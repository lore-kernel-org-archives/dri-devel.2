Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44601C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:18:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83D8C10E2C8;
	Tue, 22 Sep 2026 05:18:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OXXjzh0Y";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C22610E2C8
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 05:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790054281; x=1821590281;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VRiMTxOBCVZxzWF1mtaVlOQ7SyIG0U4+48q01LCJKOA=;
 b=OXXjzh0YGVRiVYEXbJ1pvoWcCKteypGaqhfH4KE3tmX/qgESBV2U92/Z
 zLVFUocFuPIMKUG5UT4N4tjblX5k9MSOuFODxK/XfPoMiL9sArp+NzwQ1
 M7pNIqL3+9ZMJbhldjNTYEGOnz/kbFAfdOxUKvVU7geXe+knEoFodulVf
 0N0zZaUZEKh9bJjpAVyL5GlpvbzPRaAWiq8sYoX3prdn5yrUvI/N3rOhs
 ucvrTVJ81DYVROskRqXuhX+Sxi+oQIsLBZ/83YFOGUd5Wgi0s6oHTRM0m
 QrlyCkHKrfW6BDHSk1raBjv8OjXWMUNPZWzTIhh8erJ9OAEIDRJTbBqNR Q==;
X-CSE-ConnectionGUID: gPwPjx7eTHO7CpTHBCSD8g==
X-CSE-MsgGUID: 128gmSHUTz+wjqu/1iiR6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1128812"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="1128812"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 22:18:00 -0700
X-CSE-ConnectionGUID: 640UYqKTSsi+2/V6MjZr0w==
X-CSE-MsgGUID: pqdgCWUzQbqv6alauCHvuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="271511815"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 22:17:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 22:17:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 22:17:59 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.29) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 22:17:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z63OzIdPgn0liLXkxNYU/waHrwMTS7QHBxyyfCafQ1iM0dvj2NBiMYFLz9h9Mxj1rzjnQbS+WFgfal7WSxrQpFlHMenPk/v/jK/EAiWNU4BoABfH72mOyphYa7mx1pvnD0WqxemhlmhCNaNxGZ5jkTNFVimjVidWMTUp0rqOWkO8t7T7UJpa51CGFPgE3jvhZfnJgb3fifR175bw8RZxFdrlHslq5OBiNcAfRv6W/0ii4lYN8RbTwCnyu7xtiFQ6AjXW8BV+jcyBgjsiUC2okZb0WDw+3hdPfpstYvffryLAWncqsfe3N9PoLhHqkJ8SyjrA9Y1tUX/D8ybHWnOPyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkMU2q8ZIUoAvO3C3t0yulS110puK3YYB2k4UZo5Ngw=;
 b=WPkKpB7FKiFPHsmPTnI/aDwj1dBz2ihP+XWkyICkiO+zgEGAuNikCvENw11v7LY1ZDOxZi54R3DTVM9PxqJ6y79x+0Os31nNm/uLkghmNSwlsh7UkB6LLHlzpIKsenVnyTV/cAXZQNIdf2lxOW3ErnL16cfKcq6gb1uU5Ek4xI3YwN6rfAtiTMWcpwMCRpZ3oSmsRbbM9I1aPHHi1dGGaiPuB46sSs4hHcVgv/Rbw/H2YiIy9/QPexCCOHuKw0J0n+JnAMwRby+33agH8bjVaTsQo4aex1VOvrNKDyCK/Po/tpvcA3nTsZum/AQ5KBY/qNIFlYU0+KZ9PBuz1l+DuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by IA0PR11MB8302.namprd11.prod.outlook.com (2603:10b6:208:482::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 05:17:50 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 05:17:50 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, Jiakai Xu
 <xujiakai24@mails.ucas.ac.cn>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>
CC: "robert.mader@collabora.com" <robert.mader@collabora.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] dma-buf/udmabuf: reinstate a reasonable default size
 limit
Thread-Topic: [PATCH v2] dma-buf/udmabuf: reinstate a reasonable default size
 limit
