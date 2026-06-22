Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1BACDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8DDD10E62B;
	Mon, 22 Jun 2026 15:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="j3xWgp1n";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AA1910E62B;
 Mon, 22 Jun 2026 15:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4zzIyYdbBJqtIZTlTYvPceniRp/hjGuT+L/UE1oHF9qScmpBlbJC1ve115B1hPn5x65JLBk2NSo+8pIiQQMxzque1AB3WGQcNFU3i/k0loD1MLcDhllW1kigoQ3Mr3WaVTIvmBFsfCc3TidnJ0neuaWiTYQ/uxGSnOJXO1bTQaU6LFQvpCByde15Ei5ZgEKlmnuIZeAWPW8iDw+bEmBHKujZ6JYcUkMY8WKVubBVTBXXa/GLyS7JNEtpDZBTlg13glEtfgkQ8xRI1x+3Leltx0Wah72cAR9QIy+VUxh1WYJx0jkTAV3r8lx7J29WrQyCRx0hEazh7aKAsiZfXnfSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4dAB//9V3Nx8nEkHHY8I/OXoQ0E+/8k7aGIZLFpYic=;
 b=nMcQRI2/FK6iKceMNgw4Pemw20igRv8d/SvjxZBCb+bGCiiWgkmm/8Q10Dd5ifUOdIiOntVMR+91BfTFhy1UbDKTN9C1a6G2iQNpcTeqhSuF+SUwNrdnK9ljhTBBYHfr8r0YbgVeR4ywAI///knVHTcP9BggiCUi+xvRyyYm0jaDm0FToUVrTL948iTesMv/A5d4823BkjXQjzCOk/f2/8ls+5XsZ4FKszmy0bcaeD0DjIns7Dd9dKrn6QUIrXIWwH5N1boLeuXyyONHeEXVQfX3pNoSgBBmIAoNnhhHSKijsrJxPDL2LMbFuBoiT/iIMgP7G2OsDWysZucmkL897g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4dAB//9V3Nx8nEkHHY8I/OXoQ0E+/8k7aGIZLFpYic=;
 b=j3xWgp1nFzNTPMsS7hMpIT+ajeR+EvMk9NJ/BcygPplkiHEQ5s2Hxm2PRPFoPQuZZkntGnqszAmkhAVdTIIkXxqL/8nm0HPC1D1ypae3EzM8haGksnUm4aqaNVZGD5UKUscw9Njb2BqJ8tVZUjcxJ47bxtjvWcUTzls+W/OEZUKehPLXNVM3DJ8g+SZLfaHewfVPEtiOsPkHnQEA9d+EmzftjbY1vtr4x5TpuQJeKnVhNY7D22Dq+wGbSuLjuZmeYlgfM8v1wnR/CtLJQgwhIkUh1Msu4XGe9iN3XYo4fcLcIdop8bXxGcLaKWtaY1BH2v1zKNrRmnKdJeFOJOeaXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 15:04:44 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 15:04:44 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 00:04:40 +0900
Message-Id: <DJFO5A5XN2EO.22B58J2O6D4JG@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 3/6] gpu: nova-core: gsp: move boot code into local closure
Content-Transfer-Encoding: quoted-printable
References: <20260619-nova-bootcontext-v1-0-45193cd0a2e5@nvidia.com>
 <20260619-nova-bootcontext-v1-3-45193cd0a2e5@nvidia.com>
 <DJFF1W6VGY4Q.2PV5MEPMFXIDB@nvidia.com>
