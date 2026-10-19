Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2E1CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE87F10E98E;
	Mon, 19 Oct 2026 11:26:18 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93CB610E6D9
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:26:02 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8PFOA2193452
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ux49o/jZ2Q2HbyoLdTvVFEFeUH/9erwewqJgn0+nyII=; b=n/spyE1BkM/dDNRS
 NY8H3e9GZWT/a38lAPzY0ca12xZUFDWI7HgjNpvO99UkGI3Yc8Z4pi/6EasE8jSo
 MCirDZ1mGsx9tSwXtsaADw7Zw0SBJG6SnztTUifIANPCOiqMUrGtGY06QAjWHc7L
 KL7EEUBaSqvQA621soHLUt5j1vyfPzwayskQAksXU7qRalhgpIZfWAUm+p5lVhgb
 bBWO9Mjyjl9c/f75WXflinVfx8pxF9sfztA/nruxXhl6fuZZvAewQMIwizkM68xz
 kRy1cca41BQFoZlF18ZCFOVpbH+l+77b6bI2XJUVWYJJ7eKNg7Y+fe7vp7Nu1pSa
 SAogtA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5w1af8v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:26:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93909014c85so453660485a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 04:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792409161; x=1793013961;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ux49o/jZ2Q2HbyoLdTvVFEFeUH/9erwewqJgn0+nyII=;
 b=Cnbt0QDW/bn4K1W5B1/5Rs+Q9kcoH+Eda11YSc2nXHS0RtgMgZbq9VK+I9gkeZ6bpY
 F6FEOn+DTYKeSBG8yyWpMQ082Dx25YA2bO3Dn/6/B6Yzavf0tz75xgbm/bzqtLJcazuS
 DdGfqKRUTVJoHK2eTw5uH622itBiLrPt8GzOAUxcqwjzGjI9ulPrp+WYK8QBX3Pjeyjl
 wzylOx7hAVWV4RxbukGS1w/FaFhTODAvFIgowRl/lA2TBrtqBE7DjqAlTc9KlZGAGlFm
 r+E/kVV+XBrl38maSxHttMgL2FIU780WbiXTZVVzYqvXiR/LfBSPWowPL2Py/upiUsgy
 LhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792409161; x=1793013961;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ux49o/jZ2Q2HbyoLdTvVFEFeUH/9erwewqJgn0+nyII=;
 b=Jt3Jl1cCF6b/ylrROZ2HKoos2ZTM16FKguuoh8OQOKUTz+4HZkikhMWmo21p/TY1mH
 QFOUwZNUKwxcyiycSrlFkxgq56WFvTdakpjtZm3Z/zyScBifDpKnKji2ldIX02PIu/Wt
 0ydHTHjDS9hDB0yKt7nn+H5XUBe2dq3/z3SyibbNUgWsHk/lHbEHvflGvYcPRw4h/RQ9
 N8vFswzhIcQAfhUgRybpBP/EooeFPPmCikdOLOCMp/TlGS1vPNoizISlvrbmrwVIo5Uu
 it/u7nVDlpZjbF3PRzu/DXcpPfuDT+qk99dvnRTiV6XIygAj48fcNkzyK0Uie59MeKP7
 V8lQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcrUG36k/ZVu1jKh+Pq7SWnu8UYOvW5YHCn51Fbob/ZkrcByr43rvAd78UAgGV6znNgqI+eXI6L+w=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI3RfxqXRf3cRoD/OgtfBkvhtPMuk4MwAN1+e8PFIscxBg6II8z
 bDSKKkHDaJssKA8AduHgXZlAzllCRpw/HsbjtHGEf0yikawfOogKj+lLiSaH5eSAawV+wiWDHPc
 e0+IbJE00eMWt/hSx4M1KFgacxrHFQiWH6yjelhOUL6BvnhydEjZ95UfTH5zmn1JYI6ZQzt0=
X-Gm-Gg: AYBFou2YMhNM34c9oLFwmqT/ej1sNJ8+KoHYuG71DJlInm/F/r4r3SADUagFAkH501S
 /075JmNf6utbRuyyHQjlYtds6qcP+I2tLa3nS9ur2DKa9tP4W5w2lF3TG1ictC3jKskNyVu5ilE
 CfiFmxpKL/lQdLqNOunbGIoegS9OcZZONys0sRwh7OmpB0JGjVXP4y45NsNo1qtQ2pi2WsxdiVt
 NspQ9jTfO7Imn5qV3LAL8XEdREqsvgErqqUlncA5srMcQcdxc9/yO2L+FqWu87llFbv3XlekMsV
 bDo3KVYtGoGbkH05QbelxNXjIokhhLK4MiEhMmOHW03mPQWhsXAjyY7aU7aBGfh9h+lJ0II7a+c
 i8lPbQOgRHOPpU9Qim2zpc7n1ZQ0NEMcsj5I+uS9ngSWtIp1hRJBjjTFvTqL8fUeHwpA0bmNPey
 5k+F3qvz//bjtj
