Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4ADC982CC
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 08:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE47C10E53A;
	Sat, 19 Sep 2026 08:21:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BZRLuC3v";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 479D310E53A
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 08:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789806076; x=1821342076;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=59x2eElp7kN6AWrT2S4RoIxG8OhpiM29Blz47ycUfn8=;
 b=BZRLuC3v9xDtpK2bVvclZdVV50n70nRW16JIAPXAjenM+EKfzRVTZAGs
 pVBCGFj6SAbbir1rc3K/2NkjVG093iHWYi1690DQ/6IqyXqgkF4b1AuGn
 Sk1nlDYP+99vyUYh/sTdqoq+gJtJGoCbqVZWUlJctM5cucqa1P5DFXkT5
 CMJtUsUDOMWSEGOHQQVMxe4yWfwdtBgWs65Km04ENPlNNBYF7DZeHi2CG
 pt0BXqeQSAzbT8euQqM66sXdmF1pMzkWJqA5CI/jBBCGjEAdqEgeMCgdD
 mbGIYfITAd0lOnb/IYkFRR+ef5IfptyY9mWoXAyK1igsnS1uTjXiOSdOq A==;
X-CSE-ConnectionGUID: FiFaU3+5QcSF+vED1SBUJA==
X-CSE-MsgGUID: M4sBPBdDRK+nvKeitQ/e4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="100938195"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="100938195"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 01:21:15 -0700
X-CSE-ConnectionGUID: 6kJqhRcHQGCChYVSLauMWg==
X-CSE-MsgGUID: G9/ygdDFSwK+hqAuW24B2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="272084680"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 01:21:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 01:21:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sat, 19 Sep 2026 01:21:14 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.54) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 01:21:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8IlXpZ/XXfhqd742iMKO8niKwaRfqn22J0TQ9FDLCtfo3nKS9oSbfGmmemOsBxy1LvXkNHfSM+z8anwv0nSjovmSIvl+l56dlETRH5axlxt+i+asg45a8U4pwNLH1xKGNH9+rZzul+T1J8JRnydIxx5B1Rh+h4tayoTdVkrNljVg6zy5XuRErICf6qh86GkhYBF7+LQv7TBm92u/Pj/+d6gau6L4I1NJj3Kev52wZC+f1z5nrxYaLRUEWalwobyiiI4gYTStWAEmW4PPNnO3S4VeGiImfHwdCOABND/a/EnVwIWIuGMvO+BBjW8lVmOZGF05Eu/Y6OmtJTrlKiTwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4X1Vj33YXdxUHoLRBSQTeEMcDCI07icBiGFBxcMuUk=;
 b=hfGi6CgJZMCmZEFqvnesq9OdnVyJ6MwEhnwS522NVeVfE43wIEpjCzFjfA9zY0lrW64803mtruQF1Ga9xGE2zhcB2RROdQGEXTo10lUT58QbqLQQybZVsgaC0iSX0IEwL+/EevY1JlNLPejnw8RPHyZ+wZzsy3tXvIE+2jbTlYbL2iADrDu8wwwwqUv/SBaidRlLAMGaRKXsKOqUIR5q3FcxCNVUyw8GaaCJjGTvASUp+6uRMdIosk+DeYasVIN/wZK6JXwVHuNIi5Ly7g4uO6yABKtFG8Ys6fKyr1jE1tJzPR97/5GhLNMPx/al17zkcNqA/jQMTOT1G0RPNjnDDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SA1PR11MB6822.namprd11.prod.outlook.com (2603:10b6:806:29f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sat, 19 Sep
 2026 08:21:04 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%4]) with mapi id 15.21.0428.011; Sat, 19 Sep 2026
 08:21:04 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, Jiakai Xu
 <xujiakai24@mails.ucas.ac.cn>, Gerd Hoffmann <kraxel@redhat.com>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
CC: Huan Yang <link@vivo.com>, Robert Mader <robert.mader@collabora.com>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dma-buf/udmabuf: avoid oversized kvmalloc in
 init_udmabuf()
Thread-Topic: [PATCH] dma-buf/udmabuf: avoid oversized kvmalloc in
 init_udmabuf()
