Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8B7C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 19:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25CBC10E141;
	Fri, 14 Aug 2026 19:27:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZSFHEpFP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bCrl9TMi";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B74910E141
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 19:27:30 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EGhaKX1472641
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 19:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tSLfEOxYP0vSrAkxyki0StAKequhT+48qAGHOJcTMn4=; b=ZSFHEpFP2tHrnA2a
 g8Z6pgMkdP1GBnj0dh/O6Mt5FP1DNj2IQM+Zmek5Ke5ifR1tMNy6O+lOAMufRaqo
 MYRSZjCgoKb+gwSMwPdX1XywEaz/WWgR6xGQES3p9mRqw8G24T4GdYwDfBO26LCa
 /GYAH1Xe/ILMoQDkL4Qynyx5nX5ya/3+Wp8ftPcrFn1XS/NjhfARVJ2tz2luqFY3
 p9tF/zhmjhh2bsKSpBa7zdK5JpYpk3fIeG3sdNBNNnRZ0IIW8k1obeSr6HYJxNSG
 sbtMcy6zLVhbC/1FreZFdSgx/KLfBbHBaI6EUdvsXO/Hx5dobp1U9+9vOJX0lETR
 yzVafg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g267rgrba-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 19:27:29 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e22137fb3so2068363a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 12:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786735649; x=1787340449;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tSLfEOxYP0vSrAkxyki0StAKequhT+48qAGHOJcTMn4=;
 b=bCrl9TMi6P/XYSYifhVZ0+2pb7sQUbVLcNjjaZTq+O7k41gCQWUPVpgE9AUQkbc6pV
 gCoQ6ZnN6l20zysihyykZeNBYklC8tRdtQYHT9RJmd4sXKrGIFe9YTayk2YGds8ro26V
 hOfkYSUapZmstbE3rMkZFpFXZgontf36GO40Jaofm6EITZK0jl7fJqwE4qvX30+9Yp3R
 6EFHaHxnOaGL/TTJeIqZEDW3qmgwvMGUHHc50Q8y+F1U4WNtkmmBl9TVDd/0U//P+mUM
 Q3VdQWh8XGjwuhMTvjFR9p8vS4Q6M7gAXUrU0m7/OAKxpRO1dUGVFPQIX0FiHqDrtA0F
 z2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786735649; x=1787340449;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tSLfEOxYP0vSrAkxyki0StAKequhT+48qAGHOJcTMn4=;
 b=boe7e9JeTSQLURI6Glw8/Ura0FLx+O2Tb3fFrfQMlgRzcEVm8Qrn2Hv610pQndpmCn
 f97WisGnlq1Q7C/sk1Ji6E2LFm1GKKBMSVPrzUX9L7D7VqJWTX6wMwwWfsc0KYYtNMfk
 L2Bg1f0l8VjwlRjkNnFvKVifMd+KziGhBaxR1VfCQ33cG2htj35HJGm+XrLfQFb7GPyd
 FEkIvGLvvscQQGLMSUwGErKqyLi0uFVMVXROOvHHq4uhF9kYMHaiTmpJTl6flnOOcfv0
 Qa4g202rifzb8nI2JDz9IuraaxH64VFq32byP8c90kaLGjxLmbqdRrBkZSI8aNywt5Uq
 1ltg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoapwgzwPdPnN3/n9Ns84Pb/9iqe2Oqx7YO8zPXXUOseKkOflHMBCdTiZerf/tyZ6YOdrfqL1HYiRY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+CWDlrbVsrRrnSk4ZNVGLXsvLYpCGiFz/QsspcXfrPWK/fApW
 UuD0GVZ0/Ze2FhwrInt7yp/Zn3wJJp8gTjsLeOe0xzujqNES1X+N9VwQdpLV5LPvYrb7Lx1Zeyd
 wze26J6VSXYh4PCj5nfo8td6qvNCRb3PTtfpvP2AZDVxjK/uWKgQCYJNPuOCNtrlUN39fIRc=
X-Gm-Gg: AR+sD11kspqGgfXVFGnjnLdwwf714y3V9IotSM9vclaCcj1o2IPsB75d27RgNq9NYfg
 GVJJLVnuILjTeh4/W0eIUQDRCD0zQuKKnPnwy3QaICLKQg8LrAKfJMFCiuGcFjcreVuungrCXLq
 Fa8JO+T6xJzu1lmOmgyF2epol5k1dKDzDstqlox2c/l5Ue0cISAosOweYeh8PpyitjDGOWSlybo
 A6sNYHYe0fR8qyn/4kAROy1eitqY+LTirtQDX+VzdJZQFR3YbFu8CrKBO54NQcJuAuETo2i3gDE
 dhba6dnzcNl7OgBxg6Cd34qzYfMKEfkQoSEtS3tYG5WVabyNBH+kh0pxMY0u9A6K6F0r6ODKZEo
 5vTX4HHH84YyfYLuVO9mWz7Di8HQU39IrEerEH2MjBPkXFjOlrUVKGw==
