Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965C1C44509
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81AAC10E7CF;
	Mon, 13 Jul 2026 07:10:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="q3INDviQ";
	dkim-atps=neutral
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B55910E1AA
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 19:05:34 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-8ff88549786so12448276d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783710333; x=1784315133; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5Cb4T8zzpAMOVzwqCT+1eDu/jZ6x8Q2fk7Pyrqw1u7c=;
 b=q3INDviQS9qNED3dgdAJX8YhF7EPKsi9ZuFQX7UzKGL645AelVAj1iS+HSnLucIowV
 Gsr37dMIuo6RrTK7UFsqp1Pkm1X3eyt9OSgVKJN8n7e2cQBwFvBeXYu7j6FbBB0yo5K1
 RfCg46hjeHiQuwl/H6zXSAo6oA5nGU34ryIxbrrU381R8QaxL++aZ1L9f6Zp/9fU1Zja
 JpPYE8SVTi8qtbSzT2vkKEqRoMVwU9eQrb18GTYhzFNqOIUIHKXimK9jA9dyzur3uTRm
 yRwiQkwmt5+Jkyba6eUYnio2AjLm73R1UdnvxQYZpNgJgcG1F+uQ50QdAUjJRKJk9fAx
 cHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783710333; x=1784315133;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5Cb4T8zzpAMOVzwqCT+1eDu/jZ6x8Q2fk7Pyrqw1u7c=;
 b=SrQ4+swVvFsotGrORVjEjMZ8i1+u4UxbJAKFql6kfRvon2n1PkT8bD2cJ8Tuwcw5V2
 5elVTrB6TqgSTKApBF6riVbbWI2ICAw0ejSV7AZ83FMpLGm2lIBQ1rqy4YHk5p5A+Y20
 J1KKVBDNIP8s2yE9naC7UJKLE/OrklJfCtW/eP4thO0mZCILai4mxFnUPs9fsySMp5Xv
 AE51SGB5jBhOn+PnkDvPOJK09VheycOJZ4FEA0mDMi6JYriyDw5z17Lm6kxybRIFem12
 S/7vMETJ3RT+i20gjXYiG+fBPMMP7sqse2qwNnLroIzS/onl2lsqSSEsI9Jrirr+5faL
 yRiw==
X-Forwarded-Encrypted: i=1;
 AHgh+RovT324vvOG+4MZ73qdc5jXN6fQH99K3QZjbaoTyUiePUeYk1N6JVpGkmf2S068hmSZchK2MUuTmWI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx39+hVIWLxTMbaRj8+salFYmm/YzNEdyGYRdHP6+u24PPlfnPY
 iypCiIqR23YX6K3ApOnKLyWmAAs6QKLpN9hWr4kZbrueLTn7X1kZ5jwZerUW/E+yLjo=
X-Gm-Gg: AfdE7cn+L6IaCHuRBG+BDsmdpXbHeOE9/e1wkwdC6d+zgwuhwSGIAhc+1aIeSSthkAI
 rG8jSUHb1pnRIaOfIEdo4p1KG70YPJm52e1gmpXmHhhgzz/6LrZM8ydsVjcmIu18Qr9gRQex6+D
 dGmRWTSEfIrYnrQJzP1aaynJHJebty1Akh+z2SSuBd9lqnout0tvtYUk2Lys7usrwvO2OiVlIkE
 G+EByTgYgmdRdvRILVTYWUaN1/KSTnrA6ZdlZ273EWemv9SBwVudfZhl5I0XjjeD8NmXWzG1Ntj
 Winh4/OGgr2qNkddSDWseiENJy+t13lYrBjZVhK1vT5QEkxUuRYs+17Ew1dqmoSdMn5D+qBaADM
 dYRaS6eihafZqLi1nQUYrqzEn4L1/pTf2C7HT9xKanB3r62gRufKTOoUZjVVfITA/GLDUFSxA5a
 8Ky4GXrt7bWqSc+K8OjEoDihoR+an2JY/iGO18ICBbX6q8NnBsZq3BUFlxjS0GBTZQIPNr
X-Received: by 2002:a05:6214:33c5:b0:8f0:65c7:315d with SMTP id
 6a1803df08f44-903ff971194mr4994756d6.24.1783710333250; 
 Fri, 10 Jul 2026 12:05:33 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd80fe009sm47940576d6.38.2026.07.10.12.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 12:05:32 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:05:27 -0400
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
Subject: Re: [PATCH 20/30] mm/vma: introduce vma_assert_can_modify()
Message-ID: <alFCd1RtttwxKBLc@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <23c7602c58cacc23ef22618a27af9a2d54addf58.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23c7602c58cacc23ef22618a27af9a2d54addf58.1782735110.git.ljs@kernel.org>
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

On Mon, Jun 29, 2026 at 01:23:31PM +0100, Lorenzo Stoakes wrote:
> vma_assert_write_locked() and vma_assert_attached() are useful for their
> own purposes, however VMA code absolutely does allow the modification of
> non-write locked VMAs if they are at that point detached (i.e. unreachable
> from anywhere).
> 

curiosity: I presume this happens mostly during init and/or teardown of
a vma?

> It's therefore useful to be able to assert that a VMA is either
> detached (modification doesn't matter) or write locked (you're explicitly
> locked for modification).
> 
> Therefore introduce vma_assert_can_modify() for this purpose.
> 
> While we're here, make vma_is_attached() available generally - if
> !CONFIG_PER_VMA_LOCKS, then there's no sense in which a VMA is
> detached (vma_mark_detached() is a noop), so have this default to true in
> this case.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

