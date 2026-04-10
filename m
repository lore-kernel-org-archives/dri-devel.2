Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182C5F44852
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 12:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6656710E964;
	Fri, 10 Apr 2026 12:20:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="NqtE3ZUG";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8140E10E964
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 12:20:51 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260410122049euoutp0143673c5084fdbd183ef4d66d37caa67a~k-jNd8WTG1907619076euoutp01A
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 12:20:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260410122049euoutp0143673c5084fdbd183ef4d66d37caa67a~k-jNd8WTG1907619076euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1775823649;
 bh=lN5zWO6+anmGDngLkOfFZEph7VAV3nISscwbspgkQFg=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=NqtE3ZUGhjK5b+8l3UJojriJ5nrit/EwmaDAMcMN1Br+4xN1xUNTVGwRO9rgOuFEb
 Bx2jTuJ8f+oN9wlq+XE/SWAFwLerZjUb96fqzAMZHDkFsEJdpJG3ASlCz+YzeKizNO
 GJFKrCnlGUMsKgU/vRZdu0YCgkUV/c9nFfJj/i48=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260410122049eucas1p2207046638096d1540b23f0a14d6169ac~k-jNEfoaG3206132061eucas1p2p;
 Fri, 10 Apr 2026 12:20:49 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260410122047eusmtip17c8b02f981e525f46be03f8d2d0e134f~k-jLa09If3110231102eusmtip1Z;
 Fri, 10 Apr 2026 12:20:47 +0000 (GMT)
Message-ID: <9e3f7066-f147-4854-b662-9027fa7d3c80@samsung.com>
Date: Fri, 10 Apr 2026 14:20:46 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2] dma-buf: heaps: system: document system_cc_shared heap
To: Sumit Semwal <sumit.semwal@linaro.org>, Jiri Pirko <jiri@resnulli.us>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com,
 tjmercier@google.com, christian.koenig@amd.com, robin.murphy@arm.com,
 jgg@ziepe.ca, leon@kernel.org, ptesarik@suse.com, catalin.marinas@arm.com,
 aneesh.kumar@kernel.org, suzuki.poulose@arm.com, steven.price@arm.com,
 thomas.lendacky@amd.com, john.allen@amd.com, ashish.kalra@amd.com,
 suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAO_48GFt21rv0PJd2Csa0O4OEpN053_p__4Zux+m7jQdHSagEg@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260410122049eucas1p2207046638096d1540b23f0a14d6169ac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260410121457eucas1p1450d22bb1d09d9978fe68e801d8c2a58
X-EPHeader: CA
X-CMS-RootMailID: 20260410121457eucas1p1450d22bb1d09d9978fe68e801d8c2a58
References: <20260407092617.635223-1-jiri@resnulli.us>
 <CGME20260410121457eucas1p1450d22bb1d09d9978fe68e801d8c2a58@eucas1p1.samsung.com>
 <CAO_48GFt21rv0PJd2Csa0O4OEpN053_p__4Zux+m7jQdHSagEg@mail.gmail.com>
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

On 10.04.2026 14:14, Sumit Semwal wrote:
> On Tue, 7 Apr 2026 at 14:56, Jiri Pirko <jiri@resnulli.us> wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> Document the system_cc_shared dma-buf heap that was introduced
>> recently. Describe its purpose, availability conditions and
>> relation to confidential computing VMs.
>>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> Reviewed-by: T.J.Mercier <tjmercier@google.com>
> Thank you for the patch!
>
> Marek: Since you're taking the dependent patches through your tree,
> could you please use:
> Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
>
> and take this as well?

Yes, sure. Applied to dma-mapping-for-next. Thanks!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

