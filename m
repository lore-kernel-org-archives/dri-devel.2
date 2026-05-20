Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0137CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 13:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A1A210E632;
	Wed, 20 May 2026 13:10:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="oIe0SWWu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FD1F10E632;
 Wed, 20 May 2026 13:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779282626; x=1810818626;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=CbXmx3WjavP5kcQTkedrx5HHgI1eIETQcIYgrhmAYQo=;
 b=oIe0SWWuNjrCte/gRGnwZlK+YvSy/akwRVwzxWkhp0psa+bS6JT4ai4B
 U1lAvYYwxXnavsgKNHh08DsugQRvdjqOT5FlYAAx3Am/vzN1Xk55mvZ3T
 uqeIj0/jCOYa+5/Mbic6r92pdhMWxOOBCx74baByMbBut5FEwS6nbOj5D
 RvFGXa22sPgtX2++4zuCMj29Z+P8otVLCIqdwOvyf1wB2WoYdNKO7CKAj
 DmbLMlqhE2HZuF1zX03ex0tG1kccKuaK5XKA6oNHcZXXF5zbVgvyrINvH
 nHeDauV4UbDGN15EM1G7Dqa7aqUaIKcAnG0roAlcWWf1CfMCMwQ0YvsYG g==;
X-CSE-ConnectionGUID: HouFfHUPSmaEJVzVy8hRHQ==
X-CSE-MsgGUID: KTsxXvaxToem5Bj9cNeg1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="67707244"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="67707244"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 06:10:26 -0700
X-CSE-ConnectionGUID: shJXQyHSQVGAtZP3+q1NSQ==
X-CSE-MsgGUID: MUs3v0JHSfWXemzAWlO4Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="245158844"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.148])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 06:10:22 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Chenyu Chen <chen-yu.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Ray
 Wu <Ray.Wu@amd.com>, Limonciello Mario <Mario.Limonciello@amd.com>, Chenyu
 Chen <chen-yu.chen@amd.com>, Mario Limonciello <superm1@kernel.org>
Subject: Re: [PATCH v2 1/3] drm/edid: extract section header processing into
 helper
In-Reply-To: <20260520021432.1301326-2-chen-yu.chen@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260520021432.1301326-1-chen-yu.chen@amd.com>
 <20260520021432.1301326-2-chen-yu.chen@amd.com>
Date: Wed, 20 May 2026 16:10:19 +0300
Message-ID: <636d8a5c5d0b626852cee0446c2ebdaadff346c1@intel.com>
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

On Wed, 20 May 2026, Chenyu Chen <chen-yu.chen@amd.com> wrote:
> Extract the DisplayID section header logging and non_desktop
> detection from update_displayid_info() into a dedicated helper,
> drm_displayid_process_section_header(). Remove the break so the
> iterator walks through all data blocks, preparing for future
> patches that will parse additional block types within the loop.
>
> The helper is called only once for the base section via a
> header_processed flag. Since version and primary_use are only
> captured from the base section, and extension sections carry a
> primary use of zero per spec, the non_desktop logic is unaffected.
>
> No functional change.
>
> Assisted-by: Copilot:Claude-Opus-4.6
> Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/gpu/drm/drm_edid.c | 37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 8031f021d4d0..04878478ab78 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -6715,30 +6715,35 @@ static void drm_reset_display_info(struct drm_connector *connector)
>  	memset(&info->amd_vsdb, 0, sizeof(info->amd_vsdb));
>  }
>  
> +static void drm_displayid_process_section_header(struct drm_connector *connector,
> +				  const struct displayid_iter *iter)

The name's a bit grandiose, yet loses the bit about "base section" which
was the crucial part in the comment that gets removed below.

> +{
> +	struct drm_display_info *info = &connector->display_info;
> +
> +	drm_dbg_kms(connector->dev,
> +			"[CONNECTOR:%d:%s] DisplayID extension version 0x%02x, primary use 0x%02x\n",
> +			connector->base.id, connector->name,
> +			displayid_version(iter),
> +			displayid_primary_use(iter));
> +	if (displayid_version(iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
> +		(displayid_primary_use(iter) == PRIMARY_USE_HEAD_MOUNTED_VR ||
> +			displayid_primary_use(iter) == PRIMARY_USE_HEAD_MOUNTED_AR))
> +		info->non_desktop = true;
> +}

The indent is all wrong in this function.

> +
>  static void update_displayid_info(struct drm_connector *connector,
>  				  const struct drm_edid *drm_edid)
>  {
> -	struct drm_display_info *info = &connector->display_info;
>  	const struct displayid_block *block;
>  	struct displayid_iter iter;
> +	bool header_processed = false;
>  
>  	displayid_iter_edid_begin(drm_edid, &iter);
>  	displayid_iter_for_each(block, &iter) {
> -		drm_dbg_kms(connector->dev,
> -			    "[CONNECTOR:%d:%s] DisplayID extension version 0x%02x, primary use 0x%02x\n",
> -			    connector->base.id, connector->name,
> -			    displayid_version(&iter),
> -			    displayid_primary_use(&iter));
> -		if (displayid_version(&iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
> -		    (displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_VR ||
> -		     displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_AR))
> -			info->non_desktop = true;
> -
> -		/*
> -		 * We're only interested in the base section here, no need to
> -		 * iterate further.
> -		 */
> -		break;
> +		if (!header_processed) {
> +			drm_displayid_process_section_header(connector, &iter);
> +			header_processed = true;

Every DisplayID Section has a header. Every DisplayID Data Block within
a DisplayID Section has a header. This is about handling the information
in the Base Section header only. IMO header_processed is misleading.

BR,
Jani.

> +		}
>  	}
>  	displayid_iter_end(&iter);
>  }

-- 
Jani Nikula, Intel
