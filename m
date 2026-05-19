Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30144CD343F
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 02:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C1F510E363;
	Tue, 19 May 2026 02:55:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="sM/CG61X";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012031.outbound.protection.outlook.com
 [40.107.200.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C81F210E363
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 02:55:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3n0R92GZxr2lulV9U8S8WE7vL30wq9/oPdwlopaoaZ1FdlCc5MfIuSmLJA0RSheZ6NLZxeOzXilQQd4PB+H7xjeCHVwtmgGLM8A8dhkZ9J86qne1yQoV+4VCUlTS63cotcqgnlFjRLfRm5fCFZDbdkV4E661sftsC/h66BM9wFkp/9nko2CNbq4F4nX5/VqSrsnUStlkEQX/+veBQXBmdVWzIykAikIyjSU4tYO8eavh/5X/Q6jeMaJ0mySoJTjzDYHabEg1f75klzsZibJdAlrVwjdpzkXWtOB2XVXXsGqdDfSZDjDGStZ3pKyykKzRyltj6Y9r76vNabFxwSmdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5Z/XJm+h+eieQ3lufcEIIJmclC5ZXcAUQhGO62FVv4=;
 b=PAiCg/VPcQoDxRF7aTPS66BayXluwxgvlBtjtugF3pUUhm4WJX+/V9gKgKTxsOUNKMB/69kwjB3AVEHhFN94CeUpxVJKIHBqn3JzoAEDXaY0/0tqPG7JIZfCRrwqTyqfGsDY0hJuVv4888m6vOXMC73YVQZv46+t5IJh0MKlCDUVmjEHT0r2SsSgO7gYu4KtC/DMk5zfOycYUXHCRpjOF0UZIAK29E8mGp/ymNiYbGMTQhIbjs7jJLN4xB3KfXXKY2kAsg1PS2u3IuROECQrEavFL/p0wBYRG4r9qe/b5mvqn6S0HkiL09+QbUnOc5da7VnEm9+OLGfpv35nqAnd+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5Z/XJm+h+eieQ3lufcEIIJmclC5ZXcAUQhGO62FVv4=;
 b=sM/CG61XMc+/HGFi0+7ZRSW7h5kpT3OmR7N3KW+JWigrRbwvnza38e5sKkmrZA51y8M6Q7lVYuIbyh6X31d8AWt86cN3gHeg3wSnWQYQ7q7KqvTZneg9vg3fwBJLy1r0vpH+WCl8rlL58nMXZRNMB4HF4l1tpsXvO+uHae/v1S1P7PMUQ8UL6uHTb1afenLIYhO5goQrKjZKlw0sva2QvEeVzEWL3c7e3sfSj3N6hKotWaIKtO1skT3xTS8PHmwyERoysqhbF94oKo4AO+xnK4n+/bA8iodax59ay8YEyD2P22mmiWLcqckLZAKhwoi0/KXGITHhx0+8srFdPfBCTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 02:55:45 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 02:55:45 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v4 00/20] gpu: nova-core: vbios: harden various array
 accesses and refactor
Date: Tue, 19 May 2026 11:54:54 +0900
Message-Id: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNyw6CMBBFf4V0bU1flOLK/zAu+kLGRGooNhrCv
 1vQRY3LmznnzIyiH8FHdKhmNPoEEcKQh9hVyPZ6uHgMLm/ECJNEkBZ38MTJQIjYSal8axl1jKP
 M30efj1vrdP7s+DBXb6c1sBI9xCmMr+1Zoiv37VJSdBPFBBsru4Y6WnMnj0MCB3pvww2t4cRKV
 ZQqy2pDaseJo9IY/afyQmW0VHlWVSeF0r5rtKp/1GVZ3nwjlY8rAQAA
