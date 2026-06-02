Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA73CD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 08:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E8BA10ED28;
	Tue,  2 Jun 2026 08:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dcstd8YE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QZqKoK+n";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6167F10ED28
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 08:04:03 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 652454xI1937415
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 08:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 B703hGO+RaNSrRMp5DLHVw+od/NRHRIOECEIiojPEEo=; b=Dcstd8YEf4gFzfFd
 IlwVlkBiyz+1iAW6IxNSrYNQQUtCD9rrbbAtFq0rgdc00H9CfBre1YkYCoaSfihF
 2Ia4HRJ63VFfhoztv4wy1oBZZ0umAhXpTdCHAjoqD3CsXvDCLCtGQsc1v+r5zhnu
 ZhcBUJuQg8GmxsZj9IRIWny1IB0cDXX15i/oELJbA26y8TfjS7//6uSdEk9rmKrA
 UyKb8aUjxzLiVOeqx3gYh1q1shkxnJpSk7Bm43OwKKS4e8aJGt7gHdPuTO+NYz0z
 Cs2Ubbqsyf8Oz2PS4CnwonISLvxFOuXf9ahMBIPaQXD0P/VOwRwmdk/MjpU2PB+P
 9JTdVA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehqubgvm2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 08:04:02 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c85a2c665easo2208342a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 01:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780387441; x=1780992241;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B703hGO+RaNSrRMp5DLHVw+od/NRHRIOECEIiojPEEo=;
 b=QZqKoK+nWf9rvuJzl57/6hVTSCsVoHpFYcfeYsYixDAvGVRR/C6AhYp7YABD/4PTe3
 kLUsntWqIuwxYnW+29FMuwqCKquKE1UxCEmv0mnR8gA9TDcl87Zfa2ktqUrXZBLLzVjm
 eulcMNHRMLsr40XHLj5dVKUdP8y4Z7bYtuCRb3wsmPFD/NgtmBcpNEdEC2ulp3ZwjpAS
 6qTJU+6HFc8kNl5W2V6YBBGSxdhlhrTHhg4EOWv0P1VXRpPTzTx2mqMoo09hHu/HQ8BY
 zEgrPNh8SWieEmcTx9S9fqPtfWVwW+VXLHjv1yRRz+CRdXJr9/JzwYZh3J6UlI8oFUy8
 Sd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780387441; x=1780992241;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B703hGO+RaNSrRMp5DLHVw+od/NRHRIOECEIiojPEEo=;
 b=isoB7lVkmNrIsAF9D08euATNYxhNM7TUSbGbmMY4201luHIJtmloMjk6sS1GmkUkoW
 S0yRNKADo1wa15DiY6ZP+RNuqFwwq8C1+pDzRuBCBSa5nERbM9gQF2cAt/jxoWluvnfT
 uATGPT9rYn0LvnAoZTDHvZIEsaTEKr9DA0WHKHKnTz1IWiVBErTl6LK82HojBSUog/Rv
 knoFkxKAnikXGyIO4SbJTagUUFUg2HDyEeGyjHiV19qiMJnlMbz8sYkO09ayh3eEEjDP
 jyqtmhyeynMJ4LI1uxsP2RahKZPX+ki7NFTm3fqv3FOJtOJP56dtg3XxHbxZKDVBFsq9
 Jgnw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8HcA5qApHscz3cJS8bxqhOUXcv28FXvNgfimoxUlbADJtqvg4tTYd9lGZglb8qZCo3RTUQBnKZuKc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCnYzI1jR9CjCTQDmlLGRe0tbR12lHlnYCeiqoj8g4rXhVYfPg
 k2sZGsYuXQqLuJzbda6+rzQO7F/nUR2QlnrtqEm3p8cHQ0w71y38YlsQjBLD3Sx5vgttWWdC3+d
 ryoRpQSngJqVMIOOjcZ0lK2kVnpTdbSrOUn8X8ylL2i++EKlpDs9YNVDs5aWK8IKdWVAOW90=
