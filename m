Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA621606A89E
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kK6g/sVP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Fee0w5lu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F40910FFD0;
	Thu, 12 Nov 2026 10:15:58 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B5FE10FF83
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:15:47 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC5nlgx441999
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=rcf7KX2/k1jjCd0zZNcv+h
 8VDra3CCI6aK6Rh3JpzWs=; b=kK6g/sVPxEq/537kJrMxhljfwMxmf7yPaRAnd7
 aOftMKlG2vo62K702jKPIZEhXhbjvIYtRBeP98/QE5E8kl3yA+FGcvc/NDcbB6Hr
 UlRKxmfUN7jtgUdhJZRCVTp6xPcHwizF/E2s3WHDfXwHDqV4t8RtQjLvTpacdz/o
 W2fp8qPqzOWsSXlrvYhCJyobR8MxjUAOeXXjV8/VY5YQArVaUGewu7RoCjRKtH5/
 YNOgevYEDKVNKLYum2ulTH5f13RpBwIuIFCxTx3u9ajVw324KlU0GEcD5YtGT6pu
 1L3ujOdlwG66RZj4YJHqnVEBJUB8jmNgJCqMEloqVBwCOF0Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw7nc0ys5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:15:46 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8b852fdd55aso5245444b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 02:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794478546; x=1795083346;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rcf7KX2/k1jjCd0zZNcv+h8VDra3CCI6aK6Rh3JpzWs=;
 b=Fee0w5lue/fk9c+gkDHKy5iO+SOiCWflc1YpaxCXv0W+c0rCu/fQdTEsUNiA/yLGTE
 LdF0MpTEPAnCG7uTk1IC8T5KrZBRrir204I7HDlLordZxkqVlwpd2BXuieHVgS07DCDL
 cgA/eA1feCFymYh6VIsxhnmKee72Vm6a5m6WPY+FgPph6PhxiTj7eDQunmNssaAjZtbc
 sBkLskM1IMadOvvSWvu+b7iTbfQhJ4ZJRHKtsPdw7XUGi1tQlFtyvzsHMVcQ8QNwWoaJ
 WvjcQqenDo8Sdsf0OelAZFwcnDFVe3I61MP0PqkD30sEBOgC7r/nqPwz/bcvId65v2I7
 /iWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794478546; x=1795083346;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rcf7KX2/k1jjCd0zZNcv+h8VDra3CCI6aK6Rh3JpzWs=;
 b=wNg3ujM5n6omensG6qltXIk4uY5DHmVrKMxsQImze3RI48ApZtE7MhlIULb31/fvMx
 lqo7r+iQ0qmbWe1NvHxX/KNiKKO8DtCq6usnbVryTh7HMT5TQp80lkqoVXmYAuEaZfZr
 ZBowGaAAVdXJeppngd51VdT+ANhMI22oq/soiv3vXAmXa3SunK9ntjcb6vK+fYfoQrGJ
 C3kwUOFndfLCwyD7CjBbYTJd6yFNcLVHMm+cJVe529L7BjtVS5IMddeuk4UQmhDXtvBK
 hlQwtZ6CUThSaKKetRpUoQZ6KqMEjqH6xYYUDXCvMZQYzmVF5GwIqcBSs5KpcTPxJyw2
 1lZg==
X-Gm-Message-State: APuU4Z+0uua908kqi0zf5D8tdlnit55S8rQCQPgsIF5Sr8IOanpG5RAS
 XI1zBrnuDka7SIM1oXpf3zwBdZybsqoIICIsuHTohaPfFBtm4R1kv4HoqOxzRsFelvEiVXDVId9
 vANUlAwi0H9r8+Cdgmu9GD+mEH1OePefmm9GtkJNTKDQK7xBsfvr1RdskicdoXVax2obTpcFL+K
 Zvifw=
X-Gm-Gg: AYBFou2L/xpOsCxghrhPWrGPnljNuulKe9LBhPDJtTNEK8S6xa1XP/h9jThXR/c3Txv
 cLOIGmtaWgLSK11Y1WNCA7pJ8NOUeoSxDVp94DfblqiAM2aS/4A0f0CQlID+B+DKg1n3ONFTAoY
 LNHqspUsZLaTkicHNjwCZfKt2J/nyjrS4m3FbxlnkXuTP6fy+IUV8HyWDq2uLf2wVKd8aWgEUX3
 /hYvpneWFJr5TKtdGwVTyglrHLUcb2OL40IDc3IfmXNuS6nBH7nfkEXymM5PFD6oIzdRt5qkpUc
 Dc0xjXLxDku144WhjgnxdJO4bmh13svHem6xKkdXcY3zCJ/TbadY57aqfpctXkptIUTIWD2VSIK
 rlkd9pHZ9612tawVryiwwAOdVx+U6Vi9LhzZTO8yAHWHBEsh6ShQWOxDoitZgWalyerriAAoDUF
 sz
