Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1734B606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JD6pU3sV;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EY82I5ix
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BED310E2E7;
	Mon, 16 Nov 2026 11:34:55 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D169F10E2E7
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:34:43 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGBLRO5918628
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=p0U+0MgseieCY+eZgbxNlA
 GFpXCIrXZzDYBXpqCiW0I=; b=JD6pU3sVv6KXPfTVXYWh2QhBBZR2u7QSDCDHEa
 H9QRMVKQabwfChms+jQ4uE7a6ndYuQG6A5atqfrJY6nUEPmQZOszaPXW7OiqvmtM
 BZ5F1wh8bXDEkDzOXePVtbIZ+aNsxI4N6bym5MFZVS1Drsfvj+rt5nFeHjVNHfug
 gA9+1rHOuy/jA1V+bDncMDiuY8Kndfo9AuvoleKm98H8YG6fvjwIw40hmcG2f9u7
 x73N+4+HVIDBswyH0Bi8mfc8qBnd449Q12DWL1k6nBt93lMpF3pC6BpCUwfCFMYG
 obYGFz9iEw+tBjCmiAd02lD843tvFsUhhqw2fyBRLKyDLoIg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j000g08ck-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:34:43 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3aed37745bcso3242280a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 03:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794828882; x=1795433682;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=p0U+0MgseieCY+eZgbxNlAGFpXCIrXZzDYBXpqCiW0I=;
 b=EY82I5ixoMZdD57lbhy/5V4Gtmt6VG77ptqZht4dD/TTpdfoFpXpC0zOGghx6GeeCs
 SAU33+CMdlh0vUdqjmROebQfleRrZQDDPtnjesn4BfhEzq4f6PxGR//5wkljgH0APQK9
 Si13QiiNX7+vyjxj8T0/PIjzUk9RwD5SC0pMZdlIXR/LmvHo8MTuMJnPe1BrD7qnKwEE
 HzhNLVxSLewQ/r4m3+NhEh/1nXma+nJgRcREJWosz4WeSUpYz0l5JC7FVJISUIvxXKw6
 cn5T/UJGzwdcdRDh3QhfKOAZF8vx2+VQ2+pq/uo3MI+9M/YhVWAPAiT1EJcgpX3LDX3o
 E+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794828882; x=1795433682;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=p0U+0MgseieCY+eZgbxNlAGFpXCIrXZzDYBXpqCiW0I=;
 b=fvccuKsfs+q2J3bp6rhLAyOlbw00cqYG1IHjvfWrXLH887la4kM7Y/x2IMtebrKU22
 FPosi7Jqg/LY8l4WNVHxk2uts7WQqhNU31hgj+uFQh1Tjn8tsDh2QQykQ25ts/AeEDHE
 Vshq1D8ypipQjZEXbmKA/CqtLK+mFCkoibGBr4WLG6oHbffaGuK3S8Z+EnhTnUYmiIdf
 r9GWF2D74Xbb3B97dlLmsxfnU0Ee8rGUDQurAnAmaJm4+YcgMgWf2FAiwQbQZgU7Wv38
 zzbDqGRhK95GJwxMB4BrLsEMqBqwdQDwSXL5EjUICCCsH5vhcz0jA+xGr8rhGtdPKSoh
 /o0w==
X-Gm-Message-State: APuU4Z8dSQesVBPRXmphkpGqe9kjgCT639HxcT9Zsv2gfgEv8RJK13XU
 OJvqDfnnK+tMJcFBvzZYUtJMLhud37wiWqx9aUxGOC69NZYbv4WyxSKMf+8b8JKsMY89mv2Jye3
 iXMjGzilJ2tUv+vWpSXflFNxWZe76fa9hvBRZrW9cy2Mha0haSc3Vx67PXg/GIq80OfAag4ey7z
 TQqzE=
