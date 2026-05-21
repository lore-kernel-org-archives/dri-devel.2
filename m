Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52874CD343F
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 04:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7444C10F1CE;
	Thu, 21 May 2026 04:06:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nsFG77XR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J9wo28eP";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0A7210F1CE
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 04:06:44 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KKjZEU1797936
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 04:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mXPHU0FSRkb8TWkVq85RVfc/tLbj+oz0zmwBY3S5Ci0=; b=nsFG77XRomQZ5EVO
 3eaminfuvOUUAo1/jTAdjwaY9cyGse1+haGYj5D1vncUdyyniiYUiTZqfPORktG4
 u7PMwA2MrBsDQxyoTGO8jkWI2nBLBN3pAYg8cP7ejmW7uFDT8mMiOXGDBo4FHa8Y
 DWsI3yxG96s6IMO24my4r1IC+eU3cLS5VGYEABWGLjZyLtpjIRPYWWD334G80bI6
 oOpABhIxCU/7b4otY41p8DGmhJK8+s6U85jaIfmTle8UZ9U1Ap4MsJHqmIcIbxKg
 dOMAvZrsWFv1bY27EmSC1+r9MPR7y2bMI0cLT6R3oAZCotXfsZTdKZEnsy+Q99mU
 YkbzFA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9dxu31bc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 04:06:44 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2be9e0905a9so6188265ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 21:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779336403; x=1779941203;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mXPHU0FSRkb8TWkVq85RVfc/tLbj+oz0zmwBY3S5Ci0=;
 b=J9wo28ePngdQuccXDBOyrxZqD6+DnflMvDT1Ge8jpqGCbjK0MHDZOlW2P62oC++NcE
 3MQuDZot5+3cAQpoeJ3OHhBs5LYBAjEetTwT15EZQ3Bd26l58AT9UhXf4xTuL2sAlEc7
 NVMGeC8evO09ybRCgp3kK4NPHe0BJE4mH8ke/aHy4lzyErF/k4LUBojBHD/Rwm/wyEJN
 QN2JDKpIVGkPC3g8oXk7/nI0DTdtBTu7Fd7S6XF/QNhR7HPG7oqFq6TC5Wv3isXLL/Z+
 QLHKPjT5mMpyLPHcSD+B0nH1YVFTK+6qY8bAASI5l4hVK/L7dUAWuGsfwqhDyTB1cRGY
 wnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779336403; x=1779941203;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mXPHU0FSRkb8TWkVq85RVfc/tLbj+oz0zmwBY3S5Ci0=;
 b=E45N09+p6nyR5DKWn4uFIN5AnV8jqq2TL/XA6fjnfYY4pVsqRjZVHly8/nGTG17755
 9DcMQ+fl/CjZCNysvRhGL4dW5XMoGkFnh+gqGOo3OFKUwHlOwy93UJoX/9fjXLtFYh0T
 NBZjdl0fXCBYBVicEyiQwhkUZecVf2ZWCHpiDOCcArDMy+wLUOkUqxewlQgot+77xwM0
 KLAtkqk5CUbPl7N46UytV+wS10RJI7UfTCtcFYcfxKvpTongSJS7OcjkwVRnHnpnlX3Z
 TJ900mD8FlNQrLpFip5/OLwaHWmimiix37H4If0Z5FhgsAfWSuUO4lqcByKU9C5koIe7
 fi5Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9plqgly767AEq3F7ki0uWe46b0SHFR7Wd0hygEP6paYfTZSqqWP2gcZbBFKi15Ru7zXGNdfH0HPgM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxVtwczGYddD2RaP9LRkxeYsOJbELes40uAPIvcfzIPTfKP+DJ
 bIpMUNY3nboZ2ZxrT69Q2sF1CqcdXewvxGYSs4whwnJw8ZaXKRc6But4cGILCBwCfY8KoXUFYge
 VTvOnwOvWVsund6MyElNdXWwsA7wE5w8RAp3/VdSmyqrXqWSttWB6UKEG8qS8mcMLx3fjx4U=
X-Gm-Gg: Acq92OEI3YnyKcm47qG+6SrW9f5AvmQK9wmx8lY9lKqfr9zcacdmaA+Xh6fTukA8u/p
 5tW9up9ZCfacuU8q41V8irac1BZswfhaVlUV2HUIKNeHuF06uBRW0YoLuDX90cm6guN+mvO6u9U
 igv6+NONisxpXwPS3BeinjpwUDXg52740bzW8qrq6KhbvYl9D+dpcG9IDNZrzhWwiybh7TZb6K/
 JGFMqCw5UTZG7zz/w1WJc5qTOL3ZXsOGQe507s8ayKiLrFQ1pLNsEQiSuf1u8w77j5BADVEC//I
 RntT7e3AiwjPsDCDUkJ8+8KcniPkX+CN8QY6yBRgco0Monse5QfgZFoQJp5qvK8gJ8oeNzJYUp6
 NnfFcSjPeDorh07GSNeLKOLZ0nC0QelVYk/Mu3Mu+J+nplGHXeug=
X-Received: by 2002:a17:903:a90:b0:2bd:ef15:9fce with SMTP id
 d9443c01a7336-2bea3345f6bmr11166935ad.20.1779336403380; 
 Wed, 20 May 2026 21:06:43 -0700 (PDT)
