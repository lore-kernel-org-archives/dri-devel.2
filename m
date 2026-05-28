Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F229CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A318B10F382;
	Thu, 28 May 2026 15:26:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CviyUWZ8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86C4010F387
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779981961; x=1811517961;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RrhBemNK5ARo91dTQwLIX4cz2fEaw4K8AuDerio7uHc=;
 b=CviyUWZ8+mieqZ28xwbrmTD2cMk7DXCnXJYC6RzFPtinRue/5fJwSkgT
 bpMLTFPWAqea9ZTmXUU7cGMTW2MTuuvbRquzJwUERLdzcwG6PgZPD4YPl
 Q+QqR/exY8QX2d+MWx8W+zq6tXA9m6v/Gmn7a3VDK7ynH7sSRWfN/mCeX
 wjE1zvugNkNsQLXYBPd9qQlgBKOQ+r0DHSi+hqhZibgfxJ536kr2qV1To
 Bxh82JOZUf4pMac1sY1w2E8y9ZJT4gpYqit/3oy964UhBcBAi/fPd0xuL
 FoTSSZnDWyr3hKh9W38RymwHB6mKiwy3IituOFdnrwXdFzLDebYBK/VIA A==;
X-CSE-ConnectionGUID: W8cegVBYSkKDTRFLWUREXQ==
X-CSE-MsgGUID: CVgkwXL8SpCX1KTGi0Ritg==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="91133623"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="91133623"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 08:26:01 -0700
X-CSE-ConnectionGUID: jednf6dpRluAT53yPFVlUQ==
X-CSE-MsgGUID: MwU51+RtRb2Pg+gLSlLF6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="238166302"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 08:26:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 08:26:00 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 08:26:00 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.8) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 08:25:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUH3hQfh4YJx05cus4OHpLzhrPplph7yO16RZk63MPOvvIPIROl0D51JGk9nMpGt0mbuXCcqHiflcjt9SQXOoJSbUsJFCj2tBegCKP+QyRSk97+uNGKO8+FIMgBolGcPWNyrt3hHfpMvxS5nGCHRHv5NdUeunAfKY3L1PdhuY6OyBrwm48cIwbOrbbpWAA5QJux3hytoLKVGOLPxtxpGuZ4sIqsHOVI8TYrlfNaHP/2UyPIF89kKSIZbrJO3KY3XixvT1C+RYugdPuKu50HmAQRQtqM8TBWCB35cLp7FlIz0mzGpYkfxP3Q0KeGsKm7glHPT/09Q072fowHt/fWwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79mXVv1/JSfcB08wpvGAVHQbNWVn5ZW6F9snNMdI05E=;
 b=iMJYY1ECnCj4t6X+OR2KtxmW24kxB0eHN83TxsQ1aGAm/nYG86IK34x87MC2LMksZ3aTmLubGmGsh1MbfAkr+IqBRdi1mm1BUnG/iPktaVnGVo3uB0tJeEA1kaCcD5C7GFYwuG6v9TBHr0xcOZ8HSism3cTv3uLbNAeotUl9GeYX8J2Z1aZqV72E/9tsJcnBgJmf29j9V3Kpu3Rye79zaR1oaQEd5OKi6vBIQn3bx6+IKHXkdzWEeMw7vkfjV6P6x+s1cFtIrBZ4qxvgADmCC4dTw/tANSVUkb10rFt3esJuM3HEXdd4TwdCfe/3b1/x3ebQesWcAz9zakM0KjighQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8019.namprd11.prod.outlook.com (2603:10b6:8:12e::18)
 by IA1PR11MB9472.namprd11.prod.outlook.com (2603:10b6:208:5ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 15:25:57 +0000
Received: from DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801]) by DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801%3]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:25:57 +0000
Date: Thu, 28 May 2026 17:25:51 +0200
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: <dri-devel@lists.freedesktop.org>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Krzysztof Karas
 <krzysztof.karas@intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>
Subject: Re: [PATCH] drm: Set dev->registered back to false in case of
 register failure
