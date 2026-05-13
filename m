Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEC8CD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 16:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A958210EF75;
	Wed, 13 May 2026 16:53:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VqcTOxGY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X+mwhDU+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B83C10EF7D
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 16:53:11 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DAPBNf2321422
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 16:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ZOuwO8Oe7+fhFiUNtPbUZRGD
 3ndfLf9Y9W/ejus3N+4=; b=VqcTOxGY8MgLhpL7QdJ7no1pbuPJqDQSDCOQZvYM
 mMv2QA+Iibd/P3kLfEp/Ky0P4VHfBddRiB/PPRujgkEMFpfPetiBU6hWAsdCxFIR
 8Ut7dqpEQwHYBfUyicHI/0cWX9KFNFZE8rT3VOCjQcL8m9+BfElsdQUsIATm1skS
 pjqwAgJ3ViXZjsjoVldeMz5idJoo0ZkjKbBATknvuPAPXU97jAjlkJH4mqR05W1q
 VnYqmW12Qt9uGodhMDo4ORsMNGmV9eXSkRflCsy1J/r6OmTNtqFcMmFHAlhVr5RO
 81+YfJ1nhuBpv3IM31e6/dco5ewo+GlxS3b6PQ639X3PqQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4hgub21g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 16:53:10 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-514d2b22e7fso49568831cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 09:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778691190; x=1779295990;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZOuwO8Oe7+fhFiUNtPbUZRGD3ndfLf9Y9W/ejus3N+4=;
 b=X+mwhDU+brG547JFCe+x+Itubr79RuOvwz3yTBEc2FfV+by6u/3HwWRFoHGrkKJDQJ
 SVuCqBdZ76IeXMpavTjgoKaAOqvdqBw5y4ekivFPcPcXJMdrpi0GNXovVP1Lx1IPSUv0
 LRa+BjD+NGK55/NyU2nQ5zhhwlnN4ZSS8XNgoBwTk8YinGEwSK0K0kBPwe11v+RTH2A9
 ljzW4C6R3CFX6DLhIykOZXjzBZQwUDgjYGGPF/uISy5ePjkBJaPkET8NyskIcrdcnKgn
 b5l/MCBIo+q77SJcod0cf0lPPx075paVNeCNO7jnKrZb1wvMMnBTeB5ctT6Wk+WlDGC9
 jkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778691190; x=1779295990;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZOuwO8Oe7+fhFiUNtPbUZRGD3ndfLf9Y9W/ejus3N+4=;
 b=rzZyUnZ5/99I0kWgdG3ha/JYcxUjsdz3VELOiCybUziCEjWriFYtXUuNFiw2T6ZlZQ
 dtB1jW/lejq6r0JTXf5t7Mxpu6jiJWUXuQg7r4Gbxm4G+v4qNBEOc3GYewAQhNiu650Y
 sgcNiDMKje1emsaXz6aThatpCafXlsJtKxq2XF+zwujOC3zxsyBQZw+YnrDwQo+/tQIQ
 wbbw7e7ClePjdiBDKnrc6+facJAIEEujymBbdLCpDx2gzPq4UY2ZzX7VIvzglUd7I84R
 o4LOsAamA+ajferkG6M79gpfylf9ShnutWkNUWNCKU+2e0fHGlWjkoM9kMRaMrKzW+u+
 45mA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/LRfubK355AAi9j++Tfm4alrU4/9C4En2ndvTNd8xpVe9a6pi4Hf/9/1Ya64q9R5N71E8QcPg9H7k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyotLM/JvNPjfzlYynKPkP/9TeoXqX38098aSl7m1XHrgvKd+9R
 GayETGXRjyGIL/uoemsA45HzU7woKe6NHVeOEUbunG8t/QnoHiQojvJ71GfMZ5VzHhgkWrkhpdn
 WPPO9GdQWNJX1iD2PusR0XvpdKSYoAyl3Z3B6cMKH2494Auyecq2geD+cQ1p6BBzTOb5CJ08=
