Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F30C4453E
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 16:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9314810E4A5;
	Wed, 22 Jul 2026 16:22:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JCSAm4hB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EB1810E4A5
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 16:22:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BD7A4600AB;
 Wed, 22 Jul 2026 16:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E141F00A3A;
 Wed, 22 Jul 2026 16:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784737352;
 bh=iMFk1aaWGGVoj8fAZpSXeah11KlsqhRKW/dk+/xD3Dk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JCSAm4hBcrJekVgTJpcbanh02oSPpVSJAxCzCmlHAQNwYFXf2StbrxV8ZNc0uNsqw
 46bCfac6MsH03bRfGvA4+TUUQ0svkbB8JsBd1vq5zHdcHy6nJcUK9A8jUdkadmESX/
 PThqfRekF0uhmh3T8UbLTanb7SHKliJIIFQ+B9BZpchazkL3kU8VjBf3CXnBrzA1xv
 AGiQ2A9xvx5/kh3V6cL+SbthtpiEjdgHeTa5XJBckHNhawTt8aEP/djiawgpbCB7Tb
 rnjDXGojaivkDtNFx3xKqmBwktgmmsZUzqrEBZVgOWBik8tX+ILpEnuMB0CQ+QGang
 Q/W/ikFlVqmHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/11] drm/bridge: it6505: quiesce event sources and
 work on remove()
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <837efb37cc967fc0bb4371d1051dd33838425d2d.1784717129.git.daniel@makrotopia.org>
References: <cover.1784717129.git.daniel@makrotopia.org>
 <837efb37cc967fc0bb4371d1051dd33838425d2d.1784717129.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 16:22:31 +0000
Message-Id: <20260722162232.52E141F00A3A@smtp.kernel.org>
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
- [High] Setting `notifier_call` to NULL during unregistration causes a NUL=
L pointer dereference in concurrent extcon notifier traversals.

Pre-existing issues:
- [High] The extcon notifier callback can queue `extcon_wq` after the work =
has been cancelled, leading to a Use-After-Free of the `it6505` structure.
--

--- Patch [1]: [PATCH v5 01/11] drm/bridge: it6505: quiesce event sources a=
nd work on remove() ---
commit ea23622a6daa324ec330db52ae5d71446a7f3ab2
Author: Daniel Golle <daniel@makrotopia.org>

drm/bridge: it6505: quiesce event sources and work on remove()

The patch attempts to fix use-after-free issues during device removal by
unregistering the extcon notifier, disabling IRQs, and cancelling work items
before the devres cleanup frees the it6505 structure. It also initializes t=
he
extcon workqueue in the probe function.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index 8ecb43611dba8..e9c84e4fb3a09 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c

[ ... ]

> @@ -2951,13 +2954,16 @@ static int it6505_use_notifier_module(struct it65=
05 *it6505)
> =20
>  static void it6505_remove_notifier_module(struct it6505 *it6505)
>  {
> -	if (it6505->extcon) {
> -		devm_extcon_unregister_notifier(it6505->dev,
> -						it6505->extcon,	EXTCON_DISP_DP,
> +	mutex_lock(&it6505->extcon_lock);
> +	if (it6505->extcon && it6505->event_nb.notifier_call) {
> +		devm_extcon_unregister_notifier(it6505->dev, it6505->extcon,
> +						EXTCON_DISP_DP,
>  						&it6505->event_nb);
> -
> -		flush_work(&it6505->extcon_wq);
> +		it6505->event_nb.notifier_call =3D NULL;

[Severity: High]
Does setting notifier_call to NULL here cause a NULL pointer dereference in
concurrent extcon notifier traversals?

Extcon uses raw notifiers, which do not provide built-in locking or RCU gra=
ce
periods during traversal. If an extcon state change triggers extcon_sync()
(which calls raw_notifier_call_chain()) concurrently with this unbind proce=
ss,
setting it6505->event_nb.notifier_call to NULL while the traversal thread is
examining this notifier block can cause a crash.

If the traversal thread fetches nb->notifier_call inside notifier_call_chai=
n()
immediately after it is set to NULL, it will attempt to execute it.

>  	}
> +	mutex_unlock(&it6505->extcon_lock);
> +
> +	flush_work(&it6505->extcon_wq);
>  }

[ ... ]

> @@ -3647,6 +3654,12 @@ static void it6505_i2c_remove(struct i2c_client *c=
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

[Severity: High]
This is a pre-existing issue, but does this fully prevent a Use-After-Free
if the extcon notifier callback is running concurrently?

In it6505_remove_notifier_module(), devm_extcon_unregister_notifier() remov=
es
the raw notifier but does not wait for concurrently executing callbacks to =
finish.
If the it6505_extcon_notifier() callback is executing or preempted on anoth=
er
CPU, it can call schedule_work(&it6505->extcon_wq) after cancel_work_sync()
returns.

When the device unbinds, devres frees the it6505 structure, which can cause
the scheduled workqueue to dereference freed memory.

>  	it6505_poweroff(it6505);
>  	it6505_remove_edid(it6505);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784717129.gi=
t.daniel@makrotopia.org?part=3D1
