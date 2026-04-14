Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F293F9D0C4
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 11:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E54B010E597;
	Tue, 14 Apr 2026 11:54:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mxxcwx2x";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADBF010E597
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 11:54:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDlWpwo5Zhld8JYMUh0N+mQE0/2oYH0qMk2r4GAWxrbhnDCuY/U8HLvol5R1Uqla56o4H/83BkQMZnP1cKvhGWXTt7JH8cOR/+FDKpj48Itwzu5v/0SsX7oDfAHbqB1v2CfEJJCjoj/tX6g5WdBx8duTmOJR+ytrYsIo9JUdsPAZwqRP+f0SFi26PpNzxdr4h5IgG6ABa560ByQf7EvzQrSy3Yd5VxrQBgHbUtLsUMF6wlJXKIUQE2UkoIq+MzEyi7j6Vl/GUDJlKjcN+VUUJlXaVvmLdBJKJR6QXWQoJsMXGBtBVr2fHuNY3jA7mEneeO7FbJx9Rtjo1Kb1E6btDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xe4lj25pLelHhHRVrinfyrwKL37xLXF4CF5+fweIzk=;
 b=mYh3k6R7a9cJ5yVUeYHirA/QurbRLnBhT5dVjmLnhxXW0elqgLAm8GN0EDQbjLKN8Ugg//zQ2RiSTZrD1bDxvSvlizCJYCqd0SvlCoPJTW7PRFRTZu261/uKocvzG0THUYcdRB/4kO6ozrfuUI5d3mO4kDITJKLkY3bhEPORtJNzz9sOrxYSHo0FUD85pkie/G7zKn5ZJfsXgXdxZo+t2Y1cRN/O16iM56aV1ml6o4xlcSjMyRbuEBeGmIr5FXQRQKG/L8HQLGd4q8DIsLtMEhJ8qQgD+KQeH0ybMKKGherEwWNK4JtkNwW0atgm0EO2/Z7xz0y68Yrg+XUkJIHH2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xe4lj25pLelHhHRVrinfyrwKL37xLXF4CF5+fweIzk=;
 b=Mxxcwx2xtfN2VMbI/D6EZEhmHCnGGk6R4mpwLl1JGVMQZIqOuBPPuqBFPZHovYuN4sJ+1rstzPBYU5P4ZKrZnbxufPOedQ/EVcr0QIuEwRCTQEdCE3Y6ICOKqXvn+eS7Wd4sU+IX9arbgLTXVEYCACU+n14OKVUyJjRc4baN5n2lml1BWmnbvku7JI5hDaMei8++Q92B3b+E9+/qRQKJBWv/VhdxxgVngGhkYXSDELrZOc+irhV2uP2eD+lWrjR8r/t2pKR7fNmo8eEgMrzFojfMW1I5uuHLIzKmaqxIOdtYbqdyTGoU4lqWDVmIT4FS0TQybDzXTix+JvtPnILdWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Tue, 14 Apr
 2026 11:54:25 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 11:54:25 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 14 Apr 2026 20:54:05 +0900
