Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F203CD4F54
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 00:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C267111261C;
	Sat, 30 May 2026 00:01:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SPjJSPV+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hf4rSxwd";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 208D211261B
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 00:01:13 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TIQRik876275
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 00:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UpywO6SkDOjlP3BMRqeWEdeabYg7GdsoNqQc655h+qs=; b=SPjJSPV+ZNlrAoQn
 ZHxh7mmtcvDOm1MYocHyO1ZEIhJMunDrcUhCqbHQLdAuI1BDF0Ql+/oIxZZmLhic
 FMywCJ1j1ahva4KoZ/rxXJd9C6M2ukZJnKaGcjwlFY+lmggD1+zjUQEK3OhXBnik
 Vgp86RjtLCvAfK3PMeDe9To2Pd3DVU4F8TpzWHeU1v6zbLRjefpWtPbnu7PZrNLc
 wMOA8NTRrBZ1eYh0tygVzbxKYMzbVKSKu++zKen9u+LT9KSbwllVS6868krliWEj
 GtjURwWxPyZUkGTvu1MFVmLMZSMfK1LE8CERJZbpk0eeMIlgTqk3HlXB9YAQJI7T
 8R/e3g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efg3416sp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 00:01:12 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304f23c55b2so1121057eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 17:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780099272; x=1780704072;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UpywO6SkDOjlP3BMRqeWEdeabYg7GdsoNqQc655h+qs=;
 b=Hf4rSxwdpgl6xTAzOkkY1AxxkBAk243v291BbBaJ2IwSkjZ+9xn+rAn6YQK804erNo
 Rg/PhoQQBlpFPGmS+f0xAj2sx5fcGOWrAt8IGLqIwl7Xd0i0Ji92+MAQXSczlRH7Sv7k
 h895kcRKTVe3IsCB/VbCQ6O59Jq+M3OuzPDWkkOo+87sVPSgxU8qnNuR1NXsoqFFL0DZ
 cvfzm9d+7RwFDVsjpZwzcgorb61LxN0VeGEwxKNyXqeA47opGrrGem7H3O00bKISVG3s
 5zEvUWUPwBmrBBQXQhzIHf4SHRTu1ESe1ljet+a9cjT6PWOqNv/VzIJnxmFIyOy86veD
 57jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780099272; x=1780704072;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UpywO6SkDOjlP3BMRqeWEdeabYg7GdsoNqQc655h+qs=;
 b=o9IwYZ9UEe6Lw/j3JVItBhq5zAh+sswMb5JjOjinSVPId9NqNJybbQJZjDB7gBbHtb
 cmsP9vIIr5WNtCoCsUmBxheXeMEoo4LMb/OAm5bZ2lsNcQj/tfT/FziW9ejHOZ/OIkT9
 H2f/4gQD4alDB4Jhju11Uczr9zLLWcLyuyER2P6aICnpec6gcnc4FSvDjekdMT3YAlfw
 xg6B78o2VFSFu77DgE10J9VhEkrE0UMNv1hn7PhRPEgMFvIDwaNJD0Nhz3C8BDhGXErP
 hrVIRmd76DHWOtmdK/GWeTwl7UO7eb+Dz1Kkrx/CC5tkwB29SL8sVuIzqtHFhz61SL+c
 lr8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8w80iKxKeRuoqsHUNfWE1+NbGodSq846iwkf6f86MDYxloY+pwrSBxNUCWyejIycoZTDM6CsTrto4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLZ4qgDMAn7NhPgxIJE/yG64UKqaP4AhYXKryNY5D55nZj9+63
 Yw64WDl48ATMzlixdJWiNBMNnOun6O+AwaXFtGOdAKyMEpjGIMaGJyG7Iy1l2K8OH1Tr6LbQ4ND
 lXnm8i053mZaxgQg/jxInGYDSUd78KJ/esKnJvyZY2Ku16/7KzVwWwMUB78hbTiJEfF9KwKU=
