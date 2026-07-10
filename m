Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254AFC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D94EB10E830;
	Mon, 13 Jul 2026 07:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="fD4KRU8n";
	dkim-atps=neutral
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 943AA10F93B
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 19:08:38 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-51c2a449c57so7492141cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 12:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783710517; x=1784315317; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iFtVuusRSG4YUFzvnh+nyLwKm1T7E76ZywXpwPdPfD8=;
 b=fD4KRU8n1uPG1nZgw3cqES1SP0xkWDXBK5I1zajMK/xl4blIMuVrYuDfhAqTQ/rTsf
 xtgC/4ybO7PYoOOzvEvdf5qAX5hS7oAGaibJI5N1HXG89vBXuM/mripBUou6qBNOHdnv
 vNrdA8uz2QGw/lFyTSuCdsEKuo1Ieu0aF/bDFN5e9Y3lpI08Gpg3q/g2HmNldASGXiom
 5C72LNq4cUGdR+eQkfM4b2hjq+S+sQpHgBtuCjg+v82+85zFTu+SU795T3/5iQTa3eHk
 fIpsmgFR3W50upaoIoVGqkR3hegDHs/Kx+ypeQvgv3kGTHKIF23EEH/NmnunvNaH93BK
 vITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783710517; x=1784315317;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iFtVuusRSG4YUFzvnh+nyLwKm1T7E76ZywXpwPdPfD8=;
 b=kquOXevzg9XrqIOBs3kJq9/tdEbAIofd/NOmz8OxKvq9fDjeAleB/bQGqyFoeNkBXC
 s2oNTEdAGNFlOGKzog6sctR/Z3jiR87/YrjCPRvcPddvT4kuwsZQRmARFBtaQh7CQh8a
 IgRbc2uHMbADQhfmbhLXDAEi404uotqeUoZZh7sYMCNJ5FfhtMlsrRaFTpTk99id1ySM
 5lB72NGfEwHLnwOb4sahc2DX/Qwzzuz8Qz0Ao5pQN13IeOayg1MLne6zkrEpKGtAHNTZ
 C8kRA6b9NO/Djrw52XzH52Ehp3RKebBZ5pz8YJfUljg9kQ16x9uioZCmyJg45tkB4Gc/
 R88Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpyhQv6vthUrLWmHjVPRjcPi1zoK/xgVlVUmjWmxWd4tQsCqNgr1G0KEQFBpm7QM5vr46L85esZJW8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwBok0J1Gbo024JBY4bWFkcUywrlz33XXJG3/4fGdsfOy3ERBI7
 /oVXrbMb2vjr2yY8048V1bGfYV/Ez//63gEE9U80TfzhFZq8Y455aGs4T3xZ3WHm3D8=
X-Gm-Gg: AfdE7cl4pGGJsvsxyPFfArmPZgzhabWth3W/kMVfS5UNme/C5FRohfhIBD0NOzp+PXr
 FlG//DFaIDJ9wqgKft1tNwx9UWQMo+wrypcrYlUzAtdlcJvBglSbODrYgPsDRcXOv45f44X2oRO
 xK9nwkVB6OL2RSwu+bMZD6Mv69WQdYKw/rKEXSvVEoq5elfTKzluuvAWEvs0aHs7BZD4q/sUP8h
 j3KPXaOIbcBB0vhVjFJSX5INZh7slFIQBNVzxLaW9RqPSeHvvF0ZxSPL9GB13DABew7vodV2Hya
 jdVkm4sSQ8EvzbXoP3VqatB269VcThwm5MKtRrK79oAZxMFejOyr4ZrZapBGXIRauMUXE0pDKa/
 tXiKhJ0CDwVU3HbJpebLWOdVEW5EM//cD/dWu4Xwdz9DvC3IKF0G222ZEYdYA2R+/9tOnmYxIrB
 IEojuA1YKdDK2D7a6Fam2rhmL+9SkLZUpTqvcQHsXQEMRtI4L41/nj4oPYDIiOj3DDf8b1
X-Received: by 2002:a05:622a:1818:b0:51c:b900:513d with SMTP id
 d75a77b69052e-51cbf280a8amr2226311cf.53.1783710517321; 
 Fri, 10 Jul 2026 12:08:37 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd7c1da1bsm47847566d6.30.2026.07.10.12.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 12:08:36 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:08:31 -0400
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
Subject: Re: [PATCH 22/30] mm/vma: move __install_special_mapping() to vma.c
Message-ID: <alFDLz9_oSSvHTuJ@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <b3254231831037ca3e9757e3e05c90072e04a6aa.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3254231831037ca3e9757e3e05c90072e04a6aa.1782735110.git.ljs@kernel.org>
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

On Mon, Jun 29, 2026 at 01:23:33PM +0100, Lorenzo Stoakes wrote:
> This function is operating on VMAs and rightly belongs in vma.c, where it
> can be subject to VMA userland testing and allows us to isolate it from the
> rest of mm.
> 
> The _install_special_mapping() function will remain in mmap.c as a wrapper,
> since this is used by architecture-specific code.
> 
> Doing so allows us to isolate more functions in vma.c for the same reasons.
> 
> This forms part of work to allow for tracking MAP_PRIVATE file-backed
> mappings by their anonymous virtual page offset, as doing so allows us to
> isolate and keep code that interacts with this together.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>
