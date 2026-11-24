Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4450F606A335
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=SI/DKvAZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A004310F456;
	Tue, 24 Nov 2026 14:33:47 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 050A010F66F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:33:41 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-3b3d4d3bba3so2296897a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 06:33:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795530820; cv=none;
 d=google.com; s=arc-20260327;
 b=Fc+J1uWERAK5UChw6nrN9t/XpT8l2SyX50UW3jbT9Tup6GLVv5kqMeNeSoA1iewBab
 DX/uNQW3YHJHmUvm11y3gj8Hp3pt67drMhKZoePtkpXSR6/V+fHDND6fFsk40f52oqbf
 6RenddwNau3eGzleoj7/V23SETW53E3yQMVBFquDkw5tL5UCKzMFzMcnaTtTgK/2N7co
 +HaVNRjg481WVjfEQQRarlQ7mVX5P9y5FeQpqnahDkAh+cNBXr8DFrqrM8bd6TBfus2q
 hQFCR60kS5bISARy/iwam21MMHyyhG30V0nHfZNrf+bwEoxgjudGMj5DFH2uemP8K7Ql
 VdcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RUxbFCgX/qZgkllCLWhh1DGi6P1IWH5bzGO/fNRQRnI=;
 fh=aWUqxXkRLRHR4LKOeikHRnTvaVeMeLM2sFfOrw2eXok=;
 b=Ap2pfitFxetxq8sEo5wHMyBAwG3bSCdtkF6t1KL2/uH9cDn8xo2oBMIjj0+VD8UjnY
 Oa9qzkd4LG2lqdygN+vYUAsf7ogoQ5x0zxP6Sdp8kza6KM580gv5XT6i2mKgWO+cBVPH
 9893zN/QB6wHw/6PK+oKhAd5VOcrXuRhj9jnaruNxFn/17egN50e/AEG6ZTYNkMaWDvd
 DescbWvcLrFFHnxC9IY4KdlzPHVonZXOmu6hH5EHPIQnLN+34PNIJjOdwlciXQ37jV16
 0b63A/vOTNhovgUpItoILoGq29OIeDY1jyiBO4zqWjhL+mmISPq5DkMLXh2WqpD+WBcu
 afEw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1795530820; x=1796135620;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RUxbFCgX/qZgkllCLWhh1DGi6P1IWH5bzGO/fNRQRnI=;
 b=SI/DKvAZv2hq1GhCuud/9eqZDPMCrhReRghLgGhCwzgchwmKDQh3NnG8ErfSCR9Yyj
 RamBJfPJxTz9orWYJl2L5JN3CHz90dwy+VQJkUOZ3NS2v1surfxZHH5gwUDVJi+NxyD3
 kJWPSr+6VfnlZIVYDRkYcSZH4coYuOhlkSlNwpwbXjwOYzriWqywGdGGPPJE+LPbV+82
 rGzGS4B9nNkV6OX11SoY2seyYTTapgtv870Q0q8J8Ad0QM42p4z2bzEeBrqvIPXYEVXO
 4Iwh+o4sBeciamayLnliSH+vjRKpv6aTTJDOhHuO0N17HINHW4AOgL4VAax4aJUF5FEv
 G8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795530820; x=1796135620;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RUxbFCgX/qZgkllCLWhh1DGi6P1IWH5bzGO/fNRQRnI=;
 b=dX19+vLzZTgcspoILydJ1gt7E4KvJBstp/zQCcgXw+/+k3JGsK9vKgYBX7wdKbJo37
 RjXWUa5UpO7VNvtXPZHYzxgIhT6IAZOJcOac6jPch3UFRQTEc4rs7aY619Lw+dQU0GxA
 vdLZZAWHNANmYwwE9yV00tEKFkHzh/kQDk7kPHTrEwxJwz2nyGvR7fVFvUnsyktD9NlD
 nKZvZaS/VZLRf6Z0PpJZmHOLziBHyLcu9WcigfbafQQSWDlrAw7v3oQ4x3qKUxc17ce6
 Fh5PXM6wHg9p1g8gcHpS4zrcAVcyWGrt7lB/Nruj+7tZS8lzhZUxB8xY7+obZ7chukVX
 VvsA==
