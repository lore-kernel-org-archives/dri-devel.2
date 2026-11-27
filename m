Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03314606A323
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qbb7YUQp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DCBD1128C8;
	Fri, 27 Nov 2026 09:25:30 +0000 (UTC)
Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 678501128D5
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:25:24 +0000 (UTC)
Received: by mail-wr2-f9.google.com with SMTP id
 ffacd0b85a97d-4912e5f330dso2453965f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 01:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795771522; x=1796376322; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ksU77zdRcGEkDaOL3bOMHybdYo8q9JOlRC2jOXpEIBg=;
 b=Qbb7YUQpAJpoVo0YbAE7gTespMPfWCOrodjNLR9sIUMKlv1PkDm1nR2OKjkhG+12Iq
 hWCJ/AaufaA7YApKYrcWNg7fiSb0dtJuywx+0MGx98igSOi40cNNCZTIoSQ4y/FXKFaZ
 M6lAzCumST3j4oiu7McVnRtxXhkJf1MIfnY1CLSMUZBxRJ2lYmFkR7esUEz5hgiswQAx
 1ejk9fyMOi8IHIjok/+mnphI1F16bDXOaDRyNPjhZA3Wqh/2FAsOAdJcazzt0h9DPuHj
 UkuzSjN53sJ0AOh8OYKtky8aPJ0utOw3y6NVx7EmR2ZJdqCGHN99C282+TUJAEb+RXnM
 N98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795771522; x=1796376322;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ksU77zdRcGEkDaOL3bOMHybdYo8q9JOlRC2jOXpEIBg=;
 b=hQOaMp0xT6YxwSdb6KEc/S03kt04nUZEokJbNwbRvOjJn6fD99gcDryYDjMAcPijb2
 3P5B4ANTqySpDy9uXIo9rXLRoL6aZxs9o4BL/tqFjiHqJDAjI5UPcySzhSDDZCXHYraw
 NaI8TZ7wHU8MH+uX6ET+Hg6tRo8Jw1SEdRHX5Ffun2XNDBGqVZ5eAmczF2Lzt/WVlwqR
 jPvFj1FI5zZq8XN0V1l6ZoTXK3ylScqkL6G5vcsFgl7bu/hYOARTQFFf4YGXGBRuAiLt
 2h+2vYLQ4MXikXTKfU4L2w5YIYWcGOeJ3IO4QGh2c1CfUTQY7nSDd7Cnp2vgBjSKgAfn
 DXIA==
X-Forwarded-Encrypted: i=1;
 AL+hErFGm6tp9nK/ZhOSV4gqda7uCNTIhob2/z5T95tOn0YU5MvLyQY6BIB6nkTmR+Wk3i42BfQHOYv9rSo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9j3uwvK25ep9jVpFUUkG91WiBGcBAvR5J2S52FJhRRlD8pfL92
 Pm2X4jDCmWa9DtTRbbu18Jw6CrM/TidAViQIv5vm4BhLFOO2Ch5TKHIv
X-Gm-Gg: AZFdTZcPiitAYT0E/v0G8td5n5tUjU0Slk2Lo6MGHxTSrjRqxmp3Eo2It3Ra/GL1XSe
 pqzUqLEz0eElzPdEcG/PAAAp6KRBk11Q4o93/lEfyhRdogpkoeeobxOwc87yNaozAcydgGYdHfN
 /CUx9bHH5nHBLpzIrVqQJdJi2bp6JFEHVefVz39EWJKt/x+22d/hlTRtZEvtu02d8WsfBWJYVCo
 zabPSP7oZCw9bhNqOZNA2jN2VPfTPdtIqKwZmebgsihd7iof24PLs/L9+jJvgyAWeETPvWzBv34
 5hwVNcEoCExSO9CwWcUj/Eewh3iJ/dcyKxDbnMip3eXWKNNtjoaTjv/S1eGg0t9JomH1FOJNhaq
 opr79nAdLWixO8wHWEEBcVrwSBFAWNviGt8IuplBLsGFc7h2FMu22J7uA4J10FYUP3CgxQPvX4L
 75aLwEYLwMyxiNw0VrGJptQauGor4JlDnE0lVJOmpmTERu7jxtuwnQS1B+uLtJ/YETNADIVBDPE
 qpI/fKFzl4Ut91gUtaBP8B6ujUOvoB4y4kE8yb9crlUWN0LwxFELeQCLZ5oXSVJlkSyBJzZdu5D
 gs2zo0OVTwajgQqSoq1pN69Mcu7ymvvnTl3kBw==
X-Received: by 2002:a5d:584f:0:b0:4b9:8ac3:f5fa with SMTP id
 ffacd0b85a97d-4b98ac3f6d5mr16755716f8f.48.1795771522353; 
 Fri, 27 Nov 2026 01:25:22 -0800 (PST)
