Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6536ECD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 09:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B15C410EEFF;
	Thu, 28 May 2026 09:38:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="I3knpawH";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18CEC10EEFF
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 09:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779961087;
 bh=rHYM65akxqHNcNE/5zxAiTvlScgfy4gjVLQtW79x9U8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=I3knpawH9gZxI8zqXXm/7U0RBVJjohN7vqY+H6qXH9VW6J/fjJfdsftRJx54AoVJ6
 lWSHJDa32SmF/BB9JK3syMtRpGGb54mRX3zUSYziyrtDDaOaS3MSfszTFWt62AcTDb
 fCgiqPKwoEVlthfY9Tq8M/92M4L7xHuRKbXnTo429wAkv705n8P2w46q/m5pGavSuC
 9wcu/E9Y4Av1soxW6Qif+RwZmYb92Z8vi8ueiKIJYUUwmUJmVF5wHZzMTxC4YdUjsr
 uEGjOTfbmSK8tqhXZEn7qc/yzpSgRTxljZjaXL2/D9j6PKjm6+FomHpcQeVGaWBpuI
 A1B9HABDMiu9w==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4762917E0191;
 Thu, 28 May 2026 11:38:07 +0200 (CEST)
Date: Thu, 28 May 2026 11:38:02 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Igor Torrente <igor.torrente@collabora.com>,
 loic.molinari@collabora.com, willy@infradead.org, frank.binns@imgtec.com,
 matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 5/6] drm/gem-shmem: Track folio accessed/dirty status
 in mmap
Message-ID: <20260528113802.0e0a7a18@fedora>
In-Reply-To: <5d34e0b8-1b3d-4a7e-bd5a-f0eceee4a83b@suse.de>
References: <20260209133241.238813-1-tzimmermann@suse.de>
 <20260209133241.238813-6-tzimmermann@suse.de>
 <d89422f1-f00a-47b1-b68a-d949d6d6a974@collabora.com>
 <850e8355-7884-405c-a70a-986ce032c019@suse.de>
 <831c0943-c75f-4d42-aa5f-90ce34cf8530@collabora.com>
 <67855fcd-2afe-4a1d-a51a-210e45f56167@suse.de>
 <20260527121832.7264f0db@fedora>
 <4a00d72c-9b87-4511-9da0-bcb40fae4d74@suse.de>
 <20260528111140.2d9535b7@fedora>
 <5d34e0b8-1b3d-4a7e-bd5a-f0eceee4a83b@suse.de>
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

On Thu, 28 May 2026 11:22:46 +0200
Thomas Zimmermann <tzimmermann@suse.de> wrote:

> Hi
> 
> Am 28.05.26 um 11:11 schrieb Boris Brezillon:
> > On Thu, 28 May 2026 09:20:16 +0200
> > Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >  
> >> Hi
> >>
> >> Am 27.05.26 um 12:18 schrieb Boris Brezillon:
> >> [...]  
> >>>> -			return ret;
> >>>> +			return vmf_insert_pfn_pmd(vmf, pfn,
> >>>> +						  vmf->flags & FAULT_FLAG_WRITE);  
> >>> I believe we can go back to
> >>>
> >>> 			return vmf_insert_pfn_pmd(vmf, pfn, false);
> >>>
> >>> if the mappings are no longer adjusted to catch write accesses.  
> >> If we don't install it as writable now, won't the kernel not split it up
> >> into 4KiB pages when the actual write happens?  
> > It will be installed as writeable right away, regardless of the write
> > parameter, because if pfn_mkwrite is not implemented, vma->vm_page_prot
> > won't be lowered to read-only in the first place, or at least that's
> > what I remember from the previous debugging session I've done.  
> 
> In insert_pmd(), the write parameter controls whether we run 
> maybe_pmd_mkwrite(), which sets the __PAGE_RW flag.
> 
> https://elixir.bootlin.com/linux/v7.1-rc5/source/mm/huge_memory.c#L1632
> https://elixir.bootlin.com/linux/v7.1-rc5/source/mm/huge_memory.c#L1655


This is not where the RW|SHARED -> READ_ONLY lowering happens though. If
the write argument was the only way to get writeable hugepage mappings,
it wouldn't have worked before your pfn_mkwrite addition.

> 
> That's at least how I understand the logic here. Performance-wise it 
> might be beneficial if we track the write flags as before.

It was working fine before pfn_mkwrite was added: huge pages were
mapped as PMDs even when they were writable.
