Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6E4FA1FED
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 19:52:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A2B110E06C;
	Wed, 22 Apr 2026 19:52:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="i4bLgg4e";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1A6210E06C
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776887524; x=1808423524;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=w1qiusDeNNe7SyLiBdfWvJ44pa998KllMdpXrnSe7/I=;
 b=i4bLgg4ejXEMBlkftp2EDLk1DXIxjoaBVO6p0WvvdzlT3OG7uhFLdIOH
 NPWeeQG3XZwsrfgdRa8H3Lg3uXqGxD+AowB9SmuVV+0naSDPj+cm2i8He
 BeWg7kn8CC91x+FaM317uEbdq1oeo7FAP545JBPttOOTa2cbhkVnEl1f2
 AghkHW99djUpqQhOCslbBWTkicKWX7/FIf2LiygMY1FwFL1QkKus0cGyv
 TBH8iRTk3s8fKHu+buK5lm8I/Y+s2D1VIhOZ7uAk2WKiaVdXeoDaXZbcc
 pYPEFG9Gvv4ZDHUw7hg3NnmIWgtuSQl6b63cAqQu4GTm/KMpfaX+uu5MJ Q==;
X-CSE-ConnectionGUID: f/T59uCcQT2hiVNjPoZSsA==
X-CSE-MsgGUID: orzNJbfKQ46+3aJKpzv09A==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="88461018"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; d="scan'208";a="88461018"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 12:52:04 -0700
X-CSE-ConnectionGUID: RN0jA3a+QBS18Y1XREObtA==
X-CSE-MsgGUID: 5tE465CcRVSdh4JuHdDI+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; d="scan'208";a="270558663"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 12:52:04 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 12:52:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 12:52:02 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.46) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 12:52:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlkCNRvkANSOU9RzDq8Njlk2ry+2wBZ9L/m55/dOZhj4YYvGLb2zGGwt0qtJ+Vm4lxq99JfEDvN8HOCTvAN+HI2CHY1CaC0Ldo1BGIQPRzbwEv4dz39NmPo7GOK51diojQEMIP95Q84JflYyLoKiHbEXnpl2GfSj5gVmInTezCZaWWBJLrAEb9LoYv3nnSU2ura1CiGf0582n6UDfwAnmmAhDnJylWSbF47xAdUwyLMmDtvtJtWW96zZvNpqd2UH16C6vOdOw0SyR3dQxwsOgYs0ACXj2KLXmpmluZqYBoo16RPgqvSkdszys40DNd+uAm57VRkenT0XTalpLkUW4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=il6sEzx2OfH48lQku5XkqZ2xinWvx78xljRVJJQWpLs=;
 b=UhlxiKLQouPGzWWSftVafCG6dN9g/0zYsyfsW/4NWob+q7j6Gj4pQ1nTLc0KbqB4G97jX11eEBhsP+fWlfj2oV8dU3jw3x2070uh9jgCT8m+F4weMC/WBi5nh8sK9ispGhWEQo5Xeb6kA2AzMgdLRZu5RRlC7StagFOvBQDwpTJzkgmeUVh3pCddgifUuEANv/IY3nZv0dWGo9NRzI11+BWK9TdojzapVZlRfywyIPPLomT11xtnzw+dVTRF3y+7ffdy1Rt0tB4eP7so+Ud0TfyNIB5n79BpqGpN+ZO3oNyzGbfMyWFcH4EngXPgHdyPwZaDh0V5Kog0TRCRF8ZdDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5445.namprd11.prod.outlook.com (2603:10b6:208:30b::7)
 by PH0PR11MB5783.namprd11.prod.outlook.com (2603:10b6:510:128::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 19:51:55 +0000
Received: from BL1PR11MB5445.namprd11.prod.outlook.com
 ([fe80::ceba:7a73:8708:315]) by BL1PR11MB5445.namprd11.prod.outlook.com
 ([fe80::ceba:7a73:8708:315%6]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 19:51:55 +0000
From: "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Gupta, Saurabhg" <saurabhg.gupta@intel.com>, "Zuo, Alex"
 <alex.zuo@intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Cavitt, Jonathan"
 <jonathan.cavitt@intel.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "tzimmerman@suse.de" <tzimmerman@suse.de>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
Subject: RE: [PATCH] drm/auth: Only drm_drop_master if it exists
Thread-Topic: [PATCH] drm/auth: Only drm_drop_master if it exists
Thread-Index: AQHczeQkDzmLNDi380u7p08w40QJDrXrfG0AgAACA4A=
Date: Wed, 22 Apr 2026 19:51:54 +0000
Message-ID: <BL1PR11MB544504D75778EEF9B6A76ABAE52D2@BL1PR11MB5445.namprd11.prod.outlook.com>
References: <20260416210047.3904106-1-jonathan.cavitt@intel.com>
 <v352ddbainho63kevtsaa5ijthgrlhwlawqpuoh4oob7m6644h@432qcnxumfbh>
In-Reply-To: <v352ddbainho63kevtsaa5ijthgrlhwlawqpuoh4oob7m6644h@432qcnxumfbh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5445:EE_|PH0PR11MB5783:EE_
x-ms-office365-filtering-correlation-id: 907b23db-fd5c-4d76-15ab-08dea0a89b2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|18002099003|38070700021|56012099003|22082099003;
x-microsoft-antispam-message-info: rhtTrLXZJ5XoV8xKNmbcApJTIhAGckeo5AsyoFeqBKojPwhbHYmkWpcL3R6xyIo9fM3hu8Jgvo/2ssMKta4Lh0SdP5Hpi0YsET2VrKm7xvgfa1j7pxj62TbY9ogRvHpfH/Cj/EQlld/SPYZZd3PeQQQ62mjsQrouWob/teBBUFelpPKW9jPJwiBkTxStF3zNXGejO8MjlUWAJzYpqjoJLYwHpGInHtdm/sNATXjwBzbJRMUUM4cqRbB/8iUokZhAFMrKYE8TKctteVWkpWu35bts2KeTki4V6P93Zlic8cS007ADVkcV+a4jUdwi0zccR80gjiKJI2jDOsKpRWXdrB5URjk1Zw/6zcTYRobE26gL7yGJHKtDY4+In2laVDObET10/idVyWaZDorlIhvBxmzhW0A8lYmA2AphtKQ/OAuLmgvjlMXnUclKlkuCvDO5j5Hr89R2mSLT1NWhT5IyLn8ZBPvNZwxwvaPsJAVDR/cwcOqscIEkdTT1m5Prts7CERE6JdUk3tAU9vOk78lCfiuJuu8tij78xZaWrI+uIVQlvSWeq0m58y9JHPMiRVXlILDv9AGfV6wAOU8DRax4KnufBx9Ym6dEJXFw7fWGQKcnmXr4R81NVmlHqzZQ/wi56QtReg/DHAF9MWBrzlHYaVjyuvYldXiuxc4I0nJz+Rd2AZy/jbNyDuCDqBWmSKrMQbvxTK9HOi7YPBQ+53EEItZrTg7ELEqTFxnNk4qIAXNm9apucuJOEvF0vV9hWtVS+X6BGWZvYSJViGqusYISDNYS2gUpUoqKPQEU5FWgLnk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5445.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(18002099003)(38070700021)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GMt6gBIPIoAy8l2cKyRIgTiMXUzKDuMMNpy8yWqF94QDNsP0LwczapCL0xGU?=
 =?us-ascii?Q?azOY/Viw41spRDWIBSyfhc76lXEyLf8ojjDU8X1juhFI41Sp09AmFbPZdbiJ?=
 =?us-ascii?Q?AtFXnWAIslR4F2BaUsQ7F7WZJGV2Zag6K7EvWqt/gw3R7kpo+MjaZ4/855pL?=
 =?us-ascii?Q?WVWk3iTjgYjnxNeSFCIaj2sWpOBmjKxcoW1n4O9VpBYUM3hxIZBYHFYh7a6v?=
 =?us-ascii?Q?nzmSCzPWTGZ+55SboiqTHogWA0hzF1TgQ+A0xgGMPJfrJBMZIckOPKTzUvpj?=
 =?us-ascii?Q?p6FUStzOnh9qYlcijcpz0WbcWvt62iuWS4XgMdXpYC9cN1RkHBlj1PpZ+4rn?=
 =?us-ascii?Q?rdMxOrt3ilF58zDdM8lh08NYueVIsc6wi28gPETe016iEet/iZ66r382Twwt?=
 =?us-ascii?Q?AJLkahZwRb2Nback9q0ZHvctc35c16U3kKhl0AK0VZeD0CuGxW99XSDTYoYE?=
 =?us-ascii?Q?QALlPiaIFt8oKM98HXfA3YP1ztHkHs7aRr7lZkfmAg+EWQW/eapwt3EXqnny?=
 =?us-ascii?Q?PbyfWqujWaqix3xQHGzQp9GkhKItPfKq3zxo0DmdBbvxN86veYcgAajSwujq?=
 =?us-ascii?Q?Tv6bnM2Zw1V9A6CsvdhvvKf6Qq37yvNzdw23EGRRUBGe64jQG4yB95ai4ydQ?=
 =?us-ascii?Q?SnHNwkx1BvUnTAv4fGWt0Iu/ak8EqBJt+3qTN8bp1wVNRbaw7KL/RSdg4TEi?=
 =?us-ascii?Q?6f5DwFzEzAnDP64MjvfYMninCjxETPGAythjvbD8J6fIq7MnUZy3tDefLgqW?=
 =?us-ascii?Q?vvi340ekTJQSl+Xk/6m2C3o5GGFAJ4Q1/UKUhhFev51UobjVOHyzpiEWjrUG?=
 =?us-ascii?Q?FVn0gXD6eI7Bm7F/qa1Jj8C/tIcUQnkU6MGnzLeVlMVdmudC6dRG8c9lWSWq?=
 =?us-ascii?Q?yxTJ5IfZ3lm34fx7+UWkywlt46N013sz+qL2jKln5QaO6jjZpDKRCV6AEHXB?=
 =?us-ascii?Q?6ATi5BpH+f0w+7H77ioMfmsV73svQGe7AzDkYjqPR8RFm5Fkzzej85O+JdR7?=
 =?us-ascii?Q?A0QpgYuWhZN/Gr1P/xrH9EgFg6t7ZPNp9qTT406TJKeL4RYWVO+04q1/tVCg?=
 =?us-ascii?Q?eKpOO4+vNDeMHp3Dn/a+tNQyQ6O4ojODZViudu5dla4LrRLwsIVW3NEFkyt3?=
 =?us-ascii?Q?0xRcw+IFImayTJpffCXu1FgwTng53A+GB+465jgjHzUkjbo8T5phizAGupaT?=
 =?us-ascii?Q?NcScS/HdJBPLrLkGu1gzzM5IcDVRONpjNkC8dDvqW/LFfyzq38t+sVtWjjGq?=
 =?us-ascii?Q?JDViY/rHU1Oclqvdwy8paRXWmZW7zrO7QbDyZ38KLjogScQIxr0mcXxWhweq?=
 =?us-ascii?Q?0HG22LMfU7bGK1h4WdzeUgRYJEvQh7KqNqy5LOkNyy4iDxgG5+0l93p4mvGD?=
 =?us-ascii?Q?vPSC+cYlB8S7nU8pPkGy2b1kHsMjWljUnRVlSRaqfFi4BNR1IC2/AiX2dMAM?=
 =?us-ascii?Q?8+XtO7bC/RsP9E8UNyZyeSIOXOwuiVdTRFfLBoz/JABF/62REs39BN6CR/ci?=
 =?us-ascii?Q?7rjdypHCfOXP1kafk6M8Uf7O+0pYOzrBJyUQEBv/rDK16AUIWza8PPkR0AHi?=
 =?us-ascii?Q?Efm9lNIhQeT9780JJsXPTBACn+Rgkfxdw4er8HHoBaBUavGoVbJiQXXezXta?=
 =?us-ascii?Q?zZa6L8reF0BlNHJSPEr5KVYOdUASfqwqtIb56vyc3pq4gD4Rt9MjsnU+nrEh?=
 =?us-ascii?Q?1vRFhwrNzQjzt9m0bBB+HGYxxhgi9QbHC+2SUdSqqjBENewyHpzpaUXBgRKR?=
 =?us-ascii?Q?j4csY0pzTysP7VAr3MWXHi2BBpmCzONfMxaGY+FkN8s3mDRQXXh1m+zwFgaR?=
x-ms-exchange-antispam-messagedata-1: syNKeccCpNZmKw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oeI80z/0Pk35dgTacTBY/ts7TnPi4sXkjiHtnZaToHXsq8yjKKTKHEcJzlF4UcQFd5dPYzHgszUS+nSP6sEquZMTJAHD3bMtxaJwvDQMD+UksM3GczRX+mVPqwudtM0YD8Izo8yCYhXH0/xewRzSdirgTjkj1FA4yNkIrEEkzsVe7EhYIZcnVuFD53lLebkkwzmsADah+RadMGMJMh7FIcvAjpihPIpRzXOifepRCW2QNuq6b0tsUzJDDLpEw8mVPhoM1oA/qyUf+NvNeyLTG7vCeA6LJfFJ1A6gSbGt89NEoyVrVIW/7DUrvXydRJSuqfHhy/l7PbNzzfJVHhextw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5445.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907b23db-fd5c-4d76-15ab-08dea0a89b2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 19:51:55.0241 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xBAKJ6Y2ql5oKnEOjbdnoEOONMTBwRlG+MDih2FWwcLZy8JxNcwhlDZxwXifrXy/dcKHNJqs83twKq/Ni68Vnc34/cpDNCo3/QaUCQ3dauY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5783
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

-----Original Message-----
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>=20
Sent: Wednesday, April 22, 2026 12:14 PM
To: Cavitt, Jonathan <jonathan.cavitt@intel.com>
Cc: dri-devel@lists.freedesktop.org; Gupta, Saurabhg <saurabhg.gupta@intel.=
com>; Zuo, Alex <alex.zuo@intel.com>; linux-kernel@vger.kernel.org; maarten=
.lankhorst@linux.intel.com; mripard@kernel.org; tzimmerman@suse.de; airlied=
@gmail.com; simona@ffwll.ch
Subject: Re: [PATCH] drm/auth: Only drm_drop_master if it exists
>=20
> On Fri, Apr 17, 2026 at 05:00:47AM +0800, Jonathan Cavitt wrote:
> > It is possible that both dev->master and file_priv->master are NULL whe=
n
> > passed to drm_master_release, which would result in dev being passed to
> > drm_drop_master (as NULL =3D=3D NULL here).  This would result in a NUL=
L
> > pointer dereference when passing dev->master to drm_master_put in
> > drm_drop_master.
> >=20
> > Only call drm_drop_master if dev->master exists.  Also, make sure the
> > original calling requirement is maintained (dev->master =3D=3D
> > file_priv->master).
> >=20
> > This fixes a static analysis issue.
> >=20
> > Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > ---
> >  drivers/gpu/drm/drm_auth.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
> > index e17bb0f1f9e0..e5013b870ba0 100644
> > --- a/drivers/gpu/drm/drm_auth.c
> > +++ b/drivers/gpu/drm/drm_auth.c
> > @@ -347,7 +347,7 @@ void drm_master_release(struct drm_file *file_priv)
> >  	if (!drm_is_current_master_locked(file_priv))
> >  		goto out;
> > =20
> > -	if (dev->master =3D=3D file_priv->master)
>=20
> The previous call checks that file_priv->master !=3D NULL. So, at this
> point the NULL =3D=3D NULL check is not possible.

You mean drm_is_current_master_locked?

Internally, that performs the check
"fpriv->is_master && drm_lease_owner(fpriv->master) =3D=3D fpriv->minor->de=
v->master"

It doesn't explicitly check for fpriv->master !=3D NULL, but I don't think =
the current execution
path allows for fpriv->is_master && !fpriv->master, so I'm guessing that's =
what you're referring to?
Otherwise, we could be passing a NULL pointer to drm_lease_owner, which wou=
ld itself be a NULL
pointer dereference issue...

>=20
> I'm sorry, but this looks like a false positive.

This has already been merged.  If you think it necessary, please feel free =
to file a revert
and send the request my way for review.
-Jonathan Cavitt

>=20
> > +	if (dev->master && dev->master =3D=3D file_priv->master)
> >  		drm_drop_master(dev, file_priv);
> >  out:
> >  	if (drm_core_check_feature(dev, DRIVER_MODESET) && file_priv->is_mast=
er) {
> > --=20
> > 2.53.0
> >=20
>=20
> --=20
> With best wishes
> Dmitry
>=20
