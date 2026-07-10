Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B510C44506
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3314310E7E8;
	Mon, 13 Jul 2026 07:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="rSADkGyK";
	dkim-atps=neutral
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBBD810E1FB
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 21:24:11 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-8f1a8e914a9so11790116d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 14:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783718651; x=1784323451; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hyoj4hjMSeCH2l8wiR4N5JqU7D2zu2bS+BNg0w05A5I=;
 b=rSADkGyKvkzdYIenr2BHpgo1vn2+lezPASmXCLaosCY1kyRy79ziE/k8RFFHNXmYP0
 1NZMJMBTcOBzeJPbiwXlT7NJhZA+tXS0aD4U7nhNYt3By91Ikp2zD9Cf59wo2qNkc+4k
 7rkmexSL3TuTdg8l1FkwjfsZCP4jITsTuVxZ2hQHuRzEjWZDXlxLK5kNr1vc+Ei+qi8S
 GuykMq63H8cD5ygDwmrg/+jzIQtasAd49Icu62GvogvzhUbzUaJP1cg+U9g+ufRAlPXH
 HL+j51bpwX9HvjlMrzVs8nVgzxUL90vVYuSAn8bd7LUTYSBj5cM1PfSRLpg6cBzLho9N
 6i2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783718651; x=1784323451;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hyoj4hjMSeCH2l8wiR4N5JqU7D2zu2bS+BNg0w05A5I=;
 b=KsADU4laBcbYrh3CG+WRKDDNBTFBc30691ti9GOzPsI4olOO0gNETMsMNcuLTyW1M2
 AxbZsiJLtybx2z9yvTZ3Av/R8QJdhRzb5PO/G8WohxIDNGjfIDkxCsP4dquDSiPoRiXd
 UJMhOo6h6W5HV9fNtBr2VeWUNB9daV0b7hhiWqaFNuRRF/CCvcGYFAUZTXVksrOVOwvN
 6yUSpNqtu8gAel4mtQq+h7b5kF8U5vtk6nI4CilANw5exZRIddn+7BEve6v8GNhDf6ax
 JwY3c4osi3Fb1YSKUIbgPD5rvY7+2gv3OMM/mZNWlPlbEwCjxlbr40Qd9+5E3R6u3coe
 RleA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpfBopAuBMrFsRhlpujFkRJrp4sb/FyiHnommu+8ffuOlEYEXJVuPyd1HHvaC2TLKcOLI7FbpGmSiA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy/qLIK2oIAuzPjCr8fh0Dz643NdVxokVKkRIKcnyLBScauHJdd
 xr34gCPpkhXMDLslTIH6h8WY7r08cYKGco1dNGylTqTFpVnM1p5FJoR1VoyQvIPmd8c=
X-Gm-Gg: AfdE7cmVUqLCMfOjaRfRbJ4CzBTPRreteXXzpdrTfP1n4pki4XftlO7KoJfpomLeejZ
 YmhVCO2NQ9sNeErEhlgJD1pppQVQzdu7HTSXa8hXijXnqHLsSeHV6LU0qC948ynrEGESIO4Vepy
 wvoeI2bKqxAq12korUdlMiqO+fpIbwfxiuzd6iL9+8lCDrhMH7hGZas7hPTVHEraTErgax7ZnxV
 dLBXlE3ayGwvcqTT0ib/vU8Q88+4Zc3ik/+wfXhBwJlHB7ujEmlsx9Hjajj8RsMtfP0w/gLSIT5
 cPNcKG8CB1SSKWJQjCZWkeCY1MAFv1aS8OS1kiZVL6FVdX9uHR8tyjlIYrSxgkJN82NsEE6wGD4
 zAPDLjwMUie8PKYf1qxI0Ed7x/wNpZHWsT4VAdVaRtUZ6bc/fntnz9jHkhunTzIb6E4+AkmlRqq
 heixXxH3+LGwoHAZ8LecsyAmFjmHixTNPwR/FJ/YfFMO6RJNHN8n38hrm4Nq+ZfjgUrFtE
X-Received: by 2002:a05:6214:5b10:b0:901:730f:5eab with SMTP id
 6a1803df08f44-9040038208amr9843886d6.27.1783718650605; 
 Fri, 10 Jul 2026 14:24:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd82e9d5csm50431486d6.41.2026.07.10.14.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:24:09 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:24:03 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
 Lance Yang <lance.yang@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
 Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>,
 Simon Schuster <schuster.simon@siemens-energy.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Dan Williams <djbw@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>,
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Alex Williamson <alex@shazbot.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
 iommu@lists.linux.dev, kasan-dev@googlegroups.com,
 linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 22/33] mm/vma: introduce vma_assert_can_modify()
Message-ID: <alFi5J3-UQtvTzxV@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-22-2a5aa403d977@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-22-2a5aa403d977@kernel.org>
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

On Fri, Jul 10, 2026 at 09:17:03PM +0100, Lorenzo Stoakes wrote:
> vma_assert_write_locked() and vma_assert_attached() are useful for their
> own purposes, however VMA code absolutely does allow the modification of
> non-write locked VMAs if they are at that point detached (i.e. unreachable
> from anywhere).
> 
> It's therefore useful to be able to assert that a VMA is either
> detached (modification doesn't matter) or write locked (you're explicitly
> locked for modification).
> 
> Therefore introduce vma_assert_can_modify() for this purpose.
> 
> While we're here, make vma_is_attached() available generally - if
> !CONFIG_PER_VMA_LOCK, then there's no sense in which a VMA is
> detached (vma_mark_detached() is a noop), so have this default to true in
> this case.
> 
> Also update VMA userland tests to reflect this change, correcting the
> previously open-coded vma_assert_[attached,detached]() there.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>
