Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756A5C43602
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:19:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60AE510EB36;
	Tue, 30 Jun 2026 07:19:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="bTY/egli";
	dkim-atps=neutral
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E68C110E6C0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 15:27:33 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-92c7a0a7059so197272385a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1782746853; x=1783351653; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YVSnUoP7z1l2IjNO7QqWpl688BIslf+DGUxd2Ln6LGs=;
 b=bTY/eglikrstZo4mgRbAcY8W0ky5IARGEPEOcPFJy3gJsj48ZXDCv1SH2uvhO5JhQJ
 5tRoJSQ+s/54efDjFXCqDhkeSLdFbwYoyC9qLMQ3YYeUxI5R0Cc8Spr8rK1ynZYBBT3+
 t9JQwT7XxHpXggHaijoFV1ai27qZz6p6OcQAHhdGZ2hlmjvcLIXr2tEDjJew6NEdozQ6
 MbyvOwFSQnDwGqnsSRHL6OeY9fNPnMuH+iQufmQcEmUgccZa+zj2YGfThEzCDtXyF3C6
 Wgiu74dRgLOSMpXTg1MXWm/mPzPY3JhaWQ7RHnCMnFpm191mWM7UDFknh+JngWyO4wgu
 5ACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782746853; x=1783351653;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YVSnUoP7z1l2IjNO7QqWpl688BIslf+DGUxd2Ln6LGs=;
 b=f2Jisimuisa1iNuYSZ16jbWxINjzNR8uKrH7dfrI7j+4VjqnWKbg5x6I+istTveZOj
 4F9zMy1zzJYIySISW60ZZ3QKLPh2ocwQfjAzXurG3SVTIs3bUWm7jVvxyt0fvfYM4zz4
 drkahOw72zLT49FYyYmXIm01ps7d6IWzmB8k3ITqeQ3k9IRKuax8PdA9HB6h5mc4A0Je
 PsV67by1HHPm456G796HwWPbZq0/oAX6MBLiqJ1+aS/HPXuu0Q6202vFIzKRRgNiRciW
 ZzhXlCW7ao8P5W3Aptq1myXBVfNcACX8FTu9cJFIdjuDyf3PLDXpi/JO0/20SSzusmQX
 BKBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+r9u+LmL4ZDpxLzEKivKRO9hamsF7xEJBa3kKSvATXSBC7uy1MS7KLDxGK3ADi2SiIovhXr0VExy0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwqVu0HvhxMKT2TPPNb5yFqBEJJAriA7mRr2MEANzeD1uMstkiZ
 WwSDzLLNoQSENW0mvcAI009c0wElyZTxHO5WiY3Byd3g77WictEMs+CRawzSCdtuqXc=
X-Gm-Gg: AfdE7cmZ54jWsFcPqnopmSUE3Q92lfeCS5N68v5tHeZQwvEpt7MNTDh+XSLs6RpNuVW
 aoRTlPfO7reOG4QtwepGaRdwOLlDbpnN3vPCKNDmWRnoKRcddACY1Ot51CaoKxbLkj9B/UUAKCD
 gmOhs0VIJawiE/oHjboTZyqGI3zTGt0hy/PJ1QOe3WyNLrm+smkWdcDo234Rw+1rOUCTR8Rey42
 M6QFscrwVVrVs99ZljxxFjeAZ8i+qTu1RrG6NXC9cNNIr4EKjLmUfGNPMAUiALUX7JYKXNExpa0
 I8EWU7/3DviluZNdHGP7Xa5Yo0kBkncBkCCBCLRGyoYkoi3qgaPPVJkx+Ak3HLc2G9vfRK7xyYM
 K1wLWQYJyK5vXrh2Wf3p3lCqPeoF3TDeERJvtfH46C5nXEHinoiNA0FQQ38/DBQOtC/rd8IsrvR
 Cz/XFK1jq1NRHhqpZJ6bcgQJfA1E7sXPyR+itTr8dz3gsbcbWAA2pswgupHNXnTTdwgzVoQYimf
 z+00Fw=
X-Received: by 2002:a05:620a:7002:b0:921:9df8:d38f with SMTP id
 af79cd13be357-92e62785c63mr1415985a.43.1782746852526; 
 Mon, 29 Jun 2026 08:27:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e621943b3sm7429785a.19.2026.06.29.08.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 08:27:32 -0700 (PDT)
Date: Mon, 29 Jun 2026 11:27:26 -0400
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
Subject: Re: [PATCH 01/30] mm: move vma_start_pgoff() into mm.h and clean up
Message-ID: <akKO3vnNmWIJAZ7z@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <b28b698df4c009e85c4728446ca5863d8e633164.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b28b698df4c009e85c4728446ca5863d8e633164.1782735110.git.ljs@kernel.org>
X-Mailman-Approved-At: Tue, 30 Jun 2026 07:19:13 +0000
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

On Mon, Jun 29, 2026 at 01:23:12PM +0100, Lorenzo Stoakes wrote:
> vma_last_pgoff() already lives there, so it's a bit odd to keep
> vma_start_pgoff() in mm/interval_tree.c. Move them together.
> 
> These each return unsigned long, which pgoff_t is typedef'd to. Make this
> consistent and have these functions return pgoff_t instead.
> 
> Additionally, express vma_last_pgoff() in terms of vma_start_pgoff(), since
> we wrap the vma->vm_pgoff access, we may as well use it here.
> 
> Also while we're here, const-ify the VMA and cleanup a bit.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

