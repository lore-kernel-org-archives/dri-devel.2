Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAD7C43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAB1A10EDCC;
	Wed,  1 Jul 2026 06:46:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="koVp/hSc";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B15010EDCC;
 Wed,  1 Jul 2026 06:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pe40S/yQ5ZkAbqhMcn4pMu6D+f8EsbXZu0x1zRSFUCuHW7236hvsJC7KQ3UR3Sry3Yk5aVcZNMWH86CK3hSQuxz5H7Dzlz4yqdj1rq9zf/XJMfNwnjZA4NiPEwscMOurT06ETCAUjurGAXPwhG2H/nZCk7yHcY7fhK24rc/pW1T8dI8rtiztlbhutVFmbXn7M6/bUKKeQcEGjm2rA1UHTw9f/Qsrh+BwEuOwBwci4dw9w5CcAGCDqAjZv7zKp3c1i3dI4VZALd4Zy+CCi/MhyjFyTwE48IEbApoc4yptLUCVif7TMq+TC9g8fM05kQjDEf+Xu1k9+Z8jXWB2P/mlrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akfKWqDfCuiR2UMMgGtVl9B5rYRSZv6eC/SJreRTqPg=;
 b=P2G6DsY3irPY7sShkjXqQKLmanAzTZVvArx5kAB6IQ/26Qu7IcMMxOecLIP0PfGiTCwytwTNwB3D0eUunLw6GPYZwqDFYEBiXlTx5cfNr+n0x/jEZnqcJLhTAHxHwDDJPRWGmRqc+i7srpQIa8sJssHY9gE/jcbPx5oDUD9/hOUSA6Y50siUlFNw+lSK9uedhYHnJ+UobNma8+5wo2GvYXfq4WaFZO4iyIoRaB+/jyK0ZOgxdzFSAr0+/pF33h6mbpSOCpndeTg4FV8rbvUGLR2tqOKuwyV1aJLg5cyYiWbq4zzLGO3nTbPelOTcWMilwdiGaq3R/59LjNg5VAwXPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akfKWqDfCuiR2UMMgGtVl9B5rYRSZv6eC/SJreRTqPg=;
 b=koVp/hScsUJuPiFIHDq3uw+Exfv+B0tJdJASOSCU/dRm9S7znxcTsZihpvTKdXY7Tx+8l0qO44u2fiPJ+utz3LrqXUrSPcAxwaudLMA327rPpqiRf8GSJ7/ZmtSiXn97jPz6Xpd4KjSmm81Ev0E0dogHC2+PPoKu2eCkYcvTyTlZVe/E6fhseNWGlBCcHbI203tyf7BsAaT22hO/HRQvWvy45Y3Lww8pRvA3FjLVlbYHCQnypv/X2fMBGIK3ecF96mV86/5uX/qfqjp+IsjWRqHRdmyNlG4aqwem3ZKkVf281KXZ7smmzw8K/jIrGFaWPT21SAzke8avSgte+AXNdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ5PPF0170DF9F2.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::985) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 06:46:29 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 06:46:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 15:46:26 +0900
Message-Id: <DJN16PTQXXXM.3HB9HGBHZYDNS@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 13/13] gpu: nova-core: store Fsp instance in Gpu
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
 <20260629-nova-bootcontext-v4-13-5539d8469590@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v4-13-5539d8469590@nvidia.com>
