Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4A7F8D74B
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 14:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1260F10E8BE;
	Thu, 16 Apr 2026 14:02:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="K88paQfM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DqBBY31Y";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6232810E8BE
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 14:02:53 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G8YY931702831
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 14:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lK4ABVEsh6vQVo/gXF6kYceIrK1uJbLooD8HSUD9HiY=; b=K88paQfMfy9cAtk2
 kzMbi/YdkaDrgPNwIPQdzDhZWgqOjhYwuwfNHKEgk33d09bMdZl4Jn1gEWXtCIWN
 xM7vM0Nxi3aycorwa1zAfmTBHGb2SgsewN/TnguvOvzP1WUe3qWTz5cTqu2FUcL8
 1TO5E1xZwik8YQNb4VcmGuK8Ln88CXRyyhhuEamnc3wtzBZwgIJ0rHIR8DhH+r0C
 fQBMA0qd4i3yNWUtAprWcS94JZS0gdGZDwZSMpnobI0RNIGa6c1fcYSQNmo0DJJl
 HiFPwVrpWTmUb5C6NaxcFEqCepv4ygg6L6mSIfdXRuAM810/1x0ng1rRs2s4ojF+
 0mwn9Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djdamm308-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 14:02:52 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82f780a13c9so543292b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776348171; x=1776952971;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lK4ABVEsh6vQVo/gXF6kYceIrK1uJbLooD8HSUD9HiY=;
 b=DqBBY31YEdR82f3KxuvNM9Ybtx+x5hqJqKL3U+J0eij1hTwlx16amsiulHHpzBuGPc
 An4FBeqTLOZdIDJjyLdR7rzBXc8Dxn8A+mWarM1JntqP2XoOjI8YSxwrvHKK127lTVez
 w9PY7ZiNalEdk1cOpuuLuUDdyyHGqhTTsE6Ku6qjr69o7KrL+5GOiXEyfS3UILngArgU
 g0KRAn+3+DTgS4eiFfAYgSo15gmbE4g+lEgjGHzgTRwsyGAL9uugtXVgKesbYST3qjJL
 p2Im/lbJynT3F0g+MwkXCtMIFk/EUQj5/fLaJ8IjaTY2RHQyBzfK7/Xym9phpN0tlB1P
 kFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776348171; x=1776952971;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lK4ABVEsh6vQVo/gXF6kYceIrK1uJbLooD8HSUD9HiY=;
 b=f0Sn30SjVWbx80hEq0azgYy88caQf9rVt/COP1RVd4QTxIPiBqMGW+T0S9h18gKw+E
 Kttf9tHZvdVkTM3XpmaWg2UjXhotb/VBZGRFULKpOuBR9BkwA35uQTV0q+VzBmgBqNSE
 ozuN2bcP0ClqTDXOuHL8AZDXU9xS5tr+aMZoXxILAlqs5aSqvSl0iiJzj0EcMHDqzGJe
 lilwU1Hme43FpgFxZ1uRJYeB6b+9HFbHMZNtkQ+QbzUVUiR/2Au9ih8JG6cVePX60+bD
 akRc2/mB/lMePDJ1tjh3lLa6Xbtyb5Ar9DyRF/YerfeWjtMk0c/362nLELD1yJIgTx6p
 XeVQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Dt/Xh82u+Aj8fnZK7uGKmjFF8qcZAHx4apqYWF60ExEwBKvQHAOwqzvq3E5dsiyhpnuhG9+jNhnY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfybNR+XMUNrtHv6NzAbnhiW62PW3QAKgpc5+Mlijx8tNqKWPk
 YOJ0nuGPXyq/BOw0jvwd14sMEoYR6c3NXTjvB7TMLSr4okEp7NQy0HF1PneFOHnJ+BTFettw3ws
 vfEw+4bYLBOHfmtfcyOAQvZJ2b9PXRFuja4CawQ2gsuqqCwXJVUkgZfY3w1sja6i+LUggEWU=
X-Gm-Gg: AeBDiev+eXgZ/SeSVGZr41nvwNchuwJNkJ9txInPVbRB9sY4nxlQyN51DZ80HB41tPO
 DejE9ZqlbTANq6/PuY2PEegpIUHwcrx36KFr2olgZJMAqKdAfGc+jHokzx2GB+smh6HuITrlbyX
 LYmu08mw4Qb5asM6AVclP1qXYonOMl4/Yk1yNmxLxw9xsGEqCQe1Oc0SLenWUivtqEvcm4Caa3V
 5mZIad1nEfcemxtVaYtxR1edNFNX7/jrvDACg6qoeBYTAfe/+y01YD9CoScf33gr3Ty1nQ2wZS0
 RDIAKfCavvd1DAlp8nnD24uUE75/2o5APPH/zY0CZ6FphW/noM6yxdmu+VAtSxat2a9W+Yd6UZ4
 AUWaeRSlQA/xgjvUcgmKm/0kwuvetHuIlzo4nhG3kQPyLi5PUodAy1AwuOG/aFw4=
