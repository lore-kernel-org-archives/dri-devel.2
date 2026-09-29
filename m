Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CB6CA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 20:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2493F10E8E2;
	Tue, 29 Sep 2026 20:31:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="HEc77UIN";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8240A10E8E2
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 20:31:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tu4VbAxehuRwjpvIaJ6UULpdGUpHnU7laCfrFkwYwRgcPiAcfQhamtD1jw+UzQHnez9yBJs0nLbDhT1bjc5czqz/VYz72U8vrg59bmRjKtP1EYn7HXw15g2JPp6dSwq51voMstV8L4n07Bo82GtOUSFEb1iMeXbn24sFD7g00ANMt0fwW/xB6z4xYJh10UcOt0lILNJLSnSSD76xQGA6yLJ9P4odMiTN1oEp83NQsShHLy+ksq941vsVLlNBAUOczc0OJ5CSejsCiN6KZoJ46XjIQ6IRPBrUO1a3OF/p2+u3uuNBEiOLSlBCtQUoPTIgk/znMB29ZrL39dRs1pqhxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DU2VJaRCXTc5VIZUnmuQw+Wdle4lf5l0BHe7RK6F8o4=;
 b=EcqeRsWKB0KwdGTfiprxgRTkt1Ldk2hy57Q9/C3YsXCiZ1Hw44DxYcEUwc9UYvogU54TSkc/9DsgKJ3PidRI8xvQPU8vrPGYWF1cggXy20jtE8oTcu+nOSVl90PT7qqfj9PuQm2QvvM4uUcdeN+kjpZQTB2MQaxm9DQiyG79MkN8LtZGArEAETkh2yWfYHXwKyaYWj65YqT6vTFX8qfJS25PLrDsDBJTC1JahDFnm9IPyuPOzyW+Wu5npqF8xkVIWWPAT2pnLKM2mbXtJJ3kMLfbLPvM+wPicj7wwxk0M2jRBJqKP3nBIoX0pyWVYWvjVXNxFtE8dCFwIozWrfK+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DU2VJaRCXTc5VIZUnmuQw+Wdle4lf5l0BHe7RK6F8o4=;
 b=HEc77UINip+9UXf9ikg4bv83IsjQAWadt8I8NbY+8MppFv8Wwl2EZfKgoAI6cnO+yQoCzKr4DdIFBfD78//j5T3dD3s1JZMmsj7ZNiBFK/w01fpKiMzzbYDA/FMM/p3QSi8x3JM6okgBgAIQlLOCMdxZS3p6is4VCvbDAU127Fy34LElfONp51AHMjh0IpXLli4zRW2FnWKpvCsRnqD8cWxq7pvsqSrBE2qiaXaoCUvTKkvhhC2LHDOwCs55f4e+xjtz0xTvo+07z+8eh11kReZ7va9IzzX2gxkCyUC944kBg6839ZAYEsQBX0yDajj/08weVHLQBgHPZdAqfPiQ6A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.21; Tue, 29 Sep
 2026 20:31:27 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 20:31:26 +0000
Message-ID: <51dccdd0-eb85-4572-be62-6ca39038cbdf@nvidia.com>
Date: Tue, 29 Sep 2026 13:31:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: nova-core: use a single try_pin_init!() block in
 probe()
