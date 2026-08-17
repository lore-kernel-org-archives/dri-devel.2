Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B320C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 08:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE8A610E6AC;
	Mon, 17 Aug 2026 08:02:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="M4gF4Is0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AL0LJNWZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 663F310E6B6
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:02:07 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67H711In4118163
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EfLblXrI2Wp6ZlzzoorT7wBL5Mi+F/9m9+D7Kvm7TA4=; b=M4gF4Is06pSxY56K
 W3KOFtNM5HsHAYjpCFDzpoJ8wMRVNUAmT2p7b3Ribex5cvyTG+ubAFfuKJNMPV1N
 AyyWnFu09qGPCbxSLwSBLZTZmiSPOsuxNXRLNAvvWPdtlSTi+IjWVy3VWYIXPwfQ
 s3cgXIHPxH9ppMlXGOgudH0+gUzaTEJ4lrdVj66mpLEk6/AKr8zucnJmH9YvsVXb
 jYf3fYfEroD61AVJdHht0op+O4V7Rmybt3iBm+z8g82NNK6C8rQdJg+Txf+5jWUF
 TEsLJfeveNsl4UAdW2TQSAe3iGzW257Tk8eRvYFsWO8q2Aoso5mtZsqenJy9NGP+
 2WXRtQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghfe18p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:02:06 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso60549781cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 01:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786953726; x=1787558526;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EfLblXrI2Wp6ZlzzoorT7wBL5Mi+F/9m9+D7Kvm7TA4=;
 b=AL0LJNWZ9AE9y+lv3tys8cN8Je1eW36IbgW3ZnQCllIYREVUHlQ5E9EFJTm2Jg1ZYV
 C3ZdvBXHs/wnXEfCIxtXRFAzEpSv6/H1qXddsO5Yf8y+hDKe7sqN9E2eex7Dn1mVfyxp
 Z/HSud6MqKhJHjbuhmLFetVI9t655VwQPRyOqhOK1UCIqowLsPo07EFiiOP2kPlKwcr5
 xZhiCY1tBJRcLXag1ccGjMEfZWmqzEpKw6HtA6HiXIMBWA3gz3EoRrHvtJDOrAWb/yqt
 UAddrgaEz5Twaf9RgDUdAsvr6YVy6KuckLSh41bn7XFzcEYgtlEFsde4WZb0aKvqSzJS
 KanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786953726; x=1787558526;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EfLblXrI2Wp6ZlzzoorT7wBL5Mi+F/9m9+D7Kvm7TA4=;
 b=YF3/b+qxMbTLIwn68AXhRgiK1yh+sTwK3VnkRXu9SSgh/jwqPPoxTC/wHXwB8jIPf4
 anv3Kya/ERRIJ27dScKna3sMqYbUUAVqKBElX0Yq8xm5zP/V2+yzqgiUsxkbSlIHmRVN
 Anq73neapQPS7WCOuWjL9AUx2ju6sAVZrJDtyBjY2cHz42GkhAR+ItM0Tq3U15ZCCaeR
 XhiR4WhNkRFJq7Egei1MxyVFjKsi3CFTmDq7pKTV1mNSJDTTToAMt4ztEsAyFHoDt+i0
 RAeb3X8K4PClub+iqRD/z9a5eRcK3wQ6xyFZHbdEAZBdIyRKShWag9mWjisKhxkVygSc
 TvmQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFnpknEofrmpiRLOhp+HjYwSzoMKcjwcE/5ce3qRtkQ8DBreDFa4BtlpUnWixVajR8g1KOVEhQjOU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxpQ2IBgb1wkWiT3Ye88/agK+zK2aWHdMku92Lfm+Vl25cTJOFB
 lSsy06lDaMEJOwjfLOVPJwIERnaD9VKTF3mFlqZ1Ez0tl5LifPcqm06/v6orVESUK1vCbIP5gb8
 wW12ssC7Rgvhtqj6Sjr7FmSDiGJfkN5OZKckJDNmGeh6Fo2W3V9ytvFVUoePZKjIgTaFC6g8=
X-Gm-Gg: AR+sD108Qn3ENKEsuRQ6AC4PE/KqpFTXWtyMN0uBTtof8MxHs580L2eLahOg3goivh4
 XYRb4NmIpPfT3iEJOXt1p1d3sElH5K9xJmTjTGpY/TCcOGfTLlI6gNixBmpnJFOGk7F/YI3BXRW
 yko9OwgbeeDtf28t/MHGOuFoWNHV2d4h31GjkLM90mocHGHn5E8IWE4w+/IhFAaQBocY4WgIjRW
 QA3D1zSC0cY/XePLT0B9xqx1wwSZZrWdOVL8YGnE5YH1XIPAxPuCCNPY5H/GUOfAkmGbv0ZCmhs
 E8bRaUKMN0CAt/dgJOggIjHFdUESfCMbiT3yCMMDIISZ7HXDcycj3ZMIYfTF+hQVU54TDgsvoMa
 DRZwybpb81DNTxARrtXUP6hwg4QoL1vJ5mtFO28EaEwu4R7Hjx0S/5Vo1bdAoQMl0+A==
X-Received: by 2002:a05:622a:1488:b0:52b:4f1a:5fde with SMTP id
 d75a77b69052e-52d85380e96mr249900971cf.19.1786953725648; 
 Mon, 17 Aug 2026 01:02:05 -0700 (PDT)
X-Received: by 2002:a05:622a:1488:b0:52b:4f1a:5fde with SMTP id
 d75a77b69052e-52d85380e96mr249900321cf.19.1786953725258; 
 Mon, 17 Aug 2026 01:02:05 -0700 (PDT)
