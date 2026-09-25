Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17908C9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 05:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E5A410F827;
	Fri, 25 Sep 2026 05:17:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PsIHiLeH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B72D510E9ED;
 Fri, 25 Sep 2026 05:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790313472; x=1821849472;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2zAvH+E0Olt9Q3B7Q2tCDE/RzG3Tm/0vu3l1K3VdTfs=;
 b=PsIHiLeHzPwQiysX+wZAW1CbAs5fQpOZeNvRnIzEoJWpgDAhaUazG6Pe
 HFASxw/JTdKNT7i5aBQGoi4zhyvbiqI40SYamFdNlqsZ0u49XlQqP5SSe
 ULA9X9DjsnCTYRqAxbN0/YvQAfYe4TNFE1cxLTCC7vB38PDRwtpblJ78q
 UaWdOdw5H1Pi+BCvDj4vgQ9bBKJfeOJgFtLF+sK8gyqdJV1FvAGwh3laL
 6JG4BoWJKXEv6jMsdBoDR2uHt+gMg9DtpYwZ5s+vg/9UoYoYYpw3Rb2XL
 SGXMuJdFIqqmlJHiSNzMWvWM6xSP1mgYVIYl0fpy1Don5eC8OJ9lP/yoX Q==;
X-CSE-ConnectionGUID: 03+Bwb/UThO0m81v0FGQ+w==
X-CSE-MsgGUID: u5A9BvtWSK2veur7tY2azA==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="108586620"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; d="scan'208";a="108586620"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 22:17:51 -0700
X-CSE-ConnectionGUID: 5yOxRwGhSTe108Hgw2vxAQ==
X-CSE-MsgGUID: e75WqGc4QH++Ou1d/6vmuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; d="scan'208";a="277992663"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 22:17:51 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 22:17:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 22:17:50 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.11) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 22:17:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYTd0zMkMgDnVQlpGIfWzgXPCczAXG8skFQgC6cfB4LSo8Wg9A/5RLS1T+qzb86SmOpgivjR9ygqZDoPfc1LloPT0/HaIkYGL3qGNTCQjCaMh/yyy7eNgNO0qP1WImZPxMhfPRlMWYOtOjRlu2ULqwLL2+A/gK/NqdQhSiLL0LBv0cyTDs/YWxjpEyCu69w+RoD3ncFhjSB91IRxmipA0Sdlne5BU4aOvmps+CTrOsAybq5uSjaHcMbRllG4pU6AYN2btALqTbrliEW75cobS3gAJ/Ajo0JQNSwookoaycggnNjcDNUYLIVrisROfSA3xwJufU16QjTfv5oH3FrV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzsU0rtH31GOBneYMCv6tGDaXkt8xCyQSaTKGHg/qJw=;
 b=thnkmGqNjnYfVeTwROdUDzOiaEbKUR3cG31+S8zxg9CicXJdS4k88kB6BExJCzhxJeLDKqWzxeVny3p9IoflWGZ2U/2W3+ERfpicj5/sxsd0J3E9uwcUv9O8/4jB8XiW5aUkq+FE8Bk6Ncsdor8+TtlQVB4LgFNabCXQoGWYzV5IaEohMJT5qG4y38RUw5pWATL7lMFP/lDkE8zDlpu2TagYNuX+z0wTz8LCq8Jx9aikdHLGFtHJMis/pfER82264wdUkyy4GyxryAW6FKwykCHtVnILxBIWJZTRSi+W2n0tU5ywrmDct5dExboSv1lw7QwhIPghAV8IvS3yXJMVxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::5b) by SJ2PR11MB7473.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 05:17:47 +0000
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::5be7:2ceb:99ef:6334]) by DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::5be7:2ceb:99ef:6334%8]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 05:17:46 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: "Sworo, George D" <george.d.sworo@intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, "Vivi, Rodrigo"
 <rodrigo.vivi@intel.com>, "joonas.lahtinen@linux.intel.com"
 <joonas.lahtinen@linux.intel.com>, "tursulin@ursulin.net"
 <tursulin@ursulin.net>, "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "Sworo, George D"
 <george.d.sworo@intel.com>, "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>, 
 "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>
