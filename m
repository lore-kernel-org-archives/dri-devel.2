Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D3AFF8864
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 03:12:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55DD310F1F2;
	Thu, 30 Apr 2026 03:12:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ilwN/1E3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D4DF10F1E1;
 Thu, 30 Apr 2026 03:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777518761; x=1809054761;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=e/Z+2QgZ+RRY3JDUqbTE5piHHgvGMrK9NH2kLAUDCsI=;
 b=ilwN/1E3ocf7lsGfqixkpab9TmzflZy1V9u8lR2Kw7WC24JJc20Z1kB8
 EAHw4/ouEgpFBdZX04oF3DT/ng1Uzl1OEDEDtIr7JU+9shMPy1Cjdfm94
 TZgmMiWRRWEcveMZJAvK1/owke8JBmb8nZWdPGBoM4/hNrwJ2/4Mk6ITm
 vVJVOKc5wnXzHgxY+sd4JIN1sRad53S8r3nEB49zpfGE1FDIiVDlNMjYj
 s8J5Pvp6SfzBygQiOv6/8CT3C0PP+dm0jqkBuT2g1MflnotmvqU4tHXAb
 DfFWNU0ps+xNMKEP96S+wIvPlpadq1Zdbb1/VYH+rn+ETn0JVB2GRI5kk g==;
