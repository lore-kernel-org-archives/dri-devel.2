Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A464BC61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:46:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB80810E4EA;
	Tue,  1 Sep 2026 07:46:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VOp4CF/5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90EBE10E3B9;
 Tue,  1 Sep 2026 07:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788248785; x=1819784785;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=XQ03EJChayW0mWd3D8G0lcpIYkFYcKh2LlIfZs4nRH0=;
 b=VOp4CF/5k4dD7lsVsbG/Of0jjl45q3ZafOarx8Shx2hNxjnpfycExSga
 I+A4tSOuyjZreKKudZ2oK0xFi5QKkvhKGL+2uY8Dim43fhBfu5vWrARH4
 vrHcTbfPt5FDkCP8foWHjLTBB7S20W8Mto5KdKdUT3rT5T6FXbW1mx44v
 KVFc/wlgHyMcGK8dA13bL4NrZ2aXbLDksvYxcIqXFkgQ3+pGX5OGQSxSZ
 pbNBplt1YhCHBjSRPnGx4VBbnp9PL+4HdvsUUo/zJnPrk+ABhLL33YhKD
 GvEXYGhoUNf8ucLR/oTRkTw2qZZ0D3ehBziYCEXTX0bv0nbOzGlDroZgF g==;
X-CSE-ConnectionGUID: mCTHrq8nSWu9/uLrPLVvxw==
X-CSE-MsgGUID: oTvqs8S4SVGyG8KZ+rSJYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="99268737"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="99268737"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 00:46:24 -0700
X-CSE-ConnectionGUID: CDuosXkJS3GzICbG0Q9AYg==
X-CSE-MsgGUID: u8UWlk7hRTSO7QWbLgVO2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="267235204"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 00:46:24 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 00:46:23 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 00:46:23 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 00:46:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMldjRc15uQgG6qFMhOwU5fCiM+sHviq0wUWUtnIPHieyjRW4getRcE8in1Z/TcrwhRIG5UJKvOdExW023VuhPPXV7PfIavYinu0caS3cFr0FX8zyjU6ZSHV+TCU9aCcoOWIlo87AOrg6KtQ8OHARRXF2iH7mLaJZLxlNXHcXrvWLDRUqJYuwxZx7fkWiyA8Myc6657EtjwYPcsSYBgOZrPOCjrI5Ucou0uw1YJGB6Oga9d+v7p64y0LAuKR1+lQAt3nYPFKKAkWe0eVFLhgmhBUFabhJ2vztEpgE/7Uc2QGjbXdvOYnr12H/IT0uR9A9wKNeZimET6ljEkDYeUSPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQ03EJChayW0mWd3D8G0lcpIYkFYcKh2LlIfZs4nRH0=;
 b=pZc3Vr7rhpABw6wZFIsY2HRSJ67gG+WHIcnOKs/L5pkiYqcs2tXdpoRfP4EOdLglxF//vmf66e+ZFqcvgeFO9yiJGa52NHWngnJA/cFi/Uffszi/ZI3B3zGrz150gwe78KVwCw0CKikucFmtYYRrqkVn+rbY2ZkvLNy3QRugR3kt6tYNxS6BgAOsYYWEOoMVvsSvDJ2a9m4BwmBI9c8ntS8xR0DOZ9O+MVjxKZo8hI/sPzsyhnFk/SjPP6qG5H40JUsoxF7XGT2CzQhxWPm+4zNYiXL3NcHBAq9Y2yvo7p8V1v+xFrghScf5Boh6Bd6I8ucHLqkOhsLJGUtiYu5dPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6360.namprd11.prod.outlook.com (2603:10b6:8:bd::12) by
 SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Tue, 1 Sep 2026 07:46:03 +0000
