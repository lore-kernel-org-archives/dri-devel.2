Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6210C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D052A10E7ED;
	Mon, 13 Jul 2026 07:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="lgrBnLD7";
	dkim-atps=neutral
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 983BE10E1FB
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 21:17:03 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-92e67555e24so72772385a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 14:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783718222; x=1784323022; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Izor2xUYDxPFma+uXVb9laI9dziDM9wo4fE46zQgxzc=;
 b=lgrBnLD7rxBGet6VmxU5R7ZJoRVksSgy4PNUvOqa6+6YYTtZPfvPXae+82t7ayrJvl
 OtZcQ7oNyVGRh5hTQlYgavaMOD0D2DN+AjRa9sdQAMY9z1rZk57NXd+tfzSMRzWXUUG1
 kAlJ+bKvEZCH3FbEIzWTuA10kGVYvj4Qy+cV9/tEPZ4zdkmO0Cjt7QVdiBDFyO6vuTOR
 KrRPQrEeyTm6KwdthU1LEVigmHRMA2ZPN8QaFn39ZU4BPI7l58h53svuLfwhv5FEtEzo
 st1bHqyrIIzh1Y5I9SgBbWItgtDNxXsrDx4TSRiDARXs5uHDWQi+T12UOt84pCiWFPZq
 nkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783718222; x=1784323022;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Izor2xUYDxPFma+uXVb9laI9dziDM9wo4fE46zQgxzc=;
 b=bpk6EN6XeIqtlGJG5833RRPEAmrVv4nffTxOoGT/0nfbplR1PzSWJ6NvpGAEuApXj7
 PaAo44N5Op0mJjxJm0Y14XayBL8HuFIVxUuFH3BGGguYX6KdPrNEf+TKFOfVAdl9zLWl
 i6N2W2JemI7YKgRMoXDNoPsV/mF/MdkjyUITo22Jqof58+Cu8vHjHu8XuJjXXrk+j7+e
 lJFZxHpDcHdkY6ajCU9/yD04NSW7GnS8gwnX/Ghgy4RvS8HQA11YNFoTezryd4bE0xxd
 8kdXFBYerDzAzLlK83DHtRKbV1HqGEI2zys5pAZ7t9WrXLE41B3FYFvZ2yHPcXwX13lX
 vVqg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5EbEvSm4RIyVGworIW14D0MzuYIPGCiKR32WBSg/K82FGiZ+qzCiCrm0zeYulrR0p+NF787Pon7E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyo1Zs8iHfVoJ9lk2xoOt0WXhm5YOaIj2ez8bGYurnDQh7orYrK
 7FyFNrHWNyIjNIGaMbZraWgufGBahQKybz3YuCkkPJPhyrTS7lX1FvDG/CcznYrKZXY=
X-Gm-Gg: AfdE7cnCk/geBkfnnWEq8P5WNYfClS6kwWUgngYtWHZWkW7xhnqhQAuKTtrPK0vstVA
 9JRD8n/6lRWBLTRnl1JyB/tCfQCqY4xLJRYDi0AMLKk3nW8FgmgdZjXAg32eSQUdJkiRAM5caXg
 NOthaOnSaKnfKjov4dVYySKB9C+DmXHv5ZQVdkbFbj8KeJN6Pnt9yEL13a/jCQ5f1ZC7cVoKJPf
 dXrxKriMA0EVoRPOUqVBFYWGwO+c6kVFQSOcRUAXyNRKo97GWGb9cZYPOEU2oK4w4ouCoNZqiFV
 itdyncbyDfbtCM+r69uh7iJEMJHl7eCF1ZZ9SSbwapLNSJ5mV+Auamtb4U1xb7HV25xMsNoIi68
 m8cYBT0iUPBMgu3jeNfywVSK5CnB3tvT8hovhSby+ID0UwdrIs96M1ST+P/eYH+UGME3Ei+Ve+D
 htwT1hLiX9WrYN1I6Su4GYUwNOAYzHO8c2+urseQccU83dVCJw+raUhvjCML9tLwEZBd9S
X-Received: by 2002:a05:620a:2691:b0:92e:72a4:f290 with SMTP id
 af79cd13be357-92ef2b3518cmr83584585a.19.1783718217777; 
 Fri, 10 Jul 2026 14:16:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd80fe218sm49983646d6.33.2026.07.10.14.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:16:57 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:16:51 -0400
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
 Naoya Horiguchi <nao.horiguchi@gmail.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Alex Williamson <alex@shazbot.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
 iommu@lists.linux.dev, kasan-dev@googlegroups.com,
 linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 11/33] mm/rmap: rename anon_vma_interval_tree_*() to
 anon_rmap_tree_*()
Message-ID: <alFhQ71-WGGHo1sJ@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-11-2a5aa403d977@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-11-2a5aa403d977@kernel.org>
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

On Fri, Jul 10, 2026 at 09:16:52PM +0100, Lorenzo Stoakes wrote:
> To be consistent with the newly renamed mapping_rmap_tree_*(), rename the
> anon_vma_interval_tree_*() helpers to anon_rmap_tree_*().
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Nice.

Reviewed-by: Gregory Price <gourry@gourry.net>

