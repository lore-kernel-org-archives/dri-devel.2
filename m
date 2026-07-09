Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A0CC44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C89D10F44B;
	Thu,  9 Jul 2026 07:55:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EEWWl27Q";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D58D510F44B
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 07:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783583730; x=1815119730;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=FUoQCEjU/Y+Mv/eUW6vLTOcdrLCzrhzm4InYasYdHaQ=;
 b=EEWWl27QkqAMxv0DhJU2JLA0ZGJpA8ixx+NFxsdnTRwZZ0Ih308E42+v
 xL5TQJWwz9W7YFJLcwjB7CK3IqdnMAQQR/nJbrnxeKd2X/pWV8PGAkPWW
 Rqd9xWm1yXrYLmPCfQeM2PhcCz1PBwEcb8eBit6w2UQprGv59+7+jmMfK
 ofprQk59xEj1j4pjebWq7rPcUD6QIIpDtK70e5I/gpMHj55JXRQd002oM
 duFXdr10lfu1Zs6AhzWWlHEahmCDiSuW3i8QzbNgCyS9fVIw9SVTtQhti
 uf3julrCWCtGOLokX3UV1CxKWBjXLr0j/v88mb3lby3uvCifh89Jx11Gy A==;
X-CSE-ConnectionGUID: wwsx+MwQRz2Ei2sQNpfxZw==
X-CSE-MsgGUID: L9060eTtSSuwVL6tonIeoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95412696"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="95412696"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 00:55:30 -0700
X-CSE-ConnectionGUID: 5VM4+IBrQ2mtVE92quRHog==
X-CSE-MsgGUID: 5eJlaxVQQXOTZb+BwPFbVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="248145588"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 00:55:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 00:55:28 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 00:55:28 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.66) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 00:55:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/zX5XQigu/PFljAvmbLuKPOyQdjmQv+UL86UiKje0J8nzi+o5GHYDyLagYMMmHMiXdBOeXevdnm9aHP8VsKFDmEYAMmOJt/q7hwzuVNF+96BMxcihM7DC4Je1JUbHDMZiF97QsOGL24KHV59ce6Ypwv5Su5dKOdNj11LXLifaLW1fZ8NU7bF+P0JzxMy5c4EZcuQMcT71qX7J/lPii2WHI2pLQGzZMalEBvI8HSjcW9CYLzrjPKK0WQOK2dKUJ8MbneSPfFE2ipMABcSa2eiL35L06VvC0XmhzQu7IVJStXz0d20GrxfNRVIhe2lQSctqzxC1FLqZG1pTdVpbvr/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKZVV9xdj6PVfFpqAEYdiLmwRDBSFhSJMlWR4izWaNg=;
 b=gCBpOFYvdBMEoyNYM92XHqx3PWSZvnIf3wk6jhxLU04JFm49rdqs3ij52LF7YjAlhCLbO+3NSWLGkVUdWz4mDKsXHxfHZPBG+F0y3ZdJMMZRxGrwi+MWLvwwjC9Z2hndm7M70oLpx9xx3jqbRv9N+2GsMGYmjeVSaKF4WwWT6Xu8a2wAf9lFh503VWb4KmETFyICUZt07OWnxFygd9Kk6eMZBxGxB7K0/+LS22Eeqm3fNdTK2kiIf4a4jzQ4AnIdERAomyFogrldxhmzM8xrENfDXF3L7MxgRmJ57WYDe82jNI0RPugngXYTGFUpeuqMlVa/O2BNWvdcXaY5XoTQ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SN7PR11MB7604.namprd11.prod.outlook.com (2603:10b6:806:343::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 07:55:20 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0181.008; Thu, 9 Jul 2026
 07:55:19 +0000
Date: Thu, 9 Jul 2026 00:55:17 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
CC: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 <dri-devel@lists.freedesktop.org>, Steven Price <steven.price@arm.com>,
 "Liviu Dudau" <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>, Danilo
 Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 <kernel-dev@igalia.com>
Subject: Re: [RFC 0/8] DRM scheduler kthread_worker for submission latency
 improvements
Message-ID: <ak9T5V6BQE2bojZs@gsse-cloud1.jf.intel.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <akd/ae5VGQrsWqsf@gsse-cloud1.jf.intel.com>
 <5963b079-cb44-4cd4-be56-f47bf3f15e0e@igalia.com>
 <akwyNSXO+QspyoBx@gsse-cloud1.jf.intel.com>
 <akym7rllMDFFcz8q@gsse-cloud1.jf.intel.com>
 <992e86a0-990c-46ab-8816-cf3c030d274a@igalia.com>
 <ak63Qzqxn1k9ezEd@gsse-cloud1.jf.intel.com>
 <20260709092552.256e2b3f@fedora-2.home>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260709092552.256e2b3f@fedora-2.home>
X-ClientProxiedBy: SJ0PR13CA0080.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::25) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SN7PR11MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eed2497-af9c-4eca-d9ca-08dedd8f6c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|5023799004|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Zd4eSU0sn6kGs4esyPkGwEYWgOKlc+M/FeqoL4tgbLJA+uxxW62QFsQ+fOjWTrsbYPiNN8waMa+kHzkOTdnxkRUTzwTZ41b4HdSZhm4ydAIaZvlOrYL2dKf4vQk2GxfhmvVdYTPIBG5I0r6I81MOvPYMptyyAMtbQQX7bu8wTix8UmdjnIo6mqdIyV/4KjJ3J19yUNxegTgyTxiLeUOeD+e0dijIOJ9SnBPSUdsyRClmQJl5yE4Ypg01DBLOVYXSRyioQLYUy1QDjf/vRp80h/xp1rtCvF67HfBBh1r2L0tRsbyfh+9osFRIGPvSQi+3Wzk0yAhUTRyVOHeSMJgU+Xr5+rOumkcKifrpO4mi1HOfefjqynYpVDLEY+s3Rk2tLzNqUk6yHCMD3mIC+wgT0hInDnp6kEkLbO7TuQompmstimsw5PIBoIc5w4X7Cdk7BbLUj/FUzrULyaE6s1EPl3XDwmHtOXdAdfnsrnWSf/b0+pupczYMiON+r0TdOC1wcYEWv2/+7IvHaalRsxO2BWONzomJR4SQyDxYYv6R1odI/1ULjCmlZ3QTgqzvszu3UFZV53oLYanQ3Ljuzrvj/5M35gYRR9GT2uPlBtYLK3gIfi8gxW9Vq4grGGhN53M/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(5023799004)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUlOVGZSSXliaCtrT2hRaWszZTRXd1V1cmtEbTYvbFhhaGRXVU1OTDJiNDdF?=
 =?utf-8?B?c3lqT1RrN1g0WFpDSUpOVFVxaWxSOEhnSm9vS044d09IejVVaDJONHF0cVF1?=
 =?utf-8?B?K09hTkpqMVNhRml4SkNaaHg5VStPc29MdlpWeVFpSTNSUStRMkVZWG1KSE5p?=
 =?utf-8?B?TTZ3V0tyS3ozUXNqOFJEL0xEVGg0c3dsK2hjYUlnV2ZQNCt6NlNsbG0wRUFo?=
 =?utf-8?B?QnVPRGtBOXFlSXFlM0hnQ09pUzB0cmFmRjFZeUpqQkYxOUhzYStwYThFbkRs?=
 =?utf-8?B?czV5UzZsR2JySHJZZW9yS3FoWEhaanV5SGFLUVdSdDcySnNFUEdYeDQ1eTA5?=
 =?utf-8?B?TmQ5Tlo5YStmT0xiMmlkUEdJQy9yMEwzMm90L0p5UGF5QlVkTUttcWxocDhi?=
 =?utf-8?B?SmEwNmtYbHdacTRseGdaa1BrVzM5TTFPVlhjZnZsUXl2TDYydmFuSWQ0eWMy?=
 =?utf-8?B?MVpwYnAvUWVXZy9TN2NtSHNhZHl0djFRa1M5MTJnSUVCcmNhSVRqU2FEREhC?=
 =?utf-8?B?N0ZmSXlPT1A3SGhpMlVoSjhkR243ZmFBbGZ3d0ErVjVZVkZHSGFQWG5EWGNa?=
 =?utf-8?B?b3prYWNTUnBJMm5YOXZnTU1uaFd5bW51TWNyM1A4VGNLTnJDMTljOE1QWVJS?=
 =?utf-8?B?TVlQZUllOGN3a1hqZTVadGh1cHZKSlBPdjRWSzhDRkVmS2xPZmZ3VEJzdWsx?=
 =?utf-8?B?QTVNNTNwTVJ5bHlJSEJUZFFOdzRrcDdINmhJY0pyTmhGRk1qWDRkM2FJbVRl?=
 =?utf-8?B?M2ZVZFZ6c2ZxNVREZ3NHekw2dzcrZjdCVnl5K0JDUXVOWHlGNXhoSVBqY3Nj?=
 =?utf-8?B?Mjh5T0RMbGMwbzArbk1jS1VFSHRia0ttcWc3em9tTHoyRmtvcHRWaDNaNk9v?=
 =?utf-8?B?MUNGVTVubmYrMkUrTk5ISHg2a0VheGJMV21LOGNpSUJmMjZwRmpHbjBiV0t2?=
 =?utf-8?B?b1F0R3NCM3c3UzFqRVQzMEFqSjFHQjBWQXR6K2FvTUNKT3RUVmlGK0ZXWmpY?=
 =?utf-8?B?KzhDbFM1djJVVEZtSU1OZ0JlaE9XeGpiUUJESG9pTlZIbmxHUGJxSTAxSTBz?=
 =?utf-8?B?Z3RHek85dFJYR29KMTdSQVNZMW83WGNnbmg5eldyUWNTK2gwSGkvaU5uOVdN?=
 =?utf-8?B?SjhiclcrSDFjemJLWjgzWC9FOEVBVjRjbXZrSkVkTVZYbVZiRHkrRnVzUDJl?=
 =?utf-8?B?MEZ6V1pLVzYydVk0OGZ4UTlCUnRReUQ4dS9EWXBkUUZrUDhOV3pibXBtbmt2?=
 =?utf-8?B?ZWRLazV0WUxBaVVlT3Jjc1dGazloaWNlNlE0eVBNMFdCVjV6K1BMNnkwUVBm?=
 =?utf-8?B?SDV3ZjlLWXN5WVd6ZE1LbkRidTdRL3hDc1M5anNTVXFSZnhRUzNmYXdOVEVk?=
 =?utf-8?B?emRkbzhobUoyeXNuR3UwaDY0eFFIeFhpN08zMlBnZjBOZ0w0L3d0TGNpRG41?=
 =?utf-8?B?QmZpVE1OZW5lRXBJRzFZMUV2K1M3M2J2OGcvT2JBSE5TZVpnajRsa3piUUZx?=
 =?utf-8?B?Rmp6VVJNbWVLbFRxTUkxcVhCSU9GYVZQTVVpeVJ1N1RybGpXTC9qY3NGUTRp?=
 =?utf-8?B?cElqbkxOdGg0M3lRanJkblplQUFGaHFhRHlzMVZ6am5XVGJkbm1VQ2c0RGcy?=
 =?utf-8?B?RlpzUWlSbnY0T3FGVURnN2hLaHg2MCtkME9oSmpkWE41VUdoSDU2UFU3U3o4?=
 =?utf-8?B?V285eU5TRG8zbkI4UWZYeUVQYTh0alJqSXJpZHQzM3pHaVhRTmw3UEhuMmRJ?=
 =?utf-8?B?bmhpTUxOak8vNnhvN0R6NnpONE5TUzl0SUsrRVdHZTJoUGtCNURCUFppdGZl?=
 =?utf-8?B?N0ZoWk5NS3ZZQlh5L3hzWXBBSnNZa3IyR3M2aTZFdUxYcHFxczk3aVFUK0tR?=
 =?utf-8?B?aHRRMkdySks3OHBPVlh1Vk5aeFd6cXJkbDVDcXQ1WEdzVnIyR3lkaTByM1NT?=
 =?utf-8?B?OU5VMGdFWHlCZzEyN2gxOXo3d2hCOUl2cnpURVEvdGw4enlkRGUxaEs2TjBD?=
 =?utf-8?B?RHpWS0hwcWlxS2o5eFNIdDMyUUdVdzBwa0RqUXVHYkxWTmxUR3ZsMytsa1VN?=
 =?utf-8?B?ZUNpOXQ0d2F1NXpTdkx5Lzg3OHRYdmsvZWM2Nks1TC9sS1l2Rnd4ZzkzMzYv?=
 =?utf-8?B?bkZVdlNtbzhpQVpXY1dwQUJLOEhEMHF1ekYxV2xBWG9rVFc0NGNIWU85N1li?=
 =?utf-8?B?V2hUNjVBN1grekdBZkZ5NEJWbGhXM1JCSUl4ZnNYSkpNMStFNTVGY05LT3FE?=
 =?utf-8?B?MnM4SE1ldkhUQWUzcFFEMXRKdmpidFFoUUlnUXFnMU9BUlVrc2JwQTE1Sm1U?=
 =?utf-8?B?Z2VuMDl5NTA2aE9lQ2hLZytoSTlnS29BWE1QTGlnbEl1QXJBMU8zUT09?=
