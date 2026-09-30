Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5301DCA5FC7
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B218E10F462;
	Wed, 30 Sep 2026 14:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="o9OeWF9h";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9511410F462
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 14:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIwZtMMJ0bfpU+/MGGK062pdRdr8IHtWSpoAKzt9Z8NhA+tAt8jLL9gmb2pji6WCo9rML8781vX3ipSqjALkzYWTHPLP0FRh5cfFNFcRoHRnr2miZNwNnumWHe8FA9e9WKjM0d8RLFdilPkTqGppBaS+MJc0Z2OJyLXeCjxYIzD6T4wtsJ8y4ZprfpoadGxAdFmh1vL/t/Wpjf9qlfN0zCDlcrgTdqdAtbFi4ON3Jn0/gcr2mUSiEQet8Qsgg6qxdKt5azzKGHOBvhGEIb9Ld2lEIG1oSAop3d/2G3yj10n5uEeW9K/4S5y/dtl5gJb77bhq6tDdgby1YP5IYnkfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQ9APqN/lZ35U9+oMCw6a72bug2p+o5VID34NGtvVac=;
 b=oul1qnQpNZuRqZnAPJqhMFw4ln+3tT+i1F7K0cOqJzlFGMywBZJTn6K6py1x85TwTeF+P6TyABXj53V0dfwINhsLxhmz3M1yJTKY1tvibD7mpAwyM4FNKwSo/5wX5j7LwMznNXLzrAWPIEmJfXcK3Qn2wRJ6in139kqwSgg9PNq67X9Q/9YlTp+fWiVkujfToe+Lz9TFPuIt6M7fQ5JmOOpOCLU8CaAUs5lXsQVnRqf29TiHCADTZnf6BZzdA9U6bzbfTXh55fatALMRmzs2KFgJLBY5HblVPg4FLiLNnSPIWag+U2llU7gJrrHFmEwGODE08+FUvn7dtS6/iNALBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQ9APqN/lZ35U9+oMCw6a72bug2p+o5VID34NGtvVac=;
 b=o9OeWF9hML1AFiSiW6+9qLQlbjtbfaL6c8Th0dMfULagrQVEhqP8T+eBL4i62C+xg/3+/aN4XB7PoigVeCRcxUBaIZcy8pgWYvqpLYuc/K/V5dwuff6sNqvsHmiB6T51Elt9WUXz8AG/TdPhihXFxlxH2E+UjR+VnO71KhezJFv4bWOlwYTlg7HqFDVZinjqr4w3V5/mmGNqUm/gO6VssYozSY8l3vveTysSTvtxhdJCeAKtFG2cYhXDN9G34HanBSr9Sj01lnAtFdPOy2gdusMsflULZlxlAmrObTcyMOxQ33aY/T6ZHjVyN1YhoC+11Y0nVeBZRtoH/9isMsxCcw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.15; Wed, 30 Sep 2026 14:56:55 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 14:56:55 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v3 0/9] gpu: nova-core: gsp: prepare the command queue for
 r000 dual-message types
