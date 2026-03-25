Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E5FFEA835
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 08:39:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97EFE10E825;
	Wed, 25 Mar 2026 08:39:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="j0D2rDLV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6301D10E835;
 Wed, 25 Mar 2026 08:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774427944; x=1805963944;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fqXW0YgB+Y7EPJiccbi3FgTUbd9uBr1rzjZ3PPozJk4=;
 b=j0D2rDLVj9hAbjqK6E/OXqNk9GjPjwpePD4xybEbFXy1aohOjospBnsr
 PzzltDRqE7EYvum3UOHi6g/iyPMz1+OGmMopPZSGoYnCpy2QN6I83TjDe
 1owNNxhWrAem4WpvxhiSLBilTQCB+4eBiXlK9twfYwvVCxRIYH16feZbx
 K91yuzQGbEkEwzD4mBopOdMlWE6L8bcV5b7iYz8Tv5TpUrQyoPZOmuwrf
 EY8ZUSW8bO2C4tcIU9qHQ+kUioi5vR1Vgd5L/CBjmDnOz/VTuzAZlUbsj
 /jlMfZTF4hgcReood36xxMVYllYtoLtlEyl/VEiAjbbnMRDDEzgfIfYs9 Q==;
X-CSE-ConnectionGUID: MdItLqQeS4eCn3l8oDX3Og==
X-CSE-MsgGUID: ibdl4AH0QlKQqb2yFFLdPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75575363"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; d="scan'208";a="75575363"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 01:39:03 -0700
X-CSE-ConnectionGUID: l35BktAXRPmFJsdhmLgr1Q==
X-CSE-MsgGUID: Q2tFkmVeTNC5nW5eBiF03g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; d="scan'208";a="255117418"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 01:39:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 01:39:02 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 01:39:02 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 01:39:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXXwpnzd3foDIy7WolPF/4R1emKFpXCX7os+j1Yp47nF97+UuaSpJmm1cCbhNTkbQLGNx+TPLjJpcWiUSnffgZ/OyCvplSaDt94ZM0NPjTn3m+kYhX/aOzWXbO9ZAkFLsXcVbdBmlkGQyanUCra4jW6rVfiFTFeweLNM7By8XVhGU9CfJYmgJrjpmzERLxG+2+RkDFkaq++kFjzDJ40TeL8zofVWUhufOODXM9Ta1NGQc0v/QVL1vcZ/XxlX9Wg13afwJ6H5CkBgE7iqAvIwYBHvizCfBFvw/29xJ8ETcTIVA2kHmbMBQ2HVMvqLe4hbzXU0Wq5ZBOpvYkZqdD/xHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qp+Idx5a339y8oC8VykWYQT8ZPfVPJTmYMCj8D5ul/I=;
 b=k0krW6JUGeZLqo4ECN1HnakrtNsP1xYGHGyFjtTZP7C3fKYrBV2sCKTcMCDhj4l4fdsaCmPPUYb7HmChLkIEIqO7hPrCp6KmIiimd1o6d+jV27x/7TC9p2/GazJLrxouQwCr1uZnUmWf0QXUVCYkhBeZXBYPXPlDvxTftyEWzU8D9pkhK9Eo8wKO3jywWNfK/yVYR5uzPJJZm/UBbhFgep1Q48N3Dkkx9CTeCtNnAZoA0RYFn5hgyKzZc7lO43iUxipdjd33IYhYqbgV9DCOJO4iw8lCV1pAWsQ/voPpPH/KlwT5VSzas7egxrDuw4wUMLmjzAeMm0zx49VoDC7c8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6011.namprd11.prod.outlook.com (2603:10b6:208:372::6)
 by PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 08:38:58 +0000
Received: from MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::3a69:3aa4:9748:6811]) by MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::3a69:3aa4:9748:6811%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 08:38:57 +0000
Message-ID: <8d140cfb-ad38-4548-aec0-89581c79d8e5@intel.com>
Date: Wed, 25 Mar 2026 09:38:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v6 1/1] drm/xe/pf: Restrict device query responses in
 admin-only PF mode
