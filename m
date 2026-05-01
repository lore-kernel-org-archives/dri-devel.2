Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E76FF8864
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 05:15:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 722AF10E4F8;
	Fri,  1 May 2026 05:15:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ppH1P5ct";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24F9510E4F8
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 05:15:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLg03ICj+Yh2VldE+OumTUNZOh75efsJFFI6H6HYGbVdriXnMg/IFCyIx1gZpX8G16Ha1eCCWVVq3KcFhN6OeWhZped8WY0VnlfYjzdAAsdgHpeqbXm8QYvNqJ6hOeGFu3eAhg5Pvp8sgFzrUmf0ZHIQ3d7khxtFULmO6bP8K3qjPyo4MVqkUnORETEf3Ec8byn+D4wYoWGlc1rvxdaYXKDQB3+1GYCLee3Y9rc7Oxyu+hH8Eqd3TVOj2kGGcrlilD4jiUiDxPaVCHpuhnCwWHbVkfSFLKtrQSt5bvZKqWCf/YmhwfQcyk4R0jbxXDkTsJVUrbI1peEl+BPCZGQ4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4F+ZMK/hFfRIRN3+o8qW9SdgaEYC6jB7rFWiYDu4lOE=;
 b=Gf6QDx5KNznqQT0SssWBa9dLbN3ueUTGGPVBX/F3ZmB53Xj6cKxfKSh8yISPbbrPuAm/0haFKgQBWEV7RlVgQ1GghC63vCaOqyVcRpKrSMIeW+eGX2dcNDbcRkB57UjM2OqjAJ/kcDTymkR8I9fodZDP+b/bwb3d4liND2kjY+D8CHQls8F0UrU6CmLCxpiqIWUq4maGDRCcgn1g6/7dPYBfl8hlspJ7MiZyNwAxe+tTJ4F8qF84wh7+liasykTPeVr1m+ACIpAEMSQ6jYkM9I8cF0jyrh6E9UlZ8hfOdq3ndMDi4dKnfu3ZQrLFTSBlUHYPbejnDFsSpC9b1YEvTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4F+ZMK/hFfRIRN3+o8qW9SdgaEYC6jB7rFWiYDu4lOE=;
 b=ppH1P5ctynv9cDKUW3jcUt/rtMBgF/njurMMCeCpUL1MKllkQ0b/bVEQE4eJGjtMN2UTU3LqQ80ezPevVixKV3exurcrclFSZpMkdzNU83bvyAv42TArdJDKbn3QiSUcHL5xyx1rbx/yYl7sFDxK8cTfQO532h+eZHZGZaM6xAf9tax57FrRKP++lHeoZhKI+HLX2QpZYgz/JtVVp0SEGkPiD8mw0CJw/cRIDLVr/LTPsny6Z1whlHaeNnh2TVJJpcEjUWnjAZDOTpa93l0LI5kJ9Uw65vhYbbARByLrEVvfM/9jL25FAAy+lN9h5fDYdvgFx72eFlRhKWWLUHS4ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Fri, 1 May
 2026 05:15:49 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 05:15:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 May 2026 14:15:44 +0900
Message-Id: <DI7321EJOF54.3G9O56RIJTYG2@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 01/11] gpu: nova-core: vbios: fix various cases of
 reading past `BIOS_MAX_SCAN_LEN`
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
 <20260421-fix-vbios-v3-1-8f648aef7a85@nvidia.com>
 <DI5O794IQL4T.1TUZKR7LI9MOS@nvidia.com>
 <76d35553-fff8-4de0-9815-3a2b777e43ec@nvidia.com>
