Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C07BC5DF97
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 02:30:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C41810E090;
	Mon, 24 Aug 2026 02:30:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="MJUdz4z1";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AC9E10E090
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 02:30:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNiqtaT0DmH6+xB39Af3hqUsaEJ9Pb89KQfdPdjKExbA15SGyvYQvvP6os4wYdU+1J/LLNgUkGXHhblxzMh3/cXJN3dj1eeC/INH12+zUFZR+CEQRfTE8yJ+gUUmMJKJW4ywGzGmG3+sQ/hxojSf8kkTF5ovUH/lrtFrKu8aPaowR6eL29ntGSujbexZk8mTM1oGqLQyip9fg/xQAQZcwzVkZvFjvcfttl6+4QLb7QyXE/znq0b3E8s3E/qclID6Jy6Q5rVWt+6R1+HwkENEcKT6LoYpvFJ6qQPDTRvmD1zFTDrdXHdGmu8TFXOBkuNHjqIAjkIqAkHQ2Vudi3sJRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+0k1GC99zwMVFvPoTyn0+hqwDv/ZpAMz74XArkXQlk=;
 b=vLM1RzjEKzU5pcnnrN1yQZGw0i+Fn8v0AWtwtpR3pke1HulolFIJ0rOpJMIv9yiHbTB6rWtrael9CwrKNVVWWRtSBUkEZpcjnccBQVFWw+SWh32PwMxBOZl/RYQyUIFrcIe+0hs5H0n5ezlnO9yE1ELCGoUoT+kbSEIyvuAF2JAD6aD3ahvyfplEQhkRwFQib1NPD+xUorPA5maKqIUzNBdQ7mEWFABCJkjkte5BvejvO160XSfkrCXc4zMyt0IuhZj5zasVWU5PhroElnXMIWniEbfgeh1Q1muMbXpVQt9dMyIEp8peCUBCIJPFRtojp8MdR94ceYQ74ltJzGRAow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+0k1GC99zwMVFvPoTyn0+hqwDv/ZpAMz74XArkXQlk=;
 b=MJUdz4z1oMHwEozRBFcMYS45SKg8mpx1yjZMoPffw0YM9ygBqLYGC7SShkOHk8BpTXDQW9UPdr9Ncc2thB8uehCCHFPQesJJqYdoJ2PrOn1I9MwIieytqkR4Us8IVVHJf5hy9gu67gQUVyynHSy2/fECYgyPsl4qhK8GBR5OQfn6+/XghU7lazY/0yhYBqqoNWcSX5LdaUYADAnz4Jr5QwGqOwgfBu8/oIYGbqbkLrRH36k3jzufG11mFdXdHgeRXQQzEUAsNcRadcyCt6K8zOEaeUnVU3035DOf0t2QpVTp8/yW4lNOYlmEdpDLB6467rTxT5DVxyw4RXiqi9p3RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SJ0PR12MB6805.namprd12.prod.outlook.com (2603:10b6:a03:44f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 24 Aug
 2026 02:30:25 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Mon, 24 Aug 2026
 02:30:25 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 11:30:22 +0900
Message-Id: <DKWTK2FWW5PT.13WXH8LCISUT7@nvidia.com>
Cc: <dev@nanonej.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpu: nova-core: Extract FUSE registers definitions
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Antonin Malzieu Ridolfi via B4 Relay" <devnull+dev.nanonej.com@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260817-b4-extract-fuse-registers-to-gpu-mod-v1-1-c4924070bbb0@nanonej.com>
In-Reply-To: <20260817-b4-extract-fuse-registers-to-gpu-mod-v1-1-c4924070bbb0@nanonej.com>
X-ClientProxiedBy: OS0P286CA0121.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:169::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c8b9f1d-2b35-4fd7-ab14-08df0187a756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|23010399003|1800799024|376014|18002099003|22082099003|56012099006|10067099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: XDAa8Dl3ZLjrbxifum9UJCaOwkz0li6Nohem0Y+Mc0DqWZi/77hWoIASAyQv9wqitZXE4pou7RewG0j4W/tQ+qQ+al8sAhX16PMZF7JqJM38UXMORJPC121z8zsFs7TZAC73eS4BUjNNfYjBwEFU2mJpaTswAHR7e+ZAPmhFJAqWsxlVkpbJfDTyspIEG4tfXGtkdCyUriPM756CR6TRwE5qRxYfFTrt8KGZ3p2MbdVsQDtVigrJOXNRbg91iz2pRinuidtBWO0xNfL0HSBNng05708lu20m5I1Lix53k1NdcCqw8sQOm8G79YUW+So/CD2y9KzZA5NPX+quISY/LDyaEmVmqxZ2ISYF+cLcEUyJsVuFG9VlwvIkinhGdxjF0eaHEAjQnd8KYO0AZqMu4OOlu0c6QsL1Xzjqe8asG3K2CEs6OVtt0LOm/JfSOz/TA0UqTSG49wdDfVlGxHs2qcnB84QgWXZpzxnHPhhVJx2GuNrkXETyK72/tR4wl4ppLg/6QY+mQ6DZhVr1eTwGUeHK5uzJUECIDkWf8kkb1L4oyFU4RHMB905gPh+oqm1lSvkgxXJZx8QklXWQ7Mb3ZP+K0B26YhFa0KPi89habokijEywSazEjHdSNmQxjbwj+KvewLCGlBOcQM/5jmcgtKz70CrmFlgoOmk+FMdiHwA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUt6aWl2TkFwMFY4YlZBMW13aVhMclpaKzg1SXNwOUxYeWkzREVSQmJEWUtY?=
 =?utf-8?B?cXEwUXArUlNUTGJjcFNjcGQzRmFNcEJOMHdraFVER1hsM25uWWlTVTBKVkZa?=
 =?utf-8?B?Sk1hK05CaU1JbDVMM1NiOWRSbVZ4RU4zaXhrMUZWa1ZzL3krdTVFYis2NkdI?=
 =?utf-8?B?bmJabHBuZWlVc09wcml2MzhONnQwMUZnWVhJMXdqcXIwd0IwVmF0eVF1bGtt?=
 =?utf-8?B?bmtIWFl5dGM2OTVZbDN6eEs2aXRYc3BSaXJPbUs5bVVJNCtEc0o4UUdlVm9R?=
 =?utf-8?B?WVRrKzkxRHF1cDZEank3U0FRbjcyb0xNOGwyTzNVZWZqOFl0RGxSZytBMEdj?=
 =?utf-8?B?ZTVTL00yUGdVMDF0RnlFUS9oU1FBYzZ3L0ZpWW5oMkZVdUQ0K3pNSHgwaUlQ?=
 =?utf-8?B?Nm1hRzJLeThIR2hBeHNpdGdxQmo4bUV3TEpmSjBaTTZtOFFwdHV1SFRNeFZX?=
 =?utf-8?B?RWVKejYvWkw3WWhOS20rbmpESU9NSHpVT0pkcEpyVG11SzY1b1pQOE1oZm1m?=
 =?utf-8?B?Vk90ZlF3ZXRNSVhsc2Q2NHhHQUd6UTA2SlRsMXp1eXF2RTdoSjRPOEhKTlNL?=
 =?utf-8?B?NzFpVTR4a0Q5S204UUcyREwzSHVKOVNpQVJoeGxVNG5LdXI2aCtlZnFDL0M4?=
 =?utf-8?B?UGZnMFVvQzJWZ3p3MzhrWHB1MlV4SlpwMDl2RDVWR3BKekJMTjF4VVU4WUZm?=
 =?utf-8?B?RFY5b1dHYnlXckhIYlBIaVJYZkNacDBMNkx2NS93T3BEbnNnd2FwSTlzYnNx?=
 =?utf-8?B?U0pZUHRQM0xUUnN1TGppanBZRGpVblRFU3dZVjRiTFJQYW50WXpjN0EyQUNQ?=
 =?utf-8?B?VTdPa0RhTHR4Zit1UGwzSzZoNStWOFFGRFJGNmoxOFVDKzVpa2NBV2kxa0Jq?=
 =?utf-8?B?N2JrMXI5Mk5VWWF3QUdNbG9laWEzUnVrWjFVN2NtbEhNNmxCZGF2RjFJVUlu?=
 =?utf-8?B?anRtZjd1bUcwUWh2dTFaWVN3VGdsVXNTZDVIZDNYeWtKenZyK3hpclY2V0JQ?=
 =?utf-8?B?NUlpc1VxK0o0S2FXb1VXbGVUM2tyWTBBVG9hUUdXUzlUdit6Q0Q3b3p4Qm1T?=
 =?utf-8?B?UklTVm5tYnNqUThuN1dCL1pLS0pKZTRwZEluWXBIVmZkWDduc0dhV2V1MWZZ?=
 =?utf-8?B?b2NNc2xKaS90WnJ3bm9RTithcXZ2dXRCNmtxM3JzQXdhbk9MWi9TM2ZZTHdk?=
 =?utf-8?B?VndOYllQcnJleHJQMXFXR20zbDcxZUx2aGt4SmRHL3MrZ0tIUFU2TWFOYldE?=
 =?utf-8?B?bS84UTRRSFZXMmk4Y2J2NFNJM2NTc1lpcXRWRWVYVFd5cXg3d2lWSDUrZmdZ?=
 =?utf-8?B?ZHNRWFpmZDVFUlN2U0I4aEd4L3RRRkxZcnVZNGFFQW5Pd3BVTFNTb2IrN25m?=
 =?utf-8?B?VkNoUzBoNkZFdVZQV3VoVDZIc2JBL0YyNXdyODdqNzhEUEhxRmMxaisxYXVM?=
 =?utf-8?B?clJnNmJRcWJnaFB2R2p4clh4dHR3KzcrSUovREd0bktEQy96Y0hBUW5JT3la?=
 =?utf-8?B?ck51bGYvT1RjRmdXZ1RTNW9KLytxaERTMFZDZVZOMWVITFR6RktRSjhralFX?=
 =?utf-8?B?eFZMODFDeXhnR1NWdVlOMjk1aTdxWUhIUk5lckZNdFdFYmRHVGlBSzVlblMr?=
 =?utf-8?B?QzBYeDNYU0kxKytHSkVxTjlZak0vczBPQzBRcWRTSDZlY0tRS09xMldtRGEx?=
 =?utf-8?B?YjF4UDR0d2Q3VDJoV1RIWnZlUjYwQS93YXFGUnExMCtDZytJVTFWTlc4TVZF?=
 =?utf-8?B?UGw3SmFmdGVxamRiSkJuNktyV29Od1RqTUdLRC9EcU5qd29aRktnRU1BUjcy?=
 =?utf-8?B?VDROTDRSR2phRG45c201YkZlZkxWYUE1c1FVTkc5a2hLaWN0VXNwMGpHS0tS?=
 =?utf-8?B?V29UK2pxdE4rSTFDRTdTZENQelFaSEZ3ci9tNzRQWlpQUDB3djRMdjRkKytw?=
 =?utf-8?B?Y2lTMjhKa2dZblQ1ZjZxN3I2bmtLRTlKOHpoK0pBQ3dmK2Z6YUVKOFVCUjJR?=
 =?utf-8?B?bzVVdXdLalJ6Y3lRUGJmTEpQQ0k4QlFkOXArdkFvWE8xYXFONDBpd2hoN3J4?=
 =?utf-8?B?Y2VmOHorL1BhS1F5ZTdWcEpDTHlkMXZBWjd5Q2Q3L01XTkpQYTlwdXBYMkFJ?=
 =?utf-8?B?VS8zYzJDbEhTbEpTMGdjeFB3ckVkTHJ2czZEMnJGUkVGUEFZZTZyQmVqT0Rj?=
 =?utf-8?B?ZW5ZTG4zbWNvUlorWnNxVkQyM3dwNHdiOGxQTUVWZ2xrVXM3dzdZSGwwdkhR?=
 =?utf-8?B?QXA3b2Vid1NkRUNLWHg4NFBzWWRqRmNBMmVaR2xWMmhwcFhHcHBLVmhUOHRn?=
 =?utf-8?B?aXVmV0VzMVRUSjIzWXdPNWZ2aXBQcW1NZnhQbmJoVGRxbGQwTCtFRlZDcE1v?=
 =?utf-8?Q?Xkd/tD6K8X7efFLDv7PHBJJo/3B/QLiuLKzczGryYlAZq?=
X-MS-Exchange-AntiSpam-MessageData-1: A4hjTBLSi5+C+w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8b9f1d-2b35-4fd7-ab14-08df0187a756
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 02:30:25.1625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPz7/I94iS40fpT9bIFicxeXsCaemLoTHdJHTFhdK69Gi4uON3hPe5/2yWH+aX0DhBl/X768d+I0KWXcMRqOYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805
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

On Tue Aug 18, 2026 at 5:04 AM JST, Antonin Malzieu Ridolfi via B4 Relay wr=
ote:
> From: Antonin Malzieu Ridolfi <dev@nanonej.com>
>
> Move FUSE register definitions from the root regs.rs file into the
> gpu module that own them, in the existing gpu/regs.rs file.
>
> This follows the same pattern established by previous commits for
> GSP, PDISP, PFB, PBUS and PMC registers: register definitions move to
> the module that owns them, visibility changes to pub(super), and
> cross-module access is provided via pub(crate) helper functions.
>
> Since gal102.rs (outside the gpu module) also reads fuse registers to
> infer fuse version, a pub(crate) helper function fuse_ucode_version()
> is added in gpu.rs to provide that information without exposing the
> register type directly.
>
> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Antonin Malzieu Ridolfi <dev@nanonej.com>
> ---
> I got several doubts regarding this patch:
> - I didn't touch the comment in falcon/hal/ga102.rs:71 cause I didn't
>   know if this information should stay there
> - I'm not sure if the re-export of NV_FUSE_OPT_FPF_SIZE in gpu.rs is the
>   right way to keep the read in gal102.rs or if I should also make an
> helper to get its value
> - Then, as I'm not quite sure to understand the exact purpose of the
> code I'm not sure of the `fuse_ucode_version` naming and the comment
> explaining what it do

I am also a bit hesitant to apply this patch as-is. As defined, it only
adds an indirection through the `gpu` module for FUSE registers that are
only accessed by `falcon` (actually, the `ga102` HAL of `falcon`).

`fuse_ucode_version` does some falcon-specific processing (notably with
the engine ID mask), so it looks out-of-place in `gpu.rs`.

Also, the patch doesn't move all the FUSE registers -
NV_FUSE_STATUS_OPT_DISPLAY is still in the root's `regs.rs`. That's
probably because the destination chosen by this patch is not a good fit
to contain them all.

Now I am not quite sure there is a single, good destination for all
these registers. We could move these to `falcon` (and
NV_FUSE_STATUS_OPT_DISPLAY to `fb`), but this just happens to match what
we are doing right now and if another module needs to use them we carry
the risk that it will redefine them locally. Or we could have a
dedicated `fuse` module only to carry these registers, and some
functions to provide the services needed by other modules, including a
HAL to read the correct NV_FUSE_STATUS_OPT_DISPLAY register depending on
architecture. But that looks a bit overkill so I'd suggest wait-and-see
for now. :)

