Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2D3CCF2D3
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4870610EAA0;
	Mon, 19 Oct 2026 11:26:19 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8516810EAE6
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:26:00 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Oxhi1168075
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Tii5RYXORarOGXzAnt+Gm5B0QCr3yXhEhRVEbLAopUU=; b=CvS3tH42DqGAO8BI
 Rgd088K/7wWEtXO00Pdw3OQhz+id7l5UcTms0iJUwBKSz2CueFMhT6f5Qp2YqDX+
 wVFk8iKh56t/a+kkjScibD1zNqWAJyVMLRxtVFstOxZpT30a4BAcXsSmQEXNdAI/
 ucPj+TPbkS3Z/mylFblUeowjss/ExtZGLk6VftqOpdiQIE4rUFQ9bDy3ROKDceny
 mMpzzIes4BrkSkZ6CMfPucSjR2TRGokHMjyXzb0nHG0GxNlfj8hN0cDItZyzJR+N
 t9YZS2YnLNU4/W27y7DTyoWRtQ4HteJw3KdINk042JNLocKV6JbZPSrTir7F/ulz
 qQng2Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf5c8tgg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:25:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93dd3c3badbso479254985a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 04:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792409159; x=1793013959;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tii5RYXORarOGXzAnt+Gm5B0QCr3yXhEhRVEbLAopUU=;
 b=EHFFh3kOKgEwiHz3aMWoI8qj7hwy1FzWh7o/bxZS1P6R87MVtSyX/vjJDd0p4TLOZq
 o6mAACbu9XcNvKNgJZe8tYKJXjhgk8hBuQYZ0e8iBWSZOA3FXcE4vVJt4RjVQDxKx4+T
 LQWysty463mn/jxf+KCfC5neVAPhrsPE+EfXz2ZPOrapchZEtOeoU7hzlz14qWAKg6LJ
 zkhxiY1kpqXtSPAgkN1DZXCVrMFGl+l1yXFYjzPeY6Yjq4WcorGTU6RN8KUWjKaTem0a
 Ndq39/WL00i85aEwO+fZFp37bN3VjwMZGSAU5Rl/nF5uEwXO9SEapi589q6+HPxeaUMg
 WzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792409159; x=1793013959;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tii5RYXORarOGXzAnt+Gm5B0QCr3yXhEhRVEbLAopUU=;
 b=iBl+XxYnkhunWttc9Eafg8S5MXVF7q07VApo6hL+1tlBhtdfj6ZxM/tOOm6DAK4DjT
 MPBLjp2ySWh3hCTNYeBAmD6hENzFZMP4ZItgixi/Fohh19/p7HKMscJR1VP/Xx7ss66H
 s8EUvzhcuUN+7QqNxzd/xULFcL6xCvyEEvmbvfQaB+Kv1kZLNStOJ/RWA77JHHN613UE
 3mBssmR4+gE7stNpP3YYh3uw2hOQwXgVgkfp20RW+wRI5K0X0Cp1MwC1uX+Rc86kafkl
 98sIeDvNHePhTzh0srs8AH/qDadWxPeThoVrQNdyE6eYOA1lhp0bwi3oBjxvEFpW3O5C
 TP2A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzoHEqH8hpzGYJeL6Y2nqB5hpLTWtZ3cDqyumo2tikQeAfvpazAwlxgsULPLXqzgf4dtJDEUoKpclk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKqBD17m7Zk7q6n3bz38Bm5fMRR0IJrir59e6qIoN281EqqhtIe
 Lr8YY7tYQkKgqi22qobQcbpdCj+QYcYH83mp1BFSSSO6TbbBXbEDyfz8RcxOS6sSr9N/C6avpOm
 ZQCIyiRei5zFgsY6lWdyiFb6xmjtKcl7iWEhtINMqarAiO00IbcFTo5o7a2Fsob5CJu+QMcM=
X-Gm-Gg: AYBFou2JFl1FVjod5SbwGivRwDJKt0nTCncfDp/FGoP+cxyajQutSl4Wf8ysUJ+frsS
 KUxUBicTEmioHRo48UOmbkRfortpmXhHaX+7I4cgl0P6NtZiSJ8oIXxgLabStKFuyaUcMKA8A9b
 09Fqut8qOEC0sen0oLm9qxLI796gXwI3ehPj/r9xvjD1PM8jAguBOMxwDyZp9/vc80dAeUezSNB
 W3LrgQ5JuZNOZ0XIQqV1p3DkZCpGrgrn/SmHmN9qVIqcOirDwL3T8lvtOTC3j/q70ZZr588wwg8
 4/5DJ31poOmz5NaQivhiClcv8m7HQE4dsats3QrCv0Rq/rWX4jeitXMCnwpSi3RtfYsS/39mtY3
 tzj3xHSBCPBMUMZNLYJdqCfGELXfO5ADU5dWPukCH1Mbh3E9NXXIKPCpL2HuQGgwvgDCewUL9kl
 fGfKnhXkTBFNOS
