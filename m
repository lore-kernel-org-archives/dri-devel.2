Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CD8C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3615810EE90;
	Wed,  9 Sep 2026 04:00:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="EjNpAgvE";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27B7410EE90
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:00:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aR4rdddh+KO+dXKw7MNtUnfK66ojJjz3DoGiS12/1dktdO1moq3cLL5/VnRPMM7BfputRcngw4MH0dlO8+eGswUx7aLcBFHnwfw4ygrsZaVw44728j1/AWyJS6kG8xA3fc19lL2Nu/zckuvb7UtUdZ6DhxUeSEIR0TYaT87CB5LrIp+KfSw0LXSNgTKojTwGlrATPy7vrrmMQcnMPqEEcGkrpe31Exq1+OSYLwWkzbPvL3NLYnffe5fCzV3BSpGQrDey+f2Q5Unzut4tycnJlToudxs0X8oZmGQCDPrKbMfoy0UoIZ7hEZ6kW3SgnCfKQ+NdOxzkJKbqImcm0iJzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMPtr8qviiLeGsjIENXD9ecKTxUwCkEynyB9oU+f+nI=;
 b=ijlrEBWWyENEVtmjscto+y9ohsIAtqOHAZiDr6wJfChi/YQcqCYlxZRcmzUOo/i2yJ+L0NTqFjguucDyNw/zvkoWNJZv6sBp8xBsBwCOiK0YD48YIfXa5NDvXq1LdfRp5P8A9Yike+rK9Xem8ceZGpiu6tjMRMT0NHz7YBG2VhCX3uZTohTl1fROfbWiDWgiWgiAuHtk2d8HibepszR5ykQzqW6doD0H4COWj6YlTPxT6Ad8mIhVFelxIDVOKmOFR+beqWZSQBCaSMTX1N3l2F5sMhL/4KtAoj7N7zR7c+aWr27V8raWOqI0P9TVTl4PJaPGzGhQqyxhCWdJI+uEeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMPtr8qviiLeGsjIENXD9ecKTxUwCkEynyB9oU+f+nI=;
 b=EjNpAgvEBoe7m+Phy3w2ogSRf4p1Vg24Xcy2CtR+0L5lsEtQtXnwQWsZl0/zjO5bPO6MXT8aflrhOHxX/iupEVJLb8rM5TGUJ49Q9V/lSrNfynSJvJflSJ/oeuvLjiarVVIgyJdVLXFCWEHIFFjK1hZekB9idkzH/btF1BiKTEkVJLCyiEYyzWDdW/7em7VGMWdkTa9n8/P8JytHrGlfajHcFj8VJPhT6mZ1Q0sKTfErG2rFA6YnQ4UmJoGGh2vwdW/NBYXEviWJYUMzz1rrw+x3CVUuJeDbFZVuuoDHj36zmul8X5QadsdIJG1ehmcAYFN8RO68wbKvSyAVZrMbEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.7; Wed, 9 Sep 2026 04:00:50 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 04:00:50 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 09 Sep 2026 12:59:53 +0900
