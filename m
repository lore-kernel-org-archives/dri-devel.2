Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFC7606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 07:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iWRUV8jm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4337210E21D;
	Fri, 30 Oct 2026 07:55:02 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010037.outbound.protection.outlook.com
 [40.93.198.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76B5C10E21D;
 Fri, 30 Oct 2026 07:54:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0a8BaVqKpJ5h7/BT8crhFNka/xBBCQENnyZSHCg7xXSrxeT0rmo3FNttlejBdllmH808UWLyRQJBHjsz4bD1neu7rW+LRX7J0c+vLloLNGv9IgOJWeuu5DMvQrzdyr25JBclNSZtLcL1KWMsuJ5Ytc0CmHQUQkZnMuH2gClVl9dATTZ2Gc1LjaMN9x++0vhuDsUqVUretxMWwLb6EEBsiVhaPFkz1h7lkCvr0kfA0vn3QOPHAzkLEbbB7NVaOIHb+IVb0dGfx4v7dfzUxf1E6LNvuvbFyyP8sfHy7lnCyMYEcZHSYO2ntfG9OV3tJl4BS+Pmmt4SwdBn5LJ4CoG8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWkVI1IHNF2pFoXNP6sI7M5MaLtdg2PPRl5YrQz+CzU=;
 b=wW/3GosEkzQmVhoF+flbeZZ7qv/1JxGkYhGPPOONHodtp90JsHZe2g3At4Xol+wuC3owqNZeUz828bTyuwDvgZ6HqRF1rOp71vBUbzUD7Fb/SxHCfDHDfNuJGYCDZg4aHcr+XKR8aW70Ubgy4OHxFGt2a62bZPNkECe+L+Z3RNCU+Oj/aUsvjT+0aN4SjfiVgvk2Mub3o25Yf9zijqNst05wNkosZWPuRVZIdF+DOhMAj/MZrc9I877HBB5DqGRMGUzMt6hUx0Lvzf8RTRPz1ejljly4x4tEb3l22JPTAqD/D0+p4llZdnhZaC/FZU1lwU69F3LEfvsAk6D0O3udUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWkVI1IHNF2pFoXNP6sI7M5MaLtdg2PPRl5YrQz+CzU=;
 b=iWRUV8jm18Ypm/P+rPpEwu6EjvElVPYvq6wLWVVFGYZ37+b6sum9fktfTdBK/ZBGn2lanOY5R6GGGU85Sm1CydR7LUoz00Thd2HEnH+A1ZDO1C2WbnzQoCBtaBQ5P/BdQmnAVGNZA0IbO2V2g+EHkvN02X/cTHSLDkso9hAmXVXYAu4oLsB4jopPVpIxcTAp4ViMyCgNOVRKPD3UVekkqW4ChAJOhOanDMwBC73V6OnwUaSn4qxxLg6vO1rRg5ahMK9+UBmul6t1I8yQdCUtA7o0jRjPWN2zXpQiEfbEATnv/jEnN1IrvzNCEgZsvWVGc/dxKX4bNFNNB1c5RfcK6A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Fri, 30 Oct 2026 07:54:53 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 07:54:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Oct 2026 16:54:47 +0900
Message-Id: <DMI0EYN8IGGH.2ZYHEC3P49CE@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Dave Airlie via B4 Relay"
 <devnull+airlied.redhat.com@kernel.org>
Cc: <airlied@redhat.com>, "Danilo Krummrich" <dakr@kernel.org>, "David
 Airlie" <airlied@gmail.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH] gpu: nova-core: make pramin/buddy optional
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261026-nova-pramin-option-v1-1-d073b3f047fc@redhat.com>
 <DMHV8ZWTAEVB.YC2XG5BHNBN4@nvidia.com>
In-Reply-To: <DMHV8ZWTAEVB.YC2XG5BHNBN4@nvidia.com>
X-ClientProxiedBy: LO2P265CA0496.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::21) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BL3PR12MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 5065cb12-fd27-44c2-4402-08df365b14f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|10070799003|376014|261026140227099003|10067099003|4143699003|261022075727099003|56012099006|261022105027099003|261021135927099003|11063799006|261028144727099003|261009223027099003|22082099003|261026121527099003|18002099003;
X-Microsoft-Antispam-Message-Info: jUonGXfQqjRg9oCqWzasYOpnAu3DfNe/gZvRqgkKkUhCwGEF/i7fV94gSyhZ+ACRmWQL+sT6EZBqnFyI1GiCExxavEb54iIZqjm47nlkQcCNQsC8wUxGnsa5GZeA/1IVKWbMNFtjc3AvRZLAKz/8FIt0nDSqoE3iS4x8JvYnbaMgckx1OOGLAklHIp9LlI6Iw9JFyIc0UkYbMFs9VsO2UGtH/LRVA8wN6T4mLJFZvnmdP6bbbbq5bfEw+q8kIxnFuOO9DWEhKv6IwBv3DxvBfCtG0dGjNH+ruslWmI2qlV5af/A1cvQx8WMYjyu8iJT/nysmmXWxdcjwQcyr7vc7HEiqn/Nk3U6KZSChAcIfT597cQgY5XNORNZLmclDuXDJHLyo8UCleAdSJ0dnDPxGjyT6aiXhXIB6tXJA1WIqTbbKJ5mfU3fCT1Y1vQ92k8InTPRXdSlJc9Oc/uM0Fby2c+xqD1mAmBxGr2yzyTxItBjTMzzKyG7h8x3fsgcT/kS5YFZ/lmaUzTvLNU8w8U/45XDxKE2yAYVAcnn1QHGwQpfha6hZ9iPlqt9NQSEX+FD8Km1Y0b73588cI+Axk+eKM8mb4WvkiIe1ttoN5UtGQKDPOr7YmHbdnXTd/Np17k0hKF5S5yku/Ubkk5cCM3yAzSpF4sjU1n3Yf/yTftyN8Ys=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(10070799003)(376014)(261026140227099003)(10067099003)(4143699003)(261022075727099003)(56012099006)(261022105027099003)(261021135927099003)(11063799006)(261028144727099003)(261009223027099003)(22082099003)(261026121527099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXYxK1diQUFmRnhZeHdTTW5jRFRHenE4TlNDSWRzSUdKckNPY2dPdjU3YWpj?=
 =?utf-8?B?WWh4M0xVVUlZZ1hMTHRRRkFxWmZBVGRaVkh5ZVVmeENGZmY5Um0zMDVjQitV?=
 =?utf-8?B?Ujd4c3U1WWgwRWo3SVdkNUZvNWFlYnN5VE42WUIxTlF3dXRFMFlwQlRnKzkz?=
 =?utf-8?B?QmdGOFJQRktFTGd2SXQvbFpWYmdYSEJoaUo1Q3BiOHlEd213M0pQYmpWZkxo?=
 =?utf-8?B?SlY4TVZtMC9pVG1IN0FmWFArL092a3p5ajIvWVdpL0I3UnpRUllTNzJTaDdj?=
 =?utf-8?B?WUp1R1F3a2FkbmphTytQWEpqUE1IQkQrMTZmSnZDZTRBMktLUHloRS9DdytM?=
 =?utf-8?B?T3RBNHQzbWhzKzVrckc2RnlOYkpucjZ0NWo0cjlyU3BqTVFCdHYyUWwwSTlG?=
 =?utf-8?B?VlRSZG9BSWMrZjFxWm1BazJzSEF1ZzRiTWJqNlJPa2lDclNMeFVGWFNBK21I?=
 =?utf-8?B?aEFBSURzdWlWdVNlZ0UxUnhBOGhELzZ2TUN3Wmg0NkhpM0NoK2o3K0hnaDNT?=
 =?utf-8?B?aDV6Yi92NktJcm1nN25oUnpkUkVSOUxzdE5GM3B1ZnpFanRpYXlMVUY2dmlr?=
 =?utf-8?B?TTRlbXNiTlFxSGpnMjUwWDhZbVpLclUwYlRTNzk3RGZRSUExV2xkWFRFckl1?=
 =?utf-8?B?UnJXL2gzQnB5ZG0wOFdQNDM2clVicmtpUnBQeE9pQlI3QmhkUS82ZjRFdUVt?=
 =?utf-8?B?VE1IMm01V2FpV1dJRDdhUDAySGRnQi9WOGhzczE4dWJlcy9oY2RMZlN0V05T?=
 =?utf-8?B?S0tvNmdjcnJlZFc0Q3N4L1NCOXE0S1pUYUF5eE9GZzBKQ2YxL0cwZEFXK28w?=
 =?utf-8?B?blVSTUt1RDJTUmRqUXBiT1QxVDRXUFJVQ3cxQjU3UGxIYkt0R3V5ZU5Gby9W?=
 =?utf-8?B?K3h4VFZQWHo3bjVnNTBaYTlyNy9WcitzQ05QSmdLbFRmZzN2a25WTFg0OHUw?=
 =?utf-8?B?UmJTbk4xczRyblJqcGRydWppRk9qVkdTRngwb1BZT09ZeFFVejNHaUFpbWFQ?=
 =?utf-8?B?OTJsQ2hFdXRiVWppZ1pXcEJuSTRRdjdKM2Z6dHhKclBXZ0NyVC81NXlybjdX?=
 =?utf-8?B?OTJuNlZJOGVqc0tWQW9jZUxQb0RqeWhQZHdVWnZvak81RFcyWFR2U05ISGtk?=
 =?utf-8?B?T2hLRmlteHlUU1lmb3lLUE9BWi9zV291bVkySW1leGpHMDFUSGVMREQ5U1M0?=
 =?utf-8?B?b3R5cGtkait2aUlBZ0xFallzZHVuaTFlbTQ1VGVnYWtma2gxK3NuOVV5QUdC?=
 =?utf-8?B?NjhuVTJlSk9vbUg2V0FqZzBZNEtBRnhkYUp5ZHhCRkN5SVY1WDY4alFzU0d0?=
 =?utf-8?B?M1pBMjlIQXVDTDEzaDF6M3dWMERlWWFZVXRxNEU2dlNCNytNc3BzOFRwMTZB?=
 =?utf-8?B?b0UrakxkdHBIYzBnL3E5YnNmc3RGb0FSMEczMVRUZmRobkN2a2VoNXExY0RY?=
 =?utf-8?B?MURSdU9mcFlMamtRdnVqUWxKUS9sV013dTEwWldDWThWZDJiWnBQckM5YU9D?=
 =?utf-8?B?ODRDK1BET0VndTBnSDRiQU9IeUMxWkFrZ0JlMmpDQnJaZVVZNHBXQ0RnUXJO?=
 =?utf-8?B?QkRaY2lNWCt5ajZnVW5qQjJjNmxoV0l1d200ZE4rb2g0RXlvM3g4N3JwQzFL?=
 =?utf-8?B?TEZDb2VzZjY5SWsxS0lqVHd3ZmE2bmhDdlNxRWNDMUx3OEtrNjJQRzlVQVd1?=
 =?utf-8?B?WmdiVkhLS2RvUW9QTGlSUFR4YlJyOW9NT2dSYlJrOUMrb3pseDNBdGh3QW1w?=
 =?utf-8?B?RkNYSzF4b0ZQSFFQMnpOY21vWXZWUUVrdjNMTGZlbjQrczdyV3VjN2xjTkhj?=
 =?utf-8?B?bWhBT1l5TkJ5cjlnZk1SK0ZlM3Fncm90b1JUTUpwZzBpMEpaZ3FqL2ZDaGNw?=
 =?utf-8?B?b2VoRGxMYmlCai9sOVd2OENKZEVvK3MwVG5MK0dXY3h3dnFUdDBUOTB6dkdx?=
 =?utf-8?B?bXYvK0svdWQwZjczSmJzNTRabXhiRVV4SG5nRXlhM0UwYTVzcThJQUlONVpu?=
 =?utf-8?B?SGEzSHFSbFdzWXM5ZnFDQTdZaTVONm1hekplcjNFM1pzei9sZ3F3djJXMkxK?=
 =?utf-8?B?aXNSNXQ4elFxWkZzdS9jWW9xdC9FL3VLVGMwNzdmVG5RaUtndFg5RXBzbUt4?=
 =?utf-8?B?alZZQzJlMXRWMEVEb2lMbGFkNTdQSE5mS2lJVnVobGpNLzhGaVZIV0gvNlVs?=
 =?utf-8?B?TjluZWhsY1h5T29kNkpvYktTNWowZEtuMDgxK2xyem0rSEZvSzM4V1ZlY3Q2?=
 =?utf-8?B?WXBwZnBsQjVXMG1BTFRuQXBJSjFaV3VMR0o3UGZ4TzUyTVRTUHdRMmRGYjhD?=
 =?utf-8?B?T0pHL0k5aDVJbm5GYmJMNDdLamVoaFdYcW4rSUxGZ3NVek02NDAzNVpoa0lN?=
 =?utf-8?Q?2vUxnUBGz3fuZ9t4ZXKAOkzlJMF18avQKIE1XaoTC9oX+?=
X-MS-Exchange-AntiSpam-MessageData-1: pyjyh4vdrWmIvg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5065cb12-fd27-44c2-4402-08df365b14f5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 07:54:53.3159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJIp7CbvZEUUJwGUsS9Ux0QpoSdIeEF05nfV7ZxZ0SVj1n2Ya3CMeb8gb1hK6ujnPuTwJ+a0lMzUuLM7k4mXYg==
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Oct 30, 2026 at 12:51 PM JST, Alexandre Courbot wrote:
[...]
>> @@ -85,28 +85,28 @@ impl<'gpu> GpuMm<'gpu> {
>>      pub(crate) fn new(
>>          bar: Bar0<'gpu>,
>>          chipset: Chipset,
>> -        buddy_params: GpuBuddyParams,
>> -        total_fb_end: VramAddress,
>> +        buddy_params: Option<GpuBuddyParams>,
>> +        total_fb_end: Option<VramAddress>,
>
> This is related to the comment made by Sashiko, but in which cases are
> we expecting `total_fb_end` to be `None` here? Is this the same set of
> systems for which `buddy_params` will be `None`? If so both arguments
> should be merged into a new type to remove the ability to represent
> invalid state where one is `Some` and the other is `None`.

Agree with this here - these both rely on vram existing so nice to group
them.


[...]
>>      ) -> Result {
>>          {
>> -            let pramin =3D mm.pramin_mut();
>> +            let pramin =3D mm.pramin_mut()?;
>> =20
>>              // Drain prepared PT pages, install all pending PDEs.
>>              let mut cursor =3D pt_pages.cursor_front_mut();
>> @@ -255,7 +255,7 @@ pub(super) fn invalidate_ptes(
>>          let invalid_pte =3D M::Pte::invalid();
>> =20
>>          {
>> -            let pramin =3D mm.pramin_mut();
>> +            let pramin =3D mm.pramin_mut()?;
>
> I'll let Eliot comment on this in more depth as I am not very familiar
> with this module, but I'd like to avoid these runtime checks if
> possible. On systems without a framebuffer, we should not even be able
> to call these methods, so I'd like to enforce it at that level.
>
> Ideally, we would consolidate all the state requiring a framebuffer into
> a new type (i.e. my first comment, but pushed further), and put it
> behind a single `Option` that solely tells us whether the system has a
> framebuffer or not. Then methods requiring a framebuffer can be passed a
> reference to that type and work without runtime checking its presence.

I think that we can't just put both pramin and buddy/etc into a single
struct for vram-less systems. For example, for vGPU guest, pramin isn't
available (but we still have physical vram to allocate). We have some
matrix more like:

VRAM: exists(need physical alloc)/doesn't exist(use sysmem)
Pramin: exists(bootstrapping ptes)/exists(not using it)/doesn't exist
CPU->VRAM access: pramin/bar1+bar2/coherent link/no vram

So these things kinda end up having to be handled separately, afaict. We
will still have to manipulate GPU page tables even on systems that have
no vram/framebuffer.

The current method of always using pramin to write page tables needs to
be reworked and abstracted (I'm looking into it), since pramin may not
be available, and the method to write the page tables could be one of a
few things (pramin, bar2, sysmem, copy engine).

Given that this needs to be reworked regardless (e.g. map.rs should not
be using pramin directly) I think this is a reasonable short term
workaround tbh.
