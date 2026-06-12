Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81267CD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:30:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CEA010F62D;
	Fri, 12 Jun 2026 18:30:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ivZnQjum";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RhyQ4sX7";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F64A10F62B
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:28 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CGVafp047309
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VAc5Ikptycwe+SAdBBV6cT/v4cLIQIAkYHbY8Re0nJ8=; b=ivZnQjumAYn2ffrl
 Is7Sqx+bhSIzdvC7QxA7pmrNJEMhayWPE0cI+oG5wiLKNDeGlQayknv61BqZtUEf
 67MjnN7JcLD5O8FfZ+hDb5kLXtfidZb6E6gg1YmI4eFOmmjuc2UKM//YSgSWs/R0
 +seWyK/ZwXEJhtPfySsS6VMAkDWHI7Q4SdFa+SIjW/wY0aF+LEuO4M2bFJxRXjfa
 y12GojzejfbWsQSiK5GYXPfHPu+OOJTAxo11p2LznsRppvPat9ihKmXDafdqicG0
 g1AhstVX2RVdddrKeSIhnvNsk2BxVw6kF2SD+uqShvJaTNzGfGk5hI7sBbs1feBs
 RuRDVQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er76ek2fy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9159bc52211so181384785a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 11:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781289027; x=1781893827;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VAc5Ikptycwe+SAdBBV6cT/v4cLIQIAkYHbY8Re0nJ8=;
 b=RhyQ4sX7M4ohz1zG3P8q+wesKnp3ujSilqLXcIDsYFQGPCBm9K0Xb7MX+7egvJw1WL
 x6ZNfaWbFtCtvuWmTLZQKWurREQooKy3H6CqkEspFD/So9HVRX2s8YURbXOrDpKGwnYq
 lBgsD3yIgu5zEiHkySawrFj98hzs/t9VHkeLe4nxoKCp6joa1JaBWBo9hMoDCnl8zfoa
 uzWZWYOWFnddzcr8a5vZuFx601mQcS4oEVKoEqfLQWSeX7LhaUjUNgJZmOUKd4s/HwnK
 4sjMjTH0sZbcVG+LtOIwLSz/k4ZexqEwYD7FXV7K8kbzFV6qExQY0Br9VyviBbRsbek9
 29QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781289027; x=1781893827;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VAc5Ikptycwe+SAdBBV6cT/v4cLIQIAkYHbY8Re0nJ8=;
 b=PQMBqcP3tRol3FRuUjQxTjuO6v6ilxXTCFF67PioYFW2ZzyQRc5JY768XsxRByycGJ
 1FUbK+dIC7EWZeHJkL4Fzr5vCV8GN3VFGYnYR42aRNnsR2SKqh/PUvacVB0sNmr2ZTJy
 +YwcCViQP8bYlTc6PAwz1fsd+YRht2cHj16pwAZb6G3aSP3zdsoHjAZg1pHdHBbljk0R
 krVDiHeZnNxXxivx2UAPAkhOoKOmnfB5DROHawWyS3Ep0QvYBP11dUiOQ1w3f7M9tinS
 G/KKBkc/sVPWQWodXkoOkf4LSMptVKnENGHAELcw1XE1VaDhc281igR58BKhzvZw3qpE
 YPDQ==
X-Gm-Message-State: AOJu0YwTWrJ7OxZr5PD4RaMMtSji9tQAs0cm5TICwJayPZMQjYazYlwl
 HpjGeFjukYXwicINX1wcPqrff6C++fn/qdkFkVWJyJ9H0lDkwmIZ8nvTqd4F+LpH9KjSNg2wG4L
 o/BCNXcl+Kii8PY7grN0tNUjiGpfPID8lqSez2hjsWYDxlUgIzNNsA2FEnLm3NYCOE4T4kdM=
X-Gm-Gg: Acq92OGVUv0eptVToL9NQ0RWejNR6vVO3XRCAcZIIWmlL2z7q3V87Q9EZXtM3l9Xeom
 L7z5yQnIzqU3+ZBwzmkIC1JthiT+jsQMLBdOtP1NnfF3BtzhE42OiOR/6Pbf6FX2oGi6dlYojAu
 vrpzotM5Z49GtlDstDTnnxcw6TesZURtieT4XAk2PFZPC7mncuGCJzsNKpVaIw3pS+Rmm8PM5ut
 5pcSf5BqA5aL3hNi2HtAlpoPxGiVdMmvYi2JGoOZ5fuk6GCqM75NFlKHIJGYwGMDaptXcHghien
 3+PKW0lwgXnCDLunX8xQvah7FcV+NxRMe6DC6lg75jpCDg9u5hiL11d4r5p5QBlhSlgbUyhi0nc
 v6IoHIh5ITQVQpBGjr6i5FMgsonygzpZe7NrDfJh0qUgHpnuMNxXIDUz1NQRcm4PqDnm53ZCMcb
 ID5Qo9F6tFYLNLKOV6Kb3pWkP46wMjJhRrTj4=
X-Received: by 2002:a05:620a:bc8:b0:915:a73e:3544 with SMTP id
 af79cd13be357-917f1c56720mr144565685a.56.1781289024614; 
 Fri, 12 Jun 2026 11:30:24 -0700 (PDT)
