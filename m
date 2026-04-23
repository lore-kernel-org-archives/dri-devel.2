Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896A3F589D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF49810F10C;
	Thu, 23 Apr 2026 13:16:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jRt2M6R7";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F4B210F10C
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:16:39 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1D2BD9A4;
 Thu, 23 Apr 2026 15:14:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1776950099;
 bh=g0tfRCWfNS80U1BG80fTONyoMqk2OH2q2gq5EU3XOxE=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=jRt2M6R7ch4AN89uPIbi678C1fbUwm1eWdNNWNj5xcIwsqYjIm9wf3NuYmng7EYTN
 7wO+h4ZMYV9fgYF8hknnBrkEq7JfxQJZTAVhOkQqwR4Ba4A1xvDsJgM9ajCNWYLzVH
 yn69OFGEjWxOE/1rqCwz0KHcpF7SowBiVBJUPSWQ=
Message-ID: <b24c428f-5752-4544-a8b4-77e91d7bc158@ideasonboard.com>
Date: Thu, 23 Apr 2026 16:16:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/panel: simple: Add timings for Raspberry Pi 7"
 panel
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Marek Vasut <marex@denx.de>
Cc: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260420-rpi-7inch-v1-0-e68d5c9c44bc@ideasonboard.com>
 <20260420-rpi-7inch-v1-2-e68d5c9c44bc@ideasonboard.com>
 <3z3u5mbngmbzsch3mzs3twlh3aec6r7jokstzv3ghxyusrzt6b@jqvdnuiapx6e>
 <af71183d-70b8-4a41-8466-67123e7aab02@ideasonboard.com>
 <20260423-kickass-fat-boa-209f68@houat>
 <72c2cd94-0a8b-46c8-981b-4ad4a3222e59@ideasonboard.com>
 <CAO9ioeVX6OChRTgUrUdgrPF+3s2_7vme7m0yb85pjYtH1MFskw@mail.gmail.com>
 <ced05a92-06b4-4f6f-95b6-c3dc104c35f3@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <ced05a92-06b4-4f6f-95b6-c3dc104c35f3@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Marek,

