Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ED6606A335
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8NG67xM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 951D010FBCF;
	Wed, 25 Nov 2026 11:48:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE26310FBCF
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:48:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A6CF4407AD;
 Wed, 25 Nov 2026 11:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6201F000C0;
 Wed, 25 Nov 2026 11:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795607286;
 bh=gVP5w9lbZ4Yott2V+qkoRUdwMw4fna9KQh87NAvEQ6A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g8NG67xMAFJIyYRoFKVq4/x94fkNRLFRrwk2iz1vkcwvpa63dFTSIQf08cmdd15Rz
 Cx4Y9BnQS4rd+TGMDFwLCoFMeFuwWrm2nDcGPTxTKmvi0S37nK5XolI2AaexNlSyO5
 xzdmq95oo6aeJ6ZxnNQDd/QwE/DkJphKX+/q+6Di1GAEPZDSX3/RX6YgBuqy1TUyaL
 cUtpzagxTW38R2Zsy+Imue6e3uCULjdfOtRJDiysbztHBauNCshR6N9zA/jq5Pp5O4
 2ylVgLSszPnDYzRC7Gn1sBx3xEaziUHaAmTW46JyFWxBGlQRrABDDNOyumB+t0KFdC
 aEW9ZzYetdO3A==
Message-ID: <sashiko-outbox-233284@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 19/20] drm/bridge: analogix_dp: Handle HPD
 notification from downstream bridge
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261125112141.1434903-20-damon.ding@rock-chips.com>
References: <20261125112141.1434903-1-damon.ding@rock-chips.com>
 <20261125112141.1434903-20-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 11:48:05 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/bridge: analogix_dp: redundant AUX probes in detect and
  analogix_dp_bridge_notify()
- [Medium] drm/bridge: analogix_dp: bypassed HPD check and static poll
  in analogix_dp_get_plug_in_status()
- [Medium] drm/bridge: analogix_dp: unsynchronized concurrent updates to
  dp->connection_notified
- [Medium] drm/bridge: analogix_dp: late hpd_notify_mode init leaves HPD
  IRQ enabled on suspend
--

commit 2e833b8add367c84281267efb779f7ba405e5a0d
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Handle HPD notification from downstream bridge

This commit adds an hpd_notify_mode for pipelines where a downstream bridge
provides HPD notifications without detection, muting native HPD interrupts
and probing the sink over AUX to cache and report connection status.

