Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3392DCD98DE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7189710E4A9;
	Mon, 15 Jun 2026 14:42:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="UXl59XOC";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC62410E4C0
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 14:42:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaSi2wnJ7kTaqkbWVNrFGtDTJ1FVNDxCTtUUPmX+YV/7VG+ouMWYBAXHq01UuKU9pkGr7CjNzMmYK+cKXXJoo85kBUYwWPD/vSMbJEFHvUHTSs93WHW3qQQ3piKbtuhRloNLs9OmaNIffwjlGsSOEEtciLU04I22jjOz0uQqRFvAaPe1ULJJcuHrr3iPlVoRHrmnZaLn7iS/IZP7oRxiFMg13EQ8PfwhL2PaTP7qDl1V0u5AQCd4TUhsVN+lnLQxUag3W9V6oLClwiIYcckANU2wcVnK6IPBIqG/o54W6eXqQB4Cv+jubJyL/w8rXzu+32WaJhQNocIB42cltDqpVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfZMpf7wKGYDz9HFap/PYSNDjkuQiw08uz/CLfDqVu4=;
 b=lxfZlmk2qmKhQl9GaZ15VFJ/wteinPklxNUxm+h6tkQbDybOjScjl2aoLjBXnGgXwSHPN3jCucBHl2hhDIxmKCIGllFT65fuhH7L09+1UKMw3l7DixorgEQmJMR8nPtMoJa7ib9pF/nPL6q9/6W8PDmanPEA3/Rr/PW6oWpW9SyJYa9HcrjJYy0EoeGKbKmPGAEgUzdvDYLMEMsuD4q/VFryCH7Ysr18OAguuIM5zAaau9THkz9xiEbXVdOxdrnQSTcWlGHoAnMjTT+72FbZYiegZwNMwENgjuqa2j8zZ/NDBjcAs8YBR1ZX4zykDgwviVefyg3OTzfcowKulgGCHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfZMpf7wKGYDz9HFap/PYSNDjkuQiw08uz/CLfDqVu4=;
 b=UXl59XOC8+j2worWd6C9LbnSOXolhK6Ci+trKxa7uMEXMaE0vLEne92rqigEcWIbrTPwlctlrG/4LniT4vaw5HXGJMrpysfi+D6TdRcgkE3l+yNa/HTQbjnEawrAZuy7JHHMekmeJLDn+5aOfTJMJOnvf/Ew5DlBgJUMHacdHr8sUzHpH4hHyaCT8illMta2WYRfwhkMR0/hLN/q8M/mNtqUi3WiWHJwXfhaHRaH/68fb97kqI3WEXuqadCXA6U9PKbwPj+2Af3/nXKXcnTCruovvMqqDxAO3qBjeWWYd7VRfqkTRyVF1R8dgSn2ipTiHzajyyv04IVHws6Kel6BJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Mon, 15 Jun
 2026 14:42:09 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:42:09 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 15 Jun 2026 23:40:49 +0900
