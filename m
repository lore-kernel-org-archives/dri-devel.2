Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E56FF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B1B610EFA2;
	Wed, 29 Apr 2026 11:22:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nnyL8bCI";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40F4210EF8B;
 Wed, 29 Apr 2026 11:22:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqmIbFZtTHFzkGFOzbpdLeu7f6icTcwrtyOpKL88Eza7NJYJTouNh6Gbfl2xgiQdVEL+vEHqQRscNsn2ptWCHKDT4MQH8CYBDpfUJ3YI0ZqNbvRv4s5AFGsoOAP643aFac1tepAm1EIGxu4BA33+Iaa/zUNtaEq9kzEqwC2gV1oL/A38K3Fgmfui6AqVOcAsfB1QY4ubmJssS/Rs62s0zzsIZ2cNKEUnNOn6heLLO0oTGV7b/Cmawhiykbjof3yAGeUbBAVKIrZ40dGU2w+XDkMpb+GwvzCW9thddK1FWVAohge3U4N+OwQ763q3AydoTC1quN50T4nPEw2jvwcw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdCvJwyrb9zJaJi5gBc3W5/dDGdPBTPQXIv9j1t5zBE=;
 b=rTgS86cF1AhYerfD1fcOQuOQsvrwBcZt0Q0YsET8qnxbzQlle+2huh5AO0PrT19G6IRqdpRI270w7ckSHt2bhVz9Y5bMdcfEoDc+kvOMaaAOUOxfb37vOydJ40W9E2KhDgshLa5ekv5btahRRxlniP5c3rQq0pTyfAzrVz3k3kBI20ZWRr7F+JPbT6a9mWRnVbSuIccRvk8iXVLm1ZXBLFr2pq4DFN4EJWX+/3bpPm97LYbrbU7PQGJ4BPsGkTsKeAGnCLf27ROB42eKOEY8bwxfR78hJsgzrLkDEFdosvGV27ZDK3JUV1UcFo8Nh9CQ2ZRQb+Ugse89T254AlNAlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdCvJwyrb9zJaJi5gBc3W5/dDGdPBTPQXIv9j1t5zBE=;
 b=nnyL8bCI0PhJ9bymXajcI/XNxVd5FEAwksdlGON42zpsMpp7yXAMqMduSWyxhP981vqUY4CqTSxsMvg2b4tSuKqJK9kj0QjhLCqvgBOkkCkyYtfj/Eu6gncGpaHTVqO5b2A+aKi8iLVehDDR/N5fQz/9pXinpuk/HpYzKaoVQz6RO5aIf+Ug0vsHGY/Hz67t4WPcutA9KdjZVbumRPaCdDhyQvplBFP1uMLB2L27zBUINDm91ENXfDLKzILjEPF/kE3k0F82+ZN+qHnn0h42T5iCVDTBOYY6OyroILeZ5lcIzyE8TXhGN6qIRpMVVPOloPp8zD288jPTD4leDUI9qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Wed, 29 Apr
 2026 11:22:45 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 11:22:45 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 20:22:41 +0900
Message-Id: <DI5LLWPPP8ZN.VCFLVV8Q73MS@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 5/5] rust: ptr: remove implicit index projection syntax
Content-Transfer-Encoding: quoted-printable
References: <20260415-projection-syntax-rework-v1-0-450723cb3727@garyguo.net>
 <20260415-projection-syntax-rework-v1-5-450723cb3727@garyguo.net>
