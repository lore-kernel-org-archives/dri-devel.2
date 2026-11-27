Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03134606B18B
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=frmY5Q5/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QwR/TemZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F5E8112B23;
	Fri, 27 Nov 2026 14:29:51 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F356B112B22
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 14:29:39 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARE1IBe2471785
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 14:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yiGZwT/Bg5TvVGfD5LTWL0XbZSBeVdRVsOxaeXrrotQ=; b=frmY5Q5/Hv73oFzh
 4JN3ioKtzpQFVghVg2v9548Rcgh+YvrUYwJPhSeOH6hrBGW3u3r3O1NvynCbSvVu
 MWom51hfpgCUctmURY/zzxET8ztHqI4/G+oJfqY9+Rmz4pL8eOs4Rx0iZNpkmRx0
 gyhvtgCj9bdze/nNIhlefKqE/+26DkKQztAfxN9sgXR1W3HU/5zQt9VyqExmFKGJ
 C3KPjOCODnhbQMe95X8VIksts5T5JupcjITJgkpMXIVG5b0sSTDNf0S8bclKPZAi
 ltnXVO471hDorpL32gJ0uavZtzJWjFTiahz4gi7tC1pMp2MXotbgJaFyRhRKEduf
 aOuY+g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74gasugr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 14:29:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93edac5877bso111400885a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 06:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795789778; x=1796394578;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yiGZwT/Bg5TvVGfD5LTWL0XbZSBeVdRVsOxaeXrrotQ=;
 b=QwR/TemZ70PcUS9HTWhkHw82kPSdArlfX+tdT94aHfXOtCajFtA4Ush+tmUKAopp5x
 Do9uWtRzu84E2KdnL0tIJH1tNl+nW9xEmOYNKB+IsI698HhseTQVBhVFRXNGMSs/doUY
 ZQ3TeeSlbJBJuc29Omf0V0zAeup+RjAeITs0K/W2ndMEThNi1FWXBAoPHMhPG33c8I9M
 /FzunK4/xmrtcneHrL/ucMV24bCDHwCLiLmfYvB/bgmQNGPP7Jr3E41ntebg/YncV6cJ
 exGBeCjKs7QhvVktkJ3xXPxSOdFoZlyRuN7/c9DvjB2T6QE4hP1x76M1LGD6xREp6GD9
 jOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795789778; x=1796394578;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yiGZwT/Bg5TvVGfD5LTWL0XbZSBeVdRVsOxaeXrrotQ=;
 b=t6WR2s70g4Q6n/+VaVnQiHDO2+JLqz0Rk4KwiaD86y4DXY/Z3rkqZpu+oVsA1uTvPw
 Uoa0bWOGv3Cix2nlRZaRfeG5FdwbHkRV2qPxbE7KTqVLFzJNVPgMWqR5fOSbQ8XMN2xu
 Jf0EEnOolkeW0B7FjNv0HnQKcj3ytVoedh35X4z8Z5VJs7rMBAIBEZ8ZM8q2RG6OKcdJ
 ZzSF2ouS+1xa11BqfsK/WrC6/whnYLPYU3U3n/MWASifZpJ0xNkDgHwmIjK+KrXc+yA4
 c5kPueQPF3lYqDlSj+wogWUnZRw/IaWN6HW73Zr2zhEvUNtY4HzU34oWJvc8t4xzAMSF
 IQDA==
X-Forwarded-Encrypted: i=1;
 AL+hErGO/hQKqMAQoZGlfD6QiJfI7lCpSNYcrmXtyJpEaXguOPKllsWQ7NzGSCsmtUOAf0182AL10D+0C94=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+9/V0crBwgRguyDhRkyBa4/43NS9G/QM8s6o9cwVz3WCRTeYIS
 X9HZBIOwk1c0DJsIiOuEmh9NPUDzGqeo1ks4+I8mX8D955FSViKz4acTeiwAFYm19WNoLyT6jgK
 PiiBfgY3WjNZUbgDY1XUUo0RmB81DmZiFREiic8P0zGywO+8zxSG/GM4upVD+Xstwy0oOvP4=
