Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9424CD5BB1
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 11:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17CE610E595;
	Fri, 22 May 2026 11:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Aj2L2KfQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YxftEqKz";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C66B10E595
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:36:31 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M8t38p2765337
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0Kz1PaqWwTEocBZajiua4OjXbfEzHPpJqKHCbrC3ujY=; b=Aj2L2KfQaFaxDwKh
 uyLL6HufEkARLLv45DffTT2fIHAQ37lmu6axPOK4fH4DDwbY9p6AdohVE3qFm4Z4
 ZXHxNmDJ4lBo570XZT2fN70Ohc9J1LDdEscWvvX6umXsoP2Bo+1GTibwv3qP3PEu
 sE4AdZzd9NOaW/bbEih0wrNwJbpWM+oss3OR5bJfg0aHwfO9QCRurCYlk4U3U+3Y
 je8BrKri+9YBzbCrhCcr5RbrLAMuqJx/lCo0U3oP3bxZP6xy6kW4eeNT3rB/H6GX
 6fxjBlcoG66CHTChld5+hDdTGOyySLGt+MuhwL6FKfgmrqGlgsMqkAb6GE0ZYOS5
 TvxZVg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea3u7vrst-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:36:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50faec938fcso17728391cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 04:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779449790; x=1780054590;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Kz1PaqWwTEocBZajiua4OjXbfEzHPpJqKHCbrC3ujY=;
 b=YxftEqKzgFocP1pZfPDhd7pyPzT8dNmfS99sskSmWlS7HzY6ndYEa2UPic7nhPklBQ
 3B7RTOi27tJDU1hndxOdiXhn8Uqp54Bsd1bz3oslsjooFRM1Tz1yijJk3g/UYhffTgy6
 GFGNg31BuZB1qVhGyjdNpH5xvihcZKXQX7ht6/G0QHm+nsKyaUDKama34/zmijL2fwei
 fyIa92brpYSca5GZMFaB6n9wcDSAgyRXzBfoZQhWhuqWtOPCNEeSH1/CMb5Ov60cS4Hj
 zjYN5sed3SxvhHFmDYbKOHmGu4FvFY7FZVn2LOpK2KkUI6M0gyEEv9X+TcmgKiX+P7ke
 Md/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779449790; x=1780054590;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Kz1PaqWwTEocBZajiua4OjXbfEzHPpJqKHCbrC3ujY=;
 b=mte0E7jdGSrS3Lsb7+BumlZgIj+Q1Cuy6wdt5TkPfLx7GeR9Nhvi9PpTsXGSWbv4fq
 OAWEqbpnpZ/E99bT5hLQKbZFhZITlIXPTxmP+LEmWm2xhjzQKQaj0t01eQFT2FuAAR9O
 zhyb9idGCoEuvjCpXcClR7aO2I937jz2CI3wRm+l/AUKUa7+RuGRlztWkpZ9PHRVFpuZ
 wcrWNC/QqdXMxwR7rxInWDB/ts21QoE5sCb4eIXAgKAiN7XLlvuh94YERRkjTjmAkLjC
 V7Jf3N42ymeFcDtEPDaXVs/ObrMofa8Y8jcJJUtR1Wk5c5SUkPA9jU8iq8KgH5NPYNgl
 ae8g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+cMPtS/AotPos7EoNit3SmyD6KfnMxijow23JQtp6csXvDfp9sI2X5Rbdvo0TuTMHYO3Wj7JVuIW8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwCduzPJR0ofI5q/oOFppCJAiI1WJdL/hcHIpHuYjVdcNZt9KFw
 /bS4mj9CTulKDzinli3fehLIKu6tkmmyY7RCCn+/RDN13EVc5/lfQAGTXQahCKsroeVkl84yMn6
 631fRgBYN4Hd794mC/V8CM0yGCaEvX46Rok5RLwKf1UdVs6Ed+0691YyHC7pmvYuD8y699SQ=
X-Gm-Gg: Acq92OHunalTBiLvT7507UzrBCVjKayX6RtRWXwQjSS2E3AqSyOzxchoxEzg8WMuCp4
 sSczTCq7WJ6eSAbyBCYjm44bD0FSGCyWCH5f17Qb+SlfIGxMCQ2Vyufi6A0o9sRMO1kISvQHYlC
 a7aWcq/V0YOomfGoOlQVHZINwISJdq8zwB0u7/vloRi4iGozBktAHIhM+f34M+2j5k+TvO0ud3J
 YCPKBJG33FFg5NON4f24BAO5UiLHOF7KrPEXoFo4vwJLdpsZ87Aj2o/Prf2WhlyHf5o3d63LkZS
 zHKsYZ/CErMJnIgI25MilGvMcp4c0a96eEJYxy6HRt8ye9Mb8y3okfir295otseOcuXeOWJf0Jz
 s88HP1PDLIh9xqP9ul5QwfF1Pp36kEetcBd/1uKCCjbkRAQ==
X-Received: by 2002:a05:622a:17c7:b0:50e:5cc1:1de9 with SMTP id
 d75a77b69052e-516d43c245emr35211741cf.7.1779449790634; 
 Fri, 22 May 2026 04:36:30 -0700 (PDT)
X-Received: by 2002:a05:622a:17c7:b0:50e:5cc1:1de9 with SMTP id
 d75a77b69052e-516d43c245emr35211441cf.7.1779449790279; 
 Fri, 22 May 2026 04:36:30 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-688b9f60898sm614332a12.13.2026.05.22.04.36.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 04:36:28 -0700 (PDT)
Message-ID: <44b80ab6-cc4c-459c-874e-8cbc98b82921@oss.qualcomm.com>
Date: Fri, 22 May 2026 13:36:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/10] drm/msm/dp: drop event data
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
 <20260314-hpd-refactor-v5-6-0c8450737d64@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260314-hpd-refactor-v5-6-0c8450737d64@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aIXAb79m c=1 sm=1 tr=0 ts=6a103fbf cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=WKJx3f7KLcD3q_vraEEA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: OANYsUedR8Qo6z9CfLkZXnNkJr460bGz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDExNSBTYWx0ZWRfX3wFivYNnarlX
 Exzc+BLLC3D+LessIlG225guAzvEYSuT48QHT4r/lWuRH+PJWUFjL/ZjMkzQ0RUiJqda+/hL/nQ
 AHeukia8gwyjEhUr8E7f0A9GY157Q0JbPW/bRgxV68P63ffDLZc6Zt0ABZCswqKi82YvxjqWgAl
 0SdTRk+A8pOhvly+X0aB9uN8IOeEAh4926+LFMoLIXIic+QUsqxPKceCaER4fFHMtbzSwVhyrBs
 qQ8IMgY8q9A9w8M7WPOuUe3B0ivGnmarv8iTq9gqDCMs7Ja/2bw2BPJr/d3oX7PqMb3icXqsS1V
 MHNonrngzK04LrTwUVZTJCposHTtv2URcP6SlO2bXiGZSXEaf3e1iAZ/44sUnqMaOOTmZdC8/vE
 coKvcHuO7tAOHLWnt0rpNGwpy1CqxKEYvAykkqB43/pgIv71ggUkomYjijZkitKrLiB6cgTE+uV
 71xgQq3zXiSbaEJxb5g==
X-Proofpoint-ORIG-GUID: OANYsUedR8Qo6z9CfLkZXnNkJr460bGz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220115
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

On 3/14/26 2:09 AM, Dmitry Baryshkov wrote:
> With EV_USER_NOTIFICATION gone event's data is no longer useful. Drop
> it, removing also the argument from event handlers.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