X-ClientProxiedBy: DS1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:455::13) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ5PPF0170DF9F2:EE_
X-MS-Office365-Filtering-Correlation-Id: e11b78fb-d931-49b4-bda9-08ded73c7af7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|10070799003|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info: H29CeIz0VZMIo0nEyayGGPUPlQV3c1mrjYKSipT0bHPTCyjSHr79q7ieDfDP6BB2HRAMKxGJMmqAVQ2ZBv1GK+ZuUhG98bHbwSHTJjBzSxGkea+ciqMURWQnNTauB7YDREpobKt//j0Lg/v2gicE0nQaAshnlcN6pRcoRFEH/p+1ksPbVy9gpI6b0Jry488CMXN7crly/6okJwE8GcSg6g/mYuFv61v0DaKZXzcVhMrVi82xeUiHf/6y80G9QcA81jmhGaktu0jJblxeyh+2gubqvxImokNkvnIs+N5Igyhe/A4VhxJ/3EnnnHhMeNhoY8839EWi50eqFpoBOZps7QzdaO6iFvts7P1iAH8uCTpOc6n3K9mqDJ8l/da06VQHJgVKoxtXDp6kDvwDwXNHzjcEhc2loMVE9f+Q9aEtGBCMmX5CzRGefEYFWjedKYb4w1gQ7XuITG0TqkycYcGsTOq9I/MLsMK1uUfhyqLBG8/N9forUJArE6kSHT/8OUyNPMwhMgcwekOe1lt/SmEFweSBJmUAyFMX4Rbne3xdAlbft8zDiyZAX7JvVJEvrDzZ15/59dNfq0b1f7U7r6qWgP7YGY43SkAgC5BPX6+Qhj7XEu7lD3Wv2wvBYNIERlg2mbJD4tXysDvCbRZ67oNHkhZP+vwVZdW14EHKglk4aMyiG4gurRMBqbPAOh8MfKiu/K+Iz5qRH0woHhAbcVQTKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlZxVmp3eWxDeWo2YWVFTDJ3OVg5ZzdlQ3QvNUczVy81bUU4YnprcVlta2Er?=
 =?utf-8?B?cGFVN1YxOWYvNXV3ZVYzdjZ6UkRrL2JDVVZIZGZUa0NraWg3eGNtUHNjdEU0?=
 =?utf-8?B?Z0I5UFNWTVFWKy9NVXQwOWE1N1dUaXV6MDdOQnFGUzlyZVlOdzBhcWRMbHlB?=
 =?utf-8?B?R2ZDVmVsd2NUdVViWi9KWER6OTJPczBtaHV1aVYzcDV6cmx3UjhSb1VjL1ov?=
 =?utf-8?B?bDJrekV0ZUJNTWJCbEZJeFFQZ0RMaFE3eWpyY1ZXWXh1b1pvaElVOVBvU2Zt?=
 =?utf-8?B?dW9vVTZpdTB1M05IUFphd1R3WmRoOFdXQWFyNWNPb0J0OCt6RHRScDVVTDl3?=
 =?utf-8?B?WU0yQlRuRm8yVVJybnpOSEhpNDlYVk9rREM1YTYxUXBTMkZqQ0QxQ2tndm5q?=
 =?utf-8?B?SERQeHFHVW1qQjdnemk3UFRQcDM4Wmp6ZDR0eWhLeHRybm5sRWhOWUFMWm50?=
 =?utf-8?B?anQrUHBSSFlrT0hYbjZBUkkyMjFYbGdTM2xwai9xdFBPbHdVLzB6eXpqVCs5?=
 =?utf-8?B?cW85aEEzNWRxamZObjgwMjM4L1FxaGVPYUhoOHYzRVF6VGtUZUlUQkNaK3hn?=
 =?utf-8?B?cW9aWFp2V2VMSlU3UmpwR3dLVldXbmVBTXhkdDJsQXl6dW1pVnVzM1Zpd3l3?=
 =?utf-8?B?alVUeUdWQmMvNHAveEp0N3lwbllucSs0a3FrcjNXRk44M2ExVmdSMkU1RVh3?=
 =?utf-8?B?Mkt2RGJVRHNSOUU2M2R3MFd1cGdaYUdINEhsdG5yTXc4ZEx1QVpSSmJsUHZy?=
 =?utf-8?B?b1cxSnEwZW1EMmZUQUFvUEJRV0RWL3FOa2Npb1JwZXBOdWdpNDg2WXgwa1BM?=
 =?utf-8?B?aWNzN2Jpb1FqWGphbVphSGhaUTZZMkEzL1F1ZjlCZGQ3MHBNVTF5UDVpeGl5?=
 =?utf-8?B?R290ckoweUQyUWV1NmtvN0dHNFM0MjFjZHZYdWoyajVYTEZzWEcxc2YwUzd4?=
 =?utf-8?B?eUVwejRSOXdvTEJDK3ZqMkE5OUZ6Qk1ncFY3VDBMQ0E2SkpEZkVGNUU1MkY3?=
 =?utf-8?B?VkJZVWhKZ1FhZzF0Y1BTNk52ZVRhc1Y0OG5NcWZrTC9aWWt4MHBlZ1V3R0Mr?=
 =?utf-8?B?VFZqVjU2QTl0SjVVQmlDd3JZSmo0MjZaR1lQbEhTZFgveUMzM1hvZWZ1Nzdl?=
 =?utf-8?B?RkdGWklzdHdaQWYvQkVRNUpOeG0vL2x1ZmRjd3htUTVSTGxDWXRsdHQ3OG05?=
 =?utf-8?B?YkVMQmVrN3h3MG1sVjhQL3dBMGgxZkQxQWFiOEI4b2VzWWYydkd3RytjZDJq?=
 =?utf-8?B?WGpNcUNGS0pSb3RadEpaTnREQStYc3NjSEtEaDV5SUw5cGsvdDR1RVJTdWhu?=
 =?utf-8?B?WFd4K0VvTWVhUDdVT3Nad0NHQjVYejZLRUh0QW55azl2UGFZUWdHTzNNenR2?=
 =?utf-8?B?d3JvTjRrOWI5Sm5nUTVNeVZETFNLN0pSWWZGanFxTndRUXFGKzUxdVRBVkMy?=
 =?utf-8?B?a2F3VTBxSTZCZkhUeWRvZmRGT05zN0F2NmU2djUwcEhkTzIzSHBaK0M2ZjFX?=
 =?utf-8?B?MWpmNEtIOHNFUENyRFZHM3hVckpXeUdkZEg0eTkxbm5vSUVxbVQ4VVBIdGpw?=
 =?utf-8?B?V1dwYzlvUkU0WU9reitWc21aVGRKOVNzaHJMQmFjcUFFNjFBa1lKd2hsR28x?=
 =?utf-8?B?d1JKeUFlTm1wbmhVMjVtaTdOWElTVmx4VWc4UlFVaU15YVZDcDYzOHoyZ0lK?=
 =?utf-8?B?eExaRW92L211V0hteFZEeHhtb0NBbWNBVys3WGtuTnhDTmk3azJ4ZVhvUGFo?=
 =?utf-8?B?QUUxUDZJK3ZSakZoL0VEMFI5ZGlSdkdabGlTbDQ5NDZrRU4zdExOZjd5VGtl?=
 =?utf-8?B?eVRvNFR1cDVSQUN1d25reVlLUmZLK3ZBbldjanNrQURIa2QwQkN1R2l5Smhx?=
 =?utf-8?B?VG5mUGxSZGtmTHpWa0pMNXdLaTBTSzVORUZCcVVNNU1DR01jSDJEanoxbXNF?=
 =?utf-8?B?aysveFAwQjYwS05QMWl3Y0ZMSlJrWnJuZzdNNnhqY2ZLV2ZwUmszWGRwMUdD?=
 =?utf-8?B?czlPRDBLU0dhTHBpSkRlSGZMRi9PN1NTR1c2SEhkYXNVRlJzSVRWZmt2WGNj?=
 =?utf-8?B?UVRJcUhIakVQTTBkcDB4S2g0WWtKSHBDQTBaeUZFME1Sdjl1eHlqUEhjSW9X?=
 =?utf-8?B?OXZnTnh5UVFRSmFzK1dwMEJ2ZjZzcTN6MXpsaU00N2RldXEzM0Ivb2hud2R6?=
 =?utf-8?B?Rk0zRWYxZ2xuQU1VdjBoVFd3Yi9RVGYzQnhyRHU1TnZGL09YY1dDUXM4MUpH?=
 =?utf-8?B?SldSai9sVGtmYks5UUNETnZldVJYRzlRNkcyUG45OUZQNFZNcStLUy91S0E5?=
 =?utf-8?B?bm5HZUFodzJUY2tIaXBNUXRZUTlPWitlNEVWbXVPTmZURGxPVkJoS1lQSks0?=
 =?utf-8?Q?BCDy5ESTlt3kRPTm8oFcYVwoZbaez+DweJbS0q45SUcPt?=
X-MS-Exchange-AntiSpam-MessageData-1: 4apK0LQUjfLX8Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11b78fb-d931-49b4-bda9-08ded73c7af7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 06:46:29.5709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJWSyc5FkMJ/d91gwqIoy6xdwJbyo5ShTlST4EOhUrboZFygw24LOPA7fTZFBPAPfRHTjGCxRltDoqP6md9jwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0170DF9F2
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

On Mon Jun 29, 2026 at 11:09 PM JST, Alexandre Courbot wrote:
> The `Fsp` instance was only used in the Hopper+ boot path, and
> consequently built locally (and immediately dropped) in it.
>
> This worked well as a temporary measure, but the FSP is a GPU
> sub-device, so its lifetime should match the GPU rather than a single
> boot invocation.
>
> It will also be needed in other parts of the driver, for instance vGPU.
>
> Thus, create the `Fsp` instance in the `Gpu` constructor and store it
> there, passing it to the GSP boot as a mutable reference using
> `GspBootContext`. This makes the `Fsp` available even after the GSP is
> booted.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

