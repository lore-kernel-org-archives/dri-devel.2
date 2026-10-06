Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509CDCA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 09:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E9BF10E326;
	Tue,  6 Oct 2026 09:50:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dXaicJjl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fpGtZfRw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E2D310E31B
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 09:50:41 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6969QlNJ1447186
 for <dri-devel@lists.freedesktop.org>; Tue, 6 Oct 2026 09:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jS6d1VPN5H+Nib8Nvayq3z8IMlZlt6USSmNHvwcP2Lc=; b=dXaicJjldr2XiWNK
 qDfXDZ46dH1ZHuY06qcM1OaASYRIwMrCacE4jK2IHr3TMIYqdOAsLV6eWfUV1oy0
 wJQwVNuoQ2fGMeHngAdgX1avYFRHgI0fJPmiQS4N9lIcWZHOgkAfG4IeDNo6Qpg6
 VgTs4iJvko8u+/Ss9gf/ANfpGlm4W3mfuFxIIstk5hiONH4JV564ai6RWqbNWP3D
 FWFYEMe9Qxe39eOIuY874by8M8RVS1d5wLDFo9Pl7Ub6gtRCHL8CRYlLmMXi9j5+
 8nEfVdMoP4i5Rioee5Pza/+B3ZAmQ5bRdysdQoSV9uhsZOaD+NvLKVU+PGIP7l/S
 gM2UuA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xc502tp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 09:50:40 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8886059d3faso5651006b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 02:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791280240; x=1791885040;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jS6d1VPN5H+Nib8Nvayq3z8IMlZlt6USSmNHvwcP2Lc=;
 b=fpGtZfRwst9qcDUVJKJ+HGBATC/GZ0UDFJgcy1Vo/IcfpSUiPiHWm2CqpGXKAdvnRs
 dm2mmKPSgkvI8OZ5xPBB2PnmDAOSQaZ0Dr807uZIHKGMODZvrpXoybwXVA9O2QtcnGwt
 VqlA8sSrzna8DW4GE2/fnx5vmlMHs5R2Oaff9vNGWqPIW7NynWNu2uRtEOOpbjAKr+RZ
 1q8mZruCiWG5rj9xfvDu2LdteYMYqeBCwGFfSsRNBwIbZIDiLCJCHa+2mTzrCD6/zBii
 adwuZsYr8OIB5NZFWcY75gclth8xTsXS1pgIlqdTMryUJCHFEbTLVStJt38smziaosx3
 70iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791280240; x=1791885040;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jS6d1VPN5H+Nib8Nvayq3z8IMlZlt6USSmNHvwcP2Lc=;
 b=LI7l1b4MJh+h9B64bkEvhtEF1K0HbcCgNsJFlTRUYcINiB6NfFFp570tq/jUXalFVm
 58w/I9SXw0Q1faEqJldVephphwJCYxgruwTfF1ZeDkjcPi6MwNVqe+SrYJ3q/q1KqaM4
 Yx38VIy4y81wnNIW/qUOsC6BtxM0o/sl+zgEXHjuUSkolDRFBlqnjl70oCQawu9HmYQS
 uz3XjybOjUeZCin5BENsEVi8sXUrfsuxUO+2FTZcJpio/hiprDZZDE4Ol6vZ1wxmR5kO
 82zaj3YUuuPLAf9oFaqro0V86gU2PkZbqCq0uLFxXF+ClUvXJyOYyclCa8vqPLx7PuyD
 vdFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvn2o0gYVf7G+EqpgPmVQM6NyBpACAxCA15v71QXHUTJmH+r2RjSl+ijjaMLDN3Hv0M4wsCaRgujU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kE8RGk6y+1cuintkZEbPJtV13FHIceA/2MyOVwhLyuQdmyFEAd
 ugZPBLt75Pcdq0t8BAmPpZr6YnCwKPOv4KYpUBb9/cAXJN9sLYtTwjwZMQlEHMy68XM4H2fQHWh
 UF3RtiSX92jKlGlIUDdtd/+2B+rXRgTiJL9mZds0rKlaSXGP2TtHfWAaSDMzOc+LoIZB9wuM=
X-Gm-Gg: AYBFou2hiZmjPaloDZ3LwL1DT5vS/AGbp9LlCs12hPeLsvm/3zeS7jEBUZfIsB71/ln
 zfOgodQ+yLcgDn9Q4j7+h7RkZboJ4pKuv1CdbP4pPdjEyxlqr+S49Ip+Vx4ORt57FTI3E4qROVx
 q3+4acZ/IV2xmqRZMTtF40ncXQqpD2W4qO4P/dvu8B+Pk1M2btAq+3CZfw+JwdQMqa9Ojw0QMor
 jgY1knjoV0qeH9X2tIge7vvMivcoMX3i8aIC65uX+KJChbrH9QQsdMc7zDWzrqSyYBV3qzGFnjo
 J6DAJhLpDUH1HasCATYaaxCTn4bGvgvXD1R2VTbSH5Y198vmP7t2vJJpvEFXq9WpxIAPAw0WjEs
 foRFHl02dhLiqW+A1MOzJ2QjW3fKT6GUFrAB3LZuNWfhM8RlTk/3gnck/8/sWz2/b
X-Received: by 2002:a05:6a00:2e07:b0:886:9eb2:a9aa with SMTP id
 d2e1a72fcca58-890dbb8c48emr757976b3a.6.1791280240279; 
 Tue, 06 Oct 2026 02:50:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e07:b0:886:9eb2:a9aa with SMTP id
 d2e1a72fcca58-890dbb8c48emr757941b3a.6.1791280239785; 
 Tue, 06 Oct 2026 02:50:39 -0700 (PDT)
