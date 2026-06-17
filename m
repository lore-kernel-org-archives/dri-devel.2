Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC44CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 13:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5233410EA1B;
	Wed, 17 Jun 2026 13:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="bcAiha2C";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011008.outbound.protection.outlook.com
 [40.93.194.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C372D10EA1B
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 13:24:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OP2R78KPKyfHAXdA/s+xoE4NK0TSRNWA7GTgBzde3wIU3PUBSeoaj5fc/la+Mw9i1Gt0FeOfsVz9dj31YOFKoO2awUCLJb3v89JOYe/+5OWl7MFm0PiZph07NWWdYN4p4MQIpUaKhCY/gamU/4qYK6bT+zbUrRnTvkd+3uR4JOTNQRImWa14uf778Oi8TOK/FX6lwmRSxOMd39tH3D4MJVrowQ3Yhba4JWoaW+vwxtXm3Zsno5i8WdcdolEyIL9reTFUaC1kN9Xgu1GuypZ56vSQ04EVezjpMdPo99lQYU7oFt7JrOOSCeDZ/rrth/edcBpZoKI6MurhsZjXOEOt5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjbEBzcPqsDgPOKD3BR0P+a8IUAgHaZh38Se/qdzOz8=;
 b=TOYaLB0CiYaNqH90mGm7Eq/ugLNHPwJ0ep8xbrPsijWSRs9vY/bxn60OmpC5ydwQabiLGjMEV0A6pfcgLb6oA5XUSPd/rT3RuStsM/9K7m9n/U9JNpdqXu8v7Zy5unntHNspa6pe/ouC3Ut3MBg+gbpuzFjnjnvWsTqCnCVP2gYXVICRcW/oazAbgiMj44N7iwQ+Tkopr9p4lhq8FPDwn2FYCNwXihbV8bXCNxY/THCRtYNhtjH5gaoPoZnWsEXm+eRzTcfTY3TvNcwp/tBVBygN70At3o6an3wtJLQXvbYvzok6JL4Z9kc8If+YMU1DrCai+E30CMnwZW2kTBQX6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjbEBzcPqsDgPOKD3BR0P+a8IUAgHaZh38Se/qdzOz8=;
 b=bcAiha2C16OPG90RkpPXAxju8okgz+aIY5gIlBL12B4mJ70ZER8kVaMkuLYJ2AWAuP/DBgtRKX6wSXXH3kSsfyVgspeh+yoyWXCDyPFv0URoc0tq58HYAV/Y0j5CRAgTtUkKuZlvJip0+eu3UbGRLchJJpaA+qn1rHOQr3DE+4IDH/0yLhGRV4Nj7PqnnZ/uYT6rDjCvwOVcRYuId97h1LDALdPod617+CidvF2orJIxSq2Wb3IKWR6I3w56pcDR6OmxFHTVRElGsyjqpG4761ih1W/0+Y36WfJXKDMvCsXioJCeE+he0TZPVF6g6BGATW7l0fM5QwBhjWXr19t0/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 13:24:49 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 13:24:49 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v3 0/3] gpu: nova-core: obtain and display VRAM amount
Date: Wed, 17 Jun 2026 22:24:42 +0900
Message-Id: <20260617-boot-vram-v3-0-20b9ec5fe9f2@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ7CIBQFr9KwFvOhoYgr72FcUED7TVoMINE0v
 btQNzVxOcmbeTOJLqCL5NjMJLiMEf1UoN01xAx6ujmKtjDhwDvoQNHe+0Rz0CMFsAKEZMCtIGX
 /CO6Kr7V1vnw5Pvu7M6kG6mLAmHx4r2eZ1d2/bmYUqFXtgXcMBEh9mjJa1HvjR1LDmW9UJrcqL
 yoTRkkFwIyEH3VZlg+Wnjfb8AAAAA==
