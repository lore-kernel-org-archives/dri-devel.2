Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF358C5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 08:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26F6710E6BE;
	Mon, 17 Aug 2026 08:02:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gUv509Hg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZLJ2f0R1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5973910E6B6
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:02:45 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67H76l8C663012
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A3326y2xRLc4LUOS/GitWc6Ks0gAYMdIYlQfHxMHMgg=; b=gUv509HgWGlG+Cy5
 EE3RDEv0i9vuuJLaeB8aJ0tzpS9EjAqjMv1f11Yz9lx0tSWcVl+etNQzRDOoTVdC
 6AewY63wPCRhV9z1flQunFjlcHqDFAHeSuSarwETSe1Nw1XdvdGyo0Y/hwR6rVIm
 Zsi7XHeokjsYt+9ous1BsY44KEu/t/qdbu15C9vmJIRW7E90tu8qErSaS/ECR+tB
 Vb354AaMMaKw4O1fYxf79SeRhmMLEryUwFKxsTTH+437vd0CrTUr8yvLLVJz65UL
 Ap6+6FCmn3BUwAvncNCkyadR7GT3NYJu9tkcL7n4A44z3JT+umYVz4YEohrPNDz9
 Zmw7tg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghnwxy7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:02:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c19493ac2so32876061cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 01:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786953763; x=1787558563;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=A3326y2xRLc4LUOS/GitWc6Ks0gAYMdIYlQfHxMHMgg=;
 b=ZLJ2f0R1jrBocKuk9BNKRDfluwaULXg2BUjyH9O48MSK1YlM2B2ew1GkRNYGd2MBKV
 Yl3LaK+KK99/2SEgDwVsTZRFjx6alANqI1KUIdty+PgHT3D4jvkQbamfDurkJuTDFGbC
 VDGuLtvoMxTB2tgcp2UFN9to4JLjNFjQ6tgz+8lI25iiB0YfyMETMgP/7DZGakRH7pZG
 fYyW6Q1ZcbznRHVg4/IIn0z223bzvnDaSJ2uYSUJC+8mSKEb44kjEg3wMGZCsC4+ATn6
 wbkGEmd9V4XgJKW4iPIHR2pt/mMX6rIy3KsqhTYd8gvRWKgm6gozHCz/hFxkZCz/iX8i
 rxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786953763; x=1787558563;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A3326y2xRLc4LUOS/GitWc6Ks0gAYMdIYlQfHxMHMgg=;
 b=bcrLyQ0jTmQLWHadN+S6NeHfrPtIxEqd7TYjB8wSz1Z+IzY1Rr3YzhGwlbAA7O5qIw
 ouCCIf4JE5rFKcwDzQ3U2g0q1l6K5YNY77ze+KJlBPNEhCj1qpUkirAFAanYGMeNmswS
 VAl2O4hv1c+DncNNCuVSPm+DpcuxVGLLjDBlXt1QG/rbmijQVk1NWG2+A58YPLgpKYUM
 madaYI6xGpQyFeSH1vYMmkT2aO4WuISJEDAScVkBkw2dB3+HIFQx8KXxQwDysd8yrtzJ
 d8zkKNC0m0m8FpLhDW3zZIqyisoew8DWGhp4EdMXFSSdl8g8E5z1nWtb2Y3FnWZUhFGV
 2MYw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrDjQqrSwo7PuDVkWYCYMTfci72NfCMmIwQxCVb4nKLa1AmWN7PQois2ecFfYmvV+2BzO47Rdu+qZo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzqSAdr5vtgK1bGPW9yyBcR7xqvbiJfPWhKzuxmdnMFO4Xhvs2p
 s9QqfnbX3M/IRNVAizOqBSXXH4x18KCvgiAI8CX5O1G7yOVeuxJptZSGE1GHJEk1Y30aCdC0ZDP
 FxDU5od0iTSwxKnBxy0TSaWpCo6nawMUaH8C0YRMAqPcI8HB5cWjo++IyH9hZzPblndXHiKk=
