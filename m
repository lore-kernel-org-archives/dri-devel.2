Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D766C5DF70
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 08:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE53610E6B1;
	Mon, 17 Aug 2026 08:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WSA7haT7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G6/PVOTL";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1174210E6B1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:01:58 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67H7smUK1297166
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Eq8SMRnl+krHyl5tGUy7vPAIIuXfNAkaAWBYuPBe/EU=; b=WSA7haT7QLcAAVEt
 ONRKNoDofW1w8mN1KBhyv1VtIavVNsAZMGd6TJRH3nOCfCKgOgzvgeaMtyj8qscw
 vN7o/MPqQXOmHKRbcn/WW4nw3NJ+m0mi/2CQIzUefxe9K79ureQNZRJe0Dvw2imq
 Bbks4wdqt+M0oWPU2bd+HfNNz1QLxlmPeUOvThVnVCjFCNYZTtMdWz3f7UG4LJpn
 1oX7x2Bv/3MXghQPecuKhF23mUOlAPpj/28IwdP7m7x2nV7xEJ/WMLSId12AqK/i
 sWUHbwxmPd7Dknd5ikp8Rw/cZTCULcXBI3eln8hs0CNTC5wMZVTu34IAdSu7Y2Jn
 Bbjbng==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3xb1g0u2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:01:57 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5174a236220so29530251cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 01:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786953716; x=1787558516;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Eq8SMRnl+krHyl5tGUy7vPAIIuXfNAkaAWBYuPBe/EU=;
 b=G6/PVOTLiAKNPb55Cq25oMuz1kJA71DebtyIPqZUngtlNk9Ypz0xYxGAdWbak+NzJw
 ZyKJH/EXFoA9mpv+szzIA4+Xs5rAac9tcclxMtlzr0c0zF//vu1z5fFmb/6356itORXV
 WXGVlJ8I02FaU/yzwan8VjF2rOEievNQrJvkEaJPGGSF1/bAivWkibWcBGtrPbUDOqBU
 SiQko2z9BSo1wXVOrDhUQfDVbXwxny4HZ8yEtZbPgjM2E5tCVAVqEkCgm8IzzGMf5oeE
 2Mly3uvdtAosbDSqPcujp452UkNk0K0bxGSdFDDV09qJRugogKSVjR8du+IK+M9i67t8
 LgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786953716; x=1787558516;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Eq8SMRnl+krHyl5tGUy7vPAIIuXfNAkaAWBYuPBe/EU=;
 b=KHBClM5JlCkySJGlaYgQd0qsOnzyuoW2GdgUKydnRVcjoBBq/DYDrXEbyF3F0uu6g3
 /JxLG56Kxm0MFwbXo9sqD5Xk5+0XzXLXvTrs5iWtKLRIyB6CaJ3ap8pmmave0Za4lrke
 TFdYF721eBy7iTpya81MnSR2Zfypk7FTSt1g0jQGkdBvfD+7A7Ac6Ptxgdu5H7/J7Uer
 OMUpkjsDl36siaylh5rIIbhBrA0xMxbJi7G/jsOPqvgMj58pCeLNk1dnmTLmEzLQTshp
 8soWUAAvrWdiJIjMcV/gb4vq6N2cUab36QOXIiI8rh2mWxWhfcW/v7Bn77SCdzaro4iw
 QVQg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvqrBaSojTAE34iBAjoHA2NLdnqlS09ZhcnkGmkpOfkza+H+a3ZM5MNBz8zE4EbTEafO6nNGZP69Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwsJyTmChGWnoiCKzGaNWx5e78aCE0J69WW18AJSdGgQ0eqEiw6
 0DyZMyc/h8kgG1xzbQ1IoS7umRbj2e1xouygMK6J/kNnV3nMj+86nko1fvY6xv/QWVR0vZZdJ42
 /8zFdVoZA15wWOy2TAuxT+tJEFzHdjaEcqYoQgoSTk4zjH9oo2AbNq4wPcINpv8iwxwplTyk=
