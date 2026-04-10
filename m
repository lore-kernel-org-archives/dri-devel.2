Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CE5EA3C5C
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 10:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF8A310E92C;
	Fri, 10 Apr 2026 10:43:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hemF5OiS";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46C7F10E92C
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 10:43:09 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1DCBD1E7;
 Fri, 10 Apr 2026 12:41:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1775817698;
 bh=bLHOvry8mx/y9qCzHWcu4EBafaHQykIVWmSbtNr2Png=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hemF5OiSr86Aoen8UoRMfRXG8SIcC5tcF2ot7ufaG6KDpk0r+BoEtMG+le2FjuTLy
 EGrSTba6m7boK5NC/jRfIEgPNerf+qL3zc4abVOnuGrMMbUqT3k9pQHayULp7cfhRx
 hb6tlG1hdMnxErqGhcAG7dxe9JzbH9RlJ7r5GVqQ=
Message-ID: <b673dcf0-d434-433b-ac07-3515b1ef4d84@ideasonboard.com>
Date: Fri, 10 Apr 2026 13:43:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xlnx/zynqmp-dpsub: Fix dependencies for COMPILE_TEST
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
References: <20260408081430.1712335-1-wenst@chromium.org>
 <386241e0-3d1b-43cc-8bc0-b6d35a97ba89@ideasonboard.com>
 <CAGXv+5HjX3FagZs5K+Z=PYQWt2a92My6wgG+ZXKh140w3Hz-QA@mail.gmail.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <CAGXv+5HjX3FagZs5K+Z=PYQWt2a92My6wgG+ZXKh140w3Hz-QA@mail.gmail.com>
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

Hi,

On 10/04/2026 12:08, Chen-Yu Tsai wrote:
> On Fri, Apr 10, 2026 at 4:49 PM Tomi Valkeinen
> <tomi.valkeinen@ideasonboard.com> wrote:
>>
>> Hi,
>>
>> On 08/04/2026 11:14, Chen-Yu Tsai wrote:
>>> The zynqmp-dpsub driver does not have build time dependencies on the PHY
>>> or DMA drivers. These are runtime hardware restrictions.
>>>
>>> Group the two dependencies with ARCH_ZYNQMP so that the driver can be
>>> compile tested without them.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>> ---
>>> IMO the two driver dependencies could be removed altogether, but that
>>> would be up to the driver and platform maintainers.
>>> ---
>>>    drivers/gpu/drm/xlnx/Kconfig | 4 +---
>>>    1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/xlnx/Kconfig b/drivers/gpu/drm/xlnx/Kconfig
>>> index cfabf5e2a0bb..4c6729459f40 100644
>>> --- a/drivers/gpu/drm/xlnx/Kconfig
>>> +++ b/drivers/gpu/drm/xlnx/Kconfig
>>> @@ -1,10 +1,8 @@
>>>    config DRM_ZYNQMP_DPSUB
>>>        tristate "ZynqMP DisplayPort Controller Driver"
>>> -     depends on ARCH_ZYNQMP || COMPILE_TEST
>>> +     depends on (ARCH_ZYNQMP && PHY_XILINX_ZYNQMP && XILINX_ZYNQMP_DPDMA) || COMPILE_TEST
>>>        depends on COMMON_CLK && DRM && OF
>>>        depends on DMADEVICES
>>> -     depends on PHY_XILINX_ZYNQMP
>>> -     depends on XILINX_ZYNQMP_DPDMA
>>>        select DMA_ENGINE
>>>        select DRM_CLIENT_SELECTION
>>>        select DRM_DISPLAY_DP_HELPER
>>
>> I think the above looks more difficult to understand than the current
>> version. We should perhaps rather drop the dependencies. But if we go
>> that way, then... we can also drop DMADEVICES, DMA_ENGINE, GENERIC_PHY
>> at least.
> 
> Perhaps. All the APIs for these are properly stubbed, so I guess
> they also count as runtime dependencies.
> 
>> What problem does this solve? Why are these two dependencies bad for
>> compile testing, but the other dependencies/selects are ok?
> 
> I was build testing changes across multiple DRM drivers in addition to
> the main platform I work on. Having to find and select each dependency
> was annoying.

Ok, makes sense.

> I would say DMADEVICES and GENERIC_PHY are much more common to embedded
> devices than SoC specific drivers.
Ok, so it was just that you already happened to have them, no searching 
needed. And I think COMMON_CLOCK and OF fall into the same category (if 
I recall right, those headers are also stubbed).

>> I personally don't mind hard runtime dependencies expressed in the
>> Kconfig, as searching for the correct dependency-drivers when your
>> driver doesn't probe is always a PITA.
> 
> I don't mind it either. But the way they are described means that compile
> testing is overly dependent on having some other platform specific
> driver enabled.
> 
> 
> I suppose another way to write this would be:
> 
>      depends on ARCH_ZYNQMP if !COMPILE_TEST
>      depends on PHY_XILINX_ZYNQMP if !COMPILE_TEST
>      depends on XILINX_ZYNQMP_DPDMA if !COMPILE_TEST
>      ...
> 
> Does that work for you?
Yes, I think having them on separate lines makes it easier to read. As 
Ville mentioned, the || COMPILE_TEST seems to be more common, so we can 
use that.

Can/should we also add the check to the select lines (DMADEVICES, 
DMA_ENGINE, GENERIC_PHY)? Does that help any? Hmm, but that requires "if 
!COMPILE_TEST", so if we do that, should we also use the same syntax for 
"depends on".

Well, in any case, I'm fine with just dealing with the two xilinx 
specific dependencies, as those have the most impact. This patch is not 
too bad, so I can pick this one. But if we were to add a couple more 
configs to the same line, then I think it makes sense to split it up...

  Tomi

