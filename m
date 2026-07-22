Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD2CC44512
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AF3F10E416;
	Wed, 22 Jul 2026 06:51:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TbXG+6os";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IK/flQDM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1679A10E416
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:51:32 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53Y1c4054814
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/YHKBQCRpdF6ioKDZRp1kbK4
 J+GBA3HywUvyPdCcLww=; b=TbXG+6ospDyHRNKxSuOUqRRzVIszrahUng7O5E7z
 +lze8I1J1fpXiOrHDJvgwqX8aoQcXZZWJDC5aMV5fx5XrHt9ukn9miswexldl4Ia
 N8inbgJHWLRjuAceZWrbLvF9ZeFSU6n8IZPVwExcojK/cplsYA/z0j6g4ZwvBEKa
 AaelhbA7vF9XGAZZzY+2j/1ioE96NwmARPPNZG3zBfBLNA1nre+10hg6tGAjT2QO
 P6amxJ6wmCalzkZJZih6mwn/JnjwUVj9jpFrWA2DmhPm8PF0En1N/ebURZmtYZdh
 zE7MXoZXdontGzgL1QaCK7D9hyUYk4HCuM5j7qjFh0NIGw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjpxdgf2j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:51:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso21252501cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784703091; x=1785307891;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/YHKBQCRpdF6ioKDZRp1kbK4J+GBA3HywUvyPdCcLww=;
 b=IK/flQDM9+B8f3fqsHG6CCKIdHdLwyAkwbqy39e05tIc4rDIHr5Ye498YBoqc7Zt5I
 lDbbimocVqZGvZ4zID+gMOtq6tHrtx+VuG7YPhfuDVOvESNvjhA7H4y1I1V/50h4b971
 sNYsQlaiDMfAac32I/IPQG/8ZtyG/FVsQh19SM95FrRWknzogirrmHajWOxzgQQIKvHL
 Z5yEUeooh4om+gzwkZrYcbJRXKDhlK5Oiua4QrY2IzTXoEj+We7qYGqXUSEs77YRY0O8
 byTv+CE/fUTVCpdwUpwJ/+amSA6Io3wiagkyVT48buvIHxkvl28mqgIfMYG85rtXPBoz
 8i1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784703091; x=1785307891;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/YHKBQCRpdF6ioKDZRp1kbK4J+GBA3HywUvyPdCcLww=;
 b=RQIiwB04OjocJDdtkn6/SIBsyvdshN/1g+m1Qy4ay8m3PMGmxdNn/d3kwEoAgYD3Eg
 HWxSpO7lSvy2ckHvkF5zLU1yN75RrtK3WB46dkvKdxq0mD8xzlficlGQYrm0DckP2NA8
 3cQN9FlYH4Dj1LTz/A6OaSX/Zkq78kZkD84Ds4E9+NJ7KBqcuBxpY7ABPa5xrBf7IPEp
 IytEtU/9MdtAyF/eft687sJfa2Xt+jvBW2HpZJKd95e7JXMJ0UOuzsRTT+H91uLe19/K
 VSngdNwqLJwTK2NZQfmovYSh9wZMXDoZM7vwlOREJy+XM3CMOFLZ9At4ea+sVnUHyaLH
 zcPw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6nZfCtJ871feoPJiy9U7ybxUnoWU9owN+IgwFUZc9KEh420JbnFhtcdV3o7uzj72XbKj206f/K+Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYa8txExf3pqAHlSPoAA9HVsw9ANGu1A85b13CC4P7fhGW4Z0Z
 4na7jDbFCN14D7nKmsie1YS4C3CZkctg0PKJQDJENKtlNCXU4jLlAhrujboVLNslk3gAwlVgdoP
 DGCvC5ZpH/2kMcVZ4NXK2umj3HWfPIMIDCRtrrM3PKuSb1HgKG918kxUjQlJdg/owoXO12J8=
X-Gm-Gg: AR+sD10r/Tq+Wj09o+7o9JrgJtVH2swx3RCcm3hcO+5zhJDaMHhPyZprIEnswpFoS/t
 vRtXlNbE8XIPaBe4S3VTekUo30JMmzqWsNRA1TUaA2EtQwfGl+w6cAT65Kq3Le4B3qbliuBXyrK
 uI9m8Y9BOFb/qqcJZKkB5/BdSE07lkSK49g3jw9t846Vx88XC5knU8PBc1zHcVa6J1jeEUBtkUV
 PNhCLzr68N7kU58FBH74EeuPp8PKtQSN3kSKfEqdIRQVrBtk+pq5eqRcA2/iI/xcF5BeYu1wqwd
 Lt89RHvzqCbJWKYdLFgrlczbcFGAEj2M8zF47UidkcUeVS/Xg0wa5BULMljWe75yxZN7Ta7vaSv
 SKVqOdlK6nl/SQhIPmsB5XSdf1WpCCmKd8gq7Q2z/Ucr0ZGHA4faouUC3le3MANK1VDjUBJEzIn
 cMgqeWpior0ECQPg==