Message-ID: <y4idmqp6hdwawu6hntmtgppl74fznigglntwqzvdv4ii3g7jpf@icbzgwcryzxb>
References: <20260522154037.46892-3-krzysztof.niemiec@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260522154037.46892-3-krzysztof.niemiec@intel.com>
X-ClientProxiedBy: DB8P191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::12) To DS0PR11MB8019.namprd11.prod.outlook.com
 (2603:10b6:8:12e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8019:EE_|IA1PR11MB9472:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d0784e0-4431-4acd-78c4-08debccd6a3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|5023799004|56012099006|11063799006|6133799003|18002099003|22082099003|27256017;
X-Microsoft-Antispam-Message-Info: WLFYLKxlqG6ZMLZxWEaiN0NO/lAtXxfF9TnByhrLl6USKCSMO5icfl7esKnPJv77mywh3qyYm9ExZqP0IapetzilEnpNNr7Hj0zxC1tWcUY0D4SZPWWhcDQkC6KqwpRSGWhkEvgxdJVbjBPXdYz5UxPPo3u25GcivKLQUxCostK3SH4oewLC0QhTlFonuG/KhIyxznzweQL1aqZ69uNf3e2E9nMZE9MCe1zqR+YCD+oBxQhfzqYHtX6h+oaKfmtLJ4Kv1VQmxn4TKuJ3AaZbR0qtDKEa0VLF3IC96bDIx177UJAlpg8SrORYPZ2MQiT/lyPvW4kofvSFIPThYqFELZ3KaE4kZr7p2cTO+4hB3Rtrsmi2troH7VTJXWQ47DnXtRQq+8DkZ5hpFjIgn6Ozfk8S1XXnRelNPUr5zVmMLGSZE7YIevKfT95KvKk889pBVEnHwlcwpV/0ZUr/zRjdCibwWSF4jQQOWdO77txcsIPHcny3sCzBJllWjvaLOecVrnEoPhLCli/XR+tHkYm81QBYjkuIobLN/ol19yvVbwV2dHjeyEIfpU8T9PcWDhhUjA/GVCLJcAHa/4Y9sTwmNBWlq/8ikDGyAqICWbKet+pHNkNFbNpnFVvZ4C1itbDAiErzM8r1zVODcJUBEtRQwZqBRgSqDVutfK9oqJeCRFdDeMpg63guhHsh5v/1P70wJyz3Z6dgRBwHTf+1iVxrAipwnDt8JGKJoUO+XobEw39kmuvvK+MqIfldL1MZzu5O
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(5023799004)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(27256017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDBhVVBIZ1BsRE14djBsS3dtYkNucEhFMFdYUDBNZHRLU2syUFUrZVJERUg2?=
 =?utf-8?B?NFRIRFl0NEEzMHRnNVkva0FHbW1lTnNvV1JXVW95MWR0QnlKamZlby9rSWJa?=
 =?utf-8?B?SjFObmRWKzRkQXQ1c2pOV01VSmF1YnVxcFh2RXYxTlE2UkJDL0RlcFVOeS9r?=
 =?utf-8?B?R1F1R3dEckJwSisxU0YySkFiUHlyL0Zzb0ptanpEV1hRZEpKdnBXOWpXdlNW?=
 =?utf-8?B?ZnJzNk5KS0xtR1dKNitOT1pMSi8rUGpIMGlRbUM0SWM0VkVtZ1ZUTzQ5SEh3?=
 =?utf-8?B?ZSs0Y2lDZGNqeitNWENXc0VLRzZLelFnQWdjdEdnTmVYWkRGWHlvVEJrN2xu?=
 =?utf-8?B?T1hUOExObDJxaTh3ZUxYTlMxVTZNbm1pN0ROOWNUaGZHK3V2ZWdLczlyTkVI?=
 =?utf-8?B?cmpWSExTK1ZNV2NBUWNxSjFOc3NuV1AvejhTdHA3K1dxcGRDb2ZPU1QxR1lk?=
 =?utf-8?B?M2tzUXBRbXY4UmcyT1UrSmZWbnM2L013M2FmcElJZkp3RC9tREkwTENtd0No?=
 =?utf-8?B?S3V6aHJxYVhxVGtqb1dIOG9obGhqRmpOMXdidXBxa3p6MmZBbkdPalkyUGNn?=
 =?utf-8?B?ZGtsZ1VLUC9xbmlueHV4MkNJSGxuOFR3UGNsSU9pbTYwcTVqM0QwUk54eDIy?=
 =?utf-8?B?RVlmWVVlZml6RnFydlRmSXpGWkRlT2RKZ0tSNmRpckgyREpjb09ZNlUvVGpy?=
 =?utf-8?B?TEtSVHlLNmZuaFoxeWl1emZZMmdyZENVRjJLZjV5VjNTKzFabG9ZL1dZak5J?=
 =?utf-8?B?Q1c5THd3TlJTTnRrMnA2UDNxQzh2THNMR1pzTEZiN0N3Z2Z6SXhMcFlEdTIz?=
 =?utf-8?B?eU9nTDdDbDZwemZHREp0eEZmR0FJUExYdHVZalFLcndzVlZqSlphQmRnUngx?=
 =?utf-8?B?dml0NkYwaXBUaDBmT0ZMK0xUR2YzRmlmaVR1VFVEZlJMSlN2ZnJOT215Zmdm?=
 =?utf-8?B?Tzhtbm5HV2Rlem12S2VkS1dXTktyR1hqcUF3T3pJdk12eDltWHZhSXpoaGVi?=
 =?utf-8?B?UnEwdWVtWm5Gc1V4cG9nZ3pmS3JTc2pkZ2c1dzI1L0hOYmgrRCttdERTVFdy?=
 =?utf-8?B?U2d3UThveUJUN0R6M1ZWOFRDQndRWFNWVHNmVytjSGV3MUo3RWFlR1hrOWgz?=
 =?utf-8?B?ZjlkWVhQZzU3WFBPN1RGblB1Z3lsZDVNclVIUkRVM1hHcW9PZFkycTdzM2Fq?=
 =?utf-8?B?Y3JVT1l0WWo0NlUwV0xnSFgwUGNOdHZOYU05SHMyNGtCdXhkblFISGVrL3N6?=
 =?utf-8?B?Ni9VL3BSRzRYNnVTbFlwUU52KzRmSVNucDlzRjdQVlQyR2hvclJLeVNGSzZl?=
 =?utf-8?B?cEIzNVN3aFk4c0ZVTmRxT0g4TWJQN2RoVXdxTGUybGY2ZUlISFhWakRqRmFi?=
 =?utf-8?B?QWpoblBEZ0JsV3FndVVocFBXMVdnbkZPYndqdXdFZy9xTFNJNWRMdm9GelpK?=
 =?utf-8?B?VjUzSUhSZlM5TUovOStJSEVXMXF6V0gwZllqWWh2RXdSUUswZlltOWlEaTlm?=
 =?utf-8?B?bzc1TEJyQU9NWUFRNFY4aXEzWXZudCt0KzArZnBEQ0ZSeWlaVDJnR1I1UmhV?=
 =?utf-8?B?ZUFmelcwYVp2cVRXZmFWOUZaZ1lMaEZpbGVZNGVtR3IzZG9QMXZuQjAzOVVX?=
 =?utf-8?B?Q1ZWSEl5WUwwY3lXQVNYRGcxREtZSC8xb2l1cWVlSHU5Nm1XZXQzNkxSMS9X?=
 =?utf-8?B?ZXFXcGpYZS9lVklHdzM2KzNQQUZpcWRZc3pDYm93eWlrMUVpOTE0L3F2OHRn?=
 =?utf-8?B?YlN2elJTWFVjbTZERHV1MWN3K3hhZkw5UW9SSjEwUGRYaEhrcGlNdmM3UHNt?=
 =?utf-8?B?MHdQeVp5YXJaaitjYVZvWEVKTWVUZk5BSEZHTUpIYU52UHNRTmZMMUFneVRq?=
 =?utf-8?B?bkkvSTVUTm5iTnFtL3F4emd5SEQ2WU4yT1dkVzF0MDJJdnNLUDI5ZldYck9l?=
 =?utf-8?B?OG1NMk9EYlduZitCNG1TZEF1MkRSMHlXYytLQTd5ZGVBZXc4dDBrcUYxalZl?=
 =?utf-8?B?bFFHRHlHY202Ky9KMWo3UXJwcGludEdCMmZjSVZINUlkMHN1NmkwQjFBUlBq?=
 =?utf-8?B?NDZtL1J0d3lkK2lMSENJdEpPWXpsd0o0OUx1S3k1cE54dWdjMzNYYXlRQmpI?=
 =?utf-8?B?dkNPRlBOMkdnblI4TmFmS0ZxSmhwZHIxa0FjR3diZnlpZmZoTjBTMzRFQWRv?=
 =?utf-8?B?OExIWWZqZmcwK3Y1TFZrbzA1aDRjZUFFRW5HK2VPeGdVNmVJZ1F2a09BcTBM?=
 =?utf-8?B?WkZraW91NjdSc2crUWVWd2tNSnFOandiWXBkWG9xRnQ0TmpMT1JHS2lhNDdo?=
 =?utf-8?B?dllaazg4VWNsZVg5VS9JZkFMckVBbkNWWWx5MHpLTVU2bXdWQjhPL0FOdm84?=
 =?utf-8?Q?Dq9of8yU+PFo94lc=3D?=
X-Exchange-RoutingPolicyChecked: lh0h/SqKXFg0gNfhvDc8zGPPssj/dpKKg+kglRm21RYDX3uPn9Zb6EI/tA9mb3xSJqQSXd1DVgOmOLE2kCPjMtWq2Mx25QrWrLJjiwN/c73/3mHTEjSf0dIKrEiRvNCKodhS5T4yUTg/Xdtz2JYuLVfn8OTKEB/obUB5irO39Xlkwk47BPpqda5FDt7Xoa6odMgmLeGa1J18PUNM0DEVNVDwPOXEbDjPJ5gwWgQjtDur5zyDCTZcRNw/X98GBYvTNDUKWb8v9DeIj6hXnLoRDvWDun5UmH+8MMYHugGxbh+GW/s3xc9emxuoL3XfpxtK2he9ZJZ96L2G/o/VkpRJgw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0784e0-4431-4acd-78c4-08debccd6a3d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 15:25:57.1196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8cGdml67hlx/c8pd/NbBo0Imw+qIRlvyQpivXKSc6y94snjDsrmXEmv6inhuRSuUTJuRWVTPrR05IiCLWWmzsddUwoTChSZBmdlvNi8JYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9472
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

On 2026-05-22 at 17:40:39 GMT, Krzysztof Niemiec wrote:
> The dev->registered variable was initially added in such a way that it
> is only set after all functions that could have failed have been called
> and haven't returned an error. However, since then, the function
> drm_modeset_register_all() is being checked for its return value, which
> opens a possibility of failing the register after setting the registered
> variable anyway. drm_dev_register() cleans up after itself in case of
> failure, mimicking the functions called in drm_dev_unregister(), with
> the exception of drm_client_sysrq_unregister() and
> drm_panic_unregister() (_register() counterparts of which are not
> checked for their return values), and the dev->registered flag.
> 
> This creates a situation in which after calling drm_dev_register()
> nothing is registered (as the function entered an error path and cleaned
> up), but the device is reported as being registered according to the
> dev->registered variable.
> 
> This, for example, confuses the WARN_ON() in drm_mode_object_register(), which

(typo, s/drm_mode_object_register/drm_mode_object_unregister)

> is raised if a non-dynamic mode object is attempted to be unregistered
> in between the drm_dev_register() and drm_dev_unregister() calls. If
> drm_dev_register() fails - meaning the device *isn't* registered -
> currently it still reports dev->registered = true, which triggers the
> WARN_ON(), even though the usage is correct in that instance.
> 
> Set dev->registered back to false in the error path to prevent this.
> 
> Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
> ---
>  drivers/gpu/drm/drm_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 985c283cf59f..92403d79bb64 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -1116,6 +1116,7 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
>  	if (dev->driver->unload)
>  		dev->driver->unload(dev);
>  err_minors:
> +	dev->registered = false;
>  	remove_compat_control_link(dev);
>  	drm_minor_unregister(dev, DRM_MINOR_ACCEL);
>  	drm_minor_unregister(dev, DRM_MINOR_PRIMARY);
> -- 
> 2.45.2
> 
