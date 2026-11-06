Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7A7606D810
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GBZFvIQT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J2OqNHZg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AF8D112D89;
	Fri,  6 Nov 2026 13:44:57 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10754112D89
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:44:45 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6APkPE3685265
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 13:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xvpV7huPZOlel7iSSvUNNhoLboYoj8TboGt9Ixyle+o=; b=GBZFvIQTGt0yxwew
 VfjJMKC3DWQx1y5HV8xDitYh8SRUZi9Pn1fpydibyFVtI2IqNBQfXH1dXIBmjcku
 hMOREk61sIunKEnxGLoLN8TQjHMXhefPF/9owEwxlCPR/KS7Re7XSj2fHNKlMzsU
 3Ysd+MWT1jXNdpEC1Q58tZCbmcBhH7YfJLe2+uWb30ynIf8VaWMd1UYqLuHo2bJO
 YbJoha7rvUYiQseoBx/kBFyffCpO9tL3NIPq2fWv8RfiUUAwrPCPYNl3MSjrSonT
 ZR4fKfsy1AOCONSQFs12AlKwzlj5LiLD49zAfuK9mkWMQBw/84ovrFC9l7fcP+HK
 eewsfw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa3045-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 13:44:44 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ce7a85f04so142302685a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 05:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793972684; x=1794577484;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xvpV7huPZOlel7iSSvUNNhoLboYoj8TboGt9Ixyle+o=;
 b=J2OqNHZgXy4M5v2HBi6TlMJRn7BfmQhxImauH4v+Gtnv+ZSJ9nF9k1hhMPKj7a0uwR
 SXGNWxps4+1sXu4abehNTiaziB3FURz/9dLKkyse+nrn+T9lQD/wKV641nAbzD+hdObQ
 FuKhgGAaXCwUApdjC+/mo8a6Wxxu/63EU25tdA8Tru5zQiquDenePG56lHhvJR6diKCt
 GlwMGT+3Wu1GfXxdC7wjrZRAHo56rak2bymraXx0D7Aa09UVCFULyzTJjvZkp7DQatzK
 RmvhQf2+epU0mb7KEdHU+U4bKcSkgOe6ffLsVccF8Oi91jF/v1RwnjphDQkdfUMq05so
 sXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793972684; x=1794577484;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xvpV7huPZOlel7iSSvUNNhoLboYoj8TboGt9Ixyle+o=;
 b=bq3esptr+olV2/ML+qDU7j8AbiTrOLa8GuX5RtQg2QAJLSPcFg2GDD14yluTdqP9Uo
 7Tmw8il0mAyLSEJmJST5RRcqNdWm4b/ff8QYuxBBuKO9F4Jfx13mzPUsa/ivG9THFDHF
 G2Y3dVsDrPdOak1mObxe72dRqJCKadZqMHs4BpW5SHnhIJsEnaS8kSIDiqVbjIHrTRWV
 53Yx6d9JANFKHrifnAVwx0Egk29AsE3OSmhp1Tsc+RpU47dKkGyOqHHMDIfcwNw8AkWX
 oiqUzHOatcSR4MmXw05H3T9yPp6ie2DpY2toCkKadzVMW2a9stEzuHRQhpJe5z0ABve+
 HTTQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVXkBbc2GimVYiNKQgKUYDJK884f7ohqqJzItH8vqwAl2ilUdfzPZk5hbvpTr2dZJlnyFvjCyP1MU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+bDTCG0G1fVvotoXzWyW0EKBCzA+EK5cimdvwAiiTw5VUUXaSj
 wVnDgU3LzFhLn7d6FHwTjqMl6pFiNyfhuQFgcFQ8CVlazxppBqlm6LhRfGBmfs3VteIoVqiS0oM
 LFIvyjZYoumyfFtWTWFfKiAnB0D3hGIA+qX3GtCmkXpGoh3SDOig89J/IE+zS3D011aherd4=
