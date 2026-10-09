Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94727CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2C2C11209A;
	Fri,  9 Oct 2026 11:54:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="KdLeuU7q";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23ED210E11C
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 11:54:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F18rSKdRfbsMo851n7To3rGMZUhD70tRx7L+NQbHVX14Aq+8E1VA8YAc7qanjl+j6UWI/9R2vOgS5lsyNJihTcgwTfkONFN8WTyMaxrZBWpl/LvHEObEWtzTIG5+rjI79+BMwSOuovaMaNZP9BIT35CTnQYaqlJKMgcGZohV5c7+GMUOtAVSDzgd7tizVOuz2HKtQYI/9ccA1nsQEPj8AKoRGWTvpnFLs8NRcMkVo3DxVegOLRcKCgFaS7lsh9W5tAANh+weEptgS9c+yQm10fjmv+GSbbCNwYIwK73SiNIbumhlqvT6w0WzxrPEsUjEgmFQAZQmFIDwcf8YVCKZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BxAWKjrJbfRZeBhrTUrnu0K2K5MCfMU/qgGsC/pcCA=;
 b=BvSmwxqe75dPJMtZq6X9hho6kpHVPUWEo15SQvL4hwXyjRMLSiWcmYFqOOB7hCSpmUrpB0sgGEYGPX1ggQ5mcFFbvsZt5o0mCV3dhClaKBtKrBWjKc0PHq+UUWEU1rpCMl5/BRNW49iPAHWNoXCpSKcshWyQAmLhGH/GL+QiMgTALoiSN7HLqJOOk6N/LyahBYRk1slDEn2Sw9AekEvlyxUxT/73/U9349rtTYg7eTAMe11O3KH4rCWnUOVkTnW2Lpe/HwtPS8m6KulCddqgcRwJof38qwTf+SbSiIPf8e2QUKBrQ777QrUa3A3bUnuJTxkF+C8TCdYrmVtMzWKT2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BxAWKjrJbfRZeBhrTUrnu0K2K5MCfMU/qgGsC/pcCA=;
 b=KdLeuU7qgfaNqW0ov7fcOyTK9SowP6nu62H9g6oF6DM2K1ymESGB9Y5gGKyIJi+7gr2tor0lFP9mBVA4EQNNg5ZIGP70uuDK+GCKzMt8fWPxzAUwQnGdeCRcHogbWGw9DDzKx2/yqMEroS8dII8URUajXy0/pOK1pMCWT34JW23cwfONEnuKxbLULbDgzEqta9HEzd89neLlhF3eiE0UukN1VFVN9uZ9V7ybNlkAwysqmlfDcyi4p4TiPB1MWt9jYj3AC/A95JZe+SpEyy8ls0D8lw1KDOFvugRahIiY3dpEYdQIM7SI8OcynhnpdACKpBmrBuDg00h71PRt1KOtIw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS2PR12MB473522.namprd12.prod.outlook.com (2603:10b6:8:400::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 11:54:13 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 11:54:13 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v4 00/10] gpu: nova-core: gsp: prepare the command queue
 for r000 dual-message types
