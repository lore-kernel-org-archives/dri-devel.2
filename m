Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F79010D14A4
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:52:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3B8010E663;
	Mon, 30 Mar 2026 11:52:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GNoxgTcW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j/RfPpP1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E12E110E663
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:52:32 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UBEH611402804
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XgZJgX0TxKp/l+YGdpnqFg2Xk4t+k4MwvR0s2wGs6yc=; b=GNoxgTcWeJWByafe
 661K0CzwlmVtN0ciQX/D4P376uw1N3buiAVLaAB7YthrKgLIHnmowfMj0r6oXVdS
 QRedBV28dyn95nH8U1NDgtEP9p4jaPSPVtV/THLtB/fFRRb+y6af6ZKFzbjMJFaG
 HVJKZ3Mtp1R+KNT9IWMRzOsYvpmauAWOXVdTrLrH7y9eSC9D+VuZnDb3skWNrmVB
 15OJ1t1wkz16I4Ah+3OjYoeUb7yWM1ugMHVCRCpNI8J3NvC79R1VdJFwVeB+yNhU
 YlNBIcefEt/OInov7YJXFABYn/Mqc97jee+3PYKQi9OhINS4UA2xuygR+6vHewle
 Z7lxiQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7r4h83uq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:52:31 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2b81ff82e3cso2156421eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 04:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774871551; x=1775476351;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XgZJgX0TxKp/l+YGdpnqFg2Xk4t+k4MwvR0s2wGs6yc=;
 b=j/RfPpP1R2cFrcXa6wHCQDvolPQwEEmnTMnIgEu/k0j2Y5yj5BGGvoxf7xOtfdH7a4
 tOzbUi3tFrpSw5iD2McmQjgHqtf3EwP9V+MLlo+9+hgkPunUrRqgH1qSMhJjGoS+N8OU
 9PkP9bDiP4IgJPppKZPomG2JmS5cWgEBY0SCxAjqE6EGHTwTCx/SbkO3V7TMK8u0fybt
 3jPXL1L7fFExRHbQPzVmM+PlDiE80yswXcuG2pVxr9RYp4aQzqbNvBgJSPYRRd39bJ2q
 5bV1o4Vfp8wU7CSV4c4HYZyc5ygoKIorU3s/n6bUY/3qRIVz/XaQ6dQikt4qtT2mS+hr
 eh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774871551; x=1775476351;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XgZJgX0TxKp/l+YGdpnqFg2Xk4t+k4MwvR0s2wGs6yc=;
 b=ZD819fdHroseznDiCi1S2KeaEY1mCHtW+DWFy+qaI0i4HXXuCDnOpbaFjHdzFdzgWh
 LezCdetEQkYPeqSAo39NuXf19MlXwvYCZ5xAB1eb2i16e/AhNX9TaBGYWrluYcZZzWQk
 EXJShyMQkoeL7D+irp7kS9bPglGS1u3H54EU1/a1FdflG1dz2avqEKp4jI/WyTOu+M97
 EhR5Q5b1Xuj+K0/qYvbnzubxdX82HISrWablxbUo9CZw6dvPNan0YCP4hT21d8ppeJI+
 r3a3GBZzFb0O4GShYN1SKsyHcyWKkjEnhmTI1DQNRYOoccQ3Wa22ti9fPbdY3VfmusZS
 6jWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT4SDzBnU/riyt0wz9YagmHCxDY5LcsOZk6qPWIGsGmmdeQKdFQwSCIcfH7TOyVU4oB4edND8Sfhg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5JtBRZRJdkzPu5Oo6YUQCtftEq0DWqNMCa03K1UZ782j+4d0M
 JmxkkSJiPHnNjrnBBNNLIjmhZow4ZV4KQqY8dDxkYPGCKTs38m7f/WpjnPlo5BxUTevfjvMWPo6
 bN8UAUeexBRhLGSFuqMmsb1xJ1q0KCHScU22MYBfu5AgDCf/T1x6lxc4Mg9IG08C+W01zR/A=
X-Gm-Gg: ATEYQzzhSMNW0B+x8fClhvmCet+9dlqLX+un57k0oWzpN503oDlO1l15wmIYOOrSz2s
 wo3YZxM+qEU+Ros3qa1xUJRfm4CPfBT2nz0M3UZ62ocwhqXlUs0DpIsF4n1E4TYb5TfRLDqKpfE
 C9YvDx0t9Dww//6txbw7+km5whuYumViKdXCi1VQJ7SI6/4qA3TDVdIxkhEvW5jE4jMpvAPmF10
 3dYV+zALS5dkO6n7AoSk8E3/Xpx3VlXtpIeQtOaJqE2Y522BAm45mc+sqvAefZX7G9qEy48tP3j
 S+IHJxOJpzTxy5GvCOV9ccE0LtEgxqUJfKxLAugUOVG+zNzSusLbKTwqnP6OwLc/Fesfr1F6nBJ
 hW32M262VcXSmAhS1I0RrCsUPDjEF7S23Rfqmp6/Az1r8jxoxSQg/KiJNZGdXieb31fPj9i11t0
 KCQMQ=
