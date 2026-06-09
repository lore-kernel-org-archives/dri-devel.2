Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B09BCD8CAD
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 563DA10E181;
	Tue,  9 Jun 2026 08:10:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VKMkIx/M";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B33510E181
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKYc7SIl9rLBdEY6GQnCVAd1jqdt5Uhqf7blGrLI1WPDt4OFKuI97Ykht5ladp1HWMiRNg+cmzymapXUVao8EwVivY9RSav/QaCQKQFbl/XAZZjh9zQ0g5K38HFsDNKsAJlzFDSxyO0KBU3bwRfuJKndql/KSB17ub/In/LddEInv4ZK9aWuA11E8A9/KqBjwklQ92OPboCo8ePcKDxn0Qq3kKLTSJUXCZskJ50ee0xkd+4TW9D1AJk99iu5QywDUOBENA+TlzLb8OioeL/kYIWipkKs77J7Cg4JTu6dRTkzaPNWcDLhjtefreLaPtOvZ+N7TnaUu7bF7H1Cu4vq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jp7k+y1CTcDOCsSvn4pOkrjcde7mUct9/FAzuyON87A=;
 b=cZ29ipz18gWxHQtDLJ339DHQGkKyYgTfabkzgJVn6+PnZguteUyruf2xq/NwEFxE+dScE7A8L4I0DQG+NqXyH0rM7lSBos2g7ena2e7wSKqpLJrJABD8NA4Ohc6yAC0Hkcc5VzT+a/Ki8D9HehB1x8xnpMtkJBox0zBXBj2CVsTcZ8HYoUx8/MN9rmCXv/Lo3slMvUl+ZL7GdqdigMvD1zen3RDNrOdLgTaGgqqQ8yXHHA1nl/OtWSPJ8HqfnEIADtFrZENuKkjvGT6+pbbYUWFWzlOWOHRfSKVrhHBPkFx22zkEbwgp6lyRw1h2BjQwq38wBYHCltLxa0tM6MlZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jp7k+y1CTcDOCsSvn4pOkrjcde7mUct9/FAzuyON87A=;
 b=VKMkIx/M10lj34vlhcbe0PIoBgqXdAC9Yy7ZOebJ3YuY2RTaC/3Zv9F4rRZaOfCNJPk+cemXqxEhWP43us5VSOXYA7I76aEZuUfAiQfm2QLas1BDPDx4DDukVKs86MR0o/MjPtzBS3a/02brZkDpS/P1XriGCQ4bI4sSk2dyqflAt1RPnWsZYUcIHNSJxJkA4jy1abrh4Ts4Obyk2KaLKmnGWPGNCBmPJVbE5KyB+Puoe3w4yK4ZNREmekn3u7ZbRJBilXb8NXDtR5z70wV0zCT9XNSPa8s0yJy6SLm0MIlVOQxqJAOHzMI34yjFzIRQ6oB5DcWMJMkgQlvYxcPb6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MW6PR12MB8900.namprd12.prod.outlook.com (2603:10b6:303:244::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 08:10:15 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 08:10:15 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Tue, 09 Jun 2026 17:09:19 +0900
Subject: [PATCH 3/6] gpu: host1x: Fix offset calculation in trace_write_gather
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-b4-host1x-small-fixes-a-v1-3-7c1131c0b3ad@nvidia.com>
References: <20260609-b4-host1x-small-fixes-a-v1-0-7c1131c0b3ad@nvidia.com>
In-Reply-To: <20260609-b4-host1x-small-fixes-a-v1-0-7c1131c0b3ad@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: OSTPR01CA0037.jpnprd01.prod.outlook.com
 (2603:1096:604:21b::10) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MW6PR12MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd1dbd1-61a1-4f61-3aac-08dec5fe899d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: IwjHHKfTYgHC6UM/frJkPtJiGSx3ZH5BaMZe8lrVI7uxB4IXh6MXCpGUOJ7R/9br+yb/WnxhGUZyuVn0lBUAs9FNIzkN1ELnu2fFv1/Ig8CZ6/8JF1k+n4YfrflKtbpxCJt8RRxArepTj+4W0RPJlzJGVFKXnFDqLp8lt79LfOgdpXQhqPeHZhlua3Jn9yySZLZ/CwrjfcBquMOIQyJZ0XvXgs2xWCjZ2Xn1yHjq3oiF6EZlGi9CYUDiD6Zn96n7Zk4PbaLqInVacPvfjfh5C3skzg+64tUXK3+X/VPyPPAGPRM9zjp7SjVNttjey+TZoh9E8FY8JvWjhoPkX04nxYVzD1mHpSIeaZE/ZagdQg9z/zzI1INah5EJhxQCxa5Calyk/6tEa3mlCaPqrQuA2Jqz357hWTGpTUyBsvIgeP2tEH/8te0UnqbgANKoI4RMnaGzmF5KaBM4vL5U9sWQpzgxIRsvVW+9rnagx9fYkF1T8pb0lDh9ePnlPvbR9AUuYmSfIyojhMGxVPcOnpJ57z8DcIcFdLzpqZtkqgItcrAuneZfYxFWE+DUQRw9hEUy7/5qPn0erI8nPgtf79BVM5glAxkVkckHwHrVTZ0UyaIEUSK6xr5d56z2kVKVY2x2sU36JBlEa2AoEdHegsFtN3t45c4jMjw2gLoSiZx1Of93S7KoxfQC6roWVz/Xvfhw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnhNSFd5d0FKM3VxU0w2VmhXbm9qYTNKamxKUHQxZHhGRTdyTmg5RUFJTDBT?=
 =?utf-8?B?akN5Qzl4NXo2R25Dc2ZPcDFWK1l4c1FiN3QrQ2NuZG9McEtoYkJsNGVUM2x0?=
 =?utf-8?B?YkV1R0JRT2c2MGZyWGR5SGtsNjJIT2pqM0VscFB4dm9pVloyZENmOGlCRVBs?=
 =?utf-8?B?djFERlhiWFZldjVUcUlYM0ZyOFRDb05FVExIclN6Wk9Scms3aGpCc0JoQlBB?=
 =?utf-8?B?bjRLWHNlTDZsczJkQnBZbzZyQUFDOGxZNm1jYU4zZThLZkFDOVNITFZWTEdL?=
 =?utf-8?B?SXlZQUs0VFFKekxMK2FPa1h4dHlxNFhVQVkrcjR4NGV5NEFiaDRDbUJZQkJh?=
 =?utf-8?B?QzVmNWYzMnpKdjVvRnl3ZnBsNXM1Sk55QS9hTkU4OS9WbFVIVjBzcTNNZXFC?=
 =?utf-8?B?dHNsMTN4cEJ1TUhtUjRCOTJtRFFCeTRhNDN2eHJ4T2NmRkhGSHdYRTM1eHB0?=
 =?utf-8?B?UFZBTFBaWXEzMjQ1QUYydU50UlhRcTVzb0hBOHp1N2IxbGRvUW4wRHpyb3FQ?=
 =?utf-8?B?TlRLUS9NclJlcFdjU2taakF2UjdNZHc3SGdmMGg2VjNUTlFwcE5hbVNzZk03?=
 =?utf-8?B?NUk0dlFKMkNNTUFrVlV2REVkSG5mUlpvemVHbzNBdm80ZHBMZk0wcWladmgy?=
 =?utf-8?B?THVFVGtQeGFZTHpzN3RMUm1Wck15Zkw5czNyU3VPV3dxNnBrV2NqTlBNRy9G?=
 =?utf-8?B?OTZ5dWlZK3JwSjNjcHFDUG1hcVUyZ1lxZ01GU2YxK1VITjV6empNRHEzN1Ru?=
 =?utf-8?B?VXRaMmFOQUFHUzYzNzZCVkZGSlJONEZHZWtYQVJHcENYeDVhRCtWMHM5T1Ft?=
 =?utf-8?B?UkEzRXZPZW1ESTY0Qkp5VVhRSkVvMHZUN0p1bjFxbWR0c0xFQlAxWHgyUnFK?=
 =?utf-8?B?K3ZpL001YUlNZEFpSXVpTDhnd2V6WVpGU0FUR3NCamdkTHFWd3ZaalZBdS9J?=
 =?utf-8?B?UVhSU1JyV1kzdlkwVUVOL3ZOaUV4ZkM5QlVKU1BQVUNUL0w1WVZEZ2hlWkp5?=
 =?utf-8?B?RWlkRFYwQmNUUERwNjEzVVJlS2hUMXJISVpKQWpXYUNzenJJYWFROGI4bXpN?=
 =?utf-8?B?Z3RYTmcyL0ROeDNieUZuZUpmSXRONW1qOHJQcUtId3FOT2pNcFJvWFppMFRT?=
 =?utf-8?B?T3kveXcxVGJNUmxqUHVQcDdVSFB4RFBaRVFTV2JLQUtEekcwL2Myc09BQklm?=
 =?utf-8?B?MzN5RjRnekhlT0RLZXM5RnVrNlhBN1JjMEFudHBDOGp2VnJBWHRXMGI0MDVv?=
 =?utf-8?B?ZHUrYWNqSU9SQnBFL1l1SllMOSt3VjJMTG9jTFR6WVppK2xDWDFyZ2duOXNq?=
 =?utf-8?B?cXRsQWpxVkYycFgyTEZKbFVEVk5Qdis4UFVGYkQvQ3RROWlnRHhxN0pYckdN?=
 =?utf-8?B?Wm5aSEN5bmlNVzVhTVpma0tiNGY2N1lqRFVjK3gzTFVXdHJtM3VYTVBESWdp?=
 =?utf-8?B?Smpld3RLd0c0TjlZYmpXSXBmL3Z6a1VTckZvekV2S0dCMkQvUzVsNGxIRXdC?=
 =?utf-8?B?cFZtTTdBVVNSWmd1OXlybDhZazdVOGdyV0szcHYrd2tuWkduS1o3QXVzT2s5?=
 =?utf-8?B?MTE4M3RVbUxSMEo2WEFmbUZPT1lpL1lZMk5Wejl3azgyeWl0RXZDMTNmSVpS?=
 =?utf-8?B?NnpCR1FubDVVWEw2VlRNSWl3S0pzWFBxZ0JrUUhRYnNrMEtZWTh6ZllIRlcz?=
 =?utf-8?B?N2FEajZGdVFPMVZxY2d6N1NhQitoWEk0NkFCVHhZNDZzeDU4dGJRNHVMTUw4?=
 =?utf-8?B?QkE0SkFQaVhlQUEwcURCNnNkUDEvVlRIbkl3Vk0wQ3V6QXFSR1dXbkZHckJO?=
 =?utf-8?B?SG1jWDNxazFUa0Naa253c2RQMUtMNzhTdklPbTZkcVRQcklxVTlNdFJZcGJT?=
 =?utf-8?B?cWxYRVJVMmxDeWhXYThTbDdMRG5QMSs2OGJtbW5SM0RMdTlWaDBrNW42aElP?=
 =?utf-8?B?Z0YrYWtpamxoWjFRYXFiTU56a0xFdjB4RHNPRG1ZeC9xYUlwVFlJb0dNQmNB?=
 =?utf-8?B?OXU4djRKSGtxR1NaV1hTUERrUjQ4SXJKUVhRc3RTRFQ3VGM5WmNtZXJpemhT?=
 =?utf-8?B?Q3UrUDFTaTFKajYySE9paTFpK201d3FpTUZWSWxXMGtGUXovS3RLcEN5SnFS?=
 =?utf-8?B?T1prQ09LSG9oUk9XZHozNGliL1VKOE5XdDd0NlpXcUZDOWJob1M0R3VkN1Yy?=
 =?utf-8?B?Nk1LcUpBN0Y1aGJ2TDZYTHJXNDFJbHNzODlhU3VCSDZpMGdmVkhySFdwMjdx?=
 =?utf-8?B?Mk5mNXc1MXduQ1ZEeUZOUkRXcE5KTVF0T2NnZTZLcUk4emlPUVZIcGZzSWxh?=
 =?utf-8?B?UkNUbGUvaEZTVE9OQTQ4UTQxaUtwUG9TcVJieVpNWGlOY2g2MitlQy9qSnVq?=
 =?utf-8?Q?lguo+fIoa7I09ei46G4qRbTjEPaFzg6q+g2nLFOuvXY7E?=
X-MS-Exchange-AntiSpam-MessageData-1: ottVb2D0l3hg1w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd1dbd1-61a1-4f61-3aac-08dec5fe899d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:10:15.5165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJtnLo1vhBPnWeMEwkVDWNGC8qMJXHZJXeKjkXaPRiPM6Am03ECK6YL7FTb2+eRuJoC9t8D9guqYgwdIZVcJ6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8900
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

When a gather longer than 2*TRACE_MAX_LENGTH (256) words is traced
through host1x_cdma_push_gather, the reported BO offset drifts from
the third iteration onward.

Fix the calculation by properly calculating the value on each loop
rather than accumulating.

In reality, gathers tend to be pretty short so this is unlikely to
ever have been observed.

Fixes: b40d02bf96e0 ("gpu: host1x: Use struct host1x_bo pointers in traces")
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/hw/channel_hw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/host1x/hw/channel_hw.c b/drivers/gpu/host1x/hw/channel_hw.c
index 2df6a16d484e..9dda73199889 100644
--- a/drivers/gpu/host1x/hw/channel_hw.c
+++ b/drivers/gpu/host1x/hw/channel_hw.c
@@ -36,10 +36,9 @@ static void trace_write_gather(struct host1x_cdma *cdma, struct host1x_bo *bo,
 		for (i = 0; i < words; i += TRACE_MAX_LENGTH) {
 			u32 num_words = min(words - i, TRACE_MAX_LENGTH);
 
-			offset += i * sizeof(u32);
-
 			trace_host1x_cdma_push_gather(dev_name(dev), bo,
-						      num_words, offset,
+						      num_words,
+						      offset + i * sizeof(u32),
 						      mem);
 		}
 

-- 
2.53.0