Date: Fri, 09 Oct 2026 20:53:56 +0900
Message-Id: <20261009-cmdq-rpc-v4-0-c9ab8de1d3f2@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNzQ7CIBAE4FdpOItZFkutJ9/DeCiwKCb9ESrRm
 L67VC8a9TjJfDN3Fil4imxT3Fmg5KPvuxxWi4KZY9MdiHubM0NABTVW3LT2zMNgONnSrUvQCBW
 xXB8COX99Tu32rxwv+kRmnP3cOPo49uH2/Epi7v2YTYIDXyNaXTauFkDbLnnrm6XpWzbvJvwnM
 UsjnVINVVLT6kvKNynhTcosa6GEdKBKBP0hp2l6ANc4wfonAQAA
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
X-ClientProxiedBy: TY6PR01CA0002.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS2PR12MB473522:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ba2d9d-30f1-4db6-4d1d-08df25fc0974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|56012099006|11063799006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: DXS0pveyWrMtpYyyF5Gs+pR38Lio9FGNfILlIN3kMAlE46Jmffr8pd9NmgCM0vkSFbBBlXolG/v/vCJRhNwgP4pzuLka8M/jF9bKCy3muCBe4IS/rHNpZoVzlPq2hoa3HEqZ4gPFqB8czmXUqWmbpos8ano8YZIttgNBT1CB5aqA2Ju0572qtpt6OcRGqHsMpj3h/U+oCrPjNVabHqqa5aqfp9mr5iuO3wKaX12OR6HKXWeJKzAmirXj9e2Mgx6a6aorCeL3OqBWUbVJPKeRYp6ZOWFoxuNDFEERc+AddPu6ONU4try6dWMM6iNXabkDrKMbusa1javN8VtiJKU1c4og1q2QmrpZhTX1xJDVA1MyBRme2O8fn2fEgUZ01TQYnEgvowNASr8w0+JANQ/axU9SX78ABygWoKC7V97W8WhuhsGMYUucQFuFWYkDgJil/0wYkLYutx3Uhna7IC3tWP6SgRP2j8wKEL/7ctExeYiqha+U7R+sAlepKIyEfvYTDHD+aD8LzT7WkX/pJCDEWdn25mpTry5KfR80RC/b54qdOGPZcceLDntexPrC+4XELBYgWMYjwDwbtKR1QDbllp7rViyzx3H5rnI5hKnl+yJRChHAmH/uej4xqK77AiRWDs+f8CzRx7TQI0bzSADHdQx9prC08zkLj6p9sTDdrsY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1AraTRDTEU3MlVla2ZmcndmNDhFUGdRTlVuM0NtQ0FCdmJZK2c5aVZrejVs?=
 =?utf-8?B?R1hIclo1dHhSRkpPOGV5Zkp0dkYrNkdod2cvdUsycEtLY09oZncxTkU1Mlo5?=
 =?utf-8?B?aVFHQ3BrSjBUUFo2V28rbXZ0MlJoaFZOQnEwY2JjbG12NkluN0hZa2drNlJl?=
 =?utf-8?B?WVgzNlpNVlQrKzlmdTBTdDc1TWFiU1daUW56QUFSRVZraEN0Zi9RV3FZU3Ur?=
 =?utf-8?B?NWY4ekdTWmp1a2FXT3NxUmltZmF6V2o1NlJCRHlyT1VJKzE4Zko3WTNpbmhE?=
 =?utf-8?B?QVY2clFGbE55R3A0VDVXZEFUaUVzZ1V2dHY2QWlWSVRNaGR6bi9rR3l3NU1H?=
 =?utf-8?B?QVpaNytIQUtMY1VLdEhOUnZLa2RlS1JjeExkYmRHbjlVOUZSOGNGK1ZSQnp2?=
 =?utf-8?B?UWg3Q09XOFB5TzMzYXg5UTdhNXF0Q2xXQ2kxc1FSY00zbHNoQXhIK3R4d0VV?=
 =?utf-8?B?Nnl1YklNdjNyREp6RXRoYkZKT0NCck9jOW9YbUIxVUc4dHRlSzNaWSs2VzB3?=
 =?utf-8?B?bmtCKy93ZFZ5c0NoWkRyTWN0RGZBQjduS282bzF4a1hOMklwUFB2QkZhS2t2?=
 =?utf-8?B?VittOHVLNUdyWkxBNExZUUJ5RC9mQjNnbktERkYrN2tKR3RVQ2NwcUVZMUdY?=
 =?utf-8?B?b2ZQOEU0TDNaVXJGakVJZjV0QWFUTGRTckdGcUkvVk52ekl4Wkw2Nkk1K0tv?=
 =?utf-8?B?QWFrVkRIcFVTd0VHd0FMYmhDU2ZMSUdJODAwdTFnbDV6NEFUZGE3TEdlWXI3?=
 =?utf-8?B?L1NzVmdDMVVzVjFXMm5kT0ErY0FiaW5TSzgzeExxZzZkU1BiWG11a1hEbThp?=
 =?utf-8?B?cndtRFFZbFVvQVYvaXBrMGYzWThQa3lEV2J6aXpZZllld0h3OEN5c0UxRnM4?=
 =?utf-8?B?ODFSWmxDdFd0U0t2YjJoR3RqMXBiNlU0WHYzQzBlRXFxUHNlbDdLTDdSNW5X?=
 =?utf-8?B?dXN1ZUNITHNCc0JrUjBMWWVDVXBCT1lscmYwL2Y4dmNoTkVwMDRyem1Qd0pZ?=
 =?utf-8?B?MmI2Q2lrV0FoWDRSOGhJVDdRMXRjdm1ON1E0b1E3bXcvTW9JVzlab05SNlM0?=
 =?utf-8?B?QXNtUS9TN2xKNlJXWXBpQXFnY3NEWWZ6S0NBWmFIenRKMm9RbHlKSkVnUEFU?=
 =?utf-8?B?ajJFd08xSW43dzB3azFWMFdrZnV6MnY1UHBBbjVJekp2Vy9SMnZGY3IzVVVR?=
 =?utf-8?B?S1ZTSHA4azFwQmRvVXRrZmJidjJiVEdqcUdlckNJUm9FYmllcVRUWFBEcWxG?=
 =?utf-8?B?ZzNLSmNYU05FVjV4NThUNjFJWUhLQnpUMnlnbks1M0o3dm5sZkY1REN6eHB3?=
 =?utf-8?B?eVYrSS9hbVluWW9JQW81dVF5cEw1UVNKMzdvR1E5Q1ZXbUJxWE81OUtpQW5q?=
 =?utf-8?B?MVVMK0VFN2tGQ1NZL1Q2Z2F2cjBmZmNRUW15QXA2SkE3M21yaWV2Qmw1czdM?=
 =?utf-8?B?clN5eUlSbWdDUytsY0FnL1UwcS84TWZVWmM0Qk9WOGgwV25jTGRObmpDb0Nt?=
 =?utf-8?B?U3U0S1d4bUpmKzFCTkMwU1AvYW0yVUlsTDhhRkNHMjZIRjdnYjlLUHBaU0F1?=
 =?utf-8?B?NjQ2elRuL2wzYnIxWWYxQkEzWnhXRUZMUVZFUFNodVRSTU00aVhJdzlCdnhu?=
 =?utf-8?B?aWxHZnhNTDZxWHlvYzYvUXc1czJRMU11ZUJ5Nk5DK1ZnL3ZYOGdtMldUY2hK?=
 =?utf-8?B?MmQzZHpOMjNnQ3poK0JKQkM3M2xESk9IWUJxRWtCVDFMNG1jMVhaMnErKzgx?=
 =?utf-8?B?QUNOZVlSZkhaRnpIeXgwNk9DRlFDUWoyV2MxdGZMaTVqNU9jK0U3TzZJNnNH?=
 =?utf-8?B?QXBSY3h5b2tyVmpqSitxclFVYWZKdHZvUGVRdzhZSkhqR21KajJoYzd1anZx?=
 =?utf-8?B?cENQY3VFZDhHaUo2bDJ0aU5XbXlLV01pK1Z3VktUVmxIUGdLQXVNd2xrMXlL?=
 =?utf-8?B?THFxWUhobFdYQ2VtbG9PSWJTeFVwTzV5Y3BOUDVyMEczLzdVQlkyR0M5RkJ0?=
 =?utf-8?B?ODJ5ZTNIUTNqMW1uOHZuWWlBU2xUQkZ1YWlKenA3MlFmZW1NTmdXcHJ1UjZF?=
 =?utf-8?B?YWFhUUtYZktSWndHbnBVOGltYk5FcE1LTTArS051ZUdzWXJhemgzM25PR1pH?=
 =?utf-8?B?eUtVQkZuTFU5UEFRdzhXL0x6WjE1SGRINXYxeFVHVHk3SWQ4bFR4VDNYOUNY?=
 =?utf-8?B?RGNyRnZkWERmLzlOdnNkUm9Lc0VKVzdaOWlyTy9QUWoraVV1RFNmWEFaT0Zr?=
 =?utf-8?B?aXVLNVUrVnZpblJtdXUvRGkxSEtQV3MvV00rS1UyT0tzSXp2WTZMWWFYRnBz?=
 =?utf-8?B?VEhNZml0WHlJcWlPVm54ZnRWRldKYVZacXUzSzFDQ1NxcmZVVXlndmNVbzh0?=
 =?utf-8?Q?S97gJ/vBrxYq/DzBJJZJEC2PlY4IrSK9BtnG5iGBmk2vu?=
