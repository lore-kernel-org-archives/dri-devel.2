Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20F7CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1458310E033;
	Fri, 19 Jun 2026 11:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="T/3l93mR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8923310E033
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 11:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781868295; x=1813404295;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/tfCkFHxGDbWm8fi9SHvJTA5we4zsCXSLZQd+SJEZVo=;
 b=T/3l93mRotV5hHFv3JMaSAel+Ru2DfypL9WYrU+Rn3WHz1BDGDsS68/t
 UYwP0zFgQFT96QLesvIbNTlSWMxjOvySGrkvvLEmCvYThir3/gUIna1l7
 nsRcQ85L+ssqia/s2hy6eYB7gcnihmuXDxNLFmByUrN+QDJH9PfrZCzb1
 a1Zc54utu8XRiUIUK8HafC+fDnX+w44y86RWwMqE+ZktOJgHcgCg1hfT8
 nxsVt1noLEFTvwD9OpQdbx9Q7KMTR3tH9LtdqQGA04Tbx+2ArgTVIwuS9
 BzJQo1F2Bpc6nc0/Ed5+ZL8PczXIJez5CoFPjvOahfvnFCn2FGp7d6rwU A==;
X-CSE-ConnectionGUID: eLErJ7xQS+SZzUIxCWcAZg==
X-CSE-MsgGUID: bCjhvSeNTOSNWeqM3w8cuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="93369584"
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; d="scan'208";a="93369584"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2026 04:24:54 -0700
X-CSE-ConnectionGUID: T3SkJm7wT6ijbk+30Ub5tA==
X-CSE-MsgGUID: q9TZcO6/QkSe0QvQfb6d9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; d="scan'208";a="250529070"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.188])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2026 04:24:52 -0700
Date: Fri, 19 Jun 2026 13:24:49 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: Re: [PATCH 1/2] gpu: Fix dependencies in CONFIG_GPU_BUDDY_KUNIT_TEST
Message-ID: <ajUnAaEU-vhiF0wb@ashyti-mobl2.lan>
References: <20260618152331.36763-1-krzysztof.niemiec@intel.com>
 <20260618152331.36763-2-krzysztof.niemiec@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618152331.36763-2-krzysztof.niemiec@intel.com>
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

Hi Krzysztof,

On Thu, Jun 18, 2026 at 05:23:30PM +0200, Krzysztof Niemiec wrote:
> CONFIG_GPU_BUDDY is currently not selectable by the user, mirroring
> how CONFIG_DRM_BUDDY does it - the idea is for a driver that makes use
> of it to include a "select GPU_BUDDY" line in its kconfig.
> CONFIG_DRM_BUDDY is also selected when building with
> CONFIG_DRM_KUNIT_TEST, as it can be thought of as building a mock
> "driver" running the tests, that makes use of the buddy functionality.
> 
> CONFIG_GPU_BUDDY_KUNIT_TEST doesn't follow that logic, requiring
> GPU_BUDDY to be selected already instead of selecting it itself. This
> requires building the test kernel with another driver that uses
> DRM_BUDDY, as this is currently the only kconfig option that selects
> GPU_BUDDY. That shouldn't be required to run unit tests for a module
> now completely independent from DRM, let alone any specific driver.
> 
> Fix the dependency declaration in CONFIG_GPU_BUDDY_KUNIT_TEST to make it
> work as intended, mirroring the setup in CONFIG_DRM_KUNIT_TEST.
> 
> Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
