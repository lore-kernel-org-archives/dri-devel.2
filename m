Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1DB606BFF5
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ej7q/biG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TTCVaanp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 673B410F68B;
	Tue, 10 Nov 2026 12:58:15 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 293E810F68B
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:58:04 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAB9xJj4186610
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xM39//LeNx9JjD5To/VljnT8OdI2vlJ2LgADFVsT1Yg=; b=Ej7q/biGRMdxc/8K
 26SADomgPfH7/zN0Bz+Wg02ndgQG/eVGnlUb/1+O9MBiI2xSMNFpRDKvCJ1Wkwlc
 akY++Rr7krpNp2RHoZiyjXEveYh5wzbLhP9c3BZ25RnOQSNN7yUVbquuPeCuYozZ
 Iee1Gq+XFKbzFPtXW8qSG3VvQx9F/pejVtu1RoRrVeADRkGgzQ1VnYOCOcRNSizk
 uxLOZWwWHTyrnz2GKRt8ym+1y6uCNDVfV2y5UTZackoxfrkXZhT69aGDvQOkYX4D
 yQVN7CL5FiCQtp3UWLmQ1SKhHNT48+aADLE3G2zJfgVqNUzmdyC9LUmf8EKxTgmR
 hQVt9Q==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyvwgvg5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:58:03 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7d2eba20719so306621137.1
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794315482; x=1794920282;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xM39//LeNx9JjD5To/VljnT8OdI2vlJ2LgADFVsT1Yg=;
 b=TTCVaanp7uU34VKq0GUq3ya9PHutjho5DcxcSNbbrhxMkiwKBkb+IwPVezTWjnkj8V
 jko4kj7dEqvOzSFht46s6DkwMTUT8jZJLXz6K2WFazli2WFaejeddCOsF1KG3AeZ6+vz
 g84fKaccsW3DxFiYN72GKjVOZl81tunIuhomnjNfpXG2lWQom0GdvQszUN9ojNckeftY
 JHJ1gc+hV9c2QFXdnvRGkOKIldIID6HMRJWdk7aqMNPLda+QJc5q41ltgsgK/uyb1L4i
 W+kNi6yhNMbciCm+JRMpV8ypZBGMoB5GoHsIZQWUNJCLF+P4p7Mrs1mH4ZxvPFYIfufK
 Rc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794315482; x=1794920282;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xM39//LeNx9JjD5To/VljnT8OdI2vlJ2LgADFVsT1Yg=;
 b=kJBJRFC7126BzLEVZY13zskTIYsz6UNv5YSuAF4QU+kL6xnnO5OXY8NkBBqiRshPSP
 z5qZEASXaJkZOTtmbLf5ZxPV9Hqh20MJ+r8cmJWgYzy3CW5/9uvyM/GlKlwbzQGOIq2z
 oXz+06/Jx0HKacABZLe7sgyio5dD0E9RgP4SsLUwAh4Xz74ALB16SSn4KtrbDN1r1JDC
 hMTKzxdiUZVorqk/zRRAzN4cZ0i0s5A3B6UCqFPtOrfq8Gzyf0pZyy/YyRxFrMAuyjqz
 wSkU52weht5kAk/ukzvQmWvAJZ/U9hQzXL8P6rwf20HYoPHNksnvQ0DIOwpCnhNrSYcA
 NtZg==
X-Forwarded-Encrypted: i=1;
 AL+hErFHxdWUn4CZ8XSbHGaKClZDYH4Bj7uNgubOl5lPv8cqTE/VWhEfhTFLfEg7HCak3zKVthh6HiWmcgI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8ireOaZKCRVDKkKyfbO8ZcAzb6MlFVqiDipABDw2fZsKDas2JW
 MVCrAVTkaQ6ltmSzy7842FnwZcwZyRbAsnIh/+j/IUSFQlDz/onlK8QlRj1GhJIy/f/02eOmPUA
 2Osn0JS7Q3ubRmk9aXj9thDJVXGUlvcdPEyk/tvImpzKGSlwqOYbzPLy//sA4gvGVBIlHoDmT/H
 LJM/g=
X-Gm-Gg: AYBFou2vfQhOJk5e3IO8dE3KU8GTV+/HtS3kTx420+cHOVvZNgCnnApVkdy2bcuR4CN
 bSMQVnK5ISd1cTaadTC1qN5YtEv7+FYMFI78kUnCIzhIf+CXuoh8Wf1WFqgjhmqiEX5mw9QPLG8
 zaxPuyStArqLzcdbmKAdj2+E4ZCvKghgERHOu3Kkya5TzSn7GGbm9qUhS5QSE5U+9gJINjqzX7G
 bIje0mvkuLbzsBw/oA5R1vVSArv1xEUXqgpVuBURVCuZdSfk/4Sn8296LCfBR7VY+WSdAsOesxN
 +qACo2JlQhjPlf5rW2I0qcheUzUlRt5/mUJ9Kr6OxRsIjH4Yyh5r9utyT/IigsLfIUi3JlTnmMP
 bEIJ9yuJQKMVwofbGzhqHy0bTQLHkCxJNa+eWWsGbZLbJTOpX8miFbiAyPhZzZRzHuAspyw==
