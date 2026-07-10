Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B45C44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 16:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8C4710E605;
	Fri, 10 Jul 2026 16:43:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="PpvYGyjJ";
	dkim-atps=neutral
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C92B410E605
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 16:43:13 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-902f92b8504so5357226d6.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 09:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1783701793; x=1784306593; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cCrA5GvcNcomQ8YHAskvpnsx6mUAVwyB/JWdGkfbiJc=;
 b=PpvYGyjJp0xWU+ViQ+Sr3wa5COTvrmu5+6SOnJsAOqPOxxQTkasQn9QxFivYmNhwFT
 3Peua7yMnGTyeGZZg3gFmLJGlY8b/RbfIop2hE5Trx3JEokgXxbsTmOE12VST9hJKgJc
 QvD5XprlLcbVw1dK8Ck0nmhmMW38VW+6BHul8xVssEINwIHTVNALdJpc8tuoEE6rfDmw
 uAyFUSinfgKazAhjjSC0+mWxfrmVy3V9RAE1ZW3yAsfMBRnK4IU1y9/ks5dbpOqbDDJP
 /TUZYFTlzClwCDsJOZYt4NGij463yTSGCqMzbdcMzEL35EM+R4Pwy1UVFCWPVFYkLC47
 rQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783701793; x=1784306593;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cCrA5GvcNcomQ8YHAskvpnsx6mUAVwyB/JWdGkfbiJc=;
 b=ilA7Xjm/86g4zz6hEw8pqo7TFvCefJ2SKMkqcQXIYyc6FYNazu+vo4IHtC+MGPtXCs
 sBdqhrUFwnoGWdIiUKWC59yoQJ0iGEiJdWca06xRLe3701JDBKXPlejwOGG4uEGh6edp
 8p7Ui7ZiBPwkudCEqRvHqwvLOA4CMZmw0nBe3NOJlEd097AJDZLMku7eKraIv2L4gtBk
 kC9xi/iI8j1U7IR67HmGgxBFryUhSxv6oy/+lUe/uI3oVdnldbXoTcGam/IHesPffKHF
 rjReumU9VwW3qfr9/5D45wyp6SqRiImLOGeYlh8PD5vWgVwLIIyHYkwbnWBi1e2oeGTC
 of8w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrIs7xyDiHDZxP7GbSamTcvc69Rxb9ZramN6+vu75wyPq97nMfUa2hape9MAnJeE3+fCYhP/7pPLGw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAxoBsNPg9yeMuIhzjmLvaCanrv6uofjMHaJo9mdGxUQvgZCUO
 89mjsz/n2cXwc37NKyeqJj+rTovupai4c0Z65QevfslAB9tpxSIqWt8U54MxfYF39Vk=
X-Gm-Gg: AfdE7cl4ixQykjISwfCJiLRzk72s2rcBoOuTg556OdtsPKJ/QttWDGtxkP0LBxfy0t/
 9RUNxwOX1/C+CDaQMFnsprXhCLOdJGEYxEojAbbvv7CVXkyxew6hPboJnuaJhsTsZ77KuwzzzKR
 iaKnOV3ts5MOc1JCrnHDH7PcPH6A4CNINsI0xBMAExeI5heG+/MSCKR4mzVpPT+sGaXMt7/4sRl
 bM3EUHunqsK/bXtS8cNtHWqJbyAR9Y3ci2EKMrp5QBKdyQICxsKh+4fqmlgQc0tVXzlzVJeYfoq
 HZeM2aCjbuqf8/Hb3Fi5GlflT0J1Afh724avonKaXZ1a+7wBin3kwOTSGKjlcttLgAcT/qj9d10
 /Na5FHL3b9qurnsXoVLSWmAWO1EI3F+StWh9PGC0Ym4dvFPwEOxFmdogo4Rme
X-Received: by 2002:a05:6214:43c8:b0:8f4:4d6:8adb with SMTP id
 6a1803df08f44-8fec1d808a6mr146369176d6.22.1783701792723; 
 Fri, 10 Jul 2026 09:43:12 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-900a7f8f5d6sm30725036d6.15.2026.07.10.09.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 09:43:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wiEJj-00000007Yof-1AFg;
 Fri, 10 Jul 2026 13:43:11 -0300
Date: Fri, 10 Jul 2026 13:43:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, david@kernel.org,
 decui@microsoft.com, haiyangz@microsoft.com, kees@kernel.org,
 kys@microsoft.com, leon@kernel.org, liam@infradead.org,
 lizhi.hou@amd.com, ljs@kernel.org, longli@microsoft.com,
 lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, surenb@google.com, tzimmermann@suse.de,
 vbabka@kernel.org, wei.liu@kernel.org,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH v7 6/8] RDMA/umem: Use hmm_range_fault_unlocked_timeout()
 for ODP faults
Message-ID: <20260710164311.GU118978@ziepe.ca>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345364975.660027.8790629832830633290.stgit@skinsburskii>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178345364975.660027.8790629832830633290.stgit@skinsburskii>
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

On Tue, Jul 07, 2026 at 12:47:29PM -0700, Stanislav Kinsburskii wrote:
> ib_umem_odp_map_dma_and_lock() takes mmap_read_lock() only around
> hmm_range_fault(), then retries -EBUSY until HMM_RANGE_DEFAULT_TIMEOUT
> expires.
> 
> Use hmm_range_fault_unlocked_timeout() instead. The HMM helper now owns
> the mmap lock and refreshes range->notifier_seq for its internal retries.
> ODP keeps using HMM_RANGE_DEFAULT_TIMEOUT for each HMM fault attempt,
> while interval invalidation retries continue to be handled by the existing
> outer loop.
> 
> ODP still validates the interval notifier sequence while holding umem_mutex
> before DMA mapping pages.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> ---
>  drivers/infiniband/core/umem_odp.c |   18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
