Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00847CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01DDF112217;
	Thu, 15 Oct 2026 08:59:19 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57A98112206
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:59:04 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F3wZpv1889496
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xu2033LaBmqkzJxlbTL1PZOWfNlBEA8awrj2KAxUyVQ=; b=RtWaKqVIjcDIizuw
 TX1vXJvc5rRosGwFQ92VouUUmdyixXJQw0Ga7e5Apn5K02TIwwAwl+SBg5O2LTXa
 G9CYty/nlw8Itaho49agNiT24IatQZnPzPAu3kxWgrqnlQ0I2ExWobrBDxtMikbK
 Lb4h7ido9NJthtwZqnFvKDgorUbXlExAld6kqliIPQ7aoS9eIjvF1yYXpVsct+Ap
 jW6voNqnWgxJXfz6BpCER+Qhlnn9nzuUkDVSy1SaKC0J7wUBMm/JQzywqwwEb3QZ
 XW0eRQy+fV6Gg2RRE5pAIRAGWz+7JDmAjqMRm2aiBONYlIY+iVGhr+OlgkqTZDdM
 GNUxdA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqda14y8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:59:03 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91b937ecbb4so67485076d6.2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 01:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792054743; x=1792659543;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xu2033LaBmqkzJxlbTL1PZOWfNlBEA8awrj2KAxUyVQ=;
 b=GcEFuRI4L1epj0dOT5p8COzx3pNxZ1Ockgk7Szc/sSo8zqDGF5cujUTUW6U4JGZLmw
 MOAXrjEC36HKvCHoQkkJBizbQqUGsJ1Uv4dcX+GpTwh9e4w7jzS1dqby3oXgb3w0SEnH
 vmO3/shTV+hNeBh18xCuHBwbB2nHjCecV1ylVIJ1WPzVzrZnD0PGrAoX6OgCJ7qYWRRH
 Af6EdAApKx7MgGiFd93YYL28OK5SEl5NvcU8kP5AUeByIE/vfTmn8ayKObYxp1effU7l
 kKF1uYN7vI/usWvJ7QxxN6LTdB1jzcAEa5DNdIIQSFM5JI3MWk/vcRvseLP9Ymm1rKuL
 jMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792054743; x=1792659543;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xu2033LaBmqkzJxlbTL1PZOWfNlBEA8awrj2KAxUyVQ=;
 b=Gf6OA6HcEEomswi3+4ZQ4C6eF7bvpQzVJ4Mv6T6a4jJ+xZlPinSDz/sPIuF7sFk7gc
 FirFlA/2gnf+N+Hic2kwJqQd57IIDIl57URfzgTXmUp8uI06KnUwMw+7yPn5ipudSJ38
 oZCvbyh017sE+xLZTqtXlRL7rqjjTDyGAFXyGgrH3TXGBhFm0ALb3HykD0SJvlqUYDeq
 gOrNAVIKO7vkZSqcRGoIqmc1pRCKA/dmVJp+XfYLuuU0uI6nFVYsNA7wnnHmdR7RVMrV
 1kz1gTCuDGComw8Mk0iBYQ5UPWm6R91ux78frr8SjtNXgu93mbChCeiWll94FlfelbdQ
 BQdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFg8eNgUaRiLxldl2iC6We9FjxIogYoNI7Av9BGQ4JqYtsGaX3bwzbJ1qrfzklFpo6D2VsdalkSvk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIAdfGOS9n8TSYC9lMsUcR+SVMxilu8oppWmKbOwhfmTdRpwy9s
 nlyyX8VaaNaaEEzm+r19cEpDzggFuh7k3vKvAlLQy009vNKDhZO0PTp49/DIfYc21HQU68Jes87
 kxtJPkWQ7hkPG99BQ1sPGpk0ZieLp0m7V08J7yBgpGyce3djdRHZHiUzSOsNoWRdcHfCXCQY=
X-Gm-Gg: AYBFou2c9ywxjRBOoayO/QnkZKVQEXB02DoZFm6FrtDHN3U/x7k9CpcD859UsjFvCrQ
 V95BqQoVTSwxGhR+FeoZYiF+F/PqAJBqq8UY61WMJzlMBiPtCZ0Ln8QU3o3QmfPg/+ikIVdwb1A
 2jH4kIQuSRIplFy8g42XNEJlmibytGAbcjOyvFldARHGVD3hHUyH1dRWFIwjgaORsBYPdYHJN7Z
 K8e7FXtsS97iPhFyLdszU0zIXvSqcxRcNcSnsy5DlHteV3/k7TK6LTwJ4UnMsPPTRSOxuOpb10z
 HHpWD2H53SpwIRUiviClv6VKFbIanZrKiN3mqjOPFawTpbmwyiAzKRnFz7mzu1nU5s6O5YH/7ON
 cOR9CGbCVZESeX9Frt5PyBxzn9wpbB//6T16EC8867mXckCUJe5lxlne+suyw48GkGAZHY5rxmE
 bzMhXZpgQwn1Yi
