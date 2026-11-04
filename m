Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99050606A329
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jP7Bpvk2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fyvrbyow
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0C2510FD38;
	Wed,  4 Nov 2026 16:36:49 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C4F010FD38
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 16:36:35 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Fj96p1692579
 for <dri-devel@lists.freedesktop.org>; Wed, 4 Nov 2026 16:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xvpV7huPZOlel7iSSvUNNhoLboYoj8TboGt9Ixyle+o=; b=jP7Bpvk2XgpNT4vZ
 wIu0A6jDZUDNWqV9TJQ8/ScmE1SrzWCJEGMCkuPhZnUqqsnCH9/iRSZD9q5YD4p6
 2Vpsk8ooOl69g0EgjS2Y+hjxj4T9rOOUseg+DLHyG/DX9dOTtMtHdcQvsuoXYloq
 JH1CqLReCHPzY91KBWamyNdGMBKqpjfC11XZaoySD+73+gAVlEoO0xK0hHMtlWOn
 2JzP8JXCcPuYvRA+BmNfR5Mub0pRSOjj+G6UiQG05qpO6fBfXnml/O4Tqp75LC3c
 0swoYMt143rBOTWficYoFvLw7MjhFcKimYBOTpvhBorJRW2gs9It53MmGaxIe0Mx
 v0vljg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6br0jjs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 16:36:34 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91c7a26f892so20579896d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 08:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793810193; x=1794414993;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xvpV7huPZOlel7iSSvUNNhoLboYoj8TboGt9Ixyle+o=;
 b=fyvrbyow9fSCmFgXM0p0qeVBDvNuNp9sUmDysj3SuP55VvlY6ihwzi+dK4GZrzyHhB
 vs+zI87xo1CT0/K/4uzINJ/LomPoTkrmez2Uywpq7N0o/p4dg7mzKc+K2lPPaQaoZ3Af
 ZBinPQgI2GO3LZpDR0pIXJ4j0SLRBvqlP5p+hzGfsww7/dkDmsOfDk4SER3Cwmo8quKm
 O/0bB8KEOxzJHKuEIkhKbbf3KrR0IS9l3INg93fWjPy0m7xWHAaVdTGn/tBkQ4evBjr5
 Ph46n6bn27JOFtHTNdkCeayU/hV8M7luA5kUqxXwfLle7NVO+iZ74sdqOTDMo+Ky0ozv
 NjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810193; x=1794414993;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xvpV7huPZOlel7iSSvUNNhoLboYoj8TboGt9Ixyle+o=;
 b=cMUE4ZMn68WmoIB9UwswcJHRGr6GsaZApUMYKh05M/snJZsg6zFvZ23juQYlat9F3J
 7yYGZayOEr/l634Tuh39DKnyi0bHsvCblaFlP6ugCVchgEqePRUiKPzVRq5sHoHgg9yx
 cKI8GfH5Vs3GRzOEBTwHV1mTguQmTRw/dQexUCjrQkW8tthG49ou+zukZziYUyiU3cmY
 /fGoyA/0Ru0f04DbTWc7/jwvEe70dh67yQbEmU3KXZzinHSqeRMxzwjVmg+QLbs1c7GC
 L5oFEA6qpe47Oa/ZzQ3RGqAo/56m5U936zjWQZKJhZd9Oe3IqPw9ffQHlZppPLUSxHuh
 8YgA==
X-Forwarded-Encrypted: i=1;
 AKwUvBySw5SfHRf9Y32JI5H4spZK0Rq66tG146kIEQ0iFNmUnc/shravTQ/Jq7eYIwKg7wmY0QTxktxZQtM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9K4w4O3litUjyiCd/49BjdPcEt+sw8v6gR1mzoCQ/MV3wNfNGw
 wKKZ75jv1sSBZbL9dSyf5uhjg5AzhOaPh3X3XbwSlWD5DeP1F8OhiD8bF55Mm0u5QAvF65mFT53
 Pt29UOckSrvqFlnEpTxPw1qt7sYoLUNiLuHJErjCt2+jTimIQZErmt2fC+SjxoTFGr1uq1t4=
