Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E41B606A320
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m3TKCYfk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E38D112145;
	Thu, 29 Oct 2026 09:38:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A855112143;
 Thu, 29 Oct 2026 09:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793266707; x=1824802707;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yyKkdU01/ayouraxiF8wH0riCsg1tMHSvHsYbh5zK98=;
 b=m3TKCYfk5tO8DoN+KevUa1YjLxDnv+Nj2tLdeXl2iyDDn6xbwBUgM7zL
 vp6obLitH540umU4hxWxrKfdmaFNM/CvE8+ow9uSxgLUXYS7MwmwQ75dm
 2TG3xrb53yitGrtkt8p/WtCygA8Vk68oKHbeFBDTqxG5Dg7V862DPreBe
 CGfNa2WttmzzBlrxr1qHhvzbgdBt6qfCDzx6hlpqA9iw+w5Fr7kKyESMO
 Gh0j9WCOYzg3pmhNukxC4Vle8CYixzokcQktEXGth+hpEzAu2FugufMpM
 WzSvFhEIOtuUpAaOgh142i1u7Q+OH0Mnl+xva2ehW5rXKQufW/ckdIKNQ Q==;
X-CSE-ConnectionGUID: oFOGrKlZT3qPr8ZtjoxpIw==
X-CSE-MsgGUID: iJu58d+rRKu6VRjqNI/zdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1998154"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1998154"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 02:38:27 -0700
X-CSE-ConnectionGUID: WIprxqtPT6qRC2VQDJN1/A==
X-CSE-MsgGUID: l8e+Suk2SiOGZxpdmMYRfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5430530"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 02:38:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 02:38:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 02:38:26 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 02:38:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0PVjwON96p/+NkNJiP9MK1rv/2XNidaNyn1+b+Ui4i7F9RUbh+d/hSyndgRcuInXXY9g2IBeQyJvqwAQ9ZWTDRi3NSg/82hXzqSpfLl6hspPpgh6IOHSquN2/bURlj9bnbhvw5Ft5ohPlMBxvPO34efOQp54ApVz1uRqseV8/3oGrs9e8KyCZ9QzH3tU6ZhqBeYmZqv7+6t7s6JbAe6Bk2KGb43XFUoSpWJP1QIjwSmmjTSezspY4F2OdDTT3N7ntUDFPzW2YILThUow4AXwn0EVDXRADN/zY+QASwJQBfPikaH4ILZgM982xK4PAVokO1IBn+RKTjv7bFTFUEYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WchFdVowZX7goKXVDM9O3VxaCjHDKfk8NL2L50VBbk=;
 b=XbsMsCj3RF3Wq8AmX17Q5Rh5nw+n78XrqU0EJWKj1mKqhoRzSK7UF59TpNdIdUdE1roJnM+SmL8P5eiS4XMOMdJ+453la+HwJJoxaqDY0UKTLr81BHRoDuPbLQcGbBRKA9yY2TEjMNTTq4+8QKYJcbvvfP3JVXtd378yK8YN9PrOIGJ89d+yjIXZNkEWAR/i/EflABkF14qUyLQ1yxOvcpgTflglQZuGQ+Xb4vGR8DwxtY2w5ljhNJYYvVuX7HgIS7hRhAmGnJGb2GxCebsO9Bwo9/Z1IK9KoSOroWj7KvZvOCLwuHS4+PUFOTeMU9as+mff4vCUCeU6UXd27raOeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 PH7PR11MB6428.namprd11.prod.outlook.com (2603:10b6:510:1f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 09:38:24 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0546.021; Thu, 29 Oct 2026
 09:38:24 +0000
Message-ID: <63ba65de-4292-4f7a-9df3-f98fef5c88fe@intel.com>
Date: Thu, 29 Oct 2026 15:08:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/xe/survivability: broadcast dmesg when engaging
 survivability
To: Raag Jadav <raag.jadav@intel.com>, "Teres Alexis, Alan Previn"
 <alan.previn.teres.alexis@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Roper,
 Matthew D" <matthew.d.roper@intel.com>
References: <20261023173625.601113-2-alan.previn.teres.alexis@intel.com>
 <auFpdeRIafjgKSV9@black.igk.intel.com>
 <f7f8745978c21de8687e1e539a15f0be9f9d4a6a.camel@intel.com>
 <auLQCWmLV395IoS7@black.igk.intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <auLQCWmLV395IoS7@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0166.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::9) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|PH7PR11MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: 61204ade-f14e-40d7-45e9-08df35a06093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261022105027099003|261009223027099003|261021121427099003|261022075727099003|10067099003|56012099006|261026140227099003|261028144727099003|22082099003|18002099003|261026121527099003|11063799006|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info: rN7TeZU4PaI/aNNxxeKSeTyqGMkqAbT0igALG1wnOkUd7TJ5WOFTNWXRZCPVIzGE0o8F67iuabZ++CeYjanOR6gLbXnud6qxlMmFqiOt7k6TEsSuj1t4m3m2uouQZMS5ZYeYksnrOaG6q3iF4rvveX944WHJb7zkFD2IJTJ1Qi24RgutQ3kycJbDT7wEilRNuWLyxmdt5/dWDxYJTN0M9z2E6SkxEwgWm1wKKAynEd7wT+eCKXN3Eo+3tUp3Eh15TyYI3NeavEDhwVZi+DZfjLLJdwFc9EbNOPxi+VuZ6z45/x8XgvTo81IkUiN0ms4QtsSWtP/fNZKPxk2nxfrgiGUqqPHWvj6JgFEkRhbkLcDUc5qLEXtCqbRn4BNi0yaOG7Udkcf/jYf/wixIFCKKfkQBqZoUPRSYqscyVKuzOZBKNel82/tCykY9ndY1iwfaGGgzCYYaiUmSM7x1eHwxs0sQgxA3ixFqRztSS0hxRvdhHwTzzK8LiFsyZlMEtg/clnzFOD+nPlozQdDU2904t1DuIOqWApD5if2JmA6LOj4SvKfEDphPNYUrW/icGLqIUw57rd46k09mP8BML87TJ4xEMRsWde818E4LmtXutqa/xK4n13sxv661suL5y9RdqTnKkbojgb2wsW3lqQlLQ9V2ahBAfbxil8mQsjpxT3Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261022105027099003)(261009223027099003)(261021121427099003)(261022075727099003)(10067099003)(56012099006)(261026140227099003)(261028144727099003)(22082099003)(18002099003)(261026121527099003)(11063799006)(4143699003)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3BmbmJlYW9XOE9ITnUxdFpZeU00QVVjNmhYL2NYVmxiTlovSnNyaktwWG8w?=
 =?utf-8?B?TnVEMUk0cGlVOVZGZnY3bTVZQlJSdFJsaHV2MmhxVDNkYTBqT0dvem03WndO?=
 =?utf-8?B?bDNGRE93elpQSkdpTHBYRUlxTjRLOFNSREJxbUpYWWpHZ0Z6MlZLdzBVeVhm?=
 =?utf-8?B?Qm43UHVieUdMYXVxcGRCb0dnRklPUW1qMUlvcjhiQ01JOGI3MTQyQ1ViUWdh?=
 =?utf-8?B?blJkTHNIMU5zcTFvdU83ZHVPY2JQUVdCbnQrMGRLLzVEenBseVVjYmhvQlhR?=
 =?utf-8?B?NVBROERteCtYNzBkTU1hZjNYYnRuNDVMbEtsQlc0T0dVQWo3UEMrd2xyTFFo?=
 =?utf-8?B?c09KMUw0V0tpWFJsbW9oVS9LRE4wenB3ZXZRTmppWGJOZHRLUThKZXYwWkxL?=
 =?utf-8?B?M1JsbWZ5Y0RkMHJ3amdIcGZnNkdzdG1FaHFtWVc5UWM1d3JFN1Irbm1DQVl5?=
 =?utf-8?B?N2FhUTE0QUNqdW1qdks0bWxkNGtsMkpHZXdPLzNTMVBIM1A2YUpPMDBaaFYz?=
 =?utf-8?B?Tm43ZFNtVXBscm00dTl1VGRySlFVdHdveHpGaHR2OExVd04rYkR0VUk0MG9R?=
 =?utf-8?B?NzF1V05EdndEMUsyOVRQY0o0ejZoYmhQOGpvMkg5S0tUTTk5U3pJMzNkc0dv?=
 =?utf-8?B?Q3JyMytUNDVGZ0t1QXN5bk9RRnpDeXNReGhhUlVESHFVWWJWS1pTNmFjeXAz?=
 =?utf-8?B?Vm5NYU1ZSEQxYzVNcnc4ZEdpZVBObWswaWZTY09BVm03eFRqa1ZkWHRWeE85?=
 =?utf-8?B?cHFyUTVaa1RGaEQxRGhmamV6K0lHSmdhYklVZHF3Q212dEJ1THNVUU41dUpE?=
 =?utf-8?B?OERNeGVYNWtLcUpQTmlpblNTdFl0cnhKaFlIakM5OEpTQldRQlAxSm40QUE0?=
 =?utf-8?B?N00wR0t3Z3JMV1Izb2kxSCs4ZENVbzBhVHAwMDBwR2JHMktackIyYmJ0TlVp?=
 =?utf-8?B?djBEYU5WUXdvWEZqdDl2dm9YZXhHRVlVekhWLzRhSkdSaGwvUTl3T0VyZXky?=
 =?utf-8?B?UUprSzFick9ISkhhb3VhNzkzVm5MTW9Qenl5dW10amNqb013SmNKbmZEUFJz?=
 =?utf-8?B?ZWZvRTY2My9jMGw4VWJSa0pFMVNPcDhmSStRSWs5bWhlMFdVbVRWcGthMG5j?=
 =?utf-8?B?RENCbGMrdkw0ck93MEMyZTdNMkRpUnBGbWNwa2JXbXBIVGVYQnlXWUpkRmM2?=
 =?utf-8?B?SldHNTZOVEJQRU9VOSt3ZDRiMFZKZDE1S2xRdml0MGRTUWdydlFNeGlWbCtM?=
 =?utf-8?B?QTRxWDZqT1VxaWpIaEluRVJVL01ISHA1SXAxR1lNT2ZZc1hkRnFGbVV3eExl?=
 =?utf-8?B?YVB0R3BEVzVQczNvOFF4a0tMT2c3ZktlaW5zT2VvazZhd3FoeWxrVUJmbHJE?=
 =?utf-8?B?WncveVlRc0ZXMHAzWVkwQjIremliZ0YzYjUzTEZkcXRnTnRzeDRIaUplamtF?=
 =?utf-8?B?TUM3dmxXUHZSQTBnOU9jQ1JRdGhXNFQxQVlubWlSTC9zMGJNM1RYU0lNNk8z?=
 =?utf-8?B?Rzd1SGJjWEcxdFZtNUI1akRseUM3QnRld1NBQTFvMUxTdXFkUUxiT0JyN3dE?=
 =?utf-8?B?ZVluVE1wbmJNazl3cnc1VUg2SjgycnRUZWZxQWdOc1JnSG1rR09EZWRrdThD?=
 =?utf-8?B?M3VsTWdiTk1vQVFjYlh2SXF3MzN3V1BFNThCdmJCRGVMd2JpUFplaGQza1gw?=
 =?utf-8?B?cEw5YjVwZXF0Rm1HaHF5K0s3UVYvb2lxbkliL1BmaEY5bDdKeDkvTDJheW5N?=
 =?utf-8?B?MFp4aXE4WVVMRVYrTld0WkxpQnFlYW1GMnR0UXRaMzFueWpQRGtVcVpmblZt?=
 =?utf-8?B?UHJOSERKcEI1S1NkNzlCbjhsdGpmUGJaUjJUU3NFa3ZEc2NONUpDTmNQaldX?=
 =?utf-8?B?Y0lKQkhlWXhqVytaOWRlMWRMUmFhMEFBb2hXWVo5Y3FXVEIyekpFVDBub3Z2?=
 =?utf-8?B?QXozSTJ1OUNlMDErQWhpbGZ4emR6WGtpMGtnTThZSjlCUHF5N3FwV25JSzRl?=
 =?utf-8?B?Y0NFTXJWc0tFV0xWZ0o2cWJyQkpQS3ZCQVRaZFlocmtEekdjdEh2NFVUTDZ0?=
 =?utf-8?B?ZXFxSDNHUERucUxRRTY0aWhSckRqbm9MaEwxUzhRN1BwUTR5QWE5a3A2QzNa?=
 =?utf-8?B?Kzh2L21sOHlwUmhQb1hFVXlFTlYwUDNXT3B4bTlUWHB2ZHdOWjVkU0RocFBV?=
 =?utf-8?B?VTcyLzY3clVIMEgydGpMT0FYb1F4empoeWYyMkFwaE0rbFFZUkttYzBpVURk?=
 =?utf-8?B?M1BBak4yQnhLNzBwNGJjeENEbWo1dG1lMFNLTFdYVlUxamdjeXNvUVBpYVhI?=
 =?utf-8?B?MHNrOCszSWdJZ1RYNmlEbG05NTVnVS8ramtsOEF4eFpDM2QvS2xZQT09?=
