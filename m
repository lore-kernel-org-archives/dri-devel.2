Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7EA606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 23:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IG6ynn4M;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DE0oHzR9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E899510F9CC;
	Tue, 17 Nov 2026 23:01:30 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E22D10F9CC
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:01:10 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHMf4Ex3559162
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8oGuG6gtDFzH4M9TtmWAc4LvmLxE8dx3JMMf9s41U1E=; b=IG6ynn4MfORNEa8i
 XJ7nyp7/PSx00XDLozkwGJINbGUMdPwCV+pXCJWRIWt+TsbOydlIT7Dk8YAcvJ3e
 XxnfGAxnF1pHN5x7GbuV0kQsuMYEsQp5F9DfsJ2wPb4/N8mnwjm6LWX8EK3VgYyM
 g0MvMCfQdsPePuGeCuUPDRvwpdMr8pWHLWko96mlHQeMpclPd90+KxJ5FnzGCFVs
 2F0271fpw6lrohvi82PoDOSLs+XH03VMWkpYMy/srrujEySvw4dhQKzwbbfqb8gW
 22WShGo8oAqo3KBnsGt39x+pv+nUJYRhpay5kZVlw8VqpCvDPUpHajfWx3/9pJbd
 yJTKSg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yvcg4hw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:01:09 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1383723dfddso393915c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794956468; x=1795561268;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8oGuG6gtDFzH4M9TtmWAc4LvmLxE8dx3JMMf9s41U1E=;
 b=DE0oHzR9yNtLIyDPtP9F3HuAl9y4BIRwhw930M+9tOuKCCAlVSTNwUlABVTl/W0uMP
 q2CqTcOnhmKVnlIkzu1wCTBRQ/LDWNC7afC5C42XMykDIa6agtcJJGs1BObbbHwW1F2T
 LExHROOhwPGeIufiY5NSSoeLyL1ngnBkEsXxhBFzWAMjjqj19emi+PLVkfXlLDlVcvXO
 BxeC1AzZLGYJWTG1qR9BIJjGqJ086TeeNRIIWb5GKDT4ux1rDCOQttaRWX0vf5kBstHP
 BwlQUIRaRH8POmPprK41eZNFvUZLfBtX/PqWe8D+byhUTMzhjwmEGhxoAyR1td6zFtoa
 aWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794956468; x=1795561268;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8oGuG6gtDFzH4M9TtmWAc4LvmLxE8dx3JMMf9s41U1E=;
 b=HwrNYC+ORgRH/m6owZqsU+pJy3CiL4ftoIwcfENxvgl9ZT8IVEo8Qa12vnJnfcEqli
 QIVzEG760HKSHNGc+AKPUiAvsmyjY47txd1yYaHY7+APPhD+Cx9nnuLNHUM2/Fkaze/h
 9K8w8K8NSUvPhOjahyvyaSuHBqfzdVlEo7aTu928PwUbnZ7cMyn7YwnNPW/5815lHcCR
 UesulUKN9nr6fEtFW2e/H5nv7UPS0x7IQ9e6P4W03MHdXmT23FIBtFILifdFEpKuDBKb
 XxGC9MyfOqz2vcAKGnFiZif0V4JQRvbFgG05HBDAhEVgfLHULnwVa37efk8NFzI/bCQs
 dG/A==
X-Forwarded-Encrypted: i=1;
 AL+hErGktbF8tYnglY0LcG+7acfWJ/KIRvQM4F8yKTSv4ttgeo+yHP6fVEsSeFGKG4MVNhqxIEBB9g42LDc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+UPnnxN423xbxY1NRAnGc06MS3Yvm7lru47Ol2KGFSgvE5tW+8
 bdc1Ozsbmhfom8ug3Q0ejvrCsfMavctLq4iucDYrbDi+lZGXrbOk5QjklXQuijxdBfse0qdgAjc
 70JNxW1w3J44QwZINF63dKgWD83U5qkgQmeQdF2f5+nKb5/RaSyv/6k837dtDYuXDP0d4HW1Wf4
 YIGHs=
X-Gm-Gg: AYBFou346ku8zH2S1a12nXFAdtUYtAUmCtbsUHb/rEjNvQZRSGWZnvhCYZUib474bME
 O4495hUcsIZBDqF39t/Ae9BIj4bgjbRSERMCbYJyRRU9l8IQmECzI8OSseeA6jb+Up/9bk93XAs
 wkQ6Pmkd5BRHpjZVlKkHjcaXtipBx0AKF5cPmHoaV5eg0l3d4c8EMYI83jydjJ738moLkubI+Pb
 V77BrmbutZiN/nQB8d1IKdNGEj7GU//hFvSa0tq3QWmZiyYidgKv3fLBJyglPWLn5pj1lga+Q1d
 xLyN2Ab9mF74eK/c/mQB3eqA2bTAM4tyDDuXv01R1DuBANDbTI9QXyqJJBwikP+CJybyAM0TqCe
 fOsPdLJzyik4OxxN41xaXHQwPlgn5MSzd46eF8H5fPxM3v4BSRvJd8O4wIsTWbU0FI42mH9EvDw
 ==
