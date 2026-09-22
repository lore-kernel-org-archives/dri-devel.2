Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE299C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:29:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B50110EE29;
	Tue, 22 Sep 2026 19:29:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jCbt5ILn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63F6F10EE29
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 19:29:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0465F41273;
 Tue, 22 Sep 2026 19:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4471F000FF;
 Tue, 22 Sep 2026 19:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790105361;
 bh=LSSKB0HSzTfJegD+ydG9MaaxXxhnrk09HHlOcTUjrWU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jCbt5ILnur106HqVg/FLeMynS62EpBRHxwCUqt5oUiyPl7IU+nASdnDhAwdQBubW8
 xI8PYIUiUhUf/qQH1uXkTaTCgBqoogjn+vqpUhYALJ/MN6vmRnTXHXSjdjXOKpnjYp
 s+3HUeU4ZwyF98d+k0nfKwafBCsYxFKqWkykVmXenJBt7GXc1E9GixWZBfR3glZZMv
 cSsisO1VjJxwpLeUEfljpGp09MXMmxVjtKy25nKGQYUkIzln/Qzs/eB3wsxaslX47G
 7ZrDQhMDcmhCQj+HkJa47ACe4gz3MqEK2gkCAW34q43pWuo8a1VCO2eIoexgArEsRp
 2DyrCae2NBPYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/nouveau: pass HDMI GCP deep-color state through
 NVIF
To: "Daniel Campos Ramos" <Capitain_Jack@yahoo.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260922192132.114546-3-Capitain_Jack@yahoo.com>
References: <20260922192132.114546-1-Capitain_Jack@yahoo.com>
 <20260922192132.114546-3-Capitain_Jack@yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 19:29:21 +0000
Message-Id: <20260922192921.BA4471F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/nouveau: missing 30-bpp GCP configuration in nv50_hdmi_enable()
--

commit a5a312ee20dba0d1f27e5316dc3d7c1c29070995
Author: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
Subject: drm/nouveau: pass HDMI GCP deep-color state through NVIF

This commit adds HDMI GCP color depth and pixel packing phase configuration
to Nouveau to support 30, 36, and 48-bpp RGB links. It extends the NVIF
HDMI method to pass and cache these values for generation-specific writers.

> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
[ ... ]
> @@ -826,6 +827,19 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct=
 nouveau_crtc *nv_crtc,
>  	max_ac_packet -=3D 18; /* constant from tegra */
>  	max_ac_packet /=3D 32;
> =20
> +	/* Match NVIDIA's 36-bpp GCP construction and extend the same HDMI
> +	 * color-depth encoding to 48-bpp.  48-bpp groups contain one pixel,
> +	 * so their last packing phase is phase 4 (zero).
> +	 */
> +	if (bpc =3D=3D 16) {
> +		gcp_cd =3D 7;
> +	} else if (bpc =3D=3D 12) {
> +		const u32 hbp =3D mode->crtc_hblank_end - mode->crtc_hsync_end;
> +
> +		gcp_cd =3D 6;
> +		gcp_pp =3D ((mode->crtc_hdisplay + hbp) & 1) ? 1 : 2;
> +	}
> +

[Severity: High]
Does this code omit the configuration for 30-bpp (10 bpc) HDMI streams?

If a monitor supports 30-bit deep color (DRM_EDID_HDMI_DC_30), asyh->or.bpc
is set to 10 in nv50_sor_atomic_enable() and passed here as bpc =3D 10.=20
When bpc =3D=3D 10, gcp_cd and gcp_pp are left as 0, which means "not indic=
ated"=20
and assumes a 24-bpp standard color depth.

Could this cause a corrupted or unreadable display output on 10-bit color=20
monitors by violating the HDMI specification for Deep Color?

>  	if (nv_encoder->i2c && hdmi->scdc.scrambling.supported) {
>  		const bool high_tmds_clock_ratio =3D mode->clock > 340000;
>  		u8 scdc;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922192132.1145=
46-1-Capitain_Jack@yahoo.com?part=3D2
