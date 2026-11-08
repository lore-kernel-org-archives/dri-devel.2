Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAC9606A31C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=H9bOqhv/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22C9D10E36D;
	Sun,  8 Nov 2026 13:52:56 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012069.outbound.protection.outlook.com [52.101.43.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04E4C10E36D
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 13:52:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfK8OamfK3OMvPpyqo9ZT5nDLIbxh5dGx7fl+/IxJBJxkSYTB6lc5Z0RJlsl6DSL7SZ55NLbr7TmqoMK7V3MXYGljKlFBZ2Is8vfB64Yww0w3AHSYnHXdt7uEr/wTe0S154NVG3JCAwyGfVNjEzAynMfGW8JwQ6FTsAvOXG0Wp0bGOk2HsXB5+dHRgw3fAiJBffjHr2xvUa5C4Evz4WgI2dGLYc/XFcS+USok4JuG06JAToFECiLVL2meIAN6CYv0+o4jJ/SOuO8a8WO290wJUKAI35xUCG0kDyc9Eg306+2yF2BS2rxcO0m9uicG4s/j5skwAC35F0HFtEZ6uKdIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cl/WzabMzxlmcFxWLJKk1ndLbON0v/ikR8aJ6IMPsDw=;
 b=O0fgf98jylETMF8IXdjBB5G9C5gE1XJt7II9AqHUl+WXWScyNxclQXUgGwJcW9Kwuub4ZdX4919wcTr9NxM8N+ZL8c5fH1v8wZHuYjf3Qyl8ohHMysyFK2b8W/BMFZ2cAJ5l0X1sinCU0xZmaR15CfQXUmeGB1kl2/uF/R9zfknLO/fdHD583s7Ktz3ShkVyEumJkXkcG4uVDwAgG08130Uim5RIva3F0203XjWv/Fw3S16tY4D2eftOhY96ifrCairUwwZPzHZtNfULtqhOVpfnSXt7eC7+k81RUPNumgtbt9Ut2cxpcp4JI72kB/LjuW0QVZIngQq8bVFRxX6tpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cl/WzabMzxlmcFxWLJKk1ndLbON0v/ikR8aJ6IMPsDw=;
 b=H9bOqhv/cUd15xi1LRkp/6OQwA0/kVDaPkvB9NGuS5iplsAcmwUu0n5DwqizE2+WA2YidNlKyDAe3nunQJ7Y4s0XiKT6e7wd2WJ27MYcqfwOaVqaOyvstJXBMUkEq1j7BUb5J4ph4aPhJKIlk5fHgHgxO1YtNa3K3b1qT42xt5Xqf9fVS0VLlqRpbeApEbCc3PxzS2iatGl70/ByqEGlBLsjbsFkBjOUfxljDw2dCT8OUxWpEpO3sokoDmQhLNC20h+5GXfziJCYjnKQU2CfUr9Ziit+sqR/R2rrnuiPjiOYg7+Yb4bnbt1ygODd+Qkc+mSPGkQs3z/xf1CJcYjlDA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 13:52:45 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.007; Sun, 8 Nov 2026
 13:52:45 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 08 Nov 2026 22:52:41 +0900
Message-Id: <DMPVNWCP35KX.177YD8SUQTBT7@nvidia.com>
Cc: <airlied@redhat.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v5 2/2] gpu: nova-core: add support for GPU timer block.
 (v5)
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Dave Airlie via B4 Relay" <devnull+airlied.redhat.com@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20261106-nova-timer-v5-0-a0cd25f3ee18@redhat.com>
 <20261106-nova-timer-v5-2-a0cd25f3ee18@redhat.com>
