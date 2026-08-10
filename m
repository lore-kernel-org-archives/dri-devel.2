Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E97C5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 04:36:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AA3710E5FC;
	Mon, 10 Aug 2026 04:36:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="U0mFofRi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92CFE10E5FA;
 Mon, 10 Aug 2026 04:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786336569; x=1817872569;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=Fospd3EglvnBSdUnQg8Bg4GbUGzn8+gbZCBzC7tXozo=;
 b=U0mFofRiFqOFxDE5/yT+bL/51fLszv5zOijHwF8MQZTCDTFZuTh+UcMO
 92R54xiFCNMYodbcmrpSYzI5hApJVXHdGEH8TfLQIr8yUQkVYWxEi3a/9
 zwa80UFgeVr3+s5eWAeqXnoHtulMkGOZpG+3UoBTcOAsdHcHmRigIYJmV
 8+R8M3heQXjA9/0v1fCEOdWOQDRDeyUrcZZpgYGlb+pcTL9tcn6fLv1ab
 lJgimElD/wdsDRE97c2UfSjQSVVWUuY9HP7v/Gj6mMUoHXVklZes5cH1+
 NnrNL4TyVNPMs19cwDonZgzPBcsEQRtj40BJDFuHf291pfU0IA0eeQ5RS Q==;
X-CSE-ConnectionGUID: iO1v4pwQR4mKBu9rLxelbA==
X-CSE-MsgGUID: e4xowaAuQKmFZ+xRDsX5qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="98204007"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; d="scan'208,217";a="98204007"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2026 21:36:08 -0700
X-CSE-ConnectionGUID: ntIXmv0NQa+hpyeB3CbkaQ==
X-CSE-MsgGUID: qA6T4EQFTZ+8sQLlY891ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
 d="scan'208,217";a="287640524"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2026 21:36:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 21:36:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 9 Aug 2026 21:36:06 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 21:36:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grrIcy0aIaT/9WEohxvKy9q1N4mz2OUBwOcaRBhPM7TGaCcAcMlLJHFFcy3tvFFdbey/EdXKTtr5DwfRtqiZUkWh6ugRoFPpKEoahc4JnqLDVLHW37E8aU3hfb28DHV5HWZzVsVDIYzkAgBrA6kawZtie4vsPr8+hz/kxN8FzcuK8Psni4pTHwoP2plFqedKvP4SqT+bNPga8J5UgtxdPnx/UGQ8X07ApKe9btW+oWfd+acmfpu81pi6GGJFvtIE4dDVrW11B7peQ1gIz5vpO8Q3YagIpsurxfh11ryU2K3WZNXi80WMy1ad2vq2UbbvDuH3kuxG3uT1OPp+4LBekw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UV5emr8zd5f5BNWNsvImPxlxStORxx2DVBML0vwsnBM=;
 b=kY74wbSAJC5RXtTCUEeuPrVxNIy9ioXLUDmhXCRk+3waZ9rhKuamNnbCk778AkhcrhYIIh8/l/mPYhSJALj7ELdJnmEnkapxQNKvV/Xoi/A33OcKbiBOUvlyu+lFNt7SIb4QVbzVEMKzAAGOBIkcQnJOsvaqVaeNKxxpBXMjq1BZVwA6hG9tseE6Ynsgmnqt9rXIB8jYexGtdHSGyu0KU8L4LQpQnA181AahD66/fPfQVN27GSWO6Uvi/9XrnyWavUI6GkMLT/qe3SxkT+BCPl4g8B29AJiS7IDL0JtfGKns07Hj95+6t5+8Ax42iUn7Z3KlPOKRo5NOUq2WciaUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 by PH0PR11MB7448.namprd11.prod.outlook.com (2603:10b6:510:26c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 04:35:59 +0000
Received: from BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c]) by BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 04:35:59 +0000
Content-Type: multipart/alternative;
 boundary="------------y1CsS5q3iAluuBmo0h4PYegc"
