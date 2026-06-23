Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C00CDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:38:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4249F10EAFC;
	Tue, 23 Jun 2026 12:38:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="BNgKUhch";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A862810EAF4
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 12:38:16 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2c6b7bd4e8dso46085ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 05:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782218296; x=1782823096;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kRyC6uc9PiBbjK9ZqA0DFvnVffsSMfHhakITg77vSEE=;
 b=BNgKUhchCiP6SybN/27XcazdTEVzRk7BihaCmfHQDuZoZXQt4SCLQhNfqieFh6KDZJ
 VNpem1EsEqEyWNHpVEYX6dFirbclpoBI10weK2HL/oT7Fj6taTd92d5+EsoKF0iS6+43
 /WFi92+Qi5pE1xID4mpyOCD3JZ2hyoolFHYpXb7n/EyXpV0kIB6ktRcf9IO4OsLg0pIc
 x5LmsISn2HDDyWcFAlK0CcoWwU+27w8ki1ZTxrg9xWCtr77c0FYp+P7Ld27vTpF7d9Z7
 7vZOlJ1n7GoNWqat46FF85+Hna4G4d3/tmwoHEHLC0S4sOTymMGcO3T8NNDWjVQMM8z9
 zIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782218296; x=1782823096;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kRyC6uc9PiBbjK9ZqA0DFvnVffsSMfHhakITg77vSEE=;
 b=sQ+V5gvvK1hB/0Fr8tpyBkYUdZ7YBmQrcBar9EAC/NWbW61Aa/OtpHEoadu3yIyvhd
 y4EPMCx+i4Cmc3J06NhwqldnNSlxcYdJ6g/8hJ+biM30L2VruAUz4XPZATe1I5Kgj4+8
 FQTF1sYCMSgnrI35IpiZi3r3e6DGkLGCy23J18idLW7DWFqH6C7fsV6dtgFuQ+GBHzJ6
 uDb9Cpqxra0PMySO2bs3GDROHi8py3UZT633mmfxv/EviGDNyCEi+A1RJtaY4PWOxAKa
 SHJIS+U+tFY/H5X1BLeLbw/FSAVF5e9mNKEDsAQ42R8Q9CHXpKWs2oBAKpoEAY6mpcuM
 ehNw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4RbZjorkG88FWF3/4Q0cCqgQH3GLXCFHdPJHo7D19MedAbCo6qUbeONWOi+jnDhkqyEpxQ3iwWys=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywlc/Qz46lFMmEgNbXF1aVwCidlttwHPKaNwa6hQYXDSPGbEm8A
 5dOjUoZxBBI0zMBWjuqDIezNAif8Q6tVi3t2pFXUJ5I442hz796nKZsFG/YgneurYA==
X-Gm-Gg: AfdE7cnlXzQC9OdEl0YJr/SRNMRPohONXPmNV9HYDoTxyRu64wEXphEZUaKEkM1Kldf
 W9V3E0t75R86WJBB4jjultnSPxqr1MUzhh1sEpTDz/riHRtY3+Ql5jR5VE+Oq0OcAvIk6oeDHlV
 flG438aoMySkLsRQW/+v660JKgZgQRdw2Srhd3ATcpIcs/v63ajA0VRvPkj/8IneOdH7oBZBbCV
 ycYMvVR3LuWIguMhQ+aR0P4TMMee+TIcTro/HaPL+3RXQiELZUyhucUOFeiB9lHuFIbLWTT974s
 Swu/8SBl23501kS4g143B3sl0aSTVXwiiROkqVYCw1K0aVKEwnfWBAnWZMR5bDkDge3X2IwOzwA
 gPbhkyZEoF8djIRxcwbrhH2eOBysByYwnAlLYtUtwIciX6qyvEvAjltLYDZkPD48bq5xLr+aF4t
 PKMD6B2TfLDTkooPRXWuXAD/arAOZIYr5CTblnHHD6jC3Kun+lxXQsojBk7Tvm
X-Received: by 2002:a17:902:e5c2:b0:2c1:4a67:5f31 with SMTP id
 d9443c01a7336-2c7c70efd4emr1597435ad.9.1782218295641; 
 Tue, 23 Jun 2026 05:38:15 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com.
 [34.142.255.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84564d6c2cesm13106102b3a.2.2026.06.23.05.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 05:38:15 -0700 (PDT)
Date: Tue, 23 Jun 2026 12:38:07 +0000
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
Subject: Re: [PATCH v3 6/9] vfio/pci: Clean up BAR zap and revocation
Message-ID: <ajp-L7wHQ2rQFK97@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-7-matt@ozlabs.org>
 <aixgZQiBQKgS7yIM@google.com>
 <62970f4b-e624-403f-9cdc-02438c820d23@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62970f4b-e624-403f-9cdc-02438c820d23@ozlabs.org>
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

On Thu, Jun 18, 2026 at 05:06:27PM +0100, Matt Evans wrote:
> Hi Praan,
> 
> On 12/06/2026 20:39, Pranjal Shrivastava wrote:
> >>

[...]

> >> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> >> index 86362ec424a5..51990f6d66d5 100644
> >> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> >> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> >> @@ -1692,6 +1692,14 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
> >>  	if (ret)
> >>  		goto out_put_vdev;
> >>  
> >> +	/*
> >> +	 * hisi_acc_vfio_pci_mmap() calls down to
> >> +	 * vfio_pci_core_mmap(), so BAR mappings are still
> >> +	 * DMABUF-backed.  They don't require a zap on revoke, so opt
> >> +	 * out:
> >> +	 */
> >> +	hisi_acc_vdev->core_device.zap_bars_on_revoke = false;
> >> +
> > 
> > This seems to be happening after we vfio_pci_core_register_device, which
> > could be slightly problematic if another device in the same group races 
> > to trigger a hot reset before we can set this to false. Could we 
> > initialize this flag before registration instead?
> 
> Remember it is a safe default, so in the event of a driver not managing
> to opt-out before it's required then all that happens is a redundant
> unmap_mapping_range().  The default-safe was a nice suggestion from Alex
> on v2.
> 

Ack. I see. That makes sense.

Thanks,
Praan

