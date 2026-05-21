Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0324CD5BB5
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 13:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAB0E10F325;
	Thu, 21 May 2026 13:51:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="dOrLcRQA";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0D9710F333
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 13:51:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsUakmyPZ/gydDdbFYTxHcACBPkS/98uNUm9Hh4CgG5U6p0Y+8ezta3i6HUwQ4C9A15w2h92lCjT2UyT4HC+f8dxFq7PaAPCgqAP0te/J/ULx4y7VMLIdtkCk3BavPsSnDOSmOBYaTtZsFBtANQHqdic94+zV7DpYfGS2Gd/1Q8CgFxcGx9Li95oGoxsaGNTctC1MrvIAmjVwkSOKkuOYUnn9j20N4uVpi79HvPKLIfg9tC2mLiVXm6vAzZMYF6Qph/kC8ChgKaRXv8Unzsw0PmWU58CKk8K9s/apwHW24YPz1Xa5IZISh/ijIda8FsM0TE2Hzk5BO4WjqksAWagTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwjHzZvM3+xkrEASptD51SROQfh5MDwADzuVlfveatA=;
 b=gJZc8qNTLiGuMLDPtIATui6coLnRrnYNK7jmq7w9ZymUjZ398j2jM75Bcc/m9gloBjphF/OSDUrE77llyDSyCS1H0xjpNeRttq1qELl2e1liNveE2hfzeu6/pFRMCCMHSYofcA+uyZM36tx5SNc5Uy1UgMXsGeekfY9uTjT0JBAu2Rl669RNGEnyXqxxKvvnDqldCEm7KjKGfasRgksnX6X3L1AcUAyl4CxBI5QvbjBRcJ+sU5MmVqmkg2JNU8hnKgh3oMu8Y+oZ21zUxAdGlgNMUgfAELMjLqXlw7eNR2oEksY8MvOjkZ650JcUDFoX/EhvyS62DThHLPSeY4wkrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwjHzZvM3+xkrEASptD51SROQfh5MDwADzuVlfveatA=;
 b=dOrLcRQAOuHBMcFnYhiVkx1v8otsGVkTJflAlOf3x9qMfP1h//RyBffHQALFZ3xmPI/uHaQw1vLJssS/7EsnAp9S8laX8NYPdHFgDLFVsXak3WTxi3bRZ40s6dLfO3IrUGIIljPcUlqOL9SwYGJoL139pdf+mT01OPrGzssUoJws+4pQ4Q4A4llO3z5SFXgzqCuQwNQlxgYM3sFopDZO8uoyoW+1D0bPQCAnv8CosuaDgEhhuhDDNoKHvsj3zZbuBqhJbLE2+avpDy/Dyibj5uK3JnCLoWVZEsr+WuCJ7t8m3MQ/+3qkMz24zbnk1DjOU+B5P54D7zg0vQssXCullQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Thu, 21 May
 2026 13:51:27 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 13:51:25 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 21 May 2026 22:50:54 +0900
Subject: [PATCH v6 7/7] gpu: nova-core: run Booter Unloader and FWSEC-SB
 upon unbinding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-nova-unload-v6-7-65f581c812c9@nvidia.com>
