Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B7EC44508
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE98C10F7D0;
	Fri, 10 Jul 2026 07:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="R6wfsEdq";
	dkim-atps=neutral
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B9FC10E6B7
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 15:49:59 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-920f33347f5so108284185a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783612198; x=1784216998; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jHzvbYEg0XlBnUnrRe2UmAXaT3jquo9NtkCgPzQ6hGk=;
 b=R6wfsEdq3JkYfjMKOBOSwodQFWmK3DclxROdvTWrZX0uwk09ln7ZbVwKSgfUR7yGQW
 NVkXEKY1IR2bLe4oD3aaOF9lhtskJPtjeFEFhgEGDADdblT9pw9gJqMXxo8sQZfmt57u
 LIZyMXCOdZL+91Wd6IBhgWcXKGmes+yjZc3yz2E9E9j1ssPjq89vhjwL4QlmcmA9htEy
 jkY9MJZExxBSqDSRIxoSLdMw2YNP9ey1z7tgkrOGpXUvTiJHI9jttZtFPcBSi31uNF9U
 y5pBt3z17MfrR/bUpVC5e0wcL8WabNSsOJXdujBFOVAYB5fkMBPKRHL4PlHP4eykg1Wp
 8V2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783612198; x=1784216998;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jHzvbYEg0XlBnUnrRe2UmAXaT3jquo9NtkCgPzQ6hGk=;
 b=mp9n6IClmd8/VWRtLDZjw1XYlTygaZULgU0ZjHH9PiJylIAapdqzokQzwygDFB38bh
 3QmNm90Cu7Oul2ZEWT3EDd0ZIE5JgzWJyKigegNPrd+0TlC+3j37xbq95BbavIyJC8gF
 TnjG5ipLE06wjokyxro6dkfys/TK/pJlsMZdMVJLFH236eTqQaHZdgsx86+EFxFlJWfH
 M/NTFYYmd7xMK13poVy2mkAeGGhAnNc4YOBPW+3UY1XWERtVOWZAqvKaRj/mI9KUYpgM
 qdg/3y0BsdJUNCah94UhyREWMwoN3UadsGYf/0sJaUwfuU/nwIbWUpsagZ8G7rMoRAjT
 iPfQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rook137+AfBmVQMzAtRkxM/naG/mSZQAxO4RixmPSlEFxeSj5zF1NoB3ueggOR8WdrZv2ljMnl21/s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyARvaJq8MEFZfSDe48UghE3lSdBwni/MwNfHnau7p1MITAr+jL
 wURueqFK1dDhAp6RReWQwnQvE2OwuXUATt2y7cfKE6Svuk8w+D7Ptd4f7uXPOz9FUdQ=
X-Gm-Gg: AfdE7ckoRCXtL1lYgPHYSwTyXj4ok7/DIzFFW6pm/maxSqeO/Kom825Qn3ptWF24y0h
 Rp52bebvNX+/oIET0WNprQlkT0Awx7CUiDDs0c10apQGHw/78Pu+R7Zcwq/Whi4ax/BuL4Cpoy1
 PGBdzBVj/OmEj5u+iGvSjxog0yqK1zCTR/HSaZ0XgsF9O9U7HqWnCGK989nSqQ9xl8uYhoUgdDp
 r4UMGml6rc+FnjwJTob5fa6cIOES8Io+tdn2+fLmEjdZJJw3+80VLLrGdXJifEyp034Ki/QUVPn
 kEqtdd9UMa9DEKgifDMGZap/n5Csbzo1Wi83dzmA9MhazlXJ0hfDMGAqm3oBp0xeD4qs3o6gQMe
 wbgGLeDHsQEn+R9/cLayzpKBTVZpWQbQHJ05UNK0LH5ilYK5TLXqh2cvZXkmkkSt9rn4mUjPn/v
 ny6eqtpCutKxTcId+Lb11ZRguqHl5pvPm9zNtMpChAomeXZKIz8r067VxKUw1AGPqtfuad
X-Received: by 2002:a05:620a:8017:b0:92e:c116:bf0d with SMTP id
 af79cd13be357-92ecf95dd8dmr807949685a.86.1783612198042; 
 Thu, 09 Jul 2026 08:49:58 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90cbe3e2sm1689967885a.35.2026.07.09.08.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 08:49:56 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:49:51 -0400
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
Subject: Re: [PATCH 17/30] mm: prefer vma_[start,end]_pgoff() to
 vma->vm_pgoff in kernel/
Message-ID: <ak_DHzxSA73zWkGN@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <ea87349d63205bf4c26ea79854f179a9bf8cfb0b.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea87349d63205bf4c26ea79854f179a9bf8cfb0b.1782735110.git.ljs@kernel.org>
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

On Mon, Jun 29, 2026 at 01:23:28PM +0100, Lorenzo Stoakes wrote:
> Be consistent in using vma_start_pgoff() and vma_end_pgoff(), which clearly
> indicates which part of the VMA the page offset refers to and aids
> greppability.
> 
> This is part of a broader series laying the ground to provide a virtual
> page offset for MAP_PRIVATE-file backed anon folios.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

