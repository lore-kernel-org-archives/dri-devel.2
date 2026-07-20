Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0500C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:18:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A5F310E7F5;
	Mon, 20 Jul 2026 08:18:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LmbRgNQi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EF9B10E7F5;
 Mon, 20 Jul 2026 08:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784535538; x=1816071538;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=hnngrHFE9XX5H5dAy+zYgph/IfzSPhSSvCWxoxsDnpA=;
 b=LmbRgNQi+k9pHWcyW10VsYauaoZN88sODijVUKRg88Fi3iL4gbmvvewO
 WVkEnav1NH+0+LKoxM2ZuGWaJpsWP8yUbRFcri55adOVGA7kPznWpB4ss
 ANmVYPMrGbDfKIAzy5P2oudpVVmgMSmpZVvF2XPbHT+2TYcQRFm6714TI
 OzDhuNBgxmE4Y3EPI3z0sQ8CqHUAliPqR4zmKS7eoyDLGrL1DX+MX2FkP
 ORKXt+z5CkARI0/VHC0rabTgNWBwJQfwNC/ceRH60Mr+EQR1BMbpbI8ei
 JY7kYkP/5B7ZoVBKofCYHjWK2hmfP6qRhTdtxGFNnzr+5oR9GjKgXhueH w==;
X-CSE-ConnectionGUID: gEp0guypTiuw/gVJrZnioA==
X-CSE-MsgGUID: wt0eXS32SiKHgkA3qlS6Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85309044"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="85309044"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 01:18:57 -0700
X-CSE-ConnectionGUID: 5LZrPY9fTKSyT7kAinwWKg==
X-CSE-MsgGUID: /cvk9hI6R2iNMpZkEAqBPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="262356246"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 01:18:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 01:18:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 01:18:56 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.24) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 01:18:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrJcH96LX77t2Rac3h9VK9PxWY7CnYRY5l0P+7hAlGBwdfreBe1w8frInHcitHYysJF6m81HlOnPdCspJtNTXf2+S5Trnhmob9Q/+Y17X7/Q7mlVAJQnRoLW1EcHB74p6sZuwU1gsZZjPuZl7Ie0S7RInkxMRQ/wyDaYrD8TccU4i6UE4dOYZ0etYw1SCLIueAYvUCrk+CooRCD4KeNeJTMGZCUkqrKjxQM0KlV07kQVl81qvtBy2ShQUsH9IJMgHYD3iCqinMome5T+rRsBGz+w+J7OJv+3DA19xxbmo03nJp7glAybxymmY+4JofISG6f7Q0IRinSzQlY7Jci8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBwZoIbBAtOhDbW8ew0alBmWEDYyZbVakiQNqFp3eZM=;
 b=xq2kAfuKdXhSWlVwdQQYIxE+P4t1gEMkRvMJt1IKHE71guofCPyoI7KUvqRQ5IjeKuN+mKfj2NDobSw0S98fFb+vU/TOdvVrvKL6/JC2AkNPzGTlErWREx9iUHNpMU8JGQ8+/bdi5mQXVu13kTKpFPeWxkPtkawv2wqkUxWOyucnHkTccEyiKAVvPZ0edLmQ0TMjmWXCUaQ+2jyp/5DT34dXTmTiARoeFSb6EDEj2+MyIauByUEPswkHzCBCpp5V1Qo50sz6Ixu2czAspBxSpBPwNaonObzhf8oIpy88yvp2oSdiMpIsHKmWjJJSaj7cZJsefPAGsVyAIPml5RpMmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by IA1PR11MB6146.namprd11.prod.outlook.com (2603:10b6:208:3ee::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Mon, 20 Jul
 2026 08:18:54 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0223.013; Mon, 20 Jul 2026
 08:18:53 +0000
Date: Mon, 20 Jul 2026 08:18:42 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>, Andi Shyti <andi.shyti@linux.intel.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, "Sebastian
 Brzezinka" <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v3 4/5] drm/i915/gem: Read and shrink memory in a
 separate function
Message-ID: <fpdox6uyoqnjx7nat427miehqtmhermzcpdpqfeystrmuwsgoq@sxbrby7ofmma>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260713095812.1014365-1-krzysztof.karas@intel.com>
 <20260713095812.1014365-5-krzysztof.karas@intel.com>
 <8979872eac4f9eabb499f074b66583013f6f524c.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8979872eac4f9eabb499f074b66583013f6f524c.camel@linux.intel.com>
X-ClientProxiedBy: TL2P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::11) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|IA1PR11MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: e767670a-e9d8-4af9-b374-08dee637897d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lCri2khtcfNSUqEDE1lax8a8CsT+F63jV7LfOqTkIlAoRgyRh9gwwci3xMvIvmS7qk6Gwkvv853z67UHuBr3OoToIS/kk884Rnl4EOoGL41WyP1NXB8B9Qu7S7j+K1QaOy9XGlcTbQERIYdQREIE4xtzTjEjBWdtEJu5b6fXGwLwB9KPO1GGfgR/7QwNao9bXFkUIkjuNDju84xXr0hcwc+5bATSPTkLtYr3Tbo64mEUAfOPoPdAlsCszb1aQQ/X+WzSWp4z9iPQdQW3IRX8bodWLQMRK2Hv4rVkNGv/HVneBNY85t3vTHriylRe1NV9Btl3yhLetC/qSC+jyQaRJksdDNJCfVgKU5s3/ztH4ok/4CSXKN9btseiCA7T0EE5JOzMVGRyYsv5jpR1mdIrvH7yYF3jNEIr6BwfzX3tMApBLQZRwH/bFUxg2X5ylab4JfbGvU8M6zVlN9EhWNc79cNx/nON8bz82wYY0/Gge3hqcJ97L+aQkkfAzYa8tjDWtZAdEoy2Ya2SxzpNS2DSjg4V8sxHhYkSoIv/T3aki+knyaJm4kkWldRKHtPicVbPQiYxJnKgbGHxviGNbgVtndz9mA2zffRphWD+bL0XAZqc7mFusPbthxUw3TTy/P1u/xZ3Q0DYSR1Bw2f3LjJ32yeu1WjCs0CZWgDEPZO1Ht8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmVTMmF5Wmw3cGI0MVRSZ0RFQ3hRWjA2OThYMVZRclNlSUIwdkJTbG43NFRu?=
 =?utf-8?B?N0JSUi9aeS8ybW9LbmtieGZ3a21ERG9SWnloUlhUOVJiOUJGb3hjdGFIY3Q4?=
 =?utf-8?B?SVVhTzM2cFlYZU9GZHFJRUV6akdlUGl5aVRhT1VtY2RZYnJWWkMvdEVXbkdR?=
 =?utf-8?B?RXV0WTdPU05EYXdTSitHT2VQR21ZTlpBcGtqR1F3UFJYd2dZakQvMDNoa0RZ?=
 =?utf-8?B?MFg1ODMwbWptbmxMemdkSEJvekVDZE5CanRXR2YzSW8raDljYlFaUHJvYVda?=
 =?utf-8?B?Vnl2WXZmRFl6OU9pdnZLVUFWdGJHK2ZFZWhaYkM4V0paTFIzemtOVG14UU9U?=
 =?utf-8?B?a3QzWnJxVWFEOTZjamE2UXZPb1RWcWhMNHIxZFdOM0hQbWtFY3VhWG84UnFE?=
 =?utf-8?B?WUlHZTRMQ01UeitmUnRYakx4UzR4SFRHQWc1cFpxOFdzb1RPZFA2dUhNTWdy?=
 =?utf-8?B?TWpEUjF5UTB6eTJKckM5MTkvR0VoMzkxNG44RjZoRmpYbEFqS2V3UXBvYzZa?=
 =?utf-8?B?SUtiQTF6RHBGbXBNanN0QnlhTHhYT1FILzNwdXRLc2syQlV6SU9iRENqbGR3?=
 =?utf-8?B?RkJmTU5oditEaXUvUk0rZnBWNHFINDJJTXVpd0FyaWFGNndmMHBlNzZYcU5J?=
 =?utf-8?B?RElWYUpmRUgzYlB2bmp5NHZ1Sk5LbG1HWWwvQm9sazBUTUZXYVZkWVZKQVlt?=
 =?utf-8?B?M3RtV2svQkpGZHMxM01mcUp0bzdzQ1R4Vjk5ZXRRYXJqbG5iMk5YZTh6aHFY?=
 =?utf-8?B?U1lFZzJEYTYxbDJJc25IVzRidFNSdUh1ZU5md3VFU2szNEhtblBpSHI3aTVW?=
 =?utf-8?B?d254TEZSNVlEM2YrZ2I1NWJ0aXBUR2ZhZXlCWFZzVFZOOG1RQk5TY3VOczdW?=
 =?utf-8?B?eXdyNk9CMktTMWh0VEUyUkxZVHFjTHBhWndIRkE0SklsWER0cGp3OXdZWmk1?=
 =?utf-8?B?Q2JrY2paWDcrREUzUnM1NlFWTnhmUkRkeGdTdTdqOE5oOTR1RjNkV1IveXBC?=
 =?utf-8?B?UGg5RmlPK3U1MzhhbTlLTlM0RXBTNld0VGo2M0dxa2NhTUVpbDIyMFpXcHVS?=
 =?utf-8?B?eTVlL3N5cmZ0eDduVjVpSnhJd2x4VjVBWjRDOUJJYnV4a2s0SHlzVGVpUmNi?=
 =?utf-8?B?Z0d1MitFZXBaRTlXdDkwYTROaU5ZYy93Zmd4N3U1WkxKUmgyZmRPbGFsbEhn?=
 =?utf-8?B?UWhnSit0OStZcGpzSVFSR2pvdDczRTJYd3l2YkdGeUhyRkRGbUk0WjBMUGVN?=
 =?utf-8?B?bkZ1Y1JFZ0JQc0pTMHZQd01FUGpOV2RTeWJCTmIydkhoREJ2WmYwTHJMcy9Y?=
 =?utf-8?B?bXBLWER4ZXBkV0ZmMy9BZE5zUzRRaHlsSytLc2czaGFQL2YxU3JmYlNkajlP?=
 =?utf-8?B?TzJzcGNjSEUyVklnbTlSbVhuaGhKaDFlZmZ1UVYzK2FpOFpIYmF0ZjFqcHYx?=
 =?utf-8?B?L0VRUDhyTmcvelkxMnMyRzJBbU9qcHZIeVlVeVlMMDhhbE4wZU1YWW1Rc3JP?=
 =?utf-8?B?WGF1dktHZU5CWGtXUVJwMGtjL0NiY3owYkZ2djF3TE5IV0ZENmVZdzUzcS93?=
 =?utf-8?B?R1VEci9GaGp5NWk2bXNCd3B5ZzBESVFOdkhPNHo3emFjeE55enBmcDZ2Qm1Y?=
 =?utf-8?B?c2d5TGtnUFRQanhLcXB2M05oYlNzUGtqdGdsSnJGS3Q3aUpzT1gvVFExRERh?=
 =?utf-8?B?TG9PVXMxK0VnN0VMYTlwVGNObUxMQWY3TWdDdkozWFZBY01DU0lmd2ZDUS9T?=
 =?utf-8?B?TWhmMTBMcHlqYllKWHB6cG1JenNRUUJvVmpNdDNuaTZIOVZhbVBjR1RHcW1r?=
 =?utf-8?B?KzhoQ0Vyd1ZrbjNjeTY4eHE5NkYwWnVvYkZiUTU5YUZhOHFmclkrQ3BBMDBD?=
 =?utf-8?B?Nm9SRFU5cVJxTzVWbFNMVzNXYnR5em5maCtpd1NsSVdleGJ4U2E4U1AzVGFX?=
 =?utf-8?B?NDZGTDEvOUlUanFCT3R6RVlJWWpFczZ2Y2JGdUQycXFvWWRuQStIWDFFM3BU?=
 =?utf-8?B?RmJlYk9kS3NpV0RteFY4cG92ZmVJTVdoVStuaVRJZjY2R3JSMjdyN0kxbzM2?=
 =?utf-8?B?c2ZFcmk2MkdKK1ZBSGZ5U2JRS1pPOTlRNlJoNGpIQ1pwdXkwMnFzSmVSckhP?=
 =?utf-8?B?TmRMMkM5Tmpoejhvdk9JTXkvTnVxTFk3OVQ2RzZIcmx0SGFIek1uWXNYbEpu?=
 =?utf-8?B?SWt3RzNoVWxFYWtvaTZvZktrRnN4bG5FZTNXZUhBRG9PdFB2dDZ1QkswMHVz?=
 =?utf-8?B?eVBYQTZvaW41THJmWUdMN1dBUklVWTRiZjVNSGdFRWFvMysyU0ZyejFHYVZC?=
 =?utf-8?B?aGdUMmgwRUFIcUNVRlptOWxndGdvZ0NFZU0zVlNiS29mWGJ5UGtuMWJFeENx?=
 =?utf-8?Q?UvYXqekbeS/l6AAQ=3D?=
