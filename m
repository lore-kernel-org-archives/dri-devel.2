Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E58C624D3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 13:42:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8F4C10F200;
	Wed,  2 Sep 2026 13:42:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="bdHgKtxQ";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E1C010F218
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 13:42:41 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d6ff3aca06so24645ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 06:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788356561; x=1788961361;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZSTpKHWOHnBacMTdwSxpJ9Et4v7FJnMFRqiSvtmfiLI=;
 b=bdHgKtxQiefgWzJF1vbbOR0LneqjxsmY/EUn53ZIVNpFV6XWorcRKMlXE75alv3u+L
 BEyvfMFQQQvPDV9BUmSD2ZjFyPjQEq6CtsAxmMx/iS22CFoctbqNKnTN1670UjRC/gCx
 zjyCNj5MS7s/E+VWsp2QknQyaDHB7Uv3kSvFjPQ563fm4EqW1rDFquGPmwI3IrVNsbvd
 i5cKYHf/MA+DQajIyQix9+6wWJ/DJB/w65L2G2D9iDBt2Te+/Y2LDmnK6NVykEp08ZUW
 YaebTZ2tuc9vTK0Kd3PnK3Vp8MnyOZRGJ/oqzRpH1l+tCcm8DwRDxt9uNhf1TxfYwwrW
 l3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788356561; x=1788961361;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZSTpKHWOHnBacMTdwSxpJ9Et4v7FJnMFRqiSvtmfiLI=;
 b=Hdkz9nIncpf3vy6qTmqrO1SuoLcHSldei7mJ60xgaKucHxQL3keSE3xPXonXU3YkXf
 BMDOB4xEZ1ZPrby5Bwzyv55cyNhy+Pw+6NxKMxGbXadI0y31n1YUlai8rdbxvTdYuHVY
 xTBudklYrBANgjey8skcOmk8zwIkuAhPMyBDa57S5oI4EbhPMLoOAA0wFRA5yYxgQiWI
 tVhbRqUzTVg0zex8aXuRXWjbTRdhfziDe7vh/C2Rd7NW55enDslHYR1tJnRjYGBW9bPI
 PT7dXhgCwUbY0O7VHea8DsO67Eq5b5DO3/gcNf+NMlapPmFGoVmq6ICIjjDr83udfX07
 WPSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByZKRpcZtw6iSqguvwoyvh15WWP6eMHqSBrI2MmCwAuWSUMczEJM7v5m9mcb2PdDFPnyIe//ABFxdU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n03DnUbqhuq1WNH03rue739iIe7h9+JtYEdKYnCE+BUpTjqUgR
 wvKzgHSXIuRdzfjEe9ul44dVnwE5FIWSG5VhdWgr25mjCvNbB/pZbvOmTkQVxJ/BaA==
X-Gm-Gg: AYBFou3Urq5HdvSx7pdgFYnVZQrrdYZLmmFbaY8+N3MPGwOiJwtkbI+YlFkaBooKDj6
 159GnOW8thGthgbTr8EHTU1fK9m4DHoAMS+GOlEpNzBeQ9A+2sQkZUBWsqGKVIoaeGJJGM+UhNE
 Uwtvnn+/x1wR6ml8Sndm04awjuzOkx29sOKX4Gv9ByLzQ4CqlZCXgFT/Yxu0XyPa7rPw+KslFs8
 BGJ24SOnRyoJf1TreDvTt5WrLzQjHf9AncYiB20cMMqn2llM+vp7rY/b3Df+xrsOHiJPgEXSNPB
 SDEGuit0oH8zftTNeY8APIGLj5fASVw/BABXi7LWf5ksswZ00HojvtJkUHzHUybfH7OABQlScFw
 rb+KqLJsDn8RaKYgQbW6+ZEt50RRWmwTej7EGgYn0lRARmEqoPe7ZhiXcYmj78JfmiXfSGXNkCo
 FKbz8S1mXdzC25enQuzs5M4ZHxhinKc/efDKSjQSoD9lHVF/4u5lfmXmvOMFpKrUquhxPR5Xa9E
 MpwxRdV2+wSw30MmKnTDJsMFKA=
X-Received: by 2002:a17:903:19e3:b0:2ca:4bb4:4bd with SMTP id
 d9443c01a7336-2daf66043c8mr1378505ad.5.1788356560192; 
 Wed, 02 Sep 2026 06:42:40 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com.
 [34.142.210.164]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc003aee2sm1404704b3a.30.2026.09.02.06.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 06:42:39 -0700 (PDT)
Date: Wed, 2 Sep 2026 13:42:31 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, David Hu <dhu@x6u.co>,
 sumit.semwal@linaro.org, alex@shazbot.org, ankita@nvidia.com,
 chriscli@google.com, david.laight.linux@gmail.com,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
 jgg@ziepe.ca, jmoroni@google.com, kevin.tian@intel.com,
 kpberry@google.com, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 nicolinc@nvidia.com, sashiko-bot@kernel.org, stable@vger.kernel.org,
 viursachi@google.com, xuehaohu@google.com
