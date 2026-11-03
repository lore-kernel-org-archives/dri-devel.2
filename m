Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B6C606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hzv47GXo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC9610F818;
	Tue,  3 Nov 2026 20:36:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BDD010F83D
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 20:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793738159; x=1825274159;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=iqY7zS1aj1Vj/EpPldWGNgpbYcR1IVm/utL0o16/kLY=;
 b=Hzv47GXoOpx6LkrazCC9MCnyLuXoltxL/kxiONYH7hWukJh7kM2RwghU
 3Vpms35sP/2mT1YumNQ6dr62qMoaaRpcXbV839dIJERqS/C8/9zhvbfxR
 J4AJmDzmneFbMTT/A9ZfH12Phy6n1OqfNgM/fkosQ/0IYeXLd5vJaXSEU
 P2IlfTODnRmxc1M+tcAlhNTPSXtnC8G/6+0yMfzJ1vmIoWVgWfGu+8Kpd
 yCA8+kVhRBEaSy972SYiaRyCAFwTpQw2ERwopxrfLalNUaIY/1i2AS48A
 6oC5/MkAH2zqltozl/96y4ufVtDw4Wqd1N+JpG3io1K5R/Xa42zhbxC+6 Q==;
X-CSE-ConnectionGUID: KJ8Q7DDTQE+XxdjuoGlZxw==
X-CSE-MsgGUID: 0sd2NgXrSTyj6Kp7QYKpWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2368694"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2368694"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 12:35:59 -0800
X-CSE-ConnectionGUID: IpauYuZoQ0qwdcuo6Gjo4Q==
X-CSE-MsgGUID: dx0DLUzvSqKdBy9sFP42xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6597818"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 12:35:59 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 12:35:58 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 12:35:58 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 12:35:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbTeaJOnqkxyvxKBXF93JXzml/dz9YF0shqZzg80WbkhFIl8XgKfTQ07clbjJyX/sLILIBtNmTEPzJK1yqSH5H9Ysr7CALc7Yw8tiRifpOy1fvxwXXvrLfh9t01uCR5oLAHQoCBwRHh5aiIyuRCku0geAo2cPHp480ALJTXwX0ODOvca+f9sV1nwHyW0olWBl4lXfQuwUR+i+afsI0bUVzRGRiiZrTKf0nFJgYag5u1Ypx+wx/x/GGeFzo7CuMnv9WK50yukxWy/1oCAiQbK+WPw2oyCVHPOHBTz068HopiS5hckLmkk6wDbgSqNqb2Tw2EbzJRKg2hIBsfDI5t/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=io/q9p8RALnZpcB1YIwSvneiuHYRJoRubnD0YpcTTz4=;
 b=bzhQvsGiSTSV9NoadWPaZt6J40d+LCkR6YdpU0R3SmSE69JP3wz7baQdrwhKnFoz4coU6+doYjYPWI9lEx0S3tioqX4NZBcYO0ZFrcTEP1lhaL5qkfL6IGhw32ixUhWsa7WVFu1HO3SEaYB/TWJ1jSI7S9gWpM/hlrua4P9EhihwgghEaKjR6UQbCt3Cdr5d/lmhpqMsfoiWKluZi6qCCOlzC0Wi/sJ0bE0nZB5T6XY8htXd/Z6tnU1odoX+5SPoq2QzI7VdfDPgoO/PibNYKiAkzg6gwIcYSDDQKa4s4GwpMIoG0C+YmFoUJ7vm4GWcn91N35mwVhuM3BtAX5WqQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by SA1PR11MB7085.namprd11.prod.outlook.com (2603:10b6:806:2ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 20:35:54 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 20:35:54 +0000
Date: Tue, 3 Nov 2026 15:35:48 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Danilo Krummrich <dakr@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, <dri-devel@lists.freedesktop.org>, Mark Brown
 <broonie@kernel.org>, <linux-next@vger.kernel.org>
Subject: Re: [RFC] linux-next: replace the DRM trees with a single
 drm-for-linux-next
Message-ID: <aupFpMdhZD7vcP0b@intel.com>
References: <aujZcJBUyQ7iX_PM@intel.com>
 <CADnq5_M5SjooHDGt3T=69mTqYW0rjwM25Y8r9dgi8gDJEWYt7A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_M5SjooHDGt3T=69mTqYW0rjwM25Y8r9dgi8gDJEWYt7A@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::26) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|SA1PR11MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: fff293f5-9da7-4249-bff6-08df39ea0ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|23010399003|6133799003|18002099003|22082099003|261102123227099003|56012099006|10067099003|261009223027099003|261022115727099003|261022105027099003|261021121427099003|261021123027099003|261022075727099003|4143699003|5023799004|11063799006|261028144727099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: hk2fJJuwGj0nrxyN7yU9URrTNWTl393DWXigKCg7K0cshYNhbZCdPwWcXiQKlcqUcTn5IIXMW0B8XQw0hEGM26En3+eRTPbIEOQKy+zyWfpZSY0+1mfUwhWDiTKKL0vCU7UndjBllRRvNH70BR+Oge2KepBD1g876STu/Tv8KLMOl72XMCHErkn7e76zNpUutmQ3fw/tlmQrg0e7kjzYFlerLPweDjCNbqLr62M8VK2FNPp6j/CRmOnu/E98j7exIHGPDM4hcgutuXr7pvitZ+rhbNZSYkwswb3DWbW+EbLLqnytY6fHSebb1rgcjHSF+/dD1j+hqMyxkZLcle6wn1ge4o1kzqulQwWuxcla8nSM4Aen8l1X9f7JG1SvYkoNj7mo3OQGlQS/wTG8Mt7jey83ep1hhx7jYN1xrFzs0XHyS949fmhkR7Rc2lgxZGvfEHjl4yS5XrwdntDBUF2AN6thxcTboP2sQkcgjyeBxBUakk+6whMny9NVFn4aRSDRKk6OGe5JhvIdKeTM3ZDX+oBNLhuSx9NuVK3hNsT4U0P1/1oDaJ67UO3UIAFCz65eeMxkK9C7Td0KU2UrTofSAYNWmNRv9im/7E4kSFHoTNUk8nVBaLIXRAAnI8W+OxxC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(261102123227099003)(56012099006)(10067099003)(261009223027099003)(261022115727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(4143699003)(5023799004)(11063799006)(261028144727099003)(261026121527099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXZ0NkVDOGI3ZVFlcG12bTFTYzU1MXJXUkIvbDFKbG5sZUlNSk5zWGJXZXFt?=
 =?utf-8?B?RTVlUDJyVGtlN1dPUkhYV1hGSlQ4YW9MWDJjYmJHbC9ZL1ZqSHJ3cU9Ib2pi?=
 =?utf-8?B?THhBYXg3TXNDbU5yWWdDWDFnYlhIazM4ZkVTNVRBdk9WSEZEeWl6SDcvTEVq?=
 =?utf-8?B?NnQ3NHBhRCs3ZFp3aE5nRGQzMVkvSEtnaW9Hc3Z5ZWtOdFkxR1pDZlEyY05u?=
 =?utf-8?B?aXJIOEIyblorSmdGeWhpMHV6KzYwR2R2alJRNy82dHNVSVVha3kyeDBsZ1kz?=
 =?utf-8?B?THNkZ2NBTFZCWEhmK2JwL2RJUE5WNjRaT3dNY0swNy9uMTRKakx1LzdnbUQ2?=
 =?utf-8?B?TEJBaWUvNWFFMGlYUWRwYUozbEpnVzlOVUFSQVdhc1Vyc09lUVkxRDcveThP?=
 =?utf-8?B?RHdiRGxwOS94bkFidzh3QlMzbTlKeGNEUS9Mc3R4My90dkFrc3NnYlRSN1Ni?=
 =?utf-8?B?REtNMmlzV0hCRVltWnF2aGNuT0VZMmdLemVaNE4xRTdWcjllVHFvWWRMZXNN?=
 =?utf-8?B?SUZCcDJqWTZobFliaG53RUZ4V3ZBYnZTWmprWHRYN0pGUUkwUnlNMUNmSU43?=
 =?utf-8?B?SVFRRUJsQUp0ek1DbXNmYWRsdkZ1RVdMbXI4amRXSVFIZmdSTWJDWm02TDhJ?=
 =?utf-8?B?aWZ2VVc1ZmJ2bUVqOXJpOUJsV2piZlBZQ2dEdW1ORVVaS0tlSGFUbnRLckJY?=
 =?utf-8?B?cmcwdnNuVFd6bXhJWkdSTVNkUXlIQUtxVXVuMTFHdnFQaE91SkNKRlo0VVJh?=
 =?utf-8?B?VUxuS2xMamFLSzhnYjlmVU9JZmY0dnFDM3VKcDlWbGtrTHd3WkZOY082cmRk?=
 =?utf-8?B?d2M4dzlYdmgwRHliWWZpRnM4NTJuYXNCSm8zd1RrZmJiR3dxaWJpWkNieFFO?=
 =?utf-8?B?YnZic01nUXdmU2MxaXorZWdIeS9pcHp2azVURllPY3ZvMU5wL3Q4bUYweEVl?=
 =?utf-8?B?ZGh1YzVuZFVDdHdYYnZBTkJBbGw5Q3U3ZldhSjAraHZ4d3hOT3ZoNmoxNlF1?=
 =?utf-8?B?MVp4VDhnekc5V210VFUvak5Ua2t6enBpaVdPU1I5UTFxM2k1WjhzWU1kcUg0?=
 =?utf-8?B?eVdHalZzZHZaUks5aWRXVTZqeFVSV0UwU1c1Y0VJUXQzZWNaelF0dTJ1YmdP?=
 =?utf-8?B?bHJGZHhyV3VtWVFsVEIwMzRPSFVtamVQU290L3JVV2xmRm9EUlhDOEJlc1VR?=
 =?utf-8?B?TjQ4ZllNMmQ0RjJhTVhOS0lqb2c2elg5TWtySi9heVNUMlIwaFl3bWovMUs2?=
 =?utf-8?B?SnI1WGQ5aGVXdW10VDNSVS9TcDU4eXpyWm40b2MvMUNvWUQrajF5VE92UXRu?=
 =?utf-8?B?Ny9va1hnQVBmVDJDdFdUZVBUT2ZXSFVLeFVteWZZTU5nSHlUc1g5aFNZak5E?=
 =?utf-8?B?b2VZQ3RBek4vQUtSaVpFWkwvRkxmNHpPK1lrQWk4eTNCYjY3L2kzV3lpYmJ2?=
 =?utf-8?B?endQV3ptVUJQU2RoS1dtUHQwN05WWENMVXNYVExBSEZ0aEJJa1lIUFdjb1Fa?=
 =?utf-8?B?ZWxlb090TnpmNHVqTjhPVnVxTUtHdWpBWm94bFF5Qi9vZStLanN6bFlNdEJa?=
 =?utf-8?B?V1hDUTJFY2tsYlh0VkQzaDQ5NlJrdnpsUmVTRXJ1eHhnYXQvVWVKMldQc0Nr?=
 =?utf-8?B?bldEOVhrS3JlYldCTWpITWtiQnI0Y29vdlBVeHJvNFZ2cEtsNFlzOWVnRmJo?=
 =?utf-8?B?WGFiMkdmQUhQT1lWbW9Hd2JkTWlncWlGZFBsRnVYZHZ6MHcwZjQ5VitTa0Ju?=
 =?utf-8?B?Z0FobFRXeTYzRVRmcnJIazF1THJ5OXpPTUs2bDA5eTFsOVA1eUhvU3lUQ0Ur?=
 =?utf-8?B?ekNpcXp6UDljNzZjb3c5a1J0dFlBNWhuMmd3VGd1RDdvV1ZvTUdYR0xYeURk?=
 =?utf-8?B?R3VtVGhKa2JoeEpocmlEWEdHMGllZVJHZXBrUGRQWmpHaUs5SFAza2ZBYWZW?=
 =?utf-8?B?cFdHczdSNWVua1VaVjZLanJjVU9NSlMvUk82Rk5MMC81bFFxTFNkSnBCMWFD?=
 =?utf-8?B?YThiUWMzYXNpNVIvbVBIcWIxOVNTdFZBTVZKWDhUZ3RLL3R2cDZhUVprT1lP?=
 =?utf-8?B?NDFEVTBiMFhsN1JXaFNra0w2YU5VM3RRUVp4dVZVdmZKQ2hKckdsajZleVVI?=
 =?utf-8?B?RkxOUmtLcSs1bHVLVkFucHgraDNJcHo2V2FJMElqSjdZcXBCaTN1eGFWSlRI?=
 =?utf-8?B?S1ZtRWo3YXBLZWt4Vmc5N0MvUklZcDVKRzU1NklNVXc4MHdSMzN6VUdpV2Fn?=
 =?utf-8?B?dCtobFNuaGVURlpORzI0UDcrVVhEVWx5b2VoM0dBTGN2bXNSVXZ6THVqMkRF?=
 =?utf-8?B?U2dqS202MEdKcjMvVU1NTVFoTlZXKzFrb1FaT0sxVDNucElZUFg2UT09?=
X-Exchange-RoutingPolicyChecked: rMfsIV6msjII3AKB+ZBvki80PDpMRM0GQA5xd+hoHRM6mB1J4C94NXgJw+j57WOF1DjQ6rjZzIQjEPwsf9JJruw4hFiltU8T8f/78iIPrQmmViGkJjvKzDgvIkGad8iNUG42U70dXE4zvxiyMXhLZShQ0twsxCWnAmONSvWik7tIUvsULrl8LDrJ2WcMnsscNuHJRS2Sl9l9SMcRJHGyyl4mvbVOUAZpLz+C2GJhsmh4UGRv9PUl9l6dsXV+gU4pc0tXa3xOxzM9ION7ejfu8gN2kOveWqtPaxTp+tA/qL8Un8lw9GCiKT87+Ogvvk4p+Kus9aufcCi8uOMObnIFBw==
X-MS-Exchange-CrossTenant-Network-Message-Id: fff293f5-9da7-4249-bff6-08df39ea0ea9
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 20:35:54.3233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lQC4KC3DJdyVsZSZ85nFsF045yiLOF3ztR3yVCtCKgFsBHS6beP0J/bn034OMrCcVeg2F0FQXltNlbHDx4Ytw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7085
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 06:07:15PM -0500, Alex Deucher wrote:
> On Mon, Nov 2, 2026 at 1:51 PM Rodrigo Vivi <rodrigo.vivi@intel.com> wrote:
> >
> > Hi folks,
> >
> > We'd like to replace most of the DRM trees in linux-next with a single
> > branch:
> >
> >   https://gitlab.freedesktop.org/drm/tip.git#drm-for-linux-next
> >
> > It replaces these entries:
> >
> >   drm/drm-next, drm/drm-fixes
> >   drm-misc/for-linux-next, drm-misc/for-linux-next-fixes
> >   drm-intel/for-linux-next, drm-intel/for-linux-next-fixes
> >   drm-xe/drm-xe-next
> >   drm-rust/for-linux-next, drm-rust/for-linux-next-fixes
> >   amdgpu (agd5f/linux.git#drm-next)
> >
> > drm-exynos, drm-msm, drm-msm-fixes, drm-msm-lumag, drm-nova and etnaviv
> > are not part of it and stay as they are.
> >
> > The main reason is to reduce the conflict pain that Mark constantly faces.
> > All of them should be handled already when we are rebuilding drm-tip.
> >
> > During this work, I realized that drm-xe is a big culprit for leaking
> > future work without a blackout date from -rc6 to <next>-rc1.
> > So, another quick solution would be to get a drm-xe for-linux-next like
> > the other domains are doing. However, I still believe that this unified
> > one will make Mark's life much easier anyway.
> >
> > The unified branch is rebuilt by dim together with drm-tip. It has all the DRM
> > -fixes, drm-next, -next-fixes and driver -next branches merged, with
> > the conflicts between them already resolved on our side. From -rc6
> > until -rc1 (per Linus' tree) the driver -next branches are left out, so
> > nothing for the following merge window lands early.
> >
> > It contains the DRM fixes too, so it would go where "drm" is today.
> >
> > During the past weeks I have confirmed that the drm blackout period
> > works well on this new branch.
> >
> > The dim changes:
> >
> >   d875049d2b29 dim: build a unified drm-for-linux-next branch
> >   3009867cd318 dim: keep -next branches out of drm-for-linux-next during the freeze
> >   https://gitlab.freedesktop.org/drm/maintainer-tools/-/commits/master
> >
> > AMD:
> > Alex, Christian: linux-next takes amdgpu from
> > agd5f/linux.git#drm-next today, which differs from drm-amdgpu-next in
> > drm-tip. Is drm-amdgpu-next fine for linux-next?
> 
> They should be the same.  I just mirror drm-amdgpu-next to
> agd5f/linux.git#drm-next in case anyone is still looking there.

That's fine. But please let us know your thoughts on either going with
this approach proposed here or with the other approach proposed by
Danilo, where we in xe and you would need to create a for-linux-next
and for-linux-next-fixes.

Both xe and amd are leaking next.next patches into linux-next right now.
And we definitely need to stop that.

Thanks,
Rodrigo.

> 
> Alex
> 
> >
> > All other maintainers, please ack if you are okay with this approach.
> >
> > Mark, you're in Cc for visibility only. Once we have all the acks, I'll
> > send you the formal request. After linux-next switches, we stop
> > updating the old for-linux-next* branches (patch below).
> >
> > Thanks,
> > Rodrigo.
> >
> > ---
> > dim: stop updating the per-repo for-linux-next branches
> >
> > linux-next now pulls the unified drm-for-linux-next branch instead.
> >
> > Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > ---
> >  dim | 53 -----------------------------------------------------
> >  1 file changed, 53 deletions(-)
> >
> > diff --git a/dim b/dim
> > index e3f616b..b3ed8f7 100755
> > --- a/dim
> > +++ b/dim
> > @@ -658,52 +658,6 @@ function dim_range_diff
> >         fi
> >  }
> >
> > -# update for-linux-next* branches
> > -function update_linux_next # branch next next-fixes fixes [for-linux-next] [for-linux-next-fixes]
> > -{
> > -       local branch linux_next linux_next_fixes linux_fixes for_linux_next for_linux_next_fixes repo remote
> > -
> > -       cd $DIM_PREFIX/drm-tip
> > -       branch=$1
> > -       linux_next=$2
> > -       linux_next_fixes=$3
> > -       linux_fixes=$4
> > -       for_linux_next=${5:-for-linux-next}
> > -       for_linux_next_fixes=${6:-for-linux-next-fixes}
> > -
> > -       repo=$(branch_to_repo $branch)
> > -
> > -       if [[ $repo != $(branch_to_repo $linux_next) ]] ; then
> > -               return
> > -       fi
> > -
> > -       remote=$(repo_to_remote $repo)
> > -
> > -       git_fetch_helper $remote
> > -
> > -       if [ -n "$for_linux_next_fixes" ] ; then
> > -               echo -n "Pushing $linux_fixes to $for_linux_next_fixes... "
> > -               git_push $remote +$remote/$linux_fixes:$for_linux_next_fixes
> > -               echo "$DONE_OR_SKIP"
> > -       fi
> > -
> > -       if git merge-base --is-ancestor $remote/$linux_next_fixes $remote/$linux_fixes ; then
> > -               # -fixes has caught up to dinf, i.e. we're out of the merge
> > -               # window. Push the next queue.
> > -               echo -n "Out of merge window. Pushing $linux_next to $for_linux_next... "
> > -               git_push $remote +$remote/$linux_next:$for_linux_next
> > -               echo "$DONE_OR_SKIP"
> > -       else
> > -               # dinf is ahead of -fixes, i.e. drm-next has already closed for
> > -               # the next merge window and we've started to gather new fixes
> > -               # for the current -next cycle. Push dinf
> > -
> > -               echo -n "Pushing $linux_next_fixes to $for_linux_next... "
> > -               git_push $remote +$remote/$linux_next_fixes:$for_linux_next
> > -               echo "$DONE_OR_SKIP"
> > -       fi
> > -}
> > -
> >  function check_conflicts # tree
> >  {
> >         if git diff | grep -q '\(<<<<<<<\|=======\|>>>>>>>\||||||||\)' ; then
> > @@ -1192,13 +1146,6 @@ function dim_push_branch
> >
> >         git_push $remote $branch "$@"
> >
> > -       update_linux_next $branch drm-intel-next drm-intel-next-fixes drm-intel-fixes
> > -       update_linux_next $branch drm-intel-gt-next drm-intel-next-fixes drm-intel-fixes \
> > -               for-linux-next-gt "" # no for-linux-next-gt-fixes for now
> > -       update_linux_next $branch drm-misc-next drm-misc-next-fixes drm-misc-fixes
> > -       update_linux_next $branch drm-rust-next drm-rust-next-fixes drm-rust-fixes
> > -       update_linux_next $branch drm-amd-next drm-amd-next-fixes drm-amd-fixes
> > -
> >         dim_rebuild_tip
> >  }
> >
