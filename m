Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2DECA5FA3
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2DE910E8C4;
	Mon, 28 Sep 2026 08:43:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="sl7oV/f0";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B23110E8AB
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anX8hgKC9Zhoqs7exqJuTaJ9OzpjVXVi4c0ajX+MZEnUph8CcFHJRHQroWZWZOk6sonTbuQn2Xi98a84CfXHOCsY1GU+8rPVFznZRMUXo2/rwBDR3maTH10xzw6TtOORmVtgfHOuMEjsOxAoaZFlhxvetI8BMbBnxEQjVfsSbMLJ9y2mUpXiFAKa+gUMXJxJRBYfm+oUPsOOe6oXqFtZtn8pEDLvMzTnBhbKvAhxSW6YcYyK0QXCnZS6xQ052bOWhoGGV1s3ShzmWBh0Khyc9YcKsfjxHRndDqMXEh5M4HBgp2nsFj2i7vrl9S3ObJRsngY1HpPNt+tqUbEXjJe/fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9Yvk3D6HPkxAyIo+4hQijtWiGKhgZFPeVgxWNDXIFw=;
 b=aOTFVhqUIq7nv9P28sJuY8rtD5ZQJI/A69ZJgV7PFN5CnDeh4QYtRE1y3OT7Qew8QSv5FUw6WCfkOpMr/dp5oCLBcXLM7X15Au0kv2At4GO7N83A94LXZcxe6RzEgjgtFp2y3mqr2iO5k8cPtlXJb+mw3mLyOrCNfhbzZF+VUeNvStwfdDFo/MAbfOPI4pcyyeg/dSmnOCQs+mXkc96tt42ptyheTOpodnpqf9pqpF5IbhXvbnu4IJBS8Fal9dojdPbuHMKM6pKTxOXs1IvBhr/TwUcx4q5ofIBRU2KFq1gVTsgkGHfN/uN/yhcTeePf/S794EhXHf3CVUgTgGS5yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9Yvk3D6HPkxAyIo+4hQijtWiGKhgZFPeVgxWNDXIFw=;
 b=sl7oV/f0ijqJDpdK+Gu1ei3T68laftx+n8+z+b23T3KgElr03iTuGQq3adx5c605Y9p9uUE1P0vzFIZG3Z7nLwViCZi3WnJgPXBET+BvrAHkrQ0WuqRnHJ4VO0KkugDsYC+QXKjcLZPvtpcaTD+sahcNXlzCF3LS2qEcA+iTvQxceEL0kubijAifVYqnDFU/n7rihqlNBLdnepXCLVorQDCHLFFE9URbOQXyxYdZINMsgzsSefBwIB+pfLpGqUZqQVD+GzCMHw7F1Yv4LbQQ62YTOAR5UV01vugm/MegjmSdN6WE2qQCmgcq538RTiv62e3AeQ+ahvszNj8tubU2PA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Mon, 28 Sep 2026 08:43:02 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 08:43:02 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 28 Sep 2026 17:42:40 +0900