Received: from DM4PR11MB6360.namprd11.prod.outlook.com
 ([fe80::22d9:ae03:5db1:680]) by DM4PR11MB6360.namprd11.prod.outlook.com
 ([fe80::22d9:ae03:5db1:680%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 07:46:03 +0000
From: "Shankar, Uma" <uma.shankar@intel.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [v6 6/9] drm/i915/color: Add support for 1D LUT in SDR planes
Thread-Topic: [v6 6/9] drm/i915/color: Add support for 1D LUT in SDR planes
Thread-Index: AQHdJBCGi8jwRvuO10Sjj/hqyyXOq7a4T2pwgAAEM2CAAS3MAIAAAhHQ
Date: Tue, 1 Sep 2026 07:46:03 +0000
Message-ID: <DM4PR11MB6360156E650DA4C0810B2360F4A82@DM4PR11MB6360.namprd11.prod.outlook.com>
References: <20260804123107.2256124-1-chaitanya.kumar.borah@intel.com>
 <20260804123107.2256124-7-chaitanya.kumar.borah@intel.com>
 <DM4PR11MB63608596E790F45C24DD18C9F4A92@DM4PR11MB6360.namprd11.prod.outlook.com>
 <DM4PR11MB6360FEE47A37F9AB2941BCF8F4A92@DM4PR11MB6360.namprd11.prod.outlook.com>
 <a27618eb-b5a8-4100-bf79-5b35fbfaf2de@intel.com>
In-Reply-To: <a27618eb-b5a8-4100-bf79-5b35fbfaf2de@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6360:EE_|SA0PR11MB4752:EE_
x-ms-office365-filtering-correlation-id: 058d38a0-462d-40d4-e4ab-08df07fd1308
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|6133799003|18002099003|11063799006|4143699003|56012099006|22082099003|38070700021;
x-microsoft-antispam-message-info: DGLIrXPvLf6kqoShVZ99smEfH0FGOoy/zn6RBK41xc4OpcFNtBk+23hyuKtwIiTLaJ4azFjJqNc06zYH5yaV5sIadjKy2QFc1YlhbH7X7Ylwil4DraLb3H3s5xeyiVNaecogkkFkmAg7ojb31Nqdys2m2nxUAHJ/xIfuSMbcbv2gm8fcQIScMU5aHrl2zlaM9ltLX9CX+uEKEZMYgG916yMeZ7OGri6c1PCcm03FaQMh56S2M+zETyfVnm1YKXdl/fzWcMExRXPLK5OsPVXTtKOsl25OvNON9izopCCf0mrsK2K97zXSU+KaU4eo+Z2e9qvVRRI1+bD0On+EfhixyPDRzryOCkCgFx8hM/MUemTL/QQsKfk9jVLLP5H3PYQttizR+XFSC8apmNY2z2D3Ly0sjngQUj6FgMRK2vucLON5s2kInYDPGSTG/KY9nlLRsAe01jKZ+7iNtVSsPJ+ojyYPWtSXUdcWVzV+l4er4fzsfxcxNin1RsNfVhNdIhE68DZWDSgpUBgdIMQZN054cVwLFyzLF/pp8R0XXYx01iCJHwQaOq171IfPLcNa9bOdC4RqDHZSl9VuoZ4RubB00wtpj6cpQp+ntVwltvse0zHoa5Sr9FQh98RpZOWqJymhJI4/E/IGKtLFTygiiJ9ZQ7TB1V7/7Fh3ZgUxjqKNsI/0T0L2V7qKUL2GRw7sngdg3MlbuS6UIU86c2o2PZWNqcz+Ts6u497dVRiOHeS+pUI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6360.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(6133799003)(18002099003)(11063799006)(4143699003)(56012099006)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDVGeURlTEdNY1JURHNKKzNjd25FdkxqbGhETVdTbm1HVmQ4aUt6T3YwdVBP?=
 =?utf-8?B?dmVVbGxYRS9QRUVXQlUvMWJ1VzFFcS9ROGpQblV1by9KY0dXKzdid2xjWHhK?=
 =?utf-8?B?ZVdybXJZSVlQOS9uT2g1dXdRZk1ObThFb29zaHVqenBRVzFpdzdSY1NMYkRz?=
 =?utf-8?B?NldQamJBQUJ6OGZ3YlVNZTcxSnlHcDY1RWFSSmx0eDFSN0JXRjNyL0x3Rldj?=
 =?utf-8?B?L3RxSDljY2lxbEZieVBGVzBUNUdWWEUrUHlMYmI2UGEwamNyTkdTM3VYOXEx?=
 =?utf-8?B?Nm1WTm9KRlpKK1RHdTNKVWt2ODFZdTV0WXF0NThaYkphakozYXdLcmpvbzdL?=
 =?utf-8?B?eHNjY005blNKMGpkcjZZcmNja01WK0VNcUd5NXFNcGFMU00zL21kTmQ1aVN0?=
 =?utf-8?B?SWhZMHg1Qm1QTDNGdnQzMDBmUEk5SGludmFmRVpoalNCNC94bzRsb253Y3lU?=
 =?utf-8?B?U05qUjVkTFlPN1Rzak56MU9SMHRGZERBeVlxVDI3ZHJ4L01nanVqVFdOQzAx?=
 =?utf-8?B?bXYvSmZHQzNRTldUVllaRnBPZmlCWTlhZml5dGJyTWtHNHlYc1JKeW10ZFZ0?=
 =?utf-8?B?dCtyK3NSRXB6NmpYMEhrRUJOR0kxOWhHK2hSVDFZbDc1Um9HYUlBZHRCbGNa?=
 =?utf-8?B?QW93MzBKWVVvSGUxZldRc0V3Vm9VUS9xT0FxZ2xBRkRZU0tUVHRZZFBZN0Z3?=
 =?utf-8?B?NzBZeEpRY3ZDeStJS3E5K20ySDV0MjdCVmJ0SjNNcjNHZ0J0MnZ5YWRXaUlS?=
 =?utf-8?B?K0FnNTllam9VZHVxSDJiVXhITk5BallVRnZJaGlOZ2hCbUlDMW11c0ZFcmRh?=
 =?utf-8?B?c29zS1Nqb2JiMGlNWFdhdDRQM0wwVWNhTUQweDVhakdzNTNaMGN4dmlkSFJj?=
 =?utf-8?B?T2pGQnRyUWZPWEFub2RvY21CcEcvckh0aS9rdXROVHRxaVJzMXhBWkhuZHdS?=
 =?utf-8?B?emg1TGtqSlZxS2R3MzJyWkpnQk81VWZIU1ZHNDdycFdMbDE1RGJsM3ZDNTFK?=
 =?utf-8?B?MTBNVGQzVGxqa1Fvb0lEMERwTjIrMldXN3doa1hYNVBjZU80bitzVE5WL2dJ?=
 =?utf-8?B?TXdrRGh2UE9BdDBoUVU5aWtYS1RMZXVVUi9xNWlXSWIwL0JJanJmcE44TW9S?=
 =?utf-8?B?bHdxanhrTUR0Y3VsVWtpRG5rWUhsRXRhNmJXSERzRkVmNjJGNFR3MG12QXl1?=
 =?utf-8?B?aVp6a0hmSFJoaGZNRVg0N1dDNERFMkJTT2FRd0ZPV2IzQnRvUlIrSEtMMWxX?=
 =?utf-8?B?V25wMklXNFBBNUF0RVF6ZHlJLytJK01sUUdjcEFudW1rb2xmaDBnWkZ4VExp?=
 =?utf-8?B?OHlxTk56d1gwVVdOL0htVlNnbEgvUmh3KzQ5Skl3ZWtJOG43K29ZS1A1MUhr?=
 =?utf-8?B?bEt3dzNaMTV3VFAweEFuRm96VFMzakpyRGY5NDNZN1oxUjJWUzBnaGNrQXJW?=
 =?utf-8?B?YndjTFd4cGU4NHUzbWxEZ2VoUXlSRG1FVHdrdEpEaGErTEt3bHlSWTZuT0pP?=
 =?utf-8?B?RUFRbS9kZkhhVCtZaWxTbVRnaGowVFZHbmZqcUQwOWRtNFdNUkVaVHhyQjkv?=
 =?utf-8?B?T01oSVhzY3hiOUpuRm83TTkzaEtvcUdOYm1oWXh3WlUxYjJORCtod3lRZWlD?=
 =?utf-8?B?WGk2UDdDTTc2S3dURUNmekpONGtLR2EvVlJKT2JrWFJJd1JlTk5IMmkrd0dw?=
 =?utf-8?B?SXljYW1JK2tDbWcyYU01UzhoejFoTS9IT0FWeGtnemhUY3YzSjNBZEw5TzBW?=
 =?utf-8?B?dXpqamFXZ3BvYWJXZUNsekZRK3ZoNitKTkNmRlU4L2xRbis5bFRkQWdmdHhl?=
 =?utf-8?B?M1ArL0xHWUxGZlV6bk1TTEtLM0JpOFpHSEljeWMwbTJjditHYnhuUnorK05U?=
 =?utf-8?B?bzB0VXV5MDJKQnNoczlOOEhzamZOVm9TQVVBMkNkeXlIZWJSVW9weVBncnB6?=
 =?utf-8?B?b0VGSitrUVN0OVhsa2pzN0FBV0hpSkduZG1oTHd4djl4akg4bU8vaitFQWRz?=
 =?utf-8?B?Qy9uWnI4T2w4NGpUTGlENnF2dHlKemxNZWxzWHU1WWxWdVd2UmdsNDZLb2VV?=
 =?utf-8?B?ZkJhcmpXWFNHTFF3d3laNko4VStWQmlPaWE2c3JhN0FMTUdjV24zeVphejND?=
 =?utf-8?B?cWc3VDliWVo0Z2pFL29YRFJUWFR4UGxvN20rWSt4ajlvRFdxVTR5OUlrM2w2?=
 =?utf-8?B?UmY4Zm5tZVdqdFA0MFg5dzNBQW9CN3JIWTl4TEhuemFmMGNFTmZHMTBYRXdi?=
 =?utf-8?B?VU50M0ZlZTA2RjQyNXZIdTdKdVk5bVg2WVhMak5ENDZZNG50NzR2eHVjM2xq?=
 =?utf-8?B?YnVabDZGTFhEbmhmdElscHlFck0wOVcvVXF1N0xFaWRiRjFpbXJnUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VZA/PLkN7Fv7BmAhBTr5D5t9bCCHvAnR7Yy4J3EYoaw4zW+nTmLWX5F/itEUlEpHKibQzOcNE7woQXqIknNNvphra1QP6DxrM1MIAqTICra0mEkn6nioS4iwt8KXp0nOS1U5lLhDugr4mrTa/o2uCiDmepOdmD5OkEQ/LZL1GgBTBF3nPoh/1XI3qF3013MEui20OtjlF4dR++nx3tnvRJDfG4lM7Sswha6JAkVLim8uAlhf1nCSmkK17/gP20DLDa6aclin3a2Dfc/5TvI8o8UxcrhfcP7+Xy/Yqn3vTPry8OQYmd5nd0qMqKuUvsSjvJuAOPtlbrnfbF35KzsqOg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6360.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058d38a0-462d-40d4-e4ab-08df07fd1308
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 07:46:03.7100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fccP7ryZ3RSC28+o1MXQXsl+t/Pdu03Qe+C22dREpV+uQS2ONjCaiy3Lve5KpYfFDc2dFg3ASTSJhQjg9jcD8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4752
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yYWgsIENoYWl0YW55
YSBLdW1hciA8Y2hhaXRhbnlhLmt1bWFyLmJvcmFoQGludGVsLmNvbT4NCj4gU2VudDogVHVlc2Rh
eSwgU2VwdGVtYmVyIDEsIDIwMjYgMTowOCBQTQ0KPiBUbzogU2hhbmthciwgVW1hIDx1bWEuc2hh
bmthckBpbnRlbC5jb20+OyBpbnRlbC14ZUBsaXN0cy5mcmVlZGVza3RvcC5vcmc7DQo+IGludGVs
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCj4gU3ViamVjdDogUmU6IFt2NiA2LzldIGRybS9pOTE1L2NvbG9yOiBBZGQgc3VwcG9ydCBm
b3IgMUQgTFVUIGluIFNEUiBwbGFuZXMNCj4gDQo+IA0KPiANCj4gT24gOC8zMS8yMDI2IDc6MDgg
UE0sIFNoYW5rYXIsIFVtYSB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4+IEZyb206IFNoYW5rYXIsIFVtYQ0KPiA+PiBTZW50OiBNb25kYXksIEF1
Z3VzdCAzMSwgMjAyNiA2OjU0IFBNDQo+ID4+IFRvOiBCb3JhaCwgQ2hhaXRhbnlhIEt1bWFyIDxj
aGFpdGFueWEua3VtYXIuYm9yYWhAaW50ZWwuY29tPjsgaW50ZWwtDQo+ID4+IHhlQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZzsgaW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgZHJpLQ0KPiA+
PiBkZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4gU3ViamVjdDogUkU6IFt2NiA2Lzld
IGRybS9pOTE1L2NvbG9yOiBBZGQgc3VwcG9ydCBmb3IgMUQgTFVUIGluIFNEUg0KPiA+PiBwbGFu
ZXMNCj4gPj4NCj4gPj4NCj4gPj4NCj4gPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4+PiBGcm9tOiBCb3JhaCwgQ2hhaXRhbnlhIEt1bWFyIDxjaGFpdGFueWEua3VtYXIuYm9yYWhA
aW50ZWwuY29tPg0KPiA+Pj4gU2VudDogVHVlc2RheSwgQXVndXN0IDQsIDIwMjYgNjowMSBQTQ0K
PiA+Pj4gVG86IGludGVsLXhlQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgaW50ZWwtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZzsNCj4gPj4+IGRyaS0gZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+ID4+PiBDYzogQm9yYWgsIENoYWl0YW55YSBLdW1hciA8Y2hhaXRhbnlhLmt1bWFyLmJvcmFo
QGludGVsLmNvbT47DQo+ID4+PiBTaGFua2FyLCBVbWEgPHVtYS5zaGFua2FyQGludGVsLmNvbT4N
Cj4gPj4+IFN1YmplY3Q6IFt2NiA2LzldIGRybS9pOTE1L2NvbG9yOiBBZGQgc3VwcG9ydCBmb3Ig
MUQgTFVUIGluIFNEUg0KPiA+Pj4gcGxhbmVzDQo+ID4+Pg0KPiA+Pj4gRXh0ZW5kIHRoZSBTRFIg
cGxhbmUgY29sb3IgcGlwZWxpbmUgdG8gcG9zdC1DU0MgMUQgTFVUIGJsb2NrLg0KPiA+Pj4NCj4g
Pj4+IHYyOg0KPiA+Pj4gICAtIEluIHByZXBhcmF0aW9uIG9mIGEgc2ltcGxlIHBpcGVsaW5lDQo+
ID4+PiAJW1lVViBGdWxsL0xpbWl0ZWQgLT4gUkdCXSAtPiBbMUQgTFVUXQ0KPiA+Pj4gICAgIERy
b3AgcHJlLUNTQyBMVVQgZnJvbSB0aGUgcGlwZWxpbmUgYXMgaXQgaGFzIG5vIHVzZSBpbiBhIFlV
ViAtPiBSR0INCj4gPj4+ICAgICBwaXBlbGluZS4gVGhpcyBtYWtlcyB0aGUgcGlwZWxpbmUgc2lt
cGxlIHNpbmNlIHRoZSBibG9jayBsaWVzIGJldHdlZW4NCj4gPj4+ICAgICB0aGUgWVVWIHJhbmdl
IGNvcnJlY3QgYmxvY2sgYW5kIEZpeGVkIGZ1bmN0aW9uIENTQy4gSXQgY2FuIGJlIGFkZGVkIGJh
Y2sNCj4gPj4+ICAgICB3aGVuIFtSR0I3MDkgLT4gUkdCMjAyMF0gY2FwYWJpbGl0eSBpcyBhZGRl
ZC4gVGhlbiBpdCBjYW4gYmUgdXNlZCBmb3INCj4gPj4+ICAgICBsaW5lYXJpemF0aW9uLg0KPiA+
Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IENoYWl0YW55YSBLdW1hciBCb3JhaA0KPiA+Pj4gPGNo
YWl0YW55YS5rdW1hci5ib3JhaEBpbnRlbC5jb20+DQo+ID4+PiBSZXZpZXdlZC1ieTogVW1hIFNo
YW5rYXIgPHVtYS5zaGFua2FyQGludGVsLmNvbT4gI3YxDQo+ID4+PiAtLS0NCj4gPj4+ICAgZHJp
dmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9jb2xvcl9waXBlbGluZS5jIHwgMSArDQo+
ID4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+Pj4NCj4gPj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2NvbG9yX3BpcGVsaW5l
LmMNCj4gPj4+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9jb2xvcl9waXBl
bGluZS5jDQo+ID4+PiBpbmRleCBlZmQ0Mzc1YzQzMzEuLjUzZTU1Y2UwYTVhMyAxMDA2NDQNCj4g
Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfY29sb3JfcGlwZWxp
bmUuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9jb2xv
cl9waXBlbGluZS5jDQo+ID4+PiBAQCAtNDUsNiArNDUsNyBAQCBzdGF0aWMgY29uc3QgZW51bSBp
bnRlbF9jb2xvcl9ibG9jaw0KPiA+Pj4gaGRyX3BsYW5lX3BpcGVsaW5lW10gPSB7DQo+ID4+Pg0K
PiA+Pj4gICBzdGF0aWMgY29uc3QgZW51bSBpbnRlbF9jb2xvcl9ibG9jayBzZHJfcGxhbmVfeXV2
X3BpcGVsaW5lW10gPSB7DQo+ID4+PiAgIAlJTlRFTF9QTEFORV9DQl9DU0NfRkYsDQo+ID4+PiAr
CUlOVEVMX1BMQU5FX0NCX1BPU1RfQ1NDX0xVVCwNCj4gPj4NCj4gPj4gV2l0aCB0aGlzIHdlIHdp
bGwgZXhwb3NlIHN1cHBvcnQgZm9yIHBvc3QgY3NjIGx1dCBidXQgY29ycmVzcG9uZGluZw0KPiA+
PiBoYW5kbGluZyBpbiBkcml2ZXIgaXMgYWRkZWQgbGF0ZXIgaW4gdGhlIHNlcmllcy4gV291bGQg
YmUgZ29vZCB0byBtb3ZlIHRoaXMgYWZ0ZXINCj4gcGF0Y2ggOC4NCj4gPg0KPiA+IFBsZWFzZSBp
Z25vcmUgdGhlIGVhcmxpZXIgY29tbWVudCwgZW5hYmxpbmcgb2YgU0RSIHBsYW5lcyBpcyBkb25l
IGluDQo+ID4gbGFzdCBwYXRjaCBzbyB0aGlzIHNob3VsZCBiZSBmaW5lLiBXZSBhcmUgZ29vZC4N
Cj4gDQo+IFRoYW5rIHlvdSwgVW1hLCBmb3IgbG9va2luZyBpbnRvIHRoZSBwYXRjaC4gQ2FuIEkg
Y29uc2lkZXIgeW91ciBSQiBmb3INCj4gdjIgb2YgdGhlIHBhdGNoLg0KDQpZZXMsIGl0IGxvb2tz
IGdvb2QgdG8gbWUuDQoNClJlZ2FyZHMsDQpVbWEgU2hhbmthcg0KDQo+ID09DQo+IENoYWl0YW55
YQ0KPiANCj4gPg0KPiA+Pj4gICB9Ow0KPiA+Pj4NCj4gPj4+ICAgc3RhdGljIGNvbnN0IHU2NCBp
bnRlbF9wbGFuZV9zdXBwb3J0ZWRfY3NjX2ZmID0NCj4gPj4+IC0tDQo+ID4+PiAyLjUwLjENCj4g
Pg0KDQo=