Subject: RE: [PATCH] drm/i915/hdcp: Fail fast when HDCP Type 1 is unsupported
 via MST
Thread-Topic: [PATCH] drm/i915/hdcp: Fail fast when HDCP Type 1 is unsupported
 via MST
Thread-Index: AQHdTKFO5decz1keY0Gebaizv9Y64rbetAYw
Date: Fri, 25 Sep 2026 05:17:46 +0000
Message-ID: <DS4PPFE901A304FCC90881F238024132B5CE3802@DS4PPFE901A304F.namprd11.prod.outlook.com>
References: <20260925035639.2034315-1-george.d.sworo@intel.com>
In-Reply-To: <20260925035639.2034315-1-george.d.sworo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFE901A304F:EE_|SJ2PR11MB7473:EE_
x-ms-office365-filtering-correlation-id: c66d8a95-509d-447f-679c-08df1ac455cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10070799003|38070700021|5023799004|11063799006|6133799003|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: 1zaRQTXLygD0noTl9Jrn34i+sFhdOTfRTbIL03jni3Fi59EOezaNeDbhD1Hpp1vgShsqUNznzMygpyss3RdeZ5RNwMKmWSFMhf+d92mRbtyxP1JSE6mUry+wiNy9PkR2X+7aSSz1g6O2lkPacRMPHL4tWsJXT55KvwVX2yIw7VuQIj0Heenxg+JWudYqje1DSXLWnsAOWnyfcyE7a2obWAkM7fWvQhLfJYTfJl+kzOMyyywDmSE74JA2pW7d/GMiftQNoNLHlYfgXdZVauQ+juAi08hOJSUocyXb88tsIsO+Y7r2Fu+zkfA2aYuz3Hp0eAY+ZwtXj0PD7sm8wdPjwiqZuKYyVQCqB9xSKznYx49Gnh9DCJO9lha9i7D70VjwTzlL/1UBELaE71WkkVWmOnYQK77VLlM7EIsMCfRJ6LXnlVakDTU6XRHHLckmgpqbfCwJpYEh6FqO+F7RAMZmNvFmUm/T4rterYXbUib0ofs13rX2DREGLlJP9hRgbsHjy9s5/l21dQBQWDdFxkH30dgtPbbG16CKAHTYOThxyZkK9uT1k3Y7prFHQ4llqEc7XN/Z8u0xMR7RhnyusLWk4DnZP65WmW2H0X2T7OyS+tKDmlpM4wyqSoYJAe3mzjk7aNqZ08giaA/fCuSzODVsqiX/fqRFikGOQ/NMOmb0MjUnz/pdiNX5xBxOQ9rbJrqD3fSPfzYjsv8ccWQFp2LOGlczaDVL5SHyDDyOVQAh3RM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPFE901A304F.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10070799003)(38070700021)(5023799004)(11063799006)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fRioKGbPp8pcL8aT+wLd7Z55GKIw5hu36kjp824/WlEYLOA+2fO7s29FFk8U?=
 =?us-ascii?Q?EJ6rRVs1A3WLaxmUPOHVkHkFiemLWgxTe969vvfKWk2LS+xKCFmvrF5YAugA?=
 =?us-ascii?Q?ZyLnFKIHF0mPuPFCZ312QZQR7CtEbbOy0ggR0t9WBSZ7ynNBIiTEXViE3fOB?=
 =?us-ascii?Q?L3YifBPsGwgs+kxDllBL0mSDLGxPDJVVwumez/XuVsicisS0KMW0vRGxZGqI?=
 =?us-ascii?Q?GxJ/4iUf7gEy2n+4G5Ja2DEvj8kVbhltNQqIA1pKg0wprAiRpB0AYZ4UQOK/?=
 =?us-ascii?Q?V7kPrhKfPlO5neHo6On1ICxoZ3/qU8gSHp9w0ADFBvEieQkqaGlod8S/ZDiM?=
 =?us-ascii?Q?w9IMHt25QYbHFh5eB1ADXeENJOMUcq22mwuoRDBAT5qVhUGYePO8WvvQBsp9?=
 =?us-ascii?Q?1mFBpcosfSeUB5Axqc2vPOfohfd7i/9SKWq6INkyi4ssQu/jYDFuSjrt4sOk?=
 =?us-ascii?Q?W2XS0EaD/frWrAGP39a8vG7yrSkwbplNNF8TQw8bezIKYFjlevPEndADWu0C?=
 =?us-ascii?Q?PqIAh8OuBVgjNF/yN2IOEwWHjZim/f4Hr5lT6rncM/+Gnw5SOPWSYlIcZewV?=
 =?us-ascii?Q?h5J05mnYLmuSBbqh0GkXYyw7iypBsr3O6OGWVnpLUc3pOD62EnMbP6fMsNg/?=
 =?us-ascii?Q?xq+9TQQt2IytWJWhhZYpLAJ23JFia1uekF/RwkhbWvTYqKL6nfgeSXGwLV9o?=
 =?us-ascii?Q?GDqCZmT0eDFn2Az7VBz4A3qYeh2AviCevmYh5tLUy/IWzytAVYIH75UkYIPs?=
 =?us-ascii?Q?/PcZJlw0ztp6OY3Mmwty1sNwWAOBzVfn+iFu+IWf/gdkoRZQttUbAoZ/w1Lt?=
 =?us-ascii?Q?QRB4l3lbTHe3Yn5aXPUPZ4cvZvqWBCqaFPfnuYvylCHhfeq/oTIErI+vMgMU?=
 =?us-ascii?Q?TQk0swZDO+UvI/p0lu+gZIdxW+jUDr0LvcPzZkfdm6zSdGeNMNz29GzVmulF?=
 =?us-ascii?Q?10TFy+kNaVATsoI/0D8l6NGDKgWFRp3yAxG09q8UMCp5aB1zCpvJtFXqLrPU?=
 =?us-ascii?Q?JIqQ05XWGjrs/TZ8LC1ISwph26+DrzXitagrPYgOesGmAYm6ho3HC/MzZ+I3?=
 =?us-ascii?Q?jeymDAPzgAOJYfAonJzWqUZrBGOvWj2uAFrA/r6ai5W8189ctPywpIZepKND?=
 =?us-ascii?Q?/OG77Bgus5sPNF7dKPgEpt7rQJra3LvTQJzdJYwmRXiJoAtM1YlpjWwZhmS+?=
 =?us-ascii?Q?CMrLiyzFumADAl/PwfY/1l4FGRTziDOFbEhaYtt+MtepWHEYX8jZdZC7g1cm?=
 =?us-ascii?Q?9S6Bvp+jFScffE4uTa3B24QfqlNCbL906Nn4AFMmV8es6NgMwwZZwQncdbvV?=
 =?us-ascii?Q?g//P9Fr70onUIchLS+IJJm6oYn7vUoPh6vEa+u88mpD8jbzOVD2JJ/9j9Lei?=
 =?us-ascii?Q?Z7YAXb9PUXkZChWhLciIvJpE2iE/6TewnzUiVdUFm68nhUgw/r25bN8OLnvD?=
 =?us-ascii?Q?eChhFbNHqJx12906e+QdxSPUA/A5wl4y2xpu4oz1QAIXsmtoylydMpP6iF9A?=
 =?us-ascii?Q?qgrjoCc0qjwjrKUMs5DF7hllz1SY5+03RD4REx+cbNQBmorF7HShlMt2IsIo?=
 =?us-ascii?Q?emIX/wW77DnNBpp9qy1/Z9VeeXMzojLYZmjwlKylkYKfAOWgnp+EH6Fm6aGI?=
 =?us-ascii?Q?R4P70iB4kQDajLzRkDHGmVuzMukJPn9MIPI3mxLiakfFmFPqzlLGV0o3TbGe?=
 =?us-ascii?Q?t+DqwnxGTK9mwG+VErXNFVu0D6RrfTldv5T8Z8tRsVOlWjomxpMVgdFzeVzw?=
 =?us-ascii?Q?wSc6q3pqaIPgJouZixpGVjB/mevAvb7kdTLONcC6BZViveRzYYDkGUknUVE6?=
