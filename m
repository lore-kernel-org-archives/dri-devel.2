Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A232A109E54B
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 05:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 078B410E299;
	Thu, 26 Mar 2026 05:45:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mpgKxhWj";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E0210E253;
 Thu, 26 Mar 2026 05:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774503941; x=1806039941;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9rX2DI+PiJoX/fvM7T/lsYSSq7xJuuqC+Ap9Uh/V1d4=;
 b=mpgKxhWj27ub9FFpK3e1PD4z2p0mq+7BhAsEFgCrWfWfFj+hPiESSMwL
 0/0u4h0zkQwseDwa1sZmFgmc7Tka9W+raw+Cg51nLJrAlEpej7NddHAmd
 FkzYtE1yuYg46Jma8pcOcyWTU5DbZpQxDCY/166xfWttfkvjB3LviJF3J
 oK2ZsWyZyd5VKJOSmWi++3IhOKDVh92L/TP1n589Bk1Vy3zrO5KIkcvfM
 yCgOCCrU4x0AK+ARlNC/SP7WS5CfPwMtK/VqmjR+TD6NB15dk6Pqd0AyE
 PDtK3znjF/E1ROi50iXgvKCHUguOlDv3Icudq7Mugt5IzPCcDJ4H6bL4X A==;
X-CSE-ConnectionGUID: XcETj8oJQ5meJfTaqhFGIQ==
X-CSE-MsgGUID: upVsQmmeSF+/J3I2Jxa/xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75574140"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="75574140"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 22:45:40 -0700
X-CSE-ConnectionGUID: gVjC0TSeR/OAsGs/Ut0vJw==
X-CSE-MsgGUID: V2Apn2bLSFyry+cDTG4fug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="228971369"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 22:45:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 22:45:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 22:45:39 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.17) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 22:45:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqO++7SiV/nZdc4b/KxZxsXfdv2d6F1wxpPhxyUsu/Ox9UET+l+YsqECaLXUQiGX7Boed0AXdenoXmPaNnd5Mxvw9z5enS60J9b3bCyrabQxKJFZWVl3xOSlWxh27+XVfTXzFtKVYpPt3QdHYxaW2UHPVMyxvm3kgRcJE61LuqWQr+iaZ/V/iO4w3NHikhLCtaMkMkHwvlCtNS+71/oJRmZiLgmBXed1BVRFogvMDJmAb+n+wNdHFXpO4CH+ZU/+7hfpDGsCGk6rWQTCIEaeI6whKymNq6E2SOi/+18XioHkNUM+HgirxaWLza7nsZDvoAR103sGq/fYfGNYakpA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1MXti2FT1Jypp0hQIdfUqV921C6juX22zCHerxlR1k=;
 b=eYtHikznOy+Q5CSldObDPnj4j2ThWc99Zn9hJgNJybYgNs0nkut4uzD/BjdIXs91LC7B4Y2bLVvpjTQqk7Jn3UH44Km2fHFUQi1WPnuYTbXLH0k43tF7gJte8MTyQ6c0MNJqQtMkATg87JQRIoI1qHsVqQ3meZ7lLXyE+BVD0sP8eqmOIsTc1VSj+JKvwQ39brBQqeavSiDVZbP4uHc00H3LG44wdJXhqMza4edEwSZbtbseDy0uBRCtwfA/q9ss0sb73X3L3nQ6zJyIu/bWeq8fKNo34RHme0XodLRJbyDbpFpUfdfBUgkUMgz9DQlkP7DxwrGoM4VhSBZmG/TPVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6266.namprd11.prod.outlook.com (2603:10b6:208:3e6::12)
 by PH7PR11MB8036.namprd11.prod.outlook.com (2603:10b6:510:248::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 05:45:31 +0000
Received: from IA1PR11MB6266.namprd11.prod.outlook.com
 ([fe80::eda2:e570:4314:8720]) by IA1PR11MB6266.namprd11.prod.outlook.com
 ([fe80::eda2:e570:4314:8720%5]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 05:45:30 +0000
From: "Bhadane, Dnyaneshwar" <dnyaneshwar.bhadane@intel.com>
To: "Brost, Matthew" <matthew.brost@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [RFC PATCH 04/12] drm/xe: Issue GGTT invalidation under lock in
 ggtt_node_remove
Thread-Topic: [RFC PATCH 04/12] drm/xe: Issue GGTT invalidation under lock in
 ggtt_node_remove
Thread-Index: AQHctP5r8oaFZR8cG0OebUJI8K0sk7XAV3gw
Date: Thu, 26 Mar 2026 05:45:29 +0000
Message-ID: <IA1PR11MB6266D442CA9E6249174C9428E256A@IA1PR11MB6266.namprd11.prod.outlook.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-5-matthew.brost@intel.com>
In-Reply-To: <20260316043255.226352-5-matthew.brost@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6266:EE_|PH7PR11MB8036:EE_
x-ms-office365-filtering-correlation-id: 00d0ea1d-3292-43ae-bc37-08de8afae42c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: O2guKan/5AC38X1L/Uarbv8BFxTtfolV0QvvGFzIANlzeI5WX5cCvwhM2xOUpyvZr97Owj/BOyV24iGuiAzbFXrLf0syHZn5itkHBkEA5RQQvqcdSoRAW3EK2Zp1xmO8c9CA5qGvPqkVnv1Ph4/f/0E4p+yWliWwOT0YkF99yiSyUjyQIzdeJna1qBtxo3EIuz/RmLWnfIxiRqyadTeGFdR5yMGd/ZrayIFb+w3YffFHAREFJMiqJhjm5iu/99KyYSiEZsI3e/qEOrAr72orTwFKjPnHT9OC5MuV/+4AftOLDqmbLXRdJSnXcN0outcXT4WnfluWDpsvKmoIiRhKQuvKnPFqlRixcxNrxmspU1AxzQaPBfFFDh9TrgeMVREiqIPiLeCh1FTDKAMrt0uP7vcnzhZln0eQk8Ii8u1fGFH+AjKgJnhtvdxRPxnvCDPCqXb0nFQPZ3NSMsUioN7Ysxh6tI0+2r60X/IFF2dQ5kF7zhP0Uh9KHrfcAfmcQejpgKRbOjFe0NbT0cPZEi5SlXkcdoQuhrr5EfsDHi+/CCrIHbjFj/DkosJz9iy/FGGNnBD9WnCdmzaSf/coNhHJvvJj2/eQxRX/oTXftwJiXdRPE0VCDL4soDkRyr0G/2Nb/S4DITGWUcKt3lCPxRXv06VYwRYIz7m1SxLmIxB7yIZ5hV2DEw1mrpb8X967FXdW/qjzL+tHAkt/M7ewDLrY6RSZP5bCbpZJAwCzJwJMlgKi6iPGmqSnRXtFafTh0fNX+/1FSHwfYz2ab7H++JoykLmVPbhGco9t7yeisyobqG8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6266.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P36cdy0KX/TkVEt6Ra5TBn5W8zJudEGTiy0rTHujRG2Q2O4Nra4Y1L0jbi9z?=
 =?us-ascii?Q?D6PhV8xG2pjTkDZwd50ePIur64lWxDFoouCpP8AStsMHJP6SIDY88RmvD5ya?=
 =?us-ascii?Q?NCIEQRSw5i2bcoIjAE94amWLzGojzcYGGIOrc2W3WBefcafZPZUep5xuY6L3?=
 =?us-ascii?Q?2j7Dyx9puPGQcoUn7hEn4fkXg0KY6L+IZt8EC+p6Eews7HLNzGutF2UD4C+o?=
 =?us-ascii?Q?ab8LY0VBKxl56cnsWe2Ee1Og7Ose82AX0VM3TvrXPlJP9rWpuu0AkfQ/SU31?=
 =?us-ascii?Q?tPKSVyrSl8DpEZx3CwrSTwoZURfFbAofkdFCyTZ827lHnXtIyqhBfL0+d5H4?=
 =?us-ascii?Q?O76CIN2P3ZiKJHpqf7bIZPiHzrIeAnYU4K0+fwFl8itq1EVqQ8q1NS2/6ReA?=
 =?us-ascii?Q?mECsZzP+ChWNK8aq41HGQa7Z2bZuegR5nraCfBFIeyltIs/JG9SUlYJMkMbB?=
 =?us-ascii?Q?51O08ANd9uKvMz37GJJmB/54NNcAD1LuaNywk4VdSrrhw2wYmyTxUtG3xMkm?=
 =?us-ascii?Q?KRF7cd08DxJ+sywnNRaJ4Hz5jIvIjRkTI81QAwQYXOdQXf6S1SJ/iUqYg8kn?=
 =?us-ascii?Q?0tdJwF8D6BI0E36g9fIuGOENioYPIaevse9tjzvrAqSjqLuWQBQfik6Ccmtx?=
 =?us-ascii?Q?Gm8w06k1Z3F4SDsXIHcgUZtRpxuQsLMhZT4Xv+cZOJvAp+NHGGNSwg7PiW+y?=
 =?us-ascii?Q?I77sKe2DjZXrRPvYAsbnpMrowCyhL2VOKk2nXEfLsWap2oNR+tJMTQzlEgBw?=
 =?us-ascii?Q?Vw1b+Mu9IqKaF7zambIMUYdNHk9lvx2RNmE1mOnUuJvf/1RObysbKVkQnH6b?=
 =?us-ascii?Q?dVwgWIru2lQ4laV3QBlmjW7hULhAqy8nW/BKjgA0cg5SO7DRvLhZSvXoSj2V?=
 =?us-ascii?Q?PC5wTSMEOcBKYl4MKMizepcuZo/k5RKaP/cUhL6lv4+FkLiD3XqGLdprn91B?=
 =?us-ascii?Q?ItuUIQ3Uvcn1Uy42zr89WzOFTt74Bu2fMo1K1ebxvxXGRH/D4ui76G2kg6HM?=
 =?us-ascii?Q?cgUASiDxcKGJU43t5rlTXA4WIKFtqjuaZ7/e6CtwIFNFgH/ns8Shz1EY9gEe?=
 =?us-ascii?Q?28X4AWUqraf7WoPHEyf59hiqenK24YC9GLuB1UwvV4guEk25kyvJt+Z+Tth9?=
 =?us-ascii?Q?n3uqTuBmYOhMh729Gr9SYj6EPV1DrmWupqG7wjM/YWHrovwwn6pP0JxGXPEq?=
 =?us-ascii?Q?l/DDz8G0WQFMuj/xUVlm5szuro0SPse5iN7wqtRacF1w2Wk7fG2EywKwDNg1?=
 =?us-ascii?Q?oHjX6qRRh6ngDUtgzG2ECAv2XieSIlrLL0DzIMMBxtX8e+C5H2qQr02subAN?=
 =?us-ascii?Q?lO7ghFjTQS37vImoxrNfNH2lygSZW6LfMWb3FuXw3ZjPmj2a30ue/geB2bhp?=
 =?us-ascii?Q?veFRAj/J7zvDWaD6DO5ghKpWJ18lHtHmxMwSebAWsL1B1EqpEfa7cCp7PcBS?=
 =?us-ascii?Q?9ost6MdbUERg3a8j5lsBjLnTOi8P+JCMACKf9kbAvGuVQZ7iUuxMPXqk84XY?=
 =?us-ascii?Q?JZH/9CEmv40MKp7wvEYuZErUpHorNTA/8+VNscpoh9mf1Z7gPuy4r30C+qmd?=
 =?us-ascii?Q?EIwl28bKxdECuAP1Kmo9sLHnJI7Iz1vTfqm7VcKrRdXrhrxqahgulcZSezIS?=
 =?us-ascii?Q?WFnGlrqtBMUQXzOl4U0vsyZ9/9dx0xiMJT4fITY1p12ckx7HDVcVxBk4ZqxM?=
 =?us-ascii?Q?330h+2lWIeJ4eiFRdHQn8LZO7C/TVFsvRvMiOkDz3AjOiFbZKkL8g/SpIiBq?=
 =?us-ascii?Q?Np9LMB8Wxg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HE7rUlei9zdVi4cxQ6fivb80O3BMQs1Fxksp1kqpO+V2To2oMJepSKCB1bqt9Bknc1r2NqBiKBFTI40wCeEAl+1wHrSZKqEVVN3iVJiGzaSO5l4Nf4pYG6s1/bM/1QgLv5RzqoQVHRWAByTYvazrf9MoHTUD/uqBm/yDtkIg58UGegvmGfc9PIYgo2bAEADKgUIit0O2JQse+PvBqQn5muMdlGI1DDoC/nxEEo8XkyX3XzuzkHV9a+ftBVSx8YduSaTd1WMckE7Gjbe/adwXEWKfYdXlQIgsMN2U+HLWyE9MMvh6ZpBHJpxMJUMZjQ8DYBCO6/Cs+H025s338NxtUg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6266.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d0ea1d-3292-43ae-bc37-08de8afae42c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 05:45:29.6603 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XQfXoMM3DRI8ztq9876gwrejov6by8Jlzsxb/u7X7Jp7bg+bRIUmRQYdr7mn/ckNVwE/3x7NIyG2UaX+/F7/wd8ew/NhAdoJDRvbTpKG4Uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8036
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



> -----Original Message-----
> From: Intel-xe <intel-xe-bounces@lists.freedesktop.org> On Behalf Of
> Matthew Brost
> Sent: Monday, March 16, 2026 10:03 AM
> To: intel-xe@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Subject: [RFC PATCH 04/12] drm/xe: Issue GGTT invalidation under lock in
> ggtt_node_remove
>=20
> Async work (e.g., GuC queue teardowns) can call ggtt_node_remove, so the
> operation must be performed under the GGTT lock to ensure the GGTT online
> check remains stable. GGTT insertion and removal are heavyweight operatio=
ns
> (e.g., queue create/destroy), so the additional serialization cost is neg=
ligible
> compared to ensuring correctness.
>=20
> Fixes: 4f3a998a173b ("drm/xe: Open-code GGTT MMIO access protection")
> Signed-by: Matthew Brost <matthew.brost@intel.com>

HI, please take care of nitpick here "Signed-off-by" before merging.

> ---
>  drivers/gpu/drm/xe/xe_ggtt.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
> index 017f679ba13f..353b324f7301 100644
> --- a/drivers/gpu/drm/xe/xe_ggtt.c
> +++ b/drivers/gpu/drm/xe/xe_ggtt.c
> @@ -482,15 +482,10 @@ static void ggtt_node_remove(struct xe_ggtt_node
> *node)
>  		xe_ggtt_clear(ggtt, xe_ggtt_node_addr(node),
> xe_ggtt_node_size(node));
>  	drm_mm_remove_node(&node->base);
>  	node->base.size =3D 0;
> -	mutex_unlock(&ggtt->lock);
> -
> -	if (!bound)
> -		goto free_node;
> -
> -	if (node->invalidate_on_remove)
> +	if (bound && node->invalidate_on_remove)
>  		xe_ggtt_invalidate(ggtt);
> +	mutex_unlock(&ggtt->lock);

Looks good to me,

Reviewed-by: Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>

Dnyaneshwar
>=20
> -free_node:
>  	ggtt_node_fini(node);
>  }
>=20
> --
> 2.34.1

