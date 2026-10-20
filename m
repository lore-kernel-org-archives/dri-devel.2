Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68660606A322
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Du80hbmk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD96C10E44C;
	Tue, 20 Oct 2026 10:08:40 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16C7410E247
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 10:08:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGBETQv9kuRtpnLnBASPICoM1izvDGQq0CHp6F5wKd/vOkISVrwTxuQjDJ7N3EPzxIB26e1EUW5utBalDYD44iemaXba+BHB/3c13tPBgoseEgdOP4po9C8m9jz0m7DpDNiyzRX/XAxTl8DMaDyhULvoYbIiSQsicJ8/A8nNZJxuX4vd7hMuk4FD8vNkL/v6npHOQmXaPM5FZE8F8jjSyKvBhphV3dsqDKTGQQzn1/anhW6LrcDVtE7FmXbfSoBZELjbHRGlUNL6U1011ivsbcOagQJYWulQV+vrYFYsgNLxMMPzcvWWWm4qO743qbj9OEKA/L4xnu3UhAlLDOQJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAeyfjqUfOBJ8Mo2+J9nIzOpJhPtNiIegLIhmX3UquQ=;
 b=THPVIScK46vwqL+OXw0Rawl8g+wxD6Hj9/Ty1PJGTs+ZlKE+c4UH3ySVCT+M8LwXpNJrX3zA88MlztLA+iwcUkYPMhpcBkkI/Zr+63euORzpLAaV/4AgFGJLFphgtJ7AuKDcZad73qu/eEb4ICUrsvJ6nx3bXVToK1O7xr+zvxlc4C5Dy/UARU/h8pYLQUgWhM3JI4CO89qtkpqy9D/GEQ4oP68ItrPF4AA6E2FDk5LxF+ZOxB1vOOJwYFgzRmJBy3SbmIpU0eFphSzVkNfUOcf7n5cybg032XxVlW1gby4gh/BWz0YwGvJ8gRE+gOTyPuul+xx3NYlgm3gCfsPdyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAeyfjqUfOBJ8Mo2+J9nIzOpJhPtNiIegLIhmX3UquQ=;
 b=Du80hbmk9+FrZTQqCDyDEdIAwAYaeGhDJL+o91ciWjCQb6aGVFPT37a+/GaNaKwRUJG/u/idYHPFfy+pUfTmrRll9lok+qp+FeE3tXgZENswY9Yg7zdJY9WNCaCdBLggB2A2CwlMhQW2c2UBETUJflSu6IkrRVoWYNUEOxmD+A49hMUm6AJZqbBm6+W7jlfRWjBrVpCHXj62ya1Mx9/o9QfZVe3hLIN4vbLi4SS0aM4SDMhv0WOs7RholNgSRguH9YFDDtbWzz46HwAGBfUWQvZJxvpDYsnd07/s/mxgb/Z0veCxbSVlnf3Hz0FTQidoentJdP5EXv08TqvseyOJEQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS6PR12MB754991.namprd12.prod.outlook.com (2603:10b6:8:4d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 10:08:29 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 10:08:28 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v5 00/14] gpu: nova-core: gsp: prepare the command queue
 for r000 dual-message types
