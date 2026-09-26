Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C06C9832A
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 18:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDF2010E145;
	Sat, 26 Sep 2026 18:32:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PVb86tYh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XpjYKQfH";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8762810E1CF
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:32:03 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxe1e245543
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=N6Sk/qPpTb8
 0sqKVTmQiXDBsrY1jdpSDdOhKqhp6i50=; b=PVb86tYhihJaM2VR2lRViZcLDqw
 aNChzCaDeuAsn+oGyBLRjv6D928o8OgHdIbv9zebBAiKNi8zYw6uhZDvYsjUOeOM
 rV0XSCDJRC/LWC6CY5mTtKGepqGLxL/JKglnmcgjNvKBrm6QISzDcJAxVOWEg4am
 vTk4CJvQS4FUo5tFXoZpLSvsrL/bhXjNtccHe5nMaQLlWabiZ7TjxDgFBD9SBz9v
 oM/pI5JDlpxQH6i4Cq7rhY5Soeo14A8iEWcuvPSk4IsWRlXHN3hwCcp3XthwY40F
 3qgIf37dEpfVEOulX3sbkMH5m9WP5Gjrhvqy85nfq6XbsyLpOSu0ObRQcZg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3dp1tpt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:32:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2db3b126c9fso17739725ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 11:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790447521; x=1791052321;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N6Sk/qPpTb80sqKVTmQiXDBsrY1jdpSDdOhKqhp6i50=;
 b=XpjYKQfHm1xXNw5O8bja/ITirhFwIfhcGemGYZmTCp7lWRyK8H2Ev1wJX3QgHBSup4
 QImDqPL7Ed0pv5L6nrg4/lgFXlzMMozzqUL97DWxC1Qlkha0itZ6Rjtf1BvDHgw9tePo
 RFdh80uh7hqdeP6fyZI3ar/9Xe+Z87jdeNY+2IdjhNqy5vhWiNsAB6nLQuetKvK/T3qv
 X7UeDjt6tow7f0NKeQYDXNFlPAt0TD7doj739uGHH557piyN8qMdclqRksbtzVcnjkDd
 PxTpfOlu4+LP3wahjwoWS1FrQYcODX6Bsg5IukNParVAeORLNXPKi6Kb+VkQUc/MiGN7
 rZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790447521; x=1791052321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=N6Sk/qPpTb80sqKVTmQiXDBsrY1jdpSDdOhKqhp6i50=;
 b=VirH0JAAZ2CDlt0LRVXRXmPx6T9ooTyMs56APmYept75B6gHbKQPR3n+yIkx8OPdOR
 ZyPAlzoNPquwZfqH4WlRMXn3i38j2l6DMCXqRZQsoICLxu1YehDPXiBzvtwwc57KfGBo
 DkfIHSD7Z1PLhTlJD7hdD3bTL72ybihFChZe9umUlOsDC9sxDHK0l+/zwBLhXQfvojtU
 qEV6k0ix3BDQjhwOW4tCMaGqF4gnff1cncSCubT2SFmSJU6vpFPUO3dwKnroX5sUUB2e
 uEGpCUb2abN/JkDcY+bBnBdZdmSubNGLjbSVKzJGZXY6+XAEBneIps9UItl6bS9IbRKh
 5rgg==
X-Gm-Message-State: AFuF++lzBdcvcX3JzVJKrIpuB3DXlCB/cZKkoNJVk0fK7caeBghRegJB
 gXB6WAokFCCIulyEs8dq3Y45BF7Q/wJBkcT5C18Z7wXeXWpvuReuqU4koTqpwhXlgYPLO2h85CQ
 Z2qg7olGbnxV5LOMYvc6Xp3gYlexFLYWhmbHMC3vR8u8kCVsrZVHZEmUJCdLosD9zWTsrOFL/u/
 1EeAA=
X-Gm-Gg: AYBFou17WIUvhpHA9ZItxDfkujC4tGJPPIIYFI7UbBoEt4F9LFsbTY5yF7qG4JHIbWU
 uaDUtfWzNr/skeP2/nhq0tWKbjxImZy8R9KIFVAgX4NxGaL+vKIHzcMYUrTLN9FjtQLrcNX6W7O
 TZpOud2sFrzwjYYk7a5EGhqrSI6mn1sqc43eZ+kzF8zOgjMrQ2Pl/3/B8TZxdlySLfZ8dNdknxj
 EO9QWYXlUAn8/RlKmMlEOYkSNk0ALJVn/eL8mEpyvsmb+NZLqaGwzcVYx7pvuUfHRDOwCY5P6/L
 zbtCIDjjYC4W+3QJWUHCPm7uY2Ax0DzPxp2AvXV6GV9B7qlGerscr3MybTmYtip2j88t4sLCksn
 W5KDsZPCGGxK5xGMtxJqqJSL0SdIwlYT1izOLscGHwwG/RA==
X-Received: by 2002:a05:6a20:d49b:b0:3d3:af85:eb98 with SMTP id
 adf61e73a8af0-3de0e790e6emr8061652637.26.1790447521323; 
 Sat, 26 Sep 2026 11:32:01 -0700 (PDT)
