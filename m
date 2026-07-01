Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8FAC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 00:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B4FF10E18D;
	Wed,  1 Jul 2026 00:15:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="dSjGBS90";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012067.outbound.protection.outlook.com
 [40.107.200.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD91C10E18D
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 00:15:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BM0Vyhic837/V3KVPD3mZqNZFa1ym6qjiySacAnIRxqzfzoM3M/rm9m12AMp68tCd6QPXYc1j/l9n8TWKrgAwSf8zec8lskU25WhSdcSQxFhrjrCVyhEqIuu03Yr9nj6Y1BMPJGzPOb8/06aWTd7FNvhMhJlHNWvwi+xTefhe4FpHtvaIw1ZBOj58icPmf/EZ1WlgRpHIpTuXhX7LlRMqHbqx3+zENrQd1LTKZjqXvyULDV2Ba/Abg5D1FM2qH33EvYSNhnIKdufQiUS3jIt19h+fi7PGI12fPgTAjFz5E9iJDmfr+Twvny8398Ljl6pprnSVqForU+vp/rEK3fKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mzjwMqLWOR7UGyAgHNXhWi80zUQfmmUs806QDGMZHM=;
 b=tLb815S337oV/Zk117/XJAkClNPs9J1ngSwEyi7/eTMB0g39Fd6PE8ZfEo/cJ4NxaTmRGX+qlxIcUy9nE+TL4lyxsqjDSSavurUt23YLnCDKMBkulIf0b9skNXXOo4Rj1wpTBlgmD189f8Iq37E7ZfnCpB5tocdIHYyQG85AE2zpA2WM2LZjcWmtS+wvMH+R01xwoaCHgkbCoTvNrEOjeRrYmJAhSCzrGFuweePaXhKOU/FG9TfNh02IlHTerDtVDM+SHg3XwmMJ2LELMbNTR140by9Q/9OOeId/RvlwdyFICou4eulabmZt4ojugqo1QoAFTPTtORniBddYmNkP4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mzjwMqLWOR7UGyAgHNXhWi80zUQfmmUs806QDGMZHM=;
 b=dSjGBS90GJcfndGnorCO8+JRHIResTUcUIc4JG7tQxmac2+QfyW9JX/Yi/uIl12Dmhp9NsKBLKFeMReFJxNiMaFp5vN0zX2qWRGE3pgOCza0sDuD5VBQ+N9piUELR0zhtoPgySSaNRdJpZe4gfJD2kdRjVfpDjEOFuKXcSrhVoNBi3ysXI9ABmTWQANRbcbDjAlxkJktnbQIkUd8d5uNkho6JY9eyLJmJEEd36vn3mauGWsNTOksF5y66kartYGOEfleaZngS/4Q3M9eTk0Ld8BiuyG/m6hXPwOXjelr563G1k1EM+d1NWk2Sc2iA5AETb67sdkaNgp4om2r/Yfoxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 00:15:38 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 00:15:38 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v2 0/2] gpu: nova-core: convert to kernel bitfield macro
 and remove local variant
Date: Wed, 01 Jul 2026 09:15:29 +0900
Message-Id: <20260701-nova-bitfield-v2-0-2e949bf1836c@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw7CIBBFf6WZtRggBtSV/2G64DG1YxQaqETT9
 N+FunZ5knPPXSBjIsxw7hZIWChTDBXkrgM3mnBDRr4ySC4VV0KzEIthluaB8OGZxYO1Vp6OhnO
 omynhQO+td+1/nF/2jm5ukWaMlOeYPtthEc371y6CcYZOcKe0lkqpSyjkyexdfEK/rusXcYVnS
 L0AAAA=
