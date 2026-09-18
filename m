Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D35C982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 17:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E683310E961;
	Fri, 18 Sep 2026 17:05:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="G5Bz4EP/";
	dkim-atps=neutral
Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com
 [74.125.230.235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4FF810E961
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 17:05:29 +0000 (UTC)
Received: by mail-qk2-f43.google.com with SMTP id
 af79cd13be357-939109fafd6so85147985a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 10:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1789751128; x=1790355928; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zQcyEtFjPBr6Six+ddaDb/CoGlSZSKi7ev20pm6BxlM=;
 b=G5Bz4EP/awL69ku5Vc595wJZ7faxMMDpX9qkvrFPOc+RzdDcpGOaw/jFKInvzFnL9z
 XREmv4nPg6EVjVFSv5kVroD0Nj9jE7XP8M61OQhyq+77e4vb8ZXir6/xxMfrLC0PsIaE
 Y0i0iuYVFo8aJQWKCiDXZ7wnZwUEiFrkVmSh08XjwOY2MeR6rJOMw38XqxuxNyVhERsy
 gh89eFtkvk4gSuviH1XYInoc6dYhJbDcvDQYUAdV8uYsUDXZeS1uzdhpS8I0usYtn4bI
 QKIeZI635aP4fA5NeKtXeN69FteSBQrCUaZwxyaAKN/bMwByWjlvT/j6aQOKRQslt1nq
 nRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789751128; x=1790355928;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zQcyEtFjPBr6Six+ddaDb/CoGlSZSKi7ev20pm6BxlM=;
 b=iQtndiCe9yX8tXwiJ6Omc6N1Fcl2tds2crLe9lZDYQUQ3Wa384xdvh8ArMtq7FjtVj
 or7abfEP+JOjR1g0OF3BM8u2zxSG/ZD+AjHfZYzFq7a8mQgZvuaAEJ3lDLUJbhEMPQyo
 XFOdivRnRIzeudh2vzPctNstzCE+qzKlmgwT/8vGNQGSpcq8CuxVuNukmn8FthnN/Oa0
 2pkzQF8GqbcYcB68kkyZVzoz9ZtcYTm1Q0+YCsu19qeDCVfro0/dZ+7J5vaFLK0sbJQd
 SrTiIXevZpnndHkZgbXi4hpPitjGHleE79YmYZKxC7jEDiG4sUrc2FjfPFAmV6Zj9FHA
 8zCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLVMICPyxI1PUHmj9PFKTVFhGuYB4VA2gHZir44Z9zgREB3MlUjbu27RBtmr07FS41s4/AITeSppA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ngaacY6ucp2EPrhJSZE1hlp3I9uP0SJEn8/GvVqVXVDsgGunR0
 8OIvXOwGZUhlCJjVpJ1JaBbIityQ2lFI/dw2fE3nb883P2IBWr2Cmt1S4rcaDzqHiT0=
X-Gm-Gg: AYBFou2CeiBalTFk/B6IFdYgeMk4RTwELAJoB6FlGdZGDtxk67Ono8rPncLxf8CTw34
 3t7In8vlY8IvldpSzp0dLBi4ykR5WPWh0H6x/D6ayOo4DPGKkgLS6nR2InJA8N3NhKGTzoxcpJ8
 9SykmTgFqTHAZFVZTS1lwRwxjNObRWVcO33IQrXdiBBCi3FQMz6lvsiYnfK5DYHf9JcL4Qw657D
 4P/a0m60z20VDJWEF/syFynzdn9h3glLrxDjTFQtYeoVa0YIx/0w9PXBs61nf5Rzk72vrc8u/8I
 AzmIRKHVPomgG8eLnBzj1nBRHglgaL4mij3JdD+IdWg+urYeZRFU9dil9sMe/I419Z/bPCDkuln
 sXOVRp1WmUVpyTJxzPwA92uSWJcOyHfBl+hG60Buex12mIzkN8gNzuEiRcn5N/P5w4jC/Yt2nwV
 Tm3kCiDAlXBCZM0NvbXT0g+M3CRe5bjpRcFxe6mqw1FPkY9KSI/YtcKSuzz7sGee66A25ue4S6a
 c6JfJi8B/MOyLPlypOCLb0K+5q7CQS6x1hytJ3vkp+JFxANYEjcU4fg
X-Received: by 2002:a05:620a:440d:b0:93a:83d:1d26 with SMTP id
 af79cd13be357-93bdc6c7741mr490404585a.32.1789751128040; 
 Fri, 18 Sep 2026 10:05:28 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net.
 [159.2.239.150]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93be0cc67e6sm187224885a.5.2026.09.18.10.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 10:05:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1x7c1c-00000001zVZ-3Nwz;
 Fri, 18 Sep 2026 14:05:24 -0300
Date: Fri, 18 Sep 2026 14:05:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
 Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v6 18/18] RDMA/mlx5: Ask P2PDMA whether ATS takes a
 direct peer-to-peer route
Message-ID: <20260918170524.GH11599@ziepe.ca>
References: <20260914-fix-p2p-acs-v4-0-v6-0-5ef07ec9ef06@nvidia.com>
 <20260914-fix-p2p-acs-v4-0-v6-18-5ef07ec9ef06@nvidia.com>
 <321890690ce83d1943b2f678bd9bee9b8c895b66.camel@linux.intel.com>
 <20260918121500.GV13683@unreal>
 <b517070d0b9236b03962fcba649faffcacda23eb.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b517070d0b9236b03962fcba649faffcacda23eb.camel@linux.intel.com>
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

On Fri, Sep 18, 2026 at 03:42:28PM +0200, Thomas Hellström wrote:
> 
> 1) Xe attachment check if pci_p2pdma_distance() returns OK for the
> path. Then Xe always sets up dma-addresses using dma_map_resource(). 

Open coding pci_p2pdma_distance() in drivers is a hack. Using
dma_map_resource() like this was never "allowed".

We've fixed things so these hacks are not needed, the drivers need to
move over to things like dma_buf_phys_vec_to_sgt() and the hmm helpers
to use the DMA API correctly.

> 1a) Let's say the importer (Xe) has ATS enabled, and the exporter is
> supposed to map dma_addresses.
> In between there is a switch that allows direct traffic.
> Now with your patch series, How would the exporter know that Xe has ATS
> enabled and therefore should return IOVA mappings rather than the BUS
> addresses representing the shortcut.

The thing that does the DMA map must be aware of what PCI TLPs the
PCIe initiator will use to compute the proper P2P mapping mode.

ATS always needs an IOVA but that still doesn't mean the P2P will
work.

> It seems to me that a pci-device settable flag "ATS always enabled"
> should be enough to fix both issues?

It should be be per-mapping to support the NIC workflow that isn't a
global operation.

Jason
