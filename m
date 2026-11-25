Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EE7606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 22:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q5OQSpME
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6E84112007;
	Wed, 25 Nov 2026 22:54:19 +0000 (UTC)
Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D925C112007
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:54:12 +0000 (UTC)
Received: by mail-wm2-f9.google.com with SMTP id
 5b1f17b1804b1-4ae596853deso13151495e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 14:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795647251; x=1796252051; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qwFPqDuhjt+AHduHGsxSJnIXxJCHI3I68/jYa7+86Ts=;
 b=Q5OQSpME5BgJ/6zwg/bIDL4VTrmoXsplCOgzxp707PxR2Rb/h60w13b3osrOebJYD6
 T/Gesr4bGFzMoRKWqCkqFjBIm7X7IrX7FC/fetbBtCFO5vqWssvkFN2LkdaeH8YEhi10
 9Y9+mJmhwUY7VcMyyIMDobeIEyYvps2uZbRLPlIA6tlkUbQQCd8x8trcTuG4+9pLp8qn
 10ctpJrLgq0Qrxjjx1KBev2xFYKF07nYv8xGFHGyZB4tML9GS/f7gootPR9MtGlBrBgq
 PenGymB3mP3uS40+nCPP6NTWsKMVhdE/Qjz5ofIjVpBd2reRcXKbugGHJ+xsnBPN3mwL
 oseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795647251; x=1796252051;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qwFPqDuhjt+AHduHGsxSJnIXxJCHI3I68/jYa7+86Ts=;
 b=mIlXMnb4/xwLa5bPr8mfUu7R98pMrlJKR5HKyufWvjx5iTQwglMSiudI1jZh292n63
 W+IVItuYRxcn9ktAkiFVsLx8uri7/0iCiOXtC1PbUi3K9VcskGQ+xrbQB3oNeAJCmyAE
 eiz13UkSZ0l/qkk6LsbY2le1bNjd46Dq59YMb4isRMV/W7srVLwaZHvu0OW3I04ykuu8
 l5pJNq5rwBG9HyFkB1FJ5e+TUnZ9oiko2DC7WZkd/AwW0/4+JAanwuzzpET8jxCtnWV/
 OaofDRwsCah+bE6VslMtPkODwbFueicu4DrVrMMKYq3yN2kpWgh7Ljh1eBa+mH/P8qaK
 lu2Q==
X-Forwarded-Encrypted: i=1;
 AL+hErH+8P6T70j72NTLZ9VrKXEQXN8wOr1TE5Rv59IcYXJHGKo+odKAgXkw0nr1U5one0UBS4k7JGoZIx0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/6/GCRhtrepqwb2ltHzChxCBXqTBiA8i5R6IDxT4G7Uz09oVqv
 m0pYP4fQ+fcbL/MMs493N92ToPl0oYKm5/LNIxLnrApu6XNpmbyCeRu0
X-Gm-Gg: AZFdTZfftvZVZd1TrV8GXfO+1ZUHB6irrEY/Ay+pTtxit31VMP6gtBaB7zpLEnt1aKA
 NfYxMzLJL1wY7TsAHT0rToYjq4W9NJhsxbOSHewWuxXOpzekqpge+6XYwiQJyj8i9zoRSevcZro
 145r7jX2TScJL/+Skg+hgmibdxj4WQ/MvcidQpx9YGEAT9lYU0Wm+QIRfU0Y+mRGNHgIGbDBWFK
 +nd6xkfq8mFk9PiA11kmHIYzfQPn3VURdlvxKGmfB+dNGbmhbmCVLJT1ETZrdmtRL1B11vcJqkf
 1da2HIupBjK/uxm0LcIWo0GCuSYbwvkdQEIxj7QzmFX9cCRbezQ8dHr/TMD+Kxl0CRRchM1vE73
 /G36n9iJd87P/lRCt6i+ydB9lGUWTDdfVPgnWnCDityhz+8fUSPaIEyVT5HJ2SE7BKgxxswNea/
 SAX0/dYcUznAspBu/L2sxiu36qBIlq90jL+wWG2QA3+6/QtIbvpuFXSn5tyCzYA24oLyXS60ooh
 p2oMNWpmPo92/5w3hhpaaxFG/4EbdEuqEJra/hD4Z/XCihamAZzIzkU9Wh7AoJZq6GmjEjvrFBp
 OIFqAqKlb4hEKDxQlCVVg+Z2rZQgZ4hnwlQL
