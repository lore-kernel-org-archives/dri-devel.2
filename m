Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A04EF4ED4
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 12:26:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93FEE10E1B1;
	Mon,  6 Apr 2026 12:26:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mPE4wjVc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2ED710E1A7;
 Mon,  6 Apr 2026 12:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775478413; x=1807014413;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XBIX18YPNZf2EhyJv16XuXsR7Ugs0DZYandKgRlZaS8=;
 b=mPE4wjVcBInrpHUPaTCY4Rb+Cnyl8gqXqcDhNoDGKAuuijbuHTq9a9Xl
 lF46kf19VUH+EYcUPudA/trFXirEydNgUKcKiTt/4gq5LZsmHjFos4J4B
 GegIPxX1mEi/jhiN9GErWcijNsvgF/QaPnMeGUVmF4qP2kvItIBqNC81J
 R50z1HmSd+I9BeEX78swZvcecjOAly/QWP3Z5xkLhk63h3E9da7/WOjL4
 Zv+ZwjHpGh+GjjRzPR1/fm9mLSab/RgnwzBpvx+upgC4v6kwKpe+FiyfL
 8yOym00dnAMk2ZU8UypNgW5W3Xaytg44/LnCaQ5bAEP1T99/6GLjF/J6d A==;
X-CSE-ConnectionGUID: oty6oXg1QaqY2B+Ae0HJNg==
X-CSE-MsgGUID: Tvv6rSbkRdmlEb6XCs5+ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11750"; a="87050143"
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="87050143"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 05:26:52 -0700
X-CSE-ConnectionGUID: z+mHpBVoT16f6zWz0/ZbnA==
X-CSE-MsgGUID: G4UZg4qKRAG59Ixavqy+5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="221285432"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 05:26:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 6 Apr 2026 05:26:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 6 Apr 2026 05:26:51 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 6 Apr 2026 05:26:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXDT2saNg09DKyfxF+jXkhPxchz8MyHflSIaIahJW32BLWLtnDN8FeHRlnmfVkC5BqgDzJwzvzYfGaeST5EGN43qug8OYeBX2DSfXYIxnqohIOz9nVOB214TLwoMxWliV6wX4AXQA3PihVWADbmS1y8feUST5TcPX3KO2zCQ1eYJ/hI+DJbrFVHD5bchYRjQ5AxOspb7s7UTPZLD9w53Ojgi5bQ1xlJOaifmoJRJUbexqY+RJVmSSTLK9OwZS2zAhbrhIT2CLNl5Dh+gE0A0H4HNVcgXong6HprOgna2ESVOnK3ffUsKbUy7e//utOrK5k3IVmGGLvenxOtcfj09LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G56oePaGZZ9VaVSa+Ng263HELQ7G14uCFY5FvzewXdo=;
 b=fPRgq7puqwzda99YaPfitX4U7TEmrd6+FANJxtH+v1uroXDwrSU3y3GWQuLNrGpXtrgfAJoGWlOgkH/ye4YLNqKLJ6OW8KijHX/ehsHhL+I8b92JU3CGlLZNwULSMQVgd9csWOMLKeYfXMuWtHV0o2v76n/7u3TE5jVDf2StkOT0c/IfWp1FxGxdikeAbnKkTXF9jJ/Fa/GRKy60ig6gFRlONmBSyGvlZJ6FuuzrJJwwHstCW7TJ2w5pBbHi7yTq61FlurgMVnS73QYLoLzsJR/4pgNWnONE91EqJzznejS+vYY2D9KY8jRAsRvqjgXFCmfjKYTGmtS3ipjy6K86iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21)
 by CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Mon, 6 Apr
 2026 12:26:49 +0000
Received: from MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d]) by MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d%5]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 12:26:49 +0000
Message-ID: <b1561dcb-e7e0-4092-9368-97abd5971969@intel.com>
Date: Mon, 6 Apr 2026 17:56:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET
 recovery method
To: Raag Jadav <raag.jadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>, <andrealmeid@igalia.com>,
 <christian.koenig@amd.com>, <airlied@gmail.com>, <simona.vetter@ffwll.ch>,
 <mripard@kernel.org>, <anshuman.gupta@intel.com>, <badal.nilawar@intel.com>,
 <riana.tauro@intel.com>, <karthik.poosa@intel.com>, <sk.anirban@intel.com>
