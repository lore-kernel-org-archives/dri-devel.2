Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0C9C531C9
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 04:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C51E210E0F0;
	Sat, 25 Jul 2026 03:59:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="iqhRor6s";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7247E10E0F0;
 Sat, 25 Jul 2026 03:59:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784951993; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AkEdgMgVnjZjnQFhlrCWE4guJtHtHC6nw4W1/GCBk1uaWuw/VxrpXZiM/E9r3y+xSRtHhLMEKa/o+AfTgvsOG2/NHlcvm5K3c1SyIa7Q7yjC0ML8nIcKB91ecTySsqM6wgHuw/Cj/ufTLphUcCxt0eFr1tqW1oM9Q+BJhmZHWI8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784951993;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=3W1tqnSMyQwvsS27ceKsbriLhwf0c+O3opmmpmqB0J8=; 
 b=IJahq6RDSSExjx4eRassZeF3z/BoomZWkG77Om/8qR67DMo/7C1NJhAPC97ofnzFKgAAKzHOlvMpN/kXUOAYr0nzTu6eXfhv1l8/2QRZHMh7OcfAQk82MX4vcmyJS7uEWA/RYLchSrsv5NM55lTzwoO2XnzvBDGLtNcxVsQucJY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784951993; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=3W1tqnSMyQwvsS27ceKsbriLhwf0c+O3opmmpmqB0J8=;
 b=iqhRor6sTk52JRsv9tPoxEk+5lC5xPBg7IeGMZjFWTZbgN8RNrDN2psBRG6H8CSy
 TQYK131bey/hQHELzYIs7ekOW0tXkEDn32b5nOSYYrzM7UxfUAFc/0U+Rxsju9qG5nO
 uctTZpHWfctCXLpQ++Pv1bh14m30nSkoILdH0BYk=
Received: by mx.zohomail.com with SMTPS id 1784951991074829.1841111702598;
 Fri, 24 Jul 2026 20:59:51 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH] drm/nouveau: allow allocating NVDEC channels via abi16
Date: Sat, 25 Jul 2026 00:59:12 -0300
Message-ID: <20260725035912.1016464-1-daniel.almeida@collabora.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

From: Dave Airlie <airlied@redhat.com>

Add NOUVEAU_FIFO_ENGINE_NVDEC to the abi16 uAPI and accept it in
channel allocation, mapping it to the NVDEC engine runlist.

Skip the Turing copy-engine workaround object for NVDEC channels: the
copy engines are not part of the NVDEC runlist, so the workaround
object cannot be instantiated on such channels (and is not needed
there).

This is required for NVK to implement Vulkan Video H.264 decode on top
of the NVDEC engine:

  https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/31867

Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/nouveau/nouveau_abi16.c | 14 ++++++++++----
 include/uapi/drm/nouveau_drm.h          |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/nouveau/nouveau_abi16.c
index 291203121f0c..4542d5f4ded8 100644
--- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
+++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
@@ -408,6 +408,9 @@ nouveau_abi16_ioctl_channel_alloc(ABI16_IOCTL_ARGS)
 			case NOUVEAU_FIFO_ENGINE_CE:
 				engine = NV_DEVICE_HOST_RUNLIST_ENGINES_CE;
 				break;
+			case NOUVEAU_FIFO_ENGINE_NVDEC:
+				engine = NV_DEVICE_HOST_RUNLIST_ENGINES_NVDEC;
+				break;
 			default:
 				return nouveau_abi16_put(abi16, -ENOSYS);
 			}
@@ -485,10 +488,13 @@ nouveau_abi16_ioctl_channel_alloc(ABI16_IOCTL_ARGS)
 			goto done;
 		break;
 	case NV_DEVICE_INFO_V0_TURING:
-		ret = nvif_object_ctor(&chan->chan->user, "abi16CeWar", 0, TURING_DMA_COPY_A,
-				       NULL, 0, &chan->ce);
-		if (ret)
-			goto done;
+		if (engine != NV_DEVICE_HOST_RUNLIST_ENGINES_NVDEC) {
+			ret = nvif_object_ctor(&chan->chan->user, "abi16CeWar",
+					       0, TURING_DMA_COPY_A, NULL, 0,
+					       &chan->ce);
+			if (ret)
+				goto done;
+		}
 		break;
 	default:
 		break;
diff --git a/include/uapi/drm/nouveau_drm.h b/include/uapi/drm/nouveau_drm.h
index 1fa82fa6af38..c4905b3e4e91 100644
--- a/include/uapi/drm/nouveau_drm.h
+++ b/include/uapi/drm/nouveau_drm.h
@@ -89,6 +89,7 @@ struct drm_nouveau_getparam {
 #define NOUVEAU_FIFO_ENGINE_PPP 0x04
 #define NOUVEAU_FIFO_ENGINE_BSP 0x08
 #define NOUVEAU_FIFO_ENGINE_CE  0x30
+#define NOUVEAU_FIFO_ENGINE_NVDEC 0x300
 
 struct drm_nouveau_channel_alloc {
 	__u32     fb_ctxdma_handle;

base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
-- 
2.55.0

