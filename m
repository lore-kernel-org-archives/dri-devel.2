Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6DDF327BF
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:20:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D566710E1A0;
	Tue, 21 Apr 2026 08:20:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="OAjNWDdd";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010053.outbound.protection.outlook.com [52.101.61.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42D9B10E84F
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 08:20:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xp+pHYNMZTzCRLk9TPCJM10CC5hGtUKdSM7Z1g46OCystkOklwXKCWHkJDoBMctMNg5Gc3whgNUXnEVIyd81CNOg4evqsoBjK123aB4hE25GG4H/ZYHXxf0CwM2R3/LkcnjpQw8zKhETizPL2rsjXAu08GbMdUlqTB5iEJ99OkJIQt9YWej8Oo5l9FlHhI/N7ghaTyAcQxQGFequrPLEYXHHbNybCuRZ/12TFBU1xbktE/8jWIFV7tQh++dIvCYzkNInCWgr2CEq31pEN+GYdCN7GEyKlxB2OS42ODUFqQmTcG6uEtkY3kwr5uLGEKr3KC4n1aV4BI5I0ASGWXv+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=St7r6vXmQZtIH/lP/EfpKY0HRh4vqBU08jdFg8Xa3cU=;
 b=mNC99Orz0p8uinqZQwkb0pcZPw4ylNNbsx7ZgQfbjG+J5hRIiRPJTPjgO7XztCagGlJ6zopY5c2e4f9HipDymRCbEvIDmTCVmduGwQjQ5aPidRAU5EL89sRMzjtpTvezGMyYwaRc3zxqeUiFvmjxgX6jTU7AqT0xZoeRNyzbcHLPu84fT/bgXjEpgRMvwuyBzGhMb8Vr6ZdDjWphZ2SULVDABtDhJcxbNxWBFp+G3OJRncnMUpzgtUb8AIrZ/S7kELshTXXnH4I4u6hx0wF3StRtLQbJPgkBMHOU7YuOgD7afuyEBay1CKnJDpcq4KBlDOR4XpKjQ9gzNqrGQ/R0FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=St7r6vXmQZtIH/lP/EfpKY0HRh4vqBU08jdFg8Xa3cU=;
 b=OAjNWDddULeKY2c2n7o+OqHh8CP3aMaUfCYtpHl0LQWItW99h29sZfYsIvNu2w4AIMMB6et4c5cUDg7at07u6/eDhdhGooia2SB8UHvZqLiqKvfi9c269UVLaMFN40N45UVvHaShvVyLiYVDorBxW/Ejsr3dbHGu9zTGuHarB+ElCH8XSu4V0f0+JC2xI/0XVGqJluMppZceV8YDHetBQzF5r9PRg3HP7CYeO4BCik2F0dDCY1b/ouMfR/USvmdCGsx9OEcJtKOjydRNFiCKdVaIsBC6IDWa8FoB1YhCe2A9ffb1z3itzOetpQ9ClxbclFvFeGaiO9vZppSX+QqqvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 08:20:40 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 08:20:40 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v3 00/11] gpu: nova-core: vbios: harden various array
 accesses and refactor
Date: Tue, 21 Apr 2026 17:20:19 +0900
Message-Id: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNzQ7CIBAGX6XhLIafllpPvofxUFhq18RioBJNw
 7sL1UM9ftmZ2YUE69EGcqwW4m3EgG7KQ+4qYsZ+ulqKkDcRTChWs44O+KJRowsUlDrYzggOQpL
 MP7zNx7V1vnx3eOqbNXMJFGLEMDv/Xp9FXrhfl7NNN3LKqDZqaDnwRoI6TREB+71xd1LCUWzVe
 quKrLasAcmAK637PzWl9AEXim088AAAAA==
