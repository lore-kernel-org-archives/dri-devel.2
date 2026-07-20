Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3C2C4452A
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4920410E86B;
	Mon, 20 Jul 2026 10:31:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SeSPw6vm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B36A10E865;
 Mon, 20 Jul 2026 10:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784543511; x=1816079511;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=XUVyt2KTy07F268QY8sS3AEM8c2kZRKCts1lBCCDMQQ=;
 b=SeSPw6vmf3O5kp4Nyi04A9meqRUBwuaho15fS9LqmNw0XJQQ/o+JStga
 OEhcDQNjf+364hb+coY0ba94AqB60HBxZwByYCipEod+jcNUDrJMZbdZb
 IQ9Tu5NRB2TlDYngNkXoMgEw9l5Wu0rNozQyIbYsPLAyP7RYfctGaP2x7
 Wh0iknZLcTDG4ruNrtb+TlpRDUzjkP8UFsNuvwM+pllJLzpeUxsXR10hl
 2GUha+IPnZJ+ZpY+R3w73tWl7zUI4ZpQOurZ7G94XecwuAt41EuonoPyc
 VxbNAjYLUtOm/+wKQlMeZJSDbFleLU2BW+e2cU2OHdZyBEWb7dKxIYL9n g==;
X-CSE-ConnectionGUID: 5GKdd1lHQ8KNhNdWNGihCw==
X-CSE-MsgGUID: Of7wrqDhQ+qeXl1z9/GxaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="87659991"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="87659991"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 03:31:51 -0700
X-CSE-ConnectionGUID: xpjupZgTTuqfouzEvomIIg==
X-CSE-MsgGUID: lLx5jcwSTc+ubdUA9Kzq0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="253475069"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 03:31:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 03:31:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 03:31:50 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.25) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 03:31:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IejWOzdVpRbqQOLVgMzv2IUU5bvT2DrOGq6Wa6QjfnUv3XifwwLIA99A1+cmWyiEP1qE9i9i+NjAqnhL60du2vttRDfek8aYVcnYMZ58hHRI8uBFH/zjTfcZKSij0N6nyzkrIGsTyifkdZF6yHeFfMBtjF10rEwI2wbhqScmAeJl/UIWdM7Qd5gxPJ2sDlXCmmfKXDlhcUziWh3HuiLGHddhN0E0xRbLFbauBEDKUfeY0+20pj8hGjVhpa9mXo2eOIcr6vC3TazC49r2z4Qvpa7aP7ke5U7oKR6JsoVvFAq3JEVpKtgu5wIActi/SAO6rtceLE4TWwZ8EP5Spe63Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUVyt2KTy07F268QY8sS3AEM8c2kZRKCts1lBCCDMQQ=;
 b=tENCkGTfvrAC04v5RY8J2sG8qen4Sj29YaxrS1K0tO+/jt56xt3VvQ+rr60Vro7nVJ1ISJcIWmnuX1U1JNs0eQyOuDzO5gBZS3d0yYASNp2u9/hDMftpt8oS1LqlD//hoB/fJs1o8jNpiAEWA7DGEPVKD/e9srC/KyhP3r5qxUyCCG1+k4urQ20e2UlvotvXUxNuTCutztJj1eiNhlMsCgZGQOqLaQ3+0/cct2Z8gY4kTnZ+ROzcVI/FXTPTUL7jxcCvab41YmkH47nv67mFiuYqzr+ocQQBgupKPrbn8pVG9WQlc4SWrOJLd6y1cz0TVpSc/z81erRJoHg34zDZ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 SA3PR11MB7977.namprd11.prod.outlook.com (2603:10b6:806:2f3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 10:31:46 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 10:31:46 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "jani.nikula@linux.intel.com"
 <jani.nikula@linux.intel.com>, "thierrycantindemers@gmail.com"
 <thierrycantindemers@gmail.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Kahola, 
 Mika" <mika.kahola@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/i915/psr: Disable eDP Panel Replay on XPS 16 DA16260
 (LG 0x07C5)
Thread-Topic: [PATCH] drm/i915/psr: Disable eDP Panel Replay on XPS 16 DA16260
 (LG 0x07C5)
