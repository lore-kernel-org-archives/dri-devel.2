Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FFEC5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:40:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 579CE10F320;
	Fri, 21 Aug 2026 15:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pzJS8pKP";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FFFC10F320
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:40:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=taNLJV18DMrMprB+hDiNKvpdawDN1hdRJbUJHz6H1KLdtsWRZdEaLW0ZQmIo33XDSQn6/pTP1Fub9j4AU0Ve3mS1Q/43U5jmwTWGlIos5eTvgLd2Uk0Tuwqn8JM6v2vnFRsDKw0nGwwoUnQuUy5yKswJRHYs9jOyACTykToiJLK38CHsc2uBvV3ebdZYg/CBBJ2QPbKwmjizmLg1pB83Gmtu5sQEc3dEKthrY4YwMQNi0z2e4oPdSpbHyQfGK7+hu07w2c9RkjsXy4zf9wJ2tgCDUYZMeq62q1YkzizcD4aRk0tIxZmmUYu1GRjvkadJzA+R9vpibHIWOeoYO+dvog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiKaHLRWyLglqoNXv0xdSkCXcVi+5sLPmWUf5xjrfgw=;
 b=PuQ/VKx1PpFL1edlk0ck3qQICq2CPKZZj05utOX12nMJVD2F9wkQyjIGwWQmaTWttStRcwdqRYn/jxnb5UK/w6VGxLuaJPQSSgndfN4ccN2aOAidlYz/2jY4rpCBrGfbUXHC8lK0Rgn05iqz07KgidOfjJiQLKRUoW79Ir0ImXa9w8r4bLEmZjbhBr1SQiXF6A2rxLkwAUh4bjXw01gL3XjTki8/oxPuS3zBej30UrE5FBVTX3XL+TUclHRCw1YV+Csx5sH46iKdLxvZT8v1YxQE4e+7tGY5p3Px2FaETa50foj80q6LDGN2U/NccrMb1351tryqK3QpXelbvZxUog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiKaHLRWyLglqoNXv0xdSkCXcVi+5sLPmWUf5xjrfgw=;
 b=pzJS8pKP8fwJSOsni2Z0DiQQyALh3T4ecbSE7UWeI5bgoaBqaA5wxieE+nxP4Eni2xCmmC1iBbGFuDxSA6aQm4VWfIsHSYXUXcGXu/jVLcxWvUPZN2746GKuUmBcu07Irneo0QskiioSFcFNc02g/1b8AdE2KrgKRihMVEC9UWI=
