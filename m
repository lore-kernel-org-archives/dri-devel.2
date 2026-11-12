Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331FF606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 05:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K1mAQv/l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77E1F10E6BD;
	Thu, 12 Nov 2026 05:29:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26C6910E4C4;
 Thu, 12 Nov 2026 05:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794461359; x=1825997359;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gZita787LPd59uqrW6PitoM3nxHixTVOi9NtJSq0Ouk=;
 b=K1mAQv/lZK9m6fvGmUodUCcUWuvh6sDjc+MD5PP4b/zieCAhf0wO5CRg
 ersl5wQRDELBEUwU62tvypIF/XtXiU15Y/kLLY6JCEo+MUDhFxDRv/jW0
 vTI8OtRszzW82MR3ZujfKLb9sM3AB3zQBjqnla7ui5DtXbWLZ997vB/qV
 2oiEleQQRoYnLD3QBONDIsipA6nWTLQ9lT0MsxsSnmofxh+DhTL/iSBUF
 PyR1PHEzjQSDmKwNZYxSxGLQ/EObR689hoDdYQQvIZ+yZRMRsLyVXOnVD
 TjGX8ZCWeYUpNFj2BkCtw4phWUSdo12cvt0p6QTbUqbiQRHaGu711ij39 Q==;
X-CSE-ConnectionGUID: bgUTFyCSRQGqX5UPpC0LTw==
X-CSE-MsgGUID: PHEQKRRRQZex1Q2NHLMMEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3334050"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3334050"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 21:29:18 -0800
X-CSE-ConnectionGUID: FMkibplQSnyc0mmGXij+tw==
X-CSE-MsgGUID: ZNjC5kpuROGlLEacJ5U/Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; d="scan'208";a="10288689"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 21:29:18 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 21:29:17 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 11 Nov 2026 21:29:17 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 21:29:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZl2N3ns+zqw0rTSdL0k85Iy8aYZtmktUZ+TjQJ6HoEwPGaZT08OtW6zNssiTgQSUBLS4Lbh4xUwOjBF7yM42hHVAmLtrtsWLQFS4qxxnZIJ5Yra1RG0fh48mnVlOiE8IBnTwhrYPI4j7Fk+tqmWYBLyQeDp0jetDqIWTRsCBJZBYiir+HnL/2z5YjJanvwq/BORUTNnFYTxYaVuDR2SnXz0ShtCL0czBKYZjcSv35k9qzr783bppMYTgLxecz64dO/aAU59yOOUavJM501/bXJfeDXrD7ThhupCc99+jR30UsDuNK0vg6x65zfPs6bqpj0YPvjKuEDEvfFCqe149Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxJNyCQ4+OuHrkDcGgzArZIwoyXJogQN3612cgbGa5A=;
 b=ivJkJTSiad/mLaD2wnlQarKIRBJ2wz4A2Djvavx5cWSK0HkQPjIbU99Mfsq5RArxabqRAnZcq/KUEqo/Wp6nMyoP5DRLGGeK3LPgBRZmlI9cE73cuUiWRdTyr56rRro/15uc9xbfMrFxwFyYbcfKttq8SLtm0Z9dBTE6/cZZbQ4DP8xpeHWOMLsdqsP6dIXcouDAiInWrCy59JuhJ+K6EPio+Eosc4A5Ixd6vViaeB/Ee8Vnh/9y+UUwJuv/lzi5wk0iZm8BLOOMuTHdNVN6d1NOhIT1SIsjL6Rpk2hl/lgoYfahYuMLA2Sj+TxnEbAjQEvpYg2bBqsqyJk4XOOh1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6423.namprd11.prod.outlook.com (2603:10b6:8:c5::14) by
 SA1PR11MB8491.namprd11.prod.outlook.com (2603:10b6:806:3ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 05:29:14 +0000
Received: from DS0PR11MB6423.namprd11.prod.outlook.com
 ([fe80::bec6:10b0:bbdc:ea88]) by DS0PR11MB6423.namprd11.prod.outlook.com
 ([fe80::bec6:10b0:bbdc:ea88%4]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 05:29:14 +0000
From: "Prabhakaran, Krishna" <krishna.prabhakaran@intel.com>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, "Vivi,
 Rodrigo" <rodrigo.vivi@intel.com>, "tursulin@ursulin.net"
 <tursulin@ursulin.net>, "Auld, Matthew" <matthew.auld@intel.com>,
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/i915/dmabuf: avoid global wbinvd on dma-buf import
Thread-Topic: [PATCH v2] drm/i915/dmabuf: avoid global wbinvd on dma-buf import
Thread-Index: AQHdLSEDAM+rltzTuEeLf4YUWeJViLcpOQSAgACcCJw=
Date: Thu, 12 Nov 2026 05:29:14 +0000
Message-ID: <IA1PR11MB641869284E0505A68FF8E8E5FA712@IA1PR11MB6418.namprd11.prod.outlook.com>
References: <20260816014552.14969-1-krishna.prabhakaran@intel.com>
 <179439387311.199148.11937438921736048164@jlahtine-mobl>
In-Reply-To: <179439387311.199148.11937438921736048164@jlahtine-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6423:EE_|SA1PR11MB8491:EE_
x-ms-office365-filtering-correlation-id: 5e6bb025-8720-4db7-2f2c-08df407de3a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|261009221227099003|261009223027099003|56012099006|4143699003|11063799006|261028144727099003|261021121427099003|261102123227099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|38070700021|10067099003;
x-microsoft-antispam-message-info: cysrc8EfU6HXlQwqK7VG+jIyqrFV/qnW4Cyz4lggBnAT3dD9rfNQcX/+KFCXjBt79PCISFP4ef+w2n4D2BLwVr2sdBUPtYMD7sZ2bqu0ceIh/6k2HpO2ruyqol3W/X2Q1p6UQKLQ+pCubfp9KzKElNC53UnydZhUGQE3QnTxpLvT1O5hw62pe3WyzVUfRV9CopzU3gzmoZv0PQoZSVX/4YcWXMWCq7+X1UcQbtih7m566dgviY3pooQe2cy/6esINrwZaTG45dYbLUSEg1aKfnrEuo4/Rrvt2WbxHG1KbfAOJNSOu8z/bHzMy3e/YZcHrNQrAEp4HGykNdj0wMvnWMa2LvTM/w5r1NehBJr0eRbGckrGIkoDo50aPgJQjVZYnCPevGLUg/IbpkAYyrSePspW1yLjQ3jT9XFxTc7SkAo4DqX2RSp8N0RCfcTdfoIEOpANsNExMfqD9VvSxrZyIkX/fd8WIoz8SyfpxB6Q4qb/W/Tdn2MR93Nt1mtJR3nhib9pn+i/6CUwqo5vt8rHsTVc8zilHSlKftn9PNuCs5pzaxEXU0oPqFRCdsWK5AIbCGwkft0F2xADfOPaK6CorDLjrBRZeSDeq/GnFidU5nQHYxnZhDiy+VZ7H2nLkidW6zKzT8hZmhm9jS0uVYAgdU7+u0PAcr8I9R/ham4LxjKI+75GIi2N/8NK4Z+MB7SP83Lav15DFJfPVjYRtVfgQtIQZj9D/o8AxO7wB9gCZu8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6423.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(261009221227099003)(261009223027099003)(56012099006)(4143699003)(11063799006)(261028144727099003)(261021121427099003)(261102123227099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VjbW3BDjbcPuN5KHoCVfxaWMrEgRTnVn7G1LmRmeyRXZSD7w5ZR/68mG5U?=
 =?iso-8859-1?Q?3R7lvXOEwSS26zmRdDGO8Qb7gx1Jou3FRNHwXpMQ4qyV1tdQ7qkvxxZaIO?=
 =?iso-8859-1?Q?vDdJMCLT4rBd941qC+T/wFWWKejioGF7ToLKOGpiTV3xFitJRWxrRBfHCc?=
 =?iso-8859-1?Q?JMIGD14oZz42Q96aUrgtkdRlOgaUnE4GoHz1XQDw4DA/p83779uUjwngN5?=
 =?iso-8859-1?Q?Zit774cHq8bDnvUCoSSjN6E4pwU0rkoBGBEX1VMWNxNUeGSfIGgkPWNHgY?=
 =?iso-8859-1?Q?hq6gwrx0Sp1mXZs4BRVHWaft85+p2Ik/YkCZQYtvxEONCddPNfi8X/iUe7?=
 =?iso-8859-1?Q?ISqFDNazo/DhGnbITxYyA9acORJdYfTfGVsFG1OsWsJaI+CW1zulwS9AGm?=
 =?iso-8859-1?Q?fhWvsrzLdDoUFaJMmq4NOBVUoyxQUO1EiYpHCTOCH78zAz7groP5Cj5J8n?=
 =?iso-8859-1?Q?PrIOMGTJtvunLLjDHpUU9R0qaCUoribd3agB4FKd9bIz42Mvu5BcL8pd2z?=
 =?iso-8859-1?Q?6P3ItOMI48F1bN2nCBZi9PsCkF4pR++1vE4BGfNDuB/BzHzBdTlD0eJjg2?=
 =?iso-8859-1?Q?Tgh5gIjEtMZMa1aLNhmjQKfYfqfmKdn91OdWWvPZ1zZjpvvpBteZepzKYw?=
 =?iso-8859-1?Q?OCrqyFUM2rm5X2+oC/5eQjl0wrlXoVXa53JOdGLD9vQOyiBlQBZKf+CXSC?=
 =?iso-8859-1?Q?Nwxp0nOI5TKJdauoETdVUb5WNkq918pgSoJgTDX/UIImtPv+qNdHKVSwdd?=
 =?iso-8859-1?Q?+RG5WegITAR5ITLQ43LUNJpcIKn0pqH9IZ79Dy4uDFhTYCdrUjbSgisTiD?=
 =?iso-8859-1?Q?kmaWSFqhzuyyYsxb78LCL89bweqexK/TuzGHTPlrGTxaWq2iAcfJPkKxzB?=
 =?iso-8859-1?Q?9VuR0OA2RvleatuEMgnm1cjDiBb0oD/zuTz6jiO+TMzT20Pq+A//BaUNGA?=
 =?iso-8859-1?Q?Tw01XO56lMUKTrgLdxtZoF+fx8SxmMS1Bvos3tohLg6RJ8uYztY5KulpNh?=
 =?iso-8859-1?Q?sipLZicCbbjolUDJH2ff77i+UB2IGVFv/7gIV1LoPYMHG7kuALevdQAvh+?=
 =?iso-8859-1?Q?A9/3RSJrvRUKdiwNgS9Mv0dI6soHGN9rGbAJzssBevk95ssY5VmaNYZhUP?=
 =?iso-8859-1?Q?PhtZB22HcSFWLEX4QL6HbNymKC3nrzQgPCKm29kF23V48vItV89nuImXQY?=
 =?iso-8859-1?Q?Cw1ta5l146YYGDlDHYqTdjA4u8rdIj8uErC+yMSxPr4cacRMKA6U7G2vPi?=
 =?iso-8859-1?Q?l+/EiHyVcu1lKQJKNbkBpu5JpE6MnuZ7Kn/0ElY94LuFcf3U2RnxfIobhT?=
 =?iso-8859-1?Q?PFn8FIIMmG7wcHBP9dPmzmM1LZ94qfW01/XiqLhoIWQb2Tt9tSVhrrcodY?=
 =?iso-8859-1?Q?2wKuaxNPd+YmS9kvL1030uvzu7IF+QHEu3OVVVegKPTEAwfXyxY99fyoZd?=
 =?iso-8859-1?Q?nU8XwiowvTiErQ7U5pSViwtm0/VaMKpqtqv79c+xr10xhVl3OoF8l5Cpa9?=
 =?iso-8859-1?Q?slWU+7Ffjj9glisTDUmABCNm36Ch5ekuGQZgeROdHSwDrjjQAeseGlS34C?=
 =?iso-8859-1?Q?vvfq+u8JykG00NwQEkS9hfOoEyMqjUtGKMyroveuhHJ4EJHsgAyoKxEpZU?=
 =?iso-8859-1?Q?WOza6sILrFPQgYhNsjdFIfDkIcRUyPlTi62Q+j0Py2gpUUvxJx/eS5jxW9?=
 =?iso-8859-1?Q?J/7g2aoQls29Cn11rZ81ZOTa1i24k0OqDPlpTw39LOwAQsslkex/sxjmbw?=
 =?iso-8859-1?Q?Vul2eRRWTKX03pqv/omTY0rUD+0dc4qmEicYfB/zqmOlzdBtCnlvW1uj8y?=
 =?iso-8859-1?Q?0B/OBDNZJAE4KRfT1saH2P/F4pXJNT0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UNZtlJzwpMhwBbBBOy7mQIK/Xeohr+EZNA4kCcUc7EgoOH2EVgkwU8tjdDDaRj3ba1hXFvB+T2tGKDBxTxQl8p1E5D4AKI6z0ZMvq6Y2OjPrr4Vw5uOYLcqPU5cQs3rxCcMS/VlMlzOdPFeCF7i/xFIG8xPzJK8JC2VTL0lxL3guvzRYzFL9dejea6GQui8+ACAUThFO1x93VsZ5vx59DvAm9Y3m3j3DqWUcZMHxbRhm8ssMYFyRfAXiozEpAEbk5FybyvW7PS+E/FDTQncWbpjhnz8N33Faf7W8FjqW2eGGchioagZvY6QM3EWQrBicAQhfg7zrYvm2JimFfep0TQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6bb025-8720-4db7-2f2c-08df407de3a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 05:29:14.3907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ZRmG6a90eWQ7q51AVnrXEFpBpo2b+FtlI+qEAwKkEe8J0i7k08pQt84HeLu7a7BlGNa3hnAwzEOlh4KDcB+yJcPyHpqqcHU7XN9JmNgrZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8491
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> No bug opened for issue, no exact hardware config described, no dmesg=0A=
> logs.=0A=
>=0A=
> Also, if you import a new dma-buf too frequently, probably shouldn't=0A=
> do that.=0A=
=0A=
This feedback was on v2, but it still applies to v4. The setup is an ARL-S =
host running multiple VMs, with all VM's playing video. A persistent audio =
glitch was heard during the playback. Here's a perf call tree captured from=
 the host QEMU process during video playback indicating that this was starv=
ing the QEMU processing thread.=0A=
=0A=
virtio_gpu_resource_flush                     45.45%=0A=
  i915_gem_execbuffer2_ioctl=0A=
    i915_gem_do_execbuffer=0A=
      eb_validate_vmas=0A=
        i915_vma_pin_ww=0A=
          i915_vma_get_pages=0A=
            i915_gem_object_get_pages_dmabuf   36.65%=0A=
              wbinvd_on_all_cpus               35.95%=0A=
                on_each_cpu_cond_mask=0A=
                  smp_call_function_many_cond  35.92%  (29.74% self)=0A=
                    __wbinvd                    7.38%  (self)=0A=
=0A=
This profiling data is what motivated the patch.=0A=
=0A=
> You're literally echoing what code does or has in comments here. We=0A=
> can see the code by looking at the code.=0A=
>=0A=
> Please try to use less LLMs and use more of your own words for=0A=
> describing the changes or writing comments.=0A=
>=0A=
> Patch description could literally have been around two sentences=0A=
> about reducing the amount of unnecessary flushing.=0A=
=0A=
Fair point. I'll keep the v5 changelog focused on the problem being address=
ed and the proposed fix, rather than restating what is already apparent fro=
m the code.=0A=
=0A=
> Definitely no Fixes tag for what is essentially an optimization.=0A=
=0A=
Agreed. I'll drop the Fixes tag.=0A=
=0A=
I will post v5.=0A=
=0A=
Krishna=0A=
