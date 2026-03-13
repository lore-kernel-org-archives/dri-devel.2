Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A0C105F791
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 10:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0037410EB77;
	Fri, 13 Mar 2026 10:22:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YnMAHNbQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W76UzT77";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 921C310EB79
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:22:09 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D8vFoC481699
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9RLzBru1PJO/xbKYewzMwJUh7vtg3J9W4Mz3Jhv2beA=; b=YnMAHNbQYPlu6xTX
 f45SZMUf4QMkso+YRyd6pprSEk8AeUxxh7FS4JyoNyewUfWh97e83XL5xH0WomI0
 OPfRB9ZaUh9aPgMz8hrqNbycNAgihzudZP+7VYPz1FPgTDWicwll7B3NaP/tobJG
 XBsSWIDdB3oqryX/14NPJeZPMDlMjqy8Y+b9ZPdMqbrUyEyaYUTDM6VHLQ0zMKJ3
 IdHaNCF+and6iAAqxCUwhtFWpxf1EGiNTPpML2iI2+vZ3LlcS91iB3lN9lo4/hMf
 rg6Fw9h0SrE7zc4vBkuc0MNe4/lQBpUyzwVkDWnt6iLHia9wVKTDrCdkOuE5y1OL
 QPJc8Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvfh7rae3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:22:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cd8198fe16so127504685a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 03:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773397328; x=1774002128;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9RLzBru1PJO/xbKYewzMwJUh7vtg3J9W4Mz3Jhv2beA=;
 b=W76UzT7734K1w6IZ2NsWx3NN5zahGVPVaR/lbXl8/1DCxbEL0tPBXeKUVv+DEw2xZo
 DyIZdVPBRBQvPJm59A+fkMzW1g3yXFOlHPYDSUGJHMsIU4Iz0iMM5z5qJlV7RrL1WSej
 dkMO6VjerYxj1jBQKhA3S+SN5dZFqQ6mc0heRQ+OKsUrx5Pi2hAczejqViaouOKhwmdi
 rv+5edhxMowyx+W4M0lRx8ZE9/CHWQL+tfhy76hgxcHj+xKbaKgosQoOKe0VMAdKWo+V
 yUKp6fquhk0CC4hSUOi+hwTgllZwoOiMkGHm5PMxjtJpSYiwz2zXQmtWXW+bW2jNMsl2
 qqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773397328; x=1774002128;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9RLzBru1PJO/xbKYewzMwJUh7vtg3J9W4Mz3Jhv2beA=;
 b=XsxZ7yWhXOZXEr8qwHjM42NFbyuXAr2HkfRaekelu2iQ63KfLZMTQ2hh5OFsqKmHLL
 mwRA+LMwEkPwZ0bkEo5x43CxJQw/1agLPl4h1hiFwCw72FLM4PjbASaps29Pwnw6ZbcC
 DBGm9DST5SJeG5G/w6E9zZ/xh/ouOOgkzTwzMTwpnQ1SrQrY2+exJS+axScM2sPQLVQs
 Rv2A4vqyLAx/IrZk2TeFmSvbceZRxADw7O3N8nYMROKDVBiUf7YeBa1K0Q3KJMRz4I0Q
 phiVaMvWYLQbYmzsoQLUtbZcCv9mQCNFBl4n09s4F19wkkViqLIgViLl3iZi+2VMkGTY
 8PZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTD/0DRi5UH7oFjMerx7DvsumNhLk8E4BxUkaJ1+YnfdjBRnhC2qNe0vtxFQIePJtxKKihRDW0XrA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsEk/EnBTXAwPU7DfozAlppJvEbFnw6k7EK57T44RodbFsSKPQ
 M+Dl0jXl50qMv39jW5/sMPeobgbO5mDARBf6NkVOLWFdpB+QABNaMGmxImYGBfOsO8CTHOQgIJm
 u7T80CUCAyuzyIkQgUd8tEd7xGJ6E77XJY7Xr4omX0HGxZTeRxO1UcXoMorEiQM3CvlJ3SJQ=