X-Gm-Gg: AZFdTZcERPzzrmsExWruzEMXr58yxLrUWpbRO52VlwA42s11X5gJZRapHtyD8BfH1pV
 /qM7TrLXdm7bF8zLNzBfJOX7sqQKqpQxlieM5Saq9eWTEFD8n4MBNUvQBZUKeVjALcl4BjmDfhn
 Auk0yvYy48kOHUPRj2C9+SZqKZnoJ3uBcU2IEgbFh8udF7fX1X8QtSKi9jhq9t53w9LB1Z21Oh5
 ozcPBawudzUg4pnnW1bL7xn3qAnHRP5O7hAgOdyrOrp/yKUJNGc1C0AZwpxrCHkqEh8I6jb8qgT
 pddm4IQCRXOsZglJNq5Ck0bKFO90Bq1NwPemI64Y2wU+mZsOAy0zt3fxqcyqKS9t/YPioun9b63
 RJSCarrKapXf0iNQsboTCuHBmqSPseXzrwfrZw5oCyZDxXaI+5RKMURv/q+eqzzaIvGJs7dSvQ6
 Al
X-Received: by 2002:a17:90b:5112:b0:3ac:9ad9:6afe with SMTP id
 98e67ed59e1d1-3b1b0d481c5mr6683731a91.39.1794828882400; 
 Mon, 16 Nov 2026 03:34:42 -0800 (PST)
X-Received: by 2002:a17:90b:5112:b0:3ac:9ad9:6afe with SMTP id
 98e67ed59e1d1-3b1b0d481c5mr6683708a91.39.1794828881886; 
 Mon, 16 Nov 2026 03:34:41 -0800 (PST)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197d27d26sm21000719a91.13.2026.11.16.03.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:34:41 -0800 (PST)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Subject: [PATCH v2 0/4] Add Parade PS195 bridge support to enable HDMI on
 Glymur/Mahua/Kalambo CRDs
Date: Mon, 16 Nov 2026 17:04:03 +0530
Message-Id: <20261116-mahua-hdmi-v2-0-0b5af6bf9e70@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACvq+moC/22NwQ6CMBBEf4Xs2RJaEdST/2E4tHSxayzVLhAN4
 d8tePUyyUtm3szAGAkZztkMESdiCn0Ctcugdbq/oSCbGFShKimlEl67UQtnPYkjYn0wZWfVSUM
 aPCN29N5k1+bHPJo7tsNqWBuOeAjxs71Ncu39FU9SFMKU1d7WRlpb4yUw569RP9rgfZ4CmmVZv
 gRT7M69AAAA
X-Change-ID: 20261112-mahua-hdmi-8ee75b4fd29a
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794828874; l=3388;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=CEPQAfrfoOVFKYiKvfmvgizAwumAv2PlKkCejyLCjNo=;
 b=hRbs9o7wPDhSjnLNtvA8ciYcRV/oTQJ5GNv/Dp0qV2W+e2dBnKRX5ILctpkifimanUrxvlgK7
 fd0Cr5MqwiqDh5isEcGgP9jOMNL3mcNewIPNYORuLQgcszfQa0fx7zw
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0NSBTYWx0ZWRfXxkYdQvhtlEzn
 wCyhHvFVAZIwJxI5gD0UaztlXvZ1XLzHnDU4lQuBUihOJ4QR3/weY/vjjzGgbEjAoa8+98He2HL
 pTYmqSA1QCMGlo9+7QjVVRjwX0zS4tQi+FYFQUIMoilt0WGnJnecBosm2Ua62t791h+JoULH3fX
 WbPEBfBQj8g5MK7LLAkgaE/IaRs0BYH88pZmf9qAomZDkU2bEPyUwaN3sDcelCPBSvgkV+pHdet
 vG3nMOgi1/T7xq9dqe/12zU+SLzJh+z+VNciz/RRS8rnj4arcOBw2C64iqWalJifn5n2Peo0Q/U
 bRP3xRg2b+knJW+5utiI92xAV/ZDtlUXmvDe9/YJ8brC2hZM6l8rN65oAqbHxMc6RFKz0b9dbu8
 3zmY3oVU94tyRDYgzrIhsjvSJRKEbPV+b5rhJ8BFZhO8cKco4gwF6N0h5GW0k9aAqsZCOIG7Gv6
 XvaygJAmQWdtAHB1asA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0NSBTYWx0ZWRfXxgvg7xLm8XFO
 5k9WjJtiV/tVxRYpiYomWnJw2QanEcW9JcCjyxZgeo4DOYZRxXjS8jTBkgUdTslYk4UAuRTIjCb
 0KYuYJT6pgr1J2fidRLZ0Kp054fMlJo=
