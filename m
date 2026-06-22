Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B60CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:25:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E6A10E0A5;
	Mon, 22 Jun 2026 07:25:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="HRB4CQHy";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011025.outbound.protection.outlook.com [52.101.57.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19EB410E0A5;
 Mon, 22 Jun 2026 07:25:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htVD+tGACmh2KOELYvVc5MbeLxN6/9LGnZqV57yCi9iPrHxbInxcrbpRkqRuV8NRqP9SNEpxYYgG8pVcYsEH16vdk1cPPly11rVUNUAdle/oeKuq+PrCVWFGq2QixbkH0nfs+4IrSJxPvOqQv74D//jwpWzDJr6oscLUWtG622ctlOsLsXeGN/vaqTx5/mUDKr/CDiN79kum+ZoOi/hNLLV7RUcBZjvUQ97NFKPiNlhN0LPlNCh47Xw1BM/bQBIwsdiPpbkJb7/EC0qXErHkIIpT6MJyHmv3iaUStQ1n+YSOenkCpjIhI9awi95fyFv8qbPUpFwiJePDD6GBE87MkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/Be8xu5sYxY2Mio9V2kY96W1qovvNVnFA/9dK7noL0=;
 b=vvpmfdqknmXdBRYFLPfglRstjAE9yKBulk8m0UTX7KNyFAYPdAhG0uvEeteBPDtq5df+WfVAufXUchOHy4A8tA2r1VMZfnO3HmGvIkNThGeQHZTikz6FieXKwURgQuuJU1iO8u8Uhw8rAzVSj96HD949mvN1XAL2mRIZpM0lATu2btlm8K05lLHjsgMmHVpUv4mPsdtpsY0m31N4QstDiGMsMoTOUKrbMTSTXtP+GPO1jU7rqdhox3cN+PNbenLCJSyoVTSWnT2WzHbYICIzkywmHggqJ+FxBHVaKCAQFNtsoLXIjLQ+9mZzqifeikVDLacidCy1WGMMlNBNTn1RuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/Be8xu5sYxY2Mio9V2kY96W1qovvNVnFA/9dK7noL0=;
 b=HRB4CQHyxD6TqqDSNSnm5ap/JDxzpFT741P4FD4o16+QT+GBu39bFZ+meZWlU/YXpUDpeP6RrAnRqZW+tlkFgRihzyR1XC8qdfmuuLTPiXgw+YfjcJQjX7FVT6ExNVP1vIQLQLmGDrCNo6kjwRn9fTYjZEzs6F6iRBOIdUzcgq3KQQbmSfjJpaEBePGI05CM63ZgfvcLGB50NUd7Xadm8+SbcgUNAloz2D823xpgz3PHf+fXtAlN+Nc+Pd8JRclYoGYXKtLpuK2ViPImWk2QWKPVvMlb82Eqw6tCwaIZMdVZ+j/dJJjAaxaGk5NSdqQE5enwRFDXCXfFHEJTwrNNfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 07:25:00 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 07:24:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 16:24:55 +0900
Message-Id: <DJFEDA2Y9AKH.2OB41MD0OREKU@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 3/3] gpu: nova-core: gsp: Extract and display usable
 FB regions from GSP
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260617-boot-vram-v3-0-20b9ec5fe9f2@nvidia.com>
 <20260617-boot-vram-v3-3-20b9ec5fe9f2@nvidia.com>
