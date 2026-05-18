Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAC5CD4F58
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9C2A10E988;
	Mon, 18 May 2026 18:04:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="sW2pfWL8";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A54BA10E983
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:04:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jc9jW10WzNc/GOTt37o4LmWSGsF7946v3XHkFUERoSCmS6dk0GvhJn1hkC96za3w3ygI/kNzBoEsO97GULeCLDopDnoBdbkt5PbVIdR1AekBusGPK+OjxaYuqoRBs4uxFAe6dccmm0mG6nSoXqoeCX5tjs0Gk2ZJ0/OZyNv23D8VoUEaj45K1d2GCSVOIb+ZZ9OBicdC/Q299kERQ7dcEBM0Ada7f5CcBWizfipkmv82rFrtAQsWbqIYWPjol8xy0+bcprQSGDoJBkw01/RmWGiOpJgxPabS2RDe3LJRD3e3t9V1N1lymTlfhIOkqSK3akKBBVsFr1T5zpGvUmuKgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNGw3KiHAkYviQ9Z1iW1UB/pk0wV7k0L1VEAON2uPlE=;
 b=n3UIH6v52pk2xPDbR4NuQAJVGi6YV7y3FFJ2m5EatO/kplG7JIE2cN2DMdidLPciuVYX2YC3jV0h0tD2q75ti/hxuJyI+fVR/MDtWL33G5CvHCMkwUdi0LB5uPjwCU/RFztQUaqP2JXTwk6EGN1NW4vPRzS8Tki4Bor2/ODmxhYVRtbloxNEcmSBqNWFHtc6980q7MC4bLaXBbY2t2v7h6fHndw4VPsZySny3RKzZWJ0HValcp/bQ4QUN4Hez+00oCeKm5Dc/3wzJAVj4CGz+BYuk9U4wr+8e2k1vt4Iw+VbalmgQIp6Omm0PlPy0ETa+FVHWYHvRnpGUfduAZ4OaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNGw3KiHAkYviQ9Z1iW1UB/pk0wV7k0L1VEAON2uPlE=;
 b=sW2pfWL8dYikh3vwOlQLwFY4e0Gff+Fvb1tMY+xnqgwulqGvTgQswSYgBLQoZybxddTgj2HcxGhaggLSxd5UmBNDz/ADUpwDpKO982zKnKXPWKszoqpiyj10dhmcWBmuEt+vXRMuyDsTvPY+Hfpa9xJO1xI1y2QGzYC5QujGnVVSkEInBnhpOioOnspr6TF7eKTIoQvO2RbLgoN44liNGANQ+O7jNSpWmmgtUyZiHkSCFvc3OnSQPpKv1mA0B8WHtax/wNl6cN/+dI0An0Gmw9qS6E1JD9Y3Yb1d4/5y/qGWTdjgNLqJxf05+IARhAYgUjWtYL2sj23JTyBWjje1bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.22; Mon, 18 May 2026 18:04:00 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:04:00 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, Nikola Djukic <ndjukic@nvidia.com>,
 David Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Andrea Righi <arighi@nvidia.com>,
 Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Philipp Stanner <phasta@kernel.org>,
 alexeyi@nvidia.com, Eliot Courtney <ecourtney@nvidia.com>,
 joel@joelfernandes.org, linux-doc@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v1 10/12] docs: gpu: nova-core: Document the PRAMIN aperture
 mechanism
