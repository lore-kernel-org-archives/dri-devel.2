Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D51606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 21:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KUHAEy+8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC05310E002;
	Tue, 10 Nov 2026 21:27:29 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBBB310E002
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 21:27:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9CA8260254
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 21:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA131F0089F;
 Tue, 10 Nov 2026 21:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794346041;
 bh=72+moSR4CwGXr/jKUo6yl9Yk/rGpxTrHtwqfJai4CoM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KUHAEy+8Dv45KIOMAsZ9BZBetK4aXeRx2NjzrwLzsKRC+npoIgGaTKLboV3Cd/iMP
 ksLhaTm1KAOSHCUT7k5wmP46Yv2+bjNDdU3gP2SVz6GWnyCelV3Ie4ZPJIw8bmMswL
 y/zCOFwV4O/6GI+KPHUdsEM8NyM7cQ2cNIda25RRAfyx8g/LSkc24NIgROJ1HcANkn
 MqoKHL7oeJvBYtzUv14LkJumjoDBYzpGY9xvtOOhA6GD9q8umI0Sd598wouOsROpgr
 UXn2liWz11wxhdYYDOjuyY8H2efxUanCCNQxPLhBU9s8Cu1fFMYz3umAqcQ9juWqei
 pcg1YEAwuzjcg==
Message-ID: <sashiko-outbox-207767@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/amd/display: Route connector DDC over AUX for
 native DP sinks
To: "Mario Limonciello" <superm1@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-superm1-amdgpu-ddc-v3-1-9436b04d1e31@kernel.org>
References: <20261110-superm1-amdgpu-ddc-v3-1-9436b04d1e31@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 21:27:20 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/amd/display: stale link->aux_mode in amdgpu_dm_i2c_xfer()
  breaks DP++
--

commit 98cc22cc3e67bb7ce06a4e571268aa8a05d6952f
Author: Mario Limonciello <superm1@kernel.org>

drm/amd/display: Route connector DDC over AUX for native DP sinks

This commit routes I2C transfers on a connector's DDC adapter to the AUX
DDC adapter when link->aux_mode is set so that userspace DDC/CI transfers
reach native DisplayPort sinks.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index b498fc5fbb140..f80de9e7f850c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -3373,6 +3373,22 @@ STATIC_IFN_KUNIT int amdgpu_dm_i2c_xfer(struct i2c=
_adapter *i2c_adap,
>  	int i;
>  	int result =3D -EIO;
> =20
> +	if (!i2c->oem && ddc_service->link) {
> +		struct dc_link *link =3D ddc_service->link;
> +		struct amdgpu_dm_connector *aconnector =3D link->priv;
> +
> +		/*
> +		 * DDC to a native DisplayPort sink (SST, MST or eDP) is
> +		 * tunneled over the AUX channel; the physical i2c pins only
> +		 * reach DVI/HDMI sinks (e.g. DP++ with a passive adapter).
> +		 * Use the same aux_mode selection as the EDID read helpers so
> +		 * the connector's single "ddc" bus works for either sink.
> +		 */
> +		if (aconnector && link->aux_mode &&
> +		    aconnector->dm_dp_aux.aux.ddc.algo)
> +			return i2c_transfer(&aconnector->dm_dp_aux.aux.ddc, msgs, num);
> +	}

[Severity: High]
Can checking link->aux_mode here misroute passive DP++ dongle detection
over AUX when a passive DP-to-HDMI adapter is plugged into a port that
previously had a native DP sink connected?

In detect_link_and_local_sink(), link->aux_mode is not cleared on
disconnect and is only updated after detect_dp() finishes:

drivers/gpu/drm/amd/display/dc/link/link_detection.c:detect_link_and_local_=
sink() {
	...
			if (!detect_dp(link, &sink_caps, reason)) {
	...
		set_ddc_transaction_type(link->ddc,
					 sink_caps.transaction_type);

		link->aux_mode =3D
			link_is_in_aux_transaction_mode(link->ddc);
	...
}

While dm_helpers_read_local_edid() runs after link->aux_mode is updated,
detect_dp() runs before it and calls dp_passive_dongle_detection() ->
query_dp_dual_mode_adaptor() -> i2c_read() -> dm_helpers_submit_i2c(),
which goes through i2c_transfer(&aconnector->i2c->base, ...) and
amdgpu_dm_i2c_xfer().  If a native DP monitor was previously connected,
link->aux_mode is still true during detect_dp(), so the read of
DP_HDMI_DONGLE_ADDRESS (0x40) is redirected to the AUX adapter instead of
the physical I2C pins.  Because a passive adapter has no AUX responder,
the read fails and query_dp_dual_mode_adaptor() falls back to
DISPLAY_DONGLE_DP_DVI_DONGLE (SIGNAL_TYPE_DVI_SINGLE_LINK), capping the
pixel clock to 165 MHz and disabling HDMI audio and infoframes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-superm1-am=
dgpu-ddc-v3-1-9436b04d1e31@kernel.org?part=3D1