X-Exchange-RoutingPolicyChecked: iRbY18GXIR/i9bNBsUzzrEIUx+wgWO6WEd5fcilgeGHY1ceOYwdeXsqGzgHWWULV2dNQrxxE/y4k0WBB7nDt1XT2J9TKBpgRPhvTAOTvGSbjVzCDk29q02Pvp1jcZuNmYbLZrnDOUnp+6OxV6zFyFfRCfmUEUjMl0EVBFpFItAGuNxcOzNQY8BHoDD7jBDmUSw4uZPEv9cNtbpNPldMuMRdrqyarrcr0IqraO1T8DVPVGaKybWRwioVhamADS1lMyljbNVcEETmel1d2fJmOu3hVg5LL4U3JZI7Un39soMuh9TxYMAQObrGa8wekbjI3rMPNbcGMTkGdRUT0gus0hA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eed2497-af9c-4eca-d9ca-08dedd8f6c06
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 07:55:19.7497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kerFyVH53FsEK1yOXtstFzONhjZ9D5/10WlMJEJhCaxBXGnRCVUHp+yQBwgBVyC80wfi46l00hiwq9XzuyzKsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7604
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

On Thu, Jul 09, 2026 at 09:25:52AM +0200, Boris Brezillon wrote:
> On Wed, 8 Jul 2026 13:46:59 -0700
> Matthew Brost <matthew.brost@intel.com> wrote:
> 
> > On Wed, Jul 08, 2026 at 06:01:55PM +0100, Tvrtko Ursulin wrote:
> > > 
> > > On 07/07/2026 08:12, Matthew Brost wrote:  
> > > > On Mon, Jul 06, 2026 at 03:54:45PM -0700, Matthew Brost wrote:  
> > > > > On Mon, Jul 06, 2026 at 01:41:01PM +0100, Tvrtko Ursulin wrote:  
> > > > > > 
> > > > > > On 03/07/2026 10:22, Matthew Brost wrote:  
> > > > > > > On Thu, Jul 02, 2026 at 03:37:37PM +0100, Tvrtko Ursulin wrote:  
> > > > > > > > The problem statement is explained quite well and succinctly at:
> > > > > > > > https://gitlab.freedesktop.org/panfrost/linux/-/work_items/49
> > > > > > > > 
> > > > > > > > Essentially, on a system (over)loaded with a lot of runnable CPU processes, a
> > > > > > > > high-priority DRM client gets latency injected into the GPU submission path due
> > > > > > > > to the DRM scheduler use of workqueues.
> > > > > > > > 
> > > > > > > > This patch series proposes to replace the workqueues with kthread_work and
> > > > > > > > priority inheritance to solve this problem.
> > > > > > > > 
> > > > > > > > In the above linked issue Chia-I benchmarked the submit latencies which
> > > > > > > > show a striking improvement:
> > > > > > > > 
> > > > > > > > 		median	95%	99%
> > > > > > > >     before	41us	1.5ms	2.6ms
> > > > > > > >      after	15us	19us	24us  
> > > > > > > 
> > > > > > > Can you give more information on these numbers? e.g., What you ran / how
> > > > > > > you measured these. It is hard to argue with numbers.  
> > > > > > 
> > > > > > I believe Chia-I observed latency on some production hw/sw and then wrote a
> > > > > > synthetic benchmark to test it more easily. Details are in the above linked
> > > > > > issue.
> > > > > >   
> > > > > 
> > > > > Thanks, I see this now. Part of the problem, as far as I can tell, is
> > > > > that fences are signaled from work items rather than directly from IRQ
> > > > > context.
> > > > > 
> > > > > For example:
> > > > > 
> > > > > "There is another 2.5 ms of scheduling latency from
> > > > > panthor_sched_report_fw_events() (running on irq/105-panthor, PID 257)
> > > > > to process_fw_events_work() (running on kworker/u32:1, PID 62)."
> > > > > 
> > > > > I assume this is only addressing the scheduling portion of the latency,
> > > > > but you also mentioned a 9.5 ms delay for vkQueueWaitIdle(), where part
> > > > > of the latency appears to be on the signaling side due to the worker
> > > > > thread.
> > > > >   
> > > > > > > > This is obviously really good for preventing compositors from missing frames and  
> > > > > > > 
> > > > > > > Modern compositors do not pass render-job fences to draw jobs as input
> > > > > > > dependencies. On Wayland, this functionality is provided by
> > > > > > > linux-drm-syncobj-v1 and is enabled by default on Ubuntu 24.10 and
> > > > > > > later. SurfaceFlinger has also operated this way for quite some time.
> > > > > > > 
> > > > > > > The obvious solution for compositors is to submit work directly through
> > > > > > > the ioctl (i.e., bypass path in sched) when there are no input
> > > > > > > dependencies, which should be the common case. The main exception is
> > > > > > > when one of the BOs mapped into the compositor is migrating or otherwise
> > > > > > > busy (i.e., a BO has a fence in a kernel dma-resv slot).  
> > > > > > 
> > > > > > You mean the direct submit RFC you floated some time ago? What was the
> > > > > > verdict on that one, wasn't it rejected?
> > > > > >   
> > > > > 
> > > > > I had some patches for DRM sched that I never posted. It turned out to
> > > > > be a little tricky because of some other quirks in DRM sched, but it was
> > > > > still roughly 100 LoC plus an additional lock.
> > > > >   
> > > > 
> > > > Side note: I quickly rebased DRM DEP here [1] and prototyped some RT
> > > > solutions.
> > > > 
> > > > I added a DRM_DEP_QUEUE_FLAGS_RT flag to internally choose between a
> > > > workqueue and kthread_work, and to enable FIFO scheduling in [2]. Most
> > > > of the details are hidden internally, but I had to make a few small
> > > > changes in Xe to support this on the driver side [3].
> > > > 
> > > > Putting aside whether or when DRM DEP will land, if DRM sched really
> > > > wants FIFO scheduling instead of bypass (the IMO this is somewhat
> > > > questionable), I think the approach I took in DRM DEP makes a lot more
> > > > sense. I haven't looked into what changes would be required in DRM
> > > > sched, though; hopefully it wouldn't be too messy.
> > > > 
> > > > Of course, kthreads are now directly exposed to userspace, but this
> > > > would be limited to privileged userspace with FIFO scheduling
> > > > capabilities, which seems reasonable. Additionally, this approach does
> > > > not require the kind of large paradigm shifts proposed by this series.  
> > > 
> > > This sounds plausible and TBH I also considered worker duality. If you look
> > > at my series I wrap everything to drm_sched_work and drm_sched_worker so
> > > drivers do not even have to know what is the underlying implementation.
> > >   
> > 
> > You could probably abstract this to some extent, but any driver-side
> > functions that process work on scheduler workers would still require
> > dedicated function signatures. Perhaps some creative macros could do
> > something like:
> > 
> > DRM_SCHED_DECL_DRIVER_WORK_FUNC(driver_sched, work_func);
> > DRM_SCHED_INIT_DRIVER_WORK_FUNC(driver_sched, work_func);
> > 
> > However, this would only eliminate functions that perform a
> > `container_of()` conversion or use an `if` statement to select between
> > workqueues and `kthread_work`.
> 
> Honestly, I'm questioning the viability of such an hybrid design. Not
> only this makes the code base even harder to reason about (and thus,
> harder to maintain), but if you think about it, the only reason we got

