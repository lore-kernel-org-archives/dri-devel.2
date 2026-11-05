Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF45E606A330
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KcbI0FGU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DD5D10E1AC;
	Thu,  5 Nov 2026 17:08:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ADB410E1F7;
 Thu,  5 Nov 2026 17:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793898494; x=1825434494;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=5SWCj7u+AZVyRuqaD0dvIIMKCEG7YeyHF+pdDOeuanA=;
 b=KcbI0FGUG3zknjZN2r5tzpvviPoGWzSyOtnxYEpVDrSXhQYG2jgNc1Xg
 vrZglcbAywPOjs1cZLdKQrWfQJoen35XoWoB4jIqXIwWXD/Y4GeD5jqoR
 dCf9nk9K4lzCbH0Lk5yIKncnYbUL4tqthpK2U7mWTzms4v2YYrqGmOEKo
 DHmSoCsNM4QURL+Pyf+YwqRN/C9u6nuowqn/7MiHb6MWd6pZacMWj+Esl
 bNC2Bm0NSQXPbW7Bxln21GQIkH4HE9g0uUd/gmLzDfZ+SkJVRONFID6+S
 hwZMfjtKafOws482djK4NuoDkrUG9GKa2HeBYGV7pxxMzeEsMlp4a7hao w==;
X-CSE-ConnectionGUID: vPSyvuSKSeeM/ZCnDwnSnQ==
X-CSE-MsgGUID: 01r4oe9jQLWwYXHkY7ieLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2610068"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2610068"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 09:08:14 -0800
X-CSE-ConnectionGUID: AeNGSIuSRayL8fMkqkYhOw==
X-CSE-MsgGUID: xpCkq7RMRQ2x9GCfaAtyzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7397912"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.198])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 09:08:07 -0800
Date: Thu, 5 Nov 2026 19:08:04 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-sound@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 =?utf-8?B?VG9tw6HFoQ==?= Hnyk <tomashnyk@gmail.com>,
 Wim Taymans <wtaymans@redhat.com>, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/eld: Add drm_eld_set_port_id() helper
Message-ID: <auy39DQZEc3SpqYo@intel.com>
References: <20261105160240.2850042-1-kai.vehmanen@linux.intel.com>
 <20261105160240.2850042-2-kai.vehmanen@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261105160240.2850042-2-kai.vehmanen@linux.intel.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

On Thu, Nov 05, 2026 at 06:02:39PM +0200, Kai Vehmanen wrote:
> The ELD baseline block reserves bytes 8..15 for a 64-bit Port_ID that
> identifies the source port of the audio endpoint. drm_edid_to_eld()
> leaves the field zero, and no driver fills it in, so it carries no
> information.
> 
> When two identical monitors are connected, their ELDs are then
> byte-identical, and userspace has no passive way to tell which HDMI/DP
> PCM belongs to which DRM connector. The only workaround is to toggle
> the connector audio property and watch which ELD goes away, which
> disrupts the endpoint.
> 
> Add a helper that drivers can use to fill in Port_ID with a common
> layout:
> 
>   bits 63:48 - PCI domain of the DRM device
>   bits 47:32 - PCI bus/device/function of the DRM device
>   bits 31:0  - DRM connector object ID
> 
> Userspace can read the connector object ID directly from KMS, and the
> PCI address tells GPUs apart in multi-GPU systems. For non-PCI devices
> the upper half is left zero.
> 
> The split between a 16-bit PCI BDF in the upper half and a per-device
> display identifier in the lower half follows the Port_ID layout
> documented for the AMD Azalia sink info registers in dce_audio.c.
> 
> Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> ---
>  drivers/gpu/drm/drm_eld.c | 42 +++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_eld.h     |  3 +++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_eld.c b/drivers/gpu/drm/drm_eld.c
> index c0428d07de53..baebece7b4ed 100644
> --- a/drivers/gpu/drm/drm_eld.c
> +++ b/drivers/gpu/drm/drm_eld.c
> @@ -4,7 +4,11 @@
>   */
>  
>  #include <linux/export.h>
> +#include <linux/pci.h>
> +#include <linux/unaligned.h>
>  
> +#include <drm/drm_connector.h>
> +#include <drm/drm_device.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_eld.h>
>  
> @@ -55,3 +59,41 @@ int drm_eld_sad_set(u8 *eld, int sad_index, const struct cea_sad *cta_sad)
>  	return 0;
>  }
>  EXPORT_SYMBOL(drm_eld_sad_set);
> +
> +/**
> + * drm_eld_set_port_id - set the ELD Port_ID for a connector
> + * @eld: ELD buffer
> + * @connector: connector the ELD belongs to
> + *
> + * drm_edid_to_eld() leaves the 64-bit Port_ID field of the ELD baseline
> + * block zero. Drivers can use this helper to fill it in with a value
> + * that identifies the audio endpoint, so that userspace can associate an
> + * ELD, and the PCM device it belongs to, with a DRM connector, even when
> + * identical sinks are connected to multiple outputs.
> + *
> + * The Port_ID is stored in little-endian byte order, with the layout:
> + *
> + * - bits 63:48 - PCI domain of the DRM device, truncated to 16 bits
> + * - bits 47:32 - PCI bus/device/function of the DRM device
> + * - bits 31:0  - DRM connector object ID
> + *
> + * For non-PCI devices bits 63:32 are zero.
> + *
> + * The connector object ID is only stable for the lifetime of the
> + * connector, so userspace must look it up at runtime, and not store it.
> + */
> +void drm_eld_set_port_id(u8 *eld, const struct drm_connector *connector)
> +{
> +	struct device *dev = connector->dev->dev;
> +	u64 port_id = connector->base.id;
> +
> +	if (dev && dev_is_pci(dev)) {
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +
> +		port_id |= (u64)(pci_domain_nr(pdev->bus) & 0xffff) << 48 |
> +			   (u64)pci_dev_id(pdev) << 32;

The numbers look correct.

> +	}
> +
> +	put_unaligned_le64(port_id, &eld[DRM_ELD_PORT_ID]);

Endianness agrees with the HDA spec.

The implementation looks good
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

But I'll leave it to someone else to judge the actual
usefulness of the provided information.

> +}
> +EXPORT_SYMBOL(drm_eld_set_port_id);
> diff --git a/include/drm/drm_eld.h b/include/drm/drm_eld.h
> index 0a88d10b28b0..de0478720721 100644
> --- a/include/drm/drm_eld.h
> +++ b/include/drm/drm_eld.h
> @@ -9,6 +9,7 @@
>  #include <linux/types.h>
>  
>  struct cea_sad;
> +struct drm_connector;
>  
>  /* ELD Header Block */
>  #define DRM_ELD_HEADER_BLOCK_SIZE	4
> @@ -80,6 +81,8 @@ static inline int drm_eld_mnl(const u8 *eld)
>  int drm_eld_sad_get(const u8 *eld, int sad_index, struct cea_sad *cta_sad);
>  int drm_eld_sad_set(u8 *eld, int sad_index, const struct cea_sad *cta_sad);
>  
> +void drm_eld_set_port_id(u8 *eld, const struct drm_connector *connector);
> +
>  /**
>   * drm_eld_sad - Get ELD SAD structures.
>   * @eld: pointer to an eld memory structure with sad_count set
> -- 
> 2.43.0

-- 
Ville Syrjälä
Intel
