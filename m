Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED005CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 11:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3006010EFAA;
	Wed, 17 Jun 2026 11:02:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cIQFFyGt";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AFEA10E9B7;
 Wed, 17 Jun 2026 11:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781694171; x=1813230171;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=xYs06wKO1Xzcjnul63PQtz+j9zJtAqTLweSR5PfMPcw=;
 b=cIQFFyGtZ0bsu2SqosNwe3ltPZzv4PS677X8ae0vl1T/VjvvwroIiXu6
 lTInBBqDTAp3NUpiEMQd9Bgfzgyf9ttYvARHcB/oY8QP7qmsPeyX0nIvV
 FlJ/5Y9/KMu4JmgcJYwTPzRbtNt8BQxR/acyvwToeHYY2HtI2cgmYhBqD
 4ipe4MxiCLIrH0v6DeMAIOnCJZSoTBhRg+QjivhTm5CpUN7vxI5LcBUDa
 F61iH8B1czPk6Cw1YBFhhdglp9CSeBLHDWX2jmO0z8yjC9TezE+LOF1Fs
 ZhC/CHdzC2T3I7GsxxxiYYGoJMSLycI+M7H2FtJmeOQJmYSFQPdN+Atbz Q==;
X-CSE-ConnectionGUID: NNMSJ44ASsOLG6qBcvadtw==
X-CSE-MsgGUID: v3pXIjy5SPik0ItbLQP8sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="81480136"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="81480136"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 04:02:50 -0700
X-CSE-ConnectionGUID: zUm8ggRHSXad4Qfu47THTQ==
X-CSE-MsgGUID: /sSL5434RQWwkC0Y+xOiXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="247907236"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 04:02:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 04:02:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 04:02:49 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.64) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 04:02:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwVOMn3uRF/GM+DezFgbt4ME8O6Ma/i9BqxM1DsIuXoGGhZMOiGMt7cQ/hpFRXqXxbAirdAEJSbXiWy8ceSDjeB/GIfxJ8tX4Kkd0MhuCFZU/BpQ/ahIxcNN7L2OqCCKLDATyY8jNX1ZZaI1S4jDXbp9rDwuN+lmeJEglAxfDyoo9eOoe4FmKqEkbN3U3oJ9hdyA+HhpBFHvwFcqtlMJCTyt+cAgPaVBeFQhHAGdK6Ygzth95CIr4i8TdQ+VVayLrcuaTJESEXj7Nyi2ndfgtabCQP9mKJE1VRPFgayJXuShqGbelGrTVcxkKmog8TiTe9n06gwOnePPA64l04BMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYs06wKO1Xzcjnul63PQtz+j9zJtAqTLweSR5PfMPcw=;
 b=KYk4Ez/d8lQbA5BbdNCHUE4MSJxnQpa7Bo7wwJRAiSsfOUkvUj4iPiZWgqXpckcytNolfnBUcPhBsPPi7XPcz2AwBz+K8IJBqCKfkvYF2NZU7aTTtfPHRr0Ph8SjSs/YTjCsrHDu11Ux2KjqxconqBDLVBZOFXQrFUK2euf877ZHRYUs1eZykZoGGXalFr9k13d5kTVxglvIJWq59/I9H9bqgxJWcsXK2+2ZhjzAgiaOGOV3/xt5ed20C3Hx0FckDUMa5XLKgCfgfuxZY+ZxXCxJ7joXSPof5hw18fGldW/NSDUY5XXoSRcO8PRkpxfSUM7pCRDRL9gXVn23Yty1Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by PH7PR11MB6425.namprd11.prod.outlook.com (2603:10b6:510:1f7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 11:02:43 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 11:02:43 +0000
From: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
To: "Jadav, Raag" <raag.jadav@intel.com>, "zhanwei919@gmail.com"
 <zhanwei919@gmail.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "corbet@lwn.net" <corbet@lwn.net>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "Brost, Matthew"
 <matthew.brost@intel.com>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "skhan@linuxfoundation.org"
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH v4] drm/xe/hwmon: document DG2 fan speed reporting quirk
Thread-Topic: [PATCH v4] drm/xe/hwmon: document DG2 fan speed reporting quirk
Thread-Index: AQHc8qta/AL8LxBncUmGoV0OVmDUPLZCqgQAgAACSAA=
Date: Wed, 17 Jun 2026 11:02:43 +0000
Message-ID: <03460c5632c235a0a278db8ecb90bedd35718a08.camel@intel.com>
References: <ahqN8Esjz9SmGofH@black.igk.intel.com>
 <20260602161707.18922-1-zhanwei919@gmail.com>
 <ajJ86P9MvLmtbPpp@black.igk.intel.com>
