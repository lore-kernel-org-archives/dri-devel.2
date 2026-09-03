Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CA2C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E47B510F58F;
	Thu,  3 Sep 2026 12:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nwhxe9jS";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAEF210F590
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 12:41:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLqhZWHaSvZQzaltUSe/jNE4743l5nczQCzu8I9fJ+a0jb6xT7bJGxvtLLVQfCZS0WdaFx+nsWrKC827injIBNz+5cBQzDxOa2hsAbD2pKiSLMldcO46Z8jARcnLJ31mTbFt5oKmWu1mtpnO+Zn/F3yfS+sfBfHYYIZZtvRgSkKu3W62RtaMi6ZYqpuv96vS3F9bgtQ5twUV6cShhpNgK76aiEYlUA3AI3ImK040EY+reb81HCBEyOLoY2UBUXZfImNLlh9vkm3pdYl9zMynlo9eNEDJBIJ8cRpNEbwjDYynH5aVb76nqUwqkp6WGDyT4KYHDrqm2GbyNO62LaXdKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCOqygjxkBZ2jJp1t81Nsf7Htv12aLFlgUsBUx1L8dQ=;
 b=pTfalacJI8RfDQIoOkovvzLv767Zk+NCC626ZcdmP4bOjcbiMWQGuExwFZGWTJ9WyuneVMIan13dIzEdmJ28wuXgtuHBnAYrt0PpI1OOWTLcT4Q2wsEuItCLM8WTDwZCevQqHVC97D3Jr0f3uMFptwa8dwLcWv00XyC06Zi4fujENqcR48XcNzfK1nZap6dwZCNpF62MZ4zKr9QHzxMSsr4GcqUoPAa+wua9/k7iNTzHiPbK1UeB1KaeTkqQPl4tgv7GkgbKeidXV4xRZoOSD6SnO4+ZJ+RiJLkFkNbVuNUIdcBDpAmAKptiFMJJl6EhvhqrJs/1PlClajWn67x11w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCOqygjxkBZ2jJp1t81Nsf7Htv12aLFlgUsBUx1L8dQ=;
 b=nwhxe9jSBiaIHPIfBSEjQI2QaYAGXiTcXOwJsK+y3/VFVPYv6erHw9pweS4v6N8xF4fhGTdM8MDxlIaAJpk+PEGoOfb6TsJt0pCQyzqy07wyDmfjcFMSkxKkRwsJOxegpDv6EsXOX6alGHdO/JvJT3yGZv/QCTVljSLUvYNfFYCJbGytjFbk8LpurfrOV0D9P0Fc36rhK2KifEqjwnnkP7B6ON/u454pifM8eww3/BBQ9VlvWJuj6g0WshMot9fM958WFBA/vDU7iuRtcBf8wDubsqEmw5+Dj6GCJ7Uc8Xj0U1dpGAyL71kyfgrg8hFsVxcJNFgs7+gfk4QnFh8fpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 12:41:21 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 12:41:19 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 21:41:17 +0900
Message-Id: <DL5OT9P4398G.36X8DJ6IMIQ6N@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
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
Subject: Re: [PATCH v4 13/16] gpu: nova-core: convert hshub0 from relative
 register to projection
