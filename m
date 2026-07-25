Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5898C531D0
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 03:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4E4610F4D8;
	Sat, 25 Jul 2026 03:23:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OOMjgDBC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 387DE10F4D8
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 03:23:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BB6C24125F;
 Sat, 25 Jul 2026 03:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DD61F000E9;
 Sat, 25 Jul 2026 03:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784949803;
 bh=W/9XDNXFM+3kHXRkSK47kaY2EHbh+Sm+CRqd+8zL9ZU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OOMjgDBCnUljsw3sythJCT8FnllihTNIXLTTCxQ00Jci8kky8OPiSM60lAk8y5/HX
 hz5NSa45hoxBH9MQthhHns+Hz9LVlS5miNmolOVeYDkNboi2NO6f6FvvzJA+RfGLII
 oD8H3n5TJt0/85aawrJGV9pk3+Qn4+KocyIXDFl4IDc3ArIxyHg01TiOGFo5Mk0/c8
 aJj9pUdDatIQrGASuNhRS8KUU+Eklb11gDXwAHfSXS+uBCCOhirat2Y4YYI4sHc42A
 svXkBSSMnMZsV6Jx+UgB5PBjLDwVXiOGyaCq8iG5z3waJp32YPu9AtdOR7L/fgzbH3
 XZfd8ZCzxxGDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/13] drm/bridge: it6505: quiesce event sources and
 work on remove()
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <248a9b6a19da93d75b59e9fcad0e03fe94ea67d8.1784947240.git.daniel@makrotopia.org>
References: <cover.1784947240.git.daniel@makrotopia.org>
 <248a9b6a19da93d75b59e9fcad0e03fe94ea67d8.1784947240.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 03:23:22 +0000
Message-Id: <20260725032323.74DD61F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free in `extcon_wq` due to raw notifier traversal race d=
uring driver removal.
- [High] NULL Pointer Dereference in `it6505_extcon_work` when racing with =
bridge detach.
- [Medium] Data race on `extcon_completion` state between `reinit_completio=
n` and `wait_for_completion_timeout`.
- [Medium] Missing `pm_runtime_disable()` in the I2C driver remove path.
--

--- Patch [1]: [PATCH v6 01/13] drm/bridge: it6505: quiesce event sources a=
nd work on remove() ---
commit ec8b6db3474d25da1dc993de7833610db7cf6509
Author: Daniel Golle <daniel@makrotopia.org>

drm/bridge: it6505: quiesce event sources and work on remove()

This patch attempts to prevent use-after-free and NULL pointer dereference
issues during driver removal by unregistering the extcon notifier, disabling
interrupts, and explicitly cancelling work items. It also tracks the extcon
registration state to make unregistration idempotent.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c

[ ... ]

> @@ -2951,13 +2956,16 @@ static int it6505_use_notifier_module(struct it65=
05 *it6505)
> =20
>  static void it6505_remove_notifier_module(struct it6505 *it6505)
>  {
> -	if (it6505->extcon) {
> -		devm_extcon_unregister_notifier(it6505->dev,
> -						it6505->extcon,	EXTCON_DISP_DP,
> +	mutex_lock(&it6505->extcon_lock);
> +	if (it6505->extcon && it6505->extcon_registered) {
> +		devm_extcon_unregister_notifier(it6505->dev, it6505->extcon,
> +						EXTCON_DISP_DP,
>  						&it6505->event_nb);
> -
> -		flush_work(&it6505->extcon_wq);
> +		it6505->extcon_registered =3D false;
>  	}
> +	mutex_unlock(&it6505->extcon_lock);
> +
> +	flush_work(&it6505->extcon_wq);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does unregistering the
extcon notifier fully prevent the work item from being requeued?

Because devm_extcon_unregister_notifier() unlinks the notifier from a raw
notifier chain, it cannot synchronize against a concurrent traversal.

If a traversal thread has already read the node but not yet invoked the
callback, it can execute after this flush_work() completes:

it6505_extcon_notifier()
    schedule_work(&it6505->extcon_wq);

If it6505_i2c_remove() then cancels the work and devres frees the it6505
struct, the preempted traversal thread could resume and requeue the work.
Is there a way this could result in a use-after-free on the freed memory?

[Severity: High]
This is a pre-existing issue, but could this same raw notifier race also
lead to a NULL pointer dereference if it races with bridge detach?

During drm_bridge_detach(), the core sets bridge->dev =3D NULL. If the
delayed traversal requeues it6505_extcon_work() as described above,
the requeued work will eventually execute:

it6505_extcon_work()
    drm_helper_hpd_irq_event(it6505->bridge.dev);

Will this dereference a NULL pointer since bridge->dev was already cleared?

[ ... ]

> @@ -3615,6 +3623,7 @@ static int it6505_i2c_probe(struct i2c_client *clie=
nt)
>  	INIT_WORK(&it6505->link_works, it6505_link_training_work);
>  	INIT_WORK(&it6505->hdcp_wait_ksv_list, it6505_hdcp_wait_ksv_list);
>  	INIT_DELAYED_WORK(&it6505->hdcp_work, it6505_hdcp_work);
> +	INIT_WORK(&it6505->extcon_wq, it6505_extcon_work);
>  	init_completion(&it6505->extcon_completion);

[Severity: Medium]
This is a pre-existing issue, but is it safe to use reinit_completion()
in it6505_extcon_work() without synchronization?

The it6505_irq_hpd() handler actively waits on this completion:

it6505_irq_hpd()
    wait_for_completion_timeout(&it6505->extcon_completion, ...)

If an extcon event occurs concurrently, it6505_extcon_work() calls
reinit_completion() directly on it6505->extcon_completion, which resets
the completion state without acquiring the internal wait.lock.

Can this corrupt the completion state or cause the waiter to time out
incorrectly?

>  	memset(it6505->dpcd, 0, sizeof(it6505->dpcd));
>  	it6505->powered =3D false;
> @@ -3647,6 +3656,12 @@ static void it6505_i2c_remove(struct i2c_client *c=
lient)
>  	drm_bridge_remove(&it6505->bridge);
>  	drm_dp_aux_unregister(&it6505->aux);
>  	it6505_debugfs_remove(it6505);
> +	it6505_remove_notifier_module(it6505);
> +	disable_irq(it6505->irq);
> +	cancel_work_sync(&it6505->link_works);
> +	cancel_work_sync(&it6505->hdcp_wait_ksv_list);
> +	cancel_delayed_work_sync(&it6505->hdcp_work);
> +	cancel_work_sync(&it6505->extcon_wq);
>  	it6505_poweroff(it6505);
>  	it6505_remove_edid(it6505);
>  }

[Severity: Medium]
This is a pre-existing issue, but is the remove path missing a call to
pm_runtime_disable()?

The it6505_i2c_probe() function explicitly calls pm_runtime_enable(),
but there doesn't appear to be a corresponding disable in this
it6505_i2c_remove() function.

Does leaving PM runtime enabled after driver unbind leave the device in an
incorrect state or cause reference count leaks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784947240.gi=
t.daniel@makrotopia.org?part=3D1
