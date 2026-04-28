Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47B0FF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E78C10E11A;
	Tue, 28 Apr 2026 07:55:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mt+rXzIv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XsdXnm5v";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEA1B10E11A
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:55:14 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S3kSsa2112686
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=S8G8K02HvttZ2MDTZAXU8QDZ
 sZ0XQjEOBIbTjYdF7BY=; b=Mt+rXzIvD0aha3xya6EF0GN1J2glocV6xXKt0yDJ
 T6aJliuJFj6wj9I4hf+GtcKozc7v7lJuU7xtoywi8XLOmjHsXwDNdvJGMcJZNP/p
 c2rdTz4v1BtSXLHKlkKQyFsr+QrkFDamiSK8hoeAXhmNa4kZSQBbfjo11P3VTgor
 3XSJtObPEDEv9uXPLM+BDtrGy5JRHPrnUkBFdBoFl/aMrK9CPnI7ZQANRS6fNmpf
 BwxuCSuGAkDztKTw9seZEmFJyXrVPf+HFlfmWZa9QyaBodiassGrKN+0ZjuGTcqA
 uewof6mykFAYoIhgDrK7Bh4WlipOnt2GThilLc2xvrPajg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtdmbjfxg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:55:14 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50d58bed44aso239971171cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 00:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777362913; x=1777967713;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S8G8K02HvttZ2MDTZAXU8QDZsZ0XQjEOBIbTjYdF7BY=;
 b=XsdXnm5vSmNpZMLLKXQsyz3Uv2zzglyCaf/c9WUVaN3r4xIVg+1GWZFY0Uu5haiJ21
 tEOG8SFwFTXMwakOwfWQLzs3Q6LsezAe2CLBVnCte6M/PtdQX1/JVCIPOvz2Ak/sY4Bp
 5duSvikabbvEzTPBiqSuUBe+bC83pE33CSDk32jFBMXVWJ2SCQiPvkhCYxeHgZiecJ6l
 9zLzQBKIcAKJTIE5IfC5f8bH5d2OTFGPmm0/Ufd/ODY1/3nRfVJoc9y8TiaH20kwofOT
 oMz8sDIepFfxr2oYKG+eCJP9smWIG3O8PPb68WquPq5kuF9XdbTRKfgtUjpK6/PDIZdP
 jksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777362913; x=1777967713;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S8G8K02HvttZ2MDTZAXU8QDZsZ0XQjEOBIbTjYdF7BY=;
 b=K2UU3yYU++xz+0fadtWuUhm6O8vBG87Au7rYyHZXisGYEF7gG9pl/Ogqer15OHHB0H
 5oALcMSSWFo8qV0d50md8TX2xXmHU5PzEa10oX6kp9tGi7AvL+aQe/rIVUkGbXIWcOeS
 F9hQ0WvqHVrsobZ2vb375S8Xogbpz7YGHvjfRuioGPmVSKSgbP9B7rS/7b/ahwSz6GeR
 sU3gp+qaCM3sapdIdLX0swiJz6YrZaXiOAlf5cwhlh8aibz/2LoQ22sD+UkKTgqBFwLg
 qLWGEAfKU3TC3JqNRYmmMm5tXwZSAMU9NNQ3ZFaqkSP2XU1eLOTFCQbATo0wLLxzWfLC
 2S3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+pput1jYAqB0Yr9/t3Dq51RdNu5UVn4t/+k9skYmD1sykO2Y/XLFglr/SmBVOghv4QdK6Mb2qtsQU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyE+0HQ5qzmpUn4rKvqlSXzu8lvdNNUPserK5/IYL/1WiBM8Z5D
 2/BNPh4cLj9/J89xoad19Hw66fvwEgm+OiZD3tnSiKrnKXee908Ot1sFWhIxbZeyn2H/NXmlAKO
 hWOwAbX7uoaL3zU5ZaS1Be+9mWkP10iz/KTsopCLy/fSR+roCvESVloZwCa7TiFVvNKMYVEg=
