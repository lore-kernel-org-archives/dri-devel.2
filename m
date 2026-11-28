Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44128606A31F
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=OoAX4mmU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 862A210E343;
	Sat, 28 Nov 2026 09:35:00 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF5110E343
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 09:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=hB
 Y0ZMqRZmkIhi198k9dX9tGPXJ7CqRD+6OcWXXrb9k=; b=OoAX4mmUken0+na1+v
 BQ2FIPyQ9bOiZD8puUXzS/UiSfo70CVzuo/7LN9ia4H2E7LEE0NXjJe7yZDCBEKd
 A97RmP2cBuca8/YnwqX7W/XBi0afyp0O4+f3bny2gNJi/GnnIxY+XPSZz9mPAeXG
 LQthWaCFU8lGB/rQxh1CjmJv8=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wD33xYVoAprc0BGLg--.29209S2; 
 Sat, 28 Nov 2026 17:34:16 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 ogabbay@kernel.org, jacek.lawrynowicz@linux.intel.com,
 quic_pkanojiy@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] accel/qaic: Free the DBC buffer on management transfer errors
Date: Sat, 28 Nov 2026 17:33:22 +0800
Message-Id: <20261128093322.1217738-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD33xYVoAprc0BGLg--.29209S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur48Zw48GrW8AFyxGrW8Crg_yoWDZwc_Ga
 9xCF18G343KryY9rnIyF1fZF9akr93ZF1vgF1vqF97AFW3XryYqFyUCFWrZa4rZFy7Ca43
 G3WDt3y5Ar18JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRuUDJ3UUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7hiL+WsKoBhw8wAA3e
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

encode_message() may allocate a buffer in encode_activate(). The
buffer should be freed if something fails later in qaic_manage_msg_xfer().
Add free_dbc_buf() under label lock_failed to do so and retain it
on success for here because the buffer should not be freed if no
failure. 

Fixes: 129776ac2e38 ("accel/qaic: Add control path")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/accel/qaic/qaic_control.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/accel/qaic/qaic_control.c b/drivers/accel/qaic/qaic_control.c
index 2ccc55486aac..f322887ec53e 100644
--- a/drivers/accel/qaic/qaic_control.c
+++ b/drivers/accel/qaic/qaic_control.c
@@ -1250,6 +1250,8 @@ static int qaic_manage_msg_xfer(struct qaic_device *qdev, struct qaic_user *usr,
 
 lock_failed:
 	free_dma_xfers(qdev, resources);
+	if (ret)
+		free_dbc_buf(qdev, resources);
 encode_failed:
 	spin_lock(&wrappers->lock);
 	list_for_each_entry_safe(wrapper, w, &wrappers->list, list)
-- 
2.25.1

