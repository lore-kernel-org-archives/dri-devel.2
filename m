Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23856C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7267010E68C;
	Mon, 17 Aug 2026 07:04:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lI2SqdVf";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D24A210E68C
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:04:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZleLdHw/PM9f4KUNFRK8pwhTMvl4vXiW6g671MJTrTXEuC0Wt2dAUidQ/7Clx0Z3ogi/hW567TAeM/YW1L81pcjLewg0330xbxPbTC3bI0dn/HkAGHJTP6+8MM4ooP9Db6sCCY/QPmFS09KTQ/v/CnIqY8lU+3g4ONqTlnxLXx22iM9GlYbVhO+YlejEBDBf+Hl/oOieT+FQRtMZ/OAbUR69/tCTK0xZaDNf7H2n/fEYX2xpMyyckUSEWRR/LX7ye1Ji8hDuHtbpEo0A8CD+nauTvk5ypVyY1V1LAyOL0p6HKd1ozo80QhEa2I1I4GdwzgD5QEUACQ+/wAw5grJVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9lL4P0+kPlectpChZgVcvyHpgOWc/edGfJoeTv7RIY=;
 b=qm6oVRqxi/S9swAVOqQaNShZVI5tXZqDvzJdOWitrPaNT8UUPsPhfsNF2gpExxe7AeK/FB9GS8/QRDO3cOpgkQOKz+lJ0TXG4YXlpGm8AOMC+6Ct4iih4gCZvcetusNhdVBKrLa3iwdfCu88vMPVklKMa6QC1ZnQSmuxX92h8OMkoqc/YzgBBmBxMfLaxnHzYELRWRbljKxgsjpIynfPMCC6Q9cilRoJ78B76VYVG0EQJM1+9J/sq12K2RvchNcQlHVUF97FaxBN+4/lxyDOjBIi1qtQonp056V1RUwsd9Ywm9TyQmDI+8D5VnkOLp1+H4G/bPru1qb6kR0CpfMgsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9lL4P0+kPlectpChZgVcvyHpgOWc/edGfJoeTv7RIY=;
 b=lI2SqdVfOt5ARAVrBT34NBuEYUqgHrLht5RTaETTKTcPL8oKyMSozFV4jFkvhvPjxOPovVBXdLVxpLvrz1K+e5/lBgqTBVEXgC5hZNUYk6AXLHroKCq6V2zBTS9X2qqCFjE2rZM/d0g4NiCRKHHJHvUjh1eAlFfFu2wA+8aygsiyvZzK9pvKwP/XJjkzSybu84Bw+Y29/UUjXTWC4QUQoB/W/jWAd7H8xX61rSqXmd1TIFc6sM1UUTCBlsbKHx5k+FJMZfadv9rgTYZljP77NqdqEK8NpY9fDaO4ug3r1h4xlkhRrLL1bGfqjKYNV5+BY4CULGdpsRxu4EDXaU0CoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Mon, 17 Aug
 2026 07:04:33 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 07:04:33 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 17 Aug 2026 16:04:17 +0900
