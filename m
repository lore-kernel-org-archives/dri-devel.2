Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4A4CDE007
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0DE410F135;
	Thu, 25 Jun 2026 07:03:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=jasonxiang.net header.i=@jasonxiang.net header.b="h0NJwydc";
	dkim-atps=neutral
X-Greylist: delayed 360 seconds by postgrey-1.36 at gabe;
 Thu, 25 Jun 2026 02:40:18 UTC
Received: from outbound.qs.icloud.com (qs-2007d-snip4-1.eps.apple.com
 [57.103.84.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B28C710E141
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 02:40:18 +0000 (UTC)
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPS id
 53A6630000B9; Thu, 25 Jun 2026 02:34:14 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQtJC0MFXgJeC0sEQwVZAFBcHA4HTytYEUoXXRVeClwXFxZWGRcNVk1TGUACWRNbEVcfHQNSHxICWkUKTV8OXh8EF0YZVQRHHl1WQh4ZAlEcVg1XQ1QEX1BJDEFQbFoARxdIHV0ZWW9QXRwOB1YYXR5BEVIDUEVcFU1YXgRTVg5CCUoFXQFZB0ALSwBYDkUARglJAkAGRlgIeRJSHlgFShlYFlRDWQ5GThkMSh1SVlEFSgxcAGgPXR1YEV0=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jasonxiang.net; s=sig1;
 t=1782354857; x=1784946857; bh=9xwfsavpZ6AjRJVASdrQrHxjcLHdD9uha06sBvvM74s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=h0NJwydc9nvZYOKGyS3xTcqmsxbSYtIqIMRvdsgW+X9slCwhkPeWlFcqQZVD72FCb7CfkN5z6t1ePg9z9KdhLwT/6nStoX8lZKaJZQ55qRQ5L062z5itH+tGS19PJ7uze6p/bjIuVuasPhbhL94gt2T5Ye/AeKZu5M+3nk9GopvLGu9uV5ZKcoFCLJa8mGwbWPR+rWrU0gWmLlX9jYMqH918CN+uD5Df51+V2nms5aM3ZVJTvvshAXSby/E0iGFp5KhwsmpBQQtIaDVMl9qqRA/4/mae7arlP41R/rWi6AUS7gqJytZdNI4pCXNcnmDeoH765FASZzhCH/VU6xR+uQ==
mail-alias-created-date: 1782291625467
Received: from JasonPC.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPSA id
 C12EA3000102; Thu, 25 Jun 2026 02:34:10 +0000 (UTC)
From: Jason Xiang <jx@jasonxiang.net>
To: Paul Kocialkowski <paulk@sys-base.io>,
	dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 Jason Xiang <jx@jasonxiang.net>
Subject: [PATCH] drm/logicvc: Fix layer_node reference leak in
 logicvc_layers_init()
Date: Thu, 25 Jun 2026 10:33:59 +0800
Message-ID: <20260625023359.26011-1-jx@jasonxiang.net>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: EMQoFXPYZ1JIXWaGB8izQ3NdQZ-v0mt7
X-Proofpoint-GUID: EMQoFXPYZ1JIXWaGB8izQ3NdQZ-v0mt7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDAyMCBTYWx0ZWRfXyqZuaI7e3vFy
 G/5f57qkx0Jf6mqKut97QcV6rk90q+VdqdoWianWQFXyWR41x4foEO8G5utg6Ax7erjT98b4aw0
 LwCxAM5oyMMjf8NngD/qdXWa5A0xPODBsdaLkoUFhYUaABXW2s37Zz89xNkCPatSAFxrqDYAbO6
 ICNGSawna6KWF6JywJVNwnNjJrCtbXJbjm3GW51mWKzUaTpDh/SjDUdNRKAjWEW5d3f6AcJCVhK
 J3Z06j2EjY5EvpTiaD/MRTNG+g/lLUDne9zD1+j0bVUv8zbwQei4X8FFCbP69LlP3NL2fr/YhAe
 UgVMCl0wVbgLn2Qb4hZ
X-Mailman-Approved-At: Thu, 25 Jun 2026 07:03:17 +0000
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

for_each_child_of_node() returns each child node with its reference
count incremented, so breaking out of the loop early requires
dropping the reference on the current node. In logicvc_layers_init(),
when logicvc_layer_init() fails, the error path releases the parent
"layers" node but not the child node 'layer_node' that the loop is
currently holding, leaking its reference. The leak has been present
since the driver was introduced.

Release 'layer_node' before jumping to the error label.

Fixes: efeeaefe9be5 ("drm: Add support for the LogiCVC display controller")
Signed-off-by: Jason Xiang <jx@jasonxiang.net>
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

base-commit: f0e6f20cb52b14c2c441f04e21cef0c95d498cac
-- 
2.50.1

