Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD41C54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 049E510E93F;
	Tue, 28 Jul 2026 14:46:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UGgRF5u1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D68D10E93F;
 Tue, 28 Jul 2026 14:46:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9828741794;
 Tue, 28 Jul 2026 14:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432E91F000E9;
 Tue, 28 Jul 2026 14:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785250016;
 bh=T/PYqlUQvMrIaurasbg8b4ywEHZqwHL+68ciOIACLtc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UGgRF5u1U4by0nLiLfP39GKxGfrY7/hLGmK3WsMwoAaxmz1Fr6XPKj1wsg6TTfQfs
 Ntv5ZVCPucM9jmAhFxWIwH6CJpg+GLiafzUgJ1/ysZdzaCTCFDK/IGk+GsZfqnFYDU
 9LLK5jbSEQZzqOHLO4UrgX19H4VoBgOD4YMnnTlfXSGfHxlfm3MWby92Q973JjdxjV
 iVuIIjLsNdBXjKN5Ugww82/wqm0/oP/jitDWlvdPLFY17CFds3DggIWMbXk1gJo0Mt
 SEw6Yh8abyfigH9ahxFFA7UticnT8QAUKjyvQ2YuAR6BtEMbpP4HN8DdCU5YYodK49
 ESnjBAIorlCCA==
Date: Tue, 28 Jul 2026 15:46:36 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Christian Koenig <christian.koenig@amd.com>, 
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
 Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, 
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Dave Airlie <airlied@redhat.com>, 
 Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/3] mm/huge_memory: add folio_split_driver_managed()
Message-ID: <amjAtdJjBnHmA1Fr@lucifer>
References: <20260722044220.1110278-1-matthew.brost@intel.com>
 <amiyPLdgHGK25X48@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amiyPLdgHGK25X48@lucifer>
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

On Tue, Jul 28, 2026 at 03:40:55PM +0100, Lorenzo Stoakes (ARM) wrote:
> I know different people have different approaches but PLEASE cc- everybody
> on the whole series for context :)
>
> You may annoy the odd few who want less mail > context but that's the best
> way I think.

OK sorry either I wasn't paying attention, the mail sent slow, or I am blind :P
but I see I'm cc'd on the rest.

Apologies!

Cheers, Lorenzo
