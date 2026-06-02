Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9F9CD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 16:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BB6B113AEE;
	Tue,  2 Jun 2026 16:59:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AQM0q7aJ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94B51113AED;
 Tue,  2 Jun 2026 16:59:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adYyV7NdUcTU/5XSV8/Yks3GQZVQ8hYFTxnbpVnHbTxjWHVYqy3tuoRCBnyQHiSpbbh3rt27iwLfAF13iT5R30O/DU1wReEhgwtooPY548jT+tFDEs3ENiNQw+6okAlgsoJERY20XqR/mi8CCCyoH3flaVWrbMcNGlOzjfV72s+eDLhZQzfNJ6c7y0TG3ELWKiNXS6qerMB/axN7oLxYaoJaUjt34vET0+rhtuq5cI9iW+yftnJNwNl9rPEp0QTGCGLoH4X6PqZOhMN6y6VVuo4HPIfFHMgbp2VOj9kXstNSAfSMU4VqVL0R6ud/SRZor2i26D4egTmuMLcd/HSLTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRcqoexA5LPQOUmGmhtnWBK5jvnrg9NgM48PKukLr10=;
 b=QHoZBFcqPTASiBKsnqo19nUs0y4X5Lr51ZiZWouToKW0Gez/Wdk4o90K7nhoB4pw0It5mr0QO/ZGs2TibrlB7RWWQtedUP/mHKqQqcwRwUtlgLD2T3vn8si4A/yYpqx87AGDhQfqr4wETT3fOG0ocTQRqeNxXi4JqImFcDOC5ky/S8nqlNPBzp4u9r0jenhm2LTwe7Kb7Bru7uPMEuo7Hm9bMm1YzPVOHxI5p14Bt+KJG5Mh1gN/ozg+APDx1VJ8WA7YrTfFtsy9AMuwI1IMC541iMIkA+hBr0SFTNfVzsSntK6xZ7EOMZ99GLSeG49ssD6nFsmDWfrMHIkHMy2dCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=igalia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRcqoexA5LPQOUmGmhtnWBK5jvnrg9NgM48PKukLr10=;
 b=AQM0q7aJ0KFIMeh8sHJtAD6IAxHfRTBIKPCrC57ZLCy7QmJUHf7YCQToGTne7j9+CkmOWR1ip0voyrHdYw1ykvu3Ra/IoqT7QdjD3tOmrHClwraRkCQAXVmJeGbqj3byqBxI/v+rGznEzVETj5YwvPKFwnov8XpB5jXLhtJt9bQ=
