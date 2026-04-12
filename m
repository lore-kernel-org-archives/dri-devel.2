Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213BDE937EE
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 17:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64C5410E2CD;
	Sun, 12 Apr 2026 17:32:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="j+aoycii";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N3ezeGjE";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96B9810E2CD
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 17:32:36 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63CE4sUc3830849
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 17:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cjHn7Kk5aOTSG3RKTc9qr3CMGxHyzEiq474/PRW5gVM=; b=j+aoyciiQ4vmGyY/
 aW24Pb3A19VCXG5157xJmt0ItwqIHuEoBLq0dZm9LsLNDMISn1iWTxlbH7D6Tx29
 ek+I9RzQZUk0KjG9HYNOzoCUiRt6z2DeapXEHMwP3Rqx2RmCXBr7Up/2KbeJlaaZ
 VEtLJoTDQXLky4jiAuDZLa0aie7rrrspbbDG1I1v4589RXeQeUWkW0P4wUEP6xW7
 qSn7WCyXj0rQAXm4FOltKl99t0zDoEkMMm0RBHqEzdSvyRVRKZSVl5lMtlOGDv4W
 PSYQQDYiWNHq69NTmjlL4YfR9ew+HSnDA54tRpX5dRDcgsn2klIwl9Zzr7gX+nwt
 iN+HXQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfew02qxn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 17:32:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d9a6a853bso90902341cf.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 10:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776015154; x=1776619954;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cjHn7Kk5aOTSG3RKTc9qr3CMGxHyzEiq474/PRW5gVM=;
 b=N3ezeGjE/8/w0kAPYnovB4+pIFfzImg78F5IIrrv+BZ1hbIXVUA/mxgWG2iOy8bED2
 QxZC+RVfRpRni638KHRE0pJD6/iH2Hhzs/Nbdcn+LCCZJ0TurlXUMyiMSx8JWCyTCZZa
 YtR56SRXLFAJApytAHSS+t6JNKl0Q6QP5rYzsLJvmEvixRSX6YJ85UoNXRwtNGqEQ43C
 ZCFGtJRlCR5Llg8admkuZWzwvVSGm9sUQp8sXDvZtXrtUDhz4LUH0jCXDUypHX/mLmHG
 TOioq8W/IR3KQQx2ogcQMEZK1KKvkb5+dhEezzT8S59leV2L8Rq4kqb1sm5FhnFz8j/F
 jbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776015154; x=1776619954;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cjHn7Kk5aOTSG3RKTc9qr3CMGxHyzEiq474/PRW5gVM=;
 b=d9LDA4pezMGaHUDL6w2ErypANAMUK0M6MKXMZzzxRkTpQkFGqpCUfi+aKXH4GytQme
 pbekcjc2kZlsoK+7BBfMnRUQSGzV2U6XXMr6pq6o87JdfXG2vVCMdZzLApIT77WOk1i+
 H+Gg4Yya2/0DSzi7kMt4Y0MX+X79H2lRRij00V0HkkcsfePnQXZBwOPjiRXCLP6h62KF
 EkZ2skVnkbBwqS5Ffnmbjt15J8SCdNcRhwoxCgCnRLqQ7bqHSyboju7pm9S4WuOmU6me
 kYnzdNkQfVVPi3gsgMLFVIqeiIOKMOUOS4kvlENnUgfqFXDRrqsX7wkEADd3e4EYz9rv
 2oyw==
X-Gm-Message-State: AOJu0Yw8PkpjSpxqmk13cnAZ9OmEG7O2U03hJK2nysaf/51Cx4k2Fs/a
 ndmVOEwWcewOwC8gO/nf61Sn8xcf7hZqgVk0d0uZ/Fl1X2QQUkAx10qpoL4L4d5tI8nNH7Q57hb
 6bamY/IrHnaeTbpGf1FJ5xOaJqXtwmWvpYaSQDfuhcyd1CXYZfrrKOdaPiJC6ur+pHNKLRR3sUk
 bJzF4=
X-Gm-Gg: AeBDiesfdmPqepvd498MPZPI24ewtL3fnx70blN/0Fuh0mnWn+tugHZBbEsFGcLbCV6
 FGR/FmdKT++/BfbU4DMtLNzinxoE228DM2+dQuThWeZ9Y8G8kPbkimyd+ofZZ2/DlX6NAoI8jxy
 d8SugMdTjDdvX5n1Liurh9LfVIHPvLHwrRbpjS0m01wH7V1rkfqqe3RcKmAKHDd+lFUDuJ0RfxO
 89lLFW0KdWvCMt3cYTfGOQH5alka0ho3t1dNl/wRoJ9VYoySDXNPlMRx30lKCGTWQQkDQ9BRjnP
 qwvFmq2QfpmP+VPb+6YndVoK9ebFrgywXesQuWAXT/QF3S5Fz6h/llG0iut3hpO8YVR6Dp3WI3W
 Yaft/Ti6V8YDXf/GYAfa4RllAPeeeJoSzuC6hdGC2B7jOQds0UMu6MPlok0Uynryrps4IyRz2Vk
 rjsS9qwSZ75FLq8Km41uTqr/JROjtJiqjtAnw=
X-Received: by 2002:a05:622a:4106:b0:50d:5d96:568a with SMTP id
 d75a77b69052e-50dd5b016camr159089381cf.27.1776015154383; 
 Sun, 12 Apr 2026 10:32:34 -0700 (PDT)