Subject: [PATCH 15/16] gpu: nova-core: mm: Add BAR1 user interface
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-mmrebase-v1-15-8dd5d4225d2e@nvidia.com>
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
In-Reply-To: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0293.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::11) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS0PR12MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2d3f85-aaf9-44da-1f07-08df0e26ef5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|10070799003|376014|366016|10067099003|6133799003|3023799007|7136999003|22082099003|18002099003|11062099010|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: XJ6PnzWcNDIVIxHLEOTA8aVlfG1a2Dqmxi56+RazeMgrZrHyMjcn2usERj7XvE3I+gBsr/vfBhGU++qe9Lt00Wf9HUA39tKUGTJvS1IGWsLeJtMheh3S1C3LxgqNY3woEEzi+88duKX8OtbVl2gGjLM2qzfHVZfA0OnO6BBopyG7AHjhdkiM8cnI/9IiA3G8jifCDhA4XsV1fFlDJllXUDoqWWkNDFEKXblbsvXvaIi06pMdCfBTmEcq4dYTr8Rda938OHQ3AZzurpnOCBqcw1opFHiDvL9xBuGI0RH6/KVk5UnEok0uyntUbQkzlgePqZGCLavg+5obzVBWUNq1qJmqiFPpoZdBKNyQ4mtRNcbBVcHu8scqGc4BzGoPOy3d2879VtMqtDe0CWL3eoFmHCzz5TCboxVWcFUThWNsOQ5B+zhg6BmhFNtT0B/+YlRcFgFoi3e8Rq3Q92SIVJBiR9zPDUq2aZ47/ZYorhYzBytzRmWgWdpELDmKXZ1+aTvpPjMadGfp5O58p/Ibr2X9OUKn0gi+qZtg9JPCmFkyqIAPhwK0yClvseNszXGeIpnLIcgDx/cnxr1fNYIGURf+qXMGtyffHRF8TUi4vGDYwJ9Tk533VD1lLEsrQ+Hkoc6RLdMK4KOGOu4yo5g2NF8xBN80MP3/WXENOQp5MJl4yeY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(10070799003)(376014)(366016)(10067099003)(6133799003)(3023799007)(7136999003)(22082099003)(18002099003)(11062099010)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWtXa0N4b1RvNTBnbFhUb3JPSWtKeXIxU1MvSWxQWFcvdjJHLzY0RnQrWm9J?=
 =?utf-8?B?aFVoUkorSWpxcTltREZPUEZNWElqRkR4N0dPcStGdGlOOXBVNG5tT1ltejIv?=
 =?utf-8?B?K2FZbzl0YlhVUXNWT21yeU9ITFdNM3lvVWRUWUtrUC9ZUHg3T1FTY0tSSXhp?=
 =?utf-8?B?aHdyZWwwRjVrQ1lnOGNLSUdJcVdYRmtnMnRMWXNNcHlWUjBZMFFPbGZzMTVu?=
 =?utf-8?B?ZUV3K0x3Q0V6QnpKY0d6ODBaWEFCS1pUTHNLbSs5QjczVzNBQUx3TTYrd3A4?=
 =?utf-8?B?MEVVOVk0ZzY4c2F0c2xSbzRrc3o5c0l1cm5yTGpRR3NSTmtjVUwrVzkyQWY0?=
 =?utf-8?B?eTJQaGk2ZUJpdnpYcm5lUld0cEw3NjdyWnlJNDVackhjWUNsMTZKUU03SHdT?=
 =?utf-8?B?VWptL1ljU1FocHQxT0JqMm5kSGQ2aG5rSjI1cTF6SDg0bmxVbWhBenQ1a00x?=
 =?utf-8?B?TmQ2T1FMZzNoejd2dStiYStmaEhYdDlWc2hiUUxmdUQ1QkRRQXh1Sy9pY3Na?=
 =?utf-8?B?amtjQ0l2NkRScm4vQzNGZHpYUnJIMkJCclN3VFI5ZFRFcGYxY3Z5bzhEWXMr?=
 =?utf-8?B?QnY5eXdIei8wR1hjYTgra1V0NFRRbEV3bFhLOUFwQ1ZmYzgxZGcra0k1V2Vo?=
 =?utf-8?B?dUFIS3RlN0huaDU4ZVNRdm40eVpuQVE1aGthVHQ4dm1GUkIxOFN0ajA3QlFT?=
 =?utf-8?B?OFRXMngvMnJFN2Q2OVQrTC85V1ZMZG5FTCtsN01VSDRCZkZhaXV3cnBLNnRZ?=
 =?utf-8?B?R0Z2T1hvcGg3ZnBGQ3FiR0J3a3AvaHkwQkJTNFZRT21TZ210STZNZ2ZzOXBs?=
 =?utf-8?B?WEtPcXRZUHFSRDFGVDVmUS9xRDZXQy9VYlc2ZlVUUWRCM0cyMzBTVklURGdI?=
 =?utf-8?B?MEY4NHp0aW16R2FVNThUOHZ5VXJCb3RwUU9qQVBGMllINkZvbzNOOVl0OWxk?=
 =?utf-8?B?aW1CdmV0ZnM3Ri9kR1JiM3AxcmdvM0ZTbk1RN3IvZDRaVml6L0hHalJjdlZO?=
 =?utf-8?B?c3FYaWozdE1mRE9wdWtVbzZ0WVlhTmNTWm84aHdMVytrS2JWS2pFQlowcVRl?=
 =?utf-8?B?VnhWN2Z0OEROa01EUTd4enlnWktHZVltM1YzNUZnK1k3SkxoY01hK2Z3akEy?=
 =?utf-8?B?QWNYMHU3S0M4K0RmYzhGRi9PT0t4bnRjcVcyZEUwRFNjQ2dCWE1QRlYxTXB6?=
 =?utf-8?B?UWU5dzBxOEhBbXhMQkdVbFhaOHJXVWR0d2VTZVZOblpSRm1kazBJcUdoUHdy?=
 =?utf-8?B?SW5wSnlKYm56UGZJRFA1ekc5M0IvT3VzWnFoWi8zcUpsU09wVjlZUHQ5OU5u?=
 =?utf-8?B?SlZIY0VudDRQNUhPTWJKbkNLMzBiVmNzSTl3dzdPczh6U05yc0pIL1lzTytr?=
 =?utf-8?B?RU9ISlN4T3N4OTBDbmFqYm1BWXhQRlhHbkY5OWpwZll5M1pGUUNrdDZnNXd3?=
 =?utf-8?B?NGgrWXUveHA5cHp6OVhBSFphcjRqVEJ1QkJheTNuVW42NURFeDhEdnVTY2xl?=
 =?utf-8?B?N2tKcDJjTVNNcmtHeFFqVXh5WXJuZU9HZ0o1YjBpbktQUTFEMzVidnBacVA1?=
 =?utf-8?B?YXl1MWc3MlArMHJqRGJjUU82R0t2eHV3RGZCb1FVWUdYdjFJc1RlUzgwaHlM?=
 =?utf-8?B?TUJTNGY3cFc5U0NkZDNueHR2MFZVRGJBNGQ0VERDOTA0L0gyb0pDRmhPNk8z?=
 =?utf-8?B?NUJ5K280czFLTmxsaEluMWdubkt4V3dCMVRDYk5scWg3N1YwSlRxYXhLSnI0?=
 =?utf-8?B?MU9BRDdVTC9PcExLNEwxOEhvMFlGTGUyRnI2c1BSVTNxcUNwL1cxeFZ6RE9G?=
 =?utf-8?B?d0g0RXpQSEo1VlFFTzBWME51M2g1QWcxdElTZVZEaVRWUVVOY3J1eUtEMWlt?=
 =?utf-8?B?eW5RZ3B3N25JYTg5WDgrRCt6c2tuaTY3dlJZS1NWcmlJdlFlZVphNVlEb290?=
 =?utf-8?B?Z0N6ZnY2ekdETHhFRzhuelFxWktsVEtsQTl0TWVEdGlRcFd0amNVYkZrWjlN?=
 =?utf-8?B?YVA4Y0RBNDRXTkNlcWsvMGtyZlBibGdOU3k1NFpwOGZybXg0TC9jRGZsMlJv?=
 =?utf-8?B?NnZ2UXpWcFpzUjVnUjNLMXhBRUxLaEpZVHFZQVh2c1NFb21oZDZ5bHNlM0pn?=
 =?utf-8?B?YS9QeGxUdk5vbmFYKzhNU3VCYTBaYksxU3lpa0pzallRUi9mdzhsTXlESTJj?=
 =?utf-8?B?c1o4N1VNUkI2Z1JXcElFSGJuOS9VZTFrZnNiMk84QWxwaWtZUDl0TFVZT3Zx?=
 =?utf-8?B?UGRKbGRCS2oyRHpvbzVCUXp6ekhzNmRxdEJ4ZTVyRW5lUnA4ZHF2TzlkeHlW?=
 =?utf-8?B?UTRscVVUa3AxZEozanRaNisxWFFMaVRiNWt0Z1dKd1VSc1RJWndzRjRub1Rp?=
 =?utf-8?Q?yG7LNA4rYH77A1DLYQANowhtl8VAAR3oWTTONBKhNVf3c?=
