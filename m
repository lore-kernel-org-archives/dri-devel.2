Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2486FC98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:39:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B46C10EE3B;
	Tue, 22 Sep 2026 19:39:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oHm+Cmaf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57BCB10EE3B
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 19:39:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 52AFD6022B;
 Tue, 22 Sep 2026 19:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3BB1F000FF;
 Tue, 22 Sep 2026 19:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790105944;
 bh=jZkS+y+1MC6iB0krBU1QBTSjMvDnF5ANlOckWYIKskQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oHm+Cmaf5daOIdMwq4GJn4K1TE5NFTIXgcLJdbIb5t+NByccEBUS04QbKJ75of3B7
 yY3VLDrOvirLPtvEGXEC34euWGoSJ31xq1KuPm+EAkD/Jn5P41xRTfTL9hVaoYSoa8
 peke951g0UqchnwZenHJ6Tbu7PWHozrOqAtIekRWAB28nl/nnF5mXMBQI0f19X4VTz
 g8TFOC3Y6+ZtLRnjLSPJysu2+bMR0HJucszxAX15Hh6mJYWAwi3ptYWruXgWq1qvm4
 4fDROjmyCYOi+gPF9ICL1rucLx4RGZp71IQpDb1PEKoTTNhJY3/Ng52DTGjgiMG3ia
 oa5pn3TeiPUhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/nouveau: select HDMI deep-color link depth
To: "Daniel Campos Ramos" <Capitain_Jack@yahoo.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260922192132.114546-2-Capitain_Jack@yahoo.com>
References: <20260922192132.114546-1-Capitain_Jack@yahoo.com>
 <20260922192132.114546-2-Capitain_Jack@yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 19:39:03 +0000
Message-Id: <20260922193903.DE3BB1F000FF@smtp.kernel.org>
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
- [High] drm/nouveau: incorrect TMDS character rate calculation for HDMI de=
ep color breaks SCDC scrambling
- [Medium] drm/nouveau: HDMI deep color permanently disabled on non-HDMI co=
nnectors
--

commit e40b56c72a75d42642f11bb0711a44b65e65a10b
Author: Daniel Campos Ramos <Capitain_Jack@yahoo.com>

drm/nouveau: select HDMI deep-color link depth

The patch enables HDMI deep-color modes by attaching an 8 to 16 max bpc
property to HDMI connectors. It then selects the appropriate 10, 12, or
16 bpc output depth if the sink advertises support and the resulting TMDS
character rate fits within the existing link limits.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/dr=
m/nouveau/nouveau_connector.c
> index b0b0ad9a0c248..240a7b96cc519 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
[ ... ]
> @@ -298,6 +298,9 @@ nouveau_conn_attach_properties(struct drm_connector *=
connector)
>  		drm_object_attach_property(&connector->base, dev->mode_config.
>  					   dvi_i_subconnector_property, 0);
> =20
> +	if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_HDMIA)
> +		drm_connector_attach_max_bpc_property(connector, 8, 16);

[Severity: Medium]
Does this prevent HDMI deep color from being enabled on DVI or DP connectors
that are driving an HDMI sink via a passive adapter?

If the max bpc property is only attached for HDMIA connectors, then for oth=
er
connector types driving an HDMI sink, the max_requested_bpc state remains 0.
Later in nv50_outp_atomic_fix_depth(), the deep color promotion checks
(like conn_state->max_requested_bpc >=3D 12) will fail, locking these
configurations to 8 bpc despite both sink and GPU supporting higher depths.

> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> index 2c66e480b5116..9e8bfd6b78ec0 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
[ ... ]
> @@ -1776,6 +1808,27 @@ nv50_sor_atomic_enable(struct drm_encoder *encoder=
, struct drm_atomic_commit *st
> =20
>  	switch (nv_encoder->dcb->type) {
>  	case DCB_OUTPUT_TMDS:
> +		switch (asyh->or.bpc) {
> +		case 16:
> +			depth =3D NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_BPP_48_444;
> +			break;
> +		case 12:
> +			depth =3D NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_BPP_36_444;
> +			break;
> +		case 10:
> +			depth =3D NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_BPP_30_444;
> +			break;
> +		case 8:
> +			depth =3D NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_BPP_24_444;
> +			break;
> +		case 6:
> +			depth =3D NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_BPP_18_444;
> +			break;
> +		default:
> +			depth =3D NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_DEFAULT;
> +			break;
> +		}
> +
>  		if (disp->disp->object.oclass !=3D NV50_DISP &&
>  		    nv_connector->base.display_info.is_hdmi)
>  			nv50_hdmi_enable(encoder, nv_crtc, nv_connector, state, mode, hda);

[Severity: High]
Will enabling deep color here cause SCDC scrambling to fail for high-bandwi=
dth
modes?

The HDMI 2.0 specification requires TMDS scrambling and a 1/40 bit clock
ratio when the TMDS character rate exceeds 340 MHz. However, when calling
nv50_hdmi_enable(), the existing code calculates the high TMDS clock
ratio using the pixel clock rather than the new TMDS character rate:

drivers/gpu/drm/nouveau/dispnv50/disp.c:nv50_hdmi_enable() {
    ...
    const bool high_tmds_clock_ratio =3D mode->clock > 340000;
    ...
    ret =3D nvif_outp_hdmi(&nv_encoder->outp, nv_crtc->index, true,
                         max_ac_packet, rekey, mode->clock, ...);
    ...
}

For high-bandwidth modes like 4K 30Hz at 12 bpc, the pixel clock is 297 MHz
but the TMDS rate is 445.5 MHz. In this scenario, high_tmds_clock_ratio
evaluates to false and the unscaled pixel clock is passed to the hardware
sequencer.

Could this cause the driver to fail to enable SCDC scrambling and the requi=
red
clock ratio, resulting in a display link training failure and a black scree=
n?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922192132.1145=
46-1-Capitain_Jack@yahoo.com?part=3D1
