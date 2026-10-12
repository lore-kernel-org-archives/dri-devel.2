Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC29CCA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32AA010E502;
	Mon, 12 Oct 2026 07:41:25 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB68C10E502
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:41:13 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C55lX0751017
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MZWuDN9pFOwD5K//QEGKoPML07MF6J4iroVYXqGUMxo=; b=Bmh6lps/PXZ03dJZ
 zLpa/8XF4xKgytva97b2Ucex7SDMQfBH9+4y+8wqS0RDTOIYsF7VhrDdDj9Lsn8j
 D+fjTz07OiYFVJ1J4yYAlth25xNb9GfzdQ1ZbhtP34N1g21xQFP9hCKsT3hBcpVG
 tBzg/3dVQ8acEWDYH5OENBw9BJHCNhT1XpEukJDYdqDn2orWQV7kWfhhwPQRj1Pl
 dnk8hJ+U2kxpvErLj6ZJgSNIMqS7D7GBTrKE1P9bch5pXrOHkAvyN1Ut6dwLfuuv
 yN0lvd7kblyDRiKqud/GsrIr0lWjFwJ+rnTgp2M3usHZgQH1cpkzvYjdFrXtMwbH
 aj8Sog==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7e4ed9wt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:41:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5338bd59032so3713691cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 00:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791790872; x=1792395672;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MZWuDN9pFOwD5K//QEGKoPML07MF6J4iroVYXqGUMxo=;
 b=HvFmAcnRUvHyz1Zqlwfrw3CBvz+Io1H5EYBpvAQXgtxr+tpvvfu6GCGKri6V/dxim6
 5rw4L27doAHgLqaGGg/NQvxNnRJqWofaOfbmNdExmEczpfJoPpQWpJSgT+/yNiKQoA4v
 EINYkO/xNmZtSA56ZqKL8dLoAQodjLpn3f611hFB4merLbGYhGdPP1NCWY15hdLaOisE
 Xght/c8uIY4jrBKY/fXcnO3ycjvTd/dfMmpxPlkTMSlebD2veVXUfhiwa+oBM+RBeW5s
 i+R9TjAn556mzV/IKm0u0OozM/WsUjvYKkeN4/7if9NQvhcomcn+mYsW5RLfRT7n9/U9
 KIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791790872; x=1792395672;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MZWuDN9pFOwD5K//QEGKoPML07MF6J4iroVYXqGUMxo=;
 b=QkjIVKPd4vjuiIIu7CdLGl0PpReAU/DpO0EbEL+ud3JyelWHKnP0l/dqumEB4JNEdn
 xlYtXi0/84XqQGJWt7uLaHMTO7aQ/lyySLiYZVznhGV4CYadqPPbSvmL+KnoZLf09WER
 skhUee1H2iZf+4jTwWx6fyr1N8w9Gabhyx3B7INM4biQ73kLhMtFQg68ALzSQ1QOhQ0P
 kf+06J9T8Uu0vTjEwx5DNXw3yypVIs3vacG+fn+yl3o5uRezAlz+unFd+/rssTrSHM7A
 bNtiv3BqwJfTSvxo6nBsC8bGvvr1v1F6pbI/ukGtipdn8P8skc0qa47YgcoWysfDOrP2
 SYWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwi0AA3dHg7eQnzL15k0NsAbL4Nbbnli+1UNg2Z0qpWKejn1z3vXnVGGALEDd2QCCpwboelNkuu8Us=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKX3pUb0h/SfU7r7iLki6e/p29Y1g8JkG3X5eExLz+iqmbc1W2Q
 Siz/4qbEDrjs4jfv2PMKMZ1jHo98TT3dnzCP9PyvqbMQVH8Rod6r57w33//emPxY+hp9gOK/z0t
 6Fyp8jWeRRO0qgbOOD7XGNWMB5Ae2JNc6xcnspqbSoc4mxQKa+FbwixiiBFgq2tgfkowVy5w=