Date: Wed, 30 Sep 2026 23:55:39 +0900
Message-Id: <20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyQrCMBRFf6VkbSR9tZMr/0NcZHixT+hgUoNS+
 u8mdSXo8sA95y7MoyP07JgtzGEgT+MQodhlTHdyuCInE5mBgEq0UHPdmzt3k+ZoStuUQoGokcX
 55NDSc0udLx/2D3VDPSc/LTry8+he21fI0+5HNuRc8AbAqFLaNhd4GgIZkns99ix1A/wzIZq6s
 FUlsS4UHr7MdV3fqIh1pe0AAAA=
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
X-ClientProxiedBy: TY4PR01CA0060.jpnprd01.prod.outlook.com
 (2603:1096:405:370::13) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8ce0de-2593-4d70-ee54-08df1f031179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7416014|23010399003|11063799006|10067099003|260925022911599003|260925021311599003|260925021911599003|3023799007|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: I2ItdsY1AmBemkMXDEbTy4ewx8qX7L8JqASvUjDzMqgz8BtFWeqcVAn8biHOFhuBDJN9m0n4UWydJIg9O7Js5QaftKtL4xuz8h3O1d3yLj3Zq/FdJ9YtRjgemfGDfPINNDU9/Zy3WfvRVHWS03yqioRcP2ACPQN96D70oq2VoZb1e7FH4/IoMuM+cCUgESwq3xtyGVau/86yQFKOGRwQfv8gWd7hckXu3f+FCZuS/N17JPUq6mlWF76aoVOaUDmEij+g4DAqMbVyrj/9YR+W9LZFRHsDM9lycc0yLY4XKZpDyrBx22Z9v5qxxKHBXFibaSZLqE2RGuZ5D0PQgJma72Xv1sxca6GHbILLiAJEqK5kpkcDIXJSchc+dJ1bQOlJ8utBHm94scFnfgg/P9TgHNSzpc1gXlxR+79TCzaZErMGQ8H17qZJLZ/45s7L4cZDr0b/sItU3Oa/E3X0WbFsGKH8/Zb06mjHjLKEH0FKgoin/1Hom0X4Ds6qMI873qKPXoplHKKFw2sVjySnK/Z5bFshqZ2DmMK/qzEbyqZ4k5TWNbKjCwwt7fR5J1UsePYdzG+6IPyiaHyxnXt3ajaeLC/6gnbs8bftEXp3ilC2BLrWiH+s24qK7og++nPGOMqzesohBwOjeuPiu9wBBH1ve9Xio5Q4PXatgiqjT1Rdyc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(23010399003)(11063799006)(10067099003)(260925022911599003)(260925021311599003)(260925021911599003)(3023799007)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czRVaVc1N1NTa0xyNDJsSzdCZzZqQkVUWE91eVdNQm9Lb1hZMlo0MTdQM1Nv?=
 =?utf-8?B?V3ZKcjRwRmM1c01RMTNrS211OEZZR3ByOUx3UVpGZTdwQXdVSEhHamxuTGh3?=
 =?utf-8?B?WUJlOFljOXZyVFNoR3ZRTWRSRnIwNW9tV3YxRWc2Nk9Cc0F6MmdEQ1NXck9x?=
 =?utf-8?B?S0NWVHUrTi9DS1BVQVF1VGNlV2NsK2VhaHpWNy9lRmYzVkFreldhNmhFenNs?=
 =?utf-8?B?Y1NqUTRvSmwwZDhaa1dmRzgwaHVZZEt0K3FLWDBxaDFNNEJLaTlTUWFGcjgy?=
 =?utf-8?B?emVxSjc5MDA4R3lodFhKQTg1THNwQzRGVkNkVHBWQ0tVSnB0OVFLU0VRSGd2?=
 =?utf-8?B?bmxxQnRnVUxFRTdyeXFrTjNXUEI2N21tdjZCVUlMakpsWDhnZm9CMTExSHg1?=
 =?utf-8?B?ZkxDaTh3MFNYMFkzQWtrSlBpMitaUUtkTnBGeFh5a3hpZ2FNYkZmWGo3T1JK?=
 =?utf-8?B?NVIveUphZ0taY09yZkpYWlhwZVFqaGxnb2FUZUFieTEvSjNaVXYycWw2ZGVX?=
 =?utf-8?B?cGJEaEg4N21yVW9yckZsVE9ZdzhYOXpTU1NJMnl3RG9JZHEwZSt2NWlwRW8x?=
 =?utf-8?B?QndGbDRXcHduTDFFcHZoY1VLaGFRb2Q5VWRQRUpuSjQrRUFsVUFUQXRRUDBJ?=
 =?utf-8?B?aUcxLzc2Rk8wajg2MXZ6d29QUWZrUWZseVdkR1lzQnhnMlJ3WVJQa0hIaS92?=
 =?utf-8?B?NkdwNjdlOXhDMTYyUHdKdjRCcWxZUmV4Y29lRDZWRDZraWdyQncrSzBJbmNB?=
 =?utf-8?B?aC8vcno3L2N0czl4Q3pMNGxqcnJId1VxTWV4bzlhUnFZcS9Va0ljd2dtMExI?=
 =?utf-8?B?R1R1VzltUWord1JlUmtSM2o0VEhPNWE3WDhsQ3IvdHR0NXlXYSt1bEl0RXNw?=
 =?utf-8?B?VEozbVp2Y3gzV0JJb1ZySFVoSXFtK1NzVmlkUHBtS1JpVkFBKzIyNVZUNHBx?=
 =?utf-8?B?Z3dEZ1Fackx3cGdxMHlsSFJyaXdJemlsb1FlR01yZHYwNUpuRG1zQmRqV0tz?=
 =?utf-8?B?YmVvTTVLRzBHL2w5ZzFMNFN6ZzJGMWhIdnhJSkJ6QVJMRU85R0RMS0FuTyty?=
 =?utf-8?B?RCtPanNjdmlpTjY4M3k4NEJiMXVXNVJaOU9Ba09tZU1VczFYNHB5Q1dBV0gv?=
 =?utf-8?B?UWwwVEZvcCs3eE8vK3hoMHNVSFg4bFByMmoxcEFhVDI3bVBnT0FCaVd1ZFAy?=
 =?utf-8?B?SmlCa3ZhMktxQjZxQk04cXRlQjAxNU5JR0NFZm1nSkVDN1czbXhXWDR1S1E3?=
 =?utf-8?B?WW5XWnFJK2VKaGNCamZWL2h5REl2a28yY056ak1SZHR3akZLbVpvdVp1RWdy?=
 =?utf-8?B?UTBXd21DZFJ6QU1nTldxZENCZFNzYU9QeTV2cW9QcndkNTI3VmY4U1ZwWXl5?=
 =?utf-8?B?UVBGNmVSb24wYVNTblMvcTN4dzdGbDNXZUYyWVpGdVJHUDVxNGY1T1Y5d0Rk?=
 =?utf-8?B?SGxmZFRtWldLZWJJeVV6U1JCbDgxSkNHNUtCcC9tUDNGZmxGVUxGejdwK2hi?=
 =?utf-8?B?a09mQW5kT2UrQkpiMnBQZGVHdDBYZk84TGdieXRjaGI1ZWkyZ2x1encvMENk?=
 =?utf-8?B?Qm1CTVR1Umk4STRHckpNd1RLMzQ5SVJyQmF2YnMvOUlhd2wyRUpzR3BaZEFy?=
 =?utf-8?B?ckM0Y1Zqb2ZLZDBTaDZkTkVjWUJaUWxiSmN3N0laOTI2VW1ucEdndE9QWUNH?=
 =?utf-8?B?SW5BK2VqT1JUTlN0V2dTdFJWTFp0aWRsa0d3dGlkVVF1bndSNUJaOUU1ZFUw?=
 =?utf-8?B?WHlrbWRUMW5IdXZJSkVFa25VcWsxcjdscXg4RmR2bkVGTGYvWHpHMGpGVFp2?=
 =?utf-8?B?TWVjY05FeSs0Tm1QMk50WDIrZkJ0KzM3MFJQQjNCbEVTSFphVG5nLzNyVUJI?=
 =?utf-8?B?RzNwZm8vOU03WThZb0VvQVhtMlhRd3Uvck9Jcjlwd2dPaDZqcjJncW5YalAr?=
 =?utf-8?B?Y0hpbXdQczBKRUpDVVZYTzVRYkRockowdjBtOFBoSTJYZDk0R1dsaGExWnJw?=
 =?utf-8?B?ZHBYY2hQdEFTSG1Ec21lMFJ2WGx2Wk95TUpTTWZTbWhnVHluNGZha1d0bFlF?=
 =?utf-8?B?U1loZUhjZVI2LzVDSkg5bkxYYmRjbldOOWQ1b1BENGJpSE8zLzR2N1dENVZy?=
 =?utf-8?B?b2Y0WkdRcFJ4NlBOblRkNWhvc1huWWEwSG1vNm51V0RRL013SDdKWEZ6eDl3?=
 =?utf-8?B?YmJZRzdzVzdJQTBoaWNhSzUzYTBQZFc1bnltOThja2VTUFByNUxRbUxkK1h5?=
 =?utf-8?B?UjBtWnJrTm54SjdEM1JCT3RwVk4xYkdBUjA1MlBsbnFMM2dxZndtdkZnUTFX?=
 =?utf-8?B?S3FYZ3V3SmlFTkJxd1d5OVd4NFJobUhNcmJaZ1VZTDE5ZTJSMTFnTjMwV3M3?=
 =?utf-8?Q?nQ0FxbJ/ZNQZBAdo9VRttI4YKJMKGSls5ha8bNeipwVHQ?=