Date: Mon, 18 May 2026 14:03:40 -0400
Message-Id: <20260518180342.2387845-11-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518180342.2387845-1-joelagnelf@nvidia.com>
References: <20260518180342.2387845-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0014.namprd18.prod.outlook.com
 (2603:10b6:208:23c::19) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH7PR12MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e6f880b-df34-4cf2-09aa-08deb507d68c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: V6ojDKOttBh8ESkoV/+ZahFswzsrSl3D2pJsj9RaRD7sjJieLomu9EG20q3xHw3WNTN3raa33iyk82L6QwKIf29QI7n5/PC3kYokR+sfBoNH5l5i0pSXaCsRL/cl5KXBj61q2veDHOu8OF7w4Wr+o28STH/QpmHr2/SUjtrLkl2RAxX58GjdR0I8z5Ey1E1ZlsgQ1apIVGgdhEDRvxCEYd7YKZgBS/N+1XyMQ2WJE2APMnV7WOFpVT3Hu/NGx1MMJasDhxyIkxFD+Frwn6L+ZEdAC5PXEfuoBf+gqCSN+C1qxy59xPD4nlGaa28cTPd9tn48y2RF9HF1Q1TwT7cIEL3nBycnMLJhh2YYr9xXSQwwv3nvhLZw31Ll7Uv8ybNVaZ8XKfr3FI3dazB1douhjYR6Dlm3Xsi3PfXjxTR4J+po4hm12oHj049U253i+2860FEyiJp7OpnX5yshHONEW4IO0AyNrz6tFqHLWvOLbmbf2fSrOefWpVwMsMv0j/V+b8eghGRI+ZK/sk02MwCrlXDUJ+uRdh4BhgfQuEY0NgETzAcseR92hVoRuAVZ4C17uYgubXdd9ATIEZgZK8wfZFrbVtTBDDkWQaiU85jQBgEhwddQBKtT7nadBXVnfuMB7jk7Vq8B2zUzm8FoCN+l/EgvcIbUvcchZwXHqvFZ341+xlXisAAUhyRX9jueRM8j
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bAqSt0K0wmqUlzyspc/0EG8plcAH4MgeZybLQAROyOSmjuVNBf+87+ozKEkb?=
 =?us-ascii?Q?IPTIGwJ/gKzOLRPs05LHHDTnyAi49WMzrUSDwvOMo3+qZWbDpKArdWQNpQ/Y?=
 =?us-ascii?Q?WgEgwRut+GEO1WLQ5+NG8doWWqLBfnAEG5AWfLFXGOFssyAXAutLTZQBmhD2?=
 =?us-ascii?Q?UR44o2e95WkHyM3LYsXs3+jQ8sxD8B6s8Z0kt4Uf9Nm9Kz4OtmAuuywuVOPX?=
 =?us-ascii?Q?d40CFaY0WBV+U1QGBs8TrMKlhJv3uYVzRAxLnG4XsiJQwZsN1yzcyIeTqiH6?=
 =?us-ascii?Q?3YaNJ94NSJTDL6e9//OjRe2nVBlUeTGV+5q5+PfhjjfMhkuiasfbtqsOSgzz?=
 =?us-ascii?Q?47XPMjN1y2QWfUKXpi56nzeYnO4EUiVPEZFh3ylbvI7ZvwWvN+I2PzgX49OY?=
 =?us-ascii?Q?WjkLKnKFD05G9XTRPzPjj657VdkCMXvy/BQAOCZ9PQQdBikATrPeEt0C1OO0?=
 =?us-ascii?Q?ns7FCZH4gTkgZ0Y3Ug8VZP2oPYplYhIYHf5NhTFbJWGVnRVEb3Ojt++Qlh0H?=
 =?us-ascii?Q?bSzGA+mZSz6ZJBS0QIz4eWuEHDnZ+Oj6NvDOQNOb5bK73oSvfLHVmSzWCCSu?=
 =?us-ascii?Q?6gweNwJoc1D6vepYec+f427LtfhR7PBiJph/81snEPF6U3a7eJev2G1BnA1x?=
 =?us-ascii?Q?hgfxrn9lu2aoJ8c1CI9fE/x22BXrsFlJRBKGK0Y9ItLao+q33mi/3QF4gz6a?=
 =?us-ascii?Q?G72ldTwiusu45QF4UegOxR2uu01sZIeisG+87fQeKph2Te7ZBvkeFWvWYibq?=
 =?us-ascii?Q?UOV0/x/aQdRI7/+xYwxjXKMfDYMrS/GFWFRvpSRqQmRhaXXrdBHzHG0KPGO9?=
 =?us-ascii?Q?Dk+S9LHZKnVdVxAaA8X9vXrGFDVYPxvHRxh/UE8Sml6yapFdrs1+pKi8T1uR?=
 =?us-ascii?Q?4U+MKJf80v0cF2QPp9dpdVSsPh9/NrzmhSxSIQeoe65f6qurtHbuORklD5PD?=
 =?us-ascii?Q?h6fRxS/xdCOwH9eIAkJzsxlE/+fVIdlK8hE9xlFOEvqxqICFwp5pKIWzxgpa?=
 =?us-ascii?Q?ZL9ctXpZxr2C8Z+LCHNKVRBGikLtjiJWisseLaNfSY/uCqXn68jpCoRqw2ah?=
 =?us-ascii?Q?+iwFDJr6368B77StWR8c6livyKWDSnyyJLEBbU6vAZflgGNg/PghqOl+Tg4X?=
 =?us-ascii?Q?CVddm3hUnfh/V5ekC7vwzr+zMFbK0xqBZWSGttBXmGFFOS1p9k5K3ngC0xip?=
 =?us-ascii?Q?ewAvgZcwVhKsp7vZeBClObYMkHCCweIDRpXyZa0lHU1MjaBRvY0Sdn2A9JQv?=
 =?us-ascii?Q?vr0IT4M8FTMCZK6fpDQrGS/cbYTJr8Z+enfH8CC0QqTZjvwTB0RssU2S1FjP?=
 =?us-ascii?Q?oBbK9UsdtElkqJpwVYWVO4wNxT2DtKwFxjXYeG7bMjYPeMKfP5ERNa6RcyDI?=
 =?us-ascii?Q?BW6/3TFzYfcccfoU0o8zoN1mmnlokhFUJstqdxU89WpKU/NoGaZpvc0Ah/mL?=
 =?us-ascii?Q?4VvUHWqMVC0tDVlzfkW29RpkPWBpfhfBK4VzgjARLklxcBsVyj39mhyeIc9p?=
 =?us-ascii?Q?DjgJ3CPvrkIsGlUdsdLLSqxZDwBXkJwINXyfR1fiBYZyUH2CHG0vZrFBeLer?=
 =?us-ascii?Q?mZKW9Zh95GsNAHvY6R8o8jgfXB8nRVD7fZdlE5pXIKxBU6FLw73NZj/gKs+w?=
 =?us-ascii?Q?DLdYw7pThebIO9dduy0GFKuN5rSihj2S+SGbK91f5KEqYErpZXSB455pIRrL?=
 =?us-ascii?Q?LCaMsOEc6m+BdEhOq50jFhghgVPQlP9LKL1yPY8+nb/3ViAiIjnxlJzEC+Y4?=
 =?us-ascii?Q?b3y0UtfPfw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6f880b-df34-4cf2-09aa-08deb507d68c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:04:00.3440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQ0IPWlpF2qAreIAJ/aaSsyjQhz4rwFh/smHhZa035nnXjNgmwGl58e8ofHTRAJdK41lU951tTxDI6SmRLeDdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620
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

