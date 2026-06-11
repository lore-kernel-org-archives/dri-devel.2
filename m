Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0026CD8C9D
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 365D410F09C;
	Thu, 11 Jun 2026 18:37:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="rlWmX9Fl";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7466310F09C
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 18:37:48 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2bf2d865383so14765ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781203068; x=1781807868;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/TFfh87PJEUZx1rJ8R/E1mrJDSDu5E1AnG3uHnDgisU=;
 b=rlWmX9FlPeF26xuxmgpspc5plfFUQF8hWOm6Fny4pFUJ8tYhQKYiTRmHk/Tc5kjX0u
 r9thPWg/u/vKWGlvmy88hU2KzHEMYWPXHx/tCcniHiyfQ6NWQz58AZuOBNG9lltChxu3
 H7+NqnZ4ev80XrzEf0IQi5yIAmh16IRbMrpLz6DB4Y9SyZX5ER7gfEkhmnAEAe1Rj4JC
 99SvTu7yIwlE7lL9yNv5kpbqZ0RqFd0+BmsXuGxmbCTu09vvXImeUuNqgl5IYNJq/6qU
 bRy+eZvpjMg4CagF69zNwI4jX5uQhjK4SxhUASKCC3PbzkKAp9XBoj4OEzEX1HROVbvC
 N2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781203068; x=1781807868;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/TFfh87PJEUZx1rJ8R/E1mrJDSDu5E1AnG3uHnDgisU=;
 b=NCmJu1LMWPFCXQWZ4HTwx7zkRUybOkCWXIoSSJZIcA7t0UuQGObSfceO1FKRZmhSXB
 sMDsk6o8kNiEDLbOaWilf2MDUNnzxOAQjZpx4VULW5PkUyQtTrN7SngKWNxiXLqWZKd1
 b3gnSsT9BbtL6BfMhPrDGJRqJF1RGpdasBaVgB2KZ/ikb88+gybiefmoOdfesB9TWnR/
 3kxw8fCOjnRQt3PJKYIS20QMNRGD7ETmbeeIO3b3KLZVt03m2/1ChdIuhJv8M1xQcCfC
 c5Vu/yyBAq3n0PnnsAZKMffF8++gzmheH34Z3QhBEj7DBZSZH3Gc5YqOU/Mzf0TEWDt7
 eX+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8hi49O/2s0kxXgia03SIxr+O9qh6AMePGJbWD89GwGTf4LJNi8FhJjFd6bWep4K8keHZXnNNPJD3o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxH/1OMxSOz2VP0N38oHo9WIVdCCmvdOQHhHcXNP6dfyBuQf4RS
 zYYcBhks3lb+A69FdJMjq/KjNr4DZNY3j8obQhEQX8tg5qxVdPXZuHUsLyEKx7U1ig==
X-Gm-Gg: Acq92OFOQP/xTFT/qUAy0RkaPSiIwJXt0fK35TwZWVhSznSGkE4d6wJ1r/YGogctMio
 s3Ev0dM28w3EMHN1HtUBeqgNxQtvnuQ6GlEYh+ciKW1G2XKSd1iYkppM7Z1LdqcE0DgZwtIGb8B
 j0vbdB6Espuv0q976BqKChcJstvyjB3FC3/UstwrpNmOSLad8lwdKB/WBRY3s8YjflrGfsT9XqE
 3lBrlBmA6Poy3d2iR8+M4ZOAVUsCLqSn/D8axsFEPyXE8NeOKBSQNKGVW5koKkfb7qvwPGRieC6
 y4nctNsVpZWCZmCSSaJVbyDPoG2blqQWZkafc9A/74qwrpfhBpa0031hx9xhCbv/o+kvoEY7jyi
 2WcUst6OAFkYnIrIIGRRQ7nssmUeRiYCyCkJmtTgGgZ8yrajAqcS/iosxCEDITABeS/ltQ3IeUr
 nJGhswstqqs86FxYDw0/IsHnHJ5GcWp2WFjalewqTNulBAMjwmG993lxI39cZO