Subject: [PATCH v3 1/8] rust: alloc: add Vec::try_push_init
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-b4-nvkv-v3-1-f04504c262c2@nvidia.com>
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
In-Reply-To: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY6P301CA0030.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3ba::17) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 67cfda10-a8f9-485c-e0c9-08df1d3c81a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|376014|1800799024|366016|10067099003|56012099006|11063799006|921020|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uhGE7ORx63doXQrsLd2bu1qJ9fkni/BicOv+rr08sB0g6Hobmoy6/UHExSkhTokt/P9xHr5vgBZjkPxsziqvrCexbw3jvS2W35d0RYl6hLhB1BTvwhgSQxTGEpuJSZb5YS+eyOanzrxFuWK5RtId6U+Tu3+ly/81lU1qnKl43dzDlYZ4LjTEpn1JOCMG3ifMjCT5ExodVBY6cdoaJvh1sywuvNmSCf9ABRoHsFWsDOM5wSvEelLyeAPokynsBEAwgfROCOqPGe+7iIs0gADaJVEHBG0eymxcVHOwXKmteT55ndamG20mtHCTAVU9GNhr9SkrIPCIfcndrexqBcXBEoMPFzNbd2UDs/7GobcN+BDEBEh+p+yCOYvS1hHxkha4ZmzzNDKO+ogvG7YMaKR5VS/2/5Hz795Mn7xB4CjP9SqYZQ0ERTkWFNhOEFCKKsXPyDQgLBfYnDESIplns5EgeOlRBjtqyiWIqiatgMiaxmCJrlsbDNNlmtYGF87kTDqcAfLjBlwMvKd1eYHqwjXUH8YQfBJ+yDYm/MzDaBzjpbeks6nkKqytJoGQCP3crLALkVFbP5H6uJxCDcVoLRxIlqLOymPDmLxR+GGes/gtvkPSGriq9uYmLTTRpOF6kW5T8/GPmgmqFKi3CL78mQ8SrVYEKpL7ev+SjujbPvmIlZOfkwLhhVc8Khs9WJVoiBnJagpu4BAJ70bPI7XdSntO3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(921020)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDNlODB5U3lXa1dxV3lmWjdHWUNLcFBzQ0JzNVhEaCtTVmdBSTVpaVNISW5a?=
 =?utf-8?B?YkUwcUwrRWNyL3B0U0dmNUFKcFF1TnBqVHQ3dDJTWUU5NGgyK25Fak5yQ2t5?=
 =?utf-8?B?ZG9WSHV1YmVpWDFvcmg1RGlxMXIxZk9zdkNrNGVtd0hTWEFCYjA4a00rSXdM?=
 =?utf-8?B?bVN4cTdyU1U5dk9yc25iNS9weU1vVzNYMjdxOFExUk14VWtrVDlyZ00wYTM5?=
 =?utf-8?B?d0NITUhQeE5COHJGczdVcndQWmNiNkRMeHNmRytBazZtSE1oNXJ5aXJ1TWlu?=
 =?utf-8?B?dzUwZHRzNEtVaHBWamZtY0E2VkxIdGJLM21wRmVGRy9JMjBzc1JIWHJhdEx6?=
 =?utf-8?B?eDU4UGxVVkNESlB1TE92VlNSK2dwSEd2b2hMMVJjS3pVZ3lZa1ZRQWNyR0lj?=
 =?utf-8?B?WUpHL3VkcnNlUmZGQVRLNjhKMHh1c010L2lMNUNYTG4zM0twQjFCVkdaamEv?=
 =?utf-8?B?S21aNmNOZ3A1SUUxcVUwWi9kS3htQ3d3S1NIbkYvQjljQXk4cTZxSEZTbHUy?=
 =?utf-8?B?dEx0a2FsaDdwNGtKSEV4RlN4UUxuYm5ZSDFNK1dDYUhGZ2lhNlN4eDRxSkZW?=
 =?utf-8?B?eWJaNC83eEtGRUI5SXZZOW1Ock9HQWhNdlNWSHVmdzRhMCtRUG1WMkMwbUZ1?=
 =?utf-8?B?bVZMQlk4K1RwQzVWcEg3a2F0em1WNUR1eDN0ZFI1RlpWT0x0cnRpSms3aW9o?=
 =?utf-8?B?bzA4SnFNZDhMVWVyb2lKZGREOUN5d3AvME5ocGxuS3JVNmZPTzV0Vy9IT2dV?=
 =?utf-8?B?SUVDR2JOTThNcmdPODhOTGh2enVPemlmTWpCT3V2ZlNvYW5OWk02SlRKOE0x?=
 =?utf-8?B?UVExcTBNeFBSUFV0eUZyZ002aTUzWWxTOCszU0pFSzh3WXU1MUJnY2NDdVBJ?=
 =?utf-8?B?alJFSVcwVkQ0UkVZYlBET3o1eHF6YkEzdER1RmVMeGtiQ3h4d1lEZlQ3NUdO?=
 =?utf-8?B?TVVCSm11blBKeGdPOFdyR2pNVllVSi92OFo3SmVoYVpNTFo1N3BaVkloZjNW?=
 =?utf-8?B?czFueUFUanBCZFNnbUdvL1BsS3pFL2txdDZjd2tMWjJDNnNpUXY0Y0dxcHhX?=
 =?utf-8?B?ejJDMXplaVk0NlZMU2FOd3JwRkxQQWdVSWVwYUkzWElHYVc0MEFQTmdwcHA5?=
 =?utf-8?B?NG84YURiTDNqT2prL2l3bytDY1pJOHA5dFFDSlV5K1M2MTFWeXkvamxBalJZ?=
 =?utf-8?B?bnJvSzRlZ0JFR0Ftb1JsanM4UzJqQTNaeXFhMStSV3dXNnNqZ2NnNko4OEl0?=
 =?utf-8?B?Umk1dTdYdlRCMHVMK1lYSmJsclVUK3JXaW0wUVhreDJPYk4wcUpnRS9uNlF1?=
 =?utf-8?B?WWRydHJ5aFBhcW9XZVc5VXR0QS9tQUY3UmF5SjVpZXlQaHl3Qk1GTEt5aHN3?=
 =?utf-8?B?NDl2NEZ2dVduYlZHYXVQV3I1Mk5NR3BWN0ZaVzg0RUtjV0dqYUpBYTRQaUU0?=
 =?utf-8?B?amxuWUI3MFRxcXgzWnJzTThyamxDWE9TY3FGaVhZNWxKRXFOQ0txeFVkNllu?=
 =?utf-8?B?bDJrYmRLdEtvK1o2dS9HZFh6N1IzSGNKa1MrN05BNVZxaitPTWFyL0J5M2d0?=
 =?utf-8?B?ak1COThCSmZOZ01GOWd5OHZoRTc5WXdNQ1J3QkZRMXArWWJ4OURNTHZPOU9l?=
 =?utf-8?B?SlR2cVAvcUdZWGM2RTArbzdkQStFU0xERmVWc21BclFnTnhDMFdmTkFXMFF2?=
 =?utf-8?B?eVdDMUhYZ1RSSC8zcGFCMWVaUDNsQXZTMGs4bVRjQ21CV0dZMWdyT2pHSmNG?=
 =?utf-8?B?U1k1L1pTZEVHanh6N1EwY2RSNGZuSTYvbGJPNnhJNHFBSi9SQ0R5TUswd2k3?=
 =?utf-8?B?RVhzTzU4QWJGQ3FiNzhmNjFsRHo3aThHRkJYazEwbzc4elM0TDl5cXRIQUhk?=
 =?utf-8?B?QVdhRm96cDgrdkJIWkV6OWp3MGRmbFlRRElhQVJycUxITlJGSXVQbldNMmJp?=
 =?utf-8?B?bWtQNjFDMDdUS0xhL3pMcjlMVXczOUZ4SnpBdWNnenFwK3FsRzAveHZLSG1z?=
 =?utf-8?B?RUQ0U05EWGlycVg1SEFKcEhwcUxndHZySmlHTUh5MWpXcFdwS1hwYTViSEsv?=
 =?utf-8?B?c0dHeGFvQWh6RFIvV0gvQnZFK1Fmc1VBbmZoQVpTUWNBS0lTMmtBVlJERmY4?=
 =?utf-8?B?RTgvS1gxMXE2dnp5VTBRb1NZazVUVnpnRmZpbTZxMmJLVWtsM0VWZkJoaFlj?=
 =?utf-8?B?NlZhWkhlMkhtT2lZTGg4cXRRT2MzbXlxQ0E5dlhYM1ZpN0NDNGtwNzQ2UXph?=
 =?utf-8?B?a0VWQjBLMy9GUFBtTk00dHQ0aDZvQXdlQ251MWNJNVhXeE0zYmpPbHMzdTIw?=
 =?utf-8?B?Rzg3V09NcWsxd3BjSWZRRWNLT2hNWlEzSXVWWlc3TFUyVEN3RWxMS2U5WXBI?=
 =?utf-8?Q?h98fHXm0oWvLJbCnx1D5Hb5uH3MTKnpzX9NDLxG7gsbwW?=
