Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA90FCA5FAD
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F6F410E9F4;
	Wed, 30 Sep 2026 02:44:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="o0bbyqan";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012021.outbound.protection.outlook.com
 [40.93.195.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EB0110E9F4
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 02:44:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oe1S/Lg4UJHuOeQcigWQD7h6Bplw6BZVk+ObDlp4Izp6gqgvXtS9C9JH6DhdF8EBn4hCUL/he7bDA+cJYykQDjqNPl49Tdak62qbhmlAVpI8VmEqG+H4l3VJEPI2LgA/Jh+JqXuvpWBS8t+WzpI4J6WPx9i1hshQfk71SuMJZgoxNN5uURp6+2cvNyTrY4WjLlU/DCYhC/E//h23Roi7rGgxWQSr196Atrw6BPJbP2LiyjBRKlAB5nvOvSghY4m36TlMwOAz6mFVCWpA41bXXyHIpF7qwx+kq9yQ91ZbNYWREKsBac8iRy+mxNoPV44v6DrScXfOjNZBPVv81XdtTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwKMUxwz3LWBROLsrEpxE7WbG4KsLMnFOOkpo5ANuSI=;
 b=E1vTr4vFuhAF4nvKxl5vX90jd+3FBEa6f4K/Rve2n/NX9D7cZwZUNZMngVzgYyv4fFdYQztke8m6DPEsY3NcZMrYfsd+JYRrzfpYrBVUGMlU3URCjVfiOs/Yg/FqFHR0xfpHd/+Tng06wSosMpFBy2DLm+tNKdnlpkaroahOA0/tkkblONOG2P3rH4MEAeH0O4Pr/F5sBTlhsgnB1HDlgFa7yvAjUWJ8pMR3b2lmeE+usYOiWMki4CPByn4xSl228v9QgEhZoSxvZRgkMUAnx9WqbQuoEXYEMHullfYAjuhZucwzxU+Z/HbfnOCuuC6ZwvTjtEuxbG9g+syHj5cQrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwKMUxwz3LWBROLsrEpxE7WbG4KsLMnFOOkpo5ANuSI=;
 b=o0bbyqan8ndygEx9LFtHTPzO+RZCNtr98/fvpdU16YbVJ+GlkKQbx/q4S2nHMxfbI/m1DkroodLM1DoogoQwZsmZOuhovB3mMNXnxlVt4qSAzxu9fXTwRpSboGvd5DB2szhxMcRVMCMVgs2LgLRb1dGYi4QcqFOvANd59f10oIcdQJo+NQbpet0ApemzjQ4WlM48WYOHBFdrIrhRn4NLqjrOsCOW3OY2eJeq+Ek5jJzZ+S8zi4jX/0dlSB/XMcUQmMnK2y9cVkzhh3tBp33V4u4YLs/A/VQxXqZVYv9hr1PMNQd1OFyvLTLQjDvNm18kENHiH4/qphJ2kgnviXyywA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 02:44:39 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 02:44:39 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 30 Sep 2026 11:42:54 +0900
Subject: [PATCH v9 5/9] rust: use Alignment size constants
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-chid-v9-5-0d6cca376cff@nvidia.com>
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
In-Reply-To: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0036.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::6) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 29140a2b-8c04-4137-75b0-08df1e9cc5d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|7416014|376014|1800799024|366016|10067099003|56012099006|921020|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PK9BbmIIuuAQVUPug7WjIXXDne+zn8eIHr1lDPDQBdr9LvJg3tbZgXznLpWlEuIJHwdLFnwjDyFDvtVZpxaUti4g+0cwg6rmdM4Orv5mrP1qe+gwGeLrK//UDx5EUU3bhhXB0SI5Rqj0ci9ddUtWahLXSkYk71QLoAgVWPMfXbLBo0pY8oyagNzDOT9SsgXOb+kCuimKViB6mq9O8e6wELWDUiRQSUdxWWgaleVT5x316OmxujRIeIVbS/hqOeHrISexmcR6ObnUn4wfJZpo/+IiUPP/8FsfTiHrdbPqH1aAhBFH7St5gizqr/RMFwUFe+Z44gaQ49eTLaAQn2ocZfTmqNVkKooVvWmnkYrKc6dz4ghJWB4rx/AldYKSs7/jhJMC/ujTqwScen4D5v/PxQbODoSH9JH0IU5gTlqyWBBGtCEzQZwTHR/O3X1QJ16aYaLkXvlzG8BO8dvvSENAQMOzih/57u1eSK52Q2ySVjrQlr/SaZZ1k+R4GvcsNKMpDDNZMAWyhfwmltcstAnG4O6QUPvQ96/xxlLgZGLRhPM81sgGRjTBPqcsnMMxCfsqzmTjTbd9f1vj+fP2fuvGGV/h9dm93I4H8p5Axg5SMlv+USWRJdyMscMULVZ1YLYaVKci6QM6QCCOTYJmRbJE2HPZK6GM8UpatlTQ95z0tw69NNyycoQJbMqivk5Mnlsy7P3Rux7c7D2IVxDTpVxw+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(921020)(6133799003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXpSZlgxQ3ZQNVlPRHRFcklSanJjZUF1STZoWjRMMVdYY1prdG12blR1RkUw?=
 =?utf-8?B?S2VsMk1FV3MyMG9raVlPMEg2dlhzV3c2UTdyaHRUSVo4eW4yYllXRzhWZDJZ?=
 =?utf-8?B?MVZ3ZDV2di9xaUVibTd4RlI0MFUwZmpqNytZSC9RUFBjUEQrUHh6T0lqNU1p?=
 =?utf-8?B?RkNTcHRYVEJtUlZ4R0VOYmtETWowYVRabHJjWU9zUkVsSjdOSWpSSHhhN1Vm?=
 =?utf-8?B?UFJtcVp0NUdGTzNsK1NMNlhCOVBWVldLV2luUTFkbVZTSXlmOGVhMmdmR09Q?=
 =?utf-8?B?NElBSnZXSEUxVlpvTTBPRTA3dmNTVGl1bWtVSWF0ZHJQbFVjOUorcHphOEN5?=
 =?utf-8?B?OWNVaTNYV0RxUnN1ZVBkWmlTR3Uwb0tIQjZDalgwR2JDNkJWUjFWb21Ebk9B?=
 =?utf-8?B?UFRib0ZDTUJpNGpmT0pEck92QjFLRWhUUUNXMURtczVQeWZ4SzF0d1NnaWZC?=
 =?utf-8?B?VEVuWnJKYzAzWmFDSTJNamcxeWJnVXNHOWJuSDFyaWlLbElYRXJiVzhYTjFw?=
 =?utf-8?B?dWlQL2d6K1VhR1praVlzZ0N3cWo2TW9tbTNja2N4NXdkcjROdFFFMHIzV0hy?=
 =?utf-8?B?bU93TnliQ2pGNmpmTUo3cmNyMzVMekNLb0hRVThHa2JiNEdCNzlDaFB0akQw?=
 =?utf-8?B?aG9KZVlwcTViV1VIeWovK3YwYWRZTGt4UWlPOUxKWllUTWhHSUxUak9OTnZs?=
 =?utf-8?B?ZDl6NGpvZEVPa1dINEhSMzJNZXNNVDZzajhFTktqeUN1UndDZHFvRUxZL2R0?=
 =?utf-8?B?U20vM3BtYWhKV3RYdDBTV3l3REVqUnFhMWI2eFdBejFkWFkxOHh0b2NwMyt1?=
 =?utf-8?B?RTdDekQ5YWtlOXU2cHk1WFc1Wm1ScXlYOFE3aU1zTUlCTVBoeVZxOVhNVVhz?=
 =?utf-8?B?OExhOXpxYWNWTitBZUdiKzZNd0NHMFdQRDlVaTlQclU0OU1OTFNTUHlyQlNw?=
 =?utf-8?B?MFdxVWYzeFc5cVZGaGxPcnZtTHdVd2wyNmdDMGFMWjV5aEI4QTJLTnZic2oz?=
 =?utf-8?B?NTVSOHRnV2hmZXVudjFNaEdUV0RUZ09tUEFBbGQ0ZDVNM011RmxIT0VmRlRo?=
 =?utf-8?B?KzVVc1krTDErTzBVWlYyeFQ5RXYxNlAvYU5LNzRBbjB3NjJSUS9mMDlTakhZ?=
 =?utf-8?B?c2lBQnhCTk5zc25pQkVNaVBFRWlGNUVOSGtiNUNvYVJJY3ppem9rQXh1Sm54?=
 =?utf-8?B?Mnl3ZDZsN0t6c1UzczY1d1FCbC9Ua1R5SEV3eGsyMWJLWGdnUnIvN05XREJE?=
 =?utf-8?B?NHBTRU1RWk1sRDdUZDdndEZYVnZSQnVQL0E0MlRrcVdBYjEvei9MTGNBeklJ?=
 =?utf-8?B?TVBHMjZIN2FsSllJWUtPUzYvbUVmTFN1ei9tZkpTbU1SRUR3VnpoNjg0Qjk0?=
 =?utf-8?B?MFdmR1o0NjdySEc2a0F2cjRlR0Y1dEl1SEN5ZEk4bnVqaVZ0Vlh4bkl1dXhZ?=
 =?utf-8?B?VmFWd1NCR3pSOHMvbUh1SGE3SThKY0F6Rzl3L3NUS2Ixa0tIWnVlRFdKcytM?=
 =?utf-8?B?ZzZZc1NrYTZqNy92QUFPRlc4bmg2RndhQjhqc1BpeVl3dXhSbkVkdU1rTGtw?=
 =?utf-8?B?SzgrZ0syZkRvelZVQ0RHelBoRE14YXFGOWlBcmlJVlQrb0JyWkxETGtva0FX?=
 =?utf-8?B?QjNoY0FRc29YWmgxN0lrTWRQTE93Y0czd1hWT3l5amhvUDlLcEgwQzdvQ0Vp?=
 =?utf-8?B?QStQZEFyait0eHZDVUo2SS90Njg2YUM4V2ZLSTNVN0xHczJEbE9wMWxiYzlq?=
 =?utf-8?B?ZXJlZm9ZVWpBNGRmZSs0SDhjY2l4d091MThTQWxaVTF4czNQUnRsckY1enRO?=
 =?utf-8?B?QjVVSk9vR3NsYTNndXhSVzBNRWlIY0lKWWt4TDR6a0czVm91dlRjcytCRW1r?=
 =?utf-8?B?WUVnV0c3MkZhVytkdWxhM2oyelpLUlFzc05oYS9PdmthVC9WMm85QmpLSkpo?=
 =?utf-8?B?R21QQnBiU2oraERrWHJCcC91amszZFRlOWxKYWVUMVc1UVpkejhTVTRNT1o3?=
 =?utf-8?B?ak96dEdRZGhiSU1RUTFYbHE1M1R5dXVJdHBOMFo3UXBWZ0dQVXJHeVdYOWVK?=
 =?utf-8?B?REs0YnVDakRTbXFTSDU2Z3FRa2YwSHdoZlVEYjBHSDlvckZQUDVuQ0M0ZURV?=
 =?utf-8?B?bU9yUU40d1FjYUJTbGtUWXQ1blBaSHp5dUJZRE53Z3c4dFp5REdlSkQyRllr?=
 =?utf-8?B?ZHErbnYrWm9hcWh0TG5ER09ucmJIMEtnWVFjektXR0s2Y3M0UFc2SnhDcFNX?=
 =?utf-8?B?VlBVMy9YNHNBQ3ZsYlpqeWtPVVZHTXBuUzlPRWk1VS9vdE50cjJXZE9haC9C?=
 =?utf-8?B?WEMwaXo4bmN2RkJzSGxuM1IvaHdQRElvc0FOSFFaUCtDdHQvTTY3S0ROUWZQ?=
 =?utf-8?Q?XFlWFwcJtUCReEVTg2Ati+ZOpxvtcno7kwmIryiPoYS9b?=
