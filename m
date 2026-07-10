Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55333C44506
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A91010E7F0;
	Mon, 13 Jul 2026 07:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="GR6lqUap";
	dkim-atps=neutral
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACF6A10E1FB
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 21:10:01 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-8ee6912d86dso10747076d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 14:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783717801; x=1784322601; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FM5wmgcpnXqQ2LPOtHbLfNIfX5IHSF2YMfcySjsQd8k=;
 b=GR6lqUapgDiGWN8Pmy3BqtJTarUlZagyhqj5l8YpURcdgBHI+kcjfDseypD7mUjay8
 sXb/zpQVI1o5DYdj5tJAIrTE9VJmui1ZDD7Lg7ke4i0B7ndWU9cdzU6dGcipXuX7OHIB
 M1lisuzySVYLoAGgtJA24Um6TLQnhkXTZualXt4Gre/du2uC16Qs3kdzP9Q3JwGzW+F9
 392AUJyQm9/vexHwB+gCgQvra7ml4rF6JfdRix3COFfDfmxrMDi/Rk1mV7yYMBvs/3rB
 RCb11lDlmHA6an+EeMteMUE5CrKxsy7YZUn+YTUXc4C7kQbtpuqzFZzCFykQdTVCf8bY
 tFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783717801; x=1784322601;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FM5wmgcpnXqQ2LPOtHbLfNIfX5IHSF2YMfcySjsQd8k=;
 b=Jhf+9HQYuaogGiZvTdP/NWWFBRQGUMFj11sKQnU1dlKEnjZL4iKjmf3pLDe92q5Ulk
 jHOdwF+4QODiQp/o4DyjQTsXlifFc2Wq9bQIvY4OLIatsXa/pcZXSFkCCYXTR9D8/rc6
 rTAvn4fQJjMZB2RsMCvvQzvGV32tiz4dOauLDKTyVR/qm+UFZOqZAMj6bj9P7INYXg9m
 QxOUwYBN0ozBTQgryGrMf/nE5P46wWZpFz8+iNiMlbkny1Mem1+PwbSU488tk18T5rC7
 izforfu+OzdAhprNAcqgrkHibt4/Zujt+UEDfIoxLw++TgkLPem1jQyLwFthoPlEol+b
 e2vA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoX+SeZ8dSR6XHoGoOhNzUV88SuTk9KBlDh+j3WcjWrDKi7+Lf4taVEqBkIxUtUi+zGHJF2NPoUti4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyvTV3vvePfyX+2vZR7ezcUiUq1c6uHId7yg/h3xP/8sqNtkDQZ
 amBpYKW3o5y8OlNixT/Pz7sWLzWJF/0Ow5SFnPDvsHyat0bclAX7TJaPpb5Jo0EkOJ0=
X-Gm-Gg: AfdE7ckTVqoB6eLoMySPUL/3HABDhoz56b/X+D+WFZDsR3yPVCLznzQPbNwwfy3Ubj5
 /qDpGvE7X+4XrYcE6ZuSA53BoxeR86A4DCglc7xgLN0ERJeD3Wt5iH3flki4OHWBDkb3gtsvMSz
 Ok8rS9SFPMVm9uv/lJYCBsds9wJkvqKSb0JWNNN8K/EYSn9mWcS4ai0hCcOTB7X4B/7+wddGg3H
 e/FV94+0L7zWo91zb0FKTp+muJvuRidgZf+0pP9WS5Z1TwNri8T6JifrKNH4M6uTb+MYQZR4qay
 qfzNi4eyFISN0xi/pAw3eUeHIXqGG1Kq8p3t1Zp5bfd860NBZBKecIZUGxf5ulJ79dhvniyARbi
 huoiJyaRJ1lgTynSgZrWSy7WveGEu3Z+TkZY7RkS+jbVOVH13iTaH23DhzR/7v1+yODQWC3Crzr
 rAN6EuNpTLJ3kX4QFqjFL2r0FaNLjtodac08dzozaypL+BBEfQzvBQ3efmAdUcYmiqRt6j
X-Received: by 2002:a05:6214:31a1:b0:8d1:d1e1:8360 with SMTP id
 6a1803df08f44-90400b7f3e1mr9010646d6.39.1783717800595; 
 Fri, 10 Jul 2026 14:10:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd87c8d4csm52955776d6.44.2026.07.10.14.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:09:59 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:09:54 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
 Lance Yang <lance.yang@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
 Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>,
 Simon Schuster <schuster.simon@siemens-energy.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Dan Williams <djbw@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, SJ Park <sj@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
 Kees Cook <kees@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Alex Williamson <alex@shazbot.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 kasan-dev@googlegroups.com, linux-sgx@vger.kernel.org,
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, kvm@vger.kernel.org,
 Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 33/33] tools/testing/vma: output compared expression
 on ASSERT_[EQ, NE]()
Message-ID: <alFfopehgN0dkMzM@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-33-2a5aa403d977@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-33-2a5aa403d977@kernel.org>
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:10:39 +0000
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

On Fri, Jul 10, 2026 at 09:17:14PM +0100, Lorenzo Stoakes wrote:
> Update the macros to output the compared values at hex for easier debugging
> when test asserts fail.
> 
> We have to be careful not to re-evaluate expressions as they may have
> side-effects. So update the code to take local copies and use these for
> both the test and the debug output.

Aw you found it before i reported it :]

> 
> Also remove unused IS_SET() macro.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>


Reviewed-by: Gregory Price <gourry@gourry.net>

