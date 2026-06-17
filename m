Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07AD5CD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 12:44:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FF2489FA7;
	Wed, 17 Jun 2026 12:44:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CotOQbcu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AA8289FA7
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 12:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781700260; x=1813236260;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=iOTX/eTaYU9t8vwPSQruscg0vqU1dObtme0Ohj4Pa+g=;
 b=CotOQbcuwL6Qw3iSdgBsXIew6ezM4yaluILgr/M8ju3gtTc1DpKOxSfx
 ZkBzwG7vM1q8E/iUJ0BOEUUQEvQcOlSIf/NhbLLDj4Wds+Z09Z19goZVK
 7o+VB4DYb/som4sgPqJ2jPIF7zAFl1iDI1TOiaJ6exXnTpfoR2rqxyXsE
 NHWzt++LipCnu3qzG88Ass3xQ7k5JxIgtfFGFz8fhoGn1suXjhB8c6zPk
 HIucf+4bf1qzaNht70e6jZpURwmtNCiBeq8Qmr+en6ZgTKF+JamRPWd+y
 EPTf+a2SF7R7zfAmg8WHFa+ZB1qnQzIBjFOw+maHXD8w1m5cm2Ah31OEc w==;
X-CSE-ConnectionGUID: nRvQen8pQ0qH/li1M9CGmA==
X-CSE-MsgGUID: 49om9mi0TjWgrjXMcbkW2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="86332094"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="86332094"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 05:44:20 -0700
X-CSE-ConnectionGUID: 7NSiGOqTSYCgBM3cNuumzA==
X-CSE-MsgGUID: CVKFtSpERXObIH8GbTCaNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="249962456"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.158])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 05:44:17 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Xiang Mei <xmei5@asu.edu>, dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 bestswngs@gmail.com, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH v2] drm/edid: fix OOB read in drm_parse_tiled_block()
In-Reply-To: <20260615184737.899892-1-xmei5@asu.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260615184737.899892-1-xmei5@asu.edu>
Date: Wed, 17 Jun 2026 15:44:14 +0300
Message-ID: <d7fdf98414e1f0386eb4acee2600b92f1ab66053@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, 15 Jun 2026, Xiang Mei <xmei5@asu.edu> wrote:
> drm_parse_tiled_block() casts the DisplayID block to a
> struct displayid_tiled_block and reads the full fixed layout up to
> tile->topology_id[7] without checking block->num_bytes. The DisplayID
> iterator only validates the declared payload length, so a crafted EDID
> can advertise a tiled-display block (tag DATA_BLOCK_TILED_DISPLAY, or
> DATA_BLOCK_2_TILED_DISPLAY_TOPOLOGY for v2.0) with a small num_bytes at
> the end of a DisplayID extension. The read then runs past the end of the
> exact-sized kmemdup()'d EDID allocation, a heap out-of-bounds read.
>
> Reject blocks shorter than the spec's 22-byte tiled payload before
> reading the fixed struct, as drm_parse_vesa_mso_data() already does.
>
>   BUG: KASAN: slab-out-of-bounds in drm_edid_connector_update
>   Read of size 2 at addr ffff888010077700 by task exploit/147
>    dump_stack_lvl (lib/dump_stack.c:94 ...)
>    print_report (mm/kasan/report.c:378 ...)
>    kasan_report (mm/kasan/report.c:595)
>    drm_edid_connector_update (drivers/gpu/drm/drm_edid.c:7581)
>    bochs_connector_helper_get_modes (drivers/gpu/drm/tiny/bochs.c:574)
>    drm_helper_probe_single_connector_modes (drivers/gpu/drm/drm_probe_helper.c:426)
>    status_store (drivers/gpu/drm/drm_sysfs.c:219)
>    ...
>    vfs_write (fs/read_write.c:595 fs/read_write.c:688)
>    ksys_write (fs/read_write.c:740)
>
> Fixes: 40d9b043a89e ("drm/connector: store tile information from displayid (v3)")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
> v2: use 22 instead of sizeof, based on the topology_id[9] fix:
> https://lore.kernel.org/r/20260610141549.555605-1-jani.nikula@intel.com
>
>  drivers/gpu/drm/drm_edid.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 404208bf23a6..df3c25bac761 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -7575,6 +7575,14 @@ static void drm_parse_tiled_block(struct drm_connector *connector,
>  	u8 num_v_tile, num_h_tile;
>  	struct drm_tile_group *tg;
>  
> +	/* tiled block payload per spec: cap 1 + topo 3 + size 4 + bezel 5 + id 9 = 22 */
> +	if (block->num_bytes < 22) {
> +		drm_dbg_kms(connector->dev,
> +			    "[CONNECTOR:%d:%s] Unexpected tiled block size %u\n",
> +			    connector->base.id, connector->name, block->num_bytes);
> +		return;
> +	}
> +
>  	w = tile->tile_size[0] | tile->tile_size[1] << 8;
>  	h = tile->tile_size[2] | tile->tile_size[3] << 8;

-- 
Jani Nikula, Intel
