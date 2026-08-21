Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC78EC5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 19:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5800310E348;
	Fri, 21 Aug 2026 19:59:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="unafybPE";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89E9610E348
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 19:59:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AscSKV2qsfFmpuen3OPpB0wTbnfy4YPdx7ktXj9kbDOAbgsL/3A8IE71EjiCOZfIVgfe4zavssnmK3V01c1o0HlRcRhp+T4wMiiVPitbVcUgzQQ84iwYV/08jfd297WX7i57V4X56+KyQUrgDMoYgTbtILBAVXIN2CXxEpyIxjHGCtdruEfgoKYzGie5pfiE1VA9m+r1Ye5l+1k0uti+1yWutDjccjPxEyeNUFC8X13q3dpRq679eGYMJUYqBNc3nAzOVYI9r6oJdm1qOXeS/ws2WA6wFWgxwCQr8HDKOoaLAiskqtmKMCQd0nQeoAqcCJhxbB51UZCfGsiARyyIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rq0yEHtS+Cz92dCzyGpzXwyfl+aooHEG4ZPrwMi5p6Q=;
 b=ADQrkC+6VbbGYjWLeOWbhJxr7tZ1x6F+HK/FTTSHA0S2BR3ntxvp09AdpmfaVPpV37NyLSvhpKjfoirX1NadhUF3PZ8jtrmgElbqpZTyLoQR4I69foES4bbSNs3CXrg7ucX9hA14Z3LnRB3Oz/zXSBAbp05rdCUWp6dunSzUo8plAip+Hh80zex7c6tQikVjVLTIg9jwwxKv+46Jp+nbeg+IFH/RPxvjKM0Mht9uBVxgM6XgomiHjggSl2je4WlR+fqRahyFSEnnlQ+3NrlBxFWrRH0vnZJXENja0MQrPRxwDQaQ9/aZWH7hKayWQfBLbs0egWtyclbmTKN5JzHAfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rq0yEHtS+Cz92dCzyGpzXwyfl+aooHEG4ZPrwMi5p6Q=;
 b=unafybPEW9p+OFDTKpCPmmAV64bm4AIRZ4K8zvPW7MPR88Yx+2b3EyX2wyNwdxSeAkIlzKl5h6k5RAvg86rnpuENBkbqgxdGB9SIW6EfmdggrD4pmQT1ye6tHKU0CCCUVWJzpYcWbx3M78tF/S6kIjgL+umFHeh5CvBiiHIIvNA=
