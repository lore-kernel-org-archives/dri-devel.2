Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4521CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 16:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DFFB10E60A;
	Mon, 12 Oct 2026 16:44:13 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011033.outbound.protection.outlook.com
 [40.93.194.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 933A710E60A
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 16:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYG86FvHAaCG0zFLyxFM0ky1GS+LmO6ZyGOU6v/+WUwKbi2Ry7IEfIpNMWdDz1gMJ7lGetLiT9nv5Zxh+cXLzXSyFSpN8m0tZ7z43C/1IFWzpW4/5t2QoY0KJWl1ZR5BuVsy8DK31pmHcH6SavPVKkU2ULyy9As1nf4cZzScxrgXB+tGzXjsLF7W99FsTGE+H6X83ND5Z71+iN2ol1jvY3r+lCbdLByo6KAu2MTZQ3rTh2rB0Y+yy/wPawjVobcxOtSpbQI+0Ms+l7x09dqt2PxiFCjoGcO/j/O6g0tXNF8VE0oGq8sf3h/Bu2TIbNaEuQhUHmke8h5gyenQJYtLsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6ycvoK0mY7fJ1RJe/3MsiMrJ/HB/V9u19f5ZVoOxgw=;
 b=TueHqGdNBRXJ6Hb0tMabZOBhC1ydgLEdfb0uqseg4ShltuSZIolc8SyayoMU/wS5hl6v0JhV8UokXUqQb2BjXXjTCB7q4JIx0t8qfnuG4KoeIT7ECP5n67FncPyZ976w++S8YIybNKUZAY+A9ea2aLnAhnj3nyJYeFHaEeSVE91YPXshHLOVdUTrb8qoyeMiBm0ctiUK19nQUNIluKw06XJZ50Gm14LDIK5AQWUZX4sfIzxyBUxcFADabg8PJIkKzj3+MTh1pOq+kJSS7ucklxqNAJLWeHcs2IAsmlLzzT5rvLnQ8K1KoXuBX83ATXJhw9K3Q26tcwRIWJx+31XHag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6ycvoK0mY7fJ1RJe/3MsiMrJ/HB/V9u19f5ZVoOxgw=;
 b=AS0SFEVK3Veu3EbMaNQ/63TkPmb5DvZOd2b5VPLNPMqoF/k5zStBjSAUDCHCffxncoeTTSaCGpxC7T8B1WLWUe1nKSJTWOOenPzBlBnpzcxvkGg/NlyCMdVE85KnJwu/fLnPUOX/V+zJjA5oJKLaGQgLnKpqNJ2zTXNSmEHDX1Y=
Received: from DS0PR17CA0005.namprd17.prod.outlook.com (2603:10b6:8:191::6) by
 CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.17; Mon, 12 Oct 2026 16:43:57 +0000
Received: from CY8PEPF0000005E.namprd21.prod.outlook.com
 (2603:10b6:8:191:cafe::5e) by DS0PR17CA0005.outlook.office365.com
 (2603:10b6:8:191::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 12 Oct 2026 16:43:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY8PEPF0000005E.mail.protection.outlook.com (10.167.247.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Mon, 12 Oct 2026 16:43:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 11:43:49 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 11:43:49 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 12 Oct 2026 11:43:48 -0500
Message-ID: <6a124bdc-06ac-79c3-7c26-d9867f9c5abe@amd.com>
Date: Mon, 12 Oct 2026 09:43:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: Reject device heap BO when dev_mem_size is
 not set
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>
References: <20261008232416.2646054-1-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261008232416.2646054-1-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000005E:EE_|CY8PR12MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 077a5b32-bc6a-4e0a-c1a1-08df2880014f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|261009223027099003|11063799006|56012099006|10067099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: OiAIDkbbsG+mby9udan1xE53+7uXDe0IwAdLfLdyv9JI5g7b3JjNDIZavSfMFuO19cYVVrK9KS/Z2G92YpDZHY6l6p4J96siTKlw9FZSANfAuxjQORJgyLcJtEJFZ8Eu9U//Gh45wcRalbV9aiwrQOp7HtX3BSjvvj3ODoqTirNzz62gOh6Lep4G9be1lsy/SrdPyUEN5UMeBdZG5xFjGvFOC1kPqhUWABOg+njxyT/X2komg0nQQ7Lo+E+Ucx0TsgzBWbf8OLDVskR1eLaXZF9dVBaNwA2+jaBG92pMVLmMONZ81r1ZkZq7kZGX+N+yk0JztB5VgI2YeZqpQ/xi1YbE9QVbgK6VYUCAs3/L8Qv+pn8mBQX1JeIonqqodggCJS+ozUZzTkLiLqNEGK1IExYjwhzmDYIvQ5gEu1FKpap8oqg2QqUXSfd8yOXif7w4eE8eI0EImPpyu9OEwOjrNTPqFe8D6SD+UmFXGSUbFua1cjwe3cobTXmyuboP4jZAPB0zjnL51zCc9pJAP/uA1ol18eWJDG2RQP++Be1v0bKUKdR4R0YzsQJcqIZGhFCd8LXDv/I73Nb35bw8IZWZ/6uwz/G7bdQ46RLMqCP47RD0/6pMdGWbH2rP7CHHzCGNoDfogBOfAgMvHA3VFLP8y8UJuruCojRa04Sx+ZhZHOtDUKOYfyUuvs0LjXYwIP4ldhHavG+3I3dyXvX5NKlgSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(261009223027099003)(11063799006)(56012099006)(10067099003)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pO6GIuF2HyukAQjoVVz9NFnNo2j/qjH1ApfBKa3xGAjQWGr4IeEKOtoh9MM4O5inziut+fGeCy2vq1KpYZ5cITV7W6MfYL7dBr35/ugAcPRk5Gcfiw1qIJQVgFlZqDhhKJ2754Ljc5nRPE2lWNuLndJVsKerpq21Obhg8XfrSNY05vburQBHV7vJiou8iNDp/ttjngTzgXNI2GXvB6mrs8uDMg081ma83+hgeVXXJI/p4PwQ5cPRKa2QJB/WXelwKTJW0TQMV2AvusiOMX0gb18EbqqO/oT4i8Q30fyq8UIemqcozMmMViWRo1iYubdAacv2PGryiBvUBQdwE/OMVe5y07AMoaTsSQxQoWnucJ//PoMrcB55DGrwWSMfmv1Zz9YSF2JVxpB1dUgFOyc3JaSJKDYDe1envHx3bUZYFLZg1u7+0a1pPuaJt6Qfp/Iy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 16:43:55.1943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 077a5b32-bc6a-4e0a-c1a1-08df2880014f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF0000005E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538
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

Applied to drm-misc-next

On 10/8/26 16:24, David Zhang wrote:
> NPU3 devices do not set dev_mem_size, since they do not use a device
> heap. Creating an AMDXDNA_BO_DEV_HEAP BO on such a device hits the
> WARN_ON(!is_power_of_2(dev_mem_size)) check, which any user with
> access to the device node can trigger.
>
> Return -EOPNOTSUPP when dev_mem_size is 0.
>
> Fixes: d76856beb4a4 ("accel/amdxdna: Refactor GEM BO handling and add helper APIs for address retrieval")
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index f4832337ec31..f14484bc31ec 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -1140,6 +1140,11 @@ amdxdna_drm_create_dev_heap_bo(struct drm_device *dev,
>   	struct amdxdna_gem_obj *abo;
>   	int ret;
>   
> +	if (!xdna->dev_info->dev_mem_size) {
> +		XDNA_DBG(xdna, "Device heap is not supported");
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}
> +
>   	WARN_ON(!is_power_of_2(xdna->dev_info->dev_mem_size));
>   	XDNA_DBG(xdna, "Requested dev heap size 0x%llx", args->size);
>   	if (!args->size || !IS_ALIGNED(args->size, xdna->dev_info->dev_mem_size)) {
