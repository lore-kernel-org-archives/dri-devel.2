Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696F4C44500
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:20:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A87DC10E45B;
	Tue,  7 Jul 2026 07:20:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FZMQ+o7h";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A656010EB7D;
 Tue,  7 Jul 2026 07:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783408842; x=1814944842;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=oCzQj6mzYMWn7iqnEq+ZWs0O8xxcgsd/5YisJkPeUmU=;
 b=FZMQ+o7h7zIsXFtKxR5+vVjIipBXrHDg5mCB20UNtp1x7ZxdHacLw9mA
 uysrDzv/FEjnNwOoYBFlnGt7pxSFNza4TIYN6pQunaeLP9Zvad+fg8Gdo
 zbpwVTt0cacGBqonvMAdjhy1dLakyCaSrMT3h21g4Sw2xmSOFoWGfEFmP
 jnWzyPDXTwaFEWoPJ/JhcDSiOLlXyG7DaY42dfnOJrwBiqZKVb5bLdU3Q
 1VZ6C1wq8SXFz765SoxziscxzknWysfSfBwFcMXe5kGpCiDBCQ0pscGer
 SNHK4WDydBzb/dG6ZkCHusKCRNwSdBAoOjSpzAlKs9xkje/8OXALIrDb4 A==;
X-CSE-ConnectionGUID: lC4+XuvtR1emOY20367+7g==
X-CSE-MsgGUID: m5ZTq0GZQGuXceWOSMkVKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="87962850"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="87962850"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 00:20:42 -0700
X-CSE-ConnectionGUID: A4GgYyZLTeC5yKEPCVStcA==
X-CSE-MsgGUID: 0oqI3gtaRSmRaXZoccMrKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="250570814"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.199])
 ([10.245.244.199])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 00:20:37 -0700
Message-ID: <67ffc76ee6d1aa4e9ef5f4c393304914359eeaab.camel@linux.intel.com>
Subject: Re: [PATCH v7 3/6] cgroup/dmem: Add reclaim callback for lowering
 max below current usage
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: intel-xe@lists.freedesktop.org, Natalie Vock <natalie.vock@gmx.de>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal =?ISO-8859-1?Q?Koutn=FD?=
 <mkoutny@suse.com>, 	cgroups@vger.kernel.org, Huang Rui
 <ray.huang@amd.com>, Matthew Brost	 <matthew.brost@intel.com>, Matthew Auld
 <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann	 <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 David Airlie	 <airlied@gmail.com>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Thadeu Lima de Souza Cascardo
 <cascardo@igalia.com>,  Alex Deucher <alexander.deucher@amd.com>, Rodrigo
 Vivi <rodrigo.vivi@intel.com>, 	dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, 	linux-kernel@vger.kernel.org
Date: Tue, 07 Jul 2026 09:20:35 +0200
In-Reply-To: <akwBFlw8MwhrwsRu@slm.duckdns.org>
References: <20260703130541.2686-1-thomas.hellstrom@linux.intel.com>
 <20260703130541.2686-4-thomas.hellstrom@linux.intel.com>
 <akwBFlw8MwhrwsRu@slm.duckdns.org>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
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

Hi,

On Mon, 2026-07-06 at 09:25 -1000, Tejun Heo wrote:
> Hello,
>=20
> On Fri, Jul 03, 2026 at 03:05:38PM +0200, Thomas Hellstr=C3=B6m wrote:
> > Also honor O_NONBLOCK so that if that flag is set during the
> > max value write, no reclaim is initiated. The idea is to avoid
> > charging the reclaim cost to the writer of the max value.
>=20
> Is this really necessary? I'm not necessarily against it but this is
> trivial
> to work around from userspace and feels like a gratuitous addition.
> What's
> the use case?

This was something that was added at the request of Maarten. The idea
is to mimic the memcg behaviour. For memcg, the use-case was to avoid
having the reclaim cost (I assume in terms of cpu time) land on the
next allocator instead of the process writing the new max value.

I think there are more details in the memcg commit history, but the
presence here is solely to mimic memcg WRT this.

Thanks,
Thomas=20

>=20
> Thanks.