X-Received: by 2002:a05:6a20:d49b:b0:3d3:af85:eb98 with SMTP id
 adf61e73a8af0-3de0e790e6emr8061643637.26.1790447520870; 
 Sat, 26 Sep 2026 11:32:00 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc794ef8befsm1768841a12.12.2026.09.26.11.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 11:31:59 -0700 (PDT)
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
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 6/6] drm/msm/gem: Drop use of drm_prime_sg_to_page_array()
Date: Sat, 26 Sep 2026 11:30:46 -0700
Message-ID: <20260926183051.25754-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926183051.25754-1-robin.clark@oss.qualcomm.com>
References: <20260926183051.25754-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA3MyBTYWx0ZWRfXzlIIckWpifsr
 e6kQtwy5tCAQ55XqqhN6roJm9Ok4/Pr+Lp9m4WlYOGPh1K6uiN9klV2ryyK2P5lW/vsMy+psgm6
 im3cpOAa69OhHcibYEVoupV+lpaoOXLkLd8u4PRf1jV+MUS/XbYqzBhThCRCPylw09v99OZCJgg
 S5Cte02Bs5eYltemM6tDMKHe+rfhs+SXekGXDswv0UJ2F2mfrzbos9FsGtkZUXKIk9/Y/QEITOw
 GLNqRqraqmrqkl3cjOZOmvVByFubzqgG45/nPjV8r2NUds9cj2dNaA3KKW6JCQEGKPDrwBTSsvt
 IMSFHJHDGTKZDF8T+qXxY5+GDFk4Lt2r0xSUZEfu1jMitIqClPS0O2e+AKazyNMH/6bomC+p9Ix
 7Ahnw5rgEkS3rN2tZjBR9YJxbGn3w2Pa7Rueyd5whmwH1zmX+AF/hwBcuc7pvW2UNu1l6w2dRbF
 YE7KsETBG0yUbKvEe/A==
X-Authority-Analysis: v=2.4 cv=QsXLTlyd c=1 sm=1 tr=0 ts=6ab80fa2 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=VGg0XEsK77xSs33O3y8A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: WyQb_6g2rsAkA5mg3xSqg_wTcsdMkG4C
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA3MyBTYWx0ZWRfXxo2zy404qZ2r
 uUJB0N46CncMW2whZ1FS61+xsQefvNlc3w5iepdiIzmk2QQkB5Hi/IfvnXShhufipQ0tIymlgFE
 BZXPZNDof2IXe/hj6ZZuBbn3DaY9tUE=
X-Proofpoint-ORIG-GUID: WyQb_6g2rsAkA5mg3xSqg_wTcsdMkG4C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
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

Now that we've removed any use of the page array outside of paths that
are restricted to native (non-imported) objs, we can remove use of the
deprecated function and allow msm_obj->pages to be NULL for imported
dma-bufs.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 3111d7389572..130ae27ee00b 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1116,11 +1116,6 @@ static void msm_gem_free_object(struct drm_gem_object *obj)
 	if (drm_gem_is_imported(obj)) {
 		GEM_WARN_ON(msm_obj->vaddr);
 
-		/* Don't drop the pages for imported dmabuf, as they are not
-		 * ours, just free the array we allocated:
-		 */
-		kvfree(msm_obj->pages);
-
 		/* In msm_gem_import() error path, sgt won't be set yet: */
 		if (msm_obj->sgt)
 			drm_prime_gem_destroy(obj, msm_obj->sgt);
@@ -1350,14 +1345,10 @@ struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 				      struct dma_buf_attachment *attach,
 				      struct sg_table *sgt)
 {
-	struct msm_gem_object *msm_obj;
 	struct drm_gem_object *obj;
 	struct dma_buf *dmabuf = attach->dmabuf;
-	size_t size, npages;
 	int ret;
 
-	size = PAGE_ALIGN(dmabuf->size);
-
 	ret = msm_gem_new_impl(dev, MSM_BO_WC, &obj);
 	if (ret)
 		return ERR_PTR(ret);
@@ -1368,28 +1359,14 @@ struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 	 */
 	obj->import_attach = attach;
 	obj->resv = dmabuf->resv;
-	drm_gem_private_object_init(dev, obj, size);
-
-	npages = size / PAGE_SIZE;
-
-	msm_obj = to_msm_bo(obj);
-	msm_obj->pages = kvmalloc_objs(struct page *, npages);
-	if (!msm_obj->pages) {
-		ret = -ENOMEM;
-		goto fail;
-	}
-
-	ret = drm_prime_sg_to_page_array(sgt, msm_obj->pages, npages);
-	if (ret) {
-		goto fail;
-	}
+	drm_gem_private_object_init(dev, obj, PAGE_ALIGN(dmabuf->size));
 
 	ret = msm_gem_init_bookkeeping(obj);
 	if (ret)
 		goto fail;
 
 	/* Now that we are past potential failure points, set sgt: */
-	msm_obj->sgt = sgt;
+	to_msm_bo(obj)->sgt = sgt;
 
 	return obj;
 
-- 
2.55.0

