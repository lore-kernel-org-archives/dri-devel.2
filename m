Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35808CA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 01:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EACB10E9E4;
	Mon,  5 Oct 2026 01:46:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nvPyYFIe";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEDEA10E9E4
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 01:46:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Swbm4/v6f2aLc9Exfz2HAkunU5voRwucE5YiynlexFjsYZNIhqROj5lwetuJe2pIWsI+3vg0EDFoG9BMQXAQd7UC3oUYppb7AfvqvCmWt68MGym5jgeusA42cov6HzzxOOUCtG1YYkoOEuWluHi+2lqLir3JC3WAWfBrb3BG6JeIkLUk03RuslbdZ4me3f9XbBVVycaMmXoZR4QhP9DRX6Uy8T1nW64ZrBoITcqQcRq48ywnOkNzXxQ76Gp3sIIHq1f2SkKirgm7B5JLM+rclQJrdSmKjkYFjqQxd4tSvuhG5f7AAw2Sotl9uV3IHReAQsmzuGuHKUM8CoUj9bXBdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJlnmlEN29qGy4FoiV0wdjFKY9YN6mRxTY4Wj7e/kXQ=;
 b=D3kmMGv2WHtgr03gs8NfHuAQ7AmTLorrv59tYlqRG8BvFY4AN7zcOnGjXa+HE66V98+yhxY+Z/TcGI9TLXr6FcF8tCWeYZCt3Mnl6osaFolNVyt5mvYO5fLd3OFEvlE0sEGTFj0Y4OT2hY4ODCZCxJiSOHqTK3VNWElniGjV9anzkmLVJFlH5NaodNowF+t0id0/SR06I0IA0sXdGit6fL/CqkHwwmcWMUrT/wdRqF/6osDiP/AvMQDbCYkxfoW/b058LEVk31zkOxgqEzEZQfrZUKpBCXHVJl9p3V4NB7lYxgct9YWvYF5RNEUxsDX1/3MroPZ+hVi+F0vhJ9PrHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJlnmlEN29qGy4FoiV0wdjFKY9YN6mRxTY4Wj7e/kXQ=;
 b=nvPyYFIeB0iClLWOWEUs0H4MfOthZYpQKelj6oAnMaP4pWsplRhGLHSIx06xPiM6JVsOP5O1i8E5tK0mwMPuukUHK7Y4dBiAG+oFife30GKdcTNUa9O/GSfY4muQ4KW+UWjoKW+uXuPndg/nw86IoC+JI7CO1P4JX215bkBzbDaNuFavGNhkXOzNOKZqRc0tc1V55wDcZ2SuABxqv90PrVFiCD6fd56u9YU5apg3i6U2LD9fPSya3ptgLrZdX5p1V6uPReOLi1LV1xGajGEtJCPk1Q/KoBkzQ33K9LkwgsZ5ag7sv/eAftNEqt1RuckWUu98Ddt58sik9Cz18W8p2w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS2PR12MB432622.namprd12.prod.outlook.com (2603:10b6:8:70b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 01:45:48 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 01:45:48 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>
Cc: nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
In-Reply-To: <20261004-nova-int-fixup-v1-1-9e4bce097f94@nvidia.com>
References: <20261004-nova-int-fixup-v1-1-9e4bce097f94@nvidia.com>
Subject: Re: [PATCH] gpu: nova-core: fix warning with NOVA_CORE_SELFTESTS
 disabled
Message-Id: <179116465060.2110289.11293506958359500228.b4-ty@b4>
Date: Mon, 05 Oct 2026 10:44:10 +0900
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OS3P286CA0032.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f4::20) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS2PR12MB432622:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb56acf-1d2c-4402-6df6-08df22826121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|1800799024|376014|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MoLZ39EqCA2Jgc4PRyCLIihPixuey1x+abWroTVBuP8HZJWTetX21fKog8KgLntkc9CETrxouLHc2cekBYUaPy8BnYM/p8e184l+mgYI4iUAbD2zAEsepLF3luTXJ395AOZ5H0egZ2TmNYbjOQCVRncBL7B665KDknbrIcUWhYeDHl5JO/Hm2M1f2L8yzEtBNy+xfEJ71dJ+8bPqS0hXXTGDKKBUj6OOyQjV4+OyALKPBLB39R9qGo9USDyf9do7tZ9MTP4nx2CzGULqs2V+mE58rEdcQTs75cpXjLsZ9x2eUvJ3MZVBd+U5HtWrKbEDnkpM6vjnwuxZpSZEkmHi/XHNECtToWslJOJokaWuwXLU5Tn+XjtaNUpX71fmJmhRYmDskFczUO/fckx7qoGlnW9ORARhQqQPR74Y31HPdkpu10UFH6+I+dG8do6DROQVA300JzCfEg49M7Gt7ZFqBLywyXIV9ShrlfRZ5MHehH9pAihEwQ2JUVbj7KiZ+wDpN8OCLl/B8Fi9K+XOOehozpu9dSptVTsHXUJqkCjrXRpi2YyC3KwmhBrayUgeGKmcYjnjfM+DtKu9WgAD/GF5/kfw0t560L4469YkYNmDBC1ZhsRwvTO/9PHv3L/Iaubf3Bow8yZv1XJsRaajUST9cmmDh088gWUcJxa/dc2/qrg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGJtUVJzb1ArcnVCU0VpNnFoTmluRTZmRk84aEZOOHJnSjFMbERlclY5SkZl?=
 =?utf-8?B?SVhDdTlNSExxTXkyYno2WHV6QUZvKzFHZXFpZ0FhamdUT3hXUllaWXhrd01w?=
 =?utf-8?B?bm1FR1VMNEJEU0d1L0YzR2s2RWtlUU1yRno5YS9WR1YzMUVNNG5kZHVtcjhr?=
 =?utf-8?B?YXh4YWNDUTh5NGJ0QkVaVmVDRHhaeHd3bFAzUVVJOEZvcG5uWitPcjNGNEZS?=
 =?utf-8?B?dEEwNTBEdzM2RE9reUdLd08yUTZOc3hWV0o4SmFyVElFcUhCY1l1ajlRenRR?=
 =?utf-8?B?NmpIMjRyQ0c1RDJTM0VHSTV2NlRhV0g1Ky9pcTBNRlE5SU80azJOVkp0T2dz?=
 =?utf-8?B?Vnp3S3I5VWJxOEZJL0NOOHVRRXhocTdqYTM0U1NxTzhERHpya08waURNdDha?=
 =?utf-8?B?OWhMbVlhMEpiU09INVBma09rTEhYSnB5NzRmbUlEcktwcENQR2NGRU90aWtV?=
 =?utf-8?B?TExBQmI1OWNYdTBqQWlCdVZzYUZOcXQ5YVp3djExTGV4eE9Bb0VVclpCRlRp?=
 =?utf-8?B?NytFTXF4Q1RpUU81RnR4a29VN2NjS2lpa1pWRjhWa1hTRmEyTkxNRGVYWVls?=
 =?utf-8?B?b0tZQnpUanBrR2x2bys2SStacnZLK0NxYUFJT3QrQXY5TUNwdkoxS25CK1ow?=
 =?utf-8?B?V00wTm1vMXlqMUVhYUFyTGFYQVZlZExGRXNsWTZVV3phWmc2a1p2S0w4dGh0?=
 =?utf-8?B?Rm5lQkFLZWpFZHl4cUl0eUoxL0xnRGFUVlh6YXRVSm0wWjc3a0RxTGxCTE5H?=
 =?utf-8?B?aHlnTEJRUlFqMFFUZG14VFV3RHZNcFZjakQyNFVvN1Q3NEQrRG80eXgxZjU5?=
 =?utf-8?B?QkxhTHFxenlaUDBkZlAwKzFWV2JPOTAzSW5hNXlBWUJPU1B2WjROVExpQk1G?=
 =?utf-8?B?bFBtSzd5SW0vd01Vai83UFAvN0xyYWNrQTkvRWtnUDlMNTM5ekNiRXZYNVJN?=
 =?utf-8?B?SFFPV2ozTkdEc1VqNU1La0FrVE1MWlduU01WcHhSajFyWTdNNDlqSnFKd1h2?=
 =?utf-8?B?UEJkMGUvazdDT3E5M0ZacFBKc21qZ1ZTOXVKRUNiejVISWNwc3V0b2lRaS9k?=
 =?utf-8?B?SG9XanY4cVd2ZjJZVmRBOXJwcnN3eFdQcmhmNGRJeW1GMFRQVlB2Tksvak04?=
 =?utf-8?B?L2pKc0IrL2s5dGRMYm5Bakh5dVdaenJubEs0VlppSHdhOUkwNm5ZNmxubzBp?=
 =?utf-8?B?azVXeVVrSDFVSWlRWVpoalJFbWFsb05OTVRHZUpiUm84MTFuOG5Ka2dPeFhD?=
 =?utf-8?B?WWVtQ0h1OTZucnVSNG9wK0RKci9NQm9XWlFUSDA2dWZqREoyK3hiUEpzcjIx?=
 =?utf-8?B?Q3hLOTFuMDVPVXAzZUhFRk8yeWdxUi83aDlwR0FNb0dWSHlaWGI2QklJR0FF?=
 =?utf-8?B?eW9kNWhZY2lIdTV5STVoZ3RONEREV1ZxSHlaRmk5WVkzZ05TN0k3TEp6OVF4?=
 =?utf-8?B?OUtKb3VzT3VmK2lOMU9abXNKZHMzVnhpNWlpWWJ1V2tjUk85MWtLZ04xQ2dT?=
 =?utf-8?B?czI1UUttOGM0UTNvbnFzeDEzdnE1aGFDSVMxRUE4YTIwMyszczlvSmFwdElx?=
 =?utf-8?B?K3pIek5zM0JzajEzODBRWEZyRWNoVjlhREVNZ3BpMnkzUE85M1c5dHdKSE5I?=
 =?utf-8?B?VTZyTEZoRThMVFdqd3lnV2NKTTlQWUNINVljTDZSWFZLR21TUE5leGlnV2tk?=
 =?utf-8?B?RmpqRTlCTkxuQk92YS9yY08xRm8ydlJ5WHlWMEJTOVMyTGc3MDJQdXdRNXF2?=
 =?utf-8?B?MUp5Rkk1T1FpQ0J0anJRU0NsN0h0UHVBampWM3ZQY2RjaWQ0R1JrM2g1MEdn?=
 =?utf-8?B?VXcxOXAwSlM4MjJzcmZMTS8yUmlyNStuLzBLVzE0VGhVZVdRSkdPYmNjRHJX?=
 =?utf-8?B?WXYvNzJja0pidGozZ1ZVUElEdVpJTG1vcWhGMjllTW0yVkpDdUhTWmw0RWtV?=
 =?utf-8?B?cTdGLzJlbTZBTFRXMVJzT0R6cmZEOEpTMCtmVlFqcENyRFAzVXByMjVVdldP?=
 =?utf-8?B?OFF0U2RBQ0pOZXhTNzhSN0VQMzVuL2VORW9qcnZCQmlTMHdSSmhlZjNDQlB1?=
 =?utf-8?B?S1dpYTdnUEtzUU11d1hDVnN5YWMzZm9yOWtGT3dka01qSnZ6RWEwSEtsSVli?=
 =?utf-8?B?UE81TU9hT3dSQ3Ewa1A4S2hrVFB2ZXBUK2VHTHQ2ZEU3SEt4RXJuSVdOb2M5?=
 =?utf-8?B?SnUrK1JxTm44MUx5ckR6Y0gvaXFvaFlMUG8yTGxwemt1Rys3N2k5NXF3MjJv?=
 =?utf-8?B?MmVvM0FnSnBlRVk2MGROaSthd0VQdVo5cVhQKzFxcG9vcTVrREJuTHRiYzlI?=
 =?utf-8?B?a08yeHc4L2gxMEtBK3NiMU1iZkhjMWp6cS9mdW9oTGFKeDVXcEpGNFVsSC9Z?=
 =?utf-8?Q?2Sg27okX8QDO6yu4xYCAkdC36qUFto73A+tRhU5MBGHFp?=
X-MS-Exchange-AntiSpam-MessageData-1: u8TwFzOF6sycJg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb56acf-1d2c-4402-6df6-08df22826121
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 01:45:48.2688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OCg2pUJcDrysVxAbpQm/rmSklR1cAqf+tzB/VxlsMUv2pajAaNjOe029NYeIxGxzmFjjEFTeoVnyqXNbTqCrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB432622
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

On Sun, 04 Oct 2026 10:00:49 +0900, Alexandre Courbot wrote:
> A module-wide new import becomes unused if the `NOVA_CORE_SELFTESTS`
> config option is disabled:
> 
>     warning: unused import: `Spec`
>       --> ../drivers/gpu/nova-core/driver.rs:29:9
>        |
>     29 |         Spec, //
>        |         ^^^^
>        |
> 
> [...]

Applied to drm-rust-next, thanks!

[1/1] gpu: nova-core: fix warning with NOVA_CORE_SELFTESTS disabled
      commit: dc90f13368ac509b05189089bed178858234c050
