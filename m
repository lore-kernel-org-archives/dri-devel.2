Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE59CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEC3D10E400;
	Thu,  1 Oct 2026 13:54:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4+LWexqg";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2ED110E400;
 Thu,  1 Oct 2026 13:54:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/vnyeXRG+V3SgPvjI7wSYktdskXvf0u8VQCEBxl2JGR6wTzPxnFM88tQLx9LGPt1S+3AROAstOrn+l6TTmnzGIArzQTmIYytXXvdhAiWpBoCJPMpWRIzLEIYPOzh/mOMGf2Gm69cQNMIORZHTqR5a/ZiTAkw8xwudmp1LIBiQ0yqQQWJtLn9VFB7LbYQcppWV8uPG7c2cg5P492TwezNj3uHmNwoRbmljtGAfBVid2Ayb9iZMNRpeAreYHLzwHXT9cgyQMnYzHlrSKOewIw7nl8iwN3Ysif1IJQwFslYIiIFbGTIKz0sstHDCquPx1TmfAY85bUogdu5gM20K5Pig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90e7LDm4YINtGskIhApZiC9K2JTnaXyCpDAEIJDOEoc=;
 b=wV8rbcPB6FA0Y14LOGngfMmbcYIBHmwSTBJXWRoNXN8AG9yHtR+ko/cMnEuYTIn+0fuUZrOozAP+OcguaBNkm2znQo1YRVHM5USQ5Z/14oKPwfcOWFz29e7G39LzaZWt/RzoPyfsSr+5T8wzzG8dp1qIthcSU/glhumUj80fTa4kVLMMI46xFQ14dlVSvTZDB7zVnGEKhFmD2cToqPNNruCVmTq4JYOhboHoJFg2Dn6CO8F5Yfje2iiWkOPaOPqmJtPwG2AOJgSmhH3IFfF1V1nqeGvccJuZ9KthsAh+u6dO6C5aVpgYdTjY/fpKJygWftpYpYcxUyMKPkHHvjA24Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90e7LDm4YINtGskIhApZiC9K2JTnaXyCpDAEIJDOEoc=;
 b=4+LWexqgu5T5/dXXbQv/Anzve76ym01E1oitWMlm6yFufiGPC8pnrmHAezRJpW8UUMGxD+ykW+7is9YaKpLF8WjuLtoLmUWyOUnVCf3LRfRaFar/5fvqtPi3ESCAU9xDC1UZxvd0W4iRg56lkgtwFENyIdZW3kKsu28fFzv49uo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 13:54:13 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%3]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 13:54:13 +0000
Message-ID: <96bababa-cf6d-472b-85a1-bafeef5fc474@amd.com>
Date: Thu, 1 Oct 2026 09:54:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] drm/amd/display: Disable CRTC on MST connector
 unregister
