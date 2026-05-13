Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DB9CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 17:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A149510EFE0;
	Wed, 13 May 2026 17:54:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oax177p8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PYRWBZpd";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCB3310EFAE
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:54:17 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DHo9I31393027
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=C04fNeLquaS7uemBA4+Am0E2
 khDbaAX+WsMNaX9Ovo8=; b=Oax177p8aI3km8LgiNOtkYjekiQ0Imsft1DerYtc
 jvtmBnrShmz7Nqzh6axl3hpXAgZxpyJBdlscrW7C8S8C22bKZYoE9ubyd/8mRFeQ
 lMVdLBKtUiLcrGcDJDEf18j0zGPgpTG0B+X/vMEv8epb/uJlcOCdX+oQtDr9xReP
 Z1IbFZODpZ6Lfk3aeaEROGwTglWx/gB4DEmgMteBfhQKrXDPuyyUb0TJxLVE3mhj
 eWjlze8sNV97zvqIGCwB5sZLKB2EjuzmKPZnpmxIgezOXo7I7c2Qmeh5N9B2ImHk
 0t6CuNQGNWf4w9c5ER0+puVu7hwxiVs3diiBTy9IE+PvBg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4k262xwg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:54:17 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8acadca1ac4so178922506d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 10:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778694856; x=1779299656;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C04fNeLquaS7uemBA4+Am0E2khDbaAX+WsMNaX9Ovo8=;
 b=PYRWBZpdnXIHqmgiBDjspfRKvrnSnsC+X5vj8kzJZ7E07/LvsL6/W+CTymTxn21KZM
 MLOzsx/k0JA/hdyFbcobFIVtl6c8sk0OGyabT0zvgtHnEd0bYQZr8o2dGR1Rt0Zd+Qn3
 iRFAmYOilE0W2FKWqdhiXa7GbCiz5WAK0/hNCSGaGcgozFytZ36oMsb26H431UAxup+I
 8SLoMbY102FJWMNwjby+po7NarOkpFDFJs0t4Ofbh+p8ovup+6XOoa1vNM69ibnJeFQQ
 VGRyBOsk5PdUCpkEnahR65+jVqkjZ16iN59BVRIz0lTVolrbsBpykl5rEWrIlFDusksB
 EG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778694856; x=1779299656;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C04fNeLquaS7uemBA4+Am0E2khDbaAX+WsMNaX9Ovo8=;
 b=h8IzJH7Ya81FJFSpD1ER/ecyvV4iPkMg1bqvNkK8f9jr4Ap7Kplygqbm/DTQVGf1Vb
 lbEthCnN1o01TmjfFd00bryAgeaxuEuHlh4dpe/HNtRpmeXtMcmBQ1ElGvKUOo86mqO/
 KS3eUQMZfaBkKf1DGxjT+b2V3i/0kY9tLtszxjRiD5Uf4Nvkw9EO2xD2Ce0Zf5PG2rGC
 GVIiEjO7nMAZSMH5J/SW0OAC4Y3yj5Sw2HZSfo+JI8XTtjXNvWV28WCYsLuXnuz2ThmI
 fVfx4N18fXANfdzhnw9TzJVO3NPpHVxcO2l1cYzPBkP/UujYWohI0jY8zd8cBqyPeCRc
 cH7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/i2EOXqoxS+09W8Lfrtfymd5YkF7Mk298QyKEQ4q/BuB0HqETejLM/d+qsBJyD6VkrCtL9Rb6Vsog=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwnJfbdgJOWCy9dS/hSDFuzOlOAJYg9DDfGloIWSXzfbleFh0f+
 fTwDt2udRbWZ34uTgmIKxwtj9YWo/+QT4nObULdaPFXctxAa4IlLmgVtkGmsjrkUFD9L5ni0xoN
 P628TLQKxaYLF9NGgsQKMmf1Dh1C1UR9vKI34jTAy2nuub+OHgbcr2YSdQKei9CARBPhAfXE=
