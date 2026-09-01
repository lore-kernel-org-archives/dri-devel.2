Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD55C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:38:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98CEF10EBC0;
	Tue,  1 Sep 2026 07:38:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DHh7zRxW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AFFB10EBB1;
 Tue,  1 Sep 2026 07:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788248272; x=1819784272;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=JKyvGnIovW5Taq6OBLaDVD84H0jRi9Us4o544aOns/0=;
 b=DHh7zRxWj04hpi1fH/NHJpJQfTi+macSBzCpZeISGKw4D+QJ0daHEs0c
 DNnXGmBa5PRUJF5IoC911TmKgHHuWP+SlyCQmBcp5f+X5WRQ8TX4+d/wu
 GtItrR7/AdseDG1/gdyDVnNBPUAZ8UA5WMrCALVSZ6/3EyklnptMpgemC
 TSZMioqGQyQBYQQ7tay++Ozy8Zq7nZaZReGYE8sVR/sgiKyn7uaf3GLPR
 e1YftPOCPexuRq5S9f63ghOcmLDTWgrd4Qe85yHMiA/+x6Pjx9b3qv9j7
 E58zWjp7mjGjBL9mhPgwPq++zgniW7308YrbYJvfUKyGXyVgTKuSFfq3a A==;
X-CSE-ConnectionGUID: g5F93saKSOuBCf3l77fmcQ==
X-CSE-MsgGUID: y7bpDZGpQZWacdOHQWDhNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="99267959"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="99267959"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 00:37:52 -0700
X-CSE-ConnectionGUID: FNFR45TUQHOkb3fWERcTPw==
X-CSE-MsgGUID: 57Cayix6T/q98f180HAQ8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="262883749"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 00:37:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 00:37:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 00:37:51 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 00:37:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yY+f5bv6OiWf6IcedVkGzWTMZ9CZJimdrs+UfKLL0XiPJNd7dOQiye4IFI8PBc6+ZjzmXcF8LrVcdXtk5FGcAK7l/AJVDmCca49e+kGrjHTPh0fY/zSHe3vcPi2sFnIsJPaiiCJg9Xyp0Dz+5nA33Ah6wl6JQqaTf1fCpFSfpHmxkC5K44Ip3pv7SkBYHzhZRNJzARzz8k8Q4dWdMzm3xUCDuF4pnSkb2M372USOebjB4wYP2tS1zcHRJd5yvKtn2/bob9sWkZJQ/rtU+tjKLq2yMJXegkkpIOolXdIQNuntggqebwEg7WrXU1vOwA2CDeGD+ZV5Hz4ggq+6WLsDMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hV5idKCXE09yEEzQ2a3Np56UT4yDnE1lOzvZWLPbCFQ=;
 b=xVbFWWNwktQoOGrxqLaqat85Fd3Y2VVu/2EYQoEQSiLsYys9vXt6jE6GFftO8ZrlduMxFM7U7fOoju35uLgzzKvrgCjqwE7yExHPbHDALLX8ckpi6VgdwH84t9qb4guA/sF5ClB+ZFzvwA2Yg0dogI5L2bV/74TDglc3abUwK3ddzi2yJdNS3B3AFfKBhDkLzqt5DMscAU97amq+LvsD2zIWZQ7Kf8/xomJfgmA6svRMFNkN6sSwLfkZfg8n7fdPEbTtlRZaBy3vzXT4KONQAxNPLlvGSShX5yA3aMMFr5IMDyiwB3FcD45RgKQnR1EALOzmu+y1EgvoJcjrmcVQ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7636.namprd11.prod.outlook.com (2603:10b6:510:26f::13)
 by DS4PPFFCBF1B4C7.namprd11.prod.outlook.com (2603:10b6:f:fc02::62)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 07:37:49 +0000
