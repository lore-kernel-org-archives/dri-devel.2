Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C51C44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB48A10E7D1;
	Mon, 13 Jul 2026 07:10:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="OQMYEgBq";
	dkim-atps=neutral
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D5BA10E1AA
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 19:26:06 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-920f33347f5so69157185a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 12:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783711565; x=1784316365; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aHwFumUUjp1dZn3azv3jRxV2z4/4b2Y11BxxEMyANyA=;
 b=OQMYEgBqHvO2WECTl0J5e+vTBuCDA0y/oF3GJX0CiqjnPyIVP+8IEZx5gEn1XQQJL+
 dg4KceYzmfJbjId6VdcSIPkn+PtgkXWO25TPP4r+yDIE9NgXrqpoX5Sr2/0ytKp6G7GA
 Jno6V7SVqzACFmUm3sK0AwNcXarS996sZ6+0v4arkk/xVg4BO/Yf29A+MxfkmENumHK4
 80wK0Nv0Reb29B9NVsTjcPS9ng/asuLakv20eOo96PFcsOkLKrKdic0rh87jH6lDhn7s
 fma50f0HEBvT0wfFViTRjuQaRFQgk+pO2GSUzqpGz7SJ/7Od4x11vFCoEzHAU6jsJ3zk
 aY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783711565; x=1784316365;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aHwFumUUjp1dZn3azv3jRxV2z4/4b2Y11BxxEMyANyA=;
 b=szfRE+yq2IB0+PKD26N+gfMJHajq0Pc28r3V+M8i+sgUv/pyBqn6DqzNrxSCcAKBVF
 WO+TGqqjkk/pO2D16QqTYXuD6RH176Z3HJpWLvHclIH1ksa/0upUUwicc++GX4QS5FCd
 ymLi9ffzl3OOfHJzQhtnxpkHBbySi1xP87WOlr8P+WFBjadqds7dsBmWxcrVA00AXLbO
 N3b1tWFlfRoaumGC5FFf7MiFBbIFvwuqrzgcSjOsx4GNr3EhaXRAGNFaJe2k9ecv5LKZ
 HIJdcxutfhqX3fHb6FzdZLcF79jlYkI1Ov9/s4IV55+XaN3R0F/IuHX+daBm3PspKLu+
 GOBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFxNH8n0Y1G9M/5fXHOJTpb7gCuC3WwVcqLE5L/HR+u7IxVso6bdglDKwl/099szcTFyCZWw7QpMU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyxg1XtmLWzkR/hR09g+m4ws64tw0VuQHkQzCSxHfAuZBXUtp2+
 kihKk4RxfFz8NeREVHGu9hb+nycY7iNcCn6WEGtPwvWXq8Rxl2ZmUa6KLV0YP8kw0kA=
X-Gm-Gg: AfdE7cnSeK2JZvfM8EeXZvpRh/3YBay7xKrJ5+BEEoTd9xIsd0rRze5ywGQqssEuPFq
 N1r5dx2VeSK+6zKHeqxmGxfUQ4X8I5i2KJ8Y3pBXy+SqcvvUXmP1xY4Y6C/Mv2vMujCnxdS0/jH
 tVEeNSJRT9DVGbEK4MB3ATq4yeW5hIM4Glh9eQGatryeLrMVtgdH2GcX0ykcvec8d+jnr0s5BtH
 LHor2iW2PhdO99Wh6swcK1WtAeVNZOHfFo6DlHXJQbbYAVkMwRYgzpH0xQGf612MudT3uxjLNDu
 eAhl+mdjIDEDpUlsKESWeNqd+4atIYEOSeSGcWrcVHwWbmRtYyMn1+ih9U0eyXvOYrEMhVWBMsj
 UdbKZyNnamlKVFIVuHt9+3EtXBbu40rsKDMg/rY2pfjt9jycz061fqXyL6si/g+fckTge05b8Rt
 ZR2/WTj1RVaiRz1F/3uyM2Qe39sZt4PktZTTEbKX408Ct4v8+RClP3Y4f0Gc2C/D2VB7Wji0vur
 Ha4jVI=
X-Received: by 2002:a05:620a:2993:b0:915:8502:f7f6 with SMTP id
 af79cd13be357-92ef2b575e8mr66564685a.35.1783711565033; 
 Fri, 10 Jul 2026 12:26:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92ee5d37540sm265182485a.38.2026.07.10.12.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 12:26:04 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:25:59 -0400
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
Message-ID: <alFHR3fg8K1-SITK@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <22d0f4e3fe11f6fd1312734e242d008267ad142c.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22d0f4e3fe11f6fd1312734e242d008267ad142c.1782735110.git.ljs@kernel.org>
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

On Mon, Jun 29, 2026 at 01:23:38PM +0100, Lorenzo Stoakes wrote:
> The only files which should be including vma.h are the implementation files
> for the core VMA logic - vma.c, vma_init.c, and vma_exec.c.
> 
> This is in order to allow for userland testing of core VMA logic. In this
> cases, vma_internal.h and vma.h are included, providing both the
> dependencies upon which the core VMA logic requires and its declarations.
> 
> Userland testable VMA logic is achieved by having separate vma_internal.h
> implementations for userland and kernel.
> 
> Callers other than the core VMA implementation should include internal.h
> instead. This header does not need to include vma_internal.h as it only
> contains the vma.h declarations, for which the includes already present
> suffice.
> 
> Update code to reflect this, update comments to reflect the fact there are
> 3 VMA implementation files and document things more clearly.
> 
> While we're here, slightly improve the language of the comment describing
> vma_exec.c.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

> +/*
> + * To allow for userland testing we place internal dependencies in
> + * vma_internal.h and external VMA API declarations in vma.h.
> + */
...
> +/*
> + * To allow for userland testing we place internal dependencies in
> + * vma_internal.h and external VMA API declarations in vma.h.
> + */
...
> +/*
> + * To allow for userland testing we place internal dependencies in
> + * vma_internal.h and external VMA API declarations in vma.h.
> + */

Do you actually need 3 copies of this comment or just one copy in
vma_internal.h?
