Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07105606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 21:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tqy0g2u8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hG7A0Ht+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 650AD10E362;
	Sat, 31 Oct 2026 21:45:11 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E736910E362
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 21:44:59 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69VJF1Nc2969317
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 21:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=yDGBpE8wO71JGfIhhYSREmTT
 DT8BIMcwQoGjF/pa28s=; b=Tqy0g2u8Y/mHPZEmpqKvoI9nEA0bTFPbKTpRDOpo
 cSXiT5tsequCmwJxCOE7xbvLLdGx+iOEyL7B3jURpVBQvAt4BcUO/q6aox/lAPfi
 RNHnN6R9yDreV4fzjOUy7nqhJxaw3fach0IFzS1ZUGsrev8SyuMPQmemBcX3PidB
 d4jvX93H4Y7+c0zbWrekez2g5VQ7Zq4jil++c1Lwpxj1AAWISfjkcrKOh09+7AmE
 8xyZ9eAv4LoqeLFIZNJSKkeuupgYAaxOmb73llTamWZC1pT0jdZ/fhP8Vwt8r3fU
 NvV/WdmnR4hp6ibPfIBTiGMbxBUIit2ZwrcTiRSLAs7Qaw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn5pkjgya-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 21:44:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f1e62510cso420672785a.1
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 14:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793483098; x=1794087898;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yDGBpE8wO71JGfIhhYSREmTTDT8BIMcwQoGjF/pa28s=;
 b=hG7A0Ht+immNE5iOzqBB8MHq7dJ9L5zFk5dFlU1Q/HUdlG1+jkfTr/KS+Tf6X5evga
 9z9YfGOwu+zKZQt4RKue1XoeZH2rqzeH1NGiiGZ3XfFQoyScY5YFS792Ye+U+0CFPg4s
 Cw69IV3PJ5CbW5d3/VWV7f0jpShvReIrLizn9vAmtclAvFM5VSupKp3d0Stx4hJBsOYJ
 hbOhNiR3xWE0ENf39mi5VJhUh2jRsgOmGD9UDLjpBGdHSBW1knhrguKbBcyH5SuvPtFK
 /QzfpO8xgKtXlbyDFdc5nN+YaHKjvjzuM/dCVIRahiV5mY6qmRcZF6GIWMs8l1c+0UtA
 gItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793483098; x=1794087898;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yDGBpE8wO71JGfIhhYSREmTTDT8BIMcwQoGjF/pa28s=;
 b=VZShrQ77lZdgNugKevT0tLWhULn2/1r6bXdBLoJpHBHrT1jvynZ1hiD6ilbML7GNDD
 586ZkLwmj+s9rT81vXjr+IX94FdRbxDrBeNpRAOZbWzltwejb9IdUWzkkM8ya260BpZx
 2IuIP72PP2HrWbo9r/ge5w92Y10et5HfU5O7KE60TcqFUpxEVmbt4uRmJK7UwJZomcHG
 2X5jZskUSgGCmTsXDe6qzxgXd0JIdY//5MI3d961iM0I4EBn8P57pZx3wy451nIVwcmS
 u5H+IkiUd6HUbbEzk96kk39oiFJFS/p0UUrvwLuaZXEJwyN9cJtrrBqxDQADb8mRXyV1
 HqGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0Sw/QlA53EQxJHf0QKCXu7lFZrYrAOg9O/Dfiw7k5R/ZRjTDnYrbKQG5uI2SKhIgCFp/7aGpwaQo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYImNebx0AVYX9sowZSinrlFnOVUVeugYgJNi6jp/8QkR9EFB2Mp
 NSLXcQUJ7ffbM92VIo46LW5utLG428uu+lXbeUzrKs1xIM1CqG9T/PM6RRo/iGZklowoMKOwv49
 RWPJoXA1Qd+hQT4JxfRlr5mzvEVuvX2nsYw1bw1ad9Ptk97txur6p+W8DgNpogWriXiNyCaE=
