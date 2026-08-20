Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098E3C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57F6810E206;
	Thu, 20 Aug 2026 14:55:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HwMi2G4B";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45EC110E206
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 14:55:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D6F3A4145A;
 Thu, 20 Aug 2026 14:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D4C1F00A3A;
 Thu, 20 Aug 2026 14:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787237707;
 bh=+M9WuEZ1w+3yovDMUGAolPcJ6oGK1VwZjS9Kh+LxH+w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HwMi2G4BPKRS2/y0IyuTEA7ZmW3q0rL/DoD052krIxrrsnjGysW70BndQhBiKBL/H
 /rdXUouajCqa0oh8+SMZk4oZfZC/4JSPeceM1evnXFhJkxmplwA6Y3U/+xSkjEmjQp
 V9MNz0ng+3bcTO3WP5ZmcCEhXFt817jaqpXdXkLrpUeXItQ7TWu5bJE+Kt4CI4PT2n
 d77bZCckggaHy5QKzlWdUrpMllH03Zwyiq3oFIF8TAmbcDutuAys9BhRpxiM4jAUwh
 3xVB8PYgqWv7KNaBeSkW0ctZTyN7YpsnEXulawNDn9We8I1qAYYBFGKeCO9+hadIUL
 zk38cjOYMUp5w==
From: sashiko-bot@kernel.org
Subject: Re: Patch "drm/vmwgfx: Set surface-framebuffer GEM objects" has
 been added to the 6.18-stable tree
To: gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <2026082037-dig-poppy-40df@gregkh>
References: <2026082037-dig-poppy-40df@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 14:55:07 +0000
Message-Id: <20260820145507.A4D4C1F00A3A@smtp.kernel.org>
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
- [High] The patch introduces dead code and fails to fix the NULL pointer d=
ereference it was intended to resolve.
--

--- Patch [1]: Patch "drm/vmwgfx: Set surface-framebuffer GEM objects" has =
been added to the 6.18-stable tree ---
commit ffe31da5836d4a9255ecd4b72a2e8e4b2fcaa31f
Author: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>

drm/vmwgfx: Set surface-framebuffer GEM objects

This commit sets struct drm_framebuffer.obj[0] to the allocated GEM buffer
object for surface framebuffers. This is intended to prevent a NULL-pointer
dereference in the client's vmap helpers.

Link: https://patch.msgid.link/20251104103611.167821-1-tzimmermann@suse.de

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_kms.c
> index 54ea1b513950a..d32ce1cb579e6 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> @@ -553,6 +553,9 @@ static int vmw_kms_new_framebuffer_surface(struct vmw=
_private *dev_priv,
>  	memcpy(&vfbs->uo, uo, sizeof(vfbs->uo));
>  	vmw_user_object_ref(&vfbs->uo);
> =20
> +	if (vfbs->uo.buffer)
> +		vfbs->base.base.obj[0] =3D &vfbs->uo.buffer->tbo.base;
> +

[Severity: High]
Is this condition ever met for surface framebuffers?

Looking at vmw_user_object_lookup() in drivers/gpu/drm/vmwgfx/vmwgfx_resour=
ce.c,
whenever a surface is successfully resolved, the buffer is explicitly
unreferenced and uo->buffer becomes NULL:

drivers/gpu/drm/vmwgfx/vmwgfx_resource.c:vmw_user_object_lookup() {
    ...
    if (uo->surface)
        vmw_user_bo_unref(&uo->buffer);
    ...
}

Since vmw_kms_new_framebuffer_surface() is only used when uo->surface is
valid, does vfbs->uo.buffer always evaluate to NULL here, leaving the GEM
object unassigned and the original crash unresolved?

Would it be more appropriate to use vmw_user_object_buffer(&vfbs->uo) to fa=
ll
back to returning the surface's guest_memory_bo when uo->buffer is NULL?

>  	*out =3D &vfbs->base;
> =20
>  	ret =3D drm_framebuffer_init(dev, &vfbs->base.base,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026082037-dig-popp=
y-40df@gregkh?part=3D1
