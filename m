Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D12DCD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 09:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DE7610EE88;
	Thu, 28 May 2026 09:11:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Vrh/3qbI";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB37110EE86
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 09:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779959506;
 bh=p83yMS4+TIpBazfoCslnvC+pbsWKviEG8NJxRj91Z5Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Vrh/3qbIeHhF0LcNWK4VFxyuYOLGXyBFmXNpXP5E2EQpByekeO8ScSpLmzIXU8LYp
 DLs+GcuNc6I6sA/9/QMRRTCKJWj6cp/aNJjss0GuLYSZtjUC5iFkS91BSh1d6uWfTS
 JHZwCOQLm0jgadq4oU55MgzkCq7GXY3pLGcIB7yabxnPW/iV1d1a+FHgL80ejNoahf
 CUV1BNmeRqShjT2Q29buW5bKmlIdmJ3AfTXPrqXEf6epPXGnt1uN/j2fIjwVCDqg86
 dPHiL6qPngF28vyJiCK/ueZY3HqUaF8g9l9duaJqy5aQjEvkaYwpWCQIrVdZkGP9+4
 EvhH4LQvE8piA==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0E0E317E0157;
 Thu, 28 May 2026 11:11:46 +0200 (CEST)
Date: Thu, 28 May 2026 11:11:40 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Igor Torrente <igor.torrente@collabora.com>,
 loic.molinari@collabora.com, willy@infradead.org, frank.binns@imgtec.com,
 matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 5/6] drm/gem-shmem: Track folio accessed/dirty status
 in mmap
Message-ID: <20260528111140.2d9535b7@fedora>
In-Reply-To: <4a00d72c-9b87-4511-9da0-bcb40fae4d74@suse.de>
References: <20260209133241.238813-1-tzimmermann@suse.de>
 <20260209133241.238813-6-tzimmermann@suse.de>
 <d89422f1-f00a-47b1-b68a-d949d6d6a974@collabora.com>
 <850e8355-7884-405c-a70a-986ce032c019@suse.de>
 <831c0943-c75f-4d42-aa5f-90ce34cf8530@collabora.com>
 <67855fcd-2afe-4a1d-a51a-210e45f56167@suse.de>
 <20260527121832.7264f0db@fedora>
 <4a00d72c-9b87-4511-9da0-bcb40fae4d74@suse.de>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 28 May 2026 09:20:16 +0200
Thomas Zimmermann <tzimmermann@suse.de> wrote:

> Hi
> 
> Am 27.05.26 um 12:18 schrieb Boris Brezillon:
> [...]
> >> -			return ret;
> >> +			return vmf_insert_pfn_pmd(vmf, pfn,
> >> +						  vmf->flags & FAULT_FLAG_WRITE);  
> > I believe we can go back to
> >
> > 			return vmf_insert_pfn_pmd(vmf, pfn, false);
> >
> > if the mappings are no longer adjusted to catch write accesses.  
> 
> If we don't install it as writable now, won't the kernel not split it up 
> into 4KiB pages when the actual write happens?

It will be installed as writeable right away, regardless of the write
parameter, because if pfn_mkwrite is not implemented, vma->vm_page_prot
won't be lowered to read-only in the first place, or at least that's
what I remember from the previous debugging session I've done.
