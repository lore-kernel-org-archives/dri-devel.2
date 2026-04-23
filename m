Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C929FDEE25
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 16:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE53910E340;
	Thu, 23 Apr 2026 16:35:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="h5J8EGFW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD6210E340
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 16:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776962145; x=1808498145;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=eF0DMNDRApHE8tZ929IQqcyoxDmEi08RXpcTwdofkow=;
 b=h5J8EGFWjpbHgp1ZdsHGPHkQ2PkFpV0dJxvZgrCk2gkSfyEzMUrmdhe2
 PpqLUK9km2+Sh7JQQlwGVvLHgi1AYX1Rbw8vhB/a/YeR7W+B4077613F0
 oIlPcoaOFMKe73M3R4BcdLRc+jDNzWA4qJoA9g6W8RHot1Ac48pIgN4D2
 VQzr/VmbBJuO2PB7rShN16locbKCqKN0lGHAihuZZv2z1inFscv1ZSx7Y
 640hKvc+B8XnrmBWb5P0KhLY+nbl3521A1yMUhVfgplXiC2yrF2VInE9q
 wKqNfDyxolKrlrBFWqQ7kIF3dkv66zdZfsAwbEnF78fMnHolWGwAGWMU1 Q==;
X-CSE-ConnectionGUID: kht7WknQSu2iOn/2MV/t7g==
X-CSE-MsgGUID: ZfmCU9XBQASu5u6pr0/fnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="77849695"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; d="scan'208";a="77849695"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 09:35:45 -0700
X-CSE-ConnectionGUID: w+AE2G+aTm+QRaS7iXg2NA==
X-CSE-MsgGUID: rl2TvaJxRzeQvB82sI6PNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; d="scan'208";a="228134082"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 09:35:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 09:35:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 09:35:43 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.4) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 09:35:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ux4wz0mOnX6Gn5uAKKxSlOKy2tKPMs+yM+rjcGlHJu/E3sJ9Z10aHsuhOifqXAPAvnYJXBgLtZiZnq9uyHExcOxwBJ9mOIt+KeiQ83Q7jcy8+svnZ1VWa52ihvqtuvuTV7bF+3VEgjRfwXcHJbcp4hILGNRlzKtmDHDYZQhcB1WOumUXIJsXVZfLWmBqG+j4lwtMqESfSj0mPmifxHWW6EK9Fpf2dHyHp0jqc4rfvEOZsP/82UgkHmXSUwlWNaxdGkWYcpaM8/Rbo+OsyjEMS+GboDxlyLlQusJTw3SSmabnUm9UWHzP8SJw6iyhLdoAFhtFHmoj8TmNF8jE+U3ylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aW2jKzOY2Mgreu7iOtLK1bZXY5nPuJJ586EMGGiQ5lM=;
 b=Ih+OUzf/rtnq3XGSMI6hXLMg0k2nNpvSAVyExpzArXKDKmYxbgPAV8auhq1OjVpyjk6i672/yxwDqHWV9+u8DXmcSj7Ab3giVIVCSKCl481DT4wc0G9Awf523dUfYaxTFzRJCUWAH1U5Sw6sX06Ck7eAYCsx76KN1omc+0BpCrHpUlvg2AG/lLtugdbeDWg36GZjeiPFYr4oxbHU8yjYajwds9bu4q5KHdlj+KJLun0CJCBNgEuFIMx9PjQS8DMU9lco6U/UEe2RCMOPNqLBDhZqCUAgQNBYAQLhxOz0igie6qDDGm8Ks+8sv46hTWsiYoxdtcO5MQS7ecSSlyUjsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.21; Thu, 23 Apr 2026 16:35:34 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 16:35:34 +0000
Message-ID: <6ec01703-31e0-4998-9508-a5a115ae7bc9@intel.com>
Date: Thu, 23 Apr 2026 09:35:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: further issues with MGA G200 graphics chipset
To: Thomas Zimmermann <tzimmermann@suse.de>, Jocelyn Falempe
 <jfalempe@redhat.com>, "airlied@redhat.com" <airlied@redhat.com>
