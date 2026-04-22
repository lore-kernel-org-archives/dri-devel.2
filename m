Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E82BF55811
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFC0C10E81D;
	Wed, 22 Apr 2026 08:23:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OywMjXys";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2802110E81D;
 Wed, 22 Apr 2026 08:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776846181; x=1808382181;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=7YPq3iXWyvY3q3RAI4OP3pjosMRauV0NX4lrhVbDRVQ=;
 b=OywMjXysBMOR/wltKwoa75e2EsW9IR71gKvFf8lxjNVPLwCiZXXFihjr
 xOdhiN+so37RpaYHv2GSrz3hgGsC9BP8WBQCiEpf8djm8pvS9m+gRCKg/
 JQFk7cczaIEfwpu1RsDjxYKnwGTINStKkqP5uzQhRupz14wnWJ/PU8Es+
 yTpV/F+tU2QTseaFDd4WhVJsPZcUFD6StJbc2NRkiW8wrrwSGlUT5tmY5
 HBNu4+hyVM4dEMJWqB4S5HKUj7ik89GN6HFRpP0XhqtYBnnV5LX6hbpdh
 tYkhyBM9JUtvZ91th47mR4gAuVENjiYN4EBYPPkxq1XzzzdDb93hFL+FC A==;
X-CSE-ConnectionGUID: lNUqGIB5Qu+Kv8MVJE/xsw==
X-CSE-MsgGUID: Q49lDH4WT0aJOdI/M9UwIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="81659620"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="81659620"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 01:23:01 -0700
X-CSE-ConnectionGUID: 0qNZXcWqRZ2Nmd1Q4ihaaA==
X-CSE-MsgGUID: pd2hO6gQScSnj06V8aT4sA==
X-ExtLoop1: 1
Received: from abityuts-desk.ger.corp.intel.com (HELO [10.245.245.239])
 ([10.245.245.239])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 01:22:59 -0700
Message-ID: <432e5ce12ab767bc88b2a0cec49de4fc48694b24.camel@linux.intel.com>
Subject: Re: [PATCH 3/3] drm/xe: Avoid shrinker reclaim from kswapd under
 fragmentation
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Carlos Santa <carlos.santa@intel.com>, Matthew Auld
 <matthew.auld@intel.com>
Date: Wed, 22 Apr 2026 10:22:56 +0200
In-Reply-To: <20260421012608.1474950-4-matthew.brost@intel.com>
References: <20260421012608.1474950-1-matthew.brost@intel.com>
 <20260421012608.1474950-4-matthew.brost@intel.com>
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

On Mon, 2026-04-20 at 18:26 -0700, Matthew Brost wrote:
> When the Xe shrinker is invoked from kswapd, a large amount of free
> memory in ZONE_NORMAL relative to the high watermark is a strong
> signal
> that reclaim is being driven by fragmentation rather than true memory
> pressure.
>=20
> In this case, shrinking Xe memory is unlikely to help kswapd make
> forward progress. Instead it can evict active GPU memory despite the
> system still having substantial free memory, increasing residency
> churn
> and reducing GPU forward progress.
>=20
> Detect this case and bail out early from the Xe shrinker when running
> in
> kswapd and ZONE_NORMAL has more than 2x its high watermark free.
>=20
> Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Cc: Carlos Santa <carlos.santa@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> ---
> =C2=A0drivers/gpu/drm/xe/xe_shrinker.c | 13 +++++++++++++
> =C2=A01 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_shrinker.c
> b/drivers/gpu/drm/xe/xe_shrinker.c
> index 83374cd57660..e56afde83de6 100644
> --- a/drivers/gpu/drm/xe/xe_shrinker.c
> +++ b/drivers/gpu/drm/xe/xe_shrinker.c
> @@ -236,6 +236,19 @@ static unsigned long xe_shrinker_scan(struct
> shrinker *shrink, struct shrink_con
> =C2=A0	if (nr_scanned >=3D nr_to_scan || !can_backup)
> =C2=A0		goto out;
> =C2=A0
> +	if (current_is_kswapd()) {
> +		struct zone *zone =3D &NODE_DATA(sc->nid)-
> >node_zones[ZONE_NORMAL];
> +		unsigned long free_pages =3D zone_page_state(zone,
> NR_FREE_PAGES);
> +		unsigned long high_wmark =3D high_wmark_pages(zone);
> +
> +		/*
> +		 * If we have 2x the high watermark free, this is
> definitely
> +		 * fragmentation
> +		 */
> +		if (free_pages > (high_wmark * 2))
> +			goto out;
> +	}
> +

While this or a similar check might make sense, That should ideally be
in the TTM shrinker helpers. And probably we should ask core mm for a
proper indication whether this is indeed fragmentation-driven.

Thanks,
Thomas



> =C2=A0	/* If we didn't wake before, try to do it now if needed. */
> =C2=A0	if (!runtime_pm)
> =C2=A0		runtime_pm =3D xe_shrinker_runtime_pm_get(shrinker,
> true, 0, can_backup);