X-Received: by 2002:a05:622a:e186:20b0:521:987f:bf34 with SMTP id
 d75a77b69052e-521987fc2ecmr132874181cf.61.1784703091186; 
 Tue, 21 Jul 2026 23:51:31 -0700 (PDT)
X-Received: by 2002:a05:622a:e186:20b0:521:987f:bf34 with SMTP id
 d75a77b69052e-521987fc2ecmr132874061cf.61.1784703090691; 
 Tue, 21 Jul 2026 23:51:30 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9bae7d0sm316678e87.34.2026.07.21.23.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:51:28 -0700 (PDT)
Date: Wed, 22 Jul 2026 09:51:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v8 04/39] drm/connector: Add HDMI 2.0 scrambler
 infrastructure
Message-ID: <62b3bsa7ucgo2g7w75wudt3aundl3hv57qgjr6kqfteve56rf7@w42tah2fnvml>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-4-d79890d00b6a@collabora.com>
 <tjsidlnvswo2rdhqa6jybxrnb47lxgmxdlfrfbasuh67wjbqoy@3a45n3zawvnf>
 <17753a1c-824a-4835-ac2d-8b2796bba1eb@collabora.com>
 <534b921c-638c-4fc3-b89e-5dfc1f269f96@collabora.com>
 <20260713-statuesque-nonchalant-seagull-b9c39d@houat>
 <91c3a825-3344-4ff5-8ea0-f8f057665b3f@collabora.com>
 <20260715-ancient-zealous-eagle-b13e94@houat>
 <dfca9032-98ca-4c61-b1b1-85fd05283d77@collabora.com>
 <20260716-astute-nippy-moose-bd22b5@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-astute-nippy-moose-bd22b5@houat>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MSBTYWx0ZWRfX05StSpo82WZX
 kctlvgiWj6krQex9bKDMjL3RsZSd9bGSdDRUkb/Wmq+OqwafQFdC67LAU/vhfSoC3BAKDaz0DUk
 iNJJihfd1eN7P7apX1/qBcxeOOWH8f2CUYtBfoqox/lLmPAaDVLV9MQibQ83aZje3Fl7AL7hVKz
 Pg+dWxiIaXP8PwW/4TYj8ppIEQjSsDCNFhtwfeQ7ToN1GMYTtWYRowwUCVsh5qj2x6revBEz+XE
 PVkWDXO8b8swVXJd93jfveBzUWoFL1CpcGjv1YWiflHHJaVhZVVFtsZfK1dtzK7H9F+PgQyNbtS
 dynw3EIt8ikGqacZukVCORKHTnoWzAimfo3u4pC/RNfzOZ81r9yLPBi6DNNMn+9goKgfRZN7CTO
 uUXvmn+8s8qLhT6je7h+qJy/s9egWzgbkU2r2LGn7OH94nmhShYNo1eRVSHBARQabmtU1KrxClD
 Kc/L+0D5vBeVlyud6HA==
X-Proofpoint-GUID: QM039x_PhCPfx-FuqK9I5qn66v9a8OSJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MSBTYWx0ZWRfX8G4L7al2CNP7
 PvoE4OMCUw5dWLghD7Jh3GO3pIfVONpXfk/FxwGANCd+whAiLBoGjmmdGUdfqxFlTAmEzpTuTnZ
 rmSKosIGEE2wL7Q3rZBDq0GUHCpgaCg=
X-Authority-Analysis: v=2.4 cv=b7iCJNGx c=1 sm=1 tr=0 ts=6a606873 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=T-56vAx3aY-Q7tpFFuUA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: QM039x_PhCPfx-FuqK9I5qn66v9a8OSJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220061
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

