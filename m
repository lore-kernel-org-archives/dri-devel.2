Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DC1606A323
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ijfEmQwu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8F5710E24E;
	Sun, 15 Nov 2026 07:38:04 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5238D10E27F;
 Sun, 15 Nov 2026 07:37:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsxI4dekWxoGhFg1NVWHo9MxQa6ZJiT8emDWMX6ptCFv0QgtvIfcZSl7Ygp1iV1Qa4KZy3LWzD02gdWhrgMY/wF2Ppph/A2PbRyTm7QsVsZXbmZd2tyCKwQQQ0E18hXlEhKZzOCHIxUBijaOgCQrGLsJIyRlkX48EqRwvj+m1eLF72FS33h5ZUme2q3gjU1bkDJjunH37uGpFDQdsRkKfYw1opNV0WcR3FTJw/aGjMG+ulrV5xXXHi/1R/m9V1ttTbRUQs3iUiMzk5/tyvmRKYYPD0Jw4o9PEj6dwrriM9GC1QLX0Rb9ksca5xViC3fqIJ+PUpdYjBx155arr13bsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNBepls7z6HkvoFV1KQjb3mP4gO+2OUviXmpJ7l3i5A=;
 b=LBaDi4kUi9Q9KY670erAXnQd8thzRK1XkBrFnU2to6+lpMQAZrtUeN7Ha1wh5MleyNCzdh4Uq6kiCu0fRsFO6E3pIKWAkUPekaKZVLg+/wVCpZczOfqG83tlyyh8Vo+O/KWrCi7GKU+0U9eMIPloc/TmOLVtAQiRNfK224QfY+wBYkegxAC2cwzwczlReJsSEShdIwrEUmVxUmN9LtUBGVx2PvN9hujWgTxRW72b0i9evSy5fUSqztntNKVogGMi6IhM1TtBySXaDLXAfO0ILKNrL4xuzsmEWihnPqzsB1P/V7++1uhvRmhh8Gd15X5HvL9CfYSvLwqo1eJ3gIhqzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNBepls7z6HkvoFV1KQjb3mP4gO+2OUviXmpJ7l3i5A=;
 b=ijfEmQwuU8OwORWSJe3ssAiRFZxBDLCdocKK96JrJtVUGJ3Va15CkIaPMRa84aYZT0O6FlPCR2g/Mvf8zbDAiD5stEQ0FSdEEwA8xW3VC7bloDVcbrKOK0ZmB+Hj7BZjLULrZg/RaukJCwi0pSgRfAOvdUJqDcVURVEuBIQngtQ=
Received: from BN9PR03CA0801.namprd03.prod.outlook.com (2603:10b6:408:13f::26)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Sun, 15 Nov
 2026 07:37:52 +0000
