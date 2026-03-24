Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C47F54AAD
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 050AA10E666;
	Tue, 24 Mar 2026 13:11:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gXbZm1cF";
	dkim-atps=neutral
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A581B10E666
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 13:11:36 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-1273c690e5bso499014c88.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 06:11:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774357896; cv=none;
 d=google.com; s=arc-20240605;
 b=kkVS7LDRvkgAxj4rY9zasv4AYRn7r4dbdW6/kCWs9NsC6tVH+XwMmXw/vodvd/NSJL
 umWVWX39+xYHhAc75sWoBOG3LWpGXYRzum1mncxjcyK3g2J8E15XscEKGmQjwdJap8Lw
 smoxhwLKClJWju1Mas4vJNSDWVK59I2tNcs03/1GxaXNc2UPRP/9emD+Jg1rWdo8UgEi
 1iz9QOY2/Md70+D+A/nExxjAubi5m4sjipHXCl5JMgOhJtM3XZ5raj3KUMRYiLAHeqoi
 uhPnPrIeFpUujfKQC/LizuGRe3P0xEUhRc8vhhJcUxy/Chy3hsxhOqcCqHOsWf25iDLg
 UvuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HQZx/kvnFzJcbke4KxeXmKPQO4Our1sxl7Tf5UayGA8=;
 fh=hsAOzJvqExl2KA8vonHwfdRwLyZe/THQFBa9lzJpO4M=;
 b=aiOAPSMfY49NN1Q7fdwo8guZa0Ta85ewyG7mmGZzGrELjdmbxrHxm8+UN76WyjAY20
 dTjif9kXfXr6bqS5w2RBNXJH8B0MdnYr+QORnpqeddG4vpgNR9pSXwZOSpkxcWQN2AiU
 eig4rmAGMduQjVF4ulzmS7ajsKrT8M5aVMR4b1a/SBTbSorudO9XAPXTMutaZEtCJNSj
 uuAnfrVkqNTj/cPDKtobX37wHfdL1WnSoXVMq5zRtXh0HBPsS95BzPDDU/U9VnBw0m8S
 nw+uFKUV6TdGeBFkVk9GhKRy+OGZdSYmK9J0HZUrKxouHQMCqUvJ2cskKwmHt7/BuTll
 5QhA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774357896; x=1774962696; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HQZx/kvnFzJcbke4KxeXmKPQO4Our1sxl7Tf5UayGA8=;
 b=gXbZm1cFP1GEQ3arec9DgjTty+IDH/MhsytHeno37+85yCPB1/CoNFbfprlwopSpD+
 CxNFyIKGtZF2RiL/PEhxjGPr8wgFc92SqMmyHMV1Q31S/Gz+s9XDiNAfZBCHMKDvDcRo
 9zEeieitLoaYC/oUsvfWTiairu93uyWyxyj4lszBz1epjK/MV1y7ZPaJJQXTEzJ6Kkcb
 p0daMHgZPPX/vkbGKhCFvxZ/nly3woixFPGAi+MFJcZrVkqvg1cQDqZRRSezx2ZE4Ct3
 Bsf5X7gVjsDOVAsCHe/4GCfkbfy0CThfdp6JWzh1K9raTDkIZ3nX2fc3gIkdzOikSz/p
 9DrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774357896; x=1774962696;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HQZx/kvnFzJcbke4KxeXmKPQO4Our1sxl7Tf5UayGA8=;
 b=UmcEo0SONDQKhMzXq7i65TppG0cLPQwUVYaZbRoHDEgaPlqP3r57hmdkk6/kZbtf1R
 ndUutkKNtaX6b9dUuGlMv2cv00Oh0wOtmxk1znUEGxFlK9238bYIDPeF7OlZh7rBmoHH
 p0FcmJeYHGWNz/xMUjtvrnOsLdSPvzC6TvPUZTTRefCNnOzfChqUQU2KQ0+52/iEi6n+
 19Rzxv59aKeSq3vKc4KzpqnGbzzMwyfSLLWqh9Yu/r8PSV49p0ZrpSNnYzCbDZcy6lXB
 aumX5Vtn6517E8b5cJd9v0KdqZBodC+ENuFOXpVB+fpAdEtbOBqv37qKskiZbrrNGqXc
 GbYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUM71VlIFoRtMgfbUP3K8JfXOrRy+HSIcZs2YXJKDafkjykg5j0lv1uQBTAENl8LJN87YEYVE9ll8w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzrTO+99SMLX6aUlfO9nXdd0zmFpcXwPfp65wAQFj4EMSouIsHr
 om6tVbWFvSq0PVecraM+GEk065RjixI+qSLU5c8lsIbZDm5//BcpDkFGG+6R926sfehulICQeq7
 OIkgh9K/G5OBQ2C2f0nHg3NJtIZVR2+1DHg==
X-Gm-Gg: ATEYQzzsAAsdE8mklV4EOomOQ+jNk/siDv9hzXeYMEDbSmbOOyBbwVlzsyLlkYt1rs4
 +MZDA7tbATxnfqNiV/I2aST5VjO7g65iHX2fUvktGq8jmlkI/04kcRnGYk2RZt0PyevVGNHqUpX
 4kQVBP7s6VtFRFFsBf1qNi4jrGzD8FwYp9JH98k/nchLdza6iBCEvwG75nByibtdfYJJUBLLexP
 SEDFyAhoP8K8zMQBupRFB3uiuoSiAfS81S7C8w5ePLfoVcPEgV98Vw4+T8TCjjFR72PbAJ3SQqM
 tp3ml6ZfD/oqwranxBpaPCI732jTTe6n+EE6aXrfTvc4uqvrOqD4k8Iw4lXP/ffNgFWDGg==
X-Received: by 2002:a05:7022:2224:b0:128:d590:2947 with SMTP id
 a92af1059eb24-12a726c143dmr3367139c88.4.1774357895871; Tue, 24 Mar 2026
 06:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260320083247.428482-1-nichen@iscas.ac.cn>
In-Reply-To: <20260320083247.428482-1-nichen@iscas.ac.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Mar 2026 09:11:24 -0400
X-Gm-Features: AaiRm52hZWMu_Hps_nL6ZzI9xC82b-C0ijos6SKmEDSAmtR9aU33yL7mfuLLMkQ
Message-ID: <CADnq5_Ni0AUQYWT1hP2DqA0HGdDgTGPwTa4mPszbD1nNVGqA2w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/userq: convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com, 
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

Applied.  thanks!

Alex

On Fri, Mar 20, 2026 at 4:47=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote:
>
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it seems best to use ';'
> unless ',' is intended.
>
> Found by inspection.
> No functional change intended.
> Compile tested only.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 781896c9fd26..6daec964ca5e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -961,13 +961,13 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev,=
 void *data,
>         }
>
>         num_read_bo_handles =3D wait_info->num_bo_read_handles;
> -       ptr =3D u64_to_user_ptr(wait_info->bo_read_handles),
> +       ptr =3D u64_to_user_ptr(wait_info->bo_read_handles);
>         r =3D drm_gem_objects_lookup(filp, ptr, num_read_bo_handles, &gob=
j_read);
>         if (r)
>                 goto free_timeline_points;
>
>         num_write_bo_handles =3D wait_info->num_bo_write_handles;
> -       ptr =3D u64_to_user_ptr(wait_info->bo_write_handles),
> +       ptr =3D u64_to_user_ptr(wait_info->bo_write_handles);
>         r =3D drm_gem_objects_lookup(filp, ptr, num_write_bo_handles,
>                                    &gobj_write);
>         if (r)
> --
> 2.25.1
>
