Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5F8CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5768D10E307;
	Mon, 22 Jun 2026 19:00:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hyrNnRh5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64FCD10E307
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 18:59:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 134AC4166F;
 Mon, 22 Jun 2026 18:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB711F000E9;
 Mon, 22 Jun 2026 18:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782154799;
 bh=v5QBm6qa+OqHLLGjLCx8x8n2JJYamc2t3YH+owipFrk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hyrNnRh5RKp+NgtQl9D4RhF/tXtwC62hEfYjjmcP4XpXIek8WkYqWvo0Wn3OeDEon
 K0ZwVg9i75ZQRaMLiOOUHWrn3IuoSN4YtZZ0esUIgD5Vn2OBq9HP51mVvlXI/6iMCE
 QfRhd95mFRFVJHZISRmPj0nwmLOMwRC+1ijAvqMpxfsjOQDKQXqLSW2b9SHAON6aMv
 CWCcxHN8uFGcp+ElWpZ7sjC9/aElTVFsgss8MVFNuOftsuywR6J0hMBa5lULhqxpKw
 1RZm97SZr7FpAc2zDH7rySxo4DJMDJ2rq/g7MEdSV83Vn41+Zbmx8ReS0YwcdKWPWH
 rSjnHeC/VwIEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/4] dma-buf: add optional get_pci_tph() callback
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260622184211.2229399-3-zhipingz@meta.com>
References: <20260622184211.2229399-1-zhipingz@meta.com>
 <20260622184211.2229399-3-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 18:59:58 +0000
Message-Id: <20260622185958.7EB711F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The centralized DMA-BUF locking conventions documentation was not u=
pdated for the new `get_pci_tph` API.
--

commit 558f8ccf1c7e2c892ffa9049e917832eaa82ea77
Author: Zhiping Zhang <zhipingz@meta.com>

dma-buf: add optional get_pci_tph() callback

This commit introduces an optional get_pci_tph callback in dma_buf_ops and a
wrapper function dma_buf_get_pci_tph() to retrieve PCIe TLP Processing Hint=
s.
This allows importers to request TPH namespaces that exporters can emit.
The wrapper function requires the DMA-buf reservation lock to be held.

> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index d504c636dc294..7a4c9b0d5dab4 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -1144,6 +1144,31 @@ void dma_buf_unpin(struct dma_buf_attachment *atta=
ch)
>  }
>  EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
> =20
> +/**
> + * dma_buf_get_pci_tph - Retrieve PCIe TLP Processing Hint (TPH) metadata
> + * @dmabuf: DMA buffer to query
> + * @extended: false for 8-bit ST, true for 16-bit Extended ST
> + * @steering_tag: returns the raw steering tag for the requested namespa=
ce
> + * @ph: returns the TPH processing hint
> + *
> + * Wrapper for the optional &dma_buf_ops.get_pci_tph callback.
> + *
> + * Must be called with &dma_buf.resv held. Returns -EOPNOTSUPP if the
> + * exporter does not implement the callback or has no metadata for the
> + * requested namespace.
> + */
> +int dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool extended,
> +			u16 *steering_tag, u8 *ph)
> +{
> +	dma_resv_assert_held(dmabuf->resv);

[Severity: Low]
Since this wrapper and the new get_pci_tph() callback require the dma-buf
reservation lock to be held, should they be added to the centralized
"DOC: locking convention" list in drivers/dma-buf/dma-buf.c? The documentat=
ion
under "Convention for importers" and "Convention for exporters" lists other
functions that require this lock, but the new get_pci_tph API was omitted.

> +
> +	if (!dmabuf->ops->get_pci_tph)
> +		return -EOPNOTSUPP;
> +
> +	return dmabuf->ops->get_pci_tph(dmabuf, extended, steering_tag, ph);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622184211.2229=
399-1-zhipingz@meta.com?part=3D2