X-Exchange-RoutingPolicyChecked: oeMySPGD//z8nY1Fj/sN5sgnd724F/Ftg3RAWFVma1UzJ0RUuirY+uvUXWOCjRhuwyGPlhfJ0NOEJ8SK3f5cDcr8cya52dWbHwjd0PUfei4PpBK+6KsT3lreatd4KVIeInf6sAnwwnrodUlu0vMskMX2PTdQjWprrEdciAW0nm72KUX1Mrfv652QvfJmYfhjZU2lWZYPdeMVLIWYd2gc7zJkVIYUr7PaIXdcS3rRH2TPupatqTYMqoPuIXnnXXAIL4EdQWox1wtqOgIt6U2qG2DL4JxN18eyqV+VJd0v6kNKL+W78YELMfMhsN6rcoYmI4P2leW6EmUXIcGNmS867g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 61204ade-f14e-40d7-45e9-08df35a06093
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 09:38:24.4468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiQvEupWVAe+XJfHRCBxELhAQYaEzjjFZNYE3asevk90j/iP3AGzcasrmm0EFGbNeexg9pgAKzum0gteg0HvZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6428
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 29-10-2026 10:18, Raag Jadav wrote:
> On Thu, Oct 29, 2026 at 02:31:21AM +0530, Teres Alexis, Alan Previn wrote:
>> On Wed, 2026-10-28 at 04:18 +0100, Jadav, Raag wrote:
>>> On Fri, Oct 23, 2026 at 10:36:25AM -0700, Alan Previn wrote:
>>>> Today, when the driver faces issues with early pcode errors
>>>> and attempts to enter survivabilty (when explicitly requested)
>>>> it may either succeed or fail (latter being possible due to
>>>> underlying subsystem blockers). During this flow the driver remains
>>>> loaded and completely silent. No messages indicate that it may need
>>>> or it attempted and succeeded or it attempted and failed, to enter
>>>> survivability mode. This patch adds some awareness in dmesg.
>>> What case are you exactly hitting here? From what I understand both pcode
>>> and survivability failures are logged inside their helpers.
>>>
>>> Raag
>> I believe the issue couple of us observed was unexpected value in check_boot_failure
>> called from xe_survivability_mode_is_requested. But as we went back up the stack we
>> had absolutey zero indication there was any error. nothing indicated we were even
>> in survivability mode. At least in that failure point case.
>>
>> I understand we have injected sigid code logging in the various other branches
>> of downstream logic (from xe_device_probe_early->xe_pcode_probe_early /
>> xe_survivability_mode_is_requested), however, I it would be more intuitive
>> to put a single message at that top level to at least indicate some kind of
>> survivability activity was directed, attempted and entered-or-failed-to-enter
>>
>> If you believe the correct fix should be to ONLY keep error logs at every
>> subbranch instead at the top level, thats fine with me too too but i notice
>> they currently don't actually convey the survivability state.
>> We have messages like "Firmware flash required" or "Boot mode enabled"
>> but nothing saying we are in survivability and the gpu isnt usable.
>  From what I found both success and fail cases are logged here.
>
>          if (check_boot_failure(xe))
>                  xe_log_err_fatal(pdev, SURVIVABILITY, 0, "Boot Mode enabled!\n");
>          else
>                  xe_log_info(pdev, SURVIVABILITY, "Boot Mode enabled!\n");
>
> These logs use SURVIVABILITY as a component which would appear in dmesg
> (not a fan of it myself, but that's unfortunately the xe_log design).
>
> I do agree that we could log something like "Entering survivability mode"
> somewhere if xe_survivability_mode_is_requested() were to return true,
> unless Riana has a better idea.


If we are seeing a pcode init failure without boot status failed, then 
that is a issue.
The only other way to enable this is via configfs.

SIGID logs do print survivability

<3>xe 0000:03:00.0: [drm] *ERROR* SIGID=103 FATAL SURVIVABILITY: Boot 
Mode enabled!

Agree with Raag here.  We can remove this log from 
enable_boot_survivability_mode
and add it in is_requested instead.

Thanks
Riana


>
> Raag
