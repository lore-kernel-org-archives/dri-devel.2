Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3748DC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 19:09:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57AA410F179;
	Thu, 20 Aug 2026 19:09:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NBDzhydv";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF2EF10F17C;
 Thu, 20 Aug 2026 19:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787252973; x=1818788973;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=P0Kd/vxMnNFW+uzIIBk8CY1wm5tZE81x4FP9ngtHfJM=;
 b=NBDzhydvouMCTQ5rCD778f44xRRwRL3dg6sBbGXjYGVO7awHSRGc6cG+
 0dqx7w01mBDYmX3gvr+8Bw9rnK2oyAqG7y+3LZICDZ+lYOPWeiAcYLAcC
 D5X29YVaSS3FGuiMExsOGNZ/jICtkq9DvdxEdyZPOXnGEzBC7prtshu78
 7ZW+5U4B3PXN/6W7/YzmbAbC0UcCTGiv01phM9jaum/krGVsHvtgH1ZGD
 OIFHcCqEDm3ivqRRUBeebXRjSaE1LbFjsI8+SoCHh98A4O/ICoIuoPujE
 CyeTbxHCug6H5kee4JHEN5UdWbwtiXsrVQQycFlpnHxQoemfPQgXetMnZ Q==;
X-CSE-ConnectionGUID: 0OyOiHVwQeqPQe4phGCciQ==
X-CSE-MsgGUID: FmVScEmpQqC8jajVmRMcXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87923824"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="87923824"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 12:09:32 -0700
X-CSE-ConnectionGUID: iV+s/+LJTgyQEJmLB5W/OQ==
X-CSE-MsgGUID: UES9ubUOSV+UVZjPDCXyJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="269945470"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 12:09:32 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 12:09:31 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 12:09:31 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.8) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 12:09:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvSlxe54Cx54Wmm7k8BSwtsdycmvLXkuXmAGJ7ukvB3BfGkp3yaYajSjgegjOPPmv6sF6BY/p8ZfwuQXx6sw6y6In92f/9My4lafBj4Hm5rGyzKN11peDAxllSS/py4KL9d1ujh7zpha0XATVYZD5Lg/XJfnU4EHKfTkxHy2PxOodQVRd0k+IiT3GHkY2PqSA9JDssEEYnq19u3q+jOQLlS+Fx1zcA7SUBIQJJi8uNGtLbEXQOsn4mg/FQ1t49//4g+pVQCW6gUfsncraSmnPGjRXIAukKbi/xRTbGwvI9R6m1c+vhMScqNQikxGNAMkmgL+xwDeQz0UQba6dSEGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWCkRqswISPLkGhKZ3njGxHcEc76r9G6u985ES7gHtw=;
 b=gyZfNY6rHWPITa7TjKlK5ftzXe7tD9kcG3A+zjDgv2kkrtzYAQbcm4zFQbHbmpt4rJH+eInwqrSyF6mBExixbtst16IP3PFgMzJNSDIBj+6tL6eAPwyJfjU8KJSywTIeQrqc0f+Btzgb1T6uMtqbMYwiZAgO8YyYoxgMRxgg5WjCgYpsMTzljPIkRLdr4flHhLZ8G9q3yKceNZQkRfM25ZupR9nRp2CqC16w10eAPUsUR/7ZnttPrPhPi7gC36UuXliUX3BaQTyn7TfwZSpFt1dhL9I/IRp2cmSXZTI0piu+Mrkvvzq5SnQZ0KI9+0p8Gq+caIVBiDUEQ46qESZWyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6418.namprd11.prod.outlook.com (2603:10b6:208:3aa::18)
 by DS0PR11MB8052.namprd11.prod.outlook.com (2603:10b6:8:122::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 19:09:26 +0000
Received: from IA1PR11MB6418.namprd11.prod.outlook.com
 ([fe80::b831:13bc:a1c9:2628]) by IA1PR11MB6418.namprd11.prod.outlook.com
 ([fe80::b831:13bc:a1c9:2628%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 19:09:26 +0000
From: "Prabhakaran, Krishna" <krishna.prabhakaran@intel.com>
To: "Auld, Matthew" <matthew.auld@intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
 "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "Vivi,
 Rodrigo" <rodrigo.vivi@intel.com>, "tursulin@ursulin.net"
 <tursulin@ursulin.net>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/i915/dmabuf: avoid global wbinvd on dma-buf import
Thread-Topic: [PATCH v2] drm/i915/dmabuf: avoid global wbinvd on dma-buf import
Thread-Index: AQHdLSEDAM+rltzTuEeLf4YUWeJViLamsPeAgACiTLk=
Date: Thu, 20 Aug 2026 19:09:25 +0000
Message-ID: <IA1PR11MB641816D15A8673AFD5667E22FAA42@IA1PR11MB6418.namprd11.prod.outlook.com>
References: <20260816014552.14969-1-krishna.prabhakaran@intel.com>
 <d3fa2250-3530-44d5-9661-032f195f8ad0@intel.com>
In-Reply-To: <d3fa2250-3530-44d5-9661-032f195f8ad0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6418:EE_|DS0PR11MB8052:EE_
x-ms-office365-filtering-correlation-id: 10a4d4fc-605c-4063-6cb6-08defeee8d54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|56012099006|38070700021|11063799006|10067099003|4143699003;
x-microsoft-antispam-message-info: b9d/gEdBcpu1F4/UXis0LzaljxPyU7Ko81+uF9JQWE+vHG3q3cHh0ZglM0BKrhpgyD/FVF8BYrGk86dN5eIP+nP+pRSraqDvZoE9DJakG+4gFhvcQEzk+PPH7aaVJOJRqkM4QGHOZsS5N8+rM1v1JqvtygHUF6Aq8JkoTl4KE9MNWXBo9v5aMJbavIxtdb3Y96Fg+lMlHHMMcbaThZ8nBIKUnww7A/ooMdIOX1hfADRYk6k2DKQo+6fgcObTy097+vbBHbPTVecV1sGcjlqCnDVKe5O1kHYTbvzQsBXcWJ6qTVI41ByUAQqp/n9op7Q3RecQ4sIUJ2YJzdf40ig5dL2NlidGChP6bLVBV+UnXMyMW+SzdfP+X/LgCj2SSMRDUwh2lty5lW5jntKiI60pe2D3o+gImbbdA6r7Cdt95QQGaLk9cbShAjgAI3VuXfHqE1fZ6VMIklhCcgG3H/cVngZeh6lMX8UaqMMjANTK5OpfJJ8hmnr7VgPgMW6CSNLZduQjxJoHbdxk44YTscJmzqRQzpX5akD6KWGYZsx5nNKYrHYPEBQxdKvXiPZ+CDvc+CSerecqmvsEXnskwTuZ04P7hI6ymrGYkuG8u+Vb+AMKolOD4GnYvbBzopKGly/t7rE3N7NmIYmVkDosurA366hTpUvUtWvlJhlAA6JUJc65G7JgL/6uGbROoWcYC9Ps1hMkopGBT317akIeqdFC2m4zMeviuHUcTXdlWMZGH5A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6418.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099006)(38070700021)(11063799006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RZUtVO4+tVNocqc4hMPNbMcNuWcQRJMHVOnQ0kqA0YVk/dvmkl8ZeSMsXj?=
 =?iso-8859-1?Q?gsy7Sb982Ba1TPKX5rg2TdKSiuhrRWl3YYhFJVDVK2nsbM34qo/vTYySmB?=
 =?iso-8859-1?Q?zgahU0F4vbpFvexwl7TVKKYYdmd4JnGebXCZGNHWM+KQ953R6GX9QcLYOi?=
 =?iso-8859-1?Q?2QYwIBf9odz0Fhh10L6z3GdQOECOS/VY1l4j21Cm8AKzX4LDgTLHNfDgTd?=
 =?iso-8859-1?Q?olRfK2luXPx/GimGe6+B1CBRoRwWACNT3NP0o7cWL01P1uPUDasOPz/SNW?=
 =?iso-8859-1?Q?4tRSls2rX0QEh+wgY9FsX5oGJRLqFBGQZYocGYzm820hGjd9KBz/Uu9jAz?=
 =?iso-8859-1?Q?Vfu3m+Li+XUkn6PH9pYX5ih0szbLq11G688LUkxbNnRzkgA+uKor+FaDH4?=
 =?iso-8859-1?Q?f4nPg43+sXxnIAPOarT/RTivKvoe1Bw1zpQZJfKXBh23pBcwiRe+bEXp9B?=
 =?iso-8859-1?Q?MmppSAFWKTR28tvvdjEIZaV/iryK4CZ65Yheh2Ho3YoYyRh5iw86O+k1F0?=
 =?iso-8859-1?Q?FaIlcgFRjEkG6VWPdYZn2cXRYTrF8iEEhVquYmm5hftYFc97lb5zhGgLY0?=
 =?iso-8859-1?Q?hWAaNY+79Og/+Yt5DHb5O4OJ+BdfxiKYTW/IksM8avxdk53Pvr1a7RCrPi?=
 =?iso-8859-1?Q?V5Tmkn7b7KN7ou+EQz6RXRLpSqNBgwt2um1EXXcVFJvAlalMSU+Dqum9z/?=
 =?iso-8859-1?Q?1KTj97IRi0pghCEnsuGRc/Uedgr9cwRumqga64mk1RW7gDgeUYiN+DAgg0?=
 =?iso-8859-1?Q?LriaM9VmrdtMZmUoKtmG4wvPd86lMG1LtOjRZtf9FFVSh86laKX5u6yd58?=
 =?iso-8859-1?Q?meHvqFrRe/bwgqkRTNliJ6BesWs7U+2yHCS+D4ItjTRKwpx1lra/bLRI1z?=
 =?iso-8859-1?Q?igyXVZXbPTXb9nQ1VbBL1c1/vxzslWkvHjJ2J8TDNhW/KZiAkbHuX89I0O?=
 =?iso-8859-1?Q?U/3qz82Me31nKvbCwPg2ZJMh/4tC5MSg4Mwk7rIvTZiqmcRNnmZQZbMaF1?=
 =?iso-8859-1?Q?WXCeKVwbSAThO8N0BCDjOcDte2/TqYBmG2Jm3f6w7XjCaUWy0QWWs7WXqf?=
 =?iso-8859-1?Q?eh2KpUTp+z8R+wEnuv9X12R5fbbmcoeZQ7SK4Oxr1X+qkkg/cKaGXKe6Mw?=
 =?iso-8859-1?Q?Zmh7EiIKqt3VHbNOgYINFrHcerKsCNEo7cVIGoEDLLIUlgxph/qfQQhCAa?=
 =?iso-8859-1?Q?HXBD7jmubZFzUK5mKvpHSVxBwD2UJZClrjpD53YlftTqX3cOzB7vkYoA5v?=
 =?iso-8859-1?Q?8uOuxPqPncd0ybhz9DFigJwICsbVFE4/rO72jd0SNB2cu5t8iH7//AXefv?=
 =?iso-8859-1?Q?h0TbixCkSJt+OeM7xcnHSXNS1X6VMsEH7jmHSodRo5sYDSgInE2TywslfB?=
 =?iso-8859-1?Q?QC2djICMuesXVeYcpS4PrniPRuV3+uGgm+Ar7ujPOeGrc6/YsQy7Jk8bYw?=
 =?iso-8859-1?Q?KctjFZR3X706BPhAO2ua58jPsOjKaKbSL8sq0bHUkUucPLxOHC1mJgVsog?=
 =?iso-8859-1?Q?X7M2TAIegs0ZwDW427weT/bWLcGuDI525t0GhjTpsaapJBunFItcxcU+d9?=
 =?iso-8859-1?Q?VMj2PHCM5+lt9rE5b4fC/Aj73GiZB25omGjfI/rm75KBAYgSt729nse9Rq?=
 =?iso-8859-1?Q?Pl827HESFj9/j2j7TkK3eLC/eHvB3Ze+jvrWrhr5DpjdwTuSTEJSeHrtd2?=
 =?iso-8859-1?Q?H8UpLeXmeygl2C7eVJANA5l9CBRO/set5R6DfeisVaj+cTugLPvjTetpX3?=
 =?iso-8859-1?Q?wqclHEuY411bJakPLAYhXfBtlGLWtUKOtAeRsWK72WRvFEbKgnInTpQwGi?=
 =?iso-8859-1?Q?DvDTpYCzKg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pk0IQmLsFYh6Oxwr82Edop053fGVaeohleyx2sdEFWAugJbpJp5ixGnK6vjQwFvIuJJ9kEOiNECtEfiYGxNN22bWejSDYMbxWJHS05Z30B/lG47RH3+mH4XOmMqBbVtF4FoYaFUUdSWurzu6akRUEO0RCgtitGgIALYb/OCDboK+BzHLqm+97CUv6MW4IzQzpgModfZSJB/EvOIWFZxnebYDLRDK1CLm51vqIJwOCdaPih/HgXD4Kddj5Rj0rmMNYqBPfguOq0ou0d7RksBe2mT7NlJCc2AEPZ5j3JFlcti9siTfPH4K7aliFw2pH+NrSLp6XlsbqY0FFEqn3S6brQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6418.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a4d4fc-605c-4063-6cb6-08defeee8d54
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 19:09:25.9643 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lb8CeNGhZ/DYdkBleukzu/cquNx/ZhoVXfZITag+8MM73ZqWS0aZ90XC1sunxPvdjIHa45e9u//set9/QcSYyYRqszMa35Rm9OfRcHPUxcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8052
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

> I think we can bump this now for dg2? I think we treat dgfx as always=0A=
> coherent with system memory. So maybe s/IS_DG1/IS_DGFX/ in a separate=0A=
> patch? Pretty sure the rest of the driver is the same.=0A=
=0A=
Agreed. I'll send that as a separate patch, "drm/i915/dmabuf: skip=0A=
acquire flush on all discrete GPUs", with you as Suggested-by.=0A=
=0A=
> Do we need the flush under the else here? If it's not placed in system=0A=
> memory what is this flushing, from i915 pov?=0A=
=0A=
Right. i915_gem_dmabuf_attach() migrates the exporter to SMEM=0A=
(INTEL_REGION_SMEM) before get_pages() runs, so dma_obj is always=0A=
struct-page backed here and the else was effectively dead code; a wbinvd=0A=
of device memory doesn't make sense from i915's point of view. Dropped=0A=
in v3 -- the own-dma-buf branch is now just:=0A=
=0A=
	drm_clflush_sg(dma_obj->mm.pages);=0A=
=0A=
Thanks=0A=
Krishna=
