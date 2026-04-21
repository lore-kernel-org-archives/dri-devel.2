Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73864F327B2
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B472C10E7F7;
	Tue, 21 Apr 2026 07:08:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="C7ZURTBM";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05CAC10E18C;
 Tue, 21 Apr 2026 07:07:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTZ+lRdXpDgtawHLNqlz/sfVEhTMM75mkUyDND4WYep8/uclfplYaDHjE4UqH4/RFxPKz+t3UC+oW2XKS89dQR9EgItCYkC9sQHL1c//tLUc43FJbxmeZOSEaHNiLrjTOOZNm17Mw6ZEQBf5aXx+gmWMsmHDVzBsRRkHvzYKKQpemzaOTxyaZSNOfRoSYCJIJnFJxVfdT2bdYZRE98J3WsnI92Z0v2/5Dlxtorc923xrGWK1VmdNPxlVgi4vBxllhVAatqjIRXA39pilv6lTipEjx9qSPZhtDpDFHRHMBgvSUK+37MIcVtv+TburfHL2BJSqUlJ/jSc1rvfzSk2FUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ek+vlvo0xuKoimHR5KbPJcTEB++ViUciv8U1hCvCUYo=;
 b=ih0fVgCFfzKgTHeiL2/A8Yw1lVC+k70qyRZDPaNjx2RZKVO+E/FmQf8hYx9hiD82OnoGsHV+joVjMLcOSIJ7rsyZcVy+sbFsOQNIZCgA5K3doYSyZhcT2QudF56LsqfnQ3TX84fuXJRxCrcM+t2hc9SeHGyKBIFbAyZey+7QE+JIkrBpbVjGNaFznQvr60/Zc2HGnKgEq+wzqKp78J/6k9OcuPwbB9z4U3s6LOWKPcQBXzpc7LQ2IbLmTrasc6Gzcob7YmzUQEs2wa04FlAzdiFIBTIhCxk07TovwcVCa+Mp6k/i1h5fbGANf/eBSl5OS8u5E1nI+jyc704uB00NuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ek+vlvo0xuKoimHR5KbPJcTEB++ViUciv8U1hCvCUYo=;
 b=C7ZURTBMS9E4ElBBMwZSy0XdUPyDfMDxQYgqu26JzqPqO6VdSEnar3y4IUSnGLfvtDxD5HMbrPrTIPJhNViKUrjD/O9FuHM1IPWcv+9cGjy8rwxp7Ddzq/Qge2+FiQcQPo5uwVidkESQErOnzRsIBCId+K25eEofmv0GiKsIV+OSBUCHj6zI857y22m04Ry00Ixpo3CmjtfkITStPoT9vjH/1M4AAG5dz9FwkMKFnmt5UydLZTuM252NegJ3C3BqjPZW0zYRd833ZAqYXgvdZFXj8UsaFQKC+vDj6Jwtg/Gl61SKEL4P+g59NuTKljxchfbkS35GQU2qdL8x0R9pYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH8PR12MB6772.namprd12.prod.outlook.com (2603:10b6:510:1c7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 07:07:54 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 07:07:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 16:07:47 +0900
Message-Id: <DHYN6DTR4KE4.1WN4EVEZ26WB2@nvidia.com>
Subject: Re: [PATCH v2 1/5] rust: add warn_on_err macro
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Boqun Feng" <boqun@kernel.org>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260421-nova-unload-v2-0-2fe54963af8b@nvidia.com>
 <20260421-nova-unload-v2-1-2fe54963af8b@nvidia.com>
In-Reply-To: <20260421-nova-unload-v2-1-2fe54963af8b@nvidia.com>
X-ClientProxiedBy: DUZPR01CA0180.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::14) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH8PR12MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a9510ab-37a3-40b5-a942-08de9f74b4fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|7416014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 5VqQ5/ISk2lz6P4A388i+pAqikJtv1QrvjbB8aS1IF2K/lXoDcJ8NrQOcpBnRfo2HRNkDKJHIxkJpbVA52bTvPBr1LSiiVDcqKoWI+WnLAXPuJ8G+gB7frP95UQgULP79BjGKYj0OXLXVbJMPLk3/VgZlH4SU8eyV2dSrm+N3srA6ujqfYOTLyApG5oUR7d2YtwpRIZy+BEb4mAFBpBewbK9n6yisvkmFPhQy494V+XhwCgQH0owoheKIQX09KVmgxKBtxreBq1V5CzOTAej8V8ZfS7uVb7S3fwmzFGEr0PSgn7M3CMs/mLN3PGfbxK6Opw9yDe83ZIILU/4TSI18rZBDjQhUs9rU4V+RijcqTehvMAxOBFi0L3ijnqNzhgEyfDadfHgPJ3km/cGJ4h3ywTcC8KiAKlRoeiCJPVcjud9vQasJDO2KDC3pjL+ByeWtoMop50o29MtETjzVe6l/5prqP0zIJkivxReibmv7zKUc5sYCi/kiz7wqmpPZTsaQFoRwEdinuvnB9oDJr4+ZudZDH2AVUqTBu873+aShpErxot0l9TaZcpeBlpraERVL1HEaKAThM0fJKDihpzKCmRRiNYaQXRqgXq4lr3V1rdAY/OicP2Bi18HLyxOTfdI1R8H9yxa4KMZ9Cpt8VDkd824ileSWlmfo7yZgfBYFDKyYeCjSC/RkXLLy8TQVZJYdY4gBHTLRhJxuMZQq77pKdGrnZdi3UMqSsHruB5bU1cOkzNv7tgSwygM82hTwL7dxuN8nNoOGn1v1wpTZPKtPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(7416014)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VklRN2UzRVNkc0YyWlBFUGRGVVRVUVZrb1dyYjVEU1BHL2o1ckQvQVNSREth?=
 =?utf-8?B?V2ZZUFhSNU1RTGNWQlVzSGJtU1JNaTN0eFZuY1FBLzZXOElwWnVjbDVDMEd5?=
 =?utf-8?B?dWUveURXeWlWUkVzQ0dHMHdSVlVvSVgxamVYMVRtdk9DRWVUQVh3RGllaDRP?=
 =?utf-8?B?Y2REb1JEVU4vL1lYcm51S2R0UWdKTW9XTENINDBtL2h1NDYwbTJscmcza2px?=
 =?utf-8?B?aHFadmFUSHZCQndtQmhiT0swWUlwSnlvUjEra3UxWEs4WGliZEp2QW9Hbitp?=
 =?utf-8?B?N2NjZ0UzVUJWdGI5UXBJT0xRSWpRV0FiOHRORVNMMGkvZC8yME9RZFYrZUc2?=
 =?utf-8?B?WE9GbkV0d1hYbHJ6ckdnbXJUZTFwcVkwOHloSlZNZFc0QVdrNFNTL3MwMmRB?=
 =?utf-8?B?YXBCTC9seGh4NGV5enNZZXBZbGJ2THpjQm5qUGl6cGZIUlcvS1FtUFRxVGlx?=
 =?utf-8?B?TnJzSjJSaVUzejVva2pEcHJnWHFyTElpSCs5dXBJZmgrblEzcnJCWFFkb3Bv?=
 =?utf-8?B?YWtzN1VaMklaVW1xYUpGZ0JYZndaWDZodmNCaTBsVm1tY29GM1JQUnBoZzFR?=
 =?utf-8?B?eUhFaDdvd2JaQ2c4UDVrNGYramlMbWU5eFZnNjN2eFhBbFdmQXBGMGZxUVQ2?=
 =?utf-8?B?bHhCeSs3NkgvN2d5elZsNGg2eDB2bGNwczFGOHQ5MThXSXNMMmo5VEpYcElR?=
 =?utf-8?B?T1RESlQyVVM4ZWRFc0hMZVVOYWxNNGpoTTFYdS9YNTJhVVh2bGV5R3VVL3Zy?=
 =?utf-8?B?WXFMQk5ZSVhzMWZ5MnR6ZFJ3NFVpemQ5aHF0TkEyVGJZejBjaUNRcDRpMGdL?=
 =?utf-8?B?Y25uUFF5NHBoMFJDVTg5S0xiY2tEWVRCa09FVWJVUUJYZUhRNERkYVBSeWwx?=
 =?utf-8?B?aVpNQVQxVFlVWUVkUENyaWFNTUk0M2k3bHJQSUI2eTluNWdzWWxicXZpNDd5?=
 =?utf-8?B?azJMbDZyenh5MHBVbkFDbTREWElENlJnMzVZUE1Zenk1OFY1T2NVUUcyaFlX?=
 =?utf-8?B?K0lJTkEwSnc1YVl2bEtqbGlQaTBabURaQnFXMWxacU5SeXVUZVBHNXpFOGN6?=
 =?utf-8?B?L2dGUURVU1R2Vi9hM3NPMFptYTR1QTdpNTNONnNITG9TakpmTGMzaDBJSUxM?=
 =?utf-8?B?VG1oTTU0czhFVkd5Q1kvNzdGNU1Nc3V2dk45VUZ5Y1k3UnpzZ1R4YXdmLzFB?=
 =?utf-8?B?aitKcGR3NUhVandCbktiZ0lJNThaS1Z2Lyt2WldpbHVnUWVweW0rcXRUVmJF?=
 =?utf-8?B?Y1JmWUlKTjZ3NVZ1cUJRRUtKaENkcEhPdXkvRmV3UmtRUTlKNzE5WWlvcUt2?=
 =?utf-8?B?QlJrdVJTRWhxbnJRcjdxS25GaE11SGN5bWNldmN0NFppN2t5Rm1WTmxjVThI?=
 =?utf-8?B?NFVtZmI1QWFObk41VWNrRGpFa1JxWUM0NlJ5SEhTRU50U096cno3bUNwNThz?=
 =?utf-8?B?MnJ4cGdYeU9PQXhESExnU1M2NGYyUVp3UlFnSnJOYlNwcFNnWFNiRDFWME1P?=
 =?utf-8?B?RXFobUJYeTlrZGdTdGlWYlV1VFdwSXVkT01LZkh5OUtQMDlwbU9Ta2lEWVF4?=
 =?utf-8?B?dU1ZTmlwOXlFQ0hmVEdYTTBvUU5tK0FhTnlpbmVqNERnckUvclFsM3V2UE1q?=
 =?utf-8?B?OGtMVis3bmpTU3ZQZVlQQ1pZbzB3dWwxd3VmN0pGSFV1Z2NaSG0zSXlmd1Qy?=
 =?utf-8?B?dnZXZHVDNXhDSmJZTmN3b2xyZy8vYmErdkRtcVpHcEgwcDh2UHB3bi9nWjAv?=
 =?utf-8?B?bUQ0UVFJdytXR0pYTFI0TGdXd01XVHRMYWsvYzQ0OUpOQzk4RWJuSDZkTFZ6?=
 =?utf-8?B?N0hqUDF0bXY0SnZGR0lTeG9hQk03ZDdCL2U5OHczZGw0cFNQU3dJNC9vR1ZD?=
 =?utf-8?B?MDM2V2tYRHA4SThrdTF4bmV5alRJN01CK1FaTVFOQmlKRFYxY3pnbDY1M0J5?=
 =?utf-8?B?dFFEYTNRQVk3KzBxR1FZWTVZRVFhWnlBckUvN3dFakFMODE4QlRiNHY3c2RL?=
 =?utf-8?B?SDRqUDZPWmhlWklaRnlRSmxZbFAxVXNsQnEvcGtnSEQzbjZzR0RKUmtDVVVp?=
 =?utf-8?B?NDNJNmJFRTQvcVc3MWxDTS90ZVY0Z01oZEh4SGJhNURRM2J4UVp6eDJwV1U1?=
 =?utf-8?B?N0liYmNFMVd5SUxML2JHU1puZWlDcExONkZ0SnZDZW5MM2ozekR6U2NlTTJV?=
 =?utf-8?B?TXVTSG9nbTc1RUFOSWpLakFNT2JOQ0x5WFRmVjd1Q0VWc1lENjhFMzVpSGFX?=
 =?utf-8?B?Qk9pU2JjaXFDM2pqWm1HellBVVFTZjF3ckZqZHRoRXRpU0VOK0ZoVkxsK09T?=
 =?utf-8?B?QnZBL3Q1TGtyTzQ4SjZQMnlIaGYvTnZsa3hmeW80REswMmNLb095MndTR281?=
 =?utf-8?Q?M1ZWrRI5sQO0+hH9lASxqs3nPi6xLrukpEjlA3qy4Tbig?=
