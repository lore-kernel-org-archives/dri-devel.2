Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC716606A331
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L2iQTbCM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44F7310ECA2;
	Tue, 24 Nov 2026 13:54:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B362810F5B4
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795528461; x=1827064461;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=DExrSGXOiTKBtoA9dCjAa8IsuZJqIx6QPSH5pFvl/oY=;
 b=L2iQTbCMUWAMZ2v7DGleBZMGXr9seLYhvvmTAg8DzlKvK9cRZY/RCuwV
 Kr8NQRmIrAEW4GThxKstZTulU7M9F6C+iDw8tK8oHZWgqzERA4Fznc4qw
 ynXtvSymrEXOQhRSiA8lDV70boKeHC2X5f1uLrBoGgna6chPdok4bsTTY
 fKtFHtyTYWbmXrNEXjS2p9Z8rIseJMs1alLYX+CfmYZG06gul10hF0rfV
 na9AC4pKxYGOhu91zPW3B/qmWLTJoJmgRDFZvLiFSBojFUiyzuMkJuD2R
 0UjAjg0LyZW+3qBMhFavJ5SjPwOuSncLtxnXB6CHYJxYISp0ptyAWJfrr g==;
X-CSE-ConnectionGUID: R7FRNxWSTWGE95Hwhm5NfA==
X-CSE-MsgGUID: MBo7zpgQQbuGlR13yzs1FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4352656"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4352656"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 05:54:20 -0800
X-CSE-ConnectionGUID: m/HfaHiPQcWMOIpsewuRAQ==
X-CSE-MsgGUID: jDdLBR3UT/qlpwUxMwLhsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11625936"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.245.188])
 ([10.245.245.188])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 05:54:17 -0800
Message-ID: <fecf82c876bf4822bc1810a6ccbf36b7b327db96.camel@linux.intel.com>
Subject: Re: About NUMA support in drmsvm helpers
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: "Huang, Honglei" <honghuan@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>
Cc: Simona Vetter <simona@ffwll.ch>, Alex Deucher
 <alexander.deucher@amd.com>,  "Kuehling, Felix" <felix.kuehling@amd.com>,
 Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org, Honglei
 Huang <honglei1.huang@amd.com>, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich	 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>
Date: Tue, 24 Nov 2026 14:54:14 +0100
In-Reply-To: <3c762d0c-ef16-4e3e-af96-fd65fc492db5@amd.com>
References: <316c1d61-f297-41ad-95d1-43aaa67c9696@amd.com>
 <c844403b-8c07-4a37-a988-85d2548bb674@amd.com>
 <3c762d0c-ef16-4e3e-af96-fd65fc492db5@amd.com>
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

On Tue, 2026-11-24 at 14:55 +0800, Huang, Honglei wrote:
>=20
>=20
> On 11/23/2026 7:04 PM, Christian K=C3=B6nig wrote:
> > Hi Honglei,
> >=20
> > On 11/23/26 11:44, Huang, Honglei wrote:
> > >=20
> > > Hi all,
> > >=20
> > > A NUMA issue is found in another thread in [1]
> > >=20
> > > We also encountered a similar issue, performance drop occurs when
> > > NUMA balance is enabled.
> > >=20
> > > And there is one more thing about NUMA:
> > > The current amdgpu drmsvm can specify system memory as a
> > > destination, but not a specific CPU NUMA node.
> >=20
> > Yeah I think that is by design. the NUMA node a page ends up when
> > being migrated back from VRAM to system memory should be determined
> > by the original backing store/address space and not the driver who
> > migrates it back.
> >=20
> > In other words when applications said that it wants their buffers
> > to be placed on node X it is not up to the driver to mess with
> > that.
> >=20
> > > This has impact on some platforms like MI300A that feature
> > > unified memory for CPU and GPU.=C2=A0 We did a test for 2GB memory
> > > accessing in node
> > > 0 and node 3. GPU read/write bandwidth averaged about 2.78 TB/s
> > > with local pages and 103 GB/s with remote pages, it differs a
> > > lot.
> > >=20
> > > There is a requirement from AMD HIP to specify certain SVM memory
> > > to specific NUMA nodes. But KFD also can not support NUMA fully.
> > > So the HIP runtime have to use linux NUMA facilities to move
> > > memory to the correct NUMA node, this could lead to unnecessary
> > > ram to ram migration.
> > > And it also can not solve VRAM to RAM evict to error NUMA node
> > > issue.
> > >=20
> > > Would it make sense for drm_gpusvm helpers to let a caller pass a
> > > preferred NUMA node by interface? An explicit destination node
> > > for migration to system memory.
> >=20
> > I think we just need to make sure that the NUMA preferences of the
> > process and any setting specified by madvise() and co are taken
> > into account.
> >=20
>=20
> So we should reuse existing MM mechanisms and respect application
> NUMA=20
> policies, right?
> Some changes may still be needed to cover the remaining gaps, and
> needs=20
> do some test to verify the NUMA feature.

I think NUMA process settings can be tricky since the recoverable
pagefaults (be it SVA or hmm) run from a kernel thread that doesn't
have the process' numa policy.

However NUMA policies set with the mbind() system call should AFAICT
automatically be honored by both hmm and SVA.

Thanks,
Thomas



>=20
> Regards,
> Honglei
>=20
>=20
> > Regards,
> > Christian.
> >=20
> > >=20
> > > [1]:
> > > https://lore.kernel.org/all/b32fb02a-68b4-4db9-83dd-254147dbf215@kern=
el.org/
> > >=20
> > > Regards,
> > > Honglei
> >=20