In-Reply-To: <20260415-projection-syntax-rework-v1-5-450723cb3727@garyguo.net>
X-ClientProxiedBy: TYCP286CA0167.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c36034-4ad2-4dad-ecc7-08dea5e1a2fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|10070799003|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: h9WTwgQWHA/QUtNsgo9K1CrYVdp9LpQCNxb4yqTtZjDaOJ5f7ZvRgA5wN7kU+I4b731E9aNG3+schmegEzJkwV/8qEdoeKbPaOTMgPKS1Y8ayalQnh4pBEfx3pDplh8r5kfM7tzR595Hmq4ETl6843R4ZKPzkB75LOECklJq4bkHgMa8RRHfgoaB5E0TV82ZPBwUS9QuArGObhQAEJki9StQZOYPo2pnZHaBOkApAFJrDABPHb5czFfnxhjikPB/5ffgBpSlZ96pdoiWhc4yf6JYpnkULHVOC6+3JmvpKdjBkKM/pSsPetfk9d1m673AvICL1Oln6HUobP7n8fgzfyHZSO8mDn12EXMInzK0NTyF0Zv/N4H8hXQPVn1JhUgfDW1/dhoReFkoGRgCb60rRa8y57swA8W6TYnREskQKQH0cilVKTt6J9/NCU9/oi7RJ51447zQoEyZmVyeN9AIyqP9qIbBolU0zInaDiySDxiwHXth+CLhQ/VHbodxwqBefjN57bNOUA5muUIsoy+YzH3rxkYRjt/Bn3pywzmlPFfEk1nkcdxkOVI6NJFMeNSHQhrdRYC8Ahenq+P6aDt4SUBAbk3WrchiJpsnc/f33xaJQFm0Hgm0gM96YySIkStkPobUYd26Go0Ya9DlPv47irDz6/v3iNEKTKQU0HXOfqBy17nIScm+s2TbF6IMF7P7Bvg8sb11xP/ZX9yKyJ4B4M22CTFLx44xM75fK/Si7KY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(10070799003)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkZKOXZSclJwMnZCOTBneEs3QVZEbCszR01hc2swTjN2QWFIM1VISnBLNnI4?=
 =?utf-8?B?T2M5MDVnekIyMFRFYWhhdVVJajdNQnFDWExVM0pqd0dOK3VKZncydUhTd2dH?=
 =?utf-8?B?QjJpdzVkTkp3eWFGdlJrVUF6SUdIendabURXNWRHQTVEdDEyb3JnV0xZRHJW?=
 =?utf-8?B?eXBGbEUwcnZZZHdvdVRkc3JWYTZpRjBHWXpGMk1DUVBsUU5LckRFQStVdVox?=
 =?utf-8?B?RHpPSTM5RVNYMFVwZWpia3NKWUxMNFVYUnZweWZTOUI2R1JCMGEwWnMzQmZx?=
 =?utf-8?B?a1JYNG52VmYxNFphaE44RDZmNjlUWjNLakJwSzNyUTNNb2hsUDR4bjhJVUdz?=
 =?utf-8?B?ak8yNzMwSXBjYk81Ni9pcUhVZHRhUi9yMm1sQ1NBODB3S1NwVmhMK3BOWWhZ?=
 =?utf-8?B?Wkt4Ung5S3hHMVJPWWl2UndlOEVkZ3VjZm5SbEtKOVBHYUo0cHhERXljSlV2?=
 =?utf-8?B?MWl5b0ZSQnM0eWZ4bDA4d21UU2twTDZzRzdXTGl4eE5URll4TXA1NkZsYi9V?=
 =?utf-8?B?MDBHV0dqQ3lyRWJrK1dXbzlDWkROd2k4YjFlYnJ5Uk1pN2JXT1JFbFZGaFcz?=
 =?utf-8?B?OGxXcS9NZ1NvQUVMRHE3dXhUVWpOQTY0TUZQYUtSVTM5Z2hPWFRScm9HUndt?=
 =?utf-8?B?M3ozMnd3TmluQTdRbHJVVTlxTGsydG5XTG1pMlpLdG8zN09iaHQ1UGFBYjBr?=
 =?utf-8?B?UW5zM0pTdU9jaHJONDVhMFpTbHlPbmtKeGcySXVlK1dVakJsSGxOTGFVQm1T?=
 =?utf-8?B?bkFIOHZIaTd1OUhKekVpU0ZrSHZTZ1pwOVJWWVBTWWlyV01OQmtTTy83em15?=
 =?utf-8?B?T0pXZ3ZRWnJ5ZUpaUDNCUkE5UjNoYmE2VzZZVWhPV0NkWU9kNThmdmNCS1lU?=
 =?utf-8?B?N2NkaHBGNFRidVRjUG01OHVKUEtLRDRFWjFTSEJVMUtZdlA1SmJmaUsvYTNR?=
 =?utf-8?B?M21aVXVwdGo2V0xPVTkzQWExUkRFL1l6N0xyWVkzZnpoVEZGSFdMaHlsdWt5?=
 =?utf-8?B?LzRwaDc2N2VkKzl1cWJQcEhYR0lRbXVOZ203am1XLzNmOXhrOFFkOHdQc0NZ?=
 =?utf-8?B?OVB2WjRiQkV3Y0hoZG9peTV1Um9DWUgyTXZMMGlsbU9SczVoZEh0MmU0UHdu?=
 =?utf-8?B?RCtoSTVKOVhidGx4MjBybm94OUpEMnhXUktPdDQ1WGxmNkt2dVRUN3d5SmdQ?=
 =?utf-8?B?YS93bllNd01TenVlZUhaS2JoK29ySmlCT09xTCsvbnhGSnl6UDl5bFVqc1lo?=
 =?utf-8?B?QzZSY2ZzMDNJL1haa3IyZHM0TGQvd1N0Sm1SdGgwYy91emwwMjhFZGpEcFpq?=
 =?utf-8?B?T3R2b3Q5NmRnS1FiOTZLZmtFSGtLLzF0U01ubmF4dXVTK2hZZGMvaCtUSjZS?=
 =?utf-8?B?WkNhSHhwUnRBRWM3K05OeGlVZVRwNkpHd3dleXh5SFNxeS9IbWMzQ1pva0tN?=
 =?utf-8?B?bENDYVVUR0ptelVZZVJsK1BneGh5bUFweDZSWTRBbUUzaVhnVlhOQjNKcDY0?=
 =?utf-8?B?Q3c3Z1QxSU9wNEYvTUp2MVZVbFo5MzVnblNqelY1eEhZMmFHVFd0QUdMR2Fp?=
 =?utf-8?B?R085b1VhUy9xZlNvSzRrMVNsY2dueHFtamFkQVRYN2d5Nm5zT1F2ams2OVBy?=
 =?utf-8?B?K1hUcXhvWUk0NTNLTUV6Z2F3NUdHNkljOUtHQm1PME1zTU04cWVsajFQT202?=
 =?utf-8?B?Q1dhRkR5NEEraWdJQ2ZKMVdWQm9Ta0VJNEhuTmpUeXYrTk1tdUcwaVdib0lz?=
 =?utf-8?B?ZW9vU3BYN015WWZDc2NTODZwNXRacEZsK2Q5bXhYVFhBMXo2NEZ5b2twcXVX?=
 =?utf-8?B?RityYnBpOUZkdkFNUXJkbHNObjZQM1RsVVRNSHpiZ0dSTzE1eHlFOTdSR2lM?=
 =?utf-8?B?cGlOb1RoSHZLZGZoRFJxcGY5YTkwcUFWKzRnN3dodHBFeGN0dFkzTnBnQ09z?=
 =?utf-8?B?UTVsNTV0OE5CODNhUjRUK1ZscFdFVit2aXkyejVNRkhROC90M2NTeEpaVk9G?=
 =?utf-8?B?VEdjbXBQQ2F3M0w3bTBLcGlJbnFYbHdjTVR2N1BRWkZ4ZnB2VU9XSUdSaG1D?=
 =?utf-8?B?WFRnZDJuYmRBdmdVdzVLTlZoYVFWcGQwcEd5N3cxTGVkVWRsK1Q1K3pDUHVR?=
 =?utf-8?B?UTFFbU1sVjZRbndlTm95ZU1PQU1HVHpZZm1GdXhLQ2J6VkhuMHIwSkRIa0RB?=
 =?utf-8?B?QVV6Mk82OFF6dURuNUZRVW8yUXdCd0hyV0ZxK0pBTDBhQ3h4ZmpxZ1FNRzFw?=
 =?utf-8?B?OWZ2LzJCbVVUczRDVW11VE0wMnpteEUxVzRuNFVLRmVkeXVyTWF6Vjh2UnNK?=
 =?utf-8?B?MzZtQ2VVcWRkYTMwaHpabjVWZ1NOZmpkUU9GUlU3YkdrR3B4ZW85QWZGcm5C?=
 =?utf-8?Q?SxwypOssootC12Mg5H+zuJzhcXICs40rKrQEh1h8CyOcG?=
X-MS-Exchange-AntiSpam-MessageData-1: UsXKfEvSYXkcJg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c36034-4ad2-4dad-ecc7-08dea5e1a2fc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 11:22:45.5352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuqVMvuyU3+vP2iLCrqC7I+NdrLd3MyKi1FqYh6ZYJ3LQZcClx8xYDxuYaWaaWBCT5KfV7PXHXbjYgAxc31FRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695
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

On Thu Apr 16, 2026 at 4:57 AM JST, Gary Guo wrote:
> All users have been converted to use keyworded index projection syntax to
> explicitly state their intention when doing index projection.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
