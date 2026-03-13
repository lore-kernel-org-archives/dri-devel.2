Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4C6105F7A7
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 12:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D84510EBDE;
	Fri, 13 Mar 2026 12:55:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="SWH6jPaU";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09DD010EBDF
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1773406525;
 bh=NCXnzrq2A1QW1RDxmrjE1LGSy0pWXHheSFQWOUDwhh4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=SWH6jPaUpOc3lGvw4TCDoo9W9Qn8tDU5LLjiQ4Y2ipCzP5m0UNuz4qx985Bz86alW
 HsnvE3FN8+MU+C3dKMVbcL+ZWAHDWEVCa+Joj0mHbRA/BlCxJ3Uu70ho/zICVwFnZS
 ItST95C90KB0MCDO2jcaNKBYLRjSF4QURroz3mtmS8uRY60G5Zvnk1ooycDIjOEaGr
 sZcTun1BZvCMRQHvWtDCqaqmr752DfIWLzzw50T26bQPNOnziS+Eyf7Qs626Fbn0P0
 LzHqJT7pWSC2pHctShTxBS0dJaJue3+tn8aGNJZ2cYuCB/IUnNfeVKYGjTYxwm4rOr
 +BwojEDw3hgVA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 17C2717E0222;
 Fri, 13 Mar 2026 13:55:25 +0100 (CET)
Date: Fri, 13 Mar 2026 13:55:21 +0100
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
Message-ID: <20260313135521.07823792@fedora>
In-Reply-To: <20260313134328.3166c4d0@fedora>
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

On Fri, 13 Mar 2026 13:43:28 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Fri, 13 Mar 2026 13:18:35 +0100
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
> 
> > On Fri, 13 Mar 2026 12:04:25 +0000
> > Biju Das <biju.das.jz@bp.renesas.com> wrote:
> >   
> > > > -----Original Message-----
> > > > From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of Boris Brezillon
> > > > Sent: 13 March 2026 11:57
> > > > Subject: Re: [PATCH v4 5/6] drm/gem-shmem: Track folio accessed/dirty status in mmap
> > > > 
> > > > On Fri, 13 Mar 2026 11:29:47 +0100
> > > > Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > > >       
> > > > > Hi
> > > > >
> > > > > Am 13.03.26 um 11:18 schrieb Boris Brezillon:
> > > > > [...]      
> > > > > >>>>> +	if (drm_WARN_ON(obj->dev, !shmem->pages || page_offset >= num_pages))
> > > > > >>>>> +		return VM_FAULT_SIGBUS;
> > > > > >>>>> +
> > > > > >>>>> +	file_update_time(vma->vm_file);
> > > > > >>>>> +
> > > > > >>>>> +	folio_mark_dirty(page_folio(shmem->pages[page_offset]));      
> > > > > > Do we need a folio_mark_dirty_lock() here?      
> > > > >
> > > > > There is a helper for that with some documentation. [1]      
> > > > 
> > > > This [1] seems to solve the problem for me. Still unsure about the folio_mark_dirty_lock vs
> > > > folio_mark_dirty though.
> > > > 
> > > > [1]https://yhbt.net/lore/dri-devel/20260312155027.1682606-1-pedrodemargomes@gmail.com/      
> > > 
> > > FYI, I used folio_mark_dirty_lock() still it does not solve the issue with weston hang.    
> > 
> > The patch I pointed to has nothing to do with folio_mark_dirty_lock(),
> > It's a bug caused by huge page mapping changes.  
> 
> Scratch that. I had a bunch of other changes on top, and it hangs again
> now that I dropped those.

Seems like it's the combination of huge pages and mkwrite that's
causing issues, if I disable huge pages, it doesn't hang...
