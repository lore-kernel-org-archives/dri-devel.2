Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85733D35148
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 06:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7645310E1D9;
	Wed,  1 Apr 2026 06:47:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RtixfgY/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h559SvtN";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 496A810E1D9
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 06:47:01 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6312ON8N718623
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 06:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cU0JO6nNSOem63nZNguZOl6oCNzTQPmTCHcJjz8fqX4=; b=RtixfgY/wlQgXq6k
 KsAxx0Q5BkoJmN61F4mnOV1RdliN8JmZRcqrKCv3wWc7TPpu0JqZ00VsCQC/Cy68
 hUV00OJTQqlBuKoatc9H55/somYQ8dEPUyiwZGj8MqKfgclx8MIP3ItBapqiFgGP
 Z0rI3KeFON7zZMP4mx08edE8V0xFZj1aES0V3i/UgiV+bHjupAKL1RbMw42Hmmor
 2AvNu+uvr/ZzYRLI5w8ShwM+ae5dphtAOfLpYQN1t5R07W75pn8QAoW4DoDKrlfF
 1GpboJws/hJNfz+68dK7Rqq/TyluOw3bzoNG723GYoJY755gXMumfID4XUQhqT7B
 B+lU5g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8kcstndk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 06:47:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b258636d16so30729195ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 23:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775026019; x=1775630819;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cU0JO6nNSOem63nZNguZOl6oCNzTQPmTCHcJjz8fqX4=;
 b=h559SvtN4kGrNem6G0aGfKArQR5pVIyhJ2AM0P2H6D+IKALKcOVNPynhrbzhZWU5WY
 KRC8Ls/QdsbiWnOUWnna4n2xX8e1YTgsImxcYYabcM0fHtTPi23fKafsn/4oBbo7rzd+
 7xZz4XFTiiJi8i1WoWtye9gpMuBA8SlMs7PF9tx7CY2HJ6e27t6OPABlGQuXrLPSciZJ
 NLVPBszN+ALNBA++P4RGw9VxbaweBnRLEYtDKNA/LHA/Jdp+bK/HFY2Soj7PmTFFdVwO
 sYDqHsWGTZjqTvY2eKv0Lk0gh9Fp5cNmbqvaWb42PMdE0ZdAJh89ayLGpaVqmEtyUP7q
 /aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775026019; x=1775630819;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cU0JO6nNSOem63nZNguZOl6oCNzTQPmTCHcJjz8fqX4=;
 b=XlEFzk++/UzxUD0t7avl38RGwXb/oepayR2GY3cVPzkGZy7SNom5u8zd4CKXpVdRv/
 sB0ceHjpKGGgkj9iioatInhm7xSP6wQ0sWNLt2j7OgUH2oVYkX2r+hbITDSrXcJlHvZT
 9SxGtYuF6X/92rnDMxllc0Wh/Wav4wEK5Ic2ojqaeeXkjYQXu9FEi9dp3HktpVPJIJCG
 URrYFDC7Ons1Kob/TgLNXDOi8PV600tUhfnH4pk4zee4zVmzUKmsi9WT1GZsJn7HdadR
 PHgfvmd4AzeTSVXTfKfsp9Tw6oWesDP/Gp5QCqeMDafdVyVxMxgtHSOVo3U83Npaykj8
 nshw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgbLyTpVxZBkZGJD9ki5Hmk4x3L53nYzCfaAZ336ZGcAPbfV52ivuQCVNmUbRyNEgHf/OZcEP5pUA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwojNVQD676+Sh81wtTlXho40tAZEXjkWKaS/pMrLZ4pZLc1pDE
 XGtzjh+dUoQVGvrNvJX+TX0dyaRB3lxcBvmfmAh0WMstjiSNkPJF6Y6g6cd5VgqSwG2WeqI8oyd
 BM/ZonYRzeeR8nSbqpOz1zO3WqMJ1YvghUdI6MWC2kI6qaZNkHod1UcUZP6mn3XoaXuwHy/A=
X-Gm-Gg: ATEYQzzt2/y19uYb+BlADFbv2UA4Nmo0y+xclNX0Ck6zTz5fOd00KvB0mL6iZFuL8kz
 Ybd7CWpEiOBScYel212wnic2yDz1eNE8fNwVIeucqCLv/aZIs2LzPyJ6BlmxsYzlNccL5wFTISZ
 PJDJk4vauWfgHQuXBYUzUnt/dD+Vkzs51KPDB6TH+F7t9RU7HdGcA6s/IcbIBPsyFBxxuCgLaAq
 ZcnaonGtBuJTh8N7q5zQ6a5m2RvejwYMLzQkHOxUAaBaduyJPa10wpDbBqw8p9sBMbEtZ6Ktwu/
 npeYJeQb6+1dWFtxndNqkS4ryi1MZooA4DQQBjXyee3IlxdMKA0+kRBMEt+DiBfzIycnUvBvico
 TN9S6LLNu2vmPIZWidXxZxx4xC8safMJlAgnoiFX4HgLhUgpIS9Jsl0MOLcJNZH3qiwDap4Gslk
 LdF6hhpXz6yIMuvk5FWw==
