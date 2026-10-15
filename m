Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658C2CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CA9610E1E8;
	Thu, 15 Oct 2026 11:02:03 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 247AC112298
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 11:01:52 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9jibf2417235
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 11:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 27RadkhSngOPN3cixnSOE+ldf4UCtEE46PlRVZAmFzY=; b=inF0ZugABga5RGmA
 b4Qmke4FwoUfC+XVIxjurdcCzGSwf7QhxL/3X/Ioly/djFzk0nhIQHb4Vul+Bzr9
 oKIyB85mItCzTHLhoc51NT2JpOe6U4FnVWnscSY11P3JrVqryr6SUd1TPFmCV3LI
 NAywbpMr2Y9Yi/pkxRtj09QDipYT9qmeuxdLItPklwLAGEkZhBHddg3OSxsUE1Cc
 A5gIOd9mVNx33EY0dBBx49uzOsg5Jj9Upbtm5U/Mpr5NwZZnoEreL3sTXEsO+eZ8
 OC0B9fMOnSPZN+WxRmddZxYMglydLK3pBW6PcKQTja9aQCNZOnyxP3E1/mzzTr6y
 8GPRVQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdhhr4r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 11:01:51 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5d44237e2faso265362e0c.3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 04:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792062110; x=1792666910;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=27RadkhSngOPN3cixnSOE+ldf4UCtEE46PlRVZAmFzY=;
 b=MQTff+UvWTmsve7f82KVIxc07IAiGnTFP63Az857fJ1vPbZWgJN3yw4rpiNCVk+NLw
 S8mfm2Q+yNz+c3cIBSlMj2GWsmKOKlbCmsiB2GBgnohilHkR6Qfef2ii20j3g2LM7Y0e
 CAitRvNiG+N4IBDPTaL+/7DjgEITgoONyrp020g6AJfogODnmMeTzZnUbUhcvd5S3CZf
 yulpASeumq/lTx4vF2DnN63eGRS44N1lIyDQeNWin0/HeZGCD/sF4VZ3Qko4AznuQf0f
 hv9YdoDuqeCMX+Adg5bhVY98akjGccovUtVOITwycGZGY/kmRU4n+nkj/ZOdkQ44AJUy
 KvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792062110; x=1792666910;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=27RadkhSngOPN3cixnSOE+ldf4UCtEE46PlRVZAmFzY=;
 b=B2dx5IE/B3y4un6KOJV1Tiyk+KGExFbQ+9vdNN2evcM1uCUmSzsrsN/mRbcRm+5CX1
 VZpFBOSFd5PTO/FnnQHzSLJsLM/tr3Wxfmk+gGLv8XWFDmXRSqrgXXWVnR89+MvMBCTa
 MKVzy0pywaIU/2cCRKO5B1iSDkl2r0Dqmn/NUROpsXOCkyPtdzi14y0QqjaaIp4ujl2+
 R/n+CQLxPgdIK+0fDrz1ndRmErZDxbCN9CJm3Csn1WHnqQnJnANe6LLeYQyzwv6dYvDE
 fB2NCUzXHWg2qC0QWttiOzds+/768EYqmKiaaNoZrj1VCp/KCXwn1BrV3hpr8fodrLkl
 +iIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwd/zSpmp4R0MJrXMRdECv9PR8+zX05ndi6Jl4fREf/cM6kMbiCNXcRqXoZ2E1BW/eAB64fxnb8LIU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLNgb2K3bysqLBwMPY0ujrH4cEOHc6yCgiAkXBKJB3Ggw0IRo8i
 Ii+9DL86X0dtoD8lTjoOFQAgG59CZQEBKAyW94Pa63naE2qo/67WG3qaqo16pgptwmeDZYFRilD
 hOrPeN0z5aJE5uC4Y4AyRSyyZM8JY3hWlDOHhjkpoBgGlyLCyrB1OT1HBb/ot58nh2dk+BPA=