Subject: [PATCH v2 02/11] gpu: nova-core: vbios: limit `BitToken` entry reads
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-fix-vbios-v2-2-705d30d16bba@nvidia.com>
References: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
In-Reply-To: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: TYCPR01CA0128.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::20) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: cc97e962-f8ed-4a2c-2d6a-08de9a1c9325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: PO3H37LPzUP7zO1OXx/NezzCr+0VZ3ZQUOn9G2R5G5rziQnhaTiOYxTV0mELWYVDKJHCBZq16nd1E23QvKOKETv+NppU1GhCAgmMQUXdqWAGlinse7bEXH8tBY9HwEZUwKBnGqmggz5b39slPuxU0qWP4HhAal0Q12bDkEPaLeDb5UStSYDJsO4jj6vYOTKN5j4VtYXhclky8fzzont9xzQA+/dQxxYnf12+MKh0Sw7DjdIvEyqIXDPVG+jcI2EJ50JJYv7dVnh3Dwt3XBk/l9l+Aq0vKvR/OJDDnIaWwTm8wwPKTfNI3fsUR0xZyFRWHNku8JhC8uRVghGiKSeyfH3zTnOYS+I2UYQJIgBtSxnogrzunLX4KE7e840EgzS5oDA9FgvP08ixVmIRegJgDc+Cc0Y5JgwnRZvQ8xyPtrjQerWL8hjF7Pb9mC7WFUXiE4Qk4fLAckwOZ+vdGMUHXXO95QbEXr9twNtAguqGRMr6j6abWaDXWZohGsJzSXcraPPQ0y+RfU1mpNW06S5cJbQwlzt+W2PriFbhINHYwC3EbuVmC6e6IT7BoyeYMGWUyZSJra6ftCrIjV1ojOYBg/R8kujEnPLp4mBZ5WVkmTiEoTGX3bdH3+0tjA/Dy51wcSjn+opvx1EagfUIQp4uDxEgrytz6F17kOIjzfiT2QporIsE3/CC3X2geG0pmWGnXvi3CBV/117KJkL2B8juZcuLnUa0eYSLRa0q4GAcntA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2gzQ3U3RmZNM3BwVmg3MjRvYVlNZVA5QkgyZUNPeTFoZG8xRUxIcWppY2VX?=
 =?utf-8?B?a3o2cm1ZU1NJR3k1Ym5ScjdHQThNRW9BTEdMRkEvU3NZaUl3S0ZMZUhMSDEv?=
 =?utf-8?B?bW15cUY2bks3bm40WTk0Yit3TjdSaGY5Q2dDSXRxbzgxdElvNWZPSnZhVkk5?=
 =?utf-8?B?WXYrTGF0ekwyN25SRjhFNExEanJlKy8vOS92SWlrdGVIZkZsS3RUcDB5M2ti?=
 =?utf-8?B?ZFZEMTB1aHJRc1RQZXVoQ3ZLUFhMR0k4a1c3empKUXduYTQ3ZnV0VVJBb21y?=
 =?utf-8?B?Sk9yZ1U4bmZEWXNBekJ6di8rNk9ZdE5VeE1oTnlyd2VpUVJpVkZ2Q3BYaEdR?=
 =?utf-8?B?QUpoTG94Y1hVZzNEM3ZGRzQzenRmY2g5RVBvZHF2QWtFVkF4Ym41WHE3Y003?=
 =?utf-8?B?KzRuVmNsN1ZnYVVPTCtBTVVjV1ZwTVYybVAxck4xaGZyR2ROeTJVSTUvUGhD?=
 =?utf-8?B?ZG54T3FhaWV1WHp3QmJVdXF6eFRTVVF6czByY0wwWkI0cUNrcWphdEZDcmd1?=
 =?utf-8?B?YXIrck1zbHhyeHZFbXlEMG5WVTNPaURVOGxwbmpuUFVjZ3NkeUNlemtvUEJI?=
 =?utf-8?B?cjdhSVQyN3dvNFpKNEhVZEZXcXZBYkY2YUM2eHlKSW5wVDZOY0hSTEtldFR0?=
 =?utf-8?B?UVpmZGt4UmF3d0J4V3J0SWhtdW1YMHdQemowZnZUZVBieUx4VHp2U1hhZzd1?=
 =?utf-8?B?cVd3ZFppMkMwb2MvVVZjMm83ZjYybnRDK3NjN0UwaFhvUEhIdEF1SWlENHFM?=
 =?utf-8?B?QzFGaXZtVENybzBaa0J4YmpZSHdyMnFvYVNwekI5NjVNWXh3SHdtN2VKcVI5?=
 =?utf-8?B?NWlIRDB2TW8xdW50amxtOVZBTllZdlFUQWpvbUY0OC83bUN4OW1vbGtUSlBN?=
 =?utf-8?B?ZUp1SjdEYVB3WHowdnNEOTZ3RWRvYkpmelpUQWpzTGI3ck9DVTAwZWxxeFMz?=
 =?utf-8?B?d3B1WE5tTVJPTzNHSGdPVzFkTjNUczZPR0dUOU1jQVpiQm1DVUNnOHNEb2I1?=
 =?utf-8?B?WEhsZkZvWVRMRVZIVEdGeU5GSVlTTnQxUUZnSWhvN1l2VkVmUFlDVi9HeTZY?=
 =?utf-8?B?ZXZGMlRMRmRuRW1rNllXYlZrRGsxWkM1VUwvYXYrUDBDNFBFM080UDZ4SW8x?=
 =?utf-8?B?Nkk1RmVSMEdFVmYvQ0s4WW00bm5Rc0ZzZlE0TE83QStLL0hKTVcvbjd1cmZE?=
 =?utf-8?B?MWEyMnBRbFYxYmNJVmM2UllXTW1UTXpJSVgrRHYyMm14WmZKN2RnTnJCeW9L?=
 =?utf-8?B?aHFkVkhPSmNERlMyaHVYUDk5azhVOEwrWW1JMDFXbVZDN1Q0b2RVQ1hYL21w?=
 =?utf-8?B?elR3bHM3NG5uZ1ZnRWZKbWNtVTdHK2JzanJkazUzQlB1Mm0xWXdLZDY2U0Jq?=
 =?utf-8?B?TE4rL3p1OE9sZldUbmdVdHdCa3kweVJqS2x2VXdhaWFKOEJXN20vWmNWeHgv?=
 =?utf-8?B?RnVLTnM5ZTZWNzN6SjYxMjhUb3ZrTXJDeng0WCtVbENCQVgwQVV5K1hBeFZm?=
 =?utf-8?B?QzNxUlZ2ZFYvTVdlVHk2Umpkak5NcTI3a2VibmVza08xSFBKWFR5MEVRWjg1?=
 =?utf-8?B?dVVhalZIQkJ0ZVNVK3dlU3ExTmR1THhoeHRVZVlRaXlpU3V3eStGRmNWZWNx?=
 =?utf-8?B?bEhidWkvZVh4aFVPT3pWZ2RhQysyNWtsS3A1ZlRYVXhyS1hkMXNrT0Q4S0E4?=
 =?utf-8?B?c1o5Z0VQa3llUmV5eHcxYWZNZjA1MDFGRHQ1RmV2bUtqYlAvbHRqTDZINTMw?=
 =?utf-8?B?OGRwZHVvSCtLekdVRkM4NUtMQjlwSVFtay9yVTlsNVdFaE1HVVlKU0t3V0V6?=
 =?utf-8?B?MkxtQmNwZGtyZDNCRVZ0OVBwM0dyYTNOdHhMTllpdDRETS94SUFXWHcvSmVw?=
 =?utf-8?B?UWRmYmdvNFoydm9BcG5LMFJreWdZSU1ON2JWUGJLS3AxQWtkakpjMjNFc2hh?=
 =?utf-8?B?TFBKVm1IYTJ0Yjd0NVJFNFMyVkQ0bmEwOXBrcVBQK05CQVVtSFZiMWExMmMy?=
 =?utf-8?B?cDNEVTZUaFoyN0RCalFVU2t1Sk5lWC8rYW1lRUUxRjUvL2grMGJ2Tm11NC84?=
 =?utf-8?B?UlZJaStWd0tmclBlV2ZQNUtNSTh1UjNvSFpkdDVFSjFqTjc0U1JXRWFKMjlk?=
 =?utf-8?B?Q3p5RS83bURRV0RwaHdzSXM3K3NCcnNMRFVUd2U2SHVHMmNsendoU1ZmMS8v?=
 =?utf-8?B?Y0pDYWwyckpOVVUxT1BKQ2kyOXVVVzRiUVB2Zi9WLzExZCtXdmhyMjJCMktJ?=
 =?utf-8?B?RHVUM2lsZXZGV3BubkFqeERzQ2x4Qld3Z3cremd5UGxYaHJmZkNJaTYzM3Uw?=
 =?utf-8?B?VFJmUkVZV292VHFsVktYb1RuUXVWWVhFKzY5SjcvaGcwN1VRK3dkUWM2cEQw?=
 =?utf-8?Q?3URO7yLyKjDRtyDwUSMs+4WkUAIlrTxpHMHHuIDcb+UBG?=
