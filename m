Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D915CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 12:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4050B10F1B1;
	Thu, 14 May 2026 12:37:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YO3C7bqT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PIr9m0du";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1785010F1B1
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 12:37:10 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBeVTq3061929
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 12:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iSowrtE5EBA1YxeyO47FidyogDnDbcytlrVwQdLxer4=; b=YO3C7bqTNygIL/rR
 zg77oN8KLtLkXw1o9VI6MvzrB6UO7CpuTxul8EfDF3ylpXFy4PlS9YB65ZpR8uuQ
 kQSzpsFi97NIDDLMkMZ0t0ll/vbQifE8iZE849QYOjqmINbfVtcP+6Lv0uNZEeE5
 plu6CnxD6EGbJNiBU2nfloYUR9laruvX1+mNd0NV2a1tVvb7nSKCyDT9f+4dexqN
 yzbF6ss/mLueX8iJvzhDKN5ao0aRWsgf3waW3bf42B35O14bClIGEm/7/i+UOnB4
 /jpuJ424cuxQRSmIbOQ85vsSTPYulquAkAvnGdj+oaJDobPcarkiAmgVQVK+sGRL
 2NKmaQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e554a9ycq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 12:37:09 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-56f8a5c02b4so664278e0c.2
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 05:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778762228; x=1779367028;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iSowrtE5EBA1YxeyO47FidyogDnDbcytlrVwQdLxer4=;
 b=PIr9m0duH7J0lH/tudy2NzAfrh0JVx/AAWOE2Np/qJnBo2iIyr2qkqwSxZATT8S1BE
 5FTT+heTBwrD3msbmpNgr5wbUjKfgh7XOvf52aBiiUAYMnvVMO49sUQ76n+uq66Jbc+u
 7CQjE0xwSOzc0FxWpcqAydFuwXPwUzH9PxlogSLrhuFGks8bqw1bztl59ETwE45QGDJR
 tff4wdYHuLMYasgzDqNg6K6aJvU0sGkkTiaBNFFDA5MOhDxutqvPKSNmbin2IrGb595y
 zX+BpPaT/WDmrBioOtaw5rT9N75ityfDwsv6vGiS+XzKsMEWv/VUgkWDr64JmyoAATH1
 Rwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778762228; x=1779367028;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iSowrtE5EBA1YxeyO47FidyogDnDbcytlrVwQdLxer4=;
 b=QIPoFLd1zlW8XteL0hF7C4NUe2DALkVfFMm0SKvdMWPXuRl+2emVRACGiE8o27sr9E
 fTXNM6W2jFVuc2Lrx0VdZlqs+8OlVIiupguxKLskA8xFAQ8e6VduBoIIzzzn3k9cS2v2
 mJCe7S0Ku4YT64/CA+sioDd1Eu3DHNXsR/psKuEAnQUD7jTs+qcklfBsli+Z6jetFsls
 7CtqikQKO6J5azRQjMK13sgn1h81lk6H30vHqPAC+TNqxx40Zv6TlJS/bfJ02xG4/BDJ
 jQhMuYFKdFVIIKvygMGo0itWKvz9pvMfdl+BdgtwTjc7Ju44yMv/CNmamz0sEYaL6bkn
 s1OQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9OF5ybMmomXnUzIPMB7c+1gbTxtHJlG56C4E/9hM5tzTDWGASOsJJteqUoqd+o/yuAHyUhJ1TO+rU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAwYnGHClD49S1hxKzJifO1LQ82B5mEjMNlPYPwukzMeRiTZ/O
 wKBQF/HGpJu6Vp6PDv7NkOikC6WolPgEvo1EAMKo6IsRuP8XeJ8TjIb7Wi1lfkLsUibGzaueKcf
 fTXVtvxtrMBF0rq9zM8wykaQA7Iuc8YnlEf/pWtOoiVE9nSsnYe9Z6sGi0oWhNoEX1Ydt2TcxmN
 by2Tg=
