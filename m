Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880D4CA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 07:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D86BD10EBAE;
	Mon,  5 Oct 2026 07:24:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wt2dRDyT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aqd19pKQ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0A7C10EBB5
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 07:24:40 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695102tV1410759
 for <dri-devel@lists.freedesktop.org>; Mon, 5 Oct 2026 07:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Azp63sWT2CMgHHs8K2ACf9
 MkCZDugyXiO1aUWelBT2o=; b=Wt2dRDyTnkF+pdHOpaKGQBWxScFEJqRY3lwpAD
 1jHwEZ0QfGRqWNy99WW7bBc3uaZouzQPTZ+VQG5SE/LLFg3fo2/wspwmsAzBhldL
 NBYO7iFuKfxbDebVwPPnujTns3qu2PcssM2Gwx9TIehCgHfR/cVTLnjHgdCoGRDx
 LAyrykYEDSKJ6fYL3d2DED9xadNBzqR16xo2KVQjHZ0P2Pi6t5pfIVB/af8NSwxm
 UkZC7+X7bcjpj6yT2IzIwkjtS/wItinIJ0C5JfhzWo7VoVhKffRK6csuQyp11ibG
 QH4sMu1NZcmjgvSCHD/DYoZO2KmUGi44+AIq4paeSWFTZVww==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2sr6cvyd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 07:24:39 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3a4a0017549so2304451a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 00:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791185078; x=1791789878;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Azp63sWT2CMgHHs8K2ACf9MkCZDugyXiO1aUWelBT2o=;
 b=aqd19pKQDi69lEJzUCcKuMG4W4X8VLCL8Z7RnII1mdA+Sqvhg211JbBVt3oJeFnT8r
 NxGIRaEQ0PyCJs/fDc/7jKlCDeFW31cRvvSO44G99tDi5l/Gl2zkvWklUVN2d881hleL
 5qTQOm3JpDyUhOyLUSAdSI7B3tk5hglnouqXeDBC0imaOyNAjy4f9lZRH1h6o6rIEKkD
 U5sTS9QRQmnLDH+igUJsVBzB9EkCDktmWkhqhSAdAQHJooX4Dz5B3tf52I8rGmQip2dK
 IPgfsMZY+JdBJQhv+WBfJ4xu4geyL4uxvjujQzOY7jJY0eRK0zd7R2KI6FAqY/nOrvKz
 sYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791185078; x=1791789878;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Azp63sWT2CMgHHs8K2ACf9MkCZDugyXiO1aUWelBT2o=;
 b=zttZreDN6qblvcIs3iGJDVGxKKaDKry+zXQIVCG0DAbXJ4svmddnSiya30SSrVNbYP
 0WIG/m5HvHVZpiaI67EOSsPhCz0s51keXho3Yn4UZtnAbW+SWuocJgRhbl1o1l7g2woP
 4sPDWDpsHa6zi0Vmp0iDJcbtZ4TWUY3r/hWEyfPHP18WVP42QgmKg2cqTBCgPiKAH0G1
 0fYa34/fvzckkFyJrOqI+kHSi/NUOGsidnymjx70XVxbBrjYkv6E5gCZOWVNIYYvBtIs
 CTZiLKYG+Odtu2JyODQDt03puTIAxNmo/tEn1JOms51pGzLYZbACk34JM2+4Cr82PqK7
 enAw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbJ/NzwOWnnV0UEjrli4gcZDGITzgL1WcYB+6LhQXS8xr42MI+5ZigyLu4GUhiTInUcjDjU9ENo/I=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKwyPpnWcSfhwzViGW1COaHAYDXRGz/h047yTRpoOSUpK1uIC99
 hlOPjLWxwHCHqeLijXkxDucRTAtJC0wynSE7WoXcZSNEip1axfbhPDqASoWFge6GI0NNZYi6ZMo
 UbRD4asqlKCIS4i+GPyGI3qXCquxgU+19H0o1rFsysiagxNNIF653tAUuIMLSc1giqhVBeuw=
X-Gm-Gg: AYBFou2SQMg2mjcNuZWKQLU8va9Ct621Ao7asVGahpZdQOgDVw3zxGMO0CnKmcms619
 xYDA2PTfRwGG81egDvlj09X14xR3D4qxxFanyBgheEz0IFKWoLYsM2hCldZINZCl3MI0FD0qTCH
 fb0w/Qsd/pWaB4Y+035o805MsK/JMYKP89jPsZF0ORGFSjdIEZQ9hwhKBMU0AsIhzuDAzpb7QER
 JxaDznhg232v0fXKf8EC/8Qmrtuw/JxkZHz81PpRZ/zpUUo9f37mRgRLd6moxt1knr1r1+a3CLW
 Pj9+c2Xr9cDl6YPU1v1gzoIOfg62c0FbgD68trMkbkWqdFyK2WmB5PI3EpWsmBuckZMWnUFoIV4
 kNJYlBt4jDWVAVSRZuq3fgzBtzl2aDjoGNIM=
