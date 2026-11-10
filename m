Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB58606A325
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R+zFs2XU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PUIVE068
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DEA610E10D;
	Tue, 10 Nov 2026 09:40:29 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A457B10E2D2
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 09:40:17 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA7l7iu3392351
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 09:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FqTmzG2leUMrWmJ2S1homkRviVObF1AjWA6tGVbhMsY=; b=R+zFs2XUqHSKJB9w
 /2qpzwzk+q+4hINDOXILfeHP+tZDMDZE2PH6PWMajq/9n/IIYYkp3bNOdo8GN5vU
 K5iQ1fTnotbZC2RjOxgB45upmJQmvS8vTukkQeRRTCiRPS5VhdG+CleeqnoBkQZI
 uctMCbVTROM/7BdFnl4h9zGXpGhP0aG4ABK3VYECwL8CpoSucKAKB27+FJNOZUGM
 zdrACues4AwzzKSknseM6X/uS75bpNYaM+MMkXLsqMgtQlfaDanSmz/x8ahMPna/
 QUzGWCNqllzDK9BvMPCgUUVeX+oft0K8CCmB3aECTeKbvUbxugLVJU5e8+1KwIZ3
 nQ6WnA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4humjg2um9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 09:40:16 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3b08aee6b3eso1627497a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 01:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794303615; x=1794908415;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FqTmzG2leUMrWmJ2S1homkRviVObF1AjWA6tGVbhMsY=;
 b=PUIVE068PD1KjvFbCpuh0pUxsa4+LvmiWeYe0L75O3R8mzwkTXllRxW4OC334jl6DV
 0dCE2QU29HjWl4Yg21bnA1GdNBOgPsLz2buBMReC232dulXaIExld2yTn8RUP0rVfBFV
 1lfO9AxkunzvEzqjX/Ow9KgGUgiRrghzRlvA6+24LzFHolUhH0PYzcR6iZwDCtoEKyT8
 FYxaBo0TTP5GucBPwVnB3M8TzEhl+2vfThOw5PNL3b7YPZSGqZohwln9Ags9YTvIkex2
 yM2GZUcVm7xYZXLDyfihumgckfu6xzCZPuxZKatDsR9noql16+4yzmZnWaHF11pwaZrX
 yRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794303615; x=1794908415;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FqTmzG2leUMrWmJ2S1homkRviVObF1AjWA6tGVbhMsY=;
 b=BCpVh4589ghqifUOrW1ayqX2ZhMR4H9P//xavieKh3YVbEPDWbc2VdlfNSQ3PB6mAx
 aorgKcvElLzranJtM809fC4gHGxqsLoqBbqFSUF1Wke8qPuF6W7oJB6c5U5LEZGMPybJ
 5DdzeJ37Nlh7W68qMUQkbZ+Dmv1xPEzQVOLSh8Xg479apNjIFKi9allyhxZz9nVCRImi
 Fa9VhAaZSZ0i6n6w4rS1ocdzEGnF8GlzbuUr4ei+Q+m7lAhlgKkrmNuXGbv9LZre6qIQ
 BnUiKFQ3F9UmfvVaWmQCzlxxO/HOXL0QzWYodsO8LnswjY5OlAdBgytnBeIP4DhHL9eF
 PpOg==
X-Forwarded-Encrypted: i=1;
 AL+hErFkq3BZvo3Z4YPnr9Q2FzDQixOzyhr8Dqva8EqSdg+8jBw28w94h266XMEHz3Rkm34G0jkhu/xmx8E=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9crFXeyQ/3+Vwr+7OGdmMgmEb+DIEbrQtGCGNyxNmsnxDw/Sn0
 vyk5xr+3haU0HOkfNK/Ibn/MpSRJH4+i65lMwaCowtXSIY6d4MR49QApKD06dm5d7gKUmztLnfx
 hQdCLM5mQHfzkSuY7fJV+7Ct4zBBMOQfSBpBN1vRXvBdXd4cZq1r7PsP5yidMpq89rE8H+9U=
