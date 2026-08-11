Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18CAC5B569
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C066D10E291;
	Tue, 11 Aug 2026 06:44:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XCAvdIU6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5BF510E291
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 06:44:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A2A06001D;
 Tue, 11 Aug 2026 06:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9948A1F000E9;
 Tue, 11 Aug 2026 06:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786430660;
 bh=8CV9C0fteJuw/LuwvISkkiA3Pz1oEu9xaIlcJm9yiDM=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=XCAvdIU6359mhm5OSz0Qo6JbtwOuioQB4k9xxkVrjGyVMdlRefefIH3rmPS4arkay
 XuK1vyki3FVvFTXYpo1RxyUyVhkx5v2S7CD9PAfeNfFpFo1LVSmIfJQX1L17OPtB2G
 tfiPqRBLuMsEXUTBmA1nkqRX42CjC98Lwto2kJb6fED0BY6Kn9rP3B3WZxnstIfC81
 7UEiXlIxOfcx2WOcD6/5m+HmW+2Spd5wCs0f/riNZLGYfdEDLnh8/ipJ8hf2Cs9DQO
 533TaxnmKR546UDh9WH0mHYdoeJC0xQTZ1Ht6Sck8uMTPE2qc1Rwb0hKP0WJRQZP5A
 jMcU2BXtubH/g==
Message-ID: <70373503-71e2-4646-9246-d3b5d8360cec@kernel.org>
Date: Tue, 11 Aug 2026 08:44:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v9 0/5] Add SCDC information to connector debugfs
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Daniel Stone <daniel@fooishbar.org>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260724-scdc-link-health-v9-0-bdda406d016d@collabora.com>
Content-Language: en-US, nl
In-Reply-To: <20260724-scdc-link-health-v9-0-bdda406d016d@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 24/07/2026 16:22, Nicolas Frattaroli wrote:
> HDMI uses the DDC I2C bus for communicating various bits of link status
> out of band with the actual HDMI video signal. This information can be
> useful for debugging issues like questionable cables sabotaged by feline
> teeth, Enthusiast Grade cables made of cow fencing wire, and other such
> problems that ruin one's media viewing plans.
> 
> Consequently, this series exposes various bits of pertinent information
> from the SCDC protocol in an HDMI connector's debugfs. To continually
> poll the link status, userspace can poll the debugfs file.

Tested-by: Hans Verkuil <hverkuil+cisco@kernel.org>

The contents of scdc_status is parsed correctly by edid-decode, so I'm happy :-)

Regards,

	Hans

