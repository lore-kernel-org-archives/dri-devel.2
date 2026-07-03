Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B84C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 20:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E8AF10F902;
	Fri,  3 Jul 2026 20:36:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NJ8mtjsQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GwsmTvnV";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FE4910F903
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 20:36:21 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663KPZaI1029415
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 20:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2dOV6SNjFzG9X2tjzVk0oMjUqNu3RuI4o/7x3sDqaJQ=; b=NJ8mtjsQ5uk3031c
 1sHML28nZjDSTULG5cmU9dYBC52+Up47/RZ8EGa74eXGgGXlHkX1mRPa8fKIcB9J
 kR8IoDLwnkQisdxw+Ong7g0TWTtOxA8GLTXhi2VEMpEr12KUPnC3fG43yrkiCaoo
 on7VFUEktt8FnhCPil5kln5tE8FFOKp9GOSLkjWwhz+ZDjrKGlk4VVw8W8o8b7yP
 bkxo/wD8LklfrJ04RgY1ktF8i5vEj7f4+BELFuXzWhc4cgJPdAdNiqeGhx1NgcYs
 1eusB7Up1EI1OmFDAnGb1h4rdFaiwZGIaVD4lrqak95amlcOwWoprQX+T4IKzTpb
 C8Gefw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qckk8a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 20:36:20 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88da04b719so692129a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 13:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783110980; x=1783715780;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2dOV6SNjFzG9X2tjzVk0oMjUqNu3RuI4o/7x3sDqaJQ=;
 b=GwsmTvnVEUM3l6vvR42sk8fr5gH7WocaO8P9Av8CzAMRJDwIJkEM8fqn4pWvmyg6yS
 q2LohG0WQJ1JDb/kZiBd+vddnbj8XxKWuKvo6i0mIEhicmi3iZoRzICNyLFhAcnM3ArD
 SeEncNlrefAKJdhIVctZSEAI8yzTHLRTcBQR8TPvAM9WNZutEumqHjYm0EO2gPiyPWAg
 P5CDXv7j0TCnCCMNH63fj/ScFRDWilu721AxL+hzre/mikPk5xs/9YA+Mzwu2TABalY0
 mIfC2sOs7AySR3n4OEYyakV4l3XMFSQiWm1CMGvpxpSFwcm0kQqB0nyMYGlNTcZ9Lm2o
 vMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783110980; x=1783715780;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2dOV6SNjFzG9X2tjzVk0oMjUqNu3RuI4o/7x3sDqaJQ=;
 b=CgS+ZVuqQlu0N9JaNOPkZDeHlxJjxFwtRGEVJjkpD2tgma8Gj9G0preG/6xq87YuA0
 lkaHkQoZQ/qU6apAkCFf2f5RxacB2TjPNJQt9zhi8gorQzp50IifDSU40d/Mj+UPMbfQ
 aOUW3vksr/gz7J45FzhQ+DeSi2gjA2qBY1qfGhiQ8lh+QIcfYYk/2q3ipaTiZzTSMQuD
 T6MK5NYUrji97d/JTcfu/XzshW04LQGlG+PRM+HSlRV1LlhdpoJQwNqE2Cb23YHOxBsJ
 MzzjPg+4VVKeaI/5Q9+4Xy7P2KifNiHCswdbhgPXiL3LqjoSZPtSFCva4cNGO8Z+RnCZ
 TXvw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SNaAFderumJHVBBdd79T+cPGfXfH7crndYLJ2Pxhn/Mu5GT5WNqA4hQLKIr2p6k1RW9uoG3k/8iw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwhACefI1b3cbswqKPPOuH0jlY2KYU9RFraaveGHJL0kAYjxJ31
 /T6x2/7ytbcVY0OJKrx5cDxLI1ZcJP931ENBHiAaW5W4kvtbQTvTduRvq4FHZ4bQM5cmpTb5RmZ
 1O08z91WwsEBZZiPW6AJJtypZu6hUEQe5sHOjTssrHhr2MgZ7PeS2e3wbWus0P5F+0gdrJykYD1
 9A6kI=
