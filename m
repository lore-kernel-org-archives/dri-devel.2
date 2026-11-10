Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E54B606A32E
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W4W3Ie/Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7029E10E92E;
	Tue, 10 Nov 2026 12:02:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D60D10E92E;
 Tue, 10 Nov 2026 12:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794312173; x=1825848173;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HhAUpNuzDozuVjdF12LqWeLLpGws7iUzN3G4eEtCwpk=;
 b=W4W3Ie/ZTOhfDceUYt/hfGTR9WEnF3IxHLCZROpY0nzYhYadsW0UBL22
 FJZMVpnqdZGL8YulX+F93KbHjrzM0s/dQsXWktfqmBAOydBOizj03Shz0
 9+Ie+4gytcOFmzh/2qWXKB378vCqnsZJ2L6c8fUe9wL2ku/aYTiN4ELGK
 BCDYqpcE2F6Y/KHOrN0HuBWMTjMotGO/WonZQ1GoY+BZOzx+CG7Zx7W2s
 9jXxNH6dBpXb9afRxeScTYil3WsLKsFToTPsO0FkrN0G14Ms5zENofq88
 kEW3RQdQ5mGJBD16qMeNgQWfPZQYX6+3mMA6mCRpAiSQ+gPpmuRV/Rhph Q==;
X-CSE-ConnectionGUID: ez5JUFkETcGzr1sYwGdvZA==
X-CSE-MsgGUID: jlWoQf7LSY25ZGGnPoplbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3156165"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3156165"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 04:02:53 -0800
X-CSE-ConnectionGUID: ZqmuHCDMTKyLwUC/7lBmqg==
X-CSE-MsgGUID: A8Fj9ojISPexeUfkUXUf7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8174905"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com)
 ([10.245.245.11])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 04:02:48 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
 by kekkonen.fi.intel.com (Postfix) with SMTP id 0CCB6121B7B;
 Tue, 10 Nov 2026 14:02:46 +0200 (EET)
Date: Tue, 10 Nov 2026 14:02:46 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Seifelden Abdelmonem <saif.elden.hatim@gmail.com>
Cc: Mario Limonciello <superm1@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, Hans de Goede <hansg@kernel.org>,
 Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bin Du <bin.du@amd.com>, Nirujogi Pratap <pratap.nirujogi@amd.com>,
 Benjamin Chan <benjamin.chan@amd.com>, King Li <King.Li@amd.com>,
 Caspar Adriani <caspar.adriani@proton.me>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Arec Kao <arec.kao@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] platform/x86: amd_isp4: add the OV13B10
 (OMNI13B1) board configuration
Message-ID: <avMH5glolytc9L86@kekkonen.localdomain>
References: <20261103155313.114347-1-saif.elden.hatim@gmail.com>
 <20261103155313.114347-3-saif.elden.hatim@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103155313.114347-3-saif.elden.hatim@gmail.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Seifelden,

Thanks for the set.

On Tue, Nov 03, 2026 at 06:53:12PM +0300, Seifelden Abdelmonem wrote:
> +#define AMDISP_OV13B10_HID		"OMNI13B1"

Any idea who allocates these HIDs? Omnivision ACPI ID prefix is "OVTI" and
"OMNI" is indeed unallocated. I presume these HIDs have been "allocated" by
AMD? This is not the first time something like this happens but it would be
good to avoid it from happening in the future.

-- 
Regards,

Sakari Ailus