> 
> ---
> Changes in v9:
> - Unlock mode_config.mutex on disconnected connector early exit
> - Calculate and print Reed-Solomon error corrections counter on != 4
>   lane FRL as well. Technically a functional change to an already
>   reviewed patch, but I kept the R-b because it's so minor.
> - Link to v8: https://patch.msgid.link/20260722-scdc-link-health-v8-0-cd1dacbb85d9@collabora.com
> 
> Changes in v8:
> - Acquire mode_config mutex in an interruptible way during
>   scdc_status_show to avoid racing connector state
> - Remove scdc_debugfs_priv, use connector as debugfs entry priv instead
> - Allocate and free state in scdc_status_show, since it doesn't need to
>   persist across debugfs reads
> - Check for NULL ddc in drm_scdc_read_state in the unlikely event an
>   EDID with the SCDC flag was forced on a connector with no DDC
> - Note: drm_connector_get() is omitted from drm_scdc_debugfs_init
>   because drm_scdc_debugfs_init is called on connector construction and
>   the debugfs is removed on connector destruction. Adding a redundant
>   reference increase here would necessitate introducing a destruction
>   callback to mirror the debugfs_init connector op for the sole purpose
>   of decreasing the counter again.
> - Link to v7: https://patch.msgid.link/20260721-scdc-link-health-v7-0-92df1b6ad5fc@collabora.com
> 
> Changes in v7:
> - Move HDMI debugfs registration to new state helper, fix up all users
>   (sun4i, vc4, bridge)
> - Register scdc debugfs in new hdmi debugfs helper
> - Link to v6: https://patch.msgid.link/20260611-scdc-link-health-v6-0-6307875a6b5e@collabora.com
> 
> Changes in v6:
> - Fix off-by-one error in drm_scdc_read_state
> - Link to v5: https://patch.msgid.link/20260604-scdc-link-health-v5-0-11173b0ac3de@collabora.com
> 
> Changes in v5:
> - Read all SCDC data regardless of update flags
> - Dump SCDC data as hex before the human-readable output. It's separated
>   with "\n----------------\n\n".
> - No longer write 0 to read-only registers
> - Add Reed-Solomon Corrections counter parsing
> - Parsing has been kept. A desire was expressed to get this data without
>   any external userspace tooling, and the kernel will need to parse it
>   eventually anyway to set the link status.
> - Functions have been made static as of right now, since external users
>   may do another pass over the function signatures anyway.
> - Link to v4: https://patch.msgid.link/20260527-scdc-link-health-v4-0-622ea40a1f59@collabora.com
> 
> Changes in v4:
> - Don't use C struct bitfields for parsing status flags. Switch to
>   bitwise AND for boolean flags, and FIELD_GET for multi-bit values.
> - Drop the superfluous !! and parens
> - Drop the __pure attributes on static functions
> - Initialise stack local arrays with {}, not { 0 }.
> - I've kept the print macros and %-30s format. Reason being that I don't
>   want to repeat the format specifier and str_yes_no(foo) a bunch, and I
>   like the %-30s format because it means all values are aligned with the
>   value of the longest field, which is 30 chars long.
> - Link to v3: https://patch.msgid.link/20260526-scdc-link-health-v3-0-59e4a4aaead1@collabora.com
> 
> Changes in v3:
> - Add patch to change return type of drm_scdc_read/write.
> - Rework error counter reading to duplicate less code.
> - Also check lane 3 counter valid flag when reading its error counter.
> - Use memset to clear buf for error counters, rather than doing it in
>   the loop.
> - Make read_error_counters not accept 0 as num_lanes; fix it up in the
>   caller instead.
> - Link to v2: https://patch.msgid.link/20260520-scdc-link-health-v2-0-511af18cd64b@collabora.com
> 
> Changes in v2:
> - Add HDMI 2.1 SCDC status reporting
> - Link to v1: https://patch.msgid.link/20260415-scdc-link-health-v1-0-8e731e88eaf0@collabora.com
> 
> To: Jani Nikula <jani.nikula@linux.intel.com>
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> To: Andrzej Hajda <andrzej.hajda@intel.com>
> To: Neil Armstrong <neil.armstrong@linaro.org>
> To: Robert Foss <rfoss@kernel.org>
> To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> To: Jonas Karlman <jonas@kwiboo.se>
> To: Jernej Skrabec <jernej.skrabec@gmail.com>
> To: Luca Ceresoli <luca.ceresoli@bootlin.com>
> To: Daniel Stone <daniel@fooishbar.org>
> To: Hans Verkuil <hverkuil+cisco@kernel.org>
> To: Chen-Yu Tsai <wens@kernel.org>
> To: Samuel Holland <samuel@sholland.org>
> To: Dave Stevenson <dave.stevenson@raspberrypi.com>
> To: Maíra Canal <mcanal@igalia.com>
> To: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kernel@collabora.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-sunxi@lists.linux.dev
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> ---
> Nicolas Frattaroli (5):
>       drm/scdc-helper: Don't use ssize_t return type for scdc_read/write
>       drm/scdc-helper: Add scdc_status debugfs entry
>       drm/scdc-helper: Implement parsing and printing HDMI 2.1 fields
>       drm/debugfs: Move HDMI debugfs registration to state helper
>       drm/display: hdmi-state-helper: Init SCDC debugfs for HDMI
> 
>  drivers/gpu/drm/display/drm_bridge_connector.c  |   3 +
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 156 +++++++++++++
>  drivers/gpu/drm/display/drm_scdc_helper.c       | 289 +++++++++++++++++++++++-
>  drivers/gpu/drm/drm_debugfs.c                   | 157 -------------
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c          |   1 +
>  drivers/gpu/drm/vc4/vc4_hdmi.c                  |   1 +
>  include/drm/display/drm_hdmi_state_helper.h     |   3 +
>  include/drm/display/drm_scdc.h                  |  21 +-
>  include/drm/display/drm_scdc_helper.h           | 103 ++++++++-
>  9 files changed, 568 insertions(+), 166 deletions(-)
> ---
> base-commit: b747a63003130bef1a3d5d6ba97c94d0cee36f55
> change-id: 20260413-scdc-link-health-89326013d96c
> 
> Best regards,
> --  
> Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 