X-Received: by 2002:a17:903:a90:b0:2bd:ef15:9fce with SMTP id
 d9443c01a7336-2bea3345f6bmr11166445ad.20.1779336402878; 
 Wed, 20 May 2026 21:06:42 -0700 (PDT)
Received: from [10.206.108.31] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d125159sm224568425ad.76.2026.05.20.21.06.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 21:06:42 -0700 (PDT)
Message-ID: <40f5320d-4b58-4e99-b7b1-d52d09c04127@oss.qualcomm.com>
Date: Thu, 21 May 2026 09:36:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/4] misc: fastrpc: Add polling mode support for
 fastRPC driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: srini@kernel.org, linux-arm-msm@vger.kernel.org,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de
References: <20260520065047.3415790-1-ekansh.gupta@oss.qualcomm.com>
 <20260520065047.3415790-5-ekansh.gupta@oss.qualcomm.com>
 <jtqfnly2ma56gbdstyk7exk4lhw5nild57uyokkkgrtnnqqscv@xik2phrs4v6t>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <jtqfnly2ma56gbdstyk7exk4lhw5nild57uyokkkgrtnnqqscv@xik2phrs4v6t>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDAzNiBTYWx0ZWRfXxtu3UnAoQf0e
 ilBPeXQak5w9zdNaZdLJEvlrYKH3+0mkFMlLHRR7KJxkOxR/zZuAhg1sGLp93Ww2xiNMoU2dCiH
 XXTwM7B/CCOfS1kaaeTUCM1uMl6rarcIq2HvtgRXoffzV8tu3J6T1kuDYZQ3GmxoZZIl5pVQb8f
 diZnw5BAYB4ES4bz3/RrVDMxNhyHKFgabISkDnCB/2JGdOTRDYletf21Ti/23lraB/qbWUtLdvT
 3zlD4ODofhuqO5dhr7GYR5H9UaJti/eRG3wRa4Wy2qkoEJXG33FNvUP4eoxS74NSe3G1Yp3enq9
 bV3UYOzgb1FrmkFNqhpesyG043A1AI6FLvmC+OLqPq1mqmSXIDWgrTTwMm0rCZLhkG2oge/Tr8X
 4BNsjcIGRNBnq7SL1Yq88cyjVyxnDA237wZzs4OdXWFS0mWVrfE7syaLsjfH0tQSnPjh+/M3WCN
 tK+/LFAnY83XWeBeLnw==
X-Authority-Analysis: v=2.4 cv=Zckt8MVA c=1 sm=1 tr=0 ts=6a0e84d4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=G4waM6_Fef8mLlXZwtoA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: -BMjTXoAT72z4t72yIwBr_ijRAgQ5LSV
X-Proofpoint-ORIG-GUID: -BMjTXoAT72z4t72yIwBr_ijRAgQ5LSV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210036
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

On 20-05-2026 19:06, Dmitry Baryshkov wrote:
> On Wed, May 20, 2026 at 12:20:47PM +0530, Ekansh Gupta wrote:
>> For any remote call to DSP, after sending an invocation message,
>> fastRPC driver waits for glink response and during this time the
>> CPU can go into low power modes. This adds latency to overall fastrpc
>> call as CPU wakeup and scheduling latencies are included. Add polling
>> mode support with which fastRPC driver will poll continuously on a
>> memory after sending a message to remote subsystem which will eliminate
>> CPU wakeup and scheduling latencies and reduce fastRPC overhead. In case
>> poll timeout happens, the call will fallback to normal RPC mode.  Poll
>> mode can be enabled by user by using FASTRPC_IOCTL_SET_OPTION ioctl
>> request with FASTRPC_POLL_MODE request id.
>>
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/misc/fastrpc.c      | 167 ++++++++++++++++++++++++++++++++++--
>>  include/uapi/misc/fastrpc.h |  29 +++++++
>>  2 files changed, 189 insertions(+), 7 deletions(-)
>>
>> @@ -1813,6 +1907,35 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
>>  	return 0;
>>  }
>>  
>> +static int fastrpc_set_option(struct fastrpc_user *fl, char __user *argp)
>> +{
>> +	struct fastrpc_ioctl_set_option opt = {0};
>> +	int i;
>> +
>> +	if (!fl->cctx->poll_mode_supported)
>> +		return -EOPNOTSUPP;
> 
> This is being handled too early. What if the user passes any other
> option?
okay, right. I was handling this with only poll mode as an option, I'll
move this after request_id check.>
>> +
>> +	if (copy_from_user(&opt, argp, sizeof(opt)))
>> +		return -EFAULT;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(opt.reserved); i++) {
>> +		if (opt.reserved[i] != 0)
>> +			return -EINVAL;
>> +	}
>> +
>> +	if (opt.request_id != FASTRPC_POLL_MODE)
>> +		return -EINVAL;
>> +
>> +	if (opt.value == FASTRPC_POLL_MODE_ENABLE)
>> +		fl->poll_mode = true;
>> +	else if (opt.value == FASTRPC_POLL_MODE_DISABLE)
>> +		fl->poll_mode = false;
>> +	else
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
> 

