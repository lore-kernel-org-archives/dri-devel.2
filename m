Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3CCCD8CB2
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6922610E46D;
	Tue,  9 Jun 2026 17:40:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CYnzurUe";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9555A10E46D
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 17:40:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5408B40148;
 Tue,  9 Jun 2026 17:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7C21F00893;
 Tue,  9 Jun 2026 17:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781026837;
 bh=Resmh0VIPv3cvuF3Lz/pIf9uMj8LarZ0XGRbt2N0At8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CYnzurUeyR0HZbW9FCDdfBY1DNoR9mR/5M9iEvFWSGddJL01o7rqvcV0Lpm7R07le
 s+Laeg1rzjTijFCWXd0g7qalSingHawvX8OdHNjqp+SkWkpt+zzLCExqVFUz1zSv6I
 btMA3WeBuOAYsHu5gF1WsZlQMRYTtmWCCxCiC+SofTcOfltB8tvGy6zp+T8Suhub0H
 hq7pt0OyH0jMsoGGFpeEhRkDhWEVuc9rWhhtYfpt3G3lDkBGMXhqzt0fCsOwLGW5kg
 QnKUBX/7eCagBB8V7iZoq4OmpW4xOlvYKCH6MGrxGfWQdkGTVpCe7O4WUcVnGM6Zou
 grAj8yS1PzUlQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7/8] drm/colorop: Convert pipline 'next' pointer to
 a list
To: "John Harrison" <John.Harrison@Igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609171941.169104-8-John.Harrison@Igalia.com>
References: <20260609171941.169104-8-John.Harrison@Igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 17:40:36 +0000
Message-Id: <20260609174037.1C7C21F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Unconditional dereference of potentially NULL color pipeline in VK=
MS pre_blend_color_transform.
- [Medium] Fragile global state tracking in `drm_atomic_colorop_print_state=
` leads to misaligned pointer dereferences.

Pre-existing issues:
- [Critical] Data race and Use-After-Free due to asynchronous access of glo=
bal `colorop->state` in VKMS composer.
--

commit bddf98b16d8f020be8f44f0de1ce3cd9f1f44d2d
Author: John Harrison <John.Harrison@Igalia.com>

drm/colorop: Convert pipline 'next' pointer to a list
   =20
The colorop pipeline system was using explicit next pointers and open
coded lists rather than the official kernel list helpers. Fix that.

> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 170de30c28ae4..8e985fd0562be 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
[ ... ]
> @@ -849,7 +853,12 @@ static void drm_atomic_colorop_print_state(struct dr=
m_printer *p,
>  		break;
>  	}
> =20
> -	drm_printf_indent(p, 1, "next=3D%d\n", colorop->next ? colorop->next->b=
ase.id : 0);
> +	if (list_is_last(&colorop->pipeline_list, &(*pipeline)->pipeline_head))=
 {
> +		*pipeline =3D NULL;
> +		return;
> +	}
> +
> +	drm_printf_indent(p, 1, "next=3D%d\n", list_next_entry(colorop, pipelin=
e_list)->base.id);
>  }

[Severity: Medium]
What happens if an orphaned colorop (created but not added to any pipeline)
exists in the global config->colorop_list?

It appears the pipeline pointer would be set to this orphan, but list_is_la=
st
will never evaluate to true since its pipeline_head is empty. Won't the
pipeline tracking get permanently stuck, causing a subsequent valid pipelin=
e's
last node to return false here?

This looks like it would evaluate list_next_entry which computes container_=
of
on pipeline_head at a different offset, leading to a misaligned pointer
dereference.

> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/=
vkms_composer.c
> index 83d217085ad09..fc20b788738a3 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -194,9 +194,12 @@ static void pre_blend_color_transform(const struct v=
kms_plane_state *plane_state
>  				      struct line_buffer *output_buffer)
>  {
>  	struct pixel_argb_s32 pixel;
> +	struct drm_colorop *pipeline =3D plane_state->base.base.color_pipeline;
> +
> +	WARN_ON(!list_is_first(&pipeline->pipeline_list, &pipeline->pipeline_he=
ad));

[Severity: High]
Could this cause a regression if userspace doesn't configure a color pipeli=
ne
and leaves the property unset?

The previous code handled a missing pipeline safely, but this looks like it
will unconditionally dereference the pipeline pointer inside the list_is_fi=
rst
helper before checking if it actually exists. Does this need an early return
or a valid pipeline check first?

> =20
>  	for (size_t x =3D 0; x < output_buffer->n_pixels; x++) {
> -		struct drm_colorop *colorop =3D plane_state->base.base.color_pipeline;
> +		struct drm_colorop *colorop;
> =20
>  		/*
[ ... ]
> @@ -213,7 +216,7 @@ static void pre_blend_color_transform(const struct vk=
ms_plane_state *plane_state
>  		pixel.g =3D output_buffer->pixels[x].g;
>  		pixel.b =3D output_buffer->pixels[x].b;
> =20
> -		while (colorop) {
> +		list_for_each_entry(colorop, &pipeline->pipeline_head, pipeline_list) {
>  			struct drm_colorop_state *colorop_state;
> =20
>  			colorop_state =3D colorop->state;

[Severity: Critical]
This is a pre-existing issue, but can this direct access to colorop->state
race with concurrent atomic commits?

Since vkms_composer_worker runs asynchronously, couldn't a modeset dynamica=
lly
free this state via drm_atomic_helper_commit_cleanup_done while we're readi=
ng
it, resulting in a use-after-free regression?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609171941.1691=
04-1-John.Harrison@Igalia.com?part=3D7
