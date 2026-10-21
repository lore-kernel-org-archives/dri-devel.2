Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F24F606A328
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BtRAEGJ3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MDvS4GCA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2E5110E202;
	Wed, 21 Oct 2026 07:57:57 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CDD410E202
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 07:57:46 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5j1iH3926222
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 07:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UUSdb7GhbdJGsEth6SJ34W7vHVCnsU2vlRUxl4txdnY=; b=BtRAEGJ3m/gSrMkN
 CjYqTKQLf1HMYVC4H9SvxL/OIOeiYUFZx3hkxeiSk0mMpmdhVmqsiZpTdYNNqVD4
 7MGUDBiORePjw/Fm6R3rjJjyJ0Ezb81emwdQUGmAW0rYZ0Zv/LC6dgeJhb/kj+xT
 0RdNSPFOuOjKPOgpwW2x9dFO3kbheXS1PQkzw1GE6VCUEoDD7W166rgxOdKbE/y7
 egNQNhnbmMYN6UlkbQBapf1mY8TAi88qsjAQDB6HN3flbd/G7yKLD+3Ts3lgGAiq
 CBLN3uYKahCslmV6+To7cYuv33pf6/HbkDnsf3S0FxNiRNzcWWpUexiJ9H41Dbwp
 PmGb1g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7h2c8cr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 07:57:45 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35c3c370b17so637635eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 00:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792569465; x=1793174265;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UUSdb7GhbdJGsEth6SJ34W7vHVCnsU2vlRUxl4txdnY=;
 b=MDvS4GCAY1nJI5v6sCz/vActSNq5HQwxZ2fXiaOgfil7Kt0kqRDwoQdaJ+3Z+c7xVi
 PQdjEG6an9LsP8XqmHn4B7u4RWOP5gkoLtIgydd80QV2ckJsG9CyX28SHzrz+TElc+uz
 No9nifOB1RMXDyk3U+LNnOYtGgQDdASNIiVn5mPYKfcL0inNFUwDDCxTJwWafJy9dVhN
 vMi/j6tu4gv4w1qHH+AApwQExYFqE8LFPpeq/aWhonI9BdIKaq4YwFDfS1bPGB3k6IMh
 l+d6gAisPKTEjs4Wq/P6wnFkHsOvIzHbBb0GuNzfJHC3FJ+NLMB7nEJIEZPPGAzzottC
 cQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792569465; x=1793174265;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UUSdb7GhbdJGsEth6SJ34W7vHVCnsU2vlRUxl4txdnY=;
 b=UizQcZ512DwhCIjzLnfA34ZWJcqOhaK+yB5lZdEVyGtwo+Ft1tATMF8fmOvA2ni/Qe
 5J/xaKHWA++prWaimOl48r2YlhfFslIXy/Cu+00QoCwc/TKPU3XiX2zei0WNwjU+I/MF
 WEaOImd3f8X0ipZmf+2Dc/FCplAZdpye8+SX/d80XKUj5bAsHyk9atRzQlt2NEzbr5vI
 kUw8y4ad4gISr5pPPkH/QbOPkJcAg4i7o7Co0aqsuXrZEz34YTkB3QBi6Yneu2n0rv3Z
 +yQxS1ktCBrK1EJ17zxbe7bBC1shmcxUOD9IP2RDH1C77rUe6+oSh88bot+K+uBBbtsx
 uv4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCMVmgZXCFLuVUCxpmwN3VM2OO+jG6uF8mLLmKGPK2TokPHLnVKA8jFOCsqnePBN2yp1DwKPfw3ks=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLU5u62KKgQX9fCo4BepUNbiwlxoN4cHRb/k116ilZ7O8FVy11r
 pZOMVgjuK7GTmRcKzAgHLuTkp7SLJGnJL++hGt2XStd/gODB89pt4Iy3hvLff/qxcEWKksyjo+F
 jveF9CT0NL9LoTSfFgefmewii6gLFN0lu9KMR3g7ECe4ENkWS/WQyyaoLCR2w1879v9mNh18=
X-Gm-Gg: AYBFou0TKR6iW8t16HQe2TPUbPTP+iqDRt9NzbNE+oyB68wZ/9zbBvDQxn0vnjGyttr
 GuObTwIVwsx7VQ0zQ6ycVaggfQpg/4VzDXalJCC2/c88mw5+ahobyO9jrDoDh8PL+180Mq3T8wt
 nkOhLk/zM+lBS2O4T8WkTtLjbJ8/uKJKkPAA7ZYMfaVlGO11bwOjFtKcWlp6Q00VPHR94UkaMMS
 06FF7kCZE5FcHevTaHlwxGZlRYkya5G8cCEaCUTXweJztvGHPLXA89b5DvnQ87Sz0ElDwHKoTfI
 I5Hmcnk1RacYYn2cwF6uooChftnrHOOym13H0Z7XzqSbEV05Z6xR2nm2lcazPBUevyYIpupv1PJ
 RuLzXxxgiCxnKi9Fp/scQ0gwQ
X-Received: by 2002:a05:7300:4627:b0:35e:da0a:75b0 with SMTP id
 5a478bee46e88-3674e164a78mr2283895eec.25.1792569464785; 
 Wed, 21 Oct 2026 00:57:44 -0700 (PDT)
