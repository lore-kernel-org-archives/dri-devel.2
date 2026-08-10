Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A7FC5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BC5010E8E1;
	Mon, 10 Aug 2026 14:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="g8KPMbHQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="anSDfRMb";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F85C10E8E1
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:58:01 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ACj0pl1705871
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WdwA2wmRQHckIWAhOekrolL6CsXQoNiZph7xjDqyoxc=; b=g8KPMbHQ9Z5dmEIs
 78q+6h3q1daAEdSqD5EhhFFiJ+TAsyNNyWl8f/h8rdglyqC5RgL1fDbSceAgFgs8
 92iHgEr8c0MCgESZkAqtDTFPFN3OwK3Eq09LGpYvGuEQP15DDykKXhsMYyLT8I8T
 js63gbGvaQLrTdAnA1NkxDshpRR4cjy/oZmHYvLWjboA191b/45sIv793uwvkYuM
 pW5IeriDK9+epkkNsSh4qG603MIKNW/4ozhXQvMxPSXnaLcE3ApfylYlUlRizl68
 4zAFkEuFT1lmW8oN3VtLbj8/UKVlqUK+sGcgCXR696VbKSEfj/h0v9+As2ohjsmV
 egObSQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fybh59fsm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:58:00 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7f39e32ca40so16507a34.3
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 07:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786373880; x=1786978680;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WdwA2wmRQHckIWAhOekrolL6CsXQoNiZph7xjDqyoxc=;
 b=anSDfRMbcwYOb1vnFZzcnTiztQ5dgF8ryMfs5fbsYJBTW6pQd+6azd7zcCmvHkCVdX
 qoDo5/Te+UZZj8wpVsPZnru3QnhhAmzWiD4XyF55Fv+9wIKgUmtvNN2okpgQ3wc1bfpo
 ToAR8eSHrMK+ahQJZUwIwePuYNNLeMXraMFS/tWG/3/QQBgOTfgmQGSuf8EQUGatKzEW
 bZ1Gknp+LoPl0oW7+W/dToHpf/Tby0JFbxn1DJL376jD2O4raKtPnIo6wAfL9AY6ibC9
 3mE4FPz6SisWgpuvS1qxnYmWixZ764pFCp8P8A8UZxLx9wfLUEUzwR+JuWt5SG5CGvKF
 n17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786373880; x=1786978680;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WdwA2wmRQHckIWAhOekrolL6CsXQoNiZph7xjDqyoxc=;
 b=P3VqXFnk+4y8k3RxPQPjizbNJr3NiGKmkM2W/ZhFThk1ocHaDfzIAwrZbe3SyMWW3O
 OyKa1Fu2lkiEjCSyXY6wJpYrL+APJR2UdR+RNNn9QlF/KKlOUny/2OJLPmhvtFUDbYnt
 G8z7bp6ujCfUv3r2zuM4zWyQqG0x7JnD54FH0q+J4dtzN0ZH7+KaPjaxZbYmr8SRay0W
 pRExBp4MZkajklqUOO3zbvL4puJOMvR9ii+FD00QOtOn8wxdxYzexDS5mbgHfkM1C3Wg
 9gd5mmAXmbPvtQKqmOTn5ub2dcpLOu5EQVodUaKcj8Oab9rAm7Hvpi8VHEudGEVG/RBZ
 BI+w==
X-Gm-Message-State: AOJu0YzT6hrcu2T38pEyk2P8fSUYGRmK36uSRex4pFDaAEbqqZ6SfCJ1
 olj6jamlkYjOwvlX4ZbjT0nC75tj7uzCKaEb4DCXk9CwQ+t+8W/k12eVU1Iw7lzDUuP/qljRJNt
 SW+/U9ff8D8AHhzlUIm0KgzU969m1sj9vP5MnnKSJqKQdASr8nE4eAsPyGgYKFLUg4EpmWaE=
