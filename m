Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3FAC4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CB5310EB0A;
	Tue, 21 Jul 2026 18:32:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="j72SmSNo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fihVmgyj";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F8D110EB0A
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:32:04 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LH2iet2160628
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OaTD6dHrwwXWksGv6iIyR3RVuuH2sI/MiqMl2YqMmkA=; b=j72SmSNou1mszlrm
 s9BNg0A32p9PJv5/CjXVhlBgQgQTppfIOFBfCq3fclseMSQeOi5ljf4hkW6iWC+U
 uMkgmzJwgiuMKVbFC3K7MGyyGEj31EaVkkHLdWQKsjngIWamU0Ebuyf+oDrqA57m
 Sz94nQAXG+hQyrsMDJtqSomFe7koDfdE/6niawR8Rhqx+YGeyXJXPP+NHINGBYJV
 1V++gMq6iO57u0UZa01YBYwIX3TdF7RRjT0cAHdUEFDg0NWPoEGnq1Zn9EikQrbg
 83EywVpn7hxHd3Iri5fpURZt+37WgmGkmgtPsxraOGObiGOaJi9b+NPLUyZZjyLk
 QF7DOw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9c41k3n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:32:03 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e820609d9so1483860485a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784658722; x=1785263522;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OaTD6dHrwwXWksGv6iIyR3RVuuH2sI/MiqMl2YqMmkA=;
 b=fihVmgyjrF+SvugZtCXDfjTZiAgDpJYfXB1mDsDoMDBMt5FNClVyMK6hNXKpNWhiai
 bASYz1t8NIMiMGkR6mIrmAOzTgTW+NWVn20A7DsTB4lSp7SpVTWHJRZQ6V+S4zNI1CHJ
 fdHqatVGe9Ao0AaJMejOM9+wrTa4D3UV8s0v493XKMGDXqWsTQU9+PmPXllWxh4HvI27
 exPscc7tu4xvttJTG+gKVliEY2/8DSN/lhAjGUwZVNWIb1eWjApXqxUPY9A70BkSEOOG
 jKwaaEgGa3MXMHYWhQvKExiKfB63Uc5iCSu8GiTQIjkJjHzvAKMXveSRImH1JQaZFF9o
 Vtvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784658722; x=1785263522;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OaTD6dHrwwXWksGv6iIyR3RVuuH2sI/MiqMl2YqMmkA=;
 b=Uzd3H0Ho2h6PyPjp7FCcLI0UYD3qlj1pSw1P5nC8QNjwpaolLM79bJmCAMd300XxE3
 0wUIAeP3HVxNWPYQA3Ja/iOkRz6hRrA/D5uCP0A6Pdm4wkYj6h+nfEKrCDUI++7I6vzo
 gGhEiD+yfzYV3R/MwprKafi9RBeUE0yQ7D7RJE3D7S7h/F6kmDOutMqhiw2QQrx7bJuU
 BgSCa2bZW8spGkz1r8ye983+Rsflemwdf/voWCqIZNaf7+uW55aBCB0hInqeKKiNuaC2
 rrrwRZ3sKHR+fg/9KPkN97JwDZom3jm9PP1c/AHCf8myYwFdSE5S0I+z6iEysB8tSYAS
 I1dQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrUpNJyw1MQD0nbIIEOXJTeCVliRaD0oSnUoPkdOQfjITjJDzbWtQPo+icKxYHlPJKmjEhfs5I35AQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwH/ubZh1td1bVEAwI69AnGWkKmY1/74J116Az+cQ7PcGqUUzR/
 N+BQYoCzf4VYZZhCmAMN5FHxOch93RB18GqI0M6QGxiE0a9OAeWC/kGepa4LjJLTeYrUUbGFvme
 zXbjXOgAPxgYRjumkfN7Zgi81sVn0y2oevGjylGWuuMl6518KJOITZ5rqnHSgo9ECMYNl9MY=