In-Reply-To: <20261106-nova-timer-v5-2-a0cd25f3ee18@redhat.com>
X-ClientProxiedBy: OS7PR01CA0249.jpnprd01.prod.outlook.com
 (2603:1096:604:24b::18) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: f10d6b92-00e7-4f7b-2347-08df3d9f90df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|366016|376014|7416014|1800799024|22082099003|18002099003|6133799003|3023799007|4143699003|5023799004|11063799006|56012099006|10067099003|261028144727099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261021135927099003|261021123027099003|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: uc0qGq3U3tcFdXawoNjGck70N5oWYbASKGtFOYCSXMvPtRF2rgplzdALCSn72IcUzoDJNW7hwATA4yK+ZkoGYMaI4bGgSIGS5tLIuyx0g4qTIyC3T1J9k1KOl2vFH61sHnp14G8+b3PbJXvqrBaOslB6Rdv7hoD/X9GhXZPuIJbVRHVqQBrqKKLTROFG6CkZfeklBPmU+DZ24XsPaZVJDs8YAx+o+5krWuBvBc8NgYY2EX0aCf9qwxVqP5q3IRVlcDrTMTcHNHToRsPuTGRlAfJDmj1NKIPyqfLnd5h/TTz53kWopnzBYvrTGByppv5srmi4BcYHgiscdS52Tw6pR60f85W1ibH1YND9W8oD1bkCl6lJAuWkAlqdWwU6+SgByzysva2BSAD6UGmPXw3JDyMFKZGS0qSFAs3fR5qEvH3AoyFpinc5yq4zjUztDPYp+FItdWMTLFShFdjpqQK6rAOMbW+T2BTw7IgEA+EVV54kWpVpgEHvf+R+pVbTYSCjDZMTuhNwAARtyMwbMk52ZKrQHKWsmJ/iHQ9FfK98LXB00dOJIdG7IhRTuDYfECVnLqMoCVMQpiPYZ2CIPQkMZDnDUZq9dZFaj+Di88g4xoApfXx2Kg+bmenGXDzOtPk+P7xQvOZmD21S8f47klPSP2sAlOBvzTKlXLF05OLD6g0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(6133799003)(3023799007)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003)(261028144727099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021135927099003)(261021123027099003)(261021121427099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnA4VmlZSko3R0pseENCWnBEcHV1QTdoN0MwZ090SDZaQWZnMzdUYktqejFy?=
 =?utf-8?B?Mk0vcXhhTGw1bmNhK3RESm1DcU1tS0tOWTR3NGV4S0daMzJ2NDFpOWVrSVow?=
 =?utf-8?B?K0NDVVpCMVk3NnVnNlVzUEplYmtUeDdMSXdLalJWQ1VNTVFqUUxLZWJONHZw?=
 =?utf-8?B?TUNtMkh0clE5VXlzeXAyblRKY0Ixa2Y4UEdjd3lrVSt4eC9yT05WMktFOEsx?=
 =?utf-8?B?UEhuejI1bzMwZ1oxcGVqeHhDMGRLb1o0N2xGV1hnWTNMQWxPS25hczIyMk5x?=
 =?utf-8?B?cEFiZHMvcUJYRmF6eTd2RHNwdHZvYk12U1lDL2tVNi8vRW5xWDFoYjNORnJy?=
 =?utf-8?B?RzV6SGdTcnlNR0dibnZzZlE4ODljRDh4M0VsaS9TY3N3TlY5aEZLd0h3LzFU?=
 =?utf-8?B?WCt0RjNVR0d1SUEyS1RZNlgxRmFNbE5FbElMdWhhSGw4L0xXYTJxMC90ZTRm?=
 =?utf-8?B?UHc5Z050ekhIanE2REhEckpuV2dVOHNWSGxGNUpUb1JoYkNqN3BrMkhZeGIx?=
 =?utf-8?B?ZGIrR2lzQXNEMDBYcWdsUXlTSVhVZEdZNFk3RE9OU0hBOGs0MzNBdFpoYlkv?=
 =?utf-8?B?Lzc1M3FtRWI5azVRYWlxTjROMW1wS292cTNxTXFRTGhndjJ2bm1LbjlhQldG?=
 =?utf-8?B?b0l2aGdBc1lkYlJqS3BZaGliU2xvdWNTSTMrSFVFR1FYeG42QW9hc0lEVHdR?=
 =?utf-8?B?RWxRSDlic2M1RDBrM2xsVUdBbU5TT0dTbVpFVk9GUkYwaUlKaEhmK0oxNFpl?=
 =?utf-8?B?RXBJbmtKY2xqUDdGbnZiK1VlOVduMUNlUit6bGdNYjdNZjFDeXFQclJXRmgv?=
 =?utf-8?B?UFR2MllyQmEzejlxUnRwWUhUbVlja0owZ3VuaUFkN3hIZFNaVHM4OHVheUZI?=
 =?utf-8?B?MlBqcHJpWEZEd3krOTdGa0tYR1JnMDdWaGJVT2FEbzlzMjgzV2RKZ1JtSmVK?=
 =?utf-8?B?WC9RTjg5UC9pZlVVajcybDVuUElNTjg5aXIxalJFNjNkMHVHMXdIclUvMzFO?=
 =?utf-8?B?bEFST0VrKzNsKzdBMUJ5TXJ1SWVQR1h5aHRtSks3MUZmSDgwbGt5N0J3SnJE?=
 =?utf-8?B?UFlWd055RDZ4b09tYXk4azdKR3lLTy9kMHRnWWgzWUtCb0JHeFZSdHpOOTlZ?=
 =?utf-8?B?NTVudEF6dElDRS96ekFCWjI1OTRGeVBzbVNpMStzREVKQlhpZVlZYnhUcVg1?=
 =?utf-8?B?SWUvSjFCZEgrZmN5K0xPVHVNcUtGT0FwWnRqblMvOW9yUmpLZ1ljRHkycHV1?=
 =?utf-8?B?bHZTUjdFWVhGRmI5d013RnlPaUZXUXA2eXdrTWgrVWJja0plQkdTbEo5RUVi?=
 =?utf-8?B?eElsRzlad0xBUlN6R0tWU3A3RGMzSVRLMmxWSlpJaWFNc3RhT0dBNVRYR1lh?=
 =?utf-8?B?L2Nuc0QwNVBNeFRpUlAyb0NWYmVuTTFaR055OTRFSkh6bm1XbzhOS3FleDdT?=
 =?utf-8?B?MEJXZmZha29ra0lwOFI2YWViTWlZZ1hkbGVRSVRRNmdTSGdMdlNvVDk5MzUv?=
 =?utf-8?B?RFRhWXVHYW5xNnR5ZHN1Mncva1Z3ejNNM0doY2RtR3ZpZDlJaVRubmhwWWFy?=
 =?utf-8?B?QWNPNnhVN1RGVTBQbDlVa2RDOUJYQm1nQzJNZkpzOUp4aUVoTThJV2VlWlBJ?=
 =?utf-8?B?Z1pyZHpRMlY2eHpDUEpJdUVzMTVVdVlZa3ZkOHNRTFRlWkJlRVdjbXZreGVR?=
 =?utf-8?B?Y0pqYzNSU3dvMWdRUTFpQTJLTzl4OTZXU3FuUEpZS2g3L3NydVF4czYyaVdR?=
 =?utf-8?B?T0xHR2I2aEJHSllRWWY1c3lTWWtvbVVRdEx1cGJVMStHcVA5S3hOejNPZkhE?=
 =?utf-8?B?UmpON0hrQmtXUFlBek11cVNYbUtvWVE1NzRmZXBoZTRDVWtYLzROS1dyeEgz?=
 =?utf-8?B?UjlPOXpBUDkram9NeGxyQXI2amVCelhEVTd4RVJGcTFEZDhPeCtzajZxcmxT?=
 =?utf-8?B?UTErRVhnWEd4R1NLTzVtcDJTcFY1ZThpOXpkTnJTV2NsWHFtdVh2ZGVuRFR2?=
 =?utf-8?B?aVQ2N2o0NVg4UGhrTXA2eUYwSVUybTg3RjcwZXpZYUJFSUtOSVFnQUcvYmM0?=
 =?utf-8?B?SGdPWWdwM1NzTm9YbGtrV3g1c1ZaK3FjZ0xEMW10RmFYaVBJL3d3NUFYNWJY?=
 =?utf-8?B?V0xUNXIycUJLQUpOS2g1Z1JvYVdPMFNzYkRqUnYwckcwMFJhNU54UGxXYzAz?=
 =?utf-8?B?NXlEWnVsQWc4bWl0aTM1bmRZOUlXQkQ1c0VUV3U2QmtWd04wQkx0STF3YThz?=
 =?utf-8?B?eWl0algzZXJaT1krZTZwdGl0RlMzWFVJNlhEaGo3bHpScHllN0cxT2xQY3I5?=
 =?utf-8?B?MWFjdlNtSzRkRzF0YU53OTU1WCtwMDNtKzFscVpvTmhlYmo0cmdwbEdrNEVX?=
 =?utf-8?Q?3+5PzHYlNAT/D+h+RgIPtCdjxywScqlqQWscJS81Ma0TX?=
X-MS-Exchange-AntiSpam-MessageData-1: U9CXF35ba5oZmA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10d6b92-00e7-4f7b-2347-08df3d9f90df
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 13:52:45.0651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fjYpQv6S4dq/eKJNZq5aUW6xcEy3EUDle47NNSPnkHsj9m1Gd4En0PGBrBuwFwQBl+iDFQtCkEN4K+I6J8ox3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571
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

On Fri Nov 6, 2026 at 2:34 PM JST, Dave Airlie via B4 Relay wrote:
> From: Dave Airlie <airlied@redhat.com>
>
> This is needed to calculate the system timer offset that is passed
> to GSP init.
>
> 2 HALs exist:
>
> a) tu102 is the gv100 path from open-gpu, the priv level is checked
> and the cpu time is written to the gpu timer. no offset is used.
>
> b) gh100 is for hopper+
> This is the gh100 path from open-gpu, where the secure system
> timer is read, the offset is calculated.
> On gh100 which need a work around to avoid sending it to registers

