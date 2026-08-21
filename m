Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA18C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 07:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CEB210F240;
	Fri, 21 Aug 2026 07:20:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cVEICEyT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gdFNLWyM";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C7F110F23E
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 07:20:52 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L5TaR5503702
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 07:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U4hIfsztrJ5/Bunzr0Zeq8RzRG+Rg+6qQ9vg35INQbw=; b=cVEICEyT5E6nAFNG
 2Se+uBa/wtqan+H2cfzDMIjfK/vHT20R4YCL7+6CmHUk/xTgmLdIEcbsWA+fZpvj
 H9hmGhLFwPdMSB6dwQIHtYbPn55bNV4pHFpMcQ79UuXwjor6DwP8UF6ojhZBXS6x
 nArFj66KhIREoTlJ8PYKiPJrUzRaM3GAHo3AJngR0U7G3unrKjiUaS4lS10BY/8j
 1Es2j3Zra1sskBdl5A5+C0Z7nRT+hrpygT29ulNtRlah95iKzEgLM0M3iW06WGlP
 IaIinyWQUjPApye+jlGeBb28spz6yqZrChTZZN8MsM4IM1lDG5Wj10OTYlVnzNSW
 r+Ef5w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gde8cey-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 07:20:51 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38f97b3f853so1073222a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 00:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787296850; x=1787901650;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=U4hIfsztrJ5/Bunzr0Zeq8RzRG+Rg+6qQ9vg35INQbw=;
 b=gdFNLWyMkabQ03nPe2g7RGasQMrhubMvMf+1Fc57ZTbBFU7SjxTG6OennChJxWR7kF
 TJxyP7xN28mWEC8rnxsqlOMgFZoux0PaLyasxXu9Dvjo16DaCayIFDVstINQAWyIapu9
 Pdn5ekp8oxhkl/cOkXFoy/Aq4FloDogqg6+qNVl/eO+W7gQAxJkOtAcO3mBKcFs+a28F
 3RkkdJbk3T53VNqNSjxzObemGNGiT16avLjV5aODlGwJTOJn5Nfw75I0R7P2PMc5ru8F
 Bzq6uaIHpUM+ZqFt9fGIZ1tlIVshVnEPng/776qgBV/33mcnYUg8ule7LCgjVMTorBT4
 SDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787296850; x=1787901650;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U4hIfsztrJ5/Bunzr0Zeq8RzRG+Rg+6qQ9vg35INQbw=;
 b=F4De7skzzREFIVirbtOVDIylz0EruZEFV/scHpElu9lJ3M4ryY0q9WtlbMH0UiP382
 gYGIMkw+i75L1TkcPGjDiPId4WCORzodTOg3kYq5MNQdnzakqGuY81YV/xWYzxH2q5e5
 GuUNcLLHfLiKgAiG4HAUXK1Xex3/bsiXNIGDZKnYKg/OzGrRmM6Pqxmv1iaEageKrlXS
 495WJJKIlhABH81KstF586RgEmKnDqp+kkTDRcPfQeR5sk10srHNZEujTYsX++3d4sna
 EJUBc+kEr4CAiRWV1HjrwTelqFBRYI9JH6L557FX/VXEXOkDOBeswa4SOh+8k/Yo7Z+R
 VFQg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrB45ijKgucDniV0OwUpYUtRwg0sVMbDrfrtUV+jBsov+5r6jenC1QMrpH71SXMYHMaQeM2WNRTs1s=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kQnxyQkSu+Nn9VGmWkrHSQXeb5rG+LIYUGI1dWqGdm27OgIkPS
 aPa/8uL89Cs4YSdKiROkMCbYcOGZ0I0KrSh/sVpUsZxEAcqFS7y/qQGuEynbGvr3V/zff6o7O5T
 Keu+HQKpqC3kaWcwmJ5ukU4XYJxPfoBVxi9wUYb8eghZqJot72V8nMEsYdyBoVHW1gd/Zgq0=
