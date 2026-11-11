Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC504606A339
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 01:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bz1Y93sr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D70AF10F88D;
	Wed, 11 Nov 2026 01:38:19 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3EAF10F88D
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 01:38:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFXE4z9wvtblSCgfkJmSPrdLPdgOE7mErFMAq6XzWqPYw4jOANAKu355bV6RTKV/IK4mRYJoj3xWThha7zMrGprPCenlKj2rYSwBOEK6h0PePYFf9rQpSNFJfjv31eHMysSP7aM/X1G1RzivaqCbZ3XYhmV3Yd0IeW+yS8TfqtCr7q5dLc2BBwUvpXSe/BCIROkMnKe3rScfH6oxMrh6m/fR4ytVe+RlYyLILBDct9R+PlyP0yRT+lZB9548qpmyzfeMEqUq08zAQarR6OFUZUnlM0/D/OTqB/5E0JUbEZS8RGoIKRg+FKKtNobVclKgZ2E+IZA5XoP2Q/YoCS+d0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vLMC7GmyFDXT581O9rOwctl3rMuk0XeOS+WDmAFdrA=;
 b=Za7ymxjwuRGR3vPpFQ62+dL5PMsGtNzTm/K/mj5aKgG6oSPvmmti319GyvtB3Mu16eiOnG5CA/HxdcVGek0szLn5uJ769tBpF6IhnxMDLEXEzOBs6MEEVOAkv1Dxbl809wqcmyxysoCrUkcB0mv4Qv/mtjHRIIZHKBBs2/BIcKdh7OFoRkaFm1xDdk7w0/cH+VsFYyXK+vBEaOIaQxjQraqsfRuSahBkFo5vLTAW/t+KTHoHDlt8auC+uUZ8KNGLLGjAYtC+5UU07E3m9/tE7luZLj82WVEFDqEZ2SpwYR0qBuIKPvqRkDRuP9CYwl2UWrICfEcArr9IChFbMzMVSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vLMC7GmyFDXT581O9rOwctl3rMuk0XeOS+WDmAFdrA=;
 b=bz1Y93sru88h8VkhxQZOL55hBHYjsyIY8oeE8jvEgMS/2YcbTDyKNCavZUHEMYNr0PNh2TmwrLqwLGm8Kj7XJQNRWZzdbs2MkV7Egbz6W5OqKfKFn86V4AQ09hNaYIqjE+GzlEjY3JOLcOo/kt++6qqdsY7C/Vbpbv/vUm/3pa5Jq1sTaLmX2/MYbOtOfHeJHuc30R4i4ZPSNOBH13mRL8v9y6yEUovWdsfRjngEwNXRMLMDMxpX8pyDajCTtsLgf4jPWYLKBSAswoBcadx76WElV3N2TJV+gviXlv2aDyoVYFWw/ooNJKC3bl56GHJt4LO8auMIci/plpAjeOx8Lw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 EAYPR12MB796180.namprd12.prod.outlook.com (2603:10b6:303:2fb::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:38:11 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 01:38:10 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH 0/2] gpu: nova-core: gsp: fix misc cmdq issues
Date: Wed, 11 Nov 2026 10:37:33 +0900
Message-Id: <20261111-msgq-64-pages-v1-0-d8c56b6fdd6c@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NywrCMBBFf6XM2kA6sY/4K9JFJpnUCH0lrQil/
 260Lg+ce+4OiWPgBLdih8ivkMI0ZigvBdiHGXsWwWUGlFiXpdRiSP0i6quYTc9JkCGFVipXYwN
 5M0f24f3r3buT00ZPtus38jciL1s+Wk8NyCQWdhqGsN6Khq3TzKh9Q55YG9RKV+jJtsoq35JrU
 FbOQXccHw/GSG69AAAA
