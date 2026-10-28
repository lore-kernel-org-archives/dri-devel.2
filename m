Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA99606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 05:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hqnn5uvH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 273F410E4B9;
	Wed, 28 Oct 2026 05:42:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CAB110E58F;
 Wed, 28 Oct 2026 05:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793166137; x=1824702137;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FTcHhuTIK6AeVBld2PWFrBD9AUD/06ONTdGyISva8bo=;
 b=hqnn5uvHklisyUicMLiv8FvfIM1+8mH/MBPT963A+kq0qIiJ/Li5K9nv
 Pv84W7+rF8fUPILlhGF/iZ3pJ3dgUxq8MtSqXoH2X4cD5jSnCZ5eRpekT
 0i6LVuhHnNzZN1eRp+CdRfRyKTyuLHS5YFyj1ToE/xtItXcYUnv0kPOYm
 jbZ3zuBzKzov+Z19fsRLcVE7k9yc51NTFxWNWeqpqzamIxTV7WH6aw2yF
 hAfcA615IvpK/glQZNhNwMJngm1ZDVOJwYgXvldOyvOMRq6G9uwSzG8AR
 1GKxt7gs1SJd4TyJ6HeJB6FMBtJONrXXOFRRW0GcVhR2F7eTO4rOTYYXT Q==;
