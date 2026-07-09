Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC76C44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:47:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C9DC10E048;
	Thu,  9 Jul 2026 09:47:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KDEJhqQB";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E495910E048;
 Thu,  9 Jul 2026 09:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783590469; x=1815126469;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=SSuJLx9SE57A7qIxtS+wkjg1DUj+y6sjOCSXMaWQQak=;
 b=KDEJhqQBHnzg+W1DRvUp7QtkgN85iaQZt5INbNrre8pcbKIRt8PaEJeU
 gbbELqnC3US+8pegF3PlrYLrVOsb7tBwiNHiiFf2eXS4EVwPT+SxhQOFm
 FbhcpKsSZ8dcaF5BkBJmHm3nmQntq7rbntS2Y1ooYz+QVQtKQDAjRFvtm
 Nw3E3Br/rVasHzTmsXHe4JvEpaXvUHErnheEIm/jnn6XJP/+dIHcrCGGd
 V1rioierX0Iv562aMRy/r/9euIeMShToDhYjPvnQdqWVTZXsPf2x1No7p
 ipAPWeKY5OA3JaSgp+2T9FcRZw9m4y7qlzMVAcCeuZ2MjC6JtIhkshTUn g==;
X-CSE-ConnectionGUID: A3Jrmow9S66XtN0ECenGtw==
X-CSE-MsgGUID: 6fIC7AdSRNusHGmjonn8Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84380023"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84380023"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 02:47:48 -0700
X-CSE-ConnectionGUID: 4ygGpAhyTYeln8kGMGST4g==
X-CSE-MsgGUID: th6FiBwhSfakI1Bu3JJT6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="258142936"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.44])
 ([10.245.244.44])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 02:47:41 -0700
Message-ID: <265737ad21d42a7509a8c43619975f0ef150f275.camel@linux.intel.com>
Subject: Re: [PATCH v7] cgroup/dmem: implement dmem.high soft limit with
 proactive reclaim
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Jing Wu <realwujing@gmail.com>, matthew.brost@intel.com
Cc: christian.koenig@amd.com, ray.huang@amd.com, matthew.auld@intel.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, tj@kernel.org, hannes@cmpxchg.org, 
 mkoutny@suse.com, natalie.vock@gmx.de, mhocko@kernel.org,
 roman.gushchin@linux.dev, 	shakeel.butt@linux.dev, muchun.song@linux.dev,
 intel-xe@lists.freedesktop.org, 	dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 	cgroups@vger.kernel.org, linux-mm@kvack.org
Date: Thu, 09 Jul 2026 11:47:38 +0200
In-Reply-To: <20260709061114.1623774-1-realwujing@gmail.com>
References: <ak81RUK6vRZaMN2D@gsse-cloud1.jf.intel.com>
 <20260709061114.1623774-1-realwujing@gmail.com>
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

On Thu, 2026-07-09 at 14:11 +0800, Jing Wu wrote:
> On Wed, Jul 09, 2026 at 12:44:37AM -0700, Matthew Brost wrote:
> > This looks quite similar to work Thomas is doing here [1].
>=20
> Thank you for the pointer, Matt.=C2=A0 We were not aware of Thomas's
> series
> before your mail.=C2=A0 After reviewing Thomas's v7 [1], the two series
> turn
> out to address different =E2=80=94 and complementary =E2=80=94 problems:
>=20
> =C2=A0 - Thomas's series hooks a reclaim callback into the dmem.max write
> =C2=A0=C2=A0=C2=A0 path: when an administrator lowers dmem.max below curr=
ent usage,
> the
> =C2=A0=C2=A0=C2=A0 kernel calls the driver's reclaim callback to bring de=
vice memory
> =C2=A0=C2=A0=C2=A0 usage down to the new limit.=C2=A0 This is analogous t=
o what happens
> in
> =C2=A0=C2=A0=C2=A0 memcg when memory.max is written below current usage.
>=20
> =C2=A0 - Our series adds dmem.high as a soft limit enforced in the charge
> =C2=A0=C2=A0=C2=A0 path: when a successful allocation pushes a cgroup's u=
sage above
> =C2=A0=C2=A0=C2=A0 dmem.high, TTM proactively evicts one BO from that cgr=
oup before
> =C2=A0=C2=A0=C2=A0 returning.=C2=A0 This mirrors memory.high semantics in=
 memcg, where
> =C2=A0=C2=A0=C2=A0 reclaim is triggered per-allocation to keep usage belo=
w the soft
> =C2=A0=C2=A0=C2=A0 threshold.
>=20
> Both mechanisms coexist independently in memcg and serve distinct
> purposes: the max write path handles capacity reconfiguration by
> operators, while the high-limit path provides automatic backpressure
> for workloads approaching their quota.=C2=A0 Having both in the dmem
> cgroup
> controller seems correct.
>=20
> > Are either of you two aware of this seemly overlapping work?
>=20
> We were not, until your mail.=C2=A0 Now that we are, we would like to
> coordinate with Thomas on a few interaction points:
>=20
> =C2=A0 1. API intersection: Thomas's v5+ replaces the bare u64 size
> argument
> =C2=A0=C2=A0=C2=A0=C2=A0 in dmem_cgroup_register_region() with struct dme=
m_cgroup_init
> (which
> =C2=A0=C2=A0=C2=A0=C2=A0 bundles the region size, reclaim ops, and driver=
 private data).=C2=A0
> If
> =C2=A0=C2=A0=C2=A0=C2=A0 Thomas's series lands first, we will adapt our p=
atches to the
> new
> =C2=A0=C2=A0=C2=A0=C2=A0 registration interface.
>=20
> =C2=A0 2. File-level conflicts: both series modify ttm_resource.c and
> =C2=A0=C2=A0=C2=A0=C2=A0 ttm_bo.c.=C2=A0 The changes are semantically ind=
ependent and should
> =C2=A0=C2=A0=C2=A0=C2=A0 compose cleanly after a rebase, whichever lands =
second.
>=20
> Thomas, would you be open to coordinating on merge ordering?=C2=A0 We are
> happy to rebase our dmem.high series on top of yours once it lands,
> or
> to split out any shared infrastructure as a common prerequisite if
> that
> helps.

Sure. Let's notify eachother of imminent merge plans. I will rebase my
series on yours if yours go in first. If needed let's look at a topic
branch that we can merge into drm or vice versa.

My work is stalled on lack of reviews ATM.

Thanks,
Thomas

>=20
> Thanks,
> Jing Wu