X-Received: by 2002:a17:90b:4fc1:b0:38e:2524:724f with SMTP id
 98e67ed59e1d1-3933b8f143fmr10004727a91.12.1786735649170; 
 Fri, 14 Aug 2026 12:27:29 -0700 (PDT)
X-Received: by 2002:a17:90b:4fc1:b0:38e:2524:724f with SMTP id
 98e67ed59e1d1-3933b8f143fmr10004665a91.12.1786735648703; 
 Fri, 14 Aug 2026 12:27:28 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141387e49d3sm12130628c88.7.2026.08.14.12.27.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 12:27:28 -0700 (PDT)
Message-ID: <228c220f-9cc1-4ef6-ae4e-afa9a6c22b6c@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 13:27:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] accel/qaic: Add missing <linux/device-id/mhi.h> to .c
 files
To: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
 carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260727173326.2219191-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260727173326.2219191-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lml70vTzWmuX5tqv5Rg8gTCH4WCGrv_G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDE0OSBTYWx0ZWRfX44ZnLU3E+CcC
 hEPfQndGGed6GtHzV2BNUIl8PL3tOBfFrmJGXjgXInPu0aXgAU4kSF9jchVhfqMAiHXyW4kZLCY
 L/GUgQUyw0o9pBhm8gU5ZsfvQiIEi6WPIz2Er/D/qOZSBvA1VpFJEn+6fHO5WsItCXfz7x585jA
 UetNs3qndkRf8SQYGB3euOycGocHsiB4qAbPcL4Y1aPYagcJuFNXvbhAojqn+GiCFhPvQ6mdviZ
 4puIuuwH61Z87w7cr2eXYF3USIKzTqkizalMtILDxTB/WWkqRnyD0b/+lHGR2xpssNs2xgObLWq
 9tTReSJIiHR5pNHf9p7J0I7cw1Ls/uoNkoSfDHZ1W3r9fgQOyTycm7ngcQPBNAqIbuwVu8CP8bC
 9NCpivTgy+X5SoonvWLgJsvshjCQ2HyEMefNkPXF5QNYUjiPHI+XCXDQvHOUhhe1hOc3Cv+YHkE
 7/IhchiToSEHmQ6H5vw==
X-Proofpoint-ORIG-GUID: lml70vTzWmuX5tqv5Rg8gTCH4WCGrv_G
X-Authority-Analysis: v=2.4 cv=LP5WhpW9 c=1 sm=1 tr=0 ts=6a7f6c21 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=LFKF1gb2yPlRpIi15JYA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDE0OSBTYWx0ZWRfX01svLsUWmlZc
 luPAZtgDW9fZzsHt+/rcW1Dh1wT2fP88YNhPH7pjKcB7O0x/v6xQKOOzbtK1p7NIsg2fRyyNQ7o
 rRn5a840JUCxK4j7Mc6tpxGb70dsi/E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140149
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

On 7/27/2026 11:33 AM, Youssef Samir wrote:
> Although the qaic driver is using MHI, it is missing the inclusion of
> <linux/mod_devicetable.h>, or the more recent <linux/device-id/mhi.h>,
> in some of its .c files.
> 
> This series adds the missing includes to the relevant .c files.
> 
> Youssef Samir (5):
>    accel/qaic: Add missing <linux/device-id/mhi.h> to sahara and timesync
>    accel/qaic: Add <linux/device-id/mhi.h> to qaic_drv.c
>    accel/qaic: Add <linux/device-id/mhi.h> to qaic_debugfs.c
>    accel/qaic: Add <linux/device-id/mhi.h> to qaic_ras.c
>    accel/qaic: Add <linux/device-id/mhi.h> to qaic_ssr.c
> 
>   drivers/accel/qaic/qaic_debugfs.c  | 1 +
>   drivers/accel/qaic/qaic_drv.c      | 1 +
>   drivers/accel/qaic/qaic_ras.c      | 1 +
>   drivers/accel/qaic/qaic_ssr.c      | 1 +
>   drivers/accel/qaic/qaic_timesync.c | 1 +
>   drivers/accel/qaic/sahara.c        | 1 +
>   6 files changed, 6 insertions(+)
> 

Applied to drm-misc-next

-Jeff
