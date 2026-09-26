Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA515C9832A
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 18:31:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 935D010E31C;
	Sat, 26 Sep 2026 18:31:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iMdEq/vQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SqfIW/zX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DDB510E1CF
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:31:50 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxReW474703
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rCiTSj82OYF
 5QfTUX7zKg4lPx2ctvHCuTZqaZWcoJjM=; b=iMdEq/vQPLGIJbtI7qPFC3/JCWk
 TSXuGyqyy1w7U9dpCannDKH+E2ubk6j7kNSG+Q/ZmH74qqvs4dAKUWj/ueoSD0rh
 JtrhihfrG+Zmifc+IZ8jfe+Z509ovN4eQ+Gg6CpI8shXR6eHDV30uUzgWx0zJ62W
 1HhniEf4FWeY5VUeE3GafFuqNugbra3gzZ3aUp057feU2zPWyZWncDs2SUBeCkIN
 /ExsZPzFfW9dQvriG/dRpBgY19VuoZjuvZaJ4CO+VC7TFJg2YARfmP4qRe+5H0fy
 lBy4YHhF2KLJvHHFeFy7xs5ZUtewnkwfm4GD1HJikeLWqf2ick3o/pMogBQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx6939gwf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:31:49 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc42a07d04aso1188220a12.1
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 11:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790447509; x=1791052309;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rCiTSj82OYF5QfTUX7zKg4lPx2ctvHCuTZqaZWcoJjM=;
 b=SqfIW/zXGJocCpodPDT+kx71+pHZzXB1aYmr/s4CP9RiEJi61DazYO13g+9yCQ/ysy
 hxi2RCiggxM9Vqp4Bd+TGEqhUkxm/p7Hsc9V36Qq/y1lesFYJexTd5M1k0DatlRAcC6o
 ksQ4fWzodS2t7sVVFtZEQiv6yVrLbb5aay0p3kHX6twvnUWMGt34KJpZVp2eyD4ywbxW
 MiQtZL/sCiHpug78iJkOkwNxmM7AJw6FTnDAUGZ6kG0mjjQpH5qDtt0WmLH1jQQVOvLl
 jmjGD0qLgPr7TZELRacR5hV054rbavAUk4voQcXjetDZKBEc+IGJxDI5/Q26qu8KihnI
 SHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790447509; x=1791052309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rCiTSj82OYF5QfTUX7zKg4lPx2ctvHCuTZqaZWcoJjM=;
 b=TFQVFlobAHZVIB+OdCo4Lj7kLJm5OEPnbW9j4/KkuIvXU+5UmOVg4ILrJFQkViq35D
 hAw7gzUDYSnww6TiYcEuhLwKFW1gPqp8wov4zpQtnckRAp98QXOPhv5V6yB/qAru2O3B
 qVrUmY04W1ypFZk7FenxK5qOoQEjpph/XznakP2OG85l8CDwkG/vRiuG7b3KIHbpRCEB
 M+04nrK3svcyYZGMthyIm1sfNetyrUI+ehULiA6/yyTpZ7veMwtAFZxyiHvEaPLrfNYm
 luItg76LhUFtcTLmOKGEnJj2UXJk0pBPUeQU4AXsI++7Zz6+2TwpLxWV6o3JepO/ywRX
 WajQ==
X-Gm-Message-State: AFuF++mEJwHuLe3vERSKubLyJvYp5kGIqlbpwP0ivJAfPcdVnG99f3a2
 jL4vORgNS5UpCSH1MEPGoUEWL+gqq+K1iPKkaqvYcO5DrFxGcwmeNjOhhAPYW8X6yRizRSAQOdV
 By7d7oiWFVB9cGMUq+mueCBDoGAMWdyepkAY6525JDPyIx9wcfdM9kzvxy1eBmlnRtvTin4ypq+
 uVHMI=
X-Gm-Gg: AYBFou1mzZ23cw0eWodI66EqDfHw4drKj3sEkmZ84Oltb3RHcjMghW+PlmsHC/GQSFv
 YmLYJHF7JeBymu9rkt8AvB+JpkR6ZMEe4E+LfSjyleUyFf8isEQh01m1cksUiVsr/L9xrkg8/7Y
 qFpLiHauZSYQSAMKkn5QUkgKmbomfowQYtUIe9/z9jYYqwzKtB2vP2DND8rwidp8fUfNioFtsQ6
 jMiYbUVaWDTBEaV8Y9CxBpcXFS3fRz1vQFY7etylttcZQ68FTn7vj6dUAthSzGKJSEUJkkfKk7q
 tKn2DP1/LjoIwSIUiQV5POzMtFTM9ioQ4e8e2UCQLQ9aP3V1m9oSENMxAwZDcMfW7Sfsp8Cro4W
 wmn2t7FhAwREfCGBuduuIpcScsSD9GcAif/ZuokuAqvI5XgE=
