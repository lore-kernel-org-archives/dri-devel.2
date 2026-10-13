Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7CCCC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6CA910F537;
	Tue, 13 Oct 2026 07:34:15 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA8E410F52C
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 07:34:03 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D21CCq3054805
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 07:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QnAC6pQZmx6ev8l+Wp+rlXv2fKnslv6GIEdOe/wgt2c=; b=fW3Xb6UihFx/p3nu
 2EU+C8tK+z/QiS1kMwZkprRe2oeQ59jH4En/YRLLLEOKjk9ThaCBP9qcQHjNslwo
 AH2hzvaoIaRZ1WymPV/XeuADZGoMgSYJOCcYvNWoU5nJmqO7jgz4ebPKY5FQQU2v
 Ka6r0s5syiTksNSB/AhmqOmcHy1dZnyms3h5Hrb0HwtKStNzhup8zEJUN/jnmX6A
 qEB7hgJqc0DGuid5wqQFRzH++NVHZ3CYGq7thi4eKeuqZE8GoqmBBti8FAEmc1mY
 iVWwAZv59mUtdLpzRqgyoLdYXOrqznHBtXxE0C7KqCK+jzKpkgS0140UlltDSOm8
 QJEh5g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h93aeu2bc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 07:34:02 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3a89dd31fdaso2325841a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 00:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791876842; x=1792481642;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QnAC6pQZmx6ev8l+Wp+rlXv2fKnslv6GIEdOe/wgt2c=;
 b=ftVIYC0k/WiH6mww+u988wNFFDf4Kw2jdjOaY6MHg8UnR0ETItmoC6+vba0VSjDhVL
 rVe5kDBtyWU8Kf9tUNTuZfiSKOQP2gOrNRw0n+8pQQ8Xv4lQ9RMh6tTgn3sHM1yX4nrB
 /Lrn4tVRakKSNxrPfQPtS5txlFdRJxVTE+Ti25xdR/Eh9gA/RoLOZ054kaSBXSp+8wUs
 VChoW03qDsEAKYeOlpiyPgd9NYTlL4Sh45/YgAg4h2kpQtVENcmRKFvQ/w/Z6M/bg2b0
 BG4WzyvYJ8SWSdECk+i6qew/+7c928N+NqouqL2QMZGTj0DtvAKZw4Y7ziZVsE93+6aT
 h1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791876842; x=1792481642;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QnAC6pQZmx6ev8l+Wp+rlXv2fKnslv6GIEdOe/wgt2c=;
 b=VAKd72/Aky9S0sZK61NQDjYBFuOX75IezqECLd5wypBNovLOBEF9Blwre5XWzYIUGS
 ZZ0GcYD9sfQWMSptRPeo8jujGrE9W5bcPNWpUHt5XY29nSo957d3jvwdsq2Ow/PTjGrU
 dfwU4dWXc9tkB0qEmvOF+i9WRTHdqZGPzIOrXiYcdeA3j80DBhcnPRtm+QP7PldPlIJp
 F8kmpEmVWaRFWqrBqywB/qyRbWwjgSt2CnlkgqyzhmU2kgAFuM57OiC1K1P8EUBDhq1W
 KBs5kjqGZtwaFRiOmJurx4db42lRnFwRmX5GXnnHDo1wVIjsz+Sep6LpkiEY7XJ2WSc5
 6M7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3dBgRlz/S/RfhDQoDYqkQHs7a0PByV9B4AEK4oPkfp4YKetu8iLPPx5hJtmpDcUjoRKVL8I2UMTQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJynPxDqVg2AURL5wn0Htyw1a4wVwuYDxZlRuI4/aqQR0TWCIq/
 L9LTLnPxRBwytX0RL5H6DalnVwjHkHaupkW6przWulIi+2wWzMB6eo0pLyl4THLPopKKCxdjQOF
 GIbow3I6os9RLuIg/EY79fgVO1vz/VGLxRWtcsJMFdw1jhqwbieVS9CqeXX0SRJNMU9g2ibI=
X-Gm-Gg: AYBFou2WedAndlRLPAY5oTXwrcDdAO0o37kRS3R+YcpmOiyvkwBzyxg7FPQR/o03wVB
 2bNA3tHHXgy3/hktagj1sXma21qCdKMtAmLb/McAJ3SIwI5zFDu5IdRiy38GnSVeiB5IYUa+Zlf
 sN4x1bGs/iovDXZv5fVCqfElFH3JXZlt+2gTKxuYBOg3jIeiOdhTIahz1LAX0FlnJMvPjs6KXeC
 ZeSnlkR0TLnxHjr+evhwUDtBg+S3oGxf7F2KyFEreY+P5dPpmgoAJhpt2bbejTNHrertJOuHTx4
 XRgSIOGRDEc4AAuidQHdfOFonGgjhKnJqTmmpHE68shEboqGpkhaZ9weKkO/Zpd6eNxlNCUFyB2
 dunhZcveQUZIUnhSl0t3Wgy47/vQ=
X-Received: by 2002:a17:90b:4fcb:b0:3a4:bbec:b4b4 with SMTP id
 98e67ed59e1d1-3ab3a94c1efmr9124394a91.26.1791876841659; 
 Tue, 13 Oct 2026 00:34:01 -0700 (PDT)
