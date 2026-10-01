Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BB9CA5FD5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CEF310E38C;
	Thu,  1 Oct 2026 12:11:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="k46zXmVT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DC7C10E1DA;
 Thu,  1 Oct 2026 12:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790856719; x=1822392719;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=MA2XNFlETLTcZMHhWLzbV+1KvFEeDMrVgI09lmuZjTY=;
 b=k46zXmVTCTfjwemQrLEQPYL4L9iVOIjTmQk/i7aOw3mm1O33zergsNfc
 XN+a2QkxM7KDvzK8KTNsbO+soJtigjaGtuW8pox3sPU5ewW1cK31yjx7g
 9QRQdcS1fWzXdXaVTcECH5XEM+mMJ/a1iXqR+SVnmUzIbJgyx6oVht6Iz
 +SA+7w8vgVYSgDJUxyD3LsG1kvKXV8lW3d+74gKOUc3RA/IYKNr2G1EpG
 7dApp/DHmXWRT3CBpPX7yHBylCSaoezlDVynEbk/EvSN06tJJgiV6F2eJ
 kXQ3cTQlfijBsyeTfXvXsDx43fTHqK4rCywlFmieeEd5f91m3ZIZ1cLcY Q==;
X-CSE-ConnectionGUID: Qw/UvcZCQIW/4DMj4mi5Og==
X-CSE-MsgGUID: xeTTQNESTJqnoeQCWwrmTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="101771563"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="101771563"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 05:11:56 -0700
X-CSE-ConnectionGUID: Ql9vP7zPQhuWCG6/GieiiA==
X-CSE-MsgGUID: p/sa4/0jRaedPkqg5gjblQ==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 05:11:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 05:11:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 05:11:54 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.64) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 05:11:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWbHQKfjQq2KLw2f0LtvjxIF9dW79mlMWOlFJlxbFfbzTeGvgOml6XaSpQSvl/LCmkS/pGRbjnl/ayNnWw8TU4xn/C8E73TUGFSM1ZADy1RnaYPolQmjmivp4FH8A5o0SYq7fp2iJ9FjQ+RNhlb3i0x+YmAPcMuuxZGNJGfA1jz0scHguzLAwpslyZikUIExVgr4wUlU8egLqR2/6tgFEetPHLZy/OYWnqA+srFbaEjXZLGk5Mqm9CDaCf8yaU0MnA9mpR5nKOEAfkYBum2K5BmT0L4hjWNphjD6dXlQGnrzkmcZBLpiQSsVomweOLcWS5ucc4YGRDECHBoFcVEyRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MA2XNFlETLTcZMHhWLzbV+1KvFEeDMrVgI09lmuZjTY=;
 b=aobQSRSSx1IJpIIKbfqntxh3cBkh/ifj3oLcvRMEsynhvgzmDm1P2AOexFiImgP1B+gLJWIuj23uxgQwE1Z8W35yPlzUHvgIaQQKqofsIQ8/itbqY5oZbcs/pJXgI+mHz2fJy04y6NGAAbYIPC8Af1MfmOjZ+CtN/6IQjr1+0Bz5eB2TNDfPHcHzDlQOh5w0qFZhhFcz7lDK81ll5sZ22NiRQ3kHBjb6d8PFauQY9/9dpmlnldsi78j3Yg6CrnTvnO9EhO+KshMUtrRaYgW2NKBtyjlrjjNN8X4vu15wNEV/cZFRiLkFHloNwYo7CgrDuv0spp65leaG7KDLFAaMJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 CH3PR11MB8093.namprd11.prod.outlook.com (2603:10b6:610:139::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 12:11:46 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 12:11:46 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v6 10/18] drm/i915/alpm: Modify LFPS cycle count for DP
 ALPM
Thread-Topic: [PATCH v6 10/18] drm/i915/alpm: Modify LFPS cycle count for DP
 ALPM
