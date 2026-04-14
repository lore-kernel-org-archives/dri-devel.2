Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82902F9D0E0
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 16:15:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D568B10E626;
	Tue, 14 Apr 2026 16:15:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F5H2WCqU";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5B7810E627
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 16:15:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1pqCYkO3DB/qQrvODYyE/cfbNuFqR5KkxSGOJWdBMnxX1oNxwvWbpASf+ofgdwD9ZGQt0xfco+Y9hBXdIJ5OjOaO8EHPgrl7ZQt0rsZpaPPFkSH29JeXT4wZfCQXjmvS77HJPbP6kb4clp6oBHzSyMs9am8fKmPHXWev1+GKE9ldoPIKY2l6rwaIYE/BUPeLfvwvTjjhXroeLztn1xu27GTLmFeww9R2EcsLFD3Z/oSVSHMad9j5wTDh8PB4msZNrRaOThOrqipT0LVe+hOF11wup1oEcyYSYxdJ0PGD+M89KFFG5mbq+YY26rIf0hPjnxUfsWyVTwC3k59xv+6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBc8XEubvKrlhpbmgtFm74dSuXzjlbUvQNjXZUqyQP8=;
 b=IUUMuW9C/v34+I05wzXzXfP5wQA0jV1OcqOCnOPzQ/PaW2NPTc/5RX/ImG67fK2O8M2+G7s9txx2GWCZUCsuy20unm5zypz1hYCvhDXgQcWpZH07OuCk9t/y9L5eQSIQ/69uKfxPAihfexYpuORPxvjSow/Xe9K4r4pUfF4eRYZ43FFPTK5Lego9ebIaaJt5TtH5vGmfUlN92GbAPALmjqdkYpAs+M8ZXArECU2KIbhzZLQ47qGLGRDGZ5SpSgfLapZFnInIOE5PmQKmTxF2vlMpy1v0g4kskLlfFrwOXGCyG8YGoml16H0tT4nT7/tD92JxiEWzfHheG9VFCx+ycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBc8XEubvKrlhpbmgtFm74dSuXzjlbUvQNjXZUqyQP8=;
 b=F5H2WCqUKlWqRgJSnpGfzWq0u1zP//1/nNv1onxjYyjPoggut2beOouNOSBtqJbMiqtmRmCSR4PuUKsHv7u87a/Bu9+5W79Rzh5y54EMAAdHvSLkgSQm2XI1jIi6gcDg0KwtCcBTNjB1EsdyZcAMSaYWnK/Pvn/MXrF64f5GJC0=
