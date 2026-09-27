Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A376C9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 11:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7834C10E0E1;
	Sun, 27 Sep 2026 11:14:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="KXlB5twi";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010057.outbound.protection.outlook.com [52.101.56.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FA0D10E475
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 11:14:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pa/LikZsbHkBKfUXx0DhSq1fR3bPvCQH2lfX3Fax1sHDQiJO7X3OcE3WtXYlQncET2Yj9rjyD2iUqUda3PFQrK8ABFegVbqt6xYeRmuwz1upXG8Lq4om84QFhSOiAoKIJyfPKOB0Tq6EZqQ8k90FZdTqox6NGx2OAXsHFsxjkv8d04FPhOTS0gIwL1NpnuOCZe9cZil5IYdFDivoLYa73U0yRjT0vOcpDq1qHYdqkJkqgEP7jWb7AnZk/Tl/sS+ctuMVkAhm0Zyp6MEY3/zmLjhXArwsortCiOeEuQY4y5FWbkAEWg8aUJWEVPBRFF1PuPXYgwyXOUSZ54O87sUgqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPo4vmHtX37SCtukSMt3uMr8nsZ2rRRyxEPlCqM3iBQ=;
 b=EuSR7e65p+i5YylZWJ6p+ycvfidErarsh9D24YOvDV7HNKH7SbjwLdl5lzVemctzKdO9a+ljakLRFbb44KyJCBUajcF56JBK853EBA5sPNnzON9nH4zB6xP6NXLyrALScmlO165+Ax6C9nIHavjQES6y5dLQCWFlZjJxAu5Q3Fgb9bAO8DSUom/6Kn94O7yFaOMEqjvWMCmxW5Fvz/U8A+B9kMeKsml4rLOw4aXPBNGLPevMnEduN6iPnAh+JWmvdYyjVxOCQ6B8ftGHqvGdiZ18PoiVpsCQS4Yikk1/VWcl/DTyZwVZnQnSCmCGBfw9LPGDnBqKZ93KV3l+fqAbLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPo4vmHtX37SCtukSMt3uMr8nsZ2rRRyxEPlCqM3iBQ=;
 b=KXlB5twi/PMBXXqu6fVeI47rtHMsNLj1AZnADjFlvrSfBTwaTVHHw5u6ChcH7Jdd3DCFI352MN0drqrjZ7iqPGbktAMDh5d2Zj4QAioJ5G6gKDaOBg9eC9PEQkCkKIkDZkaf/GmQmaX1RshoJI6aTThfRIqua26ySUtl+khwa1sENoxyXEg579JFxcqPOJLRO3K8vSKp7r4+Mu779QgJDmKlemTVZci86m41wN0LLyLn7fUHoHjUecaXSBtmckANDyyrY/VqE4TMTxPf08rCJsLGkXQoZRGUgi/vLU7IeCEKIN2GNfnrn+bEPootbwQlMVubRlP7nFYCuAY8vJ+Epg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 11:14:27 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 11:14:27 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH 00/10] gpu: nova-core: gsp: prepare the command queue for
 r000 dual-message types
Date: Sun, 27 Sep 2026 20:14:22 +0900
Message-Id: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqAIBCF4VeRWSeYYLdXiRapU01QmVYE0btnt
 fzgP+eCgJ4wQMUu8HhQoGWOSBMGZmjnHjnZaJBCZqKUOTeTXbl3hqNVXaGEliJHiLnz2NH5XdX
 N77DrEc327uG+H644+vpsAAAA
