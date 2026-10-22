Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F2A606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ErH2ln6Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E96B911279C;
	Thu, 22 Oct 2026 16:18:14 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1744D10E44F;
 Thu, 22 Oct 2026 16:18:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBAbKjGFSzNcuea+V9aSlZsdk4vjnM4QjjvSU4JgfbtjTXxUmb0dFcHYAlMimDdTnWDHIexkor7xjUtz8OfGV1w4OIbhoy/4sk+nmfh3DJHRMdcNV7OyH9ioLWMsaMdSsVpxkEuZhXLu6FEqopqg3SFP1Dy2eV0atDg1OvRN3a5nAHMSKpjX1yWXKNooGu35IPBNhyHCj+neapqS1jWr7G4Qu0Oi21o6+8g68yMgm5OkS8huTKxVnzzsyjHfLlsaq0lJni6e4Q/xRgRe7CPy49iUeuAtOBjR3PQ2xzDMZn9biqmxPDm91YRDetlgY6v3so+8xijANXNkeyruF3FIzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgtE0QknxtD6UwBq5PrwOdCWrUZuVYlVIZhPVCURpX4=;
 b=sMkF6wziS6my8Xlk70M//3CSOH7gTYAbFHY6wCsHuIyMKE4x4HwnkMOK6QJSfQm/1/W7VfC4TUv2xsDP66ytDRKGuRQlRcUvbRv90pzgVoB59Uoy9bc889AJSVz5yR6ueCgzH4UjvW5TOU+pQY4PmLwMPyG6l6mdhmTcYiSuJz3LRlFQsSkklA3vvLtuXmOcb/bLbsbcfqcDtgOLb3fiJB5KY2IVVqLvzImUQt4t7VfT9lBUpl0qeWOmeNxbewfbHiYkpTC0Rju/LvqmUt160ICNpzcqoKBtzx7DbecNmV2umOHa9AUFiDv+5ghfbZH12ynvbpoG4F/jBhU06oGAWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgtE0QknxtD6UwBq5PrwOdCWrUZuVYlVIZhPVCURpX4=;
 b=ErH2ln6QGNw8tSj7mcECSWpJSYL1I/ggC/ONFL+i3KgWmHO1Kks6T1ZKAVhpGVEHYVNp8IuJehwk50D+cEK9KfHOif6YIV0Ji+HFNbway7nVW/dWKKAp+05v5vuRF059fH/3xGPSox+HatOEpaEQVrtAB+LskHEMt0cZ1LeayW8=