To: Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>
Cc: aliceryhl@google.com, gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
References: <20260927144417.1280385-1-dakr@kernel.org>
 <DLQIRUGZ3L4S.2HUCTWWXHIDII@nvidia.com>
 <DLQZW9ZSEQF8.EFP3CFEMUABB@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DLQZW9ZSEQF8.EFP3CFEMUABB@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0133.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::18) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|MN2PR12MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: 03308aaf-a951-4660-828e-08df1e68a2c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|4143699003|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: m4+zCRTKaJMzJoq71hdQW2vDhzvc+0JraUWyfbXbOOYXiDRsaWnKePm22n5NRd4iuo2JtHK1CA92PdvMhEpvsxKvSsLJTZihlx4+brYVRhw7FguK7fAG4+BqWzavrHOtQZrldvlkbThIN9VBVMcErP8/Rlgd6xw8P9wBl23Ii2YLxHZIACDbC9GCvB19yhyXmGZInTuKnzbXsW/sFJSThpmUU1KYXkc3a7Jk+KeHyUzIxfz7OVUH0NuqkwVE4XNAXXmvfZS17EYvr6W+giaUCjHoaAYx2DqnHtUxToRV5KvtnUUbOQK8ix8Dz2EyzyNiCZxmQG+ky/8XwrzPKDY+8cqNOoQFf5sIflry+W82zr4Zgp78Rih5ro7uY/woS0WvVm38Gow2LrJGJzKw/ulYIEMHP2Qp9JvHzpMoAlnyHIqADVjMKuDM5VBwhgiJhfaTpvdRiznTh/Rt8Fw4BHMXn2ELG7oTFEvM74fB/rM/dvhn/i/wo6A6mEHBgSFrB3CCEA4HzHkWvVHtFWrB/W8M9D+stCJihEzeR752q2VySS6tK4J/aYHmVjqVh77erBB2ilLRz0sTULPegfgKrPe6pOgetsTF9Q3CDOCkuNuiRnMoeG9hcQ81GzgM/mc6eT+aTAnQ1M74QhXMARTd4Y6z+JGvapKAotswwEKfqZn/jvU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(4143699003)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnVpYkF1Ky9wOER5cUcwOXp6UkNJK0RqSnAxUDFiWnNUL0M1aWxLK2VSRlFl?=
 =?utf-8?B?ekhHdzlWL0k0RU1ObnRxOFhTL2pJWTlxa2Y2MXlkRE9wNzJHaEFKR3VidDlx?=
 =?utf-8?B?WEY1MjZ3K2pURTh3VEo3UzVWeWoxcmUvN0tXOEN6cDBkNzM3ZEdqdU1zeWNu?=
 =?utf-8?B?cXRxMEppSGlrNmY1ZEs1SHBLUFpmMWJablU4c28xT0NFTEs5NkZER0lhcFJT?=
 =?utf-8?B?em1RUU1MdlQ3L3NwVHUrK0QxcmNqOTRpYmRndExtT1pMeTNqeTFtdTFQUUNI?=
 =?utf-8?B?VHExaHVrQnhBVXRNRTF4dDFZL3FrYmZZaGI3amJZVXlPUGw3MUwyWC8yRUc1?=
 =?utf-8?B?a091MHRwODkvd3lPenpOa3FWbjRuYjZzQmJZR1JtQ1d2TWhrNUtZc2FzUUlI?=
 =?utf-8?B?cGpWaWFwTlF6aFlseVoxdGswSmV4ak5SMllyUXQ2LzZ0NTYyV2RNOHBXbGJj?=
 =?utf-8?B?bzZ3NnArMnZsNCsvSmlTUk5hVzB4Yll5eStUMUpveEIxbUk5Nk9yRFZ2Vkdh?=
 =?utf-8?B?bmV1Y1phQ2hCaGREaVdBa2h0bEdjVjU4UGtCcFNBNXJvR2hZVnpMTlVrSkFR?=
 =?utf-8?B?VlVDVEl2NHRlT1RWR212cWcwaVJIR0tYK0NLVEhtTzl2M0puODY4L0xxVHpz?=
 =?utf-8?B?MDR2bU9VbVpYbjgvYkJKVCtpOGpnZms5T3Q1N2I0WG5kRERsS25HQ1R1b2lL?=
 =?utf-8?B?RlY3blRhTC92Y1hIUXJEUVYvVWpqQmtQenNJdmdhN0dpTW9pUFFacXJlOGZh?=
 =?utf-8?B?VEVZVXZvY2NKYmNRSCtZUGlCWnRYMHlEd0hFblJPN3R0VnpyVDNzQmlDMW9h?=
 =?utf-8?B?OXZmcGxYUHJ3blpBQW8wQVBwMzZReHNFanFTNEdEODNJREVRSlBVUWV6L3BE?=
 =?utf-8?B?UENkSkh3RkhjaUEvTFFuZmkwSFJqRkRobW5zcmYvdWtuSUlFc3ZLV1VzdmpJ?=
 =?utf-8?B?TXIrUDhnbzNoOWJmK21hTzFQR0lPZmE0WWRnYTNHMEFOSTcxVjBTeXVIZW0y?=
 =?utf-8?B?Rk96T1dDd0xwZ1VlYzJFdDdUVkg3VUVXYnV6SkxoVU95eHF5ckEyN3BDL2VF?=
 =?utf-8?B?VFBhcjlRTmMrR2RkY0JUOFltT3podTZQNm1XY3M5eFFZdDBCOVl5RUpMWDBU?=
 =?utf-8?B?bTZwaXVBNWx6TW9HOVBzMzZ0L2ljak1oT0NOYTYvSHJLSXJmVk1QVkVCejBM?=
 =?utf-8?B?UUdCYVJlakVZQ2VZeEc0NFBqT3Fmb3cyZE9rejdqQzlZNGZDbFB6M1pKTXlx?=
 =?utf-8?B?UEVRaU5GWngrUkZzOFcrVlF2Z3dNS1YxdmE2VENqc0U4SHFEUE5WRHM4a1Qv?=
 =?utf-8?B?cFVTZlRRS1VWWVY1THBoQUF6ZGRMU0pPdEtKTkZqSCtJZWt5L0RaTk1zS0kw?=
 =?utf-8?B?alVZQSs0MkpoK3poazVNdURIUE1jZERndXg0Y041UDV3Zi9hN0JYdG9MK2ti?=
 =?utf-8?B?SVhJZElzL3pVTU5LM3h1MjJOWWg4MjkzczZjekJtRHpCY0s2aGxhMHFqWWor?=
 =?utf-8?B?d2RJMVRmb1kxTkoyT1h1U3I5MHpNU2dlQ0JRRzA5ZVlGTXBLd2NhSHdjdXBX?=
 =?utf-8?B?S2RkZGlVblU2WFl2Q0RnaWR2Z3dZY3FHRlVlRksxeHFlcFZZaGVqREhGZzZM?=
 =?utf-8?B?N2xMUkk5YkhDbXZmVk5iQ0NJOFlaTXoyekRuV291cHU5Z0lkcjRWb1E0T0NZ?=
 =?utf-8?B?bGRkcUFaK3pqRVgzMDNNVmlXTHlUZVFXdVdqVFRzK1MxUXB3K2swNWhDajRJ?=
 =?utf-8?B?dzBOWnB5Q281VUpYbC8rd1ZTZ2RqeW1lcTFkNE9jZUtHbzg0TFhGVzVYQzJJ?=
 =?utf-8?B?UTlaZ2Y2R0t0SG83TUszZlUwdnY4QXc0cE1leDFTREFUMys1MXFmVm44MU93?=
 =?utf-8?B?YnVMQWovUTdsbHpmVEhjRW8zOWpVNmZRTURPWWFpN2hGZmJ5VXhZeWxYSlEx?=
 =?utf-8?B?YTJSbnFuZTZHalZvSGRQNS96d2hwdmZ1em82NXJVMnFTM25SM0F1RjF4ekxG?=
 =?utf-8?B?bHpLRzduZm93WmhrdGtsU3F3bkVjK3N0VmV4enV5TXB2ZTVCQVM2c1hHaW45?=
 =?utf-8?B?VzZjcUJnOE02eHVHeXY5TE1TLzFHSm00VTYyUGE2WDhyMWhLREMyeXhJaTYz?=
 =?utf-8?B?ekdrSEJqbTJjbUdDUDl0dFpQSEcwQkFkR0pOelByQWZXNW9DNnptUzBMRDZY?=
 =?utf-8?B?dWZyZmNrd3poK2FrbjlHYkVGb0FtbWN5anFKalh2K1pRaTNDSmV2bHVGL2Yw?=
 =?utf-8?B?TnBpalJBa1AzK29PVEZiaUpIUEU0eTBXd2RvdHE4MDBPbE9wREw3WWljSnlB?=
 =?utf-8?B?Z09HZkFEc1FPQURYbEVEUS9TV1g2TUttMkN3aEJjK3MreXhHM2NlUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03308aaf-a951-4660-828e-08df1e68a2c8
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 20:31:26.8494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjQkwYflsfaAiCiASwcz10796RMdE4WW9WE3CXd6A5UtVRpco9IfUa430KSdM2QAFWp/CljN0deuUoJenJ343w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
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

On 9/28/26 6:48 AM, Danilo Krummrich wrote:
> On Mon Sep 28, 2026 at 2:23 AM CEST, Alexandre Courbot wrote:
>>> +        dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
>>
>> Don't you want to put this in the `_:` block below, so it printed at the
>> actual initialization time instead of the time the initializer is created?
> 
> No, because the :_ block below will become the PCI device enable guard soon. We
> could put it in a separate :_ block, but that seemed odd to me.
> 
> In any case, we probably should drop this dev_dbg!() entirely, as its value is
> quite limited.

I missed this comment until just now, when I went to test with the final
merged patch, and the "Probe..." debug print for each GPU was missing.

I really would like this restored. This is a high value thing to
print, because it acts as kind of a bookend, showing the beginning of
trying to boot up.

In fact, we even have some local scripts that look for it (not that
that matters, but just to indicate how we think about its usefulness).

I can post a trivial patch to restore it, if desired.

thanks,
-- 
John Hubbard

