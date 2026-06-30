Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC58C44501
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D932510EDF2;
	Wed,  1 Jul 2026 07:03:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="jqvbdF4E";
	dkim-atps=neutral
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC8FF10EA5E
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 15:31:01 +0000 (UTC)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-664b2c00e12so3932321d50.2
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 08:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1782833460; x=1783438260; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vvVAmqyImW7TQjYTHR7q/vQBEUZYJ1tMtKhaki/MPes=;
 b=jqvbdF4EM3ipGnn9hRr2n87MJyXEiqJTFcTS4NlbS56DzUMyeL3jud3DmVVSfm8RhN
 gzaVGx8cGBY4SAvlBXxTke1iRFAHNvdVoWyeN9FzZN/C553rpFYEEZFnpJr8AGIWJQHf
 jX9mpV1rhU+SYiiF7b0kY8wmuaYZv/tHR/HcsHI1tXPF8piJ8zIaZ19NVMz9nknesbAY
 gKf9XtzGOsVRBb8LVYjYFW9dc7b6D/OlyHFaawNXcNCmAa1UG2jPeWBzu0R6U0byBCz6
 0afAM7MSnWwLcQayjT1UlYgXMDi9Vy0jeEgqbp8eLHhRu8Oqh4gd4EidzqWdjLwgHko7
 gFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782833460; x=1783438260;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vvVAmqyImW7TQjYTHR7q/vQBEUZYJ1tMtKhaki/MPes=;
 b=XpFH2I3wWbe9AOPhy29JY9hqjgfv2yEIvyP8BEG6RsHd3Ao7VhZw5U8zP4k54EQzPH
 WY21pMW7CRG53yy6koMvg8obiuK3WxP38iPN8E1UDUYsVHS8ggjXPDHG1SwEhn4rYsi2
 igfUc5E9vjweWRiK6qq/OFtXT2BDJfZAPLQ1HEgz+OIMUW+EkVX1ntG5KmaMm88jyTE2
 NMXTp5Kpyuw+7RuP/Q3WToK7im9e1QO6fTTwybNIzu2imNn/NPvIKn6dWAKzVsJ+LDi1
 YVOWj1GnxuahBxCFp9mi1nJoblqu3cC5ZY9tgtoryyWB3Hq3g4/1yFwPe1V7BGfKJ/Qy
 tyuA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCLy4wOAFlmM5Mc6LH3rs0KiKiwBBaa/OSBGN0ahxXtCKfJbp88vWeRoJYnxoeD4k4adw1qriEics=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4bNx3c+uKwqeb9w5KVtBost2/i3HezQ9+JYpEryt2HWJZMiu8
 WFwpwN+kVQ2eZbu6bGo/3CBruBVb2c57d1Vnnxr7qseFRKRaPapJPNYI1Uw80nxAlkw=
X-Gm-Gg: AfdE7cl3Kc/e+kz3+hNw9fPrI8xsbh6hwDoaCl9msvbH7jVGxbqRO76cHcHfGI8V0sU
 U1sff9v8HIDISoEOUaqATSH4Inhjze+V4MNMOr7xH/5IeD+beKZ4fXVGsWCCGroQhrghcR51ESX
 /X7imLxFD2dn12460bvrDHv0Wnr0iMC76ZhLb/985Pk4YiHfkKNOmpAncIyKYjvkL7ATqxB3mJd
 kHlBxqvdysE4bxCqSOr3s8U2IAoje+vgG9p+7e6XWk1e6o+iPNGQ/uPXpK2A14tFzeW/LWa0IR1
 q3WxyVWuiMsc3N6MTQF0qIctORuBbmPR0vmyJqkSxQZ5JtnMi2iA8UAHrxbiGsykh2MPHG4ka8b
 SKCov12Azq0JLBuap+znPVMs1mEgB+fwZaFc01Px4kJ2lZ0m+wkj/AKdjzzYLyczDZHXD3nF6Zd
 72WaKNmbtHKSncCRBPcbeb5/GwTK8PZkIT3fUmhmXtKY5DFxHxly7FnM2a8J3Fh876ZsET
X-Received: by 2002:a05:690c:6112:b0:80e:bd63:1780 with SMTP id
 00721157ae682-810d7eb0bd6mr46000317b3.2.1782833460437; 
 Tue, 30 Jun 2026 08:31:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f1a783d9d7sm25574106d6.41.2026.06.30.08.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 08:30:59 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:30:54 -0400
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
Subject: Re: [PATCH 07/30] mm/rmap: elide unnecessary static inline's in
 interval_tree.c
Message-ID: <akPhLlv66ZqQ-jrw@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <ed5fd5358382217a92f0a6afddcfaa030c933055.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed5fd5358382217a92f0a6afddcfaa030c933055.1782735110.git.ljs@kernel.org>
X-Mailman-Approved-At: Wed, 01 Jul 2026 07:03:11 +0000
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

On Mon, Jun 29, 2026 at 01:23:18PM +0100, Lorenzo Stoakes wrote:
> It's not necessary to declare these functions static inline as they are
> contained within a single compilation unit.
> 
> This makes the anonymous interval tree code consistent with the newly
> updated file-backed interval tree code.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

