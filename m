Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6883AFF60CF
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 07:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE5FE10E1E1;
	Tue, 31 Mar 2026 07:05:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LBPkSF/N";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B70E010E05E;
 Tue, 31 Mar 2026 07:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774940754; x=1806476754;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=u9jDHz5akFk3U0NpG26YUw6Z7jQNXhqWET4a/40lWHk=;
 b=LBPkSF/Nb0fgr1RcYVrG/1neKJlFiZLvDFturO6/Ck1UuTu/tOSfBqao
 Oa5NFL7Mg0kYGm/iaYnSgllckVzpWYJ6rADM06JpoB7p+mhhn2GWriFx1
 IcmtZrjKKYNmaSvYsQBpE1q2EYSZSy7kXipNLR0D2y/KH0x0psagKaGpx
 LGJfFs58UZ+SB5a9ianKNRH0zXdN475/BOV4vepiyaH6keBQJTD4/WvVe
 exJrde8j3I7SIXBSeFlKI5MFV1qBbDWT3i3z9DQ0/E4O2sD1DFAtbIziM
 d20OCjJhQw6pfTZM6B1REFHH0q2Mj3Po/yLR8Qqrc550g84fIUAd0offe Q==;
X-CSE-ConnectionGUID: 2eqzHt8gRKiUQUGdOrR65A==
X-CSE-MsgGUID: rT/0/miGTTSh9vqtoNcQZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="79545405"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="79545405"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 00:05:54 -0700
X-CSE-ConnectionGUID: mR14hH9rSIGOvBLSfYKnbQ==
X-CSE-MsgGUID: z7BH0b8xSIOvWFwImjCa8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="249494966"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 00:05:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 00:05:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 00:05:52 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.71)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 00:05:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdesXSdheBy5RgBncL7KTUuSTGf701Cz1dofCGxZWW2X6XfzJHHtkcoP+Fr91uXZeJ59yFSIYThBg6c6Xgz5p4Og3gw9XuRlDzDqVOeUqrzzABpOgW2MM04IJB60q13yyiqKILFwXynwAv1/VvOEmnkcm2gJKkY6SX9nP7cFPw+jKwX6qY9k6+WSsFU9E1qWzvyRXNX465TPxQO8BGnbOW7nqmcflUcjM6hxjnp2HUSfsotG2Ytfr2VkdEcZjcg7M3fhxCMKG0dH3gXuOMKD5vpEkQSMoQOAi/0V9eXmnB84cI59QV62Oyu62CYjGfAZNFqKwsYNLofJIolm6YagLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5B6/N4n8j4pI8cS39ZBwqcLbBEHFoxH0I0jZJiXajA8=;
 b=Q/pxPExR7732MKxTQryW6qqlfmNxf7RQTR2Sep1vR9gJhIRpn+SgB+p4+kaX7rAP0ViP6hC3ISS6vAxUEO3/6P/Rrj2feBYEp0IG65lh3GYGKYWTL8dnZHkQHSeWURpquvZWcmH/05OCOXAYMym4H99N3Tu2VjrbWlYMKodpBFwVkUaiyPEyHi+TuysiyoMTFjMhLYl3ucT0BaseSI/ElYv7tVbQO6uFIlCMVrPCpG2KnBRdLyPyNQVO1yFQk2FT1631P7OQ03Kt+64SKvR2vvia47VAcICRsB+xAO0vaW0Mnvy++Vr3P0SXM5RMwwO+R1fAYaXUHgaFLm6W67Iqqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6011.namprd11.prod.outlook.com (2603:10b6:208:372::6)
 by SJ5PPF162366726.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::813) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.11; Tue, 31 Mar
 2026 07:05:44 +0000
Received: from MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::3a69:3aa4:9748:6811]) by MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::3a69:3aa4:9748:6811%3]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 07:05:44 +0000
Message-ID: <bc8d7454-918a-4476-b945-ec98caf98812@intel.com>
Date: Tue, 31 Mar 2026 09:05:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v7 1/1] drm/xe/pf: Restrict device query responses in
 admin-only PF mode