X-Exchange-RoutingPolicyChecked: lJmoq2p988YygNelTkiUG2T90Nvv3nwyja0Cbe7O/YVGjxfjsBNNtaOg4K298c9vL3vQLGkUuPcS/HSX7OfdQa8hmR5jWL1i5GLz8eaMe3ANdHVdA8e1wIzlLiJyPjovQgpM+axD9ErWoujE9oAAByYVb9l7rxu67Xf42LAP7mdvCRzMWPdVZr9+Cw1liVIkilGgSmlnwDafT7YTefZo5wd9EkWiJYGluxn0NpLUhXiaJiEjxPsL8Ku9O3HSZAUKIBS9PTTu/AsJEFBCDoJU+Mm8kh3hFe02ZxTy0G4AVpqcrbu02xyVD8odSKENXZ4CmB4ry0abrNq3n2Oy+n+Hog==
X-MS-Exchange-CrossTenant-Network-Message-Id: e767670a-e9d8-4af9-b374-08dee637897d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:18:53.9004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Zb2OlgPpoLWzdo3qQzdyCsr+rvp3JNcSTZ3HS0Plp+weh7Dlna1c5axcvvkj7H3AOiHjsQTgaJGXdZzMYq8a7nl8BJPgZxTlClbz9F6as8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6146
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