X-Gm-Gg: AfdE7clYVcWzlosRi0j8jVhxGOQwp5IJ4hHhZFagYhbil2qvdJ/+Re+f7n+EPZr6FWB
 Z/yx1b76CTHRsC2heEF7PxFmTVposDGQ83ENBEnb0UxeiUnJR2hiYisg0CJsORAWlRxvEq24ESc
 pxyaoNUuh5N2rC4WTJSWv84UIB6amca+biM/cIZhXrDYvGihEes4kV6ONgDIeKWVoZrEhQ6hj62
 1HwVhZUaD26diNvUCDdEJZzU6hJifNQEOtejJgIZK3IeWNFxuHeha9ceOyYLAejbHfLiFoX6sjV
 PvlFUutLZl9TVvaoIfZtAsk8JAjXaBgC81G0D7drla/RA9tdt8uIi/tEP4ZhgtUrBewcwwnstc2
 akrhbAvALtydvwyVkHhN+p7KFRr/0PGp6s2klWfAzgqOyE7Y/7i8FunCwcu55pdZRbqrOr7p1bR
 aBT/qPIHyAkr6OGN3yuXmfLpd2RJNHSmf+BhlfmUetkZ3c42nXljWkLva+9X3Yv52eVaE=
X-Received: by 2002:a05:622a:528c:b0:516:d955:ea6 with SMTP id
 d75a77b69052e-5213bf113dfmr162690291cf.14.1784658721596; 
 Tue, 21 Jul 2026 11:32:01 -0700 (PDT)
X-Received: by 2002:a05:622a:528c:b0:516:d955:ea6 with SMTP id
 d75a77b69052e-5213bf113dfmr162689241cf.14.1784658720221; 
 Tue, 21 Jul 2026 11:32:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32a798a5sm7925466b.9.2026.07.21.11.31.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 11:31:59 -0700 (PDT)
Message-ID: <b95cc41e-78df-4b8c-84a8-6e6e0dea7f9b@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 20:31:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/10] DRM: Add support for client indicating support
 for luminance
To: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260624165751.2014759-1-mario.limonciello@amd.com>
 <20260624165751.2014759-5-mario.limonciello@amd.com>
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Content-Language: en-US, nl
In-Reply-To: <20260624165751.2014759-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a5fbb23 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=XbyYF2C9stMiDSnLSv4A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: ggoLp9TjZdvFKYYPd4SlH9w0G9V6lgTw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE5NSBTYWx0ZWRfXyXTDLEEDLH0S
 PSsSYqFmlVpIV/3Qrh+KaxyjjSjxUmBnpnUBnJYx6cBR/8tefvLTHObELYEuxsS/vChULPVCXke
 r4mIr1VkebYk3tp2Sgw2iJW9x1t2tpMlmjlwZCnXBuWak/o8wOT+yP+DwW9WXNDEM+wXAExcbt4
 cekK3Pn6luErqSsD1QX+TBveH+643MBya0kZDWIrwcVSTnvHJA+1cSBzyZAoyMNQyLu+aXO9gvD
 vCBwww4g7JNlnQd4r1JD+UipWommSVhF8qSuzQjraJGFHqlIEgeW64rWhC8iT4HIHUJ2ZB4toI3
 PbLoEVH03Fwae8HI4v0Px+Lo6AszCMXG9kaWAKD4YAV2PR3Ce9lpExkmg+OzxWEhtuPuv9PJ90z
 CKss9U59+rCrD5nVE+mED/A2ZXVAHIFUUZj+PkoCy8B/XxmpajSTGU7iPpOrGkPol6ebjVnfDbk
 LzXHjxP6LPr6WOT6Msg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE5NSBTYWx0ZWRfX9k97aiC4ASpJ
 egtBj2bt03v+rwXG/z1481XSoqBiCRjXwgneLuA0OsMvkCtr3NTrMYN43QyHRndvpPw3TiMzkzh
 kAXeL/KTju+0GRxJ4pIgsU8jAG19fIk=
