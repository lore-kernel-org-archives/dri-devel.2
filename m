Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F730CA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 07:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4A4C10E2F5;
	Thu,  1 Oct 2026 07:56:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AEnDPkWt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iOEzaNt/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8118810E2F5
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 07:56:48 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6916xmnW1661068
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 07:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 55BoVja7JiXdBlZ+YWBAfLc8GBsMp64knOlHKQvzge8=; b=AEnDPkWtkJTJRUjw
 nNdGsvrlezoKKR8IEQXvEEsjaViue8/L1mSDUz4s3yhs0PM0zVcF/O2ewrZ7Ndwj
 sEBRz7D9E+T6zwAIYk7ZoaYDsaflCl0Bml2wEZE8n3VwlTZ/ZIZMuU4MqquyROui
 4QxO4A0+EU/D6blqv7bXHPHfyyr+j7v75CVSdBdTDt7eXaIfkTSXfuBRBzbrvR2a
 aqQ5+qok5ee+DUmeNA6pfpMJJpxTcA8rDq75/69CNYEGBsMwLMX2ylxCpb0WwOtb
 AC06X+pvTf4yU4Y9V4ZnAM0A4EH8PVsl1i37L/9Dc+l+jshLi069YcG/GdNVjhOc
 hVwBow==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h167pk56f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 07:56:47 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9106bb33cdfso12068816d6.2
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 00:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790841407; x=1791446207;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=55BoVja7JiXdBlZ+YWBAfLc8GBsMp64knOlHKQvzge8=;
 b=iOEzaNt/nWDlGnv9SKmTnUkIdD9wH+B8aMpd6pX+G/3eKo1R9eFa32/7hfd31ajUHp
 9BNKkhtLgG3hAd3wq4BMKb0+9mMtD9kv/FGbngn7BvajHJ9J1QnoxAxGn35kHdrvyVHp
 iWntqLnHY/ykdCsdQ3F1EmghfHMVTzJ5gJYPleWfAGr+5LSQF87smGfXtxvbYIxx0x8K
 rugafXF+qbUFvbuMyBhjll37frxYholOrAI+LQElQvyq1doiXiUiaAWnYc4X3PW/nl9Y
 6cZOnTwkexjUenz/9Qu4GSOp/T7tFShkhKY+COHkitgS+keHp7p75rBgKwucFzf9ce2+
 KxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790841407; x=1791446207;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=55BoVja7JiXdBlZ+YWBAfLc8GBsMp64knOlHKQvzge8=;
 b=r7RLK0e86u5zxnGaYjsj9pdI+rgJ8AjddFfzouYsi6F4XVBm9kmuEbtSYyqJhhLID4
 AKPsWlDzVY43WqtYMH3ZUUrc3veS0YwkOHDu6MBd2rWPRwWAVQV2+XTd49S7b/YBRqE3
 B8pSpRpU4UFFnoeE8RSOky1NxBkWohzOb98ImiVcbA75c0kdK6LmoMH/pqFLxwVWe4se
 UmCRBKUXPPHoQPibyjlOztsNVU5SP4JTtKaFEw+l14nIAnhlD5sj+26h479psFBDEMWn
 BPYmxjemGvn7FkSE7jRA2NBJYHIe0gvmCkPBvjrhivGvDIrz4OJ0xvKqxUR96FWgeC++
 B+9A==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4yEnlsPh/RxdT4wS3yLXrIPV35CoLeY29Rl2Hp0EkDR0jrzqenrxb+SISZXY/TaBYpZzURvD/cfE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nV3NyEd5fkkNDUcVlW4Wb+KBbMJEDQfPJGVUSPRcq55VlSgvbm
 /+u2R4t6GKxUjUsE3Hiy3NaBvS6UFQ9LwjfqbnE7o2/rXfdtLgtp69AD1h7ZXQdusu1BtyKwVAw
 PPs9jN1fE4/ModmgzeiwgnDx7chd/Hvx2JYUAmgpQMEdUTJ04XrtBng+9wADMixLTGco9DvbcvE
 qSVsY=