In-Reply-To: <DJFF1W6VGY4Q.2PV5MEPMFXIDB@nvidia.com>
X-ClientProxiedBy: TY4P286CA0044.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM6PR12MB4313:EE_
X-MS-Office365-Filtering-Correlation-Id: d97c30b5-26b4-4e6b-cf7e-08ded06f97ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|1800799024|366016|376014|7416014|56012099006|3023799007|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +umEuMKCRAT1akODWznMpao2a4wH+orpRZGbB38A6Y+d08F1If6ZlgsMxhYz39VyuDDjCjxl9EPirAe3tFAUnSwW2EL2drrAiDrnK8ce0aiU4Rym9BxGINXIK0vOuoZbE8p3N3fTc1w2qzc0IGJLOlpJ4SlEPxg6UIDumHoZOCE6nhYsI2N4v+Fwq5Piiks7IImOSHBPOyHuKC/HeqXA9OT1I2AS9h/7i1wyK4ehTCC6G99NgVKL6+Z0MFmkqgJ6ISuJLs171O9ex9vvQjomRjNZZJZUJqJhJsz3ulSmt7YJ/Xq7qzvIyWOfJFutUT1vjglGRcSbUIib6cNyfshXAHrOmpmppLCvHcZkH2+4kvRo4OsMvqsDyzN+32dbOt/f5mIh8LayrTc/3PtlaiF9ehkAck/hDlPXsljCrdHuaqOcgPYREmR1Heyvt4AyZIbYggQv/W4gyHWD8St1A9c2R3ejJ3x7jjf8l+M7LBv2/rOhexNcYCRF2lTn3l0O64saM0duxZOJaaKynprb732ISLRcO/21NGrxPapkK+YJhbSVcAWw3QLBb6fvO/WVmDctglzvzpp3bOxadoRy8my2NXG2xla7plX0/T9fzHWHKwz7BZG+bzMBeMSHsJSzXkN3g1mPdrW6nsCqkL1Lg9yFUM9ZMiWONoIVvUNuSkGKuB4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(56012099006)(3023799007)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1R1MzZIR092V3BINUZWMjM4R21BaUd6Q091V2pWc0RWWGU1SlZtTk9ETG13?=
 =?utf-8?B?TGdRU2ZkN1lERGdtZjZ0eWl2bUtiNTdxZ29tZ3NOb1VuYlNjdFJFUnltYXVM?=
 =?utf-8?B?SmQ3NmZId3VLc1JZU2k0SWlacXRneVdvTHRSd2pJSG5nYmdoOXFsRzlKTTQr?=
 =?utf-8?B?d081NCtQa2w0bkY1WWEvUFYwWThTOXNkTWZnNktvSnQxREVMbHVkNWtUdW4r?=
 =?utf-8?B?TTZraDBFTEVaMzN3V2xibURSUzFJWjZEbjVod1dyRmpxcVY4MFZZbWd1ZkdH?=
 =?utf-8?B?RE9aOGVUamEvRlQweGFRenZyTHhtNm92Y2daNGNHY1BBcldEQzdnV1d3U1Jj?=
 =?utf-8?B?Z3dsVnIwemZ5cExMVmo2WXlKck41WHNSdGVkcEJCaDhSc215QzJJT1ZoRkpr?=
 =?utf-8?B?V0ZhUC9OS25aRmpOamswdnlVaUwxWUdCR2p2N2NoY0xmRjBZQ3JHVWdBQkdL?=
 =?utf-8?B?ckx1TVFYOE9JRXJkWllYMmRPZm5KQlZPQ0xLN1lDTGJWek00b0hkMHh5SG91?=
 =?utf-8?B?TG82aWxFcCszWDJRNVRERWwzdFBFMDJsZmRaWWszaVJlR2plSlE4UEtYK0Fr?=
 =?utf-8?B?QTAzUXhlQlZ4OE5qMGxydmFsdkljOHptWDd5dVVyNGdkSFYxaVZNTFVIN1Fk?=
 =?utf-8?B?MVUrVk9FSGJNRG1qdWlYMGtIOVl3dGlwVlA1VHZvS2h2V3Y4MytrdUUrMjc0?=
 =?utf-8?B?enFvOGR2T0NXRmVwS2NKNkw0Rm5HNzNqMUJoNTBBbndKeDE2aEdSd3MzRFNG?=
 =?utf-8?B?N2FVYzVFVjNiV0I2NWVROVJzR3I5aU1vZWhrNGZTVUJrZG1TUHM3WUcxSFRj?=
 =?utf-8?B?aU5MMXZ6SkVwaXRoMXRCbVhFc3FjbDhNakc4c2p3S0JvZDJOdWRvdGpUTnRF?=
 =?utf-8?B?OTNvb3FuVWt2YkNQbGhDb3NranUxdnQyTDFhUzdPaE5pcVUvbUJqZmpPVUtR?=
 =?utf-8?B?Z1lwT3ppNW8zM1RoQW5rUFV4RXpNd0NJVTV3YStXZlhaK3Jwb2g4MUNYMzBH?=
 =?utf-8?B?OHBzNzM0dkRIU283Q3BaRlB5Nzlkd0hrOHVRY3JBbVREV0p2SlVOR3N0Mmlv?=
 =?utf-8?B?UHl5QitHeHFzbG9BRnFjK0JOcGsvZnpmY1l1MDY4Rnh3RHREdXBpZWNjemdl?=
 =?utf-8?B?RDFEMWpwZWZTWFJ5WUxXLzY1Mmdxajg4S2lXSGVPWW4vTXpkZ0trQkZkWkRt?=
 =?utf-8?B?b0JXNG45L3oxeUdNb3gvb1ZncHJxVWlRc1RONmg1OWxiM1F0dnkrbEVrQ0ts?=
 =?utf-8?B?cUV1dUR0NDhaeUQyOUFmUXpHcmVLeGw3K2VCb01US0VoZmV4Q1JHZ3d5OVN6?=
 =?utf-8?B?NjN1b2ViMEdtNCtleXB4WkhJVmhobnVGeU9MUFNIY2VrbXU0cXlUNm5hN3JD?=
 =?utf-8?B?VlJEZGRRZncwenY2S1JFRGc5czNBUmFjWWNFV2V5bm01SzJVU0NBcGVVcjBE?=
 =?utf-8?B?b1ZGZ3NPakNwSStjZy9aSnBaZTRqbERJR1c2QUc5ZG5TcTkwaWQxUlZONkto?=
 =?utf-8?B?VDEwR0VJdkVEZWJRTlNXN2ZjdERRZ01IQlBLZXA4Rlp0L1NkUUU0N3NadTF0?=
 =?utf-8?B?dU9vSkY2VVcvRFZxRFBoV1dWTE4xS0hUNDBVT2dsOVNtUXc2elVnSEpWYzV4?=
 =?utf-8?B?OGkrVWsyVDUyZVZ0STVBRGtQSHRNYytLa01DbzVoYmozWVllbGp6WjkybVMr?=
 =?utf-8?B?dFlLc1d4ZU5lRjgvZEtWR2Y0TzNEUnBXcWN3RzRTSXpBTXBLcFlMVXR4ajIv?=
 =?utf-8?B?elgvcm9nallCeTd0b0t1czNpRnFHVXRJNWdhYnJ4V0xhNkxBaFZqMzkvN2VF?=
 =?utf-8?B?UkJGODhRMC9SM1hLa3lTRDlNVFRiSUZtaTFTcC9uRXNYVE9hSTREcEtDSFhx?=
 =?utf-8?B?ckRQNTVkMzhneGg3VUxRMEJGOUZsUXJRWGlGRjF1TEVjRW5SRDY0WkVDTDVJ?=
 =?utf-8?B?Vnp6dlhKMWRoeldyblVsdDM0M0xrWitMMGZkdVY2aFpOZ0tLZHNVbWF0cWhx?=
 =?utf-8?B?NnlSeW5ZeHB1ZlJiNTVsUFJ5UTlKeEpqZkdnK0Vid0Z4RWF2TkhLeW5zVGc0?=
 =?utf-8?B?c0VOYTl2SWxmYUNMT1lJS0s0NEpHRk9rbkgwbGdoQnBFSzZhOTI4WGtOTzBl?=
 =?utf-8?B?aHNEUEJSRnNnL2lzcDZGSG1pcUZScGpKdWV6VWx4R0NsQ1h5bll4c2twaXBP?=
 =?utf-8?B?Vm83RXdzdUpwcm95RXBEV2t3TTRNbUlrOHIvU3lJdWxDSy9sME16RXNZVHlQ?=
 =?utf-8?B?cVhxdU5GZk96YWJyeXBYMXZZd0J0Q1NrMHFKMkpEZmtLMHlHZUt4a3Ruamti?=
 =?utf-8?B?dVRSRUVTZHZ0WG82Qkt4ZjF2SXczY3crQ1JJV0tmYVBINnBTU2I1QXpCKzBa?=
 =?utf-8?Q?vbyVKB+tGQxxkiEFA5S2Ot5nVP/xcLRKMSttWM8S1WCOq?=
