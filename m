Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452C0C55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 10:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E40B10E1D2;
	Wed,  5 Aug 2026 10:01:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="k6rgywl5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1AB310E1D2;
 Wed,  5 Aug 2026 10:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785924083; x=1817460083;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fzFahik0wNsFo6qZ0k0Gs16RcY+wjAUZ4J2GImTqsjk=;
 b=k6rgywl5QnSk2/uI9TUiT5kLhumKlxzFpPzZra5fMOgmmC+Ok4fTLX5i
 sI8N+QXh1r2vY7yuKowcrZ88BOYI13nVI49nrO3m6zDrdDQHxOLd0hhv2
 Vyd08lOH12uqMWyJg+Ndh3RE2R9YRtb1BVNGv8od7myN+AzEI9AbCr5eK
 scWIBbwv8zp0KcWzWb9yR2WQYr0zoPdw/yAG1jK8RLQaiI9BnaZMi4AHO
 NhpDW+mNmsgBUjYdRZ/aWcylIw8YD7rqxtmvye3c7yVDQTSGxXabhUXql
 41q5TwrgbNC4IncxiLlcCS0VokeMKK3lRZA3IlHteiKTfQ45v0bjgVQBJ A==;
X-CSE-ConnectionGUID: nvHZUm16TR6PJ+1vUdY/Uw==
X-CSE-MsgGUID: kAvkZEVqThKqRaj2wYiqcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97088039"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="97088039"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 03:01:22 -0700
X-CSE-ConnectionGUID: fIamHR0qTqWX02KOAK8l5g==
X-CSE-MsgGUID: rbAHeb/YTrC7z0OpxbkeCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="265604924"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 03:01:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 03:01:21 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 03:01:21 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.31) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 03:01:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGOTVqhxN0txuMhcqhGuMX+Wtd432hu0xUuAZzQSVUdGgGAFvVOOvsrhidgWpb9iyMwEEkMrem+BGsmWKNeHN5XMpc/bvrsfQTzEQ73k/gaDLVxQFygOINSbKGUeJz1p6bQGQSLIPHKhWFkAx5Jmuqd30N1VmrbSgUSevjwEF6csj7CFRWNkj0+bNYhUYy4YLO+iwSrxYxiSmmpIF8Ua2dSpKB1yYHvqLuOlokCd6mESV0pX842ZNIAQ+kVmhSqzMdrWG4dKDlaDH5Ww6FLCt/hirQmmKI4/+cMULplWxlNm3lTRwrk+n7s+n815/1CkpuTUmC0y7UWhvggt4UYHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQta0TnyAiLdRFxgvylJTYXyBoKCylKzhuh6lk2KoBU=;
 b=iX+/cmeefNJQpJuOHnmRsmepL+luKqezJOifyh1Ul36k5V7KZHwusU+GkfKrL3EG9tmab9lfd0PipWso/nHeYYvDrm9CWZJCnOBPrXBTnyTqU5sASPtaBNDxZUA63FB2Pfy4tRlEO9QG0Xg+yW+6PnLCuZU5voHmCw1nw0thT7V5Ae03WS+9jNs7tV0G9yhvx8OLcSR1WD1sQWWy55yGWOyfI4yJPim0OkdTRxiBNhViTUEkOMjg5IYRTct24F4LSESPSBmjtzFxnBsdiFkEpbKODbo6ToTRkqqHAlQnAmIZ/MPDHI+Han7NG551vi3PEvRsKC2/UbXJ5h2qOz4zuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21)
 by SJ2PR11MB8500.namprd11.prod.outlook.com (2603:10b6:a03:574::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 10:01:16 +0000
Received: from MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d]) by MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d%5]) with mapi id 15.21.0292.015; Wed, 5 Aug 2026
 10:01:16 +0000
Message-ID: <91c8cb20-fd5e-499c-a953-07145ad87f14@intel.com>
Date: Wed, 5 Aug 2026 15:31:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 4/4] drm/xe/ras: Use fault-inject to trigger
 cold-reset wedge
