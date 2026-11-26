Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2B7606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=DiooAO4Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CDE3112277;
	Thu, 26 Nov 2026 10:01:19 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C074A112277
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 10:01:12 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3b51a9606e8so271875a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 02:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795687272; x=1796292072;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aPAOj8/sEiImf5Q5w0lmK7mWVF1uN6/NWzG/i3miSOs=;
 b=DiooAO4QhjLl3WEghApbnwTozMnrpCE/2RxF/QRv90z+o/tlLdLKBW/Aouhuoe5+K4
 18Y0JjDkqttnZNcRa9f++zjtHHl8TPNPyaO5zPLngifxqPVIZ8ioWJs1KhPPPGJCKZvp
 I8UQYwTEifZswCNViYN2UcvI/2x/tfrkn3h/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795687272; x=1796292072;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aPAOj8/sEiImf5Q5w0lmK7mWVF1uN6/NWzG/i3miSOs=;
 b=dikbz9LmV0rgGx+OLPgeY68nwJQVBsAJ1+wxoK1XlNhXAbQfHheEYQIBwlr9nqicDd
 3M1t54wys++RcD56+tgWjs5iJXymA9rgm/JSQugl2BevdM9I4VfmbpqUSJYcvnRYL1GW
 O4rFgxQFZfkkeWtyJE/LMSnrDa4Ieo8qWt9VGfFPFGRT4451xUSZfQhSQgg0deFu+B3v
 c0Bw9LlIxDv/FRl3hkDB9jiMQsQaY9BqwzzuHk6NEYNMxUF+lgJK0WDgM679uGhWCp87
 qybnZ8oUTgVEnQoH/PjHs98qlJQxGV234h0laHIjpML3A36F2DNuRnG/B9FTutMDEhge
 u9LA==
X-Forwarded-Encrypted: i=1;
 AL+hErHB1ywJjGN1eHBfj68+Dh2gjPYU4CdUwnBRAAFXC9mZxIkDASKMldNWhgdyOJCRZkXiRFB2CTDHp4k=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+VzMA1p2srnG6EmKguAjFI3b07OSKxVUo97CwLPCSvNg9p3Sgc
 bxrMwSDs2kCjPDeBlZaLisLgSgtammX1IRudv3e5N1RYdtC1iiaqsUBySmgvNpk6Tm06P0RhINb
 lk+v3Sg==
X-Gm-Gg: AZFdTZfCXgEyNdKb8ITRTQEVk4LUQwnacaukRWYnnS/dbo04F6zp0itfOYqmksBKPVR
 Xyl6EXcMFu45w5tye3Bf9pz3xOjQh41oGQcEfmjgKzItj2ONl9d+xPFmqRElvAIz9d7b5NFYDzY
 ZTkGQkrXaAvmrKja85iu6Km3JmQoN67eATp+McfaFCms8b8qoXQnIxoSrXXExnAH5zFpMumbRzJ
 ELyZSyiyczaCWKe4Ky9tW0lGyScN8OtdTrX7VAU+qVAptZM+YdGpoSpP/7w/awJLLvieh4DPrkT
 uNdztm2PD5Ozdr3Lu+oZP22K5XRH0boMotrbKEOPIorgiBvAjVi08Ha5VXiX438X6tQBN5CrfrD
 ELR9huzb1aP8LXCVgbk5y8VPtiySZ7jWu7KKPPg6wATJ7LmFsAYjPtF0Fy1XTyxj+t08unsLGxx
 iP1jgBUrEEcpteKKDVbEAsgCvpeKZvRa9u1DuVY5V2SYWGwZdecDR3s+dWBHOgcUQZrJxi9W+Wr
 Sxujtkkiz+67HYX8DpbJXG8WwwsNpi7cc4HDGYaq2xL+hLNnY9Dtukv35m0PbGoyZ3oxVOr81/o
 FCgpiJUERCpQiF4ohqgWkwTUeYhzMVLswt0hc7bei9rM3kVQgArhY/hYEobNZwrnInx+g46ysss
 48QowNLT0k5Bo
X-Received: by 2002:a17:90b:384d:b0:3ad:50a2:9abf with SMTP id
 98e67ed59e1d1-3b41c92f8eamr20665681a91.38.1795687272156; 
 Thu, 26 Nov 2026 02:01:12 -0800 (PST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com.
 [74.125.82.181]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41abb2076sm32486356a91.2.2026.11.26.02.01.10
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 02:01:11 -0800 (PST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-386c4d2e2ccso4469648eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 02:01:10 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErGTX6uBD1eaTp/2ZIayxRqbxe87UPa8peOd6j+arxv3M9WtoxUsn+xP+Sy1Y/spps0noNeMFoNbXfw=@lists.freedesktop.org
X-Received: by 2002:a05:7300:e9cf:10b0:386:e571:4bb4 with SMTP id
 5a478bee46e88-386e5715040mr399450eec.13.1795687269562; Thu, 26 Nov 2026
 02:01:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-36-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-36-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 26 Nov 2026 18:00:31 +0800
X-Gmail-Original-Message-ID: <CAC=S1nj8rJ0WJp7DcO68zyejSvzFhhB5Q_q+_jKY2itMAJ64eA@mail.gmail.com>
X-Gm-Features: Aa3M54r8mZgCPYkjyk_HhGWN4kbWoWQVSbV0f4Pj7KzdyzjM_U47c8LDiim4nPQ
Message-ID: <CAC=S1nj8rJ0WJp7DcO68zyejSvzFhhB5Q_q+_jKY2itMAJ64eA@mail.gmail.com>
Subject: Re: [PATCH v2 35/46] drm/mediatek: Add support for Display Output
 Processor component
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 justin.yeh@mediatek.com, jason-jh.lin@mediatek.com, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Jul 14, 2026 at 7:46=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add support for the Display Output Processor hardware component,
> found in the MediaTek Kompanio Ultra MT8196, Genio Pro 5100 MT8894,
> Dimensity 9400 MT6991 and others.
>
> This hardware handles the post-stage of pixel processing in the
> layer overlaying process and is also capable of performing gamma
> correction, ensuring that the per-pixel values are within the
> expected gamma range.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/Makefile           |   1 +
>  drivers/gpu/drm/mediatek/mtk_ddp_comp.c     |  14 ++
>  drivers/gpu/drm/mediatek/mtk_disp_drv.h     |  14 ++
>  drivers/gpu/drm/mediatek/mtk_disp_outproc.c | 247 ++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   3 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h      |   1 +
>  include/linux/soc/mediatek/mtk-mmsys.h      |   1 +
>  7 files changed, 281 insertions(+)
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_outproc.c
>
[snip]
> +       priv->irq =3D platform_get_irq_optional(pdev, 0);
> +       if (priv->irq > 0) {
> +               ret =3D devm_request_irq(dev, priv->irq, mtk_outproc_irq_=
handler,
> +                                      IRQF_NO_AUTOEN, dev_name(dev), pri=
v);
> +               if (ret)
> +                       return dev_err_probe(dev, ret, "Failed to request=
 irq\n");
> +       }

platform_get_irq_optional() can return error codes that need to be
handled; otherwise, mtk_outproc_bind()/unbind() will pass the negative
values to enable_irq()/disable_irq():

ret =3D platform_get_irq_optional(pdev, 0);
if (ret < 0 && ret !=3D -ENXIO)
    return dev_err_probe(dev, ret, "Failed to get irq\n");
if (ret > 0) {
    priv->irq =3D ret;
    ret =3D devm_request_irq(dev, priv->irq, ...);
    ...
}

Regards,
Fei
