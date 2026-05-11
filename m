Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC631CD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 22:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 230EF10E905;
	Mon, 11 May 2026 22:24:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZC/G7Pte";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TgwNOS6F";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84D2110E902
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:24:32 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6mjE2519102
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1ZYG25c/7YbG2u9v/KfIESsCF0E346q2C6Uk/dm+SG0=; b=ZC/G7PteSvshWYCT
 9Gwui2laiuBm9kj/hxGxf0eIf9fBSDWUxRdNVW8o8iQdm2xptrgwbqmGyjFXV7sz
 2rAKbMI0yuhUcuWWjdHZkj1aCEC+MbP2wg0vBU//sD2XLss0pUYatEvYE6ThAHvb
 oo7R6TLFSPicTu2u4au4A/M+YAfdx6ahgcWIGZJufATwrp1LRJgsnk1YyBfVUR1T
 mw1EYv5f7wsHQVIAFww+tFdPDfkg27E6Zx1og0xYCBQ23ajaHWtVDUDK4vwxQTuC
 UhkJTt1KVYtIyi8fwV1+sUkgj9jXCVd/zqbXQzzWbx5gpyigYPwrAjnVlEBlHSEp
 xCKxsQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv1gfpm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:24:31 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8354503d9acso5833142b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 15:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778538271; x=1779143071;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1ZYG25c/7YbG2u9v/KfIESsCF0E346q2C6Uk/dm+SG0=;
 b=TgwNOS6F7Kea20yEYK5aRBh+ADXo75EQ++pzsWdGK4y7M0JGURaRIhJPCggtJf+0OM
 pFEWAqxUDMZ+MNuqf+vtrn0X1qIFOtNUmJcvJtMoVTu4InTi1GALgN3XkLuPPJzAHXuA
 a1JvS5540X2YOEyFdJOeLSdvP6V4fHbscHjvN6AhuSZmzMjUi3ULfv8nX0Z+PydT8C+c
 jEad2/8gDEoLsksWf41v4yAYbjRU7uFIOeSB3JwaS1LYY+0IvE8Kz+Cq2DwHhelz+fvl
 yl+2JgPCjYo6klihoW+g7lfGujIOF7VqgcgBqiaxDC9r5gac7y7B75uxGUuBaUjgZSJ9
 kYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778538271; x=1779143071;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1ZYG25c/7YbG2u9v/KfIESsCF0E346q2C6Uk/dm+SG0=;
 b=UtSQm2yuPjbTXY1rbUU91SiG61EmSe7uJ0XYviWZRnp8HU/gL5K8hEezbeOdbRBLLD
 gkx1U6tsHFmUf2GI1/gL1FCDh4ARIsrz+do/5BIYhawkPkGE8itrNamPum+69TfZp/sL
 xVxCOnDvAGyzb+pYWaouKKGUSCtrv3b9HJdC3k1tVh5UoGDZGsiEpJYfCyyu1iAdUEAc
 T5lxH0lmY4OJ9zSzuwHK3e8/NOySG3NkAmhCLqgvdH9tMoHx+GAvdrJjGNXWcckij/kM
 L46dFvCpSd+RitOhs9027LghzyowaQSuPvW+1kf9csSYuDAwdBTyPjzSMN6pJESUKFfC
 5Gbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ80gMAuI1t3dmcYaokXuuZskBXUx2DwdTDU2OYlQN8wS+VMbpaQ0vIN0ZexqOLUDl3wyDmHm0h0K2c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwITTGyKsLUkukjLuKe7H35G4dzqSQL9SX2eN7GZsj+MzEx6UqI
 e8KJeQ2tU8sWSiZqzXXZUoyDGHIXLL2msR0y3JZFyv/1sPGw7NbrOzYvXPghTrh/Y2VEGcWB2eX
 ok7w+8fFtihvO8/k3kh4pUHbL5aWyerZaeFVju5qh3kq5MsNRPGP+Z1HWYj97qkgBvaDYfWw=