X-MS-Exchange-AntiSpam-MessageData-1: 7WuEGTcISsVSHQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29140a2b-8c04-4137-75b0-08df1e9cc5d2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 02:44:39.5281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5z5Sl0F7A9oepZGV+qJ6eg306cPe9FciSxyW3CjvkDPFP6UQH6EYyv6kGpJHl+30uhOHdNuVkUrN7yIbr/OHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523
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

Use `SizeConstants` for Alignment that are implemented now.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/fb.rs           | 10 +++++-----
 drivers/gpu/nova-core/fb/hal/gb100.rs |  2 +-
 drivers/gpu/nova-core/fsp.rs          |  4 ++--
 drivers/gpu/nova-core/gsp/fw.rs       | 12 +++---------
 drivers/gpu/nova-core/vbios.rs        |  7 +++++--
 rust/kernel/gpu/buddy.rs              | 26 +++++++++++++-------------
 rust/kernel/io.rs                     |  5 +++--
 7 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index b0c0b8fe6008..5ceb7760c78e 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -219,7 +219,7 @@ pub(crate) fn new(
         };
 
         let frts = {
-            const FRTS_DOWN_ALIGN: Alignment = Alignment::new::<SZ_128K>();
+            const FRTS_DOWN_ALIGN: Alignment = Alignment::SZ_128K;
             let frts_size: u64 = hal.frts_size();
             let frts_base = vga_workspace.start.align_down(FRTS_DOWN_ALIGN) - frts_size;
 
@@ -227,7 +227,7 @@ pub(crate) fn new(
         };
 
         let boot = {
-            const BOOTLOADER_DOWN_ALIGN: Alignment = Alignment::new::<SZ_4K>();
+            const BOOTLOADER_DOWN_ALIGN: Alignment = Alignment::SZ_4K;
             let bootloader_size = u64::from_safe_cast(gsp_fw.bootloader.ucode.size());
             let bootloader_base = (frts.start - bootloader_size).align_down(BOOTLOADER_DOWN_ALIGN);
 
@@ -235,7 +235,7 @@ pub(crate) fn new(
         };
 
         let fw_image = {
-            const FW_IMAGE_DOWN_ALIGN: Alignment = Alignment::new::<SZ_64K>();
+            const FW_IMAGE_DOWN_ALIGN: Alignment = Alignment::SZ_64K;
             let fw_image_size = u64::from_safe_cast(gsp_fw.size());
             let fw_image_addr = (boot.start - fw_image_size).align_down(FW_IMAGE_DOWN_ALIGN);
 
@@ -245,7 +245,7 @@ pub(crate) fn new(
         let (vf_partition_count, wpr2_heap_size) = wpr2_heap_params(chipset, vgpu_state, fb.end)?;
 
         let wpr2_heap = {
-            const WPR2_HEAP_DOWN_ALIGN: Alignment = Alignment::new::<SZ_1M>();
+            const WPR2_HEAP_DOWN_ALIGN: Alignment = Alignment::SZ_1M;
             let wpr2_heap_addr = fw_image
                 .start
                 .checked_sub(wpr2_heap_size)
@@ -256,7 +256,7 @@ pub(crate) fn new(
         };
 
         let wpr2 = {
-            const WPR2_DOWN_ALIGN: Alignment = Alignment::new::<SZ_1M>();
+            const WPR2_DOWN_ALIGN: Alignment = Alignment::SZ_1M;
             let wpr2_addr = (wpr2_heap.start - u64::from_safe_cast(size_of::<gsp::GspFwWprMeta>()))
                 .align_down(WPR2_DOWN_ALIGN);
 
diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-core/fb/hal/gb100.rs
index 612f70333c11..37b2ae762df4 100644
--- a/drivers/gpu/nova-core/fb/hal/gb100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
@@ -80,7 +80,7 @@ fn write_sysmem_flush_page_gb100(hshub0: Mmio<'_, regs::Hshub0Registers>, addr:
 
 // This PMU reservation size is r570-specific.
 pub(super) const fn pmu_reserved_size_gb100() -> u32 {
-    cv!(const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::new::<SZ_128K>()).unwrap())
+    cv!(const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::SZ_128K).unwrap())
 }
 
 impl FbHal for Gb100 {
diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index 3a4a10487f33..637a00b2c951 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -20,7 +20,7 @@
         Alignable,
         Alignment, //
     },
-    sizes::SZ_2M,
+    sizes::SizeConstants,
     time::Delta,
     transmute::{
         AsBytes,
@@ -259,7 +259,7 @@ fn frts_vidmem_offset(hal: &dyn hal::FspHal, fb_info: &FbSizes) -> Result<u64> {
         if fb_info.pmu_reserved_size != 0 {
             offset = (offset + u64::from(fb_info.pmu_reserved_size))
                 // The 2 MiB alignment is r570-specific.
-                .align_up(Alignment::new::<SZ_2M>())
+                .align_up(Alignment::SZ_2M)
                 .ok_or(EINVAL)?;
         }
 
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 1b548bbf146e..b4866ad21f6e 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -25,10 +25,7 @@
         Alignment,
         KnownSize, //
     },
-    sizes::{
-        SizeConstants,
-        SZ_128K, //
-    },
+    sizes::SizeConstants,
     transmute::{
         AsBytes,
         FromBytes, //
@@ -63,7 +60,7 @@
 enum GspFwHeapParams {}
 
 /// Minimum required alignment for the GSP heap.
-const GSP_HEAP_ALIGNMENT: Alignment = Alignment::new::<{ 1 << 20 }>();
+const GSP_HEAP_ALIGNMENT: Alignment = Alignment::SZ_1M;
 
 impl GspFwHeapParams {
     /// Returns the amount of GSP-RM heap memory used during GSP-RM boot and initialization (up to
@@ -207,10 +204,7 @@ pub(crate) fn from_ranges<'a>(
             bootBinOffset: ranges.boot.start,
             frtsOffset: ranges.frts.start,
             frtsSize: ranges.frts.len(),
-            gspFwWprEnd: ranges
-                .vga_workspace
-                .start
-                .align_down(Alignment::new::<SZ_128K>()),
+            gspFwWprEnd: ranges.vga_workspace.start.align_down(Alignment::SZ_128K),
             gspFwHeapVfPartitionCount: ranges.vf_partition_count,
             fbSize: ranges.fb.len(),
             vgaWorkspaceOffset: ranges.vga_workspace.start,
diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 9c214b9f4dd9..a2d2d170b501 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -11,7 +11,10 @@
         Alignment, //
     },
     register,
-    sizes::SZ_4K,
+    sizes::{
+        SizeConstants,
+        SZ_4K, //
+    },
     sync::aref::ARef,
 };
 
@@ -291,7 +294,7 @@ fn next(&mut self) -> Option<Self::Item> {
 
         // Advance to next image (aligned to 512 bytes).
         self.current_offset += image_size;
-        self.current_offset = self.current_offset.align_up(Alignment::new::<512>())?;
+        self.current_offset = self.current_offset.align_up(Alignment::SZ_512)?;
 
         Some(Ok(full_image))
     }
diff --git a/rust/kernel/gpu/buddy.rs b/rust/kernel/gpu/buddy.rs
index d502ada6ebbd..691bb40629d4 100644
--- a/rust/kernel/gpu/buddy.rs
+++ b/rust/kernel/gpu/buddy.rs
@@ -31,11 +31,11 @@
 //! let buddy = GpuBuddy::new(GpuBuddyParams {
 //!     base_offset: 0,
 //!     size: SZ_1G as u64,
-//!     chunk_size: Alignment::new::<SZ_4K>(),
+//!     chunk_size: Alignment::SZ_4K,
 //! })?;
 //!
 //! assert_eq!(buddy.size(), SZ_1G as u64);
-//! assert_eq!(buddy.chunk_size(), Alignment::new::<SZ_4K>());
+//! assert_eq!(buddy.chunk_size(), Alignment::SZ_4K);
 //! let initial_free = buddy.avail();
 //!
 //! // Allocate 16MB. Block lands at the top of the address range.
@@ -43,7 +43,7 @@
 //!     buddy.alloc_blocks(
 //!         GpuBuddyAllocMode::Simple,
 //!         SZ_16M as u64,
-//!         Alignment::new::<SZ_16M>(),
+//!         Alignment::SZ_16M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -74,14 +74,14 @@
 //! # let buddy = GpuBuddy::new(GpuBuddyParams {
 //! #     base_offset: 0,
 //! #     size: SZ_1G as u64,
-//! #     chunk_size: Alignment::new::<SZ_4K>(),
+//! #     chunk_size: Alignment::SZ_4K,
 //! # })?;
 //! # let initial_free = buddy.avail();
 //! let topdown = KBox::pin_init(
 //!     buddy.alloc_blocks(
 //!         GpuBuddyAllocMode::TopDown,
 //!         SZ_16M as u64,
-//!         Alignment::new::<SZ_16M>(),
+//!         Alignment::SZ_16M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -114,7 +114,7 @@
 //! # let buddy = GpuBuddy::new(GpuBuddyParams {
 //! #     base_offset: 0,
 //! #     size: SZ_1G as u64,
-//! #     chunk_size: Alignment::new::<SZ_4K>(),
+//! #     chunk_size: Alignment::SZ_4K,
 //! # })?;
 //! # let initial_free = buddy.avail();
 //! // Create fragmentation by allocating 4MB blocks at [0,4M) and [8M,12M).
@@ -122,7 +122,7 @@
 //!     buddy.alloc_blocks(
 //!         GpuBuddyAllocMode::Range(0..SZ_4M as u64),
 //!         SZ_4M as u64,
-//!         Alignment::new::<SZ_4M>(),
+//!         Alignment::SZ_4M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -133,7 +133,7 @@
 //!     buddy.alloc_blocks(
 //!         GpuBuddyAllocMode::Range(SZ_8M as u64..(SZ_8M + SZ_4M) as u64),
 //!         SZ_4M as u64,
-//!         Alignment::new::<SZ_4M>(),
+//!         Alignment::SZ_4M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -145,7 +145,7 @@
 //!     buddy.alloc_blocks(
 //!         GpuBuddyAllocMode::Range(0..SZ_16M as u64),
 //!         SZ_8M as u64,
-//!         Alignment::new::<SZ_4M>(),
+//!         Alignment::SZ_4M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -178,14 +178,14 @@
 //! let small = GpuBuddy::new(GpuBuddyParams {
 //!     base_offset: 0,
 //!     size: SZ_16M as u64,
-//!     chunk_size: Alignment::new::<SZ_4K>(),
+//!     chunk_size: Alignment::SZ_4K,
 //! })?;
 //!
 //! let _hole1 = KBox::pin_init(
 //!     small.alloc_blocks(
 //!         GpuBuddyAllocMode::Range(0..SZ_4M as u64),
 //!         SZ_4M as u64,
-//!         Alignment::new::<SZ_4M>(),
+//!         Alignment::SZ_4M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -195,7 +195,7 @@
 //!     small.alloc_blocks(
 //!         GpuBuddyAllocMode::Range(SZ_8M as u64..(SZ_8M + SZ_4M) as u64),
 //!         SZ_4M as u64,
-//!         Alignment::new::<SZ_4M>(),
+//!         Alignment::SZ_4M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -206,7 +206,7 @@
 //!     small.alloc_blocks(
 //!         GpuBuddyAllocMode::Simple,
 //!         SZ_8M as u64,
-//!         Alignment::new::<SZ_4M>(),
+//!         Alignment::SZ_4M,
 //!         GpuBuddyAllocFlag::Contiguous,
 //!     ),
 //!     GFP_KERNEL,
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index de8ef8e2aec4..5712478a5461 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -19,7 +19,8 @@
     ptr::{
         Alignment,
         KnownSize, //
-    }, //
+    },
+    sizes::SizeConstants, //
 };
 
 #[cfg(CONFIG_HAS_IOMEM)]
@@ -90,7 +91,7 @@ pub fn ptr_try_from_raw_parts_mut(base: *mut u8, size: usize) -> Result<*mut Sel
 impl<const SIZE: usize> KnownSize for Region<SIZE> {
     const MIN_SIZE: usize = SIZE;
     // Alignment of 4 is the most common; different base types can be added once required.
-    const MIN_ALIGN: Alignment = Alignment::new::<4>();
+    const MIN_ALIGN: Alignment = Alignment::SZ_4;
 
     #[inline(always)]
     fn size(p: *const Self) -> usize {

-- 
2.55.0

