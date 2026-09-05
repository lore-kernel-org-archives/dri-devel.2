Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53CDC79F82
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 01:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32DE510E22E;
	Sat,  5 Sep 2026 01:48:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="DspyA2+6";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-119.mta1.migadu.com [95.215.58.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71B6C10E22E
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 01:48:47 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=TUsToWMbWDdUPZfVfcX5WlBwFVjpp22QmIMA12UED+I=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788572925; v=1; x=1789177725;
 b=DspyA2+6z4Xe9Z0TqoHJ7+GIXWKFxyDyGRI8r/vspUQIs/4pPH819WFWTaH4WIsiH1eHuUnr
 7ETzVeIjbfKiIbFuRkPKoqtNXpGyJUERXVQ5dUa/rKqyycfjSw7E2VWa/cpHG1qts/NT0RUocwu
 BqteEs2/XU7lIRnuIOEnFa6A=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 6a96a44c2aaa9fd1;
 Sat, 05 Sep 2026 01:47:42 +0000
X-Mizu-Trace-ID: 6a96a44c2aaa9fd1
X-Migadu-Flow: FLOW_OUT
Date: Fri, 4 Sep 2026 18:47:41 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
 muchun.song@linux.dev, akpm@linux-foundation.org, david@kernel.org,
 ljs@kernel.org, 
 liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
 dev@lankhorst.se, mripard@kernel.org, nat@pixelcluster.dev, tj@kernel.org, 
 mkoutny@suse.com, osalvador@suse.de, cgroups@vger.kernel.org,
 linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-team@meta.com
Subject: Re: [PATCH v5 2/7] mm/page_counter: report the number of pages charged
Message-ID: <apt0e6M99xvsxBrp@linux.dev>
References: <20260831163752.2193337-1-joshua.hahnjy@gmail.com>
 <20260831163752.2193337-3-joshua.hahnjy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831163752.2193337-3-joshua.hahnjy@gmail.com>
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

On Mon, Aug 31, 2026 at 09:37:46AM -0700, Joshua Hahn wrote:
> Add an optional @nr_charged parameter to page_counter_try_charge.
> On success, it will be set to the number of pages actually charged to
> the hierarchy. Today this number is always @nr_pages, so there is no
> functional change.
> 
> Of the 6 callsites, only one user (try_charge_memcg) uses that
> information. The number of charged pages is added to
> current->memcg_nr_pages_over_high to indicate how many pages it charged
> to the hierarchy while over high.
> 
> Today, try_charge_memcg requests "batch" from page_counter_try_charge
> and adds that same amount to memcg_nr_pages_over_high on success, since
> page_counter_try_charge's only source of charges is the hierarchy.
> However, this invariant changes later in the series when stock is pushed
> down from the memcg level to the page_counter level, and a page_counter
> charge can be successful without growing the hierarchy size.
> 
> Plumb the new parameter to all callsites, passing NULL where the source
> of charge does not matter to the caller, and passing &nr_charged in
> try_charge_memcg to account the hierarchy size growth.

The terminology of "growing the hierarchy size" and "hierarchy size growth" is
confusing.

The code looks fine.
