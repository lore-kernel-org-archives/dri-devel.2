Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAB1C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 00:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3F7210EA8E;
	Thu,  9 Jul 2026 00:06:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="t2DHHO8D";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3745F10EA9F
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 00:06:12 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2cc7e86e7aeso13214985ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 17:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783555572; cv=none;
 d=google.com; s=arc-20260327;
 b=Ki4XyIZjkXzqweNdYpqFVjd2PDCuIcPMcAgmBk9m/lPgF0/Cs4vmrlzZQiyYodHTH9
 0/zntK0XmQcpKMCow8DwynUxA/eiaULRgRsS+atZVmRxGI0SYnPdwHX3Y4MoI4yKeR6w
 TWV7W1YlpwE4lvgWeLnLNv3TGlsAdIB8+wxiH2xQ1Z2v6ELLze9EYKTRFzTQ8t+C83Mp
 6NmexTOGc+j4oyt3dtVpV6PRsXEXrX1j6olzoLyAG8xrzx2P3QKZpDggICDi3lI6xr77
 y3yFoZK05+nt0ye8/SOh3kVwxU/dAbtcpoe1nVIIalx+gIjJrMZ7EAipBOoTE6Dbb+JC
 u9lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=LGyVs/ziq+v8OBPSx6ZOv0f1yGdel9dIe8uNrAG5/8g=;
 fh=ypVRd3vDqRkW5FeyekpMFey4TyyFHsTyN9V7sxGKbNE=;
 b=gLd3Pnimyy9QGYyYKxudbTUQLDc71Csm0nLvfHuqC7h1WXr1/F0B2B1ZYhw3fCrPdN
 3lid2I4oWuQnocIGZkcV4wtN/xjo7MlwSJRwsqIzA9NOq1EYWTwFz7aEA09y7sN5ic/4
 8COogKvPsqr/xHyHtHK1eT//c1zzwZeqA0YNAFjvRDWetb04ura7sSWpn702BEYr/l2C
 JnqsT8LsM/P7A24WeQmz1yml2s1WhuV5M77R29vmPrz4fESbxcHrwjHq2RUnNTju0dN8
 CPzVpY0ddU1VgtR4B2ox0OuXnrcvIS9vVE2lnQjsd6ctC4xllfhojYm3fnsad+HQ5+cV
 xBtA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783555572; x=1784160372;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LGyVs/ziq+v8OBPSx6ZOv0f1yGdel9dIe8uNrAG5/8g=;
 b=t2DHHO8DupimZUjgKfPTLD/VtZ84TmjlafW8Ggky4tPP9WRokkNfuXJdtJ/Yd30uEy
 mLssylbjdKS4Oze26SlCSJbjENO54Q3uabh9auBwY+8usTBvKOj+++e7ENkefZ8xJru7
 bcB0PovxMBeUExy0g2/+JIHejbyRdvXXbG4SI/B35QYOJJ7RcsmHV+AihhInO34ctERw
 isymp/AAf6/YYfyGAXddusb75zq0DYOYGhuPZDBVTBPCBbU8pYzUjRFlUt5O7QNOcyTI
 UsK/DQ+AcdXc7lsoDY7o6VAKzkqndpITpxoDufAddG2ERKdUi5fjTdjhb8ryG7cOOBL8
 itBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783555572; x=1784160372;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LGyVs/ziq+v8OBPSx6ZOv0f1yGdel9dIe8uNrAG5/8g=;
 b=hPSxnwdDJLV4RwkS9U5ApuI2XkjUIzNwLClu5T9DHa7lo0k6bWkboS4A0HJg4kgcW9
 GMDD2aj07ioiM0DHFumcBhJqG5UFB22HoKZ/e18TUNooWb4tbPeRzmg4OnrG7HQlp2gT
 51z5oW9hLOAlamWDAt+JJuxYRRKWpnmMSg8bhq1hcb2+0zLL3WefHa+v17IagkcjpTHt
 HytChcggLJ9yotVuLHQlCDp7+dQ2XJRd7tGS7l+kegP3uVqVNNeye29t72n96ond4qjJ
 gsjfQ3mVl8ReSUM3N7r3eufR8cEznEILC1ayc/f0fbPYS3njJJ5pAQ31UGVjDYIWlS1p
 RJHg==
