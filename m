Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90013C44532
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 14:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B88D810E6F0;
	Tue, 21 Jul 2026 14:17:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="W0ZH0ipX";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020083.outbound.protection.outlook.com [52.101.195.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 292A810E6F0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 14:17:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxuqlUegDLGneATdHc99Q+ZZxB/cP+vkLdA+mLaxqpQxxQlBepaCD7WVC7up4MQpy9yoK/hipJmTo7g+dWKBel4o1jdPGVCCRzoz3zRAGUWZpcgetNRiGRWL2MhGpT4SPKJtOFVELOLwEEMRCKwESR6k26NlTXS90soZgMRveLYKoejg2FBGvjo3CGJjgF9x2yzG3+OpYUlOhjCPSEpoGaCOUfpg+QFTUyDbJaj/oXMMd+Uj4PdEN8QbJ/Vt9WElP/4vXGUgD0L1+W8AnD/ztrmqQSrLrXPCYtPia6S39zQUetv14+C3exF99J49vH9bCK5B7xoe6MdQZ+B+WOATyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wP573uT7GLfLxseyREnBV80ef2TgiFgq1VZ9sks6W/w=;
 b=sbMBV9+TmQX/J+kFopZLIxRs5M89WPry36tyuHZ1wPxy0QCxW0kgC/5kCuFhaMv34PXB07HcpYP7COLvPd5UF1Yxy0xud/4Z2S3AzuKYVs2gdNpuSif/m8b9csucDTZ0HfU424QQKb5kGjKkiAS8zz8RTWYOJ52LzE0s6oHyW3wqngJFJWg/n7KsBq7d7S6f7RBQuQVonITTm6A0ZQnCJGNRfUxseYMMwcbl3W8diSs/a7Dk2TmNDXOEC2J5gpPxun/mJQSMdXRkZu0Fb2shGawk4gif+q+4t3D1Y5FmnXQF9gMrFrK0GFa1pV/BVmvJ8WTrpZAt7cLqOfBhzsoilg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wP573uT7GLfLxseyREnBV80ef2TgiFgq1VZ9sks6W/w=;
 b=W0ZH0ipXrLTvcIkqMDMRIAAgC4dZX+f0HTBikL7rPrB9D2B5wkHWrfmwIYeVN/NktZfnGj0iROYovwydvw21IZO1UJ/7zzx3jK1Hf6WZ2zXuWZuI+kqDmbDNIenp7OvOBp835XFDn9F7gO2EhSC6bWY1xpFlr/c9XYenrUTsGlk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO5P265MB9348.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 14:17:43 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 14:17:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 15:17:42 +0100
Message-Id: <DK4BB4LQNZQI.O9099MATRI0H@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/8] rust: io: register: dispatch fixed array shortcut
 internally
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: aerc 0.21.0
References: <20260721-registers_fix-v1-0-3711b2317e1f@nvidia.com>
 <20260721-registers_fix-v1-1-3711b2317e1f@nvidia.com>
