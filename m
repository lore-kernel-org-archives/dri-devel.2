Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48C2C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBF8510E248;
	Fri, 21 Aug 2026 15:16:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fboFt2Hz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8254E10E248
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:16:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 681C543ED0
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220371F000E9;
 Fri, 21 Aug 2026 15:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787325412;
 bh=EBXo0N0yMLgfuJ7hI7+/nzBOC5lG4H+gNdP1Xy4UH58=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fboFt2HzxdDeWPZPz6K4Bu9DKadhzTXoOXQ9Cg7b4IzQEtaljB+SsbmhGQkoxuzq1
 B/FL6Zpev80r6IE0uLb4Lt9FaeJiFiGKI4NBhS2TWGM0T+4sUrwExE/WM9B/M40BWb
 gwuOslq0jDb3HHFLTyso3dqe6AYr8SP4E5zXtfae0KFXf779JUVJC9RkAQw4BHbpt0
 4bS8OU0LOiQfMjLdKJOyIKYc/o6Gd8tFrqy858vTlkaZ7EuX4JfO7u8lq2pjNBdnNj
 imyktQjtgWXT+WYsIbC/88eZMSDJxH2D5Mw9FWdTnSLZoe+WbYb+M9bCaoABszHYiv
 83wfKvxvvA+Jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 31/70] drm/tiny: appletbdrm: Switch to
 drm_atomic_helper_crtc_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-31-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-31-fb793475c05a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 15:16:51 +0000
Message-Id: <20260821151652.220371F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] appletbdrm_flush_damage constructs malformed USB packets and uses =
mismatched coordinate spaces for clipping.
--

--- Patch [31]: [PATCH 31/70] drm/tiny: appletbdrm: Switch to drm_atomic_he=
lper_crtc_create_state ---
commit c5a19cb22088517bba7b18adab2a528f848a790f
Author: Maxime Ripard <mripard@kernel.org>

drm/tiny: appletbdrm: Switch to drm_atomic_helper_crtc_create_state

The appletbdrm crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

> diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/app=
letbdrm.c
> index cdd35af498920..94bad6dc720ef 100644
> --- a/drivers/gpu/drm/tiny/appletbdrm.c
> +++ b/drivers/gpu/drm/tiny/appletbdrm.c
> @@ -598,7 +598,7 @@ static const struct drm_crtc_helper_funcs appletbdrm_=
crtc_helper_funcs =3D {
>  };
> =20
>  static const struct drm_crtc_funcs appletbdrm_crtc_funcs =3D {
> -	.reset =3D drm_atomic_helper_crtc_reset,
> +	.atomic_create_state =3D drm_atomic_helper_crtc_create_state,
>  	.destroy =3D drm_crtc_cleanup,
>  	.set_config =3D drm_atomic_helper_set_config,
>  	.page_flip =3D drm_atomic_helper_page_flip,

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem in
appletbdrm_flush_damage() in this same file.

When damage (in framebuffer coordinates) is intersected with state->dst (in
CRTC coordinates), could this produce incorrect clipping results if the pla=
ne
is not placed at (0,0)?

Also, because buf_size is calculated before the intersection, but the frame
dimensions use the mutated damage:

drivers/gpu/drm/tiny/appletbdrm.c:appletbdrm_flush_damage() {
	...
		u32 buf_size =3D rect_size(&damage);

		if (!drm_rect_intersect(&dst_clip, &damage))
			continue;

		/* ... */
		frame->width =3D cpu_to_le16(drm_rect_height(&damage));
		frame->height =3D cpu_to_le16(drm_rect_width(&damage));
		frame->buf_size =3D cpu_to_le32(buf_size);
	...
}

If the damage rectangle is partially outside the destination bounds, will
this cause buf_size to be larger than the actual frame dimensions? Does this
lead to malformed USB frames with uninitialized memory gaps before the foot=
er,
violating the hardware USB protocol?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-drm-no-mor=
e-crtc-reset-v1-0-fb793475c05a@kernel.org?part=3D31
