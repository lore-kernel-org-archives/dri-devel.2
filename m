Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546F5CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 15:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E15510EABE;
	Wed, 10 Jun 2026 15:28:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="W+wAHRNE";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7C4810EABE
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 15:28:06 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2bf22c18ad3so104245ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 08:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781105286; x=1781710086;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rRGcDEeCGM58JoYwcY0kneIT0WSa4bKVwTj3Opbvtug=;
 b=W+wAHRNE7X6aanv3cQ82c1yDc9iVmWyElMj8zyarGtlGB2uVR/4Zn39z+QbIiJf4El
 /ITmI2+NHlP4SK8lKBD7LN7MlwxDMjijzk4Sbe3JkvqgyuqHxWEiOphtyW/bqXqirwzf
 ZNfRKDkrV3sHHFbyZOooU5GqJTADrnNbXKAXSLlbRyfO6gSv8/ju30ybIouh6NetkmTZ
 YL8nzAlEMIKjxFS9bIWu35vc/wvzAKjMots/+GgQaQ2LN+TYM+nJtpW0rzedU+DxAW52
 +SwT4XZ5R4IfAr/cb5yq5sAEKew9mWn2Hq/dU2FpmQ72FPm5Lfnx4JgBkFMaT4gbloXg
 JgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781105286; x=1781710086;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rRGcDEeCGM58JoYwcY0kneIT0WSa4bKVwTj3Opbvtug=;
 b=jL+pBTw8CBY70pQFbk9K34x/R72D+fZpQVQ8/4qp+mtpUlL5+rpgiCd9WDtHn8UNZD
 QPNDHGBXYby9wjVpTByu83fCpbiMUPb3R1ekEXYplpI+BGOHu4v1OeXH/8ekUJBEVhEP
 PXOe0Y0K+Fl3oYi+GQV8vvpxMznZ1BhAJpv96dJKaHyjUP29h5cJwv7KfuVH8eYV8gg0
 gGyDe0+5vWKPa24x7Dap2QbxdoZNjsdS0geAEnjj5m1x7EH0nsf325XdJKM3QEowiEfB
 E4PtvrpjvK/8/Rw4KLblIoQNXvp3M2j6/jywPQbH8fk+03dYlbTrXOtyDgeEG85HWmz3
 yX/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ms6bgLRMtxnlFsNSU/Fj4n3YTVbVWDforFI2pWVBUauJekyuvZ+c4r1yqhVEmUz1MPUVjzdOUSCo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHJlIeQyhCqzH0waOOVKxG9GO0yBMkMcCvMKp9CDXHcKFF1rAh
 l5mbXzS8RszxiruA5yWdT2JX0T7lFHxH8mHTNbLvH3KxVkJiUPdNKegBB/xxmoj2/Q==
X-Gm-Gg: Acq92OHBOvHpb70DvBeXr2sIHQAvLwgYvIAm/Wq3Q4qxbngVW6FI5gR5koFX6AmG5O5
 CWIxOs0DhWbK8WFpxvyOk6Pe3YVAI9zAtBd+Ap2bhDF4sr/+xWkLpbm5Xa89Nvf/NVZFn/yLIZL
 ou+kJmYRwG6sBFF11II++ctqpjPtlUAs68l1B97O4znm3BVuU+eGouIe/oXruoTucO10wT0+KEn
 PwwF+LbX4oZQNIPIEdJkUpjr5/vNE2FLZvu2klj3zN1XH6VEhP782OFnSzjtyNL2wj7UcQjRZ47
 7/vcfBBQ/iz26EgV1H6SDFnHW6P0GYqoA/mFJf3Y949pOeXttg/RWsQNRdDOpnv/zFVt6utyQIV
 QAQt1dhdwx4kcUZtuz4Lsc2tDCn/heNnZYoCkSTtiu3PgC2iLUbGNTuzySPDg3jHhEaiKfptaXf
 skV1OITlkr3RXLA/DczOSXHTBZLDcOnxZusqvNsrIs5We+DrQ9PMjCpM6Y1MtAvEiNwj5U5Ls=
X-Received: by 2002:a17:903:1ad0:b0:2b0:b925:da98 with SMTP id
 d9443c01a7336-2c2d941bcf3mr118265ad.19.1781105285671; 
 Wed, 10 Jun 2026 08:28:05 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com.
 [34.142.255.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164fa00b3sm237800395ad.32.2026.06.10.08.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 08:28:05 -0700 (PDT)
Date: Wed, 10 Jun 2026 15:27:57 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
 Matt Evans <mattev@meta.com>, Leon Romanovsky <leon@kernel.org>,
 Alex Mastro <amastro@fb.com>,
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
Subject: Re: [PATCH v2 1/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Message-ID: <aimCfaCM-m4TS2g9@google.com>
References: <20260527102319.100128-1-mattev@meta.com>
 <20260527102319.100128-2-mattev@meta.com>
 <20260527150946.312b3042@nvidia.com>
 <20260529230553.GE3195266@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529230553.GE3195266@nvidia.com>
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

On Fri, May 29, 2026 at 08:05:53PM -0300, Jason Gunthorpe wrote:
> On Wed, May 27, 2026 at 03:09:46PM -0600, Alex Williamson wrote:
> > This deserves a /* CONFIG_PCI_P2PDMA */ reference like the previous
> > long span, though potentially a better solution would be to split the
> > core code out to a separate file with shared header.  I asked opus to
> > see what this would look like and it generated the patch below
> > (unverified, compile tested only).  Bigger diff, harder to follow
> > blame, but the shape of the core is much more apparent.  You're welcome
> > to take or leave it.
> 
> I think it is a good idea, it will make it easier to add more stuff to
> these different aspects.
> 
> Really they are now two different things with one layered on top of
> the other.
> 

A little late to this party. I agree with this split per status quo.
Although, one observation from me, I've posted a concurrent RFC [1] that
implements ZONE_DEVICE P2P registration for VFIO. That work relies on
pci_p2pdma_add_resource(), which requires ZONE_DEVICE and the full
CONFIG_PCI_P2PDMA stack rather than just the CORE part.

I guess I can be careful to guard the ZONE_DEVICE P2P registration 
feature in VFIO with the full PCI_P2PDMA config. Apart from that, this
split provides a clean foundation for both series to coexist.

Thanks,
Praan

[1] https://lore.kernel.org/all/20260610151853.3608948-1-praan@google.com/
