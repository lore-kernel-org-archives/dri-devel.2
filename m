Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F75C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:40:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 873DB10E272;
	Mon, 31 Aug 2026 06:40:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="D14GZ/Lu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3C6410E625;
 Mon, 31 Aug 2026 06:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788158405; x=1819694405;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=DDBqC2+qvM8/AKR78Ix9rvugnY9ok50Qs3a+h1pYWwc=;
 b=D14GZ/LuRHD2Vb03PUrIzBo3ivt4+jInUmSgD0zyH1CqJUfMX54rett3
 o5e8z+Z9L2ZtLNhw1WAVH5+pnSTGo7awdPOFtCS6n0oFqdBSfagxwMGHU
 R5KFz0F8d7c1fckS8VlBMPiAO0wD7wS4QrRUbOgcoYOeFf2Xpmp/50tWx
 NG7fDGUShZZL/UzJ4TDAW5j5biwJAbH95B0gIc76ivxnIj+YZkaBb+9kW
 UONpg182qHelf62p93y3MBbwpTSzlDqTXlhnRX/jF+Wf0Puj50jXPX+Jv
 Ek8Qed++bK19+2kFYB6bzeicHAVt14Fj1wm09aoUFW04xHoKpTzXmJ/iA A==;
X-CSE-ConnectionGUID: 58iQ71URTJKdBK6Wof+Vyw==
X-CSE-MsgGUID: UQHh1cP5T2CVlRcWZFcHvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="87688734"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="87688734"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 23:40:04 -0700
X-CSE-ConnectionGUID: VE1P2hIYR16HOFGVra4u0Q==
X-CSE-MsgGUID: iSgmEIr+SBCrSHUgJHz1iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="269291904"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.31])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 23:40:01 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260823205028.178597-2-thorsten.blum@linux.dev>
References: <20260823205028.178597-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] drm/i915: Fix memory leak in query_perf_config_list()
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
To: Chris Wilson <chris@chris-wilson.co.uk>, David Airlie <airlied@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>,
 Thorsten Blum <thorsten.blum@linux.dev>, Tvrtko Ursulin <tursulin@ursulin.net>
Date: Mon, 31 Aug 2026 09:39:58 +0300
Message-ID: <178815839811.55476.6042238739250760944@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620
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

Quoting Thorsten Blum (2026-08-23 23:50:28)
> When krealloc() fails, free the original oa_config_ids before returning
> to avoid a memory leak.
>=20
> Fixes: 4f6ccc74a85c ("drm/i915: add support for perf configuration querie=
s")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/gpu/drm/i915/i915_query.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/i915_query.c b/drivers/gpu/drm/i915/i91=
5_query.c
> index 0c55fb6e9727..11157fb14db3 100644
> --- a/drivers/gpu/drm/i915/i915_query.c
> +++ b/drivers/gpu/drm/i915/i915_query.c
> @@ -403,8 +403,10 @@ static int query_perf_config_list(struct drm_i915_pr=
ivate *i915,
>                 ids =3D krealloc(oa_config_ids,
>                                n_configs * sizeof(*oa_config_ids),
>                                GFP_KERNEL);
> -               if (!ids)
> +               if (!ids) {
> +                       kfree(oa_config_ids);
>                         return -ENOMEM;

Instead of duplicating the code once more, could we just refactor into
"goto err_ids;" style to clean up the function?

Regards, Joonas
