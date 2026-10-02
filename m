Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B0CCA5FD9
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 06:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9647310E4B3;
	Fri,  2 Oct 2026 06:42:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Qswyy+e/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0E1F10E24A;
 Fri,  2 Oct 2026 06:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790923329; x=1822459329;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=R56GyFwuUhmBFrn4VU9DwaEQCXGwUqdpgrGZB4iID9I=;
 b=Qswyy+e/fF1usChaob4rsDGeQ+rXH0+FFRhpkfz4dOftR3TUfzIlE8Pm
 GtMR8E/BdyHZkt3TAGcPhb/jj5/1gIBAMnXjE+23wuK7A9T7s/1v4iZyS
 GHLydTDguDShm6y5vfrh6wHmOVTawHscc8Q7NJGMlWk+mFUTyI0/PPsL3
 ARyQO6UhFqHTvJWO5SxH6UR/D8i6yaew/SkIqhdSNonX6JYJ6zd0N1XVy
 glLhWPLAsSHuix0ftUlmxcvPz0pSk5BD+gDyn3EZAmMGjEcZr5fJfCv5P
 XnjhrusPPUO0BkOq4BKYNvyy0EmOIcNKepELx0apa9mqsY8iCgVx2eCA8 A==;
X-CSE-ConnectionGUID: YE/fahQxRu+3Rs6nbJQbdA==
X-CSE-MsgGUID: 8ElqWFtaQUeXAx/Txqh8uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="95503451"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="95503451"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 23:42:08 -0700
X-CSE-ConnectionGUID: qByywpx/SsWRsXlsoxFXKQ==
X-CSE-MsgGUID: f1TCTOvUSf2iq6me/dpALg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="262151"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 23:42:08 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 23:42:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 23:42:06 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.48) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 23:42:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPcBfGimuhqO6kJKP12Il8lw/Vee4i2RapyCIXIRK462W/VNZ0JsWmQb2lzvK9NS9HyZtrNuPCsmVhsauCNoUhFdIBIvdcNMYJtK5lnaDzSDIjylIeL95A2w2COHR+hojsWeJGY2EbihN+VcqkYo6BrKMjqJs/uLFvSZclu5qmIstMiF92Wp1S1gM5WRBPxkPcNfcZr56Z+HqDG60v9VFDQuwfZqF9AiOYuGrhPjcIbvZnySbcfy4eJpbqPzuELqyoUTFWj0skA9+KZ+2dFUJiu9xdfQfW/iZy3mE68SR7dCgrhUhJjKknGswhRB7qkOK0JArINYcU/FRYjf9uZ1TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R56GyFwuUhmBFrn4VU9DwaEQCXGwUqdpgrGZB4iID9I=;
 b=QedvBFGwP+GzVQQto0pFUgGbs7kLmNuNjqstqvc+i8Uyw8+FaFRkWmXfNy3AEpDhRVrLlu45hdGy5b10fn4GI2VQwS5VPoL2GOqwZXBmim3WzB00D6du5wg+b9QgjkhE208BeLuBXlynv+TNvrsv9tKWaLgz/nz8Uk5h1DuMj1FbhWOAcgv/qrOIcli/chdD+PPwQmTfyc3GtEVCUj5ELPuvRHdGhpmjH+cBWM3ekGaOl+3GD8bYDxhcxSu3sziik3P1X8U0pRnXiRXdYLICT0RxppsejsUUea9104sZujxDQl8kRsy1j5TQ4nfQGU7L6C95DssLqNd2ID7ZNGp69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 DM4PR11MB5326.namprd11.prod.outlook.com (2603:10b6:5:391::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.18; Fri, 2 Oct 2026 06:41:54 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0472.015; Fri, 2 Oct 2026
 06:41:54 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v6 14/18] drm/i915/alpm: Replace is_edp() with
 alpm_is_possible()
Thread-Topic: [PATCH v6 14/18] drm/i915/alpm: Replace is_edp() with
 alpm_is_possible()
