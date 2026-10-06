Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40222CA5FFC
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 13:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D0EC10E24D;
	Tue,  6 Oct 2026 13:10:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nKZihoeb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q4/O01Jd";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D271810E37C
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 13:10:13 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696BPE1e680829
 for <dri-devel@lists.freedesktop.org>; Tue, 6 Oct 2026 13:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+0zJukh9QSz
 /GMbZNJuCTb3x7RaCsJro6coTIz2KI2c=; b=nKZihoebcqKvrFChvxXlIKhcs/y
 jRpo91KJZ8VHWpGbaZNqG9EWlMfAAyzd9vB+Ok4IY0L/eCsSxCQ9GLyInoXAurWl
 bPlKt2RG4QKDOn+QS9CmWepfi1S2BB9qSEhTREa6pGm8vR9bFxOvvvt+GyUknYt9
 e5j/YV/KHYrHXoPfUbN+zzyC6eqoZ+Th6MDNfwvtbPHQI8sL8XgogvZht4MoMAaI
 2PaoBIHujQysYKl+9ptKosNkcjW5CAQvmvCDtfHlCB5JfE+b5fIdMtpEKHEm80Ij
 FgsaNGFu3k1K5SbEB1q+SmymNv+3SGjjold4WbYHgQG7eN+kB219maXQcuw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xc9rpvf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 13:10:12 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-398dcfabbf8so4516880a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 06:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791292212; x=1791897012;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+0zJukh9QSz/GMbZNJuCTb3x7RaCsJro6coTIz2KI2c=;
 b=Q4/O01JdCFKWYg380+pznqxD8kdRsa+LYovmb+IcFR6oiEaec7CZapfXBQAuhoXeZh
 flZ5bWpR/jKqSao3121Fs+EFOZYZCj/39mLNmnfIOOiJsu+RPA3Te0AdK3w/nVmyPWr+
 qHOVLwdNjwHG7PErNAtywYhFj2QmJjlVLnS7io4QX5Qg4Wk6feqC32mKyym8e5PRb5uv
 x7r7+TgMEdTMzLsCB/NyvV00AgXvNSRaJMRz+dZAtgVZYvtc+yVQ3y5tGTyEFlEd8K7G
 hcFSWaZ0L8rktDdC51t4Vf3NWOzt58Of7sumQIIl4iYabg5yN9pxEDn/259dOP6T5eD5
 fcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791292212; x=1791897012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+0zJukh9QSz/GMbZNJuCTb3x7RaCsJro6coTIz2KI2c=;
 b=pGlYIXy+N54yEqAp0Ken+pxy5Hc999WrgQhPtDqa83RGMsPPxIIT+T4qFpUlWJWFP3
 yrf+bvGVI3XupQHSTZVGtP7vV5UeV1QAElUm7FsBPtOtmTp/vYyZPsBHY07Uc9adTVNX
 b1e67WtXdc97D8JFjPwCXdP5WBmFvF6dVxvLAkmJdYHVGKzt9WxV/9SEtXZTrNKTVcjj
 ynIxHwJeHIVmqdu/sKkAbmv+PEBxw1lLQlXQz53B5ieZqgZo3tnahSyYBePeAP5qKkOa
 h7XIokHorw9YkD/KRtbK5Y/y3vYDsxzqU3FLNImAMzHB0nNLXYQ+qQGvVwEO89x+wskV
 nVVQ==
X-Gm-Message-State: AFq9FYKRgH0h4sNJ1lBKAoAG5+5Udg1PX8JAYY0Q0kCkAEUJiInbZWfu
 8lO13xIi6NKrw7JsxIXJAihSc9ugtd7cFOjEwNkawFgNLpoboQPxrz6DdzykEJ+vgY9PeKYq16F
 tk4NgF2FKRhfJa2X1ixWNRkuG6+SxChS+0DAiqheEGEsu/LIlbqzZw+IxeHHWOb/X6a03APZtry
 vmzuo=
X-Gm-Gg: AYBFou3GXYLjkL2F2IXAW8gsAh1td0fPJmkHsujBGt36Mljags/kjZ+iLC4SGvTrvFx
 iVOqJYVbW8hLwKYR40XfP5Z6uSp+ALHzgfbVhrP0roTbV1EamaDCvmOqZ0a+Hm3/F+PcGtkW7nS
 jAGytmUrpDhN7SeALmJTvUicWPuVlAciHclITVO2XeKmWfQFX6M0oGnSsz9s0l5l7ZTWDQFTCL4
 LyPVwWdbgHB72WXpmbh1giaq/eJ95BXGzmE8UCcNi8T9GJhALrBQIjnOYD+0QN29YLtuyICg3h3
 cs9ftkFGpBPMOQLJlhTXfWjQGd3zNZfIE8mIttMHGdnzB/Lxuq2rt69yLnDZjqen3z38CsR3nUX
 MP6ClPPXUmfjv/d7BmGSWMsrbIaJGoNtUfjlgvLInbg95dA==
