Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19C8606A320
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cCIAJCkH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A5B110F89B;
	Wed, 11 Nov 2026 01:38:29 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35CBE10F89B
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 01:38:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSjUloYKaiyE9Iii19J3O5wonQBqz0YH/tVAWw3PvY2Zh41n8R15jTNRGpyuQJoY9d3IZBTRs3vXsqeO/818mNVE/TZFXXUzjO5iwlBdIubMHosuicxRbd6O7yOmk9aRNFiDtckpVOS2UfOpO1Q6gemrDI1WzdpSmB1iH70MpbtkkSE3raHcZBa4AWnGopXadYzDFsoOkTo82PlGTwvPtsHI1s864a9Zku4jwErhLDHez9NXYpUjwabo4VPC3hZawGysZG35Qd0t5umESGneoC+9MIxeB6V3jaGHNw3S9cJ0LPJIteTkDyn4RhOfm7GRpzTYlYnQUm28MYtiL9YfWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INzt2kvc53lQnTIy/JzhsnHZB5hpdtEpI9sDgB1ns8M=;
 b=KdwobGTzEGWvjOU71wVxi64/T2rAMUEAveKDwE3uFQZvQuQtNz009/goWQZpvwocWSAVADsDyfalhupWv/TNg916GQnlEypE9iWK3kGJbKGcQGD5me3b94r6XncUxQK2dYuhsdI7edyucAkdIe9sSSvS918yQeSjdWbfpOBMXSlp4nQmL+y25dC2Oa/TF74nmaNRN2Vo1wWLhuwV9hjYSiCWRcuG1C38ooXgH/CPfltMaowdNZeM+BaS/k+/nHi5x6dNyYo3b0aauGmWY5u4zKmaSq2bGOmxuWFOKnrU7+1kD2fntpRFD01gICBuSGMI5trdJmB0tBMZ91bqOd594g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INzt2kvc53lQnTIy/JzhsnHZB5hpdtEpI9sDgB1ns8M=;
 b=cCIAJCkH62qUvs3/n3jzc52Tqneo4Bbl/+hZpjRE6696xOMN0iHckgRWgoQZpOkWizKqwNWXkyQL7tRvN4gS5Br2o4BLxe8/iLnhMWGIYlsHi/MI0Scy9tADJ5X2yJzmDD3UIoAPD8LlwJWMkaNn+5ratDrKu0lfFjHjPPBKXynviYws7oFSPGnHvUDgcaeWQSfiE5OqbGiQDTYLtC/QbEtg72Ed2Dzz11SAmfxCxE/TcOjfG57dykrlqvNo4gId/EQDH6/KkiEC09ZF/kUX8OuxNxHxIhpglghNOdS+0tzCnuTSeIU7ruJslEVUxBh8UX8boz2VOoCPcD1yAOmvgA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 IA3PR12MB243666.namprd12.prod.outlook.com (2603:10b6:208:712::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:38:17 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 01:38:17 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 11 Nov 2026 10:37:35 +0900
Subject: [PATCH 2/2] gpu: nova-core: gsp: cmdq: increase MSGQ_NUM_PAGES to 64
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-msgq-64-pages-v1-2-d8c56b6fdd6c@nvidia.com>
References: <20261111-msgq-64-pages-v1-0-d8c56b6fdd6c@nvidia.com>
In-Reply-To: <20261111-msgq-64-pages-v1-0-d8c56b6fdd6c@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0336.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::7) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|IA3PR12MB243666:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb8e4fe-0684-48b0-d7c2-08df3f9475a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|23010399003|376014|11063799006|56012099006|18002099003|22082099003|3023799007|261022105027099003|10067099003|261102123227099003|261021135927099003|261028144727099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Tsa/yKImkt9RjndZCjqk6+7Xz6bX+9388mLAm3SuyMtiU20NquXwHscKxcCZ8Ot+BqejSNaFL0WtlYxmHMSheDsHp219PiJOZeqr+MSfChG2yxIMMWni/PrnSSCyI8vEpEgvXk4gkyYPwBYQeQQ/A1e7mIug3zvJm9WN14t5uua6GqWMmAqoM+wWIqGc/tznJf6IIEKqaIecsVyvZQobXroCXA2avTUHJkTEvmIlskWd9zqOpPnnfMRnZSKHMiqx2ZntvLl72juQVwaLU4bwqO/8Kf8unrJVXE61d9iTaZPYa7/RDF7nv4rXTqHqLLWHgCBKcoIiVn91KdUV+j8qzzmLKqbMIBZ1Wgc2Z/GVxloN0og5iUC9HIw+PaF0Tib0HkMp/Buzs2MT+AvZXg7MbjP8ChwAQBbo9DiYd2QJjYFVH+sj6APMqlbx4VmfQ1oHKO2cJkyEwjS2i0IyDmkDBIEIp7OS/oE5ccpl3b5/seQyoPhV05y1CexScztHgrFWOI1cYCl6hWK1D/YL1vCm+KzjYN8Nqfw7Wb2SvshHtm0DjPBfIdXCx8gNCwofkcXNBqvG+1CeP5F6qAkPu2L2T37vBpK7E0C5CVGMi8fWfyZGSqehUxmzea169EDUxPRBmcdR000RhJDz1kEkqdXWfw83J4nxAn3c7uMihzhzitM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007)(261022105027099003)(10067099003)(261102123227099003)(261021135927099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rlc0YTVCbVZBTXBSTHV0MmFPOEFSczl3Tmg5RWVqU1ZPVGlRT0FvQWF5Vlln?=
 =?utf-8?B?ZnhpVkdhS0UzdXVNeCtrQ29ML3BQbmQ5dFZzcjBqK3hBd20zMzZ2aGZKYmpR?=
 =?utf-8?B?Y3NsQ2w4a3VsU2d2UVZUc3NvMnRKUzNEbU42UVJpSStQQzRnL2JIemJaYjQr?=
 =?utf-8?B?Yi82Z2lScFhKQnVrb1FVT0VtdXlrbFFVVitSbzJDYTBmYzdtUDJPV1RoVVpy?=
 =?utf-8?B?T2pLSkl1RGZIaFFmZksxZllSK3FXYUN5MnlWNk1qUkZzd28wUnBrRnNPUW1W?=
 =?utf-8?B?MmVNei9XY2JsQlVRdDVxM1oxSDQxS1pPSlBiMHErOGExb0d4dDQ1QWl5bUFM?=
 =?utf-8?B?WkQ4K1g5WjN4cXE3Z3BTY2ZSM29qazA2dm1yL2dhUlEzeFBjN1gwc3EzS25I?=
 =?utf-8?B?LzY1bHJGczhvN29ZOFNMUTVodzUzcDJGSEVJZjFnNnozay9wSlN6R0RQWEp0?=
 =?utf-8?B?a0J2UGF3dnVDYXBXcmNWMUhZQlFjL1hxR090STFZZUp0UXB1NExWOHVnVkhy?=
 =?utf-8?B?MjVPQjlpcGVKNGs2VTJNS1pvNllFV1dqSHNvQjRLLzIxUXYzSnFaQlJIcHE1?=
 =?utf-8?B?Z3pSRXExaHVqdS8xR2hhMTdlcXpuK3o1V2ZHbnJHQW5oNUJGaTBvam8wa1Ra?=
 =?utf-8?B?bEtTMTZ5b3pCWDI2MnJsWHg1UGRkcjU4VWhnQ0hJbk9HRVg3ZG1DZHdQYnhY?=
 =?utf-8?B?RkR2aUM0WHlWUVVvdG9MSjJVMUpCUnM1ZGJsd0JlNTJrUDVBT2VEeGgvZTJ4?=
 =?utf-8?B?cVRJc2ZwcFVTcitqeTcvckZZaDhHTldHNlJVcWhaNG11ZVVtemJQOGNlSW9Q?=
 =?utf-8?B?Ukp5L0ZDb2czUkd6bEVKdHNPRWkyeG53d1kwWElMUXF0aTRDc0F5UldoVU1h?=
 =?utf-8?B?bWtPcUpmbG84T1EzOHkrTm80V3c5VXV6dm1lVCtiK092VG1MUGpXanhzTXN0?=
 =?utf-8?B?NFBwczlPc3JlYVJxaVJtaW1HUnhGSDFER1BBQVd3cVZ5OEhhVnN4ajF6dmZs?=
 =?utf-8?B?VEhqTjVPUGhsbllOWnhFcXFRR1Y5ZWZuRkNLSmgrWURPWmFzMjFPNEJubVFT?=
 =?utf-8?B?WG5qWlBDTG83QjFZd0hIWG9xTEpGV3U2VHFCTTBlRHAraE5nekpPaytyODk2?=
 =?utf-8?B?eDg4VlhOYnlJVUJ0WmNSa3BST0tiOEVqYk9DWUtxRjJTVFpBZzQ5blIwYjRS?=
 =?utf-8?B?aThOQ040OEYyV0pNUWR6RUMrbTN0T2xQcmJ1emlpNVNoanBmb3B2b3VvaUpK?=
 =?utf-8?B?RjVZd0pBS1cxS2Z1T242bExOUGF3UUJwREh4dXBDSXJNSXhUSDJEc2xjRm9R?=
 =?utf-8?B?cTY2SmFwbWlHVXN6SmlGajZKZlBVZmNpMG1UamNycVptSmZxUkNpK2dVSlBo?=
 =?utf-8?B?d3c5UWpUbHJXampzUnFSdVRjWkFYRzIydDMzb2NNMlUvdmtqQytDQmgxTi9w?=
 =?utf-8?B?OHdxQTNFeTR2cVhFVFhGV0FZVjV4NmcvMHNEZ2ZpcE1GK1V4YVhRWlFDajlU?=
 =?utf-8?B?YXFmSElyb0xUNUkydDZhVlgrSHRmcW1uVXFObzVQQUlvT3B0Q3Bidkkzb2h1?=
 =?utf-8?B?c1p3LzlnUXlUcHdCVFN5N2hZVlpEUlZYMEloaHFRUWM5VENqdHFkdzZFUnJT?=
 =?utf-8?B?aWxBM0JWUkJrSW1YUlNyK2U4WW1vZ1ZpU0x2cUpjT0lkWnUwM1BaS3diNDFz?=
 =?utf-8?B?bWszNnlZTlVLMHlnQzJMaTNzTWx4by9EelNTV2VhT2I2SVpQVGV6Y0FQSkJz?=
 =?utf-8?B?bVRkMEl3Nm0rOGY3cDQ3WVRFd0tGTlFwbXZFVS95UWtVS05WZnhXY2ZjclNp?=
 =?utf-8?B?NWZSaGFGRWMveDNVcEpmSGpFNks0aExpL2p2alRoSk5nTFZ1NTVmNG8yWENp?=
 =?utf-8?B?VSt3VGlMektuZEdJcXR2cXhqOVZBVmlMYitrVXRoTGhmT3Vic29DODZXOTBB?=
 =?utf-8?B?Y1F0QnZPU09wdWlQNTVXTldaZnloVlBWSXBBZGJVS2pyRzVRYi95VkdSbUZI?=
 =?utf-8?B?MTB6QVhCSzRSV2RmTGc5Y3BSTG1HNzNyOUFaYmVBN0ZuMmxsY0wzNUhldVlX?=
 =?utf-8?B?TFBnQSs2U2pvc0hiUERicWRpYWdIcDIrUkJQV0xMcm9jMWlNdkR5SWRsTWdx?=
 =?utf-8?B?M25STzJLRXcxZkpWU1ZmVHV3VVVac1BOcXJBOVgwVGtkT25MQzhBMVhRMC9O?=
 =?utf-8?B?V3h2M0dLOEJWWlllU25WdHh5eTJ1b0hnd1E1RFBmVi96MUxmZkxwTHVLcUV2?=
 =?utf-8?B?bU54a25vNklreW1MR252UER3a2l5Sk0yMVBSNHdSRFZEWERzejdrelhJK3VG?=
 =?utf-8?B?alMxekN0dnZnZnVQVnhzUzJVYU1yNUdJUlVaTHg1eWdGWU5ra1NGclRoTU5X?=
 =?utf-8?Q?27hOcUUVPollvr6wCXwvPslYB/QClAPkP9Uq5Mu78X3CI?=
X-MS-Exchange-AntiSpam-MessageData-1: skKdNfaTEXHpQQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb8e4fe-0684-48b0-d7c2-08df3f9475a8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:38:17.4352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQiAYfBVipmWbWY5emeNwEzodkTEL1TgvoAYDSWNT66fUXngxD4nL9QRT52oSagqEsKqPVyj3UrxM1uBh9HuMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB243666
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In the msgq v2 protocol, which the r000 firmware uses, the queue
pointers are kept in u32 registers and increase monotonically until they
wrap at 2^32.

`MSGQ_NUM_PAGES` is currently 63 and does not divide 2^32. This means
that on msgq v2, the slot can jump backwards when the counters wrap.
For example:

    (2^32 - 2) % 63 == 2
    (2^32 - 1) % 63 == 3
             0 % 63 == 0    (slot 0 instead of slot 4)

The writer can then overwrite slots before the reader has read them.

Increase `MSGQ_NUM_PAGES` to 64 and check at compile time that
`MSGQ_NUM_PAGES` divides 2^32.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 33074bb53e8c..240ab42db557 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -84,7 +84,15 @@ trait CommandElement {
 }
 
 /// Number of GSP pages making the [`Msgq`].
-pub(crate) const MSGQ_NUM_PAGES: u32 = 0x3f;
+pub(crate) const MSGQ_NUM_PAGES: u32 = 64;
+
+// From version 2 of the msgq protocol, the queue pointers increase
+// monotonically in `u32` counters until they wrap. If `MSGQ_NUM_PAGES` does not
+// divide `1 << 32`, then the slot, `counter % MSGQ_NUM_PAGES`, can jump
+// backwards when wrapping, which could overwrite slots that still need to be
+// read. So, require that the last counter value, `u32::MAX`, maps to the last
+// slot.
+static_assert!(u32::MAX % MSGQ_NUM_PAGES == MSGQ_NUM_PAGES - 1);
 
 /// Circular buffer of a [`Msgq`].
 ///

-- 
2.56.0