Link: https://lore.kernel.org/all/5609825.iZASKD2KPV@diego/

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 7ab183f72eb63..49d0eba74e7f0 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -48,7 +48,7 @@ static const bool verify_fast_training;
>   */
>  static bool analogix_dp_supports_hpd(struct analogix_dp_device *dp)
>  {
> -	if (dp->force_connected_mode || dp->force_hpd)
> +	if (dp->force_connected_mode || dp->force_hpd || dp->hpd_notify_mode)
>  		return false;
> =20
>  	if (dp->hpd_gpiod)
> @@ -86,10 +86,29 @@ static void analogix_dp_init_dp(struct analogix_dp_de=
vice *dp)
>  	analogix_dp_init_aux(dp);
>  }
> =20
> +static bool analogix_dp_probe_sink(struct analogix_dp_device *dp)
> +{
> +	u8 dpcd_rev =3D 0;
> +	int ret;
> +
> +	ret =3D pm_runtime_resume_and_get(dp->dev);
> +	if (ret)
> +		return false;
> +
> +	ret =3D drm_dp_dpcd_readb(&dp->aux, DP_DPCD_REV, &dpcd_rev);
> +
> +	pm_runtime_put_autosuspend(dp->dev);
> +
> +	return ret =3D=3D 1 && dpcd_rev !=3D 0;
> +}
> +
>  static int analogix_dp_detect_hpd(struct analogix_dp_device *dp)
>  {
>  	int timeout_loop =3D 0;
> =20
> +	if (dp->hpd_notify_mode)
> +		return 0;
> +
>  	while (timeout_loop < DP_TIMEOUT_LOOP_COUNT) {
>  		if (analogix_dp_get_plug_in_status(dp) =3D=3D 0)
>  			return 0;
> @@ -940,6 +959,13 @@ analogix_dp_bridge_detect(struct drm_bridge *bridge,=
 struct drm_connector *conne
>  	struct analogix_dp_device *dp =3D to_dp(bridge);
>  	enum drm_connector_status status =3D connector_status_disconnected;
> =20
> +	if (dp->hpd_notify_mode) {
> +		dp->connection_notified =3D analogix_dp_probe_sink(dp);
> +
> +		return dp->connection_notified ? connector_status_connected :
> +						 connector_status_disconnected;
> +	}
> +
>  	if (dp->force_connected_mode)
>  		return connector_status_connected;

[Severity: Medium]
Can concurrent calls to analogix_dp_bridge_detect() and
analogix_dp_bridge_notify() race when updating dp->connection_notified?

drm_dp_dpcd_readb() only holds dp->aux.hw_mutex across the AUX transaction
inside analogix_dp_probe_sink(), and drm_bridge_connector_handle_hpd()
calls drm_bridge_connector_hpd_notify() without holding
dev->mode_config.connection_mutex:

CPU0                                  CPU1
analogix_dp_bridge_detect()
  analogix_dp_probe_sink()
    drm_dp_dpcd_readb() -> true
                                      drm_bridge_connector_handle_hpd()
                                        ...
                                        analogix_dp_bridge_notify()
                                          analogix_dp_probe_sink()
                                            drm_dp_dpcd_readb() -> false
                                          dp->connection_notified =3D false
  dp->connection_notified =3D true  <-- overwrites newer result

In the reverse interleaving, analogix_dp_bridge_notify() can also overwrite
dp->connection_notified between the store and the load in
analogix_dp_bridge_detect().

[ ... ]

> @@ -1000,6 +1041,7 @@ static int analogix_dp_bridge_attach(struct drm_bri=
dge *bridge,
>  		 * accurate hotplug state.
>  		 */
>  		dp->force_connected_mode =3D analogix_dp_bridge_force_connected(dp);
> +		dp->hpd_notify_mode =3D analogix_dp_has_downstream_hpd(dp);
>  	}
> =20
>  	return 0;

[Severity: Medium]
What happens if the device runtime-resumes for an AUX transfer before
analogix_dp_bridge_attach() sets dp->hpd_notify_mode?

analogix_dp_probe() enables runtime PM, analogix_dp_finish_probe() calls
devm_of_dp_aux_populate_bus(), and analogix_dp_bind() calls
drm_dp_aux_register() before drm_bridge_attach().  On RK3576_EDP and
RK3588_EDP, a runtime resume during that window runs with
dp->hpd_notify_mode still false, so analogix_dp_resume() unmutes native HPD
interrupts, enables dp->irq, and sets dp->hpd_irq_enabled =3D true:

drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:analogix_dp_resume() {
	...
	if (analogix_dp_require_pm_for_hpd_irq(dp) && !dp->hpd_irq_enabled) {
		enable_irq(dp->irq);
		dp->hpd_irq_enabled =3D true;
	}
}

Once analogix_dp_bridge_attach() sets dp->hpd_notify_mode =3D true,
analogix_dp_supports_hpd() and analogix_dp_require_pm_for_hpd_irq() return
false.  When the device later suspends, analogix_dp_suspend() skips
disable_irq(dp->irq) even though dp->hpd_irq_enabled is true, leaving
dp->irq enabled with native HPD interrupts unmuted while the PHY and clock
are powered off.

> @@ -1296,6 +1338,17 @@ static void analogix_dp_bridge_atomic_post_disable=
(struct drm_bridge *bridge,
>  		DRM_ERROR("Failed to enable psr (%d)\n", ret);
>  }
> =20
> +static void analogix_dp_bridge_notify(struct drm_bridge *bridge, struct =
drm_connector *connector,
> +				      enum drm_connector_status status)
> +{
> +	struct analogix_dp_device *dp =3D to_dp(bridge);
> +
> +	if (!dp->hpd_notify_mode)
> +		return;
> +
> +	dp->connection_notified =3D analogix_dp_probe_sink(dp);
> +}

[Severity: High]
Does probing the sink in both analogix_dp_bridge_detect() and
analogix_dp_bridge_notify() cause redundant AUX transfers and multi-second
timeout storms on unplug?

In drm_bridge_connector_detect_ctx(), calling detect->funcs->detect() is
immediately followed by drm_bridge_connector_hpd_notify():

drivers/gpu/drm/display/drm_bridge_connector.c:drm_bridge_connector_detect_=
ctx() {
	if (detect) {
		status =3D detect->funcs->detect(detect, connector);
		...
		drm_bridge_connector_hpd_notify(connector, status);
	}
}

Because analogix_dp_bridge_detect() always probes the sink instead of using
dp->connection_notified, every detect call runs analogix_dp_probe_sink()
twice back-to-back.  On an unplug notification,
drm_bridge_connector_handle_hpd() also calls analogix_dp_bridge_notify()
with connector_status_disconnected (which is ignored) before triggering
hotplug detection, running three full AUX probes in a row.  When no sink is
connected, each analogix_dp_probe_sink() call retries 32 times in
drm_dp_dpcd_access(), and each attempt in analogix_dp_transfer() waits up
to 20 ms for RPLY_RECEIV, logs a dev_err timeout message, and resets the
AUX channel.

[ ... ]

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/=
gpu/drm/bridge/analogix/analogix_dp_reg.c
> index af5e5a8ec88d6..125f4fecbaa28 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
[ ... ]
> @@ -533,16 +533,15 @@ int analogix_dp_get_plug_in_status(struct analogix_=
dp_device *dp)
>  {
>  	u32 reg;
> =20
> -	if (dp->hpd_gpiod) {
> -		if (gpiod_get_value(dp->hpd_gpiod))
> -			return 0;
> -	} else {
> -		reg =3D readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
> -		if (reg & HPD_STATUS)
> -			return 0;
> -	}
> +	if (dp->hpd_gpiod)
> +		return gpiod_get_value(dp->hpd_gpiod) ? 0 : -EINVAL;
> +
> +	if (dp->hpd_notify_mode)
> +		return dp->connection_notified ? 0 : -EINVAL;
> +
> +	reg =3D readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
> =20
> -	return -EINVAL;
> +	return (reg & HPD_STATUS) ? 0 : -EINVAL;
>  }

[Severity: Medium]
Is this dp->connection_notified check in analogix_dp_get_plug_in_status()
bypassed by analogix_dp_detect_hpd(), while leaving
analogix_dpaux_wait_hpd_asserted() polling a static variable?

Because analogix_dp_detect_hpd() returns 0 at the top when
dp->hpd_notify_mode is true, it never calls
analogix_dp_get_plug_in_status().  Callers such as analogix_dp_set_bridge()
and analogix_dpaux_transfer() will therefore treat HPD as asserted and
proceed into link training or AUX transfers even when
dp->connection_notified is false.

Meanwhile, the only remaining caller of analogix_dp_get_plug_in_status() in
hpd_notify_mode is analogix_dpaux_wait_hpd_asserted(), which polls
analogix_dp_get_plug_in_status() with readx_poll_timeout().  Since nothing
updates dp->connection_notified during that loop, it just spins until
wait_us expires whenever dp->connection_notified is false on entry.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125112141.1434=
903-1-damon.ding@rock-chips.com?part=3D19
