Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119F6C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 03:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF46810E441;
	Fri, 28 Aug 2026 03:35:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="I3ZUdy6x";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17DBF10E441
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 03:35:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSz+GCYupJhg5FPCEs3gwXzv/PmYPkJ/n9IEgI6/C3DLVVAYGP2cNt75g61r2AOGio3MGeWfeXfzJGuJHLQqYzNTq3FtjR+d6tBKCYvN2mDrrObH5PWXI0rJHTyPE5D3KaDHYJ5Ba+JNygrCnz/ELTXNlburhLhcHGmML4kv0iqrtYevKhSG6FQEjmdmhjHa6nmTfsSnK6dkw0vPg+vZAwLXR6gMMK5A2XvwWKomXwLPXZNpOxg9FtE4ABhBnzpkKT53K9E7YF8WCFTRRWv5OorLii+z7jDCeFZ7xgK7iHbdQXbDlxJklzhbdjRIirXoFVwyE6QgCbWRd5a/G3lbDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5hbgfoPiaowYbGcTvbp1fmNrP8V9wd+Yh/LxIsRPa8=;
 b=tURa/LHDtd5v1ep/ro82nxPiCeueYfjaf+JE7pbS+WHk12/GTIAC4YVE3JWej9T13lHHhgJOJuGTqzMteIYyP5YXXb3sAOoHpOJIo15AtydcEVt4Btpd8F3lfGG1nh813Oo4Yuj0YstEWDNeligb3S3lpnsVynaS/n5bsBlv7Q1aBr0PVYFBbPaLloDzCw1l+iA2g1XIbdcVUJU9w0OVKgJUMH9zc4ivjnFqUiwbftSh9xV/uT5M5KVLXbaVtAvXoDIBziqKA5tfj/pPu5WY4mLZpyCxInow9bOQV0sEnWBNxX6bXRLX5fc/WuS49Gy2Z9W9Gzvyi0zqCJdCt1Tplg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5hbgfoPiaowYbGcTvbp1fmNrP8V9wd+Yh/LxIsRPa8=;
 b=I3ZUdy6xOb1Ni7fRn7N7oKpPI28sQDyhB9hINbfq3t25Xe12jj+O/YDtHipjHWEpd3GXaCwABqGrg31kHqS8qbnBj8o17LaqUnytf7XMswF5eB3E7rGMbl+EDTAZ3vF+lv66RT+ZYIZDtbytVTGMmLfeqp1pkq6Mbk/00/+INAHpTLfBhGyOppNDyiOqEC136Oiv5ylJ8uAQ8Ylfv1FkmwtvnTe3aeqqiuoV523ApYzFwtnCHl55HjjShnQJK1RZJtVM4eUoDBxVEeaolpkUBz25iqzHqQfhQZHw8MD6HA6dBiht/UAH6+f4VbPFwRI53E2ct8ANgllecCnlnwiQdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 28 Aug
 2026 03:35:49 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 03:35:49 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu <nova-gpu@lists.linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>,
 M Henning <mhenning@darkrefraction.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH v5 00/11] gpu: nova: Export parameters from nova-core to
 nova-drm