References: <20260521-nova-unload-v6-0-65f581c812c9@nvidia.com>
In-Reply-To: <20260521-nova-unload-v6-0-65f581c812c9@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: OS3PR01CA0080.jpnprd01.prod.outlook.com
 (2603:1096:604:da::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: bb9a49cc-11e5-41c2-e999-08deb7400cd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|3023799007|56012099003|18002099003|22082099003|7136999003|11062099010|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: bOGfh/MuiaefNuskUuGm9fnz/K8ypcR9OY/DuISbFuSi42j5lnb9GxG36jf8ZFnYWOlmz+v8FG7Fg4Fk9ShxYRRGnobUVdY0xLiRgQCqCmk9PH5VqmG1wsoPus1b6qmIcv3OOb+7srQpf9guHt7Djg9UTAGCOLmGww7AP8AUXk1GUIn0CJd97Lxeej41eQiW0MlLy4daSidxqLF6+KbhoAjyZbjRdyjThSHAnNz4yXwv3wHq8ECoJBUKVRXXJAos67E9PFtzXQLC6nwACdDdxFdhs6XqjeiXfweEJi1OSJ6XR3C2vMJz/9GYDAOMyd/RuwMzBkvTbfIL1K2oQAnXcnThbMH8vFheh7ggI2ZkV4fmDZpAheFIzb/v9l5bYxCmoR2cea3aOSuLhI24SLtvhyi2u+m3yvYKAiE6EVSuKRJ93Ljflu2+zJ3tRK8d1auvV0/wsHRZcYHxb0eFZiUCvDLdYWnItP1yyb5+zpBJMSpUaHavmm02fsBizoTZsChg0wbaFcsyGOKjNcC/mjoT7+lsUINdXPlzfPLXNcKvzcT+XezDdPJcb2IF6sZlU2YHxZ0RPfHaEJ3lJomNk8PMSbhEHOqzvvu6EEykpNYUTsC4NjP2dgiH87vgI/EAyGU0nvWUPaLccSC8VtDVGkb1MqENkhRMVHRUHzQjShKWslrSZlXogp0lqjT2cm5HlsCL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(3023799007)(56012099003)(18002099003)(22082099003)(7136999003)(11062099010)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW5VdXVicFNhakRnYXNFamVWS2xsWmNsZ1VWekJIamRzQzdDZUxKVFIyb2sw?=
 =?utf-8?B?UTBkM2tFMEVhRjFrZFlqQTZhOVp6QlYydHIrbkpCeHFmb0FVRVdyZno2c21C?=
 =?utf-8?B?eUVLZkd2QVNRNHN5Z1M3R0VaTmFMYmJObUlJQTdUUVlsYWNERUVMNlNhc2Vj?=
 =?utf-8?B?TVBzN3pQQ2swL2Q0WEZ5RFJLWlJjWVErbFZrY0I2ck1iNHcwbjZOQi9EMnVF?=
 =?utf-8?B?Qk1JSHhUdUt3T2I2UzRrSmwzaWMyWktDdkpNeDFQV2NGbENDRlp6bG14bHdB?=
 =?utf-8?B?VGtGV1JyZkNVOHpzTGlhMG52bzQ4cE5GdkFrLzVueFpPYlExSXBLWU1xZTZy?=
 =?utf-8?B?eXJrdm54R2Zqa2ovYnMrOVVvOExSWloyYVU2OUUySXpsT0VDWitIalBtbjVG?=
 =?utf-8?B?QWpwdFhHcVA2dVhnUnVyVUo4bFl2K1FIZnR6NUczaTV0clVacjNEZnVDU0NX?=
 =?utf-8?B?YW45R3ZaVEpZcE9sL0pNc1JLckVEaUxxSkJSbkVVTG5YVFZBaDBLTWFWN2Y1?=
 =?utf-8?B?N2N3dklWVTJrOGI0eERPU3B5dmp0WVZrWVJFQlVZM1g1OGZ6cGl2VUlBNVJj?=
 =?utf-8?B?Y29sb3dyWXNwMVkwb0s4Wm5Bay9IV3ZhNll0Ykd6YlM3N1czY3ZiM2tNcEdo?=
 =?utf-8?B?Qnl5SE5ncXZ2c1JRUnhRTksvczZPRHowK29YWFRwZDBtY2c5V0o5UkFOemRl?=
 =?utf-8?B?eitBK1BYTHQ0WjgzeVBFSFFVV2JvdTVjMHpmTS9VYzliSUFack45RnliTkM4?=
 =?utf-8?B?VTRlK0JjSWlLbE1LS0Q1Z3h5Ujlxa0I0dElxRzFYekVzak9xRmo1bjFkOGJh?=
 =?utf-8?B?RG44ZFJQeFRQVjJTeXZBOG5GYk9WeWRiTjA0WWVvVDB5QUNrRzQ1WnRwUTdy?=
 =?utf-8?B?TFViUDhqNnJxVWJUZWVhMTNINlF5S3U5VTUvUk1xemoraVg4RlBodmZKSVdv?=
 =?utf-8?B?QlRkS0lqa3N6blZFV2h3WS9UQWZnOU1JSFdGWjh4eWttL1RDZ2h2NFA5VjBs?=
 =?utf-8?B?TUJEelRrcDlxZFBhcWp1QlluSitTeHcrUEVhbzFmeWp6YWZSOW90YlB2L2lO?=
 =?utf-8?B?KzQ2T3IxcHQvdXE0ZDE3VmFVZWVRMExkcU1USlNqWTJmRG5wVnpVbEp6WXg2?=
 =?utf-8?B?Ymk3WUE5NU5XZDAwQWQrdUx1TUwzMTEwM3VNcFlrdFR1VmU4eVBFaU5DOVBN?=
 =?utf-8?B?bHpDZGRWQ29iV3JoeFRUQTViVW91MnNGV0NXMmkyOXhBSGZUWDJWd09paGUy?=
 =?utf-8?B?aDF6anI4WkxpaStSKy94VXlwV01JMDVxRDFhU2tzVWRkQm5Hb0srRG56ZzBD?=
 =?utf-8?B?VkRGNWEra2ZwL1RlUkFYUldoRC9YTTVPTFdBaEZ5TTAxbzd1ZWlPTENzaWdV?=
 =?utf-8?B?NmZqSC9tS2Q0d25uU0JwSUFML0U5d2RucnJzN05KRk5kZjJTcWlQUE9Odkph?=
 =?utf-8?B?bXJkbmVXaXFqdEwwSkZqNldpeWQ4aHpkWWoyMEd0d2ExMzVDZ2lnUkpiWmVY?=
 =?utf-8?B?cGxnMWpmR3pCeXl0YU5QVXR4YWtSaVNvTzF4blBXYkhsMTNDWUYyZzBkS29S?=
 =?utf-8?B?cDJZdXkxVDUwVGtlMXBWNWh2VHBNSUpreTZ0WndNZG9tTnVDWVF0eDNNaWRy?=
 =?utf-8?B?RVhZaG1tWmhwVGpocCtFRFc3K2hlRk9mbEc3YnhPUmRQcndwMFh1VXppY1Z0?=
 =?utf-8?B?NEVJSXl1VWl0YnlDT1paTTl3R2ZRRG82eEpQVVVwMXJ4cXUvblFmS0NTTHZM?=
 =?utf-8?B?NWxxd0NpNkNMRTFTZnBMc0dzbytBaTVLdjU0L01OY1RJK0c0YVRZUGE3bzJE?=
 =?utf-8?B?ZWxaNFZKZ2FiNzZkOTVQN2RSek9ZSWp6aUFzWWJ0NXdjV1IwMnRnZEhSUXo2?=
 =?utf-8?B?WjU2WURaQzQxN1RLSDJpZzg3ekgrWGdsRzREcGJxK1E0UnRSTUhYYjd5SjdB?=
 =?utf-8?B?bFU3WkExajlIVGlmQnE2dUdDTmVZbE9XTml2WHNRQUlqWFJtMjh0MGY5RTBs?=
 =?utf-8?B?ejdmV3RmY3RRWnN4ZFoxWkNwMHBLTXZCMFBJa2ZnNGVJcWlxMER3SkNRUXpX?=
 =?utf-8?B?SE9hRTBWMysrTEE0S1hjaEJybDk0cFJndEZ1K3ZWUGZvTS8weUU1bC91MnVM?=
 =?utf-8?B?N2lIZlpURHcwWDFaejUwZER3cmh5dllmTnZBeFdKL1dyd0V4TGFEazRWK2RH?=
 =?utf-8?B?ZW45NTd0U2IyVWZXd3VIdUE5cit0Zjk4c1RJNEZJLzk3cWhTY1dYUjBoT2oz?=
 =?utf-8?B?VC96N3ArL3F3enBIcGR1Umk1ZEdRWTVpMVc5Q0tjclJDc0d2bU8wNnRwTG5H?=
 =?utf-8?B?dWRGQXAzSThoWEl5WWlZbFJoSmJjTDlUTUY4MzJPOEVBNVhjUlYxajN5OFJt?=
 =?utf-8?Q?NzDWQoyS7IbjquNMqHJWNRwCs8+SXA5Eqv0AJuurS1oYo?=
X-MS-Exchange-AntiSpam-MessageData-1: Xkjcf20E7WlLqw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9a49cc-11e5-41c2-e999-08deb7400cd8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 13:51:25.6361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gjmnph3gSW337km9/FzHuIInnD53AWAY7IML2rw/YD3mMg7wqNkvOflVx6ZpD1MsZ0hlO5nLty7gZIGiwDbOFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905
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
 drivers/gpu/nova-core/driver.rs          |  18 +++-
 drivers/gpu/nova-core/firmware/booter.rs |   1 -
 drivers/gpu/nova-core/firmware/fwsec.rs  |   1 -
 drivers/gpu/nova-core/gpu.rs             |  35 ++++++--
 drivers/gpu/nova-core/gsp.rs             |   3 +
 drivers/gpu/nova-core/gsp/boot.rs        |  35 ++++++--
 drivers/gpu/nova-core/gsp/hal.rs         |  21 ++++-
 drivers/gpu/nova-core/gsp/hal/gh100.rs   |   7 +-
 drivers/gpu/nova-core/gsp/hal/tu102.rs   | 141 ++++++++++++++++++++++++++++++-
 drivers/gpu/nova-core/regs.rs            |   5 ++
 10 files changed, 242 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index ced1d38d206a..20d38a64dcc7 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+use core::cell::Cell;
+
 use kernel::{
     auxiliary,
     device::Core,
@@ -21,7 +23,10 @@
     types::ForLt,
 };
 
-use crate::gpu::Gpu;
+use crate::{
+    gpu::Gpu,
+    gsp, //
+};
 
 /// Counter for generating unique auxiliary device IDs.
 static AUXILIARY_ID_COUNTER: Atomic<u32> = Atomic::new(0);
@@ -33,6 +38,10 @@ pub(crate) struct NovaCore<'bound> {
     bar: pci::Bar<'bound, BAR0_SIZE>,
     #[allow(clippy::type_complexity)]
     _reg: Devres<auxiliary::Registration<ForLt!(())>>,
+    /// GSP unload bundle, if any.
+    ///
+    /// Stored into a `Cell` so it can be [taken](Cell::take) without a mutable reference.
+    unload_bundle: Cell<Option<gsp::UnloadBundle>>,
 }
 
 const BAR0_SIZE: usize = SZ_16M;