X-MS-Exchange-AntiSpam-MessageData-1: Lmb6KS0CuTGkBg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2d3f85-aaf9-44da-1f07-08df0e26ef5c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 04:00:49.9850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8C/PqwFJNNdByjnx4uu1EbkX10Z/G9oBIlwRgm2rYVv8rYGzfEs3m9dQST3zRn/+nqLlm46o1D66sYuwLsWaRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070
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

From: Joel Fernandes <joelagnelf@nvidia.com>

Add the BAR1 user interface for CPU access to GPU virtual memory through
the BAR1 aperture.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: map BAR1 in NovaCore, borrow it in Gpu and BarUser, no Devres]
[ecourtney: update for the VramAddress raw API and gsp_resources chipset]
[ecourtney: drop the owned GpuMm, pass it mutably through map and release]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs       |  45 +++++++--
 drivers/gpu/nova-core/gpu.rs          |  32 ++++++-
 drivers/gpu/nova-core/gsp/commands.rs |   1 -
 drivers/gpu/nova-core/mm.rs           |   1 +
 drivers/gpu/nova-core/mm/bar_user.rs  | 171 ++++++++++++++++++++++++++++++++++
 5 files changed, 240 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 5723ff8f71ea..0672a0707a71 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -2,7 +2,11 @@
 
 use kernel::{
     auxiliary,
-    device::Core,
+    device::{
+        Bound,
+        Core, //
+    },
+    io::resource,
     pci,
     pci::{
         Class,
@@ -28,6 +32,7 @@ pub(crate) struct NovaCore<'bound> {
     #[pin]
     pub(crate) gpu: Gpu<'bound>,
     bar: pci::Bar<'bound, BAR0_SIZE>,
+    bar1: Bar1<'bound>,
     #[allow(clippy::type_complexity)]
     _reg: auxiliary::Registration<'bound, CovariantForLt!(())>,
 }
@@ -38,9 +43,27 @@ pub(crate) struct NovaCore<'bound> {
 
 pub(crate) type Bar0<'a> = &'a pci::Bar<'a, BAR0_SIZE>;
 pub(crate) type NovaRegisters = kernel::io::Region<BAR0_SIZE>;
-#[expect(dead_code)]
 pub(crate) type Bar1<'a> = pci::Bar<'a>;
 
+/// Returns the Linux PCI resource index that holds BAR1 for an NVIDIA GPU.
+///
+/// On Maxwell through Ada, BAR0 is a 32-bit memory BAR occupying a single
+/// Linux PCI resource slot, so BAR1 lives at index 1. Starting with Blackwell
+/// (and on some Ampere GA100 / Hopper SKUs) BAR0 is a 64-bit memory BAR that
+/// consumes two consecutive resource slots: index 0 holds the low 32 bits and
+/// index 1 holds the high 32 bits (with no `flags` / or size of its own),
+/// shifting BAR1 to index 2.
+pub(crate) fn bar1_resource_index(pdev: &pci::Device<Bound>) -> Result<u32> {
+    // Probe the `IORESOURCE_MEM_64` flag of BAR0 as a robust way of exposing
+    // if BAR0 and hence BAR1 is 64-bit.
+    let flags0 = pdev.resource_flags(0)?;
+    if flags0.contains(resource::Flags::IORESOURCE_MEM_64) {
+        Ok(2)
+    } else {
+        Ok(1)
+    }
+}
+
 kernel::pci_device_table!(
     PCI_TABLE,
     <NovaCoreDriver as pci::Driver>::IdInfo,
@@ -82,12 +105,18 @@ fn probe<'bound>(
 
             Ok(try_pin_init!(NovaCore {
                 bar: pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core/bar0")?,
-                // TODO: Use `&bar` self-referential pin-init syntax once available.
-                //
-                // SAFETY: `bar` is initialized before this expression is evaluated
-                // (`try_pin_init!()` initializes fields in declaration order), lives at a pinned
-                // stable address, and is dropped after `gpu` (struct field drop order).
-                gpu <- Gpu::new(pdev, unsafe { &*core::ptr::from_ref(bar) }),
+                bar1: {
+                    let bar1_idx = bar1_resource_index(pdev)?;
+                    pdev.iomap_region(bar1_idx, c"nova-core/bar1")?
+                },
+                // TODO: Use self-referential pin-init syntax once available.
+                gpu <- Gpu::new(
+                    pdev,
+                    // SAFETY: `bar` is initialized above, pinned, and outlives `gpu`.
+                    unsafe { &*core::ptr::from_ref(bar) },
+                    // SAFETY: `bar1` is initialized above, pinned, and outlives `gpu`.
+                    unsafe { &*core::ptr::from_ref(bar1) },
+                ),
                 // Run optional GPU selftests.
                 #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
                 _: { gpu.run_selftests(pdev) },
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index b797472279d3..f72a92e045e5 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -16,11 +16,15 @@
         SizeConstants,
         SZ_4K, //
     },
+    sync::Arc,
 };
 
 use crate::{
     bounded_enum,
-    driver::Bar0,
+    driver::{
+        Bar0,
+        Bar1, //
+    },
     falcon::{
         gsp::Gsp as GspFalcon,
         sec2::Sec2 as Sec2Falcon,
@@ -35,6 +39,8 @@
         GspBootContext, //
     },
     mm::{
+        bar_user::BarUser,
+        pagetable::MmuVersion,
         GpuMm,
         VramAddress, //
     },
@@ -148,6 +154,11 @@ pub(crate) const fn arch(self) -> Architecture {
     pub(crate) fn pci_config_mirror_range(self) -> Range<u32> {
         hal::gpu_hal(self).pci_config_mirror_range()
     }
+
+    /// Returns the MMU version for this chipset.
+    pub(crate) fn mmu_version(self) -> MmuVersion {
+        MmuVersion::from(self.arch())
+    }
 }
 
 // TODO
@@ -297,6 +308,8 @@ pub(crate) struct Gpu<'gpu> {
     /// Must be kept declared *before* `gsp_resources`, so that its components are dropped while
     /// the GSP is still operational.
     mm: GpuMm<'gpu>,
+    /// BAR1 user interface for CPU access to GPU virtual memory.
+    bar_user: Arc<BarUser<'gpu>>,
     /// GSP and its resources.
     #[pin]
     gsp_resources: GspResources<'gpu>,
@@ -340,6 +353,7 @@ impl<'gpu> Gpu<'gpu> {
     pub(crate) fn new<'a>(
         pdev: &'gpu pci::Device<device::Core<'a>>,
         bar: Bar0<'gpu>,
+        bar1: &'gpu Bar1<'gpu>,
     ) -> impl PinInit<Self, Error> + use<'gpu, 'a> {
         let dev = pdev.as_ref();
 
@@ -442,6 +456,22 @@ pub(crate) fn new<'a>(
                     VramAddress::from_raw(gsp_static_info.total_fb_end),
                 )?
             },
+
+            // Create BAR1 user interface for CPU access to GPU virtual memory.
+            bar_user: {
+                let pdb_addr = VramAddress::from_raw(gsp_static_info.bar1_pde_base);
+                let bar1_idx = crate::driver::bar1_resource_index(pdev)?;
+                let bar1_size = pdev.resource_len(bar1_idx)?;
+                Arc::pin_init(
+                    BarUser::new(
+                        pdb_addr,
+                        gsp_resources.spec.chipset,
+                        bar1_size,
+                        bar1,
+                    )?,
+                    GFP_KERNEL,
+                )?
+            },
         })
     }
 
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 1c467718c679..663e1d124781 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -215,7 +215,6 @@ fn init(&self) -> impl Init<Self::Command, Self::InitError> {
 pub(crate) struct GetGspStaticInfoReply {
     gpu_name: [u8; 64],
     /// BAR1 Page Directory Entry base address.
-    #[expect(dead_code)]
     pub(crate) bar1_pde_base: u64,
     /// Usable FB (VRAM) regions for driver memory allocation.
     pub(crate) usable_fb_regions: KVec<Range<u64>>,
diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 2cf37254fbb9..e04497256519 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -60,6 +60,7 @@ macro_rules! impl_pfn_bounded {
 
 pub(crate) use tlb::Tlb;
 
+pub(crate) mod bar_user;
 mod hal;
 pub(super) mod pagetable;
 mod pramin;
diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
new file mode 100644
index 000000000000..ef1d8e6f8c9c
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! BAR1 user interface for CPU access to GPU virtual memory. Used for USERD
+//! for GPU work submission, and applications to access GPU buffers via mmap().
+
+use kernel::{
+    io::Io,
+    new_mutex,
+    prelude::*,
+    sync::{
+        Arc,
+        Mutex, //
+    },
+};
+
+use crate::{
+    driver::Bar1,
+    gpu::Chipset,
+    mm::{
+        vmm::{
+            MappedRange,
+            Vmm, //
+        },
+        GpuMm,
+        Pfn,
+        Vfn,
+        VirtualAddress,
+        VramAddress,
+        PAGE_SIZE, //
+    },
+    num::IntoSafeCast,
+};
+
+/// BAR1 user interface for virtual memory mappings.
+///
+/// Owns the [`Vmm`] for the BAR1 address space.
+#[pin_data]
+pub(crate) struct BarUser<'gpu> {
+    #[pin]
+    vmm: Mutex<Vmm>,
+    bar1: &'gpu Bar1<'gpu>,
+}
+
+impl<'gpu> BarUser<'gpu> {
+    /// Create a pin-initializer for [`BarUser`].
+    pub(crate) fn new(
+        pdb_addr: VramAddress,
+        chipset: Chipset,
+        va_size: u64,
+        bar1: &'gpu Bar1<'gpu>,
+    ) -> Result<impl PinInit<Self> + 'gpu> {
+        let vmm = Vmm::new(pdb_addr, chipset.mmu_version(), va_size)?;
+        Ok(pin_init!(Self {
+            vmm <- new_mutex!(vmm, "bar_user_vmm"),
+            bar1,
+        }))
+    }
+
+    /// Map physical pages to a contiguous BAR1 virtual range.
+    pub(crate) fn map(
+        self: &Arc<Self>,
+        mm: &mut GpuMm<'_>,
+        pfns: &[Pfn],
+        writable: bool,
+    ) -> Result<BarUserAccess<'gpu>> {
+        if pfns.is_empty() {
+            return Err(EINVAL);
+        }
+        let mut vmm = self.vmm.lock();
+        let mapped = vmm.map_pages(mm, pfns, None, writable)?;
+
+        Ok(BarUserAccess {
+            bar_user: self.clone(),
+            mapped: Some(mapped),
+        })
+    }
+}
+
+/// Access object for a mapped BAR1 region.
+pub(crate) struct BarUserAccess<'gpu> {
+    bar_user: Arc<BarUser<'gpu>>,
+    /// [`BarUserAccess::release`] [`Option::take`]s this; `Some` at
+    /// drop time means `release()` was never called.
+    mapped: Option<MappedRange>,
+}
+
+impl BarUserAccess<'_> {
+    /// Tear down the BAR1 mapping.
+    pub(crate) fn release(mut self, mm: &mut GpuMm<'_>) -> Result {
+        let mapped = self.mapped.take().ok_or(EINVAL)?;
+        let mut vmm = self.bar_user.vmm.lock();
+        vmm.unmap_pages(mm, mapped)?;
+        Ok(())
+    }
+
+    /// Returns the active mapping.
+    fn mapped(&self) -> &MappedRange {
+        // `mapped` is only `None` after `take()` in `release`; hence unwrap()
+        // cannot panic here.
+        self.mapped.as_ref().unwrap()
+    }
+
+    /// Get the base virtual address of this mapping.
+    pub(crate) fn base(&self) -> VirtualAddress {
+        VirtualAddress::from(self.mapped().vfn_start)
+    }
+
+    /// Get the total size of the mapped region in bytes.
+    pub(crate) fn size(&self) -> usize {
+        self.mapped().num_pages * PAGE_SIZE
+    }
+
+    /// Get the starting virtual frame number.
+    pub(crate) fn vfn_start(&self) -> Vfn {
+        self.mapped().vfn_start
+    }
+
+    /// Get the number of pages in this mapping.
+    pub(crate) fn num_pages(&self) -> usize {
+        self.mapped().num_pages
+    }
+
+    /// Translate an offset within this mapping to a BAR1 aperture offset.
+    fn bar_offset(&self, offset: usize) -> Result<usize> {
+        if offset >= self.size() {
+            return Err(EINVAL);
+        }
+
+        let base_vfn: usize = self.mapped().vfn_start.raw().into_safe_cast();
+        let base = base_vfn.checked_mul(PAGE_SIZE).ok_or(EOVERFLOW)?;
+        base.checked_add(offset).ok_or(EOVERFLOW)
+    }
+
+    // Fallible accessors with runtime bounds checking.
+
+    /// Read a 32-bit value at the given offset.
+    pub(crate) fn try_read32(&self, offset: usize) -> Result<u32> {
+        let off = self.bar_offset(offset)?;
+        self.bar_user.bar1.try_read32(off)
+    }
+
+    /// Write a 32-bit value at the given offset.
+    pub(crate) fn try_write32(&self, value: u32, offset: usize) -> Result {
+        let off = self.bar_offset(offset)?;
+        self.bar_user.bar1.try_write32(value, off)
+    }
+
+    /// Read a 64-bit value at the given offset.
+    pub(crate) fn try_read64(&self, offset: usize) -> Result<u64> {
+        let off = self.bar_offset(offset)?;
+        self.bar_user.bar1.try_read64(off)
+    }
+
+    /// Write a 64-bit value at the given offset.
+    pub(crate) fn try_write64(&self, value: u64, offset: usize) -> Result {
+        let off = self.bar_offset(offset)?;
+        self.bar_user.bar1.try_write64(value, off)
+    }
+}
+
+impl Drop for BarUserAccess<'_> {
+    fn drop(&mut self) {
+        if self.mapped.is_some() {
+            kernel::pr_warn!(
+                "BarUserAccess dropped without calling release(). BarUser address space will leak.\n"
+            );
+        }
+        // The inner `MappedRange`'s own `MustUnmapGuard` will also fire,
+        // identifying the leaked VA range.
+    }
+}

-- 
2.55.0

