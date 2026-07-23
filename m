Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60704C4453E
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63A5010E4BA;
	Thu, 23 Jul 2026 06:31:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="H68Z8Du7";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94E7F10E4BA
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 06:31:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HV7fYsAD4j1+Kxfcpp4YA6AB181udhNjPPQPdikslXfZwYFLcTToc1r3arey6UL/KpgAaWBgR/xPvGI8lc1HR7PeXZlr8UKKYPCSbejZi70lHoQx7xOFruMcb9wkhN/fL6wXaewegM5ZHpSdpDbohy8gltSWc5nGmTQyjb8u/O2cbosYxUF/ZfPSH0aZda+Nz9VXzLoKlCX/pDqXE4LjN80+7n4Rwk/secrNsxrkskIKNrcy2pf85A5HI4iHFHN+9qJNAUN01dbR21low+MEm5v0ejvV0xPxLpBkISfxaWag/NwVsAoFaDzmlQSbQAfeyIX7m3Aty9Y+xz8hd2nMBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxBdDRHE10r/NX5SMhJ0A/0pyGcTo3r9FP4k0E1HbF0=;
 b=x2ESgqG7iJQ/cErO4RmsQHMAPpUCajwcZFvFpJn+sMDOGK7U54ZNY26AL7siTi+3vGHwwGA+vzXTkyUb7whFRgGwmKdAAp6tGB1QaO3WrS+xHJNRXL0/NMZAVeLOX7rNk6Ph8yA8GxQnfUFuBWYT1M8bcWXdhmnaw5q6hbCbR551a1pbahvB7AgPL73gYN/br58vzrbLcTbJsncd/cFLqgTB4B5liPS7HipkLoHKgrpH8q6wwjRCwGVP+4Q3WF7eSi75IwWjStovVqhjIt9LZw5rn+/HgbdDpvi8TzHONfVIVDjCu1OfPfdm0+jYP0E+Pdpcifypgl9T4Nloc0fHdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxBdDRHE10r/NX5SMhJ0A/0pyGcTo3r9FP4k0E1HbF0=;
 b=H68Z8Du7yC6EsAIKMDjik+ZtfFqWjM6wuquf5ChI1E1FcSySW8l0oJJQmP7Q+XrsqFpJeKFvBD5Y26uz9ZSjFb5VA63VaNiRN4VPC4Z6TEcP7KcSWtkXPaZ4ld2xMieHXLLNZujmgEzyOU77EpB4AOBrLpn6cgYwE0YrbXSBXVGMSOYe10RrpLudNk5NNYiSYQWEyvtYiBQhTGX8oUE2U8WqTGzoUveN3kI87EHpYr/Q2+P6HngnQlWucyh4ZlxF0dAYIZZ8E9oPcJe0/Nin1vcsAsmbfHKmn+AwsZmhNTOeP2XI9mfYtlpAJUGv75QzhIingtisylknaHm+tSvspg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH1PPF0316D269B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::604)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 06:30:57 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 06:30:57 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu@lists.linux.dev
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v3 0/7] gpu: nova: Export parameters from nova-core to nova-drm
Date: Thu, 23 Jul 2026 16:30:38 +1000
Message-ID: <20260723063046.1265791-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0157.ausprd01.prod.outlook.com
 (2603:10c6:10:1ba::22) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH1PPF0316D269B:EE_