X-Received: by 2002:a05:6a00:138d:b0:881:7ff5:605c with SMTP id
 d2e1a72fcca58-8817ff562d9mr1878446b3a.55.1790447508881; 
 Sat, 26 Sep 2026 11:31:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:138d:b0:881:7ff5:605c with SMTP id
 d2e1a72fcca58-8817ff562d9mr1878419b3a.55.1790447508323; 
 Sat, 26 Sep 2026 11:31:48 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87fea88dc7esm2332614b3a.30.2026.09.26.11.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 11:31:46 -0700 (PDT)
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
Subject: [PATCH 1/6] drm/msm/gem: Add helper to check if resident
Date: Sat, 26 Sep 2026 11:30:41 -0700
Message-ID: <20260926183051.25754-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926183051.25754-1-robin.clark@oss.qualcomm.com>
References: <20260926183051.25754-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA3MyBTYWx0ZWRfX0Iggu+B/yI9g
 juaeH9sXSuIgGAbXwAe/wdij4SJ++BIUYDU+R2gQVerWSv/Jli8xWq7gWiPEiyLowJCBWxnK73f
 7dT+vjsTJLxbSoOcXeKfvJX9OS0vQD8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA3MyBTYWx0ZWRfXwPK2CFN0E7gy
 NUxMKvgR4eeLiSV4SCQ8cOS89aUyqKkOB+lpJRFbgiRsTqohszSldqxoQjgGjg2/0Ww5019+Fg/
 4P99lKf2niNOn7QTtPl4b5CHQDayn9m522VeXufV65cn36DMvipRQY0cHVDUAzwVmAD3Gogatyb
 TOK1VahFvcM9cC5lbgKK+uwy9EQ+K702BAMcYJ00oBdDkM1NnCoeku5khBxnMRRTWZhnbMJS0Y3
 3osNLtyXiVlFW0HlQZaiBPScBnLRl5zquVlQWdO9YgxsREaxHhBNAPvpPSUDyyCQt3iPl7Vj4Jb
 JC7lxW2zPWi1ECDBjcAgnhVp2lMXglBAGXGKaVeRsQUNppH4lxEfYE76tjRPmLAjUSQS/9G+4a2
 izukZkeTTIoFwUA5HWtGacko3xrxisGkQuCXPjTeTd4S/vuSVdSW78P0KvEBH5cxp9QBivbfRuM
 JZ4fwFxjHjkKlwt8UdA==
X-Proofpoint-GUID: KWt_IIhOrCWdfYA8MyYIcOyK4vvSGOSs
X-Authority-Analysis: v=2.4 cv=f6Pdl+yM c=1 sm=1 tr=0 ts=6ab80f95 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=Ql1oLI5ppxrsW8Emd60A:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: KWt_IIhOrCWdfYA8MyYIcOyK4vvSGOSs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
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

Mostly we don't care about the page array, mapping/etc works in terms of
the sgt.  Add a helper to prepare for allowing the page array to be NULL
for imported dma-bufs.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 8 ++++----
 drivers/gpu/drm/msm/msm_gem.h | 6 ++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index c4cff3d53d81..e8390ebd5dd5 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -147,7 +147,7 @@ static void update_lru_active(struct drm_gem_object *obj)
 	struct msm_drm_private *priv = obj->dev->dev_private;
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
-	GEM_WARN_ON(!msm_obj->pages);
+	GEM_WARN_ON(!is_resident(msm_obj));
 
 	if (msm_obj->pin_count) {
 		drm_gem_lru_move_tail_locked(&priv->lru.pinned, obj);
@@ -167,7 +167,7 @@ static void update_lru_locked(struct drm_gem_object *obj)
 
 	msm_gem_assert_locked(&msm_obj->base);
 
-	if (!msm_obj->pages) {
+	if (!is_resident(msm_obj)) {
 		GEM_WARN_ON(msm_obj->pin_count);
 
 		drm_gem_lru_move_tail_locked(&priv->lru.unbacked, obj);
@@ -949,7 +949,7 @@ void msm_gem_describe(struct drm_gem_object *obj, struct seq_file *m,
 		stats->active.size += obj->size;
 	}
 
-	if (msm_obj->pages) {
+	if (is_resident(msm_obj)) {
 		stats->resident.count++;
 		stats->resident.size += obj->size;
 	}
@@ -1172,7 +1172,7 @@ static enum drm_gem_object_status msm_gem_status(struct drm_gem_object *obj)
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 	enum drm_gem_object_status status = 0;
 
-	if (msm_obj->pages)
+	if (is_resident(msm_obj))
 		status |= DRM_GEM_OBJECT_RESIDENT;
 
 	if (msm_obj->madv == MSM_MADV_DONTNEED)
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index dff60cbc9d95..73dafe080bfd 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -419,6 +419,12 @@ static inline bool is_unevictable(struct msm_gem_object *msm_obj)
 	return is_unpurgeable(msm_obj) || msm_obj->vaddr;
 }
 
+/* Are backing pages/sgt allocated? */
+static inline bool is_resident(struct msm_gem_object *msm_obj)
+{
+	return !!msm_obj->pages;
+}
+
 void msm_gem_purge(struct drm_gem_object *obj);
 void msm_gem_evict(struct drm_gem_object *obj);
 void msm_gem_vunmap(struct drm_gem_object *obj);
-- 
2.55.0

