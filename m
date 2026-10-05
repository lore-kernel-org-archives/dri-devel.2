Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFB4CA5FFE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 17:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A87B10E3F6;
	Mon,  5 Oct 2026 17:33:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UKi8W6Mc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6627010E3F6;
 Mon,  5 Oct 2026 17:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791221615; x=1822757615;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TUEn8nDhzyu3Uym454sGOQTqjLxLugtJZEhhYWb+PIA=;
 b=UKi8W6Mcm/MV6TKOQK/nz4FQqljGbLvZihRWqwa6NTGLhSWyhyR09x+a
 dKFArO6RqQlg2ZgqrUXhDQZHGGqWXktVA6EJRKx82UJ6QiF2A4dGPe7KE
 e7etX5fN3bqlJXXNGkNkPt25piJUur+8M1odvsKOpgSuMsSEKfUGdgKiN
 teN8MLgjYrje2+GUdHDpdn+IT1s1tFXmsF5xq/nSff9vAUGpCeqvkGVYm
 TynjDeTS2d+yGLUgFO8hY8f6TKZtdJkQi+Hy/Oa0TC4WKpMfy/ppaHrck
 tgA9fy05uuWzwwr2WNGLt6QDjOJTsidJJZUZP4ysuKX71dzU3c1Kzl0EU Q==;