X-MS-Office365-Filtering-Correlation-Id: d9472fe6-62db-485e-d3da-08dee883f463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|3023799007|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ticssg7pVeC7cj32v/Em5kT8I0o4h2l3npVXcdgHiELKHEXD++4fXLILLzGKUZaMcZ34hpXklrYhFi+sdUKQQWiYSTU6SJCV32erbwLKnyfEkt1a3wadeMlO8jVpIzwYlpiRWlF4MwZ6ec1JpTZIiVKPf8WYiHxcIsTvKErIBN1EEIFnUfqoAsJVR4UwnUtYuCzvvBxTpgSaf0jeWzfFPULJZbj00mZDf6M1Yf1cq7WpmVSBCw7aQI9kMVFiauCb5Run48TEHG8dA+mCDDiDKA20EYmil8eeTBQgjL7VlAabhR0+FNb+IQyhIqUgo2D7WY0f2gU9i2p6oRuMqqqsDdjivNWv0XNCDAxakbGdefk0bJlx6kYQUGVNyluQArf4jyfb/PUieC8ecNneRbBlBGO05KMYsQ8VYUUw/kQqPXBAKgGXbBjpZ/DFy1TzIB5TTNpGFismIbsH910N+lJwyzrjiRe+BR1guaY0cvBuZykKPrgZza5IUl7VqSr8HUL3rcqLeT6ek/TcXQ+bYfdzMcBhSgvfcW1gJM+BRah/ce7XnMe8tbSfjcqvgBwdTyNx5jFsKkXy8twCswuIueOKsfAe7l10Mxdz5jbI0N6u7tQDcgzhIruIeohBjhZ2u1ZBZrUYJGuh+u/XxthaDxYmP3dXZwRlSJ2sDzk3AcOairA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(3023799007)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8q4zG5DfpsGqFJbkrr7Ch71CzbP614mgGVUGJuB50FmxStLVxjDbE5ngjo+G?=
 =?us-ascii?Q?ZnwhVLl5Vpr6S5S4eg9tZ4L4RHqf8jvNAPG6sKRuwX6Y+8oLOpcIk1919XyQ?=
 =?us-ascii?Q?lLoHls/lMW32WAYI6Rfux7cG54g6nNIw4YHtl2rRh+bH4cWkor32A3u1A3s4?=
 =?us-ascii?Q?YCyb2SSXU5DASqrD8tQ8nP+RMfjewUt42AhwAankbX+gQzYBzd4foMw43BDJ?=
 =?us-ascii?Q?AQEXS+0RBdtWKhll5lqBybq/lTLjyHEAn8Ijdp9h8lTi6vRUsnBSfvRTIwWD?=
 =?us-ascii?Q?MfdppiRAVLfqfKpcXX+s4fcWPuRDbuRql+CU//g/NjzsJq2e1THfIBKTHSoL?=
 =?us-ascii?Q?Gf3kfGV7r1Vo+xbT0h75oMcOja6nrHF5cPbEc1ba6ek7/5E9ayRGklq86YDW?=
 =?us-ascii?Q?R1Y1jzghdeLkyZcRDhS950sbfN7xsxRZCAtoQYw3sXQzfDtnfss+KdzqM9LA?=
 =?us-ascii?Q?XGAvISI1DHBv27NKWKwGR42ywdhF+INBKwFjQljidRjTnH3zn4w6d+YhsYPE?=
 =?us-ascii?Q?8DfjsnHf/ZgM+Vj1LvuuroM5Ut6IvHF/Qz/MtCsnAMZNsKYZekmandgDDEd7?=
 =?us-ascii?Q?qKIjuxe0rYJ1noW1peJH50Vh6zuCWUOLmxpSbrCFj0YMv5C0V5llVKsumGz7?=
 =?us-ascii?Q?tAB0Oh3XsLDuRjY/wqR5USEY9fY3odOXrQQUcpGl6Tks2j2LFb6TqdRNXJFf?=
 =?us-ascii?Q?/5G+im/KOaZbbCGGGMVf1gM28WnRGPl9xP/C32kUBs+b8gk16hnWBMy/+nEy?=
 =?us-ascii?Q?KjFH/+pyxn+QOI50LHbID2Mig9X8gaqD9jHtbqR2CPAgKXaK7AoURyLHqdH6?=
 =?us-ascii?Q?fKUXcM68ruqwke4HWW+yUGH9vOgVD9rmDJsIwZcRFUZ12ZXbqpzkIbse1sYI?=
 =?us-ascii?Q?aiXh6yCvWCcQ0Zurl43zynJeOMxOzalLnl5rOvjZ3UyiI40tozPXcTblZn4P?=
 =?us-ascii?Q?9wpFwHo2hrh0PMTziq81CDNpr4jv/g28W4RgLZ+E/0h2vPghd9DWwXw9YNm/?=
 =?us-ascii?Q?vzlMdlX6dOc+omn4zEWTUfQbZJl1VxSBwMsZ4gNMAEUUftCnNPu44HUpchuV?=
 =?us-ascii?Q?ok/E/lKPyuFg1vD69OvVmRxghi3KDr1oCYahAaGUyQ2BaVQx/bDWJSyYlgpl?=
 =?us-ascii?Q?Jtf6Xx7jYEhae3VyfLsDGi4C6bVIT6xq6N6+dI+DkeosR4u7y2CdHtVy5y1x?=
 =?us-ascii?Q?BBv1NV4seU/FXPq9O5xAOswMOddEhEkOVBfbgAT2mpII2ACaqwvJriYhQKdq?=
 =?us-ascii?Q?e9hKshscjMgVg6rMsUE+tX4tquL/PgLv/X1jGLShws1v6fuj4MyNR5JFB4Up?=
 =?us-ascii?Q?LTBd9zPnMv2lNdGeJKEMnIR3n/FbXkU75oIrmExvpEntdxiZOmFStCCZJ9fb?=
 =?us-ascii?Q?I6jWF1HRWEJhCc3VeIzkmisa03/u3y+yqphYVfdLuqrC+9nMSY3S+S/QqoGh?=
 =?us-ascii?Q?a6q50m0i7yaqNgv1RMqoGZhNMPTr9QjeQJDhRSKUjcutc1O4VdrMa4/EZIJm?=
 =?us-ascii?Q?m7COGqlqk/n1SM6PhSX0sd97iDNngq2yR8gDqpjiRfkDCga2rLEy/ZvYM/xE?=
 =?us-ascii?Q?SFTjd7ec5eIDJyJefmEV6tPAJ4Wyo5V26awR16ZkBK8DEPhQ3ROggKGk7XRd?=
 =?us-ascii?Q?HLCg6HAV2PEYcmwJiS+M6HSLSqD5jhOa4lELh1Vv8N/KcmirkB2C/QsW87Wc?=
 =?us-ascii?Q?Nj+702lR5GpcKdUPqtA2Pyj6pPbFy2wjYonZB3e1Riz2gpBY2NsVnS6X7o2p?=
 =?us-ascii?Q?5GLxDFcKnw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9472fe6-62db-485e-d3da-08dee883f463
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 06:30:57.4148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C33+v0Jmapd7wu7k/aANyfea6FfSzOTt+MIli6x83qCZ559dRVg00mtQ6UauFzj4x1+JDwgFDYghG+1zb7Qgzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0316D269B
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

