Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA95C531FC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 23:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1B3410F254;
	Thu, 23 Jul 2026 23:19:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AsG2WuCo";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE40510F24F;
 Thu, 23 Jul 2026 23:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784848765; x=1816384765;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=YAIspryRCpywyST1OkHk63PVboKSZKd1z9kf7pA42zI=;
 b=AsG2WuCojB7QynaLM41ExFkEq/FS9/ffc8YCMGSI2UdMREJSb+9T99VC
 BM2o5rwzA/0JVXHQMuVdJzW3Ud4v+vjr3SN4A45iRlm8Pu46IN38eMLW4
 m3gan9L4L8IJpb/EaQaJQg7P7Np0QS/9Xho/9lTKXC0bc/JR1Gub+65Dh
 vT0gHjFL5Uv8Bo++cY8AnrEqJ/QW0moP2X3bvJYuDgdjdnq/5Oh+ctAvG
 P85wVnwNUpnWZk7UJJSbCLPuF860jJEuSVJnXiZplSKYeby07uuN6nIu1
 XxmDL4WDJGX4O/V6rhq95G2KIQcfI4kfNYKdSMj3RBH+hd2g2ZStypjCH w==;
X-CSE-ConnectionGUID: dGdD9zQPRqSGYT2IC671Eg==
X-CSE-MsgGUID: ssAZkk8QR5CwuEha8eSSZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85562563"
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; d="scan'208";a="85562563"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 16:19:24 -0700
X-CSE-ConnectionGUID: xN9HFnSsR/++AZloxL+6MQ==
X-CSE-MsgGUID: SnTPzUAlRy+ZndioRN1LdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; d="scan'208";a="288522171"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 16:19:24 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 16:19:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 16:19:23 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 16:19:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgql5ej0E7MAxVPY707YeQbfbkSPe1rJW5Fy8mR/dLalNP+Y45Mk33jiZSWA3L0Geug3Awz+8dJzl9eucxMzYOWrvf0UbeKC6KuMAKBOtAxQKWOPUn6kfVMoR3Gg9K6KkLDhNaK59nNoHadxEdYdfi2hQvIC4j5OzzRxoLg1V6CnBjW9nH2YnifRmyidmMV9DPjFzUFZ++UGmDTvG/C2UZJDmLSKd2oH8LggKh5QPvh6fr6NWiyGaNCDDl0gZdXJ4gYtIJC+1+YwhkP+7kHtSIPDOReHFJC9pX2hKbSriZGStScuAD2vdaNjwapxSS3q1FjEsKlEhMwwWxG8k5uHSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhLVFNYgw3MEZiub0fOUbXwssBgzdjiMRvhK3QCvWQc=;
 b=cozT//+ILK0O+fyhZhk42YjMpEZSbvJv04aVl4Abi+A09ygXFFUP5HFwK+AQCcnStyCgx2W/ukJLnCHL0htND2Wpsnslo/zJqinLEwU9bWHGtVE7WQvXyUl86rhfgmLpacN5mFOGze69tfgFdji4F3s7t6NArVg2nPelSwiax5Yb9mR/2StXkM5E/sbGv8Cd37luBYsPFJDNdZ3+rIpK/b78R2wP9OLt2b5Ce1oZS5O5poggyoAoVa4QNgDD3lo56r/VgCYxTxqjtI2IJVrY8heKvKzNbCvaN8QDlUd+6wjl9SvomPaooLg3QYGTiYedvi2J/RBt73ZYfce7YhLyUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by DM4PR11MB6263.namprd11.prod.outlook.com (2603:10b6:8:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 23:19:14 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 23:19:14 +0000
Date: Thu, 23 Jul 2026 16:19:11 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tales =?iso-8859-1?Q?A=2E_Mendon=E7a?= <talesam@gmail.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <thomas.hellstrom@linux.intel.com>, <rodrigo.vivi@intel.com>
Subject: Re: [PATCH v1 3/4] drm/xe/guc/ct: Queue G2H worker before flushing
 it in timeout paths
