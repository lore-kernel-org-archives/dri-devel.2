Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75240606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Pob33LMr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D146E10E219;
	Mon, 16 Nov 2026 14:53:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B092610E667;
 Mon, 16 Nov 2026 14:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794840787; x=1826376787;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=FzhLHauq6wX8slJmqH/D7Lca0l04NMZvOWVaeW+Dhk4=;
 b=Pob33LMrty51G1l4k1KF6T2DOl7ofyd2xH6ECx5TCG7L0/ks3C4wp2o9
 hrTqCKw16iRtkkjCKOXU8vSYyPdiZF49tKBK33fMljUcYSJSXXr3DYFSX
 Pzy1qBavq8l9y81KpeOZsFUJvZOWmGEv/7uSfI7XEWF8iTs34afmnGg/l
 8EoCZFWuvXJ96JB78puqH/c3XtLFovt1Gk+Yxcjqbt2OLkexJW9VBKXKA
 p8XvGLkOAZv8vdi9rdqM+zKnNLMl8gRYBsTawASZ7nTi06Lf7UVE2/W5f
 AJypyvyQIJ1FECv+9ounvtqJgQbtBfmYREncV+hrup7iP77ce/g1GuYvj w==;
X-CSE-ConnectionGUID: BnezCYKvTGGtAu39btWCow==
X-CSE-MsgGUID: idTa7QlWT9mkT8Gjy6mvRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3473945"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3473945"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 06:53:07 -0800
X-CSE-ConnectionGUID: RVsed9SRR6mHGYbHqTSNHg==
X-CSE-MsgGUID: CWFaW/ViQIG8kW8ZlcLLzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9371256"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.189])
 ([10.245.245.189])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 06:53:04 -0800
Message-ID: <58755e3cb51d534b749d70847a5478a40c1c10fa.camel@linux.intel.com>
Subject: Re: [PATCH] mm/hmm: skip NUMA balancing on protnone faults
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, Matthew Auld
 <matthew.auld@intel.com>, linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, Matthew
 Brost <matthew.brost@intel.com>, Mika =?ISO-8859-1?Q?Penttil=E4?=
 <mpenttil@redhat.com>,  Leon Romanovsky	 <leon@kernel.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, John Hubbard	 <jhubbard@nvidia.com>
Date: Mon, 16 Nov 2026 15:53:01 +0100
In-Reply-To: <6af3d5d2-4fab-4a3f-85d9-34564fca8ffe@kernel.org>
References: <20261112-numa-v1-1-ad9cbca8f49a@intel.com>
 <b32fb02a-68b4-4db9-83dd-254147dbf215@kernel.org>
 <1993e931e6a4b0cda5c04e72b1a8d5fb924f950a.camel@linux.intel.com>
 <9ec3e8b9-064a-47a7-8d00-566ff371b846@kernel.org>
 <0b794f803517c27ea818a2e894761095300b4da4.camel@linux.intel.com>
 <6af3d5d2-4fab-4a3f-85d9-34564fca8ffe@kernel.org>
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

On Fri, 2026-11-13 at 22:19 +0100, David Hildenbrand (Arm) wrote:
> On 11/13/26 21:56, Thomas Hellstr=C3=B6m wrote:
> > On Fri, 2026-11-13 at 21:43 +0100, David Hildenbrand (Arm) wrote:
> > > On 11/13/26 21:34, Thomas Hellstr=C3=B6m wrote:
> > > > Hi, David
> > > >=20
> > > >=20
> > > > There are two major problems with the current behaviour.
> > > >=20
> > > > 1) The work item executing hmm_range_fault() might have no
> > > > affinity
> > > > at
> > > > all to the GPU about to access the memory.
> > > >=20
> > > > 2) If migration happens, then hmm_range_fault() will stop and
> > > > retry
> > > > leading to excessive execution time.
> > > >=20
> > > > While perhaps Matt's commit message doesn't correctly describe
> > > > the
> > > > GUP
> > > > behaviour, do you have any alternative suggestion than to avoid
> > > > migration in this case? I think it's a reasonable idea given
> > > > the
> > > > problems with the current code?
> > >=20
> > > Adding fault reasons that hack around NUMA hinting such that a
> > > actual
> > > CPU
> > > accessing it later will not trigger ... NUMA hinting?
> > >=20
> > > I might be missing the "reasonable" in here :P
> >=20
> > Wouldn't the net effect be that content stays put instead of being
> > migrated? In both cases a later CPU access will not trigger NUMA
> > hinting except that the proposed change doesn't send content to an
> > irrelevant node?
>=20
> My point is that you are essentially disabling NUMA hinting because
> the CPU will
> no longer trigger NUMA hinting faults.

Yes, I got that part, but that's is only for a single scan, right? My
point was that we'd replace an irrelevant hint + migration with a NOP
hint. In both cases we'd lose the next relevant CPU access hint.

Granted, in the follow_protnone case we don't do that.


>=20
> But then, just disable it entirely. Maybe John knows what to do.

We can't do that globally, really, for these type of apps. But one
remedy might be recommending the app to mbind() with a no-migration-on-
fault policy.

Also the hmm O(n=C2=B2) complexity in this situation isn't really ideal. We
might need to look at that as well.

Thanks,
Thomas