Received: from MN0PR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:52c::34)
 by CYXPR12MB9442.namprd12.prod.outlook.com (2603:10b6:930:e3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 16:18:00 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::3a) by MN0PR05CA0020.outlook.office365.com
 (2603:10b6:208:52c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Thu,
 22 Oct 2026 16:18:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 16:18:00 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 11:17:59 -0500
Received: from [10.254.92.151] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 22 Oct 2026 11:17:59 -0500
Message-ID: <aa3ee76c-11ce-40c6-9b80-f0b7518169de@amd.com>
Date: Thu, 22 Oct 2026 12:17:53 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 53/59] drm/amdgpu: dm: Convert to atomic_create_state
To: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Harry
 Wentland" <harry.wentland@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 <amd-gfx@lists.freedesktop.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
 <20261022-drm-no-more-connector-reset-v2-53-0b7e4e85b1e8@kernel.org>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-53-0b7e4e85b1e8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|CYXPR12MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: a8433e0f-594b-4046-6d43-08df30580aa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|42112799006|82310400026|36860700016|1800799024|376014|22082099003|18002099003|10067099003|261021123027099003|5023799004|11063799006|261021121427099003|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: rDBjnSDHuupcHnwp24kXIZjg0imNHT+etEPVokrlpgGpZAnrtKVaKYthlQ/8M4NdJ8N5ZjOJCtF6i+Eo9hEf3je5QrU/DerPFDfSi2r4kHrrUuO5MrAtyH3lu0uZpXaiOpgJH4l2BRu1GJ5rBGFzrmiAdINJZTf/mEbN4qQFcP1TFDVoT6O96nBSxBoIaaHOSpiSlfLOdXAHKtF2VnQ2Ml+S4WBSO8ClgGY8FCQ0QQS2SD3DNquzA5pyMEgDZtQ7NB6uvzX3AjmzgspPuMWVVzKzJrl2FEmoe822CFsWN5qj3bPoU43SAD8TWLYAtKenFBXsrEIRaAtTh963QNDu+Ek7bD9MweJt+Tg67NilmkWxQVRA5d96HphN9H+nUidbzKHIdUO7+wzn1p42HHi/v99uKcfqHO2mUgJMf3gOCKzTEnuBrAuDbwE82uQPitaoIFG5/Ddgd5g+giltVdhDcsOTztiLYJ1hyURRnxSEJk3rAG+F4Td5WFeWTnN7pwdCYk4He3v5CjJwhlRE31XIp9Q/iakF8c13uouBZz7kfxHePZBxMU+uorX4ncbyvK2QS0duqE4oWqxrtxVBGUdlPDJLzPN2oYTHlBzFFaN+Vy+7PwAEKuOKtXO5Y3OxuD9OSWaLG2QG8J8HD925JYe/EFuE1w3oosqMc94dLdxVeYwNSxhkVMjCoXo+/8cHOmLiNJ+r4oZ+LolgrONynJl7CA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(42112799006)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(261021123027099003)(5023799004)(11063799006)(261021121427099003)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mTI0uuIBChpcdklROSUP1ODItL7UzCygWM7hGFIjOmYxqYmSg23tqqhE2jXlQrMYMhZdyfDIXc0BgK1VSsrDPrT6SMQJBEZcwyGcvB5bTR2HsRhXhVTNXCH2ui15Vo/lypJsBO6NeAbx1VkPMGjguuB5QFehGks4ooc+4D1G79rWTj9+tJBvlF5lUqKLhfFIZqR+nLo5KV7vXx49509L4G5XrUcBF/w3/QxmZi+r14tZwI0du15OAGyhCDwYL0PLtuDrW4KCSwYGM5m66v2TUJgHdfJBqTSRIG4/LmvSgcaau+Qkqi1mLGdQRlc4igSUqGeqwDYbOE7jTf769AOs3YVrQUY2p4aHf94KX9dvkB9cGwk+bfyKQirYX/aqK2HTud6Y4LKtGap+LIrFF42AKfya6jLF5VONx9BGbRKuxI7jZB+qZoJl13V4dicgiF6q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 16:18:00.3014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8433e0f-594b-4046-6d43-08df30580aa0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9442
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



On 2026-10-22 08:31, Maxime Ripard wrote:
> The amdgpu_dm connector reset implementation creates a custom state
> subclass, but only initializes a pristine state without resetting any
> hardware. This is equivalent to what atomic_create_state expects.
> Convert to it.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Leo Li <sunpeng.li@amd.com>

Thanks!