X-Received: by 2002:a17:90b:4fcb:b0:3a4:bbec:b4b4 with SMTP id
 98e67ed59e1d1-3ab3a94c1efmr9124362a91.26.1791876840939; 
 Tue, 13 Oct 2026 00:34:00 -0700 (PDT)
Received: from [10.204.78.62] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab371e2833sm20926517a91.17.2026.10.13.00.33.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 00:34:00 -0700 (PDT)
Message-ID: <0752c7fd-4746-4260-bc24-3e8785bc936f@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 13:03:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] drm/msm/dpu: rework layer mixer allocation and
 mode limits
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261008-lm_fixes_final-v4-0-fa986071c3c1@oss.qualcomm.com>
 <ahg4xrildtnicph5ecwknrxqwkct3odcjkfnsc6ehympy6y5mz@ddwmentwnuth>
Content-Language: en-US
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
In-Reply-To: <ahg4xrildtnicph5ecwknrxqwkct3odcjkfnsc6ehympy6y5mz@ddwmentwnuth>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: k6t5BkMlkxnAURaDaLjRtlhYH_r_JSKd
X-Authority-Analysis: v=2.4 cv=JJuuIMKb c=1 sm=1 tr=0 ts=6acddeea cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=z6WxN8cy-vpheZIcWT4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyOSBTYWx0ZWRfX6RnCh2RIQe5B
 sbcc2C+HKeMxHZbF0C8nuQlDM6mKUYQZ/mRYfv4MirVRyF9D6i7KbO0qtFgEZYpl1GFNuiz4guR
 txk5eBhZMP8DiA602/TanXG6Qd4flAs=
X-Proofpoint-ORIG-GUID: k6t5BkMlkxnAURaDaLjRtlhYH_r_JSKd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyOSBTYWx0ZWRfX3o5ecIeaU920
 vdI53xjBLOSIRtFzvCQiYkxMgq5yy22uYBwS6ZegCm0UlCNmwetlcxAgPeJYsqP5kHc9gx+6e3v
 JLGDqMzSM3xPDT+m6hAE+qqVoqVnYaneh+eR2Y2JFXRqN5IgbeKvSZOOd055v+hcBM7fl7lEUAm
 +un0s+X4LY4tQFD87/xZeeNHgo33nXSxFKAe4d46TYSZuI1/FJUOUSSQcLMkPB6jXgVn5+MaMGj
 Pmq9+/YUcRnMddVeb1bBBlI3cMZCPXtzM/tnIvHL/KuQPJmZS2E0v1LncbNxJDSm4wZJPqwA450
 7dj5UfhelXcIq3wW6/1jANCm13xEUmHTArKw32d5nx+GUJ+bH1YPr3g/lPWcUXJB52QrHjXqzft
 oqTK8W1uECOpf4UWQPGc4K2pWbIUNhXH05atJqe9+WIhFs+EzAE34hdBLUnvWB5P6svBD1zPtK0
 5DTslOc73+PVtBAY+2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130029
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


On 10/12/2026 5:35 PM, Dmitry Baryshkov wrote:
> On Thu, Oct 08, 2026 at 10:53:46PM +0530, Mahadevan P wrote:
>> Currently, the DPU driver bases LM reservation off of the maximum
>> supported width for the layer mixer and an arbitrary MAX_HDISPLAY_SPLIT.
>> However, these limits are not hardware limits meaning that a single LM
>> can support higher resolutions.
>>
>> Switch to basing LM reservation off of PINGPONG and DSC encoder hardware
>> limits.
>>
>> This revision also adds clock-based mixer selection and a source-pipe
>> width guard for mixers without source split.
>>
>> Assisted-by: LLM
>> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
>> ---
>> Changes in v4:
>> - Rebased on msm-next, resolving conflicts.
>> - Added clock-based mixer selection and reused the helper in mode
>>    validation.
>> - Added a source-pipe width guard for mixers without source split.
>> - Extended the catalog cleanup to newer platforms.
> What was the issue that caused display breakage on the CRD as reported
> by Xilin Wu? How did you fix it?
The v3 change allowed this mode to use one LM because its width fits 
within the PINGPONG limit, without accounting for LM throughput. For the 
reported 3840×2160@120 timing, a single LM requires 1036.8 MHz before 
margin, exceeding the reported 600 MHz MDP clock. v4 adds clock-based LM 
selection, retaining two LMs for this mode and addressing the allocation 
issue.

The separate clock-validation requirement remains: the dual-pipe rate is 
1188 / 2 = 594 MHz, increasing to 623.7 MHz with the 5% inefficiency 
margin specified by the HPG. Xilin’s working test bypassed that check. 
At 600 MHz, there is only about 1% headroom above 594 MHz, so success in 
that configuration does not guarantee reliable operation across other 
workloads, where underruns may still occur. We therefore cannot remove 
the hardware programming guide prescribed 5% margin based on this test 
alone.

Thanks,
Mahadevan

>
>> - Link to v3: https://lore.kernel.org/r/20260112-max-mixer-width-v3-0-f98063ea21f5@oss.qualcomm.com
>>
