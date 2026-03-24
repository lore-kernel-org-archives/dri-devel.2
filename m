Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFF1FEC0F9
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CE2F10E529;
	Tue, 24 Mar 2026 19:11:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="Uz3KGgiC";
	dkim-atps=neutral
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A0C110E529
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 19:11:46 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-8cfc497a604so604824885a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 12:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1774379505; x=1774984305; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GgkzaFQD+hUjoaCAACM9eToN2Ozqi3oZGhlYET6dGi8=;
 b=Uz3KGgiC5Ll5BM4w6ggZly7UnGggfpM1XzoS8C8cx7rdK5QsuxpYwT2e3LQFBfaa6w
 +TOQ0b3Qmip5tk2dv3Ju08GeHwjuZ4KIOSzqWfJatDv7iGc08q1/KBnseh8Ani5uOjqJ
 YgJOjRZeuDY7hbQxWfhuQT1qIhyoKPHSlxGYQgakWp3ApykqkBY2a8Pb2ULbdnwOkmjk
 RQWC5GlUpi2dZeQz32javRaX9suI2Xk3c0eifZhXo9OMimgRJiTz30lxeC+TuuGhf/8C
 CHz38BZcLbPlrRWQhQyobocNuYtLALCbi99mGz4jzAPIL1uO3Yvr62dk+FdOkwBP96O5
 ayDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774379505; x=1774984305;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GgkzaFQD+hUjoaCAACM9eToN2Ozqi3oZGhlYET6dGi8=;
 b=AamDgKGkVEKvlL3XfFtD6lx77tpBH/DYNLb5QSL3tI8W5At7OuE7SvVkImduDs6o8p
 +Okqqheyase7H/PDpKIJn02zdGXDG68ePjIhrGmLIFICM2+pJV/xjVx7qiSbUsU21+u2
 tzHbDPJFiraKcPTko86qfwzXDOt0zwYNgJjIMyTwXUuo27kQBoheWql1tGz6yKTedNZa
 peDgq8H8uD7rNfYIyKi9qKyTojN24Fq7QpW8ArpDeh7HoS2FjXrj69BngK2pnc+KEY3j
 qfmIRy8JNCNwMuN914Sc47QlKS6dlXKai62xN8cM7aFeEzDcCYY8LcVrwyFSBgKqbTHr
 nfpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbgvr6pQ2szuWD15YmFfAYQQshQoHz7Ia9O1J8tI/DyStVZR508AC7zC5KQjn+nmHGNQq7gYPX5cE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxLpMCa/svyq5OmZspz6gxoVTf4nr1CF4xZCP6ISF2iXYkYT8Tx
 4GgS2AzKpacEcMvpoaMTbUiM4O9cNCpIYmLy3CXill87ESYknwgQyucdEN8rphDGYAA=
X-Gm-Gg: ATEYQzwpcWcBUnmAi8Eq7jlpjB+RIMsL85IIl4MOG1HA5m3dcjr5YFANdN/zQjF1mtD
 aYO2wqe+6sA1bvuAir8yevNMGUFz3W4ka/AxyDVD6vBPjzC3wbI2Bw9kwmAuPVLpG77Phs3IJwZ
 m/Z7JKDXdDp7WnnYY1o45Uy7/V900XIbkdMi8YpZqj+cypvTWC6AJW9D2U1Pg5LE9uJFEFfW1YB
 6UqLP6pi798rj2SQanpXqE0qOZrmaHYBCPZUfw/yIkusLxat4z72V0fLPH3YMt+kYiJ4rXobdwE
 QLoNm0bspIwlPjv0wM3wG2M3Nicp2mBLl4+uug/wV16wZYrrX/nENBu1+HrDioJt4KRVii/Ki3V
 4AmDhvLv/vnwwaUyopGTSbVurGTXBcArKregp6X0xOVMxc7ROjxRlncAKpZOhsgxkUGDTiqAbJn
 cMt2RLsXgXF43SKHWInXLfGfU4aBRfx5XSFSf5YLpNS4U801ftsf9/JS19+nR9Tr4YjW3Mpw==
X-Received: by 2002:a05:620a:17a7:b0:8cd:7fc0:ee1c with SMTP id
 af79cd13be357-8d0010038c4mr104803685a.22.1774379505164; 
 Tue, 24 Mar 2026 12:11:45 -0700 (PDT)
Received: from ziepe.ca
 (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net.
 [159.2.73.22]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cfc8f91d32sm1083581885a.14.2026.03.24.12.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 12:11:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1w57AF-00000000JZi-3000;
 Tue, 24 Mar 2026 16:11:43 -0300
Date: Tue, 24 Mar 2026 16:11:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, sumit.semwal@linaro.org,
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
 jstultz@google.com, tjmercier@google.com, christian.koenig@amd.com,
 m.szyprowski@samsung.com, leon@kernel.org, sean.anderson@linux.dev,
 ptesarik@suse.com, catalin.marinas@arm.com, aneesh.kumar@kernel.org,
 suzuki.poulose@arm.com, steven.price@arm.com,
 thomas.lendacky@amd.com, john.allen@amd.com, ashish.kalra@amd.com,
 suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH v4 1/2] dma-mapping: introduce DMA_ATTR_CC_DECRYPTED for
 pre-decrypted memory
Message-ID: <20260324191143.GF8437@ziepe.ca>
References: <20260316125857.617836-1-jiri@resnulli.us>
 <20260316125857.617836-2-jiri@resnulli.us>
 <15fcfa5e-c4b9-4b56-8f84-20dd5f66d643@arm.com>
 <lufy3ppgiy7637iravgzabajj67chmqvg22qc3fd2yqe2p33ws@b54vibhehth2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lufy3ppgiy7637iravgzabajj67chmqvg22qc3fd2yqe2p33ws@b54vibhehth2>
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

On Tue, Mar 17, 2026 at 09:26:21AM +0100, Jiri Pirko wrote:
> >...although, why *shouldn't* this be allowed with a vIOMMU? (Especially given
> >that a vIOMMU for untrusted devices can be emulated by the host VMM without
> >the CoCo hypervisor having to care at all - again, at least on Arm and other
> >architectures where IOMMUs are regular driver model devices)
> 
> Well, when iommu path is able to consume the attr, this restriction
> should be lifted. This is basically a sanity check for the
> dma_map_phys() caller.

Right we eventually need a matching IOMMU_DECRYPTED.

It needs to mirror how the CPUs work - any place that would use
pgprot_decrypted to create a PTE should use IOMMU_PROT_DECRYPTED to
create an iommu mapping.

The current hack in AMD assumes IOMMU_DECRYPTED behavior for
IOMMU_MMIO, but that isn't general enough..

There is some maze to get there but for the moment I think it is fine
to just not support vIOMMU, it isn't like any vIOMMU drivers even
exist for CC VMs right now.

Jason
