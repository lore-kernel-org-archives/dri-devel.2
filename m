Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E8C60A2600
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xy2q0q8V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D067A10FFB0;
	Thu, 19 Nov 2026 08:04:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2612010FFB0;
 Thu, 19 Nov 2026 08:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795075452; x=1826611452;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=XJq5MA/hKpOGy8y4jxqU4YAJG05jeRxIK8HXfJaOdTU=;
 b=Xy2q0q8V1BvHOaSLVz5Fj5xyo/FsyH3sfkqgKohc3E4xYUgohVLNYFjh
 9lFxbU6zxi+plIB8WWF7hbOPjDhzb6iKohI0dVpxRIrDMVkdJUXg1wCx2
 qpdl6AdRckrCzi0PlgGcxBZUeQvcktjqrxzJV+/agnPOTZMCJNGCTFrxQ
 wGIM/9dEifq+JJmbMGDZbhQ8tOeE/d67gYxZ2oHo/06TrC3A+7MHvm3OT
 ynp3Gumoi8CxEaVc0F7Zbyl2RlMg6d6D2TEAmdDM5dW9m0BBCBQ1nc8+V
 4fIZeBkimOLaXKaRPv9GFKZmJ5LQ41r+P1jSt+iFPFcGLLgXhkB+8ZEv/ A==;
X-CSE-ConnectionGUID: otGdbubCRzObS9GkEbupFw==
X-CSE-MsgGUID: VhfHLIUYQZeQRtYLY6Afxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3804693"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3804693"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 00:04:11 -0800
X-CSE-ConnectionGUID: 9+IjBIURRrm/QG4eU2eYIg==
X-CSE-MsgGUID: NumvRLGQSam0Z47MQZjn6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="10286655"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.245.76])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 00:04:09 -0800
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261118153205.2432736-1-haoxiang_li2024@163.com>
References: <20261118153205.2432736-1-haoxiang_li2024@163.com>
Subject: Re: [PATCH] drm/i915/vma: Fix a memory leak in i915_vma_pin_ww()
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Haoxiang Li <haoxiang_li2024@163.com>
To: Haoxiang Li <haoxiang_li2024@163.com>, airlied@gmail.com,
 jani.nikula@linux.intel.com, rodrigo.vivi@intel.com, simona@ffwll.ch,
 tursulin@ursulin.net
Date: Thu, 19 Nov 2026 10:04:06 +0200
Message-ID: <179507544606.16202.12430112951192190652@jlahtine-mobl>
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

Quoting Haoxiang Li (2026-11-18 17:32:05)
> i915_vma_pin_ww() allocates bind work before retrieving the object's
> moving fence. If the lookup fails, it jumps to err_rpm, bypassing the
> fence commit at err_fence and leaking the work allocation.
>=20
> Jump to err_fence instead so the fence callbacks can release the work.
>=20
> Fixes: 8ec5c0006c50 ("Merge tag 'drm-intel-next-2022-05-20' of git://anon=
git.freedesktop.org/drm/drm-intel into drm-intel-gt-next")
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

You seem to be spamming the different kernel subsystems with patches and
never respond to any feedback, so if you could just stop and do something
else.

Regards, Joonas
