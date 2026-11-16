Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40495606A32C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SYEx8TXt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A295110E44F;
	Mon, 16 Nov 2026 21:11:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC34510E44F;
 Mon, 16 Nov 2026 21:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794863508; x=1826399508;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=tPICxjq1N4RV20UsKkWwpwgKmWTNCzLHki4n3niZRB8=;
 b=SYEx8TXtMwV7sEiYZ6SkAaBWOdFoPfsrs+hHjksZ9j+9gfkbA7Rbn37q
 hb45n48y9fKgYNMQsRyXe4qXfJFr7yiKBJlA8cEvx6xfBIlHSGdfa5J7A
 6EdQlMsQLq5AMhvkiidJMRQ+67+gSSDLsNejoL37feTwLohyU1Omd5d+Q
 3bE/Hofl2mWwQkDLFqGWjYMJuwYj1CmrxRBzoGedFUbtupn8OW66WzEvM
 GVrNqnAmGrOrmHgG5fekEyoI9CzEFuSISO9ajnEMpr0D1maZxv99tF1WQ
 66dpY+CiLNeMykZTtJs8L2aA8rkyQeCE+5jyDEH8ZfLTan+u0cyB8leSS A==;
X-CSE-ConnectionGUID: nPOOW+TkR4i/FUoACghazw==
X-CSE-MsgGUID: XhvwwgxIRfuUxWyCyq4FJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3494702"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3494702"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 13:11:47 -0800
X-CSE-ConnectionGUID: DFNsRiT0Tr+0O228TzssZA==
X-CSE-MsgGUID: Az38CCIpRNiGNLtlz+pRzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; d="scan'208";a="11568453"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.189])
 ([10.245.245.189])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 13:11:44 -0800
Message-ID: <0a8c14b4ee7e332c3c59d23fb71aaa953e12df5a.camel@linux.intel.com>
Subject: Re: [PATCH] mm/hmm: skip NUMA balancing on protnone faults
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, Matthew Auld
 <matthew.auld@intel.com>, linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, Matthew
 Brost <matthew.brost@intel.com>, Mika =?ISO-8859-1?Q?Penttil=E4?=
 <mpenttil@redhat.com>,  Leon Romanovsky	 <leon@kernel.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, John Hubbard	 <jhubbard@nvidia.com>
Date: Mon, 16 Nov 2026 22:11:41 +0100
In-Reply-To: <f81bd37a-9637-44be-83fd-be7e717fa182@kernel.org>
References: <20261112-numa-v1-1-ad9cbca8f49a@intel.com>
 <b32fb02a-68b4-4db9-83dd-254147dbf215@kernel.org>
 <1993e931e6a4b0cda5c04e72b1a8d5fb924f950a.camel@linux.intel.com>
 <9ec3e8b9-064a-47a7-8d00-566ff371b846@kernel.org>
 <0b794f803517c27ea818a2e894761095300b4da4.camel@linux.intel.com>
 <6af3d5d2-4fab-4a3f-85d9-34564fca8ffe@kernel.org>
 <58755e3cb51d534b749d70847a5478a40c1c10fa.camel@linux.intel.com>
 <f81bd37a-9637-44be-83fd-be7e717fa182@kernel.org>
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

On Mon, 2026-11-16 at 21:12 +0100, David Hildenbrand (Arm) wrote:
> On 11/16/26 15:53, Thomas Hellstr=C3=B6m wrote:
> > On Fri, 2026-11-13 at 22:19 +0100, David Hildenbrand (Arm) wrote:
> > > On 11/13/26 21:56, Thomas Hellstr=C3=B6m wrote:
> > > >=20
> > > > Wouldn't the net effect be that content stays put instead of
> > > > being
> > > > migrated? In both cases a later CPU access will not trigger
> > > > NUMA
> > > > hinting except that the proposed change doesn't send content to
> > > > an
> > > > irrelevant node?
> > >=20
> > > My point is that you are essentially disabling NUMA hinting
> > > because
> > > the CPU will
> > > no longer trigger NUMA hinting faults.
> >=20
> > Yes, I got that part, but that's is only for a single scan, right?
>=20
> Well, one NUMA-hinting protects again, you would get an MMU notifier,
> and fault
> again here?
>=20
> It all gets pretty unpredictable for these PTEs, no?

True, it does. But again, my point is that exact same thing happens if
hmm_range_fault() is allowed to take the fault and migrate? Which
happens here.

>=20
>=20
> > > But then, just disable it entirely. Maybe John knows what to do.
> >=20
> > We can't do that globally, really, for these type of apps. But one
> > remedy might be recommending the app to mbind() with a no-
> > migration-on-
> > fault policy.
>=20
> Yeah, something like this. I mean, it's hard to see how NUMA
> balancing makes any
> sense here. You're just trying to fight the mechanism because it ends
> up causing
> more harm then good.
>=20
> >=20
> > Also the hmm O(n=C2=B2) complexity in this situation isn't really ideal=
.
> > We
> > might need to look at that as well.
> I didn't quite get that, can you elaborate?

My understanding is that due to the migration invalidations
hmm_range_fault() is restarted from the beginning roughly on each PMD,
leading to O(n_pages=C2=B2) complexity, although with a small constant.

Thanks,
Thomas


