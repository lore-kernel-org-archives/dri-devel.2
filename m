Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE16B106ACE1
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 19:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68AB010EA9A;
	Thu, 12 Mar 2026 19:22:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ay7iW9P2";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010053.outbound.protection.outlook.com
 [40.93.198.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D0D910EA9A;
 Thu, 12 Mar 2026 19:22:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8kyB6wvTH5F7znIYH0zssLWqKYPYJlBKi4bYk1Lkr3wKf2nR1/Gh0XRtpSFZSu9T0IRVs3dO7rG6M+LIiq4ZrB9wAzVwrmORGlnIHX0SkYbPTrM7mQ50Lqr3V0vLkpbKWy+GLSgxKFDHBwOgKAQ/er1+VGjgO4p++oQhHLjUAVUebfZescpBuA5pDLsrakl3AwC9gn0UWtrLo/C0FqcRbN4lICd0hLvH5yF3yr5I7oAaEiCawH2GDkWgDcsj1OU98XyAaNizLoKjCm3p9UYQAY7SwjZFTksyuxeogqWaMwNZR++MZR3fvSvd/x9xolzhDVlj5NXHHn07IqZV0axdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q19z4jsfOiECJe2fOImT/PzGg4BE2iGFeEEpzixCFKQ=;
 b=fFtYapJ8gS+/btvwy9i/xuEYd+cDTYWh5kHHOgUgffdiUzyIdXkDytmKk4SZyTF5dRxXiNzTgWqlF1UyzrjA/AHyR6OeUtoEd4MPfH80BZGU9Kc2Voug/YKETKBp7YNnuX3V39XVx8WrM+cmZnzTEx4l6pJwVyQrScTiqp/ExRlin5CtMYWYPYsRan3/GCF/ryZojrZVkqcBRc33YZ8SCEs+zBarnVG+8Szv6lGuLQWsmLmrBiCbVOPCUkkpfqjpJucOAk79Ec404ui1/hbM4ZhS42hShe3CbgasENU6IDWQH+QjdIbOmWwDZS4GewHbEPGfKeMMzDM5FjB/qPwuhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q19z4jsfOiECJe2fOImT/PzGg4BE2iGFeEEpzixCFKQ=;
 b=ay7iW9P2hZq9MjRcmCsc0JfILWIiQ6vg2GQQ4zmZilVV0UHw3ZLosz0PUuVekC9fC+PKUwKAwzE9jKcl/ZiatAgzUAjAYFXF+R8sQm6sikgM8qRxyQx51sb+1m0YRlWcrkHn7NWeOYPQj25zriKFnPKFpU/mWoMJHPIKY4vflDoa2bjzEBVKdkHo/TtbSUvUE/p1CS2Smwc7FBCePXJp5ipTKcw1RBbhoTdKlHnzctDSINMssKtng+nKw/QmcnBTIM29I1aZMuj+09N0cPWi6fWgvdsIihwwYlxZzmgTZ3tG2ntn2xOpbNd7M2PRqEBKLx25cSYd7wPmOz7+EVDV5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 DM4PR12MB5962.namprd12.prod.outlook.com (2603:10b6:8:69::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.6; Thu, 12 Mar 2026 19:21:55 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%7]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 19:21:55 +0000
Message-ID: <f1398086-ff75-42c8-ad43-97077dd22267@nvidia.com>
Date: Thu, 12 Mar 2026 12:21:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: nova: rename drivers to use kebab-case convention
To: Danilo Krummrich <dakr@kernel.org>,
 Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Alexandre Courbot
 <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Gary Guo <gary@garyguo.net>,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw
References: <20260310062443.2763230-1-yphbchou0911@gmail.com>
 <99af9d88-05a0-4dcd-85f4-9d5fe9ee6744@nvidia.com>
 <abMJsUpvcUrITCVi@eric-acer> <DH11MBCZFQIJ.33U3GFVI1HFZF@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DH11MBCZFQIJ.33U3GFVI1HFZF@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0003.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::16) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|DM4PR12MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: b846ac9b-59bb-4aae-f137-08de806c9f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|10070799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: mr5Pk4DD1Rws3iNaP66q3tBpRIUxubU0FrEk6rwv5JjHNRqXRlf3ef6w5W6DgxmT732++IZ9wk96iohHPBAmmmNB1/bnQgweQ+KhGoAlgRrqbdRSPc1CxcYgsMQZT77IVmg7jcke11smhQhF1Lt078g6mdPlj3C+Z3KoBEtoWRUIzZsCwtpCHyO4uILrj8H5NDsQazzr7N4qt9IefRyOfFrAAxIv8s/jSqkJTYbdhqJ50zS22IGJg3mtm6cGsz9y2boXM6P4vVl6zBv9g00Crgy0d8wFoeFDnZ6wMVSaxkEQenmZVDi7bBChiWEWf44ViueGHLfrEme9ZzUYRTAkg1QirlbZNcb8fz+WbpxOlUe5L35GG65ubC8KujNVWTpzCzUNJfMc4uG63DGfz91Zxd9xYngyC8nVDbDT459AJIWE5SITca2b3YZfqkQlSER09idJvpCYTSxIux29yZv9pPXgQ6tKaNgyD26mZdFVulnFg7IbP6DCUsmGh41bVaCuN011LmCoB4ooBclGm0EprHSxaUW/2cT9gz7pCfhRRv7/FBlxcvMCurIvP9WFNROlYhFlO/52nYFb5u8KtQhG2NXKdDmibmrZHqEiITy/v8BkE3bS7oflH+i5qN3GXB9cto98x0Cst1YADe1bNml10PRZ1d2uhV1jOW871PQAqYJxaYbentRADs8MAaAqdixBYc/ZIHnwuKpEMp++lJHf6/NBw8AEH65ckJSlt9myW78=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFVnSG5MYjBISk9zbzVKUXJKaGkvNC8wMDlMSEFwM3dPUEtCcDNxUmJzclhy?=
 =?utf-8?B?bENQYkhMb3JhR20vM1F0Z1ROMnk2UjJWR0VveUp4bUVCRDhBaDU3S0ppSlcx?=
 =?utf-8?B?VjBMVGRrY1ErUFIzb0R2TXljL1V0V21iNlpPSXNmU2NhOEJlMndpUjdiTWZH?=
 =?utf-8?B?MVN0TWwvaUk1TURvZzM4b3pLTmE2V0VhS0lYN3RaK3hhajNFelpia012OEE4?=
 =?utf-8?B?U1NITVg4MDJvR1lOSjZyb2E5d0w0Y1pyRDZwWHBlWTROUTEzNFF5L2NFcy9R?=
 =?utf-8?B?ajMrNHd2SU1QeXhXUE9SMGM5bFBaOExEdldKb2JPNVpIRFM4UVFKeG00S0RE?=
 =?utf-8?B?R3NlYU5JY080dUJUNFY1dTdldzZ2eTIxQ0ErYXhyRmMva24wVFMwYzZkblFp?=
 =?utf-8?B?QzF3KzRrOFRGQm9uWkhCRW5URTJHS0lKYmE5eEhBWmhUYXRPOGVDaWFkeFVR?=
 =?utf-8?B?YWlsWE4zZEpMcDNDUnhkK1JvRldhQWZIWXd4R0p3NkNveUtkZTZFYVJ0eDQ3?=
 =?utf-8?B?VkgvQllQYkJpcGEwTGRuWlpnQXpKRnpROGxuWjNqS1NKSTZ2YkhpeUlDc1pB?=
 =?utf-8?B?L1ZIY3htZUt1UUY3Z0xnaEkycG93c255S0F4cXBhd0dzN3dtMFk1Y0JpbEdE?=
 =?utf-8?B?NnptWURhdWdBU25PSGthZTA0NGtnQkN4SFZzR2lwWXdGSTdzTVVxLzJxVUZY?=
 =?utf-8?B?eVExSmVYOXRycE13ZnJzS0FpNGZHT0MwOWY0RTR4c2ZsVnIvbkNWVnA5VmFz?=
 =?utf-8?B?M3k0c21nbm1Yb1ptYjAzc1J2d2FmczllRGNybUNpQURlRnFraUNlSXFqZ0ZB?=
 =?utf-8?B?UHRvdTc2ZzRIMFF1NUNyYXpiTFBiR0pnUXRxUGRlMU96Z2RvSFEyNkhJVTBa?=
 =?utf-8?B?dzdQSFVDSTBJUlFscWNHTTdFYWdDVTdxRmtzbmZ3US80eG1kVkhvUmdBK3dL?=
 =?utf-8?B?QmlCQzc1L3NrdXIxZVl6NGkrdEtIMnVCSW5MYi9OaGt2ck1PTmRSOUlXTFRu?=
 =?utf-8?B?ZDVBMVpkNS9ROHNRUzF5YmpUYjNGTUozOFJZdjA2dWNBS1hzMUhhWlB2YUR5?=
 =?utf-8?B?aktMTmZ1UGhhRWlSTGFVQ2V3UVErbW1idmo4YlBFaWdEalpHUjJINWVJTFph?=
 =?utf-8?B?QWNTaENZOUhTMG1oRGxoRWxKc3pQWGw5RC9lanFiMHJPNk9GOW8rd2M1MmlW?=
 =?utf-8?B?bHNId01EeUtrUlo0VVo2K3ZyRE0va3VNRERBeFE2STV6S2JyRlROV1Myamt6?=
 =?utf-8?B?WG13VGRVVFBvT25GMXlUVzFHdnR1VnZ5OUpzTnF3aURqMURMeVgwY1pjbDdQ?=
 =?utf-8?B?Ni9Ub2R0aWNpMk5CL0duV1Vqc2JtK2QzcTFkSXl5SkJZS2tTUVRzcnFwNmox?=
 =?utf-8?B?aWJscnVKUFFWcEdpTHBLZktGRFB6T1NGMzBBY1U5ZGZ4aFJDV1pkRmU4SFRM?=
 =?utf-8?B?TlZjMnJEVXc2LzlENmx2d1hXSW0vS0hJaEdlaW9udGJqMEF3UjYrczdLUnZY?=
 =?utf-8?B?Y3JWSHZpeXJ6RFlDQ1NSNGVKVEdnWjFreWVIY090K3dYYTA1YUx0SkZCZXcy?=
 =?utf-8?B?bkU4SHBYQW9zWjl4Yzk0REF5VEhPKzlmVVFPRDdzbGlKdHl6QjgxN2ltZXUw?=
 =?utf-8?B?NzJwY21XajY2RnV5SXliOVJIUmFodVBEK1dCQ0VyRjAyRWZ1NHdEQk0rMGlL?=
 =?utf-8?B?VEFEd2FuTFVjNlpKdmVVUXg5dmthQlB5c0pWQzJYd3BLSlRnMEZsdCtwRW55?=
 =?utf-8?B?MytsSEFTR2dER3o3MzJvN2wzc0ZPaFJiSWZsVHJNZmNyWU1PcHJ5RjF4a1hL?=
 =?utf-8?B?Vm9VZTZsRktUcEI5WGwyWUhJQUpDMHArcmZxQ1FSdXV1dmd6UHN6WTF0Vytt?=
 =?utf-8?B?elZxbm1UN29PTFc1dFNNWGIvVnZTL2cyU1Q5eHc0VTFDalk4R1ZxREM1Umgy?=
 =?utf-8?B?ZXk3RGE0NmYrL2JQZ2JUNVNSUXRXZDZWVDNSNGVmVTFYSUthWGNLYml6eDNm?=
 =?utf-8?B?VTd0enJLRnRXejJkN1JWNW1IQ0l4QVdkS2syUDVucW1rMXpTQmsxMy9UcExy?=
 =?utf-8?B?SGhpbi81em9YcHlXQm1PQnZ1MnB3elNxZnFmNjZENGJzK0p4Z3VyajZxa2pV?=
 =?utf-8?B?bHFoSXdsV0pvL0ZZYUZjbWV1QkJ6R2MwbzJDRFVhNmR5akxHQ2tsWXBaUXpS?=
 =?utf-8?B?R3RVY0U2S0pOdVhSS3cxdzdZc3krQzBZK01YeEwxWmRsaDBLejIwQ0h4clZ5?=
 =?utf-8?B?cXRaMkNFTG1pUWNwNUQ4TkRWbThoZ3U4UnRMU2Zvd0paYWhmRUtPSFNObUI1?=
 =?utf-8?B?OWJkcUVReU5QaHp0amZueHdjZWYwVXBkdmplbnRRQzRSSTU3MHNwMHB3S0Z2?=
 =?utf-8?Q?HJT/AQBhtNvaJUJo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b846ac9b-59bb-4aae-f137-08de806c9f2d
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 19:21:55.0295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOcf0cnz2GamnpqL3WYCfw/leeb0ztWr83j/wNRxM0h0t2Se5N8GIdSNlTgvw5FVBzscM23NES8rxOMC4XAbfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5962
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

On 3/12/26 12:16 PM, Danilo Krummrich wrote:
> On Thu Mar 12, 2026 at 7:45 PM CET, Cheng-Yang Chou wrote:
...
>> Would that work for you?
> 
> I think the module name should ideally match the directoy name, i.e. we have
> 
> 	drivers/gpu/nova-core/
> 
> with the module name "nova-core" and
> 
> 	drivers/gpu/drm/nova/
> 
> with the module name "nova-drm".

When p

When people do things like lsmod(1), they don't see the directory
path for the module source code, so if the name doesn't include
drm, then no one knows that "nova" implies "nova-drm".

On the other hand, I was OK with just explaining to people that "nova"
is the upper layer kernel module, and that it's the one that does
DRM things.

Which is why I'm merely "OK" with the name change, as opposed to
thinking that it's required.


> 
> The reason why this is not .../nova-drm/ already is that I figured it would be a
> bit redundant given that "drm" is already part of the path.
> 
> While I don't mind changing this, I wonder what this would mean for the
> Kconfig, CONFIG_DRM_NOVA_DRM? :)

I also worry that we might not have enough DRM's in that
CONFIG item. haha :)

thanks,
-- 
John Hubbard