X-Gm-Gg: AR+sD11LUwxrMKB/nNr5li3bsjt2B7lPIPCvYZosZ6CJ7KD1tZdjWd4ZP0y7+PkodKO
 Q7d/5QNBj6nOxz8r2VEf5mSn7kpjEmAoY132nOVhLpK+7+I4u0dC+oNPnAsNFQFfhMEi3joKYah
 D8iHWPlgUviMaM6xUDI0yBF2W8QVBBTDojUi/yeC0UtifqBNJtvKnPAaX1/ASgThrx+sS02p6Pn
 jDRxw2epBZWwWQm3b6n9wSqT1FKPe7GdALcnMvs959u4ibwwUPOlqHRJfLCqEkVXhWB7O0//Ji8
 NQkEgRVFy1NqHQf5em6aE/NHP54VGG9yV3iTTRKIAqsCzMy1Px27oV5Yj6Stadqx8tkQ8iW/9tx
 ED+Zm6ptORFazVD3I01g4pmHUgE9WEttx6Dp3Myo20VzR+m3VKnCUTlrNyWgC81HFW2+ciRc=
X-Received: by 2002:a17:90b:2ccb:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-395c35ba5aemr8334022a91.10.1787296850326; 
 Fri, 21 Aug 2026 00:20:50 -0700 (PDT)
X-Received: by 2002:a17:90b:2ccb:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-395c35ba5aemr8333915a91.10.1787296849773; 
 Fri, 21 Aug 2026 00:20:49 -0700 (PDT)
Received: from [10.133.33.40] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c46b88e9sm1995751a91.7.2026.08.21.00.20.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 00:20:49 -0700 (PDT)
Message-ID: <dd375289-0174-41ad-980f-f027fad976f6@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 15:20:38 +0800
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
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <pyqpajtjcnslk6g5ysn3ce2csrb76fhd5bif4vdb6wezomlmsg@fsl55exyufx2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BcroFLt2 c=1 sm=1 tr=0 ts=6a87fc53 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=h0lqEGe5wbmRA1m2260A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: zDrsGG9xbuhc3LTTqbSodtNj83NJa900
X-Proofpoint-ORIG-GUID: zDrsGG9xbuhc3LTTqbSodtNj83NJa900
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA1MSBTYWx0ZWRfXy0B6zsAAJPFZ
 RRgVGP5gKroNq3TS7ow8Ga22T3sv9CiRMjpeuJQXyIfwU9C4dAgpDv4aUlk82ZMDbYpMQcjevYV
 rcK3dgl3icJUDkZ2K27JbmANB8J7r5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA1MSBTYWx0ZWRfX0BAeJOk6WzEp
 cnYsxz59dWkrFP1u7RWhrlvqfjkD/qLoAajJwNKEyN+dnLcqBk4XKWJX4vCEGxSI+Zc9uy5/0U1
 YHrzKGaXwumz98hYtRWQWzpFR2UL+D0zs+XZ+e+9QnrqvX7U9XO4Bww7qt6fHUlBSSIqJkeB2Ur
 7PqhOEGGSD9aC4NGifO25Jm2MzVfOjUhW8EmVxMWWqAo0lGOut1rdKurfKmXN9EeVFdP5DY7PpL
 mW8/Wy4uuE75trrJLGYxw8FIwbiw2yF5x01jlDHqaAbwstNcOrb1yu4GrOkimFYPuxw2CL1iA9H
 fd6kCEbBuOtAwO0iQTIHMATJ/I1LzlEE5o2La52z2g4Y5QyNfYvESAzSxLv5qwy3HFAsYRZjXKN
 gKPAtajRaCGzDHqYPh2c0E6H/SpUGE/Ed1etFfdvnRkAHN3okG5EAWQQab3g3J8gASL+jhz3qhz
 TclO0GEfzD8IRtM/Ftg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210051
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



