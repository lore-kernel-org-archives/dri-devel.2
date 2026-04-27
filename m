Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C097DFF8867
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 23:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD38710E047;
	Mon, 27 Apr 2026 23:32:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HnMYY2Nb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4056010E047
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 23:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777332746; x=1808868746;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wKgKCYSXBxCoXntCH3RsNLQQh20EIW+3qCK92pIMJvw=;
 b=HnMYY2NbLxC/ZRHVe62BSiFdwsHnhE3rA3n/xc+JnDWYggqxuxRmkxJi
 KlPc+BApZEyWNd5nT4MYvjOApuiHJFULl2QOtgfwV7azknL9QwAYiH4eP
 n9o38PJBPZDoF/nUlV0IDuV8JwIWWvrwQaJ02C2UJd7v3Q3xIioD9OMXk
 Q0lDkNgqz01EQzq4v6T3kCYoJQnFllMBMr/CJlDkF05NtCxXcGlvBRezS
 GSEIIwjMJREv7B1WB3qyKN3p4FL8EmMz+EJ50r2cAaaes8RyQNQCwj77U
 59NIPng8u09rKdEwpMqvjVNrZjZ57ZUCbdg8jN18PCyKvMXRnO6GUJvuf w==;
X-CSE-ConnectionGUID: z+0UVaC/RWaGDj5qVU36Mw==
X-CSE-MsgGUID: xKi2S5V2SCmOilVPPUtPAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78113059"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="78113059"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 16:32:25 -0700
X-CSE-ConnectionGUID: hIKbe9RfReKj2EJj8Pb4wg==
X-CSE-MsgGUID: rfts6NpdSHqnAbIsdsiEFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="257313720"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 16:32:25 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 16:32:25 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 27 Apr 2026 16:32:25 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 16:32:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOv2XP+J0NFovjGGWL3MKDEwZXEj091uo2JXePFT7FVn5xFSSjhtE3K1FfeI0ysNfDYFLrrywMP1g3nr8PQJ6IFlEf3X8P9BTMqZyoDFGBZ4/8FC9PNB6OAbpI43vXwRitBn3bj5JsaLGbclILcUDNEiqlDu3j9O/rGuoCQeSf+Oo58/Gxmi6pS5CM/RPqs0jxuD5hOyg5zg3ZvwfxjdgUUTroRpYRR1ias2KiYMqansrWLZsBoxcKXFT4vlg3cyFpohYMNOse+fFDpH25U4dSAxdJEBfXQPxx9nUgmxd/ymejkE3ay3mFU1VXDoObQi4/vctcF+lqDX1erebKrsBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoK2J7cosQAlGruuujkBDt5NFY5BOisMOTJmW/vNHOM=;
 b=oFK6ELKyuHAvrPg2L8/RMFhjTXGL/T7XfhJbLQM+T+fcCaDbVCS7+1pJpPq2tOvVZLZr6ijRmm2j33v30PvvuDH+DlpBFeZUnx7U5JBlmzzMZiosNgwKmCpH7RPqBqH8U/P/PGb13/AShZ+mWQFtyVYHt139VlIj7RNhsvs8hBvf4TorKQyhXVjOMfQacfxh5Fp5RST42nci/j6lqEAXNH73LM1KGgqfTp+wYbG48CzIE5DroaAqv9zW2CKI3e//r1D0oCdVA92xUodrkNBfPm88J2UjrHied0O0bpXBUTDLex6toy7Skhd8QIMiUcIVXUBCUbP3o1FYJKan9qZISQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 SA1PR11MB8839.namprd11.prod.outlook.com (2603:10b6:806:467::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 23:32:17 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9870.016; Mon, 27 Apr 2026
 23:32:17 +0000
Message-ID: <eaf915bc-8edb-4ba5-8505-3a78b4fab667@intel.com>
Date: Mon, 27 Apr 2026 16:32:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: further issues with MGA G200 graphics chipset
From: Jacob Keller <jacob.e.keller@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Jocelyn Falempe
 <jfalempe@redhat.com>, "airlied@redhat.com" <airlied@redhat.com>
