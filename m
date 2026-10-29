Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C62606A323
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pji5Yhzf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50A91112062;
	Thu, 29 Oct 2026 08:07:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7747A112086
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:07:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3DFF243C94
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE241F01828;
 Thu, 29 Oct 2026 08:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793261271;
 bh=rS0L4sCU2pbH0YIVX5PyiYvrPKF/OJKkbukWQGMKIJU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Pji5YhzfYd/zV4c840cIEudE1sy4zqTNL8H/t93wWZBiYau0hOOuRA2jyfDW9M30q
 zgDXPPTjlxVXXrKeVfecC57iNnYzVqUI9FtHmcMvUCjvDlafVRNAJMwQleHO3s5YwX
 LsmeaslegM2hUw4hiUrGvzScXgl6Lqg38ezW1wfbJ5vZ+UBvCJsVSXfDAM43URMip0
 V1sAjjf1htXC/1cCOL8A0YIDYt2JKlpeJ1SPr7H6r2LyxUiuO1c+PfmaCkFOu3c+QG
 NKDRbRCevdkVD1CFy2009eGyweDQKFsNWsukY27RxsGvIOFWYMbSxVCKuY32ik61IY
 UKRjo8uODbgNQ==
Message-ID: <sashiko-outbox-188949@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 22/34] drm/atomic-state-helper: Provide
 atomic_compare_state helpers
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-drm-state-readout-v7-22-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
 <20261029-drm-state-readout-v7-22-25e5163d75c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 08:07:50 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] drm/atomic: drm_atomic_helper_connector_compare_state() checks i=
nactive/request state
- [Medium] drm/atomic: unconditional infoframe data check in connector stat=
e compare
- [Medium] drm/atomic-state-helper: plane state compare checks transient da=
mage fields
- [Medium] drm/atomic-state-helper: false enable mismatch on DPMS OFF in dr=
m_atomic_helper_crtc_compare_state()
--

commit 0c2a50c5386965dc9fab1a71259f23b6b087098f
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic-state-helper: Provide atomic_compare_state helpers

This commit adds default atomic_sro_compare_state helper functions for
planes, CRTCs, connectors, and bridges to compare committed software states
against states read back from hardware.

> diff --git a/drivers/gpu/drm/drm_atomic_state_readout_helper.c b/drivers/=
gpu/drm/drm_atomic_state_readout_helper.c
> index 33f0f78c9b265..c4089afbc946e 100644
> --- a/drivers/gpu/drm/drm_atomic_state_readout_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_readout_helper.c

[ ... ]

