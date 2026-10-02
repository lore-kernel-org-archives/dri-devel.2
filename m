Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16845CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F0D710F9B2;
	Fri,  2 Oct 2026 19:14:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OtiA6iRa";
	dkim-atps=neutral
Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com
 [74.125.229.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B519210F9A5
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 19:14:45 +0000 (UTC)
Received: by mail-dl2-f41.google.com with SMTP id
 a92af1059eb24-14a08c1a158so363187c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 12:14:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790968485; cv=none;
 d=google.com; s=arc-20260327;
 b=D79dQh0fTiBk1M8kIs0xM4CHBC3bjYfULap5sRGFsvPlKHV5W60ao91VwACfOMBViO
 /39Le8OjWLzVMpCyqBgVkejLg5GKdEcRPK35OCE91LQw0qr61Z4Z5wacC1W9qlMaGiVK
 i82UUz8c6nwz5sWyw4q5fXBp1KXmd2KKifofpHUTTu+mbIH8HLYyN/8ZEFICDsIl3uBD
 GF+L5rkiEFDrcexRm92XwBMluPqei/RCTtpJG6lt4H1Nr6lq7hpT2w9sZM2h5eNNq9rs
 kBQCC1LpBq0IP/jNIlmT4a0RNAgF0ghy7w3tzGYrl5sXAgxZl0dZxneFG2fiucyY8qmp
 EWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=voU7OB+CZXi4ZHgSiPxmOqD4lJvre4cV7SUx/WB01Kg=;
 fh=sA6c1KCrdbt8wNVgPOTK/V3Ir6O9jdoITcOPyVwJsqs=;
 b=A5psEmfPgzK4NFJe8QfY+IPCc3n/jh8QEdR17pyhAiR5i20h0A7+6SuUb/QZFQCNlZ
 ngQ2tEIrg6hkXoXMQNcJwemP4893598N9eM2BG4n5rcQbEzkj0kFdE4MnrxViyT9cgBh
 E2a6e2xD1W4xB65xKL76QNrDvkWsM01wUgIfdI/iVa3ctQglRIEww5955ZRdz8tKwbSy
 csV2ychuUl3WOqeiZDrNMs5cHAyCHxP6g2nCNLSW1bgdBVO0U5WtYcyqbdXhn7JsEZ8f
 KBv0/SVOErYyhXSIEwMAVNWvI1qONqPwVQLdo2AB5QmXVBAq2uPXiC8oy/AjCwmRLRJb
 kUHw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790968485; x=1791573285; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=voU7OB+CZXi4ZHgSiPxmOqD4lJvre4cV7SUx/WB01Kg=;
 b=OtiA6iRaiomODLYz6uSG/KFfrdbEMwJbOvX/Ml9R81lMjQWQ+sXaCrTubFs60PY//0
 likTvYbTKkINo6Bg8x2wE4sBOZyCNOQUV3k85q8PHq6UkTolL+Yt08hlql08Cc2veCxf
 DzXKZl9BwQhvE5YN7A0hYFXFoEcwOl6TfJ5Sfl2IwkuDMmJ2YVAHfAhXVGMV0lCZI+mo
 AWlFRByKNLWh/qwyc8ecFVLHi71Occy6+qs5x2UhjOxgNyTaARtCFBs3YafXHGA5FUXK
 ZrG5mT4xP2RC0zGqxDx2fXyQCbrZw7QvfPqaYXBSLKjMGuCM1ka+yHgNoJgZkQN8/lUz
 VqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790968485; x=1791573285;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=voU7OB+CZXi4ZHgSiPxmOqD4lJvre4cV7SUx/WB01Kg=;
 b=pTmjxGXre6hTuflR3up0sC/ugNKjeYQ+kmso7TpCc79R6Z9F2nT1MtD1hpRkBhmcdx
 2GjObdEQPLtEeTBGkw1beiXY/L0y8XmZi04DXpX/m6XfjNWbxmcacZb/ujmg2Nii1UNf
 If0o9pt9dAnPfq1tb0jUts6gTrwT2iI3jBGCi9eKS8ylG1TsZYt6GjLZ2KVPE03KtkYV
 bksHlzIk1qvsQZ8aj0g6nOOqohLSEPK+XttUpT67YgpmaJFXHDHjSKVycMMbo3mfQyqW
 JO1LI8bakJDfFixzNECMPEv4zCdfwBv9xp3X4S0gjudQLiGPQtU3ndw44NWc5akHnsXl
 cHtA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVbEKJo7MTCrvaCBJ8+D3YeUvyluDQP7GCBlReRSZGRfwB2eDM8xngDczXvIIugf+17ZDydzNc8lw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nP2qv7J3k+VTrAG0ddr6ngALtw0yNPUraW3wN6sMxaR3yM+2Nb
 EwrHwh/cCOVN537fSr1PtvmnqIy+H3TX5NAr8oL1lVoj3wlnCT7UbD0tDVLKkSGTRKj/QBJXgh3
 EVX8M4cg+pNNP7ghirQzpdj86QVC3OoU=
X-Gm-Gg: AYBFou3M5e2z59ZSQjTyM5xsVo3FxwT92PwYChi4ElOyyI9H6UbPmpXdWXy1oY1Edhv
 8/71LnYd5Paflf3XGECuD357It6xRxqlfUJ4o2wwyPTGQHZXVIxRU4L6Kmrrk+Gza8o15DQMTMw
 oaARH7pWko8GkWdyH564uvsDMf+xhdgHPiOLzESgeRRlNxHrYhwO8p+Bq5AQr6vaJtDi132smGo
 2S1cxAGElK2Xya5ZL4kPZkB0+Dq3W079cuU4II2k31LHu3KM0WN9LX5ybkdIn5DA+Op4DfOTCQF
 ZZBDA+ufJ0iCRe6VPWHv+XAALUF2zWVrmkQ3e/9XLMQDYe8vaN+cvvg3UV5HxwTAY+G/gNLDJFU
 3y9lHauzURFSTCJ5eMQruqhcH1ySzkXJiBXSbjFrbsw==
X-Received: by 2002:a05:7022:b04b:20b0:143:5c2a:e45f with SMTP id
 a92af1059eb24-14f56063178mr6211422c88.0.1790968484825; Fri, 02 Oct 2026
 12:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20261002022927.2023779-1-lihaojie@kylinos.cn>
In-Reply-To: <20261002022927.2023779-1-lihaojie@kylinos.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 2 Oct 2026 15:14:33 -0400
X-Gm-Features: AclHuK8PKQQPk1kESOt7OcPB_kJ58FIVMzXW3sN4fHbG7TXMREHm7ha7Ma1-Ouk
Message-ID: <CADnq5_NQBVuejzH_NbejF9TMvGOawFiVX1hfgz0CETfAfjvqHg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix dma_buf reference leak in get_dmabuf_info
To: Haojie Li <lihaojie@kylinos.cn>
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com, 
 christian.koenig@amd.com, xiaogang.chen@amd.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

On Fri, Oct 2, 2026 at 8:52=E2=80=AFAM Haojie Li <lihaojie@kylinos.cn> wrot=
e:
>
> When kzalloc fails for metadata_buffer in
> amdgpu_amdkfd_get_dmabuf_info(), the function returns -ENOMEM directly
> without calling dma_buf_put(), leaking the dma_buf reference obtained
> earlier via dma_buf_get().
>
> Fix both issues by:
> - Adding an error check after the first amdgpu_bo_get_metadata() call
> - Replacing the direct return with r =3D -ENOMEM and goto out_put to
>   ensure dma_buf_put() is called on all error paths
>
> Fixes: f54ce9e8cbd3 ("drm/amdkfd: Let driver decide buffer size at AMDKFD=
_IOC_GET_DMABUF_INFO ioctl")
> Signed-off-by: Haojie Li <lihaojie@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index 054870e9078d..ca5860e493a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -598,14 +598,18 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_dev=
ice *adev, int dma_buf_fd,
>                 /* first get metadata_size by buffer =3D NULL */
>                 r =3D amdgpu_bo_get_metadata(bo, NULL, 0,
>                                            metadata_size, NULL);
> +               if (r)
> +                       goto out_put;
>
>                 /* user buf_size is bigger than bo metadata_size
>                  * allocate a buf at kernel space and copy */
>                 if (*metadata_size <=3D buffer_size) {
>                         *metadata_buffer =3D kzalloc(*metadata_size, GFP_=
KERNEL);
>
> -                       if (!*metadata_buffer)
> -                               return -ENOMEM;
> +                       if (!*metadata_buffer) {
> +                               r =3D -ENOMEM;
> +                               goto out_put;
> +                       }
>
>                         r =3D amdgpu_bo_get_metadata(bo, *metadata_buffer=
, *metadata_size,
>                                                    NULL, &metadata_flags)=
;
> --
> 2.25.1
>
