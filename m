Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EC9CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8315010EED2;
	Mon,  8 Jun 2026 08:11:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="l9DsxP1+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J/8OR3Wh";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F74710EED1
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 08:11:44 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586PTub2808212
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 08:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s+HZQmCjytazYLSvvHY/io1wridXfLJz+czVsgR52vQ=; b=l9DsxP1+dDB/MnJ3
 X8rsY8/xOhjKoGh2ZydtIl/B5hi+BaJEjBSeQnh8ekFa6u+BQPYm1zupZsbob5lu
 scewVj3UX0wLBDimrY0DG1eL1xoN9mrIzIjALsrcLR7BYL4fkIG7Z9WN7a++zHJl
 ihGq0pFIjyrr2ldZuJPKVATY+q7slQzBQ+NEAyWxH5cLxhGeeHuGFcZrw0HVf8bT
 e48rg/Ctg8dM3f1NwJKMURSs3lPEawXQm8KbnZIV9ET+aR+pb0F9VQXyJjQpeXHw
 RQR/j71BBcA4Yve0OPI4YuqD/eW9wXWNnDI3xa7o4WWKzPn1Nj2c/HoAXY3m/Ed8
 Zto5vw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emb4w6rnc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 08:11:42 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-517741bcc53so11132221cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 01:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780906302; x=1781511102;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s+HZQmCjytazYLSvvHY/io1wridXfLJz+czVsgR52vQ=;
 b=J/8OR3WhvwDbiBYgWJBABV3Sr8fYqpBnSQFkZe3vzsXljIQO4cE6v9gAyj9HxOSG5W
 +K4MvqEzrS/Syob3SkAIQ8lOETrVv6cUKddOdRj6MXHhqRTtThBGjOVqD05MJ6T4bT5T
 PjHvkB7OF9hrQY+cGCXOHQoFpL1EQRhiXatsdz3f6wwRVTNUF2ZypOTe58BqEtVLybSx
 lIrqol3dMAH5fqT5ZuZlVtW+fvozQzgp6cwLItl6e+NQ7WHG2ORUycIWo2UlE/q/dvlZ
 /GPkb2JEozeG99tFuQNqUQUBPAIMjOV3sMNNi7qf4aDFu9USqZK57jVOio7WpRLsYIGP
 O/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780906302; x=1781511102;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s+HZQmCjytazYLSvvHY/io1wridXfLJz+czVsgR52vQ=;
 b=n8REIFxelvWVxurC4bC0uf45OLdvIJTAsG8ciQA34Kk7D/ttCooEyEYvlRWRVXd45H
 b/hd7bnNdaIiC2qwFX6oi4tPtTySnO5qC+eB1d47or04JekOB9r7q6P0DUmj/Vk+OMeL
 wijbeZuF0P7f23rBoOoZ4Txun18yPUwruBnI+YNiSyTojN+pzdB/d9kzXfx3/jrIf954
 Tv7gsSUq77PutPFRdCuNWq8er3CqL2o7AEeBLV0CePl3RH6T64Kme2ZEW8W2vvei2386
 RjeYUFdQa6lySzJYZxbHIW1uOZjBQJ/pZZRtSNZOU7x+YVokue+Ji2S68CaKTP81hzVI
 grpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8mZ8amcGvlX0Lf8m20gy4KIhunNN0K0CtyurCco0m98MIsUdGf0bJNT00km35qig2jAiALB466dZ0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBZWuFx8+qbqGfaSgU+cMCJwtMoBcqUaFCHesYMfYiVM27wukP
 K56aSCKp+DVsXxmO0yXaHYoqbNvlpeR88OZ9YyStigt6lQqowhianwSgxD4gbgrrHgbA0cdrb48
 39qlA8//DSkpzYrQkXr534dW65OnicE3vlYRf2+i7WY/epRd8uCb1SMd2+KoLGIECZExFeQE=
