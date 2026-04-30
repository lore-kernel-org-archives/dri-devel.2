Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363EBFF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 04:12:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A103010E08B;
	Thu, 30 Apr 2026 04:12:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Bh/EzNCb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8DA610E08B
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 04:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777522332; x=1809058332;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=38XitNDJsW/Yr5TbTj5m1nnV95Zd7q+P9qlNXM9JwtQ=;
 b=Bh/EzNCbIrUFwKjfXGH3riyJr352Qm+7rdFJeAj7Z/yS86x+H+VoKYp7
 nhytaaO7QdnB0HoB6He85OMczck7U0cj+8vdGAcy2Kqfd7znXpfLRwXen
 wE/9QaVlZucoJNG+XpNZCjaR0rFlw9SA5RD+2tZwtx0Cn4XzKrvagyTkP
 +PgJC3ExGXGvf2bec3m7W1w9y6kQktew2N2Ql1HvWgBS5LVog19mZt330
 ErzgroRWsQ17a++9EErayaHy/ghcqb/TMRQYQVA1B13zaOyFfw+IdcD2X
 n7CT5WjvviRUNXdQzuOq9Hbv/5OeUQEeMK/g3EX5sbBD44i0mCz+fQ0ni g==;
X-CSE-ConnectionGUID: KmAiTpm2Q0OZlHs3wtRKDw==
X-CSE-MsgGUID: GSxyuqIkRnWeN0x6UJvPxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78175270"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="78175270"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 21:12:11 -0700
X-CSE-ConnectionGUID: 0l63f6KbTZqgT8u4iSzQ9w==
X-CSE-MsgGUID: TxHOuTORQIWMqCuLOddrxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="239487523"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 21:12:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 21:12:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 21:12:10 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 21:12:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAOU//p0JAklbkTCyJ6EFcDCtM1Z4sP4r2TZeN8C6XLYBhkrl+3mWHcDxjMi05Ib1Q7y4bX/UbWP9XTyMgVYZUeFBd6oAV8lHkyUWOmNi53vgHwlWO2qPRdX1UCggJuPg22ccyQ0wVbp1ibCNXOhiMwP6XtPUTcAZKTjWqYYOEHLlQtCJtjQIqiVwMADP8s6ZLakQBy2V9gvIQhuMyQ5yLBQ9Tp/oQoNIcTVOkFegFRNoWcrc9OZ6Wl8rhfnOnqHNrDzxQt/3VcQQPa0dm7g2rqH5UPF1afcUWKxV87VWPvWHWrQ0xP+hT/mu8Mh83L3Xo0RY+or2FhY7xjdUNd2tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38XitNDJsW/Yr5TbTj5m1nnV95Zd7q+P9qlNXM9JwtQ=;
 b=PMDwbe27PFOhKM74aJHivfPDlHHcg5qeOs8NSO+J8xA9a41qProlSn7BgBlgWGR/jndY9Sd1MSvoVDsPF2y3RGGgKjLHQImoVDctydi98O5/kw1afadN9h+7RBIaWEwESTpkiNUSiPVkI0HTD9uMjZtpEfgEyunG/UjjQT5VuomKXnQYIiQf7QOZfYLIJ97M/xfFpM3fgN8BPFDr4F5+ApfXT+nksMzFJTvK6IX8cHND4MFYMAQ/p4P6eZEG759zbNwcbZxNJOEv5QQUPSQLAH9iDgfrZcQK44HkMf2imXIDESK9jZLdjlH90P33RIwtbqg2nOdgNs5JZ5PtqVnVDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF64C459891.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::27) by PH7PR11MB8121.namprd11.prod.outlook.com
 (2603:10b6:510:234::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 04:12:06 +0000
Received: from DS4PPF64C459891.namprd11.prod.outlook.com
 ([fe80::c3e1:d65c:ef8:9934]) by DS4PPF64C459891.namprd11.prod.outlook.com
 ([fe80::c3e1:d65c:ef8:9934%6]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 04:12:06 +0000
From: "Sworo, George D" <george.d.sworo@intel.com>
To: "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] drm/modeset_lock: add NULL check for ctx before
 WARN_ON
Thread-Topic: [PATCH v2 1/2] drm/modeset_lock: add NULL check for ctx before
 WARN_ON
Thread-Index: AQHc154XNv4vkZTN8UOQW7PJtHrkFrX14fgAgAEdzAA=
Date: Thu, 30 Apr 2026 04:12:05 +0000
Message-ID: <4f569465fd754399b5cd0a1029538249015fce43.camel@intel.com>
References: <20260429025952.1202080-1-george.d.sworo@intel.com>
 <20260429060431.1462589-1-george.d.sworo@intel.com>
 <20260429060431.1462589-2-george.d.sworo@intel.com>
 <afHm1k0K0mDRPmJM@intel.com>
In-Reply-To: <afHm1k0K0mDRPmJM@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF64C459891:EE_|PH7PR11MB8121:EE_
x-ms-office365-filtering-correlation-id: 80714ffa-0841-420a-6766-08dea66ea3f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: O0RSNzoikSeVz+9V+YFhQXMskHGTp63i9onlwG3aHQOsEmHO28z70WJcJmdozuX7oPV2QJpC2gT+T1hinA0gb9xqPnnYeyse+8niskO7KFaWd6M7j4c2Vr49EVfkEhxzsnyCrdCIpkXTA6ZS/id5a3+XWH6hk/qqy3rEhAkUkmxgmJR3nzpTH31Pt1Zkvv93PgYRaDpBKJM+jvGDOlHGEY4dblCLX6MwJD0NpcTvCEVORab5X4u5aEqgm1rNjEr9yo7dZ8zgGWp4gIVWAadgkCHx23fOKJv1L7XJRfiviH8KU5TDEIObSFTw5DMCpViJOyLQjHI0bz5C+rJereCsdMFhecQSc+ltz+/sQHA4wJIZds/wN/yDlyvcX0Sef2XFLoNtTeOGDaXN/3cDGM5QN11h5cf5JHgzLifYy0mYqwVn7ZW0JbgL1HWHOlbLCvmHayV4CDNWlWlfcMiMZrzNxVPjN0gjCR6igCVH/7EudoX+msWxyFnuZ5nSNKUeW89cvPvnHAAcshd9KN1XVIEl0wsYgqO1sHEx1lIwUk5TPnSzLHpkjeUnBLKDQAhftNoQog9tGzdXAyvNaUVGoFlaq9MLWU5P2/j8cxp5cuext7yzUB+zUKYLgB1vou3CJMw9yzRYHF7vt3/6tUlhSmv2UthVSw0FB2no6fMpuqLd1zC/TDz1KU6DaDSWjCta1/Q2eK6nD4dCCMDIeHim3yZzRHBRgpR+DLq8wbispz50dHNdVRqBBWSA0+oOfVNvZFT/ZRQ1NZzoloYsOf2dCHHAVKrDGWQFe7jdZ29DecK6Znw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF64C459891.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2wzM2Eyd245YkRPZDJzeDBBRUJzcWEwQnVzU0R3UjY3NVZKQy9GaGt4RytQ?=
 =?utf-8?B?Z1VxRTBRSXFiT2Vsd2FYY2s5UmgyS1dKVnB1VUJMVGxVWWREazIwSmMwUWZm?=
 =?utf-8?B?Nm9nbWM1TjFId3BvS3JOeG5pM0t0SEh2RHdiUithbUlDQzlDZGt0SXVFbVVL?=
 =?utf-8?B?N0dSU0RVZUR3TlJkUi9vUTF1dTZlRVRneVdPRll1eWVCVGVMS2VIUlBxUUZv?=
 =?utf-8?B?TkdZcWx1MU1QTnc2dGNybnYwNmpXcHBtanphTis4TVREOG1obGkyN1pqWGxh?=
 =?utf-8?B?QW8wcSs5OHJVcnRuaktsMFUwZ1RWQ0dhRjQzL0RSZUY5czRiMFlPU29qWnYr?=
 =?utf-8?B?dnpoZ0daV3FiZDAvWUFsMUY1L2w3OHMwU2JKaldFNXR2MEZzTXZxbXRVUjJQ?=
 =?utf-8?B?TkxxQjBZSUpUclFxZkNFdGkzQmJWM3hNR1dXQXZVaC9TZk81cGIwRWVDdXJN?=
 =?utf-8?B?NnNucTljZW05UVhNd0xGZFlmVzI1ZkVjZlJCaVVvT3AyUVhpYUpKR1VLYzk5?=
 =?utf-8?B?Zjd5MXJaNVNMUWZmT2lhczF0U0RWZEtVdkJjQWUwaUh5VEw2N0FGWTV4R3Q0?=
 =?utf-8?B?ZU5ud09kM0tRa0NGc1FRQ0U0aEorZjMzM09xanFCcmdUbVRiaFd6NlJBdy9X?=
 =?utf-8?B?QUpGYjd5eXlYdGZZYkZ3VDFjZnZDMEREVDIxeE1UNkhWU284R3AwUFhVeU82?=
 =?utf-8?B?SWZlSVkrSXZ1cWwzbmUwcGtlbVg4MjBZUStOUW9naG1jUEdZaWJLOWRoREQr?=
 =?utf-8?B?YTNQQTBJUnM1VGFTVXBoVndlSU9ld090NGNlRVVucm1DNkpXTHJUekZNUWFW?=
 =?utf-8?B?V04vZ0ErTkl1elJOcDB3d1RZV0h5dlBRakZBeVFMVURtLzNqeWNHQndSQ0VV?=
 =?utf-8?B?WVRnYUNsdnp6V3dqZ0VqUFpvb2x0b0tkZ3pLTzZ3VW01ZW9qSE1MMkhOYUdN?=
 =?utf-8?B?Qyt6Wkttc1ZLQUpkOGx2OUk0NzZsL1M1YXZNeUppTDd4UFpaNEZCM0Z3Z3Zo?=
 =?utf-8?B?WmFBSUJ6Znc4ajg5dTQ4ZkZGc3lBVHdqQlFPZzdjWDhtUS9GeXo1RHJ5bFZq?=
 =?utf-8?B?SWQvdGVzNWcvSGI1WXVpeHRzbld1OHZBYkt0OHlNR2ZPK3d6dzRkOW5yK01K?=
 =?utf-8?B?bjVCZmpFekZZa290RmxSYUVMVEpWYkpEa3JZRDRKbFFUYjFCSjdWazQ3L0FM?=
 =?utf-8?B?dVJkaGxhQisxN1R0NXFIVC8zS1pWN3I5Tjh3RDhCSFpDMlpmQkRRcnF6NERW?=
 =?utf-8?B?UGVqWFptTUhRM0xwZ1FzbnZMS2VSTC96TW5lMDZ1OTRCb0gycERsMWl6dHlL?=
 =?utf-8?B?MDlFNjFWbllDeENRemx5a2JWazZiTHIxZWFMbFQ3N2gxRE10cWF0bVNrOWhP?=
 =?utf-8?B?cGxJcW1xOG1hWVVUUkxnaHVxUEh4TkJpYXZSckwrSUtIUUtNaDI2bUg4dWM0?=
 =?utf-8?B?Z1JMcEtKT243VjREcmJ1L2JOeHRMaFIwcEZlMkpyTXF6eXAzWTFVUHJPRSsx?=
 =?utf-8?B?a2ZVYXpNZVlESmw5amFSNUZlUEczZmpHd3ZZTGVLTEFkNXRhdU1iVU5tZzhp?=
 =?utf-8?B?S0UzTzZaMDZZY3hpb0RZZHlIeVordVd1SEEySWpCazRzZzAybDI0Y0ZvTklK?=
 =?utf-8?B?T2dFemFxRjJTM21tRkJFYzdEVzdsZ1RoS2Q4dk16K1lMbXpHTEFDVHM1bCsw?=
 =?utf-8?B?UnlYNlRDVlBPRWxCcWxWSlF5WGZObmMra2JGWVZ5b2Z5bm9IbGFYNFNUalNm?=
 =?utf-8?B?ODBmM2RJTSsyWnFuK2UvRVM2ZHNXcDIrdkdsZmxIRlNoUjAvTDc5MU5VQ3Nk?=
 =?utf-8?B?UVNUU2wzNzQxWDVZd1FXbEF1Uk5FaU5wa1V3M2ZWTitUMDZEVlJsWXhLcFcr?=
 =?utf-8?B?aVZBNm56YzJHUUJyUzVNbEtwRzNrSFlGSWZCS0FtQlBYbGZkZHc3UDlIWmxH?=
 =?utf-8?B?OE5zS0Nrd0JhdEZWazRLRFRNZkxidG5zaXF3RFdmeExEZnlMMlM0QWdxWDdx?=
 =?utf-8?B?UmJUTWY5REdWUEZvT0trdi9XdnMzVXpNTTZveFAwNTZOVmxRZXB4OEcwWXU1?=
 =?utf-8?B?VkVmV09hc1gxYnliOHVOaEZVTWF5TERIY3BkRW04Y2hyN1ZHb0pPNWRLdlov?=
 =?utf-8?B?a3hac09Ib3NtM2NpUllaNWtGUXl3eTRob0tXV3lMbm4xQ0E0RUxCUFdQOWpx?=
 =?utf-8?B?TlB2VkF4UWk5bGdwUlNDL3NwL3ltVWZnbHk4Rk16QTZpYUN5eEFHYmpsbW9E?=
 =?utf-8?B?UHRWaEN3Y3RDWkhkbFVKY3BnZWlnT0VJMUlKNWF1QWhsQ2lkTXNhNkpHRUxP?=
 =?utf-8?B?YXJSTUtWUzdHcWdHRjlib05Gd3l4SVkwOCtxejc0QU1GVXliZG1HS2pWL09F?=
 =?utf-8?Q?rTZIRZfDxb5s5sVY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D182D697828BBF4A8EA6A7021B85C59C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QRku7ZrHwrbOesmyyElVjMo328MZrijrckbVgnKNlqBn76sBIynEd6tpf2ii8OYevRwjrSQNxvbsT8pv5ruZ5345lhGE+ZdZtZTGUOfT0OfJxDcmQh+U3aH1bxWlC56dki8CdSqbpnh/dT5ALxmeqCEDj8J8POauNZM7bM1iJP63Zit15c/Quq+aT3dzyxJng+BBqsiauCLoN4BOCqKfNPV619nxzxYejJghRv9lHJqPhXrenM7Npzpal+ewAPJ368RqF/I80TjDWcGIcZtBiuJWNqUGw1XcXfdJ74+Ff11EyGrAnuBpvGKhuSctvLt1PKj0MrEj9dwm+HPfl9ZvUw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF64C459891.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80714ffa-0841-420a-6766-08dea66ea3f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 04:12:06.0332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5mPvxc2F8taMzLgzH0Rs2jG7Pm/FoISPQPDvNS5N5/sSwAr6d6CHjs8qupbMQUAsYWKC32TSJILnaa66jNATX4upg9J3Z1fDefelzKmWrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8121
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

VGhhbmtzIFZpbGxlIGZvciB0aGUgcmV2aWV3IQ0KRmFpciBwb2ludC4gSWRlYWxseSwgd2Ugc2hv
dWxkbid0IGJlIGNhbGxpbmcgbW9kZXNldF9sb2NrKCkgd2l0aCBOVUxMDQpjdHggYnV0IGR1cmlu
ZyBhIHJlY2VudCBkZWJ1ZyB3ZSB1bmNvdmVyZWQgYW4gaXNzdWUgd2hlcmUgdGhlIHN5c3RlbQ0K
a2VwdCBwcmludGluZyB0aGUgY2FsbHRyYWNlIGFuZCBJIGZpZ3VyZWQgdGhpcyB3YXMgb25lIGlu
c3RhbmNlIHdoZXJlDQpjdHggaXMgYmVpbmcgZGVyZWZlcmVuY2VkIHdpdGhvdXQgYSBndWFyZA0K
DQowMy0yNiAxMTozMzowMy4yNjEgICAgIDAgICAgIDAgRiBCVUcgICAgIDoga2VybmVsIE5VTEwg
cG9pbnRlcg0KZGVyZWZlcmVuY2UsIGFkZHJlc3M6IDAwMDAwMDAwMDAwMDAwNjkNCjAzLTI2IDEx
OjMzOjAzLjI2MSAgICAgMCAgICAgMCBGICNQRiAgICAgOiBzdXBlcnZpc29yIHJlYWQgYWNjZXNz
IGluDQprZXJuZWwgbW9kZQ0KMDMtMjYgMTE6MzM6MDMuMjYxICAgICAwICAgICAwIEYgI1BGICAg
ICA6IGVycm9yX2NvZGUoMHgwMDAwKSAtIG5vdC0NCnByZXNlbnQgcGFnZQ0KMDMtMjYgMTE6MzM6
MDMuMjYxICAgICAwICAgICAwIEkgICAgICAgICA6IFBHRCAwIFA0RCAwDQowMy0yNiAxMTozMzow
My4yNjEgICAgIDAgICAgIDAgVyBPb3BzICAgIDogT29wczogMDAwMCBbIzFdIFBSRUVNUFQgU01Q
DQpOT1BUSQ0KMDMtMjYgMTE6MzM6MDMuMjYxICAgICAwICAgICAwIFcgVGFpbnRlZCA6IFtVXT1V
U0VSLCBbV109V0FSTiwNCltPXT1PT1RfTU9EVUxFDQowMy0yNiAxMTozMzowMy4yNjEgICAgIDAg
ICAgIDAgVyBXb3JrcXVldWU6IGk5MTVfZmxpcA0KaW50ZWxfYXRvbWljX2NvbW1pdF93b3JrIFt4
ZV0NCjAzLTI2IDExOjMzOjAzLjI2MiAgICAgMCAgICAgMCBXIFJJUCAgICAgOiAwMDEwOm1vZGVz
ZXRfbG9jaysweDc0LzB4ZDANCg0KDQoNCk9uIFdlZCwgMjAyNi0wNC0yOSBhdCAxNDowOSArMDMw
MCwgVmlsbGUgU3lyasOkbMOkIHdyb3RlOg0KPiBPbiBUdWUsIEFwciAyOCwgMjAyNiBhdCAxMTow
NDozMFBNIC0wNzAwLA0KPiBnZW9yZ2UuZC5zd29yb0BpbnRlbC5jb23CoHdyb3RlOg0KPiA+IEZy
b206IEdlb3JnZSBEIFN3b3JvIDxnZW9yZ2UuZC5zd29yb0BpbnRlbC5jb20+DQo+ID4gDQo+ID4g
bW9kZXNldF9sb2NrKCkgYW5kIGRybV9tb2Rlc2V0X2Ryb3BfbG9ja3MoKSBkbyBub3QgdmFsaWRh
dGUNCj4gPiB0aGUgY3R4IHBvaW50ZXIgYmVmb3JlIGRlcmVmZXJlbmNpbmcgaXQgaW4gV0FSTl9P
TihjdHgtPmNvbnRlbmRlZCksDQo+ID4gd2hpY2ggY2FuIGxlYWQgdG8gYSBOVUxMIHBvaW50ZXIg
ZGVyZWZlcmVuY2UgaWYgY3R4IGlzIE5VTEwuDQo+ID4gDQo+ID4gQWRkIGEgTlVMTCBjaGVjayB0
byBwcmV2ZW50IHRoaXMuDQo+IA0KPiBXaHkgYXJlIHlvdSB0cnlpbmcgdG8gcGFzcyBnYXJiYWdl
IGludG8gdGhlIGZ1bmN0aW9uPw0KPiANCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBHZW9yZ2Ug
RCBTd29ybyA8Z2VvcmdlLmQuc3dvcm9AaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVy
cy9ncHUvZHJtL2RybV9tb2Rlc2V0X2xvY2suYyB8IDIgKy0NCj4gPiDCoDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vZHJtX21vZGVzZXRfbG9jay5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0v
ZHJtX21vZGVzZXRfbG9jay5jDQo+ID4gaW5kZXggYmViOTFhMTNhMzEyLi4yMDUyYmI5YmI5ZTUg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9tb2Rlc2V0X2xvY2suYw0KPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fbW9kZXNldF9sb2NrLmMNCj4gPiBAQCAtMjk1LDcg
KzI5NSw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IG1vZGVzZXRfbG9jayhzdHJ1Y3QNCj4gPiBkcm1f
bW9kZXNldF9sb2NrICpsb2NrLA0KPiA+IMKgew0KPiA+IMKgCWludCByZXQ7DQo+ID4gwqANCj4g
PiAtCWlmIChXQVJOX09OKGN0eC0+Y29udGVuZGVkKSkNCj4gPiArCWlmIChjdHggJiYgV0FSTl9P
TihjdHgtPmNvbnRlbmRlZCkpDQo+ID4gwqAJCV9fZHJtX3N0YWNrX2RlcG90X3ByaW50KGN0eC0+
c3RhY2tfZGVwb3QpOw0KPiA+IMKgDQo+ID4gwqAJaWYgKGN0eC0+dHJ5bG9ja19vbmx5KSB7DQo+
ID4gLS0gDQo+ID4gMi4zNC4xDQo+IA0KDQo=