Thread-Index: AQHdDt/U0C2mDiSXf0mS5Ha11LnNbbZ2SCyA
Date: Mon, 20 Jul 2026 10:31:46 +0000
Message-ID: <a036e63561333e3f36896ac0919feab509553bdc.camel@intel.com>
References: <20260708134252.11854-1-thierrycantindemers@gmail.com>
In-Reply-To: <20260708134252.11854-1-thierrycantindemers@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|SA3PR11MB7977:EE_
x-ms-office365-filtering-correlation-id: ee1d177f-4c4f-4368-e6ee-08dee64a1988
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|23010399003|376014|38070700021|22082099003|18002099003|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: R9FqAJR0b5YFA/Aj1UQsb2Zrz7CWBg3vILx0QJ4MjEBb0Kfb6SrN9Wy3+Hz72Lq0C5SHbwBQ6wlRZIeN5c9HKpydnrecbc4hL/MDby1gm/OGJ5zglPOFgUt8VRhHHawPTBQv1JJldUtbUoGP4GyYQd5EypqIFWCAsRLR3DQ3em2eNUNlRuZDYIzr9+nKDsyI85ZgBOb0yitXPnp2XcUT0QydlTEITbafBnN8fUh2a5ORF5NK3OyvwJFMWBd0Oktfc6LlxqdhUoAUSbmRZG2OrT5KFwIax/JjnwvCXygV8OCLpb9mmt5uirtIG5P6nUUHbTLBw+oCZXLkI1nZ8dkUMmmoiSzN0V69mWc//Re9vc2Ja7rc0Gzk9tyMNcsquuonKb7zuot7O8err7pVFUtgEAYmRyQyW4xQE8nT0xjvcMBvRwNWKg7+myd4gih64/D4rPpMQDq06Rerkz8/ciEL2nMD0Qpx5ICSeOEe45FXDkgLI+5ZRfQgD+sKSJ9BbYC7qmpd2pX7JHryyTOJ/KhhjoV8nu8JTHINJmKrrLV+tyRSxQL/v7IISShSrs+5lDXgv47JX4tav7MyXs++343+mJRi4YN4euL78pgKt0QEY8P5ywzpaIyEDaO1v4fvNPMPEddzDy4O3K58S1RVU2Cz0vHQnhwil7Voy6Q5QoDnTM8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(376014)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkJBZ0xBRlZ6T0E0clk1ZUk0Mk9jUjhTL2U1Rm01SllUajFSTVB1RmJLRHVN?=
 =?utf-8?B?Q1ZjRVU5VUtaZEhJaHJuaVk4R0QwLyswUnluSTFldDRESVE4eGREcjBhUlFh?=
 =?utf-8?B?cGgwdWJKcFZsTTB1TVArckxsTE5MWXl1UXZ5TWtML0krSUNNUHRzd0lEWUR2?=
 =?utf-8?B?alk5cHhwekI0eEJPNlMyajlVQ3FWdGNyUkp2dTZsOVdVSFp6UFdlVnRTNmQ2?=
 =?utf-8?B?cW04UTFRbDdSdTM1U09aNFhnMDlQTldsY2doejM4Vi9BTGNEZm9vS1B5MUpp?=
 =?utf-8?B?djIvbEV3MlBLVjE0b081Z3FQNjM4ckxrK0tSSTJ4MlZDZllWWHlTS1k1Tmt1?=
 =?utf-8?B?dlZEb01JOXA5OTFSWHI5TVFIY0g0Rk1pVG1GdkpiaGV2RTN1TGhtMXd2N1E5?=
 =?utf-8?B?a1E1ZlNnY2NRZlNPNGtaR01vWUVOdU5Vc20vc2dPelV2NGFTSFVQcFVGUXZu?=
 =?utf-8?B?bkRKK2xObnQrcFdzYTVKOWFwYk5TZVBEc0ZsVURMa2ZpbzQ0a2gwaUdUZlNG?=
 =?utf-8?B?NVdMU0VVN3l4RTRucThHeW1BS0IzekNTZjg0TlJDcmlPSG9ZSHZtdm1SMWRs?=
 =?utf-8?B?Y3RWa1JqRko1cnNOVWdjOVpXR1ByRk1SUy9Gbzh5UmJaNjc3U0R1NHNkSGtX?=
 =?utf-8?B?QWdKallIem1iUWhuTDlvcFRUY0Y5RVEwSjFGc1hJd2NMckg0RG5ScitlbFVU?=
 =?utf-8?B?UlR4UEQxRTRhcFNEMXNQODZFU01TVjhEbU5wNkZ0Ni9YK3B5WnNmYTZsL3pS?=
 =?utf-8?B?dkhWMUlIYVB4ajJyaVNSZ090enZxTjRiUFpFTkdvemlzeFArVm1DOTNLRXJI?=
 =?utf-8?B?UGZQQ0wweEhrd09YVTdERTRrUWNjeHFtVXlVZk5GQXkrOFNCenErek50bEJi?=
 =?utf-8?B?U3NZSnUralc3NmVoREZ4RXExOGsrZVYwTDNFdXA3N2hkUHVNR2VHalVMbnlX?=
 =?utf-8?B?NHhjdS9XY1I4QnM4c1l4VkFJcXFtajcxS3IwK2hza3Q1MGFzcXduWEhMUEpF?=
 =?utf-8?B?N3UxcUJZa3FmVk00WTVpOGwyVmp6ZzZHWW9OS3kxSjZlbDBtREEwRTI0MkYx?=
 =?utf-8?B?S3BuQWxrVzdIaGlkN3ZDYWtkSmVmZzR1L3FIQzJwSFJncFpUQUNIdDFPcDg0?=
 =?utf-8?B?ZEo1NFZDN1M1UDgrQ0drUEF2ME90YWdoRXVtZFFOT25rSVJJTXJoZ3hud2Zr?=
 =?utf-8?B?TisvRWpNdXNhWHk2NGsvWWRtTWxJWHk1cERQWGxMd0xDOG5iSkJPWWlQTEtF?=
 =?utf-8?B?YUJ5MWYvT0tZNjEvcVptSXZmRzF3ZkM0MGJjd1U2Si9CbFUrK3V6TDBqanFM?=
 =?utf-8?B?UlhWVGZSZ2tTdi92QlBMemFVQmN5blJnL0t0QmlCU3UyYW9VN2F5eGlrclA0?=
 =?utf-8?B?b1lZbnlBOEVNK3VqajBsZUxuaWFnTGJlNDduS1Jya1FwNjIzbmJCVGxabVE4?=
 =?utf-8?B?SnpIWWQrOGdGdkQ4STl1STdBYU54THM3YUpBZ2NDOGE4dVN3VG04WU5DclVB?=
 =?utf-8?B?OEczMVlZVUJwd3ByQjAwZTByODBianJqZ3VXZWxNQmlQYkYybDV4SVRMR3A3?=
 =?utf-8?B?Vk1NYXd3Umt2L1BSQ09FcTZPKzQyWXVJbWZzbHFqamlxY3hLNGZsSTdwN29t?=
 =?utf-8?B?RGhJU203d3ZpSVpDUGlNcS9vRzhwNXhUZnhiRjlmRElOYzFOejZMczN6cC9Q?=
 =?utf-8?B?eXVNTi9BNWZOY2ZUQWE5NWdpVzIyUCs2YnUyU1RNS2RScThiZkFrZC85Umdv?=
 =?utf-8?B?TVp1dG9kbEhqeGIxbEluQmU4eUhPTUtNajl4b1JXMVRodUpLT1YycGNIMytW?=
 =?utf-8?B?a0FxWk1zelJzbEQ1SlpyejV3OEtsVWZJWE5xTFFSYm1kL3dDL3lLbmt1eTh2?=
 =?utf-8?B?MEFMa1FMNE8ydlRJL3cxYXFUZ0tBd1g5L2JoaENEM1hwZTRhV3diSjk1ZVpT?=
 =?utf-8?B?RXJrWHNOWStOS2pqb3RQRytKREVGelFZemRIbWxILyt4YTdiMHpLR3I0VE96?=
 =?utf-8?B?QkRYUFlCcnFnTmtoRGhuZEMrM3FMT3ZaakorVmdUVytsbzlPbHI0UjcwcXQ4?=
 =?utf-8?B?SDIzbUlhMEpnNVdLektzRkV3ZytSRmxxOUxOUER0cHdqUlJFRGNuUXE1ZHhU?=
 =?utf-8?B?Y0R2dENaQ0dXQ25Za3NrNFp0MThPcDg1QzRPNEpsY2k5bndoMWQ0WUIyY3Vk?=
 =?utf-8?B?ZnFxc2lGaE9jeUt0TEZHV3M0ZlR3Q0JCUGxrSDRnZXkzWm12aXlZMkZGRGsy?=
 =?utf-8?B?a09waTlFV2h6RzZFbDhpaFRsZHpqd1g5RHhMZ0E0VXBWRjBiaWR0WGJ5aUEr?=
 =?utf-8?B?dzJNWUkvMFhBMDlsMS9PdlJTY1o5Z2EzczlDYlVxVmF2WSs2USs3OGEzODRR?=
 =?utf-8?Q?1KWzXhSCHvbHM8CiKbTjqz7bCei+0v/yK9opxLrUYNHQO?=
