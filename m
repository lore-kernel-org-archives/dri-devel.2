Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C826C79FAB
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5F6210EA00;
	Tue,  8 Sep 2026 04:53:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fspaU0NL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D1810E9EB;
 Tue,  8 Sep 2026 04:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788843192; x=1820379192;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=lYD9U4j6PtEBORtpBpzey8e75VbbOF/aof6CgUaRzRU=;
 b=fspaU0NLCNcYDOlvoRydmzNgEypPbq5lwRYm8qt/6zqWMZyIJt53fLKW
 vUF3etm/8zOi0RpgL/DqPpH6w2iyKaT0Ie1ThnEhK2JKSsqtqFItzd8ai
 lctjzJjSaudM1P9zH5IaD/5takBmwwWjUrBBsMQBnKErmJypj/Gac16pW
 sCocJ9xdB986Tu3WEn54oOjtmt8Bd1bTOXBH7iYdU5pspQFy4dD8wrlCU
 BnQgVa1fNllMXa+9GniHdYGU4eHXPpTzySz+O+zgGsuWT00DmdhGbZR8P
 39PR9xc61deBifZNwqyl35JuMBPHjJsGP3EdOppWvyNAgkTtuPCddRSMT w==;
X-CSE-ConnectionGUID: u7/i1Za6R3GDkAi6s/uRCA==
X-CSE-MsgGUID: KyvOonfFTfWVvtsZ8VqenA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="88171351"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="88171351"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 21:53:11 -0700
X-CSE-ConnectionGUID: mtloAtxnSkaokocEk6PO/g==
X-CSE-MsgGUID: SECAcrwpQuWw5ZtqYCGXuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="269555789"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 21:53:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 21:53:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 21:53:10 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 21:53:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r71wQPTqhtSmgA95f8oUptpnMEG/gVt2T3Qgjc+WTsVd2tE/4Fd1AQDBeWVZHJ0aGgZ4Fel4CTbc6GNoey/+nETOyXY8t4DJtxtI8HhIoVAnqWyR+jBKKn4CegE4lz8vNmh6BExaFCx5x/av2sHrCxAPYng9hYL2TMOE/iMUwdbsOt4tByeuI6A4FjGINP0Zr3F32+IuCeX357iFqsJ1Mb9KMBieTiWh+tDS9uR/E7rv+cX4dYdErtjceksJZM5W+D8tZoMw+fgOHVtQc0aRikWBTVZfB9b088AP1ERi3qmvSBb42dXkwDhKoQweTm/VnUYFAwQctCUx6wMDzq1t1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dCJJROmlDQGyJTXC06FuMHYm6Wd3KaOP4jojXEewAw=;
 b=oxU1eez1Q3Rey2jxe7iD4BneYvAenmUO5ZXaFx4TdgTB0kTER7G68aXSwqH2a0iCDR8baXpk7vtkaUrR7fg2EohQsG1WvmO+rosRecEHRr1NYUc6tvFjzvYJJNTvJJmMqYUHq9S9QyxIFUgvVsFGbLCFkceQWY5wL2hbztTDhsXAuqtJTW6/OGVBguo5IDLi42K/+YCIEWAlgMReOWylbkrLE1+Fs+6iUFyd77y8yXJqjy57auL32TCgKjj/tyZHVvc2oT42cfK2txnQ2mx+Njl04OjXp2fYuoEnSUdzKuyvpS7oKAjhlNnIPjgCogbu4sMq1h6IeHJ8Jzmqg1PFGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DS0PR11MB7441.namprd11.prod.outlook.com (2603:10b6:8:141::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 8 Sep
 2026 04:53:07 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%3]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 04:53:07 +0000
Date: Mon, 7 Sep 2026 21:53:05 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>
Subject: Re: [PATCH v7 1/4] drm: Add drm_work_fence helper
Message-ID: <ap+UsYGDGdsGEkM9@gsse-cloud1.jf.intel.com>
References: <20260831134539.112690-2-srinivasan.shanmugam@amd.com>
 <20260902152049.183685-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260902152049.183685-1-srinivasan.shanmugam@amd.com>
