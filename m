Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB45FCD0A7
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 04:07:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 623C310E729;
	Wed, 18 Mar 2026 04:07:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="OAqo+1CR";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D69A10E727
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 04:07:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEdc23YUHQM8DTJJHrBWeNii9YeH2d21ech9E5xY8NWDLAEVOrhgv8DfjVCtrDf+NWxgUEnWdZPN5XA+7LzDY+/5QfzflVBQVOSHsH5n/9xWBGKkYc3hP1QCdC3/iUHSiq9WKpSvYP+S0F8xIArkFdHPk4iuul3WQS1/hlODiUgMe0MIgVonCfuUkDgGMtvdUrmkB4n0KIS8GxltF5gBY1hUDta6Iame9DOdxJaU5sV2ki1slHuFwTiL0lQVIhJ2QM8u1NiJcc9n85zHhtmfISX9QDsmHyZfvjITGeyWuSaN/5vqiTqmwrI0703FM+TJV9rgNqIA/bELEGm6e3L/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KED9xjZmKW5Eu+W5R+zqOTx8U5XGYz1w4pDseDYKk0=;
 b=MAAffPAWUABu4UU/HAgW3gxIoJi6NLF4NByHFdZgVZfXwHYThRyS40WtcRcqn9jg94j1CAOmgUPm3qv2WAIyWf4cJvfuqN4l2c5rovsTDk5mwSXVbimpNpUKZ4xK6fuSlg7j519+8mxWa2WPEJdKND0sjS2kcFQlKarVcUw39ddSx31Hb7+Frx7U6ac4mln177YOgqSi0ncE2Fvyql8CWjIZP6CiDDRsAP11wkaMu0Y1k/sGmsNvxZqZO9+252YXmWUEJBEsfuynoSW5dY6nvn3bpKO986abEYTyCdrCLGKvIzZOQLz3rt02K7Ft8dP/xlQU7JnOwaBwBhuHJmUdbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KED9xjZmKW5Eu+W5R+zqOTx8U5XGYz1w4pDseDYKk0=;
 b=OAqo+1CRuI8uCu4NvPpfugXh3GEm6hdvSbALeOoFTNF3edy0Qw6bLqCQBX30CJe2L/s9b7qTkT1Q5/joXizbUO4akuSRuOrZ/p17pYI5AAy4kJCIebQzIS81YbRxkPoZnUA9hRkejzvEa0cQfcxDJDg0LntTXRBYUItKud3FrqCsUeFG0OvN5gb10BmoKvmSVGHss9+yzOO4gogWgH+VwD0XXthlhiXnmnRBVhAL2HNQkMtmWd2BVKGQycdcynAm1HFTtmIZtmw4S/I7tR8hjmaIap+gCfdqJucuTu+jxLZJGvNFkVK8nTOOuJ1DYl4bbASD7MeVPPSEjcehJRbLUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DS4PR12MB9634.namprd12.prod.outlook.com (2603:10b6:8:280::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 04:07:38 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 04:07:38 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 18 Mar 2026 13:07:09 +0900
Subject: [PATCH v5 1/5] gpu: nova-core: gsp: fix stale doc comments on
 command queue methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-cmdq-locking-v5-1-18b37e3f9069@nvidia.com>
References: <20260318-cmdq-locking-v5-0-18b37e3f9069@nvidia.com>
In-Reply-To: <20260318-cmdq-locking-v5-0-18b37e3f9069@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP301CA0053.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::20) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DS4PR12MB9634:EE_
X-MS-Office365-Filtering-Correlation-Id: 569891c0-81a2-46a2-ecfc-08de84a3e498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +NV5Y1JMg/f8Vfllz3wItH7NEFmwHBk9e5cd4Q49GLMUxYsAYxDP1wQD/XBId201sOxcmvAlGs+ExX0WqQlGkE1q+eB2sh2BP1GlhKBBCcmru719jVIfdJj1Vm14ywermXD+BVnLYuuicD/zrthT2ksiJb9jcYJhgb0k2I1ZPyEz7m+uU2IS+mdZUxTsl/sLePLnr+W41szUvK3ODP5W62GCsQrYFYzbU7pi8gcEseEBYa8Aamy6L1TQ+Fbo0/Xxii+gP1i2zMxWaEehkw9qZ4uFDL/hYsttxGusNXQDOBWQ3VyCLap2cdOx68kbGCm+dlqbcDNjJ88Mh5ETfHJILTVTmLlrbKq4d/fIQFo4vFIzWbe+xt5RmDWAtlVmNyyZsHzdV4A2tGX4ZWQxqVVERbxvmcj5xwmAHlf/ayqfHSl45smIRebaXjiw0S5V/ayb6+/JkylAaYxQsj1WEz9dkw6GdH066rwXGejOiYICBtEDCgAA75u1QFP+RmG0mDpU/JIaR+XJCAnH4LXYGofeE7+G9l+FH2kqMi/DN2MxZe0U4zhw7K6dy64KNLrA5QOokV07PLm2uMDnE4FeLQ6jUpy8mawHIfiSwaGpiz3YMEfL/3co0EwsgyfuW59EDLc4jpOf2LDt0w5yKOC6PmklvpuK/8rGXRIqaWRde1xXtvmG4WYgcu60Qrh0ckrsmxmFFCF/W2Xcaxa7HmFbci3TbfXhn0tl3n4Xq1gWWloh9xI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bURNN0FMT0luSTBoUkplK21FbVZ0c0UzYmZjd2hvUE8ycE9nRHp2dFlBYmRp?=
 =?utf-8?B?cEwwN0c2b2hZWjVRd2pBNFpFUTd2SFRsalJwa0Y4TDdiWUVSUnUrVURHalZ1?=
 =?utf-8?B?SDYrTlJaV3dEME9LQzlMV3EzZHVsZmpURXQ3c1R0QTd5RStzODNIQVg5MlVP?=
 =?utf-8?B?eUIzUVNHbmlENisvRXRnNEdYRStrSDc0bmloUVZqOW9jNEZTdStibDRrOVVX?=
 =?utf-8?B?SFlqTW1ZM1pRMXNLbmwwcXNrcUdrZUhBK1FJRUNVaGsyWVpLZGpOVmlrQ0pW?=
 =?utf-8?B?QmJMSHpzSmpZckhSQ0RITTd2Qy9UUllhS2F2bUU1WmQvN1lYMk9FQUlLVlZJ?=
 =?utf-8?B?RWllN3FXVlVTVkNBQ0hNWkxWZW8vMDE1OHkwam5uUEZkSVppVmhGV2V1bkla?=
 =?utf-8?B?M0p3QkI4Tkt5akt1ZmE0bUVJcWh3SkhmZTFSamErVkVVRVFnbGJkdjBXMHQv?=
 =?utf-8?B?MDhYb0FKU3YwTnU4TmxVbHVDQThaUGU5V1g0cWkzL2FwWFZSMFhNVVR2dStm?=
 =?utf-8?B?VWlOUzNXUTBWRE83MFRISWx5UjYxaDYvbENiRVhYUU4xbXJTUERRa3Y3TnFl?=
 =?utf-8?B?MFdiMDVrb01VQTgxM0FVSXd6VEw3S1ZLK1AydW9vRVU1VUhxcVBPU0xGakll?=
 =?utf-8?B?REVNa2RVTGRSWXVTcjVodG1kYnNPYzMrSy9kQUxzcUREeU1pUXkxdWhVMHh4?=
 =?utf-8?B?YUxlOWptRmMwcjRSOGdscm95MldWakRZRGRtZHJpK05NRUFrVzhaNERsZWNW?=
 =?utf-8?B?S0J6V2FiVXVBN0ZHOVNBeE5GNTJjU3lpSEpsaTFtMTFpTDZjUFo3V2FUNEV6?=
 =?utf-8?B?N09pNUZyRksvN1NOWmpFdUxXT0NPYVRwalJ6bVhTU1I4blBJY1RVNXJIbXY0?=
 =?utf-8?B?T21UeE1ZaUNKcXdrSCt1Qk5YY09XV0o0bzRkUENWQlZROThQTXZXYnh2WEda?=
 =?utf-8?B?cS9sU0pnQU9HZzFvOGNsTWcyS1dUVFY1dUZkeUR6Sno3VGhNQVdocTZQWmJw?=
 =?utf-8?B?T1ZvSlErOENmdW5CMDVhd0JMU1NDYnZOU3BRNmROTFNpODZDa2ROQlh0Vmtk?=
 =?utf-8?B?MTl4Z1RDa0dBczc4dVhRZmlvU25nazhIanBPcXpLNGxoM2ZUekFQN0Rzb3By?=
 =?utf-8?B?VTEvbUxUWE1ENStxcCtzTE9HYXNjRC9wR1RSM1NIbDZyY2VyQzZUYTVrNlBK?=
 =?utf-8?B?a2lpTnRUejlXaFpFbkVSNzBNTk5SMllvR2NLT0JzZTlha2cwSDJaQmR1b3B1?=
 =?utf-8?B?VVN5eFcxY24wTEpCNWJ5b3d6R05YaXQ3N0UyUnljQk1sOHU4WWhWZ1UvUjJv?=
 =?utf-8?B?a2lTdjV6RXlVU3hEYVdZV3h0VjFqcmVvWlFCYVFDY0E2ZWdleTlWditvU2dK?=
 =?utf-8?B?TThHdHlGUDBvcW0yUXhrUDRyVmlvNG5zMFI5UUY4VGU4SU9yUlg0VEg3bmp2?=
 =?utf-8?B?cUQ5aFBjb2VhMTBTMlZnOUVieVpBYlprMXJrRi9mcXVYUXk3WGt5TmJlYXNR?=
 =?utf-8?B?SFBtSzAva2F3Rk9WK2cxY21JcmJ2emRZa0ZCTGZib0ZHTmQ0S3IrdEZKZXl2?=
 =?utf-8?B?YWtYcnh4OTcyMWR4K2gySVQ4RnY3ME9RbmhmdlJjNTF6dmRIWWloZ2gxVVp3?=
 =?utf-8?B?UWc1NWF0UVNVZnVoajVOM0I4Qi83RS9iU2NNT1BaMmFGb216ckwxZ01aNkJ1?=
 =?utf-8?B?TDNlUU85WE85NER3ZkMwVlRhdmF4UDRLSytoY0xUVzVnbnFtZ2VrSHVPaXli?=
 =?utf-8?B?OUJwMmhZUUQxcUVWOVFqd2NiMWpPS0IrTi9pTDcrQlZXS09LcElHbU9WY0to?=
 =?utf-8?B?VllJcnFjWnZCRU1nS3pYY2l1UGFETURlc0NJVE5VZVJ6MTl1d1o4OE9iRFJT?=
 =?utf-8?B?NkRVd1pTTVBJeE9hK2g2SDYzUHArc0x4QmtmTzkzYTV5YU9LR2NxdjVBYWJh?=
 =?utf-8?B?MkhZQ3diaS92ck1XeVdscEZ1K29iR2xVcm50amRCZ21CVlVXS0oyYXVGRXhw?=
 =?utf-8?B?Z3YyR3k4RUdlQWl3K0FwVHJGSjFoSkt0WTl6VHdKUVpycHl6Y3JybExzeDJl?=
 =?utf-8?B?YjMvVHJjZFkwbW1iZ1FabVJSdThsSC90RURaS0VPdWwwUHFJWEpxc2FndG1P?=
 =?utf-8?B?cVpZa1pIMXU5VFhvdW1UTkREM0phaHFXNHBVQ0xSckg3QVY4cU9KcnFydStw?=
 =?utf-8?B?L0dwNFUzdko4TEZxUVZMM284YmczUlZ0Y0xndVBNdzZ4YTdHdGpaOURnWFhm?=
 =?utf-8?B?SEI2U0ZYWG5STFliTlEydjBtUzFxQ1g3NmhTV29RWkp6WXRZRDdtSVJ2Z0lI?=
 =?utf-8?B?Mk93OE5ocVlCOHd3WkdIMG9UOEZ1OTFsNFl1Qy9Pby9OVmhkaVpGWjNIcjIy?=
 =?utf-8?Q?hqmYSv0+CxwGmlarGt6YJHO5jHAWZ+8vwDSxz180OUPYN?=
