Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED39B606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C/Z+xu/R;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=I6F4THO6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A08710E590;
	Thu, 19 Nov 2026 19:15:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82B2910E590;
 Thu, 19 Nov 2026 19:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795115690; x=1826651690;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=0wNo0/ArTw1kQSeFNrxvuUycnnh+NSRnoejSHxmKKvc=;
 b=C/Z+xu/RzF3RyHcVlAQkrR9UxSnZ9H/ZVk4YpBWKD48UrSuHRXUg8npz
 NOFjOxDIy49hMIZIsLXO3DoQB+uC7h0YYiJf+3lt5iPyQIeXOdALNJxKk
 EHqnN6KMsCMSNrN3izhJYZN94xmPLBathtFydkRQaMKOa0Qy6AacNXVtP
 X7MhRTpluDOz0C/tusEt2D1P+6A0RbYmSiLy8l/JeWmqCI5ytTkkRiCx1
 hqISZgY2tsFdSf7INSM1ImPP9aMAvptmlh5QpC7hnXUvZYpUcqvARM7mp
 CIxVir+9iE5gU33MN8XwhnvnbsX2fxmG1pDcmGTUYEeF6jSnV/+004SG2 Q==;
X-CSE-ConnectionGUID: 1kw9/rRrQtqzncJvwXB/7w==
X-CSE-MsgGUID: HsspkRHVRfu3Z+Yxi8JGXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3896984"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3896984"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 11:14:50 -0800
X-CSE-ConnectionGUID: T0ArPD/gSrmdm9Dg7IPIeQ==
X-CSE-MsgGUID: JO87BK64QxGkfH4YwyhyfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10408365"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 11:14:50 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 11:14:49 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 11:14:49 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 11:14:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2u7CmIlNeYtrn/I11E23kAq76QYpTNVkt2jHp3NXkzh9YCYbgcwB+RlYsf/znjALvmyUKGqkDdICqYnG92cLfDec6ogLRrTaNTuYyJjwSNR0MA6vISuXKZHrOnKAM2iavEt7IifrQc9BpfkBJvBAsqJQlzQ1QDhb/riK8vXlHfRox9i0EkrFNh77BsLBoXO5g4mTgF/2VFNgS0nVgV30gyxMKIkSTeGGuERa8wYG3xGHKRKK15B4aOzz4q65tjBBE2Q1G6s4Y+SncD0qSK1GEdzdrtaRSM+M62XO1h99oG9p4WlNmN6ZjUJsQEo9aycYZ05H1f43/xWgDMk+Zv4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5D64h+tNmX8hOVStg6GVCQ84nB9MFTsSfqg6ocyADhk=;
 b=MsEh1/KYNaBO9dINRuchr9iBFa5Rham6UhU9iGEBNF2z6rFFY/ytlcvLB4C+NlSzaNylnm3EkbhF8g8AMDrkR6ZrGIQWFcgraKpNS+8ORXyQFGQlKpwPPhv9FN0M4qF40ktdMXVgw6CBLcKy8ab7bEObMWH6Kp0R6X1GEAARvq4ihCiuikfK0BlF2+6KAKhFNQ5P/izlorko1OzkyE87qB+74B0+A5LXyZuwX4aH6r8Nsrg3UE3zNdhAyBWahGXQ3D6q1qtdlEfMXpMvWaSAlTRpi+C71toZ4astgZBbhwylp/Fp6BSSFafA5grU2kWb6e+XG7npiMQvF8uaLu9Z6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5D64h+tNmX8hOVStg6GVCQ84nB9MFTsSfqg6ocyADhk=;
 b=I6F4THO6dATBQXBPxzV+aEXFRPG8NEhadwmgVBDsZYQw6i6Cn+sFqEb470VjyhFRZOmaKG9ou1R4ZD9zfYNYbrtIFZZXK9z1O2VdqAlZapcRXvSmD7AwrSyRJwgNFVm2YKoDqQ/7vcqU0ld5GINAyliVigwaI2YgcZSvDjO0/bs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by CO1PR11MB5185.namprd11.prod.outlook.com (2603:10b6:303:6e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 19 Nov
 2026 19:14:46 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 19:14:46 +0000
Date: Thu, 19 Nov 2026 11:14:41 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 04/33] drm/ttm: Introduce ttm_pool_alloc_iter for
 __ttm_pool_alloc()
