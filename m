Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57655CA6017
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:08:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A96A310FD6D;
	Thu,  8 Oct 2026 21:08:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QXY+wF/D";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kIYwOk8w";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EF8D10FD3F
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 21:07:46 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L0CA5296602
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 21:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wWdjJJ/kiHobdaG6v+Jdrtw5OgD5o7Fqn+e268oN0wk=; b=QXY+wF/DDCNivfYD
 7mPAz9rH+3cWljzvOTvOCUKhgTYqCSzp3ieZe5YNw+86ZpkknXSaOGmYytPGWDKy
 vjzsAtDcDQYvfhVG9Y+wkAN7E0qdMkRGK35DRMOrnozawzwmH7ymnua7MnkS/RbL
 RfkerHBVPTOfC6r24ZmcJq7XiUsI8qNzLBjct4A+brSG3z8wCNyBaPbsNnKNVDTv
 zagUcc/K5c6OnbODN/4aCN7FsH9mAzdpjYUZUhnBcRUe2P2aoxduafcIUrWULHaN
 1X8TIDXKw0gcYc0zvZbaUkk4/V0J0lpV3RxWRBh/28LIceCgnQh40fDgjYKzzhoK
 aKexIQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ekv901k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 21:07:44 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-313d1015161so16337999eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 14:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791493664; x=1792098464;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wWdjJJ/kiHobdaG6v+Jdrtw5OgD5o7Fqn+e268oN0wk=;
 b=kIYwOk8wirOauY8b/AUDmzxhjvTjJp5YfrzLxB/DAaEm0TbnoVUoMv0d2/IV+FaewS
 lMOyoWTdcG2MnAF+f/5xmB+HjTdE/DV4R3nHEpFTDNJEqWIb/LPrYMcNJojIJpVHR1eq
 GdHmczRqFu5BfMeLXwU62Xox0sEMMMvmqpmQlkgzR0Dx94VD0DgukvMpvvSpz4TDrkKq
 o0yjgTCdANAEzBWZsitG/0PRMVnPL/JMSB8SRrPBVPReFjOqvwvhhPSEkR7K1HyRtmej
 IZ4UR/uV+rFv94F/JNCuNwyHhQ1Xksrci1dRmF5kxv+F71DewZET2tuMexcR3NnQYAYe
 Dx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493664; x=1792098464;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wWdjJJ/kiHobdaG6v+Jdrtw5OgD5o7Fqn+e268oN0wk=;
 b=bua8Q41TNYtcwSLnIbdDRkPQzQM3z0KtUJ8tDUA31s8FFcPgR1Lt40OI82ET+Lp4Wh
 MF8WMAYqD73c4NEx2EiytD/a3GzrzJcxpPpSYj+rHf7cSPEBNjZy5oA707KOn0SKvs6u
 jys3GgJLnbuAh1t3NtKWxOhKqb80bmemM96wI+TInNgTKNXHdq/AUMkeXFi2uExch886
 JpsMA89yezOfIk6I/ZLe6IG0ejov5yLqVS+s4rXybq9LqDHek5USQlXw+PLotrFrzU4d
 RT/H8kaP5GfPWUzoAMr9gdIYUBAKdWj1kSUJ1sg12Y8dvoc+Ab19H7M2vKTmLxHMNKze
 bM3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTrFL4ea8Saty4J4fhr2HnNbrEavBcYPFzdusdVuA73yUwZv826AISCp6p/gb+yezoF0ZjwV/KIOY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLVpifcj6ut1eKCnMW8pxwq0cElsDZVuRVM9stFSbTzvTVd8tag
 T/1TlhN16kI/3Hrf2189n9MW16/5bJkbwW299huAadETgbutw6oZ3/EawxbKiYYDdfiPMp3Unoj
 rCfpZsZ6TAtpsLt9GTVg+89/VkZudvaAquKmlVZP/OAXlRJXbMKdsndgbp0vhi5KqDHvENqo=
X-Gm-Gg: AYBFou29rDXBmknGDZRVa/YMt5JhA37+pbhsNC++dbvl3Giyn7C5IlQTI60ayda1Y9/
 VSHeW8NNjC5vD6XLq0AcMefi9NYRZDjNYOvZg+BsGzplT0vX0WlYaL0/VM5hdLJdhed0M2WNlzx
 xM5400zKWY6wJRDDu4nKVSUh1t8uTL11grciBltMwdnru+oL2iDDS81tRCoJHNPpyovNdS2lsNV
 Y5s40gYVQ/87chtqPX9F0S3uvo7qZXiE/ipgvYofCMAFIlF3Dbq9xPo64qyfhsu3cgLuTe0nWYh
 DUHTAV7ZQ0IlD3mUtkyjBnVaQrSM4jXWUF5v41Wvlmyaxpe4WkhZoO7DQwrXjVxuHnHhq3e4m8k
 OZOma7sIZeUWN/OSXcjp2lTo=
