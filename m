Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A80C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A213310F41B;
	Thu,  9 Jul 2026 07:26:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="QIUvYrJa";
	dkim-atps=neutral
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54EFB10EE56
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:26:52 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-92e5d6f35c1so379772385a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 09:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783441611; x=1784046411; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3pPJvCom7n6xLJkZnxYC/ipfbqNHo6N+N3CeZviAw0k=;
 b=QIUvYrJarsNiU3Cmvw2mVD9tHe38LnlGElusWKVl/FxjTh8al/zzevMV2UVXHWlVBQ
 uGrIgftKKD7m8EEMLC83AeDXUwtFqkSc+iszk1BDIWpQdw7ITdrkuz7Nbz3kLXaGaZ5V
 YL2js4N3DzAMelLhmaD2eveb+be0Vukmh/VTtdXmMuvvsbZehSJ0krM/O12uJIltBi2p
 Xq73rIIpRb/V9mcFvIxmQ3d1111eI6Fu4fPGaxLemFMevmJc1JZvIFI6DWK14avu+nUR
 ZB0zfzXi+S8c/fSlLzbxAkzcejRunOZqx/FUOZ66KAzTeZC2Z1Y0fo6CE0YcupBwvwwp
 iFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783441611; x=1784046411;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3pPJvCom7n6xLJkZnxYC/ipfbqNHo6N+N3CeZviAw0k=;
 b=VcGEDylL6JBGYbTfhcDXvvDAtyfkZTHzSnkG8dJI1NNO9GgZCjYJds2KhtYlCb74Q3
 7s2XZARnjAAshBqDNFqZYLjfC7MQkplwSla5JPpxgkC08TKu/lze7s0vcX4z50J4jrF/
 NKqH8IPeNMs4x2KfUo+bW7iwmxWnMQcOFADEY740EawRRvej0N9DE3sN9ziw8PvinuV9
 untRymoiqD27rONjx1AAZJ87BHa7WLMH+OBvkE68Nxs+ztd6p6Ah5WvJ6hkVbQEmddJL
 mzprKQWJEDFlzCLbjOyrx2k2Piqkjdd8biMPsxVhSys1YrFQ633m4//DvHPogxVzGZlR
 01Hw==
X-Forwarded-Encrypted: i=1;
 AHgh+RphBZVoXpsOyw41Mo3oulBkNbLJv70QCsTJeyRQzc8k+hrZgkJvLV6kAr/6+IS8cMtvuLYz/dIzY/c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgE3O+hJAUzVPGLuuuFAGaovecIx0XB5QtOXsmzhi0n1raoQgo
 GB/k2wLl6xaLA8zu5uPkzawM1IyhLSOmCKUyYVc3+Vjs7FIxg59xsJ1GwRMn5STTE8A=
X-Gm-Gg: AfdE7ckGfYtbBU/rBZ2njTkquajMmnTTZj69rHWYp4IsYSzx6F/00tBR4gHlmH1c1P3
 Mqwk/pzuyVaaL6vQXdQNAHZNTKtQ9RuCf6s3FG3ZCK/T+94vamaWbgwkFiYlm2qbyav7Ltj3JOE
 POZCDos8AmUN3f9cFcqBZ6z3cc0aHmXxBt9WfTJFUsvUac73bCr49ZgzUgvrLA+RgGjEOCfW0me
 wGetoKzjRoyL4i8CfIoxEhw5w7e/OjT2TO/AOLBn+YysEpBv7mlnQSMoNPONInBNx7v/xi0qdPF
 bspck0cUPGv89yGC2U66wI/OzzObe8tXs4Xq1+n+A+zNrA60lSaU0wDRNNuN2E8pxmHUa84LpGn
 vYsjrFTCDRtZ9Zn0Pb+0+qPMrJ5pGx0IbLKFQIs+5y5/YvvAV4bHMBOzsXfYkanLHcDgXFBI+Aq
 5EsNhnAHDuc+YQmhlEK7QTnGh8iLigYM0UecITkSJEzM3QGH/3sLQwl9bH6rSSn6Iy+jNRiMZg8
 HqY6is=
X-Received: by 2002:a05:620a:a807:b0:92e:c118:18b9 with SMTP id
 af79cd13be357-92ec1181fa1mr324497185a.88.1783441610850; 
 Tue, 07 Jul 2026 09:26:50 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90ba41fesm1231337385a.17.2026.07.07.09.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 09:26:49 -0700 (PDT)
Date: Tue, 7 Jul 2026 12:26:43 -0400
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
Subject: Re: [PATCH 12/30] mm/vma: clean up anon_vma_compatible()
Message-ID: <ak0owyNkHX6mw4pe@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <5a7a07bd2a774989849b0fea84f758059ed914df.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a7a07bd2a774989849b0fea84f758059ed914df.1782735110.git.ljs@kernel.org>
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

On Mon, Jun 29, 2026 at 01:23:23PM +0100, Lorenzo Stoakes wrote:
> Break up the existing very large conditional, add comments and use
> vma_[start/end]_pgoff() to make clearer what we're doing here.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>
