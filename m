Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E28CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:29:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69EEE10EA04;
	Thu, 15 Oct 2026 10:29:13 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 226B410EBA6
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:29:02 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9jY7S2966392
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZK+0FUJaqF1U29xJtyKMuQjx1J7qvdo5xAWj63A0zyY=; b=S/iOEuIx+4KUiWdA
 rGPRbJD6JVBOhU48iuOR9KlYXiZYxF07LGdb0x81+QFWyKg6gYWYfiuzwmRVJ63Q
 v8F1yBxYx+Da7WbAg37PKDOvvmNPDKxxsEBesPQbuTSjxqaF+0nuWykfh2NC5z1s
 m896EAyNwuBiRPdRuYtQqpY0ZVGGCkni+q9D+QLTGFGSFsWqpM8IbxKvdYnYXir+
 0KGIBCDteWbOk2WDU87pLOOG7oy5rIx/J/J1/L0kdPhNvnCZ7AqxbZ9/4iVL0gsS
 IiNGrlW6me0jODoG/cYdpMTsCqu2FWlxmbjZglHgV8nLC2u1hsnWPma1kbUt+Sjx
 VJ6uAA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hae4wujkq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:29:00 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2df375fb9b2so59589815ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 03:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792060140; x=1792664940;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZK+0FUJaqF1U29xJtyKMuQjx1J7qvdo5xAWj63A0zyY=;
 b=g+6dti+RlWXqG9PueSq7q4jl3wlBdbWgMhk0MZh3chLubGk2Ci569onwafWAI4NOES
 eXTpAYzqJz7JBYCcqM4rSkKjuKVsn/jH1B6h29b7jujGzhK/hNBj/ia//KkJUVGxaL5h
 cOc7DBNXOv84NO1TR5wXhf/3vWmCI7R/5EsPgm5i5LcKStNRKJl8AwtcBinQQydjdUTu
 cDzMz2CtYGvnYLUu2Nde3uUAWhbg7wsie61WhQ9TLTmKNhmv2sV5U3e4EgH8AumGivln
 RYsXAi3aRuNi2P8/uebKlkc1vKnhXjTEooeGHK1JheeDbroBo+sesLnCcFRyNq3YTPVu
 aUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792060140; x=1792664940;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZK+0FUJaqF1U29xJtyKMuQjx1J7qvdo5xAWj63A0zyY=;
 b=wLIcp098wJNT8/fQznl9CiMabqOQr4IfD/icpHOAeIKZwEF+BDfJE4yO31VGLRn4lQ
 Fa4EHPB8s/jMaXr4BdbAJyQXRp0uQyy3GVtTXyvIKnYWIokSSxAjcgztW3O/5m7QRcDx
 jlg1upFWvdppTc2aOV6TEO1NKWmt/4rTpO/V+27/fgKTj6VvaMwx40h3gG6X0RLzNye6
 adrIl4fBzcGOSYYdRQdrQu8mvpDiZqV8D8iJgPy2gBePsAJA1Af34SiG1rfTiqwMNoyK
 YEvyEzs5ECp4f/a0SbqTiARA9ctg5DeVmH4PZXvT9p9DEMEmX82cUiRSWYmNL5RNtERQ
 HRaA==
X-Forwarded-Encrypted: i=1;
 AKwUvByFkLQJWqxVmQohU4igW7gVuNxYu/OROedHROKvGA1UxbGteEtPl2uKlawhKQlXNJvTA/TPEqvX8+c=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLhoRb5lQTFD/uygW0DBMrD1by35bSgEMX52pbpu2fdfKnA8K1k
 X0QccSG6HSep6366Xt+1kLD1PJozYg7gBHGjWs/37e8kms8+ASsJmDeWk0k7uLVH08cSRlcKKJ9
 tn2Hu7rrTa+Car0cyRC4F0t1DYGC0GNW99LyVb+MMF+t7AFAPYbj75qCtnliCGgPMPxi9+jo=
X-Gm-Gg: AYBFou0chTtQjaLMa4nWhqgDFqhvAM+DIRiQHuD6IMFmYhFv+eDus8RWkdql4N9bCBM
 /NyNxVJDnmV+ScxACKNeh5AiGOJanp0YTFPbXrBVzYYLz0xqnZ9ME/AphsXA9DjhGaob3/N19ni
 qbvX+KTlbSmD2XSUfGh6CqzWbGTz9pJ4S3nxA50qHmPP4pp/ws6n9CY9sX6CCnZ0vvfjjCpaCHn
 YyEoeF+RXkHf1NU9Rb7vGjPb+hT9nxcKAXVMFKS9Qlww/HANkMhB6VunOc1fuKysZqnuZ7o60vK
 yeV6adTPk9AosBBzuDfv17hyiO4zTVgbFXOXvppaIRlZxTB1zNtd+3dEIh25D+CX9KHPtGnp1NF
 rDmILPhV8xXq+/KjRvhCzZvuN0KA=
X-Received: by 2002:a17:902:cec2:b0:2dd:c0ff:e72b with SMTP id
 d9443c01a7336-2e842e02a57mr148391795ad.61.1792060139920; 
 Thu, 15 Oct 2026 03:28:59 -0700 (PDT)
X-Received: by 2002:a17:902:cec2:b0:2dd:c0ff:e72b with SMTP id
 d9443c01a7336-2e842e02a57mr148391435ad.61.1792060139204; 
 Thu, 15 Oct 2026 03:28:59 -0700 (PDT)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422ba80asm80869785ad.63.2026.10.15.03.28.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 03:28:58 -0700 (PDT)