X-Gm-Gg: AR+sD13doj6T5sdQxWjAGu2bsS9A6sQwuKHPzohtvh0O8a3x6UAkhDrXIgueETOJ/pb
 eKm57lUsebFozNwezxdF+98osfzakL/a9nwmNG/bzmVZ/3405nPFyyBw8tnekmLqC6jl+X65BgH
 LBHxAlrDGewYLLbgWlEsKonvXfsuJ/ACp1hRpEESGQeJpu6A8VVmoNwmgKKzPgaKxFgqLfwo8HD
 ky1w7M61Hr0cSX8pstJTWAGMHPx4hfbtFoIlJLwaoVc1HAUg6R+NiVEgnb96A3F6oBkfwAJGnyv
 6kJ6AT/pu/rkfriIMGwsHlmNvJrtQN4fczo95YA/c/n8lKFxEP4fk80Dy9DaslsarqWGMA4kk9S
 +532Mwd5KY/K1V+o8H/40vcbbG13eMZ6qeD895zeu1s/hrvcHHxejVa/WEbCQmDIT9g==
X-Received: by 2002:a05:622a:1308:b0:52d:41d0:89e8 with SMTP id
 d75a77b69052e-52d85519b7amr231184621cf.33.1786953763459; 
 Mon, 17 Aug 2026 01:02:43 -0700 (PDT)
X-Received: by 2002:a05:622a:1308:b0:52d:41d0:89e8 with SMTP id
 d75a77b69052e-52d85519b7amr231183591cf.33.1786953762519; 
 Mon, 17 Aug 2026 01:02:42 -0700 (PDT)
Received: from [10.111.162.109] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db623aed9sm8394031cf.23.2026.08.17.01.02.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 01:02:42 -0700 (PDT)
Message-ID: <c36875c1-2d22-4c16-ac2f-4f4a947ed69c@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 16:02:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] drm/bridge_connector: preserve connector status for
 IRQ-only HPD events
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
 <20260629-msm-dp-msttypec-v1-2-646a10256233@oss.qualcomm.com>
 <famoeog5snpvj24b6izwox2gy74ywnwmybflfv2tvr4hjuix5q@cbtce5s7k7sv>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <famoeog5snpvj24b6izwox2gy74ywnwmybflfv2tvr4hjuix5q@cbtce5s7k7sv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfX7z8+GvDjWVSO
 kk6bDhGtHdFCB9cM3navBW3+Bv2mbdPzDmJ+NMa+luqwPyEIZMUDWpDUXEcNip5zEA8tBhkJ+MR
 WcnUdKcuBlUSOMREy9giHB+swD+5hvcpG0VKvxxXNM7C2Qd0O+F+FMP/IrOjYp9tOlyzKGs8Ac5
 vx8GoDKq3XkbiWkWMP/M1S/Odo+u4LSeI5nuTnjnzghVxyXNcqu6gLGr2FfbeZc9pwepk5FjL+6
 gzlsh4bJROE4cTS8FDHM2CmkrRy3T58i2W2dxaH95MGg92UukYAjfMjyjf/7SPFQsFKjATYg2EM
 N46Xmvdu9/ndXGTD1touIQ3oHNOEnVKXKYlaHvZ3ns9yKbhnTBQRgcGrPnH3D/p0akVBQ1ye0jY
 b454wfrjNdldtKsJZ+vXKC05wVz5HpLkT3fE/TG5YiQ3Abj/BAio9OuiWSD19WTvHgphikz9SZI
 hZ+QRRfWIKU8SSJ9T4w==
X-Proofpoint-ORIG-GUID: z8QiKAomOAM2QRN5AwuJCuzXCbZekTx2
X-Authority-Analysis: v=2.4 cv=QN5YgALL c=1 sm=1 tr=0 ts=6a82c024 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=3XZL1g37JtqLMPLRk5sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfXwozAUXdO5xj+
 gJkY/Cdn0FxXeTXn1TkCpbou+XL1rHtmooX3GlmNYdMJOXULEtdL3Gt0rNMLdS6kncdgyFH1V6L
 7JS6KElIidyiE469+DUweqozBawSomg=
X-Proofpoint-GUID: z8QiKAomOAM2QRN5AwuJCuzXCbZekTx2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
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



