Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3804C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:41:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 051FE10EB19;
	Tue, 21 Jul 2026 18:41:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S/croqKJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zm+Z3Sh1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7BBF10EB15
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:41:56 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LH2TVD3439745
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=+n/NFf65uT2dq8qZ8BzjRHqx
 r6jmGdLSwt4tjEC+VzQ=; b=S/croqKJB9y9nJR1fs48IjHwaX18RWz5LlqrAPbn
 RwTgpH5g3PmowiwedsSRnAaP68uE8cbZNAipKCnsmSm/7wNngiWcD7S13UvnhlQM
 EFHLnQy+XXSgeWs+uyH/ly58ahX9SFQPhyr0kQgrlb+E7wYeOz7XgnMtW7ynTgur
 A8MZNYriTzSdGl4ft/nVlnPvhcmHbdBBMhSo8jqiJ/sHLRc9s3xoobSVHdhtLNPX
 E6sxYQBSP3lHKbMCNMve4a64n8UBy3kwL5BzZPZtsueToApx/7gSYvzcMe8+tAj2
 ULV1z2ag9ad0+e9JHwtPVNZmmtkvcvrVSsl+HMJoBVePzQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6nstghq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:41:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5174a236220so214509111cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784659315; x=1785264115;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+n/NFf65uT2dq8qZ8BzjRHqxr6jmGdLSwt4tjEC+VzQ=;
 b=Zm+Z3Sh1+agsWr5UlYokAa74QPMZSENuvVFt+PAFbJPHtmGhYQPmM+cvdwVo++t1rQ
 CFpvE9aYnb/Tipn5KzLfwykLfva4Yk++WOrixdh/17yP7Bjy6vEaS2H40s+n61oN/tHo
 ZmF5EmjRIqGBU6bv89pe38KB8nF5EHFADND4DtmMenq4KM2ZI9cArjzkmZAKUCECUt7B
 pbH4B5CY95PT2nv3NZKgP4LsLfNMxpSeGQ9fJZCQ3tBfHXZdzxoQkwMRhmq5MQlHd9cW
 J+N/HxQvTCfJXcyzSb0CNXEL2gmQMYd2m1ymSRltGJyF7UY4+fNLsYKgDLCVAoOJaJ29
 O2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784659315; x=1785264115;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+n/NFf65uT2dq8qZ8BzjRHqxr6jmGdLSwt4tjEC+VzQ=;
 b=kj3zRrHD6Z0UJYvoXiz9F7myCk0fPy5I4o/LX57rweToanJS7XJGG3QCh3YH4YAscB
 yKME9XSYVNtkQXXWkxNuDq9zpdnNLZexKaYUMIG7uO/atF+ufdhcZJO2lT3w06bd8TmX
 5b5QsbTAiHWRIe8pdszkzSWzzRTh01F+Jql98/I1CAG7ek6j0OjvBbFld4B/cO9MiyH/
 FsGcUE1jZ3L/tMHG5Y6N3NebSUa6tDqq26k9ODjvBRPWhFZK1sRl7iXmR+u6WiN5q41X
 I2GFvMudrqGtw06MXA+uxtUu+IzEcMThC5ENLD+lHlFwLdFUgUqnROrhhs9RxMm/UBoO
 dXOg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp5LW2myGDicXZBXBU32A0+DCY+5nl24fUoLnXfFx7N1lA/6Fd46BCc+lZjgqSTRGy32cnddh/ZJI0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3GhCTd+8Kst9EYfvBGVPU1EFV+Kuq9Pjqant8ZadiOKPbIlUu
 Bkn2ImZ2lWudlDoRlxuSGEmqLVneCpHC/klI7A3f6tB8ddF5N5kDLLPBnZGZfR4PK1wv3jq2FN1
 2v0fd55A13nSZL0InkWXYw5SBAxBU4J8B+9uh3kOfwaVt8Ilp1XAjlXQ7Hp96Y7NcFLAqwUI=
X-Gm-Gg: AfdE7ck4ihbIk8oVYpk19kI45ZlVhrl5zSYrpXU9mjm978c/jb96XFXTbxzrYkxZish
 njepfs4ksmM21fItuAbXSNsH28Ar4w396Qchg+pIU5WktZBT+LqrWh7hyqYO2nbT3EhptkULza2
 ORJxH/UzWu6UvFDyooH5I05YWkrib4k2Quzc4EqFjj05T54MmMRqRsPpS8+P7FYgRAoaXMm6/sp
 RIb08ESUUzFnfoQo6gan9lOA1+UG6CRzU7mC4aqk/y/EGrqTJwa/obGPvwmdO+Eb5K4SdKoMAQL
 azllaWaRJHyZsgYKjQbMrTuZmlKUcI4JfHymfjOtE2jVeO1b5qtWcfjVDaf2FlXfQXzj5iM9NlS
 o9E4mHWyBQ7lPBGSCjEW3k8VkIExE6ZbHIUL9byagUfRQFIAvPXYORuPY16gu1iw49B0muV5KPu
 EYhZmAOFPqnyTy/Q==
