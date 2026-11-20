Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FAA606A334
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=SQyWfLcw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A16A110E091;
	Fri, 20 Nov 2026 11:23:41 +0000 (UTC)
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020142.outbound.protection.outlook.com [52.101.196.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17EEE10E091
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 11:23:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPQz2Kpw+FRRnCMdtNT4HeblJjnItQ+FyGPSv4vLZERRh4dM4dgPZY/SmDEHKSyGDENfdiiSbK7UQSIJjuodkB1Q4VOyxtW/hpfG0W2XkNltIT2cq9xfoh42xFHrBl+Mb+Xc/5/2LjnM0bssHbeT44W+yNUxBWnHassV1MAHc3OZjzNk+lVCndyhyrcjCrfucb/2am09jg2HPETDAOb0VFbD+LO3zgxbijAw/Rt45uEsvJH8Jr2f9zj/XRVQ/8+OyjTWVjP2W5waIgXLlJKTNh4sfAhvFNf7x4RWXMD+Aee5B9Vr60rauepCw5B5bDDe+NRnJqz8VzbqQlGwqizsBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5it0mfeXZObbCh5BwibnEVHUAOEXBpS1dXwMKEP0MPk=;
 b=i7BZNwREvPvKr4GEvnJKZNJa9bosTJZh9JYRMR0UhSYSGKzJUOJvDphU+ThEHtSYaXdfbTpvqM2W6x0RfSU1KlPLfOUTRjZhPVWGVHq5UVnSpe5/xIf5d/ydMiM0aSyHXWLD7iPZj+AQp9a5SXYrR59Slb3nAG8m7zvr8x99MiJ/9uPmQqh8Yyo6DzF4FASlUtvqmdNAxfiGyMZ4o3Npa2PykaiPNTCSsqj7iXXYqIGPXZu6CS2rVLvZ3toYD/YSMyoLjVNCr4jiIbZxrUUF0Wy9S9gvE5hoiZrTX7F9hTDl4fIxQVN0qI0ASu81VNlmQnnR4MhqdY++AYhmRmKY/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5it0mfeXZObbCh5BwibnEVHUAOEXBpS1dXwMKEP0MPk=;
 b=SQyWfLcwEeNsB5RwzIGyftd3U5ETl05HFoZxiDspQ4CG0e/+Df9U2sSBUiehGH50P65NyP4sWD5wjXTor7uGfjXeqBRBgQ22zA1Dij+KK10hTjspdwIwkzeNUjKBvHrEcnzgd2cKBHMmibHI8tavIf0umYssmHCDb0cVhXKj4Kc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by CWLP265MB2628.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 11:23:30 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 11:23:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 11:23:29 +0000
Message-Id: <DN00073G4YPY.140V1WRMQEK1I@garyguo.net>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] rust: drm: remove DRM device private data
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <aliceryhl@google.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <daniel.almeida@collabora.com>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <work@onurozkan.dev>
X-Mailer: aerc 0.22.0
References: <20261118181245.2583303-1-dakr@kernel.org>
In-Reply-To: <20261118181245.2583303-1-dakr@kernel.org>
X-ClientProxiedBy: LO2P265CA0511.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::18) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|CWLP265MB2628:EE_
X-MS-Office365-Filtering-Correlation-Id: f100547c-bd14-4584-e981-08df46f8b467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|366016|7416014|1800799024|376014|22082099003|18002099003|921020|56012099006|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261021123027099003|261102123227099003|261022105027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: NWpV0cqRcsB7altQNp7JC1uNq9CjzaQlIYIM0jCRyOJDnGcakZ7i1EY/EnLR4YnWI5/XQ45pTha/dzhggo2uFcLN9A4r0Z/qd8Z+y3Yr8wSrfN4nJgklARLHdkmQhPidgVuraxGdPD9YMywmqMtVWltY51tsVe9lMTbqmzYyvNLut5/CS/ac0dj4lW7XQ/4tyr33vW+wbpLzURXvKdDr8QsWiLsbURylPoOhYa07vUg+0Ubiz61wJcYcq6M8BUZDcor4TS+Qd/fxBiicK+THlKQijSULoRxGnQSOP3ILk897Ss0mJZmGT3/mFZKcCEKfaV2FPwJqDm5KxfMr9d6P40O06lr0ReV10dCNxKHYonON1oS50TFschwbJbNw1p+bFwWR+k8zdA/khgQpRM9lkvcSlVfAYNXwl2je8aSZ7PvlC6c11TLDHjhQxw+kRb2aN2k+tP6pnJ7mID9qXnnVpH1Y1IYfRX63Wow6p8tbQqBZS/f34cl7tpZ+EmEWDz+GgAV27J33Ei4rC7UfgY15JHniC8SlTnuG6eDZT/Mdz9CE9gG5RI/8YKkbQmqFC6xrCIRntLxBAnKf3lfogmImXq418bny7sD3tnKvGoUmV0b9LFPA11qdBiP/eWWf99mBId7Jo/Ghiu4P5LeWDKG9g5sO0DuNcTqoaR3paErjeCIDPIF/EEcjdTUPe6kV4mkUokMJwR7Pa37jfFqSFsQ5UQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(366016)(7416014)(1800799024)(376014)(22082099003)(18002099003)(921020)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261022105027099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG1pWFRoSFRVMEpqY3JjZGFxa3gya0JNWHkvZ2JHdy9jWFBnWEVmK2hlNU1t?=
 =?utf-8?B?OWNtSndOMjFjSWJKdjJBZzNMbExhNE44SWJCelpzSDIraTZxTThRby9PSm9x?=
 =?utf-8?B?SldudldBNVpjZFYyQnVZeVIxMVdtaWd4T0RlVTNQaXhPN3RNM2JsaXFyTmtj?=
 =?utf-8?B?YjZkT3E2TU9rMHdLc1NMUTBtQkNGTC9nbmovcDNub0NJenpodUN0RGZMejhz?=
 =?utf-8?B?Rng4ZWdJZytnd3hhSW9BZC9Nd01qU2huQzViUEtWOW5RZFBjeXpzd3JWMDh2?=
 =?utf-8?B?NFpRaXNWRVBTdXZMcXpOd3U1LzdMN0pJU292ZG41WkpyZlR2T1ZkZFlIdTFE?=
 =?utf-8?B?Y2djU05FYXMwNmVOWENFbmRod1ZwUVdSUSswTEpuVkxNaTNLV01DS1JXUENZ?=
 =?utf-8?B?bFp0QnUwNEh4WGVpaWI0VEZXeitOc3kxNmQ3a3EzRWlNVUZzUU5yWWExajJv?=
 =?utf-8?B?SjRLYmdac0NtVVE1cTZBVVdicy81T3NSYzYwUlk2RDB6aEtia1hkbFk4SFp4?=
 =?utf-8?B?SWFia2N5ZkU5Zzd0UCt4TWFkWTRqd1k0OWhWZ1ZqdXBudTQ3ZEpiemNGb2xy?=
 =?utf-8?B?cHI2Vk51Tjl4M3d2ZHl0NFF4eEJFS09Cd0tyd3F0ZFdaUEZaUTBRQlArVkxm?=
 =?utf-8?B?N3NQdFRpbTNmMmtGdEtlSlNwVEZZTkROK1Ewa0hkRFN6VEJWd21wbmNCUmRk?=
 =?utf-8?B?YlJXMnlsdUVGK2RCczYrK0ZYeTgzUXJ4M3BzMWxqaDdaZ29DVjRQenliS09l?=
 =?utf-8?B?YkxGMk9XVkU4N2ZGTkMrMzVOUGNOaFBBYlc0N0ZxekI2MFZ2bjVIY0FuRStF?=
 =?utf-8?B?TUVXaDdYcG0yZG9CZVRPd0hJN2ZWMUN6bmtseXBwR1pMRTBWT2VNcDRsZHdo?=
 =?utf-8?B?ZUxoWUNuUkpqeVBJVVA0Z0Ivd0dJT1BKMVN3emE0L2FsMHJFazBweFgzZ0pz?=
 =?utf-8?B?Y3c4TklUZU53dW9TeFdpWDB2cDluUzV2eVhGckl5bHNsQlorR2E1RzZLaU9j?=
 =?utf-8?B?aTZDWURzUDJKWnRNelN6SU5QS3FrYXBWdGhLYjZLM0Z6dFUyR09meEhSSko2?=
 =?utf-8?B?dDZja0hUR1dLMGVZYytOMUR1S1lnWkwySFMxMGZHZTVveFpQM3R1a0hzcEg5?=
 =?utf-8?B?MTdIajhnanBZYmoxVm9lMXhLYmx4Z3JXZGlYL2g2T2ZEQUxRZ3hXQ3UrZzIw?=
 =?utf-8?B?VjY5dS9RUFJJdWVOU2hhRE5TUGQ3WDl0WlV2MSt1NERYenR6UkdLMGMxUmdE?=
 =?utf-8?B?RllQUkVsR2ZubjB4S2g4UHBDekJQRGNrNFNBYXVta1FTME13dnIxb05xSlds?=
 =?utf-8?B?NWwyaVJ1cElWdVJOUjdQREtwUHh4dVZrREhoNk1GU3FVRk9lTnN0ZklGNnpx?=
 =?utf-8?B?bS8xWkxkMWtsSCt0QmNHSlNOT3kwYjk0V2FsdlR5RXNjRWp6MG1iWnZUUjhM?=
 =?utf-8?B?Q2lOUENiVUNTcjlUMFVsRVYxR2t2UUFVV2o1N09LeTFGTGlNOHJueG0vMGtO?=
 =?utf-8?B?clJ0MVpQcGZob0JiYzd4NjFsMHhEejFWaXVMM1I4Z2hqa1EzMFFLRzBoWllP?=
 =?utf-8?B?M2dtZmtVK3FHTVRFVjVKdmZ3SzVGZ1MxbDFvejRTZGJOOU1JZVR0QjJ5d05r?=
 =?utf-8?B?TC8yaVF1aWdmNTE1MmJpd1VJYUMwVStlNytUdERiWmZEVUxvbWpPNUludkYw?=
 =?utf-8?B?bjZaLzBqMlpGQlcrWHAxTDZydks5R1JDbWtFVWhIN2U0NG12ek5UN2U3TFdI?=
 =?utf-8?B?dWw1RlF3TmpBemtzZWNjcTZnaGZ1RlVGbkVOZEE1N1hpTXNaTzRzWnZSTGc3?=
 =?utf-8?B?ZW1ZWkNYNk1lYWdEM3Jua3VyQ2ZqYnNkd2QvSlRTbC9xWGEyOENNSml2OVN6?=
 =?utf-8?B?dThtQk1JNzJYTkRGTHNGd1ppanR3c1cyNWhXNVZOQjRTcmtIZmpDRHIzOXhL?=
 =?utf-8?B?VEVjaEYzSElDVmpvNDlYZmZBZkMrRlNhNTBTVU1YU2QvbGFnVGtaTUtDRDUz?=
 =?utf-8?B?Sk42aEVlWDllTXRtT3p4a3MrZHNZM1A1VzluSEQyckpoRnhXQlJYWjNMM3dr?=
 =?utf-8?B?ZVovQi9WSWxmcUNwMkFUcmNCblh0T01lNS9kSzU1ZlNQQlhqVVN5Y0d3bG1U?=
 =?utf-8?B?dzFMMFhZZGhwRUlkVXZveWZzZFNWbEhOWi9UWWdzVnd4REhIQXViWElqS1Vu?=
 =?utf-8?B?a2RvTmlKazlZVDdyYWNHZStLVUUxZGJ3bEhmL2RzYmE5cWNWV2VBQ1MyclRl?=
 =?utf-8?B?TnRMMy9MR051aTcyY0IxRnZwODZFUkdpSm5MQWx1NVVNbGhwRmpUQVhqejR1?=
 =?utf-8?B?YVE3Skh1MUxJME8xd2FHbWg0aUh0aVdLWlpBZGMrNDFBSkh2UUdUUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f100547c-bd14-4584-e981-08df46f8b467
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 11:23:30.4770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMb8oHW3Ufs5wG4N+dwB2BrP8x0Ns+4UGHi5h/i4MBr2qjphpistPUh0Wns+JE7APmGTokbLhBMpv4WwogeaAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2628
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed Nov 18, 2026 at 6:07 PM GMT, Danilo Krummrich wrote:
> Driver::Data is owned by the reference-counted drm::Device and can
> outlive device unregistration and driver unbind. Driver state belongs in
> RegistrationData, whose lifetime ends with registration teardown.
>=20
> The intended model is that, after drm_dev_unplug(), surviving DRM
> objects (e.g. through remaining userspace handles) no longer require
> access to the driver state. Thus Driver::RegistrationData is available
> (and sufficient) for all DRM callbacks into the driver.
>=20
> Remove Driver::Data, its storage and Deref implementation, and the
> unused workqueue implementations that depend on it. Drop the data
> initializer argument from UnregisteredDevice::new() and update its
> callers.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

With the const assert added:

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/gpu/drm/nova/driver.rs |   3 +-
>  drivers/gpu/drm/tyr/driver.rs  |   3 +-
>  rust/kernel/drm/device.rs      | 128 ++-------------------------------
>  rust/kernel/drm/driver.rs      |   3 -
>  rust/kernel/drm/gem/shmem.rs   |   6 +-
>  5 files changed, 9 insertions(+), 134 deletions(-)

