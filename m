Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5B6C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36EA110E28D;
	Mon, 31 Aug 2026 13:36:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mPyfRjG0";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13D8C10E28D
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 13:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788183374; x=1819719374;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=zZM95wC5xa3y/ynEioVC9ujjbxihojs8MB7oUzWpMJg=;
 b=mPyfRjG0GOimpadRaSGN3RQRUdaN7t2atBejul3jQI+0qJ9Sv/4UpiaS
 9utAMiJYxNSCP7MdKFgvHDrbMGcaZ8N2PzcJ2ddiYkrD0b1g8eh4bTTns
 dO2h0lEEQeQGJcYT6OO9tB+dC3uEHZrjp7nnviFMpoTMpZIEIwZKjaznK
 A8rOaKGxzo7ubOeOzPA1RS5EAuZMir9QqbK22iij9zN0aLuC2BO7Q/tGy
 A0eZIatzwy/jtZx915SzQvBzNjq+1Ov3ECoHMWKe7L8yaBYs0fuOb+Wff
 34zpnYaaG+JKniK5javKaGp5zMHbQ9XaWn3vTTaevhixh3WDEX462G0na g==;
X-CSE-ConnectionGUID: 9GKliGhzRS2ounfYqMqP3g==
X-CSE-MsgGUID: 9vvY6SLHR0Ozs99GDwbbzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88601938"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="88601938"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 06:36:13 -0700
X-CSE-ConnectionGUID: zKscVdwFREaMaNs/TX5SHg==
X-CSE-MsgGUID: PjGE/sbmRtS8CF8mVpGbvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="268839312"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.22])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 06:36:10 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 ardb@kernel.org, ilias.apalodimas@linaro.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-efi@vger.kernel.org,
 sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2 2/3] drm/edid: Add drm_edid_get_preferred_size()
In-Reply-To: <4645113d-3b31-4d92-b392-5d5284225211@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260831093020.494701-1-tzimmermann@suse.de>
 <20260831093020.494701-3-tzimmermann@suse.de>
 <f5f1ab9e6fab9499e49f116369858ee4da626025@intel.com>
 <4645113d-3b31-4d92-b392-5d5284225211@suse.de>
Date: Mon, 31 Aug 2026 16:36:07 +0300
Message-ID: <5126b708b6e77b6bb15a355f858fcd54b732f653@intel.com>
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

On Mon, 31 Aug 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Absolutely.=C2=A0 The only reason I added this helper is that the driver=
=20
> needs the size for setting up the display pipeline before the connector=20
> exists. I looked into using the existing code without the connector, but=
=20
> that refactoring seemed to do more harm than good. Hence the new helper.

Heh, I looked into that too while reviewing, and agreed.

> Should the new function be named drm_edid_detect_panel_size() to signal=20
> the use case?

Surprisingly, no strong feelings either way, both work for me.


BR,
Jani.


--=20
Jani Nikula, Intel
