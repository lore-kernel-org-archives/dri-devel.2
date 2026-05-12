Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC16CD4F26
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 08:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C96F610E268;
	Tue, 12 May 2026 08:11:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MoCe+lHa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFA0010E261
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 08:11:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 58173443D4
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 08:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBA2C2BD01
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 08:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778573497;
 bh=6BojsxZOLjEhtqKTz9EoHvQznoagFeTE9NbkgrQer+c=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=MoCe+lHay61HbM27yL6DeHJkNWyRrVr/biDl9iI9kjIXhEZyNNbw924m5YGTbNxHo
 /h5sLBprl2iDAItcVSjwjFQyyWrLyNYEkv53esGQChCeQEJHuGS1YwV2Dh3C0fCsfh
 n3/+NGQYmf/yvTItRH+czg9MNaREvHnFpKz2q3TXOrCw2Ks9qGOLKAZy2h7IxTcOwb
 3tztjEwqZzj+jRhjHXEaydn2OaFIbhXVKFLyaefuwTcPzSLzsBvGCVEDRF9ku/kX2u
 kg9szORz4TYJtxs8TK9l72zUq/hDUoajAWpRbnd/CTGNU9kPTDfGVwzatHbo9too2C
 S4IMvIWWhDwjA==
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-bcf41831af1so309680066b.3
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 01:11:37 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw3DM9lPZdPwuurjm0zWoW480M7SKqGpCruDVw/GDgoCdZS8bGv
 umxjZ/poC81G5/F/WCXaugH+9U/eXCQpY5GMn83ann1zWtGKWBD3PknRkoh23gdwIvivBzSN7la
 ZsZ2biLKC+JZ9h88tQ1w+8mx83lAyxMY=
X-Received: by 2002:a17:906:ee8d:b0:bd2:1995:3a91 with SMTP id
 a640c23a62f3a-bd28e318fd7mr108583966b.12.1778573495594; Tue, 12 May 2026
 01:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260512063657.53100-1-mhun512@gmail.com>
In-Reply-To: <20260512063657.53100-1-mhun512@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 12 May 2026 16:11:54 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5Q5_xgi8WDgGGYLo4ivXv7tKeK2i97sZng2LzncsmgTw@mail.gmail.com>
X-Gm-Features: AVHnY4KHOlgA72xsxa1aNNyu6NufzzZ9v5aH1Cxl-mXiJUGXiIjUAXap3V-wddY
Message-ID: <CAAhV-H5Q5_xgi8WDgGGYLo4ivXv7tKeK2i97sZng2LzncsmgTw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/loongson: use managed KMS polling
To: Myeonghun Pak <mhun512@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sui Jingfeng <suijingfeng@loongson.cn>, 
 Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
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

On Tue, May 12, 2026 at 2:37=E2=80=AFPM Myeonghun Pak <mhun512@gmail.com> w=
rote:
>
> lsdc_pci_probe() initializes KMS polling before setting up vblank support=
,
> requesting the IRQ and registering the DRM device. If any of those later
> steps fails, probe returns without finalizing polling. The driver also
> never finalizes polling on regular removal.
>
> Use drmm_kms_helper_poll_init() so polling is tied to the DRM device
> lifetime and automatically finalized on probe failure and device removal.
>
> This issue was identified during our ongoing static-analysis research whi=
le
> reviewing kernel code.
In the subject line please s/use/Use/g, others LGTM.
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

>
> Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controller=
")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> Changes in v2:
> - Switch to drmm_kms_helper_poll_init() as suggested by Icenowy Zheng
>   and Thomas Zimmermann instead of adding manual cleanup paths.
>
>  drivers/gpu/drm/loongson/lsdc_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongs=
on/lsdc_drv.c
> index abf5bf68ee..4b97750897 100644
> --- a/drivers/gpu/drm/loongson/lsdc_drv.c
> +++ b/drivers/gpu/drm/loongson/lsdc_drv.c
> @@ -292,7 +292,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>
>         vga_client_register(pdev, lsdc_vga_set_decode);
>
> -       drm_kms_helper_poll_init(ddev);
> +       drmm_kms_helper_poll_init(ddev);
>
>         if (loongson_vblank) {
>                 ret =3D drm_vblank_init(ddev, descp->num_of_crtc);
> --
> 2.47.1
>
