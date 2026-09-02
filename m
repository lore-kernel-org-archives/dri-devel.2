Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E04BC61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBD7D10F04A;
	Wed,  2 Sep 2026 08:08:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="b+nfiAPs";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC71E10F04A;
 Wed,  2 Sep 2026 08:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788336517; x=1819872517;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=tfkaCFYOx2x4hh5/MdjKUDNak7UZO4m1mi673lRIhis=;
 b=b+nfiAPsBdEfJ0vHc3i0/dTSqrs3wBJg5CTWgHmZ/ANX02TS0ddhJdGs
 G2l50FiQHLhJSzpXRAF3pw4q1jV+6LB2+XfILq8/ZkIzdAKR7/FvFfTnB
 Gv2m0XcH0Q38REK/Gm6jPIqSvP1JGYA4E0nIp/r30092uJt3FATdRxTi8
 N8GuSlQYouZmBVpi3pjgeM9gv1mJi0nVoqVZFB0rPklNVFOa0XEWdmk5g
 JVOtMLhSxaG4AEH5WJtIBX3tCFqtliYtP/PFbyEXQcelCNSAO1r5Nsbjt
 xbCgYc4FtHfyT3u2nfD4gXo/EBzZiQ6pEaLBDU7PuEf38E24CCUZK//we w==;
X-CSE-ConnectionGUID: 4MijxKWkSvycjUR2m+r0uA==
X-CSE-MsgGUID: Jwds9QB4QEOyW31T/Xah1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="114329350"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="114329350"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 01:08:36 -0700
X-CSE-ConnectionGUID: rnd4N/G+T/q9572YWakKHA==
X-CSE-MsgGUID: kZqaFZTxQaGDZg2diJwetg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="268035277"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 01:08:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:08:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 01:08:35 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.60) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:08:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oeo2cOGiqahSzlsRtK1xCnI6s7n6A2dZ4nvn+K6vmmR5e58fHHufPTr0RZCanvZOY8TdGIrV/p7pGS0ebP9SRbQraaGlFgTr0zrH6s3n2PWaOZVT41muT3xnQY2b3NjaRHPV9qtDVl8M35gcCBS9YWdorF99X/SsYuB/8R5V+Ffp87of4E0tDXcMOMrGqammvtLA3kwOIH5dRH/hV2p4xED0l1b3sLcEhj4XcEyc/vfykPRySH1f8bY7Wdwm/WbvvjsnV2xbnZgHESki7TGnM7WhdkFV8hmH1Dgc4jFJgEhuBxO+rFuFk8G3SyF69dCnMieFvw8huwYd6bCPDTVsxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVPCUwhK5hYjfPnHBNPjzUqxH3SNTvRnavZJ0hAqz70=;
 b=xsFf699tOQm4jf4EHNLvJq4N6ioSLNJSLjSj+8s0vYJPROgNXmRNJdf1mHsvIF3/FUhpd87ECPLG9HCYE92z3WYmxkzSK05fMSfpb7YHpfdvq8ChwDR8XX7eYobvUd0ci7/20z67chOWdPRs6BuYJg7rjknjbcNNQSXaX3qiViOkiGrFVMK2LLPA5Vp/nCXYLeqSyJoshf5F8Sasf+tEKqxPVCdKO3pDbwYaInaYX4HLTBrUEQ6FzI7eQmWluOojfx3/ydHPsbUU1zRiPjCGNtt9QP5O/7c7NdjBk/vxFU4e0GcCjOPx4R9zsPUfNGuzw/ENlFkdfhLIXvaulU2sYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DM3PPF1FCD3EAF0.namprd11.prod.outlook.com (2603:10b6:f:fc00::f12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:08:18 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 08:08:18 +0000
Date: Wed, 2 Sep 2026 01:08:16 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Nathan Bourgeois <iridescentrosesfall@gmail.com>, Dave Airlie
 <airlied@gmail.com>
CC: Dave Airlie <airlied@gmail.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Rodrigo
 Vivi" <rodrigo.vivi@intel.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Matthew Auld <matthew.auld@intel.com>, "Simona
 Vetter" <simona@ffwll.ch>
Subject: Re: [PATCH] drm/xe: Fix unnecessary host-side population of ttm_tt
 on non-TT resources
Message-ID: <apfZcEF8IlDak/As@gsse-cloud1.jf.intel.com>
References: <20260820031901.1018324-1-iridescentrosesfall@gmail.com>
 <aoczaCuoaZfUkfm5@gsse-cloud1.jf.intel.com>
 <CAMpTW2cxRrG4oJ0HrRoKhHrVHxWO01-L+QDoWMLCAUaSfw75sA@mail.gmail.com>
 <CAMpTW2fxFRrpn1b5WGYBrtLLMfUo_fmx9s2D0b552GJp-sF5qg@mail.gmail.com>
 <8b7001c68c94491095f41d2a3dff45090c0a95cf.camel@linux.intel.com>
 <aoeUdfrPX+0ZnZMr@gsse-cloud1.jf.intel.com>
 <CAPM=9twBded3B553KYzwDtVd0NbhbAwbiVDGw_bdrmBnOKgtKA@mail.gmail.com>
 <CAMpTW2eXS9tBzppJvvfZ-FiwoJ5MKOAdB9sqYgCDPVQ_+___ZA@mail.gmail.com>
 <ao+acQG/wyZYNYfW@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ao+acQG/wyZYNYfW@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: SJ0PR13CA0045.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::20) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DM3PPF1FCD3EAF0:EE_
