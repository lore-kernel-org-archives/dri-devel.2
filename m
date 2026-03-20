Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617F510987A4
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5842410EB2B;
	Fri, 20 Mar 2026 16:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="j7GSINz6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C855B10EB2B;
 Fri, 20 Mar 2026 16:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774023781; x=1805559781;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=VtsCX+HQ6+9ulQYfxUO4qErFXAc/WffPxp/otgm8beY=;
 b=j7GSINz6kDg1ZLrXJBvO8j/SX1WM0MrSjr46oMk85kguTyQtUCVJ+1X+
 BaWjgpz1yeiquM9HshsgwOjVw1HKdf9S4t8CRhUXB4RsRr9aCIbpvo1fU
 hbIOavfVIzwadAe3QEW+YQaASvEufvnjdDxCxCu0uVZwdh3Fvi8V87JMX
 yeVTSoaWl3lQRogkX8PJCNGnGeQ3va6mrhv/xcVWlMNdEeLM5Qf73kaL6
 X+mUC6q7Qh7aK4ZmF76XRQ1dMMg0lAhohlEqNdVlMb8xG0VaIkXktEXHT
 ABU7nC8LzfKtSadw3DAgTe/fIe3Lh7oCJkstBSOAHNvlFbTwk50aB/0Kz g==;
X-CSE-ConnectionGUID: AUfNB9aVSJ+Vg8FALxSfww==
X-CSE-MsgGUID: 30cu6HAGSfunB/YjR7bRKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="62672334"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="62672334"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 09:23:00 -0700
X-CSE-ConnectionGUID: 24vQKgJUSl2ftnC81pi5bw==
X-CSE-MsgGUID: Y85QH8VeQTOpiq6BL5FjSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="222560554"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 09:23:00 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 09:22:59 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 09:22:59 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.38)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 09:22:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNG4a/vTKuy4ZgJI9hJHC2rUZYg9kzSan4j6txAoZd6wovmOYUdSpsaUIKjVaj+/ELucRt1P0gWY7YBzvq4LgpaMRXAME2rhzWQe7XX8tPB83BeOhjX725lM20BUSOAZ3fgKd5qKFuJ1wi5pve6qUVtHEK6WrPwu0ivdXwT6JvsFcevnoR6h+zdJX0wiAsDhSnIdYdu4PyOQGEgY8O8CUxY0NqZDniRSfPZ+VG/lve0vY0i3/+RSZ+44RZfKXy78QeYKA+XfoegGDfo6i/lECTGIaroN2JM44kVzxN5ckIIViarwP5AmXBuHGXsttitzudFVi0/UCeA1YuwG5i6EPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtsCX+HQ6+9ulQYfxUO4qErFXAc/WffPxp/otgm8beY=;
 b=nw8Otjm3Q/Tc6ZJsXgT5WFUa/ZY8+LrU9e/tXj2AY/0PETLU5K0cR8yrT2DCxe1p2ywGMagkpzTQz2XUcWVZhe4CVsZi1YQt/hahkmHZFhkLhEvu2P3cHY9owoyFol4LamMBTawRmVJ1RkSE/JHgI/3gNcVVCVSz/cZOQQpjy/32GLibn/CihyH1+4+dxRqHqxcwhaM1CgViEdF82hpqa9FuluehOISODK6pZTkGKPGSS6R8Wj7ShoX/d1PMLDvXPnQbVSLS3gVh05YytvIjlxkzbQKosRvXbztexhdg2RR1vnz3GJV7we4yGjzXEyQQmWkelclQUZFMCRlf9TmJbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22)
 by BN9PR11MB5274.namprd11.prod.outlook.com (2603:10b6:408:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Fri, 20 Mar
 2026 16:22:54 +0000
Received: from DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::7396:3750:f6eb:4765]) by DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::7396:3750:f6eb:4765%5]) with mapi id 15.20.9745.012; Fri, 20 Mar 2026
 16:22:54 +0000
From: "Souza, Jose" <jose.souza@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
CC: "Lin, Shuicheng" <shuicheng.lin@intel.com>, "Gupta, Saurabhg"
 <saurabhg.gupta@intel.com>, "Jadav, Raag" <raag.jadav@intel.com>, "Mrozek,
 Michal" <michal.mrozek@intel.com>, "Auld, Matthew" <matthew.auld@intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "Brost,
 Matthew" <matthew.brost@intel.com>, "Briano, Ivan" <ivan.briano@intel.com>,
 "Zuo, Alex" <alex.zuo@intel.com>, "Wajdeczko, Michal"
 <Michal.Wajdeczko@intel.com>, "Zhang, Jianxun" <jianxun.zhang@intel.com>
