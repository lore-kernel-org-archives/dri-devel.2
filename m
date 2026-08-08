Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A637C5AD4E
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 20:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B237510E0BD;
	Sat,  8 Aug 2026 20:24:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FlNcJ0t8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="khe8YoYp";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32AC810E07D
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 20:24:08 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 678KItLH1098397
 for <dri-devel@lists.freedesktop.org>; Sat, 8 Aug 2026 20:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 01u6cdInuZafszhJdWqPh5sCL8liQnvk2eQtr7otZ5g=; b=FlNcJ0t8cBMZQlSo
 uh/lPuAQr7QH6VsnLDgUNI+a0RuhGBZIDnGgQEYcsIB/kQBd9FKApWNXS+0qcIlg
 da0cI02Fci0Q3KqmcYMWgH4cFvMwHc1cs8pCsuLNIS1utHDXw0UHYGRfmOMVOdJ0
 K5YdMraYExRGCTcIs39NYMfatpsdwMyvuQymKNwmtFRfC9Ygu76rq4acaspIqDEq
 rJyulnvbBu4RApGUEuOvD9bNW/n2uLxIr59jD3fMzM9I8fucaNqPZokQon9t+n8u
 gLrao9pSZvHLNV8NNjhIm6TuuEa0AnxBIz5tIYwm47BOx97sPudlmjJpPNqFid0j
 K7MZbA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwuf79rxw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 20:24:07 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e4758ab46so751150a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 13:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786220646; x=1786825446;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=01u6cdInuZafszhJdWqPh5sCL8liQnvk2eQtr7otZ5g=;
 b=khe8YoYpXoAWsmktYsdDsFJwZd0Olc3W7djhy74smd+qVzV5fjsC/SrbRGq7c7GnJy
 5iQjRu+EHmBXcp22qXaaObGSbI6mQuJ7gCAFkqqZbakZS+B21HNLjfNdZLhhF/R57CHa
 neYnQ+U8K/2khhMl47e5eLroIiz0/GyPF+Fwm0weHM3BfqLWn7WQJTtgWzNpjah5lrcl
 psgA1Fp5FgYcr4vmN/2gyH36xgCBq/YWdUemv0yGAoHTavjyGByd4qkcQjrmPATyBQ5V
 FlYLmIUsle/dAt1zP/ZA5jlIH5vezUtSPCgV9VdJv+JZpe9bDY4XR3cugp/VNCA7D5PP
 SUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786220646; x=1786825446;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=01u6cdInuZafszhJdWqPh5sCL8liQnvk2eQtr7otZ5g=;
 b=fPD1jkj2HRWWf8KwAmY3neQgzAGVEDK/Ewb2YDGZsOObgJp4QnYDyOQ9jqxx7UTqbe
 PQY6SpjqRoXsJzgYENqqj+MBaWkQ8C2TzbGtZJgPpfH0ZNk2gpAyG/EqxAoN4ps+rnDd
 LcnvFshg1QfOy7R0o0TiXTTdCxibrzXD5q/SiC1QBlcLEQphvVHo72iH+dSVT6ex97JG
 xggnSwxoEJOgloBCqQL3Hw6FkHwyJ2I3jexP/FPgT+hoCtoL2bN6o+rZNgj6/+8p7c+1
 B9+IBsczjPwVUxt344L4pnz0e1yWuHBJ6ShzAuAlWnKCNUVOnAjF75iQmbVlPufvV9h/
 iKXw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrSULoSVRMjHXaQNPmfZnZazkP8VsImxSuEVVq38Q8ZmpOOvM7rMa6isepSOUZ+z3ivn46Yt2sdi5o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhqersGOWd8esO2yZZyUvuuUwME5tr1f/QeSAwoVGUAF7MEWkz
 J5vOGT9hA/yEj3u6eXUnAxIqKnRxb0qH1mh53QqRf4o2T5P/qB2cV/H4ONaSIBkkWrX7zVp5DbQ
 dml12GH1jLqbHI3vH84iQdxJuxLigdnwkcFAZ7ZAwZyUEf3jb24L9Mfj376b8BH5mSsND+0/BII
 MySMY=
