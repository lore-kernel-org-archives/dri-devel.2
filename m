Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1E8D35179
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 12:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8C9410ECB9;
	Wed,  1 Apr 2026 12:11:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="X6rJpvZI";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8449310ECB9;
 Wed,  1 Apr 2026 12:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775045484; x=1806581484;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=LtRf7ZPQ2KP/yLd6h4tuXhNMx+utLON+zyadehE9NWs=;
 b=X6rJpvZIN6WeVE5Iucn4B1k5HInlWx6dm7BDPK/rKdunPke8K+/+x/Zr
 MBC54p+dqmrwNqYPW5x5vxHgQmszWiYHkLmJyKnu+KtWgOtuak4P6f5V+
 4Hn/X4AFzPzi51k4V8oH9FthloINnxh6HUCsNM5StYRbjOWbvowY4BqRV
 N+5vBiEJEoOL6z/1hjAfqYecxrSMNauvXJCnQI6XVi/PnsktA3Pz5Edyf
 1s1YrnZu59/n6fYNtgYDk1P2TyrFFxRoDg86EeLv/LK+J5aBdLa8ToQnO
 za2Y0Q9fuKRt5442acwE3NUCbJkwZg9JhamYm2/DufdrLTLRvm+xJuh5l A==;
X-CSE-ConnectionGUID: QkfwQgSuRbOKpfVwNr/Vhw==
X-CSE-MsgGUID: QMj7VqjGSdi1IfUj608Fhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76268725"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="76268725"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 05:11:23 -0700
X-CSE-ConnectionGUID: EnIUM/blQZOH4k+QMBCR9Q==
X-CSE-MsgGUID: LVUKNrBhS52fHw78/muo5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="231071665"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.199])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 05:11:17 -0700
Date: Wed, 1 Apr 2026 15:11:14 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Xaver Hugl <xaver.hugl@kde.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Daniel Stone <daniels@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, kernel@collabora.com,
 Derek Foreman <derek.foreman@collabora.com>,
 Marius Vlad <marius.vlad@collabora.com>,
 wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
Message-ID: <ac0LYoemprz5-dDq@intel.com>
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <CAFZQkGzxfGP4E18owJf5d6L4n25-nvYn0TG=rTLCzjpj1Hk23w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFZQkGzxfGP4E18owJf5d6L4n25-nvYn0TG=rTLCzjpj1Hk23w@mail.gmail.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

On Wed, Apr 01, 2026 at 01:57:08PM +0200, Xaver Hugl wrote:
> Am Do., 19. März 2026 um 13:28 Uhr schrieb Nicolas Frattaroli
> <nicolas.frattaroli@collabora.com>:
> >
> > This series adds a new "link bpc" DRM property. It reflects the display
> > link's actual achieved output bits per component, considering any
> > degradation of the bit depth done by drivers for bandwidth or other
> > reasons. The property's value is updated during an atomic commit, which
> > is also when it fires an uevent if it changed to let userspace know.
> 
> Hi,
> I think it's a really good idea to have a property for knowing the
> actual bpc of the link... however, I do have one big concern with this
> API specifically: It only gives me this information after a modeset.
> 
> With this limitation, I can at most show the user which bpc was chosen
> after the apply display settings and have the end user manually test
> and figure things out, but I cannot show in the UI which bpc will be
> chosen with some configuration before they apply it, and I cannot do
> atomic tests to find a desired tradeoff automatically on the
> compositor side.

I think the idea of some kind of feedback properties in the atomic
commit has come up before, but no one has ever tried to implement them.

> 
> As a side note, for future patches relevant for compositors, please cc
> wayland-devel. It really shouldn't be up to chance whether or not
> compositor developers that would later use the API find out about it
> before it's merged, and keeping track of all of dri-devel is way too
> much to ask from userspace developers.
> 
> - Xaver

-- 
Ville Syrjälä
Intel