To: b2amedina@gmail.com, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260930-amd-mst-teardown-v1-1-16a39ebdd4de@gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260930-amd-mst-teardown-v1-1-16a39ebdd4de@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0392.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::8) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c5a9dc-c036-4f76-5bcd-08df1fc379a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: j5R1WGziPjHid4Ibl5ABwexAsEMhoFTMx8rXkaa150h2JYGX8NQeZmfckte/riEumgapaqLgQy4BPHfiTSGZKPwmR1Dr8/UfuXz03VIDq5HBg4iNY4fTHPAJ0U2Nure171BJwcKnGxgZJewNxKLE9Ly+72vIH4scGJEGlqU8OlGLJIFDzaYV5z7j1Ro0S/DaiprJeeWKIoDYc669lEvJpb7A/sWQm//bNfnkZVfS3ADUg/duWLby2iNj2RLZEML/K1+TaMIEjZ4IhcBXetoJ4LoWQBugr9N3Kopykhfb8HFP3MPeg3zgeC9RqARLdDqPUTVkdWyF+XJj+kWcFxG4bQ6C2LY8cbxzyYuIA5K0ZVz/JEMzuAnuGisTQP2mxHSdsi3jdTxUr05TtVTVca72mFZuonTm2F862kf0iyb4vXZmRY+9ogFLgYrDMwau1pcskFLD7wX8zP6RBd4HVWI4lk6fLf9pdldjJxvYJ2XOSe371yujyp/rAKgXbRXKtNj0J70zwrsNgGK2mymTbCOONSHy5+IWES2IPWQtP0KjbgcKzt6SOic6BbfeVmwRu6kXAh9r0RRp7sGG3gNcJHi2RQQcYyJiO/jO0jrbylxhCFAVnI9TNo/+s7jGVXL6jhFbPengXqYKRvnEhqA/wcN8EHUluwC0HcmaeeXEdlwLeHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVMzSDdVdDRNcEM2Z2RERXI4RUlyMVpUWWx4N0w3UWZweWxkL2RKRW80QTBr?=
 =?utf-8?B?VnZ0T2srSlI5aXMzeU9hc0xpZk5QSXorRWZqZDFObE5zeHBwakh5a1hiNjBq?=
 =?utf-8?B?N1FNWnArYk5USGorcWlwOTQzQThtazJGTkVGRkVMMEM3T3BKUWNvWjJ2ejdk?=
 =?utf-8?B?MVNWNkZoVkRIdFJHTEJaT0xIelFGbHhlR21DbEs0UjJuWE5aQmdKNnpnejBG?=
 =?utf-8?B?bTVld0NwN0t4V3lzd3Jxc24rMHFIa0ZqdUhsbXhFK3FrMEg1blUyQml0clJh?=
 =?utf-8?B?eW1QeHJRVTd4bkFISEZiaUhBZnlMRlA2dkh0VEtUdFQrTS93K3A1SWJIb2V6?=
 =?utf-8?B?a3pzNVg5REloazVlYmwvdWhka0ZvWDhkQmpjbkVUT3dPTm52b3Z1QThuRjBx?=
 =?utf-8?B?QlVzUnFmOS9ET2VZQUFJbDkzOEZMZy9kQzBoVllkcjJJVStLbnhyK2JFVW15?=
 =?utf-8?B?ZlVON0pXYUppNmk1ZDhPeEVFUFBJNlJuL05PQ1pFdEJMaHVaajVZVWxaczVF?=
 =?utf-8?B?cXFqL0orSUMxcFk3VUJjclFTYi83cTd0b1U3MFhLYlZDZy9yYXhobmxIai9L?=
 =?utf-8?B?Z3BsV1dkSG5BcXhYVjJtSHJwclp3UnhvcCt5L1FFL0diMG5yVTI3bE1GVWJJ?=
 =?utf-8?B?ZEdacGkrMDhCNWFOcHJWNExxaXZOUDA5OEw1TEt1NkFQMjAzWGhYYzlYMmxM?=
 =?utf-8?B?a1dmdEFDbFAyTksyZ3NmbU1kWUxVZnZNYUhBYjBhU2VHVUZha01RN2s3dkhm?=
 =?utf-8?B?OUdTZ2VvQWh0aEs2SEFhNy84ZG93NVduajdMRmJWalIwTEpWTlU3bExicmMr?=
 =?utf-8?B?Y1VzYW5TUXpKWHY3bEplK0tkdlVZaG5GR3BoSXdQTUdWQm1ybWRXNC9jRzZ4?=
 =?utf-8?B?dWlDWmZXNS8yRzMvditMb1FPdTY5MFBrQUVZcExPTnhIQndsVUlTMlk4VzZY?=
 =?utf-8?B?OTRBT01Cb2lFYk9menVpbjRYVDFZaXppcWZTR1pGOXJKWlUvK0ttS3IxY1dO?=
 =?utf-8?B?WnRCeGJBYWVrWjdLMHU4Qy9WVCtJb1EzRkUzYlBibFYrazRvcFd5d3hXV3Y1?=
 =?utf-8?B?OWRYQ2VJRU1uSzhXVTNWMHpubi9TUVFiS2x3bGszc1J4dVBVZE9NV1Z3RWVm?=
 =?utf-8?B?cEpuNUNmVUhkZXIzWDlvQ0NVZDZxckR0OUREZHY0Yi93TmY3Kzl4NlBpTDd3?=
 =?utf-8?B?QVh3bFI4S0NRNWNFeFVGa1dRbkZyaUtQUEUvZ09lZFdQV0EwSnlyWmRnUWhh?=
 =?utf-8?B?dTFnTEx4NjlSRHp5NVN4ZVNKcUgrNGlMUU9ySVlFQlI0UkxZN1V5QWJsYnNm?=
 =?utf-8?B?Q3U1bVBoMzUzM2RHMW51Ykc2eTlFVjI0UUZ4RTRTL25DWEdPMDlaemM3aVY5?=
 =?utf-8?B?aGdVNHR3R0RZb0J4SEJiL0w1MmVBVlZNenN2RVpqWDUwanVhdmY4cGhaOUhQ?=
 =?utf-8?B?d3hWVUZKNjAvSVlyTkY2M3Y2SllxVjhhTnI2c0ZMS1k2d1JRbCtkZEhnWHNn?=
 =?utf-8?B?UUZ1ZUtIRnFhSkV5ME1mdTVqd0FWK05aQTVyRFdRK2lRVlYyQW5xcXVGTGZa?=
 =?utf-8?B?MEIwekt4cDV4MUlOUXA3WEhvWGtrYlZQcmdiaHgybnA3WUgySDBEUjJMVUEw?=
 =?utf-8?B?dnAwTU8wajBNR1hENUZ1MmZGMll0bGZlTlRqZWRWcVNmdmM0UlNRNjlVcTRo?=
 =?utf-8?B?ODJYRUZJY3ZkTFZ2NDJZeXVBS0hsNEcyVEZ1WDJzT2Z6dXNDN3Z5WHVuZUpk?=
 =?utf-8?B?dXNCQndUR0FVbzR6MjZDZXRBMW9GNjloWnhYRisxaS9aaUhkNW5DakZZb09Q?=
 =?utf-8?B?NzlFZkpTVUozQ3NORlJaUExRR0orLzJzdWwvZmk2czIrK05PQ01Qb1lyWWRQ?=
 =?utf-8?B?UzVtUGUweEwyems3VEpTcjZpakhDQ29waVk2QW9yVE5HdWN2MTNKckJJaWd6?=
 =?utf-8?B?WmdNeWRZTUY3cDhoR1dsU1Bsdjd1MTFweWVwNWp3aTBzc3ovcDc3WWkyQ1ps?=
 =?utf-8?B?QWFSN2ZvR3ROYWdsZEhKZk12SHR2VWFvakR3czMrVFR4WWVXYXhqZWprT2pF?=
 =?utf-8?B?bkh1b0d6ZFUzdklHenVCdjMvdG1maUdTeFcyVnB2RW1ScVdocmQyUlhyTjN4?=
 =?utf-8?B?WUIxUGNwaHJjak4xMWlNelNVc3FXdnQ4YnNzVERmVkhnRnE0dkJKa0FUM2d3?=
 =?utf-8?B?OFlXV1YyMnNtYVNQNW8xVlJ2ZHE2eWhDNXJpSDJmNk5LM2srVGw0YlAvWDNa?=
 =?utf-8?B?eXQ3L2FwOVNvOHU3RE9CMUVZb0lYSGI1UXRPdlpXeURXUDhNbDZWdHRKMk1W?=
 =?utf-8?B?NzlqVHNvOHl0ajlLT1JkOVZBOTVTQjA0YllMbXdSNHBMVWNGaVBSZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c5a9dc-c036-4f76-5bcd-08df1fc379a2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 13:54:13.0896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjkNIpes0WgKv8BV4etr36ZLiiomDpzfSss3oa0A4Bf1NuQEvgCKoQEIYS1G9FwqYvegY2TyXj2ji/dL3N8Kqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765
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



