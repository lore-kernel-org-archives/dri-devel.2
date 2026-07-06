Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBF1C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 313EB10E2EC;
	Mon,  6 Jul 2026 05:34:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="RC5T3WBL";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012038.outbound.protection.outlook.com
 [40.93.195.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F68510E2EC
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 05:34:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhAINxukpl4BZ8hynukqfg1zE/w48FtUQkQ8I9Qr/G0FUle1Cz+Y4on8PsIijMcMxHRWek0DDJy5/dSuFg6sT5mR9BuMnxilnruuHKDo11jeOVkRAlbVazKWvn0xVOa2mwpO1c5hHaFwdF1sqLXpdbA6d8zqutycqjJMyyy4B2wYbn7OmDqtK2w/NvlAuqmHPAEc6kpWh6SWpkD3ffqjYmmLd/EmPVUID+7zGWLs7CjnzhcP8YP+uUT/l99ToIFPCLnEG0RYZmK/apuSgiFivUnkccSz9ZpB61aHYzjCN8yFX0F8Pg3GBgmsK8dvobcd8PazIWyyRdzZuBjo9NTy4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tpqbre7KF8aknIKEfTJ5ryKKyyyZ5q2YRQAkaPnu/HQ=;
 b=AdRfFESH6rrTcB6m7cJi0rm7I9+38JfdyboGHF2IH2fJ1nq4Ax3mKUV5gwdEu2gl2xBTaBdj+HFHHXTPpg6GyLAfkj5uHDSNvnED4I7PA2Bi31L4iOgiCxc4WdTbGRCk0y8xb0hZnpndnTZQxbh2eTIDF5eXv3o9ktuzHyfAyJ8IPGmwYDFEFbM04Z/ZRLWmv2PvSvEHqFcJpVzJuiCXw07s2bNeDLwPY6lfEum+s51+qUEXtTl8gfuQsaR3z91PdVs7Cnq2T1a14zTQuvhr5q790u6tCmPgv6pth2JBpq3LHKeQ0KEL+PrjnbubaGBEKGh3jvC8y85RiHJ8ZxcvAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tpqbre7KF8aknIKEfTJ5ryKKyyyZ5q2YRQAkaPnu/HQ=;
 b=RC5T3WBLoJjUBS/itCTp2MNtN87JUTqEle3CQQjDtnJEnLyRMp04hn/hzL7uQ/vLhfPznuqyAi9Sq+F9gkwdfhgHRbYj9UK50NrPeNxvAJehW1WSZwK3TzB4vrJfzHfxpP4gYPrS/+QY8Jx/ttwR937uwij8EB3lYJ9Odaw8kLZuxFWhpy607rLxy81Hok41GXOKVx1gBSjUACv9QLJZhMC6FgMimrEsDUSdHpiu4W4xUDhuLXtrdWVrGI15Y2wrt0sJvY5MazDzaswoEZzM/aEGVPy+JkArKi8ce3Z44tkaEi3YRJSHzXIj9l0Ik2FU2+hq1OHdZCZmnMhKp6wpLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Mon, 6 Jul 2026 05:34:28 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 05:34:28 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu@lists.linux.dev
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH 0/4] gpu: nova: Export parameters from nova-core to nova-drm
Date: Mon,  6 Jul 2026 15:34:08 +1000
Message-ID: <20260706053413.154135-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY4P282CA0005.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: b48cc932-4127-4ed2-e19f-08dedb203f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: isSZlPVmzmhfu8bg8kqWs6b5VGMAdpUAD2I7O9p0zxKSyokN1O+DCDvXEqIuq2iLwnQApob4N1GzvRaHuSgxy9f3w25uKNQZQcLZHI+K1oCwSs8v5lXx1A9CIT88/6we1rmtz+zXVXmhFQrzuy3x0Vbw53UXngvOmzJGz1sLJ58v/Wtqj8AP7P67Mfxlp3D1Y3gXEVvOCrRV5Bjps4ZNqptvCwXtCBc4cBjUjkQmf1LhyT114proJzDjQ/tG6F6S2GLWBcInAEuGodxOB9WlikJSimO8w7jGglkZMk9laVHupNL5rD/YCkxDvgE26v9VU4FUIVwZTo5jVonFfRytJD/YQn4L3Mhl3vOk9jwofO2hD20y/DT6RHudFPbbS01+yJ2m5eJNvL0QhFhkuPJw2uow+8COlz0xB/ipYEnCcMeF+w+ExXlx1+qLU/0qjJ5kXnTSBGxeJyfe1UnSPJ+JVL7fhyed+NCLd/+Aq1MODg0C4Gk+MDX2cCQAAvv5Cq8HRm3qa0cKXNdg6RqF+qCgdgb5FQ+8qQ27dc9WN3w438C/miQW8tUuFppcQJ46dKXIk2o5izxWYf311cUStvCk5KKTWCGMkxuyMbNYPMgL/mq5C1O51RIdRi2q/zXtBWTpXEzyBk+/twlAfIBJKKnvPClDAM2gzl6V3qIl4bbbnC4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Et2o+cRCdOCAa+Ecu3O8aqLpoSTmROz5uSY5+3F7BO68NGyilCD+oW/tUrox?=
 =?us-ascii?Q?L8BI5EkgkS7bRFi/O62fbJbiovDa92sYKuY/eK/9wWvjD0MgDJdsnyJoScpV?=
 =?us-ascii?Q?NAySKPBJtKQw9W+wS2aR3zFsOYDUznqrEvuuiVyp0rl9mOKq/SYH19kj/7fm?=
 =?us-ascii?Q?n9UpCHltBeuh+anFWOQcUaCUG4ktZ/RGFH62hX1MztkIRVYPi3Hzbz33nmRy?=
 =?us-ascii?Q?33d5FvoKUNj1ljA6gNU78S6LI2EWFKdhykI9TxzvtcRUMTrbsu5QVyCMCizo?=
 =?us-ascii?Q?L1NvdM2tQbLTHDol+mKy3AuKklTreaKhmwGXQeLoh65u2KzVQsHLZfCEefRc?=
 =?us-ascii?Q?jM4eJDgkre0KrtP/DcaEE7JPQrGUCHaC3pykYtp7USEHL61gj5J38ku+iwiD?=
 =?us-ascii?Q?dYktfOzAksqkt8DZbpYw6znfgAF6EXIOWNqhZN2D4qtWudR86pgKV99V3I3y?=
 =?us-ascii?Q?/h9FU8fD3QCpljA5TqxofGJShpz5y6M/KN18KDAPkkJsACyjvlbQok2EM3xT?=
 =?us-ascii?Q?lzVvWEmRd8ME5HVoaX/W/geUX4rW+bg9CQZWbfoEecPI6fu17M6KrAhaXRaO?=
 =?us-ascii?Q?S4cgWp+gGKwMX1VoILwvvvDy2CDJ/FjIa1J6RbGzWONPQnRhCzUY9HW/T/Fq?=
 =?us-ascii?Q?YPv4AoqBSd2w+B4qtfaWrtpsiJ0pEUvIUNzbmDafIRVyxIwHT6qYdIHJ8Z5S?=
 =?us-ascii?Q?L21KvtJf+ieRHsJT0bZX6CKn+UFWji6o6OyGkqRaZJhUJyQLBk/t/TiN7B4Y?=
 =?us-ascii?Q?71AXnGZFw7S0BAACzEoSiMxzh4KNqjWq5nYfM3curXYnZ3TaAxk2ee9IUYKn?=
 =?us-ascii?Q?NsZONPuDq6Vv3UgHrlT3y5qEMpYST1zptbUbmRuzrKav+ITC2RY77yxsEn4x?=
 =?us-ascii?Q?iuIGuoqCA8Hs+Gpb4grHbX3lnsK8wZsHj2UNzJmjCSHKgrD7HyBZwFHqMtGg?=
 =?us-ascii?Q?K6k7zjI28kriVM5ziDzy1AOEYDHqjImlhS16K/gfcVhBjNl92wPWSlLjRkdg?=
 =?us-ascii?Q?DMfeJ82NZYc8xKJQK1JupEESCoDQP0lT2mwAcPMlgcZii4tyWK7VHAfSBg91?=
 =?us-ascii?Q?nKMFrMpSkEC54yPNmrNwodppJhVnY/ZTqlysi9IhrSuYvFdvIwBQYPm3pTRC?=
 =?us-ascii?Q?Z0XiVz7oYk+qRXXG1NxFifvDJBMohm1r9PeAior3bWdU/dTk/OEcwTdodgO9?=
 =?us-ascii?Q?I7MxsFOiqVg9ooMfZl9mH6lyciMIpDOA+yqtuIWmqQW/aNEnjZ6OBSVoYKVi?=
 =?us-ascii?Q?FnLSJTv2bAO/rwZMkNNHicUw0ANf3dXE79Lcas+hQ/XI7xKdx80WAbUYGhsa?=
 =?us-ascii?Q?aLV0UMSAhHlTzaxDJU5h2wWnEnF2elweMaJgC9VxvTD5edMNY1R4XlWdS8nC?=
 =?us-ascii?Q?3H2daIDIBi/BYL7fuLuEtSNsqe4BUuP2Um2SsvRM9/8vzUv/7ODLn37amxS3?=
 =?us-ascii?Q?LX+Cdq6hy8b95vAbX8v6c92t0UvoMm5bWeN26dB5SruDqtDq74x/wEEEIQX2?=
 =?us-ascii?Q?PUe4DPKy9bpd3+iVDhzM0sCEC/BrTUlx5veB11gy3RdBgFaiJ3wuDTtR1Zid?=
 =?us-ascii?Q?quBtfWxO3/FtNzXUeoErask++BllM0Cg9+Z8MrnqjBcIy4XLL4iuFqvJGZsN?=
 =?us-ascii?Q?ANqRPda9iCbJ/hZXDQdsUv4yDElf0DClOvM8x0z/ZSdkmVMhgvAO/yCMKMWT?=
 =?us-ascii?Q?XNEN3I5miUEGzijPgzni9APqxNqV45H9KukxNX6LmTk7erOgeesLcA5hZUyt?=
 =?us-ascii?Q?g56Tcnch2w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48cc932-4127-4ed2-e19f-08dedb203f00
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 05:34:27.8366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRJBLjMLgs0Ym6ddGt6TgUJeC781W067+Fl4YdUIGCdVeNKCaNumcrd11GA0xv8P8XAXeTVHx6Ve268rNmf//g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714
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