Date: Fri, 28 Aug 2026 13:35:20 +1000
Message-ID: <20260828033531.1117754-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0029.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:202::11) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a2445f2-0b42-471e-ec1f-08df04b57400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|3023799007|6133799003|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: dSHIU2cAvcul0c31IhdAlfDtbIQCWTK7GL2niossEbHekB35wa/Ov0n8zyMJxDMBlgiBsDqXG4fDI5BuCFBb3KRjHdLgFjlRvz6a2rTmoedBn65tqo4WlEkF8KqYVp4/3x44PBNOLO9cxPxxtJUvzetK6ZikE46ybz8Hqxjwbr2sBX2dmXY4WdsbBBHHiv0CJOptywRkOVfcyOxZRnUjpq3yUbXvm+zBlT1VQNZ6pn0EQPBpFStfnhKzRo94lWJ4fA9pCbEl2593Couq4gNp14V4/XQBywDYCjRsJJanuAgH+AwZzdex7KsCo+52bcqCQpF7MwZM/zLWwO2TWLFISqOq1ykl4DbHmL5u4gcLCNjh8zV+lywbfOCYLAuKcWnyMfLDEEbqw31LHx1Ie5w6d3qnklMcVsV2q7A3AzxhUyQKZZs3atqSRJh8NwXsBR7jqYgyOs716jLN9t8DYGjAfP0ldKnGONXnxoZStmaXflXxUy+zcAFj75aPVy/am+KM1X9FT+HFSgdOZXdpEaM2l21cxRygxUn8MeTnCIkpTf4EzfN4GQsqJltElJQ0rPoi+ago7yZ6kv+lNcZYrcYMbj/Xk5MLSlcB3MmpNFJg+bZ10+b9KzRI19X4I6i+Q6Zy8H5smMGM51BF0mZB7MUCMRY+WOgNPOrJYzj4771fZHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(3023799007)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BsPGP8eNnWzViZ3qfc6LrlNaXTD0c3MlNszMOOEUbtpKMDPuzyq0ucUQsr9x?=
 =?us-ascii?Q?MUxX+cJmN/wbTDpnVrMqyTfvvkqSuQzlEzExAlxwR0vJM9QTiLGCX2kc8UV1?=
 =?us-ascii?Q?iImca597hy7K/Ob4Z0tXbUFi0NlEDsNYjtp3rBLuC8OLQn3QnPNGvpldsrJH?=
 =?us-ascii?Q?fTw2MuoZk/Jxd1I6hTmRGr7ymxZWyk/bsNy77o6cUkiyM1jSQy8pEvPp/P+U?=
 =?us-ascii?Q?liJ9P2cF5gawKG0AXV11xruKH60TslJF7bixt9H7EtTp+3WXFAZ1R4vEM7NM?=
 =?us-ascii?Q?OVpBzixc0XTMk0Ujr3CaHjcgK4mS35RprShOF023rp0CEvk8C/Mcme1ShWpI?=
 =?us-ascii?Q?qaY+ga+AGUtSkhXD1Prv9yX+frhTDzFBngoCdgXuzJZsfC5FRIFOuy1rRuCj?=
 =?us-ascii?Q?wN+N+FSpzk9SPCAgbgiqHbnwBHxTsjpgV+f8vKPdTeXLjhRZaHOp+qDCeCJV?=
 =?us-ascii?Q?ulEOKiawQJLsQemWNdyPjDWjtgz9Ktljn/sJLxNCAvRfJfwbYz2yK7Q66iLV?=
 =?us-ascii?Q?zixomnwl3pvRnQSQjw/KCedhefle94XThSK7f1LbB9ixHMHBWBF1lf5ySXZF?=
 =?us-ascii?Q?Cb7H10KpimnOgl0KmaikY9q8a2Axs5dzfysdO08PjKJtXC8tcFR7UC114f9h?=
 =?us-ascii?Q?zrH2vIdudvcOAnlHSmzLJOgkzPAkTG4BIL7jBbP6HwNhaxxCIBphGG6zvJ5/?=
 =?us-ascii?Q?zuDuHeOkaCKIOa9tANoLRoMj2F7UudsVOeIdwNVASJwlAyF+kxZF0GpsYXTM?=
 =?us-ascii?Q?SK1FE5Xo3NlxC+U2ml4BC+BDwPQyOjMWiIrC0GrPYtGRCiytz7R/QRjrymqC?=
 =?us-ascii?Q?5HznzwmLXNZa+ReXRt4fpWW6AEiHsepNPy8VLrgvk3sYgPQCD1/nOtseQnpq?=
 =?us-ascii?Q?xhEoA5mrsP3TiUx6yLiVo7q1Ams4xXCyfkJeee9CE2uLThPCdpnmgxO3dK7E?=
 =?us-ascii?Q?gE7otQUzAu8WJYtvatzmZxFyZ2dHnwfBvzAcJTqh7lZjLLJGQEFYUq96SGlb?=
 =?us-ascii?Q?pbP6/CX/sW9m0zT82H54lNu7i21ifRY07Id5EYiS6HDKpjcfzk1HanL2ri2M?=
 =?us-ascii?Q?o8nt5qUZEMherYiF+XjddyEV2ZrZ4M3JfYr4jdHUIOEivd1zvd2wAh+IwJ0/?=
 =?us-ascii?Q?4+12kiZd9E8bYhfxXZGHnkMdxaBrUFtQp19o3LaYoqXhXQcQL0m7nPJvxWen?=
 =?us-ascii?Q?yYYLvwseFjlk3djnM3SuFP2HjRJP/C/iA61cc2szECcgKoVyBhqpsRv/qQle?=
 =?us-ascii?Q?7EP2vbkpqPA6JhU4ukpt2F0aN1kD4F0GbXgRYUTfdjZ3h2ubngnmmwj6Q8Ce?=
 =?us-ascii?Q?XWZujnT9wdxTAjRtKdBE5eKxuiE3XpEk/754GGbJrP4VdaXfOggRTZ1M12Vf?=
 =?us-ascii?Q?m7LhZX/RUbnUeAGeAg7+uOyH9S/K1WrfrW8Oam+KxAIIRpFWJYG5LTvq8Feu?=
 =?us-ascii?Q?P/wiABWgXMUP5f08a4kDlikYmnJDQFumg7nmXRUcRA+toeZIgHQDUd59KhSI?=
 =?us-ascii?Q?NI8TgnTHFD53dGPbri6hntMbbbMPJsVjlQoAjZLfw+Ku/o8Rx56eVz40WpkX?=
 =?us-ascii?Q?g7hm9XY8rGjywVts815VdOwIRHUXCKrfjclRIsadVgLzZ4+FtUUvFsCd30XF?=
 =?us-ascii?Q?nbgbx6Z4LwrPz8O02p5ooT3Yv4D/7JTNwZ7nd7Pvyy6Tz+xZ8wSYKFhJG+h0?=
 =?us-ascii?Q?vTiOKC0V2Jm2g+zNxgF+67cpUTW9+4VoJAAsOKNI5iBgorV5r5g8cxja44GK?=
 =?us-ascii?Q?Sx1qkchSRQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2445f2-0b42-471e-ec1f-08df04b57400
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 03:35:49.4605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zQVuRtanoBDTXHCwAPjH3mUuBX2vxf/d2yMrfSoQoieU2KWOMtfZjciHBvoHCqPkZLfbmw4HVpgXzK0KXnVUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919
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

