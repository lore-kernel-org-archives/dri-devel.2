Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8678FC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4A9E10F355;
	Thu,  2 Jul 2026 12:42:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gLJy0gXr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CFBD10F341
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 12:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782996173; x=1814532173;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=c0/yUQydlr95Z1SOUW3TktxGdz202D9d68WsPQNDvCo=;
 b=gLJy0gXrr2TbAIb/kjivldPkkdAgZ1Q3QvZ9srTgUYF+6VAHHqqbNfKb
 J80y2p4Sj41dKXcciNzwWPStHnXd8AKfBd5XbkeQ1V1wQvHWPqAKwOfCV
 wUn4m+yBhX3VK/XJJ1CTATT3NJllRcA6MYoo2hNBZzsgUwfIxbb2pAfc5
 AGpXCWYpEHM1Cbm1CZRziI8ZC3IpKWzIAJSqQgi6QWrruzTjpkZdAXZqa
 db9opx7fC/90LqeHTuJkeNXlkoIsf1V/VwPOdK07u5I0FyzoIeiuCRB4b
 Ru/wy5+Gp5ZUukrzQfagBO5t3b/buQlBEoEBYDJn4PUR5zSNu+K1Ijo9Y Q==;
X-CSE-ConnectionGUID: zUr1XFdBTbGBReQAM9kaTQ==
X-CSE-MsgGUID: mk/FUkDxQ3qCkMmkrTljGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="101173310"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; d="scan'208";a="101173310"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2026 05:42:53 -0700
X-CSE-ConnectionGUID: QZyPcHG8RMWXbphCJ2E5aQ==
X-CSE-MsgGUID: MkYCJsCBTOKMZ7LMobPsmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; d="scan'208";a="248875447"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.245.19])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2026 05:42:50 -0700
Date: Thu, 2 Jul 2026 14:42:46 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: Re: [PATCH 0/2] GPU buddy allocator test fixes
Message-ID: <akZcxufIc16r-NYH@ashyti-mobl2.lan>
References: <20260618152331.36763-1-krzysztof.niemiec@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618152331.36763-1-krzysztof.niemiec@intel.com>
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

> Krzysztof Niemiec (2):
>   gpu: Fix dependencies in CONFIG_GPU_BUDDY_KUNIT_TEST
>   gpu/tests: Add a dedicated .kunitconfig

Dave, Sima, could you please take a look here?

Thanks,
Andi
