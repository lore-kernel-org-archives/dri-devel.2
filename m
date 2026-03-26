Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA9A10AB81F
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 20:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C734410EB85;
	Thu, 26 Mar 2026 20:12:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GQySmhwv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c245CKcT";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7748410EB8B
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 20:12:53 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QGKYnT638688
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 20:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Qsmz1RtLkSbASLYXXxlZoxnDX1y/ZiflBrWH0lwDH0k=; b=GQySmhwvWr292qvQ
 Bgk2fh9i76aQJFVMR7B5IaskHorUINoRFaADSIIgiRRUya4snLSS9ZZ8tgRpXJDT
 EopJIzyQ/7MrCqmKr7Uo1iuUVB2H44ektweW5InsuOO6VsbW0IW7XO164/XqgpwC
 4wR3WoaYxtR1ZL1k1WoVOOKyWNOK8aQ8KLSRB4pE27hC4PPGdevI2q+Cyw2KdJJp
 ELW4/vEW1s8yyOxGgEM2GkI0LgjLaVyUC26YOGMbTmD7NQeWFK2Yxr0swus9ZKZk
 X7nD92gK+luVNm+F3wKGTZ2nsKGCPjX0CeDjKSqbh1pC/wT6V2LOYd80tnNn4l7L
 uLDauA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5883guhs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 20:12:52 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c739120475fso980532a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 13:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774555972; x=1775160772;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qsmz1RtLkSbASLYXXxlZoxnDX1y/ZiflBrWH0lwDH0k=;
 b=c245CKcTvvlqarsBIjGx4Px5r5DT4ONdaniNuXcRLgQOK1l+Imkfw+92THn47BTXyl
 rbjajwX2quhU1PCkCHi2JdFNG67aWw4s+SMpbDgItL05E4Uiw4n4EzTPYYEPzjyJHpt0
 R6wexvNAVa8tc/BTUpvdDjE8t+vTvIvskmiQrbzxtOQtoqaCIyY484W8O0X1Nz7AYhqp
 lgad9r7HDaAQsB5ouyIitXAEV+ldmbRxrVJU0kVQWJS6koGHI0llsHU2pZHuaM8y69Vt
 EBsrpMt/iYhB/2daY5pzkO16GkDez+Cn5g/ZCCZAJCAgy9CqDLPJR32WyQvny0a6jPJl
 1Pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774555972; x=1775160772;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qsmz1RtLkSbASLYXXxlZoxnDX1y/ZiflBrWH0lwDH0k=;
 b=EN40LKro8OnjlTUzwVDzvjWEiGYeyuzrn4B97iOXBRo3/4h1uJEbaMw+CsVcccxTpt
 MFhQnUE7Aurnpg+0zvbR7STS1lEaJDqG5b/yPDuMcwutj1Vb9auVC8PiJNnQmDwElsNt
 thiln0Xpy2p5hhpWfOs5/6lbNwqJzT+kju98DXaBBR6uVgap+JRSxXOg46CRx+rZKYmW
 8hdDBgSnulGS+fWvA3R++vRvhJsYMyo9oCS13CMTBDXfnKRYI7lRXf3bbSY/sjrd6rJN
 8/clnEUDJOdLPkCM4sEMhp9P6iohW2qltwVASwFzRpvdYShk+cRpH1aLtJ7oSYGi19Hw
 zwZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWesQ+3aC5b9HfSuj0lGaQ//EBnstk94QGy1ZwdPyLnT6b7Q1r/bX4l7WZy/qVrEID4v2T4sDb+Kuw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMnI3lpLyzgqwq6S94WjVJssTXI0lzpcLtpnUN3UMGBpEqV/Ry
 FFsOIBmXjmW+gj4ZI2iPn2ZqB51oUQTZEJIBdTD2wAeLjiwJ3Bbco51Nu1MObvAG727JV7+DFTL
 E6FPxqQlbci747evVrF240QY1RvAr0mJmzZ+Q/xb40d0il1WElix4FrKPjMmTK9qLOyMbVJY=