Hi Janusz,

On 2026-07-15 at 17:31:56 +0200, Janusz Krzysztofik wrote:
> On Mon, 2026-07-13 at 09:58 +0000, Krzysztof Karas wrote:
> > Continue unloading shmem_sg_alloc_table by placing reading
> > folios and shrink call into a new helper.
> > Make the loop a bit more reader-friendly by removing iteration
> > over a structure and replacing it with a do-while loop.
> > 
> > Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> > ---
> > v3:
> >  * Split refactoring and put it after the fix in shmem folio
> >   counting suggested by Andi.
> >  * Use do-while loop suggested by Robin. 
> > 
> >  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 102 ++++++++++++----------
> >  1 file changed, 55 insertions(+), 47 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > index 4a61b012fb6f..7c8de8fe0a22 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > @@ -78,6 +78,55 @@ static int validate_size(size_t size, unsigned int page_count,
> >  	return 0;
> >  }
> >  
> > +static struct folio *shmem_shrink_get_folio(struct address_space *mapping,
> > +					    unsigned long folio_index,
> > +					    gfp_t gfp, unsigned int page_count,
> > +					    struct drm_i915_private *i915)
> > +{
> > +	struct folio *folio = NULL;
> > +	unsigned int retries = 2;
> > +
> > +	do {
> > +		cond_resched();
> > +		folio = shmem_read_folio_gfp(mapping, folio_index, gfp);
> > +		if (IS_ERR(folio)) {
> 
> Going again through then unused shrinking and modification of gfp doesn't 
> make sense, I believe.  Could be avoided based on retries value as an 
> additional condition.
If calling i915_gem_shrink again doesn't give us anything, then
looping doesn not really benefit us here. We could do something
like this instead:

folio = shmem_read_folio_gfp(...);
if (IS_ERR(folio)) {
	i915_gem_shrink(...);
	gfp = mapping_gfp_mask(mapping);
	gfp |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
	/* again */
	folio = shmem_read_folio_gfp(...);
}

return folio;

That way we'd be explicit about shrinking once and retrying
folio reading only once. Reduced indentation would be added
bonus.

What do you think?

-- 
Best Regards,
Krzysztof
