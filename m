Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D946C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9349D10E783;
	Mon, 13 Jul 2026 07:10:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="A4eInKcj";
	dkim-atps=neutral
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02AB310E605
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 15:09:09 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-92e99ef0902so51647385a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783696148; x=1784300948; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kfeOD7p/qxHHEIV6dN3ojdA17bZ6I64Gd2Z+QpoWxkg=;
 b=A4eInKcjRnxSTipkdrL/JiK4jLm2hKeYSSmffhcve02wbT4NWF/e8QZ4KWGO9powvg
 B9kQKQSNogsZt1N4mMrdo5llnRiTaez1H7stOIr0ecD0tR2cScEiChyJLssswpsyXaVK
 Ebzk45jG+MrzqGE6dScvAYV/G82rUdiZMUXMvcFES8WlrkdhLjOWq2dPLW0VfE51EFBx
 fCISVfOs4p6qCar3itvJ0gl5xoYd8p74q+a9O0lYWlr+LflVhhV0IIZid5xtHJJpajbE
 t8Znj9CseP1X4gk+P5rFjqye43TbDaEjpgu0dd98u/ym9hQf671E5R1aw3Z/AFyCj5Qu
 8IlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783696148; x=1784300948;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kfeOD7p/qxHHEIV6dN3ojdA17bZ6I64Gd2Z+QpoWxkg=;
 b=pODdOu/a8Pen1Tha0UXjEYY3X8mU28kGSOpkQ2QlDgfpbB1OfUxvs5rTAQwoO3sj5d
 EVazd2TuIUDFK4d9c5H1PrhoAUCf8crPrHsi/GsK/DnVcwWMvwjDqdHnt39DK+fkPQuN
 w98KgtvbRrI/cko6Q1cxwiAQ2Xireb4mBt6yma2b///Bq805BAmbEfhNZzn3NcfRYtgk
 kQUC3lbFYzw9Jrm0FPbmYHp7ex/FJfN7qVokJ1tnMaSABsw/MxzRydP3VqyU4v3TJEhZ
 f3Ez+fiqL8KJrgC2CEcCDXXppE1UHKFEr4mZNBp+p2xNh0VAb6agnXiKkxm1fYw+rcg6
 0FxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr4SWYlZmx6v2FdtRX/KAWccBItHbkK9uYMHrR7EKtS83kcyG9TUobcePQIUcKyJDGZpnGOMlzQbKM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFH4KzbnuLGY08Ej9+5f8eX5XkEI0Z7CPCBdBcAmhjue0CDYzh
 szcjzaGJbgo5Qd8bAwZtxNd+O2JSriQulOWllUEIS4PhSRThbXFmVFKPsMF2+YcB0r8=
X-Gm-Gg: AfdE7clySr5+rP6/hKdBCxUvgltiZsXsaY4en+JsQZQVbAd3UtkH1T2LDp9sd10KBjO
 /NzaVqxMRFVuwPUJPFwAiU/9S5XJ2U13tRd5WQbumZ+99tJ4n6Ctz0CpjCI3QN34LQiWoabCmXF
 YHjKPoxQ6v0UMe/UZHl5aCjGv6C8mQnZ6iJB5tI365GHkPsgltUrJRAMEupXCa2DpagT+Otaw3j
 EXYHden4NWGIRxmtUWxZGyPyWoIIpLF3MGnpxzLLYucAITdSXrernBbhUEQm3IECnhnTnpW3w6T
 gGzw9EZMJ5fgaSGFjQQxlzR1YC1ExP/JTcatmRTqe9mX4mCBmR6y2IOuF5lxWJDdyv+DM5ZRguX
 fIFYXiMmsYjxq9phHMac1Ojy1tgv25Y0xkkrkEBshDRpjZkFRlPI0UszLP6iL31c9JHD+LW+tW5
 mv4LDdyy7WWs0CTifs9ubPMchDnm0hPX4aFfa3qLsPo5XMJpaJpY7rPIryFFWaRlUBbDtZ
X-Received: by 2002:a05:620a:4414:b0:92e:7d53:8e8d with SMTP id
 af79cd13be357-92ecf55964cmr1359477885a.27.1783696148308; 
 Fri, 10 Jul 2026 08:09:08 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92ee5d34f76sm213283985a.35.2026.07.10.08.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 08:09:07 -0700 (PDT)
Date: Fri, 10 Jul 2026 11:09:02 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>,
 Simon Schuster <schuster.simon@siemens-energy.com>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Ankit Agrawal <ankita@nvidia.com>,
 Alex Williamson <alex@shazbot.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Dan Williams <djbw@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <liam@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Hugh Dickins <hughd@google.com>,
 Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-mm@kvack.org, iommu@lists.linux.dev,
 linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 damon@lists.linux.dev, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH 17/30] mm: prefer vma_[start,end]_pgoff() to
 vma->vm_pgoff in kernel/
Message-ID: <alELDgm258nhjk3b@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <ea87349d63205bf4c26ea79854f179a9bf8cfb0b.1782735110.git.ljs@kernel.org>
 <akZCg73F-oGzDp1a@pedro-suse.lan> <akZGqclqQ6gS12Vv@lucifer>
 <ak_C_o2ehS17Q5HV@gourry-fedora-PF4VCD3F>
 <alEHy1raICek7imv@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alEHy1raICek7imv@lucifer>
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

On Fri, Jul 10, 2026 at 03:56:33PM +0100, Lorenzo Stoakes wrote:
> On Thu, Jul 09, 2026 at 11:49:18AM -0400, Gregory Price wrote:
> >
> > Silly question:
> 
> There's no such thing :)
>

All my questions are silly.  That's my secret :]

> >
> >    What's the purpose of retaining tags in a non-address value?
> 
> Well if you want to reconstitute an address from it later then that'd be the
> intent, but I'm being hand wavey here for sure.
> 
> Main thing is to retain stuff under the page mask
> 

Right, which ... 

vvvvvv
> > That sounds like there's fragility just waiting to be broken.

If that's an actual issue, then our relationship with tags is painful :[

~Gregory
