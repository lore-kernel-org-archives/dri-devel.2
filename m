Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7C5CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 10:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEB3610E4F2;
	Fri,  8 May 2026 10:06:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lXFTBvDw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iZHJ0iT6";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1632510E142
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 10:06:15 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6488mV841417765
 for <dri-devel@lists.freedesktop.org>; Fri, 8 May 2026 10:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OayF4gM8TJfL26qUwfDS4uiyjtIujhhqWG9XxC8ev90=; b=lXFTBvDwjEcLfFuD
 yoinouVC3528ecIKdmh8PZI7aBG57VSdNqoZhaeRe+Vyh8qU4pkkt7Vmk8RMDqXU
 ioHBlKyWMmfcrg1l5yFvC6MXbzm7L6zwyYw6ifH4e+GtxmTijxPTanNLlpyqjt1a
 XOUq1UY7nqNevE12p5TeV+cso9E8fOcyU2RQo34zNYFNQMAxfAIrHIeNzHj7dvs0
 TflAn2HA0SKBdcQYkOBxgze6xkmdJPfh1+h4PqGWhv31ll6w6VYvmcizgb1Dhw4H
 U/L+xxEfuRUDtZUqModHR9khA+eGGVOUli8OjKm7Hxk1PlJtwz8s2pEHl9uKyT0E
 xMvcAA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0ywhk2r3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 10:06:14 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-57535a51589so237996e0c.2
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 03:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778234773; x=1778839573;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OayF4gM8TJfL26qUwfDS4uiyjtIujhhqWG9XxC8ev90=;
 b=iZHJ0iT6heKG2ehiKucEpAx18G6mVIRaSotdyhlJ9/JNJvl2yjb3l3n0MJBkB9AdNg
 hlw4HxTbANFu8hCq9KCM+fqVE3ilMDUL1eJqzw8RzpJUQRovJ4VzooNQ8xHwgDKLjFlE
 9UVXhcrvRqKDEmrvhS0idT2dlJUKeENl/c9V1d4EVQqGVItX9amwZzKgZO+swBN9sfqK
 jhdlbHRf7usZ4V6+YZAYNwHev+rQ//FiJUZSBSy0qXcPJeV1r21QXPaKpWUykozp7G8j
 2y3NBaTh2XInqZSJJimO8H5Szf3Ncl0/Cmuizf4eZzYIePh3YDOw1yyCXAripyZKZKyD
 Ts/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778234773; x=1778839573;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OayF4gM8TJfL26qUwfDS4uiyjtIujhhqWG9XxC8ev90=;
 b=ZqZ9Eg5FjnGPYt2QOhGBdOeXr7NlhIZUM7k7bclwvC1Jy8zQCnyOq33dd00sTDd/1T
 WV9i2h2byGGax9wswg2pxcSSrZkndJGSwRSw9kH6PyjavFEVfdSKfYRt27W9ZEuH7YqK
 q0on+Wu/SNdqXcGYrIYZ4pZKfTY3GdvTG1e9VSSVRSgtDSdGn+SHoTcBRKbXPQ27plB9
 KXoEF9OlgfQDkRFun6M03DoLBOuMNcbSfVBZ5qrLmppZD7oLt36yj1BQgqyL66jMqo/P
 iKjntZESrxRUhdj5nw+0u9tft86H+6AZOdcrqUEmh2WkRzslBx20Thw2n+nXAbt77bol
 YNJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ82b7OJBAuaTudmMlZnnzm5rOas5hh52GU2i+1oGeFY3RoV4Ie7Jgw8bkBVGtTrRn9J2VPTJkDtRcc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyXllRRRbVFroqeSHP/lnngjk8WifFMM9huwBoqPyqolHNn9V1e
 SdWM6mXJAS17VmX0ezJh6mA/eLhLZCle6xGLIorBNFoIsSpjQ0Him1ZfFpAW851WaWaSRCtn8bh
 Yrzd/T/WMVTb3h/KH/pzGJO3mr7apr8TWOqUp4q1G7fJjfjIGa8KxxSBjoIrHygXOJ0ixc9DOZ8
 1XZWE=
