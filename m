Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C3ECD98D2
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 20:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B47C10E292;
	Tue, 16 Jun 2026 20:43:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="adFaSNMX";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAAB610E292
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 20:43:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M87x9XYpfm+UhMM4VpMWnDTBQwmxS69ccHzfoUXPscAtOmT/5P3Xx3WpYud4DpkQtDJ5T6/Ku9KVdCz3q87f6ZX/JlKpcEPkNVc02/RDadxJZO7NRRQFyfGnVH5fy3XKAGaA9TtrsOx9LzuEGET2ZwrEYYge8I836an/3r4LLy19T1qiB/xUrsfTJXIwRBLI317s+sH4DgWCyuWqHYFcpELOO/9sq9XuZ9crQzXLWxtrqWYn4RbugrYCknOptJXrIYm2afpHT7ct7nz5413MD/wejr2/nnzE4eSnbqokN73eddfEsh3bosz/PG7kpj13rXH+xl/LPp4sbq1sDbj7fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvxDIOgXK9RshC7Z6IAPtsXBcsiwlRcWxnGlkCAf79o=;
 b=NtgEWWck/ZjVAuz5X2GfwClvcXGpSvb8pYqbZZnqfymbJsYhFACKwRORHNHq8G5qpPFfaRpzEING9aGumTyZ+zQBw73ROxolQWw2HlIxFb5GHUt3xDTElzOu7nEukvuTRa0bXuBhQ79IOxiRLcpTYqjfByBBfB/V55vEQIOgItL+dnSrjGdjeCDNolLdtAZet1Xv+AATCekh+6MlLuRK1EtL3JwjsZXJPR+1nrhujsmJbcaDnPTJb3YZjHOCQiR5fKi1sRh0NZQoUneUml6vT9wlUp0r9BxYKZAwaPtZu+WrSd1JvR9Gj5SonFhEYGAb2seviv9Z+1Yf9+nYm97LJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvxDIOgXK9RshC7Z6IAPtsXBcsiwlRcWxnGlkCAf79o=;
 b=adFaSNMXawt6ANH49jD19a3DvwuUupqrfyi1N6k1ZSeD6ysOKRpdgiT3BESS+xTW+kZSpWJkFqIhwwu8V8vYSnawcVWlfvBppBW4t8D27Mi1e/ktyAW+twSF2nmTRJYj9Jdz4AilAV87qj49XzBv3IcF6rG7iDEuioNwDp0/+uI=