This patch series adds some basic GPU properties to the existing nova-drm
GETPARAM ioctl. It builds on top of the "drm: Higher-Ranked Lifetime
private data" series[1] to correctly manage lifetimes of registration
data shared between DRM, auxbus and nova-core. It's also based on top of
"ForLt/CovariantForLt split, auxiliary closure API and DevresLt"[2] although the
functionality of that series isn't actually required.

A tree with this series applied on top of all pre-requisites is available at
[3].

Properties are exported via a new NovaCoreApi type which implements methods to
read data from the GPU. This has been implemented in a separate module to make
the public API implementations obvious and to keep them in one place. Auxiliary
bus drivers can obtain a handle to this type using NovaCoreApi::of().

This handle can then be stored as part of the DRM registration data and used to
interact with the GPU via the nova-core driver.

[1] - https://lore.kernel.org/rust-for-linux/20260628145406.2107056-1-dakr@kernel.org/
[2] - https://lore.kernel.org/driver-core/20260626183630.2585057-1-dakr@kernel.org/
[3] - https://github.com/apopple-nvidia/linux/tree/nova-drm

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

Alistair Popple (4):
  gpu: nova-core: Add public driver API to nova-core
  gpu: nova: Add DRM registration data
  drm: nova: Add GETPARAM parameter to read the GPU chipset
  drm: nova: Add a GETPARAM parameter to read usable VRAM size

 drivers/gpu/drm/nova/driver.rs        | 15 +++++++--
 drivers/gpu/drm/nova/file.rs          | 15 ++++-----
 drivers/gpu/nova-core/api.rs          | 39 +++++++++++++++++++++++
 drivers/gpu/nova-core/driver.rs       | 45 ++++++++++++++++++++-------
 drivers/gpu/nova-core/gpu.rs          | 16 +++++-----
 drivers/gpu/nova-core/gsp/commands.rs |  8 +++++
 drivers/gpu/nova-core/gsp/hal.rs      |  2 +-
 drivers/gpu/nova-core/nova_core.rs    |  1 +
 include/uapi/drm/nova_drm.h           | 14 +++++++++
 9 files changed, 125 insertions(+), 30 deletions(-)
 create mode 100644 drivers/gpu/nova-core/api.rs

-- 
2.54.0

