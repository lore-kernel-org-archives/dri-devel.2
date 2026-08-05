Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4428C55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 14:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6A3610E13C;
	Wed,  5 Aug 2026 14:15:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iSB5l73q";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBAFC10E13C;
 Wed,  5 Aug 2026 14:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785939338; x=1817475338;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AoYHuHUKOnadqj/rncc81phHeOJMxQ6jSQ6wUtHvjFQ=;
 b=iSB5l73qVBMRsYFl3iiP7P5+tAlYQ50GTifV+CKBAx5m0WXVr+KuqeP/
 i065VZQUlisQFPGb2E/AZRb41eHB0H1xkryzSozm3pzqG+bZIZW9rJ9Cf
 2G9IP+Ln0st0zGuq1HBX4KCBEMC7HHuM/2Km66r44+6tjwsZZChdlbwYf
 1gSQXFPK+rC0CmvJqDC0xkpGp2K/wiCRyzviG0kdPpC3bqDkHD/jPQhP1
 Ud4rmStWgWCMQZTmRsTIsdo5dAU9FjQVY+qYqq+7i2LJnLknwvm2dd7Yc
 UwgwlV+WQ/P1Z/FcPil3uvHfjI7ojudzZxQaZH6CQIRpgpvGHqsIi6hUA A==;
X-CSE-ConnectionGUID: T0Go5HmCRwGdWBt7+GU4Aw==
X-CSE-MsgGUID: eCTfHkUgSwGKeIrP+J2JZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86629267"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="86629267"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 07:15:38 -0700
X-CSE-ConnectionGUID: A15s+YD6TxK4HI3DX6VvHw==
X-CSE-MsgGUID: e4qJ1UoITAu6FBbOARNBLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="291753161"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 07:15:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 07:15:36 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 07:15:36 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.24) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 07:15:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzwF1yMvvjfuDhIGS31Cu6v56qcf6X9J6AxYQTaDroZt/LBhv0VQCNV6M6Y0GvgAA5cnrpdCt5UQrpd38SnzfB9FeQumniXIKV8yjN8BCz1B9fHMbe4nYwkKQyljzYftz14R9jYE7/miULjmKwVOGOe0lf+vwIhKsQAojL/TbdU+aTEfx9siXtjRON3oHpDKxeR+veT//9hQJ8eyWao6erDDIPSixpgj6YErskSUvYw6MwbymRPclTn4kqLW1vE+jweMYYnfuAktOe6o6A5Px3zAskev59e9lpkcKn6Ajv2JoFYrBiRbSCsPPX81V0y/GOo6Cmsu03uIOLMTKT62yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoYHuHUKOnadqj/rncc81phHeOJMxQ6jSQ6wUtHvjFQ=;
 b=CwIcCDoOlFjf73vdEdqez2kIbJVw73reOTPl7LWKqTuBS/sJCdRZCzAqFByq3KmrSWlOWy5EmM40z291VSpUJEP8OQo5EN9BhO9GRtNlVEAVhsJPtN/CeA6j35BaFO8MAVg4FML9f8eF3RX5WCFmiHWmOiuPQC6v5VHtSA97lXlTthHfF65//FxaR44ZLkW4gvOZ2TrCgPY9FaHsshViQeR1wkncJqpcriQ3M3meBEeh49LeeO7lYXc7XjuxDuD5PUnUMHBrqz2ROttRU33PRSqkQ9e0Q3TmsCbfTeYhU47VSQlcuHL75iQJzi+rw2J0EOH00+Bhi5pnSI5QYCXaCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB8523.namprd11.prod.outlook.com (2603:10b6:806:3b5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 14:15:33 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 14:15:31 +0000
From: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>
To: "Auld, Matthew" <matthew.auld@intel.com>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
CC: "arunpravin.paneerselvam@amd.com" <arunpravin.paneerselvam@amd.com>
Subject: RE: [PATCH V3 2/2] gpu/tests/gpu_buddy: Add KUnit test for
 gpu_buddy_allocated_addr_to_block
Thread-Topic: [PATCH V3 2/2] gpu/tests/gpu_buddy: Add KUnit test for
 gpu_buddy_allocated_addr_to_block
