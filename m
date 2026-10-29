Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D88606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bh1JSCTX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7929710FFCC;
	Thu, 29 Oct 2026 07:32:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D647010FFCC;
 Thu, 29 Oct 2026 07:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793259124; x=1824795124;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=kI9itzE3pzd8o1Sk2Y/PJevHoWAc66tjRfw0+KdhkEo=;
 b=Bh1JSCTX7c+hQyLdhbDiJf64yxLsDwkdbze+Fl+PSk0IDh/eOvDH0E3h
 58BYpCj0uIVJH/kksMKDyGr+O31AAi+0QGkW4bjHjRvw6AeGl4x+b/n4U
 LwadCxAsbTLKTh+5L2bJM5lrLvMnbVAut3naXiD7Zm7/LDBintGg4eyRy
 ZqVP3Q0R/DE/1gWBP4e21b5AzE6wlbUnPzL0p1JcI18bW+oZR3crvAJHi
 Dtd3W7xsoy2lgFBEI2hGU/R4rUZCTy6GVe9fI7qn/ooMb2NBiAUKS0xwm
 NhpARhTgrb/UP3EihrXV0uvwaEwXDmNOK4pXgN2mOMGJz9czi29SUb51H w==;
X-CSE-ConnectionGUID: E26wXeUITQKyC/NYwyASVA==
X-CSE-MsgGUID: zzVvbUXbSxCKVEBjBdhHsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2020472"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2020472"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 00:31:57 -0700
X-CSE-ConnectionGUID: RfMURdUHR061njZ7FUhxzQ==
X-CSE-MsgGUID: /5SfG0usTFeRrj1io4nbJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5401957"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.62])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 00:31:54 -0700
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <auHeqGZ-hm2lS7Nk@zenone.zhora.eu>
References: <20261027072832.726435-1-yaolu@kylinos.cn>
 <auHeqGZ-hm2lS7Nk@zenone.zhora.eu>
Subject: Re: [PATCH] drm/i915/gem: Reset err for each fence entry
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com, tursulin@ursulin.net,
 simona@ffwll.ch, chris@chris-wilson.co.uk, lionel.g.landwerlin@intel.com,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
To: Andi Shyti <andi.shyti@kernel.org>, yaolu@kylinos.cn
Date: Thu, 29 Oct 2026 09:31:50 +0200
Message-ID: <179325911095.16507.8295053984620715316@jlahtine-mobl>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Quoting Andi Shyti (2026-10-28 13:39:14)
> Hi Lu,
>=20
> On Tue, Oct 27, 2026 at 03:28:32PM +0800, yaolu@kylinos.cn wrote:
> > From: Lu Yao <yaolu@kylinos.cn>
> >=20
> > If dma_fence_chain_find_seqno() failed once, 'err' will store val in
> > the following loop. May causing returns '-EINVAL' even though that
> > entry never called dma_fence_chain_find_seqno() at all.
> >=20
> > Fixes: 13149e8bafc4 ("drm/i915: add syncobj timeline support")
> > Signed-off-by: Lu Yao <yaolu@kylinos.cn>
>=20
> pushed to drm-intel-gt-next.

This was pushed without any R-b, DIM should have given you a warning
when applying the patch.

I've reverted it for now, please use DIM and check the warnings before
merging stuff.

Regards, Joonas

>=20
> Thanks,
> Andi