Subject: [PATCH v7 03/10] rust: num: add nz! macro for compile time NonZero
 values
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-chid-v7-3-a5872e64d8f4@nvidia.com>
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
In-Reply-To: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0034.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::11) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2e3e28-8c4e-4435-b37d-08defc2dca42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|366016|10070799003|376014|921020|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RBmpQFXKOVpH2twPRPw3xljNDkWAh6c7EKEP3mR2ea0vHILlHGSMfIBmubifKz1Y9RbNSuZGoIxL4bvRIRoo0RoVD/31wHQOjsOwUa7PHLaIWJV4+Vmy8kK1j7mI3zh4ROldVTuLgCn94oUNqf0OqISJHbsBY1AO/3pSB2/Xabph47pjYuLgL/jgP689tedeIaPGPsOEFfGOkhaZBsZGHaiaG1esxauO9uK3ij4G9PRmHH5P3M4EB6PpDeajU14AdxpHRgVvjTEXNQZX0yWjGZhwGvKfUfeEUXeWz7nEDsIEz9M0sSsxA4jYorVYWBs2ozCEaT3xAvRRVbpiHgUxh4IMypgv+yr9LexqodnaqyNe8sw/M4oU22ahm7nqQd5M7LpXWHk9HLs5jF2B4G4dPsXOn5blXxoEP4c+CCNbusDc1ndYCK07C38H6Y/8Xw4KKFx2wx3vD7M4sIYoS5nPSievveI7z6AdI6DzDqN3PjFSf9WPimbTalNcxlA+XWexrAQE8nrfyVWGBakFtS4NeLJKXwhbZqqg/wzX5Nher6WpIvuR0oG64teGGyOAYmv2/wrrO367Ltgr8wcYlvRdoKqA3FytCOWPGvz4Y5++Q4QVeVnEbBm2cTKQmhjl2SFRasZUZT9LSouRit87IwCwZ0uN9poTZ++MCdGGIaWUmFHsxKd3V/YnBvPne2W8KNC0YgsZZIPLa4R+pofm9HlWVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(10070799003)(376014)(921020)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlVYbi9aYTZIS0VFeHRBYWx2MThQZ0VXbWx2Ri9QeHVnWUdBaDRxR1REc2hV?=
 =?utf-8?B?OWNuM0pVYWlEUnRZTURFd2lNRGFERE91VEhJZVVvL1JOY2VDN0ZvaXpUOXZa?=
 =?utf-8?B?dEpCUTRoN0JKSURaV1k1NW9sVmVlakxtZXJCRjhRWklwQnNlOXo2ZWNIMkFE?=
 =?utf-8?B?WlhMbHJLN2drMFVxQlhJMEtnbDlpNmdaY0N2ejBsMUw2VklTYUoxbEJuckps?=
 =?utf-8?B?WDR2YnFQSVA1TnNFU2NpcDBrbW5WOXdnK0FkemRFcDhHcjJYbGhzTWN3YlR5?=
 =?utf-8?B?dklvV2t1TFZZS1hQd3NjcmFtVFFSdldOSnY2TzlTZEpjK2pYK0M3MmpLNHEr?=
 =?utf-8?B?VGlOMVVPVFJTMHBpUEpRSjBkZ1RVMDBiLzNVZWJ0Qmo5YlJoRHI2eFVMSG5t?=
 =?utf-8?B?amNyZjFQK0NieDF0UUJnYUtMMG5mYnpCSjhlVEZGbDExWWJmY0VBVGE5T2U3?=
 =?utf-8?B?eVZNbGNJZGZKQVVEbjhDeEdpaDYyNUg3YUg5L0JWRFpZc25UNVdhUHpWbzdn?=
 =?utf-8?B?Qy8zcGpCOUYrQXN5eitYZ1JNbzRKUWM4OGRlNkNqVTBSNjNqdlg3OUFRTzdI?=
 =?utf-8?B?M1pqUU5VNElmODI2RjlDRUYyNkI3YytWSW1yRVM3eUFrSXhZS0FJQldhMDc5?=
 =?utf-8?B?a29ORi9mUjl4TW81NnNPTldMcGsvZlQrcklsM0hJNngzTWJxMXB3N1VxZVQr?=
 =?utf-8?B?bk5RSHo4R21NbFR3UkordU9uTU0wMEYrZDlpcDB0OVBnMG0xemFZUzQxTTVT?=
 =?utf-8?B?K1ZxN1NFUzZrWmQ1YmZqL29WNFFhUVR3ZnNRUlVlSE4xdWNBemM5YkdrVEM5?=
 =?utf-8?B?MjhXRjZWS2Nyb3Y1OGU5R0pxZ0JXdnZBZ0lFdmV3MDVvNWp0Z3o2eW80MytZ?=
 =?utf-8?B?YkxsN0pnMkRZSnU5YVR3Zlhoc29ZZEptTjVsMm9QbUQ2cForSTNBQ08yaXg4?=
 =?utf-8?B?eUJpdXBlRXVWMXRnK2dGNGJRbElVa0w2cHVIbnIwempXNkF5OVI0MXRNampT?=
 =?utf-8?B?TjBTczFxeG55R2k2L0plRzVnZGZQWWtpbkpmWWhVSFc1QUJ3cytoTnZyVmxS?=
 =?utf-8?B?aStaeVlvWGduQ3g0LzdQVWpvL2NhbjVKUjRlc05NRkMyVUw4UHd6Y0lLOVVO?=
 =?utf-8?B?cFlyY0lKU0tDcEp0U2dZR1A4VHdkeEFCc2UxbjFaZnVzb2RvMTAxMG1DbUdq?=
 =?utf-8?B?bkJzL2tWR1BvRUZTeFQ4b3VyUUROaTBRQ3JqTWFEUzEzd1JlQVdrclpZUWkz?=
 =?utf-8?B?WmFXMDgvMEtNYTU4a2ZxVXpCV2RsNC82ZXhBWTNyZVVOeFNGU01SSm5LbllS?=
 =?utf-8?B?T2Z2RjJybTBlcjZYVWozRndFbmVycitJREpEMlJIQnJaWkl4dWZhVHVQcmEz?=
 =?utf-8?B?ZzdQS0N3K25SbU81allYanlLcTJUZGtGNDBMT3pDK2l0Y1hyWDgwcklFMDdk?=
 =?utf-8?B?N2RmdlJxYkJDa1ptMlZmWW51OUN3elZGVElSUWVkQjVuSWZ2d2ZRbTAwTHdW?=
 =?utf-8?B?TTJDa1ZOa3ZaWkJBZ0RuUUx5RW5XZi9UWFNLUHMzdld4NWNqZitkc0VEckFv?=
 =?utf-8?B?eVBRMFYycC9XdnhDR1RoNVgxK0tpRCtxUGY1SEdFVVBTKzNEMEM0N0sydXJw?=
 =?utf-8?B?d2VIMWJNRE5pUUlYWlVXZmhscjhWZlJPdXhDT0NUMGVyd2o2dk4yNkp3Rkxz?=
 =?utf-8?B?SmNseldMbzVtR0E0OWZnYlNDWS9udytXY2Z5UUNmSHh4bmJrdHhnUGExOEFy?=
 =?utf-8?B?cTIvN1FqWGZzMmNPWCtjcTJ6R0J2TmJ3citOQXc4SEI5VTFEeXdUMDE1UGUv?=
 =?utf-8?B?LzB5QkFRSU9uMXhQbDNaWFRzOUdhRkNRSDAvSm4rSTZ1QWpGZzRnSzhzTVln?=
 =?utf-8?B?alZhZitEaDBvRXo3RytXRDVPa0w3b2VzdCszUUN0RitwUGtqcjAzMWcrazVl?=
 =?utf-8?B?T2lQc0Iya3IwUHA5M0h0bkxsZFFTNW1ldDhzNlA5RUsrNzZISlVUU1JmdlM2?=
 =?utf-8?B?ZzZRYWhUWGRFZTRReU5ybXY0VFpySlVsMU9QeSt2cU9GTHJhVjFBa094R2dP?=
 =?utf-8?B?L1lleUlTR1Q0ZHl0d3M1UEV1U1FLV3FqL1lkWEFpNUFRRXdjWGlPMUdBVWhy?=
 =?utf-8?B?ODZTUUoyUnp3cFhOd0R6VmluY1MzTmVaQ1RmQU9CMVB4di9jT0Nib3ZSQis4?=
 =?utf-8?B?dVdITWVLOFlTUE0yZmJNWDJLQTZ5bEI2djVyUkU5NVZ6RGQ2TlJYVXd6RURL?=
 =?utf-8?B?a05ZYjdsZk1yc1BFS0YzNkJLSkhQTW80TXY1cnRVZS9USzdZSmo1RU5sVFlE?=
 =?utf-8?B?ZEtmQ2VLbGZsZEtjT0szQXlsZFl4RmRlbHA5Z3VNR0N6T1lFNnhiOHB2Ti92?=
 =?utf-8?Q?wPz4E1kAIx+MvSXgALKHuZnW6bXJIFfBd0ZFlF5A13J7H?=