Thread-Index: AQHdHo7pMRpocYl5iUKy8TkbKdpW+raEo4mAgAAH+YCACuDN8A==
Date: Wed, 5 Aug 2026 14:15:31 +0000
Message-ID: <DS0PR11MB8718C53436BDECFD9FBA3F6D81D32@DS0PR11MB8718.namprd11.prod.outlook.com>
References: <20260728124438.2679542-4-tejas.upadhyay@intel.com>
 <20260728124438.2679542-6-tejas.upadhyay@intel.com>
 <5c2f8869-3228-4cf9-8ac4-3ada7610aa61@intel.com>
 <2f136d39-51dc-4aaa-ab9b-4ba4c737ebfd@intel.com>
In-Reply-To: <2f136d39-51dc-4aaa-ab9b-4ba4c737ebfd@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8718:EE_|SA1PR11MB8523:EE_
x-ms-office365-filtering-correlation-id: 702c1216-6ff4-49f5-cf59-08def2fc020f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: SAcLBS4yJLF0nHUxqCIE1XnDXVIxrom4VJXrFI/E1W8WLoowJqYfcJnEI7Lngq3+iwp211o7qLpGGAT0XsC5QRGgwgw5fBRx0zOWY157OxU5xn36u8O65wGxQbNAgz9iNFYI4soal2zSoYjd07Ii5s/+/s0f5XL+K2X9yJNWRDpmVvv1WTBAFP7111RImicN94YGrdRNdFouAp1u4XHSIHGmzfLN/buk58vBvwPvC8FedtgIizVGRYI9kXx/MWLhJzUPHNuuxF9iDkH5K+3Q/iZRLkh6rb0pWREwKmeDIwW2rAgKuKSqRjCF8dNH0xZBmYSzUybY9sg+F4Esox1LNfI7IjAzjkkkpCNB2yzvkCyxR53jO1Bpf2O83eJ373C36rnJ3JVAjlaI4Bg6T1qrBrn5mOACmCU3OPrhMrdfhJvJl4PVzVPJCHpmUWv16fhhkWSROLSkrolMhyd7I3nwcNK5w2WRc2w5qbYjRTFsJ70rN3m/1jxmc29DvaLYnC/kT1V1qXmN985nFU1JqtjF8c5UKrTwTG73viXIzfCcrVYfLNu5KWQc2MrtRnHHPCM7Hig8d0FQViD/TQhrqcWp0rtlNSZHLm9HM70A2apIUesIgvBG8DLHs4dmFCYyl31eejzt2evNy/4akn9BsUUA3UIRgYeX2f4vofiI2aH+EA93Hgi9OR2/O4YZ5SU4rza6rGILhStiDKsfVTEKVCaZI13dJhnYMHMTg9iR6uEO+Vw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8718.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3cySzRPOUlwQ3hlSXZlc29OQm9VaW9wUVNkclJxMFpCeWczSDBMNFNzWEVL?=
 =?utf-8?B?REZwYkFiYlZmckE0bUZ2cUZyZngxelBnV0huRS9pdlB1SzB2bkVLMmk5STc5?=
 =?utf-8?B?VVBQQzYwUWdyYVlsTDlmTFdtTW44L3o3ZWw4RE9EZ21XcW0wWXhlYUxILzUz?=
 =?utf-8?B?Z0JZTUtDVnBnSXZMSCt0Q210ZHdpMXBLUDlTNDJOWHpvVGo4WHIxeExTZFZQ?=
 =?utf-8?B?OUVFWExWUkdxZEJJS2tHZWtRZDlnN3NHQmdxenNBdE1MSlhYUnpZQjRyMm1H?=
 =?utf-8?B?WUN0cG5iM05Ea3pncnV5SHlsSXpHN2t2NE05NHA2RXlXTmttc0RJS0hjOTQz?=
 =?utf-8?B?TFFBbXp6cklaaTdJcjAxNytUZEpZTkx5S3NGcy9mcDJtOVFUYzJXK1MwMFVq?=
 =?utf-8?B?VnUxVHMrSG1wM3UweGFQWjRqQUNFWWR5cjhDbVhKMTZ6bWpPQ24zQWM3QTJY?=
 =?utf-8?B?YXNmWDBBRHZJVzA2cjVKbmZZMmpDa2E5RVhCSVJzeUlqay9wR21HYUNhOFpH?=
 =?utf-8?B?WWVmcFRNZ0l2MWJPSm02M21xVVh4OG9rSEFIQ3VMTVdiZlBWNS9kWThYczJl?=
 =?utf-8?B?dHhYZkxmQUtNZzllVnp1ZU9WNUp5KysySmVMbmRIVGc2SW5jNkFGR1NuMW9O?=
 =?utf-8?B?S1NqZUhJUlRUdGFIMGQ5eDlBNXhKNzcyVjNBWmVTck5pQ2xKYjZXS1FXZlov?=
 =?utf-8?B?YTdsYVFqMzM5Q2FCbE1GSHpMQXp1QS82b1MzRGNwb0N0VkZUdlBoQnZrM0l2?=
 =?utf-8?B?SXhoRUlTamp2UndqeWE4K2QrdFBpYm9sQ2w4Y25mMytMS1EvWDJ0cDBhTkJS?=
 =?utf-8?B?ZGthR3pKV0NkcUxFbFJhYTgrR3AyWGlZQ0IrRzdmSWQ5TllYNUdIa2RLcW5D?=
 =?utf-8?B?ZkIxUm4vM2dsQ05sWCtxOFQ3anFrSUd2MWxWQllLemJjWFdGTXFLZjhyN2Uz?=
 =?utf-8?B?c05oR0J1Z2ZIdjZwcUZNbHJ0QjNZZnI4OWJ6dHYyY0RzUkFHZlJDKzg2cjlK?=
 =?utf-8?B?cnp2M045bUF5Mk5SY0dGZDQ0dFFMWC9YQ0R0WC9DN0NTQTJoZDhEOVUwU0Vp?=
 =?utf-8?B?MTNydTRXWlB3d2dOSWovTDV2Sm1wMHRjSkRvbjVRUHJjZGNVRENMS2xabE83?=
 =?utf-8?B?elQzUk8vZWVIMXc1S2dWMVZYbk93UGU1S0lTN0E1UU5QVWdBOTh5MkUrSndH?=
 =?utf-8?B?WHZ1bldxVGg0OGdqU09Md3YwOXdPYldlVHlUQ2dkSkpvNlpQT0pHK1l1S1VK?=
 =?utf-8?B?YTBxb2p4QWo1YWFKM282UDdVRmpPVUF6SVlBNXd4MWtPM2R1bzJNMU9VUkM2?=
 =?utf-8?B?alRkVjJycTEyZklVKzZwNlBVWDhzU2paVlVwOXlVV29nTUNpbnVEbW5VTFRi?=
 =?utf-8?B?Vmo4Y21pNzBlVHNFem1FSmRMWWRKRDdpTk5vdVpLZzBpa2x5MHoySmhOSGJF?=
 =?utf-8?B?aTVIQldmcE01WEpOWjFQMEEvN3JYVHYwTVZFZ002ZndXQ3hiRHVpczQvZ0Nh?=
 =?utf-8?B?QkM5QjhUK3BRcmtDOXRGVUFzK1oyaW1oRlZ6bUhDWENPN0R4YjRwYmh6b0xs?=
 =?utf-8?B?dWthTWpXKzU4Tzd0dmg2ZVFXbzgvSWlGdUpDM20zeklldDVPbTh1Q2h0V0NY?=
 =?utf-8?B?M291Y05Qb1B6cUVBYnYxQnFVVjJEYit5QUxwdysxSnVBNDZoRmdxeG1Fckcz?=
 =?utf-8?B?NnhQNVRwRXRva0ZOeGEyaWlnSG9uQ2FZRWRrMjluUGo1a2FoMlFRNm5UWFh5?=
 =?utf-8?B?MURDbHhuMEFteDJsb0x2STRSVUd6Q1BGVCsyMElQc1JUd3UyelpFSC94T1BX?=
 =?utf-8?B?R3lMeHNBRFNRemt1ajdKakRpK2lGejYzTVhlNmhCRTF6b1B2RlFQYjBpSWlY?=
 =?utf-8?B?RFE2UUxtZDBQd1pnRmtaeDJXdHM4MWpxNnNMTzhJeVY3UUlJemp5RktINGJz?=
 =?utf-8?B?T0twaXBBRk1yZis2RXNPSXF5OFdFOVZ4UU9CUnV5RXg1TEhvWlhMQktKakhD?=
 =?utf-8?B?U0h4K1lxZ1ZOU0N6ZnowUGo3ZEEzcTVFdURDQktCQXNnTlY4bnhMdWEwSDhy?=
 =?utf-8?B?bjFzV3dPWXBPaFBONWVPa2pWZnY0MmZlRkZEL3lRWDVpQWh4cDBEN2IzVWpo?=
 =?utf-8?B?UE1jdEt5bVFTakZLUDcrUGpYMVFvZUZxSWJRUVlEUEkxRTJMYUJBRjRwaTVm?=
 =?utf-8?B?L2tXaHNOYVJGQzhydzErY3ZjeDl6MDFLbjRLamg0dWVyK3creGIzZnJUQzd1?=
 =?utf-8?B?eExBOXFtdEt6dkdmZ0UrWkgxcXBndlZXWU1EeGpoZmVEODEwMnFQSXVrcVhz?=
 =?utf-8?B?N1V1Mmw1ejloME1GOWE0a2h0ZGh3WXBlOW5KOHRWeEVLOThjSDhGQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nnp02q5qKjOTNNZ7X7xvGZigGl2xUFB3iIy8X/4i6zg9Zzg83O3DLRIBvZ57nJULa+O1pYiMdlixbSbLRjWJ30Vy3RYlo+Q53C4GFa5M7b+4xayHj/0fyy8L9yZPh4sOybipSbCtQlooGnRFwm1FEyr43mX97EkZ8VCiPd+F6uSnCAwqqG2+YamFZUGfJGObrGyiVct/qWi1PivFXe/U68QMaWtRNxPSwEDgfxy1B2ozK/vsAT2h/FU1rqg7npXvdXnGXBlrzWGdMeT+4a3/FpaHy3GXnk2veNVERRwG3rYFrFjOSC4rnZ/ClOyE5Lj8qZXhyNl4mUKN62hBOWb6cw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 702c1216-6ff4-49f5-cf59-08def2fc020f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 14:15:31.3109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CvAGX3qqbvXrKVvdWAr+FEzlwQFe6m1Aszz2atCMBvmtLAvxRmLoH5KsHZi+tN+M0+tPJi/lLujFGki72mJPoEQKAJf7os1J15Iv5a0OYPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8523
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXVsZCwgTWF0dGhldyA8
bWF0dGhldy5hdWxkQGludGVsLmNvbT4NCj4gU2VudDogMjkgSnVseSAyMDI2IDIxOjM3DQo+IFRv
OiBVcGFkaHlheSwgVGVqYXMgPHRlamFzLnVwYWRoeWF5QGludGVsLmNvbT47IGludGVsLQ0KPiB4
ZUBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gQ2M6IGFydW5wcmF2aW4ucGFuZWVyc2VsdmFtQGFtZC5jb20NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCBWMyAyLzJdIGdwdS90ZXN0cy9ncHVfYnVkZHk6IEFkZCBLVW5pdCB0ZXN0IGZvcg0KPiBn
cHVfYnVkZHlfYWxsb2NhdGVkX2FkZHJfdG9fYmxvY2sNCj4gDQo+IE9uIDI5LzA3LzIwMjYgMTY6
MzgsIE1hdHRoZXcgQXVsZCB3cm90ZToNCj4gPiBPbiAyOC8wNy8yMDI2IDEzOjQ0LCBUZWphcyBV
cGFkaHlheSB3cm90ZToNCj4gPj4gQWRkIGEgbmV3IEtVbml0IHRlc3QgZ3B1X3Rlc3RfYnVkZHlf
YWRkcl90b19ibG9jaygpIHRoYXQgdmFsaWRhdGVzDQo+ID4+IHRoZQ0KPiA+PiBncHVfYnVkZHlf
YWxsb2NhdGVkX2FkZHJfdG9fYmxvY2soKSBoZWxwZXIgd2hpY2ggdHJhY2VzIGEgYWRkcmVzcw0K
PiA+PiBiYWNrIHRvIGl0cyBhbGxvY2F0ZWQgYnVkZHkgYmxvY2suDQo+ID4+DQo+ID4+IFRoZSB0
ZXN0IGNvdmVyczoNCj4gPj4gLSBFeGFjdCBhZGRyZXNzIG1hdGNoaW5nIHJldHVybnMgdGhlIGNv
cnJlY3QgYWxsb2NhdGVkIGJsb2NrDQo+ID4+IC0gQW4gdW5hbGxvY2F0ZWQgYWRkcmVzcyBpbnNp
ZGUgdGhlIG1hbmFnZXIgc2hvdWxkIHJldHVybiBOVUxMDQo+ID4+IC0gQW4gYWRkcmVzcyBvdXRz
aWRlIHRoZSBtYW5hZ2VyIHNob3VsZCByZXR1cm4gLUVOWElPDQo+ID4NCj4gPiBEbyB3ZSBhbGxv
dyBhbiB1bmFsaWduZWQgYWRkcj8gSXQgbG9va3MgbGlrZSB3ZSBkbywgYnV0IEkgd291bGQgdGhp
bmsNCj4gPiBiZXN0IHRvIHJlamVjdCBpZiBub3QgYXQgbGVhc3QgYWxpZ25lZCB0byBjaHVuayBz
aXplPw0KPiANCj4gT3IgaWYgdGhhdCBpcyBhIGxlZ2l0IHRoaW5nLCB0aGVuIG1heWJlIGFsc28g
aW5jbHVkZSBpdCBpbiB0aGUgdGVzdCBjb3ZlcmFnZS4gQW5kDQo+IGV2ZW4gaWYgcmVqZWN0ZWQs
IG1heWJlIGFsc28gY292ZXIgdGhhdCBpbiB0aGUgdGVzdC4NCg0KTm8gd2UgZXhwZWN0IGFsaWdu
ZWQgYWRkcmVzcy4gSSB3aWxsIHB1dCBhIGNoZWNrIHRvIHZhbGlkYXRlIGlmIGFkZHJlc3MgaXMg
YWxpZ25lZC4NCg0KVGVqYXMNCj4gDQo+ID4NCj4gPj4NCj4gPj4gdjMoU2FzaGlrbyk6DQo+ID4+
IC0gcmVtb3ZlIHVudXNlZCB0YXJnZXRfYWRkciB2YXJpYWJsZQ0KPiA+PiB2MihTYXNoaWtvKToN
Cj4gPj4gLSBEcm9wIHRoZSBtdXRleCBhbmQgbG9ja2RlcCBhbm5vdGF0aW9uOyBzdGFuZGFsb25l
IEtVbml0IHRlc3RzIGRvDQo+ID4+IMKgwqAgbm90IHJlZ2lzdGVyIGEgZHJpdmVyIGxvY2suDQo+
ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFRlamFzIFVwYWRoeWF5IDx0ZWphcy51cGFkaHlheUBp
bnRlbC5jb20+DQo+ID4+IC0tLQ0KPiA+PiDCoCBkcml2ZXJzL2dwdS90ZXN0cy9ncHVfYnVkZHlf
dGVzdC5jIHwgNDENCj4gPj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4+IMKg
IDEgZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS90ZXN0cy9ncHVfYnVkZHlfdGVzdC5jIGIvZHJpdmVycy9ncHUvdGVzdHMv
DQo+ID4+IGdwdV9idWRkeV90ZXN0LmMgaW5kZXggODk2OTg1NjNjNjFiLi4yMWM5MGU5NmFjMTMg
MTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvZ3B1L3Rlc3RzL2dwdV9idWRkeV90ZXN0LmMNCj4g
Pj4gKysrIGIvZHJpdmVycy9ncHUvdGVzdHMvZ3B1X2J1ZGR5X3Rlc3QuYw0KPiA+PiBAQCAtMTQy
Miw2ICsxNDIyLDQ2IEBAIHN0YXRpYyB2b2lkDQo+ID4+IGdwdV90ZXN0X2J1ZGR5X2FsbG9jX2V4
Y2VlZHNfbWF4X29yZGVyKHN0cnVjdCBrdW5pdCAqdGVzdCkNCj4gPj4gwqDCoMKgwqDCoCBncHVf
YnVkZHlfZmluaSgmbW0pOw0KPiA+PiDCoCB9DQo+ID4+ICtzdGF0aWMgdm9pZCBncHVfdGVzdF9i
dWRkeV9hZGRyX3RvX2Jsb2NrKHN0cnVjdCBrdW5pdCAqdGVzdCkgew0KPiA+PiArwqDCoMKgIHN0
cnVjdCBncHVfYnVkZHlfYmxvY2sgKmFsbG9jYXRlZF9ibG9jaywgKmZvdW5kX2Jsb2NrOw0KPiA+
PiArwqDCoMKgIExJU1RfSEVBRChhbGxvY2F0ZWRfbGlzdCk7DQo+ID4+ICvCoMKgwqAgY29uc3Qg
dTY0IHRlc3Rfc2l6ZSA9IFNaXzRNICsgU1pfMk07DQo+ID4+ICvCoMKgwqAgY29uc3QgdTY0IGFs
bG9jX3N0YXJ0ID0gU1pfNE07DQo+ID4+ICvCoMKgwqAgY29uc3QgdTY0IGFsbG9jX3NpemUgPSBT
Wl80SzsNCj4gPj4gK8KgwqDCoCBjb25zdCB1NjQgY2h1bmtfc2l6ZSA9IFNaXzRLOw0KPiA+PiAr
wqDCoMKgIHN0cnVjdCBncHVfYnVkZHkgbW07DQo+ID4+ICsNCj4gPj4gK8KgwqDCoCBLVU5JVF9B
U1NFUlRfRkFMU0VfTVNHKHRlc3QsIGdwdV9idWRkeV9pbml0KCZtbSwgdGVzdF9zaXplLA0KPiA+
PiBjaHVua19zaXplKSwNCj4gPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAiYnVkZHlfaW5pdCBmYWlsZWRcbiIpOw0KPiA+PiArDQo+ID4+ICvCoMKgwqAgS1VOSVRfQVNT
RVJUX0ZBTFNFX01TRyh0ZXN0LCBncHVfYnVkZHlfYWxsb2NfYmxvY2tzKCZtbSwNCj4gPj4gYWxs
b2Nfc3RhcnQsDQo+ID4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbGxvY19zdGFydCArIGFsbG9jX3NpemUsDQo+ID4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBhbGxvY19zaXplLCBjaHVua19zaXplLA0KPiA+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmFsbG9jYXRlZF9saXN0
LCAwKSwNCj4gPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiYnVkZHlf
YWxsb2MgZmFpbGVkXG4iKTsNCj4gPj4gKw0KPiA+PiArwqDCoMKgIGFsbG9jYXRlZF9ibG9jayA9
IGxpc3RfZmlyc3RfZW50cnkoJmFsbG9jYXRlZF9saXN0LCBzdHJ1Y3QNCj4gPj4gZ3B1X2J1ZGR5
X2Jsb2NrLCBsaW5rKTsNCj4gPj4gK8KgwqDCoCBLVU5JVF9FWFBFQ1RfRVEodGVzdCwgZ3B1X2J1
ZGR5X2Jsb2NrX29mZnNldChhbGxvY2F0ZWRfYmxvY2spLA0KPiA+PiBhbGxvY19zdGFydCk7DQo+
ID4+ICvCoMKgwqAgS1VOSVRfRVhQRUNUX0VRKHRlc3QsIGdwdV9idWRkeV9ibG9ja19zaXplKCZt
bSwNCj4gPj4gK2FsbG9jYXRlZF9ibG9jayksDQo+ID4+IGFsbG9jX3NpemUpOw0KPiA+PiArDQo+
ID4+ICvCoMKgwqAgZm91bmRfYmxvY2sgPSBncHVfYnVkZHlfYWxsb2NhdGVkX2FkZHJfdG9fYmxv
Y2soJm1tLA0KPiA+PiArYWxsb2Nfc3RhcnQpOw0KPiA+PiArwqDCoMKgIEtVTklUX0VYUEVDVF9Q
VFJfRVEodGVzdCwgZm91bmRfYmxvY2ssIGFsbG9jYXRlZF9ibG9jayk7DQo+ID4+ICsNCj4gPj4g
K8KgwqDCoCAvKiBBbiB1bmFsbG9jYXRlZCBhZGRyZXNzIGluc2lkZSB0aGUgbWFuYWdlciBzaG91
bGQgcmV0dXJuIE5VTEwuDQo+ID4+ICsqLw0KPiA+PiArwqDCoMKgIGZvdW5kX2Jsb2NrID0gZ3B1
X2J1ZGR5X2FsbG9jYXRlZF9hZGRyX3RvX2Jsb2NrKCZtbSwNCj4gPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbGxvY19zdGFydCAtIGNo
dW5rX3NpemUpOw0KPiA+PiArwqDCoMKgIEtVTklUX0VYUEVDVF9OVUxMKHRlc3QsIGZvdW5kX2Js
b2NrKTsNCj4gPj4gKw0KPiA+PiArwqDCoMKgIC8qIEFuIGFkZHJlc3Mgb3V0c2lkZSB0aGUgbWFu
YWdlciBzaG91bGQgcmV0dXJuIC1FTlhJTy4gKi8NCj4gPj4gK8KgwqDCoCBmb3VuZF9ibG9jayA9
IGdwdV9idWRkeV9hbGxvY2F0ZWRfYWRkcl90b19ibG9jaygmbW0sIHRlc3Rfc2l6ZSk7DQo+ID4+
ICvCoMKgwqAgS1VOSVRfRVhQRUNUX0VRKHRlc3QsIFBUUl9FUlIoZm91bmRfYmxvY2spLCAtRU5Y
SU8pOw0KPiA+PiArDQo+ID4+ICvCoMKgwqAgLyogMy4gU3RhbmRhcmQgaW5saW5lIGNsZWFudXAg
ZmxvdyAqLw0KPiA+PiArwqDCoMKgIGdwdV9idWRkeV9mcmVlX2xpc3QoJm1tLCAmYWxsb2NhdGVk
X2xpc3QsIDApOw0KPiA+PiArwqDCoMKgIGdwdV9idWRkeV9maW5pKCZtbSk7DQo+ID4+ICt9DQo+
ID4+ICsNCj4gPj4gwqAgc3RhdGljIGludCBncHVfYnVkZHlfc3VpdGVfaW5pdChzdHJ1Y3Qga3Vu
aXRfc3VpdGUgKnN1aXRlKQ0KPiA+PiDCoCB7DQo+ID4+IMKgwqDCoMKgwqAgd2hpbGUgKCFyYW5k
b21fc2VlZCkNCj4gPj4gQEAgLTE0NDYsNiArMTQ4Niw3IEBAIHN0YXRpYyBzdHJ1Y3Qga3VuaXRf
Y2FzZSBncHVfYnVkZHlfdGVzdHNbXSA9IHsNCj4gPj4gwqDCoMKgwqDCoCBLVU5JVF9DQVNFKGdw
dV90ZXN0X2J1ZGR5X2FsbG9jX2V4Y2VlZHNfbWF4X29yZGVyKSwNCj4gPj4gwqDCoMKgwqDCoCBL
VU5JVF9DQVNFKGdwdV90ZXN0X2J1ZGR5X29mZnNldF9hbGlnbmVkX2FsbG9jYXRpb24pLA0KPiA+
PiDCoMKgwqDCoMKgIEtVTklUX0NBU0UoZ3B1X3Rlc3RfYnVkZHlfc3VidHJlZV9vZmZzZXRfYWxp
Z25tZW50X3N0cmVzcyksDQo+ID4+ICvCoMKgwqAgS1VOSVRfQ0FTRShncHVfdGVzdF9idWRkeV9h
ZGRyX3RvX2Jsb2NrKSwNCj4gPj4gwqDCoMKgwqDCoCB7fQ0KPiA+PiDCoCB9Ow0KPiA+DQoNCg==