X-MS-Exchange-AntiSpam-MessageData-1: cH4xLo9lKEOLKQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cfda10-a8f9-485c-e0c9-08df1d3c81a0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 08:43:02.2784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ofj0hN7OQvSkyO71ivbihAU+TYilwJN6iTpDjGEo6LL9qYxx5ixAMZd6dDsxCmILv7fR0rMLAdt+YivIh1vQ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065
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

Add `Vec::try_push_init` for fallible initializers (`impl Init<T, E>`)
and a new sum error type `PushInitError<I, E>` that it returns. If
allocation fails, it hands back the original initializer. A From impl
for `Error` lets callers decay the `PushInitError<I, E>` to a regular
Error if they want.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/alloc/kvec.rs        | 55 ++++++++++++++++++++++++++++++++++++++--
 rust/kernel/alloc/kvec/errors.rs | 30 ++++++++++++++++++++++
 2 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index c7546b9da4fa..a2b72a7779d9 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -52,10 +52,18 @@
     }, //
 };
 
-use pin_init::Zeroable;
+use pin_init::{
+    Init,
+    Zeroable, //
+};
 
 mod errors;
-pub use self::errors::{InsertError, PushError, RemoveError};
+pub use self::errors::{
+    InsertError,
+    PushError,
+    PushInitError,
+    RemoveError, //
+};
 
 /// Create a [`KVec`] containing the arguments.
 ///
