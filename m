Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF8EC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:26:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70FE610E3F1;
	Mon, 21 Sep 2026 15:26:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JW1uH9nL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j9CH5Gmk";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A257710E3F1
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 15:26:00 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LFAEld1677339
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 15:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fqSuN/PyMXN5X/SHL3f+HDi1/AOqN1tDdAj6Y2oQbFM=; b=JW1uH9nL/Snp2ixf
 Okzj3RUHUEFMSf5gk/6dblXSflhPC/Tdy2Waq2LxQEo6Ghqofsq24Cnj61k2w002
 lTl6xsIw8V9cGhdkcRxONl59g52PZZ2WEXHf++tKCVOdPx7kdP4pecpViuHpp1l+
 DgEMZZ7GaZRRLe1nxAZ2Lga/H7kvRGzwxRnZI/ecqU57PTnr+J6B5qJofEkFf4r7
 LPjI0goIbbmiCnIjTnkWzxXuOYpg5wN5tI4mHqTjlAUHCOi0U09pWr3J/zOqwnS4
 OvUo/KremDvJLWHdb3kgIMje87+imnTDI4DH9RGQE/sqfmCnEzBK5W7/o1DinFYf
 FFHStQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu3csh3fg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 15:26:00 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c8383e6a13so117790e0c.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 08:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790004359; x=1790609159;
 darn=lists.freedesktop.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fqSuN/PyMXN5X/SHL3f+HDi1/AOqN1tDdAj6Y2oQbFM=;
 b=j9CH5GmkIC+74IA6sXDirO8GsJMu7MEdgXfdlVdxLOTZLHwRSgnzQdDp/hoWtm/bVX
 tuYeJ6ut8DTqudPQOl9od6fvZyBDiYc6MRi3qczbVzNF9rCgBcpqNEfnYucveySTH7ET
 2HTWwB7dy/3YD+q7y2VZRQdaU+lEdIkj3/GSQzPIGK8bexZ3V3mf2HzZnK1+F8OHRkDO
 +0JF7K+lEq8ZCrvEUFQmzJDbZEU6qDAC79pCCC8re0AA6sVolJRo3f51j9f8JIXhuKTl
 m7GiyCVjkyNtwBlMq/oJ+k6i6heknViJ8THJ5QA7QJoREpLRjsHKb6fhC86DjMe/BRbT
 jBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790004359; x=1790609159;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fqSuN/PyMXN5X/SHL3f+HDi1/AOqN1tDdAj6Y2oQbFM=;
 b=X1hfwJWuPBpVxzhwx2L1ErbgjB3uSuOXRztKfYE9OaOPtoZiOjO5c69VEKlJwbf1dM
 V/Xq2Io+d7EdkJ+JUdXHRCLf3vwyXQ2UwtTSTgV2HkH+54flsEkKEQzF8CtXlJHmn7LU
 yXzrb4UWB/g3hDQSf39lPW6FbjeYx5QLxeuopYZSCP+RvRK/XBOliEdLaNHsHE7GwV81
 ZIlRVRcdLPHDXN4kF1s3dheRzc5223nagK4P+UbY1TKygXvP3fyPhHuas9VKbZk6RbA+
 3BctkjxsUUnDoY4Jw+smpuqCaExyjVKC+xIix7W7DyxOkbsq99lMOmsyGAjlF6q7dR2Y
 WwgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/1vXmVCG0TakIDPvBwhSWKvPNkevB1Rqc+eY+a5uaDBJNf7ryQnVwU1vr8dVYCRAeyUs5RiUqCAU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n0HxRKbUtCUdo/7OsEi1OvYgbg17wy7qkO6IZDXVV/ITpEtmDW
 31iIrW/My25h/hsE7cKbCGs0hGZKa0msyzU40DtuEjPL85rMY3Lj5Xp40gXztCfYAZ5NRvplXTg
 Mk9smgz8OWSOyk6Impz1fGzYpG9Otq2s0mnog6/zKOy0LSCTgl+7J+ncUHeoDk5/DxeFbg98=
X-Gm-Gg: AYBFou1jK+qGId88LygHIXmT0Q6CgmZ5gO019ZWBAdu/gm5JLhz28aosXc8EDxCTWzc
 zLk2Yx4Uqr/aVRGnd2zIo/T0HnMdTouzMkLgKCiwqdAs4ooq5ruwHkAuxLEdjjPs489h6wq8bRq
 ZxdWpbQMW/Y/TpXNNzdYzCl4vhUEgGUO2mpgc/OhCIgn4SM0n1cPO5PBJHWeWXGc3wEWMC9s8b1
 zzi9nw7LVLfPVrXI1Igyt/BRz6Oo0HmbeGtYOPZsuUErX1l9UuqtNb/QPJKFIO9GZ5rjsQ4pu/u
 UHgkPBAiZij+YEPv8ZdkqWKMCO6hcYu2uVyWf/prnpYNZbxZJ/YDDJtSrqtOop6BFVfzwwvNqEg
 CVTMdqNPcUr3d55SL+MIG7BVcO9aMAJMngw==
