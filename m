Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D33606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qpZvejSD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C2BE10EA17;
	Fri,  6 Nov 2026 14:42:37 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013001.outbound.protection.outlook.com
 [40.93.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADAB710E428;
 Fri,  6 Nov 2026 14:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFo2oOkK/tM5UYn/kOBjcbRjmT217e5zEuiQW9WxHMqKloP1IjgBGQwQf3XgZcIEwknZlEzHkxpVLM58ZGf3QXWtEq/kTJlQn/A3iGGOnBHWqcskOBn44j5Bb3/4An6d8LvH6BS/8G35Nw3OX9fG0aw8NOt2X+lZ0ZzcRkTtFZLwdyoTOOJ1M+7gipKSMI7BaY9gzjWw1DxgL7MjizjkhaAYhEEiVyIoT7JnJ+onfumgcbiZQyRS4OoQJV++nKBd+hKZjoSeVwNQiJf07cQ1logAUDXQaPQzyh8PpfoCvz1iEYgW4eKC+xrPmFSDt2lNx7gUBNNx+JPDkNsOoOdBiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hO8RZ/alad6ynvlLYhBYTO4+DMjCkHeWgqZ3f60gKoo=;
 b=Crncrs6kyLkqlcZXYDi6o3ZIpjt8xiq9E0MKtXor/Jdqdx8DEVztogBRVxa3eGVWjKcN+0P/jNd7y9cJEb7ZZoAIxLN4ezt4WbpDHF5LNuusHH9CFSMI6voDgSekNXlMHCYqM66tPI6D6Ka3PHmW330bVCXSpIYeKQ1RM7t9LwcRTdgsMwxdOLW7JFFOPlMRLmTHD/LhtLo9XT9BYv2g/gYvSoFGc2pktk4o4NibyQ/UWh6U3n5Oo/S+T7RwfTuOtCoDpAI5jkfdBg9mlLdjUhlsSOLTC6Ns/ZpI5mgSGUI9FMqH2NYsJcxS9FZL8Fs1IrGZRvi0y/w0/Cxr1+Q7sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hO8RZ/alad6ynvlLYhBYTO4+DMjCkHeWgqZ3f60gKoo=;
 b=qpZvejSDhbfa6jsL2AHi8XWsrlZbJzkHRKWxJzw/Qvce7kn7/n6wa9jNSq/mLl+BUqVY3C5A2vWyOzOu/HK8H5KFtFnJlcHnR0Zpcd7+9yPgXWKfjo3CwqrcLhwsmseL57f27e5m70MHql5qCSmf0pkVeZZO0bbLY4ifyOlOk6A=
Received: from SJ0PR03CA0247.namprd03.prod.outlook.com (2603:10b6:a03:3a0::12)
 by LV2PR12MB5919.namprd12.prod.outlook.com (2603:10b6:408:173::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 14:42:20 +0000
Received: from CO1PEPF00018868.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::2a) by SJ0PR03CA0247.outlook.office365.com
 (2603:10b6:a03:3a0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 14:42:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00018868.mail.protection.outlook.com (10.167.249.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 14:42:16 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 08:42:15 -0600
Received: from [10.254.93.142] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 6 Nov 2026 08:42:13 -0600
Message-ID: <3b112cb8-a2b1-4c40-8e0c-553d49d5e165@amd.com>
Date: Fri, 6 Nov 2026 09:42:13 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/16] drm/amd/display: Fix planes atomic_create_state
 implementation
To: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Louis
 Chauvet" <louis.chauvet@bootlin.com>, Haneen Mohammed
 <hamohammed.sa@gmail.com>, Melissa Wen <melissa.srw@gmail.com>
CC: Daniel Stone <daniels@collabora.com>, Harry Wentland
 <harry.wentland@amd.com>, Jocelyn Falempe <jfalempe@redhat.com>,
 =?UTF-8?Q?Jonas_=C3=85dahl?= <jadahl@redhat.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, Pekka Paalanen
 <pekka.paalanen@collabora.com>, Sebastian Wick <sebastian.wick@redhat.com>,
 Simon Ser <contact@emersion.fr>, Victoria Brekenfeld <victoria@system76.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Rodrigo Siqueira <siqueira@igalia.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, <amd-gfx@lists.freedesktop.org>
References: <20261030-drm-reset-state-flag-v7-0-4e55eaeae683@kernel.org>
 <20261030-drm-reset-state-flag-v7-1-4e55eaeae683@kernel.org>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20261030-drm-reset-state-flag-v7-1-4e55eaeae683@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00018868:EE_|LV2PR12MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: b26dd344-dffa-413b-3646-08df3c142743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|42112799006|23010399003|7416014|18002099003|22082099003|10067099003|4143699003|11063799006|5023799004|261102123227099003|261021123027099003|261022075727099003|261021121427099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: sA+ARBmxFve2piLebY7TaaPdgsL/DmT+AI2IZuRBfB5Jk37HxsK58WsU+hECZatYDCzNvqtwsfjP2jFz7hYmFp2pzXnFkybi6SmyMBa/xmMIEc2uugJy2KJQGez90vIomXKrCYrs1m/6EiQ58zyG7XySU3JnqZVDIdEKqNC2VsSyEqueQrbPdB6NdFmdzvzHS6pGcF8FXnH8iJq+TaKYEVA3qWfivfgFtJM1wzZmbUIBl8FqL2YFEq5ZMiEm0ZFwyGSwZURBN5wWhXhjoT3jWH1YwXYfKKmv0OC87BzyfrACOtnuzu03fSz0np2H9gOYMeeIuLf8+Q8l1ptBQcSCEFkN9wyGXH0ZFfg+dp+AW6BtoinH3lcCmYOtxmlPbrV7hkoWbwg/r5ok1JBLUWex5Q57xOkt5JHjRn3qn75bbXlJkp2jUAiao9sqMY30iLExCPnBR27Z3Q+rw4JeM4qQrhlWa+ol1SshjtLEh1+tmaoEnZb849LlIfYy6vxnk3ZBYBz7hPMRhFe4uIFWxQDdVas2DHFuclbI5a2zNmN2RnmFMQuRLh4DHsptns30oOAQy2VNiFAPEOc5pW+62A1Gn26oDjt2MG3PmtWozhYmhwsWHw5HxAYKuc0JJG4UiGilywE4icBoJIVKZJdfCLYQzltu6h9ereAULBCgUuWBdtC+Tp4qxCMTjBjWkMxZN+6Ep5ULJhxrnHGbVs7AXDy4iw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(42112799006)(23010399003)(7416014)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(5023799004)(261102123227099003)(261021123027099003)(261022075727099003)(261021121427099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Y1HKAcksb2i+kJb80kqfnLXr+mYf9zjIr5Gw8UtFz/PP7w1wzFrV4IEsqQzxVFHvs/YaWH+2xuAxlZta7x8pNCo0I0hA70aoLlYrPEwjU+BoqWbDc6FKGZ3Zlplj8ZQ+JGgnVvZjfoS1J0KqKgJ6iOgxSNrWlx/AYY0NLnmIjHJSUN6HnhDDKm8rzFQtcNhF+K0vsJ3r/nTC4ZaBNnRsItDT+FGBCJYgcdTETvFcbDHOnktdA8ckH1a6YIi+l/PAqIa7RWzu06wWTpxnE5umO/Zveb69aT6RkQj9lH0Ve6Bvdwb1hOvcBj8nPsid/24IbnRl6G46Tl4UoLArJF1fS5OlW+1+CJ+ZwLP8jmvL7qTmxInlnH0OuWSVhVe79I3F33l2vSr4MSNCBDb4DFq0Eez3jF7OzFJXTgd3EDXqJm7i5tWwEDuo/oKc5CJ9QcNs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 14:42:16.4280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b26dd344-dffa-413b-3646-08df3c142743
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00018868.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5919
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



On 2026-10-30 06:27, Maxime Ripard wrote:
> Commit 2bcec01cf105 ("drm/amdgpu_dm: Convert to atomic_create_state")
> converted the amdgpu planes to use atomic_create_state instead of reset.
> 
> Unlike reset, atomic_create_state is meant to allocate a new default
> state without any side effect on the hardware or software state.
> 
> However, during the conversion we forgot to remove the call to destroy
> the existing plane state if any. While this was expected from a reset
> implementation, it's not for an atomic_create_state one. Remove it.
> 
> Fixes: 2bcec01cf105 ("drm/amdgpu_dm: Convert to atomic_create_state")
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Leo Li <sunpeng.li@amd.com>

Thanks!

> 
> ---
> 
> To: Harry Wentland <harry.wentland@amd.com>
> To: Leo Li <sunpeng.li@amd.com>
> To: Rodrigo Siqueira <siqueira@igalia.com>
> To: Alex Deucher <alexander.deucher@amd.com>
> To: Christian König <christian.koenig@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 2f88b9d65b82..779dabb7fc51 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1821,7 +1821,4 @@ STATIC_IFN_KUNIT struct drm_plane_state *amdgpu_dm_plane_drm_plane_create_state(
>  	}
>  
> -	if (plane->state)
> -		plane->funcs->atomic_destroy_state(plane, plane->state);
> -
>  	__drm_atomic_helper_plane_state_init(&amdgpu_state->base, plane);
>  	amdgpu_state->degamma_tf = AMDGPU_TRANSFER_FUNCTION_DEFAULT;
> 

