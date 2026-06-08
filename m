Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDFCCD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6251E10F554;
	Mon,  8 Jun 2026 14:53:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OTcJhzF2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84FFE10F554
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:53:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 566A04374D
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246071F00893;
 Mon,  8 Jun 2026 14:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780930425;
 bh=4PUUfV0d7No9kBih3j1wSRnfMG4UaiVHJM+3P5M0pvo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OTcJhzF2OdH4ifa2jQXm9bv+eri6mz+j/lCEKjDvAjaHg8Ox3r9KJl/zToDm7eDPQ
 xzpWELVtOHQ3DG7l9QyFd1/n9AY/iAKuH8LtrTf1duomwiEs+2+dgLFgJMfYVniHqW
 X2of9dPbme9Fjc5RjJ6/spbtIl1TZ8hHlZvOqPac+8EfJkJ3TWOvgLnsN+6refAaqR
 3bEzzGR4SPLZjj2m+w6WXmPo47iHlNszL05ABtG0T9uL5CjeWXRlOlXn1sQW068Eq/
 3zl397jAHWLvV0b+xfmuP2kEeQfhM6YyKxCzvfQLt3bP9mKkkf6cY0gZrN53lIjpcz
 /3eaEBdEiknqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/78] drm/bridge: cdns-mhdp8546: Return an error
 pointer on allocation failure
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-2-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-2-0a91018bf886@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 14:53:44 +0000
Message-Id: <20260608145345.246071F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Asynchronous firmware loading callback can execute after the devic=
e is unbound, causing a Use-After-Free on the devres-allocated `mhdp` struc=
ture.
- [High] Unbalanced teardown of `hpd_work` and `devm_request_threaded_irq` =
allows a scheduled work to execute after `mhdp` is freed.
- [High] `cdns_mhdp_bridge_atomic_duplicate_state` fails to copy `current_m=
ode`, breaking link retraining and mishandling state lifecycles.
--

commit e5ec8b954cd81adb602c1048268bad60ac236f06
Author: Maxime Ripard <mripard@kernel.org>

    drm/bridge: cdns-mhdp8546: Return an error pointer on allocation failure
   =20
    The drm_bridge_funcs.atomic_reset documentation states that the hook
    must return either a valid drm_bridge_state object or an ERR_PTR().

> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/driver=
s/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index 36c07b71fe04b..46779b49545bd 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -1927,7 +1927,7 @@ cdns_mhdp_bridge_atomic_reset(struct drm_bridge *br=
idge)
> =20
>  	cdns_mhdp_state =3D kzalloc_obj(*cdns_mhdp_state);
>  	if (!cdns_mhdp_state)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
> =20
>  	__drm_atomic_helper_bridge_reset(bridge, &cdns_mhdp_state->base);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but could this asynchronous firm=
ware
callback cause a use-after-free if the device is unbound?

If the driver is unbound and cdns_mhdp_remove() executes, it only waits up =
to
100ms for the firmware load to finish:

cdns_mhdp_remove() {
    ...
	ret =3D wait_event_timeout(mhdp->fw_load_wq,
				 mhdp->hw_state =3D=3D MHDP_HW_READY,
				 timeout);
    ...
}

If this times out, remove completes and devres frees the mhdp structure. Wh=
en
the asynchronous firmware subsystem later finishes, it invokes
cdns_mhdp_fw_cb() which dereferences the freed mhdp pointer:

cdns_mhdp_fw_cb() {
	struct cdns_mhdp_device *mhdp =3D context;
    ...
	dev_dbg(mhdp->dev, "firmware callback\n");
    ...
}

[Severity: High]
This is a pre-existing issue, but does this teardown sequence leave a sched=
uled
work vulnerable to a use-after-free?

In cdns_mhdp_remove(), the driver calls flush_work() without explicitly
disabling the hardware interrupt:

cdns_mhdp_remove() {
    ...
	flush_work(&mhdp->hpd_work);
    ...
}

Because devm_request_threaded_irq() was used, the IRQ handler remains active
until the devres teardown phase, which occurs after remove completes. If an
interrupt fires between flush_work() and the devres IRQ teardown,
cdns_mhdp_irq_handler() will execute and schedule the work again:

cdns_mhdp_irq_handler() {
    ...
	if (bridge_attached && (sw_ev0 & CDNS_DPTX_HPD)) {
		schedule_work(&mhdp->hpd_work);
	}
    ...
}

Devres will subsequently free the IRQ and the mhdp structure, but the work
remains queued and will eventually run cdns_mhdp_hpd_work(), dereferencing
freed memory.

[Severity: High]
This isn't a bug introduced by this patch, but I noticed
cdns_mhdp_bridge_atomic_duplicate_state() doesn't seem to copy current_mode.
Will this break link retraining?

When a new state is allocated, the subclass-specific current_mode pointer is
left NULL:

cdns_mhdp_bridge_atomic_duplicate_state() {
	struct cdns_mhdp_bridge_state *state;

	state =3D kzalloc_obj(*state);
	if (!state)
		return NULL;

	__drm_atomic_helper_bridge_duplicate_state(bridge, &state->base);

	return &state->base;
}

During a non-modeset atomic commit, atomic_enable is not called, so
current_mode remains NULL in the new state. The old state is destroyed,
permanently freeing the previous current_mode. If a hotplug event subsequen=
tly
triggers a link retrain, it fetches the current state, finds current_mode is
NULL, and fails with -EINVAL, silently breaking display output:

cdns_mhdp_update_link_status() {
    ...
		current_mode =3D cdns_bridge_state->current_mode;
		if (!current_mode) {
			ret =3D -EINVAL;
			goto out;
		}
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-drm-no-mor=
e-bridge-reset-v2-0-0a91018bf886@kernel.org?part=3D2
