Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEB2CC6B2F
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81994112221;
	Thu, 15 Oct 2026 08:59:04 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2A2E112206
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:58:52 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F3xZrb2738636
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=g2LOIKPWSqLofxnH5RVIx2
 cwVtotRbWzdXgPnB3dv64=; b=lQc/6FzvBvy3z6GyVKobtHgHtUX2qoUGKyJida
 UPmuNmF6YHeTDRnr1W6HnKy4xtHQAWWyk50Xebzjhy9Rcu4nbBfa9150zGRsgoYw
 2fhvpXBnW4i2aZ3u+evUjEnnpGau+5sin3KOmywd0sMUoYiaG1sfMzQ2NMc13ruC
 rDbfHgrWib8qxDK3qt6GsMnTJuhQ9g9dtbGnouG5kOq6UOtnj5YvEbUyJ0+PJ9Nt
 bIAz//wkboz9Wk8hRQ8swcXrQj44Rcie3T7CGDcNZXwah80q3LHPUQ7XVWpvm296
 feepIPkDVbfKvvsSYlH4+G8O+qfzZbyJyfu58OGq5CLSqZTg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqds94g6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:58:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cbacbb996so815440385a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 01:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792054731; x=1792659531;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=g2LOIKPWSqLofxnH5RVIx2cwVtotRbWzdXgPnB3dv64=;
 b=NcHclg38ZmwLn1AB9pgnM0/g/OeN498a5MYyOgiNmIHiC51sGa/bI9rCd24pLBP66Y
 kXmClfF68KtXucmDxuB0VN9QHtnlmU6dtCC4V0imq3hcKcIP4BTHvmVmA6aRVWyUCUM7
 pbcyorWOgVh5Y/EJIcBs/+8peFJI16ePy1pATrMccqDuWTeOTOwSjEHcTPKl82ctKQWn
 sA7i5WsefDeXEwesOMD5EgBXLFlnWW7sKY/l6x5yPmYGu0VDn0u1PX3lIYTguZHQJdaS
 RQBPFAk+uUpnuolOS/qTjiIeJjcBqxIhnDj+Xm7mIgYlkOerQ6mNrqqrurryUoP8+zyr
 AYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792054731; x=1792659531;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=g2LOIKPWSqLofxnH5RVIx2cwVtotRbWzdXgPnB3dv64=;
 b=BeQ1JSjDb4RuPHKu1ZEl/4uAcfaBKVaLfqd750ziQonUzlTkdFLNIQSGDCLdN7v4Zl
 vAIPWucvZEFXT8DMJaQI/e8+A3MMFfh4iqvztCjz29x0nYJ4zDI2cq9YDZF1th8oM2U4
 Cqm7maF54Zh8KteiB3fdVikqYYXtrfhrAJWhH8Qvgt/5Td6OdtMVxboOmNar2MTPOoAE
 LxFqPEnFmUootk7SlM6B0BQQJ0RlcBIYdCqcPa338vDnT+Wj3ZrIB0JDExD0QCWvyj66
 xQTGk8tcPe1H478l/dkuy3o5dpst3oC8g7awVJ5LcgaeR6EzejiHWlnp9p4ZVtcv/OoS
 KS7g==
X-Forwarded-Encrypted: i=1;
 AKwUvByeZBmG8skRD6C3cV24wlAkEvMRoPf719/Sx6Kz6FaBsKoubfspFgR79XBeZ4p1cvQB51arnuMao7s=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ6/LQVAjPfL+YfQCcEioTPsU7YSQXm3OPIDRCGe8M2iCGYvvCR
 vP+SDEbPT+PA2ukvTbGg8etLNX2DCqBvS4cEapb5G52n/QIZfYwzIMIJNZHPGguJ+v6rG+2jhjH
 65FueFezqHLINNn8so1VEnPD/IqUa9eaCjBvCsU0uHt7Oipl5rvaxoCq7x6VH9BBhZDlBr5c=
