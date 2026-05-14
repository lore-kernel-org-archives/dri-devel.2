Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEB9CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 09:39:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E747210E10A;
	Thu, 14 May 2026 09:39:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="C/ye4m73";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D7B10E10A;
 Thu, 14 May 2026 09:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778751540; x=1810287540;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=eQRh2ZsydWha6c+KzgsauiUOkgi3LZBd1oBuxOzPMTQ=;
 b=C/ye4m73zNhuZtpebyX/6ZthoNl+PAoQ4sNT8+QW9u+alFlPuXuWTxYw
 P8TpF0GxyZ53rSlyJb5eXUWx2w5cx8Q6hx+CdhIdl0aZmha+TxTk6iS05
 3GJbf0ZMGkNL6DQLULN8i8/mtp5jgNr/UQIGn7riuPqns6Hc+0kOPqwSc
 T9VRyQKGTnrCkTHnNAe+Tse4e+ODQuDwdZD/lb6Bmue1Tftw1FqFyWHyl
 HgZiaq5Pw9v7OILUVdIuB5hVIkAWZ62fzLVZhoGUWvk00Jm9OET2q7sLz
 hWbMlPEH95BV44GPycT9O9Q0tuf9XSExZoM/FkC4vPE5rgnYYoJAGmyVs g==;
X-CSE-ConnectionGUID: jBCHhb8sTh+Ps3TbF9zU9g==
X-CSE-MsgGUID: Revbn2o6T+qGCgek5Li2sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="78832344"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="78832344"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 02:36:59 -0700
X-CSE-ConnectionGUID: 67DTb+twTuOr3tVut0GCWg==
X-CSE-MsgGUID: L0SV64ZJQXyIBjfTM1Twyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="237357005"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 02:36:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 02:36:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 14 May 2026 02:36:57 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.17) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 02:36:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFXOIPdNUCWBiobzanGtbwGz5QbG7qE2mbPHhvwV0b5yv8dC/4Bik783VCbJHLI4XgcnqBSvNcV50cTP+H6oPw0aF8i9pLzEzk5J6BIEiwKdeKTcdYYzuf3SpYrnY/kd49SHDBTDi0PVf0YTrGAQWsq6odU1AKPtRsWRtGdWFymvfppAexlhxR1YkEQtLPSbcaSzXje/4gzF1TIE/FUE48BB3V+hQ0RVmuJH/UaGzqjvAU5z3QxwmZWI4VmIbvNpNfNWALqjA3RvWqxebvw8dwfKgLcuB4S1HG9rQnqeaw7/bMt80m6jaZE7u9Ul6EYB6EDrAuEptlYTp/vRKpJ86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGCSSXgfM4a5F0TtZzdTbK4KuMuYZ42t5J9+KjGz2Gc=;
 b=LSvK7aAJa1P5s6JMBJru56wKXcCa8OKVFFLkioZPiouGcbZd1Z+HtTT+42nf/kaexUkX0MEYrtOwobEVHms3nXZQ7KmkPj0sTO6LdFplNGUqb0L/9y7ouZnGAccwxhFUETMTt/tOAHlLmmIF31PagrbYfgxiA85L5nkd9Ba2DBBliliu1+W58ZbGv5BmIrgsWlOPOsBXnWYkbfXMTbZoR3QIpzx9n9Face6E82JeUTOQjpelAHVYczT9HnqbFvgIPK+vx20q6hSlAFshtC6XtntS6avzHk3fiYmuZVJacfTcEx+O7tKFq/e2EMoqa2svb/sEgKDV8KlWLlpTmaAoAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 SA2PR11MB5050.namprd11.prod.outlook.com (2603:10b6:806:fb::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Thu, 14 May 2026 09:36:50 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 09:36:50 +0000
Message-ID: <0e5cef01-3770-4865-8571-82611f52c553@intel.com>
Date: Thu, 14 May 2026 15:06:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] drm/xe: Suppress Surprise Link Down on non-hotplug
 device
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>
CC: <andrealmeid@igalia.com>, <christian.koenig@amd.com>, <airlied@gmail.com>, 
 <simona.vetter@ffwll.ch>, <mripard@kernel.org>,
 <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
 <anshuman.gupta@intel.com>, <badal.nilawar@intel.com>,
 <karthik.poosa@intel.com>, <sk.anirban@intel.com>, <raag.jadav@intel.com>