X-Received: by 2002:a05:620a:45a5:b0:93e:5247:f61e with SMTP id
 af79cd13be357-93f29c949bamr1190122685a.25.1792409160782; 
 Mon, 19 Oct 2026 04:26:00 -0700 (PDT)
X-Received: by 2002:a05:620a:45a5:b0:93e:5247:f61e with SMTP id
 af79cd13be357-93f29c949bamr1190118385a.25.1792409160178; 
 Mon, 19 Oct 2026 04:26:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab37ba8851sm12807621fa.22.2026.10.19.04.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 04:25:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:25:42 +0300
Subject: [PATCH v2 6/8] arm64: dts: qcom: sm8150: add MDSS reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-sm8150-display-card-v2-6-86c05068efc5@oss.qualcomm.com>
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
 devicetree@vger.kernel.org, mfd@lists.linux.dev,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=887;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=hZXX7jXb2RW5ococNqZ/3EvKgahehke65kVnEWQpEVQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1f46nwhQIKuE+nnIJbKsZpWQ74BHTOmmJUSF4
 oXddakZXaGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatX+OgAKCRCLPIo+Aiko
 1eDTB/0ScjJc6nrAYJwlxb7Z4o6Z87s6Yf5G/e6VqlG9wGSwoHZKsaWFTq8kjhNE7Sg5QROx8Zk
 yo//8AcN6chcIry3PekMiptrAnechf08aNFLpoiwDLSWds5cpZ1Ac0PlfTgMy5e6PR6FojkDbQY
 +TuLhxym4W4JiVAlCA/Q1SUNEuPcgYYKK6Pd47dca7Xdv4m76SCLdQXRENCr76zjt8gGEtHRRiV
 UIW+VuDyWoxJIkIvPPdxCMQdQo7sQOyJaNJWrjgm83pIEeqW5b5WLhCoJ7x/gLOoz17emmyFZB7
 rUupLGHhAHpKnnl7FuAWVMUC187kmAE5M0Nzk9EeN/bc0XfR
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfXzk13KMHTXcKp
 2hpZQT3m82AwVgNpjgjXlGCq4YDDxxTcuOi+wyKi/s2uXQcnOjV3DoyOnuG2onw/z0c3OnHG0Bl
 WsA9OVaQp5IJTEUHiwvwJtDE+7sJfvU=
X-Authority-Analysis: v=2.4 cv=KuPYSmWN c=1 sm=1 tr=0 ts=6ad5fe49 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=Bz10KyuN3JYNdhx7gBUA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfX3RzwQugMm2as
 0KMVc4eo062Uvphbmp5NzfHJ2qTPmcGV55PQNhq/GjMs0vc/BYUQ4mjSFDlOtqg+//eJggR1UEs
 SORHRvEf3A1oIE5xHE2Q/N63YNCurhkIT3YO/JripzdnmUiWLrH4fg8yi+FAyrKIgZUs8a6Xhi4
 F+I2p7aPpqzGE+lhXkLG4otlfsInsrKRjatwlQJ46sGFN7jneCgoVcu/y0hHQRyrvkjh9KlHOKD
 lva4AOq6IAzKOl20XyIJrtmwwibKA8FoSj0330RPNM6A33Z1KC3+oGCvbngfQUF60xxvX13wJIO
 TDLYKEQpZIo7g7Bb3jw02uemOB2fbRNVbreTLiUNTzL/+SU+P5vSeuouKuoTAZvNBTrdH/i0wUE
 4JduUlgjnZFJzJQetpeB3fFa545CIF5NNS1/U8hb4GqDTBEPLv/DRBqbm6HDzAtwUwXgtfLdygC
 Rcz0+Lc483Br5GCglJg==
X-Proofpoint-ORIG-GUID: dWhWnhpSAbcQRQPiike4YhOTo0rfhN3g
X-Proofpoint-GUID: dWhWnhpSAbcQRQPiike4YhOTo0rfhN3g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
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

The bootloader can leave the display running, as it does on the SM8150
HDK with the display card attached. Describe the MDSS reset so that the
driver can bring the hardware into a known state before using it.

Assisted-by: LLM
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

