Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2732C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F259310EB3D;
	Tue, 30 Jun 2026 07:19:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="a8voR6Ld";
	dkim-atps=neutral
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA02410E978
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 15:40:20 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-519ff1c8b8bso41920471cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1782747619; x=1783352419; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VwgemlAWVZOfyfvrJ+7cyHmQGRLai3JgFnH6EFj5//k=;
 b=a8voR6LdSKl9hghp/HvVf7dTLlEroxjunEQDf+Pzon8+E29S5WVLN6aaQd6SOFLHJB
 AdAkm/ig3itONVKBi7Oov3Nx1p/D/dcOG9rhe4HoE39B+fAaMPuFBn/epxZXPHugtGAE
 u+50V1w6yyyM3UXP2lg50pAkYR/T0n6NnRflmmOVc1dxkMENxjD0EZPgdJGzUmTWEz8I
 LiKAYaudkgOsLDwCNA3nhyYGrW5G1LC8tjOhMq1xKtO3JnL8zgdQt6u2TjEGt92DKCUn
 ZKIaCeSmPyOBCy47SVmFILNEAzduY6GH5ZKSFbQ1j6/yYruHfi+ZkNL21Y6fA6DYyK5U
 WOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782747619; x=1783352419;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VwgemlAWVZOfyfvrJ+7cyHmQGRLai3JgFnH6EFj5//k=;
 b=J+kG4pKz42/YdJJVz002C9yKCExtx0PCf27l2h3xu/Mg+2RIeSXsBl24wma3Vulg1r
 IbyJswq28A6gXZ+GHTW1WfwiOc61TFI44vn2O5V6ZPUZ/pNsiTL7BRY9DMagfuWQHOJm
 KJ5sANRALvDJrZ5eJ+6C6SkouFKKK+EgQfu83WLmckoeoF/bm0LJZc3Tfm/uNfUs8aAu
 DkLmG6icf1VG8gX8KK6fdSIqDMRUjZ6WH2nf2D3ohMu5XQTLORZ+fkE7nDPPgyed2272
 7psSDD4d/n5e1Web5Pjq/3FOTe8rNV6cEk8eNUy1lRS4GBt03OdK7VQ7Pf1rtVb4rWdH
 Ey7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9d8nkujOKMgIHpwxs6fHPCOkC7rCODohmhrRDSjosvICSTXRUbyRDsaWLx/JXAZ2E5bR2Awg73SGU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHDL19PSXJPjIjRd82M6SQiEd1iMgu0/+fs6GvyC4f7Bvfk4Af
 Q5zGfjYkrQMNDg2hu+4KYPVekbndV9WZD/Tval54DlfTXQqMBK+y5QKk26u1cyo8530=
X-Gm-Gg: AfdE7cn3DPD105cBUGlp21SK4SoVrxu9YdclEAbhUUSnVLIasXYPwQU0THb7tkxG/5l
 Ny2/G6miyIaAT5SVBi0wALLj3fiYQkyz9ntsT/QPiMycG39o/rLMz+u6vCauYI0Wb1wEDqigcab
 e0wpxwju5aKGNpAtPqakC/bS9rugt5HiK3vNMGpTV4hYhsQa7hZmvo+wN2rw+CkAet7Q7gCCr7R
 N+n92GYwU5r6Z6D/mgaGvu1o6eI0Phe4e5YBA/vg26CdwRfmi/Xmc2YHwQ74ulOUZplth5h9JjX
 r0EutslsE7o129jM7QZhkSDBSInFb9pLoDjrcinRRJB31xn2GQYAm/tH4nwtV880/XyoX3sZU5U
 koyq2SkgFP/+qjXetiJU9CVVJAFHeDP8TJreTUjfpxLME9tFlAnmkD6TLy6YkXEDQosgst1rTfD
 4pVWM4AXfovwprHDZ2djaJ6Aci9o27xhPfGy3G3TE1vDcSJpTV2OGOKXwvBiA7GHkACp2Y
X-Received: by 2002:a05:622a:5987:b0:51b:f635:9aa1 with SMTP id
 d75a77b69052e-51bf6359eadmr68650541cf.48.1782747619393; 
 Mon, 29 Jun 2026 08:40:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a876c888bsm78114501cf.9.2026.06.29.08.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 08:40:18 -0700 (PDT)
Date: Mon, 29 Jun 2026 11:40:13 -0400
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
Subject: Re: [PATCH 03/30] tools/testing/vma: use vma_start_pgoff() in merge
 tests
Message-ID: <akKR3bFV7393yOUs@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <b501eca378b9d9734e83838102aadc9276590fba.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b501eca378b9d9734e83838102aadc9276590fba.1782735110.git.ljs@kernel.org>
X-Mailman-Approved-At: Tue, 30 Jun 2026 07:19:13 +0000
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

On Mon, Jun 29, 2026 at 01:23:14PM +0100, Lorenzo Stoakes wrote:
> Now we have the vma_start_pgoff() helper, update the merge tests to make
> use of it for consistency.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Question: Should we have primitive tests for vma_*_pgoff() since
the behavior changes depending on file/anon?

Nice to have the cleanup and clarity. Maybe worth asserting no
one ever breaks this.

for this patch though

Reviewed-by: Gregory Price <gourry@gourry.net>
