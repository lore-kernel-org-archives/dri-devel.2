Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D330FF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 10:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E528710EADE;
	Tue, 28 Apr 2026 10:05:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="vG/WzYHv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D2EB10EAC2;
 Tue, 28 Apr 2026 10:05:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9E07F60141;
 Tue, 28 Apr 2026 10:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB50FC2BCAF;
 Tue, 28 Apr 2026 10:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777370716;
 bh=PMHKsltO7uhCWPnxhy5s2BeEnZwPfjveCg8V9/Ctj0k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vG/WzYHvsXBRMAmai16ySAgggPZGU8MpWPAZWv9sWPMFTh5ERt2inEMiDdtoi/aR4
 FI++YsyUaj2kd1OSC6Dr0o2A7MlUN9vgoI4RIeYUl3oVe8MHcTtGBJYGHNxb2eI3gg
 zdjTpZBT8Li0oVvjexA0TrDsq9jnKiEsOQS7LrG2vnMM1hPMaP8aufj0UWcPvH/DaU
 3WB5kHhF4+IDva8AOB/bnULOD/+AIOYZ+RYK9RJMUqYSV4u7y0BWh3aSgFz+VXCPtv
 Cd79m761OIkHPLDloZQUgdwQVv9YA+cfPqOIMcvXUEFTl5et0xcJHHtxxcLtKUxvfE
 ZmmnsWVZV3kmg==
Date: Tue, 28 Apr 2026 12:05:13 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] mm: Introduce zone_appears_fragmented()
Message-ID: <afCGGC6MUi1m-Ej5@zenone.zhora.eu>
References: <20260423055656.1696379-1-matthew.brost@intel.com>
 <20260423055656.1696379-2-matthew.brost@intel.com>
 <afCCCuLglfi70Tgq@zenone.zhora.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afCCCuLglfi70Tgq@zenone.zhora.eu>
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

> > +	if (zone_page_state(zone, NR_FREE_PAGES) > high_wmark_pages(zone) * 2)
> > +		return true;
> > +
> > +	return false;

P.S.: If you want, this can also be written:

	return (zone_page_state(zone, NR_FREE_PAGES) > high_wmark_pages(zone) * 2);

> > +}
