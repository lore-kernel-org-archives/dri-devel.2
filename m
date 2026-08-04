Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB1BC55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 06:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E848810E663;
	Tue,  4 Aug 2026 06:22:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RsgxYxgs";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 308EA10E663
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 06:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785824555; x=1817360555;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HYbWQHmGd5Ehc7k5Pe+kW0gSvO6BgK18+NjInLvvJNg=;
 b=RsgxYxgsqcQNIYbnG9Wl7gi0CludQQATKudjE/zItFSuPrgsZs5IK+B4
 mhFoYamJmzxp+ftyZlRV62P8FaNvn/CUyKOYSou/Oggh4E7Y0FsyLP8+E
 Ttwga2ztSjr2OGlENv/zHpi9BhB7p5xzjpU+5444e4s78DDl93FFZ5YRY
 7P/ces9ZOz94FKLw9p9cMvfrZ369hzTdb4C8dH4zDDG0RzhVXTQchgP2e
 JpFYLW5SDUIzmJnkGne7kWdzrhFxtlVZPD6lYS6cqaYStVrzEQnMcIToH
 mijdJmVWsFmvwfC4gwCMqzpWzeHOpL42z72eM2XzUIxMIIa3yLB8Tslcy g==;
X-CSE-ConnectionGUID: xiwcoa0aREOkKggVJAz6sQ==
X-CSE-MsgGUID: gA8DB31ZRRaFGdpr5XpQRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="103907774"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; d="scan'208";a="103907774"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 23:22:34 -0700
X-CSE-ConnectionGUID: JV0sEFD0TZqrM1hWEvqrMQ==
X-CSE-MsgGUID: rUEwJR5CSgyHdIH0Ef9/9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; d="scan'208";a="266542090"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 23:22:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 23:22:33 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 23:22:33 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.28) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 23:22:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CN1zgEFkEuMwawnvGW1EfjzcW47ThdxW9AG+vPN4+FZswtGfgMEt5ijCEuuNKSMjdUNukG9dR8ibA1jvjrCGh5C/EbAJi7Uw+qQO6E3E11il/yvd8ePFcFNhP/Pz/Api7RxIa4QBPomT9X1kL5g6Q3lsEZ4k8zu3jE0gym32i7OIa9x0QOAoJ4Je8KjrFIMANTltMBQaYzHRZTyS+ZOmkwTc8B2HqMr0mEk+PHjKTEk7ID5oGjmZKFeHMSjOm0q/JvNVOHs2btrzry9DqNk6O3kC2lGX1s1/cfZvhkcwx8UewrkyMDEsdl0nTpfNJEKOTmasyHY22zwC5hfdOfoO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTC9zfBDaIaUak6DJi/sI/czRNGSFZAeohRrVkr6g54=;
 b=OylcW3C31YovLjJCzOq+E0SeMdRtcD8mRDVMsSha6psm2jTBHQ7T5Bi8or+Ejo3Zcg5da1pqGyy7zLJ+EP6wd+Px7GtYK+JasE2Hnoj+DFqg1o8a2iRLT+X0/m3JYy1fgUR6LT2MXDtXJfmSp6NNXQ0OBOPCdawYH1amClkfhWrdBx4W0VMCcxwMEhQZkI6xvdBnFkY6wNOS9ZLqsY3Dk5YXAvbcSskmcSbxzZ0qeEkjPbp1lqky/g8Nl/0sfwkZTLUBdOUy7ShEgMCDWMlz1AYSPsZ9C20/zE3p39BPcvc4LenBX3K8x/fu1yBcPBM0xh+kY6SHffc32dumtCdijw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SAWPR11MB9900.namprd11.prod.outlook.com (2603:10b6:806:54d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 06:22:31 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%6]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 06:22:31 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Robert Mader <robert.mader@collabora.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: Gerd Hoffmann <kraxel@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] dma-buf/udmabuf: Disable the size limit by default
