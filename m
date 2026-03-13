Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D40107BCD5
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 17:46:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E76F10EC75;
	Fri, 13 Mar 2026 17:46:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="QbZ8IcW4";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA56410EC75
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 17:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1773423954;
 bh=T9aamq2yo0HMqv1Jkdy4l6sGV0d7EEk4IPc7FyjxaZA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=QbZ8IcW4JHGAMYXu00b68izz85X/OeSPnxidT+oajlEnYp0fQDUw6qBGK5zVwAFj0
 rsW+lBsRYU9vvg1Ekauiunq9R/JnoTZ8eakQf9qQIrRrPjQ2c4xFEmtUcgbb1hIViN
 4g8eeLbSg3vyfY8MtO3Zb2ASD1/26tV18JhYuKJJfltB2fGAwN+rC4LdI8DfEApLNv
 BKSdvOaL07HWWIstLMeRhCHk0CR/g5TGFeZKIHRK2dUcDoKX3GmloqJkt3vjzWepgr
 TYoj41wQYZpQuxwkpWFtS7VbgdSQbWqSZaOI6QRq60XQO/GhlzgvYc/1EL6en/rhOQ
 65xJGiKB/HX5w==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4C1E717E127A;
 Fri, 13 Mar 2026 18:45:54 +0100 (CET)
Date: Fri, 13 Mar 2026 18:45:49 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Tommaso Merciai
 <tommaso.merciai.xr@bp.renesas.com>, "loic.molinari@collabora.com"
 <loic.molinari@collabora.com>, "willy@infradead.org" <willy@infradead.org>,
 "frank.binns@imgtec.com" <frank.binns@imgtec.com>, "matt.coster@imgtec.com"
 <matt.coster@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 5/6] drm/gem-shmem: Track folio accessed/dirty status
 in mmap
Message-ID: <20260313184549.08656eed@fedora>
In-Reply-To: <20260313135521.07823792@fedora>
References: <20260227114509.165572-1-tzimmermann@suse.de>
 <20260227114509.165572-6-tzimmermann@suse.de>
 <abL5rcYIaFFO3GW2@tom-desktop>
 <TY3PR01MB113460CA616D3576DA0C3FC698644A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB113461ACB668738E1952EC8898645A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20260313111851.4c1f89f3@fedora>
 <f3384342-cdc5-4260-b670-4ffde76a2802@suse.de>
 <20260313125644.65131b27@fedora>
 <TY3PR01MB1134662A395AA0A048CEE152E8645A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20260313131835.52c5c935@fedora> <20260313134328.3166c4d0@fedora>
 <20260313135521.07823792@fedora>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
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

On Fri, 13 Mar 2026 13:55:21 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Fri, 13 Mar 2026 13:43:28 +0100
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
> 
> > On Fri, 13 Mar 2026 13:18:35 +0100
> > Boris Brezillon <boris.brezillon@collabora.com> wrote:
> >   
> > > On Fri, 13 Mar 2026 12:04:25 +0000
> > > Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > >     
> > > > > -----Original Message-----
> > > > > From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of Boris Brezillon
> > > > > Sent: 13 March 2026 11:57
> > > > > Subject: Re: [PATCH v4 5/6] drm/gem-shmem: Track folio accessed/dirty status in mmap
> > > > > 
> > > > > On Fri, 13 Mar 2026 11:29:47 +0100
> > > > > Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > > > >         
> > > > > > Hi
> > > > > >
> > > > > > Am 13.03.26 um 11:18 schrieb Boris Brezillon:
> > > > > > [...]        
> > > > > > >>>>> +	if (drm_WARN_ON(obj->dev, !shmem->pages || page_offset >= num_pages))
> > > > > > >>>>> +		return VM_FAULT_SIGBUS;
> > > > > > >>>>> +
> > > > > > >>>>> +	file_update_time(vma->vm_file);
> > > > > > >>>>> +
> > > > > > >>>>> +	folio_mark_dirty(page_folio(shmem->pages[page_offset]));        
> > > > > > > Do we need a folio_mark_dirty_lock() here?        
> > > > > >
> > > > > > There is a helper for that with some documentation. [1]        
> > > > > 
> > > > > This [1] seems to solve the problem for me. Still unsure about the folio_mark_dirty_lock vs
> > > > > folio_mark_dirty though.
> > > > > 
> > > > > [1]https://yhbt.net/lore/dri-devel/20260312155027.1682606-1-pedrodemargomes@gmail.com/        
> > > > 
> > > > FYI, I used folio_mark_dirty_lock() still it does not solve the issue with weston hang.      
> > > 
> > > The patch I pointed to has nothing to do with folio_mark_dirty_lock(),
> > > It's a bug caused by huge page mapping changes.    
> > 
> > Scratch that. I had a bunch of other changes on top, and it hangs again
> > now that I dropped those.  
> 
> Seems like it's the combination of huge pages and mkwrite that's
> causing issues, if I disable huge pages, it doesn't hang...

I managed to have it working with the following diff. I still need to
check why the "map-RO-split+RW-on-demand" approach doesn't work (races
between huge_fault and pfn_mkwrite?), but I think it's okay to map the
real thing writable on the first attempt anyway (we're not trying to do
CoW here, since we're always pointing to the same page, it's just the
permissions that change). Note that there's still the race fixed by
https://yhbt.net/lore/dri-devel/20260312155027.1682606-1-pedrodemargomes@gmail.com/
in this diff, I just tried to keep the diffstat minimal.

--->8---
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 4500deef4127..4efdce5a60f0 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -561,9 +561,8 @@ static vm_fault_t drm_gem_shmem_try_insert_pfn_pmd(struct vm_fault *vmf, unsigne
        bool aligned = (vmf->address & ~PMD_MASK) == (paddr & ~PMD_MASK);
 
        if (aligned && pmd_none(*vmf->pmd)) {
-               /* Read-only mapping; split upon write fault */
                pfn &= PMD_MASK >> PAGE_SHIFT;
-               return vmf_insert_pfn_pmd(vmf, pfn, false);
+               return vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
        }
 #endif
 
@@ -597,8 +596,12 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
 
        pfn = page_to_pfn(page);
 
-       if (folio_test_pmd_mappable(folio))
+       if (folio_test_pmd_mappable(folio)) {
                ret = drm_gem_shmem_try_insert_pfn_pmd(vmf, pfn);
+               if (ret == VM_FAULT_NOPAGE && vmf->flags & FAULT_FLAG_WRITE)
+                       folio_mark_dirty(folio);
+       }
+
        if (ret != VM_FAULT_NOPAGE)
                ret = vmf_insert_pfn(vma, vmf->address, pfn);
 
