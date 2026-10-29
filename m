Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D26606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 21:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Nx3oFTba
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B33CF10E1D2;
	Thu, 29 Oct 2026 21:57:15 +0000 (UTC)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57F8210E1D2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 21:57:09 +0000 (UTC)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-3acb11973c3so45620a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793311029; x=1793915829;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BtE8gEpGXXyQgany7PV79KzxRGZPRiw2gHz+ihjMaWE=;
 b=YdO8dN3XvY3kw2m6NezkDbZrQCZNzaCM01PrDvMqL1IH6vMxw3rmxzRGRbBFb5d986
 MPIL9IYeUc4irH+DDo6761q3QueGPx26HRagUvcrybBzm7W4K7OSx88aSJ+Lhc3tvfdd
 6C64wwL0DqJASUiCwOqWAs0mXDQrBN2aJGXAkHoFd7iSIzd8btjkvOStULK0xwtVKCFW
 7z4m1G4mEo0mrMiXhJfyTKhwOHQmtjd1N0D6l+hq8x7iq/lY+/XMP/eIYBZ4PhJonT8P
 HKfb9KlfpW6Cj95pb0TT8/r0Ozo49+EJG7Z7f97NqkU64mnmjQJ9lLbmNcLQp7qhPp+h
 yByg==
X-Gm-Message-State: AFq9FYLBqA8eobpyVcohQhdHeuphwyZoQEhgfHtT2SkR9lHmgtaI40u0
 vlNmex3y1c2b9DaEF6wVEN9qzBRYcewZyCD32SUOBbyuG1iWbWhVu8TAlUKTt6e7Uu/6TL/kFvL
 uNq1nf1jzwyl3yJ+U24NQrw2lNJSzddBf17wdmLdtpoObAe2wu1Y8I89vNyboQINGuNVV+bm2Rt
 Cca1GesY9tZx42rVAzi8s2OfjH1Yyr9Mkzz62wbO+bVmhAZTUgQdEKLbWTqrECHHp6YqaiqblN5
 NLGW/tbjaIJF5G3tWmO
X-Gm-Gg: AYBFou3/qvSRlYEFzTZz269aHUiqGPt7y1hPN4tH5WMm6jTlJB7iGa+JWazbQowT7as
 ljwptVSZVSKjWbyQ2Pa3c584ze+Mtr1qZg3y+XHrrtEhraiQtbVDr/kteKQVuIlroulcBY7Z2XD
 1FJyTYkX6o+MPrtr3nh0sN8OqB992Ve8UCprECqivCYybcDYawh0O6AJndfGPxpiyfhffI5MQw2
 6KSOLabq1OjSZ7hbQoC9zu67UjBe9/vwNC59r5W+P7KvBihtfnsokA/TFWe9cLV7aJPmOKmBG4C
 TT8Y4IFXlOEGg8WguGQcoHXMfLa85iPuYMLFXnKhV2liAf/hwcTh/+K6/hgTaIlV+0nAGPlBOoU
 YfIP0H64vZrHaMn9ZLd1MV5gFpnF49fPzUZqh76R1S5nxogu77vrqvKBoKZM/679L+zxrbq1PMo
 D0oBqaLYDyXSDZa4P+dujLj/cPHMM659um
X-Received: by 2002:a17:90b:4d05:b0:3ac:7c4d:8be1 with SMTP id
 98e67ed59e1d1-3ae897f8a31mr219343a91.62.1793311028744; 
 Thu, 29 Oct 2026 14:57:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ae845e849bsm689025a91.7.2026.10.29.14.57.08
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Oct 2026 14:57:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so329095eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793311027; x=1793915827;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BtE8gEpGXXyQgany7PV79KzxRGZPRiw2gHz+ihjMaWE=;
 b=Nx3oFTbapD9LwBlsE+Z53OdFR+RK0Z8UlDR0QcVotUVNPRDy46gikzurTE9IdcDydw
 HL+vO249oL1bMAffAXTAs7e69cLp8YojXPa8hVIkEcSxczbGWSw16kmeS9sweScdkPwB
 KqbZq2C6aYtsK8Aleh0Rxy9D30HLq8sU3c6GE=
X-Received: by 2002:a05:7301:618a:b0:351:68e8:4646 with SMTP id
 5a478bee46e88-36a424199bemr813216eec.37.1793311026764; 
 Thu, 29 Oct 2026 14:57:06 -0700 (PDT)
X-Received: by 2002:a05:7301:618a:b0:351:68e8:4646 with SMTP id
 5a478bee46e88-36a424199bemr813166eec.37.1793311025708; 
 Thu, 29 Oct 2026 14:57:05 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42935b4asm1845188eec.16.2026.10.29.14.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 14:57:04 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 maaz.mombasawala@broadcom.com, Zack Rusin <zack.rusin@broadcom.com>,
 stable@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: log MOB limits outside the manager spinlock
