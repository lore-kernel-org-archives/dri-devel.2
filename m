Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04BACD8CA8
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:56:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11ABF10E373;
	Tue,  9 Jun 2026 19:56:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QvSThxOG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D03B810E373
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 19:56:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2CAE2602CE;
 Tue,  9 Jun 2026 19:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A840F1F00893;
 Tue,  9 Jun 2026 19:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781034973;
 bh=y4iRsk+AhfxJSSqxKswZ1/phd34ipK67r/z1ycidumM=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=QvSThxOGvVJFNdr/naZAD6M8F4kr7tHnFy+Z5x0HnJL/H4yOVFl3qTjhpbbvPGMXQ
 cXBHVIgTsrYY2nzaNrl7bYLp6vnklAFTnZQoIcYV9NGY/Efnk/tQmTYqAA9txv/DT8
 QLQwMkUg9p9H7vm1ZqQ4AEd31RQjqayQa3zEkyboXBs7J1b/INwl2LvqmwkbktcPwY
 rMxsJIWA5Fwt7aVHw7Tk6enfab2EDtBKPtxIAHQIs4X0WnrC/AwdOpKaAbq9Lr+rf/
 BUyg3HdHYBXhG3pYTlAv3BqUpiW25/Fr1l0EXlFT6nTpJEpXw4jXyCecBwicC6NX39
 dmlfW70iAH08w==
Date: Tue, 9 Jun 2026 14:56:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v6 2/5] PCI/TPH: expose enabled requester type and
 capability helpers
Message-ID: <20260609195612.GA85322@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608185646.4085127-3-zhipingz@meta.com>
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

On Mon, Jun 08, 2026 at 11:56:39AM -0700, Zhiping Zhang wrote:
> Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> requester mode without reaching into pci_dev internals, and
> pcie_tph_supported() so they can test whether the device exposes the
> PCIe TPH Extended Capability without doing the same.

s/exposes/advertises/

> This keeps pci_dev::tph_req_type and pci_dev::tph_cap inside the
> PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for callers.

Update subject line to match capitalization of history
(use "git log --oneline drivers/pci/tph.c")

s/expose/Add/ in subject.

("Expose" suggests that the interfaces already exist and we're just
exporting them, but these interfaces didn't exist at all before.)

> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

With the above,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/tph.c       | 25 +++++++++++++++++++++++++
>  include/linux/pci-tph.h |  7 +++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 91145e8d9d95..aa09113c46d4 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -174,6 +174,31 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
>  
> +/**
> + * pcie_tph_enabled_req_type - Return the device's enabled TPH requester type
> + * @pdev: PCI device to query
> + *
> + * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_EXT_TPH.
> + */
> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
> +{
> +	return pdev->tph_req_type;
> +}
> +EXPORT_SYMBOL(pcie_tph_enabled_req_type);
> +
> +/**
> + * pcie_tph_supported - Whether the device advertises the TPH Extended Cap
> + * @pdev: PCI device to query
> + *
> + * Return: true when the device exposes the PCIe TPH Extended Capability,
> + * false otherwise.
> + */
> +bool pcie_tph_supported(struct pci_dev *pdev)
> +{
> +	return pdev->tph_cap != 0;
> +}
> +EXPORT_SYMBOL(pcie_tph_supported);
> +
>  /*
>   * Return the size of ST table. If ST table is not in TPH Requester Extended
>   * Capability space, return 0. Otherwise return the ST Table Size + 1.
> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index be68cd17f2f8..2e07bce77038 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h
> @@ -9,6 +9,8 @@
>  #ifndef LINUX_PCI_TPH_H
>  #define LINUX_PCI_TPH_H
>  
> +#include <linux/pci_regs.h>
> +
>  /*
>   * According to the ECN for PCI Firmware Spec, Steering Tag can be different
>   * depending on the memory type: Volatile Memory or Persistent Memory. When a
> @@ -30,6 +32,8 @@ void pcie_disable_tph(struct pci_dev *pdev);
>  int pcie_enable_tph(struct pci_dev *pdev, int mode);
>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
>  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
> +bool pcie_tph_supported(struct pci_dev *pdev);
>  #else
>  static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
>  					unsigned int index, u16 tag)
> @@ -41,6 +45,9 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  { return -EINVAL; }
> +static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
> +{ return PCI_TPH_REQ_DISABLE; }
> +static inline bool pcie_tph_supported(struct pci_dev *pdev) { return false; }
>  #endif
>  
>  #endif /* LINUX_PCI_TPH_H */
> -- 
> 2.53.0-Meta
> 