X-Received: by 2002:a05:6122:105a:b0:5c9:d4ff:39bd with SMTP id
 71dfb90a1353d-5c9d4ff3d4dmr1718449e0c.3.1790004359124; 
 Mon, 21 Sep 2026 08:25:59 -0700 (PDT)
X-Received: by 2002:a05:6122:105a:b0:5c9:d4ff:39bd with SMTP id
 71dfb90a1353d-5c9d4ff3d4dmr1718412e0c.3.1790004358715; 
 Mon, 21 Sep 2026 08:25:58 -0700 (PDT)
Received: from KDYBCIO.eu.qualcomm.com
 ([2a02:2a40:15fe:b200:a47f:1f4e:75ce:a149])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-487244229e0sm22300755f8f.4.2026.09.21.08.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 08:25:57 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: Add Lenovo ThinkPad T14s Gen
 7
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Abel Vesa <abelvesa@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
In-Reply-To: <20260918120515.595782-4-srinivas.kandagatla@oss.qualcomm.com>
References: <20260918120515.595782-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260918120515.595782-4-srinivas.kandagatla@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 17:25:55 +0200
Message-Id: <179000435568.7157.14608098257878940623.b4-reply@b4>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790004355; l=1041;
 i=konrad.dybcio@oss.qualcomm.com; s=20260604; h=from:subject:message-id;
 bh=rdBCEOP8V2ZJqdksQHblZsWuAizHXi1ShkMll+wqDVU=;
 b=JeIVKJ//A5TfGSvPVfzuVt3j5lRhSU/+/mzdVAHLo2Eg5rxnvBKIX/dRR71ePwWK1Sb/DbIaW
 MtXMsvc7gCRAIppNaGFW9HzkUIzwG3Z9vx8QLSENP9TqPFK/SfUL55P
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=SGRRMmlLTuP/lGKdQ0f4KPvxn8VVsXtXaTpdGc8i82c=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIyNSBTYWx0ZWRfXzNCiK4GzIup9
 XE5GHl4wIpRJJezSX22YMY0qQOYXk7DDlOUV5RAtEi6M6t6Eh8015D3bq9qttgOICH3Wjwyyt+y
 +Z916WFH5wZYXXkrPNkXCvIxeshQres=
X-Proofpoint-GUID: zHjfaFz5WedDA1ZelyDAtp4j3nDDjpFn
X-Authority-Analysis: v=2.4 cv=QovLTlyd c=1 sm=1 tr=0 ts=6ab14c88 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=kb4dfXkFt2E3B8CIUOkA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIyNSBTYWx0ZWRfXyraQSCz4VghY
 rZ7ckkyrJ4heUKDNHEk0CGqoTmBsHX0rCLz3XiJMOOOmEwffbdhVU9tPAPhc5Wgz7OV1HQ04hyb
 j4e7Ez3ufEvr1SmwMIyl28YzWqbkuZHeisTEzdxJcwRKxSa5zJNEWM8Jb1iJqnwf7cmhhbbopYA
 tesbp1K2QrFxFKDZdiCXi3IIgS15ix24kPtTlrTRsxHVoK/SEDOiJt/yl27t12H1qTuNVN5YWWU
 LhWtUYvXTizF7qyZD7EYiIdgsPOUjvewotURZN1VDusNoJ7gNlpxgPmVRXfM4r8cc/LQDRRx+oH
 qGpIjiCjyDxh/9nfw5pm/G765myYuuGZoJmrbEEJLDzSasozFIkIFWYeyn0VEP+HU7RsEpGEwAi
 JNFl6uxoNLptcoRV11vIW3KcKFNUFFs22WykKqXBIhjNgkZT2+tahQFDkuK2UzvWgEkbTWToz85
 gZScWPr2RP8NWVJVmdg==
X-Proofpoint-ORIG-GUID: zHjfaFz5WedDA1ZelyDAtp4j3nDDjpFn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210225
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

On 2026-09-18 13:05 +0100, Srinivas Kandagatla wrote:
> Introduce a device tree for the Mahua-based Lenovo ThinkPad T14s Gen 7,
> a Snapdragon X2 Elite laptop.  It follows the Qualcomm Glymur reference
> design used by mahua-crd.
> 
> Currently working:
> - Display (internal eDP panel)
> - Audio playback and capture (2x WSA8845 speakers on swr0, DMICs via
>   the VA macro)
> - DisplayPort audio on the two USB-C DP outputs (DP0/DP1)
> - USB-C (host + charging on both ports)
> - Wi-Fi (WCN7850 on PCIe4), Bluetooth (over uart14)
> - NVMe on PCIe5
> - HID-over-I2C touchpad, keyboard and TrackPoint on i2c0
> - Lid switch
> - WWAN wiring is included but remains untested due to lack of access
>   to such a SKU.
> 
> Assisted-by: Claude:claude-opus-4-7
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