X-Received: by 2002:a05:6a00:278c:b0:890:a995:1f4f with SMTP id
 d2e1a72fcca58-8bc1c7837dfmr4652726b3a.20.1794478546382; 
 Thu, 12 Nov 2026 02:15:46 -0800 (PST)
X-Received: by 2002:a05:6a00:278c:b0:890:a995:1f4f with SMTP id
 d2e1a72fcca58-8bc1c7837dfmr4652711b3a.20.1794478545943; 
 Thu, 12 Nov 2026 02:15:45 -0800 (PST)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baaae3e110sm3185872b3a.36.2026.11.12.02.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 02:15:44 -0800 (PST)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Subject: [PATCH 0/4] Add Parade PS195 bridge support to enable HDMI on
 Glymur/Mahua/Kalambo CRDs
Date: Thu, 12 Nov 2026 15:45:33 +0530
Message-Id: <20261112-mahua-hdmi-v1-0-b463d7b1dd7e@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMWR9WoC/yXMSwqAIBRA0a3EGyek9N9KNLB85gv6oBlBuPesh
 mdw7w0OLaGDNrnB4kmOtjWCpwmMRq4TMlLRIDJRcs4FW6Txkhm1EKsRq2LItRKNhBjsFjVd36z
 rfzs/zDge7wFCeADXmfYNbgAAAA==
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794478537; l=2072;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=v5XDZt9qzklAugLYWJ0KPcKjOVcV/r7Hu8yNX/ldZrY=;
 b=HVxI65GVY+yVZsqR4s5Z83O7AuyvDoKkcrQS5X7IYKBbRuMlH3g2sJZ34tvUgmlqNKH1zAwuz
 rAcO6fnb5SgB5wdTayeYX3dqiUYW7upAQ4EY11TiOa6lk9T/hj0/nK9
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-ORIG-GUID: sqFojwetvGyOfazM8dB-6WuP-OA2nE65
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0MCBTYWx0ZWRfX1d6PDaA5mR6D
 rReL4nB/CANj7GYw3m/WbU+76/em90GiDsW5z0nDz1YIwlyQ+u3XttpS3vgv3rqJqYlD3nWjdUN
 1zXz0Xagkt2sV5ffvkC83C0he4fMyyk=
X-Proofpoint-GUID: sqFojwetvGyOfazM8dB-6WuP-OA2nE65
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0MCBTYWx0ZWRfXwte5hPHXJahr
 EBSNNuzqErKYwLjgPhr+KyPw66js7gmkla38Zx+w5n4EdnQMKuK4Pc7aCxLCeHZfmDJxhAEoS1B
 AmHoxleNrYC+jtuM92ep7kMZjVxnwRQCxxBK2ORthT3IGO61MSXZLdijgYijwTytiN1aSknLSBf
 y5NQF36+o+HtADswFzfMCbuzlsUKwymaKfcNeGKtUjDiOjHy+8CPcdh7mc8x2cGLlBcHoCIAis9
 ew4pRJ6qfLxhNmFmoA9Ijf+RSFqsIhQc/jz/tu34EvpVOB6DaHjdT4xll/VpjVsVhEoDMV76wqB
 zg8pmfLeGDCOIZb56fn5addBRM+IEoaaxQXO+Bvcs1cQbJ/2LgzYA6odvDEbfcAKVcnPbVhax0a
 RoUDZfeOTe6YUDQ26+kixkyf5bc7636EHxfGjbL+ZYmJxXI2Z2chjyR9aJiTWvLvJjH3UA71VE6
 gHCH3OeHzzEQIgNWP1w==
X-Authority-Analysis: v=2.4 cv=A8b5rKWG c=1 sm=1 tr=0 ts=6af591d3 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KmDV3LX3zDEL7CZQN7UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120040
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

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
Mahadevan P (4):
      dt-bindings: display: bridge: Add Parade PS195
      drm/bridge: Add a driver for the Parade PS195
      arm64: defconfig: Enable the Parade PS195 bridge
      arm64: dts: qcom: glymur-crd: Enable HDMI output via PS195

 .../bindings/display/bridge/parade,ps195.yaml      |  98 ++++++++++
 MAINTAINERS                                        |   7 +
 arch/arm64/boot/dts/qcom/glymur-crd.dtsi           | 142 +++++++++++++++
 arch/arm64/boot/dts/qcom/glymur.dtsi               |   6 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/gpu/drm/bridge/Kconfig                     |  10 ++
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/parade-ps195.c              | 197 +++++++++++++++++++++
 8 files changed, 462 insertions(+)
---
base-commit: 944e974742c54a1d8236fe16897644c35ffd6433
change-id: 20261112-mahua-hdmi-8ee75b4fd29a

Best regards,
--  
Nabige Aala <nabige.aala@oss.qualcomm.com>

