Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29CE606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PPLZtSRm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06F3A10E1D1;
	Thu,  5 Nov 2026 08:13:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D18610E1D1
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 08:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793866392; x=1825402392;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2Iru4H8XdSj0jlhBugEi4B6U3aBSwDnqs48wxlGEtzU=;
 b=PPLZtSRmYXbbuA6rxUQodq7dClIv/Du5Y2IQJOdyYlSDYD731WSkORzK
 I8vz5mnnhYtNOPEQbD1mmOUr/xXvbNoWT3X5N3HdP+dzkVCu1Bu++JMis
 UV9jnBM1LcAH5PEpt1wOPHCYSXtFFkt6G3I22Yjwh2QF+UbS3AWtdqXc3
 CopVFnmzZonj/x6aVa6XdtPXczd6ZVu5+ZEf471yYMH8LoTgu94Fg/zSE
 0kfIb8lxkbrP3Yo2fF/3d+odT2cbW3vYZUi0bW0MJrpsJMklEOYjJy6Y2
 GplX7haLVLXGJ7B8uMyVc9fNTaBdf6Wjyt7Fyf+/kmkwcsLd/HJZUKEbB A==;
X-CSE-ConnectionGUID: 9MDG7fCuSruRh4Vv4OFxPQ==
X-CSE-MsgGUID: RjdMZ+cUR1aEWnqstlCiRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2544153"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2544153"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 00:13:11 -0800
X-CSE-ConnectionGUID: 90Xx8q/eRS6YpbpxgQ0DCg==
X-CSE-MsgGUID: 0QaQZvT8Sj61hItdIsDXdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="7072993"
Received: from yufei-super-server.sh.intel.com ([10.239.92.104])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 00:13:08 -0800
From: "Yu, Fei" <fei.yu@intel.com>
To: tursulin@ursulin.net
Cc: christian.koenig@amd.com, airlied@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, madhurkumar004@gmail.com,
 mripard@kernel.org, simona@ffwll.ch,
 syzbot+95416f957d84e858b377@syzkaller.appspotmail.com, tzimmermann@suse.de
Subject: Re: [PATCH v2] drm/syncobj: Limit the number of handles and use
 kvmalloc for user-sized arrays
Date: Thu,  5 Nov 2026 16:18:45 +0800
Message-ID: <20261105081845.1230910-1-fei.yu@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <39be711e-cd56-4a04-87ee-6aa2a0b69779@ursulin.net>
References: <39be711e-cd56-4a04-87ee-6aa2a0b69779@ursulin.net>
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

On 04/11/2026 10:27, Tvrtko Ursulin wrote:
> On 04/11/2026 09:44, Christian König wrote:
>> On 11/4/26 04:09, Yu, Fei wrote:
>>> +#define DRM_SYNCOBJ_MAX_HANDLES        (INT_MAX / sizeof(struct syncobj_wait_entry))
>>
>> I really wonder if we should put that into the uAPI files?
>>
>> Not that userspace is potentially using it, but this is part of the uAPI
>> and makes sense for documentation purposes.

I thought about that, but I'd prefer to keep it kernel internal, at
least for this fix:

 - The value is derived from the size of a kernel internal struct and
   from the kvmalloc() size limit, so it is not the same on 32-bit and
   64-bit. To put it in drm.h I would have to replace it with a fixed
   number, and that number becomes ABI. We could not easily raise or
   lower it later.

 - Tvrtko's series below avoids most of these allocations. Once that
   lands, the right limit may be different, and an internal define is
   easier to change.

 - The patch has a Fixes tag, and keeping it out of the uAPI header
   keeps the stable backport small.

For documentation, I could send a follow-up that adds a sentence to the
uAPI struct comments, saying that count_handles above an implementation
defined limit is rejected with -EINVAL. That documents the behavior
without fixing a number. Would that work for you?

>> That kvmalloc_array() + the following copy_from_user should probably be
>> replaced by using vmemdup_array_user(). But that should of course be a
>> separate patch.
>
> Btw I tried to do that some time ago:
>
> https://lore.kernel.org/dri-devel/20251106132645.28208-1-tvrtko.ursulin@igalia.com/#t
>
> I have as local, more recent version which applies, but apparently never
> sent it.
>
> Interesting part should also be the other patches from the above linked
> series which avoid allocations altogether for the vast majority of cases.
>
> If there is interest I can re-base and re-send after this is merged.

Thanks, I wasn't aware of that series. I'll leave the
vmemdup_array_user() and points array cleanups to it, so we don't
duplicate work. Happy to test it once this fix is in.

Regards,
Fei
