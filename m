Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A478C9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 13:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0E8310E02F;
	Sun, 27 Sep 2026 13:46:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="HG957JZX";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65C1810E02F
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 13:46:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWGXY1qF7s4SLuvnLIuWv1fk7H4wO7tYt7HHW4rAkN4YqOYo4AD3VJMvVb9JACrK1aJ6zH3nDNFdn0i7uOW/kFMy/9GqB8VI/XOskSy2w36m1stZFJcbVmdL/WgS1BcSfNq9Uc+YAIa3jkt7aldTpbD9uI0h2dzCq/GN7aZLQ78PY1UAQhWyWL3K5ZvI1QAc8yMpWKqIC+0hD0noRbuckVJa5U40jKReQ5OvXUJHBOHcOKtGFaG8cn32SqhFbIUG0hd4WrhEATN3/bZNGoPLdH4aMy/yKwSDFHNFQwaNSdvwNocyZSwz9Qcu6zu5NnO79tQ6U8ePbYZBP+U51hkYPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRt4D4YSNIUhiBpIoGDDq9A1e6k4PXNZT83Vpfz6M1s=;
 b=KdzzJKH7zi3e8fWGzmceAxRv5GAVmfR98keQ5XO2wZqRH8s0At6eIjWBSGvLx6x3UDllX86F4w3Z8T6/TaLdv/wvciljfzGsddtDpxQhVbycm2InjjRVS9FK/M/Zz/+gQMMKHOxv+xIf8TzY/5EtzY7NerRVrvlAi/XIPWNCBoR+G7aVqL57MjqQ+gVZEWywjJv3DNXb3BJMcAAkf/3g4/6UwwKR/vMWnRtV+wzSOA9yjdHjbc6Ts4P4jJGjS4H+eyZ1JLvCPFYTNtrUpUzdDyOe/cWRfUJar2HbxZCXaeYecSkIWr4kZqVCd3dMsxJKAld49hWtNzlBoFiJdvcy8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRt4D4YSNIUhiBpIoGDDq9A1e6k4PXNZT83Vpfz6M1s=;
 b=HG957JZXg2uINMGcmmYmYAL2+VVzWaH+TZWSZjyzHYuvGQ4Le3XHF51n98QRsDnyRlNOp7rnR9tj3Lt1lxgXZHIlOLJwSPQXI88vgCiZ7JbHjXttJXQtqHQ01heao7TNmG6nsrBjlRlSKIRs998LC5emR558fILbvIrWr9e3DTbtPHyezRbuYZ3zSzPCwmi6UTplJqHhDZgq7l7ilrD5SNgHvutux6aDaW+ruXIe7rGRNvbIhVyaIxoAq1OygYHumRKWssoLbreZPGp8d/tCqaFCmeOlsu8yFFRPu9Q0t0TzN2ucM+G6dC+ENQS/yk0evZfAG1bM2CjjSbuOui0kiw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS2PR12MB9687.namprd12.prod.outlook.com (2603:10b6:8:27b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 13:46:24 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 13:46:23 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v2 0/9] gpu: nova-core: gsp: prepare the command queue for
 r000 dual-message types
