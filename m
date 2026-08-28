Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50D5C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 05:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAB9F10E456;
	Fri, 28 Aug 2026 05:11:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="YX4GsFCv";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010025.outbound.protection.outlook.com
 [40.93.198.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0640810E456
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 05:11:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MU4RakfZlpi1znm2KqLDtJ0W94zc1z3JE/tHiHZaaQ5B62YM//utf+bEVAE1fvrQOTdRL0WDOkYXzAcdflUaOKxGEyL6NIOIPAQqtiKoq3dm1cjeWihDw12span/lmTXgwC8zA7RVj2t1ooMugFNIbnpujmMgWStDPQLWl8Xb9lXa5WAxTrBNAFhdvZ7RsKsP65mpvIPqUTa30urLRQn/uMEnVHlc/3Xf/AfrjYOaAEiwda6yYG3VqWkDpS2sgLOwqIC2lyefUo/zhMZ3KRwebWg01EVPl7b7q/IMS2rYyTJiRuvhtiVtZv2PjcrEX3Ir3LKbcqc4xcNYdp+29t4vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSn7jKksh9L/amRSlDIN+TA9xbbAk4v0MIUueu0zCwA=;
 b=ZleVKRC1tZYsQAbNdr/gZ0Uh2Q1r3aDgJlbtr/2uwZHe4XppH+D6QRV6FYqoFVUMeDxspkvqeSox8rW5k/TUR0oVDbkjV7Lmd/eua3MY8iOd/Vaaj4RIcfJOR0pUlmXU8XxniqDuR3jvXK8vKXGF6VY+LbWXQDyMQk99hGabVEmMj1nuaPF+O2YQtNV1UQSiam/AZRPwEd9Eh4jOSV+W1IMjlLJajVT/HnzhYg0Hf1eNPYofEB/LoSYQMw16kL/pLonAvcUef/9DwbexLC9EDksRgys+gFEW7gtNjENdmUJlusufkKpVcqYh3iII3oeTrY9ZvT2GWnpnlv0gD+gvNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSn7jKksh9L/amRSlDIN+TA9xbbAk4v0MIUueu0zCwA=;
 b=YX4GsFCvZ8vkUGM/4WLiSY9sTUgFKlQyiV+F8/6qPxZQbS+LARkHLrfuMI5/xbCFBQCsDMqcF0YOop1u7XSx5WurqPC8CR5htglELLHYVZ8cg3ZS9BYkg0qyTTRd0bwT7poKKcf6zeqnC1j8TAWOaHcyEsgyS1GFSiHmcQbIyv4HSSp803oIwYLFbMusK9zlYcz/MUgy09YRJeh5ASnFXchk8mhXLvVOLylLOcPLcepNbvd+jKNak3dCDQZyJiePu4tGl4hLABwfYySAjd1sHsgMBieltnv3OllSDZyNge4vKdhaCdVS/luWEYAqx2GdAzqHJAoyhmEqBjYQkSKC5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH1PR12MB9623.namprd12.prod.outlook.com (2603:10b6:610:2b3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 05:11:33 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Fri, 28 Aug 2026
 05:11:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 14:11:29 +0900
Message-Id: <DL0BHLZWX2H0.3N2GZ8OO2NY7B@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v8 06/12] rust: sizes: add sub-1K size constants
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
 <20260827-chid-v8-6-bc74c77d0214@nvidia.com>
In-Reply-To: <20260827-chid-v8-6-bc74c77d0214@nvidia.com>
X-ClientProxiedBy: TYCP286CA0059.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::16) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CH1PR12MB9623:EE_
X-MS-Office365-Filtering-Correlation-Id: 544c725c-bf38-4180-b06a-08df04c2d364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|366016|1800799024|10070799003|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: OCXtPAQSd8nrfYinVFKoNLBpp92nPsPTVqGraDKe9rju9YmI4O7wsJQ8o4JJyTWYo/tS5lECHWFzt9ibFg6k4Ho7Ye5kwh1LDPY2+0EOtOLZigG3D3s8nFHNfLoLVRregtPu60yMUcMA2dU723EucYkOfwhRoGibUtwscejjYLJb6TjmyNE9gOipVIr0wpQtmrf7mlF0UxJchhmUHR3NYsUIJrEfwVnigzEkhvRtNCwrW9RJ77joIE3trpXN6v/blSmNlbdxIhJScoB4u0rlzkumOWgxnk0ALh1DGnMQHZLOBTHvgHhWg1wRdiHEBkXqwVa+b5lzoYFz2+t8r0sngTsmuhqpRP+RNpDelE/vO/1WnijC+EeecUMQu3TmgW8X99Gv4cqBvA1rFpzdJwCM0hJ6ja0zCdXLZKzM1PLkZRle+4z32aU4/DTi2sOL7aiacd9AiNqueNUpTAUItvnKSP03EICFr4zglXbq1gVLU2RWfT1XEdocFoPdUH/5LSVjL8oBYNNd9hbKoUmPa/DCDr76w8j0fQmT+2Ye5nM7tpurMHpwG+W4eq9Bp0oZofKfZlk3eYYxoCJr3MyxKZoZxEIlezvE+fJGVokqGUk2aeA4T7jhgPzlGnJjV9mAvSyuTtRnCP32jALQ8SE62Y7gGEHcj1QtoCsY0nVROfilCfA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(10070799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXd3RWtHQjFVb3Rjek5jVktCKzFrY3Y2K2lSRWFVQ0lDQzNWcFMyTWJ4TWhy?=
 =?utf-8?B?SzVGUnJnMHFSaFRvN0xhaWNuWHpWKzZVVU5ubEh4SlY1djZEYjZMNFBPZEFW?=
 =?utf-8?B?RVFuM2VPa3RybERVd1FVM1NjOVBrS2NLMUEzZUZVSkFPT2ZZUjIzVjF4d2wr?=
 =?utf-8?B?TmxIZ2xkYjFPcXhMS0VOQ2lTZHQzcU1UeGt4cnBsRnVpa1FWYzcyTXNLNnNH?=
 =?utf-8?B?NzlUNmsxc254Ukk0d0RoSWtDYlFaYUd6Uk4zUEJPVnRnY1pKMXl4dDl5M1FH?=
 =?utf-8?B?VGltbmdRV0w4SXBlenJEN2xaaXdNL1Q2MVAycEhOV0ZyME5iWnNmUXZZUEZu?=
 =?utf-8?B?cnhQcDNjRFR6RmRleWpTSUxGekhKd0JKQXNJdm1MLzdBcU5rMVUzQ0dHanVN?=
 =?utf-8?B?MnRMb0xqQnBvQzJna2Z4a1ZxcVhweCtJc2R3Vkttc01UUStveWtJQ2lCQUxK?=
 =?utf-8?B?ZDVMcStPWXp1bDM3emlqenVMZ1F4cklSK1Y1cDE0SllneXczSThSYWZXNE5M?=
 =?utf-8?B?bm9PVHdZK2pkZmFMdVUzMVpBMC90ZW1qUWs1VGZYR1VHWm50TVRiZTR2OTFQ?=
 =?utf-8?B?Ynh5NzBYU0ZhQ1hmMVdGbUtBbWYwS28wYlVLbXZEY1ZjYU4vSzFGc0tHaEdN?=
 =?utf-8?B?Umt6OVkzZ21EcjgwUjdCRVp3YWxyTWtSL01uWGxNQkZxdk9GK3BGa2w3N2NT?=
 =?utf-8?B?N1VMS2JtV2xlbG1OcWlnMlNLRVczc09mSjBYL3NNRkV4SEZGODJSZDBpRzdL?=
 =?utf-8?B?T1pCRHFpam1OV1BQNnM3VEhQVWJHWjZYdktnSmFraWlHZ2swZGJYNmNwYlRN?=
 =?utf-8?B?Ymp5bDVqekRjSmt4Qm9jcmtsaktaYnZ0d0lMcGNWaXE0UjBHeDlickdKZldi?=
 =?utf-8?B?TjhGaFg3UHFvcFc4WnlPRGYzSDhHZDdGVXNmTDhiN1JuakxOeDNmbG5jcE0z?=
 =?utf-8?B?dWllL0wrQnpRcmxycEN5OS9FSHQvajM4NEtMbFlYKzhaSnRFeU5Yblp2R0pI?=
 =?utf-8?B?Nk9vaE9hWWdVRUtqekZOMTF3WmRYUitKK0NFb2pKWjJPZEFsdmRMMkxnSkZG?=
 =?utf-8?B?WXNLSWRiR3pxeGdTdHhNaUVCdVh2d09KZGx4UzhIc2ZHMjlXeUdIQTJXQjNq?=
 =?utf-8?B?SFpNbmdyY044RHhWd3FLQ3NkZGVPQzQ5S1ZQcUJ5UUgrR2E5SW9NeDg4WUJa?=
 =?utf-8?B?aWpVbUdNczVUaVEwMkFlMXJiTkpTaTZ6RHd3Qkw4bjRIb3lWRkdOUitUMWNR?=
 =?utf-8?B?d1NKZDJiU2I0UDRCUXo3VTNrL0xUdC9Ec2FqV2tUdExTUVd1aEVZMFg1M2ZS?=
 =?utf-8?B?RzhEK2xiYXVsUk45QVpORzcyOHNhSjNXcFFlbHhLSU10TitIOE1tTVloU0Zr?=
 =?utf-8?B?SnFtY3FRMmpwbFZnMXVYUkxEOE0xWVFacFdaNU92bHR0TzB6Q2l3d0RxVlIz?=
 =?utf-8?B?WS9XMzlmMG5kdFpmaHRTWEpqSko1SGQrczZvVjBTNzRMZG1Xc2ltZW1BaURq?=
 =?utf-8?B?RGhaUzlYUS9ZQVEycU5XQnMvNFZrN01HKy85LzJhNko4SEtZNi9hV013N0JW?=
 =?utf-8?B?MHFhTVJRWS9NRW9leE9Bbm1YcTFVQnRyUm1URjBjcDNLV3FqTWtaRGE3eFJH?=
 =?utf-8?B?Zk14cHlTV21TTnZwNER2WlpEK2pmK3FoOGhXOE1YNWZ2MWtkM1dZQ1YxbHVw?=
 =?utf-8?B?d0U0bm0rMUZMbW80bUllTDBWVFlUSFJHeWx3YkI1cEVxSm0yMUluL0hXZE5Q?=
 =?utf-8?B?YktJU2p3THhHaEptSW5uWGNTVGQ5VVo5VE1LNHFJM2dPYmExU2NOejNLS1E5?=
 =?utf-8?B?NmtJdFVES3dWbkhqeFlCVTIyekRXekJ2Y0ozbzJLeVlGc3B0NGxjRkdjUC9Q?=
 =?utf-8?B?aVkwNHc5UFNTTjBqZWxxY2NDWVFxMC9uZFFmZFhjckt2NjBUaG1zVnYwU1Vt?=
 =?utf-8?B?UlVqWVhKUkt1NmZNZXNYVnZDbTFTd1J2WTl0NXZOdzJaL2pCTzFxSitLTm92?=
 =?utf-8?B?Yzk4cmhEU24zS1NJWUZjNlBmbTU3dzRjZ1BPYlFRVHhTTkcyUWdMakp0b1J3?=
 =?utf-8?B?UmZUZyttMThTakR6U1JyYnNSViswOWIxNERRL1Nvd3o1NVBudUxNYi9XZkVH?=
 =?utf-8?B?dU5Cc1NyWWU5N0JyNFM3YnFpUEJkNDhaMGVjOW53ZExTZDVyN2ZtMHlOYU9z?=
 =?utf-8?B?S2JXa2VFQXpTbXkxSFZZUVRZOVkvTmpLNmdrYTFJZEUzWFN4MXZVZWQ5OWE2?=
 =?utf-8?B?N01QeXVCWDVUZGljOHdMdDl0cXdMTVN2bnRHK1lPWDhUSUt6Sm55aW1nYVFF?=
 =?utf-8?B?Y1VtYjdSNTIrUXhzUTlPNmtjeUxNQmgrY1E4QWNSb1A2RmpoQm95emRGWkNi?=
 =?utf-8?Q?CJotvlGQqYQAL4D98D2OtZ6E3AGTOvnZXCCa5okl/yviP?=
X-MS-Exchange-AntiSpam-MessageData-1: DFJVgQlqiO2cwg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544c725c-bf38-4180-b06a-08df04c2d364
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 05:11:32.9317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXUALiczVMed2Nqaf6YubitHau8bEshvLry4YMgXmN6KMEAwyVuxU5+N7yIdBEdwZoEc4bo/ac5Iy9g+e2N5fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9623
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

On Thu Aug 27, 2026 at 4:28 PM JST, Eliot Courtney wrote:
> Add some more size constants, mirroring include/linux/sizes.h. This is
> useful for making `Alignment` implement `SizeConstants` in a following
> patch, because these are more common alignment values.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