X-Proofpoint-GUID: ggoLp9TjZdvFKYYPd4SlH9w0G9V6lgTw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210195
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

Hi Mario,

On 24-Jun-26 18:57, Mario Limonciello wrote:
> From: "Mario Limonciello (AMD)" <superm1@kernel.org>
> 
> The legacy backlight control interface can only be disabled when both
> the client and driver has connector support that the luminance can be
> set during a modeset. Add capability for the client to register.
> 
> When a luminance-aware client sets DRM_CLIENT_CAP_LUMINANCE, each
> DRM-connected backlight on the device is marked as taken over. Writes
> to the legacy /sys/class/backlight/<dev>/brightness attribute then
> return -EBUSY until the last luminance-aware client clears the cap or
> closes its DRM file. The takeover follows the active backlight_device
> when drm_backlight_link() retargets the link.
> 
> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> # SM8150-HDK
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---

<snip>

> diff --git a/drivers/gpu/drm/drm_backlight.c b/drivers/gpu/drm/drm_backlight.c
> index b1ec470be86ca..2cddf209d5088 100644
> --- a/drivers/gpu/drm/drm_backlight.c
> +++ b/drivers/gpu/drm/drm_backlight.c
> @@ -71,6 +71,7 @@ static bool __drm_backlight_is_registered(struct drm_backlight *b)
>  /* caller must hold @drm_backlight_lock */
>  static void __drm_backlight_real_changed(struct drm_backlight *b, uint64_t v)
>  {
> +	struct drm_connector *connector = b->connector;
>  	unsigned int max, set;
>  
>  	lockdep_assert_held(&drm_backlight_lock);
> @@ -85,6 +86,15 @@ static void __drm_backlight_real_changed(struct drm_backlight *b, uint64_t v)
>  	set = v;
>  	if (set >= max)
>  		set = max;
> +
> +	/* Update the atomic state directly.
> +	 * For atomic drivers, the luminance value is stored in
> +	 * connector->state->luminance, not in the legacy property array.
> +	 * We update it unconditionally to reflect the hardware state,
> +	 * regardless of DPMS.
> +	 */
> +	if (connector->state)
> +		connector->state->luminance = set;
>  }
>  
>  /**
> @@ -100,18 +110,22 @@ static void __drm_backlight_update_prop_range(struct drm_backlight *b)
>  	struct drm_device *dev = b->connector->dev;
>  	struct drm_property *prop = dev->mode_config.luminance_property;
>  	unsigned int max = 0;
> +	bool can_disable = false;
>  
>  	lockdep_assert_held(&drm_backlight_lock);
>  
> -	if (b->link && b->link->props.max_brightness > 0)
> +	if (b->link && b->link->props.max_brightness > 0) {
>  		max = b->link->props.max_brightness;
> +		can_disable = b->link->props.can_disable;
> +	}
>  
>  	/* Update property range to match hardware capabilities.
>  	 * Range of 0-0 indicates no backing device.
> -	 * Range of 1-max for normal operation (0 reserved for display off).
> +	 * Range of 1-max for normal operation.
> +	 * Range of 0-max means that the display would turn off at 0
>  	 */
>  	if (prop->values[1] != max) {
> -		prop->values[0] = max ? 1 : 0;
> +		prop->values[0] = max ? (can_disable ? 0 : 1) : 0;
>  		prop->values[1] = max;
>  	}

So here we now get:

range 0 - 0   for max = 0, aka no backlight control support
range 0 - max for max != 0, can_disable = true
range 1 - max for max != 0, can_disable = false

<snip>

> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 128d431f0d6b0..70afe3d579f38 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1512,6 +1512,57 @@ EXPORT_SYMBOL(drm_hdmi_connector_get_output_format_name);
>   * 	Summarizing: Only set "DPMS" when the connector is known to be enabled,
>   * 	assume that a successful SETCONFIG call also sets "DPMS" to on, and
>   * 	never read back the value of "DPMS" because it can be incorrect.
> + * LUMINANCE:
> + * 	Atomic property for controlling the backlight brightness level of the
> + * 	connector's display. This property provides unified access to the display
> + * 	backlight, replacing the legacy sysfs interface for brightness control.
> + *
> + * 	The property value is an unsigned integer representing the brightness level.
> + * 	The valid range is dynamically determined by the capabilities of the
> + * 	connected backlight hardware and is exposed through the property's minimum
> + * 	and maximum values:
> + *
> + * 	- Range 0-0: No backlight device is available for this connector.
> + * 	- Range 1-N: Normal operation. Values from 1 to N (max_brightness) are
> + * 	  valid brightness levels, where 1 is the minimum visible brightness and
> + * 	  N is the maximum brightness the hardware supports.

But here range 0 - N is not documented.

Good that this documents that "1 is the minimum visible brightness" but I think
some drivers may need to be adjusted for that. Last time I checked the amdgpu
driver would take a certain fixed minimum percentage as lowest brightness when
the firmware provided a 0 value for minimum pwm duty-cycle, so amdgpu has this
covered. But the i915 driver happily goes down to 0% duty when the VBT does
not give a non 0 minimum.

This is why e.g. GNOME adds its own minimum percentage and never writes 0 to
the classic sysfs interface. So assuming this all holds, this means that
supporting "1 is the minimum visible brightness" will require some fixes on
the i915 driver (which would be good to have) and possibly other drivers
need fixing as well.

> + * 	- Value 0: Special value to turn off the display backlight completely.
> + * 	  This value is accepted even when the normal range starts at 1.
> + *> + * 	The range may change during runtime if a new backlight device is linked
> + * 	or unlinked. The kernel will send a change uevent when this occurs.
> + *
> + * 	Setting LUMINANCE to 0 turns off the backlight, which may turn off the
> + * 	display completely depending on the hardware.

Ok, so 0 is DPMS off, right ? maybe mention that explicitly because
I think that has certain implications like possible no longer getting
vsync events / framebuffer swap completions which userspace might
depend on. Where as a classic set pwm duty to 0 for backlight does
result in vsync events to continue. "turn off the display" is a bit
ambigous IMHO, e.g. is it just the panel which gets turned off or
the entire dsiplay pipeline?

Might also just me not being familiar enough with the kms API...

Regards,

Hans