Received: from BN3PEPF00022BC7.namprd05.prod.outlook.com
 (2603:10b6:408:13f:cafe::3f) by BN9PR03CA0801.outlook.office365.com
 (2603:10b6:408:13f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Sun, 15
 Nov 2026 07:37:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC7.mail.protection.outlook.com (10.167.248.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sun, 15 Nov 2026 07:37:52 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 15 Nov
 2026 01:37:51 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sun, 15 Nov 2026 01:37:49 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira
 <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Jun Lei <jun.lei@amd.com>, Tony Cheng
 <Tony.Cheng@amd.com>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: use include guards instead of #pragma
 once in Core 2 headers
Date: Sun, 15 Nov 2026 15:38:44 +0800
Message-ID: <20261115073844.1477890-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105-amdgpu-local-fix-v1-1-4af7abf820d0@oss.qualcomm.com>
References: <20261105-amdgpu-local-fix-v1-1-4af7abf820d0@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC7:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b4c556-0d8c-4261-04a9-08df42eb5b26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|56012099006|11063799006|261026121527099003|261026140227099003|261026130827099003|261028144727099003|261021135927099003|261021130227099003|261022115727099003|261022113327099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: NtHn8eQMGXeGYaDHtBusQUBSdMDBXsBRQHFCy/YkJDcjTBQ3xF13cNRArY9ZnrP31L/mMfRW0CKbKKSJLRSPn4GE09HOcadpGQd8GDuNx8RARFAj9fVx8O5TtofsiRDVjOfA05/gieq5Gcw/6x8oYrn+DCPQafVylhEDMTGg/JammeNcN0/qrLutuTGJj/9TaG0fO1cYZ+NVgt2hx6R9FchwX7B5Jj/58+tKqxTILJZuf60olRCD8TdBTV6wmOwwTHukeVIPCPImIOMsIHdiWxKOWiJIhzFfioloAY282fO0NXXge8yPFVPxS62NffWUIXP1HjfjK/w6fCnRat/hWkg2Y0SaGYmbi0l4ffdHQlBU8TCN9Ut7ImIsF5BcKuzMK7m3e3hE/tz6nH9ionEzZfBQ1PTMPCQuuUcaGsdZhJo94VHPp/uyyHG2SMY8hU/6WR8nLWlwuD8yf0w/UyvEw6IBcUEJF+wPCpoqDgzwWaQJHdMa0PtmlCG6wmUp5lBXodeaJQ0yN6yfegDYNc7zAFnRTIaEoxj3CtH2cgrWj7OAmxoQDSddAoJo7PPm5y6Hq16rSNwf6MT2k8Pcf+i00ND46rIVuhVy43z1mgR2s/K+ZWA1EQxzSiOtKQEkLtReVNyges86y+C5GGN/+t03kauJyQEUxYuW27HdrWhTY04eoXbW1UanX/6tW9i3tHoiyq07ROZQIlnFkXXElgsgYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261026130827099003)(261028144727099003)(261021135927099003)(261021130227099003)(261022115727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GCBRw3n8Sxrr4z9mgZSjm7VW277Uc6hwEbWHASQECG08T8zSxS6ap/y/EO5ji3bUVt/PQKtlFrqVkCvgcIw7MuFp++l4lP8CLOwlehufuCuc4HMe0Tw2VumNLiF+NyFwpCrOU6iQUWX8uX+/d8VBKV/KB2XvJX9qIjQ48vXLREOLSKPyTc2k0Jd9CncUg9bHp/EYT911M8oUq9Vl18UzbiCk2D+C3TbY5Hh3LWI0j2yraE3z7fxCywE83xRRwDepUn+xR/uwi/HOjQrzYYTI1s/qgNqgu9hHEbBgsTRTsd120rMSZPstFIW9cyK0IZm+3/H5DjLl8GelFdlB0Xet06wLi2u8SJ7NA9SKxocWNl0sdJw+mJExpIyqrkWuYQ6lnCtWd6xrxIOZBrFIkDWbqfje5i5e8lVkhfF/W0yHnxAPeo5CCEyINN3Fb6aSGWbb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 07:37:52.3472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b4c556-0d8c-4261-04a9-08df42eb5b26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>

On Thu, 05 Nov 2026 11:23:04 -0800, Jeff Johnson wrote:
> Commit 9d1a737c3c82 ("drm/amd/display: Keep public DC lifecycle APIs
> stable beside Core 2") added four headers that use #pragma once, the
> only headers in drivers/gpu/drm/amd/display/ to do so; every other
> header in the subsystem uses #ifndef include guards.
>
> dc_core_interface.h is included more than once within a single
> translation unit (via dc.h and again via api_shim.h / dc_core2.h). In
> the amdgpu build all display include paths are spelled with a
> "-I.../amdgpu/../display/..." prefix, so the header is reached through
> two paths that differ only by a ".." component.
>
> gcc canonicalizes the ".." and deduplicates the header by its real
> path, so the normal CC build is fine. sparse (make C=1/C=2) does not
> canonicalize ".." for #pragma once, treats the two spellings as
> different files and processes the header twice, which breaks the build:
>
>   dc_core_interface.h:14: error: redefinition of \
>       unsigned int enum dc2_selection
>
> This fails the CHECK pass for api_shim.c, dc_core2.c and core/dc.c.
>
> Convert the four new headers to standard #ifndef include guards, which
> sparse honors regardless of how the path is spelled, matching the rest
> of the subsystem. No functional change for gcc builds.
>
> Fixes: 9d1a737c3c82 ("drm/amd/display: Keep public DC lifecycle APIs stable beside Core 2")
> Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
> ---
> Issue debugged and patch generated using Claude Code Opus 4.8.
> I have reviewed the patch and have verified a clean W=1 C=1 build.
> ---
>  drivers/gpu/drm/amd/display/dc/core2/dc_core2.h           | 5 ++++-
>  drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.h      | 5 ++++-
>  drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h | 5 ++++-
>  drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h    | 5 ++++-
>  4 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.h b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.h
> index a761e85a9973..867fe9023fc7 100644
> --- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.h
> +++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.h
> @@ -3,7 +3,8 @@
>   * Copyright 2026 Advanced Micro Devices, Inc.
>   */
>  
> -#pragma once
> +#ifndef DC_CORE2_H_
> +#define DC_CORE2_H_
>  
>  #include "inc/dc_core_interface.h"
>  
> @@ -17,3 +18,5 @@ struct dc_core2 {
>  const struct dc2_funcs *core2_funcs(void);
>  void core2_construct(struct dc *dc);
>  void core2_destruct(struct dc *dc);
> +
> +#endif /* DC_CORE2_H_ */
> diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.h b/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.h
> index a4fa0365cd4f..b081801f664e 100644
> --- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.h
> +++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.h
> @@ -3,8 +3,11 @@
>   * Copyright 2026 Advanced Micro Devices, Inc.
>   */
>  
> -#pragma once
> +#ifndef DC_CORE2_INIT_H_
> +#define DC_CORE2_INIT_H_
>  
>  struct dc;
>  
>  void core2_hardware_init(struct dc *dc);
> +
> +#endif /* DC_CORE2_INIT_H_ */
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h b/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
> index fee03a5dd596..00cf48b14f53 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
> @@ -3,7 +3,8 @@
>   * Copyright 2026 Advanced Micro Devices, Inc.
>   */
>  
> -#pragma once
> +#ifndef DC_API_DISPATCH_API_SHIM_H_
> +#define DC_API_DISPATCH_API_SHIM_H_
>  
>  #include "dc.h"
>  #include "inc/dc_core_interface.h"
> @@ -17,3 +18,5 @@ struct dc2 {
>  #define TO_DC2(ptr) ((struct dc2 *)(ptr))
>  
>  void api_shim_construct(struct dc *dc, const struct dc_init_data *init_params);
> +
> +#endif /* DC_API_DISPATCH_API_SHIM_H_ */
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h b/drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h
> index 35a6218c1285..264bd8bf3bc0 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h
> @@ -3,7 +3,8 @@
>   * Copyright 2026 Advanced Micro Devices, Inc.
>   */
>  
> -#pragma once
> +#ifndef DC_CORE_INTERFACE_H_
> +#define DC_CORE_INTERFACE_H_
>  
>  struct dc;
>  
> @@ -29,3 +30,5 @@ struct dc2_funcs {
>  void legacy_hardware_init(struct dc *dc);
>  void legacy_hardware_release(struct dc *dc);
>  const struct dc2_funcs *dc2_legacy_funcs(void);
> +
> +#endif /* DC_CORE_INTERFACE_H_ */
>
> ---
> base-commit: d7e11a5269dc892cbee8a01dccbdb20bb4f653da
> change-id: 20261105-amdgpu-local-fix-908074837d48
>
>
