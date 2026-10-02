Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD731CA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 11:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 123D210E3C7;
	Fri,  2 Oct 2026 11:06:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Rq724k8A";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B437E10E34E;
 Fri,  2 Oct 2026 11:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790939214; x=1822475214;
 h=from:date:to:cc:subject:in-reply-to:message-id:
 references:mime-version:content-id;
 bh=iVs/6MWO+8q0fKTudkDlTIGtM1VvF7ZOENUVyUx0evs=;
 b=Rq724k8AaYXkD0Z4+arBJ/gPlo/GYjgNcyCt06G5w1GlSfIh7UsNqNOj
 aYq0PUoHb34a10HCzLPaJTvDgZewi3iKpIZQeMKNlY1iOHXkOE3MuTSJT
 essOnLjN56VOyeQN1LSfWgBS4HAJ/648szFHWeV0BLBwxSljuncqJoHEH
 Dp3stbhVVxy5zi3HpD1uv4Uu8eKSDwjmI+2F/yGl3n3F/89J14AFu0cSD
 DFfRikLm9APtEgRSVYbxspyYM+cFInrByo6D+IsCGS5eSfAdaQ31YBH4S
 xFnpAbECXRhr3UUqyUNjZ7hlOFpkwKNodmj7BjKeIFP5WVTZNojnCCm0A Q==;
X-CSE-ConnectionGUID: FnSFY8DvRSeFnp+eQkjQiA==
X-CSE-MsgGUID: 4KDnwxybTVmxORB1MjJosQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90840786"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="90840786"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 04:06:53 -0700
X-CSE-ConnectionGUID: QgNatFWjTVWtaEFzHzuunQ==
X-CSE-MsgGUID: 7jABSax3Tsy0UNm4lm3j2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="252607"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.243])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 04:06:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 2 Oct 2026 14:06:40 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: Alex Deucher <alexdeucher@gmail.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Hans de Goede <hansg@kernel.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "linux@weissschuh.net" <linux@weissschuh.net>, 
 "rafael@kernel.org" <rafael@kernel.org>, 
 "lenb@kernel.org" <lenb@kernel.org>, 
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, 
 "airlied@gmail.com" <airlied@gmail.com>, 
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
Subject: Re: [PATCH v3 2/3] ACPI: video: Remove CONFIG_X86 handling from
 nvidia_wmi_ec_supported()
In-Reply-To: <154fc984-5c29-4a23-ab8b-736471f419a1@gmx.de>
Message-ID: <1ff7a529-15bb-e166-5bf1-3dad34119bcd@linux.intel.com>
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
 <154fc984-5c29-4a23-ab8b-736471f419a1@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2070456929-1790935925=:1156"
Content-ID: <75628c1c-0bd3-f8c4-b5a1-0f09ab6ce72d@linux.intel.com>
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2070456929-1790935925=:1156
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <09d346bc-de98-fbe2-c9e5-d57da5cc6f1a@linux.intel.com>

On Tue, 22 Sep 2026, Armin Wolf wrote:

> Am 18.09.26 um 15:03 schrieb Alex Deucher:
>=20
> > On Fri, Sep 18, 2026 at 7:01=E2=80=AFAM Jani Nikula <jani.nikula@linux.=
intel.com>
> > wrote:
> > > On Fri, 18 Sep 2026, Hans de Goede <hansg@kernel.org> wrote:
> > > > Hi,
> > > >=20
> > > > On 16-Sep-26 09:16, Jani Nikula wrote:
> > > > > On Wed, 16 Sep 2026, Armin Wolf <W_Armin@gmx.de> wrote:
> > > > > > Am 15.09.26 um 14:31 schrieb Jani Nikula:
> > > > > >=20
> > > > > > > On Tue, 15 Sep 2026, Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.=
intel.com>
> > > > > > > wrote:
> > > > > > > > GPU people heads up!!
> > > > > > > >=20
> > > > > > > > On Wed, 2 Sep 2026, Armin Wolf wrote:
> > > > > > > >=20
> > > > > > > > > Am 01.09.26 um 23:30 schrieb Deucher, Alexander:
> > > > > > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig
> > > > > > > > > > > b/drivers/gpu/drm/amd/amdgpu/Kconfig
> > > > > > > > > > > index 12e4a41bf1f0..50305630f533 100644
> > > > > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> > > > > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> > > > > > > > > > > @@ -30,9 +30,7 @@ config DRM_AMDGPU
> > > > > > > > > > >          # ACPI_VIDEO's dependencies must also be
> > > > > > > > > > > selected.
> > > > > > > > > > >          select INPUT if ACPI
> > > > > > > > > > >          select ACPI_VIDEO if ACPI
> > > > > > > > > > > -     # On x86 ACPI_VIDEO also needs ACPI_WMI
> > > > > > > > > > > -     select X86_PLATFORM_DEVICES if ACPI && X86
> > > > > > > > > > The change below makes sense, but this one looks like i=
t
> > > > > > > > > > should remain
> > > > > > > > > > unless X86_PLATFORM_DEVICES is handled some other way?
> > > > > > > > > >=20
> > > > > > > > > > Alex
> > > > > > > > > AFAIK the dependency on X86_PLATFORM_DEVICES was only
> > > > > > > > > necessary because
> > > > > > > > > ACPI-WMI depended on it in the past.
> > > > > > > > > By now ACPI-WMI neither depends on X86_PLATFORM_DEVICES o=
r X86
> > > > > > > > > anymore.
> > > > > > > > Hi all,
> > > > > > > >=20
> > > > > > > > Could more GPU people besides Alex take a look on this. I'd=
 want