X-Received: by 2002:a05:6a20:3d10:b0:39b:e789:7d06 with SMTP id
 adf61e73a8af0-39ef774e39amr2521048637.51.1775026019379; 
 Tue, 31 Mar 2026 23:46:59 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d10:b0:39b:e789:7d06 with SMTP id
 adf61e73a8af0-39ef774e39amr2521006637.51.1775026018900; 
 Tue, 31 Mar 2026 23:46:58 -0700 (PDT)
Received: from [10.133.33.140] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76917db770sm10549869a12.32.2026.03.31.23.46.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 23:46:58 -0700 (PDT)
Message-ID: <49dae108-ad9d-4931-a10e-810de5766790@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 14:46:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/38] drm/msm/dp: Add support to enable MST in
 mainlink control
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
 <20250825-msm-dp-mst-v3-18-01faacfcdedd@oss.qualcomm.com>
 <ahgabnh7e2zszqjakexr4755orihk6afvqlyw3lvcffyvr5muw@hmy6kf3ociku>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <ahgabnh7e2zszqjakexr4755orihk6afvqlyw3lvcffyvr5muw@hmy6kf3ociku>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA1OCBTYWx0ZWRfX+oJNx5z/z08m
 +7DzNcWh/2Yn3oe9P2LUC2/5yjLBwinDIzBBgfKjZ6Khveo1/lFi7EVcxAGRkWfTQCJBdanxmE1
 uNk6qxRb9EV6s5B0UY+ZkPNmKHOPt8uZR+l2pvc7XT4wqQmDA0MV8/quhPeM72sagLtKnxwxcEI
 u8Nq+dX4OzOj/BAOpXwVO1iucPWKAKlNAaM5zRDBXJJN7fKXxf/naz9+NVAobfNMwS/f3Tduppb
 NJf6NJg6I34pPY0K7NxzIZIE+7wAxEzLvZbIXTq/ZqhWTyHNfzjzw6F0TYY1U13v9UxKBzLfqok
 bYjEF0/el7xokiuPovob10NYXMskUqKolRs8hNkyjm2Y9LxCy5JiLryVyX7VEfSM9WuCAJnhfh2
 lMeN0biG+LVAGz+P0MchV0LHXS9jPkOkIyruGtfbTSNNGCJUf0Q3Aqw/KfpvuyPzFeWI/zk1ak3
 eBszBV/FBn6r+/ncg9w==
X-Authority-Analysis: v=2.4 cv=KNlXzVFo c=1 sm=1 tr=0 ts=69ccbf64 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=0OcOfTFRHD3XvKAs1WQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: HUgdyY_DNda68JHar1-Jb3ylSEahNJW3
X-Proofpoint-GUID: HUgdyY_DNda68JHar1-Jb3ylSEahNJW3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010058
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



On 8/26/2025 5:24 AM, Dmitry Baryshkov wrote:
> On Mon, Aug 25, 2025 at 10:16:04PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> Add support to program the MST enable bit in the mainlink control
>> register when an MST session is active or being disabled.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c | 17 +++++++++++++++++
>>   drivers/gpu/drm/msm/dp/dp_reg.h  |  1 +
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
>> index de3d0b8b52c269fd7575edf3f4096a4284ad0b8d..fda847b33f8d0d6ec4d2589586b5a3d6c9b1ccf3 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_reg.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_reg.h
>> @@ -128,6 +128,7 @@
>>   #define DP_MAINLINK_FLUSH_MODE_UPDATE_SDP	FIELD_PREP(DP_MAINLINK_CTRL_FLUSH_MODE_MASK, 1)
>>   #define DP_MAINLINK_FLUSH_MODE_SDE_PERIPH_UPDATE	FIELD_PREP(DP_MAINLINK_CTRL_FLUSH_MODE_MASK, 3)
>>   #define DP_MAINLINK_FB_BOUNDARY_SEL		(0x02000000)
>> +#define DP_MAINLINK_CTRL_MST_EN			(0x04000100)
> 
> Why are there two bits?
> 
Bit 8 enables MST, and bit 26 was set to select the required ECF endianness.

27:26	ECF_MODE		MST ECF Endianness

                                   0x0: [63:56], [55:48], ... [7:0]

                                   0x1: [7:0], [15:8], ... [63:56]

                                   0x2: [56:63], [48:55], ... [0:7]

                                   0x3: [0:7], [8:15], ... [56:63]

8	MST_EN		Multi Stream Enable
>>   
>>   #define REG_DP_STATE_CTRL			(0x00000004)
>>   #define DP_STATE_CTRL_LINK_TRAINING_PATTERN1	(0x00000001)
>>
>> -- 
>> 2.34.1
>>
> 

