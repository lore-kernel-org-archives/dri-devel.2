Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A32BC4451B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95C9D10E714;
	Mon, 20 Jul 2026 08:25:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Jry67mkW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A46410E0AD;
 Mon, 20 Jul 2026 08:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784535929; x=1816071929;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=aDNfTGxDPVW4wzklSm/qwJd8kRo7WrKKnReC96DdMNw=;
 b=Jry67mkWi56OkyAtvzTcX26OfAkVNqFsPMA2pa8nVp5Oogx04VR7s1n8
 b7EZSIz7AxRHS7iX7B0yUzqd98ZK2W8HodwtiLX7eMtZhOs3g4+J527k6
 n8zfec30lZC1IA3vKT8jynV4FTijydiEjOZDX08F/zAY6rDJJGP4vzK/W
 Y+ukLhRhi5qnvbnzD7D5LGEGOREHO2urSDPm/Bb3nkG7HRYKiIiz6szFg
 D/XWnxAV4YqnuGx2paQ951QGi3c1/g5FOxlxS6vd6agOiyC8gpsyzI4z9
 Alg38O+oqCgnlXfMUVomuncpdQ+OQaTOtK/hW/P3+pMb1jzrjXmzdrjSJ A==;
X-CSE-ConnectionGUID: RUr0VlriTwKrECv8r/N58Q==
X-CSE-MsgGUID: zXrtFentRzGH1y/CF1cuNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85228826"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="85228826"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 01:25:28 -0700
X-CSE-ConnectionGUID: f8xTMp9XRa65vi0mj7ACOQ==
X-CSE-MsgGUID: GKYlr79pRdGWykf83HlnYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="258035264"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 01:25:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 01:25:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 01:25:28 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 01:25:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzDKx4fv2ip2n3Wh4cwfdJpVGUUskjSptChKFuu1swvfe8L9yymK6Rf2ycnaZ3+8sAXSOWg0bJMclvf/DPVBz3fxdATJdvPyNStGrIXI/rcuuznWfJcvBhFJ4U3IUqwn7/olVe7XNfBzXcpoV5czS6hexrwhXZ/lc3Qznjz6YFN+wxO+hSrj1DxGZoCdF/TDa4DS0wsAP0M3dCPwHL0Lg8jqLpKC9VP/vpBybA5IcLyD5dsuQ53A61r8nuUh39FibPcX0Jq6t1DbFCFqMmgLt0A26J00LIUyKpmyDm7sMypLHuATmKIPYO5fXP0zcbOlH5lQE1Ts2nsLeN85UqIqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qIyy3u0ERraKSzRPCoKoXHJd40IFQvEelLfy6GYzJ8=;
 b=BCyx51UcYEKsX2rzjj+Jlh0AwF2VPfdockaFJ/sxFBKH+9Qf51+mEgWZzpQ++UqGStBE3E8mq2OZ+YftipLsv0o6nE5k/mla5XVirwDVPRbOntHTvtb5ecNifUxbJj6ng2ELfVHnUHakDBOkZ1HaO3Xyzdd4CWgq4Ty8Xo6HVZiKml3aAeMGECD74VAJp1JdT0e2hdOwg8CYxcX2d5OYTWQ0ga3hG3Mojmz+HZlHpRwJ0nt0KlRDiaA0UBh2ktC1YtaXgf5SiLs0P7UdGtXu3vULd2ueRcf5ObeBzvef2WsGU0xMCBp6lIMK20GPJCvaSK6YxGWirFEP5pdBG4AQ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by DM4PR11MB6214.namprd11.prod.outlook.com (2603:10b6:8:ac::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.16; Mon, 20 Jul 2026 08:25:26 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0223.013; Mon, 20 Jul 2026
 08:25:25 +0000
Date: Mon, 20 Jul 2026 08:25:15 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>, Andi Shyti <andi.shyti@linux.intel.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, "Sebastian
 Brzezinka" <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v3 5/5] drm/i915/gem: Remove iterator and use while loop
Message-ID: <gjalgvm2zdtzz67lh7jvzopm4ba44w4eh2rpaaniqc2jyegpn2@edzadixxdexq>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260713095812.1014365-1-krzysztof.karas@intel.com>
 <20260713095812.1014365-6-krzysztof.karas@intel.com>
 <a9b6b5c4165904ac474fb4a0d56341827b33e66b.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9b6b5c4165904ac474fb4a0d56341827b33e66b.camel@linux.intel.com>
X-ClientProxiedBy: WA2P291CA0026.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::22) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|DM4PR11MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 4124c394-f4c4-42e8-ff99-08dee6387330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|5023799004|11063799006|4143699003|10067099003|18002099003|22082099003|3023799007|27256017;
X-Microsoft-Antispam-Message-Info: fwu4ifJOChE7fncpeOfz/BBDxhrxMG6wSJUe0CC9oMI1mXkBvRsHdA/qQKwjtff1GePX+4IlUaPcAg5GlVLuXMkzvv5G+P//5DPu2JqZNj3tuXB2RY6vr8TUkFoG/mAuxSMDyq9ioTrFldvRCgOSM6F6qYST2kBW2QPai/Niq39vKbseh1kI+5OZ9D8qIsxWvPdlpkBgAZqGX4TWZ5lUVlAJaJFvkLdjiPW1ShxznLV6MaZouG8W7FRnKDRLypJB0HiTmFgtJI0+sbaUi/JOd/mnwNSRGabRdxSLpnlBJaorxZF331bO6K40Y2YJxdznxwlmEDwIJzpbIUu0ZUZeAiaaSrpcvizlo9mbQB96FVVJpEtEN4+rdTJeGdM8xwKNdyBraoYp7T4v4NBbnE8NJB8w6/jPjto17d37N3PyKyhItpP1wLgwIcugXsZBDkqYr7TK3EbqQrOVmzrv7sbVQbXn714wBDRLB366e+v/11NYHz6SHd3OahUKfNqnJ2clalI95jq9uK2S2+eCoJ3Rhyf8QMGt/rnOMM2PBTaL32yIiz4ZB5rjDq7BDLso+0U13JkRFpgt4UFShiP1IZhkxpj/T40ssAIMfEeOj9W5mv8Ktu/BjZpWhn4LqP5dkcNJhLsjymq4tyBIh//RiNOWOv9Nf3/6CFWqYsk8ZpmgW+tb8PdLXXkSaVDOIF7oJ4iDW9XhdmCe1YUGd/pxujTPxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(3023799007)(27256017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXA0Yzg3OTNMdlg0OE1oV1FPc0Z2T3FVR1gwUjRTVHhpNjRVcDNYcGFSNEx6?=
 =?utf-8?B?dW9EME9oYVUvd3FZa2JkY1hXNlgya3RXUjkxUEUybXBSQWVxV3RLUGk0bFZ0?=
 =?utf-8?B?dzlEajJ3emJIRlFRQ0VhTExxTFFtYXhDdUw2dHhRQSs0cHVCZkVQK09QenVP?=
 =?utf-8?B?emllT0NKeWY0c29jV1E2bCtNQkhVMEhDazJVUHdSWStHRWNhSEthZjJrRXlY?=
 =?utf-8?B?NzZlYlFVZ1Ftak1nVjhjdWxhcW1kQ0lSd252aTZQTXYwWWg4Um9HZ1p6anpK?=
 =?utf-8?B?eENOQ0NiZzRUU0cxclZWNTdwRTNINVBmbEgrRFExbVZTR2RPSi9VQnhuenlX?=
 =?utf-8?B?anVOWTZtK2VRQWJLeVY3UDBLUzZ5dEs5ZVhMRkVmeG1ocmdIZlhIQnFBcGpa?=
 =?utf-8?B?V3lnaW1uWE5YaEFTK2haaU9yS3Z4UkNrTGk5Vmg0dWlkQ3BSL2cvamdoK0FG?=
 =?utf-8?B?WXp1WCtoQkhPN1lKWFBwdVRaV1UrQ2JxTlBLaFFIdC9SZC9jTFdRMlllNUtv?=
 =?utf-8?B?clRqY1BhOHZpOXpJK3JEcFpmT0JkUU1ETWo5aWsxRURMUFBsQ0c3cG5FYTdZ?=
 =?utf-8?B?Q3FBbmptRUNmanhGWXBCbi9XQmNycnBScS9reGp0NitqWXN0dFcya2hWYXlQ?=
 =?utf-8?B?UFNTQlRnNHc5U0UxVHg0VkE3aXhLd1g1dDJaRWwyNmRKNTdzT3FYbXgycmgz?=
 =?utf-8?B?OFZVczMxbXRSMjdQemJGWjFDcWNHY3ZZZzRPQVZ2WnZuOGUzSXlaRDlnT05l?=
 =?utf-8?B?eENhaktvc3dpMEFIUjk5M1pGd3Y2a0t0U2lOMjdiNDByWE5XRmRrNWEwQWc1?=
 =?utf-8?B?TkNDTHAzOFN1aGFDK2RLZ3hPdHN6bU5XS1pxTUZCK21ES2x6STZtWjhhdFVn?=
 =?utf-8?B?K3hmNndNdzErUkYxNTdwUlBBYTJiS3p6ZnQ4bVpJa3cxa0RjNFlzcFdWVytz?=
 =?utf-8?B?SXkxNFY3Vkc1b1cyMlZsV00vQlFHR1IyMXJoU1RQN0FQTzdTajhtRW5zMExV?=
 =?utf-8?B?cGNZc1ZOeG14RHJrME5za2M5R2dBS3RIdit6SUN6a2dDdjBPWXFFSHVnaTNG?=
 =?utf-8?B?RWN3bU5xTU93N0xCSVgzcEpUOW5MekVrWGRua2lKRWladjBnQk5NUGNxblNk?=
 =?utf-8?B?SnFWeGN2aVc2WDhjQUQzNGs3VllyOXdud2plTWxpZGs3SXp6RGYvaGE0VVlB?=
 =?utf-8?B?ZjlKL1VuWDdjQkVJRXNvOG5jRnlkaWExNkZHMEFTbnduaVVFWmVubURuYzAr?=
 =?utf-8?B?OWlJeW1iWEkyMlBNVVU2U1o4UHVPY05lVmNHNnAwbkt0eXBrNzZjWTFVMGJ0?=
 =?utf-8?B?UGhUbS9DWDFhYjdSTm9KZ1F3WlpJdTRmZGwxM1JLcWJjY1EzZy9FMFJUTUxl?=
 =?utf-8?B?cVU5dWlXcEp4MS9GVU02dmZ4SGsvTEpWRzc1OElLTnNIR2tZRXF2d0tDTURO?=
 =?utf-8?B?bXVDZ1dlcGRURXZEOVpvWkhENmxMSFJwbmxnR0pUVXdJcUFOMGFaaThpYnpt?=
 =?utf-8?B?UXZmNEVGYWhhNDVEOTZuNWdDaC9jbzdmdmdYa25TbWpldk80UXVyVVNjMVRR?=
 =?utf-8?B?VytvM0RvUWdyT0lNZHRrZU1XV0ptaHRHdFdyRWRzY215ay9wbk53UGxKSGx6?=
 =?utf-8?B?Nm9HdmVFM1ZwN3N2ZmJwOXNqRmNRS1hhNWxJWU5GTm9CYytaTlNaZllwVGd2?=
 =?utf-8?B?MVpFbS9rWkhQaCt3b0pybnI2SC9QTWNVU0U0SWozVDNISFNHUDFORnFCaEMr?=
 =?utf-8?B?ZWFvNU93RVNkK3NWR29NV2V2K25XN0ZOMnNCQ3h0TGlvUGZ3d3BEeUF1dnFp?=
 =?utf-8?B?R1p6TmpITjNqUi9VMlRwSGFjSFpCMHJwMEtCQ1BET1dmWDE0VklBVDlqZDRn?=
 =?utf-8?B?dldTRk9YOXVUQWtLa0NQMkQ1RmRHRi9mbGw4T3E4cENiR0RlNG82WG1aOC95?=
 =?utf-8?B?K1VxMTB5YXZUcWhaYmlRZmtzMWFqVVlWZFYzRWl4b3BQMHJqd1NwczNIemhY?=
 =?utf-8?B?WmtTZ25pQm9nR2I2WUNIRTlqc0MyVWtrRlhyaks2TCsvTDluMnVKWTV4MVpC?=
 =?utf-8?B?RVdUbWRYK1ZNU05mOE5SbkNQcmFBb2FXUDNpbzFMS0VabllDcFNNbXZhdjdZ?=
 =?utf-8?B?OE5JT3VZanhjRGpFTXJLS2o0VXRjTmtDWVlKMlJ6ZXloMitoWjFmMTRaWGZJ?=
 =?utf-8?B?RTMrVWtYMFExeGgrTzNiOGxDVW0xSXhQSmZra3FPQ3lFYlArK2hFU216aCs4?=
 =?utf-8?B?dFl0aGxYWXdoWUM5cHR3RmdpMWxSRGd1RTFCOGcxdnFQamdhcHhpMVA5MENv?=
 =?utf-8?B?ald5Y0hVc01SMDdKM09DY2tUcitDemN5Y0Z1K1F6NGo1azRjY0JQN1ExbWpL?=
 =?utf-8?Q?7ge1eRF6DJapIdVM=3D?=
