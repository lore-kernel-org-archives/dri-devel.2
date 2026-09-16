Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6911FC88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 884F310E025;
	Wed, 16 Sep 2026 06:37:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ILKqrp7+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QwXdOxzk";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7152110E025
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 06:37:33 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G69mDU2780354
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 06:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AQ+wFIcS7R/qaD+wlIu1vUybEb7TOl8vT6jhLZTSv0w=; b=ILKqrp7+N1wCkRrs
 nLsngSEOjVJ4Se7FEQ1iUV1nCgLA7yCzm8iUPx6tsQrlSE+mvCg3a9WPt1Bxn7zL
 KeUXGlzm+v1Ss8EMBjk4K7w9GhzYGcP9meburL+vh5BJGcXaoDUQV7CYJt5zuQT0
 MyMVDiXjbqHsQRwTZSdoyS2O6wAnUpiUO1TnyOwQh/nmZZmJndPMDKuPbQmF6oBe
 QZr0PEnlP2PINYvG4aYJqXvjBNpXITeXRfBlZPFr71GfC+Emzi1mKlMO1MkwSRkU
 ZRxCADeLpv5CmwgeXaTX/iXVZ1mnewDdb52wg2TLcpWo9BPFJivl4tcQnpbuyANG
 pkhS0g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq6kc4ck3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 06:37:32 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-912330dd4dbso34543966d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 23:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789540652; x=1790145452;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AQ+wFIcS7R/qaD+wlIu1vUybEb7TOl8vT6jhLZTSv0w=;
 b=QwXdOxzk9gPC2o+rkyYubPGsA/DeTXlmzFeiYBj5Fmxo6nhRRVaNXjx5EUpDSqqv1z
 zGrRz2zzh8RgIUriy8ZIC7HvJvehQ3c6lwlZ19yVnavZSrZooMNuEAdNwoLc9c1001Da
 UusS4rGiksL3b/miFi6ObwNTCxNBiQu0/sRu+droSUAWK7QxVHV6x2lVNYescOlRMk28
 HpdpCCL7GjaWrpIIwU3bVuxP7TXylrBslZx9OSNeFApxGLZWxNdjmCmTIbOOYFNsKpyg
 eSCvVrVXrj5af+2LyHWCsNe5I4ndz/Uurww8bQgEQmCHGH//OmnjD2SM/oJuo68wc8aD
 npBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789540652; x=1790145452;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AQ+wFIcS7R/qaD+wlIu1vUybEb7TOl8vT6jhLZTSv0w=;
 b=x47600YAoaWJcT+DNq0LOAW+fscEOdkF2u2rMCeDhiwjDmiWQgX6FF6mukl2n17vQ4
 SqHB+MayJs+WlEF1KZAqzy0e2BprvFywCTo8vjxhTDZMrU1MU2NIoVmzb+e9cbimHNTl
 Uc9saCvNrcxd8KI3QwZa2fVn8XtF3DUvf7pKXll8/ATJppUGCoWodghR7D9PNpRZLG9D
 utUeSj4nM601m5AQKCvthGCjGSTL7Q6PUPC6KGfi4l5YBQ1hqYuKISQdIFYGHjhcDPYo
 xeCCkHl9j/+n4mrCJgeDuyEWUuzTe4sjng2Oq/0ooGH+2OPXXh024llKBWW8pwfl2CMN
 9CqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMJhtGE5GA/qyabhovI4fF35ZOLmBzo7RbfgBmeIubt2ighc6aj5MgDfzKiwsBTwhmr4WcnGRPcRU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n8mrmVjoYlk/HW7Pks6HNFNYVqcDXnFFcNg50keI0TB+JKSse/
 ip3No7muuni4bTMCIj6vyyOqujdbjlhKIycfucCSCXZx9+Ppuy5bEYDFXFDAUb6r7A+fmwI68bW
 3RKAXZLtTvGSFT+X4GGoHcZ5k84HH4szjQd4UTygw2DFaYp0n7EAaztgtrWtqjGNYx65FiR0=
