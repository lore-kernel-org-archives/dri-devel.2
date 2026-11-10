Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89719606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=je/U+3cK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8EB010F6C0;
	Tue, 10 Nov 2026 13:56:18 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55DFF10E93C
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 13:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KacYS0QtD7MEUp71hCpKzC7L5WHJYgSSADs+P3YkjC53srpRx4UuFKELOd8cFfsTYVTdw+LcH0uYRXGJW3Fpu+1+BUYxxbQYwt2ij1vgK4x70eL1W/HkkQQkRFY6ys4lGWsBvC2M7Ev/kvkhJM22saRrBpfPr3I8ZuULhtlLhsXrwXmn8BXTbRd5yK3ZOP7Vzluza0nTuhr1UpjcdDdNpF0+GL1/04LvPmU596shOAKe8nec50Asjy+IyPeBx6LBhbmwnQq8IeUwUdBnM9/HgdipGw5gvdatAQxPJHB60Zk4anQ7LUkI4A98qRpdIE6Aue4WhYlV0LRKKyc5mBbhfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2Ss8mRwxpTx+nRcWuR5/6cnwzhAhYW7DAbGbPEKu9k=;
 b=pVtEnJiC/DSO6zsivaZCkm7bbkW2MKbRrqi/kXr/oiYM+7tRLpOPemW6zonYnNrXhhkq/u3SoyVh4TRBH/P7VjiF8DxiJFFaQnAA37DfUCqoRIuwxEkjLBh0/WRZIojFnwoUgFqJ1bMmb7i9rTkap2FLeVMc/RnJyk03VBsVK0CiIQgIRhzTBs4ieJcg31Dl5MhECDy4U5puGXR/BiYOl3leN1/gDBoe67fuJohBkZo3YrXviY+seIqfyhwFDe9JgFvKvNDCPhGWXcJv4Whfg4ETj/WDwut1vxrWBfGWyTnLVUNuXj3i+b7VMB18y0W1vN6yIg+IRHANO78MK1QfLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2Ss8mRwxpTx+nRcWuR5/6cnwzhAhYW7DAbGbPEKu9k=;
 b=je/U+3cKCPAQDANxlz0NR0lQnbKJPPiZCdR5yHOdOzreSSSXf+rEM88+aCwmj2Ktp9kUEchVhvHwcOpdUGmLwS6JK6UMnFoE9JU7DHjxt/VbpFv/sdY47IhQR6xN3JBiIS2ylTBVJ2Cv/35MDmJ7V0VhrDSpsqzQwnvLVC/fdFivhVTOmrvGZ7DNfB/c4ilH6BY6o+UUeDA4/t2Fzkv6w+AudoottHm0pp7BKHvDFYAZpwkkWLj3rqnu2BLOkNDXV43StGmj05e//vNtJxFCMg97k1QrcCQHMcqDL5o9thzgQvPeBT14fQXXGCPVdLDYteARxNFAuOTE46sIM7uHHw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS0PR12MB999287.namprd12.prod.outlook.com (2603:10b6:8:424::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 13:56:08 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 13:56:08 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 22:56:05 +0900
Message-Id: <DMRKZL0RNSG4.3P7B0RM71I0CG@nvidia.com>
Cc: <airlied@redhat.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v6 1/2] rust: time: expose as_nanos for clock sources.
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Dave Airlie via B4 Relay" <devnull+airlied.redhat.com@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20261109-nova-timer-v6-0-5544a3bd8b28@redhat.com>
 <20261109-nova-timer-v6-1-5544a3bd8b28@redhat.com>
