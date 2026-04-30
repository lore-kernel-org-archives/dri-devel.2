Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287DFFF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 13:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12B0B10E442;
	Thu, 30 Apr 2026 13:13:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XISeb2rX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 840E810E1C2;
 Thu, 30 Apr 2026 13:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777554784; x=1809090784;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/QIhW1krHJk5WmJ+IBEYv+S7gwGIdTD7F40PdnrRmww=;
 b=XISeb2rXHeJefl5odqHkOkbYxr/Z2imNm2G9g96rPNGeyHcpr2QQSD78
 a4DOm4WYaXoxI3gLe6pZaPx5XJY71bgymbLmFGe3gqA1UU6A7tk0r7WkL
 GUc/bjRwhJ+2tft2Rl+MFmql/xs78WkXbh55DjSQDcr081eD/qUSk+LW2
 OZt9OnebJMx6kkWjt8oCizdND7OTDTv+5EvZ0HXfrN5ev1G/UUIH/0tOT
 UwYoHqz/YkR07svA4ZzB2KAlxcFb+PVZuR2OYjToS1wPDG+H4uf0PQsDr
 4EvX6w8eFCvdjrq8iUCsXSgfo6AQFctVscyw4zdOT2gxuQPP/dPE5sQbQ w==;
X-CSE-ConnectionGUID: 2cMD6cNpRpSiABUUN3Os7g==
X-CSE-MsgGUID: T7wwRZljQxaJ+Y8MxFMUZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89596832"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="89596832"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 06:12:59 -0700
X-CSE-ConnectionGUID: aAnISaabQIyNXw0VXe/W0w==
X-CSE-MsgGUID: YMiWM+cbTDC8nZoMjELBLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="258158784"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 06:12:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 06:12:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 06:12:58 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.28) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 06:12:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilJ4DOgtSVKWe4lwZ6OoHDGjVUz8vW5joXLO3OBzt5qg8KPLkASozW8BoNIs/TIEzAPMJFWt8YhhGLvQVSbWoMaYTOeDAfJKeYQmYKyLVjCt9r/1ujsOEM69poKAa/BcvXHMTi3GMTXW1QUljojyR4u7LMCRpMGqBy8LUYw9PGzYOzZyfqTOdsWC9qp5McKXrBVe312kfIeGip9Wxw3di7BMgRcvvWzULP69100j5l+3UdJ+61RaebLY3BqZUZkatwQ9jOVnn1SzO0dGSQEfgSeqhw4mAld4+3XKeFrUqWZB2rLHi7Mk2L7myD+tRRejSFLXOlX/O1pAUE9V/sqzAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QIhW1krHJk5WmJ+IBEYv+S7gwGIdTD7F40PdnrRmww=;
 b=bg4tidZicn6mF1IaW2n+HO70ByI9AxiiDlKF/FzAFzL1GfCrJMElAOJ8LZiq2hIzbvbberO1Pgai9JTtJSabl/3bwvsiz+3Cu670YAGdTKs1klF/l8C0OZ8sajhLpOQwKeQEF7tWftLvh8xYNKUcVTYAZpCKAp1YyXmGExuy9O9ZCrQ9ThHjMVxATAVJtt7OZlpt/Z9mBTWgi79TwchcfLi3tg3RTTJT76tItoRXJlNDPVdJHbGG5iAfb0/GvF1hvuDLWnu2FOP3UZcMwQV6tE07+iL2UwfuQxMyAURHOlaxXeEjBNB8ad+S+IP3aqr2XEaSRtEiJfU727esGM1x2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN6PR11MB3232.namprd11.prod.outlook.com (2603:10b6:805:be::14)
 by SA2PR11MB5130.namprd11.prod.outlook.com (2603:10b6:806:11d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Thu, 30 Apr
 2026 13:12:54 +0000
Received: from SN6PR11MB3232.namprd11.prod.outlook.com
 ([fe80::bf74:5777:8849:5c00]) by SN6PR11MB3232.namprd11.prod.outlook.com
 ([fe80::bf74:5777:8849:5c00%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 13:12:54 +0000
From: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>
To: "Auld, Matthew" <matthew.auld@intel.com>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>
CC: "Arunpravin.PaneerSelvam@amd.com" <Arunpravin.PaneerSelvam@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/buddy: Integrate lockdep annotations for gpu buddy
 manager
Thread-Topic: [PATCH] drm/buddy: Integrate lockdep annotations for gpu buddy
 manager
Thread-Index: AQHc19UBxAjbdwjIT0+T5iBjAqiAT7X3U+WAgABCJAA=
Date: Thu, 30 Apr 2026 13:12:54 +0000
Message-ID: <SN6PR11MB3232A69655EB743710B6C9FE81352@SN6PR11MB3232.namprd11.prod.outlook.com>
References: <20260429123714.3913374-2-tejas.upadhyay@intel.com>
 <4dea1e78-da81-4c5b-ab8d-62d6f99e4889@intel.com>
In-Reply-To: <4dea1e78-da81-4c5b-ab8d-62d6f99e4889@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB3232:EE_|SA2PR11MB5130:EE_
x-ms-office365-filtering-correlation-id: fe146527-20a0-4ef8-a505-08dea6ba3081
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: s2z8YsOyHEjRwoPVWqAjYzjKannuEzHELFNAmfrKX31XM/YKES1PZ2Qhr6OBPsh1N3qEHNuZTqBfzLzijYolqNmv/VaD//kSfrHlHIoWXFSdjMgW7Fr6s7UwcNCA7oquK4RzzSAYL7daYD8cbqeEjAbTSXT5wEkB/sKid5t4xgmp+NY+96ZHXcxEQghoU7/cgBhz6N17z8b2KK2f9tK/KHyghY8ZuXSlDb1/m7KaTOrKeTSeb5P0iSv9np7HqJxpPXJbCpmn3xdx4eKnZRAVD6XE2SmVpq36sazhNLjFU+xs101kMMpsYxsIXWxlfNBG2XKZX+lTwuaW1BpbdJBsI+/B3+xqe5RslrA2Jz8P1FmhjGjdotPUPyFOLNigr6/97+ajmTBz+5qWS1O608Dy/T6fos5IlKOz8vAIGKtU18Hoo3BaSrjwHbQHNcM4qPIZ4iWra7LJaVj3cRl4Xg8Que2VnH/p1sBht7AadJ9fvTNEHTCAgdh1eD5oxsCjbAtw58G26Velqn/oMaXKl5GFW11IPPMAjt+JP+cBB4hc/hO/Xty6fT2AuqLHrBa25/up7uqWXcGedf6Ajwra42FYwqr9JS1izOC4yi5UgXXKfSZykzt2iQz0rPgJCV5U/qzRQ5fU4h65MJ0CNj2LSE0jDKNnleDeh015stkFeHuHWDwTN2OOQNN9U7A1EO0FkC+p/cVPVzdcWYkxTdeXDwBV9rrWYqSmEUx6oj5NmMRhcKy54T8aDnrGZU7d8cKb1ZI6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR11MB3232.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ektrcjhzUG5OVzFnTmViVEw4Tk9xTzBCbW9LUlp2M1N0OVM0RzZSb0h5SGhY?=
 =?utf-8?B?QktUZUdLYTkwYkNSTTd0VHVQOTNZT09BWGN6R3hydkxHd1FYY0FwM2JNTG1q?=
 =?utf-8?B?b0UxVXgya25OUjVyK1NNUE14dXpzNWNVeWMxamRHMHhoSXZPM3pSMm9QNkpT?=
 =?utf-8?B?UUNXUzdwc0FPSDlBZEgvOTBpUVNyYW9nREVlM003c1k3ZHBiQ0sraVB6Y2Ev?=
 =?utf-8?B?K0RDUU11Rmd0Q0ZFc3g0YUdpMHhwSW9XUkVJbnpuTC9XOUwrSXVkWHB2OTRi?=
 =?utf-8?B?NzBUaWhtT2tUbkpaaDI4Y21aaFpnRk9YUGh1L0F3aGVScUFNWUJKT2YvMVhm?=
 =?utf-8?B?bnFCb1VGaXdiK2srMC8yYWY3YUlvYjVWQ213ZzJGZCtNRkJDb2lWeW0zbzhk?=
 =?utf-8?B?VHMwVWJnSEJ3ek1vWFpER05RelVPZEtER2xCRjIwM1h3cjMrby92cXFTdmlY?=
 =?utf-8?B?WUFJaE5ZV1M1a3prbG1Ca2xNOHJrYkoyZlI1WG1QcVZaUGExVW13QTJRLzI1?=
 =?utf-8?B?WnpVbXVVTysyNXFCektPanZYNjZZdVZaeFBKc3o5ajJLM3p1WW9VMVpsV1lO?=
 =?utf-8?B?N09BRE5OUGpCLy94bkdJVk80YXNIZUJFcG5sOVNNOFM5ZnFjS1BKSVVVNnlC?=
 =?utf-8?B?ZmdvWGN4L2s4WkZ5c25TUlJuaXpwVzdiSVFrWC90TFBoQVhSSlVRVGRMSVgx?=
 =?utf-8?B?ampNQ1NTMmEvSDJJeFpaWTBOcnljSEJMSXdsdFJwbVNxWDU1TzFFcjBUNHha?=
 =?utf-8?B?ZlIrcGs2eitkR1dlYkoyY2lWSXdsOGZ4MEc2WlNJamMwSmsxZmdpTnZJTXpi?=
 =?utf-8?B?M3VyUktYSVNyQ1BmcVVnb3hNbkVjb3pMcE1XRjllZU5UbWtDbWIrMWNJMGgv?=
 =?utf-8?B?Y3lTZ0FEWGNtMTY2M0kzdUM1VVE5Y1VlSnQwSDNNYStEeUF4UzZpc21SQTBO?=
 =?utf-8?B?Qk96L3Q2d3lZMDJxMmVBS3hlUjErSFNGYVdhQldKbjFFRXI5RGFqZkJkWDVK?=
 =?utf-8?B?QmYzT2JIVjVGNHAxeEpEUGVibHArRWs1VTJvOGl4U1ZuLzZtQW44TFF4VHhK?=
 =?utf-8?B?S0tIS1g1U0Y2Q0h0R0JNZ1NBVlNoa1hldE01dnVtYnV0dWhPRWI4Q0dRQS9M?=
 =?utf-8?B?M0puazlHOTdVUGFJUWtoOEI2Y2kzUndjdnNPM0FJUVVuT3RLalhtd1V1N2hx?=
 =?utf-8?B?M2haN2dKVlVSY2VTajAwNGx1d1JFSWtoczNPN0M2aENlQ2dhRm5xQnZSNS81?=
 =?utf-8?B?c3d4SHF6L243Rm1Udkk5ei9DbWdTRUxIc0NNalNxeTZNNXM0WGMyR1hHaUlH?=
 =?utf-8?B?U3FDVFhYcUExZk9SaWVTYzZqR2ZsdDVWN1RSL0VBVEpTWnVXV3hoTWtxZ3Ri?=
 =?utf-8?B?R1kwRnB4dW1oMXc2eHlCSjRWQnNvVmpWN1YvQmxhb09WdlZEZWhLWXNaRnlQ?=
 =?utf-8?B?SHg1UXlzREIrbnJNWkxXUi9uN09kWTJJSXRrai9KL3RBTnB0QkROTUVxU2RQ?=
 =?utf-8?B?VDNTNmpnOUcyQzliait3VzB3K29hV0dGbFEvSE1lZy9OanVBTnhaUW4ydyt0?=
 =?utf-8?B?cVluV2JvUTczZmFiMGZlSzFjc3ZCTTJxeEhPUm5GcTZrMTVhS1RtYjkybkxY?=
 =?utf-8?B?MytCeVIyTkZvMnhkeDNaVmRkeEV3ZVQ3L05ua0lhVVQ4SFZpZ2RQT3pjempF?=
 =?utf-8?B?YXdYWHBkQXFueTFycFhXSlArK0xoL2FNU2lZV1RKSVlUaVhCNVEvemhFcjJQ?=
 =?utf-8?B?dXA0TWZKREpNS0trYUtmL0JoQUVWdzlaaE4wT083bEt4ZU9kVkEvTjdld1Ro?=
 =?utf-8?B?ZW9xSEo4czcxb0RvVktnSDI0bkZ1WmZzSXQ0bDBVbHEvOU9wMVc4Um5ucm8x?=
 =?utf-8?B?bzdsV1RVdzNsUUFKSDEyZDNhV0xkdHpMclo5TjNjcWJkR3hqMlRkRW9SZld6?=
 =?utf-8?B?YktoMlMzLzcvNk5KUnJRMG45UVZhTU13NFc0c0E4VkZjOXRrdDdqSUxxWTlZ?=
 =?utf-8?B?YlE3YUVZK1hHek5pL0FBVHlqQkhnRHVGMnNtdkZxNGs0V0RsaVd2a2d2dVBi?=
 =?utf-8?B?RFdpd3BlNnBBSEJJNitxU0xFaVgyNGtZa3BtK1ZKZm9IK0NldStzV2l1RUJz?=
 =?utf-8?B?bTVKTVNjQ04wcG52dlZmY29HM0FxL08vc1NYMHdNSUtLcVhCU1hJVXM3b0Fu?=
 =?utf-8?B?ZmUrRFRIZGV5RkZjaFJvYjM1bko0K0JXaDVXeG93aU1CaXJJRHBLMDhHc2U1?=
 =?utf-8?B?YnRHSHU0OFFNWXpoWEhDdXUrcW4yNXhFbkVxazI5M1lGRkJUTzY5K3hTMlU4?=
 =?utf-8?B?R2o4bWZYR1BGYXp4VXhFMml2d1NsWE9USEpLM2VidzlRV01aTmltaThsd2VY?=
 =?utf-8?Q?iSfuHsZZXdZzwmHhT+i0g2hQM7i8RdvpCzYfaZFgDrvrI?=
x-ms-exchange-antispam-messagedata-1: fKsThB3Ms8bbTw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cBTw1c+joYEUe5v2fy71vyrz4K3LB724v21pZPGJZQdWkP6DnXkgoNGRmGbvbEz2gOQvy8Nv2xZTGBHl5CThbi0tWMkgjBIKVYu9S7pQD+SWn7HQFizMkSQQMIdQtJUisnj4bvSdEkDx5ox2MzyocpD9okOQOgh9spLh4XCt/NDvsDWn8U/VWdyTltDrPExL+VPsZBh+kRDPBNlpRV4g/v+Sp0P4cjPGXUA6hSHkzaIl6c9xln9sEWh9eENoW5pKpza1z8UYIOjJtc9TPlVlSjWEed5V3f5MU+S8UpG/cJQFuZjvvvWDjiK0Dpu5KzO6fFE6v1gTGuLzrDxGH+pMQQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3232.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe146527-20a0-4ef8-a505-08dea6ba3081
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 13:12:54.1052 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0yHl1yYb2B06XoDoAiCCN8Yx6bRCg8UP6sGQ+OtLXMu1Sb2EmWBl0wHz5W8A5R5Pj9XqCsbYd4u52XdlAVn/adzWcadARHpCbJN71XuN4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5130
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

RmFpbHVyZXMgaXNu4oCZdCByZWxhdGVkIHRvIGNoYW5nZSBodHRwczovL3BhdGNod29yay5mcmVl
ZGVza3RvcC5vcmcvc2VyaWVzLzE2NTcyMC8jcmV2MS4gV2lsbCBtZXJnZSBpdCBsYXRlci4gUGxl
YXNlIGxldCBtZSBrbm93IGluIGNhc2Ugb2YgYW55IGNvbmNlcm5zLg0KDQpUZWphcw0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEF1bGQsIE1hdHRoZXcgPG1hdHRoZXcu
YXVsZEBpbnRlbC5jb20+DQo+IFNlbnQ6IDMwIEFwcmlsIDIwMjYgMTQ6NDUNCj4gVG86IFVwYWRo
eWF5LCBUZWphcyA8dGVqYXMudXBhZGh5YXlAaW50ZWwuY29tPjsgaW50ZWwtDQo+IHhlQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogQXJ1bnByYXZpbi5QYW5lZXJTZWx2YW1AYW1kLmNvbTsg
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsNCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2J1ZGR5OiBJbnRlZ3JhdGUgbG9j
a2RlcCBhbm5vdGF0aW9ucyBmb3IgZ3B1DQo+IGJ1ZGR5IG1hbmFnZXINCj4gDQo+IE9uIDI5LzA0
LzIwMjYgMTM6MzcsIFRlamFzIFVwYWRoeWF5IHdyb3RlOg0KPiA+IGdwdV9idWRkeSBBUElzIGFy
ZSBleHBlY3RlZCB0byBiZSBjYWxsZWQgd2l0aCB0aGUgZHJpdmVyLXByb3ZpZGVkIGxvY2sNCj4g
PiBoZWxkLCBidXQgdGhlcmUgaXMgbm8gcnVudGltZSBlbmZvcmNlbWVudCBvZiB0aGlzIGNvbnRy
YWN0LiBBZGQNCj4gPiBsb2NrZGVwIGFubm90YXRpb25zIHRvIGNhdGNoIGxvY2tpbmcgdmlvbGF0
aW9ucyBlYXJseS4NCj4gPg0KPiA+IEludHJvZHVjZSBncHVfYnVkZHlfZHJpdmVyX3NldF9sb2Nr
KCkgZm9yIHRoZSBkcml2ZXIgdG8gcmVnaXN0ZXIgdGhlDQo+ID4gbG9jayB0aGF0IHByb3RlY3Rz
IHRoZSBidWRkeSBtYW5hZ2VyLiBBZGQgZ3B1X2J1ZGR5X2RyaXZlcl9sb2NrX2hlbGQoKQ0KPiA+
IGFzc2VydGlvbnMgdG8gYWxsIGV4cG9ydGVkIGdwdV9idWRkeSBhbmQgZHJtX2J1ZGR5IEFQSXMg
dGhhdA0KPiA+IGFjY2Vzcy9tb2RpZnkgdGhlIG1hbmFnZXIgc3RhdGUuIFRoZSBsb2NrX2RlcF9t
YXAgZmllbGQgaXMgb25seQ0KPiA+IGNvbXBpbGVkIGluIHdoZW4gQ09ORklHX0xPQ0tERVAgaXMg
ZW5hYmxlZCwgYWRkaW5nIHplcm8gb3ZlcmhlYWQgdG8NCj4gPiBwcm9kdWN0aW9uIGJ1aWxkcy4N
Cj4gPg0KPiA+IFdpcmUgdXAgeGVfdHRtX3ZyYW1fbWdyIHRvIHJlZ2lzdGVyIGl0cyBtdXRleCB3
aXRoIHRoZSBidWRkeSBtYW5hZ2VyDQo+ID4gYWZ0ZXIgaW5pdGlhbGl6YXRpb24uDQo+ID4NCj4g
PiBBc3Npc3RlZC1ieTogQ2xhdWRlOmNsYXVkZS1vcHVzLTQuNg0KPiANCj4gSSB0aGluayBhZGQ6
DQo+IA0KPiBTdWdnZXN0ZWQtYnk6IE1hdHRoZXcgQnJvc3QgPG1hdHRoZXcuYnJvc3RAaW50ZWwu
Y29tPg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBUZWphcyBVcGFkaHlheSA8dGVqYXMudXBhZGh5
YXlAaW50ZWwuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IE1hdHRoZXcgQXVsZCA8bWF0dGhldy5h
dWxkQGludGVsLmNvbT4NCg==