nit: "On gh100 a work around is needed to avoid..." maybe?

> if the FSP firmware is too old.
> Otherwise we write the offset to the offset registers.
>
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> ---
>  drivers/gpu/nova-core/fsp.rs             | 19 ++++++-
>  drivers/gpu/nova-core/fsp/hal.rs         |  5 ++
>  drivers/gpu/nova-core/fsp/hal/gh100.rs   |  6 ++
>  drivers/gpu/nova-core/fsp/regs.rs        | 28 +++++++++
>  drivers/gpu/nova-core/gpu.rs             |  8 +++
>  drivers/gpu/nova-core/nova_core.rs       |  1 +
>  drivers/gpu/nova-core/timer.rs           | 38 +++++++++++++
>  drivers/gpu/nova-core/timer/hal.rs       | 31 ++++++++++
>  drivers/gpu/nova-core/timer/hal/gh100.rs | 62 ++++++++++++++++++++
>  drivers/gpu/nova-core/timer/hal/tu102.rs | 53 +++++++++++++++++
>  drivers/gpu/nova-core/timer/regs.rs      | 98 ++++++++++++++++++++++++++=
++++++
>  11 files changed, 346 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
> index 3a4a10487f33..a2ea50465a55 100644
> --- a/drivers/gpu/nova-core/fsp.rs
> +++ b/drivers/gpu/nova-core/fsp.rs
> @@ -50,10 +50,11 @@
>          NvdmHeader,
>          NvdmType, //
>      },
> -    regs, //
> +    regs as bootregs, //
>  };
> =20
>  mod hal;
> +mod regs;
> =20
>  /// PRC message sub-command.
>  #[derive(Debug, Clone, Copy, PartialEq, Eq)]
> @@ -389,6 +390,7 @@ pub(crate) fn boot_params(&self) -> &Coherent<'_, Gsp=
FmcBootParams> {
>  pub(crate) struct Fsp<'a> {
>      falcon: Falcon<'a, FspEngine>,
>      fmc_fw: GspFmcFirmware<'a>,
> +    chipset: Chipset,
>  }
> =20
>  impl<'a> Fsp<'a> {
> @@ -428,7 +430,7 @@ fn wait_secure_boot(
> =20
>          read_poll_timeout(
>              || Ok(hal.fsp_boot_status(bar)),
> -            |&status| status =3D=3D regs::NV_THERM_I2CS_SCRATCH_FSP_BOOT=
_COMPLETE_STATUS_SUCCESS,
> +            |&status| status =3D=3D bootregs::NV_THERM_I2CS_SCRATCH_FSP_=
BOOT_COMPLETE_STATUS_SUCCESS,
>              Delta::from_millis(10),
>              Delta::from_millis(FSP_SECURE_BOOT_TIMEOUT_MS),
>          )
> @@ -436,7 +438,11 @@ fn wait_secure_boot(
>              dev_err!(dev, "FSP secure boot completion error: {:?}\n", e)=
;
>          })?;
> =20
> -        Ok(Fsp { falcon, fmc_fw })
> +        Ok(Fsp {
> +            falcon,
> +            fmc_fw,
> +            chipset,
> +        })
>      }
> =20
>      /// Sends a message to FSP and waits for the response.
> @@ -549,4 +555,11 @@ pub(crate) fn boot_fmc(
>          dev_dbg!(dev, "FSP Chain of Trust completed successfully\n");
>          Ok(())
>      }
> +
> +    pub(crate) fn is_bug_3957833_affected(&self, bar: Bar0<'_>) -> bool =
{
> +        match hal::fsp_hal(self.chipset) {
> +            Some(hal) =3D> hal.is_bug_3957833_affected(bar),
> +            None =3D> false,

As I mentioned in my other comment, storing the HAL instead of the
chipset is technically better, but I'm ok if this is not done just for
this single-use method.

> +        }
> +    }
>  }
> diff --git a/drivers/gpu/nova-core/fsp/hal.rs b/drivers/gpu/nova-core/fsp=
/hal.rs
> index eaf5837ac5a8..8bcc8f71cf8f 100644
> --- a/drivers/gpu/nova-core/fsp/hal.rs
> +++ b/drivers/gpu/nova-core/fsp/hal.rs
> @@ -23,6 +23,11 @@ pub(super) trait FspHal {
>      // TODO: consider moving this into the TLV firmware metadata when re=
ady
>      /// Returns the size reserved at the end of the framebuffer, in byte=
s.
>      fn fb_end_reserved_size(&self) -> u64;
> +
> +    /// Return if the bug 3957833 is affected
> +    fn is_bug_3957833_affected(&self, _bar: Bar0<'_>) -> bool {
> +        false
> +    }
>  }
> =20
>  /// Returns the FSP HAL, or `None` if the architecture doesn't support F=
SP.
> diff --git a/drivers/gpu/nova-core/fsp/hal/gh100.rs b/drivers/gpu/nova-co=
re/fsp/hal/gh100.rs
> index 9a8563799da8..538870566b8c 100644
> --- a/drivers/gpu/nova-core/fsp/hal/gh100.rs
> +++ b/drivers/gpu/nova-core/fsp/hal/gh100.rs
> @@ -9,6 +9,7 @@
>  use crate::{
>      driver::Bar0,
>      fsp::hal::FspHal,
> +    fsp::regs as fspregs,

Since this is the fsp-local registers module, let's just import
`fsp::regs::*` and use the registers without any module prefix.

>      regs, //
>  };
> =20
> @@ -33,6 +34,11 @@ fn cot_version(&self) -> u16 {
>      fn fb_end_reserved_size(&self) -> u64 {
>          u64::SZ_2M
>      }
> +
> +    fn is_bug_3957833_affected(&self, bar: Bar0<'_>) -> bool {
> +        bar.read(fspregs::NV_GFW_FSP_UCODE_VERSION)
> +            .is_bug3957833_affected()

s/is_bug39/is_bug_39

> +    }
>  }
> =20
>  const GH100: Gh100 =3D Gh100;
> diff --git a/drivers/gpu/nova-core/fsp/regs.rs b/drivers/gpu/nova-core/fs=
p/regs.rs
> new file mode 100644
> index 000000000000..de69d5bed427
> --- /dev/null
> +++ b/drivers/gpu/nova-core/fsp/regs.rs
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use kernel::io::register;
> +
> +use crate::driver::NovaRegisters;
> +
> +register! {
> +    base: NovaRegisters;
> +
> +    /// FSP ucode version, encoded as `major.minor` in bits 11:8 and 7:0=
, written by the FSP
> +    /// during boot. (`NV_PFSP_FALCON_COMMON_SCRATCH_GROUP_3(1)` in the =
hardware headers.)
> +    pub(super) NV_GFW_FSP_UCODE_VERSION(u32) @ 0x008f0334 {
> +        11:0 full;
> +    }

