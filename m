Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CE0606A33D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iA9Y0t+Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DD7C10E028;
	Wed, 25 Nov 2026 15:47:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9746610E028
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795621646; x=1827157646;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=1yd9Lj9L5gGqJju4I7nRx8SSblyslgpri9S7QXg0hFM=;
 b=iA9Y0t+Zxf4RW1LKGxA7hj2qzPC/FIMwex96niVuFWZAgiuRVZEkq41o
 UheFsoNo1SgeFg64uk2hl9f7O423F7ljJBW/18nLi5aQ0N7To11r9wTem
 B5zmiiCZcU6uiI2EoGJES7ghb2Q29cPJ/tCQJcZgrsZkNhikwg8e14wW9
 BCAeP1pTZ+NbgdNh7xg79iKBIH/4uK+OjCc5zHLIQfhHPjNm8bhrSO1bb
 04VbCOtmdRqKQeB+tHGv4q4V7HbaxdQXv3ll0LnbGQGqY3OEF0EepZtCD
 DwdRu+49gngy8HOJbYlfqYA/80gXPTxuo1P+i5i2o4f9uBnNb4uoHN0/Y g==;
X-CSE-ConnectionGUID: +tNezqFxSp2AvAUqDKJnRQ==
X-CSE-MsgGUID: 1xqTynfkTG6L6gBMGRQ5Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4436043"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4436043"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 07:47:26 -0800
X-CSE-ConnectionGUID: mFdihMdGTJeLG9itaSYkcg==
X-CSE-MsgGUID: SqboshQGSJuUJFuFym+66g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208";a="12488989"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO [10.245.244.74])
 ([10.245.244.74])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 07:47:24 -0800
Message-ID: <ff8167523ddaa4b6e2d59be81cb06ff663251c0e.camel@linux.intel.com>
Subject: Re: [RFC PATCH 0/2] drm/ttm: fix excessive idle memory retention
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: "Eduardo P. Gomez" <eduardoprocopiogomez@gmail.com>
Cc: Natalie Vock <nat@pixelcluster.dev>, Arun Pravin	
 <arunpravin.paneerselvam@amd.com>, dri-devel@lists.freedesktop.org, Matthew
 Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>
Date: Wed, 25 Nov 2026 16:47:20 +0100
In-Reply-To: <CAKL2PNo7Vp7O4FRWGPV-ZuSqk60B4xh4pXUzcgYEEdqm_sUemg@mail.gmail.com>
References: <20261124222812.511867-1-eduardoprocopiogomez@gmail.com>
 <114377fd4c275215e40c3991bb935b8c41aa3d36.camel@linux.intel.com>
 <CAKL2PNo7Vp7O4FRWGPV-ZuSqk60B4xh4pXUzcgYEEdqm_sUemg@mail.gmail.com>
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

On Wed, 2026-11-25 at 10:27 -0300, Eduardo P. Gomez wrote:
> (sending a copy to the mail list)
>=20
> Hi Thomas,
>=20
> Under memory pressure, the existing shrinker indeed worked in my
> unpatched
> 7.4-rc4 QEMU test. It reclaimed all 768 MiB, and the competing
> allocation
> completed.
>=20
> And yes, I'm actually facing out of memory freezes on my 32 GiB
> desktop. My
> early investigations showed GPUReclaim was using most of my RAM (the
> test
> repo is the result of my last test before creating the patch). The
> tests
> shows GPUReclaim stayed at 12.25 GiB of 32 GiB for at least 60
> seconds
> after the reproducer exited. In a separate 8 GiB desktop run with v3,
> it
> dropped to about 128 MiB by the five-second sample.
>=20
> Once the allocation burst is over, what benefit do we get from
> keeping the
> full pool until memory pressure, compared with trimming the excess
> after a
> short window for reuse? My concern is the cost of reclaiming a pool
> that
> large when another workload already needs the memory.

The benefit is that since it is costly to transition memory from WC to
WB, we do it only on demand. The kernel can't guess whether the next
application to be used requires a lot of GPU memory or not. And we
don't need to add complexity to go beyond the core reclaim mechanisms.

But the allocation latency didn't seem to be the trigger for this work,
rather unexpected OOMS. Did you actually see any instance of remaining
GPUReclaim memory when OOM was hit?

Thanks,
Thomas



>=20
> If you=E2=80=99d like to try the standalone reproducer at 8 GiB, I=E2=80=
=99d be
> interested
> to see how long a competing allocation takes on the unpatched kernel
> once
> it needs memory back from the pool.
>=20
> Thanks,
> Eduardo