Thread-Index: AQHdRUGRiTfjuDQDlEuObs12e4Y2FLboUAeAgABhQQCAAABCgA==
Date: Thu, 1 Oct 2026 12:11:46 +0000
Message-ID: <5cf1a766f1e03338fbd945c461094c431be9baa5.camel@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-11-animesh.manna@intel.com>
 <5973833da40acc6c07ab0478cfc799bebb889862.camel@intel.com>
 <7356743fe09ae84dd5f6e5a34ca329ae42d37af3.camel@intel.com>
In-Reply-To: <7356743fe09ae84dd5f6e5a34ca329ae42d37af3.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|CH3PR11MB8093:EE_
x-ms-office365-filtering-correlation-id: 0e8f80aa-95f1-46fb-e7fb-08df1fb52a05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|38070700021|56012099006|11063799006|4143699003|3023799007|10067099003;
x-microsoft-antispam-message-info: 5BCu3kdpRuuNfWlA4RVVG4ji+Z/l90XhJKcxVOTa3pkVDNcMIe1W4XeN8a4VaZo7tOjWQLNJ5ukoe/Gjm7KLEyLWt3Go5QtgQqDnhatBjI76u8XIyN4Yhhxhymi1Ty0OVq0jyPzMhhHE1fNAd8Zf4c6CpfeDgF6yoo8N0BOabKJvGQc8hulK3FCnDKKafcGXidYglY9O58UX9kmRXnjhRAITxibNyiTh1lCgYZcNtWh5dBWNH27Pkyh1If28mrx++nfNBZstN9qSTj/Spex5mKRRlPDkImRx3DBZZZESPfIWTeZUhe+j+jN87W+cvSt89kDrS+y8SdFeSprU7Gsjt8zGWBsCOyH8xCzUDlPPjdsH+rZximPqR0ZtVcPe2gwfvRuP1Lu8bkwLBm+VKyBLdrpgZGa5nMELZuhATr7vQgdjK1UW0u4n6JLtkI1lETDgzgXG9yig43BRudLfxv9PH4o4+K4eCXoLg3iXNp/ma5EEJTTnayPO7wmN2pkDAT1CwcPUKbWgDutYF0Uk/zDsQ3ESKuOlSQxesKXJDY6sXGAOa0lX/Lj1R9hEesnjrOjqP1YHZ7ByK8pgbmIRcAcVOvm9FEbLkcWY6W8jKM3K9JQt8dOnPwUsrfl/OvCf+D15HYbBykqAVVDflUa4H9N7ErcR61V7ohxDwFxpOBFn7wGnw1pwaMqv2qBR5LC79yVP34OVrBHxWz6hVLdQlgYzPJdS2F7+DF9wD6+3PSDhRo8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(4143699003)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXlmZTR6V1hicVN6bmVIaDFyK2g4Z0FNZ2FxUStvTjBoZzBZTUhKNDhMd0Qv?=
 =?utf-8?B?enVlUU1qU09RVzh5eS90MHZPMWk3dzZjVTdJWTRLY01mRGd0T2l0bW8wQUNw?=
 =?utf-8?B?OHNnMFh0VStWOElVNXlISDZ6N2VNWStRQkR6bWYzYXhPMUZoTWNxYmpkZmli?=
 =?utf-8?B?QXAzcWhFR3dtT0VNMFdZeSt5MUFsWTEwd1cvTnpjU1UyZ1lsZ1I4MC95Tkp0?=
 =?utf-8?B?TTc3R3BkVDhrenZjLy9FSjcyVGUxcXVTeEduNCtuakdnL2k5RDdTamh1NXVL?=
 =?utf-8?B?cUIwVG5XbHNWb3JrVDhKMExxL2p2RUw1Z1ZhM1JweVl3SHdzNzNBYmN4QWYv?=
 =?utf-8?B?YllqdklNNnUvWExUNU90dGo0bVJlVFNjeHVSZTAwcExkblk3cjVmWHczTEp5?=
 =?utf-8?B?NDEzQmMwdkcrRG5zdXE1MVFlZ21sRG9YM3VHSEYvN1hyN0ZpcDBEOWdOU1Za?=
 =?utf-8?B?SGYvOUpubWNRWmI3NHNmYVpDY3BnRkRPVXVWSU5tVEZvWVRKazVCdFNBcU9J?=
 =?utf-8?B?OFprU1Eyd1N2OGE0Um5ZYjRBQThJMkN1a2Fjcm8rUDgwUU5DL2RQQUhSNm91?=
 =?utf-8?B?QzE0ZEs2NzZ1RnVBTVNUbUxBdXRHODRkOHE4WWtqNWI5dFJoT2NLSnlUZm9O?=
 =?utf-8?B?YUxIQ0JxMlhZd0hYR0FEVFFENTRMRGR0RzZReS9uTU0wdHNKN25Ed1lLWHZ1?=
 =?utf-8?B?NjdZYlFOVmdpOTN2L2hyd1cyb2R1Z3JGTm5uZXViUFF4NGpZVHZDUzRDOTVN?=
 =?utf-8?B?SWlFQkkreEhmT3BtZDlRMTNYTkNvU3dJV2k2RHFsK0F1V1pRWXUwQklSTGpY?=
 =?utf-8?B?a092UHk1TVVaRzRMV09EVmJ2VG9UQ1lwVWFaai9xekVmWmR4eitOSEk2bFlh?=
 =?utf-8?B?M1hnbDV4SVdsa0dObjV3eG9qZVNTdTltM2tndUlmanNSTG9wblRSTk9KSm1n?=
 =?utf-8?B?SkRMbFEwTVZkTCt0SmNJcGR3K2dKMWwrSWRPMGxKWGFTUU1obldsZG5oUUFl?=
 =?utf-8?B?RjJEQlY0TzNZU2ZhY1hUSlIwU0tRejcxa1FvYkJTZE11SlkrTjlEeU9zUnpj?=
 =?utf-8?B?Mis0eWhiRGtjVXJsZmFqbnU2U1QzemxlaG5hc0R3T1ZXVjVwa0Q2dUNkNE9w?=
 =?utf-8?B?K2lJNTUvLzY0UTg2dGU0S0hyWHZEZ3l0STV4RWhuOWpPOWlXUEw0OFpjZVRo?=
 =?utf-8?B?Uk41QWV3b2FmdEQrb3dPZ1psWFIxQU1zM0tWemtyS1o5YWRiUFl0Q25BVldx?=
 =?utf-8?B?R0NFVDB2V1JPdGRpbnJSUjJvOGVlWG4zdXI0cCtpREJaU2JoNUh0SEEydUpq?=
 =?utf-8?B?MjVoaU0wNzh3dXU5clJDcE9kZEVtSGNndlhJNDhwTHIxd0h0eURPMjNhMDN0?=
 =?utf-8?B?RWNmdWhudWR4TEFPVjVzbmxuZVNrd0p3dGV2QTUyNzFWVmpKVzRDUXRFM1Ru?=
 =?utf-8?B?Z0gvTXR3bUo4Y0NmMzV4T2ZpSVFnRDYyWXV6cGhJVXFkVWY1TlR1c2dUdkwz?=
 =?utf-8?B?MlhnYlBmRjRRWGx1czlMVlgrOFBYNXdoM01QWDZtZHJVWXAraWJXMkxLUmNy?=
 =?utf-8?B?SjM5czc3VUMrL3NxbE1tQ1pITm1wcWZ5RG5DQ1hXMEJPWDJJcTZhdGVnSWlN?=
 =?utf-8?B?K0NHTjNRNS9kWUhqN0RhVmZ5UHlSZGVXQnl5ZjRmMVdiSFdLYjJoeElOZ0RB?=
 =?utf-8?B?cEdWdUljdStmN0NqK0dkM2lGcXVwSDR5SVQ3QUU4N0NCRWVXaTFGUXRpZldZ?=
 =?utf-8?B?WGJLdG42WmZ1T1BNMFZvTzJ2di9uS2drT2hlMEtkcUM0TDFLeTdHZmZNenBB?=
 =?utf-8?B?czNDWnZXakFxREZleTViS2pVNTd5dVU0c2tTVVRFZFd1Rmo3Z3RXRi85Qk9B?=
 =?utf-8?B?VFFZNDFNa05oRTZCck15QnVTYnVvNVhwUjdndDlUd0NyYUFHcGRFZkQ4dFVl?=
 =?utf-8?B?TnZhWDNHS1drdnBuTFVQNk5xODJGRXp3VHM1U2d3aHoydC9DWjd0UlFTVisv?=
 =?utf-8?B?OVZ3c2hMbXUzdkVlTUNxNUtUOG5VZnpES1pva1VyTU9tK0pieVd1eWxCVHAv?=
 =?utf-8?B?TEk1RzNSMmFiNUlRMU1yZzVIcHRpdmxOOGl3ZW5KQmtEYi8xZ3lpeXdPK3FP?=
 =?utf-8?B?SmRRdkFGN1Y1cWlCNDQwcmIrd1ZMbFI5eVdxcG5TNytWM1ZUVW5BQXVJbHVx?=
 =?utf-8?B?Zy9lbXh4YkJIM0VxYjdTdDRPSllMTG9LWUEyNnJ3amNHRmZPN3JQZ3l1aU5G?=
 =?utf-8?B?MG1tT09UNlBqMVZlcFNBWUYxaUZrUlE0U0xMa3hiNGUxQVE2V1c5dm1qQXlz?=
 =?utf-8?B?RlQxUU01VzlEMDBTYmppcG52a1dYbDJnWngrQ01CU1Jmd2JTQ1RINkNuNllN?=
 =?utf-8?Q?enRwf325nuFyg4p0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB52BD333C124C429DEBBF9B093DE734@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mFuQ+6vFJxt44ww+YI6oHJBVMzSgigXJ7CV55FTj3vUJHaVEzU0EKpKhMYTavwie3jaw+Cz/RkaguZmmaNFdsMQGi87x9gqXnVFsAzSWsJaWJagaZBg4yegXzbpafI+edmdNKkpxVNg9kGoF1S0oJWAb9Hdgu7jG9bTw+9P+mQkNocZ6Uwh52yyxS78txU9ao76u+Pmv6zUNc7EyQaJVGw4wrpSnfw9Yj09j1SrVprDfzI6asUKBlvuaq5eMBL2e53GcG7zVD+KhAoww5/YpbeCFRvav4+BcCRP9rLK7XAap4w67w+OX/QqEEwt8rrcQuP/+Tn3wZUSV1aoFWAkBXQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8f80aa-95f1-46fb-e7fb-08df1fb52a05
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 12:11:46.4259 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OlUHE/jqw2OSxd4JeZeIKfdRGg5rJGXq92ADRTbNMPK8mEZj/Hy0Y7CvdIxC/eWRNV6033RiJckAwSAOBxbSv1ciIprcxD0ELSLNs1vvDDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8093
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

