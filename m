Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B646606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+grVBnS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9900310FBB6;
	Wed, 25 Nov 2026 11:41:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B85A010FBBB
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:41:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7CC9040A06;
 Wed, 25 Nov 2026 11:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2101F000C6;
 Wed, 25 Nov 2026 11:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795606883;
 bh=W8qv07+5q4atSY2acBLlT72oGKqJMnHdSS2IBiMT6QE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n+grVBnSXnZrWp3Qg41JAOdFosRY2oyTuRO3hKbTJ2kyFG/A8pv7/gGSqn780iVOs
 w7suR5vbtJJBzSeNpGcfXNvqUMFSOqNLzQN6e+aE+nGyuUQfkfY7EJSrAx7fQYRSpz
 kAv16oxU/HLteOvZBUWrk19GdRVFhOOiZrdRhxYmMh41RhN+UGCGxkpJeNk6HLD9K1
 BTGNmys+W+d5cYlZZ5Orr9MMB4hIx4pzBEQuYzTyQb3YixT3DXAPq4DcR+ftTPozMV
 48DyK6TcrfxAiCHtxi8KYkKBUv370BLHcRXVQMww4STEgei0VljryRXbjOLyueFNqw
 o/9tdtBezUgKw==
Message-ID: <sashiko-outbox-233271@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 17/20] drm/bridge: analogix_dp: Manage pm runtime and
 IRQ for native HPD pin detection
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261125112141.1434903-18-damon.ding@rock-chips.com>
References: <20261125112141.1434903-1-damon.ding@rock-chips.com>
 <20261125112141.1434903-18-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 11:41:22 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/bridge: analogix_dp: premature IRQ enable in
  analogix_dp_resume()
- [Medium] drm/bridge: analogix_dp: deadlock between
  analogix_dp_suspend() and IRQ
--

commit 2148ea987a79afc2769bfb9bcea363df9810b9e9
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Manage pm runtime and IRQ for native HPD pin detec=
tion

This commit holds a runtime PM reference across bind and unbind on RK3576
and RK3588 for native hotplug detection, and gates the hotplug IRQ on
hotplug support and runtime PM transitions.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 46433ea73d678..cda6e4c5cbc8d 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -42,6 +42,33 @@
> =20
>  static const bool verify_fast_training;
> =20
> +/*
> + * The hotplug events are reported either through the optional GPIO HPD
> + * pin or through the native controller interrupt, which is confirmed
> + * to work only on the RK3576 and RK3588 platforms.
> + */
> +static bool analogix_dp_supports_hpd(struct analogix_dp_device *dp)
> +{
> +	if (dp->force_connected_mode || dp->force_hpd)
> +		return false;
> +
> +	if (dp->hpd_gpiod)
> +		return true;
> +
> +	return dp->plat_data->dev_type =3D=3D RK3576_EDP || dp->plat_data->dev_=
type =3D=3D RK3588_EDP;
> +}
> +
> +/*
> + * The native HPD interrupt relies on the controller staying powered
> + * and clocked to report the hotplug events, so a runtime PM reference
> + * is held for it.  The GPIO HPD mode needs no such reference, as it
> + * reads the GPIO level directly.
> + */
> +static bool analogix_dp_require_pm_for_hpd_irq(struct analogix_dp_device=
 *dp)
> +{
> +	return analogix_dp_supports_hpd(dp) && !dp->hpd_gpiod;
> +}
> +
>  static void analogix_dp_init_dp(struct analogix_dp_device *dp)
>  {
>  	analogix_dp_reset(dp);
> @@ -1547,6 +1574,11 @@ EXPORT_SYMBOL_GPL(analogix_dp_probe);
> =20
>  int analogix_dp_suspend(struct analogix_dp_device *dp)
>  {
> +	if (analogix_dp_require_pm_for_hpd_irq(dp) && dp->hpd_irq_enabled) {
> +		disable_irq(dp->irq);
> +		dp->hpd_irq_enabled =3D false;
> +	}
> +

[Severity: Medium]
Can calling disable_irq(dp->irq) inside the runtime_suspend callback cause =
an
ABBA deadlock with analogix_dp_irq_thread()?

If dp->dev is runtime-resumed while no persistent runtime PM reference is
held (for example, during pre-bind AUX transfers in
analogix_dp_finish_probe(), or after analogix_dp_unbind()),
analogix_dp_resume() enables dp->irq.  When the autosuspend timer later fir=
es
and an HPD interrupt arrives at the same time:

CPU0 (pm_wq)                      CPU1 (irq/analogix-dp)
------------                      ----------------------
rpm_suspend(dp->dev)
  runtime_status =3D RPM_SUSPENDING
  ...
  analogix_dp_suspend(dp)
                                  analogix_dp_irq_thread()
                                    pm_runtime_resume_and_get(dp->dev)
                                      rpm_resume(dp->dev, RPM_GET_PUT)
                                      /* waits for RPM_SUSPENDING */
    disable_irq(dp->irq)
      synchronize_irq(dp->irq)
      /* waits for IRQ thread */

 *** DEADLOCK ***

>  	phy_power_off(dp->phy);
> =20
>  	if (dp->plat_data->power_off)
> @@ -1576,6 +1608,11 @@ int analogix_dp_resume(struct analogix_dp_device *=
dp)
> =20
>  	analogix_dp_init_dp(dp);
> =20
> +	if (analogix_dp_require_pm_for_hpd_irq(dp) && !dp->hpd_irq_enabled) {
> +		enable_irq(dp->irq);
> +		dp->hpd_irq_enabled =3D true;
> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(analogix_dp_resume);

[Severity: High]
Does enabling dp->irq in analogix_dp_resume() leave the HPD IRQ permanently
enabled across runtime suspend on RK3576 and RK3588 boards with an eDP panel
on the DP AUX bus?

dp->force_connected_mode is not initialized in analogix_dp_probe(); it is s=
et
later during analogix_dp_bind() -> drm_bridge_attach() ->
analogix_dp_bridge_attach():

drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:analogix_dp_bridge_attac=
h() {
	...
	if (dp->bridge.next_bridge) {
		...
		dp->force_connected_mode =3D analogix_dp_bridge_force_connected(dp);
	}
}

Before analogix_dp_bind() runs, analogix_dp_finish_probe() populates the DP
AUX bus.  Probing the panel child runtime-resumes dp->dev while
dp->force_connected_mode is still false, so
analogix_dp_require_pm_for_hpd_irq(dp) returns true and analogix_dp_resume()
enables dp->irq.

Once analogix_dp_bridge_attach() sets dp->force_connected_mode =3D true,
analogix_dp_require_pm_for_hpd_irq(dp) becomes false.  When the 100 ms
autosuspend delay expires, analogix_dp_suspend() skips disable_irq(dp->irq)
and leaves dp->irq enabled while the PHY, power and clock are turned off.

In addition, because analogix_dp_resume() does not check whether the bridge
is bound, any runtime resume during or after analogix_dp_unbind() (such as
during drm_dp_aux_unregister(&dp->aux)) re-enables dp->irq while unbound,
allowing analogix_dp_irq_thread() to use a stale dp->drm_dev.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125112141.1434=
903-1-damon.ding@rock-chips.com?part=3D17
