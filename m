Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908C0C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 00:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E30CA10E3EA;
	Thu,  9 Jul 2026 00:06:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="JHUGKh6l";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA2C910E3EA
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 00:06:05 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2c9b1edf2bdso18776115ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 17:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783555565; cv=none;
 d=google.com; s=arc-20260327;
 b=LciRZV73Yo0NdakoTVSMULzRJqlajtbTKjftp4gQAK7ZGNhJeWCsltqGUH5NvdCPP7
 V/NpaMuJ5cOxIydNMjNDly3gGOjGh70UCuOtUUxpl1V6e90zbwdSUNTPDvCsYQwhGWY9
 15+/0/HcZsstoHCq9FT0mChrXjxMW4E2bdipy3jjIMiANfYg2MKstnWonietgqmeUABa
 nbNECBlSWmEstAvh9OzMhlqjgHbQ2t6xld5gM1ZR9misxOGdHrIdV96T5fwFO4iIEP1Z
 e5kKaHILsh9CqohMoV+N2W9hAMleIXqKuSEz0kX079Wk1TtlJ5/UxmvJDnocjtPpfLm1
 xScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=yJaHiIAKdt59/nUs88AHXAG1seHCynr9U+jmRjUBOEg=;
 fh=B7qG4ts/dDgiSFZJkWnx056h7GyZxg4CZuA38yrsKnw=;
 b=izqjZJKpR75Aphe/M7IpRzhqQ7V+Xelpn4l5zaP3T4A1RJDAWn+UaAM+/Q1Mr4RppV
 HYSR9KPThDfJ4EaCUibeQEYFEYqhdqHvEodSQYzx4WpKrusQh5XSySk64KFms+ZqaC5Z
 6iY75phl5VWNQJ6pzMyOM5MYssguWljroR1UEjgTbRcpTPl7S5SIIJd0KSEWjfPxonBB
 4botwfjG54OZc5gs8p4HQuRw+/bgN6D2nJL1evIYxztv8/cuH/+XZEwNMpmWzqXNqMLA
 g7zY60UYZBVAcrUe3AREHtD618t8p0TsHt4ZG4Q2PZAcy+PXAokp9CqmGdTBoZJpaOru
 OkcQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783555565; x=1784160365;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yJaHiIAKdt59/nUs88AHXAG1seHCynr9U+jmRjUBOEg=;
 b=JHUGKh6l1tyjvH2YK+JF+BdWqG9cgOzmKiq/j97195/fr1XSgxqBSJuC8brtq4EsrJ
 RbQCHMf+aOU1TKF+XTHMcVSh7vR3jj8T9tPBLUmvXLOsQbc5yyJrJ4RC1mX7x5L0gXVG
 CbFHHA8OkrKl3KnybYggM6sjMX0LL40H/5aA/46388+IXzsQ8OPWddvLZifvKKLV5VLb
 iZ0IPbNrYQNieS9oCZ0PvqQSTqO9YTyNeGSV1kbBPGDYqzVJLqzI7cq72anNYFEhYBQv
 tan03gN2Z59Ejf7EBPtpdi+5q3r5uVutD+CpQ6rjwHOSLAT4U+zULT3ThWD3pqxuTilq
 gY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783555565; x=1784160365;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yJaHiIAKdt59/nUs88AHXAG1seHCynr9U+jmRjUBOEg=;
 b=iWNYbyqkmsg80fQNx9990wF7pQpse0ZbEnlR7taQ20duIvQ9EfmQMytyizjXWUXoLB
 TfODVU/KVHGNbcHDO2ZQEwqjEG1iGFsHfA1PrbFCwKkK5rjZu76z3jqrCYvYVf40uPjy
 4puht3i0N1Qrw+kBNgEahHEzaNKbIjTVH6pf1dVtReOpjkwjNLNxSbYi4hEy67TsHg3p
 ahO0BCOcT+UEY6C2dUWg0ccUwk5ax02k1keRY4JjBuM4mKdEZvgVhrXgkSJTdbTMfA9g
 eAIIiKSEzYO2FMiQR3maOYTESoWW7Njsjsqlzj2CigJgFCH+SwzTygbmnQt3WF7iX1G2
 mA1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNtZwig5NQVuagyhSdHyws4b51D5nEJEZW8r8LOEy2/vjd50E+os0Vdza1azdDklr+xvOQ2T8MFpg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZIB1Msx+kSQxZRcQm9paXkh7eQJWV+m2fcYKwo11/r0Rbj4vk
 CDEF9l8VayFEEakCxG7BZqhswwVVPQ2ZGrmfJ+jaX4L+Fi3kWuDQCDu3X9cc4TVLGEAjVOCwf5g
 LZepUetO+HtQ6CDvZ2E/3gml2L364ZqsS38CX06fG
X-Gm-Gg: AfdE7cnxr9Jnx90Czsf4OlurESwHtuduvQeLryw7wfTUxOSxfc5/6R0bMOldIw7X+y7
 +2AcT9yOrvlI1Yt5mb4RAbE194dy/0jntH8EJHdTkcop4GEQWQ4qpIBrHCKPexaqP9xnX23tNmp
 W3k0cG/rLDIwF6y5r/G/h7j9lLwTenipDe8xVcAqQ24kvxDyMhsXDctLQlJF8HFFICBcwYs9Zo9
 kY/c2hCt2V9GwrbMocyYY+tRnne5FBPmOcerdYJ0l+j/0K3e55glghssjbFmQ4x0zBSoKS3X9cT
 zl/Xn9drX3E/NX2BpDS+sqsp5teeLkzPQ6b08GFzCoOQSAVg6BtL8Nt83JnfllLviMPKQA==
X-Received: by 2002:a05:6a21:7482:b0:3b4:669c:ee32 with SMTP id
 adf61e73a8af0-3c0bcbc1353mr5760887637.37.1783555564841; Wed, 08 Jul 2026
 17:06:04 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 17:06:04 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 17:06:03 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <eedf589778aaab33e6df2ad6556dcde536e13460.1782735110.git.ljs@kernel.org>
References: <cover.1782735110.git.ljs@kernel.org>
 <eedf589778aaab33e6df2ad6556dcde536e13460.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Date: Wed, 8 Jul 2026 17:06:03 -0700
X-Gm-Features: AVVi8Ceg-PSWltTScKU18ZF0mdbBsNHDv0s-VKhIaqzjwQ-q80D6zfZMKk_VWII
Message-ID: <CAEvNRgE-JJAzC0jp+bY8+e1+gYSH+MjT6JqX_DfCcpaxOM-Dtw@mail.gmail.com>
Subject: Re: [PATCH 15/30] mm: introduce and use linear_page_delta()
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

> It's often useful to obtain the number of pages a given address lies at
> within a VMA.
>
> Add linear_page_delta() to determine this and update linear_page_index() to
> make use of it.
>
> Add comments to describe both linear_page_delta() and linear_page_index().
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>
> [...snip...]
>
