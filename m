Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078BEC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 08:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3295610E6E8;
	Mon,  7 Sep 2026 08:49:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZL3zZ0a/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aGRju3oe";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B36910E709
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 08:49:03 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68777e653903347
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 08:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d/0hMYtV0AUTvKgdIzntIko+FkAJyCqkPlgmbhqUNjk=; b=ZL3zZ0a//OqFRTiZ
 BVksRn9MpDegor2kl8y1SmU9no2vhNptk8la6MFQedNLeBqIYkyG1uCzcXQviN22
 gsEJbb+gBeD9MmHMDC2yAjsCc+GhbGGSfm8AeFNpp8+XUvDfZsi7OvRjOnUvNvef
 srOyl0NrPrPIXm9p+zwuuXR4kaQU9SUm4ksGe3VSmAJXee3dl9JqxCIH/LX6/UOW
 ZuLIV9Vyqdl0M9vMDfpGaWcnvCjfRgN3jB4/lEq9O2rlZDEkO6iQ/LlTAnSipfjW
 P2WEXTl/W4/gmz1gE5xf0Zu27H85vKRj6oPXRkawQlMXXK82+agOwQYVnK1zppws
 Vr59Aw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggany601s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 08:49:02 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9375d92d8cdso667294285a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 01:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788770942; x=1789375742;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d/0hMYtV0AUTvKgdIzntIko+FkAJyCqkPlgmbhqUNjk=;
 b=aGRju3oeTbyvW7Dd10DRT/eoYD98m1dJeJkCGt/CBZWwHfm0Pf/EaNrayRcyaC+WDz
 J92+/J7RksDuwta4Lr18r9GbNxdfu+vdI5sV0rMsjAxSXpFZH8nZEXqPWxu+NV4f2POQ
 EzCC6X8bIjJ8Woyd6wr1FXbZzcRcF2GRavBwmY8HCmwo02xzgsRb8o0NGVGRPugo5xID
 0z7I1DyL3t+kjP95USydtvuYl9CMQNFa/Te9sDK2hDjV4dFDRId+1/SYHLSInD1Ut1c0
 rZwKKoyC8cx0RFQWk5wQ+jw2cyY8cKjN4yBLbGVHsz9eV7/kLINkvepfehBoDNUEjjn4
 w8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788770942; x=1789375742;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d/0hMYtV0AUTvKgdIzntIko+FkAJyCqkPlgmbhqUNjk=;
 b=i2zleV4AhFx1CfWGl9IGJEJn8mxuylHBb03v9GPA/QbUPpwHG9ywBM05E0PtX2Tger
 aE5y8iNKltSV5bmwkcdxjHlQhDumQe1veqnERB04s3AVg0uOZlKdr1SGH6cX413iX9FZ
 ULMvA+oWiRdTkwGx9yoZnlZayE3IocRB+cbqkald6av5kF7v0ndDAoo+Asq7PZz/MZkZ
 Np7Kz7K/ptIIcQkUq1Y1FudFILGpGxuIB/FIacwE94cBElPqo26WnxLI3FbgFVaessj9
 ASimiMVVmcL2gjIiStRF5zWMwF3X3uf22c/lgQGShvN5BvBrGFNINyeVcEkHVUe4KwXc
 oOVg==
X-Forwarded-Encrypted: i=1;
 AKwUvByz6n3wF9RmJT/87mIXZbvX1UM4G1O7VgAr9+XfEYVYwbMw8PtPZR+10OQ/ycZQFYRtOLwp1LFsVGo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kODFJNym8NP3hXCKxldMcK5PVJ3kAPhhaHVWxrz+3Xl9+hql/m
 kYMCstQWUJv4VBcTR6OPx20ybNrZ6ofMsgSrEQfK+ipazl+dcNbvJ7VseqwhmmBmd/vtqs4VmPz
 nOJo2q7wH2umSm9k5oqFTs3D9rzUvRB4opoOUK0tG3U/7NFv6P2bYzGfWPd3jIPPvu+sP5hM=
