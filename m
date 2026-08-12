Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B41C5B567
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 04:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BDEF10E3C4;
	Wed, 12 Aug 2026 04:54:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="uQnKKt7p";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0042810E3C4
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 04:54:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsDsvpuJtPTJ/fTf1xBrLLcTMgwTbjmzfgyujNLZmEHze6eBnkaW4RqUD+y47uY2WQJh6+5R4vi6R85dKfL3ptsHnzan8+tgz1KlMWb+Ttv1qQ3VYhbEgtjJISMiTMRv4tdusUe+udzh3m5YG8wWlX3oTgxFw3CHgG3bqiThNO7dCoaMdTnCk2uDZEOmmTXRvtjBPg8bKE1sS3f2uR7cB+Dv6lERZDbx/r3PHJu0AserMvNfjHmKKtY33WYLjd73EeW5FHAWykBWRD4LdsDbGjERC7zZdXRTNseqtTXKt7LV0hxv/+GuT5SbL+kCFhlnSydzrzI2ChCBbe9o/u0TgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rok45ztNSmF9ZRXC/EGtLZX62x96TmNIGSdLHpa+sSs=;
 b=FhTPk3d4r69G/BIw32rV9ZuxpsKmtdHHtiyeeBVcN4yr7r2DaCwGc2r+QkumfysUdkklSSkRWOgcmwOjepOOw+4fkm7F4TRRTV+j9FygSLkubiop+jE0FhOsnmDAuzjUQPu6He7RqzWhADERCUWxeUx/usEZr4O5GcHsRaKHmkJC4Yh46eoFV2fRMl9juMcTg29jn4UxmCEEfl8MhZx8UcwbM1D9k+kj+dUm3uNJFq31GEHqtTNRqfTBxwGuhob7iju8yyTAgfxEdrb/lafXQwwMj5zfgJOYP3Dear8BOPxiBHsubZym7mlldfUT2uQmKUmxd8V9QG3ZsMNXI5MK+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rok45ztNSmF9ZRXC/EGtLZX62x96TmNIGSdLHpa+sSs=;
 b=uQnKKt7p1VSkrfjXY6Vbr7faHhNdVmI0hLbZCs9AZZfxFb1dw6aKp5NsRSlxovqzJpdpHcSO+MINI/GaB65ytXt9+2GkijcxT5zL3jIwrogdLfWSYghTqn4z584t2iNJezjvmikpbMShmmK3GIIsewHHW835oIlpgzrmkP2dhI++LVR5QWcKZJRIh5GPVdCe7D1f0xdkDj9lopW6kFvPZBBp8Z4iw+jyadY5ARL6s2prrx/dpL/tiO6axZuUKJj/xIr2F3zqV2vdhRrbxqtwVMh7jlBqSPE9oGG3JEVCTSUD3TDWSaMxknnqjDZ6eFSpc8sGtDkpV9bVMBtZ6xB0ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 04:54:42 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 04:54:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 13:54:38 +0900
Message-Id: <DKMP3ZMD9FRA.2GV3E2SMK8O9A@nvidia.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>, "Joel
 Fernandes" <joelagnelf@nvidia.com>
Subject: Re: [PATCH v2 00/12] gpu: nova-core: add PRAMIN window support
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
 <CANiq72n9TaUgWgZYg3Xzm2mn3Ed36B7O+f544a5BXik_XUh8FA@mail.gmail.com>