Subject: [PATCH 09/13] gpu: nova-core: wait for FSP boot earlier
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-blackwell-fixes-v1-9-f2853e49ff7d@nvidia.com>
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
In-Reply-To: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0037.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b268263-ae85-4c26-9cf8-08decaec4744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|23010399003|366016|1800799024|11063799006|3023799007|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ROq6n0aCPigvZZlMlrhvFZ0Sn7qj/vXvAhTLo2Kb7g06p9UqejVHiCxQoOoOLYv/iuERa5kLwbhSyx8nLCD7Y7o8cPR5UYzI1khBYP23mymVIVG1XoGPnfFEPrR0eUosV/bc9p00krHeUjEebAfik3nS7eUH5xVtkFyaYpP8wH8hx3Xx+LCG3qzvtGvQdArsV9fDNqfHJgNNKofPahwaEViRRNmp7+Y4LbB7q8lEGVHjvJQxyVLTgY3E+J+ViCr9FtlkwK2O2Gy0c07CJUjYReaA37fcJ4mpLWKnnt1+lr8RqbJ048gRhPg59yiDM7id0elukbfbosDwXiPoqIdJY87dhAOoDd9Yj1aAStyS7S8jjnScTk49DpUjwJDOuNjqJuI6cZLRHXId6Tj3G5K22pwVr3pSgSLJSm3AJ7Mj4Vlxah0ajd7jTVqft8LawZcEQ6Emk/ewBQZboshRi4MFG5peAFR9Bp4mLumnjOc0kUUguM+GhylDzc6NmqML+0tAG+KRlkett8Mlnbx+n4Fs9BkyW+9L/e+3Zkti0hSbA6qC3i5EAQaK1VHHycqu8wgK7ANRQ2CWe9J9xxdno/u0wOlqY2hJraxk6pQ0Wgzfj2p362YrX3xKgXl2vsIuxS+CM+LE8biWfWaj+sf2UYxG9z+50pML2U/7lgw7CcVcnkIWryH/v1JcoEoYcPT/R3x5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(366016)(1800799024)(11063799006)(3023799007)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUNuVlRJRSs3dXBmTGRWM3M4bTVPUmczNFVEWWFDUjlkUGlUeU5XNS9odnJx?=
 =?utf-8?B?NHdUY21PdkQ3M0duKy8wM3NoeUQ0ZS84S2k1Y2Z6RTNiRnF1cUxmSnBldndB?=
 =?utf-8?B?cTMrbUNtQXAreXlQbWxORlQzOTMwYjQyNVkxWXdsUGRRUHM4bWxpNnBrWjh1?=
 =?utf-8?B?dTUzM2Q0VUxBT2t0NjdCMVcxUWs3V2pTVXdBYW5GVWgyZExkb3VZTUhsZ0ND?=
 =?utf-8?B?SlVycUcrT0huanM2b01vV3kwUEFYNzliK1FBT0llNmVDUWZTcUoxYkJveTR3?=
 =?utf-8?B?R29jYmlPZUVEWW82OWQ3RlFSZlNSd0lveHh0OStybFRSR1NwTk5WeTFJMlU2?=
 =?utf-8?B?dmZ0KzU5Rmt0VUJ6Qkd6QmhKZmtDbkhnaTNsMko4SDQxVksyVkx6cHJSUThk?=
 =?utf-8?B?UG1GQVJuNVdRazE3RnN4c2xMUjZ0ZDE3K3dBdjdQUThMM1A2VlZ2QjUwY2Vv?=
 =?utf-8?B?YXNJbjg3MkNCMkhMUm4xRG1CdlBMdjBHOXV0MDNZcmVaa3JLdWdRYlVOL0lL?=
 =?utf-8?B?YnkyZlBwanM0b1NhSjNuZGlCR2RuTmVrV0NVbWF2clcvOGxOSUtmV2Y2S0NK?=
 =?utf-8?B?QlcxKzFYYXNib3lUR2FWY2QwNTRPbFhGeGhRTlJ0VWJRTTFJeExoQWhKb3dY?=
 =?utf-8?B?clRxamFhMUtuRS9WWEVFZHk2cXRFd01hUGw5Qk1jRzY5SERhVFlkeS9jdWNE?=
 =?utf-8?B?WnZxOHZVaCtGbnFOVXBUTVNZb3ZMUDYvZk83WmJhWG12VWd0eDlsMmZIWVBO?=
 =?utf-8?B?c1FGcGpud2l3WFZ5Vm5aZkR2NnZUS2JwREQ5b2NVc0pSSnlPeVVlTEZZVDVq?=
 =?utf-8?B?UnlCNXU2ZXFQdGdXd2VGZ2xQbGhiU0xjZURybEtJM1RTdmgrUXYvd0h2ckxw?=
 =?utf-8?B?N3BXZTU0Zkpzcm9PVzgrcEgzRVBzaWZ6bnpBMDJRdXQzaTloZDM3MklQWDdE?=
 =?utf-8?B?MVhpaThoUWhYR1lVZVFrazFTZ3V1YmFsREJIelVqS1pnSnN6Y3hPMEI5akE4?=
 =?utf-8?B?SVJoSHpkNWdpMUlGS0J1TFJKNUhXemdaNE1qUHlHNjZKRnFkV041UHVXM2or?=
 =?utf-8?B?RlNmMXQvNzJ3QkluaDFGdW9WNzI3cm5nNmZCT0JaOE5OUmtVWkF0UjNiTzlC?=
 =?utf-8?B?YU9TaWwrakRmN284K0RtTnpPbitRc0VnZUo4ZmxNSlhBeDVuaHBaK3I1azJZ?=
 =?utf-8?B?VGxjZXhjS2kwMHF4OXhGQXc2cWJtOTY5ZmZIVndISEMyaWt4QkpHUDBNK3pu?=
 =?utf-8?B?YW1mR0tnMGtGcUFxN2JnQTVENHRSMHJoMkVoc2JNaWVKNitlbnI1dEx5Z3Vq?=
 =?utf-8?B?VHpTMjh6VzFxblJQQzZPS05jdWhhelRzV3hWRDhIRzZOY0djZFJFT3RLM1dD?=
 =?utf-8?B?Rkt0dUhJS1phY3lEbWMwRzRVTGZyTlpGVXcvaTVmTlAzUmJLQlV6YmZiWnhC?=
 =?utf-8?B?Njd3cytHZU9iZnExdU5nemNjS2JCbU9wZ0ErZTBCeGtjTWZGS2R1QjhySFdj?=
 =?utf-8?B?YmQ1SnptcUwvZ1VGWHcxZi95TVJYT2lrVjZYUFkvUmw3bFlWODg3UE9iQWZG?=
 =?utf-8?B?RlpMTDVtenpYSjh1WWxnRlZ3aDdNRmdsSTVmMUpCR0RCR3hVMStycWQyM3BX?=
 =?utf-8?B?TWFvakUwR1Q0dWNyaHloUDI3NmhjU0cyNjVhN0tDeHI5RkhFQVNtb2RsYkhX?=
 =?utf-8?B?NEkzU0xXMmsraHYrcVRQeVRsUVZVbFBiTlFFK3JXb2RxK2NnVmNjdkR3Mk1D?=
 =?utf-8?B?bWxhNTh5d2xGT3BVNW44UFJVcWlaSHNlWHpYV0pveWhWQmQ0QmlvUTlST3ZI?=
 =?utf-8?B?UWszcEdqTVM2ZmpTYWZJaVhWRzBta0prQW50MnRhN0t5eXVkZmNoaXQxcE5x?=
 =?utf-8?B?MXg4eG1TTi91dHorK3Ezd0tKOExSOGZuT2FwMTlaR1kxSFhZWlpuRFVzOFNZ?=
 =?utf-8?B?SkhmdG1Ib051T1I3R3hYdjc2a0VjL0g3aWRjZCs1NUV5M216SUlGZEtlUFdN?=
 =?utf-8?B?bDNUSG5OS05ZenVrL2x5d0QyMCtqYWliRWZEcXFCV1BpZVo2MnBqSnFpRnJt?=
 =?utf-8?B?OC9DRmx6VTR2a0pkTzUyVmZqZy8veExXUkprT0lTTGNzNC9XcEV3NVAvQzNI?=
 =?utf-8?B?cnd1ZmdZRERDVUt0Q3lEVkp6UEdTcFpHb3FXa1gyUERBYWZ5WlAyNVpHeTYw?=
 =?utf-8?B?Q0VNZVFNM1greGJobEZNclY4bkkvRWlTU2lNVmdpRW9vRDJ3UnlucEJPZlBF?=
 =?utf-8?B?U2hReFcrSXVPcS81QStTK3h5Y0JGYy9rTzh2M2dVWm1zTDJSRjdmUjloSE42?=
 =?utf-8?B?MkZNdkFQalB1ZDE4c2I2SytqcTBGU00vZmpSNXhFZS80TFVVSkRFZzlYaWJa?=
 =?utf-8?Q?prNo42W1raLNs+q4x+QwetYFvr2wtiiwLWxQsdW9oj9OI?=