X-CSE-ConnectionGUID: Nr+JJuGUSAGZeVh9CEuEjw==
X-CSE-MsgGUID: bfyuhRbaQjyUDkQL+Oz3qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="91110218"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="91110218"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 10:33:35 -0700
X-CSE-ConnectionGUID: j/2p6Jb1SAe0O9Hvqwl7lQ==
X-CSE-MsgGUID: wErQmcZ+Ru+YFbANqXwyAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="284969607"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 10:33:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 10:33:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 10:33:34 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.59) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 10:33:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kp/UWafGPmNiz5n1nauw25hLU1+kpDZlDh/WtO+0DyOtq3cv/uEFN+DJSYbQlvy2h8EkpiWqJ4AJTSGpxriXah3zuKIJ18hGo5n/sgq9LMhP60b3O5txDpkqvXLDndRZMZ4+aMsFK6g3BMxyn8HW1agx7MQVN8XAyrN5gpWxiLKHD/lO1EYP8jdfDr/xA6VpQfKv0kfPVZdgpglb6BCvTg2Bnfhr+32waAKm/LN9kQTbBDrwvtrTcPS/nAPl4gv9TiGJkhCg1+Hrz2fgNWTE73JgvAQo1dRTfFMGTb0i5COu+VjvWENp5IsOexrdLnJ1oYtqAHDYkVKPwgMHp/uc4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUEn8nDhzyu3Uym454sGOQTqjLxLugtJZEhhYWb+PIA=;
 b=vFEYefhjh8y4CXGjNANvgFWhIi5Th2XaaaLH7onYT/mIz1N+bSEroCijpOoLZ6BmvDhwK9CCjkAxsMsqGhasmXDRokwRMAhJc/8FBEHuOF94gIos79hKMYkU/CTVbJ7U/qH6GVItVj0Emn0CaSl19ECDYESai7J3h6RDAXnOuUwoIMa/5ciZq2P4+AsDeW+YcKZZgcb4wT4jshrG61qN3muk3AAGU0f8FuPhKKGZ9QZ+DqqXk2UQsp1AfXPYAMPK18zknxSuoNe4EEJ5rY0xccBWkxwI15q7DXIHQgKIGg040TAL9DB44UwPaMwACOdaCYypumkRyR5Obx+hp0rU/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6418.namprd11.prod.outlook.com (2603:10b6:208:3aa::18)
 by PH0PR11MB9524.namprd11.prod.outlook.com (2603:10b6:510:3b1::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 17:33:29 +0000
Received: from IA1PR11MB6418.namprd11.prod.outlook.com
 ([fe80::b831:13bc:a1c9:2628]) by IA1PR11MB6418.namprd11.prod.outlook.com
 ([fe80::b831:13bc:a1c9:2628%4]) with mapi id 15.21.0451.022; Mon, 5 Oct 2026
 17:33:29 +0000
From: "Prabhakaran, Krishna" <krishna.prabhakaran@intel.com>
To: "Auld, Matthew" <matthew.auld@intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 =?iso-8859-1?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, "Jani
 Nikula" <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH v4] drm/i915/dmabuf: avoid global wbinvd on dma-buf import
Thread-Topic: [PATCH v4] drm/i915/dmabuf: avoid global wbinvd on dma-buf import
Thread-Index: AQHdOxHGow/j692TMUalNxr6NQYx9LbPaDsAgB/9JjQ=
Date: Mon, 5 Oct 2026 17:33:29 +0000
Message-ID: <IA1PR11MB6418530CCC8CC7D5CF1AB7F7FA962@IA1PR11MB6418.namprd11.prod.outlook.com>
References: <20260820205031.344338-1-krishna.prabhakaran@intel.com>
 <20260902193147.3835028-1-krishna.prabhakaran@intel.com>
 <ab752d82-47b0-4837-8b0c-030a028aa13f@intel.com>
In-Reply-To: <ab752d82-47b0-4837-8b0c-030a028aa13f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6418:EE_|PH0PR11MB9524:EE_
x-ms-office365-filtering-correlation-id: d6928941-10da-49cc-ccbb-08df2306c535
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|38070700021|4143699003|6133799003|10067099003|260925022911599003|260925021911599003|260925021311599003|56012099006|5023799004|11063799006;
x-microsoft-antispam-message-info: sNk3KTW6DO0Ee165XR9z36Q+cplILtJDFmDCb+Z9zxuZbeqlyE86QhjswHxsCHYR+j8XdoOynEikj2IOnFJGwoCqu4fIbumtBgWn9lvJhtizJKumlh3leJ64PZr1Bl3LauDMJPah8jJSaqLOZuJn68y5y6u7etnW1NyyrTU6/DLljULvbDXeO5VAT+htp7BptK1peKxuFPo6zCj0I9mhOwzD76jS32rEta+W+h5QB9umsVq3L+LieJnfdcstwBI+bqmCUYmqf7tN12ML5Rd/sFBuQJ36kdrRkL5zq0P9oO7o497mnt4os5q5imZTX4AO22GJWPREKIenC47HfyhZLPwB+faeR19FUEehJbS08EgLiNOdOU3uj/nMUwMCYSJl8Vj2+xo3NJzvIQn6bpjs4x5awNRUQPnvARoJrnWYeYTSUEA5NaCCZMw2KJeJcb/Pegjf8lBW9mW0swFIIJXnpMMQXz7zwY9xo+lV5cCl3duC1P10WgFvpSR3pfUSmj5tMFn1YWlU7czc5rPW6RWpqCBFGwc565LKPD7lNi+nDc5dxYGuKRZRflr9lKHo8OJyVBk3y8ThiB5XykURXdhNbBN7lk0xpVeKRS8/PGDkYmm8DsglgY1pQjkwUXtB60V/dctuPx5HrecKxzCACVctutp0FHOX3jHRnYQ0F4LHeaQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6418.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(38070700021)(4143699003)(6133799003)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jk+ha/UUgtwXMx46agtoMHrSVz5eNnn68mjN2G/BGoogU56MPgv9xk/eb6?=
 =?iso-8859-1?Q?CQ2xiNH/J3NDyURtINGk0NjKC+SHkWe2xFY0CPJU4H60JPJBpvJzHQ2XJk?=
 =?iso-8859-1?Q?rP5DAVS+6H1kXZR+F3cNPXNlI6w35s1ePMf2bZoGSSdWVdEiH5lRkfIZDb?=
 =?iso-8859-1?Q?4RXp/77u5ouqbkU3hdQubdAhCxFpLN50hN+smQszLCVJlcjlP7+fAngr1O?=
 =?iso-8859-1?Q?75WCXMuhV4xyYlvtJgwuk61IisPmGEvS59KIhNWm1cM1IlKgIYiiuBeEP4?=
 =?iso-8859-1?Q?M+Tex/bW403BDzkdJeL9KhW6gC5I6359kmqsXRp02xf6xwESrXElC0lGpz?=
 =?iso-8859-1?Q?NrJx1MqEvy+uo+uI1UgYd5f04pbgMvLRVwRfct56mStAxnsib4QiroWRzl?=
 =?iso-8859-1?Q?QbFXqMFJ7Ws2UA1H2tonB/9I258Impqk3na4/92QcMrN9lVXSGulHBDRph?=
 =?iso-8859-1?Q?E8jsccUVYtk/kpaH3+kSVnzhYx18EIryMeLvFxziardRaYuiHz1vckv4Np?=
 =?iso-8859-1?Q?mJ5eSvps6Xf7FIU8WrZwLEO6hb/DOFoMdAIYM1F3sUlmpRUNiYa9pRSGk0?=
 =?iso-8859-1?Q?0BRgvM/RvsbzCX7SkZMtFULm8QHwyKTv0PMjKohW82I3G2z4Lz2YtN9vtn?=
 =?iso-8859-1?Q?9VV8QjukeiohskHAMCWBpaCDXI3QM//8HVf8lczkIDc9rSRp3oAFkeKiYG?=
 =?iso-8859-1?Q?Hnbi+23zjJF1ApkvKtktsPxqqE5hrMJpJL25ypQurEptfwWWjPQzlaCG4w?=
 =?iso-8859-1?Q?BjcX6nHhzIZJWtmuizgktwcbQrNC5jDOLSB/6UtRSg0CxWoI8NdrA0Rk5y?=
 =?iso-8859-1?Q?43JX6UcLENYQwhWVbIZo2E4ZbT2Qgk/wMEM5FTlqlMWccSEKFkz4TUcHdT?=
 =?iso-8859-1?Q?QaBwpCPzp3XSzyeC+pSbtukrXuz5EM5Aut+GUTKiwvMwO4bqvNcAG3GMb8?=
 =?iso-8859-1?Q?yugD+jcncLZMk5owU4N+aAK6PjsPgZv66S75foJ7uD664U/q6yadl3A+N7?=
 =?iso-8859-1?Q?ugd7jel1aXJZIz2WglrgRdpsicHI9u5z14vaEmJww/C5BTx2g6L50V8/IH?=
 =?iso-8859-1?Q?yWP7ta9WwUTUzucuDC/laPHn7JptQiy5J2TqBr+GeaE5vxgx8nH8XwpX3U?=
 =?iso-8859-1?Q?yDup+QMuHX32hT7gRJtiVLpDRqAODXPj1yJndcOcEusZCeQI2Ii7pCumTO?=
 =?iso-8859-1?Q?e01WlGMiK96BtF+1jHGQQH49Aalsyu8Ms+p9KqqoHOglxDJLJ45v+TeXSz?=
 =?iso-8859-1?Q?dwGCng44PBXy58U3vGUgpn3FEfpDKsix/el39YQsrGzQrZBVwTND0btodE?=
 =?iso-8859-1?Q?Rs2WeWFsAiooQTe/+vQNQ1aOxUtlZ79ZYmI9fkYOpZlWQGi7JXfHONPuJP?=
 =?iso-8859-1?Q?jlaRzJmuU6X33ucdqYoP+F8wz2U5qxS7FY60P8ooxsqoGt3PLYNCcwHOqF?=
 =?iso-8859-1?Q?Q2yaPfSYcy3o5dx02xn58ptcAgTq2ZHvMHHSczSp4BUuFhelW3IRlSL/GL?=
 =?iso-8859-1?Q?8tN2HS5H0sKMq4+i0GJ5JfMY1AeqcyDomBSbrzi/ijfUFZBg6o2YKCcnXo?=
 =?iso-8859-1?Q?/4dHDiEq4p44Id+q2iUOR5Wzole2vab1/h2iwwCAo9AlF+GEQv9yLlUusV?=
 =?iso-8859-1?Q?4nixnuqDAkbCXDd2NjxbyF0N+p3r2fkcJ55Uxb7N9uBQZfNsj14VARs5lb?=
 =?iso-8859-1?Q?wntqc2RdNi7eqx/r8O9ohFHj8O93VxubdbTBSbsC+etQqEQmouEk/P6QPr?=
 =?iso-8859-1?Q?Q6/19etCOMquMp77YCGA6CXRAsn/hQgMTIzExL1M/CI9jNXe563boQHDq9?=
 =?iso-8859-1?Q?11jQSU70C/JPcNUOr03mQCLevWlYUoI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Rpl6Aaa/eQ48u0Yk84KgxclAwVRQhq0XC8GNci6K9cLnZDaK/HHTS/KdWTz3y03Mgsf2yZflgNOHIKrZOIWCrfmBkVd+tPZyFlUZqKzQKXJVux7zvuaO0NFnMowJohGTxH6STaPB5E3IGl7kVBDaZstYbcEp816uWs2UuSUlbELz0+YjgwZ+7EeU3SonRv1SzsmVX6m9xePUugONaGnWtOi4/Cpri5p86sbJshy2i+/R1PlFoJNhRPmI0Bb84LCgvzslX83Ja9INsH+jNcmLjUd9FHqCnYmoY8iMSABR0ixyvBT8doBtJD3TZMmcLxLrbHR57cYvfEQ4JiIPbT6Lbw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6418.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6928941-10da-49cc-ccbb-08df2306c535
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 17:33:29.4527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i7FUZUipLxdanJkWmVSouNISTX/rTe5xo5KSJly9fP9xunkUG9EFCftUzqr/4f9GT2k50DgpwMxLir/Lj+Y7rj9nJdcv23+Fgal+900/LZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9524
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

Thank you for reviewing and approving this patch!=0A=
Since the changes have been approved, could someone with committer access p=
lease push this patch to the intel-drm-gt-next (or appropriate target) bran=
ch?=0A=
Thanks again for your time and guidance on this series.=0A=
=0A=
Regards=0A=
Krishna=0A=
=0A=
________________________________________=0A=
From: Auld, Matthew <matthew.auld@intel.com>=0A=
Sent: Tuesday, September 15, 2026 1:49 AM=0A=
To: Prabhakaran, Krishna <krishna.prabhakaran@intel.com>; intel-gfx@lists.f=
reedesktop.org <intel-gfx@lists.freedesktop.org>=0A=
Cc: dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>; Thom=
as Hellstr=F6m <thomas.hellstrom@linux.intel.com>; Jani Nikula <jani.nikula=
@linux.intel.com>; Joonas Lahtinen <joonas.lahtinen@linux.intel.com>; Vivi,=
 Rodrigo <rodrigo.vivi@intel.com>; Tvrtko Ursulin <tursulin@ursulin.net>=0A=
Subject: Re: [PATCH v4] drm/i915/dmabuf: avoid global wbinvd on dma-buf imp=
ort=0A=
=A0=0A=
On 02/09/2026 20:31, Prabhakaran, Krishna wrote:=0A=
> From: Krishna Prabhakaran <krishna.prabhakaran@intel.com>=0A=
>=0A=
> When i915 needs to make an imported dma-buf coherent for GPU access on=0A=
> non-LLC platforms, or for objects that bypass LLC, it currently calls=0A=
> wbinvd_on_all_cpus(). get_pages() runs whenever an imported buffer is=0A=
> pinned, so this triggers a whole-cache write-back and invalidate,=0A=
> broadcast by IPI to every CPU, on every execbuf submission involving an=
=0A=
> imported dma-buf. That stalls the entire machine for milliseconds and=0A=
> starves latency-sensitive work on unrelated cores (e.g. USB isochronous=
=0A=
> audio serviced on the VMM's main thread).=0A=
>=0A=
> Flush only the pages that actually need it instead:=0A=
>=0A=
>=A0=A0 - If we imported one of our own dma-bufs, the backing object is=0A=
>=A0=A0=A0=A0 normally struct-page backed once migrated to SMEM, so flush i=
t=0A=
>=A0=A0=A0=A0 directly with drm_clflush_sg(), exactly as we flush our other=
=0A=
>=A0=A0=A0=A0 objects. This also avoids re-entering the exporter through=0A=
>=A0=A0=A0=A0 dma_buf_vmap(), which would recurse into i915_gem_object_pin_=
map()=0A=
>=A0=A0=A0=A0 on the source object we already hold locked (and fails the=0A=
>=A0=A0=A0=A0 igt_dmabuf_import_same_driver selftest with -EBUSY). SMEM doe=
s not=0A=
>=A0=A0=A0=A0 guarantee the struct-page flag though: phys objects clear it =
and it=0A=
>=A0=A0=A0=A0 is dropped transiently during TTM moves, and drm_clflush_sg()=
 walks=0A=
>=A0=A0=A0=A0 the sgt with sg_page(), so guard the direct flush with=0A=
>=A0=A0=A0=A0 i915_gem_object_has_struct_page() and fall back to wbinvd whe=
n it is=0A=
>=A0=A0=A0=A0 not set.=0A=
>=0A=
>=A0=A0 - For a foreign dma-buf the sg_table is not guaranteed to be backed=
 by=0A=
>=A0=A0=A0=A0 struct pages, and the importer has no way to tell, so drm_clf=
lush_sg()=0A=
>=A0=A0=A0=A0 cannot be used. vmap the buffer and flush that virtual range =
with=0A=
>=A0=A0=A0=A0 drm_clflush_virt_range() instead: x86 uses PIPT caches, so fl=
ushing=0A=
>=A0=A0=A0=A0 one virtual alias evicts the cache lines for every alias of t=
he same=0A=
>=A0=A0=A0=A0 physical pages. The dma_resv lock required by dma_buf_vmap() =
is=0A=
>=A0=A0=A0=A0 already held here via the imported object.=0A=
>=0A=
> Fall back to wbinvd only when the buffer cannot be vmapped or is backed=
=0A=
> by I/O memory, where there is no CPU-side range to clflush.=0A=
>=0A=
> Fixes: a035154da45d ("drm/i915/dmabuf: add paranoid flush-on-acquire")=0A=
> Signed-off-by: Krishna Prabhakaran <krishna.prabhakaran@intel.com>=0A=
=0A=
Reviewed-by: Matthew Auld <matthew.auld@intel.com>=0A=
=0A=
> ---=0A=
> v4: Guard the own-dma-buf direct drm_clflush_sg() with=0A=
>=A0=A0=A0=A0=A0 i915_gem_object_has_struct_page() and fall back to wbinvd =
when the=0A=
>=A0=A0=A0=A0=A0 SMEM object is not struct-page backed (phys objects, trans=
ient TTM=0A=
>=A0=A0=A0=A0=A0 moves); sg_page() would otherwise walk bogus pages. (revie=
w feedback)=0A=
> v3: Drop the wbinvd fallback inside the own-dma-buf branch; the exporter =
is=0A=
>=A0=A0=A0=A0=A0 migrated to SMEM on attach, so flushing device memory made=
 no sense.=0A=
>=A0=A0=A0=A0=A0 (Matthew Auld)=0A=
> v2: Special-case our own dma-bufs with drm_clflush_sg() instead of=0A=
>=A0=A0=A0=A0=A0 dma_buf_vmap(), which recursed into i915_gem_object_pin_ma=
p() on the=0A=
>=A0=A0=A0=A0=A0 already-locked source object and failed igt_dmabuf_import_=
same_driver=0A=
>=A0=A0=A0=A0=A0 with -EBUSY; foreign dma-bufs use vmap + drm_clflush_virt_=
range().=0A=
> v1: https://patchwork.freedesktop.org/series/171760/=0A=
>=A0=A0 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c | 62 +++++++++++++++++++=
---=0A=
>=A0=A0 1 file changed, 54 insertions(+), 8 deletions(-)=0A=
>=0A=
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c b/drivers/gpu/drm=
/i915/gem/i915_gem_dmabuf.c=0A=
> index b43d34c7d641..d1695171019c 100644=0A=
> --- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c=0A=
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c=0A=
> @@ -10,6 +10,8 @@=0A=
>=A0=A0=0A=
>=A0=A0 #include <asm/smp.h>=0A=
>=A0=A0=0A=
> +#include <drm/drm_cache.h>=0A=
> +=0A=
>=A0=A0 #include "gem/i915_gem_dmabuf.h"=0A=
>=A0=A0 #include "i915_drv.h"=0A=
>=A0=A0 #include "i915_gem_object.h"=0A=
> @@ -249,16 +251,60 @@ static int i915_gem_object_get_pages_dmabuf(struct =
drm_i915_gem_object *obj)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 * DG1 is special here since it still snoops trans=
actions even with=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 * CACHE_NONE. This is not the case with other HAS=
_SNOOP platforms. We=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 * might need to revisit this as we add new discre=
te platforms.=0A=
> -=A0=A0=A0=A0=A0 *=0A=
> -=A0=A0=A0=A0=A0 * XXX: Consider doing a vmap flush or something, where p=
ossible.=0A=
> -=A0=A0=A0=A0=A0 * Currently we just do a heavy handed wbinvd_on_all_cpus=
() here since=0A=
> -=A0=A0=A0=A0=A0 * the underlying sg_table might not even point to struct=
 pages, so we=0A=
> -=A0=A0=A0=A0=A0 * can't just call drm_clflush_sg or similar, like we do =
elsewhere in=0A=
> -=A0=A0=A0=A0=A0 * the driver.=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (i915_gem_object_can_bypass_llc(obj) ||=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0 (!HAS_LLC(i915) && !IS_DG1(i915)))=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 wbinvd_on_all_cpus();=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0 (!HAS_LLC(i915) && !IS_DG1(i915))) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct dma_buf *dma_buf =3D obj->ba=
se.import_attach->dmabuf;=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (dma_buf->ops =3D=3D &i915_dmabu=
f_ops) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct drm_=
i915_gem_object *dma_obj =3D=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 dma_buf_to_obj(dma_buf);=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * We imp=
orted one of our own dma-bufs. The exporter is=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * migrat=
ed to SMEM on attach, so it is normally struct-page=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * backed=
 and we can flush it directly, the same way we=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * flush =
our other objects. This also avoids re-entering=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * the ex=
porter through dma_buf_vmap(), which would=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * recurs=
e into i915_gem_object_pin_map() on the source=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * object=
 we already hold locked.=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * SMEM d=
oes not guarantee the STRUCT_PAGE flag though: phys=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * object=
s clear it and it is dropped transiently during TTM=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * moves.=
 drm_clflush_sg() walks the sgt with sg_page(), so=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * withou=
t struct pages those pointers are bogus; fall back to=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * wbinvd=
 in that case (not the vmap path, which would recurse=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * on the=
 already-locked source object).=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (i915_ge=
m_object_has_struct_page(dma_obj))=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 drm_clflush_sg(dma_obj->mm.pages);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 wbinvd_on_all_cpus();=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct iosy=
s_map map;=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * A fore=
ign sg_table is not guaranteed to be backed by=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * struct=
 pages, so we cannot use drm_clflush_sg(). vmap=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * the bu=
ffer and flush the virtual range instead; x86=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * uses P=
IPT caches, so flushing one alias evicts the=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * lines =
for every alias of the same physical pages.=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * We alr=
eady hold the dma_resv lock via the imported=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * obj, s=
o use the locked dma_buf_vmap() variant.=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!dma_bu=
f_vmap(dma_buf, &map)) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 if (!map.is_iomem)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 drm_clflush_virt_range(map.vaddr,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 obj->base.size);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 else=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 wbinvd_on_all_cpus();=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 dma_buf_vunmap(dma_buf, &map);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 wbinvd_on_all_cpus();=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> +=A0=A0=A0=A0 }=0A=
>=A0=A0=0A=
>=A0=A0=A0=A0=A0=A0=A0 __i915_gem_object_set_pages(obj, sgt);=0A=
>=A0=A0=0A=
