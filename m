Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAA9C44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9BC010F42A;
	Thu,  9 Jul 2026 07:26:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="KxJvCM3y";
	dkim-atps=neutral
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B785410E514
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:26:05 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-8e9c9d63815so18124476d6.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783441564; x=1784046364; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Abd7yWEQE6Vuyzvr8uj66ic6dsI9yDvEtRp+r0f0v0Y=;
 b=KxJvCM3y6G1T9cbS3T0Fj1N+xif0jVQE6SHgKkS/BuxKOK8TuY3hupo7fvYI3YYWtc
 LQg0asay2rZsTWtjLFzfHyAJok37T9mMwGOrgXF5l17fP4mrP6JIYiSUKLQqiAm49Cvk
 esLi88oUrX1F5oB0vYFmvMvOA5fWfzQQBt1sm59uXfM+ARrRVECC05qphTVG2UQNPZM3
 6LGgwEwjqFSrabi3bgu2i05MzVst9QjLSeRm/WB9OCdkJWu+FGv3KmCWkCFnqSo9thmv
 IHJrah9uI03Tgzx81/K57M1O+QDRtRzO/vbQW3H/o7VfTCQ9etRotbFFRIaWDgfsRh2H
 wn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783441564; x=1784046364;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Abd7yWEQE6Vuyzvr8uj66ic6dsI9yDvEtRp+r0f0v0Y=;
 b=L8jvKnQOOqc6GXmp9kri/pZLWl4ljc1ZDEEjyh+pw9HqjFwqKkCDs6naG2TKMNkJgX
 mOXnVQ4HN+2ZOD9DUEMtORQ+zSLpZrsbae3JAfL5ci1Kpjoc49e+b2YUfLKbMvoyYSS2
 MVrCKP+ObVPnK3KAnICi+sJ6+juQ7B0YSVWkHJMi/TjJYddDcfhL0JQPFYLCWICbpc9b
 kDt4muPe0jErm54rtIpf3k1v+ZeLrwXnym1n6PqeMp5N1DN1uYuZKlxAWeXJkpux7Agt
 eoq0sg8rE6Bhr3wkFPLY/bf4txPzZt0dqTvfjiUes1po132EQ2dzp6XASNWNAnqybSK8
 iLkQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpxtPqCMNI1RnkyUFTjc2LKWCk+in2hsIM7v3pYsoqNRNlhdn+ujm2InEIWi8Hm0VOlXTuj9QYua7M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykkbYXwmbTFoh5cWQEjxI0IPZ8QbcdjeHazbEOSpBNM06u0w3G
 gpB+JrsqeOlRnCS8grFeMgUMsvRaXpOtHyY1Oy6M9npxOYUJ9OEB0tJ3tMHjc2Qpfyw=
X-Gm-Gg: AfdE7cnWNeJQv17Xt04SdlOkJ//1wx6k79IULQ5H6yKevai7Ywgb6NhilQaixg/zwuf
 92ApmH8pv6dtRGdQGoLnq5mBOk9Ni+vBYm+eg51j379/gl6awwGJj/wUzb61hRUOkAvCRQxAk+/
 ffWe/ZOIk2B3ocwRLa7Ltsqa2sJtVSqZRTfAUYKrxDv70qONB1txkaAZIp0wRGaCbb4lSFQv3Vc
 fIqS/GNpPDMMO7z3+FVzVHRqCxIi+ftEVy/AgLG4eDrwQ20a3gDlouBRBJlGJMcUw6xIVxQ6owM
 i6jOn2NHBmcC2lhuFiu+2GPJG4fmsbPfA1YUuzX7NfIYtmEyn93kRb3YshpJnMlt2h3TztAKOEH
 TiXK3qUb3Aj+fYLY5uiNQ2+++64nsRtsspZIt3qcgpVKXY0qOXuPW8n50mBUmA8aGaVURNVgly6
 xD9zJpQJrizUOCnwnLK8usvMJ5IyG3B9iBogDxL5FTGBtKxvNEer88/L2sDjCUr06yGbaRm00op
 0Pk414=
X-Received: by 2002:a05:6214:6011:b0:8fd:6de3:bbaa with SMTP id
 6a1803df08f44-8fd6de3be6emr28372996d6.64.1783441563961; 
 Tue, 07 Jul 2026 09:26:03 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f46f306123sm181382626d6.20.2026.07.07.09.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 09:26:03 -0700 (PDT)
Date: Tue, 7 Jul 2026 12:25:58 -0400
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
Subject: Re: [PATCH 11/30] mm/vma: introduce and use vmg_pages(), vmg_[start, 
 end]_pgoff()
Message-ID: <ak0olp9zA6ERCXtO@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <f7b4f8a611ab4d36eb3cf2e394610a3744a93895.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7b4f8a611ab4d36eb3cf2e394610a3744a93895.1782735110.git.ljs@kernel.org>
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

On Mon, Jun 29, 2026 at 01:23:22PM +0100, Lorenzo Stoakes wrote:
> In the VMA logic we often need to determine the number of pages in the
> specified merge range, as well as the start and end page offsets of that
> range.
> 
> Introduce and use helpers for these purposes.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>