I'd like our register definitions to reflect the aliasing of the comment
(which is also represented by OpenRM). So we would start by defining the
actual `NV_PFSP_FALCON_COMMON_SCRATCH_GROUP_3` (which is an array of 4
registers per OpenRM):

    pub(super) NV_PFSP_FALCON_COMMON_SCRATCH_GROUP_3(u32)[4] @ 0x008f0330 {
        31:0 val;
    }

And then define `NV_GFW_FSP_UCODE_VERSION` as an alias to the register
at index 1.

    /// FSP ucode version, written by the FSP during boot.
    pub(super) NV_GFW_FSP_UCODE_VERSION(u32) =3D> NV_PFSP_FALCON_COMMON_SCR=
ATCH_GROUP_3[1] {
        11:0 full;
    }

That way we can reduce the comment to the information that is not
obvious from the declaration. I'd also drop the references to the
non-defined fields, unless you want to add them - it is possible to
define overlapping fields, but since the code doesn't use them we can do
without for now.

<...>
> diff --git a/drivers/gpu/nova-core/timer/hal/gh100.rs b/drivers/gpu/nova-=
core/timer/hal/gh100.rs
> new file mode 100644
> index 000000000000..49e348c89e52
> --- /dev/null
> +++ b/drivers/gpu/nova-core/timer/hal/gh100.rs
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use super::TimerHal;
> +
> +use kernel::{
> +    io::Io,
> +    prelude::*,
> +    time::*, //
> +};
> +
> +use crate::{
> +    driver::Bar0,
> +    fsp::Fsp,
> +    timer::regs, //

Here as well, let's bring the whole `timer::regs::gh100::*` since we are
in the GH100 HAL, this will make the code more concise and easier to read.

> +};
> +
> +/// Timer HAL for Hopper and Blackwell.
> +struct Gh100;
> +
> +fn sec_timer_read(bar: Bar0<'_>) -> u64 {
> +    let mut hi2 =3D bar.read(regs::gh100::NV_PGC6_SCI_SEC_TIMER_TIME_1);
> +    loop {
> +        let lo =3D bar.read(regs::gh100::NV_PGC6_SCI_SEC_TIMER_TIME_0);
> +        let hi =3D bar.read(regs::gh100::NV_PGC6_SCI_SEC_TIMER_TIME_1);
> +        if hi =3D=3D hi2 {
> +            return u64::from(u32::from(hi)) << 32 | u64::from(u32::from(=
lo));
> +        }
> +        hi2 =3D bar.read(regs::gh100::NV_PGC6_SCI_SEC_TIMER_TIME_1);
> +    }
> +}
> +
> +fn sys_timer_offset(bar: Bar0<'_>, fsp: &Fsp<'_>, time_ns: u64) -> Resul=
t<u64> {
> +    let sec_timer_ns =3D sec_timer_read(bar);
> +
> +    let sys_timer_offset_ns =3D time_ns.wrapping_sub(sec_timer_ns);
> +
> +    if !fsp.is_bug_3957833_affected(bar) {
> +        bar.write_reg(regs::gh100::NV_PGC6_SCI_SYS_TIMER_OFFSET_1::from_=
nsec(
> +            sys_timer_offset_ns,
> +        ));
> +        bar.write_reg(
> +            regs::gh100::NV_PGC6_SCI_SYS_TIMER_OFFSET_0::from_nsec(sys_t=
imer_offset_ns)
> +                .with_update(true),
> +        );
> +    }
> +    Ok(sys_timer_offset_ns)
> +}