x-ms-exchange-antispam-messagedata-1: Blkvi/71VPcp1A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wsj7SBg5XsKBFKv8y0Ib8B436jBENOVXVcGWvHPN4ERu6NAD3xL/WvhsM0MjlHVinopjDdqyujoSniCZhzd31X5scyNLjXc+XgI7SOdIEe3amGEL2KPyIr7h9R8rtluZNAXYxz+NubjAnVvNCKpvryb2E3gTi2ci4VXY3XTPanXiYhvmPAT5GmCAF3UAYg8IkaqPF84HGGhrpFciOVoVn54mOCX/ScKghhShwZN5ft8oYGgsLPX08sb1swfmM6nn3DZzjTlnBDyK/M14Wp0igMwKKW5rCTqGUlK6/AvMFYaK0BvmwgHu+MX6c1KD2s+GRqEogbBULTtAhCg0b2BYcA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE901A304F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c66d8a95-509d-447f-679c-08df1ac455cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 05:17:46.4885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z/PTpq5luiLZvL41lcuQXNmxcMwS+olvMKVinD0+/fFvelNPJ72bvwwG5SAxYseNeLByW6VhjRrY2RHYIU6EmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7473
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

> Subject: [PATCH] drm/i915/hdcp: Fail fast when HDCP Type 1 is unsupported=
 via
