Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6E0C4452B
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 01:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF47C10EBFF;
	Wed, 22 Jul 2026 01:19:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W1grFIi3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A647C10EBFF
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 01:18:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 074A2600FC;
 Wed, 22 Jul 2026 01:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A721F000E9;
 Wed, 22 Jul 2026 01:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784683138;
 bh=2vRfP9UeR9Jr4jJ33OyjU35nTYpgRjo0qoi2mDx1KZY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W1grFIi3NZEaNyXUGPEkmaE1337e+Q3KWf11GCiKiRZfKflUy+o9jurggBkTC5719
 dL9yK9T+EPG1KrZfjnhh63iLv8R8H5uzBDyHryGde8TliXK6P83Wfi6qb16P2Sdpuj
 oDooj1SSTrCliMrScbm4/2jUpIFnox6MvXm2Syzh6+mKsQVU2guurwLtPAj3qHkjOl
 Pmm+B3qK53Y+dg93sE0weMAb8AtvY9vb20sewtkQ+XTiWX4QfD9JCPhxz/q/58twB4
 VUNWMJFnBBNv8cTv3BvEqhOqZv65nbhsDH+y0eoZI1RSJ3UCLBuORsnLQdLmhXqi6l
 zboTy28HpeXvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] drm/bridge: it6505: quiesce event sources and
 work on remove()
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <a56e30751b6660c5a7e1c4cb1d8e50581a4847dd.1784681487.git.daniel@makrotopia.org>
References: <cover.1784681487.git.daniel@makrotopia.org>
 <a56e30751b6660c5a7e1c4cb1d8e50581a4847dd.1784681487.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 01:18:58 +0000
Message-Id: <20260722011858.92A721F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] TOCTOU race in it6505_remove_notifier_module() can trigger a dev=
res WARN_ON.

Pre-existing issues:
- [High] State mismatch causing permanently disabled IRQs when regulator_di=
sable() fails in it6505_poweroff().
--

--- Patch [1]: [PATCH v4 1/5] drm/bridge: it6505: quiesce event sources and=
 work on remove() ---
commit edc834b1a3770ae6b495236b92078500aa7563c6
Author: Daniel Golle <daniel@makrotopia.org>
Subject: drm/bridge: it6505: quiesce event sources and work on remove()

This patch tears down the bridge and cancels background work in the correct
order during remove(). It unregisters the extcon notifier and disables
interrupts before cancelling work items to prevent them from requeuing.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index 8ecb43611dba8..7873ae6df3aff 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
[ ... ]
> @@ -2951,13 +2951,14 @@ static int it6505_use_notifier_module(struct it65=
05 *it6505)
> =20
>  static void it6505_remove_notifier_module(struct it6505 *it6505)
>  {
> -	if (it6505->extcon) {
> -		devm_extcon_unregister_notifier(it6505->dev,
> -						it6505->extcon,	EXTCON_DISP_DP,
> -						&it6505->event_nb);
> +	if (!it6505->extcon || !it6505->event_nb.notifier_call)
> +		return;
> =20
> -		flush_work(&it6505->extcon_wq);
> -	}
> +	devm_extcon_unregister_notifier(it6505->dev, it6505->extcon,
> +					EXTCON_DISP_DP, &it6505->event_nb);
> +	it6505->event_nb.notifier_call =3D NULL;

[Severity: Medium]
Could this introduce a time-of-check to time-of-use (TOCTOU) race condition?

The commit message mentions making this function idempotent so it can be ca=
lled
from both .detach() and remove(). However, the check of
it6505->event_nb.notifier_call and its subsequent modification don't appear=
 to
be synchronized.

If .detach() and remove() run concurrently, could both threads pass the che=
ck
simultaneously and call devm_extcon_unregister_notifier(), triggering a WAR=
N_ON
in devres_release() due to a double-free attempt?

> +
> +	flush_work(&it6505->extcon_wq);
>  }
> =20
[ ... ]
> @@ -3647,6 +3649,12 @@ static void it6505_i2c_remove(struct i2c_client *c=
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

[Severity: High]
This isn't a bug introduced by this patch, but could this power off sequence
lead to permanently disabled IRQs?

Looking at it6505_poweroff(), if regulator_disable() fails:

drivers/gpu/drm/bridge/ite-it6505.c:it6505_poweroff() {
    ...
    disable_irq_nosync(it6505->irq);
    ...
    if (pdata->pwr18) {
        err =3D regulator_disable(pdata->pwr18);
        if (err)
            return err;
    }
    ...
    it6505->powered =3D false;
}

The early return would leave it6505->powered =3D=3D true despite the IRQ be=
ing
disabled.

When the device is powered back on, it6505_poweron() checks the state:

drivers/gpu/drm/bridge/ite-it6505.c:it6505_poweron() {
    if (it6505->powered) {
        DRM_DEV_DEBUG_DRIVER(dev, "it6505 already powered on");
        return 0;
    }
    ...
    enable_irq(it6505->irq);
    ...
}

Would this early return skip enable_irq(), leaving the IRQ permanently disa=
bled
and the hardware deaf to hotplug and link training interrupts?

>  	it6505_remove_edid(it6505);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784681487.gi=
t.daniel@makrotopia.org?part=3D1