X-Received: by 2002:a05:620a:2694:b0:93b:d8bc:a864 with SMTP id
 af79cd13be357-93ebd4ae9b2mr2761952285a.65.1792054742687; 
 Thu, 15 Oct 2026 01:59:02 -0700 (PDT)
X-Received: by 2002:a05:620a:2694:b0:93b:d8bc:a864 with SMTP id
 af79cd13be357-93ebd4ae9b2mr2761949085a.65.1792054742207; 
 Thu, 15 Oct 2026 01:59:02 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be3b51fd1dsm371590e87.58.2026.10.15.01.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:59:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:58:43 +0300
Subject: [PATCH 6/9] arm64: dts: qcom: pm8150l: add LCDB regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sm8150-display-card-v1-6-5c14928cef29@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1019;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=orEEB4Di9IciHmU5vNoXEI2s2xHdwt+cDps+MGXhqNE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq0JXG675dHOR6qOefRBRinkgWZvvzBOrjTwkER
 Gq/zlW3+1WJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatCVxgAKCRCLPIo+Aiko
 1VPQB/4haNfclZ26D1btqgVLcMyS+X0wynAuPTZZKRJ3MDQwxT9M8opJMeRxGfwqfL+pIi6VZKK
 TSx9SNLEuCxeEN4t1Vc3J4dL37ax6LfCBeWV8wId7riR/JOidcpe7PMaiAcMrxF2NCjOUi++pk8
 Fap6rxAo6Z/YViVlrM1MVLuFCOv0KRa3Ky8EPALffvPF/l5a3gCLlZ/+D8ek2JJPmLPW79vWNbK
 pXjSnFFUDXJ8yCOMFvyjnYtM2QVMhcgnzoOsPWjpLi1pGi4DJf99DzdZ9kZzHONBWGO+/fTx1S/
 dr7/AGG7nRthWyNGQ+pLZ/w26Vdshyd+aNbk8bzPTWTpK8Yc
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX6FIobHWBZ0eH
 Zp1hItSxj6QtAyK6LR+4SBaisCKfaGAVltlGb4rgElbcjVuMQWvCkrPvrFxjBMvXI/Uh8GNLwbv
 oL2O12Lu6nS0+pbBTWJIRQm/UwLl6L0=
X-Authority-Analysis: v=2.4 cv=K9u3jCWI c=1 sm=1 tr=0 ts=6ad095d7 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=7QMEsOvxxwx5wcZNC-0A:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: YKYUE2-GTotHgEWcLu-JV3GNq7R_d7Rw
X-Proofpoint-ORIG-GUID: YKYUE2-GTotHgEWcLu-JV3GNq7R_d7Rw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfXzEiAK4wYzu7c
 XcO7+jMN5VpNYMmha7gQFCFjNOXo0JZjREDa7DEU+svEVV406BGO7o6eVsKAjfp3j20QxGIb1Ve
 IQ+Td1qJBNLeyTNaEZVUdu5AHj9zMN7Dsg1sG7gGcySyDVrEIqemB3Y/OwxpTzjkyjiSt5TicZD
 pcF/w/H03dXYIU6oWvV5VjR3AT5WU2cm/neF4p5U7tI3urT6Ud8ZLBM8OJgMsVcD8gbWoXUKKCa
 8AFNV/2Tp979qiPF8Dz9zZ9QOjUrji7dNe6LHXficPqGlCRKZfx8thzOTaguhUc/k3gdNgjahMa
 MjVTu7d9cVV9qzHguyNC1CgxpLV9WXdD+zT10ZIqEvDZgpqvz7AjVv38k0Z7nFJWzRoxfygNr+H
 INetVeZtecWg182Am0fP56HWBMQlWXraymtnhcx4y2Uj+JfkWEX3GPewSZL3rg3bsl7rEwstaD6
 J8t2MrHxltSFj3dpy9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
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

Describe the LCDB block providing the LCD bias rails.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/pm8150l.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
index 3911d6d0d2e2..f54ddb6f7946 100644
--- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
@@ -141,5 +141,23 @@ pm8150l_wled: leds@d800 {
 
 			status = "disabled";
 		};
+
+		pm8150l_lcdb: lcdb@ec00 {
+			compatible = "qcom,pm8150l-lcdb";
+			reg = <0xec00>;
+			interrupts = <0x5 0xec 0x1 IRQ_TYPE_EDGE_RISING>;
+
+			status = "disabled";
+
+			pm8150l_lcdb_ldo: ldo {
+				regulator-min-microvolt = <4000000>;
+				regulator-max-microvolt = <6000000>;
+			};
+
+			pm8150l_lcdb_ncp: ncp {
+				regulator-min-microvolt = <4000000>;
+				regulator-max-microvolt = <6000000>;
+			};
+		};
 	};
 };

-- 
2.47.3

