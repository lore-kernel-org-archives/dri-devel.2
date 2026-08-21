Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59048C5DF8C
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 19:25:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AACE210F5EF;
	Fri, 21 Aug 2026 18:52:57 +0000 (UTC)
X-Greylist: delayed 2001 seconds by postgrey-1.36 at gabe;
 Fri, 21 Aug 2026 18:52:51 UTC
Received: from BN1PR04CU002.outbound.protection.outlook.com (unknown
 [52.101.56.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DB7B10F5EF
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 18:52:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScSrrabrnpJSDO4wllfxieEWafT9wtcPwHuMF9BLgx7OJg/91By9UsKE/wFJwejXmdo0t/Ro+HFYZuns3LkQGUL8R+MwhWbvSRgzJVXikIkLDg+h3ogRbxL0ql7K6TrtbcCPcvyZ4k74xGVhp7nF32Wzmfq8a4m/O29DJEf8p6ifoDnZqPEQUIKyki3iRRLrYnhisjgfNLEv6JQuZAtPVIDxyn1hNOeQtGQ1vjmjihCT/xk2XasSaHHMNHx1sWHeonty+GgsXLvZZty2V2Egh9iXJu5/k8IUw0Orl5ojtLIcBRvw7DFrOU4j1nRuKWG3szQEC5t9Zfd6tZqFl+Sycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwtYe1dsfQiDYh3BjVwXcmKRYLmtjxj4VUF5RVWLTBQ=;
 b=e6lY96CxgS/QeOoVyBaP1+rh4PvVR6vlntUIeMfgOS9vNFXcJaStWHDW3xF2Xax5rltuUavaWFxRtivTN8axdIfFsn+2NEJP/KgfamJlBgK9/sblUagTMc0Xu6PQ/RCQI9bY1dEEg5A3ihDWwMUyuFCzy4+SPVka5EO0BeM4YPFn3RReArhKWuJVDnBre2mVT79Cnh+BUzrrYbmGowKEXvIVP6amYaAQjInD9DAcnC62rvV7kNnlbJMBc66MAbeIvuJmcazLxN7EtRjTT17s2h8bhlAROxSS0gRdjf7ZA3Hr2Fz5PZ8Vkg/xh76DE75vKkaGPCF3PXekI0koKqb25g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwtYe1dsfQiDYh3BjVwXcmKRYLmtjxj4VUF5RVWLTBQ=;
 b=QDp19K5cG4FTlOQTAACW6eFr+ez+RMaDuLdUnvUOuPpoehOLITHy5nZ5u6B6s12NpG11LsOPS42rR3/CBe7mgbxv1/b3TuAPFeIQ6v6XxHITzzGwfYuwY3ZZADL2ncUJou42OFFEG+MWmgBZngwCbxcOSS81rMNGg1W8Y5oZw24=
Received: from DS1PR06CA0013.namprd06.prod.outlook.com (2603:10b6:8:458::7) by
 SN7PR12MB6909.namprd12.prod.outlook.com (2603:10b6:806:263::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Fri, 21 Aug
 2026 17:50:47 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:8:458:cafe::75) by DS1PR06CA0013.outlook.office365.com
 (2603:10b6:8:458::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 17:50:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 17:50:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 12:50:45 -0500
Received: from [172.19.69.26] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 12:50:44 -0500
Message-ID: <7ce13e6d-0da6-4d6c-a05b-3ad5e67499f4@amd.com>
Date: Fri, 21 Aug 2026 10:50:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Remove __counted_by from struct
 amdxdna_cmd_chain
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260821033543.1839719-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260821033543.1839719-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|SN7PR12MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: 0736635f-e423-48fa-dc68-08deffacba85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|56012099006|22082099003|11063799006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: ZLdACPiS5ivNlg4WVaSB0d2geeKs7zHVZHuAEGDPXr279ugebruapJcNkYUB4XqqWYj/g+uo/8H3JttE4flFgG9lmFVHpPyOj87z/5Vi4j3WAh2AGrGoYMO+0xZut5sSgMvZqmgVU+UEY2LJjYERYiuW1Xiemh3cPPiKNbVua9avlKdLM/UUXhkDm0fOVZ/MHy3XdNBzuGTqXCYRTaPgjMAYr+7+Fav7FG7YudCcUvmEJTnDSxgXBs/njeZpbcoZsvYWw09+CN4shUMYY91SKL0iHzBBuOrMMfnwqCYObZwMQUExxkcBEruUbYbWh06jSb77oLY6pKbJcDLgaIkhQaz/WVKiuW3+HzjwcK7IE7+GKtXDniqB0iZLnBOy/ZH7fKAtqtZLuO4Z9EYN+TpkjHLSkIUx19GHMyiwrgddPf0fjSioIkKXjbZXtuaZNIsQPqrcCHljis46Fq41zPMrE178vj2mmWNMCDcA8R6P0chk2q/oI2JpqJRztASS5vsuzKMOeXKcMY4uzGpFVA0eE6tIZLhXkhdch30ECW4mMLYuCucO3tsForH9a9q6ouqIR0+1ESpVpQ7gH8tPAm32Lyif9crZU1PW1z1wo6IfWEoFL9HjjecLq/1Vx9LNIWnqBMk2wpe82TDoFrFZ+TamQ9/jfnjow1kqOPW3ptszHh4epL8AYf1PgexpMI4lrYwTgECR9sqjQ6HHm2j6yrVFyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(56012099006)(22082099003)(11063799006)(10067099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JN8C6YMCfQ0OjYTRm5dczTwhvUEBj1Dbrwhcz3ehGTlFh6viCtef55KegHLB2ahSZpZIS7b8phyR2xUPnUA+/5Uwmdlt6EK1LbZliWU9BIVDElr6Cizgrl/Lmtli4C0lZNDSRKbTuykyR/SHX7u9v9r7rh4Ke8PoC3CXtdTez7CvQ5rkOlZpiGYjtAjZ2/4E7wog7dx0vDCXbxK2lw1dCEutgTDVe8TUZqrt/ij5LWbfBAyLLtWcxRkof188s6MdB2yigVLEX9hd7zDDwESdIVnNn0lKLMWvgRCTA0sZMN5U/DiWccvDP1us5lH/Q3TW1A8pTpcDbpBQA/qr/HSmIvSM+NgI0AZEREYgpz+ClDRpM68ndb2+gBZvZ1ZjRcXalwDU+StoSVdKT5UHZytqYSgadt0i2bm9cRZyMlsoxXGtNOvdMI0uBXy3vsFRQhds
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 17:50:46.1343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0736635f-e423-48fa-dc68-08deffacba85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6909
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



On 8/20/2026 Thu 20:35, Lizhi Hou wrote:
> struct amdxdna_cmd_chain contains a flexible array annotated with
> __counted_by(command_count). Since the structure is stored in shared
> AMDXDNA_BO_SHARE memory, userspace can modify command_count concurrently.
> If command_count is changed to zero, the bounds check generated from
> __counted_by may fail and trigger a kernel panic.
> 
> Remove __counted_by to avoid relying on the userspace-controlled
> command_count for the flexible array bounds check.
> 
> Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
>   drivers/accel/amdxdna/amdxdna_ctx.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
> index e6155f4b5db0..010538cb05a3 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
> @@ -56,7 +56,7 @@ struct amdxdna_cmd_chain {
>   	u32 submit_index;
>   	u32 error_index;
>   	u32 reserved[3];
> -	u64 data[] __counted_by(command_count);
> +	u64 data[];
>   };
>   
>   /*

