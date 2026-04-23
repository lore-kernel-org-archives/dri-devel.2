Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6FFFDEE4D
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 21:18:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5E0010F286;
	Thu, 23 Apr 2026 21:18:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GYLTr6me";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F26A10F286
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 21:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776979122; x=1808515122;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MuXHltAQThkYl2epYDR7ipZS87MbZjEk5VklscZUVQ0=;
 b=GYLTr6me/iK6uve9/yyhkmwA1x2hFgYqWdvtwBEhgiZgxaAXNz8iWuq0
 Nx9UsWLGFMS5DDx0GuZlp0Uspwq/nqMMi0V9LUTv35HXWyte9jdaLgXsU
 9z9T3rTmqa2cbSNoZkVtV7wSxjf+P8AHZS0R1q1q/q7yrB1bA02ayhoJo
 ltk9E88b5wN4SqX9c8O2UWcMsSz0iS7/VMqZC0mv2wCpP5jBN2aG7GAwO
 UEZHiQk9ZRKEAfCKHCgueb+Ym4gElC8q60RKdNQ55V3+cRKBLd/pAL8Qd
 SuxDvycMDlxCZwaTBBs2gJ/D/to+kevPocSigu9aqbUD6et52wKVRflmX w==;
X-CSE-ConnectionGUID: u5Tznl7cSmW1bBhnJcV82g==
X-CSE-MsgGUID: FzaHfEsDTl2Zs94hsUShDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="78020662"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; d="scan'208";a="78020662"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 14:18:42 -0700
X-CSE-ConnectionGUID: pyyXMe1mTdy1M87ujBBb4A==
X-CSE-MsgGUID: yQbCNqu1QIqsBqzgpFjXTg==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 14:18:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 14:18:41 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 14:18:41 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.61) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 14:18:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKUhDq7145tdzYcypULj/JH7SC2cgmHV1PhmOgHic9KpNay1imkwgk1R2qNgHr7yJMa1w+E5vnW/M98dL+3N0PoOUg45bpz9FcgkXQWoBN/CaTDYmB/s/GXjJkL1kZEoIGgE8mtMf7RYVIRuFf1jMEtTK+hEilbhUEqkxFgH4lwc70bDu/SpTlhG6FJsYQ/G0Mpa62fG76WK+s0S4uzVshLKdYKAUVr7ftqRricMibKiWasl0V8hPrPdfxgW8ogwe6XFKsFVTr/8csQD5gfWmlw/e83vvvI0pL4pIkfrZR9Kihp35AsdXoYfDxFrsaIRgeSiHNzD9Zr+pRowOObaAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yH461nfcf/QBTsdds2Um183kTLDBdqbwc5SGTbIKYyA=;
 b=E9A8CBOPI/FwPdVlxkRsIYPY+puri6DcUf9b9mVF5nNlGZweA9AfXY269unvYUU583UAJEYfic6XR6952/okg9TMkJTA+OIVKz1B0FqmB21FL2v6TjXzNrsPF/WYzcDu9+NuVuM3HCcGgvhm6FeLGhcFcXYSVuctMx3QuC2I4/h+vsPrQuGsjIT6H+hMp/w/qxNFGPa8YTcvbFPKuBd2TJYQpKQ628f6kGb1V5NN0P6Ob46n8vyZGbWZMYjLPL+77BKU1NKogRRJ33BH8XJitNnmLyLAJkk04OtazEX39GHQxymznQF/9UHIyknyQtNsVNWB4NBrvVDaNmehRgkhOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 CY8PR11MB7313.namprd11.prod.outlook.com (2603:10b6:930:9c::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.21; Thu, 23 Apr 2026 21:18:38 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 21:18:38 +0000
Message-ID: <8650b05f-4c13-4897-af4e-0749cdfd0942@intel.com>
Date: Thu, 23 Apr 2026 14:18:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: further issues with MGA G200 graphics chipset
To: David Airlie <airlied@redhat.com>
CC: Jocelyn Falempe <jfalempe@redhat.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pasi Vaananen
 <pvaanane@redhat.com>
References: <76aba88d-ec23-4b3c-ad91-83face0c3e94@intel.com>
 <a9d176ec-d19b-4f41-af16-cdc4e475a8cc@suse.de>
 <6ec01703-31e0-4998-9508-a5a115ae7bc9@intel.com>
 <14aa4840-29c4-46df-b60d-8e1b92494ad2@redhat.com>
 <e9cca01c-960d-495c-aaba-327eac43cad6@intel.com>
 <CAMwc25o=3EHkJYG=qYrgtmmB9raqbsaif6hOKLi0awG-ydWZWQ@mail.gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CAMwc25o=3EHkJYG=qYrgtmmB9raqbsaif6hOKLi0awG-ydWZWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:303:83::16) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|CY8PR11MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d28b0a9-7760-4453-279d-08dea17de29f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: dzIn5nYzAJh6p6UaZ2o2rXNvXwkmQ0cmIOctzGB1l03xxqkfMubWdxuhsKEpXK/4xfOfOrVaIk/vJ4CmWxOeDZ/Y3sNwtpgaFsJR/z1wrFhJUlYgJ3sXRJXj/ggqM1vI7P2UHk563ukASIyxhA4kzhSz0qSnvyl0cKp6ZuPwmWoSm/r6L5fMytWJXsfJ8HmdDj38hOcae86VVUhabd68HElWVteuK0lp3kcqz7pC9CxG9Y006VDTBhR9JoNIJOuUXX47paxG94PT5Vx+C6jWXKfu/oa0vHZaGl5sGv1hx8kl5kEUAPdWayvWku7mkyhJnAHjxIemKNb2uCB+jtUlFjvwK/F1INH8UAQmH174mDERKwqGm4cOB6QwB8pVeSn5o4oLHqZJ5SzBF/N/s9bgyKPUFxMq2OXKBF7u9sa24Br4SXPeZfvN6e/2W3kpPtnCJ0rpcxRvoRJRgWtyKyLzGD0l1ypfMbBk8wTRk2A1QDway+NJINeBjmwn11tImCcLnZ7nrsxOh5beQg0q4MjTfNiGf1o9oyLMm118tGYkxwHZ7OXXUgPwYgPwLgdz6tY364d3qaYc6id8fLqK4HKxygGSGzhZb9eXbhAOSfF2xSJv8SYPJmWoV2BX2FeYcLUCA9rbBGM7e6CmSlFGiKs8IS3gsLkI0gHGb/r94VsPPEctkvsG/6Pk4vV4K3Qx1MdP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7579.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elJHNkl4ai9HMkNtcjdFZU44Y2lJZlRwdGtVTDIvM3FzR0lHS2NWNHNOU3p0?=
 =?utf-8?B?RVl3VXorbkVyMGN4UXJJUWdodmlObXVQaFRDUXlhZWk0bXcwUnU3eUlIemlr?=
 =?utf-8?B?MW5mNTEzdkx5WXkxRDFkZUlaR3hBeUkvQkZnK1FTNld0VG9aNFlhQzhZNG1s?=
 =?utf-8?B?VnhqMExFZXIzWGlmOE0rZ2V5ZUtsUEhzWktXOXZFUXI1SFpxc1M2bVY0TCtp?=
 =?utf-8?B?ZXR0S3Z4YjYwSWtJSFJXUXlXRkMvRlhzQnJvazdPbmd3eEpJaTVUcjNvOWRa?=
 =?utf-8?B?SitrMHVCVkNkam01bHV4VGdTSlJtMGI0NitVVnN0UWU3QnpYYmZ6U2RwVkhR?=
 =?utf-8?B?WWNSSWNkUUorRjZ3cjlHU2RuWVhjS3A1ZmY1ald3VXNVei9LQU40YzJsVjIv?=
 =?utf-8?B?V1N0ekpJUERHWjRnTnlYUUJ2eTRlbGhvanBkWlV3VTNJNTRFQndNL1ZSR2xI?=
 =?utf-8?B?U0JrYjdQNk1XWDVwTThxVmY5bnM0UjZ4VFhvTkhoNEJZZHRaQkI5bXVuUmgw?=
 =?utf-8?B?dmU5bzZNYTdoOExzTDNyczN2L3Y0WXpJQW54cFZOb3dKcy9Dd0lDbTgrSDFE?=
 =?utf-8?B?aW1NNGkzaS9YY3gwRzNoNW1DWUhGaDdzdmN0RGQ3S3k4clVZcmhFN2RRc2ZO?=
 =?utf-8?B?TlVYRmt0RjF6OXZNbkc0ekJYRzlQRVNLZlhDbk5QVWpGWE1vaEZ2cFpQbmxV?=
 =?utf-8?B?dU5xbVVBbWZhR0krR3FLaDZ5VmZlS0FSNTRSWVdlMW5DRVBWREFWSFNLQmI5?=
 =?utf-8?B?M3ZRT2NSM0xpbUt2ZW5ndzU2WjhtOG9heW5QbXRORURaZnpPdmVmYjNodlU3?=
 =?utf-8?B?WVZwQzZySE1JMksyem9md05vMWx2NHBGYS9iZFRJakNKbUN6WGFEV1VLSzRF?=
 =?utf-8?B?TXYxNmhCVW51eTRnS1JUMHl5M1BxNC9SRWVMT0xxOXdEL2pKUTBXdlh5SnVm?=
 =?utf-8?B?MGk1ZExySHk5enp4eFl4NXRDRkR3S0VOVEl1dU45aWR3SGljUEF0T2lINlN5?=
 =?utf-8?B?UndhNEQrdFhCKyt6bjdYdUtrSzRCOElYUFBGVkRPR2ZyYlM5Z0RKQm9kRE9o?=
 =?utf-8?B?SnFoR1lFRFQxd2g0UUZ5Q1JRZUpHcm0vQUFybW9aNVZDVXI1WXZSZEhmUmRG?=
 =?utf-8?B?MkloVXIxenBNMldoeHUzMEEweUtWd3hUK3JuOFJkMkVEZVczejAvRmpneTd4?=
 =?utf-8?B?MTl5VnVZSGo0TC8xT1NtR3JtcWdhdWJ5S0p4NVI0Nlh5Ukw1WG9zN1VwYlJa?=
 =?utf-8?B?UmJQdThCcnc4SjRRWHBOeEZkTHhXMmhkZm15M3ZaT0l3a01tQ2Y4QXhvRUZ6?=
 =?utf-8?B?QlRuV0lCZzAzRzFTWXpiRzF5SE5ObG94V2ROczFWVHZLR0JVTjh2QU93RDN6?=
 =?utf-8?B?K1U5dFhZaG9hNEVEZGVQRlF2eGh3blltWGw3OCtFQWZNNkkwNUYybE5OOCt0?=
 =?utf-8?B?ejhKZE1kLzFvRUlPb24vSUUwYVFJcmJWcG1hYTRkQmtZNm12dlJRL1VQMUdm?=
 =?utf-8?B?bDVodld3bmJKK1hUVWtBejFIYjV1bEJSdlhkbjMzL3FjOVQ1YU9yanA1M0Zt?=
 =?utf-8?B?aTcrQzVBcU81cllzY0piZTBWcERKMmdESXo5WjRCSHNWR1A4ZlVwcFV3eHJ2?=
 =?utf-8?B?MkgrRXF2YlFQdmxPd0JNQkplakF0ZEV5eXViaUdQZmsxTnkyK0JMUGdPS0pX?=
 =?utf-8?B?OVAxdHUxTUtsUVRzYktKVUV2YnhNaVBIdEI1RTNYQkZRZDI2dmJYcEJScndO?=
 =?utf-8?B?WmM0Y3ljK2lTN0M3NE0zTklqSkdZTEVwbHVtR212S3RyV25XL0h1ZTlhbE56?=
 =?utf-8?B?dXRWSzMrS1h5UFZxdHF6NDJhV2dONUF4UHR5b2l0NlVlcVNoMmRoTU9FODE4?=
 =?utf-8?B?bk1QS1lBMmVIZzdGa1RQR1FsWHAwQkhaMDNWWlVEK25uNU1zU255Yk1FRkhV?=
 =?utf-8?B?QXVPSXV0d0lEcG9KS1ZrcGxDNkNHS0ZVb1pvL0ZUelJ2UnY1anhuODlucTFs?=
 =?utf-8?B?L1cySEpFZTV2aWdxck04T1JUT2J3ck5qZ3RXK3JybXVINDhhTzJER1oweUx3?=
 =?utf-8?B?MGNaNldxUE5IdW5YNnQvYnJRcExrck5mN3ZXR292RkZtRTRZYlJSQ2oyOVdE?=
 =?utf-8?B?QzU1V2RFbUdNckdmVVBCZXoyVFBCVW44Nmliemx2UGtCVzBBR1o4YjJlaXhY?=
 =?utf-8?B?azg1VnlKS2t2VU9kd0dxWHVPWkpSTzJmS3BPcHFXOEN2YU1aR0F6a0pCbzgy?=
 =?utf-8?B?OXVEZndFR1oxQzJueFptMGVpL1BCMHcwdzJjOXFRamhOZkMrTlZFZEx0NkRB?=
 =?utf-8?B?ZEFBWlA0ZGpEbVVwSXYwME1VekQ2TmVKbGtDc3N0MVAxTXpVOHNRd1c2Yi9O?=
 =?utf-8?Q?cC7f8RP6HEhK5SdY=3D?=