Message-ID: <amKhbyYjQqcG1Asc@gsse-cloud1.jf.intel.com>
References: <20260722004654.744249-1-talesam@gmail.com>
 <20260722004654.744249-4-talesam@gmail.com>
 <amExusdY0Qhs3LIx@gsse-cloud1.jf.intel.com>
 <amE+Ltrb8qKNKWd2@gsse-cloud1.jf.intel.com>
 <CAHBRX4HbDnpiEqgFauZNMWPq+Wtp6RhYYLKMW=zNbTphAB_xgw@mail.gmail.com>
 <amFftEnuIfPJKFPX@gsse-cloud1.jf.intel.com>
 <CAHBRX4GTHiv+3YYiNoDFy0L8KAyb7ruqDZR1rV9MNGwHBmLhnA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHBRX4GTHiv+3YYiNoDFy0L8KAyb7ruqDZR1rV9MNGwHBmLhnA@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0116.namprd05.prod.outlook.com
 (2603:10b6:a03:334::31) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|DM4PR11MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca9c6c3-8d95-452d-dc76-08dee910cf7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|4143699003|56012099006|10067099003|5023799004|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: bIZ9FayAnxs63ENRj5rROMHYXOtfXdzv4CY32qFM5B5De86IcxrYIlGe5JpMTckpUpcUooSmILI4rxq5G4D773LyadH1SqwRjSB1vIRnXGlpXAOmMyHarghgQkkqtWLUt2gYIG48PEcoZvK0xahBRT5VDEFkxNNXIKoAK/M/Ww73BVboWa9eq63w9/asmSKnyi5fCtBaPOr+mZKFT8kccjVSYbHVdRULgYROY1qhEQbibvmnyaE37qkmirl4ZxhXbLw//oHuaCy3ePYkPsMYeaBDpCC+wGBc906whT7O6VLTx3rhku+nP9ahmDNRTL64s01P9eMdW9D1pIQOj6m22o/q0CiL1WBb5xmq7Pd/5Nr2pVcmCAkvZN76zvpvI+IfrdppZ6oNI3UWG/ZPYm1dgP1HOe1v1LjrbkvGvXLtWB8Lfsvs+R61cHPcfeS/G3+whglXTzPDxsZP0D6swbqa/iueHVZcXxV7pL8cUUdsb9Qe9M6KjpMFl8h2rMX2nVlnX9beGT5ny4mP0Y3NIGU6WNHtj8I5K+ErOtSowv2e6MhOgdZULC6R3pcXe/C4uifOimWs6cKZRU9lVUwex+ILj6MgV9MYLbTabomCBosJc7BQfgfCbkTDMqNAPA9dNDCYkegjfNYKuvAN3R7RL9JEbviWF9RMIe7LDyhZcLcJ5vE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(56012099006)(10067099003)(5023799004)(11063799006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDNPTENwQlJLa2RYcklZOU9LTXlCUEt4bDJwdWljTXF2Smw5VHBFT0NTakJq?=
 =?utf-8?B?UlhVV2hYWCtvbExsbWJSYkFwSGVxejRSQ1dGSk9USGp5SHA3MklCLzJkTTNB?=
 =?utf-8?B?end3K2FzMk01VSt3c0lZa0xzazdFVGY0Z2w2OVFMalQ5Vm5sOFpEYktNZ3g3?=
 =?utf-8?B?ZHljeENPTFhyZEdrSG1VNW9mZkJDMVFHSWZpMTBFaHlkYTFTR05pWFNmdERU?=
 =?utf-8?B?eVlLU1ptcXdZT25OM3E2SmtlY0lFRnNZeTlIWHl6MTZiajNHRUo4ajFFOGJq?=
 =?utf-8?B?RllGWnRtS0ljWjZnaHdGOXJpTEZLajZoMFRYdlBwT0tKb1ZoQUlsRTRsMWJS?=
 =?utf-8?B?UGZ1TGFXcytYZExjeHlPbjhDOUgwcnBYTVE1bmgyYk1TdkYvTC81d3VocFhW?=
 =?utf-8?B?aWJjbW9HaVFvaEZZYkkyM0U1UWV2SHkwcTBlZXJtQkRnL1NIajIwSXR5Ynh6?=
 =?utf-8?B?bEhDb01KeERJM09SOXA4dzVSV0pEWHQ2bzdKNFZ2MXRzWWNVK01BVnBmL0Ey?=
 =?utf-8?B?blg3VVFCWXFOYzYydHJQcFhSUEN6M1VaMkRnOFdOc0dSK2lINEU5ZjRZYzlv?=
 =?utf-8?B?YkhNOElwMWZRNVhvb2NicE1jczE2dTIxaWthRTRydmVmSUhEQ2RGUjJkaVdH?=
 =?utf-8?B?THBwMy9vZm1WRzNTc0hYQnA1aThMWUM2RVZRNXVQUk5kNlFtWjg0VmRxZmI4?=
 =?utf-8?B?SFVsK1kvbkNYNFd1bHlWbWdvRE16T3dydzJ3eGQrS1BIejlWaHZGeTBWMDhS?=
 =?utf-8?B?Q1MvSjNuWXdGOGZjWHdRTldpZi9ndDc3WEZmTVVPQ25wTHZFV3JHaWhzTEx6?=
 =?utf-8?B?cnJQTEtCUGlaanA4UFA1ay8zWHN5MWVjbE14bENrNGZTRmEvTndGVGlUSTdn?=
 =?utf-8?B?M01mNnBrWm0wVTh5U3BFMU9FbE5RcVdpRXZHbEx2WldJWWV0ejlMZ242b1Za?=
 =?utf-8?B?V21ZTEk3aFpZc240S2NOOVFRa1dESjI0cFdwMkwvY0NiZFY0VWx0NS9lOUpC?=
 =?utf-8?B?MkNsMVZTZlZxZDVtb0QxUktJcWRmaWtuYW9sdEswNDlJVEVoNGxUQXkwL2gx?=
 =?utf-8?B?TGlaUU9iMG5hWWJCYXdLbGNsTjUzZW5wMm5Ra21mbXZMRGxrRHpUcmI0YWpL?=
 =?utf-8?B?Z3NKMEo0dzZHakc2L1h0TXp5S3d3UG5lVnJKSFBKQ0V6NWExNGNNVkE4S09E?=
 =?utf-8?B?ZWVPdWV4QVNIcW9HQWJnbHBoOE5LYit4cEpBS2lxMlU2OGE2b2dlWEl6MEZW?=
 =?utf-8?B?djRFSVVvaEFGZW5GMkZva01pYVJNdllkcURCS2ZIQ0dqWTFhSnYzZ2RZZjR4?=
 =?utf-8?B?RDB5M0JYMmx2RWhETG1DcFQ4dVkwS3ZsOWpJV01oTjJST2N0Wm5NOEMwa3Vl?=
 =?utf-8?B?VmtJYVg5cHhzOWVraFQzaEJVRVlyRkwxTkhVTGFDRUtPK1MveVkzRXgvU3FC?=
 =?utf-8?B?ejNKZGtUVDhqTDgrYnN5NTJ1YkJpZG5nVmRpaDJ2Rm5iVm80eG9tWWFieG9s?=
 =?utf-8?B?eW0xQVdrK2I4RnlDeVNFL1lScXNuUXNCMkJKU0c2bmpMWHRmZUpNd1BldzE2?=
 =?utf-8?B?OXYwcmtrTHdwQ3JQTUpTSWxSSWxCYkRMekNWT2wrUkRHdS9sbEd0c1h4SXEx?=
 =?utf-8?B?bWpWZXdXUHVwVFdqQ1B4UWZScUZ0VS8yRHNBdHE5aUpJeXFIR0FZWnF0ZzFr?=
 =?utf-8?B?NXIxOHJZRjNJYU9OY0VUV3hyZHVQdkNjYXdMb0pTL1hMNzBhYVJiQkEyZ2d6?=
 =?utf-8?B?ZXJwem51TGxQcW5DcVY2WGdQTUVHRzg3d2cxNi9OaGtLMkN4TnBHSmVpc1Fl?=
 =?utf-8?B?dTI0cDM1L2F1ekNNbzlXK1VpVzdxajN6OTNwOUg0dWZUdVdQS3UyalRUMnJt?=
 =?utf-8?B?SkJJUkUrMVBpUUZieDNNdE00QWpKVjJlT1NiVVpYY2ZDV2YvVjQwMlE4VFdm?=
 =?utf-8?B?c0NTMmJGZ3pPYndmalo2b3V4WXgwdDR3ZzBTQ25pcVMvZzlwYVZmTHhhc2pJ?=
 =?utf-8?B?bmNCc3MwSU5LaWpPWm9pSFA2aTRya1lvbUlKS2dTODhHUFdvV1BWZVZGVllH?=
 =?utf-8?B?aVAxNEM4ZUpLMkVlOVR5K1Z4amQrNnd6RDlaTXpaaFErQzM1LytYdjZqZk1O?=
 =?utf-8?B?N3RmaFdpUUFwejU1R0UrSm8rS2hYb1Erc0haR1pYaFE0MCsrMGIzL3VWMTJo?=
 =?utf-8?B?Nk5GUXgvOHhiaGY1bFBPVisvWEtGQkRpY3lPZy9SQlNPbG83cjU0NDVYWGVE?=
 =?utf-8?B?VVRBUjVEUTNZZDIzbDBuRFZzYUJQU1JibUZGV2piVFZTd3NnQlI2bHAvSjg0?=
 =?utf-8?B?bWlOVjhYaEExank1blZvWU9GRUJHTStteUpvVndNVy9pU3YzNUpVZz09?=
