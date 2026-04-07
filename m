Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF56AFB5181
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:36:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4969910E314;
	Tue,  7 Apr 2026 02:36:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jD+BQQVS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g9kCjloE";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1F8810E312
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 02:36:57 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636LQCrk1405882
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 02:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rP7QNfv6ha6cStrz92Y08u5fmQ49YKBVYPbtSOrnZ24=; b=jD+BQQVS01zRWx0D
 eBPsx140V6CnvnmituvAg97pVj1XVAmwswzXr7b8HsLE+jYs46s9LeKoiuYrInqN
 bnMznjcIlNmdBOiztIFMSrbmNRws8wHhTjfHGfsIG/UbnIqHa1trwJBoGq8NKL9l
 x0gkR7Xj4+wSZgHJjLPanf91MkDwVzH86hQhAB0CkFd4baxj6QQlDPiJwaNlxzJU
 q6nOfhPXRnpW18FlPfBdeslGdPjFEIWfbm1PgVtB8Hx2DNM6De6wbo0VucgHHIRj
 sEmFEH2uYYk95qH1aME+9RQzQVl1e6lqb1Z59aYrNOUgUa/n+BVO9mobhSICIjuc
 UF/kyg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrarpea-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:36:57 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35da37203d2so10248431a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 19:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775529417; x=1776134217;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rP7QNfv6ha6cStrz92Y08u5fmQ49YKBVYPbtSOrnZ24=;
 b=g9kCjloExPDrcDRb3vWd7sT3YJhnym/OE+7lSrvrKb0e7+YS6e3N7sOMONeA4PG84Y
 aOxFT8f7iTQV9mvlQNfd29wc1E53tuZ5z0iRKMmf085fXb9MwaJyedPE/ayITB2YjFkM
 y1fcbJ1v4cgCm/yexp2LWNpwFRRXC8EQTRuXUTaJ27nk/9NuYV12f4fvZ4wjqm5QjwMB
 P1M3LE7b65GD0lz6ZuDZQHhAexKT5tpjbOfOF0MEZ/8wqGO8fT1WXAzUewCVzXjZr9r3
 yuFu+s7tn29UvQKhFqfr1B+2vuJlLH6vUZ8WeJohyMeH52eXgnWcDqJy/m/BECIDJlFI
 Txng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775529417; x=1776134217;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rP7QNfv6ha6cStrz92Y08u5fmQ49YKBVYPbtSOrnZ24=;
 b=Fxb3SMgJJUougd/HGJ+PS1Nv5vXf2HUbObUidOandr9a4pbti++Mp7rb3Hiakfe6a7
 HifaTlrO/kWDOMDbWrwfL3zwpcmKO0WNK1I6nh/1sDXAOzEvQJhCncWyBLAvg7F7AYFw
 Xf31fEHQD4/3Lv3qrUeHbyLRUifS4LYfgcTqXHK1EgQA02hu+3mUenB4sEBm8QkDI83N
 eUNkcMnCpM20uqIVL6S2a1SvZ8v1DtpiUdiuQa93ZEBcm7nxaz6GCejbyAFE3Gu4MCtS
 sx6CJQCZ4+Our6wwKNby3oPo/xH2iZhZp/xgssjd9ChWpXISDMfTXYjvGLCYTCmBzjkI
 GSkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfINpFeNm7JyWVmp3pzpaNVCDGno5kpkaA8qpUF9474sAJ5ncxe0Ct8daOOBcK/hRbZg4W8QrUAVI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMV/LGBnl6r9yVJ/xCyiB3jPtZTHqUJ0mWZVR49SaRfBd5NmL2
 ESOW0DmO0g5Xul4jYdOAut0fkacnrSO+8lmvE/GzO+pHpbCkC1GNz0OvvJbBgNBVyKxCvkWhsFh
 819N40W+X73eqrD3yOkSejkK/8MQ+yv/uY8euqD2JlJyRo8A3Tg569FgRfrGHq283yGGe6tQ=
X-Gm-Gg: AeBDietc28/Zr2nV3/kv/RIGyTyROuzjJTM8RHMI4P8AviTFIZfrV1btaVyplWliDKb
 oi3MD39Kq7F8GS7RJ9LedTHpU+URk0UHi90plW2++8Cj3eTeTZ/c+c/s9KXhi3xS7Ydsrr4zXh1
 lwZ3db+rLmbn9Xui2V4ptpZ71Ers52cUCAB8r0/VPuKnoQspnwYDYsSiArLvdeym0Cnm6YgqCe6
 ax8oQnK3bKl6NJVrgqx3w+8A5Oq4vf5M2xcGyOnaoOWN6ZkLmxCl9VGLrJPOuHfdoxQAm3TFgum
 wx6FOc7V3Cs7ICb3CIBUJj+XDyRY43ASAJJwtLcj9qVtTlGMg2cuA3N3PrwaFS9wBKW+1Fm2LKh
 FIM+ZySsY9JZpcjeuRPzaL9pgD8j2UH8W7/Pqv5Gv/jNfMKcxAucPnEqMFtuGd+dQ/SE0Voi96z
 IyX7mW01PB9g3wKR6wOQ==
X-Received: by 2002:a17:90b:3851:b0:35d:9d4f:f58a with SMTP id
 98e67ed59e1d1-35de67df975mr14429980a91.9.1775529416685; 
 Mon, 06 Apr 2026 19:36:56 -0700 (PDT)
