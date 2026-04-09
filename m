Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46833F31E22
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91F8E10E0AE;
	Thu,  9 Apr 2026 14:59:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZUNMJtuF";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011065.outbound.protection.outlook.com [52.101.52.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C2C410E0AE
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 14:59:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lseJIJLVZJ25b/oIxchTw0glueTPA5A4eVO6nJxcIpRPal4td7Nn0YtleYYUTSw+c3eoD3DHtX9KhCercRLxu3nE/LxSltONYGx5VUoMC/++bXof0PXie43PbRHBca5dlYhxhUagVFvUQQz03InbnmXo+o0kFquI51NTmrvOXe1O6aY4Dc9sZVMTmGh/zdjM4HE/LDlAwPSyAyYGQ5eaysobKoKXyNZ70SWS/sx1Ja+9j9595P7FFQm73vKyizrewbeCTNh/8htkkcrI9eA5EEW9qtc+jvog8WN4a2hPl1T3I9Qng8dldvF57xgxl+6ya5G54hGHvc/f+vMH5/NFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHIaqs33P/sc4KqesYHm+0Fekp4GvYrdRNN6BSaSkwc=;
 b=kU2mm3NScHKIBLw94XcN8//pcdtlik2MmkCwHRGcD4qeBawqKxhCielOV4rI97Xh2eMHychXT+ZpuGlGAftVbrUAeHcgaqG5yBEEkEYQPjdEWqFujR6v1Y5Kdy02gbAO/avjxvTD15qSyWQorEhMjuGW0VSCa6tZDN7DZH73XRpgRkHwOLfXUg0tovCaQ7jXLuW/A6haoMn0Q+yWvr+mGQ0F39rzU4CS5++l/nivdggT8HRfwgrKd8NJLABFefm9Shh5tDII/4Zzmw6JW2y3usg6hrXDKQhTv2PmWiaJXy9mrWbxQ5c2vE7c0ClVs/QQV0h4wy6Vicg7n0bwcPIS9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHIaqs33P/sc4KqesYHm+0Fekp4GvYrdRNN6BSaSkwc=;
 b=ZUNMJtuF7pzsJO88T9fMR6PLIzy8WepRsLv8iqSJjVGrL94Xui1sAv+jjlUjqhHni8slNFpk58HRkkeJwgI1s5YZ67CEkqCPCISvRFlCiGOOtpZfeusLnW6LJp3hIpUQ+XKFV8kBR0X6K1eeeoJCEVerbvGz8ywiiOarjQKVyeEiQlUjQZqCGw05jbLpQNLXrZMI2Ch8/nKS01Gs7eKHL1OUjlLSrUrQKu77Lxh+tVojvNe7hrmk51gU1ucYNxTMTeep5lSKYb8Nw4lTvm9fnbh0UFQQpKPZFBBV3nikpex4PGRCcPIQvLznCuj5n1c0uUyYp8W9dtyGUgH+tM0Awg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ2PR12MB8847.namprd12.prod.outlook.com (2603:10b6:a03:546::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 14:59:01 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 14:59:01 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v2 0/3] rust: add `bitfield!` macro
Date: Thu, 09 Apr 2026 23:58:46 +0900
Message-Id: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqAIBCF4avErBNMLKSrRIvUsSbCQisC6e5ZL
 T/430sQMRBGaIsEAU+KtPoMURZgpsGPyMhmg+Ci4ZIrpml3hItlDVZK1NJJZw3kfAvo6Pquuv5
 3PPSMZn/3cN8P/g1To2wAAAA=