x-ms-exchange-antispam-messagedata-1: 5OJ6WAtD90JZe79rDTu+aBfVxI7q1wcPyaE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D2CDFFDF4F6864EA1F282A7C9BADFE2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Pb4y4XwOBSWMdobwv4eWMQuoEpK1zIRkXno5tLKQjHNJc0rdy7DGWrwNz1DCIG3LF4Me8cwdPTtLxUzQpwjUpNwHM8GfQWWtxkPLtkRLtK50qxA3KfoSU3WHhTFVK/AvV8IGDGOCgO92N8VcvLe6SoktPZdu8x4L2qaCh64QaD8BMMLBmJ4cRzyzyolQkGX2j1mViDj30bMfJPPKr1SrTzE593F/zEJmqEZCjHPWy3roW0QBh4Vd9Lbfb5ouiZJO7nFeWCg/tGnqUoy0zQFrsmQ6hn+6Ho0BoE2cdGZ5vjnwGc2lwNG7WemNrO0GxItjkPu65jw5fC6O2N6Kd4dtvw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1d177f-4c4f-4368-e6ee-08dee64a1988
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 10:31:46.3198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: USHpe/2MkVy3kyNilrYoBShF5nLMZt+Q/zk+yqa93fdfU25hFye68ucwyVqArJaq2bBxrmbtIoG/JRHrfMf9IQmencvNpwPfUz2kRu8kDQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7977
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