X-Change-ID: 20260409-fix-vbios-d668e9c21d23
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0169.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c0c6cf-bc51-4a88-71dd-08de9f7edf72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: hQS1eDcOVCTLOo2RLEOa3GV1RV5beELwyBAebfgnIR52Sv/ZnOnZ0KrcvRzw8aQeaz40xHxQtVOhGftwmbEg/FzGCF34xjMZClReM0mSwynIGy+Rl3PlV5iMVlelLs4LKhRhSjiJvylWHBWy2v2w4jcX/jVK1HMRDdM1RYrwRE53GuiMQOhAr4oaCpNG9WPWHTCFaRbJuymzFh8mxp/i3U+hMJPTeLVbyhtO+Xya998H+g3ctjY+R8dqQMFAP//9hNAep4t38ke/59QwdNNNeGA0MWXMKOWwChzjhxkfrdXHCwDG2R4+JhPa2texEKC4ORWcbUm+lOI2Pwzy8bnvxE+H5BlDr7HVtvHoH2VVIWejQDu7rXByplZUGQGxsPf90bz989MTBzmrxcoZhQjx63xzjHsTk8ehmBnpgNDNmRcgNIq7pjHHEYcMd2F68c8NjfdNmDnnh8q2Z9A5eI7C1ly8Ad1Jg3eBGCEmHdCowir8NB/ZH6nJkQQy/YIq1fBnCTrivfVDeSiHnbYUO3FwlR949HmPHg/kMe2kHSZy9uk21jzmENvoScLTCx/mS0M4IpOgX7xmtJ4w6G1qdC3j4ZXH8w5RTc0Oos9J7rpnLjXoc9OzZeR3bGD1Y7eBTJ06uK+XEFTf3rXdy84SpltMUDTXJj9k8z+yKTB85wq4HnPv5AYMOkNfky1B9PQ73uBnYE/lh45MMoTiwnWZDqSmDsljG6PbUEFYDeC6QoUgfKY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REdhRExBbVM5SFRtZzdmQWh4R1BwOEFCd2xTY1psTDlwZnEzcHB0Q2h1eStu?=
 =?utf-8?B?UUxaVXlKdTdzTnZjRjNkREptQm9JR3pZTFpHZVRrZFFzOFZhREVHSlJyZmVU?=
 =?utf-8?B?NFBRWGVVYnpzbU9pRlluMzNmMUd1RUpsYjUxS2x3Y3czTTV5aHhMOUNER1ps?=
 =?utf-8?B?K0xMOGY4WlgwaDVYcFRWaEFheEFSZE1oeXYvaE5FQmxkNjZZdTJNM3drbUdX?=
 =?utf-8?B?c3BpV1JEMFpacE1uK3B0VHB5cWREWmZWdjgvOFQ4a1lZQStZZVN3TTVOeTRD?=
 =?utf-8?B?TTZjSkRscDVTTk5wQzNZR1VnL1BRd254U3BUQS9EWEVZdDBFQS9VeVNIOElG?=
 =?utf-8?B?TVVzQXhOVy8wOW1FaEcyeFRIUmsvRGlNalFPNUNZdndJbFcxUkZ2YmFjWnBq?=
 =?utf-8?B?V1R3d1NBTVdkNTZNQTAvS3VweGVLMFN6MnNscmNBRXlUaE1HNDFvdE1WZzln?=
 =?utf-8?B?dHFadGJwRmhISXNlT1RKaVYyMzF1bXVuM0pkcG1zVHQ4MktWSnN6VzZid3NP?=
 =?utf-8?B?cW0yMWxPSzF3d0pkY2YxaURVMUpYMEF0T0tqNWdIQWtJeGR0ZmlvSmFmRXk4?=
 =?utf-8?B?ckRKRVBsYk9ReWZtNGh3WENLWVRRcGtESUtlelB6SUFBcUtjcTNCdmNlYkxE?=
 =?utf-8?B?TTJTY0ZmWFRxSCtPbkd6ZWR5TkJuWW52ZXpFMzlHUkFHM0dMR2kvckk4WVE4?=
 =?utf-8?B?bjVoU1ZiV0Nwa0xORG1pQ0tpMjc4eUtFaEhmSTJaY1dnL0N0M24wNDI0TDJ1?=
 =?utf-8?B?ZE5aNVB0V2ZYTlk4VGszRlYwdjN5U1NucCt4SDhpMGRpRDF4SkUvdGlFSjdv?=
 =?utf-8?B?TUVvUVQ1b3JkbmFLMW9UcTl1ZjNRTEdDZlRmeVYrWVpRd2VKbCtud1RkaFRn?=
 =?utf-8?B?Z0Z0M2Fpazh6YlFGL0dsN3EvZGVEamVBY0FHU1orR1VYeDF5YWZKY3FNN3Z4?=
 =?utf-8?B?UEU4bHFmQ2d0OHF2LzZHUGZmY2xpbXRqZS9CMWdtUDZRNXh5cmxxK2dKNnVY?=
 =?utf-8?B?M2ZzcmZBcExHTlhxdU5teHVKMWQvV2xqYTdJOUcyRVo3YkRjTjVRU2tnblRN?=
 =?utf-8?B?MGlmL09XQzM4NGY3aVk2c0pwVnVPZUpIU0hyM0E3a0QzZFRJMUFxZytqOHlm?=
 =?utf-8?B?Mm4zNm4wVllkODRhUnlHNlVsK2dadlM0cGt6K2RDQWJDRmJjQ2FYa3ltN1Bw?=
 =?utf-8?B?ckMrOTN2Y0tFWE8raHY3L2QrZ3VFYTJZTzJST1l6V0dhT3NUOGFKUGJaT0t2?=
 =?utf-8?B?RThrN2ZIaGN1NnIvdldQcjNyY3E4RkdFRWtjczhFOW85Uld1VTZwYmFpamox?=
 =?utf-8?B?NmVaNEs5bnpzTVZHUUNCR2N1WklrdGUwY2tCaGJmRWRvRU5XUFVDZ3NYQXVk?=
 =?utf-8?B?SWQ0SzEyTXRSM2FvNXhvTUpXdzhHRzBHUHVRczd2eTZiV3k1V2tuSDlkOUtl?=
 =?utf-8?B?RVkxSmlGeEFVazV2bkJ3Z2pIQ3pNcVEzbkFKWW9uMGYwWEdraXNDR1JHRk1N?=
 =?utf-8?B?Q3JENm9IR0k2YzhvQXFUNkdqbFB2VUw4SmIxU3ErVVU1T2cyUFYwWTJYMkl3?=
 =?utf-8?B?VUtyRUNsVHZNckNCaG9DM2ZHVHdoc2MxUld5Ym1wZkFyL0JXZ2RnUDB6VVBW?=
 =?utf-8?B?WXB3bWJjMmZXbGgrajlzQnNaR2xHangveUF4eUNTZ3hqQVE0K1BvdnFEUy84?=
 =?utf-8?B?ZFk0UnB0WVdodklBcGVqVlBrdGczbnFjd01xd2Y5RHR3dFdTZ29kYkNZV2xT?=
 =?utf-8?B?cG80a3J2Wkc4eUNkYXlGMlgxWEJZRXFGT3F6U0g4V0hySUZRUGZMdmRpbDZs?=
 =?utf-8?B?NHA5cFRkQXZGVXMwSktyOGZmWkhHZlJKWE9wa1ZBanJyZlo2aE1xZGJwdC9R?=
 =?utf-8?B?Wk1vZm5vZ3FHY0VMZHBVcE9oK0dpY09RbThtWnhyRk1zbWMrSjcvYktoT0VC?=
 =?utf-8?B?eXNncmcrK0pWbmovRUc1UEVvQXFKUXA2OWM4RUJMWjJjN0JMZmN3YnQ1a0dQ?=
 =?utf-8?B?VCt5RXFQNXhRQ1UrcmtQbGc4bHc1RlVEQXBSWGh3SldTYVdNMnRQSEFlcWp0?=
 =?utf-8?B?Q1BJRENMRURieVJlMGlVakxnQnlqMW92Q3BDMmlpQTE1Y2F2ZVl1aEFuUERu?=
 =?utf-8?B?T0VhZEt1UlRNbVdRbnNNdEV0U1NZN2lRbkd2YjNEQitmMTFTelpra1ZwbGdw?=
 =?utf-8?B?QUMrWmJFZzJoWENSNUJvdzVXLy9XQ2FZTTBnNldsNEVlUGI3Mng3NGlSNlBo?=
 =?utf-8?B?TloyYzBpci9TMVQzQjNybHpLSUNLdDBXcVpTejg4YzN5SVJLd0lDNVA5Q25G?=
 =?utf-8?B?a0UwVncvYXVlVE54b0F5bm85cTdKcWVYUDVobXMrK2tUYmJPMzB4UVk4TGl4?=
 =?utf-8?Q?gHKbqH2vNDZY4HBys3eSuJLGofxT/3kpy/OpX4cI6j3W4?=
X-MS-Exchange-AntiSpam-MessageData-1: ppldx+sTdRfkWQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c0c6cf-bc51-4a88-71dd-08de9f7edf72
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 08:20:39.8461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxiqSfhzt2k5FzBFjyoRhLf7I1KpgdvvzhcGx9sI43EQc+tgGafAfwduzcewchKvtSbfjnLvSbCbjOSWjICgqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376
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
      gpu: nova-core: vbios: use the first PCI-AT and FWSEC images

 drivers/gpu/nova-core/vbios.rs | 300 +++++++++++++++++------------------------
 1 file changed, 125 insertions(+), 175 deletions(-)
---
base-commit: a7a080bb4236ebe577b6776d940d1717912ff6dd
change-id: 20260409-fix-vbios-d668e9c21d23

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

