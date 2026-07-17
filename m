Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FCEC4451A
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 05:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C057210F438;
	Fri, 17 Jul 2026 05:53:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cG3v1/VP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 256F610F42F;
 Fri, 17 Jul 2026 05:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784267605; x=1815803605;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=A7mb36UV4itBY6UdDyEOnWplou/d4VmkW8RrvNFzSgQ=;
 b=cG3v1/VPwgQ4u1ndbt4xc9iRGGumGqk2gSxSn3tPUFy/jrz/d+Vqz2wG
 5RgxNwuHEjhYDO1vm0u/kph8Kjky2HRUhDZ+oONR1b4gTJuESQvA7SOwP
 +95VoDsVZNhnL8v/CHCuqmUByjELj6wS6eL27ftidyNcmCtbrCpNxnCwD
 Tf3gXL8wEZzoXaNu4a5WEQGqOKmODIjDWl/ZQiiuf/0HSo8uBGvgsHkto
 hDTOxUa2EtzWV/jx6zsF9moBgMss6EZTzy8y1qnxyB3Biqjrc9Puj91RL
 2wkB+0+oiyQ9O5tOJVeyYwPM5w1mtlx7/dfSeGRKgeVryJ2terUIdU42E A==;
X-CSE-ConnectionGUID: jmWwSHRwT6ySO5WOQkE8hg==
X-CSE-MsgGUID: PLc4SCp4SkelrJ/IAzk1TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="96301474"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; d="scan'208";a="96301474"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 22:53:25 -0700
X-CSE-ConnectionGUID: 2nc675yJR6W+GNzFZBMAVg==
X-CSE-MsgGUID: 87r3F7wYSs24R0agmlB30A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; d="scan'208";a="257328734"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 22:53:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 22:53:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 22:53:24 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.62)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 22:53:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNZe//geQG/C4xRn/qwA5XLK7SeJn1uJX0ThAmumKgfc0cx5CQMvgIl7QMGG+A3MkOHCzJJVoW6hi49b1ZzSBZdMjlnbuCMkErAN1IBzSaDB8X2KGYkJfRxoESpxlrGOf9oSjJ8TRudATkPjtb9FGhxN0RAvk1/tOhrUcqV/sUOZdKIdjL03C/X2l611LV1BtQt/i8YAkiu6IFrfcWkYUstQSXg9T6os3yrgvfpaEryqorGDjaogdMrsMf1MyKHhgmgfJ+9YSQ2jpw3IwT0POhhzmKB72YKuvgbty+3gTSbcVEKetI7oLqjuWOhsMFiLUC9vqo7+WQIQBOTG45xYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLJsfUyIIHXQc63uCzMLAvs7YK0Ho9bIAKJfqzUn7QE=;
 b=uceZ2SvM3JsChmm5D4KKSxFbs+uC2GL7+j9wHks2k6Te0iBo0rtJqHqndkVGiXfzfeJ7C849swBX9fTAKb90P6K7aOdFTLdGLvVq7tfVTB+acRR0mXawE0tlszbgUE6s/3h3Jb9cKK7ffhJcA1HBTZfr8WcyhGaeaospFD214zyAwalczyJjNYpF8w1L0EPc0LWK6Myu7DUjiBv05ikBedVRhSPF64HX1FdQyL5tu5SG3SJp2nkHVKPfznFhSIgZ9jUV/1aEvPMU+zpbukFCTi68X/Oh7eLeN3U4G099J12W/2yhDfY/zaed1lYxRWVHCmV+rloeVeAA+x+RCUruUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::5b) by SABPR11MB9964.namprd11.prod.outlook.com
 (2603:10b6:806:50c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 05:53:15 +0000
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::6d3c:5451:b5d4:3ea6]) by DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::6d3c:5451:b5d4:3ea6%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 05:53:15 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: "Deak, Imre" <imre.deak@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH 1/6] drm/dp_tunnel: Add UHBR tunneling support
Thread-Topic: [PATCH 1/6] drm/dp_tunnel: Add UHBR tunneling support
Thread-Index: AQHdE6Vc+9sgbbshiEWfPDUDCrS5VrZxObEA
Date: Fri, 17 Jul 2026 05:53:14 +0000
Message-ID: <DS4PPFE901A304F254DE0388E7AF5F88425E3C62@DS4PPFE901A304F.namprd11.prod.outlook.com>
References: <20260714152700.555527-1-imre.deak@intel.com>
 <20260714152700.555527-2-imre.deak@intel.com>
