Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AA0606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kCOD+ucP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D17CD10E96E;
	Thu, 26 Nov 2026 11:06:34 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 622C210E96E
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:06:28 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8b4c8b51b58so4079255b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 03:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795691188; x=1796295988;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i/lQFYYSgifKwpBl4Z4gLxmp/LsgZ8d5yEoRR702v7k=;
 b=kCOD+ucPZrbZjLRE5AjgELFHjZUJUpEEokWULoHqitAtfs3Ye9In7RWBJz04s9peq5
 hKjhY8sLe1VJozqOVTDr+NFPKucVKXxuPW5/RyAja/nPmglZXKRK2Li373r1kCvluS5b
 IJ8MSPpgH8bw30Nqda9Q4J8L+kr/9jSdpXO/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795691188; x=1796295988;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i/lQFYYSgifKwpBl4Z4gLxmp/LsgZ8d5yEoRR702v7k=;
 b=o47lfKUTEdA5s1s3YsPUDjsiQOy6+cIunhkCThz36IYkjVKKccivvDTeXoeccw/Rdk
 cNNbmy0X1XUZOms+AJUczpvPh3eBzAu/MyU6ZMCcMu+6EPEfzV5Ah13JnAZthcRpQh9i
 ipv6VPyTQanXcbnaA/ICLTm5RCZpyDHNNp87JEnL8gK19f8US1OUlpkkpB0xnZ/lY0kR
 TCK6NBL+yum7XyreZigW0K/XEzYIESTyMESkkM8N4bR2tJMSd0pZ7b03+BByrU6k1BwG
 sxtU0ubkbdmQk0/hJCp3VE8ywlOIwDzDZrWxmtUEEjtBNpBgFy28nGnFQlmlrIxvsXgQ
 qrDg==
X-Forwarded-Encrypted: i=1;
 AL+hErGk8TPPeYJSrgnEjLhIGwOP4pnWZN+HBni3msT068B8MuAhDl+RywrmE6BFnbmBJsDCA1RX7aBOy1M=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8iAMVS5S3C1BVhR/wdb2HPYN90BFNAxkkQX6CMLiqz+d4Ut4Qy
 iFuVePAyBaiYRF82xtgsYlT+VR6ev0V2w+dweZeGsPAFXOBpBVJTRJgZvTXIpD2pAYHVtxdjp2S
 dM94Q3A==
X-Gm-Gg: AZFdTZey5NUn1oNLkdH6Z2696eYM5dMQNQEyGuyqo6I6oUVcdQhCMPcXuFUwWhTSyzc
 BcjxyV3LObFVSjreM/yyyUINDVfYykJAsFq4fL2150feJlVQejQxOhDjeDrwTGSimR1QZaz4ObJ
 SU0mPdjpc8UYLaWYzb39+XMKjh1b8oCTXbsHrB/chPyGJT+ZN+IHKEhVQfE8lMVQaBfBkEOBEi4
 2d90MSQ3ap+z9KZUPmPFi2DioJzodOAZGObirbAnJXXiNbR0Uiy30F8F7VeYQ1U6zve/MhsJWMT
 iXRTyFfILZFS1v4OuBQRohGeYsPo+no1uV9tEh8yzrzwkz7M4MN3kekk52Hub6hJaPOl1RifTvN
 XSfw4gU2r0bwBQIsIp3aYWycAdyRXiCBptT9Py8urlgGngLeA0syB/t6va2LSqtvNNPspGBog7g
 p0pk6JIFK/vUSQs/xLL0iT6viQ54JRh6E8mPTlaizI7hzN6l35L2jYSqtxaRyeW4/Hax6P3YLd0
 Xht4HWtQsXX2sepf9IMygGXiBx+v6c6XGYKXhNx59VioGyTqYRmyRa+FMMwS/wpzUb+dmU7xVeI
 qVzTZVjZADH3CblMogE58z2ysLFFmrEjZWsOKnQtT9XJXohr4WV+j2imWE0108YLkEQ=