X-Change-ID: 20260408-bitfield-6e18254f4fdc
To: Joel Fernandes <joelagnelf@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: TYCP286CA0136.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ2PR12MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d5499d7-3c12-4b28-93b6-08de96488888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|10070799003|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: cdJnJdVTKypJmEF/6QpbdoViu9wcNch/3QfGd5ecuKAIOA+JaFIq39+UiVkxlfncvs0ksH/S9CXOKWXnpXmGgwcCo5zIYg7tOI2HHiARebjKZVB/m6meuPo4lK0ETeAiAeKfeBDGpRCCLDbM5+wk+r0Ru4ve0OEIkZ0vSigbY/QlrS1gwUSYyn6N6exnykAMybdDfF8PhgWT9AQv5WzLWDNMP23UmOrsGfPWjSyRdwBgzRvL+s/X67U2PJUT4PLicFNfPpYo70pbNBy5/NMS8mLL9HAAaaPqqHn02zz0g8iP5aORn7gInxV9dgoxpMCgU/93m9AZhOmcL89UDtLbf3tXxYqKLmUT/YOrn1OdQY20uHp73CBTfvKlUgwo38RhLVhye2c1ELdiVyyW95rUlqZ3cZA2lVqisd+mP7AfqjVc1ttEHv1l5lmYwEHxHvPeKDnqjTfO1p+INx6VmixJWAEonYECq6ujvf9180AmcaA+x7V1WdAuDIYQEuvKcvXtLFHYMc0XmUfzbj6ADve+iZNMzE5LAcVN0nSkA+FGVPMMTPhZ1y8Bo8ZkfYeJyEG8tJRbHgENL4owfhOfSk2b3czFxJO36fixQUThUIvx3BMBtUaYfhVv7h8APhh/7bGR8qSh2q2nPTx/7TdNJGKyNUGJEOR0L+GK1XMyfq6KCuG3hD+FcwSDpi21LhB9hmAgO5IRcLCaw1cOp9/8UGBa0UZXh4YSnQTQbL5Ao6S/ykbD1Yy0oKkvjkthmIZztulacZTBepZ/2xH+PQif2r5mCrQyt2j5YqC1+rSOyV2uF3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(921020)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVdaTHVSd3JtQ3lDc1NHRWRZQjVzaGhBSEZLdWlRVGhHWk9Cb05nKzlGK2px?=
 =?utf-8?B?RDZxQ1BnaEI2TjU0OVVxbTd2c0JpM2JqaWlFUXN5Z21NMk85aHdzQTBoK3RI?=
 =?utf-8?B?OUNmV1NQUWJiMlNHT3o0WDBQTVNIM2FXalRtQmNGalFvTEpXaDhaSjNCa0Ra?=
 =?utf-8?B?LzhpMTU5dHh0L1BGTXhyODZidWNTdlA1UTAxc3p3ZGxVcmhEUVFmd2ZHTHRx?=
 =?utf-8?B?dzg2aWdoNjFPci80L3lGVWZuM3kwZDVSbFFrS1J5WXZiUFlOMzRCTkNSd1dW?=
 =?utf-8?B?Z0xEWHR1bGpoWlVidTlJcmd0Y2t2bzV2K0ZaMUFjN1VkenpHUkhqRXY1WVhy?=
 =?utf-8?B?Qm9ycEZWQitvekNkRlFTdUlWMExVOWJDNDBTQ1k5MjRBMWVsNEJNRVl0SjRu?=
 =?utf-8?B?Qkk1WUhkejJnZ0p6RC9zWW1YcVRuRngydW9hVVAwMTYwclhxVlhoeCtUZkVF?=
 =?utf-8?B?blBGZUY5NS9NVjB0cHJyZmZpME8wUVZtd1N4ZWppZWozMXAyQlRNVFR3Mmw0?=
 =?utf-8?B?SGVxZU5LZ2xzN2V3cGNDZ1JWZGppRDFmRnhxR2pPVWdIYnJRNFBGRDg1aGh1?=
 =?utf-8?B?WWgwRGk1MU1mejhjOXpBcEZYSk5vbWhRRXEycitSeU5EdHdEMHZZK1lNZ3g5?=
 =?utf-8?B?VTh2dWFsT1M5V09hRjR1QUMzZUVPV2FCVlRpb25nOUYyQTJYNEt4ekZDNTlv?=
 =?utf-8?B?MVRIMU1RRWREbmRSaVh2NG8xNml1TFVzcHdNYnRpUWgrQlJEUVg5Yk5VdkNM?=
 =?utf-8?B?U3EzVmFrQzlJMzRPdW5RdHd2cW9PUi9VeTdHVTVBZXNseWxSYkx3Y05BNGxJ?=
 =?utf-8?B?MjhvcXI0YzJCMndEcEg5aTZIRDB6bnhaR0lJbC9Db09nUmIyQ1lUM2dDUG44?=
 =?utf-8?B?a0UrUmpYTFdNVVpjQ2U0M3AxZWFKM0d1SmkvM2hpbDVSTWFDdWI1U0NTQlZt?=
 =?utf-8?B?T2NwM2p2RGs4bzFxTm1lY0o1VDBqekNONHhpZUd0S20yclBMalk3T0EvRWJh?=
 =?utf-8?B?dVY3ams0UXoxQlNpWUwwRW1rbVpGbEJQV082YmxEMDFBeDVxa1BROXd6NUho?=
 =?utf-8?B?c2N5dENIS2hieWc1ZGtHZXVBUU5aUURwSHhMc2FvSkdpUFByZ1hObzVlY3po?=
 =?utf-8?B?TmVjUTVWTStkOGxLeWI2ZFZsa3dxR0ZHMVd2ZktFUDkzWmZIWDFHNjY3S1Qx?=
 =?utf-8?B?YmhGN3dCamlzZS9rMm45UjB5QVY1UDVuRnNjOEVDeEh1dktsa3ltT2VrYWhW?=
 =?utf-8?B?NG9TRmZmc0htZklWc0pjaFlRTGpXTG9ja2RIUlBHR2RobkhYd1pZRHZkdHJj?=
 =?utf-8?B?VkxlSVEzakc3c0dISUVNa0FzZlNIOUVJeTVMdmlUSG5HZ2tHUTRRS2ZvWS9L?=
 =?utf-8?B?dzNZTmJOWkhuYkhnMjg2TDlPc1kvV1dJSGJBN1BSWVZ2RWhzcmRZTkZObUFV?=
 =?utf-8?B?TVFiSC9QNGtldkJDNHFpVHdIajBVZFVhODBvQlZ0bnYzL0JBN2hyVWhGclkx?=
 =?utf-8?B?OUZSRXg5bmcyanZENDdHWGNIOXRMWGVVM2xCOTNhRzMzSC9TL2JCc0hsOXFl?=
 =?utf-8?B?bDQ2OWRrNVU1cWFBTnRWNWFSZXVhNDhIT3Z2VVM4Zzdta1lpSFoxYXpOTEd5?=
 =?utf-8?B?WktkamFBL3NGb2hvVGlNSWhjMG11SWV1M1YwOU5zYVVQR3MyQkNNNkMySmFJ?=
 =?utf-8?B?N0tOU3pCT1UzTlEwUFlIdG1yZkMzQnV6Q01JcHRsUmpOSVhBWlFDUzZHRzFp?=
 =?utf-8?B?VEtvYTlKTjVQMVdBaEJwc3gwVnliS251OXVKdHowMjIzbEZkLzlvUHBNOFBJ?=
 =?utf-8?B?Q29CV3FYME5uWHRoNEY3cmQ5N0ExZVE2eUFQekg5T0JwbFJhcEIwbEJiR0Ro?=
 =?utf-8?B?OXFvODJySHB4K0pKQlgvbVRPNkpLVEFsTFZDVGZsbWVLclYrOE5McDhUMVZh?=
 =?utf-8?B?ay95SzhaMGFpVnRlall0S3hTMzRpSW9lVyt2RGdJREp4Y0lPQ0VVbWFZb2pq?=
 =?utf-8?B?WjVNTERHTE5qTjZrb0tJTDVCYktoL0h2Z29NQ2ZyY1VaU0NmNjlmUTEwT3I1?=
 =?utf-8?B?dk1vdFBtY3dLZXRQM3l5NEluZm5KUkpNN2FoRXhNUy82QXh6b3BZclJaZHV6?=
 =?utf-8?B?bktORGVVRjJVRTVJeXIyMU1GZU1EbTRqQzRhdVpWQ1FYQ1doaVBCeGd3K3ZQ?=
 =?utf-8?B?RjFodnM5OTROM0dJRjVpdGpkdlI0dUkrSGlkQ3lkWFVrL2lUOGhuUUlvUHpY?=
 =?utf-8?B?b2VDNmFQRnNCSlJiaWxsQzdnbzVFQ0JIRlc4bzBkcE9wcE9TSkVoZjI1dGZo?=
 =?utf-8?B?UW16NUhQbjFIR3N1R0w3MUptZ1ptczgrOWNjY1k3TXYzQnJaWkZrb3pmT2tH?=
 =?utf-8?Q?L996UQYQVk+mnqZXr5Rs2uGVng54H+OAlSXScr+rqfmPs?=
