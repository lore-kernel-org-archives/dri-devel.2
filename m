Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC725606A32C
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 06:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GCZqKHGo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0493D10E00B;
	Sat,  7 Nov 2026 06:48:03 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 377F710E00B
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 06:47:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5Uc4b4YJzf2VbXKphdd2pyGiaxMoaD0utQPctNw04X2WSwBDIJN7BUUiQhCABm5LXoeV5BfTNdmmRg9sCzmcoLHAiEnidE46FtPb7doPCNsvtzRrLa+lC6bL0dA8uFCCCVhWMLm1g4QsZF/+z31DS2tVSG5vkRl+hH0WhCIHp84IZjcJrc342+241HaHGZ/1RqzaaTuzwUSZ0pz5JvuIOIGvNkPd+hlmMfMV8/vudlamWqMAW6lwuUs2H3Uo06n0CJCHJ25aqI7vu5rQcZdUCQDUogW3D9PmiTAgwgWhHYBxqTtLWgn06yiReWRtEYXAIoNQD7EE+BXZfRaP6RORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Awso86uur2X1QFxm5c20pt/OWO820tRoP2pWWpr1/Qo=;
 b=yxQFQ6VgP9D5oAEdQPKc0RN2f98CU5IqbMsQda8e0JLaOa4MANvL5wtj2Qk64icOddfgwtiWGOU/2nsgiKsEf2eCMXguD9NntnaejexoPdy3wpdJkJp+c67RbhBCyXgwxR7avsMpPmPABOkEiw/n4odtZmStNBty+a7uOacJ4MnVsJEvvk5rEHDFr9mSpz/QaNyoNlKKFRkGPuEijI+jpzWN8/VxATkG+D9Qphph1iiGpHiOQBwndrlJXY39SKB0xLjsNjrbBMvL2o6wGDUIJIlVtttC3o2CpEne27L1na5uatrs7myKvSbS60/HAM1a2X9IEtx8pT8VasyuabsahQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Awso86uur2X1QFxm5c20pt/OWO820tRoP2pWWpr1/Qo=;
 b=GCZqKHGob0KVhPvJaSwA0zKLejTQ3Mcpm9u6uIiuT497MvrS8UjaweOjeWEhyNf2dcA2SsmOpDOEdVlEv3Ulz9G1RhIQzmxLhx93TkNJuIve8ukPOrAhrvlsfpQ+Otg+UZ2y+Hg/HWLNYVnwKK1Vu5nTv+X5SsdYXc4Of/0maxohHX4ARjsk4Q+0U1neeDyZ8WndpVnNknVoQdEDA7ua1tviQt6m2Bwg0XYdDmZzvUBKRZfcw6pThxZLIY29EQ6HyDpmN3ProY4f+28R29crMU9nlS4TgRKepbnoVamQR7UVlMyoLAsYQGdMkqknzfLDEm/gIBIKRAuVu7gMyhTeuA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by MN0PR12MB6151.namprd12.prod.outlook.com (2603:10b6:208:3c5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Sat, 7 Nov
 2026 06:47:51 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.007; Sat, 7 Nov 2026
 06:47:50 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Nov 2026 15:47:47 +0900
Message-Id: <DMOS00OZYWU5.2SUZRN37DEH87@nvidia.com>
Cc: <dakr@kernel.org>, <jhubbard@nvidia.com>, <aliceryhl@google.com>,
 <ttabi@nvidia.com>, <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v6 1/3] gpu: nova-core: move the debugfs root into the
 module data
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Vladislav Zaharov" <vladazaharova2018@gmail.com>
References: <20261014154554.231015-1-vladazaharova2018@gmail.com>
 <20261014154554.231015-2-vladazaharova2018@gmail.com>