X-Gm-Gg: AYBFou3twldGX7fNVaBwMjqkXJw7dzAHiF/B5jFe9JNyQL3tQ5Itp3EBzFuqT54Jm6t
 2FQDD9HVM9JchuNDCPmH+SuXdsIwag71zA8l6Oe2lFttC4YX8PRlyKje4/9n5BlJcr7IS0zQyIM
 Xgp44yM+1y1IF6XnZO97RspHeAzFtPyNCa6Zq1Gnc8yk9mybdp7zGLNhhpKgvKFXQmCwoRsnsHH
 6j1XTEpeujb+EonIgTaPtNm1S1FmBBOJ29YwZqY8ItkmChX+SeVd+ygbQACiBWDF/pLBAtTVBM0
 9UGUyzuMljCvlSxXSzhNgTrc+U1f6nRJbh1JObObsV1xd4dsEV+6KDoKVnF/SRk/jLBg546s1Ym
 K/gKDwBrFR77anD3BWMk/bAsHxPm1cMN6bd2YVeMACozhMowE2C5esYfPix9F3Ljbr7zyFsHMdY
 Js+6W7ooavNgPySk9C7bGYzfysx8CkFF/HCIF6QHiwCaPXDT7MzphLoyxHm0MTKQ==
X-Received: by 2002:a05:620a:318c:b0:945:ca23:e00 with SMTP id
 af79cd13be357-945f35dbf68mr352009385a.58.1793972684198; 
 Fri, 06 Nov 2026 05:44:44 -0800 (PST)
X-Received: by 2002:a05:620a:318c:b0:945:ca23:e00 with SMTP id
 af79cd13be357-945f35dbf68mr352004485a.58.1793972683453; 
 Fri, 06 Nov 2026 05:44:43 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c003055a5csm382747e87.13.2026.11.06.05.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 05:44:40 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 15:44:10 +0200
Subject: [PATCH v2 4/8] drm/msm: check UBWC framebuffers against their layout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-ubwc-format-docs-v2-4-82949f88f030@oss.qualcomm.com>
References: <20261106-ubwc-format-docs-v2-0-82949f88f030@oss.qualcomm.com>
In-Reply-To: <20261106-ubwc-format-docs-v2-0-82949f88f030@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Bryan O'Donoghue <bod@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-media@vger.kernel.org,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Robert Mader <robert.mader@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3415;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=6xPvBKvXF4Oj5ER3IOirKs4PSww1szDN0iEI4yJmcYk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq7dm1xmEojRhtbHd26chPgyY5e9DYUB3anpavp
 sGYE9QRf6uJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCau3ZtQAKCRCLPIo+Aiko
 1aybCACWYFM2oDjJ4iQ8s/DVtvJt4yeL6Z+vXT5ZTRIExu9PNK25Kr5AIqBHZMkgiJkyTgutTPj
 8birGSMAO+r6KJCGQcbAzr2ElX46/NVd9PubPCl1CbCHcAIZy9dP6Jn7n0y+8RvJhh/1Rj2Os3p
 ztKl58J7/xel36mG1SW3pVq3cBk0IsjpjsVRFDSPSHiz3gPrz/LEBMtItmvBl5Ha8NisCdBUdWM
 kljD7wThly8rGkRBS0iPRhbm3WoI81lYl3BgKyQXolQ2LnfmT4IybHXZVc17b3kDlTskbmZJjBN
 kEkpUolW95vQmhIt2vNiHa/kwm+uvPcjzIQsZ5OPVFKcJnVn
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 5m-seO---cpTr0xJ8gftx8ul5L_yZWwK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NCBTYWx0ZWRfX2TNrJGD8fMbX
 3YeEcQ+/PdGX5CgxnJ4YzrgSlKTPrek3yM26H+znFbyT7Phv2zSluyjz/BUWd5mlVVjPTw3fGqU
 9JreM76+DNR1GDzsNFvVQAHAdM+tTyg=
X-Authority-Analysis: v=2.4 cv=e7WT2qp/ c=1 sm=1 tr=0 ts=6aedd9cc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=gedFiD_-BdM4RCKrvjUA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NCBTYWx0ZWRfXzeWdmPEiAVpQ
 M2Fe+cHsO/u1cFB06BGDw1/8hi1N/GLnyitpIchCf38rT3iA0qX1QJ/l0XqDzZkpcXZeFG+tlca
 hXwwthg66tk+h7e5BZFck9E3QRAxI231eAGths/uxwz7d1xvZGJWUWMJwqdUucbVo8ARPH4ynlm
 D8WmwYRPV8ZnPvz2y03UIGafZvVzXL0rpHUJBuXEIjVzhbFYO0OpnbpX54Yjf+fpB21actbUTIS
 fmy9EW2UGn8ju+pGPTdgsxaCj1XlRi7Sd6KAM3JlDFkXgPGul3JjraY9LALxIkXbFvSFUKtK/KT
 kArN9c6Xq6nMChyKvyWTRpHiImssS043in7S+RuXeOl0qtyTKMdiv+HabE4voLZqAp9/Pb3QCYa
 O+wW7hhcL2KEChdT7RffWr49RhTNURndol6VC/swYE1lIyI/SjHOx2bmvBKRuA4cy9dRCNpSOCH
 XEEcAhBYkwnp/fqv1nA==
