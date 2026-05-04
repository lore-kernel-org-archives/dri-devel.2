Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517D2FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 09:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AC4910E071;
	Mon,  4 May 2026 09:20:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DP0rHUCc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fUzkkaFd";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CDE110E071
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 09:20:27 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6448fODV3894058
 for <dri-devel@lists.freedesktop.org>; Mon, 4 May 2026 09:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xacEJq2Zps3FgavLd4lLbebjwrUmMkWW1Dnv6tEkWBA=; b=DP0rHUCcKYKrOTU6
 4+YLLRO47dTK0k95xf1aJjr/zEC1BeU1ZmwbVwTfk2Ye9TPn12j56h1pFtCLQAC4
 KhYDjPtN01UugvozyOjlVSyzEjIoYB66OLruaOmkbrdsR/a9Vhg6Hi2FJsXBmucu
 yDxrMsQbSShgrYKrMJJeQ4yyShtgpm3+qErJTb2VGDsfat2kLJkr6Z+Z4OUiUPN2
 vqKlDgQNzX0Elz9mtysDKTIQ37s/uUxNiXnIutHnNZxaKu5x8xAVTDGN4r3tpeb0
 QZqvOgpCO2l4LK6eoDpj4XlHxYa3zhG6bviZdFoj+kWClXiGFA/uAZT9PvhmihHE
 XA/PQw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw6mpdb5g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 09:20:25 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82fa366fb79so4175715b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 02:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777886425; x=1778491225;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xacEJq2Zps3FgavLd4lLbebjwrUmMkWW1Dnv6tEkWBA=;
 b=fUzkkaFdWmVGG5WcVEIybptGjOTPcwbxpmIpSQ5vjldQ9Kg5R+2rhBDwrWT0ndENTx
 WtZHhunimF1XsQCvXHKeJLioVN3AKeAxXGRMy5JWd7JfqL5CKB4L2ulMQx2yMZfChtve
 u3loubU7x50ImBtHTDvkvt7lgAbXQ26ilNh4ynefKrrFCfbuIwGfVeDeskqyxYhb+v7V
 7XrAXKkdTTOyE5BlC/7y/8k2lGr0XfWuQ4clc4bMNk92s8eIHWjcX2BM/fjj5doQWlTi
 gkLYEC2PA/o6QmXM9KHz5Cfq5uRN4Y6JoYzC+9jHU27OSzslG5mdg0g3cF8EJIAwoa91
 4x8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777886425; x=1778491225;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xacEJq2Zps3FgavLd4lLbebjwrUmMkWW1Dnv6tEkWBA=;
 b=IQCFlSbNuZQep5iPDWvGYH848lRYcJYk7DQ4CPivQ+/+UTjTORT3t08H3oWK6kpzLq
 gNZjRe+8fFGPsiI61LOVPdpA4V1nHofo8Y/K36JrKTxykeE6YKZi0opwmMTALwfzVOj0
 mFhPTQvEL9+HWfOFd4rIO94vowq/k80NzL3us4CY81GhgRjt/Y7wOPvn0S3CHIemjIXt
 Ig7JQf30zw8tT++8dsrKdRrsc1toncGdkfvgX+5ZyQWXBOecT+TbF5yxHbF1BoWeu9la
 Lol/+VpmjKSmj6c3bT8RtS0rQ+h1Q8Aoim/hhNuDdo0W98TZw8ec5bVKRIyeb/I7TeIF
 1oWg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+riwZhv4kNdMotaNzQjIi+8+kZ7SGg3PgCWJSNUGV/0sGcvau2XYVOdUABkYcW5PCIi1pe6GEl2Ok=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYTwk0ksM2V36lBErUdm5jFWDznHzUZW45PFyNjDoaoOulvupu
 HOwYdX3tqSmBK+BWECpC90P0C/H64KFPYNxKVkHJ7bUV6trQQVEgm7YE+Q0WGrjzypa/p7Q3FkN
 WjX/nD9982dQ4cpB+oUJALBgQYjOApEcHHzcMsGkUVmFuXjyJUjeyy897+EstwPZv8vUTqo0=
