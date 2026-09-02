Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE093C61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 05:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9066810E456;
	Wed,  2 Sep 2026 05:37:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NpgGi5TQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FF2D10E44A;
 Wed,  2 Sep 2026 05:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788327461; x=1819863461;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=IBQsbE+cwh53K9FTQ6moCxtsFkmGMOdvEUl6eVHOFeY=;
 b=NpgGi5TQs3sWcFkLlMstCQZvyWqa64w89LNPfiQX99omVbUdEoQeT5Sw
 VFzrF4xo6jfEhRnB2amkkz7scPrU+tFzquOLVH8ALPKcH0Kp85usXQoJK
 A4KXL4UGYTAP+2rAbrivFbQZVAaCkj1AwWZ5Tfx14av2CI5GiW1JTMmWZ
 UXMzTAUwnX2XDsOrH/SV/+Tq57FVauSH8lgjWJ21XRP2rAzLIxfkR140L
 0Ai8HhY0g7JyYuWQCGSPiVtF6x1ZPnGCKglF1WCOWmaC/PV0bE/Tgkwn3
 9ku2yGxz/qvD18c7jcGAp6pleR6t45FGotf3Y7GLM8GW0wdxi8l4nk2M8 A==;
X-CSE-ConnectionGUID: QewH7DZ8RHyg5cvRdmbzWA==
X-CSE-MsgGUID: l0b1nNO9SYiH+B232m4Dgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88623461"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208,217";a="88623461"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 22:37:41 -0700
X-CSE-ConnectionGUID: hF2Jq3pMSDKxB9YldtMwTw==
X-CSE-MsgGUID: DJTH0kEBS4qsKbynI/5PHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
 d="scan'208,217";a="294134354"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 22:37:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 22:37:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 22:37:39 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.68)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 22:37:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSy/Yx/0txskPPrwsgl5iH68VgKm9VV2lR2/pLoaP/QUiJeT++TG2cjTxuKmRC28NFG7YeCT8gkVLlppuS8/hviK5ltFEp/+hiYGCESWCpHW6rk2+XApIo9l7LYVZWDcpGcokbU1Vx16jP+auqahq0oMhxbGhCws5nRTTD7qmLDAXJ7i+0Z8NuvCaRG4zdcRHq5bPQvyAHFGpgLBz/acDadUAYUqApsvfsIZHEiSlzrr3ka10+sGCZV5TeHPWbXtemJx3v7+f+s7nEJBlzfVNFX685tl+NTEJTnYqZ5odFS/IbnG2M45kl0Dvy3XzimHeDAw6WW0Sr5ZJFYSLNIfrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBQsbE+cwh53K9FTQ6moCxtsFkmGMOdvEUl6eVHOFeY=;
 b=UxS/c/oI9zPSllWytozFJL8G/GkTg9m2hyKTEfXgK1JNrQ5x1hh1nFEoecbzEbZZjYF6t99a9p04HKaY6Pk8ykYAWmv7TfpTprCKPP5nR4qNkaiQ/XIDDZxUbI1FyymwcxCjHfKOxPbJCL2p+I/fwVBNkt/LJ1c0RuLU0LHFKWw25uGdOj9WQyT4LQKKbNfybG1eJzyx9bbcECgIpNw2L0DmPfh15Aq3VNxNlsF+2FduzxPPzWYw2P6NlxQcYmr28ZxcVNXz2P48Oh1pg23JfSQfcYSPeVCyuhjm0YDDhgNfAOe/Pxqiav/HHm6kvFHl1BaV9vov8wHsKCvJqrr/pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6418.namprd11.prod.outlook.com (2603:10b6:208:3aa::18)
 by DS0PR11MB8666.namprd11.prod.outlook.com (2603:10b6:8:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:37:35 +0000
Received: from IA1PR11MB6418.namprd11.prod.outlook.com
 ([fe80::b831:13bc:a1c9:2628]) by IA1PR11MB6418.namprd11.prod.outlook.com
 ([fe80::b831:13bc:a1c9:2628%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 05:37:35 +0000
From: "Prabhakaran, Krishna" <krishna.prabhakaran@intel.com>
To: "Auld, Matthew" <matthew.auld@intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
 "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
 "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "Vivi,
 Rodrigo" <rodrigo.vivi@intel.com>, "tursulin@ursulin.net"
 <tursulin@ursulin.net>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3] drm/i915/dmabuf: avoid global wbinvd on dma-buf import
Thread-Topic: [PATCH v3] drm/i915/dmabuf: avoid global wbinvd on dma-buf import
Thread-Index: AQHdMOWWmjSDBZy3N0GnNOD8+APfHraoN8UAgBKeIEk=
Date: Wed, 2 Sep 2026 05:37:35 +0000
Message-ID: <IA1PR11MB64188DD6A0054605737E62E8FAB72@IA1PR11MB6418.namprd11.prod.outlook.com>
References: <20260816014552.14969-1-krishna.prabhakaran@intel.com>
 <20260820205031.344338-1-krishna.prabhakaran@intel.com>
 <50981231-a975-4ca9-8ad3-df2a34588b06@intel.com>
In-Reply-To: <50981231-a975-4ca9-8ad3-df2a34588b06@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6418:EE_|DS0PR11MB8666:EE_
x-ms-office365-filtering-correlation-id: 3f990431-905e-4183-ec3c-08df08b44ac2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|18002099003|4143699003|11063799006|56012099006|8096899003|22082099003|38070700021;
x-microsoft-antispam-message-info: K7vdQWTG+Q7YVScIIHPz0CTX2PaEWOpdinzzxy3P//jbboNhS6AvE6nYARLx3yTULhuFgMuQr7Zr7L9M26uV5jpqpDJ5aldvi7Y9aHKh4jdWLn4nvucq/BT4RdBvGPJxB2r4j9YSmKzLN05HycoJwWoZjucWAiSoAXatW25IH59FYeoU7kzdkbjNdaDYSQeMtoPpLe5/Tv9arcJtsXZuytpAftrFaW/D9F/U869vB0fhKF53SC4y3Ma/Ymw+fSI3/2X0FcMXnqq7FGbgPF57EmxBX3PdysAWiTT+Trql68uLma6QG+AuIikQbw71OoZr+BTIVm9TVlamsOVlYtv/LuZOJWR97hRJDSEN3LvS1LkK+ppoYKjv9VpU51Xd+lGF0tnXYGR2cRGd6nhJyvGoe6b/ccAoKcIZ7DfMEq4oHTQXdYWja/xuQ2NZ6t3KT7Awq9J4rr2Z+D0QaDLC2O4aqgpVoIfNFuCvTpO9n1FMGe3Y4rcdIgU69h7bCyJcn8jJR/74nIiJuOGtiYMYaHMFx5sb/TAqmd7f5ych9yritoM11jaXvONZz2JgHy6VukoAMLkfQgU7EbDxyL1oIGD0TTfknKKHL1FVyZXI1NDKv0WZ6GuRc6BZiXLhyljTcTZPBav+9L9EqfNebpcVPVmv1eQS7mxmn9Sp1PKfJ2+G5CHM8p2+JeLgsfuO72xLOI/da3vDJNMIhfFgE+qNDOvGzh9a8Q2Js3oemwVXstb7bDU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6418.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(18002099003)(4143699003)(11063799006)(56012099006)(8096899003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?CQ9XOchykTuaYiDAWFBN3q1tw1bFvHP4mkpjYhvoEnZ1h1n6fE8wBIce?=
 =?Windows-1252?Q?LSk0wfhOpXjQ8+pDTBUAUIRn8pUukhtSnaEXI8VUTuuBSwwNWRx9RUSR?=
 =?Windows-1252?Q?Fu59QslfYYlc7ESAc4daxW8MgWiWe3HjRyySI8Hpl/HUmUbu8NjUa9EM?=
 =?Windows-1252?Q?gb9CLnm2qZXKu5LwrN4/ZNNqoJlemkZHkBaPhfuQuoUUaHUs6bhTC4r2?=
 =?Windows-1252?Q?k1UWxa0BpuUqrDtGbedGDByr7sWgLFE93PK307Wzj1XJVcb0vxoJ7RdJ?=
 =?Windows-1252?Q?/5rXDAbOaDfopCsJWHrlL08zkWzcBo7KPVO6nppZSkMApY9Ol8Bke4R5?=
 =?Windows-1252?Q?BRvVWnMM5Rn52vV9A3oTMcAjKi9NysDO0XRd77FRscnHaUvAZ+7Gtzcm?=
 =?Windows-1252?Q?4p5QpNibDNJfdsDmpCSb6cSg3203kdSSReyAAfMH5Jr/H7w2taUqz/5A?=
 =?Windows-1252?Q?flkJWmw0PVWw66dqKBjpuUU+j5Y78JXk7dTg2D8flmM52U4yyVxU4oaI?=
 =?Windows-1252?Q?JPpJrNNfo1KGPyx4MJi5YT4p5NPrFNrOAca7MaB90BjvFVA5RfjypjXs?=
 =?Windows-1252?Q?2FObwxHq07AaNG7OFZKiKqwoYgcLci0MCJGL3ZyuOY2I/IDpaHdCOumX?=
 =?Windows-1252?Q?GCRb8gJwOZ1DIpZ71qRJ64tg81oIei7op5o2AlBib/VhwMod1en4QSSj?=
 =?Windows-1252?Q?aJfpRFfCBujPfAm6sEAd4sGTXCwdjEMQmFncxviwdd5nXEMf/xqmla9K?=
 =?Windows-1252?Q?3jLncLOb+EPkVzYsnOHKkmCk+JO9LnHJRx67UL0psD3hN/+P6ncJKRyM?=
 =?Windows-1252?Q?J8P1gMs39WcRwWp9av2n4umi9LtoldVXd1uFTgO8IhccL/uA6AoJGXMq?=
 =?Windows-1252?Q?kh5m1tYY4wc7bH57AKFDIsmZL/eHKm1HswSfV7xcohEZbIPaie1xMwag?=
 =?Windows-1252?Q?PMxClcLxtIbbD9FHa7YyWcc5zTExcC3dEu1ulzPyr+wNwn1wZ4wif3oA?=
 =?Windows-1252?Q?xsE9D7jmislDM0I5pGO3R12m7wBrq0eBffQuRtfzsLFwoxeE+0XFOnKY?=
 =?Windows-1252?Q?A02FhpxfVVADl1/U36HHpd5sR4zfT/CRIQD+219zR7AN4IL1hJgHTAXz?=
 =?Windows-1252?Q?RGrOBzGeOhocbfGKa+AD/lH0dImpnHTugleWHgHacnHZDBiAeD3I+bFN?=
 =?Windows-1252?Q?ggKZVV/wTtrEx3tpldBkrONZ10dMqAjttKAowsUr1xwjWXAR+4iKgvcr?=
 =?Windows-1252?Q?DT8sR0L5FhwB06pv22xhZlLxC+Wulmg8WYJVy2x+4EIbS6HpZ2FqnUfy?=
 =?Windows-1252?Q?QSInOyW6MmTCQOmuWxUJW5nsXzeBcQGqiSm+VV+ODk3Mp2hFD5MIwDzS?=
 =?Windows-1252?Q?Ct8prTadh0Eg+vFzWfp2L+y4QZnsTbEf+gDW22Lw4XSiX+5MkpVmNzy7?=
 =?Windows-1252?Q?V1mRKG3AsfAP37bh3uCIHbmdPHMdUTp8Qkh6OurlGA7ixc4HRl80IuXn?=
 =?Windows-1252?Q?lrejCk7ALuIta2jB6zQQrRhktiuiHNvEoUbs9hZxaSwHDeI99iC3URl4?=
 =?Windows-1252?Q?T5a0bReecT7HSp0s3ZIX7rWQiDYC79p3BQKEDrE/MtrB/l/6FkfFeRJC?=
 =?Windows-1252?Q?KBZr2hKjxhfDsUfuwccZ5aYTGf6tKgVjY7JnwYXWxL1bEg/C5a5Cal9o?=
 =?Windows-1252?Q?dpeh8dO8EUXvQsntAPECmRYzN/HG+e0aFJ/wOrjikWTeHZyAMkLT6Sbo?=
 =?Windows-1252?Q?+rOOAsiZ7dNna9Z9zjN2tfC3cnvGHzpnztFzJhGIMLbZJ9vhCIGb7yRU?=
 =?Windows-1252?Q?ph+FazFVm3Wi2dO4mNesr/IUS7D3Qq+c0F61uhxH+XsQCf6Q4nQc67wS?=
 =?Windows-1252?Q?P/mKUr03l5bJa9nG9H/pImq6/BjlnbPtELs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_IA1PR11MB64188DD6A0054605737E62E8FAB72IA1PR11MB6418namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uOmMbDDUol8KcukOx3hZI3NdRtR1CxyMdlOIeD6wp2S+0LGiApeoM9arPhA0GPOOUGPl8Qy+EZ9+z0ApFx9yvFyPp/h6TLkVNYJDw5slmVIUqdsWBgUNS3NkOvDGT9FBu9HmWghKnZlVS2R3KYzbqcBMoZx6MnIJjl3oVeRkBO5MwQb+A6ngaVBK8Q0CiaGNTneyreSCKzGY5YJO/qtvnyy3+R9/tqBmDf4neF3GscXY/hfvRpXspEDNRvyM9jeYi7spM4Jao6MhB9Naf+qkjwMYcryNNcz06w3h1/jjCjflqTIBlOkQeVpZo3az+Rx+Cx+rH/+O8PJONoC9Rjm+cQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6418.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f990431-905e-4183-ec3c-08df08b44ac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 05:37:35.0785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tbVsFGEA66FBxmLWgeQmYyuMox/OiLZSACdlLqFxZGgjq3wdNrrdv4jj/ljejMdTpfJU/Aq+k0yHTvwi2mMxtQgnMdg6t/GdUUJ3SjRoqT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8666
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

--_000_IA1PR11MB64188DD6A0054605737E62E8FAB72IA1PR11MB6418namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

> I think we still need to wrap this with has_struct_page()?

You're right. SMEM doesn't guarantee the STRUCT_PAGE flag (phys objects cle=
ar it), so I'll guard the direct-flush with i915_gem_object_has_struct_page=
() and fall back to wbinvd for the !struct_page case =97 I can't fall throu=
gh to the vmap branch there since that's the recursion into pin_map() on th=
e locked source object that v2 fixed. Will send a v4.

Regards
Krishna

--_000_IA1PR11MB64188DD6A0054605737E62E8FAB72IA1PR11MB6418namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 11pt; color: rgb(0, 36, 81);">
&gt; I think we still need to wrap this with has_struct_page()?</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 11pt; color: rgb(0, 36, 81);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 11pt; color: rgb(0, 36, 81);">
You're right. SMEM doesn't guarantee the STRUCT_PAGE flag (phys objects cle=
ar it), so I'll guard the direct-flush with i915_gem_object_has_struct_page=
() and fall back to wbinvd for the !struct_page case =97 I can't fall throu=
gh to the vmap branch there since
 that's the recursion into pin_map() on the locked source object that v2 fi=
xed. Will send a v4.</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 11pt; color: rgb(0, 36, 81);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 11pt; color: rgb(0, 36, 81);">
Regards</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 11pt; color: rgb(0, 36, 81);">
Krishna</div>
</body>
</html>

--_000_IA1PR11MB64188DD6A0054605737E62E8FAB72IA1PR11MB6418namp_--
