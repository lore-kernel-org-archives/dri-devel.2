Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79586C624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 14:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 453F510E289;
	Sat,  5 Sep 2026 14:36:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P3vDVZmD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6659C10E226;
 Sat,  5 Sep 2026 14:36:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 762DB601DB;
 Sat,  5 Sep 2026 14:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C6B1F00A3E;
 Sat,  5 Sep 2026 14:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788618987;
 bh=/4P6v6X9ZQB2Zr5ktwjI6m8yqdhATstrZ2Q5cg0qjxk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P3vDVZmDCgk0HFX9jiuVYfYQO7yb8AnzPr6JyRcS/flBw9akQPkb82bPtaaRUF/jY
 ncHQy9zPjWmMz034r6nYyJWMCfByT/9aMC3eQyBWdRcJ996MBtEwZXSj+Q4T1yZ0Ft
 b3+N8iihyKiCucr+q38H2y7DHVSg2OdpseN8bibmpEbXGYtKNZOv4v5aIHxH29uGje
 zJI01Kju0iBN8v9pxJyt0RhA84Xts7khRXkkUG2wguwKNkYDPOWfAJTnZh/IWgIGdm
 InBNLMnamp1zkOoiBT46cIzRsXmzgi72yKf4UHV3josohnL3paYAlvHIYbDTXTkY9p
 QGZ7IVieZOGog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/xe/display: Remove invalid initial plane PTE check
 for iGPU
To: "Andrew Zhou" <zhoulol888@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260905142500.17666-1-zhoulol888@gmail.com>
References: <20260905142500.17666-1-zhoulol888@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 14:36:26 +0000
Message-Id: <20260905143626.E9C6B1F00A3E@smtp.kernel.org>
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
- [Low] The patch removes the validation from the integrated graphics path,=
 rendering the `has_lmembar()` logic completely dead and meaningless.
--

commit b290f7e32abe43d35ac4f5def3b10e9bcf641a88
Author: Andrew Zhou <zhoulol888@gmail.com>

drm/xe/display: Remove invalid initial plane PTE check for iGPU

This commit removes the initial plane PTE local memory validation for
integrated graphics, as Pantherlake can have the XE_GGTT_PTEDM bit set.
The check was causing a failure to create the initial framebuffer.

> diff --git a/drivers/gpu/drm/xe/display/xe_initial_plane.c b/drivers/gpu/=
drm/xe/display/xe_initial_plane.c
> index 0f86b73036d03..8c95dc4e6f2ef 100644
> --- a/drivers/gpu/drm/xe/display/xe_initial_plane.c
> +++ b/drivers/gpu/drm/xe/display/xe_initial_plane.c

[ ... ]

> @@ -93,13 +92,6 @@ initial_plane_bo(struct xe_device *xe,
>  			return NULL;
>  		}
> =20
> -		pte =3D xe_ggtt_read_pte(tile0->mem.ggtt, base);
> -
> -		if (is_pte_local(pte) !=3D need_pte_local(xe)) {
> -			drm_err(&xe->drm, "Initial plane PTE has bad local memory bit\n");
> -			return NULL;
> -		}
> -

[Severity: Low]
Does this leave need_pte_local() with dead logic?

By removing this validation from the integrated graphics path (!IS_DGFX(xe)=
),
the only remaining caller of need_pte_local() is inside the earlier=20
if (IS_DGFX(xe)) branch in initial_plane_bo().

Because need_pte_local() is defined as:

static bool need_pte_local(struct xe_device *xe)
{
	return IS_DGFX(xe) || has_lmembar(xe);
}

It will now unconditionally evaluate to true when called, rendering the
has_lmembar(xe) check completely meaningless.=20

Should need_pte_local() and its underlying logic be simplified or removed=20
as well to prevent confusion?

>  		phys_base =3D base;
>  		flags |=3D XE_BO_FLAG_STOLEN;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905142500.1766=
6-1-zhoulol888@gmail.com?part=3D1
