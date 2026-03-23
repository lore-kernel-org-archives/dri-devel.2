Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2ED0FC72A8
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 07:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C62B10E02F;
	Mon, 23 Mar 2026 07:09:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QpUH1Gae";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZXD8Ig93";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EBB310E3C9
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 07:09:20 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62N47rfX746966
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 07:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QGpjuuynPwJX16qdGkdVckjT//0sIw8TY5KE1UMUWj0=; b=QpUH1GaeHs1Xsf0E
 aG+ZlT3zgeW0WPlCHRhCxBvh6M91qlABmRsGi9drJQwEmrjjl5vHF2JoJRGhIntW
 DG6wDPfAio5WtFxLF0y68+as4CbF8tClxBjZ0RkAsVbrAJwJsEC6+KO/xDJjTGKu
 41znBpkxfp/pbLkGQrMAjh7jO8ZX7q/+iHyV4uN5hI/bslDZxgYudBSSzOlKicZh
 B9nngjDu23GUE1U8Ia0HBRPzAdOT4E8fLidnp/FI2T1niOyYROl1iiMCfpoe4MBT
 hUSXOx8tIDqfKHugZJRt/WaY7DghPoQnz3Y+b68aY3dlnBNtvJE5pFBdkrVpo6ZU
 qPCZmw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1jb5mad6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 07:09:19 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35b9333cbfbso2333965a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 00:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774249758; x=1774854558;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QGpjuuynPwJX16qdGkdVckjT//0sIw8TY5KE1UMUWj0=;
 b=ZXD8Ig93L7WpBe+0mRfY3IHwi8WoqpgWSiv7vwz5S/ItHu0LMe8NaYY7WcN70sEnFe
 PleOD/Fi2JFu1mWOa7rYCSpqPxtPOdGFG6WmTQ4eiBqtbx3pMIy3j4GgXrdii2URrLQs
 wxCkqY6/YXFK+9MYCD55PNRb2NFgYRyxqh9Z5VFhm72+uAcbiy4or6BmvZGPAFL8lf2J
 BhylfNapaUAzupnHBPmfdgS0VbC2b50dVDvWORf9saiL4TeveOGjpg3NQ0IE1DcdIsas
 h59cbZyx6oIwUltXhjchDp27LDLIv8HI24oSHwOuklS2eRyv+ANOUNuLqMPmqPe1a0z6
 zeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774249758; x=1774854558;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QGpjuuynPwJX16qdGkdVckjT//0sIw8TY5KE1UMUWj0=;
 b=NrGb7ZVw5DARkVZbm8qxubv/2K/Uag/D3r9ZwdxxOGHAnIctf/+Il2wUl5UJTsWtcF
 s38/y7/sVaGJnOyULWSdQf67Ftbh9z8Ei1mNa0n7lv6pvHV8EWE7TElf/bhSW15KHoew
 n36aR3l50L4LFqSrKhG09rOUaOq9RH9yLbWvaUC7zm4t3l81/LEaFnLApmAkt26x6hKc
 miTxqFEcOKVfAuaInz90MdB2ZczQDtVIV1ODRL1UETpEQoENQTtHqUvcUB4vhjhYIQTF
 RgRItQymb3gHiJf3djrIt/D1Q18DFfY+ru464OuLfVUS3HgQHi9Cn9i7wwlYtv0LpPmS
 GSjQ==
X-Gm-Message-State: AOJu0YzJb47rwiBwCt6B5ggt2Vbowk8rx34jI7TUvRXJyfzJ/1an+MM1
 088Lt59k1hsz+/5U0+rDco64nzjLfAHxo1zoeSgbH19dnFGEecrRFV/hKjxskGn849F/GPDbfRZ
 50H/8RklkBaK/4oJyr/jw1Upo4BByk/5WA29JE57FcU+B/yROjZI8/CR4Z/XOcgmMZPJTONw=
X-Gm-Gg: ATEYQzwxhA+HZvOjIg0XIaVpSGxswZRikEa6yM9kTLblCmRHs4LoR8va43usId4xKeh
 FjTW8vcMD7XQW7INnYlfvh6Uj8p6Q7hGJrn4SWAsQLs6B2MJWU6AAyfbovXGyApu84F/VME6eAk
 uDyH/mI0Z7RMqYM4UjAh5fgJFUsqvnQzVbq3llZULGSpB7yNAw80uxhmfbVw268mtpQluDTEReb
 nLwN9oTJ+ZYwzKGXm9S+o/y3xF4IZd/cl9YbOFIgHo9RlXT8VIW2fCOGREnNwaKueldCiZ0xZwT
 BZ1SkQ0+ggpwk/u89TCd+KsztrIedajCqEV+nIjUJsWUtxi0DdumHCipzjwJ7xjwbj63WD6XSRz
 Q93xDJlMRzOhsX8+DEFIQSK1Bx08m0qFmZ56Sa6ppdtt5d8f5xPHltnDQNqdwHg==
