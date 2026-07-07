Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6934FC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB2C410E50B;
	Tue,  7 Jul 2026 17:29:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jM03pjA3";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B402810E50B
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 17:29:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9c24gs81xuWkIAlHIKmW5JQk9rk2Q/6vRM2FqJlIaGwQ5Fooz6oQIAbMPFqoEdGcRSbE6rftXWTZn+BntMDNOi4fAPxm+d1Rr7kfqcmCmtkALbuq9+k2AZWTi6QCBpmpxjqnoJUkayzDxW2WW6lSH5nPYDMkBFkbAHB/MPcLJzN7cuwqIjhUkO5JQGc7J7sYMjLjvJRWkPQCP6r5SJOszPvYc8WFFb+/mutCM/0uaAJXo8R/BhBWQqTzn2wVphW1LXRMk0oLk5ldKFWObSowkqxdC9D72Hd2Q8maYst6PfDQ5oywJkXjDg1LHFqVNgi28H1C/ESW59ukim25JTnGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5qa92KLwZhOZ3ri0V29v4D7H33e9fEDNFiQrdk0etA=;
 b=M8zVE00xswO2/tL7Z4oort8rzOluzyPoVyybiQp7XG644DybPb5EvkkbnX91v3cuszKxu33kxH4q5Hq32VogJi+1dVAZe8kGeq1kjsYEcCaOGUN6nrLiE31y0VNWi+6y6eG9BjLN7h7rLbXWNNBiwdBEs+04ZEPjcGQyqbDrl4eNuOq759+D5EiVFul5Qyv0s3FjCpQn/0mbi9n2g40XKM/WI3K8aBvcBFEds7ue0MNQ6LzWSO8Va7d2ukLuHfvVspKYg1EQmsASeBl1XVVDBLOhFT6I+CRifgRrKwjNmb+eEGhAhxw0C4JaTTu3lJV1AvHLC8WDwLdEKSCXD3Igpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5qa92KLwZhOZ3ri0V29v4D7H33e9fEDNFiQrdk0etA=;
 b=jM03pjA3oD3/5qxTPr+AaE82cN1yCzr7LWapbgCvAbfpoNZwrJGC9pVMi1TGUVoANZ5+K0D4Igpbev/Qh96WU9QIp+5NAhBUOYPCLtqoZiD2ZXv85NqqUwkMwhLO4HtafrI7BpR5Xvi2zRDZDJRsVpyFnN4LzEAu1tLOCDXfcTo=
