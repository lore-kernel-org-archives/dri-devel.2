Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A629FC44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C85BB10E7D6;
	Mon, 13 Jul 2026 07:10:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="MwPxo0Pu";
	dkim-atps=neutral
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28FFC10E1F2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 18:57:28 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-92e54f8c051so64509585a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 11:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783709847; x=1784314647; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kUriDsQ9XZtRyYKZZfoXUueFFJuZPgSg6lCZHNic6sM=;
 b=MwPxo0Puka0yMf/vK6iTfPigynpSPij6t3m4NEjR4YexRsbFafb7lFlZ6oD0xQup1l
 6rkQiPw5X08z203VdUlabGkTc6B6hw2HCQd7kzw9mmOw2HmvpqIp8MUfPfIJqZPc0rHx
 ui4pZh+CxziAtUIX90G8hTbUmwmIZjgLXC9GzsjDZzO+n7tls6GJhmCu23XOW/p0Hdn+
 Yg6FWzIFcQC+jOlou2MX4sJNAB/Vq5ThlaI4B8nginQv2rVQaLt/1MPcimJzs/X9ZKdN
 s9l6o9FSb0WbiMYrySUDhpnfNBr8xdst4hs9REGaMmIhX42DiIZmOo5Qg8EwctwW7so9
 U21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709847; x=1784314647;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kUriDsQ9XZtRyYKZZfoXUueFFJuZPgSg6lCZHNic6sM=;
 b=Pn25YIbRoZJA5np3yJ7tXPrnRJ8NdrxIEfUMRi+lNv5qUhrLkV2hBIrjKxq2qxwFB3
 Vj9Wy6rUY/ZhdviMu4fPMGzNPQ7F2boZG+k7LDqEKu88QSu5D/t06PZ0oRej5hyKie2/
 bBDVXXS5lfIosIhV9Pkh+sPAXZioEvr3/RMcJhuV8t/3PC/QQMmNrMn7uwXMhJ6gJioJ
 r1vZWWET8jdiz6RRrOICbdywFfLmteYcKkCa9yqccHTDAT2FewNNs8F9g68lEJd3z4kG
 MfRQnc0KlrmX19nJPRggnPGUrb4wccyh49LeBF1w5RG+/rkNSlZSFH75dC+N88s1X6pK
 qjTw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrqMqp1Rr1aWmWiCmvvjYjPxggcZYP81SoDwAe4lQCEp78ADUqgG778GZMd75Mqd+l+cRkAViYAM2w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5FonoWDQu79fnYGrC9G5kXCNJDKD0KBcsN5bNHi7APerhvmvd
 ta+CJ2qf5gv0RYhjNF8hAs34aJJBSoqP2naVviX+gVa2WM6bhlDhea5RYN/BeQ3fT4U=
X-Gm-Gg: AfdE7cnVsrwU8ZvjnnByFQdVMss2ob5zwiedujvZJ9UavXv5YG4W9k9FEUrRyPuFg+I
 R7d1pFo5auzR9B7oh5nEdpsBCgkQC52IvZczWVPXjEKj3vEGgm2d1hqGehV8YA1VKCpt7qUE8L+
 kKDREzfIAImElPLOvVM8r8dXVSKwm8X6r68Gy0t6MMKUWe40nvQg08kbAgHr5g6lxGa25KU8/rR
 2NRomabD16R4EsKEm+TcF341PS3C2S/T1m7yWfodxTpl594yBDL9kLXi60uIWuVBqEKiIv8iA6u
 ATurm7VA7KhVmxhdQ9wtGlAuepgFWRWaxUPR25NAl7on/0qaqdLG3wDsiKN0FI8XXTXHKbXTH/l
 QzW+1ZUgpD9OXQGfgkKTkdubAkvgGu2I2BnJq/Ryizh1TdnR2m5iyMieOu0gGX+546JoTFhWx6c
 nBpyG6IrZQZQDqTDlowD1QJwnMKkG1opIrsdXZ6QI2j6wYZuooHK0f3Q0aTDWkdzMslU86
X-Received: by 2002:a05:620a:d8e:b0:92e:9d63:a6f2 with SMTP id
 af79cd13be357-92ef2c1ab7bmr45629785a.70.1783709846741; 
 Fri, 10 Jul 2026 11:57:26 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92ee5cfdf6fsm275995385a.24.2026.07.10.11.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:57:26 -0700 (PDT)
Date: Fri, 10 Jul 2026 14:57:21 -0400
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
Subject: Re: [PATCH 23/30] mm/vma: make vma_set_range() static, drop
 insert_vm_struct() decl
Message-ID: <alFAkWCnkYv--Us0@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <62efd70f9f39570724c9552cc7f2aeb5c322b2ff.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62efd70f9f39570724c9552cc7f2aeb5c322b2ff.1782735110.git.ljs@kernel.org>
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

On Mon, Jun 29, 2026 at 01:23:34PM +0100, Lorenzo Stoakes wrote:
> With __install_special_mapping() moved to vma.c, vma_set_range() can be
> made into a static function there and is now completely isolated from the
> rest of mm.
> 
> While we're here, we can also remove the insert_vm_struct() declaration
> from mm.h - the function is implemented in vma.c and already declared in
> vma.h, and has no users outside of mm.
> 
> Also update the VMA userland tests to reflect this change.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> ---
>  5 files changed, 8 insertions(+), 24 deletions(-)

Net negative lines of code, the best kind of commit

Reviewed-by: Gregory Price <gourry@gourry.net>
