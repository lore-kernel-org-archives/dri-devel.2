Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38727CCFA13
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 20:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8FE910F61A;
	Fri,  1 May 2026 20:58:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="aUDhBco7";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7575310F5FB
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 20:58:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kROTY4n4+xf9c8lFjFRgchfLuAymQdtBM1pdILa4n4kVcWrR64SvMwWCYj7IoQFAU+1Y3UcVs+/1dCl+JKDnSk/YxCKMXNkFGgr8Ky5/OdZVhqWpRGcn0ElYr37rm4y2gLj4ljMTrQZUTG/mULqzZYJxryM7EHg0zMfETz3cXSB6ikcdN5Hc2SxVnfw6T+pMkik0yUmwniiz/nRLyd2GQF6XkUNSG3LgIIiRAyhZmk/B7xbipB6RgXBABS1GApH7KVyHkPujLoHB1P+ew08Z/Oz73m23iwGTut9wd7GEWJ4etrsnyBX3/a2VOkSh/pYAC8VI9kAoNADi1V52hGXXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXscQzbTbBQ+aIzT45RVaJoPiCxnlVtnt1R7y9QF234=;
 b=dqaw9XscwAr4TMrtEnY2HtZ9VOjIR6gx0V0P0PEX+VUacCNjWrBEfAtAX5F0vZE8MZjmo4/BEthNJI60PtnNg0f4yAAxoKyIFfRmbBbeMaa1XxpHdcCaCmjYNaRrGFD1kphtrk0iEpUa1ofQjBu1X/HDGIiZ/odQ3ncXVNVpP2OQ5PAF9/JMYmERjQd/FvpH0LwEL/oZ3jIVX9T/LMbtt4NhjWfRivO/4MpoHbxviFscn2/3XettxUOenydg63cYeLtMWxC5UovAaUFYdrqKpOdMjmwiRwKwnyGx7Imw4paLlCKk9E/XB2ihnOIpDijhGwtX6WZUfeo6AdPsMznhUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXscQzbTbBQ+aIzT45RVaJoPiCxnlVtnt1R7y9QF234=;
 b=aUDhBco7YKZsCTTLfg6MxKUxArr4NKwOx3vIJgqTPdh4IFqVPlX0pIRILVY0IbMo+6Q12LUjmV7LN8cgwp1aq4Ut2nIjadXwYKV+GVyjDTPMu8L61BC6q7OlhQ86D8/fNPKpavfeNdnO1CGFPqnK9QTSPoFi392UIsgzExgFuIAAfpO3OX+lts3vnptJibcAn6CynOY2b2zEUVw5Fzs3d3xGzMyXmYsuJYcXmkaLzfaZWe3FacL8PI8v7bMJwdQJVefeuCKvc5ZzKoLd7w2kPNELb6JbzbvuXKZKUjIpsiLdhlTGfF9l7C3mmFkWpmZUwtGXxXlKyfsO2Nwzkqvwng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8360.namprd12.prod.outlook.com (2603:10b6:208:3d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 20:58:32 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 20:58:32 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-doc@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v1 0/7] gpu: nova-core: add INTR_CTRL interrupt controller and
 CPU doorbell self-test
