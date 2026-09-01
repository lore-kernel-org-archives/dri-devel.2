Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23994C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A29B89B57;
	Tue,  1 Sep 2026 09:12:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="d25OaoTu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1A088989E;
 Tue,  1 Sep 2026 09:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788253923; x=1819789923;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=a1La1O/E2UyjsP3l0AfejIpmt2r8mlubYWgE4JvKBJ4=;
 b=d25OaoTup1CnbehrBdkYpQ/Gw0HVJOCkXh0xWdPmXe35hU7IuuKHf4kf
 a/4gH6yG2g0kRl6YzMTIXDXnAgL1scPeVEOSjR1/tKFgZVg638lav27CX
 j1q5eRlVIf07zYyjUMAWSoFGZHDE5eoFAEBw3Sn060xv9du2SUoqyNnpo
 H2r84M0Q4eVD+U93nCd3Fj/P8gk7RVF0eyJ4L83/NDUlRPnOZ/CCLtp/F
 3oDAiKT93/PYT6LMQ1hnLYf8SzNbWt3QARZE3eRzsjiJktWyc4aRwJW0g
 0M74tOVTJEzlacTjjpaJaTGOZMuhFBVmfvpidPPnbAwDtKTHD5qhaYp6l g==;
X-CSE-ConnectionGUID: 9Bd5W9SVSAqGpCshIUH1nw==
X-CSE-MsgGUID: IqMW5W3VSeqJVG6pOQp1+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88800778"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="88800778"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 02:12:03 -0700
X-CSE-ConnectionGUID: Pj6cGrjGTjmDF4Q9FqUbgg==
X-CSE-MsgGUID: ww9682l8TbmBBi4PyP/j3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="266452717"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 02:12:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 02:12:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 02:12:02 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.57) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 02:11:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjlIXTnFk3PqIY8tS8Rpz7bpPYX0k5244NjCO9GxXElNPOhsioxbq6G2lCxps7Zxe55mKOlNdpYDSFPQTwSckjcn78Pp/n3ey+X8EroswZrNHz//rHfY0KWOUUPG9388HmaVWeR5b0dbWYAvu+McldXVZtUl12XteEPADAWAnQsMVgq4ciXt6RnF0IqvH2cLpEJr6EumpJkr1DBuL51MqyWUS1Mbmfh+3b9xCMbl2as+ntAcoPp7V2xLXWWlp+S5YGDcK+l8D8xGpT7Smerb7/S5PxTlaX7866+QfSMs0I4G1E6KIeKfTYEVpvhxksJEHdfJpDNXiNs/Q/WdzYwkdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=408doK7QGx1QCatkjfIjlou00t6hXXA2MXDJ0yNVK7I=;
 b=x1f/IuH8Oy4LFZLwOgWStEOwSaw8PbuEvPbd2eAP6GtpStilNbcDzeNm67QOpzDse6E0X93ueta6Z6EALEdcwaH+EjB7FhbrG1bdSBbdpPHMG/KmHubIO2mXEk7DVYBO3ag71gi3hlLYVzloOk65R8Jy2T/6x5d07RIEBsO7EQO4/8SuSIk4e0FJuJ9NfeRutPSvwajcUVnhcs1ZBykU65qmT8OlkdULk6vIHjQ8W4RyZ91avaCNy4ls79EhW+4YY+9IWPNJdhdSOD2RkAvtOcI5KMIrDNRoecyRGY4lm6JtzSFPTaOAMge2iDziHYBCQHI9VgVZV7luTzPk02qihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 by PH7PR11MB8010.namprd11.prod.outlook.com (2603:10b6:510:249::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:11:52 +0000
Received: from BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c]) by BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 09:11:52 +0000
Message-ID: <e1673532-3f31-4be2-ad35-0a998aaa9783@intel.com>
Date: Tue, 1 Sep 2026 14:41:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] drm/xe: Stop VM work when device I/O is blocked
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <matthew.brost@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-5-arvind.yadav@intel.com>
 <apXqRXClcZThJovR@intel.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <apXqRXClcZThJovR@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0120.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::6) To BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5709:EE_|PH7PR11MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: 2205ef6f-43a3-4013-9fdd-08df08090fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Ui5t9dxLgbqMiHFfbMaXMJL/X77I9mCCIsflhC3uoNAUNQbartZQ8qeo3gd3Sp+ZJNnBYnVbt/G8Q9t1Oj9vQLn1LL3eFCwYD+RkRshFQE4ZAdg/IK3DqT8cVspCl9hGsmYHNsQ6AuxSuk+1mM+n9yB7yY9aeLwMbR/k4Nlqsnac9gJkcwMC4HKrb8yUSl5PYf25hDw84C8bOQkvMOvxKns2btWhwdgJOtKuYvoPanZrnKvrWTwktuNaAs78IpAD1ec7NonTwXPi91WCKqJdJELwMHvCBRPXkBnB8OYd5GgiwrUtD5AV/k5alfVa1ADepra+I+H6k7sjS8C5UJnP8CtPlmqaTdkz1UoareK/tyK261PfzmbVaAMTrLA9z9TviimnSV74wr5gJS8tWOCVkMUJGDAfdikxPL4p6L/TameUE2/9k9G/tHakOHNAhHOxQw4JP44C2cFTpuUBNQRWQ10yQhlPbJ+T6XBHQDLXs7VxkHyjxN4sqDxADWtm5bVizJTpP8ZtN+geCJDMKXXPiL/TTqN1INAlbUMx4daBr46vVlipbP6BRwlhIRLdhMdmbKC6aOt7Dk0GYC8yvRMM/X6gl1l7pNvmbOMSmVC/1j0n7NudfwyyU7k7CZGM/xRPyQ8A9jZV0hQzxGyj0XzBQo4JavuU4/NFMuD/tGfrKZ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR11MB5709.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmJzelpTVWEzY3ZaR2NZSGozYUdMZFdFb3ZJd204TUpzQ0haNExQSFNGb1BD?=
 =?utf-8?B?dnc2ZFZjOUFPTEJTbTRJK094WmVOc0ljTmhLMytydVVudkFoYkpCSzAvYjBT?=
 =?utf-8?B?MExrNHYvN2sxTW9XRTdrL2FTREU3amNtK0lpSFJvTDNFaVZFUEZDWnhoeld6?=
 =?utf-8?B?eUZ5QWRXVkE2Q3FWWHhsT1ZSV3RDaUpvaS9rT2dnaTc1WUlwUHBCV0RMTExW?=
 =?utf-8?B?SjdSRjVzV2RFMXhDbWtWOHFyclFmTEFCbWVMVWRoOStHa2Q5VHVRRXdlYnd6?=
 =?utf-8?B?elhWd1BiQ0JtRm5POGxDUVYrVUtsdFYyNFp1RzVHUDE5TmNyTmY1MWZvMWlI?=
 =?utf-8?B?VSsxdUw1Y2ZMVVRvVytJQVFlV0tQSkxXRjU4OUxrWVUyQmpMTy9TeHNVV3RP?=
 =?utf-8?B?M1lMWmpTQmFPelhwTmtRa056bmRDREFUOFRLOTVMcEVVVG9oZ2h4Qkt5L2F3?=
 =?utf-8?B?WXJxM1NOb2Y3aVN5N3NETnJyUXhXbTlRWjRlTmNkTlkwVldoTGx0elZOeTJU?=
 =?utf-8?B?amFISkNnQjJ0YzZ1NzgxNXpXR2MwNjVlWUdLa0k1Z0trZzBucWJiVERHUGpz?=
 =?utf-8?B?KzFZU1p2V25zbjArS1VqT3hnQVo1TnJjZ2NybXFTMjU1MElQZ3Jmb09La3Uy?=
 =?utf-8?B?OGJjT01oMmxSQUZVZjlZQXVNZ2tBbXJGQVBpUUNiVTUzcjR1Yi90bWZmNzVU?=
 =?utf-8?B?c0NvR2tJeUZCWklYU1A0cGJMekFRaWthWTV3RGNSWGlRc0FNMW9UR05zOVpW?=
 =?utf-8?B?bjJ6d3lLUGtMdFJXVlVja1lLcG54M2lHVTFmOHI3YTd1NHV5OWlXYXEvMEVS?=
 =?utf-8?B?Unh1ZTVIbzg3eWVYd0N3cFdmM3lqUTdPWmlZdi9sZGE3VGxIYXhOWGx5U3BT?=
 =?utf-8?B?aTFxMDVJQUFlVlF4RWdGRVhhbm1lMTBpcDZzZlVPTW5zL2JRL0NiQm9Ra3RZ?=
 =?utf-8?B?Nlp1amY2UVhDemp2RjlvMXFZOTgyY0U0ckpzNlFMSi9IYUpJNFNKVGlrcjha?=
 =?utf-8?B?cU9Gb0lSSi9Td0tkcitFVGFzS1lWdVdnTXpjTFluTzdsMkxmVmVQbG16RHJ3?=
 =?utf-8?B?OHZPRER2RW5ITmJBVFpSVUU0b1lONlJsUVhxMHNVODhkSVN4WDl4NmFwczhL?=
 =?utf-8?B?dm50K1QwTGFwZ09rUkhuSks0bzV2Q0tQQTcxd2ZlNnNVZWhyZWlFYnYyTk1U?=
 =?utf-8?B?b0lKOWF5N2ZRL0svNEkvN3dSVWtkL0RkY2JaSExmTEc4TkE5Vjltd2tsSFN6?=
 =?utf-8?B?TjkvN3BaVGNzZzBKVFRwZzBBK3hWSVVkMWlQRVZkTUcyVnNURUJteHdwazBp?=
 =?utf-8?B?d1dJRWtwV09QY05PaEwwbVNqcmF4T1FuYkdFNXN0Y3o4VlorSC9TcUZSQTFN?=
 =?utf-8?B?NzZKQlJ2c1ovN3I3Z20rQm1jRk1JRG9CbHNDcS9kT0tZQWtsdm9SbVZhcHRk?=
 =?utf-8?B?Y0ZweEpwRitONnMrNWtTL2hNUm1IeU13MGdpNWMxUXBRWm56b1JlUXYzb3Rr?=
 =?utf-8?B?VGNxQnhpcHRMSFJ1cFJjdHlnT1FaVXBWN0RHUVYyUDIwTGZJY1BFYnoyWFFa?=
 =?utf-8?B?N3ZmVFFWV2ZDSlZoQ2Vib0pQcjBvUE5kVFhXVGtjY1pwTVJnYW9tdnRIMXM2?=
 =?utf-8?B?cGZTYk41YWVwMGx1Q21ZWUJVSXhadnlXRVplemVSVG1YTTFJQXlCMTVKL1pw?=
 =?utf-8?B?TG9MV0E1cE1ySk5FQ2hFMExwNjFTdnFzUFZubjFhcEJRTGlNSVJBOC94Y1Fr?=
 =?utf-8?B?R3VRNFRLdWtPL0pubHhzVEdjQXJFOFpLKzNhQTVDamdsNzRqck1WVUJNZWVa?=
 =?utf-8?B?OFNubTBmR3pmMEVXVFZuOHdEcDlGY2UvZXNRMDRSQmNsYXRZZ0FxcEdLa3BR?=
 =?utf-8?B?czQ4Rk40S2xuUnlxVGgrUFBnSmhTeGQ3dWtGempaYk4xNnZhdGc1NVd6SUFI?=
 =?utf-8?B?ODVTaktJbDJrNzlnWlg1SkQ2alBkeXlQM2lIckVrdm83MEpKSXZjZWh4bjI2?=
 =?utf-8?B?WmxwaUZzbVRDU010TXpvdjNKZkpXUG1tZ1BjTXkra2Q1dVkvMEhsNnhLTm9v?=
 =?utf-8?B?eHR3SzhmaW03Wnh2Z0dBS0V5U0RpM3Rwa05zL3A2VzlJT24veUY0Y3RQS3dn?=
 =?utf-8?B?K1NrWGpQa1pQRkl2UjhBbkFTRURneEUxQ0VJcm1jWUVkR2ZZNEFKQnE4Z0Ft?=
 =?utf-8?B?bnBtRUZoaDNsWjU3cjZESi9wZjB2WGdPWk9TM0JBUTJ3djdFWnl2OFVPaEVp?=
 =?utf-8?B?eDNvZUcvU3VtT1lrT3dLeUhFb1hkeGpERUpSd2JFWVFBQTNFelpqRURIclZu?=
 =?utf-8?B?dklYcE9uREJmdXZCYWRVZEhTUEZ6WVljbUxiNHR5VlB2cFhyRGFQUT09?=