Thread-Index: AQHdRw38C2rXPPBhcUK8npGL/GDyXLbUH7QAgACOLIA=
Date: Sat, 19 Sep 2026 08:21:04 +0000
Message-ID: <IA0PR11MB7185B77735CA17E4C4B62947F8862@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260918013434.1849135-1-xujiakai24@mails.ucas.ac.cn>
 <a35cd398-4e98-4d19-bd6a-3c7ec0feeebe@amd.com>
In-Reply-To: <a35cd398-4e98-4d19-bd6a-3c7ec0feeebe@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SA1PR11MB6822:EE_
x-ms-office365-filtering-correlation-id: 2b17e90d-a390-44e7-a8e6-08df1626f273
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|38070700021|6133799003|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: YtJwrY0yvUOWUPDNsnKoCG0TN5FXTXlonNit+Ycr+RkrhfKPB4gI/r+yzAmNC2bGfUFWiN7DG9ESxS2bWJoi90CTRiDCxj/zZZTJhajGbiCB9upyymXCbKiwYCEvhd6Qf8+8BdRuivfDH9cdqVHqaE358056H6vIWD65OQik9vZmsJJbHu1fOsOyrEAPCyEOn0TbMmY7IBi0W+Prto8a1oayXzu+lD2xO5RaRNgr8Oq5/J1u92lvizHPqGQzpqK7QIhs9DO8Og25nULlQDrBEBE95Kcw2sj0tJtk7+pqCDc6XFydGZJY6PI+cr6OsH68dmSsVIx87eh0BfPf9iicaDrcOYLsC23Iy3di2ptG78CJ37kiNJ4pNZj55dbaYVCjm5BVK6F6WYkJBtfz1l2prXSkfm2EYSgIhGndADvQvQjnff1h5ExTOWBIgkz3z/yJGCS0iPL5X5SLC2V7oDi3Z7vZ8Pr4XpBXu383wc6s0gCIRBVsIcJXZvxV2aZamrfE22rzVrtYJXaMxMLjZj/TWVG6NRqCv0PQO+Batad98LRV9EEdpgjf75iB/4eu+wOpN3BeZfAFAR6b8zfgiORWcTg1xUuKb334FDWyJdZyKixroxqbfi7sm+T7URjAcC5jGcE6t/HPDZBqzf3hUSFGolDsxIOD2YEJWeux+L49cg3/m/e6BiRlsD4AgoGRWcO6kPT01qXrja89y4Wxq/dnm9ejvlCXS4XjGoL8cALu24M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(38070700021)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OBkUkMlUJPYBZTnqLdQ8w41Y4q4rIRkcAJYnZ9tDvJglprYN98R/oeT20Z?=
 =?iso-8859-1?Q?ktFS8wuZ8DYyhpSq9kWoO7S2ixlOQBT00/jL2eIPd5mMyDO5BYXcI6fZ9W?=
 =?iso-8859-1?Q?VFLejiSoo8D2eq6Uk6FJGED2HrCTknYU/rcLw//ytvgQJhCqDtG20k83tX?=
 =?iso-8859-1?Q?0eACFdS9tkuLP03sB3NQCILlN4QYuzsJIQUYLKGZr3UQ7dxdW4OWTDqF3c?=
 =?iso-8859-1?Q?i4EZ9fSqMg87/zNPNT5tFrKPr1nm0mmZiHrYlZYBTnltErEmK4IbkeQSP1?=
 =?iso-8859-1?Q?DVA9LyVu/DC5c5tUwq+VXS0iD2hLUB+NaEOofxz4cPe1NC31AwiEeaQlOp?=
 =?iso-8859-1?Q?tp1iqjrq017Vp/EtGTPwLHbZ9s5QqYdHJqemTfcOewsVxsZF+i2Zuy59lB?=
 =?iso-8859-1?Q?Fm1b5Coem+aoQy7gHD2Pmy01xqvi0juR1Fdtwa76lQBeI6dJSGBNbGTL0M?=
 =?iso-8859-1?Q?Uevvp7qmUG+OvtzZVHiNPA2lEbSaop+/l8gn7yLoMUI59DdSaor1t5zaE2?=
 =?iso-8859-1?Q?/Sb+d0LwAQsLbutd49s4oz1NY1AHhWjp17trsXjwUlstoBrTJutja5HowH?=
 =?iso-8859-1?Q?zcde1Ydg1yS+Sr1ICoOmTBUl5JycVJ5XN9UcFHlrfAiRac5IjPxbocHT90?=
 =?iso-8859-1?Q?jo/iDiknnrlVpTj2ouMf+CE2QeTS83xu3+iP+f/xuOTdYGPkAWXyM5BnTi?=
 =?iso-8859-1?Q?AqLXzAAJK7Zj4k469ryDLxhVLZ9x5En9RQxxGvOI0dwt8QYDB1oNeEsxmG?=
 =?iso-8859-1?Q?LwYfwji1hLYHLT6CVRC33XOYPKv5yOIYKfO76VXF7A5rR1SX5lxsOBdiXx?=
 =?iso-8859-1?Q?HItshdLpKvK3AcZjIM3zcgjnwUuUu9NN90oDUYRNkUvIxNXGke6r9iHlUj?=
 =?iso-8859-1?Q?1GZXRGaU/Z/+W2jvJ+KRMlQ+mCEgKaU+5o22uhLj7FjZkmuP8P1LmiFlFv?=
 =?iso-8859-1?Q?0rGYaYHq7fDOV1hVHssMknccw8h0OG5laRIejt6qn09fPq0EqZXCh3IIWj?=
 =?iso-8859-1?Q?32rM+3XnH9UCL0mPxMgla/f0y8kbJrmpM9YDuNSOwE4Qjr/1nImbMcE5xw?=
 =?iso-8859-1?Q?X+eE9a7bE/Njk+sF7kP1pn7Jb7xsVPkzW8jLpu0cLhbnwxa/rz+zXLL8nL?=
 =?iso-8859-1?Q?N+FvJKxVMS/wAG0EYBDP4sDQNRofKV7QqlU14LvaO7kateQuO1dEIK0ADU?=
 =?iso-8859-1?Q?efF9DzDwq15uus8nmKMFGUiJ0FN0Iv+OIo6S4Zd4GibZ//aiV4DJzOVc1E?=
 =?iso-8859-1?Q?O1KOzEilAAEWhaYrcZOyZXym14ZcrSYXqNgHVyhYvIcm2+Y+appsZ3g34e?=
 =?iso-8859-1?Q?ELDH73QNOVC74bCaseo04p23F77mB0HIPpD10Aby3XCeeGsq0yYubIShwi?=
 =?iso-8859-1?Q?2WwFMCZAWII1xsvnvrnh2+l0lwsjPIopy7pq53gV9pgE2mlqPrf8m6Tuht?=
 =?iso-8859-1?Q?33i0B1r/1jEzNI0Nw+jc28Wc5hW+X0t8FuqPQoo5CyLkr5gNGW0L7T/SmW?=
 =?iso-8859-1?Q?iWXkRJaAL3WuKwkwpxXiEYMaQjM+9r9Ykemkte+bpLketqmGr+3FkBgY0P?=
 =?iso-8859-1?Q?D6aP3J+ZcTyPxQJuFo59LjqZxxk1S4vRmMFqQgTKcKtlaADHQJsOT/kW4P?=
 =?iso-8859-1?Q?+yN+wm5oVMiogInjASfGSNSJbKS8LDwSHyksIRjbS7nrWH8aKm293hm62k?=
 =?iso-8859-1?Q?wq6cZoBTpzedOLvfTDiXi+PrMJvw39svxED/4RT0JGX0CvId4T0usP0dSj?=
 =?iso-8859-1?Q?veoDbEGDM+qqAYU0onSBa+wMNp2A0kS6Jspr343YKuq4hoqr+7x41a8KQ2?=
 =?iso-8859-1?Q?AivqlE5+Uw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KKONxybY82yeVSbNAr5FdAREevR7scyMcQTcy4rIvAUlKp/AiQuBKVVX+4Gm4GFGQ/LgNQ2W2kdOwLxboeejvbCBES+YD56uB7fvtIHJrA+hXQ1IqfY7S17locixgeMnkLfDAbtKSPBPp7NEXPIT5JZCSBsV3q5ZPtDmT4wJAu/POkO8dSlSHCiJ5hpQwtKRxKC2lFLYEnEmoQ20bk+reKcqmSP3nfl1kyRU5zmBqybGY0epQFi8TB4UygVeXKP2ww7P97kl6ACi3Xkk/onoP0ZYV2Cu2XiStguJkV4SSZE2tXqTwO6l8ZKE2fzgDFg0ZKlr+ydSwxNZm1wtzNjzlQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b17e90d-a390-44e7-a8e6-08df1626f273
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2026 08:21:04.1948 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kt4yXu5HbRIAQsSA1QEKvmwC0TzIvm18aDvE7aoWB/UN2vlRmW4Ss1MdUbMtSbxcd1GKhD4bRdDFrv49gvvD9iMm1loP8Zgh13R71OiIZCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6822
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

