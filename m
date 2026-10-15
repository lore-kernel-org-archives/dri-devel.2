Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC28CC6B2F
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADE4D112228;
	Thu, 15 Oct 2026 08:59:19 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19D32112217
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:59:06 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F7BXsW2121415
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nKB3HAwwUoMAANvcjYoiAe4y9aLaTkX2vWSxD+aknP0=; b=IRE9cK4Wt02FYXYN
 TcfC9ibQz4nJfFl5hJbiHxaQR58kdsHtAOmW24zga/73b1y0Qlp42u1KK/AFCrqL
 y4Cblkxh3xj8Wth3I3mZHtrMqwqRQCptPJCtO2YfGtQsgYMWCYFH2nt+vEACAKUH
 8+ua3b10WvCgafGwnJYUvwcQhYuJXMODtMhk7wKOnfGQeoSJBf4tv53LaFHIdpdw
 LIJmLsoMuPwzWV5NrZTaKKM7F/xUsflJua3vYhlCGfAmztU303X3KgDrselI2Hmb
 Ys3cDSmN/oB2AWTloUeNMUR4+HmdQrf2fUWmI1nZGgHtvkBZAJ0zMV3orBIalvIM
 0pFMAA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakwn1uqq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:59:04 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93bf4c0af4eso329096685a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 01:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792054744; x=1792659544;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nKB3HAwwUoMAANvcjYoiAe4y9aLaTkX2vWSxD+aknP0=;
 b=ghxIPa1BwQGiLT8qNOZQJ0ISmhIvrcfbi97G9QxMLF6QOjmTDPQ7QfqJl+kTTQXmuk
 cxDCp4zXM0gC1QCgB7xRzvLB3pOF2gFAhXJkLsrKBTA2LazAlg1CnjvQgZAtLNfrE2Uc
 wS/U9Xrr012DDHocd/UOhUhBK+0q7JV93Rq66J8PN0hoyX9O+ePL5wj/8BPjtKJ2f1Uz
 qi8K3e/HPPI0yqCraBaNl4BIpQSjopV+yQHt5qqh7O2Fpzii5LAwZ34Eo5D3y9fptv9x
 /32qN8PtfKF7l3Wfd2S/zeEdIDAr8pePYGZnGu3viMKdcnycW9g8a+fCFCet5Nms9PTL
 NpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792054744; x=1792659544;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nKB3HAwwUoMAANvcjYoiAe4y9aLaTkX2vWSxD+aknP0=;
 b=VlW52ZI7P96Ad/xbnlcmECk6VdJqfdf88MRM/+HV7oQ3rmye3noiz0gu7XTsNT8aVb
 vZCAfBM3NREV7rOzm8P7ZQsbH/eHFlGzwSwUw/mNAWQLP44vcCFGsp4UQnuRw7n/lFR1
 Q9wEDODPwDCMb4mAkCu5+KQiLa5/NBjRzHk8QdNVWsZIRb4Lx32mGnEQCh2bEjpR3Bpv
 1u2TElDv58m22jXVKvf32r3HzGSD198u1tK8Sez5ydrxWX4Xuv66S/TrG18WNIXm6+2p
 qJkD1a0cJbwhZO2PrDTqaKvOs9sQX+GkfbVASsfp/X2mxbaaPgzjxtGb99QMQ1hQOesR
 toBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9xDV78pH+czgqm20GzJbsInCmEYukm+sDyvsnqa9ioqjhs2nzFkPI1Cfn4pm61UBa2MZa7uFFxkE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK3gIPY7YkoF1ctSAn3iC3cEfnWFflLPRcOWZr8DjmwcRNI2wBa
 4VC7NzGn010ar9zWMkmVidUqjKcIAYWIJl3EU5I7OWR9oXwCXK3L7x3hiY+YS4XT+tPIVMXeeg/
 hCG6zYX+wmHPJaJ+MF2EJIU3rQP+UXncHJars6GFHS3ZcWfm5pjEvm+EgPbaP0nR/WTA1KcI=
X-Gm-Gg: AYBFou0Aqo3ni8hhgdgvJH89CNkuG3f/j9kwZgOTtoOX1ZH4u/z8m++T1/81VL1Ojn3
 sNuSBJl4ZZ0gR4+pUCKZwz2gszZJbX5VKZf+SUuuGmT3j4xtAtQC/i9Wp8Zac+mCyep8ta/bf9i
 kOD7919gVCvyxnJV6pMx12jyKdglGVgs3fyBhrVngD06L/PRVsVnTpiS7OPQOyDfe0gd4U6qaWw
 FYYU2LmhU/PWdVgS/zghOdm8+y2FxcWqq37abyGn7/DcrawsMlVduHjZxWSGmpDUdOEtVP7MJQA
 rj/x19aTXVsFpSm0KOpFHGR7fWVzZZ4PHl1avQlPXmPB0RZ3c3B3EK93hPnkMY0ReP5Izq+dtzJ
 pQVgLopNCvGak/2oF5Ci03K2m6GM1XKzOXWgcN/XVn6L8NaZmJYbDWrXa65OJAx7RL4QLFtrf0S
 oCrmxHSnjz9oHY
