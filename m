Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61279108B916
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDA1410E570;
	Fri, 20 Mar 2026 12:20:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lHbb/77I";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011036.outbound.protection.outlook.com
 [40.93.194.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5367B10E568
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 12:20:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNOlsY7HEuzCfdUKis2FQsl9qS8guZj8MUjYIj5km5EN3I8KZXMn0y5r50V+PwUUs6J08W/iIn6g/VFG5fLLwfBs8pVcjV5Dd8KTeC9AkUsaAK7IhT8tRGlpjQROjGTbgqsBu5HKtqKlkizra7rIbZYy0E8/aRPEu4HFzEdeMwDVETp9r2Nd2SngMhfh577BpdHypdZl19Y07zp6i2jS9QjtUcqNXHgGOalAERvHBheVEppv78vOqIjFtyb0PWqnWwek5ULT79J1wQsxAlzsrdJw2+B+tamYiY+8WyLJegRMt7AUq/71mnldFnCDvzZp3xxgu8IfEYgg0j6nuVTIGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zy8Tl5WWumcjy/fKTDHJyNnB0pOx3mI3ywbfheuzQeQ=;
 b=OWtFB+316WRTYT5mrw8DeSjLuQIz2/LebDa6aCMwa635jnHWtTFX0GhPP6skoyJlqHWa44k3iSqN0NU4alUX3SFJ8eQeEn88yu2YueGWrQoh37h4wuSjp79JnWZbURfzira+abhfKAEfh3mRewe2WXSTVbql67T0lsPAFKB4SgMRD+L4o9TqgCBdOCNMtC/oSWOajYCbnLcpLfpO2H43qcR+rhSdgt4XvWMQfhKhR08v+hI98Sokg65EuwrFFwk/5DCT8Fyh6kzGkNI/FJsmGSjPOMHCjB7DZVU+DD/epP5EP4W48T/AwKZC/W1nuuwQkmzi8Egv6d6oAj2UWPn2Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zy8Tl5WWumcjy/fKTDHJyNnB0pOx3mI3ywbfheuzQeQ=;
 b=lHbb/77IKTs7Km6IFZfrGsBTQ4NfMCGZJyNYZ9Us0YPNRhBBkYbx4xW/L+ASbzsa4WcUeqMNo27fi41nL3mpYwpwkRD6X3vcpIHPjIgKIyCDJwfjeMmiWssAJ+cppS4Oha6WMow50uF996Zt44Ak8hCh7Cfcg6posqtxTtVMrxM041Zl+rnFKCw6lOILUeorDZtE1sONc2gNpdVqBDVHaen7Zq9agHMnxNU6XzMk6mb2Lh1Y8B9d+dx1JxKlXaW5r9xV/GFEMhvzg+US7MyLNOi8MyipbHMHsRoY6eG7u4SP02766u95L8TDlBV4OD0IpypCXkjepeKHVVrgJYQZjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.13; Fri, 20 Mar 2026 12:20:36 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 12:20:35 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 20 Mar 2026 21:19:59 +0900
Subject: [PATCH v2 10/10] Documentation: nova: remove register abstraction task
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-nova-register-v2-10-88fcf103e8d4@nvidia.com>
References: <20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com>
In-Reply-To: <20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0092.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f47b4e4-3261-487c-8430-08de867b16d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|10070799003|366016|22082099003|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info: v1cWkccDRxvLmiMOlrI2mw57M3NYUH4Z/xMao9KXw1iIplNtpzJ5SyHaN+QOrUp42KQh7QJJ4TCMQrTuO1WBUxHHuRfBAwLWJVBAmOXj2cuQwWFUKIyG0WcU/+G017gq5HvR2q7eNv9IEfv2AP9iQPmsC0CGTJQfkY2bPqDt/AzgOSPQvNZwvxDJ4aWLMj7HuD3AVpco2815nir/fw4HCQgDBFxQ8qF09QlOhYXFqmx/AUNch650KSWqU5YwkJjMeXXXSD/a0DkSSzuEOJqATEU36WFzeS9QyXHhxJE8mqCA2YrCNEqYBYO6nEnIosNuoVInIDC7RiWpymm7Td3wOH7F+TaHTPZ0bdF/2QLX991bM9SmzAcGmzaMQlxMaid/JVn6KpBtlt451HUGp03cEGfJo6KOC9HtugG4S9FZ1CRalFS+J0wYfkusidqA4rVxa5bbghnFjMRbq4/tAgjqiRpBC1d3rExpUrmZV7vwqcJMgw8sXhj+T19PG8wtB8gvU3Yx/VyLRMyooyZEaUGIlDhYW2ZrZtl6OpFOUlW3UVjTEkk2C8Kw+A+xIfskLhJcy6TBLz/fBc8QtKa78U6dc0N9ezG31jd31fiqRqWkqjg04uE+jYd34jDXRycDiLFDgQY3iB1ZawM8DCd/6ERCzpP4JvpNYoPzNRCZdbTMca5dAYZoLLl3Ko8BHVmRnlcHLSLZfhVJ6sSb1y+0ue0iD3WwSYbUoCgm8g3J8bePipZ0lQcY3JcwaSpzcKLSqFprMWjsO0OBl5nxyZwuubSxyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(22082099003)(18002099003)(56012099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3ZRcEJDS054Tmt0NnF2eFM0TDJ6NFNFeFBRTUxoSFdFa2xFdkpjc1VlM0wx?=
 =?utf-8?B?WDJjQ2trVmttU3lVVlVCVjlvdFpLMnNZc2NlSC81MkpjZGwwK0dqRVFja09j?=
 =?utf-8?B?S0owWlZxQllRSjM5MDZoWFh4YTZKYk9hSkxBck5BVmkrajIwZldHS0hvT0x1?=
 =?utf-8?B?RHp6NnFTY1J3ckljcjZXTDdwWFlPdjc0L1A2Sjc4QnFRNHVpMlEzU0JrWjUr?=
 =?utf-8?B?Sk55Mm9FODFxZUpJWVNkSmRZUkxOSWxndXNGeW43dlVUV295dW56ZUdEakRJ?=
 =?utf-8?B?QVQ0NE1Fc1Z0YzFQMGhGT1RYN2FTb29PWDJDdHYyZDdxWDRsTWVLWGRac3dB?=
 =?utf-8?B?d3p2ck1CVnh4aFdHVVNGSDJCTlU5S3BHeTZkK2lmTHV1Q0l2amRPdE5WZXhF?=
 =?utf-8?B?WEk2T25aQkErU0tTa1o2RHNLNFhVZkV6MEdGOHorMm9GdUlqUGVGbE9tVkhl?=
 =?utf-8?B?UG80NStBa2M5cC9WMW1ieVo0STZlUDZzb3lUdHBDQ1FwWXZ6bVZtVzhEUDhY?=
 =?utf-8?B?d2dsYWdMYldZdFd0SnpqbzRwVG9NZW5yUFNwRXptSGt3VG5saVQvV3dCNUlE?=
 =?utf-8?B?UmVoUmttdWNlai9vVTAwbTBtUnhBeDM4c0FMMnV2UE9ja0U5dEs2VERDODR1?=
 =?utf-8?B?d1hibHQvYmFiakFvdEJjNldnVHNaRzduQnJmMzRqZVpPaU9TYWZud2c3K29o?=
 =?utf-8?B?d0c3R3d3cHBUdzlJRHEzaXpCMmx2TjFNSmZkbkRFem4wcWV2YmJzSDJNbU53?=
 =?utf-8?B?UW9hSmdoQ0xXNFY0NW43YXZIYkg5amJJNnZLSGN5NW03ZG5sZ2JRb0p4dkVY?=
 =?utf-8?B?K0haYlRVaDZRazhqbHBQaVBick9xcVNBZmRXclAyUTFodXRqL2VHZE5FUnVw?=
 =?utf-8?B?MUdNb1RyTVNpSWJpamtob0tJK3pISTJTS3N6S0hncW9oL3ozaGFOZUdyS0hN?=
 =?utf-8?B?VTZHRFZPeTMxRDhPNGlwbVpLLzZyZW5UQUdZaDZIbG9wN0xpeFdjYkJsQ0ZL?=
 =?utf-8?B?amswZGtFaHhUcnUwM3dheXUxMzZVVzRLTWdFVFVKblJydnZBcjU1bS9XN1hx?=
 =?utf-8?B?NXRMcGxRRDBSYlluYVNpOWkyMzN0cHBTZ2Nta0JDTnlwSjZzM3A1SnhYV2ww?=
 =?utf-8?B?S3RpM21UcGxXVGRwVVhCUjVuU2V5OTRQUVU5cGN0UUZ2VDRJYWxrRUhHMHpR?=
 =?utf-8?B?LzlFd2dZUlc0ajZXZ3FFK1IycWZBNzhRY25FWDdzelZjZ2pFMTc3VUZnT1E1?=
 =?utf-8?B?TVF0WnowbjhyWjJWTFUxa1p5bC9GaGxIdlVPSmZONDBlMjRFeWxVWWJTYzM5?=
 =?utf-8?B?czQxYlRvRmNxMlJKYVI5Y21oaGVyVHI4UEJYZUhWdWFIdC9QdnFLT3ZMck1m?=
 =?utf-8?B?SzRBVFNQWFZKRnJyaWJ4dC9oNHlWMm9URHdGUGtKRjhXLy9YNWFNMkdBWUlZ?=
 =?utf-8?B?S000WXFKbnZ0ejl6S3cvQVp3Q0JHVHE5VmVmVmxiRnlrcTZjTlpHaHR0cWFi?=
 =?utf-8?B?REphMUFEQlFhSngyUkM4SHpOdjFsMjZ5bUI3bUYxLzFPYWJSY0s1Sk9UTE0y?=
 =?utf-8?B?d0FvT1V4eUtqSDF5VjBNbytZR1pQUW5tNm1GaFdGRkdIbFFpcFJqRmJBTW9W?=
 =?utf-8?B?V1FsVGxuUDMra3o2dWk4WkhqSHFqWFdQZUlLUG9KcUpRMUVaeWNIVnBJUSty?=
 =?utf-8?B?Z2dCcDIva0xaM0J2dXdEV0VCZ2s3YTB2cXMzSE4zUFBVbDJhbWJENEh2c1Y4?=
 =?utf-8?B?b1pGakNlR3ZhZmExanhrQUN4S1JzSGY1ZmNOc3BkSzhDK2NvczZ1bFphV0c1?=
 =?utf-8?B?TDV0RXFhdzlRSkRMelZmT1NjWEswcEFhZDhWRWRxNUxLNGJBT2pQRU1tVHBi?=
 =?utf-8?B?QmVNTllubndlQzlJNDhmdFJWbDZLck9BZEVnRU80NmFwN21sbHl0RXowWGRi?=
 =?utf-8?B?THlzV0dkSUl6YWMxSWxBWUlFcTlaUVIyQ1VMVHBLVW83UTZmbFpLVlNpSnlE?=
 =?utf-8?B?Y3lOaGJkNzBoWDRXcFAxRGhzek9lNk0zVlpnb3hGYU9zUURZdUdIZGFoSjRl?=
 =?utf-8?B?T3V6czdzaHNBUyt1ZEhRWHBmQmphc09NcU1mVDhLeXdqaFg4NDhuSWNDL3Rj?=
 =?utf-8?B?ZE9iUEsyKzFZUytzOTYwc2k0QXNCZ3A2TndscXJ0SUdLSERLenZ1ZzljT3RO?=
 =?utf-8?B?UHNOWUo1bDdpZTNTUzhVcWNRbzhPbWtrNm80Rmd3VkVtVlVNZjRSVVVvNjV3?=
 =?utf-8?B?eUhGUmZHRnBPQ0IyL08zeUxna21TTHpmZ3kycjFhL1FPN2tMODJjd2ttUkx5?=
 =?utf-8?B?NldVWDJGQm5sbXdHSlJxNHRJNno4TFZNcjBPZ3FtekloL0s5TFdDTnord2Zm?=
 =?utf-8?Q?61z/DJw94249f9WoCoDArz67a44V6BPACDVTby0km1ISI?=
X-MS-Exchange-AntiSpam-MessageData-1: 4wnijD4eCR0FsQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f47b4e4-3261-487c-8430-08de867b16d2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 12:20:35.7602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjFCxtapEWrCtxdGvbUKq31JgMURW5g2mmvfOP+OY5vjEb1BAltbnvjcdKeOskDlxXcDwEppz9bC8mSOVuxCkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119
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

The `register!` macro has been implemented and all nova-core code
converted to use it. Remove the corresponding task in todo.rst.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 Documentation/gpu/nova/core/todo.rst | 76 ------------------------------------
 1 file changed, 76 deletions(-)

diff --git a/Documentation/gpu/nova/core/todo.rst b/Documentation/gpu/nova/core/todo.rst
index d1964eb645e2..d5130b2b08fb 100644
--- a/Documentation/gpu/nova/core/todo.rst
+++ b/Documentation/gpu/nova/core/todo.rst
@@ -51,82 +51,6 @@ There also have been considerations of ToPrimitive [2].
 | Link: https://lore.kernel.org/all/cover.1750689857.git.y.j3ms.n@gmail.com/ [1]
 | Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/Implement.20.60FromPrimitive.60.20trait.20.2B.20derive.20macro.20for.20nova-core/with/541971854 [2]
 
-Generic register abstraction [REGA]
------------------------------------
-
-Work out how register constants and structures can be automatically generated
-through generalized macros.
-
-Example:
-
-.. code-block:: rust
-
-	register!(BOOT0, 0x0, u32, pci::Bar<SIZE>, Fields [
-	   MINOR_REVISION(3:0, RO),
-	   MAJOR_REVISION(7:4, RO),
-	   REVISION(7:0, RO), // Virtual register combining major and minor rev.
-	])
-
-This could expand to something like:
-
-.. code-block:: rust
-
-	const BOOT0_OFFSET: usize = 0x00000000;
-	const BOOT0_MINOR_REVISION_SHIFT: u8 = 0;
-	const BOOT0_MINOR_REVISION_MASK: u32 = 0x0000000f;
-	const BOOT0_MAJOR_REVISION_SHIFT: u8 = 4;
-	const BOOT0_MAJOR_REVISION_MASK: u32 = 0x000000f0;
-	const BOOT0_REVISION_SHIFT: u8 = BOOT0_MINOR_REVISION_SHIFT;
-	const BOOT0_REVISION_MASK: u32 = BOOT0_MINOR_REVISION_MASK | BOOT0_MAJOR_REVISION_MASK;
-
-	struct Boot0(u32);
-
-	impl Boot0 {
-	   #[inline]
-	   fn read(bar: &RevocableGuard<'_, pci::Bar<SIZE>>) -> Self {
-	      Self(bar.readl(BOOT0_OFFSET))
-	   }
-
-	   #[inline]
-	   fn minor_revision(&self) -> u32 {
-	      (self.0 & BOOT0_MINOR_REVISION_MASK) >> BOOT0_MINOR_REVISION_SHIFT
-	   }
-
-	   #[inline]
-	   fn major_revision(&self) -> u32 {
-	      (self.0 & BOOT0_MAJOR_REVISION_MASK) >> BOOT0_MAJOR_REVISION_SHIFT
-	   }
-
-	   #[inline]
-	   fn revision(&self) -> u32 {
-	      (self.0 & BOOT0_REVISION_MASK) >> BOOT0_REVISION_SHIFT
-	   }
-	}
-
-Usage:
-
-.. code-block:: rust
-
-	let bar = bar.try_access().ok_or(ENXIO)?;
-
-	let boot0 = Boot0::read(&bar);
-	pr_info!("Revision: {}\n", boot0.revision());
-
-A work-in-progress implementation currently resides in
-`drivers/gpu/nova-core/regs/macros.rs` and is used in nova-core. It would be
-nice to improve it (possibly using proc macros) and move it to the `kernel`
-crate so it can be used by other components as well.
-
-Features desired before this happens:
-
-* Make I/O optional I/O (for field values that are not registers),
-* Support other sizes than `u32`,
-* Allow visibility control for registers and individual fields,
-* Use Rust slice syntax to express fields ranges.
-
-| Complexity: Advanced
-| Contact: Alexandre Courbot
-
 Numerical operations [NUMM]
 ---------------------------
 

-- 
2.53.0