X-Proofpoint-GUID: FF8QNWR9qn9CAbp9YHuf_7pucq433TPI
X-Proofpoint-ORIG-GUID: FF8QNWR9qn9CAbp9YHuf_7pucq433TPI
X-Authority-Analysis: v=2.4 cv=Vdtir1p9 c=1 sm=1 tr=0 ts=6afaea53 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=QyXUC8HyAAAA:8
 a=KKAkSRfTAAAA:8 a=P1BnusSwAAAA:8 a=pGLkceISAAAA:8 a=P-IC7800AAAA:8
 a=e5mUnYsNAAAA:8 a=Vl28STUz-e5Og-itK1sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22
 a=D0XLA9XvdZm18NrgonBM:22 a=d3PnA9EDa4IxuAV0gXij:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160045
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

This series adds initial Linux support for the Parade PS195 DP-to-HDMI
bridge and uses it to enable HDMI on the Qualcomm Glymur CRD family
(Glymur CoB/SiP, Mahua, and Kalambo).

The PS195 operates autonomously using firmware loaded from external
SPI flash — it handles link training, EDID access, and hotplug detection
without host register intervention at runtime, so no existing bridge
driver fits its power-sequencing and reset model.

It introduces:

- a DT binding for PS195 (supplies, optional reset GPIO, and port graph),
- a DRM bridge driver that implements PS195 power sequencing and PM handling, and
- arm64 integration (defconfig + shared glymur-crd.dtsi wiring) so all three
  variants can route DP over USB2 QMP combo PHY to HDMI through PS195.

Deps:
PHY PLL change: https://lore.kernel.org/all/20261028-glymur-phy-v3-v6-0-1f1d2e565a66@oss.qualcomm.com/
Glymur commonize change for regulator: https://lore.kernel.org/all/20261106-topic-sip_cob-v3-0-52cd3826ab49@oss.qualcomm.com/

---
Changes in v2:
- Converted the driver from a platform driver to an I2C driver
- Replaced the platform hdmi-bridge root node with a proper I2C child node under &i2c13
- Chane the order of power on and reset action in the driver (Krzysztof)
- Link to v1: https://patch.msgid.link/20261112-mahua-hdmi-v1-0-b463d7b1dd7e@oss.qualcomm.com

To: Mahadevan P <mahadevan.p@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Abel Vesa <abelvesa@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>

---
Mahadevan P (4):
      dt-bindings: display: bridge: Add Parade PS195
      drm/bridge: Add a driver for the Parade PS195
      arm64: defconfig: Enable the Parade PS195 bridge
      arm64: dts: qcom: glymur-crd: Enable HDMI output via PS195

 .../bindings/display/bridge/parade,ps195.yaml      | 111 +++++++++++
 MAINTAINERS                                        |   7 +
 arch/arm64/boot/dts/qcom/glymur-crd.dtsi           | 147 +++++++++++++++
 arch/arm64/boot/dts/qcom/glymur.dtsi               |   6 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/gpu/drm/bridge/Kconfig                     |  10 +
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/parade-ps195.c              | 204 +++++++++++++++++++++
 8 files changed, 487 insertions(+)
---
base-commit: 944e974742c54a1d8236fe16897644c35ffd6433
change-id: 20261112-mahua-hdmi-8ee75b4fd29a

Best regards,
--  
Nabige Aala <nabige.aala@oss.qualcomm.com>

