Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76189C9832F
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 18:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8677110E220;
	Sat, 26 Sep 2026 18:31:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oV5nFhld";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T+/O0ibF";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 489B710E1BB
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:31:51 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxRD93167951
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UHevoU0mUWQ
 x4ft8vjLQeW50AdjnP3/fAvkpCtYXRno=; b=oV5nFhldQhWp8jcSOs5fQMEyDrQ
 HnE/WVNrtB73A+o87XdiyV1FvdypyY1bBVZLwDzhrnrhtgPNFTu5Za7aB0fU+VIe
 E2Bv4hgqppqSWyFSFHQtO11wnaoMNAqFUBL/i3eesk3aO7RZDRVL/qAfck4iEq/V
 epDdklTLrNsLn+6CBEl/g+dO0yLF+wopE56V+krqHz/Jh+FTedd/B0eCHmzRTmOp
 5w19BvGbYgmalZLylkilpCSzPYT3ABhYtzeTf+bypalwH4RC0XZ5ZlNIc08U07aG
 yHhc++pDy3Ezq4vM1q/LOGmVjkjgsWgDJYwaSnHNzdrQ71GioHkbid5jPZg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx77jscru-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:31:50 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cfa4e4684bso33578835ad.2
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 11:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790447510; x=1791052310;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UHevoU0mUWQx4ft8vjLQeW50AdjnP3/fAvkpCtYXRno=;
 b=T+/O0ibFFqRd1TJd+nr2hDGVP0FPSDu4P8GPqKvADTt/Sm4qSqm1l8FfpRqwJGgzdY
 4480q/ZfduSc6rqjjmJ/JmW/goqONvsY/CFoOOQxwxneKnUIE8LoaolPxNbuHRb4SWmX
 NAnbUGmM8/CgwmlHAVQGTVX99DqpsZaf7WRLoI/tvJmWBf/hsQCLb3y6lQfYQ1Vw5GIr
 HnTN8xyZmmPbzPxgZBx7kOGRuYyhM5nQuMad5QS5NXdn90Pp73z/BMZkXidC1LsCWyR1
 6GTkDT3eiVdvPencdNRYIG3vrp/OS0AIQmSxG0fVyhq6PL5c7JUdsr9KkwM4Yo6Bc+w8
 LvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790447510; x=1791052310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UHevoU0mUWQx4ft8vjLQeW50AdjnP3/fAvkpCtYXRno=;
 b=K6TG0Ram+yNsS20fxlQLitTiTOzpART/YBzBtz8R4qNRidUSCN3H/bLvT+4h3OyiOv
 Mopr421V53lMZE8NbThObD6nAwnx9VqNuaMfAxMcvWd7FgGocWsXNTtsTX8BsJGd2p5g
 9CeaVouSUtgfF/tIsOvy1nXf7nsDzqZvVXW8BnxNzCVn4Rzl5tKmZtP9p4/BYZS/kkaY
 ePZemzJzkcPsxfvWioOIuyYyMCW+sCfq42vxgtRIJ6iHzeBpoqkL3+3s3JyPixILsWp8
 A9DGAUxeyzA7JEM6yG0vXGT57qRkpiuB6z7JzNsKOIfreRAn1l5b7g06aV7WworCJUzU
 PhIQ==
X-Gm-Message-State: AFq9FYKpf4HimfwG87eG/GvhJqV+xSbIIRvaKWZp6H+LIQbPa+suw+OY
 znU6GYNrDIjRiSgASQ2MRGiU6Z5vBER+kr5easDSEBEUlzXmJw1I0GGB/FtsOB26mDGpvfSlazk
 kdbTmpcvP0gCkaizNcDfrD+oGaukBFMtS/yhFCTYMymYqQqAqw8fuyq0taU3HvnxQ7117uTMr64
 tid7w=
X-Gm-Gg: AYBFou3QEY7WMi3yCyw2BBXWBYHpiGLj38V9FzJU9ddjo79bXmEZD2SGNdkQWcPwVkl
 0tyqFRTQJ45Vo8mHv5GrzXpUnlJVbe3QU+4MNoXkh5j9iqKvyoIX6PYE9PgI4FVClPEdWybH45a
 VHSSwgqDmjfT/9TJ4b6nTGvgO5BE+D0uKPvOb/4RAKTpX9sVc0cKxW9JiUJoJSI5N0DjdEbnrP5
 33GyHE6jTlercTp94QwMQ/CsQzX76eAe6e4SUxZ7mQsgUbi72hDok4MiJIn+kbR9WpnFcB0U1ri
 x93TXfoh4qDcVylek1gT8OSmlVj1i6DxZ433h39Tv11jiC4UsYUMp91GAygYDlccWxG7Aa5Ywsg
 KZDTb3QkrhVXNOXW7VfwAtbmi6WW7bc990Et73CybhO8ow7s=
