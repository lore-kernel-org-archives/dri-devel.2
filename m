Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744E9606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 07:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EVFy8hqO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A74F10E417;
	Fri, 27 Nov 2026 07:53:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF5A710E417
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 07:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795765990; x=1827301990;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CC//b7z1735TYma7APpCEvEt+hwk5NhZ3JvuzBiCLfc=;
 b=EVFy8hqOmD9zZ9hYGwHXgWhqbofX1tcXTEJLWc8sDIDBBvol6wy37cJA
 MH9ga8loHCYvR0iixi85dCGPvghnzNxfCmpwNrBIfjkJJqnirY9FiMlCw
 0t654bdq0nxSqnCAgYqawcpUY1wJCeTRgv0xQ09IzSkOcsEAHfpdBV/mk
 aF3dlDZA8fbXMsZF52+7sKNEdJK8BUjODlExPJYYkdOIpXTWTiAr0IpCn
 1KaTD0sThaWlNtGhJ8+XcY5SFxTGaOZCmPcF35+0zQxUyVvm/CmIgtwT9
 wAHzurd4gZM7kIX6Zf1HRKVhefnH1ec4tPKV3KSgL/4bsJWOlT1waTHxV A==;
X-CSE-ConnectionGUID: IACfYP58Ro2vm95/689D4w==
X-CSE-MsgGUID: 64+qN9gzRNGrcuKkZTutLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4639642"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4639642"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 23:53:10 -0800
X-CSE-ConnectionGUID: tzzQhgL4Rt2xTSN0nAVsww==
X-CSE-MsgGUID: MurWGw6zT2y4tSGYmKo6bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; d="scan'208";a="12338200"
Received: from yufei-super-server.sh.intel.com ([10.239.92.104])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 23:53:07 -0800
From: Fei Yu <fei.yu@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: Re: [PATCH 0/7] DRM syncobj scoped cleanup and fast path
Date: Fri, 27 Nov 2026 15:58:58 +0800
Message-ID: <20261127075858.1868896-1-fei.yu@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126111117.67342-1-tvrtko.ursulin@igalia.com>
References: <20261126111117.67342-1-tvrtko.ursulin@igalia.com>
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

On Thu, Nov 26, 2026 at 11:11:10AM +0000, Tvrtko Ursulin wrote:
> Syncobj IGT pass, light gaming and light desktop as well, and there are no
> kmemleak reports. Nevertheless this version is a bit more invasive so if the
> approach is looking good a careful review will be required.

Tested patches 1-6 plus v2 of 7/7 on v7.4-rc4 (x86_64, KASAN +
KASAN_STACK, lockdep, kmemleak, failslab/fail_page_alloc/fail_usercopy,
virtio-gpu in QEMU), base and patched with the same config:

- IGT syncobj_basic, syncobj_wait, syncobj_timeline: 202/202 on both,
  identical per subtest, dmesg clean.
- The targeted test from the previous version, 1..8 handles on all
  six array ioctls (success, -ENOENT at every position, -EFAULT for
  bad / partially unmapped handle and point arrays, sw_sync and
  WAIT_FOR_SUBMIT wake-ups, -ETIME / -EINTR followed by late
  signalling, 20 s stress), and 1M handles OK / 1M + 1 -EINVAL:
  all pass on both, no splats, kmemleak clean.
- Since the error paths are what changed most, I also ran every
  ioctl with n = 1, 2, 4, 5, 8 under fail-nth, failing each
  allocation / user copy in turn (~340 injected faults on the
  patched kernel, among them partial dma_fence_chain_alloc() in
  timeline_signal and the kvzalloc / vmemdup fallbacks above 4
  entries), plus blocking WAIT_FOR_SUBMIT waits the same way. Every
  call returns -ENOMEM / -EFAULT or succeeds, each syncobj can be
  destroyed exactly once afterwards, no KASAN report, kmemleak
  clean. Same on base. A NULL handles pointer still gives -EFAULT,
  and a NULL points pointer behaves the same as before for n = 1..8.
- Every patch builds with W=1 and sparse clean, i386 too.

So whatever the outcome of the discussion on 2-5, the scoped
conversion did not introduce any error path bug in my testing.

On points when user_points is NULL (2/7 and 4/7): with 7/7 that is
a memset of at most 32 bytes on the stack for n <= 4, so skipping
it only matters for the slow path.

Stack (KASAN build, so inflated): the wait path goes from 640 to
1160 bytes (wait_ioctl 184 -> 296, array_wait_timeout 280 -> 688),
timeline_signal_ioctl 224 -> 472, the other ioctls +104..+112,
array_find 88 -> 224.

Tested-by: Fei Yu <fei.yu@intel.com>

Thanks,
Fei
