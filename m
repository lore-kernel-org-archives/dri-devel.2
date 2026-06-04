Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DC1CD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6BA8112A0B;
	Thu,  4 Jun 2026 23:44:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="faoSzk/n";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011069.outbound.protection.outlook.com [40.107.208.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52871112A0B
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 23:44:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJIYqcI3VGCUdZ40QffSgo5Ja9kwbxgYYc3TlWwHJugk06DhcCHCfIBC8nAzbyQimKxkCK7FCB3qlzKMWlWAPid8N6d20MzW8o+I/rYvXvBF5jePmzKNMnpZe6fy+j1Lne+OdlkUwv7sviDLSuKLBem6LtEZW4YgGBUkOkB/B++nWvgrwFuQtfybg7Jgc0iRtwqUYfhyE2J4fjDBy3kblXxZe4/IUvLJkioSEz+vbOOCGW3m5S8Bnajv5BSXsupERhfhRdg3tr/K3jC/fgid5JMb1eWZL2B5kM2vi3WrVOv5Yt/PTOMd9b9quUjiUbfQyL3NCwvD/NAGmAeqc1QVrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCMlIYpJH6o9j792Z2YSnZCVmNIF3ZS8chSUErA2lSA=;
 b=o/FIavV9ge3UYC/LJeNZfxvuYDAxmDatJyh/RJ56Fk8Z6da669PssJ7W5uG7XnUYoiJGlSPkiB0TdYRvxLMQUP7JwiIBuI24je8n6E7e8xPG3cw5RlUBJvHdvZpaKOCrz47I17cLJ4tbU/DAYC0V0XBGUGcam00eBFDQFhFc8fIYAzW+mFf/oTQ3KRyddqTGZja8CFZ2whs4Askq4PiBf/wvQVTHGimwADQCRAUQ8+LHBrvLpTQqfE3rYqyXiknRzAblmgNoSFKnNXH+HrIj+viXADtqKGah3/X03Fb0boeNuVpVbjNjq2OegA4J6jHFvK3jqWToDRZwnqAUnXSFGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCMlIYpJH6o9j792Z2YSnZCVmNIF3ZS8chSUErA2lSA=;
 b=faoSzk/ng6y7tPVlswhMa9G4wiDBAB+UpvR/J3zOUN349p0PIIbKWXbd/CvzjarLUgEqtljw//3l/F7syFT3ubjVTiqQwrbtZ/VU3iOX3xWib2hQ4RZCe9AFz6n82CFobeYigzNf3JnT4mP72e3aBVumLIr6SxgMOpUhyigHPN+mFgICKm6a7JNq7TsB4L3pr2JFiscROB8wAEZRvj2IZ598PB014kGlAZvMEM1ncaiaFNTt+N+hezBJXK+zxVnGxmNB5U+tU8CSBzCVPpkmy8+57+x20lmV9QTxzrDqGOFH1+/UK1X7GTlqoNmTpKCxVKW+yV+YgUU4TqIlniBL+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 23:44:51 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 23:44:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jun 2026 08:44:47 +0900
Message-Id: <DJ0NXPLOU9QB.3T1LO1CT3VHFW@nvidia.com>
Subject: Re: [PATCH v2 3/6] rust: ptr: add panicking index projection variant
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
References: <20260602-projection-syntax-rework-v2-0-6989470f5440@garyguo.net>
 <20260602-projection-syntax-rework-v2-3-6989470f5440@garyguo.net>
In-Reply-To: <20260602-projection-syntax-rework-v2-3-6989470f5440@garyguo.net>
X-ClientProxiedBy: TY4P301CA0034.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 246bead2-380d-4082-c838-08dec293450c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|10070799003|366016|11063799006|18002099003|22082099003|6133799003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: EgazwJs4NMRf7I+tClq3kpS/plgM/tv1TRfXA+5egAuMvPRGGXmSNb8bn4+A4E8dd/cDu0WDX7kZGOBix7exo5S4ZlDfAxxU2KhucviBroUBTUXExES8cHnlra3DaVNsRkykv0h1gXHGsaMEJrgRwL1SkI0vt2Cs154V/mFxttnBriS2Rx6B3FGEpO87xYaSsVpTnqfgT9EB+vyWPw8ds7g8h8x1vrIUSf8Y30kTsSd/r/vjT3Nq5SSSq5L+UjMOe31dLaMWIjLYim9/LSJ/rtNIJ5N9s/jdRQ5qkpuyaS1Jwe0PtoS1BkTlwjSnGIku4RMj1mCN7RbaoFPGtjPdrgNwLNmjNcUuDMGb3TvpNrBMJZhsgdnQVsrMAothD2DKFs+pOdJtokN1Mx93uSReEdwHYjqfvDpIc2Q+ATo7+3GCQ7yRqcyiocjOXlF3ncVLud7A5dQHdy0+8E1QDzvG1Ko6mwX7N0GneL1Rs7PV0HRzF24nOvUbiZvEnl3Cy0kyl7rOMG9VXfTtvSuB/gLSnPFCNjj4A80r0YA0Pn5KWbCks1TBwj4h+1t82LJjX4gmdbelNKrb7KvBZyPA7mR4tDPuhjZ8L6KAJYSNvtljXBYcKeIGvlSJ858cCcAuDIHEOcf8ODcP3JhqIVU3qgWBEMRG3vjKWPqcanHO/EEpygKvF1NkH5xB8dJj6R/O6JKE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(11063799006)(18002099003)(22082099003)(6133799003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzExTUlrV3gyY0F1aGpZamRkUlIzNGJOVmtsMkxkNVFxcWhXanpEMmQrdkxu?=
 =?utf-8?B?SWJ2SXprdEg4QWpZaEVTZnlscG5LU3FaUTdwWjh6dWhYbDBXRDNvKzNLdlJk?=
 =?utf-8?B?V0h5a3lRRitmRjBzOFJQUkFRWGV1dG5ubncrY3NnNlJ6MmpkbXFwR2pTM285?=
 =?utf-8?B?RVorUlQwdnB4SVJORi8yN3dNd3pWNkw1SEdvSGtGbnBpVkwxOU4wQ0dJdzYw?=
 =?utf-8?B?WWVZLzlIMzQ3bzV0dElCMGd4Tml3RTY4enBZdDl5S3ZJa0xFZFZaOWRHYnI1?=
 =?utf-8?B?K1JndmhGb2tNNWh3MEFxSFE4Rk55dlNWRHFBTDBPNTludHFnd3RlSjAzNm81?=
 =?utf-8?B?Y01qUGtDVFd0UXUvakltMExLOVBqMnhnTVBmMkJueGh2WE1HV3l4TXRIR2tn?=
 =?utf-8?B?Y1ZBUGtRMjQ2SDd2L2RPVEFRbXVpV2Nua0pTN2Vqc2pBZ3pQK1BGUU1vNTk0?=
 =?utf-8?B?TXE4UFN3cXViUERHeEhYaVJXbmtvckI2Z1ZTb0NDOWZlSFI0OXNPNDhVUUdj?=
 =?utf-8?B?KzFxbXQ2bnIxMlFIS29sV0tIMkwzczFHTm8xckRjRlN0OGplTVE1TXF0VHZy?=
 =?utf-8?B?QWlVMi9IN2RwOWg1VW5KQ1YvbUh1NWdlMDh2NVVGaHhBcUZkZWgzVDJ0Y1Ay?=
 =?utf-8?B?Qm44d2NmelFBN0FGeUdzaTFINU1jMm5hWnErMlNMREJzdDNXMGVTR3FWaUdP?=
 =?utf-8?B?NVhiTlZHaWFRTUpQcytqbldVVmJtQkJxdnN6WnlXVXl3ZElyMkhpa2c4cnp1?=
 =?utf-8?B?Zy9CQXA5bHBlMlk4TDA5RHVCUmQ3K0QyVmdCcXA1QzZndk5JbEZ4N0sybm1a?=
 =?utf-8?B?c3M4cW5zMEpsRlJRaGcyYm5tbG1vQmdPbS9paDc3MUlyTWhWVWlFcThvbHNS?=
 =?utf-8?B?U2JQTG51QkRzRVVOaHFPVDZITWREeGxaMTU0bXFSKytVdFYzVG5jQ25xdmhq?=
 =?utf-8?B?WUIrNE5scTMxdFdtNCtaMnQ1UjJvaFhtc2pHTzVwSlV3empaOFNNYm14NnZy?=
 =?utf-8?B?MTF0aTViSUZKNmkrUVQxcGF2MkNLOWxROW90WFk0WVF1eThKRDE1aEVVRnk0?=
 =?utf-8?B?SGZlcTF5QlgyUHpGQ1F0eWd2WjZ5VWpkclA3MExtdlJGTCtka3hZT0F0NkF6?=
 =?utf-8?B?VUdaeWx4eUlVUVZTNmMrZnZXKytKZ3c3SElrczNVNmxlZlRBcWoxN05GeFZT?=
 =?utf-8?B?RXY1NnlkUVBiY3NXV1pRR09CT0t4WXJRUnI0TlBDUVhXS1owNEtkK3FWdlZD?=
 =?utf-8?B?WUtpNjgrYVYyZ0hYMlk2d0dEQkhTS3dJLzBKK0h5MU1Bb3Z6R09ZZm80ZVh4?=
 =?utf-8?B?Z2RhbWxFTDlVN1RxYzdJZWdPN21hczNtMXJqdGRqQXJDWDFUU1JjRzEyRUs4?=
 =?utf-8?B?d0FPUmhGdlJVMGt6T0VxaHV2a0RyUXVsM0FpSm1QQ052S0VvVHZheHFaQm1S?=
 =?utf-8?B?OURmRm5xTWEvRjNsT2RsZTczVEZrMWNMVmJJWGx0QUZ4dHdJS09BRzk2ZDRw?=
 =?utf-8?B?SlQzNE9hY2lSOExCOGtmMy9pS3BjTTdka2JFbE4yTEdoWTVvWGxOM1hwRi9S?=
 =?utf-8?B?UUVzbVVhUGJUSmV5ODUrMW1KSU4rVk9iMEoyQ1ViUDV3OWR4Vmo4VWdVWGtD?=
 =?utf-8?B?SjlOSy9SSUVpdHpVUUJDQVEvSUNHb002QTM3NEhDMElsTEUyMitqK3JTUWpZ?=
 =?utf-8?B?bnFFSVVHajE2MC9sQ1hIYXpZQW8xQXJZdnpjTUJWM1ZXU2Q0NzJOMnExOXhk?=
 =?utf-8?B?S2swL0p0OUd6TDFhRTBRS294Z2w5U3ZpREFidkxld3FZZm9JMUU3eXd0QWRx?=
 =?utf-8?B?Q3ZxbjZVKzRiNUxhTTlLVW04UDFLcUZtcm5hc1hGUUFXTVB4WkRYK3hBSVlY?=
 =?utf-8?B?MTBDYzAvVWtyaHVIK1ExV3liZFpFbFE4dktXOXVuVmJTem0rdFJreHVJNWZR?=
 =?utf-8?B?K0dJMFFXVUFSWGNUcUNxTmhDcGtPWVpWTjhTaDJQSk8wamg2NUZiUmpzb013?=
 =?utf-8?B?S2paZkd2amJiTmRweVBsdHlHbHJpQk93SWZ6Q2F0QnZzNnFuVkRFbjV1d2Y3?=
 =?utf-8?B?L2JpaHBCdHo1bXlKVzlBRzJ1dnBTYVdCNGJzN0tuaE5jNkVRbEhybkRqanhF?=
 =?utf-8?B?ODByNmpwWWpOSUMyckNYS0JZZWY4RmVnWWl6eXhNdU1Od0gzZ3VvdDZKRmkw?=
 =?utf-8?B?a3FOeitERkhnL3NVcGU2UnkrRC96Y09ZVklzR09IVDhhRHhDNEx2L1RMcVpr?=
 =?utf-8?B?RzBLMHYvSEN2d1RNTFNHTjgyWkVtd0FWOERyWnhndVpyTCs0c0JhQVNtWWsy?=
 =?utf-8?B?UEN4eFZIdTIrUkVtb2ZaR1BJZUU1LytuYkpGbmFRYU9UZjlsMUZRaUZXc0No?=
 =?utf-8?Q?DWz5Ce31T9eXHQyxjmFLd0gVsaRM2W96J4qyCVPkHYdLb?=
X-MS-Exchange-AntiSpam-MessageData-1: hiUbY4JFXw/esA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 246bead2-380d-4082-c838-08dec293450c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 23:44:51.3297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKL5paztv5la3MIiSHfTM3AizXs6fCN9rv7Kg3IgNjlQwAiqaSH3psNtlX9UuTW0N9fEo+5eLsJq/9m+mfpPsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099
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

On Tue Jun 2, 2026 at 11:17 PM JST, Gary Guo wrote:
> There have been a few cases where the programmer knows that the indices a=
re
> in bounds but the compiler cannot deduce that. This is also
> compiler-version-dependent, so using build indexing here can be
> problematic. On the other hand, it is also not ideal to use the fallible
> variant, as it adds an error handling path that is never hit.
>
> Add a new panicking index projection for this scenario. Like all panickin=
g
> operations, this should be used carefully only in cases where the user
> knows the index is going to be in bounds, and panicking would indicate
> something is catastrophically wrong.
>
> To signify this, require users to explicitly denote the type of index bei=
ng
> used. The existing two types of index projections also gain the keyworded
> version, which will be the recommended way going forward.
>
> The keyworded syntax also paves the way of perhaps adding more flavors in
> the future, e.g. `unsafe` index projection. However, unless the code is
> extremely performance sensitive and bounds checking cannot be tolerated,
> the panicking variant is safer and should be preferred, so it will be lef=
t
> to the future when demand arises.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Thanks for splitting the renaming part out!

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
