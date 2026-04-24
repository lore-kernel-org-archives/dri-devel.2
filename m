Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF52FE5206
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 11:13:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 978A210F4F7;
	Fri, 24 Apr 2026 11:13:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bmWYFYeG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C65710F4F7
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 11:13:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id ABB1E43B96;
 Fri, 24 Apr 2026 11:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B317C19425;
 Fri, 24 Apr 2026 11:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1777029210;
 bh=GqTs5ygTosFneocKlPAOSsqLvTcgAi1JqGhpB7fqPO0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bmWYFYeGbYMYG+FurHRaKqSkn/WAjZM4tyqApKy29MaSa0pS2QhfJ7BhV2FWlS7R8
 +7naXHvd44tPIESI0DP0qLKtvg8i1pa7ncTFH6RgzPvrsurmEumHnN043jovr6nj5n
 gP/JSsNiCdL2v0v9kbUJE99lp8N7eJBBJJrsQH10=
Date: Fri, 24 Apr 2026 13:13:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v2 02/13] drivers: base: Add generic dma context bus
Message-ID: <2026042422-deem-chemist-8d0f@gregkh>
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
 <20260423-glymur-v2-2-0296bccb9f4e@oss.qualcomm.com>
 <2026042346-trustable-register-095a@gregkh>
 <06c04947-e72e-679b-493b-e112d693f391@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06c04947-e72e-679b-493b-e112d693f391@oss.qualcomm.com>
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

On Fri, Apr 24, 2026 at 04:01:13PM +0530, Vishnu Reddy wrote:
> 
> On 4/23/2026 7:07 PM, Greg Kroah-Hartman wrote:
> > On Thu, Apr 23, 2026 at 06:59:31PM +0530, Vishnu Reddy wrote:
> >> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >>
> >> When a driver needs to create virtual device at runtime and map it to
> >> an IOMMU context for memory isolation, there is no common bus available
> >> for this purpose. Each driver ends up implementing its own bus type,
> >> leading to duplicated logic across multiple drivers.
> >>
> >> host1x driver implemented its own bus type to attach an IOMMU context to
> >> a dynamically created device. The Iris VPU driver now has the same
> >> requirement. Rather than duplicating the same bus logic again, a shared
> >> bus type is introduced under drivers/base that multiple drivers can use
> >> directly.
> >>
> >> The bus takes care of creating a device and attaching the IOMMU context
> >> to it based on the client inputs.
> >>
> >> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> >> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> >> ---
> >>  drivers/base/Kconfig            |  3 ++
> >>  drivers/base/Makefile           |  1 +
> >>  drivers/base/dma_context_bus.c  | 77 +++++++++++++++++++++++++++++++++++++++++
> >>  include/linux/dma_context_bus.h | 26 ++++++++++++++
> >>  4 files changed, 107 insertions(+)
> > as you can not have a device on multiple busses at the same time, this
> > makes no sense to me at all.  "dma context" is a bus-specific thing, so
> > please add it to the bus that you are wanting it for.  It can't be a
> > generic bus as that just doesn't work.
> >
> > Or what am I missing here?
> >
> > And why is DMA somehow "special" here from any other hardware attribute?
> 
> Let me give brief information which was discussed, in the initial series,
> the iris VPU used platform bus for dynamically created devices and we got
> the comment/suggestion from Robin to implement a proper bus_type with a
> .dma_configure callback.
> 
> https://lore.kernel.org/all/02b3d0f5-f94c-43cd-93af-97cfcf7751b1@arm.com/
> 
> based on the discussion, implemented the dma_context_bus and used for iris
> VPU devices instead of platform bus.

Why not make a irus_vpu_bus where you can do what you want?

> Here, the device have only one bus (dma_context_bus), not multiple buses.
> 
> Regarding the "DMA" naming, the core operation of this bus is its
> .dma_configure callback, which calls of_dma_configure_id() to map the device
> to a corresponding IOMMU stream ID. The name "dma_context" reflects this
> purpose.
> 
> I am open to suggestions from you or Robin or anyone else, if there is a
> better or preferred way to achieve this, I am happy to consider it and
> rework the implementation accordingly.

As there is only one user, just make this your own bus please and do all
of the needed bus operations for your devices there (i.e. don't hang an
"empty" device off of it.)

thanks,

greg k-h