X-Gm-Gg: Acq92OHFfWvQ3mW7KZnEpwGqv4TIXB6kyHxXBrlTV3o7/pvTg28cvHZZyBRJBN5kjm5
 vmtvKhvWtXgjlGx8r69wxk761fPE/ZOrZEBT4J50impAnxa/ZjkbTdZQnxG4lLzR4Y39QQkVWeR
 vbw16rWOnnJ+w/3PSEH1QnuN+jCDm+lPri/+Ld+eyAbATH8z+cB81HrjzfB7O5Ez80u7cIbX6L8
 D1ROSnwDjsS0IXsIuLnkYyb7RNwxm++AnVk2X10PI9GTt1sxYfjJSEO36sfdYl7VsGIKW64vL0E
 3NmWAYjzI93CxHLkow3UVaG491hPdKmPFU7fRSlu9wh2MdrDlKkMNQy5sGSBCxBXIrfSpoNWCG+
 KEkf+RYeUlvtEv8Mza0TGD/g5BG8MDhnnbwNipGJWsvKjyIT34+iYuPsP
X-Received: by 2002:a05:622a:120b:b0:50d:9138:3322 with SMTP id
 d75a77b69052e-51795bebe2dmr136988571cf.7.1780906302357; 
 Mon, 08 Jun 2026 01:11:42 -0700 (PDT)
X-Received: by 2002:a05:622a:120b:b0:50d:9138:3322 with SMTP id
 d75a77b69052e-51795bebe2dmr136988431cf.7.1780906301968; 
 Mon, 08 Jun 2026 01:11:41 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0559f1f62sm840014066b.57.2026.06.08.01.11.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 01:11:41 -0700 (PDT)
Message-ID: <cfefaca1-01b5-4c4f-8bec-d59f88b18dbc@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 10:11:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] drm/msm: Recover HW before retire hung submit
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
 Jie Zhang <quic_jiezh@quicinc.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
References: <20260605-assorted-fixes-june-v1-0-2caa04f7287c@oss.qualcomm.com>
 <20260605-assorted-fixes-june-v1-2-2caa04f7287c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260605-assorted-fixes-june-v1-2-2caa04f7287c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tV2kaJVp-hLXoEKc7Ih8SXemSP84TybM
X-Proofpoint-GUID: tV2kaJVp-hLXoEKc7Ih8SXemSP84TybM
X-Authority-Analysis: v=2.4 cv=YIWvDxGx c=1 sm=1 tr=0 ts=6a26793f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=1CK4PI73WE-LNi9EeHwA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NCBTYWx0ZWRfX9TSibVC3jXYS
 LkNeiYC2ZnASDkUAB63meX1v7ZL/ohq3rzmFKFiLxNrebDboxF6Z2z9xMUMQHi3dSYAnLOw25fU
 SVBHssmam/NEbFaLh1k+pULL/Qab2BBx3KeE0CX4utAEXJGiFsul0ngYvgK+PSJkZ0KnLuS90uq
 iZZzWrvAmALeUvXFZMOEai0QZOvS9a7lmhKalxuKwjMJatqaqb4fD9mncxzI6+mLLJT5x0Qo/Af
 ut2a0cNnN1WeJjp9RNkm3hzAZMlyczDPXGcSihd6ZtqWIDaAjUnjDhO89jigJmIYcgb3f58bHeu
 DDWlCQb+VZttFHfAPquPjreIfIb9eE4pXJvVWvn9l/ndZ+wGqOZPUMKP+Dv3wu1LzEOq906Ha41
 ag8PLlNSs/1m1TFau7jjgX5APilzhDpB5uGxyd+evOSn92LNzeE41ZacyPfbXbSJno0bWAHdf6u
 epfbZqXklzmU7TGNo5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080074
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

On 6/4/26 10:08 PM, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> During recovery, it is not safe to retire the hung submit before we
> recover the GPU. Retiring the submit triggers BO free and that can
> result in GPU pagefaults since the GPU may be actively accessing those
> BOs.
> 
> To fix this, retire the submits after gpu recovery is complete in
> recover_worker().
> 
> Fixes: 1a370be9ac51 ("drm/msm: restart queued submits after hang")
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