X-Gm-Gg: AYBFou1A+sKRJNle+H1FUP4wrFpc/djhZ58aUoDb8fJXadgEmSi4MjFo9G5poyKOy49
 1ic4aB29dL4GTDnPo0mlvAWAAJ1cz5tibG/qel/ckB4BpXqKh8lkJ0I17FYBaomzGwxgU6PxFF/
 Gz00gc31mqb58FA8U21OL7m+ugM0u2x9nq6bosrI/pj08QEkJQydeP0w8eSvyBuyp5RfvSreQ/O
 bQLyJE1E8yyk0+4lfxh4sFVr3z+aEAuxdbCBqudLAv7kRVC5HdAjOtHGcPDR4VEhqJxJS6ryURx
 vW9fBbAq7mLu4w5+wkxPzmB0tc8Am5tvnG4zmAvn1uhF4NFQXJTe1sdS/nkQ1VbF486iOjmQ+2l
 oGrk5mUW6w1h0lGJti3+sCVxPXA15G16j7gZLnoMjbnLYOiuxYu8/43Fen+0jHAIZIgR38Dc6vH
 AI/bL0GTJglZlzvye60BRsiyqiwLV+Gq0c8SkdsP7vWc7LoYGzGxvaSWP/QgHD0g==
X-Received: by 2002:a05:620a:1a20:b0:93f:57a3:ed4e with SMTP id
 af79cd13be357-9442175a8demr1040525885a.40.1793483098204; 
 Sat, 31 Oct 2026 14:44:58 -0700 (PDT)
X-Received: by 2002:a05:620a:1a20:b0:93f:57a3:ed4e with SMTP id
 af79cd13be357-9442175a8demr1040523285a.40.1793483097768; 
 Sat, 31 Oct 2026 14:44:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe04edd72sm757409e87.1.2026.10.31.14.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 14:44:55 -0700 (PDT)
Date: Sat, 31 Oct 2026 23:44:53 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ishu Brar <patches@brar.si>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] drm/msm: mdss: Add SM7250 support
Message-ID: <qshcmax4t526oqoj2udcub6oqtgnkol7fptswvxuftlizy2g2y@2zqtdemmz6a3>
References: <20261031-dpu-sm7250-v1-0-159f403ec405@brar.si>
 <20261031-dpu-sm7250-v1-5-159f403ec405@brar.si>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031-dpu-sm7250-v1-5-159f403ec405@brar.si>
X-Proofpoint-GUID: PzTi1w6AXFXVgJVE0joVWeE3jEbIcqOo
X-Authority-Analysis: v=2.4 cv=Z4F5j3RA c=1 sm=1 tr=0 ts=6ae6615a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=r0WxMInjeZJlmvLLs6sA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA4NiBTYWx0ZWRfX+I5yVY1R0OZa
 OTcH6THbY1mf1gRLHGGjRdP5ldBrcUovgntVNSbFpwZFAXegLqtGGGHoV73QhCw33MG8ukf3Sal
 BtdYNrBvgVMM419+5zY46aTyyFQD+cs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA4NiBTYWx0ZWRfX3uSCHIgBIJgt
 goz77rSaJY8FP06k+5e9YYpt91AZwtCZJk2n0US3MSGsNU6yV2AqbrkHsMiV5LjoVqHwAWWc1gB
 MkReAUqJc402CWJcAtx/LwC+C8qqKpUhrtV3VVi7F0b4LJiqTQuXDNm1JAV1jr8DSI1Jk+SQfP8
 pT7Wg5zfSej57rQYvc6RteKNw9Cv3BQ2ZhpJEEQW9c9+2+sO8spqC640E+1lDDzNxLstIu8BoZx
 T37ArKntna4cDQEmtFwiG9svce0X0OopdOYK5CtMO2f16R5ca8rZm2Kie0fWtHmTEPF0md2dIwM
 q4zRy1isADuk2uLR/7ibHmPmPu3kTGzxBCEy47/R7NobAYmxMe2ycjPnvhtG8UMADU+26ocoiiz
 DOcAzqs1FK/rhJGw+rLCZLkVkShJqZLKmY/EPEwG2riwhtuJ+xTK2VJWatDCMZbSg/PLSyM9IvP
 uQTkPNjtZ3Tk5c9ZGtw==
X-Proofpoint-ORIG-GUID: PzTi1w6AXFXVgJVE0joVWeE3jEbIcqOo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310086
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 31, 2026 at 01:23:41PM +0530, Ishu Brar wrote:
> Add support for MDSS on SM7250.
> 
> Signed-off-by: Ishu Brar <patches@brar.si>
> ---
>  drivers/gpu/drm/msm/msm_mdss.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
