Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDB3108E1F7
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9DE410E9AF;
	Thu, 19 Mar 2026 12:05:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="m3FLHizY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aY0YeHDL";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEEBC10E9AD
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 12:05:39 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J73x2i1027104
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 12:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BxWauT55b+x7R7xDqRZOaWA/qamDOJrR/au8q+rJFaI=; b=m3FLHizYj0fDULGo
 m6MMv0llzB3xhr9NUKexQrYut85F7DNPSoHVTx+OjDPEOgdv2t+nX7QufSce6kQP
 HPeYORgWNtppvliCTJTzl8L+WI1xqxCLBDi2Puc6eD6e4lhOZCeHWdNyVtxFSluF
 vzrOQpx/ilnrUY/9aCWs3doezVMYY9wc4f1R70nSYacsMmLhpKXogGP2uB7zf8xe
 qAc7YXW1ZPiIRk5poAelRaW4fcms7Jl8NpnErHluhAk84zWZlr23vR/+jmWfBMnB
 MI/Rg2+LN8ckOvpv/t9jTEEg5U/MM0p8Ys3BRPuWc86aTOfUyFzWAHFTRG4/csva
 aRP+/g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0032k6br-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 12:05:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cb38346fdbso74048585a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 05:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773921938; x=1774526738;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BxWauT55b+x7R7xDqRZOaWA/qamDOJrR/au8q+rJFaI=;
 b=aY0YeHDLBMnz9Jl7SZARwONoKYOaGeMxSKWgtcBK5AbCvrSFsFOJ+DYpfjeTpef2sz
 lPiMQKaKGT6ni15oVaXGNtZeClQX1OsPko1iSia14ZCWl+dYqfDeOaXZ91DiRuWJsyqo
 kyw8Vmm+9+vapy/1HW7vwuPwILZG5R2rZGgQiMbsMdUWIZE7ycly7tdPs8SyVE1Iu25X
 9mgyw2kGCfkuP8qgRg2z34welgzi3dfM1s2pCpcnkidGnNf8J0FP/gb7QEcCQRaLjiVe
 /rMP3pBrLNhxVDpGJBrxRR7sVWxiF0V2KEVuvGdZ3HR45IDL99nvJzpMJZHARXniIQNE
 GY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773921938; x=1774526738;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BxWauT55b+x7R7xDqRZOaWA/qamDOJrR/au8q+rJFaI=;
 b=D7Al4Dl1cVJqpBu3ySdPVhQyy6Nof2SUTpidhibR/7BYcZL9N4teTgydInmfGhE+E8
 fj3XK67wjUvCQgoctsZteXzTQHjAQREwZloUlzr4XuQ0KnyAA+f0KWcSDwkNhdkasloQ
 KGWfcOoRXl5sO25wJ3pAEmdgAyZmHk+6bgqlRRRgTekCKhXBf94BsmGI6ImbcFYi4vrr
 CpfS0S56NaIUPCg9nfBJbTke+XTeoLyZ1YQrDeAa88zrpSrjUTWgnGN+395hQHgNa2l2
 lnOVQ1hcbP869f4IQuLqK7FKvJSQ362D/Xb3RkE7WJc/8MEYdqTy1nZkwAJPzUiY0H/1
 NH5A==
X-Gm-Message-State: AOJu0YywPlQu183Cv1tRBPlEwbc0lRBvrgmBqA9tWAz7CXhD0Xto9waC
 97HNSMmYuMha0yUaFhKjesKfNrDnfz6krc644O2e+da1b3TsGVks9fWjxGEeFuZYH9/0krTEQ6g
 ww9tx1n3IQvABWPUkzJ53L1uKVjYnS1saqmzSgeYMcdkt8hjFoJmjl1NjMgUIOHRd4esDoKM=
