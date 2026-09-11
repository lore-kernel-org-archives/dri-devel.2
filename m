Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB6EC88E41
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6559410E121;
	Fri, 11 Sep 2026 00:05:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="niZU6+01";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CC9A10E10D;
 Fri, 11 Sep 2026 00:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789085131; x=1820621131;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Tgigb/ovCV3U3Zi2D0iYLPgHbyBd2GFdmNy4lM7urtg=;
 b=niZU6+01czRZmuxsZkB0hfYKmjF5WF1amErvUpXN+VBviefEDqLl1hKX
 X+0q0+NuNZzJN+h2pMo3dlNNYHp+ukrhkei0ZpnV2pMwwxImG9jeEHgLP
 ztoUh5iXB4VR+3+XAqOVA9YxqMIb9SZZuUeflBHjlDBrNJYsnhzH+fOo9
 8w5n2ElSlEkFQPkXcvOMItzhEJw5bH6rfbLTrvRYkdQ0JQYLIrc9whsbN
 3o59BNLGPqQLYAKx1VUdFCntgBo3VewL4cTlI0oKdVyIPVqVtDMMJjnwH
 P3kcHAEDvUgwleGFQxNmoYxqQWVtiODNXAwqYD3kpr85u8hNV28166MKR A==;
X-CSE-ConnectionGUID: LJvbWIe2Q/mTwlU9yrdraw==
X-CSE-MsgGUID: mfq5e0DnTMSooQ0FsFATKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="115090005"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; d="scan'208";a="115090005"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 17:05:31 -0700
X-CSE-ConnectionGUID: bSx4ySFxShegJ5I85rsi4Q==
X-CSE-MsgGUID: Dvav3/IBQgWpySMNS6eSGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="101454"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 17:05:31 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 17:05:30 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 17:05:30 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 17:05:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjlnI/jJnRBRVU4J1p+gQIXbDCmWBUYQrEViSh7afBdPzSW1BXS53v5cHe9973W3ABlUxqi3Lyc1HjDPiFJPf/oIKuahkzb70YSf2V6tZaFSK9AJUcOpzUam2XQ0oy0LqKKH/uypOuRU4fa9nFm+MB2gpmB3yXLFmGf06d8YtWQiUBXtXSjLe5jg6WVw1EWTDaMBPPMJZQZqVR+2IlgzeQOGcVNZC54aVa7ZhZ37bJbNXnLO5EfSd7NcAR1UBgHXvPNGy1PMpYnw/vp0WJ2Z1RTJQYyfDe5OH2ICgiEtwjLmpEpfAAbKuqQbuIZDeRwT1CJrBV5bvHgPeJX7uzpVkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tgigb/ovCV3U3Zi2D0iYLPgHbyBd2GFdmNy4lM7urtg=;
 b=w+BwCpIOmjH10Tua+6GWlgshQKYaXHyOttIwk8/3TTT3XBX5sSxt9KYK49VILU4WZDt4FPjWYtnzOUcuhtlOntqdkxNZ1i0cZdEb81wgxZfHf7rU4WpvcsZ4Cc3Q/O/oRsxpsELgbFicQmZ2OZEdxQ4NYzSNkRyROiYdl4mNlVjtE4GDsxT493L4akPdgCmFxuuaTFmyjBxuWhAH7UkQXuXOz0eUBk+zo8EgpRb9OTjFbaubVlQ5j0k6Vv2HcUJ3QigkW24Dmwwk3cUdqBtd4I0xVAunXMnRhWgXg6M26n1wNOV8hfZZsOGPcCq+J+x1fhZ4GQpYk+tLbXoo/zDK4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LVWPR11MB9883.namprd11.prod.outlook.com (2603:10b6:408:3c0::11)
 by DS6PR11MB9896.namprd11.prod.outlook.com (2603:10b6:8:460::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 00:05:28 +0000
Received: from LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e]) by LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e%4]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 00:05:28 +0000
From: "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Roper, Matthew D" <matthew.d.roper@intel.com>
Subject: Re: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
Thread-Topic: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
Thread-Index: AQHdP8PElfBuV+ezuEu09Nv4H1Mil7bF4xWAgAKf44A=
Date: Fri, 11 Sep 2026 00:05:28 +0000
Message-ID: <3c3d414c1edf2623f0dbf4cef81c632a50da43d5.camel@intel.com>
References: <20260908185609.359565-2-alan.previn.teres.alexis@intel.com>
 <04c865dcd2135c202cf604b111084fc809ae322c@intel.com>
