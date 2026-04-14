Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652F6F9D0C9
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 11:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D120D10E46F;
	Tue, 14 Apr 2026 11:54:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DrzulQvs";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51EA188A27
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 11:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icHSQEOu5rGQRyyUv4NtvRY85KMz5MmhvviRiBDi+ifw4tdNQ0i2+ZNIOQikA8I0NKN8yDyn5vtJfYaqQb5HLS9YKdPOnECsFIlcxd8eel8LAHJzq4mXc80zlBjAXzRHDnXi69Jh2t5g/lnODTZf2i1ZdY/4wFPAe00d6bhefPpfIrU/92RGywh763GW1S6o5oATJEx9opPpnPSiJtdhoFdY43rzTZ2YssXD3fmt+YXO5ItigasCFY0pYMm5ZLVzOeRoRCX83dkp4LXTjdpwEexItpneygG91ndRscPIgDa74wSFVbkBcLQ2AkEUxNDmO2e3UVYDL9cnbCZQvwTx6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdAF4rbTKD+daZWBOtbRpPB9TuxGMFpB19hzFZUU/HM=;
 b=PBskvF+eLIbvwNJymEtXN/BTmFRqlNqxbMRYrfz/it9+9fipyRPvgvpkb1YpEDRdSnxP/CAm00u26jfokXuOFtNNsn4xrYBZClc4Msq1FenMCY2pWm69aRL7DwYhBH5VG95wsg4yvQfYf6B8JKZ+dEmuvv5vwU9jJTTv+z5tTk6fYbgp4nVbAfkRi+NLBEljH+4chgIpv+PhEmp5kxDZsKCdTMhVPhZ/7MwiSZN6rN6VB2p4l9UuHg0Km4DUGOPyYSUK28ajoZYfx26uwPS7qXSXxXR6BXIQeLFtkQQv7fdSQEoNTBUS4nWKYDZHMU0dtrB4iwBf46ju9Z9NdPlNSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdAF4rbTKD+daZWBOtbRpPB9TuxGMFpB19hzFZUU/HM=;
 b=DrzulQvs77nrRpXK7uxqxt2Ekmf69urIfrBYDVA77Lq0zs+H/xXCBbt3VzsSu56EOQeRo6yeFKaphvJCOfr7v5ZNVRZwJNMCgb4BRrn1QYyOCk3lGBbatsxcWqvs/YsUyLJ9MvBUYKhCn2K1kBChycILN7IqAIyFB1cHCcPPncjXb+zKS58NzTwQkV+ZUgocWshI8bb7Gm5rwRREN6QUDFdQI/CzajPj0WWNI9hFyimgd3cahfHeJ/ExBFbxZ1Q59nJ8kgQO12ztQ9bIngse2i0XyrRct07hXPkqMmeXPyYmw0TRgETMkpT7XQ7I74Mg6TKgHLPEIf1brzY6xU2LCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Tue, 14 Apr
 2026 11:54:16 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 11:54:15 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v2 00/11] gpu: nova-core: vbios: harden various array
 accesses and refactor
Date: Tue, 14 Apr 2026 20:54:03 +0900
Message-Id: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02NwQ7CIBAFf6XZsxigitaT/2F6KLC1ayIYqETT8
 O9C9eBx8ibzFogYCCOcmgUCJorkXQG5acBMg7siI1sYJJeK73jHRnqxpMlHZpU6YmeksLKF4j8
 ClnFtXfovx6e+oZlroBoTxdmH93qWRPV+XcH/ukkwzrRR40FYsW+tOrtEloat8Xfoc84f9d2Bh
 rUAAAA=