X-ClientProxiedBy: MW4PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:303:16d::13) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DS0PR11MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f1a630-c025-43dd-8437-08df0d65132a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: rsVy1+D4Z1psY8N3XrOOCkN8l9+El+ertfaxwPdktIztWLXDUpMZ1enLIbv721c0dBLhSs0stp8FY1cc2bXv3SRucRPw6mgp5kKo6+txRx5gvUDe+Q1mk1hdDIFDLxQydotyx7wutdl4gTcg5YPVDGrdeC7np6thZLe3czJIzge02xJGJjmfmSFUh3vZ20TBnnnLbaQZINy3h/NhIQamy6vWWxqJVU9Va9mpWOkWOCwtxC7xNYakGdWHwnZfn+E0DwAE9aQuCRDKSG8I8q1aTgbnGpudZYc5c4SAZ8E3224hA34IWSA5mL0y43CXuQ0TjsLl48HKIJQnid0LrhEKwvJqO/cZi/PkjJ2UkwdwUIPVAojPeBsEaGcFEt9/N0435Sfa1IaQx3L9bPnS7Pd6JgcW+XsCjfG9JZeUSO8yn7x8+EJtOS8DOJBNc+7H2GWObL+z6j+9EruJoTXLgKGlqMuaOgbg3dKhqk0/8v/y+NSdk+SRBDdwelz1ubjW4xUtFuljhCaczJ4meqCIEUTz1dkjO4XxHkbpPZY1H+TNo1eioGpiaRb/jw8erdq/7D4NcujWd+AmstevDvH2/bCth0AEtMBf93LZWmkkD63UwgxZTOYhcoxW5vSiSQCGOpBuxKJS/afjR+cmCdxmoV+bpTYcYNLpDGj8zHklDj+Cff0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2xpUU81OHlxU2J5VVRONzVCbWs5K2dtN0VydHA1YXdudGN0ZzlQR3FYUzlO?=
 =?utf-8?B?NnpFUmZ2YTNYQ1VtYWZoQWxzbnNDdlNLRnFqdzM2b1lMaERtWUc5N25XSndx?=
 =?utf-8?B?WlZGUHljTVpCVHdNb0k2YW1Dc2xhdENlTzNqclJJcEVuZFVwWXErdFRlY1Qx?=
 =?utf-8?B?eFl1VHFEWWpxZjJNS29oMDFnUHhyUFNhOUJIM2pFNko1TmNVUEIzZFBPZmsx?=
 =?utf-8?B?N0ZLc2lDOFhoOTVQbDBMa1hOMnI4MzRDZ2J0R1huWm9RSnlnd3pEMHRsOGd6?=
 =?utf-8?B?UU1keUlzbk8rTDkyY0t0cWZya0JvSzF4WTRqM2tTK1EzcDY5ZWt4Qm9iZEZB?=
 =?utf-8?B?aUdvb2l5SjhTUTFDS2V6Q3F2VlRvb3AwS2hTb2tleS83RTlSWHhMOWJOOGhL?=
 =?utf-8?B?a3FMekxJRE15SHg1L2djRDRMT0tnNWo2WmIrRGsxbFRWQUhRQmtCY2tqSzRR?=
 =?utf-8?B?R0wySGdQeEw3UTZZZFRoV1JUdVNjTGxrTnlEa2VQamthL0wySnpnbHQxZkNW?=
 =?utf-8?B?WjhyUHp6Qzh6WXBpUmtuQ2V3c1lGWGEvZkhjL2dSVXZVdzJ1ZzB2YUVlZWg1?=
 =?utf-8?B?VWxhRy82OUtEY2N5MkI5QTg3QzhQdzdRNzZ2TG5EU0NPODBiemFrTTJWTkFQ?=
 =?utf-8?B?Wkx6WGRaU3VEYXh5OGJ3OHdwRjF5a2tycWdoaitJYldDQkpLOFlkbnNLK0lt?=
 =?utf-8?B?b3ZTbDMzckh0V29QNjdnRjIzUXlrZG9IYzVnMzhKdmVlU0RPZlo3Rm4vd3JO?=
 =?utf-8?B?WlBTb20yaWNRNVJpanplYWtDYWZ6TENKemwxN2tyZHcyOXBVK3NnQnNMU3RR?=
 =?utf-8?B?UzFUcmIyMUNjSStwTU5UczBQQ2V1MU1jREticmNNelgwNGdKZmFYYzVRZ0Rv?=
 =?utf-8?B?bjBDczdWT2lsVk1ZT0xYTU83dk5CQitxQk1qSDROK21qVWJMaW4reWozV0th?=
 =?utf-8?B?TGF1VmxUb1loQnZCRGRSTis4alhRNFdNK2d1UE8yd0JRNk1kMzlIdmNPY0R6?=
 =?utf-8?B?VnhDeG9nNDFzeFUyd0JXQ3Vud0c4NW95M3Z5Qko4bmtTaklnNC9XL3BCQWtu?=
 =?utf-8?B?T00zNXJ6UW9OMWx5bXcvd3BJTFUvZnBFaXhxSTcrQStnSmN1WmNSUXZtcEtv?=
 =?utf-8?B?YjIzNW1IcFJ1YXp5MEttRGJGTHpvMXF4aEU3Uy9TY3hMZm8ya0dzeWFJcXpD?=
 =?utf-8?B?ZDZZTVJUbFkvVHVaT3Ruc2puNVlGK1BWM0JUQ3gzSzh3OCtmV0lhKzY1UXdx?=
 =?utf-8?B?cC9CeUcxR3FYKy9VYjAzRHIvNzdmNGxpYUs2Q2NZK0lrU3NPMXJhRXFHSnln?=
 =?utf-8?B?MDdid0NRdUNlUytXRGZzS2ZTWmVPN0libU50SUVwRFVJU0g1Unc4NTF3VkxG?=
 =?utf-8?B?bHViZlQ5R08rUCtTem5KWGNRTkZVSE0rS3NnbDJ5eUtMY093TGMrdFN6SFRW?=
 =?utf-8?B?MmhMZS9qZ2JpVU5mN3ZNSGtpejRDZnMvWU56MHd5VVdZLy9vUUVRUDNQZjc2?=
 =?utf-8?B?bVNVcFJuSXkyQ25ZMWNFM3VkK2RjeWFkUVJ3cHA4RnFHaW12bkNrSFc0Q29v?=
 =?utf-8?B?d0NKQldtb0w4SVR5QTZLUFg4aTEza29nckswQUxSYzNsbjY2NytwUW02Z3Jy?=
 =?utf-8?B?bUU1NzVUaXMvaCs2NXJ1Z2wvOTVtcTdaQXdIYTBTL25lUVljT2VIK3pjeTdL?=
 =?utf-8?B?cDRVR1FyTDlFR2RuMlFhU09QNTRhalIyK2VQUXdlemt5OVlzS0IvTDdNT3gr?=
 =?utf-8?B?ZVFlRklRcE14R0R2NUZVVVJxb3N1UENKN2VZSVRCblcwTkQ4Z09YYkN3eXZi?=
 =?utf-8?B?aEhNWVduMHlZbWVGcWVhRzRyQmFmdUpQY1J3eS9uaUpTLzIxT3pqSk9Cd1p6?=
 =?utf-8?B?bHI4ZDI3bUVzUUErZXVXbmRtb1RoZjVRdmRaOU9lN1BuQm5FOUwvaUpGTmpN?=
 =?utf-8?B?TTFxY3BCYk5rZEk0Q2o5d3NZY2N4QVQzMFNtUmhXQ1NCOVh2cHp1VjkxTzd4?=
 =?utf-8?B?R3VpMjNVN0dMNUJEaytFVlVqdkNNM0Z6RFZLekJ5K1VtNERGUVFGUmE1c1Fy?=
 =?utf-8?B?YTdiTjA2OGtoa2FsbU9OYnM1eVdPNFRXZnhDL1VYaFc3TUFsa2FBWktRTVVZ?=
 =?utf-8?B?aVhtcko1QTdmcHM1Z3lwYm5mT0NVMk1mQ2JuZUtmODZqbDEyUFdIaXFkR0VC?=
 =?utf-8?B?RXJXb2liY1B0VE0rdjVHVUIxWThTazZFSEVNeWxOVFFHZ0VacFU4MkFkcnFR?=
 =?utf-8?B?ZVJ0cnFHUDNjVUYvOGE4Zk94MlN1OCtubHk2YUl1YzFJNmQxNS8wenJIN2d1?=
 =?utf-8?B?TFU3SExpaDA5Smo2MzZHTVBqaEpyU2pxaVJDZXQ3UjBOeGFJZW1lenFQUFJz?=
 =?utf-8?Q?utLNXoIwBQT3lz30=3D?=