X-Gm-Gg: ATEYQzx8Xxwv15QqvTnGZWa81AGoqj7qsFxYkMn9EoK656iAs47Z5pXVpC5B/SYQSW8
 ssUkBiN2KWwaETI6WOqeXIhz0XRTWwaibhvzxtGvQjLU8aAbQi64CwtnQfImT2yyZv7Pyj0+XZR
 ZHmvlfhVAeL9bzPJ8nXcF9yT16GhSZPFKtL1fryL0Lgdml3jTYBUy73ox3DPLdwERwlEhuy/PhP
 +LRmlCNmJX2ZLWUKF7B+YVutpAG6aDcpkn/yG6Uw52B9BbTDA3JOW+t1gV45qa7r7VUcpobUvoA
 wBIR/0ZIPT9nP17+yxiNm4MI80CDcmLuFtDSnOgoIe6Hwy5UirIx1krEQ9g8cFxj4tfRx+ZfzzY
 3msJpzv+m+hMcnSReBRCwAbNxieiApFpctWDWvFPfnhyCNiQ3prtScrp+ljmMcjFmLyRBNset0F
 Mo0ME=
X-Received: by 2002:a05:620a:171f:b0:8cd:b2cd:ed4 with SMTP id
 af79cd13be357-8cfad27373fmr685237685a.3.1773921938290; 
 Thu, 19 Mar 2026 05:05:38 -0700 (PDT)
X-Received: by 2002:a05:620a:171f:b0:8cd:b2cd:ed4 with SMTP id
 af79cd13be357-8cfad27373fmr685231585a.3.1773921937682; 
 Thu, 19 Mar 2026 05:05:37 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-667aecbcc9fsm3724012a12.6.2026.03.19.05.05.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 05:05:36 -0700 (PDT)
Message-ID: <c9ea2f9c-8f50-448b-ab9c-cf4500722189@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 13:05:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] drm/msm/dsi: rename MSM8998 DSI version from
 V2_2_0 to V2_0_0
To: Alexander Koskovich <akoskovich@pm.me>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
 <20260319-dsi-rgb101010-support-v3-1-85b99df2d090@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260319-dsi-rgb101010-support-v3-1-85b99df2d090@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: aigNSAjT8EWY4FN_ZILB_cXaKaqhfU_l
X-Proofpoint-GUID: aigNSAjT8EWY4FN_ZILB_cXaKaqhfU_l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA5NyBTYWx0ZWRfX4/fd0GDCFf55
 wIYlCWtdf3h2PYQO7DfdBNxHA/jpyY3h/h1qg+AljgIWS3gZ5d6Z5epCPgBUCEpDHTRoxjA30t+
 a5X9cE1CaSjnko/sRZMZ0mltR0i+NJn15in93Lb/1a9kwPZYcOkmsf/76I8dxRAn/Yh3sGwE1y/
 XCUUG1OkY60lCm6LywIVUR17tcWpiPBjxCz9jhQWqCEFn5zun8eIyXpS34fdtldlmKNY/A9C13j
 KtqeWE9Y1AarCIHt3nFYgRc/pj2K1BDMkszp0Bw7hVmDjTDcpGI3uUVW+VpZLBkivvKZbgtG6Gx
 GXmr3ObstkV/dsWiSeO5Dsly2CqheGZANgpaHBKsUkoF1b2sbG4KmmXH8N1R/vLFdD/i41fi9a4
 tWRdattfw9piepwBQqS+D4WXjkJfbmde7botcaXf0xtjtm3svYjd1nuKF9FKd11x8zwzEXFZpqN
 jeaCKMS01z/zck7XyKA==
X-Authority-Analysis: v=2.4 cv=WO9yn3sR c=1 sm=1 tr=0 ts=69bbe693 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=LOFc8Sdq0yBhcMBbFKQA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190097
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

On 3/19/26 12:57 PM, Alexander Koskovich wrote:
> The MSM8998 DSI controller is v2.0.0 as stated in commit 7b8c9e203039
> ("drm/msm/dsi: Add support for MSM8998 DSI controller"). The value was
> always correct just the name was wrong.
> 
> Rename and reorder to maintain version sorting.
> 
> Fixes: 7b8c9e203039 ("drm/msm/dsi: Add support for MSM8998 DSI controller")
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
