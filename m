Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC81ECA5FAB
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 23:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2FC410E18C;
	Mon, 28 Sep 2026 23:44:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M68z9GNg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2C8510E18C
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 23:44:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 15E2A60136
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 23:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18551F0089B
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 23:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790639041;
 bh=1WdtbWW9ZiTyoHXGF6wqFuwUhglmsjzBGLU11/qcEXY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=M68z9GNgU1PQrr9z96rreonup5D0owhIvGzXs7QpZSeLQ9/G7DCePG8c/J106NVF2
 ELp/hW5TMc2AR/+rWeSLdh5b7f9XHZnjkhNOA+kktP60q87GW6/PYc+BVKdH2rr+3O
 pYHGlrlKzuOoIG7xI1cKlu9mEqO8kzArWJo14OQW6/zUIRVgpoBpECMMLlMBaBrYA+
 uQsYt441dFP1HMl0wkwVJRzPAsSrqyZfi6zdUm+qcnvWeuMBGGmQfi0q1Rwogu22o5
 AKsCj3oHGRtU4XlGiJ+w6psK3GDWyT2GK4qJq6OfkdCxJS0SztqCYFWc1Oy5K/PFoF
 sFMKXcWf815NQ==
Received: by mail-dl2-f42.google.com with SMTP id
 a92af1059eb24-144efd1ea76so2062915c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 16:44:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzSEC76sTfU27D563DzPmREi1WD8YqY4PpXOND3hxNNMSrlXjI1J4clgjTMcAv/Y+4/nH+uynxZp1Q=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nisHlgse5nXZKBx/wghaiyTZCWM8355VcKxoHEl/PtFTRMLRZT
 pU+6W/jUn7dtMuN4MYl8op3ZBO3F1xSRZrl4CVc9laFdOuR7lHBVJ6Rdh91zcZO9DlzH6Zp2MMi
 b/elOOzRxIake9ivHMfCToHw0c2JvKg==
X-Received: by 2002:a05:7022:220e:b0:143:296a:4e58 with SMTP id
 a92af1059eb24-146cfec8688mr17695133c88.27.1790639041117; Mon, 28 Sep 2026
 16:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260828-mtk-hdmi-v2-fix-register-offset-v1-1-118ad5d7ebe3@baylibre.com>
In-Reply-To: <20260828-mtk-hdmi-v2-fix-register-offset-v1-1-118ad5d7ebe3@baylibre.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Tue, 29 Sep 2026 07:45:55 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9wM00UUgXCCapLkuNhaV8h7Hh5gDP=ayhUTy2kxLn8gg@mail.gmail.com>
X-Gm-Features: AclHuK9rDQP3ezTpoWlsP6Hp3Tj24gUagLdqOtVesows-kOTI3dxpack7i3LaLs
Message-ID: <CAAOTY_9wM00UUgXCCapLkuNhaV8h7Hh5gDP=ayhUTy2kxLn8gg@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: mtk_hdmi_v2: fix VID_DOWNSAMPLE_CONFIG
 register offset
To: Julien Stephan <jstephan@baylibre.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 CK Hu <ck.hu@mediatek.com>, 
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Tommy Chen <tommyyl.chen@mediatek.com>
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

Julien Stephan <jstephan@baylibre.com> =E6=96=BC 2026=E5=B9=B48=E6=9C=8828=
=E6=97=A5=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:10=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> According to the datasheet, VID_DOWNSAMPLE_CONFIG is at offset 0x8f0;
> 0x8d0 is the VID_CSC_COEFF_0 register.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: 8d0f79886273 ("drm/mediatek: Introduce HDMI/DDC v2 for MT8195/MT81=
88")
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi_regs_v2.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_regs_v2.h b/drivers/gpu/dr=
m/mediatek/mtk_hdmi_regs_v2.h
> index 521b35c7e14d..bf3ebf5492d1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_regs_v2.h
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_regs_v2.h
> @@ -173,7 +173,7 @@
>  #define  TPI_AUDIO_LOOKUP_EN           BIT(2)
>
>  /* Video downsampling configuration */
> -#define VID_DOWNSAMPLE_CONFIG          0x8d0
> +#define VID_DOWNSAMPLE_CONFIG          0x8f0
>  #define  C444_C422_CONFIG_ENABLE       BIT(0)
>  #define  C422_C420_CONFIG_ENABLE       BIT(4)
>  #define  C422_C420_CONFIG_BYPASS       BIT(5)
>
> ---
> base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
> change-id: 20260828-mtk-hdmi-v2-fix-register-offset-879afc38cad1
>
> Best regards,
> --
> Julien Stephan <jstephan@baylibre.com>
>