Received: from BL1P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::34)
 by SA3PR12MB9158.namprd12.prod.outlook.com (2603:10b6:806:380::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 16:15:02 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::df) by BL1P221CA0015.outlook.office365.com
 (2603:10b6:208:2c5::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 16:15:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 16:15:02 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 11:15:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 11:15:02 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 11:15:01 -0500
Message-ID: <68b8c1aa-87d6-a464-cde9-5507f502c0a1@amd.com>
Date: Tue, 14 Apr 2026 09:14:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Fix order of canceled mailbox messages
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <maciej.falkowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20260413181843.670796-1-lizhi.hou@amd.com>
 <963b6bc7-f126-4681-977e-c6e04ec66010@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <963b6bc7-f126-4681-977e-c6e04ec66010@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|SA3PR12MB9158:EE_
X-MS-Office365-Filtering-Correlation-Id: f86cdf51-1329-4452-9218-08de9a40fba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: O9OSBXMdjejhPrPf67Wa45rAEt4MrUECwZA1kF3CE0Jo3/GMZVCF7o0KD5fgSW5+qsFAqbWI5L4thLH8k+LtfT3PP93/a4a1ZHDJupSbCCogFRRu/KGTb02Zp7kxw37u5ZI17CSQi9Sm4/12T0SObUaDoMY1Bn8FoUfjwPz2CYiwzbc4vAcHfQnRIMzchEXnNMtbIyacuNm3xpu6kh4t8Ib4qgbklisq5fmPWP+xi8VFiZTL0+LvEq23xFMb4rmdxeXIke6Cbv/sixNLcHwX2tMc70txq7Sv/I2UPBWP1qXBjbHD3PVDRU/9m4pSFARkHp3xXQJZg3PmOMuSEPE8rdm1vr543Go3o3sQQluxu8uVtjGezQcwXCVCx/x9yp3F1/ncwCn1Vf9I4ADNKZxtgeAVkJ9bZ3ANZ9u6p4xbfM4uIgEoCyqcQ0OM+ANfLO1a5pVPOpN9rHPEZBHUb8qQEV9Xp2ppCG8ORGfX5ulHV7nYtDZJUoYO6l9/v6fkXHyjW5Xkb5Tth/4YTWyTLdhQ0jIDbtmxp2Doztub4SwBFqKBJkj8p8KP+zCFntyCNq1Qt8kYp5raCXz9kuO6UuheqfahFwaiwPiBrhjkG/9btn2GYhrpqTmHQeWtfoUDzIPD9fmGgBEQEeB6EUjo+vXgG4IzJv66aDeEDb0f7bPSXinVl8GiESHBrq9vNhZFtmBUd82B1Igfdpj8dciDPh4YKo1VrQOveCA1labCwVp7BUYKTZr4eoKLXXJPnAvt8plBVJMnajW3TKkUmAhJ0YsTpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Wu5psbR9c4E1IOgrCie/F4zou5iixvYaUGcxhMw2CX91y6oAdRTDg+SRKQQ2xWcwv9cOrVfRp6Pui+pZo4sXA/eyGBmJkH3MY0G97BVDEUDn2jzXdjMVikWUlr/fIQGREFzuDWQoZskofVYsRZKG76/INDtw0G3/N+fSooW6bqgdf5J0gruhBg0p75lDatbpjQTiyX3Yn5+zCDG9LIx184wyEkVYeyDrW49FOg+ibsgBieIChaeHMiLLYRkkOEExNvj9FYH4EcYpK2ebFx8aFm9n8IJPKIbvnV305JZxnOINpE7IA4IoO5KvkNfgAEyfILfVNUQfKr0VEYT/x3kWYkIPa48ZL/mb6oDuyvPFIfkuIfx9AEDzoKvEw5FGNqxaG4OiXMBTewYD0psZnrNz5s/wMH3N/U7Ox9eqf3L570jMNk65MU17LwOuHFqaH+qV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 16:15:02.3314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f86cdf51-1329-4452-9218-08de9a40fba5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9158
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

On 4/13/26 15:40, Mario Limonciello wrote:
>
>
> On 4/13/26 13:18, Lizhi Hou wrote:
>> Mailbox message IDs are allocated cyclically. When destroying a mailbox
>> channel, pending messages are canceled starting from message ID 0. This
>> results in an incorrect cancellation order when the ID of the last 
>> posted
>> message wraps around and is smaller than the ID of the first posted
>> message.
>>
>> Fix this by canceling pending messages starting from the next available
>> message ID, ensuring the correct ordering across wraparound.
>>
>> Fixes: a37d78470bcc ("accel/amdxdna: Replace idr api with xarray")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/accel/amdxdna/amdxdna_mailbox.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c 
>> b/drivers/accel/amdxdna/amdxdna_mailbox.c
>> index 84a7e92562ad..336e5e77f18a 100644
>> --- a/drivers/accel/amdxdna/amdxdna_mailbox.c
>> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
>> @@ -549,7 +549,9 @@ void xdna_mailbox_stop_channel(struct 
>> mailbox_channel *mb_chann)
>>       drain_workqueue(mb_chann->work_q);
>>         /* We can clean up and release resources */
>> -    xa_for_each(&mb_chann->chan_xa, msg_id, mb_msg)
>> +    xa_for_each_start(&mb_chann->chan_xa, msg_id, mb_msg, 
>> mb_chann->next_msgid)
>> +        mailbox_release_msg(mb_chann, mb_msg);
>> +    xa_for_each_range(&mb_chann->chan_xa, msg_id, mb_msg, 0, 
>> mb_chann->next_msgid - 1)
>>           mailbox_release_msg(mb_chann, mb_msg);
>>       xa_destroy(&mb_chann->chan_xa);
>
