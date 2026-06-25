Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B65CDE001
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 11:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 687B710E1EB;
	Thu, 25 Jun 2026 11:54:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="beu4O6BZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D70E610E1EB;
 Thu, 25 Jun 2026 11:54:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 96DF040B7B;
 Thu, 25 Jun 2026 11:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264EE1F000E9;
 Thu, 25 Jun 2026 11:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782388470;
 bh=/GXFi/MVRAwUZHw1Zk5DPCqLioIWwoiNAiqmK1nO1Ew=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=beu4O6BZP1eXIi45Dd5+lSUZZefTpFb3TjvzlFxLH0t/BOcXi8L6Dale141fqCl6Z
 /Xte0MUmMr3yT9Pcbt1Lg8nplPdvKdmOnIVohDbRXzgub0s/+nTkR/vXxf57AZz0CF
 SBFlmlwifSmHo/3s7jGSTq143SfCAFMwOl8TxWJ61LJRBo6NS6O+GjGXDZFEdykJda
 ZAhI6fYFT/UqiaP96opC92vgpKZ/jIEtfoHBzsGwNgcrPxbp9F0u58F4tUoecbcYza
 skRccOgyZHJp/MMsUbljWviO84DFhaq696UGJc6N0ZebJUxf28JNGPE6nucgOmoHxO
 kXQfySON4fttw==
Date: Thu, 25 Jun 2026 12:54:20 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Yitao Jiang <jytscientist@hotmail.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>, 
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R . Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 0/3] mm/mmu_notifier, drm/amdgpu: block THP for GPU user
 mappings
Message-ID: <aj0V0Dqg-4Xa8-6Y@lucifer>
References: <SY1PR01MB10596EB75463208A8E1EBBA0FC0EC2@SY1PR01MB10596.ausprd01.prod.outlook.com>
 <d462612c-508c-4682-a776-92f4f4a40e28@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d462612c-508c-4682-a776-92f4f4a40e28@kernel.org>
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

NAK to this or any version of this.

This series is insane and the idea is insane.

On Thu, Jun 25, 2026 at 01:47:25PM +0200, David Hildenbrand (Arm) wrote:
> On 6/25/26 12:59, Yitao Jiang wrote:
> > Hi,
> >
> > This series fixes a THP policy problem I found while debugging
> > frequent ROCm GPU failures on an AMD Radeon 780M system during ML
> > training.
> >
> > Some AMDGPU/KFD user mappings are registered through interval
> > notifiers and cannot safely tolerate the backing VMA changing from base
> > pages to a transparent huge page after registration. Userspace can
> > still apply MADV_HUGEPAGE or MADV_COLLAPSE, and khugepaged can also
> > collapse the range, after the GPU mapping has been registered.
>
> Huh, why? As a memory notifier user, you must be prepared from memory to get
> unmapped+remapped at random points in time.
>
> What is the precise problem here? How are you handling THPs at registration time?
>
> Letting arbitrary drivers make THP policies sounds like the very wrong approach.

We absolutely will not _ever_ allow drivers to do this while I still breath :)

>
> --
> Cheers,
>
> David

Thanks, Lorenzo