X-Received: by 2002:a05:600c:64c8:b0:4a0:1c0e:b057 with SMTP id
 5b1f17b1804b1-4bb887e2380mr359278035e9.4.1795647250854; 
 Wed, 25 Nov 2026 14:54:10 -0800 (PST)
Received: from [192.168.1.11] ([31.94.68.154])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b7515sm755939345e9.13.2026.11.25.14.54.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 14:54:10 -0800 (PST)
Message-ID: <e25c68b6-d67a-4d5e-86d2-724ee2407f0c@gmail.com>
Date: Wed, 25 Nov 2026 22:54:08 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] drm/amd/display: unlock secondary tile on Apple
 4K/5K iMac panels
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <6c7b9cdf-9562-4954-9f66-444745e430bb@gmail.com>
 <SJ0PR12MB6830376D484FDC67FA87E10EF7432@SJ0PR12MB6830.namprd12.prod.outlook.com>
Content-Language: en-US
From: Richard Lane <richardlanedev@gmail.com>
In-Reply-To: <SJ0PR12MB6830376D484FDC67FA87E10EF7432@SJ0PR12MB6830.namprd12.prod.outlook.com>
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 25/11/2026 15:41, Deucher, Alexander wrote:
> Public
> 
>> -----Original Message-----
>> From: Richard Lane <richardlanedev@gmail.com>
>> Sent: Tuesday, November 24, 2026 8:04 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; David Airlie <airlied@gmail.com>; Simona
>> Vetter <simona@ffwll.ch>; Wentland, Harry <Harry.Wentland@amd.com>; Li,
>> Sun peng (Leo) <Sunpeng.Li@amd.com>; Rodrigo Siqueira
>> <siqueira@igalia.com>; Limonciello, Mario <Mario.Limonciello@amd.com>;
>> dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; Richard Lane
>> <richardlanedev@gmail.com>
>> Subject: [PATCH v3 2/3] drm/amd/display: unlock secondary tile on Apple 4K/5K
>> iMac panels
>>
>> Apple 21.5" 4K (iMac18,2, iMac19,2) and 27" 5K (iMac15,1, iMac17,1,
>> iMac18,3, Polaris-based iMac19,1) Retina iMacs expose their internal panel as
>> a 2x1 tiled display over an eDP root link and a secondary DP link. At boot, the
>> panel TCON operates in single-pipe mode and holds the secondary DP link's
>> HPD line low until unlocked via DPCD registers.
>>
>> Enable native tiled detection and link training for DCE < 12 Apple 4K/5K Retina
>> iMac panels:
>> - Latch the root eDP link via DPCD 0x4F1 prior to reading its EDID in
>>   dm_helpers_read_local_edid() on Apple hardware (DCE < 12) so the
>>   TCON exposes its full DisplayID tile properties even when Apple and
>>   OpenCore Legacy Patcher (OCLP) EFI folders are absent.
>> - Point the secondary DP dc_link to the root eDP dc_link
>>   (apple_tcon_peer) during EDID quirk matching on DCE < 12 iMac15,1
>>   (AE01/02), iMac17,1 (AE05/06), iMac18,3 (AE11/12), iMac18,2/19,2
>>   (AE19/1A), and Polaris-based iMac19,1 (AE25/26), checking
>>   connector_signal since panel IDs can flip across the two links after
>>   S3 wake. DCE >= 12 support for Vega-based iMac19,1, iMacPro1,1, and
>>   iMac20,x is documented as TODO.
>> - Avoid falling back to DVI and latch the secondary tile via DPCD 0x4F1
>>   on the root eDP link when probing the secondary link, allowing the
>>   secondary link to read its EDID and populate DRM's DisplayID tile
>>   properties (has_tile, tile_group, and tile_is_single_monitor).
>> - Write the 3-byte Boot Camp source table (0x04, 0x1d, 0x03) to DPCD
>>   0x310 in dpcd_set_source_specific_data() to unlock the secondary tile.
>> - Prevent the secondary tile from entering DP_SET_POWER D3, which causes
>>   the TCON to drop HPD and stop responding to AUX transactions.
> 
> Does the display still blank properly without this?
> 
> Alex
> 

I have just tested and the display still blanks, and recovers from suspend
properly without needing to prevent the secondary tile from entering
DP_SET_POWER D3. Hence this patch hunk can be dropped (no modification is
therefore needed to link_dp_phy.c):
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/
protocols/link_dp_phy.c
index 49521ac4b0e8..f051fe6c060c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
@@ -50,6 +50,9 @@ void dpcd_write_rx_power_ctrl(struct dc_link *link, bool on)
 	if (link->sync_lt_in_progress)
 		return;
 
