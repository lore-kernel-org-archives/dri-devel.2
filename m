Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974BFF53D8B
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05EB110E32A;
	Mon, 16 Mar 2026 18:51:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DcecoBgX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xz7ISPqd";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCAD010E32A
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 18:51:34 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GF2hWO1534052
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 18:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=GbJIE4awYR31+dxdu/q5rVaW
 rRC34cBDYrzjRpjAoQE=; b=DcecoBgXScz/g3YBunKdlIyNc/mTYUPZmnZM02gD
 mcDxzAtsQ8mZSahtgbpV8DeCmD+aVJPA8ooyaX8R+Gxv/S5L3c5vSMaYob4Dv0mf
 KTDawmaJ6MByns3Acyh5IFvr0bzP+2JWv9wAT+PWB3rOgGie5+0vYaKK/6dDSpfF
 b5zWAUJ/dHzxRQjCzhijW5VfU4LWIy8EyLTJUO/y1fuX5wR120F5D3jnzUra3EB1
 j6bhHQyW0q35jHqaJhNRxk79Q8rU/xQ6hx6vh7INz3rqo40Jp5muk7fOlCFRbalD
 kwlcOkbtPeuQdp+zqgnOnvwcVFIWdyhnN3Ax5ZUwhChS0g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxm5k0tu8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 18:51:33 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cd77bc8186so5140934185a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 11:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773687093; x=1774291893;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GbJIE4awYR31+dxdu/q5rVaWrRC34cBDYrzjRpjAoQE=;
 b=Xz7ISPqdAWTtgK2sHhxxRnIE3Y0fu8MR+MivLBiKnYX0hPhGfdF8DzvaGKGEOZXiY+
 0YAkgE6/fqzO9a60na41c64cfIAvCbSCrRUAHvpdHMuShkcP2mDDPIUv+1ts6A2zyXNX
 t5IvBygQnBufAXjFNH/UpEUailo4IfnlStUwiYHTL3RjCFperPd6aFT5fXVRai5QUQ2s
 po2alaJkb+kEEJv3va/rqCma0Oh0qr4Z8KsFeKYkadnU/Nvu/XwtoV2EFA3511AJ25LT
 67RqY4DEkJIAAHEXuPS2YfGrrtzxnaKQvlmu7TTG2i/kjd/4B4gwAIrw4iuyaxGpvY4n
 Nuhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773687093; x=1774291893;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GbJIE4awYR31+dxdu/q5rVaWrRC34cBDYrzjRpjAoQE=;
 b=VWxA1gUJi1mT6bH8f4ExAv0nM2vXamcGv51iZCz+2gf7+qnQK2/05f04kbcVsWcTP/
 k9H+R7D2KUwbNjxujI3pJz41M8yhIWTeM+mxmA/pcQT0ffMHbwTBQttUg8BwhFsIIeIq
 ZU8A8cxawkjADrYz9bKpPVCPcav4q5nVNg5AMussTWTYfRyXzzQURIKrvhXU462DySXD
 BYtcTgVc4p8UX8bkaEdzvvzcMZCWtljBiqzz6LNbChkyaCwSu/DBlkCXGmZH+RwaRB5V
 JUWeqFnINEHEfIpdk2hkgPm3zU6ym5BaMxHN/5J460aHCSSHiso3IqtR7nc4+ReY0F1t
 9eQg==
X-Gm-Message-State: AOJu0YzWx2i1AK6ODLUeF4HrkE/Z4nZAxt/d2iPhZxuCbDt1zLQtS3oC
 X9Ohth+84j3cSxmItj1bq/qWjRO0zOz4ZZ/UqS+HyYFF/cAii3V/LBJ+yJKnvM2YjsxkC5t9hH0
 3rGDn/LaryWFQIRgmQSZt75rQZlOOXalc2iPGPhiGcU82gfUuo2eR4GNlHQXnevu0yJ83+jI=
