Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E71C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8757B10E29B;
	Fri, 21 Aug 2026 08:48:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="DSwuXfZ9";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF3D910E29B
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 08:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=hw
 dc5E8K+IoWSlPWuVB6qjWL7+TyiJkCO+IOkAfA8OI=; b=DSwuXfZ94xJfazvUws
 VPz2a6d9Lh/teClzp9r2UpmGNkJwWssyhcJI77t4VxHa9V84BC4PkgRtoM1GBw82
 Y4b6bk1DPlotrtamh5M6O4ZPchwHOxxyb2aHe/TRXAfPEzoGkH6jja28x854jCjv
 gP0iQn3ebd5gCzrh0oUsC5Y+o=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wDXzTSnEIhqUTTCCw--.40021S2; 
 Fri, 21 Aug 2026 16:47:36 +0800 (CST)
From: oushixiong1025@163.com
To: Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] drm/sched: Fix incorrect test description in
 drm_sched_basic_cases
Date: Fri, 21 Aug 2026 16:47:33 +0800
Message-Id: <20260821084733.541572-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXzTSnEIhqUTTCCw--.40021S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFW3ur1rZF1UKFyrXrWxtFb_yoWkJFXE9F
 4rKrnxXrWUAFnF9w1xtF45ZrW2kay7tFyxJw1qqw4fJw45ZF98GFZ7ur17Xr4agFy2vF93
 tws3KFWYyrsxujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8a0PDUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC-gjq+WqIEKj8HQAA3e
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

From: Shixiong Ou <oushixiong@kylinos.cn>

The second test case in drm_sched_basic_cases[] has num_entities = 1
but its description claims "across multiple entities".  Fix it to
accurately reflect that the dependency chain operates within a single
entity.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/scheduler/tests/tests_basic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/tests/tests_basic.c b/drivers/gpu/drm/scheduler/tests/tests_basic.c
index da5c4952780f..34bbb2c27913 100644
--- a/drivers/gpu/drm/scheduler/tests/tests_basic.c
+++ b/drivers/gpu/drm/scheduler/tests/tests_basic.c
@@ -90,7 +90,7 @@ static const struct drm_sched_basic_params drm_sched_basic_cases[] = {
 		.num_entities = 1,
 	},
 	{
-		.description = "A chain of dependent jobs across multiple entities",
+		.description = "A chain of dependent jobs in a single entity",
 		.queue_depth = 100,
 		.job_us = 1000,
 		.num_entities = 1,
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

