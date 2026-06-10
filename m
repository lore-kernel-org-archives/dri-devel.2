Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5E8CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B83E10E4A8;
	Wed, 10 Jun 2026 14:45:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="krCm0IZj";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AAFD10E637
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 14:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781102751; x=1812638751;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=tkOzyDdrsQBrIpjjWDbFuiQH0jDBEtUyXu5Q0Kdtqbg=;
 b=krCm0IZjlAxUIXtAYc/MNz8jY57+dHscX1jQcozHzacZljGTNQYyXUDz
 +w/gJAVKP81X6YZz2ogr2gJFYZG6Hi53S6VYqQ4Q+eYBlolMrIT7gn+mP
 yTSFywFf9Oj4u2mM1+wZ/VkrU4/b9qd1051Zp0tIktUb0oSVRPfVZH23W
 /BVx9D2rk74vN0SIRKo0MRlOou95/EZVB5VnRDmok2wveL09BO+NKsuNf
 gLlIw7vqPDubDhJOAto8bM7zh45CQHemMMP3f8OnM7jNtVGBjeFzRDavH
 nMKUb/K3uoE2TL5i7PinsghwuGaBnDfwGCptkP34/96b0zJgjZYU+Hafc g==;
X-CSE-ConnectionGUID: +NM2PjPJTCSrFXx36Yz1dw==
X-CSE-MsgGUID: 3JEFEKeFTqy/NKTxb/CmDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81027985"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="81027985"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 07:45:51 -0700
X-CSE-ConnectionGUID: siS0FlX3QkKQt5vi8NPjZQ==
X-CSE-MsgGUID: GRIgeYagT9GKyI3duiWHpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="243727800"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost)
 ([10.245.244.3])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 07:45:50 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/displayid: fix Tiled Display Topology ID size
In-Reply-To: <20260610143258.324C21F00893@smtp.kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260610141549.555605-1-jani.nikula@intel.com>
 <20260610143258.324C21F00893@smtp.kernel.org>
Date: Wed, 10 Jun 2026 17:45:47 +0300
Message-ID: <7f2d51d75ff70c1d2f46658d162c54d0bbe46da7@intel.com>
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

On Wed, 10 Jun 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Missing payload size validation in `drm_parse_tiled_block` allows an out-of-bounds read of the EDID buffer when parsing malformed DisplayID tiled display blocks.
> --
>
> commit 3a0b5d7c7c564335f99c7d692448de9241f67bbd
> Author: Jani Nikula <jani.nikula@intel.com>
>
> drm/displayid: fix Tiled Display Topology ID size
>
> This commit updates the Tiled Display Topology ID size from 8 to 9 bytes
> in the DRM subsystem structures.
>
>> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
>> index 3fa4d2082cd72..11646453aaac9 100644
>> --- a/drivers/gpu/drm/drm_connector.c
>> +++ b/drivers/gpu/drm/drm_connector.c
> [ ... ]
>> @@ -3579,14 +3579,14 @@ EXPORT_SYMBOL(drm_mode_put_tile_group);
>>   * tile group or NULL if not found.
>>   */
>>  struct drm_tile_group *drm_mode_get_tile_group(struct drm_device *dev,
>> -					       const char topology[8])
>> +					       const char topology_id[9])
>>  {
>>  	struct drm_tile_group *tg;
>>  	int id;
>>  
>>  	mutex_lock(&dev->mode_config.idr_mutex);
>>  	idr_for_each_entry(&dev->mode_config.tile_idr, tg, id) {
>> -		if (!memcmp(tg->group_data, topology, 8)) {
>> +		if (!memcmp(tg->group_data, topology_id, sizeof(tg->group_data))) {
>
> [Severity: High]
> This isn't a bug introduced by this patch, but could this lead to an
> out-of-bounds read of the EDID buffer when parsing malformed DisplayID tiled
> display blocks?
>
> Looking at drm_parse_tiled_block() in drivers/gpu/drm/drm_edid.c, the generic
> block is cast to a displayid_tiled_block without validating that the payload
> size (block->num_bytes) is large enough:
>
> drivers/gpu/drm/drm_edid.c:drm_parse_tiled_block() {
>     ...
>     const struct displayid_tiled_block *tile =
>         (struct displayid_tiled_block *)block;
>     ...
>     tg = drm_mode_get_tile_group(connector->dev, tile->topology_id);
> }
>
> If a malformed EDID provides a tiled block with a short length near the end
> of the allocated EDID buffer, comparing 9 bytes here (or copying them down in
> drm_mode_create_tile_group()) might read past the bounds of the EDID buffer.

Yeah, maybe you should start reading the mailing list [1]. This patch is
in response to the fix for that very issue.

BR,
Jani.


[1] https://lore.kernel.org/r/4e784cad86c91595b6d5da64ca854dab38357658@intel.com



-- 
Jani Nikula, Intel