To: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>, Satyanarayana K V P
 <satyanarayana.k.v.p@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Piotr_Pi=C3=B3rkowski?= <piotr.piorkowski@intel.com>, Matthew Brost
 <matthew.brost@intel.com>, =?UTF-8?Q?Thomas_Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, =?UTF-8?Q?Micha=C5=82_Winiarski?=
 <michal.winiarski@intel.com>, Dunajski Bartosz <bartosz.dunajski@intel.com>,
 <dri-devel@lists.freedesktop.org>
References: <20260316064100.2542412-3-satyanarayana.k.v.p@intel.com>
 <20260316064100.2542412-4-satyanarayana.k.v.p@intel.com>
 <875x6lq64y.wl-ashutosh.dixit@intel.com>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <875x6lq64y.wl-ashutosh.dixit@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0385.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::21) To MN0PR11MB6011.namprd11.prod.outlook.com
 (2603:10b6:208:372::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6011:EE_|PH8PR11MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 20fb7538-f668-4a1b-99ef-08de8a49f4c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: qfD3bV6XBIitNMTe7iy8GGq6UZ8dUpahUh8bMY6+MYU7kxWieuMUnXZvyYngjf7qu8s2Ks5EP2MloYj1q8jwj8c2bPj8xh8pxb31oC8xJlY0+msZiVZ9oszvCmCZ3ICiiqsZ+28el3UI/CaouBUC6soenwIMru0JXsYdCoeMhZbCkWm1SQOdE9FfcWGHg0n0pUQjvXUGGr8A1a2qAfVGn56/ekxNSqj+8KiLS5brnxqLs1W489RNENzMwrwavyc90mxrVcwKWFK2cRbf7R9waTRbq+yPAowtDKdO/tT1PEYfxsYVVx+oO3DqZMlq5qhyAEghXfR7agAKfSTdrXMNxe4HtuKvk0Bd2N4c+dMwBkfvji8uqs7LiuPnjJgHq0GcFSZxiuZ/+reOLiS8VeWEgjA5M8tnCiOWMtFQwfJqb/2UKyQ9rlLip2u9oqs8SiXIzZdtd2GclMmaWkLkaDp/OI0X5G9HI7fthWA7iwpgFvm1N9OGLct1CBWNq8scoIP0c+Y2xHNv41pizzfPl5rCKQB9Ezslsur+CrP6LZ8uu30HnrEPRFuuhUXDeG3Sv5icLYZf3XK2oFh5d5c1mpa7NORMu3Ktm6reCMlICA8PkvGnB4pr0T04+t5P8HBwcZLq0npLNajeecBDjrEmlwMW4P9OuQZSN2nQUrghV69c5CgSTzoi2FoaIqr8YfcNLzo9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6011.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTY4SjhMVzh6VlVpRVpkZGR2VzlxMTNnVVFQZ1BIYmFBNzZUdUtrRzVZVWR5?=
 =?utf-8?B?TC93ZVJoK201bzE4TlNSTkc0UmF2YmJQYlU0eUNYWmJWZndwRTQrK2drRWlu?=
 =?utf-8?B?ZXBzSmxqL2JiRTRlRG56YUdtSU1ndnBRVWx4UTZtYWRjUmoyaVNrRGVvVlV1?=
 =?utf-8?B?MDUrVVVxVW41dHpCMmpaVStSR3ZkV3lLMThibWtvWTF6b1MrTGJvMzhpd2Vq?=
 =?utf-8?B?cExTWVhKbDFnWFhjL1hqaHZmUVM4VzRBR0VCbU84MmpIQmFsU3pBWE41VEhk?=
 =?utf-8?B?cWNjWDlwY1lVOUFXN0NpREg3L0dXcTlBOEVWYXZsbk1jVW9nWG9aK01CMk9S?=
 =?utf-8?B?cXQ5VnVJcVlrZ09qRTljeW1SemdyTDZYaUY2NlUveE9KQ0c0RE4rVVd3c0pP?=
 =?utf-8?B?dlA1NG9sUEIzU0NLMXRTVVplRDlNRTJ5Z0lFL3NBS29BeC9zcUNnZ0pRMlRM?=
 =?utf-8?B?UzIwb1pzOWVmam93cVZYdUZnYTQ2L29sNTRtbXhDWUhwRjE5YnlkZkJPZ09k?=
 =?utf-8?B?eHpFRThPb1NUbVd3Qm5CSkFubkhxVkRlV1lNbmZDWVZyQzFUSm01MW5DaUVS?=
 =?utf-8?B?NHBMQlBxL1Zid00xb3FEOU1YaGhqSmNVNmRHQmk5VE1DT2RFa2hyL3QzUU9Q?=
 =?utf-8?B?cmNRZmIyc3BBMGwrbFBKYTd3UndzRk1hM2tTRko0cHpEaE5kek9CanRSTTZB?=
 =?utf-8?B?L2FaYXFpS0JtZnpVS2FtOVhsUnNzZC9sanA2cGtGeEFJNUFwSHYyRWltdy94?=
 =?utf-8?B?clV3NVdyaldvNlMveTJLcVhWQ3ZLWUpqUmFFeGkrbGZ4UFNyQ1dkZWlvZkww?=
 =?utf-8?B?ajBQeGc5c3o5QUErOUxlOWtRcVY2V2Z0UHJZSnZVTUcwUDFZUTFsaVU0MUZT?=
 =?utf-8?B?aThQb0U2RDhITDdsOUpSaFl4YzZzTFhoMHhQK3dIdWE5QnQ1NGdkLytvdTRh?=
 =?utf-8?B?RGZETjJEcGVodHNyYzFVUkJhRllVUjdzY0gyU0x2WC9rcUFZaGx3eHFBaDND?=
 =?utf-8?B?Nk1JM2N1SVNoMW5kaDU2K2taT1VyM2FSZDdNdCtqVFh4aTc1KzhsdGVYandz?=
 =?utf-8?B?SkNrZFQ2Q2VudTJRTi9jZkhHOXl0Y0YyREZnYnVIUWdyRE0yQmhCYVlOcEor?=
 =?utf-8?B?RlFDYkQ1dUtrRjByd3BGWlpJRzQveFJQUmNZdW44cm45WHFCV1NSd2pYQ3NG?=
 =?utf-8?B?TnJ2c2M5V3R2b1pqc2NXVC85ZWV3bSs0TXlBOWFHLy9tTks3eGFVU2xvaHJ4?=
 =?utf-8?B?anZNUG9vNUw4YjhNZU4rS0E0dm5hejFkQ1lUeTRtTlZ0ZDhrRG5wakNiZG9B?=
 =?utf-8?B?aTFkT1hLckFVSVdqWnFUMXZuNDFVbkpFNE1EMFczbDJEZEVLeERwK3dpWnVS?=
 =?utf-8?B?cWYzdFdVRVg3VnRTVDhLNWtob3M2bnJqbkwrMlEwazlRRG5yZVpuSDBleGdL?=
 =?utf-8?B?ckkyZHgvbGh3Y0NmK1YvcTdlNi92bDFFTG5iL0ZUZkIrUVlpeFBkLy9EWERo?=
 =?utf-8?B?QSsvQkppQVcyQnFieVdRSWpRT1lmU0dRTG1DOERkSmpWcUVYSERCWTZyM1g2?=
 =?utf-8?B?cjl1NUd6SEpKdThYeXFIb3FROVFheFhlVFhmR0NmVlNhcUppa3kwM0paSXNT?=
 =?utf-8?B?STJ4SExXbWErWHNwNnI2cGVnUmZrZE1rSnVtdjRwc0pMU0FEekFrS3RqL0R4?=
 =?utf-8?B?d0g5M2h4ZkhYb2g4NDhGOFA3Vk93dVVsTDBWNHpkWDJLQUFBVW5Cb05HTXQx?=
 =?utf-8?B?YytuUGJGRWJqcWtFQTM4YWJlU1NEVjBBZlBhYWtmWVdTbTdrR3liSnFOSzRU?=
 =?utf-8?B?K3VSTG5TQm1ob2VPWUF2MHFxV3VuYU5xak5ZUC90ZDdIRlA4ZWZhR25nbFNP?=
 =?utf-8?B?ajE3YjAwQlBESE1FUFcrWHdlaXk2MEJxekpuQURqL1RHNWRCTFhpL3FQbE1X?=
 =?utf-8?B?TWRaMlBXdXNRU0Z6N09sbm1qRWxOK0pyNzdTSGErV3RhekQxZEo2VG9reUhO?=
 =?utf-8?B?elNoZndwTWNOOVdkRHFZcXhVa21QR1oySDIzcGJHalA5MzRrMXdFSUtKOWRw?=
 =?utf-8?B?Zk0zMlBPUDkvamdZUkVFYmh0V1FrdzRFdERONDlwTU5JUWcrcjlBY1FWTVli?=
 =?utf-8?B?MWo5SmhNa09xMXZsVHg4MXV4SDVYQ2lNR2d2TkwvMTRyRU51dWQwOFlnTnUw?=
 =?utf-8?B?WW1PVXM2ZmVZaitxQWUxaW5SemM0ME45QnBuRUhUV1N3K0ttY3pmNXMrR01w?=
 =?utf-8?B?cjFiZG00QW93Ry80ODJBRm9BYmpzaHc1VjFoejFxUVdGbk5MN1o0MXFLYnpR?=
 =?utf-8?B?VjdMZmtMT0JnbkZvSXkraXBWYkd3NXFHSndsVWJtQzJZSGpxUUlPQS9OMDZy?=
 =?utf-8?Q?hjjNV8SJu6j1hL0Q=3D?=
X-Exchange-RoutingPolicyChecked: NauUtgCn8OJT9guOgHdWPYhSRJM97QdqUaaLKI3+uUDGrT9RdfcqNOODfWIJOb2InY/QkZW6ScMnEEgqbhJWRUnyMrIffvF6QQy9SYet8+Lw+kQfVBkObSeQ2hW2Y046/zq+/tnofJhG/7hY9LrJ/o3IUSMpHdWxYc2YyVQhop9WowbHRDwMoQ0IQGfrVFp2BluI8arIqy92Ow4tPy2KHZQS7VqVDraXcz1MyY4uyqX9ueMxXfe3fqr4lF3D7lCbeyFwzptuASv3rOgBu6uAroIwmIujxwLzSSG5hGqhinJAWedfp+DeRabp1ZMj4ZkZotVJeM8W7OQU00KaWZ7+gQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fb7538-f668-4a1b-99ef-08de8a49f4c3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6011.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 08:38:57.8611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APmLuYEQofohBVk/RRXaMGkdRI+GoVpKa3Q+kr9TgDKK5MEG2is4O/RRS2ipFRQ9wB7hnFDX0BduYu8Z/JtI780/Gr3GUmxnj1+rwq/QLAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6779
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



On 3/24/2026 10:17 PM, Dixit, Ashutosh wrote:
> On Sun, 15 Mar 2026 23:41:02 -0700, Satyanarayana K V P wrote:
>>
>> ---
>> V5 -> V6:
>> - Updated commit message.
>> - Return number of engines and memory regions as zero instead of returning
>> query size as zero (Michal Wajdeczko).
>> - Allow all other query IOCTLs excepts query_engines and query_mem_regions
>> (Michal Wajdeczko).
> 
> Can someone explain the reason to move away from the approach in v5? Afais
> v6 has issues of this sort:
> 
> * query_engines will return 0 engines but query_hwconfig will return > 0
>   engines

but those are separate queries on purpose, right?
and I guess that even today there could be a mismatch between these numbers:

* query_engines = engines available for use by the user software
* query_hwconfig.engines = report engines present on the hardware

> * query_engines will return 0 engines but query_oa_units will list out the
>   engines

and that IMO should be considered as a desired outcome, as I guess (again)
that this will allow us to do some OA reporting, even if PF alone is not
submitting any workloads and we want to monitor how VFs are doing

> * query_oa_units will return valid oa support but observation ioctl will
>   fail

my initial idea [1] was to expose observation ioctl as well, maybe we need
to add it back?

[1] https://patchwork.freedesktop.org/patch/706445/?series=160349&rev=2#comment_1299475

> 
> v5 seems to have avoided contradictions of this sort. Or this doesn't
> matter? Thanks.

but since I'm not using any of those ioctls on daily basis, I might be wrong