If this is hard to maintain or reason about, then the scheduler is
broken. It took me roughly 10 minutes to modify a branch with DRM dep
and Xe to support a hybrid design, and another 20 minutes or so to
figure out how to run an Xe test with FIFO scheduling :). It shouldn't
be difficult to do the same in DRM sched either. If it is, that only
highlights why I think DRM dep is a good idea.

> here is because we pretended the full/monolithic drm_sched stack was a
> good fit for this FW-scheduler use case, and the reality is that it's
> not.
> 
> What we need for this FW-scheduler case is a simple per-context FIFO
> with dep tracking. The KMD can then decide when to pull jobs from
> this FIFO with its own deferred work model (workqueues, kthread or
> whatever). All it needs to have is:
> 
> - a way to initialize the job and its deps (so basically the
>   drm_sched_job_xxx() helpers)
> - a way to queue a job to this FIFO (something like
>   drm_sched_entity_push_job(), but maybe simpler)
> - a way to evaluate if the first job in the queue is ready for
>   execution
> - a way to register a callback for asynchronous queue/job readiness
>   re-evaluation. That would basically be called on a dep fence callback
>   call, and defers the responsibility of how the re-evaluation is done
>   to the driver. If you're using kthreads, you'll just be issuing a
>   kthread_queue_work() from this callback. If you want workqueues, you'd
>   be using queue_work_on(), etc.
> 
> The key here, is that the framework no longer decides the deferred work
> model the driver has to use. This push/pull model makes it so the driver
> is in control at all times, which also simplifies things like teardown,
> or rather, make it so drm_sched is not in the way of driver specific
> teardown sequences.

