Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D51C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:57:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C9C010EE51;
	Tue, 22 Sep 2026 19:57:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=w_armin@gmx.de header.b="Q3nH38P7";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87CFB10EE51;
 Tue, 22 Sep 2026 19:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1790107042; x=1790711842; i=w_armin@gmx.de;
 bh=lUdjrgZaJzfqhGj+CZN4gVxm1gbrnsp7WHgXh1rIN7c=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Q3nH38P7FiqPSIwijIqpJl4qV/w8EGNAi7QaGskWYTaZ/95LruwLqxCd78yBTMKQ
 moghfXNreGJiicMMCIeYg2qMpKg3GdbTA4mNes9B1RKHZ7ktZMke3y1Flt+OKAhSH
 ItVQCa1txDmEAiUjQZYL4NBOzezgzfbms79zkIyC6z40o0yYbACeCI1xIdkZ7vXOR
 478n9IGSWR54cHZ3iGQY3Oik+9+fJ8LWknH8f3SHvtGjIet4EySSJOQdjOXn+ZLqw
 wJKHpYci6wXMFj3I1GFrsx5XsouSiO+V1UG+qbv7Ysy4yU3DPPaHRb4MNnjg2Il3k
 pMJQqt3QE3ia+ooZkQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0G1d-1wnhmo2wGV-00vygm; Tue, 22
 Sep 2026 21:57:21 +0200
Message-ID: <154fc984-5c29-4a23-ab8b-736471f419a1@gmx.de>
Date: Tue, 22 Sep 2026 21:57:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] ACPI: video: Remove CONFIG_X86 handling from
 nvidia_wmi_ec_supported()
To: Alex Deucher <alexdeucher@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux@weissschuh.net" <linux@weissschuh.net>,
 "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "patrik.r.jakobsson@gmail.com" <patrik.r.jakobsson@gmail.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
 "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
 "tursulin@ursulin.net" <tursulin@ursulin.net>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "matthew.brost@intel.com" <matthew.brost@intel.com>,
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
References: <20260724025959.142826-1-W_Armin@gmx.de>
 <20260724025959.142826-3-W_Armin@gmx.de>
 <BN9PR12MB514668975E87D570F50B2D91F7A82@BN9PR12MB5146.namprd12.prod.outlook.com>
 <86d0e015-a8f4-4e10-a9b6-a9714d3e0f07@gmx.de>
 <80c4bb47-936b-976b-6ba8-b366f7a455cf@linux.intel.com>
 <11976ed3784675ad241646287a909286a42675a8@intel.com>
 <3ef68773-e07e-437a-98fb-a3c5fc08539c@gmx.de>
 <62d7da838e7042df8456e76190db792093065b57@intel.com>
 <06550473-63c2-4a3e-a5ad-7e23d7b6b050@kernel.org>
 <d696d85c44930d2124054ce11a06d3096c0db04a@intel.com>
 <CADnq5_PT7s6ixTqDSwe9ai9tUQa04z7UnwhMn7bo7CcsH5Qf0w@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CADnq5_PT7s6ixTqDSwe9ai9tUQa04z7UnwhMn7bo7CcsH5Qf0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DJjjhzJDv8/qqyn2q0PQQ9fzXlULLkpabRwG4Kn6xVvc3cn4W3q
 hmebeIApgD0nPHvWojpnL7UFoLBMPvZH9ZiOecw3l02nvRrbaumPLA1OvGcQ6HYytx7gWUj
 DCQbHO7maI36AgrTuWNqOy9O1xPBGF8EMdN1c2eYkELsibI1tl1xTZ1+DNPSyxWxUBE9HUA
 gf95mrxJ41oQmG5m1a4Og==
UI-OutboundReport: notjunk:1;M01:P0:fy0f+RFzDeo=;9Ghb8np9aCDwxhlLmFb+4wWbpFS
 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
 zrU+bcacErcutgVuQ==
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

Am 18.09.26 um 15:03 schrieb Alex Deucher:

> On Fri, Sep 18, 2026 at 7:01=E2=80=AFAM Jani Nikula <jani.nikula@linux.i=
ntel.com> wrote:
>> On Fri, 18 Sep 2026, Hans de Goede <hansg@kernel.org> wrote:
>>> Hi,
>>>
>>> On 16-Sep-26 09:16, Jani Nikula wrote:
>>>> On Wed, 16 Sep 2026, Armin Wolf <W_Armin@gmx.de> wrote:
>>>>> Am 15.09.26 um 14:31 schrieb Jani Nikula:
>>>>>
>>>>>> On Tue, 15 Sep 2026, Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.=
com> wrote:
>>>>>>> GPU people heads up!!
>>>>>>>
>>>>>>> On Wed, 2 Sep 2026, Armin Wolf wrote:
>>>>>>>
>>>>>>>> Am 01.09.26 um 23:30 schrieb Deucher, Alexander:
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/Kconfig
>>>>>>>>>> index 12e4a41bf1f0..50305630f533 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
>>>>>>>>>> @@ -30,9 +30,7 @@ config DRM_AMDGPU
>>>>>>>>>>          # ACPI_VIDEO's dependencies must also be selected.
>>>>>>>>>>          select INPUT if ACPI
>>>>>>>>>>          select ACPI_VIDEO if ACPI
>>>>>>>>>> -     # On x86 ACPI_VIDEO also needs ACPI_WMI
>>>>>>>>>> -     select X86_PLATFORM_DEVICES if ACPI && X86
>>>>>>>>> The change below makes sense, but this one looks like it should =
remain
>>>>>>>>> unless X86_PLATFORM_DEVICES is handled some other way?
>>>>>>>>>
>>>>>>>>> Alex
>>>>>>>> AFAIK the dependency on X86_PLATFORM_DEVICES was only necessary b=
ecause
>>>>>>>> ACPI-WMI depended on it in the past.
>>>>>>>> By now ACPI-WMI neither depends on X86_PLATFORM_DEVICES or X86 an=
ymore.
>>>>>>> Hi all,
>>>>>>>
>>>>>>> Could more GPU people besides Alex take a look on this. I'd want t=
o make
>>>>>>> progress with this series within this cycle but would prefer to ha=
ve Acks
>>>>>>> from GPU side.
>>>>>> I share the same concern with Alex. It seems to me we could now end=
 up
>>>>>> with x86 configurations without X86_PLATFORM_DEVICES, which handle
>>>>>> e.g. backlight on a lot of platforms.
>>>>>>
>>>>>> I think the safer option might be to go for:
>>>>>>
>>>>>>     depends on X86_PLATFORM_DEVICES || !X86
>>>>>>
>>>>>> in all of the cases that select/depend on X86_PLATFORM_DEVICES in d=
rm.
>>>>>>
>>>>>> The alternative is to find out, and handle the fallout, if any.
>>>>>>
>>>>>>
>>>>>> BR,
>>>>>> Jani.
>>>>> Alright, should i leave the original "select X86_PLATFORM_DEVICES if=
 ..." statements
>>>>> as-is or should is change them to "depends on X86_PLATFORM_DEVICES |=
| !X86" everywhere?
>>>> There are some places that depends on X86_PLATFORM_DEVICES. I think i=
t's
>>>> almost always a mistake to have some places select and some places
>>>> depends on, and select should anyway be used with care. I'd go for
>>>> depends on.
>>> I'm a bit late to the party here, sorry.
>>>
>>> Note that X86_PLATFORM_DEVICES is an option which enables / disables
>>> a menu and does nothing more.
>>>
>>> Enabling it or depending on it by itself does nothing.
>>>
>>> The select used to be there since it must be selected to be able
>>> to select ACPI_WMI (which is no longer the case after this series).
>>>
>>> To depends on in XE was probably copy pasted from the existing
>>> select-s and then changed to a depends and already was a completely
>>> no-op since depending on ACPI_WMI was enough as that itself
>>> dependend on ACPI_WMI.
>>>
>>> As for X86_PLATFORM_DEVICES being needed for some backlight
>>> interfaces, depending on it by itself does not result in those
>>> interfaces being there. That requires enabling the actual drivers
>>> providing those interfaces.
>>>
>>> And I don't think that the GPU drivers should start depending
>>> on those since that will become very unyielding.
>>>
>>> TL;DR: I believe Armin's original patch is fine and this is
>>> a welcome cleanup / simplification of the DRM drivers Kconfig
>>> bits.
>> Your explanation makes sense, thanks.
> Yeah, sounds good.  Thanks!
>
> Alex

Nice, i suppose we can apply this series as-is then?

Thanks,
Armin Wolf

>> BR,
>> Jani.
>>
>>
>> --
>> Jani Nikula, Intel