So I know we discussed that on v4, but this function is named like it
just returns a value, whereas it also might program some registers. Can
we mirror what `tu102` does and extract the `if fsp.is_bug...` block
into another function that `setup` calls?

Your argument was that resume might need to do the same thing, but
it seems to me that resume would just call `setup` again anyway.

> +
> +impl TimerHal for Gh100 {
> +    fn setup(&self, bar: Bar0<'_>, fsp: Option<&Fsp<'_>>) -> Result<u64>=
 {
> +        // The open drivers uses wall clock time here not monotonic

This module calls it "open drivers", tu102 says "The RM"... Let's call
it "OpenRM" in both. :)

> +        let sys_time_ns =3D Instant::<RealTime>::now().as_nanos();
> +
> +        // fsp is required on gh100 - return error if not available.
> +        let fsp =3D fsp.ok_or(EINVAL)?;
> +
> +        sys_timer_offset(bar, fsp, sys_time_ns as u64)

`as` statements require a `CAST:` comment that explains why they are safe.

In this particular case I am not sure what we are supposed to expect, as
an `Instant<RealTime>` is not supposed to be negative anyway. So I
suppose that could be the `CAST:` comment.

> +    }
> +}
> +
> +const GH100: Gh100 =3D Gh100;
> +pub(super) const GH100_HAL: &dyn TimerHal =3D &GH100;
> diff --git a/drivers/gpu/nova-core/timer/hal/tu102.rs b/drivers/gpu/nova-=
core/timer/hal/tu102.rs
> new file mode 100644
> index 000000000000..629d744a4b12
> --- /dev/null
> +++ b/drivers/gpu/nova-core/timer/hal/tu102.rs
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use super::TimerHal;
> +
> +use kernel::{
> +    io::Io,
> +    prelude::*,
> +    time::*, //
> +};
> +
> +use crate::{
> +    driver::Bar0,
> +    fsp::Fsp,
> +    timer::regs, //
> +};
> +struct Tu102;