X-MS-Exchange-AntiSpam-MessageData-1: hGh4tlEE/XtXwg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b268263-ae85-4c26-9cf8-08decaec4744
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:42:09.3072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oz/CW8Jfjb+oczOaGzxOCoOeMcw/XtdFozfBX9tFwdNelKgUoVClX6jbtL8Nc8VXEu3FRHuR7AvrfGcnFne5eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9668
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

For GPU architectures that use FSP CoT boot, ensure that FSP itself is
booted before trying to use it. In particular, accessing registers like
`NV_USABLE_FB_SIZE_IN_MB` for `FbHal::vidmem_size` should happen after
FSP is booted. Currently, we wait for FSP boot too late. So, move this
wait to a new preboot phase.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/fsp.rs           | 40 +++++++++++++++-------------------
 drivers/gpu/nova-core/fsp/hal.rs       |  4 ++--
 drivers/gpu/nova-core/fsp/hal/gb100.rs |  4 ++--
 drivers/gpu/nova-core/fsp/hal/gb202.rs |  4 ++--
 drivers/gpu/nova-core/fsp/hal/gh100.rs | 10 ++++-----
 drivers/gpu/nova-core/gpu.rs           |  7 +++---
 drivers/gpu/nova-core/gpu/hal.rs       |  6 +++--
 drivers/gpu/nova-core/gpu/hal/gh100.rs | 10 ++++++---
 drivers/gpu/nova-core/gpu/hal/tu102.rs |  3 ++-
 drivers/gpu/nova-core/gsp/hal/gh100.rs |  2 +-
 10 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index 3f3211eae4d0..bf0baa5ac4ae 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -49,8 +49,7 @@
         NvdmHeader,
         NvdmType, //
     },
