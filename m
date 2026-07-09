Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2781C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45ED410F7BA;
	Fri, 10 Jul 2026 07:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="TFPRoZUK";
	dkim-atps=neutral
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F21C910F629
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 15:20:52 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-92e65e18969so79762885a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783610452; x=1784215252; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3aG5hxu0JYH7EcM/cq6JX5Yef1RoVI9XARU/q8dKmL4=;
 b=TFPRoZUKYAM0HzMJu/naXJymaCurUpVY6Ib1aLpqC9dp8mQGHrFfhW+T1qjksfnrCH
 gfOk+ssIeJbjldGrZ8Q5fAuhoT8WWbZSb0ppNi+h/05WQ5hVWTy3/2hJQDmhoLKcgpG4
 Vrmk0CrwYd0kdIzG8Lit9XHv8LTI/w9alMq4JVIKeM+lWJaT6MIZ++LIBesx6e4qJB1B
 dx/Ihh+eGS2/Lsla6dJ1Re2VlOneoBLPo2Ir5S2jjpeAd79c7mwTCRDpQgS5o1O5Zhp4
 YHC4/EHoBRDAMcKbzU55/Is3fdxyLnUngjecHKFO1v2icVd8jWGa1w+J3w0THNHL52Ei
 S21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783610452; x=1784215252;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3aG5hxu0JYH7EcM/cq6JX5Yef1RoVI9XARU/q8dKmL4=;
 b=NafS4lTw/U+vXBNVF2YpU9OfUMyO3v/6BPrgz5KAdLqpagnIn0b0BsleKEwYQDa6X0
 R6KKkWRtrDcehrxzFCT5VmWwfzIKTBRHjMWFiKhwL5fqJ/JbtK9i2x351+pOzWElCcI1
 qBR0c5jrEKuLLiO4Ce1HscJp3gNZheaXrIs5xFzyIPCj58GJnDdTxFFTNpqWuNRozzs6
 JSeabl1sgfHvb7KWOupxuevj8BU5lLbTUo+c0OHZn71dDK/NWXxTgGGKT2t6eZ1TmxLO
 hKGcqjVJScm9mqJBacHk4Y6U+5Rxxlx/C+UzqP3VfmTldZlPrYt71PlOR7kuKu+AwXZY
 xLtg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrfBgg7x/a0/Qv1ZHHFgcmKwbPrrG4sp7A+Yrpb/qFjVTRL93izlD0jg6onM6UCooKDSaFV4LMEcYY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGCB4PKWRjlWp6rtXYV1qo8+2cduFsgL6ybA7xuQxlVCcMZ/DD
 dfm2Gsc54s/bsHiE8hEZTWX94m6gmc0arOEj4XtyQ8QA/OitVybfNH9mhN5CU/xINY0=
X-Gm-Gg: AfdE7ckeKj61CMHeh2+4hceNK+5CjCf9B+mYm8puK2O+nlIEoNPEpHuxcc5KTL9lFhT
 7XEcNqsqFngaCe7yhsYEKl5OmF3Smle1WU1EZFf57EJ6bS8X0jQ1YrhbCVLxvf3YhA3Z9voUQ8Z
 b+dDCMWn83hTuh/fllG1BIX0TfYTklI73uU65TYCKavURsyeYjmKbqPHTPoxQpK14bCUX/tyxNS
 1P3gHPzT6dIQhes5ZMjN/J58jhystgmOpLYa7jsmySRvTGU7MkUNmwTZJtVsb5+DIr8zlw1XXz6
 2SDiva+otK4t9NLATlWR6dVQTVXF8esoz93A2j/CsuRZM+qfandFkg52CSzplWFiFQWN3cJ3x24
 JLkbVl7ILrfTHCtyLnjfoHB7K2+4kGo3N7KPEjvcyf1idz+rJgewj2vi3JqPpNUWBSQEz+gOEbA
 rq9+/pXuD6E4/clxxCeESjFaUC83z9seinhR3dY3CXtHKPLUQLcmw6KPg5Douy0txJHXu0
X-Received: by 2002:a05:620a:179e:b0:92a:f74f:904 with SMTP id
 af79cd13be357-92edab23ef2mr337298385a.1.1783610451142; 
 Thu, 09 Jul 2026 08:20:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90ca90a5sm1652288685a.32.2026.07.09.08.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 08:20:49 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:20:44 -0400
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
Subject: Re: [PATCH 14/30] mm/vma: minor cleanup of expand_[upwards,
 downwards]()
Message-ID: <ak-8TKDC1GBOeMOM@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <b24f70b72f0a9e2a37b904e5b59d80b88bd42e4a.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b24f70b72f0a9e2a37b904e5b59d80b88bd42e4a.1782735110.git.ljs@kernel.org>
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

On Mon, Jun 29, 2026 at 01:23:25PM +0100, Lorenzo Stoakes wrote:
> Adjust the stack expansion functions expand_upwards() and
> expand_downwards() such that they are expressed in terms of named constant
> values, and make use of vma_start_pgoff().
> 
> This clearly documents that we are referencing the page offset of the start
> of the VMA.
> 
> Additionally this cleans up the overflow check in expand_upwards().
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