X-Received: by 2002:a17:90b:3f8c:b0:3a4:7730:33dd with SMTP id
 98e67ed59e1d1-3a78776199bmr8709901a91.58.1791292212046; 
 Tue, 06 Oct 2026 06:10:12 -0700 (PDT)
X-Received: by 2002:a17:90b:3f8c:b0:3a4:7730:33dd with SMTP id
 98e67ed59e1d1-3a78776199bmr8709876a91.58.1791292211586; 
 Tue, 06 Oct 2026 06:10:11 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e5a5ef5b60sm21992595ad.73.2026.10.06.06.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 06:10:10 -0700 (PDT)
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
Subject: [RFT 2/5] drm/msm/gem: dma_map/unmap_sgtable()
Date: Tue,  6 Oct 2026 06:09:53 -0700
Message-ID: <20261006131000.81501-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006131000.81501-1-robin.clark@oss.qualcomm.com>
References: <20261006131000.81501-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ctMOAF4i c=1 sm=1 tr=0 ts=6ac4f334 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=isCY8TonHXl0-fnU9HAA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1MiBTYWx0ZWRfX4XaFZcyYaiWJ
 WpEhwwLovs++aHAyN7U0M2vu2maae1SvErKyUSzDEVieVYa/UbLlblFZ0ibmD+uryrSlFMN0Tv9
 pXKNT8XCatj+pzweNNAg7H++ZDTiLjs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1MiBTYWx0ZWRfXxEJERZASYI9a
 +73DqnTboLH3gZaquQdCX3FJifp1DqGjE3MgrsZn131gGHvJHBm9CPCsIRy2dy8pXgijHfi7WKU
 ivJ/ibmG4FKr0YHIEjcWbXfXsuNlOkpajeCq9i91dM/a2+dZFE8oMikPooWqnJvOyAcMjfpDrYc
 HkiuwqcAwwEPQCcRntugfCwKFVEC2kCIdwpMQpb9TxpgNGX+n7xFrbRxpQqHyep+QySFlJlcLf4
 9jWs41pNM2pP7Qcw1JCpHiIZxTeeog16MorD14e6ky6E0TS5GlCGe+JwkM4uCQ9sFZL/WWHFUs3
 mFdeohr+C2j2T2Q8sYoSpSkyugXom75KZSnW80VJ/9oi97L3tGzo9qaGCyPJcHpz10B5SUJoezw
 lI05wxTFyHrUTp67LfAvb3eZKTSHdEiPJ7PxbmczZOa3/8nl1SgHa8hFMz5RkE1Dr1+1CGe8bWT
 hA9AFbs4nptMopt2Myg==
X-Proofpoint-ORIG-GUID: Iw0CMd3LtW14Sc9e15h_iAvbVKp-aum2
X-Proofpoint-GUID: Iw0CMd3LtW14Sc9e15h_iAvbVKp-aum2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060052
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

This should functionally be a no-op for us, since we are managing our
SMMU directly (dma_map_ops is NULL), but it populates the dma_len/
dma_address's so that we can use them for setting up pgtable mappings.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 181b9ad32672..72e3cd8bb1e7 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -219,6 +219,15 @@ static struct page **get_pages(struct drm_gem_object *obj)
 			goto error;
 		}
 
+		ret = dma_map_sgtable(drm_dev_dma_dev(obj->dev),
+				      msm_obj->sgt,
+				      DMA_BIDIRECTIONAL,
+				      DMA_ATTR_SKIP_CPU_SYNC);
+		if (ret) {
+			DRM_DEV_ERROR(dev->dev, "could not map sgtable: %d\n", ret);
+			goto error;
+		}
+
 		update_device_mem(dev->dev_private, obj->size);
 
 		/* For non-cached buffers, ensure the new pages are clean
@@ -233,6 +242,8 @@ static struct page **get_pages(struct drm_gem_object *obj)
 	return msm_obj->pages;
 
 error:
+	if (!IS_ERR(msm_obj->sgt))
+		drm_prime_gem_destroy(obj, msm_obj->sgt);
 	msm_obj->sgt = NULL;
 
 	drm_gem_put_pages(obj, msm_obj->pages, false, false);
@@ -260,6 +271,11 @@ static void put_pages(struct drm_gem_object *obj)
 		if (msm_obj->flags & MSM_BO_WC)
 			sync_for_cpu(msm_obj);
 
+		dma_unmap_sgtable(drm_dev_dma_dev(obj->dev),
+				  msm_obj->sgt,
+				  DMA_BIDIRECTIONAL,
+				  DMA_ATTR_SKIP_CPU_SYNC);
+
 		sg_free_table(msm_obj->sgt);
 		kfree(msm_obj->sgt);
 		msm_obj->sgt = NULL;
-- 
2.55.0