X-Exchange-RoutingPolicyChecked: oWswyi2am0DGce32ogVndaXgfINeHVN2jw9+kskip0MR7gdw/MOe+/as6+4XY/ipc8hA9gbJ/3VRcR6rk6+r5aSb9b2NPqwuoCdYG/sgZw6Jf87gIy9qhCWY7yC9X97Wyq7Z01b4vqo8Xb/xRCebKoHRaP41SYkZlVyV9kaUtC6py/HYysDfLjCW3rhSCWtpaA90Xm9dzvXgaNzIJNylh8Nni1fPtu0esKgiKhMS1QphtDJvSvgmswOF8kp44+0pEHNe+VC0mYjnrT3rMNMAa3K/xcVZy616tyHorPylpfaCjbyuGL8a0Z0ItP+3AMEtrWGGWrFYpudVgzWgojEjzA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2205ef6f-43a3-4013-9fdd-08df08090fad
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5709.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:11:52.3968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1yj0buevugRX838z87ydOMscT1lZvdXHgRXWvyeE64xFk6rgJXeNeAjYjPnfUnBF/G+77mHaVf8Uq8mdSgFhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8010
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


On 01-09-2026 02:25, Rodrigo Vivi wrote:
> On Thu, Aug 27, 2026 at 03:47:52PM +0530, Arvind Yadav wrote:
>> SVM fault handling and VM rebind work may still run when PCI error
>> recovery starts or the device becomes permanently wedged. This work can
>> validate BOs, update page tables or submit migration work after device
>> I/O has been blocked.
>>
>> Stop SVM fault handling, pagemap population, device-memory copies and
>> preempt rebind work when device I/O is blocked.
>>
>> SVM invalidation still performs its software cleanup. Do not warn when
>> TLB invalidation returns -ECANCELED because hardware access is blocked.
>>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_svm.c | 21 ++++++++++++++++++++-
>>   drivers/gpu/drm/xe/xe_vm.c  | 16 ++++++++++++++++
>>   2 files changed, 36 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
>> index 627a741293d5..9e78131bfa39 100644
>> --- a/drivers/gpu/drm/xe/xe_svm.c
>> +++ b/drivers/gpu/drm/xe/xe_svm.c
>> @@ -11,6 +11,7 @@
>>   #include <drm/drm_pagemap_util.h>
>>   
>>   #include "xe_bo.h"
>> +#include "xe_device.h"
>>   #include "xe_exec_queue_types.h"
>>   #include "xe_gt_stats.h"
>>   #include "xe_migrate.h"
>> @@ -288,8 +289,11 @@ static void xe_svm_invalidate(struct drm_gpusvm *gpusvm,
>>   
>>   	err = xe_tlb_inval_range_tilemask_submit(xe, vm->usm.asid, adj_start, adj_end,
>>   						 tile_mask, &batch);
>> -	if (!WARN_ON_ONCE(err))
>> +	if (!err)
>>   		xe_tlb_inval_batch_wait(&batch);
>> +	else if (!(err == -ECANCELED &&
>> +		   xe_device_io_blocked(xe)))
>> +		WARN_ON_ONCE(err);
> if (!err)
>          xe_tlb_inval_batch_wait(&batch);
> else
>          WARN_ON_ONCE(err != -ECANCELED ||
>                       !xe_device_io_blocked(xe));


Noted.

Thanks,
Arvind

>
>>   
>>   range_notifier_event_end:
>>   	r = first;
>> @@ -631,6 +635,11 @@ static int xe_svm_copy(struct page **pages,
>>   		}
>>   		XE_WARN_ON(spage && xe_page_to_vr(spage) != vr);
>>   
>> +		if (vr && xe_device_io_blocked(xe)) {
>> +			err = -ECANCELED;
>> +			goto err_out;
>> +		}
>> +
>>   		/*
>>   		 * CPU page and device page valid, capture physical address on
>>   		 * first device page, check if physical contiguous on subsequent
>> @@ -1125,6 +1134,11 @@ static int xe_drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
>>   	if (!drm_dev_enter(&xe->drm, &idx))
>>   		return -ENODEV;
>>   
>> +	if (xe_device_io_blocked(xe)) {
>> +		err = -ECANCELED;
>> +		goto out_drm;
>> +	}
>> +
>>   	xe_pm_runtime_get(xe);
>>   
>>   	xe_validation_guard(&vctx, &xe->val, &exec, (struct xe_val_flags) {}, err) {
>> @@ -1165,6 +1179,8 @@ static int xe_drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
>>   		xe_bo_put(bo);
>>   	}
>>   	xe_pm_runtime_put(xe);
>> +
>> +out_drm:
>>   	drm_dev_exit(idx);
>>   
>>   	return err;
>> @@ -1301,6 +1317,9 @@ static int __xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>>   		drm_gpusvm_range_put(&range->base);
>>   	}
>>   
>> +	if (xe_device_io_blocked(vm->xe))
>> +		return -ECANCELED;
>> +
>>   	/* Always process UNMAPs first so view SVM ranges is current */
>>   	err = xe_svm_garbage_collector(vm);
>>   	if (err)
>> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
>> index 19b3d0be7928..0cee5306fb9c 100644
>> --- a/drivers/gpu/drm/xe/xe_vm.c
>> +++ b/drivers/gpu/drm/xe/xe_vm.c
>> @@ -497,6 +497,11 @@ static void preempt_rebind_work_func(struct work_struct *w)
>>   	}
>>   
>>   retry:
>> +	if (xe_device_io_blocked(vm->xe)) {
>> +		err = 0;
>> +		goto out_unlock_outer;
>> +	}
>> +
>>   	if (!try_wait_for_completion(&vm->xe->pm_block) && vm_suspend_rebind_worker(vm)) {
>>   		up_write(&vm->lock);
>>   		/* We don't actually block but don't make progress. */
>> @@ -518,6 +523,12 @@ static void preempt_rebind_work_func(struct work_struct *w)
>>   	drm_exec_until_all_locked(&exec) {
>>   		bool done = false;
>>   
>> +		if (xe_device_io_blocked(vm->xe)) {
>> +			xe_validation_ctx_fini(&ctx);
>> +			err = 0;
>> +			goto out_unlock_outer;
>> +		}
>> +
>>   		err = xe_preempt_work_begin(&exec, vm, &done);
>>   		drm_exec_retry_on_contention(&exec);
>>   		xe_validation_retry_on_oom(&ctx, &err);
>> @@ -531,6 +542,11 @@ static void preempt_rebind_work_func(struct work_struct *w)
>>   	if (err)
>>   		goto out_unlock;
>>   
>> +	if (xe_device_io_blocked(vm->xe)) {
>> +		err = 0;
>> +		goto out_unlock;
>> +	}
>> +
>>   	xe_vm_set_validation_exec(vm, &exec);
>>   	err = xe_vm_rebind(vm, true);
>>   	xe_vm_set_validation_exec(vm, NULL);
>> -- 
>> 2.43.0
>>