In-Reply-To: <20261014154554.231015-2-vladazaharova2018@gmail.com>
X-ClientProxiedBy: OS0P286CA0009.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:9c::14) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|MN0PR12MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: 253e314b-8a7e-4025-ab6c-08df3c9b0a83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|23010399003|6133799003|18002099003|22082099003|261009223027099003|261026121527099003|261022075727099003|261028144727099003|261022105027099003|261021121427099003|261026140227099003|10067099003|56012099006|11063799006|5023799004|4143699003|261102123227099003;
X-Microsoft-Antispam-Message-Info: 5b+4idtzljvHr5S3qTk0NmIfmZfgKppzw1oy6I+i16uk3eVnWcEL0C1bAM+A+42f8eAycfwD6ku7Lht4LeYIfG8ScL2q5XPIr814zvFqnAlKxOc2iG8C4AEvb0/oqp7xUwzIk+kNasv73F33xNPO2zXnhobJXw17/FRjWaFzko+Cv6mJR/Za6xcpmRYEyjmWZi52Q2boGj+YAJKid935rgeH6OO95KSCSBTMWQSPTCQQyqC2MDMxwkFpY+Cmp2atqoSOLilgm+w1RN7t7GMkuo8ZGhHgPkqk/yk+A1UKi251vblxpGFnc9ysGgtMmiwXItjxFU2eM1wf/lWIIkyxugOq2T84WOKMjwGkkdJuYoQS3BB6yGy6wfF8xyhIWfffksZ2VzBzkW6gS0Ca7cxGbln3jtUj3dhTtUwq0k7VoThkL3wdL4AQlOmYjuRs50dWht5P5aqFS61NRF1ilwcLRfyImFwHWU5g7B6FkPGL5rknmNrbJKe1wPEA6yvySHTMrz+MiXGi3a8PgHmf01Afup/r9OadYhuvYkuJF2vcPH76DyOsiG7YkQJPbLz6FPhOimavXFkqv3zcr+fFxcVCTOrSkpMHNqZzyzZun7Az/RBA6SLMLc0pGjZY0NoL8/tyZLy6OOlaQ69qVLRF8FPlp9sClUJmBBvWXzMuU02J3fM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(23010399003)(6133799003)(18002099003)(22082099003)(261009223027099003)(261026121527099003)(261022075727099003)(261028144727099003)(261022105027099003)(261021121427099003)(261026140227099003)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXk5Qzc0NGt0N2FTSFF6RHNuNUxJRWN1dVJuUWFVZ3dXRXVXZ0FkNnF6bVdZ?=
 =?utf-8?B?bjlSY2kzQ242WFVJNEZKcHVRVklFd0x1Y2ZqMGlISmdXL3c2cU1KY3o3NGJu?=
 =?utf-8?B?VHo2VWRybmRGS3lSejNtcnNLZ0QxaG93T3k5NjlLOWlZSENQd00vT3NSL3Qv?=
 =?utf-8?B?YzZXamFISG10QjMveFd2cDFUSFhGZ1dNRmpYZjZDT2tWV1dCbkdDa01GQUpH?=
 =?utf-8?B?MVVCODg1WDNRbnBldzAvUW9BUEVRVm9SUFV4TmkzUjBOeXNZWVNOWGxacTI3?=
 =?utf-8?B?QlRoUEZKcnBZeWF4bEE2OS94ZktQTDB5TElCMWRCUitUbUpJcFU1ZkZlc2NY?=
 =?utf-8?B?ZTVOZkprU05JbncwWDBCVGZSbE9ES0xWQlU2enp4MDFSdnFud2NrRFYvUGlG?=
 =?utf-8?B?WWlXS29XL3pveFdGUG1sM0ZPcWNOdGRjc3pmSHZQaFNtaWpLNEpiOWtlOUsz?=
 =?utf-8?B?NUpNTkZiYXlUaEN4akdhTWtnUFluRWd2SUFHMXkrZm53ZitXcFFsb2JKTnhR?=
 =?utf-8?B?NHNhYWdac3BpVHhYcnlGbmlWSkZyS1ZVdXoxRE9NeUtZZFJ3eGtZeVhFYUpi?=
 =?utf-8?B?NGdjekJGeXluWkh3cDdxbzRxTW9KYlVrUHBRWVJ2WHVxNkdqeGZjb25odEpq?=
 =?utf-8?B?Ni9WN0xESkJseXFhOVlNbmhsbnZ6SG9BQTQ4N1pIZElkeDh2R0pScE5DellP?=
 =?utf-8?B?RVlQUDlxZUd4U2lDVFJxRXRUODNPWXR5RGw5ZTMraEltY3d2bE41a2oxTUlu?=
 =?utf-8?B?U01mRWxnQ25PcjU2ZmttcXpoRTlQTEkya3BLUERHRUxwelFHRnFtZjBCd1c5?=
 =?utf-8?B?a2RCTVY0Z3psRjlHTm5KdEpCcFJJZTZ1bG95R1JLeFEra21PV0dMVXJrUENU?=
 =?utf-8?B?SEJHM3oycDM3T1BjQ3B0VWJCT1VtaTFqZjFEdGZNZ3RVcW5KN01DQ1hVZHZX?=
 =?utf-8?B?OTVQMElaZGZSRFNEakNqQ3RSQWFBRzArZGZWeU44dVRaTHJiWHZ0OXRJSTFB?=
 =?utf-8?B?ZUVqc1dFeC9od1RFMksrNWVkUkc4bXptbnpqWUVQc29xRkV0NklRUGtGY2k3?=
 =?utf-8?B?ODRiV0hOREJpZlRLc3lFRUJCNVJleTBSMStBdWRMdnRnRmxCbkZMc1ZCTVls?=
 =?utf-8?B?VUxKcTRNSFRhNkZnaDF2U0Y2WVZaVFB0ZmdOeWV2WUZIZjYvUWg5aHpBeDl4?=
 =?utf-8?B?d2tqZS9JdGlWbjU5TE1FclovRkhkaUNEdWJNWVNsbWFyUUpqWFcyU3k0aVpO?=
 =?utf-8?B?S0lLOXhkbHhVbzdxYVdyZUlWeWNsbVR6aExVUGUzUzRadUZmVzd5MWhrQlVE?=
 =?utf-8?B?TUxjV2s4MUdLSERDWEJvK1BnaDVLOTdHRlRoZXpyODFWdFdGeGsrLzc0N0pU?=
 =?utf-8?B?Z1JiTDY2eFcrZ0FpRUhLUnU1M3QrdHZ0NFgrUm1xMU9xYzE1aFJ2dHdVQ0ZT?=
 =?utf-8?B?NXJJSWVDcDNMZG9uWFZHNmdKd082L2Fmay9TNWp5TjUyV1RvNGlPWXlQMlcv?=
 =?utf-8?B?VW55alpINzFYTjFqeHltVmRtVzIvdG5yejVpK25sdFJRSDlZTSs0N0RHN2d4?=
 =?utf-8?B?QWNXWFFDRTN3b1NEQVdNbEpWRmhjbmJZdnNzNWlhTHhqZC9uL25PUDM1emIw?=
 =?utf-8?B?TW9aVHl4bmtjaU83VHI0QXlsV1ZZTUlRRVJqYTFaOWNWVkMxSlNNbkVRN3ZY?=
 =?utf-8?B?dmFRV2RtaUlucU4zWWJ3RXFIV3JHU0dzR0tQMndhdDdkWXVjTFUyY2ZSSCt5?=
 =?utf-8?B?bklITWJaMURZeUYwWm9OWU5KTVlTdVd3U0VuQlgxRUFYaDNkc3dINUsyaTJs?=
 =?utf-8?B?ejljdWFYQ3ZPZGx4MnE3akoyNkJCUHJuSUs3dUh0bnc2K01ZbDRwU1ZEOS9N?=
 =?utf-8?B?RlN6SFVMRFp0OUlZdGlzVWcyTXpTeU42RzZadktGWC91L3hUQUp1VzJBcFJS?=
 =?utf-8?B?NjY5aHQwWTZsOVBOVDZnT25sSUVOMk80aXBySFoyQmZNeFdnNlVwRnhLWDBZ?=
 =?utf-8?B?RXBzL2VMa2F0RG9BUHBTK3ZzT1JzczFMZmZ1UVZES0F4YUM4UFN4OENSQyto?=
 =?utf-8?B?Qk4yOWtLRTVjb1ZFc2xDRXNuQUZ1dWphWkgrdGFEbmJuSGxKM1dabmtmdDQ3?=
 =?utf-8?B?blBydWRSbHE3Mi80cUdxY2R0L1FSZXQxVTFHZXpxL1VOeDV3bFhMeFhPUjY2?=
 =?utf-8?B?cU9vdDY4T0FGTjg0YngzZ3o0NG9jSmlIeXNkSDNFbFJCYVk1Y0dEdmlkcmE4?=
 =?utf-8?B?MGU3L1pzN1NjQmJzRnVPdXFhdFB0WTNaOXZFS3dRTGNKYkhNdVhJTFljQk1q?=
 =?utf-8?B?SDJhUTNIbG5ZZFc1a0RGUE5XRzh4N0NDWTIrdUtHL1NYUVFablN5WDJHNlFD?=
 =?utf-8?Q?uWJSdRWv7IpHDB+laWyGr/p14Ox/vWwNkTDtx2adRluqr?=
