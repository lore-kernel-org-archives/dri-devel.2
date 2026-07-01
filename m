Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D171C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 11:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E03410EF08;
	Wed,  1 Jul 2026 11:39:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="mogeRbRD";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012058.outbound.protection.outlook.com
 [40.93.195.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D34A610EF08
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 11:39:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPG+sl9v2+KicQzpGcRSOUpWrAd8BzlGYaM5W7wJsJXi/k7AvEa1X/LBy+BriETsBBhEc1hNxifCzLc8uLTn4Qs7gAVwrHyFDzpodEyaQhGEnwUEuOCQAyy/Bdl6ISMjl/Ek1UVNrEMtFXlJmmHgl9rGrEiFnYaBKjurUAm/2vDL2jH3SKoJT1AeGbGU3vzuRhcCjGBgomi1Ig6fUY3Ne8uvfF5umuIFrlpi/txv22imirrmi0hzqWox+taiJzEnCRgbyTnJNGyf9zwH7dp+FmZf/gVQm02nnoZP1sGCVG+usezDWYrcf3zpsvF7KIIa5YMkJKQQIGAk6jBXRHlORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2QlWcC5CTvW22tW3ZolvECJJqN1DCu29xF5u04VI0k=;
 b=gLvM2xyBVIBkrcOkA3jLoAmzJx5h2pV2AJncTmhsaVNGxw9VvotQGX5PotfntQegsNoZAZeL8rsyV9hovy2NV8gSJCs04mAdWJwpGRHpo9waV7o1u37ClcPkj8Pcd7hwO+D36WP1xmEeo/fbWV0CjJY9A3m2drA9eQdRbgsO4PClBmYthmm8u0Z/xymM6T5Jk1qUM64nmiDd/Gk4q2h9jWXIjh0zBmRiubRK2BxSR7Xbo3Oys+hpKJbMnMtUwNTe6KDAG2AvjdEYyclTTMEK9+3R82jucqgj/X1l4E7IzEDYVTpIl8w9C/8Gx3du2eFPlF79xINOL+OszHEFJp+xbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2QlWcC5CTvW22tW3ZolvECJJqN1DCu29xF5u04VI0k=;
 b=mogeRbRDvXTd+iF97hZKMHJuVXjdx9Vupogt5voV6uVmIyCa3jkxWu3Bma2XrwLFtSTTAessvnJyITzk1UGXMFXsIIqcUJuoL5Z2xTbfRM/BhGysHRIlhzJQu5a7ELyNS/0GF0hHWnMt8lSeeZF+lXzc7KJqYtQY2X3d2AhqXcn/R+rJZaBtgqdmAm5BzjSDIcLGqDyy9otm7V5+60LCwJnW4WQHYaETFf2fW8ea1BpshO/3X0OhGHkxtCLUWS+AQehkbjfquZUfkH1F9rNk6je77neMbqvzxDZ/ZodUQOFOqTBFz5Ka+AgvUb+7F4VvKYE7i0g35DooP1ScjAwsUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV3PR12MB9117.namprd12.prod.outlook.com (2603:10b6:408:195::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 11:39:45 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 11:39:45 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 20:39:42 +0900
Message-Id: <DJN7F8XYS3M0.ESS0T8O4HOJ3@nvidia.com>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <ecourtney@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <lyude@redhat.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v5 06/19] rust: drm: restrict AlwaysRefCounted to Normal
 Device context
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-7-dakr@kernel.org>
In-Reply-To: <20260628145406.2107056-7-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0107.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV3PR12MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: e94c58d9-8cf2-4037-d865-08ded76572e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|10070799003|1800799024|366016|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oI4tChcp6slUDK9UR2QwFtFfG5VMXyJshWr4gw24eWS60sYtV5yKctD1zqZ0voMQXZ/i7XIMw+8O225dwRaqEdlxcemLr2VJg/izuI8o7RQcBcEieTwJA1melOjI3DiXse282fAgU1g2Dw3TzkTL+zfBt4dG90Wc18p+XQUylW6LthiDO8V+oAYdLTJxoMv8Jidr0h/uwqEx8N5y5cECnOLly9cJWnv0nDEqP8idJn4oBnz//6NPL8NDCaznl0fxgLEzQ670iaKFvFQ6gadimOqLrVIeDvNBsaF1tO7B1iSD0SQ47J59rUePFjXplOprmZgVwrYWzoF22JGFkqJdSXlGVa0Zm3d9+I/WOQwiUST1yYQMDEE9fsoK6PEs8+0aLrqry71d55euwnPYo16WWTDF0ozudCjdCiMNDi2I34YlfTiMNjOfOZv29WgKk/2rWyay9Lu1EA8/ZbltSPRVTfRcAG0UhpABxeOqaxQ+ZjjmY2+O3L73qyM5Cb7Oyn8kY7LAWbBOrCtmLlKsR/HzOd916cwaNXUOK+Dj1kOe+88my92KLoZNKCWHbx8wEZKGqKa+cWhc8scIcy8jsmqReXmgTx0d2RWizdKy/N3XAtx5lsWN2ZQKrwulzJMiZwAKvhv2FSAwStPLSRBb/lqeqCGze2cPZV10PHRH07OmOIA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(10070799003)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEI3UkxpY1FkS2FiNlRzMFBDVTRxWExIS2FqNGhNcENjVFVFUDhkSkp2Qmph?=
 =?utf-8?B?RkRmU0VseGYyUzMzZ1MzYXpJUXZpcmNCd1BVbkpkc2JUMWpZMWpjTWRCZVlC?=
 =?utf-8?B?bHMrNGNYQ0lXNU1KRC9TYU54WDQ5ODhZVnlpYTNGb0IvWGJRNU9HMVFXdDdl?=
 =?utf-8?B?K3JTUnUycXYvTWtNTGRvT3QwV3RKOUxqMVRCZnhyRE5XaHpFazU3WUhQSjRJ?=
 =?utf-8?B?STByODlMWDRmOXMyNmFZUGNEbmV2bkZYOWRoa3l2QXVnUnpvaEVzQkVzaXhX?=
 =?utf-8?B?OU9wY1ZVSEw5SUxlL3h0eFQ0TUc2TmZoaXRrMXhhK3pjYk9uSnpSQ3hKSEZP?=
 =?utf-8?B?c1ZqTERNZWZ0WEw3MmV5dVpTSHRBZUJCbllHTkFuUHFwenZUQ3ZzaFcxTE9i?=
 =?utf-8?B?TWxmL0plRkp1YXJtZWQ5MTZiMVhSakg5U2lJa0FpSThwZFFNeG5jSjBGZ01D?=
 =?utf-8?B?NWZNSjkvSEk0R1NGSm1USzV3SUtjRWc1b0FRNmtXbVZZSmZUaXNqcEw0M0pm?=
 =?utf-8?B?ZHZwb3BnZnZ3cjBSRzVUK1VxZXNmTUh2VlpuT1oyRitMVUhsSnRaR1Q2cVFL?=
 =?utf-8?B?aDAvWHhOeSs3SGp4TDgvZmtEbG5ua0pHQXlSVjUxa3JWUjI1cFVmQVpLNGpX?=
 =?utf-8?B?Z1dVNThneW5BZjVVaFhuVkFyTisraVNSSllRWGZMelJZWVVWblZVK3Y2RUt3?=
 =?utf-8?B?eEFaMC9MTGhOZ2prbk5YR1QyQzRhcUpXMkdZM1d1elJKMVZubUxKaGhUM2dn?=
 =?utf-8?B?QVNRRDhFYitoUjdHYWtLa05wUzB0SGN4WWN2b3IrbmlpUG55djNzc0hYdDYz?=
 =?utf-8?B?OTh3WjJVMEdVN2RyQmJMOHF0WGNtNnUrMyt0MkpSeSs5NGVCdkpkalNXTWs3?=
 =?utf-8?B?SDh6NDhyQk4yZk9yT3UrUEsxdS8wY1JDVFRDZWxLUlVUaUlzcU9mSnk1WnFn?=
 =?utf-8?B?R0xOTVRtVm84cVp0MkM1WlBIQlUxMDAwS2pOYzVnZ2k5Mnd3clAyLzhQajlG?=
 =?utf-8?B?TVhvaHd4cEZSRGdHNUxvdUJiSHpvQTZqODZNa0xuUThLTXFpMk8rYklYOUF4?=
 =?utf-8?B?NmZJTS9KZVd6NlFPV0JHLzlaZjFRVWZLc3dKZ2IrdkxMRGtPUjJCMExUZkow?=
 =?utf-8?B?d1d0ck1QWnJzWGFDZWNEZkUzelByMEkyK3ZPS2hQTWx1WG44L1pVei9pa0JB?=
 =?utf-8?B?dGVPODVlWE5JODdYTzlWVE5BcTcwS25hRXRTaWk1WWxQTEtOaDF1MzVLTjdO?=
 =?utf-8?B?S3ZsRVMrekc1UXV1dVVSbHRaZ0tEM0RiTHFaQ3A5a2RZODdwRFg5Vmt0blZp?=
 =?utf-8?B?QXN4b2hzSFV6VUVDU0IvYllCa0NSYlh6RzJSL1pZZ1lwS2oyQWphQzdSOFpB?=
 =?utf-8?B?NGYrVTJ2ekFmVVBpV2E3VkdlUEhiWTRsNDFCa2FwR0NJRXdJTVR6MXJqNno0?=
 =?utf-8?B?ZWd5RmN1RzlPSVlMMytRSlh6T2tjVng4Z290dGZQbk5WWWw4T1p4UFNEQXpO?=
 =?utf-8?B?c08wbGFuY3o0Z055Z0wzN3BpQzM4eTBFTTVsd2RBdFdFb0ZCcTNRRVFNQXlT?=
 =?utf-8?B?N0lVejd1UnJpeVNWcm5pblordDhDUFc3THVnQW94bFZLWmgwaUgzNkkzRjVJ?=
 =?utf-8?B?OWhpR0ZrWDEweUw3Q2M2clZyQ2JjbW44M3hNbk02L0wvNnZSSktVaWV5cG5p?=
 =?utf-8?B?emFZYW80VFkxaFpuMWNHV1ZSNkN5RnA5bG83SkdwS0FOci9FbUh1SUlMTldx?=
 =?utf-8?B?M1ZPNEp5U0hJRjNvY2tDRkNpWmJDSVo2bVVUWTVEQTA1eVo2UXMwajZGRThG?=
 =?utf-8?B?OE4xdXN3dm1FaitmNHhvWCtDZ291UUFVYmkySUs1VXQ4VlZEVXJCT01XdVhk?=
 =?utf-8?B?aHdqV1UzOFVmS0dabTl2bk1nQXJrM05TdC9DbE1MSk5acDJ0Q3NtK2RLendn?=
 =?utf-8?B?SVYxV0RIZWtzUWNhRTFkemlLa1FRUmxDUnhSQ09Ka0xmUlpKcjRXaFJPc3pq?=
 =?utf-8?B?UmFLOGJlSHltTkxJWWpNUjFKbS9tendOQ3JRK2Y2L0pmWnZSeUcreXhMdWhO?=
 =?utf-8?B?V0Y2cUY0Y04zQzIwaVRweGlNKzRoQ2Z4VnZXUnVVZGFRTzZtSzcwUVp3c0ZN?=
 =?utf-8?B?TS9tb015a1NqQlora3kvRGJvSHhBVjhYc2xCeUk3ZDNtZGxMR0xWclNtNUdY?=
 =?utf-8?B?SUFpMHY0U044ZzBaUFZCbHphNFRtMUhKRThFSDFNUmZyQ2E3VU1uazltZlFT?=
 =?utf-8?B?cWVvL1dVZ1pJWjNGb2JZd2g2allHTjcrelpvaDdvTTZEVFp6ZnExL29OOFVz?=
 =?utf-8?B?RDVONFUwNHdYVmo2aG1Jc1V4UDlaVUlRV1dnWjgzdVl2UEgzak9HeFhObFJ5?=
 =?utf-8?Q?2s1FPy6LFnY2EnvmsAZt7gTid6Oi9vz7e8MevnTkAPcnt?=
X-MS-Exchange-AntiSpam-MessageData-1: Yeb1/V+UQEFoWg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94c58d9-8cf2-4037-d865-08ded76572e1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 11:39:45.4068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3cpaUsjR4+eEsvejgn8VvTyiTSN5NQ7LBt8Eg2HPgXbPWIPf5pvZjMAq1uPZW4J4vSR2FrK0yV2ZgpOUJxz4LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9117
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
> Restrict the AlwaysRefCounted implementation for drm::Device to the
> Normal context. Registered devices represent a non-owning view of a
> device within a RegistrationGuard scope and must not be independently
> reference-counted.
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
