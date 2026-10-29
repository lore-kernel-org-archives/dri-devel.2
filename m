Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E28606A31F
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 12:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KZGWNpnM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAAEA112237;
	Thu, 29 Oct 2026 12:07:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D982112237;
 Thu, 29 Oct 2026 12:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793275663; x=1824811663;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=haNvBN+6I0qZH/hq50Aelh358H+KYj4WGO/+qKvSpSM=;
 b=KZGWNpnMmzmDbcxDmvpaKhC6MkOOWRUeOSdG27qlJ3lNLA/Hw56tQa4g
 FKOKvKkRGPoncZ3GaIbRVm/WAnle2bYa2ex1qwUXe59db8ZdrB/2JCu9l
 XbqVi0Frk3FgrvFpVC6jEbKyTknnQdx+/b2YM6nJL4vEXBYM/JPbr+FZh
 u7Z3Vs3uSp8NArJerqUG4zFMw5p55Nt/JuVdg3R4ASWsEm7AOXAbsaZOf
 3gkNn3Qad7BKa/5JqAPE8ubtLllle6epsSL5TIuhUgc7uzgGN3WBO86xa
 Ox21IzpFX7uWsobeH9g7TgbLqSbcH1hBSxSbsv3ADbne5hN/efHomZYpE w==;
X-CSE-ConnectionGUID: YrrpvMWiSDaL7vPPB1jk8A==
X-CSE-MsgGUID: kLmZ+mczRvWPWcPXxEw8yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2040620"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2040620"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 05:07:43 -0700
X-CSE-ConnectionGUID: 9dIB48gXSJ+jv+6S2SeEtA==
X-CSE-MsgGUID: fWa0pj25QlCDM7z+ywO4cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5060783"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.145])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 05:07:36 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Dmytro Malovanyi <dmitrymalovanyy@gmail.com>,
 dri-devel@lists.freedesktop.org
Cc: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Maarten
 Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Patrik Jakobsson
 <patrik.r.jakobsson@gmail.com>, Lyude Paul <lyude@redhat.com>, Danilo
 Krummrich <dakr@kernel.org>, nouveau@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, Dmytro
 Malovanyi <dmitrymalovanyy@gmail.com>
Subject: Re: [PATCH v2 5/5] drm/nouveau: Use enhanced framing for DPCD r1.2+
In-Reply-To: <20261029101826.72773-6-dmitrymalovanyy@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261029101826.72773-1-dmitrymalovanyy@gmail.com>
 <20261029101826.72773-6-dmitrymalovanyy@gmail.com>
Date: Thu, 29 Oct 2026 14:07:32 +0200
Message-ID: <566f5d1c9623a86589c2c28cb83434433e0de1d8@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026, Dmytro Malovanyi <dmitrymalovanyy@gmail.com> wrote:
> nv50_sor_dp_watermark_sst() checks DP_ENHANCED_FRAME_CAP for the
> watermark calculation, but the actual enhanced framing enable is
> decided in nvkm, in nvkm_dp_train(), nvkm_uoutp_mthd_dp_sst() and
> r535_dp_train_target(), with its own copy of the check. Convert all of
> them so they keep agreeing with each other.
>
> dispnv50 uses drm_dp_enhanced_frame_cap(). nvkm does not include the
> drm helpers, so add nvkm_dp_enhanced_frame_cap() with the same rule.

Seems reasonable to me, but up to the nouveau maintainers.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> Compile tested only, I don't have nvidia hardware.
>
> Signed-off-by: Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/disp.c               |  2 +-
>  drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c         |  2 +-
>  drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.h         | 11 +++++++++++
>  drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c      |  2 +-
>  .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c    |  2 +-
>  5 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index e91130f93..f965d4811 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1607,7 +1607,7 @@ static bool
>  nv50_sor_dp_watermark_sst(struct nouveau_encoder *outp,
>  			  struct nv50_head *head, struct nv50_head_atom *asyh)
>  {
> -	bool enhancedFraming = outp->dp.dpcd[DP_MAX_LANE_COUNT] & DP_ENHANCED_FRAME_CAP;
> +	bool enhancedFraming = drm_dp_enhanced_frame_cap(outp->dp.dpcd);
>  	u64 minRate = outp->dp.link_bw * 1000;
>  	unsigned tuSize = 64;
>  	unsigned waterMark;
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c
> index a109348bd..fbd9935f4 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c
> @@ -509,7 +509,7 @@ nvkm_dp_train(struct nvkm_outp *outp, bool retrain)
>  	OUTP_DBG(outp, "training");
>  
>  	ior->dp.mst = outp->dp.lt.mst;
> -	ior->dp.ef = outp->dp.dpcd[DPCD_RC02] & DPCD_RC02_ENHANCED_FRAME_CAP;
> +	ior->dp.ef = nvkm_dp_enhanced_frame_cap(outp->dp.dpcd);
>  	ior->dp.bw = outp->dp.lt.bw;
>  	ior->dp.nr = outp->dp.lt.nr;
>  
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.h b/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.h
> index 9a6be4391..e56acc162 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.h
> @@ -23,6 +23,17 @@ void nvkm_dp_enable(struct nvkm_outp *, bool auxpwr);
>  #define DPCD_RC10_SUPPORTED_LINK_RATES(i)                               0x00010
>  #define DPCD_RC10_SUPPORTED_LINK_RATES__SIZE                                 16
>  
> +/* Same rule as drm_dp_enhanced_frame_cap() */
> +static inline bool
> +nvkm_dp_enhanced_frame_cap(const u8 *dpcd)
> +{
> +	if (dpcd[DPCD_RC00_DPCD_REV] >= 0x12)
> +		return true;
> +
> +	return dpcd[DPCD_RC00_DPCD_REV] >= 0x11 &&
> +	       (dpcd[DPCD_RC02] & DPCD_RC02_ENHANCED_FRAME_CAP);
> +}
> +
>  /* DPCD Link Configuration */
>  #define DPCD_LC00_LINK_BW_SET                                           0x00100
>  #define DPCD_LC01                                                       0x00101
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> index 377d0e0ce..b0158fc30 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> @@ -87,7 +87,7 @@ nvkm_uoutp_mthd_dp_sst(struct nvkm_outp *outp, void *argv, u32 argc)
>  		return 0;
>  
>  	return ior->func->dp->sst(ior, args->v0.head,
> -				  outp->dp.dpcd[DPCD_RC02] & DPCD_RC02_ENHANCED_FRAME_CAP,
> +				  nvkm_dp_enhanced_frame_cap(outp->dp.dpcd),
>  				  args->v0.watermark, args->v0.hblanksym, args->v0.vblanksym);
>  }
>  
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> index f5f22173f..c62900320 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> @@ -972,7 +972,7 @@ r535_dp_train_target(struct nvkm_outp *outp, u8 target, bool mst, u8 link_nr, u8
>  	if (mst)
>  		cmd |= NVDEF(NV0073_CTRL, DP_CMD, SET_FORMAT_MODE, MULTI_STREAM);
>  
> -	if (outp->dp.dpcd[DPCD_RC02] & DPCD_RC02_ENHANCED_FRAME_CAP)
> +	if (nvkm_dp_enhanced_frame_cap(outp->dp.dpcd))
>  		cmd |= NVDEF(NV0073_CTRL, DP_CMD, SET_ENHANCED_FRAMING, TRUE);
>  
>  	if (target == 0 &&

-- 
Jani Nikula, Intel
