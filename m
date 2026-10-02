Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90154CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 12:21:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CE9910E57E;
	Fri,  2 Oct 2026 12:21:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TiJwpzIB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kHRklwDV";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1DF510E54A
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 12:21:18 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6929nQhW2061960
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 12:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Wae5KuvkJ0kAtp7ZnZDsr83K
 4A2AnXNcvedN/k0fXnc=; b=TiJwpzIBToM310YAzU6ACgCASTz0OoHb3OEj23dm
 Ax6ZX1cSwKkIFII848co3sPc7bRFgWeG2GVypLniVuow/M1k6Kwt6He8KkRcrYLT
 lDn8faBRexmecRaUXtHZwjbffMUJY/HzZBPpJ/pwiCuXGAqJgOtvygyx+MI2OHhI
 umtkcDLmDa/Q2IgOFqWbuPAxLnUo2N/2HGl9eZkRRtS7/o/8pWOMj8B6e3yXZDZV
 Wncn6sNocfLAnMQQFY0UYzXNewmvOmFbJFjlcg7irE6KqLvwYf1DDqBtmP2s8Ztn
 IcsJvEKLIlciu6Ya65sEw8F132yepQrFFFLR2gwx1mAUiQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h256mscnp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 12:21:18 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7be858243a6so538357137.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 05:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790943677; x=1791548477;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Wae5KuvkJ0kAtp7ZnZDsr83K4A2AnXNcvedN/k0fXnc=;
 b=kHRklwDVtdUUp8UBhqB28p1OvIsk0b6Szml3Q5d4VglVX3KcbsZsbJkRMq0gNBsw9G
 p+rIxoSq0EdknZJba3Qh1OpqXf38gcQtMLCKTOQr0rUIJKPqimJ2IOxlMP3OEmbTDKR6
 PhbDkAnR9TsKrlV4acbaUMdfbn8qMBPa4cK2LQjJuuS+5vZnfBMrWcodvOJ2Ao+Pxzye
 g2KWZQ97semn4G+6a21MbmbFiG7fp7c4cqDkjGwzb9KHJaVDyGuVu4Z/CPByOYr2scYH
 SE1Fgy6XRS6Og3aH+/8Pg2B+m6sd/Xof1BqNf2mlzQB32bbVM9neYvv5jPKTiw7O6ZPK
 0zQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790943677; x=1791548477;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wae5KuvkJ0kAtp7ZnZDsr83K4A2AnXNcvedN/k0fXnc=;
 b=eBVYE8WIST5otrWUBLQ2FQWkr6pi9P4GNhXmu1fVAbqtb+ebR/VbAij1EQ+WgllWji
 yxWyCod8puF0m428j2rQK2ZPaSCvZvRsJHbqY5+nB1XVLJ4yQuLWpuz6tWG0x4Z/1HwL
 +mEgbW7MnWK6aXpsQXv5Hf1rqGqbht3oHxBj5YaTCu7z5bPyZbUeljBwOa/P/gmeOfMr
 lOY29o2Wbcr7VKGghJz5w6HBTgrdNPtfYBWvJoP18Xz67mWUKLiTZaf5omfZqy5X0RSI
 8cs9lX1hGQi4GuryzO6kRz+tqpaXIt2BpthCGKx2XzurBy8YSwdJQ82GzYdDMJkrLaMl
 i8Ow==
X-Gm-Message-State: AFq9FYJ+WZ7lML3rfyMzVkVBfuOS3b4iDLUMTOg6zqpFDWww5XCYcfwz
 srqQW568AT/SV6YnN/3sqzRFKruaxWj+D1VOyWppSSNh2Nty4s+B+7uaETemfoJjx91mmO/fdGX
 1OS/YCVGhmBE9iezBiRzw00AI+s+jkOI2ErAkBGKAQA+uJV8fwFeYX9g+elE8UnyytXCNJVQ=
X-Gm-Gg: AYBFou289D2OgUegylwcxi+sLkHdVe+4MtnKx1pSRLvsdvpxXxNaWYj+zvcWuBEnD9c
 JR7cAXK4Na1vdob2a4S9jgD4RJMWnnT7U8fi1WkiToxXZWyp7BhWlfkOqWkW2JcWwraiMT39Ncz
 EQ/pcFVqUAzhmjEjIzX9s9uBCGHRXn+XQxYVMYH5fYflUqMxJsyyHuKwrH9s0vmQOh21kJHZpUb
 G3H05jOfSUQTszJa25WcmAY6UHOYPu7zl8Wx+AoDWRl1rlSj0LK0IJ7Q8S0NeLRS7lEiYyQosSw
 CM53G6uAr9KKFFydfWujSbOQv2q+kMr43FrPb1uP3imF8Hook/albEfIO0acsI2EZ/BPB+uRpZq
 NWPC+pG0uVaTkstlpLAN9liXt4MpIiV+9nOb4YMfvs+LPP+Wmv/tn3t/kqhhqiS75mcXFHUDmTx
 J9FF80Kp44Gzrg
