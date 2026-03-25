Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8859103A9A1
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26A7910E6BF;
	Wed, 25 Mar 2026 02:47:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZId/ri3q";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADBAF10E6BF
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:47:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y727Yu0jTcWL7EK4Z2hMGlydgcmmsgu8HqwSD1X38z+U72Mt9COgZ0dZv0+jkT+Lr7atF3wd0ZxwXVMd2QtwKMCO0NMpjiMu6oSZR34VvUpV/vLTEBgQ6R3PnYucUparjgCd8VXeVTcvdcJXQnCAh2pC1nE7DwT3QSxDpB2/jrzdiucLxIB7iN2P3rJStuQJYVVio79+JS7YdNKsYq9c5/kZBeeeOh7a7oiiGQ3NJKCB7/X1IkPgtHgyTdZecy6x68LmAPywatxDp0V4s35El/q+28g35OYT6AbYDC9HQxxtuhwW1suJICT550F5FBdjehdL1K2fbZkvDeLOcsBwuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkVb9wLuGv9aaNw86P5lsYZiaY+jTqvs0UIA7x2iLeM=;
 b=rL7UGmAesF2d92VyWkTEhwM1kTg+aOoXKa+EGkg4TTFoszTYFkhT78r4YcQ7DS/avLkGbHL3WaKp+Mh9+LnOSKb3s7HqYqEBYq49dyyYXY8Ul9YgLyG2sz5a6Zt8nDkNQcqai5aSCnbRM2nRWBrVXVwmyV0KCat/Lb5vS27/ldVI61uP7pPghZnFXDp/mNLcAz2yzJ9/nyIQY+b1oAHYRJ9gEUYG7JYiqvgydcgsLAeWZOAKb2sulNO6kICzAf7wzzT2a0EvP54apv3mMVIOmAiSq2uxKa+OvkgzNvkjx57h21kDtXsFqN2i9OVI4eTR8yijzkw0sxbCuu8yI29cJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkVb9wLuGv9aaNw86P5lsYZiaY+jTqvs0UIA7x2iLeM=;
 b=ZId/ri3qlmEXtWbja1SpFVLQ8qlkcPn9rLxGBchtIGwc3Ir/P7PmiqeN1Cv0SbJnwbaQCy8yNeY3UaRi164y7NJnpLIocwNPKPubNntOnij2wJ6zKpoQ5dwgYisSYk8yUH5LTSGEyhbq6P6/vg0Hk5EGSNghg5bKZbsiO2u/0LS9ExHfLTWTATpXEr7m+LRAIfyXhAX1/9CjXsjZ0MnY3nQNDF1xb88R9FWOrWighIePvxwUNRbtQ1t7HkZREBxXg4JviOSdTSb/IH7NtycRgH/LYoNSOEQuPlGUyVRgGHYyIJpV19X5GiZHArARyYhDBwInnhR1jSCgpAm0Rqw2jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 02:47:13 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Wed, 25 Mar 2026
 02:47:13 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 25 Mar 2026 11:46:23 +0900