Hi Christian,

> Subject: Re: [PATCH] dma-buf/udmabuf: avoid oversized kvmalloc in
> init_udmabuf()
>=20
> On 9/18/26 03:34, Jiakai Xu wrote:
> > init_udmabuf() allocates two pointer arrays with one entry per page
> of
> > the created buffer.  Since commit 1c0844c6184e ("udmabuf: change
> folios
> > array from kmalloc to kvmalloc") these arrays are allocated with
> > kvmalloc(), which warns and fails when the requested size exceeds
> > INT_MAX bytes.
> >
> > With the default size limit of 64 MB the largest possible request was
> > far below that threshold, but commit 44e9eb5a7621 ("dma-
> buf/udmabuf:
> > Disable the size limit by default") raised the limit to INT_MAX MB.
> > With 4K pages, creating a buffer of more than INT_MAX / 8 pages
> (about
> > 1 TB of pinned memory) now makes kvmalloc() hit its "crazy size"
> > WARN_ON_ONCE(), which is trivially triggerable from unprivileged
> users
> > through the UDMABUF_CREATE ioctls:
> >
> >   WARNING: CPU: 0 PID: 412 at mm/slub.c:7021
> __kvmalloc_node_noprof
> >   Call Trace:
> >    udmabuf_create
> >    udmabuf_ioctl_create_list
> >
> > Fix it by rejecting buffers whose page count exceeds what the pointer
> > arrays can address before calling init_udmabuf(), returning -EINVAL.
>=20
> I was already wondering if we won't hit some allocation limit when we
> drop the general limit.
>=20
> Please don't add any new check, but rather give a reasonable default
> size limit.
My preferred solution to address this issue is to add mlock accounting:
https://lore.kernel.org/dri-devel/20260831060210.1713177-1-vivek.kasireddy@=
intel.com/

Do you think this approach (mlock accounting) makes sense?

Thanks,
Vivek

>=20
> >
> > Fixes: 1c0844c6184e ("udmabuf: change folios array from kmalloc to
> kvmalloc")
> > Fixes: 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by
> default")
>=20
> Two fixes tags usually doesn't make much sense.
>=20
> Regards,
> Christian.
>=20
> > Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
> > ---
> >  drivers/dma-buf/udmabuf.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> > index df6dd00462423..25984e75d7ff3 100644
> > --- a/drivers/dma-buf/udmabuf.c
> > +++ b/drivers/dma-buf/udmabuf.c
> > @@ -383,6 +383,14 @@ static long udmabuf_create(struct miscdevice
> *device,
> >         if (!pgcnt)
> >                 goto err_noinit;
> >
> > +       /*
> > +        * init_udmabuf() allocates two arrays of pointers, one entry p=
er
> > +        * page, with kvmalloc(), which cannot handle sizes larger than
> > +        * INT_MAX bytes.
> > +        */
> > +       if (pgcnt > INT_MAX / sizeof(struct page *))
> > +               goto err_noinit;
> > +
> >         ret =3D init_udmabuf(ubuf, pgcnt);
> >         if (ret)
> >                 goto err;
> > --
> > 2.34.1
> >
> >
> > --
> > Below is the crash report:
> > ------------[ cut here ]------------
> > WARNING: mm/slub.c:7013 at __kvmalloc_node_noprof+0x516/0x5d0
> home/zzzrrll/tmp/kf_src/linux-7.3-rc2/mm/slub.c:7013, CPU#0:
> syz.5.27938/167363
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 167363 Comm: syz.5.27938 Tainted: G        W    L
> 7.3.0-rc2 #1 PREEMPT(full)
> > Tainted: [W]=3DWARN, [L]=3DSOFTLOCKUP
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-
> 1 04/01/2014
> > RIP: 0010:__kvmalloc_node_noprof+0x516/0x5d0
> home/zzzrrll/tmp/kf_src/linux-7.3-rc2/mm/slub.c:7013
> > Code: 05 bf fa 2d 08 49 8b 0f c6 04 08 00 65 48 ff 0d 90 fa 2d 08 0f 85
> 4c fd ff ff e8 05 43 8c ff e9 42 fd ff ff e8 9b 86 0e 04 90 <0f> 0b 90 31=
 db
> e9 d2 fe ff ff f3 0f 1e fa 65 8b 05 8d fa 2d 08 89
> > RSP: 0018:ffffc90002bc3cf8 EFLAGS: 00010246
> > RAX: 0000000000000100 RBX: 0000000000000000 RCX:
> 0000008000000000
> > RDX: 0000008000000000 RSI: 0000000000000000 RDI: ffffffff835e3226
> > RBP: 00000000ffffffff R08: 00000000000028c0 R09: 00000000ffffffff
> > R10: 0000000000000006 R11: 0000000000000002 R12:
> 0000008000000000
> > R13: 00000000000028c0 R14: 0000001000000000 R15:
> 0000008000000000
> > FS:  00007fc89ae45640(0000) GS:ffff8880f3de4000(0000)
> knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000000110c2ff305 CR3: 000000002b3d4000 CR4:
> 0000000000752ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000006000
> > DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
> 0000000000000400
> > PKRU: 80000000
> > Call Trace:
> >  <TASK>
> >  init_udmabuf home/zzzrrll/tmp/kf_src/linux-7.3-rc2/drivers/dma-
> buf/udmabuf.c:193 [inline]
> >  udmabuf_create+0x1b6/0x750 home/zzzrrll/tmp/kf_src/linux-7.3-
> rc2/drivers/dma-buf/udmabuf.c:386
> >  udmabuf_ioctl_create home/zzzrrll/tmp/kf_src/linux-7.3-
> rc2/drivers/dma-buf/udmabuf.c:465 [inline]
> >  udmabuf_ioctl+0x132/0x1d0 home/zzzrrll/tmp/kf_src/linux-7.3-
> rc2/drivers/dma-buf/udmabuf.c:496
> >  vfs_ioctl home/zzzrrll/tmp/kf_src/linux-7.3-rc2/fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl home/zzzrrll/tmp/kf_src/linux-7.3-rc2/fs/ioctl.c:597
> [inline]
> >  __se_sys_ioctl+0xbc/0x130 home/zzzrrll/tmp/kf_src/linux-7.3-
> rc2/fs/ioctl.c:583
> >  do_syscall_x64 home/zzzrrll/tmp/kf_src/linux-7.3-
> rc2/arch/x86/entry/syscall_64.c:61 [inline]
> >  do_syscall_64+0x12b/0x350 home/zzzrrll/tmp/kf_src/linux-7.3-
> rc2/arch/x86/entry/syscall_64.c:84
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x590d6d
> > Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89=
 f7 48
> 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fc89ae44fd8 EFLAGS: 00000216 ORIG_RAX:
> 0000000000000010
> > RAX: ffffffffffffffda RBX: 0000000000611e7f RCX: 0000000000590d6d
> > RDX: 00002000000023c0 RSI: 0000000040187542 RDI:
> 000000000000000a
> > RBP: 00007fc89ae45010 R08: 0000000000000000 R09:
> 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000216 R12:
> 00007fc89ae45640
> > R13: 000000000000000b R14: 0000000000528d40 R15:
> 00007fc89ae25000
> >  </TASK>
> > ---[ end trace 0000000000000000 ]---
> > ---
> >

