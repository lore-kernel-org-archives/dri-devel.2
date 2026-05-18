Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91239CD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 08:57:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC43810E039;
	Mon, 18 May 2026 08:57:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="pwwmVtLh";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AB2A10E039
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 08:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779094646;
 bh=2qTLaW/COV+GfxNT+S1Mi+IrpTKOlvQB9ZJrbZDjHvI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=pwwmVtLhoMYQTahDd2zJsjpmIP5OzRDUKAElxBRbyqPqhFEwXyQkDtRrG0LxRQgI5
 wF9B8xvYuSvSdD6HcplGKMY+AxD+Dd3nUeGfwtc/0ETVDauGIuE2fkRB30chfo/GrR
 qUMrZDKkO04TeIYAle5Cgbvvkc7KiAsC/S2d53WSQoF6wbOUSAt/2b09UG1lY4fyQf
 J74eyWJIz9tMYQU6K1fLG8IAgD9A10Q7P+RG4q7DS26UxuWdgnvvXRLIn4CCACWuGO
 8MpaFvFYZPa6tbPLkRlP2CzjqnY+UymXtRmFzPkGG7e3hLDN35U7H/pH093EPXUJ09
 O657R13F7DLaw==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 419D217E0443;
 Mon, 18 May 2026 10:57:26 +0200 (CEST)
Date: Mon, 18 May 2026 10:57:21 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] drm/panthor: Driver-wide xxx_[un]lock ->
 [scoped_]guard replacement
Message-ID: <20260518105721.42ffa64c@fedora>
In-Reply-To: <5ab2d07c-74a4-4a2c-b145-6ed7b0060944@arm.com>
References: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
 <20260513-panthor-guard-refactor-v1-1-f2d8c15a97ce@collabora.com>
 <5ab2d07c-74a4-4a2c-b145-6ed7b0060944@arm.com>
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

On Thu, 14 May 2026 14:16:37 +0100
Steven Price <steven.price@arm.com> wrote:

> On 13/05/2026 17:58, Boris Brezillon wrote:
> > Right now panthor is mixed bag of manual locks and guards. Let's
> > make that more consitent and thus encourage new submissions to go
> > for guards.  
> 
> I'm fine with encouraging guards for future code - but I'm a little wary
> of a big change like this - it's hard to review it and check that
> everything works the same.

I can try to split that up, but even after the split, it will still be
a pain to review.

> And it's a little dubious that the mechanical
> refactoring produces more readable code in some cases.

I agree, though the mix of guard()s and manual locks makes things even
harder to reason about, especially when they appear in the same
function/block. The very reason I ended up sending this series is
because, as part of the IRQ refactor, I decided to be a good citizen
and use guards when I could, and I realized how bad the partial
transition was in term of ergonomics: not only you have to think about
whether the function/block scope is what you want (that's basically
what guard provides, unless you used explicit scoped_guard()), but you
also have to think about the interactions with your other manual locks.

TLDR; I'd rather switch over to guards entirely, or go back to manual
locks, but the mix we have right now is far from ideal.

> 
> That said I asked my friendly AI bot...
> 
> [...]
> 
> > @@ -3142,48 +3126,44 @@ panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
> >  	LIST_HEAD(remaining_vms);
> >  	LIST_HEAD(vms);
> >  
> > -	mutex_lock(&ptdev->reclaim.lock);
> > -	list_splice_init(&ptdev->reclaim.vms, &vms);
> > +	scoped_guard(mutex, &ptdev->reclaim.lock)
> > +		list_splice_init(&ptdev->reclaim.vms, &vms);
> >  
> >  	while (freed < nr_to_scan) {
> >  		struct panthor_vm *vm;
> >  
> > -		vm = list_first_entry_or_null(&vms, typeof(*vm),
> > -					      reclaim.lru_node);
> > -		if (!vm)
> > -			break;
> > -
> > -		if (!kref_get_unless_zero(&vm->base.kref)) {
> > -			list_del_init(&vm->reclaim.lru_node);
> > -			continue;
> > +		scoped_guard(mutex, &ptdev->reclaim.lock) {
> > +			vm = list_first_entry_or_null(&vms, typeof(*vm),
> > +						      reclaim.lru_node);
> > +			if (vm && !kref_get_unless_zero(&vm->base.kref)) {
> > +				list_del_init(&vm->reclaim.lru_node);
> > +				vm = NULL;
> > +			}
> >  		}
> >  
> > -		mutex_unlock(&ptdev->reclaim.lock);
> > +		if (!vm)
> > +			break;  
> 
> ... and it said the above has changed behaviour.
> 
> In the !kref_get_unless_zero() case you now assign vm = NULL which then
> leads to the 'break' case above. Previously we 'continue'd.

Oops, that one wasn't intended, indeed.
