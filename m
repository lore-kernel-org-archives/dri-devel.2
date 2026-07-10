Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A31CC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EE9110E7F1;
	Mon, 13 Jul 2026 07:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="ppLwpX6a";
	dkim-atps=neutral
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7938F10E1FB
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 21:17:54 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-92e50979c71so135500885a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 14:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783718273; x=1784323073; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3ZedB0VQ1AWAm53tDDWxHLVghH418fWVIB0lX7U1LiE=;
 b=ppLwpX6adCencoEtDPgihH9OEl0ecP5lMJtV0n722OZhDgajUPTruOpAy2zOQwWPF+
 GPgf0yuvdCMYuPXTWp756jERYo5ASDZFNTkEwgMHYvWRSgR3cXEOn6GgB/1TRG3AqePn
 jtPYH1O3c9Om8Jnai8dMmfZjimYYKB/lvIIOfc6sD+ismzDjebUACwxaLNi6e22f2wVJ
 jUf7PBzTUtwCDx/n5/TWDEfE8/30dIytAn5GAJUna8JEXDrDdo4Q2kdtNuVxSesP9EE+
 4pn8WvNumUVC2OWz0epNZyUZaEAZVByToCcfP94d7598tcuY7nVJSDXh0I79KBoiqiyN
 nRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783718273; x=1784323073;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3ZedB0VQ1AWAm53tDDWxHLVghH418fWVIB0lX7U1LiE=;
 b=XzWT0WI9RCRP/nXUXcnRq32/GsE1Of9azOWEYVKNHytu+ywGugbdgYoyjEA9DbELKm
 tJOmq4gumyaT8o2myIzvYZFzmSQeWrFYys6lYdeeQFsnAtwmGEtFTZIjfzbUQMW8Cxz8
 VCd2Vl1sAgtrboOHmoBpcr1bV7W2mSqgQZx8bAwRCMi0spVfvpkzmKqK0ekBYu77Z88p
 AlWiG+yaFbqZJunhNM5WBv8h4kUnKrYWvl3qRk2gn73Ue8ktVo26kYAKmlvCAaQY05xH
 SmeTnk1anUqM3rGuzxVIJpXpV7FzzJxgRSB50HNemvVT3aasx600tmOCZte8MFppsG2d
 +g0A==
X-Forwarded-Encrypted: i=1;
 AHgh+RruRWN4Zg3k1hkwzd3Wp5Te7H/JvtaMWWX5eVs6/z9PzlGjHvaqA8/0rF2kWO2Aec6nf3OzX41QIN8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyBRihEsT/5HeFdvAfWfrbPYymdudlW2fSd4mvjCEkqN5fVRJ57
 i+cUvYk0zyyvLOyw90i/ARbjUZGSPhxx/hhz8Usupj9J/BKcTc6QZH/KqiTrbxKHfTw=
X-Gm-Gg: AfdE7cmKwO8DUsNUhbGKQoVv05TcXexhcVj1rtgm+aWFt+v12i/KZ27e69H9eFLSciS
 ZRt+TokGkpHc05yDmN2tn/OCyD0LvlnrB8NTlQCQCmDjw6f1VNlFp0Xzkz1+2v+I8vm7Q3yCQiA
 WMGVdI8kK8d19JAr4b76vOGyarUhEWaLT9Wshj5EesC0J7twRqvOCs0j7wSj1H75q0DpiZFsguL
 taXToJMs0IZTlKwAag00mSqlz1t9x6BRyKR7ozCYmrJpIssM/65u8vKGGgZFXyNyMD/+VkxCRQJ
 zcT9XZ1CCIy3cTPaARh8NRWZztCG3nqLNEEomtpJSCBVgp/SmxIdcV/8t/RmO764yb8B9uqdxWT
 ZXENInXd8YkwGvLjGeOGN77jM4P6Oid0QUSKf6zOllWR8aE7XjK0HmV8SRQeyOvFnm+IZCbe3Cb
 m2k41NPLVWSrhe5+wJd+PrYBDuLEc70UlPiGUgjltaRqsMUZa/H95pKmr+095M0WftIqkB1zEvc
 xaH15o=
X-Received: by 2002:a05:620a:40d3:b0:92e:7afc:93ed with SMTP id
 af79cd13be357-92ef2d03c09mr108964985a.71.1783718273295; 
 Fri, 10 Jul 2026 14:17:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92ee5b4b1bbsm292932185a.2.2026.07.10.14.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:17:51 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:17:45 -0400
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
 Ian Abbott <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
 iommu@lists.linux.dev, kasan-dev@googlegroups.com,
 linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 23/33] mm/vma: add and use vma_[add/sub]_pgoff()
Message-ID: <alFheaAGWCIAjom-@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-23-2a5aa403d977@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-23-2a5aa403d977@kernel.org>
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

On Fri, Jul 10, 2026 at 09:17:04PM +0100, Lorenzo Stoakes wrote:
> Add helpers for adding or subtracting to a VMA's page offset, exposed
> internally for VMA users within mm in mm/vma.h.
> 
> This is to lay the foundations for tracking anonymous page offset for
> MAP_PRIVATE file-backed mappings, where adding and subtracting from this
> value must be reflected in both the file and anonymous offsets.
> 
> These are used on VMA split and downward stack expansion.
> 
> No functional change intended.
> 
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Carrying over from v1

Reviewed-by: Gregory Price <gourry@gourry.net>