In-Reply-To: <CANiq72n9TaUgWgZYg3Xzm2mn3Ed36B7O+f544a5BXik_XUh8FA@mail.gmail.com>
X-ClientProxiedBy: TY4P301CA0018.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c50d76-80a2-4686-746b-08def82dd239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|366016|1800799024|23010399003|4143699003|11063799006|56012099006|6133799003|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: k/vyM0XurNOTzaDf1AUfduEwgrOIhlgDfsQy/+8uXAI08GugTufjiZHQjPKZtmTZU+f3Fw9eTSv5SqPMbfLM4V2b9kWhS9fWFLR3zEgLIo6U7/7URPeWC9ZaXoxe+J7GmRIoMRDzPTWdh24/FX8nO+Nb0IiVJSsz4HubiN8UoSegNXw7U4p4yQ/KFKab4K7z7lh8TxvFrmRfomrnTPMwxQba3a21GXILVBFCM0sqHBShaB4241bOYa90+q/c/TfhFNY0WOnqk/5uVnp1NS3OO/2RX/9IxIn4dJ5ByG/GCNHmIn4k3m6qrKmx2LamGrmD2MFic3cSzXVJ1VntYUvdi3PZzhDivcEvYMKQeiKJQ3MBAQG7NKhME6xIRNBPG63WFhyFOmyo+qki9aD0RMrGrz1eJEnhUyJ6PeIhuEK4dArj6p1AJUsVMkd6x/SnWyN99qzLuogfxtCmDiQdNET/9jMAm59/NVktSqoZLpkCB1nZvETeuCOIwUgEOrkBRci+t/R4tsiGwasKvEjN1N9QgujeCzr260DTUYBg28j2owiLAl/fn5Ym6GC54K+ywzwXWG0D8br/kaQZVHvsSJuGJsB9SrW+PAFFGmopM6JqcfVQle+LYQzJUdG+OLDND4xxZwJ3uOTlewCV/FvcBEvIw2ZIxpeiMfhV9AiALPCmkqk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(6133799003)(18002099003)(10067099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnRXYlJUMzc3d2NZSWRmd2pGNHpRYmxycmhDaG9GZVdOU0I1UGNZZTl0WXc0?=
 =?utf-8?B?Rmo0aWtUNUtpYzd5V0JyZDY5bTBqZWh0UCtkT2tzMWJFRkJkdGpkQ3pOZ0hJ?=
 =?utf-8?B?WTI3aVVweVZCbDBYWjZVUllVYkhQcm5mUzloajIzQkZ5NTRKQTRLa1FtVk9W?=
 =?utf-8?B?WHFSQ3RHUnNvZnlMVDM1SW5TcTQ2TmkrWHVPb3kwdXA3RzBTbExlZllPSzZX?=
 =?utf-8?B?SkNZMjhka0F4ajdiK0NNR29zOHZVTFNmcmhlRGN1M29HeUwrTThvbkVkM3Av?=
 =?utf-8?B?VmRLNStpYW15amdLWWJ1M1ltQ0lYOU9LRENmYnJJUjlCMkx5aEVnSEJlcHZF?=
 =?utf-8?B?MWZSSHlDSllQcTNXamYyOUVHZ0JhRGZ1VG83RFc0bThjcG5oZWVWdzBoZEJN?=
 =?utf-8?B?dlFoZFZ2eHhzRXlGOGpkdG1vYzE0U3A2WWRJVVRhNlUvUjI2VEN3dXNHZkdm?=
 =?utf-8?B?UmZJZWNYVDRVS2pFa2ZQbUpPUUJzOHRGMEw1SVo2WjVLbUQzeXN0RTZwUDVh?=
 =?utf-8?B?aS9EbXc3NytjSzBlckh1VTBmZStmY0RjMkhNTVpMUXpjRG1sQXFmQUdmLzZv?=
 =?utf-8?B?eFJRWGdiVGJmL25KWTFuSml1UDJCMU9lK29EUkE3eFVKWU8ybXg5MVZ3eDF6?=
 =?utf-8?B?SS9mU0lSUHlwN3JEUjVGdk1yUGJvVkwwNmhRRWcyb2lvNE9lMEJDZ2tYNTlW?=
 =?utf-8?B?aHI1MG80aktmQTlYT2lGYmRCWnBuWjhGOFVVTTVUekhaeHhQbytKTHhPdGk0?=
 =?utf-8?B?V29HaHlmSFhkT2NkNlVKSTRaWU9PaDlZeW40V2FvTjhwSXFFcjBmbGk2MThR?=
 =?utf-8?B?clUxbDdwcFNJK0NIMm9kd3RTN3NndTdiMWNUU2E5a0N1SGhNTGgwNU56ajlJ?=
 =?utf-8?B?QWxPUjRXMzBqQVN3cVFiYVJmUSs2VjQ0TnozbU1yWTdHYjZ6TGZYOWh3dVph?=
 =?utf-8?B?V1RqL01Cdlkxb1NUREVacFZadjVZSk1jT09McXlyT0F0RHh3OUY4UElPSGY2?=
 =?utf-8?B?NGk3NFFoM1Y5alNMVkU3SVdCVTJqZlVoU3hQK0FVMVFSRzdtOUJUanFRbzB2?=
 =?utf-8?B?dy9nOXprK29wdy9penpjUitLamo4dHFPK05sUTc1MzFLMnhSd1FqUTRIbG81?=
 =?utf-8?B?NjlzS0dYUDI2cUNkamlOcmVXaE83QVBzQ0RsblU2bm5pcndQK3U0WVhmWXlq?=
 =?utf-8?B?Mm5lc1NtVWRxSjJzaUlxejg2MXVzdHZSMzhJMENDZDFkZERnNDVRbGpZWkNy?=
 =?utf-8?B?czdGQTlncWVhY0dhQmxHWG9mTUVMUVhaZ29BQjRvUnNXdk9ZYmROUjIwMmsz?=
 =?utf-8?B?NitSZUVhNEF0ejFhVmMxRnF3eTdpSjBVbUt5SHAzYzlrTDEyVFJiN3Y2cS9B?=
 =?utf-8?B?OXBqVlR5a3pGTWRpUDljSHVhQWpDS3dRdk9GQXptWDBjdG5BTmQ5S0RGL0NM?=
 =?utf-8?B?ZzBiaUhVVjRWTDgvY0Q5UDJlaVNzYVREWkN0Q1ViMEdVcE5SNG1oYmpqWWF4?=
 =?utf-8?B?MlVvSkhLTWY0ZnBKbWVsbTkxdHoxR056Z3h1Vk0wcExtaVBwUTFuV1A3OEw3?=
 =?utf-8?B?VGhEWDAyV3hCRkxFcmp2bEJRNE1VSlUxSlRra1Bpb1hNZGE2OHdzWnJXT2s0?=
 =?utf-8?B?YlBXMm1ieWx0bVZPV1hidXRXL1JiUjA0ZDhpSCswYlFPNlFkVGJrcG5PWEdC?=
 =?utf-8?B?WWJLZzJiNGRoSjJORisyOHAyUGlYaVZkc0hvaC9KNURPVERmcnRmUXhYVG9M?=
 =?utf-8?B?dWk2VWQ5VTRrSFhtNmwrN1E5TnNaUzVMUlJxQkp4YU1qTlNwdHVUQXBHZ1Jo?=
 =?utf-8?B?Q1c4czJTRC9QSTlmQzN6RkV3ZWJWTk44Wm81QVJ0YkxYWXUvbEF3clVLUUF0?=
 =?utf-8?B?S0hENkt4M3FjbGsveWhUVVZKUEpiRENuM282bVVmd0tnZTg2WTMySFNVYU8x?=
 =?utf-8?B?dDZCQ3A1d3dIQ0xSTW9EYmc5Vk9HTkVEUUJTcTIrZWViRGw3NXJ4U2p4YWhw?=
 =?utf-8?B?NzAxQXNGcjJpYXJhRzlKNFR6M2dicDlvZ1NzK2xjZmpNeGNocG0rc01jck1B?=
 =?utf-8?B?QVNNalpHQ3RWdlRkOWFORk9ZdVg1M2xGQklKMmZFclNoU3pZWUZLaCsxamNv?=
 =?utf-8?B?YnhwY1F4ODlaZ3Q1bHJGd3dRdEpXakhGM3lkeGVrUXY4c0k0OHFNbHFYendl?=
 =?utf-8?B?b2EwUFl2TmZNaGloK0xpdTh2WHN0MXA0S3Y5V2szdXZIWG9SaFZsR0ZJTTFJ?=
 =?utf-8?B?MFNVZzVXUXdack1mckY1a3NOcGdNdVZsRmpJaUhOUlJZZ3VNQ0lTV0VlYW13?=
 =?utf-8?B?QTB1blZJOG1icDBjTm1Jbysvc1ArUjJKVTZsTkFBbUFmTDBzY09iSmRFNGpN?=
 =?utf-8?Q?4tqNPJ+tdQr5BzaWlvV7Evz2xNC2BcNoGIAJ03FNWoYPt?=
X-MS-Exchange-AntiSpam-MessageData-1: M2+Om4hndQl9uA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c50d76-80a2-4686-746b-08def82dd239
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 04:54:42.1330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Dvqbzw+pQT9wIA+Z/xQIc5/OTuGj7iJQJyA7gYk9fGuORMA3z8XbhozEAuvzDP+GgDbn3aM+cEUJvuqA797SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088
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

On Tue Aug 11, 2026 at 9:31 PM JST, Miguel Ojeda wrote:
> On Mon, Aug 10, 2026 at 3:57=E2=80=AFPM Eliot Courtney <ecourtney@nvidia.=
com> wrote:
>>
>>       rust: num: use const_assert! in Bounded
>>       rust: num: reject Bounded::shr overshifts at build time
>>       rust: num: add Bounded::shr_exact
>
> Applied to `rust-next` -- thanks everyone!
>
> Alex: I didn't add an implicit Acked-by to the first one but I assume
> you are OK with it:

Yup no problem, I did ack the previous version that included this bit. I
was just a bit slow to react to this one. :)

>
>     Suggested-by: Gary Guo <gary@garyguo.net>
>     Link: https://lore.kernel.org/rust-for-linux/DKIY9YGIPUUE.SZD2DUQM9NG=
K@garyguo.net/
>
> The second one is actually fairly important so I did:
>
>     [ This implies we can break the type invariant, which in turn means
>       we can trigger UB via `Deref`, e.g.:
>
>           rust_kernel: panicked at rust/kernel/num/bounded.rs:528:22:
>           unsafe precondition(s) violated: hint::unreachable_unchecked
> must never be reached
>
>         - Miguel ]
>
>     Cc: stable@vger.kernel.org
>     Fixes: c59a2d14cd24 ("rust: num: add `shr` and `shl` methods to `Boun=
ded`")

Thanks!