@@ -94,6 +103,8 @@ fn probe<'bound>(
             // other threads of execution.
             unsafe { pdev.dma_set_mask_and_coherent(DmaMask::new::<GPU_DMA_BITS>())? };
 
+            let mut unload_bundle = None;
+
             Ok(try_pin_init!(NovaCore {
                 bar: pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core/bar0")?,
                 // TODO: Use `&bar` self-referential pin-init syntax once available.
@@ -101,7 +112,7 @@ fn probe<'bound>(
                 // SAFETY: `bar` is initialized before this expression is evaluated
                 // (`try_pin_init!()` initializes fields in declaration order), lives at a pinned
                 // stable address, and is dropped after `gpu` (struct field drop order).
-                gpu <- Gpu::new(pdev, unsafe { &*core::ptr::from_ref(bar) }),
+                gpu <- Gpu::new(pdev, unsafe { &*core::ptr::from_ref(bar) }, &mut unload_bundle),
                 _reg: auxiliary::Registration::new(
                     pdev.as_ref(),
                     c"nova-drm",
@@ -111,6 +122,7 @@ fn probe<'bound>(
                     crate::MODULE_NAME,
                     (),
                 )?,
+                unload_bundle: Cell::new(unload_bundle),
             }))
         })
     }
@@ -119,6 +131,6 @@ fn unbind<'bound>(
         dev: &'bound pci::Device<kernel::device::Core>,
         this: Pin<&'bound Self::Data<'bound>>,
     ) {
-        this.gpu.unbind(dev)
+        this.gpu.unbind(dev, this.unload_bundle.take())
     }
 }
diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
index e45e5dc8d5d2..c5e17605e1a3 100644
--- a/drivers/gpu/nova-core/firmware/booter.rs
+++ b/drivers/gpu/nova-core/firmware/booter.rs
@@ -282,7 +282,6 @@ fn new_booter(data: &[u8]) -> Result<Self> {
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
index 75fe1bdb80fe..5af04901b512 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -18,7 +18,10 @@
         Falcon, //
     },
     fb::SysmemFlush,
-    gsp::Gsp,
+    gsp::{
+        self,
+        Gsp, //
+    },
     regs,
 };
 
@@ -261,10 +264,20 @@ pub(crate) struct Gpu<'bound> {
 }
 
 impl<'bound> Gpu<'bound> {
-    pub(crate) fn new(
+    /// Create a new [`Gpu`] instance.
+    ///
+    /// `pdev` is the PCI device for the GPU, `bar` is its `Bar0` mapping.
+    ///
+    /// `unload_bundle` is an output parameter, where the [GSP unload bundle](gsp::UnloadBundle) is
+    /// to be written. The driver layer will pass the written value back to [`Gpu::unbind`].
+    pub(crate) fn new<'init>(
         pdev: &'bound pci::Device<device::Bound>,
         bar: &'bound Bar0,
-    ) -> impl PinInit<Self, Error> + 'bound {
+        unload_bundle: &'init mut Option<gsp::UnloadBundle>,
+    ) -> impl PinInit<Self, Error> + 'init
+    where
+        'bound: 'init,
+    {
         try_pin_init!(Self {
             spec: Spec::new(pdev.as_ref(), bar).inspect(|spec| {
                 dev_info!(pdev,"NVIDIA ({})\n", spec);
@@ -290,14 +303,24 @@ pub(crate) fn new(
 
             gsp <- Gsp::new(pdev),
 
-            _: { gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)? },
+            _: { *unload_bundle = gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)? },
         })
     }
 
-    pub(crate) fn unbind(&self, pdev: &'bound pci::Device<device::Core>) {
+    pub(crate) fn unbind(
+        &self,
+        pdev: &'bound pci::Device<device::Core>,
+        unload_bundle: Option<gsp::UnloadBundle>,
+    ) {
         let _ = self
             .gsp
-            .unload(pdev.as_ref(), self.bar, &self.gsp_falcon)
+            .unload(
+                pdev.as_ref(),
+                self.bar,
+                &self.gsp_falcon,
+                &self.sec2_falcon,
+                unload_bundle,
+            )
             .inspect_err(|e| dev_err!(pdev, "failed to unload GSP: {:?}\n", e));
     }
 }
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 38378f104068..1885cfa5cb38 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -185,3 +185,6 @@ pub(crate) fn new(pdev: &pci::Device<device::Bound>) -> impl PinInit<Self, Error
         })
     }
 }
