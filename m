Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98756606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NgzRx0am;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L+3Aojm6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02C86112474;
	Thu, 22 Oct 2026 09:50:15 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DBFC112479
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:50:04 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M95x8s3305784
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=2QkaBLLPRsYQoGth7j16Gi
 +5UCkKaxN5I/4+4Qhdpdo=; b=NgzRx0amTvoeC83cyCtRJDW3g5smBPsEETMB8j
 nyaNdao93xa5+c0DXq7gMrIBqD8HW561AM2eUEPrq9EfvQqqxz4mghw8x+NfwjBJ
 W3jBYoIgCnvjg9/VIEpiBb882SRzIuswfq+uHKoFSqWTdMYasEjeS06SVmd37gqX
 JchlJWwB+6JzUXMLigXPlCUtIMYqTHJYi9AFyO4gpeJGTmmNDeGbLalU3L0RzPaK
 745xjZNE9m75aQAqNjE9D4Y1+xqmVFO1D2VZ0H/2+wguDw8iY8yrZlA1A62UMqHe
 jPdaKnHfMfcZQCes/OXqZuxRGNJem6RSPm1M4RHwoNhxEo5Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93asqqc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:50:02 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so2818810eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792662601; x=1793267401;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2QkaBLLPRsYQoGth7j16Gi+5UCkKaxN5I/4+4Qhdpdo=;
 b=L+3Aojm6xVhsFjyFKYVofB1wPs1RjFoHU4+uqD0lItat857uDX4JGRNq2t4Izd+kYI
 9Ka+l7vPpuSMilh37T3e4OdTHnm8xjGN/VRTeWUwi0VAhIOWCUCVqsTbirfLlSnqLv+6
 DvlhuAzf9aZ7p0HD7WBDT6bn/cun8nCgcUV5gy4MdtrPrkTY5OBbLaYUWaZtCFqFU38s
 a4RODvOg4NSYrAQmqhxGIt+VmY+n42N5zRfD6dZWDbi/UHM53xRFi3BS7nLwdvc7Q3iL
 3Iz+yq4b9n0d2+IFlSFv1Yr/WBb5hWYADXyekkgr+37uWsiU4dO70W7LfTrokC3ZOKlC
 yapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792662601; x=1793267401;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2QkaBLLPRsYQoGth7j16Gi+5UCkKaxN5I/4+4Qhdpdo=;
 b=s4QxbkGdDM99w70SmRjYSb55Fv+gVb44t64uSVH3amihcc/wXiOnjVZjLBaTJtRbyR
 tFahUNnG0odg2qnp7BpeHtYEYxaMpAcv739HWaLMotH8/Rgtsc6R/8t0PWf4yJ1IdCe3
 8g5pE+lcEGMelx77aWmEgPfit5ObEEC+KAJuMDIM2q1XNASQ44XUbGoCN4FEKgihAEsQ
 nLh9z6Mj9bvqC7ItSCtU1FeG48vXE653Dxl5h08yyWZquw+Z14UkfmOCfLUIxw4eV3JG
 Alwyiiqxc6NLLijgsgwrXantnsDnFbObF0G/T7YGHkn8644aaPMUy1WB3JdWZhH1eKKX
 Ki4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/ryUGpGuJbTx9Hsvae61GEmzZ4lrR6QGvNu3t6wfbjbOBn72J0gfKkLhZsEryyOf6p6JeUeZQycU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKbflf2GjNtEaX0ylWqYYBVHBIzXrJVRD9mHk0z3KBgZLaI/smX
 zcaTxpMWM8KlvMDHYKESMrv7CeyRARo8urf1gDcpQca/fc7Lf5OnGTerxJra7W8/J5CFl58GsLI
 4PjmzMcRsVHUaCr9Q+vD1jhkGPFaINkvJmwrFkKELX5/JxgmbnwueK9tnpB0NO7XtU+J74vE=