X-MS-Exchange-AntiSpam-MessageData-1: yh1dY9EwfJIZcg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d97c30b5-26b4-4e6b-cf7e-08ded06f97ab
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 15:04:44.1625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRDgp5DLGq52PDXD5uPOSXHPPiTNpeTMxtCg+jmVci75JqjkWd9FLy8FSES78+Kyxmb0ZQvMhacfuI8V+mPrSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
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

On Mon Jun 22, 2026 at 4:57 PM JST, Eliot Courtney wrote:
> On Fri Jun 19, 2026 at 10:42 PM JST, Alexandre Courbot wrote:
>> The next patch aims at replacing the cumbersome `BootUnloadGuard` with a
>> more local and less intrusive mechanism to run the GSP unload sequence
>> upon GSP boot failure. Doing so requires running the boot code in a
>> local closure, which changes its indentation and would make other
>> changes difficult to track in the diff. Thus, this preparatory patch
>> moves said boot code into a local closure that is run upon construction,
>> so the next patch does not need to re-indent code that changes.
>>
>> This is a mechanical preparatory patch to make the next patch easier to
>> read. No functional change intended.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>
> I agree with removing BootUnloadGuard, but I think it's not great to do
> a bunch of lifting into closures then manually handling the result. It's
> error prone imo (we already had several bugs relating to this kind of
> thing). Instead, what about just using ScopeGuard directly? This lets us
> avoid lifting into closures (which is a bit noisy) and avoids manual
> result handling for failures (which is a bit error prone). With the
> `GspBootContext` it's fairly easy to do now:
>
> ```
> let unload_guard =3D ScopeGuard::new_with_data(unload_bundle, |unload_bun=
dle| {
>     let _ =3D gsp.unload(ctx, unload_bundle);
> });
> ```

