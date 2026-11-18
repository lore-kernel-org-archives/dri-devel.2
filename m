Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4684160A2601
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mBvUnD2v
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EF9610E153;
	Wed, 18 Nov 2026 15:02:38 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28F0810EC3E
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=aF
 dQfitX5kqFFj4LEjeWDFgKXwo2yxAJjfPXDJoFef0=; b=mBvUnD2vdZwRZqqJrx
 Ioh2enMq8o7pxbMdycdk/+D3jVViY1KIWb2ql8SqYtr8TYUrVP7yviSDAT6fnWfV
 vaWlvQLzE8MzkrwvGYGxE0vlMNYUQE9wqitjbPi+YqNUBgQVOuQvRPh2E/A9UlPi
 ubA5C/hqo5tFHDHVpTBk4RVfc=
Received: from localhost.localdomain (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PygvCgDnDnyfvf1qxRLhGg--.65352S2;
 Wed, 18 Nov 2026 23:00:49 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: dianders@chromium.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] drm/bridge: ti-sn65dsi86: Fix DSI host node reference leak
Date: Wed, 18 Nov 2026 23:00:45 +0800
Message-Id: <20261118150045.2414052-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgDnDnyfvf1qxRLhGg--.65352S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtryfGw43ArWfKF17Ww17Jrb_yoWDWrc_CF
 sYq3yxJrs8Ars2gFsrAw4a93yay3Z0gFWkKF18Ka93t3y3Zry7W34S9F95Xr97uF4UJF9r
 A3yDXF1UZw13AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRtpnmDUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7gGxIGr9vaEqhAAA3b
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

ti_sn_bridge_parse_dsi_host() acquires a reference to the remote DSI
host node with of_graph_get_remote_node(). If ti_sn_attach_host()
fails, the probe error path removes the bridge but does not release
this reference.

Call of_node_put() after removing the bridge in the probe error path.

Fixes: c3b75d4734cb ("drm/bridge: sn65dsi86: Register and attach our DSI device at probe")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 48b83df9aed6..f4cf3b4af876 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -1465,6 +1465,7 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
 
 err_remove_bridge:
 	drm_bridge_remove(&pdata->bridge);
+	of_node_put(pdata->host_node);
 	return ret;
 }
 
-- 
2.25.1

