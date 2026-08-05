Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140D4C55ABF
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:02:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47AD310E151;
	Wed,  5 Aug 2026 05:02:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XTVaE8AY";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5B3210E151
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 05:02:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTUkPbptUybJ7c+TeTzMQebtZJwLaKO4qqyC0uHUlJXGqCXAQVxJtG7NsCPv4MB2SRgfDdcl+3rPNITYJCruGC1fhZOvUGzXQfqY/j65d++OffT0jPehOlCAU8eXtx7OMoR49rwqamxRPlbSG9T7pxTQGM4Nouh/oe36g8rBe3sYlcTpEQBxJFoLf+R9sLwN7FlAsItiq3hPp2+0TdDd0hylRZxo7kCJh1NPnGZ1bKA06p4k3NjvmU3GbKaaAwRqe2YgLpOan/SP1VOAg16Gmv5Emcw9uuCsN31MIInm823vhodaStLZ+XoIJNZao8/lfQ0PoJwbtrnX//zc6g/tKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9r0KhhaVBRImZbL2dex52cc2QT4SBmFC+/21PCuZCw=;
 b=hF4ChncZUTwVRjSEs9KYimzx0NKck5jPpWkYigWf3mCP305SGL/oNikgP+G9Te32Nddgaz9RoMLxgWV0gQjUR1zIYXYK960mDEJ5ApBrcIxmA8A58MgTjq4vyRSUZ7uDuLGMlKYC/emsfMKH3KolM7T7rvULwTKj+bjeADHqTPzCanpCQc83IfUNn0un+cdQIIdUGdexidMBCG28HL8uN8nyh11mb9e5AVL608J/eevQcZrwR33vn9lafyNsQZGCBGap7HDqOe1piBzgWnVabqWYpNNrj1ZVBffrgFSuf/wkFfkcIznB4cAHeBHX9lgErNDTUtr3RePhp7xAPaEb6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9r0KhhaVBRImZbL2dex52cc2QT4SBmFC+/21PCuZCw=;
 b=XTVaE8AY/3W9g71Q5TvL7JwyxUVUH8Zn2eSTlBMMgc4xHmICJmPLSYenbka6qWsQndI+rGZRTmoAX+yeaJ/ZcMEZiKgpaCU7ojM8KeVDRguV4Dkq+tny9rn8nH6hdSqYT///7/4PmVlw6A/8aknxXhE04NPaNeqHDEUp7yrr/Qvu8BtNbg1piL7OqwsvVEupdSv5z+7+q7vSiR9PjbosyKDzlNSAdx6Mz/+yuzsDz3ZJTgsCF6YZ9oYCJaU16/INDu9aYnNiIzokkD8T+ki6kW18sH9eCBE9MgLR9Wr37/w3Cu4xMOyMZ7iTEp4TG0/4TMMcGekYWAkr57Qe9e2GMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8536.namprd12.prod.outlook.com (2603:10b6:610:15e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 05:02:00 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0270.016; Wed, 5 Aug 2026
 05:01:59 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 05 Aug 2026 14:01:45 +0900
