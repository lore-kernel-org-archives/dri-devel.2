Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFD0C5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6618A10E202;
	Mon, 10 Aug 2026 14:51:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RVQ1ypgp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TxBCnS/3";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EFD610E202
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:51:56 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ACj0iF1671296
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gTJShaQ8ly4nCUgfAoU7CUotG9qknpirLcGSxiDk/hs=; b=RVQ1ypgp1BFX3scU
 OT8O+riaE4uKn+q9KFborw84tavN8QSApDN8x2eRpiIOghrkb2ntcXm+05j69IcK
 8rJv7zuF20n5XQpIvlu7SXMHz+3Yz2OipjwZVCGD4QIC61fWtcDmY9hwwz0oX/El
 UsvHaZ0nV6GGhgGz92PMrUzyATC87tcqln32NwrwP4zt/gqHDJN4d3PgtzlO/9eY
 LkTExkVvxFBGHi8OB5hpxq4KbPb3hQI2Ixjny8yme8MU7U0Wpdhlw4HD3cei3O/g
 8pUDUCm/XtnNqdQIwABalCd0Bsc543e4yy5OQuNmWYfK8gI0AA9GknCy39NYMjjr
 iQa4sA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy8v2a517-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:51:54 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51a8db414c7so28121811cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 07:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786373514; x=1786978314;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gTJShaQ8ly4nCUgfAoU7CUotG9qknpirLcGSxiDk/hs=;
 b=TxBCnS/3hPwj/n6LvK7m4CFk8Snt+pOvGyhYd0fMIDJPGKG0KRyWBau1xkk52B0Ybf
 wyvufW7HYEp6Kw2WJUl0rsdqgUNWmPJSzLEnoKOyJj19N5JMtJ0QTaaQV+9tGBrSg8+6
 3ewRVw4nMH+/x2VBi/y2GHqrZx/Lj/eWsKDAm516KzUBrf5y7uE/Qp3Whq7bqKVyor4g
 wrhM37fPE4mKBhbsqZA++q1nRjv0MAlsQoFVICA6eCnsCwgUmSYUbKXtwMgQmqgZQ7WN
 DohTyVhyNOR3uRPEhFMyavkQplbimj25gSF8BqTwh3r6+2RcqviUJW0SHJiqcJLw98mu
 LQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786373514; x=1786978314;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gTJShaQ8ly4nCUgfAoU7CUotG9qknpirLcGSxiDk/hs=;
 b=apLU7EU+qhseQ1rjj/ueF9bIg0IHDNxXyfvyBiVhVmnitoq3B8/s5yu0UCB7m/fjW1
 mMyeNS7UVM8lRam7BJxdDOcz2APQRFkPofcUCRv+97iiHyPpw/YxAN6SknTQno5XVk75
 A0RcHjbf+iQHBmchaUyEof7F1PxrreLzHXSRV155Sw9NIgi4OFZvGszpDwFzgoB0R3AQ
 xMCFTcUiNkZuWlwpun4+F0SGR/FNDwmmlohgwcPfnHpLdOX/zfcDj8vFWWZici7CyhTt
 mMjZPnHALuPI0x4zzKh4jJFX17vyjg4uL6Uei2CWlIXNJ/44q3eqKTVQx7VC8GQBMUKs
 BJHw==
X-Gm-Message-State: AOJu0YxpTc/6Z+feHcVKUsD9by97tyquKj8Igv+0267hTk6SfwDts1wu
 vYQEXLy4GUc06COqcjb6wfjB1mDftynKbe9rRd1DgVxNFTO21GMRU5JbKH1lLAfucNR+kjOZPL4
 sx+1DjrikSyLPGn3XycNMY39KTW41PyMN7wUSqGXymxZXuzJ1hQOBjHPVeSqDdcvyc94Rs2Vs74
 f0Onw=
X-Gm-Gg: AR+sD115VXU466T2adSo35d0BigugX09WCbyuAK//aNjHWwcYwauFj21JT5hM+/D/Il
 7UoizLY7rx08LwaDmUtkTc5cK+j86h2eoAVAMBs0M3ulOeYdvFE/D3SssVuFzw4ehRslIuRSsmb
 uBzksyxK6noMCZ6MLIcocRMQ2SbMUWkD+JIwCHKqNUgyB9W+yUtWIhcD7Duhb5TsvNLdHcMfxbm
 hC0euC/NnpBSlXOL78EqCu62BuhZP/S9OuXIHbH31LORp4+shzjvS6AtahIB+GoruTj27xsPmmA
 RqxjqVGYlnd0QkWwk+B4MSv0msXad3NICpenFMg7zaDYA8iEWIiqbEsGAHsNDQoyFeMg1nqUg8w
 YZXVK0AYYJLraShG0y2oknVjolK0F21nHyoXV0E1cnuN/M77QVKwvzg/rvqhT7TuG9C3d3+vLBa
 csTs25N8Du3fH0rQ==
