Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782A9C44508
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 034DD10E7D4;
	Mon, 13 Jul 2026 07:10:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="VycPZnAf";
	dkim-atps=neutral
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4003810E1EC
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 19:38:47 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-8f29ec73064so9233456d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 12:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783712326; x=1784317126; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=68XwZpqFqsaLFsxYJLdxs3+k1PzHke/kGWmUPy80R6g=;
 b=VycPZnAf6+TwOMKfxNh2idpKpGmDFe2O8V9NFFwsEj4meb5akpJg6JtR5+oxJon6gr
 3msSWQbVjW2CBNRqP9vyIKy/owQMYdOiE0Tz2Gxnjs209iUu4o58SgFG6kz8IzNcRugd
 Ch2z9uPZfqpedKHqHNrj5UwHQTHzlBjf5gB19jgR3iPyrWI0rvqHjyl6gIe0fzzMgfsl
 qW3ocSFAo2ydgSRqMm02R6rrud8+ooywKupI6q6Od+THO6fAdnb1kZtxBmDrMKvZ03mB
 G9JLgrh6wj1MdaIO297XCUzqa3dvbiP70wxqWZ6QsswO6Leg1Rr1y3e2wqR6JJhFoiUg
 YYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783712326; x=1784317126;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=68XwZpqFqsaLFsxYJLdxs3+k1PzHke/kGWmUPy80R6g=;
 b=S6RCkHsULG6zHAAFDow3ze1X1TFZlyoi+QxcFsyiSqpDV2hLMAM8X+Ud4UOTYk6TU6
 dNPQi5v40ZsBBnPRlF+WkjDY0r5riFc1iAxORIdYG/gZ7Q9exsseKseXLQe7MIvDtdu9
 5NI9Hd5lkGjAmVHAnTrUkD/spaFEjcjSWcNUEb9bJeDECWDYbUgaoGpXc57HIwkoFZjQ
 jc8VB85CvzPxape+3mgKBUpAMaXXEVzd5AhBQbqZwum/3ucMdcnCHCrbyRk59WDTKuNW
 /eGyGcGc2+2N1LxxvPq2ulzx7SQ37SzB5g5VEe2bxNb6LXhzMyjE4RM8kz/vYgSRcwYt
 T/MQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp0jHjFJZKi9Rue6LV6W3c3h4Wg8JlXZoX8npxaJZrHdNH0AYucfmtYAX6VxBI524MffLYB+H1oODo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyR70mrFqJzRXt1BUmgQRHIcZEigotWcYk98MZMPxy058Qyi5FQ
 GndPyb6kaONvHn/+CgkH4F2CVURaqtfeVlUNCo1zdapFbj3abgEeDGJ1FZ6YXkKte70=
X-Gm-Gg: AfdE7cnijytBDKNrJDMA8z4O2QnCv0zByqns0B1gtVkfEm26E0ifkX6tU0QqGnbvMgj
 etWVE63aLdkmRubG8CvTEoEZhzLdCNvAuIPCje869Ikqu1U1WdoBsrrzzfslqBhFLfv+mSS7zhg
 Cu9bgGX4lO3tqbr0iGyhLu72I/X2sTGiu6VESYy9va9m0xtLDeIsABWDpeKgJhrvg8KwyxRYuZx
 VcRFNeqSyesW3GcmckZ8wP7GbGemn7iYExijTiTLm4o+F3oPpTiMtfLmiD7AyYirPhE02SjHRcb
 YnA8VwSgvUkkwAUKPqyU8khktaomHQ+DVoLTCoSQBbLMFpsF/6zpwFqzhZp0DUroRXyHPZLvnXB
 TctcxUkzeyGwrfr3HxAV4CD8NRtTxuHJx42PN8NuY8TlbCQXu05DO2XrUp7nQVTG3ERdGQWuMdP
 H6f0ZCZ9DQFLnKB76hLDKuEiTFXmXXUDEII3b4cR04OGPRlAmwwHotma5qBXUEYoFjiKX2
X-Received: by 2002:a05:6214:4b08:b0:8dd:fde8:68c7 with SMTP id
 6a1803df08f44-90402c685c0mr4983166d6.30.1783712326120; 
 Fri, 10 Jul 2026 12:38:46 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd87c9500sm48486486d6.46.2026.07.10.12.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 12:38:45 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:38:40 -0400
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
Subject: Re: [PATCH 28/30] mm/vma: use guard clauses in
 can_vma_merge_[before, after]()
Message-ID: <alFKQOJrgiJl0p_t@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <213918ef85ed427d29d0635db6b07b15280d3bb0.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <213918ef85ed427d29d0635db6b07b15280d3bb0.1782735110.git.ljs@kernel.org>
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

On Mon, Jun 29, 2026 at 01:23:39PM +0100, Lorenzo Stoakes wrote:
> Rather than combining a bunch of conditionals in a single expression,
> simplify by inverting the mergeability requirements into guard clauses.
> 
> that is - instead of checking what must be true for the conditions to be
> met, instead check the inverse of the requirements and return false if any
> are true, defaulting to true.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

