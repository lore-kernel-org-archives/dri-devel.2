Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A69FCA9EBD
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 14:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A531B10E031;
	Sun, 11 Oct 2026 14:04:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q4W4xec9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADBBC10E031
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 14:04:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9A66E601DB
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 14:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533E31F0089D
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 14:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791727443;
 bh=86pWPhLv9adWOQ1oVMYMQWf73TNhvR4D25U83YvJRXk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=Q4W4xec9m/VHOuiG3KnYHd2gtbv11XoCyhIIjdFiPQ3wyinY9CbDqE5SmCdVMSqcE
 TXT6m/13swQ+bs5M/5+S5/Z1DMFAHcJE3OOyVqmi8Y60tI8scQUm95FvyUH4PWKJun
 +U+87pw3NoMFk1g4pyNPHYAHexQI9vZtKEeQGplYF7cjld7f/K4gS7apga9g6Sv4Rh
 4fSYJ8p13RhIxpguIjscDcDkfM1mlBf5OiDfqVvyWMl+r/RBZTpbbnCzRzH07dNmpE
 QNbK6PP6tQg3o8EaAxIVGWZjC7dsVzzVPs4SQOqaFQmKy5jKXgEFRWQfLYsliTxvti
 02u+IM/Tambmw==
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6af9a9451daso1670776a12.0
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 07:04:03 -0700 (PDT)
X-Gm-Message-State: AFq9FYK/KYEVNXamdQ0kXLLozalbmW9nYBT2f9AFJKt/cdBA12jYX3u3
 1xZRKQ9q3E8MTCepkz8xRVDWsrckI9fLHCjyYXpL/8H0CGo3f4ahTXICiEpsEv6fLydm3NtiQd7
 5fALq4f+ixYWsFMGB5Yf9paMkDO07bos=
X-Received: by 2002:a05:6402:304a:10b0:6b1:b5b8:b696 with SMTP id
 4fb4d7f45d1cf-6b1b5b8b911mr909603a12.23.1791727441955; Sun, 11 Oct 2026
 07:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20261003093415.e64386de1e64-1-archwse@gmail.com>
In-Reply-To: <20261003093415.e64386de1e64-1-archwse@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 11 Oct 2026 22:03:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5bHA_MZGsA7=udMTiM57wqG-nQMbak+afeq3+CvVcBcA@mail.gmail.com>
X-Gm-Features: AclHuK__mYheWRSoDKQ5OBLHeWz1vxxNsOg4UblzjX9eWNRSrtJhbuLE3srtb7Y
Message-ID: <CAAhV-H5bHA_MZGsA7=udMTiM57wqG-nQMbak+afeq3+CvVcBcA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/loongson: Fix double free on BO initialization
 failure
To: Evanshenf <archwse@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Jianmin Lv <lvjianmin@loongson.cn>, 
 Qianhai Wu <wuqianhai@loongson.cn>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Sui Jingfeng <suijingfeng@loongson.cn>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Oct 3, 2026 at 5:35=E2=80=AFPM Evanshenf <archwse@gmail.com> wrote:
>
> If ttm_bo_init_validate() fails, it drops the buffer object's reference
> and cleans it up through the supplied destroy callback. lsdc_bo_destroy()
> releases the GEM object and frees the enclosing lsdc_bo, so freeing it
> again in lsdc_bo_create() causes a double free on a synchronous failure
> path.
>
> Let TTM own the cleanup after initialization has started and return the
> error directly. Keep the explicit free on drm_gem_object_init() failure,
> which occurs before ownership is passed to TTM.
>
> Tested on LS7A2000 by making drm_vma_offset_add() return -ENOSPC for one
> selected dumb-buffer creation. The error reached userspace, the destroy
> callback ran once, and no handle was published or tracked BO retained.
> Normal buffer creation, zeroing, mapping, readback and release passed.
>
> AI assistance was used for the ownership analysis, fix, fault-injection
> tools, build and test execution.
>
> Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controller=
")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

> Signed-off-by: Evanshenf <archwse@gmail.com>
> ---
>  drivers/gpu/drm/loongson/lsdc_ttm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/loongson/lsdc_ttm.c b/drivers/gpu/drm/loongs=
on/lsdc_ttm.c
> index d7441d9..88536e2 100644
> --- a/drivers/gpu/drm/loongson/lsdc_ttm.c
> +++ b/drivers/gpu/drm/loongson/lsdc_ttm.c
> @@ -475,10 +475,8 @@ struct lsdc_bo *lsdc_bo_create(struct drm_device *dd=
ev,
>
>         ret =3D ttm_bo_init_validate(bdev, tbo, bo_type, &lbo->placement,=
 0,
>                                    false, sg, resv, lsdc_bo_destroy);
> -       if (ret) {
> -               kfree(lbo);
> +       if (ret)
>                 return ERR_PTR(ret);
> -       }
>
>         return lbo;
>  }
>
> base-commit: bca45af5998a05f34b13a2ef11e639bac9c62643
> --
> 2.43.0
>
