Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF54CDB479
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 14:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAB1910EB88;
	Tue, 23 Jun 2026 14:40:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MrwId4NB";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E01610EB2B;
 Tue, 23 Jun 2026 14:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782225640; x=1813761640;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=KhQTiBKWNVBTcu+d9INvXQUM6k5ChbdH5d70gcrKIXM=;
 b=MrwId4NBhqrMRa4iY4PZO1fKRRyJeQfCZU2D5Z7J8k85cAYBLsZ23VON
 ON0zFNGNuoMnwJWJ7Np/YUPYn+vZGQJ6HKnro6PGnhyx0fjhEHaKfNdip
 1S/l6Dmw1jb5BO0EuX4feFWQQR1yocUe2Gp6sLvTbt/i57HuASya5NR/5
 N2cOpAKO50Fky3PgVbDAlxjWiEI+OKBgz/bwfE/I+/NIlv7f7gQefjT9U
 zFohRqgBW+DNRsRQMPhSzUgd4GTrkTQaIKExA0wrakU7Y4JmGtQX9Czn6
 i2loC4OAfumn0p1oK8pR/OkGm1czNdXuOnHrP+w1rbpk0Lt1ddXSTNf/l A==;
X-CSE-ConnectionGUID: Z4ykT/qvS4qx5qOCwQ7gQQ==
X-CSE-MsgGUID: KkNO1oPASSaeDhBqD3XETQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82856838"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="82856838"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 07:40:39 -0700
X-CSE-ConnectionGUID: dt2jDttGQfCOIczSsp9h0w==
X-CSE-MsgGUID: /8QGS8soRpyo2Q+m8G5a6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="245165347"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 07:40:36 -0700
Date: Tue, 23 Jun 2026 16:40:33 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Riana Tauro <riana.tauro@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] drm/xe/i2c: alerts and controller enabling
 modifications
Message-ID: <ajqa4aWpj4fXkeHb@black.igk.intel.com>
References: <20260622114759.3464047-1-heikki.krogerus@linux.intel.com>
 <ajpcyS3s6hArVQy8@kuha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajpcyS3s6hArVQy8@kuha>
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

On Tue, Jun 23, 2026 at 01:15:37PM +0300, Heikki Krogerus wrote:
> Hi Raag,
> 
> I completely forgot the enum for the clients that you proposed
> off-list. Sorry about that. I'll add it in v2.

Yeah, definitely need a vacation :D

Raag
