Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA69CD4F49
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 08:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A72510E6F6;
	Mon, 18 May 2026 08:10:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Igy1keKt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hLd7c4t6";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E29010E6F6
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 08:10:34 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64I7Nfj61912590
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 08:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u16NnZfYSFY4xkfpv5Zf9NfzaJ8H7jvZjFQscSXeWSk=; b=Igy1keKt4o6Utssk
 BveJW0y7FQVkgiKMTVlHNX/6EWf50fxqbjOVFU4KfWZAcNCKESvv82AX9oVPb/tF
 Q7wURzp+lr4/av7HG4KoTyGLwsVJWBsI7Z4/8+ZC8N1mmktcD6CXg+t5Tq747f1J
 FhZ9CvmBz63tPLl57qL4ea9hK2PPauFvPFcZF3K+uWFgckyP+y2qiWLwrEId7cjs
 avwecQ5xWUx4nQFMhxGSekWuB8dokjI8CrOfG8EOE4W1NmgX86V6SBG3ioBgqLLG
 iEByiNTTd3UzbJdFOkDwSPZuHnNGiVmhQvNFyuPckzezQlQLPaiP9O9WwidLZz3K
 4sUVGw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6tvcm8ar-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 08:10:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d5d076d88so5946161cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 01:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779091833; x=1779696633;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u16NnZfYSFY4xkfpv5Zf9NfzaJ8H7jvZjFQscSXeWSk=;
 b=hLd7c4t6ibDmybEEBuPSrnrJHz+2LIE6fjZYuDk5HTSFmjsDCV7h9mowMAYjGaCUmN
 hZ82FnBsYC0OqEBdsbeaE524efz5kgfU35o+dwvNAviftdEVlp94AXYektwhZnGlgrQR
 To7Xs20+r6FaT/I5/d9ffypOdMY7Y+x39RJrX008Ann8ayzusCuacEmzseEQVqlmRKjM
 zveuo1lvYxjLeVp13KKd1mNwYfe8Zw0ZQV5v4xG824pHgffsj0UqZjzoaM+HtRuKAa/+
 XX+Ua4smuG8wORL9efvxcdWVswEIpq2uM9S7En7a91BdoUkWcgxJwlktAUT/YAQyGw8r
 2s4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779091833; x=1779696633;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u16NnZfYSFY4xkfpv5Zf9NfzaJ8H7jvZjFQscSXeWSk=;
 b=Q45w9DsYCDQuEURLZBI7q/LcBbKVKQ4Ch0wIVITrvUiUxpTxLWfTEC3Ci1YBWQaNhY
 DZuq0+C/vOzZHnouPnFdcX4AthF7JvMb12iXUhVOYa1NPMxPFiw4RPMEuByPEg+qakq4
 ZwM99Bu479T+m2GZPDtA94wwlJGZBBkUeztCGZRKl+sRx07KOzKQb6zXZxkKA8sZx+FH
 VtuVeeomOGkf8rZovYYzroWz4PBbVpVqCIZ7ge99B30OIACjApXbzu8pQEDZVywQa6GJ
 JDmIRPADi8utgo02SnWWzfLzBToSpfcYIfi8k+n9G53qjtfOeQSxgNiUXRD2fGH16aNg
 gwTg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Mb5fwDSe+5VKYvHh8Ko4OQ+G/BCNPdqFbP6AvJUamWgm05rRR5PbeqWNFAnbuL7mKVhEapZ+OFcs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwljKAL8Lm+ZGj1gCbZgS1QkXcGkqbbBGkEVMqy5cDFJMuBSzgL
 RkBjM+Mo7/082U4HTLRzbeo2fwP+NYKbenlJEyunP/87PZM1RS0U+crvkZFonAneOF53zfeh+fd
 9iRUrhrEDcWPtu2IkgIazT5oeRqG8plUaxe4hyqwEx5IhIsJOj87ZdFawmB+zgXitPixS1/o=
