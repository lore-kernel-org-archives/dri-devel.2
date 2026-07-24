Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7599AC531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 19:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9BBD10E0A0;
	Fri, 24 Jul 2026 19:48:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MvOC8ODP";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE6710E0A0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 19:48:26 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so813961a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 12:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784922506; x=1785527306; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ioc+vYD1TGm3PkR61xqfpxrMbvRpPmr2378lUazgynQ=;
 b=MvOC8ODPdv3lughusDWqx10uwUd9yvCZYS60D8fQyhiWI4KHoNa+AFT2hFqXx1X9FZ
 P5/MGFff30HB2vdxaCGiOdTLY4EA9ifxC+v541mwed0XGfJo+g4GXlwUfHMsrxsRfxuE
 WsaODQ3L2SmgQHGEFSj+7GS6HywoEyqQWfhSu8uNvOdhj3P4BjDnMQ9NqHzSuUd92J0X
 2qJEBkhZ9nhpr0kTz29GIcVpUDnSQ8UTFiumWnrmH7ftZvYSe4ul1GGXwRSObrtDNOeA
 neDqZTsiu7nXJsWGN8svOhGHmkP+47NkzOyvKFjjSHdxc7RIacPw5knpYPmmxKSbfHgV
 QjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784922506; x=1785527306;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ioc+vYD1TGm3PkR61xqfpxrMbvRpPmr2378lUazgynQ=;
 b=hfy9JVBAPlWnRNxfuHw2sq2M6WcnZzz/r7ubba3F4wJTDlTRVB0/9NoajQzVeqi2qu
 YPZa2lEEGN3zO6nHVY4xAv/ATeTv/ZEBgyAODFFqDPjztnYclf/McqAo1WQrjhHvgNUb
 gLmEGHwx0MxCyJKanWYUNcMCk/3vaM2trs5YWMG+A5Oquja3gYsBPXSVp0ZMmFsHB2X+
 62i2hwYhaTGsuA1SIVy2JJHrTTxepvKau3NwG0YYKV5xzAt18BUgM678OMDHXFQWGYy9
 KAaymalKBMw0i/4se9pcyDCNbWVY9pNIq5fSY1gHOQ1uXfTdZD2ThZeWwZHDY9AiGpWs
 e5Mw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrPDnuvEjtdpadiaJFoP+bMvBbg/l6sbdsprG1YqrfgNuml+z4FLmZBxonyAVdCfGrCNTyh7F4tZk0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCe8dEERtV04ddNpLvhk5JK8u1XA5WykwCpf57tn2BqcHjnHuL
 gJ19oB8Fkl1buwHUyw/0jSuDIloue9IhskehptRcOQ2XW00XrpZjIv7c
X-Gm-Gg: AR+sD11IKqA/U6ETICwxcyTugXspYWsYmselZObSN2ILD38UW0qkMJ48IFmaVWMgaRG
 I+dtoUsRMVlrQbGKnUbHJW3CkBPNjA56owwvmd5Y0pWW9G1Fr3Fr8w7ThQroO/8UnSSc9quHJrB
 q1NcM3dLDdG3gs9e4ysghHQmPNwbT5aFO8zyQ9Vq9EscKqm061FOCzZ5xg+xVrP0DD/qseJ7BaJ
 XESmmG+7V2LTkgLMDT/VpojSgxcMRr+Fmfp5mEF2DxxEUikCTVK5zHtudkuQMRE0y+EyNFyoe/f
 RPz3gdTAp7FoZOEmxFxbUaaoZfdMgvhxU0oFAn8NNrsQ7HWoHoMpYdnz+9uAQ7ALM7goNUBDZXp
 ub3kAQfHgdj4HravVwr6J/p0TaNDL2USd6Bb1Y+CWliui0AX/xOzHBwcDgHVFCtcU72px0ifCwv
 sifLgWhLY323Ph2MZttts0ofR9wyzS2jjomQyCuPeQl53f
X-Received: by 2002:a17:90b:3904:b0:38e:584f:2515 with SMTP id
 98e67ed59e1d1-38ec6aae88emr8486005a91.37.1784922506003; 
 Fri, 24 Jul 2026 12:48:26 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f0417599csm2037544a91.9.2026.07.24.12.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 12:48:25 -0700 (PDT)
Date: Fri, 24 Jul 2026 12:48:22 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-hyperv@vger.kernel.org,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH v11 1/8] mm/hmm: move page fault handling out of walk
 callbacks
Message-ID: <amPBhhqIbdUQdlPf@skinsburskii>
References: <20260723-hmm-v10-v11-0-c55b003a4b61@gmail.com>
 <20260723-hmm-v10-v11-1-c55b003a4b61@gmail.com>
 <7655eaad-dcbf-4275-93f6-1f92ffedfa76@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7655eaad-dcbf-4275-93f6-1f92ffedfa76@kernel.org>
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

On Fri, Jul 24, 2026 at 09:00:24PM +0200, David Hildenbrand (Arm) wrote:
> On 7/23/26 19:36, Stanislav Kinsburskii wrote:
> > hmm_range_fault() currently triggers page faults from inside the page-table
> > walk callbacks: hmm_vma_walk_pmd(), hmm_vma_walk_pud(),
> > hmm_vma_walk_hugetlb_entry() and the pte-level helper all call
> > hmm_vma_fault(), which in turn calls handle_mm_fault() while the walker
> > still holds nested locks.  The pte spinlock is dropped explicitly by each
> > caller, and the hugetlb path manually drops and retakes
> > hugetlb_vma_lock_read around the fault to dodge a deadlock against the walk
> > framework's unconditional unlock.
> > 
> > This layering does not extend cleanly to fault handlers that may release
> > mmap_lock (VM_FAULT_RETRY, VM_FAULT_COMPLETED). If the lock is dropped
> > while walk_page_range() is mid-traversal, the VMA can be freed before the
> > walk framework's matching hugetlb_vma_unlock_read(), turning that unlock
> > into a use-after-free.
> > 
> > Split the responsibilities the way get_user_pages() does. Walk callbacks
> > become inspect-only: when they detect a range that needs to be faulted in,
> > they record it in struct hmm_vma_walk and return a private sentinel
> > (HMM_FAULT_PENDING). The outer loop in hmm_range_fault() then drops out of
> > walk_page_range(), invokes a new helper hmm_do_fault() that calls
> > handle_mm_fault() with only mmap_lock held, and restarts the walk so the
> > now-present entries are collected into hmm_pfns.
> > 
> > No functional change for existing callers. As a side effect the hugetlb
> > callback no longer needs the hugetlb_vma_{un}lock_read dance, and every
> > fault-path exit from the callbacks now releases the pte spinlock on a
> > single, common path. This refactor is also a precursor for adding an
> > unlockable variant of hmm_range_fault() in a follow-up patch.
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> > ---
> 
> Any reason my RB got dropped?
> 
> https://lore.kernel.org/all/0b9be5b3-93aa-407f-b83d-409bec4b55e1@kernel.org/
> 

No reason, just an omission on my side.

Andrew, could you add David's RB to this patch, please?

Thanks,
Stanislav

> -- 
> Cheers,
> 
> David