Received: from SJ0PR03CA0343.namprd03.prod.outlook.com (2603:10b6:a03:39c::18)
 by CH3PR12MB9313.namprd12.prod.outlook.com (2603:10b6:610:1ca::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Tue, 2 Jun 2026
 16:59:10 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::26) by SJ0PR03CA0343.outlook.office365.com
 (2603:10b6:a03:39c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 16:59:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 16:59:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 11:59:08 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 11:59:07 -0500
Received: from [10.4.12.116] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 2 Jun 2026 11:59:07 -0500
Message-ID: <0bae5fea-a1d8-4516-b1a7-eb90e35c39b1@amd.com>
Date: Tue, 2 Jun 2026 12:59:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Export symbols for KUnit test modules
To: Alex Hung <alex.hung@amd.com>, <harry.wentland@amd.com>,
 <sunpeng.li@amd.com>, <siqueira@igalia.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <ray.wu@amd.com>, <ivan.lipski@amd.com>, <srinivasan.shanmugam@amd.com>,
 <marco.crivellari@suse.com>, <mario.limonciello@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
References: <20260602161536.3909009-1-alex.hung@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20260602161536.3909009-1-alex.hung@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|CH3PR12MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: e8cc3c02-126c-47cb-0daf-08dec0c8438f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|22082099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info: Pb8851Kyq71mKpbAFNRNPRgVm1i+r5DjK/nsDr72q4Ep3vXznVqiHGVqRH8f2ZAo4roiAz6ekGsoUQw3dWpS8xYXprTtU3v0VKc+KLvGLsLUaMnu/rba8TQJk1QvrvAq9ihvHuc7Akd1sWBGBHGX3VltBjcxhu608awlYcmJsh+VFLfzyQMg7pOh2VR0HMJj6RC75lYaD+ioJztypctZkDBJz2hbHEjJe7u3PrKZG92h1dTON9S9hLQetT3PT+SL4SD1HbMcyZ/Jkb/3kGQQF7OXuIzFjHJvNmD6ch5ca8irQTIWyNviGlYRYz6JxyXmZ4LxtaB/M6+9yQkFsNgHOGZR/rHaQyWRQ+jweL8Ij3qFMgd2TCJZ7xrZmUH91waZ1BrR8qMBjVVBhfJvLv0n1BLkYiTd+YbE+eA6rgQAWXUVt5paiYdkbODXkU8OOh/OD1Dp3zmNO4MRGUCqQyRDcev6Bdn4qXfo9yaTrxmj2nwX2WLn1liXAJwO1GOlrOcHga8g6OR606qSXW/+dxbCw0r4uRL3MUYwzPx/xaxmxiEDSMhfkeJQsa9xQRwqYU8WC4oZzQZZDDG++z6Q0Nd3SmHQrVP3hwWV1hU1dXzL5cn/IBnBJH9wSixG3IBNhfAprI8YfCof/Qmz59m9mf1kZIS48c7dZoZUym0cegmCEWDTG5DhkybuD3UaOUyo9LyeP38D8GgS4+jdLSxuzQ5zN3fsZNDJs+pvsADr6CCxTEnpH6C3fvEaDN1Cjy1nFZ1XE/cHag9/rTlEKxbeGlkUWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ut1XRmG646XClmrzv401ekr6bT4Y4rWY0JIBMx3mDeBZkyM0RNsC007S+8INuXLXsijLxRO9SBqQ8xfCLxID+sA9s/cal2iI4MB4IftdoBi2KPlfz1XuL3hKbs+eIU8zo3KgXgdF6FGvfVe6b7T0Zt9TZBnVpM4Yp4uVQLsCvP7Ppga0ZFPmtDFCMjMaL60Y6hyoFJSYJ4vPeFQ/zAMSHJlBllAftfagXYFduBv5jPmv8zZyacWObPRpzFH3qRJoeCL8pgdJuwuYWyT+O20DqckyvODFBPHVOF69ZFsvom9lgd4MHGgcKHat9yn0rC5wCOXm5k511/fXR2gDnj5cW8drW7HTntx0xcBhCWyifoFINrEBJq3bFauiuxqT+XHKVYzwY4WZugiQF4L01PuhzKrEghTha7nHHwDJY9jJwZCMrilW6u3+zMRq6d2LDkdS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 16:59:09.1896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cc3c02-126c-47cb-0daf-08dec0c8438f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9313
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



On 6/2/26 12:15 PM, Alex Hung wrote:
> Add missing EXPORT_IF_KUNIT() calls for amdgpu_dm_psr_set_event,
> amdgpu_dm_ism_init, and amdgpu_dm_ism_fini so that the KUnit test
> modules can resolve these symbols when built as modules, i.e.,
> CONFIG_DRM_AMD_DC_KUNIT_TEST=m.
> 
> Fixes: 7c1bb28ce2f0 ("drm/amd/display: Add KUnit tests for amdgpu_dm_psr_set_event")
> Fixes: 4db0dd9e5a63 ("drm/amd/display: Add more KUnit tests for amdgpu_dm_ism")
> Assisted-by: Copilot:Claude-Opus-4.6
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c | 2 ++
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 1 +
>   2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> index 5c0841728671..32391b56097e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> @@ -640,6 +640,7 @@ void amdgpu_dm_ism_init(struct amdgpu_dm_ism *ism,
>   	INIT_DELAYED_WORK(&ism->delayed_work, dm_ism_delayed_work_func);
>   	INIT_DELAYED_WORK(&ism->sso_delayed_work, dm_ism_sso_delayed_work_func);
>   }
> +EXPORT_IF_KUNIT(amdgpu_dm_ism_init);
>   
>   
>   void amdgpu_dm_ism_fini(struct amdgpu_dm_ism *ism)
> @@ -647,3 +648,4 @@ void amdgpu_dm_ism_fini(struct amdgpu_dm_ism *ism)
>   	cancel_delayed_work_sync(&ism->sso_delayed_work);
>   	cancel_delayed_work_sync(&ism->delayed_work);
>   }
> +EXPORT_IF_KUNIT(amdgpu_dm_ism_fini);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> index 85caa8534184..0dadc0bb214f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> @@ -189,3 +189,4 @@ bool amdgpu_dm_psr_set_event(struct amdgpu_display_manager *dm, struct dc_stream
>   	return mod_power_set_psr_event(dm->power_module, stream,
>   				       set_event, event, wait_for_disable);
>   }
> +EXPORT_IF_KUNIT(amdgpu_dm_psr_set_event);

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
