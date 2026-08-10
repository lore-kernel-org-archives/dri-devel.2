Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730A2C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 09:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95C0B10E769;
	Mon, 10 Aug 2026 09:31:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="At9hOsJX";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010030.outbound.protection.outlook.com [52.101.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1529C10E769
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 09:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gG+X4IbEHzGWdF+yzVIR+Qv5NPk0ua8useUHeB+tZcFqaLr2AMI7ouSsMonNCEXGm7i9i+LzdQjmbRzbQXNb5db5QDFRY4/q2jJzmCWDnc8shROHlVQHsVATCWAloyWzU2yoT0dn3RCNfmPZcWeEpmJwKy/WWPn1LTbG0+8H2REarsjQ0myrQ7fa2zzV9f7J+VVYKFJ0Pq28ZXKS02tb1kAvTdgEPIo2AIoJuadHJfJuIyV6z6Qg/yr4pFGhICDXmwMueCc9lYQyGzLJyGi1U2nWD0B/K4JNBmtBJdmqfrNqGS5fQm8yxRPBPbMPSQh6S6NdGQmrkFjmRqHsZ0kkRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOcigV9aiTt5oLbS+1YSC1J6d4its/26CuK84orwq0U=;
 b=TWbDPafITqMuwVyNaeG7+U1jNguW0bvM7p3WNWmlKJ9NMVGO1I+LgjwOryZBHgE5EVbKXiqbC3aLYirxXysIuJNGiBN5vqzntzBaUc/k/OR9C4tNav/1T11fZWtFauv32KOY7t0pQlhgW4iYKTnLTfOI4XtMftaLqnjw1GwVVIJwAWuAUEOsfwE+04S6YsnUyyOL+lWxDhKe2BRNWm+ejGRU25cnbOl+cspyrDsH3jJyA1vWbiLVJw/sRl95TwGEb5PBXQUv1LLQ+hIWqR67ycSmex1aDvMm7XSVjYie02qhsDaQihq+rqMHWvoxehBExlHB1xP9zaJ4u8N2Y6gySg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOcigV9aiTt5oLbS+1YSC1J6d4its/26CuK84orwq0U=;
 b=At9hOsJXnkFSPSjOoLcUh8965ZvSyptzuoWjD15rlzkx/3xXKQSlqls37VAdemmaFofUPQbEunFSL63RxUOCTTsCHLyYIcPXVJ0LiscELg3R+z9Y6I3y8zEVbWhIuSFi/GV28OPBJmReTYJtmz7Y8T3MbRIQgbp8x70pfCngUtE8ridyiSi60iov2eu1Z+I1/ZqgFcqlD6HYrNqiO8/2xdo1gvy4X+tRedHS//OU9ZcjhWKGX2cIFuOuVT+7hB3sUc4cLWggyAfeQkuO0pHybjKNQ/+l86Pdk8IuCmZ8u7Ar4LSTYacgfZIx/UOvKl6qq/T9AR2wSrscvNKZkAHVlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB8570.namprd12.prod.outlook.com (2603:10b6:8:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 09:31:49 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 09:31:49 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Aug 2026 18:31:45 +0900
Message-Id: <DKL5R3318OMC.38HDIKRBX2P46@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 05/16] rust: io: register extract offset computation
 to helper rules
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-5-c3ca142220a0@garyguo.net>
In-Reply-To: <20260805-typed_register-v2-5-c3ca142220a0@garyguo.net>
X-ClientProxiedBy: TY4P286CA0024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8f6a4e-644b-46a4-8f2a-08def6c23437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|1800799024|23010399003|366016|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UGttlLYQeSGwdhaeDGsiC2dNPPCasts6DSAnOFGzV950nDSxCEamPOYvQB3NE5u9+SSXFd7mNrjk6vtLUihXkDhzcQ3d09xy0vZoC+f9be6zBu+JD3F/tJfvEn+0JNYeF/SaUyBA3BhC60bcTNol3SClVeQM+gpxoXmILT29Eyc2VU690scXCM6gXKyLRKlhAk8R0l2nbVjwYpxu6OJTDgTvqOM4z0Dpnh6/cftz5ECe7uOGfRVaHJLJ916Lzvq63RB3dLThyWRmHKCqgsEcTIhTjABY/Fc8FKfQ2Ie6c06VAqVuO3KyXzaBziyUFkND4EYbrAfzzbe8SYpszAx8tpxgokLgtdOYPONiQVHC6DhiG0IrjkbZu1c35v5ESjLJyHyGPz7NeAupQXuHpBDP7UzbG5FLxplTYzhViFbjgPrXnMms3owh3AeU2hqi1mSpQ7otF3SgiYF2nS3e5ts5qJHK0Avv2eR7x4DnhWLaIjRf7Ok2lX50FL8AJHPHplMR5SCQgeOXC3BuFoz1Ne2YKKT0M5Np5VP8qJuQ6idUb6jGHes99BoCM+DuOa5xHefcgi+V6HsbMCvtmEAWCo/2SvMol26NgeRmn9WEdLDcEutv5rlHXMp9YJAZrHtvXRAkRf13SkSD/gf3BK0ZW4EwRyR+8Twh5KgRtAvzwKIaqFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(23010399003)(366016)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qkx1amtnOWFRUVloMHpJRDBnZnFqSmplOU1EMFdvRUFhU3huZTArbWpSV29s?=
 =?utf-8?B?NnlQZDAvZVJNQlQ4SStydUxVZVpGTkRpZmhERU1wSUtQVVlCYXFVT0I2Vzdn?=
 =?utf-8?B?bU1uc3VDcWIzR2p6NDZlK0I4RG0zdGFRUGdWK3YzQ3dreDBLSXk4emtWcnJZ?=
 =?utf-8?B?YkxKS1FLVkRwaEJ2OVpnVnR3cjF0WnIwOHh3ejRiTHFTWEQ2S0R1SXJqendS?=
 =?utf-8?B?QTlqT2Jna2NLUWEzSW1NRUtPSnEzdThYZVRaSytXVWpocGVQUmdCZkNkNExm?=
 =?utf-8?B?ZmpYSHlRVUwybEJyM0xuYUdVVUtUOVdxYjRqUGtNSTBhTWNnWWc5bDJJcFM3?=
 =?utf-8?B?VEx5TStJbzJBbVJQVktDNk9aT1VodTVDa3k5c3FSTUFkU1J2WmN1TU9ZUmVI?=
 =?utf-8?B?aDR0NEFjNC8rWHdtTlQwRFA2a011aTZTQkFDMFRKUUt2K3NOT2xyZWs3QTJL?=
 =?utf-8?B?eG01eWJNMHBqK0ZOcVRtbVpjUnZrUU9pZndOUEpVWWN1UmpFaDFieU9zUVBB?=
 =?utf-8?B?b3VTYzFqZVhSM3ZnZVdOa3NjM0xUVG5naDNVQVdjbkF3V2dtbHNCb1dYTC83?=
 =?utf-8?B?YUtvN0pxNUc2UFFVTi95SGZQRVhKVXRycXNCdXJvdlYyMHNoZlNjN21CeEdB?=
 =?utf-8?B?dnlWb3dyL05Rc3lVeFMrcmhVUzF4ejJiMkhiOG9jeWtJQUNsQmJCT2dpYlBW?=
 =?utf-8?B?S3llSVhweUt5NFZPUGVPdXY4THJ0ZDVXTWdVTmpPVU5HM0hiTUJEa2Z0Zk5H?=
 =?utf-8?B?YmlKNUxaVUJJdEZVaTBxY3U1c2hZN1JzWnBKaWIrbDV3VzYrZko4Vll2VFUw?=
 =?utf-8?B?bVE1ZjA2UlBWOTE1ZVJaZFh2WVYwcmxKSTZkV2RCT0RYdHZoL2RtZ1EvRkMv?=
 =?utf-8?B?UUhLWVVteEs2Z2NlcUQ2N254dHFxS2RicGpuTGI3eWlSbGEyYVdyRnZWT1U3?=
 =?utf-8?B?K2dVdWZiTStWdDVVKzJocEJ3S2hzN0Q1ZStMeVozdHVVNGIyZFBONFpmWjRa?=
 =?utf-8?B?RXNJejBYcHNBOTluT2FFakJNZllUdWxpUmF2WHdBdXhhWFBhSEhxeGNvY3Rq?=
 =?utf-8?B?c3Q5Z3EyZlpMNXNqR09PTmszSkNIdG9Tb1Zta0lGdWtWbXpzajRjeUtOcEhq?=
 =?utf-8?B?TituMExRbE9wdWpOOE8rUXN1MzNpdVRqdjVEYmRZUDI1UXlueGJPZm9zdDFH?=
 =?utf-8?B?YUtMN2RGNVViMWg4Q1Vqc09SZ3lyOU9lY0RscmFTOWN3blBvY2xTaThpblcx?=
 =?utf-8?B?cVAwMXZtQS94VlUyQWhvdm9WaFVKSWtPbFRQSVdlTmcrQ1pTdW04aEo0UjZk?=
 =?utf-8?B?bk5Ea2d6N0x1SkpWWVR0M3hyNUZIMmRsOXQ1Ky9rdkRjZzNMUnYxaVJncklQ?=
 =?utf-8?B?cEkrSnkxblJxZDBaSTJIODNMcGNvaFhMRWVlUThNUWZTWVJsVEVadGt1MnV0?=
 =?utf-8?B?ZExXaHdNeEhBcmVJdVd5RWNuOTM2OTBzT1FzdmJTSjVaUXkxTXN6Z1ZsNlFL?=
 =?utf-8?B?eHBIT3F0aUcwQis5VDVLY0hkQ3FlSWp4c1NBTkgwWm9Hbi94NUZRc21uNyty?=
 =?utf-8?B?RkVWaHNXZlc2enNKdUxpREFidjBFQlAwZXUvTE9RV1Bib1poZlgvVVNrU3J6?=
 =?utf-8?B?T0RDeFNGTzQzYkt2VU1FbnhvSHVqUGJrWEh2SDJMZCs5M0YrbFdxV3p3endY?=
 =?utf-8?B?M09XZWxvdE5kNE4zYmRwQklNaHRybjREaU5YYmFjMzE1eEwrZkJTNlpQcTZ5?=
 =?utf-8?B?WU12cVl6M3IwZWQ1N0dlSGZHMUJ1Z0RRaTZBNXl5Qis4UWphYytJNmhEODdn?=
 =?utf-8?B?N1pjLy9CRndsYlIvK1F2bXZKalJOZ1lBa1REQ1pka3o4M2c4VzRRNVI0alZl?=
 =?utf-8?B?cit0c3VORVVremUwQm4wSU5CMnZlSk01c2hnclZoYUtETDR5emxzV0huVUZ6?=
 =?utf-8?B?Z0ovZTVUVGFUTWJvd3Vxa2JqNUp4dGE2Ly9nYlVNVWlsejJ6Q2g3QlQwNnUz?=
 =?utf-8?B?dXZSSXJybnVaMHN1dURWRHNBSFU1RU8yUXpyc1d4OWhUWURXNHpVa21KdGV2?=
 =?utf-8?B?TG1UMGUrQkdxV3RRSW5qb21RMlNrZjFoaGRxeXhxUXV5L2dGU0cxVnoxZE5w?=
 =?utf-8?B?M2JORnl6cm9UUjg5QXN2RXZ4UzdZY3ZqMXdmc1N2bmJXUWIzOWRSMjBlVzZ0?=
 =?utf-8?B?VDlvVFE5Q09KczZSZGZrMHI0QXpya2J4NXJvRTZ1M0VOdGZYczRqNW5RV1RT?=
 =?utf-8?B?MGk1U1dBYkl5Y3B2V2Z4M1RXMHdHVlpEYk8yaElyY0lpWmpRMmJZVHFXZlBI?=
 =?utf-8?B?YzdiV3dpTDF2OUVjQkxjbk10dWNvbmVPY0RROU4wbURINXVDek5KZDdYa0x2?=
 =?utf-8?Q?75luzNFzbudln4F/OVIi3XepP1v2exV75OjrSg+gdpTFl?=
X-MS-Exchange-AntiSpam-MessageData-1: +Ts3MLr4yr9m2w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8f6a4e-644b-46a4-8f2a-08def6c23437
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 09:31:49.4677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZmGCoSAYmdfLoMi1q7ACUXv+ky/jcW+9K3Xze13a72kKXlzRovvSv832aK350eEcahkZGJqOm9Pzq/hQUWJRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8570
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

Missing `:` after `register` in title.

On Thu Aug 6, 2026 at 1:35 AM JST, Gary Guo wrote:
> Create a helper rule for register offset computation so there can be a
> single rule for fixed offset registers.
>
> Similarly, extract stride computation to helper rules.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

I guess patch 4 as well as this one can be merged prior to the rest?
They are valuable improvements on their own.