On Thu, Jul 16, 2026 at 03:50:29PM +0200, Maxime Ripard wrote:
> On Wed, Jul 15, 2026 at 01:46:12PM +0300, Cristian Ciocaltea wrote:
> > On 7/15/26 11:55 AM, Maxime Ripard wrote:
> > > On Mon, Jul 13, 2026 at 01:23:00PM +0300, Cristian Ciocaltea wrote:
> > >> On 7/13/26 11:50 AM, Maxime Ripard wrote:
> > >>> On Thu, Jul 09, 2026 at 10:25:54PM +0300, Cristian Ciocaltea wrote:
> > >>>> On 7/3/26 11:54 PM, Cristian Ciocaltea wrote:
> > >>>>> On 7/3/26 5:34 PM, Dmitry Baryshkov wrote:
> > >>>>>> On Thu, Jul 02, 2026 at 05:46:17PM +0300, Cristian Ciocaltea wrote:
> > >>>>>>> Add the connector-level infrastructure to support HDMI 2.0 scrambling:
> > >>>>>>>
> > >>>>>>> - A scrambler_supported flag to indicate whether the source supports the
> > >>>>>>>   scrambling capability, in which case the newly introduced
> > >>>>>>>   .scrambler_{enable|disable}() callbacks in drm_connector_hdmi_funcs
> > >>>>>>>   are mandatory
> > >>>>>>
> > >>>>>> Do we need a flag? What would it mean if the flag is set, but the
> > >>>>>> callbacks are not? Can we drop the flag and use the presence of the
> > >>>>>> callbacks as a way to identify that scrambler is enabled?
> > >>>>>
> > >>>>> The flag is intended to be set only within drmm_connector_hdmi_init_with_caps()
> > >>>>> when drivers advertise HDMI 2.x capability, in which case it also ensures the
> > >>>>> callbacks are provided.  
> > >>>>>
> > >>>>> We could drop the flag and instead have the init helper clear the callbacks if
> > >>>>> they were provided for HDMI 1.x.  This might slightly reduce code readability,
> > >>>>> as it relies on checking the presence of individual callbacks - especially since
> > >>>>> we plan to extend this further with HDMI 2.1 support, providing four or five
> > >>>>> additional FRL-specific callbacks.
> > >>>>
> > >>>> I tried to replace the flag with a helper that checks the presence of (one of)
> > >>>> the callbacks, but it's not straightforward to unset those for non-HDMI 2.x
> > >>>> cases since the hdmi_funcs argument is immutable.
> > >>>
> > >>> I'm not sure why we would need to unset them. If the driver states that
> > >>> it support HDMI 2.0, then it needs to be there, if it doesn't, then who
> > >>> cares? it's not going to be used. We can log a warning that it's
> > >>> inconsistent I guess, but there's no need to actively remove it.
> > >>
> > >> I was trying to address the use case where drivers provide the scrambler
> > >> callbacks despite not supporting HDMI 2.0.
> > > 
> > > Scrambling got introduced with HDMI 2.0. That doesn't make sense, but
> > > it's not a total deal breaker, it's just going to be here unused. Hence
> > > why I was suggesting to put a warning there if you wanted to.
> > > 
> > >> If we replace the scrambler_supported flag with a helper checking the
> > >> presence of the scrambler callbacks, then we would need to ensure the
> > >> callbacks do not exist in this case.
> > > 
> > > Keep it simple:
> > > 
> > > if (hdmi_version >= HDMI_VERSION_2_0)
> > >    if (funcs->scrambler_enable)
> > >       hdmi->scramblers_supported = true
> > >    else
> > >       return -EINVAL
> > > else
> > >     drm_warn(warn, "Inconsistent HDMI version");
> > > 
> > > We don't need anything more than that.
> > 
> > I dropped the scrambler_supported flag and introduced a helper:
> > 
> > static inline bool
> > drm_connector_hdmi_scrambler_supported(struct drm_connector *connector)
> > {
> > 	return connector->hdmi.funcs && connector->hdmi.funcs->scrambler_enable;
> 
> I'd add disable to that test

I'd make it an error, if there is only scrambler_enable without
scrambler_disable (or vice versa).

> 
> > }
> > 
> > Therefore we need to ensure the callbacks are not set in the HDMI 1.x cases:
> > 
> > int drmm_connector_hdmi_init_with_caps()
> > {
> > 	...
> > 	if (caps->supported_hdmi_ver >= HDMI_VERSION_2_0) {
> > 		if (!hdmi_funcs->scrambler_enable ||
> > 		    !hdmi_funcs->scrambler_disable)
> > 			return -EINVAL;
> > 
> > 		connector->hdmi.max_tmds_char_rate = HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ;
> > 	} else {
> > 		/*
> > 		 * Scrambler callbacks are only valid for connectors advertising
> > 		 * HDMI 2.0 capability. drm_connector_hdmi_scrambler_supported()
> > 		 * relies on their presence to report scrambling support.
> > 		 */
> > 		if (hdmi_funcs->scrambler_enable ||
> > 		    hdmi_funcs->scrambler_disable)
> > 			return -EINVAL;
> > 
> > 		if (caps->supported_hdmi_ver >= HDMI_VERSION_1_3) {
> > 			connector->hdmi.max_tmds_char_rate = HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
> > 		} else if (caps->supported_hdmi_ver >= HDMI_VERSION_1_0) {
> > 			connector->hdmi.max_tmds_char_rate = HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;
> > 		}
> > 	}
> 
> Drivers might have a lower limit than the max allowed by the spec. It
> should be provided by the driver, possibly optionally with a fallback to
> what the spec states?

Yes, likely it can be handled with the if !connector->hdmi.max_tmds_char_rate.

-- 
With best wishes
Dmitry