In-Reply-To: <20260617-boot-vram-v3-3-20b9ec5fe9f2@nvidia.com>
X-ClientProxiedBy: TYCP286CA0264.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::15) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MN2PR12MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: 824cceac-6cb2-4baa-5a71-08ded02f5e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|10070799003|376014|7416014|18002099003|22082099003|11063799006|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: CQyNwifBniSVOGq3KZJfoxnRPGSwQOKmEfJ2CpC9m7yXXkb/C/Nqpn3rZWM63yVvjRt2cYqkREmLnHL1jEVFFgNTPhMV091w3Ou7IVVaXyzYj6nRUADY9a9BgPvpOty3X/HDuao4IxJTjJkr/UVAjLPgLbQH3+ORKBsYBO3fwKT8qhsL3p+vZytdBarGOJUkahwwCFCF0RqTEgtShTblO49woZB9dpTeEwSOUOga0/zh5na7rPudWBXgbaXERphp+qiJY8HIUItWTywdhWtU/G9X2b5uXpPB97I1WkXU1hSgLQ6rdRlrW6RfxYJaZ8clY4947/PSnAiNkArp5k/b0jNUeWtFLpQ6R8c+OdmyGkQJj/Qn8gXrZVXDXxlTjNGBIiaUYAtq1Bgtmij8QBurXXd11NTVU8Uis2cS0XsjiV1ypQ681KsU4jdfOPvDFXm5hs4a9gS1EzBEaNSFRPqS3p12Ots/aXpfKF5e2W+2yYRb5GWBolHGwffJu3eNLniz7Q9P7bhB9oR8xhf+0rGtolWOQsFUk3/QgNkcG52uhffkS7nfGupZ5GjNM/PZLBVAxl9kE4Pb51wlg4ZSHzYb+ctdOEfq7rLxUkOXjK4wz4SHAVmrw4gJZ5S5awUJ/I37cUwhSTogHUnHkikdfyEzO9Az/CJ3Cc3wD/xL9UNpr/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(7416014)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ymk4d0VqRzMxYXBxTEJmTEg5WGlrZkp0NVVrUW5BK0VuMk44ejhjT3BrMi9D?=
 =?utf-8?B?cjMrdmt4VUFFM1o2eWpsUlFEYTByb0JOY0Q4SE1yTlhEOE9rQzJLaTkvcUNM?=
 =?utf-8?B?UFdMOUQwbVJuL1hGRGNkSlhrNk9YeEZwWWtUdWNKdkVVM2V2SlhoZDRRaWFp?=
 =?utf-8?B?RXpma1VMRU83SHBpLzN5QkZqQXBDWnNnbk14SzdObndEZDQwbnRyZ3dpM0da?=
 =?utf-8?B?S3YrYW5ZZ2orS1RDcGV4QUZNTmIwU1lSeSt6RE5FanJGS2oxcFRIbUpjUHpw?=
 =?utf-8?B?RjFiQ1FaYXlwcERNMXk1d3B1QXZLUXRUL1o2K25yOWlreTVRNVVWUm1hUVJj?=
 =?utf-8?B?WlBENGpjc1k5SlVBUVdpekRzcGhGVW1MZXZyK2hseVJ3UWlNcDBDcUpGYjk2?=
 =?utf-8?B?ckpkYkxPSEtTTWRkdk9NRGhTaHRuQWZkNmVhV3ZMQXJTVHF1MmUxZ1huN2oz?=
 =?utf-8?B?TWtPS0tkN1VHVDVpeHRkQVdiZU1UYk1UWDJSYk5jcnpxNXZvbDhNeXBPUkhP?=
 =?utf-8?B?OG9Falk0eDBPTjl0U0JpclpwUHVXcmFjSW40VnMwa1dRc0hrRUdZSmxONzN0?=
 =?utf-8?B?NUZwSk0wNXpJcHdqSHZodWw0VTQxKy9kaFpWWE4xUDUvV3UxeUoxOXU5VWdm?=
 =?utf-8?B?cmFJN3MxbXNkbmJTdzd5eUJFeXZiaTRQamRtRlA0WkdpNW8vTmhtb1hoV1BX?=
 =?utf-8?B?RmhVb0lvUVJiOTAwUnRQa0NYTFFJLzVvd2NRM2VidFFrYUlBeXRWaFhPWmZw?=
 =?utf-8?B?T1k5VitMd1d2TGhPamdWam02bFhMcmpHSUZ4Y09jd0x6RDdmOU5YdVRwL3Q5?=
 =?utf-8?B?ZjNMSTBvQytJOGJ5c2dFemNMZ2t4MjdERkRCVWdaUGNzWnlnUjluaG1ERkNK?=
 =?utf-8?B?dmIxbmpQTkUrQWQ4dDR1c3IvRDVTSW5UWjE2NGw1Wmg4anRIdlJuUVFOcEcy?=
 =?utf-8?B?ZmpuTmtDdnJpb2xwck9uNG1YQXNmUjBibkNHYm9XUzVzaHN0bm9TMWZxZFpI?=
 =?utf-8?B?T3gvdENQaFJzOFZPemQrOVBsSzBZNkRxSFpnblovM0Vvc244dUMyT0NSWk1n?=
 =?utf-8?B?TFY3NXRyU3R0NmpyWFc0ODNsZlVQRmNKbWR5bm5rSWZnNmRVQmtZS3VuNmtR?=
 =?utf-8?B?V1liTklOV1NsYXZodmlRaTJadXdnVjlveDhOVFdqM0UyWEtkUW1JTEFsR3lD?=
 =?utf-8?B?RW81NnJLalg0OFZiVnAzUWIvVWtXYXdBTE9NNlgyUlJ3TGVPMWlLY3g5SEI5?=
 =?utf-8?B?S3REOUtXcXRFU0dicEdZcW9sOEJTSFdDYVMxZzFxVEpMZk55bTl2TXRsTkxS?=
 =?utf-8?B?a3d0cXNFZVVkUXBKSnQrdHdHckJzZldmQVdDVkRoZGExRkE4WDM2TWNFdlJK?=
 =?utf-8?B?SmdQQm9UWk1RbGErck95czhHUjZjb3JiQlhkQ3pmOTVLWFRKYTJCdkFTK1Bu?=
 =?utf-8?B?L2FoYnFBYlJNNkVObHJYVEh6d0JpUWVIbDh1ZXprbFYvOEFESVlrQUt6dDVN?=
 =?utf-8?B?U3YySFgwZWhDTkoxcFZIQzBEaHFPYlZ0RmxQY2RMNFhUdnVaQTc4UnlCZkFn?=
 =?utf-8?B?NkdaVDl6c2piMXZKK1RxUThJeDdKdlNKZlNwb2k3c3hrUFVocUdYWFZITWpw?=
 =?utf-8?B?QmN1SXB0T0VMQ2FCY2ZyRkwzWkM4bFh1RkJBRHRhLzVSNUx4L0hnZnlhSlA0?=
 =?utf-8?B?N0xjWkgxNmdJOXB0dFNFanNBV1ZjN1VHSURMc3M1YzJXc1d4ZDNGeDJ3b2li?=
 =?utf-8?B?R0Q0S295azUyUVR1dm0wbUVLZVdmT1RkR3FDb0pvbS9VWU9xTm9BY2JPSk9F?=
 =?utf-8?B?WkVmRFBabjdDWVMrWnZrOUZCOFVmUG9qdU84OWFiTnMza3NPM0pBdy91bHZD?=
 =?utf-8?B?ZEpOWmFpdlBML0RFSWFBek9CclZ0UVNiVFA4Q2IxNHJNV2dhQzl6cXB1NG5p?=
 =?utf-8?B?MFdNd3pSOHBaUUhrbUJaZVBPQm9QQVEvamthR29OSHVEOFJBU2hHdG1ldFVk?=
 =?utf-8?B?NEQ2VjV0SHdRSTJKSDlKU0N4ZXNvVkhUMDBwOWtmbmVLZ0xaS0I4V0ZMYkx1?=
 =?utf-8?B?TVMrdFZxck95WUVTODlHN3ZUUzV0bXNIM2lBYWhoM1RBdCtYZ2lzamFmbDhi?=
 =?utf-8?B?YVBybVZ3MEZNZm5LdzVuemhIRWpURFN1WXRuVXl5WTNlTkpLMHJlS0hHMWJC?=
 =?utf-8?B?d0RwcjNBeGZsRENUVEo5NERXZUYrS2I2ZkgyWi9aOUwxdmRhS2h4MjdnWWZY?=
 =?utf-8?B?bmloVUVNTjIwaWJTcWR6VzJNamdsZGFvekY5SGNSZ2ZIOVhKVVErVjBnVXUx?=
 =?utf-8?B?TWd2dUhuNWdhbFpveURNVXM3ajZQbEZIN1JJaHM0UmR6L0MySkZ4ZEIyVlcr?=
 =?utf-8?Q?dxdxBB2uyz4pkxpnfVlEfwHsch9HzHWpOfinVT+j15c22?=
X-MS-Exchange-AntiSpam-MessageData-1: iY7Cb3h4ps6Iew==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824cceac-6cb2-4baa-5a71-08ded02f5e19
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:24:59.5251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEq5gE+xhY09Lq8k6UHLUFn6CgRyQvmJYHlSyXcI5/GDTBk+E7hLB8XoEFcv+b5NNcIkg6enW34A4g9WwZb3+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
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
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