X-Gm-Gg: AYBFou2BPSK+P9WXwy04krmKoiCFP4c9qP3RGQEg6FmYR1MMSe+W/lGheXMMrOJlRI4
 VoFyIpe82Hb+GhyE05mltoX27JmfArMnU9R6wilUoAgyX5pKmnz3l0RS1HYcVREbEUG+QrkLXxN
 lmdNk3Uf+bJ04baQHtAgiR2qwkgM/BtHri1wdAEgOXp1rSw1xDcd0vA/Q8gbhJ/qz448XZlrXsv
 oaw/ukmxJPlsDfr7KuDFZ6gpyD1XARt1sTxxmfy9Yw+pbStU81y5hptrb7fE4W4cUQeza3Y7+Bz
 wLcpAzRgJKKWA2cUE4dllfizssGBtZlqdg4wQzi8j30PoV4oXkRS34yW1n4/ATUkCkNbFFWJIw1
 a/CnmcPnNyAHxY7+Csx4Nxw==
X-Received: by 2002:a05:620a:4541:b0:939:eb09:4458 with SMTP id
 af79cd13be357-93ca96cd5bdmr657117185a.3.1790841406692; 
 Thu, 01 Oct 2026 00:56:46 -0700 (PDT)
X-Received: by 2002:a05:620a:4541:b0:939:eb09:4458 with SMTP id
 af79cd13be357-93ca96cd5bdmr657114985a.3.1790841406140; 
 Thu, 01 Oct 2026 00:56:46 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2e31d866d9sm104499266b.54.2026.10.01.00.56.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 00:56:45 -0700 (PDT)
Message-ID: <15e32d18-1f58-4a0f-85b6-affac29a0a48@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 09:56:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/msm/a6xx: check pm_runtime_resume_and_get
 during resume
To: Roman Demidov <roman.demidov.nn@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20260929142103.81854-1-roman.demidov.nn@gmail.com>
 <20260929142103.81854-2-roman.demidov.nn@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260929142103.81854-2-roman.demidov.nn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: uDUy3FoWClF6VKJOJiR7FTjTHdjqbD02
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzMSBTYWx0ZWRfX9VfsOxA0o8Pj
 OZ7spopROZPOeHuaJLvpIpvj6AfKWC3AW0skp/cqEjO9OFch6/fQjXHpIaUYJKo7vSHxj897ZZy
 xWQXATXeoLGwi4nSdVepVWwCLfDsLic=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzMSBTYWx0ZWRfX4BCy28/L5GZh
 TxN6Q5eEmLDi3vAbx/KJ4vZYQhjH7Vvm1jtu6j0mXCpc/ySX4NS9/Z9L4eb98IKiUEXTnAhMO3s
 MAgnuTrOuGx080sf5iAz3LQrfK6IjpaiY9HA8XRogvey6Uw4VPyQJuLMII2F0tYB4/MXihdL17d
 WkfgExFq+Sfct+o8vc3Wop3YTGyGoI9dDv/bmGB+7zwRHaNARvjlDeotR+EyppHxTQyYI5trOyY
 dPtW0J1t8Vf6TD/W0m84ufCVKrRrL4e6Dijs9llazs0Tc6pTfLbY8yA0Bn+3Qj0dPTM82NZ4vqq
 euyTmW29V0aN4zFwlneyKJ109c/PwlP/SDenk6XafNdjHXs0md4Usqd28ouLr206vsPKve9Osjd
 N6cs5K8MkWqCcQiGBXFSQeXuqge59Gi8E5U94lWqnhuWMkOcnnq4BAHeK8y0xUAN5g2BDzyYawS
 5VdbWQm/AWCgl7JXPgA==
X-Proofpoint-GUID: uDUy3FoWClF6VKJOJiR7FTjTHdjqbD02
X-Authority-Analysis: v=2.4 cv=WpC+otfv c=1 sm=1 tr=0 ts=6abe123f cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=HH5vDtPzAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=8WuSQyhVeKmarUdqJEgA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=QM_-zKB-Ew0MsOlNKMB5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010031
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

On 9/29/26 4:20 PM, Roman Demidov wrote:
> The return values of pm_runtime_resume_and_get() calls in a6xx_pm_resume()
> are not checked, which can lead to hardware access on suspended devices
> and PM reference underflows.
> 
> Fix this by checking the return value of each pm_runtime_resume_and_get()
> call and properly unwinding the previously acquired resources on failure.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 5a903a44a984 ("drm/msm/a6xx: Introduce GMU wrapper support")
> Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
