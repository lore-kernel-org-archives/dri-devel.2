Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBACC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 21:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41DFB10EBD7;
	Tue,  4 Aug 2026 21:02:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VdrCUzNY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 646DF10EBE4;
 Tue,  4 Aug 2026 21:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785877370; x=1817413370;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=xp4dgEsP/uG6ExFIBiO9xAijnEj4HxfC/OXSKca7h1U=;
 b=VdrCUzNYG2TchsY36BttHT0EVgxRKTkST8ThlVOUgAYAjqO2rgB7KrbJ
 U1EHR3C1fuFs3i+ox7gedsFpCA/m8egUWD1RU5IOSTZiQNLI/7UP6Ysmh
 WEGYgbESbWfC7T6iss/oUE4+v4zqOQdW5YpkcZoNSGmSlaGW5Ik9/To5+
 INg+OZQ4VzX8OoNlaxVWBq3cF4gPyWG1pUq8p4taIEn9YSXFAfrTc8Scm
 c2Q4WXAd3j1aBWX3+3nTBan3xeuDrObArFZBUD1BFu3fm/bHlTYjvUuwe
 wAFz9/NoPSBZYS3XNjt5RO3RLwqALkGvuCqN8G8nRvNRVWiEoAFDzO5yw g==;
X-CSE-ConnectionGUID: x4X98fOnQda5zvASwoFlrw==
X-CSE-MsgGUID: +OXwh56HR4WxYB4N/nKybQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86209931"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="86209931"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 14:02:49 -0700
X-CSE-ConnectionGUID: GWJYxlQCQpmZmyunPY7UaQ==
X-CSE-MsgGUID: XJ8jq7mZRLm08jTntgb8+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="261037993"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 14:02:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 14:02:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 14:02:48 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 14:02:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GG8cN6wzFYP9wGLgWovqr8cXJJ5/eNyjYihzzvGPZuLIqYs5XC+pn9LXPYGybX1MpiEeige1eE66WyIObh4VR0ibtE+MQzcC99HKpAw4W4GPcPbr2RgXMhvoDHXL1MNEH1DBrMngmMFVlHdDM1OWjmRYsNHS3tFckEPEfivdMtZusFQIRxE4g1mB3yw1Fed+mCUgP7m19aN3id+4h3GshcYTUCpbkR3j7IHsgU2iUsrhU1DtFv5jxuPEOyK5aAAWwu570LU1TcrR7XVcY0v04U8bejpdgb5nbVHbALd/arskvqKO1gLxz/SusvQRPTi6SqzmxbSo80t8PaIa7P0T/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xp4dgEsP/uG6ExFIBiO9xAijnEj4HxfC/OXSKca7h1U=;
 b=nlKiicq6StxWfs1A8ecg7Qfntmgh7EWsXPJdyt8La3g/dJFo8USw/CdP6L8K9k5ZqyOone4ESB3aWgjX4Exqe2sg81xHlui21HxiK91JvHyFzSD3LmVM0B//U2+TY3RgUtivwZNffaO0nloB+kY+PONA85q1E1UVv+rHGAD6L8f9An46iuxCQC1p8/ory++xrwEfRvhvTj39D9xf0zvKvUwKcSEYs7aMve3BWdMbddsvVDvVxFx0P2rvqqqH4NggsPkmrwi3iv0/JinLjc/OEuWTSakRF8xqQsz4zBOyV48UHG34k4hvWFzid15JLb9xvZIi2DRDF3+ckbB33WR/UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6320.namprd11.prod.outlook.com (2603:10b6:930:3c::9)
 by MW4PR11MB6788.namprd11.prod.outlook.com (2603:10b6:303:208::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 21:02:44 +0000
Received: from CY5PR11MB6320.namprd11.prod.outlook.com
 ([fe80::9cd7:94d5:90f:4d76]) by CY5PR11MB6320.namprd11.prod.outlook.com
 ([fe80::9cd7:94d5:90f:4d76%3]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 21:02:44 +0000
From: "Summers, Stuart" <stuart.summers@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
 "talesam@gmail.com" <talesam@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Brost, Matthew" <matthew.brost@intel.com>, "Vivi, Rodrigo"
 <rodrigo.vivi@intel.com>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [RFC PATCH 0/3] drm/xe: diagnostics and workaround for GuC TLB
 invalidation ack stalls on ARL
Thread-Topic: [RFC PATCH 0/3] drm/xe: diagnostics and workaround for GuC TLB
 invalidation ack stalls on ARL
Thread-Index: AQHdI7cQmhH2EHhEx02YHK5nxm2FrraOYbmA
Date: Tue, 4 Aug 2026 21:02:44 +0000
Message-ID: <c0c50dff0f9b64a2db8e1470d75e450ba35cccde.camel@intel.com>
References: <20260804021441.3054424-1-talesam@gmail.com>
In-Reply-To: <20260804021441.3054424-1-talesam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6320:EE_|MW4PR11MB6788:EE_
x-ms-office365-filtering-correlation-id: 13175f58-c623-4167-fd5c-08def26bbac6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: aiVClEMP5ymliclkdfPaVqAHJIIRmoROSyMUbRVvSwe/DLi25PHoXVQ0YEqnA/VD8rjEwnGXhMIOnE6Y2tb2baSGx2hqyOp/7dqECpF/8Sz23FlO8nMkC8c+RqyxioJ4YU7SHe5VLVRbP2G7wMXn8cUURkcWXsYbjrLhXOHxz9fHpyEq6wqqcVNQ4nCtkNkoUL0pUtmLEYHeqiv61UkoOTN6LcBGXW63ZFMMoQj34IT5CpCzUwNY5k2Q1Ux8jT+9W55rrDyUefWnAAtMQ2OfDAZtXEWWmknthVVIBhF4dJuSXHk0Kps/PIc/nCdAxfnGFNgSzqhXg5UywGMX7gUZL3kDyhyx5HP7fEg+HAJK466kSZ7FM3ukNtU2YLcbnd4u+3PTCpy4tNFj6GtDYoTmrlBe/cTLM+MgWmShmjMerJ9nsSm1DFS9+PvxHmo0K4FVlQCoKTQtmTbP6oYr3d45DaGJwWFTthvKjoA2ET7IT0CUQbC4xF8g28NKfvxgUFH3sfXWHGNGv16Vrwl/4pRbUpYYY7wdRUjp65zIqDp/qMV/CdP+jqgUtkGzTEC6zvAoRZmRR7Vvhlq4gil7niHKyJk/YCRWn42ZEjvV6TtfcghYLp95CuR+hv5WsRX4733qSLrr6YNpafp4/W+4o8VIjdkEol5C1aQRVo9L56b/tVM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6320.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFFaUGZrUFVzZWZ6a284cHRRRExXTTVFRXFqOGlGQWdobEVpUCtZNEM0a25S?=
 =?utf-8?B?MHE1L21HWkQvaGhtN3hZSjlYN3BxZ3lIYzRBUk8zUHBCaW81U3BaR25TUG5R?=
 =?utf-8?B?M2hnWWVoZEtna1piSFRaTXRMbmVyTjROTmJucjZtRUk2d1J3TWV4N3hTWUlH?=
 =?utf-8?B?MmhQbkNidlhuWEpUWTRDV09XYzdvcGJvRjJqUkx3MDdCUFljSzl3UDJiakd2?=
 =?utf-8?B?WHB4U3BrNTdlTkxFQkk4K25kUXlBeEh6ZGxweU55MmZ1NWhJSE1aSEdsNi9h?=
 =?utf-8?B?bzlDZjR4Wk94YzZJRlRoYURkRWV5SWU4TXVOQ1ZTOVFBVnh5dmRZeXI0NFNj?=
 =?utf-8?B?VldUSEVJbHdvN2R1OW9wdnAzYzJDY1luOTdYbzE2cVNtLy9qdFMzQ3VQWWgz?=
 =?utf-8?B?QU4rTnAvQVNsaTBRN3A2NFQ4VXZrUXB0VFZvYlBsRDljWnQ3aW9VSGpsRDlH?=
 =?utf-8?B?VHlkTXBtZkx6L2hLU2tSa0hIM2Y5Ui9lVFdnS0hrUVF5cTUyZE9QZkgxZEdT?=
 =?utf-8?B?bkNQWFd5dVE4dUhuRmNUYXFvVkpTcU8rdjhxaWFFVUtIWFVRRGFHa2trcElH?=
 =?utf-8?B?NHRPTFVMN3dXQ2pMMk1GWU5XaStaVTFOR1FheUZwUyt3REozUyt1OHdnMHJv?=
 =?utf-8?B?UHNEd3JnUFUzVFd4T0FTUUt0S1c5WTgwOGdRWEd2TXhqWGF4cmZsQ2ppdWJ6?=
 =?utf-8?B?bmYxMUk4SWZaSGt2NmxxYWF0ZnBzNG9LVUFpUjJrVU5IajVEVDZIcll5bU9j?=
 =?utf-8?B?WG9kRW9JTnJHcHBpTm1YaDZkTUd1bGNNdVdTd1hrUm5USHV3OVNEaiszU041?=
 =?utf-8?B?elNUQ2ZZcHFkcXRHeGhlVmgwOXduM2dGY0ltZjJGVlV6L3ZEbkJJSTNzUm04?=
 =?utf-8?B?SzZzTy9RQ2sybTMzUks4UFhMY0pWRGVJdjRndUZRUmN6S0pjVG5tY25pdHFP?=
 =?utf-8?B?azFIMWN3K3RqTHBaQnZoOC9PT2dmbnhIbVJHWjFORXFsRVFyQmZHTDhId3Qy?=
 =?utf-8?B?cytMR25VKzc4YXRURjRrKzlXbUNYMFN2cnVmS3NlcGlOdWxqVERPdXdzdytt?=
 =?utf-8?B?K1hMajdqS2xHTk5JZ3R1aVVwQkFPUHQ4Tmt0OUpuQXROdXY4NGFMdFFXeTlz?=
 =?utf-8?B?YjN3UUw5MGJTaTdCby84eHk3ZHJqOHhCYjlpcTFUT1FiYjVIYWNjZURiTVVp?=
 =?utf-8?B?dWtrd282TVNrTXJFWkVId0pSMkVFemxoZXV5dmxDcTV5Rlo0RkFaU3FhdGRG?=
 =?utf-8?B?WVJCV1NNYnFzeUM5enRyV2tXNGJsR1ZrS2E0ZkJqQy8xT3V3TE13dDYyMlBU?=
 =?utf-8?B?TzBIMEZxRk9xMUxwa0FOMmVjdEt6RDloeWpvQ3JFR0tUNUo4NjM5R1RjMGpz?=
 =?utf-8?B?WC9sOExTWSt4SjRyRThIeFNQakpGeWxKa0d5MnYxMFBBTHlORi9RQWVYT2Jn?=
 =?utf-8?B?ZXhnbzVvaEQwRHZtTytJSGFwWTA5NzdpTXh2WDlOZzVrc09BZWlJNVFlc2F6?=
 =?utf-8?B?eFA0eDJ4Tzlyb294Q01td092RmhVaHBwQWk3eVFXbk94MFFlcXpGNDhSSEhH?=
 =?utf-8?B?YXFhZTRnU2RORk1HRmxWMU05WHBvbWhKY2RhczY1bkgwa3NoRlovMGxGYW1G?=
 =?utf-8?B?NGVFL3FsMGEvSVFjMkJnWXY5WmxBMGROL1p1NjdXazJHdVovYjcxNjdISnV1?=
 =?utf-8?B?bXlpK1B6SGQzOG9tcysvSU9hbXJyMW1lbllOYktUV0xDREVmTjB5SXNxWXNC?=
 =?utf-8?B?cUhFakpCN3pMcUx4VXRPbnJuSTA5UWRRTXZ2K2o2Zjd4dWt0WThKdGYvTnk5?=
 =?utf-8?B?N1RZWVJnOFpkWWJIc2xXZFZvNUp2SW16SHJHRG1SSHRmdkRkOTUzTjJnTklu?=
 =?utf-8?B?aHBTaFllckJ3SkswMG8rVWR6ckZXTXZOWXd6djdocW9GaVBRMHVEdWJCaHhM?=
 =?utf-8?B?ZE96M0pPaFZnT1cyTFJXajRTbjRQdVpSSzV3MjFNUE0rVjZGdlQxejBOSHF3?=
 =?utf-8?B?K2RJWVhFaTRaUXFQQkgrNXJnbTVDQVd6N085N2JmUzVWRzFJajZhWlJML3Rk?=
 =?utf-8?B?a25sdW1yejFXNlh4Q2gzeUJvVFN3QkU3cmhydi8zdGRXNUlLR25RT0dZOHcx?=
 =?utf-8?B?SmlTZ29WV3RNUWFaMGVuTkdJUGtYdUhBTHdTUDRQVGoxdFFjajZtcVA1M2hX?=
 =?utf-8?B?d0N4R3RHblFWb0h2c1I1a1VyL0ozenBvNWhNZ2tYRUdWcVRUZ1ZpVGpPQTl6?=
 =?utf-8?B?TFhWbWhoUGpONy9RbmlhREdVdlJNNmNvN3M0T0pQVkRlTnMzd250c0RsenBj?=
 =?utf-8?B?Q0VTRGVxcmpHUVBrWmFmcFRuN0MyS3R6SnVVSVE2ekVscWRrakg0cWgzVnYx?=
 =?utf-8?Q?PcOXNhtMOnStkGrU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1752B8736414D408302095F79219A08@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: K3E5V9MZFnD/Z+j3nx0Se+dC905r8A844yXnDuRYWlTe+37tfQLNHhp16mnUb7ISmSOWuSKUc/bZHfLOHihbsic6HFFwcv7qWbypAZuGfFRAFmq57o4fQe0/9Uo0i7pS8RN/Q4oq8e1ewUyjkFaa5Zpac0ly7oWQqcUMgr0Os1/pjXj+wAjZVaGM4iO2tyxOLxxEOjjk1A3Y+vx0ymCNgFi46siEDF9cKk4QTk2AivT5ZsWItt4SLvVtr0rPGxoGVTC0qKP9nip2K1+NggB1sIHo+PyQ6P72ZJjshYpd5laTdEUAC7ERAYxKmIiWS3wJKUVXJIOKCglo0Erb2M3Gjg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13175f58-c623-4167-fd5c-08def26bbac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 21:02:44.1897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s3AbbpAdMH/buM0iY2FWcBLRkzpR0bHUyy9NNyNnSyQsLY9WLYNbfnE7zOZGp+XCVjmqIviBFFzP4sjfBmF8TodkqSqXW0fAUuaxwH2E+ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6788
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

T24gTW9uLCAyMDI2LTA4LTAzIGF0IDIzOjE0IC0wMzAwLCBUYWxlcyBBLiBNZW5kb27Dp2Egd3Jv
dGU6DQo+IEhpLA0KPiANCj4gVGhpcyBzZXJpZXMgaXMgYSBmb2xsb3ctdXAgdG8gdGhlIFRMQiBp
bnZhbGlkYXRpb24gYWNrIHN0YWxsIEkgaGF2ZQ0KPiBiZWVuIGRlYnVnZ2luZyBvbiBBUkwsIHRy
YWNrZWQgaW46DQo+IA0KPiDCoCBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL3hl
L2tlcm5lbC8tL3dvcmtfaXRlbXMvODY3OA0KPiANCj4gU3VtbWFyeSBvZiB0aGUgaXNzdWU6IHdp
dGggR3VDIDcwLjUzLjAgb24gQVJMIChyZXByb2R1Y2VkIG9uIDdkNTEgYW5kDQo+IDdkZDEgbWFj
aGluZXMgaGVyZSwgcGx1cyBhbiBpbmRlcGVuZGVudCBBcmMgUHJvIDEzMFQgcmVwb3J0IG9uIHRo
ZQ0KPiBpc3N1ZSBhYm92ZSksIFRMQiBpbnZhbGlkYXRpb24gYWNrcyBpbnRlcm1pdHRlbnRseSBz
dGFsbCBmb3IgfjIuM3MuDQo+IFRoZSBIMkcgcmVxdWVzdCBpcyBjb25zdW1lZCBmcm9tIHRoZSBD
VEIgaW1tZWRpYXRlbHkgYW5kIHRoZSBHMkggQ1RCDQo+IGlzIGVtcHR5IHRoZSB3aG9sZSB0aW1l
IC0gdGhlIGZpcm13YXJlIHNpbXBseSBkb2VzIG5vdCBzZW5kIHRoZSBhY2sNCj4gdW50aWwgbXVj
aCBsYXRlci4gVGhlIGZlbmNlIHRpbWVvdXQgZmlyZXMgYXQgMi4yNXMgYW5kIHRoZSBhY2sgbGFu
ZHMNCj4gdGVucyBvZiBtcyBhZnRlciBpdC4gVXNlcnNwYWNlIGJsb2NrZWQgb24gdGhlIGludmFs
aWRhdGlvbg0KPiAoY29tcG9zaXRvcg0KPiBidWZmZXIgdW5tYXBzIGV0Yy4pIGhpdGNoZXMgZm9y
IHRoZSBmdWxsIHdpbmRvdy4NCg0KRmlyc3RseSwgdGhhbmtzIGZvciB0aGUgcGF0Y2ghDQoNCkkg
aGF2ZW4ndCBsb29rZWQgaW4gdG8gYWxsIHRoZSBkZXRhaWxzIG9mIHRoZSBzaWdodGluZyB5b3Ug
d2VyZQ0KZGVidWdnaW5nLCBidXQgd2UgaGF2ZSBoYWQgc2ltaWxhciBpc3N1ZXMgdGhhdCB3ZXJl
IGZpeGVkIGluIGEgbGF0ZXINCkd1QyB2ZXJzaW9uLiBJIHRoaW5rIGFyb3VuZCA3MC42MC4wPyBJ
dCBtaWdodCBiZSB3b3J0aCB0cnlpbmcgb24NCnNvbWV0aGluZyBsYXRlciB0aGFuIHRoYXQgdG8g
c2VlIGlmIHRoYXQgaGVscHMuLi4gKCtEYW5pZWxlKQ0KDQo+IA0KPiBQYXRjaCAxIGFkZHMgeGVf
ZGV2Y29yZWR1bXBfZ3QoKSBzbyB0aGlzIGtpbmQgb2YgaGFuZyAtIHdoaWNoIGhhcyBubw0KDQpJ
cyB0aGVyZSBhIHJlYXNvbiB3ZSBkb24ndCBqdXN0IHJlLXVzZSB0aGUgbWFpbiB4ZV9kZXZjb3Jl
ZHVtcCgpPw0KDQo+IGV4ZWMgcXVldWUgb3Igam9iIHRvIGJsYW1lIC0gbGVhdmVzIGEgZGV2Y29y
ZWR1bXAgd2l0aCB0aGUgR3VDIGxvZw0KPiBhbmQNCj4gQ1Qgc3RhdGUgYmVoaW5kIChNYXR0IHN1
Z2dlc3RlZCBjYXB0dXJpbmcgZGV2Y29yZWR1bXBzIHdoZW4gd2UNCj4gZGlzY3Vzc2VkIHRoZSBp
c3N1ZTsgZGV2Y29yZWR1bXBzIGZyb20gYm90aCBtYWNoaW5lcyBhcmUgYXR0YWNoZWQgdG8NCj4g
dGhlIGlzc3VlIGFib3ZlKS4NCj4gDQo+IFBhdGNoIDIgbG9ncyB3aGVuIHRoZSBhY2sgZm9yIGEg
dGltZWQgb3V0IGludmFsaWRhdGlvbiBmaW5hbGx5DQo+IGFycml2ZXMuIFRoaXMgaXMgd2hhdCBl
c3RhYmxpc2hlZCB0aGF0IHRoZSBhY2tzIGFyZSBsYXRlIHJhdGhlciB0aGFuDQo+IGxvc3QuDQo+
IA0KPiBQYXRjaCAzIGlzIHRoZSBSRkMgcGFydDogYSBkZWxheWVkIHdvcmsgdGhhdCBwb2tlcyB0
aGUgR3VDIChzdGF0dXMNCj4gcmVnaXN0ZXIgcmVhZCwgQ1QgZmx1c2gsIGRvb3JiZWxsIHJpbmcp
IGV2ZXJ5IDI1MG1zIHdoaWxlIGFuIGFjayBpcw0KPiBvdmVyZHVlLiBPbiBteSBtYWNoaW5lcyB0
aGlzIGNvbnZlcnRzIHRoZSBndWFyYW50ZWVkIDIuM3Mgc3RhbGwgaW50bw0KDQpJJ20gYSBsaXR0
bGUgd29ycmllZCB3ZSdyZSBqdXN0IHBhcGVyaW5nIG92ZXIgc29tZXRoaW5nIGhlcmUgdGhhdCBu
ZWVkcw0KdG8gYmUgYWRkcmVzc2VkIGluIEd1QywgcGFydGljdWxhcmx5IGFyb3VuZCBHVCBnb2lu
ZyB0byBzbGVlcCBvcg0Kc29tZXRoaW5nIGFyb3VuZCB0aGUgdGltZSB3ZSdyZSBleHBlY3Rpbmcg
YSByZXNwb25zZSwgc28gdGhlIHBpbmdzIG9uDQpyZWdpc3RlcnMgbWlnaHQgYmUgcHJlbWF0dXJl
bHkgd2FraW5nIHRoaW5ncyB1cCB3aGljaCBpcyBzb21ldGhpbmcgd2UnZA0Kd2FudCB0byBoYXBw
ZW4gaW4gR3VDLCBub3QgdGhlIEtNRC4NCg0KVGhhbmtzLA0KU3R1YXJ0DQoNCj4gYQ0KPiBzdWIt
NTAwbXMgaGljY3VwIGZvciB0aGUgbWFqb3JpdHkgb2Ygb2NjdXJyZW5jZXM7IGEgbWlub3JpdHkg
b2YNCj4gc2V2ZXJlDQo+IGVwaXNvZGVzIGlnbm9yZSA4LTkgY29uc2VjdXRpdmUgZG9vcmJlbGxz
LCB3aGljaCBwb2ludHMgYXQgdGhlIEd1Qw0KPiBmaXJtd2FyZSBiZWluZyBpbnRlcm5hbGx5IGJs
b2NrZWQgZm9yIHRoZSB3aG9sZSB3aW5kb3cuIEZ1bGwgZGF0YSBvbg0KPiB0aGUgaXNzdWUuIEkg
YW0gaGFwcHkgdG8gcmV3b3JrIHRoZSBhcHByb2FjaCAoZGlmZmVyZW50IGRlbGF5LA0KPiB0eWlu
ZyBpdCB0byB0aGUgRzJIIGhhbmRsZXIsIGRyb3BwaW5nIHRoZSBzdGF0dXMgcmVhZCwgZXRjLikg
LSBtYWlubHkNCj4gSSB3b3VsZCBsaWtlIHRoZSBmaXJtd2FyZSBzaWRlIGludmVzdGlnYXRlZCwg
c2luY2Ugbm8gaG9zdC1zaWRlIHBva2UNCj4gY2FuIGZpeCB0aGUgc2V2ZXJlIGNhc2VzLg0KPiAN
Cj4gQmFzZWQgb24gZHJtLXRpcC4gVGVzdGVkIGZvciBzZXZlcmFsIGRheXMgb24gYm90aCBBUkwg
bWFjaGluZXMgdW5kZXINCj4gZGVza3RvcCBhbmQgVk0taGVhdnkgd29ya2xvYWRzLg0KPiANCj4g
VGhhbmtzLA0KPiBUYWxlcw0KPiANCj4gVGFsZXMgQS4gTWVuZG9uw6dhICgzKToNCj4gwqAgZHJt
L3hlOiBDYXB0dXJlIGRldmNvcmVkdW1wIG9uIFRMQiBpbnZhbGlkYXRpb24gdGltZW91dA0KPiDC
oCBkcm0veGU6IExvZyB3aGVuIGEgdGltZWQgb3V0IFRMQiBpbnZhbGlkYXRpb24gYWNrIGZpbmFs
bHkgYXJyaXZlcw0KPiDCoCBkcm0veGU6IEtpY2sgR3VDIHdoaWxlIFRMQiBpbnZhbGlkYXRpb24g
YWNrcyBhcmUgb3ZlcmR1ZQ0KPiANCj4gwqBkcml2ZXJzL2dwdS9kcm0veGUveGVfZGV2Y29yZWR1
bXAuY8KgwqDCoMKgIHzCoCA2OCArKysrKysrKysrKysNCj4gwqBkcml2ZXJzL2dwdS9kcm0veGUv
eGVfZGV2Y29yZWR1bXAuaMKgwqDCoMKgIHzCoMKgIDYgKysNCj4gwqBkcml2ZXJzL2dwdS9kcm0v
eGUveGVfdGxiX2ludmFsLmPCoMKgwqDCoMKgwqAgfCAxMzENCj4gKysrKysrKysrKysrKysrKysr
KysrKystDQo+IMKgZHJpdmVycy9ncHUvZHJtL3hlL3hlX3RsYl9pbnZhbF90eXBlcy5oIHzCoCA0
MiArKysrKysrKw0KPiDCoDQgZmlsZXMgY2hhbmdlZCwgMjQzIGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pDQo+IA0KDQo=
