Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94735C43602
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73D2B10E17D;
	Tue, 30 Jun 2026 07:19:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="RGgM2oZ5";
	dkim-atps=neutral
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com
 [209.85.161.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F4C210E970
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 15:31:18 +0000 (UTC)
Received: by mail-oo1-f45.google.com with SMTP id
 006d021491bc7-6a145935764so1133605eaf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1782747077; x=1783351877; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TtnRVAeDbe2jCD/DHkmGFKsvQqrt7nLFRBhYCay7qN4=;
 b=RGgM2oZ53Cwth63dLhiox+LwmvKnu1e23gdCZIZk26aIaFA5bYBzzHLz9WhWOvBwrq
 CGpxL6IjXazz5uVz+WpUn1iCE5bAOSsQqpJU37i0ogIi+H1PFjiTomR3JmJimsVmkzb+
 RAreh7GulhdxgKNQzwaAHy8O+UXiSI9oWHbYYRrNa/c3R4t3KQM/e7eHFkUF4wZH/cx7
 wFT6sxcK1A0y/tsh9nH0BJmNQ6Do4oZVkkKQf3LVcF31lNE2z+6sclgDKYjVxSx4XEQp
 zgzqecN2c8Gzpe2iTFNynCdt8UBw+f8+b/DpoAQ87Bsr7ncpVBL/AQ44NIJPkdM2Bsws
 M6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782747077; x=1783351877;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TtnRVAeDbe2jCD/DHkmGFKsvQqrt7nLFRBhYCay7qN4=;
 b=mvfl06NdIt3H3Mv9U9W7/GjuZR5t3Kew6HfdBSadIKXB66cxaz+ywaB8REAQq2TAnI
 Wlj7WPoMjvikiboSdWAtUteKACWy5k6iDEpEN25DE0OgdN8WMzQCHqH+Gq3ois/z1Vs9
 O2dgPfV2hJv1giOm2BnE5MIyUBZLSk1d1bX874i68aFYCHttTFiGrDsFqVoi6ddUMryP
 kFFJ9x7jubETL4hyk9RmfZiGMrq/fMjMh8PEdBPX3TSG+CsZoFOiHMSyHqMxhPG1UBiT
 CAycwVwD58D3FhNlNC4Rw95WKP/GqJrLVtnp4rUTrd0MxaijE3FYHcZVfa6+uAaEd8DD
 p+zQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8SSkvZkgAwF8W2UR1mYylk5JMW9/OB/SIOKFtbsmlYPHyKLyYa951kIGgfYuDwtf5jyR8fJJL3sAU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwpSAfj2dPMsKeezHYb0Y/hFHdEKI/gWz2RGkRjwFzz8qJSmRRz
 l5YQFuCoMbqdG5pYlusRzpSASlMFLeuDBuDZYopvVvtgH7wrUoPOskrXP35GOnNYCq8=
X-Gm-Gg: AfdE7ckEAGzEs7bsmjNxUtiTN24TuzF4zBMSpF1vV1UF1cFuPq/tsMcMxV16UTWZNNV
 KIh580saoxNtzsR9E7sS0ZB6tUVFnjPPZendCaHMmZG1DlapQriBczaHztQyKA79nZVFGiNuNRa
 M5EGFDwFEV53Sd70/KtSxkVgwIfwvXb+ErhQmciHvgcjJGjJIxstv0x0LToOEiAJQFmLH2cxbwf
 Lowrr8UF+IWTe78HL+jWfhfnwmumJKRx/XFaRK8pdn/oBCW3DhK5NEutjs4Qgjw4QA9N3jH1mjl
 WBTDpuRcC04Z7WaIb4otElkjobAQ5QOTH9H7c3ueSI9pqulNd9BLIROIXnE8Z+RJCCiKFupY18G
 k00uW+UyjhLWnoMrrCFxMhii01TMt3MQa9M3bxURuwgPYN++gZ04M6MP2uxGMBOysEv74dRm7Q+
 26l8Y0X0kjSxnqvRp3a9SWkANiPUEnfv4uCmbAKdiUy1iAJ675OJNYWUQY6vk8VrfhOP+PSbZKv
 XA32R8=
X-Received: by 2002:a4a:e914:0:b0:6a1:524b:1f5 with SMTP id
 006d021491bc7-6a1891b6f09mr98038eaf.42.1782747077395; 
 Mon, 29 Jun 2026 08:31:17 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e6213b95esm9184285a.5.2026.06.29.08.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 08:31:16 -0700 (PDT)
Date: Mon, 29 Jun 2026 11:31:11 -0400
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
Subject: Re: [PATCH 02/30] mm: add kdoc comments for vma_start/last_pgoff()
Message-ID: <akKPvwYs-4TwYwKO@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <8c618dfd7de419e3b797b8bd1cd921d4c5b8878b.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c618dfd7de419e3b797b8bd1cd921d4c5b8878b.1782735110.git.ljs@kernel.org>
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

On Mon, Jun 29, 2026 at 01:23:13PM +0100, Lorenzo Stoakes wrote:
> Describe what vma_start_pgoff() and vma_last_pgoff() actually provide in
> detail.
> 
> This is in order that we can differentiate this between functions that will
> be added in a subsequent patch which provide a different page offset.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

