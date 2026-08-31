Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10119C61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:51:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BDFF89B46;
	Mon, 31 Aug 2026 08:51:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iNu2nwuU";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48A1089B46;
 Mon, 31 Aug 2026 08:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788166291; x=1819702291;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=H8AGgaN0fxCVZaDd147b/BPVaKt5rLGLX8Ilies60dg=;
 b=iNu2nwuUzGnQPy/CeG20dVcUHckLhk93nPiQyctzm1oIqiTtqwzda6MH
 e6ttBPT2ZxHivJy+junXstDj1HBGzvxVZKkyMOcT2cD6xcbMHeRVAzVAG
 6y30C+seJSt4HA79QQ0qK/8KHc866PEUQoyeQfrgFDt1ncLW/gMTTA5Xw
 sjYw9FPcpuf9m+MvUQQQpF1LL7jpMuZU5T1PNsKUrOC/tYHRCr8RKy55s
 GhOM90iUceSxYR2UjUEHbxUKhTCazWOrOubywOCxBpK004cr2wYhxFb19
 a9iVpDPnR2PYORzUe1FWOT0a8ktNRKdYDfabjE0OY6K9iaNgrWpASVDiQ A==;
X-CSE-ConnectionGUID: 1bLWhvBGQp6Mm8QUwT0uQw==
X-CSE-MsgGUID: K9OInS+bTKehrK7oaB2BEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88421998"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88421998"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 01:51:30 -0700
X-CSE-ConnectionGUID: M7+Z3B/rTHWK0RuyBvKpUQ==
X-CSE-MsgGUID: 6VxY7c5KTFGR+/9FwbFMGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="265499026"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.22])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 01:51:25 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 louis.chauvet@bootlin.com, hamohammed.sa@gmail.comm, simona@ffwll.ch,
 melissa.srw@gmail.com, robin.clark@oss.qualcomm.com,
 abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, Kamil Konieczny
 <kamil.konieczny@linux.intel.com>, "S, Sowmiya" <sowmiya.s@intel.com>,
 kernel-dev@igalia.com
Cc: Mark Yacoub <markyacoub@google.com>, Thadeu Lima de Souza Cascardo
 <cascardo@igalia.com>
Subject: Re: [PATCH i-g-t] Revert "lib/igt_kms: Do not treat writeback and
 virtual connectors as connected"
In-Reply-To: <20260828-vkms_virtual_output_fix-v1-1-789718f4cb00@igalia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260828-vkms_virtual_output_fix-v1-1-789718f4cb00@igalia.com>
Date: Mon, 31 Aug 2026 11:51:23 +0300
Message-ID: <5443fa9f99309b0ec0afdd98319619a63d5467a3@intel.com>
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

On Fri, 28 Aug 2026, Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> This reverts commit 321448df7fc9af29b4c6697dc74e6c5e2100af6c.
>
> It has broken vkms testing, which has only Virtual connectors.
>
> Cc: Mark Yacoub <markyacoub@google.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

FWIW,

Acked-by: Jani Nikula <jani.nikula@intel.com>

But you should solicit feedback from the author, reviewer, and committer
of 321448df7fc9 ("lib/igt_kms: Do not treat writeback and virtual
connectors as connected").


> ---
>  lib/igt_kms.h | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/lib/igt_kms.h b/lib/igt_kms.h
> index 695f666bacb9..27f8877a9f6a 100644
> --- a/lib/igt_kms.h
> +++ b/lib/igt_kms.h
> @@ -669,10 +669,6 @@ static inline bool igt_output_is_connected(igt_output_t *output)
>  	    !output->config.connector->count_modes)
>  		return false;
>  
> -	if (output->config.connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK ||
> -	    output->config.connector->connector_type == DRM_MODE_CONNECTOR_VIRTUAL)
> -		return false;
> -
>  	if (output->config.connector->connection == DRM_MODE_CONNECTED)
>  		return true;
>  
>
> ---
> base-commit: c0c86b23b316bec7d22bbb95e433a8dc25884a1c
> change-id: 20260828-vkms_virtual_output_fix-c82298792438
>
> Best regards,
> --  
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>

-- 
Jani Nikula, Intel
