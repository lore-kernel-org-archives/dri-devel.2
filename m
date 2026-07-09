Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CDDC44506
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CCA110F7CF;
	Fri, 10 Jul 2026 07:06:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="tYgIILkG";
	dkim-atps=neutral
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F2F110F62B
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 15:18:48 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-51c01089e8aso12004261cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783610327; x=1784215127; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D66HPeIJnm5ZDnK+VorUOpyiniaZPeUCt2fPIKMnyb4=;
 b=tYgIILkG5Rs3JedAvV3i9QlHmq5WVg2tL0ZPCK1WD/Ya5RXqzXMm+I2XH07PU2zrbI
 Q0i5n8W5+7Sfjk6p3hQOrAtHTpfNyXclXmZeASPYJC6Nu15jOF8reRs/4UFt9BVYN9eH
 2CnhMok/HG1NeP4i0rSid70kIpeBfi8ty8LGwfDglvhOOcdhukU0gFeEljxZ7j6NrmNl
 pZszTrQIGIBDvmYdfdxbim47RjXNSJoA51rCHq/mwfvJtqwbuZjrDlxmaH1Fo0CF3b/e
 EyPN3YIhwn5WmR/5eQxME1yf2XbHnpC8I9WyYKn1Cm9W2g5tzrOQbEff0tjLqFvI1Nvb
 FlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783610327; x=1784215127;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D66HPeIJnm5ZDnK+VorUOpyiniaZPeUCt2fPIKMnyb4=;
 b=QaXGJsTjaokGCuIWxW1Gj1oGD7rlZ4e60/Ls1P+mq93FTdhq02c8/bKLdJpQgsrn+O
 XCVB+sckUJBoVUWoxn6IjoLdtjO9HiAjZ2EjFO2BThgMMeTQhaP8qjKzkGeZCqh3+v3R
 CycTRU09B1fWv3AXC9VyD9seaaLdFTf47uXPDykVCNELt4Rph9fHe9kAPkrx9KEujHpT
 J6fdRkCVS2uALunBu9ljRyTvCQYn2Xwq4ME9x5px82w6mo5Efjs7G6o64w70zTH/yyN3
 gTECe1Bs00zbSDzzy08DtDoMdi2EELfQNhQEgXtwLrLSypxGNO2VgrnqJREqYZsqpjas
 2AZA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrx+A+eDF8y3COJTug7KKCbPRGozpdfzdNrQ/UUnXs9LsUJVO39kuU8RLmp6MT0FURDO2aiFY96Qaw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEJPUmDhl9xJiPqAuDrfWt2W2OklHIV36pXWT0U1pPQKfJdfF9
 YNz7KRL9blDMK0DndNBWyokV8tpPUO0XHXCT2jh0DySy6oDY+cHJ2c7fDw8/55fZa1Y=
X-Gm-Gg: AfdE7cmffkeTLx7FkwbYLwjUHSTLSRZ3UEya84lfbsy9kA6wopmL9n8Zn/VYYUoWbZs
 r1zLFI13j5h75g7TEo1zCboCICttG1qy0TIlHGBDwMxpje1o2I0ky8znI0NSXCy2sAM14bf/0BL
 g6DxHc3Dpr+WUzwYwtSMb8xIWo3chzQ2Fc8Yt2VPTp5wd3HgON5kRdwFkwFnOfalPUmp5MBaPdp
 YAhrR+sL303dmX0dBWg+3e38LyLhUoDLUpTyEeEg279jyb1tkktys/6+NnwvjeHSzSgZ1nMZ781
 rckc5ckFc7vTY6NcSyKDex7PSN3txK59nIVADGsWQTc/gnH1F28HRoIzvsVAYbeEvgf0pZh247l
 G/PpNoUGJc3SGd23qB+8UX9QZcDEVbS8FNRhYgPKP8k/0lBM2+1oT5kyS1tmw6FedUUm9fWT4SA
 F8Jbc7tvJksFOdcCOQLmX+pRmiiEgQwrEmVWZfh9zWyW3lJOwVsjhMB9jJwyEjK043T4MNT1r9M
 qjbhsY=
X-Received: by 2002:ac8:5cd4:0:b0:51c:1c2c:a8c9 with SMTP id
 d75a77b69052e-51c8b3e2e32mr79753441cf.43.1783610327278; 
 Thu, 09 Jul 2026 08:18:47 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41db4fb5sm158006781cf.25.2026.07.09.08.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 08:18:45 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:18:40 -0400
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
Subject: Re: [PATCH 13/30] mm/vma: refactor vmg_adjust_set_range() for clarity
Message-ID: <ak-70CHGujkI5jJI@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <ada7972f49ea7f1ff1df6d11e4651f270444f8fd.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada7972f49ea7f1ff1df6d11e4651f270444f8fd.1782735110.git.ljs@kernel.org>
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

On Mon, Jun 29, 2026 at 01:23:24PM +0100, Lorenzo Stoakes wrote:
> Add comments with ASCII diagrams to describe what we're doing, avoid
> dubious use of PHYS_PFN(), and use vma_start_pgoff().
> 
> The most complicated scenario represented here is vmg->__adjust_next_start
> - when this is set, vmg->[start, end] actually indicate the range to be
> retained, so take special care to describe this accurately.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

> +		/*
> +		 * vmg->start    vmg->end
> +		 * |             |
> +		 * v    merge    v
> +		 * <------------->
> +		 *         delta
> +		 *        <------>
> +		 * |------|----------------|
> +		 * | prev |    middle      |
> +		 * |------|----------------|
> +		 *        ^
> +		 *        |
> +		 *        middle->vm_start
> +		 */

Even with these diagrams, it's a bit difficult to understand what the
actual intent/result of this chunk is (but that may be a limitation of
me not spending enough time reading the surrounding code, not a comment
of your work here).

~Gregory

> +		/*
> +		 *                Originally:
> +		 *
> +		 *            vmg->start   vmg->end
> +		 *            |            |
> +		 *            v    merge   v
> +		 *            <------------>
> +		 *            .            .
> +		 * merge_existing_range() updates to:
> +		 *            .            .
> +		 * vmg->start vmg->end     .
> +		 * |          |            .
> +		 * v  retain  v            .
> +		 * <---------->            .
> +		 *             delta       .
> +		 *            <----->      .
> +		 * |----------------|------|
> +		 * |    middle      | next |
> +		 * |----------------|------|
> +		 *                  ^
> +		 *                  |
> +		 *                  next->vm_start
> +		 */
