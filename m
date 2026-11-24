Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53229606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 04:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k72g3MMP;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=j2nWS1Z/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3437710E593;
	Tue, 24 Nov 2026 04:58:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B303110E472;
 Tue, 24 Nov 2026 04:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795496309; x=1827032309;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OyFQOqnYIiWhXJaWo6YgPxJaG+Ka3iIuIowe1cEZuJo=;
 b=k72g3MMPfhNWmAfXPlDlzAX+kcrt40h2IWpR3JFocxRZRwbf21dXeHwR
 sHoVbxHAReNELCY2NylHurIfTh38EFh06omylyBUrIOk+poDH2cccwSP5
 3GXK3iAocDwd4fHjtlLRYbXM3jtfDuDb4MJv91Rwj8IJ43AaM7WCbb6q/
 6Uy5ZAK9RZPF/kaPUi12p1MugVgBzIgpAOcTVgPAF9noorREPCaRAqy+L
 VJI44YEazDB1uABz6SLZykN7aq7y2D5+AjztAat1lrE/uJqsMP//qgF35
 hGQ6e2erf/OGloMr0Tjf9IeeF5cgAjbk9Y0pUwvhZho2WSglrmDwnQ/f/ w==;
X-CSE-ConnectionGUID: qy4DMbeITiKTWgvx3v+jcw==
X-CSE-MsgGUID: B5WDFkDlQZKO8jD121o/cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4212313"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4212313"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 20:58:28 -0800
X-CSE-ConnectionGUID: 3U82AtS+SUCNcU+C1o7qLw==
X-CSE-MsgGUID: pmzeb8gOSPehMhguFl2wUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11803049"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 20:58:28 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 20:58:27 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 20:58:27 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 20:58:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/ZcdFIuxPkIoQsEty6kG3riPcgM3NIJ3/9MqNbpYHCHAeusSBKh0tz73i8rv74423X0AK+iGZoUmCIPpGx+0wMCkLmGYDVkyXXFXM38afeWsEBPfneWqDXMHS5zGD4JHaKff7DCgowCceNP8qP4WFtbVR28bTxvsgy1g2i+n1KBaf4pbgf9hahZtwUGgh4IpDMUymboMRIdHuFOPkSLjcP+ahS0k3LrmyE4b0eJpKbcaX9vGqQT7XsU95W2NRCu9Xe0+Q67c8DCuaiLGJ0mM6jPq2XQzxZlEoVw/+rOKaQfy8WAxRJzMjzzKMFNucofD1yu5o9p+uPZ6iYFoSY1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZ3yuBO7w/6TRUDCRRtOO4VOqB9aJTVD6RJgeGuXixE=;
 b=xJCSee2Ebbqi9u1r2cVeaf1LuZqf4jyoo7KVs5odlO7aiS3KHVKJOSVSk1uxMml6vyeChKZsEj7N6uAPNQYh31gDdHFEzkMHw/7W0ZjIwWzNJYc/FANaXdzFpYpUENbpran8mc3Lc8so+UgS3A+dsr2x1fq+audmPvOjiYnfqnOE7iOpmvlbWjpYQO64vIqB+hhv052GoO4JDhnZKZTyk2ld6h8gdO/h7XqWFtr0LkgjBuynXO9jbPeCT+yIHj7Rz5pDUSu0NFilljlp0QxhTLILQx+5FXysxiRP6CpNSiRZSdiEL7T0WE2xaRQiR+6McV/22QaTUClyIXLfgO8iOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZ3yuBO7w/6TRUDCRRtOO4VOqB9aJTVD6RJgeGuXixE=;
 b=j2nWS1Z/xsT1gaaDnCrtoMmk38h0+OU/5389MufnkFzZHTl70+Pfu34Lubf6OJxqHTzk+qhzL6FthgFYQ6GrQuDkYgYMjf0Z7XlJDhhOXuBaGT4S4+iVhv6apzpy8vG8vCopPiIPkAGfANHwERe3zhYWjjrFyV2x/1qfJP+nPeA=
