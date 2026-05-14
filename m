Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B35ECD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 21:47:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD59310F35E;
	Thu, 14 May 2026 21:47:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="nnwyfzwj";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C9A710E111
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 09:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=0B
 UtnKvD+GeOQvoijnTlcDugeGkYx2OUGkytgoDIvW8=; b=nnwyfzwj3dQ4/YOKjq
 BZPNukpWVwJa7DlGGQ0FUCimsnIudtG49n5k7lrHbZYxrj39mV4EeYdHn2eEYSGn
 s885+KCBpgSEpmAFZnoNOVOEwTxGJ+ZBbRgZNfeG1jB+1OND5CyrElfdku4OEp6l
 /Z8lTvQIcC0mOZWUOBsaEf4JA=
Received: from neo-TianYi510Pro-15ICK.. (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wAXApbekgVqz+5QBQ--.35178S4; 
 Thu, 14 May 2026 17:16:25 +0800 (CST)
From: liuqiangneo@163.com
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de
Cc: airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Qiang Liu <liuqiang@kylinos.cn>
Subject: [RESEND PATCH 2/2] drm/dp_mst: Replace seq_printf with seq_puts for
 constant strings
Date: Thu, 14 May 2026 17:16:10 +0800
Message-ID: <20260514091611.153919-3-liuqiangneo@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514091611.153919-1-liuqiangneo@163.com>
References: <20260514091611.153919-1-liuqiangneo@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAXApbekgVqz+5QBQ--.35178S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr4kuF17XF43AFyUJF1kKrg_yoW5Xr4fpr
 ZxCFyUGw1qvFs8tr47Jw42grs8Ga9xAF1xW39xJw13X3s8Ar4DCasFqa1xtF4UGF9rtw15
 tF4q9a45GFyDWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jBlk3UUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 5olx1xxdqj0vrr6rljoofrz/xtbC4Am6HGoFkun2oAAA3N
X-Mailman-Approved-At: Thu, 14 May 2026 21:46:51 +0000
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

From: Qiang Liu <liuqiang@kylinos.cn>

Replace seq_printf() with seq_puts() when printing constant strings
without format specifiers. This is more efficient as seq_puts()
doesn't need to parse the format string.

Signed-off-by: Qiang Liu <liuqiang@kylinos.cn>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index fe72245fb9ca..d6620018d965 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -4939,12 +4939,12 @@ void drm_dp_mst_dump_topology(struct seq_file *m,
 		return;
 
 	state = to_drm_dp_mst_topology_state(mgr->base.state);
-	seq_printf(m, "\n*** Atomic state info ***\n");
+	seq_puts(m, "\n*** Atomic state info ***\n");
 	seq_printf(m, "payload_mask: %x, max_payloads: %d, start_slot: %u, pbn_div: %d\n",
 		   state->payload_mask, mgr->max_payloads, state->start_slot,
 		   dfixed_trunc(state->pbn_div));
 
-	seq_printf(m, "\n| idx | port | vcpi | slots | pbn | dsc | status |     sink name     |\n");
+	seq_puts(m, "\n| idx | port | vcpi | slots | pbn | dsc | status |     sink name     |\n");
 	for (i = 0; i < mgr->max_payloads; i++) {
 		list_for_each_entry(payload, &state->payloads, next) {
 			char name[14];
@@ -4966,28 +4966,28 @@ void drm_dp_mst_dump_topology(struct seq_file *m,
 		}
 	}
 
-	seq_printf(m, "\n*** DPCD Info ***\n");
+	seq_puts(m, "\n*** DPCD Info ***\n");
 	mutex_lock(&mgr->lock);
 	if (mgr->mst_primary) {
 		u8 buf[DP_PAYLOAD_TABLE_SIZE];
 		int ret;
 
 		if (drm_dp_read_dpcd_caps(mgr->aux, buf) < 0) {
-			seq_printf(m, "dpcd read failed\n");
+			seq_puts(m, "dpcd read failed\n");
 			goto out;
 		}
 		seq_printf(m, "dpcd: %*ph\n", DP_RECEIVER_CAP_SIZE, buf);
 
 		ret = drm_dp_dpcd_read_data(mgr->aux, DP_FAUX_CAP, buf, 2);
 		if (ret < 0) {
-			seq_printf(m, "faux/mst read failed\n");
+			seq_puts(m, "faux/mst read failed\n");
 			goto out;
 		}
 		seq_printf(m, "faux/mst: %*ph\n", 2, buf);
 
 		ret = drm_dp_dpcd_read_data(mgr->aux, DP_MSTM_CTRL, buf, 1);
 		if (ret < 0) {
-			seq_printf(m, "mst ctrl read failed\n");
+			seq_puts(m, "mst ctrl read failed\n");
 			goto out;
 		}
 		seq_printf(m, "mst ctrl: %*ph\n", 1, buf);
@@ -4996,7 +4996,7 @@ void drm_dp_mst_dump_topology(struct seq_file *m,
 		ret = drm_dp_dpcd_read_data(mgr->aux, DP_BRANCH_OUI, buf,
 					    DP_BRANCH_OUI_HEADER_SIZE);
 		if (ret < 0) {
-			seq_printf(m, "branch oui read failed\n");
+			seq_puts(m, "branch oui read failed\n");
 			goto out;
 		}
 		seq_printf(m, "branch oui: %*phN devid: ", 3, buf);
-- 
2.43.0