X-Exchange-RoutingPolicyChecked: lQPGcXuOjM9ZTswsN7AHzO6uAYPy7ZyLbzQENfYJCJ5lCvaDfDEAveVDj6DzokxlbYlLh0ZgBfzdiOjPw7pXl8DcqW2Vwf3ehjBi2/xeKdjIWQbaLBI100cLU4kRmgpmpjZcOvhy10W69DH95wgthDgrFlA+fRwJSX9x4Na8LgRzjaoc+EhrfD8Br6pXEETfgDjrXkjBY7b4B5wwRODhNKppGIn+pcMtoUxeoupI69kmGyW83ICgS1esn8Co0mSRg7Pr4uVQGXHtEhL3nOD+v7JEGfmS67CWkqwP1MayjLATXepDr9Pt8BziJQhHxiFD9DyFrEaiFeFEARWS1tXM2A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca9c6c3-8d95-452d-dc76-08dee910cf7b
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 23:19:14.4870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTU54vt8OHIpVlIRPBQ5SyLZrjHBNHjdVwdgAb9k78RJQL3r/8TWiwzKgKMPZMuacrgGEOqGHbxjWv8OKs2rHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6263
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

On Thu, Jul 23, 2026 at 07:31:10PM -0300, Tales A. Mendonça wrote:
> > What about the H2G CT?
> 
> Hi Matt,
> 
> Thanks for the series and for the H2G question — I extended my
> instrumentation to sample the H2G CTB descriptor as well, and I now
> have results from two ARL machines running your series 170939.
> 
> Setup:
> - Machine A: ARL-H (PCI 7d51, Core Ultra 5 225H)
> - Machine B: ARL-P (PCI 7dd1, Core Ultra 7 255H)
> - Both: GuC firmware 70.53.0, kernel 7.1.3 with your two patches
> backported, plus debug-only instrumentation that samples both CTB
> descriptors and the GT C-state at TDR time and logs late acks. My
> earlier G2H-flush patch (3/4 of my series) is NOT applied, so your CPU
> flush WA is the only recovery path in place, with the stock
> invalidation timeout.
> 
> Results, 7 timeout events so far (6 on machine A, 1 on machine B),
> identical signature on every single one:
> 
>   TLB invalidation timeout gtidle: seqno=89335, gt_c_state request=C0
>     timeout=C6, c6_residency request-to-timeout=2278ms, waited=2279ms
>   TLB invalidation timeout g2h: seqno=89335, ctb pending=0 dw,
>     head=23932, tail=23932, outstanding=1
>   TLB invalidation timeout h2g: seqno=89335, ctb pending=0 dw,
>     head=792, tail=792
>   TLB invalidation late ack: seqno=89335 recv=89335,
>     request-to-ack=2325ms, timeout-to-ack=45ms
> 
> To answer your question directly: the H2G CTB is fully drained at TDR
> time — head == tail as read from the shared descriptor, i.e. the GuC's
> own view of its consumption progress. So the invalidation request is
> not sitting unconsumed in the H2G ring. Combined with the empty G2H
> ring (with one outstanding G2H credit) this means the GuC consumed the
> request but did not send the ack until 2-45ms after the TDR fired,
> roughly 2.3s after the request was posted.
> 
> Also worth noting: your "CPU flush WA resolved %u pending TLB inval
> fence(s)" warning has not fired once across many hours on either
> machine, while 7 timeouts went through the recovery path. So at least
> on ARL the LNL flush WA does not appear to be the mechanism — there is
> no G2H sitting unprocessed on the host side; the ack genuinely arrives
> late from the firmware.
> 
> Everything points at a GuC 70.53.0 stall: request consumed, ack

Yes, this looks like something is going on in the GuC.

> delayed by seconds, firmware "wakes up" right around the TDR. If it
> would help I can file a gitlab issue with the full logs from both
> machines, and I am happy to keep collecting events (the two machines
> produce a steady trickle).

I'd file a gitlab.

> 
> I would also like to give xe_devcoredump_gt() a try as a separate
> series, as you suggested, if no one else is already on it.
> 

If you could wire up `xe_devcoredump_gt` and attach the devcoredump so
we can inspect the GuC log, it would probably be worth us taking a quick
look.
 
We do support ARL on i915, and the firmware is the same. In general, the
GuC firmware operates similarly across most platforms, so it's quite
possible that whatever is happening here could also be an issue on other
platforms.

Matt

> Thanks,
> Tales
