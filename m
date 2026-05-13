Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C22CD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 11:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1836E10E302;
	Wed, 13 May 2026 11:53:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aDv6kJpN";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98FE410E302
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:53:00 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id EDAB9229;
 Wed, 13 May 2026 13:52:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778673170;
 bh=Z8eKeo+05KskQgsdeggdbSAlsZAMrOpUqZEa1xE5beM=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=aDv6kJpNTasZLgubP7RpRdZAzMkFpMmnrX1frWXs5lEpbZxwLHCmDKWRuV74qZxkQ
 Paj3x4IdJSLRbp9X/dPZtW/XPCwe4KK+p+9Odd1ic/ePva/+rZ7ImKK5epHuIGJVFU
 w4Qshojli64ifXsnZfeb3opqlfRz6Mc/b0eu1YAw=
Message-ID: <faa20bc8-02d8-4715-a65d-2d8aa4102296@ideasonboard.com>
Date: Wed, 13 May 2026 14:52:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/panel: simple: Add timings for Raspberry Pi 7"
 panel
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To: Marek Vasut <marex@nabladev.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
 <b24c428f-5752-4544-a8b4-77e91d7bc158@ideasonboard.com>
 <da6bdb78-7fe8-4f51-b9e6-444748ebc319@nabladev.com>
 <103f94d0-2599-497d-ae37-d88922b9f669@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <103f94d0-2599-497d-ae37-d88922b9f669@ideasonboard.com>
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

On 23/04/2026 18:01, Tomi Valkeinen wrote:
> Hi,
> 
> On 23/04/2026 16:54, Marek Vasut wrote:
>> On 4/23/26 3:16 PM, Tomi Valkeinen wrote:
>>
>> Hello Tomi,
>>
>>>>> In the past I used this panel compat instead of the
>>>>> panel-raspberrypi-touchscreen.c and it worked.
>>>>> IIRC Marek splitted the multi-function module into a regulator and the
>>>>> panel description.
>>>> Ok... Indeed https://pip.raspberrypi.com/categories/651-pcn lists 
>>>> PH800480T013 as one of the panels used. Although two variants are 
>>>> listed, and also a third panel model, possibly from another vendor.
>>>>
>>>> My module is v1.1, and I think it has the PH800480T013-IAC21 D/5624/ 
>>>> KIT- LC variant.
>>> A question to Marek: Where did you get the timings for PH800480T013? 
>>> Did you find a datasheet?
>> Search engine first link:
>>
>> https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/5337/ 
>> PH800480T013-IHC09.pdf
> 
> I tested the "powertip,ph800480t013-idf02". I'm using BeagleY-AI here, 
> and it didn't work at all. After some testing, I figured out these:
> 
> HSW of 2 is much too small. But this could be an issue on the display 
> controller or the DSI encoder side. HWS of around 8 starts to work ok. 
> Below that, I don't get anything on the screen.
> 
> The syncs are interesting. I set them to DISPLAY_FLAGS_VSYNC_HIGH | 
> DISPLAY_FLAGS_HSYNC_HIGH, Marek to DRM_MODE_FLAG_NVSYNC | 
> DRM_MODE_FLAG_NHSYNC. But I have sent the TC358762 series, which fixes 
> the syncs that the bridge sends (20260327-tc358762-fixes- 
> v2-0-3589d3c45f4a@ideasonboard.com).
> 
> Flipping the syncs might explain why I used 46 and 23 as the 
> backporches, Marked used 46-hsw and 23-vsw for backporches (well, 
> Marek's vbp was off by one as I mentioned).
> 
> But now I'm getting unsure if my TC358762 fixed the syncs correctly... 
> I'm pretty sure I measured those with my scope, though.
I did some digging.

The upstream TC358762 syncs are wrong, and inverse what they're supposed 
to be. The upstream powertip,ph800480t013-idf02 timings are such that 
the image still gets centered correctly, even with the wrong syncs, but 
this makes the timings not match the datasheet.

With my TC358762 series, the syncs on the parallel bus are correct, and 
thus powertip,ph800480t013-idf02 no longer works right. My 
raspberrypi,7inch-dsi panel timings work right with the TC358762 series, 
but those panel timings have the sync polarities wrong, and thus the 
timings are also not according to the datasheet.

So: we can drop this series. I'll fix the timings for 
powertip,ph800480t013-idf02, and then it'll work with the RaspberryPi 7" 
DSI display module...

  Tomi