X-MS-Exchange-AntiSpam-MessageData-1: c3tv5S8p0zlUEQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc97e962-f8ed-4a2c-2d6a-08de9a1c9325
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 11:54:25.2792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /O72ID9ESLQl5B08udMYsUjPhGLxF4fXTpzTylOxyJrKrhtvFonKfzfxg0guNcCUaJN/RLUyKaOMNl90KmCnJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636
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

If `header.token_size` is smaller than `BitToken`, then we currently can
read past the end of `image.base.data`. Check that the token size is at
least as big as `BitToken`.

Fixes: dc70c6ae2441 ("gpu: nova-core: vbios: Add support to look up PMU table in FWSEC")
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 6de7e58e0da0..de856000de23 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -423,31 +423,31 @@ impl BitToken {
     /// Find a BIT token entry by BIT ID in a PciAtBiosImage
     fn from_id(image: &PciAtBiosImage, token_id: u8) -> Result<Self> {
         let header = &image.bit_header;
+        let entry_size = usize::from(header.token_size);
+
+        if entry_size < size_of::<BitToken>() {
+            return Err(EINVAL);
+        }
 
         // Offset to the first token entry
         let tokens_start = image.bit_offset + usize::from(header.header_size);
 
         for i in 0..usize::from(header.token_entries) {
-            let entry_offset = tokens_start + (i * usize::from(header.token_size));
-
-            // Make sure we don't go out of bounds
-            if entry_offset + usize::from(header.token_size) > image.base.data.len() {
-                return Err(EINVAL);
-            }
+            let entry_offset = tokens_start + (i * entry_size);
+            let entry = image
+                .base
+                .data
+                .get(entry_offset..)
+                .and_then(|data| data.get(..entry_size))
+                .ok_or(EINVAL)?;
 
             // Check if this token has the requested ID
-            if image.base.data[entry_offset] == token_id {
+            if entry[0] == token_id {
                 return Ok(BitToken {
-                    id: image.base.data[entry_offset],
-                    data_version: image.base.data[entry_offset + 1],
-                    data_size: u16::from_le_bytes([
-                        image.base.data[entry_offset + 2],
-                        image.base.data[entry_offset + 3],
-                    ]),
-                    data_offset: u16::from_le_bytes([
-                        image.base.data[entry_offset + 4],
-                        image.base.data[entry_offset + 5],
-                    ]),
+                    id: entry[0],
+                    data_version: entry[1],
+                    data_size: u16::from_le_bytes([entry[2], entry[3]]),
+                    data_offset: u16::from_le_bytes([entry[4], entry[5]]),
                 });
             }
         }

-- 
2.53.0