Message-ID: <70e8e9aa-83c3-43e7-9a0d-4ed695896395@intel.com>
Date: Mon, 10 Aug 2026 10:05:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/pagemap: Prevent double migration of device pages
To: Matthew Brost <matthew.brost@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <thomas.hellstrom@linux.intel.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <himal.prasad.ghimiray@intel.com>
References: <20260807081244.2229191-1-arvind.yadav@intel.com>
 <anZlLADT45F75WKQ@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <anZlLADT45F75WKQ@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: MA5P287CA0233.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::12) To BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5709:EE_|PH0PR11MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: a205a147-7a70-41fe-1574-08def698e010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|11063799006|56012099006|5023799004|8096899003|3023799007|13003099007|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 76r3waKCvRvIkHUn+HA6Cku3GmX/2KV54kBSG28JpVh+0jWneP1dmJV9l7pch1m4iY9RGlhagjsM8lzUMGzO1hiUagVramZsUCBIqM3CJGUCpMu18x00r2+BDocRAhtAlsbpV10Dif410z1HCAiLDNJmgzRcmd9m1dZVMXVX8Rjd/q+W/O2TnkvP6ux9IY0PP7aMxyT2Yutkf7Xm2QY71VuNMWJ8kTTFiY1DZVPAPChP4CszqcKJXEA8X9mqLZw/7a0A0Bjmt9vEDV2APM1LWwDOnMmLTAUBccml+jQZc6Za3L7L3y7tl65ugYR6GZ9IpqHohUknkyKemAu2pC2GitMwOHwi4Oq86ATiCrNDiqGNSUzhC0h6nL2ZhQYVcLqa68Xtf6z2ZZoMQzWgP0wNnSp7/0M8tC4LlHr03QMASmbZOwaj5gEfYRIWh3WNEzKHHzUbxL4AwAFaXkyJ1h1XFX7mgS3mhWZxvleGyJCIif7N913x6n3aWlN24rs19XdYcheYWrED0/sdIJMwg6z8KbggySQYIp1O6TKgsSZpA3MRD9L4Oo3TRMjq4oG5Imnhff9wYRZPoTa1JI3auLiqFqXnl+fIEYj6FDWbkSik8KMbsMohTRiW9LOizQDfPw7G
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR11MB5709.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(5023799004)(8096899003)(3023799007)(13003099007)(6133799003)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVNKNmtOWnVTVnRFb3F4SG5sc0xpcnJHcjJ5SHo4b0lBWE1PdlNqTnhWSlZO?=
 =?utf-8?B?c0ZVNFRFS0FZaldUTGZLbWlaMTl2aHVxMkIvKzA3ZTZVdFcyREUrN2dzUHlQ?=
 =?utf-8?B?b0V5QzlUYXFPWUNtakNGbFFWM3VTcXpzcEw3ZGNoaUNiSDRXV3VOZzl2WHg3?=
 =?utf-8?B?WmNGTGJiWHZ5anVWSVZ0TEplcmxOd3lYWWc2TUQ0Qjh4RXE4Tms1UW8rdFBR?=
 =?utf-8?B?WUN1UTNGSTRJYU5KclJCL2FwdjZDeVJIc1JKTDNyRENGMndjQnZGdklUcDht?=
 =?utf-8?B?KzFLeXRrUndGSE9vdUF4TjNnSFBhcVdZdE1lT2JsVGJYaWpJdlpaaGRQNHhW?=
 =?utf-8?B?eFpTOXlTUzMrelFFQ01LUGEvUXcrZzhBVEMzaWUwamM0QWdvWUtLYTNPS0RJ?=
 =?utf-8?B?YkNSbFI0V2QzRGN3TXo4cEo3a1ZseXlrOE8ycjZuaHNkd0JWQXAwOW5KZVJw?=
 =?utf-8?B?SUFUVjVTVEhTQTN2S1dBdnl1L0VOWllmeVJTSHBRaXFlR0kzVm1CNElLakRG?=
 =?utf-8?B?UHFZYkRYUEhaZVNGRVBSZzhrRWV3aTlrTXlwblBHdGRkRE1WdmRweERhZlgr?=
 =?utf-8?B?K3BOS0JsdTVJNklpeGM1QmorTUxqKy9mdDZZOWhUOU0zSW5EYXRKTkZGbmhi?=
 =?utf-8?B?dHE0Sm8xRll2b0ZzSEE0SytpYkJKWXgrbVhLaTREYllBRExpS08zMGxibzRM?=
 =?utf-8?B?RFhXdjN2dGRpd0Z6bEw0VWFFeWpOZjlDY0FFc0p6Q3dLbGJvdHh2NnFXMlF1?=
 =?utf-8?B?RVJ5T3JBYnNiTkZONkpwYXVYQ0VBTG5PWExUQ1pHVmVsMjg0Qk9IQ3p0cHdJ?=
 =?utf-8?B?ZjJFMWxSTGR3RW81RmxWL3NqWFhIcmt0Vkh4QU9GczlTVFZhVk5yTk1qdU5s?=
 =?utf-8?B?QkZFRFVST2ZvbmpmYW5DY2Z3N09IL3dtKzNzaUN3Sk1KWERSL3NhR2xaV0N5?=
 =?utf-8?B?WDZUUnVCbWtCbFN6TWJ3dmJDa282ZkVBVmE5TjlFdnNDeUo2ZXFHbHlJSVEx?=
 =?utf-8?B?VzNUcXErdUo0YmlialVWRW1JSGt2ZmVtdkowWjhMZ2M5OGhaZTlabnNMTUox?=
 =?utf-8?B?UHBxYjQ3MWZQbG9uQXJZQ2xXRENXOXA3dmN6UDhEZlRBTUJHdWdRSlNpQS9G?=
 =?utf-8?B?VGdoWkZIY2UrMEtXb1V1T1o4YXR6Qjl1bGM0ZDVWNFdDL3RmT1BvQ2tkTlg1?=
 =?utf-8?B?RW1OS29STnVLRTBPRVJaendybDRDc0Z0SHRQY281eUN1cVdXTXdJazhEU1lv?=
 =?utf-8?B?bFQveml2Nnhad1c2OWJtZ3pzbzNhaTBqZ1Q5bTYwa1liclhQRzJsOWJIek4z?=
 =?utf-8?B?aU4rUjVza0hlSUNacUM5UktUSzFwL04xblRQSSs4Ynd5MXhzamVVd2dlM3Fy?=
 =?utf-8?B?eVdqYXlUbnc5Zk14OUdHMEhsNVRoTkJCK0xtZktTc3VhTHNWa1BtWUdzOEN0?=
 =?utf-8?B?RFU3N1NGaFVraFpNWlNwUk5HL0xwWVh4WnI2THlULzNzY21neG9WN0ljM3JE?=
 =?utf-8?B?b1RWZUlQUFlQVDhsTnQ0cUNwblBYa2FwMTN1TTRlTGFlNm9NaGFMc1p2Sm9Q?=
 =?utf-8?B?SGZNdExBL0dIdTBBd1BEcHBlUTlEb3RseHV5WW1aQk1YWWZrdytrbDBoQ2Rr?=
 =?utf-8?B?ZnlYdmJqT21pYzF0NHUrbVFZZGlUZGtxbnRsLzJOa3hXbVZUYWtjaFZvQU92?=
 =?utf-8?B?WndyM20zbG90Z1A4dEZYY3MvWFc3d0ZjdklScmlEN0xINWRab0gyeHBZM3Iz?=
 =?utf-8?B?MEdaRk9EM2xBS2F5cmJJYTZVSm14UEUxSmtYZ1ZYM0srcVVwd2krWEFpY3py?=
 =?utf-8?B?cnFuNnNsODh1S2lnN0hPTjFpWWJaUGZvYzRiMW5lanZ2Q0IvbmJWaTNoR3pu?=
 =?utf-8?B?WDBEa3VhdU1qS3J4RnR2dVIzUDBUdVUxZENmQzA0TWhrblhlcFQ4ajE0WlRS?=
 =?utf-8?B?bzJDSHRyL0lEMkcvT2ZsdEIySWFUK09FOXJpWFVmcU9SRWhlTUNScUVGR0th?=
 =?utf-8?B?eVdvajRqa0pLcTBGVXN3MHJqazNyaXBxQjZwcm01a2gxQjhPUjBkbnRoNUJM?=
 =?utf-8?B?ZUM4LzRPdFRHZUhhRTFxU1RIWllacytoR3ZhWXpJUmtUbXFhdjMyNmVYUHdZ?=
 =?utf-8?B?eTU3V3N5eElqNlRROXdNclkwYWJYSlpDOGswSEpoYnJJc2NEdWV5N29iVnMz?=
 =?utf-8?B?SnFxeHFCRUIxWUNHcjdvcUxoZ08xV3JSQzdKS1dmNDFoeXNBYWRHb2ZRdDlv?=
 =?utf-8?B?MWRYQUdNMlRFOS9vR1FMb1MxMHBJR2Y3Q2N5WWtRTHE0ZjM5ODJTT0QxZTN3?=
 =?utf-8?B?QVArby9GdTJ4SFIwM004NkFmK1dVZk9wYmRwd0M3dWcwSVBSQzNQUT09?=
X-Exchange-RoutingPolicyChecked: AhtgRSbjqc+ftEWs/20FS3bplbmnoZ1S4S+eLo2RpD2H+IDZxrOp22XF9JCO72jOJcIBtPYpUeOzsXpdmZPUf4FxQ+7Dd8XlE/9IdJCFJzQ7pwphb197M75G5Xx0jmXuf6YosrTfHlFUBKGfb0iM1lCi8iePsUmJMguG25WTpTYz7Z79itGYsnV4BctTvM/f7tNCFTJ9HQzq4UT762IAZJoLQO81SlgOUdr8rJDNw2Qs/qv/fZyxcAifGBIKkQo0S6ubWuPg8mrN6WQzj+g6dWEgDJdykDjtL+M3CQh4ZE0R82qQ7pWVCUd8flUASaFzmqKeuZvPtvv35X7cx2MsNg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a205a147-7a70-41fe-1574-08def698e010
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5709.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 04:35:59.1151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYD2L9WjqNgMGP0lpLgmhU7I0AFRK/OwuPfm9vn6xQg9xlW8VeE1i0aVvaE3C50/fIfRdX2dylOmr4axnQHvgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7448
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

