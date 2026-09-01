Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4B5C624D3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:37:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEA2910EBB9;
	Tue,  1 Sep 2026 07:37:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ETTlguVq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BAD410EBA5;
 Tue,  1 Sep 2026 07:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788248230; x=1819784230;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xRqPPTOziNVLosuFusdfJrz80y8wl43SAlhsvhyOvUE=;
 b=ETTlguVqqZ8bG/Q+rsTZsDJ+dp7VH5c3J7iBSrTJkGgQejqGuhEVuHVd
 eg41KysoJdooB/9D0eYx0T0hoYhn1OqaEFnfgYn8UcYrmqCRJqvB0tiZ8
 lt2DF2R8UnmoN4Bwlw/ReZW3JAj8Y45IBCOthvC54ctvxJ8UrJWrLcKTN
 AitoAyAs7TBy7Vp/UOEKzHT1s8vfgAebggB5u/HOy3cEctFtiLmd/KWFf
 8UrcV/Qb3XTmsDsONktpf/VRI8XUit88KjMdg37d1FW4j9FYjVzvGEFQh
 +df5vWT3zdY4B6wwzGaGhLRoAJzIn9i9JIe6BRZRbgMYZ0PcHDAIqRdJC w==;
X-CSE-ConnectionGUID: hNaiqNU8QmGRGDmw67Oo3Q==
X-CSE-MsgGUID: cgxrRAONRpyDj6WnICBeLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="99267877"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="99267877"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 00:37:10 -0700
X-CSE-ConnectionGUID: KN7BsqOARs6UGTJKX860UA==
X-CSE-MsgGUID: qC+XALJrQj2SCAklUE1c0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="272803928"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 00:37:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 00:37:09 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 00:37:09 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.33) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 00:37:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAq3+5cqFHu4e5kKNsH1v6xBMg3NVlwspVXr4HzxrMjtkTKZQcnCxpzwcUM0jNxdTtXW/hCN7Fb73CgDWe1hPtaFDgRJgAVvk7kxc0yWdf+Md8+EoGRKzSg4jQt/GxbKYtst8SrwqE6nd+QGK+rCSsie8wslD/+lidCkEE68J0Qztr5d0QlEkNdOr6OGFnylg5Zqz6rSuujqlgCGctEGqlOvkTHpbRCuudN9JYVkLP6b5UlzPFI7pLfiw4Qlw8qNmDboWavFna6PXeHzTpaAaK+EeWiJfAg3AO0nkFCWS4uz65YCyIlFtoBn0x5zUCEMpYZTnRzpZ7nNutsOrCywjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Vq3Cts4R6llfw0HNrfdLWOl4c8WdZ+oeXzloHAOEBA=;
 b=lJw6EHfUFDnLZCHzovS5UUb/W5OkPbc8TaXPau9thmh8eKZDC/KNMIhjoFgZUu5v1rNrv6+7/QtpbC9gB82wF6+1sexHrmP51/fZnnayJjm5gc62ueNzT2mIdBXcA5rgp1gkyOX9ExFkiIXajualvui7V3HErpKHF9TNgUItRT0tfOTrGtVzLzufHQBKxrQvPWR3DVIeKLm/0e+dODKcIJ7dnx1u8MBX5R8tOptkpDgclRXuSPvdr/Ldh7P8wpS6MLckBMGWIUytjz1noaubfqzHLkHhUdL4ZpGYW/8AMc1WejzGZ/0LPkDdxe7aDn3LJMXUOn7h3w3ZUIAmPajVFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7636.namprd11.prod.outlook.com (2603:10b6:510:26f::13)
 by DS4PPFFCBF1B4C7.namprd11.prod.outlook.com (2603:10b6:f:fc02::62)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 07:37:07 +0000