CC: <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Pasi Vaananen <pvaanane@redhat.com>
References: <76aba88d-ec23-4b3c-ad91-83face0c3e94@intel.com>
 <a9d176ec-d19b-4f41-af16-cdc4e475a8cc@suse.de>
 <6ec01703-31e0-4998-9508-a5a115ae7bc9@intel.com>
 <14aa4840-29c4-46df-b60d-8e1b92494ad2@redhat.com>
 <e9cca01c-960d-495c-aaba-327eac43cad6@intel.com>
 <a23413a4-f939-4a23-996f-4ba5c8294c59@suse.de>
 <5155f29b-bc4d-4e60-9a26-22d568c43e46@redhat.com>
 <0be82b55-0f78-4ef9-8b50-f068ec36ec4f@suse.de>
 <df849883-f61d-484a-bd4c-32da52473ad3@intel.com>
 <3def4337-4297-45fa-8825-4147abda49f4@suse.de>
 <174f2602-ee3b-4cba-b757-47c44e0fb10a@intel.com>
Content-Language: en-US
In-Reply-To: <174f2602-ee3b-4cba-b757-47c44e0fb10a@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0315.namprd03.prod.outlook.com
 (2603:10b6:303:dd::20) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|SA1PR11MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: b77499e7-8ed1-4e73-e61b-08dea4b53821
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|14066099003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 5DZdKhazAPHSq/gEoJ0KmuYc92aA4wBFZsbFOrwe8oiOjJfMppTETc1h+obwJa9rOURwHe4ilQmaop+lMhSZStZsWKtmP0t6GwVXJh+1CZ4MqqqoYVGaMhNxsP1oAuELy+nMWLWmCmP366QklaIW/bwAwKkyZXJI6aBfnuLzUfARf6zJ450vb0zym0tx350msnB0ozVGhuO78uqVYru0xEgyfUleqFJgmjKSko2SuhCq10fZJY7e6rsia8anU57X4ZawOVrVixS4+EgUzc0NKvyXKVS8BtjvjBd0wQol7uTbqQn7XnxKJieCW8X67lE8fqyAmG5YNWlcN/SKZC7HbVEnja5XdpR6EP7D4sK7iJNKfF+Ppsz/zHS5SddEU6sw5jzUUaP+RcjsFM61SgFTpPn3P8Bl7EHcc6zxkCWjTSeTwWg9JYlWNXmP+VIZo+Jrzc2nFjrfLBJS8AzStnAuRuh7JadJoIPGlFokXftB2XkArDSiSW6/FqHr8TqGo+fe62BArWaK8UaCVSpqbYJ4PoL3VSkgxHgeatOTAPOaUziYVH4BX+O6g7r9ULXryn6vfI6UzmimV9MEN3hIy/ieQtvyApdy7+yjYK7vcmP6s6U3lTyw4gVyRvdBBDptkNnNIN7seiTS4yshlNhLOC5EUXRfpUJBR5EjRSwmICF8PIQdDiZ0tqmkKZqQSIHcvsi5VK6Tx8AtKTRtvM7dgrv1CFAkHqHp90Sh2SlUHII1GUM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7579.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(14066099003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2hyanJXdmJYWDZISHcxa0kySVg4RXQvT3AyMUZZTTkyOUdwVm1WWUFTNHpT?=
 =?utf-8?B?Ui9JNC9VWldXYy83dzl4YzI4NTJoZUxlZG1XV20xcEhaQzR0aWVxODVLVzYv?=
 =?utf-8?B?TGw2U2czRjlJdGZCRndGWC9VNzZJUDk0RzlOQmdWVjhqMENNcFk4aXBTdmhn?=
 =?utf-8?B?MmZwR1lwQXlSWTJmTEFOdVRnMzEwNkE3YkNoL3lpY1hOejF0cTlaTDRMdy91?=
 =?utf-8?B?eHcvMWRiMm5KdnhCQm9XM0pubE8wU2hBS0RnYzZ6Vk45MzV5UW5rV3hmcVVn?=
 =?utf-8?B?a2c3Ni9Fa3lPNUF2YW1YcEpnVE10NjM3NVo1MXY5Q3NOY2JNRitBYnJwdTgr?=
 =?utf-8?B?bmFadGo4MDZDZHBZSXE0TFE5R3FyYzhlZWxIUVpvL09BRitXVUhNOWRQNkJT?=
 =?utf-8?B?Ym1RcHA3TGFUakd0bVI4WE04WEx1OENWTm52bjNUSGd3M0x5ZklmNm50ODJl?=
 =?utf-8?B?VmhEcVptSXVRdEgvc1BWcG5iSThOY00waWFtcWFGZW90czJnQ0UyKzJGL2RZ?=
 =?utf-8?B?Q3hJeERTSnJWc3U5dDFXUUxmM0ZjTkJ0UzNDczBFRTlGTkFkcURscVRSUmds?=
 =?utf-8?B?RElKSVRTVXpTU3BRTTN1UjVYY1NsOEZoYzROU1FtMEVRUjdsMjVGRHhOUHht?=
 =?utf-8?B?MGRUeDRSM2h1RkJPK1d5TEZLRU9DYzZTQVBCMkJmWDhaRm1lTTFJV1N1c1JL?=
 =?utf-8?B?S3NsZHN2UHB1bHd4ZkZ5YmQ5UGowL1hwNzRlVWFyU21LZThLWmhhcFhOTFdL?=
 =?utf-8?B?TUVlWklsdzNoQVpDVE9IWHNlTVFtVG1yWk5RM2tCREZPRWFzazVydHQxMnZp?=
 =?utf-8?B?MFh1bjhzUGRFd2plNll1U0JMaTByMTlzMUIweVF2S01nekZGRTNBMklGZjBS?=
 =?utf-8?B?R2FsQTJTMlpnQ25UK1Y2bzF2WFdHNzZyTmM1T0JMRGU3NTMrbTJQREhER2Rn?=
 =?utf-8?B?VEpjZ3F0WmRNOVJoemIzR2R4K2hlaXRFYzN0OXVON21PUGZmSGM2NjE5ODZM?=
 =?utf-8?B?UEV1dGRiVVhsL3hPRjVTVUJTQ3FUbUtVaWowM3NoYlNySkJMZWJxa09lb1ZX?=
 =?utf-8?B?YUpOTThzY1BPSW9heDJOakNGQWRWa0xJL3YwZDJUZ1lTYlNHek5RaVFhZFox?=
 =?utf-8?B?VW4xdWJBczJDOVBFYXJLV1VwZFF5QVVGVmJkRXFrdzJ5MWNpVFlYYWRGaVRD?=
 =?utf-8?B?NU94U1l0SGJNV0ZVUHJ3ZWdBRE5yeFpPSU9pcDZxdDBnZy84SWUyV3VVSlE4?=
 =?utf-8?B?YkIzN1k2ZzQxTjNQZjdVckgzcDBqdDNucEQxSGZGVnJuNThvQkViZE9mdlVk?=
 =?utf-8?B?QUZKRzFkMEZFamFXQUxWUitDZzRUZVprVXZGbUpZaW9EWXBGOFZNZUlRd3Np?=
 =?utf-8?B?Zzh1NG9GMEhoREdFc2tXV3o4MEo1dHg5UklxZFRseXpHeGRacE43OXN4WXlN?=
 =?utf-8?B?aE8xU21IcHJkdGg3MzlkcnhXOXR5K05GZmRyWVlrbm1NS245S0J2TFpER216?=
 =?utf-8?B?THM5RkR1MjRsL3M1eE1rVVc4Rk83RVFOdGMzTjBXaC8yZW5PYWErL252TGYy?=
 =?utf-8?B?dStPOW5LS0o4VnZiN1JlNndkWW5mVWs0VGhTSU5yQXdrT3NTMlZIR2V1L095?=
 =?utf-8?B?YmYvSjFmYno2bTVDSWFtditIZGk0ODVWZUhXVDdRZjlzNmswWXBlYUVLM0Rp?=
 =?utf-8?B?QlRpeTVkaTU0WHQvUmZvWFhBdHRDbXdpZHBMc21iclRPWEl3dlNEeHRtVFZN?=
 =?utf-8?B?YUZ1ZnlGSFViQnA2VnlUeFpPUDJTSHVQakNCc25vbE9jdUVxN2hwalFNZWpi?=
 =?utf-8?B?ZWZLYnFWcEJTTWJ4M2ptbVJxTVl1U0FDM0phWnVVUEw1dWxOS3N3MXZEb2g2?=
 =?utf-8?B?cVl3R2t2WHlYUDdTN1BjTnZETEVYbWdRZGRvRmJyNzY2RjJhcWExdUVsLzNv?=
 =?utf-8?B?WlU0RVNkNllDSG9pMHhlUjIwT09EZWk2VDMwQnhjVVhwRUJ5OU9XRFpiRVlm?=
 =?utf-8?B?SUlHekRSY2JDSytKVytwdU53Z2tBWjgwOHp0MnV5bXg4SVFjZVVDdnVBTFlF?=
 =?utf-8?B?MVJ0TGxyUUd0LzdyTFVsc0FBcnpGSmdyWForVWYrUUQ0Y0JSWHVZRkQ5OVlU?=
 =?utf-8?B?cGo4M3VDWkVieGJKRitHajNPdmRvWXZienVuYm03dzBmQmx5MGsyaVpYT1Ft?=
 =?utf-8?B?Sld6NUJtZXlROEVaTm5lVWtYcWU1K3J3TlhQSWJDdGRlZUlYZ044Q2ZUcTRJ?=
 =?utf-8?B?U0szdGMwRmRkYWFZbHg2Ump1TEtxSmhnaytmVVkvLzVoOWRpUWJwK0YzeG9W?=
 =?utf-8?B?SUJFSXgrbSthT2wzTjNjRXptY0NEWnNETjdDdmJjRGFDTFE1ckNTZz09?=
X-Exchange-RoutingPolicyChecked: sv4ODeL9vnFdOaqZ7m8ZcoeNpo0giKYOAWfQJSeIVRDr87UrYPSyeR/fWRNM19aoRyTJ5ZhcjM9pPRyB2xRyNnif+CfILKtcSB7GjUOyRaU8rOLO9WI9Icfa5T/DEe9dBQZZHePlNZGrHG+DslblAa3Lh0gYXcBalnBMbeB/WR5eXBcZbCiGWLZ48Tatzy2S2IDLELrxZxsw8xlkL1v1g9HHT4h+M+BLXHAoe1txDtg0Qv3l7ARvHGsmHkKww662JOFK0ZbBeMclkKE89FS52Gdx698bomlKN8ITIduwZJjoyB3E1REru9GNW5DJECqaQavSC70LE5UnW/w4cdohHw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b77499e7-8ed1-4e73-e61b-08dea4b53821
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 23:32:17.2407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwCA7/beUdOnRyQSM4T1z2ew2f74GmtTBFf1qyeUnyNYHQt/UrCBOofsyJA99zmQoFfWBm+IdOqr81zd+KO7Bc8So7552JnVuJscblYqA2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8839
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

On 4/27/2026 3:53 PM, Jacob Keller wrote:
> On 4/27/2026 5:14 AM, Thomas Zimmermann wrote:
>> Hi
>>> In the mean time, I'm happy to have our team test any patch to confirm
>>> that it behaves as expected and resolves the service interruptions.
>>
>> For now, I've modified the two places that have BMC support in the
>> driver. Could you please also tell me your system's exact Matrox chipset
>> or its PCI id?
>>
> 
> Here's the lspci output:
> 
>>
>> b5:00.0 VGA compatible controller [0300]: Matrox Electronics Systems Ltd. Integrated Matrox G200eW3 Graphics Controller [102b:0536] (rev 08) (prog-if 00 [VGA controller])
>>         DeviceName: Embedded Video
>>         Subsystem: Dell Integrated Matrox G200eW3 Graphics Controller [1028:0d38]
>>         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         Interrupt: pin A routed to IRQ 16
>>         NUMA node: 0
>>         IOMMU group: 16
>>         Region 0: Memory at e5000000 (32-bit, prefetchable) [size=16M]
>>         Region 1: Memory at e6810000 (32-bit, non-prefetchable) [size=16K]
>>         Region 2: Memory at e6000000 (32-bit, non-prefetchable) [size=8M]
>>         Capabilities: [dc] Power Management version 3
>>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>         Kernel driver in use: mgag200
>>         Kernel modules: mgag200
> 
> The device ID looks to be 0x0536, and the subdevice ID is Dell 0x0D38. I
> don't see anything specifically related to mini display port. It is
> plausible there is an encoder between that output and the G200eW3.
> 
>> The patch is attached for your testing. It would work against drm-tip or
>> v7.1-rc1.
>>
> 
> I'll give it a shot.
> 
The systems that were having trouble are currently being used by other
folks on my team to check other issues. It might take a day or two
before I can get access again to test this. I'll update you once I've
gotten access and had a chance to test the changes.

Thanks,
Jake
