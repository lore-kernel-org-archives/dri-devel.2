Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CBF606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 04:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RtcUJqyU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 304A210E3E6;
	Thu, 22 Oct 2026 04:42:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C85110E2AB;
 Thu, 22 Oct 2026 04:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792644116; x=1824180116;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=aC0IoVujE9uuGL88CiWwQFE5wX74pO8PYG7e8LLwGoE=;
 b=RtcUJqyUFsUCIdi+UomTxxRtKscfuhMeyz1WuUYvE5+jo5Cw0riMSBp6
 YV2T3ZKxzNDtv7RdMygVFNMmtkhwugCex7xA18eNtQE2HSeCDRX13vW/+
 pYq9obsvwbNovJWuO+gX82nB+nqGQ7WE09FbcAZ6lGUdrNAPUInHB8sWS
 LKIuGVonWVA4L1UxFVZVB564Xd1EZMmOCpTf7nifu0Yz3ookOQZF2ZOKZ
 KvowR5GOWlqDVTqePgFDll7eeQEl6O2eLR752qRtlpyUaB09PCEcRcxPI
 hK6baSUZ8aX2l9nlAYTUGqUvY1vbdLKatbkhqrWbUBpW79QHIY7n0hoo+ A==;
X-CSE-ConnectionGUID: oHhzz95dQQyZCT9Slx2qTA==
X-CSE-MsgGUID: K8JUZQraSk2UC8igVFX9Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1392646"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1392646"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 21:41:56 -0700
X-CSE-ConnectionGUID: KRBrTIcVSTWIKwGhGvzDoA==
X-CSE-MsgGUID: sOB8oxJsTj+/xzhoU30INg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="5115781"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 21:41:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 21:41:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 21:41:55 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 21:41:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tk5NQFAV7gnWrz4YWsOqsw8ppP29BimCsSj1SpOgoojsSR2GuaYTa9AHSlg6IECmVB/2v3xGjEdcxNz1wn4IoVsrd7538gmTsPVDErU6vH9tj5Hu0l12UhWKomU+fkEklL+uIyTcaSKMEodMPlydMN/1NDBNnAi5l86zuK9DY0aswhzrLvs+sNr5YdLgfL3JCUBcqr9R1V+6h9tCfEGOFAmNaptkAh+yl7i77E7ks8Y+Lr1WbzbFFoj4myhAonVgup6Mqi+708G7yNGI4FLb9gNeG0CTL2VFyIc477VrpSzHJxtAyDC0bYTll9suba0sYwycnOp+LJE3mDdu4uKy0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzZsuIiBsF8VoApb8OfCqrK0QNrH8S2njTbUD+F0uyw=;
 b=PwFlq5oHkv4qqwTfIONY7dZFKId6nMJFFmDpdSagnNx+8kW4JKY7gBhmGGRtxL6U6/LvNQ0UJm+ON5cprJIxvxsEt5F/i1hC9b0JK4QaFL0nFk7QqbfuR7/MXP84mXKPneaw7IxrP69cYUmpWEnDQ0Ilc+rAj7WqxKw+AxZHki/4YtR2fu07WT07O9VehJXkFrMkjdr01VwVokK/jChYMIFkKpWvlI3VVG4bRts5iAgDAfkqvdBs1tHyiLrp93zpOxX2uivcnRbVaexpgnARAZ9WAxH6NOK9LOARAzH9ev+ntGAs5EOfn0K/zxUnVDDtoJd/XSS7rqOu8VDUSK+g0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18)
 by SACPR11MB967231.namprd11.prod.outlook.com (2603:10b6:806:548::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 04:41:52 +0000
Received: from DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c]) by DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 04:41:52 +0000
Message-ID: <aa357cbe-fcfa-41f5-ae82-fdc8cd79f495@intel.com>
Date: Thu, 22 Oct 2026 10:11:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] gpu/tests/buddy: Add range-bias pruning and
 free-order tracking tests
To: <sashiko-reviews@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>
References: <cover.1792599420.git.sanjay.kumar.yadav@intel.com>
 <acd1a30cc29c3d6efc14723cb90434d0e378ea0a.1792599420.git.sanjay.kumar.yadav@intel.com>
 <sashiko-outbox-180522@kernel.org>
