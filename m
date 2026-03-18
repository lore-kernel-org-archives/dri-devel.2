Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293B910854DC
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:42:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F7D310E790;
	Wed, 18 Mar 2026 09:42:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ernGxS1b";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23A4C10E78F
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:42:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D374543D43
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47E2C19424
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773826968;
 bh=RJwoWtZrXCLEGDUgWgO2HEC3zfLTFC1Z5mRLSoWhmDY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ernGxS1bQ9J+880VR06GxPkNTKnZeMBWqIgSaIzFIm+vD3TolFZE+nFn+hKzF9A+n
 DaKpbmECQNopQ3lqNQmAVs/EfYiYtxCZhKPBhsxYofHFBOe+OSiIWnioWXdcUEHWNA
 sS2tVF9fymvFNR1GMoOoKI5IygSyYpmiy/IQK7ACnjL5Z0KPgg5v902LKBeh9Fuf1W
 nNj7Q9379x5g9IEoZlnv/gpMmgmvdIwVvuFf45hFEZ+BZrpP7FUuQ1e77m8HTXdAOi
 PNKuB+my+xxozJbFaY8+y9nXHuVlaQT0R7VVhthzRguJB0YOTTevBKNEnSqIfWa0vD
 y9jWREwcqvf8A==
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6674cba2c50so1088179a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 02:42:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUlPp1OfbMrbHW9DWF+ndT3zzQvTjwYeXRAktIYYuCLE61kRMzQjVvnrh8/joO/8iAwvrOChpKRE/k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwO65/JVzLH0I1AWO4Je944YJCKaDuLkmpCA+DbptJqyJi+Kw5p
 rBvoOVKpI6SnG26lk7WUS/hDTmT4Vx22+Ii76xInzJ0LtKiL6Jb46CAaP18ZwRamJ6t4QCbKUHy
 u1/T+Tav/kKKl043+mzlF6Kf8/PZqD9Y=
X-Received: by 2002:a17:907:94c8:b0:b97:66cc:1b2b with SMTP id
 a640c23a62f3a-b97f1c803aamr204589666b.23.1773826967249; Wed, 18 Mar 2026
 02:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260318092349.11651-1-lvjianmin@loongson.cn>
In-Reply-To: <20260318092349.11651-1-lvjianmin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 18 Mar 2026 17:42:41 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5hcnGAE2xYU-eKuWWCyJkW5mfn_wyS49_MTpz5K+8zEw@mail.gmail.com>
X-Gm-Features: AaiRm52kL_gsnb_HtNI_kVXh6aan5pO-qbordrOfzDCgN6mzPWZE2UQQuoNaivM
Message-ID: <CAAhV-H5hcnGAE2xYU-eKuWWCyJkW5mfn_wyS49_MTpz5K+8zEw@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: Update GPU driver maintainer information
To: Jianmin Lv <lvjianmin@loongson.cn>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>,
 Xuefeng Li <lixuefeng@loongson.cn>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Thanks for the invitation and will try my best to help, too.

BTW, please spend some time to review this patch:
https://lore.kernel.org/dri-devel/c6013f25-fce0-41ba-a275-96188a6647c1@suse=
.de/T/#t

On Wed, Mar 18, 2026 at 5:31=E2=80=AFPM Jianmin Lv <lvjianmin@loongson.cn> =
wrote:
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
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Acked-by: Huacai Chen <chenhuacai@kernel.org>


>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 96ea84948d76..4232039b7282 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8626,8 +8626,13 @@ F:       drivers/gpu/drm/lima/
>  F:     include/uapi/drm/lima_drm.h
>
>  DRM DRIVERS FOR LOONGSON
> +M:     Jianmin Lv <lvjianmin@loongson.cn>
> +M:     Qianhai Wu <wuqianhai@loongson.cn>
> +R:     Huacai Chen <chenhuacai@kernel.org>
> +R:     Mingcong Bai <jeffbai@aosc.io>
> +R:     Xi Ruoyao <xry111@xry111.site>
>  L:     dri-devel@lists.freedesktop.org
> -S:     Orphan
> +S:     Maintained
>  T:     git https://gitlab.freedesktop.org/drm/misc/kernel.git
>  F:     drivers/gpu/drm/loongson/
>
> --
> 2.20.1
>