X-Gm-Gg: AYBFou0l2qvwebalsheRRtpwDgBYsH6yfGTPh8oSrJVi/IH5TPOiuK0p8HIQ6WpYhQX
 v58na58Sh9FqfRuVdbm/FIuluTWFpxvWXZjBSzzB39JFVda/TwsINGnyeksuKmHPPBZDbvWWOE4
 caZNrhvGcQaoH6WESzMERkHr9e8JHfHKcGbPtxR1oqDiq6ALOPkiV4mwmldsYIdvI4HszX1Ab6p
 L+qrvoAakpxGPUX5jPBEsKYM/7PzI2CgveBZn2IBHy7MTF9wA0uo/+gZ6qc4ftRib/a1VFx0ezH
 U6kV2KNe1iCRUBgKVpuRv/r2eiV48iZFq7RmKKFL8q/nAPG+q6/+udTwMxHnJ8bM9PFmB5/5/jG
 drGF4eaFqExzcE3VkfDJf5SCFscICTVbBf9IoX96q/mN8EQlRsMsM1h87ihR+18/h
X-Received: by 2002:a05:6214:3186:b0:910:3923:cc76 with SMTP id
 6a1803df08f44-91234436ca6mr106063746d6.31.1789540651603; 
 Tue, 15 Sep 2026 23:37:31 -0700 (PDT)
X-Received: by 2002:a05:6214:3186:b0:910:3923:cc76 with SMTP id
 6a1803df08f44-91234436ca6mr106063206d6.31.1789540651009; 
 Tue, 15 Sep 2026 23:37:31 -0700 (PDT)
Received: from [10.38.246.144] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9123bddcf56sm18155886d6.2.2026.09.15.23.37.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 23:37:30 -0700 (PDT)
Message-ID: <ec70fa7f-4e02-484a-b7f7-ced7b81d3e44@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 14:37:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/bridge: allow hpd_notify() to suppress connector
 hotplug events
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
References: <20260629-msm-dp-msttypec-v1-0-646a10256233@oss.qualcomm.com>
 <20260629-msm-dp-msttypec-v1-1-646a10256233@oss.qualcomm.com>
 <cgk2httvebzm2jnjnb437mutez66tfozzdk77mjwukfzngdioh@mu46u3pwlf2u>
 <af5f2e4f-42a2-49f3-9c6c-0f910c5f9208@oss.qualcomm.com>
 <pyqpajtjcnslk6g5ysn3ce2csrb76fhd5bif4vdb6wezomlmsg@fsl55exyufx2>
 <dd375289-0174-41ad-980f-f027fad976f6@oss.qualcomm.com>
 <fcc816d3-e3d4-4dbf-8ae5-bbbac6e2189a@oss.qualcomm.com>
 <z7a7c2pe7aqpqlh7z6ep4fhctujnwaxqxukqaywjwvt3w7ahnc@j5i5f53c4fqu>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <z7a7c2pe7aqpqlh7z6ep4fhctujnwaxqxukqaywjwvt3w7ahnc@j5i5f53c4fqu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDA4MyBTYWx0ZWRfXyzBZGVm6b0tJ
 79HyYlXHLvpfIj9uoIuRh5vcWBQvOBHJuKY3yihtLmWEYpZh8JAsv4222msvz94m9eB0uczyuHx
 ceo7FxBSzQPMJ+oikHs7IERubl5FRn0=
X-Proofpoint-GUID: Lx9WllhupZAh4wWIreda3sDOegEyDaYS
X-Authority-Analysis: v=2.4 cv=ZINCCn7b c=1 sm=1 tr=0 ts=6aaa392c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=NHX6yGbTSU1aQjhbUZcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: Lx9WllhupZAh4wWIreda3sDOegEyDaYS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDA4MyBTYWx0ZWRfX0IXXSmznHe9p
 Oe2g97nZ+wafGbzPhSvFSCPGz8+G4gb+ch1IE1QTJ8Pawlxc5dPG6EkkJuMRSFdg2sCsVrV6cbc
 LhkTTPF5qmibk7JkLksoIDN1fhQ6sHFnlsfaZ3ivLvGEMS5qQmlI1l8BZXu56a8m0cXDwJoHuwq
 HU3qcs5IP1IUM9wHjENCEbRnTN6W8uPwLiY7fgqPn7cvJ9YNj3llt3lO6C2qP4kx0RI/BivCvyR
 bo+npRocd/0CRrMK1NWXLw1fYATbZzy00p2jXCj+pQ5bsh0XHOorjXFR8jFm42aXjVsVKJNSd4j
 C4bGpM07zJPm97XL3DoCNsr8NlqcGAOX/Z+CZrLITgLWX/8PagO392qhBsVNVoQkbgBe7Qkwxx4
 ++RN6xMIJytRE/Ouhb/7KUgtj/dekCrJofDgOuGCC1N1ralgi4l6I2TF4ozRcK8QobrjsWjIMO8
 F0QxA94F76mczv3I/+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160083
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