X-Gm-Gg: AR+sD12b/zLFFX4qO1P+FVK5kOhhA5a7orez+/+H0TZJbaESYm/LSpRzXzMgCvg+1JA
 W7Yvx15dvW+Fg8f57V7MYBCQFTADsg6mlTC1YEQjy4kPvq3Mkur616T5WlU0t3eVJobGGr4Y4vj
 NVskdLKTvdD1FodIDgrtBTBAwhyL0RJ+6Yy/eP2TXtghAhUjs8eWWY9ud3eZkq+MWxMKfZ6IkSu
 H9wHgMilPZhMtFUbAqH/VxltTIxmteamwrxkWvVeLjJoPAmT/B+D8KsqY3xb+kLQIyf1Kxj255B
 oLxlgYU5Ie1j7cwFr7GZqaK+bGGI0O3Yg8BaICUd6ztktlASnZF12/Jf1qZF37bW1m7mhIu5Qk9
 lD4ljdB9xkEtqjr2EIK9AnrjU
X-Received: by 2002:a17:90a:dfd0:b0:38e:5ab7:ce9b with SMTP id
 98e67ed59e1d1-3909d928d54mr19724773a91.21.1786220646155; 
 Sat, 08 Aug 2026 13:24:06 -0700 (PDT)
X-Received: by 2002:a17:90a:dfd0:b0:38e:5ab7:ce9b with SMTP id
 98e67ed59e1d1-3909d928d54mr19724736a91.21.1786220645731; 
 Sat, 08 Aug 2026 13:24:05 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86e917sm26357417eec.5.2026.08.08.13.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 13:24:05 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 01:53:13 +0530
Subject: [PATCH 6/6] arm64: dts: qcom: sm8750-qrd: Enable Adreno 830 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-pakala-gpu-v1-6-207ad1fac1c7@oss.qualcomm.com>
References: <20260809-pakala-gpu-v1-0-207ad1fac1c7@oss.qualcomm.com>
In-Reply-To: <20260809-pakala-gpu-v1-0-207ad1fac1c7@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786220595; l=735;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=ymhS+3e4NByeoLtvhtUzi1OU8oKq9ZdqernyZjiEAeM=;
 b=uYjdjbJ12t5VAKxIr+XNECqLJ2vbrM02URqAEEMTZNYKgw6+E2KGMRbEYVaJ29qV+aCEKIHAx
 j41pxbg/WIACKFH84SmDpzBYVCFukR2yWvTRz2H1vQg2XjMQYUVYkpB
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDE3NiBTYWx0ZWRfXxIMUdvpzfEjD
 loxCl3cIHnT11Jp0EvD/s3wQGWRVMCJVJcOfk12+SONSJGUYA1me8LJclVJL0l0OyHvAPARCNVt
 XsO/Ch8bpNRLk1avGmMYO6ayWVqvkLw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDE3NiBTYWx0ZWRfXyC1pFkN9Xd/E
 ZIsj1e+IT8FnM9snJl4HHZczq5ZI5eR9pc52R1kN1Srhxw9kKfJoMTwsJmblTb/KzYkwjbKQq3u
 sBZxNzQQVyC+2V2vz5CeZdW0yu5vlajw2I2qCQZKWGpEj3dvXPXTyjAVXHL6psJ1ZhvTaj6KVnA
 +fNOT3g+ZrXn4t3rRCAprhL+8NbGH4nhgm3q2sdBqlinqHnAbP2BHnqMv81t5eaS91p8ugcExiD
 41MAwgjbaqHpIXCygSmyESELwbxPW3DhWYbL5WbfpCFSQeBYC/5qDRTXSodN5FgZNWlcB8DsL3n
 JwViDpwArOG+ZVeWmmpdCA28xim+6zwCnEOCL1kz2yXR9Us4WtuT45/SClIW8jPj1j/PpGh0b7U
 glGO+6YciV4La43ZFICZqUVWNUQ8eEL7LZkmjiez1pgGV8uXRhjcKlygkgSCMSFIVtAtQI+q47B
 a8bPD16JmOKzw7/JG5Q==
X-Authority-Analysis: v=2.4 cv=ecENubEH c=1 sm=1 tr=0 ts=6a779067 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: D_S3RXjgZaJIc2QOAwJ7Cpdiql_jeuhT
X-Proofpoint-GUID: D_S3RXjgZaJIc2QOAwJ7Cpdiql_jeuhT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080176
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

From: Jie Zhang <jie.zhang@oss.qualcomm.com>

Enable GPU for sm8750-qrd platform and provide path for zap
shader.

Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
index b56317cfa9fc..75927e1f7b9a 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
@@ -858,6 +858,14 @@ vreg_l7n_3p3: ldo7 {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/sm8750/gen80000_zap.mbn";
+};
+
 &iris {
 	status = "okay";
 };

-- 
2.54.0