Thread-Index: AQHdRUGYbQ5hiEi6BU+FBpUICwjiabbp57MA
Date: Fri, 2 Oct 2026 06:41:54 +0000
Message-ID: <6894f8fd02677c4c53d5caa2ed48da3b01eb11b7.camel@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-15-animesh.manna@intel.com>
In-Reply-To: <20260915180449.277933-15-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|DM4PR11MB5326:EE_
x-ms-office365-filtering-correlation-id: c9f9ec38-b072-4b1f-fba1-08df20503f91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|11063799006|56012099006|4143699003|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 7+iOWOoJK52iskSte+sIrcrMiQuBbnBY0DE6Z1yTXFE6nFCKMVLUYSH9HrJCygkD3QipN77rIJgc68LDPYmCiZ8nJNzdtCmTZ8FEqDxUhx4HsQ8YfjaqqL+VIwSN41gqUPaypqWIzFK/s3iAOmbxaEfTLKinIjc0zdgjWMNJugKm/Cj9ytNRXOrPu75EpDWAJXAvEX/5RTEH0cpiRx3yE2rkwXXty7rN4ler2cm49uQpipTFwB81ijGvlS1z0qggLKUt9fE9xTLD1SLNuOmtPW9SkapypMGtgouuWPIoTZDUEvLMzODsDpLPbHi9E0ywWhNMjwUO7jkuMLZN0ObhwpFzCbdu/kYGV5EunTyWjLI9k0Tsex7F2qOlSSp1h7cTnSYVTl4RC8QC/XqP+G3yqn2EfbCHgDpv9AuaDltK36dnoVATXR6MhjqIl4jHfIMzrc81qoykMyAYhlj+mCvJkNp15NEw7XQjNdFavTqvRyc6lqul/s0VBKfe7/rbOXKabjbNiDDlEpC79q/A0uUzZz4EpxJ9QjKA4GYp9x9CvYvb24uAB5KjXMsSdjdCE0RqbkjzcKoiGDOnu3XZhUU1jqElnsnvXbs1r80/T+53qeLDnPNd5kF9b5U0/Z2hPBKgQdz8iqkUxnC/zCnXlEYTe7BcjpC/qILyIKumwBEbSzSbpaUSSdqjrBp4Do3SWvjz+VEaU5KDJWWW0RJijexvOVulwiJw2oaHy7V5DFUz4fA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TW4xZjBpcS8xZ2toS0hNRkNkRGlZNnpHcXBBSWh0WEpyUXZjaStINUNnMEts?=
 =?utf-8?B?UWIwVGNMQ1FqaUNPdjQyKyt3cmxMWDRwOWM4WVdYeE5aN2ExRjJlZEJUdmZl?=
 =?utf-8?B?bnB2WkxDR3BVK0xHWWh4SDhXeHA0K05SRWFpUEN3SjRQajhMTis4T3dzZm5p?=
 =?utf-8?B?L2hXekxZdGt1RHZjcmpjcDBnRlZrQ0RYV1N0Ky9NUFJPeHhPd1N2d1hISk5W?=
 =?utf-8?B?RmV1YXNRRWlRcmNXelFXUldwTlJFQnMrWWZKV2xMSlJmMDcyNXBVandrMUVi?=
 =?utf-8?B?Y25BYkRlYU95SzIwVVNjNWtsWmFUYWVZdUV2MVhCa0N0bG1TaGVDbEJjR0dZ?=
 =?utf-8?B?RkZDaE5NenhMeWptem9pYkYvamRqOG5mT21YcHk1Z1ptQUpQOUlvYU5YalZo?=
 =?utf-8?B?c3hGNzJtS3lqWnIvR05hZGN6azVCbGxMVHphcnVRWkRuRC9qYmEyVW8rNXkv?=
 =?utf-8?B?VkZmSlc0R3dCeG04V1ZqR3Irc0s0M0FNYW04NkVxOWRMYU9JVUgzSUVpSWFk?=
 =?utf-8?B?Yk5XN3FGVFM2UjA1NHozeHlvMFZmK3RzdVZwU2NKMzFLMlpScXo3aVNPbUdk?=
 =?utf-8?B?OFRjb3RlTGlVWmZxZG1hRHVvWHdTMHBrb0xBaWllU1FrQWcxQS9NUDRnc0o3?=
 =?utf-8?B?SWViZDBGMmIzYm8vc2I4alZQUjBIWS9keU83RFBDTzdhbW9EdHp0S2dQUGFz?=
 =?utf-8?B?R3ZZVm5PTDNpUzlHUktGM3o2TUx6ckdOK3hQSWg2VFRhd3BicXJJbDIyOWRZ?=
 =?utf-8?B?b3JQakJ5MTcyaDZML211RmdDQnJQekRpZVlkVWVwOU9nSXJPMmtLVE1aZTVM?=
 =?utf-8?B?a1VUNXV6cENTdTVGbnh6SmtGU3A1K2RVRDkwTjQ0b0lRVXVQSEtRa05TOTNU?=
 =?utf-8?B?VXB3ZytMdnFPNk5hZGtZNllGNzVYeVNIbTFWSDdIc3M1ak01NVlCZmtHSHds?=
 =?utf-8?B?OGEzcFJIazVFdVlsV1pyMG9JcmNqWmk2NFkzbitIMzJVVzFZaytaWUdxQTMv?=
 =?utf-8?B?bzJZa2dnYVlrMEttVjZ5bU01dnA2U2FIYThHYWJidDNtSlVzNDhxTjh5VFVE?=
 =?utf-8?B?L0t1TG5kQzVTOFN2STZCTDJDSWdZRlV3OTF1RHRYWVd5WWFFbzVHZnZVYkEr?=
 =?utf-8?B?QlF5Rk4yR0JPN1F2a0RTcVFrZnVpUmZJcG5YUkZMYXp3eU5GMXdrZk9TZzFi?=
 =?utf-8?B?RkhkQXR3SGh3ODljUUlQSldockRQaEVGWTYwaTlYRzVpZ3pubTBDcWgyOE1M?=
 =?utf-8?B?QzJPZEVwY1Z5MjhaU3hhY2VtRXhvQzU4SVNRMkQ4TzJNVjBXU1N2RzhhZHlt?=
 =?utf-8?B?anh0dnlCb0g1RGRJalJPeHFpS1Z2aFA3MWErMlNPRmxLZ0tGekFrcFlHZXlT?=
 =?utf-8?B?eTZNNEJkSWhVMWlPdW0wZjk5YlR1a2oxYWhqbVhGMldPc3pNQVptZVc3alVE?=
 =?utf-8?B?RWlUeEhOckpYYWZSUFJ4Q0xYSUwzUStXRGJIbXcyNS9uUWlLQ0F3MnhLNTlG?=
 =?utf-8?B?cm5OaS9vNFpPbGlrOStGR1hsT0xkY0pKQ2l1SlYwQU9oL1Q4UG1JN05zWjhZ?=
 =?utf-8?B?WGlaVkt3N0VKNkx6S0NMY2RpTXJ1RmhNVmtXWUJDaTRQWjZyYjliQzlRQTho?=
 =?utf-8?B?WWN4RkNXRGRJYmg1cDljQWZTS1RjZ2RJaENGdEMrUUlLYmJwREZyeUx1Rkxu?=
 =?utf-8?B?YUswTERObkVxSlJ6Z2dEbHo0Z2dHcUErNHVWUEFiQkJ2VzBibVFlbFg5QVgw?=
 =?utf-8?B?Zm9uUGZjN2taWDhHT3pBbFlZY1NEWWlkWU5mTlplbXU5VTZ1YlZuV0JQcUVo?=
 =?utf-8?B?cm1VWGVDNEhFZlJJY3h5QzM3b1RSQjZINFVPS1liVEdSWW4rRDYrMWtCNnlp?=
 =?utf-8?B?QXk0OW9CTVZYYldYOWM5MzVtUE1zazNLdzNaai94RWN0dXhlS0JNeDUvYzBS?=
 =?utf-8?B?anBBU1VkZEFtR2F5cXF6RXppUFNJTkJldjFFbDRCb1QwZWJUUkwzVUpvUXJX?=
 =?utf-8?B?Mm42TjN4VlZhM2dpcE0zZVRZTHJVM1VLWVp3Qzl5TU9VZnZwUUxaSEtHQjB0?=
 =?utf-8?B?Ujg1czIvOVhZcjl5UmJEY1NqM3ZHSnFOWjd3S21aaGJ3Rmlwb2I4SGFqNlVW?=
 =?utf-8?B?dTk5V2prU2kxNW5sVkF4aVBtRUUyakVGazNhelR0NGQ3a21sOVBBUjRCMEhX?=
 =?utf-8?B?dmdSMTB6b01hS1N6ZlRtdG5yYzNYYUROVE8zVjUxcGsyMklmYjdOaWVSWlVN?=
 =?utf-8?B?Y1pPL0g2TTNMQ0NFN2xNanpFUW1mTXNlL21ZaXZyWFJ3NmZKOGpiRmdXMHZK?=
 =?utf-8?B?MXlnVWZxdGc1S1oydktxOWZWNzhNdEM4ZEExZStuMFdHVVJmdnVYamduOUU4?=
 =?utf-8?Q?HPIQ0sI3vVMSDlIk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8ABFAC2F611F4499890AC026E50393D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mF0KtGohGNFsEVHUfRjNC34YxS6T+YbGBUwo9vSRFAD958k0Z0WCj0Ty27Es+OuH36fCIyeyJ8HaDdWrlRJWqwa5hHSozVdL/ALXZTLTZochQoGOZxl7tBhguR+xRVhNEDUfIWH8iYOek8S0pjCt15Auv7yb7vLZU4T3f/CSm36AaW/0LJx9hrRpkTIo9hYQnYKjLVCcfCMJpe/uFnOej9xOd4/BgRvW0XgdN+QB1mYolNrJKuFX9AatdAs4GILLhS1JlWdaWbFMs6hTSKQDA2tFlNkkRs11TK1FypYFGR8h8A7MAJifPeul4yF3IjCY9mSfz3vORON2l7oDTlUqFg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f9ec38-b072-4b1f-fba1-08df20503f91
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 06:41:54.5845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aJB5LD2gi3VdQ96iYPHNDQRNeLlHpusi35fSArxQrkqj4jpiUoiSCDQI2ZFd9cNjoTONmgp4QWmu0SwRDYdDd0TvyoTK16Z7Cj2+mB4x53Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5326
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