drm_sched teardowns are in fact awful.

> 
> I know some of these concepts have been discussed with Philipp and
> Danilo for the JobQueue implementation they intend to have on the
> rust-side. I also know that they are not particularly thrilled by this
> push/pull model, I think they're more going for a solution where jobs
> are pushed to the driver when they are ready for execution, which
> requires having their own worker/work to defer the run_job() call, so
> back to the problem that the framework enforces the execution model.
> 

This all sounds nice, but my initial reaction is that you're asking the
driver to do a lot of things that it will likely get wrong—for example,
stopping and starting queues, DMA-fence rules, tracking jobs to
completion, handling timeouts, managing object lifetimes, and
implementing teardown flows. Consequently, DRM sched has historically
gotten many of these things wrong as well, although the concepts you
want a scheduler to provide are there—they're just implemented poorly.

Another major problem with what you're suggesting is that you
essentially have to accept that a ready job may be pushed to the driver
from IRQ context, since fences can signal from IRQ context. That's a
massive can of worms, and I know firsthand what a terrible idea it can
be because i915 did exactly that.

So unless I'm misunderstansing you suggestion, this is something I'd
never use as common DRM idea in any driver I was involved with.

Matt

> Oh, and also, just because more is deferred to the driver doesn't mean
> we can't have generic helpers for kthread-based/workqueue-based
> deferral, the big difference being that, it's now up to the driver to
> decide which ones they want to use.
