Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6E2C43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 11:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F334610EF02;
	Wed,  1 Jul 2026 11:30:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="l9vi5fTv";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F55B10EF02
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 11:30:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qw2bWJdr+sdDPBAlbDegv1PVhdOr19r8gy7CD24FSCwlpq6nCNV5m3xQoEIZSkz3H7d8fkan+jwINBrNk4+ZqJPhFjvdTnuLJfy8dYnOeDknAfck0hI25qVbQxJSdnggtUOff4F7ZQ40ujHDVy6aPDvF4XrE/2sOG6TKBBF4eN61J7cRxDfcsOx2EK7DcGFu/q/4hUnlJsF/0RZ2np+kS2c3a5Shf66PX9xazEL2LpE2HLUpUqH1mD17dm+eCFgQL6uiDP7Yc/7oQIe3reJTjErfRz+mug3V+oLrFD/rXHXQ5OpWMHmWGCAAh7uZ+XOOnr2y6pQ3uBudbjBAK22LwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDhpXpZaYYkwrREkGK9im4T258359zqUtwmENoQL6KE=;
 b=wGaExLVCbCl3+u1JQIwHWb2KvN4bqaUrUe3O3i8XghQD9c/jzAuLT+HuVzImn7qKKFPjSnxdO2bTRSQQDzih4YfdjKRpCC7cpTrzE8hN58vFi9c1g+iG7DSY5B+vXa1ywj4N/kRDJcIQU1Z99PF8aONY2jkGNsSelj12ADyN44yl7p8xk+u2TnA3iOesygLBXbqY1C/MADS9eQ6SpGFT0ZN9upQELbs0mwZZgs/HgVqc5Wl+Gge3NSt8stN6XBNj+5HXXeiU2PampuVbnrNkML0AVf3XgLRDXw/+evvoq7V/+Wm0xjEPKzDfUAXxSuIItt0qYBvaJIG7hVtSg+J04w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDhpXpZaYYkwrREkGK9im4T258359zqUtwmENoQL6KE=;
 b=l9vi5fTvEvLXWgAS9nEOaYH5NSCrpXNls99clPtvYEF1uDtDF21SCmmer9fFOWBC0EjbI/+v8TWbm8c6kqp9BtmMTWqfhLR66LPLO7y6vTR1Fs5B8MqPe9WeJ8uON9IJhEHU1WNuXt522nNxz9Ws+xM8SNNH/0WSlIz8vB80h4WvkUtxQn8SqSVjgDp/KdDl/g/slvqzS0xQgwB/VdSI15bRimK6Ca6Z+nkDT1vOMNObagtXfuJmL5ENiwYzWeZ+LN1rP/BUTUM84KMb3vSvopEpI7eGFD/A1dmvjU6bpU/b1noIo5oWyaeKvKe3NG5jjIO+ETN9KLSv3wo3Q5RXaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 11:30:12 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 11:30:12 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 20:30:08 +0900