X-Gm-Gg: Acq92OGnCa/zBkM/mM6lqywv3h9TocWGFf0+u6OAUvcK1LfxbMCpRdzDmHPjnPBgS8j
 dRT0M7kWtTNuEKbqrQyF7HdtZX6Yxr85uk4xN7S8SREhIqMl5vf6tRDqe5jQ24PGFUUMyPPI1Ii
 TEvDa4FXQb9yJnZL3oFOpMVAgQkB3aNrjVNXFktAGLvWzOwdkb6zq1HNi5+Bjd6Tq2GYAFG8blU
 lgj/jrp9RVHPBUZ+nrRhGHeW89fqmcZ1Aumt2o3XIEpFhhGXN9zEQ3uDymBbzE5AcOJi0ACpdc8
 YF6B7tZD2/9R++dA8StgzicOrBbiKeB2OeJLLkeD/hsGo110jOH9NckkWOn6EaTaG6FxChp/mRU
 Mn/v/FU+w5QMSYL0es/rtGp7524Bw6/HhDeTbcNx0uWWKlx4l8ieTwMZ03jaKU/GUYMNrhbey5U
 r3UME=
X-Received: by 2002:a05:6102:2157:b0:634:b9a9:c082 with SMTP id
 ada2fe7eead31-637733f0556mr1164957137.3.1778762228443; 
 Thu, 14 May 2026 05:37:08 -0700 (PDT)
X-Received: by 2002:a05:6102:2157:b0:634:b9a9:c082 with SMTP id
 ada2fe7eead31-637733f0556mr1164943137.3.1778762228059; 
 Thu, 14 May 2026 05:37:08 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bd4f4bd1124sm84302766b.1.2026.05.14.05.37.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 05:37:07 -0700 (PDT)
Message-ID: <2a19abc9-4e73-4e8c-8cff-c2b28100abb5@oss.qualcomm.com>
Date: Thu, 14 May 2026 14:37:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] arm64: dts: qcom: kaanapali-qrd: Enable GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-8-13e1c07c2050@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260512-kaana-gpu-dt-v1-8-13e1c07c2050@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Pl31NYqfL0MihEwu7PZ45z4F1zois-8A
X-Authority-Analysis: v=2.4 cv=Wag8rUhX c=1 sm=1 tr=0 ts=6a05c1f5 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=OwxjEWw48HTU6ZCEJDcA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: Pl31NYqfL0MihEwu7PZ45z4F1zois-8A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDEyNiBTYWx0ZWRfXzBKu+zzi87Sp
 h/Z2DQs8+VJZQkW3q5ouYqTD77ytD4XpJHkvWsry6kJpF0R8scIXmQd/T0Lt1fl78voPb2jhaMr
 Ugj/tOFKi/Yoci2YaRXEPeZOhPQqzIJIeFwjuOPNCk7xtVSC6Ih7o6SQNUHXP0GwtH0VEpnXq/H
 8gZEszftxwAz8oQ617QYbPVcUlcb9dUK3pQfXI5gaDA2InNClUVa8uH/sWg03FSjBx7dGJJLu41
 OOtCfDCkpsyNqDRzP3V3OjaTLdzHvSGhdwsKYJNp0wi7DmwZRDE9wRtCum0JTCE3pkTqdeb92NQ
 MlN+nq36rtUMhE8yN+KC8UFsJTH69DKmX5y03qfpt3jeZSKgcVUTozegegTuACPWPDs0SkRk/iZ
 s+bYDx+bCXcKX+nqWMkjFs9YR1zQ+aON7zIgtUvxY6qjdozLN/5+MHDRGP7QVgS+9HKA1vKbEUT
 1HxGE9A770HIcxodDaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140126
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

On 5/12/26 12:23 AM, Akhil P Oommen wrote:
> Add the secure firmware name property and enable GPU support on
> Kaanapali QRD device.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