Subject: Re: [PATCH v36 2/4] drm/xe/uapi: Define drm_xe_vm_get_property
Thread-Topic: [PATCH v36 2/4] drm/xe/uapi: Define drm_xe_vm_get_property
Thread-Index: AQHcrYHONfZJyVxHiEOe0KOz+n7VZrWmsFQAgBEAGIA=
Date: Fri, 20 Mar 2026 16:22:53 +0000
Message-ID: <0d374f16c93c9f15e948b135645e6e18ea6f4dc7.camel@intel.com>
References: <20260306155556.67500-6-jonathan.cavitt@intel.com>
 <20260306155556.67500-8-jonathan.cavitt@intel.com>
 <b1bda5d1bd13d5a802de3f5a274f5ae40e84572b.camel@intel.com>
In-Reply-To: <b1bda5d1bd13d5a802de3f5a274f5ae40e84572b.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB8179:EE_|BN9PR11MB5274:EE_
x-ms-office365-filtering-correlation-id: 3f3a495b-3dbc-439b-5055-08de869cf066
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: cn1YEoHOfU41HihmZKChnahg4cLo1Xjk1e1ibtOiiDUhuvP6FgXhcd0tLGA3Nyii2VfAhSqVaNlb6HqgcVbmlwpgHdDhQJcsy0lQVjdOmhrhSyCVojrsSaEXKiLeDsvFHPd9sotiWJwJk3Jm3ySz3AypmJbIIw5KHYkRTXXMFq5i6tfdRO7XtZeouYAgrLone1j01SiXPUNM0KmMT0mVnWqwmvMZaD74pklFBV50KNHCXITFie9w+fnb79ZAHrFbdKjYQ1p0S8xqAGOjZ426NJlSVm+nxgmjxFZyxv6X56oYLTGRgC4hps1cd9owRBHV0oerTafiooNhJvUnTeoEdnpnEDqW85pFd61ldNfzVsJoTU3ylz7QcXJvmzJ79A40VmAh/gmAILIV+WEeHKpYgwOaiAxowNxbxm/P1LYvm1pikn7yJcIKPMR/ZyvcrMlMrtkfAvoNJYLRyGuuNjf3XCK4gqh+1jhSjYi6/lYyObywOXwA9ZZt4IuDZVbx14zEawE4VL7Er/NZviOtSv/pNyr2AN9qxRzDoS0pVS28LCapjvNGtIu6JUgKPMmhPwGRWMdIMEdvtYCG71Fgl3h4nVwxYaF8+n6IwDV66IfRygRdWhDsTJ5xmE3CjVprFf4OrXJsFu6j6VmE4gHwCkbHTCURiLigOxp13/Y5WeNFlie66Rzy9tiiVsS0MPvxWqpVTvV+iR9hGrjFDMPHPxpqnePYMnOdHk7GmSbcfgBS8nRhiz/1KPmbML/F+Q//NGZS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB8179.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czRiNDkxMERnclV6NDNDdGdVWS9HZVB2a1M4NHd3WWJFeVJhZ1EwUTlvVnlU?=
 =?utf-8?B?WUdqQkJqRklaUVo5ZHlKMk1XeUNuNXBMMi96dStIbG9VNHd5dUZBVkVDejRz?=
 =?utf-8?B?RFBzT1ZqMmxqeC9lNys4UlFCRmhQazBOQjZnV0JLdW9FMXR1cEpxWThqak5C?=
 =?utf-8?B?ZmlZQlZTeTlXeHZKNmh2bmFkYVNoRFA0QjdyQkNzNmR3ZjBicmJKTlRhWFNO?=
 =?utf-8?B?RDJPUDJmT1JNRzZUY2Vxa2E5dlZ6OXI4NUNWZU5mcEgwOFdRT1Y3RG9uR0V3?=
 =?utf-8?B?elh1djAxQ084eWVsdGlKNmRxcTF6dXg3V29nQ3dnalkvNHh2WkZLa00xdnhV?=
 =?utf-8?B?dTJ6Q2xPTk5qdGR3LzNBeXdDVFl2bW5yK1dyMndFSDNsYm1sK01ZelY1WnNi?=
 =?utf-8?B?TVZXVHlEU2swT1FyeG8vaUNiYVg3Q202MzhMdmp3V0Z6MFprcWZyNmFsUVlD?=
 =?utf-8?B?eGdMUFJxTUVBbkpEUU5YcjZqczZkWUIrdW5sbEorWm9Da1hBZklvYmszRGQ0?=
 =?utf-8?B?V2RBaGdjejY0cjhZV3NxdmJGL2JGK05oMjFsOHNiUDd6eGpGUU93Rk0yVkI5?=
 =?utf-8?B?cWRRUTFOVlhYeXJSb2ZnelN3ekVHeVVWWDNXa2E5U0p5U1ErbjdzNUM3L1oz?=
 =?utf-8?B?Uy9CMVpmODFlVE9hSUJLWnNNaXRFYnNPcks5UXpCUVhFSE1KaSt4U1FPUkJn?=
 =?utf-8?B?cUFsTjBvQTJ3eFlZY3QyQkFMZFovek5qczJYdWVsRHlGNnM1aURtY2xBZU1T?=
 =?utf-8?B?UVR2MmlUSjJJNnZlak9WZEZQM043MG9xMTFzRGkzRkNYZHF6Nit6dzY1ZlJl?=
 =?utf-8?B?Lzh4cFpVQ2I2K21rNHoybGptTDBKNHNTNXBhdzkxNlNhaDVwNzVGdjlvYXpl?=
 =?utf-8?B?QzZ6NzJPNld6OEhocjdyekpBWThwcXdkendOeEVaaGZXbTg4MytLOXl0Nmts?=
 =?utf-8?B?UjRHU0hCSmlTaGZKRENzTWgrZnMwQWJYVVRQS3BSWWZuc3haZmU5Nlg2bU04?=
 =?utf-8?B?Y1RRU0lTdFU5cEFIa1o4QW9hWSs5Z2ZCajdRVkxNb3lkNm5xOURwRnpTejRU?=
 =?utf-8?B?d3QycnF2TUVjTGlQK1Q5cjcrTUdyb1NzMjBOMkszVkcvN0U0VDc1elVXRWRo?=
 =?utf-8?B?THZyRkV4Z1RXY1NJKzdHQWQ4L3ZWckRWaldtV29JNHA4WDJ6am1PRXl0NlNH?=
 =?utf-8?B?MGdzNUg5WWlJY0xKOTl1bVZBRkpyKzJrMi9JV1JnRzRES3dxcXpoK2pQNnpG?=
 =?utf-8?B?amZYM2FyZTFLSXZPajFwKzBzdWZvN3lwSjR4elAxZ1crbDVQQlhtRjFaeFRi?=
 =?utf-8?B?cjVyMmt3ZlpzVHdicWhGbjRKc1JVWjl3VzJxMFEwUWlpMG5vbHlvZlVabnBi?=
 =?utf-8?B?QUV6NHFYOWRXYlJEM2FocU9kV0ZjY0t3bkk1elhTanNIMVJnWUJwWUZWdDdW?=
 =?utf-8?B?N2wwZ3hOR21WQjFBdENWRWFHeVlNRXIvbDRpUzAxK25iTXo4VXI5NHh2Qzhz?=
 =?utf-8?B?a0xMazJBK2oxbE5hWEhha0xhVU01OEptSFgwY2oyN2NCaFp1L0Izc00yb1lO?=
 =?utf-8?B?SitDS3hPbVJkaS9yTVl6dkxYSVIxNUMvcitwVjg1YzU2YXppYTFITXdxcWJk?=
 =?utf-8?B?T0Z3WU1QTnd6cDdYR2d4cjFJZC8vMis2UCszdUsvMk0xMDk2UERxaWZESVIz?=
 =?utf-8?B?aEsyOWRaV0NzRkYwUGlkTHY5ZDI4TGprSHBwbjRQT0VRVlF1ZGkwNnNLZnlp?=
 =?utf-8?B?dTh4alhZSGZTK3lsUnNJK085NGdtRGtYNkRDc2FPUm50ZThqdHFUd2lWdzJI?=
 =?utf-8?B?SEZheFVjUFpubFlFSHp0dW43bnkvbHFqUTJEZE1LRHpmcHp4NFpmc1psamp1?=
 =?utf-8?B?Q2dJQTFEaEpRc09MQTVPWlNmQkpwL1ZEbit6Qi80VU1oejRtQ1FkK0JqU1Rn?=
 =?utf-8?B?dGpmd0d4dTVwendlUVc4QlFTWDBCREpTMkRJeEhnZEZxaXZSMjkxMXI2SzBv?=
 =?utf-8?B?c3M2M0hBQ1Z2dkdpVkZ0UGFxVmFjOW9vczM0b1p5bUlWK3Jidk5tTFo5QkJJ?=
 =?utf-8?B?WlRJNEs3T0FJN2lzNmR3Qm9ZY24zSGgyUXo0UTFmUmszaXhMeitoMkRwRjI3?=
 =?utf-8?B?SlNKQ3FRcDJKUEVpcGtBcXVyN3RveUR6U1RlUmVVcnJEWWROL0cvVXhSZVNT?=
 =?utf-8?B?cXZxMy85MVJaOFNmRGRIQUZYdU5mSDkybzFMdzF5R0I2M3NkOENGTFNlVjM0?=
 =?utf-8?B?SytNT082ckhhWHJnSFZCeHBMVjd3Sy9FNWFHSVZhTFd5TDZZYlNDcGVUd01B?=
 =?utf-8?B?N045bDB1Rm01TFRCbWxoQUpHK3YyclcvN0dFOExCaGZNci9lbkp4Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1297953825560745BC6C0A0929E0685C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Kx8JCR4x2pKNLBnuTrR1ffjnJaaMYdbED3SXn7kNGtU1LyHZaoTl1G+rGhuFXk7Pn6PU77EuKVShOOFgF1mZH6AgvQZgAJNCh1eYY21Kiwj0zPFh2AxYBjsoLVDxq3J95RBQ8a3E3GRKqTLvXufkjR6AoYzTwV1/MgaKhMQiVbG1x6hfxA6CwLSECO2K4jXms+Fezh9eFAYDfsIaCUmF6ru6gQLgWZsVMz5LcgHYuAhO1EDZj170iiK8YIuWSgGebLL0EK5dg3CSgfGv+20+WYR+GYVs57GYjEmFw2BhxpAdK2RR8tSs3HKf2CVcA+Uh9s+VNEZ8Sh6ZDi0cbicpLQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3a495b-3dbc-439b-5055-08de869cf066
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 16:22:53.9049 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDC1Wx4Yp6h4e6PaL8XhBvlm3lFuFwaA8QOfEpr/JOt8+mmrr66wlpNv6OsFJf10cWGSmvpjKA9/2BBu5fPoqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5274
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

