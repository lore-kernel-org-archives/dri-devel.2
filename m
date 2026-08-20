Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8B6C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8DD710E220;
	Thu, 20 Aug 2026 20:20:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OIr6sRLM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B04810E220;
 Thu, 20 Aug 2026 20:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787257216; x=1818793216;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AOuuP83fUnon1uHsLpSgsFea+xfIJGI1YCsbyYlwmko=;
 b=OIr6sRLM6MBoca9eHEVgH4aC4Kl5tLu8CPIbXcmULSeRySJ4sIeUL50+
 KR9tx5S3HhPxS80VZ2jikkftJk53gKYORDAsvcDBF44Vu1OOD5cDqNlGZ
 8/dDn9oZKD+D6HCuCcRbfJ4w+LW1GVTseUIxnBlxZewaYkgsK841snhDm
 uIojMpB9QD+ONGylaulwgT9OfMZt0hhk82GmHzWBwT6oG1Ao2nNVp6zAT
 MOJL+d2tgVSMNgIwCohwwLDKppgIhH4ARyUsg8UEI8IiThcAIre+dGih5
 tIVFE7enSFNrQOCvFpXNQpTzlJTAZep/Sdrqc9kdFA+dmNrZZS3QBMHp9 A==;
X-CSE-ConnectionGUID: WFObY/IfSX62ubYIfYDf3g==
X-CSE-MsgGUID: MKOVC3KRTKqppXYzgyvJ2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="88008638"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="88008638"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 13:20:16 -0700
X-CSE-ConnectionGUID: GZQUe643TfaGj4wvSOCj1A==
X-CSE-MsgGUID: Oq6epQltSIOLhrGeRkGxAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="261864411"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 13:20:16 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 13:20:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 13:20:15 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.23) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 13:20:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dX6xuhJNq5IwyTD1ayg7rzAlsYd9LvQh/bKIbuMR97wxws8oAm4XyU9hCUOePKHmGMrG+MZpR33LeC+9BxmBYFdbyGQyedGVSqtH4DAHWT3IV/scCFDGerVtirX08CexLugqVmkXiIQ2DHST/6c+gpu4BGKFircD/7t/UhH/QJUJmxeWX3zZeyTobpUZlNPoBQqSepzOxqIaRUmx+og3BE3j7t9rYG5rDVYTQIrZHZiB8V/hQZudaSdBVcvB2nWuoTU1RVETcVItJXU7nICJwVk/pkUvltnGrWsZzHPC5ZagU97gR7vCo23z2IX1Z88uDqXXXGp+8yPJITQ6kPnxqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOuuP83fUnon1uHsLpSgsFea+xfIJGI1YCsbyYlwmko=;
 b=Jc7AIGF1KDpSnyJvjIpVCZOP6xN2LZ/+VoL3HYGUxkNe85L3tb4UI/Ty64qo7izZmBLDN39HiCY5vMg6xm3IL46JiGkEHcEW3/Dk9FAIoGtPp4O2g2Gt2hdS32epEXkia4+13G5f4+nCTDTew9Tf8meHQ6hbyV+Sw/JC/1RTztfnRjbswNV4oTySVfOn1ScqLLBdSUZOrk3UprSF4Io6ZIk2aT4isOE+a4kQ9/KR3VJUvd4VpgERf/Cj+K5EV5opnQfXtUGGhdQF44GnbZISV6fq94cVD1jydYfTolCfF708cTT6NfAJyh2kOs2mYRLB9ZF0ip6PwbiUYtNRshaIaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6418.namprd11.prod.outlook.com (2603:10b6:208:3aa::18)
 by DS4PR11MB263615.namprd11.prod.outlook.com (2603:10b6:8:509::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 20:20:11 +0000
Received: from IA1PR11MB6418.namprd11.prod.outlook.com
 ([fe80::b831:13bc:a1c9:2628]) by IA1PR11MB6418.namprd11.prod.outlook.com
 ([fe80::b831:13bc:a1c9:2628%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 20:20:11 +0000
From: "Prabhakaran, Krishna" <krishna.prabhakaran@intel.com>
To: =?iso-8859-1?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 "Auld, Matthew" <matthew.auld@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
 "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "Vivi,
 Rodrigo" <rodrigo.vivi@intel.com>, "tursulin@ursulin.net"
 <tursulin@ursulin.net>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/i915/dmabuf: avoid global wbinvd on dma-buf import
Thread-Topic: [PATCH v2] drm/i915/dmabuf: avoid global wbinvd on dma-buf import
Thread-Index: AQHdLSEDAM+rltzTuEeLf4YUWeJViLamsPeAgAAVPoCAAKEBeA==
Date: Thu, 20 Aug 2026 20:20:11 +0000
Message-ID: <IA1PR11MB6418DB79226105198C2E16BEFAA42@IA1PR11MB6418.namprd11.prod.outlook.com>
References: <20260816014552.14969-1-krishna.prabhakaran@intel.com>
 <d3fa2250-3530-44d5-9661-032f195f8ad0@intel.com>
 <f4a4d6b6a4b353e2993a0e556b93da8501846d40.camel@linux.intel.com>
In-Reply-To: <f4a4d6b6a4b353e2993a0e556b93da8501846d40.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6418:EE_|DS4PR11MB263615:EE_
x-ms-office365-filtering-correlation-id: a150e742-b8ef-45b0-d31a-08defef86ff1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: Jvh5MpYd23wPXVIreV6CVau2REcqwZ8ueMRWpRrKuqVsCQUNY8AUk20jT0MJWjK+5Ct35QxefO0FgahCJet2ASWojyuIG6XlXaZUKoK7gmkbVhLsPLQGkije2nYLVs307GVjgNlI6JoAFMS7PIaXG2VKqd2cZtWE+4kXNc6oM/KYapzJV5s2vCw+X1YKv9ns23xTZZI7sBP921yEdweBPMlb3i3Jpw/Qvb3rpWCdEsbI8Ytfqnq9aKl2IA/kIwdo+BITFZrg2FLt6jvTUK/zM5eWDbB5RRVBSFbqbQiUWPXUQwa7OnkGEYEdlDrlRgrUDTA5xiIVd5jOcyXSC61BbfmVrluSQ/M+kE4V9qKdjKeJrbn1Eeww74AT6bhBtdYRz49nwaI+V2+IZj+Sxi/lcnCxXTQKXGnGxbGqWp6UylpoF6vglw7qeHWHqsD1s++koFqNMF9QKiRIJnfSEqz+PxwdTunRtvbOzs20Vs+XWkfSjbCw6PTJr3r+7bjlBTRWh8sXcrCvoCs3xu4N02aYGw/HYmnTJ230I6JZStdpSPegQ42hsvfscDyA4F8LRGGRPgUlmjH1eVBwFNfOiZYvJbStQF3a2kbTrmTPKTk0bUTflKM++NVaKSv74Wi9p8CjKg0r+agTyDlPld+GSTbPL7/PTbuRQzXXZLWzlZQt04va1FJmdcp9zHepvU7OUT2L66XJdP45clqwc+7inv6mMbHsHGZT8ZVWGzGnHn84nA0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6418.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vKDId0Qrx7FBQQhdrbxKodqQrV3IKZJ4s2KuEXn41YrPDY2UwWAf+tUJ8N?=
 =?iso-8859-1?Q?4/ajWQhxzPqegAaSpdn8qRqByvj8AXTE3bd+8g9uHxujMbarNm6Ashy6hI?=
 =?iso-8859-1?Q?ZBvw490kz71w456kMkT3N7OjjAj5mxlbHf3lC66HRaZCeDYyiBhUISkWuv?=
 =?iso-8859-1?Q?MGCnAY5//WiIUgMwF/56/fgJUwiZuaNF6auA7Fsw/Glh1acV1HIgwkCaSS?=
 =?iso-8859-1?Q?08jiSKSC+FYUENx6IPnvz/qkVA89zpdSGqwAkn438q2gbs9Vq5W3bOTsP0?=
 =?iso-8859-1?Q?j6QIGp/f1tcLd5FxsRcryHd8APsisZYssvRSKXLoGUZmxQN0gyDtDwgy2q?=
 =?iso-8859-1?Q?pHUXB+m1kJ2QkiFgNiU899NpvCHNhy8n0CzBaR+kEsq+RYolhZcoIcSjpp?=
 =?iso-8859-1?Q?P8uHpt8y60MyzjuLlQDRFYd0qpoXzEpAkXtp3KtCFY+mZbUXXufAUYi9MJ?=
 =?iso-8859-1?Q?K3T5jGIjwyEzl72YoXTYFLkbxZMVAkmknjxVhm259GujjHLasYCcLb24Mg?=
 =?iso-8859-1?Q?UbHa7lqj2j4Rqcd4B3qPm/y0EfaFeyd14/QD2Q/02N7syhUHWundDkNQ+b?=
 =?iso-8859-1?Q?gjckvmj5I1FJNCPephb4hI6qzc15O7dLi3p2nwFdvzcukFGmgu6cCH8sHo?=
 =?iso-8859-1?Q?uozbgOeRl34H03cQ/3WU4Bf30wg/LzT3iQupouCP0jk1CNTfR98zP1MUBP?=
 =?iso-8859-1?Q?w3x/V/ORkKPD7ZgPILcbfZhPT6V7z4Wg2CK4bjdYfFoYUM91DFjA5UMb4a?=
 =?iso-8859-1?Q?QyI/ypUaL9F1tBREdt/9rKp1h0mdKu6pZqA3rOldGAesE5sklhxlj4n06h?=
 =?iso-8859-1?Q?N3q43Hjrw8mIlkS7C6o0XHNZNkXf+AjmMNhF2TUFWHGVrSz8FGLaNjcLoX?=
 =?iso-8859-1?Q?TOfYhGsupVU9x20o11H6bGexBy89imn3Dyj/rAzyj3IuwBc/NE3+DrBNN2?=
 =?iso-8859-1?Q?1lZTrx7hQyjP0XqvfdUVhWac1p8PHeUp96uuzb71Q444NM4MkdiFglwtlS?=
 =?iso-8859-1?Q?G2WeU8SnvAoy3H8iTl5C0441PpR8BpSse6qM3D8U4T/GHL+pP0Hfu1UfTl?=
 =?iso-8859-1?Q?pk8OKy5HZpIf+r5jC+bP0alCRxil+vkiAttRvOYLyNfhJFGWvSmLBRux1M?=
 =?iso-8859-1?Q?/0Fxa2Uucy11DJLlXw1wzbKYP59jImPo0u4MA+iXVVmYcXR6piMlh1WATH?=
 =?iso-8859-1?Q?k0zxcnyMWiSjKtopWPqsuLw88tsV0R2qXEm8GiXwrbvCetDEFoETC4lojX?=
 =?iso-8859-1?Q?cjoM1+Ci7vTSOs/Gr3jY9ILkc/4RzgEj0187xyyGTfr/kfwZpdorEU7McB?=
 =?iso-8859-1?Q?rZfWrp8rLXy420E3ZnWvg6vTNR/y1+wuxcXHtKF/lbfxT9YCSfHy2KYI+E?=
 =?iso-8859-1?Q?CuyxzPt5wlLfUqbDQocu+KyFJXYPmVPeW5YDsER9rWbbFhhCO0Qbj9LQk+?=
 =?iso-8859-1?Q?UcHgw7fb1xBXabd5p3/bBMzIGr5Ayl9xYhX48z6hgUCG7gFayvwjIwbiIe?=
 =?iso-8859-1?Q?P5KYZ1zJmACbaVM2Red4Fh1tERcFFWzQoPlS2LZpD2fmytxmMOEn5d/WU2?=
 =?iso-8859-1?Q?chT65H0P20+wMGe/lMHXp/hbhTrRJyj0EeLSHhE3ZdOd2E8f5SvVmuze5Z?=
 =?iso-8859-1?Q?PM+Rbl1BaJ70UTxsxB9wW6QvsNbaYg37gabTvni51MsJhIhgsLK/SH0LsC?=
 =?iso-8859-1?Q?9MgiQa262lHQkKzXt5ro7a3yALkZHV2jxMWk5oX9KvyQmlEYqOLO2rho2n?=
 =?iso-8859-1?Q?NXFtC6v6ecfQ+6YY1O+YPOaYMA10em9xIXpYYd9nb05AeTS5Gvt4Hl3W3k?=
 =?iso-8859-1?Q?/zv7N9Ig7w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kiNNGD1zpqUrMjS3gJCdszaKWeS9znLFQLWUYBfzD/qHTkzwiW++iruIvOx0Shj83zCD5IZufmXcDlneYnB5ThdNpW0bv7uEbS62qWHP9kXAf1SR2AKtHBD1SP6U6VRoTDajdTmaHBKA9V3lfa7ZyDzliI8suSt1YLCNCKSnrIVPLhc3iUu+6KdffjGZVVwYf4+88UR9c7ap3/xpf84A4QIg5cRNNt9Jfh6NTPoLlaScG8vwaBJpCpsfpyfG8Gcse4M4QbG+oDroo4SL+y8sSyukPT203bWyCm/PNyHYez9RRv4ctFaRmeGuDJYWnCBo0ypDAjJvF2EekEr6/l5eQQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6418.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a150e742-b8ef-45b0-d31a-08defef86ff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 20:20:11.6089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k6tN40ihpt7KGhZxspCBOSjBB9kswKk8ZGJc1LJk3rbXJHlZ97F0YuErvxzAEyBbnkUNlCdpY09xGuyTks8CzTxyOcoN8ydKEDURBiAYakA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB263615
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

> +1=0A=
=0A=
Agreed. Will send out a separate patch for that.=0A=
=0A=
> The need for this flush is a bit unfortunate. In theory iomem can be=0A=
> mapped and wiped write-back, But I'm not sure how common that is...=0A=
> Random idea, would it make sense to insert a GPU CLFLUSH into the=0A=
> pipeline using MI_CLFLUSH (on hardware that supports it) or an=0A=
> uncached but coherent MOCS / GPU PAT setting dummy blit?=0A=
=0A=
Agreed it's unfortunate. I'd like to keep this patch as the targeted fix=0A=
for avoiding the latencies added by wbinvd_on_all_cpus and look at=0A=
the GPU-side approach as a follow-up.=0A=
=0A=
To make sure I chase the right thing: did you mean making imported=0A=
buffers GPU-coherent via PAT/MOCS so the GPU snoops and no acquire flush=0A=
is needed at all, or emitting a pipelined flush at submission time? A CPU=
=0A=
wbinvd/clflush and an MI/PIPE_CONTROL flush act on different caches, so I=
=0A=
want to be sure which direction you had in mind before reworking.=0A=
=0A=
Thanks,=0A=
Krishna=0A=
