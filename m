Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A2EC55ABA
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 22:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE0EC10EB3A;
	Tue,  4 Aug 2026 22:08:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Y/pRRAox";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 263F310E07C;
 Tue,  4 Aug 2026 22:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785881329; x=1817417329;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/CjWusQWnHfvF1L4GuByNhRSt2WNxp6xRUmF8cWagb4=;
 b=Y/pRRAoxnACSWm4rjCpam/SBXLMMCyNIG7959W4T2VsVnMvubLH8sIMt
 IWjuNq3UeDC7rWqbEZxKzKWx/X15+DCTRqS53jrvamEnYWDJxQajEmh0h
 EJaewvacsHDbSY32kQkB2zHMhypPxho5DrSYK8auC+BDKCepuiPh1GhFA
 2WYqbjV2dYZYvh7fwbGOsQ7K+xdttGkQ+1NIqhunaccrvBBSqdIXTFetR
 ekjkAMDnloZbPi2rOtjtEWKMci7BshwQFkmLVAVSFlPM2plVGpZX2vslP
 1Yvw6iJYV9s4E7wKn500sHCE+ibm+G3Q0XVJsDXu9WexIPsbnlxMzukmF Q==;
X-CSE-ConnectionGUID: m3tedgLGSvShWId8chnCRg==
X-CSE-MsgGUID: rZwKeK9pRZCZF9FrJQTXvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97039757"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="97039757"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 15:08:48 -0700
X-CSE-ConnectionGUID: B9IncjoeTxK1K6pol+NxkA==
X-CSE-MsgGUID: iQMoOa62SxW8/ldHIaxcfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="261690523"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 15:08:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 15:08:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 15:08:47 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.31)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 15:08:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CD6WTsdGBP7qtZu+3ciypOlBrqV+9YAywhHC0ZgHgvWITyGsOx2zNQ1g8DKXbfE8f46X1f+d3UWkFC/ErnfA4NkXr5KZu4Cu5SnQDm1Hhfge6EhKx+odbZvPjD9ZjiQHkzSVNIlyEY9wdAezvLRCgzoIAIfr1tdQseVWfbKzthnVW9Wnm7a9joB9ng9iT6YOAVEBAbqJzv+allR4tzA8qiK+g4lBRRxKFHGL+tZ3nKdLHNdcza3FjdjZR3LUs2Q1EB6dZdsbAbcPjJSYNch8zLDkrM/2Qq229H4FELR87c83+T2iBfszKqdPhoE3siC2ZHd/ThixtrIJDBTkc3IFhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VHmOFUs+IZBlV4tOE/wzAs2XEdcaE6mlR02y/pHtMA=;
 b=gbwTwwGMywcYAo7NPxBjIoSJBMYUm7l8KIwcYYaenxNUOa3FF7H4TyIzdvnT7w4aWuTtbANOMlajVXwQ7po33tYgIK9RdlLwwpTlOuqHdCjvVLTJ/p2I9x6e1UE2LP4/os41I9O8IOmpZqW6fb4PJJ1usct2kz+QDvy5mTO+We/Sa39dq3tLUr8uPFFhakdHisDfhoB8ZNP1GZwPuH9O4URKbntzUUf4Gzu4d2gchKYnsOUQ9D8stPQlr4XqmcxbWRUfiNM7kYHlGGF7J5nzYKrAfKu2fRGNHne/0Pb3H2sepNi/BrGddMp0NpPp9X1PAXUwm+2CF9EVqXJYrWswww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16)
 by PH8PR11MB7966.namprd11.prod.outlook.com (2603:10b6:510:25d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 22:08:43 +0000
Received: from CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::ed0a:e4ab:fde6:edcc]) by CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::ed0a:e4ab:fde6:edcc%2]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 22:08:43 +0000
Message-ID: <cb06c8e0-0cf8-4dc2-a586-77aafc95f0c0@intel.com>
Date: Tue, 4 Aug 2026 15:08:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] drm/xe: diagnostics and workaround for GuC TLB
 invalidation ack stalls on ARL
To: "Summers, Stuart" <stuart.summers@intel.com>, "Brost, Matthew"
 <matthew.brost@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Vivi,
 Rodrigo" <rodrigo.vivi@intel.com>, "talesam@gmail.com" <talesam@gmail.com>,
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
 "Filipchuk, Julia" <julia.filipchuk@intel.com>
