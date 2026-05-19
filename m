Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5903FCD4F54
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 23:38:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C6D910E013;
	Tue, 19 May 2026 23:38:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OS9zLKic";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8D2610E013
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 23:38:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2592560229;
 Tue, 19 May 2026 23:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A321F00893;
 Tue, 19 May 2026 23:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779233933;
 bh=nRQgbMjzxu8Q3kOrsyDwli0tf7eSBOzQr+PWLku10Rc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OS9zLKicRAaT0ytGqArZtlKKQMTl4c4yfc7HkT8Fbm4pW7slkIkJuyJS4jABvY+is
 57p8QyTJlXVhvMoXPgA2GDDM+pEFicCRawsSv8wCiRTWbsBY/cPlsGeXZdlhWGQvGB
 Pmx2xLRg1JU0vxDqGPQwbpprmgdNYmbAqZIiJwCtYTxWJSgkX0VK9WV+P/CY/K3il/
 4AaQKZMX73BqXLMoJkDSlKah7GrzZ6OYnuslOzzIBaW2DbWsiOPw/BEsfP0DrGMcdr
 Edq2FWfbKCdtIEm8m2e6Z8fegrW+0ygMk3dHTl92JkDpeVWDzxOMuvU4HnM58x9U7K
 YBzUWIivryjjA==
Date: Wed, 20 May 2026 07:19:35 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T . J . Mercier" <tjmercier@google.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-buf: system_heap: Use LIST_HEAD() to initialize on
 stack list head
Message-ID: <agzwB78oIt6yZAOs@xhacker>
References: <20260519060532.13221-1-jszhang@kernel.org>
 <b4acc363-b307-4ce1-beef-fece0d66e696@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4acc363-b307-4ce1-beef-fece0d66e696@amd.com>
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

On Tue, May 19, 2026 at 08:51:00AM +0200, Christian König wrote:
> On 5/19/26 08:05, Jisheng Zhang wrote:
> > Use LIST_HEAD to initialize on stack list head. No intentional
> > functional impact.
> > 
> > Change generated with below coccinelle script:
> > 
> > @@
> > identifier name;
> > @@
> > - struct list_head name;
> > + LIST_HEAD(name);
> > ... when != name
> > - INIT_LIST_HEAD(&name);
> 
> The patch itself looks correct, but my question is why would we want to do that?

The benefit is: simpler code, combine the linked list defintion and
initialization in one step, thus 1 LoC vs 2 LoCs; And potential bug
prevention, e.g use the list before intialized.
But I agree, no strong benefit here.
> 
> Initializing the list head (or any other result variable) directly before it is filled in is usually good practice.
> 
> Regards,
> Christian.
> 
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  drivers/dma-buf/heaps/system_heap.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
> > index 03c2b87cb111..6f8b7138ff56 100644
> > --- a/drivers/dma-buf/heaps/system_heap.c
> > +++ b/drivers/dma-buf/heaps/system_heap.c
> > @@ -409,7 +409,7 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
> >         struct dma_buf *dmabuf;
> >         struct sg_table *table;
> >         struct scatterlist *sg;
> > -       struct list_head pages;
> > +       LIST_HEAD(pages);
> >         struct page *page, *tmp_page;
> >         int i, ret = -ENOMEM;
> > 
> > @@ -423,7 +423,6 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
> >         buffer->len = len;
> >         buffer->cc_shared = cc_shared;
> > 
> > -       INIT_LIST_HEAD(&pages);
> >         i = 0;
> >         while (size_remaining > 0) {
> >                 /*
> > --
> > 2.53.0
> > 
> 
