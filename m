Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AA9C982DC
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:43:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8457B10F2D3;
	Fri, 18 Sep 2026 10:43:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="S6wNyiQ4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78F1710E4EE;
 Fri, 18 Sep 2026 10:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789728187; x=1821264187;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=BpzpvWMW+Kltm7l2DwODGS/qgmlr/2OVqYMl3RGVofE=;
 b=S6wNyiQ4J6aMg6wnclmDkTBV9DhckGM1+VEDSI/WDo5MwCuko47KJkNX
 4o4U/ZslhO6beWSDvpCrFinBzm0eofc5HUXjHb+qfUCC5Ivh5y/xnCeMu
 7Mc8A//4i46CfSGS8PEmJc1iWPsdaMPp6oRnEunTj2ZwXBBO9Sb01/aP1
 NKn4ZZ+pI2QSBzOMquoVBceASoZH7EX6QX4u0Z2/iEgZjO2vYnD+yV2u1
 zNcs3uYS0JQgxlbBpXTL7eT1/i4/VAq43rVtNMA9kUu4ub+FwgErx/m9h
 XJyBg7x60wvEnRg2pdlywPPuaYaohMwJQEtmeohEFloG4RJ2cAPNfhzug g==;
X-CSE-ConnectionGUID: FTiaiCtXTlmkX8cbCXAmZQ==
X-CSE-MsgGUID: aIpXf3lvQqmAs7bIBFBGzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="740718"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="740718"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 03:43:06 -0700
X-CSE-ConnectionGUID: 7a2p/7Y0SNqX+d3aCxCuNg==
X-CSE-MsgGUID: 6+NdPYf/Rkm0/R2EYyVUkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="297813291"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.245.216])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 03:43:00 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, Armin Wolf <W_Armin@gmx.de>, Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux@weissschuh.net"
 <linux@weissschuh.net>, "rafael@kernel.org" <rafael@kernel.org>,
 "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "patrik.r.jakobsson@gmail.com"
 <patrik.r.jakobsson@gmail.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
 "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, "tursulin@ursulin.net"
 <tursulin@ursulin.net>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>, "matthew.brost@intel.com"
 <matthew.brost@intel.com>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH v3 2/3] ACPI: video: Remove CONFIG_X86 handling from
 nvidia_wmi_ec_supported()
In-Reply-To: <06550473-63c2-4a3e-a5ad-7e23d7b6b050@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260724025959.142826-1-W_Armin@gmx.de>
 <20260724025959.142826-3-W_Armin@gmx.de>
 <BN9PR12MB514668975E87D570F50B2D91F7A82@BN9PR12MB5146.namprd12.prod.outlook.com>
 <86d0e015-a8f4-4e10-a9b6-a9714d3e0f07@gmx.de>
 <80c4bb47-936b-976b-6ba8-b366f7a455cf@linux.intel.com>
 <11976ed3784675ad241646287a909286a42675a8@intel.com>
 <3ef68773-e07e-437a-98fb-a3c5fc08539c@gmx.de>
 <62d7da838e7042df8456e76190db792093065b57@intel.com>
 <06550473-63c2-4a3e-a5ad-7e23d7b6b050@kernel.org>
Date: Fri, 18 Sep 2026 13:42:57 +0300
Message-ID: <d696d85c44930d2124054ce11a06d3096c0db04a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, 18 Sep 2026, Hans de Goede <hansg@kernel.org> wrote:
> Hi,
>
> On 16-Sep-26 09:16, Jani Nikula wrote:
>> On Wed, 16 Sep 2026, Armin Wolf <W_Armin@gmx.de> wrote:
>>> Am 15.09.26 um 14:31 schrieb Jani Nikula:
>>>
>>>> On Tue, 15 Sep 2026, Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com=
> wrote:
>>>>> GPU people heads up!!
>>>>>
>>>>> On Wed, 2 Sep 2026, Armin Wolf wrote:
>>>>>
>>>>>> Am 01.09.26 um 23:30 schrieb Deucher, Alexander:
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/Kconfig
>>>>>>>> index 12e4a41bf1f0..50305630f533 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
>>>>>>>> @@ -30,9 +30,7 @@ config DRM_AMDGPU
>>>>>>>>         # ACPI_VIDEO's dependencies must also be selected.
>>>>>>>>         select INPUT if ACPI
>>>>>>>>         select ACPI_VIDEO if ACPI
>>>>>>>> -     # On x86 ACPI_VIDEO also needs ACPI_WMI
>>>>>>>> -     select X86_PLATFORM_DEVICES if ACPI && X86
>>>>>>> The change below makes sense, but this one looks like it should rem=
ain
>>>>>>> unless X86_PLATFORM_DEVICES is handled some other way?
>>>>>>>
>>>>>>> Alex
>>>>>> AFAIK the dependency on X86_PLATFORM_DEVICES was only necessary beca=
use
>>>>>> ACPI-WMI depended on it in the past.
>>>>>> By now ACPI-WMI neither depends on X86_PLATFORM_DEVICES or X86 anymo=
re.
>>>>> Hi all,
>>>>>
>>>>> Could more GPU people besides Alex take a look on this. I'd want to m=
ake
>>>>> progress with this series within this cycle but would prefer to have =
Acks
>>>>> from GPU side.
>>>> I share the same concern with Alex. It seems to me we could now end up
>>>> with x86 configurations without X86_PLATFORM_DEVICES, which handle
>>>> e.g. backlight on a lot of platforms.
>>>>
>>>> I think the safer option might be to go for:
>>>>
>>>> 	depends on X86_PLATFORM_DEVICES || !X86
>>>>
>>>> in all of the cases that select/depend on X86_PLATFORM_DEVICES in drm.
>>>>
>>>> The alternative is to find out, and handle the fallout, if any.
>>>>
>>>>
>>>> BR,
>>>> Jani.
>>>
>>> Alright, should i leave the original "select X86_PLATFORM_DEVICES if ..=
." statements
>>> as-is or should is change them to "depends on X86_PLATFORM_DEVICES || !=
X86" everywhere?
>>=20
>> There are some places that depends on X86_PLATFORM_DEVICES. I think it's
>> almost always a mistake to have some places select and some places
>> depends on, and select should anyway be used with care. I'd go for
>> depends on.
>
> I'm a bit late to the party here, sorry.
>
> Note that X86_PLATFORM_DEVICES is an option which enables / disables
> a menu and does nothing more.
>
> Enabling it or depending on it by itself does nothing.
>
> The select used to be there since it must be selected to be able
> to select ACPI_WMI (which is no longer the case after this series).
>
> To depends on in XE was probably copy pasted from the existing
> select-s and then changed to a depends and already was a completely
> no-op since depending on ACPI_WMI was enough as that itself
> dependend on ACPI_WMI.
>
> As for X86_PLATFORM_DEVICES being needed for some backlight
> interfaces, depending on it by itself does not result in those
> interfaces being there. That requires enabling the actual drivers
> providing those interfaces.
>
> And I don't think that the GPU drivers should start depending
> on those since that will become very unyielding.
>
> TL;DR: I believe Armin's original patch is fine and this is
> a welcome cleanup / simplification of the DRM drivers Kconfig
> bits.

Your explanation makes sense, thanks.

BR,
Jani.


--=20
Jani Nikula, Intel
