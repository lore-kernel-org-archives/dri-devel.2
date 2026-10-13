Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E719CC6B08
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B350110E5D0;
	Tue, 13 Oct 2026 09:13:31 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010004.outbound.protection.outlook.com
 [40.93.198.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC18F10F641;
 Tue, 13 Oct 2026 09:13:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uq2ifRhJiwvmmuU+3kB0Xt1NXjghI58fNHUeBm2MCSEERgyMoT7xjoz1qSM03rt/Cuv4BvlcBR8XTgpHlYZo9ZZuB11ZIuH8dpvLwuIKx/T56LG6yeTFMBArHzl/zy3YsCoSYdvn4h1BGwiU64XNkKoedQH5Ir7efvt8uIVSO82mjn/N8o7TrT/nf7ZysFpBTkizQG4LzqbZ+7ZNeniY9zgkxH8KuwufghIbDOK+tu+ju5vfhWK9bhTqeva0kwVDSaE6mxLScmtxxfUfxuRjtqFiedqZUC1KmPCJxYV8hw/TL/7a7FnmcwLcToT3620bR0FnyYf9F+7ogSdfhI/wcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=db/JgfUiVH8DktDGinWYTooI6dM3qbtSKiZQt0XKV8g=;
 b=F9n2g4Y06i+hM7EiuRgqtvjIRH17QP85A/6c9lZ/S6BxL29TASGwDLw92cNKfweQwGk9FAllwyDcpqJicvrFqBGssp3HCvBF40tYdvx2UPIXOaX68crp9EVpSnJYKXTK6Yx4TqULDDW8xNk3i+ywMTM1oG49nmghNNa/wk6wRFdkR3kOwe75NmzftBEPi1DIokF67Gh5QbU6S1ShR8LQLBcw3y4kWuuTndcmsAUuW1ZpaK9sEgkp9bcQLbtAj8O28g37vSEepRI32OZy+fUhVwLJkV6HcaNJAjk4QM1E5PrxUIWcGedMq92Mw7xFSeEstM5lsBF6iKP1TlLJ9ZfM9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=db/JgfUiVH8DktDGinWYTooI6dM3qbtSKiZQt0XKV8g=;
 b=UoLRPNqisdi6U7SkVHph1j6Yb/uIODkDWQOasphbX2XvrQ1M1+g45UxhaTMWmUZJRAVkDg7RPkbcOY5VqbglcjPz8U+2J8YPXp36GTV+dvN0WT0pOk+1USmMyzVQQwCsUpgEgd/IiNhjyiWc3DSj5ZsGIVElJLqwoiHW2uAiub/bFaq4JdlvB6EpWZOumtXAE/WDVgHQoKTe1Tf+W7srHu48T0jr5Czy+fNh3XWBx46AOXrlxdAG0fev9XulkKOsc1ty0ZN/I4m6Q/TohnCFpLTxt3xoyag4dFsNaHVNtxZIz+lnP5jSWyVMYk5PPM12aWKIc4NjjCYSCR5qX1UkRA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 09:13:21 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 09:13:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 18:13:18 +0900
Message-Id: <DM3LFTAG2MSP.WQLXM00XA0ND@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 3/8] rust: alloc: add ArrayVec
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-3-f04504c262c2@nvidia.com>
 <DLYE5UBDLFYU.3RTMUE90DJPDK@nvidia.com>