@@ -359,6 +367,49 @@ pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
         Ok(())
     }
 
+    /// Appends an element to the back of the [`Vec`] instance by initializing it in place.
+    ///
+    /// Unlike [`Vec::push`], the initializer may be fallible. If the allocation fails, the
+    /// original initializer `init` is handed back in [`PushInitError::AllocError`]. If the
+    /// initializer itself fails, its error is returned in [`PushInitError::InitError`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// struct Element {
+    ///     buf: KVec<u8>,
+    /// }
+    ///
+    /// impl Element {
+    ///     fn new() -> impl Init<Self, Error> {
+    ///         try_init!(Element {
+    ///             buf: KVec::with_capacity(16, GFP_KERNEL)?,
+    ///         }? Error)
+    ///     }
+    /// }
+    ///
+    /// let mut v: KVec<Element> = KVec::new();
+    /// v.try_push_init(Element::new(), GFP_KERNEL)?;
+    /// assert!(v[0].buf.is_empty());
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn try_push_init<I, E>(&mut self, init: I, flags: Flags) -> Result<(), PushInitError<I, E>>
+    where
+        I: Init<T, E>,
+    {
+        if self.reserve(1, flags).is_err() {
+            return Err(PushInitError::AllocError(init));
+        }
+        // SAFETY: The call to `reserve` was successful, so there is at least one spare slot.
+        unsafe { init.__init(self.spare_capacity_mut().as_mut_ptr().cast::<T>()) }
+            .map_err(PushInitError::InitError)?;
+        // SAFETY: The call to `__init` returned `Ok`, so the first spare slot now holds an
+        // initialized `T`. The new length does not exceed the capacity because `reserve` ensured
+        // the capacity is greater than the length by at least one.
+        unsafe { self.inc_len(1) };
+        Ok(())
+    }
+
     /// Appends an element to the back of the [`Vec`] instance without reallocating.
     ///
     /// Fails if the vector does not have capacity for the new element.
diff --git a/rust/kernel/alloc/kvec/errors.rs b/rust/kernel/alloc/kvec/errors.rs
index aaca6446516a..4e4be9a46d83 100644
--- a/rust/kernel/alloc/kvec/errors.rs
+++ b/rust/kernel/alloc/kvec/errors.rs
@@ -25,6 +25,36 @@ fn from(_: PushError<T>) -> Error {
     }
 }
 
+/// Error type for [`Vec::try_push_init`].
+pub enum PushInitError<I, E> {
+    /// The allocation failed. Hand the initializer back.
+    AllocError(I),
+    /// The initializer failed.
+    InitError(E),
+}
+
+impl<I, E> fmt::Debug for PushInitError<I, E> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        match self {
+            PushInitError::AllocError(_) => write!(f, "Failed to allocate"),
+            PushInitError::InitError(_) => write!(f, "Initializer failed"),
+        }
+    }
+}
+
+impl<I, E> From<PushInitError<I, E>> for Error
+where
+    Error: From<E>,
+{
+    #[inline]
+    fn from(e: PushInitError<I, E>) -> Error {
+        match e {
+            PushInitError::AllocError(_) => ENOMEM,
+            PushInitError::InitError(e) => Error::from(e),
+        }
+    }
+}
+
 /// Error type for [`Vec::remove`].
 pub struct RemoveError;
 

-- 
2.55.0