X-Gm-Gg: AR+sD11LoRrieBbSLLTjw7fKwuy1n1sMyyLt77P/0Z2GDu9l9trN8hYqLNYndbea01P
 F944vz4I4CJT4JN+iHNCewen5CMch/+nhmzde7nxRmJXdWRf0IGL2CeY6d0wPpeAZ7I44vxKzc9
 O9bx+fjuFpgu2e4qarCKRNZtqLu8D9/BT2daEpoodEYxcr5uY4XFVbiUWb8bSX72RzkAk6j56yQ
 sB1ijEXPo1T4VfUc4Xl7d+lrdvXAYb1I8igLySUFNpYKB2DIG/0qhyPwGIcQs6D8TKUxrOm4jyQ
 yCM6GLic3I6x5xuIQiVdr4YxwYLNjfhwPkManat869ftuZJBV96m0I0iM7kQ4mwRBoheB74KLLZ
 OzmJW4JfWdkVvdXmjUawiH3qvVZNFhI2voE+TaNypVAjhSIyalcqO2erI+naSA5F9lj2sCKLUra
 hV+i7yLF1/D7JKuB4qnEZs
X-Received: by 2002:a05:6830:6d44:b0:7e3:f809:7984 with SMTP id
 46e09a7af769-7f1e5c77cefmr15118109a34.1.1786373880132; 
 Mon, 10 Aug 2026 07:58:00 -0700 (PDT)
X-Received: by 2002:a05:6830:6d44:b0:7e3:f809:7984 with SMTP id
 46e09a7af769-7f1e5c77cefmr15118099a34.1.1786373879705; 
 Mon, 10 Aug 2026 07:57:59 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f35b806fb3sm7609792a34.25.2026.08.10.07.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 07:57:59 -0700 (PDT)
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 20:27:30 +0530
Subject: [PATCH v2 2/2] dt-bindings: display: simple: Add boe,dv215fhm-r01
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-b4-lvds-panel-doc-v2-2-f2c2fe309989@oss.qualcomm.com>
References: <20260810-b4-lvds-panel-doc-v2-0-f2c2fe309989@oss.qualcomm.com>
In-Reply-To: <20260810-b4-lvds-panel-doc-v2-0-f2c2fe309989@oss.qualcomm.com>
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
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786373857; l=1155;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=qVqJBVOQMtfirprOedA7z/gOwg3MWqFV9hNvPpYASs0=;
 b=Csm0Fl6VuTo5xyNu4TKuIis2gxQpm2RNndEWu3cc8LJQdGBgwSPaRHZR1aquqRdlmaPph/3j0
 4NrY4JRmxOXBusFhNlOh8vlk0zOJROia3CwSvcTyDtJKChYsIjZnJnj
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Authority-Analysis: v=2.4 cv=O4YJeh9W c=1 sm=1 tr=0 ts=6a79e6f8 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=fMfOcokNL7symIEKlBMA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-ORIG-GUID: roMDv7eVdQGCqNBJPx3zypmex4PRT1XS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyOSBTYWx0ZWRfX+IdLYxeq+D9R
 K3D1RoDtbvoF48DuBUfZt1PJcg9Cc89JcdXA59xTLDACA7qzTma0fvZgl2Gx395ke6C1San16ZN
 UwhSxW/jizWx4uu85e8PE3zLjWpBr88=
X-Proofpoint-GUID: roMDv7eVdQGCqNBJPx3zypmex4PRT1XS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyOSBTYWx0ZWRfXzNmwBUZpIFcy
 xYL3zRZVepvz9zpQEFXAEx/ZgD6dR6mTWxDK08CkFttxdpMUi/7cVOG0DDPZnLbTyP+b4nhxtfz
 M0X6zvgkI9vNF1m4SofHGeFXrIPlUL/8cn82SRH22A/xjIjzUAzkpXaJIEwbs9yB/pYi8iVHiCG
 /i1xH6dTRaVqN+2+0KrmV9s4/xQnbxcF9lDGvGSSroZnKR0tHJSqqwV06C8uYdEigitV4KM9fwS
 BOPw6v/j6WxrwBGy2CypJUELqKvmqy5eMW3l2WNr/7N1DBZng5JxaJYU48Cf6q4W92TY9pCocNY
 WSZNfH6UZ9nt6EjpU11NVKxCUGSJcOzMee7YWvteMb2VJR/Z1T1qsZ8MpzYHn70mauDGSCJ5yYv
 9NFe4A/UQQMvjSebRCF68Ge/SfDuHDzsiYnJN6n6ao9dObg2jdEBWNFTrmj6YST/Vg3sMDjG4VF
 uCx3V5ujNQAbO8s10fg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100129
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