Changes since v2:

 - Addressed review Danilo and Alex
 - Minor renames to better align with HW based on internal feedback

Changes since v1:

 - Address review comments from Danilo
 - Add an API call to read VRAM PCI BAR size using nova-core
 
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

Alistair Popple (7):
  gpu: nova-core: Add public driver API to nova-core
  drm: nova: Add DRM registration data
  drm: nova: Add chipid enum to nova-drm UAPI
  drm: nova: Add GETPARAM parameter to read the GPU chipid
  drm: nova: Add GETPARAM parameter to read usable VRAM size
  drm: nova: Use nova-core to read VRAM_BAR_SIZE parameter
  drm: nova: Expose a render node

 drivers/gpu/drm/nova/driver.rs        | 17 +++++-
 drivers/gpu/drm/nova/file.rs          | 24 ++++----
 drivers/gpu/nova-core/api.rs          | 49 ++++++++++++++++
 drivers/gpu/nova-core/driver.rs       | 44 +++++++++++----
 drivers/gpu/nova-core/gpu.rs          | 80 ++++++++++++++-------------
 drivers/gpu/nova-core/gsp/commands.rs |  8 +++
 drivers/gpu/nova-core/gsp/hal.rs      |  2 +-
 drivers/gpu/nova-core/nova_core.rs    |  1 +
 include/uapi/drm/nova_drm.h           | 47 ++++++++++++++++
 9 files changed, 207 insertions(+), 65 deletions(-)
 create mode 100644 drivers/gpu/nova-core/api.rs

-- 
2.54.0

