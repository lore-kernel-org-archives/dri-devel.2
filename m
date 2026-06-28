Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EC7C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 18:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DE2910E66E;
	Sun, 28 Jun 2026 18:25:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Orqf+F0p";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HArHQgNk";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0274C10E66E
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:25:23 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65SHiYKn415882
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E/Adwkoxov+upvWUoqX+Dqc020CT53dbeXdpXRu0FmQ=; b=Orqf+F0pLb/58jZI
 FhZ8Ls+LPFICJ+Jq1rTtdumHPi52Mvy70o2Yugkd0K6l1w8x+aW69fkBewkOuFVf
 tMgiGcjUqbj9ho/thCLppGa+4rStJetrNuoYz/Enkx8/VUv0yW3GRYti3Yn/UaF5
 i5Cm6xAvzQjoNl6Y177spR5jSt8J+D1wfTjYP8poRNGLyhfEY7/2DfNBfn9/EEXK
 56daBXJURjprC3Mv4Nehe/YB0ZzxGIGH9cecGNdMnix3An1TiL42O15OmyA7fVGW
 2QyNNahUgG2+CO8rjmJ0aFtS6yFv3xKzgJGNIQdLz1LOdvNm4oPMzZaAxFXcENXO
 ugjaJQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27t7u9f0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:25:23 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30cb2bcbf7cso1972715eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 11:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782671123; x=1783275923;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E/Adwkoxov+upvWUoqX+Dqc020CT53dbeXdpXRu0FmQ=;
 b=HArHQgNkxiT0rF+wckHFeYLEBWRVrivF6gIYzmOIdKY4hzm4zmabbqWOpcJgIat5sq
 8QKp3+GLT0K0eYxBy64Fi1gr7ZPc0rfhKyB6erCQjaW0he7IXsyJIya2+itCacBNXn1w
 MNiMyXN87WtST5F4HHhKUi41cygsbtl/0Hy0MINg+sH7Li4v2sRX6Bo1Zd/4pEHaDkDQ
 sO5DzEMBgyymcoCzzuLfbphbmcCCyWYsx9X6U8jkIpAtWMImaFexsNPZ6XKl6jTEhEWU
 eug8OR7fYie+ZXqy5F/IXBZXWar4MxzaRvTS5f1Zx8ztNK7aF6sNeGHeFsrlTl22SddE
 BzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782671123; x=1783275923;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=E/Adwkoxov+upvWUoqX+Dqc020CT53dbeXdpXRu0FmQ=;
 b=ZLkS4JPsQNnOZB5VCp3EcGXDE7/474qLI7GYyK9w6ekgxTrNYVWr6csy2ho4W5YaSm
 o/+yNXJSiSyhkFQwySE4H+EjD0IR4+j6rJgvoLUuSgGFUbsiBQf/hsvJDgDcNl0/e61L
 IGDFXZkIB9DqAvmDehPbh9O2DJAg6CVQ+gcMidEPls67fhaJ0+gg+Yp2Oyr5EDf75K/i
 VrXvoQCoc7/2jE3gooMUuWvMfPczDe/SVxRYU6c9YDi+/Mn60fHP0YoY/gMUcDpIuw6/
 +iIyEuukxqGGkKz//hhOhVPBMuvoJRwTc7hOy0CgoQ72b8n/D5ekGzKejC3E+8nPP2KM
 E3jg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqg+m6qh9CzK+7o/eWogNXRmc144J7FvFUAMrsydisEiHuIO/QpkcBLapBw1bWHzJat2J8OKE0WD90=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKuGwnrf79jsp1wTU1nhVMNC56lbIcxDBKIUy8heeZa86YLPt3
 SuVpkxrPWmBLb8ko4vbNHbX+rQFJwCnRvMla198e7Nt6k80htPfk+gsBx5vloSs3oYvTDEkXSXU
 /FwjGOkGDE09/007JHKLBzBTL1l2LPIwTMbTrmwOOcx5zMmcE3aAJChLEe5pYXP8LvvKZS7Da8k
 2lb+U=
