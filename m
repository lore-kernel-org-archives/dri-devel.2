Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EA8C9831E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB6E510F5C2;
	Thu, 24 Sep 2026 13:58:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HljG2yH3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5692C10F5B8;
 Thu, 24 Sep 2026 13:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790258285; x=1821794285;
 h=content-transfer-encoding:date:message-id:cc:subject:
 from:to:references:in-reply-to:mime-version;
 bh=fmC/vFPAeLNRWiFnfr1VsBYas6LzarQazl9yfnXHzBo=;
 b=HljG2yH3S5pBiIboGxofDaY4hj68WsXL70bXiw4Blwhxj3OiZFrgoifD
 uK5NNfIF0ns16F2rNL4UMnJMEhYU36qKoFpVE/NYhMIggjZcbVfOlNLRq
 ejyOf5w92LCGQWITa8ad5quilP35Zc4KCvys9OYiHpb24+MAU+oQEuVQl
 Nmu9YqVSqQEc6sgpZHjNTqciTb5aXLWslBZUhHKousn54dbWa1IiKhMKf
 UX8wGcDu3lZcFdKem0+8TmyS63rs1eVF1H56sfQE3CbD+PSpZiO5vs2Dp
 W5ZGkEQTkw09RdwZL8Fn6qB2dyRUGKuEN9zytXyNZZdreyxCECcNBw2uW w==;