Thread-Topic: [PATCH v2] dma-buf/udmabuf: Disable the size limit by default
Thread-Index: AQHdGcmgIlKoMcnWgUS+mY72ClF+rLZ826QAgA+mMYCAAD40IA==
Date: Tue, 4 Aug 2026 06:22:30 +0000
Message-ID: <IA0PR11MB71852141D71DB8879A3EEAE6F8D42@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260722110145.36641-1-robert.mader@collabora.com>
 <IA0PR11MB71859E0D17C2959DCBA7CF3AF8CB2@IA0PR11MB7185.namprd11.prod.outlook.com>
 <e0129e0c-9157-4ddd-a54b-37d09135160f@collabora.com>
In-Reply-To: <e0129e0c-9157-4ddd-a54b-37d09135160f@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SAWPR11MB9900:EE_
x-ms-office365-filtering-correlation-id: 44b73319-1f0a-4a7f-55b3-08def1f0c3a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|10067099003|11063799006|4143699003|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: /oLJNKpEmsd+uh+HmLkCPOiSm1rHAexZBNxn3ebIf4FGtMOysL4X4/OdAVOtroGzTMCWTleoFKBG8+6KYF0TByteCdkCVk2h+lig2JSDjvotIVQjLUOFFFmfri/QXexqU+jFJpIeLtYl3mRgS1+J5otVNNa5a/JPDs/oTKE3BHSJWJ5OOk2bSVwblHsVwmokkHNl2D6HuZTDOxzenPSf7xrfzS/or0j4dSLDTaKsMuZ85CnkzRagY2iAWT7mMHCQXDaaUf9lCXdD3fY128I37D8HKwNdtQhEmcPQjHaAw1xozuMv3/HRluIw5oQppuKRDYxU7eJwItNZqMKuCHPazOBqnHcy4tUxktx9pvYiEl2oQ247nxatUdpgVCNJKyWZMU4fVU5S95EjY4xR3BTjyL3uNVOqz46mpTkGojZMyoGPOnYX6S8unFCE78X+yEofI2TyV2O9Kk1tTiEqx1dR3aEvB+/5E2L2hRqmu0tkVjupwJ6lKwSd0sH0+3BtfzA+aoEshd3AeCblT7xuaQ9eO9yVqmKvFvpOWmdJKpWr+MyzKEcMFsD6Ig7L4YGEZBXIwfFNqPWvnT8NdYYd6/1/J+RSB/bcvr8n4VnqBsX8LFEaPaCTCe9I4nqJ58gpDYuZ16WO/nzUD3s0higelfk8F95zqowMxk0DVaxlnsmMwHjlQGAdQQW7BTvPFkLeTD5SLYjfMpAZ/tM2wXRWUWIkNXzzLXKxTu0FLFI4JWv9LmU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?S1QzysGfe03elkvmX7YK6h+YLVffw3P+fSF2iO5uM68FqrGpoTpfelCfuC?=
 =?iso-8859-1?Q?Jq/TP0c/RybmOkcDOvPZ0amEI5uSElhvaheVHqex0ypumzXM8P97JWbP5i?=
 =?iso-8859-1?Q?e5vkhh/uMmCk3n9drAkZD8WTaLt5P3lW1pB4bijzYr1hzktAHDeNQZLNLS?=
 =?iso-8859-1?Q?BBr6NNkQG2b31cXGj24TgNPKg0y6Rr3luDsz3L7y9XUUNVGPcEn+e+ELhX?=
 =?iso-8859-1?Q?8+KOf6dcYMd6KnljkvCSQqxCKywBmE6yk8cWYnfnlJnQzchkVR9yF44veN?=
 =?iso-8859-1?Q?0E7juIQ5aSGZFh7UUdQ37vz41s4O13FbuNFKLMyEPKu3txbZuOd1Wi+KOK?=
 =?iso-8859-1?Q?UbRvWrkpFdm6YQR2SZfzxKlb5pHMAOSqZkcsSqVa/yVc6/DnpmRzzEdxQw?=
 =?iso-8859-1?Q?Pbs83yKf7/9EHIX9AbmJqRSl5Vi8AtquAYetY15H8nvM74mS9JGQxPrxoz?=
 =?iso-8859-1?Q?hqckFq1d16SlQ4xNLtO7OZTG2Qp2H2/R0PgUQSD9pHmJOGYReeIZr6NMdS?=
 =?iso-8859-1?Q?w53TtbN3fnDrFMq22ONORO+sNcv1anz8CJ6WaRewACpZgN/ob8YEXX6cyw?=
 =?iso-8859-1?Q?NJrarrgfxn0jlfID/tvmrH6x8+attjSlusacqEWQSGJ6cD1x6HPeddZ53Z?=
 =?iso-8859-1?Q?xTFUh755MkS03gu7/3t9vuf//S2PJ7pOyYh/nayo/+pENHPGPw0TgHYciG?=
 =?iso-8859-1?Q?/Q6DtGh9O0ATsSP9wlty3M5B0RnDNtPNWPXIBaKPVZsu79yRoA9xs0jTmd?=
 =?iso-8859-1?Q?R/KFsB5poSFNY4L4KSkywKtAUXB75hWRqTIGehxa+c21r+2dM3CAZH5H/b?=
 =?iso-8859-1?Q?L3u+W1+tdeIxfXLYFju5EQdfkReZLnbgF+u1yGuaHqamv8fz55T+C9Zn29?=
 =?iso-8859-1?Q?56yFlzzCwA+VV+Cs9A9JwKbsYYF9SmyFr6WBC1e170URiru3Cw6jCJciJF?=
 =?iso-8859-1?Q?g7STJKx4Q81cLGUN+DAXAxZVkcACoHdnup3UvjXqjAJUuXCV99rgugUnhI?=
 =?iso-8859-1?Q?vsjVJPoNv2duQsf3BdinfY9xwrbWm9sOWciEG257ShB+Q8PWnWhwGqbVkK?=
 =?iso-8859-1?Q?fOJS2n7cNqp07WHmZSHy0TM9JyAUAZc0YwhqO/kfP4IYRSMiAWTrAJxGks?=
 =?iso-8859-1?Q?zs/fK9Hhez9Pe/0AmQYP3WGBXAVbOfCcJjuIHwkU8EduXbKHNfgRpSddaB?=
 =?iso-8859-1?Q?tVs5Dw4e43LTK6jOCs3KXaHL+pUzdv1HLBqjc+AhkatwVrVb9B16EEHy0O?=
 =?iso-8859-1?Q?RF6rSAzujomZsfJe6k04MhnUOj42ZBdNFIkyoVjVWt+9vKFJSdzcFd969W?=
 =?iso-8859-1?Q?zAMcKHK33WVLCbZ1xbReooQ8maEbZ48VnC30VUACEXQheK+l5RIZgT9Cjb?=
 =?iso-8859-1?Q?1i7ED/XtC5lFbtpS+ZbtbNwVgtaBkhKhoXDEJnIM6zyOw9z0YES6NTNE7I?=
 =?iso-8859-1?Q?VkW4c5HjruEOyQgsHHZzw3C2U9QOAidhxtmeHsQ4ELGMtmk6Y8UeThqSEx?=
 =?iso-8859-1?Q?du88858zSinV32Mm5ujoNkE2nKLfWgQEd/8ly/Ss/qHo6VmFv5wP0xxELR?=
 =?iso-8859-1?Q?ohkdnZWXbWBnOSXSQ+ITyWDLkuPpDoTuMT6u/gdi6Tmxz7tH0xhBJG4DZU?=
 =?iso-8859-1?Q?j2G9Gjfdr9+B8PjVwUjPgZm7e0ioWoLsBRana3/clGOoZm7WmUikI2bRb+?=
 =?iso-8859-1?Q?1Z/YV6Wk2P4sQ0Y9/qAuqdPyZu1IGT5WktXCH5VswU0iFdUgIUxO7VnjzK?=
 =?iso-8859-1?Q?SysrLgOjTQF2LNqTozs8VhqRpL21xhvX+bmJvLJc7n0n2IDih/RFY30V9p?=
 =?iso-8859-1?Q?YFa4ACDfeQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FNuf/yxkRU+QSC+sV4dd+wcaFh0TnupkLvDwOY6dO6FaIzoOgs1kCt2T8pZ2Kge9CkmmrzvPa09o0qTZ6+A3N8K//CAKXC7bHSylCdD3kyNpVZddMwCIgVTS4yvNfbKQk7FcBcid+Oo8DWLViwAbT1qfCoiYsksloyDR3BUPz2fFCHuPsnJXnrS4M+z6v6IRlc80LPYmzim1/iw9ZkUK/sDR3abWWeCoqCYiMz1+3czxfTicme5dI/BOtNDymrccDc+8iQwE2QvGdYuY/oztlVV3xgzv8X3t/2F6XHmTy9A7psTXRKvovIelcRW1JabUiUlUyTCyYTvDgkvuK91FVw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b73319-1f0a-4a7f-55b3-08def1f0c3a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 06:22:31.0032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j3mID7QoVxxHbGT/+N8GSCNliD0jSVF00WWFQ/5MjawAB8F4MNTO2VD8kfrY0GJzc+Ow6vo9LcRsvob73PPhR0G7B1P4OwWH1opMUv57tX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9900
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