Received: from [10.111.162.109] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db612c2bfsm8319271cf.11.2026.08.17.01.01.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 01:02:04 -0700 (PDT)
Message-ID: <af5f2e4f-42a2-49f3-9c6c-0f910c5f9208@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 16:01:41 +0800
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
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <cgk2httvebzm2jnjnb437mutez66tfozzdk77mjwukfzngdioh@mu46u3pwlf2u>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfX9cqPRdD7h/Wt
 9l9xLpqkFCsnAW1uRGkdCiM6ggOt7hs0XzqY1RCS9vt4deA2zIF2H0I1Zakb6mLjpk/rs4oWJeL
 H0RCFG6y1ZGYdiQIqM5dCtebEAikHFo=
X-Proofpoint-ORIG-GUID: DQN9qijJ4TaRHtd38gr6zvnwRjZeApj2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfXwbJe6p72Efop
 Mf6M5d1PD+JRlVDEUGNlmHr/m6WYzzBcJ7+qN5QaWtjwD1F2GXBhDWDIYYO2BoThKXleKcgs2O3
 U2iTCGWQdSs3JAKas0wkU+h1GvCJQsqizEfClsdHWvHf6uB9wOY5sicojquaK3MojDsyDdRaOWz
 D2kUfSvhBxPNZGg1GAu7MTGUaz2lBbL9HLHJPbInf+ebyzCFZJSr94vO2BsuiXRiHidu+rrl8sd
 pOAk+PRAnIupuktwnkdBkPHEcCNLHBpvoZapbgFd7pKFitFMQ7OTHrAoRY1lehVfc2tqWeMVGHS
 JKwyYI7O2OVEAyTyyH6JtnlJmwjQwrmFx4+PpyxE2b3TgJXzgC06tMKAtsjonxMl0ClBRIR6nPX
 t65B61E0oZNVOMcpNa3govjkHQ/BxvUF3AjgpGD+OAYNoOmu0xGBNnGOusaZ0JZhfZ3i3Os5oGR
 Pj9DXi04743tvWh358g==
X-Proofpoint-GUID: DQN9qijJ4TaRHtd38gr6zvnwRjZeApj2
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=6a82bffe cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=EPiK6WrKEJDDbvHRsiMA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170059
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



On 7/12/2026 6:21 PM, Dmitry Baryshkov wrote:
> On Mon, Jun 29, 2026 at 10:48:03PM +0800, Yongxing Mou wrote:
>> The bridge connector framework currently invokes all bridge
>> hpd_notify() callbacks and unconditionally emits a connector hotplug
>> event afterwards.
>>
>> However, not every HPD notification requires a userspace hotplug event.
>>
>> In particular, DP MST bridges may use hpd_notify() to propagate HPD and
>> IRQ notifications through the bridge chain while the actual hotplug
>> handling is performed by the DRM DP MST core. Connector creation,
>> removal and userspace hotplug events are already managed by the MST
>> topology framework.
>>
>> Allow hpd_notify() implementations to suppress the bridge connector
>> hotplug event by introducing a bool *send_hotplug parameter. Drivers
>> can clear this flag when HPD processing should not result in a
>> connector hotplug notification.
> 
> Why? Worst case the kernel receives another hotplug notification which
> gets ignored by the driver.
> 
Hi, thanks for reviwing those patches.
Let me try to explain the motivation.

Semantically, IRQ_HPD is just an IRQ notification, not a connection state
transition, and shouldn't be turned into a userspace hotplug in the first
place. However, drm_bridge_connector_handle_hpd() currently calls
drm_kms_helper_connector_hotplug_event() unconditionally after processing
the event, so every IRQ_HPD ends up reported as a hotplug.

Second, MST IRQ_HPD is level-sticky -- as long as the ACK has not been
cleared, the IRQ keeps firing repeatedly, and MST bring-up (link training
/ MST enable handshake) itself generates a burst of IRQ_HPDs. So this is
not about "one extra hotplug", but about a burst of them within a short
window.

Every one of those hotplugs is delivered to userspace via udev and
prompts the compositor to re-probe the connector. In the window before
mst_active is set, that re-probe walks back into msm_dp_bridge_detect()
and performs aux/DPCD accesses, racing with the MST enable flow.

The amplification also isn't limited to a single connector: on Hamoa
there are 4 connectors (3x DP + eDP), and we observe that a hotplug on
any one connector causes the compositor to re-query all 4. So this burst
of spurious IRQ_HPDs during MST enable ends up amplified across the
whole card.

>>
>> A NULL pointer indicates that hotplug suppression is not supported by
>> the caller, such as the connector detect polling path.
> 
> And nothing in this patch makes any use of it. I'd say, it's
> questionable addition. Let me check other patches...
> 
You are right, I will reorganize the patches in next patchset.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/bridge/lontium-lt9611uxc.c     |  3 ++-
>>   drivers/gpu/drm/display/drm_bridge_connector.c | 15 +++++++++------
>>   drivers/gpu/drm/meson/meson_encoder_hdmi.c     |  3 ++-
>>   drivers/gpu/drm/msm/dp/dp_display.c            |  3 ++-
>>   drivers/gpu/drm/msm/dp/dp_drm.h                |  3 ++-
>>   drivers/gpu/drm/omapdrm/dss/hdmi4.c            |  3 ++-
>>   include/drm/drm_bridge.h                       |  3 ++-
>>   7 files changed, 21 insertions(+), 12 deletions(-)
> 