Date: Fri,  1 May 2026 16:58:18 -0400
Message-Id: <20260501205825.73614-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::24) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e21456-6088-42bd-802f-08dea7c46753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: UMTH0LtBcaBeO7JyLgWGT1vFh8cfZNipaRRinSeI8kJn5ztaIoOMQflAAKr97XxxSiHrfbPT5xZDMhnfLkcIZ2YamAhi1x2trTjQU7F+RXFEDLvI5DpumysXvISjuKqpiJHYRBtU36l0XCCKqD20zW8Dty3IFIzU1wcwjSaSt04cQgm+AyPOhccbU1GHuxRrMs8MHwUJRB6u7yUgai0lhYp+8pcbWXVkp9gkMzrEnmdFTf64ISUaRPrqN1jvEpKzUPhYHqiDaopYa18a3Gazefj4y4ZoTtic8A1zAI90y+jNYy+di7kxjdZeI1Q0z245JNc+KLFlQuwVV8i6nRcDeSXg4v//n/sazv1Nd+Oif6b361nw3NTqdcjRdqRuAaNX5vYspLoy30x4XjxPzf7mRWK5FyEG/OgFmtSz1Iid+FS8k1f3q2NnCAXtJDI1P9j+JQtbdO0Xe1KQjNe0m+d9bdOkTTobr/mA4NhvClIwAvTrBQa+uUV4V6XdDWZZbFQeztdDDWG9Wd5vcFBGAynCWgx2YgLNSDsJRLXW9hQOd7s+4X/5+4gDzkuFk7PShltzFf8z0YWC2uTIVn2R76NqPmZ8cghDIigY5RKcsDwkbmpNUPX8hORp8P9h3EkQFTmXQOfRayxn4Wvyh2sGU0za6v5+5r0wtx9Teumznbnh0hoJu6RRklSfMMgikwvuoHtf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sw1LraJKY3ZQGo+EHM4RtDWalpew3KRNbY8n0OkG702988mgnZZIMil8K+//?=
 =?us-ascii?Q?Ws5Kw3Tc8pbTMOcjNWq7h32y8UApB4m1IsiGn2bSRoV3u8PsySZtBiXHCiAd?=
 =?us-ascii?Q?4iZsJpok6+o66Pp8Kp1L45GGaj8vSE/Bik1lowfO7JoMsLerpKHhxjiEOqZV?=
 =?us-ascii?Q?C9jeMI5GfyJFkKREdfBqJKxNqhup5+iUUcGiAzIeGTxWbmBUBBT6uA+kxRpq?=
 =?us-ascii?Q?GZMT+EC5IqDoHpcIE/Ko5k1MX64PHuq9rqtEZIZnJV/cGw8hv6DqKXNc0JoE?=
 =?us-ascii?Q?ilEuH+nQBCAfDQVRxYf9g0JMw4mENyyd61fVdqtt/lXL+lKz9EQtkBMpRZSV?=
 =?us-ascii?Q?FmTSkfv0Oz6Bfq1pQ2cIPxMRm2+eJu4Xiibkd3i7p90HQaJ+BpDU+Bj9O3e7?=
 =?us-ascii?Q?vmww5gm/6GswWuFSF/Lj/dXgv3pvo1TzEpb8o8NQE2flhaa8hAJ4vkbVqJwq?=
 =?us-ascii?Q?RjYGgRK+j9EDQ5to2q4yyjgrAH+9ZgLx5XXE9xQu6swd7hPbe6ULBndODQ1Q?=
 =?us-ascii?Q?N7HMsbfQt88xIih3Ia37BTFxMuN6Q2hdXdes9nFF5vJxTUZRper68cAGvFC0?=
 =?us-ascii?Q?6UKIgLKEC3fjDVToV84fgbKQ4CIoXqKuzfFjPmnXs/QpK4yRkQNGvbcKezG3?=
 =?us-ascii?Q?lI5U/z/iOLGEx+JAQ431eF2ZkWWeTjBU5r4hwZR2ez1ePO9pNkkn6L6cydG0?=
 =?us-ascii?Q?Mr0anBN2o5gKMhSfZzFajkx6thWR6HFQYfBlgdeuIDO2DnFuze3U3wSjHwia?=
 =?us-ascii?Q?AzQbNDR88joqXkklzrUWNuFR02TDeh9NyxFNtxdCY05ztqKC7WBVLpYDxRnR?=
 =?us-ascii?Q?8MFb7QNah6ebUzOXrVRH9lY+jCAUlUamCNhhn/vcYD9tyBcA0S9wOYnwg5xN?=
 =?us-ascii?Q?cazlf/cTQPZkoYCePSVNVBAZlupw1bVpOJX2TPughLhN9xDVjS7W9yVS6X0Q?=
 =?us-ascii?Q?UvELh/pMJyBfq93eFE3inTrKPE/ELAcu7uT0iynfWWNuQKVnZTwnTdsqFTvl?=
 =?us-ascii?Q?3eCiVjXFJdyfd60a8SM/RVghv/r2jZiHfH92zL1RCuWz/ZE2d5hItjGjtL3/?=
 =?us-ascii?Q?LRkmdvOjYxSoOVNPtkhOQ469/dibo8YKWBHZFFT0pgcYBh1E8YuU8Kd7VK7M?=
 =?us-ascii?Q?nPXeKxq8vSZPAVh6ryrUUBTTb5aAIvVcKw4BUgpeAVNromDQ7qzn59ukPmZA?=
 =?us-ascii?Q?+vYH+4nFk9XJnQEbkiU0ekYjcqLPdB3KUEMS740tfh3aMwPtXCyKEvkj6dZM?=
 =?us-ascii?Q?RqR9qMMe7ZX1TpQCr5k4iZsh1Z0LoOS7Qbb0J2TWe2EMouc0ZPEtCfIAiB3R?=
 =?us-ascii?Q?KNfMQ+SiT55UsMa5V01BF755lCrTK7EJjmG1IiQYXfDZO3dTzI0tCM0YfBPv?=
 =?us-ascii?Q?sRKzasedTmgIm9YNTgUNQT3K9j2jc8F3wDz57VJmbtuM79QG9Taoh1eUMPH+?=
 =?us-ascii?Q?MwRifrVVoXClVuEZcmFLCDHOj8PUDekc2kQnA6Rfh1FVwJiNOelCK+PS7BTB?=
 =?us-ascii?Q?AtS+mwTIeiHW/FzVu27+XscE3/SSbPy89YzgHS4ufoBxTnaZTDhvO4FtR6w+?=
 =?us-ascii?Q?I5bXGwc4jxLwtadQJLcRV592J64o1rfwLbShqTv7T3pzD/m8WatvL/l+XyVL?=
 =?us-ascii?Q?HZUqSQ9BoUyVlyu64kIDTWNOIZEN+9dNwjknqTzCAjWhfbBL1oPZOsbuydap?=
 =?us-ascii?Q?Ciqhbw1nrK/7n0hGKlYHD/WLI5DzElRDTC38vD/6/wsMFQFcLeXK4Bu1/KsQ?=
 =?us-ascii?Q?VSDWussqEw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e21456-6088-42bd-802f-08dea7c46753
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 20:58:32.3413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vC9TnGO3nnTMihJ2Xihl1AYsHLBGu4v95iyfQo3ob6W5Ca+/GdpjD0sCRd2aR4A0RpVhwUMhPEw7UB0qg6VH4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360
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

