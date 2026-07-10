Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FCAC44506
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7719110E81F;
	Mon, 13 Jul 2026 07:11:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="dnz7eg3v";
	dkim-atps=neutral
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B24610E25C
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 21:04:10 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-8f0d6853360so11230716d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 14:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783717449; x=1784322249; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OhI7UcJVN9EaMSo9cM31eWAmb7Tf3pcvHFHtAkV4RLE=;
 b=dnz7eg3vUy/mdskOVRHjes1B9ixPObFs0IoXW8omuezRBvKiMDfeUNP6OeK0GKQBut
 gK4hs0bJep9AnOU/gItVpA9aQRqHIHDMQ7tIV671p2ndMRgUyitReQtMxm0ULc7rs3M5
 n4s/EgDfR56T5k+yx4vHsYu1GLj28MLKf8XzTn6a4wcg6tlqioNP1Mp4YFNIGp0gQJyw
 ZxT26DJm4D4pHrr/JyXLUwcqnLZeucvm6dUoM5rQCddNW0BeVk6aDoz+zYBYc/sGEQpW
 JnF419ds39YDg64B7QGf2wv9namlzEr5YWoscq906tFsZPK7hBPxCAaUfkmBx2C+BLHg
 x7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783717449; x=1784322249;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OhI7UcJVN9EaMSo9cM31eWAmb7Tf3pcvHFHtAkV4RLE=;
 b=PnLXxy13w/LS07d0sv3VtkvD3zyKE6vYmTASqCbQKXDvg5Wf72R32f7jbS63d4v0sM
 iemGucMNQGlv6VkHSMN3McgIRQh368YB/7Gp79Awy1KVpNoWhL9Jkj2oqv4yEWZ2A8O6
 SVeXko7dGBN/qUqtX0Ie0/Gj6gN5Wfe0RYNwavOx+Tl/dkMkaFkDYGFZ5Tr16zCxc7aa
 8HM/0/V5qJ0xtB1fVi6+i3rR/Unmem5PVKMNg9HVAjw8gNRUkXjL5aGjm0iVbplkvl7N
 wLGeF/x7jDyyRamGEE0g6YTlJLKjiMt86ZUfqW4sPRZAIJe5NIJi5tDjxrABwCirrXz5
 scrg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqlDoO55GKqHZXp9X0L4mWXDur0WAPTWbzrrFg5CeVn9Bl3ivymKGsh1gZacm1C+DAqg1pEKWs28P8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwTiRD3odSsV32uZbGJBApM0f9CgTkwg0VbCX/jPuhpBbQ7XQwZ
 jSOhGm5xw0e5E0pzP0jY7hf8TuhNKuBaIKqu+0itU31vUphP+hb6GDoDYEjqqOrkfIU=
X-Gm-Gg: AfdE7clo3K+xAbNQQWDduA/1kaXK7/fTSBHzTmcslJvyKZRaVnuS8sV/+F5ESvTMIN6
 OsPncklThoXiWbVF/HK1OKpRrGKaljmiep6wO1KTRkdrImb0s1Lqg2dBxcFDyCL6AW96afuK6oo
 lXx4kgdkxWUXUNweKauPrP7edaPzBZ7IlfWJlSlQ0FncSGDHQxAMsSy8XflK7WFQ/ur2uwyMvj6
 ++Ey8NQWfYvtsL0nh0LYaquomp/KJB8SS/Y0h9ePR8eYMyHG8XJjpKx11bvA2DFHMPTrw8Z7zY6
 hpr33gJwUqQkT0t0mY2D1bXjq65B8eZzewonLWbCmy3JH3J4XZnDqLogXT/rWX/uFsP96cjbui/
 ZLgJ3TDHPVSF3Ophptv5TpOPmIXkH3Q1HdKv4AXJr1TmgnJTrHQD52ZCCc3osBHeSDV1tLRu8cD
 gxC3GL6Bc0CScS/p+cYQb7zIBE/FfD+mO4XDI2+sUMTmsVWC1h6CSoOC03I5d+G3zkbfPV
X-Received: by 2002:a05:6214:3bc7:b0:8ea:10f8:ae87 with SMTP id
 6a1803df08f44-903fe450f77mr10485176d6.11.1783717444207; 
 Fri, 10 Jul 2026 14:04:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd50df5e2sm50655596d6.4.2026.07.10.14.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:04:03 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:03:58 -0400
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
Subject: Re: [PATCH 27/30] mm/vma: correct incorrect vma.h inclusion
Message-ID: <alFePgFUR52GgBS7@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <22d0f4e3fe11f6fd1312734e242d008267ad142c.1782735110.git.ljs@kernel.org>
 <alFHR3fg8K1-SITK@gourry-fedora-PF4VCD3F>
 <alFJUfaGHVnKd-Nb@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alFJUfaGHVnKd-Nb@lucifer>
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

On Fri, Jul 10, 2026 at 08:35:43PM +0100, Lorenzo Stoakes wrote:
> >
> > Do you actually need 3 copies of this comment or just one copy in
> > vma_internal.h?
> 
> I'd rather have it at a glance, it's a bit silly but C headers are silly :P
> 
> BTW you're kinda racing against time here as I'm on the verge of sending v2
> :P

:[ i don't refresh my inbox when i get hyperfocused and now i am sad
