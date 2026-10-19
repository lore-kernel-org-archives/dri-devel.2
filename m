Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C53BCCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:08:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B09410E8D4;
	Mon, 19 Oct 2026 09:08:33 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B7B010E8D4
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:08:22 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OuFK3305595
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iDOJUKPZ+vd5FVmRMKIpfjJCtt51gYVRZlZPGq8hbR0=; b=He0AHl1xU03PyNTv
 xDsm+upddU4Xsx967MQJT4Wt34HjxqKkeRZI44q+7420ZbSnex0wMlSdCpI7KeRS
 CkovQFWNZYbFqwMK1I8pXSatwO89sH4ShObIo0auHRPtOBek18pZh4iiPhWcKcJG
 sPqmATo88qW7jjs43fw0bbAgcuR2ZcG8BQ5m//Qiom59mQ/zXYJ5FaSxHGNasN5H
 qg1pnEk9iBohfJJITAZrEiILn9wSbAzyOViIBnWc4/1Hq9sbrW+lxiEpMK1ywBkT
 +PgTeVlBqzSnySNuH1a29xXmH7uT5jgfbT50qWkSKq7Lt1nSAhazIAELbxuBK8I7
 +Z7KAQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf47ga39-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:08:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93df7a9466bso31024885a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 02:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792400901; x=1793005701;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iDOJUKPZ+vd5FVmRMKIpfjJCtt51gYVRZlZPGq8hbR0=;
 b=kq5Od9R3EEWwrnJ6VUYXltvvuaobpchG1qxO+1p6F74YSitEEvlSa/jR+MhedqtVwy
 GsgMbIiQ+zn0L07gUuEKq+tprJ8qTArvTm+qqgdqQeHHgRkcQ17fkCslaPkns/HPJ5Na
 Hbd3LVp7wVZgHMEvCkeqBjTtsvlOvFl57eavpTxgaihm9EF3hsqxz598FMATBZis+Va1
 OVRoSVpfkrmLxa2jAF7EP1lHD0M7o0QBCKDF0qsoh1jMEnb1kH/7Hcd5nRm66nDjHQu5
 1nXQd4tq9/ZGdk9G9U9+yoIs8g5raZyisf5yqJsa6T0yFu5WIQpm/smE6lNkqj6GtMTB
 E6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792400901; x=1793005701;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iDOJUKPZ+vd5FVmRMKIpfjJCtt51gYVRZlZPGq8hbR0=;
 b=1WZ8kJ7WT77L9Dukjwe03HnSTcSmb9n+O2kuNu8/0STKqQSm59ar8lxQQ41bsonEso
 z/7epNU3yrNvqDfpNaZdc6S80/ex4NprX2PALskpsNkEa14MVXRObQ+coa8sragWLmR+
 6Be2cj0A/5akA1E8xjhgZ6aNfN7pJadmkiHeOUu2EHy67HXOYUjp5Ishpzvw/g9dDFKp
 iAInL0hRqVsbVHHc7OmM2AYArBj593ByWtc0iZCTw5UVThFo4XmzhCm9Plqvg9ja7hjI
 Ut5GknOQyNB1YXEjJ0CCllP56lEqoa+KbvkViTKmntd9ElAjF0R5XgWDNT/kzON74UqJ
 9vHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVuhKwZm5TbNVK6h0q6F5D0UqRLZnlMgvQZXCMMipoK+k2qyDyQb/Fp1Y5UUKwchBb8NWPxzqgJLg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJfmwecbn+/PPhQLb6z5KLcUZWU7vnxxgZSCfcGZJYU9NMPBCTj
 CjobW8wtxaXpD1/ixUwDHg2P68x2xLp/xisEdb+eaASCA5tPe3UKQZVzy+87Lg1LjmTP0p5Ik7V
 CkU9vEPzlpvqU/fv86qAgT79xeRD+M9+60Y3z+mfXpOQBcO1bMC0MfxgMVsZbb9HkFeNsqug=