Yes, initially I wanted to use `ScopeGuard` but ran into issues when
trying to make the references mutable. However it looks like you have
been able to overcome these issues, thanks for taking the time to craft
a patch!

>
> I confirmed that it's also compatible with the v2 of this series that
> has the mutable Fsp - you can stash the context inside the ScopeGuard
> data (then making a &mut reference to the stashed context for brevity)
> or have a separate unload context type that doesn't use FSP or something
> (could later be type parametrized along with Gsp, for example).
>
> For example here is a rough diff on top of this patch series (you can
> change the Result<Option<UnloadBundle>> returns to like
> Result<Result<UnloadBundle>> if you want to centralise teh error
> handling of a failed unloadbundle although currently it can only fail in
> one location):

Yes, looking at it it looks like a cleaner approach than using closures.

The only thing that I saw as a regression is that now each HAL needs to
call `Gsp::unload` itself in its own `ScopeGuard`. I don't think that's
the HAL's work - `Gsp::boot` should be the centralized point where this
happens.

But we can make both work if `unload_bundle` is passed as an output
argument to `GspHal::boot` instead of being returned:

    let mut guard =3D ScopeGuard::new_with_data((ctx, None), ...);
    let (ctx, unload_bundle) =3D &mut *guard;

    // `unload_bundle` is a mutable reference to the
    // `Option<UnloadBundle>` in `guard`.
    hal.boot(&self, ctx, unload_bundle, &fb_layout, &wpr_meta)?;

The boot method can fill `unload_bundle` early, and if it returns an
error then the `ScopeGuard` will be able to use it. Also, and that's
nice, the HALs don't need to use `ScopeGuard`. But output arguments
aren't really something we expect to see in Rust.

Another alternative would be to separate the unload bundle construction
from `GspHal::boot`:

    let unload_bundle =3D hal.build_unload_bundle(ctx, ...);
    let guard =3D ScopeGuard::new_with_data((ctx, unload_bundle), ...);

    hal.boot(...)?;

It removes the "1 boot -> 1 unload bundle" symmetry, but on the other
hand it also splits concerns more clearly. And it removes the awkward
return type of `GspHal::boot`, which come to think of it was another
smell that things were not in the right place.

The main drawback I see is that we now need to build `Vbios` twice for
TU102, since it is needed both for the unload bundle and for booting.
But the solution is the same as what the v2 of this series does to
`Fsp`: the BIOS is a GPU-wide subdevice that is likely to be used
elsewhere, not something to be confined in a GSP HAL. So I say, let's
extract it and make it also part of `GspBootContext`.

How does that sound?