X-Gm-Gg: ATEYQzziScqTK1IKfurG/Zc+4EaSoppd8ZgeMjRgPDrCiJjT1FKncGE04uQ2cOB0p7X
 o/FbqgjFHffrlCjYmHhmf4yP6Xj97n8nA5Xx013ESuKvrjueCxT061bey758J5BAy8Ir8o/R3pr
 inm5VMsZfzOTGml6Ia4MHasr2GOH+6GRu3bLZt5L1jH/a3zc7CHPdiUmQ9s/xktL3RU7kJcZMLT
 g40zPHusb+hcBhA5l29TjGg3degniJKGPRdymLZuHiX/yNgL15P0lpMVS5qcv56Cupiz3zsmra+
 lpEg2HfQcPL47pqcDm+Kz13UkX4HhXxqp6n5mOo2R/pNSCUP50/EdY2CbRCOz3P4RvZEkCRGbhd
 q+lrt3cp/TCz66QM/ciAeWExlS1SLQtmKzSX4SKlWR097
X-Received: by 2002:a17:90b:5109:b0:35b:9777:8bb1 with SMTP id
 98e67ed59e1d1-35c0dd951a1mr7211362a91.19.1774555972202; 
 Thu, 26 Mar 2026 13:12:52 -0700 (PDT)
X-Received: by 2002:a17:90b:5109:b0:35b:9777:8bb1 with SMTP id
 98e67ed59e1d1-35c0dd951a1mr7211358a91.19.1774555971741; 
 Thu, 26 Mar 2026 13:12:51 -0700 (PDT)
Received: from [10.91.121.222] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c2ebe2c98sm44495a91.6.2026.03.26.13.12.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 13:12:51 -0700 (PDT)
Message-ID: <7d223573-438c-4e93-b4b4-64975c4da93f@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 01:42:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] drm/msm/a6xx: Fix gpu init from secure world
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
 <20260324-a8xx-gpu-batch2-v1-10-fc95b8d9c017@oss.qualcomm.com>
 <e44e776c-df8f-4555-a487-9a7a6fe032dd@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e44e776c-df8f-4555-a487-9a7a6fe032dd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HLUFkr47QT90U7SIkohaw3-c8HFztvAr
X-Authority-Analysis: v=2.4 cv=bopBxUai c=1 sm=1 tr=0 ts=69c59344 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=SFlVdHt8JhaXNI1LWXcA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: HLUFkr47QT90U7SIkohaw3-c8HFztvAr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDE0NSBTYWx0ZWRfXz9n4yUZH0qjL
 lQuMikt6aqyfA/GH3asw065MGzOiXLcZ4zjMS+55KQ83clYxaSeoyRrcY1DN/sBp9Or79ko4Myh
 MqDrViIlwgpS0zkiQ7LFIcN+U2s+MRWT+nm4hWvwKx7N0Fg1kHDnPNVANn6wO61Sj2aZ/Pz86C5
 uOdpXr6WUBGzcNHo736kNi18U+Ffbpe74njNRa1GG/suMXh9e7bZtx87d1AB9xIbzxRwfK+9t7D
 n46ZpZ1pr01Mx4t6m5p3Z/0BY4coOAljJVpUmurV88DQ+MF2kKzqK7rCUcA3VxMkqqe8Rqv1se1
 E52ghMwsVnUxXF8jrIsason+8+Nk9OHiJ9mUGi9sefm5/GUARmg1nEMYiGen+CcyGrpvdCHJ+Ma
 0RwRqn1RmzMVNNfgsqzSEupxxObONj3ZBiOfVmZ+zt/L7R2iTBSKD503amN3kbRoXMitm4AtYod
 S3FUQuujBvP2Z2JQVjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260145
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

On 3/24/2026 3:37 PM, Konrad Dybcio wrote:
> On 3/23/26 9:12 PM, Akhil P Oommen wrote:
>> A7XX_GEN2 and newer GPUs requires initialization of few configurations
>> related to features/power from secure world. The SCM call to do this
>> should be triggered after GDSC and clocks are enabled. So, keep this
>> sequence to a6xx_gmu_resume instead of the probe.
>>
>> Fixes: 14b27d5df3ea ("drm/msm/a7xx: Initialize a750 "software fuse"")
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> This now makes this happen on *every GMU resume*, which sounds
> undesirable (kgsl does this in gen7_gmu_first_boot)

I had this in my TODO list, but forgot to update. Will fix.

> 
> Similarly, we call a8xx_gpu_get_slice_info() on *every resume*

No. We check then slice_mask and return early.

-Akhil.

> 
> Konrad

