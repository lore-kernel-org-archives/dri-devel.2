Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1F8C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:38:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E040510EC59;
	Tue, 30 Jun 2026 12:38:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FsbzbzUe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L4Mp4sNB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0192610EC55
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:38:07 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U9mxs31613434
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4OYUFv598H0zTgYaTxiad7MP70D3IXkLu00sHk72TbM=; b=FsbzbzUeTWSQxnA9
 kJPqCIMJUFmj4GvpwwryZIJKRcy5rbWo34809alM0V531WTuqJpuNEpnV2QoFW8p
 0cF8pj2AeiEaEq0bMOuvc6VHejiI/+nZ+nE5Xj/bi/gQvlxtt6iyZ+FdHPQDKaUc
 RfvDKEiDFS12tBKAjqsnhorkqSGubivxTg+9+TBr7Wae3oGxa/xngntKkAo78ND9
 P0nyRJYj9WlaMliHyYpbcOefCh8tgTvvLL30PONEzLfFPSXWKzI+9r67TDc3MnTD
 i6SRoiuQ71TIJGrJMbITeyjrvRBh6cj2hRCq6NOq/XEx9ENPbhxUJm8QEF/Tx6EV
 nI/wFw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3x1cuvdq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:38:06 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-737ddaf8c57so91364137.0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 05:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782823086; x=1783427886;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4OYUFv598H0zTgYaTxiad7MP70D3IXkLu00sHk72TbM=;
 b=L4Mp4sNBh5PBkMaU719keUwUPQx4FCT7Xa9cLWMTc4cKrafOVptVn5LJRzRHRkU84A
 8SSh1tGmaAX7TxLisaoWGTvSEymeKSEpydQQtiUyPQM/np0as8zZ0AfMiVuRyymegj4O
 rq1quDYgSnT6anH1rCm3huaxHlFjU5L60jlOPElP2A0ut2B/NzUzCsVqNy6OnAr6TYHF
 bOp+7ob5KSn+t8/kWwp1ESoddKR4Oz/Asde5EG+xynKuBnnEbX80Z7l1TXo4Ym7b5H0Q
 p1iOFg3Yiht/RgJ/gN7YGmlQzbe2wJ/dtzjBkE79kvUhr0pPWWexcUu06dfTp2v1U1IM
 RT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782823086; x=1783427886;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4OYUFv598H0zTgYaTxiad7MP70D3IXkLu00sHk72TbM=;
 b=CkZR4SNkPYyD/yggfDs/Cl02eimhu/tcN2Cm5stja+rtIqIYSfx8CAq9kGXogcZlQG
 GvPjfWzRgpbH4onQsXe3plj7QdzqITOgHi+a2cpEl4HQKZ2J/eZm8NNkltTzYHpdm2mV
 D+10tKrN3oYoXgtnEVvcLvo5ttbwb4KeP4YtETMPM7VBK2Q2iD8LcVNJhHS5a/66hN9e
 rsqE5/AlBwuZ2X3D4M9iIaoTCpz5p2DKwzguP4A9YbTsKo+lOh8YlpIsPXLNUDwXlYM0
 1C1e56UnmVLRgjgW3Hgpo7JIBkk7nMn4LueC9NE0O2pnUzFvNSmh17iZoC50UzpJyrMS
 ZNYw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqQa8KnPrVVpIHM+NX9u1EGgs2jwPu3xCOogpuTyafIZZxxMpIcCfub7DaLox6WcuuVDQilbo+bL7U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDzGCLiOe2WEc/o25oNVcRTT/BYvDXotwnJsC6vtNgxFuzH6YN
 u8E3MnvpXLhw/ElW2BkFSrc16mjEwkep0OHXYVyTe0C2VcCbNEttvpr4Oda1MSAB2kyx6NwPzBM
 oFc8FgWEA7xXBwTnDpjBjYYl6lxb+5aaEua2pcdDAdpsa9FlUfmebRg8iSHKZEOZ9d4RQOg8=
X-Gm-Gg: AfdE7cnDr5cHI6grJm8XjLjOfe/zljMNL4d/ufx7zOhaagdHZXGXqg38orqDkVBDwlu
 K/AE4Xo43wL3yO3BJ099msZ61FpOc0f+MBi/2CHLA2b4bzngJ40a1cuHGNcJtujehWSVwUOiJOj
 X3x/waJsfU4L0HXX0jdEViebN1Ear4JnBtf1PX0IdiRvxQcOi5OIYM2GOm39WEXhDUfjEzGjOYu
 zClbjuA3HgtE0N9SU+XZSfY9oCpEL2gU/XSevNa4e3bdrfkLbslyqgAMGSLRqKTMtn38ETs3CgZ
 6u7CTUesRxR1GSsRx+e2k6dkj/OIf/5StDc5IFtHqBm5gw3GGM6JVbWvQO5VvHRwAdpffg9sTkf
 SbWKUC1JAiqExlP2kiV34T+9RwS/T5+F4qwI=