> Setting it to any value
> + * 	from 1 to N adjusts the brightness accordingly. Reading this property
> + * 	returns the current brightness level that was last set (or the hardware's
> + * 	current state for drivers that support reading actual brightness).
> + *
> + * 	For atomic drivers, the luminance value is stored in
> + * 	&drm_connector_state.luminance. The actual hardware update only occurs
> + * 	when the connector is active (DPMS is ON). When DPMS transitions to OFF,
> + * 	the kernel automatically sets luminance to 0 to turn off the backlight.
> + * 	When DPMS transitions back to ON, the kernel restores the previously
> + * 	set luminance value.
> + *
> + * 	This property is only available on connectors that have an associated
> + * 	backlight device.  The property is created by calling drm_backlight_alloc()
> + * 	during connector initialization.
> + *
> + * 	Client Capability:
> + * 		User-space must set the DRM_CLIENT_CAP_LUMINANCE client capability
> + * 		to 1 before using this property. When this capability is enabled,
> + * 		the legacy sysfs backlight interface is inhibited to prevent
> + * 		conflicts between multiple clients trying to control the same
> + * 		backlight. This ensures that only luminance-aware clients control
> + * 		the backlight through the DRM atomic interface.
> + *
> + * 		Legacy clients that do not set this capability will not see the
> + * 		LUMINANCE property and should continue using the sysfs interface
> + * 		(if available).
> + *
> + * 	Note: This property can be set through MODE_ATOMIC ioctl as part of the
> + * 	atomic state.
>   * panel_type:
>   * 	Immutable enum property to indicate the type of connected panel.
>   * 	Possible values are "unknown" (default) and "OLED".
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index ec820686b3021..4d2520de7614c 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -41,6 +41,7 @@
>  #include <linux/slab.h>
>  #include <linux/vga_switcheroo.h>
>  
> +#include <drm/drm_backlight.h>
>  #include <drm/drm_client_event.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_file.h>
> @@ -252,6 +253,10 @@ void drm_file_free(struct drm_file *file)
>  	if (drm_core_check_feature(dev, DRIVER_MODESET)) {
>  		drm_fb_release(file);
>  		drm_property_destroy_user_blobs(dev, file);
> +		if (file->supports_luminance_control) {
> +			drm_backlight_uninhibit_legacy_all(dev);
> +			file->supports_luminance_control = false;
> +		}
>  	}
>  
>  	if (drm_core_check_feature(dev, DRIVER_SYNCOBJ))
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index ff193155129e7..fdae36b13300a 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -28,12 +28,14 @@
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
>  
> +#include "drm/drm.h"
>  #include <linux/export.h>
>  #include <linux/nospec.h>
>  #include <linux/pci.h>
>  #include <linux/uaccess.h>
>  
>  #include <drm/drm_auth.h>
> +#include <drm/drm_backlight.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_file.h>
> @@ -380,6 +382,19 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
>  			return -EINVAL;
>  		file_priv->plane_color_pipeline = req->value;
>  		break;
> +	case DRM_CLIENT_CAP_LUMINANCE:
> +		if (!file_priv->atomic)
> +			return -EINVAL;
> +		if (req->value > 1)
> +			return -EINVAL;
> +		if (req->value == file_priv->supports_luminance_control)
> +			break;
> +		if (req->value)
> +			drm_backlight_inhibit_legacy_all(dev);
> +		else
> +			drm_backlight_uninhibit_legacy_all(dev);
> +		file_priv->supports_luminance_control = req->value;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
> index f38f2c5437e68..4475896c963b4 100644
> --- a/drivers/gpu/drm/drm_property.c
> +++ b/drivers/gpu/drm/drm_property.c
> @@ -952,6 +952,12 @@ bool drm_property_change_valid_get(struct drm_property *property,
>  	*ref = NULL;
>  
>  	if (drm_property_type_is(property, DRM_MODE_PROP_RANGE)) {
> +		/* Special case for luminance property: allow 0 to turn off display
> +		 * even when the normal range starts at 1.
> +		 */
> +		if (property == property->dev->mode_config.luminance_property &&
> +		    value == 0 && property->values[1] > 0)
> +			return true;
>  		if (value < property->values[0] || value > property->values[1])
>  			return false;
>  		return true;
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 13954c2220b7e..40cfc2296445c 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -217,6 +217,13 @@ static ssize_t brightness_store(struct device *dev,
>  	struct backlight_device *bd = to_backlight_device(dev);
>  	unsigned long brightness;
>  
> +	/* A luminance-aware DRM client has taken over this backlight; the
> +	 * legacy sysfs interface is disabled until the last such client
> +	 * goes away.
> +	 */
> +	if (atomic_read(&bd->drm_takeover) > 0)
> +		return -EBUSY;
> +
>  	rc = kstrtoul(buf, 0, &brightness);
>  	if (rc)
>  		return rc;
> diff --git a/include/drm/drm_backlight.h b/include/drm/drm_backlight.h
> index e0e09e38f7c06..2af48be3aa372 100644
> --- a/include/drm/drm_backlight.h
> +++ b/include/drm/drm_backlight.h
> @@ -43,9 +43,9 @@ void drm_backlight_unregister(struct drm_backlight *b);
>  
>  void drm_backlight_link(struct drm_backlight *b, struct backlight_device *bd);
>  struct backlight_device *drm_backlight_get_device(struct drm_backlight *b);
> -void drm_backlight_set_luminance(struct drm_backlight *b, unsigned int value);
>  void drm_backlight_inhibit_legacy(struct drm_backlight *b);
>  void drm_backlight_uninhibit_legacy(struct drm_backlight *b);
>  void drm_backlight_inhibit_legacy_all(struct drm_device *dev);
>  void drm_backlight_uninhibit_legacy_all(struct drm_device *dev);
> +void drm_backlight_set_luminance(struct drm_backlight *b, unsigned int value);
>  #endif /* __DRM_BACKLIGHT_H__ */
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index d78ac1068d12e..5e32b6063d228 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1209,6 +1209,11 @@ struct drm_connector_state {
>  	 * @drm_atomic_helper_connector_hdmi_check().
>  	 */
>  	struct drm_connector_hdmi_state hdmi;
> +
> +	/**
> +	 * @luminance: Luminance for the connector
> +	 */
> +	unsigned int luminance;
>  };
>  
>  struct drm_connector_hdmi_audio_funcs {
> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> index 6ee70ad65e1fd..0bb1e53f36bec 100644
> --- a/include/drm/drm_file.h
> +++ b/include/drm/drm_file.h
> @@ -248,6 +248,14 @@ struct drm_file {
>  	 */
>  	bool supports_virtualized_cursor_plane;
>  
> +	/**
> +	 * @supports_luminance_control:
> +	 *
> +	 * This client is capable of setting the luminance for connectors.
> +	 *
> +	 */
> +	bool supports_luminance_control;
> +
>  	/**
>  	 * @master:
>  	 *
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 26a7281d179c1..b03737ee8dacd 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -197,6 +197,13 @@ struct backlight_properties {
>  	 */
>  	int brightness;
>  
> +	/**
> +	 * @can_disable: Minimum brightness would turn off the panel.
> +	 *
> +	 * Setting minimum brightness turns off the panel.
> +	 */
> +	bool can_disable;
> +
>  	/**
>  	 * @max_brightness: The maximum brightness value.
>  	 *
> @@ -314,6 +321,14 @@ struct backlight_device {
>  	 * @use_count: The number of unblanked displays.
>  	 */
>  	int use_count;
> +
> +	/**
> +	 * @drm_takeover: Number of luminance-aware DRM clients that have
> +	 * taken over brightness control of this device. When non-zero,
> +	 * writes to the legacy sysfs ``brightness`` attribute return
> +	 * ``-EBUSY``. Managed by the DRM backlight helpers.
> +	 */
> +	atomic_t drm_takeover;
>  };
>  
>  /* Forward declaration for backlight_update_status */
> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> index bc7ef7684099b..a3141d46d7d66 100644
> --- a/include/uapi/drm/drm.h
> +++ b/include/uapi/drm/drm.h
> @@ -903,6 +903,28 @@ struct drm_get_cap {
>   */
>  #define DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE	7
>  
> +/**
> + * DRM_CLIENT_CAP_LUMINANCE
> + *
> + * If set to 1, the client declares support for the LUMINANCE connector property
> + * and will control backlight brightness through the DRM atomic interface. This
> + * enables the kernel to expose the LUMINANCE property on connectors that have
> + * an associated backlight device.
> + *
> + * When this capability is enabled:
> + *  - The LUMINANCE property becomes visible on supported connectors
> + *  - Legacy sysfs writes to /sys/class/backlight/{*}/brightness will return
> + *    -EBUSY to prevent conflicts with DRM-based brightness control
> + *  - The client should include luminance values as part of atomic commits
> + *  - Brightness changes are synchronized with display power state (DPMS)
> + *
> + * The LUMINANCE property accepts values from 0 to max_brightness, where 0 turns
> + * off the backlight, and 1 to max_brightness control the brightness level.
> + *
> + * This capability is supported starting in kernel 7.2.
> + */
> +#define DRM_CLIENT_CAP_LUMINANCE		8
> +
>  /* DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
>  struct drm_set_client_cap {
>  	__u64 capability;