Thread-Index: AQHdR8/Ka7Jds4c1EUGL2fKq+gaV6LbYnOwAgAC/otA=
Date: Tue, 22 Sep 2026 05:17:49 +0000
Message-ID: <IA0PR11MB71850CE89762EE05B36B7DCEF8832@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260919004222.4141024-1-xujiakai24@mails.ucas.ac.cn>
 <d91e2d04-cb8a-4c34-9e7d-e8faf2dfe79b@amd.com>
In-Reply-To: <d91e2d04-cb8a-4c34-9e7d-e8faf2dfe79b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|IA0PR11MB8302:EE_
x-ms-office365-filtering-correlation-id: d300d646-c76e-48db-df72-08df1868d8a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|4143699003|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: ljXm2UOOGeJVyq4pwq3Ho10oX7uHb9ugO3f5zr9J/kXG9jDxnQLzgcRWugA0DucLi4thh1P3JWPe7hn8ZIIm7PmU7rLJvJert/uFqHx78MjSF6sG5oBBXqB+vmHybuhGmdlLUdZrH7jZTaoWHFGLimmGxqpjVi7PMIK0+Yw8TW5iMmF2qrKGgS/gbMrZ4LYxSsKLixisr6q2iVPPLuaZflWIKKMEeLaMX9oGMbUDT96OPAZDw4ZHfYIl58AqblAc7WJStjBAXDhumsEogKFYxGLwBdSqLyjUOfAydWA5h0Jst38zdVe4YUBTCYWEKNFTRschwCRtxx96eDgTID+lg5Po0bGqDb657xb0wbBdQ3vww9oycd+sL6QNlc8T28QMRlzDwVgFclVJ5MZ8xx8N9ohjjFQ+bmcV6tG6ik1w9o34If83P+UTdq8PlJqs/O7TT0fj22MyDLSgmCl+zAhDbnqGR8w+5asWu0POdfWt+KZvspyesnvAuF4F6EWBeXZbEJJIMeX9ge5DyiCjPoyRWjCf+9Xp38idxUO590tCMy6JOLOtzEAm7wvv78Q4jgrJfwFqk3U/ERKbzeAxJCQhkF1zdENctEHNIwPTKlyD+6AqlzUQl88HCAzjpiGMrDT+HKCav3++YX71E5CnQwXISWKQhlQlgOnA1//9rOL/uPYpEh/Ld2uD8zWuvuxB+N5N
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/eyDIVAkrdt//muwnILct0k++5l79P3SHQKh9pWDTgkzN2nJZFkQ20waTB?=
 =?iso-8859-1?Q?vYQHRV/YfwBwL7Cj/+RuO2aODhrG6UQSRvJZF/dNeNOkFIs2JHiMNtRn6U?=
 =?iso-8859-1?Q?2FZAj1yq8QP6ob9+1dPIPVGYiuEkk2nRma4lP0P5gl2W9RJSVBWXr5qA2t?=
 =?iso-8859-1?Q?CE2fjNsph0pOE2dvYcSDUga3wqGqmX2KDUBL2ldIN8YYDOlpJPOXjzIHMu?=
 =?iso-8859-1?Q?po734n3CHwFm2p27dTLbRvSqSYEyknTuhq8ZUrmG+mxJhUqu64IecgXh6D?=
 =?iso-8859-1?Q?PmxAEunDkQQtALWzsEAgZRrPSwiOgp99Oya7mvhOXBWDwKiFHIg1fSkoRC?=
 =?iso-8859-1?Q?8ozBdbhq1NQ7E37Jad9s2TvlLD/5HeLgc+HvqORPjcPVdilGffN51U9K6o?=
 =?iso-8859-1?Q?b85ql9Regp1Fn10h0zOCPTZVXV97sDri+Ex8Ey6HbH1DtJ+5W6fcZnYFiZ?=
 =?iso-8859-1?Q?kP/86Zdatj3u9KkPTj5rYYE8Zx9yNvZlYGYm4/YStc1Erm7vf3v2CbRmcl?=
 =?iso-8859-1?Q?8nuRiKRdTA/M1jjKM2HvLJvo75akd4cgfgeDtkxu/U4/QNALj2gP3ZnjNn?=
 =?iso-8859-1?Q?VpQPResmKrSiZiGYdn/EIpIREGJk78X/nbMha/a11/OMFXDutI5o4m8ZSh?=
 =?iso-8859-1?Q?qIWjaQbmCGKLrhKlWMUKNOaceytu5cG+F4q7SYaRgrHnmLrThCXXYIN22N?=
 =?iso-8859-1?Q?ki96t8T25lab/9Gz2ZIMsYqxUDGHDwGDTu/hFZANIGcXq48WKh8229pQRN?=
 =?iso-8859-1?Q?t4Jv3U8rf0hFje9uvM8sPzh6uNWfFkEZM162oOhXS4OmK0bYScXbSQTh9q?=
 =?iso-8859-1?Q?x9o0WXh1WCOCWJlHj35vr8Gwh7e/FUkPJQf6w7ARxUQ+NxNRn0aISDDIkM?=
 =?iso-8859-1?Q?eviEtNaif3sExmWR7t8oSi9Np4bCBMIvFdxJdlsdKWaXF4N+cBkqje2up2?=
 =?iso-8859-1?Q?9ysXIWQsI+vpWthpDMJfpDnSqgsgfhYD8SKQ5uwpuLQzzLhKy6/AJsB9qZ?=
 =?iso-8859-1?Q?KpQOlFuDOn5x73GHILZ5uqiUrGgxVFfkVbTR1w65L3LaIWClfnz05cmovg?=
 =?iso-8859-1?Q?FD3jdEI2RHT6Ut+vbj5qHuvE1fYFgiKQEHo7v0KwYYUqhY3Er7Hu/fLsKg?=
 =?iso-8859-1?Q?gxi/VZdD+fmhuTsPb2JP9BMOqo/pwnM8b98I3vBCLNuodIwB2Ep+82f739?=
 =?iso-8859-1?Q?ykqnkBMg02ml2J69wRpoMZzkAyg8ym1O9AYcxfVzgr0IeNd0E7rPuYeuFz?=
 =?iso-8859-1?Q?SzdqAY4LnDBC1xLUSpZJnzV2PsXLaQn/FEvgU9vTx+vgUEl1xs5FFJgj7i?=
 =?iso-8859-1?Q?xmmS0fCu9FbNtvIqME7scoDOKY/xLUlFHipQkOlWjpV+tWwXR1RhUJvbAR?=
 =?iso-8859-1?Q?Q2YNyn9zdOK+AVygoxsxfmiJGLdb1YtkmwU8cBduk6GnaxeeFrGEMy5BL7?=
 =?iso-8859-1?Q?648/i4tVaomr3bDtR178yK3FBuXf/dil6kQZdVXgFhQ5gVGyTAyTS1t49l?=
 =?iso-8859-1?Q?D5A19SDg08I/n/yiq+sxVRHwduS7iqnSqdpvgFrTPWyrZ8U9d9ewyq16A6?=
 =?iso-8859-1?Q?ueXTYAT+c1Trj04VY/P44J7+F4VnYB6Xf5867VJIsW+dlH9HIiSWbGcpEM?=
 =?iso-8859-1?Q?Hl1vFlZxsF74lxAaPqVI5n8PyZa8nT0dZBHs0NFZTb4rZX7YPLir9UUefO?=
 =?iso-8859-1?Q?0yJIW55PXHVctjQD7+0gOLYdNPmPJHh/7JDXenMenAhhj8EIdV0br1JDuN?=
 =?iso-8859-1?Q?d1S4Z/x8eGccdv+BNmqiqsHJZwg6K9U/pp9+1nzEs1xYH2IRbtEpk4NEVk?=
 =?iso-8859-1?Q?v/KShPKo3w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: odADnJsHt2//CB5UVo50q17VBZ4KqQLPVgPSgZBD8bGlqBWt8Iesnd438IxsraxX2Nb5X75PncNoophxDa00TlCFgIy/DzqdJDKmkz2W4IgcW3L6sRsI9hVgvCgo9phPP2euQP1FGbCmlYKTWtFkZID6X7kjl5032j5H6PzOoXZCrGXFzGH0CXKm2/XaNz+4ikpJqXN/PGWevHlX0vSEkG70YR/b6joPsaGZMHCRt1uYRYuvbc1zY+/R5kvt5MbSezH2Mrh7suqWrAlTTyMlMWnzE9h3w5aYmHJgxaJsp2vJkdfaRWIHNKzgr0qQHHBAW7v6V4r8jMItRTmdSpGcnA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d300d646-c76e-48db-df72-08df1868d8a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 05:17:49.9828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iUCI3zry3ed3sLcwhVbJwL9Pu8ovhB3OfGVaQi/ynUzk9IhSlu9a7Yzx8ecdEaZgJb8Ec9TVQO1OkUnFmJ403qmDx1qJq+mccYEaU62GzsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8302
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

