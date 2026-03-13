Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D1A105F799
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 10:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B501210E0AA;
	Fri, 13 Mar 2026 10:52:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="k1crffAN";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3408F10E0AA
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1773399153;
 bh=+oXaDRbNusXTMSSax236f0w9eZRyQ4ofZH6RI1lFFOA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=k1crffANo5WtMZ8+i9gRbcbmXS3NbPjwM0y8sdtEfl9JhpHRCRWRYPeG281GYwykY
 FxoIP/swG3kK9QMyPdFhHcxbS0X8UCbPNvdmAmcNJbuIoAsQwHVOpzjWlkdg7IXp8r
 fpiNDxqg2hZbQ4O/TDWD4ASn5QZDczct5NxCONsW9j3wn8quOElNzGw+6mB83OkIw6
 y3I1fX1Co0PKTyvBbtvlEY1bMOz3GJDyq9hv/T1bwi80czB+jHGEtQwk/tpa5VYWvu
 i+CS2Izek3iZGkPE3QmE88SdkHVyr+GBUCa8nxKsaGR4vMqeDkXNcti53Vb96G6PR8
 P4nI1Bhd7GAEQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5089317E0E42;
 Fri, 13 Mar 2026 11:52:33 +0100 (CET)
Date: Fri, 13 Mar 2026 11:52:28 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Tommaso Merciai
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
Message-ID: <20260313115228.5c516729@fedora>
In-Reply-To: <f3384342-cdc5-4260-b670-4ffde76a2802@suse.de>
References: <20260227114509.165572-1-tzimmermann@suse.de>
 <20260227114509.165572-6-tzimmermann@suse.de>
 <abL5rcYIaFFO3GW2@tom-desktop>
 <TY3PR01MB113460CA616D3576DA0C3FC698644A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB113461ACB668738E1952EC8898645A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20260313111851.4c1f89f3@fedora>
 <f3384342-cdc5-4260-b670-4ffde76a2802@suse.de>
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

On Fri, 13 Mar 2026 11:29:47 +0100
Thomas Zimmermann <tzimmermann@suse.de> wrote:

> Hi
> 
> Am 13.03.26 um 11:18 schrieb Boris Brezillon:
> [...]
> >>>>> +	if (drm_WARN_ON(obj->dev, !shmem->pages || page_offset >= num_pages))
> >>>>> +		return VM_FAULT_SIGBUS;
> >>>>> +
> >>>>> +	file_update_time(vma->vm_file);
> >>>>> +
> >>>>> +	folio_mark_dirty(page_folio(shmem->pages[page_offset]));  
> > Do we need a folio_mark_dirty_lock() here?  
> 
> There is a helper for that with some documentation. [1]

I know, I meant using that version instead of folio_mark_dirty().