CC: <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Pasi Vaananen <pvaanane@redhat.com>
References: <76aba88d-ec23-4b3c-ad91-83face0c3e94@intel.com>
 <a9d176ec-d19b-4f41-af16-cdc4e475a8cc@suse.de>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <a9d176ec-d19b-4f41-af16-cdc4e475a8cc@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0220.namprd03.prod.outlook.com
 (2603:10b6:303:b9::15) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|DM4PR11MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: 16820472-4596-4110-6e2b-08dea1565748
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: k3GuOOfqr9IE0aVsRswbaNqOkVIbRztXnDZD9ZxPit89spYTT7OgKRt5XXTiSZNiO4hpE0NT7JldulCxLjWvuTwur5285hH5baEHN2r1P0PUBFpUN/yP1l0T9PTa4vi6uh8ejhHa/Zff/jZtUV069tLr01gSyw4jHl0/mV2aEyHLZOpbmw9MbCK9L5WyUMPJoKcAwdDrL7y2ZRISfKvWbRqVv+A4EuIsY5sxXWB+IFanytnR3AceD07gNmPk+7s6i405b2RNjyUXf+rJx9OTks6QBHcvY/+/miEawghhkkevl8KhcogNYuWtQK/wxOW3y3fKsdU4xMZCn6Sb3jModuSGE0i0Icu4LT4rrf5xrNTfGy35WR2Yed6fmb5/aqEb/XWyK8wVyHvfmFEQu+Fn/hEXOOFH1CT7FJlCHnYy6iqzro3kLq3Wf9ihtrQvyxB2pj4s4nxkcCTMVqCyd+aC3RWeSPxlQ0cYqIGZ1GIKvhqPmXI5im6VUFsbcd0mOw9jrDpnmFTbZWTAUMwSNJso4l+PVf+xiUUaJUG/H6EMms6EvQHmKgSst3jtwLmkuLzYBXD14fwzS8zR6FbO1CtjiY0LZP8Nfd01LvhK7Xk4K/zpb4LDhgOk1k8NBRTorKHuBPQPwf9gyQJblaY0hLgSSt86QqxFf8rZFD3By7O3SBqazcjJVkOsyioM772nDxQ1anwHnDwJJW1/LCg1mOIU7QL6qeLXdZAGl1f2OuYWyASn8bJ9kVwLYzR9G7xmcgfq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7579.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm5YTG0ySTYrK3VlQTE1dXV0aVExWnJMVkVualQzYU9QVzZscWF6Wjd3TEhi?=
 =?utf-8?B?V1hLR1VtRGRlNFloRTNzSkZqNko4bXNnQ0VTQUtzQ2RuSzlTZktQYjZwbC9o?=
 =?utf-8?B?OHVFZ3F4UzJaam1IdmNQR1pjZ2VaTi93eFFUMnNTUFp2Z0cwamEwUFhBWDFr?=
 =?utf-8?B?bE1oVmhBaFB3K2krUzdHMkNZd0F4ZldkZWlyTUhMSDRpMDBwMEpDQndUc1Vv?=
 =?utf-8?B?ZFU0OEVsd0ZIUEpUUTN0dy9WV0FVRnR1dFp0WlZsaUdvVEVFZWJVbkpKc045?=
 =?utf-8?B?WEI3cmw2M2lYWUF4U1E4c2gyN0RzQ2RSOVIxcTROTWZxcVc4Q1ZDYlN4cG9M?=
 =?utf-8?B?WVFzU2VBU25mZjFCYjByWExVNXRJT1lEZGVHeVFBcGp0Tk51b3grY3dXV29p?=
 =?utf-8?B?ek14NkhSZkZ3dkhNK3c1WlRmYTg5QzFOelY5UHd5Y09HMGhNT2NvVzZxbmIy?=
 =?utf-8?B?cWhyeXc2aUlXQ25tZjVuMFN3MXJuN3ZySW9sVVFFOUFMQmZpNmEzOWVsa2hL?=
 =?utf-8?B?MWZmWmVtTUJ3VG9RdFJlaTJPWHkzd1k5ajE2aWxIN3R2ZGVob3ZUMmhMTlNU?=
 =?utf-8?B?K2t1VGVXbW0yNXNZeVh6WU5td2tkdnNoOHpTVUwrWWZqSEFXRWhUbjZCMitS?=
 =?utf-8?B?UkYzbFB5WnhVL0kzR2hsT3A4Q1liOWhBd25LRlRIcVpLdVlCOWs0TEk1RmR6?=
 =?utf-8?B?c25zOXBMbm84OHZpRFRzc0xKNmNsOEhFSEhENHJJbUJwbmw5S3A5WkFpYlhW?=
 =?utf-8?B?c2FUOHR1dFpVc281cFJUZCtGejU1cE1kZ0FWNk5pVVVHUDlqSzdmQkE0YVJB?=
 =?utf-8?B?R2F5U0lBcXJCUXRzNDZrZXh6Y2NmamI3cWJ1WjhrLy81SGMvRHBPSFJPK2dQ?=
 =?utf-8?B?cFE0MzRjTFJyUFRweDlSdXQyM0hoQjlSZmtCMkswdGxxQ3UybWU2TWdweWFJ?=
 =?utf-8?B?RG1DNVp4Y3pza2pHeG1lb0ZBSWx6U1piL05JaE5zMXRIcy9TTzV1RGI4WGhN?=
 =?utf-8?B?MXFsdFc2WmNHcGZBWlA5bjR1V2RiMDI5dFdPUVJydzlzWnNwanVhUE5IV1g2?=
 =?utf-8?B?SXQxRVVuVE1ENkc1UlM2RWpZK1BMRW9MVHRmcjF5NWxnYUVlcVl5Vis1bG1m?=
 =?utf-8?B?MXJRTjRtdm9JNkphOGdxWjVDTlBLVTd0T09zNTNQOEdLbmtLTHpsYzcwVno5?=
 =?utf-8?B?QmJNT1lXNnZBYTd5R0RpSzF5aStDTjJaUjR3QlhVRkZ1a2dVWWVTeEc1bGtI?=
 =?utf-8?B?a2ZaSkJpZEhuR0Fod1c5OExVQ2JyQ1hYTzNTbzV3MTVaYVBnVjkxUENkZzdy?=
 =?utf-8?B?czdnUktTYS9YOVBpUi9xUW1IRkxnVVpGR0hmTi94b2lhbEhFY1p0NHdxRFhJ?=
 =?utf-8?B?SmVPL0pSak9wSXNLVGVUUm1iR1Rra2xlWXhiMU9BVTRkYVduMnFPb1ZtUkt0?=
 =?utf-8?B?eU1FdnJZQUs4eklZTDJ4aHVrUHd6cVJVTVpLU1ZUZVBHUVdZT0tYUmtVT3A4?=
 =?utf-8?B?QUc2d2lxdVFCa2ZrdXhUaHQ2bWwxRFc0SVd5SUQ5cUpPZklVNDVRczdjMHI4?=
 =?utf-8?B?TkxKTzNwUmVIczdLODRkUU9KVWJxbzZJQmtUZS9YUGlFazgrbkNaZzNEaGpa?=
 =?utf-8?B?S3hvZHZtK1h4a2tPNVBIemVHK3RRWGx5LzVsWEVSSnpvOXgwQ3dnQ0NETlhy?=
 =?utf-8?B?Q3hlb1RaRmJaTmptcFdjWkp6ZFdQU01ud04zNkxZaTZOeUFQbkJqbUdTcU9k?=
 =?utf-8?B?TEpUMGxaQ2RWYWhyKzRxU2pNRUROVlRTeUpmUzYweWF1WEU4TU1TRmtIUElX?=
 =?utf-8?B?NGh3RS93M0JUeEN1VjhFR25CSFkxZzZGQTBUZGIyTm1uWXVUc3VUQ0kxbVZi?=
 =?utf-8?B?UW52bVdBMHlpSkxBbFhCVWVQVVhDV1Q4TVBnZE9XWms0VjlnUFEvWGJxZ08x?=
 =?utf-8?B?dnBlV3VkQW1vV3E2WmJ2L09mUm5qSTRDZ2N5UTh2Ui9RY0lIVjZHUkp1dk8v?=
 =?utf-8?B?Y282ZEV4NkhyTHQyZ2pRVFZMb3NIcHl1WFo4K0VkM3JydU9tNkNOWlBWU0lt?=
 =?utf-8?B?cUEwQktaekFhY0o3dExVcHpRcHNCWU5aK1RYbG5WYW05MWhKakZqako2UDdH?=
 =?utf-8?B?aWJjNDVSYVBJQ1k2MDRVQkhmQ1VUUjJHbHNGVXB1Y0Q4YjhQbXVwcEMvM0Zh?=
 =?utf-8?B?U0NlTVBBL0dsYnBtSDIzV3dDSC80aTVWdFAycHNZajIzbURjL3pQaUFqa096?=
 =?utf-8?B?aE1iR3JIUFFjSTg5NlNtUE5sbWhWT2kyTGZ2MHM0eVFUNGJQQ2ZJSDVRZmtp?=
 =?utf-8?B?dUtCZi9CR0VxOVZBamdQK2FoVFMzN3RzNWRHN3dBTlFVQkgrN2N0d25GZ0FP?=
 =?utf-8?Q?sHF2sPzuuiMyAaPc=3D?=
