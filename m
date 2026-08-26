Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9583C61DCD
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:45:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E42E10EF76;
	Thu, 27 Aug 2026 09:45:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="GE4y075E";
	dkim-atps=neutral
X-Greylist: delayed 427 seconds by postgrey-1.36 at gabe;
 Wed, 26 Aug 2026 07:01:54 UTC
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFADA10EC09
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Jb
 pmdGWy/go06b/bKFUmGuT6wYdXB22e+au7hEoMXwE=; b=GE4y075EiM6B+yaE6k
 2tJ4B6UqJZe4AiEQEJ1TIllTB/OukgmL6wpwDmlrl1oIkTUU14d52SWdMVkfTgqy
 dEu9dy/Kc/7SEOt076Ir0/6ythzNMbApRxPUe1X/aLkDmVpdKPh8A9DeWQmDQO54
 JegK1y05XTKogBh5mv8FJP6G8=
Received: from localhost.localdomain (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgB3+BeSjY5qs87iOA--.19815S2;
 Wed, 26 Aug 2026 14:54:10 +0800 (CST)
From: Qingshuang Fu <fffsqian@163.com>
To: Paul Kocialkowski <paulk@sys-base.io>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andy Whitcroft <apw@canonical.com>,
 Joe Perches <joe@perches.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Qingshuang Fu <fuqingshuang@kylinos.cn>, Qingshuang Fu <fffsqian@163.com>
Subject: [PATCH] drm/logicvc: fix device_node refcount leak in
 logicvc_layers_init()
Date: Wed, 26 Aug 2026 14:54:08 +0800
Message-Id: <20260826065408.617148-1-fffsqian@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgB3+BeSjY5qs87iOA--.19815S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtry5tryUAF4fZw17Ww1xXwb_yoW8Jr1fpr
 WfGas0ka12vr4ayrnYyFy5ZFy8Ww4xJrZrXr1Iyw1DXrs8A3Z8J3sYvrW5Xrn8Aa97ZFy2
 vryqgFyqvw1jkw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piXyCJUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 5iii21xldqqiywtou0bp/xtbC6hLFkGqOjZIO6AAA3w
X-Mailman-Approved-At: Thu, 27 Aug 2026 09:44:45 +0000
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

From: Qingshuang Fu <fuqingshuang@kylinos.cn>

for_each_child_of_node() holds a reference to layer_node for the
duration of each iteration and only releases the previous node when
advancing to the next one.  When logicvc_layer_init() fails, the loop
exits via the error label without ever advancing, so the reference to
layer_node is never dropped and the device node leaks.  Add the missing
of_node_put() on the error path.

Fixes: efeeaefe9be5 ("drm: Add support for the LogiCVC display controller")
Signed-off-by: Qingshuang Fu <fuqingshuang@kylinos.cn>
---
 drivers/gpu/drm/logicvc/logicvc_layer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/logicvc/logicvc_layer.c b/drivers/gpu/drm/logicvc/logicvc_layer.c
index 7f5ba000188a..e83a2aafed77 100644
--- a/drivers/gpu/drm/logicvc/logicvc_layer.c
+++ b/drivers/gpu/drm/logicvc/logicvc_layer.c
@@ -613,6 +613,7 @@ int logicvc_layers_init(struct logicvc_drm *logicvc)
 
 		ret = logicvc_layer_init(logicvc, layer_node, index);
 		if (ret) {
+			of_node_put(layer_node);
 			of_node_put(layers_node);
 			goto error;
 		}

base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
-- 
2.25.1