X-Received: by 2002:a17:902:fda8:b0:2dd:c100:3134 with SMTP id
 d9443c01a7336-2df7e23b4f4mr73595995ad.48.1790447510131; 
 Sat, 26 Sep 2026 11:31:50 -0700 (PDT)
X-Received: by 2002:a17:902:fda8:b0:2dd:c100:3134 with SMTP id
 d9443c01a7336-2df7e23b4f4mr73595835ad.48.1790447509680; 
 Sat, 26 Sep 2026 11:31:49 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df913dfe98sm23353725ad.22.2026.09.26.11.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 11:31:49 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 linux-kernel@vger.kernel.org (open list),
 linux-media@vger.kernel.org (open list:DMA BUFFER SHARING
 FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b), 
 linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
 FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b)
Subject: [PATCH 2/6] drm/msm/gem: Mmap imported dma-bufs via the exporter
Date: Sat, 26 Sep 2026 11:30:42 -0700
Message-ID: <20260926183051.25754-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926183051.25754-1-robin.clark@oss.qualcomm.com>
References: <20260926183051.25754-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA3MyBTYWx0ZWRfX1KOEa3lotHaM
 MTd67Uq4/M5141BA74dLjm5g77Kxm4TjGal7S5A+or6XQFBmVukrwz4vSit04FQgE/5FfBiEnXv
 HFdNZ+FDifczvBMH5nWat6X7FQj11p4=
X-Proofpoint-GUID: VG30CqW1oer7ybhEcgSWyO-SYLfRp17w
X-Proofpoint-ORIG-GUID: VG30CqW1oer7ybhEcgSWyO-SYLfRp17w
X-Authority-Analysis: v=2.4 cv=J8U/fwnS c=1 sm=1 tr=0 ts=6ab80f96 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=plbGacqYsnyxf3yiAH4A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA3MyBTYWx0ZWRfX1rFb1Rf/k5JR
 HjJkMu6q2vXShlavsLi6s3RpLkOttesI/KTYhkEHloUiR6D67c7FO5C7L1QusdycJodyFBXti0l
 JRVvWtEUfEuMAQjPUYxEYAdlZb1seDiDB3SrpIENiaB5UF3ydK1jf//Ob24LBhVE1dWy409gcpu
 7U6TVCUSheBWbWMFBlgaNrYwLk639ZF2Mk7YBHLC1l3spNVbziWJOuqlKq0VdNTIkayYso/EiuV
 JsS/cG5X/UlopGqgvZ2mT5IBWork+gH4VEzIv1m9w91zD/ycXzntOaFSMcPpEqCA5d4mbD7hzQv
 JyOX0yuAmH+ZSRMGTbxjev/mizg42lfijcjDUEocg4+lLxtWuxZpHYXL4+bvC3LWPAaiRvhTfLd
 pyYp06BTmXND9Czw/MI50q3M4vho0n/X+1gCHrd1Ge2YWggZNUTry1Q8ZaVXvvGbHA43W5FHfpx
 FTgoTd/Xd7Qe9QueL+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260073
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

This was always the way it was supposed to work, and when we drop the
page array for imported dma-bufs our fault handling path will no longer
work.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index e8390ebd5dd5..c90336b3b231 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -23,6 +23,8 @@
 #include "msm_gpu.h"
 #include "msm_kms.h"
 
+MODULE_IMPORT_NS("DMA_BUF");
+
 static void update_device_mem(struct msm_drm_private *priv, ssize_t size)
 {
 	uint64_t total_mem = atomic64_add_return(size, &priv->total_mem);
@@ -338,6 +340,9 @@ static vm_fault_t msm_gem_fault(struct vm_fault *vmf)
 	int err;
 	vm_fault_t ret;
 
+	if (drm_WARN_ON_ONCE(obj->dev, drm_gem_is_imported(obj)))
+		return VM_FAULT_SIGBUS;
+
 	/*
 	 * vm_ops.open/drm_gem_mmap_obj and close get and put
 	 * a reference on obj. So, we dont need to hold one here.
@@ -1126,6 +1131,25 @@ static int msm_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struct
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
+	if (drm_gem_is_imported(obj)) {
+		int ret;
+
+		/* Reset both vm_ops and vm_private_data, so we don't end up with
+		 * vm_ops pointing to our implementation if the dma-buf backend
+		 * doesn't set those fields.
+		 */
+		vma->vm_private_data = NULL;
+		vma->vm_ops = NULL;
+
+		ret = dma_buf_mmap(obj->dma_buf, vma, 0);
+
+		/* Drop the reference drm_gem_mmap_obj() acquired.*/
+		if (!ret)
+			drm_gem_object_put(obj);
+
+		return ret;
+	}
+
 	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
 	vma->vm_page_prot = msm_gem_pgprot(msm_obj, vma_get_page_prot(vma));
 
-- 
2.55.0

