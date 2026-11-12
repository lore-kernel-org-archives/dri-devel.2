Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42856606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 06:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=F2iRiM6x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8314510E516;
	Thu, 12 Nov 2026 06:15:25 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013014.outbound.protection.outlook.com
 [40.93.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BAEB10E516
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 06:15:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdEVp78cfxJQzMDjzVeRxe/0kR3OtLfv5oNNp/AteGcQhFb8t/pwt1AhUX82YPMHPsImOEiDVik4DFujYlH2RANSG3St0VHk0kQ/eeGLBfAqgD+FVwlJRrekL8iLIbTLaLB+nsp04w4FFaGM1TbOoCsembUDg2lOa7zMCPBZTxL696CHY2LMU5x1Nv09z87316saTZH7l7EevFzL6slgs7QR+ccv44Eu8hSi840Nco1h3ocG2UunZGcXGJ+rQLo+6q/f0WONIOFNXTSawChy/KitXsKN4PawjH+BsDRzvchHhPwRFuzvEhV9F3FwHhkgz407U+Jdxn/VuJSgtYIEKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ss+2O4s3tdLCILnx9V4W2a31zjrrX4eCywwtEK/Rx6E=;
 b=fydEFRtikWd+kQm+uYxGIaU9TRDnS8I7xtQpKEnpedmrsbp77rrAfRH+fS3ZHFF43lBYjiUgwrt4j7Wj6Wat21ency6IuHoCh7/FqoT2XhnRz0EOSHGKjD/IildXVlJungn8NrmeqRpU6adUVDQ8rwPctAFB0dxgrqqx1YOR/deLjcsELKM5vl6cUONFuS9hD1KrhGhZYzE01lu04UHWchd6julRZmw8e0FAAfE6U50hGmHj4hO9JWJCWXXcYd/3NinSvc7Wf2g4CmFQt3Cn/vNMVnmfNQHWZtsaX3K8t9aycFeO0DAvk/2KmEZBq6Q2K/ui1wJKAkXN+YvVFhyOnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ss+2O4s3tdLCILnx9V4W2a31zjrrX4eCywwtEK/Rx6E=;
 b=F2iRiM6xAFRip27uYx07Wm6VFmdcT8Xt7cat2wu0PM9Egqzwm0n0fzIDwlTB/kGTm7BmXORglE24La8C0RX1+csIBAPXS+I0ZAXi05uRvPj2euPzUkVMJ6Nukp8GiEM1rDhOW9a3zPH+IJZ3tn8Dou9xgSWfKeA7OcQHoNr401dMc0C0BbBPh3s5Ex72oy9aoTilUTv/eC+VAzLSMKl/4M3HLj53MZnsE4d0iDL+ncO6n5FKexN5ot4c3BcOv9KpVot2MEn1LSh09UO9iGbs3wJD9bp58qN1aRMhhd/kcPQ/0yy0vBKyQd4J1eX9AFAU3Dq7mw2kR/Azfbcgfr5Xdg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 06:15:11 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 06:15:11 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 12 Nov 2026 15:14:54 +0900
Subject: [PATCH v2 2/2] gpu: nova-core: gsp: cmdq: increase MSGQ_NUM_PAGES
 to 64
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-msgq-64-pages-v2-2-bc1e6f7301ca@nvidia.com>
References: <20261112-msgq-64-pages-v2-0-bc1e6f7301ca@nvidia.com>
In-Reply-To: <20261112-msgq-64-pages-v2-0-bc1e6f7301ca@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0126.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::6) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 0edb0680-a730-44d4-7ddf-08df40844edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|10070799003|1800799024|366016|18002099003|22082099003|3023799007|11063799006|261026121527099003|261022105027099003|261026140227099003|261009223027099003|261028144727099003|56012099006|261021123027099003|261021121427099003|261021135927099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: FHZT/butKmLCM3vV7NtNnrYY1PAxo+KnSMKBXXUfoGKWsmgvYPoJmGlWl/J5p0lbFHQ4iIqILn5JxWtJShqr4RaUAj05HW4II0l6ECvviqKlUNJ97oMKjEwAtWGDH4TKuCqBYE9oUsz6orHBMhw+LdWtr5JnQ0FCUHzbSN9I0+8jObOzUVVXdw/sYfgCaomR+Ia6tgvRCFwfhRBbcTVRxflEny7S6b7B8wzwjRmzVjazX1m8+ltKb0oonRcfs3aTlxdcFzlljfdiK1l+vXPO/jpShXxsIgnvQTXqzDcHVwSdrxv7d7U851vTWOmHonx5hTdMTumM8EyTycgg/dN99Way4NpuXVUO8hXr+mgA/lWpDzJSZU4qsuVkiicBY2zr/N1ifullyZYyV5OxpaOKbhtRC8jyjlzyC5TC+a+/MYSto0KE07wwnjVvhrxr5+bnD9RO4UoQRosaoStKarygU+SCt9SOcRiT9IYG3vlqAMzMCfcy3EdP79PsHffghoDbUGQwpz3TzGjB+YAGo3o3itwqKNhdd9VoaPm0eU8pCQfXzDUH4Gvn0VGl2aMcGn5W+3Z1fTgfECMqn40xkqOOY3Q5t1zGlZ44BEpIvc17ALn3npvjUVnq/QDpvE91IZ6YEeJAlK2divvaL3rFhidiF00PNWa9NBIH2wsiTJptUGU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(366016)(18002099003)(22082099003)(3023799007)(11063799006)(261026121527099003)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003)(56012099006)(261021123027099003)(261021121427099003)(261021135927099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFBTTTEyc3VIR0M1WjZIK2NiVlZGZEtGcUt6NmcraHZpYXh2dksxSkYwakNJ?=
 =?utf-8?B?a2FnQVFEOWh2SU9zaVBlUHdVN0NmVk43anA5UHZDM0NIWVZsZ0lIRXVzVSs5?=
 =?utf-8?B?VFdMMitzZlJua0x0VlVJckljL1JTcjVORjZOZVo0eWFHdXdES29IY00zZ3Jq?=
 =?utf-8?B?a1dueHJwaG5Ea0F0YUNuMTNvdmxTa2gyd1VKY3E0ZkFYY1pLUGdhQWYySVZ4?=
 =?utf-8?B?NTF4VWIxVHV5L1A1MGg4U2p1SzJBQUU1UXlUeHhRQmpEWU9mbHB3VmZzSjVa?=
 =?utf-8?B?WlBKSzNXU29GVnFIOG1jQWxuS2Q3bDExV1JZV055bWpRWDBQeDRxTmIwdTlL?=
 =?utf-8?B?YmptMitmcC85N0pERWtIK3d3dFZCeW5JN2c5Q2VYWUJSay8zblh0R0FFRzRm?=
 =?utf-8?B?MWkyRjBxTU9lUGNFeDNWdG5oR0dYRjZqOURUajRvc01WM0NMWmNGZXpaVDZs?=
 =?utf-8?B?djZyOUNEbEJuYUloWjkvNXc5ZlNWR2FQeHdMN2dWZ1FmMHp5UjBNd3VSL0U3?=
 =?utf-8?B?L3RtYUVoSXdQek9zYVdLVGZRRUoxMktiTEVNRW1kNjVVcWhJUTUrOFVRUy80?=
 =?utf-8?B?dEYvVVh1dVJ4Wityc2t2eVF6RmczYWpLRC9ObDF4bmtCcm9McUJiTHdsejVo?=
 =?utf-8?B?YXhmNy9SRGN1WmZSTzV6VUtQd1JqNTJRYWdDWkV4Vi8xNjJTWVdqZkowZUJi?=
 =?utf-8?B?dU5wbGtMeXpiOWlrOHZOaEFZTWY0aEJ0QW5FVDl4ZmY1KzRkZFVVL3o4d3ZR?=
 =?utf-8?B?WkJPOFNpRElqUDkyQ0tTU3Qvb0dVY2U5bnRML1BpWU1wamliWE1RejkvQlN2?=
 =?utf-8?B?UmVMVlRnSHJBU213dE5IUDcwUXRXakRGNWhoVUdQVG85SDZ2WjhMY2ZDWjh0?=
 =?utf-8?B?RUgrTDFGbG9xUmN4TU5wekZHUXhHS2Rhayt5NHVFWTBZdHQ5cVFCTUNwODY2?=
 =?utf-8?B?a1VhRDhzSWxkdnlTOWJXOVJJWktXTTVvc0dicy9WRjBva3ZJZ0lnMjNCRmRJ?=
 =?utf-8?B?dStvVS8xYUwrUjlEZFBnZG1lV0Y0bWN0M01LZGtUZDhiN2krZzM2R2tuMUY1?=
 =?utf-8?B?a09uODh4UHJIdlk4SjdvRFdnaGs4S2I0akEvZnJ6U0xBaExMWDVteHJJQUd3?=
 =?utf-8?B?T29UVFliZ2tISmxwby9ab2RhVFZySDNlNHU0Yk5taklwa2lmZmRqeFd0UVFJ?=
 =?utf-8?B?RzgzMzRtWUl6N2tVb3Y4L1BVOG1JdUVORlVjK2RrOExVa1RvYkJlakNTUS96?=
 =?utf-8?B?Yk80NEo0MWdjcWVSR1lxY1F0UGVLMm1PaGRZWTJiR1l0bGluQ2VDcmFoSDFr?=
 =?utf-8?B?TURrcHN4em55dFJ6QmVSTE5JcHZNQ0N2WGtrdU8xVHoxSGxqYWJYM0M5eHNL?=
 =?utf-8?B?UnptWXpVeXZDTGtPUkpwVFZzWGJ6ZmhPL2xWU2dQeXlpYlZxMTNueFRTamZu?=
 =?utf-8?B?dS9vemFUaUI3czA2Rk9oazVWbklCVjY4cWxpY2dJQzRxZFBZc3V2cFdEZUxt?=
 =?utf-8?B?b3Bla00zcTdFSmhHQ0ZqTzVLQzROKzMrU2w0SWJscXYyZFRoaEFuQ2tvQ0NR?=
 =?utf-8?B?M0J5RitTTkZSQysvSGpiNk1nMWdHbEdhRFpvc043aVN0VUhEZzJVZFFqdVRI?=
 =?utf-8?B?b3pzTEpJMG02WkNBTXZjWElBTXV6UWZ0aHdYem1xMUZmcGtwN01TNzV3SzdR?=
 =?utf-8?B?MmVydTJPT0hOamNoaGJGb29hRVRVbkdXZXFodURvTTVpVmNybUowdFZkMnJV?=
 =?utf-8?B?eTBvS1RucUoyVDZWZjRxRjlRdTU3UGdvaEhXRmc0TWFHcFBDTmp0MC9RT3Aw?=
 =?utf-8?B?SFQ2Qm4yTE44VjVuQ0NZZmk5ME8wdmZmd0RFUnhvL0Q5eUZXNUpNTmdlUGh1?=
 =?utf-8?B?OFhxR2UyTVR6a2loYm9rTTgyVlFQTjVSQmUyZFltVDRDS0N6aEZQaGVRTVls?=
 =?utf-8?B?WTFoRmRtVjM2S2FweVVUWG1ZNG53bmdjUmtJZzBIelBLRkM4bVFQZ296d3pM?=
 =?utf-8?B?bWtkMUJtcTBkV2lEVDR5MHdZanh5VTlVLzNUaEFHbTBRWFB0SnVwSGEybnRH?=
 =?utf-8?B?bHNKbkxkcHVVeGFWSkhSQTBnN01hNENRSGcveHVzRVFySXpDNXFXeG9CVGJm?=
 =?utf-8?B?elRndnhRZWNUMFR4Z3Ftc0hSK2pXL0JKZDBibjQrSHJaTGZnaXZwcFduUUJu?=
 =?utf-8?B?bHMrWmZTcVllRFBVUmcwZG9yNHd2d3FaZm1rS1JmM3lWa2l6RllzVHNpRmFu?=
 =?utf-8?B?T1h1c3J1aS90Y1hZcG1JRlZOc2RhQjVCNXM0U0d1azBwZlB3alFXalpSdUdY?=
 =?utf-8?B?MkNuQU9nc2xFNXA0dEpNU080QkpFcG0vczdVczR2ZkgzZVJLMmpSUXY3elk1?=
 =?utf-8?Q?zEDHb6Cq1jhoERx6+nAc4yjz5P4XqX65SJ69LSrJc5Dlv?=
X-MS-Exchange-AntiSpam-MessageData-1: haLfugm5mJpA6A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edb0680-a730-44d4-7ddf-08df40844edb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 06:15:11.5103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vR0+qYyDCS3qEr8XNZb0poimDbw+2a0hbNjoXbT0XxPv1ypxq3ruT+Nc1R90LDZ6/KUEjkHrILwaWHcImm7yEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
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
 drivers/gpu/nova-core/gsp/cmdq.rs | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 33074bb53e8c..8d34acaef9ea 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -84,7 +84,12 @@ trait CommandElement {
 }
 
 /// Number of GSP pages making the [`Msgq`].
-pub(crate) const MSGQ_NUM_PAGES: u32 = 0x3f;
+pub(crate) const MSGQ_NUM_PAGES: u32 = 64;
+
+// The queue pointers are wrapping `u32` counters, and the slot is
+// `counter % MSGQ_NUM_PAGES`. For slots to remain contiguous when a counter
+// wraps, `MSGQ_NUM_PAGES` must divide `1 << 32`.
+static_assert!((1u64 << u32::BITS) % cv!(MSGQ_NUM_PAGES => u64) == 0);
 
 /// Circular buffer of a [`Msgq`].
 ///

-- 
2.56.0