Received: from SJ0P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::34)
 by PH7PR12MB9125.namprd12.prod.outlook.com (2603:10b6:510:2f4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 17:29:34 +0000
Received: from MWH0EPF000C6191.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::9b) by SJ0P220CA0003.outlook.office365.com
 (2603:10b6:a03:41b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 17:29:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6191.mail.protection.outlook.com (10.167.249.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 17:29:31 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 12:29:31 -0500
Received: from [172.19.70.117] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 12:29:30 -0500
Message-ID: <1ce38058-6773-4784-95ea-0c48af4a0b4c@amd.com>
Date: Tue, 7 Jul 2026 10:29:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Fix potential NULL pointer access in
 amdxdna_gem_vmap()
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260707172316.539699-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260707172316.539699-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6191:EE_|PH7PR12MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f0f879-d5aa-4068-7ac9-08dedc4d4e5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7hBMj8UQmTuu84eXL6pJdzypTYSoouG/OdxhgKdZLsM2DY58J/buF64XA/IweXUuQ3h0xHt7vqwTsJ3ltm7wqM4uOCBHTUxNpbFcKznFZMkXfxm6AiD3WSm/TsHi9sGsUZ+LNDDwpx2RlFaSAhWC3EikrZtZrsTp0xbFvpoaEK/1CdtuoTQOeIh2LO7eKlxDX3CbQ+/aIs1GNssYiXXgQqcJfzqX80IfnjSa3XH0wLjnywhpyZgvtxw/rrkpgyY3iXX2NOGrovUztU8VfUWB3miOe/9xD289WnUOaga6mRZL3Vo3PxEuA9gmJOqvLcWUYzPzozFhpuU+li6Too+WI+9XMbKJoEQM85qcAGOhsPd6UBDoIRxxEKwn/iUb7u6il8qvipWPnIiKiPVn4GOrScki9qPNQ+/VoGH6wOLumn+PYRR9EqHtCQY5YvCqrrLLFXZG3kscUUywAkqGLkNZW+osqj7PAgkXpgpF9xAalvrEhrQcaSSGUOyozdVhhETVGSYE2/csSnFjhbxt9OOs8fcvqjFKettz/jG5EsKaytwLfsEcXTPpgYRX2Z2AjEOJZwps3NWPU/enhOOejWcGpS3NS7z9WgLGlScztj3jd48moueMIRK0LZ4GtT+ciMwIKXX1MsgHSN+xkGWEkvwbSIl/hef8QzuKC28dIpacBVPBgAVhAgFY7ex2u2wuuS/REqI5LAe7Xe6JESVoIbB3SA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qpTapOj/fWFLRklw/kgqjbysH3zFe8lg81ZkrBPyihT7CQv57cDrCu+u1PGYGX6vegAq3F6ZgqtIjadwVA4vFT0IxYqpagTW8gi9WQJgR+/wNEytyv+ADo7F3RAFsMGiax73i4voJfyvfSqVMYKbxEyi6Kiqmv4Vowf4ZU7SQmnOa3fv4WRNLjNOfUMjpLGOrFkDZlexCPpjIergnuhnw521fWr81HPCdQIa/EakwfcXmP2Zm2HtwszWo0Evhm6z/9zHlHQhMZfTy8IHEqYtNr+r942DMNDVnm8G85dAIm1hLbGfYfj/l3nIF3iiVnWfp6uCOuyh8lfYI7ekx83yZcFyU2QC/RTL4HF6kkyOiWx4YUHf1+NoIt8CIAwPbFpaGQLhRE1QMfq/8aRHJiN7YEz1mYhNyTXjvUuDH2xAfXh/VGuN9m7QYKESNUsl04dS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 17:29:31.7320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f0f879-d5aa-4068-7ac9-08dedc4d4e5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6191.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9125
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



On 7/7/2026 Tue 10:23, Lizhi Hou wrote:
> If the heap BO was never vmapped before its handle was closed and the
> user then vmaps the dev BO (which triggers amdxdna_gem_vmap(heap_bo)),
> and drm_gem_vmap fails — NULL pointer dereference at abo->client->xdna.
> 
> Fix it by get xdna pointer through to_xdna_dev(to_gobj(abo)->dev).
> 
> Fixes: d76856beb4a4 ("accel/amdxdna: Refactor GEM BO handling and add helper APIs for address retrieval")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 64c7d82713b0..5033a0e5c6ab 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -198,6 +198,7 @@ amdxdna_gem_destroy_obj(struct amdxdna_gem_obj *abo)
>    */
>   void *amdxdna_gem_vmap(struct amdxdna_gem_obj *abo)
>   {
> +	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
>   	struct iosys_map map = IOSYS_MAP_INIT_VADDR(NULL);
>   	int ret;
>   
> @@ -210,7 +211,7 @@ void *amdxdna_gem_vmap(struct amdxdna_gem_obj *abo)
>   	if (!abo->mem.kva) {
>   		ret = drm_gem_vmap(to_gobj(abo), &map);
>   		if (ret)
> -			XDNA_ERR(abo->client->xdna, "Vmap bo failed, ret %d", ret);
> +			XDNA_ERR(xdna, "Vmap bo failed, ret %d", ret);
>   		else
>   			abo->mem.kva = map.vaddr;
>   	}

