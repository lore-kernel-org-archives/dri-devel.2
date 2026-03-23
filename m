Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917FAEC01CD
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE8D510E4E5;
	Mon, 23 Mar 2026 11:08:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fzczZ6Ub";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013026.outbound.protection.outlook.com
 [40.107.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4B2610E4E5
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 11:08:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCnMMgsA4H33/Ek8qI5AY10O6wAMk6Tmv5M4Bvbx8K9LrE5u6DGvlxvQ+gFwGcrap+B2X+6TiWWY+t5SzUAIY3YrBvUKuMNVFEbXlIrjcR0aEHR92jLWmu2FBapLE3sWMh7WQPcI+wXEUfSJ4hkXyC57wOO/u+QVoQi+iT8e+nlzrZY4/qovztbi5zLQo5srCkJHgm6Vw2C6VH+Nm+HAchGNeAQQRoXmkinjrh7PpSujJoJ4tgcE0erfI0a4wRP+8/cL840sAtu2QcE4OYIdrd6mis0ogGOcftS5GkVcbEQzjyxjbLu484TXJR6i3bKFzdRoVuJajdlxksTuaRF5AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkVb9wLuGv9aaNw86P5lsYZiaY+jTqvs0UIA7x2iLeM=;
 b=YPjnrtLTaylhH8AYk4cWaLgycA1uzAfPFChFLgGIU1u2iPi1Yu5ktpLVhu830ZWUp7FB8HFsCW6KVCUyS7jKptT8r/e1H0M1e0nFWHfoUA44Sj6gTc28926DNBTvdQ1Wna1v7bj+vEh+iqpq55mHOajZoDczXXk/rAspiPICE7dLQD48z56fQUuroyYhZHE6gLU+ybgve0HCiJOkU2ELVpMjc9Qk2mpkmpw//z0JKIGwjq41sqlDULKXnBhzgTlaE3ZTMYlno2+vSEXb6VyviDShtebsYCSlIO9BeV9glKlmtKiuHsm1bYZTIgZFHR3M0i3s2HzDHHsO/Y055/byrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkVb9wLuGv9aaNw86P5lsYZiaY+jTqvs0UIA7x2iLeM=;
 b=fzczZ6Ub+dQFxCgNeZQ010weh6EGyv8tl0Ryqpn1f974YfwiC6aid1YD8+UIpsYd6z9EGtzA12/18BlVch23ks5GQzjxIKRd3vDiXHPb8c6/hxX9CmOAsNXBaTL30sbpKxO5RiRRQVr1CIsSSjb4nd3B404xegp4Fs0ZVf2Ow47hHuiJCQUN2qcKybwJdzpKcGNqx3k8wid1BX9mOMyiw/8O/30TY7LajeTcCjpnHK8+O1b5CY5rgyCXeRjo96Yf4+wyb8C6hRd5O7QNvsZvu5a1tTKmOMmjWwbI0bgEC2o1vFR4oPSuQpIajxKlbJjBrRtwILHEPUInDwZm5kIC+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH2PR12MB9458.namprd12.prod.outlook.com (2603:10b6:610:280::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 11:08:24 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 11:08:24 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 23 Mar 2026 20:07:45 +0900
Subject: [PATCH v3 10/10] Documentation: nova: remove register abstraction task
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-nova-register-v3-10-ae2486ecef1b@nvidia.com>
References: <20260323-b4-nova-register-v3-0-ae2486ecef1b@nvidia.com>
In-Reply-To: <20260323-b4-nova-register-v3-0-ae2486ecef1b@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0045.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH2PR12MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b40bda-6c56-4a9b-f5b4-08de88cc808f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|1800799024|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: c+xoBdAkGQ2dOV1QtDMhEAE5daly1KLi/CUaTT+ra0jI0FSwKMe5TTyvmvnmLdNsHQawAwKX6h7ZM4tlt/qikRNS57VspZOtRMWZjGeyZbfpDnBaxQfS5qSOOc+tyzG2Fw7vrP4pptxrAyxs5nRjTgagXgwjxpQ5QL5Umm86FZTJ8jXSrM9hqjhiqA9ZSm1LMGudhpeDbT8y1RTsZz+mOQXKERVmojSNaqQY5HLmPIKutMpWwyKS+yPrLLwgKAHCTa9iDzQhYM7q1ABytTZxXaPyACL9RHGp90TgjqPFrLmrrp20BSC31yXv2mU6VNYwxF/PDNePiR/YEXgvYWa4+98DdvUC15RzxCzT5e4j4d3gk9O0XTVS+lyilt559m8CD6OBpapebduxbn4lEp1iAqMIIQPIDL9LTCdh/WmUpaqEDfx9+vXXLizh1Xw1eA1STxaucSOmZVkShzJsqZ8J6nfrH8cbJCYHdDCsOmgrRYsm1oW1ZDtSxDGLAPHh+M1mmiywgxAUG2Pnfp8vGM2S4PkK+hpDRlrj7LAHxovYJnaRqyIcBvlKGuF+Hv5jYA34FYF8NHRSWsvssy/+8o8mtUz3jKsAUIeqR1qiOm9ZXbwfS6xItyk776HowMdFzD3KizRCJl2p55vZAKHx4dsvuI6urjpxWqs+NKJrwgiUSW/L8xtf6l+akJAJ3fFidrfAo/kQSkhW+qlpQttcQpfUPpsHqQelD/lS82r3fVLljjpsGBzovRtRAmmjym2sWAPXnbyM8khJ3iLJ8k6gmqMpNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHZVTFd3c2VLVkpsWitrTTNoTzcyODNOR0p0Q2pJR3hLRnZEQ1RXaGtBb0Ft?=
 =?utf-8?B?eEtrNFUzdzRUUnFMREZFN0NVKzhYVUU3R0s4bkVQc0ZLMkdCamhNd2Rxb3JK?=
 =?utf-8?B?cHd5a2tkSVRNcUFKa003MW1DNFkwUFNJRnBQYzN5blNKWkhpV29LWERLWk5B?=
 =?utf-8?B?Q2Z0NmZlVGljSFpmZ3piZWhLcFhQQnpKcXZraDNVcTNKK01XamJQdlArL1pX?=
 =?utf-8?B?MXFkcDhSem52YVlBTnpWR3MvT2NyMHNkTFhJZnN6anFTRGg4ejZqYkpZL1Bp?=
 =?utf-8?B?WjJtMGttZW12K1ovYnVKK1h2NGx0YXIydXY0dmJveDFpTTZwRkxWOGV0TmUz?=
 =?utf-8?B?S1dMTE5Qcms4YXdpenptOTgxc2ZwZkxXMWVmeWtyWjN5SWdOT1Uvb3dNUGVT?=
 =?utf-8?B?WEZzWjMwRUlHc0dRMjAvMEpwS2Q5eWJKK3U2MmU3KzlZS3NiR3pzRzJlV3B5?=
 =?utf-8?B?dVVleU1pSGRSeHNrVDFTSmhnRFU4ejVxTDVJb3MxeWR6UzREYlpFVlJ2S2VO?=
 =?utf-8?B?SWFmd2hiL2tUSm9uZ2ZYQWxOK0xZaFBudWNZaXRjM1NuTTUrbjdCdDhNR0JZ?=
 =?utf-8?B?L3pQbm1EVXdZRktDcHJkWVFNcjJqQkhvMTY3Z2trcDR3aXlrKzlCS3FVdW5n?=
 =?utf-8?B?Rmk1dDlMYXovRllJcWNBbkhML1hXNnF4dDJmZkNwL3dOSWxqcFBJN0g4QW5Q?=
 =?utf-8?B?dlAzL1gvZm40RjVVL054RXEvc0xHVWtuNExYd2ovMk9DOWhVZHFnWGhSNG9B?=
 =?utf-8?B?SjdIRHFTWXJmdk5SbjFQMUx6aVh3NlJUYzhlZFZ5WDdBM0pxdC9LVjZqK1RO?=
 =?utf-8?B?YVFVdGdOTE9rN0hlVFNsVHAwclByemUxZUE4M05nU3RUS3o2Rk5hMHM2U0lQ?=
 =?utf-8?B?aGpsR3dCMzRVa1Zlb1pjR1BEenRUTzJKSng1MGtjakNoZXJvSVlBWCt2a2dm?=
 =?utf-8?B?c0l3a0Yrajc1R3dIN054ZVlIKzJFZnF3RDNDZ0c5ejVVM2xOKzREdVNMZGov?=
 =?utf-8?B?M1N6M1ppcFRnYUl0VzBCL29HS25NcFZwc1FCZnc5NVBCc29BVlMrOG9lNm1O?=
 =?utf-8?B?UUlqWVNUZWlRWUZXb2hsUkFFTGtuK3JheEN4VTdaTVhUN0wzb281cEpVT1cr?=
 =?utf-8?B?NERqd0Fwc3IwN2tYbE5EbzZQWDlhbjNCL2tWNXNscHVsTGtJYW8rSVBTcGZj?=
 =?utf-8?B?eW5UKzlOcEMwVSsyZ3lVbnFoSnJ5aGp6ZWlBRXlDNmRUREdMU2FNOUhPVFRG?=
 =?utf-8?B?dzV5dVlLbTBUL1BCdDBNQ25zcVNzRmhPcVY5ZjZDQkNJYU5sd0hsRnZRbllr?=
 =?utf-8?B?RC9GLzM2NWxPT0V4S0RZK1owcjc2RjUvVENJQi96NW5ZakNaN2hMYkdDQnF2?=
 =?utf-8?B?cWxwSW10ckhNWnFZelBYQjU4bXg2SGF5emlDVGtuMmFKVzRxUExudFdKSXZv?=
 =?utf-8?B?b3RydktWMDJ1QmFBdXFNelRwL2J6a0FqUlRGNVZwM0xQVCtDRFZmZERTN1V1?=
 =?utf-8?B?RHRsN0gyZ0pqRXl1dWlHL1NOc0pqeFZBREJEOExlWGEvSG15bDdqUnRZaldt?=
 =?utf-8?B?VTl5RURGSy9Rcm9FcGM5UVVIQ0M5WGtFbXFSQTBENDNBMjhqSzUyUXVkVVNP?=
 =?utf-8?B?RThGdkJ1UnUwZVFnbzZwVlRCM092a1NkOVRNdWM0dTBGMlJHeXZGVUIwVlZT?=
 =?utf-8?B?ZTZRYWZYN1AzV2IrL2g1NFdhOFkzRVFNOG9OYlNlRWFoeFdRNTQ3cmVGbTNE?=
 =?utf-8?B?OWVmblVEWlNBUUI1QzIycjBmOXBURlBUSDgyWS92bXJBbnB4RER6WUZqWitM?=
 =?utf-8?B?TXpYaUpSL1pXbHhkUC9VdWUvc3VyZE9NcE8rUVpqamdkcE1WQVlrdjJJa09u?=
 =?utf-8?B?MW5CWlh4OW1HMlFtN3Jtd2VrMnNCZDdMVE5zRFNSQjdpZ2xxR1pHYk5jVEw4?=
 =?utf-8?B?NW1DYmtZN25WTVRMenZaNzd4UUQ0ZllINkcrL2lZZTNPT09zNnZVWlpXYytu?=
 =?utf-8?B?dFc2Nk9DM25EZlUwak9wK1VESGJUaWdpb0dqN25HMkpoN0JUSzdmdVFKcTdr?=
 =?utf-8?B?aEloRFdRMmJOOHA2NFhZVkpaQnl2VDVIZVA2eE5McUhHMU1COTU5VXZ0RGRS?=
 =?utf-8?B?cFU5aEtyanNQamgxWlFuZ1dVSlFxcHljWEJSQ0ZKTHpaaFpWNXVSQ0NieEN0?=
 =?utf-8?B?NEJFdUVkR1FVZ3RDREhWZHowZkFpWThRMi95K0FNTzBsaytBTlNYazdFWkJ0?=
 =?utf-8?B?Zy91MkJkdlJzZi90cGlxOHFxSFNBQ29FTTFkcWZaVGtCL25JWDJnRDRhOHdl?=
 =?utf-8?B?bDVYWUdWTUdqNUp3cjZZUVRzWEtGK0tBMGJZUTBvWEdVd3ZKN1hSVWo0M3JL?=
 =?utf-8?Q?dw2jJF+WRC1vHXMGP95HoDppYONDWrZ/6U0XlaGgCTm8d?=
X-MS-Exchange-AntiSpam-MessageData-1: TtDklL0/y0d+Ng==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b40bda-6c56-4a9b-f5b4-08de88cc808f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:08:24.6166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: flbuoP994X5zHU9sNadj64Fs5omWfVk36caLcp51oZzDQuVQtBUCb6o4a9j4KuPHHpp48vi6KCLspLdlcd3gVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9458
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