X-Exchange-RoutingPolicyChecked: dFcYdkML0h07hti65Fjy7N03+bVVKuO9UWAwkqShL6pSvkzUMbdlN/cJhBm5qTLfzluQWtL7FSWmvzvTmE2kpNOuQxebLcBE95R1ccU2z8J4vFR6VNuKvDjTuWQ8GZ0E6aj/fsurTSvRDpD68lHkgY8O4D/JxbFAWCs5hFX/e+drrJEDpDwNDszED4JN+KYMyP3q/HqZ0DppUTeRgMCvklzUvAc7iTa+3O0CzyvlO3Z7DCXRZguvLWZVfj/1nqJsmDgHeNi0EPUT52ITCRN0Zcuor3xhGKG256DtSssOWFhxaB3WntyrRkdnAeyeHbasOesNt1DLEHuMlaiMaHGhIA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4124c394-f4c4-42e8-ff99-08dee6387330
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:25:25.9465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1lCYl8I6hajEJS0kVP57agKzU8phmoT71nz4Aie3efhoGoL+h8v+53HdGVA+uTZmiUvODKDImTPrqfDTlm1EjloJhCMM5aIBoIQWH63oS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6214
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

Hi Janusz,

On 2026-07-15 at 19:04:42 +0200, Janusz Krzysztofik wrote:
> Hi Krzysztof,
> 
> On Mon, 2026-07-13 at 09:58 +0000, Krzysztof Karas wrote:
> > Change the main "for" loop into "while" to get rid of obscure
> > iterator "i" and use more descriptive name to indicate how many
> > pages were already covered. Detect first loop with st->nents and
> > put instructions for that case in their own block for easier
> > reading.
> > 
> > Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> > ---
> > v3:
> >  * Split refactoring and put it after the fix in shmem folio
> >   counting suggested by Andi.
> > 
> >  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 29 +++++++++++------------
> >  1 file changed, 14 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > index 7c8de8fe0a22..66d0f8f6ffcc 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > @@ -135,11 +135,11 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
> >  	unsigned int page_count; /* restricted by sg_alloc_table */
> >  	unsigned long next_pfn = 0; /* suppress gcc warning */
> >  	unsigned long folio_start = 0;
> > +	unsigned long pages_done = 0;
> >  	unsigned long folio_end = 0;
> >  	struct folio *folio = NULL;
> >  	struct scatterlist *sg;
> >  	gfp_t noreclaim;
> > -	unsigned long i;
> >  	int ret;
> >  
> >  	page_count = size / PAGE_SIZE;
> > @@ -163,15 +163,15 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
> >  
> >  	sg = st->sgl;
> >  	st->nents = 0;
> > -	for (i = 0; i < page_count; i++) {
> > +	while (pages_done < page_count) {
> >  		unsigned long folio_page_index = 0;
> >  		unsigned long nr_pages;
> >  		gfp_t gfp = noreclaim;
> >  
> >  		/* Grab the next folio if we exhausted the current one. */
> > -		if (!i || i > folio_end) {
> > -			folio = shmem_shrink_get_folio(mapping, i, gfp,
> > -						       page_count, i915);
> > +		if (!pages_done || pages_done > folio_end) {
> > +			folio = shmem_shrink_get_folio(mapping, pages_done, gfp,
> > +						       page_count - pages_done, i915);
> >  			if (IS_ERR(folio)) {
> >  				ret = PTR_ERR(folio);
> >  				goto err_sg;
> > @@ -181,7 +181,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
> >  			folio_end = folio_start + folio_nr_pages(folio) - 1;
> >  		}
> >  
> > -		folio_page_index = i - folio_start;
> > +		folio_page_index = pages_done - folio_start;
> >  		if (WARN_ON_ONCE(folio_page_index >= folio_nr_pages(folio))) {
> >  			ret = -EINVAL;
> >  			folio_put(folio);
> > @@ -190,16 +190,15 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
> >  
> >  		nr_pages = min_array(((unsigned long[]) {
> >  					folio_nr_pages(folio) - folio_page_index,
> > -					page_count - i,
> > +					page_count - pages_done,
> >  					max_t(unsigned int, 1, max_segment / PAGE_SIZE),
> >  				      }), 3);
> > -
> > -		if (!i ||
> > -		    sg->length >= max_segment ||
> > -		    folio_pfn(folio) + folio_page_index != next_pfn) {
> > -			if (i)
> > -				sg = sg_next(sg);
> > -
> > +		if (!st->nents) {
> > +			st->nents++;
> > +			sg_set_page(sg, folio_page(folio, 0), nr_pages * PAGE_SIZE, 0);
> > +		} else if (sg->length >= max_segment ||
> > +			   folio_pfn(folio) + folio_page_index != next_pfn) {
> > +			sg = sg_next(sg);
> 
> Repeating two or three lines of code to avoid calling another one 
> conditionally doesn't look optimal to me.  Maybe you could invent a simple 
> replacement of that 'if (i)' conditional expression.
Perhaps it is not optimal. I do not feel comfortable having two
conditions that contradict each other in the same block, which
is why I wanted to take out the first iteration setup.

It is more about aesthetics here, so I do not have a strong
argument here besides readability. If that is not enough, then
I'll revert to the previous code.

-- 
Best Regards,
Krzysztof