This series adds interrupt controller support to nova-core, and validates the
full interrupt path with a CPU-doorbell self-test. It is based on today's
drm-rust-next tree.

The GPU interrupt controller block (INTR_CTRL)
----------------------------------------------
INTR_CTRL is the GPU's two-level (top/leaf) interrupt controller. It
multiplexes all GSP and engine interrupts onto a single PCI MSI line. We need
it to receive asynchronous messages from GSP. GSP will the host with a SWGEN0
interrupt (routed via INTR_CTRL) to deliver async RPC messages like error
reports (XIDs) and other event.  INTR_CTRL also routes notifications from GPU
engines to PCIe MSI such as submitted work completion, MMU faults, etc.
Detailed documentation of the architecture with diagrams are provided in a
separate patch (patch 7/7).

What this series proves
-----------------------
The CPU doorbell self-test (patch 6/7) exercises the full interrupt path
end-to-end. It uses the LEAF_TRIGGER hardware register in INTR_CTRL to trigger
a interrupt, then waits for the IRQ handler to fire. The path under test is:

  LEAF_TRIGGER write
       v
  INTR_CTRL TOP/LEAF goes pending
       v
  GPU fires PCI MSI write
       v
  Host VFIO -> guest IOMMU/IRQ
       v
  Guest Linux IRQ -> nova-core handler
       v
  Handler

The full stack has been end-to-end tested on Ampere GA102 with GPU passthrough.

What comes next
---------------
This is the first stage. Once this lands, the next step is to read (via RPC)
the interrupt vector table that GSP programs at boot. That table tells us which
INTR_CTRL leaf and bit each engine is wired to, so the driver can route
incoming interrupts to per-engine handlers. Future patches will also add GSP interrupt
support, and a per-engine ISR dispatch loops.

The git tree with all patches can be found at:
git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (tag: nova-intr-ctrl-v1-20260501b)

Joel Fernandes (7):
  rust: sync: completion: add wait_for_completion_timeout()
  gpu: nova-core: allocate PCI MSI vector during probe
  gpu: nova-core: add interrupt controller register definitions
  gpu: nova-core: add Architecture::is_pre_hopper() helper
  gpu: nova-core: add INTR_CTRL interrupt controller API
  gpu: nova-core: add CPU doorbell IRQ self-test
  gpu: nova-core: document INTR_CTRL interrupt tree

 Documentation/gpu/nova/core/intr-ctrl.rst  | 305 +++++++++++++++++++++
 Documentation/gpu/nova/index.rst           |   1 +
 drivers/gpu/nova-core/Kconfig              |  13 +
 drivers/gpu/nova-core/gpu.rs               |  22 ++
 drivers/gpu/nova-core/irq.rs               |  29 ++
 drivers/gpu/nova-core/irq/doorbell_test.rs | 203 ++++++++++++++
 drivers/gpu/nova-core/irq/intr_ctrl.rs     | 281 +++++++++++++++++++
 drivers/gpu/nova-core/nova_core.rs         |   2 +
 drivers/gpu/nova-core/regs.rs              |  13 +
 rust/kernel/sync/completion.rs             |  18 +-
 10 files changed, 886 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/gpu/nova/core/intr-ctrl.rst
 create mode 100644 drivers/gpu/nova-core/irq.rs
 create mode 100644 drivers/gpu/nova-core/irq/doorbell_test.rs
 create mode 100644 drivers/gpu/nova-core/irq/intr_ctrl.rs


base-commit: 610e892bdb57043c7769982c2bff0260b6007b75
-- 
2.34.1

