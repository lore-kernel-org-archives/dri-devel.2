Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B5DC61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 09:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D95910E48C;
	Wed,  2 Sep 2026 09:27:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XQW567dQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B0B910E486;
 Wed,  2 Sep 2026 09:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788341240; x=1819877240;
 h=from:date:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=KPrDvW0fnoXM/spnF4ccGetBZU62mAAZhQ0Hguq+iaE=;
 b=XQW567dQqeWtAIeq2pTJ4EzAD67PN31TaopyWUd+iASC85fTw0EXHS55
 6gQRRzRxQrfz5OiWvM1Aq5ljh5nuJNCWgLZoGkcLTE9EdfiZsxm4EPOHA
 /ELzdIYWKNInAmNrc5Zu3lmG3S5KGlDx32CBJUusekqg4O3c+k3Ep9ktv
 h/A92vmQiedTpCu1kJ+UrVMLaDa4+Q2aRysO0ecF4ifGqbSTd5eTSyTvm
 tI1K3sr+N/3p7kuO4KB2vam2Ty9NhiiuyYe0WuNUDWq3oDGpg47ssHeeG
 QGeIHob0qUKQf0kGrO9Y8sGenSKHdxpCh+VdguNXXxkuq3Bw3hH8LfkQ/ A==;
X-CSE-ConnectionGUID: fUP1VBmnQ2CQYsCCUwPbdw==
X-CSE-MsgGUID: fgdjAyDVQpOnRmre6dVGzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="114336702"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="114336702"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 02:27:20 -0700
X-CSE-ConnectionGUID: bQypmes+TVyLHiesV3Df/A==
X-CSE-MsgGUID: uAFY43MYR6eU1d4FFI5Nkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="263207963"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.185])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 02:27:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 2 Sep 2026 12:27:09 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
 LKML <linux-kernel@vger.kernel.org>, linux@weissschuh.net, 
 "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, 
 linux-acpi@vger.kernel.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, jani.nikula@linux.intel.com, 
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, 
 tursulin@ursulin.net, intel-gfx@lists.freedesktop.org, 
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com, 
 intel-xe@lists.freedesktop.org
Subject: Re: [PATCH v3 0/3] platform/wmi: Add aarch64 support
In-Reply-To: <46bd3385-4bd8-4a98-8ef3-57c29d00361c@gmx.de>
Message-ID: <c8445c2e-6799-7856-610c-0742248e1c07@linux.intel.com>
References: <20260724025959.142826-1-W_Armin@gmx.de>
 <59aadf0f-953c-4b7c-8c92-9dd9bc4f89de@gmx.de>
 <46bd3385-4bd8-4a98-8ef3-57c29d00361c@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-507380628-1788341229=:1183"
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

--8323328-507380628-1788341229=:1183
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 1 Sep 2026, Armin Wolf wrote:

> Am 07.08.26 um 23:03 schrieb Armin Wolf:
>=20
> > Am 24.07.26 um 04:59 schrieb Armin Wolf:
> >=20
> > > The aarch64-laptops project found out that some Windows-on-Arm
> > > notebooks contain WMI-ACPI mapping devices (PNP0C14) that work
> > > exactly like on x86. Those devices however are currently not
> > > supported by the WMI driver core due to only supporting x86.
> > >=20
> > > The first patch removes this restriction and allows the WMI
> > > driver core to run on all architectures that support ACPI.
> > > The second patch updates the acpi-video driver to take advantage
> > > of the improved support for architectures other than x86, and
> > > the last patch enables the generic WMI BMOF driver to support
> > > aarch64 as well.
> > >=20
> > > All patches have been tested on a ACPI-based aarch64 VM and
> > > work just fine.
> >=20
> > Any thoughts about this series from the GPU driver people?
> >=20
> > Thanks,
> > Armin Wolf=20
>=20
> Can i assume that the silence means "looks fine to me"?

Hi,

Those subjects may be too generic for the GPU people to realize we're=20
waiting for their Acks.

I suggest you send non-ML email (private) with a more descriptive subject=
=20
to the relevant maintainers asking for them to take look at this series=20
(I'd have done that myself later this week but you can do it as well).
Such an email is more likely to be caught in their radar.

> > > Armin Wolf (3):
> > > =C2=A0=C2=A0 platform/wmi: Remove dependency on CONFIG_X86
> > > =C2=A0=C2=A0 ACPI: video: Remove CONFIG_X86 handling from nvidia_wmi_=
ec_supported()
> > > =C2=A0=C2=A0 platform/x86: wmi-bmof: Move to generic WMI code

--=20
 i.

--8323328-507380628-1788341229=:1183--
