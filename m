Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50AC606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eJOHndh/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FC1110FDF4;
	Wed, 28 Oct 2026 17:35:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2D5D10FDF5;
 Wed, 28 Oct 2026 17:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793208913; x=1824744913;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=UI2WNfZzOyQTVTSwnKMZu5zfYdi8X/kaS6eJwJcc7fw=;
 b=eJOHndh/rMpST4TEAksRC3b6zKBYz8nEIGRQePxtEIe9CJCHxDOJ3z19
 A9e06WD85NyvYFxniGvunrniZ4M7rFHPIIAsj8BJQ5nRFW68VqJ3GaqTi
 3t4NcGVoILK0CCsj9zxBhYS//U/BHSId+ToKWNRMkEVyY7dktF+Vz09Ni
 OqpeEMKa7z+GDzUw5QgWHBVtK8GKda91pRVd9EBOI4BCh84JA4JATKUWd
 mPqcJRIqcq78oBpFaeiUl1EBEfP3yEAS3JWpAfkNANpslIudfZpVq1VsH
 hJA6jcwUJaGHPR9tTaNEnD6axWkXOK2NkPeoKYvx1SAJyVWXiuyfW6stQ g==;
X-CSE-ConnectionGUID: P8OZnJmrRaC2pBuNrDeDxg==
X-CSE-MsgGUID: ECWGVSQhQ0mHTuHuhEC1Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1935743"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1935743"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 10:35:13 -0700
X-CSE-ConnectionGUID: +PFKSS33RmunfSWZ+DpdEQ==
X-CSE-MsgGUID: cPsmyOYcTauw6W6X2cmmdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="4961827"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.122])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 10:34:57 -0700
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <auHjA2kEBniSCTj3@zenone.zhora.eu>
References: <20261016033102.529239-1-jia.yao@intel.com>
 <auHjA2kEBniSCTj3@zenone.zhora.eu>
Subject: Re: [PATCH v13] drm/i915/dg2: Add per-client control for
 Wa_22013059131
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Shuicheng Lin <shuicheng.lin@intel.com>,
 Matt Roper <matthew.d.roper@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Maciej Plewka <maciej.plewka@intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>, Jia Yao <jia.yao@intel.com>
Date: Wed, 28 Oct 2026 19:34:54 +0200
Message-ID: <179320889403.143024.1638848416588104514@jlahtine-mobl>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Quoting Andi Shyti (2026-10-28 13:57:39)
> Hi Jia,
>=20
> On Fri, Oct 16, 2026 at 03:31:02AM +0000, Jia Yao wrote:
> > Wa_22013059131 sets FORCE_1_SUB_MESSAGE_PER_FRAGMENT in LSC_CHICKEN_BIT=
_0
> > at engine init, but this is known to cause GPU hangs in certain workloa=
ds.
> > Add I915_CONTEXT_PARAM_WA_22013059131 so userspace that handles the
> > workaround itself (e.g. by limiting SLM size) can set it to 1 to let the
> > kernel know bit 15 programming is not needed. The register is not
> > context-saved by hardware, so the value is programmed on context switch
> > via the indirect context batchbuffer, and the old unconditional write in
> > intel_workarounds.c is removed.
>=20
> ...
>=20
> > Bspec: 54833
> > Link: https://github.com/intel/compute-runtime/pull/919
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: Shuicheng Lin <shuicheng.lin@intel.com>
> > Cc: Matt Roper <matthew.d.roper@intel.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Maciej Plewka <maciej.plewka@intel.com>
> > Cc: Andi Shyti <andi.shyti@linux.intel.com>
> > Signed-off-by: Jia Yao <jia.yao@intel.com>
>=20
> pushed to drm-intel-gt-next.

We're still lacking tests. I have reverted it for now.

Regards, Joonas

>=20
> Thanks,
> Andi
