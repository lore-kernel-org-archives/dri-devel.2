Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF95C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FBBF10E7EA;
	Mon, 20 Jul 2026 08:11:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YKHEEImQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E645610E137;
 Mon, 20 Jul 2026 08:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784535067; x=1816071067;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=c1G3lBlvdZCZaRLqago9DRHgAZx9HU+9zgpqxNhuG1A=;
 b=YKHEEImQfl3i2LqCMCL/zhXqkd+umILoOpo84juRXVyomnFkwVxBGWwF
 SIMcFcOurFij95xDh6kcAPic5CCYu9pKT22x/kZ8vpM9OR525jetdfGaI
 WTmK6elzM5nTvEX8ETivaJW6tId6ikSs+FYVsaMDcmyOEMRBzcAH3u6+k
 CwmAvbXGuFCLHJxgQzDUbJxJWBkz5wjr3zqiyb9tH1CZyzjWpqay+76ll
 Fh3XQGl6djU4cfii7yRP0qgox72egt04SS+KOnDJEcj2DKYEHSRILgbiF
 x+Cx8SkOeF6dgVb6ICclejs/7Kwxak6CfON4CC1YYlCqL4L4g2Nq4+/Iw g==;
X-CSE-ConnectionGUID: 4NxTALvpRCyDHGKnQB4rwg==
X-CSE-MsgGUID: r0XOz/ULTzy3VlA0gWXKtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="95701478"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="95701478"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 01:11:06 -0700
X-CSE-ConnectionGUID: 2G2APCjUSjKQjNACOonOCQ==
X-CSE-MsgGUID: V7WaGLqZRkKQSCaG6hwInA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="255613551"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 01:11:06 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 01:11:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 01:11:05 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.9) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 01:11:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkU35Pv2jpAxnoGfunzoztI9tu0F5iUwvyQNFrDk5GZaqdaSKVIHrEo2jjqp8SkX7OmINP3qxLgsxAIEEV8bF3pGR5QknSir4DEiIxC3MBmmYU0iyBD0kA38xfTT5BekxEfmTOHp/mzrPwqSzJ1oyNGwTVPXf75jViH1BRrtvuZODh9STd8ZXe2xNFvKOmVSh5sBCUmvIts1gNs+kKYFtsc4uQzToI4UX/Ny/CgjpqXLupZx7nojRs/AFWyznR0OLEASLk6E7H8PsoqunSBGRQEK5fXBRrr/fEFceK8mrAy+NbFAz1+JXs7DxvzbbrPehEsfrUO6QsTjAVbdW3Yicg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMO1++td1EylV8DFYIHJTcF0koqicW4tGKISZDt00tc=;
 b=jF5UY+S5KQgav4Aaux4ZP5a69nT8gFFEHlzGjVSgGH+UxKljUpIc/sBad3qLYKu5bhbs53MW+2kgo4j2NzjhjJJj2Ds490Uh/s8bOifZeY8jqN2GPYYL8X+r0n/JF6osm4g+iQXjLhyO/TjdiQbNbrUxbfk1xreEbufMr2/3k2PCw2+KyI3ED0NmTaTlBkiKfkJu3odDhUt1UGmevRNu/nLKYll3EctmHBo2d1JAVIkI/9iXLvWTwcE6U6qEEv8ccJIY6TNoGOLIb46KbfB9JEFH7emOXkmvn7B+Yht+aCOK4D80xI8+zWFbFnS2DKpzTS/mb9otuO84bn7hf9E9HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by IA1PR11MB6193.namprd11.prod.outlook.com (2603:10b6:208:3eb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 08:11:03 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0223.013; Mon, 20 Jul 2026
 08:11:02 +0000
Date: Mon, 20 Jul 2026 08:10:51 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>, Andi Shyti <andi.shyti@linux.intel.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, "Sebastian
 Brzezinka" <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v3 3/5] drm/i915/gem: Pull out size validation into a
 separate function
Message-ID: <uue5j5fe4czjnk4whhge6ozmdxnuozgldkf3nmzqixqnonstqb@l3o3ycb37b4c>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260713095812.1014365-1-krzysztof.karas@intel.com>
 <20260713095812.1014365-4-krzysztof.karas@intel.com>
 <ceb6e88a73eb99700b0af3e19e3d5c4941341752.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ceb6e88a73eb99700b0af3e19e3d5c4941341752.camel@linux.intel.com>
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|IA1PR11MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: fea7941b-809e-4206-1f88-08dee63670c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|11063799006|5023799004|4143699003|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: qGZ7fbHCmP00yFmZ/D2Fv8mGUdUecyrN3ORUmN76huJWUnatqGefnWgajKQmC6eoqOjLR39fXNvRs69wO/3DWgb6UQH0v+wuJjZpGQzksD4wFhcqqvBDrejmW1mG4KHUxwf/j/P79+IgP4NHxId9fLtVva0yMtc9M0bmwdnkobrs5eODEzoGGCFKJEKVWQcgsZydSzjHk9IXV+F2JPJpmU3CGtvK10UFBpTi6KYOaeC4CgrGKVS0nFGntnFvkHxh/ykbu1jH5TPYTZGqLA9ke2++PoXjTiN0k5z4Kad3Ubq+0dBg6ReBLTXlJGqxgX4HBrW2ANqbH9FKjEFGelS+Olc5TerRg5Zpvlj+O4XN/mHtpuC19iFU5Tk5f4idtO1ad67/r7I77eShxbNNFZZurVXVRCHKApSJa2z7ieFt+X00vlHEpydIffX5xZyFd+TlX5ZfHDmlQVxVszvQMN5uVZ3n43fKmSzDOWZRbZ/Wvvyzz6i46ogPwhVOnMixM9Q/L9/1AIR466Y8KIWVGrBf593K2Az8ekaSKameuMg/5EanuFAEkAr3d3g/CDcDDPRMMExHNRAdraMJ70Lvpz0DsAx2+W6rfHhvTqsFp28uREa3OihU/HAsOB3DyNWrX50/trXyz/1zxFWounyoE3QQ7gmNeAh/NqzdrRh5xNNNiF4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(5023799004)(4143699003)(56012099006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTJZLzdnMElab0FudzNLajhKd1M0RldsNEpLKy9uekZMUklKY0JDT1MyQXVY?=
 =?utf-8?B?TVQ3LzVZUm5BSG10ZlBpQlNvd2U1d1RlQ2dLRDlKbUh3WjlBYks5V05ObURs?=
 =?utf-8?B?dGo3RmhKUE4vbkVtSkgvNEhPendUR2E3QVhqK2h2bU9mM05yR1dma2UreG13?=
 =?utf-8?B?THk5dEx6Y2N5bmxvNDZsNDZFTFNCNktIOXAyU2Z2Rk54THVXZ0NOcldVVEFl?=
 =?utf-8?B?VXVrbHBwTHZtTEtzZnpIYTBoSmJDcHc4dGpHNCtRUlV1OUI0RExhWHFqcklS?=
 =?utf-8?B?aFl2emRDMDF2TEVSMWdNUWM5RDl3ZkdpTVJiVGFkR0VZMXFSVFBZU3M4ZHdQ?=
 =?utf-8?B?TURodnR1T082MlkxZzF1M2pnVndqVDhFa3VmZG10N0lzbEFyTWQ0OVEySyt6?=
 =?utf-8?B?RThTQ3I5cFVPMW9rL0hDekJ1UkxMenIvZGJ3K0RhTDhrMWU5L1BVVk5BUzRz?=
 =?utf-8?B?UWdnSVplRXJkS1FYOUFERGpyb2RNOVNBRkVxNGY5bUQxN0xGSHdPYmxKYXA1?=
 =?utf-8?B?Z0ppNDhuWHpULzlVaWV6cm9TdzVNQjRhLzc0Zm5MaHhjZjlHbC85S3VSdmFk?=
 =?utf-8?B?Wjc3dC9YdUt2TEU3cTNQOEs5eFV1RlNoeTVZMXhPVXcxdllWOERLVVhiRlZS?=
 =?utf-8?B?TXo5blVzbzc2cU9RSHdDRGxJK3I5U0tPYzA5bUZsZVZkQ24zYUdMNHc5UDF2?=
 =?utf-8?B?WTdtVGNMTUZrcUdjS3hXdW9KZHBqaTZFSG1nMDZPc0V2V1NwSXpHeEVmYXlB?=
 =?utf-8?B?U0JoM3IzN0FDQXkxQ2kvRWVocHh0eVMrYnZaSDM0b2FDOTA0MkN3cEdIeWNM?=
 =?utf-8?B?T2h4aWs1TXNJL3M1dUNXQ2VuQVQ3RmRwZHBQMDFiMlRPTUhJN1dUVWpVczVJ?=
 =?utf-8?B?eGZyNndDWFFHck9GMjN1L3VuYjhYU1RRT3FFRmxqbExxalNML2pZOC8vdnZF?=
 =?utf-8?B?ZjcvRXVCSnVGOXhsRHhocnJBVFZCckJkTW9sVlM0SjVNWk5xcXcrb2FaSGw2?=
 =?utf-8?B?Nit1ZTFqaTdMd3NPeUhEeStuSnhSZmZIVThINXRTSWdOMHJsQkF0NGJvWkgr?=
 =?utf-8?B?QnRvL3ZCTTJ3TjlCeXJYUUNVamFpbEVDb3FSNHhTU0JrekdLSURjd0JmblNv?=
 =?utf-8?B?NExWTDlsTjhreG9rVmNESEltOS9JTXhGczd4dmhPRWVEL2ZFbUFaTGwxRDR5?=
 =?utf-8?B?T3hZblZ1NnluWVJ6M3FXMVdJeXVGMUplSVozeHZFdkRORkEwRmRRQitLcWty?=
 =?utf-8?B?eTVseU5NVnJmTU9TWXZUclRJNHZnRG1CQko2ckVzUVFBVWdmM1l0aE55VWVL?=
 =?utf-8?B?OWxxUDdhN09FaXZTWGNMck5qays3bHkxS05RUHJqaFBCMnErc2NkTE01S0wx?=
 =?utf-8?B?Wm1OeTQ5SHpMVllYQWMwbk84SXJmNThrV0pwZjV5eG5mb29DcEplSE5XTERV?=
 =?utf-8?B?dVVDd3k2VTlLUkNLNWk3Rk1QM1V0Q0xSUzZRcEJBcXlrNWlxbzlUY1FXU1dj?=
 =?utf-8?B?RXpXMm95MlBLSWlNTW1CZ201OHJ3U3NSMy9LVHdHQWoyMkgxNmk1eHNYM0kv?=
 =?utf-8?B?MUYyMlBxT1B3elhUUUwzNkRSR21adnZCekxHVDR3aFZsYStISEo4NEIvTXpv?=
 =?utf-8?B?aW5pS0VDQVNFNVNiejB4QmtFZTM2SXZDUWlFNFdCNXVaeWtWUWhQSlludTdu?=
 =?utf-8?B?bkkyRUJoUXlYVzRNOXdFSGRKVlF0cVhCRWNMakNyWUVlRzlKN2wwZVhQcnZt?=
 =?utf-8?B?WkVqN3hQSCt1eTJBaHNzK1pZSmRmTUtCZmhubTZLN29SaWtPem1pVWxaREV1?=
 =?utf-8?B?VHF2MjVQZUNXMFMzZEJLWVorVWxndGUyR0JrTkxiWUpUcFpOL21lM2lyenkz?=
 =?utf-8?B?Z1EvSW4zc1ZhWVQxMWJoUTlmUk5mSmV6Y2s2VjUzcGlST2tpZFdIWS94ZWRL?=
 =?utf-8?B?dHJMcVh0NGRuM0JSMmlpZGE0bUp6RVRPRGcxTlp6bWFQM3pOWVd4ZDNKT1Y3?=
 =?utf-8?B?cHpvQVErSjFhYWE1ZThZODJ4dHh1aGM5Nkk0VzFJZFBJbnducytuek5zYmhN?=
 =?utf-8?B?ZjlETEtXdE9JN29TeGxhazRuL0xKa1RvQ0NEQm12TzJXSVo2WUk4ZURJSXkx?=
 =?utf-8?B?TUZzZ2dhWkxyRkV3M3ptSEdxVGZ4WUY1RG4zVW5ibjJPOGI0WFdtVHVIWXVS?=
 =?utf-8?B?c0YwZzIyQWdHYTBNZUdCQmlReXBTQWtCY2JVTzBqd2VKUTFtQTlNdVdMZkd5?=
 =?utf-8?B?TVRVd3RNWGVTUkU5UVRKUTZJR01aZk94VThmamdLSXFPajJqVkRYdDg1N3Vi?=
 =?utf-8?B?MHlSOFFpSk1rMmUxd2tKN0JBUWJnU1hiZXA1UFdidHNTTFlCei9PSkJYeGxR?=
 =?utf-8?Q?71dZcuNnJIJu0VbE=3D?=
X-Exchange-RoutingPolicyChecked: frorDFWIh6Dqm1/+6OBv/snmVT2mAUOFMAPSKPXNlEjjgGCMj7uQlLBZ0qQBq52SOM4RN5BMKTS11THuUoJUd4q77WCAt/lOifWXwZsyB3y93YbNG01ilp4nwpOAwlaRVNLqcpCERIGQ56IglK/fJ1JQHlM3B0KkybWAHeNHIEBTMa3f9vAqBw1596WCPkWFxKGja6VP+xrl5lbHEPnxdjXy62UPnQW074lHwMwpMisWtZWjrbtDbVTNxAQFmG3wRWNHQhHhvGeq7NLz4AtqEyuAVfmzYkrpyOXkNUjsLdZ5yNy+8Xb1FgpkvrDUztadDm+MfruEHe2DJ2QHPfM7ug==
X-MS-Exchange-CrossTenant-Network-Message-Id: fea7941b-809e-4206-1f88-08dee63670c8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:11:02.9049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uM9gKz9QXERDwdVQSNpLHUFEkPK1ua9pfyfh9okGNT96TQ8++QLyocLXCC+Ud9KWzYiAIpGs2OOIImqdzZuOFD/FwlRdaoh+fc21N+Zm3wA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6193
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

On 2026-07-15 at 17:21:39 +0200, Janusz Krzysztofik wrote:
> Hi Krzysztof,
> 
> On Mon, 2026-07-13 at 09:58 +0000, Krzysztof Karas wrote:
> > shmem_sg_alloc_table is a very large and hard to read function,
> > so reduce the number of operations it is responsible for by
> > placing "size" validation in a new helper.
> > 
> > Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> > ---
> > v3:
> >  * Split refactoring and put it after the fix in shmem folio
> >   counting suggested by Andi.
> > 
> >  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 29 ++++++++++++++++-------
> >  1 file changed, 20 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > index 0011d76f5b8c..4a61b012fb6f 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > @@ -62,6 +62,22 @@ void shmem_sg_free_table(struct sg_table *st, struct address_space *mapping,
> >  	sg_free_table(st);
> >  }
> >  
> > +static int validate_size(size_t size, unsigned int page_count,
> > +			 struct intel_memory_region *mr)
> > +{
> > +	if (overflows_type(size / PAGE_SIZE, page_count))
> > +		return -E2BIG;
> > +
> > +	/*
> > +	 * If there's no chance of allocating enough pages for the whole
> > +	 * object, bail early.
> > +	 */
> > +	if (size > resource_size(&mr->region))
> > +		return -ENOMEM;
> > +
> > +	return 0;
> > +}
> > +
> >  int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
> >  			 size_t size, struct intel_memory_region *mr,
> >  			 struct address_space *mapping,
> > @@ -77,16 +93,11 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
> >  	unsigned long i;
> >  	int ret;
> >  
> > -	if (overflows_type(size / PAGE_SIZE, page_count))
> > -		return -E2BIG;
> > -
> >  	page_count = size / PAGE_SIZE;
> 
> Verifying if page_count can accommodate a result before assigning that
> result to it looked more correctly to me.  Since overflows_type() doesn't
> look at the variable's value, only its type, I think you could postpone 
> page_count initialization and pass its pointer to your helper to preserve 
> that more reasonable order of operations.
Yeah, you are right, it would make more sense to validate it
before assignment. I'll do that in the next version.

> 
> Thanks,
> Janusz
> 
> > -	/*
> > -	 * If there's no chance of allocating enough pages for the whole
> > -	 * object, bail early.
> > -	 */
> > -	if (size > resource_size(&mr->region))
> > -		return -ENOMEM;
> > +
> > +	ret = validate_size(size, page_count, mr);
> > +	if (ret < 0)
> > +		return ret;
> >  
> >  	if (sg_alloc_table(st, page_count, GFP_KERNEL | __GFP_NOWARN))
> >  		return -ENOMEM;

-- 
Best Regards,
Krzysztof
