Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E581FC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EEEA10F56F;
	Thu,  3 Sep 2026 12:27:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="u353uV/I";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37F4D10F570;
 Thu,  3 Sep 2026 12:26:59 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AO363931954; Thu, 3 Sep 2026 13:26:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=JXjYmHkZ70MpN76wTrkYhRn
 7eTnzR/6jXvTCSXeGuUk=; b=u353uV/IYsHa+aWHMbUlP3PO8DtBuCpIisQPT7d
 A7vOXNDaY3cRN839DZziOZDd53401D4vdWORe7hks2jo1s18zX0OZYbLhFc2fmTP
 kxy1p12xrbIEXjIHI1yxiUQgUTfge0QxawhOBS0ThBZCT6AFaEMtKW0oyLWM3Mt3
 SOnNITUd9NUIFMt3fNlXrUnuT8kQ/h8TW6RSzM/yN1qervhIWSMXXkoEIvUEQH71
 I/5ArSv4iQq6Vw81pXANsTOAqgz00WNxTJDA4anZiyOg7sQfS0pezfgvySe5fyBv
 UgM80ArMZV7eneYJJ+3Uvzu+wSi0ly5N0mNmfV824JBtDbA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gbqgvc8qr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 13:26:43 +0100 (BST)
Received: from [127.0.1.1] (172.25.10.25) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 13:26:41 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Thu, 3 Sep 2026 15:26:28 +0300
Subject: [PATCH v2] drm/imagination: Fix parameter validation in
 pvr_fw_object_destroy()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260903-fix-null-pointer-dereference-v2-1-138ff9b6f805@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAHRnmWoC/42NQQ6CMBBFr2K6dgydKGldeQ/DQsoUxkBL2kIwh
 Ltb8AIu/uLl/7y/ikiBKYr7aRWBZo7sXQY8n4TpXq4l4CazwALLQkkEywu4qe9h9OwSBWgokM1
 xhgCN0lJesdFKiawYc8XLoX9WP45T/SaTdue+6DgmHz7H/yz33Z9XswQJttQ1Wkv6hsWDhzaRu
 Rg/iGrbti9Kotgg2wAAAA==
X-Change-ID: 20260812-fix-null-pointer-dereference-2c891142d988
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Sashiko <sashiko-bot@kernel.org>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788438401; l=2699;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=pksU9UBgOJDqMf98NvL1eyqBEF5diO914w9pQAxCwY0=;
 b=OZ1A6ZKmfOECpMqA0DG+6IVRk2TjS1ZHMcP8VmmA1W7nWldpzoVG2dpEQLRlwteeXXEtFPqMb
 NIKROSR6PkAAB4v51CzlkOw7QPsghCKI3JEpe3LwlnVVKmktaUZOw2n
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.10.25]
X-Proofpoint-GUID: 9hkYqcV-jbBnFzJbheW78KHz8YVqmgC5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEwOCBTYWx0ZWRfX/upyQoVsUyyg
 pSBXXiy6Pemt7mB6ZwNnD+RazKSlqtMhDYqeu4MZvId9odd9X7XSYOneybdldHmvLO5ljGIuL6C
 Nss3RpJsoNhbkxsc5Cq0Er54IdBs2hVyrubfkYrrOkvrs5bOzs3q/rphC+eF2jSEP+Hl+GEx0Yh
 bYq5XMbDkdHWJ3d21WR2c9KDRpkLDWK7g6xgspjtB1XNlo7qHVGBL49G3oxqp1s+w0KF4JXTacX
 pQUAEq8Rt1RBxB3PvlFdSjk395N2x9YuznfVzdG3niA29R4M0lv1EWTFozG7LCaIZu9VN2NR5+D
 2TOIqt8r3icLEl8kUXPaW2gOsW5PLMtq/ER7TbXZfAj6qqkOhGrt7jM5JN+xV6pm5c1kjrPle0i
 x5RTSS9jwCNZsm8f7CeeSz2SLJf+KVo2P0XM8Vxtwl2KGWicYsRmo4J7NlVFihQfOU4QCd6UmrG
 rXMFHp31fdx6VJWDoeg==