> @@ -680,6 +681,268 @@ int drm_atomic_helper_sro_readout_state(struct drm_=
device *dev)
> +bool drm_atomic_helper_plane_compare_state(struct drm_plane *plane,
> +					   struct drm_printer *p,
> +					   struct drm_plane_state *expected,
> +					   struct drm_plane_state *actual)
> +{

[ ... ]

> +	STATE_CHECK_U32(ret, p, plane->name, expected, actual, color_encoding);
> +	STATE_CHECK_U32(ret, p, plane->name, expected, actual, color_range);
> +
> +	STATE_CHECK_PROPERTY_BLOB(ret, p, plane->name, expected, actual, fb_dam=
age_clips);
> +	STATE_CHECK_BOOL(ret, p, plane->name, expected, actual, ignore_damage_c=
lips);

[Severity: Medium]
Should fb_damage_clips and ignore_damage_clips be excluded from
drm_atomic_helper_plane_compare_state()?

In struct drm_plane_state, fb_damage_clips is a transient per-commit blob
describing damaged rectangles relative to the previous frame, which
__drm_atomic_helper_plane_duplicate_state() explicitly resets on duplicatio=
n:

drivers/gpu/drm/drm_atomic_state_helper.c:__drm_atomic_helper_plane_duplica=
te_state() {
	...
	state->fence =3D NULL;
	state->commit =3D NULL;
	state->fb_damage_clips =3D NULL;
	state->color_mgmt_changed =3D false;
	...
}

Similarly, ignore_damage_clips is an internal software flag used by
drm_atomic_helper_damage_iter_init(). Neither field is stored in display
hardware registers, so the readout state allocated via atomic_create_state()
and populated by atomic_sro_readout_state() in
drm_atomic_sro_readout_and_compare() will always have actual->fb_damage_cli=
ps
set to NULL and actual->ignore_damage_clips set to false.

When a blocking atomic commit includes FB_DAMAGE_CLIPS (or comes through
drm_atomic_helper_dirtyfb()) or a driver sets ignore_damage_clips, won't
commit_tail() -> drm_atomic_sro_readout_and_compare() ->
drm_atomic_helper_plane_compare_state() report false state mismatches on
these two fields?

> +	STATE_CHECK_PTR(ret, p, plane->name, expected, actual, color_pipeline);

[ ... ]

> +bool drm_atomic_helper_crtc_compare_state(struct drm_crtc *crtc,
> +					  struct drm_printer *p,
> +					  struct drm_crtc_state *expected,
> +					  struct drm_crtc_state *actual)
> +{
> +	bool ret =3D true;
> +
> +	STATE_CHECK_PTR(ret, p, crtc->name, expected, actual, crtc);
> +	STATE_CHECK_BOOL(ret, p, crtc->name, expected, actual, enable);
> +	STATE_CHECK_BOOL(ret, p, crtc->name, expected, actual, active);
> +
> +	/* Both inactive, mode and properties are meaningless. */
> +	if (!expected->active && !actual->active)
> +		return ret;

[Severity: Medium]
Won't checking enable before the !expected->active && !actual->active early
return trigger a false mismatch when a CRTC is in DPMS off?

When userspace blanks a display via DPMS off
(drm_atomic_connector_commit_dpms() or an atomic commit setting ACTIVE=3D0
while keeping MODE_ID set), the committed state has expected->enable =3D tr=
ue
and expected->active =3D false, while drm_atomic_helper_commit_crtc_disable=
()
powers down the CRTC hardware.

When commit_tail() -> drm_atomic_sro_readout_and_compare() reads back the
hardware state (for example via tidss_crtc_readout_state()), the hardware
CRTC is disabled so readout leaves both actual->enable =3D false and
actual->active =3D false.

Because STATE_CHECK_BOOL(ret, p, crtc->name, expected, actual, enable) runs
before the inactive check returns ret, ret is set to false and a mismatch is
logged even though both states are inactive. Should enable only be compared
after verifying that the CRTC is active?

> +
> +	/* One active and the other inactive, that's a mismatch. */
> +	if (!expected->active || !actual->active)
> +		return false;

[ ... ]

> +bool drm_atomic_helper_connector_compare_state(struct drm_connector *con=
n,
> +					       struct drm_printer *p,
> +					       struct drm_connector_state *expected,
> +					       struct drm_connector_state *actual)
> +{
> +	bool ret =3D true;
> +
> +	STATE_CHECK_PTR(ret, p, conn->name, expected, actual, connector);
> +	STATE_CHECK_PTR(ret, p, conn->name, expected, actual, crtc);
> +	STATE_CHECK_PTR(ret, p, conn->name, expected, actual, best_encoder);
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, link_status);
> +
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, tv.select_subconn=
ector);
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, tv.subconnector);
> +
> +	STATE_CHECK_BOOL(ret, p, conn->name, expected, actual, self_refresh_awa=
re);
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, picture_aspect_ra=
tio);
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, content_type);
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, hdcp_content_type=
);
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, scaling_mode);
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, content_protectio=
n);
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, colorspace);
> +
> +	/*
> +	 * NOTE: We can't check max_bpc, max_requested_bpc and
> +	 * color_format because they are userspace requests negotiated
> +	 * during atomic_check into output_bpc and output_format. The
> +	 * hardware only stores the negotiated result.
> +	 */
> +
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, privacy_screen_sw=
_state);
> +	STATE_CHECK_PROPERTY_BLOB(ret, p, conn->name, expected, actual, hdr_out=
put_metadata);
> +
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, hdmi.broadcast_rg=
b);

[Severity: Medium]
There appear to be two issues with how connector and HDMI state fields are
checked in drm_atomic_helper_connector_compare_state():

