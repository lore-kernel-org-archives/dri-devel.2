Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D3ACA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A3AB10F8FB;
	Fri,  2 Oct 2026 15:30:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FBRn86lT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KTO5NvhU";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE44E10F8F4
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 15:30:05 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692FGxB11442827
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 15:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cs03Scv6zTSJTVwM3WZ7/EMRFDk8Su3MnHfipZGK3Xk=; b=FBRn86lTpDP5qHgJ
 rx70xJg4VvlLM29NonePiD8WPPrxk+CJaXn46IjJxtEapla/a/IbTVwsfFBzxf1v
 OXU21U6oujn2Ut96ljr9kPiIftNyRH68ixkXYVhlBQWfd43ceVERoFlt+zmwY97e
 eXKLo7nFk20GUOIVNwKQprVLOGClqHOm3xZ7BJWK9d0X8U7D86eqLk4vW3UC+jEL
 eXE4IaAUUgABWrbc51jWXCCtzPzXTxuMm5+iCJHD70fqZ5dG19eemlBmPCIiKnV3
 I41ZUAlF8lIEDq0EJQQDF6OXulLG0moLd0drGNKFn6MMRykDxV306mt9dbF9D7SD
 yaVy8g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1t9acnyh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 15:30:04 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc1a439db36so4792056a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 08:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790955004; x=1791559804;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cs03Scv6zTSJTVwM3WZ7/EMRFDk8Su3MnHfipZGK3Xk=;
 b=KTO5NvhUIKeUrdH/nCGs7gjYaAtPk3nImy+X8jri81R/x912qsU2DDVCYRXKw320bC
 8WACu/8RYS5t6ml/hkObYVsQ1MAd+j7AgxjpiIhEB/1tCWpgLEiLW0YJi1/ZJYaTlbRt
 ekx+TYcMhY0/4kIcK8xE2n4QHkwh0uxdTZcE+Xri7WEIsg2psB5USSra/N0Jx0f9TOW3
 j+TyaCSPQzT/ycnIsdcuNeuGE5Q4v78HHCwbo8YsaTikCU6BrPBqgnjn/hYKYE8rp9Fv
 E21wO/3MjDFSVaMCWld5BS5VC/rWBrE1Zt0aVLL5Z73yQ5Dz2zNFM2WGMkohIiVs3a19
 VMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790955004; x=1791559804;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cs03Scv6zTSJTVwM3WZ7/EMRFDk8Su3MnHfipZGK3Xk=;
 b=uq9ad9PpWQ+MMDlf7C4PGkD8u5rUoA6c9gb2wXvKuLa8gLz0CF00e9J97b1KpyojyF
 jd/bSSXi5fFcsO42BZzSydg8W/FNiUH8VcI312mCQ7ZltTAaE0UywOiYe7/ctHYfr1mS
 A///Lga1NEWYu0tKo7+oWl1d4pWufL3n/soC4R7u1QFnWO+UDamMu/n8dYZLyTMzhGkv
 D40C7Me7m485BULQ6BO6fGDhPzcgaA0gKNb0CzMmDhbO21xOVKco5hkOLnUVx2TaWb48
 jJTa300dpEurXrq6guMdvl1NuDmZb6GPDdU8fLHe7HwMZtc3fK/9X1qY4bHk21I7Me6V
 bGSg==
X-Gm-Message-State: AFuF++k3Q/mpeTKqgahnTgGF13Uo3Ic9j3LSuUzhG0pLKmyCffljevTZ
 b+Chp5MjMmtia45JSg9NY7TpOlFcVyQ66FNqpN2yGg/1mR8JynHS+VQ6OherTDhQ759dtd4CtLB
 Y/+w9fwC6Zqwxlb2vRXhirt//hlgSQ65tgL23O1ulEpZEnduYbuJ+EP4epNRb7GsSeEnmT3MROt
 rarc8=