X-Received: by 2002:a05:620a:2985:b0:93e:c12d:4ec4 with SMTP id
 af79cd13be357-93ec12d54camr2604347385a.36.1792054744260; 
 Thu, 15 Oct 2026 01:59:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2985:b0:93e:c12d:4ec4 with SMTP id
 af79cd13be357-93ec12d54camr2604345385a.36.1792054743810; 
 Thu, 15 Oct 2026 01:59:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be3b51fd1dsm371590e87.58.2026.10.15.01.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:59:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:58:44 +0300
Subject: [PATCH 7/9] arm64: dts: qcom: sm8150: add MDSS reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sm8150-display-card-v1-7-5c14928cef29@oss.qualcomm.com>
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
In-Reply-To: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=826;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=lcd/P+nruFRhQ358i4WAml/LB0EcL8s1zTEbmnwyMQo=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ9aFqcd8m07PmdPRa/RC1X/HOQu9S8ms0iXHNl9mkp0aV
 TuvbeX/TkZjFgZGLgZZMUUWn4KWqTGbksM+7JhaDzOIlQlkCgMXpwBMROIE+z+lc+Yq0xUkOnq8
 V6yKXsqvqn6thMfq9NXmSs2CeleXbyv6vzbvUK37H8WaN6NVreJc1ksFT5PFM6b6/jwxVcbtP6O
 X05L43UFO0ReKTrk1f3q3eeuk8nCBzv3G1jqem7O03ZaGtWc83a4gryN1RvQWf5rK3nR/vr4YuQ
 6dI2WPP3tf2CFepi1RL+Ozk63Eme+Z6Kd8af9l2WLhdspLWEpKoybJrytyzT00Q3muo37pNmmhk
 Klvdldw6xgv0l5w+Eux+ox0xYsKPsuXz3B7oakQ2fqTPdr1u4Mxx5kVfRu3WLV1ss6rTl317lfo
 16fG9QncgiYBqfdjsgOS45Q1VMrWsBya1xprvvXf1hYA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfXyU7jIukRdfKs
 Hsh2Non260K5OrtkjrphV9V2vySldRKBCJA/PbhPhPTJKiWm9iFHlUqgtxaRVdK+mBmC3TlOPs/
 enb20qyUA6bkeXJBNHUhs4rClFXAMbUATDcbu0xa36ONegLkcl4bw6749mNPRMztnThfLC1rjvF
 ehzEH+xBiK4KeEuGhtPRRowK2B49UZzOs5tgQWTlcpKsfkFuXjJBpobA8b+NzMyU9HfgP5LzEvD
 vf1iY1kOkwtnvegDLREAXRJ/gxbuKkzVHDMt11cOOLsKxamk404IAts/0G+zhGXrSzxXF6f4fWo
 P0GMvjtuXzvXz7c9/GJOvrCzKmERriJcxP61CdbiQe3I0s4lDcwE7yfRDBIJjGfPFEGWITWvJPP
 SsXpZQhxwRAA5sMNFFx+SgrauFpALzMDqoY7+2LNOzB7v9ASrrZ8pn6OGUh58y9lAXZDJXovGZl
 RhX6uPDUBUetFkkOMmA==
X-Proofpoint-GUID: kVrF68lTLUm-7wZv250Xqynp7mOAkNQQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX4Z2F1OVSWfhW
 cv131Z8xp1zVbQgim6+XpKqz6SNTkLo/weNS9xg/XTILjzjUHhL53Hyhuqu4eGG8Bn0fXyAgyuu
 I4IXCBWOuDrBPvv/zjP2Dt59AAlpkGs=
X-Authority-Analysis: v=2.4 cv=BqUIUoX5 c=1 sm=1 tr=0 ts=6ad095d8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=Bz10KyuN3JYNdhx7gBUA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: kVrF68lTLUm-7wZv250Xqynp7mOAkNQQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150035
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

The bootloader can leave the display running, as it does on the SM8150
HDK with the display card attached. Describe the MDSS reset so that the
driver can bring the hardware into a known state before using it.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 293fcbacff34..a2d6e6947c4c 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3817,6 +3817,7 @@ mdss: display-subsystem@ae00000 {
 
 			iommus = <&apps_smmu 0x800 0x420>;
 
+			resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
 			status = "disabled";
 
 			#address-cells = <2>;

-- 
2.47.3

