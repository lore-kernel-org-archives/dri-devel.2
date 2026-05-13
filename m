Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89096CD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 14:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF27110EEF4;
	Wed, 13 May 2026 14:53:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="e4ZZFKl5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D240110E326;
 Wed, 13 May 2026 14:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778684008; x=1810220008;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=+nkd0hIANHMErNoW+36L2RFIXXYiPCP2hqzvZ335Z8U=;
 b=e4ZZFKl57ZHxPqBfUH3439t2YDbD8StUptzutsZ7kYcr2m6ww8EFhbEi
 N8sepPt6auciLvY3j2aDOGvhGTJ7QD7AtVzuvfFnd9NP6VBvq6JkTNsjk
 4Q/AnSGkn6FrtqOd1W3oBhvXZSzTf8b6wyyQApl8WcVZZSq+ZfO/TDwHs
 lplaGr4df+15AMaNGvh/7izsrOpyb7/GZ5KMzyHkLV/ud9mWFF8UXBpzZ
 C6lrczYFzzz1yBLZM4kWjw4t1fXiay6LZx6Szh2Qg0ayF0hecuWNRTmwD
 tHEGUmdlOe2Xz/kdUI8jDPNOuFEUPCeCviFxbibK/UYUdXGuO9Y0upKlj Q==;
X-CSE-ConnectionGUID: 56Ia8NgaTiSlIoi4dz0GDg==
X-CSE-MsgGUID: lOyhsEO9QxCZ2/dw9rBpFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="97039256"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="97039256"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 07:53:21 -0700
X-CSE-ConnectionGUID: vjFABCX/SsuPcYOxQxbOUg==
X-CSE-MsgGUID: X8kOSuBQQWCEnb4zi4I8dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="242112986"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.244.49])
 ([10.245.244.49])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 07:53:14 -0700
Message-ID: <d5e310c7f4506ef373c705180b33b9d5b2645b1a.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] mm/shmem: add shmem_insert_folio()
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, intel-xe@lists.freedesktop.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes
 <ljs@kernel.org>,  "Liam R. Howlett"	 <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport	 <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko	 <mhocko@suse.com>, Hugh Dickins
 <hughd@google.com>, Baolin Wang	 <baolin.wang@linux.alibaba.com>, Brendan
 Jackman <jackmanb@google.com>,  Johannes Weiner <hannes@cmpxchg.org>, Zi
 Yan <ziy@nvidia.com>, Huang Rui <ray.huang@amd.com>, Matthew Auld	
 <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org
Date: Wed, 13 May 2026 16:53:11 +0200
In-Reply-To: <d7cc273b-17a2-4b5f-af6a-0dc708c8cabf@kernel.org>
References: <20260512110339.6244-1-thomas.hellstrom@linux.intel.com>
 <20260512110339.6244-2-thomas.hellstrom@linux.intel.com>
 <f14d99d3-c1ff-453b-a280-17b8c4d5af94@kernel.org>
 <b4800086347aa3b27edc42b6536cb3a2b76a1aa8.camel@linux.intel.com>
 <26479389-459b-4cc4-914d-e7d29d5e5cc9@kernel.org>
 <c6b4031a-5625-4b1b-8a51-6e47241d32c9@amd.com>
 <bbde0793-fd21-4a9c-b85d-f13d8b787c50@kernel.org>
 <1ce447ceea88bbe56c7d28654a51fc2856a7f986.camel@linux.intel.com>
 <65596f86-e6a3-48b0-aa3d-2e608964e29d@kernel.org>
 <c0b5b94dfb4d04a1319bfb110f326afd2c29d48b.camel@linux.intel.com>
 <d7cc273b-17a2-4b5f-af6a-0dc708c8cabf@kernel.org>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
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

On Wed, 2026-05-13 at 13:36 +0200, David Hildenbrand (Arm) wrote:
> On 5/13/26 12:37, Thomas Hellstr=C3=B6m wrote:
>=20
>=20
> >=20
[...]
> > One alternative would be a single large sparse shmem object common
> > for
> > all DRM objects, with a range allocator, but that also got pretty
> > ugly
> > when I tried to implement that.
>=20
> Does not sound too crazy, though.
>=20
> >=20

Yeah, I stumbled on finding a reasonable idea to connect a shmem folio
to the pool LRUs and the range allocator metadata.

Assuming a shmem folio is pinned using the memfd pinning interface,
would folio->private be temporarily available?

Thanks,
Thomas
