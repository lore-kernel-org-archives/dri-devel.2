Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2F3606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LBvc45Ra
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2B7710ED4C;
	Mon, 16 Nov 2026 09:00:25 +0000 (UTC)
Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com
 [74.125.225.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EC5310E281
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:52:07 +0000 (UTC)
Received: by mail-wr2-f11.google.com with SMTP id
 ffacd0b85a97d-4901ac93584so783281f8f.0
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 10:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794682326; x=1795287126; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rVBETihkpK3ZyrNBm4wNB0zQniJSB3VwqkgPzbMYV+E=;
 b=LBvc45RaBXuqZDMLUk5W9taoeHxH+uf5DUZt1ESonmZl1xt9ybjQrOzOrRKNxUFCob
 ISM8wKJBewfFZjVR+j29XMpAxMlWgUZ1GU3GozuOUOUAdEhEGIFhi1qpWj6aPbiT8IiC
 AYCFqMZhf0ziMNK+Eh1MwQPbn3jK114lmG0PV3q33VD4eJ4SiG/u4qdcbkOZaKn5ITwh
 lXyUmVg9hWBfHJlfFjkGE73ngE2GaK56iOCzurAPi/0ijFkZld2b3kmgBzH2bZO0azzT
 9mjOoRmVWZr62nh/EU3fQOtz295DutIrqcSvSRTYl+QJEw3ewUHh5be3PZ2kkCIyKU5P
 +7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794682326; x=1795287126;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rVBETihkpK3ZyrNBm4wNB0zQniJSB3VwqkgPzbMYV+E=;
 b=j5OpEDZ3llYjJK47H1pNL9NhaHOcUnCgNt093rRG9q6qMH/ZyX7lYGQnJlCKZZXS1Q
 z/7KrVGwGmrTm1GAMnUfIxZP93mPsn48vzWswuEAxSz0e948mZC3lfdrxx7X5P4clGq7
 Kty6MjI/cnxe+rdDON3IqQF5MUxNJwRXb6NYyLrEY9kdmoRwbAvaoQK22sfauvCk/ZUr
 vrx4FORpgueokHqVYGDvis9iEqklfPiyGJbhTvDBA/KMrzcZbvXQTQs0c5AN0lqp4goC
 +BmzEVDcEdXaWo6OivFogay47yBX8p863pC9fJrk86BdzT96VIP/+vi6cuwCBDBfhhow
 A7wg==
X-Forwarded-Encrypted: i=1;
 AL+hErHfuclmkTSGvOMK2/SMCPpL+H2itdReBund3wqEiXizdTF69M09KwGJrOrfbe0GXBsV7K+pCFatEOg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z80esmDKQBRxiXgivxY4QFgmVVt0UZrWz21NsOxiA66yvjCNksa
 xFeLtg77f8OaL8wSZPivJiOwL233zRr4HrQeCKMef4p1vnMm4+i3i787
X-Gm-Gg: AYBFou1GhJ3V98sXaXXHUvB3l2CvjtZEitM0w15a0YyeavC5HqUNJflsf5mrf7cXbSt
 jDssh7jig75FK2TS0221amuLVX58wkkHS3oM51OfDy+VT4UO8NUEsymctylFa7J/i1buaEc5Y2g
 4LEk1DP/WJAPHMV0x9w8gvUo0UDgRCd3a40fRnLw1e4K1LeD6xcYRTdtAKD9SLdp7DiHQU91Ysf
 LS5zGYHZSFF+L/Pwyl6WtlTcmD00uFG3v6YOcsia5gKpPEe8jdvOCE8bsgUtEZL49yEs0e23Zx2
 5EaxkOxdVS3Ha3iami4tp/xP+dOnwzMHmy9haUyYLAPUmzST2hI+Wcub/o/gHtJ1xqeqod8sm9n
 0ZiYTxP4KejaT1/pL5RHUIOAZUpUfqLj15oPJRMQ+U/Gio7LubTBZTxyonnUrJ2cbUJTuyaW003
 uhtPactqR+nedzRfBln2FpGLo8uupMekcTIvJjYOp4O9AJ2mpAM7VeRUFGxo7QCB92rcWc/pObX
 aPAaqAZbIUBMxUXctWoNpfck26mQYc2bqA6tXLEYsWVFmIW6MmNSkCYdV2vMoqgi3rSWd33lkic
 T2Key0raJbRYtnz45da1Y9HkNVewdU7t4hc=
X-Received: by 2002:a05:6000:250a:b0:49e:f905:4698 with SMTP id
 ffacd0b85a97d-49ef90546a4mr2226078f8f.2.1794682325669; 
 Sat, 14 Nov 2026 10:52:05 -0800 (PST)
Received: from [192.168.1.7] ([31.94.68.191]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f1c18b9sm10201381f8f.20.2026.11.14.10.52.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Nov 2026 10:52:04 -0800 (PST)
Message-ID: <5e30862a-5161-49d7-8713-2da9dec4356d@gmail.com>
Date: Sat, 14 Nov 2026 18:52:01 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/amd/display: unlock secondary tile on Apple
 5K, iMac panels
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <94672259-c526-4ec7-a69c-7dda8d934593@gmail.com>
Content-Language: en-US
From: Richard Lane <richardlanedev@gmail.com>
In-Reply-To: <94672259-c526-4ec7-a69c-7dda8d934593@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 16 Nov 2026 09:00:24 +0000
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 01/11/2026 23:24, Richard Lane wrote:
> Apple 27" 5K iMacs (2014-2019, iMac15,1 through Polaris-based iMac19,1)
> expose their internal 5120x2880 panel as a 2x1 tiled display over an eDP
> root link and a secondary DP link. At boot, the panel TCON operates in
> single-pipe mode and holds the secondary DP link's HPD line low until
> unlocked via DPCD registers.
> 
> Enable native tiled detection and link training for DCE < 12 Apple 5K
> panels:
> - Point the secondary DP dc_link to the root eDP dc_link (apple_5k_peer)
>   during EDID quirk matching on DCE < 12 iMac15,1, iMac17,1, iMac18,3,
>   and Polaris-based iMac19,1 (checking connector_signal since panel IDs
>   can flip across the two links after S3 wake). DCE >= 12 support for
>   Vega-based iMac19,1, iMacPro1,1, and iMac20,x is documented as TODO.
> - Avoid falling back to DVI and latch the secondary tile via DPCD 0x4F1
>   on the root eDP link when probing the secondary link, allowing the
>   secondary link to read its EDID and populate DRM's DisplayID tile
>   properties (has_tile, tile_group, and tile_is_single_monitor).
> - Write the 3-byte Boot Camp source table (0x04, 0x1d, 0x03) to DPCD
>   0x310 in dpcd_set_source_specific_data() to unlock the secondary tile.
> - Prevent the secondary tile from entering DP_SET_POWER D3, which causes
>   the TCON to drop HPD and stop responding to AUX transactions.
> - Unlatch both tiles (0x4F1) and clear DP_SOURCE_TABLE_REVISION (0x310)
>   and DP_EDP_CONFIGURATION_SET (0x10A) in dm_suspend() so the TCON
>   returns to single-pipe mode for the EFI boot screen across reboots.
> 
> Signed-off-by: Richard Lane <richardlanedev@gmail.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 ++++++++++++++++
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 22 +++++++++++++++++++
>  drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
>  .../drm/amd/display/dc/link/link_detection.c  |  7 +++++-
>  .../dc/link/protocols/link_dp_capability.c    |  4 ++++
>  .../display/dc/link/protocols/link_dp_phy.c   |  3 +++
>  6 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index bdabb4bf14da..74cd88d8d580 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1607,6 +1607,23 @@ STATIC_IFN_KUNIT void dm_destroy_cached_state(struct amdgpu_device *adev)
>  }
>  EXPORT_IF_KUNIT(dm_destroy_cached_state);
>  
> +static void amdgpu_dm_apple5k_unlatch(struct dc *dc)
> +{
> +	const u8 zeros[3] = { 0 };
> +
> +	for (int i = 0; i < dc->link_count; i++) {
> +		struct dc_link *link = dc->links[i];
> +
> +		if (link->apple_5k_peer) {
> +			core_link_write_dpcd(link, DP_SOURCE_TABLE_REVISION, zeros, 3);
> +			core_link_write_dpcd(link, DP_EDP_CONFIGURATION_SET, zeros, 1);
> +			core_link_write_dpcd(link, 0x4F1, zeros, 1);
> +			core_link_write_dpcd(link->apple_5k_peer, 0x4F1, zeros, 1);
> +			break;
> +		}
> +	}
> +}
> +
>  static int dm_suspend(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> @@ -1674,6 +1691,8 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
>  
>  	amdgpu_dm_hpd_rx_irq_work_suspend(dm);
>  
> +	amdgpu_dm_apple5k_unlatch(dm->dc);
> +
>  	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
>  
>  	if (dm->dc->caps.ips_support && adev->in_s0ix)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 9774ea33272d..532748127f72 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -173,6 +173,28 @@ STATIC_IFN_KUNIT void apply_edid_quirks(struct dc_link *link, struct edid *edid,
>  		drm_dbg_driver(dev, "Force FreeSync min to 60 Hz on panel id %X\n", panel_id);
>  		edid_caps->panel_patch.force_freesync_min_hz = 60;
>  		break;
> +	/*
> +	 * Workaround for Apple 27" 5K iMacs which expose a 2x1 tiled internal
> +	 * panel over an eDP root link and a secondary DP link. Point the
> +	 * secondary link to the root link to latch/unlatch the TCON via DPCD,
> +	 * checking connector_signal as panel IDs can flip after wake.
> +	 * IDs (Root/Tile): iMac15,1 (AE01/02), iMac17,1 (AE05/06),
> +	 * iMac18,3 (AE11/12), iMac19,1 (AE25/26); TODO (DCE >= 12): iMac19,1
> +	 * Vega, iMacPro1,1 (AE1D/1E), iMac20,x (AE31/32).
> +	 */
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE01):
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE02):
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE05):
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE06):
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE11):
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE12):
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE25):
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE26):
> +		if (link->connector_signal == SIGNAL_TYPE_EDP &&
> +		    link->ctx->dce_version < DCE_VERSION_12_0 &&
> +		    (link->link_index ^ 1) < link->dc->link_count)
> +			link->dc->links[link->link_index ^ 1]->apple_5k_peer = link;
> +		break;
>  	default:
>  		return;
>  	}