Message-ID: <ebf962ad-6b55-4741-bbb3-783f56c1106f@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 18:28:52 +0800
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
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <fx5njelx53gciz6rguzjybxgbyxbfqweelsuy4j3aab2n5awrf@n27xvmre7ztu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0MSBTYWx0ZWRfXyn7wthfaJyr0
 80y4wq1jEjAit/XNa38ArwC73iERt5U98Pbw7wzSPrKV7NxYsQuXDrUoufKtwMOje+4x7cZMjie
 GIba/wCgmPhIyPhqp+joTToayRurNvQ=
X-Proofpoint-ORIG-GUID: yw9piesTCzSfqQuJcE1XG9AgvFUVndkw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0MSBTYWx0ZWRfX7blNlw7AIzqB
 KsBLw+ALna3CXpJkshpqxOiTwDSl8t9yxpAJmX/ceyYFsdE1QR+k/VNgSvD2yOLsMFpkKDp2AH+
 Gz237J+W9zHcUa0NMuzXJM35G8cOUekRTrOqBWz5/W2Meig/cIvyQnCi5Y4oJvHCxImGVgod6kk
 WaZgAy8Rd5wy6OZXNjFe+/aElL8uVMcEi5MebS34mV2sNhrAmGjYFseSaeXP2teA5GLEP4bVYGY
 i92fUYmwn2mGF+0GAYbO8mtT5Yno2pV0Nl8H3HUenINhy1pKkQcP1kSytwlodhwV8059DRF8Pkp
 SBFVwWLuzJ7/nLD7nlhzw0rWFm56K6aUEiXvV5npvGK8lCSeXnCdMaPolBeD29KXDipr3jo8Uz0
 pvmNpst8gJXIymrZATEMkDkMhGmPaNyVogEPhlsBNAiSKRSOuBC4v9BONC4jDQ9PkDP9Z6gDr07
 F7Ybf50rkeCHaa642Ug==
X-Authority-Analysis: v=2.4 cv=E8BYNqdl c=1 sm=1 tr=0 ts=6ad0aaec cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=laV4OcfiDC6K5KK7Cz4A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: yw9piesTCzSfqQuJcE1XG9AgvFUVndkw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150041
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



On 10/12/2026 8:23 PM, Dmitry Baryshkov wrote:
> On Mon, Oct 12, 2026 at 04:44:06PM +0800, Yongxing Mou wrote:
>>
>>
>> On 10/1/2026 6:32 PM, Dmitry Baryshkov wrote:
>>> On Tue, Sep 29, 2026 at 12:25:32PM +0800, Yongxing Mou wrote:
>>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>
>>>> Whenever virtual channel slot allocation changes, the DP
>>>> source must send the action control trigger sequence to notify
>>>> the sink about the same. This would be applicable during the
>>>> start and stop of the pixel stream. Add the infrastructure
>>>> to be able to send ACT packets for the DP controller when
>>>> operating in MST mode.
>>>>
>>>> Add REG_DP_MST_ACT, the ACT trigger register used by this sequence.
>>>>
>>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>> ---
>>>>    drivers/gpu/drm/msm/dp/dp_ctrl.c    | 44 ++++++++++++++++++++++++++++++++++++-
>>>>    drivers/gpu/drm/msm/dp/dp_ctrl.h    |  5 ++++-
>>>>    drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
>>>>    drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>>>>    drivers/gpu/drm/msm/dp/dp_reg.h     |  1 +
>>>>    5 files changed, 51 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>> index e1614bc49a7c..65d22505c2b6 100644
>>>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>> @@ -142,6 +142,7 @@ struct msm_dp_ctrl_private {
>>>>    	bool core_clks_on;
>>>>    	bool link_clks_on;
>>>>    	bool stream_clks_on[DP_STREAM_MAX];
>>>> +	bool mst_active;
>>>
>>> I really don't like the idea of having this flag in two locations. Here
>>> and in the msm_dp_display_private. Can we have it in one place only?
>>>
>> These two fields are intended to represent different states with different
>> lifetimes.
>>
>> msm_dp::mst_active tracks whether the DP connection has an active MST
>> session. The controller field records whether the current controller/link is
>> operating in MST mode and remains valid until the link is shut down.
>>
>> I agree that using mst_active for both fields makes them look like
>> duplicated state. I propose renaming the controller field to mst_mode while
>> keeping the display-side field as mst_active.
>>
>> Would you agree with this change?
> 
> What is the difference between these two? I.e. what os the difference
> between those two?
> 
The difference between these two states mainly shows up during unplug. 
mst_active is cleared when dp_display starts handling the unplug, while 
dp_ctrl needs to keep the MST state until all streams are disabled and 
the link is shut down.

So there is a period during teardown where these two states are 
different, which is expected.

My concern with keeping only one state is that we would need to pass the 
MST mode through multiple dp_ctrl APIs, which would make the code more 
complicated. Would it make sense to keep this state in dp_ctrl and 
rename it to mst_mode to make the distinction clearer?
>>>>    };
>>>
>>> [...]
>>>
>>>>    static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
>>>> index 83117e7619f3..472429d09200 100644
>>>> --- a/drivers/gpu/drm/msm/dp/dp_display.h
>>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
>>>> @@ -19,6 +19,7 @@ struct msm_dp {
>>>>    	struct drm_bridge *bridge;
>>>>    	bool audio_enabled;
>>>>    	bool power_on;
>>>> +	bool mst_active;
>>>>    	unsigned int connector_type;
>>>>    	bool is_edp;
>>>
>>
> 