> > > > > > > > to make
> > > > > > > > progress with this series within this cycle but would prefe=
r to
> > > > > > > > have Acks
> > > > > > > > from GPU side.
> > > > > > > I share the same concern with Alex. It seems to me we could n=
ow
> > > > > > > end up
> > > > > > > with x86 configurations without X86_PLATFORM_DEVICES, which h=
andle
> > > > > > > e.g. backlight on a lot of platforms.
> > > > > > >=20
> > > > > > > I think the safer option might be to go for:
> > > > > > >=20
> > > > > > >     depends on X86_PLATFORM_DEVICES || !X86
> > > > > > >=20
> > > > > > > in all of the cases that select/depend on X86_PLATFORM_DEVICE=
S in
> > > > > > > drm.
> > > > > > >=20
> > > > > > > The alternative is to find out, and handle the fallout, if an=
y.
> > > > > > >=20
> > > > > > >=20
> > > > > > > BR,
> > > > > > > Jani.
> > > > > > Alright, should i leave the original "select X86_PLATFORM_DEVIC=
ES if
> > > > > > ..." statements
> > > > > > as-is or should is change them to "depends on X86_PLATFORM_DEVI=
CES
> > > > > > || !X86" everywhere?
> > > > > There are some places that depends on X86_PLATFORM_DEVICES. I thi=
nk
> > > > > it's
> > > > > almost always a mistake to have some places select and some place=
s
> > > > > depends on, and select should anyway be used with care. I'd go fo=
r
> > > > > depends on.
> > > > I'm a bit late to the party here, sorry.
> > > >=20
> > > > Note that X86_PLATFORM_DEVICES is an option which enables / disable=
s
> > > > a menu and does nothing more.
> > > >=20
> > > > Enabling it or depending on it by itself does nothing.
> > > >=20
> > > > The select used to be there since it must be selected to be able
> > > > to select ACPI_WMI (which is no longer the case after this series).
> > > >=20
> > > > To depends on in XE was probably copy pasted from the existing
> > > > select-s and then changed to a depends and already was a completely
> > > > no-op since depending on ACPI_WMI was enough as that itself
> > > > dependend on ACPI_WMI.
> > > >=20
> > > > As for X86_PLATFORM_DEVICES being needed for some backlight
> > > > interfaces, depending on it by itself does not result in those
> > > > interfaces being there. That requires enabling the actual drivers
> > > > providing those interfaces.
> > > >=20
> > > > And I don't think that the GPU drivers should start depending
> > > > on those since that will become very unyielding.
> > > >=20
> > > > TL;DR: I believe Armin's original patch is fine and this is
> > > > a welcome cleanup / simplification of the DRM drivers Kconfig
> > > > bits.
> > > Your explanation makes sense, thanks.
> > Yeah, sounds good.  Thanks!
> >=20
> > Alex
>=20
> Nice, i suppose we can apply this series as-is then?

Hi all,

I don't see anyone opposing this anymore and the discussion has died down=
=20
so I took this into the review-ilpo-next branch.

If somebody still feels there's something wrong with this, please let me=20
know soonish.

--=20
 i.
--8323328-2070456929-1790935925=:1156--