In-Reply-To: <DLYE5UBDLFYU.3RTMUE90DJPDK@nvidia.com>
X-ClientProxiedBy: TY4P301CA0074.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::17) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: fa4cca5e-0cb3-44f9-afb6-08df290a39de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|7416014|376014|1800799024|23010399003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: IMRLTUJtwMozvyCcbwenpmiqUDxmJtQUZPMBfTI3VGti5NMbV1LBCN5MsT6uhICzw+ANjfv2Vjy3i/TQR3K7qYaJzEnvPUrts7kcnbxhBIfl4O1yV+ysaECq2foU07mEwo0cydghZNJdE90lsXaHeb1eDS01nxn7gy46VI3wmwChIN59IY7fyw6h1WT8tvzXvy8IH86nAyDJ4iH3c+6jrXHxtuHf4NdDmpBrG6yeVl0OGWZR8qRLnhxpwBxQ0pKOdrrYJOUhFiRRu4jhaAQYELaljqM+1zk8Xtry9jW39nqfYkWGEDNRh+Ofluhr9XiATaDCifJsqMHwJj3i/XPkhJu/pdQiGRlFciQ9lBAiFC88gAmItnUroSiib5bgPv/P9RCKiv5uXcHYU1SvTiZMiYFANtoRU+vRYYZR2YQ3z+/yjgDQXwn9x+dlNtt8F3BXR8K4XtPZ3MWi6RmscrHHy0q2iUL799AXWLfNq8Gef/pPjg7JllmqL+R81JVnQjUM4jFrNlIXK/5YQbuPmepicWxJjTGQS16zUO1n+doHPtLu1ZMUpiduXGA3BrSqLwPMVM8K1wpFeQOOkyErXo1HfEPphYrtdosaDpjgcWmpaVJHBsQUe3R64mrUgBhojFhQl0wEu036hOpdocOUkx6HRogqfEvEb2iR11+iezvZnA8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTVkTlYwOWd0N0V2QVIzT1ZMZmd2d0d2SFd0cDgyaDdaendLS0FRZTdpN1Ez?=
 =?utf-8?B?NFY2RFhBS1hmV2RIWXlZMmRBWXdTamI5Sks5RTBNTFZQcXlyZzRtWXZNVm1R?=
 =?utf-8?B?dnQ0SVozbk1FNi9LK2VnK2pmUDhOUlNON3VaWkZqaHEyUVgvcHdiTDBnU2F5?=
 =?utf-8?B?Z1JVdkJaRDl3M1N2blFmUTAxZXEyUTFDNXJWa1h2ZXJ1N3hUblhqVmpTR3BU?=
 =?utf-8?B?N1BEZTJqWXNzNC9RT2VYek5kVXpEV25OUWRHRFgvSkUvNjFrajRSTjRnd0lI?=
 =?utf-8?B?bnVHRjdRanNiQzQ3TTRURHN6a2UrM0hKYVdDaVI0T0d2eWhXRFBKYllOcUY1?=
 =?utf-8?B?bW9pZ24vU1lWcUd4ZklWL3Bod2VuS24ra0x3Q0VFQ3VMTmk1RjBvcVcrdGZN?=
 =?utf-8?B?SnYySnFJZVFqSVlVa05KcG1MMHNSaTNTSzljc1I2VjBBeFN6MXJaS2x3dzdl?=
 =?utf-8?B?cGROQ2V3MWw0ODZUa2xVYmY1WjZ1NXF2Z2F5WTFCUWcwMjlmeU0wbm1FZFds?=
 =?utf-8?B?dFk5MytSWjRrckY1NXY4S2gvNWJib0lSdERYc0pqd3JhNGw5eGtWTmhNck9Q?=
 =?utf-8?B?KzRwWHQ3UDkwbjJ3dWN2Q21ubDYzUnJSSWtUd3I1a0pmVDdkdlJsV01EODRa?=
 =?utf-8?B?dFg4bW9HUmF4OWRsQ2Zrd05hTGdTYTJ3QlczU2tDR0RnMmtlNXhVajR1dUl6?=
 =?utf-8?B?Z3dnRCsyalhvYi9ETVdKL2NjNzh1UWpmV3JpcWVLYTVhV0Z4ZG1DM0JpVUxo?=
 =?utf-8?B?YXR1QVlJMUhHczhQRzIyT2VXOG1KaVpYSmJXa01rMkM1YWlDM2xlajRnNU1O?=
 =?utf-8?B?RUtRckU1NXVjZ1JFdmltcHk4UnV6bGNUazlnRUNQUHhvMEZndVB3MW81eHlt?=
 =?utf-8?B?RHZnRWYrL3h0T2p2TG5JSjRkSFVnQ1JyTjllN1krOUJNUlZPNDc1TnNLS0pW?=
 =?utf-8?B?d3BBSmMyOEhsRG9RY2R3K1RhWEVsTFBpTGFwK3c2KzhxTzBXK21qUTd2K3Ra?=
 =?utf-8?B?aFVNb0R1RDBDT0hoNGUreGpiRG9PTFhhQU5LYTUwMnp5RnFKSmEyRW9wNXdw?=
 =?utf-8?B?K1pQSUc0L1pUV1BaRXFJbEVpKzB0VXdlMHRLVDdaK21kdEhqb3hZYm4zUWVZ?=
 =?utf-8?B?Vi9DRWU4SThkZVBsVDlaU1Zqc0hkS1RSK0xtcWRndnQ5YlFoR0ZpTE0vcmhv?=
 =?utf-8?B?c3ZkL043NkVlbWhqWGdiamV6aFlxVXZRRG9GNzBzYWVFWk9BQ3FMLzJOd0dO?=
 =?utf-8?B?RERqSU85SWNuNHh2OEtsKy9zQVhidGVlaXQ3YjBkUHN5b1JlckdmNVRjdStu?=
 =?utf-8?B?ZUtwdjNrK3RpMW5UREw0eEx5SnMxbjJHVUo5bG5QWjltWGhxcFMwZllJaEdh?=
 =?utf-8?B?c20yTkZzSXNxTU5nc0JiZlRXTGIyWU4zYVNtWDRNUTQ0bURJa3YxQ2FnSXBC?=
 =?utf-8?B?Si9VQVdBaW9UaEtFRGNSVGtBeTVyTHYwWE92cDhmUFJPOTAza0xvL0M0Wm5y?=
 =?utf-8?B?MklZdDRBWTFiZ0VlY2c2QjB0d1E2Z01NWnZXZmd6bEpkQk10bjdvb1B4c25Z?=
 =?utf-8?B?TE5jTGtXd29nZTV3MnJPZG5mM3FLYVV1bktMSE55QjlsOTExV3dZanVTblZp?=
 =?utf-8?B?Nzk5NE5PU2JJV3JxVEdRZTdWRkN5TDlWUGYzaVNBSmJvaERWN0E3NUdjVVph?=
 =?utf-8?B?QlhEZGJvUlNCS3ExVEFJYjdXSWZXQlYrOTdoMzBEWTdpQ3JoeGROY0ZtMU5N?=
 =?utf-8?B?aVNFSFRjUU5rY1RkWkJUSUk0bm5YNFl0SGgxclFqYTd4NW9EVUMrWGh2RU1F?=
 =?utf-8?B?dzBwZUd2ZWI5YzRDQkpXOEpQWHNpSk50ZHhVa1JuYWFhV1N4ZUU5NzJQNElt?=
 =?utf-8?B?Qk81YXBnVE1ubjRTbVZuWlFla0MwOWpuT3VFN1BOby9WdmVwd2ZHQk9McExO?=
 =?utf-8?B?NDdkZy9LbHNwSUdNSmtrdjBjK1k4QlJ1QzNvVFd0MFVKR0pMWm52Rko2YTkz?=
 =?utf-8?B?SE5iT2hvdGt6SzRCVElPNTZrNG1KL0tYWUNOSTRlRTArZGhIK0xLazFjUEF1?=
 =?utf-8?B?RWpDZXBVRWw5NzFCcVdGMXBOV0VrbGF5b1BxZTBVcmV6eGRXSmNOSFFuNHFm?=
 =?utf-8?B?THMzcGV5MkdGSG8rVVM3UDA1L29BWW0vRXBtaGk3TlMyQXdOY3ovSlkwU1BK?=
 =?utf-8?B?MnFGUkg5bDFTSDR5SE9Mb3RwS3dsWkM4V200Y096MEVPSUNsWU54aG1ZbHQy?=
 =?utf-8?B?UjU5MTZNY0pZckJSS0lTKy9JQ3NPVkFDMWZPblpZTm1ibGtpamtPZHJTZ1NF?=
 =?utf-8?B?blhyYzMyYlhWNVBGRGdjZTRCYWF2OEdJTmFZVVRBdVh6TVJNTm1NYVMzbUJi?=
 =?utf-8?Q?Ca0w31mxbrV/S8NCLQ48cLa6AxTQvEePccTknAiYE+tdz?=
