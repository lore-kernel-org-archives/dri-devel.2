Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B86606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SPdpQLIQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KZbxDMiC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D54F510FB2F;
	Thu, 19 Nov 2026 07:36:12 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7020510FB44
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 07:36:01 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6v8GP2030783
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 07:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MrR4v6w8hM+joF8rOFBj1WZlbRGV33NqZGNbqm2Vp0A=; b=SPdpQLIQ/hjGJ8Y3
 zpJQGpqvX5XR04RNeeNiStAUJZp5gij8VvMpXKIPgv7UTNov3w4lDumv+cMPxZg2
 O0WwUMGZJUQgdLzxYrrm/Yu+6ve4S1iC9QfSWIDz2ldbrPKlQcNsOyf0AtG8s8Be
 2IYjVack31KNqUp604HdbqWn2MoXXbwORfPe6+ej7wHdpL9azUIOusqHWLcrsbPb
 jEhKN0VztQgTB36OnDVqfnTEtbco9IwtV8UxkdcDshhRp5eJCW7DxzVgQGXXy0we
 svvd4P2m8Buh8UgiUeFOPgmR++Sz4R1SZcZ+IABfKpVV6607WiE3Z+DQcoV9Wwvu
 X1iVsw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1g3ku7y6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 07:36:00 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cdb86c39250so1225212a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795073759; x=1795678559;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MrR4v6w8hM+joF8rOFBj1WZlbRGV33NqZGNbqm2Vp0A=;
 b=KZbxDMiCgF2Y8ULmKGP/HJF2ltKGAJmkGXz2Rbo+cngE1yuJBYJbYh7ODic0LpuxEc
 6fjswoMApFk/AcZ41YRnc5tQbrvBtNw995BI2ghPK8ng8G8MMilbXkHw3kBCrNbAdJX8
 MegYBspcW4D29dM+2JbwjibTBnEfsZPoZyeHWbT9SIeczScf2IF+38a7rlXJy8a6BySS
 N3vEySpbo7yXBB+cX6HCfWmgEy3xvJCij/7JxACLojNgvnlNhCM7jHi/KcB9BQB42ZcW
 faV0mEzIYWYOOKFsvtrnQVGoO37SeIiHrMA8bTTWdhVv/VgLQkDR1LGF1He+fU6ghBZb
 +BYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795073759; x=1795678559;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MrR4v6w8hM+joF8rOFBj1WZlbRGV33NqZGNbqm2Vp0A=;
 b=N/SHAXJusvuyt8N6sdEncG4adGR21gzEtCIIVQlXLmH7wzH/wCcmaEH9vQvKMZ0zCI
 o9zq+o6AsQD4AAbyKF7JTTHksnEmm9gzWZlDatAWZKsPc7OTD1/o4eHKtgBr6ls0S6js
 TFZRnjTJbDsxOzmp4IYwpkSoRjOBhOAh5glnD9eMJANa3Rsp2f49nHTMKDanh6pVQfL3
 /5PgR8dX0I37WPrjHXLsmZM+jdn2Pn5JO4/qFPPQoJ8naywGP1hj/86tktwEBKWabwPZ
 B36C+uwn1+HO9WiG6JsPBPhfMwJ0ge9T2ZE/4Kx0B+OEipTbcxAIbDaEu3gVplg9mIrm
 H29g==
X-Forwarded-Encrypted: i=1;
 AL+hErEF5/lfX4/Ck0FXo87+VobxhQfexBmiRIS2ec7g14YVs5IOxPNbx3WGwI79nhRtASa2sDs0Mb94zT8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8CozJU/As+epvvlHRxLTtLbQg3Wx3AFwN0enH/jzUm7seiJPHU
 vRFgsLjGJ1f8MIaAxvUbMEuiG0GJruasW8rAv1vjVZkr9LflTuuoa6qMqbq4BPrdOZFlKC3a50P
 u6WoQ8KUM3h8ryhGN4NWlx+j463QEE2AwCxkFRUQ7aBT8anBz+8kUCOPFvpDnFgB5rWmsgZ0=
