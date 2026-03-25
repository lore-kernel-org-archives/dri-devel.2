Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D11FFEA80A
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 05:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70DC410E1DF;
	Wed, 25 Mar 2026 05:21:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OTM/lQ+H";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A40F10E0BC;
 Wed, 25 Mar 2026 05:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774416092; x=1805952092;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=0L7yd6KjvHm0ZQf24rBBEy+dmUYKc7C5EXJemMSMsnw=;
 b=OTM/lQ+HOdWZUihBiiehuCNg0Sc6MfVQP198lvvneYAJogkEM++6Qt16
 4B5vd+z8/teADBS6bb73e4aytnVT9+cgk5rpdVoJrzvTSFJCni16Qecg2
 o+Gg/2BMX41bsIAwKy+sGVH1dxKzqnHGQrLQwZehoG5R97GdPFZobPCmz
 AWfY+UD7hVkV1zZcGLfhnprVrwkuY3v2VQ6I1vXPWOBlN3AMKyKHqH2qE
 /CNQBlkd2+3NuKb34+hFusNSVhPPt6mGv4MbuYu3i+xk+kJleqz1T0GOW
 3yTSF9NYKBEVzjI+CsFvGoT0avWLbvIwkixZVR5N6RKt/k54HE7s/7HdM w==;
X-CSE-ConnectionGUID: AC13gqQLR32k7L1JPEaDww==
X-CSE-MsgGUID: Ms8cOMMlTLakZaSZRHt2EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75162355"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; d="scan'208,217";a="75162355"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 22:21:31 -0700
X-CSE-ConnectionGUID: iUXN2BOdRyejtHzdz+jcJA==
X-CSE-MsgGUID: d6JpmQZ7RymNFBrbkERABw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
 d="scan'208,217";a="220158954"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 22:21:30 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 22:21:30 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 22:21:30 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.6) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 22:21:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+WB3s+7DsNlLuJ7eyWaHed8ZEFQA941WWn3FswIkslemK1eZmnj8RVi2TfYSig7hPfpmfjmOLQC70OmPE1RaqAMhQFOymq9/c+M9jN8rQx/alIWjpmzeQz9cmNeQFG4DrhJbK+7+NDbNkqdkZ1tUj0DSZd65PvG8f9RYPza8OPq8pgkZ/J+Ezr2It2yHLgxhA0dHevKEyzoYFgMkhbCUoiJDqfUXgjH2F8Dm/I7mtb9J4P+HVo5e86gtyY61yuRXt2phYe3fQ1JsNrLi4oC9dbVO+b1quUTOTUiUM/mLL69ABJ8AJ+tXNbVBfPs2OrMTG9oOWYo12tOoZ0BE+K3GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKZyK1vzyY1e5qUo8Ek/Ugtd/yPZ4uyKheUh2eAPFNw=;
 b=Qv0/i0uj1TSxT1nqeTpYvyG//MQIq0aCr2G7d1TnIyLoZnZBkwVFQ1ZhaciaaFtAjBJZJli3pqRGT5OcLFLqueSvYwNu9tNz1+dz/bmt5GsEs0LMWwiGDExin/N4AE4ViXKRNm7fPG4872STghmGnO8j0/Bw3jjYEuf/OF6siYyTdFfmNQnRaQpXW4DraFeuYJuUpcg3B6wdCwnbhwyW4svOkghypaOpEFDsDMmaLMCB5EQ2BkrP0EZlC2W8/7p+eF2ej84wvfr6qb+mCZzaQq4UKAoRNawyrj3dYDjluI1VqBlyiBSqqVk5OwGhtGc2vdyvA8GodrzX8PS5aknV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8695.namprd11.prod.outlook.com (2603:10b6:408:211::15)
 by PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 05:21:27 +0000