X-MS-Exchange-AntiSpam-MessageData-1: QIOEs6RKcP9j8g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5499d7-3c12-4b28-93b6-08de96488888
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 14:59:00.8106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5U7B4AsrPrrXUGiawOo/5uL6A2G0f1ABahT8JL2nBk0qb/x5hXm0+vgUySp6wO2Dei70uQceBPPKCw/zERxWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8847
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

This is the continuation of the `bitfield!` macro which started
alongside the `register!` one before being temporarily integrated into
it [1].

There were still ongoing discussions in [1], notably about improving the
ergonomics of setting bitfield values. This revision doesn't try to
address them yet (although the `with_const` setters partially solve the
issue); it just extracts the `bitfield!` macro and makes it available,
for the following reasons:

- To get the ball rolling again after several months of hiatus,
- Because it is already useful as-is, and ergonomics will be improved
  with macros built on top of the existing code,
- To allow dependencies over this series, notably the Nova MM series.

Thus, the discussions about ergonomics could take place as part of this
series, or as a follow-up - after all, bitfields are just registers
without I/O, so the present proposal does not introduce anything that is
not already in the kernel.

[1] https://lore.kernel.org/all/20260120-register-v1-0-723a1743b557@nvidia.com/

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Alexandre Courbot (2):
      rust: extract `bitfield!` macro from `register!`
      gpu: nova-core: switch to kernel bitfield macro

Joel Fernandes (1):
      rust: bitfield: Add KUNIT tests for bitfield

 MAINTAINERS                        |   8 +
 drivers/gpu/nova-core/bitfield.rs  | 329 ---------------
 drivers/gpu/nova-core/gsp/fw.rs    |  15 +-
 drivers/gpu/nova-core/nova_core.rs |   3 -
 rust/kernel/bitfield.rs            | 809 +++++++++++++++++++++++++++++++++++++
 rust/kernel/io/register.rs         | 246 +----------
 rust/kernel/lib.rs                 |   1 +
 7 files changed, 828 insertions(+), 583 deletions(-)
---
base-commit: a7a080bb4236ebe577b6776d940d1717912ff6dd
change-id: 20260408-bitfield-6e18254f4fdc

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

