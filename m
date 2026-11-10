Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E010606A321
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GPgJw/kr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD12610E0CC;
	Tue, 10 Nov 2026 08:43:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC3DD10E0CC
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 08:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794300197; x=1825836197;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ceyp6qUlPkZr8sRjiOtI55f56LZSHpjTj8wP8Vp3EyI=;
 b=GPgJw/kr2LPYj9gP6ZHiNs5yQRpoLdO2HeF+/XfiGAYxbZ4edovyMTTC
 wvvH/iONuGsPt6Q4bUFQoU60Bape1JQjX2w/sla53mROTEFU+LM2Slr39
 c2qyoqj3yUqcHdscSmvTxBPWkzHnX0h/dMluKkUOtRjzhCMF2QBf4lFHy
 hDIZMOgioK8PBJylqwRx2HImiF93Ip4o8YMDZK2lCy8IUOc7CSys2Bk7g
 8m4sU8cX5KE7M35zVarxJAtD/O8MAqdtnVs0hdv+g7io4E1sX7wzL+dq5
 xCmJ0hhuPTJqX2caa7Hgesw3UFYYO589Mwq99zw4vk82n0IgilWfCJ2tW w==;
X-CSE-ConnectionGUID: 6p3/RTDkTgubPtM8JbEcEA==
X-CSE-MsgGUID: UaN/yOfgTUGQVO6+CNvFiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3053625"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3053625"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 00:43:16 -0800
X-CSE-ConnectionGUID: nIFQ9jbdSVGDm8tLoiS2fA==
X-CSE-MsgGUID: gmGvns63SEKcxV+ySiOZSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8241688"
Received: from yufei-super-server.sh.intel.com ([10.239.92.104])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 00:43:12 -0800
From: "Yu, Fei" <fei.yu@intel.com>
To: christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org, tursulin@ursulin.net,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org,
 syzbot+95416f957d84e858b377@syzkaller.appspotmail.com,
 madhurkumar004@gmail.com, stable@vger.kernel.org, fei.yu@intel.com
Subject: Re: [PATCH v3] drm/syncobj: Limit the number of handles and use
 kvmalloc for user-sized arrays
Date: Tue, 10 Nov 2026 16:49:06 +0800
Message-ID: <20261110084906.2458016-1-fei.yu@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <3aaea7f4-62a5-435c-b1ca-35babf30a7d2@amd.com>
References: <3aaea7f4-62a5-435c-b1ca-35babf30a7d2@amd.com>
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Fei Yu <fei.yu@intel.com>

On 11/9/26 12:54, Christian König wrote:
> On 11/9/26 02:48, Yu, Fei wrote:
>> Signed-off-by: Fei Yu <fei.yu@intel.com>
>
> Reviewed-by: Christian König <christian.koenig@amd.com>
>
> Let me know if you need somebody to push this to drm-misc-next.

Thanks for the review! Yes please, I don't have drm-misc commit
access, so I'd be grateful if you could push it.

Since it carries Fixes: and Cc: stable, drm-misc-fixes was what we
discussed earlier, but drm-misc-next is fine with me too if you
prefer, your call.

I'll send the uAPI doc patch for the 1M limit against drm-misc-next
once this has landed.

Thanks,
Fei
