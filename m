Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03D0CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 09:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B93510E316;
	Tue,  6 Oct 2026 09:50:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="R1FN5KEE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PKL/MZVR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B47710E30E
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 09:50:35 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6969UTRJ084393
 for <dri-devel@lists.freedesktop.org>; Tue, 6 Oct 2026 09:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=T9oEOBEBhJUjWH2nQll9Zu
 PtpcYhVcGfQm4EXIdM0IQ=; b=R1FN5KEEE30nDMwDoKFKY4GCY7QjCNhKdTQQ0s
 9j/40Zv44klyD9Ou1fKZYui7D79nOAdvoAc/DP262XEFdmpJTxefmynWZhYHs9ju
 56rgil2zyRuyoEdK+Nyf94iLTiag2U2BIEEnaWQeTDuJPshh8yqSupbNZdjfjekS
 DHdHkyzME4DyIQ8gQty0U3c45zTvNt6gsS1HpTQZOvm5IqIyWJYJCeUP4hBB7vWo
 TUEN3mQ1S4NulnHSqIc3UKS7PMSSFg7te4eEartGUq0XlXyDKJb8DSKhMbmilwh1
 p7JqClcK/Nn/Qe9P72eJwdGeNH+jr04eQ9ci+gPnS4PUU5jQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xdu82bn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 09:50:34 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc73895c7d5so3364326a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 02:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791280233; x=1791885033;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=T9oEOBEBhJUjWH2nQll9ZuPtpcYhVcGfQm4EXIdM0IQ=;
 b=PKL/MZVRi8qyIi+c4QMd0AayrPxg7NxJqErZyzi8gSK9UgPfyCeTyMXa/QTCr1viNs
 ZspE89tC9xQcbn3n2rYr6gu2i+UMgsnJWLvOo7InbOtP8KzdFp3oBXwCrirItMQN7cWk
 HR8AMtYw6yh0LTPsZ/t089F0PDhJ5eWHuTb4QQr6dG6LkNQkp3xg8M1c520DFtKDg8vP
 KZTW5YOfiLGy7afIM8WnRr9l8nCsFYu0Pi2avmN0hLua+nWJAlheKf6ZjIe1IJL86M9H
 uBZ7M/NDMG1Ol/bZ35ROQfj/a/8zRVRtwz7To/u492CDIGbP165t6+eeL8ZQY7W9c89I
 nnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791280233; x=1791885033;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T9oEOBEBhJUjWH2nQll9ZuPtpcYhVcGfQm4EXIdM0IQ=;
 b=j4zjO0e/q9xlg+qWoPezJSoF+HlB0tTtWSimBRjTXeCaON9/4hJ8KWYQdO+f98v7JS
 QGaJ6Vzir5sVhBzHsOav+3j3F9aKdlLe1VvhzSOlserNlkKKRe8gzJ4qiRhltJR6AUtj
 AQXsnX8MS4IBMf9svWCTaNLNEl0R78awS5hKrhxajGH5dhSQHn441kvbe9+R1ucWdamo
 GG31w+MI8cBxkVh77NEURc2uizl9bruBYhsmc02L3EycaerQRH9I64+xGh+3a/fP2aH7
 +K6vP4qGZPJHFgI+BpWMRvWwnP8MslxvmZvSKjuTy4kfpGb5cmbHoEUpim/Tm2f1KHBU
 qBGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+EjMSKsiBmGhZuw/ne5hJEw0pOuSGM8doKjmz+q7MYThj+oE9S2fWF3/iNKeZTwj82r2bmJVnnEI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nwctzTGibYZq0fIcvM0QDgHdI+UNHVmNaksnSvJGOBdnJFwP+/
 gvc4uoePZaW0IKx0Zy6D2V/Wtq8DYWr4rQOZRi0Ov/3MdvxZ+E0GpSEtVwj9TqvLRRq9xdaCNBT
 Qd+0qaV0EFjDX03cD25sWJC/39Mx8CohPjzBB552d4v5a12dqm5rLTbzf3ni1gbYJ4AWM9hk=
X-Gm-Gg: AYBFou0NVQ0zUx7BmB0XlrxoAOy2A5zQty1hKuiNO2Z17/EBD1YOoLFqcqh1wAsKtnJ
 t31NdQxkZo+MR3jDE84ywPvar0IVxo+ID/EqYZNVU7ladIK/phHGBnfMImtrKMOastAkLK2iATs
 fU01xAjIUbUiWMl3qsfdVqJ43Tadk3EMFvyaQ4fiyyHPRrs6IGRMAdL7ixEu+bgVbSzDBqFVluC
 SOFOpUkcddxykyOrNikeoCznZjE2p1ZEEs+hRywrmr8MeV1cOzu/5AEonWIONHHY7xmO1WIwk40
 kBMjXYD+fyMdBBCbKfqehcW53Tokck5LZedYQz3Fe5ue3B9MIemNwwQ3gHWBVSegO/Ygof7Qd0y
 qTSdzeSxP5LK9XBH/vraDN9e6CfyHztyfNkF5G95Xtvju8YjqcQHZsZoF1GZl/rq+
X-Received: by 2002:a05:6a21:495:b0:3e0:c961:b5bb with SMTP id
 adf61e73a8af0-3e0d6baccdfmr8945970637.66.1791280233456; 
 Tue, 06 Oct 2026 02:50:33 -0700 (PDT)
X-Received: by 2002:a05:6a21:495:b0:3e0:c961:b5bb with SMTP id
 adf61e73a8af0-3e0d6baccdfmr8945928637.66.1791280232685; 
 Tue, 06 Oct 2026 02:50:32 -0700 (PDT)