X-Gm-Gg: AeBDietMQNSef9VcCrLiieLfhHygQ9DIuQRtOwWASgZyzoxMglvlFOE0wBrgQqUQj1J
 FxmJT36uum/qVuEhpNvy4V8gLsDskreLdN0OrPiW7t5xklRIupskd4QVUc+bbu8L6xPPgRQONpK
 apH36V1FLqBAZ024/lxefYkvs4FaZaHbnnGJ6qj+VVVX6l2DTXyVgwHTP1nYevoHiVopwWs84//
 uNqIxWqXMz/fpcRwt5IwA0VJ+9r3uKQCy7v8XKxfQYnrA4Hp/1wgqVEjJSLxOS7CPBrvhJw2spr
 aQuJFZqvXr4xb9y4CETawOyCHtOFS3z+eqWOso9zG7r7d6d33SwXQJTyO2M7q1T7NjL2s7RLJQx
 fCKYd3pGBCVxL2gvWZJ5Ce9sVkAPuNrOM/K8cw2MHvPavPsorIDo20kGrfjBct/qCiqAX4sHFr9
 xHFpc08qLGH96JNHd8VcGU/IDSI0D4ION3gHLKCKWvw1HSFA==
X-Received: by 2002:ac8:7d4e:0:b0:50e:635b:5579 with SMTP id
 d75a77b69052e-5100e125f1emr29274701cf.19.1777362913194; 
 Tue, 28 Apr 2026 00:55:13 -0700 (PDT)
X-Received: by 2002:ac8:7d4e:0:b0:50e:635b:5579 with SMTP id
 d75a77b69052e-5100e125f1emr29274391cf.19.1777362912796; 
 Tue, 28 Apr 2026 00:55:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a7462ca9c5sm423493e87.14.2026.04.28.00.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:55:11 -0700 (PDT)
Date: Tue, 28 Apr 2026 10:55:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, sean@poorly.run, konradybcio@kernel.org,
 akhilpo@oss.qualcomm.com, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
Subject: Re: [PATCH] drm/msm/a6xx: Check kzalloc return in
 a8xx_hfi_send_perf_table
Message-ID: <edqrfbce5xt2vcyvm2savf5juhehvzydugklhh2a3vzvobhltv@xhlei77na2vm>
References: <20260428073558.1234238-1-nichen@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428073558.1234238-1-nichen@iscas.ac.cn>
X-Proofpoint-GUID: WuDdGtu8EVi-e2OFXogcCY1316FAJI6l
X-Authority-Analysis: v=2.4 cv=PcrPQChd c=1 sm=1 tr=0 ts=69f067e2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=JpMRHLQez2RCAVy9sDQA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: WuDdGtu8EVi-e2OFXogcCY1316FAJI6l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA3MSBTYWx0ZWRfXzY+B6qWf5zJP
 2C7ySkU3QL/2NTqxZuN5pgnZrMTrmJc8D3y5DSrGCEezgO6bMtki/zPVgoxphagNkyiHA/KMRwE
 FPAUU8Mo6uyvPShqVCnxlzBnD8mwufvkvm2qHqHSeePTz3oiiCffZCQTxT/We/XAcKmwLnRa6F9
 oyfqaTjSDkuIoI5/iIIB07L0Er7RzTwvLskmuul2Vajm4Cy6S1RJ3HJaxoSjjiffcIoTXHrE28u
 MwY0aPQbkEEdQwGFURsmeszWCoIw+Vr+FU/4wWZQHcR2dCDh04alpYQpwvl7bJrdL7p1Hk+3V2+
 sgBwExvqNlZLabt06dVFomkgG1wYBNAn1VK7hBpyWYhXmYZVWuBuuVdw63aQICXGj6nN0C1WwH8
 SrPZDwPNcykF3zTNR02orANU6BvYn7LHiM6nLxJzMZQdcZ3LPE/pDBsUDb3SYsg5noZPAkAZbMb
 IMzmQcW7sv9+hysWtuQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280071
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

On Tue, Apr 28, 2026 at 03:35:58PM +0800, Chen Ni wrote:
> Check the return value of kzalloc() to prevent a NULL pointer
> dereference on allocation failure.
> 
> Fixes: 06cfbca0e1c6 ("drm/msm/a6xx: Share dependency vote table with GMU")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
