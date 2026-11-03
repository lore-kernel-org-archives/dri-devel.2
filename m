Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161976082BFA
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kt5QvJTW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FC3A10E7F8;
	Tue,  3 Nov 2026 15:58:30 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012065.outbound.protection.outlook.com
 [40.107.200.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE7B110E640;
 Tue,  3 Nov 2026 15:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vrg0jzHcYqVYPYC/0yPwzGWnhAO/DCdWrFYIw1Crckspcs4glY+Gs10lDzUVVLAprwG2J+B6H6U+xVaCGMz0lYaWbmATo6+FotLCwy5yzfNkSoEhdHlumSXqVv6FrgSwFnCbHIRmPXGGCeHQeW4wSlGJ5Ruv4b4iiINdaVAiwc5v1I3mArWbeagfkDjf5VZhm/TKX4Ixd8ZW3mrk5MqrPJdZA3MKQj//ANl6aDcBNly8rCthvFaqy93FEx/PfPBjfX/HGUy1BmgBT3lwUd1B5ZoxNx+P0nL/x6F6WbuYqYYVLQWT7qIhz/gyVDzsmLhaci6ktoQAhpoQ+nRHDyJcaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZAeF5qCrHnvCAjc+m9kuFmGRSwKNVr/a8T5CO/bX2g=;
 b=HPw/1OsfyC/1+TsfAfbcue8xXIjpTJokAcZRi9jvJAnhCVLPFJBA1Clo2pZ6coMau9oWmxx2vxJ4NhWIZsdviVM+rG4q5fLzrudtHaW3+qucK9ZxMvD7TOk/CgYFTS4jTPW+daI+CoQj2Qtu4cfsvycEEbyAnTNO5Q7UENTpktcfzmZ3gN9gCCyDpAR6hi2+FaKhevqBQzZ1/n6W3o4LqdE61naP4+NBKThubzI5ItRjAiLc1rQjrrKP4YnT1WR8ZcbutO6e7/h7iEse2fpTqozSNKC2sYILFC/rwuCj56R7gyzT57akLyd550yQ0fRDmNkEAi9qLFDspyXVs+MC3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZAeF5qCrHnvCAjc+m9kuFmGRSwKNVr/a8T5CO/bX2g=;
 b=kt5QvJTWHDHlJwZlGTmuKQqrUdFwowCmZMRDe6JaLh891Pn6uWSKFAg2A588S0ZPq7hLmMeJdubJckRjWeAuXRaU+xsUAZK01fOMX0mhvcRC+6cTrqi+5Nge9XM2Uhhig6J35l516Rbzu838RM0lEWE4rLZlLa4YhhveY4NBnO4=
Received: from DS7P220CA0126.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::10) by
 CH3PR12MB8547.namprd12.prod.outlook.com (2603:10b6:610:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 15:58:13 +0000
Received: from BN3PEPF00022BC2.namprd05.prod.outlook.com
 (2603:10b6:8:25f:cafe::31) by DS7P220CA0126.outlook.office365.com
 (2603:10b6:8:25f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 15:58:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BC2.mail.protection.outlook.com (10.167.248.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 15:58:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 09:58:08 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 09:58:08 -0600
Received: from [10.254.93.75] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 09:58:07 -0600
Message-ID: <139b2703-53a7-4ff3-b6ad-46b047f0f0c6@amd.com>
Date: Tue, 3 Nov 2026 10:58:06 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/15] drm/amd: add luminance property support
To: "Mario Limonciello (AMD)" <superm1@kernel.org>, Maxime Ripard
 <mripard@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Jani Nikula
 <jani.nikula@linux.intel.com>, Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>, Rodrigo Siqueira
 <siqueira@igalia.com>
CC: Xaver Hugl <xaver.hugl@gmail.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
References: <20261102-superm1-backlight-property-v10-0-b2a6f24131f5@kernel.org>
 <20261102-superm1-backlight-property-v10-3-b2a6f24131f5@kernel.org>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20261102-superm1-backlight-property-v10-3-b2a6f24131f5@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC2:EE_|CH3PR12MB8547:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a864fe3-708e-47bb-1ca7-08df39c34299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|42112799006|7416014|23010399003|376014|1800799024|6133799003|10067099003|22082099003|261102123227099003|18002099003|261102130727099003|921020|56012099006|4143699003|261022105027099003|261021121427099003|261021123027099003|261022075727099003|261026121527099003|261009223027099003|11063799006|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: +FrN461jjYdk+bffRUMrWEEj9qdnUfxOFXNpqPHcH5WARsQquovWWCBt3bDKBe4ZQ37pDRcKyzULc+ieb38XH9hjl/WmB6dRFF+02Ep81W7fcmBws+EolvD/OBhkpdZui37EFa3H2wVcY+fSnNjR4JX4fXTtAjYn4X+BcnYb6eRNp6LwV4y6yDPjGxtmhnsxN35qvNKHYp/3N9ce5TxwOxUOk3PatjIROld16OqRxsdfTJDGAuBaIU17YN3V797ABTPo2WNw39uoi2oExstGozsSRA3AEoZt5RkAOPskFd3XYIViHzq+PkCIfzGPp5HhwX1gQMTd/BG1oHYHgRodkvipTaRWKt30WiaSR6yGS7gKJtdEXkJMYJbDWBGF419Uw63SR88n3icrgSIBmsq0INrdGvfl9vzPmHPRF77CBDuTR+dWCXBt1XCaVceETwdf56jX8oAU3m9pwEbdLEMq3NiVf/M7l7vDU8Kf7aIqbwVIhSAnMts31lTUn4zvFgZ42+M1mKdpFPH6vcsrq0umD5wg/NJ/bMoqKxLJ2bLSvpONMg4dR3Od/V2QXtvPGGxvGdp0cqJlfZXyd4hvJKCp2Q/X55Z6wK7mGFHv/5UTQfBEJyDQEZMXWcRqRvtItfzVQUxE1hDsYBwju8Hk4lcYoH1OTnYvaEXMOktqiOX0h2FYelqFb/5f+scvyYi2Im6O+zcaN5skxFo01ciD/pFYUtgxmQ/8Un4R1mvTNE08ErP7z+dSrhuaeTB41buoj9Nl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(42112799006)(7416014)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(261102130727099003)(921020)(56012099006)(4143699003)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(261026121527099003)(261009223027099003)(11063799006)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R3zPNGMb8riSVb/TGeVk9SIkQTP0rKcbYDHjmtyP/phqfnT9DV1rKgcMI3lHGEsHKy2M4v1Q6LQklnlyZiaFoK07/uVwINNY4J58bNUXdpG3qNZza4/Rvg1D3e4ryWFsIM+McSAL1F7LxzH4VL8fEo3KQvB3nMAuWpj22vaPwMUjoXQ7UNT5X7clvhTaHDyUinKlGKVBDxg9rFoe1zj/1ZC7ga7/+4lyHCLj2n/yowGVed7vINBXlAAEnZaExDu8jP4FHE8OwbAs3wFgFrvGUSQykRE4YTIOr8yG0XuYkV+rOiLb1RJ/dW0yLL3FnQVhqR14T+qvXMhxT04FzZDXS9GbQEPoMLoJtZsfBplEa6f5rSRsQx+JZn4jn58wrNLgfYlfJw7s/wxrepof6fpM8no6Z9MV9xaXc6HWT81cV3rn3V+WAjdt9Fp4VtWu63Yp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 15:58:10.8182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a864fe3-708e-47bb-1ca7-08df39c34299
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8547
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026-11-02 11:49, Mario Limonciello (AMD) wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Expose the DRM LUMINANCE connector property for internal panels when
> CONFIG_DRM_LUMINANCE is enabled. Keep registering the existing backlight
> class device otherwise, preserving its userspace ABI.
> 
> Use the existing brightness scaling and programming paths from connector
> helper callbacks in both Display Core and legacy display. Apply atomic
> luminance after the display pipeline is enabled so changes made while a
> connector is inactive take effect on the next enable.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Kconfig                 |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     | 20 +++++++++++
>  drivers/gpu/drm/amd/amdgpu/atombios_encoders.c     | 17 +++++++--
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 22 +++++++-----
>  .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    | 42 ++++++++++++++++++++--
>  .../amd/display/amdgpu_dm/amdgpu_dm_backlight.h    |  2 ++
>  .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |  7 ++--
>  7 files changed, 96 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
> index 50305630f5335..7a6a049aa6e90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -20,7 +20,7 @@ config DRM_AMDGPU
>  	select I2C
>  	select I2C_ALGOBIT
>  	select CRC16
> -	select BACKLIGHT_CLASS_DEVICE
> +	select BACKLIGHT_CLASS_DEVICE if !DRM_LUMINANCE
>  	select INTERVAL_TREE
>  	select DRM_BUDDY
>  	select DRM_SUBALLOC_HELPER
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> index 92c98e999efe9..209a7a6c246db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> @@ -798,11 +798,31 @@ static int amdgpu_connector_set_lcd_property(struct drm_connector *connector,
>  	return 0;
>  }
>  
> +static void amdgpu_connector_set_luminance(const struct drm_connector_state *conn_state)
> +{
> +	struct drm_encoder *encoder =
> +		amdgpu_connector_best_single_encoder(conn_state->connector);
> +
> +	if (encoder)
> +		amdgpu_atombios_encoder_set_backlight_level(to_amdgpu_encoder(encoder),
> +							    conn_state->luminance);
> +}
> +
> +static void amdgpu_connector_disable_luminance(const struct drm_connector_state *conn_state)
> +{
> +	struct drm_encoder *encoder =
> +		amdgpu_connector_best_single_encoder(conn_state->connector);
> +
> +	if (encoder)
> +		amdgpu_atombios_encoder_set_backlight_level(to_amdgpu_encoder(encoder), 0);
> +}
>  
>  static const struct drm_connector_helper_funcs amdgpu_connector_lvds_helper_funcs = {
>  	.get_modes = amdgpu_connector_lvds_get_modes,
>  	.mode_valid = amdgpu_connector_lvds_mode_valid,
>  	.best_encoder = amdgpu_connector_best_single_encoder,
> +	.set_luminance = amdgpu_connector_set_luminance,
> +	.disable_luminance = amdgpu_connector_disable_luminance,
>  };
>  
>  static const struct drm_connector_funcs amdgpu_connector_lvds_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> index a1d05df0ac99b..dbff532ac1bcd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> @@ -191,6 +191,21 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
>  		goto register_acpi_backlight;
>  	}
>  
> +	dig = amdgpu_encoder->enc_priv;
> +	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
> +		unsigned int brightness;
> +
> +		brightness = amdgpu_atombios_encoder_get_backlight_level(amdgpu_encoder);
> +		if (drm_connector_attach_luminance_property(drm_connector, 0,
> +							    AMDGPU_MAX_BL_LEVEL,
> +							     brightness))
> +			return;
> +
> +		dig->backlight_level = brightness;
> +		dig->bl_dev = NULL;
> +		return;
> +	}
> +
>  	pdata = kmalloc_obj(struct amdgpu_backlight_privdata);
>  	if (!pdata) {
>  		DRM_ERROR("Memory allocation failed\n");
> @@ -211,7 +226,6 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
>  
>  	pdata->encoder = amdgpu_encoder;
>  
> -	dig = amdgpu_encoder->enc_priv;
>  	dig->bl_dev = bd;
>  
>  	bd->props.brightness = amdgpu_atombios_encoder_get_backlight_brightness(bd);
> @@ -2123,4 +2137,3 @@ amdgpu_atombios_encoder_get_dig_info(struct amdgpu_encoder *amdgpu_encoder)
>  
>  	return dig;
>  }
> -
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0ea45ab12119c..53ff9a55c3a8e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5191,9 +5191,12 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
>  		}
>  
>  		/* Skip any modesets/resets */
> -		if (!acrtc || drm_atomic_crtc_needs_modeset(new_crtc_state))
> +		if (!acrtc || !new_crtc_state ||
> +		    drm_atomic_crtc_needs_modeset(new_crtc_state))
>  			continue;
>  
> +		drm_connector_update_privacy_screen(new_con_state);
> +
>  		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
>  		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
>  
> @@ -5273,8 +5276,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
>  					    &stream_update);
>  		mutex_unlock(&dm->dc_lock);
>  		kfree(dummy_updates);
> -
> -		drm_connector_update_privacy_screen(new_con_state);
>  	}
>  
>  	/**
> @@ -5397,11 +5398,16 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
>  	/* Update audio instances for each connector. */
>  	amdgpu_dm_commit_audio(dev, state);
>  
> -	/* restore the backlight level */
> -	for (i = 0; i < dm->num_of_edps; i++) {
> -		if (dm->backlight_dev[i] &&
> -		    (dm->actual_brightness[i] != dm->brightness[i]))
> -			amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
> +	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
> +		/* Apply brightness after the display pipeline is enabled. */
> +		drm_atomic_helper_commit_luminance_enables(state);
> +	} else {
> +		/* Restore the legacy backlight level. */
> +		for (i = 0; i < dm->num_of_edps; i++) {
> +			if (dm->backlight_dev[i] &&
> +			    dm->actual_brightness[i] != dm->brightness[i])
> +				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
> +		}
>  	}
>  
>  	/*
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> index 0f664c658a127..0857354e7327e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> @@ -41,6 +41,7 @@
>  #include <linux/backlight.h>
>  #include <linux/minmax.h>
>  #include <linux/power_supply.h>
> +#include <drm/drm_connector.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_panel_quirks.h>
>  
> @@ -296,13 +297,17 @@ struct dc_stream_state *dm_find_stream_with_link(
>  	struct amdgpu_display_manager *dm,
>  	struct dc_link *link)
>  {
> -	struct dc_state *cur_dc_state = dm->dc->current_state;
> +	struct dc_state *cur_dc_state;
>  	struct dc_stream_state *stream = NULL;
>  	int i;
>  
> +	if (!dm || !dm->dc || !dm->dc->current_state || !link)
> +		return NULL;
> +
> +	cur_dc_state = dm->dc->current_state;
>  	for (i = 0; i < cur_dc_state->stream_count; i++) {
>  		stream = cur_dc_state->streams[i];
> -		if (stream->link == link)
> +		if (stream && stream->link == link)
>  			return stream;
>  	}
>  
> @@ -356,7 +361,7 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
>  
>  	dm->brightness[bl_idx] = user_brightness;
>  	/* update scratch register */
> -	if (bl_idx == 0)
> +	if (bl_idx == 0 && dm->adev && dm->adev->rmmio && dm->adev->bios_scratch_reg_offset)
>  		amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, dm->brightness[bl_idx]);
>  
>  	link = (struct dc_link *)dm->backlight_link[bl_idx];
> @@ -657,6 +662,10 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
>  {
>  	struct dc_link *link = aconnector->dc_link;
>  	int bl_idx = dm->num_of_edps;
> +	struct backlight_properties props = { 0 };
> +	struct amdgpu_dm_backlight_caps *caps;
> +	struct drm_connector *connector = &aconnector->base;
> +	int ret;
>  
>  	if (!(link->connector_signal & (SIGNAL_TYPE_EDP | SIGNAL_TYPE_LVDS)) ||
>  	    link->type == dc_connection_none)
> @@ -675,6 +684,19 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
>  
>  	amdgpu_dm_update_connector_ext_caps(aconnector);
>  
> +	caps = &dm->backlight_caps[bl_idx];
> +	amdgpu_dm_backlight_fill_props(caps, power_supply_is_system_supplied() > 0,
> +				       !(amdgpu_dc_debug_mask &
> +					 DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE),
> +				       &props);
> +	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
> +		unsigned int max = props.max_brightness;
> +		unsigned int value = props.brightness;
> +
> +		ret = drm_connector_attach_luminance_property(connector, 0, max, value);
> +		drm_WARN_ON(adev_to_drm(dm->adev), ret);
> +	}
> +
>  	/* Offer ABM property when user didn't turn off by module parameter.
>  	 * OLED panels are included to support CACP (Content Adaptive
>  	 * Contrast and Power) feature via set_abm_level.
> @@ -686,6 +708,20 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
>  }
>  EXPORT_IF_KUNIT(amdgpu_dm_setup_backlight_device);
>  
> +void amdgpu_dm_set_luminance(const struct drm_connector_state *state)
> +{
> +	struct amdgpu_dm_connector *aconnector =
> +		to_amdgpu_dm_connector(state->connector);
> +	struct amdgpu_display_manager *dm =
> +		&drm_to_adev(state->connector->dev)->dm;
> +
> +	if (aconnector->bl_idx < 0)
> +		return;
> +
> +	amdgpu_dm_backlight_set_level(dm, aconnector->bl_idx,
> +				      state->luminance);

Maybe gate this set behind a comparison with old_state->luminance != state->luminance?
Setting backlight today may trigger a self-refresh/IPS exit that won't re-enter untill
the next vblank disable. Would be good to avoid setting the same value if possible. 

> +}
> +
>  /**
>   * DOC: panel power savings
>   *
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
> index 891749322191c..859224cb37988 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
> @@ -33,6 +33,7 @@ struct dc_stream_state;
>  struct device;
>  struct device_attribute;
>  struct drm_connector;
> +struct drm_connector_state;
>  struct attribute_group;
>  
>  #define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
> @@ -47,6 +48,7 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
>  void amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector);
>  void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
>  			    struct amdgpu_dm_connector *aconnector);
> +void amdgpu_dm_set_luminance(const struct drm_connector_state *state);
>  void amdgpu_dm_update_connector_ext_caps(struct amdgpu_dm_connector *aconnector);
>  bool amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connector *aconnector);
>  
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index b498fc5fbb140..f2c2a2e730d3e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -1944,7 +1944,8 @@ STATIC_IFN_KUNIT void amdgpu_dm_connector_destroy(struct drm_connector *connecto
>  	}
>  
>  	if (aconnector->bl_idx != -1) {
> -		backlight_device_unregister(dm->backlight_dev[aconnector->bl_idx]);
> +		if (dm->backlight_dev[aconnector->bl_idx])
> +			backlight_device_unregister(dm->backlight_dev[aconnector->bl_idx]);
>  		dm->backlight_dev[aconnector->bl_idx] = NULL;
>  	}
>  
> @@ -2038,7 +2039,8 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
>  			return r;
>  	}
>  
> -	amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
> +	if (!IS_ENABLED(CONFIG_DRM_LUMINANCE))
> +		amdgpu_dm_register_backlight_device(amdgpu_dm_connector);

There are a few places that tries to restore backlight after gpu reset/modeset, depending on if dm->backlight_dev[i] exists.
I think in those places, we might need a conditional to use drm_atomic_helper_commit_luminance_enables if DRM_LUMINANCE.

- Leo

>  
>  	if ((connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort) ||
>  	    (connector->connector_type == DRM_MODE_CONNECTOR_eDP)) {
> @@ -2701,6 +2703,7 @@ amdgpu_dm_connector_helper_funcs = {
>  	.get_modes = get_modes,
>  	.mode_valid = amdgpu_dm_connector_mode_valid,
>  	.atomic_check = amdgpu_dm_connector_atomic_check,
> +	.set_luminance = amdgpu_dm_set_luminance,
>  };
>  
>  int amdgpu_dm_convert_dc_color_depth_into_bpc(enum dc_color_depth display_color_depth)
> 