Date: Sun, 27 Sep 2026 22:46:17 +0900
Message-Id: <20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr0JmbU2ZpAKuvIdhUdpBxoQCLTYa0
 rtLcevyJe+/v0EgzxTgWmzgKXLgye2ApwLMoN2DBNudASVeZIOVMKNdhJ+NIKv6WskOZUWw67O
 nnt9H6t7+OLy6J5k177MxcFgn/zm+Ypm9P9lYCilqRNsp3TelpJuLbFmfzTRCm1L6Av9AS9+zA
 AAA
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
X-ClientProxiedBy: OSTP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:216::10) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS2PR12MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af1521f-4b08-45c1-6b04-08df1c9db83d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|10070799003|366016|23010399003|260925021911599003|260925021311599003|260925022911599003|10067099003|3023799007|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: aTE+6y1sdgTEjpwnjBXwOKz8SUak+kZ40lzBkbf8A8gHMylDzqVTiHJ5TdXwu1JnLWkkjmOt0Bu6T2wd6+M+xhKVMeLXMb5XY7Kntq6G+pxr5gHvpe+3Kv/cTWpZCoZhqNKpUcKoXv/mEhpgpHUMxKUxeg7Devykb9F8C3m0FAIrfK9CMF2eHJyVocaW+fEG1ZsSNGwoeheqgwMWYi+JXA5QolZCSjcVKWgCb4G5dGJjRvBrM3gqYqja7Xvx9ER6Lugcl0jkRU8u6/fBs3tLYJuvcOaO1oOwThS3paXaHrSLEKzfUQYj16Oa6GM7ufiJm1B9vX6Rcj+9bSb4W/MTOuxSnyxmOv765wCR2vcHpPMALHyiwefaFHKDcgAWcC7pFx63EClsAWIyKUDFngoDIWZTHgp0N8CryE57ZPWqk8e3WiIJ8niiiVog3mhzgGGlQEs0yDBOZ80/9RckeIPy04TyXm9oJ/zXQqXg9T2A1X0z6r8oYk+6S4sbqm/yUofxhXOnYR+L7v0j/u8QTmBB/o8b23Jyl472/aMmkfP5oBFKERiICvvE5oNHlcwW3mP7DqhS1JS7z636hUGc74eAkJLXXLqlfEF/m47MdRH1jqktn7GMMXU3cVpdgc77awu7gHCjqU7lNIsfJehNJ9IsAb2YlZXlUxJuIwLx/XltXcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(23010399003)(260925021911599003)(260925021311599003)(260925022911599003)(10067099003)(3023799007)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmVjVGlvMDZVRUlOQ3Q2SHdOR2dIbHUrM2ZXMHYyMXhhMWU5MU1LdEJFZitX?=
 =?utf-8?B?cnBRQmVKd3gra25jK3VTeHpMbU9NdWxTU0V1VUFjOVNVNEpKUlpjcy9Vd1lE?=
 =?utf-8?B?bTF2RGE3R2RUVjZhSDlTTk9KSjFwTFJzUHhwZm5KNjFtcWtETXoxaVBmbjAw?=
 =?utf-8?B?LzAyUW5wQ3ZhL1hsTFVLaEI3UTkrKzZXeExMbVNOMVQwSy94YmQ4eFRZN0s2?=
 =?utf-8?B?OG84R09WVzZUcG5lQXlmdTlUdDRDS2NReTIxWEFNU3ZoT0VEVTlZV253SFBW?=
 =?utf-8?B?bndLVlhYWVNqMjN3d1pyT1I0Y2VjY1ZNZlR0dVEzUldpN1B5Z2tiaDlUb3pk?=
 =?utf-8?B?N0tzZDcwUHFEbytmQkpncnVrelpPNUVoRHRIQXVNekNWaDNYZ1VCQ1F2WVdD?=
 =?utf-8?B?WTlKcXJhWWxKM0pNaXV3T1R2SU1EWmpXcU9kYnlaL0NXQks2ZGVOQkRiRWdh?=
 =?utf-8?B?WDFOaDgzU0VrNnpoSkJUZzMxK1VzYjdyaXVqVDlpSGJhSHVVdlF3VDBweGpk?=
 =?utf-8?B?eVppZmtVRm9vMkpEbmJ5MUh0Mk4yMVBOcXlNVWl1aHBCS0tBeE14aG5paHRl?=
 =?utf-8?B?bndVU05HSWxGRHRlbW9hdzdEd1pwcnpaMXRFRjQrRjFZS1c5NmswN1lzQUhj?=
 =?utf-8?B?a1J2VEhmdnM0eHMyd3BPS3NVR1kwRlY4QTkvOVdPMjVxcnFLbElOdGdxNG1W?=
 =?utf-8?B?VUhJMXNyTzVKU0RRbjBscS93d1o0RXg2YmovRWd5LzRpaERvaHBKNm9xUEN5?=
 =?utf-8?B?VlJwelJGMlR3dGxYWi9qRVJqY1ZDc094RXVScUVLWXkxRFVPRVR0SUNBQVMv?=
 =?utf-8?B?U09NcU4xYm1JK093bk8zczhRUCtaM1dkUXZFdjIzWmt1dlcxTERCN3oxSkh1?=
 =?utf-8?B?dXJhdlVJNDF0eEloc2pURzVxWDZlU2RHeTBadHU0OXpQcXZrbXZzM3RSUUNX?=
 =?utf-8?B?YW1UYnUxTlJvN2RlSkJweEVSNlBRWXNqRTBqZmliUlFNOGFVbTZQZU9lcEpC?=
 =?utf-8?B?Y0RTa3ZGbUo4QlJlYTBGU0t2aWJwV0MwRXhJU0haWUxidEhhaytSSDBHMDRz?=
 =?utf-8?B?WUFOTEQwR3Y0OVRpd2tOeWw5OVVVSmliRk1FZmpMTTBSRHVVeUtTMmY1ZHNG?=
 =?utf-8?B?aENtd1VDcUY1RFRnTzJTNzliWW0yaDlWeUY0dGRpTDBJZWg2SFJkbC9POXZS?=
 =?utf-8?B?UUZyRFgvNmUyV3Btam82RDBiS3JyMTQxTS9hZjVPYm02Q1ZPQXdUSGdVSFRR?=
 =?utf-8?B?U0FRQVR1U1pDcTExQ2M0bUNha3NuaHlzZ004RzREZXV3aHpNVVh6Mk1Kd3pi?=
 =?utf-8?B?M3h6QXNrd2dIVTFSVEZGSXdWRmw4bEkwU2Zkd1B1dWwvcmdiMjNzNzFERmxO?=
 =?utf-8?B?Z3g5N2N2aXdIRVNJZ2wvaVdiaFZuekYxVkpxWTBFU3pvMHYwWElPdHpmekpV?=
 =?utf-8?B?WmhNNVhhNEJYNTJwY3pjSm5Ic2I5RGZWVzQrR05POWJnTXNRdzdXUkJpZmxy?=
 =?utf-8?B?eDRmY1h4MllRTkxySDZQb0tqYVVUMkNTVVdrSEJSYUN2RlhXY2hnWWlrMDZ0?=
 =?utf-8?B?WXkvRnoyV1ZsWkN0cWVOMzlrZTBsMUFxSVZ2a3g0NW1yTDBlWG8vNk5qVHdj?=
 =?utf-8?B?RW5OcjE2b1d6ZElFeWZpZ3lDQTUzck5ndGFVRnRxYS90eTRzbjY4Y1FKU3FS?=
 =?utf-8?B?eUx1dVcyNHBUbDRZQ3lPeWJGQXFYMHR2M0M3RksvNHVlQW9jaU1NYzJCWU5v?=
 =?utf-8?B?cWhORWxNeHlyY010K251aGFvbi9VYkFRUmJtSGdISlA0N3Fid3VUcW12QVJG?=
 =?utf-8?B?SUtXZllCNHpleENnb2VYcnRsSGJGN1Yvd0hSdkJkcUlhVXVEVC9XeTZndWdz?=
 =?utf-8?B?aU51enZmSWtMSmRYL3BqWnFIR0xycUpic2VMS3EwTzBrd25XUWpMNVorbEw4?=
 =?utf-8?B?QTR0cmZQWmZmbDc0M3I2V0NUZjZWRitkWTBFUUlqVFgvbVJjQXM5ME4rb3FZ?=
 =?utf-8?B?S1Y5V1lGYlluMVVjK3Q3OFhuUFg1SHhBWW4ycWxxQXJPbDJhYURObHVld1d5?=
 =?utf-8?B?ck0zYlJFTDVMa3ZyZVFxaUZiU1pmMkdJcXNaTXJEUHhZMXduYzVKanlHRmIv?=
 =?utf-8?B?WTR6WlB2azBZMmJOL2R4dm85NjBtWWtrRnhXOGp1b1hZZEl6bEJycjNZVDJZ?=
 =?utf-8?B?KzZRQU1wMUY3QmZwamhKUUJJVkxWK0ptQ245c2ZOL1BVL0k1RkpFRVYvSWl2?=
 =?utf-8?B?K2d1ZnJTTWdpaGlVSVZKOVB1d2ZYMDAxclNOa2c1TElRYXpNZ3NKNFBJZUNV?=
 =?utf-8?B?SjdyL3ZETlczU0RqVG1uN3lDWDVuZUVtb1lkNCswT3R4NEhtRk1DZjFHSHVu?=
 =?utf-8?Q?Ud86ssuAbtI8LRTO5lfjYrmTkvnnkd4V+1tISo5c8QV+d?=
