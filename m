Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BEACDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 607B489131;
	Mon, 22 Jun 2026 07:00:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="LvGLC5o2";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52A6310E4CA;
 Mon, 22 Jun 2026 07:00:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdaU/3djv9bDJ1LeDH2msYbx9Jh/lJaUZ2O0dMKQxpVWgXVsu6ehFh1A3wfTTiwjP7Rmv2YW6qlzApagXTsyNz943sxL6xwr6fad8Plryn5MlUEkXIrqpJ1Gmb/DN56wc18qVwz/08A0tfYGDUl1RcSQXySFz0+cxrZAFNjGbeZBQ7DqgXp/fzo1pMVC0HKgR3pOzp7X2pKdU3FsIjI0/l0npEtjjRqYSGjjSoz+Tx8EASqAmdQbzGMFPfcSbm2fiuHk2baFWTH+CikkLqQbZbtQKjXRVgS1HnCmsjWEReLhPu15KoIdYlKQUvAq8ImBF3LoJn0c1g2vmM0Cj9OWlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Fu1tWeIdBjmhg2HSpAptxRE1iMXBG+Z2HXVjgiGS3M=;
 b=Zr/vaYHCDs8NNxCRtdXFpezfGXvL0qrNROhwyjGLt0V4HyDhCFli+GdPRV720F3e8fSKQXoW+821MoTJBylbv4mPH3aS9UkUhNfNAqAL6OwGlvgo2Zvg1org3hB43Z+Gij5Z5uIZP5y+fntZ7cin2jhIgIAKEqYMG5P4VDUsdRTU91VYl/PODiHepQzXATj79MvqniCm7As7b7kNxLss91ziISZHEn3PxW5xwnnqv45Ht6fRmvWTllcQC0RVuAWZwgBESPKCyqOjKYcsiv4f/VvZrEYVpWLGi5WOqK9Lm1ocZgSo7yYsPSuNoJv24j3tXVfm4AH9Q+NPWN4G7LPd8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Fu1tWeIdBjmhg2HSpAptxRE1iMXBG+Z2HXVjgiGS3M=;
 b=LvGLC5o2x+kTNMeWgUPB/dpwXPCcUZTDoJtf5qBaosaZN6JV/D6E8twOYhAEU7H2LScNDUDT9MxIWkH195LDJPoxz5Ci+IJX4pPJvgKyWqAbWal/UP6fFAQ344TYFTnge21r2r0AXAWIr3jXEEnGoPBbdN+aFImpCPA8qeOWWul0/Zdt7RW/WJMx2KP/H4d4NW5rNjbyzgZD2jyS4F09+Ue2LQQDsrpBI0vuR9YtTC3iOQ4GE4OLv/k65Qucs64xiBkgwpienokDZqfaYW2HQl6vD95x3oErztyDNHB9p8fEO404rYoCOpoOAsM2Afvx1Up69r2Cwx2RiLP8OVTepQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 07:00:40 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 07:00:40 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 16:00:36 +0900
Message-Id: <DJFDUNHANK3S.Q30B27GHLQPU@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 1/6] gpu: nova-core: gsp: sequencer: use GspBootContext
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260619-nova-bootcontext-v1-0-45193cd0a2e5@nvidia.com>
 <20260619-nova-bootcontext-v1-1-45193cd0a2e5@nvidia.com>