X-Exchange-RoutingPolicyChecked: ZniWVjraIELFFDXp6whCr3yTwo03vARBcGhvtn3Izjd9G0YKDXkoPWJUEq8Bv6qjHCCMPsX4WPjWIdr5KeWrwNQFbd5atjqiIzBocLc4UfTD7eXuHX3l7uAkki8AEnkw+7VIO1ybbieMDcUzPDdI2sX44rBWfcrFRJxRJ4mYGafgFsBMNystRiCkQlyQltWyGi7Vs1cxbb0gcRD8N1htrePn0twhgTlQ5L8AO+UOn8oVYaTsIhNIuvb3nEXU9fjAY2Ub/RlEGtUCDybxxFhCG6JoTTUxU126HFvoVDzpd8HdjaPTfdPb0hpB/OLFrxFYjZaYxrfsCQfcmhcseN0RdQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f1a630-c025-43dd-8437-08df0d65132a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 04:53:07.6762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTDSCmEBWUS2nAZNLilephR00qMsdmYG7K7RiXz+QM9oKLGTKsAQ0D7KWZxDcEhNhzK9qzQx+yJZSEDg7Z4lLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7441
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

On Wed, Sep 02, 2026 at 08:50:46PM +0530, Srinivasan Shanmugam wrote:
> GPU drivers often need to queue work when a dma-fence signals
> because certain operations (copy_to_user, eventfd_signal, memory
> allocation) cannot run in IRQ context. This pattern is currently
> open-coded in multiple drivers.
> 
> Introduce drm_work_fence — an embeddable base structure that handles the
> dma-fence-callback-to-workqueue pattern in one place. Drivers embed this
> in their own structure and implement ops->writeback() for the deferred
> work and ops->destroy() for cleanup.
> 
> The helper manages:
>  - kref lifetime
>  - dma-fence callback registration
>  - workqueue dispatch on fence signal
>  - safe cancellation before driver teardown
> 
> For work that additionally requires borrowing the process MM via
> kthread_use_mm(), see drm_user_fence which builds on top of this.
> 
> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org
> Cc: amd-gfx@lists.freedesktop.org
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/Makefile         |   1 +
>  drivers/gpu/drm/drm_work_fence.c | 184 +++++++++++++++++++++++++++++++
>  include/drm/drm_work_fence.h     |  69 ++++++++++++
>  3 files changed, 254 insertions(+)
>  create mode 100644 drivers/gpu/drm/drm_work_fence.c
>  create mode 100644 include/drm/drm_work_fence.h
> 
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index e97faabcd783..c5be8e80d0c8 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -72,6 +72,7 @@ drm-y := \
>  	drm_vblank.o \
>  	drm_vblank_work.o \
>  	drm_vma_manager.o \
> +	drm_work_fence.o \
>  	drm_writeback.o
>  drm-$(CONFIG_DRM_CLIENT) += \
>  	drm_client.o \
> diff --git a/drivers/gpu/drm/drm_work_fence.c b/drivers/gpu/drm/drm_work_fence.c
> new file mode 100644
> index 000000000000..482eb3d4475f
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_work_fence.c
> @@ -0,0 +1,184 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright © 2024 The Linux Foundation