X-Received: by 2002:ac8:7f53:0:b0:51c:2633:9ddd with SMTP id
 d75a77b69052e-5213e081cf4mr191503941cf.41.1784659315241; 
 Tue, 21 Jul 2026 11:41:55 -0700 (PDT)
X-Received: by 2002:ac8:7f53:0:b0:51c:2633:9ddd with SMTP id
 d75a77b69052e-5213e081cf4mr191502761cf.41.1784659313364; 
 Tue, 21 Jul 2026 11:41:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9d4356dsm65884e87.56.2026.07.21.11.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:41:51 -0700 (PDT)
Date: Tue, 21 Jul 2026 21:41:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: Fix DMA SSPP REC block offsets on DPU v13
Message-ID: <aqna6hzjorbpnnu5gcwsxkhhy4xstokoo5uzqwspr5saftyivf@2uxvuhwp2c2m>
References: <20260720-dpu-v13-dma-sspp-rec-fix-v1-1-10d69b4875e7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-dpu-v13-dma-sspp-rec-fix-v1-1-10d69b4875e7@oss.qualcomm.com>
X-Proofpoint-GUID: wSWEwvc34rMUZ5_TzEw63EymF_FSA3-a
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE5NiBTYWx0ZWRfX7iygrIUhzUKc
 HsldNmPhtByVEi3g76kN7sWqFXM7c8EDRGSMeVL8IoGzWmJgR7B4JfDiWwS2DsVizUjIdeJeCTe
 +ssiHVgxXW4w5fjS/T02tn7rUhmwXjw=
X-Authority-Analysis: v=2.4 cv=ZJjnX37b c=1 sm=1 tr=0 ts=6a5fbd74 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Po1t57-fbbXoP4SbIj8A:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: wSWEwvc34rMUZ5_TzEw63EymF_FSA3-a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE5NiBTYWx0ZWRfX9jSRnTxY6mrs
 Q8k69nyc9OMbAIcQtw4U9hknI8Xn53jTaYqT1ACaMm2fPqk6HzezJyLr3jJ/kw9PfhMcX2cCmg/
 PjoaBkV3JR1MpwIWt1wOBqtRyR4MlFqiZv0Vo2uyuj4GNQtC2sit2XgqDGRFtpOX38zeHeDqH/P
 t7H79dm//0QRPjDO2vPZAYr51dDa6yvHeBbzNU141YUV4ZFnZtM9bjEo23mGwBI3oBU/2Icrgh/
 AD0zFJHfu1couzmajU6bf3Btbo+IxY9/5M+S3h68rqfinDnrpfHxFR26W7V4Xj0lb5glcxtNieK
 oyVngf2HSMdrRZAnvUN9o332bbXJ/H3uwB/T4NQRS12BiEy/1GGJqt4K0kDm45dUIsHfUpQkcaq
 sTmCZEFn/JLlVk7IoE+LKJ9M6KhcKA0lcdZyVZ0Ewd2A+Sam3PvT7WtDtIpgHC9qPIrWxWi36RC
 6OrSp6rVdogWzseUFgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210196
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

On Mon, Jul 20, 2026 at 03:56:08PM +0800, Yongxing Mou wrote:
> On DPU v13, the DMA SSPP REC0 and REC1 blocks are located at
> offsets 0x1000 and 0x3000 from the SSPP common base.
> 
> The existing DMA SSPP sub-block descriptor does not initialize
> sspp_rec0_blk and sspp_rec1_blk, causing REC register accesses
> to be performed at offset 0 instead of the corresponding REC
> block. As a result, DMA SSPP pipes are not programmed correctly
> and fail to produce output.
> 
> Introduce a DPU v13 specific DMA SSPP descriptor with the correct
> REC block offsets and use it for all DMA SSPPs in the Kaanapali
> catalog.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h | 12 ++++++------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c             | 12 ++++++++++++
>  2 files changed, 18 insertions(+), 6 deletions(-)

Fixes: 83fe2cd56b1d ("drm/msm/dpu: Add support for Kaanapali DPU")

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
