Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00ECBC44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E58C10F7BC;
	Fri, 10 Jul 2026 07:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="QpmG+eEn";
	dkim-atps=neutral
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2898310E09C
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 15:49:27 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-8eefd0c5f59so329376d6.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 08:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783612166; x=1784216966; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hryUWYzOZzjuIh9gJx+Hzg+n+E360+tJZh4R7BZGeLA=;
 b=QpmG+eEndcBezbydrBIeugJzqosCVwCwJYo3Bsd1rUIoifBWwyb5Wmqbpumb9deb8C
 txDbN68Yv2Sm0pNptuVjU9i2OMQB5z6JU7wJZw4n5jvcxU5UEgO0rWHuPhv6pTGWA/PP
 yC74rhmZ6pMhMLNs/MnIH+HuJUlqz23V1A7cPpEVPntcvmoopZj7o3H43LuhPQK0xtjR
 imZAPsmTNHSShi36TuGlbfK56TEH9Sqa/G5JJ1Bb/0ZHVFzo6w/HJLsMFB3GoLWzuPVU
 kPMfDvv/x/DgW1ahdIHasVia1f5EU8qcpqg9OYe52bd7LDpELOtAFzkcmqqILGZnRQUi
 /Mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783612166; x=1784216966;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hryUWYzOZzjuIh9gJx+Hzg+n+E360+tJZh4R7BZGeLA=;
 b=k7G99PkMrC9TRLGroIIlafcI8lv1R9qCR8lGop3BCenuGqWjXaC4fy0yF2M+Sw0WQv
 i5NjmE7gj3zXjbZpuLaRj4a5WTI2mTJDNCc1527Y1Qm2US+iwq7Mo1TODe+Nb73Y7U1R
 EW++7j1b0eYinn90UEA3IMsEl9l+tVOteOFyddOgFHUao3mSG7/3dCARCkOlhCNB3ilj
 3ZEPaY98Ja2m2wZr7bmp3WTr709xK9YIZGOtrSkcdxGB/N/m4vMumdTE+7xhQb9ovIuP
 1R6MomApIQm/Q1SeuPyUV9Boo2jbSz9PbiUJzLCs28sWtrOklrILzOopiavnX8PpSpC+
 b9iA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqhjfQFXwXjLZ47mUDXPt7nqHY2jzhLHJU/myz4VnVaC17Q8LqKmu2Zu9yjza4L490mmuIOLOFY47A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykHwlbLaVd0hKjOYHELMb2/c+NhPx7DGX13yp/b9xNhezZRd7H
 DvJGqGvprFfTyQ1l5ywjXRMuNCeof2HGxuN/P71GzyaB6Cd/anvSp1PHgINa8uhwbyc=
X-Gm-Gg: AfdE7cmNDrhJakf5VB7oz/IeFIC5zb+oR5FM8KI/Kgmv48ibev2TmcylbhTeN9g5DtQ
 W4/kRFeimq+C4PJpbJWXLWHbu/CohY+J6FC+9agNmdGf4yvhDQlbc1O9J/TqLbZLskY3iboV1w8
 oLOm8v6Vf/387PkCjX20Yt0PCVHnt119+Wox/8e5oy249aTmD9+eFB0c8rGMs2Y5zmQA/efhO4L
 Tl4Vaetigw3dCmgF1vend1pJy16gbQT4mkwcERP7qth2Y4RLVveD0iuLXZFTGrVOk8WRsTQyXja
 Ux44GfK06ZmCBxkvg0x5sO1eTCAV7rzaPpaflv1EGLx6BmmhoSTLD1ggYoo7f//S8YLxIDtJMVb
 bi4nlvGp0kAkxEeSOpRl/SGwS9sVP3pKYLfIgYU85pXIQ5GLBeK95UL4MSaCInFQZ9yxShdgzLG
 Kz7F0Q/F69HHK+9FPm6PzYKsAp6YbV1b2t7QzREfCNylvWRqtbFard1+0tGdqBqwh3NdWg
X-Received: by 2002:ad4:5c8a:0:b0:8cc:2a92:48e4 with SMTP id
 6a1803df08f44-8fec217b8bfmr87997286d6.32.1783612165998; 
 Thu, 09 Jul 2026 08:49:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd7c1d9f6sm20164456d6.23.2026.07.09.08.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 08:49:24 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:49:18 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
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
 damon@lists.linux.dev, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH 17/30] mm: prefer vma_[start,end]_pgoff() to
 vma->vm_pgoff in kernel/
Message-ID: <ak_C_o2ehS17Q5HV@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <ea87349d63205bf4c26ea79854f179a9bf8cfb0b.1782735110.git.ljs@kernel.org>
 <akZCg73F-oGzDp1a@pedro-suse.lan> <akZGqclqQ6gS12Vv@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akZGqclqQ6gS12Vv@lucifer>
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

On Thu, Jul 02, 2026 at 12:30:59PM +0100, Lorenzo Stoakes wrote:
> 
...
> static inline unsigned long vma_offset(const struct vm_area_struct *vma,
> 				       const unsigned long address)
> {
> 	/* Retains page offset and tags. */
> 	return address - vma->vm_start;
> }
> 
...
> And I'm not sure it's really all that useful. Perhaps retaining vma_offset()
> would be though.
> 

Silly question:

   What's the purpose of retaining tags in a non-address value?

That sounds like there's fragility just waiting to be broken.

(I presume you are talking about things like ARM MTE and such, right?)

> This is one that I think makes more sense.
> 
> But in general, I'd rather hold off from yet more churn here.
> 
> I'm making these changes to establish a basis for virtual page offsets
> introduced in [0], rather than just cleaning up in general.
> 

I agree with this.  If the refactors here suddenly have to think about
corner cases on things like tags, that's better resolved separately.

~Gregory
