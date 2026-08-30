Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E186C624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 558C610E67C;
	Mon, 31 Aug 2026 07:00:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="R1HWHZks";
	dkim-atps=neutral
X-Greylist: delayed 38750 seconds by postgrey-1.36 at gabe;
 Sun, 30 Aug 2026 14:37:56 UTC
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch
 [109.224.244.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17B0F10E1CA
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 14:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=dj5zc2jsabefxinbmqowpxz3am.protonmail; t=1788100673; x=1788359873;
 bh=uD7bEy198wazO8so3kuvubQm6J+YiztYDjZz5CAEask=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=R1HWHZksTUVgLL6AQaCrLsm4sxwnXoOfaQuKS3bUu6PhK+mfNO6ihR/nyNjKBO7wZ
 XWuNQthMbpx/U2PP7KlskeJudwXiautL7RXOMKDE7VBuHkaTgFdtL4sSO4wC0Nvabg
 pqsilHJxbNQVP+Q4TE3YCzgzsHIQZt0HOIocDpjEW4XfBCVwf7RUODBEBeoz9uDiEO
 Y6AV9oGF9VSycHj1PvtXGFnOKuAZ0IcC07d/C3oGQX+SZroc01OePCD+bfwpEm5y5p
 SyicD31Px52LSAijo/7ZFmvZWMgy7g4+BJl1ZTAXX8kyV4IL9PBP6CMm7aW1ftOOfc
 f1AiKiMkEqWCw==
Date: Sun, 30 Aug 2026 14:37:48 +0000
To: sashiko-reviews@lists.linux.dev
From: edu042sjroy@proton.me
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm/amd/display: Honor Broadcast RGB for BT.2020 RGB
 output
Message-ID: <74PFQWiLP0PGzuj56HLz5wuHCWiYESIW4YXl5g-Y4dR4KHF-hU_DA6UswCrh5nm9K0QkNndBDtohMpIACMw46ECpp-wwfilyWHBW30D3gCU=@proton.me>
In-Reply-To: <20260830040634.3E9B01F000E9@smtp.kernel.org>
References: <20260830035120.937992-1-edu042sjroy@proton.me>
 <20260830035120.937992-3-edu042sjroy@proton.me>
 <20260830040634.3E9B01F000E9@smtp.kernel.org>
Feedback-ID: 147615787:user:proton
X-Pm-Message-ID: 4eef056e15719330ba62fc2df2760a74f4b38456
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:00:03 +0000
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thanks for the review.

The first NULL-pointer path does not appear reachable. When a connector is =
attached to a CRTC, drm_atomic_get_connector_state() also adds that CRTC's =
state to the atomic commit. amdgpu_dm_atomic_check() additionally calls drm=
_atomic_get_crtc_state() for every changed connector with a CRTC. Consequen=
tly, drm_atomic_get_new_crtc_state() should be non-NULL here. For an unatta=
ched connector, acrtc is NULL and the condition short-circuits before acces=
sing the CRTC state.

The stream-NULL case for a DPMS-inactive but still attached CRTC may be a v=
alid pre-existing issue. It is not introduced or worsened by this patch: th=
e existing condition dereferences dm_old_crtc_state->stream before calling =
amdgpu_dm_get_output_color_space(), which is the function changed here. Bro=
adcast RGB property updates already enter this path for the existing color =
spaces.

I will investigate the inactive-stream case separately and submit an indepe=
ndent fix if needed.

Thanks,
Satyajit




On Sunday, August 30th, 2026 at 12:06 AM, sashiko-bot@kernel.org <sashiko-b=
ot@kernel.org> wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>=20
> Pre-existing issues:
> - [Critical] NULL pointer dereference in `amdgpu_dm_atomic_commit_tail` w=
hen changing the `Broadcast RGB` connector property.
> --
>=20
> commit 25a82016e5e929302d7c5fe7edf379f4e6cec7a0
> Author: Satyajit Roy <sroy14@alum.utk.edu>
>=20
> drm/amd/display: Honor Broadcast RGB for BT.2020 RGB output
>=20
> This patch updates amdgpu_dm_get_output_color_space() to apply the Broadc=
ast
> RGB connector property for BT.2020 RGB output. It explicitly selects limi=
ted
> range when requested, fixing an issue where it always defaulted to full r=
ange.
>=20
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.=
c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> > index 8a35e4df13cbf..f2f6a2a0db99e 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> > @@ -758,10 +758,14 @@ amdgpu_dm_get_output_color_space(const struct dc_=
crtc_timing *dc_crtc_timing,
> >  =09=09break;
> >  =09case DRM_MODE_COLORIMETRY_BT2020_RGB:
> >  =09case DRM_MODE_COLORIMETRY_BT2020_YCC:
> > -=09=09if (dc_crtc_timing->pixel_encoding =3D=3D PIXEL_ENCODING_RGB)
> > -=09=09=09color_space =3D COLOR_SPACE_2020_RGB_FULLRANGE;
> > -=09=09else
> > +=09=09if (dc_crtc_timing->pixel_encoding =3D=3D PIXEL_ENCODING_RGB) {
> > +=09=09=09if (connector_state->hdmi.broadcast_rgb =3D=3D DRM_HDMI_BROAD=
CAST_RGB_LIMITED)
> > +=09=09=09=09color_space =3D COLOR_SPACE_2020_RGB_LIMITEDRANGE;
> > +=09=09=09else
> > +=09=09=09=09color_space =3D COLOR_SPACE_2020_RGB_FULLRANGE;
> > +=09=09} else {
> >  =09=09=09color_space =3D COLOR_SPACE_2020_YCBCR_LIMITED;
> > +=09=09}
> >  =09=09break;
> >  =09case DRM_MODE_COLORIMETRY_DEFAULT: /* ITU601 */
>=20
> [Severity: Critical]
> This is a pre-existing issue, but does changing the Broadcast RGB propert=
y
> crash the kernel via a NULL pointer dereference?
>=20
> When userspace changes the Broadcast RGB property on a connector, DRM cor=
e
> creates an atomic commit containing only the updated connector state. The=
 AMD
> driver's amdgpu_dm_atomic_check() does not add the associated CRTC to the
> atomic state for these broadcast_rgb changes.
>=20
> This leads to a crash in drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.=
c
> within amdgpu_dm_atomic_commit_tail(), where drm_atomic_get_new_crtc_stat=
e()
> returns NULL:
>=20
> =09if (acrtc) {
> =09=09new_crtc_state =3D drm_atomic_get_new_crtc_state(state, &acrtc->bas=
e);
> =09=09old_crtc_state =3D drm_atomic_get_old_crtc_state(state, &acrtc->bas=
e);
> =09}
>=20
> =09/* Skip any modesets/resets */
> =09if (!acrtc || drm_atomic_crtc_needs_modeset(new_crtc_state))
> =09=09continue;
>=20
> Since new_crtc_state is NULL, drm_atomic_crtc_needs_modeset() uncondition=
ally
> dereferences it and crashes.
>=20
> Even if this did not crash (for example on a disabled CRTC where modeset
> might evaluate to false), execution proceeds to the fast-update path in
> the same function:
>=20
> =09if ((new_con_state->hdmi.broadcast_rgb !=3D old_con_state->hdmi.broadc=
ast_rgb) &&
> =09=09(dm_old_crtc_state->stream->output_color_space !=3D
> =09=09=09amdgpu_dm_get_output_color_space(&dm_new_crtc_state->stream->tim=
ing, new_con_state)))
>=20
> For a disabled CRTC, stream is NULL, which causes dm_new_crtc_state->stre=
am
> and dm_old_crtc_state->stream to trigger a second unavoidable NULL pointe=
r
> dereference.
>=20
> [ ... ]
>=20
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830035120.93=
7992-1-edu042sjroy@proton.me?part=3D2
> 
