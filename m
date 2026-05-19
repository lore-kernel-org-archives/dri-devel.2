Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3935CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 15:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18CF510ED63;
	Tue, 19 May 2026 15:20:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="npU9/zHa";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81BDB10ED63
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 15:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779204010; x=1810740010;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=36WpNWvCIlVGZu3cw7xQjXKo4fU8Az4AFn7QuRKBvi4=;
 b=npU9/zHa5zDiJ3j/20Dk/RYILc1s8eP42hvkjCDzK5bYLFXJ7FATo/EM
 7OcNIaj+gg6DG2W/JgKBqwvbfDGm6KfYVdxHcDxeODOskLQusNhtTa1E9
 bhK20urbV4Ft0zKkGzNOqv+4BRL0BNWcEexmVmOhc3KQSS4WDvPnx+uYf
 S7QwCGJScVx1iTyA5N9wPTz2bxKwL935qQvqirPW0bJakoPY20MYl8pQ2
 3QqegXuU6LZnNPh7aON4XfjlFtRbH020AhQBut7UMbDNc6a8sGQtkwPbC
 wVS8Gh9BFt19YHKcotrGhsb4VIs3B3PRcNQPBwwb7/KvU/RTw0otB6fO1 Q==;
X-CSE-ConnectionGUID: KGihZ16oSMuFehgyNcW7wQ==
X-CSE-MsgGUID: RiXfRJPxRJi/ueaEBvrteQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80049479"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="80049479"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 08:20:09 -0700
X-CSE-ConnectionGUID: Xp5R7DdtSQe8z/stJugcaA==
X-CSE-MsgGUID: ew2jpY9nRMmFaPJuPcejWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="239849864"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.218])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 08:20:06 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>, Maxime Ripard
 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, Nicolas Frattaroli
 <nicolas.frattaroli@collabora.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/8] drm/display: hdmi: Add common TMDS character rate
 constants
In-Reply-To: <20260519144712.1418302-2-javierm@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260519144712.1418302-1-javierm@redhat.com>
 <20260519144712.1418302-2-javierm@redhat.com>
Date: Tue, 19 May 2026 18:20:03 +0300
Message-ID: <78506dc5f7ff02a2bdd05de1170a1cb3e33e1abe@intel.com>
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

On Tue, 19 May 2026, Javier Martinez Canillas <javierm@redhat.com> wrote:
> Several DRM drivers already define their own constants for minimum and
> maximum TMDS character rates.
>
> By defining common rate constants in a shared header, drivers can just use
> them instead of having driver local define macros or use magic numbers.
>
> The values defined in the <drm/display/drm_hdmi_helper.h> header correspond
> to maximum TMDS character rates defined by each HDMI specification version:
>
>   - DRM_HDMI_TMDS_CHAR_RATE_MIN:    25 MHz (minimum for all versions)
>   - DRM_HDMI_TMDS_CHAR_RATE_MAX_1_0: 165 MHz (HDMI 1.0 maximum)
>   - DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3: 340 MHz (HDMI 1.3 maximum)
>   - DRM_HDMI_TMDS_CHAR_RATE_MAX_2_0: 600 MHz (HDMI 2.0 maximum)
>
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>
>  include/drm/display/drm_hdmi_helper.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/drm/display/drm_hdmi_helper.h b/include/drm/display/drm_hdmi_helper.h
> index 9c31ed90516b..0ee246ff82e0 100644
> --- a/include/drm/display/drm_hdmi_helper.h
> +++ b/include/drm/display/drm_hdmi_helper.h
> @@ -5,6 +5,12 @@
>  
>  #include <linux/hdmi.h>
>  
> +/* HDMI spec TMDS character rate limits (in Hz) */
> +#define DRM_HDMI_TMDS_CHAR_RATE_MIN	25000000
> +#define DRM_HDMI_TMDS_CHAR_RATE_MAX_1_0	165000000
> +#define DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3	340000000
> +#define DRM_HDMI_TMDS_CHAR_RATE_MAX_2_0	600000000

Usually everything in DRM is in kHz, and Hz is the exception.

I'm also not sure the 1_0, 1_3, and 2_0 really help anyone reading the
code. I won't remember what they mean in Hz or kHz, and I'll have to
look them up every single time.

BR,
Jani.

> +
>  struct drm_connector;
>  struct drm_connector_state;
>  struct drm_display_mode;

-- 
Jani Nikula, Intel
