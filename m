Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019A0CD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 10:32:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B584F10E2EE;
	Thu, 14 May 2026 10:32:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZTBrjx/K";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCF1010E2EE
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 10:32:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yw3ys33xPiXF8A5jcyux3cr9BuRadrUnN3bFU9Ll4yjqcbrX9c9Sz4ZqZGRVA7+c4MCEVoCEFgNtRDxTtFAru8Ofn4ymNIzmudJWi6VywRIcQnk21LMHAjd+QLJtfganRU0AVrr+polFxCip2jSR+WOyz+AYpbuUSEExrfRhWz3HrnKfdAr6+qs8wBkq+4nQopPWcXoj5RF/oM+2gDKLEqThxzCyu/rVSF9uSumRi8PrSCQvvO24/zyHYi7S276ndVbh5dVmDM/UFb0NlwQ+LqNxtJQ94+HOvV+6xiB0jXArXHpE26TpgD3LoEGEyBU7zK0r24NwVPCOtlzCx5hS/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rQGO5w8UeqPrfiwQ3OUBfhPSejafQs7/TMWlt6Ow6o=;
 b=aun8dwpQtmg0GzarHrxiOem4ECkTwcetC1Cyh/wKr7+eHhFt6rjmIZzZlGkLj/dXAoHnSJzOOsU+86LkIIvNbL5Wtj6SCrjLVYkZQWEHVRrWLPZMIUHfHvClUQfRJmStGtX8BMIuXu4+f5JtIwyZHabcIizPw8Gx+BY03M6tgo7sNayXqdKuVvUP9QqZEtbhHuZ9RZ5ThOAOpvpdEhW4R3/42ckov4mawi3BDuFusqqNG5a3fgkNj/fBdH1q7Cva/+D2pG7IdOeCZPZlDK2xkrxHz9AwafkBq1dNGx4Ponyl9gFef+tMPEZuGBmSCi33zplBzQGSGdEU9R2QoanEbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rQGO5w8UeqPrfiwQ3OUBfhPSejafQs7/TMWlt6Ow6o=;
 b=ZTBrjx/KXaFgm41ZA/Pb8S/MdCCUFPcdOpA8XSsOZbYyjtL1uf0BJ/bDflnadrcb6eSatwayImdSa7f58K6FM0B9jTICqP2l58pUho4yenbpqthBYmhfYkirer4CQd89h4dOM94XB9TNw1lYregXQF0eT5nsv7cee3w6u9fcCQty3dA3X5NoHM6rR1GOEPBlKiIVeZqQ0SNq1qK5nv8yxqkeOiZR6ZIFNXhEWycvySIP8ZZR0UiMW2sVOuXb38Uy10x19yKAJCKTS7hb2B+6fpDyaCdGoOadYmbpvRPlfVrFppA+4gCETW+gnHrDbEOKcgd94umfuD3zmeIf62R0Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:208::15)
 by SN7PR12MB7179.namprd12.prod.outlook.com (2603:10b6:806:2a7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 10:32:34 +0000
Received: from MW4PR12MB7000.namprd12.prod.outlook.com
 ([fe80::43ba:fd2f:56b9:7387]) by MW4PR12MB7000.namprd12.prod.outlook.com
 ([fe80::43ba:fd2f:56b9:7387%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 10:32:33 +0000
From: Tanmay Patil <tanmayp@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tanmay Patil <tanmayp@nvidia.com>
Subject: [PATCH 2/2] gpu: host1x: skip redundant HW state update
Date: Thu, 14 May 2026 10:31:53 +0000
Message-ID: <20260514103153.766343-3-tanmayp@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514103153.766343-1-tanmayp@nvidia.com>
References: <20260514103153.766343-1-tanmayp@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::49) To MW4PR12MB7000.namprd12.prod.outlook.com
 (2603:10b6:303:208::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7000:EE_|SN7PR12MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: ac81baf4-4f0f-44eb-7b76-08deb1a41c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 3Ex3n48A6//uWLuyXw+k6Ofo/0j6gVGpob5cJW3R0Ln1a75gEXgBI2VNPN5FEczPh9Lcnmt/BwjyXv/Ni5SdNUq6TV6pn3Fuo6IMZvBKglw7wY8YYOjeULVL91cbbsxVCVamQ/EMJzBR0Dlsr+YB03AkKXIorhub2bLFYrY3TarqnZGmNq5RdBp4J4xdkdYAERa6BrhSIcLFKTAsiq0I2P8XNZcHlhbJ1/BtE6fBdhNFPvlGQAPhL84DSM3xq0ohkGTc2g8l0a2oTToLfgRKfL1GxJt+EIheeMg41BEZpoxMmIy8yU3bJZVI7E1ehn4qjV9GCNy13rcbI2cp4IJh7pCILnI/sPK0n5d9PPQZ91U5bs0v91vBTdKszlXHM74dX9TeMG3ILQ62GJuJ5pw0e4E/4ox+FSRXO8FWjiVEkRA9zU6IjoysBWYnUrzWYv3MSpxcmpb0eZkqcIp1Kko5aQLyEHyMj82ZGPUHVUwQSlUneNutlKlJEawXEOAjB2g+aKhij/qgapOzeYSCZRM254zJNbJ8tqo0SafBJNQK5E0LhMrOexax3iN/arN2msbAs2GTIOS/RDMh8dRyn/YgWgGfweFpKLGOaH++MwSzPw/9rcJULw6TsgegKQbK7mvYjFkeb/go5emq/PMK5k38UzJ38P1OnQBCzsNAIbzrBuOoZBLwafMAsEr8QWUVKtaT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB7000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g1ULhwQopPePENxfTS/ENpFP5uzjBSdAwI5vj7mEbX06tzQ9HjCnjwG6D294?=
 =?us-ascii?Q?PXtO5z9soR/rphp9zyWMnTH79Eqsiwgmnw8xicnKiylGey+cm7IBotrhGcPF?=
 =?us-ascii?Q?/tKdnZozIVcmeJ1oPAySfCz3mLgBwM2ENgMPW7rD9NbQf6+TJmizuh3M2btr?=
 =?us-ascii?Q?pgjN4gp7b2EzqTbmw1c6FhAF8PLy9aGOHxuaW+3xNkIsd+HAp5bdtAyr7Z58?=
 =?us-ascii?Q?wBr5q2VEWt3L8dqQ/fVzE6a2qvqQEIsPpauJuXCqCkfqGQRiNaX7CWn6t2UR?=
 =?us-ascii?Q?s1jlyM8YU4zJxTsty/6qzC3u/uIntThKLt05G8EOkuLQtA7k1iCnOmoOTlc7?=
 =?us-ascii?Q?72eo4crpi4Tcs+mhpIBWy/tUoVx48sdWRtmKK53zYz0xlht+X0WC+LFc51qH?=
 =?us-ascii?Q?UYRKZMmhz85zx3IbbU0yzfDYjrx5jmEqkX2xA9sBjWJ4XvW8keESxYHufLDV?=
 =?us-ascii?Q?m6Og+xZ5bX5ue7I6opaCjC5ToZr9H3AiDiBpGkvd3UBete2gjWIbFax5mWgD?=
 =?us-ascii?Q?qJfnd4XqKa/tH24Sijynvhxlg9tUzl3XBVtkgW45Kfsfjn4AUZz+W9FdhxxR?=
 =?us-ascii?Q?LZM5i5ZQyFTCmDoDl9s9j8zwmIg9G4BSjYWjYd+ryTUbaMh3HeQ7/teRLr/K?=
 =?us-ascii?Q?E+cysFvOhSBmoOhferFNWmCOV1MA62TmKoDZh68q8Gy5De03lRlZT8BrZT5b?=
 =?us-ascii?Q?0BYxzbgIhEjcJrsVetViMPHxs5elyIMsESY8vqo6Rtr2vqIVBKmKvEIjHbqn?=
 =?us-ascii?Q?Qk5fscAIV2tCx41NKkuoWeyywadsQLcTI/L1Q4cCSJbUgFn+1hhefj0+j+xw?=
 =?us-ascii?Q?O1UiO2l376ZXge0kkGZYPJ4Xk2WkUooDBoE5oxr+iJ0qqXDwZnxv1QdkP5HS?=
 =?us-ascii?Q?eN66AcdJdgfxkSvz6p05aloW35y6v9Vn0r+7E8pV6WAiQYG3vfsJDQtEZsp1?=
 =?us-ascii?Q?won89URN7DJe5grRM7lqEjMLT5gNQxT1uXCZpzKmMeLGJyPnYdo2EMZP3y2I?=
 =?us-ascii?Q?jpgzZz6wINDFIJ7oAYrb8faDSsuCFcl/6fy/d6kHaEJ1/fDBZpTI4OXF8MbG?=
 =?us-ascii?Q?mNDWXDwu+pCbjTrZKRWKhrvan60NZLIyuVqVyVfC70xc01KA36CfFnVrObuz?=
 =?us-ascii?Q?bgudjJJS4HlCDTcDE2PZcMfBvkf5gtQ0KASXQ8Y/zFJzDjBZjbTRiIwPAA7r?=
 =?us-ascii?Q?8yKy9qZzykiGsEuxLO104XgekPzEM52U2XtX5XzO/tF3c/P8J5JJxZqPvsFu?=
 =?us-ascii?Q?5xxgQiWo34BchdISnHgJt87wc1nJJYE0nJGzOygmITJW7//pPf8zHX1KrVGS?=
 =?us-ascii?Q?5e81GdG/akKwckvHDYGtGxR/+ByVR6QWPb11djnH9bnCpwTMSFewA7mpYM7u?=
 =?us-ascii?Q?EjIjf8PMimkoDtDi+kbwq3kq2Rle1L2TR7R/8NWdeac21vF+tJTdkfwnj/an?=
 =?us-ascii?Q?KA+QkpKaLRBvlOgR+nccsje3T6libDAFWIx59Yy92f2DZt3RCY3RiejZQtVy?=
 =?us-ascii?Q?gXO28VsKT0Z9IMiDLW1bEcjIg7syYu2QNT2lurmYgnUUg7BCC/B2SCHeTBsZ?=
 =?us-ascii?Q?hwOV8VK6DifiqRPODj2Usp+XDx5KGMyGInHUDbd3fxXiIkQ2YtiSrznxTz2i?=
 =?us-ascii?Q?8XenUzfF1jH2tgVJr8h7Vho1ZsR6fnJUpYVVFoPQOyRt38+j96dHhhACbyGh?=
 =?us-ascii?Q?oPok9CxlTjuYvCDnDJSFW3n5T1dIxkliMUFL61NGYf2WnP2t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac81baf4-4f0f-44eb-7b76-08deb1a41c21
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 10:32:33.8982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgwpcwDMiUrezqyxmSYYBj+2lVJ9qWupT8oTivWAq0983QopL6e3xKP1Vx8FDEureVWAMTH0XCh8jJnUsDXo6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7179
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

When the fence list is empty, host1x_intr_update_hw_state()
falls through to host1x_intr_disable_syncpt_intr()
which does two MMIO writes to disable the syncpoint
interrupt and clear its status.

The ISR has already disabled and acked the interrupt
before calling host1x_intr_handle_interrupt(), making
these two writes redundant. Skip the update_hw_state()
call if no fences remain.

Measured Syncpoint wait latency (50000 samples):
  Average latency:   10.6 us  -> 9.4 us
  99.99 pct latency: 51.90 us -> 36.58 us

Signed-off-by: Tanmay Patil <tanmayp@nvidia.com>
---
 drivers/gpu/host1x/intr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/host1x/intr.c b/drivers/gpu/host1x/intr.c
index f77a678949e9..723297250768 100644
--- a/drivers/gpu/host1x/intr.c
+++ b/drivers/gpu/host1x/intr.c
@@ -92,8 +92,12 @@ void host1x_intr_handle_interrupt(struct host1x *host, unsigned int id)
 		host1x_fence_signal(fence);
 	}
 
-	/* Re-enable interrupt if necessary */
-	host1x_intr_update_hw_state(host, sp);
+	/*
+	 * Re-enable interrupt if necessary. The ISR already disabled the interrupt,
+	 * so if no fences remain, no update is needed.
+	 */
+	if (!list_empty(&sp->fences.list))
+		host1x_intr_update_hw_state(host, sp);
 
 	spin_unlock(&sp->fences.lock);
 }
-- 
2.54.0