X-Received: by 2002:a17:902:ce02:b0:2bf:b01:2b4c with SMTP id
 d9443c01a7336-2c3e3f69092mr255655ad.9.1781203067344; 
 Thu, 11 Jun 2026 11:37:47 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com.
 [34.142.255.199]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c865880c00dsm2085451a12.24.2026.06.11.11.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 11:37:46 -0700 (PDT)
Date: Thu, 11 Jun 2026 18:37:39 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Kevin Tian <kevin.tian@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Message-ID: <aisAc1HRn2Wa4F9p@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-2-matt@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610154327.37758-2-matt@ozlabs.org>
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

On Wed, Jun 10, 2026 at 04:43:15PM +0100, Matt Evans wrote:
> The P2PDMA code currently provides two features under the same
> CONFIG_PCI_P2PDMA option:
> 
>  1.  Locate providers via pcim_p2pdma_provider()
>  2.  Manage actual P2P DMA
> 
> Some drivers (such as vfio-pci) depend on 1, without having a hard
> dependency on 2.
> 
> A future commit expands the use of DMABUF in vfio-pci for non-P2P
> scenarios, relying on pcim_p2pdma_provider() always being present.  If
> that depended on CONFIG_PCI_P2PDMA, it would make vfio-pci only
> available if CONFIG_ZONE_DEVICE is present (e.g. 64-bit systems), even
> when P2P is not needed.
> 
> To resolve this, introduce CONFIG_PCI_P2PDMA_CORE and refactor the
> basic provider functionality into a new p2pdma_core.c file.  This is
> available even if the CONFIG_PCI_P2PDMA feature is disabled (or
> unavailable due to !CONFIG_ZONE_DEVICE).  Then, drivers can enable any
> additional P2P features with the original CONFIG_PCI_P2PDMA (available
> when CONFIG_ZONE_DEVICE is set).
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  MAINTAINERS                |   2 +-
>  drivers/pci/Kconfig        |  10 ++--
>  drivers/pci/Makefile       |   1 +
>  drivers/pci/p2pdma.c       | 109 ++--------------------------------
>  drivers/pci/p2pdma.h       |  29 +++++++++
>  drivers/pci/p2pdma_core.c  | 118 +++++++++++++++++++++++++++++++++++++
>  include/linux/pci-p2pdma.h |  24 ++++----
>  include/linux/pci.h        |   2 +-
>  8 files changed, 174 insertions(+), 121 deletions(-)
>  create mode 100644 drivers/pci/p2pdma.h
>  create mode 100644 drivers/pci/p2pdma_core.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c2c6d79275c6..b21523b3bd8b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20617,7 +20617,7 @@ B:	https://bugzilla.kernel.org
>  C:	irc://irc.oftc.net/linux-pci
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
>  F:	Documentation/driver-api/pci/p2pdma.rst
> -F:	drivers/pci/p2pdma.c
> +F:	drivers/pci/p2pdma*
>  F:	include/linux/pci-p2pdma.h
>  
>  PCI POWER CONTROL
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 33c88432b728..59d70bc84cc9 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -206,11 +206,7 @@ config PCIE_TPH
>  config PCI_P2PDMA
>  	bool "PCI peer-to-peer transfer support"
>  	depends on ZONE_DEVICE
> -	#
> -	# The need for the scatterlist DMA bus address flag means PCI P2PDMA
> -	# requires 64bit
> -	#
> -	depends on 64BIT
> +	select PCI_P2PDMA_CORE
>  	select GENERIC_ALLOCATOR
>  	select NEED_SG_DMA_FLAGS
>  	help

Nit: Did we drop depends on 64BIT intentionally here? I guess the full
PCI_P2PDMA stack still selects NEED_SG_DMA_FLAGS? IIRC, NEED_SG_DMA_FLAGS
doesn't select 64BIT?

With the nit (and Bjorn's comments addressed)
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