X-Gm-Gg: AYBFou2RZbYEiTFicPuGs+Sae/ywpN6WLn2uE/YmyRqKLCHpbMVfNWIdGMV/Ww1+N/w
 h5OtULUnHtftsFFrheJ1oOEDWIrJUsrULnovcRXFw4ERRuVGdlBwB+yS7PJeJieCTDOuNZHxBFn
 dQv6K7t6iMBxRDX2kOhzJhQMwIzSN6qolbiuHYopWJnI6IUayE83TusXDs9r0M6kEga20FhHynv
 c+KrqlICmR/cNaZhGKejekq7VNmS7Oz/aXmABQ6OyqHf9GrHgzy22DFY2gtgZpG2qNi1jpmeekC
 c4nl8N3BGRO/6dDQUj9+MOuuiweY9EM9gaHLL5ajEPyZNloc93RDy+mth8Zjgz5UFBG4MvK3uc5
 ZN+lY1fSodhrxjqkDJVwFBg==
X-Received: by 2002:a05:6122:6857:10b0:5e9:6763:368a with SMTP id
 71dfb90a1353d-5e9676339a6mr1758684e0c.2.1792062110391; 
 Thu, 15 Oct 2026 04:01:50 -0700 (PDT)
X-Received: by 2002:a05:6122:6857:10b0:5e9:6763:368a with SMTP id
 71dfb90a1353d-5e9676339a6mr1758621e0c.2.1792062109804; 
 Thu, 15 Oct 2026 04:01:49 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c3f8557c767sm45945766b.50.2026.10.15.04.01.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 04:01:48 -0700 (PDT)
Message-ID: <b422b3c2-ea11-4ee2-b3ac-9e58f486ccd4@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 13:01:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] arm64: dts: qcom: sm6350-lena: Enable PMK8350
To: erebion <erebion@erebion.eu>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20260926-pdx213-upstream-3-v2-0-b4612e3eb536@erebion.eu>
 <20260926-pdx213-upstream-3-v2-8-b4612e3eb536@erebion.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260926-pdx213-upstream-3-v2-8-b4612e3eb536@erebion.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0MyBTYWx0ZWRfX0a+RKLHiAXe7
 KCVyz+Tiki/rPj+ZGXQ4PgaCPkWk6PWBCzGCunAoSeU4/dgp4LwTysGPRBqq+VzsfreCMx93cmn
 1KCljUAQpa6SUMf2Q03KFl2/0wVUxhKcf1d+6z8jCr3WcHG2GB3ouqsailL9sg9TW0m/KJtGHV6
 85P1ERBF8fSddLyoNNwmGZVH6eZCqeuPJ0DooLIu6a4u1QoN+xKFwrKHOOFYlMoYSYCOgy/hyqu
 rpd1VQ4w1wmFm7FEbdFd/cujtmRiOKdgAvdlGc/RIne5oyPdkL+qHnQSWnR7DKUCgRhWSgOihvl
 pjQEClprbc+f7MfIl8SkWbpUtchJ1HUT0TpJufhdugV6NhrHBaOKbJQ64a90h3U7KJTRQIpZZlW
 ukmGUHq7gvddJfTsjbQKdxMgMf4zxQs7cver4QQOwRipdaOHD4T2g0+rUE5no9wP2xSPx5f5Uys
 NSr8RVef60UWe0YqVAA==
X-Proofpoint-GUID: XANa8HmnLtMpCpyf2iZTXxElDfBUzwmU
X-Authority-Analysis: v=2.4 cv=DeeCOftW c=1 sm=1 tr=0 ts=6ad0b29f cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=JgZe5hknAAAA:8 a=EUspDBNiAAAA:8 a=JHwpSSwbIGnF5Ym6y0QA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22 a=ODtDA1adfiiB3BH7YLNA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0MyBTYWx0ZWRfX9M9aUTFMz/KP
 K0HgwQ9Hxp3L0qI8DqfQr255cfLhR5Jn0gE0kOFzV4bm4F/CKjysTEw6l5SMKMj85vpnWuK9GP6
 4WeYKcSZjZ8T8GV8JYIRqFCw+/vbFio=
X-Proofpoint-ORIG-GUID: XANa8HmnLtMpCpyf2iZTXxElDfBUzwmU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150043
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

On 9/26/26 4:00 PM, erebion wrote:
> Configure and enable nodes for PMK8350 on the Xperia 10 III.
> 
> Signed-off-by: erebion <erebion@erebion.eu>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