X-Received: by 2002:a05:7022:6882:b0:123:331f:978f with SMTP id
 a92af1059eb24-12aabb50203mr6812654c88.7.1774871550795; 
 Mon, 30 Mar 2026 04:52:30 -0700 (PDT)
X-Received: by 2002:a05:7022:6882:b0:123:331f:978f with SMTP id
 a92af1059eb24-12aabb50203mr6812642c88.7.1774871550263; 
 Mon, 30 Mar 2026 04:52:30 -0700 (PDT)
Received: from [10.110.38.145] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12ab97efb42sm11000274c88.7.2026.03.30.04.52.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 04:52:29 -0700 (PDT)
Message-ID: <db642c02-8009-40e1-b296-70de8364b43d@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 19:52:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/38] drm/msm/dp: introduce max_streams for DP
 controller MST support
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
 <20250825-msm-dp-mst-v3-12-01faacfcdedd@oss.qualcomm.com>
 <ltlmp5ytl2f7no7aqq7sl54pwd4f53fuema23xnuwu5uthhbg3@7wamwvv22nle>
 <c71ea478-ed93-4f10-aba2-023180c2ed42@oss.qualcomm.com>
 <ex5zvncmnt5pmb5j2utolgbw3yewj4x4e6nu7sdrgzm7ubasmi@2jdubbxuckwd>
 <99d6795e-1cea-4e7f-b8b6-97f55af55d8d@oss.qualcomm.com>
 <ns7sknmegndsf6uvih6znbwk6bpltjmbykvs6g2ma3ccd767fe@3q5rhx3zj27u>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <ns7sknmegndsf6uvih6znbwk6bpltjmbykvs6g2ma3ccd767fe@3q5rhx3zj27u>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA5MyBTYWx0ZWRfX3AgPD+GMm9M0
 ENdexEbhK3ONhP6++NK4fKwxYly9Xlryd4lmEAqNne94DxcjCP7rTTMz3gtwDoOSbS6eTDJjiEi
 DFWWa1hRLkX4EQcUOFQsRr1BaNwozOllByV+hanHT8LOFnOIjnmao0epZovUB0b6y06qbcTvSig
 PAgIscpAWspuwvJeobFVQe5zmjeIm69oqTz2cBzjdpUWiLF0gSOx4107D7NGHN7ViEqWmrggut3
 /nuXj2gtup+9g/1q86etiMSvmMJLNLKwQM5i+iSRwiR5jbaA+YOyUdeiBnj/+oKL6yB7YxIzp1Y
 dJc3cn+AgGHolFfDv2pYGc0cke93qFlvS381jVp9AAMx3jkMhhKq+GYR99TanbG6FGBRsWPL7P2
 Xi6PgSXu/J78s+NMaBM2sLZwMXPDsH691rS48dpBj535d+LCf5cQV0wiSnOI1D6YMlqlpaurVRv
 PgSJWERJkbIirQq93Lg==
X-Proofpoint-ORIG-GUID: gHNfI15kI2HO4gkLrT7tMVQXaH3Tlihs
X-Authority-Analysis: v=2.4 cv=PI0COPqC c=1 sm=1 tr=0 ts=69ca63ff cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=fQFtLZBTUO1RzxlNfjoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: gHNfI15kI2HO4gkLrT7tMVQXaH3Tlihs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300093
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



On 3/30/2026 7:42 PM, Dmitry Baryshkov wrote:
> On Mon, Mar 30, 2026 at 07:32:38PM +0800, Yongxing Mou wrote:
>>
>>
>> On 3/30/2026 6:35 PM, Dmitry Baryshkov wrote:
>>> On Mon, Mar 30, 2026 at 05:57:13PM +0800, Yongxing Mou wrote:
>>>>
>>>>
>>>> On 8/26/2025 1:42 AM, Dmitry Baryshkov wrote:
>>>>> On Mon, Aug 25, 2025 at 10:15:58PM +0800, Yongxing Mou wrote:
>>>>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>>>
>>>>>> Introduce the `mst_streams` field in each DP controller descriptor to
>>>>>> specify the number of supported MST streams. Most platforms support 2 or
>>>>>> 4 MST streams, while platforms without MST support default to a single
>>>>>> stream (`DEFAULT_STREAM_COUNT = 1`).
>>>>>>
>>>>>> This change also accounts for platforms with asymmetric stream support,
>>>>>> e.g., DP0 supporting 4 streams and DP1 supporting 2.
>>>>>
>>>>> How?
>>>>>
>>>> Each DP controller have it own msm_dp_desc ...
>>>
>>> Why do you need to mention it?
>>>
>> Sorry, I may have misunderstood your “How?”. Could you please clarify what
>> aspect you are referring to (commit message wording vs. the actual
>> implementation)?
> 
> "Yes." You mention it as if something was done explicitly to account for
> those differences. And then fail to say, what / how. My assumtion is
> that this comes from the commit text style (see
> Documentation/process/submitting-patches.rst). Please use imperative
> language rather than descriptive. It will make such questions go away.
> 
Thanks for the clarification and for pointing this out. Will rework the 
commit message in the next revision.
>>>>>>
>>>>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> 