X-Received: by 2002:a05:6a00:178a:b0:890:a995:1f61 with SMTP id
 d2e1a72fcca58-8c87b4f3f5amr21962504b3a.15.1795691187817; 
 Thu, 26 Nov 2026 03:06:27 -0800 (PST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com.
 [74.125.82.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c873c1cfa0sm10496355b3a.48.2026.11.26.03.06.27
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 03:06:27 -0800 (PST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-33fb4680717so2291415eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 03:06:27 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErFax4zbpw/5ma80lLM0d5639nMvcFeAkFC67LJaE+HBUM+eNbZjBjcJNlS5o/40jMwUwKCtwimXZOE=@lists.freedesktop.org
X-Received: by 2002:a05:7301:240a:b0:386:cd71:b714 with SMTP id
 5a478bee46e88-386cd71ce89mr5908411eec.35.1795691185712; Thu, 26 Nov 2026
 03:06:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-37-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-37-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 26 Nov 2026 19:05:47 +0800
X-Gmail-Original-Message-ID: <CAC=S1ngQC33xKiYRYT1qq1jqJj+7yveiwu1CQrouv8Ud+dPtfQ@mail.gmail.com>
X-Gm-Features: Aa3M54q46fTI_3jhRSfuxLJf-vqFgr66vNyr9HYUTk_fEMF24HCMszULS2t_YS0
Message-ID: <CAC=S1ngQC33xKiYRYT1qq1jqJj+7yveiwu1CQrouv8Ud+dPtfQ@mail.gmail.com>
Subject: Re: [PATCH v2 36/46] drm/mediatek: mtk_crtc: Dynamically find
 suitable CRTC DMA device
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
> Now that the vblank and config components are being dynamically
> selected, the only hardcoded strategy that is left is selecting
> a DMA device for a CRTC that is being created.
>
> In order to support pipelines including an embedded multimedia
> controller (like MDP3) chained with the display controller and
> pipelines chaining multiple display controllers together, stop
> assuming that the first component in the pipeline is suited to
> do DMA operations and implement support to dynamically find not
> only a suitable DMA device, but also the best one.
>
> This finds the first device that provides DMA and the first one
> that is also behind an IOMMU.
>
> The criteria for selecting the best device is to prefer a DMA
> device behind an IOMMU; if not found, the first DMA capable
> one is selected instead.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_crtc.c | 68 ++++++++++++++++++++++++-----
>  1 file changed, 56 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediat=
ek/mtk_crtc.c
> index 3cb2d1a28987..16c9ff2cfe32 100644
> --- a/drivers/gpu/drm/mediatek/mtk_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
> @@ -1132,6 +1132,60 @@ struct device *mtk_crtc_dma_dev_get(struct drm_crt=
c *crtc)
>         return mtk_crtc->dma_dev;
>  }
>
> +static int mtk_crtc_find_suitable_dma_dev(struct mtk_drm_private *priv,
> +                                         struct mtk_crtc *mtk_crtc,
> +                                         const struct mtk_drm_path_defin=
ition *path)
> +{
> +       struct mtk_ddp_comp *dma_comp =3D NULL, *dma_comp_mmu =3D NULL;
> +       int i;
> +
> +       for (i =3D 0; i < mtk_crtc->ddp_comp_nr; i++) {
> +               const struct mtk_drm_comp_definition *cdef =3D path[i].co=
mp;

`path` points to a single `mtk_drm_path_definition`, did you mean
`&path->comp[i]`? Or use `mtk_crtc->ddp_comp[i]` directly here since
patch 38/46 switches to it anyway.

> +               struct mtk_ddp_comp *comp;
> +
> +               comp =3D mtk_ddp_comp_find_by_id(&priv->hlist,
> +                                              cdef->type, cdef->inst_id)=
;
> +               if (!comp)
> +                       continue;
> +
> +               /*
> +                * Check if this is a legacy OVL_ADAPTOR component and, i=
f so, this
> +                * has to forcefully be the DMA device for this CRTC: ass=
ign it to
> +                * dma_comp_mmu to force that.
> +                */
> +               if (comp->type =3D=3D MTK_DISP_OVL_ADAPTOR) {
> +                       dma_comp_mmu =3D comp;
> +                       break;
> +               }
> +
> +               if (!comp->dev || !comp->dev->of_node)
> +                       continue;
> +
> +               /* Find the first device provides DMA... */
> +               if (!dma_comp) {
> +                       if (of_property_present(comp->dev->of_node, "#dma=
-cells"))
> +                               dma_comp =3D comp;
> +               }
> +
> +               /* ...and check if that device is also behind an IOMMU */
> +               if (!of_property_present(comp->dev->of_node, "iommus"))
> +                       continue;

Checking `#dma-cells` (a dmaengine provider property) and unscoped
`iommus` can be fragile: if the leading plane reader has no `iommus`,
this loop keeps scanning and can pick a downstream non-plane block
that has `iommus`.
Maybe filter by `mtk_ddp_comp_layer_nr(comp, i)` to skip non-plane
components instead:

if (!mtk_ddp_comp_layer_nr(comp, i))
    continue;
if (!dma_comp)
    dma_comp =3D comp;
if (of_property_present(comp->dev->of_node, "iommus")) {
    dma_comp_mmu =3D comp;
    break;
}

Regards,
Fei
