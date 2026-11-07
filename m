Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF88606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 01:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YX42AQ5a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6385B10E497;
	Sat,  7 Nov 2026 01:25:31 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012030.outbound.protection.outlook.com
 [40.107.200.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0C5E10EB05
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 01:25:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXLVD9Iu1X8JjGv75TLjqX0r9Q6cNmNe9FM56tMzPNQXY1bR8FHUaKwBbRB+037oIVancYxhoK99DhdY9Sx6SnFToiLHHDLHP8Qya8VvOzTs5lEb8EKJ6Zzy6P8tVPQNpgVFjDI6oopLfwCoR2ECGoISlzZz2BtAzMLEwKpIQd1RkR5kaHf29xLVAeipAsx2HIWcDHycdZkc9CGaFedwj34vVeaIjQFm79j7K7QqAuBSCjRz9+Ida25NrZprN9DNkVOUX32e4Tdg7k2EddiEFVu+qYpDYfcns/HrmfGvAzvbFjyc+Yx2NNcbjP7WPOxQ7Osx0p+NIsqbO4lWsECP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnY+O9xW9zlOshW5YiJKq9C5IDTy/pjJAUlooH8yiv4=;
 b=jfqLkj2AOgtEmyqBUimT1OrukG+uKaUIha5Inx0WYc7ZDZjLu4VMDZ89q3ENaOKM8GFZpOMHE2MLVlsp16cc/jFPq+huWfhPnH0QUO+6yJL0Pfmo8PINdFo/ltyKras8IeHSNnq4jA3o6lgn0HisBQj603cIvy1e2gvOEqkk1OU7qCD5X3XJDFCfy1zVQJemaNgy23ivA/N/mGVU4o/9uar7hKQgrL41yX9mr+yHW8wB8hGpahZzQ0+3xi67DnqUxR18COVPvLLOhC9B5TeZKi2+AgeCpnthG0k9/Sa1TRyLLPyhZCodc7GJkQI2ZkHUJCSq3yWGtyvy9Up+lxEKPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnY+O9xW9zlOshW5YiJKq9C5IDTy/pjJAUlooH8yiv4=;
 b=YX42AQ5aMUgVjPOAm7DzwBsNxsMnA1yJhbaUCM/gQ9gYGOpwIj0L6TA6q59QNq+VOEUcifPIB0g2OkiX4K/tj+Ryyd7RkXa9N3B1AVpybD2IXS4sfBCxuew166WXkt0WuL2N6vJGWyrzRIYlbm1Hh72dqrbiF9NT90mdeocoUgJKOUpgsqaXyPJ6lhqs8BLZFlOe0A51NQGcs8J3A1NdWbS7fsT/KtS6I0SGOSWBpSw3W/3xKVwLiZNxhy1YMYS+iSd8MFulF0RTKgGJHu45u+EwNrMeC8TizOZgme752QPl8YtIkQbpjhfxVxrh5PXB0Wwa7mmIHudiioIFn1NROA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DSVPR12MB999309.namprd12.prod.outlook.com (2603:10b6:8:41f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 01:23:20 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.007; Sat, 7 Nov 2026
 01:23:20 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Nov 2026 10:23:16 +0900
Message-Id: <DMOL3JXGL7PD.15ODH571S1OFY@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Vladislav Zaharov" <vladazaharova2018@gmail.com>
Cc: <dakr@kernel.org>, <jhubbard@nvidia.com>, <aliceryhl@google.com>,
 <ttabi@nvidia.com>, <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v6 1/3] gpu: nova-core: move the debugfs root into the
 module data
Content-Transfer-Encoding: quoted-printable
References: <20261014154554.231015-1-vladazaharova2018@gmail.com>
 <20261014154554.231015-2-vladazaharova2018@gmail.com>
In-Reply-To: <20261014154554.231015-2-vladazaharova2018@gmail.com>
X-ClientProxiedBy: TY4PR01CA0018.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::7) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DSVPR12MB999309:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ee7d230-0d28-4015-7506-08df3c6db513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|10070799003|366016|5023799004|11063799006|4143699003|56012099006|261021135927099003|261021123027099003|261022105027099003|261009223027099003|261022075727099003|261021121427099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|10067099003|18002099003|11062099010|22082099003|6133799003|7136999003;
X-Microsoft-Antispam-Message-Info: m007/b4tZR/10ovslYXdnR0DLeZyqAB0F4DShMREVvkvzhSsbDCJtbK9SgyOAuHCLhyFyhLa6ZBredMIvmAwpwSynm8U5pwlTbI6xmREqBzyi6BRLAMYN4eDmaSudEAfFoCAXK7+S6ORwNk7isKObIqKq8F7nSGUd5H5hlB9JfaPiMyXOZWo3UrJyOnN25FmUdxQ9t6Cz88GO2zHF2B2iOjS1NKerAdxlsjbjUGAHcJt20CbcRULMD+JFzmMGEj/l6ipxGNjEDux9vKMwdgLgC+FG6hca5vw0KW76FsovmFPMkiQyn2xyd0SmdUVdyDp4mHrrt3RrtKbsJFcJsUYqYzrSUUlNc3yoZoBxy4XBY29+q+qbX6jcvJG1WEkC1esxYYi4UrtCottIKkVp/OAKKflM2xyPsMYFiG5uUoYzM3heFYbApk4wm+mJ+FJFCaKES8wDcAtmtem3R/hCMDprzysRlkVhQwyshwcKlY2V3uBqcEKPaGcj41LTJ7N2CJtzPOiR/ryOmuW30HVrNyJxuh14t0CpusGTVTMiv29B5syJINvayWXpATrK5tZ7P6aEN98JAUsuvM9MMcZoismMWQPc7jQC5udHrAclh3i+TBWSNoW9JXESmAx5L1sEQ3gweR1B0q57DC3XKnH7q7bZTm1QpbVm99Xszjh9xUziAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(10070799003)(366016)(5023799004)(11063799006)(4143699003)(56012099006)(261021135927099003)(261021123027099003)(261022105027099003)(261009223027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(18002099003)(11062099010)(22082099003)(6133799003)(7136999003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjVTSUkwMGtONS80M3g3QWtqY21uNld5ZE5lVzVjLzBQdVVFSXJ3NG01TVVh?=
 =?utf-8?B?VUF2d2dVRjRzRERRcVo3MDdBZzB1dU5GTnE1eTBBQjhDUTZaeldoemhkcUJR?=
 =?utf-8?B?eCtQMlh3OHZNMzdJd3I2NENLM205Z01VUXkwTFJMTmJaMVVEUHlYNllYS3pt?=
 =?utf-8?B?OHE5R1RlbjFBcUxWN002cE5iVG5aL0VRc29hd0xJZVhJbm1IV2lINVhoOGxE?=
 =?utf-8?B?U0V5TmpWb2hRdCthek9vMTQxbm9YY3FSVVN6YmVXN1Q0eHpzQzVKV1JUaXFu?=
 =?utf-8?B?eXRRaVdlVk1MWlkvRzNVdWhaU1BpOU1hdVBIUzBpOU9HcFgrVGl6S3JWQXlE?=
 =?utf-8?B?cVFFeDFHRUFML2pmb3JyN09nNjIvVU5wcjBoK05tckRMbTlWMmRCemVsdi9q?=
 =?utf-8?B?OEplVFVUZVR0ZGkrUjhaTlF3MlZBQ21GUGJpc1c3VGpYek5iTkVLcjIyWER3?=
 =?utf-8?B?TUZpQUx2blE4QzRHLyswQ04yaFVTWkZWQXJ0QmU4bGxKZjZQQUI2a2ozVW51?=
 =?utf-8?B?dnRWV3ZjUWJqT0I3ME9iVjFtNUprb2k4TmEra2xiSnIycjE0b2xmRTdkK3RS?=
 =?utf-8?B?TTE1RVhNTXF1MlZ4M3ExdWVRaVlURUFaTktIU0hDa1RNZVBtYjA3MlczVXlP?=
 =?utf-8?B?SHRSenRSTDJQTGZVMGhhNEs1YVk5WE9HZmM3RXczV2RubEp0Yi8yRXZVUjBL?=
 =?utf-8?B?ZEJVNTlYRXdqTXhIamo5UHluQnlCekgwYUFBR0VlOWtpSDBQdEZCNnZQMy84?=
 =?utf-8?B?ekJ5RUZYT3dOSGV5VGlWWFdPYWFvMjdQSTNBdkNaZDB4WWc2WDFoNFEvOEd6?=
 =?utf-8?B?cVFlRTZuQ1MxVjdOdDR0WjFVSW5RYkkxRDZYMkpxeTBKSzBoSVNIREJKNCtF?=
 =?utf-8?B?MVArT3dGSzF3Rmo5b1dobU84MnlaT2FhZ2FlZGxRU0VVSVloRmVWTmhHcGRC?=
 =?utf-8?B?NG1odHRuRHBJeEd2cmZvNWJTVTFxSksxUmUrcXFzRjdDVlUyVjdnaHc0aVlk?=
 =?utf-8?B?TDVoeGtxeXpXTld1VVQya1NMU2hGOVRwK0UwM3I1QXQwK1hkVjBwa1FYZFht?=
 =?utf-8?B?bGdvVURDQ20xUGltdVZkdy9qU29ObVZnRjRlVmpPZTJrMWdDRk0ycmRsTCtu?=
 =?utf-8?B?OWVGZHQ1ZkFNdjhDdkc5MjJici8xYU5PR05PT0FkL0lNNG9venk5VitMNmx1?=
 =?utf-8?B?cjNDVzdHOWtkQm1lKzhualpxRUdaNHQ5a0kzSDZGbXlpeDJ6djQ4N2hzK2NQ?=
 =?utf-8?B?ZkJxWTdoTVh2UEh3azQ2Rm9ZVElpQ2NubG9jSG5GNGdJdXJmYURnQjhVUjUw?=
 =?utf-8?B?ZG1lNlhtbDJGeWN0VHk2ZG5xQlIyS3FOQWVFZUtmL2dYSjF4L3R0VFNiU0xr?=
 =?utf-8?B?RHRIVGZLMzV5Ym05UlN1UFI2bFhSUnFvMllVRXZJT3UralhJMkJ0UnE4amNk?=
 =?utf-8?B?aFVTMEtCQWRrdEpyOWtaMzJidzFaVStxeTdOMlc3Y2wyQXNtZHJoNWMrdTRu?=
 =?utf-8?B?bDg5a3J5NCtNRnVTNWZFcEhlWjJWbk1OSThKWmQwelpBL2RpU3ArWHJMYVQ5?=
 =?utf-8?B?SXdDWnFkeDl2T2IweEpDMnZXWEF3VzZRSjBETUtmdTJKVDhtMm4zdjdpaFRE?=
 =?utf-8?B?VmhlMnVSbzJMR0EvdHV0VDRIbmJLNGlqMGxqallaNG8yNFVaT1gzNS9DdTY5?=
 =?utf-8?B?ZDlremNJZ2ErdEsvUnR5bWt5alNpU3R1MjRpa1hIZUtOSVBpSTJlY1MwODZW?=
 =?utf-8?B?UVdVV29DNmttb0NVYk0wTVBWSU9JczVXT2I4VXFWYzFaWkpzYmt3TWNoZk1O?=
 =?utf-8?B?K1BYK1d2bWpmeUNSQmY4dTNBV1FTUTZ4VkphU2lIK2Fpa3E0dEY3M25JNXpw?=
 =?utf-8?B?KzNBWlIxQWlkeTRnS05qcHIwVjhxajJad0Z5eHBpZ252VW1RQ0dmSHlCVVhX?=
 =?utf-8?B?VmFwSlg5ejQzb2UvSE5lRFBOdS80UTgxd3hVakRMam1qMnJXM0hBenNJRGlN?=
 =?utf-8?B?Z2xFMWpVM24wT2NrUXJrSnBBZWJiaVdXWmxudFBWS0N5dTd5Q01LRituZ3ZM?=
 =?utf-8?B?Uit1RmdiTXI3cm1IQy9IM2thNERSdCthZEJPYzdraDBsR2FSem45ZERyOFAz?=
 =?utf-8?B?R2VEMTgwRXpmQ1pMTDlxT09WWVVUS3lHUDNTVm5uYysyUFFyKzZxWTZTK3lV?=
 =?utf-8?B?elU3dWxhM05RNVJwRjIzd2tFeWYxVWFCWDQ0UStoVFl2VFQyYWVKUEc5amR3?=
 =?utf-8?B?U21HdjR3OTJGZjJ4Y3NQUVgzbkE5ZmVqNUdSbjN0a1JKaTR0dncwd2R6MjI0?=
 =?utf-8?B?bURQODdWSSt4QjB0eFpFbkpWSmdVcVNDQzBGWjR4NnZVU09BQjZFNmYzSU02?=
 =?utf-8?Q?52o64ZDL0cxZ7SwwmrJuPbtuzD8tii822ZGQczOrHS+XN?=
X-MS-Exchange-AntiSpam-MessageData-1: DXHNAoMzzXpjDg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee7d230-0d28-4015-7506-08df3c6db513
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 01:23:19.9877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IV7iLfAGUzLwXsMNECJhRa+ZaAx3kyJcFefKl6omK+x/aMcju7abeoy1w11QbtErvUZCmlRQFE4+0cYLf61r/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999309
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Oct 15, 2026 at 12:45 AM JST, Vladislav Zaharov wrote:
> The debugfs root lives in a static that init() fills in and a guard
> field of the module data clears again. That costs a `static mut`, an
> unsafe write on each side and a guard type whose only job is to undo
> the write.
>
> It also leaks. try_pin_init! drops only the fields it has already
> built, and the guard is written after the Registration, so a
> registration that fails leaves the guard unbuilt and the static set.
> Statics are never dropped, and the module is unloaded right away, so
> the directory outlives everything that could remove it. The next load
> then finds the name taken: debugfs_create_dir() returns -EEXIST, which
> Entry keeps as it would any other pointer, and the driver comes up with
> no debugfs at all until the machine is rebooted.
>
> Have the module data own a DebugfsData instead, built before the
> registration and dropped after it, and keep only a pointer to it in the
> static, for devices that have no other way to reach the data of their
> module. What is left is one unsafe read for the users and a single write
> when the data is built, with no guard type. A registration that fails
> now drops the data that was built before it, and the directory goes with
> it.
>
> Assisted-by: LLM
> Signed-off-by: Vladislav Zaharov <vladazaharova2018@gmail.com>

Fixes: 09691f5d8070 ("gpu: nova-core: create debugfs root in module init")

> ---
>  drivers/gpu/nova-core/gsp.rs       | 10 +---
>  drivers/gpu/nova-core/nova_core.rs | 74 ++++++++++++++++++++++--------
>  2 files changed, 56 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
> index dda58095f40b..01ed4adffe93 100644
> --- a/drivers/gpu/nova-core/gsp.rs
> +++ b/drivers/gpu/nova-core/gsp.rs
> @@ -199,15 +199,7 @@ pub(crate) fn new(
>                          logrm,
>                      };
> =20
> -                    #[allow(static_mut_refs)]
> -                    // SAFETY: `DEBUGFS_ROOT` is created before driver r=
egistration and cleared
> -                    // after driver unregistration, so no probe() can ra=
ce with its modification.
> -                    //
> -                    // PANIC: `DEBUGFS_ROOT` cannot be `None` here.  It =
is set before driver
> -                    // registration and cleared after driver unregistrat=
ion, so it is always
> -                    // `Some` for the entire lifetime that probe() can b=
e called.
> -                    let log_parent: &debugfs::Dir =3D unsafe { crate::DE=
BUGFS_ROOT.as_ref() }
> -                        .expect("DEBUGFS_ROOT not initialized");
> +                    let log_parent: &debugfs::Dir =3D crate::debugfs_dat=
a(dev).root();
> =20
>                      log_parent.scope(log_buffers, dev.name(), |logs, dir=
| {
>                          dir.read_binary_file(c"loginit", &logs.loginit.0=
);
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

nit: "A device currently has no way", this is a temporary limitation
(hopefully).

> +/// device goes through here instead.
> +///
> +/// Written once, while the module data is built, and never again: what =
it points at is dropped
> +/// only after the driver is unregistered, so it is good for as long as =
any device is bound, and
> +/// is not read outside of that.

This is some top-class Claudespeak. Let's rephrase it into invariants
that we can refer to later:

/// # Invariants
///
/// - Only written once before the driver is registered.
/// - Points to a valid [`DebugfsData`] for as long as the driver is regist=
ered.

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

You don't need to explain why this method is sound, the method is not
marked "unsafe", thus it is safe and that's all callers care about.
Anything more is unneeded cognitive burden and readers will wonder why
they need to know that.

The SAFETY comment below, which gives the same justification, is the
correct place to explain that and already does it.

> +pub(crate) fn debugfs_data<'a>(_dev: &'a device::Device<device::Bound>) =
-> &'a DebugfsData {
> +    // SAFETY: A device can only be bound once the driver is registered,=
 which happens after
> +    // `DEBUGFS_DATA` is written, so it points at the data of this modul=
e, which lives at least
> +    // as long as the caller's device is bound.

... then here you can just invoke the invariant we defined above:

// SAFETY: `_dev` is bound, so the driver is registered. Per the
// invariants of `DEBUGFS_DATA`, the pointer is thus valid and not being
// written to. The `'a` lifetime ensures that the returned reference
// cannot outlive the bound device.

(technically one could pass another `Device` that is not bound to this
driver, but I guess we can overlook that for this private, temporary
interface).

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

Here again we are not concerned with what `init` does, we only use this
comment to prevent someone from breaking the drop order we rely on:

// Fields are dropped in declaration order. `_driver` must be dropped
// before `_debugfs` to uphold the invariant of `DEBUGFS_DATA` that it
// remains valid for as long as the driver is registered.

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

This can just be:

// SAFETY: The driver is not registered yet, meaning that no device can
// be probed and thus nothing can access `DEBUGFS_DATA` concurrently.

And since this is also where we enforce our invariant:

// INVARIANT: `DEBUGFS_DATA` is written before the driver is registered
// below and points to `_debugfs`, which is pinned and dropped after
// `_driver`.