X-MS-Exchange-AntiSpam-MessageData-1: BwnypqELDIyj0g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ba2d9d-30f1-4db6-4d1d-08df25fc0974
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 11:54:13.1887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06HFYaBWhm05tGMo0V7QZQvicZUGytN/UUTZUm+BP6gm/+I02Cn4sWtbt0eWWcM9tfDn5NHd5AyLeEOqnwfXzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB473522
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
Changes in v4:
- Rebase on top of latest drm-rust-next, including the interrupt series.
- Move RPC parsing code to `RpcMessage`. (Eliot)
- Do not mention the command queue slots in the public documentation. (Eliot)
- Use different names for the length methods of the message and RPC
  headers. (Eliot)
- Fix bug where the RPC header length was used instead of the message
  one to compute the number of pages to advance by. (Eliot)
- Add a patch moving the message logging code to `RpcMessage`.
- Make the `rpc` module only visible from `gsp`. (Eliot)
- Link to v3: https://patch.msgid.link/20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com

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
- Move `log_event` into a method of `RpcMessage`.
- Make the `rpc` module only visible to `gsp` and its submodules.
- Fix doclinks pointing to old function names. (Sashiko)
- Link to v1: https://patch.msgid.link/20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com

---
Alexandre Courbot (10):
      gpu: nova-core: gsp: cmdq: validate checksum earlier on receive
      gpu: nova-core: gsp: introduce and use proper RpcMessageHeader type
      gpu: nova-core: gsp: cmdq: group the RPC-specific part of send_single_command
      gpu: nova-core: gsp: cmdq: split the transport part of the send path
      gpu: nova-core: gsp: cmdq: split RPC parsing part of the receive path
      gpu: nova-core: gsp: cmdq: move RPC message logging to RpcMessage
      gpu: nova-core: gsp: cmdq: split the transport part of the receive path
      gpu: nova-core: gsp: cmdq: move the RPC code into a sub-module
      gpu: nova-core: gsp: move the RPC commands into a sub-module
      gpu: nova-core: gsp: add `rpc` to RPC message send/receive methods

 drivers/gpu/nova-core/api.rs                       |   2 +-
 drivers/gpu/nova-core/gpu.rs                       |   2 +-
 drivers/gpu/nova-core/gsp.rs                       |   4 +-
 drivers/gpu/nova-core/gsp/boot.rs                  |  12 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  | 429 +++-----------------
 drivers/gpu/nova-core/gsp/cmdq/rpc.rs              | 443 +++++++++++++++++++++
 .../nova-core/gsp/cmdq/{ => rpc}/continuation.rs   |   0
 drivers/gpu/nova-core/gsp/commands.rs              | 329 +--------------
 drivers/gpu/nova-core/gsp/commands/rpc.rs          | 333 ++++++++++++++++
 drivers/gpu/nova-core/gsp/fw.rs                    | 123 +++---
 drivers/gpu/nova-core/gsp/sequencer.rs             |   4 +-
 11 files changed, 913 insertions(+), 768 deletions(-)
---
base-commit: 3e3404c52370595e37eb5b942df169884f38a124
change-id: 20260927-cmdq-rpc-ed5f850b207e

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