Date: Thu, 29 Oct 2026 17:57:00 -0400
Message-ID: <20261029215700.3009996-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vmw_gmrid_man_get_node reports MOB limit expansion and allocation
failures through vmw_host_printf while holding gman->lock. The helper
formats its messages with GFP_KERNEL allocations, which may sleep.

KDE startup and desktop mode changes can reach this path, producing
"BUG: sleeping function called from invalid context" from kvasprintf()
while the manager spinlock is held. That's likely a separate bug
because KDE shouldn't be using that much memory but to debug
that properly stop filling kernel logs with warnings.

Defer both host messages until after dropping the spinlock. Capture the
failed allocation's page limit and roll back its accounting while locked,
then report the error and free the resource after unlocking. Use
drm_warn for the guest messages so they identify the device.

Fixes: cfdc3458db8a ("drm/vmwgfx: Be a lot more flexible with MOB limits")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c | 55 ++++++++++++-------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c b/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
index d607452dff6a..cc580ce57797 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
@@ -54,8 +54,11 @@ static int vmw_gmrid_man_get_node(struct ttm_resource_manager *man,
 				  const struct ttm_place *place,
 				  struct ttm_resource **res)
 {
+	struct vmw_private *vmw = vmw_priv_from_ttm(bo->bdev);
 	struct vmwgfx_gmrid_man *gman = to_gmrid_manager(man);
-	int id;
+	u32 max_gmr_pages = 0;
+	bool mob_overflow = false;
+	int id, ret = 0;
 
 	*res = kmalloc_obj(**res);
 	if (!*res)
@@ -85,43 +88,53 @@ static int vmw_gmrid_man_get_node(struct ttm_resource_manager *man,
 			const unsigned long max_graphics_pages = totalram_pages() / 2;
 			uint32_t new_max_pages = 0;
 
-			DRM_WARN("vmwgfx: mob memory overflow. Consider increasing guest RAM and graphicsMemory.\n");
-			vmw_host_printf("vmwgfx, warning: mob memory overflow. Consider increasing guest RAM and graphicsMemory.\n");
+			mob_overflow = true;
+			drm_warn(&vmw->drm,
+				 "vmwgfx: mob memory overflow. Consider increasing guest RAM and graphicsMemory.\n");
 
 			if (gman->max_gmr_pages > (max_graphics_pages / 2)) {
-				DRM_WARN("vmwgfx: guest requires more than half of RAM for graphics.\n");
+				drm_warn(&vmw->drm,
+					 "vmwgfx: guest requires more than half of RAM for graphics.\n");
 				new_max_pages = max_graphics_pages;
 			} else
 				new_max_pages = gman->max_gmr_pages * 2;
 			if (new_max_pages > gman->max_gmr_pages && new_max_pages >= gman->used_gmr_pages) {
-				DRM_WARN("vmwgfx: increasing guest mob limits to %u KiB.\n",
-					 ((new_max_pages) << (PAGE_SHIFT - 10)));
+				drm_warn(&vmw->drm,
+					 "vmwgfx: increasing guest mob limits to %u KiB.\n",
+					 new_max_pages << (PAGE_SHIFT - 10));
 
 				gman->max_gmr_pages = new_max_pages;
 			} else {
-				char buf[256];
-				snprintf(buf, sizeof(buf),
-					 "vmwgfx, error: guest graphics is out of memory (mob limit at: %u KiB).\n",
-					 ((gman->max_gmr_pages) << (PAGE_SHIFT - 10)));
-				vmw_host_printf(buf);
-				DRM_WARN("%s", buf);
-				goto nospace;
+				max_gmr_pages = gman->max_gmr_pages;
+				gman->used_gmr_pages -= PFN_UP((*res)->size);
+				ret = -ENOSPC;
+				goto out_unlock;
 			}
 		}
 	}
 
 	(*res)->start = id;
 
+out_unlock:
 	spin_unlock(&gman->lock);
-	return 0;
 
-nospace:
-	gman->used_gmr_pages -= PFN_UP((*res)->size);
-	spin_unlock(&gman->lock);
-	ida_free(&gman->gmr_ida, id);
-	ttm_resource_fini(man, *res);
-	kfree(*res);
-	return -ENOSPC;
+	/* Host logging allocates with GFP_KERNEL and must run unlocked. */
+	if (mob_overflow)
+		vmw_host_printf("%s",
+				"vmwgfx, warning: mob memory overflow. Consider increasing guest RAM and graphicsMemory.\n");
+	if (ret) {
+		char buf[256];
+
+		snprintf(buf, sizeof(buf),
+			 "vmwgfx, error: guest graphics is out of memory (mob limit at: %u KiB).\n",
+			 max_gmr_pages << (PAGE_SHIFT - 10));
+		vmw_host_printf("%s", buf);
+		drm_warn(&vmw->drm, "%s", buf);
+		ida_free(&gman->gmr_ida, id);
+		ttm_resource_fini(man, *res);
+		kfree(*res);
+	}
+	return ret;
 }
 
 static void vmw_gmrid_man_put_node(struct ttm_resource_manager *man,
-- 
2.53.0

