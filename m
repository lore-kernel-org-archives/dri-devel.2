Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22578C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0E9810E7A9;
	Mon, 13 Jul 2026 07:10:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="cn70gW5+";
	dkim-atps=neutral
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com
 [209.85.217.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0199E10E21D
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 19:02:04 +0000 (UTC)
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-738cdd667ceso370742137.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 12:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783710124; x=1784314924; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pC/3U7Ftz6dY/QSNTLtw6DNyhuKVUlnEMcNANT8zsUU=;
 b=cn70gW5+XpzWUE4ia4uKPcV/TfjoBcNHJagisXuEyfO6MHdS5SwdNvNoVW2KCRgKcE
 Cp0CUMYiFnwNkQKWskZ+a17JSC2zSek5rq6tJNCaGoEUWNB7PLll+GFJkJO9SHtCuPKP
 aOz1dCqKHYzbeU0OzpCnvfEPYm7urpEcE+pgHC7Zp2RMTZ7wrjd7r/uMhGBi7ZVxPlbT
 mJE2/loj0+nLcPUOMpViW5sH0mQdRR33UwfId5qUrX4Fn3hy4DL2BMoa7n9cUA+v0Dbp
 ZkkqRGzdZQPctMuboJ27yUd6pK3SYCPMAlxSi470XKsVErh5yv7rZDJR8uDohTqJsbp/
 6stA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783710124; x=1784314924;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pC/3U7Ftz6dY/QSNTLtw6DNyhuKVUlnEMcNANT8zsUU=;
 b=IP5CFpibpLEMsgq6giLEE8Mua1SJFT7+3n1LrNXURvBeSM9SwViTRC/2x86TyNfAxE
 WaxDVizx+C/yRB1tYxkxnsLnvnI73k5WFWGk7qSEIpQ/Ts+5pFw2cJVeXRyW7yS3VkZy
 i998Wvna8BEb+4HDnGC4JgbROFwDDUiqGYZchgcZyHafLYzg8G2uao/g4rrVrk3l0KE0
 WheFN2ZAvmPbib5k1hFdYPLuXhtStrdnmLWaFgSGHxZkU+tQVyUGv9aqCFDtL0/SFe2q
 RX1ON2/l5HIbKZhmGFe1HZ9BiiGjWPTINwQgh4FTSblctWKV65QlUsXBdu/m1Z7h6/Db
 kBvw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqgTx1eab4YwbwmKNc5WFp/2LO6voEQj1LiRkMPiO61mhiPl9+r3Jwbg0scjbb+01ry7OmRpDVFLw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZTgWmx39nvFFiEcq+3l6uYMo5haeFjD8sqNiHknB6ypRA3j4q
 QWOKOwfLYaF5oV8u3fSoLtKqT4zwVgUV7r74OW4Na5lLWz8HBWsnTH5LcqdCdvzCLrQ=
X-Gm-Gg: AfdE7ckJXYwODZRrSIlsBmjTfLgehYHd475NrqshYeldtETtMPIxAnyFAELFXX1eTJo
 DOvs3DLem6RI9UQCpUKVuJaQ8cKD8vyL5SoDmYkZkj0VIljJmXDeUUKbO7URkpRyEARoD6ecKKl
 1Nso13uYJeEYEYLGwcGztWTUY7dSdTqnmvRj7/mLxSrArkjnLyt9WFilNkgo8MSiSCsNSlxf0e0
 9rhZ+rDExHuuxu65LT84rO+MHszkuOELjeESeVczilmuIMkSxJq9BWPPa/3+rLY3YSf+TsaPJlY
 5WKEts7FvVOkQhm4WyT8X63NeLGK1+AYonOAQO8sUATcXKr0hGdEZxH6cNj6Qb64+wqkyTEGqMp
 921JvZOsQcO3sso02JbP+Ma8bf095xEvQgt0yEoQSPpVuvSwp6QdxacdOdI0U59MPAq1xRTeedR
 osivS4s7FpcLRXZAovhbnhdNwXiYEmLIdJS6THxSqMyf7WQoZARQhwVt7PD7Hoj280K7da
X-Received: by 2002:a05:6102:689c:b0:739:5f55:3c3c with SMTP id
 ada2fe7eead31-74533d66217mr325833137.13.1783710114831; 
 Fri, 10 Jul 2026 12:01:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd56c4b91sm48074036d6.19.2026.07.10.12.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 12:01:54 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:01:49 -0400
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
Subject: Re: [PATCH 21/30] mm/vma: add and use vma_[add/sub]_pgoff()
Message-ID: <alFBnZ8RcRN1hlk5@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <794044881e454fd8ac13e59d5ff5fc86fca08b03.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <794044881e454fd8ac13e59d5ff5fc86fca08b03.1782735110.git.ljs@kernel.org>
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

On Mon, Jun 29, 2026 at 01:23:32PM +0100, Lorenzo Stoakes wrote:
> Add helpers for adding or subtracting to a VMA's page offset, exposed
> internally for VMA users within mm in mm/vma.h.
> 
> This is to lay the foundations for tracking anonymous page offset for
> MAP_PRIVATE file-backed mappings, where adding and subtracting from this
> value must be reflected in both the file and anonymous offsets.
> 
> These are used on VMA split and downward stack expansion.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