X-MS-Exchange-AntiSpam-MessageData-1: gV1UecTFfBPYFw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 569891c0-81a2-46a2-ecfc-08de84a3e498
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 04:07:38.4027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ff0jj222iVohD91hz7SEmoqrYRCEDY/1wXKOUBG16Uy5RJD3uD1yjm92bjR4XC4FUHoeG7KrZgdLJPozLADIyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9634
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

Fix some inaccuracies / old doc comments.

Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Tested-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index efa1aab1568f..f7ca6856ff35 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -502,6 +502,7 @@ fn notify_gsp(bar: &Bar0) {
     ///
     /// # Errors
     ///
+    /// - `EMSGSIZE` if the command exceeds the maximum queue element size.
     /// - `ETIMEDOUT` if space does not become available within the timeout.
     /// - `EIO` if the variable payload requested by the command has not been entirely
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
@@ -682,22 +683,20 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
 
     /// Receive a message from the GSP.
     ///
-    /// `init` is a closure tasked with processing the message. It receives a reference to the
-    /// message in the message queue, and a [`SBufferIter`] pointing to its variable-length
-    /// payload, if any.
+    /// The expected message type is specified using the `M` generic parameter. If the pending
+    /// message has a different function code, `ERANGE` is returned and the message is consumed.
     ///
-    /// The expected message is specified using the `M` generic parameter. If the pending message
-    /// is different, `EAGAIN` is returned and the unexpected message is dropped.
-    ///
-    /// This design is by no means final, but it is simple and will let us go through GSP
-    /// initialization.
+    /// The read pointer is always advanced past the message, regardless of whether it matched.
     ///
     /// # Errors
     ///
     /// - `ETIMEDOUT` if `timeout` has elapsed before any message becomes available.
     /// - `EIO` if there was some inconsistency (e.g. message shorter than advertised) on the
     ///   message queue.
-    /// - `EINVAL` if the function of the message was unrecognized.
+    /// - `EINVAL` if the function code of the message was not recognized.
+    /// - `ERANGE` if the message had a recognized but non-matching function code.
+    ///
+    /// Error codes returned by [`MessageFromGsp::read`] are propagated as-is.
     pub(crate) fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
     where
         // This allows all error types, including `Infallible`, to be used for `M::InitError`.

-- 
2.53.0