X-Gm-Gg: AYBFou1iPyzPgOSG5Q7WJFx1D72ztW5jhUbQne88GfClOtmYSIxTR+lIs64vDeHyInP
 AQBHu7XBbegq1DLDk9W49rHPSpam17N5OazZE8zbHUT+moAAPjJ3V94gpWzKR0DReFSOmrBU4Iz
 tkkalHyq55g5QcP6CeAKPuIRUwYjKi5KoYabgLfoXzQR5Qb2BGryhlFzJG5C0fHmC/uH1qqRrlz
 BwuyGx8Hzm46o7ETWM2ZLAoASSr99Q0fr+XAI0Ws7TrUHAMO6NbxeJHjCXV4Uz6ADlRm65jPHQX
 fch4DRps4UWjAqsezJPldt4SbmvklsVN+kI0rZ5NL9oDGzwFfrR+zv7yvl9fSy5qXkH8UAq/Es0
 qY5mA9PIGGDTMrX7lEPKi4rf6hS3pdoO8lX8=
X-Received: by 2002:a05:7301:7308:b0:353:7d17:9a86 with SMTP id
 5a478bee46e88-3674d447cadmr5794752eec.26.1792662601036; 
 Thu, 22 Oct 2026 02:50:01 -0700 (PDT)
X-Received: by 2002:a05:7301:7308:b0:353:7d17:9a86 with SMTP id
 5a478bee46e88-3674d447cadmr5794697eec.26.1792662600223; 
 Thu, 22 Oct 2026 02:50:00 -0700 (PDT)
Received: from hu-bkalkond-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367417a2fadsm14418035eec.21.2026.10.22.02.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 02:49:59 -0700 (PDT)
From: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Subject: [PATCH v3 0/5] arm64: dts: qcom: kaanapali: Enable DisplayPort
Date: Thu, 22 Oct 2026 15:19:41 +0530
Message-Id: <20261022-kaanapali_dp-v3-0-b5ae8e6083c3@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADXc2WoC/3XNyw6CMBAF0F8hXVvSUqngyv8wxgx9SJWXLTQaw
 r/b4sYY3Uxykzvnzsgpa5RD+2RGVnnjTN+FwDYJEjV0F4WNDBllJOOUkBzfADoYoDFnOWDNJS9
 YuWNUVyi8DFZp81i54+md3VRdlRijERu1cWNvn+uep7H3h/YUE8w1KBAMuMzLQ+9cep+gEX3bp
 uGguOCzD4N+G1kwBM1FVTBZ0i35YSzL8gJXwsfIBQEAAA==
X-Change-ID: 20261005-kaanapali_dp-f6d6839731fb
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792662591; l=3513;
 i=balaji.kalkonda@oss.qualcomm.com; s=20261001; h=from:subject:message-id;
 bh=Ebf9YUT2+AQzu0QYDkw4+3IQKi3e5KD+tNJ6G8A+yUk=;
 b=a66fQygAG0DL36lsBctdeB0Ui8HZn5GN3FSxd6e/yNwTH91siuJTIRbIkqJmYkvIkEqH8ESKB
 C8wj+nmy6CJAk1jGrGuas4HnLav14PfNFYIoZhbwmfQmrOVSmrRIZgX
X-Developer-Key: i=balaji.kalkonda@oss.qualcomm.com; a=ed25519;
 pk=U+unGox551qPLS2mzIlN+b5cHksxTMGPnDwePd6KEnI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzOSBTYWx0ZWRfX8LZPX5ajisCM
 vRmIBSriZG09S1FAwmd0tUvtuIoXqc4jGuIuweo+t1wPAhO2kusIPcAD+bMGlG0HJViZsiAhvPm
 nLuqTmvcxRDMzrOgrH/OCDEEvBfj32+cbQvP3fn4qSLlPhr70qlOeVu9tFoNTV8hXIIY+5Qo1jf
 xgRWVFRANId/yfs3Ze+moVTmU49oNAJbtG6Slo1PKdoSDCjlM1zr2YVbaLExX3xetL6ixmaCyTi
 jrIYPmOKrZUEyvrVnuV5mM7Ki7E0AQm2XJXcOpKEaxJtu2XcRzzxmmbvOr+zbKSi99/OZT8TsgK
 4U/3eNCsaQnOEewfP09trIj4gzP6yexti0r+sr6EH3j1BM802L4x8U2mHTdWHttZti364Q9Z8aa
 yn70mUya6iJriGjYGr/f90RLwZAiQNBLVLz0IWZNkJ7xEDpyDgbFBaDgX1cJ6ieUZECtNGfVSbh
 S2QE3YOIRNRl+WPaxcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzOSBTYWx0ZWRfXzgbkjLQh7TnI
 +TdcIxfot5u+ukeZ/JjejMSLiVSn6SI2FoiRsRx7nNeq+TY7SOVih4jplGk/0YMlAm+Xc7NR0N3
 0ypmqZHoGGvWeERF3ggAnUzDpBggN6w=