To: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>,
 <intel-xe@lists.freedesktop.org>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, =?UTF-8?Q?Piotr_Pi=C3=B3rkowski?=
 <piotr.piorkowski@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, "Dunajski
 Bartosz" <bartosz.dunajski@intel.com>, Ashutosh Dixit
 <ashutosh.dixit@intel.com>, <dri-devel@lists.freedesktop.org>
References: <20260331061736.1218962-1-satyanarayana.k.v.p@intel.com>
 <20260331061736.1218962-2-satyanarayana.k.v.p@intel.com>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <20260331061736.1218962-2-satyanarayana.k.v.p@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0902CA0044.eurprd09.prod.outlook.com
 (2603:10a6:802:1::33) To MN0PR11MB6011.namprd11.prod.outlook.com
 (2603:10b6:208:372::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6011:EE_|SJ5PPF162366726:EE_
X-MS-Office365-Filtering-Correlation-Id: 25540336-0e7a-4e83-d3ee-08de8ef3ed2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: Jjn/D8fV9JTzvwKcHPi9g/rkZOgbqDL/LrtRJCff3/q8HX91BXI7SAA+vgpe6JPBTqYxkPEe1JVlzLXX85cKHbPoaoFNPsJXdVxcnknnm784mYSxkY9yEOrgwbQWITiIcCgN1ZjGnCaS9cMDs+ZdYRR+NTIaFer+xMBt7G9a5AJIqKA33dK5s2sYdKVwkhkTYuORBp44Y/VZlt08BWNlftkRPnb5L5JwoaXHGIcCrKDn5oMPuWd87HkLiQf4ytjn4lg/ku+SDAeMu+zGem9lzm4GSHhwjiuBgEotrG9bM3Hvt69n9IslDkx0jTMbsvapmUfdCKpp1Y7m/HGLvsqqBG/QVoUGEmhr7iGXYfdrq+ck9V7QJva4zyV90mDebjUx/QBSVv1oMgVwiOGihWAkG8FWNRDfdgA0oHP/hRUvFcMsDXNQ0hQQhtHUhAVFssX1tYYRkqdPVgKdvCHtXR0n9K+ODJFN63/6uMbFmO0tO6VEvLYyNx7hH14wn13GwhlrxCMJDne+Axa7KX32sDkAm74jfsYD1Nbv5r1ZtC6VZEINoAX52ldJ8XJJDBe7xUDncLo0r+Os2gGmKkVSbOvD4CEevgzK6k9UuqD06ZLE6Jzo6jncBBbrCu1f/7logJSJASj2RHf+J2566eoCpHYV7f7NxmBqbdAgIu9XuD4B/FSJbURf5FdIoFnEk308R0RKrPBLs6L4bJoBtTr8fG+FEI1OK0INTmthrCoJFsomIkU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6011.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHRqQnBEQ3dsTnpkTHk3N2lpUGt0YjNrTzRoZmRaVTlqOFppZFhpdmhidnJw?=
 =?utf-8?B?UlNTOW1jWE5iYnpPVlBEMm5obEMvSWhvanhFcXBuZ1VpVVNKRythZ1JXVmsw?=
 =?utf-8?B?OU84TzZ3TEEyN2xxNjYvSEdJVkJVeHVadkRkcG4rK0dwM1BXZkM5bXJGMlN4?=
 =?utf-8?B?Wno5Zk1IUnI5ckR4V0gxYTVwcXBtWDQ5V1BPbkR2amlqTmlBT3ZhdHIvT1VC?=
 =?utf-8?B?VDZkSlVSMVFhUWdMNngySk5jTFQ2Z3NvdTl4TXN2TWNwUzl1VUN4Q3gxZlk5?=
 =?utf-8?B?ZG1WOHpxS2hLckx6T2NzY0VQc2VUcFN2dSt0Z1hxZ3VWQUFrMXhZUG0zLzJX?=
 =?utf-8?B?YXlqb0JJK1BMUUM2d01qRGNhVUNZcW56RjBXMHlHWkNqWWNRU2d4aDVPc2Zn?=
 =?utf-8?B?My9RNkFNeFRiT3R2MkU0R1RpWVVhYVEvUnZYNnhCU2ZtRlRKWEZNeFJ3TzNH?=
 =?utf-8?B?SlA2Y3BHTEFHQUZYeXFaQjVrNXpWdEFJc1Fsc2UxOXc2Y3NJdEJrMjJnYnlE?=
 =?utf-8?B?TkpRV09Majk4ekc1YXlXcUcwbVh2MXkwSGwrSnAvRzdRdFRISFB2NTJNTVJI?=
 =?utf-8?B?bDdsVEMrTHJhZDkzdnZRajdyUkZacWp0ZEdEL2JXKzQ1L2xvNElIS2ZHME9m?=
 =?utf-8?B?WWxsZ3oyU2NpdmtVbi9KVFZCMjZPNXl4Q3BMS0Z3NXhPb2pLbThvbVpGbmVN?=
 =?utf-8?B?Z3NMbGJOZWRxNThsTGh4b25HVmM3dy9rdmtQeHZmbTF1cXdiRmVVTE1NTmJa?=
 =?utf-8?B?VmZqVVJrdzZOQTlEajRRMS9jWS92S3QrVTlsdFpFVERHc0VnNlNPdy9yaHpC?=
 =?utf-8?B?Ly8vZHhvM1pPNzVsZEhBcnhDaHJ4WGVKMk9MeEQxeUdFcGl0RVlkWW9oSm9j?=
 =?utf-8?B?cmJ5MTFyb1dNQWtiSnNXZ21LTVZ6dXJGek9qU0lnVlFxMkN6QnBRb1BDQ3VM?=
 =?utf-8?B?LytWbS9NdHNFejlFRDFxOGo1SjJNSW5wN0I5dEhFSXZoemg4V1cybWZhSktt?=
 =?utf-8?B?a0pZT01KQ2NIejNBcXAzT280bzlmY1VIcnBNWDVHVHhaaEp5N0lMSDRTTHp4?=
 =?utf-8?B?WEhsT2s1TlF1Zk5xRWg2U0J4clJiajlndHpjM1dNbVZRc085NjRBdFM3TlRV?=
 =?utf-8?B?eTEvSS9GOE13U0UwMGZuSjhrdHNsbFJiQUVyTzM5VGMwV0U1SHBsalUxeTFZ?=
 =?utf-8?B?aEl2YWROSlNhQTJSdWRpWHcwTS9kZXJTMWJGbjJxTk56RjMwYXFkeVVVOWJ1?=
 =?utf-8?B?bFRCenROTDAxSEIvbEZ5MEZ4d0crM1lKa0hKK041Y0pXRUh1Q1hGdGx1cjFy?=
 =?utf-8?B?Q09GMmtKUmM0M1pqSTJOd2sreE83V0FPNHYzL2M4WDZ4VUtzTXdRS09mMDBr?=
 =?utf-8?B?SjhPSFllRktia09XSmU2ZTVZZURwcWJlNEtXZmtoUGRTUDBlZ2tZMjhxK3JV?=
 =?utf-8?B?MnZUZ1lscXhlSWVYbFR6Ym9DeXhLZ29RajdiNmhIejlZeG5IeURFMkFRRjZG?=
 =?utf-8?B?NnRONVo4VVhFbFRnR1NCMUh1eXNpTTNjZVNmd0hWQW1oQS9Dd2NmV0NKejJj?=
 =?utf-8?B?Wm1tMDd2SFU1S1Z3Q3U5cGlUczZqVkpPQ2FLM2JtUVZibTAxRk82L013dTFB?=
 =?utf-8?B?cm9iYkdxdGZrbm5Ucy9UMGw2ZXd0M0NnU3U0MDFCVlFVMVowdEx6TEo0cGdx?=
 =?utf-8?B?cEFoczdZcitwNWFMN202RkNEdzYwb3MyVGhtVUhKSUU1dG9ITThqU3lZa3RM?=
 =?utf-8?B?bW9iWHZxRlM0WVhPZlVnanZDSStHaUhZSTc4Sm54VENkaURsQkhUUUVnWFJI?=
 =?utf-8?B?TW9FQmI0ZGR1alNGWlhFMDRvYm1ibUJvUE5lWmlqR1hNK0RCUURCYzVjUlhS?=
 =?utf-8?B?cFNVMGJvNWRodHh4ekM5TmxTbUlGM2Jvc01odGlEME9zdndTMjYzakdDTnBX?=
 =?utf-8?B?R3NqV1VPb0lORCtTdmpwOUkremFrZERHWlU3QzNEU0M4d3A4VHR1bnBxc01U?=
 =?utf-8?B?UHVPUmZnZnlUcFlsWmFyOUhYZmlCSG5tUUM3SGhFUXpDd1JDYlBUM1MyLzhY?=
 =?utf-8?B?L0ZrUE5Sc1NkQkZ0R3pDdFQ2K2ttZ3JCb1NSRUYyRmFrMjdHbnR0QjFBYmlV?=
 =?utf-8?B?WE9KNWFrSjdYaXJTQnczZzRLRXFJUG5MbVRJYW85ZnJsTGVQb2lOMnR1Yk5O?=
 =?utf-8?B?TXlPOWlHazUzTmV2OTdmUThoVVppZnBGUXhDd1N0RjVrbnVqajFoNlY3Rkkw?=
 =?utf-8?B?OU9MejJCRm1yRW1mem1wdytXYS90WWRac05udnNmVmlwdFFtSzlPVTg4bk1N?=
 =?utf-8?B?RnMvNEh3VW45bXdlUENJR1dQeXRiSHRLZ3piNG8xbUxMdmx3dVJPQXkrT3ZH?=
 =?utf-8?Q?rSJreHcnZ/nW+Vs8=3D?=
X-Exchange-RoutingPolicyChecked: ByTCHY/LufKS7VFG9aORyEs5zmntiK9H59lNv0HbzpZxn3A1a9AyEDpIOBq2JNMiXy+Utqnir15IHX4oEfVqMO/zCVf5SrzKU7b56zj2+IDdq31+Vu2tf9Uf0Fa9cDpvoDoRdV1OIKESNgrnavpJ+/QYBd+wIs4dlJ5cEe0a/z9Xz7v0VONWgoqAR4L9x4udhDZ0yFUpz7vBMEZUdft0da6Vn9n9+1wEmTHGNZfKw7Ne62XW2zjx+3IlEeW+ZxxRqib2DXhkRFEgP4lL2nOjAesh5lo2pVwwD93kFjV74n2Vxy+JRjakyhkXTTvIdaFahPSgxd5KRuFWBtsMWfMaTg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 25540336-0e7a-4e83-d3ee-08de8ef3ed2f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6011.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 07:05:44.3251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a59j+fAfkq6itIUI1eQ6Lw1wYzJDE2EccOW+iUYmP4GVKv5Dsf1KoAvYEnf7EB7cyg3a1BuW9lY5w+76QMiJ7HFiONdlvJ0hrxh+20wLT04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF162366726
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



On 3/31/2026 8:17 AM, Satyanarayana K V P wrote:
> When a PF is configured in admin-only mode, it is intended for management
> only and must not expose workload-facing capabilities to userspace.
> 
> Limit the exposed ioctl set in admin-only PF mode to XE_DEVICE_QUERY, and
> suppress capability-bearing query payloads so that the userspace cannot
> discover execution-related device details in this mode.
> 
> Enable admin-only mode with:
> echo <B:D:F> | sudo tee /sys/bus/pci/drivers/xe/unbind
> sudo mkdir /sys/kernel/config/xe/<B:D:F>
> echo yes | sudo tee /sys/kernel/config/xe/<B:D:F>/sriov/admin_only_pf
> echo <B:D:F> | sudo tee /sys/bus/pci/drivers/xe/bind
> 
> Signed-off-by: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>
> Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Piotr Piórkowski <piotr.piorkowski@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Michał Winiarski <michal.winiarski@intel.com>
> Cc: Dunajski Bartosz <bartosz.dunajski@intel.com>
> Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> 
> ---
> V6 -> V7:
> - Allowed xe_observation_ioctl as well with admin-only PF (Ashutosh,
> Michal).
> - Updated commit message with steps to enable admin-only mode (Rodrigo).
> 
> V5 -> V6:
> - Updated commit message.
> - Return number of engines and memory regions as zero instead of
> returning query size as zero (Michal Wajdeczko).
> - Allow all other query IOCTLs excepts query_engines and
> query_mem_regions (Michal Wajdeczko).
> 
> V4 -> V5:
> - Updated commit message (Matt B).
> - Introduced new driver_admin_only_pf structure (Michal Wajdeczko).
> - Updated all query configs (Michal Wajdeczko).
> - Renamed xe_device_is_admin_only() to xe_device_is_admin_only_pf()
> - Fixed other review comments (Michal Wajdeczko).
> 
> V3 -> V4:
> - Suppressed device capabilities in admin-only PF mode. (Wajdeczko)
> 
> V2 -> V3:
> - Introduced new helper function xe_debugfs_create_files() to create
> debugfs entries based on admin_only_pf mode or normal mode.
> 
> V1 -> V2:
> - Rebased to latest drm-tip.
> - Update update_minor_dev() to debugfs_minor_dev().
> ---
>  drivers/gpu/drm/xe/xe_device.c | 61 +++++++++++++++++++++++++++++++---
>  drivers/gpu/drm/xe/xe_device.h |  1 +
>  drivers/gpu/drm/xe/xe_query.c  |  6 ++++
>  3 files changed, 64 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> index cbce1d0ffe48..910a0aa4c3d0 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -25,6 +25,7 @@
>  #include "regs/xe_regs.h"
>  #include "xe_bo.h"
>  #include "xe_bo_evict.h"
> +#include "xe_configfs.h"
>  #include "xe_debugfs.h"
>  #include "xe_defaults.h"
>  #include "xe_devcoredump.h"
> @@ -216,6 +217,11 @@ static const struct drm_ioctl_desc xe_ioctls[] = {
>  			  DRM_RENDER_ALLOW),
>  };
>  
> +static const struct drm_ioctl_desc xe_ioctls_admin_only[] = {
> +	DRM_IOCTL_DEF_DRV(XE_DEVICE_QUERY, xe_query_ioctl, DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(XE_OBSERVATION, xe_observation_ioctl, DRM_RENDER_ALLOW),
> +};
> +
>  static long xe_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  {
>  	struct drm_file *file_priv = file->private_data;
> @@ -390,7 +396,7 @@ bool xe_is_xe_file(const struct file *file)
>  	return file->f_op == &xe_driver_fops;
>  }
>  
> -static struct drm_driver driver = {
> +static struct drm_driver regular_driver = {
>  	.driver_features =
>  	    DRIVER_GEM |
>  	    DRIVER_RENDER | DRIVER_SYNCOBJ |
> @@ -415,6 +421,40 @@ static struct drm_driver driver = {
>  	.patchlevel = DRIVER_PATCHLEVEL,
>  };
>  
> +static struct drm_driver admin_only_driver = {
> +	.driver_features =
> +	    DRIVER_GEM | DRIVER_RENDER | DRIVER_GEM_GPUVA,
> +	.open = xe_file_open,
> +	.postclose = xe_file_close,
> +
> +	.gem_prime_import = xe_gem_prime_import,

not a expert here, but do we need this?
comment says "This defaults to drm_gem_prime_import() if not set."

> +
> +	.dumb_create = xe_bo_dumb_create,
> +	.dumb_map_offset = drm_gem_ttm_dumb_map_offset,
> +#ifdef CONFIG_PROC_FS
> +	.show_fdinfo = xe_drm_client_fdinfo,
> +#endif
> +	.ioctls = xe_ioctls_admin_only,
> +	.num_ioctls = ARRAY_SIZE(xe_ioctls_admin_only),
> +	.fops = &xe_driver_fops,
> +	.name = DRIVER_NAME,
> +	.desc = DRIVER_DESC,
> +	.major = DRIVER_MAJOR,
> +	.minor = DRIVER_MINOR,
> +	.patchlevel = DRIVER_PATCHLEVEL,
> +};
> +
> +/**
> + * xe_device_is_admin_only() - Check whether device is admin only or not.
> + * @xe: the &xe_device to check
> + *
> + * Return: true if the device is admin only, false otherwise.
> + */
> +bool xe_device_is_admin_only(const struct xe_device *xe)

after introducing this function, to avoid confusion, we should revisit: 
 - xe_sriov_pf_admin_only
 - xe->sriov.pf.admin_only

> +{
> +	return xe->drm.driver == &admin_only_driver;
> +}
> +
>  static void xe_device_destroy(struct drm_device *dev, void *dummy)
>  {
>  	struct xe_device *xe = to_xe_device(dev);
> @@ -439,16 +479,24 @@ static void xe_device_destroy(struct drm_device *dev, void *dummy)
>  struct xe_device *xe_device_create(struct pci_dev *pdev,
>  				   const struct pci_device_id *ent)
>  {
> +	struct drm_driver *driver = &regular_driver;
>  	struct xe_device *xe;
>  	int err;
>  
> -	xe_display_driver_set_hooks(&driver);
> +	/*
> +	 * Since XE device is not initialized yet, read from configfs
> +	 * directly to decide whether we are in admin-only PF mode or not.
> +	 */
> +	if (xe_configfs_admin_only_pf(pdev))
> +		driver = &admin_only_driver;
> +
> +	xe_display_driver_set_hooks(driver);
>  
> -	err = aperture_remove_conflicting_pci_devices(pdev, driver.name);
> +	err = aperture_remove_conflicting_pci_devices(pdev, driver->name);
>  	if (err)
>  		return ERR_PTR(err);
>  
> -	xe = devm_drm_dev_alloc(&pdev->dev, &driver, struct xe_device, drm);
> +	xe = devm_drm_dev_alloc(&pdev->dev, driver, struct xe_device, drm);
>  	if (IS_ERR(xe))
>  		return xe;
>  
> @@ -708,6 +756,11 @@ int xe_device_probe_early(struct xe_device *xe)
>  
>  	xe_sriov_probe_early(xe);
>  
> +	if (xe_configfs_admin_only_pf(to_pci_dev(xe->drm.dev)) && !IS_SRIOV_PF(xe)) {

we should be able to use xe_device_is_admin_only() now
no need to check configfs again

> +		drm_err(&xe->drm, "Admin-only PF mode is enabled in non PF mode\n");

nit: we ca use xe_err() here
nit: maybe the message should be:

	"Can't run Admin-only mode without SR-IOV PF mode!\n"
or
	"Admin-only mode without SR-IOV PF is unsupported!\n"

> +		return -ENODEV;
> +	}
> +
>  	if (IS_SRIOV_VF(xe))
>  		vf_update_device_info(xe);
>  
> diff --git a/drivers/gpu/drm/xe/xe_device.h b/drivers/gpu/drm/xe/xe_device.h
> index e4b9de8d8e95..c220f2f1352f 100644
> --- a/drivers/gpu/drm/xe/xe_device.h
> +++ b/drivers/gpu/drm/xe/xe_device.h
> @@ -43,6 +43,7 @@ static inline struct xe_device *ttm_to_xe_device(struct ttm_device *ttm)
>  	return container_of(ttm, struct xe_device, ttm);
>  }
>  
> +bool xe_device_is_admin_only(const struct xe_device *xe);
>  struct xe_device *xe_device_create(struct pci_dev *pdev,
>  				   const struct pci_device_id *ent);
>  int xe_device_probe_early(struct xe_device *xe);
> diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
> index d84d6a422c45..40c7ab9fecf8 100644
> --- a/drivers/gpu/drm/xe/xe_query.c
> +++ b/drivers/gpu/drm/xe/xe_query.c
> @@ -217,6 +217,9 @@ static int query_engines(struct xe_device *xe,
>  
>  	engines->num_engines = i;
>  
> +	if (xe_device_is_admin_only(xe))
> +		memset(engines, 0, size);

that looks broken - we will return some number of engines, but all of
them will be class=0, instance=0, gtid=0

why can't we put is_admin_only case in xe_hw_engine_is_reserved() as
previously suggested? this should filter-out all engines as expected
so returned query data will be:

	engines->num_engines = 0;
	engines->engines[] = { }

> +
>  	if (copy_to_user(query_ptr, engines, size)) {
>  		kfree(engines);
>  		return -EFAULT;
> @@ -297,6 +300,9 @@ static int query_mem_regions(struct xe_device *xe,
>  		}
>  	}
>  
> +	if (xe_device_is_admin_only(xe))
> +		memset(mem_regions, 0, size);

similar problem here

> +
>  	if (!copy_to_user(query_ptr, mem_regions, size))
>  		ret = 0;
>  	else