X-Forwarded-Encrypted: i=1;
 AL+hErF9hr4tJB5pcul6ZYP7C1Hu3pEjdh0/tAWwuWGoKT8SoXILVLNQWtIQZC390lkBBMB4UtwKsh05UoI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9pDlIisFgbO9qQPI2MewX6wlZ3paaMdEkKTcgZoqqCPcxf8Zdv
 OFVdY7FRT6SShId++AzJwioo5kEn16cJYeJMeXmbLagINwRkW/nXl14qu5libj5zHu+EeN45i6T
 pxIk0NUBez3vORD5QJwZETxA90M2gnEqwmTPtOfZxCw==
X-Gm-Gg: AZFdTZeBdkhvMgcsoiuM6lwCLQtVd+2fiLnnJsl0IHxX25XNgg+Sx0tuRvXxzuBJIy+
 SvxQgDvQVTOWwoVllxwr5jgKR/++Ts0pvPZRx8UgKDPxh6h5AnwwZKBea5J56ukkrjQMm068c5Q
 FMSMSC2PwQtCY0l4a5cWcf8uCrC9xsfnPEENpNsraZYovFofjAKxw3IweFgekkOyMfcOCB2CoQo
 qR7FJDikHjqMKzZhle1Fvy5gWfpNLIcXgqyzpfFfVAnpcpArNPj3tO1YixMn5ulqxCIRnF6Orr8
 bC8cNy2hj3nueFmDYL9yOrgiByxmHRCmVJxymDDN4GqQf5JBguf8a1TtDr0m18lrtvzvRbEGOWS
 7ba2ZlLCt85m2mGWhStiDQzpKr9/tPcaOSw==
X-Received: by 2002:a17:90b:2f8c:b0:3a2:b16d:928b with SMTP id
 98e67ed59e1d1-3b41c95aec8mr12847695a91.46.1795530820492; Tue, 24 Nov 2026
 06:33:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-32-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-32-angelogioacchino.delregno@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 24 Nov 2026 14:33:29 +0000
X-Gm-Features: Aa3M54oxOcYmQorjTkd5D-GkJnjfCGVao0VGN1bH7KpMt9eEOWMLLFoUmIq_rhA
Message-ID: <CAPj87rMW6c0BMELjn70vsc+mkMxegDbSgQC-8BEDGspFyxzW2Q@mail.gmail.com>
Subject: Re: [PATCH v2 31/46] drm/mediatek: Add support for Display Layer
 Blender component
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 justin.yeh@mediatek.com, jason-jh.lin@mediatek.com, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Angelo,

On Tue, 14 Jul 2026 at 12:46, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
> +#define DISP_REG_OVL_BLD_L0_CLR                        0x20c
> +#  define OVL_BLD_BGCLR_BLACK                  0xff000000
> +#  define OVL_BLD_BGCLR_RED                    0xffff0000

We probably don't need a #define for every ARGB8888 colour tbh. :)

> +void mtk_blender_config(struct mtk_ddp_comp *comp, unsigned int w,
> +                            unsigned int h, unsigned int vrefresh,
> +                            unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
> +{
> +       struct mtk_disp_blender *priv = dev_get_drvdata(comp->dev);
> +       u32 val;
> +
> +       /* Set ROI for this Blender */
> +       val = ((h & GENMASK(15, 0)) << 16) | (w & GENMASK(15, 0));
> +       writel(val, priv->regs + DISP_REG_OVL_BLD_ROI_SIZE);
> +
> +       /*
> +        * Set both background color and constant layer color to Opaque Black
> +        * (ARGB) for eventual Alpha Blending to be effective
> +        */
> +       writel(OVL_BLD_BGCLR_BLACK, priv->regs + DISP_REG_OVL_BLD_BGCLR_CLR);
> +       writel(OVL_BLD_BGCLR_BLACK, priv->regs + DISP_REG_OVL_BLD_L0_CLR);

Would you believe that this does not in fact need to be black, as it's
been configurable since 4c684596cde4?

Cheers,
Daniel