X-Received: by 2002:a05:6102:5804:b0:739:64ad:bf4e with SMTP id
 ada2fe7eead31-73a3912c265mr460464137.7.1782823086339; 
 Tue, 30 Jun 2026 05:38:06 -0700 (PDT)
X-Received: by 2002:a05:6102:5804:b0:739:64ad:bf4e with SMTP id
 ada2fe7eead31-73a3912c265mr460459137.7.1782823085760; 
 Tue, 30 Jun 2026 05:38:05 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6987c95003bsm1081611a12.21.2026.06.30.05.38.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 05:38:05 -0700 (PDT)
Message-ID: <64e425ab-dddc-4221-81d3-3283e2961bea@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:37:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/14] remoteproc: qcom: Select QCOM_PAS generic service
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
 mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
 mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-8-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-8-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX6IfCs1dZUjaL
 8Kcgea3pGffywWmgfHHbtglTHtKSpxpJG6W7kyq4jsF3k5gVNP8WztJremzDrgRTLRi4h4RwOvw
 o9XwxpjVNE4QocIphrwnofL2YQ2ZpJ+hexVs9bal+UHCCc28V/NJJ9KumrU8oFFv7dQqVKI9+MG
 RLBPj5ra81WVV4MUxahT7mrm+bcydswrf7uHeDclhL/2bOboJO3gHiKH35rybvgnfRYapauNyMm
 RKZwbwYWuV2L+OowvdHe52oimSx9ww2kHlBpOE09Qc+aPVp5tqHaWlK9glBAo2SMWj7GOnEWQMZ
 QIIvwcr364uC6EXS5L4qRIheD/Dv0sYU4gIYHbHxIHjqf/huLHXTSo5cbAMTyHUBqVJ2168f7KD
 6oydrEFS+cSQ3omOLwNzuEfPeq/hBrpBKlLF+Pxx7S/pBEqFD/oD5ogmU4M2sy6fWNSXvfJrx0d
 y41r1udkPZTY/vMPwKg==
X-Proofpoint-ORIG-GUID: VwCGM3A87VfpNdygKMbEFPfXy0WeX7z7
X-Proofpoint-GUID: VwCGM3A87VfpNdygKMbEFPfXy0WeX7z7
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a43b8ae cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=9LJ1SYc1tAtFajrMtPYA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX5TZOsLhkdocd
 4B9JaRqpRQHWuvQEwt6z3+Kmk3MuL65yyyEegvGyGHXzvuqI57jgl/qg0e5B+ADjkxbdv3NZHqe
 fpMFuiXgdRZDIFNPlUaXPn0QcTLf9Vc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300116
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

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Select PAS generic service driver to enable support for multiple PAS
> backends like OP-TEE in addition to SCM.
> 
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Tested-by: Vignesh Viswanathan <vignesh.viswanathan@oss.qualcomm.com> # IPQ9650
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/remoteproc/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index c521c744e7db..65befdbfa5f7 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -210,6 +210,7 @@ config QCOM_Q6V5_MSS
>  	select QCOM_Q6V5_COMMON
>  	select QCOM_RPROC_COMMON
>  	select QCOM_SCM
> +	select QCOM_PAS

This is a NOP, SCM already requires QCOM_PAS

>  	help
>  	  Say y here to support the Qualcomm self-authenticating modem
>  	  subsystem based on Hexagon V5. The TrustZone based system is
> @@ -230,6 +231,7 @@ config QCOM_Q6V5_PAS
>  	select QCOM_Q6V5_COMMON
>  	select QCOM_RPROC_COMMON
>  	select QCOM_SCM
> +	select QCOM_PAS

Likewise

>  	help
>  	  Say y here to support the TrustZone based Peripheral Image Loader for
>  	  the Qualcomm remote processors. This is commonly used to control
> @@ -282,7 +284,7 @@ config QCOM_WCNSS_PIL
>  	select QCOM_MDT_LOADER
>  	select QCOM_PIL_INFO
>  	select QCOM_RPROC_COMMON
> -	select QCOM_SCM
> +	select QCOM_PAS

This is OK

_however_

It leads to a situation where no back-ends can be enabled

Konrad