+
+/// Opaque bundle required to unload the GSP. Created by [`Gsp::boot`], consumed by [`Gsp::unload`].
+pub(crate) struct UnloadBundle(KBox<dyn hal::UnloadBundle>);
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 447c9b083039..2968178d0c6d 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -46,7 +46,7 @@ pub(crate) fn boot(
         chipset: Chipset,
         gsp_falcon: &Falcon<Gsp>,
         sec2_falcon: &Falcon<Sec2>,
-    ) -> Result {
+    ) -> Result<Option<super::UnloadBundle>> {
         let dev = pdev.as_ref();
         let hal = super::hal::gsp_hal(chipset);
 
@@ -57,8 +57,8 @@ pub(crate) fn boot(
 
         let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
 
-        // Perform the chipset-specific boot sequence.
-        hal.boot(
+        // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
+        let unload_bundle = hal.boot(
             self.as_mut(),
             dev,
             bar,
@@ -98,7 +98,7 @@ pub(crate) fn boot(
             Err(e) => dev_warn!(pdev, "GPU name unavailable: {:?}\n", e),
         }
 
-        Ok(())
+        Ok(unload_bundle.map(super::UnloadBundle))
     }
 
     /// Shut down the GSP and wait until it is offline.
@@ -130,16 +130,35 @@ pub(crate) fn unload(
         dev: &device::Device<device::Bound>,
         bar: &Bar0,
         gsp_falcon: &Falcon<Gsp>,
+        sec2_falcon: &Falcon<Sec2>,
+        unload_bundle: Option<super::UnloadBundle>,
     ) -> Result {
-        // Shut down the GSP.
-        Self::shutdown_gsp(
+        // Shut down the GSP. Keep going even in case of error.
+        let mut res = Self::shutdown_gsp(
             &self.cmdq,
             bar,
             gsp_falcon,
             commands::PowerStateLevel::Level0,
         )
-        .inspect_err(|e| dev_err!(dev, "Unload guest driver failed: {:?}\n", e))?;
+        .inspect_err(|e| dev_err!(dev, "GSP shutdown failed: {:?}\n", e));
 
-        Ok(())
+        // Run the unload bundle to reset the GSP so it can be booted again.
+        if let Some(unload_bundle) = unload_bundle {
+            res = res.and(
+                unload_bundle
+                    .0
+                    .run(dev, bar, gsp_falcon, sec2_falcon)
+                    .inspect_err(|e| dev_err!(dev, "Unload bundle failed: {:?}\n", e)),
+            );
+        } else {
+            dev_warn!(
+                dev,
+                "Unload bundle is missing, GSP won't be properly reset.\n"
+            );
+
+            res = Err(EAGAIN);
+        }
+
+        res.inspect(|()| dev_info!(dev, "GSP successfully unloaded\n"))
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index ae16fd6ba7fb..fe591c124a94 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -30,9 +30,28 @@
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
@@ -44,7 +63,7 @@ fn boot(
         wpr_meta: &Coherent<GspFwWprMeta>,
         gsp_falcon: &Falcon<GspEngine>,
         sec2_falcon: &Falcon<Sec2>,
-    ) -> Result;
+    ) -> Result<Option<KBox<dyn UnloadBundle>>>;
 
     /// Performs HAL-specific post-GSP boot tasks.
     ///
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 187fb7dbe40a..46ffc51dc385 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -18,7 +18,10 @@
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
@@ -41,7 +44,7 @@ fn boot(
         _wpr_meta: &Coherent<GspFwWprMeta>,
         _gsp_falcon: &Falcon<GspEngine>,
         _sec2_falcon: &Falcon<Sec2>,
-    ) -> Result {
+    ) -> Result<Option<KBox<dyn UnloadBundle>>> {
         Err(ENOTSUPP)
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index b7a88f3ecea9..fe6fcb84b03d 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -32,7 +32,10 @@
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
@@ -44,6 +47,124 @@
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
+struct Sec2UnloadBundle {
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
@@ -143,7 +264,7 @@ fn boot(
         wpr_meta: &Coherent<GspFwWprMeta>,
         gsp_falcon: &Falcon<GspEngine>,
         sec2_falcon: &Falcon<Sec2>,
-    ) -> Result {
+    ) -> Result<Option<KBox<dyn UnloadBundle>>> {
         let bios = Vbios::new(dev, bar)?;
 
         // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
@@ -175,7 +296,21 @@ fn boot(
         )?
         .run(dev, bar, sec2_falcon, wpr_meta)?;
 
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