ianal but this copywrite looks wrong for fresh code.

> + *
> + * Common DRM work fence helper.
> + *
> + * When a GPU dma-fence signals, drivers often need to perform work that
> + * cannot run in IRQ context (e.g., memory allocation, copy_to_user,
> + * eventfd_signal). This helper queues a work item when a dma-fence
> + * signals, allowing that work to run safely in a workqueue context.
> + *
> + * NOTE: This helper consumes dma_fences but CANNOT implement
> + * dma_fence_ops. Work items queued here may sleep; dma_fence_ops
> + * callbacks are called under the fence spinlock and must not sleep.
> + *
> + * For work that additionally requires accessing userspace memory via
> + * kthread_use_mm(), see drm_user_fence which builds on top of this.
> + */
> +
> +#include <linux/workqueue.h>
> +
> +#include <drm/drm_work_fence.h>
> +
> +static void drm_work_fence_destroy(struct kref *kref)
> +{
> +	struct drm_work_fence *wfence =
> +		container_of(kref, struct drm_work_fence, refcount);
> +	struct dma_fence *fence = wfence->fence;
> +
> +	wfence->ops->destroy(wfence);
> +	dma_fence_put(fence);	/* NULL-safe */
> +}
> +
> +/**
> + * drm_work_fence_get - Acquire a reference to a work fence
> + * @wfence: work fence
> + */
> +void drm_work_fence_get(struct drm_work_fence *wfence)
> +{
> +	kref_get(&wfence->refcount);
> +}
> +EXPORT_SYMBOL_GPL(drm_work_fence_get);