References: <20260318064016.374656-7-mallesh.koujalagi@intel.com>
 <20260318064016.374656-10-mallesh.koujalagi@intel.com>
 <ac4l9rpozGzrIrGP@black.igk.intel.com>
Content-Language: en-US
From: "Mallesh, Koujalagi" <mallesh.koujalagi@intel.com>
In-Reply-To: <ac4l9rpozGzrIrGP@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0200.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::17) To MN0PR11MB6207.namprd11.prod.outlook.com
 (2603:10b6:208:3c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6207:EE_|CO1PR11MB5089:EE_
X-MS-Office365-Filtering-Correlation-Id: c3bbc42e-24b5-4b6b-f17e-08de93d7c64b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: jJCjdT24Po3k6D1x3CqE19SY8y1h8qDm7NlIkUhyzm+fisdv47ZWbtexe0SeGY7Cyj5w8hpCs+XVvHjGyErWdx/9H+KLT0u1f//oLRgzIpUmtZ052sPbevVnJ/XJSXIc5vGGDebuLOZ2PP9LphdPtDUxICw2YB991pCNTZr7H1ExDfN+TK4bE6Zy1KbOP3u+5BAfb6FIyEkAL2XiIt7zrQdBJ5z7XklsvBsx5HqXerSLnXD9DWnXae7ZDfVkinQdjt95uEnvVFrpxIXBZsZliQKSuaG1fyzK8ul7frO6gbz/OxE5RD2iMph/i1QIqRmSaD8rCTrk4J1MdcyfetcjnqH7DTPkHpQat95i84tM4vEQECWZEOpPjCr6nL0odwYhTkWSaN1k/HMWMvAe53r16G+UxAZegYXDf+/0GsqJFCxU4huZdHAHUkfKFUAD1kzWwwfXd4yBrZIqZ2TSySkwcTznUat5GBa9fhrk8/U6l8ZBQPGku+E9mPFwPpNj+96+zn2nUnrPtITTciL7nfIzOt4SxgGC0nEQcxNl0qh3vHEAhxYOKjf8yRCtwpoyeWMJ9MPAYnK6IjVAAZ9PAYdDl2f96r4fpMmRAGEz2/bq4N8Nko2gSApkkC4qW706T1IA9aJkU9I2/RXgMBt3ofFEz7dStLwSjc2RljcccHyp7cuK1ljwFDlPsaA4MPAsnKQdlc46leYt4oerTajP4PyndzZFA4nxkdDLdeOzQHEesoo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6207.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzNEUVBzVWY0cnBUY29YSG51cnJMNnZkaTVwU2VHUEFBM3JtQStRY1M0YWI3?=
 =?utf-8?B?VzBCMW01RmJSU0pnamxVcC9zdFB2cUNFU2V1QUR3cVl2ZFNua2pTSDFMMzVY?=
 =?utf-8?B?KzJvdU5XVjB4bGI5Z1UwcFpEd2dMdW9qMndIVjV4a0hxT1B2SmwyUUt4MHBh?=
 =?utf-8?B?YTBnWWkwOFNwT2YvclBqWkNkZERuOVIxVGNlT0NHa29jM1A5bVExODhnY1B2?=
 =?utf-8?B?TzAzdnFKN2RPMVROTEJUaVI2NUlLbnBVaDZTN0hud2RKbHljTlFOM24zZEtS?=
 =?utf-8?B?bWQwVFBYNFI3UUlMK2hCcUZDa0UxNVM5TWVWaWk1enZiV1dGanRFM1g0Zk5r?=
 =?utf-8?B?QUtHNFdvV1hlV0Vod3ozU0RDbUJtZzkrV3VLWmZkb2lLVFhVRDZsQlZ5b2ZQ?=
 =?utf-8?B?a2UzNE04R2Fhck1wK3lMK3lHbHlWMFZEVlZKWnhqKzh3VHBrUm0rVkxJd3FY?=
 =?utf-8?B?eEdCM0pBUDQ1aDViT0EvYTNObUtKR2krS2xqQWRZMVhwejJETjBPRVF4eFZN?=
 =?utf-8?B?eHlvSG9Wc1FNYWdFYUsxNmd5YWU0MFlIY2xEc0VlK1h2S2d4Y0o3SDFYU3Qr?=
 =?utf-8?B?T1NreW85L2hMenI0ZmhTSEUxV1JkZDhPR1pJaUNCekVFSWZxVWdVTTkwUGRt?=
 =?utf-8?B?UERvRStIcnR6NUd3QnFmc0VBUGpJcGkzdDBVOHRWOWVuN2FvWnlvaUExbUta?=
 =?utf-8?B?elNWdERQSytsWnlFTkFqUytBNFdDaXdSNHpkSnBJZ3UzamNGU2ZudmxiUWth?=
 =?utf-8?B?N1luWFI5VVR5UG42QUdNampDYlVyTlRCZDFtSkxLTmw2L0VMWWR1cHNsdXVj?=
 =?utf-8?B?UDVBRDhrS2NLRFFQemJiL3ZQempxTTUxOGlmU3Z2ZU1Qc0NQejJISlBobkNZ?=
 =?utf-8?B?azFvemxxSFAwY3o0azVNZHFOUjdyaVY1TlpGVHRNTXA1blQyc1lFL2M3MUti?=
 =?utf-8?B?UGxSdk44ZzN3bDJzMU5CMTdzSm5jQ3k4ZS95VnFCdnRWdmVNWXVOdUoyR1oz?=
 =?utf-8?B?L2VYM0tSZUJNL1pmQm14MklEOTJpbjNwVk44ejZVd3pZM05OTkV1aUNKaHJJ?=
 =?utf-8?B?dmRBYWtoTkJET2h2a1BoQ3pTRUwwOURHajhYYTM5K2syUmJxNkh2T0tKdGVF?=
 =?utf-8?B?S1R4ZUdZdnVVWFYxZE9TUEZyUDgzNXE0dkorWW95NE5GakJ5cG1NRFh1eStR?=
 =?utf-8?B?a2h2Q0dQSUtCNG5kREZ1R3oxbTk4REkybzduVUhFTWRXZUNCa0M3VVg3amdt?=
 =?utf-8?B?QmdKSmRBV1p2SzBFL1lHNk1oMHEvdXJ2Ym1Rb25GVWpQOENyY2pmTzdRRSts?=
 =?utf-8?B?OHBtbzd1NE9vdWwvaWVuMWI1NjZrMVN5OWxyRzg2UDBDT1BRMXdFck1wR2cz?=
 =?utf-8?B?K2lwQVNVSW1CY2pYOEQ5K0JqZitKMWc3TGdwRUZnYnlmVjRvQlpVU2JxenUv?=
 =?utf-8?B?cENIRkRsQis5THoxQ2tOamp6WVIrdzdlMXBvaUhwOGVZUTNvNlVIOUZVNkJM?=
 =?utf-8?B?WXo5YmMrYkZ4QTU5bzY4MDFkcG44V21ndVJabmVXQ1ZRTkpacUo0MW5QRDNm?=
 =?utf-8?B?NzVGK3g1UE9zVDRBSkN5K2pRT2JrTXlYdGxNYmtWaTVOOW1XUGg5ditpcStY?=
 =?utf-8?B?ZWRPTzBrZHZnTVVjTHZSVU80OU80K1hIbnZGdytMaFIwck1QUjNYbWdibWJN?=
 =?utf-8?B?cUwwUUhYSUVhenpaOGRmek13aDMraHhTa2htVHpoS2I4MVlNdlhuMjdrKysy?=
 =?utf-8?B?WjZNRWJwbzZNR295MjEyS252VWVqUktYK05BVXhMUXZUTTdiNkNQaElZL0VG?=
 =?utf-8?B?YUJ1bHBwVEFqUXArdUJ5ZFRrckdJWS9IVFpLakRWSzd5bXd1WlVJNE1IZ3U4?=
 =?utf-8?B?UnNtR3FrRnZ0WnFvTXN1WWN4d2JxSEJBMlh6Y3BBdFMydGFMejRtcjN6QzN4?=
 =?utf-8?B?bDJyN291TW5JbGYranVFelNjMFF0RStkYnZyUzQxam9MTjlEOE9PNWI5b3dm?=
 =?utf-8?B?MnM2Qm02Yy9YWkdsZE11SklyUzF6UCtiRXFhTEdOU1hsM0dRT3BUZmgwb2sx?=
 =?utf-8?B?VisvWUU3b24vZ1drKzg2YmxUZi9vbFN0cEdhOWc3M1hTVWxjTGRXSGJWSFhU?=
 =?utf-8?B?VFYzQ3h5L2NEcEJOeVlteXJGOGtHZ1JtZ3JyQ0VWVUtZM1R4Y1pkVStUZ2Vx?=
 =?utf-8?B?OVJMb0VCQ0xQL2E5dE5pb3RBZ0dYRzg3WmIxZUQxNTlxUHUwNUFqaWdwaVgz?=
 =?utf-8?B?UFBqOEF6SUVISndyNnhnckVEREVsMU45UzhtNDRtQnlsaTVZYzlWNHJ1bE0y?=
 =?utf-8?B?ZU91T2w3cFdiY2o3QlFjUVFkVmhVb2lRY20zblhqOXZmWnU4RDJaaC9qZHRV?=
 =?utf-8?Q?X4OOI+1RT3YN5JJM=3D?=
X-Exchange-RoutingPolicyChecked: KlaeqVmNp0VneUypi8cz/ijP64XsXTA7GbGaMIHnJETm0T80a66npx9fS5yHUxoaLhL0bE9PO+GVk40zCsFQ83DNqDpTym+zdTxCDvGIdYIfq7GT36m5faIjVonB6uxBASgCnOr3+dSvF9mOE6mE1F8GeZUrWEL/qXUHmGoxJL8AdmM/MRiD1mtqAsdkzp9/QTnyHhCqoK/RFlZnF+eUC5y8tgONsi6/1BkeOuObvCWIMKSQ3vorspm7ubZj3DGVsexc1s3VIHo+Z+64l1uq2/L/9o9jCZmDJrjY8RmM9JWg8J6Kn3IQDrn5FnQX49K4Yav+Di4agjiRkkT64bu6uQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bbc42e-24b5-4b6b-f17e-08de93d7c64b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 12:26:49.1523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22fdUCcNby3BuT3zcqTKR1ROyAtOjSi6jKgFwJbIUddhzsv/uNN6CZYubbepBKqqKU/tVT1gQvfb7H2NSPCaB15O7SVFH1cdwUykHbReX/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5089
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


On 02-04-2026 01:46 pm, Raag Jadav wrote:
> On Wed, Mar 18, 2026 at 12:10:20PM +0530, Mallesh Koujalagi wrote:
>> Add documentation for the DRM_WEDGE_RECOVERY_COLD_RESET recovery
>> method introduced for handling power management unit errors. This method is
>> designated for severe errors that compromise core device functionality
>> and are unrecoverable via recovery mechanisms such as driver reload or PCIe
>> bus reset. The documentation clarifies when this recovery method should be
>> used and its implications for userspace applications.
> Aesthetic nit: We usually try to utilize the full 75 character space where
> possible (in all patches).
>
>> v2:
>> - Add several instead of number to avoid update. (Jani)
>>
>> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
>> ---
>>   Documentation/gpu/drm-uapi.rst | 73 +++++++++++++++++++++++++++++++++-
>>   1 file changed, 72 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
>> index d98428a592f1..5b63f1c17b9b 100644
>> --- a/Documentation/gpu/drm-uapi.rst
>> +++ b/Documentation/gpu/drm-uapi.rst
>> @@ -418,7 +418,7 @@ needed.
>>   Recovery
>>   --------
>>   
>> -Current implementation defines four recovery methods, out of which, drivers
>> +Current implementation defines several recovery methods, out of which, drivers
>>   can use any one, multiple or none. Method(s) of choice will be sent in the
>>   uevent environment as ``WEDGED=<method1>[,..,<methodN>]`` in order of less to
>>   more side-effects. See the section `Vendor Specific Recovery`_
>> @@ -435,6 +435,7 @@ following expectations.
>>       rebind          unbind + bind driver
>>       bus-reset       unbind + bus reset/re-enumeration + bind
>>       vendor-specific vendor specific recovery method
>> +    cold-reset      full device cold reset required
> Does this work without unbind + bind?

No. In cold-reset method, we do unbind + power cycle + rescan/bind.

Thanks,

-/Mallesh

>
>>       unknown         consumer policy
>>       =============== ========================================
>>   
>> @@ -446,6 +447,27 @@ telemetry information (devcoredump, syslog). This is useful because the first
>>   hang is usually the most critical one which can result in consequential hangs or
>>   complete wedging.
>>   
>> +Cold Reset Recovery
>> +-------------------
>> +
>> +The ``WEDGED=cold-reset`` event indicates that the device has encountered
>> +power management unit errors that affect core functionality that cannot be
>> +resolved through recovery mechanisms.
> Here cold-reset itself is introduced as a recovery method, so this could
> use better phrasing. Also, we try to be consistent with terminologies
> already in place so that the document is easy to follow.
>
>> +This recovery method is reserved for power management unit error conditions where the
>> +device state cannot be restored via:
>> +
>> +- Driver unbind/rebind operations
>> +- PCIe bus reset and re-enumeration
>> +- Device Function Level Reset (FLR)
>> +- Warm device resets
> These are already documented so not sure if it's worth repeating them.
>
>> +Such power management unit error state typically persists across all software-based
>> +recovery attempts. Only a complete device power cycle can restore
>> +normal operation.
>> +
>> +Upon receiving a ``WEDGED=cold-reset`` event, userspace should initiate
>> +a full cold reset of the affected device to restore functionality.
> This is already covered in consumer expectations so can be dropped.
>
> AI assistance is useful at times but we'd want to make sure that things
> remain objective and translatable ;)
>
> Raag
>
>>   Vendor Specific Recovery
>>   ------------------------
>> @@ -524,6 +546,55 @@ Recovery script::
>>       echo -n $DEVICE > $DRIVER/unbind
>>       echo -n $DEVICE > $DRIVER/bind
>>   
>> +Example - cold-reset
>> +--------------------
>> +
>> +Udev rule::
>> +
>> +    SUBSYSTEM=="drm", ENV{WEDGED}=="cold-reset", DEVPATH=="*/drm/card[0-9]",
>> +    RUN+="/path/to/cold-reset.sh $env{DEVPATH}"
>> +
>> +Recovery script::
>> +
>> +    #!/bin/sh
>> +
>> +    [ -z "$1" ] && echo "Usage: $0 <device-path>" && exit 1
>> +
>> +    # Get device
>> +    DEVPATH=$(readlink -f /sys/$1/device 2>/dev/null || readlink -f /sys/$1)
>> +    DEVICE=$(basename $DEVPATH)
>> +
>> +    echo "Cold reset: $DEVICE"
>> +
>> +    # Try slot power reset first
>> +    SLOT=$(find /sys/bus/pci/slots/ -type l 2>/dev/null | while read slot; do
>> +	    ADDR=$(cat "$slot" 2>/dev/null)
>> +	    [ -n "$ADDR" ] && echo "$DEVICE" | grep -q "^$ADDR" && basename $(dirname "$slot") && break
>> +    done)
>> +
>> +    if [ -n "$SLOT" ]; then
>> +	echo "Using slot $SLOT"
>> +
>> +	# Unbind driver
>> +	[ -e "/sys/bus/pci/devices/$DEVICE/driver" ] && \
>> +	echo "$DEVICE" > /sys/bus/pci/devices/$DEVICE/driver/unbind 2>/dev/null
>> +
>> +	# Remove device
>> +	echo 1 > /sys/bus/pci/devices/$DEVICE/remove
>> +
>> +	# Power cycle slot
>> +	echo 0 > /sys/bus/pci/slots/$SLOT/power
>> +	sleep 2
>> +	echo 1 > /sys/bus/pci/slots/$SLOT/power
>> +	sleep 1
>> +
>> +	# Rescan
>> +	echo 1 > /sys/bus/pci/rescan
>> +	echo "Done!"
>> +    else
>> +	echo "No slot found"
>> +    fi
>> +
>>   Customization
>>   -------------
>>   
>> -- 
>> 2.34.1
>>
