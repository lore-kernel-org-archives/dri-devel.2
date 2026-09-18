Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91985C982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D872C10E864;
	Fri, 18 Sep 2026 08:07:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EWz6X/fC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88FC110E4FC;
 Fri, 18 Sep 2026 08:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789718848; x=1821254848;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=zkCVM8vtfz9mwZhx1cFKKSSSnqLv9yu5+oUbCaj5ejc=;
 b=EWz6X/fC76sV5QrQn5UZaolpi2p4M8czLSGfRDih+PvMepU21iz3sA+6
 cr45MLPs247jkSTQjPk3M83AR/wyPYxBDqXZhwfOMA5GbJ6FogcnZYcBJ
 mj3u0Q3slgfVLoQe2Ac4KWQmXvm1FggJ3he1RkaNvx0xKUSMEPKC0zOge
 GjOv31hqiljjh9dRZRDKldZdrqT3YH0wQjbyNOmvwFaBHZ0+2Hr+7rPLe
 WUKVJ1SJ1xFBwX4q2mi6Hi+nwGLJIYhXMaUdYsBpzMDw2bx4GpKHaznku
 eu6nOUfW30oDHKMCYxKGqpGQyshrpAmPZQTjTdXi5TediE+SGczd5Mj5v A==;
X-CSE-ConnectionGUID: xEHKhhpxSl2QlOlsanPoow==
X-CSE-MsgGUID: 58V1NLJyTkmUkJLU9bcCpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100805400"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="100805400"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 01:07:27 -0700
X-CSE-ConnectionGUID: 6VOz6MEcROaJ6nxBvGvFIg==
X-CSE-MsgGUID: NjIiFybCR7mbJujaf/1hcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2506439"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.245.216])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 01:07:24 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Zhenyu
 Wang <zhenyuw.linux@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, "open list:DRM DRIVERS"
 <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Cc: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Subject: Re: [PATCH] drm/i915: use string choice helpers
In-Reply-To: <20260918042325.17700-1-lalitshankarch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260918042325.17700-1-lalitshankarch@gmail.com>
Date: Fri, 18 Sep 2026 11:07:21 +0300
Message-ID: <b5576d0e503315036500145888d712e75df42f7e@intel.com>
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

On Fri, 18 Sep 2026, Lalit Shankar Chowdhury <lalitshankarch@gmail.com> wro=
te:
> Prefer the str_high_low() and str_read_write() helper functions
> over ternary operators with hardcoded strings.
>
> No functional changes.
>
> Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/i915/display/intel_cx0_phy.c | 5 +++--
>  drivers/gpu/drm/i915/gvt/aperture_gm.c       | 4 +++-
>  drivers/gpu/drm/i915/vlv_iosf_sb.c           | 6 ++++--
>  3 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_cx0_phy.c b/drivers/gpu/d=
rm/i915/display/intel_cx0_phy.c
> index dbebd7210848..b83f0afaa9b5 100644
> --- a/drivers/gpu/drm/i915/display/intel_cx0_phy.c
> +++ b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
> @@ -5,6 +5,7 @@
>=20=20
>  #include <linux/log2.h>
>  #include <linux/math64.h>
> +#include <linux/string_choices.h>
>=20=20
>  #include <drm/drm_print.h>
>=20=20
> @@ -189,7 +190,7 @@ int intel_cx0_wait_for_ack(struct intel_encoder *enco=
der,
>  		drm_dbg_kms(display->drm,
>  			    "PHY %c Error occurred during %s command. Status: 0x%x\n",
>  			    phy_name(phy),
> -			    command =3D=3D XELPDP_PORT_P2M_COMMAND_READ_ACK ? "read" : "write=
", *val);
> +			    str_read_write(command =3D=3D XELPDP_PORT_P2M_COMMAND_READ_ACK), =
*val);
>  		intel_cx0_bus_reset(encoder, lane);
>  		return -EINVAL;
>  	}
> @@ -198,7 +199,7 @@ int intel_cx0_wait_for_ack(struct intel_encoder *enco=
der,
>  		drm_dbg_kms(display->drm,
>  			    "PHY %c Not a %s response. MSGBUS Status: 0x%x.\n",
>  			    phy_name(phy),
> -			    command =3D=3D XELPDP_PORT_P2M_COMMAND_READ_ACK ? "read" : "write=
", *val);
> +			    str_read_write(command =3D=3D XELPDP_PORT_P2M_COMMAND_READ_ACK), =
*val);
>  		intel_cx0_bus_reset(encoder, lane);
>  		return -EINVAL;
>  	}
> diff --git a/drivers/gpu/drm/i915/gvt/aperture_gm.c b/drivers/gpu/drm/i91=
5/gvt/aperture_gm.c
> index 253b41789be9..794fb50e48dd 100644
> --- a/drivers/gpu/drm/i915/gvt/aperture_gm.c
> +++ b/drivers/gpu/drm/i915/gvt/aperture_gm.c
> @@ -34,6 +34,8 @@
>   *
>   */
>=20=20
> +#include <linux/string_choices.h>
> +
>  #include <drm/drm_print.h>
>=20=20
>  #include "gt/intel_ggtt_fencing.h"
> @@ -76,7 +78,7 @@ static int alloc_gm(struct intel_vgpu *vgpu, bool high_=
gm)
>  	mutex_unlock(&gt->ggtt->vm.mutex);
>  	if (ret)
>  		gvt_err("fail to alloc %s gm space from host\n",
> -			high_gm ? "high" : "low");
> +			str_high_low(high_gm));
>=20=20
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/i915/vlv_iosf_sb.c b/drivers/gpu/drm/i915/vl=
v_iosf_sb.c
> index 1f0332b4ad0d..fede1735bc08 100644
> --- a/drivers/gpu/drm/i915/vlv_iosf_sb.c
> +++ b/drivers/gpu/drm/i915/vlv_iosf_sb.c
> @@ -3,6 +3,8 @@
>   * Copyright =C2=A9 2013-2021 Intel Corporation
>   */
>=20=20
> +#include <linux/string_choices.h>
> +
>  #include <drm/drm_print.h>
>  #include <drm/intel/display_parent_interface.h>
>=20=20
> @@ -101,7 +103,7 @@ static int vlv_sideband_rw(struct drm_i915_private *i=
915,
>  				    VLV_IOSF_DOORBELL_REQ, IOSF_SB_BUSY, 0,
>  				    5)) {
>  		drm_dbg(&i915->drm, "IOSF sideband idle wait (%s) timed out\n",
> -			is_read ? "read" : "write");
> +			str_read_write(is_read));
>  		return -EAGAIN;
>  	}
>=20=20
> @@ -125,7 +127,7 @@ static int vlv_sideband_rw(struct drm_i915_private *i=
915,
>  		err =3D 0;
>  	} else {
>  		drm_dbg(&i915->drm, "IOSF sideband finish wait (%s) timed out\n",
> -			is_read ? "read" : "write");
> +			str_read_write(is_read));
>  		err =3D -ETIMEDOUT;
>  	}

--=20
Jani Nikula, Intel