Subject: [PATCH v2 1/3] gpu: nova-core: falcon: remove unnecessary check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-falcon-dma-projections-v2-1-4cc9f3f13ee9@nvidia.com>
References: <20260805-falcon-dma-projections-v2-0-4cc9f3f13ee9@nvidia.com>
In-Reply-To: <20260805-falcon-dma-projections-v2-0-4cc9f3f13ee9@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0105.jpnprd01.prod.outlook.com
 (2603:1096:405:378::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e14dfc4-0b17-487d-ada6-08def2aeae6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|23010399003|7416014|1800799024|366016|921020|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XT+3EeDCedvnERvLWOh3JRpYqptsymHDShj4v7fK/W5p2lBNMDH8ng9yUEvCZlAIidLlAkEi54fNs1uJxVTmQg3xGOY/Auqe7JtJDZkBo5xN0bgVehwnMW5XXq5G7VxUU0CDTXPz5tja3+vsct0sLFY+w9aAInQhNbYdAzhhv/c+3g7t/+bFE7ROZ/ossemlOfEq2mPTUXs+8SaI6j6fNrbr2So2v3CNUVD8PiC029WcmsKwlssIX4deLmwnx0HOi84XB4cPYZCDlXDBXeK+XnIRCclEjIUvpblsHy8EF4Ld2MIrvICqTL6WduOrm4b89R5nphGedmBQDYcP19H8Xj9xZ3cpF2MaMSpTIykBgVzF0XdmXozB1XpTf6t4zC427N5Y+fXATTLx+ZfUhVoJ8Z6TDE8W/kyN4HgIYHBW/XiJ9p3JF1He/5xqEci+iGHmV/oA34FtFGDFF5ODPhpANgEc53/4sSUNI1xqOLINH7qccvbPdZ2WPNO6k/5RHwEKUdfBODM1ZhO3x+sAtwIU7nszRgxXXmyDCemCo/qvnh6NicPCT8flcQeC9wjGmy029qz1RuRskuAZlD1EIzuOX3NaT8bhErq6tIGoIERlgOqsdgDNwKLlj7FrtmNVvqPyrwV+z0bd6MauAbCdTAw0Fvc2b4xfIqVteX+SD6KfIJdvh9Ro4SCz48XcrGtaqNtWX0HixUmRUCS9NZsY+TygGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(23010399003)(7416014)(1800799024)(366016)(921020)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1Z5cjNGTkxOZEc0UHU0OUpoQ094TVhoTHNnOVRVUFRYcXN0NW5OUmJqb3V5?=
 =?utf-8?B?UHFTMERoVFdKWkZVSFkrTG9wazlpajB2eGFZZVVZU2RxV0djL2ZjNy9jSTE2?=
 =?utf-8?B?T0wzK2w0Q1dzbWtBZVNwRStNemtwZUxJckJPWUtUYTZ6V082SW5IOGhMTWc1?=
 =?utf-8?B?Vm44Nk9mcExrNTU3MmozWjh6cjRRTm8yV09vOGhEaUVPc3NiOTlqOXJaM1cw?=
 =?utf-8?B?VnBqNzBpa01Ga3o5MEZHY0VZVE1nelpobEVBbE1rYTdQZFkyUlUzWUZpOSsw?=
 =?utf-8?B?cnRyRjlLYWhBL3R5T3kzN0ZPc2lyWmxBMXQrK1AybUN4dmx6akU3OUJLNlpW?=
 =?utf-8?B?N0dBMTFLajlPRFJjVFgyZFBCTlhkSXl3WWc5UzEvb0VFUHZFZzBlZW1GMnNk?=
 =?utf-8?B?VjJybnMzeWVTQlpmcElrYnB0Wmtrc3hQQlJtQnYxUDA3NjJ0SlBhb25hLzdK?=
 =?utf-8?B?dTdLMW5kYmdYZ3NKMWc0dDUwSlpSVno2eHZQZEcwcU1RcVZMeTNIalMxQUNl?=
 =?utf-8?B?RUhyK1NFOGxwYVV0bXNWUHVjK1M4UndYaERwZUxjZE1pZmZaTWNvNTkrVWht?=
 =?utf-8?B?N05Pa1VJcVcvOGhiY2Z0T3UxcmRWZldtSXNrNWxwVzJGQndCb0JoYXltSUFT?=
 =?utf-8?B?cDRJSnM3TFpOWDUyTzBHWk9lcnIzeU5GTitZY3hqRjNLVWlpb0dieG5FZzRk?=
 =?utf-8?B?UXl6SllLamtndzFMOGp2QitoNUk3RmhiR0VSamgvMEJUV1N6M2NhcTdLVEdJ?=
 =?utf-8?B?alRUMFpSZi9vYmx2WFBocStUVTRrZDJFN0FKNG8wRjJrT3lFYUxkejFMM0xU?=
 =?utf-8?B?eHhLQTJrTlZ4dlJrS3VZMElRUjcwbzFhSEQ1TEtsSnREVFVjSFk1aFlrVU9w?=
 =?utf-8?B?bVRkQVFONTRhWUt6UVo4T2QxZ3VBMlIvYTM4cnRoR3JuVkNIZ3hyaHFxRGY3?=
 =?utf-8?B?S0VpcHIrRC94czBaTXVQVGZueER3QmxDMzVQUkxmY2hLMktJVzhyUVAyNXJC?=
 =?utf-8?B?SFM1MkpJcGFSenhHKzBTbkxMTlYwbXFvRlFhdVdEMG9UWWt4ODdmaVBNMDda?=
 =?utf-8?B?WnQ4MmRlaFZrd2IwQTdwdUJGL1hiZTJFak0wQ3dCZkc0M09rRjVqM0pORGov?=
 =?utf-8?B?WjZjQmxPSUNhYlM3ckZIcUFFTHlPWWJsTmYrcEsrQ1NYWU14Ums1ZHZ6Y1dS?=
 =?utf-8?B?empIWHpkSFFVa29ySURVbmdPQ0dsYXk0b2lNTWZPSUhNZWtETnB3RWxLNllo?=
 =?utf-8?B?YkpZQ0dJSVIrMmhCL2wxV0x4SHRDNzJDTDlCQW1aL1YxazJXMTBjbk5wL3Fz?=
 =?utf-8?B?NlcxaW5XOS81STVVRGxsYzF5TGNNWVI4VnZKU0JnczR0b1owWnExaVZqWmN2?=
 =?utf-8?B?T01FR1dJTTNxdkQ3b2Vsb1ZVcmJSZlIvUzVKYjZLT3pXaVJxMVBDbDQ1aDh6?=
 =?utf-8?B?bStWcmJENUh2MXROdW9DM3RKVnBoNC9Rc2RzY1ZuRkVsQ010TjBvQ2htbVZO?=
 =?utf-8?B?TWtPTk90QUZEY29RampzakVrMFFhVTRzRGVNRU42bU1vUlhEZEU1NGZqTURT?=
 =?utf-8?B?aHhqUDdXcjU4cERZS3BUeDduUldzZ1l3aE5xMzlJa1dOVmFqZVpMK1FwTHkz?=
 =?utf-8?B?ZWhEUlRkc3Q1aW40TTAvUHF0d0djZC8wK0oyYnhUOG5JaCtmNzRXSE9hOS95?=
 =?utf-8?B?QmtrYjdFYnl6ejYyYXVYdGtQUXhScnpBc1Q0cG0xMitRaGZHN1FMS3FrTDVz?=
 =?utf-8?B?bk4rek5SZkhJK0NkcGo4QjFUcXkrbWVWdjhNWndhMlNjbTVKdkQ0SGg5Sm43?=
 =?utf-8?B?MGRqa2F6d01VeDFKUkFPZnFaVHdFNUNoTmRDak4zYkJGTTd5Q2I2T3ZoQ05L?=
 =?utf-8?B?ajNPN2RFdDAyME5VSVFHdmNkYm1kaWhFMk42REE2OCtQcjV5QVpWOVpnOWg0?=
 =?utf-8?B?VDZPRmlNU1dzTThWVkJFbHpHWUNTYWNERHNOZzJTUkpZdktEc3oyV21DU1lK?=
 =?utf-8?B?ZndhZlJwRW5EcENma2czdU4vYVUzSmg3U04xWTQ2cWZsTDdYR2Y1VEQwaEtX?=
 =?utf-8?B?TVJIMzdQRU5oUFRXMkc3bWxtcXdBb21iY2tMN1habGZlTEFNbS85OFFSTmE4?=
 =?utf-8?B?VHB5NmlYa3BrMnpoOGR0eHRrb21ySG5pc3RmTEk2QVlldnVGMG1HZnl4bW1N?=
 =?utf-8?B?UXNCN1BHaHdHT0RFNGs5OG12N0M0c3ZZYllTamFZMGdVRWdSa0xqNkJOL1lv?=
 =?utf-8?B?TmViNnBkZWYydHRFS2c5M3QvUUFJSldQbDByd3JLVVVyYXR6OXZaS0pLOURT?=
 =?utf-8?B?TTZoZHRrOTBpMXRRTWVUUFFGaHdFbTMrcnY2TmZnZW9MeGNwblhVOHgzdTc1?=
 =?utf-8?Q?ALtOTx0gHBAyDZp9ZreAlCdANr+a9S1cI7xU977I9o6Xz?=
X-MS-Exchange-AntiSpam-MessageData-1: 6g0TAALE1QTmAg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e14dfc4-0b17-487d-ada6-08def2aeae6b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 05:01:59.8972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ufIXVsMWDEAZ3j0foEcg3drpvgUCPSVES/0BYutqsv8cy4snfPhaNDf0jFcxWf1iF4rhPXqSYVKAdGh53LADQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8536
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

The `try_with_base` call performed on `NV_PFALCON_FALCON_DMATRFBASE1`
already returns `EOVERFLOW` if the address is too large for the
register, making this check redundant.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index a91cbdd5d636..cd05985f5ee6 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -9,8 +9,7 @@
     dma::{
         Coherent,
         CoherentBox,
-        DmaAddress,
-        DmaMask, //
+        DmaAddress, //
     },
     io::{
         poll::read_poll_timeout,
@@ -534,12 +533,6 @@ fn dma_wr(
             return Err(EINVAL);
         }
 
-        // The DMATRFBASE/1 register pair only supports a 49-bit address.
-        if dma_start > DmaMask::new::<49>().value() {
-            dev_err!(self.dev, "DMA address {:#x} exceeds 49 bits\n", dma_start);
-            return Err(ERANGE);
-        }
-
         // DMA transfers can only be done in units of 256 bytes. Compute how many such transfers we
         // need to perform.
         let num_transfers = load_offsets.len.div_ceil(DMA_LEN);

-- 
2.55.0