In-Reply-To: <20261109-nova-timer-v6-1-5544a3bd8b28@redhat.com>
X-ClientProxiedBy: TY4P286CA0016.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::14) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS0PR12MB999287:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c373bd-4b7e-41cf-3127-08df3f325eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|23010399003|376014|366016|1800799024|11063799006|4143699003|56012099006|261022105027099003|261021121427099003|261026121527099003|261028144727099003|261102123227099003|261009223027099003|261026140227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: PLmEfGP/IbydAnD4DX0DZXRY4MX4DOw29N66lHC+rNNBRGq41QyqupNJQ1RZkhbG/WA23TG10A5xOh+Izp+JnymHkWn1jjiIntVtKwVqiHk6q2t0hyH6jkPW4mOohsVuEYMEuRb4VMKSMLNswb3jDd1jhSjrrc+Zt4TTLAnf01xXnWxQ2MOHh00AA3k/1wyOkJ69EZnOXAHY1anB6cFmR6PhdrwiNa0Caq/+1qk9rZIZwIJSDtItKQ7S5LMNMUkJFDgeSzVmMHX+AQpbUPYg3gCjtwYxiheSuJxRpBxLySLaxorrznJExXP9sBYbVoWRqVGa/pFyYkVEVyAmXz6ZSMpjDXELeHXVqGJcxVQKFTGd5pCG6c9Z1vM6ZnCttisBDUXvFygaykguURcvsb8EWdnO2DsC+tuJVUP2hVadgxI3xIxQoaX3XUctSjq91NaEI/FR7AEvDTcsL6bS27IPMpvmVWlYVYbANcwBS6MUOlJUKhRRvPpIsDaVcGk469AT/PrUgTxTllaq6bA/SkPTvpR18RBXKD+wIFRflEUgiTB7beWHfgR0qczajL/m/rTGahXKNwE0aNqK2JidsZP/YaakSG92uCGuO/avSbq2yATpx47xovT8cGGEM5dsBuanX0dTEIpBqx8pbjpiHkbVWZOytH3VhIdEt9mgTQ7/WPo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(23010399003)(376014)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(261022105027099003)(261021121427099003)(261026121527099003)(261028144727099003)(261102123227099003)(261009223027099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFJab0UyRG1IcWExTis0QUk2TnBJVUFJZlk5WGZ1cE8vZUpIRFhEMXEyY01l?=
 =?utf-8?B?Q0dtT2RtTFozSGpGaktTU0JzV0JmMU85ZTZVRytuUmlrMzFJUTBQNUFnTFo0?=
 =?utf-8?B?a2hYRWhmTnFjWUR0eE0wWVJVNlhBb3EwWXlpR3FoV1NmR1laV0pSUWdiTE5R?=
 =?utf-8?B?dzJ3NkIveXZjbGtOdGJqaXhuU3pHK3lyRVlmR0svbms5aHZiZ0tRNjZoeVNU?=
 =?utf-8?B?UmtlT0NWVVVBQ3dUeVFWN0dnSGZMc0pNVzlJNjBwY0wrWXd4TXpSUTVOL2lF?=
 =?utf-8?B?d3oxT3JXaDcrUGFyK0hPSmhQamR0ZUloeTVqaEJRUDZ5Zm9XcHFqVnRGVDgy?=
 =?utf-8?B?TlJER0xhb3o2Wmw1ZThtRjJoU1NhR21UcmErL2NTUVVxdU43c1AyZVBwM1RM?=
 =?utf-8?B?L2dsU2N1NytUQXhldzQyQVdRc2RzRHpzT0ZzYk96b29udjZyTW5yOHYvU0I1?=
 =?utf-8?B?ZVFSNlNxWUk5d3lTTU95QkVwcm1rcVU4OVFOV2Y4SnVSYnozQUhDL2RSSkhR?=
 =?utf-8?B?QmlCaWNiU3BJYUQwNnVpYTloVml4SWFBdXJ0RmE0UklTVXN1SzY2TjUvU0d0?=
 =?utf-8?B?ZWZuY0lZeEM1TVFzUVd5bmgveWJBTDVSZll4WWxHcUNsbk9MNnFMWTBQOVdN?=
 =?utf-8?B?L3pnMkEwcHZCVW5OYmVKZEJMZHllLzN4N1RYK0E2M0pBRkJYV3krK2tZaVkw?=
 =?utf-8?B?b2g2dkh5MDU3QW5taVptRjB4RnFSTjVXcEM5WXNIaE12Mmw0QTVQLzRwMk9S?=
 =?utf-8?B?RC9vM2dCelFCQWRLYzVVdC9GSmRNWnZMa2x2MHdXbnRvUjY2K2xUc0Z4VzZ5?=
 =?utf-8?B?TnlDaVhOaHdTcEpQdGRMaVBVc0tCRE15QVZzcmpxN2xDWnZaeFRsVGlvU0hV?=
 =?utf-8?B?TlBsT0hERXJsakdlR2xLN3p2Sm41c25jYy9jQTFKMUJQa0JqVk1yWTRBNmlx?=
 =?utf-8?B?MzFqVnRIdDRsa0J1ZzdLc215WG9yUkNZcXZyNkpuaVE4UDV2SWFCNEFWY3du?=
 =?utf-8?B?YTBpM2IyYW8rYUtyT29HQ1pxQ09WbFROY3l5Y1E4SEo2T2dOS0lDZHpxR2Uw?=
 =?utf-8?B?Zllsc0xSZi9NV3k5RTNpd2JUUWY0ZFp6VnlQOThRZDRkZys3VkVzSW1ubXVp?=
 =?utf-8?B?M3pnMkpVUHczcUdndENIU0JXMVJoMk5OQlpDNFQ4ZHhxRmJFSTJNQ2xrNEV0?=
 =?utf-8?B?ZkNQL2ZsSWhsaFZicjZHeldINm9OcnY5cWo3dGVIYTEyY091eFVybzdibWRa?=
 =?utf-8?B?bHJGMTVZVDYxWWU0NkgrNEtiWlZvb01tNnV1NkRBbGE3N3lMTzRxbldHbXY4?=
 =?utf-8?B?RzVsQlAzUEFZa1g4RVZzemp3YllaY0x3L003V21RR2M4MDdySDVVL1Z6L2s4?=
 =?utf-8?B?SWF4OWZCbjZXeWhzS3BBcTlkRVVieDdPWWNRTitEeWFLZkY0UzNKcUdTeEQ2?=
 =?utf-8?B?WVVjcDZrajFueWZwUHBNZnpGeHhmY2M5bEI1RERSczRqS2JiblBzdzJvTTFR?=
 =?utf-8?B?VkdWbVZSQlNTVzd4TkZJTTNmY0lrM3Q5NG5mSVR3RkRsL3VZZzJQbkJ6cElU?=
 =?utf-8?B?RmZYM2Nrcm5CaTVZUFRxNXhPblJTWXNzb3JaZzBYNU5ncko5a1p0OW1QVUJx?=
 =?utf-8?B?UkZzY1pONTQ4RTFaeldiWGVRc2xTdUJlZkxzVW04VEFSK0x4Y0tWdnBFaW5L?=
 =?utf-8?B?NStibXloZTlJUkVsckt3blhralM0bVZSdGQxQVJnZjMwam5TMVM2YkFqMTBs?=
 =?utf-8?B?QkVTZ1B2UkZPc3lzNEEzZkF3U0JUUS81T3EvWk9NYktwRDBSYWczQTVUSWlI?=
 =?utf-8?B?ZHJVNElEaHdFMDlxbUZjK05zWUgxS3BoRkNXS084eXZ1MDZmZGxPSzg0N2sx?=
 =?utf-8?B?U25PMy9qSGR0cXVlOUlIeXVqOHBnS0R3UEpKaU1aVTN2elBBc2hoamxJdlhH?=
 =?utf-8?B?aFErcExIRmZDMGYwWi9uRXlkMGhpYUF4SVBDN3IwTXN6OVRtWThOek5KNWMw?=
 =?utf-8?B?NU5ZYWF5ZVdkUmMyQm0zNFNhU1JxczE3eFo4OUF6VVRHYlV4ZlNrSDkwMm9J?=
 =?utf-8?B?aHZ0K1FIN3RMMEJHSHl0RmcvOSsySFM4VFczTXlSMTNRbnc1Z1hyWCszSmxX?=
 =?utf-8?B?eUUrZFBFaVdOMGFGVldQUCtONEt5S3k4WDZtYkRvT2xBQU8wcG5LTVRZY1R2?=
 =?utf-8?B?WXo0Sm5PSHdUMThaZEtiZXhZbHdDcTE5N3dScE9ubDlteWJGZ3ZwMDdQUG9H?=
 =?utf-8?B?WEh1VjI3eUtkcG1hRUdGSDFVUXRPd0JaYTZCenlLYlNoRkh4N2tMcHFyUU5v?=
 =?utf-8?B?dy9Cc1puV1F3Z0NjOTl2NHVJWWl5Nm1zUENSWDNIWmFWY3BNaWdVYzY1Qmk0?=
 =?utf-8?Q?a1wTW6JQ/p1+nnR7kTUriX2rReSo5wRDR23qGhDyJP/63?=
X-MS-Exchange-AntiSpam-MessageData-1: a4fvHe0lKhLz6Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c373bd-4b7e-41cf-3127-08df3f325eae
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 13:56:08.0794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7IJpue1tnPKO1cKAD0cA3OhojVmrsApa4h0xeINW4U1myleqG9MewSBD6Bq395kPm9O8Y4WY8FHiReSjupPJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999287
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 9, 2026 at 10:55 AM JST, Dave Airlie via B4 Relay wrote:
> From: Dave Airlie <airlied@redhat.com>
>
> The nouveau C driver does ktime_to_ns(ktime_get()) to program
> the cpu ns into some hw/fw, so allow this method for rust drivers.
>
> This is needed for following nova patch.
>
> Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Dave Airlie <airlied@redhat.com>

This patch has also received a maintainer acked-by:

https://lore.kernel.org/all/875wyoydqk.fsf@t14s.mail-host-address-is-not-se=
t/
