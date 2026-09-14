Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AFCC88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7870910EFBF;
	Mon, 14 Sep 2026 17:38:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tQTU5BZu";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010054.outbound.protection.outlook.com [52.101.56.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A3E210EFBF
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 17:38:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1NuuHfLkOHwR1+QkIYXTcbcx/iReQ1n8rk2hbk0775ULEKf52wggYS0fZz9+sLDS/xVbwa07qXnle2+hsP1P8LheO31QqainF6NtS+jMSe151PsSy41Z/pomgfBVoVxomxDZwD9UHeh4rMOsn0whVtZv9BfI6X2Ro1FNn2YfPvlw1ySxYKidXnS52LjiWepwG6le/1FB5phnE4QwT5UtrteLJOHTroMY7tbnW+w+sk6HgWisuALj3owAsYEMsmHlJpweRPq4+zw5BnY2dLGLqQOTg9U6S0lfnttvfc03SekQ6TD1Aktx4ECLu0MLxlfuZXxJu6kBEGg6YY5SlWR4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1bLN71/p7mwFZxEkhokLgVAvzZ9nWmh3yo5FMI+b7U=;
 b=Q1dOOx4SRbCtXMhjyHzCyE1cM671bHpJSAYfTDGhpio7vLT6732W3KVJx2Db2H2Q7cfjDp7zrXVublYTi7Hs+7jKkzHWGPrenFYMtt0/uiD2C7NuXeUM6yAs9UnjDZG01jLNgaj6+t2dl1vrTwRgj2NhoSwiB1I+pRm582z4KQkeyEwriHhoJLTdgDYDiyB6+sYg66MTzbMWb9qXoaxS0L6VCZ3WumtfG5E3D7uHv3jB8inSsHxTpCkXFqT8TWzh3i29+qKk2EKbUPSHqNv79PlgvDN9XF7JUUlqqruwfP7+sbzbgaRYOYhj8mCd3Z92Q8fNQuQrXwq88ahOD9neig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1bLN71/p7mwFZxEkhokLgVAvzZ9nWmh3yo5FMI+b7U=;
 b=tQTU5BZuDA4ngwXUZreuZRRq0fULGMFzWe+LwFz46LeUnrkZVelTwZKsLPWFs5kJcxp14vhSEs3y+guXq0LdqTJmoWCMKhv2NFALvGm4JPlhGv+TIhtgjGtvxUsa8gnhvf4zza6Oe/L/VRFNTC1VFWrgDSw8RYMMVmrH1xxiNUA=
