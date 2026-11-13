Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7A0606A337
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Dtim+80K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA9C51127C2;
	Fri, 13 Nov 2026 20:35:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D85CD1127D5;
 Fri, 13 Nov 2026 20:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794602119; x=1826138119;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=ZBde9T5yIFhUbpSEt2N9ofmNUnd2o7eVYR1t4ml25Cg=;
 b=Dtim+80KEB6Wdscml6KCdPFBmIGLkVCPpTUIBzjORPJ0wsMc1BFKr2l5
 YAp4HFSRUmSZLyS8dxocQrA3qlpW3oByChzKIfx/ZDDJa1RdsFQrWPtyc
 UyVNArhinQj7CgCtoE7jX+8v5o0VggvxlpPjNitr/hgLNlGc65BC1GIRb
 iA0JTPKL6BSUlZtizYQMIlb0txHIgmwdiFMD7PPOBr/J+XOA3cx3/d/I8
 TNIBl7E9CpxNgOkUAGEOHy/VM1q7f6Xaj1WZGsJpoPNSgB5pb/bRI04jw
 zMueL8qV5ySHT4c6kyJ6Nu/kJotJwG78Kwam4ai55IcJIWE7l89c+Af8A g==;
X-CSE-ConnectionGUID: 2j25kW1vQZ6HkgsjkE850g==
X-CSE-MsgGUID: teadZJM6QWOoNV+REd4uEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3292333"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3292333"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 12:35:18 -0800
X-CSE-ConnectionGUID: YYV4gveNSTKUjR6e+yjzZQ==
X-CSE-MsgGUID: 4Lc0Si74RiO2z2bAenVV4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="8822926"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO [10.245.244.252])
 ([10.245.244.252])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 12:35:12 -0800
Message-ID: <1993e931e6a4b0cda5c04e72b1a8d5fb924f950a.camel@linux.intel.com>
Subject: Re: [PATCH] mm/hmm: skip NUMA balancing on protnone faults
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, Matthew Auld
 <matthew.auld@intel.com>, linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, Matthew
 Brost <matthew.brost@intel.com>, Mika =?ISO-8859-1?Q?Penttil=E4?=
 <mpenttil@redhat.com>,  Leon Romanovsky	 <leon@kernel.org>, Jason Gunthorpe
 <jgg@ziepe.ca>
Date: Fri, 13 Nov 2026 21:34:43 +0100
In-Reply-To: <b32fb02a-68b4-4db9-83dd-254147dbf215@kernel.org>
References: <20261112-numa-v1-1-ad9cbca8f49a@intel.com>
 <b32fb02a-68b4-4db9-83dd-254147dbf215@kernel.org>
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

Hi, David

On Fri, 2026-11-13 at 19:27 +0100, David Hildenbrand (Arm) wrote:
> On 11/13/26 17:25, Matthew Auld wrote:
> > When automatic NUMA balancing marks a PTE or PMD as protnone
> > (PAGE_NONE), hmm_pte_need_fault() requests a fault to restore
> > access
> > permissions, including _PAGE_RW when write access is needed.
> >=20
> > Calling handle_mm_fault() from hmm_do_fault() currently triggers
> > NUMA
> > balancing in do_numa_page() and do_huge_pmd_numa_page(). When
> > hmm_range_fault() runs from a device driver or kworker context
> > (such as
> > a GPU SVM or userptr rebind worker), folios get migrated toward the
> > CPU
> > node executing the remote fault.
> >=20
> > Also, each folio migration invokes try_to_migrate_one() ->
> > mmu_notifier_invalidate_range_start(), which invalidates the
> > caller's mmu_interval_notifier while holding mmap_lock. That causes
> > hmm_range_fault() to abort with -EBUSY after every 2 MiB PMD and
> > exhaust
> > its retry timeout on large buffers, which has been observed with
> > large
> > imported Xe userptr buffers.
> >=20
> > Add FAULT_FLAG_NO_NUMA and set it in hmm_do_fault() so protnone
> > entries
> > restore PTE/PMD permissions in-place without performing NUMA
> > balancing,
> > matching GUP's default !FOLL_HONOR_NUMA_FAULT behaviour.
>=20
> Ehm, that's not how it works.
>=20
> GUP will not trigger a "special" fault and will try not triggering a
> fault and
> not restore permissions.
>=20
> It will try continuing, leaving the protnone pte as it is.
>=20
> See gup_can_follow_protnone().
>=20
> For read-only access that should always work.
>=20
> For write-access we always trigger an ordinary fault and do NUMA
> migration etc.
>=20
>=20
> So FAULT_FLAG_NO_NUMA is doing something completely different and I
> don't agree
> with it.
>=20

There are two major problems with the current behaviour.

1) The work item executing hmm_range_fault() might have no affinity at
all to the GPU about to access the memory.

2) If migration happens, then hmm_range_fault() will stop and retry
leading to excessive execution time.

While perhaps Matt's commit message doesn't correctly describe the GUP
behaviour, do you have any alternative suggestion than to avoid
migration in this case? I think it's a reasonable idea given the
problems with the current code?

Thanks,
Thomas
=20