In-Reply-To: <20260714152700.555527-2-imre.deak@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFE901A304F:EE_|SABPR11MB9964:EE_
x-ms-office365-filtering-correlation-id: c280338a-15a0-4bb2-fadf-08dee3c7b196
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|10067099003|11063799006|6133799003|18002099003|22082099003|4143699003|56012099006;
x-microsoft-antispam-message-info: Txt6zibSmbRcrpP3HSqAlBhWIdKZ0Sk2G30xUF9xK3o3WWGKjs26VGS3xr4irEuQvXObAlsvrcWzWmZQdhSTsGROM4TdBLD5Vv5VCrsUcv66FsnR105CxAu9SrnKqCwE/jlPPruTL3N3XYLSEI8u+F3hik0yqIkjY+VUbtrgArfm2hZSjCxt8yVqlJek+oZm/OfHLxOUEwGfxaIJ0dAQolo68/4asW1xTzR27KDueWyxSU38QIUUHr9fx/KKSCtQ8Aa57Q7E11DUsESVK0cieRao/gX6y7Ix1xM/SVgS3imIDeJZnmb7el/PM6cOyYZXushGqNIIxL3qjKjL7Ixl2ks7DhdtTM2dLlrerawpgTe3XM+RWgWt7L1wALzKXs7j9WfKoJdaZAl//SFpPVouBxPZ5BGi9eJYP5K3KZDHULTVMFAWxx7GVfFEZcb4DpuiNIETASVBjbyCX/VqJbdm9QrSCDTSXaBPSJ6OMU4kroraSUgqnuMO6ojE9X+qDqZp4MNKztOG4ertTitNNgkhesim3AGJEePAl1s0YDsPs9PC69ZOVmFuMDzejxP1DYJqKtPuQ+lTH7dobs2Thw/i8xEQG91qPWMj6Ey65Rm+2e+PGwx7wDM8r6UmMDCv5SwBtdxKjI7fD+2ltklCWr9M1fEPYrss7QYFxriiz3jIsVzuXlEbANFZeNZ4sYLzXn37CLk2o0+XS7pA4ztfBQ4LbSLLUFAID4b0fX/h9WA5lh8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPFE901A304F.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nXKBd+nqKv4y27KyCKH6bbWjTrSlhrQcMS0j6qnv2LlIRnr4FTDwmbITFeZj?=
 =?us-ascii?Q?Ms8jkV9ByRADSfjlqAap/18E6ZmT4CZPUMaFXViP1bWJLAUvXIaz4wGH986J?=
 =?us-ascii?Q?ZBEGYwRSCy8qU8lPOvz77cvuKV3RpUD5VxdBK5cR9/YQ1PSk1DLtpN9346uQ?=
 =?us-ascii?Q?plZb6cEBpQSKJ7CFElU/p6IJWzWNQe9Afhrt6vE17Eu7pNI5toxaXaVOjIzk?=
 =?us-ascii?Q?OdWUa70kvJm/3Wy5BnvpiMg2SEe42bEBcvi5R0832/cYcFECM/1HH3KMv+cO?=
 =?us-ascii?Q?GERcrB/KkCC8FWk7D0vO4frFJQypsoDYy5674RdX0r1i1jkGBopqzOnUR4aE?=
 =?us-ascii?Q?PAijEA4jUNudd86ry5RTzfXfkqCfGCUVXI03XmDnUCnIvA08ez4zUl/6xvos?=
 =?us-ascii?Q?PxJLPeoJrNjjpLel4YttAMwboZQZ0Ao8VBvOa0ZCWQYNEwBKqPqJcllMFngN?=
 =?us-ascii?Q?q67Nv9tqZ7F4PCZnCNC7z+F6Ix2KYioylzRk8GBYEN6rDnhUYVeXN1VqIrcm?=
 =?us-ascii?Q?rCYVXnrXjfCBqbUeO8Vj9UFxSlbMQ079+k8yE+tpkfV0RuobP50sTnnbdg+H?=
 =?us-ascii?Q?BAHGVdkhoklZW0qjbF0W2BopEj0sfm4heHiYSpO4tecII2guEQk8VCxn5OJZ?=
 =?us-ascii?Q?4iHjEw5rYzdLaRuPuRx4Bw5jn0+IG2RAIXSJvQk/gAbdRATtrDipCG2Au/Z0?=
 =?us-ascii?Q?pwFGhXGYf6AxiAXA9+FUWJzY6XzDYd4fP8VGJSp567iHMMtVgeu7PadIbtSX?=
 =?us-ascii?Q?LxWALY2bnVaOlrCgzcyeIViqdoUy5ocCySE6QCEqsARP9Hid9odybEiVH9l1?=
 =?us-ascii?Q?lRm+pUUUjCCcRRmSf6yCgSmrdT6Ptoy5FIu0m5/yuyj65l24vWiS7h5zKzLt?=
 =?us-ascii?Q?j5wdwwhVtK6nr53tw69hZQ/+3y6AuN01ifZWU9Ri4IfptAhbarI9SJlctGoN?=
 =?us-ascii?Q?IzIi4C0NA7ujwDM6jKSN3LL+3bCogap+eyza9ZHXc9vE2MRVxJmsmAF+GC+4?=
 =?us-ascii?Q?BBPY1Mdp/1YXLUAP/DMUhQZhXm2GLIpi05kPML9Bq0wsB1gE/zQWDXHVTwNJ?=
 =?us-ascii?Q?Gas2cR6cQ1wcuMPzr9uONJv+ijjcwuLulGCPaB/Bv7XH6eI3RZxAmAR2PAeK?=
 =?us-ascii?Q?oS41p61MpcAGooLTaS24KJZ4IaiZkk1j3Ibhemz2nCuHKABbBelATnDykhkk?=
 =?us-ascii?Q?pqQgFXyhGQAv+mYRkpU/T+VWzF9pF0esMVcALj3OZv65g35dFuUGr1Dj2wIs?=
 =?us-ascii?Q?XwQr0HITI3PeqNOMh1pYlwjEbD7DGHRaX1akoxWEPE2OwDD9Y3/98OkFGmYO?=
 =?us-ascii?Q?yuinx3+XsSrisph0bkS+1LQ+J3Sdlyqvwf9nHkCw81CCfCZsHRsq2IbDnVPR?=
 =?us-ascii?Q?lNNivL7RW7WgEWbUJTv7DM4Ke9iKfLFPHE5DVF8/A9GI+rO0kDA9hRWhjdvq?=
 =?us-ascii?Q?z6GMMPWHctHJLjdgTfhui/WjYcF/P60dW9YXQkeKNYGX3vu1c5/C1t8R1wTg?=
 =?us-ascii?Q?1JmsNlw+5YRBVfIO2VDhGq2OhCdSgIyjEvHYNnw00iqPrLTENin/8gB6BzbY?=
 =?us-ascii?Q?XVWmayOagtihRMGb2g0CXo9Y6QOQRSm0qtJ0CPYimIm5u4ufhjstkKsnjvsf?=
 =?us-ascii?Q?R9rAt3G/2G5Hc8ufqFT1EnmP9GmXL0mN8Q7KtKDYqWN7B08g9gnkavGtoLj/?=
 =?us-ascii?Q?7pQ+GemNBXBRgg1xnlbT3f8gwqpdoRBzKf8xUN4XRrmzhc/SxN3x+BeFGOWv?=
 =?us-ascii?Q?oVTAeOMV6Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LJdAraf8Ap/lYMva6P/zE77Zqe5p7AnaYWhHN7dTfrJbrygxpv5eKmMBKUoSNYG98f7+QvRPu6qN48copgN67Z0FYWWXhk1eI0Ukt7ixgSqo8GK8OarMEP5o4Ntz8RaFPo/MCMto4WNvm2t+1A+3QzxSsvxLAUAZNspso2BC67czIZPqPl3LoHQD9oM8y6tqdBeBFDIiF2MwblkyejFI6Pn0pAJZz79FVrWnyOeP0/hEH+j3okn5d9LaF378laZqk7v+7LsUWL+xLdA+FGOknhX0x0Y6+NXMswMPqHRCrvo6+0FeLbHEju6CUStCf5Zs1kOm9QyuGVKhFt4bI45z8Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE901A304F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c280338a-15a0-4bb2-fadf-08dee3c7b196
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 05:53:15.0247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A5iQ8yzc2xIoSofh8pfOdCjhvv2PMP5chP1382Xhu9pzAyXwauDJfTV57/7Kn5yEGNIpt91Hrn3A347yz6ge/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR11MB9964
X-OriginatorOrg: intel.com
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