X-Gm-Gg: AeBDieuTVQ0ca4XFJMDrQSwhpa6J4rq6Py9/GY1wJ3TEjrm6YzRrLQitODy/u2xt1RV
 6aBCoNT3g/s/QoztZfyMmgJJc0zZRphn6uYG8d3YSnHWypklYuT3I3+VKxvJschITxq+Ny0FE3S
 Ix+KDVeODadDAaU+eeN929U9he642LzHDuyx3VBbytjizRtD9W/HbvT1toTHRINNmeWbYOAsSsA
 IQKvpo4+fSYKkmsW4neeAv90XAA5G9+ZijRcKEhVuhjNO1ge0x90TR8EaNeQYYuiHc13+8yhXiz
 BnJzuxg+HhzYfRLRSLn+Oai96ESbj9waIE4zyeT1r//NRS79WBKNqXS6g4lkmThV2aWBvDTmO1R
 KWlid4O4VpPzgZ3rEtFGNePKlnGr6g6zogKbeNYLAXjERyR729VG+Fjt1mU2nbQ==
X-Received: by 2002:aa7:9f07:0:b0:835:388c:9764 with SMTP id
 d2e1a72fcca58-835388ca073mr4931603b3a.37.1777886425021; 
 Mon, 04 May 2026 02:20:25 -0700 (PDT)
X-Received: by 2002:aa7:9f07:0:b0:835:388c:9764 with SMTP id
 d2e1a72fcca58-835388ca073mr4931557b3a.37.1777886424440; 
 Mon, 04 May 2026 02:20:24 -0700 (PDT)
Received: from [10.217.223.121] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83515ad0049sm12316337b3a.33.2026.05.04.02.20.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 02:20:24 -0700 (PDT)
Message-ID: <81d83991-df25-4fc4-8261-6793ea9dc438@oss.qualcomm.com>
Date: Mon, 4 May 2026 14:50:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/15] firmware: qcom: Add a generic PAS service
To: Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org,
 apurupa@qti.qualcomm.com, skare@qti.qualcomm.com,
 linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-3-sumit.garg@kernel.org>
Content-Language: en-US
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
In-Reply-To: <20260427095603.1157963-3-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H6rrBeYi c=1 sm=1 tr=0 ts=69f864da cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=DWWpLck2SfFL7czMIZ0A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA5OSBTYWx0ZWRfXw6m53d5hIzpr
 EBg75riaLTdRqt+x3ve+cyLEgtZua6ximPADkh6Dlk5AHuEf1PiFDoPITI/jOJvEtiuINhL46x2
 HMFqQW5yaNZM1aq2uhf98UN08MU2wMejowIb1scv9pCRKvJSa4R6yrC79cd80mdny10Y61bHHMU
 PMCY6laHfCHdCMHtXpvHwxFguR7ACzniRdEWDDDQ3xTNS+H1qDyn2ByPHGdFqk0hykgwy5E5Dnu
 8IYETwO8YgeUDkKjYvaU0vyk2cgLL253ARKA3VC3fjZTvGvTiY/XZB+INZIeV0BwA0O67lJACtJ
 3oQb56ffR9XcpMSJP85McYw76VYaoilzV+m8xh2hm1lZ8kEOycr5L9J56/NJ0pJuPSK5P50bmAG
 ek9/oRNwbaK05RasPbZOaBUY5+XdOFgk0iJOrTqaJCa1MRe7cIRsWT+XGuVnSyCIBfr4eSNt15q
 P3W9r01Nv+zayKtnobg==
X-Proofpoint-GUID: 0Z4YZ2ygtwBp7JVy_5hGqBNqcZeGvWfa
X-Proofpoint-ORIG-GUID: 0Z4YZ2ygtwBp7JVy_5hGqBNqcZeGvWfa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040099
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



On 4/27/2026 3:25 PM, Sumit Garg via OP-TEE wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Qcom platforms has the legacy of using non-standard SCM calls
> splintered over the various kernel drivers. These SCM calls aren't
> compliant with the standard SMC calling conventions which is a
> prerequisite to enable migration to the FF-A specifications from Arm.
> 
> OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
> support these non-standard SCM calls. And even for newer architectures
> using S-EL2 with Hafnium support, QTEE won't be able to support SCM
> calls either with FF-A requirements coming in. And with both OP-TEE
> and QTEE drivers well integrated in the TEE subsystem, it makes further
> sense to reuse the TEE bus client drivers infrastructure.
> 
> The added benefit of TEE bus infrastructure is that there is support
> for discoverable/enumerable services. With that client drivers don't
> have to manually invoke a special SCM call to know the service status.
> 
> So enable the generic Peripheral Authentication Service (PAS) provided
> by the firmware. It acts as the common layer with different TZ
> backends plugged in whether it's an SCM implementation or a proper
> TEE bus based PAS service implementation.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>

Regards,
Harshal

