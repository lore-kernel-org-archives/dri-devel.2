Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D2EC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13F5A10F795;
	Fri, 10 Jul 2026 07:06:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="GO+tXiDN";
	dkim-atps=neutral
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F81010F629
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 15:57:16 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-8ee88fce572so568026d6.1
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783612635; x=1784217435; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T5BtG8ZZnILhla7gs7f63UlRSUpFIkMkPS04TXxov0k=;
 b=GO+tXiDN98jRhLEmXK48a6HhkyY9s8BHm7z8g1N4M9zbnr4LKK6daVEVLB8feIqLN2
 q3r3TNh3Fe5XMqOUB/FGVvAwIQ1Rl1lpI6kCphDCH7eG1owzDzgtgcetwtgo/OUBS7tG
 d88MIIY0OMyAWmEU2JBJN8iynGiXgbKPskVS9bG7QEdkgHKppN802X0x6xc3Ec9RJN8N
 nObv2gz0aet16ndRDtsa0/icC0GYuizpXkgeyoUxhwF9SKmaQFtZ2cIYO8umNZ16xfvq
 tStq3HJgrt7IqTpz+tSnLYYXXFQcGqtG5IiJc6rlx1LOyCOLfNWfS45dddLUCNtcAsyy
 4L4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783612635; x=1784217435;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T5BtG8ZZnILhla7gs7f63UlRSUpFIkMkPS04TXxov0k=;
 b=HHVq8sozfDMr+YC50PHXpc4gkntpeq1L9mBi+MF2/I+xfxLVbyQlDVLzyaFX8DWtDT
 ZNftbeKLOwiZJLqmuj8G9/rnW+4Q0L5GDwSCVzyFHXv26eSjT/42vDc5Zx6xqOgfa0Bm
 eEoufLOKpABjoqE2ffUa7LoqrUOwThVrCknhdXMCjqvSAtRM2nkX5Z1ZDbGcB0fkqSCW
 /nuUKc27T9uj/lCcJh84Omqh3o/Hk3NNnecZizD3LoztfxGMiE1l+yKG36e348F+wYKU
 +vZJRYXqMSXesqJOnfGm3gkVos5CnJRmzo1q4yXIEYTzXED/9KvZxwrTfuHsb/wB/VZu
 HgvA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2zPjepJ9y2OU2DcpoCgtVHEe4g8WXfaWJBc7KWc4ZUCswwJJlr0U4/GkaxrEXHw81UsHQFRXmoA0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/3pXLRyN4L8Ne4Mz7HfK9dglB0YjieMt98b9bBh0MAkNb+aIq
 0GQcD8BFDtOcuzRQjN1RFxO0CwA63Y/q91c4Q3Ftq8emZTlF+L9wDQ2fm7J1Jw8AIUQ=
X-Gm-Gg: AfdE7cmeCFjBCIcwXS2JaEoHnyl3JNMYkh5SDAbsEX+4K5jiyTwsgrlYGgBxYXwrWq4
 QW5jfF2cc5N04BxRUI2B7QlwjgI9Fry8nWi7rUOxHcP0sp1pPMaw41jTi2NjnKx2tbWuBSEuouM
 Wno3CBy37PO7um3uLEI1fd7kp4d44mH9NMqTD2FGtGsFGTX2tDsao0Mq8mcDHdSoXrDEfkep/8x
 QpCXOcc+oICBS/dkjQL8iIX/z5eEdEPsruTsWiCWu15bR2PISkgjMXSLC3vG7C2GGCCCnpoLqGS
 elLbG7TnlwqxfyR4ANxDFczyaBz/gyRhtL1VZM1jBVzKYwNvC4KL0Z7Jaz0Y0h+BzrxSbuB9aY6
 2Ef1yuSrrFhESNvjZZL16UzQnesXhFlYLtrKWW7VD2KneaSWOsIBBAAMSK/D/UITXi1wpP+443+
 rDNz0bwRMq5RMQ+5la+F2v6/Qfif48OsmxMTT7BNpnVPD2QELa6K1R5UkKsUNb96ErOGivfRytl
 fQGrjE=
X-Received: by 2002:a05:6214:2aa6:b0:8f3:e0ce:6119 with SMTP id
 6a1803df08f44-8fec0ead52amr91789316d6.21.1783612635560; 
 Thu, 09 Jul 2026 08:57:15 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd86d43e2sm20317526d6.43.2026.07.09.08.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 08:57:15 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:57:09 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
 damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>
Subject: Re: [PATCH 19/30] mm: use linear_page_[index, delta]() consistently
Message-ID: <ak_E1Y-D2Twykusr@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <bf56e2e98b512962a2fb88900d535a0e9e6769d8.1782735110.git.ljs@kernel.org>
 <ak_EivwcDDdn1Xvp@gourry-fedora-PF4VCD3F>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak_EivwcDDdn1Xvp@gourry-fedora-PF4VCD3F>
X-Mailman-Approved-At: Fri, 10 Jul 2026 07:06:09 +0000
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

On Thu, Jul 09, 2026 at 11:55:54AM -0400, Gregory Price wrote:
> > @@ -2462,7 +2463,7 @@ static int comedi_vm_access(struct vm_area_struct *vma, unsigned long addr,
> >  {
> >  	struct comedi_buf_map *bm = vma->vm_private_data;
> >  	unsigned long offset =
> > -	    addr - vma->vm_start + (vma->vm_pgoff << PAGE_SHIFT);
> > +	    addr - vma->vm_start + (vma_start_pgoff(vma) << PAGE_SHIFT);
> >  
> 
> Obviously correct, but was this intended for a different patch?
> 
> ~Gregory

bleh already caught, sorry for the noise :]