X-Gm-Gg: AYBFou0GwLORLtj8Yvzc3XwuFcc7/7Vmb/n497aIAKQ9/tPtykQJqoeBYFOAKB5CAd4
 gZ+xhkbSnCwjiGsozUWQQpD3Pu1TIKNI5R1x2LlCxYVin0oY2R/UuqKsh7Wm7/K3tIo3cRIdrTA
 R3beSmCoqi00ynO5iK+3RJZfh5vvEzhvPq+fA089sevUO8HfSO/IIgwidT8d3a5ALm87Wbu55Hf
 hwq3egDNarPfzg53AmigB9xs4vYf5LY8Uz4rgYmwfeSVBILdoiPyQdrFkz+JCwYbrYzpwIww/uC
 XBe5Rmzr2pDL04mbkJk01ZLq50dP+eV2DdbJj1fghpH3fP717L2YEW/BQCfTAhmNxys1OzshlA/
 DH2oGgLL1Z8LgatyULLri3swh2KrejT5dImlG2ATjOl+BdBcq4PIP09P+xnNgcxe6n8D8i2O4zh
 ItFMKmJM3esXrDCeDJl7uFtqBuBv+KcbesYvNYSTJ9LdPzDeTho17w+dPePGBRmw==
X-Received: by 2002:a05:620a:8907:b0:939:6de6:9518 with SMTP id
 af79cd13be357-944216ed973mr2970783885a.47.1793810193180; 
 Wed, 04 Nov 2026 08:36:33 -0800 (PST)
X-Received: by 2002:a05:620a:8907:b0:939:6de6:9518 with SMTP id
 af79cd13be357-944216ed973mr2970777785a.47.1793810192681; 
 Wed, 04 Nov 2026 08:36:32 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3acdc6bed64sm5267191fa.7.2026.11.04.08.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:36:31 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 18:36:07 +0200
Subject: [PATCH 3/7] drm/msm: check UBWC framebuffers against their layout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-ubwc-format-docs-v1-3-389044012b4e@oss.qualcomm.com>
References: <20261104-ubwc-format-docs-v1-0-389044012b4e@oss.qualcomm.com>
In-Reply-To: <20261104-ubwc-format-docs-v1-0-389044012b4e@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Bryan O'Donoghue <bod@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq618AE2Tl00L/YEMEv4dxHfGBuWN+CB2e3ikuQ
 fxCGeK05k2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCautfAAAKCRCLPIo+Aiko
 1ZbGCACaqv83336QYPjXUNoQwg1h/nFN+er0jSNcAhRx0s4e+WhQ4CzrIeqAWFtjDW8qffyGZ02
 WcJZGlgtO3VFacOiOh2FvGRAqQD3hC81B3RCr3eytSr8iiClpa1FdxLKRsVCf6NOpWepX3AYs0X
 EK8Hk0P25tnrX6GqMSgvnT9GITrMrWb8+xeP7iJ+ahScIHeWR61RwSkw5ubkev2DLlVAnzvWqzw
 yDmGVCtKGJucVDgAaIrg1HUYE+tbIfSMcHsIA50UzgH+CB9F1OpxqmaYQbB1ynGIqVReY7OFrR1
 Jx1if8K+frhXX184L5mOE4GVxGcg+27mcchUFj1F8YSfgrV9
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfX81KizXxNo4af
 kY7/hiUFYugJhfakfXjbRVkmB7WT9YwdGlIsB6drO8m4d7/XMYZezChhg6aA05+Kk7P1Wh8kwEL
 b3bsRlp+O+n2IKWXMj44aT0UjI8xdwCeFsM8gBTIxbSEavVPsPJ25+shhMdOJv7U7ss/Aw1M8hI
 UquCuvQJbcr/EjIoS1IdAQk/j05OYUGkn7OEXQeoLXzyy3rcUlo3gJQ/LM8WWKJ/xrztYa/3211
 puoelOHkzuz6/dlLEn2ARDooJwTzV5tMIhsjeLeYLqOUhRNUYVsQ7pLqDS7fwz1E397qJvYUMVX
 5xHIECLrgcfGnDvkxomozxQIOoMIWJcFXkwQEpL4XW8s29dAlnt2gR5cZKsmYTvMY7+CmsKwvUy
 AJUGQR9PftQ3wdG3bWP24e9ktcA1w9mfVF0DezZ9eArzm3RRbKIKbCArBkMuTqgxepT4GQ4pAGd
 OesWdmXM8TLvw9oUMIA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfX/ApPZuicVIJs
 /o6ChaAuhwr6khn94OTWRl10iwMesukNmnA3KGd4y5rzqE9/14+Zy/y8D+WAu+K8L1A67/+hAIv
 i60VnZKgVHWyhZ4yMYcPiUZY+2uSGO8=
X-Proofpoint-GUID: 92EMk4ptJ4guBRZTgH81YLOJUY8qmJbD
X-Proofpoint-ORIG-GUID: 92EMk4ptJ4guBRZTgH81YLOJUY8qmJbD
X-Authority-Analysis: v=2.4 cv=futJ914f c=1 sm=1 tr=0 ts=6aeb5f12 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=gedFiD_-BdM4RCKrvjUA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040066
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