X-Gm-Gg: Acq92OHYeWD9qhlxdd41eC/bnCT/cO1kbe+Hf9JT93LdjieqBy+NTkddP57NzKbZnMq
 droRpQJLdu/6hlu/tf4izEGig23rUk5mdnc2043gRTEi+OdHo8kDgqgHBTlkJ45zhrt+a1u5IWW
 kX3PAvnb7eKSyIHGNAz0SqAqhyRzE4D5E8cl8068F3y/qPQoAEmwAwNGJLVV1HIZspF2HX8FfoQ
 o6rzZJ/5ssA7KKmP7C3Es7x/mdbPazU28MJ8qidZ1BwxWn78NsjSnGngbICZKoLI6Zw8XOHFlE8
 K90B3yeFVFMdJSBPYQz9vOoO9+MXcunWA6eKyuoi9sQbuUg+f64AMggy71i+F0H9axUkhpBrY27
 0uQEv6cAFD0FfTehHIfv2YwtFQMIMtT6KKhsUtWyyDHeaDwJ7bNV+r6UTB/tj2duP7aaINrVs0A
 zFibW2jF0Pa0LoEXJPzx2LLEWYPpM=
X-Received: by 2002:a05:6a21:6b8b:b0:3b3:298:a063 with SMTP id
 adf61e73a8af0-3b427f50ca0mr15597599637.38.1780387441417; 
 Tue, 02 Jun 2026 01:04:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b8b:b0:3b3:298:a063 with SMTP id
 adf61e73a8af0-3b427f50ca0mr15597547637.38.1780387440965; 
 Tue, 02 Jun 2026 01:04:00 -0700 (PDT)
Received: from [10.133.33.92] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85771d367esm11645229a12.11.2026.06.02.01.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2026 01:04:00 -0700 (PDT)
Message-ID: <ebf6693a-46ed-4a8b-b190-da8663d668a1@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 16:03:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/15] drm/msm/dp: allow dp_ctrl stream APIs to use any
 panel passed to it
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com>
 <20260528-dp_mstclean-v5-10-a9221c1f1f3b@oss.qualcomm.com>
 <mar2smjimo3uoucxctofmjd25vsfun66m3l6i4prnyvo3z7dzg@7e565usiluvq>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <mar2smjimo3uoucxctofmjd25vsfun66m3l6i4prnyvo3z7dzg@7e565usiluvq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 60pdj6sTJlTdQUTC_q87gTyjiqU_ehtw
X-Proofpoint-GUID: 60pdj6sTJlTdQUTC_q87gTyjiqU_ehtw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA3NCBTYWx0ZWRfX+3FPER/N3uWg
 9GVnfsLTivuE5u00L3iy61OCxbKG++CkXr8lBl92APAye8bQjQLNvAPeSLOrJzG6wDdwxtrSwQd
 5Z8gvd85T07Oj9ybXWGz66XEje5jJFW6FFV1nWU7Y5MoIACwZcWGITMvIdD53GWACnkckMadwJc
 9iPHkgzBv1/mFxI7hB7M33SMjc2pwOINQn8esVgouvqEq0wFz0F2iOTrSLTJT1Pw+vHvfE7HPi3
 nR9unokbKg1fU07qQI0VSbShCRh81MZcqbujyme6RKmUjNZENB1T8blU2q551RVBmI6qgvXmbTO
 BM05+SmKOjo/PhN83xib8u0dfRy/8DIN9MUM0IYk1Yt/sCG9QNqfVa5n/fIyLPjWRn4d7KeDcUN
 aLvlc2WF4VRqqKlNuwzzLkbKMn9r82GMbaEor53AGqRUabZyYRWArUOC1kI0fC1lfrkbyhBnMyr
 QVXDjlCWBKV7Dis8kPg==
X-Authority-Analysis: v=2.4 cv=FcoHAp+6 c=1 sm=1 tr=0 ts=6a1e8e72 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=EvH9m4XvAzKA_BOLlAYA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020074
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



On 5/28/2026 11:25 PM, Dmitry Baryshkov wrote:
> On Thu, May 28, 2026 at 06:40:31PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> With MST, multiple sinks share a single DP controller, so a cached
>> panel in msm_dp_ctrl_private can no longer represent the per-stream
>> sink. Drop the cache and pass panel explicitly to all stream-related
>> dp_ctrl APIs.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 208 ++++++++++++++++++++----------------
>>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  28 +++--
>>   drivers/gpu/drm/msm/dp/dp_display.c |  24 ++---
>>   3 files changed, 146 insertions(+), 114 deletions(-)
>>
>> @@ -389,7 +389,7 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
>>   }
>>   
>>   static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
>> -					    struct msm_dp_panel *msm_dp_panel)
>> +					    struct msm_dp_panel *panel)
> 
> Please don't mix sensible changes with the renames / cleanups.
> 
Got it, thanks, will fix it next patch.
>>   {
>>   	u32 config = 0, tbd;
>>   
> 