Subject: [PATCH v4 10/10] Documentation: nova: remove register abstraction task
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-b4-nova-register-v4-10-bdf172f0f6ca@nvidia.com>
References: <20260325-b4-nova-register-v4-0-bdf172f0f6ca@nvidia.com>
In-Reply-To: <20260325-b4-nova-register-v4-0-bdf172f0f6ca@nvidia.com>
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
X-Mailer: b4 0.15.0
X-ClientProxiedBy: TYCP286CA0006.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ad18dc-86b0-4bd5-7b93-08de8a18d17f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|10070799003|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: p3Laq2BQ5v6nD38JjS+zqJvehDuisTKmXx9oB6kZ1SpV2gO89J1hDYh6YLPAJ6MirXq3nVUqYXzmK7lDbghrxtzy+TKadnwYkXyk986VVCgIndu4Yf5cm82hXT6Rp/x68Nc/qHUjAiO4MhoJ9YRpebeIg+lwrRm7Kr811HjPyRMBruec+crNjSJy/RhrjfZ5I8qdsnbVvdP9g/z1Ohm10uS22lZidaPrbX583k1wh2BoC7/abKIEYsQowyj6wOLWKqnj53mSrQzEZuKu4SbNP8phu0MIVBfUn0BqzAr7xiUD3AxoCXj66UHbGmEORn++IdILH7ddN1apjGmthfqueA2wYtyb+3IKc0KHQytMhqfTvI0uR/MWDhaJioEVmQkybnOT3dh3uyfVtX9N/YWnHpKrJg1fnkzC/ErnSC1jIkZgdE6LPp225FNQ+ULzMwhD/vLdHmPV1QuBIjxbnPTp/o2laHHFvu6H1CE4VWhRPWqCTntNscU1Fuot5y4NVb5uaAWP07JO/o4rZvkl9rB1AbqMipw6WJ3i58LZLTMIXEGBWk06xfjX8dbKyQ6xPB3P1if52nsrnJmbTMM2H6yv8XLIeKJ3lvQstjmqIGKElGxbQ/FVLPRVmFXtFRlume/zeEwsyC4jcMrsdl1RlhdGgz8PgtSVhFUyz3r50K19mv4Zdnh/p4jcyMgRVtQMz5esI7u4POJXtuWrU2E6jVTetsPI5kk+SPKH9RSqQWVluELD2BSlJoi1or5XH2zqcQquO4NqSAq5Y4Bd9i4/rQurQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(10070799003)(366016)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlRKay82TkFJc2c4TDFvRU41dWlLRjl0V0xCdHAwakFWMXJLQ3hub3dxNWJp?=
 =?utf-8?B?SDhjVXRBejFaek1MS2M2ejJSbVRTb05qM09SSERDMk5YVXkzS2RIL2JlUExr?=
 =?utf-8?B?dnNsMnJ3VCt5U3JSd21XMGRtR1JKTHd3UE5RTXViUXR3NVB3QUQwQU1JSUpJ?=
 =?utf-8?B?eHprMXFiZ1VuMk1LZlRKOEEvVVdoa01VTUZOVzJmRmtoNGxKdE9GOXpabzlL?=
 =?utf-8?B?K0hJeEJtSmlYdzZ2bEMreGhrNkY5NFlCamJhOXVwd2VCYTVvVUtZSkxkY3Q5?=
 =?utf-8?B?ck9MRjhpSk16WnMreDVWWkxLTlVmQ2YrdU54Q3NMZDUwdjZsNlJybk10aVhY?=
 =?utf-8?B?SmtnczJVRGVrYlZ3aXJqbjJGbE9Gb1FxcHRjZi9tZ0U4SXFLZGZXcUpvR3ox?=
 =?utf-8?B?ZXVla0xDMzhKM0NVZVBCeDZ2ZUgwY0t4WDRrMGFEZkpieVo0V3pTL3ZUNTVu?=
 =?utf-8?B?WTIySEdZay9KMnJmRXNWMGZKbDJ6amM4c1dpZUtUUno3bTl6WFhRRWxNOE5K?=
 =?utf-8?B?VEVtalQ4MHFlcjB0S1hqMW8rQmhaQWFrU2xhaDN5YjlTbnhxQjk1ajhjTVZK?=
 =?utf-8?B?WE5MOVhUajNlQnRZUU9SckpiNVNrVWhwc3k5N3cybkdaTXRnOVF6T1BvT0dY?=
 =?utf-8?B?djdOcEYxYkNPZkJoRHkxNitFTHYvRWhNdlBGVlVDRzNNbndXVEwvYkhpNG9E?=
 =?utf-8?B?Y0VWU1dENmpaUUN4cExwaW5tSVdsRWtKVFpvS1pJTHg3ejZxVTJNUzRNcmIv?=
 =?utf-8?B?M1RIWjAzWHFQUFR2QUxRSjBjRStoY0E5OEFudTFNa3ZraUxBL3hDR2ppL01G?=
 =?utf-8?B?VHBDVjM2ak1ITUFtUzFlNXRoYmNtWndTZ1JrQW1VVGkyNzlDZDM2aEdhbVhO?=
 =?utf-8?B?TmdtTXZ3dVZ3WnJOdkgyUHBDTXk3OGFKY1MzcFdsYVFkU1JUK3ZWbDFWbDBt?=
 =?utf-8?B?a2NoTElKV1pvdXhHVThJNVg4MyszdFRrK0ZaMDRla0xlbUE4UTc0L1huWUJX?=
 =?utf-8?B?Z09PM3JvdHJlbGMvcWNtR0JsN0tWdER1cXI3UFhCU3NtSWQwa0NQZ01sbW52?=
 =?utf-8?B?SFdEbUZad3NkWEFpTEcrNE10ZkFwUzFET1NIQWo3ZE1CL0tFcHpnN0l4TXhJ?=
 =?utf-8?B?VE9Uc2FSdTRNS3hPMUZwbUJ5QVFhTktCNEtCSU5HcDBWSXZCWnpvaUlaRnVa?=
 =?utf-8?B?TjFtbXlyY25CUGJhaFZCLzl3cHJWMENpaTJ2UVJ1V3Q1SFRyVzF1QjZ6Z3A5?=
 =?utf-8?B?V09lWGJzd0dmREg3K3RGSDB3V21CRE1BaFVoREZ2V2Jsbi9PRTUyZjJ6MEFO?=
 =?utf-8?B?V2tOYWlraUV2UkJleWwyZFR4aGdTUDRYMDZ5a3didkNkcEdlNlNNOThNRitE?=
 =?utf-8?B?ZEw0dE1EUVpTOHZ2d3p4eUcvWDlGaUdleFg2VVpaSG9PcXRlNTFBczFGemNI?=
 =?utf-8?B?NlRxdGJudlNCMnk5ZC8ySUh0ZTdlcEk2Q0pvdWRwUzdpR2JkRzhZQ2dvUVJK?=
 =?utf-8?B?QjlzSkdmZTl6VE5YYUVWb0Uvd3prV2x5SFZSbXMvL2JEWHNLUTNVYVRXVlQ1?=
 =?utf-8?B?Z21SbWlIOFBrZmFleXh1Q20zSk5FdmhJRGZ6SXh5b2I3STNQUWhUTmlNVkhz?=
 =?utf-8?B?cGtNb1ZEUmhnbnZTclVlMDRUYldTNmdDRkRiMUtIaFM2cDlQQjJEWUZPU3lM?=
 =?utf-8?B?UVl0WldhSjNqL2ZDQjFsYkVnNVIvaUVyWnJNeTdzenozejA5aURKODJod0Nx?=
 =?utf-8?B?NXVSMzd6Ry9nNTc0Z2NEUitFLzNLdDFseGhSM24rK1kzSmEwcmQ2OCtyYmJ2?=
 =?utf-8?B?eWhjUldBbngrZ2RVcVNjNlEwWGZ6R1h3TkNURURxU3V4TkRETHlpMStCN0ZY?=
 =?utf-8?B?dDlNVjFZTTU5cTEwbk9zQVVwaHhHNUNCbHdXWFg0aDNTTnpGcHNmNnJJTllT?=
 =?utf-8?B?dTh2SG53Y1NNVDlEVmF5bjdTaXBmMmhQNUVmVlZ3ODd3WVNWcU5KeHg3eXJW?=
 =?utf-8?B?TmJXMVpqOGg3ZmZPcnVMLzdLbzgxNjd0c0lKU1QwYlVEMW91N3pNUngwTlc1?=
 =?utf-8?B?T2FwN3JhVm5wMlNOWEtHSGNaanFjSHN1ZExWcTdTNUhTVHlTdHBHeERReTFY?=
 =?utf-8?B?N09wL0ZQaHZhWEhhRTk4K3plN2FTYndtektGMEV1eExnS0Y4UGNFSTk2MG9E?=
 =?utf-8?B?MENiZDRYRDlrR2o2MnkxTUx0U0JFRG9hc2dZaEFaelFtbnp6eW9kYlU3N2hX?=
 =?utf-8?B?bW9zRzMyUHo4TzhsTVRoeDZZMk9BaGwvYURWK3cvSUhYVi9wMUhkZER2RkpL?=
 =?utf-8?B?RlFqWjMxSTZ1WHRhdTVIVVRzYjJmRlR3U1grVlhTaDFFOXdESDJ3VzgvK1J0?=
 =?utf-8?Q?iG3ortLRiFeI6wY5Z60oM/3NXv+pw3mLTw55fRTIH4RQ8?=
X-MS-Exchange-AntiSpam-MessageData-1: Yh5cSqdJDvi50Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ad18dc-86b0-4bd5-7b93-08de8a18d17f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 02:47:13.3079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTIjcsnZ/oGvefjtWnCkiePSDGZ++0fMAsHcxwBbNiJ37KmVXzHdjp2UaLi5LBbNvuK13SIXN8GSO8c0szF6PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448
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
Reviewed-by: Gary Guo <gary@garyguo.net>
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

