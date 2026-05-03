Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FF4CD3423
	for <dri-devel@archiver.kernel.org>; Sun,  3 May 2026 00:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A7BC10E00B;
	Sun,  3 May 2026 00:03:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="nvlRp8j+";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E994310E00B;
 Sun,  3 May 2026 00:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=KgWnLf/mFwD1Hh3sBaH+YGaBoHD9/6I/6KRlAUewflQ=; b=nvlRp8j+/HTCnnNTy6Xe57wsOY
 Gt/09apg7UK5cV5SMjE3M51EklDvplc8gJ7qcDBz4Xa9n9fGauknLzlq6cnG9fLjMkCtQ//riiUpU
 9S+ho6d5iuD7orwVyImufSv6/btUuJOXg4wYqHrjzDJPr2/ysZRj8oF+pqjCfUW+uungX8jvuYmkJ
 WCxZNZlEjeQL5R3VxAZbI2ykZrRsyAmkuC8O+6KHiKE8VQfvHLjxQCB0k7Gl4qNjrJoy/UiRLnfbW
 VNUTl329wyVZnLBBeAqDCxt+bFD29C5EgVO3RCTGd3IhpZJx3YZlIyjiSuJ6bwB05mE5ZafbO7R/v
 bikF3WRw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1wJKIu-00000009wgg-3Hut; Sun, 03 May 2026 00:03:24 +0000
Message-ID: <c36e7dfb-cf62-4d21-a3b1-f54cb43e0832@infradead.org>
Date: Sat, 2 May 2026 17:03:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Randy Dunlap <rdunlap@infradead.org>
Subject: does DRM_GPUSVM require hugepages?
To: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Content-Language: en-US
Cc: linux-next <linux-next@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi,

In linux-next-20260430, I'm seeing build errors on some ARCHes when
DRM_XE=m (probably just "is set") but HAVE_ARCH_TRANSPARENT_HUGEPAGE
is not set (not selected) by the ARCH.

Does drm_gpusvm.c require hugepages?
Or possibly DRM_XE needs some kind of restriction?

I see build failures on ARCH=alpha, ARCH=openrisc, ARCH=mips (32-bit
or 64-bit), and ARCH=arm (without ARM_LPAE set).

Example:
../drivers/gpu/drm/drm_gpusvm.c: In function 'drm_gpusvm_get_pages':
./../include/linux/compiler_types.h:699:45: error: call to '__compiletime_assert_361' declared with attribute error: BUILD_BUG failed
  699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^
./../include/linux/compiler_types.h:680:25: note: in definition of macro '__compiletime_assert'
  680 |                         prefix ## suffix();                             \
      |                         ^~~~~~
./../include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
  699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
   40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:60:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
   60 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
      |                     ^~~~~~~~~~~~~~~~
../include/linux/huge_mm.h:113:28: note: in expansion of macro 'BUILD_BUG'
  113 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
      |                            ^~~~~~~~~
../include/linux/huge_mm.h:120:35: note: in expansion of macro 'HPAGE_PMD_SHIFT'
  120 | #define HPAGE_PMD_SIZE  ((1UL) << HPAGE_PMD_SHIFT)
      |                                   ^~~~~~~~~~~~~~~
../drivers/gpu/drm/drm_gpusvm.c:1560:52: note: in expansion of macro 'HPAGE_PMD_SIZE'
 1560 |                                                    HPAGE_PMD_SIZE ?
      |                                                    ^~~~~~~~~~~~~~
make[6]: *** [../scripts/Makefile.build:289: drivers/gpu/drm/drm_gpusvm.o] Error 1

where include/linux/huge_mm.h:113: says:

#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
#define HPAGE_PMD_SHIFT PMD_SHIFT
#define HPAGE_PUD_SHIFT PUD_SHIFT
#else
#define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; }) <<<<<<<<<<<<<<<<<< line 113
#define HPAGE_PUD_SHIFT ({ BUILD_BUG(); 0; })
#endif

-- 
~Randy

