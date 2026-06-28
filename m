Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44895C43327
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 18:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AEE510E670;
	Sun, 28 Jun 2026 18:25:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XJWDZsXy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fw04r3Xc";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABAC610E670
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:25:15 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65SHieoN423461
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WEEd6pGIHJ7HSv0pntu9QVw4caHLnNnK53uxzqrs9Zg=; b=XJWDZsXyybmXtixy
 TD9TZjhNYlVwupMIKDj9ccUekygjgyb2NuRhpgPoLs8FQ8nh4FrmHFtjJK8OfCUE
 TzJ490W5r6MMnxRQghIRMtQs7mRwzHxQ8cqe+cZdT7VclxE1rMDa14L8OfdKtIK3
 q5jqmu2p6FmzKE2kU+FLalq7ysbj6Oh65RiGwAqmd2Vm4iUTo5Jyou6E880qZ2OW
 bInH4OR3letKay8hMZQRrISDVRFDG4kk+fwOdLZBf4rqjzz7yM+GzCKuZlRnLr9r
 OakVsTWVs2/f3s9172k/w8xzPP4nNeh370kQOvYHyE+9lBMPY864HRQ9IA7QKWpK
 PO5nJA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f279ckb7v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:25:15 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c17f62afdso2354613eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 11:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782671114; x=1783275914;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WEEd6pGIHJ7HSv0pntu9QVw4caHLnNnK53uxzqrs9Zg=;
 b=fw04r3Xci20q6kHEhpBbD7ZfDL2qRicQuyVHJtNAu/hBXSvzbCXQ1E+6JorVZ7+AIu
 d6diDZG0BGD2hKK51uLKbngsG5vBDl8y5L9yfV4HQTLa0tgAd7KduGDMLbgoYBbV2Li7
 5NjepQyhT8pMqNSe5mZlcXjx1jpGnug+AbmbPezJPwDudp+Z/b3SHKNe/5Z2T7u315wA
 3r6V19hd2VXEbsrFx8LPbKUkkN16Ia5tl02tRE983SFCj2MHZLghI8CUpyeR/D95jVdZ
 s753DMsIys2Y0xYkH6S6qHGVw7Xm53zPMKiG2uLfwj0YyxHjCEOPKlkL/sbkFhBu3EYY
 AMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782671114; x=1783275914;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WEEd6pGIHJ7HSv0pntu9QVw4caHLnNnK53uxzqrs9Zg=;
 b=BE2igVdntQYHzJRp7EwT5kRaniJ3kRWfFw9R9qidZ6NZRSSYAQN3AjU04X2p/7kp3j
 y0w+C2iwLZlbVmWj25mRhtDJelLFiAIxvDdD6WsKZ5y7yiI2NFNYp32pVWmDOoQRe4sl
 XoIP5EoPJnwQWVkbTddODiSen5mMwUgqwAB/CWOEQ9CVF2kQxNZSKurHYaEbJDDsRgzZ
 tPXYO+6tu6jlAbr1HTWdQnhgN/1+7xO1SWPyZAQJ/AkkVaS5nLq6HmgKHFYdhNOqAWqI
 /bNkR6FZ4QX3h0QQ+lclkAIMW4CqO/swgdyPBOCPK3MjH5FKTem75gYhHDr4mRhVaVG3
 JbOA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6k2J2DvvJZ7GDgJLYHMVejYGiZVbvSnbyMWOwB5H57VOoPT8W+BJCYPhlhQQ7yV6It9SBXmbq3hM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxAklW3qnRvfxccCzVaFbCuo9nivwQP3OnEH3Ro2ATZZSahuFiW
 BueVoZefNs3kO8aJ520llIGUfzU0wfjpoTox3/AFJEDh8F2cdKDv/+hqROpP6MTvkJnBAqgKVi+
 kaFfZCrrY2HqoV82dLeGHsayEBJTgqrT4dQmZi0SlLHPuRYIt97EFK5WzDHQkaQvQLV7vA9EdoD
 kj0bE=
