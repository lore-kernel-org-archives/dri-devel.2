Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C1B606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 05:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Oh1WUifr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC9B210E3CF;
	Fri,  6 Nov 2026 05:29:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD00810E108
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 05:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793942952; x=1825478952;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w+0WC+LRb1srNFS4rQ5m5791sS62cyuQd92x1Y3ZVEo=;
 b=Oh1WUifrCjeKSD3V+oV+LG3SkDOn0PpGDEqEAxVPs9ttiueJWpIuzX7d
 CcwNUPrbg3prL3Lr7ivOU7s01/dWV2NpD7wK13e9E8H0vamv7jPG20v/7
 +VWYlKpu6diii1rev/tVudndZkhkJKq7nk5uIKmsFPFNze+H1sRMR26CS
 9R203CmrdjdEsbwHm5KnMr883h8O8WfmCBC45HzmkK/QIaVnT35ZmWgx1
 7J5SZKYxqwS/jgxoy3eECeMODODt0MfnoWH5341tVcpoa/hRHid3WeE3O
 kXAZCGN+z0xqTFyYFARWL2Hqr/SOz/tT2NFff7ar6cC+rf4n56cnklfQE Q==;
X-CSE-ConnectionGUID: UBwIn9o3SVG9Q4d1uDBxQA==
X-CSE-MsgGUID: oxSSsq2lS+yV+6Ss389b8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2789106"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2789106"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 21:29:11 -0800
X-CSE-ConnectionGUID: utXC/fR6RMGr6iOPsY9+9A==
X-CSE-MsgGUID: dWZS+NHRQRe0Ue3TXhMhGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7534559"
Received: from yufei-super-server.sh.intel.com ([10.239.92.104])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 21:29:08 -0800
From: "Yu, Fei" <fei.yu@intel.com>
To: christian.koenig@amd.com
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org, fei.yu@intel.com,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 madhurkumar004@gmail.com, mripard@kernel.org, simona@ffwll.ch,
 syzbot+95416f957d84e858b377@syzkaller.appspotmail.com,
 tursulin@ursulin.net, tzimmermann@suse.de
Subject: Re: [PATCH v2] drm/syncobj: Limit the number of handles and use
 kvmalloc for user-sized arrays
Date: Fri,  6 Nov 2026 13:35:03 +0800
Message-ID: <20261106053503.1437526-1-fei.yu@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <a6a2ca76-94dc-4616-8160-d756713e22b9@amd.com>
References: <a6a2ca76-94dc-4616-8160-d756713e22b9@amd.com>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Fei Yu <fei.yu@intel.com>

On 11/5/26, Christian König wrote:
> On 11/5/26 10:12, Tvrtko Ursulin wrote:
>> On 05/11/2026 08:18, Yu, Fei wrote:
>>>  - The value is derived from the size of a kernel internal struct and
>>>    from the kvmalloc() size limit, so it is not the same on 32-bit and
>>>    64-bit.
>
> Oh that is a really good point, but most certainly a bad idea.
>
> This means that code working on 32bit then suddenly fails on 64bit, not
> something we should do.

Agreed, a fixed number is better.

> I think I prefer a fixed number here. Something reasonable large enough,
> like 64k or similar, should do for backporting.

One concern with 64K: today only wait and timeline_wait break above
~64K handles, because of the 64-byte wait entries. The other ioctls
only allocate 4-8 bytes per handle, so on x86_64 reset, signal, query
and timeline_signal currently work up to ~512K handles. In my v2
testing, reset, signal and timeline_signal on 200000 handles succeed on
the base kernel. With a 64K limit they would start returning -EINVAL
after this fix, which I would rather avoid in a stable backport.

So I would suggest SZ_1M instead:

 - it is above what any of these ioctls can handle today, so nothing
   that works now starts failing;
 - 1M wait entries are 64 MiB, far below the kvmalloc() INT_MAX limit;
 - it is the same on 32-bit and 64-bit.

If you still prefer 64K, I'll go with that.

> But I would still use a fixed number and maybe a static assert that we
> don't hit the kvmalloc limit when we allocate that fixed number of
> structures.

Will do. Something like:

  #define DRM_SYNCOBJ_MAX_HANDLES	SZ_1M
  static_assert(DRM_SYNCOBJ_MAX_HANDLES <=
                INT_MAX / sizeof(struct syncobj_wait_entry));

Plan for v3, for -fixes:

 - fixed DRM_SYNCOBJ_MAX_HANDLES plus the static_assert, define kept in
   drm_syncobj.c;
 - keep the kvmalloc() conversion;
 - update the commit message accordingly.

The uAPI documentation of the limit will be a separate patch for -next
once this has landed.

Regards,
Fei
