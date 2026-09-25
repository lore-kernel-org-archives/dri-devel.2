Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4F0C98324
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 10:24:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1923F10F9C8;
	Fri, 25 Sep 2026 10:24:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="aU2MEIfC";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 216D010F9C2
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 10:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790331840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nqSQfDrdpDYW051eAGtg8LkmO5WsRJfyGEnYEAE/NaQ=;
 b=aU2MEIfCt45e51szoZQauZoqm0l4KroNY454TAr3TQICdAHWoP0goDBKpsZ59u+kfP5bCF
 JZjiNU8/YFUEIPpr6O4Tb72Kc8YgtHzRVr9jirYB0mluBcgFtQmoHBOOnxFDskoN8B4yEv
 0zMDA+cBadNDa6v8cESkQfWWBGOaFok=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-jRdQ7I2tONW7S2XkHJz26Q-1; Fri, 25 Sep 2026 06:23:56 -0400
X-MC-Unique: jRdQ7I2tONW7S2XkHJz26Q-1
X-Mimecast-MFC-AGG-ID: jRdQ7I2tONW7S2XkHJz26Q_1790331835
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3a59a300bfdso3543671fa.1
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 03:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790331835; x=1790936635;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nqSQfDrdpDYW051eAGtg8LkmO5WsRJfyGEnYEAE/NaQ=;
 b=ihAH+iTFTv6gvdYFAxlstlgTk5T1YNQgbVZtzveFbtKIlGe/yKZx5tw6HyOuq2/HMN
 HCYjFBiGgcWmeDFOHIhsyMYSFUEETsMky08MmXIZGJ25NVthLIBnSNPJe+mik0CraiEe
 /pw9HO7b8fqJ7ozQ5HNqmDVGXkfjuqWlrvnMdI4kUj6Rfiiqd8CrHOxtII+NFRrBSMta
 1CLC1lVPdOiJ1ZQwLC71m7Y4Kf4UPJn87mWwBHg62+zQ7/iKU9/dWWhB1PvtcN0jUv3K
 UXEdTmJBX3EHqOW8tITxk0vpix36ZtmMlDxiMzmQKIGJGJ4GCsdw4VnPIsbIYXxXHkKq
 aNGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwRivOwh5aGGl+HSIlscVcKcm5kbCZdJ8/SPItaqHQ5ETa2gsKUjdLUPud3a5B3VZWYc8rLsj2mUeU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++neXzFoeNe1wfUnovebEbENqchc9e2iSHCl1Q6bd7i6gdwPBiF4
 v7ASHfnCb9i7FLqL8hwlKHh8n1KYu8pzXYuETBXrVsHXWNISxO2QhEnRq/yXBxFtzFaq54SRyN8
 r68OsF+rMTsxUZOFPm5OJTplYxMFPwJ+Zc4Bk15ipnE4rQcZ/5git0zda5sduOoWilCpd
X-Gm-Gg: AYBFou2jj3JpqXh0/sK0S42e/5VnFT2e1h1FoOgh3dxKPe7vlHvuvS9d6Xo771HTaJo
 cJgwnu0RK4+jK6bypUceGGhXS4E2B+MUex6AmvdIjYpKMu7pCiA881Lp6yHaW7iKfY9sdK54aRQ
 0WlEjn27/NYZfCZK2EjpxAoYo9zETckuvFBiB+GVCjmxPbU9QUr3fmbBpCrcH4CM3vtnAUQVjz9
 b++P3CTzdm42nycuhLC9yptsW0nvUSkFXRw1EX/tIiLk3lK6xrPidEsEp1G48m6hke+dIkSHy1d
 Cam2z8cCLqN5CHs0lxzRT8m3amo0EkhSMFAPcR27RX1XrmsbSw2iqSUyCBGT887C2fems1JrLYT
 u9ay7ksQ48SYoBK94NOkX36nlEW0iFbM=
X-Received: by 2002:a05:651c:b0a:b0:3a5:dfd3:41b6 with SMTP id
 38308e7fff4ca-3a63bdbaf2amr14482531fa.0.1790331834967; 
 Fri, 25 Sep 2026 03:23:54 -0700 (PDT)
X-Received: by 2002:a05:651c:b0a:b0:3a5:dfd3:41b6 with SMTP id
 38308e7fff4ca-3a63bdbaf2amr14482331fa.0.1790331834509; 
 Fri, 25 Sep 2026 03:23:54 -0700 (PDT)
Received: from [192.168.1.86] (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a64c2ea5d2sm4507651fa.18.2026.09.25.03.23.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 03:23:53 -0700 (PDT)
Message-ID: <65c5c412-56a7-46a9-b22b-22077a8e9727@redhat.com>
Date: Fri, 25 Sep 2026 13:23:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 00/11] migrate on fault for device pages
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
References: <20260924065313.899730-1-mpenttil@redhat.com>
 <arY5zKsLuf7f_EYw@infradead.org>
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <arY5zKsLuf7f_EYw@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LYpFfgkS2zRspmWh1LGzxzZldMt3P8F2O33cEpEYFQs_1790331835
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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


On 9/25/26 12:07, Christoph Hellwig wrote:
> Who is going to use this? The series seems to lack an actual user for it.

Two users:

For one, existing migrate_vma_setup() callers, unchanged. The series
reworks migrate_vma_setup() to collect via hmm_range_fault() internally
(it sets HMM_PFN_REQ_MIGRATE and calls migrate_hmm_range_setup(),
mm/migrate_device.c). So every in-tree migrate_vma consumer — nouveau,
amdgpu/amdkfd, drm/xe via drm_pagemap, lib/test_hmm — runs on the new path.

Second, the point is to fault-in and migrate in a single page-table walk
instead of the 2–3 walks drivers do today . It can be driven by
hmm_range_fault() directly instead of ping-ponging between hmm fault and
migrate_vma interfaces, and lib/test_hmm exercises it. migrate.vma is
also populated now for free on fault path. These are aimed at SVM like
migrate-on-fault, and is motivated by Alistair Popple's experiments
with  current interfaces, where the redundant-walk overhead showed up
clearly in perf traces. The unified page table walker also avoids some
limitations in current collecting interfaces that can crash when raced
with unmap.

So this is a building block for migrate-on-fault but delivers immediate
in-tree effects by unifying, refactoring and more robust collecting.

--Mika