EXPORT_SYMBOL I think for MIT licenced code, unless the kernel compile
complains which I don't think will be the case for anything in this
file - I could be wrong though.

> +
> +/**
> + * drm_work_fence_put - Release a reference to a work fence
> + * @wfence: work fence
> + */
> +void drm_work_fence_put(struct drm_work_fence *wfence)
> +{
> +	kref_put(&wfence->refcount, drm_work_fence_destroy);
> +}
> +EXPORT_SYMBOL_GPL(drm_work_fence_put);
> +
> +static void drm_work_fence_work(struct work_struct *w)
> +{
> +	struct drm_work_fence *wfence =
> +		container_of(w, struct drm_work_fence, work);
> +
> +	wfence->ops->writeback(wfence);

I think you inverted the naming vfuncs for drm_work_fence vs drm_user_fence.

I'd expect drm_work_fence.worker and drm_user_fence.writeback.

Matt

> +	drm_work_fence_put(wfence);
> +}
> +
> +static void drm_work_fence_queue(struct drm_work_fence *wfence)
> +{
> +	queue_work(wfence->wq, &wfence->work);
> +}
> +
> +static void drm_work_fence_cb(struct dma_fence *fence, struct dma_fence_cb *cb)
> +{
> +	struct drm_work_fence *wfence =
> +		container_of(cb, struct drm_work_fence, cb);
> +
> +	drm_work_fence_queue(wfence);
> +	/* Single ref: wfence->fence released in drm_work_fence_destroy(). */
> +}
> +
> +/**
> + * drm_work_fence_init - Initialize a work fence
> + * @wfence: work fence to initialize
> + * @wq: workqueue to run the worker on (must be ordered if sequencing matters)
> + * @ops: driver operations
> + */
> +void drm_work_fence_init(struct drm_work_fence *wfence,
> +			 struct workqueue_struct *wq,
> +			 const struct drm_work_fence_ops *ops)
> +{
> +	kref_init(&wfence->refcount);
> +	wfence->wq = wq;
> +	wfence->ops = ops;
> +	wfence->fence = NULL;
> +	INIT_WORK(&wfence->work, drm_work_fence_work);
> +}
> +EXPORT_SYMBOL_GPL(drm_work_fence_init);
> +
> +/**
> + * drm_work_fence_add_callback - Attach a work fence to a dma-fence
> + * @wfence: work fence; caller retains their reference and must release
> + *          it via drm_work_fence_put() when no longer needed
> + * @fence: dma-fence to watch; one reference is consumed on any return value
> + *
> + * When @fence signals, a work item is queued that calls ops->writeback().
> + * If @fence has already signaled, the work item is queued immediately.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int drm_work_fence_add_callback(struct drm_work_fence *wfence,
> +				struct dma_fence *fence)
> +{
> +	int err;
> +
> +	drm_work_fence_get(wfence);
> +	wfence->fence = fence;	/* transfer caller's ref — single ref, no get */
> +
> +	err = dma_fence_add_callback(fence, &wfence->cb, drm_work_fence_cb);
> +	if (err == -ENOENT) {
> +		drm_work_fence_queue(wfence);
> +		err = 0;
> +	} else if (err) {
> +		wfence->fence = NULL;
> +		dma_fence_put(fence);
> +		drm_work_fence_put(wfence);
> +	}
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(drm_work_fence_add_callback);
> +
> +/**
> + * drm_work_fence_cancel - Cancel a pending work fence callback
> + * @wfence: work fence
> + *
> + * Attempts to remove the pending callback before driver context teardown.
> + * The caller must hold a reference to @wfence across this call.
> + *
> + * If the callback has already fired this returns false and all cleanup
> + * has been handled internally.
> + *
> + * If removal succeeds the callback reference is released internally.
> + * The caller must still release its own reference via drm_work_fence_put().
> + *
> + * This function is safe to call from atomic context as it only acquires
> + * the dma-fence spinlock internally. If the caller also needs to wait
> + * for the worker to finish, use drm_work_fence_cancel_sync() instead,
> + * which may sleep.
> + *
> + * Return: true if callback was removed, false if it had already fired.
> + */
> +bool drm_work_fence_cancel(struct drm_work_fence *wfence)
> +{
> +	struct dma_fence *fence = wfence->fence;
> +
> +	if (!fence)
> +		return false;
> +
> +	if (dma_fence_remove_callback(fence, &wfence->cb)) {
> +		drm_work_fence_put(wfence);	/* drop ref from add_callback */
> +		return true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(drm_work_fence_cancel);
> +
> +/**
> + * drm_work_fence_cancel_sync - Cancel callback and wait for worker to finish
> + * @wfence: work fence
> + *
> + * Calls drm_work_fence_cancel() then cancel_work_sync() to guarantee
> + * the worker has fully completed before returning.
> + *
> + * This function may sleep. Must not be called from atomic or interrupt
> + * context. Use drm_work_fence_cancel() instead when sleeping is not allowed.
> + *
> + * Drivers must call this during teardown before freeing any resources
> + * accessed by ops->writeback().
> + */
> +void drm_work_fence_cancel_sync(struct drm_work_fence *wfence)
> +{
> +	if (drm_work_fence_cancel(wfence))
> +		return;
> +	if (cancel_work_sync(&wfence->work))
> +		drm_work_fence_put(wfence);
> +}
> +EXPORT_SYMBOL_GPL(drm_work_fence_cancel_sync);
> diff --git a/include/drm/drm_work_fence.h b/include/drm/drm_work_fence.h
> new file mode 100644
> index 000000000000..c8e3c5b9f0c4
> --- /dev/null
> +++ b/include/drm/drm_work_fence.h
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright © 2024 The Linux Foundation
> + */
> +
> +#ifndef __DRM_WORK_FENCE_H__
> +#define __DRM_WORK_FENCE_H__
> +
> +#include <linux/dma-fence.h>
> +#include <linux/kref.h>
> +#include <linux/workqueue.h>
> +
> +struct drm_work_fence;
> +
> +/**
> + * struct drm_work_fence_ops - driver callbacks for a DRM work fence
> + */
> +struct drm_work_fence_ops {
> +	/**
> +	 * @writeback: Called from workqueue context when the dma-fence signals.
> +	 *
> +	 * Perform the deferred work here (copy_to_user, eventfd_signal, etc.).
> +	 * May sleep. Must not requeue the fence.
> +	 */
> +	void (*writeback)(struct drm_work_fence *wfence);
> +
> +	/**
> +	 * @destroy: Called when the last reference is dropped.
> +	 * Free the containing structure here.
> +	 */
> +	void (*destroy)(struct drm_work_fence *wfence);
> +};
> +
> +/**
> + * struct drm_work_fence - DRM dma-fence-to-workqueue helper
> + *
> + * Embeddable base structure that queues a work item when a dma-fence signals.
> + * Drivers embed this in their own structure and implement ops->writeback()
> + * for the deferred work and ops->destroy() for cleanup.
> + *
> + * Call drm_work_fence_init() at creation and drm_work_fence_add_callback()
> + * to arm on a dma-fence. Call drm_work_fence_cancel_sync() before teardown.
> + */
> +struct drm_work_fence {
> +	/** @refcount: Reference count. */
> +	struct kref refcount;
> +	/** @wq: Workqueue on which to run the worker. */
> +	struct workqueue_struct *wq;
> +	/** @ops: Driver operations. */
> +	const struct drm_work_fence_ops *ops;
> +	/** @fence: The watched dma-fence; holds a single reference. */
> +	struct dma_fence *fence;
> +	/** @work: Work item queued when the fence signals. */
> +	struct work_struct work;
> +	/** @cb: Callback registered on the dma-fence. */
> +	struct dma_fence_cb cb;
> +};
> +
> +void drm_work_fence_init(struct drm_work_fence *wfence,
> +			 struct workqueue_struct *wq,
> +			 const struct drm_work_fence_ops *ops);
> +void drm_work_fence_get(struct drm_work_fence *wfence);
> +void drm_work_fence_put(struct drm_work_fence *wfence);
> +int  drm_work_fence_add_callback(struct drm_work_fence *wfence,
> +				 struct dma_fence *fence);
> +bool drm_work_fence_cancel(struct drm_work_fence *wfence);
> +void drm_work_fence_cancel_sync(struct drm_work_fence *wfence);
> +
> +#endif /* __DRM_WORK_FENCE_H__ */
> -- 
> 2.34.1
> 