X-MS-Office365-Filtering-Correlation-Id: 67098c33-f3c0-4131-1fbe-08df08c958f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|6133799003|56012099006|4143699003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: Hwls0FAXkiQ82FsfdMgnZm35x9homPpizpJBjs1Eu+eO/VgzzbWVVx4uT4f81/qbRpaZ7aZywIhzfQphXjP+fF+apHJEhBARTSl5YUmB4BdV9PcXDGnC7UOPhswP94Odc0g1y2PeaSBDin51o58HuP1Knvod3iUehQpkxE8UyHptqQMLnP48l1v6j5IoULxF9gyrtfwpjL3m/rVXBn1xlR2WoK12OZ2IHSXhM870NqFhQ2BIfRS6Xo+CWWhx3Eg9fSPnos2By5eRLLFlzvl93ch7H3GZ8bQo5vKdFQDd9gl7abHRCa6S/eEM/fR96F3ZjONWAP/rZ8j3HH4K9r1QBN3D8mXxtBgxqq9mMbMXXQ+CichNC3GKL8YcdSFQGRF0Xc5beHx+//JEE1l6nvaA2ZVMO74fb3OOFyD5NEfK1YCeXtJaXU1xhnwDLl3F9RUFonLZNXGO+HOuVTtkI4B4kB0aE/t78Lq3TB51NN58zK/Wej/khke94XhSTQ1dSzWzza2C4dg+B0d6tu4DBQ6/c05/phE/QvW4SkeXFyPohifokeCCySmjgakYllCkXCVcKckSdcuidf3bAAy4P4c9GoYVssXCUH8Ib09NMBFzA1xu/cLJRa+WyIiLJAie832f
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(6133799003)(56012099006)(4143699003)(22082099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlJTV0xNTDFyeTZsNTJ6M0FxblRFNGNFVmo5Zm92R0ExVHlZbGJ6MG5nMmZi?=
 =?utf-8?B?eXhpME9nU0VaS1k1YmlNcWpiRmI5Ry9DMXJLWW83WUl3R05YVnZIQVpyRjYy?=
 =?utf-8?B?RGZsRG9PdDR4NVA2a054dHJLdDJNV0xKTkx1SkowYVkvL2tTSVQzblVLYWU5?=
 =?utf-8?B?MStwUmZXazM0Z1h1U1V3MzRYbTJrQzFaRVUrUWFWNGtKaXlEMkFtWkFyckN2?=
 =?utf-8?B?bUlKTVo1Vm9ZYlZMc2FINHlxTkVvYkpwTWorSFdDbmxNdUFreVV3Q3JPNGxw?=
 =?utf-8?B?ZGRaR0UyVnZnVlFxeE5DWWNLY1VxQXA1YmFZZW1Qck01WFRBYnA1RDluWkNV?=
 =?utf-8?B?WVp1bmxIVGh0RUl2bGZIdUlIQVRzRkc1a3lDZ2lwSy9Qb2E1U2pIOU5ZL3NL?=
 =?utf-8?B?dGVFUGYvejZock9MZ3c2eEZReFJrV1V3b1RjWGlrVHlzVitBUFNuRzZBdmdB?=
 =?utf-8?B?YWJ5dk8zZ0d0NFl1VTNNZzhtcXJuaEZNdi9LSm1PSjlNVSt3MnR5VkE5MVlh?=
 =?utf-8?B?OGdLVVh0SGVLNDlxMU02Umg4blJUeXY4WTFaWnREZWEwWVNFbWlmV2ZUaXJ3?=
 =?utf-8?B?eHdya3k2cHhkS1gzYzZadzA5bldYWk92dENtclBjS3hsVXhTTjBRaTh4dGJC?=
 =?utf-8?B?cm5WVXM1QTF0N0ptbWtFOHRJcUJoRWlDWk9mN0t2eTJPZTdBaXl2MlMyYnFW?=
 =?utf-8?B?ZmRaQkQwb3dHYlg4UEwrTWhpUGJQcGx3TUFLQTRncStqUVJkNGRzVGxtZld2?=
 =?utf-8?B?aWNzb3dmWkI1ZmVuVHl1TmRwV2crVkxrQ2hZMWN6QkphdUlBcUs5bThWbWNU?=
 =?utf-8?B?U0NOUE1WMkxKOXFGS0wvcmh6OUw3cnhPWlBkeHV2c0dDN3BQSzcrUDFxSFM5?=
 =?utf-8?B?VFpKUXIxWlcvNjhKNWdwQ3A1MHMzOVFQWGhMdWdpQVFlMkZqdmdxYnhHZHFo?=
 =?utf-8?B?NTYxaVF5T3RjZFJCMlhYOHczalNrMDFJeDFXcmQrZHd3cmpBWDl2MVlsVklL?=
 =?utf-8?B?NjV2bFUzQklLbjZQbElmMUdOaEJGd1Z1cm8rblVnT2hrQXFNV2VpaG5xUVBj?=
 =?utf-8?B?YUh6Wk9sZXlBeEtidHFmdEh5Q1pUWGZEbGEyYyt3cHg0WHBMTDk1UU04UXhn?=
 =?utf-8?B?NVl5SDRJenZlMUI4M2JvVk1LdzU5N0F0cTA5ZzcxOUc0OHRwWFF1V05lTVhG?=
 =?utf-8?B?Y3lZR0FSdVZQVjRkTEx3K2VFTGtXZTF4MythcXB3NGxTandScER0Tkt4Wkc4?=
 =?utf-8?B?c09ORk9tQ1VLV282MFZBRklRWkNiODhoOVJXVEtsOVRYSnRERWkrZUZaR2Fv?=
 =?utf-8?B?WDBQcHU1VzY0V3ROeWhLd2JMR3VUMDgrK21FYUxNa2NKWXcxMHVpWXVxdXAz?=
 =?utf-8?B?TittTUJTMzZBMDZjYjJnUkNSWHRjR1hhd1JpQTFSWXZMNGNmRW5sVlpjRjZ1?=
 =?utf-8?B?bGpndURJWVhSNmVKR2ZVSlMxMFlYaGYwRDRPbmpiRm5naHJzdEhxVlVhMlFN?=
 =?utf-8?B?eTRuMnpodWJzMjZlREt2WnVxdE50d1RzQzZMd2huN3dXSTBSK2hZM2VvN2Ux?=
 =?utf-8?B?aXpNUmdoWkFLYVJab1BOdHhhVkFmcTY4cjZ6WEJ6cmtjcitUNTNMRW1zYXRw?=
 =?utf-8?B?STc4NU05cmhySklnS3o5MVMwK3hKSDVXbS9PazRLM1o1VTViSzhTRnlXK29n?=
 =?utf-8?B?Zk1udVloQkJoc1h3UVh2eDZvOC9EeXcyTUdNR2Q5NGxTL1VjS2k1c1lnUyt3?=
 =?utf-8?B?TmwxSHQydXBCYjRLMXFwNEpib3cwWGttMC9ibjhCRVh0cGx4SkMxczY4aUpi?=
 =?utf-8?B?NmhTVGxTS2RUeElOYnFOeWZkMGpJcGQ4a002Ryt2alZZdmdqdnhlS1pvaTZD?=
 =?utf-8?B?NHJvM0pMZnF0TmVzOTdNaHV6TWZYaDN5VzV6Q2RTTGcyMUNjdmZnL0ZSMTZx?=
 =?utf-8?B?Y2JPdDEvTzBDTk9GbFNhT1BhbU1mUm9NWGlGUHZza0VoZEFEUUVoaXJuWVQ5?=
 =?utf-8?B?WXVHN2lkSE96eTBycmY3Zm01N1JwdytlU29sWDlCYUpwTTFVZyt1VzlwZWtF?=
 =?utf-8?B?V3dUVU5oTmpXUWZhM203REU3MFI5SlNhOXJRWWpwT0I2RmFoWjZ5UjJmQm9M?=
 =?utf-8?B?SEgyTWVadzdDRXlEVUNyd25nQkJxeVdydHFNaHowanM4MnJCUUt6czQ4anhN?=
 =?utf-8?B?TW1DbC9CSEZVOUJ2TmMvS094Z1ZIUDVBTG92RU02NjdEMXE5Q0FBMG9EdGlQ?=
 =?utf-8?B?RkVYazR4MUIzN3o3RWloN2FxTGpSelQ5Sy9XbVkxQUhaMXlLc2FPU3NTYVdk?=
 =?utf-8?B?bmNlak9ITWEveUNUUjhZWjlnNHF4emlCWEFib1hxM21hOGg0V0pjOVZhWTI3?=
 =?utf-8?Q?5D7+acfqdnJmq8AI=3D?=
X-Exchange-RoutingPolicyChecked: rHdvmtQ1ap0i9W+VCSvl/qVrpAXEk/doo0AggbFLrm1Mk0PutMgKTutbU25UHzJXWS8K406qHB8Wsm7uqmVWeC68zt8Ng7uSh8nWDeML9zRSkmfd9ipbxRWI2tMRe4dkMenIXalFCEX/qGQ5tkcOUOdEoLhTKy+YAQy60+m7t7bKvQpyV02y7BlIsQDVluALkODzEQj2lOguy9RXY4FD65tafzkuFuH3K3O7JwFNG4kl/+w31Zp3gI3d0KXQ1A9EkfPPFAHMvM2APnP9qtayQgTsqdjLZMhF7W2qOpeRPIm9GgipmpCrccfgeJfWwBGqRisDIyImzNtZ90ooJUjDEg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 67098c33-f3c0-4131-1fbe-08df08c958f1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:08:18.5656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKnyx405R4HtTu2gDYoqdWKRp8TX+BBbcxwlGaSmX9a7Ge4z42l57a4D8zoTw7gnpdC6roLS+FRD+csC30covA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1FCD3EAF0
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

On Wed, Aug 26, 2026 at 07:01:21PM -0700, Matthew Brost wrote:

Dave ping. Question below.

> On Thu, Aug 20, 2026 at 10:34:49PM -0400, Nathan Bourgeois wrote:
> > > Shouldn't we just be calling xe_bo_validate() here instead of
> > > ttm_tt_populate? (With the correct xe_validation_guard() wrapping).
> > 
> > > Yes, this might be a better solution, making ttm_bo_setup_export()
> > > completely unnecessary.
> > 
> > If ttm_bo_setup_export() is unnecessary, I'm happy to change the patch
> > or make a new patch. I will attempt to implement and test this locally.
> > 
> > > This part looks good as different patch from what I'm assuming will be a
> > > TTM fix.
> > 
> > Regarding this, what do you recommend I do, assuming the patch
> > remains local to drm/xe? I'm still learning the ropes of contributing.
> > 
> 
> 
> For Xe I believe Thomas and I aligned a xe_bo_validate with a correct
> xe_validation_guard is the Xe preferred solution in the existing
> design... But a question to Dave below before I commit to anything.
> 
> > Nathan
> > 
> > On Thu, Aug 20, 2026 at 9:08 PM Dave Airlie <airlied@gmail.com> wrote:
> > >
> > > > Yes, this might be a better solution, making ttm_bo_setup_export()
> > > > completely unnecessary.
> > > >
> > > > It's also a bit odd that, in flows where we don't have backing storage
> > > > on export, we populate with pages and charge the system memory cgroup,
> > > > only to move the data to VRAM when the import attach is triggered,
> > > > resulting in a copy and a change in cgroup charging.
> > > >
> > > > I guess the question is why was ttm_bo_setup_export() introduced over
> > > > just a validation at export?
> > > >
> > >
> > > I'd like to think I had an answer for that, but I don't. Likely
> > > because I wasn't thinking about VRAM charging at all, and just
> > > worrying about making sure we had populated some pages for system
> > > memory ones, so the other side couldn't DoS us.
> > >
> 
> Dave:
> 
> We don't charge any cgroups yet, right? This would only come into play
> once a version of [1] merges, correct?
> 
> What would prevent the pages populated for a TTM BO from being
> immediately reclaimed and discarded? I'm fairly certain Xe's shrinker
> could do exactly that, since we don't pin those pages. This seems to
> imply that we'd need to store the cgroup associated with the TTM BO at
> creation time and charge allocations to that cgroup, regardless of which
> task ultimately triggers the page allocation.
> 
> Another option, instead of validating, is to revert
> ttm_bo_setup_export() entirely and rethink the overall approach as part
> of [1].
> 
> Matt
> 
> [1] https://patchwork.freedesktop.org/series/169831/
> 
> > > Dave.