X-Gm-Gg: AYBFou1sJ84dpGDaqzBRdsU+3mkwc5LMSIZtmG6vIa/w9IJAfgES3TZmv8s2EIvGqj2
 VUVfeW0uXAKMo9Kh/iYCkg/IUTmkzgS0og7D8aHn2XcbQ8aYdRSlMFezODgdoq5pb8KIVDlPVjV
 qFVx0gb1HqW544p27uY0w1iccAjHecMN6Vv7j+Zs0zN1I0vXQwb+JrOQ/htUOq/iF/T3/mui1T+
 PtXefe6Wi+LRMlTPaZPkmZvHq81bUHYaRyZD0g9MpE0YVOgeGJK3UtPmDJd0PB5iMY+89eOYtzR
 heIdnfL+OA58qPTeEv1ygSgob7F0xObx3mIv2rWKghn6FXQs4WfIOactCD5dBUKirSEYRKbiK1j
 3ptwblkvuW99J2oPhngLjf9mSR8DINZA/POdixwtEHT0E1Y5xqL/Fob0VjoQCbCDXaKsmCBp56w
 uz
X-Received: by 2002:a05:6a20:a10c:b0:3fa:7d82:5e96 with SMTP id
 adf61e73a8af0-3fe985f42bamr6096182637.73.1795073759041; 
 Wed, 18 Nov 2026 23:35:59 -0800 (PST)
X-Received: by 2002:a05:6a20:a10c:b0:3fa:7d82:5e96 with SMTP id
 adf61e73a8af0-3fe985f42bamr6096147637.73.1795073758410; 
 Wed, 18 Nov 2026 23:35:58 -0800 (PST)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c5cb54e413sm2433584b3a.43.2026.11.18.23.35.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 23:35:57 -0800 (PST)
Message-ID: <a63614cd-93e4-4c5e-8d76-78a6b77a96f3@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 15:35:51 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/35] drm/msm/dp: add support to send ACT packets for
 MST
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-8-4b81473185e7@oss.qualcomm.com>
 <aolbmfnrk6qkfifib6bmhslaro5z2734ydfip4mnn3go4efpsy@2d4m6nnh7ogv>
 <3c28f89e-8b49-4937-b4c8-66da180a5706@oss.qualcomm.com>
 <fx5njelx53gciz6rguzjybxgbyxbfqweelsuy4j3aab2n5awrf@n27xvmre7ztu>
 <ebf962ad-6b55-4741-bbb3-783f56c1106f@oss.qualcomm.com>
 <y446bfbdgsqqwuu3masamj33cvcksp2xdeltvaeojpolgga3fg@awtfd4bgpy7h>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <y446bfbdgsqqwuu3masamj33cvcksp2xdeltvaeojpolgga3fg@awtfd4bgpy7h>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMCBTYWx0ZWRfX1eZhjZpwc+y9
 fpw27E8z6Ufgef8K9Q3qPLl5Qd4tSXIySjuDTL7242sI8rHWEZDYHG/hAhvVhKAUgsGruMznEbu
 ygFhOicFdAMzeEe2VL+cDQjHKpIU3O9DIVMmeHcMGjBRX6B6Ru+acyizYrgFkw8aJk1GJLlNAVW
 yCXOww0uU/UwQ1PEm23i6F2L0p1qn+XNdurOxS6JgL0BFVQQ2gYemPFjQKuoMlHqXYo9rby+agg
 5Cs1y2t/aqjQoOpXk9oE2DjfKZCGR9FpBuefK0OTAvyXgaO3rP+d/0M1OM2mZHsiJB1bE/xGneM
 l205mxKQUQaDRahjdIQ1HwhXaMbaER3mzyPUmk5t21o7SoNpUnYvcBDIUJyQGURGw+F76hrJe9h
 HhhZigBD3nwwHsSi7NhOhkwXwxZE5jqPKZlzhu0dodg/iU7GGil8Wxlpw96p/vnnYCiZ5joYPZz
 wp9p1+RC25hZyyT2BQA==
X-Authority-Analysis: v=2.4 cv=Wom+otfv c=1 sm=1 tr=0 ts=6afea6e0 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Ip3K_fYRsbvWuOMUuCoA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMCBTYWx0ZWRfX+n0V+eKkqxsw
 qHU1wJwZjJi3F1zXnmwti0U/QdfhJTw/0/oh0uVAINFAS9NbSGSnE3ojVWnzbmXoP0xewDzOv4f
 ffuhBJt/eSavgSqsiL5Xo5Tc8lw4nEk=