X-Change-ID: 20260409-fix-vbios-d668e9c21d23
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: DU2PR04CA0065.eurprd04.prod.outlook.com
 (2603:10a6:10:232::10) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: b127db30-f533-4c36-9e02-08de9a1c8d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 36kEHa1+VR3acSOJXfOfxBRT2dMuqMLvYSKEp4gXbV1R9J4/ihnpaC6bXjeBVfcxLkXpo1xt3aPFOivg4Li1ZVRXPTwbRr0l8HVOBuh4TUOjmHC+TpZXnNBTAfUOUNwIUq294SqfFBC2BFeZhqc+ye+9tqw1oq78vP8Isb5zEEM7+/dfBVUTHntgG6lKivt66agAP94B8x75JXxJ4LuobPd44Pmu/+2ZMm6nto6mIPq4iJ58+2d/X5bLK2yY/9okSgRFLlENgNxmuQL2lVwj9VOClU7p5rK03OraPPv3hn9nxdZ0B0af0hDW1/F6+/f825R9wPEvdqUEK3+ZsNseVvRFuKo1W9/XfgCO2m+k5+Iy1nahHGvyu7kTPQZ3IF3sYmJRbI+6hZQFpL68BrF/fzXwmhtP6OFBAeoVHwX35Xflg6RII5PxcYjzXh1uLrfepOn8Z2mCDN/3j1aWa0li6U66AxsqYPAqA8Q8I/f1eW8SqTEP8M+z0MY5fWyEX1v16JKx5cYvFNo1aKkwwb3kRLC20b3K9FqmIqBWCN+ANpzwsm+rIwD00Wi8LhriVgwqCeJ0VJ9NQoB4lU30J0cojOWQhzPO4c4BXAbM3KBTg/N8G5R67KZJGoxs4cdNOf3K5oOnfBfOJG84aIilrGB18ehquqYqz9REX43iDdgUKJ3iC6upX26sZU9LS+wZae31fLjGuCBXoWi2Wa86ZkjjZQ+zfVObMRWHPNu7FeENjkA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ni9tcHN3ZnZ6MHdkeG9QS0VVZEo0eVNMcEFaUzFlYTRINUdwUVorU2lITHNV?=
 =?utf-8?B?MEp1ZWFsYStLWWgrSkhuWW1yb1plNkV3dS9DZDBpUnc2TzRMU0pUcnpVbXFU?=
 =?utf-8?B?UytVT0hBOURiMEdHNmdLcEpNUVVHSFpIMWlReGsxZE5EQTZHenNqeVoxd0lP?=
 =?utf-8?B?bDdPTFBMWlJ0d2JDalREVkdETnBBMit1UnNLT3BBWlRYblU0NUNIT21LOXph?=
 =?utf-8?B?aUJmOWJ5b3UvdkRMNTVGUlZXSUxoTFRpWnU3NVhWeTZEUllNQ3RLRklCQll6?=
 =?utf-8?B?TnRHa3FWNFRtYjFxRGIvRHVaT0IzNHY1R1NETjdycTVYRVdxczhueHFWelEw?=
 =?utf-8?B?UHlkcC94Q3NpL2dCdmNtRlZFUzdwL2RUWjh2UkJXbTdxUC9ETVpyUFNjMU5r?=
 =?utf-8?B?MkRaQzBsS0tKNVhSMjg4Z2d3N3RCdWdBeEFCVDlISTU5cVU5cGp2L2dWQkFh?=
 =?utf-8?B?aCt6VC9OS2FsNmtySW9maWNEUFMzWWVQd3orOXhLYkU3QU5qSm1LaTM2czBX?=
 =?utf-8?B?RVdpd1RjblhHR0dKSk5ZOUhkdmpFQXRjWFAvWHJTWDJ2VW5OMGIvNU1nbWts?=
 =?utf-8?B?VnpqZUd1TkVFU1pHMTF3SytoM1hrMW1KdTJ5eUt5elBnQ2NQN3krSTEyQnZY?=
 =?utf-8?B?RFdnWUdRa3lscS9Fd05SRmdCa2NYV2FlUDhIZ2ExY3dlL3d5cXRBajloWUJH?=
 =?utf-8?B?UHBmcnhSa1Z6OTFSOWNBV0Fsb3U5ME1tQVpDWGNEUjB5aUc5SmxlVkRmZzRY?=
 =?utf-8?B?aVZiK2NOUXk3QmRxSEE2WDkxWGU5UUMrY1lwalU1K29FbThSeVA0VVVycml3?=
 =?utf-8?B?Y0tTMGwzNEZEM3o5MHJXQ3VFcHhLUjBoeTBid252L2VMZ0c2OWdCRm9XQ1RQ?=
 =?utf-8?B?dTA1dTdTSVdPaXFtYVBlOVA4M2E3Q21oSTF1RkpoUTBZT2VXV1dPei9qNjFk?=
 =?utf-8?B?ZTUvQVNOeEJVREpndm9zQ2YwMmMyUVRWb2N0Rmg3REt0OFFieHlSNE5kWUR5?=
 =?utf-8?B?a3ZsWVEwUHBxa0d2Tk9aRURPYjNuNDdseUt3b3dYczdmYU4rZ1ZSclFwVi84?=
 =?utf-8?B?OEMrL0FOblRjOWovQStHNmgrNmpiQ29NSWZPUGtjb3lROFZCZmc0S1d1S2xx?=
 =?utf-8?B?UU9aN0xoMVN3TDY2cjRXQnd2ZzZCSUxMMU5sd2ZyK3d2d1owR2haK0VWcERP?=
 =?utf-8?B?TTljdnVPR2NpdHlLSG5vM1Q2bk9ZbDBwdUFvaGRGKy9HNjdUbkprb0Q3aUZs?=
 =?utf-8?B?Q0lqdXoreEFXa05sb244aWlockIwb0crdGdoRG1McGFheUZHdjFET2YzSXdP?=
 =?utf-8?B?U3J2U3VNM0ozY3MwS3lOOUlxalkveHFvU1RHay85M1RxZ1FhVE1JcnVsaGNE?=
 =?utf-8?B?STRsSm00aGliL3V5MVhZWDdtWjFkd1YzRmw2Z1VoNHBaak1Rc2Q3TklLUnZp?=
 =?utf-8?B?V0MrZDVDMWVHSDVNYnBKT1pkWmwwZFhPS0srT1lORVJrSHRmSW9Ydld2dzRw?=
 =?utf-8?B?YXZZWE85ZXorZXI4a2IwMnQ3WWVueGlQOGZqeGd1NWIwQ3dlVWNHNUY5bG1o?=
 =?utf-8?B?dm96anpXTGFLWU4veFpyZnlQMjF1VXNqeTB3amtHaTQzdXRiUUEwVjNYL0hi?=
 =?utf-8?B?SllTZG5mL2VTRjY2c0VnaFpqVzRDU3FtcUQvdkwwb003cWRVZ3VUc1REOU5l?=
 =?utf-8?B?dHEvTUNoUHJFSUU2OU5DYUxuRGdwbjBHQnF6Ui8zeGxxdVEySzNnTW5zYUpV?=
 =?utf-8?B?OWI5V0ZKV1JtYmFYbWJDMUNXY1dqb3dPWDgvZnJ0NFFZZ1ZibHhqU0dHUjJW?=
 =?utf-8?B?djVPQ3lkT1RxWm1ZMlppQWJuTk5HeWczVU9YZnRSbXFETzJmajUyNTJ2enZv?=
 =?utf-8?B?WXA5cy9MSjBQajUvV2lXY3BHY3dwQzB5MzVicmdET2JxQU5MbHk4TzBNaVFs?=
 =?utf-8?B?eWY5U0xib3YwZW9LTjlpRG94d0Z2cEVNVDIrNU85c2dTWkdHTnBMNHNqZDBG?=
 =?utf-8?B?bElwSXdjRW9CVjRTb0pTT0I1aFB1aVJvaG14L1h4dHBycGZKQkhMUEVZdEdE?=
 =?utf-8?B?aG42eTdQZnArd1Z4UWpLT3JybHlrazNaLzJmSUhoMHBtaW0rWWQ0YWdRb1Jr?=
 =?utf-8?B?QXN0Wm1vMXhqLzdHLzRRYjRES0dkTVJnZzZHc1VKYXdNS1dhY2k4QzFEdHg2?=
 =?utf-8?B?NlRsa3dONnNZQ2RYaHRCMUxHZ0xEalljTEtRVUQ2Mm9YbVArWlRTYzlkQWRr?=
 =?utf-8?B?TUtZeEFldThXTmUrbHViVW1yTjZQM2g4dVBLUmEybmdsSExVQlZvVVFzeEtZ?=
 =?utf-8?B?Szd0QUZJaU83MExBdlFyQ3NleWhYVnFoY1hURDQzWW5NdDlyVndQczJTRllR?=
 =?utf-8?Q?MUwyqeya2ZBLMR9WBcPN552APPRO86ZK/0PTEwt7LIU7l?=
