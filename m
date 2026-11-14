Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6FB606A329
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 23:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oSEa2Lsn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E18D10E0F3;
	Sat, 14 Nov 2026 23:40:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B6D310E0F3;
 Sat, 14 Nov 2026 23:40:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9B1E143C49;
 Sat, 14 Nov 2026 23:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5477D1F000C4;
 Sat, 14 Nov 2026 23:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794699645;
 bh=9lWgaHyacwecdihG695tOYPm+ThklEG59qsmYTOmYkE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oSEa2LsnrDHzF0s2oUd90DSHGV5Gq5WRqtv43NuK1Y0qgEPuAwL19Qy9/6NyNIQ5C
 aQi23nZbRVCxdeCIxCV2bz+DX32itXDwMPHeKhThC2vPthVyUUqlOLE8ChE/8SWYQR
 QaoaQpXYE2P4P3Lsn9z924Q+bA70Gd8C1rcMFsBHwLHkFw1geXMfTnCBk6+5LrbIsv
 klAspEHybTfqnBXunWkjQR0Fi2LKNWkdsa/chDtRte6EVxncjmjKQ+IVC4wnPl/Naq
 DFKXgjnaXO67Q4e1wQ62WeNdmtJFBuxy/LAw8Fj3j+dnvA93eHoldTpzQoERCwO9PQ
 Vg2SuAYomK41g==
Message-ID: <sashiko-outbox-215118@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] drm/amd/display: Copy the preferred and highest
 refresh modes after probe
To: "Hugo Sales" <hugo@hsal.es>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261114-amdgpu-modes-four-v1-4-f11e2a6cd407@hsal.es>
References: <20261114-amdgpu-modes-four-v1-0-f11e2a6cd407@hsal.es>
 <20261114-amdgpu-modes-four-v1-4-f11e2a6cd407@hsal.es>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:40:44 +0000
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
- [High] drm/amd/display: dc_sink UAF in
  amdgpu_dm_connector_update_mode_copies()
--

commit 1f5a443bde024bb59f9710748a6f559dc056a617
Author: Hugo Sales <hugo@hsal.es>

drm/amd/display: Copy the preferred and highest refresh modes after probe

This commit adds amdgpu_dm_connector_fill_modes() to copy the preferred mod=
e,
highest refresh rate mode, and sink EDID into struct amdgpu_dm_connector
under connection_mutex after probing a connector.

Link: https://lore.kernel.org/r/auh8pUx_kXUYSdZ8@intel.com

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index e477ef61ce109..491965266b786 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c

[ ... ]

> @@ -1223,6 +1268,87 @@ bool amdgpu_dm_is_freesync_video_mode(const struct=
 drm_display_mode *mode,
>  }
>  EXPORT_IF_KUNIT(amdgpu_dm_is_freesync_video_mode);
> =20
> +STATIC_IFN_KUNIT void
> +amdgpu_dm_connector_update_mode_copies(struct amdgpu_dm_connector *aconn=
ector)
> +{
> +	struct drm_mode_config *config =3D &aconnector->base.dev->mode_config;
> +	struct list_head *modes =3D &aconnector->base.modes;
> +	const struct drm_display_mode *preferred, *highest;
> +	struct drm_display_mode native_buf;
> +	const struct dc_sink *sink;
> +
> +	lockdep_assert_held(&config->mutex);
> +
> +	drm_modeset_lock(&config->connection_mutex, NULL);
> +
> +	sink =3D aconnector->dc_sink;
> +	aconnector->mode_copies_edid_size =3D amdgpu_dm_sink_edid_size(sink);
> +	if (aconnector->mode_copies_edid_size)
> +		memcpy(aconnector->mode_copies_edid, sink->dc_edid.raw_edid,
> +		       aconnector->mode_copies_edid_size);

[Severity: High]
Can amdgpu_dm_connector_update_mode_copies() read a freed aconnector->dc_si=
nk
here?

In amdgpu_dm_connector_fill_modes(), drm_helper_probe_single_connector_mode=
s()
acquires root->mst_mgr.base.lock during MST port detection and drops it on =
its
exit path before amdgpu_dm_connector_update_mode_copies() runs. Meanwhile,
amdgpu_dm_mst_connector_early_unregister() runs from
drm_dp_delayed_destroy_work under connector->mutex and
root->mst_mgr.base.lock, without holding mode_config.mutex or
connection_mutex, and frees dc_sink before clearing aconnector->dc_sink:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c:amdgpu_dm_mst_c=
onnector_early_unregister() {
    ...
	if (dc_sink) {
		amdgpu_dm_With_dc_lock(adev,
			dc_link_remove_remote_sink(dc_link, dc_sink));
		dc_sink_release(dc_sink);
		aconnector->dc_sink =3D NULL;
    ...
}

CPU0                                  CPU1 (kworker)
amdgpu_dm_connector_fill_modes()
  drm_helper_probe_single_...()
    ...
    drm_modeset_drop_locks(&ctx)
                                      drm_dp_delayed_destroy_work()
                                        ...
                                        amdgpu_dm_mst_connector_early_unreg=
ister()
                                          lock(&root->mst_mgr.base.lock)
                                          dc_sink_release(dc_sink) -> kfree=
()
  amdgpu_dm_connector_update_mode_copies()
    sink =3D aconnector->dc_sink;
    amdgpu_dm_sink_edid_size(sink)
    memcpy(..., sink->dc_edid.raw_edid, ...)  <-- use-after-free
                                          aconnector->dc_sink =3D NULL;

dm_resume() similarly releases and clears aconnector->dc_sink on SST
connectors under aconnector->hpd_lock without mode_config.mutex or
connection_mutex. This causes a slab use-after-free read of struct dc_sink
when copying sink->dc_edid.raw_edid.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-amdgpu-mod=
es-four-v1-0-f11e2a6cd407@hsal.es?part=3D4