X-Received: by 2002:a05:6102:4bc7:b0:7a7:5355:7fb6 with SMTP id
 ada2fe7eead31-7c0f59b3ca2mr448792137.24.1790943676863; 
 Fri, 02 Oct 2026 05:21:16 -0700 (PDT)
X-Received: by 2002:a05:6102:4bc7:b0:7a7:5355:7fb6 with SMTP id
 ada2fe7eead31-7c0f59b3ca2mr448770137.24.1790943675425; 
 Fri, 02 Oct 2026 05:21:15 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87e32c6ccsm8966761fa.38.2026.10.02.05.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 05:21:13 -0700 (PDT)
Date: Fri, 2 Oct 2026 15:21:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com,
 helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 lumag@kernel.org, robdclark@gmail.com, robin.clark@oss.qualcomm.com,
 valentine.burley@collabora.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] drm/ci: Remove sc7180-trogdor-lazor-limozeen job
Message-ID: <q6yw7ksztmybe7zz7tsrfbnjwsvgku2rsybqn4k56kwd5gk6ka@7uo6s5taakt2>
References: <20260616115410.325837-1-vignesh.raman@collabora.com>
 <20260616115410.325837-2-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616115410.325837-2-vignesh.raman@collabora.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA0OSBTYWx0ZWRfX0uS/SMgTMXeE
 ZOsiBYuObmYllyZ2vWF9gJnmf+OF5eSM16FKeMZOpZvFp9v0+NtOWPIyvZOH5kUF0tOOeXpGOme
 1bvwQeEK1eu03EZo1pikr34B1Bsn7fI=
X-Proofpoint-ORIG-GUID: nGcP_XLB8fvSVv7khRG3mi0HDDhAxVYm
X-Authority-Analysis: v=2.4 cv=b80ncdGx c=1 sm=1 tr=0 ts=6abfa1be cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=e5mUnYsNAAAA:8
 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=JEwvJmOL-QIgOP14BV0A:9 a=CjuIK1q_8ugA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=Vxmtnl_E_bksehYqCbjh:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: nGcP_XLB8fvSVv7khRG3mi0HDDhAxVYm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA0OSBTYWx0ZWRfX/xskz7TyOIKK
 /u7rLz93aJkDQdBKmyCAh00j8UddzYIGCwFLibWLLcQ7DS7DO0IPqav3a9uaNA0svuIhF+00hNh
 vFrl1PtJ0/V8aOI6ySw+P4EWlZBrj9QTOiQLWVJBDSGheljwAKInGf9I4vigITlF3HbvLiyxo1g
 iXu4ZW1bLztA7hZ8lv08arOkZD6xoN/fr5GG+eKR0IQwgM/nelL7uYtufsLjoX3ZuCo6qdsVRlu
 Q/qHp8le2SaCzTF05pVn/5QbrJ5k7/QCRrfMJciqAfEBEQH4uyQRTyYQCqtKEtVFeGaCkubSERF
 QTLN7h07J8iBx60LozUUiD29bW1m5R40j+7aF7m8occF8TDGP9w/jz5QuknQZjlUMjD3tSPQP5b
 OMHt38ieN4xB5EMu/ac3W5cJQB1oTOzBjTdSxJoAP8b610YhYQuHpZry6thZphopscFtjS1TlEG
 MbWtTNN2vhJguwLcK1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020049
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

On Tue, Jun 16, 2026 at 05:24:04PM +0530, Vignesh Raman wrote:
> sc7180-trogdor-lazor-limozeen devices in the LAVA lab have been
> experiencing stability issues, and 4 of the 6 devices have been
> retired. So remove the corresponding job from CI.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v1:
>   - Remove sc7180-trogdor-lazor-limozeen job
>   - https://gitlab.freedesktop.org/drm/msm/-/merge_requests/221
> 
> ---
>  drivers/gpu/drm/ci/build.sh                   |  1 -
>  drivers/gpu/drm/ci/test.yml                   | 10 -------
>  ...sm-sc7180-trogdor-lazor-limozeen-fails.txt | 22 --------------
>  ...m-sc7180-trogdor-lazor-limozeen-flakes.txt | 20 -------------
>  ...sm-sc7180-trogdor-lazor-limozeen-skips.txt | 30 -------------------
>  5 files changed, 83 deletions(-)
>  delete mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt
>  delete mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-flakes.txt
>  delete mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-skips.txt
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