X-Received: by 2002:a05:622a:58c4:b0:51c:1ff:2512 with SMTP id
 d75a77b69052e-52d20a50c50mr250088811cf.33.1786373514104; 
 Mon, 10 Aug 2026 07:51:54 -0700 (PDT)
X-Received: by 2002:a05:622a:58c4:b0:51c:1ff:2512 with SMTP id
 d75a77b69052e-52d20a50c50mr250088001cf.33.1786373513541; 
 Mon, 10 Aug 2026 07:51:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39fddd6a796sm22489661fa.36.2026.08.10.07.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 07:51:52 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 17:51:47 +0300
Subject: [PATCH 2/4] drm/imx: ipuv3-plane: add the pixel blend mode
 property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-imx53-fix-hdmi-v1-2-fff9b1b17f25@oss.qualcomm.com>
References: <20260810-imx53-fix-hdmi-v1-0-fff9b1b17f25@oss.qualcomm.com>
In-Reply-To: <20260810-imx53-fix-hdmi-v1-0-fff9b1b17f25@oss.qualcomm.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4122;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=4QNydV7spsaEfA/iL4Q6QeiitR6lJ+BPeYG4Ij6Ga+0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqeeWDajN8HOrxXriFLb5kPXKQed7DBCYPlTJEJ
 6eIFR+YSEGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCannlgwAKCRCLPIo+Aiko
 1WDVCACsjxkK997hWtj+NXAjCYxxBz2W6w7JaFqnwMTnQ/6a7fuwFDQ/RDQt/KSf0OCi2oUXplT
 o0PnrMFfRFPX25OQ9sxayIMVGb6M6261clcl9AQbWCBRf6vXz36soQ85Ip9v0Gxct33+c7IQ3Bd
 T4QLf6tDW4GDzwdFAlizX/BwMnM1k/7zjHyFa2W/MdTkm4TNJbmRzRzeO+V0b3GtLikKxebyiQZ
 t9GIeGES4E+xy3S7VSDpw0F9/ZVmEKhBA8HRTYl3QBmR6hQEsVakMphFpuqW1Nl5SJd3CphA32T
 V94et7o/IiGBQPQYmnDf0RZBiz4tmOooj6n8LGfkK56WHvkn
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=S9PpBosP c=1 sm=1 tr=0 ts=6a79e58a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=5XQbaQfSCqgvYuQxrhgA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: Nlnyxk971N9d21i5f-KRussLkNiogvT1
X-Proofpoint-GUID: Nlnyxk971N9d21i5f-KRussLkNiogvT1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyOCBTYWx0ZWRfX+t6uVudaHQ6G
 ujCeb17Hj0ZM4dDfjQ1V5Pvu0v5i1CaKISyTYPPwBJf5kqAMftTuvcvi39A/4P/6gNEZTkg/h7h
 wj5zS6PwfNRto+GHBFTgaCeFJKWRIfBw49E/EyEsjBGnqZj5eNHi71ywLnLKKvz7jdeeb06ETLF
 2igZ/ZTUR5MmfwGOETPGfF+Ixj2UqE/DK7015Lu+mTahYuop+Jxm3hswJtFmCpf/aAXnaDe4lvw
 xqA+iRRQPBlH34L1U2aZ2cnelpxy78mBTI1roVzXFQmtSvHpK2zQxmlCJNdMQ3Vn3/+P3uQPZXI
 DIpAeOahX+dj3RVEHLZIEm46rfMDflUPYk7MdxvEPz2EYEgMZFTcUpiIIAB5j7Ad+dAL065dpt5
 eXbOWopiyczWBcXSdTrNW5Vmw3hFq9Svy67JCz3m+zf8mERiMNm5e5Zm8Q/TzZ5L1C6CcOc4zxT
 2bDaZPMPzL5U75I9KvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyOCBTYWx0ZWRfX+f//0N2BJ0fb
 h3HtLRGiZTnmefBegB+g4FFXZCdSUMhKX1jgKhuAJHptTo+zWwtliksgOYfsXUBZCp2GizDaE/9
 FPy2MYJ3GIf9uF63qdImbVLBz3+Yd+k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100128
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

All three IPUv3 planes advertise formats with an alpha channel, but none
of them ever created the "pixel blend mode" property, so userspace has no
way to learn how that alpha is interpreted. drm_mode_config_validate()
points this out once per plane at every boot:

  WARNING: drivers/gpu/drm/drm_mode_config.c:872 at drm_mode_config_validate
  [PLANE:35:plane-0] pixel format with alpha exposed but blend mode not setup