On 9/8/2026 9:10 PM, Dmitry Baryshkov wrote:
> On Mon, Aug 24, 2026 at 11:15:44AM +0800, Yongxing Mou wrote:
>>
>>
>> On 8/21/2026 3:20 PM, Yongxing Mou wrote:
>>>
>>>
>>> On 8/18/2026 11:01 AM, Dmitry Baryshkov wrote:
>>>> On Mon, Aug 17, 2026 at 04:01:41PM +0800, Yongxing Mou wrote:
>>>>>
>>>>>
>>>>> On 7/12/2026 6:21 PM, Dmitry Baryshkov wrote:
>>>>>> On Mon, Jun 29, 2026 at 10:48:03PM +0800, Yongxing Mou wrote:
>>>>>>> The bridge connector framework currently invokes all bridge
>>>>>>> hpd_notify() callbacks and unconditionally emits a connector hotplug
>>>>>>> event afterwards.
>>>>>>>
>>>>>>> However, not every HPD notification requires a userspace
>>>>>>> hotplug event.
>>>>>>>
>>>>>>> In particular, DP MST bridges may use hpd_notify() to
>>>>>>> propagate HPD and
>>>>>>> IRQ notifications through the bridge chain while the actual hotplug
>>>>>>> handling is performed by the DRM DP MST core. Connector creation,
>>>>>>> removal and userspace hotplug events are already managed by the MST
>>>>>>> topology framework.
>>>>>>>
>>>>>>> Allow hpd_notify() implementations to suppress the bridge connector
>>>>>>> hotplug event by introducing a bool *send_hotplug parameter. Drivers
>>>>>>> can clear this flag when HPD processing should not result in a
>>>>>>> connector hotplug notification.
>>>>>>
>>>>>> Why? Worst case the kernel receives another hotplug notification which
>>>>>> gets ignored by the driver.
>>>>>>
>>>>> Hi, thanks for reviwing those patches.
>>>>> Let me try to explain the motivation.
>>>>>
>>>>> Semantically, IRQ_HPD is just an IRQ notification, not a
>>>>> connection state
>>>>> transition, and shouldn't be turned into a userspace hotplug in
>>>>> the first
>>>>> place. However, drm_bridge_connector_handle_hpd() currently calls
>>>>> drm_kms_helper_connector_hotplug_event() unconditionally after
>>>>> processing
>>>>> the event, so every IRQ_HPD ends up reported as a hotplug.
>>>>
>>>> What if the IRQ_HPD is delivered together with the first HPD event (for
>>>> example because of the TCPM processing those events)? See the mechanism
>>>> in the displayport.c AltMode driver.
>>>>
>>> The DRM API should simply pass both long HPD IRQs and short HPD IRQs to
>>> the driver as they are, and let the driver decide how to handle them.
>>> Based on my review of the implementations from all three vendors, when
>>> long and short HPD IRQs occur simultaneously, the long HPD IRQ is always
>>> handled first, followed by the short HPD IRQ.
>>>
>>> I have another thought regarding the current DRM API. Could we have the
>>> DRM layer pass only the HPD event information (long IRQ and/or short
>>> IRQ) instead of connector status, and leave all handling decisions to
>>> the driver? The DRM core would simply report LONG_HPD | SHORT_HPD, and
>>> each driver could decide how to process the event. This seems like a
>>> pattern that could be shared across different drivers.
>>>
>>> This is just my current understanding. Please let me know if I've missed
>>> anything or got something wrong. Thanks.
>> Sorry, after thinking about it again, this idea is not fundamentally
>> different from your current approach. In the end, we still need to handle
>> HPD state transitions in the driver. It seems my previous suggestion does
>> not really simplify the problem, so I apologize if it has caused any
>> confusion or misled the discussion.
> 
> No worries.
> 
> I'm currently stuck between two ideas: continue pursuing the current
> "single API for both events" or implement new "two API for two events".
> I think that the second might sound more plausible, but in the end it
> would complicate drivers much more, because now they'd need to handle
> synchronisation issues on their own.
> 
> If we start from the DP AltMode, we have a single state word which
> specifies exactly, 'HPD pin status' and 'was the IRQ_HPD captured'. Our
> DP controller also has about the same status word: the connected status
> and the IRQ_HPD pulse. Which (for me) points out that the single API is
> a correct way to handle the HPD/IRQ_HPD.
> 
I’m not objecting to the single-API approach. I’m just not completely 
sure yet how it simplifies the driver-side handling, since the driver 
may still need to deal with HPD and IRQ_HPD arriving at around the same 
time, or IRQ_HPD arriving when the link is no longer present.

