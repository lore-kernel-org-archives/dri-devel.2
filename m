Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D0CC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 05:25:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A82B610E0EE;
	Fri, 14 Aug 2026 05:25:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eDqkPxan";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KwQkKi9L";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16CB510E0EE
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 05:25:30 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E4QsDc594248
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 05:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UtRAHnir7bPWxS4ms70wOZ+2NIR1lDRXxWBVrJgXdhM=; b=eDqkPxanpsCjQw53
 jmwBmY1gU29szTVUTNkaQ3yyCjss/iM66nfcnqMs8rfTdAah3mdqV8D0uIVtTU/f
 PcZ+xvKJNmzhwvM9YCdyDivzK7dGxAY3XcGAY59LQGMO5y+brOkiSkeA85skW54W
 6ZA0lmxjAAvYiMDRHhKmdHyOE6cUB4nwA4I/A+R1uF/0b9uibgRwA5Wg39qZRwpx
 xi7Y7fkMX0hGivTH5YyysZHyK/uNYbXZHuucSeI9DLjJ8C+/S7ib44jwAaWDm1Hy
 2Eg9xqiqPZ5t8VvpG0Rj67bWnvXdcG1hG4+kpeGkoI2l8SmUlbfuanxf2qsTWoRM
 zGNtaw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1gy4tsek-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 05:25:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cc4c126cf0so1177115ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 22:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786685129; x=1787289929;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UtRAHnir7bPWxS4ms70wOZ+2NIR1lDRXxWBVrJgXdhM=;
 b=KwQkKi9Lieh9GwBtV6EGIX4kzImXyb2EWUWbHFy5b8dTHVLpc7zBNfZkhteSiQRb0n
 ToSxJwy9x8hYzVY35Sk9xWNKzqabFmed3nC3xk2DDl5DU0iNKlQ1HPtQCaxou72eCEUk
 q/7iEc+QyNUvADmT8m7GzJeoDwZvkVnK1z84nusNyvt+L6ru4iosF54ppO1d8fx7BloC
 Yb4f8FW/lWuGL1E/dtxEkrwl4D/Id5wYzVHvcpkoaJvyZblP0Y+qzwz0sVXr0rTLThRs
 dT38y9v13RSjWwIJZ1DO2/OugKoau8OqyDEmVWiTm8r66/LHMRbyC3oRFk1LyQNvVzy/
 YPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786685129; x=1787289929;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UtRAHnir7bPWxS4ms70wOZ+2NIR1lDRXxWBVrJgXdhM=;
 b=Is88UfrtnoVTFtHnsKZndSg8MNLADe4AA5uey99YA+GzlKWh2juPondnax/T7muO9I
 npfaD0/QYJy1I3OAx8FVAHlaSKe48EH85DnNgGLjR+q2baP02U/Wv1/56BgSE4HJ9HaZ
 Qrvt7e0fxCmLNBGIyCSEY7G/riUZbDd8m1U+UjY6ZUJTZnfdFKQ06J9fIcR1j1CJ+vUw
 zt2552+HpSEX0HUE/UkEuoHTClQE62b8kdplEs9cw9DN+EbpaLO0Io5PbGT+Yhp0j0Qt
 qnJa8ey+CZJr4TvdKsA0f0qY2HAvMBED96NYiP22sNNxwhekyNvte5SUmkdq0dt4ZOFL
 NVrg==
X-Gm-Message-State: AOJu0YygoO508OP4IkpcbUYJ0q9EAaHB2fPihu1Vh5VZpS0ZcSAWs3Xq
 YAIWl9+0T89FQeXpksjTNevilzlXdOKynr0WSwwKl6BXpGajezeoDzrCzvYkCY6uaYNlvUWbBAw
 5SZQ64NxdzLtnQeyvqg91UZcwupSsvJDvkWdmrOYC5e39RKf7AKXzN8jHzDkNkr+/dMoTuPg=
X-Gm-Gg: AR+sD12szfzxXjYQfLvS1cgs1MFDrfIXMIMSlO6tz0l3pGU2U+Owex6y1IfK+dpx+eM
 CDZvzd3z1jQkEiew8MJonae0KfolMRdAkDQs6wgfME7ztwj7FOdVNpHfdvLnpFttx4L9QqWiyiz
 GuWiNRxr+ZVwP2NXDAmE5cFVd0kvNcBZVBNwqv8BGnOWcsznyNTSY5w8PZoE2AJI6EUcc+sBqdm
 ZIcB54U5jjPX662wNdlFTJnd6ZGouxBJadkhFTfw8O9mP+PdN8wPVYZeenBdmtLZCDi5CkPyAbM
 hUpsqzTxPQiviHnXNbtjpQzEygBrw+MIVD8z+2lP7/kC/ee0tYSXeZPTlRZg1OdVlUtDirIxgUv
 uODCkGw1KBiWy+LWyg550sgztB5FoYxFSdxCK1IWeW1fn7ltmHAhdbfiNNCK1RrIeN9hAY9odRE
 Wx1KYuAmlw73LrHdQUjw57