X-Received: by 2002:a05:7022:1408:b0:1b2:366a:e7d1 with SMTP id
 a92af1059eb24-1b543d3cc31mr799557c88.32.1794956468055; 
 Tue, 17 Nov 2026 15:01:08 -0800 (PST)
X-Received: by 2002:a05:7022:1408:b0:1b2:366a:e7d1 with SMTP id
 a92af1059eb24-1b543d3cc31mr799517c88.32.1794956467368; 
 Tue, 17 Nov 2026 15:01:07 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5445eb29esm1380839c88.0.2026.11.17.15.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 15:01:06 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 04:30:08 +0530
Subject: [PATCH v2 5/5] arm64: dts: qcom: nord-rrd: Enable Adreno 753 GPU
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-nord-gpu1-v2-5-8d6d9908b7c5@oss.qualcomm.com>
References: <20261118-nord-gpu1-v2-0-8d6d9908b7c5@oss.qualcomm.com>
In-Reply-To: <20261118-nord-gpu1-v2-0-8d6d9908b7c5@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Shivam Rawat <shivrawa@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794956423; l=813;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=PC/6atmGOO+qaJdXSQTumHCgKU+rZftW+u9k7tGoypM=;
 b=81oJm0yeVzyC+ZdQ8YeQRpGgoqhdFgmG7SzEXxTKhIsLI1fCeKTL9ePwIANNm8mrrw7xegEy3
 9ec6KAziGSTA7y956YGzjhQFN7vKgoYnCfCMxA2xM5oEu1cy/MU2psi
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=R5OWitRX c=1 sm=1 tr=0 ts=6afcdcb5 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: rijSFInIEldpWPNRLHOIkcXaq26ep53t
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA5MSBTYWx0ZWRfXzR9bELzbtBMo
 2W8rKBUG7vtjVC7RLtQ/5oDHVgNZQr8r/33wn32EszgiyQEmKjmBZbjDA6yK+gVFIXVs1qtHXqF
 8lvAYUmo+G36S7xQHXlTv6nI3azOvEU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA5MSBTYWx0ZWRfXyf7rKgLFpTMg
 0Ln0JsKAqmyGgCx7qW0mrY54LhWeuPOzSb2EKy1VH8adX4FHF7argtrVfpeNdWgInSeRVIIVoev
 Nj5Lp3K+fNEW2Jb8K+QcDtPB8N1YeY1/V1TmJO2K85KsWIvZprZ5wGUilJthXg0UDDcf9U+kF3j
 RNq7OoiSe7h/tdPUXhCodga4rpvUenv/6PunMGq7oxw9YQU9j6MyMKdumvUSjZo5fNJeTQmZQzn
 4jtdJ/2qJKIVw9tMjXLEf46+i+3eCsC/zW5oht/60J3abBFLFQQFT5et2EiYWTSsmBbSDgR44+/
 fI2ESrOlj3LTgzXRve/vuJca9U1npnhBS2U8TrvY2YYxDQTri0bNMEoM7cGW4XxhtAlYEWdyw0U
 r+eJSPfRanRxHfMY6pVxy6GL6bMM17wMrL4zK88ZlDIbfgw9gPF8ROleCelrUPuBLQXQmq/CRzx
 +arIlsc0K+83l8a/zqw==
X-Proofpoint-ORIG-GUID: rijSFInIEldpWPNRLHOIkcXaq26ep53t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170091
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

From: Shivam Rawat <shivrawa@qti.qualcomm.com>

Enable the Adreno 753 GPU on the Nord RRD board and provide the
firmware path for its zap shader.

Signed-off-by: Shivam Rawat <shivrawa@qti.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/nord-rrd.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/nord-rrd.dts b/arch/arm64/boot/dts/qcom/nord-rrd.dts
index 47978df0af92..51e5ef927b7c 100644
--- a/arch/arm64/boot/dts/qcom/nord-rrd.dts
+++ b/arch/arm64/boot/dts/qcom/nord-rrd.dts
@@ -366,6 +366,18 @@ vreg_l3l_1p8: ldo3 {
 	};
 };
 
+&gmu_0 {
+	status = "okay";
+};
+
+&gpu_0 {
+	status = "okay";
+};
+
+&gpu_0_zap_shader {
+	firmware-name = "qcom/nord/gen71300_zap.mbn";
+};
+
 &i2c7 {
 	clock-frequency = <400000>;
 

-- 
2.55.0

