Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7321CCD343F
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 02:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D09B310EA28;
	Tue, 19 May 2026 02:57:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Icx7++zK";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99C5C10EA33
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 02:57:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGIi3HR6BWJ7m+kAtz338VInHxGKouLeT3CZx2dSkh4w1cut8gaMwKGRAKX7+acCVmmR+wAAQw0hxhtJDaiQtc/dfZfBc4dpKZ6amhp25NzHmhmZYCSjguKRTEX7+PPWYmgSqHZFK0iYzrQbf0lXpjc1aGFJvl57efpnSbu874oFnxlaDEUgDFCwRimN7Je8Ri9ULuYA5jsEeSJIu3VsHmyPl1c0W1M9eZA7e75rAh61Z6tW7Apw/ZpMZgoIiatO8OUESqyMPmm7dNuz97GBTsP44RPMUaVvh+aSQMgSD9/YXRxxUdQvbvpPurXDQI6hgDFDQ7A1ObVXQTzIvlmrGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZIq3cozq8lFVROrWFytDQNUVTJ6Pzw47RAeysXtExc=;
 b=R00xifwSWQvOa/ojh/uXCg/t58o2w1wk1lA/3tQCZnv+j6sa03pLVdtQshLuXLFwWDBNfk3za0556Fh4UYkpU6JAyDRPxp6Vqy+mZI66CEqhC4ATfqETdogIsml+1wgEOJ8Ed4JJjuO/IO2giABY00GcGWEJ8V93h1hDVwIfza46/pdIfO0yM5H0Qg0wWgQXQUoq3xSpugM/gPzqdBZWl8Hx0PNMqGN70T804RMUT1SIHdfjmU7IBFlI0Uv2P7ePjTjPjQx+0dxx8H3kDhNetKTXRsxaPdF0xXb6N5jOZ3is76EOh1cVv1NXvnV2glr6fhDEVviSrRYpn99XxYX7EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZIq3cozq8lFVROrWFytDQNUVTJ6Pzw47RAeysXtExc=;
 b=Icx7++zKe+rNEQU15epwNsfk1iEKJgq1P+KcbWUVyZZwvzJD9obzUEReINfXdWLt/6FJOeOkljVNEk8vO6rixJFaFSv1tf6UyJxtXfX9rsB5/6H8mx2yJNad0UTYz/hujdai59NyeTfQhsZxtSuf1AGf1TXaPgyvy/gwVyI6FCipYWr6R1CRpWFfHZQ4jSVSYCXapKsIihcc6kUw10ZNdcVF4JhX3SwMbyyg0b+O1CnkyJ6d2H8AXZaRc5GFlH8NR+MILux9aIAX8wjdkw6OV6S4mYFK8MrmNcLWztRyRE/XWCkY2BM9BirtXzqKdfEMhFLp5zSBqne12rH5diBoag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 02:57:05 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 02:57:05 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 19 May 2026 11:55:13 +0900
