Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB43FC5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 17:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D502E10E0C1;
	Fri,  7 Aug 2026 17:46:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="l6fDY2t6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A1E588EA1;
 Fri,  7 Aug 2026 17:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786124793; x=1817660793;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=aGTpkRRBW/iMjXEYLeoa/4ed+G0fUr0bVaL3LMqKV+s=;
 b=l6fDY2t63PssI3Elg56Z2apYjXuaCZGHEJx4cME8M8F3C/6EI6ixPdxQ
 38OcNQKZ6t2C7eqH0djEc7wRE7plwspMtXuB7abn+O1wDtxK1hyibS2/W
 O30nV3qhUgXSasAluny1xr9divka9ia2O3XS2bwIb0CMOP8UM/DP0sSAa
 lY/tt7r5TGq4o9RyyVTP5qWba8hmT/JMO6mGa7IOGXfImn7nemOppidkI
 r7+4C+5ViIAJQwi5l5GMxcxNQkFmycem9yA2joHhNbcQq7vtsnFEmKe6N
 w9ac/bHc7ekyyyi6RYnxMXMEWEwh5Sk9jMBtI+w0OmLLpZETvfw9dcvcz w==;
X-CSE-ConnectionGUID: VcNKMi/3QPK3t0GL/lOE4A==
X-CSE-MsgGUID: M7lLMaRgTQm+OLIwx/9tdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="97337012"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="97337012"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 10:46:33 -0700
X-CSE-ConnectionGUID: LzPazDiDQ+S+DtxWTYqKKA==
X-CSE-MsgGUID: YAMiTU+oTQCVvvBEBNL5nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="258603180"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 10:46:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 10:46:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 10:46:32 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 10:46:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxHEQn6aTFXvVPHLmTn3yCh1AHfPRcF6E3eNNFeUzkWI6T4Y5JORWPmyKOQaPgG0Nyc3du1jF4FkxrApCWp82zMkTq+NwSzvK7s6nn//LvNb0VNCtjGmrAyXp4Hegqu7z+dDTXJuLd+lz5WfH+39hfQHQPBqQ7GRnfFRXJ2uteYnRxigwPfkxNC7fPI/AZfMEoegxWrx339orlVI8LTgaDSLC61ZJyLhi72HTYM71Dc36XKGnPHBWD6DjHKLxJF4h/qPrva5lYS5WBpvmI5LAT9nlud9f1RE/Cepeb7xpasX2J8effkZpc6tDl6akylfl1+o4o0zISK+Lkhj57yoiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74Xgeqmrx7y/SGZqLTk8u0BtURe/gXy3s8Br0rsn0ic=;
 b=R7kLVm/0UoSLc0y6for3gb7/iMz+Pe+sUlLoTUewMp1CqqIXPqbIHCLr4BnUK9vb5SGV+WY/f8CkTzfkrXvAcJqtvVn2fmRybHWpZxVM+h+ILjZbUrZ6E0I5WaiHi3NvuYau8XGzbQhQO4YpjnBrr8GwSNIR2PEy06F3TlneXrl1zbXL9jOQPzkWSiZtIw2dcBYcJ3ZJb1S52f57ZN46EgsNZgX7Cn1LS3GIQzLMFIndfDhNnD3qrwx5wY6MMsvf5cvDKnVWoMji0ypR/Q32St4z6cWioj3ZkcW+vxqkcZbNuFtUOclr/MiY/agLEqRp3RHwu5zJFufD4IWMZOaWyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA3PR11MB9160.namprd11.prod.outlook.com (2603:10b6:208:57a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 17:46:29 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 17:46:29 +0000
Date: Fri, 7 Aug 2026 10:46:26 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Maarten Lankhorst <dev@lankhorst.se>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, <intel-xe@lists.freedesktop.org>, dri-devel
 <dri-devel@lists.freedesktop.org>
Subject: Re: drm: xe: Kernel-submitted job timed out
Message-ID: <anYZ8nUFP5dnRy/h@gsse-cloud1.jf.intel.com>
References: <CAHk-=whiv=b+dAvjaZDsZkfUEzjZMSSLExDOWVcbJ0exsCj6_Q@mail.gmail.com>
 <6874536d-ab1a-4dd7-a23f-2a071bda145e@lankhorst.se>
 <CAHk-=wj5aE1yVMb8RM2AuNUHSMnQDaGT+Vy+At5ds1vxBA+Kng@mail.gmail.com>
 <ahDAErDSE-SFA0oM@intel.com>
 <CAHk-=whX59mtUnU2ayMWoDQX6Ee2NXLK2NxQ+dZnb-Qc_mF1hw@mail.gmail.com>
 <af9278d3-4002-4e09-9bcf-bc75d1cf8145@lankhorst.se>
 <CAADWXX-pfvA3mKWSjdahnihAXHQB2VP9BOJDCXonG3Q_nxurLg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADWXX-pfvA3mKWSjdahnihAXHQB2VP9BOJDCXonG3Q_nxurLg@mail.gmail.com>
X-ClientProxiedBy: SJ0P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::7) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA3PR11MB9160:EE_
X-MS-Office365-Filtering-Correlation-Id: aa9f5fb8-5b7a-4cf2-d579-08def4abcf4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|4143699003|3023799007|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: e112hvjkTYJwjz2Q9mI74qYpGT5sO0tsD9HAB38b0ZM3zt4XOf9G0iH0ekeTBaWMXfh8/EckTKmikJnN1P1MqnrNDGZY3r7RFLU49SYwFPi4dyD2TwnA64jNVlG6bQlseWYTWAC0hQHZAxRnvRq7cCxtxqXdVj0tsWvRxkt0EuVDZ1gZP7LUwER/CJ0w/4LHGl+236rcLCuDZ4X0kwzsnBI+8fyUCo3aTnB3DoUrhAUwg3RgLna3lDrBopZzOwiIMW7zw+GR3tn+DoddbnecbjN0efP6zAt1tYRoiOU3J2cQVD88qdci0bPzAdCNcyiyZGvvpt+dNmG3mPcU5gjLVG3y9dUMKzY7QHK8yJZl6d9FA7yUak9M/mhFKaVUACmYWpzfXKneFKcev1W+95qxskyQLqouunWN+GM5WQwnuJfYAlppfRplDKAJX44U/+cX0tZ0TSfouFUne0OFVkRd0PkGTFWmQEF5gHJf1scRcNxTb4/Ev7Jf2LWVHhQBYPu7Tp/iVsPxO8HduHsIH5Y272YXXDy7RDm//eaSIhLS8HYP2ult5UZTXKQW9QD0nmrz7XTi2RI2k1+fYvYwMZ7TxnTwU5W8OJKHkaDFvWSAnKshORbnCo8bsa9yq6mUMwx8L6MzLZUNV4KRT6YcF1aCIPQhhA9LQ5n6kUkmdeS4Glc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(3023799007)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2lLMmVxY1kvc0szUENkQVcwdzM4eGR5WVk0TXY5a2cxOU5Cb1BLYlpML24r?=
 =?utf-8?B?R091OXNSSHI4K1ZRWG1CeWV1WDJERW1FRi9SeVA5OTZJd2I3SzMzTGd0VlAv?=
 =?utf-8?B?NHk3TnVBMXhWWjFpN2s5aWR2WDVWS2hKVTN2UXVYTmJ5ZWJTK3EvZStPUVdN?=
 =?utf-8?B?ZDNOYmMwRGxkN0hXT1Vvc3FJUk5PYWIrU2VQTDE0NHpldmtJaTBoOXJEYVpo?=
 =?utf-8?B?UGg4ZGRMTWNJK29MNE9DUXJrbVZRcFB4VnpaTWJZWG4zSHFMS1RLUXlUSlpr?=
 =?utf-8?B?aHVYZTdOUW9oVDVSOWg3THRvcVVjMlduclF2VkgyVGIzT21GRUJnK0hNV0Q3?=
 =?utf-8?B?ZXNQMzJBblp3SXlyN1V5YTFvQkhaV25IMTRaQVU2aWVOTUMzdWROSklyZWlB?=
 =?utf-8?B?YmZVbHlVVVRHM0JwZFdWeUZkU0VlTGloOFRuSlBDTHNLdXNqODZ5S3N2U0hG?=
 =?utf-8?B?MnFCOFNid095NHRRck5zdWFGcHM3NVdZbC84MDZJQUVIelB4cXBKZy9CTmFU?=
 =?utf-8?B?VlRsa0swSTQyN2xHcVBSVUtRVTlSLzdvZE1vQzZXRW9PMjA1QUVTcU9ETWJJ?=
 =?utf-8?B?UzVqTlc3dmp0dVlVd3BPK05Jdlg3WE9jZmFMZm9mKzB1OXJpQWl5SW5rMGlx?=
 =?utf-8?B?WHAyK3FPYlZNVldtKy8wQ3Q2OUd1U3p3VDh1TXZMTmg3OU5ENFFvVXJ2a1NW?=
 =?utf-8?B?L2VwSDFjR0Y5dnJYL0FUbHlXV0hESDJ2L1l2K3A5cXJ1T012NXRmVjJzMmJB?=
 =?utf-8?B?WXl0MFNHZmJPT2dHZ2tmRkMwZ2NXdHd2WFNvUzd0bGlDRW1hek0vQUN3enRC?=
 =?utf-8?B?cVRoWVN4RnF2bS9tcHVJbWFQWjl1RlJwcGFBL2ExaDlrU1RKdzhZeXFMbTRr?=
 =?utf-8?B?SDI0MVdsMWQyU0VPWENiYjM2Z2VTd0xDKzhvV1VTdTBiYkxuL21BZ21sTGtQ?=
 =?utf-8?B?R0d0ZVR2U05DbGY4ZFZjVUxzOW83ZFQ4VUROR2YyTTd6UjdxQURhcklCeGhp?=
 =?utf-8?B?N2d3b05lVHNWQUhWaDJTejg3N3ZrSnFPOHJ6L1BMMVFnVFdvY3FUc3F0b2JJ?=
 =?utf-8?B?cElsZ2lFa29KVUxtZ25YRjRNeXFoQTA4V3p1dktocE1DL283OUtCejdRS0s2?=
 =?utf-8?B?bWt5aHFJOUxOTlVLRXFWWU1xWDFYQ3BNZDB5YVVidVkvSkpLNTNIMVZLWWhj?=
 =?utf-8?B?ZC9PbStWVVZ4MVBnYll1WW9IamdDSjZvckVqaGZlSVVHajN6aFNHUEJ6SGZu?=
 =?utf-8?B?OWJNSXk1MmFPOEhWcUpsdHVwZzlEdXcraU5EWnAyaDhXc2hvSFJUSHBlNTVJ?=
 =?utf-8?B?QzAyLzBCWDUvNURzckZpQmNtUFA5NVc3dHNsUXNGL2RvbjJrMVBGK2svMk4y?=
 =?utf-8?B?ckhMa1NKU1dJSGJwbktKdVR0TVhUK01pTURIVTZscXdzMkE2VjlRUXpTZkEr?=
 =?utf-8?B?SXlmdWJZeXZ2Rnlxek5Qb1d5VmNkK28yMy9EZi9XWmJDbmJHa1ZwYVQyVkhJ?=
 =?utf-8?B?VDJ4MUtGbnI4TGhVcE5NOG1NTzJ1RVRIOG9ZYXczU0JjSHZvVFdSdzlpZ0NK?=
 =?utf-8?B?bU40RDdreDVOYkV0RFBiV3R3NVVTZ1Z6NTNZVzJSWWNwNHhGaGlqeUVTenQr?=
 =?utf-8?B?eTU1cytwRkx0dFd2TmZORXlvSVhiZEphVnh6U0NJU0VtelRIQXBWRTh5SC9o?=
 =?utf-8?B?Y3o0RW5jbGFadHZ0WHdqaG9MN2ErYWFLeFJ1UDVKa3BoYUhFaU1tTDJEbWly?=
 =?utf-8?B?akROR0VzVlV3QnpROWsydDViTHRObjhlVGwrZHhSSXFHYmdBR2p4N1B0RDcr?=
 =?utf-8?B?blRkblNUNFpieEpMbWczMVNlSmh4QXU0aVlMaFgyMFh0Wi8yMG9DbStRZDFQ?=
 =?utf-8?B?WVljTy9LZDNMYlpSMUVuZTFkSjZyL2tzdWZXRUd4MHJ1UFdLRDg3azlUUkgw?=
 =?utf-8?B?OWxPVmliZ29kSzBUeUZweEJLbitDNW9IYStUbWlubWNpOER5REc5a0QvS3JM?=
 =?utf-8?B?VzJNR2VOZFVOcWhqMFlNZEdmV0s5QU9UVTNJK1UxdWtDejhjNEhOdlZoNVJJ?=
 =?utf-8?B?eVEvamtkLy93SitxL28zRDJsSHRNTm1nbUJxZjNlUnlyZUdpRGx2c29HQ3Ay?=
 =?utf-8?B?NGlOcU43SFJDbWs1RjlUTDd5bG5ZRnE2eVNBRVloK2xMUkllRXRSdWU1QVBE?=
 =?utf-8?B?QjZ5QWhEcmZiaVB0YWVEYlp1djhubEdRZ0JYbnU4VzJXUDIwUjVzVnpXMnVF?=
 =?utf-8?B?ODhzQnRxYmhRbFJpMXY1QkFmNEdkUHRyc1QyaFJKamxKTFdlWnltTjA3aWRG?=
 =?utf-8?B?b2FJR0NWaUgzZjBjUGdSeC9TbWQ3NGlZVi9nV1hRVnBlTmVGWXVxUT09?=