T24gTW9uLCAyMDI2LTAzLTA5IGF0IDIwOjQ1ICswMDAwLCBTb3V6YSwgSm9zZSB3cm90ZToNCj4g
T24gRnJpLCAyMDI2LTAzLTA2IGF0IDE1OjU1ICswMDAwLCBKb25hdGhhbiBDYXZpdHQgd3JvdGU6
DQo+ID4gQWRkIGluaXRpYWwgZGVjbGFyYXRpb25zIGZvciB0aGUgZHJtX3hlX3ZtX2dldF9wcm9w
ZXJ0eSBpb2N0bC4NCj4gPiANCj4gPiB2MjoNCj4gPiAtIEV4cGFuZCBrZXJuZWwgZG9jcyBmb3Ig
ZHJtX3hlX3ZtX2dldF9wcm9wZXJ0eSAoSmlhbnh1bikNCj4gPiANCj4gPiB2MzoNCj4gPiAtIFJl
bW92ZSBhZGRyZXNzIHR5cGUgZXh0ZXJuYWwgZGVmaW5pdGlvbnMgKEppYW54dW4pDQo+ID4gLSBB
ZGQgZmF1bHQgdHlwZSB0byB4ZV9kcm1fZmF1bHQgc3RydWN0IChKaWFueHVuKQ0KPiA+IA0KPiA+
IHY0Og0KPiA+IC0gUmVtb3ZlIGVuZ2luZSBjbGFzcyBhbmQgaW5zdGFuY2UgKEl2YW4pDQo+ID4g
DQo+ID4gdjU6DQo+ID4gLSBBZGQgZGVjbGFyZXMgZm9yIGZhdWx0IHR5cGUsIGFjY2VzcyB0eXBl
LCBhbmQgZmF1bHQgbGV2ZWwgKE1hdHQNCj4gPiBCcm9zdCwNCj4gPiDCoCBJdmFuKQ0KPiA+IA0K
PiA+IHY2Og0KPiA+IC0gRml4IGluY29uc2lzdGVudCB1c2Ugb2Ygd2hpdGVzcGFjZSBpbiBkZWZp
bmVzDQo+ID4gDQo+ID4gdjc6DQo+ID4gLSBSZWJhc2UgYW5kIHJlZmFjdG9yIChqY2F2aXR0KQ0K
PiA+IA0KPiA+IHY4Og0KPiA+IC0gUmViYXNlIChqY2F2aXR0KQ0KPiA+IA0KPiA+IHVBUEk6IGh0
dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC9jb21wdXRlLXJ1bnRpbWUvcHVsbC84NzgNCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKb25hdGhhbiBDYXZpdHQgPGpvbmF0aGFuLmNhdml0dEBpbnRlbC5jb20+DQo+
ID4gUmV2aWV3ZWQtYnk6IFNodWljaGVuZyBMaW4gPHNodWljaGVuZy5saW5AaW50ZWwuY29tPg0K
PiA+IEFja2VkLWJ5OiBNYXR0aGV3IEJyb3N0IDxtYXR0aGV3LmJyb3N0QGludGVsLmNvbT4NCj4g
PiBBY2tlZC1ieTogSXZhbiBCcmlhbm8gPGl2YW4uYnJpYW5vQGludGVsLmNvbT4NCj4gPiBDYzog
WmhhbmcgSmlhbnh1biA8amlhbnh1bi56aGFuZ0BpbnRlbC5jb20+DQo+ID4gQ2M6IEl2YW4gQnJp
YW5vIDxpdmFuLmJyaWFub0BpbnRlbC5jb20+DQo+ID4gQ2M6IE1hdHRoZXcgQnJvc3QgPG1hdHRo
ZXcuYnJvc3RAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+IMKgaW5jbHVkZS91YXBpL2RybS94ZV9k
cm0uaCB8IDg2DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gwqAxIGZpbGUgY2hhbmdlZCwgODYgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL3VhcGkvZHJtL3hlX2RybS5oIGIvaW5jbHVkZS91YXBpL2RybS94ZV9kcm0u
aA0KPiA+IGluZGV4IGIwMjY0YzMyY2ViMi4uYmUyN2U5YzQ1MzMzIDEwMDY0NA0KPiA+IC0tLSBh
L2luY2x1ZGUvdWFwaS9kcm0veGVfZHJtLmgNCj4gPiArKysgYi9pbmNsdWRlL3VhcGkvZHJtL3hl
X2RybS5oDQo+ID4gQEAgLTgzLDYgKzgzLDcgQEAgZXh0ZXJuICJDIiB7DQo+ID4gwqAgKsKgIC0g
JkRSTV9JT0NUTF9YRV9PQlNFUlZBVElPTg0KPiA+IMKgICrCoCAtICZEUk1fSU9DVExfWEVfTUFE
VklTRQ0KPiA+IMKgICrCoCAtICZEUk1fSU9DVExfWEVfVk1fUVVFUllfTUVNX1JBTkdFX0FUVFJT
DQo+ID4gKyAqwqAgLSAmRFJNX0lPQ1RMX1hFX1ZNX0dFVF9QUk9QRVJUWQ0KPiA+IMKgICovDQo+
ID4gwqANCj4gPiDCoC8qDQo+ID4gQEAgLTEwNyw2ICsxMDgsNyBAQCBleHRlcm4gIkMiIHsNCj4g
PiDCoCNkZWZpbmUgRFJNX1hFX01BRFZJU0UJCQkweDBjDQo+ID4gwqAjZGVmaW5lIERSTV9YRV9W
TV9RVUVSWV9NRU1fUkFOR0VfQVRUUlMJMHgwZA0KPiA+IMKgI2RlZmluZSBEUk1fWEVfRVhFQ19R
VUVVRV9TRVRfUFJPUEVSVFkJMHgwZQ0KPiA+ICsjZGVmaW5lIERSTV9YRV9WTV9HRVRfUFJPUEVS
VFkJCTB4MGYNCj4gPiDCoA0KPiA+IMKgLyogTXVzdCBiZSBrZXB0IGNvbXBhY3QgLS0gbm8gaG9s
ZXMgKi8NCj4gPiDCoA0KPiA+IEBAIC0xMjUsNiArMTI3LDcgQEAgZXh0ZXJuICJDIiB7DQo+ID4g
wqAjZGVmaW5lDQo+ID4gRFJNX0lPQ1RMX1hFX01BRFZJU0UJCQlEUk1fSU9XKERSTV9DT01NQU5E
X0JBU0UgKw0KPiA+IERSTV9YRV9NQURWSVNFLCBzdHJ1Y3Rkcm1feGVfbWFkdmlzZSkNCj4gPiDC
oCNkZWZpbmUNCj4gPiBEUk1fSU9DVExfWEVfVk1fUVVFUllfTUVNX1JBTkdFX0FUVFJTCURSTV9J
T1dSKERSTV9DT01NQU5EX0JBU0UNCj4gPiArDQo+ID4gRFJNX1hFX1ZNX1FVRVJZX01FTV9SQU5H
RV9BVFRSUyxzdHJ1Y3Rkcm1feGVfdm1fcXVlcnlfbWVtX3JhbmdlX2F0dA0KPiA+IHIpDQo+ID4g
wqAjZGVmaW5lDQo+ID4gRFJNX0lPQ1RMX1hFX0VYRUNfUVVFVUVfU0VUX1BST1BFUlRZCURSTV9J
T1coRFJNX0NPTU1BTkRfQkFTRSArDQo+ID4gRFJNX1hFX0VYRUNfUVVFVUVfU0VUX1BST1BFUlRZ
LHN0cnVjdGRybV94ZV9leGVjX3F1ZXVlX3NldF9wcm9wZXJ0eQ0KPiA+ICkNCj4gPiArI2RlZmlu
ZQ0KPiA+IERSTV9JT0NUTF9YRV9WTV9HRVRfUFJPUEVSVFkJCURSTV9JT1dSKERSTV9DT01NQU5E
X0JBU0UNCj4gPiArIERSTV9YRV9WTV9HRVRfUFJPUEVSVFksc3RydWN0ZHJtX3hlX3ZtX2dldF9w
cm9wZXJ0eSkNCj4gDQo+IFdhcyB0aGUgb3B0aW9uIHRvIHVzZSBEUk1fSU9DVExfWEVfREVWSUNF
X1FVRVJZIGRpc2N1c3NlZD8gV2UgY291bGQNCj4gYWRkDQo+IGEgZXh0ZW5zaW9uIHRvIHBhc3Mg
dGhlIFZNIGlkIGFuZCBhdm9pZCBhZGQgYW5vdGhlciB1QVBJLg0KPiANCj4gPiDCoA0KPiA+IMKg
LyoqDQo+ID4gwqAgKiBET0M6IFhlIElPQ1RMIEV4dGVuc2lvbnMNCj4gPiBAQCAtMTI0OSw2ICsx
MjUyLDg5IEBAIHN0cnVjdCBkcm1feGVfdm1fYmluZCB7DQo+ID4gwqAJX191NjQgcmVzZXJ2ZWRb
Ml07DQo+ID4gwqB9Ow0KPiA+IMKgDQo+ID4gKy8qKiBzdHJ1Y3QgeGVfdm1fZmF1bHQgLSBEZXNj
cmliZXMgZmF1bHRzIGZvcg0KPiA+ICVEUk1fWEVfVk1fR0VUX1BST1BFUlRZX0ZBVUxUUyAqLw0K
PiA+ICtzdHJ1Y3QgeGVfdm1fZmF1bHQgew0KPiA+ICsJLyoqIEBhZGRyZXNzOiBBZGRyZXNzIG9m
IHRoZSBmYXVsdCAqLw0KPiA+ICsJX191NjQgYWRkcmVzczsNCj4gDQo+IExvb2tzIGxpa2UgdGhl
IGFkZHJlc3MgcmV0dXJuZWQgaXMgbm90IGluIGNhbm9uaWNhbCBmb3JtYXQuIEp1c3QgdG8NCj4g
bWFrZSBjbGVhciwgcGxlYXNlIGFkZCBpdCB0byB0aGUgY29tbWVudC4NCg0KUGxlYXNlIGFkZCBh
IGNvbW1lbnQgaGVyZSBtYWtpbmcgaXQgZXhwbGljaXQgdGhhdCB0aGlzIGFkZHJlc3MgaXMgaW4N
CmNhbm9uaWNhbCBmb3JtYXQuDQoNCldpdGggdGhhdDogQWNrZWQtYnk6IEpvc8OpIFJvYmVydG8g
ZGUgU291emEgPGpvc2Uuc291emFAaW50ZWwuY29tPg0KDQo+IA0KPiA+ICsJLyoqIEBhZGRyZXNz
X3ByZWNpc2lvbjogUHJlY2lzaW9uIG9mIGZhdWx0ZWQgYWRkcmVzcyAqLw0KPiA+ICsJX191MzIg
YWRkcmVzc19wcmVjaXNpb247DQo+ID4gKwkvKiogQGFjY2Vzc190eXBlOiBUeXBlIG9mIGFkZHJl
c3MgYWNjZXNzIHRoYXQgcmVzdWx0ZWQgaW4NCj4gPiBmYXVsdCAqLw0KPiA+ICsjZGVmaW5lIEZB
VUxUX0FDQ0VTU19UWVBFX1JFQUQJCTANCj4gPiArI2RlZmluZSBGQVVMVF9BQ0NFU1NfVFlQRV9X
UklURQkJMQ0KPiA+ICsjZGVmaW5lIEZBVUxUX0FDQ0VTU19UWVBFX0FUT01JQwkyDQo+IA0KPiBJ
IGNvbmZpcm1lZCB3aXRoIEpvbmF0aGFuIGFuZCB0aGlzIGFuZCBhY2Nlc3NfdHlwZSBhcmUgbm90
IGEgYml0DQo+IG1hc2suDQo+IA0KPiA+ICsJX191OCBhY2Nlc3NfdHlwZTsNCj4gPiArCS8qKiBA
ZmF1bHRfdHlwZTogVHlwZSBvZiBmYXVsdCByZXBvcnRlZCAqLw0KPiA+ICsjZGVmaW5lIEZBVUxU
X1RZUEVfTk9UX1BSRVNFTlQJCTANCj4gPiArI2RlZmluZSBGQVVMVF9UWVBFX1dSSVRFX0FDQ0VT
UwkJMQ0KPiA+ICsjZGVmaW5lIEZBVUxUX1RZUEVfQVRPTUlDX0FDQ0VTUwkyDQo+ID4gKwlfX3U4
IGZhdWx0X3R5cGU7DQo+ID4gKwkvKiogQGZhdWx0X2xldmVsOiBmYXVsdCBsZXZlbCBvZiB0aGUg
ZmF1bHQgKi8NCj4gPiArI2RlZmluZSBGQVVMVF9MRVZFTF9QVEUJCTANCj4gPiArI2RlZmluZSBG
QVVMVF9MRVZFTF9QREUJCTENCj4gPiArI2RlZmluZSBGQVVMVF9MRVZFTF9QRFAJCTINCj4gPiAr
I2RlZmluZSBGQVVMVF9MRVZFTF9QTUw0CTMNCj4gPiArI2RlZmluZSBGQVVMVF9MRVZFTF9QTUw1
CTQNCj4gPiArCV9fdTggZmF1bHRfbGV2ZWw7DQo+ID4gKwkvKiogQHBhZDogTUJaICovDQo+ID4g
KwlfX3U4IHBhZDsNCj4gPiArCS8qKiBAcmVzZXJ2ZWQ6IE1CWiAqLw0KPiA+ICsJX191NjQgcmVz
ZXJ2ZWRbNF07DQo+ID4gK307DQo+ID4gKw0KPiA+ICsvKioNCj4gPiArICogc3RydWN0IGRybV94
ZV92bV9nZXRfcHJvcGVydHkgLSBJbnB1dCBvZg0KPiA+ICZEUk1fSU9DVExfWEVfVk1fR0VUX1BS
T1BFUlRZDQo+ID4gKyAqDQo+ID4gKyAqIFRoZSB1c2VyIHByb3ZpZGVzIGEgVk0gYW5kIGEgcHJv
cGVydHkgdG8gcXVlcnkgYW1vbmcNCj4gPiBEUk1fWEVfVk1fR0VUX1BST1BFUlRZXyosDQo+ID4g
KyAqIGFuZCBzZXRzIHRoZSB2YWx1ZXMgaW4gdGhlIHZtX2lkIGFuZCBwcm9wZXJ0eSBtZW1iZXJz
LA0KPiA+IHJlc3BlY3RpdmVseS7CoCBUaGlzDQo+ID4gKyAqIGRldGVybWluZXMgYm90aCB0aGUg
Vk0gdG8gZ2V0IHRoZSBwcm9wZXJ0eSBvZiwgYXMgd2VsbCBhcyB0aGUNCj4gPiBwcm9wZXJ0eSB0
bw0KPiA+ICsgKiByZXBvcnQuDQo+ID4gKyAqDQo+ID4gKyAqIElmIHNpemUgaXMgc2V0IHRvIDAs
IHRoZSBkcml2ZXIgZmlsbHMgaXQgd2l0aCB0aGUgcmVxdWlyZWQgc2l6ZQ0KPiA+IGZvciB0aGUN
Cj4gPiArICogcmVxdWVzdGVkIHByb3BlcnR5LsKgIFRoZSB1c2VyIGlzIGV4cGVjdGVkIGhlcmUg
dG8gYWxsb2NhdGUNCj4gPiBtZW1vcnkNCj4gPiBmb3IgdGhlDQo+ID4gKyAqIHByb3BlcnR5IHN0
cnVjdHVyZSBhbmQgdG8gcHJvdmlkZSBhIHBvaW50ZXIgdG8gdGhlIGFsbG9jYXRlZA0KPiA+IG1l
bW9yeSB1c2luZyB0aGUNCj4gPiArICogZGF0YSBtZW1iZXIuwqAgRm9yIHNvbWUgcHJvcGVydGll
cywgdGhpcyBtYXkgYmUgemVybywgaW4gd2hpY2gNCj4gPiBjYXNlLCB0aGUNCj4gPiArICogdmFs
dWUgb2YgdGhlIHByb3BlcnR5IHdpbGwgYmUgc2F2ZWQgdG8gdGhlIHZhbHVlIG1lbWJlciBhbmQN
Cj4gPiBzaXplDQo+ID4gd2lsbCByZW1haW4NCj4gPiArICogemVybyBvbiByZXR1cm4uDQo+ID4g
KyAqDQo+ID4gKyAqIElmIHNpemUgaXMgbm90IHplcm8sIHRoZW4gdGhlIElPQ1RMIHdpbGwgYXR0
ZW1wdCB0byBjb3B5IHRoZQ0KPiA+IHJlcXVlc3RlZA0KPiA+ICsgKiBwcm9wZXJ0eSBpbnRvIHRo
ZSBkYXRhIG1lbWJlci4NCj4gPiArICoNCj4gPiArICogVGhlIElPQ1RMIHdpbGwgcmV0dXJuIC1F
Tk9FTlQgaWYgdGhlIFZNIGNvdWxkIG5vdCBiZSBpZGVudGlmaWVkDQo+ID4gZnJvbSB0aGUNCj4g
PiArICogcHJvdmlkZWQgVk0gSUQsIG9yIC1FSU5WQUwgaWYgdGhlIElPQ1RMIGZhaWxzIGZvciBh
bnkgb3RoZXINCj4gPiByZWFzb24sIHN1Y2ggYXMNCj4gPiArICogcHJvdmlkaW5nIGFuIGludmFs
aWQgc2l6ZSBmb3IgdGhlIGdpdmVuIHByb3BlcnR5IG9yIGlmIHRoZQ0KPiA+IHByb3BlcnR5IGRh
dGENCj4gPiArICogY291bGQgbm90IGJlIGNvcGllZCB0byB0aGUgbWVtb3J5IGFsbG9jYXRlZCB0
byB0aGUgZGF0YSBtZW1iZXIuDQo+ID4gKyAqDQo+ID4gKyAqIFRoZSBwcm9wZXJ0eSBtZW1iZXIg
Y2FuIGJlOg0KPiA+ICsgKsKgIC0gJURSTV9YRV9WTV9HRVRfUFJPUEVSVFlfRkFVTFRTDQo+ID4g
KyAqLw0KPiA+ICtzdHJ1Y3QgZHJtX3hlX3ZtX2dldF9wcm9wZXJ0eSB7DQo+ID4gKwkvKiogQGV4
dGVuc2lvbnM6IFBvaW50ZXIgdG8gdGhlIGZpcnN0IGV4dGVuc2lvbiBzdHJ1Y3QsIGlmDQo+ID4g
YW55ICovDQo+ID4gKwlfX3U2NCBleHRlbnNpb25zOw0KPiA+ICsNCj4gPiArCS8qKiBAdm1faWQ6
IFRoZSBJRCBvZiB0aGUgVk0gdG8gcXVlcnkgdGhlIHByb3BlcnRpZXMgb2YgKi8NCj4gPiArCV9f
dTMyIHZtX2lkOw0KPiA+ICsNCj4gPiArI2RlZmluZSBEUk1fWEVfVk1fR0VUX1BST1BFUlRZX0ZB
VUxUUwkJMA0KPiA+ICsJLyoqIEBwcm9wZXJ0eTogcHJvcGVydHkgdG8gZ2V0ICovDQo+ID4gKwlf
X3UzMiBwcm9wZXJ0eTsNCj4gPiArDQo+ID4gKwkvKiogQHNpemU6IFNpemUgdG8gYWxsb2NhdGUg
Zm9yIEBkYXRhICovDQo+ID4gKwlfX3UzMiBzaXplOw0KPiA+ICsNCj4gPiArCS8qKiBAcGFkOiBN
QlogKi8NCj4gPiArCV9fdTMyIHBhZDsNCj4gPiArDQo+ID4gKwl1bmlvbiB7DQo+ID4gKwkJLyoq
IEBkYXRhOiBQb2ludGVyIHRvIHVzZXItZGVmaW5lZCBhcnJheSBvZg0KPiA+IGZsZXhpYmxlDQo+
ID4gc2l6ZSBhbmQgdHlwZSAqLw0KPiA+ICsJCV9fdTY0IGRhdGE7DQo+ID4gKwkJLyoqIEB2YWx1
ZTogUmV0dXJuIHZhbHVlIGZvciBzY2FsYXIgcXVlcmllcyAqLw0KPiA+ICsJCV9fdTY0IHZhbHVl
Ow0KPiA+ICsJfTsNCj4gPiArDQo+ID4gKwkvKiogQHJlc2VydmVkOiBNQlogKi8NCj4gPiArCV9f
dTY0IHJlc2VydmVkWzNdOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiDCoC8qKg0KPiA+IMKgICogc3Ry
dWN0IGRybV94ZV9leGVjX3F1ZXVlX2NyZWF0ZSAtIElucHV0IG9mDQo+ID4gJkRSTV9JT0NUTF9Y
RV9FWEVDX1FVRVVFX0NSRUFURQ0KPiA+IMKgICoNCg==
