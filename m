Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C92606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GrKywXFX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B41A210E62A;
	Wed, 18 Nov 2026 08:00:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C193410E740
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 08:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794988826; x=1826524826;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tTTxBv3hoXdNOA1Y0DVIHQwl3ph19QI43Q2Xrf4ouYc=;
 b=GrKywXFXtDenBaiGcLQb+n3SoVovWXywYPSrhxTcJOjylC+7UeSB4hmq
 Vc4UohcNLea5wdGOtHS2hDP1WvTuERYA/k0M7GWz4rX55fGw3JKXKeRcm
 gcriFw36cIf+ceJe0Te8e6+fSbgW9UUhEvleNg6l00uu9uuD6aNEiWj8p
 DQ66VP1+CS77pmLX7YoLmeX3TulLWGu34/O9eTBnCeZe2eXCLeDgF+1VT
 UaMxihGlfp/Z3V35OFoGpkL6L7ppnLES6x+9QtXH39zxmkYMc2hFnpWQJ
 121egD709m0NptB92aio1GvIGjcRyBzCjLZnavPI5uFjPGDoVo+6Hvc3K Q==;
X-CSE-ConnectionGUID: kNhhWMZ7Q1WfvduukhHPjA==
X-CSE-MsgGUID: Xqn3937yTlKgYEtYj7sSMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3830899"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3830899"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 00:00:26 -0800
X-CSE-ConnectionGUID: PovsubFNRv2D6t//AabkIw==
X-CSE-MsgGUID: /ro3B/1+RLynA0/z8gzMaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10025235"
Received: from yufei-super-server.sh.intel.com ([10.239.92.104])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 00:00:24 -0800
From: "Yu, Fei" <fei.yu@intel.com>
To: tvrtko.ursulin@igalia.com
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com, mcanal@igalia.com,
 christian.koenig@amd.com, fei.yu@intel.com
Subject: Re: [PATCH 0/3] drm/syncobj: Allocation avoiding fast path
Date: Wed, 18 Nov 2026 16:06:11 +0800
Message-ID: <20261118080611.180520-1-fei.yu@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117103916.9101-1-tvrtko.ursulin@igalia.com>
References: <20261117103916.9101-1-tvrtko.ursulin@igalia.com>
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
> In practice there are multiple DRM syncobj operations (and/or ioctls) per
> rendered frame, and vast majority of them operates on a just a couple of
> handles, or timeline points.
>
> This series adds a fast path to avoid the temporary allocations for those cases.

Tested on next-20261117 (x86_64, KASAN + KASAN_STACK, lockdep,
kmemleak, virtio-gpu in QEMU), base and patched with the same config:

- IGT syncobj_basic, syncobj_wait, syncobj_timeline: 202/202 on both,
  identical per subtest, dmesg clean.
- A targeted test for 1..8 handles (both sides of
  DRM_SYNCOBJ_FAST_PATH_ENTRIES) on all six array ioctls: success,
  -ENOENT with the bad handle at every position, -EFAULT for bad /
  partially unmapped handle and point arrays, refcounts balanced;
  wait-all / wait-any woken by sw_sync fence callbacks and by
  WAIT_FOR_SUBMIT; -ETIME and -EINTR followed by signalling the
  fences afterwards (nothing left on the stack entries); 20 s
  wait vs. reset/signal/query stress. All pass, no splats, kmemleak
  clean.
- The 1M handle limit still holds: 1M real syncobjs succeed on all
  six ioctls, 1M + 1 returns -EINVAL.
- Every patch builds with W=1 and sparse clean, i386 too.

Note the series depends on 6ca87397aeeb ("drm/syncobj: Limit the
number of handles and use kvmalloc for user-sized arrays"), which is
in drm-misc-fixes only, so it doesn't apply to drm-misc-next yet.

Reviewed-by: Fei Yu <fei.yu@intel.com>
Tested-by: Fei Yu <fei.yu@intel.com>

Thanks,
Fei