X-Received: by 2002:a17:903:1b2b:b0:2ca:de3:15eb with SMTP id
 d9443c01a7336-2d3b0739429mr26779925ad.0.1786685128682; 
 Thu, 13 Aug 2026 22:25:28 -0700 (PDT)
X-Received: by 2002:a17:903:1b2b:b0:2ca:de3:15eb with SMTP id
 d9443c01a7336-2d3b0739429mr26779535ad.0.1786685128175; 
 Thu, 13 Aug 2026 22:25:28 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3aeb2a0b4sm4545835ad.53.2026.08.13.22.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 22:25:27 -0700 (PDT)
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 10:55:13 +0530
Subject: [PATCH v3 1/2] dt-bindings: display: simple: Add boe,dv215fhm-r01
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-b4-lvds-panel-doc-v3-1-1ad152a4d3ec@oss.qualcomm.com>
References: <20260814-b4-lvds-panel-doc-v3-0-1ad152a4d3ec@oss.qualcomm.com>
In-Reply-To: <20260814-b4-lvds-panel-doc-v3-0-1ad152a4d3ec@oss.qualcomm.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Liu Ying <victor.liu@nxp.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786685115; l=1225;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=pazSav7RKprkmz1Mmx/rVxatkvi1ozlV9Wr4tjOqULE=;
 b=J7tKtEj3LU4J3KwwUVyJBM0ZqGTKrMmb9CsTLDj89MYijHZ8VrpF6CwivSmyngqbjzRT78nwO
 49tX9g52MOICcA49rluGoZ6BU+xOSprp8QbaW9UAnSc82e0NJz8U90d
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Proofpoint-ORIG-GUID: EJzEdlIz4p0uOtpI0zYIdSFD51BWAb09
X-Authority-Analysis: v=2.4 cv=ZYAt8MVA c=1 sm=1 tr=0 ts=6a7ea6c9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=fMfOcokNL7symIEKlBMA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDAzOSBTYWx0ZWRfXwPTFUN3uW5o4
 yOiSjNumhCo5baE4VZHLBHIjoMNHE5jOGpxjkBuYvQy6VhPaVWkhGADrtTftP5eR+gbbj4uXfWz
 jW3dxmXr7mLw84acJGrJN3RNRpFZ0oM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDAzOSBTYWx0ZWRfX3T4u1rzf56VS
 CBGQPV534HxJ5h2tZ5lc4EMkr1iLVTlaI/qO98rWMLJ8+IDat/0hftnTN8e9dyah13PmADo/GhY
 egO0GdNj5xYeAD649u8ytbTaNhZdD3+j0evDVqdcSQovXjQnGWHv3fhdTLIEvMCJMyMi6geXcg0
 L9qMgpu62tIS0R0VPxt8es3bsT8LAdGEfgeYbwQmMjYWGRcLoAVxY1RKn5OxmgiqpmL4PXftQd/
 0uJtWUO4eiNcUYTx4XnY9E3a5bZ56kF6QUiw5m6SgTx3c8cDhsD7Y0qtPbkKwG61sPb7DxmTSv3
 oN0retyj2o1JU8bo4+emcwxcNVjrf/qpyUHFuaQONkc+RoqascT8ieSBiKCKiU81fULMw4cadNq
 YO+dYVbysLeSI037eTKdXA/WeXtgNcRLEr8MsjWiVJl8Njy8MQsv6mTIdA+07m4qGacgUNZxWJm
 +aHYkm6wTTwgB42hrug==
X-Proofpoint-GUID: EJzEdlIz4p0uOtpI0zYIdSFD51BWAb09
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140039
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

Add BOE DV215FHM-R01 21.5" FHD (1920x1080) dual-channel LVDS panel
compatible string to the panel-simple-lvds-dual-ports binding.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
---
 .../devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml
index 8a2f6feafd37..68beb476fb48 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml
@@ -44,6 +44,8 @@ properties:
       - auo,t215hvn01
         # BOE AV123Z7M-N17 12.3" (1920x720) LVDS TFT LCD panel
       - boe,av123z7m-n17
+        # BOE DV215FHM-R01 21.5" FHD (1920x1080) dual-channel LVDS panel
+      - boe,dv215fhm-r01
         # InnoLux 15.6" FHD (1920x1080) TFT LCD panel
       - innolux,g156hce-l01
         # Kaohsiung Opto-Electronics Inc. 10.1" WUXGA (1920 x 1200) LVDS TFT LCD panel

-- 
2.34.1