X-Change-ID: 20261109-msgq-64-pages-bab32c03d627
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0136.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::20) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|EAYPR12MB796180:EE_
X-MS-Office365-Filtering-Correlation-Id: fb75a534-9c58-40c3-7c49-08df3f947153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|23010399003|11063799006|56012099006|261021123027099003|261021121427099003|10067099003|261102123227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: rwTeJ8DF3QZt1jDabs9g/c6oNnVoNxaCWymb9TYROtrjHlYALiuamwFMRpH/YnsQVxWH1kXSDk3U8tP6WjN+qDtDqsXsil9+nkHDgg14siv9UeiBnF4mdZzqragUXeoUVaml2nhgg/SIpT0YBv0zCJcO+hohvbF/tpJd9NnZtdpTQ/FSZUwMFhgGv1Yaj//gPJZvPwppT4uJ7M/wEi33echCRmFbfl8wEryxE1GLFVNqN6EYXDdYgaxDCZHadoLFsGoioIDMNWeiSP01gCOW/cw8zOPiBW38CuwMpzB9r7ELbRZrULMbfvgkEtxAR6ojFiQYCyjplsJam0PbDl2Pm+cPmlE/83S1W/tnCARw691pnsQV+5lhAaXmcHHHghv5zJR9pJqFV4sN+1p8dREvslBBaaxS7fODq1OELavA0OMEle4/PylgGkMsm7xDBvl1n5MPi6BrCQ4ckZPftw/EPd+ROMa5ZZIdth1MpBxNck6HgqBxa0Uby8fmLIUdnllh8CR8tqhPtDc+71BG8m8lgz2XUiJXWoUz2JniI8CKTpJaqDO2WSKCBIwzTs2f3ezIj8m3oKQDNcnWJeabdB51pAb1H5jR+Af2aCzf6xH84OuZKy1XQWC/rtOmiD8+URxxRLcuIA5Lgzs+bwG4Eb8jjIQ7jnllFxMGnQUzEuxoqDM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(23010399003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(10067099003)(261102123227099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFFjS3ptTDBSM1NyS05uaDdZdUFSTFBNaTFtV1h0SUxTWm5ra2ZMaWhkdDVF?=
 =?utf-8?B?VkpmTHZQSW05c2N5c0Y5Z2p6b0U2aHZPMC8zWDkrTjhWYmhnaUVxMDhDUDVB?=
 =?utf-8?B?Qm9lT1RJTHVzdHVwOEhSRjkvdkVCZG96b0l2bENjTzdYK1I5NTBsbGRtNHVm?=
 =?utf-8?B?OFJiL05FRCtTVXpFWWFQTTJ1VzJpUnBVQUdUd1V1R25OVXhERWZ1dy9hWFlL?=
 =?utf-8?B?N1JuRkp5ZnJUZW5Bd05xZUJxZmZ5YU96a3BIblhPbk9vakpQd3Q5bWl2Vk90?=
 =?utf-8?B?US9acU5KNTdoNHRLOVg3NjVkUWtiUnFnR1dmWVF4OUNibU53WklDVzk2L0pZ?=
 =?utf-8?B?UG1lejBwUkt0RlFka2VlYzlrTDZ3UEJPRHljQ1laZVpBUEFlTUVqZWw1dmYy?=
 =?utf-8?B?aitHblBQekxpQUNGTGROK2djVXBnSFlNUXVzbmdLY1Fhc1ZmbU1vSHU1amZ3?=
 =?utf-8?B?a2RCQ29qWDFIU08xZkg4b2E2ZGpmSG54bkdDUlQ3eVdvOUY5bGo0eUlhMGNS?=
 =?utf-8?B?RFpIQ0tlOUZhSm1Va2tKRkFMNVRqaEhZZC9xMTkzR0M2SUo2MUdqcFdrMUJ5?=
 =?utf-8?B?bUt3MTJPUytxaE91bVpxZVB3M202b0tPbjVjSDA4Zm5mbzdDZDBrM3JEODly?=
 =?utf-8?B?MTVIZGthcjR3dWFxSWs2SzZ6SGtDNEJOTHRyS1pRQTVWZ2ZPUFZ6dnUxRGtV?=
 =?utf-8?B?WFVHdDhrNUVyRzc5Q0VwRVFnM1FIUEozOW9xWnVoZ3pxN3RsWU5SWTg4N0kx?=
 =?utf-8?B?TTY5U0ZaRnVacllBUnkxcGZoUDZYYTFnZjl5MUZ6ZXlGK0M4M2hKV2E4QTZz?=
 =?utf-8?B?VjRjRGQwVVducGFMTUdHbGlrRWEybnh0UlpJOUplWHY1aERsSHZxRHZvQWpM?=
 =?utf-8?B?bEhJWE9xdGkrUjkydjZtT2ppMnJrMzBnUkg4QlpnQ0E1NlQrZVNSRlljdVVj?=
 =?utf-8?B?ekJCemxBWUFtNVlXUXV2N0RlVXNVZnRGeThKbk80YUpsMGdYK3pKY3dIMk1u?=
 =?utf-8?B?azdrTG1TUVU3b2k0QWZycGx6QzMwVnFwQ2FFZ2hBeER3TXlHYkJnVnZxZG1v?=
 =?utf-8?B?Vi9vUThKMjM2bUNISzFPMk11VjNiZWtiMEg5bUJyaHV3UElGUjlaL1FnMnIx?=
 =?utf-8?B?SUszY1ZEcGNmV2g1UkliK3hzeXhkUnpVWmE4SnhXRmovcXk1WDA3RFM4eGx4?=
 =?utf-8?B?ZDFxNWJhS0c1Z2RyS1lCL2x0NTU2VCt4VVJzZTJyUGdVQUU3QkZNVUNzeS9y?=
 =?utf-8?B?ODNhdWw5ZmZnZEo4Q2t6dHVicGd0L3dhTGl5Y1dmVUs2S1BISEVXYWF1MFUr?=
 =?utf-8?B?bVFkT0V2Ujk2SFV5YUZkankxc24vWGVOUFRqZ253MnUySUdUVHZTWWttc2Nz?=
 =?utf-8?B?eHVjVWJFNGoza3NjTGc1SHN0N0lwZjNkRFcwMFdFdE1HbUtNNjNiOHNIbDM1?=
 =?utf-8?B?czFzSTd3bDdtaDBJQTNycUdudHJZY2VUbnhTd3lKUkgwdTRZUlpFTUZuM0Jw?=
 =?utf-8?B?amVJY1oxNDRFek5KNGFvRysra2M1bkthcHhEZjhrTU4rU1lNMXlWZm1PdVVG?=
 =?utf-8?B?T1pCd1BtZXRwQ2hQNzFqVFg1Zzk0SGEvN0FndVJCaFVOOEpuYkhyZ0h6UEVz?=
 =?utf-8?B?dXZZbE9mNkJncURKZVJEOXBRaGZ5c1VoSk9GYk4zNW9ReThjMzd6eTNzTjhO?=
 =?utf-8?B?SDA2UDBZTDdWQVFVUXNlM2w0L1VscDhvZWZ2aVBQeUN2VXBZWWx6STZ0K1R3?=
 =?utf-8?B?dEFHTmJ0cE5TQy9mVklyT0p5Qk5nY3dxSk56dkpkcy85UklMLzBCK3pzTnNm?=
 =?utf-8?B?NDhsaVZYdldZUzlNdFdxMVl2bkVuYll2amZCYjFRYmlmUXlPVGtjKy9ENmxM?=
 =?utf-8?B?SGN1dXlHWHZzK2Q3RlVzZHFxMDcycUF0alJxRUpWbFVTdXgxaGhibUpIanhh?=
 =?utf-8?B?MlRBZjFmTkRXbndZeHhhTWMxWlRBaFhKOVRKTFZPa3BNTFdEN28yRGR2Vzl5?=
 =?utf-8?B?RTNKRm82QWZwRG9PYU9NU2pnaTNBYmZDL1NwMGErSXBxSTlTSVZPQlY5SGUy?=
 =?utf-8?B?a3JPL21lTHVCK0RMaXBCekw4TVBGMXZPOFhvMzNGdkx4UU95QUlRNUJ2eEtU?=
 =?utf-8?B?Vzcza2hHN2sxaVZYUjVrMFlUenhpZTdtSXE5OVNUUVNYNlVmUFg1OG9aQzlO?=
 =?utf-8?B?YkJRaVZwQjhNMm1oTG95MHhPVk5aT0RQQ0RDc1pvSDN2L2MwUFJmLzlieXJV?=
 =?utf-8?B?RnVwN3B6K2dRZ3Fsa0FPNnlmZm9mU21DeUhqWW5wckN1OExRSTh3b25XUm1u?=
 =?utf-8?B?cHgyS1k3L0k1N1Zqc3J3WW1aTVJCT1JTTmtiMmUrTnNUeFFRMHlDQkdzZXk0?=
 =?utf-8?Q?CePZICoihoCyCFlXKIvm3EeU8qbbf23+JDvvCsOPSQlnW?=
X-MS-Exchange-AntiSpam-MessageData-1: GHQk9HYDxRZ5hQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb75a534-9c58-40c3-7c49-08df3f947153
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:38:10.3165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAlWK1NhgHAqskzBPe2UQM+1GOrRvUIN6q7jNNuU2eQun9MKv/XfrxOSsRRSragU9wwu/aILPv6C5n2kdZRj8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB796180
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix two cmdq issues.

This is based on drm-rust-next.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Eliot Courtney (2):
      gpu: nova-core: gsp: cmdq: wrap the sequence number on overflow
      gpu: nova-core: gsp: cmdq: increase MSGQ_NUM_PAGES to 64

 drivers/gpu/nova-core/gsp/cmdq.rs | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)
---
base-commit: 7ecd9ee29f7bfbe9a293952fbc83c3f8bd7205dd
change-id: 20261109-msgq-64-pages-bab32c03d627

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

