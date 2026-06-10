Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3ADACD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 113F210E623;
	Wed, 10 Jun 2026 12:49:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="a6S8lBQQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F12F110E623
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 12:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781095789; x=1812631789;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=HTJjdgTLFSuJq2fjGDwVqpMvF/WetTpLlhj+xxFwY5o=;
 b=a6S8lBQQl5xnnHcKpUqEmJ5tdRz1tDzHjJWYiWcvNIxaJjfMf5Mj4Czx
 4jenUTICdeA1iiOm9kvzlkCzELAQMktSGDsnqpcbtrV9MYUTO3l6+ufzg
 SRYpmiv8YSuLIRf9HKljY0S6f1N6VuoTrciBiz7xFQKL9iyT2hLb2TAWR
 mjHHGzpJVYXt38jyz/TPxsaeEYjhG3FZCJ9xh65TDjfvKSdimZMPtVgZW
 crabagFIBGHJeKaNOUKMjQjp7KY/CaQZC1i1ITu3lNyv1vjHuU7cbnibL
 Pl71KiKcM9C46L+S/10UARVtsiy1Ksd80vWuEj6rWRXq/2JDf35ftXltH g==;
X-CSE-ConnectionGUID: Z+yFOXKrT7el5lqTaVJBiw==
X-CSE-MsgGUID: IrzSUkRaRiKaNM4HJSyHdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81627559"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="81627559"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 05:49:48 -0700
X-CSE-ConnectionGUID: LoI90bOhSDas4fBrr+x0lQ==
X-CSE-MsgGUID: dwjwVl8EQz6lOJeaQQIXfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="250093316"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost)
 ([10.245.244.3])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 05:49:45 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Xiang Mei <xmei5@asu.edu>, dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 bestswngs@gmail.com, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH] drm/edid: fix OOB read in drm_parse_tiled_block()
In-Reply-To: <20260609064038.2799482-1-xmei5@asu.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260609064038.2799482-1-xmei5@asu.edu>
Date: Wed, 10 Jun 2026 15:49:41 +0300
Message-ID: <4e784cad86c91595b6d5da64ca854dab38357658@intel.com>
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

On Mon, 08 Jun 2026, Xiang Mei <xmei5@asu.edu> wrote:
> drm_parse_tiled_block() casts the DisplayID block to a
> struct displayid_tiled_block and reads the full fixed layout up to
> tile->topology_id[7] without checking block->num_bytes. The DisplayID
> iterator only validates the declared payload length, so a crafted EDID
> can advertise a tiled-display block (tag DATA_BLOCK_TILED_DISPLAY, or
> DATA_BLOCK_2_TILED_DISPLAY_TOPOLOGY for v2.0) with a small num_bytes at
> the end of a DisplayID extension. The read then runs past the end of the
> exact-sized kmemdup()'d EDID allocation, a heap out-of-bounds read.
>
> Add a minimum-length check, as drm_parse_vesa_mso_data() already does.
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
> ---
>  drivers/gpu/drm/drm_edid.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 404208bf23a6..92054ac82fe2 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -7575,6 +7575,13 @@ static void drm_parse_tiled_block(struct drm_connector *connector,
>  	u8 num_v_tile, num_h_tile;
>  	struct drm_tile_group *tg;
>  
> +	if (block->num_bytes < sizeof(*tile) - sizeof(*block)) {

I'd prefer using fixed values here. If the tiled display topology data
block is ever expanded, we'll need to have them anyway.

This should be if (block->num_bytes < 22).

And reviewing this, I realize struct displayid_tiled_block definition is
actually only 21 bytes. The topology_id member is 8 bytes, while it
consists of

- Tiled Display Manufacturer/Vendor ID Field (3 bytes)
- Tiled Display Product ID Code Field (2 bytes)
- Tiled Display Serial Number Field (4 bytes)

i.e. total of 9 bytes.

BR,
Jani.


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