X-Gm-Gg: Acq92OFmE2NVbaHdw19v4/DIo2mkVgTfwU0SANF5nPvcnPhc9CRX+tsy0V7Fkj8V2Wk
 XEnuyu5KE+Rl9WLdRCL5O6rU9EXcicCFyr7OxhuFQf9rR3vu4dqJF/AEESHSp7RrVx79uEp/aQH
 IFDmtmwAJmYwyyZdt4VEygpc64lrbH+vHGnkdhVjzvIOYwstchSZSPeXzzGmXmyurRMV7kLK4dx
 trDfw0OrqAU9VarLK0M7hCvQNphb+s/knu4aUZelH1d8whYmFrv8Ao8epAw3zn7G7ulVb7SYf3M
 bjQ+pvJrys5PXmBoQn/2anMFJefgdq0lm8KvO/YQiyd0N0ZgiH/+80f9xQn5fZHY5zbH+Mxeknl
 Kmt8+Fl6mL2kEM3VIYd2+1VGYGTdv7BrwdCa5xYUHum2yMuthJpAAsGX8yv4i0evm25va2Aqnm5
 KPe55d5IbEwbZbtg==
X-Received: by 2002:a05:6122:6214:b0:56d:baee:40 with SMTP id
 71dfb90a1353d-5755cc74085mr2309376e0c.1.1778234773411; 
 Fri, 08 May 2026 03:06:13 -0700 (PDT)
X-Received: by 2002:a05:6122:6214:b0:56d:baee:40 with SMTP id
 71dfb90a1353d-5755cc74085mr2309369e0c.1.1778234773009; 
 Fri, 08 May 2026 03:06:13 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bcb43e09752sm21464166b.59.2026.05.08.03.06.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 03:06:12 -0700 (PDT)
Message-ID: <28dd74fb-ebdc-438c-8624-6b8fa0657e40@oss.qualcomm.com>
Date: Fri, 8 May 2026 12:06:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/29] drm/msm/adreno: use version ranges in A8xx UBWC
 code
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
 <20260507-ubwc-rework-v4-19-c19593d20c1d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260507-ubwc-rework-v4-19-c19593d20c1d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bMAm5v+Z c=1 sm=1 tr=0 ts=69fdb596 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=F66dyu4Cpv24ktMMw0UA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: ZWVPyvIEgo_vwRje-Y4CJew_5Cp3EKFL
X-Proofpoint-ORIG-GUID: ZWVPyvIEgo_vwRje-Y4CJew_5Cp3EKFL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEwNCBTYWx0ZWRfX6uegKoBESi3P
 aHztmxvhiQ3Cl14r0GQHGh5veaRfh9n92YhlMrpTH+0pDVfQfTRkRRuYtImEBj+olmCT/c8Zaoq
 woOvVptl8DwisAd8YFXIIoLxlRlIO+PrFxi3U6HNMcIqWbPHMG+0KYaPLXP4KcfA6hKNs6Ewk20
 gebTtGPrrs96lE86ieDAUCTBbe8urIEQUUVTE/mAGjTUyJv1e+lQPKwI15ZUe8HJCKC8hR5bH8c
 WMMGgVup83MVgCdMofsq4q/sKwa1nrMcbnK6G50zYR3iXBS0ySD1MpvjGvKM0plNU4ukVYCWVxU
 QZea3tSlPFDciEBGdN5SZUfB2KPUs/irj15tkx15HFbTp9dSm/cqC0Mn3t2+KuTyOVajV+IcgoC
 RweoJhFBaYZ1d75wq+8daa8X6sR+3JfehlSSy3JkKoOs9Y2wvMo2EdPGoENUHHvM0LscBuKWAX2
 x3B6nk+GtRFpzkZOoBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080104
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

On 5/7/26 3:03 PM, Dmitry Baryshkov wrote:
> In order to simplify handling of UBWC minor revisions (like 3.1 or 4.3)
> use version ranges instead of a case switch.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index 5c73a9ebb22b..29d559fe4683 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -286,26 +286,24 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
>  	u32 hbb, hbb_hi, hbb_lo, mode;
>  	u8 uavflagprd_inv = 2;
>  
> -	switch (ubwc_version) {
> -	case UBWC_6_0:
> +	if (ubwc_version > UBWC_6_0)
> +		dev_err(&gpu->pdev->dev, "Unknown UBWC version: 0x%x\n", ubwc_version);
> +
> +	if (ubwc_version == UBWC_6_0)
>  		yuvnotcomptofc = true;
> -		rgb565_predicator = true;
> -		break;
> -	case UBWC_5_0:
> -		rgb565_predicator = true;
> -		break;
> -	case UBWC_4_0:
> -		rgb565_predicator = true;
> -		fp16compoptdis = true;
> +
> +	if (ubwc_version < UBWC_5_0 &&
> +	    ubwc_version >= UBWC_4_0)
>  		rgba8888_lossless = true;
> -		break;
> -	case UBWC_3_0:
> +
> +	if (ubwc_version < UBWC_4_3)

< 4.3 specifically, or if (4.x)?

Konrad
