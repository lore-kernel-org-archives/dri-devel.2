Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B590606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=irif24IF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F98310F563;
	Tue, 27 Oct 2026 13:53:35 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7063310F570
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:53:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 59F1443D6C;
 Tue, 27 Oct 2026 13:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A231F031E2;
 Tue, 27 Oct 2026 13:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793109209;
 bh=WkBiMDL4Bx3nqJ4tUL8vzovNFgqLW71mnZ+J+sczVAA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=irif24IFoTx10v1mQat8h0fZxid6fcxcynD/kQDmfPcsBKdvIYfdNjDs6ajgeDnUM
 HZnidLTc1YDwmULgR5CqqGGYydXm2ItYnxaywitMWFk1YcrbDcthRF38LpfxVdevjE
 9nHYFWNr/Cm5FE7jEDW3zFs0Lymover4ihwb8aG/YlnMD23Td+y400VpTF/uw1qYnX
 e9U+0QpDC1By2buXZetAV+d61Gt7XMxbPbPX0aqbPiZgY/PXfKl1WdMEvwGwaImrTK
 RhmXQAAYGjozEoU3wZIGebIdeJm+AXmyYuXPHT5p0n8hInPMXpptO4qALxjVsrDLew
 XuZZMBthcU+eA==
Message-ID: <sashiko-outbox-186671@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 17/18] drm/bridge: analogix_dp: Handle HPD
 notification from downstream bridge
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261027132810.1746118-18-damon.ding@rock-chips.com>
References: <20261027132810.1746118-1-damon.ding@rock-chips.com>
 <20261027132810.1746118-18-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 13:53:28 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/bridge: analogix_dp: invalid status in analogix_dp_bridge_de=
tect()
--

commit fec557a2a8eaddda095ccdaffc8d84d2a1bbe03a
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Handle HPD notification from downstream bridge

This commit adds an hpd_notify_mode to analogix_dp when a downstream bridge
in the chain provides HPD notifications without detection. In this mode, the
driver caches the connection state from the .hpd_notify callback, mutes and
skips initializing native HPD interrupts, and returns connector->status from
analogix_dp_bridge_detect().

Link: https://lore.kernel.org/all/5609825.iZASKD2KPV@diego/

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 44d431a89ff6f..12c6650da3a46 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c

[ ... ]

> @@ -925,6 +926,9 @@ analogix_dp_bridge_detect(struct drm_bridge *bridge, =
struct drm_connector *conne
>  	enum drm_connector_status status =3D connector_status_disconnected;
>  	int ret;
> =20
> +	if (dp->hpd_notify_mode)
> +		return connector->status;

[Severity: Medium]
Can returning connector->status directly from analogix_dp_bridge_detect()
cause regressions before the first HPD notification arrives or when connect=
or
forcing is used via sysfs?

First, drm_connector_init_only() initializes connector->status to
connector_status_unknown. In rockchip_drm_bind() and exynos_drm_bind(),
drm_kms_helper_poll_init() calls display_connector_hpd_enable(), which only
schedules conn->hpd_work asynchronously via schedule_work(&conn->hpd_work)
(and when drm_kms_helper.poll=3D0 or with bridges like aux-hpd-bridge, no
initial HPD work is scheduled). When drm_client_setup() ->
drm_client_modeset_probe() -> drm_helper_probe_single_connector_modes() (or=
 a
userspace DRM_IOCTL_MODE_GETCONNECTOR call) runs before conn->hpd_work
completes, analogix_dp_bridge_detect() returns connector_status_unknown.

In drivers/gpu/drm/drm_probe_helper.c:drm_helper_probe_single_connector_mod=
es():

	if (connector->status =3D=3D connector_status_disconnected) {
		...
		goto exit;
	}

	count =3D drm_helper_probe_get_modes(connector);

	if (count =3D=3D 0 && (connector->status =3D=3D connector_status_connected=
 ||
			   connector->status =3D=3D connector_status_unknown)) {
		count =3D drm_add_modes_noedid(connector, 1024, 768);

Because the status is connector_status_unknown instead of
connector_status_disconnected, drm_helper_probe_single_connector_modes() ad=
ds
fallback no-EDID modes and drm_client attempts to enable the disconnected
display. In analogix_dp_bridge_atomic_enable() -> analogix_dp_set_bridge(),
analogix_dp_detect_hpd() then checks analogix_dp_get_plug_in_status(), where
dp->connection_notified is still false, timing out after 5 retries (~500ms)
and logging an error.

Second, if a user forces the connector state via /sys/class/drm/.../status,
drm_helper_probe_single_connector_modes() sets connector->status to the
forced value without calling .detect_ctx() or .hpd_notify(), leaving
dp->connection_notified out of sync (so forcing "on" still fails in
analogix_dp_get_plug_in_status()). When the user later writes "detect" to
restore normal detection, status_store() clears connector->force while
connector->status still holds the forced state. Then
drm_bridge_connector_detect_ctx() runs:

	if (detect) {
		status =3D detect->funcs->detect(detect, connector);
		...
		drm_bridge_connector_hpd_notify(connector, status);
	}

Because analogix_dp_bridge_detect() returns the stale forced
connector->status, drm_bridge_connector_hpd_notify() passes that forced
status back into analogix_dp_bridge_notify(), overwriting
dp->connection_notified and leaving the connector stuck in the forced state
until a physical HPD edge occurs.

Would it be better to avoid setting DRM_BRIDGE_OP_DETECT on this bridge when
downstream HPD is used, or have analogix_dp_bridge_detect() return a valid
connected/disconnected status without letting the detect path's
drm_bridge_connector_hpd_notify() call overwrite the state from downstream
HPD notifications?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027132810.1746=
118-1-damon.ding@rock-chips.com?part=3D17
