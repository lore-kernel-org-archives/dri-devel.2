Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EC0C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8448210EB3B;
	Tue, 30 Jun 2026 07:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="VBjTY6hr";
	dkim-atps=neutral
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com
 [74.125.224.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB98210E977
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 16:01:09 +0000 (UTC)
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-664d7863920so1141085d50.0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1782748868; x=1783353668; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4iCXvcvVpnsYDr5kbvWXbUhbyvnE3mHOMHboZJmxShw=;
 b=VBjTY6hrz22fvmKyWf1z8iNkgJU+JWi8ef5kzzRE2zYq1tfJsUeVWo3xG14R3SnD7x
 17D/LOHPNHzHzzrtjjJM0IvO5wpToxK4xt1OAzzd71JAZG5Gi2lK0abtKbkdnMyAVhy4
 zUbfncnVZLTbze+Ur73ceQiy/oBbgPILQ7FIJ1blSRjNydLr/icQruluoGOBrcaM2kun
 On3pvpd+0iEbefkg3NDHWAKnDuqF+drQreP2va8yH298wGGn+tiMTAl9T9yzt+Xur7IF
 //5gghfmo0r6L/GsWHdMZqdIGANFc56xRPlmPFeIeKKg6OjSj1iR4eF/jPFiGdHD6PSG
 FI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782748868; x=1783353668;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4iCXvcvVpnsYDr5kbvWXbUhbyvnE3mHOMHboZJmxShw=;
 b=kK6byV3+QWBcp8+6DwK68cx3jbn44I11iJH/AVO9hAyb5csIjPoKo4wNGUDqR0G54p
 8nBvWJ0uMts9yhkRrML8XC7AyO01adM/m0xEQpc35jHC2r7kKVe2osQWsCRJUTICEf12
 MPyF3TCy1EeM/2rnZMhchBLkqgw1DC6H1V43MPcKqeL8C7dJzapdYC20T3XLOsWiBckT
 nT4g73jqOSmyQm3ZhoBf6pvQlvcUhZ/GDJrcIvhFe2k2EIHvQZPEqGImOl+5YxosYtPP
 Z9/icqbw+d657pBaAwKzVUSB+sAnWWEhTK0ucWnp2IbInTLgH0o4aa2GPQSaa2o+i80z
 91bA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqKDJCQlT5PkSluxWD9SVnqGf9jKYtHFSdunagRfqjSek+jLjSO5Pxo0G5N9HiXHwn8vmnfUQtZmeI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhFQp/8b36+0oBU9vjm17BOp4uoMwXYEQ/cTixy4ApdP4eFuwR
 KiscadSuSjuKgtjCN2LVHuD897mlB2T2vp7MPtVmVXDS75kJv99sGhAmOrZvBAQxNKM=
X-Gm-Gg: AfdE7ck0TMWMaV3O1RPT/JR3+sHxW05dGCPG2/d5xYzwmcPcteb9Ak2lv0IvY+oVmfz
 CHFai0i8XLa/EuY4n8OALwPTjw7GodvuxdlcnB/bzSvU0WbGnt3OYBJiyAlHnFrXUjehWQsgeum
 zKDOksIb/pdaqgkXIr67QU9p8V16lXj3j3Za5sasrBuEHljHrAiAjxWLs2KgAZPpecngjRERowm
 vMMqqs7JOM2g+f2CmZviEgkXYq2GA10S+d2647il0fZnsIwFiX5IaBczZD9CprijNplRTuGKWIO
 sXjTbcAZY64ZdhaM8Ypl37TRh2KboLxCq9BdnElWTVMvMQ2oNXFSVne6fyIpC2ggmAMUAZ19d9w
 GtOq5EetoiplHaY9oE8hXpFxlMDWGx5fZGNxSFyG9/whUehZVKv9eTm8q3J39hw+YVZXovF91VZ
 TF7Tr4bspvfn4acd5Lt8Bb2QH2APEDRH9uxgBfDBFxNyCR2VwiEzmhhjJWcQIj3XanPHzsSApy8
 sWSfn4=
X-Received: by 2002:a05:690e:d8c:b0:664:e66e:f965 with SMTP id
 956f58d0204a3-664f974638cmr245066d50.7.1782748868214; 
 Mon, 29 Jun 2026 09:01:08 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f1a717edc7sm1112836d6.36.2026.06.29.09.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 09:01:07 -0700 (PDT)
Date: Mon, 29 Jun 2026 12:01:02 -0400
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
Subject: Re: [PATCH 05/30] mm/rmap: update mm/interval_tree.c comments
Message-ID: <akKWvnU2Ua-8ceSb@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <80d482a927b2e9862487b812e0ab48ebc1289a70.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80d482a927b2e9862487b812e0ab48ebc1289a70.1782735110.git.ljs@kernel.org>
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

On Mon, Jun 29, 2026 at 01:23:16PM +0100, Lorenzo Stoakes wrote:
> Update the file comment to clarify that both file-backed and anonymous
> interval trees are provided, referencing the relevant data types for
> clarity.
>

Isn't this self-evident by nature of the function definitions?
(one takes a vm_area_struct, the other takes an anon_vma_chain)

> -	VM_BUG_ON_VMA(vma_start_pgoff(node) != vma_start_pgoff(prev), node);
> +	VM_WARN_ON_ONCE_VMA(vma_start_pgoff(node) != vma_start_pgoff(prev), node);
>  

For my own edification - I know not to add new BUG(), should I be
converting BUG->WARN/something when i find them in areas i happen to be
working in?

~Gregory