-    num,
-    regs, //
+    num, //
 };
 
 mod hal;
@@ -229,41 +228,36 @@ pub(crate) fn boot_params(&self) -> &Coherent<GspFmcBootParams> {
 
 /// FSP interface for Hopper/Blackwell GPUs.
 ///
-/// An `Fsp` is produced by [`Fsp::wait_secure_boot`], which only returns once FSP secure boot
-/// has completed. It owns the FSP falcon and the FMC firmware, which are used for the subsequent
-/// Chain of Trust boot.
+/// It owns the FSP falcon and the FMC firmware, which are used for the subsequent Chain of Trust
+/// boot.
 pub(crate) struct Fsp {
     falcon: Falcon<FspEngine>,
     fsp_fw: FspFirmware,
 }
 
 impl Fsp {
-    /// Waits for FSP secure boot completion, then returns the [`Fsp`] interface.
-    ///
-    /// Polls the thermal scratch register until FSP signals boot completion or the timeout
-    /// elapses. Returning an [`Fsp`] only on success guarantees, at the API level, that the
-    /// interface is not used before secure boot has completed.
-    pub(crate) fn wait_secure_boot(
-        dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
-        chipset: Chipset,
-    ) -> Result<Fsp> {
+    /// Waits for FSP secure boot completion. This must be called before trying to create the `Fsp`
+    /// interface or read any registers dependent on FSP boot completion.
+    pub(crate) fn wait_for_secure_boot(bar: Bar0<'_>, chipset: Chipset) -> Result {
         /// FSP secure boot completion timeout in milliseconds.
         const FSP_SECURE_BOOT_TIMEOUT_MS: i64 = 5000;
 
         let hal = hal::fsp_hal(chipset).ok_or(ENOTSUPP)?;
-        let falcon = Falcon::<FspEngine>::new(dev, chipset)?;
-        let fsp_fw = FspFirmware::new(dev, chipset, FIRMWARE_VERSION)?;
 
         read_poll_timeout(
-            || Ok(hal.fsp_boot_status(bar)),
-            |&status| status == regs::NV_THERM_I2CS_SCRATCH_FSP_BOOT_COMPLETE_STATUS_SUCCESS,
+            || Ok(hal.fsp_boot_done(bar)),
+            |&done| done,
             Delta::from_millis(10),
             Delta::from_millis(FSP_SECURE_BOOT_TIMEOUT_MS),
-        )
-        .inspect_err(|e| {
-            dev_err!(dev, "FSP secure boot completion error: {:?}\n", e);
-        })?;
+        )?;
+
+        Ok(())
+    }
+
+    /// Creates an FSP interface.
+    pub(crate) fn new(dev: &device::Device<device::Bound>, chipset: Chipset) -> Result<Self> {
+        let falcon = Falcon::<FspEngine>::new(dev, chipset)?;
+        let fsp_fw = FspFirmware::new(dev, chipset, FIRMWARE_VERSION)?;
 
         Ok(Fsp { falcon, fsp_fw })
     }
diff --git a/drivers/gpu/nova-core/fsp/hal.rs b/drivers/gpu/nova-core/fsp/hal.rs
index b6f2624bb13d..7c5a7e61835c 100644
--- a/drivers/gpu/nova-core/fsp/hal.rs
+++ b/drivers/gpu/nova-core/fsp/hal.rs
@@ -14,8 +14,8 @@
 mod gh100;
 
 pub(super) trait FspHal {
-    /// Returns the secure boot status from the architecture-specific `NV_THERM_I2CS_SCRATCH` register.
-    fn fsp_boot_status(&self, bar: Bar0<'_>) -> u32;
+    /// Returns whether FSP secure boot is done.
+    fn fsp_boot_done(&self, bar: Bar0<'_>) -> bool;
 
     /// Returns the FSP Chain of Trust protocol version this chipset advertises.
     fn cot_version(&self) -> u16;
diff --git a/drivers/gpu/nova-core/fsp/hal/gb100.rs b/drivers/gpu/nova-core/fsp/hal/gb100.rs
index 42f5ecfc6400..a95b2dde2a04 100644
--- a/drivers/gpu/nova-core/fsp/hal/gb100.rs
+++ b/drivers/gpu/nova-core/fsp/hal/gb100.rs
@@ -9,9 +9,9 @@
 struct Gb100;
 
 impl FspHal for Gb100 {
-    fn fsp_boot_status(&self, bar: Bar0<'_>) -> u32 {
+    fn fsp_boot_done(&self, bar: Bar0<'_>) -> bool {
         // GB10x shares Hopper's FSP secure boot status register.
-        super::gh100::fsp_boot_status_gh100(bar)
+        super::gh100::fsp_boot_done_gh100(bar)
     }
 
     fn cot_version(&self) -> u16 {
diff --git a/drivers/gpu/nova-core/fsp/hal/gb202.rs b/drivers/gpu/nova-core/fsp/hal/gb202.rs
index 1091b169a645..a3010717c57d 100644
--- a/drivers/gpu/nova-core/fsp/hal/gb202.rs
+++ b/drivers/gpu/nova-core/fsp/hal/gb202.rs
@@ -12,10 +12,10 @@
 struct Gb202;
 
 impl FspHal for Gb202 {
-    fn fsp_boot_status(&self, bar: Bar0<'_>) -> u32 {
+    fn fsp_boot_done(&self, bar: Bar0<'_>) -> bool {
         bar.read(regs::gb202::NV_THERM_I2CS_SCRATCH_FSP_BOOT_COMPLETE)
             .fsp_boot_complete()
-            .into()
+            == regs::NV_THERM_I2CS_SCRATCH_FSP_BOOT_COMPLETE_STATUS_SUCCESS
     }
 
     fn cot_version(&self) -> u16 {
diff --git a/drivers/gpu/nova-core/fsp/hal/gh100.rs b/drivers/gpu/nova-core/fsp/hal/gh100.rs
index 291acaf2845a..a440b68205e2 100644
--- a/drivers/gpu/nova-core/fsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/fsp/hal/gh100.rs
@@ -11,16 +11,16 @@
 
 struct Gh100;
 
-/// Reads the FSP secure boot status from the Hopper/GB10x thermal scratch register.
-pub(super) fn fsp_boot_status_gh100(bar: Bar0<'_>) -> u32 {
+/// Returns whether FSP secure boot is done on Hopper/GB10x.
+pub(super) fn fsp_boot_done_gh100(bar: Bar0<'_>) -> bool {
     bar.read(regs::gh100::NV_THERM_I2CS_SCRATCH_FSP_BOOT_COMPLETE)
         .fsp_boot_complete()
-        .into()
+        == regs::NV_THERM_I2CS_SCRATCH_FSP_BOOT_COMPLETE_STATUS_SUCCESS
 }
 
 impl FspHal for Gh100 {
-    fn fsp_boot_status(&self, bar: Bar0<'_>) -> u32 {
-        fsp_boot_status_gh100(bar)
+    fn fsp_boot_done(&self, bar: Bar0<'_>) -> bool {
+        fsp_boot_done_gh100(bar)
     }
 
     fn cot_version(&self) -> u16 {
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index b3c91731db45..ca37892c3b38 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -295,7 +295,8 @@ pub(crate) fn new(
                 dev_info!(pdev,"NVIDIA ({})\n", spec);
             })?,
 
-            // We must wait for GFW_BOOT completion before doing any significant setup on the GPU.
+            // We must wait for some architecture specific setup to complete before doing any
+            // significant setup on the GPU.
             _: {
                 let hal = hal::gpu_hal(spec.chipset);
                 let dma_mask = hal.dma_mask();
@@ -304,8 +305,8 @@ pub(crate) fn new(
                 // still constructing it, so no concurrent DMA allocations can exist.
                 unsafe { pdev.dma_set_mask_and_coherent(dma_mask)? };
 
-                hal.wait_gfw_boot_completion(bar)
-                    .inspect_err(|_| dev_err!(pdev, "GFW boot did not complete\n"))?;
+                hal.wait_preboot_completion(bar, spec.chipset)
+                    .inspect_err(|_| dev_err!(pdev, "preboot firmware did not complete\n"))?;
             },
 
             sysmem_flush: SysmemFlush::register(pdev.as_ref(), bar, spec.chipset)?,
diff --git a/drivers/gpu/nova-core/gpu/hal.rs b/drivers/gpu/nova-core/gpu/hal.rs
index 3f25882d0e56..232f073ccc06 100644
--- a/drivers/gpu/nova-core/gpu/hal.rs
+++ b/drivers/gpu/nova-core/gpu/hal.rs
@@ -19,8 +19,10 @@
 mod tu102;
 
 pub(crate) trait GpuHal {
-    /// Waits for GFW_BOOT completion if required by this hardware family.
-    fn wait_gfw_boot_completion(&self, bar: Bar0<'_>) -> Result;
+    /// Waits for architecture specific operations to complete before we can try to boot the GSP.
+    /// For example, may wait on GFW_BOOT completion or FSP secure boot completion, depending on the
+    /// architecture.
+    fn wait_preboot_completion(&self, bar: Bar0<'_>, chipset: Chipset) -> Result;
 
     /// Returns the DMA mask for the current architecture.
     fn dma_mask(&self) -> DmaMask;
diff --git a/drivers/gpu/nova-core/gpu/hal/gh100.rs b/drivers/gpu/nova-core/gpu/hal/gh100.rs
index e3f8ba0fab33..3aa18feec1f7 100644
--- a/drivers/gpu/nova-core/gpu/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gpu/hal/gh100.rs
@@ -7,15 +7,19 @@
     prelude::*, //
 };
 
-use crate::driver::Bar0;
+use crate::{
+    driver::Bar0,
+    fsp::Fsp,
+    gpu::Chipset, //
+};
 
 use super::GpuHal;
 
 struct Gh100;
 
 impl GpuHal for Gh100 {
-    fn wait_gfw_boot_completion(&self, _bar: Bar0<'_>) -> Result {
-        Ok(())
+    fn wait_preboot_completion(&self, bar: Bar0<'_>, chipset: Chipset) -> Result {
+        Fsp::wait_for_secure_boot(bar, chipset)
     }
 
     fn dma_mask(&self) -> DmaMask {
diff --git a/drivers/gpu/nova-core/gpu/hal/tu102.rs b/drivers/gpu/nova-core/gpu/hal/tu102.rs
index b0732e53edea..34b63a7c0ada 100644
--- a/drivers/gpu/nova-core/gpu/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gpu/hal/tu102.rs
@@ -32,6 +32,7 @@
 
 use crate::{
     driver::Bar0,
+    gpu::Chipset,
     regs, //
 };
 
@@ -55,7 +56,7 @@ impl GpuHal for Tu102 {
     /// This function waits for a signal indicating that core initialization is complete. Before
     /// this signal is received, little can be done with the GPU. This signal is set by the FWSEC
     /// running on the GSP in Heavy-secured mode.
-    fn wait_gfw_boot_completion(&self, bar: Bar0<'_>) -> Result {
+    fn wait_preboot_completion(&self, bar: Bar0<'_>, _chipset: Chipset) -> Result {
         // Before accessing the completion status in `NV_PGC6_AON_SECURE_SCRATCH_GROUP_05`, we must
         // first check `NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_PRIV_LEVEL_MASK`. This is because
         // `NV_PGC6_AON_SECURE_SCRATCH_GROUP_05` becomes accessible only after the secure firmware
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 31498ae7abd2..35554d92fda9 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -159,7 +159,7 @@ fn boot<'a>(
     ) -> Result<BootUnloadGuard<'a>> {
         let args = FmcBootArgs::new(dev, chipset, wpr_meta, &gsp.libos, false)?;
 
-        let mut fsp = Fsp::wait_secure_boot(dev, bar, chipset)?;
+        let mut fsp = Fsp::new(dev, chipset)?;
 
         let unload_bundle = crate::gsp::UnloadBundle(
             KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>

-- 
2.54.0