X-Exchange-RoutingPolicyChecked: YTHzTKmcYwr/SAtasBtw++l+gI5zx4xkAEmNPIMXgiEkyFySYxgQI9VmlbG4rWDt6qzNSqraxXXX77YKdjLhvxYiuYzJvQtpcsEifEYWWIAkLxRrst6Lg3eeO/RWzCWKtisPil4PM9xtD08DfZ0UzeyAuOkHgqEhVuXDa++IDcB+Ah4/BdGla4RkAKcsCDrugAiBwS4rrgA9OVhw/TfsJtDKSG8+E9ufTaFm26SR622WxOhnMTm3tBsbuNT0Yp1ynsrFLpejV57AFYfOz7aBdJp2DVJwX9SRrJebeTLQ6JCvUSu/G8cG+vj5iFkooNtROs2JSs1NvNOsEci1QbNxzw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d28b0a9-7760-4453-279d-08dea17de29f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 21:18:38.0178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mrxx0ANDya97Q2rCDmf9AfBwggPHYBmQO8o5sYywH8fP6Ee4l7YkLorHIfBceXVO8BCDlIrKoNTPlk3iuU9JkINYPd+ccwZli/ETp6/Psfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7313
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

On 4/23/2026 2:02 PM, David Airlie wrote:
> On Fri, Apr 24, 2026 at 5:42 AM Jacob Keller <jacob.e.keller@intel.com> wrote:
>>
>> On 4/23/2026 12:22 PM, Jocelyn Falempe wrote:
>>> On 23/04/2026 18:35, Jacob Keller wrote:
>>>> On 4/23/2026 12:44 AM, Thomas Zimmermann wrote:
>>>>> Hi
>>>>>
>>>>> Am 23.04.26 um 01:55 schrieb Jacob Keller:
>>>>>> Hello,
>>>>>> <snip>>>> I'm also curious if its possible to stop polling for so
>>> long with udelay
>>>>>> in the i2c logic somehow? I am not very familiar with i2c, but it is
>>>>>> frustrating that this driver is causing yet another stall that is
>>>>>> impacting timing sensitive data. Even if in this case its due to a
>>>>>> faulty cable.. it is frustrating that such result causes the PTP
>>>>>> failures. Would switching to WQ_UNBOUND be helpful here at all?
>>>>>
>>>>> Try Dave's suggestion to avoid polling.  The driver won't be able to
>>>>> detect changes to the connector status, though.
>>>>>
>>>>
>>>> That's fine. I don't think we're even using the device. It looks like it
>>>> might only be in use for BMC, and the VGA connection isn't actually
>>>> physically available, so there are no changes to detect.
>>>>
>>>> Is this polling really only to detect when VGA is enabled? Would it make
>>>> sense to only poll on platforms which actually *have* that VGA
>>> connection?
>>>>
>>> Polling was introduced with https://patchwork.freedesktop.org/
>>> series/131977/
>>>
>>> The driver needs to know if a VGA monitor is connected or not, to
>>> provide the right available resolutions to the userspace.
>>> Otherwise you can set a high resolution that works from the BMC, but
>>> then connecting a VGA monitor will not work, as the driver won't notice
>>> that something has been connected.
>>>
>>> The mgag200 doesn't have an IRQ or a register to check if something is
>>> connected on the VGA port, so the driver uses the i2c and tries to read
>>> the EDID.
>>>
>>> Unfortunately, there is no way to know reliably if a VGA connector is
>>> present. It's possible to disable polling on some machines using DMI
>>> quirks, but I don't think this approach will scale.
>>>
>>
>> Timing sensitive setups like mine must have system admins who know to
>> manually disable mgag200 or disable polling. Many users won't be aware
>> of this. If the polling were not intrusive, this would not be an issue.
>> But....
>>
>> Faulty hardware (perhaps just a cheap pull down resistor on the VGA
>> connection as Dave Airlie suggests) means that any such affected
>> platform has a polling routine that causes significant issues on any
>> timing sensitive applications.
> 
> We could write a patch to just say if we see 10 bogus EDID polls we
> just give up and loudly say in the logs.
> 

That would certainly be a better situation for me...

> This might break some crash-cart plugins in some data centers though,
> I don't think we have contracts in Matrox or the server vendors who
> make the hw to say how they recommend finding this info.
> 

But I could see this being a problem for data centers who previously saw
"no issue" and now see "this device is causing a problem", especially if
that problem is really non-existent?

> It might be in ACPI or dmidecodes.
> 

I can try checking if anything obvious shows up in dmidecodes for the
device.

> Dave.