X-Gm-Gg: Acq92OEXocKIhc86GWGaT9igv5/5bTyrq9N+R4e9tSDc2A+qCJ57aRnCBh86jNvqvO5
 VvT7NaJplMA658jgbUvHaLoCcqQIqMP/eXVwRscpOUULyFbzHBpo0bUbgRaxADdZxE3MOlMSOSp
 E32Ja6Fh/5zlb3l9220/x/OHFUFpM6YWO6/vtfsZW4Zm3pxAKofvXaHpgW4jUoKIG70C3TTIK0T
 wDRkDTNgUBvMAQiRlr5pbrzy1ej2M1bfy1uZlTsI6xRtl0lt1+AOevB5n7HmGBFj3PsB3KY9NeK
 NpQZqNviEIv1pazu3iMe10FDQ2hbpz3KF4QGuWprFss6HQNrKjRwJcugbv3RrMP+PZgiy2SmiAn
 FfFTpsHFbrxNgYG3JkShWx3XEJpdmrCE3g3/wNEflpU1gIjjAu1UwcrMo50tS048dQ/KV6CVxa6
 DrA8o=
X-Received: by 2002:a05:622a:1b05:b0:509:39b5:a977 with SMTP id
 d75a77b69052e-5165a2030f6mr119721811cf.5.1779091833073; 
 Mon, 18 May 2026 01:10:33 -0700 (PDT)
X-Received: by 2002:a05:622a:1b05:b0:509:39b5:a977 with SMTP id
 d75a77b69052e-5165a2030f6mr119721561cf.5.1779091832587; 
 Mon, 18 May 2026 01:10:32 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68311879413sm5037581a12.25.2026.05.18.01.10.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 01:10:31 -0700 (PDT)
Message-ID: <3e40ef5e-0a8c-40a6-9422-6086be8cde1d@oss.qualcomm.com>
Date: Mon, 18 May 2026 10:10:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/msm/a6xx: Enable CLX feature on A840
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260516-a8xx-clx-support-v1-0-62508bf651ac@oss.qualcomm.com>
 <20260516-a8xx-clx-support-v1-2-62508bf651ac@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260516-a8xx-clx-support-v1-2-62508bf651ac@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -o_9--MPyVUuAfWiQM10L0mwuuuSd6PE
X-Authority-Analysis: v=2.4 cv=UIDt2ify c=1 sm=1 tr=0 ts=6a0ac97a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=RZPte_UQLmBFeyYnhWcA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: -o_9--MPyVUuAfWiQM10L0mwuuuSd6PE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA3NyBTYWx0ZWRfX8XNvUFUMiu1N
 ccvi0lTt4ivHfQDwTVBVPHv4WASvyaE0Xwuk6ViIwQsMM4ah+WRvU27qaKiYPsY2PH8uA+l1E6V
 Hcst4EDNTM8bVQuNAmPFcaTvUTBFBqMzR8dUVzKJa8QvtTNOovPqdzaSKgS1e6lN0bgOohg9O8I
 8oB+CNDD2io7JdRcJEHaWHFvz4srwmV92N7V1f/0e6riuQr3Bz0wTWAekjhGYbDI7O+fU+etPpc
 /+8wGVr3zL+my1P6DrNBsCmvCJHilOsQ+uSGkJmbxTvdbp/HmyEAmGnMNsAUDOK3+6kOcUqciu8
 sYOFsD2IjoVlTdpnOLqCRCQIaAPCuuvqfRKmN7rXwDdh9zYrl34tV5QOqpHHcxrzKuwnMjiARd9
 JGAIPrpbvi8lE8d3sOQpIL6ckDL8u0ZlJY91RttW8oLL5lHi2hNhLAFzhL3xFUvb6GjtH4jzCR7
 OisWRzCTn7qoxeAI8kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180077
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

On 5/15/26 10:07 PM, Akhil P Oommen wrote:
> Add the A840 CLX domain table and the IFF/PCLX limits table to the
> catalog. With the HFI plumbing in place, this enables the Current Limit
> Extension (CLX) feature on Adreno 840.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 86 +++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 550ff3a9b82e..c503912a61c7 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -2108,6 +2108,90 @@ static const struct adreno_reglist_pipe a840_dyn_pwrup_reglist_regs[] = {
>  };
>  DECLARE_ADRENO_REGLIST_PIPE_LIST(a840_dyn_pwrup_reglist);
>  
> +static const struct a6xx_hfi_clx_table_v2_cmd a840_clx_tbl = {
> +	.version = (2 << 16) | 1,

Is that major/minor or major=2 minor=0 patch=1? Please add a define

otherwise

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