Received: from [192.168.1.11] ([31.94.68.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6baa397asm46609335f8f.48.2026.11.27.01.25.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 01:25:21 -0800 (PST)
Message-ID: <2e93336e-9983-4d20-96fe-515a6b5009b2@gmail.com>
Date: Fri, 27 Nov 2026 09:25:20 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] drm/amd/display: unlock secondary tile on Apple
 4K/5K iMac panels
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <07e54333-2391-4e8f-8819-fa431d981430@gmail.com>
Content-Language: en-US
From: Richard Lane <richardlanedev@gmail.com>
In-Reply-To: <07e54333-2391-4e8f-8819-fa431d981430@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27/11/2026 00:05, Richard Lane wrote:
> Apple 21.5" 4K (iMac18,2, iMac19,2) and 27" 5K (iMac15,1, iMac17,1,
> iMac18,3, Polaris-based iMac19,1) Retina iMacs expose their internal
> panel as a 2x1 tiled display over an eDP root link and a secondary DP
> link. At boot, the panel TCON operates in single-pipe mode and holds the
> secondary DP link's HPD line low until unlocked via DPCD registers.
> 
> Enable native tiled detection and link training for DCE < 12 Apple 4K/5K
> Retina iMac panels:
> - Latch the root eDP link via DPCD 0x4F1 prior to reading its EDID in
>   dm_helpers_read_local_edid() on Apple hardware (DCE < 12) so the
>   TCON exposes its full DisplayID tile properties even when Apple and
>   OpenCore Legacy Patcher (OCLP) EFI folders are absent.
> - Point the secondary DP dc_link to the root eDP dc_link
>   (apple_tcon_peer) during EDID quirk matching on DCE < 12 iMac15,1
>   (AE01/02), iMac17,1 (AE05/06), iMac18,3 (AE11/12), iMac18,2/19,2
>   (AE19/1A), and Polaris-based iMac19,1 (AE25/26), checking
>   connector_signal since panel IDs can flip across the two links after
>   S3 wake. DCE >= 12 support for Vega-based iMac19,1, iMacPro1,1, and
>   iMac20,x is documented as TODO.
> - Avoid falling back to DVI and latch the secondary tile via DPCD 0x4F1
>   on the root eDP link when probing the secondary link, allowing the
>   secondary link to read its EDID and populate DRM's DisplayID tile
>   properties (has_tile, tile_group, and tile_is_single_monitor).
> - Write the 3-byte Boot Camp source table (0x04, 0x1d, 0x03) to DPCD
>   0x310 in dpcd_set_source_specific_data() to unlock the secondary tile.
> - Unlatch both tiles (0x4F1) and clear DP_SOURCE_TABLE_REVISION (0x310)
>   and DP_EDP_CONFIGURATION_SET (0x10A) in amdgpu_dm_apple_tcon_unlatch()
>   during dm_suspend() so the TCON returns to single-pipe mode for the
>   EFI boot screen across reboots.
> 
> Signed-off-by: Richard Lane <richardlanedev@gmail.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 ++++++++++
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 35 +++++++++++++++++++
>  drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
>  .../drm/amd/display/dc/link/link_detection.c  |  7 +++-
>  .../dc/link/protocols/link_dp_capability.c    |  4 +++
>  5 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3d2201285888..6275a585593c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1610,6 +1610,23 @@ STATIC_IFN_KUNIT void dm_destroy_cached_state(struct amdgpu_device *adev)
>  }
>  EXPORT_IF_KUNIT(dm_destroy_cached_state);
>  
> +static void amdgpu_dm_apple_imac_unlatch(struct dc *dc)
> +{
> +	const u8 zeros[3] = { 0 };
> +
> +	for (int i = 0; i < dc->link_count; i++) {
> +		struct dc_link *link = dc->links[i];
> +
> +		if (link->apple_imac_peer) {
> +			core_link_write_dpcd(link, DP_SOURCE_TABLE_REVISION, zeros, 3);
> +			core_link_write_dpcd(link, DP_EDP_CONFIGURATION_SET, zeros, 1);
> +			core_link_write_dpcd(link, 0x4F1, zeros, 1);
> +			core_link_write_dpcd(link->apple_imac_peer, 0x4F1, zeros, 1);
> +			break;
> +		}
> +	}
> +}
> +
>  static int dm_suspend(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> @@ -1677,6 +1694,8 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
>  
>  	amdgpu_dm_hpd_rx_irq_work_suspend(dm);
>  
> +	amdgpu_dm_apple_imac_unlatch(dm->dc);
> +
>  	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
>  
>  	if (dm->dc->caps.ips_support && adev->in_s0ix)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 6192c0f6086d..0863628c9d67 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -29,6 +29,7 @@
>  #include <linux/string.h>
>  #include <linux/acpi.h>
>  #include <linux/i2c.h>
> +#include <linux/dmi.h>
>  
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_probe_helper.h>
> @@ -173,6 +174,31 @@ STATIC_IFN_KUNIT void apply_edid_quirks(struct dc_link *link, struct edid *edid,
>  		drm_dbg_driver(dev, "Force FreeSync min to 60 Hz on panel id %X\n", panel_id);
>  		edid_caps->panel_patch.force_freesync_min_hz = 60;
>  		break;
> +	/*
> +	 * Workaround for Apple 21.5" 4K and 27" 5K iMac 2x1 tiled panels
> +	 * (eDP root + secondary DP). Point secondary->apple_imac_peer to root
> +	 * so detection/suspend can latch/unlatch the TCON via DPCD; match both
> +	 * single/tiled IDs and gate on eDP so only root sets the peer.
> +	 * IDs (Single/Tiled): iMac15,1 (AE01/02), iMac17,1 (AE05/06),
> +	 * iMac18,3 (AE11/12), iMac18,2/19,2 (AE19/1A), iMac19,1 (AE25/26);
> +	 * TODO (DCE >= 12): iMac19,1/19,2 Vega, iMacPro1,1 (AE1D/1E),
> +	 * iMac20,x (AE31/32, AE35/36).
> +	 */
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE01):
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE02):
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE05):
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE06):
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE11):
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE12):
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE19):
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE1A):
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE25):
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE26):
> +		if (link->connector_signal == SIGNAL_TYPE_EDP &&
> +		    link->ctx->dce_version < DCE_VERSION_12_0 &&
> +		    (link->link_index ^ 1) < link->dc->link_count)
> +			link->dc->links[link->link_index ^ 1]->apple_imac_peer = link;
> +		break;
>  	default:
>  		return;
>  	}
> @@ -1299,6 +1325,15 @@ enum dc_edid_status dm_helpers_read_local_edid(
>  	if (link->dc->hwss.prepare_ddc)
>  		link->dc->hwss.prepare_ddc(link);
>  
> +	if (link->connector_signal == SIGNAL_TYPE_EDP &&
> +	    link->ctx->dce_version < DCE_VERSION_12_0 &&
> +	    dmi_match(DMI_SYS_VENDOR, "Apple Inc.")) {
> +		const char *product = dmi_get_system_info(DMI_PRODUCT_NAME);
> +
> +		if (product && str_has_prefix(product, "iMac"))
> +			dm_helpers_dp_write_dpcd(ctx, link, 0x4F1, &(const uint8_t){1}, 1);
> +	}
> +
>  	dm_helpers_wait_for_edid_ready(link, ddc);
>  
>  	/* some dongles read edid incorrectly the first time,
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index 8471dcfe24fd..bd3857267331 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -2018,6 +2018,7 @@ struct dc_scratch_space {
>  	bool skip_implict_edp_power_control;
>  	bool forced_psr_active;
>  	enum backlight_control_type backlight_control_type;
> +	struct dc_link *apple_imac_peer;
>  };
>  
>  struct dc {
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> index 5b257f003f13..02c6e5874c16 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> @@ -218,7 +218,7 @@ static enum signal_type link_detect_sink_signal_type(struct dc_link *link,
>  			 * we assume signal is DVI; it could be corrected
>  			 * to HDMI after dongle detection
>  			 */
> -			if (!dm_helpers_is_dp_sink_present(link))
> +			if (!link->apple_imac_peer && !dm_helpers_is_dp_sink_present(link))
>  				result = SIGNAL_TYPE_DVI_SINGLE_LINK;
>  		}
>  		break;

I have also discovered that this modification to link_detection.c is not needed.

Richard
> @@ -1651,6 +1651,11 @@ bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *
>  		}
>  	}
>  
> +	if (*type == dc_connection_none && link->apple_imac_peer) {
> +		core_link_write_dpcd(link->apple_imac_peer, 0x4F1, &(const uint8_t){1}, 1);
> +		*type = dc_connection_single;
> +	}
> +
>  	return true;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> index c487c5b87dfd..74954702c5a9 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> @@ -1496,6 +1496,10 @@ void dpcd_set_source_specific_data(struct dc_link *link)
>  				link->dc->vendor_signature.data.raw,
>  				sizeof(link->dc->vendor_signature.data.raw));
>  	}
> +
> +	if (link->apple_imac_peer)
> +		core_link_write_dpcd(link, DP_SOURCE_TABLE_REVISION,
> +				     (const uint8_t[]){0x04, 0x1d, 0x03}, 3);
>  }
>  
>  void dpcd_write_cable_id_to_dprx(struct dc_link *link)

