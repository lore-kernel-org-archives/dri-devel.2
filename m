Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE69C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B06310F76D;
	Fri,  3 Jul 2026 10:22:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="I6wwEnzW";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010040.outbound.protection.outlook.com
 [40.93.198.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0C4910F76D
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 10:22:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtiFd2PMvQojaGPyQamNPtWI/PAdSN02Q5jMEYrzCpVnVVNCjtRLpqz9E62qg59ZadOjbcOkrBhz1aFh2//4ykkvWGSoQIryRbCAlOYXeUbdxAN8ujCP2cN/IFf+EKtFDdLDBLffeaZjm9DZUicfR6B14fb3qvOS/wmqy92lgZexLAvcCI1ef02k9XFKitC3wlOezvNFoNr2fZ3judd23XtzwRc0/qskJyiLiEjgl05AKw9fyHs+1EzwZkmW5vqjx5AEc6I0oObn4yg9IYn/wdUfX9PLLwIEdFte6rkleppCQWc3Q/GIaO1vQGrLYguNqF+GjpWV2wqKoUGBtgWieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I88S6JSlIdH3Ai+xqmwucWaDlOWkyvF4I6sJq3FZ8A0=;
 b=uW3zu/L8hSovbLXfDzfemnCCl/ftpv733THTf32iKXZdp0F5o+GKwJ+DXZXLJDg14VzjY6DVTtT3rdabFitD68eIeRSuAkoeBvTE/56WQlJ8NtlKoQ2e07bjuZdjOIlzsfYLpVXgiiRs/SwaVO81b1FA1YMAwT7hRT8dlVP8/GbTul8bQmDh/WAKld9iganq91JGPQEjGsbffbx9QP2FbAkwOc93c1m5qFh/s81S4RUnfyHzTOxH3tYLMqmH8/B/fYqeMfVWcYbl3vItjE3gjiHSWoOgYrCEMaga9697JJcSr0q+xU4ZiUCCYCZ+30yPdvwKIwS8yDvwGIUmUxcAvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I88S6JSlIdH3Ai+xqmwucWaDlOWkyvF4I6sJq3FZ8A0=;
 b=I6wwEnzWHQfNj9L+0HBqwHJ+uz7v/9JU9VH2T/JZ9Klho3NZG09ZNIqgsAgVyOhmMGNDO1wUNKUjqrJ67Y0n22OtKBmSr6Enau0gFn25IvB6w8TvTj6wEMCMaQd8ErnqbhPgI9v+HtiqmQjEnWZdnrNDqShcIfQlqv6e6ug2zO/k0t5x6wiWNaxPyNssrLZ2UiZ5OYSUOMYt3IVwEaHxb+jjNFjzM/8/ChJpB39OUF2bwkRMsBmE/pO5C/ffFGKo0pVBprbeWbvHT+nhrmob1Fc9IQfJi0c1vmep5EC5xfIS310BS2aLoILUzQkl20aeTF3PZgTAmF8/c8HFbi+NTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:22:21 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:22:21 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 03 Jul 2026 19:22:05 +0900
Subject: [PATCH v2 01/10] gpu: nova-core: fsp: limit FSP receive message
 allocation size
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-blackwell-fixes-v2-1-8e3d8bc32bb9@nvidia.com>
References: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
In-Reply-To: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0046.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::13) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a29113f-3cfd-40b7-cb54-08ded8ecf800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|23010399003|7416014|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: veC5gaT853xGkNwFpRyNtY1G38opJaiJKIYUqR1aKQ0/xEMcUf/BxFs23Ugtu+ee+6ME++3TZusr4/tqdn42IcUWWz6yjKT1eQCGCZpn9xa++zyPp9JDOEOk/mQ3KT4AmgZh3wTLYcttLShV9YGORTOeGBGACVvWwUxngHzV8HXA6g4TiR3E/F1xcLKeWC3QqusswAZdH/hpN1JWUUDHa5ADtN7rmCtSqKAKjWz9RH35rZ/7I+IttdKWtmz3vnBpsnBQ7nI/TwVtbYXXv13fRSOTaogSFCHQtPWuADlyiclre9avz+vDJRDH6J9bMuOVWWOo5uhX1bU3zyZ09jSrjSK0tGmJAuRMy9dAtUdjLAN0hGhjR5FzZfo0rU8P7hp5GW9DY3FaKq5ismcw7RzPMcESYI2YVp3CPtXofISDNv906L6CCe7iBNfFYW49EtWUkF56ar3zwJPIfJe3EPCnsDvvHx92PpStthJWxpspjhfDSHLrzsAaxI1OKc+AroMusejh/dXA8lxLRLHIrQUs7vGSLBrAs7IcFlC+RHJXeHIdWDxpj9itjnER5I5PjLt7j+4Jm6awTnsXJ4q/X86jTTsAj7UUmJSEyWYU6vAquphQHoOY1cPLtQgDynXIcd85lizaAk+43fzkPIPKyW9rufjU0CE0CJ+KwiUCXRPWlHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(7416014)(376014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWZna0ZYWUUrNVMrQnVLQlp6Zjh5cGxoYzI1c0h1UXgwR2F5RVlFYlRXNTlT?=
 =?utf-8?B?NEQrb1V3cTAxVERrR1BPZ3BxTXpaZlBCYlVleWlacFdMazZELzBGYmNKS05H?=
 =?utf-8?B?aVVaQzJpVjFBeGhTVmJsZGY2RDZwdk1TSG9MMlp5WlVGTGpCMG1vZlN1YWdD?=
 =?utf-8?B?SmxQNlQ3UXhVcTJYMXluQnRmWGpFZGhDemg0Z3F4Rm1hajhVSDZiTGc1ZWN4?=
 =?utf-8?B?T21sWUVJTVI3WUxSRE15QWJoUHhaOWhmVndZblF2QkVkaEM2L3YxTXRWbkFn?=
 =?utf-8?B?Z3FTblRZbGZ1R2FmUlJzM2UrMU9jT0hIVTJiSnpDYURXajQ3dkUrQTJjRVUz?=
 =?utf-8?B?aGp1WE10dTBabHdLVjJIUmM0YWFwcmdwU0l0MjkzNmNvMHJLcllWM3piVnlK?=
 =?utf-8?B?b29HOVE3RnpUbE1RQmF2Z0ZaS2ZoN2V4UzNJRTE2dkl3elEyRk81bnNnVnlu?=
 =?utf-8?B?R01IVVVNZzIvQkNjQ25oWUVLUHRrYjdTb0dlc0svOERYWlNydTk2RU03aVpq?=
 =?utf-8?B?SG9uMnlUcG5LcTdrUFNPcmtqUHNzNlpGVXVhOHNkclVYdlBzaytVeEtjYy9X?=
 =?utf-8?B?QmRRcnBQa1owZys1QjBMWncxMHBWaEIveWRqeDlVYUtkeXlYL2cwQWdXbURk?=
 =?utf-8?B?ZzJCdk5sUnFsN25DKytQNlAxRlpIZnVxY0Nab09sblc3eUJJUkpjM1NoMmZT?=
 =?utf-8?B?WE1pZ3NLc3MyTXZMU21TOW9xWEhmR3lNV2g4TnRjNUZGbkNYWGI4OXNSSVh5?=
 =?utf-8?B?aGtjQUxMclFJWFJRMllKN29Zc2RmQWtmQ3RmTE9uVHpoZHh3OWYyQXR0Qi9q?=
 =?utf-8?B?SmgrQkZBa1V2bUpDOUpqY284Qy95TnBqZEN4M2dXQUFPMmxDc3Bwekw0dG9R?=
 =?utf-8?B?SFBQWjA3WEdsWjVNd1VtOEhLMjlZNElOcTVFZ3hlTWQ1M2tyV1dvT2F1NG1X?=
 =?utf-8?B?RUFYQXJ3cmttTWlPYlA3ZWVJQzJWbjVtOEJoOFRnQ0Q2MG12cUNHRWppaklr?=
 =?utf-8?B?bENSWUJ0NEwwdU4zd1VQc3RoOWdpQTZ5bXh6YndCOWxnMTBHTi9zYlZpZHN5?=
 =?utf-8?B?WGNnTTdKdzJCdFRCL29vOHRkUHRsOEJRZEtnR0ZCemJjU0tQbWRnTnR4WjVv?=
 =?utf-8?B?dW8zNGE2bUp3WldXbWkxVEpmV2NscjRjT21hcjF3alh4eEJEQnZQS1NlMllK?=
 =?utf-8?B?U2xMVEcyTC9EbzE5SDY0T2lwUnhLRlFCUzhRckJOMGptNFdPV1RZWHRhNytw?=
 =?utf-8?B?QTJ4ZWxJV2FseHptdlkvajVRNm5OQUtMR3l2UWZ6aTRvZ0tLaGhuYzFWMmhE?=
 =?utf-8?B?Y1hueGpkTXY1YUNrTjdXdk8zOW02b0Y4dlpjeUx3cnc1anE1ZS92WlVCYnFi?=
 =?utf-8?B?WG1kUUxZZlFaYnRwQURKTlUvczUvdW43VlJjOXhiNkF2Y0VaYWZFa2M3VWlI?=
 =?utf-8?B?bTlEUDdKWllnMzJ0Rit3ajZKN1hMT05ZSnVLd0o4amxXODZzYXlFYzRYaSt6?=
 =?utf-8?B?dENZd0I3dFhVQWhXZ3FHZ2ZsQUF5V0JTQlMzNVNSMEh2a0NxakpNVVhvMGN0?=
 =?utf-8?B?a1dqOWFxUGY4YWR2cWFGNDVQN29EQVpXamhqcWtxRmhJMzhwR3dKM0hsS0lj?=
 =?utf-8?B?emtDWFVJb3lWRnNjTytqYmJlOE03NlVtVm5KUkJzUW5rWkVsTFhkSTFJY3h0?=
 =?utf-8?B?bGNjZkFXdTVwYTdJQWNTMTRlVkZqN3ErTUFpY3dPS29jVDV2VCtwdWQxNVJV?=
 =?utf-8?B?ZXpGVjNhNkptWnFKWFcrYlVkeEM4QSt5UGg0bk5JL25PNEFUbUN2L25vMkJ5?=
 =?utf-8?B?K3V5N3F5eDZ0dkFUVk94RmQxZmk3U0hlZGlZVVl1THFDYTdobW1MSVV4Vmdx?=
 =?utf-8?B?emN6ajZucThUbXlPNExYcWdCeXN2Mm5ITnBaeC9OMGhTQmwrZWVkTkl2REEv?=
 =?utf-8?B?NEFGbUh5L1dzeUZiK2p3RU9neVRQQVYzTDIrVHQyMW1vU1lqS2QyNkI0OVFK?=
 =?utf-8?B?cXVWaE1CWlpaOXJGa053bWFjbko0TEtNMFI3MUtSZklPeUlqK0wrTjd4NThu?=
 =?utf-8?B?N21vQXBlM0xKTmx5b25MeFJYaVdvRmxEbmFCcE5mQUtlY3dnb2NJTmIyYi9X?=
 =?utf-8?B?MHFGRFdiY3FwMnJlWjV1cUI5bmRQYVlkWGRZQnFNck5oTm5Cc3ZoYXNEb082?=
 =?utf-8?B?MGViMlVRMmRFcnhMbmdpTFlqS1FZR1Y3YWNPY09KMzk4MmpDSk5ZMStVRmVH?=
 =?utf-8?B?L3R3ZFhVQk8yL1NnMDZNRmVHQi9ZcTY2OGY4bHlDcmd6a1NjdEltdkEwR1JL?=
 =?utf-8?B?OTJsQmVpVEdCTlZuMlUxaXRtNTFWcVZpa00rZHRjdlJoZVZNYnozeEM1TCs0?=
 =?utf-8?Q?pT9AAdFaEP1TmDE0CStiTPgytXS8f/R5iRSrf+yDjuU/4?=
X-MS-Exchange-AntiSpam-MessageData-1: 7mEaPA6e4WcC9A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a29113f-3cfd-40b7-cb54-08ded8ecf800
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:22:21.8983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0P8WVd3jHIcVPjZR+k4rn9Mr1Z8qkUgmQxrskTB4Emnlwt+abI9EahWI4oWVcLr+WTLThOuvmuCSQvTx7uCAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
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

Currently, the FSP receive message code will try to allocate whatever
was sent without checking it at all. But the actual size allowed is
limited to 1024 anyway, so reject any messages over that size as bogus.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/falcon/fsp.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-core/falcon/fsp.rs
index 53b1079843ae..7cd9604d1f4d 100644
--- a/drivers/gpu/nova-core/falcon/fsp.rs
+++ b/drivers/gpu/nova-core/falcon/fsp.rs
@@ -34,6 +34,9 @@
 /// FSP message timeout in milliseconds.
 const FSP_MSG_TIMEOUT_MS: i64 = 2000;
 
+/// Size of the FSP EMEM channel 0 that we can use.
+const FSP_EMEM_CHANNEL_0_SIZE: usize = 1024;
+
 /// Type specifying the `Fsp` falcon engine. Cannot be instantiated.
 pub(crate) struct Fsp(());
 
@@ -159,6 +162,11 @@ pub(crate) fn recv_msg(&mut self) -> Result<KVec<u8>> {
         )
         .map(num::u32_as_usize)?;
 
+        // Don't blindly allocate more than the maximum we expect from FSP.
+        if msg_size > FSP_EMEM_CHANNEL_0_SIZE {
+            return Err(EMSGSIZE);
+        }
+
         let mut buffer = KVec::<u8>::new();
         buffer.resize(msg_size, 0, GFP_KERNEL)?;
 

-- 
2.54.0