X-Received: by 2002:a05:6102:2b9c:b0:7c1:8aa5:36d6 with SMTP id
 ada2fe7eead31-7d301ba38d7mr715651137.11.1794315482033; 
 Tue, 10 Nov 2026 04:58:02 -0800 (PST)
X-Received: by 2002:a05:6102:2b9c:b0:7c1:8aa5:36d6 with SMTP id
 ada2fe7eead31-7d301ba38d7mr715642137.11.1794315481593; 
 Tue, 10 Nov 2026 04:58:01 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.7]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fba35csm58422365e9.1.2026.11.10.04.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:58:00 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 13:57:42 +0100
Subject: [PATCH 1/3] arm64: dts: qcom: msm8916: Disable disconnected DSI
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-display-msm-of-graph-v1-1-0f3106f817b4@oss.qualcomm.com>
References: <20261110-display-msm-of-graph-v1-0-0f3106f817b4@oss.qualcomm.com>
In-Reply-To: <20261110-display-msm-of-graph-v1-0-0f3106f817b4@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Del Regno <angelogioacchino.delregno@somainline.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Mahadevan <quic_mahap@quicinc.com>,
 Richard Acayan <mailingradian@gmail.com>,
 Danila Tikhonov <danila@mainlining.org>, Robert Foss <rfoss@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3980;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=65njRLBqDnUyMSob9Dpyv+KJXmakPkOeCvlHFYhe1os=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq8xTQbHWfK+D3i/RoxLJyMDJ7NZJC8pDAy4fvN
 hxuG2J5vXWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCavMU0AAKCRDBN2bmhouD
 19TrD/4m1pyWaPmrdxKPoimQkBa9g+ksohwgck9+Sol9aIyua4pkoOf52KzBj81zXbXkjzV3g8t
 Y1KRFZJQmYwpCgVlqL1195hs5em/cOz4hpqFxtqjSNvtop23nMswZ7Ipdr106yztLpwwUP01Uz9
 mmnA9byL3NZ0Y1iPybiQuTdkdu2ScRNZE3HEmlnzcJLh6s9ERkDG8OlrJHQ5ojrkAiq+PxndJ/r
 E6GiY/9AmbEtN6Mqz7TyxI1ODYE35KqESKdF/dxZTd5/jnw4pc7tnKKrETRuit+rOgcxCtIp3NI
 8XAYo7oiEzmeaeOQyoPm3dsq1mtjf7FJwa34nzQbwwf+vN8fMWZ1F+phcTdHHBZQTSGkZrruCMQ
 0wUSG6eW8+yJJOtSDTonlnnXtvVPi26mJWaBFtL0dRGnTfuX6Wl0Dl23rNdfKOOFuX0kyOuM3CG
 QZKPqTbj5B2TQxTEtrqXovvCMKmlpzRlv8ME9X/IQmN1FiF5nTF3nrxUa0Aw66Oi294bhM6UfY7
 R07DRV5vWuxcdmV2VP/PfGIOB/Uun91n3ePgK5a+WnyhSeHT/z0lYM6j9wJdMkUkB99RM2XSZtf
 XAEnx2X9wun9XCBv7tZ0JLHdojtUXdMpaztffXJcgSw1/VAJ1p7H1vfzVZHZkQ4F3wzYBtvpjjc
 cFle+ySOKTeKmzw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: 1OqWU9qj8SrMV5EnzV63UsiehImzdal8
X-Proofpoint-ORIG-GUID: 1OqWU9qj8SrMV5EnzV63UsiehImzdal8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1MSBTYWx0ZWRfXwgwUDhICBhua
 gt5XE7JJjcG695W/1BAFyLk8+r2dL7TfY2UcfoLN+EYt6c+SY/ps47I9Ib+YIpjS76YmuoaRb+f
 GIM7ib17gaOkFujmUaExy7pSkkhNIH0=
