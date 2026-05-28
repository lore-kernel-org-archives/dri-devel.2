Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15379CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 19:29:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FAA810F5E4;
	Thu, 28 May 2026 19:29:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="DMV4YU6+";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2D3410F5D4
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 19:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779996563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oh4yR/ss5c41je5jv3EajM1W8lREAand3plKjqUGg54=;
 b=DMV4YU6+Sy9nIz/sLWU33YKkKexd0Je4Qj9p6QUpeiDOl/u0D+K2tYh/ub6JSrKMSOqNSx
 uyCJ2grJ6zTqo+SfsM+i3DBojEhnaDqKqOpMKDQSbr6Ii8bCjaJ6Xjmno6HQ7Cq0gILRCz
 afTvHEnLR4ZYgzA0Ve6KtvCj2/RoRqI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-FtSbXF8VNDudUhug7YkZRw-1; Thu,
 28 May 2026 15:29:16 -0400
X-MC-Unique: FtSbXF8VNDudUhug7YkZRw-1
X-Mimecast-MFC-AGG-ID: FtSbXF8VNDudUhug7YkZRw_1779996553
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66EAE1800622; Thu, 28 May 2026 19:29:13 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.89.248])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F50A19560A3; Thu, 28 May 2026 19:29:11 +0000 (UTC)
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
Subject: [PATCH 3/5] Revert "nouveau/gsp/rm: cleanup WARN_ON(IS_ERR_OR_NULL)"
Date: Thu, 28 May 2026 15:27:17 -0400
Message-ID: <20260528192847.4077458-4-lyude@redhat.com>
In-Reply-To: <20260528192847.4077458-1-lyude@redhat.com>
References: <20260528192847.4077458-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 52EE-28fzOaYusZGp5oFdr_53AbeS-zU1XTmwlOe2mo_1779996553
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

This is probably too risky, see the discussion here:

  https://lists.freedesktop.org/archives/dri-devel/2026-May/570353.html

This reverts commit 6198977a78af8769d3f3108e830901325b97cf03.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c
index 9cd68f8622d36..fae08ac3b18c7 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c
@@ -55,7 +55,7 @@ r535_bar_bar2_update_pde(struct nvkm_gsp *gsp, u8 page_shift, u64 pdbe)
 	rpc_update_bar_pde_v15_00 *rpc;
 
 	rpc = nvkm_gsp_rpc_get(gsp, NV_VGPU_MSG_FUNCTION_UPDATE_BAR_PDE, sizeof(*rpc));
-	if (WARN_ON(IS_ERR(rpc)))
+	if (WARN_ON(IS_ERR_OR_NULL(rpc)))
 		return -EIO;
 
 	rpc->info.barType = NV_RPC_UPDATE_PDE_BAR_2;
-- 
2.54.0