X-Gm-Gg: Acq92OExxIcKvfqIGNQvi6djrVtzRVg+MgAV2Z5AcYjHsMgC0CM01unxBO7qPr/1Mbs
 AiDvg2mATJQ1YDx8pP9IkXjxTmwOqTJXLnHxA0wzEynbFWBvUTutBLl+ipLhZXKGj6HkoT0ByfS
 nJQnHXAnhOuLhiNbT4c2kT6WSMOW3/O8ytMzBroJ4zYBJyM/MXYXC2G/+oqK4j7CIhufhKS1/uc
 IRqnkoeAdvipE4fneAsbFSk4fnymwnbj8cYYT1uW6VtRGMJ8Yy35SlRZx0E5qinYFbpqwqR6c5G
 6L8NftQ/7xylPKvDzMHTJ/SufLe2pM/U6oLfglWJX4ry9hk0sYW6vtczGChwt+Rq4rX/jcGXSZT
 XvUAibE5hayMRUto5TIDlxNtxuYuHR71vMwMy7hcFUwzIKBoSsJsKrGdKC0gzs11ZW9/TD/rMDq
 qtfDgYQpvhdzO6NIn0bFW0oJk/hffDqm2iau4=
X-Received: by 2002:a05:622a:1a97:b0:510:138e:b83c with SMTP id
 d75a77b69052e-5162f58ae21mr59839871cf.33.1778694856248; 
 Wed, 13 May 2026 10:54:16 -0700 (PDT)
X-Received: by 2002:a05:622a:1a97:b0:510:138e:b83c with SMTP id
 d75a77b69052e-5162f58ae21mr59839211cf.33.1778694855776; 
 Wed, 13 May 2026 10:54:15 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3945c8de83bsm187021fa.15.2026.05.13.10.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 10:54:14 -0700 (PDT)
Date: Wed, 13 May 2026 20:54:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 8/8] arm64: dts: qcom: kaanapali-qrd: Enable GPU
Message-ID: <t5kgyoudahhrii4x3i5eufl5rqdzrcaid2n4yfx5kixm2xrzqo@3sfbgdenehnu>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-8-13e1c07c2050@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-kaana-gpu-dt-v1-8-13e1c07c2050@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=M/l97Sws c=1 sm=1 tr=0 ts=6a04bac9 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=zfO1FHEroGhDxMXjEocA:9 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3OSBTYWx0ZWRfX+Ca5YVs6GP8c
 t+D7GrDmYBorHS8PBJMk1KvVWB9rWdTGS9TaZw7s2ZWq5d2iYsnPOboWtR7L0jmIN79FIAhUNfK
 nMELHKQYR5U3pF5CWTA7p59po+XZkRcNHj2QA5DyEIyuaJPap6RaYXSGBm3CX3wIf/b8ZIxl2mz
 z6MUlfBSKOoIZMFlOUfPJQZq9CKLdIjJZ4EtQNfLEcwf9KDrRQe28S5V6xrKg/4fdwEpumWEGBB
 NkppkcPGDF6cbzFuBvVt/wHVTbdBcGflbDLYsBFU+denA0vueF9yKKBSQryIdCum+WSS01tO5El
 4BuT/hrvHoxr9kirHZdkZDNDidQQSL4+V8EbssKIoenRkGr0uCDQRp83fXSVOiu/2nMJZ5eZ3pp
 MoYlipdN3WNX7JpBsRsQXQW9TDriWYRuJnQL4HIyJks60aJ+ft1iIyK8KrwCnApeRWefYiAWO0h
 99jRcPxnnnuLIb8q10Q==
X-Proofpoint-ORIG-GUID: cQCxOjkPPLAGBwHyVNkniljTRcNXuuF_
X-Proofpoint-GUID: cQCxOjkPPLAGBwHyVNkniljTRcNXuuF_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130179
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

On Tue, May 12, 2026 at 03:53:22AM +0530, Akhil P Oommen wrote:
> Add the secure firmware name property and enable GPU support on
> Kaanapali QRD device.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali-qrd.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