X-Received: by 2002:a05:7300:4627:b0:35e:da0a:75b0 with SMTP id
 5a478bee46e88-3674e164a78mr2283854eec.25.1792569464146; 
 Wed, 21 Oct 2026 00:57:44 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36741e71eaesm10244209eec.26.2026.10.21.00.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 00:57:43 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
Date: Wed, 21 Oct 2026 13:27:18 +0530
Subject: [PATCH v18 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-lt9611c-v7-v18-1-4978b94896f1@oss.qualcomm.com>
References: <20261021-lt9611c-v7-v18-0-4978b94896f1@oss.qualcomm.com>
In-Reply-To: <20261021-lt9611c-v7-v18-0-4978b94896f1@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Mohit Dsor <mohit.dsor@oss.qualcomm.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Sunyun Yang <syyang@lontium.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792569448; l=2049;
 i=mohit.dsor@oss.qualcomm.com; s=20260808; h=from:subject:message-id;
 bh=ut+CndQz/jrWa/IvwRM0rWOCvN47R5Wgsw+GSTdue28=;
 b=BJvp6vToztQ5YRn9Fv08ZCiWFwNdk3c/ERO9nL3RNMq+bhIwSWIAbBQzaiSLe28miYMqKNVad
 2yII30O5k6sDq6pLqpuXHAK0AiYjYpna3Xb2DMeCCvjcTERj327FLY0
X-Developer-Key: i=mohit.dsor@oss.qualcomm.com; a=ed25519;
 pk=outHVBN53JhozDw1xkj3G1qrqqE5scMBP7M4WL3aHQQ=
X-Proofpoint-GUID: 9qEEYfQsMYK_eNYSZcJq-P_95d-gmW0P
X-Proofpoint-ORIG-GUID: 9qEEYfQsMYK_eNYSZcJq-P_95d-gmW0P
X-Authority-Analysis: v=2.4 cv=EuJHPicA c=1 sm=1 tr=0 ts=6ad87079 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=gEfo2CItAAAA:8 a=Kz8-B0t5AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=SdC2vBNBQt3qShdCGKMA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzMSBTYWx0ZWRfXwgk8FyvcvXEM
 V6Dqi7m2lV53kdQowJ3rLPnSck0P06bjaO5gVYp+WNvGkgrs6nq4OKVkN/BQx/w7Pr/vs82uuyH
 i9VyRfkMl9QJ+JQgC5s+oIr5n8sryIw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzMSBTYWx0ZWRfX9o6JvWVCNzjc
 SyyBtLG4LOPgh4KOnN4xWTu1Sq6Iw+ukmXBvw6z/YyM4lN6FBN+vLmOJxQYmjGVLa7dNlPaXegK
 3mBocRyLt/c6Dl1qxzLpn8wFyHyyJ79py1o285XOmPlWfRrpHCYlaKHM3zfYLM+ivLLVqcB7NGG
 VUaCoy3ttvswLj58jzcYqAULeCCdfLlvVvzJGiBQomPF4mDzwultxdGGatcTLSFzHd/wZWJVPq6
 IwSawamPJcnwVqO+PfCjc+M8Fqjw4q0KXG0eSaIWjPW3RrcHVDryCudsopaezuiWzPDRTLqTxYK
 gT3QaVr0vvmV1eVZFLLZYdeVrXyVCAzI8kwY8JOPr/XTKvnicnDIRrrs2V6Skc8OdPBIEMzSbZx
 74oWgxcgsFkI/r/7VmzOfPcfH7IZPBKXWVigkLTsAQTXZvOb278tzc6gKPnPgDrpDJTw5M2XX2+
 8vHr4AleGB59uEtEryQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210031
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

From: Sunyun Yang <syyang@lontium.com>

LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
mipi dsi and output hdmi, differences in hardware features:
- LT9611C: supports 1-port mipi dsi to hdmi 1.4
- LT9611EX: supports 2-port mipi dsi to hdmi 1.4
- LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Sunyun Yang <syyang@lontium.com>
Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
---
 .../bindings/display/bridge/lontium,lt9611.yaml        | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
index 429a06057ae8..194aeaac601f 100644
--- a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
@@ -4,19 +4,23 @@
 $id: http://devicetree.org/schemas/display/bridge/lontium,lt9611.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Lontium LT9611(UXC) 2 Port MIPI to HDMI Bridge
+title: Lontium LT9611(UXC/C/EX/UXD) 2 Port MIPI DSI to HDMI Bridge
 
 maintainers:
   - Vinod Koul <vkoul@kernel.org>
 
 description: |
-  The LT9611 and LT9611UXC are bridge devices which convert DSI to HDMI
+  The LT9611, LT9611UXC, LT9611C, LT9611EX, and LT9611UXD
+  are bridge devices which convert DSI to HDMI
 
 properties:
   compatible:
     enum:
       - lontium,lt9611
+      - lontium,lt9611c
+      - lontium,lt9611ex
       - lontium,lt9611uxc
+      - lontium,lt9611uxd
 
   reg:
     maxItems: 1
@@ -78,6 +82,16 @@ required:
 
 allOf:
   - $ref: /schemas/sound/dai-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: lontium,lt9611c
+    then:
+      properties:
+        ports:
+          properties:
+            port@1: false
 
 unevaluatedProperties: false
 

-- 
2.34.1