> Subject: Re: [PATCH v2] dma-buf/udmabuf: Disable the size limit by
> default
>=20
> On 28.07.26 22:20, Kasireddy, Vivek wrote:
> > Hi Robert,
> >
> >> Subject: [PATCH v2] dma-buf/udmabuf: Disable the size limit by
> default
> >>
> >> As udmabuf increasingly enjoys popularity - being used in projects
> like
> >> libcamera, Gstreamer, Mesa, KWin and Weston - users more
> frequently
> >> encounter cases where the current default size limit of 64MB is too
> low.
> >> Examples include allocating video buffers at a 8K resolution - and
> even
> >> 4K
> >> is affected when using non-subsampled video formats and high bit
> >> depths.
> >>
> >> In its current form the size limit for individual buffers does not see=
m
> to
> >> provide any additional level of protection - such as limiting the
> amount
> >> of
> >> memory a process can pin - as the later can just allocate multiple
> >> buffers.
> >> If additional guardrails are desired, they would likely require some
> kind
> >> accounting not limited to individual buffers.
> >>
> >> Therefor let's disable the size limit by default by setting it to the
> >> maximal possible value, INT_MAX.
> >>
> >> Signed-off-by: Robert Mader <robert.mader@collabora.com>
> >>
> >> ---
> >>
> >> Changes in V2:
> >>   - Use INT_MAX instead of 0 in order to not change behavior
> otherwise.
> >>
> >> See
> >> https://lore.kernel.org/dri-devel/20260711144814.8205-1-
> >> robert.mader@collabora.com/
> >> for a previous attempt to make the value configurable via kconfig -
> and
> >> in particular
> >> https://lore.kernel.org/dri-devel/6764ca6f-b4d8-4baa-9d27-
> >> 2ca867ac2d41@amd.com/
> >> for the suggestion and discussion to remove the default limit.
> >> ---
> >>   drivers/dma-buf/udmabuf.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> >> index bced421c0d65..639e93704924 100644
> >> --- a/drivers/dma-buf/udmabuf.c
> >> +++ b/drivers/dma-buf/udmabuf.c
> >> @@ -20,9 +20,9 @@ static int list_limit =3D 1024;
> >>   module_param(list_limit, int, 0644);
> >>   MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit.
> >> Default is 1024.");
> >>
> >> -static int size_limit_mb =3D 64;
> >> +static int size_limit_mb =3D INT_MAX;
> >>   module_param(size_limit_mb, int, 0644);
> >> -MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in
> >> megabytes. Default is 64.");
> >> +MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in
> >> megabytes. Default is INT_MAX.");
> > Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >
> > If there are no further concerns/questions from anyone, I'll push it to
> > drm-misc-next soon.
>=20
> FTR., we already have a first duplicate :P
>=20
> https://lore.kernel.org/dri-devel/20260803144120.11524-1-
> xaver.hugl@kde.org/
Yeah, looks like this change seems to be desirable in many use-cases.
I have pushed it to drm-misc-next today.

Thanks,
Vivek

>=20
> >
> > Thanks,
> > Vivek
> >>   struct udmabuf {
> >>   	pgoff_t pagecount;
> >> --
> >> 2.55.0
>=20
> --
> Robert Mader
> Consultant Software Developer
>=20
> Collabora Ltd.
> Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
> Registered in England & Wales, no. 5513718

