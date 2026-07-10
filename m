Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75392C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43CD910E7BE;
	Mon, 13 Jul 2026 07:10:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="Xv4CwKEx";
	dkim-atps=neutral
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8D4110E21C
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 18:55:51 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-51bfb91795eso8305541cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 11:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783709751; x=1784314551; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=35hzoYcsWEd72Qin3ApbTs4xBItRwQ29eotWM9K9y9M=;
 b=Xv4CwKExRfJhyOJkHXi2SK1xsFZIstqw4ERUmd4U1KPaWv11QoL9sP5ssUhTwissDq
 GN2MFJ+2vNd4gjBvxc+1lDbfprvZachydZTy5CDVrM5aGoKA3yqJeg/ozV4DgZliwS8T
 JhhWJpaTAF4wt7wemt+rwSQ3W5HJngnds1o9sZnRT4abbUnAa8FKmmGWU3gpWGmvTs0v
 XAxNHnHOCT5ZR/FO0fmqqhRkMtnprputcwGLoK/kEfZ/QI28xFRTMGDvjLOxW9o/teCc
 ecT7breDU/lwuzrdPsKX/o8YRRtUMZWdljMeRBDfqdAMA6ywcnFRG1884SmQ83LIS8qp
 QaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709751; x=1784314551;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=35hzoYcsWEd72Qin3ApbTs4xBItRwQ29eotWM9K9y9M=;
 b=MdzqqcAAmHca+4zzyOECOl2dJpNCJQ2jR1AZOQXheQ0khHid/0NDD5ShMStJZ8kBOn
 F7JG+rEjKg2I8hToDzVM0mp7uP0wQtf8qwQzQBFLK5hLs0OBU6Dx+l/ONGVSRKKf1tud
 VP5BsKArm+sR24dAeBRCtUv3YDCOHnetJ2uKf+Sc2/zWtUMWn/uYTSKR/Ajmqb6h0Imq
 /gw8oedBh0/D5UXn3E8oiom9apZ8DZOnxYhAFbGiHe1OUg5EAAMCoc7huOcwh2dgXNWQ
 +wLgfMP8KL26XXRbEqUSvGWAv2O/gZjZ+fE0Q7tSl2/iVUzn2Z0DuIPTOYqN7yL48H3T
 1gpQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro7qoBR2lJJ7Cd30uRauJMcHN68y+FZHTaKcmDPKYChjeXL77qs7Wqnbj/lR04p8QiJlQ/CXlOJOZ4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1jbWDa57O9jyyyIrFM/gtbXNsyRmg/hbzo3fPPPOr6nQ8d8Wp
 uPaAXrMsc0zWRZO1u68a/oI/REi17V/I/pgX1j5Wm+TxuOrUukqKeLOlQzaApa36kE4=
X-Gm-Gg: AfdE7cnBKdgbfN8qWZMBSet9V84BCTV1QTXK6+ZY5g58gUtVQPDThggDzKK0wfsClvR
 2sJjta3/JXI1d4jTsRS3wfE225cL64uUWKSymUi19oiSrCIOK0uXLU09Dl6ZbmdXTA2vXQfLfFw
 CrS+fNNKa8VueFMMA7pHv+4xongYoNDwuYFk6bn0VSg2c9b7TpbDZxTjfsg5frsMZ/Lshd4+1vs
 7JGOtqnxT7t4Jb1BMSzI90tWGB3hgPMlr0Gau9DXz/FsKauayMNTCXX3XL59QspihaYYocW+1v6
 9jK3iO1Kr580Q8gpN7azZytKImccChMnFED5083ogvYE55pPEP8ZbxmGsXvwVnuCX2WoRUiXQtD
 PARKAWuIfwN49trvQgYnVdUZbNJfWhkqOqIjmxL9gYZqHDK/5ll2d8YYSI1wbFg7lhbC6tXPj/c
 1Zq3qmcsq0SnKw4DbkLkZPdLNGeAy1igJ99X71cmLMDR9GiLNgMNGAkrwDeKeZAUhMbV/K
X-Received: by 2002:ac8:6112:0:b0:51a:f94e:ce51 with SMTP id
 d75a77b69052e-51cbf1fb386mr1548881cf.50.1783709750657; 
 Fri, 10 Jul 2026 11:55:50 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51caace31a4sm22925021cf.12.2026.07.10.11.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:55:50 -0700 (PDT)
Date: Fri, 10 Jul 2026 14:55:45 -0400
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
Subject: Re: [PATCH 06/30] mm/rmap: parameterise vma_interval_tree_*() by
 address_space
Message-ID: <alFAMZNiJvxNpzGF@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <43050b10b53cdfc3627440e6b14ae2a9730b2a5c.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43050b10b53cdfc3627440e6b14ae2a9730b2a5c.1782735110.git.ljs@kernel.org>
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

On Mon, Jun 29, 2026 at 01:23:17PM +0100, Lorenzo Stoakes wrote:
> The file-backed mapping interval tree functions vma_interval_tree_*()
> accept a raw rb_root_cached pointer to determine the tree in which they are
> operating.
> 
> However, in each case, this is always associated with an address_space data
> type.
> 
> So simply pass a pointer to that instead to simplify the code, and more
> clearly differentiate between these operations and those concerning
> anonymous mappings.
> 
> While we're here, make the generated interval tree functions static as they
> do not need to be used externally (any previously existing external users
> have now been removed).
> 
> We also rename VMA parameters from 'node' to 'vma' as calling this a node
> is simply confusing, update the input index types to pgoff_t since they
> reference page offsets and rename the parameters to pgoff_start and
> pgoff_last.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

nice

Reviewed-by: Gregory Price <gourry@gourry.net>