X-Gm-Gg: AYBFou2U8aONzgpZYHBLlu12yEqZySSC+I1Vhzw1XZOxJA4+7i1u+Hi4czwnbYrt21d
 PqSgy9iPqh71AsLosVHOb0nb1YfBN1KYcX7DCFYP+qX4X3+GQDKxyqp+rvFe43HrIqmdS1LtU5c
 piAUcwGkeSJ9MKaPqBjaLdW3DMbCnMSybEiCouT66sEuBydJjqoft/scz9yhR76DVAx6uj9oAnv
 TGdRGOkZRJvP+mdGVVdgplJtuRmuXO+Xcoq9tZNg5iqUvXeWK2odeECk7lrL5gXNg4MxGqrSpMg
 Ip/KSbb590WoO221hVwf7lgsCwt6/noQrmkTlC4SHPhGeDISJASnQWigqLYFfmYsRL8CPs1/SIZ
 Pv9fGEi0OpwbuePtKxU8iAg==
X-Received: by 2002:a05:620a:4452:b0:93a:14c:329c with SMTP id
 af79cd13be357-93f29b38f59mr1324502085a.1.1792400900981; 
 Mon, 19 Oct 2026 02:08:20 -0700 (PDT)
X-Received: by 2002:a05:620a:4452:b0:93a:14c:329c with SMTP id
 af79cd13be357-93f29b38f59mr1324497185a.1.1792400900469; 
 Mon, 19 Oct 2026 02:08:20 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4090dd10ebsm339452466b.22.2026.10.19.02.08.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 02:08:19 -0700 (PDT)
Message-ID: <20553686-c073-4b13-a23b-a4936da33dad@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 11:08:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a6xx: Don't set GPU freq before the GMU freq
 table is built
To: eng.m7mdhashim.1@gmail.com, Rob Clark <robin.clark@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261018-msm-gmu-freq-guard-v1-1-dd92dcccee86@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261018-msm-gmu-freq-guard-v1-1-dd92dcccee86@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: WXxHLzDxqg82cvS52T5Fhj7x1WipUSf5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNiBTYWx0ZWRfXzjZAiJr21NvS
 FKDJ+u4ngpcwADhhQ006x9iKILhrg0SE+9qRwnD8BndEpCULcVdt19uxbTi2JYzqnxe8mkfwf88
 6xIt4SXtJ9mPHfGfUHsTwvdCHsRzSVxxjnRfoFj+oCAD0X4l8FCZXitmN8ZfW4n1nSwoi6Yz75I
 hq43BWpkRl0bX6XR92iZoxkifYsfo7rYHHicEjMTg9Gr5mnPdZdvx0oCXfVU+y+mWxJS0oKdEEj
 fPOYc7+H/myc2y8XoaP02Yt63vPA+0NXJRMj++y8PRtI8kIs2txfE1Qi2sjLy92VqecE+HjKjHY
 n8Lf7q3MafqsPh1TPZWHfHJGaQinsLQFmKiI7H+mMOFs3TdgzCl8feJovm/wTGYoxlY35tzHn8E
 8KYTFnHOHg2hO0FfE6UTlV2wfHNzOESI2qYNLHf/Tmqgo7+ON/dQWukhZdsbl/NsB11s7QOEc9x
 MMrhHoVP+HaSfQh/l+g==
X-Proofpoint-GUID: WXxHLzDxqg82cvS52T5Fhj7x1WipUSf5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNiBTYWx0ZWRfXzzwmUW+SwBtr
 cCsnIGlfi1TPAZg6cPofNZfU+efhXZtemrn1SlUJCMUZPdHPTFnv3yHykqdrJEFkO3FPDNkEexu
 tatXGnvHjeytaRkiQZNsg09ENAamMno=
X-Authority-Analysis: v=2.4 cv=cLt1IVeN c=1 sm=1 tr=0 ts=6ad5de06 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=TId0fF7HYP2RL42ZpU8A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190036
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

On 10/18/26 8:29 PM, Mohammed AlHashim via B4 Relay wrote:
> From: Mohammed AlHashim <eng.m7mdhashim.1@gmail.com>
> 
> a6xx_gpu_init() registers devfreq through adreno_gpu_init() ->
> msm_gpu_init() -> msm_devfreq_init(), and only afterwards calls
> a6xx_gmu_init(), which fills gmu->gpu_freqs[] and sets
> gmu->nr_gpu_freqs. The devfreq sysfs node is visible in that window,
> so a write to min_freq or max_freq can reach a6xx_gmu_set_freq() while
> nr_gpu_freqs is still 0.

[...]

> If you'd rather fix the ordering, so devfreq is registered after
> a6xx_gmu_init(), I'm happy to rework it that way.

I think that's the cleaner fix.

Konrad
