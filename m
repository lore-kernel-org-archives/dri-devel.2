Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724ACC44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 972D410E7B0;
	Mon, 13 Jul 2026 07:10:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="BOsNu7mL";
	dkim-atps=neutral
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E376010E4EC
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 21:27:06 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-92ed19f4d60so89287285a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 14:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783718826; x=1784323626; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oXHpiDgBaIEeQKnuJdWSZ8rFz2G2XIdWbRFpuwAJIiw=;
 b=BOsNu7mLB1JbrElJD0yTZwXP8ycqiju9WADfCMB0S073g1RP57Wzci9UQGei7H3bhs
 UURYONpKhpbTDuf/PXcOeoEP0PFXIC/JK1zDIXog1gzHy0aF0oL+u73X+4Pi8+TKn2HV
 oUBYWYSZl3FxTIRRjAmDwUQoL/r44c8GKBW6LEp3FvXJNZgLtH2ql+1gTlZ43ieU7/0a
 W6sfum+Zot4wZaPMeCGU20hnx+Fp9nYMsCbCrfw9yQv3LG4+nj1jpr8wHzXrLTonCx+f
 vXn8iR37YjHoJCG9y7TEjPcFFVPNBcxSI1ke2wROQPLL9oy1BpflDpFO2P8EQKbilBhY
 P6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783718826; x=1784323626;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oXHpiDgBaIEeQKnuJdWSZ8rFz2G2XIdWbRFpuwAJIiw=;
 b=m+vnIJMDnAYtpu3J0CYLMkOs9P64z6Y21H5q0xcYtrU8TCr1830KAdKUOLp3bLP5BG
 a7CwQl35I5CjAUrbKkUYruMBStiY2JJaBHhqnKyC14bFXSLcMk4eymePQXnd3ufqyblp
 Bm1JOMOMo+kQF0pMZRecws6E+hagSAvnzx5EkKrr1OV2VCmBXV3/zwlP0B6OYIUu9lzF
 hQoiawRzNyGj/WKTsKI+ojVfrmX/pe2aCuJvv4aaY7abV7Afh5uD4CVxCJyFbHUS3rpW
 Z0fqUnaUqi5Y/V66ygYSx2knu4diKRVrT5tFfSWEghZOZiLBZMCiNlU76T4Mg421538P
 qvHw==
X-Forwarded-Encrypted: i=1;
 AHgh+Roy7Vlvi14jX5GmCeM0xyTbJWwcs321/EMnPXnKfdhGK/FrLzBTTG1jMX9zfrgnSuCMapeTudW4HPE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3n/xJy3BaJds+R4FYdQ+4XJuPAq7MqnSEML2cC7S0EkgJpMZ9
 8381RsYWs4ITxAWgFqEnUlDgHgrqq1VXdYH9Ffi7e3uvtOeqyBb0lomvNLSZxFQwt5Q=
X-Gm-Gg: AfdE7cnmvYd8P3YNp7jk9deW/dYh+jJOIuQNwo6v5OOmx0CZUaJ+ZNgTV2pcsGIj2Jd
 LlnysXZYPdEC+0scQB1bpjcryuDNglmLyKwZyQTCxbO2GQS2+R8xFFP1/SzuOAQu3B7y3OktWtT
 EYkPPHWLdnB6qEDo8yigVcG4v4IFxvvJsjUjLCtVN3WL4uv98thKXiK9jUNmi8eAPFwRM90jMYC
 sqAzMgGWNwlb6AQb0P3wb/qx/Q0qgHZYORgnF+UXn6OGQta6qfmMD9GZcoqcLd0wctYnn7CDeyW
 cfsYPVfsgD1VIFXrdzC0H2+i5byJcvcU+HipFBFKHI1+L/qYbg3cE5+hSod7gVmFg/bv7oblXqf
 Heo6U5wNo5Wozm7u70ilsy/52SCQufkYlSOiDhcWBGTqdJxG+GeuTTkVDMAZCNpgolAiEDegtyK
 XsFtFJpMKFMNP1vw5sHpIEkwJKeV7kcXOVUB86DB7qe4Bno5LWKIMQgsVN9WtyXn+yQZHx
X-Received: by 2002:a05:620a:4008:b0:92b:856f:3c14 with SMTP id
 af79cd13be357-92ef3d1792cmr55468485a.11.1783718825767; 
 Fri, 10 Jul 2026 14:27:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92ee5d2d68bsm289148485a.33.2026.07.10.14.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:27:04 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:26:59 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
 Lance Yang <lance.yang@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
 Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>,
 Simon Schuster <schuster.simon@siemens-energy.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Dan Williams <djbw@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Alex Williamson <alex@shazbot.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
 iommu@lists.linux.dev, kasan-dev@googlegroups.com,
 linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 29/33] mm/vma: introduce and use vma_set_pgoff()
Message-ID: <alFjoytGnkjJs7zR@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-29-2a5aa403d977@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-29-2a5aa403d977@kernel.org>
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

On Fri, Jul 10, 2026 at 09:17:10PM +0100, Lorenzo Stoakes wrote:
> In order to lay the foundation for work that permits us to track the
> virtual page offset of MAP_PRIVATE file-backed mappings, we abstract the
> assignment of vma->vm_pgoff to vma_set_pgoff().
> 
> We additionally add a lock check here using the newly introduced
> vma_assert_can_modify(). This asserts the VMA write lock if the VMA is
> attached.
> 
> We also assert that, if this is an anonymous VMA and unfaulted, that its
> (virtual) page offset is equal to the page offset of the VMA's address.
> 
> We must be careful about MAP_PRIVATE-/dev/zero which violates fundamental
> assumptions about anonymous memory, so we check for !vma->vm_file after
> using vma_is_anonymous() which these mappings satisfy.
> 
> Additionally, we only perform the assert if CONFIG_MMU is defined, as nommu
> does not set vma->vm_pgoff = addr >> PAGE_SHIFT. This isn't really relevant
> to rmap as it has no anon rmap (nor needs it), but we must avoid it
> asserting falsely.
> 
> All of this logic is kept in assert_sane_pgoff() to keep things clear.
> 
> In order to maintain correctness given this assert, we also update
> __install_special_mapping() to invoke vma_set_range() after it's set
> vma->vm_ops (which determine whether the VMA is anonymous or not).
> 
> We do not use vma_set_pgoff() in vm_area_init_from(), as at the point of
> forking, we don't necessarily have correct locking state.
> 
> Updating vma_set_range() covers most cases, but in addition to this we also
> update insert_vm_struct(), compat_set_vma_from_desc() and nommu callers.
> 
> We also update vma_add_pgoff() and vma_sub_pgoff() to use vma_set_pgoff().
> 
> While we're here, we drop a BUG_ON() and update insert_vm_struct()'s
> comment to reflect the fact anonymous mappings can be added here.
> 
> Finally, we update the CONFIG_MMU, CONFIG_PER_VMA_LOCK defines in the VMA
> userland tests so IS_ENABLED() will work correctly with them.
> 
> No functional change intended.
> 
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

carry-over from v1

Reviewed-by: Gregory Price <gourry@gourry.net>