X-Forwarded-Encrypted: i=1;
 AHgh+RryLEfrHULxqeheVpeT8HEocC9NuW/Tkg7DSe49bvxjB+0cxXWgMIGLvZXsLDxA4YGR+RpCt1nkIHk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwxCKdiRLO1oMfypoOA7eb3R5rHLuRwFC4Z/FIkdRvVeDKcVYsU
 Gou9Fd4sEU1pm0k3Z4J0DgWxblKmEx/FJR35JPvb1uTTtxuVqDRu7K/rzPlsKjrngQ6+tihcx+F
 nbV503zhCwB/x9FmW1Cim5YgFD+GfflnQP/u88KtU
X-Gm-Gg: AfdE7ckscYc+VH/etQtv1JNnfSIfy2MgKU89viZiGHEiAXirAPzHEYB2MAY1YhMH6Fp
 szjpPgOxR0CztBoa8wpz/w6aLlR557PCrp3JuLXUvXt0tPPWZLtQ1oUyLQ14FENx1IXPWw5bQ5z
 7UYLfUjXrr+tHfPZd18UqhKivpMP/LmbPe9TheHpsmGxWsE/0nzrlPLdwzRx1Sol4yk/6oV8bpQ
 8dJVDpK5W1I3Ux4J5pT4AiHQ6UcPd9QZwXuXUQK4aTRqd9QGjuHLvFTofYr3FrezskBW7gN+JS7
 G45DKmZUKagCuUSOMTuCLsVWyIRd17Tr5+UDw0rcElfb/PpvOFOcI0KSevg=
X-Received: by 2002:a05:6a21:1f88:b0:3c0:9c19:b27b with SMTP id
 adf61e73a8af0-3c0bcce9940mr4979424637.73.1783555571036; Wed, 08 Jul 2026
 17:06:11 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 17:06:10 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 17:06:09 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <bf56e2e98b512962a2fb88900d535a0e9e6769d8.1782735110.git.ljs@kernel.org>
References: <cover.1782735110.git.ljs@kernel.org>
 <bf56e2e98b512962a2fb88900d535a0e9e6769d8.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Date: Wed, 8 Jul 2026 17:06:09 -0700
X-Gm-Features: AVVi8CdcseowPqFId5ObGoqB8gTqCLO4QEXGH1ZjH1-pjTCLGI84NpwTLe_LrAc
Message-ID: <CAEvNRgEV9VkWHULS4g5hVHu3T6=YZ89HJmkv6rS0+hK=5UFu6Q@mail.gmail.com>
Subject: Re: [PATCH 19/30] mm: use linear_page_[index, delta]() consistently
To: Lorenzo Stoakes <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>, 
 Simon Schuster <schuster.simon@siemens-energy.com>, 
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, 
 Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>, 
 Lucas Stach <l.stach@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
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
 Alex Williamson <alex@shazbot.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Dan Williams <djbw@kernel.org>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 "Liam R . Howlett" <liam@infradead.org>, Matthew Wilcox <willy@infradead.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Peter Zijlstra <peterz@infradead.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>, 
 Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@kernel.org>,
 Kees Cook <kees@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, 
 linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-mm@kvack.org, iommu@lists.linux.dev, linux-perf-users@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
 damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>,
 Rik van Riel <riel@surriel.com>, 
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Lorenzo Stoakes <ljs@kernel.org> writes:

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index db57c5766ab6..f0e5da490866 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -440,7 +440,7 @@ static int kvm_gmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpo
>  static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
>  					     unsigned long addr, pgoff_t *ilx)
>  {
> -	pgoff_t pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> +	pgoff_t pgoff = linear_page_index(vma, addr);
>  	struct inode *inode = file_inode(vma->vm_file);
>
>  	*ilx = inode->i_ino;
> --
> 2.54.0

For the guest_memfd change:

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

Thank you!