X-MS-Exchange-AntiSpam-MessageData-1: be7hgYbYIce1og==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2e3e28-8c4e-4435-b37d-08defc2dca42
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 07:04:33.1213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLodgFTOxu/t0sFaZVjqYIqyPrCatxhzceykskKDRIO0Hl2SqMEmhZnOfZuPdRV1qZhNDIgXZ0JKMndeUoTnXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732
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

Currently, using NonZero constants is quite verbose. It's unfortunate
because it disincentivizes using it in interface boundaries. Introduce a
macro to make it nicer to use.

Link: https://lore.kernel.org/DKO414SNC0B2.248FUBGJGSPLU@kernel.org
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/num.rs | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
index 8532b511384c..055d23ca7fd1 100644
--- a/rust/kernel/num.rs
+++ b/rust/kernel/num.rs
@@ -7,6 +7,29 @@
 pub mod bounded;
 pub use bounded::*;
 
+/// Infallibly creates a [`NonZero`] value from a constant expression.
+///
+/// [`NonZero`]: core::num::NonZero
+///
+/// # Examples
+///
+/// ```
+/// use core::num::NonZero;
+/// use kernel::nz;
+///
+/// let v: NonZero<usize> = nz!(8);
+/// assert_eq!(v.get(), 8);
+///
+/// const N: NonZero<u32> = nz!(0x10);
+/// assert_eq!(N.get(), 0x10);
+/// ```
+#[macro_export]
+macro_rules! nz {
+    ($v:expr) => {
+        const { ::core::num::NonZero::new($v).unwrap() }
+    };
+}
+
 /// Designates unsigned primitive types.
 pub enum Unsigned {}
 

-- 
2.55.0