T24gV2VkLCAyMDI2LTA3LTA4IGF0IDA5OjQyIC0wNDAwLCBUaGllcnJ5IENhbnRpbi1EZW1lcnMg
d3JvdGU6DQo+IFRoZSBEZWxsIFhQUyAxNiBEQTE2MjYwIHNoaXBzIGluIG1vcmUgdGhhbiBvbmUg
cGFuZWwgdmFyaWFudC4gVGhlDQo+IGV4aXN0aW5nDQo+IHF1aXJrIGVudHJ5IG9ubHkgbWF0Y2hl
cyB0aGUgTEcgRGlzcGxheSBwYW5lbCB3aXRoIERQQ0Qgc2luayBPVUkNCj4gMDA6MjI6YjkuDQo+
IEFub3RoZXIgdmFyaWFudCBvZiB0aGUgc2FtZSBsYXB0b3AgKHN1YnN5c3RlbSAxMDI4OjBkYmEp
IHVzZXMgYW4gTEcNCj4gRGlzcGxheQ0KPiAweDA3QzUgcGFuZWwgd2l0aCBzaW5rIE9VSSAwMDph
YTowMSwgd2hpY2ggaXMgbm90IG1hdGNoZWQsIHNvIGVEUA0KPiBQYW5lbA0KPiBSZXBsYXkgc3Rh
eXMgZW5hYmxlZCBhbmQgdGhlIHBhbmVsIGhpdHMgYSBwZXJzaXN0ZW50IFBBTkVMLVJFUExBWQ0K
PiBMaW5rIENSQw0KPiBlcnJvciwgZHJvcHBpbmcgdGhlIGludGVybmFsIGRpc3BsYXkgdG8gfjUg
ZnBzLg0KDQpUaGFuayB5b3UgZm9yIHBvaW50aW5nIHRoaXMgb3V0Lg0KDQpUaGVzZSBzeW1wdG9t
cyBsb29rIGRpZmZlcmVudCBjb21wYXJlZCB0byB3aGF0IHdlIHNhdyBvcmlnaW5hbGx5Lg0KUGxl
YXNlIGZpbGUgZ2l0bGFiIHRpY2tldDoNCg0KaHR0cHM6Ly9kcm0ucGFnZXMuZnJlZWRlc2t0b3Au
b3JnL2ludGVsLWRvY3MvaG93LXRvLWZpbGUtaTkxNS1idWdzLmh0bWwNCg0KQlIsDQpKb3VuaSBI
w7ZnYW5kZXINCg0KDQo+IA0KPiBBZGQgYSBxdWlyayBlbnRyeSBmb3IgT1VJIDAwOmFhOjAxIHNv
IHRoaXMgdmFyaWFudCBhbHNvIGdldHMgZURQDQo+IFBhbmVsDQo+IFJlcGxheSBkaXNhYmxlZC4g
Q29uZmlybWVkIHhlLmVuYWJsZV9wYW5lbF9yZXBsYXk9MCByZXNvbHZlcyB0aGUNCj4gaXNzdWUu
DQo+IA0KPiBGaXhlczogY2I4ZDE1NWIwODA2ICgiZHJtL2k5MTUvcHNyOiBEaXNhYmxlIFBhbmVs
IFJlcGxheSBvbiBEZWxsIFhQUw0KPiAxNiBEQTE2MjYwIGFzIGEgcXVpcmsiKQ0KPiBTaWduZWQt
b2ZmLWJ5OiBUaGllcnJ5IENhbnRpbi1EZW1lcnMgPHRoaWVycnljYW50aW5kZW1lcnNAZ21haWwu
Y29tPg0KPiBUZXN0ZWQtYnk6IFRoaWVycnkgQ2FudGluLURlbWVycyA8dGhpZXJyeWNhbnRpbmRl
bWVyc0BnbWFpbC5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkv
aW50ZWxfcXVpcmtzLmMgfCA4ICsrKysrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkv
aW50ZWxfcXVpcmtzLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3F1
aXJrcy5jDQo+IGluZGV4IDMzMjQ1ZjQ0YzBkNS4uZTQ1MjIzNTgzMmZlIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3F1aXJrcy5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfcXVpcmtzLmMNCj4gQEAgLTI4Niw2ICsy
ODYsMTQgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbnRlbF9kcGNkX3F1aXJrDQo+IGludGVsX2Rw
Y2RfcXVpcmtzW10gPSB7DQo+IMKgCQkuc2lua19vdWkgPSBTSU5LX09VSSgweDAwLCAweDIyLCAw
eGI5KSwNCj4gwqAJCS5ob29rID0gcXVpcmtfZGlzYWJsZV9lZHBfcGFuZWxfcmVwbGF5LA0KPiDC
oAl9LA0KPiArCS8qIERlbGwgWFBTIDE2IERBMTYyNjAgKExHIERpc3BsYXkgMHgwN0M1LCBPVUkg
MDA6YWE6MDEpICovDQo+ICsJew0KPiArCQkuZGV2aWNlID0gREVWSUNFX0lEX0FOWSwNCj4gKwkJ
LnN1YnN5c3RlbV92ZW5kb3IgPSAweDEwMjgsDQo+ICsJCS5zdWJzeXN0ZW1fZGV2aWNlID0gMHgw
ZGJhLA0KPiArCQkuc2lua19vdWkgPSBTSU5LX09VSSgweDAwLCAweGFhLCAweDAxKSwNCj4gKwkJ
Lmhvb2sgPSBxdWlya19kaXNhYmxlX2VkcF9wYW5lbF9yZXBsYXksDQo+ICsJfSwNCj4gwqB9Ow0K
PiDCoA0KPiDCoHZvaWQgaW50ZWxfaW5pdF9xdWlya3Moc3RydWN0IGludGVsX2Rpc3BsYXkgKmRp
c3BsYXkpDQoNCg==
