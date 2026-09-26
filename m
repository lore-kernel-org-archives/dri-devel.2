Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74ECC98332
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 18:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9469110E2B6;
	Sat, 26 Sep 2026 18:32:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pgGtQ4fw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ggZ3kZ/J";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18FFA10E3C8
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:31:54 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxQKj3167930
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KEn46yPk5ku
 xZ+umsZjKseSAIl9VBEmi21YoVSuxwYk=; b=pgGtQ4fwu5yEoXMV39+99q5F5yn
 6E8/T6zVomuf8x5cmiirEvUUu1z5iMAFu22OopK8EiE1rhl6uN/lvLA+fZUKTf9N
 uIbfNhuqBK4W8yF32BBVYhnmDsuLpGSuM6D6mlFdvI4rXFpaAaHYeWcdQ8irdgBA
 J9UKFZVUv7xCdTrlZR0f9F6wIlN89T7VH+dVHh5InPdmY52QQgX8b8yrFOKcJ4jY
 KrtzweC8g4vBNon47eUzq+QSUWo4owj0tlwihDSd69yr8UxFi3y9EZ4DrwgWIaqp
 5zDB4px2yY0jUyufB0/m5yPe8hoquBBzhJ5nsmzPCrPRI2vbIK4jf+TTxTg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx77jscs1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:31:53 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-395543dc382so1981060a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 11:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790447513; x=1791052313;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KEn46yPk5kuxZ+umsZjKseSAIl9VBEmi21YoVSuxwYk=;
 b=ggZ3kZ/JwmSdT3ymo22lH6Rn9SaTRHq9ARFVY3u1nitfXAQGTITAbaP8lZ+aPP9LnF
 IqAYVoPo2SZbE+gDMFT5hfzdoq/PtegjtW+XNKWxuucyxCqrP9tGJkn8rd9cBDMJ8XtM
 1cSc9tBOfAJiMTsbf5n+zKEffuLwkNpUxFrNLGEvc5MfqQ3tWJgNxBE5pWyKJcNVLhUq
 Gx/W7casYa/nhFe9AT/QrNwnzwUrkNXhlhUS0M1mw64SW38MQz3Xk/CswClzgcaLdyXf
 vBqT14bNiOWFc33v6j242I8zlh+4sTpKkfjujRi2f8yw14CS6zJjNdy21RSU8vzChThH
 +Skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790447513; x=1791052313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KEn46yPk5kuxZ+umsZjKseSAIl9VBEmi21YoVSuxwYk=;
 b=g8u5URm500LJsD9vlynFg3G8ptUnmmaIayGN0lGknmusxLnpeQkc5s8v/cGPNj8gSQ
 REVJp07kCTwXl218XzM/+kZZtMNn49RiVuSRz5Q9+e2uufP7SFKqbJuYW6HAYUqJ8One
 IVhRi5oX3UyYFG3FP9Awpu01BtixBVsi/PGOpFTYxB446kjtv6VGkBJhQ+4eCHvw7KUU
 yPpapFsAAxxXhCTZVbh81m7j+ltjepKGPCHtBSs3WSm31xyDtxSuCOBuG0bgg1Xs8b0z
 ziCRlhRWoWBI8gO3TFhIShwjuMzbX7Jk6mrNjDE39KqwQKlYqnr2D+CAzUTj4px6XbnH
 wQEg==
X-Gm-Message-State: AFq9FYKWMAHhO++qUddB5Dz65lVpB9bPLUXcCtqoDI6jAXkrlXgGslh3
 yMCKYVbxX1M0gMyd5bbAKlOPGC3O/SM9vu7aJD6jJXH5DuqDhBOd10nawY3afnRBNEHRlUbVyoI
 FYVlNrp2bhpoG9xD6MawAr7o6PxkZ4yIorEY747sflTb6raQOPEVyy4UZX+3Ub3f1tbA8PpeDyN
 fVOok=
X-Gm-Gg: AYBFou1JNmWd4RvFvIX1zVq97l1c3e1NgfBazmnI2m1zy7OJYROjeal5NvkY+lHUu/5
 /0mdsSZ3SvwQ8HikzqmF8Apj0XsF6WDEZuqgVT66tyrAAyZc3NKCPBXmv1c55UnEcTRa0aDn6uG
 UcxcwKHucVClGNF4NXrLbNhPK2J341D9UjNKBKpwNDj+5TGPR3B4MqvOaa/lNU8LLe0VhDEGfck
 SVIxCgyJW/uEYtGH7dJrLgyBQhTDtTRvWlS4nwlEonbtQVdzHCfuSMVeFabrEYeG0tFDxzKA0Rc
 5D4QtasBNM7KFg4ePQBR7UFLi+5RpC2bFpIhkyCsaA5TCgOQbxjabvRorlm27zzYgYCovbUUZTK
 /MJtVtbWaRusUexq9lWkU5Zhr4OiszUqqMPsa5gCrzi4ygQs=
