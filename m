Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536FBC624C6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34FF010EAD8;
	Tue,  1 Sep 2026 07:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GMcBkqzN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B27810E981;
 Tue,  1 Sep 2026 07:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788246216; x=1819782216;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uGA4hdg3Y4k/5fRrT0xcwQH9O+tg5DnzQR4ZCoSYMD4=;
 b=GMcBkqzN2I2FjD5813yNk83MEprtjPQKRfyBj2M5jgY1aBhkakVSMSn0
 eYOTo5iHw3kEAlwurubhAC5fMtmf1llabv1pwzmq/e/6h/P38jYmzHsz9
 hM0HYvxwOfRa6aFRzfWcwTyCaE7zdnBch7qqG86EziY6T6po2kwbdNJjR
 Wrb7ingPpdnVcqFklkHm+RpOqoKJFvPSQ9BPLTE2MkeXOoHEN4QqjneSA
 58LRRHO+emhW3Zhf/0uAPDlhARuiZcQFFICS7bMBc8nUXKCRmFLK/oePY
 EARAev/EhN/2VDZcsPRlgEj3+m3rfKSUseL9s8PbwSSygig8TYxvtonUS Q==;
X-CSE-ConnectionGUID: rTv5SZaBRDWtgLo7aI3ZdA==
X-CSE-MsgGUID: TLRFX16zQa2M0uiMryXCAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="92532620"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="92532620"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 00:03:35 -0700
X-CSE-ConnectionGUID: UClcyEqPTcq/ra/cZbpNNg==
X-CSE-MsgGUID: Wtl1l6zFRpeJp8G4oyxxbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="292509067"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 00:03:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 00:03:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 00:03:34 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 00:03:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEwZy+o1Xkx84N7XonhWnfHOiBhc+yRPKBjNZMHmTfvmj3HYabiUBss6Uh17guZuGpme4cWvwWi9tHyHfycL8nN2/TuDxSixhsfFvdWTNbvCQq6XkDMxs1CRxuu6k4jE70z1oHIRz8xy+aLuioLCKxklv6J2qmhbdseYrz1F5Ed4ExRuSJ9vTSJHnf8imbjUb2sHSfDIgVpXKI7EBJoyjUODIuhescT/RZbrhnlNvWkZuvyF+8s0sh9UhZ2ShtVQ5WrIuhVkZ25kuftF3z6YVP6UMZJPgYVtCx+/xydZ1p5JZQWQtF2ENv1SaB5zbjVGHn1Kt7+ByBN+5i0+l8THOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDiY4tgmJ9eAwJon/Fhjd2QJuJzIslrAtRhZGJxSjL4=;
 b=twxwUcuSaiipbWsG1X2F9exUddO1Y0OuW+pHWhRMjVwtc88wQ6/K2vaqqLdZqWA+WY8ckV7FOz/7HSG67U/4AK3ypjSacUbOsnJp7Wn2OTQTn7pC4PE2zG+GNmZUqL6gd9j0XwlUzNjWsjJ/EAKT5FmFrSf/VrJjVjQgtOZeAgJ8KXMcDiyZtOfNf8zaPpHg34kwkJ7zr61sIb5Q7m1ZApEvtMs9SwUadPV+AxIeUkHqvIoS5NoCPov1zMVUWWmW2+vxEjuov7h4ZdVZ66acoMwHUUN3NtmUxX9tpIUuTMI9Uu7rtSsn0L1waCFT5ILsw2tYoqPjW1lCmnG4sHBXwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 by DM4PR11MB6165.namprd11.prod.outlook.com (2603:10b6:8:ae::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Tue, 1 Sep 2026 07:03:31 +0000
Received: from BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c]) by BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 07:03:31 +0000
Message-ID: <c69906b7-e72b-4ee1-ad90-19b039b57b36@intel.com>
Date: Tue, 1 Sep 2026 12:33:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] drm/xe: Skip PM notifier preparation for wedged
 devices
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <matthew.brost@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-13-arvind.yadav@intel.com>
 <apXrVcABmFQbBQOX@intel.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <apXrVcABmFQbBQOX@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b8::14) To BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5709:EE_|DM4PR11MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d323127-8407-4c9b-758d-08df07f721a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|4143699003|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: +Dl8Sat8vdAg7uZJvUWVBK2XD1rLQ6mUWy66L1QNE/S5p7Xl99odhAYP8zhM8P9iJfKJBOtGod/lFSYsvc2dwG5g/fPbbC8kNuFhIc84InMQcb06M2ZW2YvnW+1++aN/tc91v8F7gS9NKGhsKRXHYX7eiYMx74N28TOiWqZmgkYc+UxG2XRhNHin0fhPpaSjujUqU/VVL/wS3nBb8rFcGgomG+wsRSSEDdcdxUzjh8gK88HGJlxYoNRBRGXvmcrq7sGSb7pz4qz4H1atn5pPuWCFPAmZETuvYekBpq0MwxxftFwTBhTo4gIJpmU+6rROd3RwdDMRmVyHJTOTh0KaU3Lbbwb8TtuqUW1Y89hwLpc0rinpze7QtyUznd1tb8wouqTltGU2XpnzPVmon9CmsiErASdzyhQJn2iUDbihFndGLkQ+cZl4ea3eYpQhzTe4HEOV78eFp+s8/CVGacC1hKObeWUKT2CEGq2tmyX0CLlYCURxN8a8u4UO337VltF1Ui8fO9DIFkgPjU5Cmg0J3BMCW7hgDa+CW+PGopwLdWyeu0T7Je8NUmFU/KbUK8neRAQxqVuoOJpEBc7jTG+rvVbPj05Yp9xsm6y8pE+eHsI3jhmwGHamZwWa+Q1jDqPH8CYpY04Flsjs3ZFLz/vmAtdUooDUV+BqFbWmaoCaYrg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR11MB5709.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVFkc2RRKzhOUGJaY1RCblFLell0Y3dYcGwyM0R4dGIvSWdIYk5kdjBFbFRq?=
 =?utf-8?B?dURjbXR2aXc3LzZUWEJ6SWFmVlI4VWJYWVJVK2R1ODJlRVA2LzNDSVZVeVpV?=
 =?utf-8?B?VGZURjhqVXdCRUE5aUcrVjZTeDRFTHZQUm92QityZ0RVRmVFUDlQT3daNnJB?=
 =?utf-8?B?dVhBMVpEQUcwQzNsYzRhRHdockQveXpVaWIvU1hXM3VwaVZJRG1rRWpibE4y?=
 =?utf-8?B?MjBTSjYraldZNmhTajBqdkxPcjFSbjIxazZ6elFQUWxnNEdOS1NYeFNzdWhS?=
 =?utf-8?B?aTlsR1hzVkNHcjEzUU80Um0vL0d1TkVnbUV1MjZLR09ha0krM1N2bTUwVzFQ?=
 =?utf-8?B?czRWM1duSTA5dytCa202MmVnL1o0M3ZXNlU3TG84aXJjZnZDeVEvMmJkZEly?=
 =?utf-8?B?elJqQXVxOHFSY21ZVG5SU0wyTytOU2FCbURFdWxrMEk2M2hzOFp0dE5hK1dK?=
 =?utf-8?B?cWdYeXpyNnNKVXZncWw0Vkk0TzFJM05zYkJZQjhQOHc4YWZrbUYrVlZLMGpK?=
 =?utf-8?B?ZW9JZjlWTmFKTDI0eHVJR2RLV2NVV3ZlQUN5YzlINENrQ01IME5yaUllZW94?=
 =?utf-8?B?TUM3Y0gxYTVyU3BXTS9PYjBEZWNmcTBXcE9SMDlMeVFBV0ExcDk2NkxhYTFT?=
 =?utf-8?B?NXJyT2ROVEx3blVMcU1LWVN5eU1MeGxydUtBanJ3TElBOWhMYkFYaWV1WTgv?=
 =?utf-8?B?emVUQ2M4eGhsVFZ6dVBBTUUzVDJIZEFUTFRqLzQwK2tMZGlzSDVIZE1USGIw?=
 =?utf-8?B?c2RNeEFENnNsNHdtS29neC8zU1QvcG4yaXN6eDFmUWZqQWpLelRDaXlCNXN0?=
 =?utf-8?B?U3RmcHBkM3FxeEN6RUVRNUNTdXhhSW9PQlpSWmxFNDJ6UWVlMk1mbTl1Rnhj?=
 =?utf-8?B?emROd002STBBdnBzcFNPaWpLZE5uMWgwa0hic1N6bno0aUhXVVFnbjRZSCtD?=
 =?utf-8?B?b0d4ZlVKMk9sa0dLcnV1MHFVNVg4ZzVrbzU1TmtlTW4wNGxmT09ySm1sdVlR?=
 =?utf-8?B?K2ZSK2RDSHdRQUdMWUpxdVBhSjBnMlNUa0tuWlZ6dUpXWlBuVGFWT0x1ZzNi?=
 =?utf-8?B?aWdBRlVRZmFpWUhDU0Y3RDFwOXFuOC8zQmpnd0kvOUFmZkowMk9nU2xtb2FG?=
 =?utf-8?B?L0VBb1U1QW05Z0o5Z21zN3JnU3dSOE00YlA3Z0lvYWVTbGMvdW5JVjAzenZ2?=
 =?utf-8?B?ZHYrQUh3bThjcjFGMHd5Mm4wN3lSYjdNb3U2TXFvbURPOWlYaVF2aldXVkxI?=
 =?utf-8?B?clZCN2o2WWVYZmxIYmlvZVNSQnptbXR2RThJWTZ5akdUZWcrTk1DQjVZaU5K?=
 =?utf-8?B?QUw2bVdpcUJXdmVNZTZ4Z055T1AzQVVJa21IdTk1UnQ3ZlpzK25sd3BSbUpR?=
 =?utf-8?B?MjZ1OXN1UFZvYzAzb0N6Z2Jrc0RvVnVEOXUwL2lsR1FaVXJ1TkhOaUlmWXI3?=
 =?utf-8?B?RWlxK2NCZzRwMjJaZCtMNmdabVQ5NlB5R2d6UUFYSG90M1JXaytpVTVwc1Iz?=
 =?utf-8?B?VE1GTXhuVWs1UXJrUHM0ZzIxYTJwbHNQQ0hsRlJoaVZKWkptc0QrR2tKdFQ2?=
 =?utf-8?B?dWZMYldBY1RYTkdkcUZ5SGVGa01FWDZoak1odjBCV2NNM3BPZzZIbUZLN0Mz?=
 =?utf-8?B?QzRhbTkzV3hia2hJdGNYSkwwbE5HYUNTVjZhZ20xcHd4SDJ6SVJuRzZmcnJG?=
 =?utf-8?B?M29iNEp3V3M4M3VORFZ6N2FvdnUxd01ZcWlMeFg2S0d5WlNocFV4YlB1QVBo?=
 =?utf-8?B?VmdjeHlaaVQrdVFBQ0dVREVCUDVFRWlRWkc3cDIvdm5PeWdGZU9NTVYzdjdh?=
 =?utf-8?B?ZmJzVUt5K2xMRWp1RUhlYkVoYjY5ajdJeGd0Ykl2dWdsQ09JaEhOU1VOak11?=
 =?utf-8?B?azY3bTFCeCtFWkNlcnpiY0FQMmRyaTdsV0xuUFZLVzhmWnBJejY4Mm1rNFRq?=
 =?utf-8?B?U2tVZ2N4VTBLdmg0a2VpcUJsUGZ3Y2lkTmxLeEtpOGRnVUgrZ0VzTXRKMUVM?=
 =?utf-8?B?dlZjYVlnTFgvNmJ6b2g5cFArTlpDMnRISHgvclE1WkNoeUkwdy9wVEMvd0ZR?=
 =?utf-8?B?Zjg2amtBRTk2L1kzKzhSY2pEckcyenJZN3I4SkFGQjNxR0h5bjlMZHFZai91?=
 =?utf-8?B?cGs5OXQ3Sm5HRkRISDJucjZ1UCs1bE5HYUNEYytqL1dNamRvcGtBTUhhZW5G?=
 =?utf-8?B?bWFHalJIcmlCMjhUREpibGNFb05GTHVPaEtvbHJHY2lTdTNzcmhJdjIycmQy?=
 =?utf-8?B?WXVQTGdRUVF5RGNyK3hrN2JDTzMrUVJhcW92V0hNRDRTRVZNQ2xUK1Z0T2wz?=
 =?utf-8?B?OHZpcllPS1d5VThIRW12TjRLQXZrd2tSSGN0eGpFSXR3L3Y4M0lhQT09?=
