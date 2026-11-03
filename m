Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF06B606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IKiuiTij
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F95F10F8B0;
	Tue,  3 Nov 2026 22:48:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E3CE10F8C8
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 22:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793746109; x=1825282109;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=z6zFA3Ddj64UDlxyERABU8+0GLhMPNk9gVDmuMZJQR0=;
 b=IKiuiTijrT5/AGoeQK9jrgc2p1NWNG/aPogAFkjgh1cZe7NxI234MA3r
 rAXs8hoTr19XhNrZrLdaPWwcjB3P6/hNb5nB0mIsX8W+DGMjnV7wQROrF
 ob5dW2LFQdIU9CUphJx1bUg3pNzsiJKqHdpJbdIImcMNdRVik7M2JORKq
 f6JsusewSxwj3zEUbkFNTd9gZ6+RV7MUwCxNlYbHBIjAAAcRdHN40k9Vi
 l8TrexqgUNxv1Zm1bsomis7KA798EjsFjC8f/7HuqhYTPydUZ9EjK2sSi
 6sYoueNjI9MSQ5rPNRagVKArBu186SnVq1NyhMTgjBJTwfBlrHTnxQDC7 w==;
X-CSE-ConnectionGUID: jLRBdS5cTfqya1qXVA9yEg==
X-CSE-MsgGUID: t6NiDNmSRDq1CcHUhRQ7gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2387468"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2387468"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 14:48:29 -0800
X-CSE-ConnectionGUID: b6JVVCkKRbaL2pfzGjwUhw==
X-CSE-MsgGUID: xDEpUZw+TXeMjfytdmgT/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6672742"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 14:48:29 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 14:48:28 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 14:48:28 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.39) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 14:48:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szsMaay5CoVX2KjQdXGQg2X5ZXdwyjfUFEYxrAUBoSOOPodrlKQM9DRshyvvEKwljewk7lS4hb9h2w2vzM3EYHitedO3HABOPUyQ1Gv52jwTBkyKbrKOwvHi4WsmVjPR07R9tLO1hvM9UtAEizZbbJmXch9ne8CKPsaT2ih0Wzg7LVXtU90yx1UQRTI9dyGQWlC/nA9WOwbhKgCRmDuXFEXJrZ17s02Yx86XdtZ3fmV7Ya9/PrUMsMaHdRHaQoCX2mcrhc85hb42d+UJKtgIVUEI9BIXA6S8BAWqZk6N84kZ/sgwpXTUaJUp6bRm/SiY0BtkpKj+vefQz8bv0mGPUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOT/jnyxTdSKMqot/S3tXGWl5mDtfe7D9GYMVvx7yFk=;
 b=d2BQP30aKD2nUAdpsuGP/dvAqPfbHDSAkaSTDEiSStKL84BRrAjXj/ns17CCZ4WIpxknjo8JSbgZCMtoqF3Z6zGPcLZjLYgRCXBq7z/Z88LInmwh0/Mgiu2x2MIx0XV5r0sJBUkhiqW05waDhozgwgpfiKKTtufM+RmpVUnifwwvB3LtVaFKjRj1u8yRvhwfp3LsEnL37KQgojQsBdY1PQ0231s8HLHRcTl27vQEGUGOxrUsLWsdRyANHR8ZIGO273BjonsL5CgR9rJONxCgMr23h/xFVfpM4ykkLdG+TF7aBwFyyznm2xXkZsCVW9/fi38+8sgVSJcwfiJICuA6pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by PH7PR11MB5942.namprd11.prod.outlook.com (2603:10b6:510:13e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 22:48:26 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 22:48:26 +0000
Date: Tue, 3 Nov 2026 17:48:20 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Alice Ryhl <aliceryhl@google.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, <dri-devel@lists.freedesktop.org>, Mark Brown
 <broonie@kernel.org>, <linux-next@vger.kernel.org>
Subject: Re: [RFC] linux-next: replace the DRM trees with a single
 drm-for-linux-next
Message-ID: <aupktBCwcN_coHEH@intel.com>
References: <aujZcJBUyQ7iX_PM@intel.com> <DMKY979I29AF.BS1DF5YAZMOY@kernel.org>
 <aujikV14tF6K1Xqw@intel.com> <DMKZR0YZV1CX.DWVK9V47GR1J@kernel.org>
 <CAPM=9tww=CJdxzvfUvLwQ6V4uoszg8JrB1XCAcp15upM-xPvSg@mail.gmail.com>
 <DMLTRKUXTL3P.11VRVU1A8ERMG@kernel.org>
 <aupFKGpAwAiGXN0U@intel.com>
 <DMLVPRO7XF7F.21199FO61MFRD@kernel.org>
 <CADnq5_N-6_T8EnihjoTSqpHGb_mZPogi6z=Ti-7_oue5d07oTw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_N-6_T8EnihjoTSqpHGb_mZPogi6z=Ti-7_oue5d07oTw@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::7) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|PH7PR11MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1c540a-11c1-4326-30f8-08df39fc924a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|376014|366016|10067099003|18002099003|22082099003|56012099006|11063799006|4143699003|261022075727099003|261021135927099003|261028144727099003|261026140227099003|261026121527099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: ghhT1xejzJRmc6QyG75Qw+hVMMjV1s7hPyBbapN9hzLr0KNNlYcGOj/Edi6NY8M+oQNCAQSCFPtGsJo4Xyplk+j51zaibwE+9s5PKa+JaHTNXJuJ0h1/rSMHxJL1WIJAsurRI5Gbj3cr85vrdpVRgZ9sFgNQz0P5xR0pVty8sx4hbscn+HAbzGRSo5+lMCLGe4flE23DX75nL3Q/DnSvswvaw+W+cwHGoyAXFySfloEi8Mctwe7aptKuRIpXSjmxkpEAhTReUnYHZTUqHUNolsyMoM2NFuJkjgaNwMVfyLtpcsriioYsdTrAKK66BzJwQ3vq05e4pqZVnByaW+4i4VvYWeZdwMcKVkgygeZlzyAXEKmFlWQWoYxVtMg5F8aIx1F5OrQb/gAiyk2hYi1CdIhxGvG18CJsAUZ6U72nxcLOb38GB7l3gYdG51T/mboyyZqk1G6uFchZqwzFjLe8HRS4KsTlxR3Qc2D5Ax5J3vpMcBTOEU3F73EB7vtRS9kqqvdvmYwyYHpB/CfoXwtZQNceK3Bf3hKDuZvpjp1GPXktxMMWx3OyuoPb5pdEKVyaXBlz3Q/eBfNYAbQ/hEOwu+BOWitRcwL+4ZHUZgP9yRicUBQmPgBoiQAivb+rS0Jrtk9WSrHu+Q4Hi4rrNvmLoRIAzTnXkdgEunIbhEqWdhM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261022075727099003)(261021135927099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WldsdnF6K2t4R2RLS3kveVhpSXAyWDArVE1WWmwrdUVWZVZTS1dFK01jVHJh?=
 =?utf-8?B?TE93RTkzMGExb2ljdTlMTGRnVzNZRlc3c3V5dUphT3JJZGI1NHcrTGxoN1Rk?=
 =?utf-8?B?dXZyWUNMN2krVko0eFlPQ21QeWZ5NlplY056dlRGaHRha2c1VWtjL3VEdGZ6?=
 =?utf-8?B?UU1DUmYza1I3YVVXaUdPSzE1eWhLVlZZY2wvRUxQeWRCeW1qZkE3bXo0VVlo?=
 =?utf-8?B?MllJdXVQaFpIeHp2VzRHOUJTNytHQjRaSjlXQWEwY2lPV1I4TURYVklJdTRt?=
 =?utf-8?B?alI0TEV5SlZqOHpjUzFFeFBBSmovcDlNdU16RVpZT3BsTEU1a0F1c3M3YSsz?=
 =?utf-8?B?SlNwZjdIdVZpQ2V2Tk8yOHM5S0NHYzA0NW9XNVlvM0kyVVlvaHlFcEFoSlFi?=
 =?utf-8?B?YmhhcVg5YWIxY01ScHkwTlhjaXF3NTlJeWVtNHVrVWtrZTlTcllHZzJKV29U?=
 =?utf-8?B?ZjluMEMrUm5vbnRCSUw5ak1PN2MrcXVpMnN2NzBYUFdreXBzTTRmbE9hRWcz?=
 =?utf-8?B?TktML3JWQVdYem9VWXJrZ25uZHhlbmlXd2JQeG9NQlQ3dno1VmV6WXM5MTNh?=
 =?utf-8?B?Zk1YTHdObmlLWG9qczBtYStjVDdKb09LSFVKRjM2VGp6VGFuWjlYWWpTRTRm?=
 =?utf-8?B?MFBWQmhtWllQTThVamdxMWtySkRlajE0OHg3bnBrMGQ4TlF1c0Z5VWtDd2hW?=
 =?utf-8?B?R1F0cis2RE9TK212eVprM0wzcWtCbWNoelZIVUJQK09BaTRsWG5KOWk3UTls?=
 =?utf-8?B?Rldlc2VnOEl5Vk1NTGVNcjg1U2Z6RXRPaG1wb09xY3lxbTNZUHlQd2FBL2xE?=
 =?utf-8?B?VVhkblNVcmc1aTlwQmZyaERLMEdXQ0NaS0dXLzN0Y1gwZHhPSXZvMmpPMEFO?=
 =?utf-8?B?T2ZtektocFg1YUQ4K0Z5bjRrNDRCU1JkbThkb1lxdElIK3p5SGN0SjB2c3lH?=
 =?utf-8?B?OHpCNi9lUEFJNVNWT25qRHk5RFdENlFneHRNSlZsa2JQOEkxbWREU3RnSlNs?=
 =?utf-8?B?NTFoNnJlaUZiUUJhMFlNK1FMUkNVanArSUs3Z0kxd215UXFRR1c2S0Qydk9K?=
 =?utf-8?B?RDdtbndyWkVUeDRwbGRGRzN4U2dwMUlhS0RhSkRWQWVJSEZuK2JVRWhiMWQ4?=
 =?utf-8?B?OUJYMmRTOGx0cVoxRkticzdhWHNCdU5FOEFielVYQStncm5wenljblh0NWsr?=
 =?utf-8?B?TDZETE90a2szSStXYmtJY2VsNDFPdFdPKzRVU2hTZllHdWZmRnFNdDNMVHdv?=
 =?utf-8?B?MTZpMGdEMVVEZUo3ZENudjBnaWVpWW16Qm1maUJoUzdHVC9MVWZEQlEyYkJH?=
 =?utf-8?B?WU5wcmh6azAvRHVSZmN6dHVaZFBGNDFxOUsvdG1MRGdTU0ZRai9DblRYR3Jo?=
 =?utf-8?B?c1JtUlRWU2VVQXluY0p4VHFWN0ZHT2h6YUl6VytuYWxPU1FYVWoySmdwY3p3?=
 =?utf-8?B?U24xRTJoSGJLaHBidXphY1lUQkFUTHVic3dhNkFZTzA5bmZvOXF5dkhGYXFH?=
 =?utf-8?B?WXlxREpEaDNWMWxObXZ3TUY2VVZEeUNqVUF2NE5EMnREemtrR2FNbXlRQVdR?=
 =?utf-8?B?Wi92TWM5L2dkWEQyc2hnZ3NrSUcwdXpnQldURWxLZkJEbXErMEEwdURXMVFD?=
 =?utf-8?B?YnMvcTVCejBvVGY4NDhiYXNJTnFxbUpsUjRMaXgrZGhrcjhRUXRnZGh0SFNW?=
 =?utf-8?B?SE9xUVRhZFJWLytFc1BxcVFzc3p3RFNFeUlDYWhkZGsvNGZPd0xQVENuWXJm?=
 =?utf-8?B?Y1h1WWpVKzdYNWNSZis2TVY5b0pHSjV3TDBKY3ZyUDdrRVFabGs4SFZGZzNm?=
 =?utf-8?B?VFBWZDNjcjViZW9GT3d3LytJandyQWtZZXc3QXRDM2hhMm52NzVaejZsZW5L?=
 =?utf-8?B?MXh3dlNFdFpZNEdPTWVRV0hpQnkvalg4Qk1wZzYyZHJOcER5UjBXa3pDNXFB?=
 =?utf-8?B?a2xuSStIS2E1dXh2QlFDVUVkRUdyY1c0bG5iZExRTkpBOWlTcGhHTVkrMU5w?=
 =?utf-8?B?VU1TWmZ6YklQdzZTRDMxNTBZR3RyN0ZUR2xGYjF2ZWdjdjBrbmRqYVVZNWZZ?=
 =?utf-8?B?L3o5S1FGOStzTjZCOUlTaFpQaytWcTNCbEo3aU43VkR0Tmx0dmFKTzIwc3hn?=
 =?utf-8?B?c3ozRE1lM3REMkszT2RBViswR1ZLb1pvdjA1TWFYSFpUSUlybTNvUmE3YVly?=
 =?utf-8?B?Mk1UMnFveStwWWZyYXhyQld0QU9mQUdqbU90bXhzcEVtTloramxMMHE2UzFT?=
 =?utf-8?B?eEh0VnpKQ0JjemRZbXFMZ1U5YUYvdVpNUFN2VVZOY0NsbXFJOW5JL0NJOXQr?=
 =?utf-8?B?b0o3dW9XaTBTWXlwbEZwZ080ditqejZEdzlrY2JJY0M4LzVQSThKdz09?=
X-Exchange-RoutingPolicyChecked: vAwIDX/MBxajN77oYN6gew9XaJPmjnrnV5vFjqkrCn4kK3dj0r2bK4QZPWdKGkjgqD81di4KKSYHmCnSFSly34RkiH+IPhglnfwx2C/XPog0UUu+fMb1rn0TPca8U6flz43qkhkElg4EIbA5wVLvu0untotsUqt3meYE0WFkHFY+PB8xAjIHe7TDXn27twyksscLKqeH2si+7TCzAV0BagR54ogUXULYlwLX0G3j6NSkAXV9D/F984pVmjH+C3FN1YyosAZkiwPTJNekkp2aMsxccvSfIIelBJOhPF12WQcv6GB0XMI6+04BrqRPn3FG1JEnp9d0dvGHG7Jn3c1DLw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1c540a-11c1-4326-30f8-08df39fc924a
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 22:48:26.0590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZpYngSto4zFdqiON2TUT2FDGA6rvdPbrDfqebnim3Wv1308BrSySlR2uYH0gDO8Js230VZiZgMQFJ6xcn80rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5942
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 04:19:11PM -0500, Alex Deucher wrote:
> On Tue, Nov 3, 2026 at 4:11 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Tue Nov 3, 2026 at 9:33 PM CET, Rodrigo Vivi wrote:
> > > On Tue, Nov 03, 2026 at 08:32:48PM +0100, Danilo Krummrich wrote:
> > >> IOW, linux-next merges tip/for-linux-next, and tip/for-linux-next merges
> > >> $tree/for-linux-next, rather than $tree/$tree-next.
> > >
> > > For this to work we need:
> > > 1. xe to create for-linux-next for-linux-next-fixes
> > > 2. amd to create for-linux-next for-linux-next-fixes
> >
> > Huh, I thought all the trees are doing this already. Well, that explains
> > where the the problem comes from. :)
> >
> > In any case, drm-misc, drm-rust and drm-intel already have for-linux-next and
> > for-linux-next-fixes, and the implementation is generic. So, adding it to xe and
> > amd is trivial.
> 
> I've started doing this for amdgpu this cycle as well, but I still
> pushed an amdgpu-next branch as well since that is the source of all
> of the cherry-picks for -fixes and -next-fixes.