Received: from BL1PR13CA0386.namprd13.prod.outlook.com (2603:10b6:208:2c0::31)
 by SN7PR12MB7785.namprd12.prod.outlook.com (2603:10b6:806:346::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 17:37:58 +0000
Received: from BN2PEPF0000A893.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::ab) by BL1PR13CA0386.outlook.office365.com
 (2603:10b6:208:2c0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Mon, 14
 Sep 2026 17:37:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A893.mail.protection.outlook.com (10.167.248.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 17:37:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 12:37:57 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 12:37:57 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 14 Sep 2026 12:37:56 -0500
Message-ID: <02d63343-acaa-38fd-e007-33256bb5f409@amd.com>
Date: Mon, 14 Sep 2026 10:37:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/4] accel/amdxdna: release the chained command BO when
 vmap fails
Content-Language: en-US
To: Eva Crystal <0xiviel@gmail.com>, Min Ma <mamin506@gmail.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20260912081012.2274075-1-0xiviel@gmail.com>
 <20260912081012.2274075-4-0xiviel@gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260912081012.2274075-4-0xiviel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A893:EE_|SN7PR12MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: 42523df0-3c4e-449d-5c8a-08df1286ea7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|13003099007|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pmDCgyQww/j8p8v8tieUznxsyTSFf2S4uSJSoeAwcLwY8e2tUMAA8NR547BeBgAud548eRJg8uWP+zA2W4fqtJ/5asLp8VvtPEtENkyVuXrCX5T2OmA7KEZ7JCDcGMF7/yFw90X4+/C5Wzqz1+GbJ7uUuL+tp0DIzAQk3xCZUeYKeak8+1jyKCYCiQV5SMegMRRhqAA4oyyx6WbNFmv1SWns7KoH5Q1YhaSWIdRDTdYLY92bpPHv0u//OItzWYOQsKyK9UcwtnBxEYFnQkJM292qG6tC8bCC4DEh/lZtCSP+BW2wbT2QfX9ZiBN0MeRldLmqUErDOrvodv+fNuWxMyBJ50YigtxhOmC678X/Ht9O/NmnLL9wsT39L7tE/HO0txuyLFTxm6rWlqH9iV6fa1qNI8WVcC+uphcJkiR8kTJuKbdZHLeBIP7fkZs624s+p2SQqX4ElVpD7hzZXDW8cgv2LYiYPZ6JHP6uXZp+6Mvayjz1UWoGHRcr7YXsxS2cOJhnnsudI3w9vIcncTR+Yoc3abHU57NZ4Q0xV1rmBySmWxgRvucXue1S/slDtmoHdYnZj8mRUYg/Ei4k3j3TCF11QG+K3LecNsvOV+MovwTthS6ZTrNLFWsc65ic7ubk1PYo9q4OL8o48+gsT01KMwjCpQAoFQ20yWh7S4uEKOLzUGGGcW4Msqsf3P/BlIOjT8TqyPYAw8F9m9KJF2E7Lw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(13003099007)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BXrAGU3ewRpgQFZO/8P7grANjoqpqG/spRZ2UN6bNXRNcu8mqBuPa+cZos7fbvnGljadYGp9g2g1MjJ+t5SBgWiursWQbLPyNk97d54pGj4Fd1MdBgklHpQZOBjebK0LQctAy5YYqC6Zjmt1IWiIsLGLUk9WKyaF4tcwjcyTJlaxvZhuInHjZKWjP9+25JcZz6GL7VfkbE52ydz9sXz67r2Cy/Sc/Uyii2DtV8mXMILc3YBT9uAx0uNnqzA0/jssVULs51jE3tBW3ykipWXCd9b8ME0KXEHJu4b9YxfqD0MQ9svBaNcOxufg53hDWBosGolu6/I4v6jqcVCPG/Xfg7P/S9hvTJpB/N/lw07gqsNtecZ2oe305928I+W/Jk5c7DJuAhVnyCTjaMZSkcJGVbjfQB0Du2G/UsmtvbkI7vvs/k7mNffWekHWohWc1jZZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 17:37:57.8468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42523df0-3c4e-449d-5c8a-08df1286ea7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A893.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7785
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


On 9/12/26 01:10, Eva Crystal wrote:
> When amdxdna_cmd_set_error() follows a command chain it takes a
> reference on the BO named by the chain:
>
> 	abo = amdxdna_gem_get_obj(client, cc->data[0], AMDXDNA_BO_SHARE);
> 	if (!abo)
> 		return -EINVAL;
> 	cmd = amdxdna_gem_vmap(abo);
> 	if (!cmd)
> 		return -ENOMEM;
>
> and drops it at the end of the function under "if (cc)". The -ENOMEM
> path returns before reaching that, so the reference taken by
> amdxdna_gem_get_obj() is leaked and the GEM object is never freed.
>
> amdxdna_gem_vmap() fails only if drm_gem_vmap() fails, which needs
> memory pressure or an exporter that refuses the mapping, so this is a
> small leak on a rare path rather than something a caller can drive at
> will. It is still a leak, and the chain BO handle comes from a command
> buffer user space can write.
>
> Drop the reference before returning.
>
> Signed-off-by: Eva Crystal <0xiviel@gmail.com>
> ---
>   drivers/accel/amdxdna/amdxdna_ctx.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
> index c24bf1c..7a61e83 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -170,8 +170,10 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
>   		if (!abo)
>   			return -EINVAL;
>   		cmd = amdxdna_gem_vmap(abo);
> -		if (!cmd)
> +		if (!cmd) {
> +			amdxdna_gem_put_obj(abo);
>   			return -ENOMEM;
> +		}

Thanks for providing the patch. This has been fixed by:

https://lore.kernel.org/all/20260819230852.287751-1-taimuraz@kaitmazov.com/


Lizhi

>   	}
>   
>   	if (abo->mem.size < sizeof(*cmd)) {