In-Reply-To: <76d35553-fff8-4de0-9815-3a2b777e43ec@nvidia.com>
X-ClientProxiedBy: TYWPR01CA0012.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::17) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ1PR12MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 8678e9ab-43fe-481e-8c8f-08dea740b4b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: y7aqaDFwRbIRN0gCbde5zY+9eaZgO7suMdOZ3UAeLzwmz5WZr5aKqmlGP1FgNjR0azLK8JXvI+2fmaFOph1/dAv+4ikyVz6rhNCM9yxvthDHmeHIbVomQUSU1FB8Zk0jAZ2jEvB1vRHf1nBhOOK8yeCTq+Pwy+AoB3zqvLt5dOsSIFg92s1b8DjHSSDPCoS60leChTJ/hzb/o9BNdIj2BodgYOpBiuZTkUyAmFTVwkI109q+emfksB+JVLTU36IVLCCGD1JUk18QBPITzrWLRQdQZYJjjjv9jJwTXY5VVM+uQOgjbNJ3DbPwd55/HXeDFEc5m2mcw7wcIoUllGZKL7bML36Jotco+yTq/MGvvzFKPwSZ23DOfr1GFIdQGBuJc7838NBvYKdM35E8nrzsuKudYu1LIesL+y/36Q+zGd/8xXvE6cMVM/4NZ6wuWZCU9VMTBT9FEe56nTujI64/VT7ALQgli0dxTFdXNIj58I+E708AbbOEAWIeNYBzqDWQBGJlP2dn0MEPwrUc6PvQ+f8FqkoCqfdmTLOJDoUicC3xOwWGZ51VH0YAfVqRp9rhYLJvmaOMaM/+Mde3bFhHIlYeunNMdQRz1K1q/UZT1fgirAV5Q8R2FJ80DjT5GZ8ERE7TfjKk935/TnsTv/D3z+WVLRXug0RTuqxPA5Fky19S/KooqlxUpMwBfTQvjeUy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWY3cGlCYis0SURwZFQ1NVJ3RkFMK1FUL2xFRkNOSUM2N0VEREl1VWFoUnoz?=
 =?utf-8?B?cGt3emd2SC85S2xBczJvUWxUaWhOL2dDOE4xL081aXZwbUc5ZU5NWWpyaitG?=
 =?utf-8?B?NUtRWjZrUjRvc3Y5bDBhenB5dG1wYmtiMmk1SnNZZTJzcFNmNTBkVkF0VUZr?=
 =?utf-8?B?aGtrdlU1L245QnFyNDU0VlpJeDRkd3oxNElXT2NrMTl1M200Z3JGTm94RUEr?=
 =?utf-8?B?anBuN2FPWERUUUh2bkpONmdUWlpPVEE3blRkenBaTW14UVMyNGRua25ZVEdu?=
 =?utf-8?B?ZDBzM0w5dDZoMUI4QUJaa0VHUXFXNTFTWFFiSjdhUzRWTXBaVHRoUFNUNDRP?=
 =?utf-8?B?ZzdnekNRT3JVN2JxTExKNGpUK290dlVWUFdISjNaN1RPK0doeUVjeVhlVmtF?=
 =?utf-8?B?Vkg1MmtBZEZ6bm15QmNORUhJbm5KSGVXencvaFM1SG94aUVpaXlIN09idlB2?=
 =?utf-8?B?bjdpVVQxaUJWTFdhbTdlVlRzSlRaWUZHazVpWExka3JFaWJDdzhtN0dBdmln?=
 =?utf-8?B?OGlUcXBZalpSTmNBeUdBQUtiNTVOUTF0Zkl1TVVQZmo1R2xNeTFvOGc1SHoy?=
 =?utf-8?B?cjhNazBZaEY5QzlzMjlic1Z6NE5OUlRtSDkxOFJ6bnpyUENVQklscS9ZekFG?=
 =?utf-8?B?YnVlNDVIVmdPMjNpNVVoVVJtVVE5L0pucTI5VFZHK2RIb084L2d1b0IyN0U5?=
 =?utf-8?B?V1NIcjBwbW0xcWFsbEt0QnpuL0tRN09MZXRHQVV5TlZuZHlwQ21VNWZES2Ns?=
 =?utf-8?B?TjJaaXNqc1pyRVBTRE1DODdEQXBqRFhvT3NKYi8xTzByQVUraTRPTVdxclRV?=
 =?utf-8?B?bFJ1SXN5eW9HelloUTBlUzdITWZSUXA1cFNkQStmQmtJSGM1UlVuQUFHcUdm?=
 =?utf-8?B?cEcvaWVnWlRsaE5yV25nOFV3ZG15Z09DWTEzZzRjSTByQ0xTVmV4VEV3dHlS?=
 =?utf-8?B?SHFqYzBkMXJTRmdCa1dtaW9EZ0YwWFRITmdNRTFFalROZHlSc1RGZ0tydGlz?=
 =?utf-8?B?OHFPSmptOWozSzNtR1V5TmQvemozWHJPUkJJeEFnQUR6NXYwNnVZVW8rQ3pu?=
 =?utf-8?B?cExIWStFZGhETnFTT1V4NUVBWlNScVRYVlpJQzhKUndDK2dkMUFuSUF3RjQy?=
 =?utf-8?B?MTVvS3VLdVpjNlkxSmtHUGoreEpDdXgydzVmTUt2WExHOTJXNFVkUEZhK2My?=
 =?utf-8?B?ZHhQY1lDWktWRmNMcTN3SFgzUWhIbGlxM3R4Z3dDMFFRMnJDbEcrbUQzMU1q?=
 =?utf-8?B?bFRVSmlCZkZCVHI3dTcvT0ljR2c5Nzl3VThRVDFNNHIxdkxZTURkdUc2eFE2?=
 =?utf-8?B?a0ZmMG9LckNKTWxiMUpOanJOOW45S0k1OFZCSFIrU0JzZElKdU9uNlpkWm1E?=
 =?utf-8?B?UXBkL1RKZXczc0g1clV4aWVtNnJnUmpJbHhkbUFVc3JHTlBQRDBIa3czYU10?=
 =?utf-8?B?bnl6NVFhVHRSL0dvUm5Ya3JGZ0VVQmdKZjJOQzQ0TmlQYmxTSGVHa2dENHli?=
 =?utf-8?B?Qzd6ZzROVlBvZHhCck1LdEdWcGpoL0pudWZrRk41aWEvZWN6WWlUWjYyL3Vn?=
 =?utf-8?B?QnNqUUVCa2hhMjhrdXluSE5XakhDWlQ1dzY2clVQeFNPY294bEVnL1doc1Av?=
 =?utf-8?B?MmZVcWpEMmZnaHRGTmwvNjNWMHZSMkJHcFVwMkJQbVhYN1NSTUkrWjVEYUtL?=
 =?utf-8?B?S2lnOE1UY1RRSXNBWHR4Q0Y0eHFZM3IvV0F6ZnZ1WEEva0luQ2d2dXpvVjFk?=
 =?utf-8?B?SDNzOUI5S2xLUDJ0bENDeFRVUEZTTTd6dVFsSm9KZ1VLV3VyaFN5UkUyMDNS?=
 =?utf-8?B?V2hTclkySzNRQ2ZyY3N3RDE2NkZaZUlLVVg0eDlEbzdOeHRiMG9ibmo0K1M4?=
 =?utf-8?B?QzliL2d1K21rRXlNNGpINzRicGJnMm5ZQjdRWnN6RHdMT2lyL0xPQTdXSElX?=
 =?utf-8?B?K0lBekwrZnUrSVUvWjNnQ0hKallPUm5LZmVYQmRIK0VQaTNsMXB1NDRWMGhL?=
 =?utf-8?B?YktBQ1A5eVNOOXZZeFhBM1lxUkdYVGhEQllMeXRrVk1KWTByYkNaYzZiTEh1?=
 =?utf-8?B?T0ZHWHJMM0xBT3RnK3dveWhnKzJxWEdNTUpwZFV0YU9GVjRvaGlidUFWelFV?=
 =?utf-8?B?MXZFVEljK3MwSFpMNkpPUi9IYVp4b1N3dTZHRnI2dzIwMndIalBMOEVmb0VQ?=
 =?utf-8?B?MDRvem8rNkZxWVZWL05ETTF5MHpzL3VmZ0pEVnVydUJBYTJGWjJuSU1xOHht?=
 =?utf-8?B?bTBhUkxqdG42WExBZ3N5U3l1aEJJN1pPQXJ1M1dMRkVkenZnVWpGd0lhclFh?=
 =?utf-8?B?RkxlS3pvVTlLd1hXYjM4ZGlJaERIY1dWRHBsR21QUWtaeEJEYjk1ZVFHb0Vx?=
 =?utf-8?Q?OvQOyLrICoEc9+40g9Oivp3UzYBK5MnRZe+KLMxeHr7hk?=
