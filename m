Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67CCFF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 163DB10F278;
	Thu, 30 Apr 2026 07:59:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="myVfI3j6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75B3F10F278;
 Thu, 30 Apr 2026 07:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777535994; x=1809071994;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=P2Tt9zx6ewbidgKEabGYxyKmcjCyoxtYnX4zm9i9cp8=;
 b=myVfI3j66XaDPKcnlHvULRZVWXaNu6P+By2Ta+JN9xFhv74hf2DCIcTV
 I4v9ROB1PwHM7+s/6rPwU8vH/sOmfCDEjE799qPeeeZoMkMYF+fNABMh5
 0E/lPgDQeFsTeN0YZZIUkm81fAkSJSXjlibyKD+kLHcf3zC6qGKnkIVMs
 B9WSmmMD1l+pqkQJIr4v6+My6CLEOpjOA0i31ygu3us2gLTx6XQPdrzqH
 Pjp+ivFgMOJo6bA4lTsBWKn18P+59YMbaLPKrKHNWCGXkC9874EwcOPeX
 uH7cCBG6GjttENtWocOl67V3pM4tZtSN+MYufs1faWEtQdBkFSbE+MHTZ A==;
X-CSE-ConnectionGUID: 3G646BudR7232+mpznfHYg==
X-CSE-MsgGUID: 3yXVQHfyS46SEhYDIP29Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78401274"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="78401274"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 00:59:54 -0700
X-CSE-ConnectionGUID: 2arnbDFIRH2GV6HLwn6v8Q==
X-CSE-MsgGUID: P1Pw2TOmSuaSkiHcYkiAew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="272625039"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO [10.245.244.73])
 ([10.245.244.73])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 00:59:51 -0700
Message-ID: <1e049fe5f571e26417d4a9b4234e163e4c0d53b0.camel@linux.intel.com>
Subject: Re: [PATCH 1/3] drm/ttm: Issue direct reclaim at beneficial_order
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Dave Airlie <airlied@gmail.com>, Daniel Colascione <dancol@dancol.org>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, Matthew Brost	
 <matthew.brost@intel.com>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Carlos Santa <carlos.santa@intel.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, Simona
 Vetter <simona@ffwll.ch>
Date: Thu, 30 Apr 2026 09:59:48 +0200
In-Reply-To: <CAPM=9txEMjXVvxAOxx7GND5tQLO2sA7K49piXN=PBchNG11H7g@mail.gmail.com>
References: <20260421012608.1474950-1-matthew.brost@intel.com>
 <20260421012608.1474950-2-matthew.brost@intel.com>
 <30c84c41-192c-44ae-a614-2b9951c55727@ursulin.net>
 <d7dda563-280f-4126-a822-a3d43ce5048e@amd.com>
 <aekygVvRz7mu+elE@gsse-cloud1.jf.intel.com>
 <5bd5ed0a-fef2-4bd4-b7a0-d263bcfb1c7f@ursulin.net>
 <87se8didkt.fsf@dancol.org>
 <CAPM=9txEMjXVvxAOxx7GND5tQLO2sA7K49piXN=PBchNG11H7g@mail.gmail.com>
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

On Thu, 2026-04-30 at 10:11 +1000, Dave Airlie wrote:
> >=20
> > Probably stupid question: for systems like my Lunar Lake Xe2, which
> > has
> > unified memory and (IIUC) no special cache-type or write-mode
> > constraints for GPU mappings, would it be possible to use regular
> > system-provided pages (e.g. from shmem) instead of going through
> > the TTM
> > pool and allow mTHP to provide the aligned and contiguous backing
> > storage that the GPU wants? Something like GEM has, but maybe
> > inside the
> > TTM API?
>=20
> TTM pool doesn't get used for system memory allocations in that case,
> if you are asking for cached memory.

Both Lunar Lake and Panther Lake use write-combined memory for buffer
objects in performance-critical paths. So the pools are indeed getting
used.

And while it is possible to change caching on shmem pages if they are
pinned/unevictable, trying to pool them quickly becomes messy.

/Thomas


>=20
> Dave.
