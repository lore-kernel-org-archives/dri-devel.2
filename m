Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242C5C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:12:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 391CE10E829;
	Mon, 13 Jul 2026 07:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.b="WBV7jahz";
	dkim-atps=neutral
X-Greylist: delayed 378 seconds by postgrey-1.36 at gabe;
 Mon, 13 Jul 2026 05:52:57 UTC
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.64.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03B1E10E562
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1783921971;
 bh=xsMiDfHY3No78dLfmPMb1cw+NhSYORJVBK/d0sBYa00=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=WBV7jahzjBx4/oZXXSB+ZExi6pl8j/sTGt7Wvf5fshgJtuk3odXx6Ky3HyBbzKGNA
 jjlXqv/5Xb9sep1s1k+VErutq/7kEVDqjG2da39NT6re7cD3vxXDt8dWL5JM/qXsWV
 ErX7ORcFPKrQmH8ZVWsKqvbPZP2VyjqASJhEoxeQ=
X-QQ-mid: esmtpgz15t1783921433tee904caf
X-QQ-Originating-IP: KGIqFQ6ZwelBHVBQsdz3AWi16EJ0V4fs0KzB/tMla+U=
Received: from PEN202512010004 ( [113.57.152.160])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 13 Jul 2026 13:43:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2535388820443823587
EX-QQ-RecipientCnt: 9
From: raoxu <raoxu@uniontech.com>
To: srini@kernel.org
Cc: amahesh@qti.qualcomm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, raoxu@uniontech.com, stable@vger.kernel.org
Subject: [PATCH] misc: fastrpc: drop channel context ref on failed open
Date: Mon, 13 Jul 2026 13:43:50 +0800
Message-ID: <DD9C99F155919095+20260713054350.3170620-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NMMSTmykDl9bgEGgFJOxAt4Kbkvw2ZUq1E1Wkn+adv2mtjA8zWOfWcUH
 lSNyKF5UafBfrMamnG9iErGLVR/LDAqA5M9hO7wn5dG+3l2Or54Ojv00KeTZrGUS5Fo1Si6
 Z17NIJrnp27sdzUFUtySMM8u9xg2SqlQ7ierndn5nsyV2+fAr/5oO/pH7NhUDL+cMmme87U
 +PSvdkXnK5SC6Nbzl4uin2VLvFT8ELDkTNNam0cWOHml547O3OzeBFDIZ6t7v72dK/Wr2vL
 AUQMuPHFWSjGsxnDQW5NeIxG23UpqsHx1wZhixFSvTD5LPRQuKrr8x3sf7nWPoBz7dSG14N
 N+A4XH+Nm6u8HDbSo/WviHKTYscGlYffd2j1A4oLDPkhEfIogscqIhOeICSqTwStVpSotag
 ATPf0RJh0k+zm/lxsz2pzHsrkx3pHG/mZlzEOkkGPgFjAyrx/Ei5zh/7WQEpdKlFs9UCXtC
 /P1OYMMYm9p0HKUPpldkvO0Q5h14xGVJ0n5aE2AbLPAGQ+83L1NlgbWcX0ZQmlAXfM4Lz5M
 f7g1zux9zHjn8xFGgxFwS49NQURCnc+NLjCimzNxMnOt71NYpwxA9C5wNjpB1InI0Fk5qY2
 ZK/ngTRxXvpvC624U+t/eeXR2lX1WqbE8Sv3rT1J4heYQZrYay6ML3gooMyDPNPPNy/gTLV
 00TA0TSS/4OTFQYGU5DsiVyWSNS7K/FFuFcajdam3MRzwHQi8Wv6JFD89AV2D22GMHb4gop
 LzNssl8C5sesR1XHWwUkbfkdFFvTLdVS46uMq1RL4mY6bE42jZ+FPmLQAZChL20B9DOhDmm
 Ng0vTuqsiv7QQsqvkxsvMQUPB5F0p3KTtI8Qu6ATkd/hOQK8YECB69tWg45AmczHxId1d2m
 SdXC04MV++gHjKYe90Bc9wIs6ritthT7QBLLQkSYMOBpcVgrTc85XTsmO/qShKME9oiyNCj
 y1GQdd+dBCxbEzJo0Lm11F/Bq9E9DYE6IJnKjgYEr+Mc0rR3brveiXOyYIp1HRmJmfktt/H
 bqTBbr4Smyr9s15WTkVkUSeKRD3oLjBj4AAJVcA5iYIZ9HaM1Bp7vsT8Yix1YM6efTPy6VO
 A==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:11:31 +0000
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

From: Xu Rao <raoxu@uniontech.com>

fastrpc_device_open() takes a reference on the channel context before it
allocates a session.  On a successful open, that reference is tied to the
fastrpc_user object and is released from fastrpc_user_free(), which is
reached through fastrpc_device_release().

If fastrpc_session_alloc() fails because no valid session is available,
open returns -EBUSY before the user refcount is initialized and before
release can run.  The channel-context reference taken earlier in open is
therefore left behind.  Repeated opens while the session pool is
exhausted can permanently pin the channel context and prevent the rpmsg
remove path from freeing it.

Drop the channel-context reference on this failed-open path before
freeing the partially initialized fastrpc_user.

Fixes: 278d56f970ae ("misc: fastrpc: Reference count channel context")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/misc/fastrpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f3a49384586d..907a87d7ca56 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1671,6 +1671,7 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	fl->sctx = fastrpc_session_alloc(fl);
 	if (!fl->sctx) {
 		dev_err(&cctx->rpdev->dev, "No session available\n");
+		fastrpc_channel_ctx_put(cctx);
 		mutex_destroy(&fl->mutex);
 		kfree(fl);

--
2.50.1

