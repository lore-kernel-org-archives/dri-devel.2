Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29F3CA5FA5
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 23:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 365BA10E12C;
	Mon, 28 Sep 2026 23:28:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SlR20X4u";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D5D410E12C
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 23:28:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3BD844366C
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 23:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211F71F0089B
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 23:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790638133;
 bh=jfNrPFE2/IENfsII90Vt8A6OX76G8R6ZgvMpj6jZeww=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=SlR20X4u9vAyQFfMO92S47QUK9yBB+P7gG41NknqY/af6wpl4Hm/J0ra67LtDoSOQ
 l/lqYoBHTv9xFC9u8u8MCgosK2Uq3gFezKU11wts4PZajg5JY15YmefbgHZvIAA+iV
 mZ4839MQbl7MSXEr1Kg5aU0GZbG4Qq0ahNMT/bIpLIyPqzcq2NSj0vtDym5yz6eB/3
 tMWwJbj8RZW1ptEWS3F/76DFUD/VYDn118KSA3LfSuM1YK+D5fU8/opP8Uz1NEWSt4
 VhaZ62p9hu6UbyLukHnfM17AgI5o1es/AmU2J0Ny1UKnkGUThgKC3k1vNp/RpMXFZ0
 CQdKKYncXD9Iw==
Received: by mail-dl2-f12.google.com with SMTP id
 a92af1059eb24-142dd046b87so2584820c88.2
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 16:28:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzRfg77Vd/1aLLqkcQx4zzjMgDEaHB61E5zU4+4xv+Uycv2y8qa4wE+vGlpgKAlavIx6JxYuLFtsLs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nQtdzpUAAXwtnORGkwIN59x9F7BfEkPw+MvD+TrAAp3EweEWAT
 pXfEF5j0Ygx0dMSZMiMvvKu3EmXBrseF4uFzjV1OelXJKAh8HY8MdVa/aEf1mdfb2sRc8A99g3x
 awXot7o+muzMvwbpfZEzvBCeZoim26Q==
X-Received: by 2002:a05:701b:4314:b0:143:50a0:56d6 with SMTP id
 a92af1059eb24-146cdfbe26dmr10687171c88.7.1790638132459; Mon, 28 Sep 2026
 16:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <7a3cbf55bf6a97835ee426eb38c34b2c153437eb.camel@mediatek.com>
 <20260825100845.438893-1-lihaojie@kylinos.cn>
In-Reply-To: <20260825100845.438893-1-lihaojie@kylinos.cn>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Tue, 29 Sep 2026 07:30:47 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-yXPCDQT4b2s6hEDDQ3Wa-x8bttg136MaZVqtgAs3Nsg@mail.gmail.com>
X-Gm-Features: AclHuK8HNY3IA0QITI8piNzSYqjyY4DjhKThRjLr8iy4Knqan-haBW6sZ5vbbc0
Message-ID: <CAAOTY_-yXPCDQT4b2s6hEDDQ3Wa-x8bttg136MaZVqtgAs3Nsg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: Add missing IS_ERR check for ovl_adaptor
 platform device
To: Haojie Li <lihaojie@kylinos.cn>
Cc: ck.hu@mediatek.com, chunkuang.hu@kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, p.zabel@pengutronix.de, 
 stable@vger.kernel.org
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

Haojie Li <lihaojie@kylinos.cn> =E6=96=BC 2026=E5=B9=B48=E6=9C=8825=E6=97=
=A5=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:09=E5=AF=AB=E9=81=93=EF=BC=9A
>
> platform_device_register_data() can fail and return an ERR_PTR, but the
> return value is used without checking, leading to an invalid pointer
> being stored in ddp_comp[].dev and passed to component_match_add() and
> mtk_ddp_comp_init(), which could result in a kernel crash.
>
> Add an IS_ERR() check to jump to the error handling path on failure.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: 0d9eee9118b7 ("drm/mediatek: Add drm ovl_adaptor sub driver for MT=
8195")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haojie Li <lihaojie@kylinos.cn>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index c86a3f54f35b..b281482ab8c8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -1112,6 +1112,9 @@ static int mtk_drm_probe(struct platform_device *pd=
ev)
>                                                             PLATFORM_DEVI=
D_AUTO,
>                                                             (void *)priva=
te->mmsys_dev,
>                                                             sizeof(*priva=
te->mmsys_dev));
> +               if (IS_ERR(ovl_adaptor))
> +                       return PTR_ERR(ovl_adaptor);
> +
>                 private->ddp_comp[DDP_COMPONENT_DRM_OVL_ADAPTOR].dev =3D =
&ovl_adaptor->dev;
>                 mtk_ddp_comp_init(dev, NULL, &private->ddp_comp[DDP_COMPO=
NENT_DRM_OVL_ADAPTOR],
>                                   DDP_COMPONENT_DRM_OVL_ADAPTOR);
> --
> 2.25.1
>