Received: from SJ0PR11MB5039.namprd11.prod.outlook.com (2603:10b6:a03:2da::22)
 by MW4PR11MB6809.namprd11.prod.outlook.com (2603:10b6:303:1e9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 04:58:24 +0000
Received: from SJ0PR11MB5039.namprd11.prod.outlook.com
 ([fe80::d9f2:247d:ca72:fc1e]) by SJ0PR11MB5039.namprd11.prod.outlook.com
 ([fe80::d9f2:247d:ca72:fc1e%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 04:58:24 +0000
From: "Murthy, Arun R" <arun.r.murthy@intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, "Shankar, Uma"
 <uma.shankar@intel.com>, "Kandpal, Suraj" <suraj.kandpal@intel.com>
Subject: RE: [PATCH v5 13/13] drm/i915/dp: Enable the DP symbol TG, with a
 debugfs knob to disable it
Thread-Topic: [PATCH v5 13/13] drm/i915/dp: Enable the DP symbol TG, with a
 debugfs knob to disable it
Thread-Index: AQHdeK2xAhvA0nRQxkqw7k3pseCt7Lc3AosAgAWqbxA=
Date: Tue, 24 Nov 2026 04:58:24 +0000
Message-ID: <SJ0PR11MB503982248EF9BF31173D6D73BA442@SJ0PR11MB5039.namprd11.prod.outlook.com>
References: <20261120-vlk-64036-dp-symbol-tg-v5-0-bf8f78b32709@intel.com>
 <20261120-vlk-64036-dp-symbol-tg-v5-13-bf8f78b32709@intel.com>
 <1c9687d3bb57dd6e68891251c2cb546c9c71aa66@intel.com>
In-Reply-To: <1c9687d3bb57dd6e68891251c2cb546c9c71aa66@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5039:EE_|MW4PR11MB6809:EE_
x-ms-office365-filtering-correlation-id: 4794bda4-e118-4e4d-5799-08df49e791d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|38070700021|10067099003|11063799006|56012099006|261026140227099003|4143699003|261021121427099003|261022105027099003|261022075727099003|261102123227099003|261021123027099003|261028144727099003|261009223027099003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: bAwjsRfmmXGOTkvdQ8X10c2vug5hw50ydV/d7kylNHOQf9ivLdsOGn3N5R453t+0WB4kLyIv6/BhHQnOg+3Mi9W8JG3ue5q84TLlOPwib/oPHiadQF9FieDlEAo0pfMBQIQvZokPqcmX27uC8IXBJyPeD/t5AiABrs/n1/VjvAJIq8R6z0aeR2dyyXMB3Gd6oGaMELzGGqYZH8ldZGlbyBPyjgmPa0dxtgWadsnqj++CDBNwlGg4NeMWBG0vgVuoIwey1IUfVd7FYDggemwm0Zyu0W1xgf2lHRkGpZYcCRhFr7dX1vGIrYfhuNJp4qpZt6faOEjETlLO+l4ZMxSrnaBgjnU8GCbVhLiNKbSuoy/fSJt4sbRx9pbGrnzCLdMp4M7964lsYw56CBmYXib8fMb2aBgxDWpcnFNIRk773CAK+CzoycDzr6bKCX71isRluFRX4bDBVo5T0n0LNFEwdg4nXsClGhcthb93mKaLP+lvyyPsCgD4IP49bYw9mgA+fR1cqoxkWvhYMhVX/8NLgJqNXAC3zFrwjlGKNWEPRiOWziLbDtXx6ItVA0MWkJRjAb4v507Z978IvCX8q8+jrLlEPvJRze3fze8dljZyapVKrQXAtUhKUpTPsq+S1DLePQ1StTe0f9rmsNYVT+KmoK9aJDctvFTzPCq/YwCv0K+b+m9ncfeV2oMcaPq+zYMBcsVK1VGA4qls25jopDhVt8fnCcRVncCXFW7IqVu8f44=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5039.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(10067099003)(11063799006)(56012099006)(261026140227099003)(4143699003)(261021121427099003)(261022105027099003)(261022075727099003)(261102123227099003)(261021123027099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Twgz0QRt/tV0UcaTp4Y2hox0lFzH89Q5DjF29By2D8LQ7hCTajsZtgeCVqfe?=
 =?us-ascii?Q?njVXndJ157Wvq6IIV8Mw34ILCiPYdbWdRRx/Kz6wC2cR9XqUkpIp2UGCHAQ4?=
 =?us-ascii?Q?RldOu/ImOZgVokKni5m+U0LXoZH7JpyUkyqbxdjdHTn2hMKREuul/YKY2h3+?=
 =?us-ascii?Q?KyeGwX5xfsOX9vbTFiIxkWOnHOjHKT2Z/v66Yk6KBzrmTNRUvrkCmDb11vFb?=
 =?us-ascii?Q?JTXCdte7TI18VWbKT0SQKg8rvzI5gQTOKjC0CT0/jKK3HFQpierpcu/5+xF+?=
 =?us-ascii?Q?dbh+6/V/hvhxGHPdlX+ic9hP4N5uu+gRbaM+drEuE4wX0Cy4gXMsI92aLffI?=
 =?us-ascii?Q?nMRLnPY4Dq24q4lHLK3OxBvqVSBQI9+6m/ojnrJr7j0oIYor9r/qYAxNPuJi?=
 =?us-ascii?Q?1sWvsq13CfIrBOThSVIvOOnJK3gu5ASo42ReemcnxjypxbFId0J077KCEeBd?=
 =?us-ascii?Q?RcyngGO4lKVkgDPmz/xJ+rjKVRdXFuHS+uxxWqIqLNSZ3fSsZ0rmQZgrzip5?=
 =?us-ascii?Q?bJYSJkWvO/1F1j3UwvlVleAhruIhvxYAYj2eOTAcqHCQQW7eVNPsRLAqcrPw?=
 =?us-ascii?Q?I+L8aYXXvDwQDBgnh0STJyApRyBMVsJz8R5LrpSxVPuytCMcGxOyW0shox2z?=
 =?us-ascii?Q?KI6zOMNelk/4+mLGwUcUvJO6P3Xd4E4ez6AjHm8CA+Op6HCKwNAyoBtghw23?=
 =?us-ascii?Q?8YQeQWKH8mO8KshuZfVvknNZ2Szp3d+8DkaWgcsXgMDTzPY4CZ0JJNuYCGDc?=
 =?us-ascii?Q?7acUgdA+t6b9xMkPr5t5v6+cjMDoHDdTddbHV6zWn65YmNdXdpoTcwYS+pP2?=
 =?us-ascii?Q?2bKxtc6fR7m0SkFiUgct4vPNoLdFKV0sTSUpnQnBIwuBgbyzZ/FsJtwmC2i3?=
 =?us-ascii?Q?wD55V5FPEjlU/Bj62el/7GDMbFfljKGkmc5ZZSiOVq7FDWr3+42DmRFOQ5R8?=
 =?us-ascii?Q?zl86c83KptVt+Bxtx7uB4KX03R3UFb2EVx2y438ITtv6d5r2b3ttVlHIbXbe?=
 =?us-ascii?Q?AVGqpqW6YyNgiW7tqXUDALavXxTnE0n3A1eOIJRxgidCTV/gcHy3zQv9JVx4?=
 =?us-ascii?Q?XTczEFeZrM4W6Khvr2ET0awX1DmmIhwRKPW/wdbWhelrPYVhEG3U67E6E+wO?=
 =?us-ascii?Q?oRYvtLBjiSYNJi10NFFk1gwp0NuGyXC3F9WBgQ1DKC7D+9xnW9KguFw6RlFS?=
 =?us-ascii?Q?Ngu9HIxgPon8OURzQ1+hV+9HJUi+HuXe/VFS/ZLhcsoPEsMFPqhqhE1iDJNk?=
 =?us-ascii?Q?RQQAlqQvndEpFDn7u3GaV8DCizJfeOrExG5w4ERvCkoh/WNrV6/BmH8+bniX?=
 =?us-ascii?Q?iKuAcAA3TI5ZyOa/y3Iqkk6nFthlG8aRBgYYdgK7l/ZXr1kaLBouwUKZCd1b?=
 =?us-ascii?Q?bsETuYIh7b++VbRFRzbxbiqLBxdai+ICc2PSeSIOZMnCMJex5rS7+munalR/?=
 =?us-ascii?Q?0e2aQ/neWyE44ddAYVQYKR6qf4+mmXDbu5+PapV8W9vg52jJsm1KtDWpCxKa?=
 =?us-ascii?Q?Tys2XlQpVYhKsbWA6ZOhOo+jd2eLG/yfJOF0htrJYvaVf69oLSZ8ns+WUgn2?=
 =?us-ascii?Q?xzXBAhFV8zKx5LzCbVwkdKKWGHU+hmDP90THpW+ZTiYbgfK6DkT/YWUavnvb?=
 =?us-ascii?Q?WWG1zlUHrq1FjlsmkUIBo452m2zy5MAJLqLu7gSLEJn5xDDgEC/RIEP27kPQ?=
 =?us-ascii?Q?KqTsEwIeMroHw6VhG7o8Tq0NvJT/hUjoIZRlUorGji87MKIXAyeut05H8X4e?=
 =?us-ascii?Q?dFDr7zbMGQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: F186WvPhxvKtDMsoTWpTLC4/45SUstMBON9MlO+UgdLhOPSTRrteG6ESLQFz/h0T8m2OvB7Co0EHp3bn+NBIvZ+fEeKg0sihI3BBMSvjp+d+e72FAOAufFmncf2WqxVhucljppWvBtrapyHFuiW5FYRkbHbBFf53kR+ulwnNT9xD29IaOUYL+M+nByh9UPqWEHE8BFwjlxsvjiBAJwuXlfnivVnyktmMXYEkrSsbyuYkMpcLNtI0Q4xAX/ahFA3mtEdz5XNyROXNsuISIS4Sc0O7vBeUwsBdNi4v+K3KyH9YqptehekCjfUcyUb6MJ1Tg52TogTS01p9uGHs9RsfhA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4794bda4-e118-4e4d-5799-08df49e791d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 04:58:24.2885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ge+WXoM8aENlpP8OnCXxG85lcdItYbgvOm3ucJioUjR+V73dItLAToIeKjaRyC75MY3KKXpzIB161y4nPL5eGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6809
X-OriginatorOrg: intel.com
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


> -----Original Message-----
> From: Jani Nikula <jani.nikula@linux.intel.com>
> Sent: Friday, November 20, 2026 7:48 PM
> To: Murthy, Arun R <arun.r.murthy@intel.com>; intel-gfx@lists.freedesktop=
.org;
> intel-xe@lists.freedesktop.org; dri-devel@lists.freedesktop.org
> Cc: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>; Shankar,
> Uma <uma.shankar@intel.com>; Kandpal, Suraj <suraj.kandpal@intel.com>;
> Murthy, Arun R <arun.r.murthy@intel.com>
> Subject: Re: [PATCH v5 13/13] drm/i915/dp: Enable the DP symbol TG, with =
a
> debugfs knob to disable it
>=20
> On Fri, 20 Nov 2026, Arun R Murthy <arun.r.murthy@intel.com> wrote:
> > Enable symbol TG for 8b/10b MST and 128b/132b SST/MST on the platforms
> > supporting it.
> >
> > Keep a debugfs knob, enable_dp_symbol_tg, to still select the pixel
> > based timing generator, for the case of a sink having issues with the
> > symbol based one, or for debugging purpose.
> >
> > Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
> > ---
> >  .../gpu/drm/i915/display/intel_display_params.h    |  6 ++++
> >  drivers/gpu/drm/i915/display/intel_dp.c            | 32 ++++++++++----=
--------
> >  2 files changed, 21 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_display_params.h
> > b/drivers/gpu/drm/i915/display/intel_display_params.h
> > index
> >
> 5c5a1a1358c32a08a460bdb81da76c3682827ab9..503eef8cf744fbf802bcf86d2
> 5f5
> > 81871fcc3f8c 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display_params.h
> > +++ b/drivers/gpu/drm/i915/display/intel_display_params.h
> > @@ -56,6 +56,12 @@ struct drm_printer;
> >  	 * in intel_display_params.c on purpose. Runtime-toggle via debugfs.
> >  	 */ \
> >  	param(bool, enable_periodic_assdp, false, 0600) \
> > +	/*
> > +	 * Debugfs-only knob (per-device), to fall back to the pixel based DP
> timing
> > +	 * generator, if a sink has issues with the symbol based one. Applies=
 to
> the
> > +	 * next modeset or mode validation.
> > +	 */ \
>=20
> I'm not really convinced about this at all, including the previous one ad=
ded in
> commit 9ed39b7d74b4 ("drm/i915/display: Gate periodic AS SDP skip frames
> behind a debugfs knob").
>=20
> The idea here is that these match 1:1 with module parameters. Everything =
else
> probably should get added through the usual debugfs mechanisms.
>=20
Based on the review comment on v4 added the debugfs knob. Based on this 1:1=
 mapping with module param I feel its better to drop the debugfs knob.

Thanks and Regards,
Arun R Murthy
--------------------