X-Gm-Gg: Acq92OFHdgTc3d53EtcG4642KlCc2WLK/ZQVsixfAuwEhPV2hYkitlZqh1m0qgAnRQE
 Qe0fmsWMZ4qzO6N+ogqg/PeJa7siZ2cLZsPkIcKnm34BvVlutDoWA4KXn8VlzAyROij7TWkzDd5
 qJGXuGv+hZiqPw1P16mfe+goIStkY24/II0fzdDdwnJFVW12RjYrfX55dDWWjdEkgnYcsHr10WK
 EcpY+K/G/YkjbS5WvxDTRXRPrSfWYmG8gy7iTOKPKAtBwSnqaLx0H5JHMTZ7Jgn6HH2j9aNTLXA
 XGBngUdLTls7YcdJfCgE87OgT7eizikZkXwsHc1YJ6vC46DvECKxawl0gy7tlpbYxB9AqQmnneA
 BuFrtfFuTG30XatKNi0UHEM4xFdWZwgZArxVL/f6Q+lL6xmgyDWAo3PN4KDDXSA5S4VSjVy02gT
 gStmvXiw4bttWUovYZo/aqEHj+54ZPy27rbkg=
X-Received: by 2002:a05:622a:5912:b0:50d:7384:a660 with SMTP id
 d75a77b69052e-5162f43f2fdmr54430811cf.6.1778691189730; 
 Wed, 13 May 2026 09:53:09 -0700 (PDT)
X-Received: by 2002:a05:622a:5912:b0:50d:7384:a660 with SMTP id
 d75a77b69052e-5162f43f2fdmr54429961cf.6.1778691189063; 
 Wed, 13 May 2026 09:53:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393f628a724sm40620501fa.39.2026.05.13.09.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 09:53:08 -0700 (PDT)
Date: Wed, 13 May 2026 19:53:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 5/8] arm64: dts: qcom: Add GPU support for Kaanapali
Message-ID: <hdpvs6gftjhaa2xx3r3ds6ss44bvytnllv2lg6anoiq2iyxwtc@qd7ejefkxmwk>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-5-13e1c07c2050@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-kaana-gpu-dt-v1-5-13e1c07c2050@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=X4di7mTe c=1 sm=1 tr=0 ts=6a04ac76 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=XJtuOP1FUQBXJGSJDRYA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: cGnel7UkQotZ8cACJPVrqb1JjlfQ9H6B
X-Proofpoint-ORIG-GUID: cGnel7UkQotZ8cACJPVrqb1JjlfQ9H6B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3MCBTYWx0ZWRfX8RXG7phaK9a1
 kiRUMZMYErpCso6LBT0vbA084Nzo/eUcoBrfcdjGQke+xr+zvqUzuFdVduZ0OMkEC3RYmW8T+zS
 lFT839QLtvrkpambcr1ywoKdW7jkXSnrbIZRqps99w0LMWlXIitKFfyqwxCR6gVeb9YQurYotHE
 mdqvbj5DvHSAaaG/IKaiMx+fhEn6UeRjfhSpePx62i6o1tRunNenQbkOg7pBqqBS9j8HCw/m1av
 vo59ZzHBhiBRwpmM5N+G7lFlA+yEyWtq5snNuMZoeQf2Q7nOR8ejhlOTN4Fao/+i7BAbVHRzelY
 cQWTpRMvfvutbHXK54Gu4IpppfD2be89WToBlIKI4eVuG8RKr2yDimbPfpI+W0XHBeFronkdfUB
 g7s+hd0VkUDk4JsieGTDQhDTEb/4vi/JELiugoa1RBYk8d9zvTrfhyUVbFUFOVH4CPCujr01Hyi
 CeUWu4MwhMDSoR1Jhig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130170
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

On Tue, May 12, 2026 at 03:53:19AM +0530, Akhil P Oommen wrote:
> Adreno 840 present in Kaanapali SoC is the second generation GPU in
> A8x family. It is based on the new slice architecture with 3 slices,
> higher GMEM/caches etc.
> 
> There is some re-arrangement in the reglist to properly cover maximum
> register region. Other than this, the DT description is mostly similar
> to the existing chipsets except the OPP tables.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 232 ++++++++++++++++++++++++++++++++
>  1 file changed, 232 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
