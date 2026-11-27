Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7202606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nV2I0Akg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B35D10E274;
	Fri, 27 Nov 2026 12:17:51 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DF9410E274
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:17:45 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-8b66d1a08ccso5585900b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 04:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795781865; x=1796386665;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CwowVZ3rKUKS7aekHm2EGIj95zoVj8ccIVxOo6VaL1E=;
 b=nV2I0AkgGmmLeks8cTZPuG2G/Jpg5jnHTlWGq0G+ieIeZBnvMGrxUkBBBDqWLPbRYO
 bKZAzgXnd+UUpBnMVo3C4qnIKUAPvh0/gPiT6UOflZY0XfuhfuLzwoZJHylbSLVKNXfu
 fzCLZVqdohuCgX8py/bMiIDyFqVEGcQsNrXQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795781865; x=1796386665;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CwowVZ3rKUKS7aekHm2EGIj95zoVj8ccIVxOo6VaL1E=;
 b=Z1u4rMXl86qczzz+gZuovQXdSmLoufxCDjjIZPghWVu+rRBaany8w/ZtGqO/qkJ74y
 dYr6GWxw8upOcCH8WFaUbuBQFyDzhOjygx0RqbZitUcyllk4U1UWowRREKwSK4rlixUs
 dKJRyPm1Ps/SRcL7s75xKK67thoydhf/ySLkuZ5ihF+ZWwMHoyJQuU/sLOyoZh9YlXRq
 jVVPxmXyu1smoto20eaeBEhVd/wHL9fx8Pn2s9QN4Sj6cjQDuJ0XbnprrEwWrPCu1Z/r
 fSB+qdCj8I/HYWJPxf2O30R4Sj/MInplKdvR38aTOJfk4fVFDIapvYP9FsUSggB7b0Lo
 EBIg==
X-Forwarded-Encrypted: i=1;
 AL+hErFmp08o6zmJUehUlA8oVDYzIKy3zn9HayfrSey5B0EEAzrAnqrt7JwHEC0MGEdRINJLR7jO5mKWnpE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8HkJkyHEN9jpFqkWMPOJ2wg5uM5FudLdLvrLlPuYsp+qjXhbJV
 d759rLRfGa10V49K8QF62koEhyQPLHU40gw/svb0YuoApO8PzPJnrtKbKJOsGEO9B4+cHGbnSz4
 Q2Fw6yQ==
X-Gm-Gg: AZFdTZfLPqirxPhK9XZnaJmEpf2n3UGAwXCUh0K0RAU2ILQk4SH1FXhxiil2NTvkY6+
 lp2yMABTzUjhEHFpVzttMoJ49wPgryEAgF0enWTeBqfbUBFf8Hqzg+xAoAkx/B229KDCivTEmtQ
 IIpn2t2Lmm18DSgvwCE56ox+4FL58cNcFL811x0Z2VR8Mn09XlVfXBoaw6hwKowjHgclaqcvAVq
 EwjU73HG9qxm/lLQf7SBZCg0pBQ3ZrbXxINKLRCkJdoatMmxT3oabMyuZNrx8w/Mi+AlBl33oE1
 qO+uME0Zcfriyj5IDJHN7KkgT4C6+km6dORRX/VlhQqJBeXchirxtYUA5f/Pa0utqzyIGYaVTa7
 qiDfK0O+qZ+T4Rkf+3v2Sk8+hyyd+yuyeGmtFz/9bHOEeaIdJhWRdN/lz7rkRC0l8VVcPjc3cTI
 wOC7cqQ9tYtbY8vFS5E+6NE3wni7eIgBISKJ51Ie5jDf6sB308YGtGKoTEX+F3pG7k8depzQ6Mr
 9bTSB/JyCX5/fiZWqJSdWjduGmUwL1NpdiohhQQOMEx6fhO71Qx2ERINKLaBTJealXk0LcofY+p
 L9IN1A7zbvSYMaf7IpDwJgIek+6A4IJmWg+Kr0dtnNYSj8qeVlK8B+mRvimLfPR3Ns0=
