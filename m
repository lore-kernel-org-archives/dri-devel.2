Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC5AC55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 09:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7352910F15C;
	Thu,  6 Aug 2026 09:46:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="E0ODpSNT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87B3710F15C;
 Thu,  6 Aug 2026 09:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786009596; x=1817545596;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EKIzh5iW04vm8d3qnEfK748DuEVZiDOLj9riTqjD/ME=;
 b=E0ODpSNTFwN+q10/OzGpwS/SDwPNWvbsLXStP49e1iUfgxMPcGrex2Oy
 IvWutLHw29ND30ILTqHEC0Z2DDP2CWv4X/AfVMtEHnduq66ufVYPHIx/3
 1DtXn8wwv7m5wV3juOFmJgOEdymoDx5IoMDy/IpDfcZrqUEZ9uQC9t4Ux
 lMTEStgqYHP892BsVkwKOrF1mSdxwELmTW3zTHh4R+ycSLNIvR8RqtLz8
 4P6QGjfkjTBe3garQstMYX0ujN/E6DgU1bMOsTiE/y0RXmSKN8RXs5GMN
 rixSvUmoZNqK/RPfdoCrBvBiffIMPb+iiIp+ueU2HbDbfympudgXXL+5I g==;
X-CSE-ConnectionGUID: dVNdTGc5Q4e/4O3anlvrHQ==
X-CSE-MsgGUID: 1Rb+BKjmR8Oq4M7RedVLRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="97194399"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="97194399"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 02:46:35 -0700
X-CSE-ConnectionGUID: s7k6TzfXSPy0RJXCUZYr+g==
X-CSE-MsgGUID: qS9hVrAmQHWrRaD3lDinDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="259440088"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 02:46:35 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 02:46:34 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 02:46:34 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 02:46:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfGfMJ23XJEcr/S5ug4lUjcAdlRiEdcICGeZSpSkzqeXcwtPhRUN9xEg40eHOVJOgh3aWh+ruGCItmq+AwXeM/pYNAXTMezdrr00liQk/igYNgugYUUG/VGMFToGLSyCwbfhI5np7U8hWtH5Ca5EhBaF2LQ8QCVx+EaIgoxak42QM63vL4ll5YvqP8QU5gHXVrM3YJaUzkJ90mhGQt3/JlPrZ5i4iIc4sRSYiRPr+G48nEt9r0s1KWFie7pHJpkoEh2prNOECvYsww/yz/ywxAXMdBlHs5lbc9o8woi9TDLsg7VjgEEpFHD7mDf2iKakHSYFvIcxBBK+N/vdSWRv0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKIzh5iW04vm8d3qnEfK748DuEVZiDOLj9riTqjD/ME=;
 b=upKjF15rKbxtM+6ekVb34smVxb4vuu6pFcSQdMRbcMOSw/4qasvEtFMDKhhyuGfqGLpNMnqP3+/93DZc9jb/Nw8H6VhVIA7VPST9wL5WzHSOTsE/SGOO0lXof6/5Qj0KdefXqFUwXg5y3NPIl24sSCEX8zw8+v02F1EtOZq+mnbFnOMc5myA25DDPn1hY3xbhqdF60DLXO8YeCdAwaybcs7deIy2PfVPksR98UyRbTHqlFlX4CSR6l4z4HCMlVXuHSVrQlHXZfF/sdhdRHruv1LU4PI5oAAP6yuoP3C4V8FJXVAV49fuVAGLOclOR/Lso1sliQJywrtyqOn80mtXNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB7256.namprd11.prod.outlook.com (2603:10b6:8:10c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 09:46:27 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 09:46:27 +0000
From: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>
To: "Auld, Matthew" <matthew.auld@intel.com>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
CC: "arunpravin.paneerselvam@amd.com" <arunpravin.paneerselvam@amd.com>
Subject: RE: [PATCH V4 2/2] gpu/tests/gpu_buddy: Add KUnit test for
 gpu_buddy_allocated_addr_to_block
Thread-Topic: [PATCH V4 2/2] gpu/tests/gpu_buddy: Add KUnit test for
 gpu_buddy_allocated_addr_to_block
Thread-Index: AQHdJWWVJbfFvFlOTEK0CZjk0jCMkLaQuUqAgAAD0XA=
Date: Thu, 6 Aug 2026 09:46:27 +0000
Message-ID: <DS0PR11MB87188855F06D221DCF900AD381D22@DS0PR11MB8718.namprd11.prod.outlook.com>
References: <20260806053624.3215216-4-tejas.upadhyay@intel.com>
 <20260806053624.3215216-6-tejas.upadhyay@intel.com>
 <5675a0ee-a5ee-480e-9a02-b71225c1d86d@intel.com>
In-Reply-To: <5675a0ee-a5ee-480e-9a02-b71225c1d86d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8718:EE_|DM4PR11MB7256:EE_
x-ms-office365-filtering-correlation-id: e01de19f-4576-4f61-de20-08def39f95f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: vqzuEQTsBYzM8D1yKX0W9ABLx2EL5U3iBfceLoxqgMmOax9Sh3pV5adr3MYwuDJy+8uL1yuf5YpNAP/YFF3KrdsIGk2NC99H7CDWGiKhGRQ86ORinQb+gdNZAZ0EoEpDLw3Crzqaxjr1nFCzU1iu+Sg0RfDzPf7u14WjwWM8mC0a9wZA5qZ5rBb/hzwSBDEU96QzzcFs+mBl7Tj0ZY0+KKo/A+grezsRX8TynSKGcG4QC8QAMpXHAbIf6h/2zhtHdnZ59GEz1999P1YUPd/qFrQRJafjxos5K4mEwN/KdLO42BdhO0I60yZ1I2Gvc4Qrda5iTNNwejetYEZCKrRH9qSS7lBSEBOilV7N3gs7owy3miN+/zMZRmOnUn5jb5n3DufvQD3oag+DRCgTa9JyqGx/kQmOHQ2AtibUzkk0XjaawVoJBejFXfngArOWDeQtaP1/PY0zDaP+P83xFANbL5Nn/2qP/Iv1O0tnL5lUEaq1eTUsP0S2g3zmOykl23wRnGUdjJmCIT5dWNICwMH38BWfIVKw+SDlTF8Oi9EN3s5U6LkqN6Po+5XtDY4eP+GMvavGxciDHWM/xaQSKHmcyaFMlMnVliZMtIleHmB+AYa8izDYzuewNaHjwqVbcQQzteVcPJ3oe/3WkqFlXBIgxIUAFLHCLx5+TpaFv49MX1Ga5unUufLa4nt0E9Ibd8df3BWM9ZerKSDPcaZLrM8gKpNpfSlbf8kHG3JW29KYWbU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8718.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wk51MzR2RU94L3Y2clVQSHNnY1BvaWRRMUdGZDlQYzdnWlZRbmExWE9lcjFI?=
 =?utf-8?B?TjdXQ3FMUVRpTi9pbW9CWUw0RVh6cFlFMFovUkRXekkzbEJ2TmxNZ0E1STR3?=
 =?utf-8?B?SloxaGNuVXV2WDRMR1lUTWNBV3hLOHFrSzlRbFV1bC9qeC81OGo0N0NERVRn?=
 =?utf-8?B?SGppRU0wTTd6K2xaQTVManQ1RnNwaEpCMkF1REZUYkwwY0FKWXFRbXRKVE91?=
 =?utf-8?B?YjB4NHB0UXRGNzQrQ09TUTd3STBHZDNCYURwZUVRUUVlUmN5aFQvTnNzbjNi?=
 =?utf-8?B?RHpTNkY0WURYT1daWFhyWURBUkJPOW5TNTZTN0VrWnNyWGtWc0tXTWFBTUN0?=
 =?utf-8?B?ckN0bFRhamtCTlByRkZJNFVseGdVNW5nSDV0U0VncmpTb1ZIc2ZYd0RrKytV?=
 =?utf-8?B?T09FdWRlVzAraDg2Y2NVbkxOSVJQZWp3dzBCL01xSDZkS0xKRjc4U25oVXUy?=
 =?utf-8?B?cTN1OTdrdHJjQ1k5T21jOWdWcGlJaXFNNmF3SEZxOTdzMm9HQzZIalkwV05E?=
 =?utf-8?B?Wmt1RG5XTnlVRzhhRStqRDUwdFBKdFRxVlB6NkUvaUtLRmlJOGJqOXNpemh3?=
 =?utf-8?B?S2cycFFrS0FOM093QStlNDlOZVlzODF3Rk15bFJTRXc1eStnckE5TTZFcFQr?=
 =?utf-8?B?TG8vNEhmTmJKUkpCN3VwOTQrdmhhVkIxeEwyS1R4ZHhXQ3hzSVZJRVo0cUdq?=
 =?utf-8?B?c0ZiZlQ0dmNZU3dWU29aTUxGN3ZYUnFwVWtjcDllVXRZQ1NNci9Ia1BxckN5?=
 =?utf-8?B?MU9peStuSkxKb2lFYjR6S1R1ZHYyZzN5TkV2WWl0L01TQTZ1dGVEbWRRMmts?=
 =?utf-8?B?WXd4YXdpOXVuS0RvL3Q4cmtBWjBDTm9KNjJTLy9uVklUWGZ3VVhLZ2VPVWhR?=
 =?utf-8?B?UER5Y2s2b2tUQ1Y2ak5pbG1td0ZxaWZkblBwSzhVcG16aEFmV01BRFhHZEgv?=
 =?utf-8?B?bG5UZHNNZjJyOFFoS1lvZVBDRHVZYy9XaDhlV2llRU9LRnZnQWhLUnRPYTV4?=
 =?utf-8?B?YmtnSk1PanRZZmFKRVh1d3ZkY0tGV2NsUC9NcWtBOXVSN2Y4cjJtSlI3R29n?=
 =?utf-8?B?am5KeWplRTUvc0J5RnlaVHloUnNPVEloSkZ1RTJUQ0tsZEl2YW15c3J6UG1t?=
 =?utf-8?B?Z0krTFdwN1ZmSFJQdTBDemRUdmIyWlllamZxUWV1dVVIeXdYbWo5OTFqSWdN?=
 =?utf-8?B?akh3SE12MjZyWU1ST1M2Tyt1WVF4b0lrckllS3FtL25xSEJsNWQxckZ6d0VC?=
 =?utf-8?B?TE9mQ1NnM2JWTC9zMmwrT0VVQTVpUUFaK3ZSd0xNSmR0dWZuTEJhQ3g4dnVX?=
 =?utf-8?B?YlhHWTVpV1VuNnFjZXc1NUhUcUpyUHA2SXlML1dkeHhhQ3lSMzI1Z25UNkdm?=
 =?utf-8?B?UDhwVHNlTy9YTmZ2VVBqa0pOTVp5cmZtUlNNN3JBUjlFUHZVanY3WXpJUWVs?=
 =?utf-8?B?RG0xcGZ3OGFXemdlRXZEbzBZUzczYjZaNHB4cDVUMWl1WklDUmFoZ3RGUWdM?=
 =?utf-8?B?Z3RtcGp1ODZBSjAyZ2RtYmhTelBmYk5Dc1M4R3d6bk5yWURSamh5SFdLeDhX?=
 =?utf-8?B?V0h2SGFsOEphQ2dyc0c4ejUxNmxVV0ZjYUJGL1RZVDgwRE1sZU9IOTBXdTRm?=
 =?utf-8?B?MXkrOThHT3lzWWllZGxkZXlXRDNMSHhyRTZDTHJodGUxUkhBQ2V6NDZ3aWpY?=
 =?utf-8?B?MWlQN0JhRTlvbnlFZkNaY3FsUkx3WWNFekxGWjF3bWZkUkZ3a2N2ZHpBckw4?=
 =?utf-8?B?OVFFVDNzK2JXNjJiNnN5NmZRNzljOTdrb3ltdmRVVzNqOW9URFM5SS90Q1R1?=
 =?utf-8?B?MzhFNTZXWldkSlFnTnY2MGoyOU9GeTBXVVBDa2pVdzJTc09CMkJoWEVRMUNz?=
 =?utf-8?B?aW9ia1lUcytnS20wVlVSTi9vZTJpcTRYMXBpMlJBd2V4YkJiR3lpN0RHQzZk?=
 =?utf-8?B?Y0ZqSTEzSDVSU3dzaTVVb0oyc3VpZ2Y3dkJiaHNvbzJ4d3dwb1JGOVEzYjBj?=
 =?utf-8?B?dEpEdmlNRUlHWW0wSG1wYXpKaERPQlY5ZUtHRnJXb2xSVS9iWG55MEt4Y1o5?=
 =?utf-8?B?NlBQUEtVMjRUM01UcFRWTjVsUWJOTUlNaXY1L25YVm85TTBKOUl4K0llRnRC?=
 =?utf-8?B?TEg1TjJyL1h0UktwOWVPQ0Fua0czZm5nQ3Bqc2lJMUJoM2diZGwrbkFuaDgr?=
 =?utf-8?B?d0R2cjFuWGJ2ak84ZW4xNERydWYxNzZlZnlqQTVTdUJzUmw4T29nTFVFR3Ey?=
 =?utf-8?B?SDIxcnA2Mmo2NHpKVGJrWmpJdjNOUjVZaWJJZkNhRisrT0MwNmtKZGh4SzZJ?=
 =?utf-8?B?UUZLdHpCelZDRnEwV2hERkNoOWNwandVYk95cmRJNjlQTWNGNG5Jdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: spD6hrqjw/5VTV9nPX3O2eEp1GBqm6bRQDRimlhcxbPhBNyrg7Qz9JT6makl+mi30yUm3EGP6+dsSMfq+qf5IYZyFl3M1pP+BaTRy81X/RHWnxVFY88aQMVuSODDiPdR0KE+c5a1S9LN6czcAN9gGy/vkH+GSL6LGpyTlLDOrbuFAEvKZxSRfOFJBmlvucV+v4ZQy19yae6y5pv6epS0ZLn1RjexrKljTd2HSb3WUM+1aOLUMQdFF4/H6UWEPf73daeYUVHWLo06KdXkFmPIlWKuaK0BNrxiYdpKKkFr3PgjauoGzb4K0RDx6bdbbMOubhdmD/zFXrefwjws5OLSIw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01de19f-4576-4f61-de20-08def39f95f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 09:46:27.4110 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UQurnY7xbUfyFN2SX6luWSVIiq01jiS8UhRB8RIOKj7OcxRMibCVY06TmHvTPHe96/mcXHXypojMMXCucujFbtVQ2J6pEygwbt3SgXQsvt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7256
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
bWF0dGhldy5hdWxkQGludGVsLmNvbT4NCj4gU2VudDogMDYgQXVndXN0IDIwMjYgMTQ6MzENCj4g
VG86IFVwYWRoeWF5LCBUZWphcyA8dGVqYXMudXBhZGh5YXlAaW50ZWwuY29tPjsgaW50ZWwtDQo+
IHhlQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KPiBDYzogYXJ1bnByYXZpbi5wYW5lZXJzZWx2YW1AYW1kLmNvbQ0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIFY0IDIvMl0gZ3B1L3Rlc3RzL2dwdV9idWRkeTogQWRkIEtVbml0IHRlc3QgZm9yDQo+
IGdwdV9idWRkeV9hbGxvY2F0ZWRfYWRkcl90b19ibG9jaw0KPiANCj4gT24gMDYvMDgvMjAyNiAw
NjozNiwgVGVqYXMgVXBhZGh5YXkgd3JvdGU6DQo+ID4gQWRkIGEgbmV3IEtVbml0IHRlc3QgZ3B1
X3Rlc3RfYnVkZHlfYWRkcl90b19ibG9jaygpIHRoYXQgdmFsaWRhdGVzIHRoZQ0KPiA+IGdwdV9i
dWRkeV9hbGxvY2F0ZWRfYWRkcl90b19ibG9jaygpIGhlbHBlciB3aGljaCB0cmFjZXMgYSBhZGRy
ZXNzIGJhY2sNCj4gPiB0byBpdHMgYWxsb2NhdGVkIGJ1ZGR5IGJsb2NrLg0KPiA+DQo+ID4gVGhl
IHRlc3QgY292ZXJzOg0KPiA+IC0gRXhhY3QgYWRkcmVzcyBtYXRjaGluZyByZXR1cm5zIHRoZSBj
b3JyZWN0IGFsbG9jYXRlZCBibG9jaw0KPiA+IC0gQW4gdW5hbGxvY2F0ZWQgYWRkcmVzcyBpbnNp
ZGUgdGhlIG1hbmFnZXIgc2hvdWxkIHJldHVybiBOVUxMDQo+ID4gLSBBbiBhZGRyZXNzIG91dHNp
ZGUgdGhlIG1hbmFnZXIgc2hvdWxkIHJldHVybiAtRU5YSU8NCj4gPg0KPiA+IHY0KE1hdHRBKToN
Cj4gPiAtIEFkZCB0ZXN0IGZvciB1bmFsaWduZWQgYWRkcmVzcw0KPiA+IHYzKFNhc2hpa28pOg0K
PiA+IC0gcmVtb3ZlIHVudXNlZCB0YXJnZXRfYWRkciB2YXJpYWJsZQ0KPiA+IHYyKFNhc2hpa28p
Og0KPiA+IC0gRHJvcCB0aGUgbXV0ZXggYW5kIGxvY2tkZXAgYW5ub3RhdGlvbjsgc3RhbmRhbG9u
ZSBLVW5pdCB0ZXN0cyBkbw0KPiA+ICAgIG5vdCByZWdpc3RlciBhIGRyaXZlciBsb2NrLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogVGVqYXMgVXBhZGh5YXkgPHRlamFzLnVwYWRoeWF5QGludGVs
LmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBNYXR0aGV3IEF1bGQgPG1hdHRoZXcuYXVsZEBpbnRl
bC5jb20+DQoNCkhpIE1hdHQsDQoNClRoYW5rcyBmb3IgcmV2aWV3LiBTaW5jZSBJIGRvbuKAmXQg
aGF2ZSBtZXJnZSByaWdodHMgb24gZHJtLXRpcCwgV291bGQgeW91IHBsZWFzZSBoZWxwIG1lcmdp
bmcgdGhpcyBzZXJpZXMuDQoNClRlamFzIA0KPiANCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1
L3Rlc3RzL2dwdV9idWRkeV90ZXN0LmMgfCA0NQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvdGVzdHMvZ3B1X2J1ZGR5X3Rlc3QuYw0KPiA+IGIvZHJp
dmVycy9ncHUvdGVzdHMvZ3B1X2J1ZGR5X3Rlc3QuYw0KPiA+IGluZGV4IDdkZjVjMmFlODNiYi4u
MDRlNDI1ZWI4YmRkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L3Rlc3RzL2dwdV9idWRk
eV90ZXN0LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS90ZXN0cy9ncHVfYnVkZHlfdGVzdC5jDQo+
ID4gQEAgLTEzODEsNiArMTM4MSw1MCBAQCBzdGF0aWMgdm9pZA0KPiBncHVfdGVzdF9idWRkeV9h
bGxvY19leGNlZWRzX21heF9vcmRlcihzdHJ1Y3Qga3VuaXQgKnRlc3QpDQo+ID4gICAJZ3B1X2J1
ZGR5X2ZpbmkoJm1tKTsNCj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBncHVfdGVzdF9i
dWRkeV9hZGRyX3RvX2Jsb2NrKHN0cnVjdCBrdW5pdCAqdGVzdCkgew0KPiA+ICsJc3RydWN0IGdw
dV9idWRkeV9ibG9jayAqYWxsb2NhdGVkX2Jsb2NrLCAqZm91bmRfYmxvY2s7DQo+ID4gKwlMSVNU
X0hFQUQoYWxsb2NhdGVkX2xpc3QpOw0KPiA+ICsJY29uc3QgdTY0IHRlc3Rfc2l6ZSA9IFNaXzRN
ICsgU1pfMk07DQo+ID4gKwljb25zdCB1NjQgYWxsb2Nfc3RhcnQgPSBTWl80TTsNCj4gPiArCWNv
bnN0IHU2NCBhbGxvY19zaXplID0gU1pfNEs7DQo+ID4gKwljb25zdCB1NjQgY2h1bmtfc2l6ZSA9
IFNaXzRLOw0KPiA+ICsJc3RydWN0IGdwdV9idWRkeSBtbTsNCj4gPiArDQo+ID4gKwlLVU5JVF9B
U1NFUlRfRkFMU0VfTVNHKHRlc3QsIGdwdV9idWRkeV9pbml0KCZtbSwgdGVzdF9zaXplLA0KPiBj
aHVua19zaXplKSwNCj4gPiArCQkJICAgICAgICJidWRkeV9pbml0IGZhaWxlZFxuIik7DQo+ID4g
Kw0KPiA+ICsJS1VOSVRfQVNTRVJUX0ZBTFNFX01TRyh0ZXN0LCBncHVfYnVkZHlfYWxsb2NfYmxv
Y2tzKCZtbSwNCj4gYWxsb2Nfc3RhcnQsDQo+ID4gKwkJCQkJCQkgICAgYWxsb2Nfc3RhcnQgKw0K
PiBhbGxvY19zaXplLA0KPiA+ICsJCQkJCQkJICAgIGFsbG9jX3NpemUsDQo+IGNodW5rX3NpemUs
DQo+ID4gKwkJCQkJCQkgICAgJmFsbG9jYXRlZF9saXN0LCAwKSwNCj4gPiArCQkJICAgICAgICJi
dWRkeV9hbGxvYyBmYWlsZWRcbiIpOw0KPiA+ICsNCj4gPiArCWFsbG9jYXRlZF9ibG9jayA9IGxp
c3RfZmlyc3RfZW50cnkoJmFsbG9jYXRlZF9saXN0LCBzdHJ1Y3QNCj4gZ3B1X2J1ZGR5X2Jsb2Nr
LCBsaW5rKTsNCj4gPiArCUtVTklUX0VYUEVDVF9FUSh0ZXN0LCBncHVfYnVkZHlfYmxvY2tfb2Zm
c2V0KGFsbG9jYXRlZF9ibG9jayksDQo+IGFsbG9jX3N0YXJ0KTsNCj4gPiArCUtVTklUX0VYUEVD
VF9FUSh0ZXN0LCBncHVfYnVkZHlfYmxvY2tfc2l6ZSgmbW0sDQo+IGFsbG9jYXRlZF9ibG9jayks
DQo+ID4gK2FsbG9jX3NpemUpOw0KPiA+ICsNCj4gPiArCWZvdW5kX2Jsb2NrID0gZ3B1X2J1ZGR5
X2FsbG9jYXRlZF9hZGRyX3RvX2Jsb2NrKCZtbSwNCj4gYWxsb2Nfc3RhcnQpOw0KPiA+ICsJS1VO
SVRfRVhQRUNUX1BUUl9FUSh0ZXN0LCBmb3VuZF9ibG9jaywgYWxsb2NhdGVkX2Jsb2NrKTsNCj4g
PiArDQo+ID4gKwkvKiBVbmFsaWduZWQgYWRkcmVzcyBpbnNpZGUgdGhlIGFsbG9jYXRlZCBibG9j
ayAoc2hvdWxkIHJlc29sdmUgdG8gdGhlDQo+IHNhbWUgYmxvY2spICovDQo+ID4gKwlmb3VuZF9i
bG9jayA9IGdwdV9idWRkeV9hbGxvY2F0ZWRfYWRkcl90b19ibG9jaygmbW0sIGFsbG9jX3N0YXJ0
DQo+ICsgMTYpOw0KPiA+ICsJS1VOSVRfRVhQRUNUX1BUUl9FUSh0ZXN0LCBmb3VuZF9ibG9jaywg
YWxsb2NhdGVkX2Jsb2NrKTsNCj4gPiArDQo+ID4gKwkvKiBBbiB1bmFsbG9jYXRlZCBhZGRyZXNz
IGluc2lkZSB0aGUgbWFuYWdlciBzaG91bGQgcmV0dXJuIE5VTEwuICovDQo+ID4gKwlmb3VuZF9i
bG9jayA9IGdwdV9idWRkeV9hbGxvY2F0ZWRfYWRkcl90b19ibG9jaygmbW0sDQo+ID4gKwkJCQkJ
CQlhbGxvY19zdGFydCAtDQo+IGNodW5rX3NpemUpOw0KPiA+ICsJS1VOSVRfRVhQRUNUX05VTEwo
dGVzdCwgZm91bmRfYmxvY2spOw0KPiA+ICsNCj4gPiArCS8qIEFuIGFkZHJlc3Mgb3V0c2lkZSB0
aGUgbWFuYWdlciBzaG91bGQgcmV0dXJuIC1FTlhJTy4gKi8NCj4gPiArCWZvdW5kX2Jsb2NrID0g
Z3B1X2J1ZGR5X2FsbG9jYXRlZF9hZGRyX3RvX2Jsb2NrKCZtbSwgdGVzdF9zaXplKTsNCj4gPiAr
CUtVTklUX0VYUEVDVF9FUSh0ZXN0LCBQVFJfRVJSKGZvdW5kX2Jsb2NrKSwgLUVOWElPKTsNCj4g
PiArDQo+ID4gKwkvKiAzLiBTdGFuZGFyZCBpbmxpbmUgY2xlYW51cCBmbG93ICovDQo+ID4gKwln
cHVfYnVkZHlfZnJlZV9saXN0KCZtbSwgJmFsbG9jYXRlZF9saXN0LCAwKTsNCj4gPiArCWdwdV9i
dWRkeV9maW5pKCZtbSk7DQo+ID4gK30NCj4gPiArDQo+ID4gICBzdGF0aWMgaW50IGdwdV9idWRk
eV9zdWl0ZV9pbml0KHN0cnVjdCBrdW5pdF9zdWl0ZSAqc3VpdGUpDQo+ID4gICB7DQo+ID4gICAJ
d2hpbGUgKCFyYW5kb21fc2VlZCkNCj4gPiBAQCAtMTQwNSw2ICsxNDQ5LDcgQEAgc3RhdGljIHN0
cnVjdCBrdW5pdF9jYXNlIGdwdV9idWRkeV90ZXN0c1tdID0gew0KPiA+ICAgCUtVTklUX0NBU0Uo
Z3B1X3Rlc3RfYnVkZHlfYWxsb2NfZXhjZWVkc19tYXhfb3JkZXIpLA0KPiA+ICAgCUtVTklUX0NB
U0UoZ3B1X3Rlc3RfYnVkZHlfb2Zmc2V0X2FsaWduZWRfYWxsb2NhdGlvbiksDQo+ID4gICAJS1VO
SVRfQ0FTRShncHVfdGVzdF9idWRkeV9zdWJ0cmVlX29mZnNldF9hbGlnbm1lbnRfc3RyZXNzKSwN
Cj4gPiArCUtVTklUX0NBU0UoZ3B1X3Rlc3RfYnVkZHlfYWRkcl90b19ibG9jayksDQo+ID4gICAJ
e30NCj4gPiAgIH07DQo+ID4NCg0K