+	if (!on && link->apple_imac_peer)
+		return;
+
 	core_link_write_dpcd(link, DP_SET_POWER, &state,
 						 sizeof(state));

Should I submit a v4 patch with this change?

Richard

>> - Unlatch both tiles (0x4F1) and clear DP_SOURCE_TABLE_REVISION (0x310)
>>   and DP_EDP_CONFIGURATION_SET (0x10A) in
>> amdgpu_dm_apple_tcon_unlatch()
>>   during dm_suspend() so the TCON returns to single-pipe mode for the
>>   EFI boot screen across reboots.
>>
>> Signed-off-by: Richard Lane <richardlanedev@gmail.com>
>> ---
>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++
>> .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 34
>> +++++++++++++++++++
>>  drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
>>  .../drm/amd/display/dc/link/link_detection.c  |  7 +++-
>>  .../dc/link/protocols/link_dp_capability.c    |  4 +++
>>  .../display/dc/link/protocols/link_dp_phy.c   |  3 ++
>>  6 files changed, 67 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 3d2201285888..6275a585593c 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -1610,6 +1610,23 @@ STATIC_IFN_KUNIT void
>> dm_destroy_cached_state(struct amdgpu_device *adev)  }
>> EXPORT_IF_KUNIT(dm_destroy_cached_state);
>>
>> +static void amdgpu_dm_apple_imac_unlatch(struct dc *dc) {
>> +     const u8 zeros[3] = { 0 };
>> +
>> +     for (int i = 0; i < dc->link_count; i++) {
>> +             struct dc_link *link = dc->links[i];
>> +
>> +             if (link->apple_imac_peer) {
>> +                     core_link_write_dpcd(link,
>> DP_SOURCE_TABLE_REVISION, zeros, 3);
>> +                     core_link_write_dpcd(link,
>> DP_EDP_CONFIGURATION_SET, zeros, 1);
>> +                     core_link_write_dpcd(link, 0x4F1, zeros, 1);
>> +                     core_link_write_dpcd(link->apple_imac_peer, 0x4F1,
>> zeros, 1);
>> +                     break;
>> +             }
>> +     }
>> +}
>> +
>>  static int dm_suspend(struct amdgpu_ip_block *ip_block)  {
>>       struct amdgpu_device *adev = ip_block->adev; @@ -1677,6 +1694,8
>> @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
>>
>>       amdgpu_dm_hpd_rx_irq_work_suspend(dm);
>>
>> +     amdgpu_dm_apple_imac_unlatch(dm->dc);
>> +
>>       dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
>>
>>       if (dm->dc->caps.ips_support && adev->in_s0ix) diff --git
>> a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> index 6192c0f6086d..e30450415462 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> @@ -29,6 +29,7 @@
>>  #include <linux/string.h>
>>  #include <linux/acpi.h>
>>  #include <linux/i2c.h>
>> +#include <linux/dmi.h>
>>
>>  #include <drm/drm_atomic.h>
>>  #include <drm/drm_probe_helper.h>
>> @@ -173,6 +174,30 @@ STATIC_IFN_KUNIT void apply_edid_quirks(struct
>> dc_link *link, struct edid *edid,
>>               drm_dbg_driver(dev, "Force FreeSync min to 60 Hz on panel id
>> %X\n", panel_id);
>>               edid_caps->panel_patch.force_freesync_min_hz = 60;
>>               break;
>> +     /*
>> +      * Workaround for Apple 21.5" 4K and 27" 5K iMacs which expose a 2x1
>> +      * tiled internal panel over an eDP root link and a secondary DP link.
>> +      * Point the secondary link to the root link to latch/unlatch the TCON
>> +      * via DPCD, checking connector_signal as panel IDs can flip after wake.
>> +      * IDs (Root/Tile): iMac15,1 (AE01/02), iMac17,1 (AE05/06),
>> +      * iMac18,3 (AE11/12), iMac18,2/19,2 (AE19/1A), iMac19,1 (AE25/26);
>> +      * TODO (DCE >= 12): iMac19,1/19,2 Vega, iMacPro1,1 (AE1D/1E),
>> iMac20,x (AE31/32, AE35/36).
>> +      */
>> +     case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE01):
>> +     case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE02):
>> +     case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE05):
>> +     case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE06):
>> +     case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE11):
>> +     case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE12):
>> +     case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE19):
>> +     case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE1A):
>> +     case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE25):
>> +     case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE26):
>> +             if (link->connector_signal == SIGNAL_TYPE_EDP &&
>> +                 link->ctx->dce_version < DCE_VERSION_12_0 &&
>> +                 (link->link_index ^ 1) < link->dc->link_count)
>> +                     link->dc->links[link->link_index ^ 1]->apple_imac_peer
>> = link;
>> +             break;
>>       default:
>>               return;
>>       }
>> @@ -1299,6 +1324,15 @@ enum dc_edid_status dm_helpers_read_local_edid(
>>       if (link->dc->hwss.prepare_ddc)
>>               link->dc->hwss.prepare_ddc(link);
>>
>> +     if (link->connector_signal == SIGNAL_TYPE_EDP &&
>> +         link->ctx->dce_version < DCE_VERSION_12_0 &&
>> +         dmi_match(DMI_SYS_VENDOR, "Apple Inc.")) {
>> +             const char *product =
>> dmi_get_system_info(DMI_PRODUCT_NAME);
>> +
>> +             if (product && str_has_prefix(product, "iMac"))
>> +                     dm_helpers_dp_write_dpcd(ctx, link, 0x4F1, &(const
>> uint8_t){1}, 1);
>> +     }
>> +
>>       dm_helpers_wait_for_edid_ready(link, ddc);
>>
>>       /* some dongles read edid incorrectly the first time, diff --git
>> a/drivers/gpu/drm/amd/display/dc/dc.h
>> b/drivers/gpu/drm/amd/display/dc/dc.h
>> index 8471dcfe24fd..bd3857267331 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dc.h
>> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
>> @@ -2018,6 +2018,7 @@ struct dc_scratch_space {
>>       bool skip_implict_edp_power_control;
>>       bool forced_psr_active;
>>       enum backlight_control_type backlight_control_type;
>> +     struct dc_link *apple_imac_peer;
>>  };
>>
>>  struct dc {
>> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>> b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>> index 5b257f003f13..02c6e5874c16 100644
>> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>> @@ -218,7 +218,7 @@ static enum signal_type
>> link_detect_sink_signal_type(struct dc_link *link,
>>                        * we assume signal is DVI; it could be corrected
>>                        * to HDMI after dongle detection
>>                        */
>> -                     if (!dm_helpers_is_dp_sink_present(link))
>> +                     if (!link->apple_imac_peer &&
>> !dm_helpers_is_dp_sink_present(link))
>>                               result = SIGNAL_TYPE_DVI_SINGLE_LINK;
>>               }
>>               break;
>> @@ -1651,6 +1651,11 @@ bool link_detect_connection_type(struct dc_link
>> *link, enum dc_connection_type *
>>               }
>>       }
>>
>> +     if (*type == dc_connection_none && link->apple_imac_peer) {
>> +             core_link_write_dpcd(link->apple_imac_peer, 0x4F1, &(const
>> uint8_t){1}, 1);
>> +             *type = dc_connection_single;
>> +     }
>> +
>>       return true;
>>  }
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
>> b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
>> index c487c5b87dfd..74954702c5a9 100644
>> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
>> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
>> @@ -1496,6 +1496,10 @@ void dpcd_set_source_specific_data(struct dc_link
>> *link)
>>                               link->dc->vendor_signature.data.raw,
>>                               sizeof(link->dc->vendor_signature.data.raw));
>>       }
>> +
>> +     if (link->apple_imac_peer)
>> +             core_link_write_dpcd(link, DP_SOURCE_TABLE_REVISION,
>> +                                  (const uint8_t[]){0x04, 0x1d, 0x03}, 3);
>>  }
>>
>>  void dpcd_write_cable_id_to_dprx(struct dc_link *link) diff --git
>> a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
>> b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
>> index 49521ac4b0e8..f051fe6c060c 100644
>> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
>> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
>> @@ -50,6 +50,9 @@ void dpcd_write_rx_power_ctrl(struct dc_link *link, bool
>> on)
>>       if (link->sync_lt_in_progress)
>>               return;
>>
>> +     if (!on && link->apple_imac_peer)
>> +             return;
>> +
>>       core_link_write_dpcd(link, DP_SET_POWER, &state,
>>                                                sizeof(state));
>>
>> --
>> 2.55.0