T24gVGh1LCAyMDI2LTEwLTAxIGF0IDE1OjEwICswMzAwLCBIb2dhbmRlciwgSm91bmkgd3JvdGU6
DQo+IE9uIFRodSwgMjAyNi0xMC0wMSBhdCAwOToyMiArMDMwMCwgSG9nYW5kZXIsIEpvdW5pIHdy
b3RlOg0KPiA+IE9uIFR1ZSwgMjAyNi0wOS0xNSBhdCAyMzozNCArMDUzMCwgQW5pbWVzaCBNYW5u
YSB3cm90ZToNCj4gPiA+IEZvciBEUCBtaW5pbXVtIExGUFMgY291bnQgaXMgc2V0IHRvIG1pbmlt
dW0gMTYuDQo+ID4gPiANCj4gPiA+IENjOiBKb3VuaSBIw7ZnYW5kZXIgPGpvdW5pLmhvZ2FuZGVy
QGludGVsLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuaW1lc2ggTWFubmEgPGFuaW1lc2gu
bWFubmFAaW50ZWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiDCoGRyaXZlcnMvZ3B1L2RybS9pOTE1
L2Rpc3BsYXkvaW50ZWxfYWxwbS5jIHwgMTYgKysrKysrKysrKysrKy0tLQ0KPiA+ID4gwqAxIGZp
bGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5j
DQo+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+ID4g
PiBpbmRleCAxNGVjYjI3MDk1YjIuLjIyZWQzNDE3NjNmYSAxMDA2NDQNCj4gPiA+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+ID4gPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiA+ID4gQEAgLTI0LDcgKzI0
LDggQEANCj4gPiA+IMKgCQkJCShTSUxFTkNFX1BFUklPRF9NQVhfVElNRSAtDQo+ID4gPiAJXA0K
PiA+ID4gwqAJCQkJIFNJTEVOQ0VfUEVSSU9EX01JTl9USU1FKSAvIDIpDQo+ID4gPiDCoA0KPiA+
ID4gLSNkZWZpbmUgTEZQU19DWUNMRV9DT1VOVCAxMA0KPiA+ID4gKyNkZWZpbmUgTEZQU19DWUNM
RV9DT1VOVAkxMA0KPiA+ID4gKyNkZWZpbmUgTEZQU19DWUNMRV9DT1VOVF9EUAkxNg0KPiA+ID4g
wqANCj4gPiA+IMKgYm9vbCBpbnRlbF9hbHBtX2F1eF93YWtlX3N1cHBvcnRlZChzdHJ1Y3QgaW50
ZWxfZHAgKmludGVsX2RwKQ0KPiA+ID4gwqB7DQo+ID4gPiBAQCAtMTIxLDEwICsxMjIsMTkgQEAg
c3RhdGljIGludCBnZXRfbGZwc19jeWNsZV90aW1lKGNvbnN0IHN0cnVjdA0KPiA+ID4gaW50ZWxf
Y3J0Y19zdGF0ZSAqY3J0Y19zdGF0ZSkNCj4gPiA+IMKgCXJldHVybiB0bGZwc19jeWNsZV9taW4g
K8KgICh0bGZwc19jeWNsZV9tYXggLQ0KPiA+ID4gdGxmcHNfY3ljbGVfbWluKSAvIDI7DQo+ID4g
PiDCoH0NCj4gPiA+IMKgDQo+ID4gPiArc3RhdGljIGludCBnZXRfbGZwc19jeWNsZV9jb3VudChj
b25zdCBzdHJ1Y3QgaW50ZWxfY3J0Y19zdGF0ZQ0KPiA+ID4gKmNydGNfc3RhdGUpDQo+ID4gPiAr
ew0KPiA+ID4gKwkvKiBFeHRlcm5hbCBEUCB1c2VzIGEgbWluaW11bSBvZiAxNiBMRlBTIGN5Y2xl
cy4gKi8NCj4gPiANCj4gPiBJIHRoaW5rIHRoaXMgY29tbWVudCBpcyB1c2VsZXNzLiBBbnl3YXlz
Og0KPiA+IA0KPiA+IFJldmlld2VkLWJ5OiBKb3VuaSBIw7ZnYW5kZXIgPGpvdW5pLmhvZ2FuZGVy
QGludGVsLmNvbT4NCj4gPiANCj4gPiA+ICsJaWYgKCFpbnRlbF9jcnRjX2hhc190eXBlKGNydGNf
c3RhdGUsIElOVEVMX09VVFBVVF9FRFApKQ0KPiA+ID4gKwkJcmV0dXJuIExGUFNfQ1lDTEVfQ09V
TlRfRFA7DQo+ID4gPiArDQo+ID4gPiArCXJldHVybiBMRlBTX0NZQ0xFX0NPVU5UOw0KPiA+ID4g
K30NCj4gPiA+ICsNCj4gPiA+IMKgc3RhdGljIGludCBnZXRfbGZwc19oYWxmX2N5Y2xlX2Nsb2Nr
cyhjb25zdCBzdHJ1Y3QNCj4gPiA+IGludGVsX2NydGNfc3RhdGUNCj4gPiA+ICpjcnRjX3N0YXRl
KQ0KPiA+ID4gwqB7DQo+ID4gPiDCoAlyZXR1cm4gZ2V0X2xmcHNfY3ljbGVfdGltZShjcnRjX3N0
YXRlKSAqIGNydGNfc3RhdGUtDQo+ID4gPiA+IHBvcnRfY2xvY2sgLyAxMDAwIC8NCj4gDQo+IEp1
c3QgcmVhbGl6ZWQgdGhhdCB0aGlzIGhhcyB0byBiZQ0KPiBpbnRlbF9kcF9saW5rX3N5bWJvbF9j
bG9jayhjcnRjX3N0YXRlPnBvcnRfY2xvY2spLiBGb3IgZURQIGl0IGhhdmUNCj4gYmVlbg0KPiB3
b3JraW5nIGFzIGNydGNfc3RhdGUtPnBvcnRfY2xvY2sgPT0NCj4gaW50ZWxfZHBfbGlua19zeW1i
b2xfY2xvY2soY3J0Y19zdGF0ZT5wb3J0X2Nsb2NrKSBhbHdheXMuDQoNCk1heWJlIGFsc28gZ29v
ZCB0byByZW5hbWUgdGhpcyBhcyBnZXRfbGZwc19oYWxmX2N5Y2xlX3N5bWJvbHMuDQoNCkJSLA0K
Sm91bmkgSMO2Z2FuZGVyDQoNCj4gDQo+IEJSLA0KPiBKb3VuaSBIw7ZnYW5kZXINCj4gDQo+ID4g
PiAtCQkxMDAwIC8gKDIgKiBMRlBTX0NZQ0xFX0NPVU5UKTsNCj4gPiA+ICsJCTEwMDAgLyAoMiAq
IGdldF9sZnBzX2N5Y2xlX2NvdW50KGNydGNfc3RhdGUpKTsNCj4gPiA+IMKgfQ0KPiA+ID4gwqAN
Cj4gPiA+IMKgI2RlZmluZSBNTF9QSFlfTE9DS19MRU4JCTI1Mg0KPiA+ID4gQEAgLTc3OSw3ICs3
ODksNyBAQCB2b2lkIGludGVsX2FscG1fcG9ydF9jb25maWd1cmUoc3RydWN0DQo+ID4gPiBpbnRl
bF9kcA0KPiA+ID4gKmludGVsX2RwLA0KPiA+ID4gwqAJCQlQT1JUX0FMUE1fQ1RMX01BWF9QSFlf
U1dJTkdfSE9MRCgwKSB8DQo+ID4gPiDCoAkJCVBPUlRfQUxQTV9DVExfU0lMRU5DRV9QRVJJT0Qo
DQo+ID4gPiDCoAkJCQljcnRjX3N0YXRlLQ0KPiA+ID4gPiBhbHBtX3N0YXRlLnNpbGVuY2VfcGVy
aW9kX3N5bV9jbG9ja3MpOw0KPiA+ID4gLQkJbGZwc19jdGxfdmFsID0NCj4gPiA+IFBPUlRfQUxQ
TV9MRlBTX0NUTF9MRlBTX0NZQ0xFX0NPVU5UKExGUFNfQ1lDTEVfQ09VTlQpIHwNCj4gPiA+ICsJ
CWxmcHNfY3RsX3ZhbCA9DQo+ID4gPiBQT1JUX0FMUE1fTEZQU19DVExfTEZQU19DWUNMRV9DT1VO
VChnZXRfbGZwc19jeWNsZV9jb3VudChjcnRjX3N0YQ0KPiA+ID4gdGUNCj4gPiA+ICkpDQo+ID4g
PiA+IA0KPiA+ID4gwqAJCQlQT1JUX0FMUE1fTEZQU19DVExfTEZQU19IQUxGX0NZQ0xFX0RVUkFU
DQo+ID4gPiBJTw0KPiA+ID4gTigNCj4gPiA+IMKgCQkJCWNydGNfc3RhdGUtDQo+ID4gPiA+IGFs
cG1fc3RhdGUubGZwc19oYWxmX2N5Y2xlX251bV9vZl9zeW1zKSB8DQo+ID4gPiDCoAkJCVBPUlRf
QUxQTV9MRlBTX0NUTF9GSVJTVF9MRlBTX0hBTEZfQ1lDTEUNCj4gPiA+IF9EDQo+ID4gPiBVUg0K
PiA+ID4gQVRJT04oDQo+ID4gDQo+IA0KDQo=