Received: from BN9PR03CA0718.namprd03.prod.outlook.com (2603:10b6:408:ef::33)
 by SJ5PPF01781787B.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::986) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 17:46:09 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:ef:cafe::11) by BN9PR03CA0718.outlook.office365.com
 (2603:10b6:408:ef::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 17:46:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 17:46:06 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 12:46:06 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 12:46:06 -0500
Message-ID: <21089f21-ba36-69eb-2b9c-642fb0ab1498@amd.com>
Date: Fri, 21 Aug 2026 10:46:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: reject a command chain that carries no
 commands
Content-Language: en-US
To: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>, <mamin506@gmail.com>,
 <ogabbay@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20260818000019.369366-1-taimuraz@kaitmazov.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260818000019.369366-1-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|SJ5PPF01781787B:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e816d6-7f7e-4732-827b-08deffac140f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GEejGfk8Qtu0izuX7zVMUr00fH+FpT9nfL0rbott5UaaeViQ8nUrw6krWiumXN5Bt2Ecy2y+nd1gN3KqpEL0sepp4jpiz4gX6Mo1oBc2N/Z9DQAZw1YgpPCzG4Y5tBrwKIWVg6BOlLb9fBdcfGeETY0q+LW94hvSjo1ZOXTGT5Qzur6dVvTdkaCIgVYhsjuea04y2ONH99twdJPykChyh/oAmXa7Lzx70exicg35N8Gc9N/o+WBkhZcntt2QHcfx3SYC6re7LZC32sR9nu85Yythi/OgHdrMd+nh+dD15lAHn094MI0wdzKJOS7o0pEzWA2+3lBYKCOK/jgwOf5NJAmIp4RULDNEdX9s5A2Y8V82pXpxT72p/JzFxNQyP0sN8YqJE/8tKiYbZwfVMs9DMP7tVbl4wuqnKaJEu1KBKCtd7g289DzOHYbR7EscHMrL4dn1T/IiPoFCmGyza54taywTjQ+O/LmaaRZ+X603RSUwSgrsivubYCu4QcGcSLiiMiwcdsKDnHsN+K4XtvT7XnTZPSNPALg0yK0INBZI5dXdDq3dw4LtNsbTcBgPoIxxEdYZtBDeFBNJm3C1MFaA2Nv2526/WLaKMSMxSndDHaiv5E3XmzLYjbtqu4ZUv0Vcq1LDlW2xn3IVedyGnzoK20u+XU9etfdvkUv8G1py/4nb+CxsrXOFpXgARprObX7WR+VExlnHqL25QEP51Gmrsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KM3lmhBRJzgmpQtqtHSv+1SAxNCJZ8qPKELagMm5duBYDD0Ps3Mqo0RVzZx7v7dM4IHMTfB/f+MIUsxNlogfOjZhiMrkoQQlO7UwFv9G47/M8S4U4d3/pwtEuwfjk9bUmh0K0TeENhn29VU1HDXKOQV+gkCZV6hW488B8W8e5Hbb9SYlZwcq0MFu97AorhfnXXJDTxeWIhPlSFrb+ODNOAtegS2BoI3QoDB7bQuhZTSRK/oHiVLqpTcuZVL67vswGMzgikrN1ic2w2upVyOUB0PxTlejmo9IxiDmESBcE+jFPEUqp1ZQj/lTQIbe0mxmUO/0lx8rsapmj/cM4S2B3IsIQsPLD7mAi4HlXuVfUcKGR0mupOs4aG5C7g1Zpt6Um+LJgXZvI/aEuhPaqUf9Lx53kCEPi+QF0VMoCtN3rmAIkAmuXdqhxeYvHuHRjy9K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 17:46:06.8818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e816d6-7f7e-4732-827b-08deffac140f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF01781787B
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


On 8/17/26 17:00, Taimuraz Kaitmazov wrote:
> A chain whose command_count is zero passes the payload length check,
> because struct_size(payload, data, 0) is just the header. The fill loop
> then does not run, so offset stays zero and the request is submitted with
> a zero-length buffer.
>
> On firmware without AIE2_NPU_COMMAND that ends at the opcode check, since
> op is still ERT_INVALID_CMD and aie2_get_chain_msg_op() answers
> MSG_OP_MAX_OPCODE. aie2_get_npu_chain_msg_op() answers
> MSG_OP_CHAIN_EXEC_NPU whatever it is given, so there the submission
> continues to drm_clflush_virt_range(cmd_buf, 0), which reads the byte
> before the buffer and faults on the vmap guard page. EXEC_CMD is
> reachable by any process that can open the render node.
>
> Reject the request instead.
>
> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
> ---
> drm_clflush_virt_range() faulting on an empty range is a core problem, and a
> patch for it is on the list separately. This rejects the request in the driver
> regardless, since a chain carrying no commands is not something to submit.
>
>   drivers/accel/amdxdna/aie2_message.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
> index dfe0fbdf066d..b4c49259a1a2 100644
> --- a/drivers/accel/amdxdna/aie2_message.c
> +++ b/drivers/accel/amdxdna/aie2_message.c
> @@ -994,7 +994,7 @@ int aie2_cmdlist_multi_execbuf(struct amdxdna_hwctx *hwctx,
>   	}
>   
>   	ccnt = payload->command_count;
> -	if (payload_len < struct_size(payload, data, ccnt)) {
> +	if (!ccnt || payload_len < struct_size(payload, data, ccnt)) {

Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>

I will add a Fixes tag when I merge it.

Thanks,

Lizhi

>   		XDNA_DBG(xdna, "Invalid command count %d", ccnt);
>   		return -EINVAL;
>   	}
