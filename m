Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8468C606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=iHtVQIKZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A158410FDCB;
	Wed, 25 Nov 2026 16:53:37 +0000 (UTC)
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021127.outbound.protection.outlook.com [52.101.95.127])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22F4910FDCB
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 16:53:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5CK6i88faNQDgZ2xATkbpQq/JK9OYog9V8Ekp6Tuni2JmKqfOzD3EYJtbRg+EURkPhVF5iErPgdu7xSEqDx661XiFUzSIE0ydjda+QOT9nVivK6aGelK4LlaVrEC63CacXgDqA7DWZcM85ZhD1arkk39Xi4Bszwjkc4hBRREAZ1eaDXNMtkOD3ulC0wEaH42LZ5WbRksPt/VL2ki4+3OqSWi9T+mxmFxJ8zVpCRm+58YwHHx4fbPfuerNgOowI6VDylBquPGJwv9I1PvULAa0Ww0LlksiyCUB5eYo5XvXvRLQABLnY9jHFoXIdTSSbfyuBHFxezZJtiwA6bW56DxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1DeFKwl5LHVEjRCvUOKEkHQtn4CUSJGo4Pb1WRyoOM=;
 b=xL31JOP8yDRS0C2AoA7TqS+HohZB/pdjkAZneGCW5++1OjC5OFq3FdiZtA3KiQVH90EViAWVDZnHVkkYf9RTK4wB0Z9M4obLt02Dwxoq8tUM+CKi25j5ug1dqqdG0sp8/ev8TdV3lIkhD817szmkjM8oDmKhWpNX556jfMMfqP0U7BXPxFGNuj6MpbRRFsgi6KB59/p56BQEkJXH6Z9tbWk+10T0x57ywL/3YZ2jqqz0W5YTdL2kf+NBz6W/5he1GfqBx/qacxBAN0vqxenMC6FtOTb+zKtSkQn46nM7zAi8KqhQmZP/r+ALDAVSatrV0vh90M6lXEGJ6Lp+ojey9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1DeFKwl5LHVEjRCvUOKEkHQtn4CUSJGo4Pb1WRyoOM=;
 b=iHtVQIKZ2ztSo5PDnusRHU0nxI7IDRNQ3/gVkExzSHEpB9GELP8dEojruCujiMfJF4hg8LTqrqwKw5uZYNtqfv+9copIsot0qDWOigTHaWvpPSBH2uxciP/hqddOiAYJ4LmD0N3/0AuJXYx4lI57/INZY+QMEVBsyI9132QRc2I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by CWLP265MB6198.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:184::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 16:53:29 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 16:53:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 16:53:28 +0000
Message-Id: <DN4G5KK81N6D.V4ARNT7YZWRO@garyguo.net>
To: "Philipp Stanner" <phasta@kernel.org>, "Matthew Brost"
 <matthew.brost@intel.com>, "Danilo Krummrich" <dakr@kernel.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, "Alice
 Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Sumit Semwal" <sumit.semwal@linaro.org>, "Tvrtko
 Ursulin" <tvrtko.ursulin@igalia.com>, "Paul E . McKenney"
 <paulmck@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-media@vger.kernel.org>
Subject: Re: [PATCH v2 10/10] MAINTAINERS: Add drm::JobQueue to drm_sched's
 entry
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20261124122951.878199-2-phasta@kernel.org>
 <20261124122951.878199-12-phasta@kernel.org>
