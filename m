Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDFEC5AC7C
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87F0010F285;
	Thu,  6 Aug 2026 17:56:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VUMkNGPL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BB5B10F27C;
 Thu,  6 Aug 2026 17:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786038980; x=1817574980;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vtsoPbXEY7gtiqVgYgPi+pJi3jGAU39n2bDrspFSDzM=;
 b=VUMkNGPLjuztexots1GlNN90naQM1KlFoXG5c33WXM4i16ipvEWIj9Hp
 Q/EFBnRxZPRxF9cow13zEtrQ1eYstr4y6XgsYK3fys7mKXte5RlicXLJc
 CkF6EJ1JbD+XNCcGhuJr7J0tERvlkFUF1Ep30g68zG/MJvjt7xoalgpEt
 ReQMGW6q3+qhXi5zBBZjtifOCAL5JmH2ABwurTxOUFJOcXy3L6HI15dvV
 eD+mxuLAg9r/Jr/Yzb+ZD29o2BCCk++15b7CWqmaElvZQqeOF3HDP8xE1
 pKndCCwO5JAoxCjM7vO4XCNLXE7mX9qVSd6fsuTmFKjpJ4JrBYFgGE9kq A==;
X-CSE-ConnectionGUID: 5OeW081YToqdpjb/EI4YmA==
X-CSE-MsgGUID: wkyUfE+PS0ax51dcCnBBeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="104046127"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="104046127"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 10:56:19 -0700
X-CSE-ConnectionGUID: +iMecG6+RbqZToID48ByNw==
X-CSE-MsgGUID: xyXhZ9UvQxOmDqvITp6rkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="266396760"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 10:56:19 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 10:56:17 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 10:56:17 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 10:56:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPXzVfnQcc5ivLqCAQXaz0oTm+qx5CCpyvlyjhk4vyofqRHNliWE17L7A6AKGHh4t5FqQ58XFudHUlISOtPkvNYCzV4WtbJl3JY9BpmOcwAQiDmJvGEIvo9iDvAyXBlXvRIHb6Qmrowzn3y/HUprJxDMGOIUGU5PfQdWBQrZVt07Ex39HdHoKEWSdLxFd93+ustExaQ09mfn5RcZ48Pra4C0noepMjMA52Ozhe0ohROycXpD+m1K8oSgemzEmSSYA3TorzIu++TWbqkswGD1kBg1UMx4212e14Pf8Tqhu2twohFoZG9JVrx7yQ4xSPFJXKSp02xtf/vRUcf9poZ6QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Qf+MRtnLHHR5DNRKqdTehLoQsRcUJDRYTYCqQX9nKk=;
 b=o5TE/Znhgi8dkrhSQIL0H3AGxQZb8l2j2qSOn7rjbl8Z7I8Pl0k0GRE+5FrNbSKfdBImFzwUvA+G3QNx1n3Riah0akBXFAYaQByiHvErSyNsHNkelX228Rtj+HE4hiy1iPeRTbPRdHzPUlWpY8aGVksnUdzPy7gqhRoylN/6646SOys7AHDRK6oe7hG7vHGFn9YnqAwLsJ4m7QyUPo73ti3hHKFInb/bFuNBVBDew970xc4iZUSJU/FMEXpO54z8vCVb9VsXym90LbjXAn3FBZUANWkASBK15y6S8caFAF7zebBAg3MZbf6wgKDiSs3LJJkRY772wzVTVaPXvYSzOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16)
 by IA3PR11MB8938.namprd11.prod.outlook.com (2603:10b6:208:581::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 17:56:15 +0000
Received: from CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::ed0a:e4ab:fde6:edcc]) by CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::ed0a:e4ab:fde6:edcc%2]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 17:56:14 +0000
Message-ID: <a467ef01-f69a-444c-9718-286df60f47d9@intel.com>
Date: Thu, 6 Aug 2026 10:56:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] drm/xe: diagnostics and workaround for GuC TLB
 invalidation ack stalls on ARL
To: =?UTF-8?Q?Tales_A=2E_Mendon=C3=A7a?= <talesam@gmail.com>, Matthew Brost
 <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <thomas.hellstrom@linux.intel.com>,
 <rodrigo.vivi@intel.com>, <dri-devel@lists.freedesktop.org>