X-Gm-Gg: AZFdTZcx/ob6CikXN1T/0Z8IHbA6zjRYYnrlY3+O99yLsTnUL9c4kWRmsqp79qrMh1W
 cLLKf/JHnCv4U+PEXf84EmWAWHdRl0NhDCs/SLozrBHSx72cRy0/SQlyuipD63kCXFMopYZ+jla
 6m6wfLIMmcy9se+GYfg5xt+i8/fMit9JxvVb0DudUs6vZzr/mDFXUbHYRtvLUngCj0Oem4tB6MI
 Y0REPxm6w3znrSltWxjKZjDO4mfYB2DBb9QfCcr7yVWNO4o3wzfUqogCMfQOgxLSPlZ4AosMABk
 iRRtuwa7gh+5wtqTAlNM2Y8ASajCVD1SCs4jp3iXBcOOx0aV9YTaHsJQW5YpcQKfzEnFYoov2GO
 26d7EDqw0bShuUaSpOP61DP/CXgU9v0bxCQjp44JhbYgfRZbaZAehwIKPaKnmsfTntgL/I0I=
X-Received: by 2002:a05:620a:5408:20b0:949:ae35:480 with SMTP id
 af79cd13be357-949bab50fdbmr4319167685a.6.1795789778329; 
 Fri, 27 Nov 2026 06:29:38 -0800 (PST)
X-Received: by 2002:a05:620a:5408:20b0:949:ae35:480 with SMTP id
 af79cd13be357-949bab50fdbmr4319162185a.6.1795789777741; 
 Fri, 27 Nov 2026 06:29:37 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ad01afbsm876223566b.5.2026.11.27.06.29.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 06:29:37 -0800 (PST)
Message-ID: <8f1d775f-2418-4763-83bc-2963bac8f5ea@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:29:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/adreno: Improve AHB error messages
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261111171417.249152-1-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261111171417.249152-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: lrObffIgt1w-rkeGAj2Ta94-Bf2A3IfB
X-Proofpoint-GUID: lrObffIgt1w-rkeGAj2Ta94-Bf2A3IfB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NyBTYWx0ZWRfX5BGMjtt8YgrP
 6ZSdoVTFobvV4X6dw3fPCxc4JccdPQe2jFqv518Avo4p0HRSEhWqe5SuhOBu/bDD9Ahb0V5pZto
 4wfzCXkG+2HvyF1jgIaDIi1ZkPQZi0xrH/mB2JmmyRqdWpMNQVv+DX+sOUF5mdfF+6Pm1u1td7W
 jFHz2IQ0W2odCB3vvULR1aiCjvITLAbqCRWXDcUNRInC+LKpbi7/9NBqiI/Ar4C1jKGLj7OtTwq
 vNux3nY71AJSMkCb5WeN3uAhmUaezgeakFQco7gNDVIY9AIskSyVTwo9Vr05yn8LREbx3Zna86g
 ys5aK2xX9zXLlTCCthVaVUwoFs7d9XqIT4tEpnpdUGjeRnCnLtbrX+fBCi3SyzszzD9ssHz/Jvq
 0ddjXEKujddUttHA8a12ovbJ/1FkWayzOxeYKN6EoxxXJYOA6PREK/9pkbMGEeriBAJwZ7DNCki
 rDFzETzlCPZoOC5U5ZA==
X-Authority-Analysis: v=2.4 cv=I5bw19gg c=1 sm=1 tr=0 ts=6b0993d3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=OLKaC8uE9iNfMb6uFF0A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NyBTYWx0ZWRfXx/BV46x868eu
 CrK3SGK7wOM30OJx3+sVPqHQsV5AcPRkIkthPHZtyytEEPmPfGLN7evJWnP5Xi65G3ynKxsbi3x
 T+JccXsLlaW18SE6TC1MGyXPdlNUMBY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270057
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/26 6:14 PM, Rob Clark wrote:
> On a7xx/a8xx we can get some details out of the CP_RL_ERROR_DETAILS
> registers.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