In-Reply-To: <04c865dcd2135c202cf604b111084fc809ae322c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR11MB9883:EE_|DS6PR11MB9896:EE_
x-ms-office365-filtering-correlation-id: 209d2437-4080-43aa-5013-08df0f98635f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: f/fbNRoeIeBBybnVlKOX8YjAU+gQSV0aYFgjnCgOvJdQvLOKEVJEN+JKUu5lUZtFoGfwtzbbZKhJSLg+qbdI/GmtKq/5l0I0HpYqRQpQgqePcNJ7Ee6iz9wF28UnkUj9laX4xbUsELpNBAjs4HNA05KNx7VYMQH54XEIG4Bfofa6LLV7m+8+0iFUTJKNDYCqJq6SLoBgTyrIur8Nv0SIgSR4DgGSGe1Y7ARRgwFzKN4WNpXaUo1hHuAQpdBV6GJg2mmZanEg+AENh9cxCyoGLAkcWfd+helRRvSxo+0mX/abjAa8+yz9nVKAmAgiQOlk/5XXQjtQdbYAXzrA4v9lymwfbU+tttVykrLXs1pk6iYTZfwDfX0+RwIz/WU+6Cg3pRy0mKpVMoZoubNRWUuwhb7nqQiXZEft+2wBFsXvxKkTsniEO7kn6Y69S6R1thF7s0nMRZFgE5MKx9hJivgqWuOZ+bFN2rNKrzXvlKRnqcoHR6br7IU+012ezprlaKivKbpN/HIAg7oPKwazeWo8QL6FBOiiMjLTRhHqxOfdsUcUkOOWrl1u1jfN0IkC6e4U0EuCYVf242Xw4gIdPYA4nNAh/KrsIf6dOnkqv9/d6szW69AkVnUuxOlqD2XvYd399zP1/LZfUbge2zKJXMLMJaMKzxn7grQZouK6lp+2hla3b9IlzZuaGUI1rSSrVAO/nMhwPI3BfF3sZxlpD8xm4sSnuVxXJ2XZfbczWBUX7ww=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVWPR11MB9883.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnVndnRVZmM3MnppUldUVk5nekF4ajZQMzdZRml5bW1VVEJwTTJ5VXFXTmJL?=
 =?utf-8?B?S3Joa1VBdm0xR1NBc1FLWFJsM3ZXdzhLd2RjNGk2U1pwelp6YTVKckVjL0hl?=
 =?utf-8?B?OW1FaE5yL3hmbXYvRlhwTjlhVzlKZWl3T1NVVE1DZnRqOXo3Z0NGWXB5OW8r?=
 =?utf-8?B?VmRFeENTQVFGVzJGb1d0UXVJdXJaT0tXOXFTK1JlaDlUT2JMQTR4RC80cGJ6?=
 =?utf-8?B?WFRtelQwNXNNSGRLc0NLcWkvRjVpNjRKdDlwOUh0TU1pYldIRmRNQVRtUE93?=
 =?utf-8?B?bThpVk5BR1pweEl0akU0c3hiMG1xK3lwOUdlM3hETUF4SlNaSHgxOHA1N2Ux?=
 =?utf-8?B?VmhMTnlYL0VzS1RqNlIwQnhSYUVJVXBRMmZIZ2M2VjNZL1JmWmhtZFVOZXov?=
 =?utf-8?B?RUVqRGEyRUFDVzVwM2RuL1BneStGNkFFa1dIRHh6U1Y2Uk16N3ZROCs4SmZt?=
 =?utf-8?B?cTJUYjdYNTk3UlpOeVNnSGV6WHVHZUJZdkNSaVVRZ0ZLV0JZcG9BWlNJa3B4?=
 =?utf-8?B?RkdlWFBsenFhMHg1UXJ1dTQ1a0pJZXlaSEszcUtaQUF1QzNza3hseCtncDFV?=
 =?utf-8?B?SGQ0Ulp6SzFjdGJSd0F3YWZwMXhoUnpxUWl4L1ZZMWJIa2gwUzRNK3NMcDNp?=
 =?utf-8?B?a2ZYOSt4WE4vYVFSeHlTTnh3Q1BwUUN1NkRpaWNXK01nU2Y1aE1CM285aE8w?=
 =?utf-8?B?MmhxYVlWZG1XZUZhdFowSlp5RGcyYlBvekxUOHF2YktQMEVGQmlpblo4Zkla?=
 =?utf-8?B?akNRMG5BekJVY0VTKzNmb3Q0d1N4Tm9GYmZFSGNwaUpHZFVvNGgwUnR5VHNv?=
 =?utf-8?B?K2ZlS1dWazJOQXNYdkxSbG1TVFQvd0dVQzJqMEE1bmNBemE5cGRQdkJqUWsy?=
 =?utf-8?B?WUlUVnBqVW1WamJkM2x2WWFGT1ptd0JzM1BEZVRYMndkRmxwcUx2K2dsa29N?=
 =?utf-8?B?aDI4WXhtazB4eHNZMXVmc0FVU01KNU9sRHVxL2NZaU1VM2RGY3B0M2ZWMGZH?=
 =?utf-8?B?aTZERG0yb3VBSDZTTVRjWFh2bWdFWlhBMnd1dlZaTHJqd1RuVTJPamx5MUFy?=
 =?utf-8?B?RThZcStnV3BzUjBOVDhIVDMyOWdWb3hnWlNYVk01aDA0K1A3YkVGQ1kraWVJ?=
 =?utf-8?B?Q2ZBTnc1ZzlYaytGdnpIbzgyRFdnRis4WEFwQlllOU5DVDVJMXBoSlJBSUZm?=
 =?utf-8?B?TjkrMHJQYnNKd2xVbStTcXhhd0ZUOVAyQWFZMzJpY2YvSkJWTU9UdytjbVoy?=
 =?utf-8?B?ZnRKaXh1R2JrTVhLeXF2a2pPTEFTMW9sRGRRYkNlUklGSEh1Y2hXNVBlOEl3?=
 =?utf-8?B?RWdsNFhGcUE1NkF2S2liQldkaFVubndhZjl3OVhaclpzNytIc1MvK3FiZnJY?=
 =?utf-8?B?cDZka0hmMUZkS0dCOEhlVFJCOTcvYnJkM051VFI5c1NVelhMamtZRzRXd3V5?=
 =?utf-8?B?YmJ2eStjWlEwem90RXk3S0FFeWxEaHAycDB6QVNMVUhSck5vWnJYSFRzU0lV?=
 =?utf-8?B?K0g0L0EwdzU1Y1NtbTdyZUt1c0RuemNuVy9OVG4xSnhhY1ByTVp0QjV0T25m?=
 =?utf-8?B?d1ZzcU9FZVRBcE52SkFNRlp2VERvaVNSejR4VVk0UVR4cDR6U05CRXg5bDFh?=
 =?utf-8?B?WVZyMDNJZVlQVmdKa0JqUFhEQ2QxNXdhblFORTR2NEhvcnZkbnh1MFB3TEU0?=
 =?utf-8?B?dnZCckQyOUZYZmhkYkk1elFDUTN1WTVUQjBBTTI2L0hKb3dORnMzZU5XYTRF?=
 =?utf-8?B?eWx6aWl3QjRKaW43OUc2em5OVTJ3bUpUWGJzay96REE2QmMrcjMweW5HZktK?=
 =?utf-8?B?MjE2SHRDZC9NRUpDMGdZdUtTc0JGK2FkQkpPSGx4ZnV1MGhEWEJpMnVYS0NX?=
 =?utf-8?B?dUl2czRKV0E0QlRja0JsSFFSZW04M01UK01jNURLWjZUQkJPRTBRU1pRS2hy?=
 =?utf-8?B?SUtsUWF3bFptakhFd0trRUdBT3pMcG1PWmlpZklkSHRrTFpDR3c2bHQzV0dZ?=
 =?utf-8?B?Z1plVG9ub0xUeHh1cktUZzUxK0ExSDVOcXNJZFJkbVZPNTVNYld5SWZtQlJV?=
 =?utf-8?B?c1BNQWJlQ3RuQTVBY1hmUXVGU2syVWd6U1AwSjBXUkFqejlEaHB4SVRUYWpW?=
 =?utf-8?B?Mkh2WHhhZUM1OGxYbDNiL0dud2hvbW16UFFSMUdyM0tCZk1SQVhzN3pzeWxH?=
 =?utf-8?B?akcyRVVFNkkzOVpib3U0bENPY0kzK1lSRWVpRGRkL0svQ1F0bXhnME84ZnRS?=
 =?utf-8?B?d0xwQjJaSmExY1JNMmN5WVc5Q1hkaERTNkpLQ1NScFlCZmpHUzE4TW8wcXc3?=
 =?utf-8?B?dmlaRVlLdWUrdGZIK0p5UjhWc2pnb1drcmczMDUyOUUxemcxdHFEWUcwNFpw?=
 =?utf-8?Q?BhqvMrxoZK38aCmEqH9sUKMiVjJMTRkUUOX0u?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F20DA2C91D6D54395F324B1765998D9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: B6vBZD8q9acy6tQzu0OpizdZ025V2ju2y96NwuLVn/m5hHAeUJPo6mSbJwIz2q8lZlZF5flaFU6snUf0Np5Z4mdHt31lx94RnAMf/QClvKsCWT/R2D0P0eY1PYs4Ye15I1iF3oa3/Twz6MmxhTlSzTZG5DYWiqBlH62pyxuum4of4vcb9H+4t0z2G48CMviIpDWkepj9/EZvV3h/gYNzI9ZmIsL73bezGG4syg3KsiRevHG7DUxqUG40Hf8jZUpYQ72y90D5xCkdna9Vyw2tTUoSKdR8Scvi9c7NB0aVrg9jGWmwJqgBiLknub/qpWPhyXdQnFZFGtR3O2/N7miUlw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR11MB9883.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209d2437-4080-43aa-5013-08df0f98635f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 00:05:28.5974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NE5lJwHXKnqPfU2JnfDkVzSLNsN0FDAzj4K6oN1+EmmL+uDHks11tSFb/BNDoEYfZt5AWhlP3JbyeiYIY53NgjTtBBWm3vyZSsmUbrsr1pS5Nl0J5sWAMhWlSIz/Fbim
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB9896
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

