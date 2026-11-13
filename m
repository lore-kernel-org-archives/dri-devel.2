Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6141606A33A
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DloUjEwQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEF861127DD;
	Fri, 13 Nov 2026 20:56:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB3341127CD;
 Fri, 13 Nov 2026 20:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794603382; x=1826139382;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=AXSAbZ4zAFhDA0DT3gf9mQz9cKPQmAWHCdFOgQ2qISo=;
 b=DloUjEwQkAB1+LTtUzN22ikfEp53HoYTHUJrVeY2EEXC5xD0etjSS908
 PwU2EGPofvujXEY8eujhXqLyDXAxLdHG+f3sPaMg2noNuvhgiFOP9n1f5
 hLPuXVVAfWiCjWuNpd2aNtcwnkC1K45JxLr02kaahTG3SvRxROtdSz7TX
 4w9noKZ2Q6AXLXKn/Uv5dzFFUyzcqLW/5Iuilqaf0xDvsMc3D6cuKWegX
 qT+CJyLkTcUEMSgJyFk0uhp1P/H60WriblwWGr/c547njqQ7YeP2IPf6o
 Xw5KVmRe35vB8Lx6AmdOnir5xKBoUTxl5Tp1Rt9cYM9yVobE8LJeLoGDJ w==;
X-CSE-ConnectionGUID: tXVJ2KJxRrmD1q7HjTEpgQ==
X-CSE-MsgGUID: bjPFkGHWTDSkNM5jsIrmOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3312227"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3312227"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 12:56:22 -0800
X-CSE-ConnectionGUID: MxmC/jBhRhOduSE8W+FTjQ==
X-CSE-MsgGUID: CSNAP3JdQu+WpkyRp59/Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9029453"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO [10.245.244.252])
 ([10.245.244.252])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 12:56:18 -0800
Message-ID: <0b794f803517c27ea818a2e894761095300b4da4.camel@linux.intel.com>
Subject: Re: [PATCH] mm/hmm: skip NUMA balancing on protnone faults
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, Matthew Auld
 <matthew.auld@intel.com>, linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, Matthew
 Brost <matthew.brost@intel.com>, Mika =?ISO-8859-1?Q?Penttil=E4?=
 <mpenttil@redhat.com>,  Leon Romanovsky	 <leon@kernel.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, John Hubbard	 <jhubbard@nvidia.com>
Date: Fri, 13 Nov 2026 21:56:15 +0100
In-Reply-To: <9ec3e8b9-064a-47a7-8d00-566ff371b846@kernel.org>
References: <20261112-numa-v1-1-ad9cbca8f49a@intel.com>
 <b32fb02a-68b4-4db9-83dd-254147dbf215@kernel.org>
 <1993e931e6a4b0cda5c04e72b1a8d5fb924f950a.camel@linux.intel.com>
 <9ec3e8b9-064a-47a7-8d00-566ff371b846@kernel.org>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 2026-11-13 at 21:43 +0100, David Hildenbrand (Arm) wrote:
> On 11/13/26 21:34, Thomas Hellstr=C3=B6m wrote:
> > Hi, David
> >=20
> > On Fri, 2026-11-13 at 19:27 +0100, David Hildenbrand (Arm) wrote:
> > > On 11/13/26 17:25, Matthew Auld wrote:
> > > > When automatic NUMA balancing marks a PTE or PMD as protnone
> > > > (PAGE_NONE), hmm_pte_need_fault() requests a fault to restore
> > > > access
> > > > permissions, including _PAGE_RW when write access is needed.
> > > >=20
> > > > Calling handle_mm_fault() from hmm_do_fault() currently
> > > > triggers
> > > > NUMA
> > > > balancing in do_numa_page() and do_huge_pmd_numa_page(). When
> > > > hmm_range_fault() runs from a device driver or kworker context
> > > > (such as
> > > > a GPU SVM or userptr rebind worker), folios get migrated toward
> > > > the
> > > > CPU
> > > > node executing the remote fault.
> > > >=20
> > > > Also, each folio migration invokes try_to_migrate_one() ->
> > > > mmu_notifier_invalidate_range_start(), which invalidates the
> > > > caller's mmu_interval_notifier while holding mmap_lock. That
> > > > causes
> > > > hmm_range_fault() to abort with -EBUSY after every 2 MiB PMD
> > > > and
> > > > exhaust
> > > > its retry timeout on large buffers, which has been observed
> > > > with
> > > > large
> > > > imported Xe userptr buffers.
> > > >=20
> > > > Add FAULT_FLAG_NO_NUMA and set it in hmm_do_fault() so protnone
> > > > entries
> > > > restore PTE/PMD permissions in-place without performing NUMA
> > > > balancing,
> > > > matching GUP's default !FOLL_HONOR_NUMA_FAULT behaviour.
> > >=20
> > > Ehm, that's not how it works.
> > >=20
> > > GUP will not trigger a "special" fault and will try not
> > > triggering a
> > > fault and
> > > not restore permissions.
> > >=20
> > > It will try continuing, leaving the protnone pte as it is.
> > >=20
> > > See gup_can_follow_protnone().
> > >=20
> > > For read-only access that should always work.
> > >=20
> > > For write-access we always trigger an ordinary fault and do NUMA
> > > migration etc.
> > >=20
> > >=20
> > > So FAULT_FLAG_NO_NUMA is doing something completely different and
> > > I
> > > don't agree
> > > with it.
> > >=20
> >=20
> > There are two major problems with the current behaviour.
> >=20
> > 1) The work item executing hmm_range_fault() might have no affinity
> > at
> > all to the GPU about to access the memory.
> >=20
> > 2) If migration happens, then hmm_range_fault() will stop and retry
> > leading to excessive execution time.
> >=20
> > While perhaps Matt's commit message doesn't correctly describe the
> > GUP
> > behaviour, do you have any alternative suggestion than to avoid
> > migration in this case? I think it's a reasonable idea given the
> > problems with the current code?
>=20
> Adding fault reasons that hack around NUMA hinting such that a actual
> CPU
> accessing it later will not trigger ... NUMA hinting?
>=20
> I might be missing the "reasonable" in here :P

Wouldn't the net effect be that content stays put instead of being
migrated? In both cases a later CPU access will not trigger NUMA
hinting except that the proposed change doesn't send content to an
irrelevant node?

>=20
> I recall that John (cc) kept saying "GPUs and NUMA balancing is
> inherently
> incompatible, you have to disable NUMA balancing".

Perhaps we could force hmm_range_fault() to run on the node closest to
the GPU. Then at least the migration might be beneficial.

>=20
> You could likely implement something similar to GUP, where you would
> allow for
> bypassing protnone for reading.

We could ofc look at that. Might help in some cases.

Thanks,
Thomas


>=20
> That wouldn't give you access to the writing side. There might be
> ways to sort
> out some of the writing (similar to FOLL_FORCE handling in GUP), but
> I'd rather
> not go down that path. KVM also doesn't seem to need that.