> MST
>=20
> HDCP Content Type 1 requires HDCP 2.x support from both the source and th=
e
> downstream MST sink. A request for a sink that supports HDCP 1.x but cann=
ot use
> HDCP 2.x currently passes atomic validation and fails later in the HDCP e=
nable
> path.

That is just not correct from HDCP spec source should just be concerned abo=
ut
The immediate downstream sink/dock HDCP version based on which it will
Either pass or fail the atomic check. So if it passes the atomic check that=
 means
That HDCP 2.x is available immediately downstream and according to spec
Source has no business poking any topology below that until later in the au=
thentication
When itself reports if there is a legacy device is present or not at which =
point
We abort the authentication. Anything other than that breaks HDCP 2.x compl=
iance
and will also result in many MST docks and monitors failing HDCP 2.x when t=
hey could have passed.

>=20
> Query the downstream sink through its MST remote AUX channel during HDCP
> initialization. Cache the result only when the sink reports HDCP support =
and
> either the source or sink lacks HDCP 2.x. Treat a missing callback, probe=
 failure, or
> no reported HDCP support as unknown and non-fatal.

I do not recommend this I have personally seen erroneous reporting when rel=
ying in remote AUX
Transaction when it may report HDCP 1.x even though it is 2.x

>=20
> Use the cached result to reject unsupported Content Type 1 requests with =
-
> EOPNOTSUPP in intel_hdcp_atomic_check(), and propagate the error through =
the
> digital connector atomic check. This keeps remote AUX transactions out of=
 the
