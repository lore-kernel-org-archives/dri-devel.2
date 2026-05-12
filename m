Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B91CD4F26
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 06:56:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B261E10E97F;
	Tue, 12 May 2026 06:56:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VNTn+Y5H";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86F8D10E97F
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 06:56:20 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-bd01481e592so225283366b.2
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 23:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778568979; cv=none;
 d=google.com; s=arc-20240605;
 b=l1u6G7yBCLpwoYtJw1S350Q2NFApaJwYsi+7hxIJ4tqJ9hzqPSsA/KKBIwJN6o0KIa
 RSHfOQEvBjjvK5V3r19L1YR4Mshe4PUiuCSYTMBvLIwG2SqccFgk958Xk15JirxqxfTZ
 r/YkJGJzndr2LGm7uOi/TeuoPnzl47S6s2CL5M/E9U2H0yQGup7f3ttNMdGZV2Bm9qLE
 pymPF/BGCzlagJmnKMEuQEwPfcWumVtNpPzNsj5nhOuSSxobZEtUWusPSa9+ByFplCB4
 pz2sON/HUDW+FYSS7rTVauNho0uSeeQyzS+b/oavkThI1huSAmkoXi/Etou0jSI2qImC
 oa5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PcRJD/2KrbXOyU9n8vUeVZ+ZFPiSsT4NRjDMaC2zai4=;
 fh=4yrVqarT0tdvyhNqI7xAhS9TrqxzEm/beXToEYG0yeQ=;
 b=WJ9tT1nQSiJPeXBULvxW4vV87MMbzo6idWfn6bf7BzoEJV2mUPGVrArfuVZFwbZNw0
 m4OSFzwglLxHOeAa477UdcZaO6iU3R+b4Hi3ydTAAhpeNktVf7rxJKbY5/JpGDaMH1p2
 zJt/sWu4tahetQV8CkAKbJVvY63xYnf4+4xgD24jOIc5K2aP2ZP3KPbsFIR2yAPtxQkS
 W9GGZW2BjeA2WfkgJd5PIqfWszBPz15XamfiVYNxpPaDSzthajsGiEmQac/AuuDsh5kz
 X7bWHMOBabTjcZjG1abjT6wpQYHS4N6HluGd8z2CfcERtHuEJXZu44gPyut+3sC4yVNO
 qXgA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778568979; x=1779173779; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PcRJD/2KrbXOyU9n8vUeVZ+ZFPiSsT4NRjDMaC2zai4=;
 b=VNTn+Y5H5R6ouf2iIqMsYBJAd4dbYbdTaEkHHWkEG9zxLL3xLzAJJ5J/VwXEl5Twsb
 2LFNSY7JMrPPP4uBs2gTBNVh4yGgAKA0Ef+cutVg3gub6B4yzVwHVSrEI2vGNtgQ9SCJ
 9WHSA/BHw5zf0LwhLtI5KRZe+X8hoYJ/pVUOqq0zdpuRVlsra2pzhNTYqB8YiPClI9bZ
 RLjy1dqdK0QridzOtmpR/gjN7I0Qwbxo4PTpMdCYg3RQB+6KsHThok+8ChNWvG9JSu7e
 s8OarHsFxOsiN622KuKHenM31f9L1ebqB9AIAoixxTs42F2XL56sL7uOK31+hQ/OzVpy
 uuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778568979; x=1779173779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PcRJD/2KrbXOyU9n8vUeVZ+ZFPiSsT4NRjDMaC2zai4=;
 b=sViZg+FVeXvrjRVt25z/V3og25s0Zanf/pG0gusfWlRdqllL8Ni0EKgLycUBUJjewJ
 Vq53FRl6le+YOaDjzV2yKBo4v69DyeVXEAl1ZmAcNcdjpucYJa7I13zWChv/o5V9zL7B
 wJWec4Nre0Y7S0cKveRznWn8og2hrbPhXdyp7Cu3ysQtBVO58sz0NsMribpz2WujJBtq
 6h/+SDrpjx5cg8t/kipKHG7Up7GdnEd+v5OWZReX/p1o899GLkc8bjmWetz2Byswxvjo
 7VUkcuTEEEABAjdDp1uwarkmqZHAy/g2e1dXy8+Le+UJv8/qTc6hq2knhfHo6XJhNVZg
 upEA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9y4L0XpkDkPXwd1v7lNVQcQawmf0LyPdxvwfyLP+mvg74aZGs/DRIWhmyDFUdkuLOmTPdoRnys4DA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWyr1am5WgPMawDC0mZ70atMoCVvHJZjqh/Zv2rkDBpRuVHuR4
 6tujaB8eaqLMv970V5hWqJxW16tnIFlWUYwNchVFOq7WwekYUFyYO+0AsAPWicFtKggq/6QElZ6
 SfCwPXeWCiBbKn8qm+baj9sYQFOVMHg==
X-Gm-Gg: Acq92OFz/WLaNomDFNo7d0iQWN+IIOcQoZ735yRnvHgcIXzFbHsfQ5BImqHH1EvzH9C
 kdJM/4Q/ODu30XEshxoKBNFDROT7t/Nk1k4EkQw4FZC2xWI9cXPoAoAD/J/KiRICsKGfe+Bv7/C
 VF8b4SbWquW81X09DEImIMhGjpzXVIetF/y8+v24BRd5Up0K49+y2dYYOnIpkPxtcn2ZCLdQqPy
 vv/q1QgGRY2ni2SgzTXxAStIIoGVGxzdP5vxKQG/Oak7RNTgACe12YTW2ivFBawYsEOQPLvnGV2
 xg7ODk6pNAVSSMGiwnAv4ToozHYMwZ7pQ6S2E7o=
X-Received: by 2002:a17:907:970d:b0:bcf:1d87:11be with SMTP id
 a640c23a62f3a-bcf1d871b7dmr522910766b.19.1778568979088; Mon, 11 May 2026
 23:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260512065436.74729-1-mhun512@gmail.com>
In-Reply-To: <20260512065436.74729-1-mhun512@gmail.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Tue, 12 May 2026 15:56:06 +0900
X-Gm-Features: AVHnY4K93hHdbZPZVPL3TVOHCvpPLydK2RIIOIY9b5J-khG9lMURvKKo9bEL9_A
Message-ID: <CAGEsz8Fe6jSvHawbq1owQ5TUm1YprufHf5mLU4t0FdYD_UykBA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/loongson: use managed KMS polling
To: Tobias Klauser <tklauser@distanz.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, dri-devel@lists.freedesktop.org
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Sui Jingfeng <suijingfeng@loongson.cn>, Jianmin Lv <lvjianmin@loongson.cn>, 
 Qianhai Wu <wuqianhai@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
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

Hi,

Sorry, I accidentally sent a duplicate copy of this patch. Please ignore
this one.

Thanks,
Myeonghun


2026=EB=85=84 5=EC=9B=94 12=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 3:54, M=
yeonghun Pak <mhun512@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
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