In-Reply-To: <20260721-registers_fix-v1-1-3711b2317e1f@nvidia.com>
X-ClientProxiedBy: LO6P123CA0007.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::9) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO5P265MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: 38606d39-657a-47fb-b5ff-08dee732d480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|10070799003|1800799024|23010399003|22082099003|18002099003|5023799004|56012099006|4143699003|921020|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: WuoVvTrjq6I2FpR3p7+59mJbE9xRlNUXqwZtXxbEPD64QktaZltxy/LCZ8iUFtmz+ofFq2hBirD2lGkGKpJJTUMEoC0SF2KH9SVk/HDEhjITwlR6wF9JMhGsiUxpgxs2PCeHEVyiUn2nG62HGaeLFj0L/N5bZkhU6f4k2XEUo6hoLuyUsnRYo334cIWKXF8y6a4SbEeac+xTq1LwQpfS2TZufLSFd1ws8BNOIFoz9DD22/CjWob6rV1Q7UFL0trt2Cq7KT1H8+kDEdOGt6rWuOHGmly8zDnv/iigb2qEPV6djLbr5tTrQYLJYx7Bo/MdIIoOJN5P7bxVvtKebIPhWdJW3RXj3LyHIaD3Wpg5lQK0Z00furYGCQiX4qq3MyAmbgPYr8rlOs3NDdDXRvQ/5UrKKwSaWbna7PdlZho0nE8TSHJ+zlmUtDbJNyDyHvwTyzk3nw/PGoyqSYNEncHXPppDe0WeZXhwOF5FZZ3w9iULRHWuMXar4vt9lt7HCzXiF4DRyYj8ab4TaUhbLFYL1aXj/LCyWYs0aE6lyAKMKkYaiznUd6UBu/LrbhuUe31lbXXO5JNYYL7Pu8Zq2/ByHTHRlZDkz9S3cdMmTRggVHfNXcTrxzpjJfvGH0jpR5OVz5vP3+3dUoaNWpFLl9SQkivjJAbpx17BWRxrho9dMAennYHU5izWechbY2vFt893klvnCwH4cdI8BIToP3X+CA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(23010399003)(22082099003)(18002099003)(5023799004)(56012099006)(4143699003)(921020)(10067099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEpjb29kVitzNUM3SUJlNmx3UFdEOWtsMnpCSWVCcXprMEhCOUV6RlZ5QXNr?=
 =?utf-8?B?N04xYnNWenlTV1ZnSGFCNUJwWTZjTGxuckFjOWZQK0RBQjlDKzlMaUgyNi82?=
 =?utf-8?B?Nzh1c1Jka3piQU1VQlFkRi84U0lzYmV0b09oZWxEbmFoY1loUzJqQ21lVW5h?=
 =?utf-8?B?cHZsN1hrazFWenFOdU1WeFc0M3NYODJVUnBEelFkNXEvUkZUdmlNN2piMzRo?=
 =?utf-8?B?c1hCR1p1VjMwemFRbFJiZTk4Z3FpQjBEZ011Y3VONHBvNjhOVXZ5elZwdU9r?=
 =?utf-8?B?NnVZc0ZEd0JPZDM0QitmbzEramljVDlhZXBxR1pPak9tSVVxSzQzRTRHaE1h?=
 =?utf-8?B?RlkwNk1MVXNxN3VONXJYZVJ4cVBDUFVNMWQvdHRSenhYUlFlUm0vMHViWmdD?=
 =?utf-8?B?L0pPR1dzVDlrWk1EeGtPM29KQmp0TnIwSHhZeDQveXlNcXBScmxPSlJBb25v?=
 =?utf-8?B?a2ErMVZNZkpkaGdsVjZBeDZLdm5LUlBZSUZoSzRyeDJKeTJpcmM2NmlObkM4?=
 =?utf-8?B?WHV0U0hrRlhWbmJUZmJNMG8vRGJjWjlaODlqWjBUZVRub2J5VEhGaVBManZu?=
 =?utf-8?B?NU5wL3hxN0tXcnhORVduYlV4YVB1K3VzT2tjRlh0NzI1TnVMYjlDWkJwL0xk?=
 =?utf-8?B?QmhGaExZT3IycXJtaDd0YTBWcGIzRFpaNkgvbTNQR0d2d3E5SGJaNk5DaDdr?=
 =?utf-8?B?dndEbjJRZFk5K1pscThNZ2g3V2ROczBrcHY4ZjQ5NE5JTk0xRDMwNEZvRXAy?=
 =?utf-8?B?ZFJtV0pJWndaZG1jMURvNGd0eE9HUG50YVVCTUU3V3hMd3V1UGNRM3ZQUU1O?=
 =?utf-8?B?RlRLUFhWV29aZFhOUkpiWDlTS2o0b21LQnBYTWg3NURkRFVKeUZzQUowWE96?=
 =?utf-8?B?bHJEWjAvRnVXYkVIbHVrTTdRbWEwRUlEaFNvTW9TUVkycWVMSDVNWS9XZ1Nq?=
 =?utf-8?B?cDQ2TVNHdFJCRkxZTElVemRuaWJYaCtBQThTdC9qb3dCZmpLMHNiS29LWEhw?=
 =?utf-8?B?MWpCS3c0RTA5eENOaDRhcm15UDZUVFFvcGJTYVZNYTdqS0xjdFcwSnl3aEpM?=
 =?utf-8?B?d216YmFJM0RvZGp3RGNUeWtjSXRCWGpHMUJIbVhSWnU4NnA2QllNWDFCTWNj?=
 =?utf-8?B?Ny9ycWoyNDFjTlkzUm5UaE8rNCtDb0hzcFJZQlRDODVkQm9yeWs5ZGo1dXI2?=
 =?utf-8?B?b3F1VkRUd0lSeW55TUhXZlFLOFk2TVFHaTdpZU9qMjNqcmh1Ylg2U3JteEVZ?=
 =?utf-8?B?b05WS2VQbmxBYkpJaDAxbm5qT1pCam9Db3R2SG9lbE02U0IvVHA5QUh0RnZu?=
 =?utf-8?B?OG4zY1R4WXJLMGhtYUtuNzU0RnF6ek5NdjFqai9PSDN3Vkd0cGphNzN3cEN2?=
 =?utf-8?B?QkQ5TWlseERERWtpUU5zMWNURmdLeVdWcWNsU2pHM29GWTZ3Q05RMHJiaVBU?=
 =?utf-8?B?VGlkczM2SzY3aTErNTVIM1FtK2pqc3pCWWxrOEN2ZlZhVDI3WjNNSlczTWhQ?=
 =?utf-8?B?cDRFTXltRmJBL1NYcEN0ZEp1OGU1aDN0ZlltZGNIKzdjSmdmbW9BbUpvMnBZ?=
 =?utf-8?B?WmNuNmZDUjFuTDYzcWRyai81bVcvaUhJMnZCMmtLQ1JYYWh4SW94UHV1Mk9F?=
 =?utf-8?B?dDlWZ1pKNmExNWhwN0Y5VXBacGVSM0h3T0dOdHRMZTArZmw1NENBaE5UNS85?=
 =?utf-8?B?WmpNM1QxdnBLckhzcHJyNnJOL0duV01rVE1idXlvV1ZUcEVOV2lLaGZjUHc4?=
 =?utf-8?B?ZTlGTzVUcU9aeGthTG1meDJPR2duN0ZjazVydGd2a0pKUm5qQ2ZaN3Q3TWcr?=
 =?utf-8?B?cWh0NnptdWlteGE0MWJhTkx6U3RuL1c5RDZrM2kycEVrWkZoUWRmN3dWUFl3?=
 =?utf-8?B?QVRDbXZBcUZ4Yy82Q3NxUHdxelNCWDNVWFdUV2VkdGNlNzVmbTFuckQwdzV5?=
 =?utf-8?B?MUN1RlRJbEtCZWNZT2Y0blNKQ2l1OS9VRDVhUE5CTU9tMjNzdDNDbEFFUnhL?=
 =?utf-8?B?b1hRSnYxZElxMDZnS3V1b2FXbjJvWURZQXFmc2xYRThVZy9VbkJJU1FCYjVR?=
 =?utf-8?B?Ym1NZkZIQzJiTVZzVSszV1N1VVQ5UzFlUXJaTnYwdE1TLy9iVldvTWpLNEZQ?=
 =?utf-8?B?MXlNcjVpZlo2WDMzZnA3eGczdUNUQjJUVFpCeU1CYjI3djlkWDdkZGplcWZj?=
 =?utf-8?B?SWJPQnJEaUl4N3ZBVk9FdldBYXRWbnpqMDlXTGwycnN3N3d0aWRHNVc2NU44?=
 =?utf-8?B?TUYxK2hvc2tlazNnY3NJUzM4T1FRWFNxNHhvVUUrMU8xOHo2c0ZFV2hJLysw?=
 =?utf-8?B?czhZU0VYSzdITlduVkMycGJzNFhldXg2RWxFd1NCN2JiY1RKd0xkZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 38606d39-657a-47fb-b5ff-08dee732d480
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 14:17:43.3788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZaPpREvKerO+mFSYrQ6YKxqpOTalzCUoW5x/tFqhMgs0U1unxdlnE7t/aiJNOZm/OIgDWv37kTYHj4Idzxwqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO5P265MB9348
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

On Tue Jul 21, 2026 at 12:00 PM BST, Alexandre Courbot wrote:
> The contiguous fixed-register-array shortcut redispatches an already
> normalized declaration through the public register! entry point. This is
> unneeded - the public rule should only be invoked by users.
>=20
> Dispatch directly to the appropriate internal @reg rule instead.
>=20
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/io/register.rs | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

