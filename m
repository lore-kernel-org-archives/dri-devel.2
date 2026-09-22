Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB93C982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 06:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0A8E10EB85;
	Tue, 22 Sep 2026 06:11:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="BknPp55r";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 915CA10EB82;
 Tue, 22 Sep 2026 06:11:52 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M5QK2m091855; Tue, 22 Sep 2026 07:11:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=8X7CkusW0IfB/2rTSn/EA15
 auoWZN8aQINjTfeKtdq4=; b=BknPp55rouYhdGiL2w+MeinGwLdVPAnEZhfrNP3
 4O1CV/3PM7f69OBCgWOAklfx91JS9lI5RSXaSqVlbp8KnxBAt5JqrkWxqEjD7Ksp
 Y3xP8AxtxFU08vmnxerehiQ+NCXFy81oiiaCgJidH8vpJl3LdovC9XUtNlMypqVp
 a8DIVfLdu6X5ZQ2szu9f/+uU0H4VL6gMnER732+M5IHftxflnWnl9Z7oS7JWbuZK
 q+tzg9GS+4woKOFnAnnInH8N9+8yYVC0zm89SBEtkjpff/O1SSBU7S0Q18xscY+x
 4Aa6JI1goSq/RqCe00676zWTVqXAt9aanvPtYPiykYo4IxQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gsgnq249s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 07:11:43 +0100 (BST)
Received: from [127.0.1.1] (172.25.5.88) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 22 Sep
 2026 07:11:41 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Tue, 22 Sep 2026 09:11:28 +0300
Subject: [PATCH v4] drm/imagination: Fix parameter validation in
 pvr_fw_object_destroy()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260922-fix-null-pointer-dereference-v4-1-6c7369b83437@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAA8csmoC/43OwQ7CIAwG4FcxnMVAUQRPvofx4FiZNcoMzEVj9
 u7CPKjxoIce/rT5/t5ZwkiY2GpyZxF7StSGHObTCXP7XWiQU50zAwFaGAnc05WHy/HIzy2FDiO
 vMaLPExxycMZKOYfaGsMycc4ruo78ZvvM6VId0HXFLBd7Sl0bb2N/L8vdn1W95JJ7bSvwHu0Cx
 JpOTYdu5toTK109vDQr1A8NsiaV8d5W2hux+NLUmwa/flPlN2HtUius9VJ/aMMwPABfy7TAdwE
 AAA==
X-Change-ID: 20260812-fix-null-pointer-dereference-2c891142d988
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Sashiko <sashiko-bot@kernel.org>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>,
 Donald Robson <donald.robson@imgtec.com>,
 Sarah Walker <sarah.walker@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790057501; l=2989;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=dTPBRt1/cBuUzzuTU5LVCE6TjlRw01N5hVVOsf87m2w=;
 b=2XlUJ2Vb7JqvHPL9ERsDjyC1akbLDPyDuPFBoecrQeO7csovYOHX392U/acOU0D9kaGt4Z68L
 pjOEWwY+F6UDy2S+YtkuMqdU3zHd6JLLBwQAo9AJgADxtLJI/zYaGxI
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.5.88]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA4NiBTYWx0ZWRfX0QHVrlyohn0/
 X7syzwWn6H8EBarQqwvcISTt6yeo4Un+dhDZ+4Xe3NJWm8sQo7sU8wm50L09uAFjsXpmygVV+fD
 1HjbgnsIJ5ehDSeQNyZD6PAXQlL6dRLUk7FY4xJhIz/J6ojHZrTu7NlfVMmcAcPsEW1B8vswTE8
 /pDn6mfzL4X4UAJrntYfESntRdEb2YW/Zku4OztEAV4WKNypaTJ0MSqZknZk1kbgSxwKA1RUQID
 t+9KqzP3Vh4xbaozO86RczCNzqxkAkq5/zVBHGWWAHHkV81zi7TMtN9YVxYT0vyo/KbIoWDGo3k
 mkbdOs0xS/sERcGOYDmCsX3h/yH0rgjJfKu2ag48b0OKYkHXfr3/QYBuUrIOnuIseLGsDZhS5hd
 yAALzHDOoeiHW8Y3HFBn0Vn61jLc68qAnD3opsw3X8ZJYakCmN1UHJrBJPll5Z8PJ6E+AJLoX3M
 ThKXfV/TJ0dXw87nm5Q==
X-Proofpoint-ORIG-GUID: dYukE0-1_-6dzPa21YfW1eDK7TC4NA1B
X-Authority-Analysis: v=2.4 cv=fYs4WEQF c=1 sm=1 tr=0 ts=6ab21c1f cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=YP7Kpn5otooA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=QyXUC8HyAAAA:8
 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8 a=craggXHLatwVVKPEDpEA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: dYukE0-1_-6dzPa21YfW1eDK7TC4NA1B
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA4NiBTYWx0ZWRfX6ZRSPOKtllPW
 0nqOD7BolWSCPfx2jmkVQn7AaiHmD3mfYILjF4CgjYEJ5tUGu31vnGBQpKZSOGzy2P+AVVdKlRS
 nqtgwJsJ/T1or8XiwOmJUjJ2md+pVJI=
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

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/dri-devel/20260810132202.3C16D1F000E9@smtp.kernel.org/
Fixes: cc1aeedb98ad ("drm/imagination: Implement firmware infrastructure and META FW support")
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
Changes in v4:
- Move the structs declarations after the early return to fix V3.
- Added kfree() to the early return path.
- Link to v3: https://patch.msgid.link/20260922-fix-null-pointer-dereference-v3-1-f099763ed676@imgtec.com

Changes in v3:
- Skimed the commit message removing redundant information.
- Refactored the parameter validation to return early.
- Link to v2: https://patch.msgid.link/20260903-fix-null-pointer-dereference-v2-1-138ff9b6f805@imgtec.com

Changes in v2:
- Commit message and cover letter updates.
- Link to v1: https://patch.msgid.link/20260812-fix-null-pointer-dereference-v1-1-f69b2ffe9520@imgtec.com

To: Alessio Belle <alessio.belle@imgtec.com>
To: Luigi Santivetti <luigi.santivetti@imgtec.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Donald Robson <donald.robson@imgtec.com>
To: Sarah Walker <sarah.walker@imgtec.com>
Cc: imagination@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/imagination/pvr_fw.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/imagination/pvr_fw.c
index 850a3ec8e775..39d70f51f126 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.c
+++ b/drivers/gpu/drm/imagination/pvr_fw.c
@@ -1425,6 +1425,14 @@ pvr_fw_object_create_and_map_offset(struct pvr_device *pvr_dev,
  */
 void pvr_fw_object_destroy(struct pvr_fw_object *fw_obj)
 {
+	if (!fw_obj)
+		return;
+
+	if (!fw_obj->gem) {
+		kfree(fw_obj);
+		return;
+	}
+
 	struct pvr_gem_object *pvr_obj = fw_obj->gem;
 	struct drm_gem_object *gem_obj = gem_from_pvr_gem(pvr_obj);
 	struct pvr_device *pvr_dev = to_pvr_device(gem_obj->dev);
@@ -1439,8 +1447,7 @@ void pvr_fw_object_destroy(struct pvr_fw_object *fw_obj)
 			return;
 	}
 
-	if (fw_obj->gem)
-		pvr_gem_object_put(fw_obj->gem);
+	pvr_gem_object_put(fw_obj->gem);
 
 	kfree(fw_obj);
 }

---
base-commit: bd4f284df04d76fd65e57141cb1e6e7a49e4c3cb
change-id: 20260812-fix-null-pointer-dereference-2c891142d988

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

