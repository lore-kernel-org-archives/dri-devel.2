Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A94606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AsQhmaQ8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A514D10ED64;
	Mon, 16 Nov 2026 09:04:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 130F910ED64;
 Mon, 16 Nov 2026 09:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794819882; x=1826355882;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=lVSOBHJ5VwDp2ZACKvS3B4mMnM7PjaTFUbphEQe5/jE=;
 b=AsQhmaQ8XIGZQII4/dSoMwhu/zXl0mAfR7AqNoAXSDSG/wlHXmwxmuQr
 CmRQz9dNcZWkWoBPeeCFgB/hmLS+w5HRxvNCURAFgVdey/m0q+9j+RKrd
 RXCIvQX+XshiGEFzqtA2zs1WvKtxvNa9XvM4B6Vwo9sOJ1SR/afjtvVZE
 m4JUNz8HMszH2u4zzF1Jfxgfe6DQzmVx9BYzvFQj/Sd8X5VBoAc0HF9RR
 /lFYskvQn172X5O9mxmoC3T7EUQ4QVR6y8/GA68apcbvLED771UZ4Bil0
 pQ0CZv2VDhQyFhAMgmiEeasWr0tsFJyvBDXVa5CIvPGutgM6kaw4x+IOr g==;
X-CSE-ConnectionGUID: N7C5N0N4R2iAvWbQfbzgfg==
X-CSE-MsgGUID: hcws8jGNRhidPgo+SFmbiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3590251"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3590251"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 01:04:40 -0800
X-CSE-ConnectionGUID: W266ZvGnSOiQYZ/klWmJqA==
X-CSE-MsgGUID: ZB1fzsk6Ro2czAt8DuOyJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9824306"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.110])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 01:04:35 -0800
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3a2a052d-19ab-445c-9073-e49dbe2dd737@intel.com>
References: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
 <20261109135549.4128280-2-mika.kuoppala@linux.intel.com>
 <3a2a052d-19ab-445c-9073-e49dbe2dd737@intel.com>
Subject: Re: [PATCH 01/20] drm/ttm: Add ttm_bo_access_locked()
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: simona.vetter@ffwll.ch, matthew.brost@intel.com, christian.koenig@amd.com,
 thomas.hellstrom@linux.intel.com, gustavo.sousa@intel.com,
 jan.maslak@intel.com, dominik.karol.piatkowski@intel.com,
 rodrigo.vivi@intel.com, andrzej.hajda@intel.com, matthew.auld@intel.com,
 maciej.patelczyk@intel.com, michal.wajdeczko@intel.com,
 dri-devel@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Michel =?utf-8?q?D=C3=A4nzer?= <michel.daenzer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
To: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
 Mika Kuoppala <mika.kuoppala@linux.intel.com>, intel-xe@lists.freedesktop.org
Date: Mon, 16 Nov 2026 11:04:33 +0200
Message-ID: <179481987310.38962.8679208943005551267@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620
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

Quoting Gwan-gyeong Mun (2026-11-13 21:09:04)
> Hi Mika,
> the description of the "ttm_bo_access()" API states, "Should not be=20
> directly exported to user space via a peak/poke interface."
>=20
> When the newly added "ttm_bo_access_locked()" is used in "eudebug", it=20
> is ultimately exposed to user space via functions such as "pread" and=20
> "pwrite". @Mattew Brost,I would like to inquire whether this violates=20
> the considerations made when the "ttm_bo_access()" API was initially=20
> designed.

This was already discussed during earlier series review.

Here, the application itself doesn't get a peek/poke interface, it's
only the debugger process. The debugger process is also given heavy
hardware flushing operations that are needed to flush out eg.
instruction caches.

This interface is pretty much mandatory to facilitate memory access
for debugger on our HW as the RCS/CCS/BCS engines may be stalled due
to a later page-fault in the queue while dealing with first page-fault.

In that scenarion, submitting workloads to the engines to facilitate
single word modifications to memory would simply be blocked.

It'd also fall off performance cliff for single-stepping as GDB at
least on the Intel GPU instruction set is very heavy on sparsely
accessing a lot of memory during single-stepping. We already had to
separate memory access and memory flushing to different operations
to make that more user-friendly for interactive single-stepping.

Regards, Joonas