X-Gm-Gg: AR+sD12jhKwo4Wie2SRNQm/d08Is1tyOAGkKnGW228Uq1FyXakE9WM9nXSS8INU6pCl
 O47JfK49GfAbaO6/+1WiGRaHYZ6CqGl5+HBrjfI1H0dkv997JLeFavIbOxUt1n3X87K+KveCUfo
 J6xOS3/TO8m610n3iuMXPMlTY5hhuMbGdkohHwADMMYjy1W2GFY1sKzZ0wMDr05dy7+JGgzedp6
 GTv6KhdPcdPywydI3c1QaNdKUkkZ+OOZBha7XodqYMk+4/bZtnc7KNCpc/lWvecl8a4qT7ZSqkA
 lMVE+8pvRMpKAl0uXz5gUdfCsa1Z99TTGHALAvNIcBpjsiTWx/Ibejv2SVAwoyq2/F60Bx1o0Dg
 YgQpQpdmHsovfpYnrLWyuNepg4C71+UmibTsLdxeA80TpA4FqZiNldG/1JNW01rn5yw==
X-Received: by 2002:ac8:6104:0:b0:51c:92a0:b2cb with SMTP id
 d75a77b69052e-52d854ce987mr241475901cf.26.1786953716250; 
 Mon, 17 Aug 2026 01:01:56 -0700 (PDT)
X-Received: by 2002:ac8:6104:0:b0:51c:92a0:b2cb with SMTP id
 d75a77b69052e-52d854ce987mr241474961cf.26.1786953715521; 
 Mon, 17 Aug 2026 01:01:55 -0700 (PDT)
Received: from [10.111.162.109] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db612c2bfsm8319271cf.11.2026.08.17.01.01.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 01:01:55 -0700 (PDT)
Message-ID: <d4e96255-814e-4fb5-8d97-50126a61c20b@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 16:01:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/msm/dp: suppress bridge hotplug events during MST
 operation
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
 <20260629-msm-dp-msttypec-v1-3-646a10256233@oss.qualcomm.com>
 <fozk5fz6bgat55vmlgyvovnmfzabjprna46cmcaoh4jyrwmbtu@k2qtjgip5vg3>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <fozk5fz6bgat55vmlgyvovnmfzabjprna46cmcaoh4jyrwmbtu@k2qtjgip5vg3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ua9hjqSN c=1 sm=1 tr=0 ts=6a82bff5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=4e0XemQSoReXIs4U_p4A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: PUv35z8Q8Y8VoaaI2837eEkivalFDDg7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfX5Eecz7o4oPOs
 Q3C+HrA6Euc0lzWCwwNliAWrVwtpqx2WbfE8sh+VMBSpL0zZqWTm5qhpp/eBbK6OXZYtmbs0b6p
 mNp2OEGeUvXq3mENtbil12riudHOhkvr5FmVxOCjil5svP75ktZzlh6YOoGATcMDxbmyoSjrYiG
 ldZgdMEV7PuqP9mJVeFJr9Vwscu41doJXCQdys7OKMoI6NcJX//h/TXi0lPHJjRbOcjbJQQ7qJH
 NWK2XHkQFeZgNjzWYTZ+YPceBvefyRPQIVJhXexOW9YgDAqEnMK+FJvhjyCZkGJl2bXXZQZt7wp
 rCTFT2SrbqLz2n28wr9Zq1D3uVFnN2mY3SYh/bOhwAa76/V2ScCoGCdsGKOgRq8aCh5UPSDlrt6
 k8R+wu8EpdHHoY521YMR+25HKE2eR6tc5rSGJnfSVp5gBBB4jERLmHL526XbWdoiv3xO0aZ+vnJ
 ntrLxIVJHlhd/bi8QWw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfX/6jSM6CoY9p8
 0IC/lIH23e8PXaw4GDgL6b+Pm7FiWEJeAM3LjPQXgDHNHU/VPw31aIAl3ERKa9+y9du4DoJiU39
 DvxWR0/2IC8sp6vE9HRwDuf3Zae+KJo=