X-Received: by 2002:a05:6a00:4308:b0:82f:6640:7221 with SMTP id
 d2e1a72fcca58-82f764f632dmr3315536b3a.22.1776348170757; 
 Thu, 16 Apr 2026 07:02:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:4308:b0:82f:6640:7221 with SMTP id
 d2e1a72fcca58-82f764f632dmr3315466b3a.22.1776348170039; 
 Thu, 16 Apr 2026 07:02:50 -0700 (PDT)
Received: from [192.168.1.10] ([122.164.36.130])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f738b399bsm3451789b3a.8.2026.04.16.07.02.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 07:02:49 -0700 (PDT)
Message-ID: <0bab12c2-48f3-45a2-a87b-b33b60b5a7df@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 19:32:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] misc: fastrpc: Add polling mode support for
 fastRPC driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: srini@kernel.org, linux-arm-msm@vger.kernel.org,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 konrad.dybcio@oss.qualcomm.com, andersson@kernel.org
References: <20260415112530.4083240-1-ekansh.gupta@oss.qualcomm.com>
 <20260415112530.4083240-5-ekansh.gupta@oss.qualcomm.com>
 <ymieeagodsfbygq7fsejsqriajmncoubzvor7t3ll6ntomtbeg@l65yihnixwbu>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <ymieeagodsfbygq7fsejsqriajmncoubzvor7t3ll6ntomtbeg@l65yihnixwbu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3RxHFUSbyrR1LAKs4eA5sQq4i03RjyL5
X-Authority-Analysis: v=2.4 cv=HMjz0Itv c=1 sm=1 tr=0 ts=69e0ec0c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=XANuBpsXGvULjGEGCPeV4Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pm_eAs2JUF_NPnZ18oEA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 3RxHFUSbyrR1LAKs4eA5sQq4i03RjyL5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEzNCBTYWx0ZWRfXxTPsE+Bf4OvG
 mkoTfBi4fnjWPZHKJPJird6IkCCCM/xt2jqEImZzMlV3Tx7sda+GTtYoYWS/CY9Z+pBmkBMlgwK
 a86a9yLzExHYO64/RoaSEj/FM7uVA+5wZveCPefr05uP0B4msYPw8KYOfOUDLR7dUipxDNSm51z
 l6Glv58sXxMtaNBxY+/oToZQX71LeBMt2LzkmMxygeyf0GIDCB17tEYt8fCQJ1v4Djswj5hSLXS
 llNAFcKO2osMARL7Oo1DIgI12GNfujAwoTKZH/CrJBSLSUAQ5R6pBX6iZfX6PYx86fMumqKUXAA
 uHDZIvMuOSDGCLzEazCviHQjlAs5B6L4AkWkRStK2IDoB/0vIBa41Yi1mBKz+qtRFSPykZWBTBF
 t/7r5Cd4LtkQQoxW3gjBf+LycvjLHjgp1urDdiHjqtOqmUO8giVF0p71sNdKHoGs4xZll3DjC7R
 7ep7UbbxHxkaOJWIz7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160134
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

On 16-04-2026 16:25, Dmitry Baryshkov wrote:
> On Wed, Apr 15, 2026 at 04:55:30PM +0530, Ekansh Gupta wrote:
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
>>  drivers/misc/fastrpc.c      | 137 ++++++++++++++++++++++++++++++++++--
>>  include/uapi/misc/fastrpc.h |  25 +++++++
>>  2 files changed, 155 insertions(+), 7 deletions(-)
>>
>> @@ -1813,6 +1908,30 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
>>  	return 0;
>>  }
>>  
>> +static int fastrpc_set_option(struct fastrpc_user *fl, char __user *argp)
>> +{
>> +	struct fastrpc_ioctl_set_option opt = {0};
>> +	int i;
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
>> +	if (opt.value)
>> +		fl->poll_mode = true;
> 
> This will enable poll mode on the platforms where it is not supported,
> later silinently changing back to the normal mode. Please don't surprise
> users and make this call fail if polling mode is not supported.
Ack. Working on adding compatible based checks for supporting platforms
by reading the root compatible string, something like pdmapper[1].

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/soc/qcom/qcom_pd_mapper.c#n643

Thanks,
Ekansh

> 
>> +	else
>> +		fl->poll_mode = false;
>> +
>> +	return 0;
>> +}
>> +
> 