Received: from MN2PR08CA0005.namprd08.prod.outlook.com (2603:10b6:208:239::10)
 by DS2PR12MB9662.namprd12.prod.outlook.com (2603:10b6:8:27d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Tue, 16 Jun
 2026 20:43:03 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::2d) by MN2PR08CA0005.outlook.office365.com
 (2603:10b6:208:239::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 20:43:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 20:43:03 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 15:43:02 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 15:43:02 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 16 Jun 2026 15:43:02 -0500
Message-ID: <e86c9394-5898-e1ba-f4ff-5677a4a474b6@amd.com>
Date: Tue, 16 Jun 2026 13:43:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: Use caller client for debug BO sync
Content-Language: en-US
To: Shuvam Pandey <shuvampandey1@gmail.com>, Min Ma <mamin506@gmail.com>,
 "Oded Gabbay" <ogabbay@kernel.org>
CC: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
References: <178155468039.81818.12173237984867749651@gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <178155468039.81818.12173237984867749651@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|DS2PR12MB9662:EE_
X-MS-Office365-Filtering-Correlation-Id: e2788613-c65e-4609-1b5f-08decbe7dc8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zzaonh0vsbdekAUigjPnoeQYCeYGcQEpF9Eftu08tdxMrrnMi0Df8/gqcNwhpxgn25fQC7DMXk7svC5iBLP0DtYlicGC0KhR6fK49Psjgyd54R8y235hGetSeQjILX0hIUWPN9T7VtJYfDcucZpexFu99fgqzMsqVUxn/uhX4zzZT1DD9LbPCxeGG8nam9TAo0CZ1Wik9JNea1FmeM0Gu1C+z2zsm2OjLieMa97GDj4TDeIx5kUAOuqUY9ohUFzEE8H0CX/7ksdK+D842NFlHt0AJeoD82dUegvkLQpjGrJr5piaBZkgye7Jfz4V+j3jZuZgUzs+5B6x08bgpomK211Z67cH7UiJjasa3MZ30WqxQJWJEMX41/fe1V/iJ1fHEAFmR4wYfypfc/lqy6ghAGssu8TIHj+r3RNPeZyP52uNBAXWKZSUcVsSUq1V3EC5AKSyuAsDnsnFapHnmEkGYPldgcspQz0OzO46AlNCwMFwuq5CeeXZNeTQnut08jlHS2ZSt/3hDugdLd1aK7O+Ip8QC5p89p10hN8M2i6y31skRJ/l10LXaMfs8Fj7nn0Q0m4lgZk/JZrUJNH9P5LBm4PUwAOs1d4n7jggod5DPY5TVwY/QGGHNSC55DdZnhVEWchx0ZPcRN2Cof760kb2J21cTqYgJ/SStGlH4a/LZSZtRhlAHqYEjrAe2ND4veCXBY6mQXbqgg7gMpFG0QpIAaYg0HEY2n8Ll8x3fg07sj8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EKizOBUigTUMAiBom5KgTdZ6IUkG2K3KiLtIs4fyBxeM1kqqq/HZ3p3MIW2JHmKA0+WAXJpi4XtBmPohyo2HTBHnKewvEMM4YotrXXYgb6GKCtNZBeijNr5tzfB6SUDYmxjDcl5n1XASBBNLJ9KiR7bRqVcg0FOaiN83930naEPESUwP5wefllOUPqRQWY7a3C3NTAFsRrOr7Ybv+Eg/m/+8xpX7y7vogFhiGAhaECsL3rWszOSM4VMauDb6l8LJrZeZlzuKilkqBSeFQo/5o0cIqCk/GIsZYPpmbBssOgmbKfwqqoSjLr/GDXWADl84AV8SfBjKb3fpVvT1yxs19STR2VIKnd2oNQxQft581ORXA9IbavwJysNdDuVPRLHIyo4oL8yoxMirUOd8+jLzRVwp+FXdMq9FadnzYcxMu+WHrgL+lxubtxQBKmQtRuJ1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 20:43:03.1083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2788613-c65e-4609-1b5f-08decbe7dc8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9662
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

Applied to drm-misc-fixes.

On 6/15/26 13:18, Shuvam Pandey wrote:
> amdxdna_drm_sync_bo_ioctl() looks up args->handle in the ioctl caller's
> drm_file. For SYNC_DIRECT_FROM_DEVICE, it then calls
> amdxdna_hwctx_sync_debug_bo(), but passes abo->client.
>
> amdxdna_hwctx_sync_debug_bo() uses the passed client both as the handle
> namespace for debug_bo_hdl and as the owner of the hardware context xarray.
> Those must match the file that supplied args->handle. The BO's stored
> client pointer is object state, not the ioctl context.
>
> Pass filp->driver_priv instead, matching the original handle lookup.
>
> Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
> Cc: stable@vger.kernel.org # v6.19+
> Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 3 ++-
>
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 6e367ddb9e1becb8d03cb4badec25deed38a851d..6c16b21994abc8f0ce58ee6dede219a84ade6825 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -1027,6 +1027,7 @@ int amdxdna_drm_get_bo_info_ioctl(struct drm_device *dev, void *data, struct drm
>   int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
>   			      void *data, struct drm_file *filp)
>   {
> +	struct amdxdna_client *client = filp->driver_priv;
>   	struct amdxdna_dev *xdna = to_xdna_dev(dev);
>   	struct amdxdna_drm_sync_bo *args = data;
>   	struct amdxdna_gem_obj *abo;
> @@ -1061,7 +1062,7 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
>   		 args->handle, args->offset, args->size);
>   
>   	if (args->direction == SYNC_DIRECT_FROM_DEVICE)
> -		ret = amdxdna_hwctx_sync_debug_bo(abo->client, args->handle);
> +		ret = amdxdna_hwctx_sync_debug_bo(client, args->handle);
>   
>   put_obj:
>   	drm_gem_object_put(gobj);