X-Authority-Analysis: v=2.4 cv=NNpAaE6g c=1 sm=1 tr=0 ts=6af314db cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=NuhE5ioKuPUxyzsrWcsA:9 a=4tUkUnfIpJ8A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1MSBTYWx0ZWRfX9HmZAx21BC88
 wuWTNWfZjn0X9JGyF8HVPbiBEu8bXdufscGvwJWrLnUJrboNY658fyW6nEbTdWboprJ8o/w8ma6
 m1tIYOY+OI3KRl/3P5S4xIpvv6Ay08ZJ314x5XuTOrOt1Hxhv9kYdyCKjEbQYcZCpJM5eYjAo/m
 ZozAskVzbxF4XAtgMk776QMBfNkQoh3Pio2nV8p6IbKPqGdhldDVSawDE4ntGtHy4uCRwmmSKrY
 1zJ5ZRs1P+5BbrP1rXIidVsewi9dh6h5aeOQdztKZcE0bEopSSdYxXsi+e1khHThzETU6KblF9O
 RIRpYLXTzQFWMoBqHonn66IitBYxBVhQGWavi7vEc89trJZT1x+L5rri0Hlx6WTb2z0bJ+Zgn6g
 qZsEh4tTgmZZud3AbNNdvAGgHOJruSfpskfEq5j3pbLxTRmOa++UqyND8RUVVongrv74TtfF0ON
 EzWHEo4OKjK8FjqkUXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100051
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

MDSS DSI and DSI PHY is useless, when nothing is attached (no panel
description in DTS), thus should be disabled in DTS.  Linux MSM DRM
drivers will also fail the probe.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts   | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts     | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts      | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi                  | 4 ++++
 5 files changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
index 906d31f1ea21..d3adbc7406b7 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
@@ -87,6 +87,8 @@ &clk_pwm {
 };
 
 &mdss_dsi0 {
+	status = "okay";
+
 	panel@0 {
 		reg = <0>;
 
@@ -109,6 +111,10 @@ &mdss_dsi0_out {
 	remote-endpoint = <&panel_in>;
 };
 
+&mdss_dsi0_phy {
+	status = "okay";
+};
+
 &touchkey {
 	vcc-supply = <&reg_touch_key>;
 	vdd-supply = <&reg_key_led>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
index 5b34529b816c..fe333ed489b5 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
@@ -133,6 +133,8 @@ &mdss_dsi0 {
 	pinctrl-1 = <&mdss_sleep>;
 	pinctrl-names = "default", "sleep";
 
+	status = "okay";
+
 	panel@0 {
 		compatible = "samsung,ltl101at01", "samsung,s6d7aa0";
 		reg = <0>;
@@ -154,6 +156,10 @@ &mdss_dsi0_out {
 	remote-endpoint = <&panel_in>;
 };
 
+&mdss_dsi0_phy {
+	status = "okay";
+};
+
 &sound {
 	model = "samsung-gt510";
 	pinctrl-0 = <&cdc_pdm_default &sec_mi2s_default>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
index 3d6d9dd3b8a8..85d1cae19a66 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
@@ -98,6 +98,8 @@ &mdss_dsi0 {
 	pinctrl-1 = <&mdss_sleep>;
 	pinctrl-names = "default", "sleep";
 
+	status = "okay";
+
 	panel@0 {
 		compatible = "samsung,lsl080al03", "samsung,s6d7aa0";
 		reg = <0>;
@@ -119,6 +121,10 @@ &mdss_dsi0_out {
 	remote-endpoint = <&panel_in>;
 };
 
+&mdss_dsi0_phy {
+	status = "okay";
+};
+
 &sound {
 	model = "samsung-a2015";
 	pinctrl-0 = <&cdc_pdm_default &sec_mi2s_default &secondary_mic_default>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
index 71b5c98458ff..65de798201eb 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
@@ -337,6 +337,8 @@ &mdss_dsi0 {
 	pinctrl-0 = <&mdss_default>;
 	pinctrl-1 = <&mdss_sleep>;
 
+	status = "okay";
+
 	panel@0 {
 		compatible = "samsung,s6e88a0-ams427ap24";
 		reg = <0>;
@@ -359,6 +361,10 @@ &mdss_dsi0_out {
 	remote-endpoint = <&panel_in>;
 };
 
+&mdss_dsi0_phy {
+	status = "okay";
+};
+
 &mpss_mem {
 	reg = <0x0 0x86800000 0x0 0x5a00000>;
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index e39743e22043..7d351cd15f90 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1634,6 +1634,8 @@ mdss_dsi0: dsi@1a98000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
+				status = "disabled";
+
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
@@ -1668,6 +1670,8 @@ mdss_dsi0_phy: phy@1a98300 {
 				clocks = <&gcc GCC_MDSS_AHB_CLK>,
 					 <&xo_board>;
 				clock-names = "iface", "ref";
+
+				status = "disabled";
 			};
 		};
 

-- 
2.53.0