X-MS-Exchange-AntiSpam-MessageData-1: +QLaSpx57B/4Sg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af1521f-4b08-45c1-6b04-08df1c9db83d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 13:46:23.7611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UV7cBcBdlOf9xnDqlsRJ1oQ2Uu5nu+4aXQfXlr7et6RaTEF+jhPyRBmlHDLLX2swOyutqvvGcjdOecKF4be7AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9687
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
Changes in v2:
- Fix checksum on receive incorrectly using the whole slots allocated
  to the message instead of its actual length. (Sashiko)
- Drop patch 1 to avoid having to validate the `elemCount` header
  member against edge cases. (Sashiko)
- Fix incorrect layer separation in receive path, where the CPU read
  pointer was advanced in the message layer.
- Fix doclinks pointing to old function names. (Sashiko)
- Link to v1: https://patch.msgid.link/20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com

---
Alexandre Courbot (9):
      gpu: nova-core: gsp: cmdq: validate checksum earlier on receive
      gpu: nova-core: gsp: introduce and use proper RpcMessageHeader type
      gpu: nova-core: gsp: cmdq: group the RPC-specific part of send_single_command
      gpu: nova-core: gsp: cmdq: split the transport part of the send path
      gpu: nova-core: gsp: cmdq: move the RPC send code into a sub-module
      gpu: nova-core: gsp: cmdq: split the transport part of the receive path
      gpu: nova-core: gsp: cmdq: move the RPC receive code into a sub-module
      gpu: nova-core: gsp: move the RPC commands into a sub-module
      gpu: nova-core: gsp: add `rpc` to RPC message send/receive methods

 drivers/gpu/nova-core/api.rs                       |   2 +-
 drivers/gpu/nova-core/gpu.rs                       |   2 +-
 drivers/gpu/nova-core/gsp.rs                       |   4 +-
 drivers/gpu/nova-core/gsp/boot.rs                  |  12 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  | 352 +++----------------
 drivers/gpu/nova-core/gsp/cmdq/rpc.rs              | 378 +++++++++++++++++++++
 .../nova-core/gsp/cmdq/{ => rpc}/continuation.rs   |   0
 drivers/gpu/nova-core/gsp/commands.rs              | 335 +-----------------
 drivers/gpu/nova-core/gsp/commands/rpc.rs          | 339 ++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw.rs                    |  95 ++++--
 drivers/gpu/nova-core/gsp/sequencer.rs             |   6 +-
 11 files changed, 836 insertions(+), 689 deletions(-)
---
base-commit: 10a6623a24a85708650efad7be15182289403cd7
change-id: 20260927-cmdq-rpc-ed5f850b207e

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