> Subject: Re: [PATCH v2] dma-buf/udmabuf: reinstate a reasonable
> default size limit
>=20
> On 9/19/26 02:42, Jiakai Xu wrote:
> > Commit 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by
> > default") raised the default size_limit_mb from 64 to INT_MAX.  With
> > 4K pages, creating a buffer of more than INT_MAX / 8 pages (about 1
> TB
> > of pinned memory) now makes the two per-page pointer arrays in
> > init_udmabuf() exceed what kvmalloc() can handle: kvmalloc() warns
> and
> > fails when the requested size exceeds INT_MAX bytes
> (WARN_ON_ONCE in
> > __kvmalloc_node_noprof), which is trivially triggerable from
> > unprivileged users through the UDMABUF_CREATE ioctls:
> >
> >   WARNING: CPU: 0 PID: 412 at mm/slub.c:7021
> __kvmalloc_node_noprof
> >   Call Trace:
> >    udmabuf_create
> >    udmabuf_ioctl_create_list
> >
> > Restore a reasonable default limit of 256 MB, which is the value
> > proposed in the RFC discussion that led to commit 44e9eb5a7621
>=20
> That is way to low, we want to allocate multiple gigabytes using that
> API.
I am wondering, what is the use-case that would require pinning multiple
Gigabytes of memory via udmabuf?

