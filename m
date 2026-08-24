Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91106C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:12:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E345710E05B;
	Mon, 24 Aug 2026 07:12:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ubwoodpx";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E22610E05B;
 Mon, 24 Aug 2026 07:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787555520; x=1819091520;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=3g4vIsQZw5ygNOhUx4SlSvCQanEhAqxPPlsPaexYsfc=;
 b=UbwoodpxQRlHy1xf4jw/fj935jEqeXmCdbjIiqM6wjSMlOOpXRwCfoj8
 W0Awm6pZKmNsNlm/2kpN3UjZWJ0odgU8wMLKehuSvEDB0Gou0opFM9X2d
 vi6rzHFhN1k/yqkhzIN3qTVyHH7zYvrKVV6Gj3gxFfhZl5IMOO6xWuGJt
 N2SSmQLzcphLiCpu0QazAews+C5KOcORbwMrLhhOwuhqZ0P9eu7Fvvkom
 vv4UQ7WT7iEDDR3bbXssviQCCZV9ch/a4YXwRrwsk6OXPlyGNuU4h9wVY
 vvr1C8CUJxSgacyIXDTuvCjwjhA8MTlxvWFr5So6FOjVTeiOfEC8E/ivn w==;
X-CSE-ConnectionGUID: g8wH7a6CSESOBLLat1PyqQ==
X-CSE-MsgGUID: fi40u6kGTE+kGiqiv9SCzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="87867570"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="87867570"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 00:11:59 -0700
X-CSE-ConnectionGUID: TAcZ9iCHRP2R0l2+vsTMoQ==
X-CSE-MsgGUID: e9U0go9SRf+KK0wnxDKVFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="266956435"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.205])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 00:11:57 -0700
Message-ID: <d9b01c373ddf8847fda460822f141b9e3cf30b6e.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/8] drm/i915/selftest: Fix a typo in alloc_workqueue
 call
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>, 
 intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Jani Nikula
 <jani.nikula@linux.intel.com>,  Andi Shyti <andi.shyti@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,  Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Date: Mon, 24 Aug 2026 09:11:56 +0200
In-Reply-To: <20260818095624.3254368-3-krzysztof.karas@intel.com>
References: <20260818095624.3254368-1-krzysztof.karas@intel.com>
 <20260818095624.3254368-3-krzysztof.karas@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
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

On Tue, 2026-08-18 at 09:56 +0000, Krzysztof Karas wrote:
> Replace "i1915-selftest" with "i915-selftest".
>=20
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>

Reviewed-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>

> ---
>  drivers/gpu/drm/i915/selftests/i915_sw_fence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c b/drivers/gpu=
/drm/i915/selftests/i915_sw_fence.c
> index 462704e575f5..b8dc30f81bf0 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
> @@ -528,7 +528,7 @@ static int test_ipc(void *arg)
>  	struct workqueue_struct *wq;
>  	int ret =3D 0;
> =20
> -	wq =3D alloc_workqueue("i1915-selftest", WQ_PERCPU, 0);
> +	wq =3D alloc_workqueue("i915-selftest", WQ_PERCPU, 0);
>  	if (wq =3D=3D NULL)
>  		return -ENOMEM;
> =20
