Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AF3F9937D
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 12:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3731310F0D0;
	Thu, 23 Apr 2026 12:01:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hYU+Rth/";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C22A010F0D0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:01:57 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 030669A4;
 Thu, 23 Apr 2026 14:00:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1776945617;
 bh=Fx938U2Vfj0K/y5jh7enFEPw/OYujGES1OBKTsXTLso=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hYU+Rth/LWlUi09SWn3C1ojFeB3bob/ROPmYmxTjEC+TzCblfv6fwLHZ97Aoxhp8q
 KK8aYt7qWstD46FDSAt3LHGL8oq4RUzkmxaXoMS6iHzRJTHxKBVlJJ4rXcZ+UltJ3o
 0oDuaK1K8Wnvw9XxASotvt1EjrM5algZ1YOzfjdY=
Message-ID: <af71183d-70b8-4a41-8466-67123e7aab02@ideasonboard.com>
Date: Thu, 23 Apr 2026 15:01:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/panel: simple: Add timings for Raspberry Pi 7"
 panel
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260420-rpi-7inch-v1-0-e68d5c9c44bc@ideasonboard.com>
 <20260420-rpi-7inch-v1-2-e68d5c9c44bc@ideasonboard.com>
 <3z3u5mbngmbzsch3mzs3twlh3aec6r7jokstzv3ghxyusrzt6b@jqvdnuiapx6e>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <3z3u5mbngmbzsch3mzs3twlh3aec6r7jokstzv3ghxyusrzt6b@jqvdnuiapx6e>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

On 22/04/2026 22:22, Dmitry Baryshkov wrote:
> On Mon, Apr 20, 2026 at 04:13:36PM +0300, Tomi Valkeinen wrote:
>> Add timings for the panel used in Raspberry Pi 7" DSI Display module:
>> https://www.raspberrypi.com/products/raspberry-pi-touch-display/
>>
>> This has been tested with version v1.1 of the display module.
>>
>> The panel is very strict about the back-porch values, they must be
>> exactly 46 for hbp and 23 for vbp. Other timings can be defined quite
>> freely.
>>
>> The panel is exclusive to Raspberry Pi, and different versions of the
>> display module can have panels from different vendors which are fully
>> compatible. Also, as the panel vendors are not public, the compatible
>> string used is "raspberrypi,7inch-dsi".
>>
>> Note that while the display module has a DSI connector, and the
>> compatible has "dsi" in it, we use DRM_MODE_CONNECTOR_DPI as the panel
>> itself is a parallel video panel. The display module (as of v1.1) uses
>> TC358762 DSI-to-DPI bridge to do the conversion.
>>
>> We could use DRM_MODE_CONNECTOR_DSI here, which would have the benefit
>> of showing a "DSI-1" connector to the userspace. However, the panel IS a
>> DPI panel, and gets its input from a DSI-to-DPI bridge, and the
>> panel-simple.c behaves differently depending on the connector type used,
>> so, DRM_MODE_CONNECTOR_DPI it is.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>> ---
>>   drivers/gpu/drm/panel/panel-simple.c | 32 ++++++++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
>> index 91ab280869ba..e75eb20301f2 100644
>> --- a/drivers/gpu/drm/panel/panel-simple.c
>> +++ b/drivers/gpu/drm/panel/panel-simple.c
>> @@ -4208,6 +4208,35 @@ static const struct panel_desc rocktech_rk043fn48h = {
>>   	.connector_type = DRM_MODE_CONNECTOR_DPI,
>>   };
>>   
>> +static const struct display_timing raspberrypi_7inch_timing = {
>> +	.pixelclock = { 10000000, 30000000, 50000000 },
>> +	.hactive = { 800, 800, 800 },
>> +	.hfront_porch = { 16, 72, 354 },
>> +	.hsync_len = { 1, 32, 40 },
>> +	.hback_porch = { 46, 46, 46 },
>> +	.vactive = { 480, 480, 480 },
>> +	.vfront_porch = { 7, 21, 147 },
>> +	.vsync_len = { 1, 2, 20 },
>> +	.vback_porch = { 23, 23, 23 },
>> +	.flags = DISPLAY_FLAGS_VSYNC_HIGH | DISPLAY_FLAGS_HSYNC_HIGH,
>> +	/* Note: the rest of the flags are defined below in bus_flags */
>> +};
> 
> This looks pretty close to powertip panels that have been used before
> hand in those modules. Are you sure that powertip,ph800480t013-idf02
> or powertip,ph800480t032-zhc19 don't work for you?

I haven't tested those, but the hbp and vbp do not seem to be the same. 
For me, they had to be exactly as they are here. This was also confirmed 
from Raspberry Pi, the panel datasheet had min/typ/max values (i.e. not 
ranges) of 46 and 23 for back porches.

Where did the information come from that powertip,ph800480t013-idf02 or 
powertip,ph800480t032-zhc19 are used in the display modules? Or did you 
mean that while those models are not used in the Raspberry display 
module, people have used them successfully?

  Tomi

