Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9907CC624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08D0710E10E;
	Mon, 31 Aug 2026 21:28:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gPFCNXq5";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010025.outbound.protection.outlook.com [52.101.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CACBC10E10E;
 Mon, 31 Aug 2026 21:28:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6hLcAhcmDi6iU4QM9pTQbbW6uOtvkteWCrsYIu4HMO6tbILySS1/phzAzXkU9ZwXgbW3bZodN4MLO2Qz03141k/EMmgGCmQx8pN+V7au/Tt8Ab2Hk55P5bXQtlYx/dFE5j5SV5vWSStZWMlJUC6vsn1xpojAgMJhVchC2S3kFo/uWyNWWxb+qO2WybWymjWmWQmcUlV8P5hVMlShphjgoS4oRCskt1g38nt0YAjNw7r+CI9c1WTaGcRjdIP9fX7UmKR3FjPk3dxiCj4IX5lVpFsj8MEDr7nioUSplVR0WuZZVQ+R5XR6MLQc2cC2Skb2cJK1W+1GazjSTFKUoNeDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hkf+tPK1fNZVek09wSlO+cz892FhRoagZwNjMQMFK0g=;
 b=h77kD4HA7RCAJQOO6X0JIKx29lMRL5CPdbVY1GvnmV834GrrvU+/0q9nXN3iDwO2FAjrRHQ2vVX5cGcGjvTvZFS1QwstDwEO0glG2PXx9RO+kOyhZ0Mrsh0fSi/K69eIZUbzlJXWdBO02bJjXYJfqxyLtbeOyEKlaowuzrR4eA5S7Q/8EQfQU+ONv+KwoBnpg+hkHABLp2/rPGcZ4NlBKVEhnjvOhi7+tTaDLXRYcBR/ugUu1oupIZZMP5FS5tJbc8g49gZkkUgL1q9L3qBxjKcRQxp6HEx2+xgmAOd9XuGcaGEVTWnrFDMThKn4uOzmOZ6LVKEWnyhNXCztvzJuug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hkf+tPK1fNZVek09wSlO+cz892FhRoagZwNjMQMFK0g=;
 b=gPFCNXq5EcPb+kojA8igA92+XQXnznNLHXbwQBuwatENYncowbqy0Iw2wfm1BUQj96LSzDNDkUoYqCmmUtPozhyD20MZhxY0XtJW5VcNLhlFYfFODw33qW6o++6Y0qKtwc9OZvTvUS/vkrhQxEbEP8lF/pVOEqCh+rT0kzhhCfA=
