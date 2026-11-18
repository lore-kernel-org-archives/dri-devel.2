Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D7B606A332
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DPMzxxZ9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DEE810E0FE;
	Wed, 18 Nov 2026 08:00:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A739A10E0FE
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 08:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794988843; x=1826524843;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OGP9MnUFhiOC/MUPQqHDu9TzC6N27uP6EG0X2bLZiGc=;
 b=DPMzxxZ9KR9rdb2bYmLfZsHzxmkVgpVpMa5pz+N5H7Zt9c+WKJdBwf+x
 nN/hznTCVf6MUpnbGfpzCE0zi3tDTiZfNYzquheZyDbBsakBAQkTHxYnZ
 PkGcFHs23KxSMilPG4bdv0u1zch3ovQSl55PKyvmKqxjHBMBtsk0i+OvF
 FlnjvwrH1Me8tU87KgalgE7C8PIjIS7kxQl0v47O6bF6ksylKCTKIfW7A
 2wchzESG8W1n9kRRf384Zf4hZpMh7iKs54cONQxQNHWDo23fSxCDA+MpW
 rQgmV6/LGNnvMW5kDJSBM0xdajDYewOUZ9TRTJU3az7QBjNzWNYP86aj1 w==;
X-CSE-ConnectionGUID: sWGE5gXCQpqUVGubgcM6VA==
X-CSE-MsgGUID: hqvXLQ13TZiKK2+b6PS5HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3830917"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3830917"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 00:00:43 -0800
X-CSE-ConnectionGUID: owEGpU2/QBewJXEO0zbDBg==
X-CSE-MsgGUID: QCW5SV+gSPyWzRKBngCq/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10025285"
Received: from yufei-super-server.sh.intel.com ([10.239.92.104])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 00:00:40 -0800
From: "Yu, Fei" <fei.yu@intel.com>
To: tvrtko.ursulin@igalia.com
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com, mcanal@igalia.com,
 christian.koenig@amd.com, fei.yu@intel.com
Subject: Re: [PATCH 2/3] drm/syncobj: Add a fast path to
 drm_syncobj_array_wait_timeout
Date: Wed, 18 Nov 2026 16:06:26 +0800
Message-ID: <20261118080626.180717-1-fei.yu@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117103916.9101-3-tvrtko.ursulin@igalia.com>
References: <20261117103916.9101-3-tvrtko.ursulin@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Fei Yu <fei.yu@intel.com>

On 11/17/26 10:39, Tvrtko Ursulin wrote:
> Running the Cyberpunk 2077 benchmark we can observe that waiting on DRM
> sycobjs is relatively hot, but the 96% of the calls are for a single

Nit: "sycobjs" -> "syncobjs".

> Therefore lets add a fast path to bypass the kcalloc/kfree and use a pre-
> allocated stack array for those cases.

These are kvmalloc_objs()/kvzalloc_objs() and kvfree() by now.

The stack entries are always unlinked in cleanup_entries before the
function returns, so their lifetime is the same as the kvfree'd array
before.

Reviewed-by: Fei Yu <fei.yu@intel.com>

Thanks,
Fei
