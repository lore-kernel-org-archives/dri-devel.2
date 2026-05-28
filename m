Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA2ACD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 13:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3FCC10F1CE;
	Thu, 28 May 2026 13:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="E9EkV/8/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 077DB10F1D7
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779975832; x=1811511832;
 h=from:date:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=B9knKPDls7lXRzyYof36NmOAnIwrn9ZAQB+O892r8x0=;
 b=E9EkV/8/rM17xEZgGRZn3Nf0Jr3FWW+LdsAUjNeSl4rUGLZVNwZwz5Hr
 1TTNKkYqFTP64rCjXLyLSEbKPPkrrQ/BLDVz6jKQ3dNPMMpbPmlDDOjEl
 +5tE/YXLE82w73szfavKwXCl7XXk3pys82X9eswBk0kr7NYv2sE/smsLV
 RMfffxOrapM4i5k2sXFCghWc05QFQw6vUYGNWlyq3hK3FD4YhkE7m5OOf
 PmHmnIIRJAVEBkCAFjpSYrdD9iB/MRE4jRhhNpAe+4rzCIOav/YOI54vu
 7HVv+ZhDTwN3q+q58sbM8VqN2rOVA/Ftbio2UHIcDP1XOfoEUdVL6XlHO w==;
X-CSE-ConnectionGUID: NxQa5TD/SAezs9oIH2Dzjg==
X-CSE-MsgGUID: VwjauZYrT320SrJmHvaLyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80878460"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="80878460"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 06:43:52 -0700
X-CSE-ConnectionGUID: sLktg+TUTmWQiwwiBF8fYQ==
X-CSE-MsgGUID: IMb3xBN/SfC6lzLUChwI7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="266454894"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.187])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 06:43:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 28 May 2026 16:43:40 +0300 (EEST)
To: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
cc: airlied@gmail.com, andersson@kernel.org, bentiss@kernel.org, 
 conor+dt@kernel.org, davem@davemloft.net, devicetree@vger.kernel.org, 
 dianders@chromium.org, dri-devel@lists.freedesktop.org, 
 Hans de Goede <hansg@kernel.org>, herbert@gondor.apana.org.au, 
 jesszhan0024@gmail.com, jikos@kernel.org, konradybcio@kernel.org, 
 krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-input@vger.kernel.org, 
 LKML <linux-kernel@vger.kernel.org>, luzmaximilian@gmail.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 neil.armstrong@linaro.org, platform-driver-x86@vger.kernel.org, 
 robh@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH v2 3/7] platform/surface: SAM: Add support for Surface
 Pro 12in
In-Reply-To: <20260528133353.33312-1-harrison.vanderbyl@gmail.com>
Message-ID: <6d8be28e-1723-d529-103b-a4ba09277b41@linux.intel.com>
References: <6808166a-423c-c801-497a-ed95cccc8d0c@linux.intel.com>
 <20260528133353.33312-1-harrison.vanderbyl@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1771673666-1779975820=:1291"
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

--8323328-1771673666-1779975820=:1291
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 28 May 2026, Harrison Vanderbyl wrote:

> On Thu, 28 May 2026, Ilpo J=C3=A4rvinen wrote:
> > Could you please confirm this penstash is correct (sam vs kip)?
> >
> > Sashiko suggested it might be wrong but take it's report with a grain o=
f
> > salt, it's AI after all and sometimes seems to extrapolate about HW to =
a
> > sibling HW without any real knowledge:
>=20
> Sam is correct here, unlike the surface pro 11,=20
> The pen stash is on the reverse of the screen,
> not on the detachable keyboard.
>=20
> An image of the pen stash in use is available here:
> https://cdn-dynmedia-1.microsoft.com/is/image/microsoftcorp/B04-Surface-P=
ro-12-inch-1Ed-Family-Rear?wid=3D1200&hei=3D900&qlt=3D90&bgc=3DF2F2F2F2&fmt=
=3Djpg
>=20
> When using the above config,
> pen stash events can be seen with evtest.

Thanks for confirming (not a big surprise AI couldn't know the spec but=20
it was worth checking if it would have been because of copy-paste).

I've applied this patch 3 now to the review-ilpo-next branch.

--=20
 i.

--8323328-1771673666-1779975820=:1291--