X-Gm-Gg: AfdE7clWr8TGIilQ5jExv7RX9ejVz7n+DTHnA4gW4meo8OLvxB75Cn5MqdaUa4UKe4O
 Odb42BVnUl8xkKWQM31GhTOi8XW0lHKWXyDPFNVL1I9G05VhuOlh6Xiw+FMDdK6Z0uvoCxDgNY+
 wldn/1cb6LChOhn+l838GkzwD9bGR69wIJDbqAqa8T9D5xdrWMxD/KVucwGAU/ijJE/CdWRl9r1
 Zo4HH+92vnzw6FLMYRoc9lGS5MibNPnh2sZLJzIgzKr71dLEW9b0vpyKzPU3xOr+hcGvIhiVJMg
 N4SlIFdDjzz0uTesM6Y8qF4ww0EnjSu3qaiU+KDYytOSyEeEyi8+SRD7yeUWU0DxqySnZi1uCNx
 CUNsKqjQhTPeNnaUD+utqrH95GyzWAn0b8fM=
X-Received: by 2002:a05:693c:60c3:b0:30c:d03d:ccd9 with SMTP id
 5a478bee46e88-30cd04d0fc1mr4515724eec.7.1782671114448; 
 Sun, 28 Jun 2026 11:25:14 -0700 (PDT)
X-Received: by 2002:a05:693c:60c3:b0:30c:d03d:ccd9 with SMTP id
 5a478bee46e88-30cd04d0fc1mr4515687eec.7.1782671113915; 
 Sun, 28 Jun 2026 11:25:13 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1a75sm37508218eec.19.2026.06.28.11.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 11:25:13 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 23:53:59 +0530
Subject: [PATCH v3 6/8] arm64: dts: qcom: shikra-cqm-evk: Enable A704 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-shikra-gpu-v3-6-9b28a3b167e1@oss.qualcomm.com>
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
 bh=uABArrmcbp7tI6+l6+GOP05oGpD2TXxtwDJgJbxPJ2c=;
 b=zu51LUxAMig1yDaYoqIMlPTJ3nAgm4JPkQdk45v4XIneHJFJdXsdBfMbW7Ec9GipESIbRsT1m
 E9agdOA8VanBZThtAfeTyOxBDPVcGJgnX+VmRW9w2JALr6auGuyEtDg
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=evzvCIpX c=1 sm=1 tr=0 ts=6a41670b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX5Oz1GY9ZhCKf
 PNGtdCquiRgZc9+dad+BwdTvrqKJzbTqsTG8oJ0GK/OuOfaM1Rto+1NrJOyct/Dx9SbP0oc2g3M
 7Z29Af+pIo15Nh0wP3OeUe714704LOc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfXwiAYC7ExNlWq
 W/83a1y5p8R4ReXNnRcUu/I8IWOy0spgGSWHXjZGAnVYRFxWdjstAA/2pjEH6rWDPrXeXLHT6A8
 KlI98+6URzJzLAqDDL3t4Iea0sp6Nyg/5XWU2laBLNGuFjUcy7M/4nvSjU8oUzkVz7WZWdJx48v
 6EEoV58PRIBOKPd1AwaDoYfh2xCB1mB4waVnbjt2GUU3tVxTWt7p7Cx9QRJhZn5aXqtgUWFWSOz
 C9acxpc+82B5x0avAKA58UEdtD1cWPgCDP+ykUrgtxtGBSx3MnLpQLsf4WmR1pyG9D7X5IYLTsG
 bO/zXVV1zGgSfE9wj6TD4DBJf5L4cTsxcpOpXhmb3ShwFm4c3CvPTEJTVUQ3e79ZPI4qG3yfzKj
 4rqtut+3ndJchRV9GiuOP8jQIA4tdg3hPrpmtdPeYG/oiOh2er0k4S3pWMcWtDy14xMulAdFfYU
 g15twGjbRpRHlF+91YQ==
X-Proofpoint-GUID: IKxJ0ADn9inxPeJKsChol4ASivUyeIN8
X-Proofpoint-ORIG-GUID: IKxJ0ADn9inxPeJKsChol4ASivUyeIN8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
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
Shikra CQM EVK board.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
index 0a52ab9b7a4c..d46132e97c69 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
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