X-Received: by 2002:a17:90b:5807:b0:3a0:8050:2ec5 with SMTP id
 98e67ed59e1d1-3a0985be2fcmr6524322a91.12.1790447512743; 
 Sat, 26 Sep 2026 11:31:52 -0700 (PDT)
X-Received: by 2002:a17:90b:5807:b0:3a0:8050:2ec5 with SMTP id
 98e67ed59e1d1-3a0985be2fcmr6524318a91.12.1790447512313; 
 Sat, 26 Sep 2026 11:31:52 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0df614b02sm1960601a91.3.2026.09.26.11.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 11:31:50 -0700 (PDT)
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
Subject: [PATCH 3/6] drm/msm/gem: Use get_pages() directly in vmap path
Date: Sat, 26 Sep 2026 11:30:43 -0700
Message-ID: <20260926183051.25754-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926183051.25754-1-robin.clark@oss.qualcomm.com>
References: <20260926183051.25754-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA3MyBTYWx0ZWRfX5ad63rpmFHko
 Ov0pqtNRV8WUfMdogQ64UN7KIUsdSEmmIvrNgZqiJN2bfC/4bQ/49u+iHT/MriY9N+KYOSihdIW
 iLQCc+hpITMl2OSN90v71mxR9RjJYAs=
X-Proofpoint-GUID: -z7y6AxSqscjUbA79q0samEtDp63sHN6
X-Proofpoint-ORIG-GUID: -z7y6AxSqscjUbA79q0samEtDp63sHN6
X-Authority-Analysis: v=2.4 cv=J8U/fwnS c=1 sm=1 tr=0 ts=6ab80f99 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=bRy0bLnbznpkn9JxEt0A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA3MyBTYWx0ZWRfX+ko2lcDKC+Fg
 +YHv3qX8eqb1XfxOt3Aga6AzVfCSin0qfLP7qmoPhluyKfihVZwM2xpUmDi7/qMeE6aw+iCl5Gb
 1LCIcOO4+PDW9643Q8BIUXI3AMYStMjh8ix+WIuSaAIVECStwpVGyUG1m+Z8RjxNJh+bDiiG943
 zUwhiC2vKEbYqx1mHJRAhMH48xIkTBhRO52SzZDBiMNjZ1zvKxzbR0cVp9NsRX2A2WSqlQRvUEK
 A0E3fKTrwEpKeiYWegUEJlDiAv0c0qFWplZTRuyF7JY1AzE3h2hZWSNUGQ2yZPNvHwln53jcFC3
 U0COhMS9vE/kRUqmk736iHMatr4fpuKf6xeqQ3ohRJHdtHB5FiZ7PjjCUellsIcWdf5g9NjgFPC
 9AKbbZUsufqTaf4kUFOsDunUdFqw0VizdYHQYZkRb2k0L0t/AivRpp7zT0dCHyOW2Bv7XB0jUVI
 9S8iDRu+oMi6F+Vnb8w==
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

Split out a helper to check madv state, and inline what remains of
msm_gem_get_pages_locked() in get_vaddr().  The vmap path is already
disallowed on imported dma-bufs.  And the rest of the callers of
msm_gem_get_pages_locked() don't actually care about the pages, they
just want to know that the obj is resident.

This gets us one step closer to not actually caring about the page
array for imported dma-bufs.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index c90336b3b231..bf6a8939af7c 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -265,7 +265,7 @@ static void put_pages(struct drm_gem_object *obj)
 	}
 }
 
-struct page **msm_gem_get_pages_locked(struct drm_gem_object *obj, unsigned madv)
+static int check_madv_locked(struct drm_gem_object *obj, unsigned madv)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
@@ -274,9 +274,17 @@ struct page **msm_gem_get_pages_locked(struct drm_gem_object *obj, unsigned madv
 	if (msm_obj->madv > madv) {
 		DRM_DEV_DEBUG_DRIVER(obj->dev->dev, "Invalid madv state: %u vs %u\n",
 				     msm_obj->madv, madv);
-		return ERR_PTR(-EBUSY);
+		return -EBUSY;
 	}
 
+	return 0;
+}
+
+struct page **msm_gem_get_pages_locked(struct drm_gem_object *obj, unsigned madv)
+{
+	int err = check_madv_locked(obj, madv);
+	if (err)
+		return ERR_PTR(err);
 	return get_pages(obj);
 }
 
@@ -722,7 +730,11 @@ static void *get_vaddr(struct drm_gem_object *obj, unsigned madv)
 	if (drm_gem_is_imported(obj))
 		return ERR_PTR(-ENODEV);
 
-	pages = msm_gem_get_pages_locked(obj, madv);
+	int err = check_madv_locked(obj, madv);
+	if (err)
+		return ERR_PTR(err);
+
+	pages = get_pages(obj);
 	if (IS_ERR(pages))
 		return ERR_CAST(pages);
 
-- 
2.55.0

