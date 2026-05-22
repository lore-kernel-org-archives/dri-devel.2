Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6DCCD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 11:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B08C10E1E5;
	Fri, 22 May 2026 11:27:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nKi/Ac96";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MPnUCjO7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 082A110E1E6
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:27:47 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M8lQBN399119
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UiKQgwyqjMIOIsH4BohlB3XwNGHNxNr62DhRiy8MIQU=; b=nKi/Ac967PmnJfD/
 4esqJ5yxp3wuRgcJYrZ2PyRP4lWDpg7BfIPrEIOPDmxL/y0P1KExvPLy6FRYcPrS
 C0e44V14quADEhWJGBTDDL13LP1mGh1y6TL0/2xhLOioLThj/goiKeHLq3jREEeK
 AgaiKFMNfUpSWbYne2hHo/wDuJC5zMS8NdSDa3zLgVjvZOfE9M0k9G+YP0KsEJYy
 A8oQ1JFuhOJCPmfEu5XQYlqYfvRiFTzfr0qSHJ/k4LmdfTS6JTMjMLi5VpygkyGy
 d816/U8vtwj7j3NH4hjzUId6wG3d+6+o0W+6R7y9QFaHh9IcHZmYzp3T25pNJYU5
 RHQhOw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea5p9v2a5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:27:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-914aa01cc21so35484485a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 04:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779449265; x=1780054065;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UiKQgwyqjMIOIsH4BohlB3XwNGHNxNr62DhRiy8MIQU=;
 b=MPnUCjO7ul+vB0/0j2sza04xrzkP4+sdvmxlKTwMhr3Jg4HUylK555ux64XDpu+wHI
 KBNaZ7QJ7NHTAfemd9ShLAyONiG2j/P7KFkBnuCV6MWipcBT5YwokOqAtNsv8Kv3x53S
 tVgKhW3LI1i/vKRkXdFSHHLProMO5dIfb8dwq+XBbbXE14EhnutW0TOJfWOVTcSlv/o0
 WsF5s4kDFOwlLo6VNm2oCCuw3lw0MfU45bRkaLZG9Y9VjxGNnkEokfKvYiXTdMqM+xrO
 uDHpaOw5Wj2XZ7MuSf+7TATcVWQfMN+1NZCHh/o89UtM9w7/PQImGcXVY1fj15e/UZVd
 jsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779449265; x=1780054065;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UiKQgwyqjMIOIsH4BohlB3XwNGHNxNr62DhRiy8MIQU=;
 b=P/bjg+LjXLkG/W6Ns+SeCVfrU6BdTLZkkxqmQ4Sb3BsJSxWW2WW37gKQHf6KJGgds/
 BCa9OJJClfqnPdJbG8CAi0uhQQmqRRrP9X+yALNEYHuBrGoSxGU8meAG9rBxvZ1dkvK9
 Ie4sepSCPLqhtOxbmwM3MXGAn7onDOloCEWVP4f/Jf4Zia3W8KTVWb0cy5hxsneGfY/Q
 lGmNNJgB6xe0uUyB94w6Tr5E8U/HP2VTYy3L31v+4gLNX0yicdf8MphxE0VYTD502+Bl
 rCBYWfTzwivd6/lUtGgo2pj2ZsrmKgwjsP3inqkSQN23tSYnXhC4/PdnJRUBuhb17iZc
 yx7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8EUqSf4yL1lalq0IBCg3JYtnppLvDEmDcYgLWz09WfOYfKWRhq/+XoROYbFqsH76n9MqL9dePhFu0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAfzau+DzU/FrB+b8FOYK/3v/fw8AJrMwl3B08re/3oU1C3nYd
 dR1OLteJJCo/SwqyWuR/ZGXc1RngNzRSUs8lhffhQSS5O28or3MQ4xTEk0uCoiiNj0D7FAMf40l
 mcQEzc1FfcCjrIYG8zj/NqWR5KKnS/EAwH7RPIyx8Vs+32YEZES5ozaASG52Adto2FJhNFHM=
X-Gm-Gg: Acq92OFBuXbJMZyP9j+QqkQJK9fsBIvOS4WfQSmpl4V4HJdlXoejZ0AWmEtzjWS8J8R
 8GYo5+pcyFg6lCUsbUiE9ZdwxuwalzQnJommTfNTnF5OpZC3BNgXamJrWPeGb6Q01Q0O4nP7FA/
 zS9su4wZ8W/dEEqa5nGozsIkwNCIH1tx5avLX3aa2nGuxwNVEZuSDpv3iLflCrJghSSa2+3VDnl
 2cDtYGHuANb+mCnzf175T91miThV/EzgdU8yP24fz4IQ/nPLnUjRL2BAdiQUMbCsBCC9c5K7pnM
 rjD7vjG5GvxBOghcXBICejDGTUqDeVUOTxgctDguGmcFLAN1hDQLwD+bQGMs7YRavWIoV+Dxdtm
 RMfwO892VTK8J3adr85RhHspuRGXkhPnU85Mec0IrHceYW6pZmMgdHJ5w