X-Gm-Gg: Acq92OGlQ/siL1U795DRqc+gJ/UTY9i3yxgWrtqXYDKhOaUkRwmJ03LFwkizCzo8tQL
 s5ID/+3fA/A9QD6SSlHmxjE42zpGCXnSBjOCjKAKJzwjPlbKwOdJ9VYvSTwJilEuW2R7yuoC55A
 xhDTbFPVdP7trdqMSuMQfXrTQvDV7tIjWdt3ONPjneDiYLZQ4dNkXIC45Bp9grVJsIvvxZDdtMw
 n937ornvkDflXA9rmXI3FnStbtu0yh+ERfBYe+BOXN9i/DthyHNlCjeibtiMt3zv9nb3I6p14pO
 rHfDIasr0cnBmjunsJUSGQxTHYctyCvrPaNgouzR9oezt1uOmFJOESBnDtAJtJS9ZCQ1tWoBtsV
 AGU87c8UFoXqWkrq570/FPPOeHS/xWMRyEoxlSt2caU2TyQ==
X-Received: by 2002:a05:6a00:35c3:b0:838:127d:a161 with SMTP id
 d2e1a72fcca58-83eebb5f055mr337141b3a.18.1778538270728; 
 Mon, 11 May 2026 15:24:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:35c3:b0:838:127d:a161 with SMTP id
 d2e1a72fcca58-83eebb5f055mr337094b3a.18.1778538270230; 
 Mon, 11 May 2026 15:24:30 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965946543sm27028110b3a.16.2026.05.11.15.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 15:24:29 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 12 May 2026 03:53:21 +0530
Subject: [PATCH 7/8] arm64: dts: qcom: kaanapali-mtp: Enable GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-kaana-gpu-dt-v1-7-13e1c07c2050@oss.qualcomm.com>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
In-Reply-To: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778538205; l=783;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=iDb2uz96prvOPreAW7V7qXKBMuEzgLkBJlRJSuUvUNE=;
 b=4L1Wf2OEP3HGXs8rkRNKP6ek9eUFrozE8QJtVasyeMz6R2v98M71tEUIV3XtOxqXKwovkzpPV
 E/IxoUX+YlzD2Rsmsy46DBTmOK2mKwzeMLD8gf2BtnmIQ/LQd2gkE6P
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: uf7hlizLA3mAj-RFn6ohnlljyIEZmY2B
X-Proofpoint-ORIG-GUID: uf7hlizLA3mAj-RFn6ohnlljyIEZmY2B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIzNiBTYWx0ZWRfXyZhd67C5bmLq
 XHzEVL79FvRS420Mpd4mZZZ8FuvZyzazEoQB6RKNKBcoKy/UsW3fPDQY8eTy2sKkuRm/lm1maS3
 ODDGc63HQiy35gSa3DTLK4zNeijkyCEAMOzxiJE0RgybUofuR0Zo51aT7HUNWq99JnVN0CQ+32w
 YG2g2QOmCw1J3y07A258YHe5Of32yekV2GrlTv49HWsCXuBSeYJmA9gKBTTpRj13QRT3cf8LV/8
 4eqgRDAzM358DRV/nug2EjYHi50FwrdR4i7IWejzZqS7I0ZZ5q7YTJJHc6kL218nqOtEQ3K8wMh
 rn0QYwREzonZMsJeE4sCTdhNPv9hFp7bVNQfIQ6i/bT9q6R7NzSCPks228AdahU2yqogOD7lCfr
 tWRsRrmzxf0hhxb3ezLucVjosPx3mb/xN4eVOgV+1PdKrLnhV/IsBzAbNjKV7JdNBIHc7fEdL2C
 nQq7mPMtaRhbZNLrqJg==
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a02571f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VHn1p_zO8-rooJRYzQAA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605110236
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

Add the secure firmware name property and enable GPU support on
Kaanapali MTP device.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
index f9b5b5718b90..ba256039dd3c 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
@@ -865,6 +865,14 @@ vreg_l7n_3p3: ldo7 {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/kaanapali/gen80200_zap.mbn";
+};
+
 &lpass_vamacro {
 	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
 	pinctrl-names = "default";

-- 
2.51.0