X-Exchange-RoutingPolicyChecked: CghlwrE7LDpt5AwGy7FK/2swUXX/sfVzWU0yQnldeM2DKcOqr2DXMUTW3tEFXU5VCcZdGlxewiScy9miLSTCckcJYB8CDjnFp4yUBGv7lDpLLQDnErkIFt+pzx0akcB1eOq055zNhAJoByq4xtSsYFhOqunkDc0SdsfFu/8OMeD0drAkbiC2Ts+m8il+1rVZD2mBCt6xpQpt9HPAQsIJATHJUyk4oivGo59e6YMrLenQ9aH2Ei/br0MxOLhKrcX+MhHY+Ekr3vBykzOdPgpXJIuI21AcXZUMYNDpsOhU3qd/shk/HMT+WeTBR2Rm88hNO2Gsnb0IvMgidQy+EdU94A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 16820472-4596-4110-6e2b-08dea1565748
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 16:35:33.9351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnPaWvpV4zWq7SeCBadRA6wQMIRo10JjVUo5/tTQ79r+RW0sqRiuC4nasN2PdxC3oXaWF7EbbmmptAhp5gTINNv2PLDBpku4luc//Sde3ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6455
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

On 4/23/2026 12:44 AM, Thomas Zimmermann wrote:
> Hi
> 
> Am 23.04.26 um 01:55 schrieb Jacob Keller:
>> Hello,
>>
>> You may recall the issues I recently reported and submitted a fix for in
>> the mgag200 DRM driver from [1].
>>
>> [1]:
>> https://lore.kernel.org/all/20260202-jk-mgag200-fix-bad-udelay-v2-1-
>> ce1e9665987d@intel.com/
>>
>> I recently have been running into another issue with the mgag200
>> graphics driver on a similar platform. I noticed occasional spikes where
>> Tx timestamps from the ice driver were delayed, very similar behavior to
>> what was going on with the original bug report. However, this was on a
>> system running v6.12.76, which contains my MGA G200 usleep fix.
>>
>> I analyzed the data with perf and have discovered what looks like
>> another issue where the mgag200 polling routine is causing us issues.
>>
>> Here's a perf report which captures the cycles samples between the start
>> of a Tx timestamp request and the point where we report it to the stack:
>>
>>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k]
>>> ret_from_fork_asm
>>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k]
>>> ret_from_fork
>>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k]
>>> kthread
>>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k]
>>> worker_thread
>>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k]
>>> process_one_work
>>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k]
>>> output_poll_execute
>>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k]
>>> drm_client_dev_hotplug
>>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k]
>>> drm_fbdev_shmem_client_hotplug
>>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k]
>>> drm_fb_helper_hotplug_event
>>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k]
>>> drm_client_modeset_probe
>>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k]
>>> drm_helper_probe_single_connector_modes
>>> +   89.87%     0.00%  kworker/65:1-ev  [mgag200]                 [k]
>>> mgag200_vga_bmc_connector_helper_get_modes
>>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k]
>>> drm_connector_helper_get_modes
>>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k]
>>> drm_edid_read
>>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k]
>>> drm_edid_read_custom
>>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k]
>>> _drm_do_get_edid
>>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k]
>>> edid_block_read
>>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k]
>>> drm_do_probe_ddc_edid
>>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k]
>>> i2c_transfer
>>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k]
>>> __i2c_transfer
>>> +   89.87%     0.00%  kworker/65:1-ev  [i2c_algo_bit]            [k]
>>> bit_xfer
>>> -   59.65%    59.65%  kworker/65:1-ev  [kernel.kallsyms]         [k]
>>> delay_halt_tpause
>>>       ret_from_fork_asm
>>>       ret_from_fork
>>>       kthread
>>>       worker_thread
>>>       process_one_work
>>>       output_poll_execute
>>>       drm_client_dev_hotplug
>>>       drm_fbdev_shmem_client_hotplug
>>>       drm_fb_helper_hotplug_event
>>>       drm_client_modeset_probe
>>>       drm_helper_probe_single_connector_modes
>>>       mgag200_vga_bmc_connector_helper_get_modes
>>>       drm_connector_helper_get_modes
>>>       drm_edid_read
>>>       drm_edid_read_custom
>>>       _drm_do_get_edid
>>>       edid_block_read
>>>       drm_do_probe_ddc_edid
>>>       i2c_transfer
>>>       __i2c_transfer
>>>     + bit_xfer
>>> +   59.65%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k]
>>> __udelay
>>> +   59.65%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k]
>>> __const_udelay
>>> +   51.11%     0.00%  kworker/65:1-ev  [i2c_algo_bit]            [k]
>>> sclhi
>>> +   30.22%    30.22%  kworker/65:1-ev  [kernel.kallsyms]         [k]
>>> ioread8
>>> +    7.30%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k]
>>> delay_halt
>>> +    7.30%     0.00%  kworker/65:1-ev  [i2c_algo_bit]            [k]
>>> acknak
>>> +    7.29%     0.00%  kworker/65:1-ev  [mgag200]                 [k]
>>> mgag200_ddc_algo_bit_data_setscl
>>> +    5.02%     0.00%  swapper          [kernel.kallsyms]         [k]
>>> secondary_startup_64
>>> +    5.02%     0.00%  swapper          [kernel.kallsyms]         [k]
>>> start_secondary
>>> +    5.02%     0.00%  swapper          [kernel.kallsyms]         [k]
>>> cpu_startup_entry
>>> +    5.02%     0.00%  swapper          [kernel.kallsyms]         [k]
>>> do_idle
>>> +    3.60%     0.00%  swapper          [kernel.kallsyms]         [k]
>>> call_cpuidle
>>> +    3.60%     0.00%  swapper          [kernel.kallsyms]         [k]
>>> cpuidle_enter
>>> +    3.53%     0.00%  swapper          [kernel.kallsyms]         [k]
>>> cpuidle_enter_state
>>> +    2.57%     0.00%  kworker/65:1-ev  [mgag200]                 [k]
>>> mgag200_ddc_algo_bit_data_setsda
>>> +    2.14%     0.00%  perf             [unknown]                 [k]
>>> 0xffffffffffffffff
>>> +    2.14%     0.00%  perf             perf                      [.]
>>> __cmd_record.constprop.0
>>> +    2.14%     0.00%  perf             [kernel.kallsyms]         [k]
>>> entry_SYSCALL_64
>>> +    2.14%     0.00%  perf             [kernel.kallsyms]         [k]
>>> do_syscall_64
>>> +    2.14%     0.00%  perf             [kernel.kallsyms]         [k]
>>> x64_sys_call
>>> +    2.06%     2.06%  swapper          [kernel.kallsyms]         [k]
>>> intel_idle
>>> +    1.31%     0.42%  perf             [kernel.kallsyms]         [k]
>>> do_sys_poll
>>> +    1.31%     0.00%  perf             perf                      [.]
>>> fdarray__poll
>>> +    1.31%     0.00%  perf             libc.so.6                 [.]
>>> __poll
>>> +    1.31%     0.00%  perf             [kernel.kallsyms]         [k]
>>> __x64_sys_poll
>>> +    1.06%     0.00%  systemd-journal  systemd-journald          [.]
>>> 0x00005d6bb7cb3f64
>>> +    1.06%     0.00%  systemd-journal  libc.so.6                 [.]
>>> __libc_start_main
>>> +    1.06%     0.00%  systemd-journal  libc.so.6                 [.]
>>> 0x00007d6ce3a2a1c9
>>> +    1.06%     0.00%  systemd-journal  systemd-journald          [.]
>>> 0x00005d6bb7cb389e
>>> +    1.06%     0.00%  systemd-journal  libsystemd-shared-255.so  [.]
>>> sd_event_run
>>> +    1.06%     0.00%  systemd-journal  libsystemd-shared-255.so  [.]
>>> sd_event_dispatch
>>> +    1.06%     0.00%  systemd-journal  libsystemd-shared-255.so  [.]
>>> 0x00007d6ce409d413
>>> +    1.00%     0.00%  kworker/65:1-ev  [i2c_algo_bit]            [k]
>>> i2c_stop
>>> +    0.83%     0.00%  perf             [kernel.kallsyms]         [k]
>>> perf_poll
>>> +    0.83%     0.00%  perf             perf                      [.]
>>> record__mmap_read_evlist
>>>
>> As you can see, in this case we are spending +60% of the cycles in
>> delay_halt_tpause which is part of the bit_xfer function for
>> implementing i2c.
> 
> That's from the DDC's i2c channel, which we poll on regular intervals
> when we update the connector status. Dave's suggestion should at least
> mitigate the problem.
> 