X-Gm-Gg: AfdE7cmACRtgFxJD9dxaMYrTJl1AZy+7NJ3th/gwrOme8tnHX+zigjKuWeJ/BXGY5xP
 52YyBFANY1NEwNeULGtqAtuc1iojmXiQBxR/iioRz09EhJNxHFJbRwb4MkphXkFKcPkDIa8oNmv
 LjVyd8UZUVixf6trBlFszq3tEYEGjoS3/QiKQxaa9J5So+e/bJV6jvIjbYD8KOcGIt2chhk3EDp
 RO4ht5rj1sUnpX1whqxwpese6/LOj1G8w+Llea9WjzGHHm0RnERlpl4j2frOZbvvsVyJFPFdjXO
 MPkM+7S9q2J63FxWE2NLQWUEwO+WUJW1K2+t+XKG8nEUG7ASz8gbOzTKZ93X/veeApfXEKhYdXk
 MlYPdxHSeh5e4d46N3pq0wGUI2nNTsBhq9XE=
X-Received: by 2002:a05:7300:6d23:b0:30e:c38f:eaa8 with SMTP id
 5a478bee46e88-30ec38ffbc9mr2680830eec.4.1782671122845; 
 Sun, 28 Jun 2026 11:25:22 -0700 (PDT)
X-Received: by 2002:a05:7300:6d23:b0:30e:c38f:eaa8 with SMTP id
 5a478bee46e88-30ec38ffbc9mr2680808eec.4.1782671122355; 
 Sun, 28 Jun 2026 11:25:22 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1a75sm37508218eec.19.2026.06.28.11.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 11:25:22 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 23:54:00 +0530
Subject: [PATCH v3 7/8] arm64: dts: qcom: shikra-cqs-evk: Enable A704 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-shikra-gpu-v3-7-9b28a3b167e1@oss.qualcomm.com>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
In-Reply-To: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
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
 Aditya Sherawat <asherawa@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782671052; l=803;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=tpJR8ANAaLpNkDfQVcPg2PDtoJzHDFbD5ZJyKcQDLI8=;
 b=UrwtznvEchsCPw2f5j1Z1h0DtgwgaYYoTKCdTBRg8y+Ki3D0VxImpc45UOndP3zz37q3BG6yE
 WXiLutKmQAqAzUYa1pzJN0Hib1HgeJhRpwgbC9jZgny/fpmO9bmcx20
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX0rPPsufVYlsy
 ADUl/RmcYnoVkkwaYbA0Puqf+YAgh1Ink7Nq1qA++qlb0om7mFt55ZfyGyphuY7sfwsot4r3Q6s
 QlN8+ZbI1gsV7Q4c6ztkiMUiVz3k6dWUqtjVaxoAFcVZgE6jsRi/5XIKkKRPh17YvYPUmC1kwEF
 j2tXwZMWhk2xTMiB8yny2pXKTGnxaDxh6WxD5FT3idMgBHYa/Y1zq1Gr2BkJNtlcZabuG21/QYe
 lXaGPoNbdEi81Pv3vI7LbEsFn8pPTIpK9+kD0xl772H5VuAXZenVxr0APmTEQEwqzxNA13JwYd5
 TIeG1zuPMuaJxml4SH/ycNdAWGuy97qn1KRwglE0/2bFYU0EFI+l1mOB9zbMPQ33TdNpk4JcjDW
 2CeSxiOuDtlwr13blFKgKvSsGz6rZqeLVfaeh6KC2AnrVCaef3TGau/zfVFI9CCpe6H+KHi0maB
 OyD0u/o6KnSPR4leHZg==
X-Proofpoint-GUID: dwTL79neJSwzI5utYiJbdE8sGmWIJSQ9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX9YW2891CqgAU
 VYuTwVSxj4FyAaj6i1GO8dg4wjJgGnmrbP3xQYLKgnFK+ujc6t9cNasyPHfk+ASSK5G4V55jo/e
 1BmRYloVeQzWpM4YwD2h9bO9BZcUb3Y=
X-Proofpoint-ORIG-GUID: dwTL79neJSwzI5utYiJbdE8sGmWIJSQ9
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a416713 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280165
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
Shikra CQS EVK board.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index b3f19a64d7ae..94ef498a2467 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
@@ -23,6 +23,14 @@ chosen {
 	};
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
2.51.0

