Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C1FC88E77
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 22:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93F6310E792;
	Tue, 15 Sep 2026 22:19:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VBIm2uEP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 572A210E792
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 22:19:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E11E600D1;
 Tue, 15 Sep 2026 22:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71781F000FF;
 Tue, 15 Sep 2026 22:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789510766;
 bh=rpSdZ5OvbqeZKcuM5Z7YsgmPO0kkzXfzBgg4m9PtGwE=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=VBIm2uEPIhgM3jm2hdfHcjfOfhndYhFHtIcUjlyzRpLGPLEVZuvTjM2TxGa6XoVKW
 TgO0OvZk7bmr/BV3ov/hWb2AG/vTXi3Xa1rIgax3sIjpxa65N2G5Yu59oEcs0D6Yqa
 GY8P/ZjyMROBXqi9VoawKc0qVWaY7LofAkSl6lQ/psAArD+IMyUAxESxx0vHrMWb9X
 G/z88e12qtTyXpTLFDJyRPizwVg9XOhCQS2zds4XGabWODIdj054tlVCFxRHLkyw6b
 1l4eBMnxGkVzOdAV5HoWDtY/6tkoZbCfFKKeZEWaNn9tm2gU932VGGNyPlYBinkApX
 xm8i9sfWanJjA==
Date: Tue, 15 Sep 2026 17:19:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v13 1/5] PCI/TPH: treat reserved 0b10 completer encoding
 as unsupported
Message-ID: <20260915221924.GA876929@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731211601.3033906-2-zhipingz@meta.com>
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

On Fri, Jul 31, 2026 at 02:15:48PM -0700, Zhiping Zhang wrote:
> get_rp_completer_type() returns the Root Port's "TPH Completer
> Supported" field (bits 13:12 of Device Capabilities 2) verbatim. The
> 0b10 encoding is reserved, but pcie_enable_tph() feeds the raw value
> into the requester type:
> 
> 	pdev->tph_req_type = min(pdev->tph_req_type, rp_req_type);
> 
> and later writes tph_req_type to the TPH Requester Enable field, which
> only defines 0b00 (disable), 0b01 (TPH only) and 0b11 (extended TPH).
> 
> No known hardware presents the reserved 0b10 in this field, so this is
> defensive hardening rather than a fix for observed silicon: fold the
> reserved encoding into "not supported" so only the three architected
> values can ever reach the Requester Enable field.
> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>

In subject, to match history of the file:

  PCI/TPH: Treat reserved 0b10 completer encoding as unsupported

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/tph.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 655ffd60e62f..5cbb381e2a02 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -200,6 +200,7 @@ EXPORT_SYMBOL(pcie_tph_get_st_table_size);
>  static u8 get_rp_completer_type(struct pci_dev *pdev)
>  {
>  	struct pci_dev *rp;
> +	u8 tph_comp;
>  	u32 reg;
>  	int ret;
>  
> @@ -211,7 +212,15 @@ static u8 get_rp_completer_type(struct pci_dev *pdev)
>  	if (ret)
>  		return 0;
>  
> -	return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
> +	/*
> +	 * 0b10 is reserved; treat it as "not supported" so only the
> +	 * architected encodings reach the Requester Enable field.
> +	 */
> +	tph_comp = FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
> +	if (tph_comp == PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY ||
> +	    tph_comp == PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH)
> +		return tph_comp;
> +	return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
>  }
>  
>  /* Write tag to ST table - Return 0 if OK, otherwise -errno */
> -- 
> 2.53.0-Meta
> 