On 8/18/2026 11:01 AM, Dmitry Baryshkov wrote:
> On Mon, Aug 17, 2026 at 04:01:41PM +0800, Yongxing Mou wrote:
>>
>>
>> On 7/12/2026 6:21 PM, Dmitry Baryshkov wrote:
>>> On Mon, Jun 29, 2026 at 10:48:03PM +0800, Yongxing Mou wrote:
>>>> The bridge connector framework currently invokes all bridge
>>>> hpd_notify() callbacks and unconditionally emits a connector hotplug
>>>> event afterwards.
>>>>
>>>> However, not every HPD notification requires a userspace hotplug event.
>>>>
>>>> In particular, DP MST bridges may use hpd_notify() to propagate HPD and
>>>> IRQ notifications through the bridge chain while the actual hotplug
>>>> handling is performed by the DRM DP MST core. Connector creation,
>>>> removal and userspace hotplug events are already managed by the MST
>>>> topology framework.
>>>>
>>>> Allow hpd_notify() implementations to suppress the bridge connector
>>>> hotplug event by introducing a bool *send_hotplug parameter. Drivers
>>>> can clear this flag when HPD processing should not result in a
>>>> connector hotplug notification.
>>>
>>> Why? Worst case the kernel receives another hotplug notification which
>>> gets ignored by the driver.
>>>
>> Hi, thanks for reviwing those patches.
>> Let me try to explain the motivation.
>>
>> Semantically, IRQ_HPD is just an IRQ notification, not a connection state
>> transition, and shouldn't be turned into a userspace hotplug in the first
>> place. However, drm_bridge_connector_handle_hpd() currently calls
>> drm_kms_helper_connector_hotplug_event() unconditionally after processing
>> the event, so every IRQ_HPD ends up reported as a hotplug.
> 
> What if the IRQ_HPD is delivered together with the first HPD event (for
> example because of the TCPM processing those events)? See the mechanism
> in the displayport.c AltMode driver.
> 
The DRM API should simply pass both long HPD IRQs and short HPD IRQs to 
the driver as they are, and let the driver decide how to handle them. 
Based on my review of the implementations from all three vendors, when 
long and short HPD IRQs occur simultaneously, the long HPD IRQ is always 
handled first, followed by the short HPD IRQ.

I have another thought regarding the current DRM API. Could we have the 
DRM layer pass only the HPD event information (long IRQ and/or short 
IRQ) instead of connector status, and leave all handling decisions to 
the driver? The DRM core would simply report LONG_HPD | SHORT_HPD, and 
each driver could decide how to process the event. This seems like a 
pattern that could be shared across different drivers.

This is just my current understanding. Please let me know if I've missed 
anything or got something wrong. Thanks.
>> Second, MST IRQ_HPD is level-sticky -- as long as the ACK has not been
>> cleared, the IRQ keeps firing repeatedly, and MST bring-up (link training
>> / MST enable handshake) itself generates a burst of IRQ_HPDs. So this is
>> not about "one extra hotplug", but about a burst of them within a short
>> window.
> 
> Ok, if it is level-sticky, it should be handled as such.
> 
>>
>> Every one of those hotplugs is delivered to userspace via udev and
>> prompts the compositor to re-probe the connector. In the window before
>> mst_active is set, that re-probe walks back into msm_dp_bridge_detect()
>> and performs aux/DPCD accesses, racing with the MST enable flow.
> 
> If there is a race, the path needs to have a lock, preventing concurrent
> access. Otherwise, you are just shortening the window instead of solving
> the problem.
> 
>>
>> The amplification also isn't limited to a single connector: on Hamoa
>> there are 4 connectors (3x DP + eDP), and we observe that a hotplug on
>> any one connector causes the compositor to re-query all 4. So this burst
> 
> Please fix the compositor, it should not need to query all 4 connectors
> if the HPD event came from the single one.
> 
>> of spurious IRQ_HPDs during MST enable ends up amplified across the
>> whole card.
> 
> How do i915, amdgpu and nouveau respond to IRQ_HPD? When do they send
> the HPD event to the userspace?
> 
The driver revalidates the actual connector state, and a hotplug event 
is triggered only when an actual connector state change or a link status 
change is detected.
>>>> A NULL pointer indicates that hotplug suppression is not supported by
>>>> the caller, such as the connector detect polling path.
>>>
>>> And nothing in this patch makes any use of it. I'd say, it's
>>> questionable addition. Let me check other patches...
>>>
>> You are right, I will reorganize the patches in next patchset.
>>>>
>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>> ---
>>>>    drivers/gpu/drm/bridge/lontium-lt9611uxc.c     |  3 ++-
>>>>    drivers/gpu/drm/display/drm_bridge_connector.c | 15 +++++++++------
>>>>    drivers/gpu/drm/meson/meson_encoder_hdmi.c     |  3 ++-
>>>>    drivers/gpu/drm/msm/dp/dp_display.c            |  3 ++-
>>>>    drivers/gpu/drm/msm/dp/dp_drm.h                |  3 ++-
>>>>    drivers/gpu/drm/omapdrm/dss/hdmi4.c            |  3 ++-
>>>>    include/drm/drm_bridge.h                       |  3 ++-
>>>>    7 files changed, 21 insertions(+), 12 deletions(-)
>>>
>>
> 