X-Gm-Gg: AYBFou0+aANWSED5MWySL70PoFU2Kb1OuOHmjp4N4qev9kuw1Tp1/nck4u1z01FrFvO
 cEWREt7Sg+kJdUtFt57O2MZ9IzU6X4yIeSSaTVZ5uUC3mwSRB2b3UZk4NbJuScpVt3/n2S8GH91
 ZSagUI2LBMCPHYPFBbXOW4tFAtyMXBzsZRljKSASY33i9H7KHAFu5CF0iqD3SeR7nWVxPtqqzjg
 rbMFKjdMmgTP7WW1b2NhO5ZIkI7ze8lSQCEJCkGiTgr31iYpKQ+l6/yQ+NiGDQC8zl851LpYJP5
 ZIljCLwDh0o3IaDHfS+HpwblKtT0aPpSS+VcLZBi8SASc5lWRXlbav62LV7rN5qbN+o+fl+iCgK
 hWaJnzog5j6zpjl9Vi/mnVMhtDnTPZaj+v8u5smiH0rgeI80FFAHogtXXdUBBFP4CJCSv21VQ3Q
 qg
X-Received: by 2002:a17:90a:e2cc:b0:3ad:eb29:3383 with SMTP id
 98e67ed59e1d1-3b166c89a67mr1747411a91.22.1794303615197; 
 Tue, 10 Nov 2026 01:40:15 -0800 (PST)
X-Received: by 2002:a17:90a:e2cc:b0:3ad:eb29:3383 with SMTP id
 98e67ed59e1d1-3b166c89a67mr1747398a91.22.1794303614681; 
 Tue, 10 Nov 2026 01:40:14 -0800 (PST)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b16ca50f2bsm886871a91.3.2026.11.10.01.40.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 01:40:14 -0800 (PST)
Message-ID: <661383c5-41c5-495a-94ab-ffd1b99d7f9d@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 17:40:07 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/35] drm/msm/dp: add support for MST channel slot
 allocation
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
 <20260929-msm-dp-mst-v7-13-4b81473185e7@oss.qualcomm.com>
 <agm7esy726no4u4cntecmllz5kxdtxaue7xcn7vdhkuh73lxau@r6mqybgiyl7f>
 <ab5ebfa2-9687-48ba-8403-186e517126d2@oss.qualcomm.com>
 <jwmtxurikcc2qsahg4rq63earm75puu46isd5du2s6356oe6eh@7umfzpxmoebv>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <jwmtxurikcc2qsahg4rq63earm75puu46isd5du2s6356oe6eh@7umfzpxmoebv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzOCBTYWx0ZWRfX+QYwpOYxhQQO
 gbRag0KhfpS0Jqc2GLCZpAkrzYD3X09GVIryeGn9vAhizUWowXmySvxCS005A36ONlqVFf4Ca0C
 FmfFrZucYE5KRyHoXYvgS0tq/WnVtmFZrJ6q5CNjAI5REEq6BkNUwmn09WR55lZfS+p/lQUeaHo
 L5imXYc+l3n/Q+IKuDITv60DrKYFrgJvvfbE0RbhDH+kQnwdO1kCElINQ8MVdJqFxWwRgwFIi+C
 cyvTDdWaqqHitXf3utWultQqnvEo5RPmNuUAktrfojzkGtqGZPgf016JFiX4j7cCywH8jOksVpt
 W8qU0lC9hb4bX8TUSlSXxPgtkhE0RYuuEx4vcpTuILIi1CLVzRb004GNjy2JIzOlTWRoCDyDYKv
 jdiID1X4O+RsCg8Wtpi35GiEwETlIyRMjPONW2q1/HCjXXJw3K5CTE2GMXLadqkTk6Hd7emvTju
 Y3K4SjI4FDHnGyMC4KQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzOCBTYWx0ZWRfX9fLnwuRWF7Ek
 AfkeZ339v2fjbAJRh/1/BEhsm4L3yvtDmZknBIATktjvG2cfahDpDwyPj8/ArEG6BcvtkdHgHk5
 /RWwH8bLrW9iN0QX2yAT/3pECwkCGEQ=
X-Proofpoint-GUID: r25ibmGMHARuHZNIdB5507LwKOsYK3D8
X-Authority-Analysis: v=2.4 cv=B6gsQ+tM c=1 sm=1 tr=0 ts=6af2e680 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Quu6St0uLKo6CJq7Ik0A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: r25ibmGMHARuHZNIdB5507LwKOsYK3D8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100038
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



