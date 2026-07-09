Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5F5C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09BF610F7C1;
	Fri, 10 Jul 2026 07:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="lRfU7tCB";
	dkim-atps=neutral
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6228B10E256
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 15:22:55 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-92e6391b114so138030785a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783610574; x=1784215374; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8MCYdDNt+ln4FYDiI3hqZQpolLcmikZ66uE9gEYE70E=;
 b=lRfU7tCBkJCOuFeXKha7F7i9b49yVEhmH+/kh9WMniA067KhEaRyUKYsb1xbgiyvUe
 Gk7H1gE3Ix8kpq6pibUHuC9rIfo8pmMpdglq+PI6FJfaLeAdndC2vzvrmEmtV7catR4p
 hlKuF2fvYPM2v+alBlwSJidEThH/Jl10Nk9ZnMrfMoU7us30egO+47ck39TGqQ1T/Xe8
 ncevMfEgpVQ1ONM7CQ1KVSZeOj2Cznyv30QEuCko9YEWT25s5ZXbYMCsq8mS4FuWCwlO
 CuI2GGtlayuhb+yKCV6zRlhNKVCwCk5YzM4eNlEdP3iXmIiNfuk5ix5x+nUFYc29IluQ
 PPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783610574; x=1784215374;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8MCYdDNt+ln4FYDiI3hqZQpolLcmikZ66uE9gEYE70E=;
 b=OFizCTn3zdp7w8m38LpmxsOoUmGMAY0C1gYLhEwfWyVb2BQoWWkUzLZlADWNp8p9hD
 kUin/0Y40itjhdySna/ww17RTE2P3Ghcd1S/KoaL4uiai5xJSqbTyzAmcFIG/rU3t8i7
 HKNnV/vrPDZAIpPow0u7jWyBm7T2Bx0DW2OVeT2iS7IP6xBdYJuZwDlHzcfvzHgILZ88
 Q0WbiQmn+HSSMyaH+TxkqXOsSfNBYkbiROQyXalVMoHHzQeoY67GXUAXAhZO9r+UjaQ2
 nxs2I5u1ZgmU0FPxIxHLNm1jqson2fIcoCxCjd/UiFvS37pfGgGUNIK05D4FzDMsSVls
 ztFw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrdzxRhpXvHLwYwb1G6R8Bz9RzJdG2nv2r49rFdPCEoO4mNsgQvrS4gwb2DCOo6Cd1JjJwsBx9bDp8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzo1tMXSgwFb+sw8o046KCMoH5s2JVExIt0I3d74BHN02jX8SHK
 IRdbn24MHVWYGeezXb+8JtiI5JhB1Bjgv2zYUEMkoFtcvJDrryLrJmdD8ChAgHZB5ss=
X-Gm-Gg: AfdE7cm+QoIovDQ7mdYHsih+nqyXjVV6F29QJ+8TggmoYKXl9lF0ugEepiaT/Avslp4
 +3KxD+N0aj7BbW029KTQ8X2Zhg0eDjWJRMB6/W1Qwns2a4hmwVw1haM+1zX0LPpO+nCbg7XOXsO
 vHkLzFUo9wADxnIM1g2G0HxM6QctEm+Unj7GPUmLNOLKq4r4989FgcD1ITkyzMk6CaS4CZQs20M
 x6kG6pJW6or3j5oC/LZrO6l9N6ZgqKblrs4BhkAksQC7mKrNzgc3Da/B7IyBcA4WLFDyJWL4v9A
 Zb68v30DV/1RCtEwRzIboAhRqAPvX/Rhuko6esj295DYoWDe0CdDxlNBWM0Gb+3k3yLwnL2XqXa
 yT3K+E0otKShTy5VzNyQFXQzBGF8lovi9h/2xmFXgqN+i7QSWwyMfRgz3vfLgPjnhWxHbH0JsmH
 0jifzcNH+vlgfW/8W5cJe1+KaeuAIuD1nA2atuZr/TMPpagz9utlFUeKC6VErMRbG+h0+v
X-Received: by 2002:a05:620a:28cf:b0:92e:68be:1c5 with SMTP id
 af79cd13be357-92ecf6165e4mr847751685a.21.1783610574232; 
 Thu, 09 Jul 2026 08:22:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90b7fc3asm1638936985a.9.2026.07.09.08.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 08:22:52 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:22:47 -0400
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
Subject: Re: [PATCH 15/30] mm: introduce and use linear_page_delta()
Message-ID: <ak-8x3TWsuhGzKlJ@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <eedf589778aaab33e6df2ad6556dcde536e13460.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eedf589778aaab33e6df2ad6556dcde536e13460.1782735110.git.ljs@kernel.org>
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

On Mon, Jun 29, 2026 at 01:23:26PM +0100, Lorenzo Stoakes wrote:
> It's often useful to obtain the number of pages a given address lies at
> within a VMA.
> 
> Add linear_page_delta() to determine this and update linear_page_index() to
> make use of it.
> 
> Add comments to describe both linear_page_delta() and linear_page_index().
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