X-CSE-ConnectionGUID: S400rRBNSSGpkmP2kbm3Tw==
X-CSE-MsgGUID: to6orwK0RDG35QXj895TYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78513486"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="78513486"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 20:12:39 -0700
X-CSE-ConnectionGUID: fl8rHdJsRnu2baNxROAIJQ==
X-CSE-MsgGUID: koCDFQDRQxO5PNMQEH07HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="231311742"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 20:12:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 20:12:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 20:12:38 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.9) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 20:12:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVTPwN9vj6sOA27l8yRzf/4HGNOODxxZI9NEgZhJ6xn9MzLDtrIebsuCFszGT8wqH9wZ3GqQDg7erUkHBIF0cQVif+IrKdtDWvShyDDqa0/Kept+Jml+iDxX9ncQ3yzvY9I2bXWEjr+pFz+yTZIra+tgqJ+SN8ZzcJS4Vd2kyI8rYF6iPo2fNw4QCCQ7vNYn89R/uIpHiOM4WGE9s2RTar2weSYtONPV85MarMkCM+c0FOBzohuszANlswsVAiPGFrbtJxWrjY0AWla4exTNrexCV3NhKv95JMlOcpnFgELXgKzQyTG8Hk49jsfSAqQNi7VAyEXlffTBMMRq1L6pDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tF3ZOeeb9uXMahbuUshgfCo2IRa++FSSYi0YNO12MSc=;
 b=I90Lj9ut6oaMYegvfqDmgDA5WGTjMdems83XfZE77Utt6nkncz+VGD3CFUHo/2/kOMC3Fa+jZ8h+LyPCzSUBbXxBbLOvJn0nsyoAkc6uitSBmxSTlxAHM8iUoaDs20GtYGR/u6tPp8bRqYKENuF0vDRgip4+ATcl2nlF7PzOeddPmulVMjBox9XQvvDgHzUQmCLJy1IM8IwL/Gw6Kc/KbtRUaR/0U2tO0whQYYHqN5L7u0DKi1b55WMZA26pqcF35qD3HykvqErbN1PhSS177NjKNgBn1ybNfLC5fDtkhrnzvrF08+8eBMvOKw/LneLQttbtVaweycB3FRqohjK0NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CH3PR11MB8413.namprd11.prod.outlook.com (2603:10b6:610:170::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Thu, 30 Apr
 2026 03:12:35 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 03:12:34 +0000
Date: Wed, 29 Apr 2026 20:12:31 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: "Huang, Honglei1" <honghuan@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Zeng, Oak" <Oak.Zeng@amd.com>, "Liu, Jenny (Jing)" <Jenny-Jing.Liu@amd.com>, 
 "Yang, Philip" <Philip.Yang@amd.com>, "Chen, Xiaogang"
 <Xiaogang.Chen@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Zhu, Lingshan"
 <Lingshan.Zhu@amd.com>, "Shen, Junhua" <Junhua.Shen@amd.com>,
 <yiru.ma@amd.com>, "sima@ffwll.ch" <sima@ffwll.ch>, "rodrigo.vivi@intel.com"
 <rodrigo.vivi@intel.com>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>, "dakr@kernel.org" <dakr@kernel.org>,
 "aliceryhl@google.com" <aliceryhl@google.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [RFC/POC PATCH 00/12] POC SVM implementation in AMDGPU based on
 drm_gpusvm
Message-ID: <afLInxpNTkA2yOZn@gsse-cloud1.jf.intel.com>
References: <e21e8e1a-4d2e-40e9-bbb7-2764cf33e760@amd.com>
 <ae5fe946-4756-43b4-848f-3b545ac61ba7@amd.com>
 <abuE0KBPtAZM9Bo0@lstrano-desk.jf.intel.com>
 <098d5d68-f218-4cee-8b73-201e7012a287@amd.com>
 <acDeRhCTh/ehOUyu@lstrano-desk.jf.intel.com>
 <a9d979e7-6ff1-47c5-87c5-b905e5c84ded@amd.com>
 <aenBy61U66DkSZUl@gsse-cloud1.jf.intel.com>
 <7a1ba278-1201-4585-b35b-3fb2cec6035f@amd.com>
 <5e44f013-a1c1-4621-9eea-e4f2459f223e@amd.com>
 <02ded343-38bd-4621-83fd-78a027eb96e2@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02ded343-38bd-4621-83fd-78a027eb96e2@amd.com>
X-ClientProxiedBy: MW4PR04CA0146.namprd04.prod.outlook.com
 (2603:10b6:303:84::31) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CH3PR11MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: ec3ad476-5e8d-4867-a499-08dea6665350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uo8QRL8t8SprSL1dsSD+CbgVyrmZJnALP664hbsabZnliRmfFRhrzicVfT4NAcDK/fZbfuXT3eRIt9r6DvswGJ5ZAjldOZAVYANYCEj/m6QqWIdC1cAqnUHjcimNEy/3piDShZaxk5nsj2RA0BsdrkxAjqf32Tv5W1lnGVVkqAhZbdRKI30FHYw2Wpp6JekK0w6sD4oh2n35uK96qLcfyopX3vp20rG3aZL2hdziEeRDP7joArJq3qyTrBsayO5AdtI0Nr2ACucZY70up9k+HRDHUxMyJy205EyPEIkzkmS1mHcGV3H2UdRL1cWVec25FWQhVDCSSDB/S7Ew6FM4QdVVSlG02jS35feabWVPe3befwUqQ6pHGm6l4Gscc2fWzuyvOR2QOZo9VvY6Vq9Gg1N/0DKOGOxj7+jWWnMxW0DmVIsyt8ThoHYtcxA17YnCATcpOx/FWwOwNREDnhSg0N3XSdSPx6kG0AVttd37acV+VwMQA8U4C2KvNmyW+RGwu2oYIXn3BURifzqRkhZ1wz+Eq9HPweuhitDa4WPdkAFmdvw55MazoIRHHSEShrc+upwM9BCP9NXYnNU+QS+YRauffSPUFchJdY4tTh7vGOUzNfbDyK8Gd1VzvqP6q7TOLrch+f8uTjV1O9lWrOOTEcfMTJLEkru48xZ0wULT5Ry09hsISTPuU64lMnqysId8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWpucGgvSmNhdFNaK2JJMTdZdkRubzB0cmdkLzdOdlhLaGZueUh6NmdueWFm?=
 =?utf-8?B?eHVscEtNdEdYT2UydmltaUVCVmF6OFlhQkdSbnlTU3NGd3hIbFVBSXFhVGFY?=
 =?utf-8?B?eHFsUlJFSFlBMUR5ek1YandhNU1BdTMrUzZlYXkxOVBUTnNjQjJZcEs4cUJh?=
 =?utf-8?B?T2dVQmJGNTY3RTlIQ3h5L1ZMKzZ2bGZWY2F4NjVBSmlBb3M3dTJBYTcwMUtn?=
 =?utf-8?B?aHlFdHN3eWc1UW5jSnVpWHpqUjgvSUIrTFQrTlpqVU1VYmxXTVdaTGFXQTZL?=
 =?utf-8?B?Vm5sMWZZM0NZTmltSjQzSlB3cUVmNVl5dStYU2tWZS9OOUJhcmp4UlpVM3ND?=
 =?utf-8?B?eGxlU0lMMzlqU3dYRVFpK3NBWVlRVDhZRm1pY09ldU1SUWxHbGMrV0VubW5K?=
 =?utf-8?B?WkIyQnFpZ3pQYWdHUjNCdFVsWFlkWitGNTc4WHhyNHd3S1JGbEVLb1BERUEr?=
 =?utf-8?B?c1poT0d2Z2xJRVBFNGZaSGY4WWcyU005U2UyVE5RdUNTeFlFTUtrdXZWZ1JY?=
 =?utf-8?B?Zzk3dDlRRDJKRzd0dEpxY085dEowdFk3emZYcEUvekNTTFhNeEphMUNST1hI?=
 =?utf-8?B?dlhpTXlLcjlQc1FRK3RmaUovNVJrNDc2QjNieFJKL0xzK3o0VmUveEM2WEtJ?=
 =?utf-8?B?OC81dElZNDNQbkt5Y2pKUG1Nc2Z5Unlid2VMYWJyNVJwZkEzNlAveWZ5WDdT?=
 =?utf-8?B?cU5YSURqRW1kTGNEV3c2ZGxTc2pXWXRhL2FkdW5QcTNuenROb251dHpVdDlq?=
 =?utf-8?B?SmtLMjlnajdQMW5KajFkeFcyQ2pRaUNLR2NmRlprSFR2bFdCZ1RPZ1oyYy9p?=
 =?utf-8?B?NjU2cDNXMzREd044cE43amlBcEtNcFc1YkxGVDdtYkJwaWxoMndhd0E1QlQ3?=
 =?utf-8?B?N2R3OXMvZi9sNVFlbThid0dMbGg2N24xMndPTlQ5eGZXbjVVckg3Q01kUXJ1?=
 =?utf-8?B?VWlEQXBwQ2h3eFhtbU5GMlpzaGw3NW1lSDFMaTFqV1RRK29mZitrY0RVZFlk?=
 =?utf-8?B?WGxLMjBaaGdSbU9hd2JhSWNDUHdpVy9rc2dQYkwyVW1oK0J4WUoxOERTR3h1?=
 =?utf-8?B?YnNtWG4raW1xcHF3V0lUWlZ6eTF5czN6NzJLZVF4K0pwWWdjS1NkMTI0U2ZN?=
 =?utf-8?B?YWxNaXl3b1BydUNDOVRUODYyaTdnU3Jram9hMFRVbzhIL3JhSEdSU3RuWW83?=
 =?utf-8?B?dk8wRWNBcDR5dWkwTEl3bDdUY1pVK3ZtQnNIREhWempRQ2M3Z1BoeGF2YW1V?=
 =?utf-8?B?dmYvcDlyQmp2SlFNUllqRjhUOFlsSDdPVmVQbEJBU0ZTSUs2TGxQLy9NOXRT?=
 =?utf-8?B?WndJWTdNaTNLaXA1eW5nRHF5RHF5cnJhR3BpSVMwcVVOV0VhS1lDL2l2azJ1?=
 =?utf-8?B?Ri9pelNnODJMaTRhbzUrci9rRzNUNTdya3BKZnkrdlVDQ2c1a0VBc1grMXBL?=
 =?utf-8?B?SzU1YTRQSVY1clJuNFpkWENPQ01GOHVubFNsZFV3d1krOHYwQms0Q2tuSUlk?=
 =?utf-8?B?clluYlFxZng0R2M0RzJZQncydTI0ajkySmtoOXJtbEJ3Z3ZXTXBVM1drWHBX?=
 =?utf-8?B?dm0vZHhjd1RLd1hQR0Q1eXUycnl4cjJYb1lDdWVxVEdnUnBSUG00dTRFYnJx?=
 =?utf-8?B?dm5GS3ZWYjBVVy9qOExvNEJtVHA1ZUpaaGZQKytlQ2VCV1Y4aFdIOXhEL21s?=
 =?utf-8?B?VWJIZkxRTDVKMmpxWGw4b1lmb2ZKdUVKMjd6cUtSUkIxSW9WYzBUMERLM3ha?=
 =?utf-8?B?dVAwdEV5cWxTMDkvcG0yRzJXODdGT1lIaHpKUWlMT0pzRXpHNWVvamNiQ1ZY?=
 =?utf-8?B?WjdqVTJEOWZueGdaaWUzUkcycVZ2UHd2S1VrOUZvYkoxTVBNUFliL2c3TUF4?=
 =?utf-8?B?dGc0RGg4V3NXcVJuczZNNG5veGV4OGladDV5b2FtZWJPMnl1cDlBVnlaRjli?=
 =?utf-8?B?Z05OWjBkdmZsaDBuMU54Mzd0ek5EOFdCcDBXR2x2eXpLaHl1bTZCdUtLR1FB?=
 =?utf-8?B?U2xMc3JHTys2TXR3WlJoZDExRWVJenN3SGRMbkticWJMRjdBVUc1c1FGbUJx?=
 =?utf-8?B?LytjRGIyZ1JPcXR0amttVTR1VWVBY2RIQ3FGSGY5MVE5SnVNaEdsSURQenlD?=
 =?utf-8?B?QzRRYW5VdGJQSnhFdEM5Mk1EYnlPRHRya25oQWxNdTYyWHgvdnhlcmFLc2ZG?=
 =?utf-8?B?eU85T2tTbzh5QnpDMDRLelI2MWMyQmJlb2VWN2VqNGVicjBObzZQbzBZWUpC?=
 =?utf-8?B?UmFMaTJMejZkU1lVL3lzWEJ0ZVZUNFlVSmwwdnJWNE1Na2FPcnNpaWRpN0xu?=
 =?utf-8?B?M0JpQ2pNc2tMMDdKWmR5Q3VPVHJIY0w1dzhhQUtvWlNJMjZNSWxaZz09?=
X-Exchange-RoutingPolicyChecked: X6WLnuWCgXDNIfWqwHI6dp2dLMXF+MxREHsb1OI14FIOoNIziGqGjLa/XNjmpvGDd7tnS5MUONd9nhYhjIwhDjxz7IFalg+Q2iP0hvsObPdheEpyNy2B9+QSAytBi5HoCcf4N3SJAaalOErNOkQZ67kH2GQ1BK+07ohc4eeibiiC+IJuMzVyb2DRVrcv5UyVFqg+DPgzHAFC3mGISnsp9xszmsK/y19PRevt5v2znSa46F02UOWS0ZnJP/7ugVV+t3Xt0wzaa0vJu0kdKye5YyDq/69tj+DomDe4igJ7ne3Fn74t1L6CMuotDUXwOKZH7MeRHQWbYCAQD1aWCP5O6A==
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3ad476-5e8d-4867-a499-08dea6665350
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 03:12:34.9321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6R+GSh3NELYXEe+M5Mct8Uk/bjOnY1kcNm4nPHGWxoSIQf79vDJfFCJHewa1FQSSZxO6C7LU5cEZY3bNSqbgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8413
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

On Thu, Apr 30, 2026 at 10:56:47AM +0800, Huang, Honglei1 wrote:
> 
> 
> On 4/29/2026 5:56 PM, Huang, Honglei1 wrote:
> > 
> > 
> > On 4/23/2026 4:22 PM, Huang, Honglei1 wrote:
> > ...
> > > > > > > > > > > 
> > > > > > > > > > > This patch series implements basic
> > > > > > > > > > > SVM support with the following
> > > > > > > > > > > features:
> > > > > > > > > > > 
> > > > > > > > > > >       1. attributes sepatarated from physical page management:
> > > > > > > > > > > 
> > > > > > > > > > >         - Attribute layer
> > > > > > > > > > > (amdgpu_svm_attr_tree): a driver
> > > > > > > > > > > side interval
> > > > > > > > > > >           tree that stores SVM
> > > > > > > > > > > attributes. Managed through the
> > > > > > > > > > > SET_ATTR,
> > > > > > > > > > >           and mmu notifier callback.
> > > > > > > > 
> > > > > > > > Can you explain the mmu notifier callback
> > > > > > > > interaction here? See below in
> > > > > > > > Xe the attribute tree is existing VMA tree (gpuvm).
> > > > > > > > 
> > > > > > > 
> > > > > > > Let me try to explain, apologies if the description is not fully
> > > > > > > precise.
> > > > > > > 
> > > > > > > In current implementation, the MMU notifier callback
> > > > > > > interacts with the attr
> > > > > > > tree only in the munmap path remove the corresponding attribute
> > > > > > > entries from the attr tree so that stale attributes
> > > > > > > do not persist for
> > > > > > > freed address space.
> > > > > > > 
> > > > > > 
> > > > > > Ah, yes. We reset our attributes upon munmap too. We
> > > > > > actually don't this
> > > > > > 100% correct quite either and series in flight to fix [1].
> > > > > > 
> > > > > > [1] https://patchwork.freedesktop.org/series/161815/
> > > > > 
> > > > > Hi matt,
> > > > > 
> > > > > It seems like you are tring to modify the implementation
> > > > > into remove the
> > > > > attributes when munmap.
> > > > > 
> > > > > Actuall we have a discussion internally that does the driver
> > > > > need to remove
> > > > > the attributes when munmap.
> > > > > 
> > > > > So there servel ideas:
> > > > > 
> > > > > 1. attribute need keep: attributes may be needed again when a new VMA
> > > > > appears or on subsequent faults.
> > > > > 2.attribute need keep: attributes can be set independent of
> > > > > whether memory
> > > > > is currently mapped; attributes persist and are modified explicitly via
> > > > > ioctl, not implicitly by notifier callbacks.
> > > > > 3. attribute need remove: casue VMA is gone, driver can do
> > > > > nothing without
> > > > > VMA.
> > > > > 
> > > > > and I saw xe_svm set default attribute in the previous
> > > > > version, this is also
> > > > > a option.
> > > > > 
> > > > > Can you please help to give some information that why xe_svm
> > > > > is turing to
> > > > > remove the attribute when munmap? And does keeping attribute
> > > > > is a valid way?
> > > > > 
> > > > 
> > > > This is a semantic choice, and we’re trying to match the semantics of
> > > > CPU madvise. I believe any semantic an individual driver stack wants to
> > > > define is valid, but if vendors mismatch sematics this will create a
> > > > level of vendor lock in which may (cough Nvidia, CUDA) or may not (open
> > > > source) be desired.
> > > > 
> > > > AFAIK, if you do something like this in C (a CPU-only program):
> > > > 
> > > > mmap(addr_range);
> > > > madvise(addr_range, some_flags);
> > > > munmap(addr_range);
> > > > 
> > > > mmap(addr_range); /* Here the madvise attributes are reset */
> > > > 
> > > > Also, AFAIK, the CUDA GPU madvise API works this way as well.
> > > > 
> > > > That said, making this work 100% reliably is quite difficult, especially
> > > > with a rude user.
> > > > 
> > > > For example:
> > > > 
> > > > mmap(addr_range);
> > > > gpu_madvise(addr_range, some_flags);
> > > > /* GPU never actually touches memory */
> > > > munmap(addr_range);
> > > > 
> > > > So we have an opt-in VM bind flag,
> > > > DRM_XE_VM_BIND_FLAG_MADVISE_AUTORESET, which we’re working on to mostly
> > > > handle the “rude” case above. Maybe we can reach 100% correctness, but
> > > > again, this is a difficult problem is WIP.
> > > > 
> > > 
> > > I think the current amdgpu SVM draft version also has the issue for
> > > the rude user situlation. Maybe this is caused by the separation of
> > > attribute layer and physical layer. Seems like KFD_SVM doesn't have
> > > this issue.
> > > 
> > > Maybe driver can find_or_insert in madvise ioctl path, to add a MMU
> > > notifier but do not to get_page, and then clean the attribyte in mmu
> > > notifier callback instead of GC. This is just my thought.
> > > 
> > > And really thanks for the information, and waiting for other's comments.
> > > 
> > 
> > Hi Matt,
> > 
> > I'd like to share a concrete bug we hit in the amdgpu SVM
> > implementation/tests about stale attributes.
> > 
> > In short it is stale attr_range overlaps with VM_PFNMAP VMA
> > 
> > 1: User allocates memory and sets GPU attributes but never use/fault it.
> > 
> >     CPU VMA (anonymous):
> >     |<── 0x1000 ── 0x5000 ──>|
> > 
> >     attr_range:
> >     |<── 0x1000 ── 0x5000 ──>|
> > 
> > 2: User munmaps the region, attr_range is NOT cleaned up
> > 
> >     CPU VMA: (gone)
> > 
> >     attr_range:           stale
> >     |<── 0x1000 ── 0x5000  ─>|
> > 
> >     No gpusvm_range existed, No MMU notifier, No GC, No cleanup
> > 
> > 
> > 3: User mmaps new memory for device pfn remap  partially overlapping the
> > old range,
> > and new memory for GPU set attribute
> > 
> > 
> >     CPU VMAs:
> >     |<── 0x1000 ── 0x2000 ──>|<── 0x2000 ── 0x4000 ──>|
> >     |   VM_PFNMAP                  |   anonymous (new alloc)      |
> > 
> >     attr_range:              STILL STALE
> >     |<────── 0x1000 ─── 0x5000 ─────────────>|
> > 
> > 
> > 4: GPU faults at address 0x3000
> > 
> >     Fault handler finds the stale attr_range [0x1000, 0x5000):
> >       gpuva_start = 0x1000  (from stale attr_range)
> >       gpuva_end   = 0x5000  (from stale attr_range)
> > 
> >     drm_gpusvm_range_chunk_size()  find the  chunk: 0x0000-0x5000 cover
> > the VM_PFNMAP area
> > 
> >     |<── 0x1000 ── 0x2000 ──>|<── 0x2000 ──── 0x4000 ───>|
> >     |   VM_PFNMAP                  |                                    |
> >      hmm_range_fault fails
> >      or vma check:
> >      VM_PFNMAP -> -EOPNOTSUPP
> > 
> > I think it is caused by of the stale attribute.
> > Or is this considered as an invalid userspace behavior?

The above example is exactly what we concerned about and handling in Xe
is WIP (i.e., this example breaks Xe).

> 
> Hi all,
> 
> After internal discussion, I'd like to summary some conclusions from team.
> 
> It is decided that default behavior will be to keep attributes on munmap for
> behavioral consistency, advantages of explicit interfaces, safety and
> extensibility.
> And provide an opt-in flag similar to Xe's
> DRM_XE_VM_BIND_FLAG_MADVISE_AUTORESET.
> 
> There is a concern about behavioral consistency from Felix. In userspace,
> whether free() actually triggers a munmap is outside the user's control, the

Yes, free() is the real killer here as libc may or or may call munmap.
Thus we have an opt in flag...

> C library allocator may retain pages internally rather than returning them
> to the OS. As It is said: "when you call malloc and then free, that doesn't
> necessarily result in unmapping the pages it may result in unmapping pages
> if you are freeing something big that was allocated with mmap under the
> hood, but it may also just stick around. From a user's point of view who
> just uses malloc/free and sets some attributes, they have no way of knowing
> whether their attributes will stick or not. I think if the attributes always
> stick, that would give you a more consistent behavior."
> 
> And it is from Christian that explicit interfaces are better than implicit
> ones auto-removing attributes on munmap is an implicit kernel reaction that
> users may not even be aware of. As it is said: "Explicit interfaces which
> say 'hey kernel, do something' are usually better than implicit interfaces
> where the kernel is doing something on its own and we are just reacting to
> it." And it is also noted that we can always add a flag for auto-removal
> later if needed, but the reverse would be a UAPI breaking change.
> 

This might be better - I believe Xe already was explict interfaces. So
DRM_XE_VM_BIND_FLAG_MADVISE_AUTORESET might be a non-sense idea but it
is in our uAPI so what is done is done... The free() case is where
DRM_XE_VM_BIND_FLAG_MADVISE_AUTORESET may fall apart / become
unpredictable... But it will work (after some Xe changes) if
say an app is also allocating largers sizes (128k plus iirc for default
libc behavior) where libc malloc/free directly map to mmap / munmap
which is why I believe we provided this option.

Matt

> Based on the above, the next steps are:
> 
> 1. Change the logic to keep the attribute as default in current
> implementation.
> 2. Maybe need adding a new ioctl op to explicitly delete attribute?
> Currently the UAPI can only overwrite attributes to not to map/default but
> not truly remove them.
> 3. Add a new UAPI flag similar to DRM_XE_VM_BIND_FLAG_MADVISE_AUTORESET.
> 4. For the auto reset path, need to address the "never-faulted" issue.
>     Maybe we can register a lightweight MMU notifier at madvise ioctl time
> to observe munmap and clean up attr_range, even if the GPU never touches the
> range.
> 
> Please correct me if I'm wrong on any of the above assumptions. Would be
> interested to hear thoughts on this direction.
> 
> Regards,
> Honglei
> 
> > Regards,
> > Honglei
> > 
> > > Regards,
> > > Honglei
> > > 
> > > 
> > > > Matt
> > > > 
> > > > > 
> > > > > Regards,
> > > > > Honglei...
> 