Received: from hu-ggarmidi-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-890acde961asm535523b3a.61.2026.10.06.02.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 02:50:39 -0700 (PDT)
From: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
Date: Tue, 06 Oct 2026 02:50:30 -0700
Subject: [PATCH 4/5] drm/panel-edp: Add Sharp LQ138P1JX61 (Surface Laptop
 8th Ed.)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-mahua-surface-laptop-v1-4-406fc042162a@oss.qualcomm.com>
References: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
In-Reply-To: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791280230; l=2528;
 i=gopikrishna.garmidi@oss.qualcomm.com; s=20260102;
 h=from:subject:message-id; bh=T0lN/DapWPxHvaDW4pJnUs2DcqEFLyYI8O4ONz2Onzo=;
 b=b/ojm2NGZbp0Hihaqkh+5mmrSWAdCRDQ5tpvVjjwOccVEs+VMtJ4T+47nPUbfO9aodCOtSSnw
 g6lpFt2gUT6BTcag8rVkDL0D1ZjjjY1yknJ4QpsQwHYj32yQf4Gxryo
X-Developer-Key: i=gopikrishna.garmidi@oss.qualcomm.com; a=ed25519;
 pk=TkSjNEhrfsj90i3wkABTZtAjLNr2cfYsujaTvyOIDsE=
X-Authority-Analysis: v=2.4 cv=X5THu2Te c=1 sm=1 tr=0 ts=6ac4c470 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=IFSe4OfV7_kOeEc-bZMA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzOSBTYWx0ZWRfX1/aK3mnREGfu
 dE5xw9eyEemtb0z5EviY0ZghiEXcBLzUmEcqGVI6YnmMWs3XY55KcdnJFjF5lhSGY8P1pMqy5n6
 6sSZqQIPQ8vYwpgX0DcydnQc1Ow7vgw=
X-Proofpoint-GUID: mnvRo_n75BVq4F1lDsFzjH4fKJewpv5I
X-Proofpoint-ORIG-GUID: mnvRo_n75BVq4F1lDsFzjH4fKJewpv5I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzOSBTYWx0ZWRfX1aumbMgWEcid
 cTVLTMjkflbQch3ec00tA62T+GcbAYBnCZPQzP/A0lk4YuZoz/UOEVR0styxxIFp9dmyTqh5KpK
 a10Rl7EpcpA3CP1Op8O83HmrjyuKEMBCCLNeKmqUzZqEB4j5wVui3X8GGobrW2740Bkvole4a0E
 ofdBmomOXGfHzlcHpFgsBRZvrrFIWG9OBgAF6oRHmJ4KSsGZqf4M/t/NMST4sAMkSRc4G52hYXA
 J3+28G6bvyi/MTTbNnfceDERv4btfyjDOzB3qPC5YTHFos3CIB474JAd41Ku2Eieq1e04lFTz26
 gUEzwvforqe0V/YRhs1RW0YgDtRvOo4ZZf3u6kskhnzOr6LvkgZxMtuxnH6gB09uZ2Jtd5ahleo
 jsb/j6oH5M/M6+h5UBwol7vTKS5pF8+5lTJICGjCfjdMy7lSFIF/YqQwBajzemF5vkmAfDD/F7c
 6LoO74hFu1aZcy8tXXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060039
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

The internal eDP panel of the Microsoft Surface Laptop 13.8" 8th Edition
is not in edp_panels[], so panel-edp falls back to conservative timings.

EDID, read over the panel's DP AUX DDC bus:

  00 ff ff ff ff ff ff 00 4d 10 72 15 a1 31 05 54
  31 23 01 04 b5 1d 13 78 03 7d 77 ad 50 46 ad 26
  0f 50 53 00 00 00 01 01 01 01 01 01 01 01 01 01
  01 01 01 01 01 01 60 b6 00 a0 90 00 2b 60 30 20
  3a 00 23 c2 10 00 00 18 60 b6 00 a0 90 00 56 66
  30 20 3a 00 23 c2 10 00 00 18 00 00 00 fd 00 18
  78 be be 2f 01 00 00 00 00 00 00 00 00 00 00 fc
  00 4c 51 31 33 38 50 31 4a 58 36 31 0a 20 01 4e

  02 03 0f 00 e3 05 80 00 e6 06 05 01 73 6a 0b 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 aa

  Manufacturer: SHP
  Model: 0x1572
  Made in: week 49 of 2025
  Display Product Name: 'LQ138P1JX61'
  DTD 1: 2304x1536 120.000329 Hz 3:2 (291 mm x 194 mm)
  DTD 2: 2304x1536  60.000164 Hz 3:2 (291 mm x 194 mm)

No datasheet is available, so use delay_200_500_e200: it keeps the
200 ms enable delay of the conservative fallback, but uses the 500 ms
unprepare delay of the real panels in the table. This matches the entry
for the closely related Sharp LQ120P1JX51 (SHP 0x15a7).

Assisted-by: LLM
Signed-off-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 5d7d696b7725..3d002d75ad73 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2198,6 +2198,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &delay_80_500_e50, "LQ140M1JW46"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x153a, &delay_200_500_e50, "LQ140T1JH01"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x154c, &delay_200_500_p2e100, "LQ116M1JW10"),
+	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1572, &delay_200_500_e200, "LQ138P1JX61"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x158f, &delay_200_500_p2e100, "LQ134Z1"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1593, &delay_200_500_p2e100, "LQ134N1"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x15a7, &delay_200_500_e200, "LQ120P1JX51"),

-- 
2.34.1