In-Reply-To: <20260619-nova-bootcontext-v1-1-45193cd0a2e5@nvidia.com>
X-ClientProxiedBy: TYCP286CA0301.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::17) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SN7PR12MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 46681f2c-bb03-41bc-3c8d-08ded02bf871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|1800799024|376014|7416014|366016|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: vqFXhJeb03o/qIHXKv+yIrUR0WdYlGboNJNC4MUHTU6qCAViMK1Zqi11S85U51exJrIUMxYCMJlVzH4QrGhHp5c7qPJ3Fwqz5/yi3n8/vAJT6i12nc43/28qx+3W/rqqUeFf/UibDU86xsSEAQa8+/DggWzOZ1G/zw8cfuOP0zSooV2UhofQrMGTDsRpCQUTMSEsH2UVuI2AoNPr7knUxXWVDA33ct+5j3EdMAeZPyJLUaUhjAMCcoQtdrHMGZtUTY0mo+/YRAzgOzKBTsKzwENTgjotbCYag5gArUdxAmey3baA2q/+0JGbghdbCFUyWvY47iay+A35Mf7KTaW3GQ/83Wcg9odGQUy0nvXGBCt48OUb7kfKYmBSKc4j/S/aAjc3GSBMerZtmVSN/ZwdRbfNnXhZp7eDo5zRzXjSS4BMWlqpSOvGAIZ+U1Qj+rR+egUCr557rHHExSlsTXPNdxOd5Lugp/srK6MQOX7Cg8uenzcY+6hnaEalpoZpnotrx2sMWvWpLh3J+ljHnLYk9PJrVQc/ESX7KqVR9qYkvHeCzdqN0mZwnplG//zlr3iOi0u0s3LUe9DP5Q3+VKj1aHoIVaRsv4B3oU7wZXc+BOB1iM2cscy7P3XcGH8/6qJEYSxshes79Nak6HpZwknpkRi0LjItLU+WeCutCSlyA7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXdNb1JuZmcwRnFoc0w5eXR2UURPT1Fxb0hCakpnTDN5c0d0SUhISC8wSkZs?=
 =?utf-8?B?SWpFaEpyaU4yWU1ObFhTcXk0Yld6dC9ra250ejU2akx1WG1QT2Q0em45elha?=
 =?utf-8?B?aUc0YjFMVSttblIxOE1tTmZibXdUaWp4SlRXYktJNFZlNCtxeitsb1BWVS9s?=
 =?utf-8?B?KzhVU2hBNkg3NUkwY1gwREJhbEZxbjRReFBVZDliT3dBTXdBdnRxVlNMSkd1?=
 =?utf-8?B?VlVYeFZHcE43eGQ5OXlxcTk2bUcxM21UaUg5eHllVDZmUXQ1UzRlamxFdnVF?=
 =?utf-8?B?QWQ5aHZzZ1NMc1hUYlQxYmg3U05vUE1NWFNuQjFyVnh5T3czTmZvOStkWjMr?=
 =?utf-8?B?c01KNkdKY2F3M2M0bUtSVnFLTzk5Z1VJaGhSMkE4TGpsNThtL1B0L1NqWkRa?=
 =?utf-8?B?UUNCVjFRcUtENUVuK0N3KzZTZEdUSjVGWkdlaGs5bS9CcUhkNHVhakVkWnBn?=
 =?utf-8?B?SjU4WGYvUGd0cnoxOFJNN0pHaTl1WGRDOW02WDFOZFRGTVd5RS9leUdCTEdP?=
 =?utf-8?B?aEt2b0REMjljTUFsNzdJbnd5YTQyS0ordGhsbENaZHNYUFBwWjV6bmJ4NU9C?=
 =?utf-8?B?YUNCQ2xZOTF4dUtYYWFGeWxIbGVOY2lWMGhPWS9pTDJ3d0d1MTVRbjRnclVM?=
 =?utf-8?B?bHdWSElzMERuL1M3cjR6L1JPZHBSV2ZNQnQyai94M3A1YS9vTTdpT0toTFQ2?=
 =?utf-8?B?MUlBNjNzV1BqT2VCMWhhdTFSNWFEaXFKS2FMYWw2cDJ1TEhPSmhuaXBUVkhx?=
 =?utf-8?B?UjEyQVk2OFlmWUNaOHMwRnp4cm9kQWF6cHNxYkhyYXE3WXVKY3htWG00M0JR?=
 =?utf-8?B?dHczR3ZBbHBiQXdYalpSOTNCT2p1dXJFb2piVXZ0V2ppNGZkMGs4VXBVN0xH?=
 =?utf-8?B?eEl5MEptcFJwdnZWdC9WbXJ1ZEgvd3pOK0tLdHpTbDBHWFZoNGlZNndWVkt3?=
 =?utf-8?B?VmNzclRHcFVrUXJKUGRuZm9pN0tVOG9LZXZ1aXE5M0xUZFZRNkJwekszYlJ4?=
 =?utf-8?B?Rlc4NHl6T2RsZ0RlYjBZemNhOGlrQ2lqVUtMMGRmejRnUG5yeDRaaE1pbGNh?=
 =?utf-8?B?Lzl2NmZkRGxOdUR4dzFNdERQYjA4ZGtPZkYrdERIZE1mL1RhV25EQmRkU25P?=
 =?utf-8?B?ZWdCbG12dTdFci9pQjhHM1dENUJWOWdVWjIwdW5SS09xNzlhVXRJazk4SFR5?=
 =?utf-8?B?V3Q2cjhoZWpwOURveVpidjVyVzF2YVNVQzUxWmdxMmpRanBKcFVNYWdXR1NZ?=
 =?utf-8?B?WEw4Z2MxUlU3cjNwQjlZeWw3Z1dLelUzcG0vN0piUHhxRUhKZndxWGZOY1Nu?=
 =?utf-8?B?UE5LaVNHM0NQWWFGVC9XWHZOdUxodjQ0TnlpUFZBSnRtSE0rcGkyck5NQU1K?=
 =?utf-8?B?ODgwR3YzQVdiNndQVEtUWm92UTBCYmIvK0xIMlBWcm96MkFnbms5RkNOc2dh?=
 =?utf-8?B?aFBjelQ4cDkyM29XbStrUTJDMDhaQjZVUzNyT2lmNHVJdklHaWpsZFRpU2Na?=
 =?utf-8?B?SkR3dGlRMzN2aXMzYXRSeDNkcE9UN0NrcG0yMjRUMDRjTU11WjUrcndHbXRD?=
 =?utf-8?B?cERoT0c0TXNEeFloVkpDQnhpUnFocGZFc3d6T0FIUTMyME9CTUNPbEMyb0l4?=
 =?utf-8?B?bjNqWEZVT1djamE0N2JIdlFRcFFzTHB1NVFxTG11REhaZUM2OVM0SkxjR0FR?=
 =?utf-8?B?dE10SUdvNTBpWXM1R01qMXhOYmpyK3J2Vy80eVZoRUxCRlNHYll4N25rK3dL?=
 =?utf-8?B?Y2JNQ0JFSHRoMzdrQ0h0NnlJam9vUmd2Q05oOE43dHR2V2VreHFwWHAvZWhw?=
 =?utf-8?B?TzgxR0JlZzFBblpQVjl3REFFS0VPTGIxV1pLMFNINERRWWZsMGVUT204Mzd2?=
 =?utf-8?B?VDFUZ1pHaGUrTHhXdHVmK0FvWWNTa251bGFOK1ovbUpITHpPbm9wRDBlWTgv?=
 =?utf-8?B?VDRHOTMzbE42V0ZJZ0xVcnBPZmI0UXpqVVFSZEU2MFRYSmtDZWZiT3NEWWxM?=
 =?utf-8?B?VGtKbndDRjhTQ01Rc0oyUzNLMU5wSzFXK1lhSVhYWmEweEJMbzN0dzhBZlVR?=
 =?utf-8?B?T1YwSWpHQ1U1eldEQWp6Z0VqbnAzOGovWXhxQytiNXZEMElvbUoxN1JNM3My?=
 =?utf-8?B?QmRVOHpBMmJ2QWxxVngySTFOV0FJcWR2UU1WREF4Z0hFMW16c1FFNjhqaGRO?=
 =?utf-8?B?eXpodjlRSXArSC83cDVGU3IySC9Ebk82dGRRQldYamZFdkJpUXRjM0tFdEVI?=
 =?utf-8?B?OWZuakQ4S3BGK1FtRU1yS0x0dUJHN1NINkZZbzFkSGIvOGY5WHZYbUhaUndM?=
 =?utf-8?B?blZKZ0pEVUVWVlJ5Ri9LaFZPK2Y1SHpTY2ZVd1h4NHFzM09JRE1wcHQ2Wkhp?=
 =?utf-8?Q?D9fuggRZ6HgVaofeZMzknc0w0clpJ1/036sfL8Y11i8oB?=
X-MS-Exchange-AntiSpam-MessageData-1: Ncin0wGtNIa8fA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46681f2c-bb03-41bc-3c8d-08ded02bf871
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:00:40.6148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsWiKC/Ty2+u6PFORRGyZ98X7cYzo7O6H2Ch1r40iSH2gr2jxinU0uZwjJFBcfFmJnTVRRcH01SAfJ3QCXrehA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934
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

On Fri Jun 19, 2026 at 10:42 PM JST, Alexandre Courbot wrote:
> `GspBootContext` contains all the resources currently carried by
> `GspSequencerParams`, so replace the latter with the former for better
> integration with the boot process and less code.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