X-Proofpoint-ORIG-GUID: esLT3stlwvZrREOD_T8xtY33FgpYRNnU
X-Proofpoint-GUID: esLT3stlwvZrREOD_T8xtY33FgpYRNnU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190030
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/11/2026 10:22 PM, Dmitry Baryshkov wrote:
> On Thu, Oct 15, 2026 at 06:28:52PM +0800, Yongxing Mou wrote:
>>
>>
>> On 10/12/2026 8:23 PM, Dmitry Baryshkov wrote:
>>> On Mon, Oct 12, 2026 at 04:44:06PM +0800, Yongxing Mou wrote:
>>>>
>>>>
>>>> On 10/1/2026 6:32 PM, Dmitry Baryshkov wrote:
>>>>> On Tue, Sep 29, 2026 at 12:25:32PM +0800, Yongxing Mou wrote:
>>>>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>>>
>>>>>> Whenever virtual channel slot allocation changes, the DP
>>>>>> source must send the action control trigger sequence to notify
>>>>>> the sink about the same. This would be applicable during the
>>>>>> start and stop of the pixel stream. Add the infrastructure
>>>>>> to be able to send ACT packets for the DP controller when
>>>>>> operating in MST mode.
>>>>>>
>>>>>> Add REG_DP_MST_ACT, the ACT trigger register used by this sequence.
>>>>>>
>>>>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/msm/dp/dp_ctrl.c    | 44 ++++++++++++++++++++++++++++++++++++-
>>>>>>     drivers/gpu/drm/msm/dp/dp_ctrl.h    |  5 ++++-
>>>>>>     drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
>>>>>>     drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>>>>>>     drivers/gpu/drm/msm/dp/dp_reg.h     |  1 +
>>>>>>     5 files changed, 51 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>>>> index e1614bc49a7c..65d22505c2b6 100644
>>>>>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>>>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>>>> @@ -142,6 +142,7 @@ struct msm_dp_ctrl_private {
>>>>>>     	bool core_clks_on;
>>>>>>     	bool link_clks_on;
>>>>>>     	bool stream_clks_on[DP_STREAM_MAX];
>>>>>> +	bool mst_active;
>>>>>
>>>>> I really don't like the idea of having this flag in two locations. Here
>>>>> and in the msm_dp_display_private. Can we have it in one place only?
>>>>>
>>>> These two fields are intended to represent different states with different
>>>> lifetimes.
>>>>
>>>> msm_dp::mst_active tracks whether the DP connection has an active MST
>>>> session. The controller field records whether the current controller/link is
>>>> operating in MST mode and remains valid until the link is shut down.
>>>>
>>>> I agree that using mst_active for both fields makes them look like
>>>> duplicated state. I propose renaming the controller field to mst_mode while
>>>> keeping the display-side field as mst_active.
>>>>
>>>> Would you agree with this change?
>>>
>>> What is the difference between these two? I.e. what os the difference
>>> between those two?
>>>
>> The difference between these two states mainly shows up during unplug.
>> mst_active is cleared when dp_display starts handling the unplug, while
>> dp_ctrl needs to keep the MST state until all streams are disabled and the
>> link is shut down.
>>
>> So there is a period during teardown where these two states are different,
>> which is expected.
>>
>> My concern with keeping only one state is that we would need to pass the MST
>> mode through multiple dp_ctrl APIs, which would make the code more
>> complicated. Would it make sense to keep this state in dp_ctrl and rename it
>> to mst_mode to make the distinction clearer?
> 
> Sorry for the delayed response. How would the driver behave while those
> two disagree? What happens if the user unplugs the MST sink and then,
> without stopping the display, plugs in the SST sink?
> 
The window does exist, but it's extremely(130~200ms in my monaco device) 
short and hard for a user to actually hit. It only exists when the 
disable commit is asynchronous.

  We can consider introducing drm_dp_mst_root_conn_atomic_check(). It's 
specifically designed to serialize the MST disable commit against the 
SST enable commit.

> 