References: <20260804021441.3054424-1-talesam@gmail.com>
 <CAHBRX4GYEKniGb8jw-h=QYPi=FpbWRKwHHnfw-K5wYiy6AWfJA@mail.gmail.com>
 <anJZt4PzCE5t49Qg@gsse-cloud1.jf.intel.com>
 <anOcGqIyrA8LUHo/@gsse-cloud1.jf.intel.com>
 <CAHBRX4FpsT3CwSrpbLA7dUEpasJOFJxdHTNkU7W81RcQw50AOg@mail.gmail.com>
Content-Language: en-US
From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
In-Reply-To: <CAHBRX4FpsT3CwSrpbLA7dUEpasJOFJxdHTNkU7W81RcQw50AOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::6) To CO1PR11MB4979.namprd11.prod.outlook.com
 (2603:10b6:303:99::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4979:EE_|IA3PR11MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: fc8bb1bc-a403-4fe3-9462-08def3e401c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 3nPiTl1Ozn0hVK1DdGDFhILEeogoADfC8X+NLBHGDikHQ2BiJ1Mkx4quTXY9/bOKvhEgxlnU/kb9iaKhVQ8riYAHI0eESIsXNBQt8gGNtOJpqngDYJD+G0B4BiS5JbusZTSjFq1Yj2iSs8Z/Z9CFwAbMMoQzb1mF9torEASEdcobUkGCwdmkJa+KarGnoJk09IPUhwhf/m3uBaZIPmHfoB3LC5N+BcdCMqj4dqg4Q/z8SHGmpFBMB7XFZfYpK5txxB0cFPEOyOZk4lJp2CP5RKNUJ8t9890XSozbXr7cLYG0jlbObO7RQMvQ9cgHkBixYCUgqc2xZgxz/836jm9bmVCND/2pZmatsMPhNrgkiiS8aqanPBlPHkoGWJ2mlCzOsolehMuXiU6bLqjkiG2Zl6GAYnX1aUhxLqM7vdBWyCUn33e/8neruuM4Uv1fBv7SMIwHER0R8I0MLzWJQimOXHvaL58FAyKE7Es1S0oj4QfCMk+5V4a6PjCgwpPzmlHiVMpwkn657ieeYzfSp9JYM9Z43tIDNFe8kRk3TDI5hAUIvey3EGyF0uc5SuiaCkljvET5Zi7nCmsLg9Cq1Yc9CYGMGrLee9huL3ElIVHg641yk2wa1IcEVYuJq/8HfPVZHN/92+EbtBkdjkL2tz0lfQO4OyebbTkqgI9B06kOjIc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4979.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGdoN1RhM3ViaDd3dDdjU0ZXQWxzam9ISWJaNEkybWlTZ1ZVTjBWeVlCdDAz?=
 =?utf-8?B?UWhYdzhrWWlJYWxESDhBcnFFN3haWEV6RmRBS213azdrSEpCeVRKWjU1K1o0?=
 =?utf-8?B?RzZDZzVTNm9LV0JQdmdldjBLMmwwWk1jR203TGJsc2ZGVXJqbEpkc3RySU1i?=
 =?utf-8?B?RE9KSk5rVVphWVJZandiR3doTSszRVBQYktyeU13NnRPT1RjeitEbEFUR0NK?=
 =?utf-8?B?eXN1WTFpblVoRDBlWndaak9nUVZkSWlZOStKNG5JOXJwOGVWWURBeU5nbDhE?=
 =?utf-8?B?bzZiVWpCUGpXOHA0WVY5Q3hKbzlXZ2dDV0Z5elVZWUViTnNRS0lSWVJFaGZO?=
 =?utf-8?B?NFVwelVEKzNaZ0FzRzhwSkJrNExNN1ptWlROM1o0ekFVaVVNcnJmTCtqR1dn?=
 =?utf-8?B?NVBOeUJZY1ZMVGtCdEljZTlDSzdCTzlhdGxTb2NZOVNhc2Q1VFhObDdqTm9I?=
 =?utf-8?B?ZGpPd2Q1MlZoaGtzUzJmTWFtVTdxUnN4WDIweDk0MVlZM2ZNYmg2RzFkZHk1?=
 =?utf-8?B?ODZsTHFkTDR6VWV5dnBJT0V4MmdONE1rd1lEb1NOSlhGa3k3aWFvaFF0WmNK?=
 =?utf-8?B?OXFMVE5sb3Q1Nk0ycENRckNUbG1lWWFHeFhJc1R2YkJYYmJhTW1BMCtJWnVq?=
 =?utf-8?B?cmI4eXpyK0lqcGVXd29iZjcwaGJDK1g1Z25kU3NUbHlrQWJ3UmRKa1hRcENL?=
 =?utf-8?B?MDRNYzFzTGh5aXBsMVpzOENFOTl0cjBpVjRFU3l2K1U4bit3UFo2cU9lZ2NF?=
 =?utf-8?B?K2xsMkU2Rm1ab3FlQjJycWs3aVV5UHJsZzYzUERuWm15RGY3T2tSYlRmTHpS?=
 =?utf-8?B?TkZqTjRwQXlJYUcrUGQyT01sVVcrTWdkRmNrODdLUGVXWWZZdVU5byttV3hx?=
 =?utf-8?B?aHZMMGVpbERvMzdFV2pUMXlubDd3cnJQQmQrQlNZRXR3cHFOeGd5UmhjdE1U?=
 =?utf-8?B?Tk80UElNVVJPUzduTTBlWW9BL1Z0eTFCbm4zbzZjc2FXWmRsQVRyMUpnRUdt?=
 =?utf-8?B?S2hXRElBd3owM0VEWUVlcGowL2drZXl2ZElhd1dnbm1TUWdlTjd0NFFRMWFF?=
 =?utf-8?B?Tm95eEFFT2EvRU41ekxWOVdvaTZIWGtIc1pmeEpxekh6RjVWNktPZmRiQjJq?=
 =?utf-8?B?VVZ1MXVrdkxNdzZIVitUd3lLVnM4YlhxaldxUlhMQWl0L0Z3VTArZ2pEQk9N?=
 =?utf-8?B?TTBZSWpBNE9BZnFlWDZkWXJtN2VRZXBiYkJjcUUzOGtjYjRYcnpJa2svTzhN?=
 =?utf-8?B?TXNJZDVaMWpaOU9wUVQ3OWt3KzI1Zm1Cd0VjbUR6cVNiQVJrclA0ZGlwN20w?=
 =?utf-8?B?bmVlNTNkWWNsMy9nWnVBb2RlWXFpb2hYSmRjZktjd2Zrd0NpcGJEUEk2QlRP?=
 =?utf-8?B?UER5anRSWlhUaEhPNVNXUWE4VEkxUE8zN0pqa0Y1MXVhT2Q0VE81Y1NjbHl6?=
 =?utf-8?B?bXVvY2krcTRMZ2xha24vbDVRUFdyVHJZMlZ5Q3Z0Q2tFRzd4VHltb05jWm1m?=
 =?utf-8?B?WmI0SnRmeXorMUQxL3F6UUJPL2I5SjloM0Y3Y1lQL0c1dExUUlVrTDN5a2NI?=
 =?utf-8?B?YXJWSllLeU12SU9UME9GRitCUDNvVVlhNm9BZmMzNVNpMWVSSTZNSmJRbG5s?=
 =?utf-8?B?L0hsYzB3ZGI2QWVvY2gvZmxaZ01zRDJWK1pWZmJmNzMySGNxY09VcjZoSmNE?=
 =?utf-8?B?ZU5Eb1piRWFHaUpIelI2MHZ1V25sZ0ora3dFQnZ0eC9HU3BaNlJNRG1Rb2dv?=
 =?utf-8?B?UXdpSnRlcU5oK25LTm80UVE2NkhSSlZEOWNhaCtBb21TdXNNc3hldktJcXRy?=
 =?utf-8?B?dk5tbU1Tc0VqNnZsRlMvMzh6MWl0RUhPR3lZN2ZCdURBNEo0L1B4Y1JqQjZD?=
 =?utf-8?B?VGkrcXZPdlFZcHVqbTFYU3dIUGoyL1lDWXpVZEY5b0pTaE1SZmRNMVFOaHI5?=
 =?utf-8?B?d2NTWG82MnpvOUJDZlZCQ3JMaDZkSk10THg0Ky82dWRXQ3lDMUg2bGY5NjFu?=
 =?utf-8?B?SGw4UGpFc1hDK2JYTm1GUlljTXpnRDVSaWRZVVkyTWxvbkVYRUNSN25jNHRv?=
 =?utf-8?B?cXVpQi9GMGhpQ2E0OHRmTG9SbGoxRVJOeElYQTdSRkxNSFlSNnVqOGI1Y1B0?=
 =?utf-8?B?MU81bTVYb3VBTVlMM0RQK1BBTnkvUHlNRGY2MG52cllFNFFyc3p2c3dDNUJk?=
 =?utf-8?B?SnM5WjYxQlMrdkxZTXAzbjFnQTVuZmNiZUxYMC82NDdHOVZESUF3UUgxNlgv?=
 =?utf-8?B?QldhL0xZN3RjZ0FscWFGN1NHQ3FueU1INitlQzZCVTk1V2FvRWJpOFdHSUlw?=
 =?utf-8?B?NU9odzFCbDVFRTlQNmluUDJQZnkyc3dsZ3ZnNnV0eE01SFFvVjNsS016dGla?=
 =?utf-8?Q?30gsZbaeZkupiYog=3D?=
X-Exchange-RoutingPolicyChecked: qM4wTqpAC7FIzzNZBPpp/7El1Zw3p04NqcT2S6NMEwnuUfUjM5S2rvNawPmtCkZGT8/G3kJWsayo4ZXc89De3ueL1BT8cRREEJRTEqK3G+73+W4gpNeuPHgiD9iqP44BC8FaSOD41tUkGi+FnbrReqKV7KozFUiKVU7zdbMEqK1i5bpX34GVaWUGrkVWbe/VbqAcgZQSuZwH+LfbCe5gi/Tf0ukPU4YA2nh8YNyB5KImxNsdmhe+xZbVLAsck7uY2YuPxU9F4VzeUMINpcw3sKI9xVnKeq5iO/nXuJE4g9UntbwBvHFwXX8zjxwW5My8WecfMDhZ8blWiTHQP9HSOQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8bb1bc-a403-4fe3-9462-08def3e401c4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4979.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 17:56:14.2711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mO4SUF+HYwFEQVzaWeqAaJcQ3dOTMrpfB/aWqVz9UZ2u3xRfVcEyGjFVERNpy2Au9wcOntvrjl/jjA4Y8hzI6F5ajGkY39OMbMvv7NLdX1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8938
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



On 8/6/2026 10:37 AM, Tales A. Mendonça wrote:
>> You've been approved in our CI for future revs.
> Thanks!
>
>> Also I came across this issue on i915 for MTL [1] which appears to
>> indicate the same issue (ARL and MTL are very close and share the same GuC
>> firmware), the suggestion is to disable rc6. Unfortunately Xe
>> doesn't have a knob for this, but per [1] you can turn off rc6
>> in the BIOS. Maybe worth trying.
> Good find - that does look like the same ~2.3s signature, and it being
> visible on i915/MTL too is an important data point (Daniele asked
> exactly that in the other subthread).

I am not sure if 14469 is the same issue. In that one it seems like the 
GuC just stops processing incoming messages (i.e., the H2G CTB has 
unprocessed data in it), while AFAIU in your case the GuC is still 
processing new commands and it is just being slow. It might be different 
manifestations of the same underlying issue, but it might also be 
completely separate bugs.

>
> On the rc6 angle: I ran an A/B experiment earlier that should be
> equivalent to disabling rc6 at the GT level - holding forcewake across
> the whole GT for hours (C6 residency pinned at 0ms for the entire
> window, verified) - and still hit 9 timeouts in a row, with the same
> ~2.3s request-to-ack. So at least keeping the GT out of RC6 does not
> avoid the stall here. If the BIOS suggestion covers more than GT RC6
> (e.g. package C-states), that would be a different experiment - my
> consumer ASUS BIOS does not expose an rc6 knob, but I can look for
> C-state options if you think it is worth isolating.

The fact that keeping the GT awake didn't help also indicates that this 
likely isn't the same 14469.

Daniele

>
> Next on my side: switching to the GuC 70.72.1 build Daniele posted and
> reporting back, plus GuC logs from severe stalls are now attached to
> the gitlab issue.
>
> Thanks,
> Tales
>
> Em qua., 5 de ago. de 2026 às 17:25, Matthew Brost
> <matthew.brost@intel.com> escreveu:
>> On Tue, Aug 04, 2026 at 02:29:27PM -0700, Matthew Brost wrote:
>>> On Tue, Aug 04, 2026 at 01:34:19PM -0300, Tales A. Mendonça wrote:
>>>> Patchwork reports my address is not on the CI allowlist, so CI was not
>>>> triggered for this series:
>>>>
>>>>      Series author address 'talesam@gmail.com' is not on the allowlist,
>>>> which prevents CI from being automatically triggered.
>>>>
>>>>    Could one of the project owners click 'retest' on the series (and/or
>>>> add me to the allowlist)? Series URL:
>>>>
>>>>      https://patchwork.freedesktop.org/series/171539/
>>>>
>>> We'd have to resend this ourselves. I can do this, but I've requested
>>> for you to be on our allow list as well. I'll ping here once that goes
>>> through.
>>>
>> You are approved on our CI for future patches.
>>
>> Also I came across this issue in the i915 for MTL [1] which seems to
>> indicate the same issue (ARL and MTL are very close and share same GuC
>> firmware), the suggestion there is turn off rc6. Unfortunately Xe
>> doesn't have a knob to do this but according to [1] you can turn off rc6
>> in the BIOS. Might be worth a try.
>>
>> Matt
>>
>> [1] https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/14469
>>
>>> Matt
>>>
>>>>    Thanks!
>>>>    Tales
>>>>
>>>>
>>>> Em seg., 3 de ago. de 2026 às 23:14, Tales A. Mendonça
>>>> <talesam@gmail.com> escreveu:
>>>>> Hi,
>>>>>
>>>>> This series is a follow-up to the TLB invalidation ack stall I have
>>>>> been debugging on ARL, tracked in:
>>>>>
>>>>>    https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
>>>>>
>>>>> Summary of the issue: with GuC 70.53.0 on ARL (reproduced on 7d51 and
>>>>> 7dd1 machines here, plus an independent Arc Pro 130T report on the
>>>>> issue above), TLB invalidation acks intermittently stall for ~2.3s.
>>>>> The H2G request is consumed from the CTB immediately and the G2H CTB
>>>>> is empty the whole time - the firmware simply does not send the ack
>>>>> until much later. The fence timeout fires at 2.25s and the ack lands
>>>>> tens of ms after it. Userspace blocked on the invalidation (compositor
>>>>> buffer unmaps etc.) hitches for the full window.
>>>>>
>>>>> Patch 1 adds xe_devcoredump_gt() so this kind of hang - which has no
>>>>> exec queue or job to blame - leaves a devcoredump with the GuC log and
>>>>> CT state behind (Matt suggested capturing devcoredumps when we
>>>>> discussed the issue; devcoredumps from both machines are attached to
>>>>> the issue above).
>>>>>
>>>>> Patch 2 logs when the ack for a timed out invalidation finally
>>>>> arrives. This is what established that the acks are late rather than
>>>>> lost.
>>>>>
>>>>> Patch 3 is the RFC part: a delayed work that pokes the GuC (status
>>>>> register read, CT flush, doorbell ring) every 250ms while an ack is
>>>>> overdue. On my machines this converts the guaranteed 2.3s stall into a
>>>>> sub-500ms hiccup for the majority of occurrences; a minority of severe
>>>>> episodes ignore 8-9 consecutive doorbells, which points at the GuC
>>>>> firmware being internally blocked for the whole window. Full data on
>>>>> the issue. I am happy to rework the approach (different delay,
>>>>> tying it to the G2H handler, dropping the status read, etc.) - mainly
>>>>> I would like the firmware side investigated, since no host-side poke
>>>>> can fix the severe cases.
>>>>>
>>>>> Based on drm-tip. Tested for several days on both ARL machines under
>>>>> desktop and VM-heavy workloads.
>>>>>
>>>>> Thanks,
>>>>> Tales
>>>>>
>>>>> Tales A. Mendonça (3):
>>>>>    drm/xe: Capture devcoredump on TLB invalidation timeout
>>>>>    drm/xe: Log when a timed out TLB invalidation ack finally arrives
>>>>>    drm/xe: Kick GuC while TLB invalidation acks are overdue
>>>>>
>>>>>   drivers/gpu/drm/xe/xe_devcoredump.c     |  68 ++++++++++++
>>>>>   drivers/gpu/drm/xe/xe_devcoredump.h     |   6 ++
>>>>>   drivers/gpu/drm/xe/xe_tlb_inval.c       | 131 +++++++++++++++++++++++-
>>>>>   drivers/gpu/drm/xe/xe_tlb_inval_types.h |  42 ++++++++
>>>>>   4 files changed, 243 insertions(+), 4 deletions(-)
>>>>>
>>>>> --
>>>>> 2.55.0
>>>>>
>>>>
>>>> --
>>>> Com os cumprimentos,
>>>>
>>>> Tales A. Mendonça
>>>> talesam.org
>>>> communitybig.org
>
>