X-CSE-ConnectionGUID: rUiQRMRURJ6FnyEDkmeeCw==
X-CSE-MsgGUID: jAu5sAwiQA2R0hE7xolUUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1891367"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1891367"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 22:42:09 -0700
X-CSE-ConnectionGUID: iWuKJCDsQKug0k+LAvcTBA==
X-CSE-MsgGUID: x++Jv3+vRO6IGj5f6JnHKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4789827"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 22:42:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 22:42:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 22:42:08 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 22:42:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zuy1z08pmw33mXFx5PvOoRtmzma10oFLJdfi/ucgmej8uv13Kt1A5GkJ8XQPOU1nZbpeOwPyVsTin12XhFvRFiNB+O5m/8GJmFbzWzRnwZU4BJcvxUQZKDHS1val8I3BkCg3cSnF9WWcXeoz0HsRdMbbd8+v1KjMqFkKcTsvUVOIG++Bcyl4TiOj/2JkxJUyLDZBtneLjm9GaCAV7ETRGwz4RmJu6YN90PHr31Hr3kLCfOyCcQwBcLNsz9ryeROeKElCaJyKXkyXK3N3v9+mwCyqiikGkvZkRSeVd0c+/DSd0g1S5X2+67N+Yh36IbttaGL9RkFo0Xi3mXzwLCoKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTcHhuTIK6AeVBld2PWFrBD9AUD/06ONTdGyISva8bo=;
 b=b0pBnlmTrnJCugFlNYVtd0XPZ4YncFJmYMikHZPTWMadV78pXU7+xwH9cc5bAs8VoFBCLRZ0y5u4c4bPC2fr8kHrhufnka9A8oXurh1GsPK4vjL4WJ0gAKIRJweLcKX1iF1ysBoBDwS1u1w5qWiVlVYfT3o0so94tN3l9J27iy4VoWfCUjYF1UnjpTRdQZjtkht+tgUHkl+dxb3dD0gU2Rc/xUif2O3QhVeZtYv6yuAA+gVqBkfZ+QcF5wBZfh2UiigBkynITe97IbLuCf7ynJEaXxjcZ6pSLREsvUABKTRn9e1twbSYftxj32KYlPFWZGovBdeZPVUR8+XHS2h5yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8049.namprd11.prod.outlook.com (2603:10b6:8:116::6) by
 IA3PR11MB824491.namprd11.prod.outlook.com (2603:10b6:208:626::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 05:42:06 +0000
Received: from DS0PR11MB8049.namprd11.prod.outlook.com
 ([fe80::603c:772d:6793:d4eb]) by DS0PR11MB8049.namprd11.prod.outlook.com
 ([fe80::603c:772d:6793:d4eb%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 05:42:06 +0000
From: "Manna, Animesh" <animesh.manna@intel.com>
To: "Nikula, Jani" <jani.nikula@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
CC: "Hogander, Jouni" <jouni.hogander@intel.com>, "Kandpal, Suraj"
 <suraj.kandpal@intel.com>
Subject: RE: [PATCH v7 01/20] drm/i915/alpm: Program zero-based LFPS half
 cycle duration
Thread-Topic: [PATCH v7 01/20] drm/i915/alpm: Program zero-based LFPS half
 cycle duration
Thread-Index: AQHdZQyIr5SzhEHMIUutGiTaAW5dVLcRhwmAgADsu7A=
Date: Wed, 28 Oct 2026 05:42:06 +0000
Message-ID: <DS0PR11MB804995C226E5E48FF0A587D3F96F2@DS0PR11MB8049.namprd11.prod.outlook.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
 <20261026054001.799894-2-animesh.manna@intel.com>
 <899b4a9b4406fe7bf1287ea8e6adba7ef60d31af@intel.com>
In-Reply-To: <899b4a9b4406fe7bf1287ea8e6adba7ef60d31af@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8049:EE_|IA3PR11MB824491:EE_
x-ms-office365-filtering-correlation-id: 6c01e17e-b10c-4b16-0a73-08df34b63397
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|23010399003|366016|4143699003|261021123027099003|56012099006|10067099003|261021121427099003|261009223027099003|261022075727099003|11063799006|22082099003|18002099003|3023799007|38070700021;
x-microsoft-antispam-message-info: Yfx5irPElsJXS0woMfeBH8V+VekuK+Yiz+kfWAmB338bS/4Cuwz8LSkEIFh2zTNuGUk3UPsQhUteriwUkfQGGdWeAbO97h/yaHrQ+mBAnok/UrXNvW43CzcY2IcFKG3oYwez/yqoRu07ZYO0/DrM7aueDZCxcGwYWYH/YxY9zvP2NBLVfqFXZa6j9qU2iFmBfvhAD4gfVGvNWjzkkkZjnOoDe+rOCtjVaX4yJTkwPHYQl7/H4MR92bhZPLnJNj8xQrucdkvkY578rzXW09ZJf7xooVpydWmv8RSUpFReg6mYEkZi0PvRjJQUFCT7+wUiQQxzImEtnINNTjy22nwrFkbt8BW4Ct8Vha0hB3uxyaIH65eBq6qr7yMIQ006PdjMw9s8aOO9UNpDVBT2gDOw5d8GwDmABgq8wEhPrJkpvrYqTld0mL9uIQCdph7Nu7d43UOrZhjkII6Mc/eOgZA4zAsRrf9uWvqOzOPFMGyiNu2+0RhoXJT43T5KhWTvUpPZJCJ1iqpHTSadUQEwoPktvsJLQCnaJxpBZUHuCL+FAimXnlX0OZ+QnHBjd9bSj3rqs8yAEaesgv4HCtWECzSwt/ulsxkS+di0XuligL+3+gwrNg9N8yU1S0WZ0jWj+fA/2p5wTsmB/UQrSEq3ufdP1+1NNFdZq5L2+Mb8QI0eDD4lUjekoGMdNUG64Dd6igUJ2x/138mrx0gt3iIUJVfbr2iD8Y8yfIjlb0svpCSD5tI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8049.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(23010399003)(366016)(4143699003)(261021123027099003)(56012099006)(10067099003)(261021121427099003)(261009223027099003)(261022075727099003)(11063799006)(22082099003)(18002099003)(3023799007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkUvdlEvRHhwMUdCL1c1Yi9FNGNmRnNmUGlSVUtSaXFDQ1ErVHg0WGFoSHls?=
 =?utf-8?B?UzcxRWM1a1RDeWV0Qm1VbFZENFZjYjNZaklsZ1lYTmM5VC8zZ2ZNd1N1MklE?=
 =?utf-8?B?ZTJaVzVPUXBQbzhQS2RkMTEwK1NVTXpLeWhqaVZEdTV1TVlKbWxTalhoZFlS?=
 =?utf-8?B?ZEQxM1BiUWlpKzlhYk5mNmhabFg4dWpkb2ZIeUlHK0phTTI5L2xmaUQ3cUxX?=
 =?utf-8?B?VW9MUkRORStKWWd6dEhMWVh1WlhzRDVrTng1Um01cHZxZlhrZGJVbkFudmFm?=
 =?utf-8?B?Z2NNZ2Zsa2RhRUhaYmFWd296RW40Y0Yra05McjdFRkJqdW51Y1VsYXRhSWZx?=
 =?utf-8?B?Slk2L1VLZEJrZFhkR2wvaWlIMklKK1ZEZ29XdW4wRjY5QXdXajdKRWN4eldh?=
 =?utf-8?B?RjQvbExsT1hMODc0L3JpTFI3MDk5Zno0dkNwVU9uTitzQ3hSTlN1V09BYysr?=
 =?utf-8?B?S3B6S21sVTRLenFyKys3emRsZDB2WXBHRjZ1SnhKRzUvR3JhQ0JsellDWnJu?=
 =?utf-8?B?K2FENFRLNEw1TzIvNWJyT3JHY3ZTRWgrMm9ZaUFhOXJBVElQUlR5N1hYUTQz?=
 =?utf-8?B?WlArSnpvM1FPS0FNQUZyaWVhSmpKUGEzeGpPVytKRHJackxaZDdhSVFQQTNq?=
 =?utf-8?B?Qk43eGhSeXhGUDcxQmROakFUVHlIdTl2RlI2N3lhcnhSa2xiNHZvNUl2aFdo?=
 =?utf-8?B?bXhzM2RiVlN0bmhEbTlGZUFwZlVHL1FSOWVyaC8zYkZOU1dSYzF3Y3VzK25U?=
 =?utf-8?B?LzhXYWRWY2gzZTQ0MDZUdk54VTJWcmg2WGJyZlVickdCeXZaK1IraHF1WUJK?=
 =?utf-8?B?eDVVTm1BRzM4NmZZLyt6TlQ0T29PRzJvKzU2Q0V2MWVXVFJJMzhrRk5nQUZz?=
 =?utf-8?B?b20xU0lYVVh1Y0IyU1RhYXZKWHF6ckpxazZwYWRsb0x1eVpKY093M2tFdFdp?=
 =?utf-8?B?WUp1UGM4c0NGSEw4OTcxandkbnUvbXFkbmJYZ0VDSkJWVjB1L09HS203RjJv?=
 =?utf-8?B?aXNMckE5bytJR0pzL0pWb2pBeTU2YzdESFV0VUdmQWl5bkNoM1lwdWdrKzdy?=
 =?utf-8?B?S3NpN0xidzdGZmNORmo4RXNQeGUvMFoyaTB1bFJTS0NBRGYwSnlsL2xFbVFx?=
 =?utf-8?B?d20vNlhMY2xteDFoNGhwaUg2ZGlRYmtsWE40VGRyRjFVZWhQL3kyR3JuSVk0?=
 =?utf-8?B?emtLR1krNFk1dlh0WFoxRVAzMlVOczI0RkR2b2w5WUtzbE4zeDYrc1hzVnE0?=
 =?utf-8?B?SDQ5WE4waFgxcDdKV2IycEY0RzMxdVArYVVVY3BRQytWekVRejZhcmxBMnJ5?=
 =?utf-8?B?N3RBdU91SE9Zb2dmVmZ6OE1YLzFqVXdwM1IxWk9mdU9GTEpxV1FjemNHeVFC?=
 =?utf-8?B?b0VQeHgrMnFBMzZDeFozRVlLZFplSWZidkJ0anZNNGp1TE1oeTNsUkszN1da?=
 =?utf-8?B?Zm5Oa21Dd3Z1bFhPYU43b1I1dFdtNzJhRklYUVgyMWpqMG5QUmRNNGpHT3hk?=
 =?utf-8?B?RTgrbU0rakpZTzlxU2RhcDBaV0kwNy92QnMxU0gvbElVUXhEWENKaWxvdTJW?=
 =?utf-8?B?NjloSDEwblltWmtJcXVuSXN6ME1VaExwSHh3clhXN0IvRWJ6SEIwOFg5S1U3?=
 =?utf-8?B?YTRsZmdZaHJVaUVXUVBlLy9uNFF3ZllxckZaNzJleVFLamgraWVPaEcwWUxt?=
 =?utf-8?B?R1hJQWQvcktMVXhsZEhQVHpEUjJWSlhCSXJ5TFdsTUVUakJwSlA3dkdadzVh?=
 =?utf-8?B?a1BpU25mQjQ3QUQvWjVSbE9jTHZ0bEFEamtGUDhFdG52eHRtaGFXUHZvYWNF?=
 =?utf-8?B?WFh5aE92N0NKc0plbkkyQkg1WVFPcmQ4dHQ1OThqVFdkRllxWXdEckI5cFhV?=
 =?utf-8?B?QlpPeUY1dkx6M1h4amoxSHZ0elEyVzhja2FOYnozdGxqd2lZc3k2d1EyY1R6?=
 =?utf-8?B?VElHYjhLMjYvQStJQ3hsRDNyc29nVkdKMWJXN1hTNzBudmgwcE9rQ1RMTlpy?=
 =?utf-8?B?dDJkRzc0Tmsyb0tKTmhZSG85MlRiVnFEam43eFBJWFgvSElVY0tLcVJTeW9H?=
 =?utf-8?B?K1ZyUjlRbDREb1ZVTTM5Rnd6NEdRSXNNTzFxWDN2VVJtZlVCYWgySjRnMEJT?=
 =?utf-8?B?VzJxZmt3T1hGYnp0WEVaRTRoMXcxaTk2Mk9sSnJIYVVHc3N3VU5EZFlyMlN0?=
 =?utf-8?B?dCt5TUVyQWU1aXJBaEc1Yi9NL2xWQWlPU1VSb0RsY08vbmJwYXhRWjJPT3lZ?=
 =?utf-8?B?U0hRY29xZDlkbnV6KzB4RGwranBEeERTM1ZqYmRwSkRCZHl1c05IdEk0QlFQ?=
 =?utf-8?B?QklMdXNsMHpBVjgxaVRCQTVCQm9uQUhINVRLVFlzMFR3RWZocXYzWEV5alRZ?=
 =?utf-8?Q?0k2VtYqR7PblsyyQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KZ2XF78oZmBFP4ls7W7ke/9nMQEdUdX7qUjpUSaQdC3Sztv5OBCDDPcTfndp8U63FQUICMffK9w7UDvHuRP5n4xT2Wo8+nIRU7EwqkddEyPJYx479WDZHxnxKvLdXOuUYx1NosBBZRxDkGBmLRx0psUE9bftskIAzpVdXXGgOzsjwfA+M/axh8SIT9hunP5+6c2liy5qzsSc+a5HS2c2nm3wzohntKTDWtB4jkNJ72d7PXEV4V9I3YDLC9QX/OIhLmfV34BbmcK/P3gfMrdXQGaLNwnMYOG3Bc47FLNLP3UFg3MyKrSGn4nOy5B0yulG7kbCOZQVPB7XYXAFnz/5Yw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8049.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c01e17e-b10c-4b16-0a73-08df34b63397
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 05:42:06.2881 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: css1Qw3MRh+nersWoiOFi106umGHkaRHYWPz5g4x2fC+3yhbWBJPQd3m+tpFp5RLKtsbbA/+nY4gBAWCwClmHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB824491
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmlrdWxhLCBKYW5pIDxq
YW5pLm5pa3VsYUBpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjcsIDIwMjYg
OTowNCBQTQ0KPiBUbzogTWFubmEsIEFuaW1lc2ggPGFuaW1lc2gubWFubmFAaW50ZWwuY29tPjsg
aW50ZWwtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGludGVsLXhlQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZzsgZHJpLQ0KPiBkZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IEhv
Z2FuZGVyLCBKb3VuaSA8am91bmkuaG9nYW5kZXJAaW50ZWwuY29tPjsgS2FuZHBhbCwgU3VyYWoN
Cj4gPHN1cmFqLmthbmRwYWxAaW50ZWwuY29tPjsgTWFubmEsIEFuaW1lc2ggPGFuaW1lc2gubWFu
bmFAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY3IDAxLzIwXSBkcm0vaTkxNS9h
bHBtOiBQcm9ncmFtIHplcm8tYmFzZWQgTEZQUyBoYWxmDQo+IGN5Y2xlIGR1cmF0aW9uDQo+IA0K
PiBPbiBNb24sIDI2IE9jdCAyMDI2LCBBbmltZXNoIE1hbm5hIDxhbmltZXNoLm1hbm5hQGludGVs
LmNvbT4gd3JvdGU6DQo+ID4gVGhlIExGUFMgSGFsZiBDeWNsZSBEdXJhdGlvbiBmaWVsZCwgYXMg
d2VsbCBhcyB0aGUgRmlyc3QgYW5kIExhc3QgTEZQUw0KPiA+IEhhbGYgQ3ljbGUgRHVyYXRpb24g
ZmllbGRzLCBpbiBQT1JUX0FMUE1fTEZQU19DVEwgYXJlIHplcm8tYmFzZWQ6IHBlcg0KPiA+IEJz
cGVjIHRoZSB2YWx1ZSBwcm9ncmFtbWVkIG11c3QgYmUgTl9TeW1ib2wgLSAxLiBUaGUgbnVtYmVy
IG9mDQo+IHN5bWJvbHMNCj4gPiB3YXMgcHJvZ3JhbW1lZCBkaXJlY3RseSwgbWFraW5nIGVhY2gg
aGFsZiBjeWNsZSBvbmUgc3ltYm9sIGNsb2NrIHRvbw0KPiA+IGxvbmcuDQo+ID4NCj4gPiBTdWJ0
cmFjdCBvbmUgaW4gdGhlIFBPUlRfQUxQTV9MRlBTX0NUTF9MRlBTX0hBTEZfQ1lDTEVfRFVSQVRJ
T04sDQo+ID4gUE9SVF9BTFBNX0xGUFNfQ1RMX0ZJUlNUX0xGUFNfSEFMRl9DWUNMRV9EVVJBVElP
TiBhbmQNCj4gPiBQT1JUX0FMUE1fTEZQU19DVExfTEFTVF9MRlBTX0hBTEZfQ1lDTEVfRFVSQVRJ
T04gZmllbGQgbWFjcm9zIHNvDQo+IHRoZQ0KPiA+IHByb2dyYW1tZWQgdmFsdWUgbWF0Y2hlcyB0
aGUgemVyby1iYXNlZCBmaWVsZCBlbmNvZGluZy4NCj4gPg0KPiA+IFNpbmNlIHRoZSBmaWVsZHMg
bm93IGVuY29kZSAxIHRvIDMyIHN5bWJvbHMsIHVwZGF0ZSB0aGUgYm91bmRzIGNoZWNrDQo+ID4g
aW4gX2xubF9jb21wdXRlX2F1eF9sZXNzX2FscG1fcGFyYW1zKCkgdG8gYWNjZXB0IGEgaGFsZiBj
eWNsZSBvZiAzMg0KPiA+IHN5bWJvbHMgYW5kIHJlamVjdCAwLCB3aGljaCBjYW5ub3QgYmUgZW5j
b2RlZC4NCj4gPg0KPiA+IHYyOiBBZGp1c3QgaGFsZiBjeWNsZSBib3VuZHMgY2hlY2sgZm9yIHpl
cm8tYmFzZWQgZW5jb2RpbmcuIFtzYXNoaWtvXQ0KPiA+DQo+ID4gQnNwZWM6IDcxNjMyDQo+ID4g
Q2M6IEpvdW5pIEjDtmdhbmRlciA8am91bmkuaG9nYW5kZXJAaW50ZWwuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEFuaW1lc2ggTWFubmEgPGFuaW1lc2gubWFubmFAaW50ZWwuY29tPg0KPiA+IFJl
dmlld2VkLWJ5OiBKb3VuaSBIw7ZnYW5kZXIgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMgICAg
IHwgIDMgKystDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfcHNyX3Jl
Z3MuaCB8IDEyICsrKysrKysrKy0tLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1
L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+ID4gaW5kZXggZjU0YjI5ZTE5M2VlLi44NTQyYmQ5Yzk2
NjYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9h
bHBtLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0u
Yw0KPiA+IEBAIC0xMzQsNyArMTM0LDggQEAgX2xubF9jb21wdXRlX2F1eF9sZXNzX2FscG1fcGFy
YW1zKHN0cnVjdA0KPiBpbnRlbF9kcA0KPiA+ICppbnRlbF9kcCwNCj4gPg0KPiA+ICAJaWYgKGF1
eF9sZXNzX3dha2VfbGluZXMgPiBBTFBNX0NUTF9BVVhfTEVTU19XQUtFX1RJTUVfTUFTSw0KPiB8
fA0KPiA+ICAJICAgIHNpbGVuY2VfcGVyaW9kID4gUE9SVF9BTFBNX0NUTF9TSUxFTkNFX1BFUklP
RF9NQVNLIHx8DQo+ID4gLQkgICAgbGZwc19oYWxmX2N5Y2xlID4NCj4gUE9SVF9BTFBNX0xGUFNf
Q1RMX0xBU1RfTEZQU19IQUxGX0NZQ0xFX0RVUkFUSU9OX01BU0spDQo+ID4gKwkgICAgbGZwc19o
YWxmX2N5Y2xlIDwgMSB8fA0KPiA+ICsJICAgIGxmcHNfaGFsZl9jeWNsZSA+DQo+ID4gK1BPUlRf
QUxQTV9MRlBTX0NUTF9MQVNUX0xGUFNfSEFMRl9DWUNMRV9EVVJBVElPTl9NQVNLICsgMSkNCj4g
PiAgCQlyZXR1cm4gZmFsc2U7DQo+ID4NCj4gPiAgCWlmIChkaXNwbGF5LT5wYXJhbXMucHNyX3Nh
ZmVzdF9wYXJhbXMpDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3Bs
YXkvaW50ZWxfcHNyX3JlZ3MuaA0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9p
bnRlbF9wc3JfcmVncy5oDQo+ID4gaW5kZXggYTU3YmMxMTEyOTBkLi43OGEwNTM4N2VhYjUgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9wc3JfcmVn
cy5oDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9wc3JfcmVn
cy5oDQo+ID4gQEAgLTMzNSwxMSArMzM1LDE3IEBADQo+ID4gICNkZWZpbmUgIFBPUlRfQUxQTV9M
RlBTX0NUTF9MRlBTX0NZQ0xFX0NPVU5UX01BU0sNCj4gCVJFR19HRU5NQVNLKDI3LCAyNCkNCj4g
PiAgI2RlZmluZSAgUE9SVF9BTFBNX0xGUFNfQ1RMX0xGUFNfQ1lDTEVfQ09VTlRfTUlOCQk3DQo+
ID4gICNkZWZpbmUgIFBPUlRfQUxQTV9MRlBTX0NUTF9MRlBTX0NZQ0xFX0NPVU5UKHZhbCkNCj4g
CVJFR19GSUVMRF9QUkVQKFBPUlRfQUxQTV9MRlBTX0NUTF9MRlBTX0NZQ0xFX0NPVU5UX01BU0ss
DQo+ICh2YWwpIC0gUE9SVF9BTFBNX0xGUFNfQ1RMX0xGUFNfQ1lDTEVfQ09VTlRfTUlOKQ0KPiA+
ICsvKg0KPiA+ICsgKiBUaGUgTEZQUyBoYWxmIGN5Y2xlIGR1cmF0aW9uIGZpZWxkcyAoaW5jbHVk
aW5nIHRoZSBmaXJzdCBhbmQgbGFzdA0KPiA+ICtoYWxmDQo+ID4gKyAqIGN5Y2xlKSBhcmUgemVy
by1iYXNlZCwgaS5lLiB0aGUgdmFsdWUgcHJvZ3JhbW1lZCBpcyBOX1N5bWJvbCAtIDEuDQo+ID4g
KyAqDQo+ID4gKyAqIEJzcGVjOiA3MTYzMg0KPiA+ICsgKi8NCj4gDQo+IFBsZWFzZSBsZXQncyBu
b3Qgbm9ybWFsaXplIGFkZGluZyBic3BlYyByZWZlcmVuY2VzIHRvIGNvZGUgY29tbWVudHMuDQoN
ClN1cmUsIHdpbGwgZHJvcCBpbiBuZXh0IHZlcnNpb24uDQoNClJlZ2FyZHMsDQpBbmltZXNoDQoN
Cj4gDQo+ID4gICNkZWZpbmUgIFBPUlRfQUxQTV9MRlBTX0NUTF9MRlBTX0hBTEZfQ1lDTEVfRFVS
QVRJT05fTUFTSw0KPiAJUkVHX0dFTk1BU0soMjAsIDE2KQ0KPiA+IC0jZGVmaW5lICBQT1JUX0FM
UE1fTEZQU19DVExfTEZQU19IQUxGX0NZQ0xFX0RVUkFUSU9OKHZhbCkNCj4gCVJFR19GSUVMRF9Q
UkVQKFBPUlRfQUxQTV9MRlBTX0NUTF9MRlBTX0hBTEZfQ1lDTEVfRFVSQVRJTw0KPiBOX01BU0ss
IHZhbCkNCj4gPiArI2RlZmluZSAgUE9SVF9BTFBNX0xGUFNfQ1RMX0xGUFNfSEFMRl9DWUNMRV9E
VVJBVElPTih2YWwpDQo+IAlSRUdfRklFTERfUFJFUChQT1JUX0FMUE1fTEZQU19DVExfTEZQU19I
QUxGX0NZQ0xFX0RVUkFUSU8NCj4gTl9NQVNLLCAodmFsKSAtIDEpDQo+ID4gICNkZWZpbmUNCj4g
UE9SVF9BTFBNX0xGUFNfQ1RMX0ZJUlNUX0xGUFNfSEFMRl9DWUNMRV9EVVJBVElPTl9NQVNLDQo+
IAlSRUdfR0VOTUFTSygxMiwgOCkNCj4gPiAtI2RlZmluZSAgUE9SVF9BTFBNX0xGUFNfQ1RMX0ZJ
UlNUX0xGUFNfSEFMRl9DWUNMRV9EVVJBVElPTih2YWwpDQo+IAlSRUdfRklFTERfUFJFUChQT1JU
X0FMUE1fTEZQU19DVExfRklSU1RfTEZQU19IQUxGX0NZQ0xFX0QNCj4gVVJBVElPTl9NQVNLLCB2
YWwpDQo+ID4gKyNkZWZpbmUgIFBPUlRfQUxQTV9MRlBTX0NUTF9GSVJTVF9MRlBTX0hBTEZfQ1lD
TEVfRFVSQVRJT04odmFsKQ0KPiAJUkVHX0ZJRUxEX1BSRVAoUE9SVF9BTFBNX0xGUFNfQ1RMX0ZJ
UlNUX0xGUFNfSEFMRl9DWUNMRV9EDQo+IFVSQVRJT05fTUFTSywgKHZhbCkgLSAxKQ0KPiA+ICAj
ZGVmaW5lICBQT1JUX0FMUE1fTEZQU19DVExfTEFTVF9MRlBTX0hBTEZfQ1lDTEVfRFVSQVRJT05f
TUFTSw0KPiAJUkVHX0dFTk1BU0soNCwgMCkNCj4gPiAtI2RlZmluZSAgUE9SVF9BTFBNX0xGUFNf
Q1RMX0xBU1RfTEZQU19IQUxGX0NZQ0xFX0RVUkFUSU9OKHZhbCkNCj4gCVJFR19GSUVMRF9QUkVQ
KFBPUlRfQUxQTV9MRlBTX0NUTF9MQVNUX0xGUFNfSEFMRl9DWUNMRV9EVQ0KPiBSQVRJT05fTUFT
SywgdmFsKQ0KPiA+ICsjZGVmaW5lICBQT1JUX0FMUE1fTEZQU19DVExfTEFTVF9MRlBTX0hBTEZf
Q1lDTEVfRFVSQVRJT04odmFsKQ0KPiAJUkVHX0ZJRUxEX1BSRVAoUE9SVF9BTFBNX0xGUFNfQ1RM
X0xBU1RfTEZQU19IQUxGX0NZQ0xFX0RVDQo+IFJBVElPTl9NQVNLLCAodmFsKSAtIDEpDQo+ID4N
Cj4gPiAgI2VuZGlmIC8qIF9fSU5URUxfUFNSX1JFR1NfSF9fICovDQo+IA0KPiAtLQ0KPiBKYW5p
IE5pa3VsYSwgSW50ZWwNCg==