X-Change-ID: 20260609-boot-vram-00d5057102d5
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0093.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a0d74f-781e-4487-8577-08decc73cec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10070799003|7416014|56012099006|11063799006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: gGm6bJ7U8U7uOdwZCaMHXL/h8wKZXOCJKodpFEJNxCVsy+HpdyGmz3dsugmd0IA42Hh1iWFcQKm5W+yFQPhILSKhbLxZ7miCSJFE/OBJyI9UCJ69HoFTd60KM1w33SMcHn5DGEpkopWVuvoE3T9eOpGQExXcaLfn49HNULA0r9oHTS9wprADtV4YCzZaiX4pbIz8bMnFIVI6DOy1ERoB3/B+mEbCiGA0BxElE/LDZnrLXG/UdKz0UPteGZspdUyVA2qWPPlJIl0tw88darasZDM5a39azxR7rhkYDO1O5on6iX7XkUsAbObImemcwKxyiFkcE7KVVniObS8oldiUiuV4XqKmbSrmWkDYyiGup3/StRRTHqBJyeZ9z3VBXPgRV/4ePWcTeO11j1S3o8KpGv/CtLP4K7QAqzSSMuCCJpM3tWaVmKsnqjqsuopech/Ugia8gMhwr7oN3KHqYjc99fy5coEgmZtK0/RzaB7eG1XRoMUxdERz7PAAEz4l/L9GZBdvrvBNRFdQJTrwp0Ha2tO17eWR+7RstWZ8zLH++Rwu/brmdooA/STjEFqpXeH2GIOg6wjRcwxyFeGMpP/kms5GRvzWmHxgUm2nUqyCi0rzh3+kiVUBxgS83+BTT1khTLPibJNzTxunLG5gfLa/oh81Re99gmzWWvMeKQgxRlwtmocqn3VN+G0CYmWEdwnURO2yncNkS8l9rBih7Ffwug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10070799003)(7416014)(56012099006)(11063799006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2R6OVI0OWFoN29HUmI4b3g0NFAxVk53Yk9WdEUyNGRON20rMmFDd2EzUnBx?=
 =?utf-8?B?ZmYrd3dXcXdid0YrRXNDcGFNUCtoS0cyOC92Q0hITVhtaTJvc2F3SUxHRm4z?=
 =?utf-8?B?Y2VmQWNHeUxzNmlCTVFuOEo5YytLRi9GRTZhUGFjaUlHWW9kcWFLRERaaEtE?=
 =?utf-8?B?UHIyMUdEQjNtdnR1TEZDODVZc3BmNXJ0K240YWpsRzExNmxxNmJzeVU1R1l1?=
 =?utf-8?B?cFJ0Z2s0Y09PZWhTc0JxV2pXRUc3VlU5OXFoL0RqaTFRNTBCZUorUFBidW5V?=
 =?utf-8?B?dnF1M0ViazZKYTNyWkIwY0NsSmY2WmxFRmttcjJsNWhQVjRyQzBrN2JaTHAw?=
 =?utf-8?B?UXFTVkc0VTdkRUdTN245THFCRnI5UWF0RGlESzN5bE1oL21tdHpLZ1hEMHFG?=
 =?utf-8?B?cHNtdWVrZVBhMEJETGZKY1hTVWR0d1o1ZXN5Nzd3Tk9JRGdCSW0zUHBiUVJ5?=
 =?utf-8?B?VndjcmNXL084QzAxSVNpc1FBRHA5bTM0MlRiL2VzR0hEVlA1NWdPRXF4Yml3?=
 =?utf-8?B?QTJXT0NmWmZGQ1Y2OTJRYUJncHU3OGd1SjYycHNJYjdWdHExKzVNcVFDdzJD?=
 =?utf-8?B?bVpZU1B4T1duTm5Fbk9SMnBac2lCNWRobk9aaGZIMDlqTGZhNVc0WW10UUNx?=
 =?utf-8?B?WDc3WWRoc1U2LzZaTHFTQUU2RWtGdDdyZWZGRVUwY1FYeTdrSEx2a2VxTUFq?=
 =?utf-8?B?VVIyV0Rub3ZRNDFUcVFPcys0N245TXV0bmgyMmtXcmh1ZXMzeVpuRnk5ZENs?=
 =?utf-8?B?ZzdCdE1OS0V3QzRGZCtoTVNpNDVQT3VuOTBGZmxuNDhiSlhhZFJUcjFuZGg4?=
 =?utf-8?B?ems5ckNCa0ZIVzlEQjJHOVRxczh4dndiMzcwNkQ2NEZlak1nUmJYNUtwZHAx?=
 =?utf-8?B?SXpRWmRNMFdpWE01WmY1SFltRjJ3dlprbjhKbVV2dDhqYkp5bnZuVitHRXBG?=
 =?utf-8?B?NnJXVEs3WUtqYjdwbzZsakNxRUE4S1g3US9XdlNuN2hUaDlZbTdRMUptVUth?=
 =?utf-8?B?aWdZeE5DckNkaU03SVpYRWE0dFU2Sko1QXNBZnNwRmw0MVRlSkRGeDFYRmRZ?=
 =?utf-8?B?KzBmUmlXeXY0cEpzbDJhMzkrdmRGMjl5Ym1lK1hRWnZhZ0loa1Y2UDJhcUli?=
 =?utf-8?B?LzNDSGhTQkdaWHFLcFF0clI0N0FqUUtkU2p5bFJ1cDRQdnhXRDNvM3JLQlJt?=
 =?utf-8?B?SnNQZjVLVWd3eHcwa0dOSzIzQWl6UTNmNGlSUHlpbDZ4b3NweDV2ZEVCVGtu?=
 =?utf-8?B?eXpyQ1NqRCtxd3EyTE9iVGE4Tzl5dVU2ejBaczY1WFRmSzZKc2ZUdzUrNkZS?=
 =?utf-8?B?OTBCUVlNYmhiMlE1MmFjRFZ1MkxIdkdaU3hRRlFpTDhDNHIweXpQK1BZUVJ6?=
 =?utf-8?B?QTZaeVltUFlEcUVnaFNFN0V4YlZkSjNodW1rdTh0MVh2KytqN0ExYm1oWDdy?=
 =?utf-8?B?WDMyWXhxVUprV2JZQTlJZDZBNnhLdTYrVGdBaXE0NGhML1lITGlHMk9UTDlp?=
 =?utf-8?B?WHBENjVrOCtpMmo0WlRVWkREaUZrWTEwWlZyR01mL3JrNWtYamRSZkRRY1lV?=
 =?utf-8?B?N0p4RGoyQjNKMmhEWk14ZHdpUWozajgzVlhlQVM2Z0wzUThTcE12UThQbTFq?=
 =?utf-8?B?OWFMNTVNVUVzVnVIejFiZzdLTmhpdDZMaVBZd3BKUFk2RFdRUjdLYWU4aG9x?=
 =?utf-8?B?QkxhdFh1T0U3VitGZUlELzA4bmJOZ3RpcXpWZEp5YkttaTh1aHpkZm9sZUZs?=
 =?utf-8?B?OHNlRm9RSk50czV4OVJzeTl1VVE4Y2xlYkF3ZlgzUytHdkEvQ01GdDB0dnoz?=
 =?utf-8?B?YlNNQU05cTRKK2VGMlFjc2R6YjZ6Z3RERDdYZXBKdy9PcHNqTWdJZmVsczEx?=
 =?utf-8?B?T01ycmpQSmRLYjltU1NMYnhEMlJhTys5dGFBQWdTbXpwSnZMVEw1YWRGUEpW?=
 =?utf-8?B?SVJ6SUE3SzJnamIwOGpoai8xOU1YYjBILzU3KzJ4OHUxOUtZeFFNVHowb3pw?=
 =?utf-8?B?RGRtR0IrYlFYR2w2NlRFb1BBb010VFlCQnFOV2dYOGxMczMrMjlDRlJXZSs3?=
 =?utf-8?B?Y1pobktYc1AwRk82ZFoyNkRLdm05a0I5dGh5Rnk2cHkwWWJYL2FUdU04OWdX?=
 =?utf-8?B?ejJadHhDUHM1cDBRcUY2ZEc3RFdlQkwvMWRmUUxydHp2azE1QUZVWVBPZ0Za?=
 =?utf-8?B?VDBvdVJacHc3VHRlSHdNQ09WTVBma0VHUzA4eGRGQ3JWM0llcWVGOFdRMGZa?=
 =?utf-8?B?U0U2SytDbTNMUlJseGd3bXpmeXJVOEd5Qkd5V3ZjOEpFakR1MjRKYzNmTXBD?=
 =?utf-8?B?K2hWYzhOYjJwSUFOOU9NaVpXNVJoVjhRRU5UTnk3aW42by91UFdlQXYyOEJq?=
 =?utf-8?Q?5bBA0C5E+wF6YPLkgqcT7dmjaNEYTXl9YTfuX4yCHafik?=
X-MS-Exchange-AntiSpam-MessageData-1: zeiMjJCFXq1U0g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a0d74f-781e-4487-8577-08decc73cec7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 13:24:49.6941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtFKFUc+xFnQVvqx3kf8cq+6tbcpe/yunT5scS01qtPzUwz6HrYV6b+X1kkeep4BVc7DCFzCLTB8t6+wJ0a6qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727
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

This series performs some light refactoring required to be able to
initialize members of the `Gpu` struct from GSP commands, and makes use
of that refactoring to obtain and store the amount of VRAM on the
device.

This is useful as probe-time information to be displayed, but will also
become a parameter that can be queried from user-space once the nova-drm
to nova-core bridge is established.

This revision is just a rebase on top of the latest `drm-rust-next`, as
the newly pushed patches introduced some non-trivial conflicts.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v3:
- Rebase against latest `drm-rust-next`.
- Link to v2: https://patch.msgid.link/20260617-boot-vram-v2-0-15c979001c70@nvidia.com

Changes in v2:
- Move `sysmem_flush` after `gsp_resources` to avoid use-after-drop.
  (Eliot and Sashiko)
- Rename `usable_fb_regions_iter` to `usable_fb_regions`.
- Return all usable regions as a `KVec`.
- Let the caller compute the usable VRAM size instead of storing it as a
  `GetGspStaticInfoReply` property.
- Dropped `Reviewed-by` tags on patch 3 as code has changed
  considerably.
- Link to v1: https://patch.msgid.link/20260609-boot-vram-v1-0-d9382610507a@nvidia.com

To: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
To: Alexandre Courbot <acourbot@nvidia.com>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Benno Lossin <lossin@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: nova-gpu@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org

---
Alexandre Courbot (2):
      gpu: nova-core: move GSP unload state to a pinned Gpu subobject
      gpu: nova-core: move GPU static information acquisition to a GSP method

Joel Fernandes (1):
      gpu: nova-core: gsp: Extract and display usable FB regions from GSP

 drivers/gpu/nova-core/gpu.rs             | 136 +++++++++++++++++++++----------
 drivers/gpu/nova-core/gsp.rs             |  14 +++-
 drivers/gpu/nova-core/gsp/boot.rs        |   7 --
 drivers/gpu/nova-core/gsp/commands.rs    |  13 ++-
 drivers/gpu/nova-core/gsp/fw/commands.rs |  40 ++++++++-
 5 files changed, 151 insertions(+), 59 deletions(-)
---
base-commit: e655873885063245fd7f49f81cebfdfdef66a59d
change-id: 20260609-boot-vram-00d5057102d5

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

