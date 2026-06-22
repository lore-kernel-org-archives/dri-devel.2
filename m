Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B06CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53CB310E702;
	Mon, 22 Jun 2026 13:39:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Xf0LNqNn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D241910E6F2
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 13:39:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8768A43B13;
 Mon, 22 Jun 2026 13:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EE91F00A3A;
 Mon, 22 Jun 2026 13:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782135588;
 bh=cvDQGG1y0IwVqqxFQwBlUa8xY/KJcw4bCENYp3ek66A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Xf0LNqNn2KOOkv/2gOqccePQIbVivilUMZbwaTX8N4W/OQUff030UDtgM4N5JvEdt
 bajBpV5e4xUEPpJJdGFtyqG1ns+tP6+YpISWnlB1kYzdq64I0V4caPcL5QOKfQo+/O
 d2tGGnRwambISBMFD5APkNda0GRxvqC9VrL2yB22i/Ek1VJHFp4CrMTEbXI39q+Xeu
 RrOtS7XoG0bA29tcvB5DeiXXL1+rw5z4c2vJmRbT7xRoNGHO48XHM/6m7WxY3o8fMJ
 yHWIcI+aMFVLUwUywV+jR4vE5PGZvSsNlJ1j72Se9/wXFq0TtV9XNuweF1N7DtUI/J
 jDlU7TG6uxJbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] drm/sysfb: simpledrm: Improve framebuffer-size
 validation
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622132433.722823-2-tzimmermann@suse.de>
References: <20260622132433.722823-1-tzimmermann@suse.de>
 <20260622132433.722823-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 13:39:47 +0000
Message-Id: <20260622133948.46EE91F00A3A@smtp.kernel.org>
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
- [High] The simpledrm driver fails to correctly validate that the framebuf=
fer dimensions fit within the mapped memory resource size due to an inverte=
d condition.
--

commit 1c3adcb617c4a3add398f3f24ada5131889b5d6a
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/sysfb: simpledrm: Improve framebuffer-size validation

Validate the framebuffer size from the firmware against the
limitations of struct drm_display_mode. The type only stores sizes
in 16-bit fields. Fail probing on errors.

Cc: <stable@vger.kernel.org> # v5.14+

> diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/si=
mpledrm.c
> index fc168920f2c64..15dcafa9d524a 100644
> --- a/drivers/gpu/drm/sysfb/simpledrm.c
> +++ b/drivers/gpu/drm/sysfb/simpledrm.c

[ ... ]

> @@ -155,7 +148,7 @@ simplefb_get_height_of(struct drm_device *dev, struct=
 device_node *of_node)
> =20
>  	if (ret)
>  		return ret;
> -	return simplefb_get_validated_int0(dev, "height", height);
> +	return drm_sysfb_get_validated_int0(dev, "height", height, U16_MAX);
>  }
> =20
>  static int

[Severity: High]
This isn't a bug introduced by this patch, but commit 'drm/sysfb:
simpledrm: Validate mmap size against framebuffer size' in this series
attempted to fix the missing validation and failed due to an inverted
condition.

Does simpledrm_device_create() fail to correctly validate that the
framebuffer dimensions fit within the mapped memory resource size?

Looking at simpledrm_device_create(), the check appears to be inverted in
both the system memory and I/O memory fallback paths:

drivers/gpu/drm/sysfb/simpledrm.c:simpledrm_device_create() {
        ...
		if (resource_size(mem) > size) {
			drm_err(dev,
				"framebuffer size of %llu exceeds memory range %pr\n",
				size, mem);
			return ERR_PTR(-EINVAL);
		}
        ...
}

Because this check returns -EINVAL when resource_size(mem) > size, it
incorrectly rejects valid configurations where the physical memory region
is larger than the required framebuffer.

More importantly, it allows invalid configurations where size >
resource_size(mem). In this case, devm_memremap() maps the smaller
resource_size(mem), but drm_fb_memcpy() will access size bytes during
plane updates, leading to an out-of-bounds kernel memory access past the
mapped area.

Should this check be size > resource_size(mem) instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622132433.7228=
23-1-tzimmermann@suse.de?part=3D1