X-CSE-ConnectionGUID: Jsm85/ibRcKmkKO19WXxyg==
X-CSE-MsgGUID: TXZgxHOHSGu/oeZsvlbrwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="101685988"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="101685988"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 06:58:05 -0700
X-CSE-ConnectionGUID: Y2sPAmZiSfCHZUt7h75kUg==
X-CSE-MsgGUID: w6H+7y7uSeO/nUgvgFDt1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="282118548"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 06:58:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 06:58:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 06:58:04 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 06:58:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STs8hG3ErapGX36RLVxUcMdDz449K2HS6xbMyfdXDqiEWPdLts7gdPykN2VRiM67XQr5P5CC5pkFCCbwk/qsXb0qKtrk+Qwl4v5Wv4gbNyVWKx84guSgQD0Uo4BlxM6pxQE4n9Ea8G5uCsD0MYRapFtuAZEfZuP/KdT1lZMuh1gsgHj2mjTvxHwmgPbuXNP0Zw4sAMtx0gFbw6ruOqgnkcw+BHfBxmc7ePsSJFVlXm65FcyhKZNK8x8mMCH1FRfoef0J3sxFOLbutuyVrxVv2Yt8S85E9o1ooLgn+XjNGlBss/It4wh7aI4vWkRAmQ6dIpt88rhXdNJBlnJZ1xzA2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzEtieqPMsbWYGclwoEcAEbu/Ou1a/06gvkdOAbZabc=;
 b=J8eyx2TLNk8DZjCAcBkNtk0rGvsMWorydmxwahFKFECKa2TskYjdL0cthVtiuepB6ok+doxJvAkZ49gI5HAHuTCUnkIazCR9vcXGPjyU8RiF+VkFZzPgTkR/HvmpF8hM/XG4mD5ry0CAk0v2At6zZQhGxdjLkYB2LMMQQ+VpBvMKITDtYaeUaaiVgZ6iE742Md82igcFv/SyRQ7Z2AWHclnmAEyKPMl8UV8gT3yjRx+3Dk9DYMDdgB8y1T8MFWKB8kDKNAIsaOUOD5Zf6rBSoqqLHI/LJUsHM36yURZ0a8NVq0MsFUGnQfQltqpUM+AdQWVsbJVuiEXo/D+wE4JW8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6909.namprd11.prod.outlook.com (2603:10b6:303:224::12)
 by LV8PR11MB8769.namprd11.prod.outlook.com (2603:10b6:408:204::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 13:57:58 +0000
Received: from MW4PR11MB6909.namprd11.prod.outlook.com
 ([fe80::9eab:962:806:3794]) by MW4PR11MB6909.namprd11.prod.outlook.com
 ([fe80::9eab:962:806:3794%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 13:57:58 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 24 Sep 2026 15:58:01 +0200
Message-ID: <DLNLLGHRVHT9.2TW4LJ2SFXO5P@intel.com>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, "Sebastian
 Brzezinka" <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH v4 2/7] drm/i915: Add i915_* printer macros
From: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>,
 <intel-gfx@lists.freedesktop.org>
X-Mailer: aerc 0.22.0
References: <20260924120147.1305127-1-krzysztof.karas@intel.com>
 <20260924120147.1305127-3-krzysztof.karas@intel.com>
In-Reply-To: <20260924120147.1305127-3-krzysztof.karas@intel.com>
X-ClientProxiedBy: VIVP296CA0016.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:354::19) To MW4PR11MB6909.namprd11.prod.outlook.com
 (2603:10b6:303:224::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6909:EE_|LV8PR11MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: 71db4a5c-8e4e-4aa6-cb40-08df1a43d6ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: zWcG0u54fZ9cZiau+dFNYWKrf+z4jrt/RcP63GPT76W58x+816jjVq07+GoraZ/eg2sB3EMdNKf17NCEZVfpeEbdS16nVa45YypNMJnSFl9fYQVjkcbGDaD5SOKdNNpiwfTfN6R0JELHdS7MRHXSwTuU0Ej3i0Vr6nIYQTbulu3f55qgHvlVb/MI7CUww+dsNHRmMUvFKufDv1fzbElqyA6XG+FU8G7YLnYEroZqPzmPYD72WkQblP9h1VO8aO9W3kK7tnBpMQ6Sye/a5TyHOFtgP6w7jq7gPUFk8O+IHf05cOYy3il8MLICKM4ohcUHli/00BW1c9CY9RxHsNxrGh48ik0nbkx2nU/hjI29aw60OcKHcdMCUCJZyCs4Q4WQmbmEGR9MAiztxytBpy5sBafyFyQBNkLYlVVHqWxX52GB1QCxVx/drXvPcF7aK3BRP8a5KHGPu3x3Rcu1Snjshy5Nn8IP0fk/BS6o0eLg7XNH4UzwQIpubomfbmlhfPLwLV6hQJqTzloC15bv3luzh4+UiL9uAVkaUF4ZC5M2T+X+RYQQ8VMFG3iIAVdjwpkmFFVKc0sQt3nHjA3MU+nfS7/20ntGVlBOOfJc0EkXmR0ofpUTsyxbxav3FTPyBE8m/yNUCmLaVu1YNxrP/pTWFJzvbjxJJDk+TTTJGUj7tzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB6909.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHFWRjVCV3U2WjI5UTUxMlEvblpyaFlld1c2aGgwVytvVlpNVE9TczVmVVlX?=
 =?utf-8?B?MTNkN0o0aFNpeWRpUWdGUHJYanBYM0EzbHVNSWJNY2NOdXY4K056VWRPd0o5?=
 =?utf-8?B?a2g4ZjF5WnVJckx6V2JrakVrdnpKTmtjQ0t5NzRLMTlRVE5COXBJNm56cXIv?=
 =?utf-8?B?Tkp2d3NVdmhRLzRFRVMxRHdEUHFDUG9CMzdlYWN5aXZtVm9ubGF6T25TdnVj?=
 =?utf-8?B?MkVrU3ZNUVM4K1A0WVJaNHBxRFBtK3YzT1BtSHcvN1kxaVV5NUhpV2xuSmRx?=
 =?utf-8?B?bW5oWmkralAwN1AwLzczbWNSeWNwQ3NxR2RUc2ErUTNxSlc5bERZRVVJR2Rx?=
 =?utf-8?B?LzdsWlJRT2tvSUEydHpoUmhDemFhbG03SHR5cUFRL0gxQWJoQ0lZV3dBQkZL?=
 =?utf-8?B?WUVVMm5YYUZsVjh2N1VKM2dxSzdzQmZ5bmgrSGtUaFl5N1ovY3NmeWYrTncz?=
 =?utf-8?B?a2V6M3U5NFBVQkYyd045c3d4RUNsOXFOT2JkZTN1WXRHbUFqVm1GNDJrUkY2?=
 =?utf-8?B?cnJJZ1drVjVjZXdnOXo3eE5NL2IveXZzUDhFVmt1MWk4dFFpU09rN0VMVmhO?=
 =?utf-8?B?VDgvbHQxZysrbW52ZXcvcmdwSWRUd240ck5HMzR6aXBLV1JYSG50RGQ1cUwx?=
 =?utf-8?B?eG52MkpmZGF1MEVSN3R5dkNObElMcW5tTGp3ZzJJcUlnTzFOanh0dVRGY1dQ?=
 =?utf-8?B?MDF3SlM5bFYyZGlMc3NYb2Z4dFNHaWNid09tNjJUSGRrUExZTkljVW5QV1lV?=
 =?utf-8?B?VmpMWG94WUVQOGg0cTFtWXI4aXBtbmUwSDd2dERKZmFNakkzVURjOGJPblJk?=
 =?utf-8?B?RXdYUlpSZlRnazIxdU0yL3U0UG9nRzJzaDNHOTM0aGVURXdTcGFrY1JzNGFs?=
 =?utf-8?B?V214UjduRmxXWGo3S3NnQ2hUajRFQzM2bXF1S2R4d011eTFFOGVpSFo5N2M5?=
 =?utf-8?B?K2RxZDBGa2dRZ3N3OEtzUUFORkJNODN4a0hxVjJEdUNhR0lQaE9nMkNKNXJ1?=
 =?utf-8?B?ODdFQWx4eWp0eGlpRm1UV1NMRHdEcWtKbExhbzQ5V2lrZTNyc05jWXVpRUQ4?=
 =?utf-8?B?VWhkSE5KSWVYQ3grUlltYUhuMGFtdGRtdWhzbHg1S3VjYlR0VWh2dlU5bnpL?=
 =?utf-8?B?OUdlUitTWVU1TWJwMzdNaUM0STNmWXlzMm5aVUc3ZDluODVqSFAvMnNqMWNo?=
 =?utf-8?B?WjVtZHdYTXgzUE02RWNCQmdIdTlNZHVCTUV4Yk9ma25ueXdqRDVrU2lTa2s4?=
 =?utf-8?B?MkhMbnRWTmR6MlRxUUpHVWtCYzZMbllSTHp6cGZ5MEg3VkVPNU5MRm83WXBm?=
 =?utf-8?B?bjd1TTdrWGJHUDZqWnBEemhGRiswSFhBQW45MW1vKzB2ZW9oT2lzdU5LM2Fo?=
 =?utf-8?B?VFRIMFZma3Arbk9Xbkt0d3M5MEdUeEJ3YjdwbmFlNTZ4VWxEZTYxT0FLUnNN?=
 =?utf-8?B?NEJtangxS2VTYUQybjcrM3JYVU9jN1hxYVp1ZU9weDRTYzhsWk1qUDdIbEwr?=
 =?utf-8?B?bGpKTnR3bDd6clo5a0lUUmh3T0h3dG9paWxoeSs2VmE2WEIwaU9wd0o1anpn?=
 =?utf-8?B?bFBxU2NqWlZqYmk0UnRFM3ArZEJQV2J5UzlnWG9nOFY2cXBFRlpON2N1NG1w?=
 =?utf-8?B?VVEvTFlZcHdsTS9UeUN2ZlRKQ3I0M0p2MmkxemtWRmt0ZVNpZlkvTXJuMFRq?=
 =?utf-8?B?WE9jdWVrWno0TmQ1dDlERGVvcU5TRU0xMkZVUWZBeEFORkt0VWg0d1dSOWRq?=
 =?utf-8?B?YVZ6N29SbEtFb1IzeW9vRXpuaFVUdjBjVTJsQncvVml4WEtZQ2dDOHFid1Ny?=
 =?utf-8?B?ME5EQzMvZDkzWWJFT1g0elRaZlNWWDNORWpvckF3Q25JK3VrSVpMV1FtSnZ1?=
 =?utf-8?B?WEV5WkN6ZjJwV1psakEwQWZwS3RsUjlINnZBcDVkaFpQTk1taU92aDNqMmt0?=
 =?utf-8?B?OU9WZ2t1RlVSRm1VbDVvTEpRNG43SWVrN1lFdnpyaWptMWc0RStvbkowK2tG?=
 =?utf-8?B?ck5wa2JKY0pCdUZQMmdrZksrM0VqZFkxbzdzM1dSaFF6UWtXdW5RS2xBVVJ5?=
 =?utf-8?B?azVtNnFyeGRheHhyZHNUOVI0cnlpWmlUMlR1N1dlbWJGc2tuUVVTaHMySGd5?=
 =?utf-8?B?em1zZ3dKYm85cXZlRTExalJCOVlhdWhzSG55QklYVDJPMDYzY0llUDA5NHB1?=
 =?utf-8?B?QWV2QTZiZGJpRWtQaGVJcTA3MzZWckpJcWVEZm1mQjBMTklnTXozZ0k3TGVs?=
 =?utf-8?B?Uk05TTJQdy9zdTkvYmhseUpRb2wra256Q0gzbTY1SVhmYmlZbzhlWENQcDcw?=
 =?utf-8?B?UnRlN0pvNnRNMk13Q0E5UVhpbVhSalRiNFgxcFkzemJXYS9zSkc3aHRqTGJQ?=
 =?utf-8?Q?bKJXUjiwFpsOnCrs=3D?=
X-Exchange-RoutingPolicyChecked: r6M8frbA6oeb8C1rYMnyClEIK6Uad68DRe7r0bQsQ1usFL39p8+bikcidLKd2bljhivoaoVjI0cGtTU2x7NirSpK80GE+eD1YMIpJaT9uCtEQc8io2HIPOc3IsIKbPPv2gKB6fA3xia+O3T7IGx+cA2BqeCnsatPYLJbRTXTHBZcLduGRgDE3Pbi9Io3RCggBXNgEQtJjH6yFzxVYHFw/1Jpmja5n64q2I1VpRJmZeEKQdCy5cy/cvzxPd3993YywUbdjzkytePM7PLdyVqJfwFg8ltVPEZfius5G4quEjkwTeuzYCTXduxmcewEgRLmqUUKy3+1MmUxMWCgN4iGGw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 71db4a5c-8e4e-4aa6-cb40-08df1a43d6ef
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6909.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 13:57:58.3713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIldzfb3ToxFBEBEA2/Ik6nQaGRXfe9xowGcjoAQEhmSUZqQx8GV5F/3prSeJ7KJMZRDE4vcMt7phqcRy08ETFD1nu4EyhJGa8NhPiuwg5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8769
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

Hi,

On Thu Sep 24, 2026 at 2:01 PM CEST, Krzysztof Karas wrote:
> Add i915_* family of printer macros, following existing example
> of gt_* and xe_* prints.
>
> Suggested-by: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
>  drivers/gpu/drm/i915/i915_printk.h | 53 ++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 drivers/gpu/drm/i915/i915_printk.h
>
> diff --git a/drivers/gpu/drm/i915/i915_printk.h b/drivers/gpu/drm/i915/i9=
15_printk.h
> new file mode 100644
> index 000000000000..5bbbe604cae8
> --- /dev/null
> +++ b/drivers/gpu/drm/i915/i915_printk.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright =C2=A9 2026 Intel Corporation
> + */
> +
> +#ifndef _I915_PRINTK_H_
> +#define _I915_PRINTK_H_
> +
> +#include <drm/drm_print.h>
> +
> +#define i915_printk(_i915, _level, _fmt, ...) \
> +	drm_##_level(&(_i915)->drm, _fmt, ## __VA_ARGS__)
> +
> +#define i915_err(_i915, _fmt, ...) \
> +	i915_printk((_i915), err, _fmt, ##__VA_ARGS__)
> +
> +#define i915_err_once(_i915, _fmt, ...) \
> +	i915_printk((_i915), err_once, _fmt, ##__VA_ARGS__)
> +
> +#define i915_err_ratelimited(_i915, _fmt, ...) \
> +	i915_printk((_i915), err_ratelimited, _fmt, ##__VA_ARGS__)
> +
> +#define i915_warn(_i915, _fmt, ...) \
> +	i915_printk((_i915), warn, _fmt, ##__VA_ARGS__)
> +
> +#define i915_notice(_i915, _fmt, ...) \
> +	i915_printk((_i915), notice, _fmt, ##__VA_ARGS__)
> +
> +#define i915_info(_i915, _fmt, ...) \
> +	i915_printk((_i915), info, _fmt, ##__VA_ARGS__)
> +
> +#define i915_dbg(_i915, _fmt, ...) \
> +	i915_printk((_i915), dbg, _fmt, ##__VA_ARGS__)
> +
> +#define i915_dbg_ratelimited(_i915, _fmt, ...) \
> +	i915_printk((_i915), dbg_ratelimited, _fmt, ##__VA_ARGS__)
> +
> +#define i915_WARN_type(_i915, _type, _condition, _fmt, ...) \
> +	drm_WARN##_type(&(_i915)->drm, _condition, _fmt, ## __VA_ARGS__)
> +
> +#define i915_WARN(_i915, _condition, _fmt, ...) \
> +	i915_WARN_type((_i915), _condition, __I915_PRINTK_FMT((_i915), _fmt, ##=
 __VA_ARGS__))
> +
> +#define i915_WARN_ONCE(_i915, _condition, _fmt, ...) \
> +	i915_WARN_type((_i915), _ONCE, _condition, __I915_PRINTK_FMT((_i915), _=
fmt, ## __VA_ARGS__))
> +
> +#define i915_WARN_ON(_i915, _condition) \
> +	i915_WARN((_i915), _condition, "%s(%s)", "WARN_ON", __stringify(_condit=
ion))
> +
> +#define i915_WARN_ON_ONCE(_i915, _condition) \
> +	i915_WARN_ONCE((_i915), _condition, "%s(%s)", "WARN_ON_ONCE", __stringi=
fy(_condition))

There is something wrong with the WARN macros. I noticed that they aren't
used anywhere in the series, so the compiler never expands them. I added
one to a file just to test it.
diff --git a/drivers/gpu/drm/i915/selftests/i915_selftest.c b/drivers/gpu/d=
rm/i915/selftests/i915_selftest.c
index 4e2566189879..7446c265813a 100644
--- a/drivers/gpu/drm/i915/selftests/i915_selftest.c
+++ b/drivers/gpu/drm/i915/selftests/i915_selftest.c
@@ -50,6 +50,7 @@ int i915_mock_sanitycheck(void)
 int i915_live_sanitycheck(struct drm_i915_private *i915)
 {
        i915_info(i915, "%s() - ok!\n", __func__);
+       i915_WARN_ON(i915, false);
        return 0;
 }


This is what I get when compiled:
vers/gpu/drm/i915/selftests/i915_selftest.c: In function 'i915_live_sanityc=
heck':
drivers/gpu/drm/i915/selftests/i915_selftest.c:53:33: error: macro "i915_WA=
RN_type" requires 5 arguments, but only 3 given
   53 |         i915_WARN_ON(i915, false); /* TEMP: reviewer repro, will be=
 reverted */
      |                                 ^
In file included from drivers/gpu/drm/i915/selftests/i915_selftest.c:26:
./drivers/gpu/drm/i915/i915_printk.h:38:9: note: macro "i915_WARN_type" def=
ined here
   38 | #define i915_WARN_type(_i915, _type, _condition, _fmt, ...) \
      |         ^~~~~~~~~~~~~~
./drivers/gpu/drm/i915/i915_printk.h:42:9: error: 'i915_WARN_type' undeclar=
ed (first use in this function); did you mean 'i915_map_type'?
   42 |         i915_WARN_type((_i915), _condition, __I915_PRINTK_FMT((_i91=
5), _fmt, ## __VA_ARGS__))
      |         ^~~~~~~~~~~~~~
./drivers/gpu/drm/i915/i915_printk.h:48:9: note: in expansion of macro 'i91=
5_WARN'
   48 |         i915_WARN((_i915), _condition, "%s(%s)", "WARN_ON", __strin=
gify(_condition))
      |         ^~~~~~~~~
drivers/gpu/drm/i915/selftests/i915_selftest.c:53:9: note: in expansion of =
macro 'i915_WARN_ON'
   53 |         i915_WARN_ON(i915, false); /* TEMP: reviewer repro, will be=
 reverted */
      |         ^~~~~~~~~~~~
./drivers/gpu/drm/i915/i915_printk.h:42:9: note: each undeclared identifier=
 is reported only once for each function it appears in
   42 |         i915_WARN_type((_i915), _condition, __I915_PRINTK_FMT((_i91=
5), _fmt, ## __VA_ARGS__))
      |         ^~~~~~~~~~~~~~
./drivers/gpu/drm/i915/i915_printk.h:48:9: note: in expansion of macro 'i91=
5_WARN'
   48 |         i915_WARN((_i915), _condition, "%s(%s)", "WARN_ON", __strin=
gify(_condition))
      |         ^~~~~~~~~
drivers/gpu/drm/i915/selftests/i915_selftest.c:53:9: note: in expansion of =
macro 'i915_WARN_ON'
   53 |         i915_WARN_ON(i915, false); /* TEMP: reviewer repro, will be=
 reverted */
      |         ^~~~~~~~~~~~
  CC [M]  drivers/gpu/drm/i915/gvt/cmd_parser.o
make[6]: *** [scripts/Makefile.build:290: drivers/gpu/drm/i915/selftests/i9=
15_selftest.o] Error 1


--=20
Best regards,
Sebastian