X-Received: by 2002:a05:620a:46ab:b0:93f:43a4:a48c with SMTP id
 af79cd13be357-93f43a4a64bmr140650185a.45.1792409158953; 
 Mon, 19 Oct 2026 04:25:58 -0700 (PDT)
X-Received: by 2002:a05:620a:46ab:b0:93f:43a4:a48c with SMTP id
 af79cd13be357-93f43a4a64bmr140647085a.45.1792409158481; 
 Mon, 19 Oct 2026 04:25:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab37ba8851sm12807621fa.22.2026.10.19.04.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 04:25:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:25:41 +0300
Subject: [PATCH v2 5/8] arm64: dts: qcom: pm8150l: add LCDB regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-sm8150-display-card-v2-5-86c05068efc5@oss.qualcomm.com>
References: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
In-Reply-To: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=926;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=/1u112Fp/QaTfq2TFsBWcfozg9TsLnTJMmUIeYDwURA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1f46xEAVvhENHT5/cr5eUC0J1Mz7Mv7VIO563
 Lrnc+EFNdyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatX+OgAKCRCLPIo+Aiko
 1UrkCACS72+7BOx9ZN6pTVSh4/cHz0fgq5dzxAulElxL6MTXCmbF238hFdvgoNdU5jtEncQj2Ss
 LIXQ9uOyDDtaw9N/usGH+no2wTcyPDCOo4uF63tPwaqL6it15DOogVtzq+L+8lYnJP2aSaXT0TK
 gYdvgG//oqkXLvJry2SYpNrQ80RmrtbGk5gLa8kA/wCbVnAwQw86P+D1C+QuK+Gt0s72HPfmdg9
 6m3AZY1EAb18yEAkXmK8vTALtOC5KvM7eIubzahCz26PTHU7dE5v5n/B09JcMbEurqn2f5ylspj
 qrHYCo2aLzqptIZDJl64ddZtb1TR5gQwm/ltogPmQ6msJh4D
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfX99tlZyE4HiDC
 qjCYgmporoyfKVyysUNtBHJHeBZNNWnixFU5BUNNTO0Axy8p2Lu+MBQGKtQIvOjNa9Z+V0Mr5IC
 4hIjegILHxMCc25BWnvFcGnNvE2CHVo=
X-Proofpoint-ORIG-GUID: FRbHT6n--vedv5kWAs8JUOELHyz8SKYT
X-Proofpoint-GUID: FRbHT6n--vedv5kWAs8JUOELHyz8SKYT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfXzDYVPhXBOW9y
 mvB3qsHDBIvDgdhemKhVR33hSGYuX5zGA7nl4zOxQxXfpm7uiefNpyHbvVg7kWGpNipQN7RvlOS
 Gky8HtxBSttz4KKd8SdNKBGhvsMy8wT2tO7epgRhCkmKjdqAhYecp530CeOnoy5Ys0ERJyWGTqx
 q7vsiXjf6gkTRONTkvVjMFklpoh4Ph8kfboGPxNLGSmVe6PnJrMGB86r8jPo5uAk8Okee+h5cWx
 bMusMb7Ie2mD1C8voPatOm58XG2h2yXll6hpkwpqEMaSlw9r+/h3RM3pt2C3ZQLGx0S/6MwCovj
 FT7eZyIPAaHhiStwlyS7CARysGRnm+SQuISAAKav7slJ2d6FnpG0KraSQXKRawoTBES/DQUhc78
 VD6wmE7DICs3UPhZPZRg20vEmHGI3HynEUOuGTCg4LmHtLjzP0Te59fc43AwMCvdK4sotVn9exX
 y9jZv/2u1mZjyGSJ8Ag==
X-Authority-Analysis: v=2.4 cv=K6O3jCWI c=1 sm=1 tr=0 ts=6ad5fe47 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=iSqtJsaWCaQ-tE2kz_kA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190045
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

Describe the LCDB block providing the LCD bias rails. Leave empty
regulator nodes, forcing board files to provide correct voltage.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/pm8150l.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
index 3911d6d0d2e2..8d2136d165b1 100644
--- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
@@ -141,5 +141,19 @@ pm8150l_wled: leds@d800 {
 
 			status = "disabled";
 		};
+
+		pm8150l_lcdb: regulator@ec00 {
+			compatible = "qcom,pm8150l-lcdb";
+			reg = <0xec00>;
+			interrupts = <0x5 0xec 0x1 IRQ_TYPE_EDGE_RISING>;
+
+			status = "disabled";
+
+			pm8150l_lcdb_ldo: ldo {
+			};
+
+			pm8150l_lcdb_ncp: ncp {
+			};
+		};
 	};
 };

-- 
2.47.3

