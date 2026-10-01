Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DF2CA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48BF110E261;
	Thu,  1 Oct 2026 22:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DW1vtsSh";
	dkim-atps=neutral
Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com
 [74.125.224.167])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64ED810E261
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 22:16:25 +0000 (UTC)
Received: by mail-yx2-f39.google.com with SMTP id
 00721157ae682-8ac8eb87a11so23218027b3.2
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 15:16:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790892984; cv=none;
 d=google.com; s=arc-20260327;
 b=NCRFB/rvQbbJ6TUO6At4bnpySYJrOW5ByzS9MSDb/9xB77pwwr+O2p9nWZ9Sr0zVHh
 IQUFIwwVgQhuBRE5B7HiK3hX3HO2E68kjOBo3rAI0raCm2t2l43illegYZZg+2WaKcbZ
 lnVWDqOroT1H/nSp+dgVsblO6PhEr6yOwrve23WCikW3/FmqE7JxNe+yUdvttc851SA8
 VPFWoISPp3Yti6KSTSPO/0zt+PUwj+xBA9WwSigEmoUJP/NlULvpeWGMphfjvhtcjOsT
 kNGXVGSoKrYKb3Y7p0Ka8YDNRiGXJ1vyBLzGJpxNgeg+BXNLBlCW65yTCgA0d1E4qt25
 zsXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XB9xzVNWQFih5nvR5ktN4dXZp6q/F9f3icjNXMhe4r4=;
 fh=rdVGboUKQTe2PQPC07+N7izNoR5Mh+KRwIz2BQB2NMY=;
 b=kOVdGJvrLTTiHGIe295pPsEKxl22dNGMnB8DwC9hLQEbPS9WvMA/lNDMCZuKMP3Ket
 EsSsejPzgb4+ERR0ue3QC/sIc1OnV21zoX4NUeo6rSnUEj224PlyyJehSZuRHfDKXm9Z
 B8cC7sAskFkrMAoTFNAcXKgZY63wEe0jgDfA3NEOYFhL5r+1WZrQJv3dzY02OQK8cYUm
 Hx3gh/H3QVCrb7F3qUNzGuKnjpXwUWIShaZnDG5em3xAQ3IAx/QYWKDrmoRl4NgrzrnX
 pR+cFaWICzA9NbVNgRroUctCXLoDp/ZhF0up0gZqVbxmkm23WWXbMLmNZcQ99nLCqI7J
 2zXQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790892984; x=1791497784; darn=lists.freedesktop.org;
 h=content-type:to:subject:message-id:date:from:reply-to:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XB9xzVNWQFih5nvR5ktN4dXZp6q/F9f3icjNXMhe4r4=;
 b=DW1vtsShVJgsa9Dxwwkv2qzz8XuADWMyx/hslYr61UfndFbGk7PIIcarHqUGn74ftT
 N3icth10W2qiYHAvhkQvTf8tcP8siXw5FNPEtnKpsYv6DeVhjaeY7TWcoUM9a23fo2ER
 9sL3vCawZHO3BoukFxiGeK6FY/0QaXfsnM0ZS/WDu0MORQJJUGqjh6EySiv+Pc7rcrhv
 FPZQfcWxrjAP3GCZfmaPT++6GlApBucuIHLH+VAaAjeEAE/2N86mOCGhZqGlgcrQW+wH
 SVHRxkjP5P3FdAiX4ymkl+qKboWFJ8Vj5GLrW/LqbYByySiuf8US1GCuxqf7qGpeai9J
 nccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790892984; x=1791497784;
 h=content-type:to:subject:message-id:date:from:reply-to:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XB9xzVNWQFih5nvR5ktN4dXZp6q/F9f3icjNXMhe4r4=;
 b=aKCHbKsbjc3UenTsIiyU71vInfyIJqkVWkeQxwhQWViFSBfCamwNzk1WduknpsHJR9
 Yh6yzpU15s0uavT3bDWxHvCX9sxhX3EgN/Qf+B/eV0JcbqL7IyiNCkrSVRGfyK70AMno
 KTpDxkOJi6QgK/o94UPqQkUCBzhyUhIaT/8bwwZwpukGQmPmwAhcVC85RovQUv57fiRn
 R65s87k4JPt8L73vtCTnggdp66Lh74+fagRsNty6wvY+6LPQDpfmxfxS5EYVJxQFSDZd
 em6TqF6nLt6aUy35D6x+mpH9SDnvHFkd3LynjJmWRle5ofQveWThfVfpQc6dWXXR0+m/
 673w==