In-Reply-To: <ajJ86P9MvLmtbPpp@black.igk.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5073:EE_|PH7PR11MB6425:EE_
x-ms-office365-filtering-correlation-id: 0a8d8d6a-b3c2-49c1-0338-08decc5ff4f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|56012099006|11063799006|6133799003|22082099003|18002099003|4143699003|38070700021;
x-microsoft-antispam-message-info: aclwW99r1CLKLp1pB+L00LJbJorEU0+5H5gKwmnWGO8YH9/THkG5nmJvYrkeu9NX0BjidINu5ByHf4hoyqrcHjUEyByQn1MOjN7myTU7Oa2fkfUOVLtM8QTJDwJ5zlDK6GGv/HqP460UwgKVptiRmDNqW+ISMt6nwZF11dcQdZ3mkf+cQa9SNrLon8Ow2X/Rfag0CL52RuyKaCjGuxNsCpxXO8gBR7cAjUuh4ymTnrhokXDzNFVqr15cJMAHb1BSepAnVZD4qYB4Uz8Ccf4bbXxb3/m969Jc+qviIlj/opPs1iIZHyVuaGnilG7qSgYY4ZQZSE6cyHlSzOkPD31HU9ByhBtO3ZCmlHF4byXKhpI20PpdGodgT5WYzODkrLtK4WUSC1O4xB29GjZndi1KY+CJsCvbZ4Jd4aPTFpZEC74sgMx8d9SPQJzXiL0zUX94OlfImjwm4dMPgOXIul0sZiJLiR6vf5OrqbUNG6LF1pQekzyoFeXiA/33IuGjP7damuygs6uszkOYDIuINlFfuDmvSrJkfSnaf81e5JbI7wfQZDtw5hRMTIHzw+l/+VhHFdLJXiFINCq6OX5kJ9394ErWUOSX+qgYSkj5sUduy4eVw/k7KM1J6hyAsp+t8JulhaZbwv37OV9a/cKqNMaiZOf4CrneXeOEKd69W3EGcTHowQpZZS38mkX4H1S/P15C0dehswNoPHicUZ8BLVAjDRPPsYk3qTIpqOda9WzVZHZC7UTn5hFlhSiqkUKH9sSC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHI2Q0gwdDhSajl1RkE0dVV6cldoaFZ4akYzTXhoWFBsWlN5YUljNmhhQmhq?=
 =?utf-8?B?d2ljblFZWDJoTkxpUVZvRU5QMlYyL0hUbkJvcVpXQWRYMW1SbFRIRHZsTERL?=
 =?utf-8?B?RGtFR3lYQ25uSWFUbUs5NEZPN25oZkFWbG90QTI5TWN1OEJNUzJKbG1vYTZG?=
 =?utf-8?B?UGNmWDJGeXlSWURKQXRFa0JGTTZLVFpBeTZFRGFRci9XRlhtTS93cm9oazV2?=
 =?utf-8?B?bE96ZUVaYWx6T1pJVjYvaTdRRGp6aVBIS1I4VjhzMW1kU3ZCMm8zQk1Vb1RB?=
 =?utf-8?B?SmpPbTNzS09PajVoWWNqMUFxRmNCUHNqY203aFpFR2hrcjNxK2tIRytFQzJW?=
 =?utf-8?B?aVA4eXRPaFlBZlNaSS9RQ2UrZFJJT3RsQkY3L0xBOHdXM2RmSlZTVmwxQ3p0?=
 =?utf-8?B?UGdZM3dGY0J0NXd2akR2VGZydnVrM0Y1REcxRTFhZmRvY3kxd2lhbmk4aVB3?=
 =?utf-8?B?SXRlUWtSQmNaK2ZvOWVsRVRLVEJLVk1SUkMwNEJPbnlpQyt4NXRxWUtEZWYx?=
 =?utf-8?B?dStOVzVVVzFNT3pkSE9hVHhNbFFSVUFiNUx2UEFKbVdpMEdTL3FQaEtCdWVx?=
 =?utf-8?B?bSt1ZlZOeWwwdklFbHZHL1Y5N3VQL3NDajZsS0c4WERIU1dXOEQ3YkNWSFpk?=
 =?utf-8?B?NUg4VVR0M0Vxa3BaQnlMd0s2UTVVem5wcHpmeWYyT2xDUU55YUh6VVNPOFAy?=
 =?utf-8?B?aHFkQjZvQjlIdDNjTDc0NlUrUVJGSUtnL0EyU0Z4Z1NOUE50NVcyajE0Zmlk?=
 =?utf-8?B?OW9FSFBWbTNXUnFSelZSRFZKTFJqVXRXdCtwSnlqbDZ4NEttZFJidUg2TGtv?=
 =?utf-8?B?cWp0THVXSVB0NStVS3Zhaitmam5rUmNTWG80cCtmSHdrSVd1TzJubWZsdVdB?=
 =?utf-8?B?SVlhclBrTTBlZFEzekFFKzc5bi9wVEtKSXBLbmplWFQvY3pNQVQ4YXBpN2Jw?=
 =?utf-8?B?NWZhUDZtdTBDVVFHeFZBTksrN3pab1Bvb2xGa21KZ0YzU1YrV05NeVlIb1pW?=
 =?utf-8?B?SnV1bS9zVzRRSnVUNmdhOFNTZEVHSnI2VEhYN0pjbHZBQWdvNHhUOVR2MDR1?=
 =?utf-8?B?b1ZXWVJTWE9LL1QzSzlOT0Y0NG5yTGZrbmV2dGpDRWkwbHpxOFhPZDBIcXdU?=
 =?utf-8?B?QUxQRzB6U1RvRHJuNjlaS3N6UmNvYW1iL2VJZ1l4T1BKakw4VStkK1QrYlNP?=
 =?utf-8?B?WmtTQ1dFTTdVNWtRVlRCKzlFVEhTTjNsaHg2TFhLRFVQekk0cXdUSjVEVXhq?=
 =?utf-8?B?bk9yQnl1RzZJLzBUWWgwVU1yLzBhT2VneGR3SXE3T2p4c2FZVExkNFljbUZo?=
 =?utf-8?B?NzFqaTFwUDNhRFptdEJ6V0ZxekJNZEtQTFNPdmgvS0hHQ1hvbE9udWJoUXZU?=
 =?utf-8?B?RUV0aDI2QnE4OVpYa2doaXFoRzJ1cFh6SDU1NkV4eHc3bFBOQlE3R1BES21n?=
 =?utf-8?B?cVFHNGNWM0Fnc3piLzhFM09xcytIbVl6ODVNaCtCQTNEMDlZOU1lUzNuSVhh?=
 =?utf-8?B?QkxwVE0vN2ZSTjJlaTlNYy81SitMekhtZlljRitWT1dzS1JJUFMyWVNodGQ4?=
 =?utf-8?B?OExuSUtwNElRK0ovbk1Mb0YyT3gyc2tqWGJ6ZzFHaTZsNDczU1h2SU9kSTE1?=
 =?utf-8?B?V0g4QXRlTUF3Rlg3UC95ay84ditXcUZhQVErQ2RDOWd2YlZlTGFKOVkxenhH?=
 =?utf-8?B?Q3NIanlEdWlnYmlKd0FuUk1Mb1V4TllRdk5FaUdGSUZzam1qUXdDcGV0RkYx?=
 =?utf-8?B?MjFvTE1TeGFCUXAxOGlsRFlqdi9xdXM5a0ZFcWVEU3RPazRWNCtERzhQdG5I?=
 =?utf-8?B?V0NMQzlHMHZkYngxR1d5c28rNW1JL0sxaVUrNVNDL2J5L3Z0NGFCQmRlcEdJ?=
 =?utf-8?B?cVNQdFI0dHRqTEhtbDhYSTJQVmpjZmtWNXBvMWFSQ1cyZVlsa1hEaExXRGRp?=
 =?utf-8?B?UzJkTGMzNkZMZ09lK25FRjlXT1VxQVo2ZW5xSmF4Zkc1TzJ3bFcrQWIydEYy?=
 =?utf-8?B?Rlo3OFVwR1hRTHJBVzM5N25jWlBWOXNISHFzVEZQeS9GK3pIR1NuUUNGdWEz?=
 =?utf-8?B?eDJTNnVoZElGOWtIM3JKeklHdUtvVldMRm13NkpNQkxPUC9RdkpjZDYxVFUx?=
 =?utf-8?B?WEhkWEREWTZmQU0xQ2c4WERPRlZPQnA1Nk4wL3RhcHBuQ3RleENtN24zMkcy?=
 =?utf-8?B?SGdCQm1raW95cnYrNTJ3R2xlR2pESHlWREg2QXEvcndRbTRCVWRPUmhtd00y?=
 =?utf-8?B?ZzVUZ0VnR3JIaUR1ZGY5SEp2UWVUUTk2dDUwaW9ubTZzNndTa1NzNlgrUFh5?=
 =?utf-8?B?VGQ5Q1BZMHI2S0JyK1VlVzI4L1pQOExkbGttb1l4QlFSNytvWnRrZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5FCA362B23AB94BA4B35463C7EF0EBF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cMfij915vIIb627L6vJiR/DKJ5Hm3Wi/PySnDSUKN93arPEjmcD/CSfDCJvRGzAFYkd+BeX8V6/cAzY7+yrJr5hH1uDGqvxeIMlZqDvN4Ylg/FaKnu3baZQCn4N1nqmJjDK3YYEX5shSAEEIorLRw/QzxdJpkSu95JkwqiGSCp9C3upwUgh05K7C6tHiapMS4wH1JQ2J/U0dX6vb8qdrlByqj/BGSiUQaVugfclnVxBiBARdhqefi+Xy2tdo8Z+1ID4+t4rMk1KeZV0O0124RoQbGmCeVeo+riDGRCu7mID3/9iduNd7H41eAXCtgg2WS2XEMHl/bCmZNj8aBVcHUg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8d8d6a-b3c2-49c1-0338-08decc5ff4f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 11:02:43.5964 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibidyNlF/sMjL4ut5C6CWZUTzEK3LeHD+r/+pOKxv31f5mQhxdi2Qu6o5JOFTes8yoiAnk8WQegQ6+0QHTy9JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6425
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