> atomic check path.
>=20
> Signed-off-by: George D. Sworo <george.d.sworo@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_atomic.c   |  6 ++-
>  .../drm/i915/display/intel_display_types.h    |  2 +
>  drivers/gpu/drm/i915/display/intel_hdcp.c     | 50 +++++++++++++++++--
>  drivers/gpu/drm/i915/display/intel_hdcp.h     |  6 +--
>  4 files changed, 55 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_atomic.c
> b/drivers/gpu/drm/i915/display/intel_atomic.c
> index b66c2d4ba2b3..c6383e27e62b 100644
> --- a/drivers/gpu/drm/i915/display/intel_atomic.c
> +++ b/drivers/gpu/drm/i915/display/intel_atomic.c
> @@ -123,8 +123,12 @@ int intel_digital_connector_atomic_check(struct
> drm_connector *conn,
>  	struct intel_digital_connector_state *old_conn_state =3D
>  		to_intel_digital_connector_state(old_state);
>  	struct drm_crtc_state *crtc_state;
> +	/* Propagate HDCP capability failures during atomic validation. */

It's called an atomic check.=20
Also we do not add comments on top of variable decalaration

> +	int ret;
>=20
> -	intel_hdcp_atomic_check(conn, old_state, new_state);
> +	ret =3D intel_hdcp_atomic_check(conn, old_state, new_state);
> +	if (ret)
> +		return ret;
>=20
>  	if (!new_state->crtc)
>  		return 0;
> diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h
> b/drivers/gpu/drm/i915/display/intel_display_types.h
> index 79f30660c2b6..1c169849e502 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_types.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_types.h
> @@ -605,6 +605,8 @@ struct intel_connector {
>  	struct {
>  		struct drm_dp_mst_port *port;
>  		struct intel_dp *dp;
> +		/* Used to reject unsupported HDCP Type1 requests during
> atomic check. */
> +		bool type1_unsupported;

We do not store these here maybe in a state but not inside connector

>  	} mst;
>=20
>  	struct {
> diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c
> b/drivers/gpu/drm/i915/display/intel_hdcp.c
> index e56df337dc6d..7490fc0fd96a 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdcp.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
> @@ -312,6 +312,26 @@ static void intel_hdcp_get_remote_capability(struct
> intel_connector *connector,
>  		*hdcp2_capable =3D false;
>  }
>=20
> +/* Determine whether atomic check should reject Type1 for this MST
> +sink. */ static bool intel_hdcp_mst_type1_is_unsupported(struct
> +intel_connector *connector,
> +				    const struct intel_hdcp_shim *shim) {
> +	struct intel_hdcp *hdcp =3D &connector->hdcp;
> +	bool hdcp_capable =3D false, hdcp2_capable =3D false;
> +	int ret;
> +
> +	if (!shim->get_remote_hdcp_capability)
> +		return false;
> +
> +	ret =3D shim->get_remote_hdcp_capability(connector, &hdcp_capable,
> +						   &hdcp2_capable);

This is a poor copy of  intel_hdcp_get_remote_capability() which is present
there in the same file,. The existing one runs
intel_hdcp2_prerequisite() to clamp hdcp2_capable on GSC status,
comp_added and arbiter. Here you drop that even though in your commit messa=
ge you claim both source and
sink should support HDCP 2.x

> +	if (ret)
> +		return false;
> +
> +	return hdcp_capable && (!hdcp->hdcp2_supported || !hdcp2_capable); }

The !hdcp->hdcp2_supported is dead code.
intel_hdcp_init passes hdcp2_supported into
drm_connector_attach_content_protection_property, and that only attaches
the HDCP Content Type property when it is true.

> +
>  static bool intel_hdcp_in_use(struct intel_display *display,
>  			      enum transcoder cpu_transcoder, enum port port)  {
> @@ -2421,6 +2441,10 @@ int intel_hdcp_init(struct intel_connector *connec=
tor,
>  	if (is_hdcp2_supported(display))
>  		intel_hdcp2_init(connector, dig_port, shim);
>=20
> +	/* Cache the remote capability before atomic checks can run. */
> +	connector->mst.type1_unsupported =3D
> +		intel_hdcp_mst_type1_is_unsupported(connector, shim);

This breaks when topology changes hdcp_init=20

> +
>  	ret =3D drm_connector_attach_content_protection_property(&connector-
> >base,
>  							       hdcp-
> >hdcp2_supported);
>  	if (ret) {
> @@ -2684,10 +2708,11 @@ void intel_hdcp_cleanup(struct intel_connector
> *connector)
>  	mutex_unlock(&hdcp->mutex);
>  }
>=20
> -void intel_hdcp_atomic_check(struct drm_connector *connector,
> -			     struct drm_connector_state *old_state,
> -			     struct drm_connector_state *new_state)
> +int intel_hdcp_atomic_check(struct drm_connector *connector,
> +			    struct drm_connector_state *old_state,
> +			    struct drm_connector_state *new_state)

This goes against what the Content Protection property is documented
to do. Have a look at the property doc in drm_connector.c. DESIRED is
not a question you answer once. it is a standing request. The doc
literally says the kernel should enable content protection as soon as
to re-authenticate whenever possible, across disable/enable, dpms,
hotplug downstream device changes link status failures. Failing the
commit is the one thing it is not supposed to do.
The way we tell userspace it did not work is by leaving the property at
DESIRED and sending the uevent that is the whole contract. Userspace
sets DESIRED optimistically and then polls or listens, it does not
expect the commit itself to be rejected, and existing compositors do not
handle that.
And note the irony here, downstream device changes is called out
explicitly as a case where we must keep retrying, which is exactly the
dock/monitor swap case this patch makes permanently unrecoverable. So
even if the capability read were reliable which as I said above it is
not, hard failing the atomic commit is the wrong way to report it.

>  {
> +	struct intel_connector *intel_connector =3D
> +to_intel_connector(connector);
>  	u64 old_cp =3D old_state->content_protection;
>  	u64 new_cp =3D new_state->content_protection;
>  	struct drm_crtc_state *crtc_state;
> @@ -2700,7 +2725,20 @@ void intel_hdcp_atomic_check(struct drm_connector
> *connector,
>  		if (old_cp =3D=3D DRM_MODE_CONTENT_PROTECTION_ENABLED)
>  			new_state->content_protection =3D
>=20
> 	DRM_MODE_CONTENT_PROTECTION_DESIRED;
> -		return;
> +		return 0;
> +	}
> +
> +	/*
> +	 * Fail fast if userspace asks for Type1 but neither the platform nor
> +	 * the downstream sink can do HDCP 2.x, instead of only discovering
> +	 * this once intel_hdcp_enable() is reached.
> +	 */
> +	if (new_cp =3D=3D DRM_MODE_CONTENT_PROTECTION_DESIRED &&
> +	    new_state->hdcp_content_type =3D=3D
> DRM_MODE_HDCP_CONTENT_TYPE1 &&
> +	    intel_connector->mst.type1_unsupported) {

This is also called for HDMI which will not have the mst properly initialis=
ed what happens then

> +		drm_dbg_kms(connector->dev,
> +			    "HDCP Type1 requested without HDCP 2.x
> support\n");
> +		return -EOPNOTSUPP;

Failing here takes down the whole commit, not just this connector.
Atomic is all or nothing, so a compositor that sets CP DESIRED with
Type1 in the same commit as a modeset or a flip for other CRTCs loses
the entire update. A property we cannot honour should not be killing
unrelated displays.

Regards,
Suraj Kandpal

>  	}
>=20
>  	crtc_state =3D drm_atomic_get_new_crtc_state(new_state->state,
> @@ -2725,10 +2763,12 @@ void intel_hdcp_atomic_check(struct
> drm_connector *connector,
>  	     new_cp =3D=3D DRM_MODE_CONTENT_PROTECTION_ENABLED)) {
>  		if (old_state->hdcp_content_type =3D=3D
>  				new_state->hdcp_content_type)
> -			return;
> +			return 0;
>  	}
>=20
>  	crtc_state->mode_changed =3D true;
> +
> +	return 0;
>  }
>=20
>  /* Handles the CP_IRQ raised from the DP HDCP sink */ diff --git
> a/drivers/gpu/drm/i915/display/intel_hdcp.h
> b/drivers/gpu/drm/i915/display/intel_hdcp.h
> index efe86808e17e..34661b074784 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdcp.h
> +++ b/drivers/gpu/drm/i915/display/intel_hdcp.h
> @@ -22,9 +22,9 @@ struct intel_hdcp_shim;  struct seq_file;  enum port;
>=20
> -void intel_hdcp_atomic_check(struct drm_connector *connector,
> -			     struct drm_connector_state *old_state,
> -			     struct drm_connector_state *new_state);
> +int intel_hdcp_atomic_check(struct drm_connector *connector,
> +			    struct drm_connector_state *old_state,
> +			    struct drm_connector_state *new_state);
>  int intel_hdcp_init(struct intel_connector *connector,
>  		    struct intel_digital_port *dig_port,
>  		    const struct intel_hdcp_shim *hdcp_shim);
>=20
> base-commit: 999838292166407bbe911a41dee23112c49e9d44
> --
> 2.43.0

