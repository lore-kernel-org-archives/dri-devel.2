Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0525CD5BAB
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 02:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A88BB10E221;
	Fri, 22 May 2026 02:53:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X5wXTzdd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAE4910E221
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 02:53:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1AA6E44527
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 02:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11731F0155A
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 02:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779418437;
 bh=KQQbO9uIVHawRi/YOjp4KVnq7XgGe6qoi1Nu0bm/L5A=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=X5wXTzddZA4CgUagP7nTu9LG5ostqEENkFYqsHOc8JqoPnxqvojfLQ3OeYKwA9Tqw
 hZkRRv4UhfAqEjp6e2vsx3EA+d7xR7ixVP6YaARZTAy1rvk94yUCGIBOXIlgpNIB6c
 fN3flc96SgrGH3gTaeJ/DXnmb2ogRbdJFNW0viA8sG40ZshKrfSYBgnsrS3hmoYTMS
 6/XhdyIcs84Z7rdayFi9OEK9o+2ixLViq4jfAQ5e1Eo+J8PMVfLjaV9I0H7SFCFtDq
 39hOX4dch0Io3NkgBIwzeZZg0MCPhJYxHVYk4aWtVyYrkJWhLwxVkZK+gsJr81mnbL
 /QXwCaj/biCJw==
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-bd2087858c4so1371205766b.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 19:53:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8shWQepcqq2GlCarrHdd7IdCJ/AgHfz32lRf721Iubr5Em/4VS/pxHp/Y/1lyQNCyT373DBCGBQrM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSKGH8S6an5bR3sb5dgfbd9qS8OM7CGd9l+H7eIc/DwZnrch5i
 nb+mzSEHoFrEvvDh8yexpPpYPwnSmS/XBMBwIV94vf0T0O38BnV5Ul2W18jyzeWMV5kznbyvY/k
 +N2ArTrR31ag6qSjeaRtpQg/oHq8OaUI=
X-Received: by 2002:a17:907:75d9:b0:bbe:37ee:8a2b with SMTP id
 a640c23a62f3a-bdd279ce23fmr68612566b.33.1779418435725; Thu, 21 May 2026
 19:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260519073950.143287-1-yaolu@kylinos.cn>
In-Reply-To: <20260519073950.143287-1-yaolu@kylinos.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 22 May 2026 10:54:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6eopGi0CWpftzJ9Vf-dDzk8fPpJGnpAZeWMNoeTnJjyQ@mail.gmail.com>
X-Gm-Features: AVHnY4Ii2ETj2FoK1SUinlJ6x561ksaPmL9uH180AnPkmzvXVDr-Nswn9TgOnHE
Message-ID: <CAAhV-H6eopGi0CWpftzJ9Vf-dDzk8fPpJGnpAZeWMNoeTnJjyQ@mail.gmail.com>
Subject: Re: [PATH] drm/loongson: fix vga client not unregist
To: yaolu@kylinos.cn
Cc: lvjianmin@loongson.cn, wuqianhai@loongson.cn, jeffbai@aosc.io, 
 xry111@xry111.site, zhengxingda@iscas.ac.cn, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

Hi, Lu,

Your subject line is incomplete.

Huacai

On Tue, May 19, 2026 at 3:40=E2=80=AFPM <yaolu@kylinos.cn> wrote:
>
> From: Lu Yao <yaolu@kylinos.cn>
>
> Need set vgadev->set_decode to NULL when pci_remove.
>
> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> ---
>  drivers/gpu/drm/loongson/lsdc_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongs=
on/lsdc_drv.c
> index 6cd21480c979..79bb61278aa7 100644
> --- a/drivers/gpu/drm/loongson/lsdc_drv.c
> +++ b/drivers/gpu/drm/loongson/lsdc_drv.c
> @@ -327,6 +327,7 @@ static void lsdc_pci_remove(struct pci_dev *pdev)
>         struct drm_device *ddev =3D pci_get_drvdata(pdev);
>
>         drm_dev_unregister(ddev);
> +       vga_client_unregister(pdev);
>         drm_atomic_helper_shutdown(ddev);
>  }
>
> --
> 2.25.1
>