X-MS-Exchange-AntiSpam-MessageData-1: G9Z0Y2LnAaBCtQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9510ab-37a3-40b5-a942-08de9f74b4fe
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:07:53.6042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yeKs/dd3bgqL7JA0eXX6+M9l3WB/x6i3MsmLrtWIprDrHB6vZ3ugh3PzTIFWSK0pjQD5a/VgRgRU3mh08vJrlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6772
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

On Tue Apr 21, 2026 at 3:16 PM JST, Alexandre Courbot wrote:
> While we already have the `warn_on` macro, a common usage pattern in
> Rust is to check whether a `Result` is an error. Add a helper macro that
> allows this.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  rust/kernel/bug.rs | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
> index ed943960f851..2fefc0aeef81 100644
> --- a/rust/kernel/bug.rs
> +++ b/rust/kernel/bug.rs
> @@ -130,3 +130,13 @@ macro_rules! warn_on {
>          cond
>      }};
>  }
> +
> +/// Report a warning if `res` is an error and return it unmodified.

nit: "it" -> "the [`Result`] `res`" since it somewhat reads like it's
returning the error

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>


> +#[macro_export]
> +macro_rules! warn_on_err {
> +    ($res:expr) =3D> {{
> +        let res =3D $res;
> +        let _ =3D $crate::warn_on!(res.is_err());
> +        res
> +    }};
> +}

