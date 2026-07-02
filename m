Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44683C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 06:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35CC910E443;
	Thu,  2 Jul 2026 06:06:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jNXFY/sj";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012006.outbound.protection.outlook.com
 [40.107.200.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CFBC10E443
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 06:06:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRMYtJAZ/Ftyvh2UxbS00FHFdmMWn8sOjs0Z+SiSuGT/pxfICg/kOeuS9iA3RoErIjvqg4iWfowMsNLLTiasroSR6kFnIsFqZbQ22017vOSmf4Gxt9f5to+BvsH4EzKDZL/ciShvjVO8cjVVTbTNZrCXDgyCcCQ3uXi2DvBfVAq62Mzhj2sgvc0w/SNv/7JNdUTZzvwLlqoPV0ArgxmEeL8lj52oSxHSN0NkRyE+3k5n5RVycj/2UxyP3VqC2Q1eH5VD3BQoolA4LO0nhTysKjj/w4SYfygDKxkgeTyyQVI9iG87gjI5KF6lqOsmVDqBtzL0KhmiN1o2Rkuqlrk1zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/CFyiHgs16pCDMXSYfho9x0pUFEh6Gabm/WviKlDWU=;
 b=h4JHdTzdDTXZyAfnMXhbGt+P+GcB6QryQxWd9GO5Y+0LRH1xWo3657+fKNIwGi8Ntu7llClVSpazTDz/2J5inK+Xsf09L/oEJfrkQ2hyJKuRyICzzz8+JDpuQFOtKcMz4j46lmkSq0TS1690nXqWpZ3wUITM+kOKMm0CH1P62edWSatizmP66JazBkoanyJwh59iP8hQo7L8Bs2BKN7B8X2mZCvq1QSTcozsM9OOZsoEYTXUv9YVqme7bvbeOtqt8qq8Bz7eE2YotPYDG6+ie/2niG/ih2m/2e18mqrfn8rCHVrEkXgP+iiOtEycn4HyvAJjzvsw0TOAwNmqY+hBtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/CFyiHgs16pCDMXSYfho9x0pUFEh6Gabm/WviKlDWU=;
 b=jNXFY/sjaKtNptAbTgfaUK6IMcLIsFoq3LdzfxSl+v9OmH+LxtHMDXuXnMMDQMwZKGwF8Am9muoGqxQZ3f2Hb1BMWxIZsdYbf6k1194VQ89ARUnygunkjJAiIj6h1buGxpdV2UEiNR3yfI3bTg2Gqlpvo57F1dgSh+aoaDvnHf7v0C8m/ook1qcJ5igamtT9SjvKTHM8O5/5y2CN2X07cg0qRsQkpSNyMKfkCOr/+nQTGcoivzSZqhUXyY7t/7oOjPMxifqYA2syU6JePuYk/Yz5SLvfscKjEzT5IYCJzAASge58MAfRRA1s1wHlSCAvW7/URmngraNB0I92/gX9hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 06:06:41 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 06:06:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 15:06:37 +0900
Message-Id: <DJNUYRYSQH1A.1BK8JMIIB7T9J@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <ecourtney@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <lyude@redhat.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v5 12/19] rust: drm: Add RegistrationGuard for
 drm_dev_enter/exit critical sections
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-13-dakr@kernel.org>
In-Reply-To: <20260628145406.2107056-13-dakr@kernel.org>
X-ClientProxiedBy: TY4PR01CA0037.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 52cbcf6c-490f-4989-6b66-08ded800157f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|10070799003|6133799003|4143699003|18002099003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: wESL3AzgbLpfcgDzMbt89Gvm7SVE827iLz8dGXRvtljAp/UIgnfKaG39jo5O9xoiO0fcu3WO2W6DX6T8+WUU7l0nf3LmdL+wLVNU/h/Z8RczgdThx7RDtzOlNdwRcOE/f3bU5RfFl+2oMiaWPHwe6b6/xEpZzK07cwmqINZn4nFz3CEZ46MY6TIZP37eao0h+euGciP/8044x0+cwWhB2XJRGQJNuTsT6E2HJ+9NlczW60MslzAsvZKpUVzdoBGPxCuAVoDwNYdR37oYT0vMLpV69e5C+VpyaH3JXw/DOP6CquKlaTDxFERdb0hc9Vk6UJ7DH6rGeEBoClbM2FWT9bVQPCq6FHpSoBWxMoV/LPGZcIUd/iefQypmS2tj2WfJ8LD/X2qQcNY3HZQGtUXkx0/yaqPEYjKOUOUHJ5xL50279LswhFQcfgd6f7W0fSCYkwCA6Z+TXIMEEUTREnDmLQFF//fdYNsoK1u7usXz5L/YUENfGG5NbYJF0Bg214NTZU23/YEQ0gM10lqmESVbUSPcPv7H6hZ+1a1Slp13C1GitYuhbZGk3/1E7CACJ147OmmVtwT68Je5SbNl2sI342Zavv4KMJs+iM+RqfFztPoWd4tCe+yEk76bJwnI24H2pGRQwMmS16AQvbE8J37nyZImBR5fgXBn3xXWm18uKtI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10070799003)(6133799003)(4143699003)(18002099003)(56012099006)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXZOa0pURW9CWWJlZDJtNGd2UzZuZlBkcWdWWjh0SkcwalVOMWdsTkFJVW92?=
 =?utf-8?B?WTJ4VmZROStQRE9qK08xLzFxVEg5bXhoSmRGaW5CUFREQ3B2YlVWZVRGUGg2?=
 =?utf-8?B?UXlXWkZseC9nQnpWSXRxQks5Y2dGY1k0TzFneUpPdVBsWnNxejFEeFJqRURE?=
 =?utf-8?B?RTRodlNzeC9sQzlaV0Z0N3ZEdVJncTQ3RUlPYXYzT1p2Qm1QWjRvWUZEVGJT?=
 =?utf-8?B?ZU9kR2RicW9RZ21ycENnazVlejVFNFJJQzFKL1FHajAvb3NydzI0TG0rV1ZT?=
 =?utf-8?B?MWc2cWhaci9NcC9xbmx5Ykt1Tkk4clI2NGd0L3FnZnAzU2c2aGxzRWdDNHdp?=
 =?utf-8?B?RGRnRUZEY0xXSHdUNnFwTjZUL3pFU2RCSklMM3k1TU9VUTZOMWpmS3BtVzRX?=
 =?utf-8?B?VzFBazVLbnVpQ1dCZmdLTGFtNlJDaldia1RqOFVoUkl3ZE96ME1MN2hjd2dE?=
 =?utf-8?B?bnpPYlMvSUE5bncrQ2dhZU9TTkJFUnJ1NDFvZXJRcWdDeVZVMld2YVQyT0RW?=
 =?utf-8?B?Z0EwZzl6YUQ0MmRPR3JuVTdYRGFGKzB2TnpiRUxBbHR5aUNhM2ZnNmVrSXpk?=
 =?utf-8?B?SlBUem5ESVk1NlRhK3NPYS9mNDBRN3FVM0hLSDJmbnJldmxPREQ0cmJVeUo2?=
 =?utf-8?B?OWhJcmxJdUhpZHloWEdlRUZCeWlaeXNTcG9xdzFiYzhhUzhkWFlaTy9zQnBB?=
 =?utf-8?B?cnBGM2hFZ0ltdXR4TzAvMzNDRXJab0xkZ0E1cGJyVmpZRXVDUU5XTS9RUWU3?=
 =?utf-8?B?TGw1ZnIrN296MU1DbS9uL1l6djUrNU5DTXozSXp0TnVxMjdZaWxocmVBaHBQ?=
 =?utf-8?B?QUtwTEZyemhrMHNpVXpIQzkwZVNBN0hvQmZwZVNKaDRjWmREYlEwZFhZQXdS?=
 =?utf-8?B?R2FuZE9VWUF3aUE0RUJSU05FcDQ0dVlacm1sN0tGWlJQaURsUGRCQndZQ2Fh?=
 =?utf-8?B?U2ZvQzkxN0xnWlpya1VyOHRZa29tKy95bWxrT2dISVNuQm12aGloVVdWWTY3?=
 =?utf-8?B?NEE5cCtkVXB1MzlEZ00yOTlhejJPSGtzNTNTVUVjNUlNNjk0cVgrTjkvdzVP?=
 =?utf-8?B?Vis1NU5SZ3ZzS3RJZm9TNnVRejB3bGpGRjM5N1lVS3BvZGxJZU9qSTg5dmYr?=
 =?utf-8?B?UW1PRk5rMFBPSVZUa2kraU1aVS93ckxBcU5KZjZoaWJNanE0Y2hmNGFtVGZn?=
 =?utf-8?B?bDg5VE1icUJ3Z0U4V0NIZ2hiRmVlZjBFZnEvQTNsZW9JcEpZZjR6aXVkbXRM?=
 =?utf-8?B?aGcvSDBLL2lWeDNqZ3dMbEo1Q0REOTVwNjdUekxxZ0x6ZHJEL3BxVWxlMDZK?=
 =?utf-8?B?YUduTG1yNXBoeGxKUEhITmpRVWUrU3hIQVIwOG1LRVJvTjRqSEN1Ykllb09B?=
 =?utf-8?B?cnJ0eVg5dFFsbThsNWExRTdTTERzLytXOHdMZ1g0UjBwZ0lmT2ZDRUhSN1NB?=
 =?utf-8?B?V2NYc3J4ZXRjdEZQR3VjVG41RTUycGp1N3RXRHZqd0t1bkY5ZGN1cDNHczdt?=
 =?utf-8?B?em5JSHM3d0paeXMvcUYzNzVYb1dHTE9uLzNoSGQySTlnVEJZN2xKZThxUzZF?=
 =?utf-8?B?OXB3NnpkOVJrM25QNVFGZFdhZUk4aFdMV1RCd0pDWkcvL2oyYnRvTHNkVU1h?=
 =?utf-8?B?b2dkWlE2VkVVSzcwckJpTTNvK2UvMlBWeFRiS3dxZjB4MWNRQ2EzQmdMZ25h?=
 =?utf-8?B?clc4WjJjR3BBVlNxMDNsUVJyWlZ2OHVFNWhNeVpYVnplUXdvWklsYzcvMmVs?=
 =?utf-8?B?VXdkTU45VlNQclR1UlpUQWdMajNxeWJjRTNVenZVQlRadHlIV01CSUpHTjE0?=
 =?utf-8?B?anBPdlNhWkh1SGtnNTkwN3lGODdOYUxoZUhJUU5zb01pcFNmZVFnUnZoZGtl?=
 =?utf-8?B?aHBhT1VNSkJrTTNqTlVVMkVnR09oZmVkNkkxNE96OWlhUEVRT01mUGdGZmU5?=
 =?utf-8?B?VVE2OEl5alNJOFVTaG5qL1RtMHdrYzJENEx4KzA3ZWpwNVpST0U1Ynk5R1ky?=
 =?utf-8?B?b2FUV3VsY1Z1S3pTMUFzd3l5TXIrbUZXUEVjRXBpVmNveFNTMzNyOG5tU1FM?=
 =?utf-8?B?VGVPMkZ0Q3FnN2lCdzZSZFRyMHJReit4NEtqM2U3ZmUxU0hYVXlwMEF1aG84?=
 =?utf-8?B?WWt4LzZOTUZrM3Y5OCsrV1hoSnBWYXpRektpbitsSjJKTTlteFFUbUxKYzVE?=
 =?utf-8?B?Y29CSDJsQStNZzlmT2NtTlMrazI2Y3NDbkV0UE90N2RhMzN4TWRVN3JXL1VF?=
 =?utf-8?B?ZGJRMXRxVUNXTVFFVk9lTElLa3F1eFcwem1HU2xEaWNkSHAveVhqelcxL0RZ?=
 =?utf-8?B?V1ovbS9QdTVSaWlBTEFOYlFpOXN1NG55cDVMQzUxVEpTR2FKeXNvQk9QMHF6?=
 =?utf-8?Q?Mv9fWg5GRTiSCtt9eQfLKpyPthjTfgYncoulsCSK7T8TK?=
X-MS-Exchange-AntiSpam-MessageData-1: xhQj+4/7XIhA0A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52cbcf6c-490f-4989-6b66-08ded800157f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 06:06:40.8853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEVTFx/8RgWf4gw+ZBgqavlDoyN/xZpYWGRnw7/dEvwGb0hh1546tpyPEjjuOcukWG55ciu+g83gfNYDjTg+gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810
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
> DRM ioctls do not guarantee that the parent bus device is still bound.
> However, since DRM device registration is managed through Devres, using
> drm_dev_unplug() on unregistration ensures that between drm_dev_enter()
> and drm_dev_exit() the parent device must be bound.
>
> Add RegistrationGuard, a guard object representing a drm_dev_enter/exit
> SRCU critical section that dereferences to &Device<T, Registered>. The
> guard is obtained from Device<T, Ioctl> and proves at runtime that the
> device is still registered.
>
> Switch Registration::drop from drm_dev_unregister() to drm_dev_unplug()
> to provide the SRCU barrier that RegistrationGuard's safety argument
> relies on.
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