X-Gm-Gg: AYBFou2ai55odGJNWjblfhaU0KRJ2I8q861RcUYgvmpUTjZxzWweobEJXEOyAevNB0B
 McbTzjMfkBQgLROtktY3nyLcAb0MpYojVJ+rUqUKYxmJZHWJWjTJNAwWo8bSkMe0Bv3K0t8A4yu
 2rA4s2qKV/YJnpzcTVNCJKKrU22DLBj5JRWPqpXHBfB/DGu26M5k8WFZHYJ1IQHA6hfgn888h22
 sYf1r4Z7noFPSVeU1/2mo/ZPGhXw7xGVg3NYwLbEef8++DmRig1Y4kJNXuN9LPv8KDvOjZyR7Fv
 ES1xE9sp+ekrLCJizka+WbaT/7Kho0BcpCv+9QQGKMmeqGRQ3KaOqF3c8BQpaoKgTxuB341+BK6
 umcWlV2o7islopbFylsHsI8+t33Vk5uItRxRT8p/Sqw9tAGiuHsy+64dXZQqK3l/7rhsdBkpItY
 xvuE1RI9MZy4Zo
X-Received: by 2002:a05:620a:4586:b0:93e:7ec0:7c63 with SMTP id
 af79cd13be357-93ebd2751d8mr2809642185a.57.1792054730622; 
 Thu, 15 Oct 2026 01:58:50 -0700 (PDT)
X-Received: by 2002:a05:620a:4586:b0:93e:7ec0:7c63 with SMTP id
 af79cd13be357-93ebd2751d8mr2809639485a.57.1792054730174; 
 Thu, 15 Oct 2026 01:58:50 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be3b51fd1dsm371590e87.58.2026.10.15.01.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:58:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/9] arm64: qcom: enable display card support on SM8150 HDK
Date: Thu, 15 Oct 2026 11:58:37 +0300
Message-Id: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL2V0GoC/0WNwQ7CIBAFf6Xh7EaggLW/YjxQWBWVVlna1Bj/X
 aomHid5b+bJCFNAYm31ZAmnQGHoC4hVxdzJ9keE4AszyaURXCig2AjNwQe6Xe0DnE0eUNWIuuO
 NM4KV5y3hIcwf627/ZRq7M7q8qH6LhPex5PJ39q+11dLiQkogHxul4eQvsFXG6Jo7Jc2mndTi6
 CwhuCHGkNuqxzmvo6WMie1frzez9dtC2AAAAA==
X-Change-ID: 20261014-sm8150-display-card-e43ee5b08c61
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2414;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=DzOAZZPP7V5LiM8vT34fJpQqdL8F6A0V377brE+YB8Y=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq0JXARHgIXLonLZHieroeOkW3Oz63AObd9Cnuj
 PzR2u7N6/KJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatCVwAAKCRCLPIo+Aiko
 1QeuB/4yll4W1X8cb3TD+jh5awefNEjJGU1yDK+LpcAJK8YnshbKfyUpsC8K0gnrNsH6EBCOJuj
 18SCiCtLR6FdwlG9sgp9LBqTzpBfFvq//iKPUbmUo9NwI+mKYIUlqAVT8L1HpyI9Z3XNw08R3bR
 UmNeYn3nHddT474pMst7IPa7lM4gkUZSQqwuF3X92CXyQEvi2dXiIpZMro1Hzywu/4dfPM/eep7
 n4UTMbp6MIXGCCGrleo7gNytWnLJjaSs9KCjhGEr21u3UjRuLVaEWkm/b9Cp9chCFgNidIrNEoY
 7Y1N4XU/+28lq+Cn/x5ndNTAVKaQz9mX/M9Ujf4aXHyoxsvH
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: eUXD6fkLfOgEdbfGXE13ylSdAxQwp7Mw
X-Authority-Analysis: v=2.4 cv=fNusTpae c=1 sm=1 tr=0 ts=6ad095cb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=4w3W_SM6jFQUSMShjksA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX0mySDDvZzp8B
 STjtIRpeO+7XL4TZFOqVEYSmD0g7EJ/410bhN+wo/6VnmGppkB40LGm7/3ZvKuAQltHEUoU8F1m
 2O9SM+WJlHs3z5SuukFsvUnafV9g/oDfOWI0xEApSLZuGpES18L6SbYS6sT2l9ijacYuZKazs7Z
 cCPaEMeqUfWthytxGZPyiTWwszC8UihZMD1z9XywIVeFvLmv3ezpXfE4O2+D59Zzo/fOi8SMKNj
 02B5Kx4Yv2vqg8tCmj7r/4UBh1vmHbyTI4Uq16GVLGa9rDgarL5H4yN4ZAhiHDk3mGodcHMVWre
 4091laN2+lKp9IR67GAos8xgi0/Q6nPT2yQHcfx2ov48hwKG782wn85ziFKjV18gtSqSIUtm5S1
 92ROkH2KaxcT2nDOKw4UZ/9yj1YIeOkQGTMWb1ty0lF3ItRSAuCxh5I+mgjW3nUqYqPXoE+aKwx
 YxVsWdrqzhQLEFf/0uA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX61Xp+DUifxYr
 YMBJSNTOPM9iXz1sErjpkfOvuf47lNE5NnbQN/tzMNzvIZ7iL47PFpSXq9wBwZOelBq4c6cSINq
 rev1Lo1ihpjkt0UTuFP0u7M47oO39Xc=
