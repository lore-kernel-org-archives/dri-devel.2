Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC3CFEA83D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 09:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3E0010E701;
	Wed, 25 Mar 2026 09:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eEHSLyaQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VUDUnJAY";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5266B10E702
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 09:57:21 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62P4srxg3110448
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 09:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XOwgkkoANNmdVUSLIh1kRTsKKbKDjbh2qaVhE/kgSwg=; b=eEHSLyaQYExMTVTC
 VpdpWhN+6wr/5VBFPNc7tK2uBuRsGU0Xw5KHaLVj7D7KSIIknqtPjLjJm+NMLXKh
 dMNogGNxd+DrjRbVNSACJUSXSeYoPCQtmP3p7rgssBHeucTHg9URswkYoy3Dhvma
 1rhEXSaueUwMpRcuiUh32rJqEHb06DwHBkNsSfnKFYOPMqJb2vfMJBWX79skttQr
 2GlTxbBKbEzZmG5bYbQWjQw6PQaWwNZKf4vGJqdgA4GhbxNFA5vTeHt8ZUnFUd50
 oSXaRwlO5oaH77795INh39tynZTrCuCngxNswFElU6RHV53WQr145TBcDwKPqKM+
 6VeK6g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3vhvuurt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 09:57:20 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89c4f6c45a7so36370406d6.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774432640; x=1775037440;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XOwgkkoANNmdVUSLIh1kRTsKKbKDjbh2qaVhE/kgSwg=;
 b=VUDUnJAYsZAU27KFqPtokyzqM3aQoMFrW0udfWRVGbMqEj551Fcj/dfXTFT4v58D3q
 per5y47P5ndfjTQ5gIIUMwYxCOA9UDbjl661k/rjCqxEODncdKInSVVEX8xWMeEvqSbs
 TWCmLvHPS0JxdsEzcaynyZ759F9lBrEql8u7aI3a86zcNKevwSYHVo2zJEYQslD4VjI8
 vPO8QoFidIHXZM6fKjFARO7baaE46Kva3CcxsoLuvDTvonS12srf6kuxUEPEcTs8IVd6
 5TmR/MlTUMbLfvgVosSryq2aYFs8GfdK8EEPLjCmWTYnS7goNhi0RbIzgRjyQitNYxK0
 BuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774432640; x=1775037440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XOwgkkoANNmdVUSLIh1kRTsKKbKDjbh2qaVhE/kgSwg=;
 b=e8YtyoE+rRoiy7Qqp1RcsJYKbYLViUlZ8oOHhiZp4L/eqiKpfkR8D7qsSPiryS/pmB
 xbq3V+9Wip5N5A9eq28PbDzR9u19Mop/uIM/VX4QPxQKNgcbEHqI7eysrkbD71tinO35
 tB+xevWyUBxddyVkOZTMXRm4mVni8KawJupEJ3gh1fo+uQA53ZCVisFa4kkx4fl8h051
 0/jMMd5XCo2xE3NL5gdfwmGdoC5b5BpyVZnImriXlfB0AcRXhE+aAXi8t+UJVo4ShOY6
 i8jUrfLFdlVilYN8WrOOXCW66zRVFHmR0JGRkxo8O0PtXP+H0I+q6mDq4Acz30l0yxxG
 gIQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlfZK6A8L783bGo7HfcBYpLogOFTns4gmTZ3Hh9Ws54Dpvh1eMMc8+8f8oZWes0vB17DYHC9hjTNE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yysyk7lei4CvUxXH4eCdW3YcKKIT9QMWP8hjBU9+QuwxFpw4BFR
 d8EE2HinSIlrFx677aX9qHs1CPJXZ6tBQ48zxEy7Y7We7UQrqt2TBN8J+dL0CvOjT1PFuf0NWGu
 P30W8scrgLpTLrJe0EKe6BjcOubiHeuuXkOxih2rY31a++xhvXfET5EGS+17jk6HNzpnjt0o=