X-Received: by 2002:a17:90b:3843:b0:3a0:a259:c67d with SMTP id
 98e67ed59e1d1-3a6ce6ca70bmr8637871a91.20.1791185078557; 
 Mon, 05 Oct 2026 00:24:38 -0700 (PDT)
X-Received: by 2002:a17:90b:3843:b0:3a0:a259:c67d with SMTP id
 98e67ed59e1d1-3a6ce6ca70bmr8637862a91.20.1791185078128; 
 Mon, 05 Oct 2026 00:24:38 -0700 (PDT)
Received: from hu-bkalkond-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a78e4f3911sm9901421a91.15.2026.10.05.00.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:24:37 -0700 (PDT)
From: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Subject: [PATCH 0/5] arm64: dts: qcom: kaanapali: Enable DisplayPort
Date: Mon, 05 Oct 2026 12:54:25 +0530
Message-Id: <20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKlQw2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAwNT3ezExLzEgsSczPiUAt00sxQzC2NLc2PDtCQloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loAjdVQvnAAAAA=
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
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791185070; l=1855;
 i=balaji.kalkonda@oss.qualcomm.com; s=20261001; h=from:subject:message-id;
 bh=PB2fJ2NPkTsLvE1rgds9beFGAFlS+6IeewjHF7IqqAA=;
 b=ZMRkJEBRxbn++DECTU2DBJxRTOxV1Zf422DCROr+2zMMUeZ7a43VwmL0EndjE+8+8i8LQuuks
 A6jKmG5MAbtDyFpRhiEQbsytABeLC1k/y/uS617BRIW3JwE+D1UbYMM
X-Developer-Key: i=balaji.kalkonda@oss.qualcomm.com; a=ed25519;
 pk=U+unGox551qPLS2mzIlN+b5cHksxTMGPnDwePd6KEnI=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyOCBTYWx0ZWRfXzyrih8+54Bvu
 tiT/me25Wxi3yGX3urwxbtqZWiOaNcK2LLZ7u/MI5Y+rJ2i1NfnqcqwQ22sq5PRjPcnjkonsS/8
 V0g+mRfPLk3Esh1bWTriDermPdVs/s0=
X-Authority-Analysis: v=2.4 cv=NaBzRGD4 c=1 sm=1 tr=0 ts=6ac350b8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=sU2yQpN9xp1-T3Bds64A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 6Gtc9uTVdKtgfVxfRpZhPeSV_QVG5yQ-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyOCBTYWx0ZWRfX+uy1TnnBFzA+
 DZW6llHHyG9pu8FbUrnOQ0HWUXMhztfNRJZDmlAWWznE3D4X/plhPbzBG8JVxsWldwbn+vwFsco
 ZOr2KTRUW1ZP0Htxu4VTrJpf16tsLVLp/NNnmwG/lVjeLs3Vrrw4ChpXi+Jd8z6E0X16Q2OChkt
 MixNMD/WQIIG74we3zB0YWV+fVDTeIRjedg91N5p+Mevp/k59U2vOtLAMF+7kn1AdmZzdOewThE
 s/X5A1bM7llZbgqrmgvb+j5BCto7r98iwFGsfGGtXlf6dqt3Z8RqYSQEn8rms1CCTfA3KVBCW97
 zShumayU05m6izre4lmBhPxwJ1AM2qa8MLSrzTVV7LSrqy7h9OCbRxx51poabIuVin7MPDYMG5A
 q2Zkui2dBe5ym2wV/iwomeY6FKsdOyNKE5SaKg7QPZ7FitxBcskSnOtb1xCIqDn6kGz2HvEg2Gr
 hbwGI6d4mtB8XM6hHug==
X-Proofpoint-ORIG-GUID: 6Gtc9uTVdKtgfVxfRpZhPeSV_QVG5yQ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050028
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

This series adds DisplayPort support for the Qualcomm Kaanapali SoC and
enables it on the MTP board.

Kaanapali has a single DisplayPort controller reusing the SM8750 IP
revision, routed through the combo USB/DP QMP PHY. The series:

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
Balaji Kalkonda (5):
      dt-bindings: display/msm: dp-controller: Add Kaanapali
      drm/msm/dp: Add DisplayPort controller for Kaanapali
      arm64: dts: qcom: kaanapali: Add DisplayPort controller
      arm64: dts: qcom: kaanapali-mtp: Enable USB headset and Type-C accessory mode
      arm64: dts: qcom: kaanapali-mtp: Enable DisplayPort over USB

 .../bindings/display/msm/dp-controller.yaml        |  1 +
 .../bindings/display/msm/qcom,kaanapali-mdss.yaml  |  6 ++
 arch/arm64/boot/dts/qcom/kaanapali-mtp.dts         | 59 +++++++++++++++
 arch/arm64/boot/dts/qcom/kaanapali.dtsi            | 87 +++++++++++++++++++++-
 drivers/gpu/drm/msm/dp/dp_display.c                |  6 ++
 5 files changed, 157 insertions(+), 2 deletions(-)
---
base-commit: f0406245cb9855e6318335a8a223551354291a46
change-id: 20261005-kaanapali_dp-f6d6839731fb

Best regards,
--  
Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>