X-Gm-Gg: AfdE7cm+RMc2K+lY7jORh/6whaqRFLynx4M2xqHcavEjb+m4jOG5yuP4jjI1w/wuPfZ
 FYi5qUixN6UWoFYB0oGdgCj+i185PJEtWjyWPLbmpilOcWb72zSmN5Ppj6B3hJG7ARH4X2p27yU
 JfI+7WStV9q3nKjzBROJGWM5ApjcJT4O6YIcC06zDFRVcHp08+qHEpthvTBl64kQOK5y86dG8TQ
 C4P0w8n3sowYifO4UatC84jQ5cvK59BBLBaFkY8dZI6G6bE+weGGHHQKU5NLiytvqvATlZjHQZv
 G2mHGP8sMKtSNYzjdpn4hsOJB4gbmTzCJRtYYgptFcbCvZChBTrthUokO7IOPK0CzW0Ae/ybXgu
 VWE8mOYPBVRV/43QQTlGfslBQjFfZdk6zOjc=
X-Received: by 2002:a05:6a21:2983:b0:3bf:aa1a:d303 with SMTP id
 adf61e73a8af0-3c03e5941eemr781904637.49.1783110979715; 
 Fri, 03 Jul 2026 13:36:19 -0700 (PDT)
X-Received: by 2002:a05:6a21:2983:b0:3bf:aa1a:d303 with SMTP id
 adf61e73a8af0-3c03e5941eemr781871637.49.1783110979257; 
 Fri, 03 Jul 2026 13:36:19 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b7b9a8asm24815567eec.2.2026.07.03.13.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 13:36:18 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 04 Jul 2026 02:04:33 +0530
Subject: [PATCH v4 7/9] arm64: dts: qcom: shikra-cqm-evk: Enable A704 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-shikra-gpu-v4-7-90cf1a52e539@oss.qualcomm.com>
References: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
In-Reply-To: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Aditya Sherawat <asherawa@qti.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783110907; l=894;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=sXVW7HyYn+zboxV3uVHhdySY2TiXHDOOKyfpwcYtiUI=;
 b=wYeDLz1Q3es0EoxTF9BBwaEzt+JV7f7Dw9TzAL+RcikJnuzjboL+RivQ+2cjiKzDhlI1C6Fhp
 /ea/aVQfkA4BAyda+/hRZFvmLi52/KE7U9JGNJ4rGuOGiA+uglghbOd
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: l1jFenwyBZ79mfu82Iw_Ivw4G7YL9KAn
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a481d44 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=JW4bpjJLMT2bmMDKeKQA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: l1jFenwyBZ79mfu82Iw_Ivw4G7YL9KAn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX6qypEa8DEPIf
 VE4N1Oswkn8QzO3khcUSHohK0EeSNa+IABRP/88oIzU3456YNlZ/SUYsVd4eHlxscOmb1ZqWHIR
 CuNWt6RgRioewkd+AYINGfjzHjeysXoWWNQg8LcQBAfkJ9pAnp2W7L4ythlMzCpTI44tXpGyYup
 GN1kN2TpLYxvhODVI++8AAC5Lyb9pOPEWkzkWIBE0EXWKAVNQEci6SU5TgaSiARJuokVqihuU+Q
 5SL9J0RGzsXFnLqgBhbMZyIcyB/ccAnlNGZMzBZKL8dSBJY2N/ph86/jfXhesXRZFp0NZZyRJFz
 xNBe93DasAgpgWNCoSRA/JB24UuUPAR77eK57XwesjdOXQHmelE5ex4bysB4kWxQ0HsJJysEbPb
 3hPz2Haj1O66pYUuLB4BI4QPkVK4yyTapcZwHMI02DoP+DL5eNT5d4nZWtS4Td5zZB4krrOPlsZ
 574QYlxFuR3tK1rN3Xw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX/LCOyBQSDT4Y
 awkbl2vTQijQO3x6t4tbp5ooONL/jxpr9QYBKxBSPWYqwswopJUSbT90AXJ1525YG8z1PrzcvBV
 LJqDOPQVWFUTuqMRkPvZ5ctnCTdCX/0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030208
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

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Enable the A704 GPU and configure its zap-shader firmware on the
Shikra CQM EVK board.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
index 269e11bd44f6..8206dddcfc75 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
@@ -50,6 +50,14 @@ &remoteproc_mpss {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/shikra/a704_zap.mbn";
+};
+
 &sdhc_1 {
 	vmmc-supply = <&pm4125_l20>;
 	vqmmc-supply = <&pm4125_l14>;

-- 
2.54.0