X-Received: by 2002:a05:622a:4106:b0:50d:5d96:568a with SMTP id
 d75a77b69052e-50dd5b016camr159088731cf.27.1776015153907; 
 Sun, 12 Apr 2026 10:32:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e49a4a6f9sm17585231fa.31.2026.04.12.10.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 10:32:32 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 12 Apr 2026 20:32:24 +0300
Subject: [PATCH v3 1/2] dt-bindings: display: waveshare,dsp2dpi: describe
 DSI2LVDS setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-ws-lcd-v3-1-db22c2631828@oss.qualcomm.com>
References: <20260412-ws-lcd-v3-0-db22c2631828@oss.qualcomm.com>
In-Reply-To: <20260412-ws-lcd-v3-0-db22c2631828@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, Joseph Guo <qijian.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=7geT5bkEq5ZiMOxGkUOHpZ6vimPzI950/l3utWM/ns0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp29ctrpy9xOc8Q5jpDD5T5H1241M8mBbzDiLZc
 iMKnWu2//eJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCadvXLQAKCRCLPIo+Aiko
 1dMZB/9925HA5O3DHUQkzNGdjbjr6r8kQWhu7qW2quZT1Fnw1mupJmQKoZdl4dEpzPELDeFa+L6
 MNjurPLE+EmWCb7TleP9Ynv9J8c7eDbBpb8hMo76cx6rdErA/lRhu5WsipJ8OkKZ3BYT/jV5Zmp
 2YtkoRmCB/G/fCrynBBkyEsp2E33DFZEp2gtXG5eZOrjmIuWtuUSjX3VgDP7uVXgQiTDC6gwfnI
 +3a9bxN36Ywoa9Z23jNnPM0K9tQp9O7ne145gm1y6W2/aQPTGpDQqdS2Fm7VceCZ73n+qtLsZ5u
 00l/P22K2hNsJC4r7JLjxCJ6tCimva2Gb/x7hHKxYh4tLJnD
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDE3MSBTYWx0ZWRfX/wA/yBi3aR/n
 Owmjct0TU56Y5++zqPH0dJcmPqheCvOkPf+I1QlvbXkH7dgBiwWc9hev81SgyEnk8dIoRmOZ+Fe
 TbhdtxhlFmnE3vg2iuXXw5b6pHn9WrZtsB9ydHj6Vl0lVBcPvuzG5JrAId1T/+182XWPdj/WwZZ
 yr79RQKVo8RkVCmCrCMBEC3aguUjTfRjSJOsTwLjFXPAK4DEOT69qNpiD5+0PV/jcK52s9KWekI
 Y9JY4fXXsRyTaaYnCFhZxPSZ18mdRPfHA0ZqLF/zcC5ZbfGVM3At6lnPsCjD907qYssex9uj0Oc
 K2on7/SpFlw7/n45/QN8nrUL2PLrpf9O8RStH8fvNmV/4tpvP5eX1sqAf4zQ1CZjPTMIyYNk2z1
 1Ad4Nay6eKg8840HKrqtoonkLVw0GbJyKuDSh98Fr78Emt0NWWkSQVrMxeKkmyWaVfuiS9EA6D4
 D/mN/vks+298oRl+avg==
X-Proofpoint-GUID: jDVisEYbHmngAIVDhjOPGlzXCSLj1idc
X-Authority-Analysis: v=2.4 cv=AofeGu9P c=1 sm=1 tr=0 ts=69dbd733 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=8AirrxEcAAAA:8 a=7qgZ0iPFU4Zeudp_5JAA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: jDVisEYbHmngAIVDhjOPGlzXCSLj1idc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-12_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604120171
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

Several the Waveshare DSI LCD panel kits use DSI2LVDS ICN6202 bridge
together with the LVDS panels. Define new compatible for the on-kit
bridge setup (it is not itmized and it uses Waveshare prefix since the
rest of the integration details are not known).

Note: the ICN6202 / ICN6211 bridges are completely handled by the board
itself, they should not be programmed by the host (which otherwise might
override correct params), etc. As such, it doesn't make sense to use
those in the compat strings. I consider those to be an internal detail
of the setup.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../devicetree/bindings/display/bridge/waveshare,dsi2dpi.yaml    | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/waveshare,dsi2dpi.yaml b/Documentation/devicetree/bindings/display/bridge/waveshare,dsi2dpi.yaml
index 3820dd7e11af..4d34a92192bf 100644
--- a/Documentation/devicetree/bindings/display/bridge/waveshare,dsi2dpi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/waveshare,dsi2dpi.yaml
@@ -10,11 +10,14 @@ maintainers:
   - Joseph Guo <qijian.guo@nxp.com>
 
 description:
-  Waveshare bridge board is part of Waveshare panel which converts DSI to DPI.
+  Waveshare bridge board is part of Waveshare panel which converts DSI to DPI
+  or LVDS.
 
 properties:
   compatible:
-    const: waveshare,dsi2dpi
+    enum:
+      - waveshare,dsi2dpi
+      - waveshare,dsi2lvds
 
   reg:
     maxItems: 1
@@ -53,7 +56,7 @@ properties:
       port@1:
         $ref: /schemas/graph.yaml#/properties/port
         description:
-          Video port for MIPI DPI output panel.
+          Video port for MIPI DPI or LVDS output to the panel.
 
     required:
       - port@0

-- 
2.47.3

