Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94D0CD342C
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 00:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1867210E8D6;
	Tue,  5 May 2026 00:25:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="F+YeDfkZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KOd2ji+T";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AE1D10E8D6
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 00:25:15 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644JbQB13467600
 for <dri-devel@lists.freedesktop.org>; Tue, 5 May 2026 00:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lefrgJVtEuX0KnRNQkpJGxwI16qD4hB9JXPY0Y5ZgqA=; b=F+YeDfkZWHOFpsDG
 QKXjzg6cxfHFinv0XRe7h11p3xF+u7RekwweaodT6oPiCxc43o2E/JloWzGY7mWF
 lQSHr78s9pxYtfGvQqwL4R54mLHB5iWS3ZNXdKWDprfhazR77KFU5R+lE1Pu8sbI
 mNpoyH1wHenN8AFoV9z4b1vwIsQUOLfrx1JFNQvx4wExcnu42tqno7G/eeTofRml
 rk1cMxbPy4G13s8y9niO0JnYoYc08EG0YQ4meaILo9vG7S4REnk0osqvG0Htyi4G
 xndOs8uJYk6LBmvMmMmabl9xfWkvpMaRYJXzVWRLpscJG2QkJiInvxhzGUFQeIev
 fLxNrg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvtjt4jq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 00:25:14 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d8ed08aa4so163558761cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 17:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777940714; x=1778545514;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lefrgJVtEuX0KnRNQkpJGxwI16qD4hB9JXPY0Y5ZgqA=;
 b=KOd2ji+TH8V+DPEKpGntMqm1V6P4HR3qsQ/46c7Ht7WAYUeQ0RYfn18RYK3eldjMPV
 wifshnz7yyDE8bze2hLJhQnF5Q6BaKg6WmERakzTV6u4p/PyhAaQW/ZtSAt99Rf6cVGZ
 TAbqr7FuDa0+GVrVVI+VRJNcFP6Lgxx5ZXzYDp8+sYZ/6SNCLXHVVqByZgbjwH/MaMt3
 lOO2+T2pYQEucOTSU1EsfCbVUuPyN0MjMbDrFhUiSWlYJOvdFxTda03NUCYuAHXnbFY0
 PVwyxxBk3MYbhKGjU4zBjD0GxbzNxh612gQJsQIzLSySuvZKyRAvkkGjNcuM79SRgVTB
 6sRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777940714; x=1778545514;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lefrgJVtEuX0KnRNQkpJGxwI16qD4hB9JXPY0Y5ZgqA=;
 b=g69Z8gVuaCv1DpqpLoC+bET+DNd8IQY84x8xFeNzZt4X+e6LU2b2eXytQemwCeOrQW
 oeKAF5Hv1n0X/dEEwv2cc+hLP0FUpDpQqn+BVIQee++vafqaKygG0nRp9UvHpiwZ3Y42
 DwNfk3MT9WE+YfYmFRSsevne7w/TPGC797TK22X4Xi82m4tkL8CkfE3zLzx8FaqUEvR6
 60V3tGQF+0i5X4nJr/ZtiuwKppr4DjEyt26AF3rOuoHlQ5bILaYYSBEJPfbxuoaYDUIR
 pPw2EnWDY2KtACYF3l75GZI2YkNTYkPwWNIWXDDgTMX8kwvGJHNmbPGCYDsTxjUzz0ZJ
 Nlvg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+m+9ACBmozzH3p+BBqpF7ChVTHqxoCuf2fQVwsFZifuRrptnZdVLC8JDl6WgNgfsG2KhF72vlJVMg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQ9mjOp6y6ZvK3g5oclWRweGris/TQ511VIBjdGpMHDxOJLKYH
 /0v7rlMdiIxs2bWAMFy80TMI7e3VHP46hEOA0y6fOlmYkpwz5bGK742ItSGMS4P0p+B7wI2ETAg
 Zexoy5FOSb+lwPQVUoNtRrxBYvlVoOWVH+EZqmqlRXZHsOfqMZ4WJMGHb1RbgsL3HAWQVFso=
X-Gm-Gg: AeBDieuf5vzBItzenvnwymWC+DuHgh9xyXZCW+I85+c71u4lzJcymovRtex9R6Bo3o0
 VU0bQzH3xJAXK2z14L9Eq4e/v1svdzun4cCv3GGu01qF974qyL6xhF1JO3NQWrHENPGT+EayLny
 Sg28BTtw6IqzkQGIbM6IfnImKeBNSsisxypt9G9rB/Kvu1KwRSy8guCuIDuPHQZQVz22xFoRDSX
 4zOf8RUbb4QwL4uw+LpJWuV1gqynB9KxIvxqV4V07fuVcYdtRQePz/yihAnbzir1q8o/esBk9EB
 1nIb5vYwd1QHGKZodqvS5Br0CNV8Hj4WicqgjHD636Iv568dM2Z7x2Z9/2h0KPTmYm8qFVfSaQo
 5U5tfjx+jNdUxSpyYkbRK0ObrHsUFZRb58nYFN8D257UhlaUJfdH4SgOxC2AzWRv00gwOW8YuO3
 vUl/VVZgGoUw/91KMPCLIkQQYRybaOJ0pXsHyNIjxpUkXzXw==