Right.

> 
> Polling the DDC involves acquiring locks so that it does not interfere
> with display updates. These errors about drm_fb_helper_damage_work() are
> fallout. The function most likely waits for the DDC polling to finish.

Makes sense. I'm still wondering if it makes sense to convert to
WQ_UNBOUND so that the task doesn't get bound to CPU and (hopefully?)
doesn't cause other critical processes like IRQs to get stuck when they
*happen* to be bound to the same CPU? I'm not entirely sure. It seems
crazy to me that this simple background polling thread stalls my IRQ
from executing for 30 milliseconds, but that appears to be what is
happening.

I am guessing that refactoring the i2c-bit-algo to allow usleep is not
really possible either, so we can't make this part of the logic actually
sleep instead of busy-waiting.. :(

>>
>> I do noot understand exactly what is causing the driver to get stuck,
>> its something in the i2c routine for reading the EDID block.
>>
>> I also see this being printed:
>>
>>   EDID block 0 (tag 0x00) checksum is invalid, remainder is 125
>>
>> It appears to print quite consistently every few seconds. I guess this
>> might be possibly related to a bad EDID block on the mgag200 device?
>> What does this even mean?
> 
> The monitor's EDID is wrong. This is likely another fallout from the issue.
> 

It turns out that the platform doesn't even seem to have a physical VGA
port. This makes me suspect Dave's point about a cheap resistor is quite
plausible.


>>
>> I am not sure how I'd go about verifying this, or root causing what is
>> going wrong.
>>
>> It looks like we print the message as part of _drm_do_get_edid(), and
>> this definitely is called as part of the mgag200 routines:
>>
>>> -   33.33%    33.33%  kworker/64:1-ev  [kernel.kallsyms]  [k]
>>> _drm_do_get_edid
>>>       ret_from_fork_asm
>>>       ret_from_fork
>>>       kthread
>>>       worker_thread
>>>       process_one_work
>>>       output_poll_execute
>>>       drm_client_dev_hotplug
>>>       drm_fbdev_shmem_client_hotplug
>>>       drm_fb_helper_hotplug_event
>>>       drm_client_modeset_probe
>>>       drm_helper_probe_single_connector_modes
>>>       mgag200_vga_bmc_connector_helper_get_modes
>>>       drm_connector_helper_get_modes
>>>       drm_edid_read
>>>       drm_edid_read_custom
>>>       _drm_do_get_edid
>> This makes me think that we're reading a bad EDID. I enabled drm.debug
>> setting to get more data:
>>
>>> Apr 22 23:47:11 1762811 kernel: EDID block 0 (tag 0x00) checksum is
>>> invalid, remainder is 125
>>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0:
>>> [drm:connector_bad_edid] [CONNECTOR:36:VGA-1] EDID is invalid:
>>> Apr 22 23:47:11 1762811 kernel:         [00] BAD  00 ff ff ff ff ff
>>> ff 00 ff ff ff ff ff ff ff ff
>>> Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff
>>> ff ff ff ff ff ff ff ff ff ff
>>> Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff
>>> ff ff ff ff ff ff ff ff ff ff
>>> Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff
>>> ff ff ff ff ff ff ff ff ff ff
>>> Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff
>>> ff ff ff ff ff ff ff ff ff ff
>>> Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff
>>> ff ff ff ff ff ff ff ff ff ff
>>> Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff
>>> ff ff ff ff ff ff ff ff ff ff
>>> Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff
>>> ff ff ff ff ff ff ff ff ff ff
> 
> This EDID has a correct identifier in the first 8 bytes and the rest is
> garbage.
> 

Yep.

>>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0:
>>> [drm:drm_client_dev_hotplug] fbdev: ret=0
>> Does anyone have any idea whats going wrong here? A google search seems
>> to imply this is reading the EDID data from the VGA cable...
> 
> The HW is probably broken.
> 

Right. I thought we had a KVM dongle plugged into the VGA port, but
further inspection shows that there doesn't even appear to be a physical
VGA port on the system, and the mgag200 is only used for its BMC
connection! (We have a mini display port to VGA adapter in use, and I've
asked the team to swap that out just to confirm its not related)

>>
>> I'm also curious if its possible to stop polling for so long with udelay
>> in the i2c logic somehow? I am not very familiar with i2c, but it is
>> frustrating that this driver is causing yet another stall that is
>> impacting timing sensitive data. Even if in this case its due to a
>> faulty cable.. it is frustrating that such result causes the PTP
>> failures. Would switching to WQ_UNBOUND be helpful here at all?
> 
> Try Dave's suggestion to avoid polling.  The driver won't be able to
> detect changes to the connector status, though.
> 

That's fine. I don't think we're even using the device. It looks like it
might only be in use for BMC, and the VGA connection isn't actually
physically available, so there are no changes to detect.

Is this polling really only to detect when VGA is enabled? Would it make
sense to only poll on platforms which actually *have* that VGA connection?


I'd like a solution where we don't have to go to each individual
customer and have them ban the mgag200 driver or set some kernel
parameter like drm_kms_helper.poll=0 to prevent issues. If the VGA
connector isn't even available to *be* plugged in, then it doesn't make
sense to constantly poll to check if it was...

Many system admins likely aren't even aware of the devices existence,
and it ends up causing stall issues like this, which for timing
sensitive tasks results in service disruption.

It is unpleasant that the mere *existence* of the device+driver causes
such problems.

> Best regards
> Thomas
> 
>>
>> Thanks,
>> Jake
> 

