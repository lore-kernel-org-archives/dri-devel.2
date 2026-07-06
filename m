Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8FFC43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EAF110E261;
	Mon,  6 Jul 2026 22:01:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ELU2mpEb";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011052.outbound.protection.outlook.com
 [40.93.194.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D83F10E261
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 22:01:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emYGI6cM6knXpBsKSctvj1RbsUiuBotjQajyrAy1V8e/yin8MGI3opvL1jNdRCCTS8wYlQ9ds/H3Yh5A0rsZsSSUbfbTYGTFUoaPiTlItZ6vs3hLI8esNCfi/vzYkAE5LVRBUt4RvmTvw6wXHWmwyUClSdqMWPrxWMvA6rjdmcwfyPQ1HzAk13JbRGMlS9Pj15PZjkK7X3oreXhlaPsIjuJegEvFeZpCpvmvw4zEIYAeU6lsVk8b24HTGGWgNilm2MwIwmLYMyIBuyfJQiab7KqT7siN8aUGudCrRBl+GPLoCXA2ASGYipNvhxs20432FCPkyKa4NlAktZb7C6a11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QfWyOhgTWxtX3sxTMWV8FM2/QbqvucSRRIJxKWU+WY=;
 b=aIxF7knDwYrJOXFP5dNovyZ6e72e+YbqUEGmOU9dAHDbMJkGWnZQNdoG9nfd4mXFVKIybiv/fJ2cRGOblZ427z0yu8fd/bQvmKVsDrSH/Ac7q35l0bq+IVte9gAZNAUd6+Tt3J0jeplGUSUov9/RhHq7jArgkRV1VmFiuQObutVc+XKFoPxWhKV/fzu7ZsFz6+7bdwX7Loclyz/BLmrTh2IeXWw6xKBgg0wFneCjCV8qjf9ihUiJ6Z5XO/6RT1Ybp8boOq2QfBv8GSzbh4ap8tN2AW5UzIP1BuFpE5y2Ozw4raPOvolRLvlHT3Cv4btJCYDPO0GueVSLp4sUcoVGFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QfWyOhgTWxtX3sxTMWV8FM2/QbqvucSRRIJxKWU+WY=;
 b=ELU2mpEbgSIATwoQ40C/7nftQ1fN/5q3Gc1SZnI6rAeL89gyEICbarYsTV8B96orfcVw2ScuYpseU9+spcoWD7x1MaP4iupyvilpeh3Vkjip/+ECOtNu3KyQG0cXkmtMQ3jHVQ0AuIVlHgBAolLNCjO8Pem7Tom/rCHOVrePnhI=
Received: from DS7PR07CA0024.namprd07.prod.outlook.com (2603:10b6:5:3af::6) by
 PH8PR12MB8429.namprd12.prod.outlook.com (2603:10b6:510:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 22:01:11 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::54) by DS7PR07CA0024.outlook.office365.com
 (2603:10b6:5:3af::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 22:01:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 22:01:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 17:01:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 17:01:10 -0500
Received: from [172.19.70.117] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 6 Jul 2026 17:01:10 -0500
Message-ID: <d4576d55-b33b-4fb6-a10a-e553637cc911@amd.com>
Date: Mon, 6 Jul 2026 15:01:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 09/13] accel/amdxdna: Use unsigned long for nr_pages in
 amdxdna_hmm_register()
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260616061532.3533469-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260616061532.3533469-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|PH8PR12MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: c1dfaaff-823f-46cb-cdba-08dedbaa1721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|18002099003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: 7hxrAl7Mi2G3wJ98QH6rBt58sugYj2AlNOuGBfV+R5aRvEDDrm4HYE9CXixi1d7oSd3qgnOWbgfUILEj3QQEheK+3XDQNfwoe+PP9S3NhrW+eQpvStjYM2NT5OyyzfPvFO8ItzIhFVHUZOKDjO+GLy7ffl4ih2J0onDPqw8YfAdx/hgIIvfTQNWkZteTOPcHkRUvkIF+9kRE5yh1BG9Tq52mG0MLKGgNBhEMa186I+/ajWo1M3i2WyAghXO97Tz8PbMykVPpNirH4a7UOdHddthcZvWrO5+IZ3LMahBDdB9/cLUcGXEQ5i1jthl8MpIoylsAVBBLZwLn268YwO1mEKDvYAlX1QBl8f/c/iqNpCNj9qJm2SqJSKrjPrcBn+QjiPdUJgFvewKcKBhnPO9dmPQyLmGTNcC61pEirnCpNzY/txJdzMOBW2dfGKFAEdM6IHSC1I4UZtq817p07pnZ9PhPPRCCySBQVdAnCE2Y17nUFPsmdS6JIuCeh4rtB+EQmRyAAJDOmE7e+NkGedo/8vaQJIpaXDqJddgXMbmm5v3M8e3mKi0FodqJjY71Euz57agNJskSGj2wtHKICx7biO1SoylVJrpX6GqD0VNrpY9a1XeIEp2lGB+y/fJyTuKuagMvS0xsVith8lmA4QGedRevDDI1V/0yThZZ9FD/bOHeVKVpkxv/usZL37YCgvS6wCN13fY9vUGtSo5h0vgN5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(18002099003)(56012099006)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zSAkMlkhU9G8XP01IhAz+57uuUqqvAnNWM3bQuiHsvFGPuqOFFhq3As6JK3ICqHt2OCfmO48ogMEkN7wF0jJxO+AYxfQXW+JH471Qu7qt2nbSha0LHQOhaFNZwpRw/zR1x1c6HLI1lV03qIOrmxYznlRZOoSRb7NWRlcPWMGYy0NI+O/DFHuDPVxn6CCtU+0GUfY6m67fa+Nth2co+M8OHlztILUVzssStpWBA1Wz+oXfHFxlxUgcRecAsl/A0OkQU9NR+vNqm9+W7JjnSApmkNBGBkTbYE7/Sq6lEu2Ckg/q9Le3Uxx5ZBDg52htiFX2ZEwZCJY/YPTIrX61w495XY4eFkjhk5p60z1JVcK7gTknMj4dYFhKBw3LLpZbyxpTQRQYu9baQn7D61PR1l9/OgSItHKKcN8AJVVciEdXcNhFJVWJhukO/Ze3qKzoNBz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 22:01:11.1350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dfaaff-823f-46cb-cdba-08dedbaa1721
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8429
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



On 6/15/2026 Mon 23:15, Lizhi Hou wrote:
> nr_pages is declared as u32 in amdxdna_hmm_register(), which may not be
> large enough to represent the number of pages for large mappings.
> 
> Use unsigned long for nr_pages to avoid potential overflow.
> 
> Fixes: ac49797c1815 ("accel/amdxdna: Add GEM buffer object management")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index aef4c23a1a66..201536aff440 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -351,7 +351,7 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
>   	unsigned long len = vma->vm_end - vma->vm_start;
>   	unsigned long addr = vma->vm_start;
>   	struct amdxdna_umap *mapp;
> -	u32 nr_pages;
> +	unsigned long nr_pages;
>   	int ret;
>   
>   	if (!amdxdna_pasid_on(abo->client)) {

