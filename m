Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B75C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCB0A891E1;
	Mon, 20 Jul 2026 14:46:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="q4gTrKD/";
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E967891E1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 14:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=PfRAFhBZQchppXOO+Jgr0cSkDMbt1DF4C/TUagsgCiA=; b=q4gTrKD/JHkF9rdgVeJRopM9/L
 urB9FO9pjuI91E3n7c9jeYmhfBQk91aQcrjjO1TtyyNPydmLVGxvVs8GYqpkhU6xWo+Hks5uvS6sB
 lbHDdqdJUCjuYiG8mU+GU49oC7mnX3Kj2F6mfBWxhopOLY7hye2br5fU7IrywpKGXRzGUth0DCKqO
 83YobtUbSGP3EUD1DQkEyI0UuUvTT/LFgFWKV0uhYRaMArtJ9d8bjgZRIC4ZiJqYnK1EvgzzFLcab
 03iYunE5zqja9kzp9HTj1eUqgezn+yrRqb7Fy3L6X8ZPqqAF9rs3rAq2uuSLtzcM6NlT1/E509PwL
 LAH7i8BA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wlpFo-0000000B90V-2Ozj;
 Mon, 20 Jul 2026 14:46:00 +0000
Date: Mon, 20 Jul 2026 15:46:00 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Mark Brown <broonie@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 Christian Koenig <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org
Subject: Re: linux-next: manual merge of the mm-unstable tree with the
 drm-misc-fixes tree
Message-ID: <al40qCMTxhEP3Kx8@casper.infradead.org>
References: <al4jGBGNG_QACaNL@sirena.org.uk>
 <20260720144141.GA16699@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720144141.GA16699@lst.de>
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

On Mon, Jul 20, 2026 at 04:41:41PM +0200, Christoph Hellwig wrote:
> >   /**
> >  - * ttm_backup_backup_page() - Backup a page
> >  + * ttm_backup_backup_folio() - Backup a folio
> >    * @backup: The struct backup pointer to use.
> >  - * @page: The page to back up.
> >  - * @writeback: Whether to perform immediate writeback of the page.
> >  + * @folio: The folio to back up.
> >  + * @order: The allocation order of @folio.  Since TTM allocates higher-order
> >  + *         pages without __GFP_COMP, folio_nr_pages(@folio) would always
> >  + *         return 1; the caller must pass the true order explicitly.

Wait, what?  This is just broken.  TTM should change to allocate using
GFP_COMP.  Why can't graphics people ask questions before writing stupid
patches?

