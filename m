Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6E3606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UAPbhmbZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 179DF10E866;
	Fri, 30 Oct 2026 07:57:45 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010001.outbound.protection.outlook.com [52.101.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 347E010E866;
 Fri, 30 Oct 2026 07:57:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2+7z4A8HBUI+neIwmznASfp9yjXdzAKHeMuKsD+86Z3ACUWc7dzVLAYxoEfPYW6MNO/Aj1mkeveQjAwQ1u6n8HVteM+VZCxKUuf2Zyr+4X6iZ59nZRZzDgWRkxEXoqYe9NSXNWFAtnkY6cD92VEl6KC89JvAkHRYVuabS/CcwZugieIsZzydxJ0vO1LrwlPdGX2vBv7oDCKe/syx9HSmkIbylK/5XLRwf/1PQTLh/1I9R8f7ZS/6TCqlSuK/gsPzvTNyhhB1ZJ2kKt6TdUXZINrnjmYc8dTLB+YwXMlHkdTuQzUaeUUFn2pUztkI+HC/iX83DSf9qqzKo3ydEnvNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=da33TEhnjgdk+i95Xp44MVbUqZxQTCCTTV2YaOVT4q0=;
 b=QXc4AxviTl3o1ulegq66ubnWKd/jHWH8iWNtXEscU7x+RRitcNXZLzTmxmqeQJNYD+s0bw0t53gSdrIFXXF04vb07vxSrd90u4WpThLn83gjinxm+vI0uTV1wQkVgslyl96yM6QLXULbN2MHeg/eqmUhxru67n++LCgfOYR+8p7JAqSU+WUWdMv6h3W78MQYiKmMxrYys15lwtoTF+grHAfQYC7jVarv+NibiiX8HiAJQcfcnJDnEkaGalyZI4jb1g38laT0rgpnbS6Q59P2I0JAsqekFarkm0dK7tdE5XfTlyHcaw15f18Px/u1yo5h2UdQD98qurHzbOg9KRK0lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=da33TEhnjgdk+i95Xp44MVbUqZxQTCCTTV2YaOVT4q0=;
 b=UAPbhmbZSDkMUVJNDFSxVGPGqvQPMsPzUQfp9FRuITfOvKRxPgdi1tMRgwx5aJzVMxcAQGXeLRw8IQJPRJpk1XN5lQ8rA5RFe7aYYrea2CbDm4kqDukxzxKK08sX6wOh09zTCdIVBQYxxyloUG6kzVJ+c904YvNFyKdOvkdc+3dkRWo5kZ2XLIdyfd95+WWB5LveIbYyqOn0/XIxq4bcyObCo55Laumqwjt5ezAexChZZUHbN+f17MWcFS1F4zDTpDVo9qW6eHyL0Fyz9KkJLUClGE4IJTCzj2wrpJCLSuPA+db2e+w22CdIq0OiCz1Jr3B9w+Pp1jcV5riWik2QXQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Fri, 30 Oct 2026 07:57:35 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 07:57:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Oct 2026 16:57:31 +0900
Message-Id: <DMI0H1ZU5R4C.25MM4QF6UDWA2@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH] gpu: nova-core: make pramin/buddy optional
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: <airlied@redhat.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261026-nova-pramin-option-v1-1-d073b3f047fc@redhat.com>
In-Reply-To: <20261026-nova-pramin-option-v1-1-d073b3f047fc@redhat.com>
X-ClientProxiedBy: TY4P301CA0084.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::12) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BL3PR12MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 04539173-afa7-4e96-1aa7-08df365b7558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|10070799003|376014|261026140227099003|10067099003|261021123027099003|56012099006|261022105027099003|11063799006|261028144727099003|261021121427099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: J3XV59OCiRKeIdD6/6qmi/RtcooCvBzDWre+5B1D49Q2mfI2/ozaRZow4cdaMYyURyIyl16i30AYmR+tqHajciWtiPxxHbtybQqs/xBX718nduvKV7X9E4qkv9qaLXiiLouwFalbUbIW6wMF1R6PAxf0VHEuLYKyvNOJdYWHDE3kIYwCMppm9e1fKOrVPrmainSM6NOL+DglM8+ZfVthTGb+40IrQcwtkh6CnKie2GhNAs9smvcB2G30doNnmH8xT/PgiAMb3/AoBfIlP74fkpTGGlOpFOH3jpu6U1eLO/FHaucgb0LGMPiJ4kJfJNK4yFtHRdooSu51xi3qnLvNKpjPmTU59kiYq/IqSKk3N6tubxd8KkhI2Ms+Py0VqNBiELvJrypLq+hNDGjsNmo0LckQPs0V5DKp0ijo3oV2tZkdBYqB6GjIjHkPnIiMoZgpc/kaa/WxOathk/RAxw47WqHWmsghQlnESVq9xXqOHOUI3szqj6KxBm4ppDs01wFC8Wl0sOPYbw0fdSco1OVMcwjqPfPaYzAsLomHVcSUOdz1cxXUmsFLTPmg+PT9b8HbMQukFA5RpMyzTbwSI0fDQPsMsd6WXvoju4l+jcg676hvhJsx5FnQ26sZVAkXnSOiBQyBUjZ/WtQbq5TV82hYltG/kcV7Lo3Lc0Rq+XlwdiI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(10070799003)(376014)(261026140227099003)(10067099003)(261021123027099003)(56012099006)(261022105027099003)(11063799006)(261028144727099003)(261021121427099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVk1YzdibUJUQVRMa2owUzhSaUtCVDZkQzJURjZFNGFJa2FyTGk3WGFrTjlS?=
 =?utf-8?B?NzJnYmdJMFpUMklOZnAzL3JtMk5XUTRHRWUzTGx0aU5QamdOaWxFd2h0VFdJ?=
 =?utf-8?B?d1dyd1E0UnRDVTVkTEtXRVJiU0VTLzVBc25TaFJYK2orajdFcFBZdU5zdE01?=
 =?utf-8?B?UFFxLzhNa0NXTStwU3NUYlE3V0dsZHFjbzlNaURTVDFMa1FGekRCdDZCQnF4?=
 =?utf-8?B?em9PVnhwRHh5TENWWkk5SVo2YnBwU0tuN0JKZWU1Ty80ZmQ1ZmdiSlZsckYw?=
 =?utf-8?B?cU9FN2kxSXZOV2FYNGpZVWNsYWJjSnRaMXBBSlNQNzNjM2xMako1S2tsR0h0?=
 =?utf-8?B?UzJBY2ttVXBkdVN3QzIzVjVsVFVhSDZodXlRWWdjcHFxc1FoVHYwQlkxeGNp?=
 =?utf-8?B?ck8wUmRWejVHS0ZIS1hteDdOaWpESXc1Uy94ODhBSi91Y0RLdDdvL2VFRE5k?=
 =?utf-8?B?WjVmV0xDQVFicWNrOHRnMFF3TmRMNFVSNVRsK2M0OWt4RWR4bW9xeGpRWDc1?=
 =?utf-8?B?VEw4akh5bVlLWnNjMEtnY3BmNTF4c1ZheXVrenVPYXE2Wms0cFNjRjJicmZO?=
 =?utf-8?B?YTRKdk1SdXRlSXViZkplY3ZqTVhZOTk1L0Rob1JaVVR0c1pZdkJ2K1NVNS9o?=
 =?utf-8?B?bTJhZ0FqSWVyT1htSENuY1RrQ0RMT1phRHRUYkM5VnN0RzdLWnJ4SXlXbDRm?=
 =?utf-8?B?MXJON0xWME5lOUdoZjl1OSthdWNEbC82bDNZMDJsK2MvZkwzOHc1VlMrNXhR?=
 =?utf-8?B?MXphWEdaQ0E1N0lBQkYvMDRQRDNDckNJSUU4Yms4QThDTFE0a3BPdExEVmlP?=
 =?utf-8?B?ejhkWXMyVG5IY1pJWnNYeExEaEEzYnczTU5OZFUzbWFoSjRtdmZxYWNHVmtD?=
 =?utf-8?B?Uy9yR1QwUGZ2R2xoenQ1ZC9VWDQ2MW4ydCtrTjluaWhndDVYRmduMFJQbmw1?=
 =?utf-8?B?cko0REgwUFUxVno5MTJXTlFScTNzLzIvSElnQmlTTTFTeFpMMnJqd01MWmsx?=
 =?utf-8?B?MDBQaFVUSEFucnRuWEs3MlN2bFEyZ3krR1U0UWczaStmR2YvRTJiaUw3a0Jp?=
 =?utf-8?B?cndQd1MxSDVWWkRWN1YvQ3lRUWFDV2FCRjU2QWplZWFDcUtkV2tmcE9NMTRv?=
 =?utf-8?B?NGF4blpGSWlHaDRRMldPUkNjSXVXOFZtb3VNcEthTCtUOUYrdWZOQ2JBTFlN?=
 =?utf-8?B?NVFwemRPYXhUdWpTVDVXSVU5bFlDTlBGajA5ZTNXVjdCRGVWTkY5d2VRT0Yv?=
 =?utf-8?B?TVpscEJnOEowbUlSREpEYWZHQ0ZVeXRHN2xCbk92RE5HbU02ZU1UZWRqSVlr?=
 =?utf-8?B?QkRRUUtLalRMdkdRYWZQQnNYR1JMUTlFTHFUbE9EVGxwK2hIa3hDZjA5WVJo?=
 =?utf-8?B?VXJLK2I5T0I5My9aaXVMM1BiaEw4TVBCbkFta3psc3UvZDdpU1NDNXQ0NGVL?=
 =?utf-8?B?YzNLUzdvSmluSCtPSHNtSXQyWjlld3hoN3A4K3hnQmlMa1gxWi9yQUVZZmFY?=
 =?utf-8?B?dnQydXkzVE9ITmZMdDM3VDUvcEVMNUVaT1FOVW9Ya3pUdXBPWGdRTEoxOS8v?=
 =?utf-8?B?ZG9yQmV3R2NQMnRMYStqbUU0UWpxZW9wQStYSENLeWFNU1MwT21FSVdrdEpy?=
 =?utf-8?B?SWtnbThJaSs5MnY5NThOTG9ucXZSR1VCRDI4NUx4K1FuUVlVNlhBdUxzODg5?=
 =?utf-8?B?TFp5ZS9icW8rY3ZBVmZmRVJKVnFTQzJHZit0Zm9lMVJhUWp0VXRKYktBQllu?=
 =?utf-8?B?TlRtRTFJbmppN2E1cEJyMitmWEFyRFBGTTFCcmo4SnNxbHI0VTJVWWFDc2w3?=
 =?utf-8?B?cDdxOFQ3SFVDTENBNEtCUXkrZ1JZTHZyeEQ1U2xWZXkycnV0NS9kai95cXZF?=
 =?utf-8?B?UG11U1hTOXNDOGJNOEFwK2VMVi9iQ3RnR1JPRDJyQU5vODRsOGcrWmVZb1Zi?=
 =?utf-8?B?RlRQVkpvMHZrYUJGY2J2S3ZnVHhqUUpmV0tyUVlIWjdGenhqVkQvNlJpKzVt?=
 =?utf-8?B?TUlheXlMdXZHWFZLdUk4VjI5V1hLS0RmNllCUzlwRElPcWJBUGZ0QUQwTWNa?=
 =?utf-8?B?T2hwcnVNKzJTSjBSUkZSeEYzZGlCOE90cWVyMTI1bUZSNzhFVXdiaWdjSU1h?=
 =?utf-8?B?Ym5aa2VGNVVzRUUreVlsZGxGa3VoMktJTkxYVzJFZ28xWXVCaGI3Q05JaGlV?=
 =?utf-8?B?WGhqeTJKUldLMThYOEV6aitZR1hFZUkveGlPcmcybDVjUEsxUzllMlluQy9C?=
 =?utf-8?B?VlpSZG94RnlpempCY0JObWNtNHhiTXY4RXc2WmhUbm5aUDhwcUlpcnc4WDlk?=
 =?utf-8?B?T3BsZ2RaK0FYemFtc2lpeEh1MVh6bXVUT3BEb0ZoWUtleFltTEdkbnlnZ1Zv?=
 =?utf-8?Q?83eUO7f7LeU5WpiC7KRg9x37rvy9aIn0D/FldghijCJI6?=
X-MS-Exchange-AntiSpam-MessageData-1: tTJHc7rkvKvj7w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04539173-afa7-4e96-1aa7-08df365b7558
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 07:57:34.9576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y45+/H5A2zBxK/xo/aDxkCPOyDJtJVpu2GAp6ge9Fc/SEQrKxsPPJcqBlWud+Jayk1L8Ctbv18MPD0c1H3oh8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6619
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

On Mon Oct 26, 2026 at 1:24 PM JST, Dave Airlie via B4 Relay wrote:
> From: Dave Airlie <airlied@redhat.com>
>
> These aren't used on systems with no framebuffer memory.
>
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> ---
>  drivers/gpu/nova-core/gpu.rs               | 15 +++++++------
>  drivers/gpu/nova-core/mm.rs                | 34 +++++++++++++++---------=
------
>  drivers/gpu/nova-core/mm/bar_user.rs       | 14 ++++++------
>  drivers/gpu/nova-core/mm/pagetable/map.rs  | 10 ++++-----
>  drivers/gpu/nova-core/mm/pagetable/walk.rs |  2 +-
>  5 files changed, 38 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index 4e59072cab50..5d53fde2cdc1 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -564,18 +564,19 @@ pub(crate) fn new<'a>(
> =20
>              // Create GPU memory manager owning memory management resour=
ces.
>              mm: {
> -                let usable_vram =3D gsp_static_info.usable_fb_regions.fi=
rst().ok_or(ENODEV)?;
> -                let buddy_params =3D GpuBuddyParams {
> -                    base_offset: usable_vram.start,
> -                    size: usable_vram.end - usable_vram.start,
> -                    chunk_size: Alignment::new::<SZ_4K>(),
> -                };
> +                let buddy_params =3D gsp_static_info.usable_fb_regions.f=
irst().map(|usable_vram| {
> +                    GpuBuddyParams {
> +                        base_offset: usable_vram.start,
> +                        size: usable_vram.end - usable_vram.start,
> +                        chunk_size: Alignment::new::<SZ_4K>(),
> +                    }
> +                });

We should probably add a helper method on e.g. Chipset to say which
chips we expect FB on vs not, instead of proceeding with no fb regions
here for ones where we expect there to be one.