X-Proofpoint-ORIG-GUID: 5m-seO---cpTr0xJ8gftx8ul5L_yZWwK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060054
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

msm_framebuffer_init() checks every framebuffer plane as a linear one:
(height - 1) * pitch + width * cpp + offset must fit into the buffer.
For UBWC this has nothing to do with the memory the DPU fetches.  The
metadata and the scanline padding are not accounted for, so a 1080p NV12
framebuffer whose buffer is 15872 bytes short of the UBWC layout is
accepted and the DPU reads past its end.  The CbCr planes are checked
where the DPU does not look: it always fetches them after the Y data in
the first buffer, ignoring handles[1], offsets[1] and pitches[1], and
userspace relies on that (turnip reports offset 0 for both planes).  The
pitches are not checked at all, as the DPU replaces them with its own.

Compute the UBWC layout instead: require the first pitch to match it,
the CbCr plane to be in the first buffer, and check that the metadata
and data of all planes fit into it.

Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_fb.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index 1e236416e15f..dd24aa7a5ee8 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -13,6 +13,7 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_probe_helper.h>
 
+#include "disp/mdp_format.h"
 #include "msm_drv.h"
 #include "msm_kms.h"
 #include "msm_gem.h"
@@ -146,6 +147,7 @@ msm_framebuffer_init(struct drm_device *dev, const struct drm_format_info *info,
 	struct msm_framebuffer *msm_fb = NULL;
 	struct drm_framebuffer *fb;
 	const struct msm_format *format;
+	u32 ubwc_pitch[4], ubwc_size[4];
 	int ret, i, n;
 
 	drm_dbg_state(dev, "create framebuffer: mode_cmd=%p (%dx%d@%p4cc)\n",
@@ -177,14 +179,41 @@ msm_framebuffer_init(struct drm_device *dev, const struct drm_format_info *info,
 		goto fail;
 	}
 
+	if (format->fetch_mode == MDP_FETCH_UBWC)
+		mdp_format_ubwc_plane_sizes(format, mode_cmd->width,
+					    mode_cmd->height, ubwc_pitch,
+					    ubwc_size);
+
 	for (i = 0; i < n; i++) {
 		unsigned int width = mode_cmd->width / (i ? info->hsub : 1);
 		unsigned int height = mode_cmd->height / (i ? info->vsub : 1);
-		unsigned int min_size;
-
-		min_size = (height - 1) * mode_cmd->pitches[i]
-			 + width * info->cpp[i]
-			 + mode_cmd->offsets[i];
+		u64 min_size;
+
+		if (format->fetch_mode == MDP_FETCH_UBWC) {
+			/*
+			 * The CbCr planes follow the Y data in the first buffer,
+			 * offsets[1] and pitches[1] are not used.
+			 */
+			if (i > 0) {
+				if (bos[i] != bos[0]) {
+					ret = UERR(EINVAL, dev,
+						   "plane %d not in the first buffer", i);
+					goto fail;
+				}
+				min_size = 0;
+			} else if (mode_cmd->pitches[0] != ubwc_pitch[0]) {
+				ret = UERR(EINVAL, dev, "pitch %u, expected %u",
+					   mode_cmd->pitches[0], ubwc_pitch[0]);
+				goto fail;
+			} else {
+				min_size = (u64)mode_cmd->offsets[0] + ubwc_size[0] +
+					   ubwc_size[1] + ubwc_size[2] + ubwc_size[3];
+			}
+		} else {
+			min_size = (height - 1) * mode_cmd->pitches[i]
+				 + width * info->cpp[i]
+				 + mode_cmd->offsets[i];
+		}
 
 		if (bos[i]->size < min_size) {
 			ret = UERR(EINVAL, dev, "plane %d too small", i);

-- 
2.47.3