X-Received: by 2002:a17:903:2b04:b0:2b0:51f6:d46e with SMTP id
 d9443c01a7336-2b0826f6ce5mr106545075ad.15.1774249758041; 
 Mon, 23 Mar 2026 00:09:18 -0700 (PDT)
X-Received: by 2002:a17:903:2b04:b0:2b0:51f6:d46e with SMTP id
 d9443c01a7336-2b0826f6ce5mr106544645ad.15.1774249757546; 
 Mon, 23 Mar 2026 00:09:17 -0700 (PDT)
Received: from hu-botlagun-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083655b45sm133118795ad.42.2026.03.23.00.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 00:09:17 -0700 (PDT)
From: Venkata Gopi Nagaraju Botlagunta <venkata.botlagunta@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 12:38:52 +0530
Subject: [PATCH v5 1/2] dt-bindings: display: bridge: lontium,lt9211: Add
 lt9211c support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-add-lt9211c-bridge-v5-1-9c63bb035c17@oss.qualcomm.com>
References: <20260323-add-lt9211c-bridge-v5-0-9c63bb035c17@oss.qualcomm.com>
In-Reply-To: <20260323-add-lt9211c-bridge-v5-0-9c63bb035c17@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>,
 Nilesh Laad <nilesh.laad@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, jessica.zhang@oss.qualcomm.com,
 Yi Zhang <zhanyi@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774249743; l=1434;
 i=venkata.botlagunta@oss.qualcomm.com; s=20251110; h=from:subject:message-id; 
 bh=y3BZBNP7fsKO4ymCdRcD7Ne62Tg4ATJwDjDqmdLWJ8Y=;
 b=2dJthIMUQedz13rkgvhq4xuh/Sz/CzWarePFvtsxYSukmBOR3ZrqkBWjj+FCBB5opwJBN9Dni
 jse2CrYyywdBUuK0SYgISaSgJDOCi8xTPtTN/OtQ6WWOcCgyhxbNugn
X-Developer-Key: i=venkata.botlagunta@oss.qualcomm.com; a=ed25519;
 pk=/SnYBwlkTzDCLnHFgEY0qFwPgKIV+aQWRbc3naiLzrk=
X-Authority-Analysis: v=2.4 cv=aJv9aL9m c=1 sm=1 tr=0 ts=69c0e71f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=UcubZVdaWCKl6vSfqw4A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: yFBEZv5TOb1XceU2nLQC-UrFVy66lrYS
X-Proofpoint-ORIG-GUID: yFBEZv5TOb1XceU2nLQC-UrFVy66lrYS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA1MyBTYWx0ZWRfXwi5UpTAqUAbm
 qym5zhSMTXtWbs7kC27mKwKISm8ejlm89+z5U4c0yKpWOUjzl4SCgybJYfeKJm1V33X44apNxbE
 zhfJYKIh8pnSTVijHKLI6q9KEE/uRXCMdsC5FqdWzG2k0/2UPk3X8YcO1eediKhfvz2pbtZdlqv
 z5nfHSv/GXCfz0NrbgQIKfZk3e6ffyBwapaRM6mArcvZIR/aZcMKJZ4LtrNayiqrl5oKXud68w/
 4/tsiBi/M4gYQZqqhRX4oYo5K8lfiIO4yRq1l6aGrbAckO5R+eGAkuiKMhZpk2pNNygJ8Z0M+8z
 vM64KDx4sUdB6BzYQWsMF+IBL5eaV/TWb3NuyaMCJNHxKiixe0vL9CoWi5Amn1/2Mq6SlEsJsL6
 gFRqrJapulKLFZiKYT5iAEtyQzfelryKx6ze7QRZ8wumbWOxDbxRx4lpRPdYxBnlT9eqDEs/xV3
 K3rCFDu3ZqgEWOZVTbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230053
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

From: Yi Zhang <zhanyi@qti.qualcomm.com>

Add binding for the Lontium LT9211C bridge chip.

Signed-off-by: Yi Zhang <zhanyi@qti.qualcomm.com>
Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
Signed-off-by: Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml
index 9a6e9b25d14a..8df90c014064 100644
--- a/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml
@@ -4,19 +4,20 @@
 $id: http://devicetree.org/schemas/display/bridge/lontium,lt9211.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Lontium LT9211 DSI/LVDS/DPI to DSI/LVDS/DPI bridge.
+title: Lontium LT9211/LT9211C DSI/LVDS/DPI to DSI/LVDS/DPI bridge.
 
 maintainers:
   - Marek Vasut <marex@denx.de>
 
 description: |
-  The LT9211 are bridge devices which convert Single/Dual-Link DSI/LVDS
+  The LT9211 and LT9211C are bridge devices which convert Single/Dual-Link DSI/LVDS
   or Single DPI to Single/Dual-Link DSI/LVDS or Single DPI.
 
 properties:
   compatible:
     enum:
       - lontium,lt9211
+      - lontium,lt9211c
 
   reg:
     maxItems: 1

-- 
2.34.1