X-Gm-Gg: ATEYQzwAedkXM/78G1v8csOiq0e+8Wv4qOuqrRH+E1hCuuM/tNxv3XVhg8REIcSoUYa
 bUshSKK+ETK0VZdmrwd7FtOr9rD4swkz4CRViRdnvnu/ZQ6zrB3OViQKmzUa8L7yOXbpgj41wGF
 QbEztRSsjqY9jOCIj8herXXC5EyK1bS0REiqj107FVlnCZvb+RFP1TCX+8zPEvcCrDYtPMjbCPq
 xJ864As36AOzlZeDsNO+1K9+wLNvIUsvseNG6ZAhStKCXj/m+Y53oR64BreFOx57sjuCGhdzURu
 LK3Yjm4qVosB8gXVZuCyebbQLpSvAIk0y/vQMMS4mlvXgAfw5zYqPiqZttbZwkF4QK58VXT4nkH
 gWdZN/CtCRSLMIAHX1Qljm5p5VRD8sq5BPQIdR65AZoz0PRX6UMwG7LhsnVwqTJoetKv9ZsXH/O
 tFY0+XMvlxsy0rlNH57sHjePvuwXhyg/TVqLU=
X-Received: by 2002:a05:620a:414a:b0:8ca:105a:298f with SMTP id
 af79cd13be357-8cdb5bb11ccmr1773430085a.68.1773687093247; 
 Mon, 16 Mar 2026 11:51:33 -0700 (PDT)
X-Received: by 2002:a05:620a:414a:b0:8ca:105a:298f with SMTP id
 af79cd13be357-8cdb5bb11ccmr1773426685a.68.1773687092847; 
 Mon, 16 Mar 2026 11:51:32 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38a67d61f1asm32736651fa.2.2026.03.16.11.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:51:31 -0700 (PDT)
Date: Mon, 16 Mar 2026 20:51:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/msm/a8xx: Update GPU name with slice_mask
Message-ID: <y4r7pispd2f2tqtenydyxrom4qm3l274vduvsxx2twngkfxk54@n276gxfb4sm5>
References: <20260316183436.671482-1-robin.clark@oss.qualcomm.com>
 <20260316183436.671482-3-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316183436.671482-3-robin.clark@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=fJ00HJae c=1 sm=1 tr=0 ts=69b85135 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=-2mmMjQWwNZ6YRhNbUMA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE1MCBTYWx0ZWRfX0lqZjF/VI8T8
 33RN1jMceeRpxUvvyUoRAMpzjAU8N3uBacSkjxyWLL8y1WvQOJUd/C8FyYQiwLidtEcHFLWyHVj
 wzgbSVktuF4xQR8WWZ0FfJIaJPepBBHYyFNnfQvm/Ih6dKOx3hagfjov8QBhDJih4rfpWO23NCt
 A0Sh4llDWe15pTimYcXsfPnluj+wwZdivhedcCHnNo1vWXT3YOlyLqSaO+aEWUIX+U9bncf+ezr
 12K0vzf24iSavBjBsYiROnMJnylw9shuiExL2Cc8PpPUMMBXUMG0a+w0FCpTKTm6wBUg/fibbDW
 84/KSeLRCPdO7EuV2dw/wvI695aY8VaoIL+yEAfykhfp0SLn3x+ikGwmcsnMSE6Af6UiNbiWY/N
 mMY537QFYStvp/HYq2egZxshPsCoFNumjcj5/M1FF0FaOA65j7YjXj7lGVBiHxHpFSO8UI1CLAI
 084KCZZRWNcsi0uItlQ==
X-Proofpoint-GUID: -pgc5jq2Mx6TT7USe_K5_kyj7Al4WKDQ
X-Proofpoint-ORIG-GUID: -pgc5jq2Mx6TT7USe_K5_kyj7Al4WKDQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160150
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

On Mon, Mar 16, 2026 at 11:34:34AM -0700, Rob Clark wrote:
> Once we've updated the chip_id after reading the slice_mask, also update
> the GPU name so it matches.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 

-- 
With best wishes
Dmitry