X-MS-Exchange-AntiSpam-MessageData-1: 4IbBpOdLhToVnQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8ce0de-2593-4d70-ee54-08df1f031179
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:56:55.0178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gaJ9m3+moIs61e8zovBcc9NoL7oCMcoi7OYmMeNrBQpqovv4FXX/P1ENl04Vpbub7J/8pK1758RMEDyGv7VaSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
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
Changes in v3:
- Use dedicated `RpcMessage` type to distinguish parsed RPC message from
  the transport-level `GspMessage`.
- Introduce traits for sending and receiving elements on the command
  queue (thanks Eliot!).
- Split unsafe blocks, drop unused impls, and other fixes on patch 2.
  (thanks Eliot!)
- Squash the two move commits into a single one.
- Link to v2: https://patch.msgid.link/20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com

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
      gpu: nova-core: gsp: cmdq: split RPC parsing part of the receive path
      gpu: nova-core: gsp: cmdq: split the transport part of the receive path
      gpu: nova-core: gsp: cmdq: move the RPC code into a sub-module
      gpu: nova-core: gsp: move the RPC commands into a sub-module
      gpu: nova-core: gsp: add `rpc` to RPC message send/receive methods

 drivers/gpu/nova-core/api.rs                       |   2 +-
 drivers/gpu/nova-core/gpu.rs                       |   2 +-
 drivers/gpu/nova-core/gsp.rs                       |   4 +-
 drivers/gpu/nova-core/gsp/boot.rs                  |  12 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  | 351 +++----------------
 drivers/gpu/nova-core/gsp/cmdq/rpc.rs              | 380 +++++++++++++++++++++
 .../nova-core/gsp/cmdq/{ => rpc}/continuation.rs   |   0
 drivers/gpu/nova-core/gsp/commands.rs              | 335 +-----------------
 drivers/gpu/nova-core/gsp/commands/rpc.rs          | 339 ++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw.rs                    |  88 +++--
 drivers/gpu/nova-core/gsp/sequencer.rs             |   6 +-
 11 files changed, 834 insertions(+), 685 deletions(-)
---
base-commit: 10a6623a24a85708650efad7be15182289403cd7
change-id: 20260927-cmdq-rpc-ed5f850b207e

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