First, unlike drm_atomic_helper_plane_compare_state() (which returns early
when !expected->fb && !actual->fb) and drm_atomic_helper_crtc_compare_state=
()
(which returns early when !expected->active && !actual->active),
drm_atomic_helper_connector_compare_state() continues comparing all connect=
or
and hdmi.* fields even when the connector is disabled (!expected->crtc &&
!actual->crtc). When a commit disables a previously active connector,
__drm_atomic_helper_connector_duplicate_state() copies the old state via
memcpy(), and drm_atomic_helper_connector_hdmi_check() returns early without
clearing the old hdmi.* fields:

drivers/gpu/drm/display/drm_hdmi_state_helper.c:drm_atomic_helper_connector=
_hdmi_check() {
	...
	if (!new_conn_state->crtc || !new_conn_state->best_encoder)
		return 0;

	ret =3D hdmi_compute_config(connector, new_conn_state, mode);
	if (ret)
		return ret;

	new_conn_state->hdmi.is_limited_range =3D hdmi_is_limited_range(connector,=
 new_conn_state);
	...
}

Meanwhile, hardware readout creates a pristine default state via
atomic_create_state() and leaves it untouched when the connector is
disconnected from a CRTC (for example in sii902x_bridge_connector_readout()=
),
causing false mismatches on retained fields like hdmi.output_bpc,
hdmi.output_format, hdmi.tmds_char_rate, and hdmi.infoframes.*.

Second, even when the connector is active, hdmi.broadcast_rgb is a userspace
request (like max_bpc and color_format mentioned in the comment above) that
drm_atomic_helper_connector_hdmi_check() resolves into hdmi.is_limited_range
and the AVI infoframe quantization range. Since hardware only stores the
negotiated quantization range and atomic_create_state() initializes
actual->hdmi.broadcast_rgb to DRM_HDMI_BROADCAST_RGB_AUTO, won't setting
Broadcast RGB to Full or Limited always fail comparison?

> +	STATE_CHECK_BOOL(ret, p, conn->name, expected, actual, hdmi.infoframes.=
avi.set);
> +	STATE_CHECK_INFOFRAME(ret, p, conn->name, expected, actual, hdmi.infofr=
ames.avi.data);
> +	STATE_CHECK_BOOL(ret, p, conn->name, expected, actual, hdmi.infoframes.=
hdr_drm.set);
> +	STATE_CHECK_INFOFRAME(ret, p, conn->name, expected, actual, hdmi.infofr=
ames.hdr_drm.data);
> +	STATE_CHECK_BOOL(ret, p, conn->name, expected, actual, hdmi.infoframes.=
spd.set);
> +	STATE_CHECK_INFOFRAME(ret, p, conn->name, expected, actual, hdmi.infofr=
ames.spd.data);
> +	STATE_CHECK_BOOL(ret, p, conn->name, expected, actual, hdmi.infoframes.=
hdmi.set);
> +	STATE_CHECK_INFOFRAME(ret, p, conn->name, expected, actual, hdmi.infofr=
ames.hdmi.data);

[Severity: Medium]
Should STATE_CHECK_INFOFRAME() only be called when the corresponding
infoframe's set field is true in both expected and actual?

When a connector state is duplicated via
__drm_atomic_helper_connector_duplicate_state(), the previous
hdmi.infoframes.*.data bytes are copied with memcpy(). If an infoframe that
was previously enabled (such as hdr_drm when hdr_output_metadata is removed,
or the HDMI vendor infoframe) is not generated in a subsequent commit,
helpers like hdmi_generate_hdr_infoframe() and
hdmi_generate_hdmi_vendor_infoframe() only clear infoframe->set without
zeroing infoframe->data:

drivers/gpu/drm/display/drm_hdmi_state_helper.c:hdmi_generate_hdr_infoframe=
() {
	...
	infoframe->set =3D false;

	if (!connector->hdmi.funcs->hdr_drm.write_infoframe)
		return 0;

	if (connector->max_bpc < 10)
		return 0;

	if (!conn_state->hdr_output_metadata)
		return 0;
	...
}

In drm_atomic_sro_readout_and_compare(), the readout state is freshly
zero-allocated via atomic_create_state(), so actual->hdmi.infoframes.*.data
is all zeros when set is false, whereas expected->hdmi.infoframes.*.data
still holds stale bytes from the earlier commit. Comparing data with memcmp=
()
when set is false will report a mismatch even though the infoframe is
disabled in both states.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-drm-state-=
readout-v7-0-25e5163d75c3@kernel.org?part=3D22