References: <20260804021441.3054424-1-talesam@gmail.com>
 <c0c50dff0f9b64a2db8e1470d75e450ba35cccde.camel@intel.com>
 <anJZSDD+lmzbaE7b@gsse-cloud1.jf.intel.com>
 <176e54adc75dc9b947caadbf95333df1b60c0240.camel@intel.com>
Content-Language: en-US
From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
In-Reply-To: <176e54adc75dc9b947caadbf95333df1b60c0240.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0183.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::8) To CO1PR11MB4979.namprd11.prod.outlook.com
 (2603:10b6:303:99::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4979:EE_|PH8PR11MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 87f82dfd-ae17-4105-4dc6-08def274f238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|10067099003|11063799006|4143699003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JYQtMD5qWptykzQPkGBDarDeeL52vwcS4q1Ty2z21s2hhQxxm0Z3YSvTUzSpKeMOCAKtERLVH/2OS8lGtXLCBgjsx1Mopb1okBDkqy0yKgzVibAs9gQVykV1EKn3IcMF09WvHxFiPJnlYsv4oZMl6acOBQe5nhrz4r0Dyp3Qd471R4qUiIKAl6dVQhFqjO7ow6U6Lh7Ssl6FSHAZATVZUzzl3oIwA0FGky27kyr0i+QB0b9oMkawhasPZ+c4qojAhggAKiB5vxdZRzwBkB0UEp7RpGHsaIM3IjUrmt8NWhGdFK3HmyFcR/NalFLVbKpjsh9xIzdTKxn/eK7mfXoAD9wUCalLXvohEbHqaXyQmeubfw8oZ9vvAm5tjtSzuLZCj0Pz/jmc1nDOCa0cYb9UPhLf+vYjd+f4ZqO87UZTKoGjxcrCsCA9isv6F1Nl1si4Rlxz0SuDylero6vu+VWqIBNbc8sZx2P//A/r21ePwVGZrOjWFvjZaoOSHvlRMFYL4MfzmtpaF6V+nuFXE6roCe815QNB7SJCKIiMBo29XOWvmtBu+urCwKKjjBovriYs4GGDfKHTJ6skLxbFCVzK59fhgaDDgUJYcSxEhmQ21MrFlC9kG7+YRnzYvXo+/K9W
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4979.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEgyUUpoQXVuRis4MkttdUhMVTBIS0tEZVNMTEJKTG9QcHk1ZUZzVk5GWG52?=
 =?utf-8?B?UnlHRkpTWndYcHNWQ1RiSmQyWWwyM0dSNEgxY1Z0NCtzdmg2UDkyYlZZT0xa?=
 =?utf-8?B?OVpZWUZsd1hBUGRIVDBFQUx4bnFvSTVpTTRSRXVJWWNtZXZFUmxGSHUzZE5U?=
 =?utf-8?B?S3ZURHRPSVlWYlNEQWFETXVnZzB4WGtSNDh1Y0twbldIUE5nTlZRa0QzZFlM?=
 =?utf-8?B?WXZDc1N6cjRDZXZUdEV2akEzV0JRZlUyclNRcXBOR3hQT09KZTZiYzJuTlNR?=
 =?utf-8?B?b280bnQyelhSRnNGanQ0ZkQxNHZxZnhqdE0zN0RERWlzU2JtWDZDdTZjM0FK?=
 =?utf-8?B?czhNNWxjeFhkMklzY3hDQXhtM2dIaUN0b0hOT043Tk00YUp5MmhmYVRocmxq?=
 =?utf-8?B?VUloYlBmUElvRFpEWkF6YlBwRkZMaTJkazlXdzcwdDFQYUl6L1hFaGJzUzlR?=
 =?utf-8?B?SnlCTWhtNzBCVWJFUzcyUFl2a3VmTEhMZzhPYXRsaSttR0N5UFp6VEE5VSt4?=
 =?utf-8?B?Rzd6dEc1TFdQZzdwM1ZjcVpyTDRBd05oczV2RTB1WHplVDlzL0ZsVWNJUTlK?=
 =?utf-8?B?NGZ5OTVEZmNNYzNkd0NNVzlMK1B2elVSVmh4VEwvcHNTeFkzUDFyd3I2bmdm?=
 =?utf-8?B?c0hOdDVGVnVSUFRWTjkzV3g0azEzaitNL053bTRsQjF2VVRqbmdKbE11VStE?=
 =?utf-8?B?QkFDZFJIWjdvRXd2MHNha05pMU1HN2FGQUZXRDhvUzN0dnV1dzFNUjBZMGcz?=
 =?utf-8?B?WDJuNER0M2ltWjFwR2RNWXBIajBMQ0JjTjQycW5HYitPZk52Zy9abVB5NGZ5?=
 =?utf-8?B?ZlVSTURqbmxHRVdpVjNubHYvclJwODZ2S3ZWZEJ2R2g2b0g4dWNvcDR0dVcw?=
 =?utf-8?B?RHNZT2Jva25vUVkxellrdStMQTRKcmo0QVdpMjV0Uzl3SldlcUFyWlB1WjEz?=
 =?utf-8?B?Qys2WEExMERqVjFKdlZXcVp4UkpGd2hjSHhhUTRLSG9LbmVmNnhlbkY4Rjd6?=
 =?utf-8?B?eFVBaXdGNml1WlVoWCtBUlpqRUI3ZGFGNFNJTmpoRUxJd04zOU5Fc3pVdTA1?=
 =?utf-8?B?VTBJZm4wQWlHUDVYS1QrOWt2d3hMSnRoY1NIZll2R3dxN1FDSjJWMEkwbU1W?=
 =?utf-8?B?R3gzTjRySEpLNUFtTk9rVUd6MnNGbnEvWWhpTmRnVDB2cENRRkZXa0VXMG91?=
 =?utf-8?B?R29uV0lVZXlVblRKYlBvOWV3eFRncis4eFRFUHBIZlVzSWE3eE5URDFKampx?=
 =?utf-8?B?NG81ZUJKWklrUnFsaW9wZktHUHVORmNxQjZaMSthdHJ0TGxvRWxYOVRtV3ht?=
 =?utf-8?B?VWwvbFJpRmJnek1jL3h5TldSd3ZxZHRFSjdSOHJjQ0pyK2dtLzE0aUtOTlZH?=
 =?utf-8?B?bmkvMytrTzdRT0VvZDE4eFdQeEFVdWhqS20wWnI1eFRicExlSE96RWFvczNy?=
 =?utf-8?B?QTR4d001TGFWOERxeGUrWS9DZC9hN05pL2NsZHJORmRZeWxzTi9SSy9GK05n?=
 =?utf-8?B?b1BlSElESHRGazJZRWUxdldvQm8xZkNjOEJ0Szl6ZFJrb0JxNDZyK25vRTdm?=
 =?utf-8?B?MDNFdTcxNTVBM3RNOGdPQUZ0Q2xFYTZEY3N5NWJtcSs0UjEydGwrQ09WaklJ?=
 =?utf-8?B?VklLbzRpaWp6TFZmOFlIWm1ldE1rM0U0dDBpUi9NVzRFU2xvOXlVMXRUc2Nl?=
 =?utf-8?B?S3VqVU9KN1VkVWg4ZTh5dThWempCcWlKZkl3UnQ2Y3Q5eXZuQXZuUjVFa28w?=
 =?utf-8?B?RkhMZk1EVXBnSWRMbDl6MXBzajRLcGYzK1VDVFd1cjF4WTVWeGFPT3RCd1cy?=
 =?utf-8?B?d3EvSVhiMVpQNjF2QjhUY0UwR0dSY3FwR1JIRVJpZllPM3FxdkUzbFVOMTVo?=
 =?utf-8?B?Q1VXR1h5d2VUNE8vYlpZZzVhYVJZekxEbXF4WWpyN2JhNVFPMUhlYmdMakJE?=
 =?utf-8?B?ZFZLRnZwUlpRWHBwbTBTcThobXJHQ3lpRUxuRTJrazQvbnJ2WXpzZHVzWEgv?=
 =?utf-8?B?d1NIUGhsQUFkaFN6L29OaGJUZEF1eWFyNkFoeHhRbmVkN0ZOcFNwam40d20v?=
 =?utf-8?B?V0lIZnBzVW1JYUN3d3c4SWxsQ0gwZExvNHdJZk80d1JGMG9yZ21vSGRpcnY0?=
 =?utf-8?B?aDZJK3ppY0wxb3A5NmtRR3Q2Qk9UYXQ4N2NJVFJyalhGMWI1emhHcVA0V0NU?=
 =?utf-8?B?SmpZWlFqL1RWYkE5Q0ZXMkY4T2k2R2NqVVlBWTljaVV5d2lIaFQyNnFuTFJJ?=
 =?utf-8?B?ZURSaDB0b3FoMDhOZmk5UUpQT0lOVFZUWEJVdi8rTkF4NkpKaHVVQzdjdTRU?=
 =?utf-8?B?N0RRTHhDQjZhOFBBMm12SGR1clJ5RlRFTjBJSGx3SUI5QzUwSFZ0WG1Ma000?=
 =?utf-8?Q?f5MQfGyBRWoNOWNo=3D?=
X-Exchange-RoutingPolicyChecked: Vy1ZcGteAS9E2nj5zsSWQ2ShHULVTex9XIRRdrFBPKie/VWpyjjka36jgPvlEHlAiXEl0xa3b7F0Nb972qorWrO6CaOi2jOjFP0rHi1iy+YKHouSAbAiC4/9kGeiuIzCuriXj/Qt3w7cpJjSUExr+gAsRKjeqOtqOJedzbsP4YmbxHHMbVcr/8x11cTHv5U4JMhHLMaEiEIuc53Oa2dQROv6cXc8g1rDAcs0GCNpwuxP6PBAZPCyVs/9x3fV8kurOeHx1jSfBWghTsHw0uuDGy9TvxzEPSAzuhHvguAwjXsoiXby+F/mk1YrNhw4AQF6Y5SVewpaGjr5I6HzQHH8tQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f82dfd-ae17-4105-4dc6-08def274f238
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4979.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 22:08:42.9175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHW1tLps2h+2kxVosbAgSstXzMUQk2ddNkq88c6fQrLciCd+TNRc7tJRliCcJ4bX5GAO5Kb176CjSfz0YJy864d2w/u/TawFDleq+48WGVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7966
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



On 8/4/2026 2:33 PM, Summers, Stuart wrote:
> On Tue, 2026-08-04 at 14:27 -0700, Matthew Brost wrote:
>> On Tue, Aug 04, 2026 at 03:02:44PM -0600, Summers, Stuart wrote:
>>> On Mon, 2026-08-03 at 23:14 -0300, Tales A. Mendonça wrote:
>>>> Hi,
>>>>
>>>> This series is a follow-up to the TLB invalidation ack stall I
>>>> have
>>>> been debugging on ARL, tracked in:
>>>>
>>>>    https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
>>>>
>>>> Summary of the issue: with GuC 70.53.0 on ARL (reproduced on 7d51
>>>> and
>>>> 7dd1 machines here, plus an independent Arc Pro 130T report on
>>>> the
>>>> issue above), TLB invalidation acks intermittently stall for
>>>> ~2.3s.
>>>> The H2G request is consumed from the CTB immediately and the G2H
>>>> CTB
>>>> is empty the whole time - the firmware simply does not send the
>>>> ack
>>>> until much later. The fence timeout fires at 2.25s and the ack
>>>> lands
>>>> tens of ms after it. Userspace blocked on the invalidation
>>>> (compositor
>>>> buffer unmaps etc.) hitches for the full window.
>>> Firstly, thanks for the patch!
>>>
>>> I haven't looked in to all the details of the sighting you were
>>> debugging, but we have had similar issues that were fixed in a
>>> later
>>> GuC version. I think around 70.60.0? It might be worth trying on
>>> something later than that to see if that helps... (+Daniele)
>>>
>> I think this would require an AR on our end to make a new firmware
>> version available.
>>
>> The upstream repo only has 70.53.0 available for ARL [1] (iirc, ARL
>> aliases to MTL for firmware). (+Julia too).
>>
>> Presumably, the GuC changelogs should indicate whether an issue
>> related
>> this has been fixed. If so, we need to update all GuC versions across
>> both i915 and Xe.
> Right... I guess I'd still like to see if we can test this in GuC (or
> get confirmation we can't for some reason) before committing something.
> My worry is we will prevent bug reports like this by working around it
> and miss critical bugs that need to be fixed in the right component.
>
>> [1]
>> https://gitlab.com/kernel-firmware/linux-firmware/-/blob/main/i915/mtl_guc_70.bin?ref_type=heads
>>
>>>> Patch 1 adds xe_devcoredump_gt() so this kind of hang - which has
>>>> no
>>> Is there a reason we don't just re-use the main xe_devcoredump()?
>>>
>> This is my suggestion: the main devcoredump infrastructure is job-
>> based,
>> so it cannot be used for hangs that are not associated with a job.
>>
>> In my opinion, this is a gap on our end. Introducing something like
>> `xe_devcoredump_gt()`, which can be used for non-job-based hangs
>> (e.g.,
>> TLB invalidation timeouts like those addressed in this series, or
>> more
>> generally any GuC protocol hang), makes sense to me.
> Ok makes sense. We can do that here. It would be nice to have a more
> inclusive implementation that lets us call this from anywhere so we
> aren't duplicating things around for different use cases. But not a
> blocker here.
>
>> I haven't looked at the patch yet, but at a high level, adding
>> `xe_devcoredump_gt()` seems like a reasonable approach.
>>
>>>> exec queue or job to blame - leaves a devcoredump with the GuC
>>>> log
>>>> and
>>>> CT state behind (Matt suggested capturing devcoredumps when we
>>>> discussed the issue; devcoredumps from both machines are attached
>>>> to
>>>> the issue above).
>>>>
>>>> Patch 2 logs when the ack for a timed out invalidation finally
>>>> arrives. This is what established that the acks are late rather
>>>> than
>>>> lost.
>>>>
>>>> Patch 3 is the RFC part: a delayed work that pokes the GuC
>>>> (status
>>>> register read, CT flush, doorbell ring) every 250ms while an ack
>>>> is
>>>> overdue. On my machines this converts the guaranteed 2.3s stall
>>>> into
>>> I'm a little worried we're just papering over something here that
>>> needs
>>> to be addressed in GuC, particularly around GT going to sleep or
>>> something around the time we're expecting a response, so the pings
>>> on
>>> registers might be prematurely waking things up which is something
>>> we'd
>>> want to happen in GuC, not the KMD.
>>>
>> In general, I agree with this. We should avoid papering over the
>> issue
>> and instead fix it properly in the GuC. That said, this workaround
>> provides a pretty strong data point, since it appears to get the TLB
>> invalidation unstuck.
> So if we hit this issue I guess we're already going to have some
> performance degredation and the workaround makes that better. I need to
> look at the implementation, but we could be potentially introducing
> performance penalties in other areas doing these pings.
>
> Again, I'd like to see if we can fix this in the right place before
> implementing a workaround for it. Hopefully Daniele or Julia can give
> some direction there.

Are we seeing this on i915 at all? Given that Xe does not officially 
support MTL/ARL and is missing several critical WAs for those platforms, 
the approach so far has been to only update the GuC FW if it is required 
for i915.
Looking at the GuC release notes, there have been a couple of 
TLB-related fixes after 70.53, but they're both marked as only affecting 
PVC and Xe2+ platforms, so no fixes seem to be available for ARL (or at 
least they're not listed in the release notes).

Daniele

>
> Thanks,
> Stuart
>
>> Matt
>>
>>> Thanks,
>>> Stuart
>>>
>>>> a
>>>> sub-500ms hiccup for the majority of occurrences; a minority of
>>>> severe
>>>> episodes ignore 8-9 consecutive doorbells, which points at the
>>>> GuC
>>>> firmware being internally blocked for the whole window. Full data
>>>> on
>>>> the issue. I am happy to rework the approach (different delay,
>>>> tying it to the G2H handler, dropping the status read, etc.) -
>>>> mainly
>>>> I would like the firmware side investigated, since no host-side
>>>> poke
>>>> can fix the severe cases.
>>>>
>>>> Based on drm-tip. Tested for several days on both ARL machines
>>>> under
>>>> desktop and VM-heavy workloads.
>>>>
>>>> Thanks,
>>>> Tales
>>>>
>>>> Tales A. Mendonça (3):
>>>>    drm/xe: Capture devcoredump on TLB invalidation timeout
>>>>    drm/xe: Log when a timed out TLB invalidation ack finally
>>>> arrives
>>>>    drm/xe: Kick GuC while TLB invalidation acks are overdue
>>>>
>>>>   drivers/gpu/drm/xe/xe_devcoredump.c     |  68 ++++++++++++
>>>>   drivers/gpu/drm/xe/xe_devcoredump.h     |   6 ++
>>>>   drivers/gpu/drm/xe/xe_tlb_inval.c       | 131
>>>> +++++++++++++++++++++++-
>>>>   drivers/gpu/drm/xe/xe_tlb_inval_types.h |  42 ++++++++
>>>>   4 files changed, 243 insertions(+), 4 deletions(-)
>>>>

