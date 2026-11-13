Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C50C606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 23:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fb97Y8kS;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Li1zaMMK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B454B10E391;
	Fri, 13 Nov 2026 23:37:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5445110E159;
 Fri, 13 Nov 2026 23:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794613020; x=1826149020;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Mnsykt9VipQNgvJyO6p0oZWZAv0HPqShE1gyqu+qqyA=;
 b=fb97Y8kS2RAaZEVPDzft/89RweVVHhqH2er0cRLjMVGvxaoqMHf3X70D
 JZjfboPmSqe88dTiQiFkZqgL8/IV2FvG/BltFCOdPcxVoFfAVTG+5aL94
 vP/fsRHL5o1u/W3a/x+tT1yFgdXtsSf8KUBgZIRsaDEGiXtkahfrzQ5YC
 xyrhxuFm+MnwNSCKdjL7mAhuUuzUqP2TdKKZ3xgI/j1rw1Fs4WdUgTGUE
 kbnvJIeE4RELmhzsfCgLaylrAE2fIrxTes06lYScx63vEUFPvmG7joA4e
 DLMkler1svGS06KHp52vWWLzUePbs+8FYk2jrqzqMFXNCxXZ+1AVBnzU6 g==;
X-CSE-ConnectionGUID: 63xbjVLDRhqB7+AqAtrksQ==
X-CSE-MsgGUID: Qn52/z72SmWoLIkK4I+FYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3470699"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3470699"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 15:36:59 -0800
X-CSE-ConnectionGUID: oBhzryvnT/2R4t1MOckawQ==
X-CSE-MsgGUID: 7X6mod5FQUOL+pyu6699kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9365210"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 15:36:59 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 15:36:58 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 15:36:58 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 15:36:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqSPkpI9xDyYlnFbvg2dIWxGdjIrYj4YtR3pWH5PH4RHLlQG1u0Szq+GHieeFcIOIKfEUFkVRLdwuhy0UhyBaH9RxpvlhSuZ4P8+OilUoxPAxYkdwZlGM7wzwqHwIrJi2dfN85fRa7LDkf2sljq4z+cwKcsFNXgF4HfiH8moicwanrey5EGghGko9XMgIKy30p998mcFBKuyO+AncQIlkzfWuCP/jcUJPr4NXBmbfp9fZxKEMFrFdC64twoxYomTKXDDB8fFIFzUZFq8olWVvaylH1cpAi7m70HiksgUuzJmVHuxJ/iRuloeU/VBK5V+StIchzfBo92LfmJgmVatOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wXy+gi6O7EnYbVJbt5hcAHbMqB9p3ag5es5PQwL6Ps=;
 b=QICzic30ggLm/99zZfy4szkq2LQDz6QxUHjgYTuaQT/4lYLYOL7rRakkFzcnxIIkX7WmwB6DDA1eXDqQNvya+YI1pjWFHsstV2/mYxJ71nDBJA34gotU7MCgMkPuQm8/2B5bGk5Pb2+yC4YaIZ4bTGgupwC6USEikAOlO4sxiePKrfpCTmArOGxqbmaIFcpuDKhRXBgFBwHk9wNJMavGCOoj6funfMU+GXRnOc9mmYa4xICFwLHZ6wm3hPkGtbX+/wyREFSJoamhmRHMYSl45oM08kwNjtQYpTLMKzfZBSiP5V0uWVBmcR9ltS9g9cN3R7xeoEltGMsDvaLxSxi41A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wXy+gi6O7EnYbVJbt5hcAHbMqB9p3ag5es5PQwL6Ps=;
 b=Li1zaMMK5PptfxPBCtVoVg7ZT8fPRI+SIq4bNahY2YdxEKzsedzZ1BFRMICCpmof5XTgoWlAtsxgg0YhKgXSRzhQVR+baUNDNS52wMyYQMUhs5Yt49yhtIGB6m5PczpY7988yh8vOEjCLvIrcF2bTTLNd+trJ2MyAXqswM2h8HE=