Message-Id: <DJN77X9ZB03Q.6O1ADS9Y2NXB@nvidia.com>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <ecourtney@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <lyude@redhat.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v5 04/19] rust: drm: Add Driver::ParentDevice associated
 type
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-5-dakr@kernel.org>
In-Reply-To: <20260628145406.2107056-5-dakr@kernel.org>
X-ClientProxiedBy: OS7PR01CA0210.jpnprd01.prod.outlook.com
 (2603:1096:604:24a::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c47fff-eea2-4b4f-1a50-08ded7641d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|7416014|376014|23010399003|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: HK3Xu3t48oMKbi3dIx8eqN10kLSl/T1mi/7BEz7URlxx0BB7UNnvoyDvuwMkgPDkpaJFR1QyyE8XTEm6J0pOST6Y0G4GHQCBtzdcyfkNpiY8+PYDL4uXElZvnvv9c3OX5Emu/7KkvOLl8hdotH4ZsHKHdeJF0/nI2xTExx+8PCndJCVSlY8u0OlpHdlvUDxS6X4gP/zNG/ysUitVHaWGnZBrSYWJeEmDo+ZRRTfiPpBeowhR6I/NhjMeYJ7JopZLTl7wJcZm4YvFX4Tau+Gcfw10yEugp/8/ygqvjwHSw/JL2nNqqUBE5XToXDEPaMea317gM5pulNUCnJtxl50AhQdgAFljPpYfs2zg1zFfMuqPs9C5JikOSNtdOA5uC3235mILdpgxlkd70T4kV0b8lMEXn92kq3/x1NgMoyGVjd9CnNfeV121C0YEAPU4sBn2dx0qtlP9Fei4E8fN3wb2iLAcayBaoTKknATHZB4W7j4eFgzS7Xf52mvfYmnmHf7Y/KMrPfIJ1ULkiExpA0D6eFWRBiMtacXOgnGAatINSldfPteNX3lhEJjuczuIKq4IFo45CwC7GOoAkVlo/rvA3ptqkg8ohJidmfBn/OxBrwV9oRtD6yhKSHde1C1bpwNuGmyDMaYXUfvlD1CigrAJWK1NVnpiFUQcO2Erk2lIk4o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXhHOStHUTZxS00zWHUxZ05LY1FVcWhTdm03UFRDK0ZNeEwwYWxjN3FHMEdR?=
 =?utf-8?B?K0NEZ1V2d01vUzIxc21Kc0l1S3pHeElrSHdTYXlmVk5VMWxiNFhvK0FPYVJO?=
 =?utf-8?B?TEk5aGplOWdncHhRalM5RFpxbXhuZ2dOK2Q4dmdjaVVTZ2EyeER6aDVxQVpT?=
 =?utf-8?B?a2tLZHJ5clViRXFERmFkdjd6Qmd5OUUwQjVUQldFYnVlQ1AwSVJkZHZFYzNl?=
 =?utf-8?B?ZkVWdE13YTM5ODl3NG5TcXRzODl5Q3RTOEgyYnNTWnMrWVcyVUE0aXBuMU5k?=
 =?utf-8?B?MlZNdHNESUxaZGU4WS94cHJWV1haQVlrY0JhS0VRSFNwNzJQM2RjR3ZMb0xk?=
 =?utf-8?B?dG9lYmZlRjVTcTQ4bHh4TDJXRTFBQnk3cGNrc1R5bFpuNndGcXFXNjh3YW5s?=
 =?utf-8?B?MEVsRUM2R0c3UkRVU1FlREkyaXhscm9sNzh4K00xSGl4UHJhUlFGMDNUUVRo?=
 =?utf-8?B?QmlaNHJQZGh2SFhGQlVaanpyeHgzMlZOSXMxUkh3TWExekhXNCtPd0JZTURG?=
 =?utf-8?B?bUxHSjcrMEpjMzRWbzJJd2pHeWZYdVRiVGovY05tR2hIQ3JnVytKb3Ava2RW?=
 =?utf-8?B?OVlNLzhuSXE3YUVUMzVjMFp4NjJDSGh4NzVxOU11azEwN0JQQjFUaXBhM0Fo?=
 =?utf-8?B?eW9CRC9EZkVHUmJFR2F0SXFoSSs1WC9CMUF3TEFYRjZHOW95WHcyb25EWFNx?=
 =?utf-8?B?akxYVEtFeXcxaHN6VFo0Q3RkR3V4MElLUlY5ZWg1RWMxZ2k2a2N0WjdoUnBO?=
 =?utf-8?B?emRXTWpsV0Q1SnN5NElpbXc2NWs5ci9KemhqTE9CVWl3WFJQaHhvN2QvanN2?=
 =?utf-8?B?eFJYWGZ4YkdSTzViTXE5a0hKL2pNLzgwdytxR2FicEVxQWJzRG4ySVZOMDNF?=
 =?utf-8?B?d2tRTThpTStsQmpVc1lIQVRzZGg5ZGRGVm1OaThPZndJK2FicUx4L1VxVWZP?=
 =?utf-8?B?T0hvbjR3TGNhTkV6Uy9LQmNqVjV2R2JMTCtEV0VuSSsrRGtZSi8wZEZkTmJq?=
 =?utf-8?B?VWwxZG95WGFwWFpPZ0Q4UjlBVm1WYlFGc1hzcFprWFNCbWNVMmdyaVErdkth?=
 =?utf-8?B?RGNGMEdkSXlocnp3dHczV2hYcHBLNm85Tm1XTzJVY1h6MERWL0JocFpabytq?=
 =?utf-8?B?V1hhdEFudERmZjB6M244SHRvRnhzc24rR05CZGEzRGxQZTUzZWRyS3ZvZDVF?=
 =?utf-8?B?VkZ1RXl3WUdUN2Z3MUUrTDArVStVc25SS3VoMXBkcHI1TGsvTWQ1Y05EVm5q?=
 =?utf-8?B?dHJKNHd6cUFRVTNyTTAxcUJKQkNXaEM2Rm8xZUN4UHoyaGVuc2xONE1Kc2RR?=
 =?utf-8?B?ZFNpeDNpUE1wa0hVQkdkb3FmSUQyOVdWaFdPMVlWNm9FUGJNUDFWZkZaRWtY?=
 =?utf-8?B?cDdENk12OU1qSzZ0QWx0ZXM1NDZDR3lRcjAwZllyL0xoYW5mQ1ZTeVArRGxG?=
 =?utf-8?B?NFdOZ2ljMjRYdnV4TGthZHV0M1ZOMnZhSzNmRjFSOTI5VHlhS2E4dDUvajll?=
 =?utf-8?B?WHJJaFNhVXRTMnJHZmUrUDdlVDkxTUJZL3E2ZC8xNk9VK2UxWldRc1JvZlpq?=
 =?utf-8?B?U1AyZWdyaitoRkxRQWEzUHl4R3FHOTYwRU0yUXo4UC9rWlVybzdWZUNTVzhw?=
 =?utf-8?B?dXJSclY0RzJ2blZHMWNDK3F0bldyRkV2bTlITFF1aUtpZktDenpmeFVjVGxH?=
 =?utf-8?B?UWtRWll6L3lrNFZsTU5naXNOMUp3T3VGRDlaeVM5YkpHR3dJUGRKL2RzUWVH?=
 =?utf-8?B?dnk5UFFuMTFMbHhickdLblVtcC96U2k5Z29jMUZmcU9QbXkxc21vWFpNd2R0?=
 =?utf-8?B?ZTVvQ0Uza1FMS0syY25OWnM4Q0dCWkxJbEVxYVA4Z0tCd3UwSitDbnBPd1BW?=
 =?utf-8?B?bU5DUDRwUHhGdTZaTTZUOEZXbUZwRnpHUWtscHpFWlFrOG9WOGYxSkhsSXNh?=
 =?utf-8?B?b0xnZkFDaWp6T0FOQ1Y2TVVBd3ZZQkE0R2RWdnNROFFxdUpBb1VJSThFcjA2?=
 =?utf-8?B?RVBlcEpuWUVud2sxS09tM0pZV2N0YzJLc0pkUFVSSjRvR1k4K0FOQml0T3Nj?=
 =?utf-8?B?L2tFSEgrcXpYMUdoVXJVUENucG5Dam1xYjdBb3Y4TVN4S2NTYXB4UGdGNmQx?=
 =?utf-8?B?MnR4aW5oQnlUbEtmYkUwdVFiSmY2T1hwVTVqNFYrNW1UUXIvb1RUSHRXdjM1?=
 =?utf-8?B?VHZ4K1JkMGphVFpCQVkvYTVhbDhIaFpyS1FOTVh2RERETERoWjhSOXp0WktS?=
 =?utf-8?B?L28xenRGR1BQSHo3RzVkWEhiVE9sUWZEQmtsM21QZU9WVURtNmtMQXZMSGMw?=
 =?utf-8?B?WUUrSUlqQ3VvYThnWTlLMW5Lc0xIM1lBZlhoOHJaSHVBZXltdkh2Q0FnNW9C?=
 =?utf-8?Q?NhaaRoUG34pbZbM9/i8Htvtjcr95JTgrvbUvatchjA4u/?=
X-MS-Exchange-AntiSpam-MessageData-1: GASu92mdwMMl1g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c47fff-eea2-4b4f-1a50-08ded7641d01
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 11:30:11.8997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKfUCKX/QotudDhL7aTjsUH4e69IpRmgYg/Y3eyGu7Zj5mL3dcx2o0shyXeWTqkS0CObGMD86B4E7MtqojriLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098
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

On Sun Jun 28, 2026 at 11:53 PM JST, Danilo Krummrich wrote:
> Add a ParentDevice associated type to the Driver trait, allowing each
> DRM driver to declare its parent bus device type (e.g.
> auxiliary::Device, platform::Device).
>
> Change UnregisteredDevice::new() to take &T::ParentDevice<Bound>,
> ensuring at the type level that the DRM device's parent matches the
> declared bus device type.
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