This patch series adds some basic GPU properties via a new GPU info
ioctl. It builds on top of the "drm: Higher-Ranked Lifetime private data"
series[1] to correctly manage lifetimes of registration data shared between
DRM, auxbus and nova-core. It's also based on top of "ForLt/CovariantForLt
split, auxiliary closure API and DevresLt"[2]

A tree with this series applied on top of all pre-requisites is available
at [3].

Properties are exported via a new NovaCoreApi type which implements methods
to read data from the GPU. This has been implemented in a separate module
to make the public API implementations obvious and to keep them in one
place. Auxiliary bus drivers can obtain a handle to this type using
NovaCoreApi::of().

This handle can then be stored as part of the DRM registration data and
used to interact with the GPU via the nova-core driver.

A new info ioctl is introduced which provides an info type field and a
method for reading extendable structs containing GPU information. This
series can be tested using the drm-test[4]. A pull request containing
updated tests will be raised once this has been posted. A pull request for
Mesa has also been raised but is out of date. That will be updated once
this series has been merged.

Changes since v4:

 - No longer export chip-id, instead export architecture and implementation
 - Add a separate info ioctl with types to read GPU info as suggested by
   Danilo

Changes since v3:

 - Use an ioctl to return all parameters rather than multiple key/value
   queries

Changes since v2:

 - Addressed review Danilo and Alex
 - Minor renames to better align with HW based on internal feedback

Changes since v1:

 - Address review comments from Danilo
 - Add an API call to read VRAM PCI BAR size using nova-core
 
[1] - https://lore.kernel.org/rust-for-linux/20260628145406.2107056-1-dakr@kernel.org/
[2] - https://lore.kernel.org/driver-core/20260626183630.2585057-1-dakr@kernel.org/
[3] - https://github.com/apopple-nvidia/linux/tree/nova-drm
[4] - https://gitlab.freedesktop.org/dakr/drm-test

Cc: M Henning <mhenning@darkrefraction.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Benno Lossin <lossin@kernel.org>
Cc: Gary Guo <gary@garyguo.net>
Cc: Eliot Courtney <ecourtney@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: linux-kernel@vger.kernel.org
Cc: nova-gpu@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Cc: rust-for-linux@vger.kernel.org

Alistair Popple (11):
  gpu: nova-core: Add public driver API to nova-core
  drm: nova: Add DRM registration data
  drm: nova: Add GPU architecture enum to nova-drm UAPI
  rust: uaccess: add UserSliceWriter::write_truncated()
  drm: nova: Add an info ioctl
  drm: nova: Add usable VRAM size to GPU info
  drm: nova: Use nova-core to read VRAM_BAR_SIZE parameter
  drm: nova: Expose a render node
  drm: nova: Report GPU name in GPU info
  drm: nova: Report GPU short name in GPU info
  drm: nova: Report GPU GID in GPU info

 drivers/gpu/drm/nova/driver.rs           | 18 ++++-
 drivers/gpu/drm/nova/file.rs             | 83 ++++++++++++++++++++----
 drivers/gpu/nova-core/api.rs             | 68 +++++++++++++++++++
 drivers/gpu/nova-core/driver.rs          | 46 +++++++++----
 drivers/gpu/nova-core/gpu.rs             | 43 +++++++-----
 drivers/gpu/nova-core/gsp/commands.rs    | 27 ++++++++
 drivers/gpu/nova-core/gsp/fw/commands.rs | 12 ++++
 drivers/gpu/nova-core/gsp/hal.rs         |  2 +-
 drivers/gpu/nova-core/nova_core.rs       |  1 +
 drivers/gpu/nova-core/num.rs             |  2 +-
 include/uapi/drm/nova_drm.h              | 82 +++++++++++++++++++++++
 rust/kernel/uaccess.rs                   | 14 ++++
 12 files changed, 352 insertions(+), 46 deletions(-)
 create mode 100644 drivers/gpu/nova-core/api.rs

-- 
2.54.0