X-Gm-Gg: AYBFou1tOs4eZysro1QxqtclGMFAjJVGx4MKVja5vKNCASsvBcBULFWaFNjSopP+nwr
 d0hTAzK6Q/UO416vchpyRmixGiGHpaf90zbx4zL+l00nSKLHpQnVH6A30VW+/Wi82vO7ESiHl0t
 ztcpITbwf4zs89iIBh4t1P1hOpYhzfWiej/SMyb/PR4zdodNsSG02/RquiWvp1gIug+kDV+d/6p
 A7Zvq9Sni9PSi32MqVjTwbyw1LBUFv8XucO9DQZmb8CGIzMq6fhK945+H/PXwF18IviWVtO9aBs
 D8J+NNYi5q1dxGeZAxHX4FHQZKLFqMJjlD6gjJ4R5V0WiYXpn0LvBhZCUzI32LrRtFOdMbFtME/
 dKUgrXLZfkSFR9IVbLRKt/w==
X-Received: by 2002:a05:620a:2855:b0:939:8148:1e3d with SMTP id
 af79cd13be357-93ebd0d7987mr1473733085a.2.1791790872219; 
 Mon, 12 Oct 2026 00:41:12 -0700 (PDT)
X-Received: by 2002:a05:620a:2855:b0:939:8148:1e3d with SMTP id
 af79cd13be357-93ebd0d7987mr1473725685a.2.1791790870268; 
 Mon, 12 Oct 2026 00:41:10 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b179dc0c8asm4576443a12.13.2026.10.12.00.41.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 00:41:09 -0700 (PDT)
Message-ID: <94131d67-0e18-4502-91d7-26fdaec0694c@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 09:41:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: qcom: kaanapali: Add DisplayPort
 controller
To: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com>
 <20261005-kaanapali_dp-v1-3-6faeac3a6d59@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261005-kaanapali_dp-v1-3-6faeac3a6d59@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzMCBTYWx0ZWRfX2F/6+ztBkUkc
 /wovnDtPjjobYgZ0uoRu+Rc73Xyl/gjiuUiOP9/ORQsy8iIOr9TF4/l/beWhaRc8z5h5lKzJKBo
 62cxMcTKKspja9Vtj382yl5ezPNPXbzMuCiif84XXA/oBOxxs4ZTanZGuvmwKb3WkF90cLuF2WJ
 1W6jhiSoKRQqT/v96qSpkSFvxKqNqa85Md/AK757ghUhQl29lOQ3cFz+MQJlNXpvg3rBRkAOG6V
 KZRAzANY+BFYB2wSJzjlU8Vg/wGEwdxrd1dqsuGQthZ56mqLV912C1zV7W40fpL6Jwby7lPVDLp
 x9tOYI/pdffEeZ407gzBABp9ejA0Rpm8j2h5R3/nVHwHyPEyHq4Hn6wnbMF7iUZGcircVuAq8sT
 MUF7oLDINrahKPNIRMchSNC7CqOP2XScNYT858+NwnA+kos6YbwNutAvZzFGDE3UHDNzySfDpIe
 fTrJdlpEyalULrCxJgw==
X-Proofpoint-ORIG-GUID: CosFrk32_KIq_5GLwq3j_rQvjftfjRFw
X-Proofpoint-GUID: CosFrk32_KIq_5GLwq3j_rQvjftfjRFw
X-Authority-Analysis: v=2.4 cv=W5utxhWk c=1 sm=1 tr=0 ts=6acc8f19 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Yp_Lh5tV98jg5vq-HWkA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzMCBTYWx0ZWRfXx3HRIOAUvz/h
 8EbCD2am6ESSvzuHkHe2tICJ9sWkrrOb6xwaJs3TSsdxWxziijHjStCHQC4Vop6ozkSxNpJ1XLX
 zIOqQkZFd0EIB+bGVy33AjGVNxVBJz0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120030
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

On 10/5/26 9:24 AM, Balaji Kalkonda wrote:
> Add device node for the DisplayPort controller, its OPP table, clocks
> and power domain, and connect it to the DPU and USB/DP QMP PHY.
> 
> Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
> ---

[...]

> +			mdss_dp0: displayport-controller@9ad2000 {
> +				compatible = "qcom,kaanapali-dp";
> +				reg = <0x0 0x09ad2000 0x0 0x10c>,
> +				      <0x0 0x09ad2200 0x0 0xc8>,
> +				      <0x0 0x09ad3000 0x0 0x78>,
> +				      <0x0 0x09ad4000 0x0 0xa0>;

These register ranges are wider (most are 0x200)

Konrad