X-Received: by 2002:a17:90b:3851:b0:35d:9d4f:f58a with SMTP id
 98e67ed59e1d1-35de67df975mr14429947a91.9.1775529416223; 
 Mon, 06 Apr 2026 19:36:56 -0700 (PDT)
Received: from [10.133.33.129] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35de51710eesm4244919a91.1.2026.04.06.19.36.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2026 19:36:55 -0700 (PDT)
Message-ID: <360d6087-2907-4db2-9273-c3ecc39ffb12@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 10:36:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 33/38] drm/msm: add support for MST non-blocking commits
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-33-01faacfcdedd@oss.qualcomm.com>
 <56tbubd46myozsycduvb5ds26smzosydr5fmbvmlv6yoiqt5wr@3ib5gnspxxqa>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <56tbubd46myozsycduvb5ds26smzosydr5fmbvmlv6yoiqt5wr@3ib5gnspxxqa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nUlH9Ug43v8F7B9Vg_SNqAVowGEVdqSg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDAyMyBTYWx0ZWRfX4yBNlECyOpg/
 L1L6qquuion44T3rXOMo1JpNXZKeI7AA9WGoJAfpm3lNq5yqn1Z30VSwnnjxf433Av9iaHtewq0
 Cdr1BfM0iwhnHI6iZuNv1hXkuOJDNdUReZ2KLvFcUSn3OidX8dMPdgyEfo88DmzNzlILrOSswgN
 Dt3nkiXNbn3Inaz+1VHDdDwco8mwxv7XY2dJKTkd9Mn/OKZVLeE90rO4dp9xu1CxZJl2SP7cEm4
 ATsTpJUo3+znDx3Ks5fBV6sSJdOCGtrSWPEHy6VLmjwuUzRfdzOPZ08MnnCLtgmkiuCdAN17UQv
 KE+mAwpG5QWGO4hIijUtNCZ0LgP9aAZsFPKb3ty9KfuKO0zlggRKBGOEx6OWgDQBxvsH9Wrd9TC
 iHupboG5r4LGU6qr1Kp7+4YPF8hOBl6mcwPPsiSJXsswg5ktpoJUrKVd3bc2vgPtlY4dq3FPUkD
 yu5MHVNssN43MijfleQ==
X-Proofpoint-GUID: nUlH9Ug43v8F7B9Vg_SNqAVowGEVdqSg
X-Authority-Analysis: v=2.4 cv=D/d37PRj c=1 sm=1 tr=0 ts=69d46dc9 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=v9bGeqcMFpeTl9iv2AIA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070023
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



On 8/27/2025 2:47 AM, Dmitry Baryshkov wrote:
> On Mon, Aug 25, 2025 at 10:16:19PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> Integrate MST framework APIs with atomic_commit_setup() and
>> atomic_commit_tail() to support non-blocking atomic commits
>> for DisplayPort MST.
>>
>> This patch only applies to MST. For SST, non-blocking commits are
>> already handled via commit_tail(), which internally calls
>> drm_atomic_helper_wait_for_dependencies() in the DRM core.
> 
> I think this should be squashed into the the commit adding MST
> atomic_check call.
> 
> Otherwise:
> 
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> 
Will merge 2 patches.. Thanks.
> 
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/msm_atomic.c | 3 +++
>>   drivers/gpu/drm/msm/msm_kms.c    | 2 ++
>>   2 files changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
>> index 3aa0020dec3a90b693ad3d4171cfcffc091aad4c..b1656fb456d54af11ba8a30d4971fface114c7a1 100644
>> --- a/drivers/gpu/drm/msm/msm_atomic.c
>> +++ b/drivers/gpu/drm/msm/msm_atomic.c
>> @@ -4,6 +4,7 @@
>>    * Author: Rob Clark <robdclark@gmail.com>
>>    */
>>   
>> +#include <drm/display/drm_dp_mst_helper.h>
>>   #include <drm/drm_atomic_uapi.h>
>>   #include <drm/drm_vblank.h>
>>   #include <drm/display/drm_dp_mst_helper.h>
>> @@ -226,6 +227,8 @@ void msm_atomic_commit_tail(struct drm_atomic_state *state)
>>   
>>   	trace_msm_atomic_commit_tail_start(async, crtc_mask);
>>   
>> +	drm_dp_mst_atomic_wait_for_dependencies(state);
>> +
>>   	kms->funcs->enable_commit(kms);
>>   
>>   	/*
>> diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
>> index 6889f1c1e72121dcc735fa460ea04cdab11c6705..09776be1d3d854f4c77d7df3afa8d56f53639411 100644
>> --- a/drivers/gpu/drm/msm/msm_kms.c
>> +++ b/drivers/gpu/drm/msm/msm_kms.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/sched/mm.h>
>>   #include <uapi/linux/sched/types.h>
>>   
>> +#include <drm/display/drm_dp_mst_helper.h>
>>   #include <drm/drm_drv.h>
>>   #include <drm/drm_mode_config.h>
>>   #include <drm/drm_vblank.h>
>> @@ -29,6 +30,7 @@ static const struct drm_mode_config_funcs mode_config_funcs = {
>>   
>>   static const struct drm_mode_config_helper_funcs mode_config_helper_funcs = {
>>   	.atomic_commit_tail = msm_atomic_commit_tail,
>> +	.atomic_commit_setup = drm_dp_mst_atomic_setup_commit,
>>   };
>>   
>>   static irqreturn_t msm_irq(int irq, void *arg)
>>
>> -- 
>> 2.34.1
>>
> 