X-Received: by 2002:a05:7301:460f:b0:34c:bc38:e2ee with SMTP id
 5a478bee46e88-3537e01ea2amr102947eec.8.1791493663754; 
 Thu, 08 Oct 2026 14:07:43 -0700 (PDT)
X-Received: by 2002:a05:7301:460f:b0:34c:bc38:e2ee with SMTP id
 5a478bee46e88-3537e01ea2amr102908eec.8.1791493663192; 
 Thu, 08 Oct 2026 14:07:43 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm634773eec.17.2026.10.08.14.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 14:07:42 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 09 Oct 2026 02:36:39 +0530
Subject: [PATCH 5/5] arm64: dts: qcom: nord-rrd: Enable Adreno 753 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-nord-gpu1-v1-5-a06a6c57bde7@oss.qualcomm.com>
References: <20261009-nord-gpu1-v1-0-a06a6c57bde7@oss.qualcomm.com>
In-Reply-To: <20261009-nord-gpu1-v1-0-a06a6c57bde7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791493618; l=768;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=hOU8TrSd+zHm12j8RPbYrqhepq7ttnj/qRjqmRqUawk=;
 b=IevTAqvF/aAxKWWdXsBJ9C5sJVLEsZZLhXmZdLDXZsg5/UNdxJ1OAbXaq4Jld07pbnowfhYTL
 r0WNdB3ClwACaFIZxqTMlRTcmzFFM959U6yZaFkW97FD7iLo70fks0U
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: Z_Yzz9Y9vDI-zrCNvhSejGMsuG98VoLI
X-Authority-Analysis: v=2.4 cv=csYOAF4i c=1 sm=1 tr=0 ts=6ac80620 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX4HqvtJhLEskt
 K6bEDNls+ODs6ceEATipNOPibfCpbdozFHSO8YxnmIToc3V4Y3igRS5C63oHfk0Y59MYgRGiwqj
 ipqqppxM7pT8dZ1fYHafUNLtETxJyIruobhlQP8aJZoTrAUcdqnsCef1/hob/iEwXUYt6juC81L
 hZQnJFdbPZBAKilUrWf9k0kufdsUL4gJIIwPizbmQ9mv5SRcVkO9g2wCdRs3TvGLh5yMgyP/ISz
 mTL+WusKDeGOikKHKKAD3IzhKtl3pu1D220IJ81clPXSQBuB6IFSeGNRDsZQ6dr36VKjcNse5bt
 EMUzHc0U2MGr0BsN+RvY9LOz2bNyIjIoxQ9Y3fv6f3R21l42uN8q5RyroJSLweFGkTtw7lScdcM
 vG0s2ri9y5Vy3gGEJ3qQPC73DFWQhqF5iTluDs4G6AR5tvCceMM8ppFoVFgaA1KW6Hcn3v4bAXo
 P3nmT1Rp04Y5rx8s+cw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX1DlLmQxXh7/K
 X7bYGdjd11hUnk58nTdGWuG7kpZJPhPY0spIVo4pbw84yzNw3Y/4JTr98RAJjby6wcC5oenb6FZ
 W+2+y0eyyq+swPid1hmOZha73yERWpI=
X-Proofpoint-GUID: Z_Yzz9Y9vDI-zrCNvhSejGMsuG98VoLI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080084
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

From: Shivam Rawat <shivrawa@qti.qualcomm.com>

Enable the Adreno 753 GPU on the Nord RRD board and provide the
firmware path for its zap shader.

Signed-off-by: Shivam Rawat <shivrawa@qti.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/nord-rrd.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/nord-rrd.dts b/arch/arm64/boot/dts/qcom/nord-rrd.dts
index 3673003c8b21..8f215bd04fff 100644
--- a/arch/arm64/boot/dts/qcom/nord-rrd.dts
+++ b/arch/arm64/boot/dts/qcom/nord-rrd.dts
@@ -364,6 +364,14 @@ vreg_l3l_1p8: ldo3 {
 	};
 };
 
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

