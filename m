Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54878C5DF94
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97E3E10E5CF;
	Tue, 25 Aug 2026 06:46:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="qZZtgWZV";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A04BB10E5CF;
 Tue, 25 Aug 2026 06:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GiYA/U26b51lmWEqTadRuZgf3uGyJ9VMnYJFYBoStASF0BH4utAxLAgziffWm9YVSOXWqqh7/qgUOzdj2puX/8PpQK6urv8KNqal9Imet9XWygcnFYOvAjvcVoXG+de5T+VHMYf6wyEjFr/U+PGKQLJOfi5pTrD+wRLrrFNtK6s9zzx251Effc067TPvfqKrulNAcH074ZN4w+PXgJ8w8Sj2gW9ZCoMfQoLA4zlNITuvmFVapWlbHt2qNdKw3CFAqiExtSaI7zJNnI0yelonEwWEyQtc8GaxRF4QrYxiUY1dCwCsBUCx4Cy8n9p80rTkYSFCQDYCE4IsIXWU4v4v+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxPMaiTWVeQfjiwVsjl5tgrze8jtnhL7Ux+A3YSJ+J4=;
 b=nZcU/dApglvlyGDgmTWPEpiNLwVx4IFUli/RtaXu2V9vauxeuoT9byWZX8ug6anh+se0JonTneuu3OAVuTvZ0cX+uIqExO8OIRS/XnsLyDptvlKsp1rmwrDy3g8LCa/V6NT7afOWZKDWxVHdcA2x3XKglKh+HdY/++NAVfkuAMW4DDffbtResJpPnEJSEW4HeAmvm2a10QSJG+0PPNsqePmZ421MU3M9dO4WVkOf9OG9qMI7MQkkxDSJ+H6lS1Jn8EbTFy4+/R0vBorm3O+VRYaEnBXw1yc1dhCdrRcTmGpVJo9535geMbBsH0LZ+CFaVM/Q6zQcLME0xHCnsfSLGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxPMaiTWVeQfjiwVsjl5tgrze8jtnhL7Ux+A3YSJ+J4=;
 b=qZZtgWZVazldrWAtSUMMrDzJya93OPmlo3GzQVX1R5LxhMWXJJcWw80jhgpmm6O+DbgjBuAxoYoQBAXJkMoIyKZE1rWAyLitrAHdajeN7+N4+V3zEzSjzWvxsiOitr57SY7hsigDgAP2gMrdpHSMSJZBolQ+qxUJ0Etbawq+Ar87W7BCwvv7DvpsuXMmou7HlhcYvlsTuHBt2xIuUbMTeV5tfxYYxRQ8h0J3V0W5M4U0zEJFLvQ+tKafl2UgGeK2SfAVEQdNVTD2CK0B1EGLcw4kjrBYJErRaiKma/tQfXzO0PHRAh3pmo7AnHo6kzbuIWQMjlaM5SNnag3DSRsgwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DM4PR12MB8559.namprd12.prod.outlook.com (2603:10b6:8:17d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.6; Tue, 25 Aug 2026 06:46:38 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 06:46:38 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 15:46:34 +0900
Message-Id: <DKXTMS7HED31.3L0SB1WM5RL6Y@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Eliot Courtney"
 <ecourtney@nvidia.com>
Cc: "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 5/6] gpu: nova-core: add NVKV typed decoding
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com>
 <20260817-b4-nvkv-v1-5-b84db5e84b67@nvidia.com>
 <DKT5GWU3ARFG.25B1BCY0A3RS1@kernel.org>
In-Reply-To: <DKT5GWU3ARFG.25B1BCY0A3RS1@kernel.org>
X-ClientProxiedBy: TYWP286CA0017.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::10) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DM4PR12MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf294d9-c64d-45f1-d9a3-08df02749d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|7416014|376014|366016|1800799024|10067099003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: qNseCrat8sftrd8c7Iym6o58OjDgZZCGfXoG6WGMBOOaGj+MqqVEP8MMPSPEvOBihAnyYzSikxX/fNkEZLd7GdJI1QfRtHWnco2wyvz4SKslkyz/CUPMTx87Wc873xqoyUIMhk+BCePSMr7udiWa7uKsct0I6VeDlaYqqf7yKva++A6qJhSK7uZ2AhwfHMAjf3pVJsxPo6MqtfXYio6viBMdsSHUluBAHEE/Kx5M5N5N/SQOGWpx7JCl5HoIZkEr4mtWdPntinTiyJfMNgqQ0JZdadEVt9Q08qK0esjFiajTrN1jnsqaG2V2CrYawshGpkU+q6DwN6CBLw3zs7UNlszvrWK2p1V1iq6Nr4dAjHfwxTVUyHeJ8RS2kqdQDtFquvelAQ8ha7Ej5cq/ForuWO4rv1ksTebu8z4V+Jd9PZW+19+XsIBCGj630tXxK6w1zK0aDLZQRbQyaSb6fsVUx5vzptkd39E/Kj6pITTtS+kTR8+YyOh1IeDnJEmLygNPFmaYSUM41tEG12QLCNLvXi7vrhouTyoaTeXpI8iMDrEf0DiLogJeDxObxSJQcO45b6w7KKRFt7pYDcv8aLIKeGVguAVZe0wkchx3LKoFU4Be62xJ8rldqDXlX40rmrXZ5gP2kSy1G9fuf5kzfyaQbSNMi10f5pYFeY+kYU+nm0M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(7416014)(376014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cytTUU5yZ1lxbjJKa2NuWFJ0TUtGdzRndi9yb0wxdVRXSWRZcXZES0lZSG1G?=
 =?utf-8?B?RVNDbUFUQ2tKZ0ViTDBhYlhQRW5TRi9IZlFkQjRNMHZTYU4wbFdoS2dPT0NH?=
 =?utf-8?B?OGlTOFMwY0lkL0hDVkFQc29IOWZ3eStKeUNVVzdXWDVISTFTem9tWDB6YytR?=
 =?utf-8?B?U0hlbmlYZXpxeEw2MVhyMHo1MmY3WUdrcmVWb0tEcW5DWkZXZzJvYTVhWXdt?=
 =?utf-8?B?eTlNZ2pwM1h4VEdQblZpd1hnL04xWDNZMFJtODFsMlI4dkJqSUZyUzErWTE3?=
 =?utf-8?B?Y0NvVW41OStVQzZvcGNoa3JoLzBMcTVjRlNtNlkwMlZvRy8rK2dvQkJzVXc3?=
 =?utf-8?B?dnJZZVhyZFZqYzRLN1g0S0N2TS9rUVJNb2pwNTlJZTRnSWprMTE5UUNGUFJM?=
 =?utf-8?B?RVdzUXFyVnBSZXJoQXgyemI3YzBkc0NPbVVaUDJueExZSEh2T1g2alBUT1Vi?=
 =?utf-8?B?QjE1Sk12RVVJUkNsUlRZb0lUUjhNYkQ1ZnFoZWh3R1ZMTVFvYnZ4SmVNbDd0?=
 =?utf-8?B?c0YxYy9VWEdVK2lqM0RZVk0rOVR5K2JhOWtMUVl2dnFPQ3FISTZUem1OWm92?=
 =?utf-8?B?SXdVTGhsVXVMS2hZd1hKNXFrMmd1c09ZcHFvcmo2N1hpaHhzdnVDQ3dVMnVt?=
 =?utf-8?B?ZTN4MTZaQmszZFJuVjNEV1Jod0k2Z21NdTFVeE9BekZZL3RiNGprdFBrb1hE?=
 =?utf-8?B?dnhCRWNqRFlpVGRsTDBWd1dLZGZiOUJqWkRKSWw0NkhrWmQ5M29KbWdEMThE?=
 =?utf-8?B?ZlhRbjY0VWc4UDB1V2FJbDFoWUIyZDFZaCtWNTFwOWFqdmZvOHN2MzlxOUky?=
 =?utf-8?B?RHF6dDUyUEVobDJ2dC9BcXNpV2RjL1lBTSt0d0ZtYW9LY3VZTXovTElFSVRn?=
 =?utf-8?B?U0RQMlRsMHByOXVEVk5VcmZrdUpLNjBZUDQwNzR0blZhT2ptYkJLTTBFazc0?=
 =?utf-8?B?SFdmU2k5UGpidnFXcWNONldDWUJMMUJ4WFhZN0drOUNCaXFqQkhkVklmelZ5?=
 =?utf-8?B?YTNRV3BlWjNoTjVRTFpxcDNIanpjRjhsVE9JVzdwNHlPbitYNGtkTmxLTVRK?=
 =?utf-8?B?NzdQUlRIVGJoOFo0UEpqWmNPSXQwYXRYbUhwdWdReGxROUt1ZUxrM3VRaWJj?=
 =?utf-8?B?V3BoMXJMYjFsWUJ1c3BFeWNqNU9qcGIzMFRGbHJ2M1RoK2dXMVdzTVpuUXMr?=
 =?utf-8?B?Rk01VjU1Q0lpenRUQlgxcHRlRDdKcnNzY2p2U1BMbFFFQ2FocEE0ZUxCc05G?=
 =?utf-8?B?bVZKNUJwTDRYa0JubWNQRFUrWW5oQXpQUiswTlJkMWF5RjMwU1ZHTUIxRVNw?=
 =?utf-8?B?OUpDcTRoSi9QOVhrZ01hUytaUlB1WnpYYWlYc0puaFJZQVJwWktJTlM5Mkxv?=
 =?utf-8?B?Y05RemV4dWc3N2xhbGYvbG5KNnd3bjlRd2JCcU04cTdGeU5POXJHUWRDWUVi?=
 =?utf-8?B?d21tUlVISFpqUFlWK0sxZUNyd1hlRjFyL2VhUnp2ZHRzS21RblM5YUtXSGl3?=
 =?utf-8?B?c0RXN2JXb0FrUS8rTkVWdFBzTE9OUlpyMU1qODBsZTRKTmZCb1pSV2Exbjd5?=
 =?utf-8?B?QWdpN3liYVk1VDZ3TTNjYW1KUnpyWTQrNFBZTnRSTXB4S0lObzNHbzR6bHVB?=
 =?utf-8?B?SGpXdmIyQzJVanNQaGtIdUVWcS9rMHNNc0lLK2t4cTQra1FlY3lvRlpORHRk?=
 =?utf-8?B?ZjNhSE5xUkM2MW14UWY1a2ZOdk52RVVtZHgwdWpxTlkxT1NxbWp6d0dRQzFB?=
 =?utf-8?B?V1kvUUtZQzJaQ3Fjcm1CSWVRdFV5d0lMeGZMM1haV1YvWVBtNVE4dnRrcU8x?=
 =?utf-8?B?SG5VR1plSGZuc3FKcGtSK3NYVG9yTmptYkxKNmZBOTc1WGRBS2p4SklqUEZT?=
 =?utf-8?B?VkFlQVVISmdRK3E2M3A0MWZmZVIvSEI1bzVHdGhhZVZOMFZWVktmU1U3T3V6?=
 =?utf-8?B?L01RNXV0Q2gvd2h1N2dvTHJFM2cwd3RqakNFVk1WaW5MeU5lZ2QwWTBiWCtR?=
 =?utf-8?B?WTlOWEpsVTNjSWdOYWZjN0lFQ3ovK0I5cno0eEYwNUpRdE1YUzRpTDZqSzNF?=
 =?utf-8?B?ZmZIR01yMmlxWDl6K2EwY3lkT0pkcXlPbzQ5cGxIbTJ4dFlqNGcrZUt4cTF2?=
 =?utf-8?B?U095MklwVFk3a3FNelBsM2QycDIzaUdkby93M3VPMnhKMUlpNWlDYU1GU3lL?=
 =?utf-8?B?NE93VDRKSDU2aFJYT3hWcFQxUTVBUkhKMEhGVERuMjZOQm91R0dvS1VydkxL?=
 =?utf-8?B?dFRFdHkxTlVKVnlvaGxnMnhkYlBuR0poblhTcVNWM1N6TVQ3TDVQSWlmSjF4?=
 =?utf-8?B?V0RHcUdYejVzRUNWVTYwYlowSmZoMUNFUGpPdjlneU1oN0p5ODBhMTRxRWc0?=
 =?utf-8?Q?PsB1oQVkJs6it1/WHSQTCKvo1rpj8pL7n0Tje1XOkRic0?=
X-MS-Exchange-AntiSpam-MessageData-1: bVs7clXDf9iWWA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf294d9-c64d-45f1-d9a3-08df02749d20
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 06:46:38.7298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsTB8G7mqGs6YtKc7+cz7jbRqNrJGA4rPyS8l2gFc+fsRwskCl7BOJAfaBnK8tn6yrOxzzYWkoLQ4Ox/y7XOTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8559
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

On Thu Aug 20, 2026 at 3:59 AM JST, Danilo Krummrich wrote:
> On Mon Aug 17, 2026 at 2:56 PM CEST, Eliot Courtney wrote:
>> +/// A fixed capacity vector that holds at most `N` elements.
>> +#[derive(Debug, Copy, Clone, PartialEq, Eq, Zeroable)]
>> +pub(crate) struct ArrayVec<T, const N: usize> {
>> +    data: [T; N],
>
> This should be [MaybeUninit<T>; N].
>
>> +    len: usize,
>> +}
>
> Let's move this into the alloc module.
>
>> +impl<T: Default + Copy, const N: usize> Default for ArrayVec<T, N> {
>> +    fn default() -> Self {
>> +        Self {
>> +            data: [T::default(); N],
>> +            len: 0,
>> +        }
>> +    }
>> +}
>
> For anything that actually constructs an ArrayVec we should probably cons=
ider to
> restrict its size with a const_assert!()?
>
> For an initializer approach that'd be not an issue of course.
>
> 	fn init_with<E>(f: impl FnOnce(&mut Self) -> Result<(), E>) -> impl Init=
<Self, E>

Thanks, that all sounds good to me.

If we move it to the alloc module, I'm thinking to add a few methods
that I think might be useful (e.g. push). But lmk if we should keep it
to the bare minimum - just feels a bit odd to add something to common
infra that you e.g. couldn't even call push() on.
