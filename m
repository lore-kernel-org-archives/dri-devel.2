Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B642FDEE45
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 20:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C36E10F243;
	Thu, 23 Apr 2026 20:47:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sh4O7+IH";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7672610F243
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 20:47:19 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NHfrDH1532320; Thu, 23 Apr 2026 20:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=U2gEHeYSu27C2eZNR3hTdiHeK1ATZpicCrg
 JNLTTh/Q=; b=Sh4O7+IH5SuUoe2WAKn5RlSzFRRu+pQx5icl6CHJF8nqZk6OIsp
 hhd/6fheZ1RpjkaRELKKb/uBgPxBJNu4MJ+z5FB3im+H8AcTa2C1AyRZr6uHI5vX
 hgXp97r45fbJiQ0t2VSUrhl1RkNz1fwzrFKyu+4tGUcOXQKojd6FEmrEEE2P1bIj
 PASd3GFv3rySenTJWjssbaTZR+4c+LTj/AxNAl9FPPpHn6gm2HSu+1224Cf5rOev
 7VhvgSN6f5cQZGsKJnXVuINIhwz6wV6YDlK5hu2gyAtg+LcGyzh5LZQJ78Qzmnqt
 DIpPf2Am7rcQ8Th3S24oRDXLlVuMV4tTang==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqr26gtxh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 20:47:12 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NKlBN5029263; 
 Thu, 23 Apr 2026 20:47:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 4dq63nawa6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 20:47:11 +0000 (GMT)
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63NKlB17029254;
 Thu, 23 Apr 2026 20:47:11 GMT
Received: from hu-devc-lv-u22-a.qualcomm.com (hu-zmckevit-lv.qualcomm.com
 [10.81.26.129])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 63NKlAWf029253
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 20:47:10 +0000 (GMT)
Received: by hu-devc-lv-u22-a.qualcomm.com (Postfix, from userid 4696302)
 id D64495E0; Thu, 23 Apr 2026 13:47:10 -0700 (PDT)
From: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
To: youssef.abdulrahman@oss.qualcomm.com, jeff.hugo@oss.qualcomm.com,
 carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 Lukas Maar <lukas.maar@tugraz.at>
Subject: [PATCH] accel/qaic: Add overflow check to remap_pfn_range during mmap
Date: Thu, 23 Apr 2026 13:44:16 -0700
Message-Id: <20260423204412.2861046-1-zachary.mckevitt@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: T-bI0vWBG-BHX93h9V4F1lSxNKbzHsZ9
X-Authority-Analysis: v=2.4 cv=QLhYgALL c=1 sm=1 tr=0 ts=69ea8550 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=jH4uIxKMFi7FzrR_XaIA:9
X-Proofpoint-GUID: T-bI0vWBG-BHX93h9V4F1lSxNKbzHsZ9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDIwMiBTYWx0ZWRfXylOG8piewTUC
 ZixR5phA0NYn2UbJzCMShlqACnyG04s0v3RZus7MXVy9T233VrZAbbtPWaisgw/L6BUzjtksunj
 ZrfRu2wtxDyh9xm0L6XbSyhFkZ9nmAX3dtiytfblYk6N+caBLUBBw1w15HttqbCCQyLz6lgRVvF
 EFNz9BAf8cI/NUW3/4Mw1oIWRDve4jvnf5Oxl06LTOCM1mEIBF0RxszaOW7MXiEP7ugelm8wgdV
 9Zr6hEa2CnospO4I1YXhsmY/zV5lNc0A2cA9QGLJqQKWccI4041lXYCWgyg4Kxqmjra7gwWvlM6
 8Gc+I+K2QCUGIyruZB4j8n1YOlImCIaj4NswG7PxPgNjPpfLkvAVN80uz1IMUJ1RetPN+o9rUyE
 H/7VE6qB612QsCVgjVsXFGrW3i4DUvhzFEGPwgR708U8Gl3VIldaEdL8AGjS7Xu4qVIzRVgT0Bb
 ng7kLS+XgW7Q5GSzuaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1011
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230202
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

The call to remap_pfn_range in qaic_gem_object_mmap is susceptible to
(re)mapping beyond the VMA if the BO is too large. This can cause use
after free issues when munmap() unmaps only the VMA region and not the
additional mappings. To prevent this, check the remaining size of the
VMA before remapping and truncate the remapped length if sg->length is
too large.

Reported-by: Lukas Maar <lukas.maar@tugraz.at>
Fixes: ff13be830333 ("accel/qaic: Add datapath")
Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
---
 drivers/accel/qaic/qaic_data.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index 95300c2f7d8a..8a6948f11346 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -606,8 +606,11 @@ static const struct vm_operations_struct drm_vm_ops = {
 static int qaic_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
 {
 	struct qaic_bo *bo = to_qaic_bo(obj);
+	unsigned long remap_start;
 	unsigned long offset = 0;
+	unsigned long remap_end;
 	struct scatterlist *sg;
+	unsigned long length;
 	int ret = 0;
 
 	if (drm_gem_is_imported(obj))
@@ -615,11 +618,24 @@ static int qaic_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struc
 
 	for (sg = bo->sgt->sgl; sg; sg = sg_next(sg)) {
 		if (sg_page(sg)) {
+			/* if sg is too large for the VMA, so truncate it to fit */
+			if (check_add_overflow(vma->vm_start, offset, &remap_start))
+				return -EINVAL;
+			if (check_add_overflow(remap_start, sg->length, &remap_end))
+				return -EINVAL;
+			if (remap_end >= vma->vm_end)
+				length = vma->vm_end - remap_start;
+			else
+				length = sg->length;
+
+			if (length <= 0)
+				goto out;
+
 			ret = remap_pfn_range(vma, vma->vm_start + offset, page_to_pfn(sg_page(sg)),
-					      sg->length, vma->vm_page_prot);
+					      length, vma->vm_page_prot);
 			if (ret)
 				goto out;
-			offset += sg->length;
+			offset += length;
 		}
 	}
 
-- 
2.34.1

