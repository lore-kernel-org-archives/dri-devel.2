Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D63C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A628110F48F;
	Thu,  9 Jul 2026 09:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UiE+EKvm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0C6110F48F
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 09:36:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 978824089A;
 Thu,  9 Jul 2026 09:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF0E1F000E9;
 Thu,  9 Jul 2026 09:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783589789;
 bh=odpLDiqG04bDji2wc4wOcuCCqh12s7tBQ6HRm+/2K70=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UiE+EKvmU6bkDHeddxUqIdLolLOPo1fa40r0ZY9C9ILzNpkmmqQztlhkBR86rWp9m
 lbPoANWURVlhoMP9Y8R/aPsAGqFzeEWkD7GxC0NAB1EbE5jlvsGCqkmX/nQ7jFwogl
 uLHWYKODsD6Pc/+XlESauhCSDS7H4FcnWh38qHs09UNRbwqq1XUCOlZcRJkDWFfrBz
 nXFn/e7VhBjWrEDQuBxXVlXSV1t97OPrkVYJQ+uCIXWpDE7M62yk56zwftFDqTsMyD
 HHJspIcw8/l8sJyjtFBRBUHxueI3+CXdC9QUjnvK64ovfa0anHVVIQ177wHBEoQOii
 vuHyv+f2YOOQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/7] drm: Implement struct
 vga_switcheroo_client_ops.pre_switch
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709092215.168172-6-tzimmermann@suse.de>
References: <20260709092215.168172-1-tzimmermann@suse.de>
 <20260709092215.168172-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 09:36:28 +0000
Message-Id: <20260709093629.4FF0E1F000E9@smtp.kernel.org>
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
- [Low] `vga_switcheroo_client_fb_set()` and the `fb_info` field in `struct=
 vga_switcheroo_client` are orphaned and remain as dead code.
--

--- Patch [5]: [PATCH v2 5/7] drm: Implement struct vga_switcheroo_client_o=
ps.pre_switch ---
commit d5ba75db20f40c6dde86b90da7c25acad6f23b57
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm: Implement struct vga_switcheroo_client_ops.pre_switch

This commit implements the pre_switch callback for vga_switcheroo in amdgpu,
i915, nouveau, and radeon drivers. It pushes fbcon updates from vga_switche=
roo
into DRM's fbdev emulation and removes calls to vga_switcheroo_client_fb_se=
t()
from fbcon to prevent deadlocks.

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index 9f5c4c101581d..974c7dcf52514 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
[ ... ]
> @@ -2987,10 +2983,6 @@ static int do_fb_registered(struct fb_info *info)
>  		}
>  	}
> =20
> -	/* Set the fb info for vga_switcheroo clients. Does nothing otherwise. =
*/
> -	if (info->device && dev_is_pci(info->device))
> -		vga_switcheroo_client_fb_set(to_pci_dev(info->device), info);
> -

[Severity: Low]
With the removal of these calls from fbcon, are there any remaining users of
vga_switcheroo_client_fb_set()?

It looks like the exported function in drivers/gpu/vga/vga_switcheroo.c is
now completely unused:

void vga_switcheroo_client_fb_set(struct pci_dev *pdev,
				 struct fb_info *info)
{
	struct vga_switcheroo_client *client;

	mutex_lock(&vgasr_mutex);
	client =3D find_client_from_pci(&vgasr_priv.clients, pdev);
	if (client)
		client->fb_info =3D info;
	mutex_unlock(&vgasr_mutex);
}
EXPORT_SYMBOL(vga_switcheroo_client_fb_set);

Because client->fb_info is never populated, does this also leave dead code
in vga_switchto_stage2() where it checks for the fallback?

#if defined(CONFIG_FB)
	else if (new_client->fb_info)
		fb_switch_outputs(new_client->fb_info);
#endif

Would it make sense to remove the orphaned vga_switcheroo_client_fb_set()
function, the fb_info field in struct vga_switcheroo_client, and the
unreachable fallback block to complete the cleanup?

>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709092215.1681=
72-1-tzimmermann@suse.de?part=3D5