X-Exchange-RoutingPolicyChecked: RwUic//NNGft5iWe7XeMf+CsvEDhVj1WCe4AwHTSu6GQEBsSffnX6k9f2o7t9NWWm+r8X7H8E4IvDa3QKbVDMRAeOSse8sEcQRxTy6FC3UnMJPCEtohu8RQQhVXMBPPeN52ibxHmTpA3X3IaZAv3A06qHFIh0N8duQOtZhdaKpEihuvXvbVlZTVc4+7dp7ed1OUJlmNNapVO25E3poctzf0bREz3nJ8AQTbHKLldg2CXdl1C9weTlPeBny3UIu0TNMq7G7BKAF8uOvTt/0XqMFFAoXfR0Bi4ETFJHUHQ8g497s+MRaQedWPgFNE/cxU4bMuVn2UQ3AkqBzCm5P8gPg==
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9f5fb8-5b7a-4cf2-d579-08def4abcf4c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 17:46:29.0299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gtwE9khFazGNw2egnnglLWq4wR0ZvUrAI2BYVci6z7yNt/+r9MBLD+U5yRE/NKbyBMwK3eyQud1qHtD75NaJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9160
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

On Sat, May 23, 2026 at 07:48:49AM -0700, Linus Torvalds wrote:
> On Sat, May 23, 2026 at 1:29 AM Maarten Lankhorst <dev@lankhorst.se> wrote:
> >
> > Does it happen more frequently when loading VRAM intensive programs?
> 
> Well, "more frequently" is hard to say since it's happened twice, but
> this time it certainly happened when launching a new program.
> 
> This time it was a markdown viewer.
> 
> I wouldn't expect that to be particularly VRAM-intensive, but hey,
> since I run with two 6k monitors, I suspect *anything* with big
> windows will chew up a few hundred megs of VRAM just for the frame
> buffer side.
> 
> It's a B50 Pro, so it's a discrete card with 16GB on card.
> 
> I have no memory of what it might have been back a few months ago. But
> I would expect it to be all the usual stuff - ten terminals, a web
> browser with a dozen tabs, and whatever gnome and wayland do, and then
> the occasional random other thing.
> 
>              Linus

I think we may have found one. I haven't been able to reproduce any
kernel job timeouts on drm-tip with this patch applied [1].

If you're still seeing the issue on your end, it's probably worth
pulling it in.

Hopefully this fix will make it into your tree soon enough too.

Matt

[1] https://patchwork.freedesktop.org/series/171805/