> Subject: [PATCH 1/6] drm/dp_tunnel: Add UHBR tunneling support
>=20
> Add the DPCD registers and detection required to support UHBR link rates =
over
> Thunderbolt tunnels.
>=20
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Imre Deak <imre.deak@intel.com>

LGTM,
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>

> ---
>  drivers/gpu/drm/display/drm_dp_tunnel.c | 116 +++++++++++++++++++++++-
>  include/drm/display/drm_dp.h            |  12 +++
>  include/drm/display/drm_dp_tunnel.h     |  21 +++++
>  3 files changed, 148 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_dp_tunnel.c
> b/drivers/gpu/drm/display/drm_dp_tunnel.c
> index 76c6bc84a806f..d29ad4116e641 100644
> --- a/drivers/gpu/drm/display/drm_dp_tunnel.c
> +++ b/drivers/gpu/drm/display/drm_dp_tunnel.c
> @@ -111,6 +111,8 @@
>  	DPTUN_REG(DP_ALLOCATED_BW) | \
>  	DPTUN_REG(DP_TUNNELING_MAX_LINK_RATE) | \
>  	DPTUN_REG(DP_TUNNELING_MAX_LANE_COUNT) | \
> +	DPTUN_REG(DP_TUNNELING_MAIN_LINK_CHANNEL_CODING) | \
> +	DPTUN_REG(DP_TUNNELING_128B132B_LINK_RATE) | \
>  	DPTUN_REG(DP_DPTX_BW_ALLOCATION_MODE_CONTROL))
>=20
>  static const DECLARE_BITMAP(dptun_info_regs, 64) =3D { @@ -140,11 +142,1=
4
> @@ struct drm_dp_tunnel {
>  	int estimated_bw;
>  	int allocated_bw;
>=20
> +	u8 dprx_128b132b_rates;
>  	int max_dprx_rate;
>  	u8 max_dprx_lane_count;
>=20
>  	u8 adapter_id;
>=20
> +	bool dprx_128b132b_support:1;
> +	bool dprx_128b132b_lane0_mapping_support:1;
>  	bool bw_alloc_supported:1;
>  	bool bw_alloc_enabled:1;
>  	bool has_io_error:1;
> @@ -260,9 +265,46 @@ static int tunnel_reg_bw_granularity(const struct
> drm_dp_tunnel_regs *regs)
>  	return (250000 << gr) / 8;
>  }
>=20
> +static bool tunnel_reg_dprx_128b132b_support(const struct
> +drm_dp_tunnel_regs *regs) {
> +	return tunnel_reg(regs,
> DP_TUNNELING_MAIN_LINK_CHANNEL_CODING) &
> +DP_128B132B_DP_SUPPORTED; }
> +
> +static bool tunnel_reg_dprx_128b132b_lane0_mapping_support(const struct
> +drm_dp_tunnel_regs *regs) {
> +	return tunnel_reg(regs, DP_TUNNELING_128B132B_LINK_RATE) &
> +	       DP_TUNNELING_128B132B_LL_LANE0_MAPPING_SUPPORT;
> +}
> +
> +static u8 tunnel_reg_dprx_128b132b_rates(const struct
> +drm_dp_tunnel_regs *regs) {
> +	if (!tunnel_reg_dprx_128b132b_support(regs))
> +		return 0;
> +
> +	return tunnel_reg(regs, DP_TUNNELING_128B132B_LINK_RATE) &
> +	       DP_TUNNELING_128B132B_LINK_RATE_MASK;
> +}
> +
> +static u8 max_128b132b_rate(u8 rates)
> +{
> +	if (rates & DP_TUNNELING_20GBPS_PER_LANE_SUPPORT)
> +		return DP_TUNNELING_20GBPS_PER_LANE_SUPPORT;
> +	else if (rates & DP_TUNNELING_13_5GBPS_PER_LANE_SUPPORT)
> +		return DP_TUNNELING_13_5GBPS_PER_LANE_SUPPORT;
> +	else if (rates & DP_TUNNELING_10GBPS_PER_LANE_SUPPORT)
> +		return DP_TUNNELING_10GBPS_PER_LANE_SUPPORT;
> +
> +	WARN_ON(rates);
> +
> +	return 0;
> +}
> +
>  static int tunnel_reg_max_dprx_rate(const struct drm_dp_tunnel_regs *reg=
s)  {
> -	u8 bw_code =3D tunnel_reg(regs, DP_TUNNELING_MAX_LINK_RATE);
> +	u8 bw_code =3D
> max_128b132b_rate(tunnel_reg_dprx_128b132b_rates(regs));
> +
> +	if (!bw_code)
> +		bw_code =3D tunnel_reg(regs,
> DP_TUNNELING_MAX_LINK_RATE);
>=20
>  	return drm_dp_bw_code_to_link_rate(bw_code);
>  }
> @@ -706,6 +748,23 @@ static bool update_dprx_caps(struct drm_dp_tunnel
> *tunnel, const struct drm_dp_t  {
>  	bool changed =3D false;
>=20
> +	if (tunnel_reg_dprx_128b132b_support(regs) !=3D tunnel-
> >dprx_128b132b_support) {
> +		tunnel->dprx_128b132b_support =3D
> tunnel_reg_dprx_128b132b_support(regs);
> +		changed =3D true;
> +	}
> +
> +	if (tunnel_reg_dprx_128b132b_lane0_mapping_support(regs) !=3D
> +	    tunnel->dprx_128b132b_lane0_mapping_support) {
> +		tunnel->dprx_128b132b_lane0_mapping_support =3D
> +
> 	tunnel_reg_dprx_128b132b_lane0_mapping_support(regs);
> +		changed =3D true;
> +	}
> +
> +	if (tunnel_reg_dprx_128b132b_rates(regs) !=3D tunnel-
> >dprx_128b132b_rates) {
> +		tunnel->dprx_128b132b_rates =3D
> tunnel_reg_dprx_128b132b_rates(regs);
> +		changed =3D true;
> +	}
> +
>  	if (tunnel_reg_max_dprx_rate(regs) !=3D tunnel->max_dprx_rate) {
>  		tunnel->max_dprx_rate =3D tunnel_reg_max_dprx_rate(regs);
>  		changed =3D true;
> @@ -1331,6 +1390,61 @@ int drm_dp_tunnel_handle_irq(struct
> drm_dp_tunnel_mgr *mgr, struct drm_dp_aux *a  }
> EXPORT_SYMBOL(drm_dp_tunnel_handle_irq);
>=20
> +/**
> + * drm_dp_tunnel_128b132b_supported - Query if 128b132b is supported by
> +the tunnel's DPRX
> + * @tunnel: Tunnel object
> + *
> + * The function is used to query if 128b132b is supported by the DPRX
> +connected
> + * to @tunnel.
> + *
> + * Returns %true if 128b132b is supported by the DPRX.
> + */
> +bool drm_dp_tunnel_128b132b_supported(const struct drm_dp_tunnel
> +*tunnel) {
> +	return tunnel->dprx_128b132b_support;
> +}
> +EXPORT_SYMBOL(drm_dp_tunnel_128b132b_supported);
> +
> +/**
> + * drm_dp_tunnel_128b132b_lane0_mapping_supported - Check 128b/132b
> +lane 0 mapping support
> + * @tunnel: Tunnel object
> + *
> + * Check whether the DP-out adapter always maps lane 0 as expected by
> +the
> + * DPRX on a tunneled 128b/132b link. If the function returns %true,
> +one- and
> + * two-lane configurations with UHBR link rates can always be used. If
> +it
> + * returns %false, using one or two lanes with UHBR link rates may
> +cause a
> + * lane-count conversion failure in the DPRX, requiring corrective
> +action by
> + * the source during link training. See DP Standard v2.1b, section
> + * 3.5.2.16.3, 128b/132b DPRX Lane Count Conversion Failure Indication
> +and
> + * Corrective Action.
> + *
> + * A four-lane configuration can always be used, provided that the DPRX
> + * supports it, regardless of the function's return value.
> + *
> + * Returns %true if the DP-out adapter supports the 128b/132b lane 0
> mapping.
> + */
> +bool drm_dp_tunnel_128b132b_lane0_mapping_supported(const struct
> +drm_dp_tunnel *tunnel) {
> +	return tunnel->dprx_128b132b_lane0_mapping_support;
> +}
> +EXPORT_SYMBOL(drm_dp_tunnel_128b132b_lane0_mapping_supported);
> +
> +/**
> + * drm_dp_tunnel_128b132b_dprx_rates - Query the supported 128b132b
> +rates of the tunnel's DPRX
> + * @tunnel: Tunnel object
> + *
> + * The function is used to query the supported 128b132b rates of the
> +DPRX connected
> + * to @tunnel. Note that the related DP_128B132B_SUPPROTED_LINK_RATES
> +DPCD
> + * register will indicate no supported 128B132B rates for a tunneled DPR=
X.
> + *
> + * Returns the mask of supported 128b132b rates.
> + */
> +u8 drm_dp_tunnel_128b132b_dprx_rates(const struct drm_dp_tunnel
> +*tunnel) {
> +	return tunnel->dprx_128b132b_rates;
> +}
> +EXPORT_SYMBOL(drm_dp_tunnel_128b132b_dprx_rates);
> +
>  /**
>   * drm_dp_tunnel_max_dprx_rate - Query the maximum rate of the tunnel's
> DPRX
>   * @tunnel: Tunnel object
> diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
> index 7154216e0aff9..8b0ca36083dd1 100644
> --- a/include/drm/display/drm_dp.h
> +++ b/include/drm/display/drm_dp.h
> @@ -1506,6 +1506,18 @@
>  #define DP_TUNNELING_MAX_LANE_COUNT			0xe0029
>  #define  DP_TUNNELING_MAX_LANE_COUNT_MASK		0x1f
>=20
> +#define DP_TUNNELING_MAIN_LINK_CHANNEL_CODING
> 	0xe002b
> +#define  DP_128B132B_DP_SUPPORTED			(1 << 0)
> +
> +#define DP_TUNNELING_128B132B_LINK_RATE			0xe002c
> +#define  DP_TUNNELING_13_5GBPS_PER_LANE_SUPPORT		(1 <<
> 2)
> +#define  DP_TUNNELING_20GBPS_PER_LANE_SUPPORT		(1 <<
> 1)
> +#define  DP_TUNNELING_10GBPS_PER_LANE_SUPPORT		(1 <<
> 0)
> +#define  DP_TUNNELING_128B132B_LINK_RATE_MASK
> 	(DP_TUNNELING_10GBPS_PER_LANE_SUPPORT | \
> +
> DP_TUNNELING_13_5GBPS_PER_LANE_SUPPORT | \
> +
> DP_TUNNELING_20GBPS_PER_LANE_SUPPORT)
> +#define  DP_TUNNELING_128B132B_LL_LANE0_MAPPING_SUPPORT	(1 <<
> 7)
> +
>  #define DP_DPTX_BW_ALLOCATION_MODE_CONTROL		0xe0030
>  #define  DP_DISPLAY_DRIVER_BW_ALLOCATION_MODE_ENABLE	(1 <<
> 7)
>  #define  DP_UNMASK_BW_ALLOCATION_IRQ			(1 << 6)
> diff --git a/include/drm/display/drm_dp_tunnel.h
> b/include/drm/display/drm_dp_tunnel.h
> index 57f5e90ba8fda..b5e665560a47e 100644
> --- a/include/drm/display/drm_dp_tunnel.h
> +++ b/include/drm/display/drm_dp_tunnel.h
> @@ -63,6 +63,9 @@ void drm_dp_tunnel_set_io_error(struct drm_dp_tunnel
> *tunnel);  int drm_dp_tunnel_handle_irq(struct drm_dp_tunnel_mgr *mgr,
>  			     struct drm_dp_aux *aux);
>=20
> +bool drm_dp_tunnel_128b132b_supported(const struct drm_dp_tunnel
> +*tunnel); bool drm_dp_tunnel_128b132b_lane0_mapping_supported(const
> +struct drm_dp_tunnel *tunnel);
> +u8 drm_dp_tunnel_128b132b_dprx_rates(const struct drm_dp_tunnel
> +*tunnel);
>  int drm_dp_tunnel_max_dprx_rate(const struct drm_dp_tunnel *tunnel);  in=
t
> drm_dp_tunnel_max_dprx_lane_count(const struct drm_dp_tunnel *tunnel);
> int drm_dp_tunnel_available_bw(const struct drm_dp_tunnel *tunnel); @@ -
> 173,6 +176,24 @@ drm_dp_tunnel_handle_irq(struct drm_dp_tunnel_mgr
> *mgr,
>  	return -EOPNOTSUPP;
>  }
>=20
> +static inline bool
> +drm_dp_tunnel_128b132b_supported(const struct drm_dp_tunnel *tunnel) {
> +	return false;
> +}
> +
> +static inline bool
> +drm_dp_tunnel_128b132b_lane0_mapping_supported(const struct
> +drm_dp_tunnel *tunnel) {
> +	return false;
> +}
> +
> +static inline u8
> +drm_dp_tunnel_128b132b_dprx_rates(const struct drm_dp_tunnel *tunnel)
> {
> +	return 0;
> +}
> +
>  static inline int
>  drm_dp_tunnel_max_dprx_rate(const struct drm_dp_tunnel *tunnel)  {
> --
> 2.49.1

