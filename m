Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC7CC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 21:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11D5B10E538;
	Tue,  8 Sep 2026 21:39:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H9GwX1N0";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B7B210E196
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 21:39:46 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396672b2565so970036a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 14:39:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788903585; cv=none;
 d=google.com; s=arc-20260327;
 b=mDgFTRet52+e4iNUlvPLNnNQXXd4wNgX+KHyATe3pKC1osmYSfuZxN5uXaY1SO7DuP
 GKvokuhEs/nN6GRC9LCueseAZkOHCEE+HHwUABN1HiwPcOpSy+ZAbuxrUm/OadwRjO6x
 V6peiNFP9siEU512gks5ynAp1TGnf/EaMAT15CvbHImgkKmKTbINP766nAgCnUG2kZOV
 bl8Y/Z2xqJ8is1YMJ1G4FQkPb9RYOtYgva+Jn9EUfFLOe9qs5QXsVDkxnsyjE43FQ9T5
 oaMeQ4ij09a3EQ9bb1n4+Pnz5uqJW8Aa5ks/z8TLJxUUP8H+b90YYMypH9ai0quHmSkt
 cgbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pfd3T0qT87+D34AEThHxdn2D1F0SWsx0LtE8mR8K1j8=;
 fh=88jsyxSIxIXMoahsFoF+toyxa75dSXdxE+NiPM0mykI=;
 b=QOFIGNoFxUsz2HtqXcuepmWdIWFt+BBMSGCAOAELhj3RiOzEMyPFnYPv+53LAez+Bl
 Zla7gTczvx2rvkh0xH0i31V/kHNnTR83UjOc+ewTmei5X7eBgdWxd5uqnQjKA6P6d4v/
 Uc+x06R4CfjcAVI54uBGlfuEEE4elTc9DypzE1Z7v3CqRMZSgzaw2njUqjEIAK5qiOic
 Ua0bfD9qDHXP6jaxgAHT7ceATUUZbd2DBIFjDaqDt/ozVWguOihoAymfPu1MTIDDILRL
 GJUiyZWd2T26M9PSQgM5vvQ79IXqsSsfyxSwjH998cWX9MVll/rUwoafT63e55Fyj1xm
 50Ag==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788903585; x=1789508385; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pfd3T0qT87+D34AEThHxdn2D1F0SWsx0LtE8mR8K1j8=;
 b=H9GwX1N02ymZQ/3YJ1eJ6pV6bsdEBEsYmf/paVZoan4FhpIt8bo0hDRzf4MGh70AET
 rdAlBSftyQxc0HBYfppds8ZW9RVugbLEN1ICADOKUtCpWz4Hwh0LnVyPzis2egcZYpEx
 DG9TXnH/75KJOIYxk/a7BNVxVSLCmOrtP/At3ZHF2n1P8Lqbq5gDhanqiuDvYbuRtiuC
 lv6NdjCuc2z9KRIRCDvgvhYhoVAq/g5lZUdPC/yDC6RaD4neEroDpOs0WGIgBdshvV6F
 I3gWQAqn3cnBG12eAoMgXZ+3ZQpiC15l3mi0LrP+BzFWr4LOJfHD+OIkX+eO9SWbuDqY
 N7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788903585; x=1789508385;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pfd3T0qT87+D34AEThHxdn2D1F0SWsx0LtE8mR8K1j8=;
 b=ImJwB0a9mW+1dYnI2noPLD+XXv92JHCR+UX6/nw8owy5zV7zUgA6QPhp6NA9pIDOO2
 D3hLlu3zbvTiMt1qk/FJ/sfCTNGHNqbb4Liu1Zw9pYCvGLmB3KWL3tQh9wuyee4xio1M
 D8sJ6Y9jWwg4SdmlMaoVDsmppda31ag1K1KTihdMiZMkDNbbgwB+ydDVChrXOFvvyP9g
 s0hA5ypNFJVCWbix9RbrK9zf7iXj4SaekWniUnPelpsW6kBW1LXVtKFljz0tCIAl83hh
 9cc/TZ3TQnLkIzgw7xxwhYMCqfuoNJffze1tx0r/jNtUH7PXT3oAG+nbpcga+ja0GJTT
 YTSA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlqRIE6P/Dog6ccDq/yw5QIx2iS00mpiETEiZhSiDnTEcwn3aOXKxgLrtRSmjWdsG8ipQj0nI6R6E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nG+dds7LmUKifVp28HFzAnx0runuv/AjfxqrAkBp1RTlc/gei1
 mLR5/DPAWoqudmv/X2ehcvGz9OYshH+csv2g464D4XWEQGdsRgMuBKMOvNlmkbEBdEVitFnITrh
 g1yzopOe9UzydM052j/qrAQy9aabqDaU=