--------------y1CsS5q3iAluuBmo0h4PYegc
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit


On 08-08-2026 04:37, Matthew Brost wrote:
> On Fri, Aug 07, 2026 at 01:42:44PM +0530, Arvind Yadav wrote:
>> A device-private folio migrated to system memory by a CPU fault can
>> remain reachable through the raw-PFN eviction path until migration
>> finalization drops the source reference.
>>
>> If eviction selects the same device folio during this window, it can
>> attempt to migrate the folio again. The second migration can leave an
>> uncharged folio on an LRU list, causing folio_lruvec_lock_irqsave() to
>> retry indefinitely and resulting in a soft lockup and RCU stall.
>>
>> Mark successfully migrated device folios using a low bit of their
>> zone_device_data before migration finalization. Make raw-PFN eviction
>> skip folios carrying this flag.
>>
>> Mask the flag when retrieving the drm_pagemap_zdd pointer and preserve
>> it when a device folio is split. Keeping the state on the physical folio
>> also avoids depending on a virtual address that may change before a
>> fault occurs.
>>
>> v2:
>> - Replace the retired-PFN XArray with an embedded bitmap.(Matthew Brost)
>> - Mark every base page covered by a migrated folio so retirement remains
>>    valid if the folio is later split.
>>
>> v3:
>> - Store the migrated state in a low bit of zone_device_data instead of
>>    adding virtual-range and bitmap tracking to the ZDD. (Matthew Brost)
>> - Mask the flag when retrieving the ZDD and preserve it when splitting
>>    a folio.
>> - Drop the pre-existing fixes already covered by Matthew Brost's series:
>>    https://patchwork.freedesktop.org/series/171651/
>>
>> v4:
>> - Advance by the folio size only for migration entries marked with
>>    MIGRATE_PFN_COMPOUND. (Sashiko)
>>
>> The lockup was observed as:
>> [10109.860465] watchdog: BUG: soft lockup - CPU#9 stuck for 26s! [kworker/u65:5:6557]
>> [10109.860524] Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE
>> [10109.860524] Hardware name: ASUS System Product Name/PRIME Z790-P WIFI, BIOS 0812 02/24/2023
>> [10109.860525] Workqueue: xe_page_fault_work_queue xe_pagefault_queue_work [xe]
>> [10109.860644] RIP: 0010:_raw_spin_unlock_irqrestore+0x57/0x80
>> [10109.860655] Call Trace:
>> [10109.860655]  <TASK>
>> [10109.860657]  folio_lruvec_lock_irqsave+0x216/0x220
>> [10109.860661]  ? __pfx_lru_add+0x10/0x10
>> [10109.860665]  folio_batch_move_lru+0xc8/0x450
>> [10109.860670]  ? lock_acquire+0xc4/0x2d0
>> [10109.860674]  ? __folio_batch_add_and_move+0x60/0x2e0
>> [10109.860677]  ? folio_migrate_mapping+0xa6/0x110
>> [10109.860679]  ? folio_migrate_flags+0x13b/0x1b0
>> [10109.860681]  ? __pfx_lru_add+0x10/0x10
>> [10109.860683]  __folio_batch_add_and_move+0xe7/0x2e0
>> [10109.860685]  ? dma_iova_try_alloc+0xb0/0x140
>> [10109.860689]  folio_add_lru+0x64/0x80
>> [10109.860691]  __migrate_device_finalize+0x12c/0x270
>> [10109.860695]  migrate_device_finalize+0x10/0x20
>> [10109.860698]  drm_pagemap_evict_to_ram+0x185/0x370 [drm_gpusvm_helper]
>> [10109.860704]  ? drm_pagemap_evict_to_ram+0x96/0x370 [drm_gpusvm_helper]
>> [10109.860709]  xe_svm_bo_evict+0x15/0x20 [xe]
>> [10109.860819]  ? xe_svm_bo_evict+0x15/0x20 [xe]
>> [10109.860921]  xe_bo_move+0x107e/0x1570 [xe]
>> [10109.860992]  ? xe_ttm_tt_create+0x168/0x340 [xe]
>> [10109.861059]  ? __up_read+0x98/0x2b0
>> [10109.861061]  ? lock_is_held_type+0xa3/0x130
>> [10109.861067]  ttm_bo_handle_move_mem+0xe8/0x1e0 [ttm]
>> [10109.861075]  ttm_bo_evict+0x141/0x1c0 [ttm]
>> [10109.861081]  ttm_bo_evict_cb+0x9f/0x100 [ttm]
>> [10109.861086]  ttm_lru_walk_for_evict+0x84/0x190 [ttm]
>> [10109.861091]  ? xe_ttm_vram_mgr_new+0x258/0x3a0 [xe]
>> [10109.861198]  ttm_bo_alloc_resource+0x219/0x750 [ttm]
>> [10109.861203]  ? ttm_bo_alloc_resource+0xa9/0x750 [ttm]
>> [10109.861208]  ? lock_acquire+0xc4/0x2d0
>> [10109.861214]  ttm_bo_validate+0x94/0x1c0 [ttm]
>> [10109.861218]  ? ww_mutex_trylock+0x19d/0x3d0
>> [10109.861219]  ? _raw_write_unlock+0x22/0x50
>> [10109.861223]  ttm_bo_init_reserved+0x17d/0x1f0 [ttm]
>> [10109.861228]  xe_bo_init_locked+0x20a/0x620 [xe]
>> [10109.861294]  ? __pfx_xe_ttm_bo_destroy+0x10/0x10 [xe]
>> [10109.861359]  ? mark_held_locks+0x46/0x90
>> [10109.861361]  ? __create_object+0x68/0xc0
>> [10109.861366]  __xe_bo_create_locked+0x384/0xa20 [xe]
>> [10109.861432]  ? lock_acquire+0xc4/0x2d0
>> [10109.861434]  ? xe_drm_pagemap_populate_mm+0xd3/0x340 [xe]
>> [10109.861542]  xe_bo_create_locked+0x23/0x40 [xe]
>> [10109.861609]  xe_drm_pagemap_populate_mm+0x12e/0x340 [xe]
>> [10109.861707]  ? __lock_acquire+0x43e/0x2930
>> [10109.861716]  drm_pagemap_populate_mm+0x74/0xe0 [drm_gpusvm_helper]
>> [10109.861720]  xe_svm_alloc_vram+0xb5/0x2c0 [xe]
>> [10109.861817]  ? seqcount_lockdep_reader_access.constprop.0+0x9f/0xc0
>> [10109.861819]  ? ktime_get+0x23/0x130
>> [10109.861821]  ? trace_hardirqs_on+0x22/0xe0
>> [10109.861823]  ? seqcount_lockdep_reader_access.constprop.0+0x9f/0xc0
>> [10109.861826]  __xe_svm_handle_pagefault+0x77d/0xbf0 [xe]
>> [10109.861924]  ? rwsem_down_write_slowpath+0x43a/0x9a0
>> [10109.861926]  ? _raw_spin_unlock_irq+0x27/0x70
>> [10109.861928]  ? rwsem_down_write_slowpath+0x43a/0x9a0
>> [10109.861929]  ? trace_hardirqs_on+0x22/0xe0
>> [10109.861931]  ? _raw_spin_unlock_irq+0x27/0x70
>> [10109.861933]  ? rwsem_down_write_slowpath+0x459/0x9a0
>> [10109.861937]  xe_svm_handle_pagefault+0x3d/0xb0 [xe]
>> [10109.862030]  xe_pagefault_queue_work+0x1a9/0x520 [xe]
>> [10109.862122]  process_one_work+0x239/0x730
>> [10109.862127]  worker_thread+0x200/0x3f0
>> [10109.862130]  ? __pfx_worker_thread+0x10/0x10
>> [10109.862132]  kthread+0x10d/0x150
>> [10109.862133]  ? __pfx_kthread+0x10/0x10
>> [10109.862135]  ret_from_fork+0x3bd/0x470
>> [10109.862138]  ? __pfx_kthread+0x10/0x10
>> [10109.862140]  ret_from_fork_asm+0x1a/0x30
>> [10109.862146]  </TASK>
>>
>> Fixes: 99624bdff867 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")
>> Cc: Maarten Lankhorst<maarten.lankhorst@linux.intel.com>
>> Cc: Maxime Ripard<mripard@kernel.org>
>> Cc: Matthew Brost<matthew.brost@intel.com>
> Mostly nits.
>
>> Cc: Thomas Zimmermann<tzimmermann@suse.de>
>> Cc: David Airlie<airlied@gmail.com>
>> Cc: Simona Vetter<simona@ffwll.ch>
>> Cc: Thomas Hellström<thomas.hellstrom@linux.intel.com>
>> Cc: Himal Prasad Ghimiray<himal.prasad.ghimiray@intel.com>
>> Assisted-by: Claude:claude-opus-4-8
>> Suggested-by: Matthew Brost<matthew.brost@intel.com>
>> Signed-off-by: Arvind Yadav<arvind.yadav@intel.com>
>> ---
>>   drivers/gpu/drm/drm_pagemap.c | 124 ++++++++++++++++++++++++++++++++--
>>   include/drm/drm_pagemap.h     |   8 ++-
>>   2 files changed, 127 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
>> index 892b325fa99b..c1112d492d64 100644
>> --- a/drivers/gpu/drm/drm_pagemap.c
>> +++ b/drivers/gpu/drm/drm_pagemap.c
>> @@ -1102,12 +1102,119 @@ void drm_pagemap_put(struct drm_pagemap *dpagemap)
>>   }
>>   EXPORT_SYMBOL(drm_pagemap_put);
>>   
>> +/**
>> + * drm_pagemap_page_get_flags() - Read the drm_pagemap flags of a device folio
>> + * @page: Pointer to a page of the device folio
>> + *
>> + * Return: The DRM_PAGEMAP_ZDD_FLAG_* bits encoded in zone_device_data.
>> + */
>> +static unsigned long drm_pagemap_page_get_flags(struct page *page)
>> +{
>> +	struct folio *folio = page_folio(page);
>> +
>> +	return (unsigned long)folio_zone_device_data(folio) &
>> +		DRM_PAGEMAP_ZDD_FLAG_MASK;
>> +}
>> +
>> +/**
>> + * drm_pagemap_page_set_flags() - Set the drm_pagemap flags of a device folio
>> + * @page: Pointer to a page of the device folio
>> + * @flags: DRM_PAGEMAP_ZDD_FLAG_* bits to set
>> + *
>> + * Preserve any flags already encoded alongside the ZDD pointer.
>> + */
>> +static void drm_pagemap_page_set_flags(struct page *page,
>> +				       unsigned long flags)
>> +{
>> +	struct folio *folio = page_folio(page);
>> +	struct drm_pagemap_zdd *zdd;
>> +
>> +	if (WARN_ON_ONCE(flags & ~DRM_PAGEMAP_ZDD_FLAG_MASK))
>> +		return;
>> +
>> +	zdd = drm_pagemap_page_zone_device_data(page);
>> +	flags |= drm_pagemap_page_get_flags(page);
>> +	folio_set_zone_device_data(folio,
>> +				   (void *)((unsigned long)zdd | flags));
> One could write this like:
>
> unsigned long old;
>
> old = (unsigned long)folio_zone_device_data(folio);
> folio_set_zone_device_data(folio, (void *)(old | flags));


Noted,

>
>> +}
>> +
>> +/**
>> + * drm_pagemap_retire_migrated_pages() - Record migrated device folios
>> + * @src_pfns: source array after migrate_vma_pages() or migrate_device_pages()
>> + * @npages: number of entries in @src_pfns
>> + *
>> + * Flag device folios that were successfully migrated to RAM before finalize
>> + * unlocks the sources. The migrated state is stored in the physical folio, so
>> + * it survives later folio splits and a subsequent raw-PFN eviction can skip it.
>> + */
>> +static void drm_pagemap_retire_migrated_pages(unsigned long *src_pfns,
>> +					      unsigned long npages)
>> +{
>> +	unsigned long i = 0;
>> +
>> +	while (i < npages) {
>> +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
>> +		unsigned long nr = 1;
>> +
>> +		if (!page) {
>> +			i++;
>> +			continue;
>> +		}
>> +
>> +		if (src_pfns[i] & MIGRATE_PFN_COMPOUND)
>> +			nr = folio_nr_pages(page_folio(page));
> You could omit the 'src_pfns[i] & MIGRATE_PFN_COMPOUND' check as
> folio_nr_pages returns 1 for non-compound pages.


Agreed. Populated migration entries refer to the folio head, and 
|folio_nr_pages()| returns 1 for an order-0 folio. I’ll drop the 
compound check.

>
>> +
>> +		if ((src_pfns[i] & MIGRATE_PFN_MIGRATE) &&
>> +		    is_device_private_page(page))
> When this called from drm_pagemap_evict_to_ram this could be a coherrent
> page. I'd just drop the page type check.


I think this check should remain. The zone-device-data helpers warn for 
non-private pages, and this fix only applies to device-private pages.

>
>> +			drm_pagemap_page_set_flags(page,
>> +						   DRM_PAGEMAP_ZDD_FLAG_MIGRATED);
>> +
>> +		i += nr;
> You could drop nr and just make this:
>
> i += folio_nr_pages(page_folio(page));


Noted,

>
>> +	}
>> +}
>> +
>> +/**
>> + * drm_pagemap_skip_retired_pages() - Drop retired PFNs from a raw-PFN eviction
>> + * @src_pfns: source array after migrate_device_pfns() (MIGRATE_PFN encoded)
>> + * @npages: number of entries in @src_pfns
>> + *
>> + * Skip source folios already migrated to RAM, identified by the migrated flag
>> + * stored in the physical folio's zone_device_data.
>> + */
>> +static void drm_pagemap_skip_retired_pages(unsigned long *src_pfns,
>> +					   unsigned long npages)
>> +{
>> +	unsigned long i = 0;
>> +
>> +	while (i < npages) {
>> +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
>> +		unsigned long nr = 1;
>> +
>> +		if (!page) {
>> +			i++;
>> +			continue;
>> +		}
>> +
>> +		if (src_pfns[i] & MIGRATE_PFN_COMPOUND)
>> +			nr = folio_nr_pages(page_folio(page));
> Same as above wrt MIGRATE_PFN_COMPOUND check not being needed.


Agreed, same change here.

>
>> +
>> +		if ((src_pfns[i] & MIGRATE_PFN_MIGRATE) &&
>> +		    is_device_private_page(page) &&
> Same as above wrt device_private_page.


Agreed, same change here.

>
>> +		    (drm_pagemap_page_get_flags(page) &
>> +		     DRM_PAGEMAP_ZDD_FLAG_MIGRATED))
>> +			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
>> +
>> +		i += nr;
> Same as above about dropping NR.


Agreed, same change here.

>
>> +	}
>> +}
>> +
>>   /**
>>    * drm_pagemap_evict_to_ram() - Evict GPU SVM range to RAM
>>    * @devmem_allocation: Pointer to the device memory allocation
>>    *
>> - * Similar to __drm_pagemap_migrate_to_ram but does not require mmap lock and
>> - * migration done via migrate_device_* functions.
>> + * Similar to __drm_pagemap_migrate_to_ram(), but uses the
>> + * migrate_device_* helpers and does not require the mmap lock. Device
>> + * PFNs already migrated to RAM by either migration path are skipped.
>>    *
>>    * Return: 0 on success, negative error code on failure.
>>    */
>> @@ -1148,6 +1255,8 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
>>   	if (err)
>>   		goto err_free;
>>   
>> +	drm_pagemap_skip_retired_pages(src, npages);
>> +
>>   	err = drm_pagemap_migrate_populate_ram_pfn(NULL, NULL, npages, &mpages,
>>   						   src, dst, 0);
>>   	if (err || !mpages)
>> @@ -1178,6 +1287,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
>>   	if (err)
>>   		drm_pagemap_migration_unlock_put_pages(npages, dst);
>>   	migrate_device_pages(src, dst, npages);
>> +	drm_pagemap_retire_migrated_pages(src, npages);
> Since we retire the pages here too, should the
> __drm_pagemap_migrate_to_ram also call drm_pagemap_skip_retired_pages?