X-MS-Exchange-AntiSpam-MessageData-1: oeF7/ceYarmmJw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b127db30-f533-4c36-9e02-08de9a1c8d48
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 11:54:15.4834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ltuLSeYm8/to3vWwgoPlwF9T94dH0vcG6Sj9RffJ4440f1EaxPsKn2J+vdJQpOeYalft8LUf6DqhuGAUVkhKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636
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
In particular, it removes `FwSecBiosBuilder`. It also adds some more
stringent checking for PCI-AT and FWSEC images so duplicate ones will
result in an error.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
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
Eliot Courtney (11):
      gpu: nova-core: vbios: fix various cases of reading past `BIOS_MAX_SCAN_LEN`
      gpu: nova-core: vbios: limit `BitToken` entry reads
      gpu: nova-core: vbios: use checked ops and accesses in `FwSecBiosImage::ucode`
      gpu: nova-core: vbios: use checked access in `FwSecBiosImage::header`
      gpu: nova-core: vbios: use checked accesses in `setup_falcon_data`
      gpu: nova-core: vbios: drop unused falcon_data_offset from FwSecBiosBuilder
      gpu: nova-core: vbios: keep PmuLookupTable local in setup_falcon_data
      gpu: nova-core: vbios: compute FWSEC-relative Falcon data offset
      gpu: nova-core: vbios: simplify setup_falcon_data
      gpu: nova-core: vbios: construct `FwSecBiosImage` directly from BIOS images
      gpu: nova-core: vbios: reject extra PCI-AT and FWSEC images

 drivers/gpu/nova-core/vbios.rs | 299 +++++++++++++++++------------------------
 1 file changed, 126 insertions(+), 173 deletions(-)
---
base-commit: a7a080bb4236ebe577b6776d940d1717912ff6dd
change-id: 20260409-fix-vbios-d668e9c21d23

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