X-Proofpoint-GUID: eUXD6fkLfOgEdbfGXE13ylSdAxQwp7Mw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150035
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

The Qualcomm SM8150 HDK can be equipped with an optional display card
having the same panel as the display card for SDM845 HDK. Reuse the
driver submitted at [1] and enable display card support on this HDK.

Unlike SDM845, this also requires a new LCDB driver, providing voltage
for the panel and several fixes in the WLED driver. The FSA4480 address
fix is independent and can be applied earlier.

[1] https://lore.kernel.org/dri-devel/20261014-sdm845-hdk-v2-0-6d0b4b42f267@oss.qualcomm.com/

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (9):
      backlight: qcom-wled: fix unbalanced OVP interrupt enable
      backlight: qcom-wled: fix string detection brightness on WLED5
      dt-bindings: regulator: add Qualcomm LCDB regulator
      dt-bindings: mfd: qcom,spmi-pmic: add LCDB
      regulator: add Qualcomm LCDB driver
      arm64: dts: qcom: pm8150l: add LCDB regulators
      arm64: dts: qcom: sm8150: add MDSS reset
      arm64: dts: qcom: sm8150-hdk: fix FSA4480 address
      arm64: dts: qcom: sm8150-hdk: add display card overlay

 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |   4 +
 .../bindings/regulator/qcom,pm8150l-lcdb.yaml      |  81 ++++
 arch/arm64/boot/dts/qcom/Makefile                  |   4 +
 arch/arm64/boot/dts/qcom/pm8150l.dtsi              |  18 +
 .../boot/dts/qcom/sm8150-hdk-display-card.dtso     | 103 +++++
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts            |   4 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |   1 +
 drivers/regulator/Kconfig                          |   8 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/qcom-lcdb-regulator.c            | 475 +++++++++++++++++++++
 drivers/video/backlight/qcom-wled.c                |  31 +-
 11 files changed, 723 insertions(+), 7 deletions(-)
---
base-commit: 1fffefb00cc0b0da1f2ae24e3d33364530ea6515
change-id: 20261014-sm8150-display-card-e43ee5b08c61
prerequisite-change-id: 20260122-sdm845-hdk-9466530c4267:v4
prerequisite-patch-id: cb272273cdb260eb5049ba5cfffe13e7904e7a70
prerequisite-patch-id: 118ae0e92f82e1d5be7b75cd310509388e6f5606
prerequisite-patch-id: efe1cd41bd8c1ddf7c9491a6fca5aec877afce3d
prerequisite-patch-id: 8759433719a8151e1a8399fe88036844f60f2ec8
prerequisite-patch-id: e46e47c4d158362a382efc455438ef1fd5c95f42

Best regards,
--  
With best wishes
Dmitry

