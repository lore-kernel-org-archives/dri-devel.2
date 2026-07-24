Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F77C531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAF9F10E00E;
	Fri, 24 Jul 2026 09:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UuarixtG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C15410E00E
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 09:52:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7C56C600C3;
 Fri, 24 Jul 2026 09:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40281F000E9;
 Fri, 24 Jul 2026 09:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784886740;
 bh=sQrovcqe5Xaw8Z00dGheB4mES5Aoe9+Lu3L4RtKxhqY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UuarixtG6QDO4+kpvCsKGTvdnJjAeW1zTgyQbq89azg87CVV7dS1ECfVnX8C3L00h
 E18jedco7LFPSUeN4Qooz4/iOx9OPNl2+dYUMPMeaHm0aOwKASgPY4m1Hhkao8Gvy0
 ACQAXn6ZTL+TbHgj8XRh7RHajB1I6n3S0dB6togIgYysCm0eLUzeyEQnuiOt4/yLpd
 yj+xqO2OuXiGAjFc4c3FSycchvCFIlv9RUoN2O5l0QyhztwVloi0hE2mbyiHVnt486
 +YCVlefA+FYGc08CrJG8UD/S4tnSA1zeYr1PQyfU3W5T4MyF6KRn0mFFo6Sehu18o9
 5FFBFf+mPymQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/udl: Use iosys_map getter for virtual address
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724093808.776138-2-oushixiong1025@163.com>
References: <20260724093808.776138-1-oushixiong1025@163.com>
 <20260724093808.776138-2-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 09:52:19 +0000
Message-Id: <20260724095219.F40281F000E9@smtp.kernel.org>
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
- [High] The patch replaces direct access to `map->vaddr` with `iosys_map_g=
et_vaddr()`. However, `iosys_map_get_vaddr()` explicitly warns and returns =
`NULL` if the mapping points to I/O memory (`map->is_iomem =3D=3D true`). W=
hen userspace imports a dma-buf from a discrete GPU (which typically export=
s VRAM as I/O memory) into the UDL driver and uses it as a framebuffer, the=
 damage handler `udl_handle_damage()` will receive an I/O memory mapping. C=
alling `iosys_map_get_vaddr()` on this mapping triggers a `WARN_ON` for eve=
ry damage rectangle processed and fails the update by returning `-EFAULT`. =
This functionally breaks PRIME imports from discrete GPUs to DisplayLink de=
vices and creates a local Denial of Service (DoS) vector by allowing a loca=
l user to spam the kernel log with warnings or trigger a panic if `panic_on=
_warn` is enabled. The correct fix for the original architectural issue sho=
uld have been using `iosys_map_rd()` or `iosys_map_memcpy_from()` rather th=
an `iosys_map_get_vaddr()`.
--

--- Patch [2]: [PATCH 2/2] drm/udl: Use iosys_map getter for virtual addres=
s ---
commit 935887dfbb84bad699c0f9cf22dbe263fac86a93
Author: Shixiong Ou <oushixiong@kylinos.cn>

drm/udl: Use iosys_map getter for virtual address
   =20
Replace direct access to map->vaddr with the new iosys_map_get_vaddr()
helper function. This properly uses the iosys_map abstraction layer
instead of directly accessing structure members.

> diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_=
modeset.c
> index 289711035b67c..06a3a4d149b9d 100644
> --- a/drivers/gpu/drm/udl/udl_modeset.c
> +++ b/drivers/gpu/drm/udl/udl_modeset.c
> @@ -207,12 +207,16 @@ static int udl_handle_damage(struct drm_framebuffer=
 *fb,
>  {
>  	struct drm_device *dev =3D fb->dev;
>  	struct udl_device *udl =3D to_udl(dev);
> -	void *vaddr =3D map->vaddr; /* TODO: Use mapping abstraction properly */
> +	void *vaddr;
>  	int i, ret;
>  	char *cmd;
>  	struct urb *urb;
>  	int log_bpp;
> =20
> +	vaddr =3D iosys_map_get_vaddr(map);
> +	if (!vaddr)
> +		return -EFAULT;
> +

[Severity: High]
Does this code break PRIME imports from discrete GPUs?

If userspace imports a dma-buf from a discrete GPU (which typically exports
VRAM as I/O memory) into the UDL driver and uses it as a framebuffer, the
map passed to udl_handle_damage() will be mapped as IOMEM.

Looking at iosys_map_get_vaddr() in include/linux/iosys-map.h:

static inline void *iosys_map_get_vaddr(const struct iosys_map *map)
{
	if (WARN_ON(map->is_iomem))
		return NULL;
	return map->vaddr;
}

This will trigger a WARN_ON for every damage rectangle processed and return
-EFAULT, failing the update. Could this create a local DoS if panic_on_warn
is enabled, or spam the kernel log with warnings?

Would it be safer to use iosys_map_rd() or iosys_map_memcpy_from() here
rather than iosys_map_get_vaddr() to properly handle IOMEM mappings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724093808.7761=
38-1-oushixiong1025@163.com?part=3D2