Add documentation for the PRAMIN aperture mechanism used by nova-core
for direct VRAM access.

Nova only uses TARGET=VRAM for VRAM access. The SYS_MEM target values
are documented for completeness but not used by the driver.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 Documentation/gpu/nova/core/pramin.rst | 123 +++++++++++++++++++++++++
 Documentation/gpu/nova/index.rst       |   1 +
 2 files changed, 124 insertions(+)
 create mode 100644 Documentation/gpu/nova/core/pramin.rst

diff --git a/Documentation/gpu/nova/core/pramin.rst b/Documentation/gpu/nova/core/pramin.rst
new file mode 100644
index 000000000000..f6cbb0811163
--- /dev/null
+++ b/Documentation/gpu/nova/core/pramin.rst
@@ -0,0 +1,123 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
+PRAMIN aperture mechanism
+=========================
+
+.. note::
+   The following description is approximate and current as of the Ampere family.
+   It may change for future generations and is intended to assist in understanding
+   the driver code.
+
+Introduction
+============
+
+PRAMIN is a hardware aperture mechanism that provides CPU access to GPU Video RAM (VRAM) before
+the GPU's Memory Management Unit (MMU) and page tables are initialized. This 1MB sliding window,
+located at a fixed offset within BAR0, is essential for setting up page tables and other critical
+GPU data structures without relying on the GPU's MMU.
+
+Architecture Overview
+=====================
+
+The PRAMIN aperture mechanism is logically implemented by the GPU's PBUS (PCIe Bus Controller Unit)
+and provides a CPU-accessible window into VRAM through the PCIe interface::
+
+    +-----------------+    PCIe     +------------------------------+
+    |      CPU        |<----------->|           GPU                |
+    +-----------------+             |                              |
+                                    |  +----------------------+    |
+                                    |  |       PBUS           |    |
+                                    |  |  (Bus Controller)    |    |
+                                    |  |                      |    |
+                                    |  |  +--------------+<------------ (window starts at
+                                    |  |  |   PRAMIN     |    |    |     BAR0 + 0x700000)
+                                    |  |  |   Window     |    |    |
+                                    |  |  |   (1MB)      |    |    |
+                                    |  |  +--------------+    |    |
+                                    |  |         |            |    |
+                                    |  +---------|------------+    |
+                                    |            |                 |
+                                    |            v                 |
+                                    |  +----------------------+<------------ (Program PRAMIN to any
+                                    |  |       VRAM           |    |    64KB-aligned VRAM boundary)
+                                    |  |    (Several GBs)     |    |
+                                    |  |                      |    |
+                                    |  |   FB[0x0000000000]   |    |
+                                    |  |          ...         |    |
+                                    |  |   FB[0xFFFFFFFFFF]   |    |
+                                    |  +----------------------+    |
+                                    +------------------------------+
+
+PBUS (PCIe Bus Controller) is responsible for, among other things, handling MMIO
+accesses to the BAR registers.
+
+PRAMIN Window Operation
+=======================
+
+The PRAMIN window provides a 1MB sliding aperture that can be repositioned over
+the entire VRAM address space using the ``NV_PBUS_BAR0_WINDOW`` register.
+
+Window Control Mechanism
+-------------------------
+
+::
+
+    NV_PBUS_BAR0_WINDOW Register (0x1700):
+    +-------+--------+--------------------------------------+
+    | 31:26 | 25:24  |               23:0                   |
+    | RSVD  | TARGET |            BASE_ADDR                 |
+    |       |        |        (bits 39:16 of VRAM address)  |
+    +-------+--------+--------------------------------------+
+
+    The 24-bit BASE_ADDR field encodes bits [39:16] of the target VRAM address,
+    providing 40-bit (1TB) address space coverage with 64KB alignment.
+
+    TARGET field (bits 25:24):
+    - 0x0: VRAM (Video Memory)
+    - 0x1: SYS_MEM_COH (Coherent System Memory)
+    - 0x2: SYS_MEM_NONCOH (Non-coherent System Memory)
+    - 0x3: Reserved
+
+.. note::
+   Nova only uses TARGET=VRAM (0x0) for video memory access. The SYS_MEM
+   target values are documented here for hardware completeness but are
+   not used by the driver.
+
+64KB Alignment Requirement
+---------------------------
+
+The PRAMIN window must be aligned to 64KB boundaries in VRAM. This is enforced
+by the ``BASE_ADDR`` field representing bits [39:16] of the target address::
+
+    VRAM Address Calculation:
+    actual_vram_addr = (BASE_ADDR << 16) + pramin_offset
+    Where:
+    - BASE_ADDR: 24-bit value from NV_PBUS_BAR0_WINDOW[23:0]
+    - pramin_offset: 20-bit offset within the PRAMIN window [0x00000-0xFFFFF]
+
+    Example Window Positioning:
+    +---------------------------------------------------------+
+    |                    VRAM Space                           |
+    |                                                         |
+    |  0x0000000000 +-----------------+ <-- 64KB aligned      |
+    |               | PRAMIN Window   |                       |
+    |               |    (1MB)        |                       |
+    |  0x00000FFFFF +-----------------+                       |
+    |                                                         |
+    |       |              ^                                  |
+    |       |              | Window can slide                 |
+    |       v              | to any 64KB-aligned boundary     |
+    |                                                         |
+    |  0x0123400000 +-----------------+ <-- 64KB aligned      |
+    |               | PRAMIN Window   |                       |
+    |               |    (1MB)        |                       |
+    |  0x01234FFFFF +-----------------+                       |
+    |                                                         |
+    |                       ...                               |
+    |                                                         |
+    |  0xFFFFF00000 +-----------------+ <-- 64KB aligned      |
+    |               | PRAMIN Window   |                       |
+    |               |    (1MB)        |                       |
+    |  0xFFFFFFFFFF +-----------------+                       |
+    +---------------------------------------------------------+
diff --git a/Documentation/gpu/nova/index.rst b/Documentation/gpu/nova/index.rst
index e39cb3163581..b8254b1ffe2a 100644
--- a/Documentation/gpu/nova/index.rst
+++ b/Documentation/gpu/nova/index.rst
@@ -32,3 +32,4 @@ vGPU manager VFIO driver and the nova-drm driver.
    core/devinit
    core/fwsec
    core/falcon
+   core/pramin
-- 
2.34.1