Received: from hu-ggarmidi-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-890acde961asm535523b3a.61.2026.10.06.02.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 02:50:32 -0700 (PDT)
From: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
Subject: [PATCH 0/5] arm64: dts: qcom: Add Microsoft Surface Laptop 8th Edition
Date: Tue, 06 Oct 2026 02:50:26 -0700
Message-Id: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGLExGoC/yXMQQqDQAxA0atI1g3EUQR7ldJFOkaNtDpMnCKId
 3dsl2/x/w4mUcXgXuwQ5aumy5xR3grwI8+DoHbZ4Mg11FaEHx4To6XYsxd8c1iXgMTSdK4uW1c
 T5DRE6XX7bR/Pvy29JvHr9YLjOAFUIl2heAAAAA==
X-Change-ID: 20260930-mahua-surface-laptop-0ae6d2419240
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791280230; l=1985;
 i=gopikrishna.garmidi@oss.qualcomm.com; s=20260102;
 h=from:subject:message-id; bh=vBESHexR1XlckAAiOTO635W5zfqoyXyDw+1NzmtYhMc=;
 b=MpjB7a8GEPa+bcf+sqbcNhELpb0WjJ6AVsq1tEC4UAa4FYFSazy2XGawD33zmxlL91PNp71EB
 RgnGVVJjUHRDSkVNiufFUiVVG5dYJD2zlInZ5ronm/jz+Ile7EfYQWt
X-Developer-Key: i=gopikrishna.garmidi@oss.qualcomm.com; a=ed25519;
 pk=TkSjNEhrfsj90i3wkABTZtAjLNr2cfYsujaTvyOIDsE=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzOSBTYWx0ZWRfX9W0H7/6zzL/a
 +UHE63YgD3cOlUHLk/MKJlrzjIVnqJ3zu7xRhjMwxuon5oqhQBzAAOkRlOPiDUhqJvfQFXuTJSA
 piKtmgoTRKXIItz7E5of1SWcOZ60XiU=
X-Authority-Analysis: v=2.4 cv=NshE4MdJ c=1 sm=1 tr=0 ts=6ac4c46a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=6qiGk_Zo5UkJWkwZqDsA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: SGGaL-RMxc4Y30wWorTzb8yww9ug6wMS
X-Proofpoint-ORIG-GUID: SGGaL-RMxc4Y30wWorTzb8yww9ug6wMS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzOSBTYWx0ZWRfX1PPdd4DbpK+R
 ppNI6joz/NVS7oMQZaostTbtJXLJ4DH1dS9RWVTgeYsWx4h+tdal7P05Fa3dLFDA4986dQC9MiO
 2nZdTFhvwtZLsucOPmz2jg50JeE3bwTmKeSMMYAerLrNlS20G/9VO8hJ6IzYEEVryDZ/f4LWcRU
 ZgqwHL3Ai5hU+eZgZMQOFaObXa0tLNLeyDPw72kEbAroZc1i8cdVeVfHVZOyQNko5l3r7ELovNH
 BFkqFGiiRzNoSufvWnS/XWlwqfKKco10Waoz1dHcJSJss7zL8oEazgCx7OE4OlOl9vCSuXBlOMz
 CmsXEadcGnyWkaQZL2KNwdC/OmQpeOWY8Mi3CKK+2vzt7FjEbbnxHHV0vJPn9617W4VbBCtb0JS
 OiBJgDoboIXcFr57rDb084HAwZR+u7QjFu0I2PQhqJ1dtafnMCDXdNe0uECZDPibZsgpi0h49Cj
 PWrs2RHrSttTAewWgkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060039
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

This series adds initial support for the Microsoft Surface Laptop 13.8"
8th Edition. It's built on Mahua, the 12-core variant of Glymur with
cluster2 fused off.

As on the Surface Laptop 7, the keyboard, fan and platform profile are
handled by the Surface Aggregator Module over UART. The rest of the
board is close to the Qualcomm reference design.

With this series the laptop boots to a desktop with rootfs on NVMe.

Features enabled in this series:
1. Internal eDP panel
2. Speakers (2x WSA8845) and DMICs
3. USB-C host and charging on both ports
4. USB multiport controller behind two PTN3222 eUSB2 redrivers
5. Wi-Fi and Bluetooth (WCN7850)
6. NVMe
7. Keyboard, fan and platform profile via SAM
8. HID-over-I2C touchpad and touchscreen
9. Lid switch
10. UEFI variables and RTC via QSEECOM

The QSEECOM, SAM registry, and panel patches add independent support for
the board or panel and can be merged separately from the DT patches.

---
Gopikrishna Garmidi (5):
      dt-bindings: arm: qcom: Document Microsoft Surface Laptop 8th Edition
      firmware: qcom: scm: Allow QSEECOM on Surface Laptop 8th Edition
      platform/surface: aggregator_registry: Add Surface Laptop 8th Edition
      drm/panel-edp: Add Sharp LQ138P1JX61 (Surface Laptop 8th Ed.)
      arm64: dts: qcom: Add Microsoft Surface Laptop 8th Edition

 Documentation/devicetree/bindings/arm/qcom.yaml    |    1 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 .../qcom/mahua-microsoft-surface-laptop-8-13in.dts | 1180 ++++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.c                   |    1 +
 drivers/gpu/drm/panel/panel-edp.c                  |    1 +
 .../platform/surface/surface_aggregator_registry.c |    2 +
 6 files changed, 1186 insertions(+)
---
base-commit: bf1ee2bd5c2da8992f33c8950ef194aaff74ed6c
change-id: 20260930-mahua-surface-laptop-0ae6d2419240

Best regards,
--  
Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>