X-Received: by 2002:a05:622a:282:b0:50e:61c1:685f with SMTP id
 d75a77b69052e-51306b1844fmr14830891cf.50.1777940713709; 
 Mon, 04 May 2026 17:25:13 -0700 (PDT)
X-Received: by 2002:a05:622a:282:b0:50e:61c1:685f with SMTP id
 d75a77b69052e-51306b1844fmr14830191cf.50.1777940713228; 
 Mon, 04 May 2026 17:25:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393610ba09esm37132781fa.10.2026.05.04.17.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 17:25:09 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 05 May 2026 03:24:58 +0300
Subject: [PATCH v5 1/8] drm/msm/dpu: don't mix devm and drmm functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-wb-drop-encoder-v5-1-42567b7c7af2@oss.qualcomm.com>
References: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
In-Reply-To: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=dH38C2Kbg849nl4YLqXv/0VJPZa24rewDmxXYahkdsA=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ+ZPi9unXUNNI00Krz7+VDWt6BKz8kdLKWkRphtrvT+tO
 F3yoFekk9GYhYGRi0FWTJHFp6Blasym5LAPO6bWwwxiZQKZwsDFKQAT8djP/t9rQ8Yu81/an5q3
 rJSazL88v6Qg6rqfci+vw4F392J2OXhb6F+bXn7AUl1C48Ae0c1tbAcX+j+ZJflB8KL5/HkqJTN
 ye/T1bjRqM0+PfOD7Ivx9ZcRf9SRLa8/eeJmSyWEeQg7iocemipjYJE66WOLjYqdknH9QZIZhhc
 SFWQmania3X3p0u63XXMTwUzw04VhArOWiPNv3Gadi7q6sCPrJZ3z3Y8WlcrM0Cyev5stMi14q1
 Ey0dW1ke2VoVigm05CXIVTAPu/wnl8LT7t5TSg3nf38A5NlKv/6Pe3mn+701XoFb52XvZ3V47Oz
 bMzx997pzGmPbn84VTR9Y1ffnBe27nwafrm3bhcXpxwDAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: U_CXOmDlSat6mfMHX5JzBuFAwlmNZ1ry
X-Authority-Analysis: v=2.4 cv=KuN9H2WN c=1 sm=1 tr=0 ts=69f938ea cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=x0dpNPXvP2gp0MABG64A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwMSBTYWx0ZWRfX7pIlGesh4RSr
 e7L4mlfKs8Bu/lbLCSZLUsJfKmwLAjAI3t68tnosp1/8MRu2ndYGcHNRLRdSu1HAhaxJn9DLYCZ
 63v2+EZ5Fl8YSOnqrQM0YjMdsACZ7RTdCBo1DND9SiHWEofTEICsZ3EBYKl9LkkvnDnZMDOrdhn
 MKij2vP2l4Q5robod2jnw4u9VnGp069vEiN/7l3wM+pmoEvMmpi/ap0V7UOtKKOWsxfPT1PZVGU
 8cHMppHF/vgsw7KdrXDMEvWif2MzsU0HBerjWu4fKVT/n83JKyQqxecGKW8vJNvOJWwGxhqB3uT
 Wo8ibuo7drWLJIFGlvgpdBai9WVtgB5cmp04oFysbqZTWU6mnogIYnqecI3hujIpgRikp2gl32E
 PH06g+J6TZQ8moH6jqNocZAiwNUejTCX4nfnFHwY2Wxs0lCwbsrw4Bzw9Y33+SWYKR/7eeGjHXK
 qjUOb2UGZAakpkg77ug==
X-Proofpoint-ORIG-GUID: U_CXOmDlSat6mfMHX5JzBuFAwlmNZ1ry
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050001
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

Mixing devm and drmm functions will result in a use-after-free on msm
driver teardown if userspace keeps a reference on the drm device:
The WB connector data will be destroyed because of the use of
devm_kzalloc()), while the usersoace still can try interacting with the
WB connector (which uses drmm_ functions).

Change dpu_writeback_init() to use drmm_.

Fixes: 0b37ac63fc9d ("drm/msm/dpu: use drmm_writeback_connector_init()")
Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Closes: https://lore.kernel.org/r/78c764b8-44cf-4db5-88e7-807a85954518@wanadoo.fr
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
index 7545c0293efb..6f2370c9dd98 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
@@ -5,6 +5,7 @@
 
 #include <drm/drm_edid.h>
 #include <drm/drm_framebuffer.h>
+#include <drm/drm_managed.h>
 
 #include "dpu_writeback.h"
 
@@ -125,7 +126,7 @@ int dpu_writeback_init(struct drm_device *dev, struct drm_encoder *enc,
 	struct dpu_wb_connector *dpu_wb_conn;
 	int rc = 0;
 
-	dpu_wb_conn = devm_kzalloc(dev->dev, sizeof(*dpu_wb_conn), GFP_KERNEL);
+	dpu_wb_conn = drmm_kzalloc(dev, sizeof(*dpu_wb_conn), GFP_KERNEL);
 	if (!dpu_wb_conn)
 		return -ENOMEM;
 

-- 
2.47.3