X-Change-ID: 20260927-cmdq-rpc-ed5f850b207e
To: John Hubbard <jhubbard@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0113.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::8) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 2826bc85-af20-41f2-c655-08df1c887e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|10070799003|23010399003|18002099003|10067099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: sMKPNKBorv+SHlwu5CZdI0Zw1bRJ3tm+Mv5wUSxJ/q8Gj6Y88NdxrMvfD2Whbt6w4Q5vDBal7SyB2J1YuAa+hHu2jNxwnoOT9Lr5mWKOMlaij5QXDKtkiGZRm/NAxQWJ348wx4uJe2N+tHF/g0tWcx+p++2Unzcfkp3UteYnmVJSKke8W0fQITesUTkzcLG4tF3Jy52aHl+Jv35baxGsX0Qjj1icvlsX8Y0YyjhRvBSz8jTsGTTAQbmMjDWmPVF4JkP86I03jvBbryguN3CpccS1teMj6LNGbrpvXiL6t8b5tJ3ufc9CpwKZ7eRI+05UwkCAihHAyoM2bqEn9q5GJdncDewD5dVbIUZPGr27wadDErLU56N/lj44XV1n0/QK2/cV7/6euwNdtVtMCdLI181pU71/d63P5SXbUWMZgt/XJz+o8QAiu82FRxWm9ozjrOrJWGI5TfXXQVzNtJR2CTV5vGQOwAN1xU8qrfGyq1yk+Aog5qFYQgiqajKZdI1sFbgTfoRj/kRHlvUlM9sufWqvGQK0XtqAP+VQjQ/oZmFc+aqGczU5EpDuWP8iEb1TzgPo9b0QOlAO48EQvS2+obUXXtoc68GwxfvjtrmIRK0tY9GuvH4+CVREyvMtMMi3R/twNPEqnBsc1G6057rjqBUa7kZmVO29+XUcjZPpTzs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(23010399003)(18002099003)(10067099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y083U25acW44cExVRTFyNmFLL3hmMUIrQisycnkrM21SZFhHT2xGWmJ2Uy9J?=
 =?utf-8?B?T2VQMU5EelhWdXhFeldIMFpHVDV6eXFqY1VVU3d0Qm1OVmJIWmZoWEJaMnpz?=
 =?utf-8?B?cFlrVFpaOERlcTBvaWFscGVldHlKSFBmZE9seEVEUTRmVXBNREk3V0VqaFZG?=
 =?utf-8?B?MzJOQzg0RnNPTmRLeE84VFBnamx1UUhsRjQ2QTJmeXQxcy9USzR5OWdjMFV1?=
 =?utf-8?B?MGVhWXF0blRVQnhYWHZ6NGt4WGNHbXpkakdoYVd1clVidkt6UkR6ejFnVTVC?=
 =?utf-8?B?Slg2M3d1Z1lCSWc3NHg3Sk9rZUE4dC9GNEpZbFpOMm9lRm1xSXlWQ1F1WVVz?=
 =?utf-8?B?NlFYYlpQWlB4TTBsM0U2MjQ2bWw4RnB2dUlYbFgxMEFYZUxLVk1TL2hRZ2E0?=
 =?utf-8?B?M1ZtbitJWVo1Ly9XamwvUFJZNTV0dmk2WndyTGhhU1Ywb056OUIxQmpTaFFw?=
 =?utf-8?B?RkZ2Vno5VGlWcit0cEQxb0FZemFmR2xxbStvQTdldWd3Qm9iQlYrbTFoZXky?=
 =?utf-8?B?K0JmMGlQVDkwVFJvSXF5MzVYYWt6RTU4OTIrRWg1ZHNFaEtkb0ltR1VuMFd2?=
 =?utf-8?B?UVBrelF5aU5pZWhMUWg0UlRxUklpcXB6ZHd4TXZMRUl3REY0ZFE4NXZZc2tD?=
 =?utf-8?B?U3kvakc3Qlp5VFdUQ3NYQkxMMUJPU3JUaFZhNnVIUlhlZExGM09YUy95Ykdu?=
 =?utf-8?B?MklsdjZxZWFuc2VhbWhKSVpQd1hadjVDS3d6K0xrRnhqOUZVbVpZajRacHFV?=
 =?utf-8?B?WDdVaW4yenU3eDJLelhVTTBkVzRpRFVVMXpSaFRNSng4djRwU3FtR2JtMnhE?=
 =?utf-8?B?RDhLNERVcXAzcmdKcEwxNjljWWdZUEVwOHRxMFZDNW1RUWl2ZDJiaytBL0ZG?=
 =?utf-8?B?aFlJeE9TZEdLdVh6M3J1eGJVUmVtKzJmZkJuQ2xWMlJjU1JJOHdqTzdTMkZn?=
 =?utf-8?B?cEgrdUpVSndkcWMzUUZuNjcvMmxrZFFZeFBBM3lxWWJIVDUxMjZhaUxTbnAz?=
 =?utf-8?B?bTFSMmVuZk1PYVgrRy9HVHZ2SDl3a2tqL2hiSVpGQjFrVFZMQ1dDbklhZXVp?=
 =?utf-8?B?a0Z0RnlSWGt4R3JXK0lBb2RYK2ZpbmJ6S2VlSE1jVjlmMm02WFNJeTlXWVNZ?=
 =?utf-8?B?QW82TEVmR0lIdjY4RmJZdnBkU2IrSkJxVjZjeGhFdVFlOGNBa1BQUWU3UlNN?=
 =?utf-8?B?SmNCSmEwdnJJRUxmN3VvaTJCTkt5S1VZYXBMZmpJejZlem44eEtCQ2VlNCtk?=
 =?utf-8?B?V3lZVEdnTGlqQVpLOGJIaGJBU1NIbittNEZqRVZFSVNlUzl0SEVNcHNGVjVK?=
 =?utf-8?B?ZUdNZTArbHAwZFhiR2xsNmF6Slk4OHpzR0ZBbjlwMkhSR1ovSDV3b2V3TkIy?=
 =?utf-8?B?RjEwalRlV29FSzMwbEF1aXdSSWVDVVhYZkJlR05XQWJXd1IvVjdUaEYrVG1L?=
 =?utf-8?B?bGp6N1pDbmxjdXJUdkh5MWVnaSsySFhnMzRHajBTbEpxc3BBbXZoZkQ3MktF?=
 =?utf-8?B?VFlxTFpMUFZkTWlNVjhzc1Z2ZTNoSXhHdmk3cHZ1Q1VaOXcyRXZJR2NpZ1RZ?=
 =?utf-8?B?TGNvTVI4dTBqdDljczBPenl4d051SzFDQXFGaWJPdGt6ejFLMmFRQ0YvMGdX?=
 =?utf-8?B?OTFqVVUxUWtSaXV5THhNbnk1Q0Z0a0liRFF5Rk5XaUlDZmdGMTFVWlZyMHQ5?=
 =?utf-8?B?Y3RqZVdOY3dhQW4vMlRzenVCYmZyQ2dtQ3dDNmhvVHliaE4zNVA4MjhvNDVO?=
 =?utf-8?B?U28zeVNmSlJZc2dZWUlYNDNudGZvTmJYSzUvdFJsb2xlNlMxYUVxK056MVVC?=
 =?utf-8?B?dnNRNGk4YUtxV1JRZkdmZzBEaThmRGpiQmxiajluSUYrYUg0TjcvcldnMXN0?=
 =?utf-8?B?elRUeExXMExTWm1RTmgvcVdFTjFDbUxuRDBSU3dUd0lvVzluOUpiKzNCNUg2?=
 =?utf-8?B?SHZCa2RHeDVKWkZNeXJmTXBybG5oNUR3YkQrZEZtSE9TejArUVNsMDEwN1FD?=
 =?utf-8?B?b2V5NjNlQjREQ2xlRWU1OCtSUEM3YWxHQnNvZDhJellCNTRVbWtXeUdQWGt1?=
 =?utf-8?B?RGNIRlRLM3UrTFB0cTBJZkpJMmhtS3ltcFJwL0JxZGdSWThxOXRra0FsbVJE?=
 =?utf-8?B?d3ZIbW1odFQrZXVxUXdIa1JCbTU4Q0pFYytGU1pKbHpmL00vdzRlT3NHZ1E4?=
 =?utf-8?B?NnFDcmJsMnZGdW9tS3JBMVNnbG9JUmZoZHV1ZzRMQkl2V2xpWVQzdjEvZVhY?=
 =?utf-8?B?Q0NtTTZ3U2VmOW5mMFY1eSszSnRvcmFVME1MUklrSjdkNE12UUNBb3BXRVd0?=
 =?utf-8?B?WFpXU3EyWWNSUTlRS1NWTjg2cksrUXFlWEIwYkZXdUpER1h0bjJabkI0MElW?=
 =?utf-8?Q?QYwjykrlDXecLeCA63dR/Xwi9RPZh8JGryC+lk0oMvUwl?=
X-MS-Exchange-AntiSpam-MessageData-1: xkeTqVysng6r8A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2826bc85-af20-41f2-c655-08df1c887e2a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 11:14:26.9759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKWj/D5ovc0e5dnAkEjBvlNkyuvRpkz89JoZq6VdrtzSMQ9HRX0Kd1Y04aPGGmKpU83KSaMYbbbBZAXlioUrLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154
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

The upcoming r000 firmware support [1] introduces a new type of command
named GMC alongside the existing and already supported RPC command type.

Since RPC was the only command type supported so far, it was embedded
into the lowest command queue level: the message header actually
includes the RPC header and the code considers them as one.

This makes the r000/GMC support difficult to land without a refactor,
with the result of transport layer code being duplicated between the two
message types, and no clear separation between the RPC and GMC code
which are mixed together in the command queue. Merging the code that way
would introduce quite some technical debt.

Thus, this series prepares a proper landing ground for a new message
type by extracting all the RPC layer code and moving it into its own
sub-modules, making the `cmdq` module completely agnostic of the type of
message it transports. By the end of the series, the only mention of RPC
in `cmdq.rs` is for the `rpc` sub-module.

With the transport and message layers properly separated, support for
GMC can be added into sibling modules of `rpc`, and the transport layer
can be converted once when doing the switch to r000.

This moves quite a bit of code around, but most of it is moved verbatim.
No significant functional change is intended.

For the r000 series, this essentially means the following:

- Its patch 7 making `allocate_command` generic can be dropped as the
  transport layer makes no assumption about the message type.
- Patches adding GMC support will do it in dedicated `gmc` sub-modules,
  following the model set by RPC. These `gmc` sub-modules will start as
  `dead_code` as they are being built.
- The "switch to r000" patch will essentially operate on the transport
  layer level, i.e. `cmdq.rs`.
- There should be no need for extra post-switch RPC fixing, as the
  transport layer code will already be shared with GMC.

Overall, this should make the r000 series much easier to review and
eventually land, while not creating new technical debt.

This series is based on `drm-rust-next`.

[1] https://lore.kernel.org/all/20260918010719.1176945-1-jhubbard@nvidia.com/

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Alexandre Courbot (10):
      gpu: nova-core: gsp: cmdq: use element_count to advance queue pointer
      gpu: nova-core: gsp: cmdq: validate checksum earlier on receive
      gpu: nova-core: gsp: introduce and use proper RpcMessageHeader type
      gpu: nova-core: gsp: cmdq: group the RPC-specific part of send_single_command
      gpu: nova-core: gsp: cmdq: split the transport part of the send path
      gpu: nova-core: gsp: cmdq: move the RPC send code into a sub-module
      gpu: nova-core: gsp: cmdq: split the transport part of the receive path
      gpu: nova-core: gsp: cmdq: move the RPC receive code into a sub-module
      gpu: nova-core: gsp: move the RPC commands into a sub-module
      gpu: nova-core: gsp: add `rpc` to RPC message send/receive methods

 drivers/gpu/nova-core/gpu.rs                       |   2 +-
 drivers/gpu/nova-core/gsp.rs                       |   4 +-
 drivers/gpu/nova-core/gsp/boot.rs                  |  12 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  | 331 ++----------------
 drivers/gpu/nova-core/gsp/cmdq/rpc.rs              | 378 +++++++++++++++++++++
 .../nova-core/gsp/cmdq/{ => rpc}/continuation.rs   |   0
 drivers/gpu/nova-core/gsp/commands.rs              | 312 +----------------
 drivers/gpu/nova-core/gsp/commands/rpc.rs          | 316 +++++++++++++++++
 drivers/gpu/nova-core/gsp/fw.rs                    |  90 +++--
 drivers/gpu/nova-core/gsp/sequencer.rs             |   6 +-
 10 files changed, 782 insertions(+), 669 deletions(-)
---
base-commit: 896ed083362758b33c49a1b5e5a3423c5814d87e
change-id: 20260927-cmdq-rpc-ed5f850b207e

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