X-Change-ID: 20260409-fix-vbios-d668e9c21d23
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM6PR12MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: ade99bda-f5d1-41e1-1c10-08deb5521f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: 2P1Zsuf9SKutuzMJTz5rYjIKKxKWzmh8P26cUNBLlWyIHLKSL4FcpT3FtXUNNrc5Hb91ySDZ2ynilmgCJiFV1yjAL8kgduWhql9d23qiW9+Z4xDPjOZ6QDv4cTKBkOwCfDvgdGUSd0CxBSmMRPa3ODBMKgROLprDQJhQa0ryOESMLPbv7F0EHeM7myu7nwmMWF8cKTUTSR4A6ek3W6ningmah8Aj4B5lyMKG5TP+joLiP7/AxIZHbKWrJfgA73elvgynk9e81xNmoEl1DiLkVAMGzj7LOiLI+wDaNSNV1XKrGLou8s7a0y1j2giLszyJXyvvx49FKcU0d7737iqYj0mucQP1X1h0xQk+4kyYMYRNWtRK6fmnnTyV8cBBKs4Yq1y3BaPfVBAKD/cDRrFL4OlT/NflxYWkB7uiGWIAlp2ROYyPKYzXI+9O0zZcU+P7J1tpUDR1P0Ped+XYyY2vOwZI7kUdk45yr+738arztUcq20nrUJyPF2cA8KDzNhU+Lksl2sg2GouQZbpJozCseeGOl65R+BahMkSOYyK6bdvXP/Z+17CZUyaxXmD/l12ZdWNznqSHV5CSRTPVa4VxxZ308Zx3JWGehMO2uCkUTlP71jgHiS6nVe1JhOZx/nylS/1V5JqQSzLfd+Dv7nfzReoEPJiAAMl0dYJ+T61VoW0RqHjYc/5Ji98RzudUTTyB33DLC11WpSh2Cc8/O4DNow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(56012099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUd2M0M2NzBJRW5tZSsvZERndXBGeDZLVG0rRHowdFJvV2k5eTFxc29rNmpG?=
 =?utf-8?B?SGVvZlg4YVFKK2NRaityM1VvTnFlQi81eGxJNWNvM09WYVlmTy9XbVhxazhE?=
 =?utf-8?B?bW5ZU0d2OEREYndMNlI4UE8zeU14Ykk4Y0U4cGVqby8rVlJlQzR0MXJ4S0lT?=
 =?utf-8?B?UVhYYit0dDFwejR2enBENkt5NDkzWENsQVVob29zYS82dlpDd21PNExnaHVW?=
 =?utf-8?B?cDVNdWNzdDlRRUZaM2ZoZnBtbVNNbW1ob2FVRmhqWmNYSWZoOHEvSW5TaW5I?=
 =?utf-8?B?UlJIbnpSZVZDeE03NXRrOWc4WkpKSldXUklZZU94a2Vhd2Y4KzFRQU04TmdJ?=
 =?utf-8?B?TUU2UndZNnlqVGpRL0JMeUhNdlNQTlNHTnBQOFN6TzBKUEVuaFRHaGNqQ29O?=
 =?utf-8?B?ZUJoMmY4d25ENWFSU2tkMHRKcEQ2bE5zZlVzdDRiR1N2a2pvZlNrc01oNVJU?=
 =?utf-8?B?bG52TmNGaWxlRDBFUVUreHBNak45VGN6VnN3RENTYk8rVy9hUkh2OHowOGtB?=
 =?utf-8?B?N0xESE15a2J2S0wwR3FnTHNyMFNReW9kR0I3aW1uUlJmVkI3VEFDZWRsRkRE?=
 =?utf-8?B?ZVpXOG80cHVQK3YxNy8wQkVDMjNCVlcyak4yZERKbHBId2hRck5IZWpGWTlU?=
 =?utf-8?B?bGM3VU5pWi80a3daRmJBVU9OZWVka1E3bEpXUHhqcEp4SWh0UWp1Vkkyd3ZD?=
 =?utf-8?B?c0JqeHhxU1lEazhldnlDcUFZZDV2SE5md3BuK05pTkZVRnF2TENPcHJDREQx?=
 =?utf-8?B?VkdYQTFGL25Wcjc0eXZiV09Va2F2aTlYYWJXd1YxR2FVYklyRzBtcktlQXlX?=
 =?utf-8?B?bDJnaEd5aWpDMTVMSGYvanpvZU1JOVZUVnlDdXAwS0xDYVJyL2JGbFNGRm1o?=
 =?utf-8?B?YmxhMnlGYjQvLzBEMFRXSVJLeld3UEVzSXJmK0xnbE0zbVlUc2tOVmp0SjFI?=
 =?utf-8?B?UWRkNHJvTUxGbkNHcE1VME9aM3Q3OXZiSHM1UGJGVFUxeXhiYU5STXM3M0FW?=
 =?utf-8?B?RTFtbDVkWUFqclZjQjIySGxINXNsdjQ2V2lRREpCWEMwOUo2aXpBMGkwbWl5?=
 =?utf-8?B?Y2l5YmI5YkM1QTc4ejNXOStQQUI1dkZxcVN2cUdKNnlPREZtQmVIdjFxU25K?=
 =?utf-8?B?SWVoUFd5SzlKZTZ0TzQyTzhZczhtN0tiNTBjejFyU204UVRUYWhLWFVqUCtI?=
 =?utf-8?B?bno3QjlJM2NwdGt1YUx2QmFQMTlHZjVHTlh1Y1paRTZiWEU3R3YyY2trVFlS?=
 =?utf-8?B?NCtwUk0welR3K1NDV3h3TXlXZWY0ejdlbm0ra0N6cmYzbGZyeUNNZkpiaGhi?=
 =?utf-8?B?a3JxRjE4VVdXT3hXWkVnWlNwTktQK2RmYUZQV1RHNE9GY1RjKzNzalh5Z2tz?=
 =?utf-8?B?QUh1ZVN4QllwL3RRRzVUNWdtcHRiWkNXVlZ0emdlaW5uUWovVXRFRFdaek0w?=
 =?utf-8?B?RG9tVzd3MkFlUytjMnJKb1JDTzhtek5sYy9iOVNpVk9kZ01TRWd4NjcwcStY?=
 =?utf-8?B?cFBSeFlsUDk0b1V6MDR4Z0MzZmtiRVFxQVZaOWRZbDdJT2JUYTc2dGYya05M?=
 =?utf-8?B?UjVSdjBLS0E1a1AzRW82UE9BK2lMNE1PRTNLNWJwRUJEY3QwVzhYNXdMZ3V0?=
 =?utf-8?B?N2JuL2Zicit3Wm5sRThicU1HRUR6U0xINitlaW5vbEVrVm8vUE5CVVk1QUJy?=
 =?utf-8?B?QWViV210MWFTZnhkQnJrbzh2MnNYOWMzN3lHRUFPT2RkN2piRmpDV1gvdVIr?=
 =?utf-8?B?bUp1MlA4YVFrdFUvS0p4NFZTcTdaZXNsWG1ITGdudzNkQzN1bWZhcnZtTUNo?=
 =?utf-8?B?QytzdHdneDVlb1JpTGhrWU9ORU5YNWtFTjQ4b0V6YUJWbUljQU5VVC9yVHlo?=
 =?utf-8?B?NWVWLzIrU0dveXNYK1RiTzhZQnZPakw5TnZWK1RHNnpwY1B3L1RYdEhGSW9O?=
 =?utf-8?B?Uk5mWnl2Zk9lOU80K1ZSUFVieHhMYmtRS1J1d00vWHUrRm4vMmxVaktaWWhO?=
 =?utf-8?B?MWd4SnVIVmhIaGJ1TWhKOCt0STJkZlM1V3BpU2RUWHVzSmJxNkFaNUJiU1Yw?=
 =?utf-8?B?U09jTU5uRUtFVmNYYi9abFVDODhQTGpFZjVtaEtmUWMvdlVFZmZoWmxOZ3Ar?=
 =?utf-8?B?ajNFNm11MWgvSnlsbE14YjlPbG9oMkxSS2oxMmNwNy9ZKythdnMxaHFsZlF1?=
 =?utf-8?B?c0h5b01NUUJIRWtYdWRyekFUd3NsZHVXdjJiTUt2REczQnRxdU50VVMxQmNa?=
 =?utf-8?B?QmptSTM4YTMzYVJCWTNITFcvbW1lekJDMHhkSGVmKzUyL2UwNnhGemllWkRH?=
 =?utf-8?B?Ly9Mdmt2TVBzVm9EY0kwVU1QSXB0dlo1ZE5MVXJ5WmpCSURacitXWkJlRk5Y?=
 =?utf-8?Q?01niaFg0Z8j6yjOZbBDcWFIfn6bA5PBJ2rofPGkM6c/pU?=
X-MS-Exchange-AntiSpam-MessageData-1: 97y3Zq7WmZayZw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade99bda-f5d1-41e1-1c10-08deb5521f26
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 02:55:45.0185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4H+WyJV0foYCfkB/YDAoCl7vUystIIfkVhd3dn7LihYqlncL7unbYbtNdOFbXAbJ7Dwxhe3UFaHSR+9LcktjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251
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

We have some code that accesses arrays based on values from firmware.
This patch series makes a bunch of those accesses more robust. This
series only touches accesses that are not guaranteed to be safe by local
invariants - some accesses are safe due to earlier checks and I haven't
modified those.

This series also refactors and removes some code that can be simplified.
In particular, it removes `FwSecBiosBuilder`, removes unused fields,
and moves type and constant definitions closer to their usages.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Changes in v4:
- Split BIOS_MAX_SCAN_LEN patch into multiple per review comments
- Consolidate bios max scan length checking
- Convert more structs to use FromBytes since we assume little endian
- Remove unused PciRomHeader fields
- Drop unused types / imports
- Move constants+helpers closer to usage locations
- Link to v3: https://patch.msgid.link/20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com

Changes in v3:
- Use first PCI-AT and FWSEC images instead of erroring.
- Expand commit messages.
- Add Joel's Reviewed-by's (thanks!)
- Link to v2: https://patch.msgid.link/20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com

Changes in v2:
- Add Joel's reviewed-by tags.
- Remove unnecessary code like `falcon_data_offset` from
  `FwSecBiosBuilder`
- Push offset handling into `falcon_data_ptr` (renamed)
- Simplify `setup_falcon_data`
- Add checking for spurious PCI-AT and FWSEC images.
- Remove `FwSecBiosBuilder`
- Link to v1: https://patch.msgid.link/20260410-fix-vbios-v1-0-bc6f71d153d6@nvidia.com

---
Eliot Courtney (20):
      gpu: nova-core: vbios: stop scanning at BIOS_MAX_SCAN_LEN
      gpu: nova-core: vbios: use checked arithmetic for bios image range end
      gpu: nova-core: vbios: avoid reading too far in read_more_at_offset
      gpu: nova-core: vbios: read BitToken using FromBytes
      gpu: nova-core: vbios: use checked ops and accesses in `FwSecBiosImage::ucode`
      gpu: nova-core: vbios: use checked access in `FwSecBiosImage::header`
      gpu: nova-core: vbios: use checked accesses in `setup_falcon_data`
      gpu: nova-core: vbios: drop unused falcon_data_offset from FwSecBiosBuilder
      gpu: nova-core: vbios: keep PmuLookupTable local in setup_falcon_data
      gpu: nova-core: vbios: compute FWSEC-relative Falcon data offset
      gpu: nova-core: vbios: simplify setup_falcon_data
      gpu: nova-core: vbios: read PMU lookup entries using FromBytes
      gpu: nova-core: vbios: store PMU lookup entries in a KVVec
      gpu: nova-core: vbios: construct `FwSecBiosImage` directly from BIOS images
      gpu: nova-core: vbios: use the first PCI-AT and FWSEC images
      gpu: nova-core: vbios: use let-else in Vbios::new
      gpu: nova-core: vbios: remove unnecessary fields in PciRomHeader
      gpu: nova-core: vbios: drop unused image wrappers
      gpu: nova-core: vbios: drop redundant TryFrom import
      gpu: nova-core: vbios: move constants and functions to be associated

 Documentation/gpu/nova/core/vbios.rst |   2 +-
 drivers/gpu/nova-core/vbios.rs        | 658 ++++++++++++++--------------------
 2 files changed, 267 insertions(+), 393 deletions(-)
---
base-commit: 8bfe9d72cf2064f679c4192dba84be79eb70675d
change-id: 20260409-fix-vbios-d668e9c21d23

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