The DP blends the foreground over the background as
fg * alpha + bg * (1 - alpha), i.e. it consumes coverage alpha and has no
premultiplied mode. Planes that are not part of a DP flow have nothing to
blend against and ignore alpha entirely.

Create the property accordingly: PIXEL_NONE and COVERAGE for the DP
planes, PIXEL_NONE alone for the rest, and honour the resulting blend
mode when deciding between global and per-pixel alpha.
__drm_atomic_helper_plane_reset() defaults pixel_blend_mode to
PREMULTI unconditionally, so override it in the driver reset.

Fixes: e6245fc78b65 ("imx-drm: ipuv3-plane: allow local alpha in ipu_plane_mode_set()")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c | 43 +++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
index a0fd39eebbbc..bde5892264f4 100644
--- a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
+++ b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
@@ -291,8 +291,32 @@ void ipu_plane_disable_deferred(struct drm_plane *plane)
 	}
 }
 
+static unsigned int ipu_plane_blend_modes(int dp_flow)
+{
+	if (dp_flow == IPU_DP_FLOW_SYNC_BG || dp_flow == IPU_DP_FLOW_SYNC_FG)
+		return BIT(DRM_MODE_BLEND_PIXEL_NONE) |
+		       BIT(DRM_MODE_BLEND_COVERAGE);
+
+	return BIT(DRM_MODE_BLEND_PIXEL_NONE);
+}
+
+static unsigned int ipu_plane_default_blend_mode(int dp_flow)
+{
+	if (dp_flow == IPU_DP_FLOW_SYNC_BG || dp_flow == IPU_DP_FLOW_SYNC_FG)
+		return DRM_MODE_BLEND_COVERAGE;
+
+	return DRM_MODE_BLEND_PIXEL_NONE;
+}
+
+static bool ipu_plane_use_pixel_alpha(struct drm_plane_state *state)
+{
+	return state->fb->format->has_alpha &&
+	       state->pixel_blend_mode != DRM_MODE_BLEND_PIXEL_NONE;
+}
+
 static void ipu_plane_state_reset(struct drm_plane *plane)
 {
+	struct ipu_plane *ipu_plane = to_ipu_plane(plane);
 	struct ipu_plane_state *ipu_state;
 
 	if (plane->state) {
@@ -304,8 +328,12 @@ static void ipu_plane_state_reset(struct drm_plane *plane)
 
 	ipu_state = kzalloc_obj(*ipu_state);
 
-	if (ipu_state)
+	if (ipu_state) {
 		__drm_atomic_helper_plane_reset(plane, &ipu_state->base);
+		/* the helper defaults to premultiplied, which the DP lacks */
+		ipu_state->base.pixel_blend_mode =
+			ipu_plane_default_blend_mode(ipu_plane->dp_flow);
+	}
 }
 
 static struct drm_plane_state *
@@ -593,8 +621,8 @@ static void ipu_plane_atomic_update(struct drm_plane *plane,
 	case IPU_DP_FLOW_SYNC_BG:
 		if (new_state->normalized_zpos == 1) {
 			ipu_dp_set_global_alpha(ipu_plane->dp,
-						!fb->format->has_alpha, 0xff,
-						true);
+						!ipu_plane_use_pixel_alpha(new_state),
+						0xff, true);
 		} else {
 			ipu_dp_set_global_alpha(ipu_plane->dp, true, 0, true);
 		}
@@ -602,8 +630,8 @@ static void ipu_plane_atomic_update(struct drm_plane *plane,
 	case IPU_DP_FLOW_SYNC_FG:
 		if (new_state->normalized_zpos == 1) {
 			ipu_dp_set_global_alpha(ipu_plane->dp,
-						!fb->format->has_alpha, 0xff,
-						false);
+						!ipu_plane_use_pixel_alpha(new_state),
+						0xff, false);
 		}
 		break;
 	}
@@ -930,6 +958,11 @@ struct ipu_plane *ipu_plane_init(struct drm_device *dev, struct ipu_soc *ipu,
 	if (ret)
 		return ERR_PTR(ret);
 
+	ret = drm_plane_create_blend_mode_property(&ipu_plane->base,
+						   ipu_plane_blend_modes(dp));
+	if (ret)
+		return ERR_PTR(ret);
+
 	ret = drm_plane_create_color_properties(&ipu_plane->base,
 			BIT(DRM_COLOR_YCBCR_BT601) |
 			BIT(DRM_COLOR_YCBCR_BT709),

-- 
2.47.3