Received: from BN9PR03CA0124.namprd03.prod.outlook.com (2603:10b6:408:fe::9)
 by BL1PR12MB5897.namprd12.prod.outlook.com (2603:10b6:208:395::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 15:39:53 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::58) by BN9PR03CA0124.outlook.office365.com
 (2603:10b6:408:fe::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 15:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 15:39:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 10:39:48 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 10:39:47 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 10:39:47 -0500
Message-ID: <d359981d-710b-dc52-9741-39cd5ed884a1@amd.com>
Date: Fri, 21 Aug 2026 08:39:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: put the chained BO when its mapping fails
Content-Language: en-US
To: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>, Min Ma <mamin506@gmail.com>, 
 Oded Gabbay <ogabbay@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20260819230852.287751-1-taimuraz@kaitmazov.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260819230852.287751-1-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|BL1PR12MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a56b42-df78-4fdf-13a8-08deff9a71a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9//fhQpz1uBwBEGWPtBafpXEefeobAYH6rJ9FdB6grCL45WdOqTB/OZCaozRwqj6NO30b4hlmxhN/kpK92eCpMf6Ko00vgp1Dkui3hVXqB0P9v8grEA5svo8K8L5oOrf7UuWskB25j8eflLb/TpBoIYvgdAtzhPtGqzraz63I57BCNsy/qvu1S4FLjIX5CWrxWkvgbLZYObDT5yeA+QqctvEGUaHQQeLitoaXebhF4Bnvj83pJX85A7VJKo79mfK3K/lJUSGHCeuQ4Mo/piggEeG2IL3TZkWLy5XuJ0Oh/HFegFxUbynpNudtMbykqqgm2hPxW4Xtug12ainoB7uxihGFHVHrK2JhU+C9TFg1YuhprDaYIDsL18wLxhyiY7bb829wJVibZeQHCarjbKebQ6vmJqAmTPCHLorXpVHZZnAnMOnVjrNmxLk1rO0loP06mTZU6P6CfURorana3c8paBskeCdkQImYK1X06TC5V1IpH33eNm2/0YXHaDTq2cGEgxZzJaRnTeeAC0sSlbaPPzuF5rvRAvirAC149sajbcHkq93ISPkzr7qrugP4I55wkC9ClE04k0cUjLbIwafIaa39j2N7FAe1U8q/gdLswGaJIXD/KkwmFtYvq9NbWh7E47AYaOVAD6nzYc1Gx2QCCUwL94LxKgKX71vgrEayZLPAt9EJZSgOMUhIH8SrgTiqPIc8OGeOxOoAuVH0EZxNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I3G4JetPTdBIHeZZBtqdKq96VqE+LVaPPud2rk0aq49J3bLj1Xj9WVgDWFJ54/e0ERSWJK9OhFT00e4yrzJWfWCYTdVvi6m3P6oHXrP/cAsrnTQdrHfMO4Rtg8q1GKP6F+foYrrzKdq6If2sbNMhwW3PA/Sd9B2xK1g0e+d3F3NPWYnV8e7az984Pu8gG51HjpMfRHif6OhV5m3AHq2VEvWy3nFqVKIJSkOkCYS30bcOwooPApaJv2tDe4J+Yjdp7RSgf1jbse6FS3vK2yq3zCBX49y7yDFZWHzheIOJHCAjgTQ8VVKXeAA31HfAtEVQtJviViOocCf6D7aOTVoX/tXGkGhxp17RDrF/FEVFgwaAm+SGyIa0pZGfYSiCg80rOrWJKfK2FsnIoFmam3DpLLB9CZbRbitrGVxFLaIxWWZCGKy7cs375TpzclnvYgwT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:39:52.9174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a56b42-df78-4fdf-13a8-08deff9a71a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897
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


On 8/19/26 16:08, Taimuraz Kaitmazov wrote:
> amdxdna_cmd_set_error() looks up the first BO of a command chain, which
> takes a reference, and drops it at the end of the function. The mapping of
> that BO is established in between, and the failure path returns without the
> put, so the reference is leaked.
>
> Ordinary use does not reach it. The chain has been submitted before any of
> this runs, so aie2_cmdlist_fill_slot() has already called
> amdxdna_cmd_get_op() on that BO and amdxdna_gem_vmap() has cached its
> address. What makes it reachable is that the BO is resolved again by
> handle here, and the handle is userspace's to recycle: closing it after
> submission and importing a dma-buf whose exporter implements no vmap onto
> the same id leaves amdxdna_gem_get_obj() returning an object this cannot
> map, since prime_import() types every import AMDXDNA_BO_SHARE.
>
> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
> ---
>   drivers/accel/amdxdna/amdxdna_ctx.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
> index 855da8c79a1c..4e4a9cf5c327 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -183,8 +183,10 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
>   		if (!abo)
>   			return -EINVAL;
>   		cmd = amdxdna_gem_vmap(abo);
> -		if (!cmd)
> +		if (!cmd) {
> +			amdxdna_gem_put_obj(abo);
>   			return -ENOMEM;
> +		}

Thanks for the fix. I will add 'Fixes' tag when I merge.

Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>


Lizhi

>   	}
>   
>   	memset(cmd->data, 0xff, abo->mem.size - sizeof(*cmd));