X-Change-ID: 20260617-nova-bitfield-be4bbb298a00
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: OS7PR01CA0060.jpnprd01.prod.outlook.com
 (2603:1096:604:254::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 9edcf87e-3398-4654-d09e-08ded705e0ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|10070799003|1800799024|366016|921020|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Ht50YXv2uujO2A4DMVw07es6C32rQtoeJA5z1ZihjdvtRr43cmMXkYJ+tktgPp1nBEEUEgMcwm3BKN6PE+PXWGsjMLTsQF8Lq0SHRrsc36EjKihz0b637TzPs7yfUFP2nXELYuRpF7rUC3GQGf+xd2sA6DZJ5B9+0qr0CZWaGcrfPhGQjUSxYhqViAsoMvCVjho0TSgKuznX1WT+QKmcOab58VdS9UPwn2JFtHhybeXM2qBt94I8vjGQKKQ8QbBWYjJ5nSWCHO98zJuoUwA4vFd/3b+PwoWjWfMSgJb4klasSXneTLzDYD65mM33x5AcuPN7wyGp27ChPo4n5dHLhx05fEmvCneYWkToqrQA3WF1LnGRaggCCW958gAoZcqgwifl9D4IMrkKKugCMSXX56HNwhFwoCmTdY+KYoWDyFzzYwqWmdpteQC9Eoe+T868TS0f0tOwFE1pvY+3AFhhBMXvUIx4FDNmkRf9kWtjErOeSWOtwwb7kk2dKl8jnJTInumAsIJhGFMPJZPnwsAdS5nHelE08xukLWEifYpDKed8cuVwGDJTJ4nGfnYfjxoEB7OLfbcMNlaN87/SVj2S9HdI0o+MQGpWwB/DMlKFy/VfTiB5BpmB+7NuJzVCt2sBjVcF/Zux7L7OseQ69yrAKfUj6woQs0mU2RshpbTBQbCHnNjDEYUluWRSbtnOG7eQIPYfcq2boKX2YbdwpF44hA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(10070799003)(1800799024)(366016)(921020)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm1PTjlJSzRaWUJHelRndXpNWTlsUkp4UzNMRlpLS2hSMm1SNWIxYm1Denlx?=
 =?utf-8?B?NlI3b2g3c0hHNGcvcUQ4RTFRMXhSYW0rOWdENEVLODJTTERhWTNHaElqN0xZ?=
 =?utf-8?B?RkRHZlZ3V1JTcC9FeEcyQmsxT3hKUVNiVVM4bFBQVFo4M3ZBVy90ZS9aQ2ZZ?=
 =?utf-8?B?bnV1UzhKVGwwR1JmZENySnpEQ1A3bExBS2JQdkxmaEhWYi9FT3NaWXkyV2t0?=
 =?utf-8?B?dTk0TFFleTlsVU1rVGM0SUVwTzJqbFpBT056MDJseE8rc1FVR0Q1bmlRQmZF?=
 =?utf-8?B?cTA1elR4eVdidUdaMEdYOS9ONzkxVkx2WFo2SklaTUZRY2VLQU1keXpIYVMy?=
 =?utf-8?B?c3NSQjFuczRmbWFFL2RGQ25nM2NKMFpuTXNoNkwyS0lROTRtWEhKTk5HbHZR?=
 =?utf-8?B?eG0zS3p1YmxVeFRjVmZhRVRyMkF3OTJQSEY1NFd0dUVrKytKQlV2dWwvcTAr?=
 =?utf-8?B?QXBEV1k5OWpOVDRYRXpwOHFkSE1JRVd6SStzTXZFUUlMTWtlVUNtQVViZlNa?=
 =?utf-8?B?bzJJZEd3V09jRnhrSlkrazV6L0N0d21ETU5pNHVnM2U2K09BNHAxL0RiRlZq?=
 =?utf-8?B?QXJyZ3N4em12SURBdjVTVkZlbE5xbmdQZy9pbDBldnBFTmdvQm01T2xPQVRU?=
 =?utf-8?B?REM3SEVabXA4a0NiZ2pPSndhQzVQZFBqNnRiOXNHM3ZpWk5NV3J4a1Nick9y?=
 =?utf-8?B?dm5zaE5TZFFzL1lBU0w4OVlab1FIMXZOTmJsUEEwL2V4M2tseFI3Y1VaemEw?=
 =?utf-8?B?QVBPODF2VzR5TnorUDEyWjM2aEUyZDJ5ZVFkcnBrMlFtdDdubnhvSlB2dm82?=
 =?utf-8?B?V0FPdnRaT05aNzRrS01TTDQ4ekw2VVBwY0pXUmh4V3FYc3NJRDhKSDNaVmRP?=
 =?utf-8?B?TGRXYi9ZOHFoQVozcHpzeDU2N1Voc2dqTHp2V1VaWC9yanBMYUJVNnd0VUF3?=
 =?utf-8?B?bDlSdE55OGVmbTVac3llZnBhWmJ0Q1dBaG1LTkRpVlZuTko1cXZjYXJvMXFX?=
 =?utf-8?B?L3hSK0E2SG52bjlpN3djZWxNSXR0czdtbDIzUVl5V0NRM3ZadnpyYkw3Zm9B?=
 =?utf-8?B?TFNyKzAwMjlUZlNhTk5nZDJLWEdyci9OMTVmcFM5c09MdDcvS3BaQ3labTk1?=
 =?utf-8?B?a0hqNDczS1ZnNnRvSWFVZk5rbEZUa21Yb0MyMmFOVDhYZHo5bDBiYjhXZGxh?=
 =?utf-8?B?a05tT3JqQ1BYMlJiRlZEM0ZhaFZNemFSejdna1hLUXJiZkhZbHF3VjNWajBr?=
 =?utf-8?B?djcvSjhzSmlpRldkcVdGeUw1V2JpN3RYajNsQ0pkYUY2UEpTV3h3RitPT2Ur?=
 =?utf-8?B?bzdwcGJseGpJeXZuQndycGN0Y2d6Qk1MUlV0OVNnR1ZnOUN0M2pBZ29PN3Q0?=
 =?utf-8?B?Qm44c245cGkzMlhFaGVDNi9MVnBGRmNXNFBsd1JOQ1B4Y0Ruby9qdWlNQis3?=
 =?utf-8?B?d2tRaER5OEZYWkRHamZTNXAwank3M09QdUVQNW5UelpnM1ZnVXFCNmhnV1Vy?=
 =?utf-8?B?cG1kUUUxWkx4YVJaRm1BWk9CNjJpZFNTTDhlYjJrVzhjTWZIVUpWYmhDM1Rq?=
 =?utf-8?B?S0F6YmJ3bE9KK0NhRi9vVWN3REhqZ24xMDNhM3Mrb2Zhdm1lejlRWHk0SDUv?=
 =?utf-8?B?dHdjKzdOcXUvNmxFYVZNTnk3VGliZDJReGtYVGNjZFJrWWNNMzl3LzVhcDBt?=
 =?utf-8?B?cXN1Z2R2QnpjQkcrWDJLV2RlQ3psZFdxb1VqUExXNExtSTcvc1B2Y1YxSVpO?=
 =?utf-8?B?UmErU2VvWjVkazlsN2hkRUlQVTFFckhMWHBLeTlzRlhOYXk5SmJRcVZjWTVh?=
 =?utf-8?B?NEFOTmVpTUt1OGhUL04xY3FWN3RTdWZJY3VpZ2NDdW9iYmM0UFRSNGJFRFJx?=
 =?utf-8?B?NFAxelNoSTI3SHZkcEQrRnNNVWtDQ1cwUXdyNFNsdGtyQWNBSDRxMDN4czVM?=
 =?utf-8?B?Q0QzdU5HWkdVaWhLSnhuVTh6ak00Rlc0YU8vWXM0Wk1wYk1pTENEU1JUQUJq?=
 =?utf-8?B?NXl3NGtabCsxRmVVSTltcWlnaTB3bVR2aW1CbnNkRkJmZDR2ajJJc1llQU95?=
 =?utf-8?B?aGdqSnExU2RUZzE5Y2c5RGNwaG1rNm5nVHZZN1BkbXVvYXIvT1BPN0M3cUdz?=
 =?utf-8?B?bnBuRUxFcStGTnVnRWtXRExhVGtkQlFCdzBFZnBwTURWRVhVcnA2MVFhc2dy?=
 =?utf-8?B?Q1I3VnFhUnFUMmFQa2ZMaWRqQ2htamNQak43Q2ZEY3RJTnFFYW9sOGkrS2tz?=
 =?utf-8?B?UDk5VTlYYmZkRS9KMndrWVpQRHNIdm0wTWZGMG5XM3hud2d4c1hLRk4xUXEr?=
 =?utf-8?B?dzNxd1BzQzZiSGc4RVlTR2VoRnlETzh5U09wMDJFUlY4WENYTzRqaklCRDZW?=
 =?utf-8?Q?mP560/n8Pj9uFac3zpLWlKO4FjvYkzvQyeclo5ayiwL1e?=
X-MS-Exchange-AntiSpam-MessageData-1: lvw2VD0OzLcmoQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9edcf87e-3398-4654-d09e-08ded705e0ea
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 00:15:38.3568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHptBWlRQqB4wMd3gYeDP1L9ka9dYA1/uVgIUqoUQLgXVMeU2VC3zC+WKNc0FyBdq18crudi7LZ0AULgpmrydQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771
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

Now that the kernel-wide bitfield macro is available, it is time for the
Nova-local version to be removed.

The first patch converts all uses of the local macro to the global one.
This involves redefining all bitfields since the syntax has changed, and
taking into account the use of `Bounded`.

The second patch removes the now unused Nova-local bitfield macro.

This is a follow-up to [1] containing the Nova patches that have been
dropped after [2].

This series applies on top of `drm-rust-next`. Since it has been
reviewed/acked I am planning on merging it soon; this revision is mostly
to address the Sashiko feedback of v1.

[1] https://lore.kernel.org/all/20260606-bitfield-v5-0-b92188820914@nvidia.com/
[2] https://lore.kernel.org/all/20260527-bitfield-v4-0-e8821d4efbde@nvidia.com/

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v2:
- Log all invalid NVDM command types, as was done pre-conversion.
- Link to v1: https://patch.msgid.link/20260617-nova-bitfield-v1-0-ec10c6772666@nvidia.com

---
Alexandre Courbot (2):
      gpu: nova-core: convert to kernel bitfield macro
      gpu: nova-core: remove local bitfield macro

 drivers/gpu/nova-core/bitfield.rs  | 329 -------------------------------------
 drivers/gpu/nova-core/fsp.rs       |   3 +-
 drivers/gpu/nova-core/gsp/fw.rs    |  11 +-
 drivers/gpu/nova-core/mctp.rs      |  86 +++++-----
 drivers/gpu/nova-core/nova_core.rs |   3 -
 5 files changed, 51 insertions(+), 381 deletions(-)
---
base-commit: 431f10ba13a964c146ae05728e42e4074bf735ab
change-id: 20260617-nova-bitfield-be4bbb298a00

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