T24gV2VkLCAyMDI2LTA5LTA5IGF0IDExOjAwICswMzAwLCBKYW5pIE5pa3VsYSB3cm90ZToNCj4g
T24gVHVlLCAwOCBTZXAgMjAyNiwgQWxhbiBQcmV2aW4gPGFsYW4ucHJldmluLnRlcmVzLmFsZXhp
c0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+IENoZWNrIGZvciBvdmVyZmxvdyBpbiB1ZGVsYXkvdXNs
ZWVwX3JhbmdlIHVzZSBpbiBfX3hlX21taW9fd2FpdDMyDQo+ID4gYW5kIHBpY2sgdGhlIGNvcnJl
Y3QgaGVscGVyIGFjY29yZGluZyB0byB0aGUgd2FpdCB0aW1lIGFuZCBhdG9taWMuDQo+ID4gSW1w
bGVtZW50IGEgc2ltaWxhciBoZWxwZXIgdG8gcmVwbGFjZSBESVZfUk9VTkRfVVAgZm9yIDMyLWJp
dCBDUFVzLg0KPiA+IEF2b2lkIGdyb3dpbmcgZGVsYXlzIGJlY29taW5nIGludG9sbGVyYWJseSBs
YXJnZSBieSBjYXBwaW5nIHRoZQ0KPiA+IGluLWxvb3Agd2FpdCB0aW1lLg0KPiANCj4gSSB0aGlu
ayBpdCBtaWdodCBiZSBhIGJldHRlciBpZGVhIHRvIHJlbW92ZSB0aGUgZXhwb25lbnRpYWxseSBn
cm93aW5nDQo+IHdhaXQgdGltZSBpbnN0ZWFkLiBJdCBtaWdodCBoYXZlIHNlZW1lZCBnb29kIG9u
IHBhcGVyLCBidXQgeW91IHNob3VsZCBkbw0KPiB0aGUgbWF0aCBpbiB0eXBpY2FsIHVzZSBjYXNl
cyBhbmQgc2VlIGhvdyBpdCBhY3R1YWxseSBiZWhhdmVzLiAoU3BvaWxlcjoNCj4gTG90cyBvZiB1
c2VsZXNzIGJhY2stdG8tYmFjayByZWFkcyBpbiB0aGUgYmVnaW5uaW5nLCBhbmQgdGhlbiBxdWlj
a2x5DQo+IGluY3JlYXNpbmcgdG8gd2FpdHMgYmV5b25kIHRoZSB0aW1lb3V0IGFuZCBkZWxheSBt
YXhpbXVtcy4pDQo+IA0KPiBUaGlzIGlzIGNvZGUgdGhhdCBzaG91bGQgYmUgcG9zc2libGUgdG8g
dW5kZXJzdGFuZC4gSSdkIHN1Z2dlc3QNCj4gc2ltcGxpZnlpbmcgdGhlIHdob2xlIHRoaW5nIGlu
c3RlYWQgb2YgbWFraW5nIGl0IG1vcmUgY29tcGxleC4NCj4gDQo+IEkgdGhpbmsgaXQgd291bGQg
YmUgbXVjaCBiZXR0ZXIgdG8gbWlncmF0ZSB4ZSBtbWlvIHRvIHVzZQ0KPiBwb2xsX3RpbWVvdXRf
dXMoKSBhbmQgcG9sbF90aW1lb3V0X3VzX2F0b21pYygpIGluc3RlYWQuIEZvciB0aGUgcmFyZQ0K
PiBjYXNlcyB0aGF0IGFjdHVhbGx5IG5lZWQgdGhlIHF1aWNrIGhhbW1lcmluZyBmb2xsb3dlZCBi
eSBzbG93ZXIgd2FpdHMsDQo+IHlvdSBjYW4gdHJpdmlhbGx5IGRvIHR3byBjYWxscyB3aXRoIGRl
bGF5cyBhbmQgdGltZW91dHMgY29uc2lkZXJlZCBmb3INCj4gKnRoYXQqIHBhcnRpY3VsYXIgdXNl
IGNhc2UuDQoNCmFsYW46IHJpZ2h0IC0gd2lsbCBkby4NCj4gDQo+IEkgYWxzbyB0aGluayBpdCdz
IGEgbWlzdGFrZSAoY29weS1wYXN0ZWQgZnJvbSBpOTE1KSB0byBzcGVjaWZ5ICJhdG9taWMiDQo+
IGFzIGEgcGFyYW1ldGVyLiBUaGV5IHNob3VsZCBiZSBzZXBhcmF0ZSBmdW5jdGlvbnMgYWxsIHRo
ZSB3YXkgZnJvbSB0aGUNCj4gY2FsbGVyLg0KPiANCmFsYW46IG5vdCBzdXJlIGkgdW5kZXJzdGFu
ZCB3aHkgdGhpcyBpcyBhIG1pc3Rha2UgLSB0aGUgY2FsbGVyIG5lZWRzIHRvDQplbnN1cmUgdGhl
eSBjYWxsIHdpdGggdGhlIGNvcnJlY3QgcGFyYW1ldGVyIC0gc28gaXRzIGVpdGhlciB0aGV5IGNh
bGwgd2l0aA0KdGhlIGNvcnJlY3QgcGFyYW1ldGVyIG9yIHRoZSBjb3JyZWN0IHN1ZmZpeCB2ZXJz
aW9uIG9mIHRoZSB4ZV9tbWlvX3dhaXQNCihpZiB3ZSBkZWNpZGUgdG8gZ28gd2l0aCBzZXBhcmF0
ZSBmdW5jdGlvbnMpLiBJdHMgYmFzaWNhbGx5IHRoZSBzYW1lIG5vPw0KSW4gYW55IGNhc2UsIHN1
cmUgLSB3aWxsIGRvIHRoYXQgdG9vLg0KDQo+IA0KPiBCUiwNCj4gSmFuaS4NCj4gDQo+IA0KPiA+
IA0KPiA+IHYyOiAtIEZpeGVkIGNoZWNrcGF0Y2ggZmFpbHVyZS4NCj4gPiAgICAgLSBBZGRlZCBo
ZWxwZXIgZm9yIDY0LWJpdCBESVZfUk9VTkRfVVAgb24gMzItYml0IENQVSAoU2hhc2lrbw0KPiA+
ICAgICAgIHJldmlldykuIEZpeGVkIGJ1ZyBtYXggcmFuZ2UgaW4gdXNsZWVwX3JhbmdlKFNoYXNp
a28gcmV2aWV3KQ0KPiA+IA0KPiA+IEZpeGVzOiA1YzA5YmQ2Y2NkNDEgKCJkcm0veGUvbW1pbzog
TW92ZSB4ZV9tbWlvX3dhaXQzMigpIHRvIHhlX21taW8uYyIpDQo+ID4gU2lnbmVkLW9mZi1ieTog
QWxhbiBQcmV2aW4gPGFsYW4ucHJldmluLnRlcmVzLmFsZXhpc0BpbnRlbC5jb20+DQo+ID4gQXNz
aXN0ZWQtYnk6IEdpdGh1Yi1Db3BpbG90OkNsYXVkZS1Tb25uZXQtNS0wDQo+ID4gLS0tDQo+ID4g
IGRyaXZlcnMvZ3B1L2RybS94ZS94ZV9tbWlvLmMgfCA1MCArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS94ZS94
ZV9tbWlvLmMgYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfbW1pby5jDQo+ID4gaW5kZXggN2ZhMThk
ZmNiNWEyLi4xYWUzODJmMDA5ZGUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3hl
L3hlX21taW8uYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9tbWlvLmMNCj4gPiBA
QCAtNyw2ICs3LDggQEANCj4gPiAgDQo+ID4gICNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0KPiA+
ICAjaW5jbHVkZSA8bGludXgvaW8tNjQtbm9uYXRvbWljLWxvLWhpLmg+DQo+ID4gKyNpbmNsdWRl
IDxsaW51eC9tYXRoLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9tYXRoNjQuaD4NCj4gPiAgI2lu
Y2x1ZGUgPGxpbnV4L21pbm1heC5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcGNpLmg+DQo+ID4g
IA0KPiA+IEBAIC0zMjAsNiArMzIyLDMwIEBAIHU2NCB4ZV9tbWlvX3JlYWQ2NF8yeDMyKHN0cnVj
dCB4ZV9tbWlvICptbWlvLCBzdHJ1Y3QgeGVfcmVnIHJlZykNCj4gPiAgCXJldHVybiAodTY0KXVk
dyA8PCAzMiB8IGxkdzsNCj4gPiAgfQ0KPiA+ICANCj4gPiArLyoqDQo+ID4gKyAqIF9fZGl2X3Jv
dW5kX3VwNjQoKSAtIGFsdGVybmF0aXZlIHRvIERJVl9ST1VORF9VUCBmb3IgdXNlIGJ5IF9feGVf
bW1pb193YWl0MzINCj4gPiArICogQGRpdmlkZW5kOiA2NCBiaXQgcG9zaXRpdmUgbnVtYmVyIHRv
IGRpdmlkZQ0KPiA+ICsgKiBAZGl2aXNvcjogNjQgYml0IHBvc2l0aXZlIGRpdmlzb3INCj4gPiAr
ICoNCj4gPiArICogRElWX1JPVU5EX1VQKCkgcmVsaWVzIG9uIHBsYWluICcvJyBhbmQgJyUnIG9w
ZXJhdG9ycywgd2hpY2ggZm9yIDY0LWJpdA0KPiA+ICsgKiBvcGVyYW5kcyBvbiBhIDMyLWJpdCBD
UFUgZ2V0IHR1cm5lZCBpbnRvIGNhbGxzIHRvIGxpYmdjYydzIF9fZGl2ZGkzKCkvDQo+ID4gKyAq
IF9fbW9kZGkzKCksIHJvdXRpbmVzIHRoZSBrZXJuZWwgZG9lcyBub3QgbGluayBhZ2FpbnN0LiBQ
cm92aWRlIGENCj4gPiArICogZG9fZGl2KCktYmFzZWQgZXF1aXZhbGVudCB0aGF0IHdvcmtzIGZv
ciBzaWduZWQgNjQtYml0IGlucHV0cyBvbiBhbnkNCj4gPiArICogYXJjaGl0ZWN0dXJlLg0KPiA+
ICsgKg0KPiA+ICsgKiBSZXR1cm5zOiByb3VuZGVkIHVwIGRpdmlzaW9uIHJlc3VsdA0KPiA+ICsg
Ki8NCj4gPiArc3RhdGljIGlubGluZSBzNjQgX19kaXZfcm91bmRfdXA2NChzNjQgZGl2aWRlbmQs
IHM2NCBkaXZpc29yKQ0KPiA+ICt7DQo+ID4gKwl1NjQgYWJzX2RpdmlkZW5kID0gYWJzKGRpdmlk
ZW5kKTsNCj4gPiArCXU2NCBhYnNfZGl2aXNvciA9IGFicyhkaXZpc29yKTsNCj4gPiArCXU2NCBy
ZXN1bHQgPSBhYnNfZGl2aWRlbmQgKyBhYnNfZGl2aXNvciAtIDE7DQo+ID4gKw0KPiA+ICsJZG9f
ZGl2KHJlc3VsdCwgYWJzX2Rpdmlzb3IpOw0KPiA+ICsJLyogZG9udCBjaGVjayBmb3IgbmVnYXRp
dmUgdmFsdWVzIGFzIGxvY2FsIGNhbGxlciBvbmx5IHVzZXMgcG9zaXRpdmUgbnVtYmVycyAqLw0K
PiA+ICsJcmV0dXJuIChzNjQpcmVzdWx0Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgaW50
IF9feGVfbW1pb193YWl0MzIoc3RydWN0IHhlX21taW8gKm1taW8sIHN0cnVjdCB4ZV9yZWcgcmVn
LCB1MzIgbWFzaywgdTMyIHZhbCwNCj4gPiAgCQkJICAgIHUzMiB0aW1lb3V0X3VzLCB1MzIgKm91
dF92YWwsIGJvb2wgYXRvbWljLCBib29sIGV4cGVjdF9tYXRjaCkNCj4gPiAgew0KPiA+IEBAIC0z
NDksMTEgKzM3NSwyNSBAQCBzdGF0aWMgaW50IF9feGVfbW1pb193YWl0MzIoc3RydWN0IHhlX21t
aW8gKm1taW8sIHN0cnVjdCB4ZV9yZWcgcmVnLCB1MzIgbWFzaywgdQ0KPiA+ICAJCWlmIChrdGlt
ZV9hZnRlcihrdGltZV9hZGRfdXMoY3VyLCB3YWl0KSwgZW5kKSkNCj4gPiAgCQkJd2FpdCA9IGt0
aW1lX3VzX2RlbHRhKGVuZCwgY3VyKTsNCj4gPiAgDQo+ID4gLQkJaWYgKGF0b21pYykNCj4gPiAt
CQkJdWRlbGF5KHdhaXQpOw0KPiA+IC0JCWVsc2UNCj4gPiAtCQkJdXNsZWVwX3JhbmdlKHdhaXQs
IHdhaXQgPDwgMSk7DQo+ID4gLQkJd2FpdCA8PD0gMTsNCj4gPiArI2RlZmluZSBfX1hFX01NSU9f
V0FJVF9NQVhfSU5MT09QXzEwME1TICgxMDAgKiBVU0VDX1BFUl9NU0VDKQ0KPiA+ICsJCWlmIChh
dG9taWMpIHsNCj4gPiArCQkJaWYgKHdhaXQgPD0gTUFYX1VERUxBWV9NUyAqIFVTRUNfUEVSX01T
RUMpDQo+ID4gKwkJCQl1ZGVsYXkod2FpdCk7DQo+ID4gKwkJCWVsc2UgaWYgKEJJVFNfUEVSX0xP
TkcgPT0gMzIpDQo+ID4gKwkJCQltZGVsYXkoRElWX1JPVU5EX1VQKHdhaXQsIFVTRUNfUEVSX01T
RUMpKTsNCj4gPiArCQkJZWxzZQ0KPiA+ICsJCQkJbWRlbGF5KF9fZGl2X3JvdW5kX3VwNjQod2Fp
dCwgVVNFQ19QRVJfTVNFQykpOw0KPiA+ICsJCX0gZWxzZSB7DQo+ID4gKwkJCXVzbGVlcF9yYW5n
ZSh3YWl0LCB3YWl0ICsgKHdhaXQgPj4gMikpOyAvKiByYW5nZSB0aWxsIHdhaXQgKyAyNSUgKi8N
Cj4gPiArCQl9DQo+ID4gKwkJLyoNCj4gPiArCQkgKiBBcyB3ZSBrZWVwIGRvdWJsaW5nIHRoZSB3
YWl0IHRpbWUgZm9yIGV2ZXJ5IGNoZWNrIHRoYXQgZmFpbHMsIGNhcCB0aGUNCj4gPiArCQkgKiBp
bi1sb29wIGRlbGF5LW9yLXNsZWVwIHRvIGxlc3MgdGhhbiAyeCAxMDAgbWlsbGlzZWNvbmRzIHRv
IHByZXZlbnQgZnJvbQ0KPiA+ICsJCSAqIGV4cGFuZGluZyAnd2FpdCcgaW50byBleHBvbmVudGlh
bGx5IGxvbmdlciB3YWl0IHRpbWVzIHBlciBsb29wIHRoYXQNCj4gPiArCQkgKiBlbmQgdXAgZGVs
YXlpbmcgdGhlIG5leHQgY29tcGxldGlvbiBjaGVjayB3YXkgbGF0ZXIgdGhhbiB0b2xlcmFibGUu
DQo+ID4gKwkJICovDQo+ID4gKwkJd2FpdCA9IHdhaXQgPCBfX1hFX01NSU9fV0FJVF9NQVhfSU5M
T09QXzEwME1TID4+IDEgPw0KPiA+ICsJCSAgICAgICB3YWl0IDw8IDEgOiBfX1hFX01NSU9fV0FJ
VF9NQVhfSU5MT09QXzEwME1TOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiAgCWlmIChyZXQgIT0gMCkg
ew0KPiANCg0K