X-Gm-Gg: Acq92OGu1dQwj0UuVvGD2kHG+dVdkj1Ms2udrCScPpu4uVeZMzDM7ygSkHiTkYwQeni
 F4GuUQCYu4NC7bWVG3RkTiD/+182a9W2rf1YUVQU7/hnr2bmZ4U85lPS6tKiSlG65nr2OnaTqDw
 MbnmmeppZ8H++SVyAffZG8ptaoipDshJVVPy9aeTrTFJel5RYHUU/BkQySnymN0ECGJ57I39Kv8
 c8tHLC/SWtjMwkaHgjgSCRu0rOf6nmuBZ6mVNhYJHyurF8G0jo6rxOj4A+5EUvxKmSesrtJRvWJ
 CP7EkrdMSqCAwG3ReH5IqTqEBlNIYopA26eLRPENxbH1Q9bFCAkLmAUb6zPSwE9HPQr2z2KHpK7
 JBMcSqdpsAMxa7WPdw6yWPyjh275FsZ3x/ofvB8sf5A0oxSwRXjw3sG++DLGZgRm90IpJFrO58Z
 dVAnSUAJcvGJY8zYTZuL6SE6yj
X-Received: by 2002:a05:7300:5729:b0:2ed:e14:e954 with SMTP id
 5a478bee46e88-304fa6dccefmr962706eec.30.1780099271386; 
 Fri, 29 May 2026 17:01:11 -0700 (PDT)
X-Received: by 2002:a05:7300:5729:b0:2ed:e14:e954 with SMTP id
 5a478bee46e88-304fa6dccefmr962652eec.30.1780099270745; 
 Fri, 29 May 2026 17:01:10 -0700 (PDT)
Received: from [192.168.1.59] (c-24-130-122-79.hsd1.ca.comcast.net.
 [24.130.122.79]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5d5385sm2693818eec.28.2026.05.29.17.01.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 17:01:09 -0700 (PDT)
Message-ID: <4bf20c0b-f153-44cc-ab83-cd0251dabaff@oss.qualcomm.com>
Date: Fri, 29 May 2026 17:01:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] bus: mhi: Drop controller runtime PM callback
 indirection
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 ath12k@lists.infradead.org, netdev@vger.kernel.org,
 mayank.rana@oss.qualcomm.com, quic_vbadigan@quicinc.com,
 vivek.pernamitta@oss.qualcomm.com,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260522-mhi_runtimepm-v2-0-fbebf41a82bb@oss.qualcomm.com>
 <20260522-mhi_runtimepm-v2-2-fbebf41a82bb@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260522-mhi_runtimepm-v2-2-fbebf41a82bb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YOXLR_NcUcLkT6JvYlBri6AFFKiIkqqj
X-Authority-Analysis: v=2.4 cv=EOI2FVZC c=1 sm=1 tr=0 ts=6a1a28c8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Q7cftjHEbLmqyJcuSDAA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: YOXLR_NcUcLkT6JvYlBri6AFFKiIkqqj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIzOSBTYWx0ZWRfX5haF0E12Y7RW
 4vxHKaf1l6ezgmHxkI3dOyeT8ndjrcfL0qpz4ikXBjfQM2O+EBMVggeCMl9E80GA8fGRYd1EMsB
 cmSF+hswSrnx1o+9c/f1zvlD0ghGBE3qXdGdDpNShGp6NVxO1ATZl5SMPLt8n+QOzJY0VGBMtK8
 5cLmkRzFel/q2kK5R2PE45sWD2St+pR1lbDRWaNAkDKhXIr6yoNwu2hLslJ/zJ1GteoWQdKFa/4
 A/xus/TCfwiv0nwbkqzhtIB0q2IU5DvwQ/FpehsFGI5Jw0AZEKJl6TIj/wlxQAi8mITusqQelC0
 SvpvXI7ceuMhE4o4ELJa03zO9vfdJ/N/G4iW40ZvQidIIQYMTwiTj4QiaI6zqdIHU/es6iNeHHo
 PyJ/FdbNAlcCEvbfis1z/XgWq8Gl5AZ4Hez4igFtO9wt+0zEtCoFy3aByWHMXDpaEztow7N8zqY
 XFKq+oAUvlYifiW3skg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290239
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

On 5/22/2026 3:00 AM, Krishna Chaitanya Chundru wrote:
> The MHI controller interface exposes runtime_get and runtime_put callbacks
> to abstract runtime PM handling from the MHI core. This indirection is
> unnecessary since the MHI core can directly use the generic pm_runtime_*
> APIs, and the existing implementations are either no-ops or trivial
> wrappers around those same APIs.
> 
> Remove the runtime_get and runtime_put function pointers from struct
> mhi_controller and update all users in the MHI host stack to call the
> standard runtime PM helpers directly.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---

>  drivers/net/wireless/ath/ath11k/mhi.c | 10 ----------
>  drivers/net/wireless/ath/ath12k/mhi.c | 11 -----------

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