X-MS-Exchange-AntiSpam-MessageData-1: iPzEaNUG0tBpaA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253e314b-8a7e-4025-ab6c-08df3c9b0a83
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 06:47:50.5983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2hU2I+1gpDPv44FSL3zo/uUh3yCEihi7juPBzJwuHbPfeazHQ3h1IwgCPcEc0U1tTGZXZ7NoGa4xA/3ZqMwlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6151
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Oct 15, 2026 at 12:45 AM JST, Vladislav Zaharov wrote:
<...>
> diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/n=
ova_core.rs
> index a8f6dc22057b..ee3a6600f320 100644
> --- a/drivers/gpu/nova-core/nova_core.rs
> +++ b/drivers/gpu/nova-core/nova_core.rs
> @@ -4,6 +4,7 @@
> =20
>  use kernel::{
>      debugfs,
> +    device,
>      driver::Registration,
>      pci,
>      prelude::*,
> @@ -32,40 +33,75 @@
> =20
>  pub(crate) const MODULE_NAME: &core::ffi::CStr =3D <LocalModule as kerne=
l::ModuleMetadata>::NAME;
> =20
> -// TODO: Move this into per-module data once that exists.
> -static mut DEBUGFS_ROOT: Option<debugfs::Dir> =3D None;
> +/// Pointer to the [`DebugfsData`] the module owns.
> +///
> +/// A device has no way to reach the data of its module, so code running=
 on behalf of a bound
> +/// device goes through here instead.
> +///
> +/// Written once, while the module data is built, and never again: what =
it points at is dropped
> +/// only after the driver is unregistered, so it is good for as long as =
any device is bound, and
> +/// is not read outside of that.
> +// TODO: Drop this once devices can reach the data of their module.
> +static mut DEBUGFS_DATA: *const DebugfsData =3D core::ptr::null();
> =20
> -/// Guard that clears `DEBUGFS_ROOT` when dropped.
> -struct DebugfsRootGuard;
> +/// Data the module shares with every GPU it drives.
> +///
> +/// Reached from a device through [`debugfs_data()`].
> +#[pin_data]
> +pub(crate) struct DebugfsData {
> +    /// Root directory of the driver in debugfs.
> +    root: debugfs::Dir,
> +}
> +
> +impl DebugfsData {
> +    /// Creates the shared data.
> +    fn new() -> impl PinInit<Self> {
> +        pin_init!(Self {
> +            root: debugfs::Dir::new(c"nova-core"),
> +        })
> +    }

Another thing: since this is declaring now a proper interface, can you
move `DebugfsData`, `debugfs_data` and `DEBUGFS_DATA` into a sub-module,
say `debugfs.rs`? This will keep the root module free of clutter and
keep all the debugfs-related setup under a single module.

Tring doing that locally also made me notice another potential
improvement, see below.

> =20
> -impl Drop for DebugfsRootGuard {
> -    fn drop(&mut self) {
> -        // SAFETY: This guard is dropped after `_driver` (due to field o=
rder),
> -        // so the driver is unregistered and no probe() can be running.
> -        unsafe { DEBUGFS_ROOT =3D None };
> +    /// Returns the root directory of the driver in debugfs.
> +    pub(crate) fn root(&self) -> &debugfs::Dir {
> +        &self.root
>      }
>  }
> =20
> +/// Returns the data the module shares with its devices.
> +///
> +/// The bound device is what makes this sound: the data is built before =
the driver is registered
> +/// and dropped after it is unregistered, so it outlives every device th=
at is bound, and the
> +/// returned reference cannot be held past the one it is taken for.
> +pub(crate) fn debugfs_data<'a>(_dev: &'a device::Device<device::Bound>) =
-> &'a DebugfsData {
> +    // SAFETY: A device can only be bound once the driver is registered,=
 which happens after
> +    // `DEBUGFS_DATA` is written, so it points at the data of this modul=
e, which lives at least
> +    // as long as the caller's device is bound.
> +    unsafe { &*DEBUGFS_DATA }
> +}
> +
>  #[pin_data]
>  struct NovaCoreModule {
> -    // Fields are dropped in declaration order, so `_driver` is dropped =
first,
> -    // then `_debugfs_guard` clears `DEBUGFS_ROOT`.
> +    // Fields are dropped in declaration order, so the registration goes=
 first and no probe() can
> +    // still be running once the shared data is torn down. `init()` buil=
ds them the other way
> +    // round, as the data has to be there before the first probe() reach=
es for it.
>      #[pin]
>      _driver: Registration<pci::Adapter<driver::NovaCoreDriver>>,
> -    _debugfs_guard: DebugfsRootGuard,
> +    #[pin]
> +    _debugfs: DebugfsData,
>  }
> =20
>  impl InPlaceModule for NovaCoreModule {
>      fn init(module: &'static kernel::ThisModule) -> impl PinInit<Self, E=
rror> {
> -        let dir =3D debugfs::Dir::new(c"nova-core");
> -
> -        // SAFETY: We are the only driver code running during init, so t=
here
> -        // cannot be any concurrent access to `DEBUGFS_ROOT`.
> -        unsafe { DEBUGFS_ROOT =3D Some(dir) };
> -
>          try_pin_init!(Self {
> +            _debugfs <- DebugfsData::new(),
> +            _: {
> +                // SAFETY: Nothing reads `DEBUGFS_DATA` before a device =
is bound, which cannot
> +                // happen until the driver is registered below. What it =
points at is dropped only
> +                // once the driver is unregistered, so it is valid for a=
s long as any device is
> +                // bound, and nothing reads it outside of that.
> +                unsafe { DEBUGFS_DATA =3D &*_debugfs };
> +            },

Let's move this initialization into `DebugfsData::new`, using
`pin_chain`:

    /// Returns an initializer that creates the shared debugfs data.
    ///
    /// # Safety
    ///
    /// The returned initializer must be run exactly once before the driver=
 is registered. The
    /// initialized [`DebugfsData`] must outlive the driver registration.
    pub(super) unsafe fn new() -> impl PinInit<Self> {
        pin_init!(Self {
            root: debugfs::Dir::new(c"nova-core"),
        })
        .pin_chain(|debugfs| {
            // SAFETY: Per the method's safety block, the driver is not reg=
istered yet, meaning that
            // no device can be probed and thus nothing can access `DEBUGFS=
_DATA` concurrently.
            //
            // INVARIANT: Per the method's safety block, `DEBUGFS_DATA` is =
written before the driver
            // is registered and points to a valid instance of `DebugfsData=
`, which is pinned
            // and dropped after the driver is unregistered.
            unsafe { DEBUGFS_DATA =3D &*debugfs };
            Ok(())
        })
    }

That way, the burden of enforcing the invariants for `DEBUGFS_DATA`
relies exclusively on `new` (and we made it unsafe to force the caller
to do that). The only thing `nova_core` has to take care about is
calling it before the driver is registered, and keeping the result alive
until it is unregistered. Simple and trivial to check since `nova_core`
now doesn't contain any of the debugfs code stuff anymore and literally
fits within one screen worth of code.