Subject: Re: [PATCH v8 0/2] dma-buf: Fix silent overflow and alignment
Message-ID: <apgnx0pirQ2SUcmY@google.com>
References: <20260901170849.4052816-1-dhu@x6u.co>
 <2bf581db-7cc5-4f38-a075-1b988c332f3c@amd.com>
 <20260902073936.GR24140@unreal>
 <aed39f83-6340-4fe9-890c-6d5f340c97d6@amd.com>
 <20260902083232.GT24140@unreal>
 <aae19599-2ba8-41fd-b3a9-b1f80107f563@amd.com>
 <20260902095338.GU24140@unreal>
 <65dc4ca1-6882-490d-baad-3e0abd708af3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65dc4ca1-6882-490d-baad-3e0abd708af3@amd.com>
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

On Wed, Sep 02, 2026 at 12:00:25PM +0200, Christian König wrote:
> On 9/2/26 11:53, Leon Romanovsky wrote:
> > On Wed, Sep 02, 2026 at 10:44:59AM +0200, Christian König wrote:
> >> On 9/2/26 10:32, Leon Romanovsky wrote:
> >>> On Wed, Sep 02, 2026 at 09:56:06AM +0200, Christian König wrote:
> >>>> On 9/2/26 09:39, Leon Romanovsky wrote:
> >>>>> On Wed, Sep 02, 2026 at 09:00:46AM +0200, Christian König wrote:
> >>>>>> On 9/1/26 19:08, David Hu wrote:
> >>>>>>> From: David Hu <xuehaohu@google.com>
> >>>>>>>
> >>>>>>> This series address two related issues in scatter-gather mapping,
> >>>>>>> specifically for the MMIO based dma-buf mapping. The fixes ensure
> >>>>>>> sgt mapping is correct, and proper for large MMIO regions.
> >>>>>>>
> >>>>>>> Patch 1 fixes a silent integer overflow for mapping length exceeding 4G
> >>>>>>> (Previously submitted as [PATCH v7] dma-buf: Fix silent overflow for
> >>>>>>> phys vec to sgt)
> >>>>>>> https://lore.kernel.org/all/20260609164047.486227-1-xuehaohu@google.com/
> >>>>>>>
> >>>>>>> Patch 2 Splits sgl by largest page aligned chunk
> >>>>>>> (Previously submitted as [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk)
> >>>>>>> https://lore.kernel.org/all/20260722233806.3922093-1-dhu@x6u.co/
> >>>>>>
> >>>>>> *sigh* such issues are exactly the reason why I didn't wanted the dma-mapping stuff inside DMA-buf. That clearly doesn't belong here.
> >>>>>
> >>>>> And this is why so many in the kernel community want to get rid of SG
> >>>>> lists. It would be great if DMA-BUF could also eliminate the need to
> >>>>> convert to an SGL, like Jason proposed.
> >>>>>
> >>>>> The DMA layer no longer needs SGL. These bugs belong to the DMA-BUF layer,
> >>>>> which is the one that depends on it.
> >>>>
> >>>> I'm all fine using an array/xarray of dma_addr_t in DMA-buf, just phys_vec is a clear no-go.
> >>>
> >>> You are proposing the same thing as an SGL, just in a different format.
> >>
> >> Yes, because that is the right thing todo as far as I can see.
> >>
> >>> It does not address the issue that dma_addr_t is expected to hold a DMA
> >>> address, while that is not always the case. For example, in the P2P case,
> >>> the addresses are not DMA addresses.
> >>
> >> Yes they are. They must be DMA addresses because that is the only thing the importer needs to do it's DMA.
> > 
> > They can perform DMA, but that still does not make them suitable for the
> > dma_addr_t type. For the PCI_P2PDMA_MAP_BUS_ADDR flow, these addresses
> > follow completely different rules: they are not unmapped, require no cache
> > synchronization, are valid only for peer access, and require separate error
> > handling.
> 
> The PCI_P2PDMA_MAP_BUS_ADDR is not supported by DMA-buf and as far as I can see is a complete dead end.
> 
> > All of this information is lost if only the dma_addr_t is stored.
> 
> Yes and that is fully intentional.
> 
> DMA-buf handles that cleanly on the buffer object level and not like PCI_P2PDMA_MAP_BUS_ADDR as a completely broken design on a per address/page basis.
> 
> Technical background is that the PCI_P2PDMA_MAP_BUS_ADDR approach can only be handled by a very very small subset of HW.
> 

With the rise of accelerators, the P2PDMA_MAP_BUS_ADDR is going to be 
increasingly more common where accelerators directly transfer data to
NICs, storage devices, other accelerators etc. 

With VFIO gaining a DMABUF exporter the use has already spread to RDMA &
NVMe devices (w/ SPDK). In fact, we found these bugs while trying to map
large BAR regions for RDMA.

Thus, it would be great if we could find alignment here. 
AFAICT, I foresee the use of dmabufs to only increase for
PCI_P2PDMA_MAP_BUS_ADDR. IIRC when the network stack moved to net_iovs
to support dmabufs, the SGL became a primary concern and partly the 
reason why we have "unreadable" skbs for memory we can indeed access
if mapped correctly.

Thanks,
Praan
