Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6DBC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 01:28:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1181610F827;
	Tue, 15 Sep 2026 01:28:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jEHdvSeT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0361E10F827;
 Tue, 15 Sep 2026 01:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789435692; x=1820971692;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vxKBsQIpe7DLBjFXdzE6tvrUFxa/eCSEVdeGmd5kzRM=;
 b=jEHdvSeTFJDGnwp6KcQ+WHvxZpquv/Lc5iCq8W0vrQgC6+/2oXugGFLs
 BNX26S4+9xCSvytWg//P8FF16cDUBUsTVDAQHFAMlr85xJesgdchujkx4
 FWhkeyA30EhPVfssZReMfDENDn6gmbMzq1bLXC6hd5GnHxYXsYB5h5DcU
 +c1fVFgmU4QKZBcrTN3dfNKkhKFepRN27d5i41+IUOLKvpH7tCgIUq5L8
 2UzDmEKEkCro5cLxir0XZvku7m90bZ/J9AASebakHojieR8L9Epz2l+5o
 wXhXYzHtn2LgAEksJfQ5dP4VXl77uyUEdgtozt66WVXXXgwZKC4l3Ybbc A==;
X-CSE-ConnectionGUID: XXcinCxrQnq3K1fHxtn8uw==
X-CSE-MsgGUID: 7gUocP/ES8ekI+WD2zCXYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89922118"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89922118"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 18:28:11 -0700
X-CSE-ConnectionGUID: O3IFcRfKReebNmgmtO9kuQ==
X-CSE-MsgGUID: T/EaKHJlSqiOVGd4xgzbXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="269519151"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 18:28:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 18:28:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 18:28:10 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.48) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 18:28:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuIjd0mwCp4L30910OK4LD6nmIGldU5PhsFPi+7Q7WnLM9jXTWO3A6Xefa+tvFl0RoCmYUvBkQgb6lD0VsTKLYYB9pMBii3pjNqtvRTYqjnKqgm1VJmbepuXrX8kntgjy7p8Oqx7DRysdCa2hnluwR52SCZLaRAMdTLi9FGCAu93Kg8HY87yC3varj+baBWW7psVlaaBUAwh1/VLomDRHxsOjKatmNX7PYk6H0s1cECGZ+WKqcNyS14MO+qbPFRbcWmQpF5vosdmymMPI1+QV3uvqPFKlqVLsJEE/7DQKoEL3HAnHF5GBws3MbV1JEYRrKwjDXPbQa2AX4ApafWhAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxKBsQIpe7DLBjFXdzE6tvrUFxa/eCSEVdeGmd5kzRM=;
 b=VUuCqqP2l3xeBVWaQ3CTjFdlEjWios6jSZ1Chyfx2ZgDzEpqdu9Neou0nZ40kavbvO90WGs4YMeojsY90CPA0mopF+KJBb8s7+Xrl7tZNpkgE4TT34RZgK+gum43A87/b1fXTSX4dttbAGTsX4jCwfV9jiLMerYjggr26RagdnEoj/AWk7zZfroWyYhKoFmVzg59ZMhn6BqlA8ag5Q6PqAkoPF7jy8q9jOfyi0VcJBAOzXFvvs7S9bkb0gckW3ZMz4sKXEo30HjsOwdgI6VIn50/F4v1/paqQqOv5kiiMS7dMKd1aQVFiNp3z2cblcfQ6MGPA5fbCPahaPNqlmcUvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6418.namprd11.prod.outlook.com (2603:10b6:208:3aa::18)
 by DS7PR11MB9473.namprd11.prod.outlook.com (2603:10b6:8:258::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 01:28:02 +0000
Received: from IA1PR11MB6418.namprd11.prod.outlook.com
 ([fe80::b831:13bc:a1c9:2628]) by IA1PR11MB6418.namprd11.prod.outlook.com
 ([fe80::b831:13bc:a1c9:2628%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 01:28:02 +0000
From: "Prabhakaran, Krishna" <krishna.prabhakaran@intel.com>
To: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Auld, Matthew" <matthew.auld@intel.com>, =?iso-8859-1?Q?Thomas_Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH v4] drm/i915/dmabuf: avoid global wbinvd on dma-buf import
Thread-Topic: [PATCH v4] drm/i915/dmabuf: avoid global wbinvd on dma-buf import
Thread-Index: AQHdOxHGow/j692TMUalNxr6NQYx9LbO6rRr
Date: Tue, 15 Sep 2026 01:28:01 +0000
Message-ID: <IA1PR11MB6418C4B9C463B2B58748A9D4FABA2@IA1PR11MB6418.namprd11.prod.outlook.com>
References: <20260820205031.344338-1-krishna.prabhakaran@intel.com>
 <20260902193147.3835028-1-krishna.prabhakaran@intel.com>
In-Reply-To: <20260902193147.3835028-1-krishna.prabhakaran@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6418:EE_|DS7PR11MB9473:EE_
x-ms-office365-filtering-correlation-id: edefb8cb-f348-484c-feb5-08df12c8956d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|38070700021|4143699003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: CB6NmWeNj0YyNnNid7p74egtHFyt4lkLIFqspF2nJhwUXniNu+oQJYkzpfiGlpmtN28kNBZIilGaKPOQHOCg4OLun8daHcKs9LP2WE8SOPA1D7N9+qaX12Zv80uy5cQq5HycxcSafcdI3FhDUa2ZVRFOZvSs8CURevIFLD/SgwpYNbw+H7iX1quwOG64dtHBZPNVQoM9yIzVjihO/mRc8maEocid1sVOAh1oN9zj1XH9HrZakMmS3H5UsfqLS0c0wRn65FBOSeVFFcULW6bzFXwyk6JL9fsLZtULX8yIlsL23avvp4AP9+kTmqE6z4tBAHcHwbrd5r06cxoU6aGLJAsYJ3VYSDc58N3JCRMSwW1T9z+uubilGYpnZQlLE67/CS59RMEndMCaMTkOxsXypDd8zEfqXxddaTew6FSd0NIKy18MdHWGPavYoq1iGR8At5WkivGP7LZk7Z1sLW076d3viD3YzwlpFDeBkYKOFN8aRyZBjVf9HlhNWg7Pzy21N/o2aUsbJimZhMAtls+6tR1qNYUIaF83XJr/EOk2AtOtlSsbTvYpJmBYMTV1BHbnodHOdf7bXQccQuiVXgVOe7G/dARgJRQPDMoNJfuB7UKG0mDL0Iq8Z+ITAMCCy82BYs8cLB3vadUtK1F3vruOjhQEypxoIo3ND2FIfmUO8z6XgOqZW849rcPMHiW3xG2nvpEzw7jV+R9YL693MCb9/yfq0kVe6+1Waqtlt5LkGmc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6418.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EVfLzozS7KzfgQrbfllERI4zkGJMe3oQEL4bKn+s7NNnV5EvgT0GKWXTGJ?=
 =?iso-8859-1?Q?LSCtzyalZHw47YdgIYbCJPk1hVOUplwxiHQEqS7VqoGSab+BvoRebf6k46?=
 =?iso-8859-1?Q?4GWnbysChl2Va+8gBIMjeLuDcWDPshx5vh0x8YKxRRLGBkjm7Ogyyr8hGS?=
 =?iso-8859-1?Q?ldyk7jbj1MbDqLTyKgANASKScLeaX4dWH2QNXZbrHGrAj1NBEd8JWlLYUi?=
 =?iso-8859-1?Q?X8SoFinTuiCVLQYSZMdOly6TpSa8FDnJi9DOlFTa5bGD9XCm1vTtCldCCS?=
 =?iso-8859-1?Q?DQkIgx8nSHjCtTbdmKAM1WIqmt5g6s0Ita4jFLQ5lHyrf1Hb8VxJ2EerjL?=
 =?iso-8859-1?Q?uGEsoja6XQztQRkWKrh3bEEjHfAXersMxgBGnPU8cueRBpdTaQZ/ddW7Sb?=
 =?iso-8859-1?Q?mok7ZekiN50BkuGRqD7Xu+JHDQhzW0TH8URIKkj+vYOi+dA28dqYHZbuQ/?=
 =?iso-8859-1?Q?7YBQW6Ar7aaw9KFzD/3aMpzC5dlEaQi52ElFmZ5e4wo0d6hGr9Yc2Gc1Iq?=
 =?iso-8859-1?Q?hPwmknQO2Dqe/ZTjMtelbMtWDaDuXXFMaEadVLsLlps9c+XKoURt+BjLZ7?=
 =?iso-8859-1?Q?1cBN/Nb0zWlerav8aVymlpO5geH+5q/is0AoFtq5KUL2XU8wPbt2CMjeQ5?=
 =?iso-8859-1?Q?kMS3k6OWzupbG8UNHcn5DoOktTyIe03MBGLErDg34AQViOGZ8R17Tf0pQU?=
 =?iso-8859-1?Q?NLylfU/4eEHkuMcje5fAPO3b5BLs/IEvh0pG4am5VpJ6s3GTUxWajGb+uw?=
 =?iso-8859-1?Q?Ti/DhXLKE/jEKqjIfOWUaBy/IMeLSbJJQKbgr/371Xi+F8wKExbPqWq49g?=
 =?iso-8859-1?Q?Wdm7R3fR+iW6qxGGaHLQsV5f5HzEIf5AcgLOPmztfJTrv8mXQXZ6jGmqdk?=
 =?iso-8859-1?Q?pMl9EHZ9MeWdsA25Sin7WV3SWD2dg4Ed7McBIq/yVHSdTrvBc6wiSabG39?=
 =?iso-8859-1?Q?SRW++/ykJpuNw6VqGt3rWvf4zDhX/2AUkaFpNMhV445ivqlwOjHIq0iY+5?=
 =?iso-8859-1?Q?FfMz3G3eSs7H+N66GAssVtpew3ylsTZIltGaOMl0GRulhkCCjk5ta9rXuH?=
 =?iso-8859-1?Q?5tmx5EGHOEDSRv2JERrklIqzQqKPasCmpAuRQ+OUchFRXd+Xrb/i5pJPer?=
 =?iso-8859-1?Q?aluIhvzNzPxtwO5zj0vA+xR1BYT0yNPqDtqfSvUzr/L5b6UNYHdVDi7/bY?=
 =?iso-8859-1?Q?/nOOpGWefEwb9U+LlEA3g28gOx7LvQkVoCbBgL+lzEZnGblU21sSw9N5sW?=
 =?iso-8859-1?Q?XP9MjV9EGvd1FwGA9LdpLU9FFI6kZNtxiGx4Bt8b2V728u89/KR02N3jJb?=
 =?iso-8859-1?Q?2aG3vpnbFgMKEVxsBycUOSWkdEiE5Khew4eJahHYSL2M1cWJIjY4rqYbNb?=
 =?iso-8859-1?Q?SVoDjKv++J3jB2+VgLe7CwH8I4xXmaQuuxzlNH/NTVvrlINwsKKKlYlVZh?=
 =?iso-8859-1?Q?HInmso2GneubBgoBnSZ96AAjkvCJmSjGbZqYyp98Ig31ogfiR4zV/ME+iH?=
 =?iso-8859-1?Q?Y39I05ge2RgZcw+ARAhWXgFZo2p8QsPcxgUo3WiT7oaVoJ5S9VpH8N9P1+?=
 =?iso-8859-1?Q?uN3RyWm3pg3huxwBNYsQ6J2MmNg6QHS9MYXiu5gXj9o3di3+O1JNf1/wGI?=
 =?iso-8859-1?Q?tzFnDe5n9kjfUe46AhQf71Tm15c7ZmX+P09lhhPHIwlAv6pQ6GDX9GXmO/?=
 =?iso-8859-1?Q?NTXBqTgtjMe144S1JmvhDz8lvW0M+G9QyaNJQx8hK2gkxAJYm2XHiSuuac?=
 =?iso-8859-1?Q?/v/rMdV3GBKvOUeesXF12WuQCd2pMkhnJok7hrASBTVD/USO1r79djMJu5?=
 =?iso-8859-1?Q?oa990plPNZ7VuEkqWopR1CecbW8/BEs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MyMlmpC9QtExchad+oCiPYJqkRSgfLbVcZDwUyas360SmUNf8bNrrhR67pdp8rA5aHjoOr4oox0ThV7OYvMLVG4YmXu2rt1z2LAhaCVPNzJY4bb57IejREiCcB+vtLEiPqWTjGgzlx/AGDPmQnEIGHkaGqq2PEmN+CwaQlxH5Kr+7fRPuZbiJEh58HBpzrsHUSVdPvFbfc7U27UnoBJJ/tb50xkar9yz/gt+CWz0+ceE14JysbeF0/A2UbJub1PG9OZlx2aUB42xDAIBKxwcyrjTv1FLtaAEVfM+nOuW3owWLvS1C9IrAbH49HeshsCBPM+gUUAd1sZt6bbWB81olA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6418.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edefb8cb-f348-484c-feb5-08df12c8956d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 01:28:01.9373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QkXTBAtioH5RkTS9+bk1b2DTjbvGX7gRRkjEjfsLwTI6u5zvReECxtnMwjwMWy6AnCg18mAhfTJoj7j2SxUgvG4zmq0wVInKO329bsZ/FcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9473
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

Just a gentle ping on this v4 series. The lone CI dmesg-warn is the known v=
blank-evasion flake, unrelated to this patch.=0A=
=0A=
Thanks,=0A=
Krishna=0A=
