Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9ABCD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 19:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 388A210F5D6;
	Thu, 28 May 2026 19:29:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="MGRs/AFg";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E40210F5D6
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 19:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779996546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P8xQYAjs5DtPCuCpT2PrJS1UzcTFSVvXTrRvI9W1Hn0=;
 b=MGRs/AFgjIHkddW7CsvFspjWkgsz8ob4YwVSNKzKB8AFMifKfcaASdwJsC3GovvCQzWJG5
 +P40250hHNz08cDSq8Zbgq023ikDghe3q4bgBONukIdJxLu5NFiy48Rx2lT+70BAudg7ur
 iS4tzHMDPOc9XtZewfGO8Y/dvNzJKV8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-XO-_kZJxMkaHR1oRtpGYRw-1; Thu,
 28 May 2026 15:29:03 -0400
X-MC-Unique: XO-_kZJxMkaHR1oRtpGYRw-1
X-Mimecast-MFC-AGG-ID: XO-_kZJxMkaHR1oRtpGYRw_1779996541
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBE3B19560AF; Thu, 28 May 2026 19:29:00 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.89.248])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 308CF19560A3; Thu, 28 May 2026 19:28:57 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, Timur Tabi <ttabi@nvidia.com>,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: "Dave Airlie" <airlied@redhat.com>,
 "Qianfeng Rong" <rongqianfeng@vivo.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Kees Cook" <kees@kernel.org>, "Simona Vetter" <simona@ffwll.ch>,
 "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Hongling Zeng" <zenghongling@kylinos.cn>,
 "Danilo Krummrich" <dakr@kernel.org>, "Zhi Wang" <zhiw@nvidia.com>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH 1/5] Revert "nouveau/gsp/rm: cleanup remaining IS_ERR_OR_NULL
 usage"
Date: Thu, 28 May 2026 15:27:15 -0400
Message-ID: <20260528192847.4077458-2-lyude@redhat.com>
In-Reply-To: <20260528192847.4077458-1-lyude@redhat.com>
References: <20260528192847.4077458-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: vFwr0QM8WKlEvyZtnnnNN_HryRCzppTjvgA85wJsQlo_1779996541
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

This reverts commit 1a80c009e27b42e8c202d4c5dbd9dad9e22af742.

Embarassingly, it seems that I completely missed a pretty big issue this
patch causes according to Danilo and Sashiko:

https://lists.freedesktop.org/archives/dri-devel/2026-May/570353.html

Where it seems this causes some machines to segfault during nouveau probe.

So, revert this for the time being.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ctrl.c | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ctrl.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ctrl.c
index aa0ebd3dfb17d..70b9ee911c5e7 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ctrl.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ctrl.c
@@ -42,7 +42,7 @@ r535_gsp_rpc_rm_ctrl_push(struct nvkm_gsp_object *object, void **params, u32 rep
 	int ret = 0;
 
 	rpc = nvkm_gsp_rpc_push(gsp, rpc, NVKM_GSP_RPC_REPLY_RECV, repc);
-	if (IS_ERR(rpc)) {
+	if (IS_ERR_OR_NULL(rpc)) {
 		*params = NULL;
 		return PTR_ERR(rpc);
 	}
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
index 0c9657cb2dd72..41301f19729cf 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
@@ -459,11 +459,11 @@ r535_gsp_msg_recv(struct nvkm_gsp *gsp, int fn, u32 gsp_rpc_len)
 
 retry:
 	rpc = r535_gsp_msgq_peek(gsp, sizeof(*rpc), &retries);
-	if (IS_ERR(rpc))
+	if (IS_ERR_OR_NULL(rpc))
 		return rpc;
 
 	rpc = r535_gsp_msgq_recv(gsp, gsp_rpc_len, &retries);
-	if (IS_ERR(rpc))
+	if (IS_ERR_OR_NULL(rpc))
 		return rpc;
 
 	if (rpc->rpc_result) {
@@ -561,7 +561,7 @@ r535_gsp_rpc_handle_reply(struct nvkm_gsp *gsp, u32 fn,
 		break;
 	case NVKM_GSP_RPC_REPLY_RECV:
 		reply = r535_gsp_msg_recv(gsp, fn, gsp_rpc_len);
-		if (!IS_ERR(reply))
+		if (!IS_ERR_OR_NULL(reply))
 			repv = reply->data;
 		else
 			repv = reply;
-- 
2.54.0