Message-ID: <av9KoYw5cSdTfO8x@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-5-matthew.brost@intel.com>
 <au091GIzweGostC0@nvishwa1-desk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <au091GIzweGostC0@nvishwa1-desk>
X-ClientProxiedBy: BN9PR03CA0757.namprd03.prod.outlook.com
 (2603:10b6:408:13a::12) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|CO1PR11MB5185:EE_
X-MS-Office365-Filtering-Correlation-Id: 49fe5c76-0426-4da7-ed84-08df46715fd0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|261022075727099003|261021123027099003|10067099003|261021121427099003|56012099006|4143699003|11063799006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261102123227099003|261009221227099003|261009223327099003|261009223027099003|261009220027099003|261009221727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Z0+wG/FmxQ+02HnRJkbeoUK2W4BrEOukT+cHehv/ZZCOHprOPQo6jFbgM7jjMU1l6zNhLK5EXnmhxDn5hTkEIdhnhFTXWmL0kdIco75WFAloy7bv8gbos39XoaWW8ZZffsXlVe0Abvsw7/HhtIsj1kSGakQbpElTNT7mtHn54UoJUqQ3/qNqnFfvjfeqEBiWOKy78ngUkJAm7zrxz0sz1NEia+C6L+PW5Uk1hJq2tkOKuY9yemJZRJWKgj+QQrHUWL5Sp4ZY/blPwi4qU5MR07ZUrD0ZLs5T5JrWy0DWpccGh8QnBMmMPXFoiXiMjzJNemm0iUng9R1OciHCFBpP2Q5HNFv7VfA0qPXfQzA2ohaiSi6Co9Ka3pQqcA/UG67JxhTh0lzgJJUNHTuQOWQ3W93nPxUlT1R2cdcvhESOhoNUWk60m7f4e5SWieHZTcBgYLcPcv7pPXQbK239rdbZZJEqvIC4CnHS3wpybIhn5SecJXAB7PA7i8CSlNIcGNblJL+03eVZU6ERRh73sRxvWsAhgkcFbbxY02D7gc0FonqWGxsaQPFjn1USBAtnevxID45L/EqgJiSVSDgp/+TQWwo7XFETVc+264lHMM2u9h5z/5NZw+6ROl0CxD+zx+vWD2MlpVPiuwRQmVHbJtTy8qbOA7dth7oK4qHgXxbG23M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(261022075727099003)(261021123027099003)(10067099003)(261021121427099003)(56012099006)(4143699003)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261102123227099003)(261009221227099003)(261009223327099003)(261009223027099003)(261009220027099003)(261009221727099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3OIpAF0QmQe1Dqt3qPwhjeUVEGzqupfGOnN6hIkrRCWYAq5sVBvw11WpEF?=
 =?iso-8859-1?Q?67E0hWk8lGQw0Di6UgYEaRLoLc3idQxfYmaO7o4uAb6I+F/fdz/FEC7mjJ?=
 =?iso-8859-1?Q?Lhn19Kh4Avjl0DTu44USyQV5P7nFaZUV91UDS87f9cKilSueUmbiRnLqg2?=
 =?iso-8859-1?Q?jSUd4I3i3xIg8c9t2ac6qaMxVDEc+748c0tVRqy26vhAhBcAd3VUUiMI8I?=
 =?iso-8859-1?Q?Ct0/gt5pk0uvo8hwg4WGqZgIFufGqZc0lU6pAfPl2lWxUw33qTKelSTWDH?=
 =?iso-8859-1?Q?3hrWAE6UwDriSXdU8BX6PhOlLMwts4gVzf7L9JlsxNrta40YU9UIOHMe1f?=
 =?iso-8859-1?Q?1Qruxm2mfN2nIUBzltxxgPixp+O3Krkznx4Eyiy9U1qERvPEW93u9z+juZ?=
 =?iso-8859-1?Q?WbjO6VwRDEqtKvzggZEZ72QUCFjteVx3CCr6WJtecnGOjIpb6Yg73yvUec?=
 =?iso-8859-1?Q?z/0vJrAfXOk7uJOJSpKRsXpo3GoaPAViAgk0sTojZimtGc+b2WTRXhetQG?=
 =?iso-8859-1?Q?4xkne+ns0I9vwUaS0hHF0XkXOQe3dTJxiLOLUxzh6jnIRjP15+sgan1VvC?=
 =?iso-8859-1?Q?q6dcMbdjxEuSFiZszUWC2U2279Qi/Y5wzKOJtUg/anDV3qlZzA/Lv0yOyI?=
 =?iso-8859-1?Q?musIgqddhllLeIRoG6YK+PgZmKuUH0oVbtoRFQiuZ/FQ0PyKn4TXBRM7Mo?=
 =?iso-8859-1?Q?iaGlL9vYUkJdPnoQ8Uu2B6drhC9NcFC9Ib3nrbic+MLwkwz5Yg7t638hYu?=
 =?iso-8859-1?Q?4f/3mQYQ9OT1VM3d0Bc9Kg20D/gf2txeNqOJo7ItvUpwtCKw/Hv+n3xtu3?=
 =?iso-8859-1?Q?MFD275hzWyRz0Us+pkkQVTgDuXN8zuhgutXZYXcuObUZ6fcVyI1iJDO6Fa?=
 =?iso-8859-1?Q?ESXlbQjxMydTgPHY+3rebibqZMmU9INvNViul7Uz9FaQ032UjLVMx3sfxS?=
 =?iso-8859-1?Q?nq/WvM68cyKiFIWbJCR5RqyTKTdlV2FLjQp/lzNf0w1Pe4MS/LzIij9ag6?=
 =?iso-8859-1?Q?jRCnLK0n3iosD5qVzaUG48jFABXFLUzsxHOGkh9hrHFlPWZWOuGJ43NoJw?=
 =?iso-8859-1?Q?rY+Dkd4MqlCNIL3p8nD/cx933EODAMi1HTSRDFVBOzPvfZ0S+Oq2mcv1AG?=
 =?iso-8859-1?Q?9StqRyaEgUAJsm/xdPILk+zVO1Y4ugApddR5UjzxVQk7RX9mkc48207d2z?=
 =?iso-8859-1?Q?GD+aQAk3bphASMx9DXjGCBp2wOAWVYK5tG6J2KEd/yoQhzMNpZkZOeXQ67?=
 =?iso-8859-1?Q?/K9ET2WKC95pGW2mpsD40HJjlFhvqHSHPa4Q0NLLuvdzu15EAYb02pj1kP?=
 =?iso-8859-1?Q?5o5/8HJ4ucdcHLJo1pORfoZgii/xheog7pxUHirZa/A9wkE58F2EjDoW6/?=
 =?iso-8859-1?Q?S0XcDi09FMk57MN4vEXfLQY55MIyse84fjykdySLK2PAYXBPXDluwaZLP8?=
 =?iso-8859-1?Q?scVS1KBDwDL5sPDqPo242gAWhnqCcwC1OHSgMnixnF4HiRgQDaFRdBDURl?=
 =?iso-8859-1?Q?MdebrlOvWhClu3NORiInjdOoqiM0GO8Nx1ujJOmneaPR8ckg6KJGAA1Qqo?=
 =?iso-8859-1?Q?B3MSxSxNN5ThhJkwP7iUt7i+r4Cb8HtkDac8vL41K7MUioyS/XuAIJp0h6?=
 =?iso-8859-1?Q?IJTARe7/8Mz+y76NU3z0OU0Bh2J8m7S5KOc4D8u3vGxuoyFHEFOK9KSv94?=
 =?iso-8859-1?Q?HeHrjrL6TtpmWFvy5lY7zzsTkU1/IUstbrTiqMeYI4L79b4YKoo4o8k8OZ?=
 =?iso-8859-1?Q?pcsfFaQd/dO/AubpY+IA1e8vmOFUpp2VjxhIWMsyppRp08EkFnHvBdzfoa?=
 =?iso-8859-1?Q?V68ju+2LYg=3D=3D?=
X-Exchange-RoutingPolicyChecked: H3tLvnfUXb3EnnVBpYPQRKCtXiLhEMG4qWcLml6XtyKDCNEffN/waRoHYaegup+iuMN63TYodk9+OhCE79UCMqUiSB1tdYBnHj5VcpPxZae0q58hyPc2icBLA+EZ3TXfk3/5ETakXJVdB2EPbgWKRszEe1DorneRhgXGz6umukVG4nlkv68kR0ZeRneYYovnQbPXLsNm3hkNXy9L49RoTKElsk1kNG2JRXU56MftEk2ySHvBnMcsCZ5Zur+zUlyymEwZBIu3GyJMdH4X++7rUKTT8WvT0czoUs7BOi102dEK3YNi7rT6IrL20VZJjsZy+f5IDv59wHPtjQ3+m0WvXg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fe5c76-0426-4da7-ed84-08df46715fd0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 19:14:46.5247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKnHXliZPvsegmf6H/1faDEgw+5DWiB06RWfuoQpMgEizNVRMaAM1agWVhtmUOL2h/pEzcwFnk9Xnj7v+ia9gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5185
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 06:39:16PM -0800, Niranjana Vishwanathapura wrote:
> On Fri, Jul 10, 2026 at 07:55:50PM -0700, Matthew Brost wrote:
> > __ttm_pool_alloc() walks the page orders in a single loop whose body is
> > about to grow several defragmentation phases (reusing old pages, a move
> > budget, out-of-lock preallocation and fault injection). Left inline these
> > interleave into one deeply nested block of gotos and combinatorial
> > conditionals that is hard to follow and extend.
> > 
> > Factor the loop's working state into a struct ttm_pool_alloc_iter and
> > pull the per-order page acquisition and order-fallback into small phase
> > helpers, so the main loop reads as a short sequence of named steps. This
> > is a pure refactor with no functional change; subsequent patches extend
> > the iterator with their defrag phases rather than nesting more logic into
> > the loop.
> > 
> > Cc: Carlos Santa <carlos.santa@intel.com>
> > Cc: Ryan Neph <ryanneph@google.com>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Assisted-by: GitHub_Copilot:claude-opus-4.8
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> > drivers/gpu/drm/ttm/ttm_pool.c | 159 ++++++++++++++++++++++-----------
> > 1 file changed, 106 insertions(+), 53 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> > index e9175c0290d7..0ca63f5ce73c 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -791,18 +791,102 @@ static unsigned int ttm_pool_alloc_find_order(unsigned int highest,
> > 	return min_t(unsigned int, highest, __fls(alloc->remaining_pages));
> > }
> > 
> > +/**
> > + * struct ttm_pool_alloc_iter - Working state for the __ttm_pool_alloc() loop
> > + *
> > + * Bundles the immutable inputs and the mutable per-order state that the
> > + * allocation phase helpers share, so the main loop reads as a short sequence
> > + * of named phases rather than one deeply nested block.
> > + */
> > +struct ttm_pool_alloc_iter {
> > +	/* Immutable for the duration of the allocation. */
> > +	struct ttm_pool *pool;
> > +	struct ttm_tt *tt;
> > +	const struct ttm_operation_ctx *ctx;
> > +	struct ttm_pool_alloc_state *alloc;
> > +	struct ttm_pool_tt_restore *restore;
> > +	unsigned int beneficial_order;
> > +	gfp_t gfp_flags;
> > +
> > +	/* Mutated as the loop walks the orders. */
> > +	unsigned int order;
> > +	enum ttm_caching page_caching;
> > +	bool allow_pools;
> > +	struct page *p;
> > +};
> > +
> > +/*
> > + * Acquire a single page for the current order, leaving it in @it->p (NULL on
> > + * failure). Tries a same-order pool page, then a fresh system allocation.
> > + */
> > +static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
> > +{
> > +	struct ttm_pool_type *pt;
> > +
> > +	/* First, try to allocate a page from a pool if one exists. */
> > +	it->p = NULL;
> 
> NIT...Looks bit odd to set this to NULL here and check for '!ti->p' below.
> But I see subsequent patches add more code here, probably should be fine
> or add a temporary comment until then.
> 

I'm not a huge fan of temporary comments and the structure does make
more sense in subsequent patches.

> > +	pt = ttm_pool_select_type(it->pool, it->page_caching, it->order);
> > +	if (!it->p && pt && it->allow_pools)
> > +		it->p = ttm_pool_type_take(pt, ttm_pool_nid(it->pool));
> > +
> > +	/*
> > +	 * If that fails or previously failed, allocate from system. Note that
> > +	 * this also disallows additional pool allocations using write-back
> > +	 * cached pools of the same order.
> > +	 */
> > +	if (!it->p) {
> > +		it->page_caching = ttm_cached;
> > +		it->allow_pools = false;
> > +		it->p = ttm_pool_alloc_page(it->pool, it->gfp_flags, it->order,
> > +					    it->ctx->beneficial_reclaim_backoff);
> > +	}
> > +}
> > +
> > +/*
> > + * The current order could not be satisfied. Lower it and retry, recording a
> > + * sub-optimal backing (so the driver can later re-defrag) when we drop below
> > + * the beneficial order.
> > + *
> > + * Returns 0 to retry the (lowered) order, or a negative errno.
> > + */
> > +static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
> > +{
> > +	if (!it->order)
> > +		return -ENOMEM;
> > +
> > +	/*
> > +	 * Failing to allocate at the device's beneficial order means we are
> > +	 * about to back this object with a sub-optimal (smaller order) set of
> > +	 * pages. Record it so the driver can later try to defragment the object
> > +	 * back to beneficial order.
> > +	 */
> > +	if (it->beneficial_order && it->order == it->beneficial_order)
> > +		it->tt->page_flags |= TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
> > +
> > +	it->order--;
> > +	it->page_caching = it->tt->caching;
> > +	it->allow_pools = true;
> > +
> > +	return 0;
> > +}
> > +
> > static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > 			    const struct ttm_operation_ctx *ctx,
> > 			    struct ttm_pool_alloc_state *alloc,
> > 			    struct ttm_pool_tt_restore *restore)
> > {
> > -	const unsigned int beneficial_order = ttm_pool_beneficial_order(pool);
> > -	enum ttm_caching page_caching;
> > +	struct ttm_pool_alloc_iter it = {
> > +		.pool = pool,
> > +		.tt = tt,
> > +		.ctx = ctx,
> > +		.alloc = alloc,
> > +		.restore = restore,
> > +		.beneficial_order = ttm_pool_beneficial_order(pool),
> > +		.page_caching = tt->caching,
> > +		.allow_pools = true,
> > +	};
> > 	gfp_t gfp_flags = GFP_USER;
> > 	pgoff_t caching_divide;
> > -	unsigned int order;
> > -	bool allow_pools;
> > -	struct page *p;
> > 	int r;
> > 
> > 	WARN_ON(!alloc->remaining_pages || ttm_tt_is_populated(tt));
> > @@ -819,59 +903,28 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > 	else
> > 		gfp_flags |= GFP_HIGHUSER;
> > 
> > -	page_caching = tt->caching;
> > -	allow_pools = true;
> > -	for (order = ttm_pool_alloc_find_order(MAX_PAGE_ORDER, alloc);
> > +	it.gfp_flags = gfp_flags;
> > +
> > +	for (it.order = ttm_pool_alloc_find_order(MAX_PAGE_ORDER, alloc);
> > 	     alloc->remaining_pages;
> > -	     order = ttm_pool_alloc_find_order(order, alloc)) {
> > -		struct ttm_pool_type *pt;
> > -
> > -		/* First, try to allocate a page from a pool if one exists. */
> > -		p = NULL;
> > -		pt = ttm_pool_select_type(pool, page_caching, order);
> > -		if (pt && allow_pools)
> > -			p = ttm_pool_type_take(pt, ttm_pool_nid(pool));
> > -
> > -		/*
> > -		 * If that fails or previously failed, allocate from system.
> > -		 * Note that this also disallows additional pool allocations using
> > -		 * write-back cached pools of the same order. Consider removing
> > -		 * that behaviour.
> > -		 */
> > -		if (!p) {
> > -			page_caching = ttm_cached;
> > -			allow_pools = false;
> > -			p = ttm_pool_alloc_page(pool, gfp_flags, order,
> > -						ctx->beneficial_reclaim_backoff);
> > -		}
> > -		/* If that fails, lower the order if possible and retry. */
> > -		if (!p) {
> > -			if (order) {
> > -				/*
> > -				 * Failing to allocate at the device's beneficial
> > -				 * order means we are about to back this object
> > -				 * with a sub-optimal (smaller order) set of
> > -				 * pages. Record it so the driver can later try to
> > -				 * defragment the object back to beneficial order.
> > -				 */
> > -				if (beneficial_order && order == beneficial_order)
> > -					tt->page_flags |=
> > -						TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
> > -				--order;
> > -				page_caching = tt->caching;
> > -				allow_pools = true;
> > -				continue;
> > -			}
> > -			r = -ENOMEM;
> > -			goto error_free_all;
> > +	     it.order = ttm_pool_alloc_find_order(it.order, alloc)) {
> > +		/* Acquire a page (pool / system) for this order. */
> > +		ttm_pool_iter_acquire_page(&it);
> > +		if (!it.p) {
> > +			r = ttm_pool_iter_lower_order(&it);
> > +			if (r)
> > +				goto error_free_all;
> > +			continue;
> > 		}
> > -		r = ttm_pool_page_allocated(pool, order, p, page_caching, alloc,
> > -					    restore);
> > +
> > +		r = ttm_pool_page_allocated(pool, it.order, it.p,
> > +					    it.page_caching, alloc, restore);
> 
> Looks like iterator has a 'restore' field that gets set, but it is not used here
> or in other places. Is that intended?
> 

It is not intended. 'restore' should be not be in the iterator as it is
unused. Will remove.

Matt

> Other than above comments, the patch LGTM, though need to look into other patches
> in this series which makes use of this iterator.
> 
> Niranjana
> 
> > 		if (r)
> > 			goto error_free_page;
> > 
> > 		if (ttm_pool_restore_valid(restore)) {
> > -			r = ttm_pool_restore_commit(restore, tt->backup, ctx, alloc);
> > +			r = ttm_pool_restore_commit(restore, tt->backup, ctx,
> > +						    alloc);
> > 			if (r)
> > 				goto error_free_all;
> > 		}
> > @@ -887,7 +940,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > 	return 0;
> > 
> > error_free_page:
> > -	ttm_pool_free_page(pool, page_caching, order, p, false);
> > +	ttm_pool_free_page(pool, it.page_caching, it.order, it.p, false);
> > 
> > error_free_all:
> > 	if (tt->restore)
> > -- 
> > 2.34.1
> > 