There is also a more insidious issue below.

<...>
> @@ -419,3 +424,27 @@ pub(crate) fn new(
>  pub(crate) fn boot_0_raw(bar: Bar0<'_>) -> u32 {
>      bar.read(regs::NV_PMC_BOOT_0).into_raw()
>  }
> +
> +/// Returns the fuse version matching `engine_id_mask`,
> +/// at the given `ucode_idx`.
> +/// Returns `None` if no engine matches `engine_id_mask`.
> +pub(crate) fn fuse_ucode_version(
> +    bar: Bar0<'_>,
> +    engine_id_mask: u16,
> +    ucode_idx: usize,
> +) -> Option<u16> {
> +    let version =3D if engine_id_mask & 0x0001 !=3D 0 {
> +        bar.read(regs::NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION::at(ucode_idx=
))
> +            .data()
> +    } else if engine_id_mask & 0x0004 !=3D 0 {
> +        bar.read(regs::NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION::at(ucode_id=
x))
> +            .data()
> +    } else if engine_id_mask & 0x0400 !=3D 0 {
> +        bar.read(regs::NV_FUSE_OPT_FPF_GSP_UCODE1_VERSION::at(ucode_idx)=
)
> +            .data()
> +    } else {
> +        return None;
> +    };
> +
> +    Some(version)
> +}

This is moot due to the comments above, but this function should be
`#[inline(always)]`. The reason is that it uses `at`, which performs a
`build_assert!` using `ucode_idx`. If this function is not inlined into
its caller, then the range properties asserted by
`signature_reg_fuse_version_ga102` won't be visible to the compiler and
the `build_assert!` will fail.
