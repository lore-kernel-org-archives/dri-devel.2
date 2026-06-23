Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F71CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87A4510EC7E;
	Tue, 23 Jun 2026 20:03:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="qrn7Niwy";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22B3410EC7D
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782245027;
 bh=LEMNvch+xEu+3Is5PhYgSbaYPcKf+aaNjlvCqRGadLk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=qrn7Niwyx9X5/cf6oD0iBsejz56tkf6uuuHGLwSsSOTkXQmRdFr7zA6fWbdRHQxWV
 5DgR1oseO7vzVTMkOtPX7QHDNTgesmBT1Mnufn8y6f1pe2ONFut1J1s/dAl05ln7Hd
 YWd7Z+NkFvbfsU3AuzmL8raJau21+w9Lcu1n4iP4m1ZOF94rZ63HVqqbCQIXwNkWxV
 aqkWJl4FkiZflSqm7yL/YsKw4rLfINNulCO5afB1iUiSvPsf4b3sIwnKh5OMWbOujd
 EJ7zdicpVdczoxpYIaL7C54lqEMauhzon34+7VgjNazjlu5cU7C3jbR+QA9e/jMpHn
 EFWt+vmwaZ+DQ==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0F28A17E02B5;
 Tue, 23 Jun 2026 22:03:47 +0200 (CEST)
Date: Tue, 23 Jun 2026 22:03:41 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, dri-devel@lists.freedesktop.org,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Check VMA boundaries for PMD mappings
Message-ID: <20260623220341.7ad4a0e2@fedora-2.home>
In-Reply-To: <ajrRhpVH6uhOABnV@casper.infradead.org>
References: <20260623181942.1536598-1-lk@c--e.de>
 <ajrRhpVH6uhOABnV@casper.infradead.org>
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

Hi Matthew,

On Tue, 23 Jun 2026 19:33:42 +0100
Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Jun 23, 2026 at 08:19:42PM +0200, Christian A. Ehrhardt wrote:
> > The panthor version is only compile tested because I don't
> > have the hardware. However, the code is identical to that
> > fixed in [1] and I have a reproducer for that.
> > 
> > No need for for stable backports. The code is new in 7.1.  
> 
> What documentation did you need to see to persuade you to use
> map_pages instead of writing a huge_fault handler?
> 
> (yes, you're all Doing It Wrong, please stop, but help us help you)

We tried [1], but couldn't figure out how to make it work with the
current locking in the gem_shmem logic, so we decided to postpone the
map_page() addition. We plan to get back to it and implement map_page(),
but my understanding is that we still need the fault()+huge_fault() as a
fallback for when we can't acquire the locks we need to service the
fault. Oh, and BTW, we had just the fault() implementation in the
version that was merged, no huge_fault(), but this fault()
implementation was mapping PMDs which led to another issue [2] that
forced us to add this huge_fault() implem.

I'm all for improving that, but if I'm completely honest, there are
times where our MM-related questions are left unanswered ([3] is one
example), and it gets hard to figure out how to do things properly
without proper guidance from the MM experts. I thought [2] was one of
these, but apparently the MM list/maintainers were not Cc-ed on that
one, oops.

Just to be clear, I'm not blaming anyone here (I know how busy subsystem
maintainers are in general), I'm just trying to explain how we ended up
with these new huge_fault() implementations (one being a fork of the
original implementation) that you were not expecting, but also wanted to
point out that we've been pretty transparent about where we were heading
during the submission process, and we didn't get a clear "no, stop
there!" back then.

Anyway, I'll try to get back to this map_pages() implementation, and
see how we can handle the fallback when locks can't be acquired in that
path (I assume this would mean no PMD mapping in the fallback path if
we get rid of huge_fault()).

Regards,

Boris

[1]https://patchew.org/linux/20251015153018.43735-1-loic.molinari@collabora.com/20251015153018.43735-4-loic.molinari@collabora.com/
[2]https://lore.kernel.org/all/20260319015224.46896-1-pedrodemargomes@gmail.com/
[3]https://lore.kernel.org/all/20260319155028.291f3157@fedora/