In-Reply-To: <20261124122951.878199-12-phasta@kernel.org>
X-ClientProxiedBy: LO4P123CA0440.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::13) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|CWLP265MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: 935fb9ab-79c1-47f7-978b-08df4b14a160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|10070799003|366016|4143699003|22082099003|18002099003|921020|10067099003|56012099006|261026140227099003|261022105027099003|261022075727099003|261021121427099003|261028144727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: pufIBvNhDYv8pzSHKTFmuxcO+K7P57NQnCoVU5QJPlm1W2hzIiiKBVE3xMMzk/FvMErnU/wMF32HB0ZMTMvYXhXdZiNtLjv0voEOer14TbX53pqdlpPR4XGe4pH2LVCKOVAw+cOknC7QvVKWnVwhwmkIoCpRwRwTng0gUpfOXYbjYMxb7tdL+DZJUbm5cVgI5kdQlfVEWcVFHoiPDsqwjnKyOGebe+Vy+GjPR065YrFfNRVFvkatgW/Pkm+/go4hDZnX71DJf2GWP0wIWgSscx6okPYEq/07URWlzxRT+9b0KljeQpcD6+y6STfVr/acSY+KeP1rUqSVGicYLp0eZ8rDFc77kfmKnXbTQJRUSbVR4O1fGiao6Zxj3DBry/i5PbKp4sxJnSmzX5MSTWLsYWdq2aJKI8eWtw90wQYrIPHqKgg2kscOeNj0QNjMwFk5Pl+0SsJ7Sj7anx0j8XAYQ7xdn9q21y90LUx+J+6azLv6cGwt6p5Er2KQYgdw9qNLEn2rftOkdDxJiI5QrNoBe3hhUiq74JPfnkvcJthx1yEoRiuspPAVeKoFmFNPrXnnzwZ5gfe4jxlIg3r5KRuf7RImPRpJa5VyZXRYD+wPqOiFVkS1uiZSQ/TlbXMJ6LYaO5pEzDmuYol4Ovgn2+HBF9igZ6cGrpbpm5Uy9MUtgKipLA4PTJNPrHcsR0HZ5uaTV7GMHPAjXjSoHxyrM75Kzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(10070799003)(366016)(4143699003)(22082099003)(18002099003)(921020)(10067099003)(56012099006)(261026140227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHhoVldENHhSWGV3TTBoUVdHcnJVVU5Hemd4dWE1b2l2eDBNNXh5SnN5dTV0?=
 =?utf-8?B?VGdKMTBOR1NQdHl5NU90bW9ydk01NXAxT244ZjRiR2ZvODVJVTh5WHZHOUJ3?=
 =?utf-8?B?c0sxR0lvak9ndkNPLzRkcWVKbFJXSVdldG4vWXVBZE54QjJaUlpJTWpEa2pn?=
 =?utf-8?B?a0NJUHJKM0hLeDljNmZRYmYzQi80dGE1Z1c3cnl5aUFYeHRKYW9Vd3FJNzVI?=
 =?utf-8?B?NmFOYUg1Y3BVaWUyTXVnR0dOeUQyQlB5OXZoZld5b2hQZGJ4WnpHWlZkTE9P?=
 =?utf-8?B?bXlnNlZKb0VORVJpcTZXd1B2d29RU3NlLzNXRE50V1R5SmlGdm9jd2tET1Jj?=
 =?utf-8?B?eEN2bmlUb01kSkFSblBFU0p2NzBUY3NXWXU3VU9hOG5hWEdQa3ZHUHk2WVVZ?=
 =?utf-8?B?WldwZWdqY2lsOXVwanhmMFFueXdwU1RXWit2UFV0R1FVd3FhVk83OVV4eHVS?=
 =?utf-8?B?WUZ4UnRXUytGb1FLb3l5TGxjYzRVRWp2cHpOTnJzZFBnd3lFaU1TYmhoVVVl?=
 =?utf-8?B?Ny9NUjJpUkZkTzZjUEVGd2hpV0NqVWZWSWFkYWVWZWcwMUltVk83NWluVXN4?=
 =?utf-8?B?Zm85S0IxTVRvMzdUV1NCMzVhT2JST2o4WFh3SVcwZ2pyRjgzb01DYldqYWN2?=
 =?utf-8?B?L3ZiNDhNR015a3ZVdTUvRVZKbmZZYzJreVd4b2FyL2JIUG05TUVUWTBJbkJM?=
 =?utf-8?B?VC9tYlJZcm5HUHRBdkU3eHdiQzZVdzUxTGwvYWY3N2VrV1BvbVQ4MlNGdVY5?=
 =?utf-8?B?c1hxYWFUdFhSd0Q1N0w3Sjh6UmFpclpMaDhUQWMzNU1KYkhPR2d3MjRVMWtL?=
 =?utf-8?B?VVNKYzlTS2UyZDdRVlVoMWROcklXTGhqc01iZzVJV0hZR1dDdURnUUdYVnNK?=
 =?utf-8?B?Y2pRcEJWeXpBZktSQ1dnUGdteWZHN0FORUxTb09iVVVSSTNzeTJVTTkvN0tX?=
 =?utf-8?B?NVRRcXpZQXNUMnhnRTZqajljNTV6UzV2eUVqcGJNYmdkdjlwUWNrQWQvSVdI?=
 =?utf-8?B?TTVQRDMxOGdtNStGcVdPbE0wT1lRejVDOGRTNTFvYmFEM3FEVFBxYjlEWGEz?=
 =?utf-8?B?Z2dJZVpOZWpOZVM2VzlxK09YMU5TQThQZGNrV2ZUZFV5S1RKZjNqczRIZUZC?=
 =?utf-8?B?aFBkUnp6QU1qSk51UGt2UjU2bzZObnpQVmd5eXVHbXI5UER1d2pTeHY0bWJV?=
 =?utf-8?B?OGFueG92NmVidmZ3RjNPZTh3d1lhekVRU0lneW9YRUJLSmtvK0FCUlVqUm9Q?=
 =?utf-8?B?MG1IakhzazhiRGhIYnBiR3hIWks0T0lPOEJlQ1NZT0pwZm5JRzZvVkhicDhy?=
 =?utf-8?B?djF3aGtXdytiUE5uazdpV0luMXJVMGQ5dkQycm51czVWUjRsQlJKQ2R0MnBS?=
 =?utf-8?B?L3R0VngzVDRPaTFxYjNwSUt6b3FOUUxueHBZUDdsOS9xVmtKN3NuRUtJWlhs?=
 =?utf-8?B?dVFoZWpaRXZmdnlhTHNyVnJMaC9OejBlV1JMcllaakJicEJCbHdHY3J1QjBX?=
 =?utf-8?B?dFRFYS96UEs1VmJhNDVzY3VuL2E4KzRRSE9jWEdXNHpLc01xN1BMQlVDM05y?=
 =?utf-8?B?dVNycVEzK2s0SnNkK1R2QmhqSkNjc1h2K0p3NUxJT1RpaGUyNEZ6L2xHVU8x?=
 =?utf-8?B?WWVTKzJIVnhqR2ZHWWhsUmYyTWY3b0dNeTNMUUJVakVxV1BVeCtDNGJxdG9R?=
 =?utf-8?B?Y0oxQlU0cXBpU29kb1NlTGFlVEFKZ1ZWL3VOK1pWaGJld1FGSXpRbFJ0dzRl?=
 =?utf-8?B?Qm1qRnBtMmdjSFRldFJZM0pPb2N4Tk0yVm9LVFRMNWN2MXZOWjZDSi9vb1ZB?=
 =?utf-8?B?RTBya0xWZFEzTzNEbE1MRlZjQzdQbStlSFJETThYcitla0hwQXdEZ2QxcFNV?=
 =?utf-8?B?SHRGU1J1dW5XUlpCdXQxTUpIUkg2MEQ5WHpOTUNHZGY0UDRGeDhzQ1hWUEtN?=
 =?utf-8?B?V1pjMHpCZlpGRHQ1eUhkZUV0bnM1OUEzQmR2bmRFV09ONHJoZ3hwY3BQMy92?=
 =?utf-8?B?QUhRekZzU3Z3dEI5SXhWc3FnVy8rdzlLbkJhcHZNNG1sV2k0OURDbVpUMU5n?=
 =?utf-8?B?ZjdsZU5abDliYk53UTJpTWI5N1poRFdZaXk0T2I0OTg0REdLYW1LOVJFUHNn?=
 =?utf-8?B?NmY1QmtYMUEzdXVKNVJLSXIvMlM3RzJwTUxCL1BmTXVRamFvVUhlOVFmWXNO?=
 =?utf-8?B?bEZqdDU5V1NSZE1MeU45dW1QZUREbW1hcVdRNEdYdE1jWkw5ZFdMRkgvY3BL?=
 =?utf-8?B?cStIVW50cXNJQUdBZGdpMFJ4VHQyTWFJNForeUJkQWI5UWZYMExZYldFek9H?=
 =?utf-8?B?cm8rWnE5VE8vc0JFQSt4RnJTaUtBWC9BRlV6Smp6MnZtNWY0V0ljZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 935fb9ab-79c1-47f7-978b-08df4b14a160
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:53:29.0128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5m6CUVGb5ItpnnCS2c4njRqhfrDjtn1OV2OYwNCf6jar5RXt/JqlmPZ58mBn5aEYYN3PXXtZNVRWAiaRyyqYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6198
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

On Tue Nov 24, 2026 at 12:29 PM GMT, Philipp Stanner wrote:
> The DRM subsystem now provides drm::JobQueue, a Rust dependency manager
> and load balancer for GPUs with firmware scheduling. Since it resides in
> the same problem space as drm_sched, it is reasonable to maintain it
> through a common entry.
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