X-Gm-Gg: AYBFou0Dzgis4ZWYxwcwNWjT3vTdg6mzGFXjVO9rWyU26I4qp8zVHlKylFnRJYYiuri
 9BaoZN6fEGZIIvN9QJ8cNxwra/B1ck0wRKXUsK8Xhzipaj5tDmnh7VcDqhox+XPNucS6woXf15V
 ahq0Vjvcx5hAnezc9baTL9YnLiWvFA+G4PQGtCSEybyZSnN9nifQLqdH8NLSfDUefqgvVEKLa+/
 Jlmsw8kExiJPig7/5xdRHncYHXBLkY9E2+BqeJ6tZOwXM0PIEdUUkjciC5nxPiPaITdbuI+PhS/
 gY2xGspxkm+wazXoiUTe7nZmDZwJH35k5GCOXooA9kXzWmV53diMG7pvXy55w/TqYxJHsznnWaf
 21KEtNoFnqfbql5gxU0GqW4APkKS2kl4=
X-Received: by 2002:a17:90b:4c03:b0:398:bac7:72d0 with SMTP id
 98e67ed59e1d1-39b3d86acf2mr22472586a91.5.1788903585475; Tue, 08 Sep 2026
 14:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260908-amdgpu_debugfs-v1-1-3b659e744691@igalia.com>
 <20260908201504.5C9411F00A3D@smtp.kernel.org>
In-Reply-To: <20260908201504.5C9411F00A3D@smtp.kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Sep 2026 17:39:33 -0400
X-Gm-Features: AcwNN1XiQcxZYZn6Y_zxh-cC1A3b-Ks9xObBstzBva-di-BAV7A8YC7qh__1sb8
Message-ID: <CADnq5_NkuyG_dmVeTzSe41F_8CHjiy4Nh0WH6DjDYx78jpjYLg@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amdgpu: debugfs: avoid extra EOLs in
 amdgpu_gem_info"
To: sashiko-reviews@lists.linux.dev
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Tue, Sep 8, 2026 at 4:20=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] NULL pointer dereference when printing imported BOs in debugfs.
> --
>
> commit be759dc89504ad9041bef159ec02b120e04cf61b
> Author: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>
> Revert "drm/amdgpu: debugfs: avoid extra EOLs in amdgpu_gem_info"
>
> This commit reverts an earlier change that removed newlines when no fence=
s
> were attached to a dma_resv struct. The original change caused multiple B=
Os
> to be printed on the same line, reducing debugfs readability.
>
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.c
> > index 5d9d137209b6f..1b6c32a177fb6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > @@ -1701,9 +1701,8 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo=
 *bo, struct seq_file *m)
>
> [Severity: High]
> This is a pre-existing issue, but can the access to dma_buf->file cause a
> NULL pointer dereference?
>
> In amdgpu_bo_print_info(), earlier in this function:
>
>         dma_buf =3D READ_ONCE(bo->tbo.base.dma_buf);
>         attachment =3D READ_ONCE(bo->tbo.base.import_attach);
>
>         if (attachment)
>                 seq_printf(m, " imported from ino:%llu", file_inode(dma_b=
uf->file)->i_ino);
>
> If attachment is non-NULL, dma_buf is dereferenced via
> file_inode(dma_buf->file)->i_ino.  However, bo->tbo.base.dma_buf can be N=
ULL
> for imported BOs in several scenarios:
>
> - BOs imported via amdgpu_gem_prime_import() allocate a fresh GEM object
>   via amdgpu_dma_buf_create_obj(), which does not populate obj->dma_buf
>   and relies entirely on obj->import_attach.
>
> - When userspace closes the GEM handle of a BO,
>   drm_gem_object_handle_put_unlocked() calls
>   drm_gem_object_exported_dma_buf_free(), explicitly setting
>   obj->dma_buf =3D NULL, even though the BO itself may still be kept aliv=
e
>   if it is mapped.
>
> When debugfs iterates over these BOs, reading dma_buf->file dereferences =
a
> NULL pointer.  Since this can be triggered by reading debugfs files like
> amdgpu_vm_info, could this deterministically oops the system?
>
> >       if (dma_resv_trylock(bo->tbo.base.resv)) {
> >               dma_resv_describe(bo->tbo.base.resv, m);
> >               dma_resv_unlock(bo->tbo.base.resv);
> > -     } else {
> > -             seq_puts(m, "\n");
> >       }
> > +     seq_puts(m, "\n");
> >
> >       return size;
> >  }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-amdgpu_d=
ebugfs-v1-1-3b659e744691@igalia.com?part=3D1