X-MS-Exchange-AntiSpam-MessageData-1: s9gAFMmjIVlNlg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4cca5e-0cb3-44f9-afb6-08df290a39de
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 09:13:20.9176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwDcDmeN4kZLX7pOzvUea7SjxTRWVZC+JQw2efTGbc9wkaoNHJzhToK8IiyHzOaVNhpqErpfFTg+ib1DBgQiDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139
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

On Wed Oct 7, 2026 at 3:27 PM JST, Alexandre Courbot wrote:
> On Mon Sep 28, 2026 at 5:42 PM JST, Eliot Courtney wrote:
> <...>
>> +impl<T, const N: usize> ArrayVec<T, N> {
>> +    /// Creates an empty [`ArrayVec`].
>> +    #[inline]
>> +    pub const fn new() -> Self {
>> +        // Clippy triggers this even if the enclosing function is never=
 called, so skip if clippy is
>> +        // on.
>> +        const_assert!(
>> +            cfg!(clippy) || size_of::<Self>() <=3D 512,
>
> Let's make this `512` a defined constant.
>
> <...>
>> +impl<I, E> From<PushInitError<I, E>> for Error
>> +where
>> +    Error: From<E>,
>> +{
>> +    #[inline]
>> +    fn from(e: PushInitError<I, E>) -> Error {
>> +        match e {
>> +            PushInitError::Full(_) =3D> EINVAL,
>> +            PushInitError::InitError(e) =3D> Error::from(e),
>> +        }
>> +    }
>> +}
>> +
>> +/// Error type for [`ArrayVec::push_init`].
>> +pub struct FullError;
>
> This error type covers exactly the same pattern as `kvec::PushError`
> (even the debug message is identical), can we somehow reuse that
> instead? Or at least align the names by making this `PushInitError` and
> `PushInitError` becoming `TryPushInitError` to reflect the actual names
> of the methods using them.
>
> Overall there are quite a few methods here that are still unused by the
> end of the series, so this patch could technically have been smaller. I
> think it's fine to keep these methods as they will inevitably become
> useful, but it would be nice if we could simplify the error handling a
> bit, or at least harmonize it.

Both suggestions (re-use pusherror, rename pushiniterror) sgtm, thanks!
