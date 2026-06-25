Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441F4CDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 04:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36DDB10E140;
	Thu, 25 Jun 2026 04:26:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JgcEFKhx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41F1310E140
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 04:26:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 627A260018;
 Thu, 25 Jun 2026 04:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD031F000E9;
 Thu, 25 Jun 2026 04:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782361567;
 bh=D+b32WYuAkEe/98OGr1o5gygitPeJVpkxeTAdorBT3M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JgcEFKhx/knNWLPqSNZ28M4C5d8EADgS6HOeomW08uSs5PZKkcnCxibRNERqoxs+5
 JeoOw19t+jZf2Urye4CxEeS9nL+xB7AO+r59XqY6+WbUIptG6w1N5b8hJfNQ+ZfGmp
 NNPTLIXQFqDfjwjEEcPbNnc+OQdHOyqEnln4tZE8Q6LTS8m6+ov5/TjfUv/iwVSLB7
 TEwUhpFPh6VxC7c076pvv3THxXCW4XqzG+LULqEVolcvr+9CZqS7LEtamXvvLfQf0Q
 sOec0og+8cK/Nathjpo+L8O1GqQtlb/jlJiwiDXYBFOrg4Xk5nfI4JAnOPRT4MAZd+
 1pAszLqbd8atg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: Fix fb_new_modelist to prevent null-ptr-deref in
 fb_videomode_to_var
To: "Ian Bridges" <icb@fastmail.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <ajyq2Fr-2fMfftGC@dev>
References: <ajyq2Fr-2fMfftGC@dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 04:26:06 +0000
Message-Id: <20260625042606.DBD031F000E9@smtp.kernel.org>
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
- [High] Buffer overflow in `show_modes()` due to unbounded accumulation of=
 offset.
--

commit c6eace86a62190121a8b0640238eca3a23f8495d
Author: Ian Bridges <icb@fastmail.org>

fbdev: Fix fb_new_modelist to prevent null-ptr-deref in fb_videomode_to_var

This commit fixes a null pointer dereference in fb_videomode_to_var by
ensuring that the current mode is kept in the modelist during
fb_new_modelist() if it is not already present.

> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/=
fbmem.c
> index e5221653ec2b9..2f1c56e5a7a23 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c

[ ... ]

> @@ -767,6 +767,18 @@ int fb_new_modelist(struct fb_info *info)
>  	if (list_empty(&info->modelist))
>  		return 1;
> =20
> +	/*
> +	 * The new modelist may not contain the current mode (info->var), and
> +	 * fbcon_new_modelist() below only re-points consoles mapped to this
> +	 * framebuffer. Add the current mode here so info->var keeps a match
> +	 * even when fbcon is unbound.
> +	 */

[Severity: High]
This is a pre-existing issue, but while reviewing how modelists are populat=
ed
here, I noticed an older problem when the modelist is read from sysfs.

Does this code overflow the sysfs buffer on the kernel heap?

If a driver populates the framebuffer's modelist with many entries, or root
writes them via the store_modes sysfs interface, the offset i accumulates
the return value of mode_string() continuously in show_modes():

drivers/video/fbdev/core/fbsysfs.c:show_modes() {
    ...
    i +=3D mode_string(buf, i, mode);
    ...
}

The mode_string() function passes this offset directly to snprintf:

drivers/video/fbdev/core/fbsysfs.c:mode_string() {
    ...
    return snprintf(&buf[offset], PAGE_SIZE - offset, "%c:%dx%d%c-%d\n",
                    m, mode->xres, mode->yres, v, mode->refresh);
}

Because snprintf returns the number of characters that would have been
written regardless of truncation, the offset will eventually exceed PAGE_SI=
ZE
if there are enough modes.=20

When offset is greater than PAGE_SIZE, the expression PAGE_SIZE - offset
integer-underflows to a massive positive size_t value, causing snprintf
to write past the 1-page sysfs buffer allocation.

> +	if (!fb_match_mode(&info->var, &info->modelist)) {
> +		fb_var_to_videomode(&mode, &info->var);
> +		if (fb_add_videomode(&mode, &info->modelist))
> +			return 1;
> +	}
> +
>  	fbcon_new_modelist(info);
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ajyq2Fr-2fMfftGC@de=
v?part=3D1