On 23/04/2026 16:13, Tomi Valkeinen wrote:
> Hi,
> 
> On 23/04/2026 15:33, Dmitry Baryshkov wrote:
>> On Thu, 23 Apr 2026 at 15:28, Tomi Valkeinen
>> <tomi.valkeinen@ideasonboard.com> wrote:
>>>
>>> Hi,
>>>
>>> On 23/04/2026 15:14, Maxime Ripard wrote:
>>>> Hi,
>>>>
>>>> On Thu, Apr 23, 2026 at 03:01:51PM +0300, Tomi Valkeinen wrote:
>>>>> On 22/04/2026 22:22, Dmitry Baryshkov wrote:
>>>>>> On Mon, Apr 20, 2026 at 04:13:36PM +0300, Tomi Valkeinen wrote:
>>>>>>> Add timings for the panel used in Raspberry Pi 7" DSI Display 
>>>>>>> module:
>>>>>>> https://www.raspberrypi.com/products/raspberry-pi-touch-display/
>>>>>>>
>>>>>>> This has been tested with version v1.1 of the display module.
>>>>>>>
>>>>>>> The panel is very strict about the back-porch values, they must be
>>>>>>> exactly 46 for hbp and 23 for vbp. Other timings can be defined 
>>>>>>> quite
>>>>>>> freely.
>>>>>>>
>>>>>>> The panel is exclusive to Raspberry Pi, and different versions of 
>>>>>>> the
>>>>>>> display module can have panels from different vendors which are 
>>>>>>> fully
>>>>>>> compatible. Also, as the panel vendors are not public, the 
>>>>>>> compatible
>>>>>>> string used is "raspberrypi,7inch-dsi".
>>>>>>>
>>>>>>> Note that while the display module has a DSI connector, and the
>>>>>>> compatible has "dsi" in it, we use DRM_MODE_CONNECTOR_DPI as the 
>>>>>>> panel
>>>>>>> itself is a parallel video panel. The display module (as of v1.1) 
>>>>>>> uses
>>>>>>> TC358762 DSI-to-DPI bridge to do the conversion.
>>>>>>>
>>>>>>> We could use DRM_MODE_CONNECTOR_DSI here, which would have the 
>>>>>>> benefit
>>>>>>> of showing a "DSI-1" connector to the userspace. However, the 
>>>>>>> panel IS a
>>>>>>> DPI panel, and gets its input from a DSI-to-DPI bridge, and the
>>>>>>> panel-simple.c behaves differently depending on the connector 
>>>>>>> type used,
>>>>>>> so, DRM_MODE_CONNECTOR_DPI it is.
>>>>>>>
>>>>>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/panel/panel-simple.c | 32 +++++++++++++++++++ 
>>>>>>> +++++++++++++
>>>>>>>     1 file changed, 32 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/ 
>>>>>>> drm/panel/panel-simple.c
>>>>>>> index 91ab280869ba..e75eb20301f2 100644
>>>>>>> --- a/drivers/gpu/drm/panel/panel-simple.c
>>>>>>> +++ b/drivers/gpu/drm/panel/panel-simple.c
>>>>>>> @@ -4208,6 +4208,35 @@ static const struct panel_desc 
>>>>>>> rocktech_rk043fn48h = {
>>>>>>>             .connector_type = DRM_MODE_CONNECTOR_DPI,
>>>>>>>     };
>>>>>>> +static const struct display_timing raspberrypi_7inch_timing = {
>>>>>>> +  .pixelclock = { 10000000, 30000000, 50000000 },
>>>>>>> +  .hactive = { 800, 800, 800 },
>>>>>>> +  .hfront_porch = { 16, 72, 354 },
>>>>>>> +  .hsync_len = { 1, 32, 40 },
>>>>>>> +  .hback_porch = { 46, 46, 46 },
>>>>>>> +  .vactive = { 480, 480, 480 },
>>>>>>> +  .vfront_porch = { 7, 21, 147 },
>>>>>>> +  .vsync_len = { 1, 2, 20 },
>>>>>>> +  .vback_porch = { 23, 23, 23 },
>>>>>>> +  .flags = DISPLAY_FLAGS_VSYNC_HIGH | DISPLAY_FLAGS_HSYNC_HIGH,
>>>>>>> +  /* Note: the rest of the flags are defined below in bus_flags */
>>>>>>> +};
>>>>>>
>>>>>> This looks pretty close to powertip panels that have been used before
>>>>>> hand in those modules. Are you sure that powertip,ph800480t013-idf02
>>>>>> or powertip,ph800480t032-zhc19 don't work for you?
>>>>>
>>>>> I haven't tested those, but the hbp and vbp do not seem to be the 
>>>>> same. For
>>>>> me, they had to be exactly as they are here. This was also 
>>>>> confirmed from
>>>>> Raspberry Pi, the panel datasheet had min/typ/max values (i.e. not 
>>>>> ranges)
>>>>> of 46 and 23 for back porches.
>>>>>
>>>>> Where did the information come from that powertip,ph800480t013- 
>>>>> idf02 or
>>>>> powertip,ph800480t032-zhc19 are used in the display modules? Or did 
>>>>> you mean
>>>>> that while those models are not used in the Raspberry display 
>>>>> module, people
>>>>> have used them successfully?
>>
>> For the zhc19 it's a wild guess, but for the idf02 it more of a 
>> certainity:
>>
>> commit d69de69f2be105b2474c05a5ca4827aac3e80ad3
>> Author: Marek Vasut <marex@denx.de>
>> Date:   Tue Jul 28 14:12:46 2020 +0200
>>
>>      drm/panel: simple: Add Powertip PH800480T013 panel
>>
>>      Add support for Powertip PH800480T013 800x480 parallel LCD, this
>>      one is used in the Raspberry Pi 7" touchscreen display unit.
>>
>> In the past I used this panel compat instead of the
>> panel-raspberrypi-touchscreen.c and it worked.
>> IIRC Marek splitted the multi-function module into a regulator and the
>> panel description.
> Ok... Indeed https://pip.raspberrypi.com/categories/651-pcn lists 
> PH800480T013 as one of the panels used. Although two variants are 
> listed, and also a third panel model, possibly from another vendor.
> 
> My module is v1.1, and I think it has the PH800480T013-IAC21 D/5624/KIT- 
> LC variant.
A question to Marek: Where did you get the timings for PH800480T013? Did 
you find a datasheet?

  Tomi