X-Gm-Gg: ATEYQzw6fwx5qswFCvTmtURotMFiktW7kGl2jx1YQwdwUZhgFxDhGpOnMATINVveLJR
 YTvn72qu8SmyGeBQFR8sNfou9cPRCX1fU/3lyc/WfnrAgjSqxjrDHQn+mgYvrnY11Wq9YRvT9jb
 NikKVcpBdH80RFPeDNGpd+gNVgDQyV1RFMEQnS8/Cn647KrZxqpEVcGhSxr4lNVU39aE/3PmLUY
 1HaH/ObF2lYjqreSk0U6PBmX37gemI05la+SxLYBoqJQJUzwBuEP49lpir0BuGGkmPg7elaTwlA
 k+HtZ7IRol/xygnNCt3ETa0esSGqEOybaOHBit7GLSpbf+4qI4dATCV5fMkZTexL+dIHWo8FlxW
 AucmPbPYsNNG4GRy/7gb2xKUUpV/J9DcH0d77yp1Uk+g8QWJNxg8UQ3HcpBzRvebabfMtnWVuMV
 1c08w=
X-Received: by 2002:a05:6214:2385:b0:89c:64b0:f91b with SMTP id
 6a1803df08f44-89cc4ba1c77mr33529656d6.6.1774432639799; 
 Wed, 25 Mar 2026 02:57:19 -0700 (PDT)
X-Received: by 2002:a05:6214:2385:b0:89c:64b0:f91b with SMTP id
 6a1803df08f44-89cc4ba1c77mr33529316d6.6.1774432639385; 
 Wed, 25 Mar 2026 02:57:19 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b983e4e9b65sm669017566b.31.2026.03.25.02.57.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 02:57:18 -0700 (PDT)
Message-ID: <3f33e61e-d244-4600-9ffe-218371c04541@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 10:57:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dpu: correct DP MST interface configuration
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
References: <20260325-fix-dp-mst-interfaces-v1-1-186d1de3fa1b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260325-fix-dp-mst-interfaces-v1-1-186d1de3fa1b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA3MCBTYWx0ZWRfX6SpYCMFSjUwu
 6P8EmDkdPLjgQco0kYJ5XE5mFE0+7o5jH14sy2+jVndspvGMgXURaBUTzlYlBZKBAh4SH+4YT9c
 mEt7uR6i+Osbh7uR+Da0bMvRbmsa02Gs4IUelzvhf/uc/f1F0QfguBdTx6IHwjMUsA6JZZMOEOX
 xCvRDPWqiasaEwRC3xJxW/y0OU0zy+4bkGMhpgQx5msYphjOE6p+XdY6cMBwMdvLLol5qIxGSGs
 qJc6nVARbTnMeDYLZnEgrInPkb/xUL/iIASkVVOxZkBG9x0Aw2UKmqF4vnf46LsG1DUi/Nq76b/
 53zMblb2LQRijSNbUlUvsB8S2C8g2Jgi+EdKsCZjOpry3SIrFe0VXaLVa5D+o2c49fkxxSMR3r8
 Dtn89gFJj5quylH/YkSugOIT+KzNMnBVjvv+2tf2B9EvLfI4Qp2DhA5FjWpwXT67iLQMHvmbrN2
 zi+SHD/wMgwLmlxpnlg==
X-Authority-Analysis: v=2.4 cv=P5M3RyAu c=1 sm=1 tr=0 ts=69c3b180 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=V25-4Ovv3ou56tOLyxUA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: jGZ9al7t5MYr0I2M5k9M80A7TqPBDTiu
X-Proofpoint-GUID: jGZ9al7t5MYr0I2M5k9M80A7TqPBDTiu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250070
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

On 3/25/26 6:32 AM, Dmitry Baryshkov wrote:
> Due to historical reasons we ended up with dummy values being specified
> for MST-related interfaces some of them had INTF_NONE, others had
> non-existing DP controller indices. Those workarounds are no longer
> necessary. Fix types and indices for all DP-MST related INTF instances.
> 
> The only exception is INTF_3 on SC8180X, which has unique design. It can
> be used either with INTF_0 / DP0 or with INTF_4 / DP1. This interface is
> left with the dummy value until somebody implements necessary bits for
> that platform.
> 
> Co-developed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

>  		.name = "intf_8", .id = INTF_8,
>  		.base = 0x3c000, .len = 0x280,
> -		.type = INTF_NONE,
> -		.controller_id = MSM_DP_CONTROLLER_1,
> +		.type = INTF_DP,
> +		.controller_id = MSM_DP_CONTROLLER_1,	/* pair with intf_8 for DP MST */

with intf_4

Konrad