X-Gm-Message-State: AFq9FYJIKrqQGZUon/XhNA04oSuy8EZuknPlKvuf8o4TG9+IIQZgEw2O
 t55yQU/8K87pLU2osFnGHW1MFm91Ix96aG/MOKhU8tOAW/peYdElgUT0NLr3Fij1NSgn8lBIZc/
 iciYxnbJ0R7iA0VDejtYflvQhMWETH9qAmdKv
X-Gm-Gg: AYBFou1/cdWD+agDzVuYjtOuoyw+d3/pE41b7o8oKun2AVtn49ankFl0TLR8ky5zHmR
 iNtrF5MHOZbGg8TDYpZrCZNkEnJc2tEj1JL5SYjAP7wkLdf030sRIq0mhC19AXtLL2d1be8Zck5
 fP1KFbttMfK+cBMtFXxauZzNex79z19W/BcLYBC7Beu2v+Cg+OWcKwy9fm0+f9GimXJE5VbqNFb
 tGb6U33c9Pbh2ttx9QuO+IKPeuAys28K4CH3U7cesBFwP+2lJOWKzVxkNqBsHrdPQzZDLg86qJV
 d6vMSlYm+HJVxxujSnbZYtPwfDh5eYTv3eTYu6Jev4BmCRCCmG7hFYJrGda6ZoL3jLB3Lr1uRhM
 2v0UoG1ONNagXoCZ9zG8y1cJ8IXcU1it3xXnIGNLviSgi2hJm49zZYPHukWS1sJsRogJn9vy26A
 ==
X-Received: by 2002:a05:690c:dc8:b0:893:cf3a:f84d with SMTP id
 00721157ae682-8ae39bbdb2emr4475357b3.24.1790892983951; Thu, 01 Oct 2026
 15:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260929205928.230301-1-adam.j.lewis@gmail.com>
In-Reply-To: <20260929205928.230301-1-adam.j.lewis@gmail.com>
From: Adam Lewis <adam.j.lewis@gmail.com>
Date: Thu, 1 Oct 2026 18:16:11 -0400
X-Gm-Features: AclHuK_PfxTij28nXeRk4sH9ua2IbQ00guiROvpG78fU7s8dZQOkRcb-7dqBWIM
Message-ID: <CAMg7iRyZ6xYNLsM6tyU2S9ViN90kJzhttEWE71Xw2QV8B3pGPw@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: release imported dma-buf when the BO is freed
To: dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000023a50d065ccec4f9"
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
Reply-To: adamjlewis@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

--00000000000023a50d065ccec4f9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry this was a dupe and is superseded by Michal TOMAs work here:
https://lists.freedesktop.org/archives/dri-devel/2026-September/595772.html

On Tue, Sep 29, 2026 at 5:02=E2=80=AFPM Adam Lewis <adam.j.lewis@gmail.com>=
 wrote:

> vmw_prime_import_sg_table() creates a BO for a foreign dma-buf through
> drm_gem_prime_import_dev(), which attaches to the dma-buf, maps the
> attachment and takes a reference on it.  vmw_bo_free() never undoes
> this, so each foreign import leaks the attachment, its sg table and the
> dma-buf reference, and the exporter's pages stay pinned after the GEM
> handle, the DRM file and the importing process are gone.
>
> Any client that can open a render node and obtain a dma-buf from
> another exporter (udmabuf, V4L2, another DRM device) can pin memory
> without bound.  KWin does so on its own in VMware guests: it wraps
> wl_shm client buffers in udmabufs and imports them, leaking gigabytes
> within days.
>
> Call drm_prime_gem_destroy() for imported objects before releasing the
> GEM object, as amdgpu, radeon and nouveau do.  vmw_bo_free() is TTM's
> destroy callback, so TTM is done with the reservation object shared
> with the dma-buf by then.
>
> Tested on 7.1.13 and 7.2.7 with a udmabuf import reproducer and on a
> Plasma desktop, where KWin's imported client buffers are now released.
> The leak was found and the fix written with the help of an LLM coding
> assistant.
>
> Fixes: b32233accefff ("drm/vmwgfx: Fix prime import/export")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5.1
> Signed-off-by: Adam Lewis <adam.j.lewis@gmail.com>
> ---
> Notes (dropped on apply):
>
> Security note: per Documentation/process/threat-model.rst an unprivileged
> user must not be able to make the system unresponsive through unbounded
> resource exhaustion.  On a default systemd desktop every logged-in user
> has a render node (0666) and /dev/udmabuf (uaccess ACL), which is all
> this needs, and the pinned memory survives the triggering process.  The
> bug was found with AI assistance, so per security-bugs.rst it is treated
> as public and the reproducer is not attached (available privately).
> A CVE request will follow once the fix is in a released kernel.
>
> Environment: VMware Fusion on an Apple M3 Max host, Fedora 44 aarch64
> guest, vmwgfx 2.21.0, no swap.  Found on 7.1.12/7.1.13 (Mesa 26.1.8,
> KWin 6.7.4), confirmed on 7.2.7 (Mesa 26.2.3, KWin 6.7.5).  The import
> and destructor code is unchanged from v7.1 through v7.3-rc5 and current
> drm-misc-fixes; b32233accefff went to stable # v6.6+.  Not the same
> issue as f739416dc555 ("drm/vmwgfx: drop dma_buf reference on
> foreign-fd prime import"), which covers ttm_prime_fd_to_handle()'s
> error path and was already in the kernels tested.
>
> How it shows up: KWin wraps every wl_shm client buffer in a udmabuf and
> imports it into vmwgfx, for scanout and, when it renders with llvmpipe
> because svga reports "No 3D enabled", as a texture.  Every import
> leaked, so every client buffer stayed pinned: ~6 GB after a few days on
> 7.1.  debugfs bufinfo then listed 961 live udmabufs, 954 of them still
> attached to vmwgfx, while kwin_wayland held 35 dma-buf fds.  On an
> unpatched 7.2.7 boot, nr_foll_pin_released did not move at all in four
> hours of desktop use, while MemAvailable fell to 2.8 of 24.5 GB.
>
> Testing:
>   - reproducer (udmabuf -> PRIME_FD_TO_HANDLE -> GEM_CLOSE -> close the
>     dma-buf -> close the DRM fd): unpatched, the dma-buf outlives the
>     process with refcount 1 and vmwgfx still attached; patched (7.1.13
>     and 7.2.7), the pins are released as soon as the dma-buf fd is
>     closed;
>   - imported framebuffer: ADDFB2 + SETPLANE on/off + CLOSEFB through the
>     screen-target path on 7.1.13, and ADDFB2 + CLOSEFB on 7.2.7, both
>     release cleanly;
>   - Plasma desktop on 7.2.7 with the patch, 30 terminal windows opened
>     and closed: KWin created 298 udmabufs and 296 were freed (the other
>     two were still in use), drm_prime_gem_destroy() ran for 85 imported
>     objects, and the pin counters, slab usage and dma-buf census went
>     back to their baseline;
>   - builds without warnings with W=3D1 on drm-misc-fixes (e78a9fb).
>
> Two related leaks on the same desktop, to be reported separately:
>   - Mesa's kms-dri-sw winsys releases GEM handles with MODE_DESTROY_DUMB,
>     which is EACCES on render nodes, so a compositor rendering with
>     llvmpipe on a render node leaks the handle of every imported buffer
>     (KWin up to 6.7.4; 6.7.5 falls back to the KMS node);
>   - vmw_buffer_prime_to_surface_base() creates a GEM handle the caller
>     never sees and WARNs for every foreign dma-buf.
> With this fix those leaks last until the owning process exits; without
> it they pin memory permanently too.
>
>  drivers/gpu/drm/vmwgfx/vmwgfx_bo.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> index 9c7a73c..f226b32 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> @@ -31,6 +31,7 @@
>  #include "vmwgfx_resource_priv.h"
>
>  #include <drm/ttm/ttm_placement.h>
> +#include <drm/drm_prime.h>
>
>  /**
>   * vmw_bo_free - vmw_bo destructor
> @@ -69,6 +70,8 @@ static void vmw_bo_free(struct ttm_buffer_object *bo)
>                 vmw_surface_unreference(&vbo->dumb_surface);
>         }
>         WARN_ON(!RB_EMPTY_ROOT(&vbo->res_tree));
> +       if (drm_gem_is_imported(&vbo->tbo.base))
> +               drm_prime_gem_destroy(&vbo->tbo.base, vbo->tbo.sg);
>         drm_gem_object_release(&vbo->tbo.base);
>         WARN_ON(vbo->dirty);
>         kfree(vbo);
>
> base-commit: e78a9fb7a40c55ec2a70ae39903dde4f898af2ef
> --
> 2.55.0
>
>

--00000000000023a50d065ccec4f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sorry this was a dupe and is superseded=C2=A0by=C2=A0Micha=
l TOMAs work here: <a href=3D"https://lists.freedesktop.org/archives/dri-de=
vel/2026-September/595772.html">https://lists.freedesktop.org/archives/dri-=
devel/2026-September/595772.html</a>=C2=A0</div><br><div class=3D"gmail_quo=
te gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep=
 29, 2026 at 5:02=E2=80=AFPM Adam Lewis &lt;<a href=3D"mailto:adam.j.lewis@=
gmail.com">adam.j.lewis@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">vmw_prime_import_sg_table() creates a BO f=
or a foreign dma-buf through<br>
drm_gem_prime_import_dev(), which attaches to the dma-buf, maps the<br>
attachment and takes a reference on it.=C2=A0 vmw_bo_free() never undoes<br=
>
this, so each foreign import leaks the attachment, its sg table and the<br>
dma-buf reference, and the exporter&#39;s pages stay pinned after the GEM<b=
r>
handle, the DRM file and the importing process are gone.<br>
<br>
Any client that can open a render node and obtain a dma-buf from<br>
another exporter (udmabuf, V4L2, another DRM device) can pin memory<br>
without bound.=C2=A0 KWin does so on its own in VMware guests: it wraps<br>
wl_shm client buffers in udmabufs and imports them, leaking gigabytes<br>
within days.<br>
<br>
Call drm_prime_gem_destroy() for imported objects before releasing the<br>
GEM object, as amdgpu, radeon and nouveau do.=C2=A0 vmw_bo_free() is TTM&#3=
9;s<br>
destroy callback, so TTM is done with the reservation object shared<br>
with the dma-buf by then.<br>
<br>
Tested on 7.1.13 and 7.2.7 with a udmabuf import reproducer and on a<br>
Plasma desktop, where KWin&#39;s imported client buffers are now released.<=
br>
The leak was found and the fix written with the help of an LLM coding<br>
assistant.<br>
<br>
Fixes: b32233accefff (&quot;drm/vmwgfx: Fix prime import/export&quot;)<br>
Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank">stable@vger=
.kernel.org</a><br>
Assisted-by: Claude:claude-fable-5.1<br>
Signed-off-by: Adam Lewis &lt;<a href=3D"mailto:adam.j.lewis@gmail.com" tar=
get=3D"_blank">adam.j.lewis@gmail.com</a>&gt;<br>
---<br>
Notes (dropped on apply):<br>
<br>
Security note: per Documentation/process/threat-model.rst an unprivileged<b=
r>
user must not be able to make the system unresponsive through unbounded<br>
resource exhaustion.=C2=A0 On a default systemd desktop every logged-in use=
r<br>
has a render node (0666) and /dev/udmabuf (uaccess ACL), which is all<br>
this needs, and the pinned memory survives the triggering process.=C2=A0 Th=
e<br>
bug was found with AI assistance, so per security-bugs.rst it is treated<br=
>
as public and the reproducer is not attached (available privately).<br>
A CVE request will follow once the fix is in a released kernel.<br>
<br>
Environment: VMware Fusion on an Apple M3 Max host, Fedora 44 aarch64<br>
guest, vmwgfx 2.21.0, no swap.=C2=A0 Found on 7.1.12/7.1.13 (Mesa 26.1.8,<b=
r>
KWin 6.7.4), confirmed on 7.2.7 (Mesa 26.2.3, KWin 6.7.5).=C2=A0 The import=
<br>
and destructor code is unchanged from v7.1 through v7.3-rc5 and current<br>
drm-misc-fixes; b32233accefff went to stable # v6.6+.=C2=A0 Not the same<br=
>
issue as f739416dc555 (&quot;drm/vmwgfx: drop dma_buf reference on<br>
foreign-fd prime import&quot;), which covers ttm_prime_fd_to_handle()&#39;s=
<br>
error path and was already in the kernels tested.<br>
<br>
How it shows up: KWin wraps every wl_shm client buffer in a udmabuf and<br>
imports it into vmwgfx, for scanout and, when it renders with llvmpipe<br>
because svga reports &quot;No 3D enabled&quot;, as a texture.=C2=A0 Every i=
mport<br>
leaked, so every client buffer stayed pinned: ~6 GB after a few days on<br>
7.1.=C2=A0 debugfs bufinfo then listed 961 live udmabufs, 954 of them still=
<br>
attached to vmwgfx, while kwin_wayland held 35 dma-buf fds.=C2=A0 On an<br>
unpatched 7.2.7 boot, nr_foll_pin_released did not move at all in four<br>
hours of desktop use, while MemAvailable fell to 2.8 of 24.5 GB.<br>
<br>
Testing:<br>
=C2=A0 - reproducer (udmabuf -&gt; PRIME_FD_TO_HANDLE -&gt; GEM_CLOSE -&gt;=
 close the<br>
=C2=A0 =C2=A0 dma-buf -&gt; close the DRM fd): unpatched, the dma-buf outli=
ves the<br>
=C2=A0 =C2=A0 process with refcount 1 and vmwgfx still attached; patched (7=
.1.13<br>
=C2=A0 =C2=A0 and 7.2.7), the pins are released as soon as the dma-buf fd i=
s<br>
=C2=A0 =C2=A0 closed;<br>
=C2=A0 - imported framebuffer: ADDFB2 + SETPLANE on/off + CLOSEFB through t=
he<br>
=C2=A0 =C2=A0 screen-target path on 7.1.13, and ADDFB2 + CLOSEFB on 7.2.7, =
both<br>
=C2=A0 =C2=A0 release cleanly;<br>
=C2=A0 - Plasma desktop on 7.2.7 with the patch, 30 terminal windows opened=
<br>
=C2=A0 =C2=A0 and closed: KWin created 298 udmabufs and 296 were freed (the=
 other<br>
=C2=A0 =C2=A0 two were still in use), drm_prime_gem_destroy() ran for 85 im=
ported<br>
=C2=A0 =C2=A0 objects, and the pin counters, slab usage and dma-buf census =
went<br>
=C2=A0 =C2=A0 back to their baseline;<br>
=C2=A0 - builds without warnings with W=3D1 on drm-misc-fixes (e78a9fb).<br=
>
<br>
Two related leaks on the same desktop, to be reported separately:<br>
=C2=A0 - Mesa&#39;s kms-dri-sw winsys releases GEM handles with MODE_DESTRO=
Y_DUMB,<br>
=C2=A0 =C2=A0 which is EACCES on render nodes, so a compositor rendering wi=
th<br>
=C2=A0 =C2=A0 llvmpipe on a render node leaks the handle of every imported =
buffer<br>
=C2=A0 =C2=A0 (KWin up to 6.7.4; 6.7.5 falls back to the KMS node);<br>
=C2=A0 - vmw_buffer_prime_to_surface_base() creates a GEM handle the caller=
<br>
=C2=A0 =C2=A0 never sees and WARNs for every foreign dma-buf.<br>
With this fix those leaks last until the owning process exits; without<br>
it they pin memory permanently too.<br>
<br>
=C2=A0drivers/gpu/drm/vmwgfx/vmwgfx_bo.c | 3 +++<br>
=C2=A01 file changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vm=
wgfx_bo.c<br>
index 9c7a73c..f226b32 100644<br>
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c<br>
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c<br>
@@ -31,6 +31,7 @@<br>
=C2=A0#include &quot;vmwgfx_resource_priv.h&quot;<br>
<br>
=C2=A0#include &lt;drm/ttm/ttm_placement.h&gt;<br>
+#include &lt;drm/drm_prime.h&gt;<br>
<br>
=C2=A0/**<br>
=C2=A0 * vmw_bo_free - vmw_bo destructor<br>
@@ -69,6 +70,8 @@ static void vmw_bo_free(struct ttm_buffer_object *bo)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmw_surface_unrefer=
ence(&amp;vbo-&gt;dumb_surface);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 WARN_ON(!RB_EMPTY_ROOT(&amp;vbo-&gt;res_tree));=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (drm_gem_is_imported(&amp;vbo-&gt;tbo.base))=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_prime_gem_destr=
oy(&amp;vbo-&gt;tbo.base, vbo-&gt;<a href=3D"http://tbo.sg" rel=3D"noreferr=
er" target=3D"_blank">tbo.sg</a>);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_gem_object_release(&amp;vbo-&gt;tbo.base);<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 WARN_ON(vbo-&gt;dirty);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(vbo);<br>
<br>
base-commit: e78a9fb7a40c55ec2a70ae39903dde4f898af2ef<br>
-- <br>
2.55.0<br>
<br>
</blockquote></div>

--00000000000023a50d065ccec4f9--
