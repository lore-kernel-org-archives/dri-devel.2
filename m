Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14264CD98F0
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 06:18:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7526F10E960;
	Tue, 23 Jun 2026 06:18:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="j+kqCol/";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4833910E960
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 06:18:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaP0bVD6aVtSnEAHtAFKNvkZoAMDIBrZbAVQ6PSLHWpxesFtLQxMXDK7x4u+9UUBqFK63NnYqsDSwhaVd/F/CQZVn91m/NTLgBhq7yvtzZXGw1iNao96Qqe4wd03kqW8L1RBYmXD7X+yTjadACJ0ThhrjoQ2u9qi19QqgoKNGTIA90KRec45sjWrdvNgJMmh1bhJmt4GtjvC4aMCsWSPgFnnsWr3m7ss4/w7Dv8syn2ZuZpy7lTJRD49W/qyzcxuU7BZPlQevAYynHJpvi78resDjZRuHv3efVLOmqGoIPmAfN2dL8YoFsvQMG4v8oas5giDDewxXMSE2p1dFv5LlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dT+0HGhlJA52XnzM3rfTY/h+W+uXtKe7YvVWHuIRoWk=;
 b=Dv4n+ehOiMvu3DsiSYe9NZK5YG788hB5uevb/ow3GLOtsFt9wNLPe2HT0XCu4fNiI3o+1Cq8UeOARYdmTZCcT3/r1wZ5U4pumotSLF6X57DAONBOOuqF0KdFNlNbmILqZa4ZjxWqqpBYTfAu8Xa4h7IroUxzmJmGSwUXE0jxNqvOXF9PaaiMsLEdh8jMt7437Sm/1rHvPW3bOfuGXETVySmW+NCgeQQ5tM9IMyZJL4M3PIrTy/iUxrye2/ZXXhJ8FeWxGOWQ+PsTRohV3SJVJNF5K492e2hhNIIpQBFnFXu9xuhdplSRfoYL6fRiBglNbDgr5s8bPLHLvSD10d75IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dT+0HGhlJA52XnzM3rfTY/h+W+uXtKe7YvVWHuIRoWk=;
 b=j+kqCol/8lE0jrQsg8t5aCnf7NvxB6Fui1qB4L5EQBzh8g8j8m/cT3tEOy+mfTz5DS+/uEmiNInkt11aB7HbNFVBYMeZyTqbjl7Af72MrPIKhgFVHK5G5zWfaqLDYuuWCQLDiMtLkSedJAgStRFKEdLN5JFwqGiIeEMcTfy7diph6Fs3/tuu/EQzGwi+Bh2729Xf2RGiwDeq9JgiRT6fN2yQDh8T59EFz788cMtJrptOt7OVUxXH7uBDg+ieT0Zf8XUimdUTNgNdC6kPHpALOOe/iVpQNIkeRBjEN4o0j+9JlO+/N2LmSSl35wNXlZ08xxxU+EFbhe39ZOShMSh1Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS2PR12MB9662.namprd12.prod.outlook.com (2603:10b6:8:27d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Tue, 23 Jun
 2026 06:17:55 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 06:17:55 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 15:17:51 +0900
Message-Id: <DJG7KGQDLDC5.25PSL1WZ7P9VK@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>
Subject: Re: [PATCH v3 3/3] gpu: nova-core: gsp: Extract and display usable
 FB regions from GSP
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260617-boot-vram-v3-0-20b9ec5fe9f2@nvidia.com>
 <20260617-boot-vram-v3-3-20b9ec5fe9f2@nvidia.com>
In-Reply-To: <20260617-boot-vram-v3-3-20b9ec5fe9f2@nvidia.com>
X-ClientProxiedBy: OS3P286CA0105.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a4::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS2PR12MB9662:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d03fae5-5826-4954-6316-08ded0ef29a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|10070799003|23010399003|1800799024|22082099003|18002099003|4143699003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: UvFXkhDzV8qN0DOUTG/qZP27P+TvqKiOlQKaskjrOEQ2exm1Xsdu38NwwstBPKtVGjRh/1PFZgF75aPTRnvJE+2vHXuzQfhG4eQOUEaudhmCKgxSFFH9ZWLFcOgtA8OAo4qb0HzRZRGt2aXdHuVGFbTjjwkKjlWIAtDlU38/rrLNAV7ohHtrS7G5JUFfpP914ZRJTqGWb7Ua0dJvjqrJeXxzb0C8/3AadpV8hhWEbSR0k+2FeGj0dORw6+Yhl/K5csUAZrxfiHslfyUBnUhSBU8rji0MKum+C26kLaC1nmkh1E47H3kmxns/ZQWvfEFfw5PG/1viS/0QNaaDr0xmd7pyZnwDGAEpM//REof6J3lnclq/Gd8+qM1Aq8jURyiCA8auuYVFA0MG+JlZoHmWMm8QRbPleoNo5LlzfhUQz5xVrc9GISPcsUCGm3/OKpUe9kDiGGsZVPvNb1qHj1qC6cYJc8RupxTfFYJIErTxxGMhFEMwh8foquYFRaGoj1HvDtUF4L/AuTv3SAklcr8UqDTvNujQlhkDpL5lOOTCS7KJot87qWEyyHpXx+DKis9sxigtcRmNWyq7J0i/CYQLSwi7L5DN7mj5VL0Ze1NgkPkUlFH7F7ZIxsIjClRyyj18Zy6qBOs6mKKWIWyTzKUnGKXbbI/lavbsUoY1fwCO99M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(10070799003)(23010399003)(1800799024)(22082099003)(18002099003)(4143699003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yi9Ga1VkMmdDRHp3TTF0eW5Kbm5KM3pxYlBxbUZsaUZlL0NzaTdvaFdqTUFZ?=
 =?utf-8?B?dkdOOFdUc3QrakE2K2NYbVA1KzhSQ1NwOHArMHFUQXZaQUVUWHQ3eUkxRU5p?=
 =?utf-8?B?dmZTQnUyMk9OQ3ZZS3ZldWJUU0p2VEpOUzdnMU5GczQ3amQwQjNXdVhyT2hX?=
 =?utf-8?B?eEdjNnZ0SENmamxNZnI3Mmoxc1ZXYmVTeUU2Y2ExblY3YlFFOWxlcTRId1Vy?=
 =?utf-8?B?d0tublk1OFAxMHMxVjcwaXA2Mjd4Zml2L0dINmw0SUtiSFBQQUlrSE1wN3JT?=
 =?utf-8?B?QWU0eEw4NWtsVi9XMEtQWFgreFY0VXVod2RaVUhGWWJPei8xZGZ3L0NzbnlL?=
 =?utf-8?B?RzlDWE90UDhTWjkreFdQV05QeU9KR1E4WGtLR0VTTU51SjZlNTRBTVFHeEt2?=
 =?utf-8?B?bUNqQnZOdnhrS203ajhQTm5hMzI5MzgrWmp6aVlQMk0wb3MzZzRadHRpSktl?=
 =?utf-8?B?bDVpK2dqbjlHSHVtMXlUTGdPVEwwM2J4eERpZ3VZNUFrYjVtTk9jRVVZZE1P?=
 =?utf-8?B?Tks3bStFNkNyMGxjTm1ORGlzL3FncTRqQytpMGNtQi9VQy9vbklQQ1lvOEdu?=
 =?utf-8?B?VW8xMyttaEM2MUNHRkJMS0drU2U4RTd5enpzV0poSHFzL2loWmM1c1JlNUgw?=
 =?utf-8?B?ckRFOG1taG00Q1JoWHRpeXByd2szcHE3dDJ5OFJIZjhhR1NodUt3MzR2OGhY?=
 =?utf-8?B?aUZXb0lVdFRQSDYrRlVlK3oveWVEa0YwZjVzOERTVDdRQXFkb0IwQldLRS9x?=
 =?utf-8?B?UzN5UjFOT1FLTytyYk9rRVdSZVdTQlZSYS9YdmlJK3kyTFR4a3UvYmF6amVk?=
 =?utf-8?B?MEdiK2t3c0R1dHJWN3RyMTVIRWpyQlVFN05hS01HWG9aaGNpa0NoZEtzQWpP?=
 =?utf-8?B?WnpQZElsYlRIaUhxZExkcldJcElzWkhVcVFzWE9Lb3ZsMkdKODRheTlVUXda?=
 =?utf-8?B?bkZLNFArU0FOQm9jamJncUszRlQ0VDJwOVpwTkx5S0NueE9aUUhDVkZjL25w?=
 =?utf-8?B?Skk3VmdUOHBwYTVUQzA0TWd4S1pVMXROMGF1a0RJWXFGbTArMGVSSzIyQ3E3?=
 =?utf-8?B?SE95ekE1Mk5mZ3ZtMnhDQTdlZXRpM1BXSWptUDNIL1pQY2l4UmhZWUk4Wkdn?=
 =?utf-8?B?WjVOQmE2ZXRCZzkvV2JCRVZnUHJkVnplYzI1cnA2YlBybVV5OS81NlJhaklz?=
 =?utf-8?B?aFZPbm4wQ2pFNzdrNGRYeXJSeUhPK0NvcStEOFh6dVdPcm1WeS9vNzB1V0Ju?=
 =?utf-8?B?SzN4T3BoYWpXeE93VjZhRkxpUWE5d1dVbG90clVHY1dscDBpMUxyN0VMZFBV?=
 =?utf-8?B?OURyYUtUeTE4cjV3OFVHNUNvSmpNd1lodFAzQlExMkJHbUN1SWRucjIyY1R3?=
 =?utf-8?B?TU9lUFhEUHFVZTkrVzlTVGUrMXprR0t5UGRRRUZwdmg5Uys4TW5QRG5pZEo1?=
 =?utf-8?B?ODhrejNyOUV5MDFOV2pTV1BTWEdsYk1CM0ZVY0paS1RjZ2pIbWppTWFqNFlm?=
 =?utf-8?B?cTNlM1duNGorMFlhN1JnVENvRHg2Z085VHN5WGhxb2dUTFdRa01oNWpxUUU2?=
 =?utf-8?B?VTVSMXBvMzc5dW1MSWViNDF5U09nd1BWVlZLWmFhQTB0aVY2bEhSNm91cndV?=
 =?utf-8?B?SHorOFdtR2JqWmgzb2VXVXYvWEV0ZCtra3JCUFR6T3RRcFZzcUtYZ3p4ZXRW?=
 =?utf-8?B?V0xYb1RGVFZUVkJhSW5oQU8vNG1iVlRVbVJoalQzS2l2bmhDZ0tORldOcUF0?=
 =?utf-8?B?VTFxUXFDOEpyR3lBelZsM1RrVnZqVHIxQk93QUJXblhWRGZ5VFRGbXVrNGVt?=
 =?utf-8?B?bUpObEFGNVF6UGtyZ0dOTmpCckVZekFOZEFmMGVoNGJSbXJSTkF0YktuRHJ2?=
 =?utf-8?B?NUtGR1M1L2I3dmhSWlJwc2ZYTFppQ1Y2NVN6TEZFSnV4YTk4ei83SzNiS0Ny?=
 =?utf-8?B?OURRRmgxdmJtV1FualdOc3VsZitMK2Y4cnI4T1g5VXlCbnVWc1VNVkpNZWNB?=
 =?utf-8?B?NXlHc0g4dzN6dmZxRE5qcGhCTm81YU1IamplWlBWR0tCZEF6TG5HR0tQRXpR?=
 =?utf-8?B?S1d5enVkU0lkMktyUnlHamNwaEYxSmFaTVJjdDYrVmZNR1VidzZzTXU2VVpX?=
 =?utf-8?B?VExUNGVrRTduV01GeVlMN3dpSUVSUDMwSzEyTTlNckFyT01pTktjcTJUQXJZ?=
 =?utf-8?B?T2hQNHZKd0lvb0t5ZGhFdGI5UjZEdUJtWFdkMjlWUmgvdHBEWnpVTW01NmZ1?=
 =?utf-8?B?OHgwQkZDZkpaWGxibXhoWjQraGF5SmY0QnpZZkUwMThEc1RwSHliU2lTSmpm?=
 =?utf-8?B?ajB1U0thVVBiMUtvaGtjQ3IvV0FZYzNFQWdwa1FEYit4dnk0bFJhclZvSGkr?=
 =?utf-8?Q?x7uKRKblPMyFyJAkQ3Kz30NgY5AwARgtS41qMDrZvaCWT?=
X-MS-Exchange-AntiSpam-MessageData-1: 2Bxqemyu1AvCQQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d03fae5-5826-4954-6316-08ded0ef29a6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 06:17:54.9533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qw6Feyp+CRF0kBpMTnKdoXEeLPN7PI4VfhKKmvgejOBhZ+1j1yEOJw5h6xpexW8lOibSf/Ki89ljT7MssBU8jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9662
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

On Wed Jun 17, 2026 at 10:24 PM JST, Alexandre Courbot wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
>
> Add usable_fb_regions() to GspStaticConfigInfo to extract the usable FB
> regions from GSP's fbRegionInfoParams. Usable regions are those that are
> not reserved or protected.
>
> The extracted regions are stored in GetGspStaticInfoReply and exposed
> for use by the memory subsystem.
>
> Display the regions and their total size upon device probe.
>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> [acourbot: expose all regions as a KVec, display usable regions and
> total usable VRAM.]
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Pushed to drm-rust-next, thanks for the reviews!

    [acourbot: replace dev_info!() with dev_dbg!().]