Subject: [PATCH v4 19/20] gpu: nova-core: vbios: drop redundant TryFrom import
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix-vbios-v4-19-5d3f210c5602@nvidia.com>
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0016.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::15) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ecaf70d-0363-4a32-ab57-08deb5524f56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: Rp4Jdc/zIxc7/yhUVfPOHkzFN7vCMcMzhCqePzFUN+sWF22rzDhDE5ZblcoZPniIHLkMx3HxzOW/oWbyyK6fS+mOj3e8oZoI1WURPymLOWE630RdY+5LWaCN+xFVMTV3S9Kr/L5yZUm637F/dFXkbyBEq7oFDbRSSUoLUnAvMNE5Xl5WQWpGBStkhwxAL2NookvCEqs9lwPn8/9f5/VMJlgWefL8lE59i2pZQ9LDjBy6MQb4UWJfDPVRwmjSm5/5u0oS6WUYLmGGPHLEtFbr4A8kq7qm2o5G0UJLUhOTtEvrfKywt0lUGwlHE+mCqbkdiKKWemov9x3q9LJAg3mbILzHSFcCv5R5pfJNOmQNzEsJRiljY8tl2hegfkrDsvEocSA0kGLZndnl6f+jYU1JXCaPqNu/wS1Yb8O87h/GW9nP6Pg1peLYGFIYP0kcr4d/T7dwqmu1CtMuEGRFzUA0/ULBfKkR8JOtM5v5kVbCpQqVBrlBPT3Jl8JMadjS2KKWsvB82W4fvgcDrbB5OMvKEVTlUn2P6bbe+yoSITxqfC38ORralWD5iXjJZuN4vkpGVRZE61IQhtaXFyzeBA5OC5Aq5FuwpKutT4RXZNBT+t/98Aw3VGSWDz1ValEjLufrHrm8QGhhrZ+J5GZ5ajl6CFD/gJrRAjWU5mckzrkzUvuKNAyMtp2ZbwwCaPiDCsiH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmVlQXJNSzNqZ0ZhNmcwaHV4SXlCMGRLaHRCWlRxOWNNUG5iN1dpZzVZb2Nv?=
 =?utf-8?B?MmZ6RG16YVdibGxNNXczN1dFR0ZPQzJKYmZobzNSdE9aRkRUbHNDLzdiNU1u?=
 =?utf-8?B?VWQxaHRST1V6UHpjQ25nK3pud0Z2TFNUNDYzUHhmd3J4Y1BBSGpveVBEK3dU?=
 =?utf-8?B?SVRHMU5PWHM5SXhNNk5FQXUva2xXSzR1c2RIVENWY3RZY0xQT052dGlXMW1N?=
 =?utf-8?B?SW9KbjZhR1QxcnEvVFB0QzJFamxCd256U0dLb0YxblFTWnNrS0pHdi9teVUz?=
 =?utf-8?B?SHFBM25neDA1c1JlbjN1Vm91Y1EvaU1pNEMxbWgxN3gvRXdmbzUyazcyKzdW?=
 =?utf-8?B?Ri9VdG0zWXE0a3ZlNHlOMmhmcjAyVXFFTjNaZzZOZFBxa25EQnQwV2F6TFJE?=
 =?utf-8?B?MmN6Sms0TklXTWh6cW9Sc3lPK3Q2RlpsMytYWmc2NVE2L1dJTk1aUlRBWXJC?=
 =?utf-8?B?bStoaGt3bisvdDNMbm9DbFhYR0pjUE16ZkRkNnhRcFVML0Mzam41czlVVkV4?=
 =?utf-8?B?VW9GSWwrcmtWb2k3R0hKQ21LOEhBRzdsOFRhL0V0MGlTZXR5TFZSVzZlOTBz?=
 =?utf-8?B?Q2VPVmwwcndlQUtPTjNuc0dHVVFxM3g1bzRDa3JKMjEzSnNCYVJBWmNva3hR?=
 =?utf-8?B?cGZLeDZOalRTQjUzODlxWllWbWI0NWlqdGRud21VcXFYYlFIN2kyMWNEWVUx?=
 =?utf-8?B?dzNyb05qTGRyZFEvSmY1RjRYYXhjbm1KOC9oeGFKbGdxR1AxQ2M0Qmw3aGd3?=
 =?utf-8?B?QXBhZnBKaXoySzlZa3E4ZC93NzdKOWJYN0R0RmFpbEJwbmVOcVRJK3hHaUhj?=
 =?utf-8?B?ampkVzBTa0VhUjNDTXJoSTVGbU95amh2T052SkUvc0JldlowaERiVTVxVTBl?=
 =?utf-8?B?aC9DWERuL0hOeG4rVFRzZWpjNFFJcndIbmxYL0pDTDNiSmlHak1XTDRZcUJJ?=
 =?utf-8?B?WVVYTkVwSXZlMDErUk1acjcyUFZIVm1nZllsazNIRm0zTmhjNmxlQXFleXl1?=
 =?utf-8?B?V3BweERMd1ZVZ1pnWG5VeHE5VG1IbTl0blg2YWFRbXlqOHVRbFZLZjZ2aS9F?=
 =?utf-8?B?OU9VRFVMclNkcEo2NWR0cGRFSk50cE9QRE5pNHRObzB4ZGlhaTNXOVZmdCty?=
 =?utf-8?B?MjB5b2E2UmoyMVFFWGNkL28vSUYrN3dTazJldUNOZmVJdFlUM2JsTmg2Y21s?=
 =?utf-8?B?T21jbFU2NlNaWlNGb25COEN0N1Z1K0lxNG1nVy9KdjJhdGk4UGpleWJFUUtT?=
 =?utf-8?B?KzdpTE1LVHdFSTJ5bWdqTmxiUjZxNUIxa3dlVXh3WFU3SkVuVVI4Qnh4TGlm?=
 =?utf-8?B?L3ExTWdXdjJaN0pkRjJaTjl5Nkw4RWVHVGZTY1p5bENHL1FDK1FnZHgvU1dy?=
 =?utf-8?B?RTVkQWlpOEIzQXRvakZXNEtrM01nRjdhUjloY1QweEdLUFJGNXd4OVhGdXBO?=
 =?utf-8?B?WTczUTV1cHhXZGtLYlVpWmNPOVhGbVl6dGl4c1Foc2JUYVZzSnZHaWpBUEcv?=
 =?utf-8?B?MWhLS0xSNjNVQ2htTEJyanlLSDFHeHAxODlSR2ZTcXJjMTZTM3hwQmt5Zzk1?=
 =?utf-8?B?enRRZmc3dDVjV1JHRkEwNTY1WThTOXBJL2FSR1hDeGMzOWE0RW05cFB1QU9E?=
 =?utf-8?B?ZzhYaTV3MVB0b1dqelM2UEJXdEQzK3NQTThIelhNRm9xSGJMZGtQL1ZDangw?=
 =?utf-8?B?b01pYVJESnd4Rlc5NThKVHZpdXlpYVNpSENnN3ppc0s1S2NVUFRzYzlDZ0pX?=
 =?utf-8?B?dzYyUGczS2RpTzVLZjlVTDh5S3lpR0gzckRGdlFjeWJhWWxNcDVlZi8vS2Fz?=
 =?utf-8?B?LzlKYlg0MEY1UEsyU09Ka2NFVlRocVBXeWt3SGRmU3paK3pPTVUwVWRvN0Jj?=
 =?utf-8?B?QUprM0swZVlFMk1KN0tFZlZtdFFDWUdXZ0FyMXFnUWprRGtINVJGRkhFTDVn?=
 =?utf-8?B?d2h6aTk2aWFmS2tQclJHRTU5bk9zL2VsNHk5d1JSSTM2REpxOGtBTnVhSCtO?=
 =?utf-8?B?NUk4Z2Z1ZFd1a0xZdVkvVTVaU0xodXMwNERFQk1kUk01bUxRSzdWRzNsUlJx?=
 =?utf-8?B?ZU1mMDJJYjBIU2JOTTFPeTlqbDRST00yWFN1UWgxVU16QjFxRjJSY1VSMHJG?=
 =?utf-8?B?azJLdVJnN3YvRU1YY2tMNUtPUmJNRTZSWitDdDg3aFR1bkN2WUdLTTNCUnA1?=
 =?utf-8?B?NkdqaWUyMmpyeE5nQVFmQkFOVGx0N3IzZ051Yy9mb0IyT3FZb3lZUC9sbVBa?=
 =?utf-8?B?eDhpRVRqSEJGUjAzNHJQNll6NnhGNmRGeVJGaXRLeUcvTHdGUVpjSnB2SURW?=
 =?utf-8?B?eEhIckN3bzBtR2E0dXNEUTZnWjRrcjl1dE1wL0NFcnJodkM2TmRBcEpDTWM3?=
 =?utf-8?Q?RlRRY/q5xJ1FIkkhCXjdKGP+i2ct24LPv2u46e245srPx?=
X-MS-Exchange-AntiSpam-MessageData-1: n4Df5aN2BxEAMQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecaf70d-0363-4a32-ab57-08deb5524f56
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 02:57:05.6977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzHQFu3CcBurISiBrrlTesSB/cwZzgC94ns/qKJY+bGTzwFj3mTFI8iMKMqAkqzlhuhWUUVoon4yhIiZfGV1vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
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

This is unused.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index ad571b39400d..9cc2f008bbfb 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -2,8 +2,6 @@
 
 //! VBIOS extraction and parsing.
 
-use core::convert::TryFrom;
-
 use kernel::{
     device,
     io::Io,

-- 
2.54.0