X-MS-Exchange-AntiSpam-MessageData-1: NPTMTyKgu0uGuw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8678e9ab-43fe-481e-8c8f-08dea740b4b3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 05:15:48.6254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: maqGseaaBDZkPX/me+Lmgpvjt5rZR1ptufaHASp3Yk+W8C3Yx590xcgDj2Xu4CuP6oWcUJXoLehjrmpnQAP9Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6339
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

On Wed Apr 29, 2026 at 11:32 PM JST, Joel Fernandes wrote:
>
>
> On 4/29/2026 9:24 AM, Alexandre Courbot wrote:
>> On Tue Apr 21, 2026 at 5:20 PM JST, Eliot Courtney wrote:
>>> Fix various cases that allow reading past `BIOS_MAX_SCAN_LEN` when
>>> scanning the VBIOS.
>>>
>>> Fix bug where `read_more_at_offset` would unnecessarily read more data.
>>> This happens when the window to read has some part cached and some part
>>> not. It would read `len` bytes instead of just the uncached portion,
>>> which could read past `BIOS_MAX_SCAN_LEN`.
>>>
>>> Also add more checked arithmetic to catch potential overflows.
>>> `read_bios_image_at_offset` is called with a length from the VBIOS
>>> header, so we should be more defensive here.
>>=20
>> This reads like this patch is doing 3 different things, or at least two,
>> since the second chunk (`read_bios_image_at_offset`) does not seem
>> related to `BIOS_MAX_SCAN_LEN`.
>>=20
>> The general rule is that one patch should do one thing - the trick here
>> will be to either update the message to describe a larger thing (and not
>> 3 small ones), or to split the patch. Both are acceptable IMHO.
>
> I thought about that too but didn't say it because it seemed the other
> changes were just 2-3 lines and generally same 'functional area'. However=
,
> I agree with Alex, perhaps splitting into 1 for BIOS_MAX_SCAN_LEN and
> another for checked_add makes sense.

Thanks all, I have split this into three patches.

>
>>=20
>>>
>>> Fixes: 6fda04e7f0cd ("gpu: nova-core: vbios: Add base support for VBIOS=
 construction and iteration")
>>> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Feel free to still carry my tag either way.

Thanks. It's a pure split with no code changes so I have carried your
reviewed by for each.

>
> Thanks.

