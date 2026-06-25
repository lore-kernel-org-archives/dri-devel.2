Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DFDCDE001
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 11:59:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EE6010E1FC;
	Thu, 25 Jun 2026 11:59:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AArBWtJu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29DFA10E1E1;
 Thu, 25 Jun 2026 11:59:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F328843232;
 Thu, 25 Jun 2026 11:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12FB1F000E9;
 Thu, 25 Jun 2026 11:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782388748;
 bh=SOWUv1XfnbEbqm4GgtkhR5DJeEd/Hng/YV/E0/Qc0Cc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=AArBWtJuZNc+/FIFUIMlGuEZ8kMvlKEFWkOuvjAEvmSCRP6Xtr79DwdLfMRKxlCsp
 Y3IT3WOyGk6qDjC+t4HKdGewaQIfROBx3//zGaqkVvAIWSn89JQ5+qpQIXdCm6oMxe
 psbFJ8N1cByHOQzNmWU63y70+iMNRCiyAjs4IyQzZXKg4LEnhDy1S1MXdKCNt/nrsZ
 xUKH6wlT1qw0OomPAMWfNmOPisTudnb6s7TrvtA9fGPJODLcaiOKBZlSZh07z2lZvG
 ARk0cWPCvn/SNRPjo4quuTXhn9k1+0qPGQG2NWAw6QswrpPXgADAiOxmSiH3UgiJ/3
 BLqOQd0LHWe1A==
Date: Thu, 25 Jun 2026 12:58:58 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Yitao Jiang <jytscientist@hotmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <liam@infradead.org>, 
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] mm/mmu_notifier: let interval notifiers block THP
Message-ID: <aj0XB-ZLl8uhSDzQ@lucifer>
References: <SY1PR01MB10596EB75463208A8E1EBBA0FC0EC2@SY1PR01MB10596.ausprd01.prod.outlook.com>
 <SY1PR01MB1059616E59F213B6FB4F4E3C5C0EC2@SY1PR01MB10596.ausprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SY1PR01MB1059616E59F213B6FB4F4E3C5C0EC2@SY1PR01MB10596.ausprd01.prod.outlook.com>
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

On Thu, Jun 25, 2026 at 06:59:51PM +0800, Yitao Jiang wrote:
> Assisted-by: OpenAI-Codex:GPT-5.5

Thanks for acking AI involvement, that's appreciated (and there appears to be a
fair but of unacknowledged AI-generated code being submitted at the moment).

However, may I gnetly direct you towards the last few paragraphs in this document:

https://origin.kernel.org/doc/html/latest/process/generated-content.html

I think this MAY be a case of the AI possibly misleading you into a crazy idea
when, as David points out, page pinning is what you need :)

We don't bite, if you have a problem that you need to solve, feel free to email
linux-mm@kvack.org and relevant maintainers/reviewers from MAINTAINERS with a
'[DISCUSSION]' or '[QUESTION]'-prefixed thread and we can help you ahead of
time.

Thanks, Lorenzo