T24gVHVlLCAyMDI2LTA5LTE1IGF0IDIzOjM0ICswNTMwLCBBbmltZXNoIE1hbm5hIHdyb3RlOg0K
PiBBZGQgYSBzZXBhcmF0ZSBhbHBtX2lzX3Bvc3NpYmxlKCkgd2hpY2ggd2lsbCBjaGVjayBmb3Ig
YWxwbQ0KPiBjYXBhYmlsaXR5IGZyb20gZHBjZCBpbmZvLg0KPiANCj4gdjI6IERyb3AgRElTUExB
WV9WRVIoKSBjaGVjayBhcyBpbnRlbF9hbHBtX3NvdXJjZV9zdXBwb3J0ZWQNCj4gYWxyZWFkeSBj
aGVja2luZyBhbmQgcG9wdWxhdGluZyBkcGNkIGluZm8uIFtKb3VuaV0NCj4gDQo+IENjOiBKb3Vu
aSBIw7ZnYW5kZXIgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
QW5pbWVzaCBNYW5uYSA8YW5pbWVzaC5tYW5uYUBpbnRlbC5jb20+DQo+IC0tLQ0KPiDCoGRyaXZl
cnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jIHwgMTMgKysrKysrKysrKy0tLQ0K
PiDCoGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5oIHzCoCAxICsNCj4g
wqAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiBpbmRleCAw
NmMxYTU5YWEyYzUuLjI5YTkzYTI1MmZlOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUv
ZGlzcGxheS9pbnRlbF9hbHBtLmMNCj4gQEAgLTY5LDYgKzY5LDEzIEBAIHZvaWQgaW50ZWxfYWxw
bV9pbml0KHN0cnVjdCBpbnRlbF9kcCAqaW50ZWxfZHApDQo+IMKgCW11dGV4X2luaXQoJmludGVs
X2RwLT5hbHBtLmxvY2spOw0KPiDCoH0NCj4gwqANCj4gK2Jvb2wgaW50ZWxfYWxwbV9pc19wb3Nz
aWJsZShzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwKQ0KPiArew0KPiArCXJldHVybiAoaW50ZWxf
ZHAtPmFscG1fZHBjZCB8fA0KPiArCQlpbnRlbF9kcC0NCj4gPmx0dHByX2NvbW1vbl9jYXBzW0RQ
X0xUVFBSX0FMUE1fQ0FQQUJJTElUSUVTIC0NCj4gKwkJCQkJwqDCoMKgDQo+IERQX0xUX1RVTkFC
TEVfUEhZX1JFUEVBVEVSX0ZJRUxEX0RBVEFfU1RSVUNUVVJFX1JFVl0pOw0KPiArfQ0KPiArDQo+
IMKgc3RhdGljIGludCBnZXRfc2lsZW5jZV9wZXJpb2Rfc3ltYm9scyhjb25zdCBzdHJ1Y3QgaW50
ZWxfY3J0Y19zdGF0ZQ0KPiAqY3J0Y19zdGF0ZSkNCj4gwqB7DQo+IMKgCXJldHVybiBTSUxFTkNF
X1BFUklPRF9USU1FICoNCj4gaW50ZWxfZHBfbGlua19zeW1ib2xfY2xvY2soY3J0Y19zdGF0ZS0+
cG9ydF9jbG9jaykgLw0KPiBAQCAtNTQ2LDcgKzU1Myw3IEBAIHZvaWQgaW50ZWxfYWxwbV9sb2Jm
X2NvbXB1dGVfY29uZmlnKHN0cnVjdA0KPiBpbnRlbF9kcCAqaW50ZWxfZHAsDQo+IMKgCWlmIChp
bnRlbF9kcC0+YWxwbS5zaW5rX2FscG1fZXJyb3IpDQo+IMKgCQlyZXR1cm47DQo+IMKgDQo+IC0J
aWYgKCFpbnRlbF9kcF9pc19lZHAoaW50ZWxfZHApKQ0KPiArCWlmICghaW50ZWxfYWxwbV9pc19w
b3NzaWJsZShpbnRlbF9kcCkpDQo+IMKgCQlyZXR1cm47DQo+IMKgDQo+IMKgCWlmIChESVNQTEFZ
X1ZFUihkaXNwbGF5KSA8IDIwKQ0KPiBAQCAtODMyLDcgKzgzOSw3IEBAIHZvaWQgaW50ZWxfYWxw
bV9sb2JmX2Rpc2FibGUoY29uc3Qgc3RydWN0DQo+IGludGVsX2NydGNfc3RhdGUgKm5ld19jcnRj
X3N0YXRlKQ0KPiDCoA0KPiDCoAkJaW50ZWxfZHAgPSBlbmNfdG9faW50ZWxfZHAoZW5jb2Rlcik7
DQo+IMKgDQo+IC0JCWlmICghaW50ZWxfZHBfaXNfZWRwKGludGVsX2RwKSkNCj4gKwkJaWYgKCFp
bnRlbF9hbHBtX2lzX3Bvc3NpYmxlKGludGVsX2RwKSkNCg0KSSB0aGluayByYXRoZXIgdGhhbiBj
b252ZXJ0aW5nIHRoZXNlIHlvdSBzaG91bGQgcmVtb3ZlIHRoZXNlIGNoZWNrcw0KZnJvbSBlbmFi
bGUgYW5kIGRpc2FibGUuIExPQkYgaXMgbm90IHN1cHBvc2VkIHRvIGJlIGVuYWJsZWQgaW4NCm5l
d19jcnRjX3N0YXRlIGlmICIhaW50ZWxfYWxwbV9pc19wb3NzaWJsZSgpIg0KDQpCUiwNCkpvdW5p
IEjDtmdhbmRlcg0KIA0KPiDCoAkJCWNvbnRpbnVlOw0KPiDCoA0KPiDCoAkJbXV0ZXhfbG9jaygm
aW50ZWxfZHAtPmFscG0ubG9jayk7DQo+IEBAIC04NzMsNyArODgwLDcgQEAgdm9pZCBpbnRlbF9h
bHBtX2xvYmZfZW5hYmxlKGNvbnN0IHN0cnVjdA0KPiBpbnRlbF9jcnRjX3N0YXRlICpuZXdfY3J0
Y19zdGF0ZSkNCj4gwqANCj4gwqAJCWludGVsX2RwID0gZW5jX3RvX2ludGVsX2RwKGVuY29kZXIp
Ow0KPiDCoA0KPiAtCQlpZiAoaW50ZWxfZHBfaXNfZWRwKGludGVsX2RwKSkgew0KPiArCQlpZiAo
aW50ZWxfYWxwbV9pc19wb3NzaWJsZShpbnRlbF9kcCkpIHsNCj4gwqAJCQlpbnRlbF9hbHBtX2Vu
YWJsZV9zaW5rKGludGVsX2RwLA0KPiBuZXdfY3J0Y19zdGF0ZSk7DQo+IMKgCQkJaW50ZWxfYWxw
bV9jb25maWd1cmUoaW50ZWxfZHAsDQo+IG5ld19jcnRjX3N0YXRlKTsNCj4gwqAJCX0NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5oDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmgNCj4gaW5kZXggOWEwMmZh
Mzg2ZWUzLi5lYTkwZWJhNzZjYTcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1
L2Rpc3BsYXkvaW50ZWxfYWxwbS5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3Bs
YXkvaW50ZWxfYWxwbS5oDQo+IEBAIC0xOCw2ICsxOCw3IEBAIHN0cnVjdCBpbnRlbF9jcnRjOw0K
PiDCoGJvb2wgaW50ZWxfYWxwbV9zb3VyY2Vfc3VwcG9ydGVkKHN0cnVjdCBpbnRlbF9jb25uZWN0
b3IgKmNvbm5lY3Rvcik7DQo+IMKgYm9vbCBpbnRlbF9hbHBtX2luaXRfZHBjZChzdHJ1Y3QgaW50
ZWxfZHAgKmludGVsX2RwKTsNCj4gwqB2b2lkIGludGVsX2FscG1faW5pdChzdHJ1Y3QgaW50ZWxf
ZHAgKmludGVsX2RwKTsNCj4gK2Jvb2wgaW50ZWxfYWxwbV9pc19wb3NzaWJsZShzdHJ1Y3QgaW50
ZWxfZHAgKmludGVsX2RwKTsNCj4gwqBib29sIGludGVsX2FscG1fY29tcHV0ZV9wYXJhbXMoc3Ry
dWN0IGludGVsX2RwICppbnRlbF9kcCwNCj4gwqAJCQnCoMKgwqDCoMKgwqAgc3RydWN0IGludGVs
X2NydGNfc3RhdGUgKmNydGNfc3RhdGUpOw0KPiDCoHZvaWQgaW50ZWxfYWxwbV9sb2JmX2NvbXB1
dGVfY29uZmlnKHN0cnVjdCBpbnRlbF9kcCAqaW50ZWxfZHAsDQoNCg==