For symmetry, let's grant this a comment like its gh100 counterpart.

> +
> +// this code will be used in the gb10b hal eventually
> +#[expect(dead_code)]
> +fn timer_read(bar: Bar0<'_>) -> u64 {
> +    let mut hi2 =3D bar.read(regs::NV_PTIMER_TIME_1);
> +    loop {
> +        let lo =3D bar.read(regs::NV_PTIMER_TIME_0);
> +        let hi =3D bar.read(regs::NV_PTIMER_TIME_1);
> +        if hi =3D=3D hi2 {
> +            return u64::from(u32::from(hi)) << 32 | u64::from(u32::from(=
lo));
> +        }
> +        hi2 =3D bar.read(regs::NV_PTIMER_TIME_1);
> +    }
> +}

Usually we try to not introduce dead code proactively, especially if the
user is not in sight. Can we introduce that alongside the gb10b code
that makes use of it?

> +
> +fn set_time(bar: Bar0<'_>, time_ns: u64) -> Result {
> +    if !bar.read(regs::NV_PTIMER_TIME_PRIV_LEVEL_MASK).level0() {
> +        return Err(EINVAL);
> +    }
> +    bar.write_reg(regs::NV_PTIMER_TIME_1::from_nsec(time_ns));
> +    bar.write_reg(regs::NV_PTIMER_TIME_0::from_nsec(time_ns));
> +    Ok(())
> +}
> +
> +impl TimerHal for Tu102 {
> +    fn setup(&self, bar: Bar0<'_>, _fsp: Option<&Fsp<'_>>) -> Result<u64=
> {
> +        // The RM uses wall clock time here (osGetSystemTime -> ktime_ge=
t_real), so the GPU time
> +        // matches the host's real time, e.g. for timestamp correlation =
in userspace.

nit: s/The RM/OpenRM.

> +        let sys_time_ns =3D Instant::<RealTime>::now().as_nanos();
> +
> +        set_time(bar, sys_time_ns as u64)?;

Same here, this needs a `CAST:` comment.

> +        Ok(0_u64)
> +    }
> +}
> +
> +const TU102: Tu102 =3D Tu102;
> +pub(super) const TU102_HAL: &dyn TimerHal =3D &TU102;
> diff --git a/drivers/gpu/nova-core/timer/regs.rs b/drivers/gpu/nova-core/=
timer/regs.rs
> new file mode 100644
> index 000000000000..89dd478a37be
> --- /dev/null
> +++ b/drivers/gpu/nova-core/timer/regs.rs
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use kernel::io::register;
> +use kernel::num::Bounded;
> +
> +use crate::driver::NovaRegisters;
> +use pin_init::Zeroable;
> +
> +/// Field value for the NSEC field (31:5) of the `_0` registers: `nsec[3=
1:5]`.
> +///
> +/// The GPU timer counts nanoseconds with 32 ns granularity, so `nsec[4:=
0]` is dropped.
> +fn nsec_lo(nsec: u64) -> Bounded<u32, 27> {
> +    Bounded::<u32, 32>::from(nsec as u32).shr::<5, _>()
> +}
> +
> +/// Field value for the NSEC field (28:0) of the `_1` registers: `nsec[6=
0:32]`.
> +///
> +/// The GPU timer is 61 bits wide, so `nsec[63:61]` is not representable=
 and is
> +/// truncated =E2=80=94 the same bits the hardware discards on a raw reg=
ister write.

Non-ascii character (em dash) in the comment.

Regarding the truncated MSBs in `nsec_hi`, I *think* it is ok to
truncate them indeed, as the value written would still be a valid anchor
value for the GPU. It also shouldn't manifest itself until 2043 or so
for chips < GH100, unless someone decides to mess with their system
clock.

I guess this issue is the reason why GH100+ are storing a delta instead
of an absolute value.
