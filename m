Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1ABC54F54
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F82710E7E2;
	Tue, 28 Jul 2026 07:21:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.b="RVfP6qDs";
	dkim-atps=neutral
X-Greylist: delayed 401 seconds by postgrey-1.36 at gabe;
 Tue, 28 Jul 2026 05:49:42 UTC
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AAEE10E519;
 Tue, 28 Jul 2026 05:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1785217778;
 bh=wUN3O4Cjd2YkLgCBSrc7QiWQMRHH9tGXZA/AAXTLcYU=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=RVfP6qDsXr4Fft2TmSLHS75H1+i72dRSwTyMF0vKyOLPSmuY23ErzCw01ZyGrcMyH
 u9u3M2HqgEILQni79Fm6iDGCBdS1UEnT8iLlSPCZz9QXiLXRY2iCkHDvBMzxSQgOoK
 GLT4GaQL9j5k9lw7S9ToXrGQEoCEV4q+IFM7b1ew=
X-QQ-mid: esmtpgz15t1785217322t2610437e
X-QQ-Originating-IP: Sls0RiQYBtOqLxTwckwD+CKNI4DVly88b/yLqvNA1Ic=
Received: from localhost.localdomain ( [1.202.39.170])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 28 Jul 2026 13:41:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13876092162116608539
EX-QQ-RecipientCnt: 12
From: ZhaoJinming <zhaojinming@uniontech.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Kees Cook <kees@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 ZhaoJinming <zhaojinming@uniontech.com>
Subject: [PATCH v2] drm/i915/userptr: Fix user pages leak on get_pages failure
Date: Tue, 28 Jul 2026 13:41:52 +0800
Message-Id: <20260728054152.140524-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MrfJYRspGRl/30oNEJDuOTqncs5/GTP2xJBHalzHvHd3cBhqM0d0mMkj
 jXGppLzrqlz0ok3Fs6yQPGf8q5imEHrtnAYOAaqwFEvB26exEoikuG8zJGZF5QnoLcBClah
 02d2M5lyoBmM0SHItfGdRMp2Gl7XrQNcxEx/ac6lAWOnUoS8TFyu/a4VcPzdJO0jm4PCyay
 gLDTbANH9I6eSJUvi4FyXmDrO9xvdk33hPZGUn3rQs6aEwTBwY6VSWBFfuMZIF6pemzc4XT
 CYjCOZjQtESTjwnPDER7ZodyvrzhlA1CNTbxOzUw3FFIMrT5e6srwF71T5/4BpzpfMG3Dgu
 QH8rBqP9q7KYK/MY5qO3ih5jfNVwL3Pcl333jJzjUrXBqbql05C9ZBce1sW75cJagzDMB9H
 HuYJtG7N0t5u+CjAZ03D6WPW6nFSu90/7Tyu7dslxZt1pRjlAvWjuHn1DkfXnKkL+5VB9sP
 KlhNviN2PwyQqAxTyhCDtQUmK0FW8Tuewc3wR9+1dF0Cay2NEpqVWNS12ridLqIMS4Y7I2h
 bdgx1Q49TZX1XQsleQczjvfS5xqC2w32ykhi64tdDciQnB6vL7eFDTBBRaB47BgFSk0kU9G
 WbFm2c2Z0ci0ELol/XIakmXGprUck9wox4nEpQJHoWSOPxy5UDIVnHaM+OFFiydmZ2501aF
 xNH0uplOQ3Ea88tD73a/Dr35VKud4WmlVH50TQ6CpHDo8KysSafPzNWeMWAYybRiQxvrt/8
 5PbaFx2h5mRU2a3ljwsfI2eAwDFxpWPUvbh2jl1mbrnHGbL/ouWb+otnfWpLAPoeoLjj6pa
 Fvsd+pFAedqH7O7IITiTNJEhJ19LxoPV82sim2ggdqnI0xP3zQjd3qP5X2BLTDZWJx4htR6
 /Av6McXCtMmyoieV+/wnCyH33vuxv77kz+6W/CoWsDinMxS3Pv25DTbKyr5uvx6QKP0rUMD
 IYZvyiSsbSnc0qMBnWzmP0LzrNxZfpWCKYpFPvPY+ejJcVX6yUi7H1O67NuSzd5wvlRIU3K
 tsVPZ1u9XwBXPDNOTC4IWb9zvRA8M=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Tue, 28 Jul 2026 07:21:09 +0000
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

When ____i915_gem_object_get_pages() fails inside
i915_gem_object_userptr_submit_init(), the pvec containing pages
pinned by pin_user_pages_fast() was never freed:

1. obj->userptr.pvec was set to the pinned pages
2. The local pvec variable was NULLed
3. ____i915_gem_object_get_pages() failed, but its internal
   i915_gem_object_userptr_drop_ref() only decremented page_ref
   from 2 to 1, not triggering the pvec cleanup
4. The unconditional obj->userptr.page_ref-- brought page_ref
   to 0, but the pinned pages remained referenced only by
   obj->userptr.pvec with no path to reclaim them

Additionally, the cache hit path could return success on a
subsequent call despite page_ref being 0, leading to a
GEM_BUG_ON(obj->userptr.page_ref < 0) crash in drop_ref when
the pages were eventually invalidated.

Fix by calling i915_gem_object_userptr_drop_ref() on the
get_pages failure path, which properly decrements page_ref
from 1 to 0, triggering the pvec cleanup. Make the page_ref--
after the if block conditional on success, since drop_ref
already handles the refcount on failure.

Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
index 043095f93ac6..7d2750528485 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -292,9 +292,12 @@ int i915_gem_object_userptr_submit_init(struct drm_i915_gem_object *obj)
 		obj->userptr.notifier_seq = notifier_seq;
 		pvec = NULL;
 		ret = ____i915_gem_object_get_pages(obj);
+		if (ret)
+			i915_gem_object_userptr_drop_ref(obj);
 	}
 
-	obj->userptr.page_ref--;
+	if (!ret)
+		obj->userptr.page_ref--;
 
 out_unlock:
 	i915_gem_object_unlock(obj);
-- 
2.20.1

