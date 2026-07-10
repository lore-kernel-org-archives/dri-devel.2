Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9122DC44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80D3010E7F3;
	Mon, 13 Jul 2026 07:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="iLqqgFZG";
	dkim-atps=neutral
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3213610E1FB
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 21:14:10 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-92e855da580so110738285a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 14:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783718049; x=1784322849; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gpMGBsh9fToTErr7i3jlVPE4gbDMnqxhA+rLBjZ5wi0=;
 b=iLqqgFZGf6hL4r0aM8c2btJWkAuByAQOX1SlTmW/a8iyJiMscaFS2N1Lkys3lw/1gJ
 HcevhuTGHrJ/EhnaUUPDMOWID6FpXXhpwLrI+yi/43UYhxKRhQlVIzXirzqRovY+1Pk+
 Tf10wQOd/wpjr5QaD5mdzXQvDeHI9AnNMlqYyHKmc8aNcfdXCt0b0koxip5HRI7BIXOH
 CmxVqvN2WoeCmMou17vD83PIpa5vbRORFCye94g+UcKs98qkbiwK7+/XFEsHgC1M4A7J
 SpwnJt2d8dggwtEQIQkxRQSoA+0N2FyxZ5pmNTCY/tN8mgP07CLRbj/9O4qoBIVQJ3NW
 EaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783718049; x=1784322849;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gpMGBsh9fToTErr7i3jlVPE4gbDMnqxhA+rLBjZ5wi0=;
 b=QfraoPIXWD8gB7uFfqsAapKpLHLfV3Vno1OVtnlNSz8Uht1wFeSOWfXmsCMFVg2xtu
 y9Oo4Livm6W7rZG1YWphUJqGMR36YRqnaXXYstNgAm4500VgwGjyhOfmX8eCa0T4L+Ox
 HrZFEBpgeq+07EaVl4FoAYRP2EGXSLTEJoMBoc1LNYhFLsecD5i7ttZp7x25/YY7a7xi
 eax54r4UHK3Hgj0Hk+kroeKFoj4Ayq5OYXJY9MN/QJrx5NteupWDZjJpymwOTtJ9CHpq
 AVS+f2MWWHp7cGlTILeXW4ZkOdbXFPps/rf11DG1PFq7UhhbLP/OfS4ZgnqaS2VuniHx
 8ebQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RphA3Il06Wikf+YZyq5URAC6nMgmpOOkCCoo2Vdl9G2Sbc1VTJGoLC9f/l9Z8YDzfeCaIiF15Vz714=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzho7pPgUcR7ziP1w+l9PLNEXtHXL3G7Uiu44ejt5TdLPOllKY+
 aaUH5sMSgQwJstKktDL1JbukJY7MowSXfHFVpH5LHrnO4ZkE8WgZw+uYwuyG4tEDqjM=
X-Gm-Gg: AfdE7cmaFz8K7veHzRFcZdDuo2J/hF/TrZ1m/XZWxJA/f63os1lKnWww9y0OfA68SD2
 TEFAFdjKP9GzaVVS8PN03Lo3S+vm0nhrP0C0SBUSYWZiQLZ091y1kP+Z0KAGLp3PD80lUmvdFd7
 wFZsnpALJEPeCAJlXK6pQTmxavbDzzsNFNNqrYPVos4xSOU+WocUUv8/LaefEuccDoB5JyPgP8P
 bo7+OttbigooojtyiX6ban3/T5ZlX8bYKLorFkcW/j2m+fFGzS7lDEVIgVmvwRrZ05Na5IBhaxc
 xjWfvQdcaPWYSFGw22rTRoOUiwoy7NPiF2q0GoU7ttp4IuBYA64SDwOanm2fE0XXMsfz3KztEmd
 7EOVoGTl6kf9exRv4t1Q/f5aHuqD4BefcMi93QaKVk0ClhUxUKI7iJxdiNiv171YGVNKeqJcM/D
 kIl5QfayWLnl6u1jKD/r/TUPXsr/zC03Zh/lvGzM7/W98iP6u6ud63bg7EJs3kbYqVPLl9
X-Received: by 2002:a05:620a:458a:b0:92e:c117:9ea2 with SMTP id
 af79cd13be357-92ef2e264b0mr94774285a.80.1783718049159; 
 Fri, 10 Jul 2026 14:14:09 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd50e3083sm50604746d6.6.2026.07.10.14.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:14:08 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:14:03 -0400
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
 Peter Zijlstra <peterz@infradead.org>, Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Alex Williamson <alex@shazbot.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
 iommu@lists.linux.dev, kasan-dev@googlegroups.com,
 linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 10/33] mm/rmap: rename anon_vma_interval_tree_*()
 params and use pgoff_t
Message-ID: <alFgm58E4G7hWIm_@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-10-2a5aa403d977@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-10-2a5aa403d977@kernel.org>
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

On Fri, Jul 10, 2026 at 09:16:51PM +0100, Lorenzo Stoakes wrote:
> Rename parameters used by anon_vma_interval_tree_*() functions: 'node' to
> 'avc', 'start/first' to 'pgoff_start', and 'last' to 'pgoff_last' to make
> clear what is being passed.
> 
> Also, express page offsets in terms of pgoff_t to be consistent.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