X-Gm-Gg: AYBFou0yGJV9nIneb8lgJxFsYq7CxS2zS9Nrqq/oLuIXbF699b0jyxaShVWl/5AjMEK
 T/afK3X1hWhne+CJKDADrn1SwTpO/FMyef11y4rYIDtTdDhxTlTS+VPltkJW6Sufs0QYqFfIEkJ
 P4h9FfvgD8PT275Bgi/MRN5gyakI1W4hnxFWicpbWZIJ8R2wa3JdatbmNsvyWJTyLLCC8yXivlk
 GiALDxS8YZasSclHGCeTjn0n883ze08nuk+4XBfrj+a4fDfoTcy/DhUTcZvKR+CU6sMCrzCuO6N
 uZoa+EhO1rJaO22C4QKSSjUI4bXo0WMJ2iKjYn5VLIDpe49ZRxBzUSMD8K/hKfYOsBIqdPDDhUR
 2yCvGJbg5EMcOxpq0gur/Yt68sw==
X-Received: by 2002:a05:620a:43a4:b0:939:6de9:4cf9 with SMTP id
 af79cd13be357-9398072e3ecmr38296885a.44.1788770942190; 
 Mon, 07 Sep 2026 01:49:02 -0700 (PDT)
X-Received: by 2002:a05:620a:43a4:b0:939:6de9:4cf9 with SMTP id
 af79cd13be357-9398072e3ecmr38291785a.44.1788770941737; 
 Mon, 07 Sep 2026 01:49:01 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:48dd:b57:9236:95f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d07b371afsm191513345e9.9.2026.09.07.01.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 01:49:00 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Xilin Wu <sophon@radxa.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>
Subject: Re: (subset) [PATCH 0/6] arm64: dts: qcom: Add support for Radxa
 Dragon Q8B
Date: Mon,  7 Sep 2026 10:48:58 +0200
Message-ID: <178877092324.9461.18090953151782895380.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X45i7mTe c=1 sm=1 tr=0 ts=6a9e7a7e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=RT5i7AouTkpRziyCYWYA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: hdBEOJN4AMVdwIrS3rfeJu6wrZPVehsh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA5NSBTYWx0ZWRfX2y2ceaIRE9wP
 2eZPea+sUhFmDAZDD+qnEewANWkQa3S7QEDcPmYpWoHzrg+m1NF+ez9JAtHzygCuQTZgLm4Jlag
 6XaX7xGtiECVuQI4Ja4wwadlwcSGqVwTAO1ETvztKppNUfYaocx+F7RWx99RAXYV4pzZXAzLQhU
 GQzsso1HIyFuZFa6rCAhXJw2Wrvv4llO6LZuCIBF8tc3WuNZ2V8wRMnX4quw8XLSQNLdx7Z7wzz
 VRaZfetBIUDBTdjEaESR6qv5k4J1cdgjX7xr+AwBuNM+IR6hf0A0HU3Ilyuv1iXByF6MyTeha4E
 kBUJP9KN1LTs6bnpbr5NkwKvh1W+RNtX648dgKAM+zjl84lWnn2f/eWR0ST7rt7dztiktPVkyge
 9K6qqf63Ih1Lc3vnJEkeCkpwK8X3Sng9vRHmA7d1Xn027NQT7q2ErM7JIqH7/mcJpPYTHlRUQzv
 MK3NGsAoIA5RFOnX77Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA5NSBTYWx0ZWRfX+AgTmdWOyd3j
 Km9hDxGzn2FzmjSda0A9d3N2iRVLdcoLwtOrWtl2MwLm43LQmPkCeUaLnWDwE5q76ovRir38J20
 c/AjLiM4YBfsyeOzvqYZKV7ALA/M5nM=
X-Proofpoint-GUID: hdBEOJN4AMVdwIrS3rfeJu6wrZPVehsh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070095
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


On Tue, 01 Sep 2026 16:47:53 +0800, Xilin Wu wrote:
> The Radxa Dragon Q8B is a single-board computer based on the Qualcomm
> Snapdragon 8cx Gen 3 (SC8280XP) platform.
> 
> The board provides UFS and microSD storage, two M.2 M-key slots, an M.2
> E-key slot, a QPS615/TC9563 PCIe switch, USB Type-C ports with DisplayPort
> alternate mode, USB Type-A ports, HDMI 2.1 output, headset audio and
> a 40-pin expansion header.
> 
> [...]

Applied, thanks!

[5/6] dt-bindings: pinctrl: qcom,sc8280xp-tlmm: allow gpio-line-names
      https://git.kernel.org/brgl/c/d4f74023be11eb9aea9a8c0b0582f20aa2c2640b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
