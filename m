Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB526FF8865
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4142A10E5A1;
	Mon, 27 Apr 2026 06:57:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DZYZT96t";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013053.outbound.protection.outlook.com
 [40.107.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02DAB10E5A1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOujohTfT39fEd7aknEVD7X8VqV+luxPZlv88tj26LvRv+VIoxlgBI6cX5KoZL9ROkkvJQNjrCRWT23yzGQ9Xk2nAzMWMMQy33H48uIITgv69AHn9X+/1BHPkbSQnQRLTJmJp79F9v5EbASC8upNwFc1GqatKmt+wuABHizNMs8Py8OaEfzqAGA2WiyoDZNrjTMPzV3lwXZN4TUCjPIsMu5pcs5hjNON1WMHeskXoH2R37D23OUOfrOU+T7+46G5PqZFazXYMh5WZg7+XSu2z5h4ecwFWjAjiEYSVNowLuMxtMqPgd1/Qt8gK/BLMjPZPfssCBZvEMGBayCztCGxRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNyro/mDxFsoeT+5eB7X66hvLL32nIRwn6gOcd9Yl0c=;
 b=KALnZz2d5DuXptVlCZkR0zNFSpW8j9hceUhTCTDKjIYV3OjNouLJPjxYNr7aeeQHt/cLfRam2Txw7pQN4ALK09ct7pXgb74YihCs4AIt2WBpqkhr2RATtPqFBkWCab8z/i1/OuFaeQZVW/zMXuQbVNh93SzVHEVTYdNPoicU2IJtgOkfNEt/E5LWFicGZoxMcrRV4PFJNpo8zn+6zwysT/n7MNQkhKNDF/g7Nu5zfPv3cs9d1IUeAjQO7HAxHal5LlCWb1of2BI1OQy8NkDqRmq/Ahe3yb8Tiipu6Z7QBz39aacgLfJYyR8QGA4J+lcZAkTBfywp6KO9eulykbpwuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNyro/mDxFsoeT+5eB7X66hvLL32nIRwn6gOcd9Yl0c=;
 b=DZYZT96tbp3pFCSXn/CIw7amwfpzy60mL3m3jlSL/cBK58X6uJbB0sLEA6gCJGCPE6JTvUk63QgHOB43DBcxCW2Tz7DR4Y8nBrdHXA7zHmwh5qWSAygSb2wO/com1+vaX8duRSVbBWEZCzAp6V962ke8GUu+8QunFDnm9EXssIj1qsnSuJZ4Jh4b+P5piJ6RQH5RIlhvHVBtb2DrRwzSO5BtKEvwDtj2Hwl8el0Ht8eZK/QNNov3z2o0hga+WtmvIXfb5a7OvKMsPHg7EBsdeKdoLavBbSSWbIPp/+1VfsvsNYcIh++ly09OF4FH2+dgXrX3C0gVTXXdFmEJ1C9SMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 06:57:42 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 06:57:42 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 27 Apr 2026 15:57:05 +0900
Subject: [PATCH v4 8/8] gpu: nova-core: run Booter Unloader and FWSEC-SB
 upon unbinding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-nova-unload-v4-8-e145ccddae66@nvidia.com>
References: <20260427-nova-unload-v4-0-e145ccddae66@nvidia.com>
In-Reply-To: <20260427-nova-unload-v4-0-e145ccddae66@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0101.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 181b5d75-e86f-436f-b169-08dea42a46f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rlq6S41Z5BnPR5K6dXDwdykYq5hcE98kZ+gttW6q1YaHeYAJEEnAbPFzwkpCO9gJBsWRU9Ad2X0CHei82RFNZmN9qvVLL2+mKVH4XoRaqjiG8piOQQx710II///1VHoMRy1qp2FCwVRnLcm7Zs4pR/sr9eZWAVzNuVG7bMVv6fpn07CKL7jfWG8U6jJQ+rqx6KZZg9vdaRmUMdDWfd0Qstop9vAtULAERGEzSZw7OPXFukLB29775ME8lw3xzkibCp6Sc1WU7JL44zJEj+Sw1i27b8/6pjMbJ3nNEVd5vBfNQnu3fGqHN1V+/6K0KvD4qgeHk6BvLb5xJA4c84GEU9BaGfX5dIBbibuWGF70MIIrN0KSC9LeGsPFdDFU7gBIbtlDX+AaVsNHxRVB197q8OTn/WfW5RmYvAFsBoEJKmORu0fve1ycQ4p+NojhTcZbh80rgQKiDk0Y+KmWUOzdofxm8gUpP1fLebzvqNLTpn9Gi16ManBwSOE93n4gRotJbdLds+Dy4kSpHOj6JSk7u2t1jT6ThUSIAVof8WepwjrFE2tyhF0wEiXKSdy/TjxPC+h/KIcDdHNhHQLYYYeWE+KLzGpprXWXQfsDaFIBHz7+2udeGxsfSeUClKmpuQnY6pqoYpPzwX4qx+tsB3bnvnbbbkR5a5tHLIwdgVOD69C1NV36xUu56hscscJIx8Ln2eGWApuYtnc2PGKWx9S7vODvHH5R/0fuBEhHfp0oGlQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q29jU3hZMlFBaEtJSUYrMHVISnA0ajBLTjV2WHA3ODlpYS84OHRyZENuY3ha?=
 =?utf-8?B?dmp4ZDd6UGNPYzRPVDloeTRDMnpNYjdocmp1bWNtTW9RUEhSaFBDQThUL001?=
 =?utf-8?B?cVUrM2tua3F0RXgvejFENkV6ck9XaTlydnBRN3d5clBBSEYwaTM5clNzejhP?=
 =?utf-8?B?OFVsemU4ZTVEb1NzaXBITmF4dE0rKzQ4d0x0cVBxTncwVnVPdVJtZ1Z1QVFH?=
 =?utf-8?B?WnJ5dVdBVkdialV6cmtrTGdOSis4MmU3bDBpVzl5by9Tb0RMOE9TbTlXdVBM?=
 =?utf-8?B?dVdjOVh0SCtYNnQvRWd1Q2FWUjB4TGNQcFgramJlL3o4QlIzLzRZcGN0eWNx?=
 =?utf-8?B?bkxzZEo4L0FPYVhZUG9FVm93eXNVQU1vN0RFNzR6V2s4TU04R2FCaTJsTURr?=
 =?utf-8?B?NjlIOExIaytXNEJhYUxLRDZwRlJjSWFBeUFlWFM2aWw3NHdUK0gyT2xEVG00?=
 =?utf-8?B?clcwMDlhMWFQQjFZRTJwa2ZmTXdNeGlaQ083bDVOZU1xcXRtbUlNdS80Mk1n?=
 =?utf-8?B?SDdRcG5oWWJ0T3UrQ0JESG1QaVJhVUhlKzBqeG9XTnMyenp5YVEvdTBZMFlx?=
 =?utf-8?B?c01ITHlMRHh3RXBOVm85ZjY1dHhsR2RZNWhhWTNKcnRCcDJpS1dZazVtVW9I?=
 =?utf-8?B?OHRaWFlLV004NW9jV2lrZTgyd3BXaG1iSjNtd3A3ZnNiWHNzMjVJalhuSUQ5?=
 =?utf-8?B?TmMyaDhwMituVllGc090SEozY3llMTJ0d1RHR29nRHNuNDJnaUNCSDRzMEJl?=
 =?utf-8?B?R09PWWpuRHNTY2lQMmtjbDRrQkF4M1ZrbTFPck9yTGxvUDEvZTlYYytZSXZB?=
 =?utf-8?B?cGJzUndMMW1zT3ZpVUthTWtsWWs4QmFSNS83WjNhTkIxT0lZeE45TmJJRHN6?=
 =?utf-8?B?cmVYdXBBanhmZTBhdjF3WDdua0NSRGZBdFA3WEpVenBnNzE0S1NWVjVVTU5M?=
 =?utf-8?B?SG8vM0drQjd6OHNyMnV4eGV4OVY2WTlkR0w3aGV3Vmp5OEFHL3Q4Sm5PUmVy?=
 =?utf-8?B?WWpCaHpGejNqcDVlRzJ0bjBMN1l2aVVmWHl3MGJXVlhLVlB1VE4vZUpIdjBn?=
 =?utf-8?B?NG0rTDdRVUtrZEV1eTkzangxRkVhekQzVytwNnY5dlNtQi9wanphTVdvZFJS?=
 =?utf-8?B?QjVGcG95YXhGZEgxd0NUa3laNXlhWjl4NjNhWHYzZWNoc1dFVG41MjZYVWVn?=
 =?utf-8?B?RWhrSGNjc3hZVmhGT01TbWlwYzUzdUk1QUQ4VlNYbnFXOTIyTEFCMEJuTWNY?=
 =?utf-8?B?MSthOVl1di9Nc3pEY0lSNnFDcm9kcGFEU0FDZTdCU3Q2MmRKYzZ2YmNyZDJ6?=
 =?utf-8?B?eDBFQzhvOU5JVnR1ZjNjSFZLQUpUR2dUUmNPdkEvM1kzZElqUGgwTDVVWmph?=
 =?utf-8?B?K2NXTXhZNFUzTGpvZUMvWkY2T2theTFsanpjK3JzLzZjcnVES1J1eENkSm1Q?=
 =?utf-8?B?TGdHVGlaTHpnWTNldzlNVGRLSkNDVEJUY0RXOXF5cUpDRTQ2VGpjRnZxaE4y?=
 =?utf-8?B?NWwrYmZTRkN5SWdmQ1VLUnJoVzMzYzNnR245M3EwQVh5QU1lNHpwUVQ2aFhE?=
 =?utf-8?B?eW5hbWlnWU84ZnN3NFVtZ21abE5XQnpsTzVrKzgraUQzSU9TQ25MalV0dDdK?=
 =?utf-8?B?ZE5Tb0E3clF0bU80SzFaS1d3aGZvSXBLK0NCODZoRVZVMWt1dEVaRHJxM3No?=
 =?utf-8?B?dzMzSHpuSkZ4Sk1oNENJdmNsdWN0dXNtQ0tFcmFuWU9rNjgrMis5aUI3cEJE?=
 =?utf-8?B?b011TVFKRCtmZG1EcUxxZDBUaG5FSUZzSDU1S2Q5WDB4K3UzUDNIYmdmUXc0?=
 =?utf-8?B?MVZjWlR4R3h0ZUU0RVUyWDZEV25yYlYzclM3dnQrSjVSZytlZGpJU3pmc2xv?=
 =?utf-8?B?ZGdxT2tJOHIxMkw3cE5STVRwOXFraXdGYlV4aVdCMmNDNjFxQTE3UFgrUTNQ?=
 =?utf-8?B?TWx2SU05REVPOENuUlc5MEN0cWJYb3lzT3JDSzZxS05RMTh6dGR0alJkL1hM?=
 =?utf-8?B?ZHNXZXZxbFNUaCs5R3dxSmxzUkhxRllRQXJNM294dCtPUUx5KzdaNmRhY095?=
 =?utf-8?B?WVF6YkhLYk1rdnVxMURNNzlyaCtzblBSd1dlbEhrdmcrc0NpbVRrV3pGOEQr?=
 =?utf-8?B?Q0kwaFA1clA2aU43RFRrWGVsRk02c2tNOVFyUmN3K25GRkh6aWVLS1ArSVBp?=
 =?utf-8?B?YWRsQXc4dWFZcVhYeEROSUhMYU13VTJDaGpLQnFIVlYwcDh4N2xzK3RhQ3FC?=
 =?utf-8?B?NEtwVVRzWGdabHFyT1dtTmFNTmp0VE5GdVpRbWVuUnFoOWIwSllacU9MajRO?=
 =?utf-8?B?ZkxaeWtjTDFLdDJ2bzZac3FjdkZPRllXSldmWVB5aUVyUi9WaDFUdHlMU3Ba?=
 =?utf-8?Q?91qsXDCsHFWZVoED+mhJUQuzMeK2+g+HYtoJLXHZLAWdc?=
X-MS-Exchange-AntiSpam-MessageData-1: 0/hn59WLyYM5vg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 181b5d75-e86f-436f-b169-08dea42a46f5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 06:57:42.0521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5Oo2mfZ1WNfarwwGX6Ly65AMMfJalARQho7EqEsvO4J1DfNH+cppyIp2Z++gVUDcE2mH2hzxvY2PJIbkOnKCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655
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

When probing the driver, the FWSEC-FRTS firmware creates a WPR2 secure
memory region to store the GSP firmware, and the Booter Loader loads and
starts that firmware into the GSP, making it run in RISC-V mode.

These operations need to be reverted upon unloading, particularly the
WPR2 secure region creation, as its presence prevents the driver from
subsequently probing.

Thus, prepare the Booter Unloader and FWSEC-SB firmwares when booting
the GSP, so they can be executed at unbind time to put the GPU into a
state where it can be probed again.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/firmware/booter.rs |   1 -
 drivers/gpu/nova-core/firmware/fwsec.rs  |   1 -
 drivers/gpu/nova-core/gpu.rs             |   2 +-
 drivers/gpu/nova-core/gsp.rs             |   3 +
 drivers/gpu/nova-core/gsp/boot.rs        |  18 +++-
 drivers/gpu/nova-core/gsp/hal.rs         |  21 ++++-
 drivers/gpu/nova-core/gsp/hal/gh100.rs   |   7 +-
 drivers/gpu/nova-core/gsp/hal/tu102.rs   | 141 ++++++++++++++++++++++++++++++-
 drivers/gpu/nova-core/regs.rs            |   5 ++
 9 files changed, 188 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
index 6a41690e72c6..6f421906c272 100644
--- a/drivers/gpu/nova-core/firmware/booter.rs
+++ b/drivers/gpu/nova-core/firmware/booter.rs
@@ -281,7 +281,6 @@ fn new_booter(data: &[u8]) -> Result<Self> {
 #[derive(Copy, Clone, Debug, PartialEq)]
 pub(crate) enum BooterKind {
     Loader,
-    #[expect(unused)]
     Unloader,
 }
 
diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-core/firmware/fwsec.rs
index 8810cb49db67..4108f28cd338 100644
--- a/drivers/gpu/nova-core/firmware/fwsec.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec.rs
@@ -144,7 +144,6 @@ pub(crate) enum FwsecCommand {
     /// image into it.
     Frts { frts_addr: u64, frts_size: u64 },
     /// Asks [`FwsecFirmware`] to load pre-OS apps on the PMU.
-    #[expect(dead_code)]
     Sb,
 }
 
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 1dd25c93a67e..7cf994ba2fb0 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -330,7 +330,7 @@ pub(crate) fn unbind(&self, dev: &device::Device<device::Core>) {
         // Do not return upon error as the sysmem flush page must be unregistered in any case.
         let _ = self
             .gsp
-            .unload(dev, bar, &self.gsp_falcon)
+            .unload(dev, bar, &self.gsp_falcon, &self.sec2_falcon)
             .inspect_err(|e| dev_err!(dev, "failed to unload GSP: {:?}\n", e));
 
         // Unregister the sysmem flush page before the driver data is dropped.
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 38378f104068..58b917172efb 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -126,6 +126,8 @@ pub(crate) struct Gsp {
     pub(crate) cmdq: Cmdq,
     /// RM arguments.
     rmargs: Coherent<GspArgumentsPadded>,
+    /// Ready-to-run GSP unload bundle, if any.
+    unload: Option<KBox<dyn hal::UnloadBundle>>,
 }
 
 impl Gsp {
@@ -181,6 +183,7 @@ pub(crate) fn new(pdev: &pci::Device<device::Bound>) -> impl PinInit<Self, Error
                         dir.read_binary_file(c"logrm", &logs.logrm.0);
                     })
                 },
+                unload: None,
             }))
         })
     }
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 59c1b4d030ae..c8555d76b3a2 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -56,8 +56,8 @@ pub(crate) fn boot(
 
         let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
 
-        // Perform the chipset-specific boot sequence.
-        hal.boot(
+        // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
+        let unload_bundle = hal.boot(
             self.as_mut(),
             dev,
             bar,
@@ -67,6 +67,7 @@ pub(crate) fn boot(
             gsp_falcon,
             sec2_falcon,
         )?;
+        *self.as_mut().project().unload = unload_bundle;
 
         gsp_falcon.write_os_version(bar, gsp_fw.bootloader.app_version);
 
@@ -129,6 +130,7 @@ pub(crate) fn unload(
         dev: &device::Device<device::Bound>,
         bar: &Bar0,
         gsp_falcon: &Falcon<Gsp>,
+        sec2_falcon: &Falcon<Sec2>,
     ) -> Result {
         // Shut down the GSP.
         Self::shutdown_gsp(
@@ -139,6 +141,18 @@ pub(crate) fn unload(
         )
         .inspect_err(|e| dev_err!(dev, "Unload guest driver failed: {:?}\n", e))?;
 
+        // With the GSP shut down, reset the GSP so it can be restarted.
+        if let Some(unload_bundle) = self.unload.as_ref() {
+            unload_bundle.run(dev, bar, gsp_falcon, sec2_falcon)?;
+        } else {
+            dev_warn!(
+                dev,
+                "Unload bundle is missing, GSP won't be properly reset.\n"
+            );
+        }
+
+        dev_info!(dev, "successfully unloaded\n");
+
         Ok(())
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index 4d8c1998f4cf..d9c324226dda 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -29,9 +29,28 @@
     },
 };
 
+/// Trait for types containing the resources and code required to fully reset the GSP.
+///
+/// The GSP unload code might run in a situation where we cannot load firmware dynamically (e.g.
+/// because we are in shutdown and the file system is not accessible anymore). Thus, the firmware
+/// required for unloading is prepared at load time, and stored here until it needs to be run.
+pub(super) trait UnloadBundle: Send {
+    /// Performs the steps required to properly reset the GSP after it has been stopped.
+    fn run(
+        &self,
+        dev: &device::Device<device::Bound>,
+        bar: &Bar0,
+        gsp_falcon: &Falcon<GspEngine>,
+        sec2_falcon: &Falcon<Sec2>,
+    ) -> Result;
+}
+
 /// Trait implemented by GSP HALs.
 pub(super) trait GspHal: Send {
     /// Performs the GSP boot process, loading and running the required firmwares as needed.
+    ///
+    /// Upon success, returns the [`UnloadBundle`] to be run (if any) in order to properly reset the
+    /// GSP after it has been stopped.
     #[allow(clippy::too_many_arguments)]
     fn boot(
         &self,
@@ -43,7 +62,7 @@ fn boot(
         wpr_meta: &Coherent<GspFwWprMeta>,
         gsp_falcon: &Falcon<GspEngine>,
         sec2_falcon: &Falcon<Sec2>,
-    ) -> Result;
+    ) -> Result<Option<KBox<dyn UnloadBundle>>>;
 
     /// Performs HAL-specific post-GSP boot tasks.
     ///
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 9d7e9f4454b1..51e1099cda0d 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -17,7 +17,10 @@
     fb::FbLayout,
     gpu::Chipset,
     gsp::{
-        hal::GspHal,
+        hal::{
+            GspHal,
+            UnloadBundle, //
+        },
         Gsp,
         GspFwWprMeta, //
     },
@@ -40,7 +43,7 @@ fn boot(
         _wpr_meta: &Coherent<GspFwWprMeta>,
         _gsp_falcon: &Falcon<GspEngine>,
         _sec2_falcon: &Falcon<Sec2>,
-    ) -> Result {
+    ) -> Result<Option<KBox<dyn UnloadBundle>>> {
         Err(ENOTSUPP)
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index d5da23cd8c90..c6c947696ba8 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -31,7 +31,10 @@
     },
     gpu::Chipset,
     gsp::{
-        hal::GspHal,
+        hal::{
+            GspHal,
+            UnloadBundle, //
+        },
         sequencer::{
             GspSequencer,
             GspSequencerParams, //
@@ -43,6 +46,124 @@
     vbios::Vbios, //
 };
 
+// A ready-to-run FWSEC unload firmware.
+//
+// Since there are two variants of the prepared firmware (with and without a bootloader), this type
+// abstracts the difference.
+enum FwsecUnloadFirmware {
+    WithoutBl(FwsecFirmware),
+    WithBl(FwsecFirmwareWithBl),
+}
+
+impl FwsecUnloadFirmware {
+    /// Loads the FWSEC SB firmware, as well as its bootloader if `chipset` requires it.
+    fn new(
+        dev: &device::Device<device::Bound>,
+        bar: &Bar0,
+        chipset: Chipset,
+        bios: &Vbios,
+        gsp_falcon: &Falcon<GspEngine>,
+    ) -> Result<Self> {
+        let fwsec_sb = FwsecFirmware::new(dev, gsp_falcon, bar, bios, FwsecCommand::Sb)?;
+
+        Ok(if chipset.needs_fwsec_bootloader() {
+            Self::WithBl(FwsecFirmwareWithBl::new(fwsec_sb, dev, chipset)?)
+        } else {
+            Self::WithoutBl(fwsec_sb)
+        })
+    }
+
+    /// Runs the FWSEC SB firmware.
+    fn run(
+        &self,
+        dev: &device::Device<device::Bound>,
+        bar: &Bar0,
+        gsp_falcon: &Falcon<GspEngine>,
+    ) -> Result<()> {
+        match self {
+            Self::WithoutBl(fw) => fw.run(dev, gsp_falcon, bar),
+            Self::WithBl(fw) => fw.run(dev, gsp_falcon, bar),
+        }
+    }
+}
+
+// Contains the firmware required to fully reset GSP on chipsets where the GSP is started using
+// FWSEC/Booter.
+pub(super) struct Sec2UnloadBundle {
+    fwsec_sb: FwsecUnloadFirmware,
+    booter_unloader: BooterFirmware,
+}
+
+impl Sec2UnloadBundle {
+    /// Load and prepare the resources required to properly reset the GSP after it has been stopped.
+    fn build(
+        dev: &device::Device<device::Bound>,
+        bar: &Bar0,
+        chipset: Chipset,
+        bios: &Vbios,
+        gsp_falcon: &Falcon<GspEngine>,
+        sec2_falcon: &Falcon<Sec2>,
+    ) -> Result<KBox<dyn UnloadBundle>> {
+        KBox::new(
+            Self {
+                fwsec_sb: FwsecUnloadFirmware::new(dev, bar, chipset, bios, gsp_falcon)?,
+                booter_unloader: BooterFirmware::new(
+                    dev,
+                    BooterKind::Unloader,
+                    chipset,
+                    FIRMWARE_VERSION,
+                    sec2_falcon,
+                    bar,
+                )?,
+            },
+            GFP_KERNEL,
+        )
+        .map(|b| b as KBox<dyn UnloadBundle>)
+        .map_err(Into::into)
+    }
+}
+
+impl UnloadBundle for Sec2UnloadBundle {
+    fn run(
+        &self,
+        dev: &device::Device<device::Bound>,
+        bar: &Bar0,
+        gsp_falcon: &Falcon<GspEngine>,
+        sec2_falcon: &Falcon<Sec2>,
+    ) -> Result<()> {
+        // Run FWSEC-SB to reset the GSP falcon to its pre-libos state.
+        self.fwsec_sb.run(dev, bar, gsp_falcon)?;
+
+        // Remove WPR2 region if set.
+        let wpr2_hi = bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI);
+        if wpr2_hi.is_wpr2_set() {
+            sec2_falcon.reset(bar)?;
+            sec2_falcon.load(dev, bar, &self.booter_unloader)?;
+
+            // Sentinel value to confirm that Booter Unloader has run.
+            const MAILBOX_SENTINEL: u32 = 0xff;
+            let (mbox0, _) =
+                sec2_falcon.boot(bar, Some(MAILBOX_SENTINEL), Some(MAILBOX_SENTINEL))?;
+            if mbox0 != 0 {
+                dev_err!(dev, "Booter Unloader returned error 0x{:x}\n", mbox0);
+                return Err(EINVAL);
+            }
+
+            // Confirm that the WPR2 region has been removed.
+            let wpr2_hi = bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI);
+            if wpr2_hi.is_wpr2_set() {
+                dev_err!(
+                    dev,
+                    "WPR2 region still set after Booter Unloader returned\n"
+                );
+                return Err(EBUSY);
+            }
+        }
+
+        Ok(())
+    }
+}
+
 /// Helper function to load and run the FWSEC-FRTS firmware and confirm that it has properly
 /// created the WPR2 region.
 fn run_fwsec_frts(
@@ -161,7 +282,7 @@ fn boot(
         wpr_meta: &Coherent<GspFwWprMeta>,
         gsp_falcon: &Falcon<GspEngine>,
         sec2_falcon: &Falcon<Sec2>,
-    ) -> Result {
+    ) -> Result<Option<KBox<dyn UnloadBundle>>> {
         let bios = Vbios::new(dev, bar)?;
 
         // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
@@ -185,7 +306,21 @@ fn boot(
 
         run_booter(dev, bar, chipset, sec2_falcon, wpr_meta)?;
 
-        Ok(())
+        // Last, try and prepare the unload bundle. If this fails, the GPU will need to be reset
+        // before the driver can be probed again.
+        let unload_bundle =
+            Sec2UnloadBundle::build(dev, bar, chipset, &bios, gsp_falcon, sec2_falcon)
+                .inspect_err(|e| {
+                    dev_warn!(dev, "Failed to prepare unload firmware: {:?}\n", e);
+                    dev_warn!(dev, "The GSP won't be able to unload properly on unbind.\n");
+                    dev_warn!(
+                        dev,
+                        "The GPU will need to be reset before the driver can bind again.\n"
+                    );
+                })
+                .ok();
+
+        Ok(unload_bundle)
     }
 
     fn post_boot(
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 6faeed73901d..356fbf364ea5 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -175,6 +175,11 @@ impl NV_PFB_PRI_MMU_WPR2_ADDR_HI {
     pub(crate) fn higher_bound(self) -> u64 {
         u64::from(self.hi_val()) << 12
     }
+
+    /// Returns whether the WPR2 region is currently set.
+    pub(crate) fn is_wpr2_set(self) -> bool {
+        self.hi_val() != 0
+    }
 }
 
 // PGSP

-- 
2.54.0

