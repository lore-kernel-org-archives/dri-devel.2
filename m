Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD25DF31E21
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04A0910E7FA;
	Thu,  9 Apr 2026 14:07:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="liteeiL1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B74E110E7F9;
 Thu,  9 Apr 2026 14:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775743635; x=1807279635;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=mLOSVjHysp5MoSM185/80eU151pPToB9l1lWVatWKBg=;
 b=liteeiL1MyCQANQbkULtEcamvAMlszi3HeQV1eJU6NltCQ19tYkvRbTl
 Ugaub+7Bfl4XhNyGiSNjV0VwywOOLWU1RxfN4cJXRtchYIuBQ/+5KZ+5+
 0tOCJjrPmFCHiH9fkMYTBUnod5/wGdoJWFSHlA8M0DESPS8pFeqRRRULX
 P7cRBDaARRbWZyShwiKDB/ErGcCpLzEL/1Xk3R3CvdWZwXnakHIZM/2u2
 bpQIri4H9TN1QdY2WEzF6apN/vJ1op/hcoZgEaqbLiq2fyQ8KFlmIf48Y
 Z1b79apR832y0CsqSGP1O6YpBb9J19dZ4j3MOlc968nFwbBhACqP6latH Q==;
X-CSE-ConnectionGUID: P4VLZGVBSpCaAWAD65ucBg==
X-CSE-MsgGUID: XCQKv98TTOWOmN+UukQB3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76711725"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="76711725"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 07:07:14 -0700
X-CSE-ConnectionGUID: UNQWB8KLQKurtv9Wabg7CA==
X-CSE-MsgGUID: zP/iif7aTd6O8aNJgrbOfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="222282155"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 07:07:14 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 07:07:13 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 07:07:13 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.50) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 07:07:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JP5EE5c7/AL02qEt33eEe86wF8FRFefVdxROcV4OGT7Tkh3w1eNzzettZlzsYEAsZt5zoMkfguloEfWdkyEzLSyc2qT2jiJmPdT0ssamjQ1Q7v8q5hddOdCHn/LJa6Mfw6WtzW3+WNJxVdkVS19fAfgDvveJK+ZwZglibYtpLWMHbmGnnLpWUYNLwF1wb9rglHaKOkDC9LIUOGVhSeuiVkde8biVbO/jIr13U5cPVS5PswFna/6yMTWFg6AgNq7FXS82LZW6NmJ/u7qrk4kxIiGNkont6GO5LD4jyoXkE7SMEu7DAk5MGRMrwJb0C1wC3uqwVRXwuZ43xQ9MQsXogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLOSVjHysp5MoSM185/80eU151pPToB9l1lWVatWKBg=;
 b=GpR4eVBKM+WU5OX9T3A/WzC+TUcVp9caVVbSde7FwRlqrya7ceFsJDCbuWtPabFCPDvOJ1LISme71c6mF6kydADCk2eTIEEtVbIipAuCnm6cvMblBLOKEOf6qbw+rUUigY0/RA2YnCLmpA/aROT9gJkaKAiTDW7mgubhCchy+g1ihQkcc7/2LiwBGeL5yvk4AqhNarUceBYPQ2LZmcpW9QsXVH6XoWfx0AXWig8phjTrZ1UGvnl7YQnISIhODRAjv7H8dwTjKcjfIEb8iik0fT2Ov3NLMY/Se5UHLi7yy8QDDehGzfmZFcm09/+bdOM7V1tzHEsEV3uh4ab7Wksr9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5663.namprd11.prod.outlook.com (2603:10b6:a03:3bc::9)
 by PH8PR11MB8257.namprd11.prod.outlook.com (2603:10b6:510:1c0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 14:07:04 +0000
Received: from SJ0PR11MB5663.namprd11.prod.outlook.com
 ([fe80::e4cb:d003:6475:26bd]) by SJ0PR11MB5663.namprd11.prod.outlook.com
 ([fe80::e4cb:d003:6475:26bd%3]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 14:07:04 +0000
From: "Knop, Ryszard" <ryszard.knop@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Auld, 
 Matthew" <matthew.auld@intel.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Brost, Matthew" <matthew.brost@intel.com>, "christian.koenig@amd.com"
 <christian.koenig@amd.com>, "airlied@redhat.com" <airlied@redhat.com>
Subject: Re: [PATCH 2/2] drm/ttm/tests: make no_dma_alloc conditional on x86
Thread-Topic: [PATCH 2/2] drm/ttm/tests: make no_dma_alloc conditional on x86
Thread-Index: AQHcyBqddBrRmIwxYEOYcylncXX167XWxBKA
Date: Thu, 9 Apr 2026 14:07:04 +0000
Message-ID: <5ce90144dd48590d68541530c687b283bd9b9873.camel@intel.com>
References: <20260409121512.81298-3-matthew.auld@intel.com>
 <20260409121512.81298-4-matthew.auld@intel.com>
In-Reply-To: <20260409121512.81298-4-matthew.auld@intel.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5663:EE_|PH8PR11MB8257:EE_
x-ms-office365-filtering-correlation-id: 6727e9d7-b3b0-438e-5ac4-08de96414742
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 3Xpc8cvfzcOUVvr0/qWPRT3pLsScBcWBFCVbUjKDBTNvXLwIGylK2+zuw6eopAikqN94XyXK3lKNCJ8MJUqURbsEqzY63aOcUP4UK+PBZPlwn3dWtCGTRAQH9s8H7EzQd+6t4C/08nMm4DfWq/UR+GKRARpcND/S8WufDEDAl8zEHpsBdCeAWe+8iivaTHCB8jRmJpAbYV5jMXOnwPTMgAycYLD9cQ7y2ReNEwnxohSNECgBbnCxkU/YuL4QslffzxD91J7zmaUo7VcTFMt7YKWcsOis1HZ1zw2xdz0//EaciuEtW3UVJjUSsP4/EcbqrPqs2mRaO0Qkce+441NllLQOY69zp3P6Ppo2VcGq8hUl4N3ITfRDZFUeCYzlWqLTc+a/ol4+onP7CeHZz8rnrRKIeYq0qP5VJui4R9dTrzZfW6YDK3buuFZDuAKJ5QaqNUYgWK3W0XJxDXsKxMIx4rF9YdKcdj9UMMzbWokQjxjW0h8apkJZAIPcqLYQ5VC0GKfCfxgc3TYU1qi11gvgrkdt4FkZM+mcxKn2AaaxLi2/fun17cy/FkqHGmyyCGrIwTMkg+lWDhVZjcVNOnpOSg7dtHlpiZxmGwNRRe+Slnb/+W/w1TYQp+V5MUzl6mZAs3PspNktRlvfTjRDPQphrAEqd3Z3+0v4Xy9EDCK1taZ91tRN/IFiu16q9VAqWMlNuE4qAYm0jAShsJt+gcjkpqu3usmJb63CCetPqaIRbzUZGx2SVruL3i3WQ7lilFS+HHSaRLJEjsSVbtf4rVwRgITHUstHVUfTxrwoBqwSx2Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5663.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnF0Z3M0M0xoOGxLWHIwc08wdjRUanNLRkk2aisyTEFobm1wTERQSEFQTXNl?=
 =?utf-8?B?TzhlVHV0UmJrdjNPNkYvc2dJQ2ZUMjFEemY5QStaemFKNnBXTkxkTmtpNmd4?=
 =?utf-8?B?bWJGdml4MVhhbi9VSk56aU5QSTE5SlcyZHNOUnB3b2hpN0p4bnRZaHhXWisx?=
 =?utf-8?B?ckFSMjVnMXpnMWhtdXV5d3l3aTdEdVZMdzVaQjFza3JyL2E0NlQ5dU5ubGsr?=
 =?utf-8?B?MGVZZFNLZW5ud2lMeUhWbzlCZU56dmQ5YUpNVkhPRXI0YTQvYTVZZkFVSVNR?=
 =?utf-8?B?T21LcTZRejh3TWM4UC9uL1VCR0ZOZ0V2VkczMWNQQ3RySnJMRzJFSFlOVnNs?=
 =?utf-8?B?dHBxOXNYWGlFNVYwM0c2akt0UkhXZDdidnFDZmVaODRYQnVZS1lrUlBFU0ht?=
 =?utf-8?B?QWo2azlSSWtqVVkwOTUzYTVIcUdrQUVYY3pyak55UFE5S0QzS1ZzV2tIbW9x?=
 =?utf-8?B?dXdsSTdHVWhiNmUwNzhnYzJYQ1JNZ2VBMS9Qc2hyQ0VsZ05Benk0UXp3L1Rk?=
 =?utf-8?B?MnV1d2QvQ2pab0pGYlpXUThzK21uM3BjY3RXbVdBWkMyenpOMTJ1WC9NZHNv?=
 =?utf-8?B?N0huTkUwU1RWM1NDRWJKbDlYSEwyNGF0NUM4TUMzTUtBUitobVhFTzlBMDBC?=
 =?utf-8?B?MHBmVktYQW02VmxTL2dnODBEbHZ2MDFDVGRUSTg4SHg2K1FCMUxlSVdvTlFQ?=
 =?utf-8?B?QWxueVA2MTR0UUI4V2cyeFRDcmM5TUp3YThCbkhoZmp2a0RkY0VwK2RQdFFW?=
 =?utf-8?B?YXVQeExtUW5KTUF6blZza1JlcWdpYnoycGJYb201NWZIM1lUTEs2bHJvSzJy?=
 =?utf-8?B?bmM4V3RaMUdzWUZaUTJnc3FnMVBWN29iaG1WVkIvcGZIaXBhWlA1V3FvTHpL?=
 =?utf-8?B?WmNNWmlSc1NwMWtFNXNjUEJDMmJGZHJQSTFYTktCQ0pWTnArNnVEeWhnaGNm?=
 =?utf-8?B?RHE3QU1JU255SmdZYno0ZkVQbUFMMzJzekpjRTdxaUhEU2ZPZDdnVkRmaHFw?=
 =?utf-8?B?Sytpb3hBKzM0aHI5NjM4Y3U4cXFRSjlCTlFqNEl6T00ya0VMQTVTbEU0dnpr?=
 =?utf-8?B?QXBJZTVFWU1oeXBlUWg2Qk1GMm5SOUt2UlZDbzJzZSt1dmdMa2Z1RHovNEFI?=
 =?utf-8?B?M1FyS3MzYkRwam9OWmViTk5sKzNWN2ZpQlhsRWlQQVhZZlhLMXJyWkFnMkk5?=
 =?utf-8?B?NEttcDBmZ2NKVGtyQWd6K0YvcG1mSkpvdWVrbG9SR1BpaWRncjEvSk9TVGhB?=
 =?utf-8?B?R0l3d2xCblNkb0JuVklialBId0tpcUhBMU9lbXlCNGFJejlWckF4SWRtVHg4?=
 =?utf-8?B?eDFqaU9Cd2xOdFRVZGRMWnpLZllsaGlsZkxyUmZ2T21uanlsRllpTnk2WFda?=
 =?utf-8?B?ZzVIYXl4R0l6amZMVS9qRmlONDB4dWdnQUFxWnRkU05KTnE4RGxUd2pRQnB3?=
 =?utf-8?B?UGl4QVJIOEwvbW5VR2ZpMWk5SDN0MzRxb3hnUm9iNEpzbEQvKzcyMGJjbFZV?=
 =?utf-8?B?aUpiT3FSRldCemxVclVhNE5yeG9FWkw4L2RCdWcvdlUvV3c3NytITkx0RlA4?=
 =?utf-8?B?ZSttZ052U3Mwc2tDcnpMMldxRlBEdHQrMWJyZll2NTl4NnJlNUR1RS9sUlRq?=
 =?utf-8?B?R2NPVWVtendFbi9tdFJ5MzVOM0xMelRDaW90K2k0K25JMVdXVUlReFh5SHVL?=
 =?utf-8?B?dWp3S1p5dVN5eWxYWDRMdXhtdzh1VGFBUEtWTEMyNC9nTFBtTmhyd3hOOEt2?=
 =?utf-8?B?RlpxZnh1aC9GSGxCUG0xQ0ZJYzQycWpiMkNTYjJRMXNYanBCNFhNMWVVaXBU?=
 =?utf-8?B?b0c5aXFscXV5ZTF0TWhQY0RKbkVnQlNQSFRaUFVuV3NPQUt6bldKOE5KY3Ux?=
 =?utf-8?B?UjFsbWE2bVJKNURXUUIwK3I2UVpXcElOajBwUnpBL2N5SVp1M1REWk9TZHRS?=
 =?utf-8?B?Y0VqQXdRS2xacmI3Q3N2UmVOU0JXaEhkRW53cUNXY1dqZ3J3NDFQSG5iakh2?=
 =?utf-8?B?NjFwT0lhZjZ4RWRKdUlHVW9DWmh4bUNsblEzdjF2ellEWmRPb1FrSDZ4dEVK?=
 =?utf-8?B?Q3FncmhUeDhMSXVmLzM0UlVrMnhPZmdkbDB5cnNHbVFnemUyejRJaHlzMDVF?=
 =?utf-8?B?NnV3WUdUQUJ1d2pxN09CZXhBZXZOaHZDR2ZkMkFsVzNJZHFqL3RHMjdZRHZF?=
 =?utf-8?B?MTJUb1UrZU9FVC9qUkIyQTl6TnAyYzNkL1ZnYWRIMHFvckZiOEF0VHRkKy9x?=
 =?utf-8?B?QVRNVm8wVWtSZmlQWjdQRmJBWllKM1VNNWxockVjQUljYWJYM2FZalQrdWdo?=
 =?utf-8?B?bVdMbkR5RE8xR3B0MDRva2dlczBZREZobGwxeC9wYWx3ZWEwKzgxek5HNjkw?=
 =?utf-8?Q?oQz/+RYZAPHNFMJI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F65B4C73F9E9A40BCADE8BF6A5BED0D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aDLnjl7m93xcoSatw/EkJWLTrOAHLjHYtfvPUAjX97Z79ZTNUbZhqPyHkMBxICm2U3gvnmPRpoWWhdc/ured9p5IpMgcDxezyUsKK6YYJie0fzCt6h63ravYta5lDILSP3iYfJ6gUvHVBfD7HMog2Qqe3Jrsea/S6xnPUVnHd1kV1mkAzZODwu//YNJp9jJ3xmfNcDCfhdjLA8mwmKVAVe6BiWr0waU6JAQpL+sZhzMg8so+2I1kh3aYq4IauNGhHkbY9KIYYIHcGppmrbLX4l2XiKWHTL2okE1MHWw6f22du9CuV95fIi/OFS+d54MsIs9faMAu91PHpNaV1m5/lg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5663.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6727e9d7-b3b0-438e-5ac4-08de96414742
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 14:07:04.5614 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: otTDEJj7JN4ecs3UZl13zrdfwWM9XTXM7a9Kf0SBN9jpvzPfpI7Vyq+Uqke2kcqnSNbp6UsTHJoOAjPZnRMavw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8257
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

VmVyaWZpZWQgbG9jYWxseSBldmVyeXRoaW5nIGxvb2tzIGdvb2QsIENJIGlzIGdyZWVuIGFnYWlu
LCBzbzoNCg0KUmV2aWV3ZWQtYnk6IFJ5c3phcmQgS25vcCA8cnlzemFyZC5rbm9wQGludGVsLmNv
bT4NCg0KT24gVGh1LCAyMDI2LTA0LTA5IGF0IDEzOjE1ICswMTAwLCBNYXR0aGV3IEF1bGQgd3Jv
dGU6DQo+IElmIHlvdSBydW4gdGhpcyBvbiBVTUwsIHRoaXMgZ29lcyBkb3duIGluIGZsYW1lcyB3
aXRoOg0KPiANCj4gWzEwOjIzOjMzXSBQaWQ6IDc1LCBjb21tOiBrdW5pdF90cnlfY2F0Y2ggVGFp
bnRlZDogRyAgICAgICAgVyAgICAgICAgTiAgNy4wLjAtcmM3LWcyMjFkMDQxOGRjZmQNCj4gWzEw
OjIzOjMzXSBSSVA6IDAwMzM6bGlzdF9scnVfY291bnRfbm9kZSsweGUvMHgyMA0KPiBbMTA6MjM6
MzNdIFJTUDogMDAwMDAwMDBhODhjYmVkOCAgRUZMQUdTOiAwMDAxMDI0Ng0KPiBbMTA6MjM6MzNd
IFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IDAwMDAwMDAwYTg4MDNjOTAgUkNYOiAwMDAwMDAw
MDY4ZTRjN2Q4DQo+IFsxMDoyMzozM10gUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogMDAwMDAw
MDAwMDAwMDAwMCBSREk6IDAwMDAwMDAwNjhjODY4ODANCj4gWzEwOjIzOjMzXSBSQlA6IDAwMDAw
MDAwNjhjODY4MDAgUjA4OiAwMDAwMDAwMGE3NjU4YzI4IFIwOTogMDAwMDAwMDA2OGM1MGM4MA0K
PiBbMTA6MjM6MzNdIFIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6IDAwMDAwMDAwMDAwMDAwMDAg
UjEyOiAwMDAwMDAwMDY4YzUwYzgwDQo+IA0KPiBPbiBVTUwgKHdpdGggbm8gc3BlY2lhbCBkbWEg
cG9vbCBmbGFnKSB0aGVyZSBhcmUgbm8gc3BlY2lhbCBwYWdlIHBvb2xzDQo+IGl0IHNlZW1zLCBz
byBkaXJlY3RseSBhY2Nlc3NpbmcgdGhlIHBvb2wgc3RhdGUgaXMgY3VycmVudGx5IGludmFsaWQs
DQo+IHNpbmNlIHRoZSBscnUgc3R1ZmYgaXMgbm90IGluaXRpYWxpc2VkLg0KPiANCj4gV2l0aCB0
aGF0IG1ha2Ugbm9fZG1hX2FsbG9jIGNvbmRpdGlvbmFsIG9uIHg4Niwgd2hlcmUgdGhlcmUgc2hv
dWxkDQo+IGFsd2F5cyBiZSBzb21lIGtpbmQgb2Ygc3BlY2lhbCBwb29sLCBpZiB3ZSBkb24ndCBz
dXBwbHkgdGhlIHNwZWNpYWwgZG1hDQo+IHBvb2wgZmxhZy4NCj4gDQo+IEZpeGVzOiA0NDRlMmEx
OWQ3ZmQgKCJ0dG0vcG9vbDogcG9ydCB0byBsaXN0X2xydS4gKHYyKSIpDQo+IFNpZ25lZC1vZmYt
Ynk6IE1hdHRoZXcgQXVsZCA8bWF0dGhldy5hdWxkQGludGVsLmNvbT4NCj4gQ2M6IFJ5c3phcmQg
S25vcCA8cnlzemFyZC5rbm9wQGludGVsLmNvbT4NCj4gQ2M6IE1hdHRoZXcgQnJvc3QgPG1hdHRo
ZXcuYnJvc3RAaW50ZWwuY29tPg0KPiBDYzogQ2hyaXN0aWFuIEtvZW5pZyA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPg0KPiBDYzogRGF2ZSBBaXJsaWUgPGFpcmxpZWRAcmVkaGF0LmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vdHRtL3Rlc3RzL3R0bV9wb29sX3Rlc3QuYyB8IDYgKysr
KysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90ZXN0cy90dG1fcG9vbF90ZXN0LmMgYi9kcml2ZXJzL2dw
dS9kcm0vdHRtL3Rlc3RzL3R0bV9wb29sX3Rlc3QuYw0KPiBpbmRleCAwMTE5NzAxNGI4M2YuLjky
NjYxNWY2M2ZmZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90ZXN0cy90dG1f
cG9vbF90ZXN0LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90ZXN0cy90dG1fcG9vbF90
ZXN0LmMNCj4gQEAgLTIsNiArMiw3IEBADQo+ICAvKg0KPiAgICogQ29weXJpZ2h0IMKpIDIwMjMg
SW50ZWwgQ29ycG9yYXRpb24NCj4gICAqLw0KPiArI2luY2x1ZGUgImxpbnV4L2tjb25maWcuaCIN
Cj4gICNpbmNsdWRlIDxsaW51eC9tbS5oPg0KPiAgDQo+ICAjaW5jbHVkZSA8ZHJtL3R0bS90dG1f
dHQuaD4NCj4gQEAgLTM3Myw2ICszNzQsMTEgQEAgc3RhdGljIHZvaWQgdHRtX3Bvb2xfZnJlZV9u
b19kbWFfYWxsb2Moc3RydWN0IGt1bml0ICp0ZXN0KQ0KPiAgCXVuc2lnbmVkIGludCBvcmRlciA9
IDI7DQo+ICAJc2l6ZV90IHNpemUgPSAoMSA8PCBvcmRlcikgKiBQQUdFX1NJWkU7DQo+ICANCj4g
KwlpZiAoIUlTX0VOQUJMRUQoQ09ORklHX1g4NikpIHsNCj4gKwkJa3VuaXRfc2tpcCh0ZXN0LCAi
TmVlZHMgdG8gYmUgcnVuIG9uIHg4Ni4gU2tpcHBpbmcuXG4iKTsNCj4gKwkJcmV0dXJuOw0KPiAr
CX0NCj4gKw0KPiAgCXR0ID0gdHRtX3R0X2t1bml0X2luaXQodGVzdCwgMCwgY2FjaGluZywgc2l6
ZSk7DQo+ICAJS1VOSVRfQVNTRVJUX05PVF9OVUxMKHRlc3QsIHR0KTsNCj4gIA0K