X-Exchange-RoutingPolicyChecked: 0jp4XCu4J8Ev8KWuoz5+SR/jUzCTgQ4MxYRyzvKm5ArbgYdf08en78ia6OW5xp1qXlQlwVMyipC6clolySOc8EDthR/LTEu1U8NJQccXkJEPZHYkzckMB7GCNma+6Sy3jXclu8O1vAIDEyDUOosEONfkGYz1gtHi3DtKddNrvmXWJp9sxPUZaDstTF6lNPjl66Lpq0HzkQMw/l8XlOL++68TtROzo0sPPQHp5oGCqvUC4n54pF2A0Lg/CGyMjMqvD70pKeXJzRSgBgWCOHd8ilRQbf6+IZS861lPhJY/qOyBfORYgfABzQhnNq1fm7gm42yRexY6aAZn7Rr16o/bYw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d323127-8407-4c9b-758d-08df07f721a7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5709.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 07:03:31.4843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhdhBteYJSsKakYZj2upHxdHOt2nPtRB75b7eRG4uyuuZpv22y0LvD81yG8yL8KaHj2OkrDVr3SCg2RIWJoRfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6165
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


On 01-09-2026 02:30, Rodrigo Vivi wrote:
> On Thu, Aug 27, 2026 at 03:48:00PM +0530, Arvind Yadav wrote:
>> The system PM notifier runs before the PCI suspend callback and may evict
>> BOs or submit migration work. This work must not start after the device
>> has been declared wedged.
>>
>> Skip PM preparation for a wedged device. Track whether preparation ran
>> so the post callback only performs matching cleanup and releases the
>> runtime PM reference when needed.
>>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_device_types.h |  2 ++
>>   drivers/gpu/drm/xe/xe_pm.c           | 10 ++++++++++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
>> index 508ba3872e72..c9dc417878e7 100644
>> --- a/drivers/gpu/drm/xe/xe_device_types.h
>> +++ b/drivers/gpu/drm/xe/xe_device_types.h
>> @@ -471,6 +471,8 @@ struct xe_device {
>>   
>>   	/** @pm_notifier: Our PM notifier to perform actions in response to various PM events. */
>>   	struct notifier_block pm_notifier;
>> +	/** @pm_notifier_active: PM notifier prepare work was performed */
>> +	bool pm_notifier_active;
>>   	/** @pm_block: Completion to block validating tasks on suspend / hibernate prepare */
>>   	struct completion pm_block;
>>   	/** @rebind_resume_list: List of wq items to kick on resume. */
>> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
>> index 720e083cd279..dd7fd170bc94 100644
>> --- a/drivers/gpu/drm/xe/xe_pm.c
>> +++ b/drivers/gpu/drm/xe/xe_pm.c
>> @@ -457,9 +457,14 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
>>   	{
>>   		struct xe_validation_ctx ctx;
>>   
>> +		/* Do not start PM preparation after a wedge is declared. */
>> +		if (xe_device_wedged(xe))
>> +			break;
> perhaps we need to return NOTIFY_BAD ?!


Thanks for the review.
I do not think `NOTIFY_BAD` is needed here. A permanently wedged device 
should not prevent system suspend.
pm_notifier_call_chain_robust() passes the notifier result to 
notifier_to_errno(). NOTIFY_BAD becomes -EPERM, which will aborts system 
suspend.

~Arvind

>
>> +
>>   		reinit_completion(&xe->pm_block);
>>   		xe_pm_block_begin_signalling();
>>   		xe_pm_runtime_get(xe);
>> +		xe->pm_notifier_active = true;
>>   		(void)xe_validation_ctx_init(&ctx, &xe->val, NULL,
>>   					     (struct xe_val_flags) {.exclusive = true});
>>   		err = xe_bo_evict_all_user(xe);
>> @@ -480,6 +485,11 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
>>   	}
>>   	case PM_POST_HIBERNATION:
>>   	case PM_POST_SUSPEND:
>> +		if (!xe->pm_notifier_active)
>> +			break;
>> +
>> +		xe->pm_notifier_active = false;
>> +
>>   		complete_all(&xe->pm_block);
>>   		xe_pm_wake_rebind_workers(xe);
>>   		xe_bo_notifier_unprepare_all_pinned(xe);
>> -- 
>> 2.43.0
>>