But it only works if you stop this branch of updating after you sent your last
-PR and from that point and on you merge or cherry-pick-from your -next-fixes.
Otherwise you are sending next.next material to -linux-next.
And this is the current issue Mark is raising to us for a while.

We have 2 proposals on the table:
1. (this RFC): a global unified drm-for-linux-next that is a chop-point while
   drm-tip is getting constructed.
   If we go with this option you don't need to do anything, but stop maintaining
   your for-linux-next.
2. (Danilo's proposal): Each driver/domain keep their for-intel-next and
   for-intel-next-fixes for granular control of the blackout weeks
   and dim merge them together into a drm-for-linux-next
   If we go with this you need to at least ensure that your for-linux-next
   doesn't contain next.next material during our blackout periods.

> 
> Alex
> 
> >
> > > 3. All maintainers to agree to move their -next-fixes on the same day that
> > > they are sending the last PR. Or have a new dim sub-command dim final-pr
> >
> > That's what drm-misc, drm-rust and drm-intel promise, yes.
> >
> > Something like dim request-pull --final seems like a reasonable helper to me.
> >
> > > 4. Instrument dim to have this secondary reconstructed tree instead of the
> > > implemented chop.
> >
> > I think for this part isn't different; tip/for-linux-next just merges one or the
> > other.
> >
> > > 5. Prepare every committer to deal with this extra build time and extra
> > > conflict resolution.
> >
> > Which extra build time and conflict resolution? You have two tip trees in either
> > case, no? One that contains $tree/$tree-next and one that doesn't.
> >
> > > I honestly prefer the simple chop solution. But it would be okay by me
> > > if you take the lead and implement the dim changes for this flow.
> >
> > I don't mind doing this. :)
> >
> > >> I.e. the ultimate source of what is linux-next material remains to be $tree.
> > >>
> > >> In general, I think that this is more accurate and probably less error prone
> > >
> > > I would argue the other way around.
> > >
> > > The reason that we are seeing so much escapes from next-next into linux-next
> > > might be exactly by the fact that the blackout right now depends on 2 separate
> > > actions to help simultaneously (last PR + rebase of -next-fixes). What most
> > > of us are not doing.
> >
> > Interesting, why is that? It seems to work perfectly fine in drm-misc, drm-rust
> > and drm-intel.
> >
> > The only thing maintainers need to do is push $tree-next to $tree-next-fixes at
> > the cutoff. The rest is automatically handled by dim already.
> >
> > >> For instance, let's say a tree closes (i.e. tags the last -next tag of the
> > >> cycle) a few days before -rc6, it could happen that subsequent commits to
> > >> $tree-next still appear in linux-next because tip still picks them up until
> > >> after -rc6. So, after -rc6 those commits (that were in linux-next for a few
> > >> days) would disappear from linux-next again.
> > >>
> > >> Not that big of a deal, but technically they didn't even belong in linux-next
> > >> for only a few days.
> > >
> > > But well, this is a good catch and a bug on the current proposal indeed.
> > > Should we move that to -rc5 to -rc1? We just need to ensure that everyone
> > > have at least 1 PR after -rc5 and we are all aligned.
> > >
> > > The only caveat is that patches landing in drivers-next during -rc5/-rc6 will
> > > take a few days more to propagate, but it shouldn't be the end of the world.
> > > It is still a couple weeks before the merge-window.
> > >
> > >>
> > >> If we kept $tree/for-linux-next, tip would never pick those commits up, because
> > >> a tree that closed a few days before -rc6 would already have switched
> > >> $tree/for-linux-next to $tree/$tree-next-fixes.
> > >
> > > Well, if you don't move your -next-fixes at the same time of your last PR
> > > you are leaking that as well. And this is happening.
> >
> > Where is this happening?
> >
> > > At least now we know why it is happening (besides xe and amd sending
> > > straight from -next instead of having the -for-linux-next branches).
> >
> > I think if xe and amd would have those branches there'd not be a problem to
> > begin with.
> >
> > But independent of that, I think it is nice to give the "fully merge conflict
> > resolved thing" to Mark. :)