Thanks,
Vivek

>=20
> Please make that (((INT_MAX / sizeof(struct folio *)) - 1) >> 20) <<
> PAGE_SHIFT.
>=20
> That should allow to allocate a bit below 1TiB again without triggering
> the issue.
>=20
> Regards,
> Christian.
>=20
> > ("dma-buf/udmabuf: Disable the size limit by default") and
> comfortably
> > covers the 8K video use cases cited there, while keeping the
> > kvmalloc() request far below its threshold.  The limit remains
> > runtime-tunable via the size_limit_mb module parameter for setups
> > that need more.
> >
> > Fixes: 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by
> default")
> > Assisted-by: OpenCode:DeepSeek-V4-Flash
> > Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
> > ---
> > V1 -> V2:
> > - Instead of adding a pgcnt check in udmabuf_create(), restore a
> >   reasonable default size limit (256 MB), as suggested by Christian
> >   K=F6nig.
> > - Drop the second Fixes tag; the regression is solely due to
> >   44e9eb5a7621.
> > - Drop the "Cc: stable" tag; 44e9eb5a7621 is only in v7.3-rc1 and has
> >   not shipped in any released kernel yet.
> >
> > V1: https://lore.kernel.org/all/20260918013434.1849135-1-
> xujiakai24@mails.ucas.ac.cn/
> > ---
> >  drivers/dma-buf/udmabuf.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> > index df6dd00462423..4d90c2cb14225 100644
> > --- a/drivers/dma-buf/udmabuf.c
> > +++ b/drivers/dma-buf/udmabuf.c
> > @@ -20,9 +20,9 @@ static int list_limit =3D 1024;
> >  module_param(list_limit, int, 0644);
> >  MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit.
> Default is 1024.");
> >
> > -static int size_limit_mb =3D INT_MAX;
> > +static int size_limit_mb =3D 256;
> >  module_param(size_limit_mb, int, 0644);
> > -MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in
> megabytes. Default is INT_MAX.");
> > +MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in
> megabytes. Default is 256.");
> >
> >  struct udmabuf {
> >         pgoff_t pagecount;
> > --
> > 2.34.1
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