Received: from PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b]) by PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b%5]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 07:37:49 +0000
Message-ID: <a27618eb-b5a8-4100-bf79-5b35fbfaf2de@intel.com>
Date: Tue, 1 Sep 2026 13:07:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 6/9] drm/i915/color: Add support for 1D LUT in SDR planes
To: "Shankar, Uma" <uma.shankar@intel.com>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
References: <20260804123107.2256124-1-chaitanya.kumar.borah@intel.com>
 <20260804123107.2256124-7-chaitanya.kumar.borah@intel.com>
 <DM4PR11MB63608596E790F45C24DD18C9F4A92@DM4PR11MB6360.namprd11.prod.outlook.com>
 <DM4PR11MB6360FEE47A37F9AB2941BCF8F4A92@DM4PR11MB6360.namprd11.prod.outlook.com>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <DM4PR11MB6360FEE47A37F9AB2941BCF8F4A92@DM4PR11MB6360.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::17) To PH0PR11MB7636.namprd11.prod.outlook.com
 (2603:10b6:510:26f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7636:EE_|DS4PPFFCBF1B4C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ff6212-8117-4103-911e-08df07fbec19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|11063799006|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CRe/R/DO9T5sJ1FW+YsqsLjW1CyphHKB9X8P5PgGDHSwBz8fbY9gOZfCxW2fKiKVTWUEXEJO3igq5KGlInshfLihm68fFiB3tpvyyJwgbknNmDt/cBCFfl0k3dUiUWPRkdyi5SGKLpladr9fEA8unwJAtYrkZMZdDzqSUjmYYadjJfndhLRZO6IqU2Rixss9KeikHcAeX4d3QYN8tLxyhB5O+nD9eM6/xBG1iVNCQV6ElwZgtfcXTWV0YLGIjNx0rwzosH8EKFncXFxMDJw+zw0rRW07MZEVLEZ3ak87HmtuLIhQxzAo6GrzYQ/2Exz0jmIxrV9ZBgy+Yp+K9sTctSnAUgTAlScy0lbTRNS3sNlx4Ap5Gx1m0vfSuUjjisNIWtf4ysu4hzlccjy5cFMbbqE++xOG0plLjJ0XII25rOxb4Tnn2OPcszQBATlAYvW2h8iurKnulSPTXiNvrJUPdP/K6l9orugoAxsmJ68pA2lTBwtz/d7uaOvzDctcGFkF5tjW8v6VuwfgI0EZZKpB13IlCTpeF6u7GCXDnX5S/+hns/jmxoGTCUA5ncweLxPQZCdcxwx2CIo8QDYCeQpv3k6jpbIjVcofV9LVpK8Jho2SkOjaTF8V3S2BpAXChTqL4yMtz1oxloAjYZjwbCS7dWFEmmyj2OAIVAcJZdxD50Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7636.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(11063799006)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWdCd3B6Wnd1TG85OXhRVzAzYXM0SWFvSGhlZGhSTDhvdFIxb1dSWHpuOG5T?=
 =?utf-8?B?aVlldjNGaUJnTExVU1ptWC91VUdqbHdueStvMmFlUzRPSUoyZThvVU00Rncw?=
 =?utf-8?B?dDJHM3J0NmpZRDdhZFhRbXR4emdVcDlMVVUrMHk0SHVuUUhhSkh3SnVmbFhV?=
 =?utf-8?B?cytibUdidWkwSXVjTkFwWmRCcE5GZS9wNWF3eEZGQkdIcUJralFTWFFZdXg0?=
 =?utf-8?B?aTRaeWk5RGREeFU5dVRqZHFZWDFnUmxVOEkyR1M0TVp1bUxpS2NTb0MrNWVv?=
 =?utf-8?B?VXRMK3gzL1NIcjhXRXEzL284b0k4TlcyNUdnWUtNZHJ0enVVTnhBdEdhTnJy?=
 =?utf-8?B?dmRsTWpBUHJBS2NiWjRlSTBWa3ZlSmVIUWFvUXBscTFWNXpMMEUwL2RsdElS?=
 =?utf-8?B?dUhsSlhsbUpvdzZnU1ZKTU9vOXdGTlV0MGVWVzdsalI5TldXVGZERERIN0Rm?=
 =?utf-8?B?K2lnZ0Y1U1JuaS9rZ2llamdJK05WekhCWWYvYXF4UThOa2NQMmVLQnVGc3Zp?=
 =?utf-8?B?ckN5RmRSWU9tYXFQMlFlOFBmUXBML0o5aWZNdkxJOUxPbzRQRTZJM1BSdG9B?=
 =?utf-8?B?djRwUXVmcjJTN1lqREw0cDN3RUdiTms4cWFucitBcFl1SzJPblVPUDV4S2s3?=
 =?utf-8?B?Z29peTU0RU9vWERhSUZsTkExek42NXZCTkRxTTYxL20zQmdwUnNRQllVZHpy?=
 =?utf-8?B?MlA1Q2lHNk82OHpVV2pZOFM4Rm1PcGl3M3hEb2N5bmtOb0JyYk9CSDl4YnJ3?=
 =?utf-8?B?QXI1Uy9zbnVZWmtRUEJlV0ZrZUp4WUZCRjBmS0JnWEZJQXVhbTQzQUVJVGtZ?=
 =?utf-8?B?a2grY2s1RWp0YU1WMjFlOEFGUldOQTVEVXc4a1pEZStvRGRYZHZMWmx4SEc3?=
 =?utf-8?B?U0o3NDBldnBXK0d4ZVJkd2dlRlViSjMvU1BsMHVSbVY3QWRBcXh5ZlZkcEhO?=
 =?utf-8?B?TlBlWjBzaHhoRWtwVUhLaTRMZWkvRzVVd2IxYkhjZ0JhQ3Mrc1h2eDdDSVB6?=
 =?utf-8?B?T0RuOGFPTmZFamNONHUxdEJWYkFhZnJQZS8wY0p2dXB5cjJqRlRMcG9nc3lE?=
 =?utf-8?B?RVQ4aGlJaWdKYnVhTGhCdmwxejg5ajF4bnVPRGgwTXVxcTdHQjkrUlpQM2Yw?=
 =?utf-8?B?OTAvams1US9RTHBPalBrV0NQNWY0RGZTUnVHZXJDQTNlR3ZKc0VSbisxNHd3?=
 =?utf-8?B?RG5iNzIzS1NzQkRxWVdjOXhvNmlicDE1MllYMHpRMmZkSldidllPRnNGa1dJ?=
 =?utf-8?B?ZjNhWkJ0TkNjelMzczE0Y0E1akJ0Wi9ydEx6SDhlcnBQN0JURnN0WE4xb214?=
 =?utf-8?B?bjFqUmRIbmw3SkZOaFJsNndTeFVCcnhVSGtsTWRQVUF0NkoxTWw1RmQ5amMx?=
 =?utf-8?B?eVdFWUxEN05lZWk5OXdRTWg5ank1bDdaVjZpZlJJeHNxdGt4dW81RGQ2Rkts?=
 =?utf-8?B?WElqRWhWK2F5ekNUNGNjOGkzSlFDYmx4TzU0aDNyT1ZxbXJyOXhXWGZCb1hj?=
 =?utf-8?B?Vk5jNHdGYTVBbmFIUGdtUDZlZzRFbDdpMTNZQmxzSUF3Rk9mMVBKMnM1WVp6?=
 =?utf-8?B?dU1NLzhzc0R1dFVJU3pJSUNlckVJdzNXK2Z3dDFRWjF4dFRqQy9QMjFHeWVT?=
 =?utf-8?B?V1UwRytBWVRiQ051cXo5d1RZNGJ0VW9NeGdsYkQrL25CdzdKMWxHaWl5V28w?=
 =?utf-8?B?QUlrT01NR1BhbXVBT1F5cDE0QS9RSjZ0U1dxV0YrVVNqeXJYd0duYkcvYUFG?=
 =?utf-8?B?SHRyY2o1dWF6Z3lYQWt6YmVUbDBhd0l4WTQ5Kzl4MkRVcmU5TkxGMmdSN1g4?=
 =?utf-8?B?anlUb0xwYW1uWlAzbzNkUzJQcXRoRmxCNGV0dDJaTUU2VzRYalUzMTJyK1RL?=
 =?utf-8?B?ZUd4cEd3N3UwZDFDRm1QM210R3NTcjRpeEJteFhBYjUzc0pNd2V0WFpCazVJ?=
 =?utf-8?B?Mk1XZnh0OGR2K0tXMFFWeTZLVi9TcyttdVhYWWtyVUFZZ3UxSW1BMTkwcGMr?=
 =?utf-8?B?b0U0V0tpU0RKajhvOUt1ckVsTXdUL0pTeXErV0h1VS80N2N2Vk92azJkZUNV?=
 =?utf-8?B?Ynk3dzJta1REYUdZMnJXSHRGQ2J0YXBqcVl5RVlONHh0ckgzVnErZERyM3hl?=
 =?utf-8?B?NHo3NVRaS0RaWHl4eURld2NTRzdmMGFkTGhHeVRQaTV3VEJCbHhuWHpvU1Y5?=
 =?utf-8?B?Ykt4RkthWEFvay9DQ2RDUFByWUQ3Rys3Z2pmME1YclJzdWY4T0d3MXJ0amNK?=
 =?utf-8?B?Z2NjOGlhYVpkK01wcWVMd2g5dEJLZnIrMmppYzJuR1lJQmRVWHUybFJqcmEv?=
 =?utf-8?B?S0lMMHZKMEhoTXNzWjJzVEdXbEM0TWNtRFJDejk2ZENMcDNBQW1mZmJDY2JH?=
 =?utf-8?Q?7MbNRtrnEd/gVuDA=3D?=
X-Exchange-RoutingPolicyChecked: XTD7EeeUTBJ/rO+VRrW08QasKLYv3phd91ekAm8pSkdyjX/8jMdV1hDMiSy8E442tozvZXqDO859v208VhL2K590AiL2KpUlzc28Is1ZwTKUvUSslCBB4S2zsx6NsEyNZ3UMPPSYhXtieGL7zlPFCDmCBwQJf69Yw4QDVLXOYow108TEhEquDCG3h27RG2i+Q0A2zM6iLXRLn0Zq3pnQ9YowrcMKHX8vVwnSECJAdn9sv7D2Yl8jPfwVkLaGIFeFm+GhiG/k7E8cyDUSp4amGkm5Og8Rdo2R2L1Lw0Z4NXkYiyDeVEiGhQz0mE3KGXB/aC5SXjymcMRzoLxA1AFI4Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ff6212-8117-4103-911e-08df07fbec19
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 07:37:49.2051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKD4lc7aaNNwRFcTUvQtRnOxGQvW4Da8+bOS58WfH7UaeIKjFBzYyKW/BRyNi3xsuHioacGK9dBOCSzuxCrKFg3+XjEZEla0nx9pygKjP2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFFCBF1B4C7
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



On 8/31/2026 7:08 PM, Shankar, Uma wrote:
> 
> 
>> -----Original Message-----
>> From: Shankar, Uma
>> Sent: Monday, August 31, 2026 6:54 PM
>> To: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>; intel-
>> xe@lists.freedesktop.org; intel-gfx@lists.freedesktop.org; dri-
>> devel@lists.freedesktop.org
>> Subject: RE: [v6 6/9] drm/i915/color: Add support for 1D LUT in SDR planes
>>
>>
>>
>>> -----Original Message-----
>>> From: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
>>> Sent: Tuesday, August 4, 2026 6:01 PM
>>> To: intel-xe@lists.freedesktop.org; intel-gfx@lists.freedesktop.org;
>>> dri- devel@lists.freedesktop.org
>>> Cc: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>; Shankar,
>>> Uma <uma.shankar@intel.com>
>>> Subject: [v6 6/9] drm/i915/color: Add support for 1D LUT in SDR planes
>>>
>>> Extend the SDR plane color pipeline to post-CSC 1D LUT block.
>>>
>>> v2:
>>>   - In preparation of a simple pipeline
>>> 	[YUV Full/Limited -> RGB] -> [1D LUT]
>>>     Drop pre-CSC LUT from the pipeline as it has no use in a YUV -> RGB
>>>     pipeline. This makes the pipeline simple since the block lies between
>>>     the YUV range correct block and Fixed function CSC. It can be added back
>>>     when [RGB709 -> RGB2020] capability is added. Then it can be used for
>>>     linearization.
>>>
>>> Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>>> Reviewed-by: Uma Shankar <uma.shankar@intel.com> #v1
>>> ---
>>>   drivers/gpu/drm/i915/display/intel_color_pipeline.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
>>> b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
>>> index efd4375c4331..53e55ce0a5a3 100644
>>> --- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
>>> +++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
>>> @@ -45,6 +45,7 @@ static const enum intel_color_block
>>> hdr_plane_pipeline[] = {
>>>
>>>   static const enum intel_color_block sdr_plane_yuv_pipeline[] = {
>>>   	INTEL_PLANE_CB_CSC_FF,
>>> +	INTEL_PLANE_CB_POST_CSC_LUT,
>>
>> With this we will expose support for post csc lut but corresponding handling in
>> driver is added later in the series. Would be good to move this after patch 8.
> 
> Please ignore the earlier comment, enabling of SDR planes is done in last patch
> so this should be fine. We are good.

Thank you, Uma, for looking into the patch. Can I consider your RB for 
v2 of the patch.

==
Chaitanya

> 
>>>   };
>>>
>>>   static const u64 intel_plane_supported_csc_ff =
>>> --
>>> 2.50.1
> 