> ---
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Rodrigo Siqueira <siqueira@igalia.com>
> Cc: amd-gfx@lists.freedesktop.org
> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 32 ++++----
>  .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |  3 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 11 ++-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   | 17 +++-
>  .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     | 90 ++++++++++++++--------
>  5 files changed, 101 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 3a4e98b08ac1..e59595b5e39b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -1942,20 +1942,14 @@ STATIC_IFN_KUNIT void amdgpu_dm_connector_destroy(struct drm_connector *connecto
>  EXPORT_IF_KUNIT(amdgpu_dm_connector_destroy);
>  
> -void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
> +struct drm_connector_state *
> +amdgpu_dm_connector_atomic_create_state(struct drm_connector *connector)
>  {
> -	struct dm_connector_state *old_state =
> -		to_dm_connector_state(connector->state);
>  	struct dm_connector_state *state;
>  
>  	state = kzalloc_obj(*state);
>  	if (!state)
> -		return;
> +		return ERR_PTR(-ENOMEM);
>  
> -	if (connector->state)
> -		__drm_atomic_helper_connector_destroy_state(connector->state);
> -
> -	kfree(old_state);
> -
> -	__drm_atomic_helper_connector_reset(connector, &state->base);
> +	__drm_atomic_helper_connector_state_init(&state->base, connector);
>  
>  	state->scaling = RMX_OFF;
> @@ -1973,6 +1967,8 @@ void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
>  			state->abm_level = amdgpu_dm_abm_level;
>  	}
> +
> +	return &state->base;
>  }
> -EXPORT_IF_KUNIT(amdgpu_dm_connector_funcs_reset);
> +EXPORT_IF_KUNIT(amdgpu_dm_connector_atomic_create_state);
>  
>  struct drm_connector_state *
> @@ -2073,8 +2069,8 @@ EXPORT_IF_KUNIT(amdgpu_dm_connector_funcs_force);
>  
>  static const struct drm_connector_funcs amdgpu_dm_connector_funcs = {
> -	.reset = amdgpu_dm_connector_funcs_reset,
>  	.detect = amdgpu_dm_connector_detect,
>  	.fill_modes = drm_helper_probe_single_connector_modes,
>  	.destroy = amdgpu_dm_connector_destroy,
> +	.atomic_create_state = amdgpu_dm_connector_atomic_create_state,
>  	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> @@ -3200,6 +3196,14 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>  	 * Allocate some default initial connector state with our reset helper.
>  	 */
> -	if (aconnector->base.funcs->reset)
> -		aconnector->base.funcs->reset(&aconnector->base);
> +	if (!aconnector->base.state &&
> +	    aconnector->base.funcs->atomic_create_state) {
> +		struct drm_connector_state *conn_state;
> +
> +		conn_state = aconnector->base.funcs->atomic_create_state(&aconnector->base);
> +		if (IS_ERR(conn_state))
> +			return;
> +
> +		aconnector->base.state = conn_state;
> +	}
>  
>  	aconnector->connector_id = link_index;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
> index 79698deacf61..4a73fc607f38 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
> @@ -51,5 +51,6 @@ struct drm_edid;
>  struct drm_property;
>  
> -void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector);
> +struct drm_connector_state *
> +amdgpu_dm_connector_atomic_create_state(struct drm_connector *connector);
>  
>  struct drm_connector_state *
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index a5b15bef8aa0..e28fbd1b6790 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -259,5 +259,5 @@ static const struct drm_connector_funcs dm_dp_mst_connector_funcs = {
>  	.fill_modes = drm_helper_probe_single_connector_modes,
>  	.destroy = dm_dp_mst_connector_destroy,
> -	.reset = amdgpu_dm_connector_funcs_reset,
> +	.atomic_create_state = amdgpu_dm_connector_atomic_create_state,
>  	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> @@ -672,4 +672,5 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
>  	struct amdgpu_device *adev = drm_to_adev(dev);
>  	struct amdgpu_dm_connector *aconnector;
> +	struct drm_connector_state *conn_state;
>  	struct drm_connector *connector;
>  	int i;
> @@ -739,5 +740,11 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
>  	 * framebuffer lists
>  	 */
> -	amdgpu_dm_connector_funcs_reset(connector);
> +	conn_state = amdgpu_dm_connector_atomic_create_state(connector);
> +	if (!IS_ERR(conn_state)) {
> +		if (connector->state)
> +			connector->funcs->atomic_destroy_state(connector, connector->state);
> +
> +		connector->state = conn_state;
> +	}
>  
>  	drm_dp_mst_get_port_malloc(port);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> index 6f91a992d43f..39b7b3e49f6b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> @@ -226,5 +226,5 @@ static const struct drm_connector_funcs amdgpu_dm_wb_connector_funcs = {
>  	.fill_modes = drm_helper_probe_single_connector_modes,
>  	.destroy = drm_connector_cleanup,
> -	.reset = amdgpu_dm_connector_funcs_reset,
> +	.atomic_create_state = amdgpu_dm_connector_atomic_create_state,
>  	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> @@ -241,4 +241,5 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
>  				uint32_t link_index)
>  {
> +	struct drm_connector *connector;
>  	struct dc *dc = dm->dc;
>  	struct dc_link *link = dc_get_link_at_index(dc, link_index);
> @@ -262,6 +263,16 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
>  	 * Allocate some default initial connector state with our reset helper.
>  	 */
> -	if (wbcon->base.base.funcs->reset)
> -		wbcon->base.base.funcs->reset(&wbcon->base.base);
> +	connector = &wbcon->base.base;
> +	if (connector->funcs->atomic_create_state) {
> +		struct drm_connector_state *conn_state;
> +
> +		conn_state = amdgpu_dm_connector_atomic_create_state(connector);
> +		if (!IS_ERR(conn_state)) {
> +			if (connector->state)
> +				connector->funcs->atomic_destroy_state(connector, connector->state);
> +
> +			connector->state = conn_state;
> +		}
> +	}
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> index 8117aaf41f22..ebf8155326cb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> @@ -1469,8 +1469,8 @@ static void dm_test_decide_crtc_timing_no_crtc_clock(struct kunit *test)
>  }
>  
> -/* Tests for amdgpu_dm_connector_funcs_reset() */
> +/* Tests for amdgpu_dm_connector_atomic_create_state() */
>  
>  static const struct drm_connector_funcs dm_test_connector_funcs = {
> -	.reset = amdgpu_dm_connector_funcs_reset,
> +	.atomic_create_state = amdgpu_dm_connector_atomic_create_state,
>  	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> @@ -1478,8 +1478,8 @@ static const struct drm_connector_funcs dm_test_connector_funcs = {
>  
>  /**
> - * dm_test_funcs_reset_sets_defaults - Test funcs_reset sets defaults
> + * dm_test_atomic_create_sets_defaults - Test funcs_reset sets defaults
>   * @test: The KUnit test context
>   */
> -static void dm_test_funcs_reset_sets_defaults(struct kunit *test)
> +static void dm_test_atomic_create_sets_defaults(struct kunit *test)
>  {
>  	struct device *dev;
> @@ -1502,7 +1502,7 @@ static void dm_test_funcs_reset_sets_defaults(struct kunit *test)
>  			    DRM_MODE_CONNECTOR_DisplayPort, NULL);
>  
> -	amdgpu_dm_connector_funcs_reset(connector);
> +	connector->state = amdgpu_dm_connector_atomic_create_state(connector);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector->state);
>  
> -	KUNIT_ASSERT_NOT_NULL(test, connector->state);
>  	dm_state = to_dm_connector_state(connector->state);
>  	KUNIT_EXPECT_EQ(test, (int)dm_state->scaling, (int)RMX_OFF);
> @@ -1516,8 +1516,8 @@ static void dm_test_funcs_reset_sets_defaults(struct kunit *test)
>  
>  /**
> - * dm_test_funcs_reset_edp_abm_level - Test funcs_reset eDP sets ABM
> + * dm_test_atomic_create_edp_abm_level - Test funcs_reset eDP sets ABM
>   * @test: The KUnit test context
>   */
> -static void dm_test_funcs_reset_edp_abm_level(struct kunit *test)
> +static void dm_test_atomic_create_edp_abm_level(struct kunit *test)
>  {
>  	struct device *dev;
> @@ -1543,7 +1543,8 @@ static void dm_test_funcs_reset_edp_abm_level(struct kunit *test)
>  	/* Test with abm_level > 0 */
>  	amdgpu_dm_set_abm_level_param(3);
> -	amdgpu_dm_connector_funcs_reset(connector);
>  
> -	KUNIT_ASSERT_NOT_NULL(test, connector->state);
> +	connector->state = amdgpu_dm_connector_atomic_create_state(connector);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector->state);
> +
>  	dm_state = to_dm_connector_state(connector->state);
>  	KUNIT_EXPECT_EQ(test, (int)dm_state->abm_level, 3);
> @@ -1553,9 +1554,9 @@ static void dm_test_funcs_reset_edp_abm_level(struct kunit *test)
>  
>  /**
> - * dm_test_funcs_reset_edp_abm_disabled - Test funcs_reset eDP ABM
> + * dm_test_atomic_create_edp_abm_disabled - Test funcs_reset eDP ABM
>   * disabled
>   * @test: The KUnit test context
>   */
> -static void dm_test_funcs_reset_edp_abm_disabled(struct kunit *test)
> +static void dm_test_atomic_create_edp_abm_disabled(struct kunit *test)
>  {
>  	struct device *dev;
> @@ -1581,7 +1582,8 @@ static void dm_test_funcs_reset_edp_abm_disabled(struct kunit *test)
>  	/* Test with abm_level <= 0 → immediate disable */
>  	amdgpu_dm_set_abm_level_param(-1);
> -	amdgpu_dm_connector_funcs_reset(connector);
>  
> -	KUNIT_ASSERT_NOT_NULL(test, connector->state);
> +	connector->state = amdgpu_dm_connector_atomic_create_state(connector);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector->state);
> +
>  	dm_state = to_dm_connector_state(connector->state);
>  	KUNIT_EXPECT_EQ(test, (int)dm_state->abm_level,
> @@ -1621,6 +1623,6 @@ static void dm_test_atomic_dup_state_copies_fields(struct kunit *test)
>  			    DRM_MODE_CONNECTOR_HDMIA, NULL);
>  
> -	amdgpu_dm_connector_funcs_reset(connector);
> -	KUNIT_ASSERT_NOT_NULL(test, connector->state);
> +	connector->state = amdgpu_dm_connector_atomic_create_state(connector);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector->state);
>  
>  	/* Modify original state fields */
> @@ -4887,5 +4889,5 @@ static struct dm_test_destroy_ctx *dm_test_destroy_ctx_alloc(struct kunit *test)
>   */
>  static const struct drm_connector_funcs dm_test_destroy_funcs = {
> -	.reset = amdgpu_dm_connector_funcs_reset,
> +	.atomic_create_state = amdgpu_dm_connector_atomic_create_state,
>  	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> @@ -6254,4 +6256,5 @@ static void dm_test_restore_state_no_encoder(struct kunit *test)
>  	struct drm_device *drm = dm_test_alloc_drm(test);
>  	struct amdgpu_dm_connector *aconnector;
> +	struct drm_connector_state *conn_state;
>  
>  	aconnector = dm_test_add_connector(test, drm,
> @@ -6259,6 +6262,9 @@ static void dm_test_restore_state_no_encoder(struct kunit *test)
>  	aconnector->dc_sink = kunit_kzalloc(test, 1, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, aconnector->dc_sink);
> -	aconnector->base.funcs->reset(&aconnector->base);
> -	KUNIT_ASSERT_NOT_NULL(test, aconnector->base.state);
> +
> +	conn_state = aconnector->base.funcs->atomic_create_state(&aconnector->base);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
> +
> +	aconnector->base.state = conn_state;
>  	/* connector->encoder left NULL. */
>  
> @@ -6278,4 +6284,5 @@ static void dm_test_restore_state_no_stream(struct kunit *test)
>  {
>  	struct drm_device *drm = dm_test_alloc_drm(test);
> +	struct drm_connector_state *conn_state;
>  	struct amdgpu_dm_connector *aconnector;
>  	struct dm_crtc_state *acrtc_state;
> @@ -6287,5 +6294,9 @@ static void dm_test_restore_state_no_stream(struct kunit *test)
>  	aconnector->dc_sink = kunit_kzalloc(test, 1, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, aconnector->dc_sink);
> -	aconnector->base.funcs->reset(&aconnector->base);
> +
> +	conn_state = aconnector->base.funcs->atomic_create_state(&aconnector->base);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
> +
> +	aconnector->base.state = conn_state;
>  
>  	enc = kunit_kzalloc(test, sizeof(*enc), GFP_KERNEL);
> @@ -6316,4 +6327,5 @@ static void dm_test_restore_state_same_sink(struct kunit *test)
>  {
>  	struct drm_device *drm = dm_test_alloc_drm(test);
> +	struct drm_connector_state *conn_state;
>  	struct amdgpu_dm_connector *aconnector;
>  	struct dm_crtc_state *acrtc_state;
> @@ -6326,5 +6338,9 @@ static void dm_test_restore_state_same_sink(struct kunit *test)
>  	aconnector->dc_sink = kunit_kzalloc(test, 1, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, aconnector->dc_sink);
> -	aconnector->base.funcs->reset(&aconnector->base);
> +
> +	conn_state = aconnector->base.funcs->atomic_create_state(&aconnector->base);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
> +
> +	aconnector->base.state = conn_state;
>  
>  	enc = kunit_kzalloc(test, sizeof(*enc), GFP_KERNEL);
> @@ -7033,4 +7049,5 @@ static void dm_test_mode_valid_force_on_no_stream(struct kunit *test)
>  	struct dm_test_cvs_ctx *ctx =
>  		dm_test_cvs_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
> +	struct drm_connector_state *conn_state;
>  	struct dc_sink *em_sink;
>  
> @@ -7045,6 +7062,8 @@ static void dm_test_mode_valid_force_on_no_stream(struct kunit *test)
>  	 * point at KUnit-managed memory.
>  	 */
> -	amdgpu_dm_connector_funcs_reset(&ctx->aconnector->base);
> -	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector->base.state);
> +	conn_state = amdgpu_dm_connector_atomic_create_state(&ctx->aconnector->base);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
> +
> +	ctx->aconnector->base.state = conn_state;
>  	ctx->aconnector->base.state->max_requested_bpc = 4;
>  
> @@ -7560,4 +7579,5 @@ static void dm_test_update_after_detect_disconnect(struct kunit *test)
>  	struct dc_sink *old_sink = dm_test_uad_owned_sink();
>  	struct dc_crtc_timing *timing = kzalloc_obj(*timing, GFP_KERNEL);
> +	struct drm_connector_state *conn_state;
>  
>  	KUNIT_ASSERT_NOT_NULL(test, old_sink);
> @@ -7571,6 +7591,8 @@ static void dm_test_update_after_detect_disconnect(struct kunit *test)
>  	ctx->link->local_sink = NULL;
>  
> -	amdgpu_dm_connector_funcs_reset(&ctx->aconnector->base);
> -	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector->base.state);
> +	conn_state = amdgpu_dm_connector_atomic_create_state(&ctx->aconnector->base);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
> +
> +	ctx->aconnector->base.state = conn_state;
>  	ctx->aconnector->base.state->content_protection =
>  		DRM_MODE_CONTENT_PROTECTION_ENABLED;
> @@ -9200,4 +9222,5 @@ static struct dm_test_fs_caps_ctx *
>  dm_test_fs_caps_ctx_alloc(struct kunit *test, enum signal_type sink_signal)
>  {
> +	struct drm_connector_state *conn_state;
>  	struct dm_test_fs_caps_ctx *ctx;
>  	struct dc_context *dc_ctx;
> @@ -9225,6 +9248,9 @@ dm_test_fs_caps_ctx_alloc(struct kunit *test, enum signal_type sink_signal)
>  					    &dm_test_connector_funcs,
>  					    DRM_MODE_CONNECTOR_DisplayPort, NULL), 0);
> -	amdgpu_dm_connector_funcs_reset(&ctx->aconnector->base);
> -	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector->base.state);
> +
> +	conn_state = amdgpu_dm_connector_atomic_create_state(&ctx->aconnector->base);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
> +
> +	ctx->aconnector->base.state = conn_state;
>  	KUNIT_ASSERT_EQ(test,
>  			drm_connector_attach_vrr_capable_property(&ctx->aconnector->base), 0);
> @@ -9631,5 +9657,5 @@ dm_test_force_dup_state_fail(struct drm_connector *connector)
>  
>  static const struct drm_connector_funcs dm_test_force_fail_funcs = {
> -	.reset = amdgpu_dm_connector_funcs_reset,
> +	.atomic_create_state = amdgpu_dm_connector_atomic_create_state,
>  	.atomic_duplicate_state = dm_test_force_dup_state_fail,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> @@ -9848,8 +9874,8 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
>  	KUNIT_CASE(dm_test_decide_crtc_timing_no_copy),
>  	KUNIT_CASE(dm_test_decide_crtc_timing_no_crtc_clock),
> -	/* amdgpu_dm_connector_funcs_reset */
> -	KUNIT_CASE(dm_test_funcs_reset_sets_defaults),
> -	KUNIT_CASE(dm_test_funcs_reset_edp_abm_level),
> -	KUNIT_CASE(dm_test_funcs_reset_edp_abm_disabled),
> +	/* amdgpu_dm_connector_atomic_create_state */
> +	KUNIT_CASE(dm_test_atomic_create_sets_defaults),
> +	KUNIT_CASE(dm_test_atomic_create_edp_abm_level),
> +	KUNIT_CASE(dm_test_atomic_create_edp_abm_disabled),
>  	/* amdgpu_dm_connector_atomic_duplicate_state */
>  	KUNIT_CASE(dm_test_atomic_dup_state_copies_fields),
> 