References: <20260512132614.1793083-7-mallesh.koujalagi@intel.com>
 <20260512132614.1793083-12-mallesh.koujalagi@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260512132614.1793083-12-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::17) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|SA2PR11MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: 3077d843-2b43-4c6a-b91a-08deb19c5311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|4143699003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: Fhd5lYEMKPy4+VO2tvQ8zrLaJQxLlvSkcAkvoVcYrEJ0es1neH9uTE6nFCbwjv+819QqAA944kCT6agu0oDCqrzxgOHO99b43kbjtj5FvfNfPGb9UvEjMaU0JqDYBi509tXWgpnZ0MO421XphSieCLtmiPyVR3pZ49ZU1S79INbltOtcb9wxLQMk9Xzgjm5GCOErNCbAucnDgGFKUs/uogVvqCOmT7RBJQs/tv9s5mPXP+L5khcwa3Llvi5IWzM3lvcHNlB7U7CQTjIAZ84dtS3IQ/G7ISncQNx6FkSac07NZ4FGdPTqVk+TR/MOqFjlEn6hptkrPf30Bv2se3Jf4g7GWximy3euqt+H2Miy7ZJ3cGi5cSkXXpR9XyVV97YZ8N/zSgKJAkA7F5UG9sZulY7zma7DpDA99uTmOU3TyylQ9q2D80wJILb3VL31k3JempwuTObKks3ZZ82VzA0KBnaoqZClvNrvbC6MOvmI3uh1jfuTbNtTTHuKio7t8nbeS6C+IqL0oUAI/1wGv44DinL1hB/JdaUOGX7HmW8UE0EOGfkjMuBkY1FVARn24SOorWkP/qL8FEvsNj7+w2jeOCuCA3K4R4I0ItEFBXzNJ2mMpDs3YYIQ7PeFE8IDTJQXbou04ogT36NXnEg2btoB2cEPwsqBQoho/sodf+jWBzrp7DM5mnrdLpQeeIJaTf7d
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(4143699003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0FwNGVuLyt6OFZiRFM3eWRSMDltdGhiMHNwd0xBTlBUbFFiTGhjYWZuekJ6?=
 =?utf-8?B?WXRXYTFSdzRDdHkxMG12b0RUNlg4YUlIbVJJMG40RklIcStaMlYvZGpEVEY5?=
 =?utf-8?B?MjgwVTI4eGtNWGpGbTd1V0dBYTluNS9sNWR5M0ZneGFWb0ZrMkprWmVkd3NW?=
 =?utf-8?B?eVNkbld6MUJvcVRPVVZvR1FsM050UzhjazBOMjJIV0JBcjlaQzFScEt0cCtC?=
 =?utf-8?B?UXd4M3BlRVJWcklqcDEwSnJGMUhrdExnMUxCSlNJMml3aWlFRzRPZk9qSElk?=
 =?utf-8?B?QTZRK2FKSzBMN3VWUnl5NG9JNml2d1BlNjdmTFdDUXU1czRIM2xrTzB2Lzll?=
 =?utf-8?B?ZHJRZmtaSndFOVRvZlkwSVN2U214UlhPc2dVVmtWR1F5SEIyYVBJenhkRWVi?=
 =?utf-8?B?RzZVWmZ4NGlydHowTHMzUWVZVVJPUGxDM1Jxd2k1UXJJQ2hZemV1SDhpbUtK?=
 =?utf-8?B?bWd6c1ZMNktDVlo3M0lLeW9QVzJCanU1UjVvUXJNZUlDUWZaUURFYTdzY2M5?=
 =?utf-8?B?WHVjY1N3T2p4em1La2VVQnRpUEZOTWRFN1N2RmRMeW56OFllYmVoZVVpajhh?=
 =?utf-8?B?R1hpUWp0RlNnUXRLR1NHNjVpQjU3ZU44QjRqSlIwbXhYY2ZNZWUzb1djMTQx?=
 =?utf-8?B?dHdydmRwWlBEOTVzN1lmVHZXZmZlM0R1V08vM29wTW5XS3ZzZTdCSW04WDJm?=
 =?utf-8?B?OW0xSDk1UjNGVVk2S1hWRjNRSFFjN1J1bzgvamZjUHFWRnRONSs3azNmOFQ4?=
 =?utf-8?B?d3BNSTB0d1VwY2hRaWdxWWMwcDdCSm5nejU2T2JLT2p4ZVUwbFZ6VXprQlhr?=
 =?utf-8?B?ZGZHMXRzMUVTdWZ1YVAwcXJRc09iQlZsanR0d2JMMG9BTGdwaDVhalhTdFdy?=
 =?utf-8?B?VXkxcU1sWTFCclZIdlRwUDdWaFBSeTNnc1ZlZE9tak1sT1RYTThCMUU3ZWd6?=
 =?utf-8?B?K0kyRXFudjVvL2ZZdmZKTktZakQ3c2VoNHFxTDE4YWRVbElSd0gwWGlpRkcx?=
 =?utf-8?B?VjQyakJOU2UvblFjSjZiNGM0Nmp4N0NwZWplNnh6Q2hNdnFjWFNya0JxNjhw?=
 =?utf-8?B?My9YSDlXbFNVcHFQenkxbytiVlB0dStpZnRPOXVaYzVzRHZNb2NPMzdXcm9B?=
 =?utf-8?B?Q3d0RVppR21UUzNSMWM4Q3Z6azVrSzI1N25qZTZ4a1daMDYwYUJEMEE0VXdk?=
 =?utf-8?B?ejd6Y3RKQW9kL2pVVU1PUzBDVThnSzdVWUMxdVI4WW9CNUxINmp6R0tob1Ax?=
 =?utf-8?B?NUpKVEdEWEFFSi9SZDBrMEpBMHZRTFVCZlVTbGxyZ1pHVVJnV05vck9BRWg5?=
 =?utf-8?B?cmJKQmx0N1cvL0szNElLbW1xL2FKVW5TZkNCU2piN0F4QkwrOFhJdHpsSHRT?=
 =?utf-8?B?NVNvdlg3cUM0WHNtR0dwcHRkYXJLc3hzOENJTkdhdkdVZ2VwYmt5a3E1K1R2?=
 =?utf-8?B?K3k0MVlKOGxXWURUaTVqNXZMendDNXN3cDdXUCt3QXg2cUNrRzhPWThmMVZ6?=
 =?utf-8?B?UzF4elhsMmkzakg3R3ZmdHhTSEVEQ0JXUHRMcFJMUUprT29Qb0FIdU12cHdW?=
 =?utf-8?B?djZ2TEVwaUFTd0c4ZWEzZVVSb1M0MSsrcnhpUXJBVnZERnRLMkxhSFFER2ly?=
 =?utf-8?B?STV4WUJUNnRYWFNTYkNJYVRaMTAyTHVPSVJ6aUFsK1NZcDRSZlFtTVlhTnVR?=
 =?utf-8?B?VHdQN2tiMWNFS1FHQnVxQkx6SDRpbnZ6T0puUW5iOU1Nam9JT2FaWGp4SXpR?=
 =?utf-8?B?cVRZU3BnQU95VHpUWnovaTJjV1ZsNGl0Y1h5NXVxM3RmSHY5RDExaHNSMWx4?=
 =?utf-8?B?bzhIdy9oL2xxdTBLam5MZU9BZE1uU21mOEJGZ2IzdVUzYXR1VUU3cmh3V1l0?=
 =?utf-8?B?aDRGZDFGVWhqQUN2ZDNteWlDTFd6R3JHNWFncWEydDJQbS9pd0lQaHRUVC96?=
 =?utf-8?B?RUNMS2FobVBPQXJvZWFucjhKZStVaVgrSWRBaWU4S3hXcThycTU0QWhxb1VW?=
 =?utf-8?B?REYvK0NZOHNRVkp3NytrMVFKVHRqN0ZpSFlWUWVvMFNUdGppV01KYjRpMHcx?=
 =?utf-8?B?c3RGTVZETlhpajZWQXpyMUtzOCtSaGoxNjJBSVJUWmJaY1FKcUJVSGx2Q3Fl?=
 =?utf-8?B?U0JYRXozeStYNVdFVEtOOXE1QytENnZSb1c2RFU3VjFQZ0hMcVo2K3dVK3Ir?=
 =?utf-8?B?RTAvRmU0RS9XU0FueFBVQWJEcDdRUHFocG0xbDVEdkt2VTdJNXFlRXVwTEk3?=
 =?utf-8?B?N1hTYzdrUC9oakNVNGFmR2ROZXZTZUhIZVFHbUg3ZDlMOHd4N1dxOVFDa3pN?=
 =?utf-8?B?K05KOWduRUovVklhbEFqdjlSMmdKZlE1dzJTUFJSbEllZmpCVkhIQT09?=
X-Exchange-RoutingPolicyChecked: XTJCQu7xv5w5BWD3Dd5O9Mf+nIrpE7g28m/XlMDLBsHINudSwnfj5JbC7lGR6r5SGuZrkGY03PaPFmsRO28Kvp1Xtji/oIajdLH21Ufi91RoUu9w/Ln7azmlr7xiS05xdGsBG6vQVqfiUmpJlUs52K6htNfhoxaZCQbH5hM1mEPK7BvxmRLMihGfB2GhN2ic9th/BXkpQ6KkoduvBckC+9ldwSRxn8IL5gnObbpEiMMlAEVsl+kzEvcR4/2rV07vFV78SCbij/ULdRoGFjFQXQDbiPya10mELtOlzeNoALXlLr8lgdHTG4Gf3my+lTzWuCZFlcs0nwOwpCZ+99gTgg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3077d843-2b43-4c6a-b91a-08deb19c5311
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:36:50.3312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCN05ygvfdBiV6WCbYagcflwrRfz+ba3oQMDAhwY4Kd1UGLISGzdfftMXc6/EGHGC07G0hQK9rQKVlAZCBbnug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5050
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


On 5/12/2026 6:56 PM, Mallesh Koujalagi wrote:
> If the slot is not hotplug capable, pcie_suppress_surprise_link_down()
> masks the Surprise Link Down bit (PCI_ERR_UNC_SURPDN) in the USP's AER
> Uncorrectable Error Mask register before punit_error_handler()
> triggers the cold reset.
Provide more details on why. Avoid function names and macros unless 
necessary.
Make it more human readable.

>
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_ras.c | 51 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 51 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 604470565bf3..67b4f25370c9 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
> @@ -224,8 +224,59 @@ static enum xe_ras_recovery_action handle_core_compute_errors(struct xe_device *
>   	return XE_RAS_RECOVERY_ACTION_RECOVERED;
>   }
>   
> +#ifdef CONFIG_PCIEAER
> +static bool pcie_slot_is_hotplug_capable(struct pci_dev *usp)
> +{
> +	struct pci_dev *root_port = pci_upstream_bridge(usp);
> +	u32 sltcap;
> +
> +	if (!root_port)
> +		return false;
 From the PCIe spec

"If this register is implemented but the Slot Implemented bit is Clear, 
the field behavior of this entire register is undefined."

Please check the slot implemented bit (8) in  PCI Express Capabilities 
Register before reading the slot capability register.

> +
> +	if (pcie_capability_read_dword(root_port, PCI_EXP_SLTCAP, &sltcap))
> +		return false;
> +
> +	return (sltcap & (PCI_EXP_SLTCAP_HPC | PCI_EXP_SLTCAP_PCP)) ==
> +		(PCI_EXP_SLTCAP_HPC | PCI_EXP_SLTCAP_PCP);

Do we need to check power controller here? Isn't hotpluggable denoted by
PCI_EXP_SLTCAP_HPC ?

> +}
> +
> +static void pcie_suppress_surprise_link_down(struct pci_dev *usp)
> +{
> +	u32 aer_uncorr_mask;
> +	u16 aer_cap;
> +
> +	aer_cap = usp->aer_cap;
> +	if (!aer_cap)
> +		return;
add debug log
> +
> +	pci_read_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, &aer_uncorr_mask);
> +	aer_uncorr_mask |= PCI_ERR_UNC_SURPDN;
> +	pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, aer_uncorr_mask);

save config space?

Thanks
Riana

> +	dev_dbg(&usp->dev, "Non-hotplug slot: Surprise Link Down masked for cold reset\n");
> +}
> +#endif /* CONFIG_PCIEAER */
> +
>   static void punit_error_handler(struct xe_device *xe)
>   {
> +#ifdef CONFIG_PCIEAER
> +	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
> +	struct pci_dev *vsp, *usp;
> +
> +	/*
> +	 * Device Hierarchy:
> +	 *
> +	 * Root Port --> Upstream Switch Port (USP) --> Virtual Switch Port (VSP) --> SGunit
> +	 *
> +	 * Cold reset power-cycles the slot, dropping the PCIe link. On a non-hotplug
> +	 * slot this triggers a spurious Surprise Link Down AER event on the USP.
> +	 * Suppress it if the slot is not hotplug capable.
> +	 */
> +	vsp = pci_upstream_bridge(pdev);
> +	usp = vsp ? pci_upstream_bridge(vsp) : NULL;
> +
> +	if (usp && !pcie_slot_is_hotplug_capable(usp))
> +		pcie_suppress_surprise_link_down(usp);
> +#endif
>   	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
>   	xe_device_declare_wedged(xe);
>   }