Date: Tue, 20 Oct 2026 19:08:21 +0900
Message-Id: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNzU4DIRQF4FdpWIu5XAZmcOV7mC74uVhMOlOhJ
 Zpm3l2oiRlTXZ7kfOdcWaGcqLCn3ZVlqqmkZW5BPeyYP9j5lXgKLTME1GBw5P4Y3nk+eU5BxUm
 BQxiJtfopU0wft6mX/XcuF/dG/tx9bxxSOS/58/ZVRe/9MVsFBz4hBqdsNALoea4pJPvolyPru
 xX/k9ikl1FrS6N0NNxJuZESNlI2aYQWMoJWCO5ODj9SAJiNHPqnsW4KJIKM+Euu6/oFg3Ja8mE
 BAAA=
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
X-ClientProxiedBy: TYCP286CA0374.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS6PR12MB754991:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a11e66-8092-4578-d269-08df2e921685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|10070799003|366016|56012099006|11063799006|261009223027099003|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: q0Zy2ZHp4MzYaAscJlsB1UN3GZRHFp0SrUnU10No1RST6SQ/A1ot4JmgrxWq1UslvlWcv1hWe/pi/zHcEuMO0alZLW6BVv3kkgHjG2ZlmjGd2VaFT7ECp12SRlcOwa60jquepMXSmhjLzNb6IWIYF5BHcSZU7S8aEdBd7WaKv09qs084v5g6DTnIVfYgltPet59HV5kg49vwrIJgoxxq6OVTu5CKKgb0klwIFpa+/iy/VTSGuCmfFMS3R+Uqjobccv64fvKKTIpxqw2Nk9Eugi/sTo0Y8xDISEk6+VdW/n/x6vwvPpycMkL3dzn4LYGxOscp8j7C9BtpyZwqhKkCX9RbuFDwUWVwUDRZ1VzZL6JhaUIxUmgdBYqikIZFa0iQMaArLueJ9rD1QfTWEdLlhhxJTO15Ay6wJsF1A0EzV4PPkGdozPg5/FhrLk6njQOqb1f1G79u7ZgQD3TY3/IR0KZcPK8VZ7Zn+g6AsR2ejRWYClR1AWdc3crPCzcIE7w8CrYO+ssAPmWf6HXi3fBRUQ2T3mWqRd+LESn3clCnfR3JNA4IJIOYDlDnSwShPVPF0/Txwhqh0aEPfakxVT0jUo6L+pUInbIX8BxBAeux/awXeDSEYnTmEK5/bA26erxsx/GcHfCb5TTxRdMa7FDKAjtoq1+qnHlIALgP4DEtQKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(10070799003)(366016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajZPZTF2c2NScmtjKzZGTEpQQU9jNEcwbHdOTHo3MFByaFlXMkNZUWlybWJJ?=
 =?utf-8?B?L012b2E1N09zamJrbGxKbERmQWJMQlE4WnhnZ3dUZk00SXM4WlpOb3RqYlNR?=
 =?utf-8?B?TjkrWGpmcmthd2M4RFhBbkp2Nm1OUjNRZkttc0s1cHlYR2FVYjVsTWNBbVh5?=
 =?utf-8?B?SFBWSmdWOFgwWHh6RjlIVTQwL2Rud3FsV0xkc0RQRG5oZDRRWVRLMGY0VmJW?=
 =?utf-8?B?ZlV2a0l2R3E3VnNwMnAyVERUN21rVlcrMk1pZmVGRDQ4eFJoY0FzTW5LR2x0?=
 =?utf-8?B?d0dlYmREWGUzbG5qVHNXVyttRzQxTEE2VTNkU2pxZUpxU1RSb2p2VWdIZ1pT?=
 =?utf-8?B?YnNySnFDOHIwMy8vS0Q2c3pkZXFOQ1QrVHgwR3l2SjcrTS9INTJ4N2RMR1NQ?=
 =?utf-8?B?TjI1eXRJR3kvT2dpU2tmM0hlTUk4OHBwUGF4Vnp2Q1FpOGcxUGxwWElQRzcy?=
 =?utf-8?B?WWJEM2lvYnpzUzJMWHFYbmtIV2Rxd3VYR3V6ek9aVFZGUVJnQ3R3cG9BaFdZ?=
 =?utf-8?B?VXVtR0JBSXhIQmIzTlI4a091TWlRQXR4U0ludU0rMGU1d0RMZ3R6VFVnYlVG?=
 =?utf-8?B?Z1o3VXZDUWVZMVMybFNaSHNoMDVBOG01Q2lKbmJYbkIxWHQ3NGZQU1VFVmVl?=
 =?utf-8?B?anJpQVEyWTl1U1RDb0M1dFZJWk1uangyaEhuSlBvSDR1V1pmTUJYYVZGUUxO?=
 =?utf-8?B?aFgyT1NlMUlRaDhnbjVETG8rUnl1NThRNUhaVkxpMVVEZkM0aDVmWmhmWVF0?=
 =?utf-8?B?S1VOR015MjFac0cyQ3ArNjV1Ym4vUmI3M0F4Mm5XUDFBUUx3a1RVQ2VSRzNE?=
 =?utf-8?B?WG5oSk9qUUlMM0FaUm8wQWFoZ3pBOFJKZW5DckZJTzlBUGJLUUJneW0wTEFq?=
 =?utf-8?B?NlBzTmdlcEhEeVlhWDZUT3BqMWtORHRDd3pGT3Myd1JHRnFXMXZDWTMzcUlo?=
 =?utf-8?B?QTN4UFdkU0RobE1Jc3dhQ1RCN2k0YXprT282SnFtTWI5OEdzRWlCWWU2NWRR?=
 =?utf-8?B?bUN2SGRLRVpLNVdRY0dqYTkyTDhabDcwOVI4aW9zdG5FWm5jUG0zKy9MUzE5?=
 =?utf-8?B?MFZ5WmEyNVJUbnZuNkFjbXZxOEpuS2pVRjU5azFPcE5EY29kV1ZBTmVvWHV3?=
 =?utf-8?B?Y0dSRTJCV24wR0h5MVMrWHduM1dtUStwQSsvc3l2ck4wRHRMQzh1L2pZRHlN?=
 =?utf-8?B?SkhIa1dsblNVNXdFaVRIcnpKNzBIZk9JVXZrUnkzd3B0YU1FSUcwRXY0dXpo?=
 =?utf-8?B?ZEFtRUNaNlRTOXNQS0F6bGs0bHBTKzQwdTdlTEF0dHUwMklkZzVGekNnYnYx?=
 =?utf-8?B?SXNkRlVJQW5uOUhscDVNZDRrVGl3OTRTVlF5Qy9YWG9yQ3IyV0RXckg3TmJY?=
 =?utf-8?B?WkkzVlhsV0I3bURQVmNDTTJuSlp6bml2ODVBS1ZkQ2NzZGV0MzJ6bVNHNk1p?=
 =?utf-8?B?emd1M1lMZUtraTNQNVlxSUVKS2IwVEtiTFNDTXZHa2RnSFR0VzhBSzlCTExH?=
 =?utf-8?B?NjNKUnhyaGtkWktXL3JWM1BESFdwYXhaYVNZWDdRMXpsWWpyRytQMTVxd1Rw?=
 =?utf-8?B?QVVaUEU5K2RiYWdWaUdFdU9QeEhmU2FwOWUyN2ZPS2JybytTZHpKaWlZdE9k?=
 =?utf-8?B?M1c0Z3FtMUdKbk1kS3VmY0pURXB6VWRvQmZDSURYNzRZOWZlZ0dvNVlUV1pH?=
 =?utf-8?B?RHN3Z3RYeENvNm5YK0UyelFwSmxrcmdiZXB5MEc4TUNEcVVPbGVBVE9tUitU?=
 =?utf-8?B?c3dwRXNrcDI4Z3NrUGY4eEJvTjBGZFVMOXlCSmlDeE5xL1cvWThudnRqY01u?=
 =?utf-8?B?b1ZJdFFMbmY0ZDlPTngwelBiOTNuTElGSEx4MHZmaVZwYjBsY28wSVVPdEY0?=
 =?utf-8?B?NkFmTGNCUSt4WWtXSmxBMmM3QnEwZEhzQk94WUVFSGZnTXhYZC9GOEE1R3h0?=
 =?utf-8?B?eUVOSmJSUnMyQkFiSGprRXFrcHJzSThMQ3ErRzB2eEFURkp6QWc2VWQ0TkR2?=
 =?utf-8?B?c3RvbkcxbHV6MXcvSGdjdDlRcjk0VC9FdEtMa1NWck16eFlscG9lZGJscjFC?=
 =?utf-8?B?aWtNNGhQQlEyQUxhY1oxWnFkaGJVSEdpOThyY3BKZCs3cEcydWNIMFJvZk0w?=
 =?utf-8?B?WlZtM2U5VzhVL2ZTc0U3bXFvVlBBSDl4NDVqendqV0dhV05rQWhlclM0TFBR?=
 =?utf-8?B?ZWxIZEg2dnJsVmlOSE1mVndCejIxbFd6ZklpRlh2TEhhMVpyK2h3T0M3TzQr?=
 =?utf-8?B?SkV5NWNmc21Id1YwZmJQYVhqRnVEdmdtc3dZS1JtUitPZm5xVWJ5NlBoSUVp?=
 =?utf-8?B?TWFINGRYbUpDZVFuaXN4V1lMcWgxd0FtblIwTzUyRUo5dmRVb2dIUExyUHAy?=
 =?utf-8?Q?3N4/RSVKHOjeCJs1gHt4Ww9x+/cFSDDIt46TFEO/jNU9n?=
X-MS-Exchange-AntiSpam-MessageData-1: ub4Vfn4oWm3CnA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a11e66-8092-4578-d269-08df2e921685
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:08:28.9060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lC8K0qqOAREMUNfFvilV5Jw8n9ZdWsihZOWARcOgStwAFVOfV8/YiSHvB0sCFyaPHgljcQY8CfcShPBxjbZAZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB754991
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
message it transports.

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

For this revision, the main rework is processing received messages using
closures rather than a trait. This solution ended up being more flexible
than the trait as it allows us to factor some code out of `drain`.

This series is based on `drm-rust-next`.

[1] https://lore.kernel.org/all/20260918010719.1176945-1-jhubbard@nvidia.com/

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v5:
- Drop `MessageElement` and instead use a closure to process messages in
  `consume_element`. This reduces the behavioral change of `await_msg`
  and harmonizes it with the behavior of `drain` to the point where the
  latter can also use `consume_element`. Eliot's R-b has
  been dropped on that patch as the code has changed significantly.
- Avoid unneeded temporary result variable. (Eliot)
- Rename `await_msg` to `await_rpc_msg`. (Eliot)
- Add patch splitting looping behavior of `await_msg` from its RPC
  message handling.
- Add patch factoring out `drain` code.
- Add two doccomment fixes.
- Link to v4: https://patch.msgid.link/20261009-cmdq-rpc-v4-0-c9ab8de1d3f2@nvidia.com

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
Alexandre Courbot (14):
      gpu: nova-core: gsp: cmdq: remove stale comment
      gpu: nova-core: gsp: cmdq: simplify framing error description
      gpu: nova-core: gsp: cmdq: validate checksum earlier on receive
      gpu: nova-core: gsp: introduce and use proper RpcMessageHeader type
      gpu: nova-core: gsp: cmdq: group the RPC-specific part of send_single_command
      gpu: nova-core: gsp: cmdq: split the transport part of the send path
      gpu: nova-core: gsp: cmdq: split RPC parsing part of the receive path
      gpu: nova-core: gsp: cmdq: move RPC message logging to RpcMessage
      gpu: nova-core: gsp: cmdq: split the transport part of the receive path
      gpu: nova-core: gsp: cmdq: extract await_msg_with from await_msg
      gpu: nova-core: gsp: cmdq: use consume_element to implement drain
      gpu: nova-core: gsp: cmdq: move the RPC code into a sub-module
      gpu: nova-core: gsp: move the RPC commands into a sub-module
      gpu: nova-core: gsp: add `rpc` to RPC message send/receive methods

 Documentation/gpu/nova/core/interrupts.rst         |   7 +-
 drivers/gpu/nova-core/api.rs                       |   2 +-
 drivers/gpu/nova-core/gpu.rs                       |   2 +-
 drivers/gpu/nova-core/gsp.rs                       |   4 +-
 drivers/gpu/nova-core/gsp/boot.rs                  |  12 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  | 461 ++++-----------------
 drivers/gpu/nova-core/gsp/cmdq/rpc.rs              | 415 +++++++++++++++++++
 .../nova-core/gsp/cmdq/{ => rpc}/continuation.rs   |   0
 drivers/gpu/nova-core/gsp/commands.rs              | 329 +--------------
 drivers/gpu/nova-core/gsp/commands/rpc.rs          | 333 +++++++++++++++
 drivers/gpu/nova-core/gsp/fw.rs                    | 123 +++---
 drivers/gpu/nova-core/gsp/sequencer.rs             |   6 +-
 12 files changed, 927 insertions(+), 767 deletions(-)
---
base-commit: 3497a403264b094ebd61b8b755165d56e7d9dc37
change-id: 20260927-cmdq-rpc-ed5f850b207e

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