On 2026-09-30 22:13, David Medina via B4 Relay wrote:
> From: David Medina <b2amedina@gmail.com>
> 
> amdgpu_dm_mst_connector_early_unregister() releases the connector's
> sink but leaves the CRTC it was driving active and its MST encoder
> assigned. Because the connector is unregistered in the same step,
> userspace has no chance to disable the CRTC before it is gone. When the

Why does userspace have no chance to disable the CRTC? It's the connector
that goes away, not the CRTC.

Userspace controls enablement. The kernel driver shouldn't disable something
proactively based on a hotplug.

Harry

> same display is re-plugged a new MST connector is created, and the
> re-commit fails in drm_atomic_helper_check_modeset() because the stale
> connector still owns the encoder (handle_conflicting_encoders), leaving
> the display dark until a full modeset (e.g. a session restart) tears
> everything down.
> 
> Disable the CRTC from the driver when the connector is torn down, so the
> MST encoder is released and the DC stream dropped. Reuse the
> drm_atomic_helper_disable_all() pattern: deactivate the CRTC, clear the
> mode, and disconnect the connector.
> 
> Reproduced 100% of the time by unplugging and re-plugging the Thunderbolt
> dock driving the LG ULTRAWIDE: on re-plug the display stays dark and
> dmesg shows drm_atomic_helper_check_modeset() failing with an encoder
> conflict (handle_conflicting_encoders). Verified over four unplug/replug
> cycles with this patch applied.
> 
> I am not certain that forcing a modeset from early_unregister() is the
> right approach, and the disable here is intentionally minimal: it
> deactivates the CRTC and disconnects the connector but does not
> add/detach the CRTC's affected planes the way
> drm_atomic_helper_disable_all() does. The minimal version resolves the
> failure in testing; I would welcome guidance on whether the full
> affected-planes teardown (or a different location) is required.
> 
> Fixes: a1b27e99229a ("drm/amd/display: Implement MST Aux device registration")
> Signed-off-by: David Medina <b2amedina@gmail.com>
> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 045a7f88b754..24b146068739 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -29,6 +29,7 @@
>  #include <drm/display/drm_dp_mst_helper.h>
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_atomic_uapi.h>
>  #include <drm/drm_fixed.h>
>  #include <drm/drm_edid.h>
>  #include "dm_services.h"
> @@ -227,6 +228,7 @@ amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
>  	struct amdgpu_dm_connector *root = aconnector->mst_root;
>  	struct dc_link *dc_link = aconnector->dc_link;
>  	struct dc_sink *dc_sink = aconnector->dc_sink;
> +	struct drm_crtc *crtc = connector->state ? connector->state->crtc : NULL;
>  
>  	drm_dp_mst_connector_early_unregister(connector, port);
>  
> @@ -250,6 +252,57 @@ amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
>  
>  	aconnector->mst_status = MST_STATUS_DEFAULT;
>  	drm_modeset_unlock(&root->mst_mgr.base.lock);
> +
> +	/*
> +	 * The connector is being removed from the MST topology. If a CRTC is
> +	 * still driving it, force a modeset that disables the CRTC so that the
> +	 * MST encoder is released and the DC stream dropped. Otherwise, on a
> +	 * subsequent re-plug the stale CRTC/encoder assignment triggers an
> +	 * encoder conflict in drm_atomic_helper_check_modeset() and the display
> +	 * stays dark.
> +	 */
> +	if (crtc) {
> +		struct drm_atomic_commit *state;
> +		struct drm_connector_state *conn_state;
> +		struct drm_crtc_state *crtc_state;
> +		struct drm_modeset_acquire_ctx ctx;
> +		int ret;
> +
> +		drm_modeset_acquire_init(&ctx, 0);
> +retry:
> +		state = drm_atomic_commit_alloc(connector->dev);
> +		if (!state)
> +			goto out;
> +		state->acquire_ctx = &ctx;
> +
> +		crtc_state = drm_atomic_get_crtc_state(state, crtc);
> +		ret = PTR_ERR_OR_ZERO(crtc_state);
> +		if (!ret)
> +			crtc_state->active = false;
> +		if (!ret)
> +			ret = drm_atomic_set_mode_prop_for_crtc(crtc_state, NULL);
> +		if (!ret) {
> +			conn_state = drm_atomic_get_connector_state(state, connector);
> +			ret = PTR_ERR_OR_ZERO(conn_state);
> +		}
> +		if (!ret)
> +			ret = drm_atomic_set_crtc_for_connector(conn_state, NULL);
> +		if (!ret)
> +			ret = drm_atomic_commit(state);
> +
> +		drm_atomic_commit_put(state);
> +		if (ret == -EDEADLK) {
> +			drm_modeset_backoff(&ctx);
> +			goto retry;
> +		}
> +		if (ret)
> +			drm_err(connector->dev,
> +				"DM_MST: failed to disable CRTC for removed connector %s (%d)\n",
> +				connector->name, ret);
> +out:
> +		drm_modeset_drop_locks(&ctx);
> +		drm_modeset_acquire_fini(&ctx);
> +	}
>  }
>  
>  static const struct drm_connector_funcs dm_dp_mst_connector_funcs = {
> 
> ---
> base-commit: 551c722f40809618230001baccf219193e22fc5a
> change-id: 20260930-amd-mst-teardown-cab8a3731596
> 
> Best regards,
> --  
> David Medina <b2amedina@gmail.com>