T24gV2VkLCAyMDI2LTA2LTE3IGF0IDEyOjU0ICswMjAwLCBSYWFnIEphZGF2IHdyb3RlOg0KPiBP
biBXZWQsIEp1biAwMywgMjAyNiBhdCAxMjoxNzowN0FNICswODAwLCBaaGFuIFdlaSB3cm90ZToN
Cj4gPiBPbiBERzIgdGhlIGRyaXZlciBhbHdheXMgc2hvd3MgdHdvIGZhbiBjaGFubmVscywgYmVj
YXVzZSB0aGUNCj4gPiBGU0NfUkVBRF9OVU1fRkFOUyBjb21tYW5kIGRvZXMgbm90IHdvcmsgb24g
c29tZSBjYXJkcy4gT0VNcyBkZWNpZGUNCj4gPiBob3cNCj4gPiB0aGUgZmFucyBtYXAgdG8gdGFj
aCBjaGFubmVscywgc28gdHdvIGZhbnMgY2FuIHNoYXJlIG9uZSB0YWNoIGxpbmUuDQo+ID4gV2hl
biB0aGF0IGhhcHBlbnMsIHRoZSBzZWNvbmQgY2hhbm5lbCByZWFkcyAwIFJQTSBldmVuIHRob3Vn
aCB0aGUNCj4gPiBmYW4NCj4gPiBpcyBzcGlubmluZy4NCj4gPiANCj4gPiBOb3RlIHRoaXMgb24g
dGhlIGZhbjJfaW5wdXQgQUJJIGVudHJ5IHNvIHRoZSBzdGVhZHkgMCBSUE0gaXMgbm90DQo+ID4g
bWlzdGFrZW4gZm9yIGEgZHJpdmVyIGJ1Zy4NCj4gPiANCj4gPiBGaXhlczogMjhmNzlhYzYwOWRl
ICgiZHJtL3hlL2h3bW9uOiBleHBvc2UgZmFuIHNwZWVkIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBa
aGFuIFdlaSA8emhhbndlaTkxOUBnbWFpbC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFJhYWcgSmFk
YXYgPHJhYWcuamFkYXZAaW50ZWwuY29tPg0KPiANCj4gVGhpcyBvbmUgc2VlbXMgZ290IGxvc3Qg
aW4gdGhlIG5vaXNlLiBBbnkgdGFrZXJzPw0KDQpwdXNoZWQsIHRoYW5rcyBmb3IgcGF0Y2gsIHJl
dmlldywgYW5kIGhlYWRzIHVwLg0KDQo+IA0KPiBSYWFnDQo=