X-Received: by 2002:a05:6a00:a512:20b0:8c9:1024:457b with SMTP id
 d2e1a72fcca58-8c9102446b2mr17712900b3a.57.1795781864801; 
 Fri, 27 Nov 2026 04:17:44 -0800 (PST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com.
 [74.125.82.169]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c873442863sm12615133b3a.43.2026.11.27.04.17.44
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 04:17:44 -0800 (PST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-38644aedba1so12073609eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 04:17:44 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErH6x5qcpfP1USv4J41yWA9oA6qixzveRYig/6VnzK+Yp2akSP8ezLOfyDPfYKgD0VMHCkHkGm5B8to=@lists.freedesktop.org
X-Received: by 2002:a05:693c:83cf:10b0:386:b526:24d1 with SMTP id
 5a478bee46e88-386b52638e1mr15336839eec.9.1795781862885; Fri, 27 Nov 2026
 04:17:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-44-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-44-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 27 Nov 2026 20:17:04 +0800
X-Gmail-Original-Message-ID: <CAC=S1nh0FpfDy8VqHJA=+bBtqZF1K5FYWF25pL1sAi4Q4MSSkg@mail.gmail.com>
X-Gm-Features: Aa3M54pcv7nTzvpglkL8e2ZqGsoE7ZtTuNgXg7WMfrQxU5jsZk3Rpl5MWtMoFKo
Message-ID: <CAC=S1nh0FpfDy8VqHJA=+bBtqZF1K5FYWF25pL1sAi4Q4MSSkg@mail.gmail.com>
Subject: Re: [PATCH v2 43/46] drm/mediatek: Add Two-Dimension Sharpness
 Processor (TDSHP) driver
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

On Tue, Jul 14, 2026 at 7:47=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The MediaTek 2D Sharpness Processor (TDSHP) is responsible for
> performing image sharpness adjustments/enhancements in a display
> pipeline.
>
> Even though this hardware block supports adjusting the luma and
> contour 2D histograms, frequency weighting, luma-chroma gain and
> others, this only introduces a basic configuration which allows
> to bypass TDSHP processing in an effort to forward the data from
> this block to others.
>
> That is necessary because some components cannot be connected
> directly in specific pipelines; for example, in MT8196/MT6991
> pipelines, when Display Resizer (RSZ) and Color Correction (CCORR)
> components are required, it is necessary to pass through TDSHP as
> direct connection between RSZ and CCORR is not possible due to HW
> limitations.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/Makefile         |   1 +
>  drivers/gpu/drm/mediatek/mtk_ddp_comp.c   |  10 ++
>  drivers/gpu/drm/mediatek/mtk_disp_drv.h   |   8 ++
>  drivers/gpu/drm/mediatek/mtk_disp_tdshp.c | 167 ++++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c    |   3 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h    |   1 +
>  include/linux/soc/mediatek/mtk-mmsys.h    |   2 +
>  7 files changed, 192 insertions(+)
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_tdshp.c
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_tdshp.c b/drivers/gpu/drm/=
mediatek/mtk_disp_tdshp.c
> new file mode 100644
> index 000000000000..31f57c567137
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_tdshp.c
[snip]
> +void mtk_tdshp_start(struct device *dev)
> +{
> +       struct mtk_disp_tdshp *tdshp =3D dev_get_drvdata(dev);
> +
> +       writel(DISP_TDSHP_CTRL_EN, tdshp->regs + DISP_REG_TDSHP_CTRL);
> +}

mtk_crtc_ddp_hw_init() calls .config right before .start, so this full
register write overwrites and clears DISP_TDSHP_PWR_SCL_EN that
mtk_tdshp_config() just set for 8-bpc pipelines.
Use a read-modify-write for DISP_TDSHP_CTRL_EN instead (or drop the
redundant write here).

Regards,
Fei