X-Received: by 2002:a05:620a:bc8:b0:915:a73e:3544 with SMTP id
 af79cd13be357-917f1c56720mr144477285a.56.1781289020618; 
 Fri, 12 Jun 2026 11:30:20 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e161fefsm742173e87.8.2026.06.12.11.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 11:30:19 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 21:30:11 +0300
Subject: [PATCH v6 1/9] drm/managed: implement managed versions of
 kzalloc_obj/objs()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-wb-drop-encoder-v6-1-9f3a54f81310@oss.qualcomm.com>
References: <20260612-wb-drop-encoder-v6-0-9f3a54f81310@oss.qualcomm.com>
In-Reply-To: <20260612-wb-drop-encoder-v6-0-9f3a54f81310@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1773;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ns6ZF2Athx6EXhPPsCUzdeEz8OHVy14bl5aTVdNnAU0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqLFA2BP6d00ejrEHxJYdHp2X9IJejczYLfY75d
 jXdts+qMaCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaixQNgAKCRCLPIo+Aiko
 1YyuB/4/+1uiqA2fryPtK0Q7ctr1kG3ePgcUSkHFnblElLxP9p5KAV0NVSrsZu64PP9Uw8QhEHn
 eku5gVTB4fteWoAdmRV6MqED5jUCgtzKxXw31I6q2yE0HMzROPxsuZqjck649m6vQ+6gjWPoIYP
 tSvCAE8vpvPK2pQ8s47BDO71QWO174Xdq0Kyv6QPCsjDT1q5muBBfuIckdqMamMRRmXbJArYrNK
 GKbQ97M3DoUAW3s0S8dCBmtmiaDK2EvYKKZZ6xfYMjkleX/ieanilprQ/xFXxojPr8xMZnF96Zd
 t+bDLo/Q7QnIlQtPjN+RW8IeT2wx6PpYUovOoPNAnHFW6kFr
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=O94Jeh9W c=1 sm=1 tr=0 ts=6a2c5043 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=6OF_V-VfZv2apoI2bYYA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: tiwO7Mm3cZeSAsd_YhfCwAMlDNmoEOPW
X-Proofpoint-GUID: tiwO7Mm3cZeSAsd_YhfCwAMlDNmoEOPW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfX9XAZiq+wW0IV
 ooDZcO2HlPyr/oqtqDf5VoIwXIv5bPhrflSCI13gdSzzp8gDTVH2WgOEwS/rUFRUusEvIswbd1l
 WtJ8za/V10hMaVdoj2ZFeICG8Q3yxQuBQbzAIlt1t2MmsTSL4yQXJO+v4wcrs9SzTq3QLbSqrS+
 Tn+62hdm7XnaOtAPLZpuJ6g9RAdWvf/Qu0KwpFZBtGK7bTzFp8+8mKqhxpH1wp1pNw93m9oByv4
 VYad9pS7swzlFDRYMYRWsU09vI8y8tGvOW9tmZjlVc/KeMh6WjzLfux70zJesILLxBw6iDRzSBs
 erV655jUgXpuuw/C5dpS0ORSz7NyMu3W9AaUemwI1eZQ8QPjnQZYlDrEFKMX/fnufPmQNFf/RpS
 x+mH8xgqC2DwhgVcUPo/ksKz5C36w/84ATfciBV94rr463zoBudrCYG1JFYD5fSEksbPUh7iyYT
 70LLhFR5IEYAdTR2IBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfXwFRizRI3q+fG
 cymqgxSbs3tMUaSUdZR9FlEDIKCMOgzo4tnxMgKzu1Ol6t7N7DUW4VbCv6aQnmldQWXeNgRYh9i
 mv515YiqN9gT2C4uKA/LCzI0sjVVlv8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120173
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

The kzalloc_obj() and kzalloc_objs() functions proven to be useful and
widely used for the reset of the kernel. Implement a drm_device-managed
versions of those macros to mix the nice interface with the automatic
freeing of the pointers.

Note: the original macros accept optional GFP_foo arguments. They are
skipped for now, making all allocations use GFP_KERNEL. If necessary,
support for overriding the GFP type can be introduced later.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/drm/drm_managed.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/drm/drm_managed.h b/include/drm/drm_managed.h
index 72d0d68be226..79049bec277d 100644
--- a/include/drm/drm_managed.h
+++ b/include/drm/drm_managed.h
@@ -105,6 +105,28 @@ static inline void *drmm_kcalloc(struct drm_device *dev,
 	return drmm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
 }
 
+/**
+ * drmm_kzalloc_objs - &drm_device-managed kzalloc_objs()
+ * @dev: DRM device
+ * @p: Variable or type to allocate an array of
+ * @count: How many elements in the array
+ *
+ * Returns: newly allocated pointer to the zeroed array of @P on success, or
+ * NULL on failure.
+ */
+#define drmm_kzalloc_objs(dev, p, count) \
+	drmm_kcalloc(dev, count, sizeof(typeof(p)), GFP_KERNEL)
+
+/**
+ * drmm_kzalloc_obj - &drm_device-managed kzalloc_obj()
+ * @dev: DRM device
+ * @p: Variable or type to allocate
+ *
+ * Returns: newly allocated pointer to a @p on success, or NULL on failure.
+ */
+#define drmm_kzalloc_obj(dev, P) \
+	drmm_kzalloc_objs(dev, P, 1)
+
 char *drmm_kstrdup(struct drm_device *dev, const char *s, gfp_t gfp);
 
 void drmm_kfree(struct drm_device *dev, void *data);

-- 
2.47.3

