Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AF3CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:44:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C43010ECA5;
	Tue, 23 Jun 2026 20:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="LQb5Q4AX";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FC8E10ECA5
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782247483;
 bh=Q/GXbcxhxDosqTJ+sCODRYXG+WQ/GMMMUnDuHdmb1hw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=LQb5Q4AX+Rx0nVbM65YeNcgJOpeXXWoHbUaxjJ1K+JuH2i32to1rctjLRaWGJ9zic
 5CuoABTSF3pPyL/PMo2DISCM5OGGNu4IvoaroO+9ykKcEZj7l0JyZWlXs8cd+U7NSe
 sHGCt7SBg+IwhgOZgtXWQhzPJ/Vn/4npXi1uKKXwxjOfGFHnRG2XLlJJ0l1TaRBIuE
 s8lXOCA1c6a2mA8B+PO0OzRN1h+SnmeO65KAXQs/AE/6PN6LdexMZ6hA70/pnfupus
 2ty7jGNL454wtTvSybH//kdwZBrOxiz65IqQSeRI8lfJ8lkVr/NGcpzcQ+8jQy72lf
 +Smodgac87GqA==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2239117E045E;
 Tue, 23 Jun 2026 22:44:43 +0200 (CEST)
Date: Tue, 23 Jun 2026 22:44:21 +0200
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
Message-ID: <20260623224421.56dba65d@fedora-2.home>
In-Reply-To: <20260623220341.7ad4a0e2@fedora-2.home>
References: <20260623181942.1536598-1-lk@c--e.de>
 <ajrRhpVH6uhOABnV@casper.infradead.org>
 <20260623220341.7ad4a0e2@fedora-2.home>
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

On Tue, 23 Jun 2026 22:03:41 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> Anyway, I'll try to get back to this map_pages() implementation, and
> see how we can handle the fallback when locks can't be acquired in that
> path (I assume this would mean no PMD mapping in the fallback path if
> we get rid of huge_fault()).

More on that. I had a brief look at map_pages()/fault_around(), and it
seems it's only meant to populate PTE entries, not PMDs. Part of the
perf boost we were looking for when adding huge_fault() was limiting
the number of faults when adjacent pages are touched, but the other
part was limiting the page table depth to optimize page-table walks, so
if we're implementing map_pages() without huge_fault(), we basically
lose the second part of the optimization. I'd need to check how much
perf we leave on the table with that.
