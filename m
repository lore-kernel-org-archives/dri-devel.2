Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0666606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ispras.ru header.i=@ispras.ru header.a=rsa-sha256 header.s=default header.b=plWaYjKp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C8910E274;
	Sun, 22 Nov 2026 11:19:46 +0000 (UTC)
X-Greylist: delayed 368 seconds by postgrey-1.36 at gabe;
 Sun, 22 Nov 2026 11:19:39 UTC
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81CF210E274
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 11:19:39 +0000 (UTC)
Received: from localhost (unknown [10.10.165.81])
 by mail.ispras.ru (Postfix) with ESMTPSA id 554A1406C3E3;
 Sun, 22 Nov 2026 11:13:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 554A1406C3E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1795346008;
 bh=iAIW/COfednaradL1rZmGyackZmIRiXlIbxDPMvY0C8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=plWaYjKp232+FtUI4KdkCTEOzdrrw8FGPxPA+Gng0OXAomXEJvrbRzqVnPuQCqtZa
 HtIGRJgjlXLO7b1l2gOGm8VAHAuWlZD/d8Ugs6B5TY8nh6p9Jq3BuM0JnPabvRgI0m
 kfEZa0LYfjUKJpHjTLoFbq7Kgu8wSAMNe2dM7rjg=
Date: Sun, 22 Nov 2026 14:13:27 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 airlied@redhat.com, dri-devel@lists.freedesktop.org
Cc: Ian Forbes <ian.forbes@broadcom.com>
Subject: Re: [PATCH] ttm/pool: Don't leak LRU list on shutdown
Message-ID: <20261122140812-09f251792405451c0dc74623-pchelkin@ispras>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf3c13a8-1dc3-4b2a-8d37-0be289a31980@amd.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Christian König wrote:
> On 5/27/26 22:20, Ian Forbes wrote:
> > TTM pool was changed from a regular list to an lru list in the
> > referenced fixes commit. list_lru_init allocates state and it needs to
> > be freed unlike a simple list.
> > 
> > Found using the igt@core_hotunplug and kmemleak.
> > 
> > Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")
> > Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>
> 
> > ---
> >  drivers/gpu/drm/ttm/ttm_pool.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> > index 26a3689e5fd9..a41addbf3ddf 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -395,6 +395,7 @@ static void ttm_pool_type_fini(struct ttm_pool_type *pt)
> >  
> >  	list_lru_walk(&pt->pages, pool_move_to_dispose_list, &dispose, LONG_MAX);
> >  	ttm_pool_dispose_list(pt, &dispose);
> > +	list_lru_destroy(&pt->pages);
> >  }
> >  
> >  /* Return the pool_type to use for the given caching and order */

The patch probably fell through the cracks.  Can't find it at drm-tip.git.
Would you apply this, please?