On 7/12/2026 6:33 PM, Dmitry Baryshkov wrote:
> On Mon, Jun 29, 2026 at 10:48:04PM +0800, Yongxing Mou wrote:
>> The bridge connector HPD handling path currently updates
>> connector->status for every hpd_notify() invocation.
>>
>> This does not work well for IRQ-only notifications where the event being
>> reported is carried by extra_status and no connector status transition is
>> associated with it.
>>
>> One example is DP MST. HPD IRQs are propagated through
>> drm_bridge_hpd_notify_*() so that bridge drivers can process the
>> notification. During MST operation, however, the SST connector attached
>> to the bridge connector is intentionally kept disconnected while the MST
>> topology manager handles all connector creation, removal and hotplug
>> processing.
>>
>> Updating connector->status for an IRQ-only MST notification may cause
>> the SST connector state to oscillate between connected and disconnected
>> depending on the notification path. These artificial state transitions
>> can later be detected by the polling logic and result in unnecessary
>> hotplug events being generated. Userspace then re-probes connector
>> status, potentially triggering the same sequence again.
> 
> Then the API might need to be adjusted.
> 
> Remember, we have two usecases, which we must be able to interpret
> correctly:
> - The driver gets separate HPD and IRQ_HPD events.
> - The driver gets HPD and IRQ_HPD at the same time.
> 
Ohh yes, here need to rework.
>>
>> Treat notifications with status == connector_status_unknown and a valid
>> extra_status as IRQ-only events. Forward the notification to bridge
>> drivers without modifying connector->status.
>>
>> This keeps IRQ delivery working while leaving connector state management
>> to the component that actually owns it, such as the DP MST topology
>> framework.
> 
> How is it handled by other drivers (i915, amd, nouveau)?
> 
i915, amdgpu, and nouveau don't go through the drm_bridge_hpd_notify()
bridge chain -- their DP controllers are integrated into the SoC, and
HPD interrupts are handled directly in their own encoder code.

MSM DP is different in that HPD comes from Type-C / pmic_glink altmode
via aux-hpd-bridge, so it has to go through the bridge chain, which
means this semantic needs to be extended to the bridge API.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/display/drm_bridge_connector.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
>> index 5edca47a025f..7334d6677604 100644
>> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
>> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
>> @@ -163,6 +163,18 @@ static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bri
>>   	struct drm_connector *connector = &drm_bridge_connector->base;
>>   	struct drm_device *dev = connector->dev;
>>   
>> +	/*
>> +	 * IRQ-only notification: extra_status carries the event but
>> +	 * status is unknown — do not overwrite connector->status.
> 
> But it's not unknown at this point. The connector status is reported
> following the HPD status.
> 
You are right, in the SST case the bridge_connector status does follow
HPD / link status -- because the bridge_connector itself represents
that SST connector, so its status naturally is the link status.

The MST case has a key difference though: the SST connector must be
explicitly marked disconnected (to prevent the DRM framework from
enabling it), consistent with what i915, amdgpu and nouveau do. In
other words, once MST is enabled, the SST connector that the
bridge_connector represents no longer equates to the link status --
the real link is managed by the MST topology, and the SST connector
is just a placeholder at that point.

The issue is that IRQ_HPD still travels through the bridge_connector
chain and takes the old "update the SST connector's status -> emit
hotplug" path. Under MST that runs into two constraints -- and this
is exactly what this series is trying to address:

1. The SST connector represented by bridge_connector no longer stands
    for the link, so its status must not be overwritten by IRQ_HPD
    events.
2. IRQ_HPD needs a clean path that does not trigger a hotplug on the
    bridge_connector -- the MST framework already manages hotplugs
    independently.

Using connector_status_unknown as a sentinel here does feel a bit odd;
let me think about whether there is a cleaner approach.
>> +	 */
>> +	if (status == connector_status_unknown &&
>> +	    extra_status != DRM_CONNECTOR_NO_EXTRA_STATUS) {
>> +		drm_bridge_connector_hpd_notify(connector,
>> +						connector->status,
>> +						extra_status, NULL);
>> +		return;
>> +	}
>> +
>>   	mutex_lock(&dev->mode_config.mutex);
>>   	connector->status = status;
>>   	mutex_unlock(&dev->mode_config.mutex);
>>
>> -- 
>> 2.43.0
>>
> 