Received: from BY1P220CA0050.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::12)
 by DS7PR12MB8290.namprd12.prod.outlook.com (2603:10b6:8:d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 21:28:25 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:59e:cafe::3f) by BY1P220CA0050.outlook.office365.com
 (2603:10b6:a03:59e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 21:28:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 21:28:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 16:28:21 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 16:28:22 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 16:28:21 -0500
Message-ID: <7c533a4d-233f-f884-e79b-59d47c0555da@amd.com>
Date: Mon, 31 Aug 2026 14:28:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: fix double-free on mailbox channel stop
Content-Language: en-US
To: Deniz Aydogan <denizaydogan1902@gmail.com>, <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20260828212405.13124-1-denizaydogan1902@gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260828212405.13124-1-denizaydogan1902@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|DS7PR12MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc105a0-2620-4ef8-cff2-08df07a6ca78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: /cV3kIW011UXOMSXmW5G6lpaHXYWjJAG6QzyWjrerfytLx3uN0d3ZTE2/isHf8DBBTKGCj6PNcd4lfEA1YaavWM206ozB7W+CmWp1NknT6LcjoYvN07+y+3TopXPefkpq6UJZ7pYHswdCAA7w0aX0lCLsZOVlySSJOFT1gHkHcO6QOHplqTIpJWQhLcBaKFQHhFyEqzXUM1CBGUwk1jAHdPVlebL6B5JQhSdJnp8hIOYZC1btdaayqLUDizYocekCZO8/82DjErIj+th9bBZQqO0O1VeWc4ByfzE8PGvknZIBsANsv07cnOi2n+UrJLDdZJFeZfccd79J47EN7tM3i90UZ1Hig1BHH/987pmp6Sbw05r3IFtUAXaKLrl56ANVi/ph32l3TtAt46J0mFXPQ4S76gJUzdJ5POvTffDMUrzhZMIDpY+RA2X61doL6JvYWV4WXBKb8cCEFCALnsJY32ffKWCJA6d2qc1ATaB6VfQjh7XjANePCzcFTFhKBTD01FXB+Flg6K+tb5qeZmkb1ylYlUmIuolGuKjnIJ0y9DFZGCB/TzJIUMHTgUFEHo7Vv3KErRTcw6FLfniNiYxeQZUH9mbpRHNEBmb/gZzf8rmQJf1JnTU0Sfsvxfp+Qskg59Q+a47TfyI9cpRKDMixUaKCLbRmVSXUbxMkA2Z4fnGNIJaGMwewRAbVY9NqUWYpJ0Fi28ypS9HWjFe7RDJOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FjmsPslrblurJkbpbiTnusaJgKBluBh7wqeNvbKHiPfz0gFpOrin5S//0WedfJciftAtrtTPQxdFxMfVgt4rD+8HnV/44Sz20ECFayTYwE4b0fuF81SOooZbtPQFALdCQmpDqmWh8YKMW5Gp/D/pL7Ihai1cdvIhdeRBPld2Xags1ceodKLD51L+8+0VB5CE9/ST5jkZ65oixK5BDCMMAitgVutsTbwzQBp8+LeegZq+NAgIZLHzITfkVpYzwiPqM2aySH9ZBp8vSTZbZHhAs0KZJRRd8rL0JhJvp6uaotEO2vgiz755RcUptmop4k9T6MlhAQtEHXVy3pS/zqofu9IWBruoNQRgqhkEc4fDb+jhZt7A1ThxmkzqLI/LLcwBN16687FdE0VDTIN8V1EjjMTwZElMiHsEQy9ER70f79tuoIDmoJfvvL6u4l6nrHaG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 21:28:25.1511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc105a0-2620-4ef8-cff2-08df07a6ca78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8290
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


On 8/28/26 14:24, Deniz Aydogan wrote:
> mailbox_release_msg() frees the message with kfree() but does not
> remove it from the xarray. The stop function uses two loops to walk
> pending entries in cyclic order, but since released entries remain in
> the xarray, overlapping ranges cause the same entry to be freed twice.
>
> In particular, when next_msgid is 0 (the initial value after kzalloc),
> xa_for_each_start() covers all entries from index 0 onward, and
> xa_for_each_range() with max=(u32)(0 - 1) = U32_MAX also covers all
> entries. Every pending message gets double-freed.
>
> Use xa_for_each() to iterate all remaining entries exactly once.
> At this point the IRQ is already freed and the workqueue is drained,
> so traversal order does not matter.
>
> Fixes: 3ba13f5e7180 ("Merge tag 'devicetree-fixes-for-7.3-1'")
> Signed-off-by: Deniz Aydogan <denizaydogan1902@gmail.com>
> ---
>   drivers/accel/amdxdna/amdxdna_mailbox.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
> index cc8865f4e..271617347 100644
> --- a/drivers/accel/amdxdna/amdxdna_mailbox.c
> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
> @@ -556,9 +556,7 @@ void xdna_mailbox_stop_channel(struct mailbox_channel *mb_chann)
>   	drain_workqueue(mb_chann->work_q);
>   
>   	/* We can clean up and release resources */
> -	xa_for_each_start(&mb_chann->chan_xa, msg_id, mb_msg, mb_chann->next_msgid)
> -		mailbox_release_msg(mb_chann, mb_msg);
> -	xa_for_each_range(&mb_chann->chan_xa, msg_id, mb_msg, 0, mb_chann->next_msgid - 1)
> +	xa_for_each(&mb_chann->chan_xa, msg_id, mb_msg)

The msg need to be released in sequence. And I would suggest to release 
msgid in mailbox_release_msg()

@@ -192,6 +192,7 @@ static void mailbox_release_msg(struct 
mailbox_channel *mb_chann,
                mb_msg->pkg.header.id, mb_msg->pkg.header.opcode);
         if (mb_msg->notify_cb)
                 mb_msg->notify_cb(mb_msg->handle, NULL, 0);
+       mailbox_release_msgid(mb_chann, mb_msg->pkg.header.id);
         kfree(mb_msg);

Thanks,

Lizhi

>   		mailbox_release_msg(mb_chann, mb_msg);
>   	xa_destroy(&mb_chann->chan_xa);
>   