X-Authority-Analysis: v=2.4 cv=QPn91QLL c=1 sm=1 tr=0 ts=6ad9dc4a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=12Bw4pmKq0hGIMEmf4YA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: KrlXO4sCBB33NF-9At4JJ_tWrCkzgGIq
X-Proofpoint-ORIG-GUID: KrlXO4sCBB33NF-9At4JJ_tWrCkzgGIq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220039
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

This series adds DisplayPort support for the Qualcomm Kaanapali SoC
and enables it on the MTP board.

Kaanapali has a single DisplayPort controller based on the SM8750
generation DP block, routed through the combo USB/DP QMP PHY. The
series:

 - Documents the new "qcom,kaanapali-dp" compatible in the DP controller
   and Kaanapali MDSS bindings.
 - Adds the Kaanapali descriptor to the DP driver.
 - Describes the DisplayPort controller node in kaanapali.dtsi, including
   its OPP table, clocks, and power domain, and wires it to the DPU and
   the USB/DP QMP PHY.
 - Enables USB-C audio support on the MTP board (WCD939x USBSS Type-C mux)
   as a prerequisite for exercising DP alt mode over the same Type-C port.
 - Enables the DisplayPort controller on MTP and advertises the supported
   link frequencies for DisplayPort over USB-C.

Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
---
Changes in v3:
- Merged the Kaanapali DP resource-count constraints into the existing
  2-stream MST conditional block in the DP controller binding instead of
  duplicating it (Sashiko AI).
- Added the missing additionalProperties on the displayport-controller
  pattern property in the Kaanapali MDSS binding (Sashiko AI).
- Fixed the Kaanapali DP node register block sizes to match the actual
  register ranges (Konrad).
- Removed a stray blank line between the DP node clocks and clock-names
  properties (Konrad).
- Reordered the MTP DP node overrides to keep &mdss_dp0 and
  &mdss_dp0_out alphabetically sorted among the other node references
  (Konrad).
- Link to v2: https://patch.msgid.link/20261015-kaanapali_dp-v2-0-c15cb83d9140@oss.qualcomm.com

Changes in v2:
- Updated the DP controller binding patch subject from "Add Kaanapali" to
  "Document Kaanapali" and rewrote its commit message to describe the
  standalone compatible and SoC-specific resource counts (Sashiko AI).
- Updated the Kaanapali DP node to use the MMCX power domain (Dmitry,
  Sashiko AI).
- Added the missing second DP stream support in the Kaanapali DP node
  (Dmitry).
- Expanded the Kaanapali DP node commit message to document USB/DP PHY
  mode switching for DisplayPort altmode (Dmitry).
- Extended the MTP USB headset and Type-C commit message to document the
  WCD9395 USBSS mux I2C bus frequency of 100 kHz (Dmitry, Konrad,
  Mukesh).
- Removed an unnecessary line break from the DP node clock parent list
  (Dmitry).
- Link to v1: https://patch.msgid.link/20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com

---
Balaji Kalkonda (5):
      dt-bindings: display/msm: dp-controller: Document Kaanapali
      drm/msm/dp: Add DisplayPort controller for Kaanapali
      arm64: dts: qcom: kaanapali: Add DisplayPort controller
      arm64: dts: qcom: kaanapali-mtp: Enable USB headset and Type-C accessory mode
      arm64: dts: qcom: kaanapali-mtp: Enable DisplayPort over USB

 .../bindings/display/msm/dp-controller.yaml        |  2 +
 .../bindings/display/msm/qcom,kaanapali-mdss.yaml  |  7 ++
 arch/arm64/boot/dts/qcom/kaanapali-mtp.dts         | 61 +++++++++++++++
 arch/arm64/boot/dts/qcom/kaanapali.dtsi            | 90 +++++++++++++++++++++-
 drivers/gpu/drm/msm/dp/dp_display.c                |  6 ++
 5 files changed, 164 insertions(+), 2 deletions(-)
---
base-commit: 9a482184d910775cf648863148944945b74e2815
change-id: 20261005-kaanapali_dp-f6d6839731fb

Best regards,
--  
Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>

