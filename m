Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE095CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9E6B11209F;
	Thu, 15 Oct 2026 15:30:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id E630911209F
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:30:22 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BEE014BF;
 Thu, 15 Oct 2026 08:30:19 -0700 (PDT)
Received: from [10.0.129.161] (e122027.cambridge.arm.com [10.0.129.161])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCFBD3F673;
 Thu, 15 Oct 2026 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792078222; bh=WRAeDjp6ofWENcWyqlqxSVWzgxgCX5uDEs3cM8Yt0eA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Y+pP9h7BJxusSlS03Q6z2ZFV09L2INalDQyHlpSM/lPJufCj6I5C6RTROAtaSzENR
 z8oThpKU6Re4VlEP1SbYn1guC8+GQjJgbg6wXI19NrGz872DeKPxeMuAAm5dlhsJ48
 Qih4pZJAWrLUaX1VWEkVaR5b8UZBQJJ+GpAUcMag=
Message-ID: <39917273-a23f-467f-86e5-8a8a954ca3b4@arm.com>
Date: Thu, 15 Oct 2026 16:30:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panfrost: reset the Amlogic GXM GPU on runtime resume
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Christian Hewitt <christianshewitt@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <daniel@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260930125629.2691968-1-christianshewitt@gmail.com>
 <179184031154.1056803.12154076398577087527.b4-review@b4>
 <6B9C57A7-8BE5-461B-B44B-EF91FC2D2D93@gmail.com> <as_A5ygwMkEgGeP4@sobremesa>
 <as_EPvb8S2rYmeRj@sobremesa>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <as_EPvb8S2rYmeRj@sobremesa>
Content-Type: text/plain; charset=UTF-8
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

On 14/10/2026 19:05, Adrián Larumbe wrote:
> CC: Neil Armstrong
> 
> On 14.10.2026 19:03, Adrián Larumbe wrote:
>> Hi Christian,
>>
>> On 13.10.2026 09:02, Christian Hewitt wrote:
>>>> On 13 Oct 2026, at 1:25 am, Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
>>>>
>>>> On Wed, 30 Sep 2026 12:56:29 +0000, Christian Hewitt <christianshewitt@gmail.com> wrote:
>>>>> After its first runtime suspend, every power-off of the Mali-T820 in
>>>>> Amlogic GXM SoCs times out and floods the log with shader, tiler and L2
>>>>> power transition timeouts. Following a soft reset the cores report not
>>>>> ready but PWRTRANS never clears, however long the driver waits.
>>>>
>>>> Would you mind building the driver from the latest drm-misc-next and testing
>>>> whether this is still the case? Today I merged a patch series with a fix
>>>> for a long-standing bug that prevented the device from going into suspension
>>>> because of mismanagement of the PM refcount. It might be that what you report
>>>> as an issue triggered by power transitions is something altogether different.
>>>
>>> I’d tested with the v12 iteration of your series in my amlogic-7.3.y [0] tree
>>> before generating the patch I submitted. I’ve now tested with v15 (as merged)
>>> and other recent panfrost patches you submitted (which v15 depends upon) and
>>> with this patch reverted, and the timeout issue with T820 remains. I also saw
>>> a splat that I wasn’t seeing with the v12 iteration [1].
>>>
>>> [0] https://github.com/chewitt/linux/commits/amlogic-7.3.y
>>> [1] https://paste.libreelec.tv/desertic-cataleya.log
>>
>> Turns out I was wrong about having easy access to a Khadas VIM2, so whatever I try to
>> gather about the existing bug must come from these logs. I see one very interesting
>> warning in [1]:
>>
>> WARNING: drivers/gpu/drm/panfrost/panfrost_device.c:490 at panfrost_exception_name+0x1c/0x30 [panfrost], CPU#0: swapper/0/0
>>
>> Something's causing the GPU to report a fault whose status code is at
>> present not documented in the driver.
>>
>> I think that, because this seems like an SoC integration issue, and because of the unknown
>> exception being reported by the GPU, we should have some further input from an Amlogic SoC
>> subsystem maintainer, and also Steven Price himself.

Here I am ;)

From the log:

panfrost d00c0000.gpu: GPU Fault 0x00de024f (Unknown exception type) at
0xba86fee1846eb817

This looks more like garbage been read from the GPU rather than a real
fault. As the driver reports 0x4f is an unknown exception type - it
shouldn't be reported.

Other suspicious things are that the Engineering Spec says the SOURCE_ID
field "does not exist", so I'd expect zeros to be read there rather than
0x00de. And the address 0xba86fee1846eb817 is well beyond the address
limit of the hardware.

Which is consistent with the GPU being in a bad condition immediately
after power up and before being reset. Without detailed knowledge of the
SoC I'm not sure I can explain whether simply adding GPU_PM_RT is correct.

We already have the magic PWR_OVERRIDE1 value which is simply passed
from the GPU to the integration logic. It's possible that e.g. writing
this a second time after performing an external reset is problematic.
Sadly as the value is passed straight to the integration logic I don't
have any documentation on what the magic value does.

Thanks,
Steve

>>> After reinstating this patch on v15 + dependencies dmesg is clean again [2].
>>>
>>> [2] https://paste.libreelec.tv/leptosomatic-cherlyn.log
>>>
>>>>> The transitions complete normally when the GPU comes out of a hardware
>>>>> reset, as it does at probe. Use runtime PM with reset and clock control
>>>>
>>>> panfrost_device_reset() is always called as part of the PM runtime resume
>>>> operation, so I'm assuming what you mean here is that reset control is
>>>> deasserted at runtime resume when the SoC supports it
>>>
>>> I’m firmly at the hobbyist end of kernel contributors and I’m not able to
>>> technically explain the patch Claude created. It’s entirely possible that it
>>> pokes around in the right area of code but is not the correct fix, but I lack
>>> the knowledge to dig further without explicit guidance. I can also give you
>>> remote access to a Khadas VIM2 board if that would be easier or useful?
>>>
>>> Christian
>>
>> Adrian Larumbe
> 