X-Proofpoint-ORIG-GUID: PUv35z8Q8Y8VoaaI2837eEkivalFDDg7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
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



On 7/12/2026 6:44 PM, Dmitry Baryshkov wrote:
> On Mon, Jun 29, 2026 at 10:48:05PM +0800, Yongxing Mou wrote:
>> The DP MST framework already generates the required hotplug events for
>> MST topology changes.
>>
>> Suppress connector hotplug event generation from the bridge connector
>> path while MST is active, and continue propagating HPD notifications to
>> the DP driver.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/display/drm_bridge_connector.c | 6 ++++--
>>   drivers/gpu/drm/msm/dp/dp_display.c            | 9 ++++++++-
> 
> No, it can't go as this. The drm_bridge_connector part should have been
> a part of the first patch.
> 
Got it.
>>   2 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
>> index 7334d6677604..82ed0dc450ab 100644
>> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
>> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
>> @@ -162,6 +162,7 @@ static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bri
>>   {
>>   	struct drm_connector *connector = &drm_bridge_connector->base;
>>   	struct drm_device *dev = connector->dev;
>> +	bool send_hotplug = true;
>>   
>>   	/*
>>   	 * IRQ-only notification: extra_status carries the event but
>> @@ -179,9 +180,10 @@ static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bri
>>   	connector->status = status;
>>   	mutex_unlock(&dev->mode_config.mutex);
>>   
>> -	drm_bridge_connector_hpd_notify(connector, status, extra_status, NULL);
>> +	drm_bridge_connector_hpd_notify(connector, status, extra_status, &send_hotplug);
>>   
>> -	drm_kms_helper_connector_hotplug_event(connector);
>> +	if (send_hotplug)
>> +		drm_kms_helper_connector_hotplug_event(connector);
> 
> But now I can also see that the idea seems to be incorrect. You are
> preventing the kernel from sending the events, but it doesn't really
> matter. If connection status oscillates, then other components might
> notice it even without the event being sent.
> 
Here our original intent behind suppressing the hotplug was
that, under MST, hotplugs should be sent independently by the MST
framework, rather than being emitted along the IRQ handling path.

Following the extra_status approach you introduced, would it make sense
to let the bridge_connector layer distinguish between long pulses (HPD)
and short pulses (IRQ_HPD) -- a short pulse would not update
connector->status and would not emit a hotplug, only forwarding the
event to the bridge driver. Does this direction sound reasonable to
you?
> 
>>   }
>>   
>>   static void drm_bridge_connector_hpd_cb(void *cb_data,
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 6835c68fe510..bc93b566fbca 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -1790,10 +1790,17 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
>>   			msm_dp_hpd_plug_handle(dp);
>>   		} else {
>>   			msm_dp_hpd_plug_handle(dp);
>> +			/* mst_active is set in plug_handle; suppress SST hotplug */
>> +			if (send_hotplug && msm_dp_display->mst_active)
>> +				*send_hotplug = false;
>>   		}
>>   	} else {
>> -		if (hpd_link_status == ISR_DISCONNECTED)
>> +		if (!msm_dp_display->mst_active) {
>>   			msm_dp_hpd_unplug_handle(dp);
>> +		} else if (send_hotplug) {
>> +			msm_dp_hpd_unplug_handle(dp);
>> +			*send_hotplug = false;
> 
> Why? Disconnected events definitely should be reported further.
> 
In MST case, MST DRM framework will send the discconnected hotplug by 
msm_dp_mst_display_set_mgr_state(&dp->msm_dp_display, false);.
>> +		}
>>   	}
>>   
>>   	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
>>
>> -- 
>> 2.43.0
>>
> 

