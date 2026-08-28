Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD36C624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C06C10E69A;
	Mon, 31 Aug 2026 07:00:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KWpDJZpV";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F089010F493
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 21:24:09 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso9145595e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787952248; x=1788557048; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tDbfWy3mJvr3iFz1oWIhMN0E9yCNJZGzu22x+0wJipk=;
 b=KWpDJZpVmD6nah/3um6vIWrjpC0rqMOyiBlD0jmskX/2hy5mBm7LoM3BlJ4n1EZpUN
 qh1YEdUsCXVofPFtcbsHGwqyx3reDjIIV/1Q1BDrN6biKCig3tOG91t6NxABRWJGTsBl
 fQ4YtOkj4+Rmkmn56MH1fEjahrbFHj3L0rhRW6iPI6usEVuYTMegfsWn7xUpctB72nvG
 n62IywfjxK9e79a6N01YXiDXkMvpPZS1BVXuYRhcTzu7V+tSwLcoFPHompArYfyFnXwh
 JmWr7X2Lhgh8hkXT5wQaNxEODonQyhq+LrkALo82PMK3zDTMrTK4XDrNEQ2m5nSyp6ip
 RkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787952248; x=1788557048;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tDbfWy3mJvr3iFz1oWIhMN0E9yCNJZGzu22x+0wJipk=;
 b=Dgflhsqo7bmWN7cisohUILa7PSGMK3OjbBwAjSRQ96BU73SKfhClQ6lHubghHSA5VP
 6Meno9JGN3UMckRFb9qO1yhZ5+UWJX6oFUZHWXr1YuCDkDT/bZSWmTsTVqku3w6z93gT
 ZMh4/h/M704c6fVKmEkSsqgNZbwnsPmkYZFPchdWajNJDsfCWnXbABWjsuGmEpw/wELD
 9SY+mUBktCXzwXcmqzcHNXTzrnStr+Amucfy0wTZbJWkIlYMySgoNtGhI1Bo0ryPI/l+
 vPLMtM1XoxzSwK5H6zHbodEPBxRfoyEzoXfEXy2pt63QAGPmWfLQq5e7/EH5TH08Amdy
 ZfKQ==
X-Gm-Message-State: AFuF++kfaERLYEcJE5ih6MwoIZRpFhWHdib2fSYXCTbVMQtIOflYH8na
 BJ8iyh/4IsjdJaI2tPCaqJ4FjiIljDrsE9ExqV2eFN7cUe1t41ieW3Sk+Lv+AvWOFJIfTA==
X-Gm-Gg: AR+sD10plKbrxp3zGEDdGZFjhZVpijoxsjyUF+6rZ9lDIBaG4qvzpMezcvpbo+8RgYX
 IrAScBbwCkkTEuDvQS7ZcaDhPnjsYlA0v6w/hEyQLm6zYQgEX0pWVmB7TP4FukMP+2Pvhxju3i/
 /mo+hysp0HtRjXuiji0uIPao1Km1u6wqqWrVc8Fd0qsXmL59XWSp20CmKwUP/XHV558HmzDvlTp
 7qLcJrCL3+mda9EJeORzacyfFHs1FThprT5YlsYu5qnyGcY8eFTLP8+Vz49qBCMN0POkkpM1t8b
 Ix3L1hLqjejzI1OoSFYIQ4TzL3MRoJNOSc7iWyJ82HPf2SWpHjdpWmssQSTerq/LpvOcBOjrLUR
 DNhAhVY6YQZdR6HWj1bljUr2mMndt7a2o+q3eansX2PJN0CEKGN5gkGeL0JON/HswStGpIEQX5Y
 rW9THrGUPYlXs0fr3IKTc5+u8g1qxUyyQWjTBL42sFiCaxuvgTFYO3b6ikUsZCRZSvBC8Ni2OiA
 KPf2/PTwunqVCWTu0Qe+zCeWcp960d+EIcKZVWsNwJ5FDvxjiZ0KdHZMUSCZw==
X-Received: by 2002:a05:600c:314f:b0:499:4e47:eaf2 with SMTP id
 5b1f17b1804b1-49b91c38bcfmr136182665e9.6.1787952248132; 
 Fri, 28 Aug 2026 14:24:08 -0700 (PDT)
Received: from drago.hgw.local ([2a00:1d34:ebf3:5500:6828:ce36:77ad:ae8c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b91728319sm86367475e9.12.2026.08.28.14.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 14:24:07 -0700 (PDT)
From: Deniz Aydogan <denizaydogan1902@gmail.com>
To: lizhi.hou@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Deniz Aydogan <denizaydogan1902@gmail.com>
Subject: [PATCH] accel/amdxdna: fix double-free on mailbox channel stop
Date: Sat, 29 Aug 2026 00:24:05 +0300
Message-ID: <20260828212405.13124-1-denizaydogan1902@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:00:03 +0000
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

mailbox_release_msg() frees the message with kfree() but does not
remove it from the xarray. The stop function uses two loops to walk
pending entries in cyclic order, but since released entries remain in
the xarray, overlapping ranges cause the same entry to be freed twice.

In particular, when next_msgid is 0 (the initial value after kzalloc),
xa_for_each_start() covers all entries from index 0 onward, and
xa_for_each_range() with max=(u32)(0 - 1) = U32_MAX also covers all
entries. Every pending message gets double-freed.

Use xa_for_each() to iterate all remaining entries exactly once.
At this point the IRQ is already freed and the workqueue is drained,
so traversal order does not matter.

Fixes: 3ba13f5e7180 ("Merge tag 'devicetree-fixes-for-7.3-1'")
Signed-off-by: Deniz Aydogan <denizaydogan1902@gmail.com>
---
 drivers/accel/amdxdna/amdxdna_mailbox.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
index cc8865f4e..271617347 100644
--- a/drivers/accel/amdxdna/amdxdna_mailbox.c
+++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
@@ -556,9 +556,7 @@ void xdna_mailbox_stop_channel(struct mailbox_channel *mb_chann)
 	drain_workqueue(mb_chann->work_q);
 
 	/* We can clean up and release resources */
-	xa_for_each_start(&mb_chann->chan_xa, msg_id, mb_msg, mb_chann->next_msgid)
-		mailbox_release_msg(mb_chann, mb_msg);
-	xa_for_each_range(&mb_chann->chan_xa, msg_id, mb_msg, 0, mb_chann->next_msgid - 1)
+	xa_for_each(&mb_chann->chan_xa, msg_id, mb_msg)
 		mailbox_release_msg(mb_chann, mb_msg);
 	xa_destroy(&mb_chann->chan_xa);
 
-- 
2.55.0