For machines with both the Apple and OCLP (OpenCore Legacy Patcher) folders
deleted from the EFI partion, an additional 5 lines are required in
amdgpu_dm_helpers.c to latch the root tile. This works consistently across
multiple reboots. It also works with the Apple and OCLP folders in place.
I can add this to v3 of the patch.

@@ -26,6 +26,7 @@
 #include <linux/string.h>
 #include <linux/acpi.h>
 #include <linux/i2c.h>
+#include <linux/dmi.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_probe_helper.h>

@@ -1265,6 +1288,11 @@
 	if (link->dc->hwss.prepare_ddc)
 		link->dc->hwss.prepare_ddc(link);
 
+	if (link->connector_signal == SIGNAL_TYPE_EDP &&
+	    link->ctx->dce_version < DCE_VERSION_12_0 &&
+	    dmi_match(DMI_SYS_VENDOR, "Apple Inc."))
+		dm_helpers_dp_write_dpcd(ctx, link, 0x4F1, &(const uint8_t){1}, 1);
+
 	/* some dongles read edid incorrectly the first time,
 	 * do check sum and retry to make sure read correct edid.
 	 */

Richard
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index f4fefa7c9ab8..aa1a9eea99d1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -2003,6 +2003,7 @@ struct dc_scratch_space {
>  	bool skip_implict_edp_power_control;
>  	bool forced_psr_active;
>  	enum backlight_control_type backlight_control_type;
> +	struct dc_link *apple_5k_peer;
>  };
>  
>  struct dc {
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> index b4546f93af0c..47755f8b9c3e 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> @@ -218,7 +218,7 @@ static enum signal_type link_detect_sink_signal_type(struct dc_link *link,
>  			 * we assume signal is DVI; it could be corrected
>  			 * to HDMI after dongle detection
>  			 */
> -			if (!dm_helpers_is_dp_sink_present(link))
> +			if (!link->apple_5k_peer && !dm_helpers_is_dp_sink_present(link))
>  				result = SIGNAL_TYPE_DVI_SINGLE_LINK;
>  		}
>  		break;
> @@ -1625,6 +1625,11 @@ bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *
>  		}
>  	}
>  
> +	if (*type == dc_connection_none && link->apple_5k_peer) {
> +		core_link_write_dpcd(link->apple_5k_peer, 0x4F1, &(const uint8_t){1}, 1);
> +		*type = dc_connection_single;
> +	}
> +
>  	return true;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> index ad1a499b0d9d..d646b156c90b 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> @@ -1496,6 +1496,10 @@ void dpcd_set_source_specific_data(struct dc_link *link)
>  				link->dc->vendor_signature.data.raw,
>  				sizeof(link->dc->vendor_signature.data.raw));
>  	}
> +
> +	if (link->apple_5k_peer)
> +		core_link_write_dpcd(link, DP_SOURCE_TABLE_REVISION,
> +				     (const uint8_t[]){0x04, 0x1d, 0x03}, 3);
>  }
>  
>  void dpcd_write_cable_id_to_dprx(struct dc_link *link)
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
> index 49521ac4b0e8..56fe2710ee2c 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
> @@ -50,6 +50,9 @@ void dpcd_write_rx_power_ctrl(struct dc_link *link, bool on)
>  	if (link->sync_lt_in_progress)
>  		return;
>  
> +	if (!on && link->apple_5k_peer)
> +		return;
> +
>  	core_link_write_dpcd(link, DP_SET_POWER, &state,
>  						 sizeof(state));
>  