X-Gm-Gg: AYBFou1sPlfEgXGLiQqO4AtpUSzRZnI/56iqw4BDIeJjTwvOuB6CRZaH9XtnZZIWfnL
 mgLbEdWmMmrIyncOl66GW+D3L+LRU83DMu8ihDaUfmqY3itwG70/0XFk8EKxPI3HqTetMm5bm5c
 mi1LRDlSxQtA1KQjN/Ska1XeGeGrkZnDN6QkwE/nHxhw7/xtEqlmDQ8ERFLc4FQIBtbFW0IqlF0
 Tq36t/VcMDf0oUe4Ge64XN5Rw2Q/HIpbfP7PnvyWtSgZxnQAZePlD2+tFPXU01FMrNHZruoohtJ
 eWMPqvbM2p0spjPDvYnalkEsEk8Gb18K6oS15ISgLxsigNe4yF/UmwlpnlnKIv4EuHsSJGQ1kBK
 Cbl9EZatnPk1bPbfh5jJ5Kg5F3wwpD3bJHJg0zFkCimw9Gw==
X-Received: by 2002:a05:6a21:4eb1:b0:3dd:85aa:d265 with SMTP id
 adf61e73a8af0-3e0bcf67ca4mr3131931637.29.1790955003699; 
 Fri, 02 Oct 2026 08:30:03 -0700 (PDT)
X-Received: by 2002:a05:6a21:4eb1:b0:3dd:85aa:d265 with SMTP id
 adf61e73a8af0-3e0bcf67ca4mr3131910637.29.1790955003284; 
 Fri, 02 Oct 2026 08:30:03 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc9f736cac8sm1159030a12.15.2026.10.02.08.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 08:30:02 -0700 (PDT)
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
Subject: [PATCH v2 6/6] drm/msm/gem: Drop use of drm_prime_sg_to_page_array()
Date: Fri,  2 Oct 2026 08:29:43 -0700
Message-ID: <20261002152948.85308-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002152948.85308-1-robin.clark@oss.qualcomm.com>
References: <20261002152948.85308-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2MSBTYWx0ZWRfX4vlwMupI5rCO
 TZhmMVQIA/F48sBiZlZjdR18zJUpc3TYM70Wv2BUwBWMGjMVncMqlIPd/FZhQhjdrAUhVDFZS4f
 qEuT2Pt9cMxfCbQN9a626w9s58G1oB0=
X-Authority-Analysis: v=2.4 cv=N++8hG9B c=1 sm=1 tr=0 ts=6abfcdfc cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=zd2uoN0lAAAA:8 a=VGg0XEsK77xSs33O3y8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: kEMzXXp9Uig8ALFqrr8p4h-c9JsiK3D8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2MSBTYWx0ZWRfX/Zt6hjASRw7j
 XtEjJzbIsAdmQiR+jDTQ1SaRCUAWfQFVBxwx8/S21ocKwjjvSGo5Yvwsdyl3MN26+LgT2cDoYmm
 muGxfU1pZHEgRFwqD4hLeFqRkkzGls4irSbvrol0BIX/z0ygdzOdFRT1l35IBDN5DlXVVoXnEZE
 tSx0LqZwRkaWaMRt7c8ny55WFpFEnpKGOhpA33k3VZ5rr34nYpgcWzkONWkscijAvW3NY2nNa5l
 X1J+sh4LaWp7pcujrt2VhGZwfBiJt5wXzTVAfgoPy+1g9aX4E/ssC8Owbh5KCWIX/bFvrLDxOic
 38coRo+tsjZKryF/E7HJmC53hglr98xY2Jn+1/6dTI0Jde4bUM0WdcbJvjW6sNkeL6z41ZedMhx
 ouSLzc3ZmLc9BrUH5zurFxCtQRki0H3wz6CFAs7Truw+VLF4lURchAqyKmdQwTf4P7T6IJU8jky
 uit6o8X4vNtlv2ICxQA==
X-Proofpoint-GUID: kEMzXXp9Uig8ALFqrr8p4h-c9JsiK3D8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020061
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
Acked-by: Christian König <christian.koenig@amd.com>
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