X-Proofpoint-ORIG-GUID: 9hkYqcV-jbBnFzJbheW78KHz8YVqmgC5
X-Authority-Analysis: v=2.4 cv=OcCQnBTY c=1 sm=1 tr=0 ts=6a996783 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=1spURiKJc90A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=craggXHLatwVVKPEDpEA:9
 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEwOCBTYWx0ZWRfX5Z/vKlKkXIJ0
 Y5g9bD7ROiTwR1+dD4ZgE4yJ9oB9LAIJlFVym4cv38AQD2r2t+tSS368dYJrE2vclpdUrY/1a6P
 Vg7oImpvnmfPwkYjvD5lKKCsTlkddKI=
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

Fix parameter validation to avoid possible NULL pointer dereference from
pvr_fw_object_destroy() when handling allocation failures.

Sashiko report:
If pvr_gem_object_create() fails in
pvr_fw_object_create_and_map_common(), fw_obj->gem is explicitly set to
NULL before jumping to the error cleanup path.
The cleanup path then calls pvr_fw_object_destroy().

Potential kernel panic when calling pvr_fw_object_destroy() with a NULL
fw_obj->gem.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/dri-devel/20260810132202.3C16D1F000E9@smtp.kernel.org/
Fixes: cc1aeedb98ad ("drm/imagination: Implement firmware infrastructure and META FW support")
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
Changes in v2:
- Commit message and cover letter updates.
- Link to v1: https://patch.msgid.link/20260812-fix-null-pointer-dereference-v1-1-f69b2ffe9520@imgtec.com
---
 drivers/gpu/drm/imagination/pvr_fw.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/imagination/pvr_fw.c
index 850a3ec8e775..88f11fb01304 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.c
+++ b/drivers/gpu/drm/imagination/pvr_fw.c
@@ -1425,22 +1425,26 @@ pvr_fw_object_create_and_map_offset(struct pvr_device *pvr_dev,
  */
 void pvr_fw_object_destroy(struct pvr_fw_object *fw_obj)
 {
-	struct pvr_gem_object *pvr_obj = fw_obj->gem;
-	struct drm_gem_object *gem_obj = gem_from_pvr_gem(pvr_obj);
-	struct pvr_device *pvr_dev = to_pvr_device(gem_obj->dev);
+	if (!fw_obj)
+		return;
 
-	mutex_lock(&pvr_dev->fw_dev.fw_objs.lock);
-	list_del(&fw_obj->node);
-	mutex_unlock(&pvr_dev->fw_dev.fw_objs.lock);
+	if (fw_obj->gem) {
+		struct pvr_gem_object *pvr_obj = fw_obj->gem;
+		struct drm_gem_object *gem_obj = gem_from_pvr_gem(pvr_obj);
+		struct pvr_device *pvr_dev = to_pvr_device(gem_obj->dev);
 
-	if (drm_mm_node_allocated(&fw_obj->fw_mm_node)) {
-		/* If we can't unmap, leak the memory. */
-		if (WARN_ON(pvr_fw_object_fw_unmap(fw_obj)))
-			return;
-	}
+		mutex_lock(&pvr_dev->fw_dev.fw_objs.lock);
+		list_del(&fw_obj->node);
+		mutex_unlock(&pvr_dev->fw_dev.fw_objs.lock);
+
+		if (drm_mm_node_allocated(&fw_obj->fw_mm_node)) {
+			/* If we can't unmap, leak the memory. */
+			if (WARN_ON(pvr_fw_object_fw_unmap(fw_obj)))
+				return;
+		}
 
-	if (fw_obj->gem)
 		pvr_gem_object_put(fw_obj->gem);
+	}
 
 	kfree(fw_obj);
 }

---
base-commit: bd4f284df04d76fd65e57141cb1e6e7a49e4c3cb
change-id: 20260812-fix-null-pointer-dereference-2c891142d988

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