Agreed. I will call |drm_pagemap_skip_retired_pages()| after 
|migrate_vma_setup()| and before destination allocation.

>
>>   	migrate_device_finalize(src, dst, npages);
>>   	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, dst, npages,
>>   					DMA_FROM_DEVICE, &state);
>> @@ -1308,6 +1418,7 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
>>   	if (err)
>>   		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
>>   	migrate_vma_pages(&migrate);
>> +	drm_pagemap_retire_migrated_pages(migrate.src, npages);
>>   	migrate_vma_finalize(&migrate);
>>   	if (dev)
>>   		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, migrate.dst,
>> @@ -1360,13 +1471,18 @@ static vm_fault_t drm_pagemap_migrate_to_ram(struct vm_fault *vmf)
>>   static void drm_pagemap_folio_split(struct folio *orig_folio, struct folio *new_folio)
>>   {
>>   	struct drm_pagemap_zdd *zdd;
>> +	struct page *page;
>> +	unsigned long flags;
>>   
>>   	if (!new_folio)
>>   		return;
>>   
>>   	new_folio->pgmap = orig_folio->pgmap;
>> -	zdd = folio_zone_device_data(orig_folio);
>> -	folio_set_zone_device_data(new_folio, drm_pagemap_zdd_get(zdd));
>> +	page = folio_page(orig_folio, 0);
>> +	zdd = drm_pagemap_page_zone_device_data(page);
>> +	flags = drm_pagemap_page_get_flags(page);
> folio_set_zone_device_data(new_folio, folio_zone_device_data(orig_folio));
>
> ?


We cannot copy it directly because the new folio needs its own ZDD 
reference. I will keep drm_pagemap_zdd_get() and preserve the flag bits.

Thanks,
Arvind

>
> Matt
>
>> +	folio_set_zone_device_data(new_folio,
>> +				   (void *)((unsigned long)drm_pagemap_zdd_get(zdd) | flags));
>>   }
>>   
>>   static const struct dev_pagemap_ops drm_pagemap_pagemap_ops = {
>> diff --git a/include/drm/drm_pagemap.h b/include/drm/drm_pagemap.h
>> index 95eb4b66b057..ebbd3b0ddf36 100644
>> --- a/include/drm/drm_pagemap.h
>> +++ b/include/drm/drm_pagemap.h
>> @@ -2,6 +2,7 @@
>>   #ifndef _DRM_PAGEMAP_H_
>>   #define _DRM_PAGEMAP_H_
>>   
>> +#include <linux/bits.h>
>>   #include <linux/dma-direction.h>
>>   #include <linux/hmm.h>
>>   #include <linux/memremap.h>
>> @@ -339,6 +340,9 @@ struct drm_pagemap_migrate_details {
>>   
>>   #if IS_ENABLED(CONFIG_ZONE_DEVICE)
>>   
>> +#define DRM_PAGEMAP_ZDD_FLAG_MIGRATED	BIT(0)
>> +#define DRM_PAGEMAP_ZDD_FLAG_MASK	DRM_PAGEMAP_ZDD_FLAG_MIGRATED
>> +
>>   int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
>>   				  struct mm_struct *mm,
>>   				  unsigned long start, unsigned long end,
>> @@ -373,7 +377,9 @@ static inline struct drm_pagemap_zdd *drm_pagemap_page_zone_device_data(struct p
>>   {
>>   	struct folio *folio = page_folio(page);
>>   
>> -	return folio_zone_device_data(folio);
>> +	return (struct drm_pagemap_zdd *)
>> +		((unsigned long)folio_zone_device_data(folio) &
>> +		 ~DRM_PAGEMAP_ZDD_FLAG_MASK);
>>   }
>>   
>>   #else
>> -- 
>> 2.43.0
>>
--------------y1CsS5q3iAluuBmo0h4PYegc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 08-08-2026 04:37, Matthew Brost
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:anZlLADT45F75WKQ@gsse-cloud1.jf.intel.com">
      <pre wrap="" class="moz-quote-pre">On Fri, Aug 07, 2026 at 01:42:44PM +0530, Arvind Yadav wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">A device-private folio migrated to system memory by a CPU fault can
remain reachable through the raw-PFN eviction path until migration
finalization drops the source reference.

If eviction selects the same device folio during this window, it can
attempt to migrate the folio again. The second migration can leave an
uncharged folio on an LRU list, causing folio_lruvec_lock_irqsave() to
retry indefinitely and resulting in a soft lockup and RCU stall.

Mark successfully migrated device folios using a low bit of their
zone_device_data before migration finalization. Make raw-PFN eviction
skip folios carrying this flag.

Mask the flag when retrieving the drm_pagemap_zdd pointer and preserve
it when a device folio is split. Keeping the state on the physical folio
also avoids depending on a virtual address that may change before a
fault occurs.

v2:
- Replace the retired-PFN XArray with an embedded bitmap.(Matthew Brost)
- Mark every base page covered by a migrated folio so retirement remains
  valid if the folio is later split.

v3:
- Store the migrated state in a low bit of zone_device_data instead of
  adding virtual-range and bitmap tracking to the ZDD. (Matthew Brost)
- Mask the flag when retrieving the ZDD and preserve it when splitting
  a folio.
- Drop the pre-existing fixes already covered by Matthew Brost's series:
  <a class="moz-txt-link-freetext" href="https://patchwork.freedesktop.org/series/171651/">https://patchwork.freedesktop.org/series/171651/</a>

v4:
- Advance by the folio size only for migration entries marked with
  MIGRATE_PFN_COMPOUND. (Sashiko)

The lockup was observed as:
[10109.860465] watchdog: BUG: soft lockup - CPU#9 stuck for 26s! [kworker/u65:5:6557]
[10109.860524] Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE
[10109.860524] Hardware name: ASUS System Product Name/PRIME Z790-P WIFI, BIOS 0812 02/24/2023
[10109.860525] Workqueue: xe_page_fault_work_queue xe_pagefault_queue_work [xe]
[10109.860644] RIP: 0010:_raw_spin_unlock_irqrestore+0x57/0x80
[10109.860655] Call Trace:
[10109.860655]  &lt;TASK&gt;
[10109.860657]  folio_lruvec_lock_irqsave+0x216/0x220
[10109.860661]  ? __pfx_lru_add+0x10/0x10
[10109.860665]  folio_batch_move_lru+0xc8/0x450
[10109.860670]  ? lock_acquire+0xc4/0x2d0
[10109.860674]  ? __folio_batch_add_and_move+0x60/0x2e0
[10109.860677]  ? folio_migrate_mapping+0xa6/0x110
[10109.860679]  ? folio_migrate_flags+0x13b/0x1b0
[10109.860681]  ? __pfx_lru_add+0x10/0x10
[10109.860683]  __folio_batch_add_and_move+0xe7/0x2e0
[10109.860685]  ? dma_iova_try_alloc+0xb0/0x140
[10109.860689]  folio_add_lru+0x64/0x80
[10109.860691]  __migrate_device_finalize+0x12c/0x270
[10109.860695]  migrate_device_finalize+0x10/0x20
[10109.860698]  drm_pagemap_evict_to_ram+0x185/0x370 [drm_gpusvm_helper]
[10109.860704]  ? drm_pagemap_evict_to_ram+0x96/0x370 [drm_gpusvm_helper]
[10109.860709]  xe_svm_bo_evict+0x15/0x20 [xe]
[10109.860819]  ? xe_svm_bo_evict+0x15/0x20 [xe]
[10109.860921]  xe_bo_move+0x107e/0x1570 [xe]
[10109.860992]  ? xe_ttm_tt_create+0x168/0x340 [xe]
[10109.861059]  ? __up_read+0x98/0x2b0
[10109.861061]  ? lock_is_held_type+0xa3/0x130
[10109.861067]  ttm_bo_handle_move_mem+0xe8/0x1e0 [ttm]
[10109.861075]  ttm_bo_evict+0x141/0x1c0 [ttm]
[10109.861081]  ttm_bo_evict_cb+0x9f/0x100 [ttm]
[10109.861086]  ttm_lru_walk_for_evict+0x84/0x190 [ttm]
[10109.861091]  ? xe_ttm_vram_mgr_new+0x258/0x3a0 [xe]
[10109.861198]  ttm_bo_alloc_resource+0x219/0x750 [ttm]
[10109.861203]  ? ttm_bo_alloc_resource+0xa9/0x750 [ttm]
[10109.861208]  ? lock_acquire+0xc4/0x2d0
[10109.861214]  ttm_bo_validate+0x94/0x1c0 [ttm]
[10109.861218]  ? ww_mutex_trylock+0x19d/0x3d0
[10109.861219]  ? _raw_write_unlock+0x22/0x50
[10109.861223]  ttm_bo_init_reserved+0x17d/0x1f0 [ttm]
[10109.861228]  xe_bo_init_locked+0x20a/0x620 [xe]
[10109.861294]  ? __pfx_xe_ttm_bo_destroy+0x10/0x10 [xe]
[10109.861359]  ? mark_held_locks+0x46/0x90
[10109.861361]  ? __create_object+0x68/0xc0
[10109.861366]  __xe_bo_create_locked+0x384/0xa20 [xe]
[10109.861432]  ? lock_acquire+0xc4/0x2d0
[10109.861434]  ? xe_drm_pagemap_populate_mm+0xd3/0x340 [xe]
[10109.861542]  xe_bo_create_locked+0x23/0x40 [xe]
[10109.861609]  xe_drm_pagemap_populate_mm+0x12e/0x340 [xe]
[10109.861707]  ? __lock_acquire+0x43e/0x2930
[10109.861716]  drm_pagemap_populate_mm+0x74/0xe0 [drm_gpusvm_helper]
[10109.861720]  xe_svm_alloc_vram+0xb5/0x2c0 [xe]
[10109.861817]  ? seqcount_lockdep_reader_access.constprop.0+0x9f/0xc0
[10109.861819]  ? ktime_get+0x23/0x130
[10109.861821]  ? trace_hardirqs_on+0x22/0xe0
[10109.861823]  ? seqcount_lockdep_reader_access.constprop.0+0x9f/0xc0
[10109.861826]  __xe_svm_handle_pagefault+0x77d/0xbf0 [xe]
[10109.861924]  ? rwsem_down_write_slowpath+0x43a/0x9a0
[10109.861926]  ? _raw_spin_unlock_irq+0x27/0x70
[10109.861928]  ? rwsem_down_write_slowpath+0x43a/0x9a0
[10109.861929]  ? trace_hardirqs_on+0x22/0xe0
[10109.861931]  ? _raw_spin_unlock_irq+0x27/0x70
[10109.861933]  ? rwsem_down_write_slowpath+0x459/0x9a0
[10109.861937]  xe_svm_handle_pagefault+0x3d/0xb0 [xe]
[10109.862030]  xe_pagefault_queue_work+0x1a9/0x520 [xe]
[10109.862122]  process_one_work+0x239/0x730
[10109.862127]  worker_thread+0x200/0x3f0
[10109.862130]  ? __pfx_worker_thread+0x10/0x10
[10109.862132]  kthread+0x10d/0x150
[10109.862133]  ? __pfx_kthread+0x10/0x10
[10109.862135]  ret_from_fork+0x3bd/0x470
[10109.862138]  ? __pfx_kthread+0x10/0x10
[10109.862140]  ret_from_fork_asm+0x1a/0x30
[10109.862146]  &lt;/TASK&gt;

Fixes: 99624bdff867 (&quot;drm/gpusvm: Add support for GPU Shared Virtual Memory&quot;)
Cc: Maarten Lankhorst <a class="moz-txt-link-rfc2396E" href="mailto:maarten.lankhorst@linux.intel.com">&lt;maarten.lankhorst@linux.intel.com&gt;</a>
Cc: Maxime Ripard <a class="moz-txt-link-rfc2396E" href="mailto:mripard@kernel.org">&lt;mripard@kernel.org&gt;</a>
Cc: Matthew Brost <a class="moz-txt-link-rfc2396E" href="mailto:matthew.brost@intel.com">&lt;matthew.brost@intel.com&gt;</a>
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Mostly nits.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Cc: Thomas Zimmermann <a class="moz-txt-link-rfc2396E" href="mailto:tzimmermann@suse.de">&lt;tzimmermann@suse.de&gt;</a>
Cc: David Airlie <a class="moz-txt-link-rfc2396E" href="mailto:airlied@gmail.com">&lt;airlied@gmail.com&gt;</a>
Cc: Simona Vetter <a class="moz-txt-link-rfc2396E" href="mailto:simona@ffwll.ch">&lt;simona@ffwll.ch&gt;</a>
Cc: Thomas Hellström <a class="moz-txt-link-rfc2396E" href="mailto:thomas.hellstrom@linux.intel.com">&lt;thomas.hellstrom@linux.intel.com&gt;</a>
Cc: Himal Prasad Ghimiray <a class="moz-txt-link-rfc2396E" href="mailto:himal.prasad.ghimiray@intel.com">&lt;himal.prasad.ghimiray@intel.com&gt;</a>
Assisted-by: Claude:claude-opus-4-8
Suggested-by: Matthew Brost <a class="moz-txt-link-rfc2396E" href="mailto:matthew.brost@intel.com">&lt;matthew.brost@intel.com&gt;</a>
Signed-off-by: Arvind Yadav <a class="moz-txt-link-rfc2396E" href="mailto:arvind.yadav@intel.com">&lt;arvind.yadav@intel.com&gt;</a>
---
 drivers/gpu/drm/drm_pagemap.c | 124 ++++++++++++++++++++++++++++++++--
 include/drm/drm_pagemap.h     |   8 ++-
 2 files changed, 127 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 892b325fa99b..c1112d492d64 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -1102,12 +1102,119 @@ void drm_pagemap_put(struct drm_pagemap *dpagemap)
 }
 EXPORT_SYMBOL(drm_pagemap_put);
 
+/**
+ * drm_pagemap_page_get_flags() - Read the drm_pagemap flags of a device folio
+ * @page: Pointer to a page of the device folio
+ *
+ * Return: The DRM_PAGEMAP_ZDD_FLAG_* bits encoded in zone_device_data.
+ */
+static unsigned long drm_pagemap_page_get_flags(struct page *page)
+{
+	struct folio *folio = page_folio(page);
+
+	return (unsigned long)folio_zone_device_data(folio) &amp;
+		DRM_PAGEMAP_ZDD_FLAG_MASK;
+}
+
+/**
+ * drm_pagemap_page_set_flags() - Set the drm_pagemap flags of a device folio
+ * @page: Pointer to a page of the device folio
+ * @flags: DRM_PAGEMAP_ZDD_FLAG_* bits to set
+ *
+ * Preserve any flags already encoded alongside the ZDD pointer.
+ */
+static void drm_pagemap_page_set_flags(struct page *page,
+				       unsigned long flags)
+{
+	struct folio *folio = page_folio(page);
+	struct drm_pagemap_zdd *zdd;
+
+	if (WARN_ON_ONCE(flags &amp; ~DRM_PAGEMAP_ZDD_FLAG_MASK))
+		return;
+
+	zdd = drm_pagemap_page_zone_device_data(page);
+	flags |= drm_pagemap_page_get_flags(page);
+	folio_set_zone_device_data(folio,
+				   (void *)((unsigned long)zdd | flags));
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
One could write this like:

unsigned long old;

old = (unsigned long)folio_zone_device_data(folio);
folio_set_zone_device_data(folio, (void *)(old | flags));</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Noted,</p>
    <blockquote type="cite" cite="mid:anZlLADT45F75WKQ@gsse-cloud1.jf.intel.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+}
+
+/**
+ * drm_pagemap_retire_migrated_pages() - Record migrated device folios
+ * @src_pfns: source array after migrate_vma_pages() or migrate_device_pages()
+ * @npages: number of entries in @src_pfns
+ *
+ * Flag device folios that were successfully migrated to RAM before finalize
+ * unlocks the sources. The migrated state is stored in the physical folio, so
+ * it survives later folio splits and a subsequent raw-PFN eviction can skip it.
+ */
+static void drm_pagemap_retire_migrated_pages(unsigned long *src_pfns,
+					      unsigned long npages)
+{
+	unsigned long i = 0;
+
+	while (i &lt; npages) {
+		struct page *page = migrate_pfn_to_page(src_pfns[i]);
+		unsigned long nr = 1;
+
+		if (!page) {
+			i++;
+			continue;
+		}
+
+		if (src_pfns[i] &amp; MIGRATE_PFN_COMPOUND)
+			nr = folio_nr_pages(page_folio(page));
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
You could omit the 'src_pfns[i] &amp; MIGRATE_PFN_COMPOUND' check as
folio_nr_pages returns 1 for non-compound pages.</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Agreed. Populated migration entries refer to the folio head, and
      <code data-start="4822" data-end="4840">folio_nr_pages()</code>
      returns 1 for an order-0 folio. I’ll drop the compound check.</p>
    <blockquote type="cite" cite="mid:anZlLADT45F75WKQ@gsse-cloud1.jf.intel.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+
+		if ((src_pfns[i] &amp; MIGRATE_PFN_MIGRATE) &amp;&amp;
+		    is_device_private_page(page))
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
When this called from drm_pagemap_evict_to_ram this could be a coherrent
page. I'd just drop the page type check.</pre>
    </blockquote>
    <p><br>
    </p>
    <p>I think this check should remain. The zone-device-data helpers
      warn for non-private pages, and this fix only applies to
      device-private pages.</p>
    <blockquote type="cite" cite="mid:anZlLADT45F75WKQ@gsse-cloud1.jf.intel.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+			drm_pagemap_page_set_flags(page,
+						   DRM_PAGEMAP_ZDD_FLAG_MIGRATED);
+
+		i += nr;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
You could drop nr and just make this:

i += folio_nr_pages(page_folio(page));</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Noted,</p>
    <blockquote type="cite" cite="mid:anZlLADT45F75WKQ@gsse-cloud1.jf.intel.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+	}
+}
+
+/**
+ * drm_pagemap_skip_retired_pages() - Drop retired PFNs from a raw-PFN eviction
+ * @src_pfns: source array after migrate_device_pfns() (MIGRATE_PFN encoded)
+ * @npages: number of entries in @src_pfns
+ *
+ * Skip source folios already migrated to RAM, identified by the migrated flag
+ * stored in the physical folio's zone_device_data.
+ */
+static void drm_pagemap_skip_retired_pages(unsigned long *src_pfns,
+					   unsigned long npages)
+{
+	unsigned long i = 0;
+
+	while (i &lt; npages) {
+		struct page *page = migrate_pfn_to_page(src_pfns[i]);
+		unsigned long nr = 1;
+
+		if (!page) {
+			i++;
+			continue;
+		}
+
+		if (src_pfns[i] &amp; MIGRATE_PFN_COMPOUND)
+			nr = folio_nr_pages(page_folio(page));
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Same as above wrt MIGRATE_PFN_COMPOUND check not being needed.</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Agreed, same change here.</p>
    <blockquote type="cite" cite="mid:anZlLADT45F75WKQ@gsse-cloud1.jf.intel.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+
+		if ((src_pfns[i] &amp; MIGRATE_PFN_MIGRATE) &amp;&amp;
+		    is_device_private_page(page) &amp;&amp;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Same as above wrt device_private_page.</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Agreed, same change here.</p>
    <blockquote type="cite" cite="mid:anZlLADT45F75WKQ@gsse-cloud1.jf.intel.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+		    (drm_pagemap_page_get_flags(page) &amp;
+		     DRM_PAGEMAP_ZDD_FLAG_MIGRATED))
+			src_pfns[i] &amp;= ~MIGRATE_PFN_MIGRATE;
+
+		i += nr;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Same as above about dropping NR.</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Agreed, same change here.</p>
    <blockquote type="cite" cite="mid:anZlLADT45F75WKQ@gsse-cloud1.jf.intel.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+	}
+}
+
 /**
  * drm_pagemap_evict_to_ram() - Evict GPU SVM range to RAM
  * @devmem_allocation: Pointer to the device memory allocation
  *
- * Similar to __drm_pagemap_migrate_to_ram but does not require mmap lock and
- * migration done via migrate_device_* functions.
+ * Similar to __drm_pagemap_migrate_to_ram(), but uses the
+ * migrate_device_* helpers and does not require the mmap lock. Device
+ * PFNs already migrated to RAM by either migration path are skipped.
  *
  * Return: 0 on success, negative error code on failure.
  */
@@ -1148,6 +1255,8 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
 	if (err)
 		goto err_free;
 
+	drm_pagemap_skip_retired_pages(src, npages);
+
 	err = drm_pagemap_migrate_populate_ram_pfn(NULL, NULL, npages, &amp;mpages,
 						   src, dst, 0);
 	if (err || !mpages)
@@ -1178,6 +1287,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
 	if (err)
 		drm_pagemap_migration_unlock_put_pages(npages, dst);
 	migrate_device_pages(src, dst, npages);
+	drm_pagemap_retire_migrated_pages(src, npages);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Since we retire the pages here too, should the
__drm_pagemap_migrate_to_ram also call drm_pagemap_skip_retired_pages?</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Agreed. I will call <code data-start="6187" data-end="6221">drm_pagemap_skip_retired_pages()</code>
      after <code data-start="6228" data-end="6249">migrate_vma_setup()</code>
      and before destination allocation.</p>
    <blockquote type="cite" cite="mid:anZlLADT45F75WKQ@gsse-cloud1.jf.intel.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 	migrate_device_finalize(src, dst, npages);
 	drm_pagemap_migrate_unmap_pages(devmem_allocation-&gt;dev, pagemap_addr, dst, npages,
 					DMA_FROM_DEVICE, &amp;state);
@@ -1308,6 +1418,7 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
 	if (err)
 		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
 	migrate_vma_pages(&amp;migrate);
+	drm_pagemap_retire_migrated_pages(migrate.src, npages);
 	migrate_vma_finalize(&amp;migrate);
 	if (dev)
 		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, migrate.dst,
@@ -1360,13 +1471,18 @@ static vm_fault_t drm_pagemap_migrate_to_ram(struct vm_fault *vmf)
 static void drm_pagemap_folio_split(struct folio *orig_folio, struct folio *new_folio)
 {
 	struct drm_pagemap_zdd *zdd;
+	struct page *page;
+	unsigned long flags;
 
 	if (!new_folio)
 		return;
 
 	new_folio-&gt;pgmap = orig_folio-&gt;pgmap;
-	zdd = folio_zone_device_data(orig_folio);
-	folio_set_zone_device_data(new_folio, drm_pagemap_zdd_get(zdd));
+	page = folio_page(orig_folio, 0);
+	zdd = drm_pagemap_page_zone_device_data(page);
+	flags = drm_pagemap_page_get_flags(page);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
folio_set_zone_device_data(new_folio, folio_zone_device_data(orig_folio));

?</pre>
    </blockquote>
    <p><br>
    </p>
    <p>We cannot copy it directly because the new folio needs its own
      ZDD reference. I will keep drm_pagemap_zdd_get() and preserve the
      flag bits.<br>
      <br>
    </p>
    <p>Thanks,<br>
      Arvind</p>
    <blockquote type="cite" cite="mid:anZlLADT45F75WKQ@gsse-cloud1.jf.intel.com">
      <pre wrap="" class="moz-quote-pre">

Matt

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+	folio_set_zone_device_data(new_folio,
+				   (void *)((unsigned long)drm_pagemap_zdd_get(zdd) | flags));
 }
 
 static const struct dev_pagemap_ops drm_pagemap_pagemap_ops = {
diff --git a/include/drm/drm_pagemap.h b/include/drm/drm_pagemap.h
index 95eb4b66b057..ebbd3b0ddf36 100644
--- a/include/drm/drm_pagemap.h
+++ b/include/drm/drm_pagemap.h
@@ -2,6 +2,7 @@
 #ifndef _DRM_PAGEMAP_H_
 #define _DRM_PAGEMAP_H_
 
+#include &lt;linux/bits.h&gt;
 #include &lt;linux/dma-direction.h&gt;
 #include &lt;linux/hmm.h&gt;
 #include &lt;linux/memremap.h&gt;
@@ -339,6 +340,9 @@ struct drm_pagemap_migrate_details {
 
 #if IS_ENABLED(CONFIG_ZONE_DEVICE)
 
+#define DRM_PAGEMAP_ZDD_FLAG_MIGRATED	BIT(0)
+#define DRM_PAGEMAP_ZDD_FLAG_MASK	DRM_PAGEMAP_ZDD_FLAG_MIGRATED
+
 int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 				  struct mm_struct *mm,
 				  unsigned long start, unsigned long end,
@@ -373,7 +377,9 @@ static inline struct drm_pagemap_zdd *drm_pagemap_page_zone_device_data(struct p
 {
 	struct folio *folio = page_folio(page);
 
-	return folio_zone_device_data(folio);
+	return (struct drm_pagemap_zdd *)
+		((unsigned long)folio_zone_device_data(folio) &amp;
+		 ~DRM_PAGEMAP_ZDD_FLAG_MASK);
 }
 
 #else
-- 
2.43.0

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------y1CsS5q3iAluuBmo0h4PYegc--