Received: from LV3PR11MB8695.namprd11.prod.outlook.com
 ([fe80::ccc3:3fd6:58f5:927]) by LV3PR11MB8695.namprd11.prod.outlook.com
 ([fe80::ccc3:3fd6:58f5:927%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 05:21:27 +0000
Content-Type: multipart/alternative;
 boundary="------------t5vEK6At6E9JRJknleTNywGq"
Message-ID: <3b1013f3-8ba2-4b13-888a-000e26f4128a@intel.com>
Date: Wed, 25 Mar 2026 10:51:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v6 1/1] drm/xe/pf: Restrict device query responses in
 admin-only PF mode
To: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Michal Wajdeczko
 <michal.wajdeczko@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Piotr_Pi=C3=B3rkowski?= <piotr.piorkowski@intel.com>, Matthew Brost
 <matthew.brost@intel.com>, =?UTF-8?Q?Thomas_Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, =?UTF-8?Q?Micha=C5=82_Winiarski?=
 <michal.winiarski@intel.com>, Dunajski Bartosz <bartosz.dunajski@intel.com>,
 <dri-devel@lists.freedesktop.org>
References: <20260316064100.2542412-3-satyanarayana.k.v.p@intel.com>
 <20260316064100.2542412-4-satyanarayana.k.v.p@intel.com>
 <875x6lq64y.wl-ashutosh.dixit@intel.com>
Content-Language: en-US
From: "K V P, Satyanarayana" <satyanarayana.k.v.p@intel.com>
In-Reply-To: <875x6lq64y.wl-ashutosh.dixit@intel.com>
X-ClientProxiedBy: MA5P287CA0120.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::6) To LV3PR11MB8695.namprd11.prod.outlook.com
 (2603:10b6:408:211::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8695:EE_|PH8PR11MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e78a91-4111-4760-10e1-08de8a2e5d10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: GESSLLSpZnqUuG3d4+uxHbgjyKqNDaQqdTpLhMF0OCIE/KUFUY2btVSAJ+880m5HYyoM9tym5ScUURN8Y+DDmd0uu4zdoz9TNPZI7Wo3FBMOQ+ve2XFpxQDWd6RCCe/9LL4RzetcQ8g8pR492/gKuLIvozZ3cSlRGl6aEx6uSrDyyL36ObhWTTej7mPeM84G30ePc4W66MINI2ySyzgJe7s2Naq5q0OCHPVQy5ZW7qtrvb45IFnriD7TR3oG5SbHCf6AmGG8zHgP7IznI2je1HaHAitJHoqtmTVS/hGwgaCX1vjJarX99fxvig/R593ltLA26BWCQP0tlzMuT7N7VCqQn2y7lG/qcVsFlYfmv6MTJJ/czL2pgZBmD4Bqtf9O/807m2e5AZOGTT75MFUJ1WhuLZddwxTiCakvonpg3ZA95rUuwfNHnleT+chdpL3PgXLgWqnWaF9gLqK3NSUnrWwKSsUEi0P36ZHuN2OiugymZj349f7cfhYTyv0oYdbM9WXxYQajy7FscygvWn8L3sEtJnUEgXii0xPFRZNGyFLEZSZZ8+uiBXwzjZ9/54ZngjSZEv616gCJEEf0qIIQGdHBUJj6NPZOp9AbBVnbo2lZN9LLVVcBW1DMxLXRuS/X2T0lcDpjk/fIOAnXapnwyb7lysKosqGSFSecKTLSKsW9vUSPfNclP1/NvKiwe2PpRiJV27XuStk8PsO2bOTdOavpigdEobQ0HAiKrbksEys=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8695.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmF3bmQ4VjlqTWpDVHlOWEpaaFBZakRaSWxyQmxERGJTcjFRcFlIQVNhQlNV?=
 =?utf-8?B?Y2tWYVpERFV1ZCs0K3dsOVZ0Zk5yVzBBclNUUUxwRlcrVkd1bnA5RHdwRFAv?=
 =?utf-8?B?K0xnblREb1FaTmNhUkFpSkhiVUxzd2ZRSTZZR01MdCt2d0t1MlVmK05VRXJL?=
 =?utf-8?B?SnJ3U1c3SkUzRVdwUENJb2NTai91VlpBdTlHcnBVdTVyZitOZzhtWStId1U4?=
 =?utf-8?B?MGpWdEFPWk82WDJuS1pMcDFxd3dRVmtCdyt1emRHTlJ6TkQyVXcwN2tNblo2?=
 =?utf-8?B?NE1oWHpqaG5Jeit0aTc0VDRjSkVFUHBMRFY5bTVBeTZIbFQ2UTNlOEZ3QVRV?=
 =?utf-8?B?eUpZcnI1TFp5UFlJTkkxdUdOT3o1ZjhhaElaYkdOaVY2UG85QjFiclBCU1Vt?=
 =?utf-8?B?RlJXclhlMlJyK05ybDZwNVhzbnFKaFhKd2R4SzVWc3luekthU2hvWlBvQWdn?=
 =?utf-8?B?TnREYnc4VjhwdDBXUGYzdUZzWHgwTGV2UVk2bzIxK3czeUh6STlLU3RyYUpR?=
 =?utf-8?B?Tmh4NGNYRUVtWkFmVVE0aFRsb3dKczd1U2pjY0dFQlI5YUg4WitLOVNWWFlW?=
 =?utf-8?B?MHBkc01ZNnU1UWY4Qzg4V0NGWThJSStHWEUxMnhINWFwbzlWekU0Zjh0MXpW?=
 =?utf-8?B?SHI0OFF2V3JkSGFVbUN6b1ZqQ2ZKZ0FZWmVvanFFb091VlhQY2tYMW5WL0Vs?=
 =?utf-8?B?amI1UVhJK2pJUmNmUWE1NENUNG1sQ1NSblUwZmRUMHc2ZGpBRUZsS05zUEtM?=
 =?utf-8?B?STBjN21QV2l2bjA1c3dDZE1HNU8zOE5aaTRoS0pMcmpsUlNCbnh6cm53NzJm?=
 =?utf-8?B?TXhKaCsraTdBa0dQdnU0VGNEZmJpTU93dEZhdU5IdWNldnlXdzlZQWkyNTFE?=
 =?utf-8?B?V0RMVi9MSFR2RlAxRkI4MjREWjdKblF0VURmY0JNRGVOOTRPUkhIUzEvYVl2?=
 =?utf-8?B?RENKZFgrVDVORU1XYkdiOEJGWmpVMWM0RldHcGhSVDUwdjNTMDU3MEl1WHp5?=
 =?utf-8?B?WTNzVkU4ZnQvNmNxU3hDS2hjczVyVTFJQ2liNTBHUjNNSi9FQWM4Tjd0RWZI?=
 =?utf-8?B?d3E3dGdKMHo2L3BtdHl2WG5zcVVmWGRBcmh6emRISEVpUVlTaUVpaDg1MVk4?=
 =?utf-8?B?Vjc3cUR4OXBjaWdKMXloRW8wR1N4K1Z1Ukk2VnhUSHNOdWJjSkgzcFR4ZnVF?=
 =?utf-8?B?VkpjM0xGSEZ3MDdKbkl3dEx6UXBWMkdhbkpyOFhleHZJajV2cE9JWnhFbC9p?=
 =?utf-8?B?b2VBU1hpUTQwc012WHQ3WERwZUpLQm9Jbm5rVWRWY0N0cjI0WlNsdGRaSTBT?=
 =?utf-8?B?MW5uSUtrenpWdkFmdldDWjhMWmFETTFmczFYRUdzOEw1VGxxaHhzQlpidzFX?=
 =?utf-8?B?Si9zRkdra0J4MTQ4ZWx5Rjh5WkFrQ1o2bVZBYXZTcjJwZ1VVWmpxNkhQQTNj?=
 =?utf-8?B?ZVNvdW5OWVBmZFlQSWpWOUFLUC9TSUtMWjZqeElXc3U1UlEzOG9qdmR1cUxT?=
 =?utf-8?B?NU02K3JhbktkUG1SSUcwMHBkdHBuY3BMVEVGb0h2VDNlWDdMQXM4V0gxOWxP?=
 =?utf-8?B?SFltTmZEK0lmc0cvbFEvK1hzSEFsRjBTeWlNWDB0Y3NoMEhZei9UQ3Rkcjhy?=
 =?utf-8?B?REZJVmxaZDlPbllOdFlXdUU3UGZ5aGNqZTJlTktRdWVUdGJVWGZBQjl5d1h5?=
 =?utf-8?B?VVJIMEVFckZsQVE2aFNVWGNvS1ZiYUtNTFg2WlE5MU5TRWt6eHNDTVZJRVhS?=
 =?utf-8?B?L0hjTlM2b0pLS2M0OS9kWW9ORTgxbFozU3NKRElyNGpUVWgvWmZSZHlUNmNK?=
 =?utf-8?B?RVlDeStBd2FvM1NKdEx6QWs4K2Z6ckJHMm55Um43bFJ4RDJibXRCUDVTdDhO?=
 =?utf-8?B?VEJhSmRuNlZ6M0hyTGhzWktTTWxHYlFpd0hOb1ZMSjNsYmJYZUI0LzFEZkxT?=
 =?utf-8?B?RC9mK0pYT21VMXluZkF6aWYxNkVnY1Rpc0ZPUkljSjYwbG40dXo0bmI5S3dD?=
 =?utf-8?B?clhZR0FYa1RlMnROOXBmVUhuZGRZTU5yWXVPMWMxOFBHdElkZEp2djlDZ1lo?=
 =?utf-8?B?RC8rVW13VmRnR2l6aE1BdWc0SWQ2WFhpZVVkMlBNR2l0WnhEek55dzNtUHZr?=
 =?utf-8?B?WmJrcWFBZVVHQ0RNaEMwYjVrOWxtMHVmNzJXYTNleTZYcDNkVDQ4Yko2VUNx?=
 =?utf-8?B?UTJab05ZS2NmdCtVb0lxVVZiN1NHcXRTL0RXajJWb1FHbmxQdjhBT0hQcitj?=
 =?utf-8?B?Q0swcE41RTljb3lrZ3F0dkEwRU44VjQzam9TRUUxUE5YaUVjYmlOLzN6SjZW?=
 =?utf-8?B?eU15bUF0SElCVm5RaTNLUGVtaUlBeTROMFNzZWRoc0pTc1pKWEhqN214R1lY?=
 =?utf-8?Q?ukhjeUrrq4eU4hag=3D?=
X-Exchange-RoutingPolicyChecked: Wbbhatz+uo0xM/oyCmAqpVZRttcqIphSeldVmJ13CLMOkrNtWOk1MAYVAGBfPhVutomYnrPjCEAg46gCAhqQj0R2tH2vTzdnRDpLZi1WD1LVvOP7WJR/apnu7MG63ldbLRBwtL44HQaPSWmlgcF7rhaNJruh7DuRqRmNFACov5mhxePgmQ+X6uNZ/X61ITevF4h8z4r4SZXqsTFDxTRi9Z+zXUylEl+8w3H1sRP+Skxf64QXX//MbGKhwUjJhqkP1LDds9JdiLlGldgYtJAM5OxQbKf9ZVm3pzBtEoP/AtC9gpM4e25GUN4RtWg7iikh6a+xi7mBQplkDg+PlrFEmw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e78a91-4111-4760-10e1-08de8a2e5d10
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8695.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 05:21:27.1405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIWNv7dgw/utp5vrQ0Q1d/5A+aGVv92dMRgkPGfhhZXfrVMo2pDHA/xpcd/dmMF7qvuVIx838E5iNF4rsWQMC1b2++g+gZrcno7v9B/wGZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6779
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

--------------t5vEK6At6E9JRJknleTNywGq
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit


On 25-Mar-26 2:47 AM, Dixit, Ashutosh wrote:
> On Sun, 15 Mar 2026 23:41:02 -0700, Satyanarayana K V P wrote:
>> ---
>> V5 -> V6:
>> - Updated commit message.
>> - Return number of engines and memory regions as zero instead of returning
>> query size as zero (Michal Wajdeczko).
>> - Allow all other query IOCTLs excepts query_engines and query_mem_regions
>> (Michal Wajdeczko).
> Can someone explain the reason to move away from the approach in v5? Afais
> v6 has issues of this sort:
The V6 is due to comment from Rodrigo from V5 "

Looking to this patch I got myself wondering if query.size == 0 is
long-term proof...   I mean, if we need to get some OA/RAS/telemetry
kind of API that end up needing some kind of query information....

Michals, thoughts on this?

I know, I know, this solution is indeed much better than my
proposal of no ioctl exposed. But I mean, since we are taking
this path and allowing some ioctl. Shouldn't we prepare at least
the query for that and then only limiting the number of engines
and memory regions to zero?"


and comment from you (Dixit, Ashutosh)as well.


"Also, there were some questions about supporting OA in the
admin-only-pf. Here are some high level points about this:

* OA/EUSTALL is not supported in VF's in current products, this might
   change in the future
* OA/EUSTALL in admin-only-pf can be used to profile global counts across
   VF's
* OA/EUSTALL themselves don't allow workload submission etc. They only
   allow reading profiling data from HW
* OA/EUSTALL in admin-only-pf will need the observation ioctl to be
   supported. Also, some other query ioctls such as hw configuration,
   topology, frequency will be needed to make sense of OA/EUSTALL data."

>
> * query_engines will return 0 engines but query_hwconfig will return > 0
>    engines
> * query_engines will return 0 engines but query_oa_units will list out the
>    engines
> * query_oa_units will return valid oa support but observation ioctl will
>    fail
>
> v5 seems to have avoided contradictions of this sort. Or this doesn't
> matter? Thanks.
Since we are not exposing any other IOCTLs, even if query_hwconfig  and

query_oa_units find number of engines > 0, the UMD can't submit any WL. So, should be 
fine right.

--------------t5vEK6At6E9JRJknleTNywGq
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 25-Mar-26 2:47 AM, Dixit, Ashutosh
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:875x6lq64y.wl-ashutosh.dixit@intel.com">
      <pre wrap="" class="moz-quote-pre">On Sun, 15 Mar 2026 23:41:02 -0700, Satyanarayana K V P wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
---
V5 -&gt; V6:
- Updated commit message.
- Return number of engines and memory regions as zero instead of returning
query size as zero (Michal Wajdeczko).
- Allow all other query IOCTLs excepts query_engines and query_mem_regions
(Michal Wajdeczko).
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Can someone explain the reason to move away from the approach in v5? Afais
v6 has issues of this sort:</pre>
    </blockquote>
    The V6 is due to comment from Rodrigo from V5 &quot;
    <pre class="content" style="box-sizing: border-box; overflow: auto; font-family: Menlo, Monaco, Consolas, &quot;Courier New&quot;, monospace; font-size: 13px; display: block; padding: 9.5px; margin: 0px 0px 10px; line-height: 14.3px; color: rgb(51, 51, 51); word-break: break-all; overflow-wrap: break-word; background-color: white; border: 0px; border-radius: 0px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">Looking to this patch I got myself wondering if query.size == 0 is
long-term proof...   I mean, if we need to get some OA/RAS/telemetry
kind of API that end up needing some kind of query information....

Michals, thoughts on this?

I know, I know, this solution is indeed much better than my
proposal of no ioctl exposed. But I mean, since we are taking
this path and allowing some ioctl. Shouldn't we prepare at least
the query for that and then only limiting the number of engines
and memory regions to zero?&quot;
</pre>
    <br>
    <pre class="content" style="box-sizing: border-box; overflow: auto; font-family: Menlo, Monaco, Consolas, &quot;Courier New&quot;, monospace; font-size: 13px; display: block; padding: 9.5px; margin: 0px 0px 10px; line-height: 14.3px; color: rgb(51, 51, 51); word-break: break-all; overflow-wrap: break-word; background-color: white; border: 0px; border-radius: 0px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">and comment from you (Dixit, Ashutosh)as well.
</pre>
    <br>
    <pre>&quot;Also, there were some questions about supporting OA in the
admin-only-pf. Here are some high level points about this:

* OA/EUSTALL is not supported in VF's in current products, this might
  change in the future
* OA/EUSTALL in admin-only-pf can be used to profile global counts across
  VF's
* OA/EUSTALL themselves don't allow workload submission etc. They only
  allow reading profiling data from HW
* OA/EUSTALL in admin-only-pf will need the observation ioctl to be
  supported. Also, some other query ioctls such as hw configuration,
  topology, frequency will be needed to make sense of OA/EUSTALL data.&quot;</pre>
    <blockquote type="cite" cite="mid:875x6lq64y.wl-ashutosh.dixit@intel.com">
      <pre wrap="" class="moz-quote-pre">

* query_engines will return 0 engines but query_hwconfig will return &gt; 0
  engines
* query_engines will return 0 engines but query_oa_units will list out the
  engines
* query_oa_units will return valid oa support but observation ioctl will
  fail

v5 seems to have avoided contradictions of this sort. Or this doesn't
matter? Thanks.</pre>
    </blockquote>
    Since we are not exposing any other IOCTLs, even if&nbsp;<span style="white-space: pre-wrap">query_hwconfig</span>&nbsp; and&nbsp;
    <pre wrap="" class="moz-quote-pre">query_oa_units <span style="white-space: normal">&nbsp;find number of engines &gt; 0, the UMD can't submit any WL.
So, should be fine right.&nbsp;</span></pre>
    <blockquote type="cite" cite="mid:875x6lq64y.wl-ashutosh.dixit@intel.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------t5vEK6At6E9JRJknleTNywGq--