Received: from PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b]) by PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b%5]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 07:37:07 +0000
Message-ID: <316de557-a3d2-42a6-aa2a-0428d72e13f3@intel.com>
Date: Tue, 1 Sep 2026 13:06:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 2/9] drm/i915/color: Add CSC on SDR plane color pipeline
To: <intel-xe@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: Uma Shankar <uma.shankar@intel.com>
References: <20260804123107.2256124-1-chaitanya.kumar.borah@intel.com>
 <20260804123107.2256124-3-chaitanya.kumar.borah@intel.com>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <20260804123107.2256124-3-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::9) To PH0PR11MB7636.namprd11.prod.outlook.com
 (2603:10b6:510:26f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7636:EE_|DS4PPFFCBF1B4C7:EE_
X-MS-Office365-Filtering-Correlation-Id: ba885720-e05e-45a2-a696-08df07fbd12a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|11063799006|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LUh/cBhBbvis0RIiZIm7Dk2VfQ2zOv4VslZq8k4TOxlE63Oc8Dcb8gI9pz5m/lxZtMDioMc3bvHoZ0dNagWK3tQyuB+xUBbpubw2FDT6HPFZdYPxEG6BSvmVIVd2bGAwcbHJdDPfNRQqc3dxyRGFA0AGn5hYsKIf091pgh2tMzXxn3gHGf+TV1E856rQ1kBvAu5iGOhsK5hiCToTtOxYeAck1agK41FD2l7rc/IL3borbHuxMGf8vPGI8Yd5DALmC4UnEzHvZTNr+FrFL3T3bW4AI3wWZDgEOhnaiP4Bo0fYu5sbrUvmuDa+fUbeXau5yKzb5WjIqTcJvcFKWXOY2LDrNxCGcATKi0tbjF0qw5mWVLDbKkjP0w+zDuBSGQjHD4a0O+b4rrD5y300ZQWcC2OBGRrlpLs0vp3YYjlNZ5Tn35HsapqOOeMKLxpE00CH+RBlLtCr/vcBIsq59TjW4nVm7zini43NimgbIwX6iLT/w7lIYAotNWIVcwqI7PMF/jS8K/lKwZVcZ8zGVj3+H1hTcNiO+gR8ZJYcp31msUWkV+wtdkNbIXCZgGdbUCE2lNbEj94tP2dsgp2Df2GfbE44f1R7YlcUEEZh7PvQQXhW9Nb3ZuJji3/xYB7lZodVoX46GqEIF16RZ7mUBQiNcW6q9Vm568ItW0WdaYBzigg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7636.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzJhSm9xQ3NKa3lxUWZJTTRJMFc2Q2NERi8rZnN4Q0NzbXZ5OForOGxmTmo5?=
 =?utf-8?B?VGpyb3lSZXh6ZGh2VEJMQ016WlcvOUtqZTl6Y2NvNzFQOTY4WG1QTVRuNmFn?=
 =?utf-8?B?cXByK2RJVlUxNFZlcXBUZWpRVUZCWWNudXVlNEdLdVM4MjV3QWtnVU9jU3h2?=
 =?utf-8?B?d0JyN2prbnJHamNnUGZzeU5SNkRjTVBkajd6aXNuR3oxa1piRUt5ZUYrL0dq?=
 =?utf-8?B?TGJwY0Y4Y0Q1RWNCcklsanpmSm91L00zd3VBSzFlUHpjS1ZwMFZxUW1pZGVX?=
 =?utf-8?B?OTlDODdIcFUrYUVsc3Rkb0xsRThlVlNQM21RRzd2dTdDSkpCRVBKbzdJeE1R?=
 =?utf-8?B?UlVudjcrdmhRTE1PdHkzQmpKMktQcW8vTlltZ042SlIzc1IwZnJRUzBkWlFQ?=
 =?utf-8?B?MUZxeWpoN0dEdmJVOGhiWkpvMS9wUTFzT2JKWURTaVp5SllZdTdiNDE3a3FX?=
 =?utf-8?B?bFR2RUozajZ6UDY5M1VacmNOQTZIcEhKcElkUm5QangwMmUxMzdKV3dNWWp5?=
 =?utf-8?B?V2pXSFRMU0J6cytGODFmWVI4czFhczJ6UWUrRGxsd2R1RTkycm9BcE1QKzV0?=
 =?utf-8?B?ME14NUxFQWtHWjFSdGJTaUFrUXR3VG1JNzR3UWxscTQ2dUQ4L1NFcUJUemhD?=
 =?utf-8?B?WTNmNE4xY0VvM1RvR2hMSmNwc3FPcjNTcTBQeEtwY3M5blBLbDZ3bHpuamVS?=
 =?utf-8?B?c3BXc3ZrYmZTYllXL1IwMXVBYlpsUFljQUt6dmlqK21DdnZPNU5VYUxSZ1V1?=
 =?utf-8?B?RGdHUnRaa2hSTUx0Qnh0NFRibjdwNjB6Rm96M3ZuQ2svK041azF2MzBjMGRB?=
 =?utf-8?B?TXh3Z3VRRkdFZDFPZERyZGQ3USszbmk1Y0NTOVV3b2lScUlyMWFYRTZNVy94?=
 =?utf-8?B?VTFyaGNXNHNHbkRJMU1FVXhpeG5YcmFvbE1QQ01pMnJwYnI3L2JaU0pKZS9x?=
 =?utf-8?B?dEQ5a1VNdUJqZTVJSEpGR1NNNVBMcFh6SnQ1ZWxBV1JBb2xVZVVSQ1pCUTVG?=
 =?utf-8?B?Yi9CV3ltdUZIbHRxaGNHQmpsQ1JINkhVdUhQeC9rd1RCMFVEZTNHVjVEWGRy?=
 =?utf-8?B?MG5POFNmMi9kVDlqbElxbG10SjBVL0FuOWxFdFkzcEYvUGlHUDJ5ZUxFZkdz?=
 =?utf-8?B?TjJOWFhCU3lrTVp6dUl4RE4rNEw2T3pEalV2QU1nbkc3bkFOMHRldWFTZVpQ?=
 =?utf-8?B?SktpNmV4VU9zaEovNGk5Z0VZTHhTK2FRVFZJYjhoVlhlbTVQUlBwSnVQbnZy?=
 =?utf-8?B?eVdLWmhJeXhjWENoODB0dC9TZmsrVjdrYk4ySDBoVE5UTnlXb2N5a3VJZFRk?=
 =?utf-8?B?NjFsTUlzVVFma3U0cklSTnlYTkp4VTh6MWdUUi9WUksrb1JLekVrZVpQa2I2?=
 =?utf-8?B?alZob1pnM2tTRFE0dWtLM3c4ZndUOTRxTjB1ZnFYTm5uTkZqUWdQY2IrMk5Q?=
 =?utf-8?B?Q2NYOWtQZzNvbTNJZ2JkejdUZWRvMVVNdEVMSkRYT2w4aERTM2FKOTNjQXRI?=
 =?utf-8?B?V0J3SXJ0bWdiVlJKVGE5eTBUUnM3Z2w0NEczeFpQcUJvWG1MS3Q0R0tZMlVI?=
 =?utf-8?B?NjJtc2J4ZzMyZUJiVEppUGRwWGU2clRMbE5UNUc4VnB4TVNYb3ROWWJMYmpM?=
 =?utf-8?B?cm1nYTBkdFNvM1VyVEZ6ekNJbGJUWFRqdTlvdDJ0UmFoNVhlUE5MNllTbjlS?=
 =?utf-8?B?LytTb0NZV292dVlpVGNTaCtvSGhGSSticTRwWmI0dVhKald2Wm1LalBERktG?=
 =?utf-8?B?NmFwNEhLZzNhSC8rVVdycElNa2JJRWxjbWtXL0wvZjJqcVh4Nml0WnlmU3Bi?=
 =?utf-8?B?cS9ZUFkyM1J0bUtjaEg3ejVnNWxrYS9DMlNhdjlPS1NKaW5QN2dGSk5NRXIr?=
 =?utf-8?B?RVRoaXVxMGtVZzlBY3VYU1dQVTYwNnJKTlRUTk0yZXAxYlVaTUl1a2pkSXYw?=
 =?utf-8?B?MVFTc0N6VlkrdEM3V3U1a0xzQXJTVUdMeUt3SHdLZlpabkJGT3NJT1k3cjF5?=
 =?utf-8?B?L1ZYRmZ2MUlld0t4ZnBhMkNSOFh0U0VXYnpmUkoxZkJvVXNlNEtZYVR3eFMx?=
 =?utf-8?B?RUtPT2tOR1dqTmpScWdodCtrMkNnT2tmNnhPcm1zblFicUt5bVhPejM0S1pR?=
 =?utf-8?B?ZUx4NlNjZ1dhMmxTOXo4MzRoVVVFa3ZIcGNneWNxK0QrbStYYTFJMFRJRTNn?=
 =?utf-8?B?c2VYRjBwWnJ0TlRnY2dVcDhDWUdzN3BCVklFZTNNVm1uTk9HSHUwUW1qTjBI?=
 =?utf-8?B?c29UQ0VGVDdYNXlleXBjKzhhd2RlOUw3YU9qbGJaRHlSaXBkQmpzQ1V1UFE0?=
 =?utf-8?B?eGRZQ0tzc3dYSkdwdE5jYUM1WVpXZitKZFlDdXlyNGplb2xKTHozTndyUXpH?=
 =?utf-8?Q?iGyA/zKlp4WjVH0I=3D?=
X-Exchange-RoutingPolicyChecked: d6kb2FaGjmBWbrXz8rXICfGqbGt+W9SnQM0IKOjupeYPUijl85HpbxQm+tQgC4itiHanw+NsVHmYb8KIPrc3EqG5KUX0aEUT9uziij/Q7Zgw/LNAdCjj6JLX3rmBLyBTSksvP918PG9LEc1tXcuoDDrA972YfTHScQ0lBp7yzJj8wmC/Sukc9yLl9Ja68Ubjl/8Q5jKS6oz9p0aMi8p3n4X64qbcZkb9Ftk2nxaEVvu2prr3JpTLubrIU2qQeJgmyEcTrFI5Ek7xPpT05oD+n4C0fXRj4+Rjc6SAa3Gb4gNLriRh9KPdRtImm7EkK4pCh7Ejt7l0H5jNKB8azfOcVw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ba885720-e05e-45a2-a696-08df07fbd12a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 07:37:07.4184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vUYMtfmEAWOSHsNX7n0pmWjveSl3XbC5JEOBrmmMqUkvwPLl3kMJGrggwS9o1lZ2QOLAhpDgX3BTnMXH/WdOtNOueKbJu+rVi793Gv2WnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFFCBF1B4C7
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

Hello Uma,

On 8/4/2026 6:01 PM, Chaitanya Kumar Borah wrote:
> Add the fixed-function CSC block to color pipeline in SDR planes
> as a DRM_COLOROP_FIXED_MATRIX colorop.
> 
> v2:
> - s/DRM_COLOROP_FM_YCBCR2020_FULL_RGB_NC/
> 	DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB
> - Inline icl_is_hdr_plane() instead of storing in local variable
> 
> v3:
> - In preparation of a simple pipeline
> 	[YUV Full/Limited -> RGB]
>    Make the Fixed Matrix ColorOp support Limited Range enums
>    (DRM_COLOROP_FM_YCBCRXXX_LIMITED_RGB) too.
> - Therefore s/sdr_plane_pipeline/sdr_plane_yuv_pipeline
> 
> Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Reviewed-by: Uma Shankar <uma.shankar@intel.com> #v2

Can I consider your RB for v3 too?

==
Chaitanya

> ---
>   .../drm/i915/display/intel_color_pipeline.c   | 23 ++++++++++++++++++-
>   .../drm/i915/display/intel_display_limits.h   |  1 +
>   2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> index 6cf8080ee800..efd4375c4331 100644
> --- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> +++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> @@ -43,6 +43,18 @@ static const enum intel_color_block hdr_plane_pipeline[] = {
>   	INTEL_PLANE_CB_POST_CSC_LUT,
>   };
>   
> +static const enum intel_color_block sdr_plane_yuv_pipeline[] = {
> +	INTEL_PLANE_CB_CSC_FF,
> +};
> +
> +static const u64 intel_plane_supported_csc_ff =
> +		BIT(DRM_COLOROP_FM_YCBCR601_FULL_RGB) |
> +		BIT(DRM_COLOROP_FM_YCBCR601_LIMITED_RGB) |
> +		BIT(DRM_COLOROP_FM_YCBCR709_FULL_RGB) |
> +		BIT(DRM_COLOROP_FM_YCBCR709_LIMITED_RGB) |
> +		BIT(DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB) |
> +		BIT(DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB);
> +
>   static bool plane_has_3dlut(struct intel_display *display, enum pipe pipe,
>   			    struct drm_plane *plane)
>   {
> @@ -92,6 +104,12 @@ struct intel_colorop *intel_color_pipeline_plane_add_colorop(struct drm_plane *p
>   							  DRM_COLOROP_LUT1D_INTERPOLATION_LINEAR,
>   							  DRM_COLOROP_FLAG_ALLOW_BYPASS);
>   		break;
> +	case INTEL_PLANE_CB_CSC_FF:
> +		ret = drm_plane_colorop_fixed_matrix_init(dev, &colorop->base, plane,
> +							  &intel_colorop_funcs,
> +							  intel_plane_supported_csc_ff,
> +							  DRM_COLOROP_FLAG_ALLOW_BYPASS);
> +		break;
>   	default:
>   		drm_err(plane->dev, "Invalid colorop id [%d]", id);
>   		ret = -EINVAL;
> @@ -126,9 +144,12 @@ int _intel_color_pipeline_plane_init(struct drm_plane *plane, struct drm_prop_en
>   	if (plane_has_3dlut(display, pipe, plane)) {
>   		pipeline = xe3plpd_primary_plane_pipeline;
>   		pipeline_len = ARRAY_SIZE(xe3plpd_primary_plane_pipeline);
> -	} else {
> +	} else if (icl_is_hdr_plane(display, to_intel_plane(plane)->id)) {
>   		pipeline = hdr_plane_pipeline;
>   		pipeline_len = ARRAY_SIZE(hdr_plane_pipeline);
> +	} else {
> +		pipeline = sdr_plane_yuv_pipeline;
> +		pipeline_len = ARRAY_SIZE(sdr_plane_yuv_pipeline);
>   	}
>   
>   	for (i = 0; i < pipeline_len; i++) {
> diff --git a/drivers/gpu/drm/i915/display/intel_display_limits.h b/drivers/gpu/drm/i915/display/intel_display_limits.h
> index ea89473c177f..7ba7360c574e 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_limits.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_limits.h
> @@ -169,6 +169,7 @@ enum aux_ch {
>   enum intel_color_block {
>   	INTEL_PLANE_CB_PRE_CSC_LUT,
>   	INTEL_PLANE_CB_CSC,
> +	INTEL_PLANE_CB_CSC_FF,
>   	INTEL_PLANE_CB_POST_CSC_LUT,
>   	INTEL_PLANE_CB_3DLUT,
>   