For reference, Intel, AMD, and Nouveau appear to process HPD state 
changes and IRQ_HPD handling in separate workers. I’m not sure whether 
that is relevant here, but I thought it might be useful information.
> Now, coming to the drivers/userspace side. Let's leave the MST story
> aside for a moment. For the DP branch devices connected to the USB-C the
> AltMode will always report 'connected', but the DP's detect callback
> would rightfully report 'disconnected' if there is no actual monitor.
> The kernel should do it's best in this case and report that the
> connector is disconnected without any interim states. I think we do it
> already. The compositor should do it's job and skip full scene
> evaluation of the disconnected connector gets disconnected again.
> 
Agree.
> Event filtering. Historically, drm_bridge_connector was trying to filter
> HPD event. We had to remove it because for the DP prefiltering doesn't
> work. This might have left the gap, which now needs to be filled. The
> bridge_connector uses drm_kms_helper_connector_hotplug_event() which
> just reports the even to the userspace. Consider reworking
> drm_bridge_connector_handle_hpd() to behave more like
> drm_connector_helper_hpd_irq_event(). Execute hpd_notify under the same
> mutex lock, capture if the status has actually changed afterwards and
> report it to userspace only if there was a change.
> 
Yes, i want to update a new verison to do this and update the 'HPD come 
with irq' case. One question, do you have any rough timeline in mind for 
the next revision of the IRQ series?
>>>>> Second, MST IRQ_HPD is level-sticky -- as long as the ACK has not been
>>>>> cleared, the IRQ keeps firing repeatedly, and MST bring-up (link
>>>>> training
>>>>> / MST enable handshake) itself generates a burst of IRQ_HPDs. So this is
>>>>> not about "one extra hotplug", but about a burst of them within a short
>>>>> window.
>>>>
>>>> Ok, if it is level-sticky, it should be handled as such.
>>>>
>>>>>
>>>>> Every one of those hotplugs is delivered to userspace via udev and
>>>>> prompts the compositor to re-probe the connector. In the window before
>>>>> mst_active is set, that re-probe walks back into msm_dp_bridge_detect()
>>>>> and performs aux/DPCD accesses, racing with the MST enable flow.
>>>>
>>>> If there is a race, the path needs to have a lock, preventing concurrent
>>>> access. Otherwise, you are just shortening the window instead of solving
>>>> the problem.
>>>>
>>>>>
>>>>> The amplification also isn't limited to a single connector: on Hamoa
>>>>> there are 4 connectors (3x DP + eDP), and we observe that a hotplug on
>>>>> any one connector causes the compositor to re-query all 4. So this burst
>>>>
>>>> Please fix the compositor, it should not need to query all 4 connectors
>>>> if the HPD event came from the single one.
>>>>
>>>>> of spurious IRQ_HPDs during MST enable ends up amplified across the
>>>>> whole card.
>>>>
>>>> How do i915, amdgpu and nouveau respond to IRQ_HPD? When do they send
>>>> the HPD event to the userspace?
>>>>
>>> The driver revalidates the actual connector state, and a hotplug event
>>> is triggered only when an actual connector state change or a link status
>>> change is detected.
>>>>>>> A NULL pointer indicates that hotplug suppression is not supported by
>>>>>>> the caller, such as the connector detect polling path.
>>>>>>
>>>>>> And nothing in this patch makes any use of it. I'd say, it's
>>>>>> questionable addition. Let me check other patches...
>>>>>>
>>>>> You are right, I will reorganize the patches in next patchset.
>>>>>>>
>>>>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/bridge/lontium-lt9611uxc.c     |  3 ++-
>>>>>>>     drivers/gpu/drm/display/drm_bridge_connector.c | 15 +++++++++------
>>>>>>>     drivers/gpu/drm/meson/meson_encoder_hdmi.c     |  3 ++-
>>>>>>>     drivers/gpu/drm/msm/dp/dp_display.c            |  3 ++-
>>>>>>>     drivers/gpu/drm/msm/dp/dp_drm.h                |  3 ++-
>>>>>>>     drivers/gpu/drm/omapdrm/dss/hdmi4.c            |  3 ++-
>>>>>>>     include/drm/drm_bridge.h                       |  3 ++-
>>>>>>>     7 files changed, 21 insertions(+), 12 deletions(-)
>>>>>>
>>>>>
>>>>
>>>
>>
> 

