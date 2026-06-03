Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A6FCD6E4A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:42:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C04510F755;
	Wed,  3 Jun 2026 01:42:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="irk8G2By";
	dkim-atps=neutral
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com
 [91.218.175.189])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C21C910F754
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 01:42:49 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1780450554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U+b6EsUk6mnaihwNh072DINdQhDt8B83hqlt9kpNg+0=;
 b=irk8G2By6NZYDw+k/5sF/XMdowE8yeFHhJi2cWK6kwuXrmNzobkD/2gdZUHMk6mIsjDXSw
 84II/gwyUuK89DBhjl8fcWf80Kdhra7ux3n7L5bnmaTMCHpnEuv6Sn/T5q1m54LV3DC0ES
 ar9IOfGNfoQtJC6+4aDcXko8E7zPd7k=
From: Jackie Liu <liu.yun@linux.dev>
To: mamin506@gmail.com,
	lizhi.hou@amd.com
Cc: dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] accel/amdxdna: fix error code being silently swallowed in
 hwctx status queries
Date: Wed,  3 Jun 2026 09:35:43 +0800
Message-ID: <20260603013543.94835-2-liu.yun@linux.dev>
In-Reply-To: <20260603013543.94835-1-liu.yun@linux.dev>
References: <20260603013543.94835-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

From: Jackie Liu <liuyun01@kylinos.cn>

Both aie2_get_hwctx_status() and aie2_query_ctx_status_array() iterate
over hardware contexts calling amdxdna_hwctx_walk() with a callback
that can fail with -ENOMEM (allocation failure) or -EFAULT
(copy_to_user failure). When the walk fails, the loop correctly breaks
but the functions always return 0 to userspace, swallowing the error.

This means userspace receives no indication that the data may be
incomplete or that the operation failed. Save the error code and
return it to properly propagate failures to userspace.

Fixes: 81233d5419cf ("accel/amdxdna: Fix uninitialized return value")
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 drivers/accel/amdxdna/aie2_pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index 4500b9ccb02e..0ff87fafd049 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -908,7 +908,7 @@ static int aie2_get_hwctx_status(struct amdxdna_client *client,
 	struct amdxdna_drm_get_array array_args;
 	struct amdxdna_dev *xdna = client->xdna;
 	struct amdxdna_client *tmp_client;
-	int ret;
+	int ret = 0;
 
 	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
 
@@ -923,7 +923,7 @@ static int aie2_get_hwctx_status(struct amdxdna_client *client,
 	}
 
 	args->buffer_size -= (u32)(array_args.buffer - args->buffer);
-	return 0;
+	return ret;
 }
 
 static int aie2_query_resource_info(struct amdxdna_client *client,
@@ -1105,7 +1105,7 @@ static int aie2_query_ctx_status_array(struct amdxdna_client *client,
 	struct amdxdna_drm_get_array array_args;
 	struct amdxdna_dev *xdna = client->xdna;
 	struct amdxdna_client *tmp_client;
-	int ret;
+	int ret = 0;
 
 	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
 
@@ -1131,7 +1131,7 @@ static int aie2_query_ctx_status_array(struct amdxdna_client *client,
 	args->num_element = (u32)((array_args.buffer - args->buffer) /
 				  args->element_size);
 
-	return 0;
+	return ret;
 }
 
 static int aie2_get_array(struct amdxdna_client *client,
-- 
2.54.0