X-Received: by 2002:a05:620a:28c8:b0:8cf:d953:b4ec with SMTP id
 af79cd13be357-914b497c533mr312758585a.3.1779449265278; 
 Fri, 22 May 2026 04:27:45 -0700 (PDT)
X-Received: by 2002:a05:620a:28c8:b0:8cf:d953:b4ec with SMTP id
 af79cd13be357-914b497c533mr312755185a.3.1779449264847; 
 Fri, 22 May 2026 04:27:44 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-688bb13312fsm560271a12.22.2026.05.22.04.27.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 04:27:44 -0700 (PDT)
Message-ID: <9b3c6567-a432-40e4-aca2-4ed92436dbe2@oss.qualcomm.com>
Date: Fri, 22 May 2026 13:27:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] drm/msm/dp: Drop the HPD state machine
To: Val Packett <val@packett.cool>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
 <9c4dad2c-25bd-47d2-bc40-9b551d023615@packett.cool>
 <a6190a6c-60ae-4d24-b396-089f3b42973f@packett.cool>
 <itszs6eu7l2zix4stdiokftgxjpqlfukbqbdg4u3sestln6pgl@yq3wud26vi25>
 <38e87937-194f-43ca-ab27-a3a9cf7267d4@packett.cool>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <38e87937-194f-43ca-ab27-a3a9cf7267d4@packett.cool>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=DKm/JSNb c=1 sm=1 tr=0 ts=6a103db2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=YME4jNqvwn4WW7v3Y9AA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: aYMILEhxR_moxVLtQCsiV1b1h9JgRSvS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDExNCBTYWx0ZWRfX/g0BsUKXifcL
 +zz1wcW8Qk+MSM5Az/TzQ3nXEy7pWs0fRpChZbuhKQdRymD8nBk+sUO7ReQVZo2iAnsvYs/7R4C
 mKgIRfp153yJPFTiSa1xyay1q2b/q4v1zkDivIhX8Zl7HqIx6G7Kfi1uHv0l9hurBPZMImfNiZ6
 AaYm2tA7XjDxIbRehJbQDR0HmpEx0Sh8XS6L+is6nL5Zo/NlRwXtpgMcwuQ/JK6IuA5PHmysqj8
 oDVoj35v+/O/8OaofFOsXpTzN8rmgI8zOzt42pOw8SmVkCjF46RRmOrJ4ESfPsIH9TZIroQvrbH
 SQTx5mZf5p+b4AE6UcELQNgmErD7Ho8ByPF/j+KPXqbJj0CuQ2F05DLwl+pMwJ4asrIY91KKhPM
 lUC10o3p8mNgWFwmkzy+Fi+Goxu5TegUPjuEwQ/BJLHdTIsvw1rkofbJmlO93Th8D1uRTyDUMCh
 +BOW7qhka43pewYE4Mw==
X-Proofpoint-ORIG-GUID: aYMILEhxR_moxVLtQCsiV1b1h9JgRSvS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220114
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

On 3/18/26 12:15 AM, Val Packett wrote:
> 
> On 3/16/26 12:23 AM, Dmitry Baryshkov wrote:
>> On Sat, Mar 14, 2026 at 10:10:26PM -0300, Val Packett wrote:
>>> On 3/14/26 9:51 PM, Val Packett wrote:
>>>> On 3/13/26 10:09 PM, Dmitry Baryshkov wrote:
>>>>> Currently, all HPD interrupt handling must go through the HPD state
>>>>> machine.
>>>>>
>>>>> This has caused many issues where the DRM framework assumes that DP is
>>>>> in one state while the state machine is stuck in another state.
>>>>>
>>>>> As discussed here [1], this series:

[...]

> [ 3362.364893] typec_displayport port1-partner.1: failed to create symlinks
> [ 3362.364902] typec_displayport port1-partner.1: probe with driver typec_displayport failed with error -17

I believe this happens when the PAN_ACK doesn't arrive in time

i.e. if pmic_glink_altmode.c doesn't write ALTMODE_PAN_ACK to
the Type-C service, which is influenced by the time it takes
for all the typec_mux_set() and typec_retimer_set() callbacks in
the chain to complete (which are called by the various flavors of
pmic_glink_altmode_enable_xyz() in pmic_glink_altmode_worker()
right before the ack)

Konrad