Content-Language: en-US
From: "Yadav, Sanjay Kumar" <sanjay.kumar.yadav@intel.com>
In-Reply-To: <sashiko-outbox-180522@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0254.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::9) To DS0PR11MB8208.namprd11.prod.outlook.com
 (2603:10b6:8:165::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8208:EE_|SACPR11MB967231:EE_
X-MS-Office365-Filtering-Correlation-Id: f9fe479c-31e2-4e34-3d64-08df2ff6caa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|5023799004|4143699003|11063799006|261021121427099003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: PETOk48+JPTAODfgKji2zje1mNImV9xpytNvI7l5BZfVQMvfP+DoD+LY3jhThzG7LTfM/kX27OBiAUcdClIJWNx+Sswlwt2HNxL14rQ/7/xlvppIdNMkjz5uv+TxnqtkXTSAOPh+95f2v9XSaRLjG2R1CNjpbRXuxx3NCkHVI1EsFo1zGaaKo7xq+vhWpj/PQV2qNIvBwz9m88h8owZdnnvVzxp52OI/JyefvUO9vRivyXDu6YTvxXXAWKOJN6wEurLCv8bo0VZ6HyYsRH9UPsKHDWQ7IXADu2tmMk54ZEiXt7DtI60UDXSCiXoMg2QkujFMWDTIbpQmGBOVyWPFJFlCC87eGNuHhqJE3Hy2JI4nqtuNx4tvAUjEjjFQZxIKDjqAD4ZC3WpxbL5di5iH8cwcCT0ip8RXJhZaQ85cbPm9Dg+vTl/ne8BCzNVkk0b3oEbGys8b9dJ2aq9cKfxAC6vOfaVdQgsQl6waFVDiGtr0rGLxwvTH/eH+BEphIfdEVE8D7lI73Xe/KOTViBbRJTYCd7B8oXd6bKEiVmgAIKC05yz5dXQu6yRUOxM6HYME0496ROLgSUey2qgDnHEwFIaxLL8ecFTknuZweeGx+/MDa+p73kY3m8Tl1F3VOfv497AgL8QQiZDx5PQTn6HZlTxzsMKnMQUnlcZbpmoBP3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8208.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(5023799004)(4143699003)(11063799006)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3R4bXVITDdOUzFrNlpGRGkwMjNQYnNzTVY1NWkvWERqRHBuZlhTR0F3SHlQ?=
 =?utf-8?B?b2RaWXBlblNDb0pLa1Zhc25rSFQzSndXYkJtMzludkxQdzBmWmo3bXppV3NC?=
 =?utf-8?B?bW5kNVdOVVJ2N0NDSlZTU3V5TGhMNk4ydkM0M1AyRm4vV211YnhMN1haVko3?=
 =?utf-8?B?MDNUOFRRUFJWSnU3U1QwQVhIU2JoN2hJVXVmTlcxdDhhU0pPZFR5NmpEenIv?=
 =?utf-8?B?STBNenhwb1RCOUtFRHZibThiK3BDd1NER3k2Rkc5L3k0SW9wNHRpYXRUV05x?=
 =?utf-8?B?YlRyaVU4MnE4REZkMHpmVzE2MStsZTBpWDBFejNoTEVUS05JTzEyYU9WVzFP?=
 =?utf-8?B?Z25NV3lLdzJKcHpONkZTUytKM01JbEh0b0I3T1l4K2FvclNLYUViaStrYVVI?=
 =?utf-8?B?WmFhSFlBaE5mQU1zYThQMWxubzU5NFJOYUFNcWpNTEhkTEcxaVdFT21zUG5Q?=
 =?utf-8?B?ZStiSXBZUTBxT2ZXeVpqdzRrdGpqeHkremFNSDg4YXROYkpWK3NzdW5peGFX?=
 =?utf-8?B?SHFUTUlnTE9PVVhQbUtSRmc5dm80b0hGbW5qZDZ3bVFlNTE2aDFhYXpHZ1dr?=
 =?utf-8?B?TlhYZ2dYSWFGUUZFU3JqZFpmOTF5Vm9CUDNIY2ZPOGlpTXNQRWl2amRJa1h1?=
 =?utf-8?B?NXBRbmxQN09yTjN6SzFQcC9nZEtNTXpabjdCZUhhKzMvbXZxdlpoa3JXWTFB?=
 =?utf-8?B?VzJwR0kvQkRPTnBVTEtLdXBhb2NVOGdUbzZCT05YR2NJWndXUnkrNWZUTy9C?=
 =?utf-8?B?VDM0WUVWWENFRkxlc1c3Qm9CZkdRYU4yQmh3ZnlobmRWMmlnMWFKSFlSMHN0?=
 =?utf-8?B?MnJ2NEFuYjQwY1ppVm9rWjRQTGNNMW5VbFFsKytrMU9yc2NFd0srTXNZQ0hM?=
 =?utf-8?B?L2RtWFFvWmU1NWdUbEtqQ054SlNKbEViRUxGVkFvOUhVTG96dyt0RC93SHNM?=
 =?utf-8?B?OXFSL09NMSsyRTdtN0QvSU5FSlNhbXZWUjQ0eVJvd0F3dkZaR3FBMEpoZnhm?=
 =?utf-8?B?ZlVzK3FydE9PdUxXZ3BHbDVxOXVYN2IxdkMwaVJsMi9ZcnZLVnhlUVFERVVG?=
 =?utf-8?B?cTJ5R2R1RDExaFJYa2RDZlVPbTFBMFNSU2Y3ZlBwbDFFMVlLQXNXQ0NHWDVW?=
 =?utf-8?B?Y2ZFYkNWZ1lrL2JCYTFRdTlzTnRzNjRMZXROUUNmWklaVWxnK1E2QnFPd2Rk?=
 =?utf-8?B?MWl2TGFWUWNlSlFqMnRTbk9RcVBlMW8wYUhVQWVYaTdsTGZOelM1QU41QmxX?=
 =?utf-8?B?SExqQXI2TlN5dkllRTNWYTRSSW1NMmg2ZmlCd2RoVlFDQzNzbmRnbWFUcWE3?=
 =?utf-8?B?Sk5YWHN5SGdBa0pQVTJVelZ5b3ltTkJlYWhzbkcxanVRNnlMa1Y3elBaQW9T?=
 =?utf-8?B?Y29mU0hpUm5wV2VEM0pJSmM1aXJRNHZ2Q0I2MXlRSERZOWJZTUltcnptUWh3?=
 =?utf-8?B?OE91MC9aTlZTTWU2WlIwV0dmT2VHSnlmM1drblA0UWhFVVI2bHBiTTNzdUFZ?=
 =?utf-8?B?cFhUQjlxTHhWY1FGOCtCdUxBY2xoSWtCTW5qUXJzb0Q4NVl3YmVoUnBjYjVK?=
 =?utf-8?B?M1ZUMXJidy9HWlRTVTBjd05kNi8xM0pDZ01KZVRpR3E3ZUhlakNKOGFHRE5r?=
 =?utf-8?B?Tkx5a3h2MFZaR2RZYk1BbURKQWMxOEp6VTE3R3BQandlaWxXTENRS0FmRGQz?=
 =?utf-8?B?K2ZkYUp6R1ZtVzNrME0yZWhIeXp1L1RnSnVRNFlqb1lNRi8wWHhCMUZ0UmxF?=
 =?utf-8?B?cHRsc3hZeHhpd1J3RjVqRWF6WkpiSEdLS1AzWnpTVzA5L2tSa2xNaDFlZ09J?=
 =?utf-8?B?cGg5T2owYlJybzNXMXRJelE5cGJMM2RiNWtjekd0QWZnOUplZ2pseXcyaVI0?=
 =?utf-8?B?VjhEckRzMmtBTFJrT0gxblhHOVBOWCt3QVlMYXB0S0Ixc2hwWHhyY2tPUy9j?=
 =?utf-8?B?VXdGYUliWExJajhmUWUxeU9kMmZ0K2VHK3dQNnlnVzRqaExuY0xVWktCV2kv?=
 =?utf-8?B?NUtlUGlhY2FaY0xnZFdBTkU5TmhoSzM1eEpJMEo3T0RuSm04MmpQSUJxdlU1?=
 =?utf-8?B?d3BOQ0xENnduMkpnUlRHeVBhOWFSSkljbGVpNHdVd1VyV0loUGMvdTl6ZjdF?=
 =?utf-8?B?R2hWM1VJQXlzRko3SUxUZ3g3OXQzUHVaUFFiNlRPUDRLOHk2aW5LdVdlNk1D?=
 =?utf-8?B?K3lJMW1jUWNzcjJpTSt5TWY2bVNyN2lTMU9YKzlVSmxIR2IzTEFsSXNGVGJX?=
 =?utf-8?B?WExCeEJMRUtWMHFXeVZUejY4SFh1L0FoMGVtUlAreFhVdVNOK1pCQUV6YWlU?=
 =?utf-8?B?TUo1M1dDZlhQdEt1N2I0SUJ1VHBUUkdDNUZGQmFZWEJ4MUlrVFc2WlAwVFlT?=
 =?utf-8?Q?eihstM7iRPv+W4lA=3D?=
X-Exchange-RoutingPolicyChecked: cAq04JbuHARWVGDr5f5d/7cAStRcBJK6uTUPn4UpXxXaz9K9YcZwjHE41iNqDRwAOluFhz8KRXXFnipMNGFSRu+4XJa+KSqwXtds65QZwvMZj/neILiVMvqNBkSijL6Ph8T8xmgxzoU8VGgKm77u+LA9zvjlq1FLp7/gm35JCmcovuctOhKTSkr0FRQTF8FvEL3n5jTZF6/lg1QFF0Cw7Zm1NdcxPHwaW1Cz1avdLbRBlhjQf1yMqHc64s53vVC5hVipzGQeuub1NXQGxGII+xsdtlodHaStLGFdjeh4bNp/gJpF2SVnqclR66kMzMyFw4vS2rDTzKUC5usmLj1Kjw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fe479c-31e2-4e34-3d64-08df2ff6caa1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8208.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 04:41:51.9441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6q1V7AKs6FX842gTuNwasJkdmLQD0YXhLjwJGuMJfSMV7hknFJftYFJV0AoT5cQhTgyd3Ri0nlSLWPtkEHvNw3mkqHt+oI9+sMkasBdUvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SACPR11MB967231
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 21-10-2026 22:54, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] gpu/tests/buddy: 64-bit division in gpu_test_buddy_range_bias_pruning()
> --
>
> commit c218b91af95d861d31913d5c9b3ba0681e319523
> Author: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
>
> gpu/tests/buddy: Add range-bias pruning and free-order tracking tests
>
> This commit adds KUnit tests in drivers/gpu/tests/gpu_buddy_test.c to verify
> range-bias subtree pruning and subtree_max_free_order tracking across block
> allocation, splitting, coalescing, and trimming operations.
>
>> diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
>> index b75d32ca6ca0a..4c7e823d57892 100644
>> --- a/drivers/gpu/tests/gpu_buddy_test.c
>> +++ b/drivers/gpu/tests/gpu_buddy_test.c
>> @@ -1586,6 +1586,311 @@ static void gpu_test_buddy_addr_to_block(struct kunit *test)
>>   	gpu_buddy_fini(&mm);
>>   }
>>   
> [ ... ]
>> +static void gpu_test_buddy_range_bias_pruning(struct kunit *test)
>> +{
>> +	const u64 mm_size = SZ_512M, range_end = SZ_128M, chunk = SZ_4K;
>> +	const unsigned int nr = range_end / chunk, window = 1024;
>> +	const u64 holes[] = { 0, range_end / 2 + 3 * chunk };
>> +	struct gpu_buddy_block *block, *hidden;
>> +	u64 first_ns = 0, last_ns = 0;
>> +	unsigned int i, misplaced = 0;
>> +	LIST_HEAD(allocated);
>> +	struct gpu_buddy mm;
>> +	LIST_HEAD(tmp);
>> +	int err;
> [ ... ]
>> +	for (i = 0; i < nr; i++) {
>> +		ktime_t start = ktime_get();
>> +		u64 elapsed;
>> +
>> +		err = gpu_buddy_alloc_blocks(&mm, 0, range_end, chunk, chunk,
>> +					     &allocated, GPU_BUDDY_RANGE_ALLOCATION);
>> +		elapsed = ktime_to_ns(ktime_sub(ktime_get(), start));
>> +		KUNIT_ASSERT_EQ_MSG(test, err, 0, "range alloc %u failed\n", i);
>> +
>> +		if (i < window)
>> +			first_ns += elapsed;
>> +		else if (i >= nr - window)
>> +			last_ns += elapsed;
>> +
>> +		block = list_last_entry(&allocated, struct gpu_buddy_block, link);
>> +		if (gpu_buddy_block_offset(block) != range_end - (u64)(i + 1) * chunk)
>> +			misplaced++;
>> +	}
>> +
>> +	kunit_info(test, "first %u range allocs: %llu us, last %u: %llu us\n",
>> +		   window, first_ns / NSEC_PER_USEC, window, last_ns / NSEC_PER_USEC);
> [Severity: Low]
> In gpu_test_buddy_range_bias_pruning() in drivers/gpu/tests/gpu_buddy_test.c,
> first_ns and last_ns are u64 variables that accumulate runtime nanosecond
> durations. On 32-bit architectures with CONFIG_GPU_BUDDY_KUNIT_TEST enabled,
> won't dividing them directly with the / operator by NSEC_PER_USEC emit calls
> to __udivdi3 or __aeabi_uldivmod and cause a link failure?
>
> Should this use div_u64() (or ktime_to_us()) instead?
Yes, this matches the kernel test robot’s __aeabi_uldivmod failure on 
32-bit ARM.
I reproduced it locally on 32bit compiler and confirmed that replacing 
the direct u64 divisions with div_u64() fixes the issue.
>
> [ ... ]
>