To: Raag Jadav <raag.jadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>, <andrealmeid@igalia.com>,
 <christian.koenig@amd.com>, <airlied@gmail.com>, <simona.vetter@ffwll.ch>,
 <mripard@kernel.org>, <maarten.lankhorst@linux.intel.com>,
 <tzimmermann@suse.de>, <anshuman.gupta@intel.com>, <badal.nilawar@intel.com>, 
 <riana.tauro@intel.com>, <karthik.poosa@intel.com>, <sk.anirban@intel.com>
References: <20260805071152.1225416-6-mallesh.koujalagi@intel.com>
 <20260805071152.1225416-10-mallesh.koujalagi@intel.com>
 <anL-1UiSNMQfsXEk@black.igk.intel.com>
Content-Language: en-US
From: "Mallesh, Koujalagi" <mallesh.koujalagi@intel.com>
In-Reply-To: <anL-1UiSNMQfsXEk@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0174.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::8) To MN0PR11MB6207.namprd11.prod.outlook.com
 (2603:10b6:208:3c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6207:EE_|SJ2PR11MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: b74ac2ad-5aa0-4519-e185-08def2d87d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8qt+qQxSMAEPAlIDTtPzOYOQzmP62LEBuYpPKRShh29mBM6quCNqtJ0TPopZ7RssyI/zJwJvzvw86Sos734Tfj92XIqTjoeFOSIbRjCtVWk9mbmUHmO+DgG/7m2R3pit47/eE5qhjv641cjE3ie9RAyUso59IoyQlMGFL+8UH1bfXeuj1d7vain7xCYrkgXodBZMj9tQ0dVxgCTDBCDNh3z7Kb32C/r+vNK9gGXl5ZZd3aDdbFIaBTiPAhV4MIICkso5dK3bmcLbVGTup46C+U3utZkCui9Kkx040bTMY6y9JZAGResBa4u8q4dlfU5ob7RhweBK+1UoQzSd3mQyoAVMVugYLkrBdapqqmLPAoG9ST1y58enVUpUaAKrCrl7/RjtftHOXdMRUzabO06TeFZGKvU1XmmI5YvDWL/pTLuUJFji1FJV0iq5iQOzQj4af6uBrVqU+DrUCs+AMWiqzcudoq+asVRA+rvX4TSnSTapDWA3UNtEZrRQTb8roJgsBHNkITjJ4DKsz/88aZxryfXtfjRApNMcMzehAFi8FCmFPMUfedmJGs/xTdHr/VZsir8cTdsa59RudkGTv8TLUFtnIR85jrjcYMDW/hCgJe41FQKfGWPhitD9DrsiZGqVVftz1aSFFEgDtKCphAeYUDgmbgEuVh3ggIOwR1eyS2c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6207.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cytzMmt4dXNhdUpjRVcwWDBDdHZObkdjNjl3eVJMUitZNk81ZmtkRnY0MklL?=
 =?utf-8?B?L0JGa0dSSVpudDR2dmRrWkVMNkVYMWl6Y21nVTlvQkl4c3lacWt6a3E3bVRO?=
 =?utf-8?B?c25ST3NTSVNpcnBqek9rZVVPVko5TnBYT0ZHNStlTFlVdjJydTE0TkdqeUJN?=
 =?utf-8?B?QlY2TmwvdUJLaTJtSnZoS3NPeFpMbWkyR1I2RjFjR0xLSldhbHRCakQ5TU5M?=
 =?utf-8?B?enh6ODJQVE5WanlIRTlGM3pvUkRwRmd1dWpCaGJrRUlkaGhCWDFtRmFSOThy?=
 =?utf-8?B?ZHZudHVnYXE1QWFjU21vclBvWHdRK01jdVQycHNWZzlYc0N4a04zOUR0QUpa?=
 =?utf-8?B?R005b1BKdmhvYmdWRVJRTFg2RHpYWkU3UFRCYkt1dm12ZTVianlRSTJDWGh1?=
 =?utf-8?B?Z0t6TDNlVjk5YXkzWlVMSDJGemR0NlFnTEJKSlFQblVEQXR1dFNxU2FUaHM5?=
 =?utf-8?B?alRBeEtqbmxDdTBoYlZQMHVTUThsdGZpSzNIT1YzRzhDVk1zWTZpYUxCdmY5?=
 =?utf-8?B?c1ZKbEJDVFVGS3BrM3pDT0s5VVUwSFJWWVI4UDcxak95bkxhWXd6SVE4UnU5?=
 =?utf-8?B?ZWVwajBKcis1UkxoRm5HMkgvanF6cnNVNWlpV0JnUno3Qm9OeFl0U3NXMFFv?=
 =?utf-8?B?ZWkvN3JibVEwWGtpNmVnR0FOYkJ1ZUVZWVlvR0NzZ3lqRGl2eFdaQVJtSDZE?=
 =?utf-8?B?M3ptYzlkMi9xd09WWG1WUTU0djJudUZTWW1qZU83WUdPZlg3WVkvdDd6Vi9F?=
 =?utf-8?B?Uk5vbkptclM3MWRZclpkKzhvcU5pcnlteWNycU9RQWlQeUd3eU5laDRUUmJC?=
 =?utf-8?B?YiswcGhFQTV6V29UOUU3NkN3T2cxREFYUHZSTkZYMENhSGY3UHBkRmtBSnBV?=
 =?utf-8?B?UXlsYTNkMU9VU2puUG80aG92Mk5JSkZHNXk4Q25IdTVQcGlNOU5WcnpkZWNm?=
 =?utf-8?B?L25ub1FLeXI1aHpwT05aSjdDa2ZoSmk5QjZsVzhIc3d4Vk5yaVRuaE9MUFFu?=
 =?utf-8?B?anZUcVpBa0dSaEtGQlN6bU45b29SMkFiV0hvclNsdE1aVGpYV0FpMVg0WjFr?=
 =?utf-8?B?Q0huSVk4RERLdmdieW9qYlYwOW9EWkRScXZnUnV1NUNSUHpxK2I4NkE4QXE1?=
 =?utf-8?B?aVNyNEtLTEJDbVNIZlhVMHpFcjhZT1F3RTM0NVJtN1RXL3AzdmlBWFNXY05N?=
 =?utf-8?B?UEQyZ0ptcHpSL2x0Zk14UExhdTZTQUhJd2JJeEpNMTNLYk5NSDhnaW9sK2No?=
 =?utf-8?B?bE91bUNNNTFWVERSSlQwbGtQbTkwNkZzaW1WKzBVL3dxYThTaGNiS09JSUhQ?=
 =?utf-8?B?OE0wMjNVRGY3NU5nWlFpaC84UzN1Q09QVklBbk9wTmR5NW9SZ0lGSmk4L09n?=
 =?utf-8?B?MzVsdEdaM25xQ0hrRGk4UXlHTlVpcDJTMEVPSmV1NDJFOUlrclZpWW4zcjZO?=
 =?utf-8?B?cEo1dGVIYVlROHl5TS9HeitnZ29kWkhZN3dqeUFDNEtoeGladWJVY25KN0k0?=
 =?utf-8?B?T0dQeGUzUk96c2tXTXJwUHhjdzVzbWxnWnNQT3B2NWJ0VDlkRStaRFdSRjdM?=
 =?utf-8?B?NjMxVlBsdG04Y3dMc1VodFFWTHY1RUhGUFV2OHMyenk1SlZ5OFp4WDcvaFNQ?=
 =?utf-8?B?YnBlSG1lemNCcEdNUmErKytnV3pqdytDTkxSNlZld1dVWVpkOXNmQldjakEw?=
 =?utf-8?B?Y2sxUTFQWnpxMkVjRElmRmpwUmp0TGNZWXpmTURIOC9iVnVjejl5KzdsZDZn?=
 =?utf-8?B?cG5vMU5lWFQ2SW1BSHA2NmVROFdvWW8xdlEvdXNVNW8xZCtBZkFzLzBIQ1p3?=
 =?utf-8?B?djdzeVQxc3IvaEY4RHFIbEZuaEpHd2g3U3NIOWx4N0tCa1Z5YitWWmcyZENH?=
 =?utf-8?B?VmFYWUtjKy9JK2lBZDI1TFcxWkdEZ3hwSEhaUW9FTDBJa2g3S2FORmN2QTJQ?=
 =?utf-8?B?Tkp1aGhDREY4K2NXblFtbjNneHRsNkJLcE9LMkpoTHBsN1RYUE05OXR0Tkhl?=
 =?utf-8?B?QmxQeWV5OUR2R1loTFJhZmllZWRKVHpSRFJaSlVCUDRobFVGU1VIUUg1bjZa?=
 =?utf-8?B?UWo2K3VWeTR6L1QrV2Q2Z0ZyM3VSNzlFOWIvcjJVVUVGcmJTTURsZUZmVXdM?=
 =?utf-8?B?bk5IcWUwRmltd1RHVUFobmtwNEJVZE5pRnlSY3JSWVViWGlaWlBtbXVWbEpT?=
 =?utf-8?B?VnpvdVhBb2t4bmRiRm5Eb29Od0lHUzFiVCtFSWkxemxGOE5aSCtvL3RNY1Jl?=
 =?utf-8?B?MkNTeEhOeE9TQVFUeTd1MWc0NlJLS1gwTWhCYnhnVmpDOUE4VW0vSHpRSXl2?=
 =?utf-8?B?aytrSmoxZFJKclBKRk1uOFhOdGVOYzBGNkRYVlIrclpFcFZBcWtnV1ZoR2s3?=
 =?utf-8?Q?phwIEz9XhYN0qFZo=3D?=
X-Exchange-RoutingPolicyChecked: ZzMK2//hBAXh5am9ZIgxFlMaMpSZ6bK/C6Db0ywXTHxJIwgg19XN62q8BFp6A8PP1V2fgKKMKiKVHuZbNh2r5jFY4p0+h4tyWHPXnaZAs1PmSVFxcT1yPxL0yKkLMNWArYaLtvTRx+JdRLDTO9MlGhzklDv7zgghDerudnTlU3DkVU3zcN9SurMcnT5roWQdCoW38JxCcu85s1crnFHJbUwn+wQfl/F16enZ5a2AVLFolYCzOvoJY3OsFjNKDOG08z7HsiB3s0xY4p7kfKnJuDiFSiQOwSMmBuU+oej9UwhbAnapJxle2IPIWho0AQXlLnhBr8I9UYlGtKFVwFkXEw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b74ac2ad-5aa0-4519-e185-08def2d87d20
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 10:01:16.0793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4OAmmR6axWomCgg21Oci05ZayrAqPlqO89kLlmWap3md2BWmiOO2kSLCgIAR9bs4qSzFCKf3OHX6S6X08wwzm1PgLSfX0wnL1U9rhfovPkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8500
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


On 05-08-2026 02:43 pm, Raag Jadav wrote:
> On Wed, Aug 05, 2026 at 12:41:57PM +0530, Mallesh Koujalagi wrote:
>> Use the fault-inject framework to trigger the cold-reset
>> wedge path (punit_error_handler()) for testing the
>> wedge/recovery flow.
>>
>> Usage:
>>    echo 100 > .../wedge_cold_reset/probability
>>    echo 1   > .../wedge_cold_reset/times
>>
>> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
>> ---
>> v13:
>> - Rename inject_punit_error to wedge_cold_reset. (Riana)
>> - Sashiko corner case issue addressed with
>>    commit 20bc4883c7c0 ("drm/xe/ras: Fix boot-time ras error processing").
> If the issue is already fixed, I don't see why this patch is still needed.
> But if it helps in any case,

Thanks Raag! This patch help to exercise the cold-reset wedge path 
(punit_error_handler())

without real punit error.

Thanks,

-/Mallesh

>
> Reviewed-by: Raag Jadav <raag.jadav@intel.com>