Content-Transfer-Encoding: quoted-printable
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-13-5552b1d59525@garyguo.net>
In-Reply-To: <20260901-typed_register-v4-13-5552b1d59525@garyguo.net>
X-ClientProxiedBy: TY4P301CA0102.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::12) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CH3PR12MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: b459f85a-f00d-4107-0582-08df09b8a72c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|10070799003|366016|3023799007|11063799006|10067099003|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: cX4DnUzs9hZ+fb7Qzb8voBYtdrCDxDwRYr7oZSmoGIF1TXRQJGd2I5pbuZoQJquxGSs+bsmWCz104ttoagNLYE7Jt5aBpX1s75G94O3aeoYnQRUEpMhRfkt7beWWQuwP35ZObkeaX7hHuSDvPfpPpP2MFFNQAP47VI/BLMFOG6mS+rywAdDoGwuE+oT4V5rD1JU+fAkU8Bpyotw7SFt2tMGVC4cNkwMW7lMhz9g5M04bsUzuLAAoqmqwxntFGOQjEZPSv0s46sU3fgWXj+bzrAYTs4J/M7wQauJFQp02aRlhpgBMM1nSgwaN8HFie2kEYtv8Kzcr2HQGX8xMQkPddp6fXOrLYLm5ZV3dCHMN09PBSrXcYYSmb9SLf3OKLDKfWDtOc/RDppjkSvLohgjBHqAhqLlE3nW8ZptgwuiaNWKd0172vHfd2HJoYc84IelMZ+ViE4FmHODX2YPusuu5GNX6M9H2I8Al79PnOuqSALLul+zf4wBWMKFNgXNDANWOrWZquc0X5Q5Q5gxtM+2QoKjET4pEk0NF9PqZu3j1FkYb0lKdos+Qt0awcUA2BOAtrljK9vpTOHwRzOnD4cuq1eQAbpaxrhnuFCCeKS771r/zxCa/8lWgGburv9T3Fo9Y5hjY2n/nUZ2bx8sut7vNNR3sUjpUK/7OJm70pK7yzwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(10070799003)(366016)(3023799007)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWRkSW5mYm5oNHo5OGlLS0FzUzd1RVh2Ri9ER1lWNG5yY0EwTjA5Nm82TENj?=
 =?utf-8?B?b3l2NzA3ZElyL0xEOEZ4bmxINkt2ZUQ4clpaTmhNUXA5OXV5K2J6WTdCc29K?=
 =?utf-8?B?WGxLTktENXpTSGJnaUZYS0RMektRVkV3YXA2TUhIK2hqYUZVSzMvb2lmVWJW?=
 =?utf-8?B?eS9naTZZbWZiUm4wWGtLU0dlcXNtQWRqRUFjOVBLTnNrY0RTdkVjdkwrSVQ2?=
 =?utf-8?B?L0t1S0lUaDBKV2xxT202aXF5dzhtdWllNmNRK2Z6T3A1WWFvYzVBSG9Fc1NF?=
 =?utf-8?B?RFg3ZVN5Y0o1RHFjQzhzNjRoOFJna25hMkZWL1RMSWIyWk1vMllscW5JVWN4?=
 =?utf-8?B?WlU4VFI2dDhZamx1c2gyL3o3TXNIOUNXWGpPK1k0K0htN3F5WGkvMmtaSUln?=
 =?utf-8?B?QUYwRTBrN0FIRjZnakdNcE1weTZUQXJWUU9LcnVIVGUrL09KelZSaHdSalR3?=
 =?utf-8?B?Wmg3VE5qQmhRWlN4QjJWNVl4UTYrU01RZmRmU0c4V0owNmt4RHVMOFM5UmFv?=
 =?utf-8?B?elZLcm5ZRWJ3UnF0azBhN0R1N29lekl2UVo1UmxEYUFOcno1SzkybTZUbUZ4?=
 =?utf-8?B?WnFyU0l5WlZHN2s3V1dkRG4rUXNvVjB3NXFzTkJWVEJENU5nVS9ISm1HL0lF?=
 =?utf-8?B?QjZ0WWY3bjhNZGN6RU9vc21GaHhZT0I3QWE4STJhTkZ6OXBjMnlqOERWbUZo?=
 =?utf-8?B?M29Fc3VBblluSHFmdlg1dUFYQmlFSDNycjRqQWkwRjRFM1RnRG9IYVJWVjQ2?=
 =?utf-8?B?ditOQXpKOVU4R3V5eXRnZnNObEZlZzRXSTBrc0I1ejJQL2M4WEhXd0dRdlZk?=
 =?utf-8?B?SmVFWm95N1dLeEo2Y3psR1RzWUJkd3pPNnVLYW5wcnBEWDRYYytTd25IRlFv?=
 =?utf-8?B?YTdzK1JiU01WZWgxLzI2bTNXQ2prVUlsYmhONnJHSFZCZCtGYmlaNDlobGU3?=
 =?utf-8?B?c2JjOUNvdUdWdnorQWl5RWgzY3JlQ1A0aXlLdmZrMUdiSW5Yc0UvdU5tSEkz?=
 =?utf-8?B?TlM3bFBaNjNZWjJHY3FxWWx3bGJ3Wkp1M0tHK2FFeWQzZUY4bWNtc0FDbEV3?=
 =?utf-8?B?Ykc1bXBpNjRXdG9GRmhVcWs5UWRUeFQvcnVKR2JhUitkcVZDbi9GcU9ORGRG?=
 =?utf-8?B?SVdzR3BqL2Y4RjVMKzdHWHl3eGFsTVdRR24vYmFrNzBIRDZGNURhWE0wUXRs?=
 =?utf-8?B?Y2lQY01iWkt1NTRGcTIzSW1BZmcxUVBJNUZsTTljSVNaS05FWTZnS0I1dzdN?=
 =?utf-8?B?bms3T2hoa2RBeVV2UWhabzgvQVNGcDUzeFBtV3BmcVVHVkJPOFpjR0xQbVU2?=
 =?utf-8?B?V043M1NOaG1CZVVHN2F5TEFMTk5XYWR6d043OVBYc1NRL0NZSVV0V3ltTnJs?=
 =?utf-8?B?cVJHU1J4UTkvY2FKMFZMTm93ZS9aaGRsMURObUhla3l1SVJGb2NoZkp0alFj?=
 =?utf-8?B?T0hHakw3T2JCa1Q2dzYvOWwvN2h0SGdQbFNaMXpOU25uRlN0WnNzSTVOSjZ1?=
 =?utf-8?B?b21XN3NwOGpzb0dUN2pSd2pHQXFPbm5pSUpFMzB3VWJVYmRYMjF2aWdwR3Rr?=
 =?utf-8?B?TGVqSWNTYTBWK1JYTW1Nb1dUUVc0ajVqQjZEQm5CU3V2c3ZUVGdOaGtoaWtp?=
 =?utf-8?B?cnJ1QTJwU0xIQ3FEanRhaWwwK3d1RXFRVS9NVnZkRDRpdU8rUjRSOVBhaCs1?=
 =?utf-8?B?Z0g4dDBaZHgwZmhLUVdxTVBsQ0FlVXhjRjhyeXlVbVN5RlhqaTBhRkN4UlhQ?=
 =?utf-8?B?VTJwU2IzU3E3QUxQaG1YU2NPa3poWmc0T2VadFpKZ0pqajRuM3UwTzh1Ym1j?=
 =?utf-8?B?MTh3RktMVWNqbGd4ZW1PeEpRTWtkUnN3ekZ5K25UbCtTUC9jMXFMQzJGaXdr?=
 =?utf-8?B?T1BmQUw0dndURjVKYTRNSkxLSlo4QWIyR1FtdUtLZjdnNDhDOGVFZDVEVTJo?=
 =?utf-8?B?VjNmK1B0N0R3RC95M2oxdGtwcjBqWXRpaHlPbnlGZkUxR3daMjhvTWV3dkpl?=
 =?utf-8?B?RHJibDZ3SG9TZ1BOci9TQXJXSWVpQlFZNUdTdXlpWCs3L0R1Q3BwVllUayt3?=
 =?utf-8?B?TVJOSTJQYlA4NFZ0SUhSbTdCS2VTMDBEOHA0YWtUUmZHbzIrY2xUaG9WaVFo?=
 =?utf-8?B?ZXVJZnpCTXVZQnBXcDNVVGhJc2I4by96YVFFTWtMUTNrSkNuSmNIak1TTWpx?=
 =?utf-8?B?aFlBSy8wTU1RempsSnl1TjEvYnVDVWhHWnNWV2MrMlF5RVRzRUdGeTAxN0dx?=
 =?utf-8?B?RCtiUHZLcHhydUpySHp6UTNsSFpzZVZrU3crMlk2a3pndEtFRmFqbjBmMWhV?=
 =?utf-8?B?bk9sTzdDWEdlbDhjRml0WkJMZmU5TmREcytxYys1czVtZFFMMEU5eUcyTXk1?=
 =?utf-8?Q?AUni4NFieYiQD2YPFRTaOdj9pmFG8P+hzYYhxLIUerMZR?=
X-MS-Exchange-AntiSpam-MessageData-1: 9Z1Lh+n72/z5PQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b459f85a-f00d-4107-0582-08df09b8a72c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 12:41:19.4283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VcXMSoFPxk9v0Sd66TgBR2X4ngDnmVZJkliisICHp/f9XmuxNtIaHoQ++AGUtJLvpkiI2QzHJHOWUiG9m//3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354
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

On Wed Sep 2, 2026 at 1:50 AM JST, Gary Guo wrote:
<...>
> diff --git a/drivers/gpu/nova-core/fb/regs.rs b/drivers/gpu/nova-core/fb/=
regs.rs
> index c27582e376e2..abb48b0955a9 100644
> --- a/drivers/gpu/nova-core/fb/regs.rs
> +++ b/drivers/gpu/nova-core/fb/regs.rs
> @@ -2,7 +2,8 @@
> =20
>  use kernel::{
>      io::register,
> -    sizes::SizeConstants, //
> +    prelude::*,
> +    sizes::{SizeConstants, SZ_4K}, //

Sashiko pointed out that misformatted import.