On 11/9/2026 3:20 AM, Dmitry Baryshkov wrote:
> On Thu, Oct 15, 2026 at 09:24:52PM +0800, Yongxing Mou wrote:
>>
>>
>> On 10/1/2026 6:52 PM, Dmitry Baryshkov wrote:
>>> On Tue, Sep 29, 2026 at 12:25:37PM +0800, Yongxing Mou wrote:
>>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>
>>>> DP MST streams share 64 MTP slots in a time-multiplexed manner. Add
>>>> support for calculating the rate governor, slot allocation, and slot
>>>> reservation in the DP controller.
>>>>
>>>> Each MST stream can reserve its slots by calling
>>>> msm_dp_display_set_stream_info() from its bridge callbacks.
>>>>
>>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>> ---
>>>>    drivers/gpu/drm/msm/dp/dp_ctrl.c    | 187 ++++++++++++++++++++++++++++++++++++
>>>>    drivers/gpu/drm/msm/dp/dp_ctrl.h    |   4 +
>>>>    drivers/gpu/drm/msm/dp/dp_display.c |  13 +++
>>>>    drivers/gpu/drm/msm/dp/dp_display.h |   2 +
>>>>    4 files changed, 206 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>> index 929e0f94f8dd..02732bd4efa1 100644
>>>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>> @@ -83,6 +83,7 @@
>>>>    #define MR_LINK_PRBS7 0x100
>>>>    #define MR_LINK_CUSTOM80 0x200
>>>>    #define MR_LINK_TRAINING4  0x40
>>>> +#define DP_MAX_TIME_SLOTS 64
>>>>    enum {
>>>>    	DP_TRAINING_NONE,
>>>> @@ -119,6 +120,12 @@ struct msm_dp_vc_tu_mapping_table {
>>>>    	u8 tu_size_minus1;
>>>>    };
>>>> +struct msm_dp_mst_ch_slot_info {
>>>> +	u32 start_slot;
>>>> +	u32 tot_slots;
>>>> +	u32 pbn;
>>>> +};
>>>
>>> How other drivers handle slot programming? Is it something to be shared
>>> between the drivers? If so, maybe it would be better to update MST
>>> helpers. Or, asking differently, why do we store it this way? I don't
>> start_slot, tot_slots, and pbn come from the MST atomic state. The MSM DP
>> hardware uses start_slot and tot_slots to program the per-stream timeslot
>> registers, while pbn is used to calculate the rate governor. Therefore,
>> mst_ch_info[] is a cached copy added to make these values easily accessible
>> to dp_ctrl.c.
>>
>> Source hardware programming differs across vendors. Intel does not
>> explicitly program per-stream absolute start-slot or slot-mask registers
>> like QCOM does. Nouveau submits each head's allocation through its NVIF/VCPI
>> interface, while AMD converts the complete allocation table into SAT entries
>> and programs them into the source hardware. Therefore, DRM MST helpers can
>> handle the common payload allocation and slot-shifting logic, but source
>> hardware programming remains driver-specific.
>>
>> Without mst_ch_info[], we would need to construct a temporary complete
>> allocation table from the MST atomic state during stream enable/disable and
>> pass it through dp_display.c to dp_ctrl.c. Specifically, this would require
>> extending msm_dp_display_enable_helper(), msm_dp_display_disable_helper(),
>> and msm_dp_ctrl_on_stream(). msm_dp_ctrl_mst_timeslot_setup() would then use
>> this table to program the timeslot registers for all streams, while the
>> current stream's pbn would be passed to the rate governor calculation.
> 
> Would it be better if the MST helpers provided this table? Would it be
> useful for any other driver?
> 
I don't think this would be useful to other drivers. The table is 
indexed by the MSM source stream ID and is only needed because the MSM 
DP hardware requires an absolute start slot and a 64-bit slot mask per 
stream, as well as the PBN for the rate governor calculation.

Other MST drivers operate directly on 
drm_dp_mst_topology_state::payloads and don't need a 
source-stream-indexed representation. A common MST helper for this would 
therefore have only one user, while the hardware-specific translation 
would still remain in the MSM driver.

In the next version, I've dropped the cached mst_ch_info[] array 
following your earlier comment. dp_mst_drm.c now builds a small on-stack 
table from the MST payload states in the stream enable/disable paths, 
and dp_ctrl only translates that table into the hardware timeslot 
configuration and rate governor inputs.