Received: from IA1PR11MB6418.namprd11.prod.outlook.com (2603:10b6:208:3aa::18)
 by IA1PR11MB6492.namprd11.prod.outlook.com (2603:10b6:208:3a4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Fri, 13 Nov
 2026 23:36:42 +0000
Received: from IA1PR11MB6418.namprd11.prod.outlook.com
 ([fe80::b831:13bc:a1c9:2628]) by IA1PR11MB6418.namprd11.prod.outlook.com
 ([fe80::b831:13bc:a1c9:2628%3]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 23:36:41 +0000
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
Thread-Index: AQHdLSEDAM+rltzTuEeLf4YUWeJViLcpOQSAgACcCJyAANZzgIACTEcA
Date: Fri, 13 Nov 2026 23:36:40 +0000
Message-ID: <DS0PR11MB64231486880CB5D0458C19BFFA7F2@DS0PR11MB6423.namprd11.prod.outlook.com>
References: <20260816014552.14969-1-krishna.prabhakaran@intel.com>
 <179439387311.199148.11937438921736048164@jlahtine-mobl>
 <IA1PR11MB641869284E0505A68FF8E8E5FA712@IA1PR11MB6418.namprd11.prod.outlook.com>
 <179447343321.19032.17914586221108159466@jlahtine-mobl>
In-Reply-To: <179447343321.19032.17914586221108159466@jlahtine-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6418:EE_|IA1PR11MB6492:EE_
x-ms-office365-filtering-correlation-id: 14be2ff6-aa29-4695-357f-08df41def81d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|4143699003|10067099003|38070700021|11063799006|261009223027099003|261026121527099003|56012099006|261022075727099003;
x-microsoft-antispam-message-info: ZQ4FxV6hZvwhk0kvXAuBYJMnTs8K6CCYmMtzIAJ0VPclKPoyE1DaktyQg51fIjgFOHvvH37pdqiedJWyH/cUO8Z5dsc/dUPDS4oKTK9qkA+LhhRXx4JVbXN9B0rQTpPqo/VdONO7FKToetBbu28ecmgrwPzFW3fgUT4HzJfu40sILbBh1Y8RUG0q/JwzXwZbtPSujI0vjJ1DXTLBIymoH0Do9Wy8x7W1nCP2rR5K+4hg0jfWHPI+NA+loikdhqXWkI2UvqLHugrf4ijjARq5cbMDu3tUbe2ZvHfNbJd80v92azrB/Nc7uryNh2cz81trja3aYC2yCKz1U7+hJgdYWQhZAfrp7e6agbnwDaS/6zbwB7AKeGXHLNr+WcYNutZlIYgb4urM+MWhj8bh69X1MIQDPku0xUhfP8ymCeR8AypS01px1mFxt6W3/pWzG4+ymXisqszyXETW1j9ufhN76bsDmmxoQc4hD7NJUOPsLm0/P6zJUniViGrOXDOnLD0U/qzTy6kcvYyPOXjKAWn453btlDYyWi3Bljnj+aAnGvYxjMsope2JiM2zcW/KxDTBxbpnVSIEj9uneiYJ94pPaBc225x8ot7Ytw4B0dZkp0gg+lVCejft3xmfQwPUPcaVDZYeMSV4BEsYY3h3ja7wcr4rQQdgY+NM7HfQBl0KnaLcHtP7JqP6vhL1f4h1HcCnIoZkyqPAm+kF6ym75A689QJO/0JtjrybIo2OUqhRwBc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6418.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(10067099003)(38070700021)(11063799006)(261009223027099003)(261026121527099003)(56012099006)(261022075727099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qlhFAuquX0p2BkPCKmUoRSoB26XqW8nSbe9cbZHq3G4GwHbavWCXPML4n2?=
 =?iso-8859-1?Q?7gzgbKLN4HTTssoKBCgGbGjmdJrkWN3JcoENNDpDy4F9/xP9H+yyq0hZZ+?=
 =?iso-8859-1?Q?qGu8UBkXkXN//xqwnzwk4dlrH4lFTqjszZ64rFZe25+rtMVN+IMa3cqUva?=
 =?iso-8859-1?Q?I3BlyssFHJMM8umop7mS2YcXHuuETNCO8lkjrp+As6El2zKp1hzSzBtT+f?=
 =?iso-8859-1?Q?uyygpnou7M5mcqa/g39GQodQBw1h6rRWs2JwTvfquFmMOkXEpqosJYTEPU?=
 =?iso-8859-1?Q?AcfX7Xr4Jud2/2nMnFaZTWM76dQFh/QZzae2/KI3AzjMCuE8K9CDkL1D7R?=
 =?iso-8859-1?Q?OgBJN+eZfTTJ1M8Ouaa50yZRdursqotH1kQMXCphZO+48YM98cZw6vrmJ2?=
 =?iso-8859-1?Q?NrX/7tDTMr03dQCw29TJwWdIZRWedJCwSvg8pbOjR+5J5ST+AZlyPCxCAU?=
 =?iso-8859-1?Q?MAY4PB12k3QjOqOG+Tt6BEQ0V+ssFyv4UZWIy+6N3pZYPOildDuzcUePZG?=
 =?iso-8859-1?Q?why+VZWmdzbPvu27VPrzEyVuXa3meEoenE4mHo9bxFlMEM10ZQLOGcz0UE?=
 =?iso-8859-1?Q?vJjJ5zCMl2HiEXNIRdqNyjOkiAEPAcp26KoPManXFBnVwto1W5LzQQr/HD?=
 =?iso-8859-1?Q?OioWfD9RmYW2fPXCqN4r+WWzrkOmXu4rUUZ/TJ/ZOQDOFcBay0rTx/Qmpu?=
 =?iso-8859-1?Q?OZ15DvDDQ/3vKXTlfIfQ4RXoTVfhzktGgDCHac7DVihLG7ufsTYjyprIYO?=
 =?iso-8859-1?Q?kNvB+oiDMxoCpJnHcLQ0tL5D26FvkBjT0qKQP2RBOLXGoWS1tz3x6fG6n5?=
 =?iso-8859-1?Q?iRpk/vs+TE3aeeXClrqFXpupzSpMzq0/6BEu0avFFni03wFFh2BajIRfol?=
 =?iso-8859-1?Q?r3kA7+njnmqaoKCF5tGuwxAmngMCJUiQIX8WbqwQItSm33MnxarEIyIwFQ?=
 =?iso-8859-1?Q?0lPjnbhfQ4gyJumfds2TmDk+K/C/Lq1c5Y35shtTLAWUwY0rCuOVBdPOFO?=
 =?iso-8859-1?Q?qtJeKxq/9vQrLtA10Qfbmui91YVvDbzLLeep5N+vSBh302H5gQg0oOZdXF?=
 =?iso-8859-1?Q?EoQC9phaqeTqEtc4P8lIPbNLNVzwOUd+f+OihST7KnukQEKwGx8On1vSKO?=
 =?iso-8859-1?Q?6rumS/3TRk56NcMq7wvudL//+/EipcfQxuX0jW406S/+Ljxo9XHQyqtc80?=
 =?iso-8859-1?Q?ZeIOAv1tFi7WuQpMdnybUotD/o6j1PTBo9kgmwkTRM2USB7/75OhaVUtuw?=
 =?iso-8859-1?Q?GFEwXmDWNbOoxV9NkLkJ7K2jEjXbxCv3zDKtscojUZEXafmkYLAw1AEtdI?=
 =?iso-8859-1?Q?yDwKmidXOELxjiD3Oo45N4DSRedxTWT2pZPgvNC+EDJAHs78qMjs1Z4w71?=
 =?iso-8859-1?Q?/l4bzwzPLdVo9mXd21PrBG89caRKrpEDf6XshoVnvDGcczQbAxNBash5Cj?=
 =?iso-8859-1?Q?QPFostYCuK59fw0hV+DBSj+3WcPIwpVeNNtfYkxrSAz6tiOVb/hJH8Y1hc?=
 =?iso-8859-1?Q?nLMMa2Fq2S7n4H6mxGcmeOZ4IZTKbNbaACw3oU3fqO4tH338qk0pOF9tm6?=
 =?iso-8859-1?Q?lP+he+jOrV46qmRlJeM5sjZdAHa3K3UBAyStRyP3oPTZrBXwYbDl0yAHeA?=
 =?iso-8859-1?Q?9psq7x1hfsdRpmx1Mte7YUtnkchjs922uOVOCZc4fL1QSyfD94HVHdN4Y0?=
 =?iso-8859-1?Q?ySjy3A78TfYW22ewJSQPsQWkO32EBStBMtow8g97mlBKx8Pkk9f4ar/BpB?=
 =?iso-8859-1?Q?QYpCLcadYd9BfULNmyriZ2cMAKCqTWIb2MIEAly8ffXQ5RYgI4tEnIirM7?=
 =?iso-8859-1?Q?r4SweZBHrdJnnUqtIy7oDeMOhU6IEDk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pgd5te6QEH+WxPR/3euPjtjZge9GMw5bDgOtWdkZ6GRmoUnDBeJSecIQ0xp18uG+qIOrcPkk5pzRAGNYw0KRuBY2ABwg8qCO2t0wYF7jWEhFuiRD2zwuE1pr8HPiMZMCZmXOUI7daHWeYN++Qd2qBVXFs8q7UkLcFwG6Lm2pYw8pt9aucxWIBQB0TN3UKNjBkzu4Pjxdr4nlLPc9Xz7NuO8oC7hx3k+aukm3W4HN6SviZ2gVrKIaMyJ2fpP3EhdP5cMlGcej4+AkvJc7BozgHchWMbfyIc2uXOSM7CB+gQBOJO+5TSD3WMi9joNwlyfTyOM3qcsLuZEVX8Ifwk2H1Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6418.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14be2ff6-aa29-4695-357f-08df41def81d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 23:36:40.9340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZZIrUMhDRoNnEApE37iJVi2Qdw15o4O04yvKv+wbnHY6FnbzJBG+0xA1k2YJWXpJ7PfkVm+8haDKjWkACPHMvvi9gehGRdU9Fw4nbq/NJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6492
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

> This is already a point where you have fallen off the hot path and you=0A=
> should really look into your application code or virtio gpu code to=0A=
> optimize it to stay on the hot path (try_qad_pin succeeds).=0A=
> =0A=
> You should not be importing a new DMA-BUF per frame, but should instead=
=0A=
> keep recycling existing ones. If you keep using new buffers, you will be=
=0A=
> finding more and more hot spots in the code as a fresh BO (DMA-BUF or=0A=
> not) each frame is going to take a hit on the performance no matter=0A=
> what. It's not how you're supposed to write applications.=0A=
=0A=
On the per-frame churn: agreed, and that side has since been fixed separate=
ly in virtio-gpu's driver. That reduces how often this path is hit.=0A=
=0A=
> How do the numbers look like after the patch applied? It's the=0A=
> relative improvement of i915_gem_object_get_pages_dmabuf()=0A=
> that is of interest between baseline and this patch applied.=0A=
=0A=
Before/after on i915_gem_object_get_pages_dmabuf(), same ARL-S/multi-VM set=
up as the earlier trace:=0A=
=0A=
Baseline:=0A=
  i915_gem_object_get_pages_dmabuf   36.65%=0A=
      wbinvd_on_all_cpus               35.95%=0A=
=0A=
Patched:=0A=
  i915_gem_object_get_pages_dmabuf    5.38%=0A=
      drm_clflush_virt_range            5.37% (5.35% self)=0A=
This patch optimizes that import path.=0A=
=0A=
Krishna=