X-Gm-Gg: ATEYQzypBP5hiuHIs3dulVN2IF2NERdUUtWph+1veHhI+ECAJbc9Af9EYtFx5QmfazV
 RnMRrS3kkSgG0CtZYskg8eQZaWhRvmZfgfI2E6fGof7TohbqUuO9MPFY1QsFp9ezsJlmYAtg5h7
 yKPhkW/xmJgfVCDJybuqeCiYLgHOImEx1t+n9tuGD55zsTWq8yp4Vgc2RCzr+04krnAf+xcI1eQ
 LG3aBRRWn4sFyWSGjQq85looH0VceY9CLT3u98w38/ziia6+gN+WP7RyuaKHSPxhX+f8A1ce+Xn
 iKGqbvwnmh830reE0kLN4TbvJfzc1Ru8pYUgBocgeJGWavnLD6FS4/sw5VU+cR7dKtAbTYpng+d
 FASx6Vh9t1H1t32w7UPdZLWuPudlf/xk2uvzVYi/rgb8IvIk74ekvKM4CNdZOfmCd8rZyBEb6WW
 zrrmM=
X-Received: by 2002:a05:620a:4625:b0:8cd:b2ce:b746 with SMTP id
 af79cd13be357-8cdb5a1caa9mr274207685a.1.1773397328102; 
 Fri, 13 Mar 2026 03:22:08 -0700 (PDT)
X-Received: by 2002:a05:620a:4625:b0:8cd:b2ce:b746 with SMTP id
 af79cd13be357-8cdb5a1caa9mr274205585a.1.1773397327672; 
 Fri, 13 Mar 2026 03:22:07 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6635088ffadsm1220549a12.21.2026.03.13.03.22.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 03:22:06 -0700 (PDT)
Message-ID: <f16d0ab2-dc40-40c9-bc1a-772efffb71a0@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 11:22:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/27] drm/msm/dpu: drop ubwc_dec_version
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
References: <20260312-ubwc-rework-v3-0-b7e8f800176a@oss.qualcomm.com>
 <20260312-ubwc-rework-v3-18-b7e8f800176a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260312-ubwc-rework-v3-18-b7e8f800176a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: xSQ3XWp7bWHT7Om6vG4yKNSbF8qOAz5e
X-Proofpoint-GUID: xSQ3XWp7bWHT7Om6vG4yKNSbF8qOAz5e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA4MCBTYWx0ZWRfX84AQn6B0P1tS
 +EA9RvopgNppMdf/wBw3rkFIuyRycGoJ5iQGleNSWzf4vCYoenkqgbHx/aapMXWVQ7dNzEAixKB
 Ki2G0xp3bPMz9HdgJbWqX/4MS7cS+eIGsFAzNdHreGuyM2M6RsXsVHlFCgWmHofJvbkJQItaXeM
 NpzqTZWA1NK3TokRxNkLA3Br27ImNY9FxqZTgO5vLW8JZq01nsRVKj3dnv8h1QcuyXX2L2pHSgl
 7fSqywsl405kzAe97tODb4QqrvQnfmhkdLdrYwVkU0L56swCgIzn7b/PMA9Qr01DiqocN7Bwstj
 Q/n6wDtSLwjrhJkoYty+CH+ls3oJy6+XaFp90t+gpQfFDwIQGdcw9nVIferVbLYeMl91MOhV/kY
 K0LiQHIStuiqvWJstdw2oiTQWfTANc0FCyP4kz28V1d7kuj6LQ658vHzaW2wUd3cGe9n5ADim/P
 aMg20XVGeTbJOOvuMHA==
X-Authority-Analysis: v=2.4 cv=BpiQAIX5 c=1 sm=1 tr=0 ts=69b3e550 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=tWrNggSR6SyvBOkGGPYA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130080
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

On 3/12/26 2:29 PM, Dmitry Baryshkov wrote:
> Stop using ubwc_dec_version (the version of the UBWC block in the
> display subsystem) for detecting the enablement of the UBWC. Use only
> ubwc_enc_version, the version of the UBWC which we are setting up for.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index 547d084f2944..f424be5ad82b 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -1718,8 +1718,7 @@ static bool dpu_plane_format_mod_supported(struct drm_plane *plane,
>  		uint32_t format, uint64_t modifier)
>  {
>  	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
> -	bool has_no_ubwc = (dpu_kms->mdss->ubwc_enc_version == 0) &&
> -			   (dpu_kms->mdss->ubwc_dec_version == 0);
> +	bool has_no_ubwc = (dpu_kms->mdss->ubwc_enc_version == 0);

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
