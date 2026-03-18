Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7285EFCD0C9
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:40:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C940110E095;
	Wed, 18 Mar 2026 07:40:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D+2jYlBn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3C2A10E095
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:40:25 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9620143FA2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5C1C2BC9E
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773819625;
 bh=JgK7SxH+kH7lGrQxfrx+YSzSPHXSeNf32GZyGa0Ve4c=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=D+2jYlBnvDfDqgsAn+2OyEQPSlOIK2K9vXIDOA0IdWdMDwI/XHXezbr+jfPtNrIrV
 Dkk1XMSPMzskn3Imb3Lkn68uZqg/onkXwoEODeo8uLnMfd6ZNmYxVXj8NREwz5tOPo
 bd7lwojhqi2GjXE2WSOIjRmPbAL98EGGmWfCCSQx3SxmU5zVe1Cf/Aey0atkKL2LX3
 OrwBwnMICUtYUUz3My3yJrw/eTMVwtR6S4+pAn1nDcvdz7wyC7yGDbcIRU8YBgIPDh
 kOL7V1Hc7GPuW6QEwbOXzRs4aAVUHk/2UKTna/Egajqf8KhYnzS2BIuftuuWHStMtw
 jpPgY/xSB+2iQ==
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-b9793fa5371so499039566b.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 00:40:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVOY0FV0wQPJ7NKl84SNM9cTLwKKUkJLu7M7ZntaiorGYfAIAbMudSZBu3OGrMyH9Sz++jHpZbYYw8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9dmMn+S//WzdZ6xo+HmMliCGk41jDENqMGqWlK1juWO4S/LCA
 Kb8lHuiEoMXP7sycPRd3GvMkdAWjKoWgzoaCJSx/SlPhVvFiBgKBYF9AAAIe760FOLVrYCROVzm
 6PF1rjCwIwPGj3394nOvLEPWCC6r0PKg=
X-Received: by 2002:a17:906:b198:b0:b97:b2dc:91e2 with SMTP id
 a640c23a62f3a-b97f48f890bmr91326466b.16.1773819623775; Wed, 18 Mar 2026
 00:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260318071307.3682-1-lvjianmin@loongson.cn>
In-Reply-To: <20260318071307.3682-1-lvjianmin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 18 Mar 2026 15:40:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7PmqY_cbU7Kp-DOL+H_urD45-8CR1kJsXXUoJ4DXgtqg@mail.gmail.com>
X-Gm-Features: AaiRm51jtGA7jmUTN5Hg2a1wqA2ZXeDezzNyntTmBpmpNKF8fiOMvTrd1DrJ_hA
Message-ID: <CAAhV-H7PmqY_cbU7Kp-DOL+H_urD45-8CR1kJsXXUoJ4DXgtqg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update GPU driver maintainer information
To: Jianmin Lv <lvjianmin@loongson.cn>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>, 
 Xuefeng Li <lixuefeng@loongson.cn>, dri-devel@lists.freedesktop.org
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

Hi, Jianmin,

On Wed, Mar 18, 2026 at 3:20=E2=80=AFPM Jianmin Lv <lvjianmin@loongson.cn> =
wrote:
>
> From: lvjianmin <lvjianmin@loongson.cn>
>
> I and Qianhai are GPU R&D engineers at Loongson, specializing
> in kernel driver development. We understand that the current
> Loongson GPU driver lacks dedicated maintenance resources
> because of some reasons.
>
> As Loongson GPU driver developers, we have both the capability
> and the responsibility to continuously maintain the Loongson
> GPU driver, ensuring minimal impact on its users. After internal
> discussions, our team has decided to recommend me and Qianhai
> to take over the maintenance responsibilities, and recommend
> Huacai, Mingcong and Ruoyao to help to review.
>
> And We'll continue to maintain it for current supported chips
> and drive future updates according to chip support plan.
>
> Signed-off-by: lvjianmin <lvjianmin@loongson.cn>
Congratulations and thank you for inviting me as a reviewer, but
please re-submit the patch on top of upstream repo.

Huacai

>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 837db4f7bcca..b4d7c4089e95 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8626,9 +8626,13 @@ F:       drivers/gpu/drm/lima/
>  F:     include/uapi/drm/lima_drm.h
>
>  DRM DRIVERS FOR LOONGSON
> -M:     Sui Jingfeng <suijingfeng@loongson.cn>
> +M:     Jianmin Lv <lvjianmin@loongson.cn>
> +M:     Qianhai Wu <wuqianhai@loongson.cn>
> +R:     Huacai Chen <chenhuacai@kernel.org>
> +R:     Mingcong Bai <jeffbai@aosc.io>
> +R:     Xi Ruoyao <xry111@xry111.site>
>  L:     dri-devel@lists.freedesktop.org
> -S:     Supported
> +S:     Maintained
>  T:     git https://gitlab.freedesktop.org/drm/misc/kernel.git
>  F:     drivers/gpu/drm/loongson/
>
> --
> 2.31.1
>
