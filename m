Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5695BF53D77
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 16:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE1FA10E2DD;
	Mon, 16 Mar 2026 16:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="A0aJtNpi";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010039.outbound.protection.outlook.com
 [52.101.193.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43ADF10E2DD;
 Mon, 16 Mar 2026 16:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRIh1dzKMFheYB1omKatG6crn0foPKSJgBEFiQRRxgOKDzvrquAlk0JHsEJy5gZjwrYfL0kkhABUmb2u/XL0hLl/FFDdxiYcm4WqBgnPmZp4GElPkPKUl324WoVK0UoVuj5DukyaOOEBBqEVRKpKbLZXDEsGBMQ/rk3qaS9pE6futPl8O9FnIgPJ0Ov4jp/N25+Ius1fbuVCrqeHk1s17RxnpPW5fqIp0UuxrtHfehW9dYxn03AoIVD55oOaD+kFqe++tON/LaPO241QANF5WaecI5DYFLqme7+ZKIbSN6DimPMNCZC1qso180IAow/5IR8+dacmnEc60OWzypWo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHlao23DxxwzyvrHhDpMTRHDXA1R1XjDpttGB6+3rPs=;
 b=GO0cHT8VRn1KApq6f0SWg337ZpmzVTe0oskTgkHlirMb7jds7ubG43jMnJhBdYtyFX/lXrapDX7nwBGDLiO1hg6nBKGLUEIOm1wTq0It69BRCf4SFIRl+vf12OVl0aoHiPqPOEgbznA/l4Z1Empu8S56F4AAr3frYE10eT+vmkGxKfWCf8MmtMD5zs1k99soP+jHDB8InSIn3japrydkyECkNUrSAsBuv6DCgSrx1YFBWuiTtY39U6DXippU8aXQylaV8vWf72qkn7Ytcqn7AOVP1BvBTxQAX9JdT7ofTV9Q1IRbi4pMw5C6GRzc4xhmcgE1A/fkZNCykvmI705yvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHlao23DxxwzyvrHhDpMTRHDXA1R1XjDpttGB6+3rPs=;
 b=A0aJtNpiXcLV0vEoAgVqqyDbNuHZ5r9IdpQ4Y92/TF646X5iWSXBtIpFEg3SxVsx2Ts+5Lra/GFIRXZZtUx96bDKtqmQ6zkNresYdCdCrQsxoSPuWDPzaGN/O2cwxHe26+bnP3FQDD+iuJ9RM/zB+FPNr6xyDZN+TjtlrWhoXzgger0E2XNqOL5amITcTeXa0aQVBHFgRz/oTbVa/9bOEtZM0u2e4shXVyfzKQlHnnt3zElYHnMiU/VV12I7SICW3Brhc87IyrxwRKiIeBHyMVyxXAeUqNddlwWZ2ai5l5JVaUziz1hlSY2Y8WsOuj2Ss2JrV2T+TFzeLibYxCWyXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 LV3PR12MB9094.namprd12.prod.outlook.com (2603:10b6:408:19e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Mon, 16 Mar
 2026 16:57:16 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 16:57:16 +0000
Message-ID: <522d44d8-b941-4207-8645-230c3980fee3@nvidia.com>
Date: Mon, 16 Mar 2026 12:57:12 -0400
User-Agent: Mozilla Thunderbird
From: Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH v9 04/23] gpu: nova-core: gsp: Extract usable FB region
 from GSP
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Koen Koning <koen.koning@linux.intel.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 Nikola Djukic <ndjukic@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 joel@joelfernandes.org, linux-doc@vger.kernel.org
References: <20260311004008.2208806-1-joelagnelf@nvidia.com>
 <20260311004008.2208806-5-joelagnelf@nvidia.com>
 <DH48IO1JI6HF.37NLGWHY2LY3O@nvidia.com>
Content-Language: en-US
In-Reply-To: <DH48IO1JI6HF.37NLGWHY2LY3O@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::8) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|LV3PR12MB9094:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f3fd20-7c6b-47f5-dde5-08de837d13b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3yvVsLtTIWoUJS9v7UmWM3IEQf2zuKOChPigYiYE4dJEVX6fWjTZVtNvUAtBPgtPhc1nE5Vmw36aibwVWUGHNK52+EMb3298yZ43ioXR2ZiyO12SrgIlSYMMuqkEzacTkdzyX8mBMCD+EomoiPKEooOcgBM7hMaUN5vaysB9TPQ5MYBoHAitB79PreKKZg8WK6WEB3hGGYbQEKZCan8vfYyiZYfLcVqGHjLCjLc0Ffn90mRbl43B1/MbwFBLAMuB+sU/Zp0nwjbR8LOrZG1rof0vFfApjrs+6GumrLQXkLTQcFacE8wfGoB9c0haPlThosQ26agVQo4jCDsi0mvnvmTUXiCK0HNFgMKbdrtGN187P212dHX7mlo4MwqscbIks2l23rpgcPYmxeO72GfsP0wcmOH+2D30AopQZ5sNpjT5oBN3W/9Kt2Z76gjVLpQj+gIxc0mP+0RNl7ycl7G6whYG88dYdo82jdCSDiGLhe8W6h5WXrUGZI2S6Ie7rC3//wU0UNHxEzXSouoepldkRfHj3hLJMzjNIZDL/qbMXeEuDvNlYeDBm2amvhhMReL0LuRzbxMnB4IwZN/mmdQ/v632k3S242/CHojUhEdvPccBppYU5MmNXTA+/psAb/feoNWdu2YpS0TOAwAkvEKch5eufZ4a0uwz5U5Xinn6Psg7TcMPbnqR9dI+I61WBqRujAELfP8eFrdALCkaE+hX1yRYtU+Ryb0OEFx9o8Exu14=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmdxbzIvYUhTMkxJT2xXbkEyV3BhUG92MFcrZGpQTW5WMHFBOWtMSnNlMGpG?=
 =?utf-8?B?ZE5icWpxRnhuemF1eExzL1VCenkzeTE2M1I1VkFlZStYaG44RTA0R0U1aHNv?=
 =?utf-8?B?YjZJWkE5R0JhblIwMzJkQ2hoL2NreGh4QUExSW8rdUIrZGtoMGx3alFzSGRD?=
 =?utf-8?B?TzdBZ0Y5RkFsMm5BUmp2RmJabWRSdE5ManN5ZlVSQ3k1UlNvRjhwRjFxVDFO?=
 =?utf-8?B?VVBCbEZNVjRJME01czJuaFZDeTdneDdrdGw3ZjBnTWlPZzVjWXN5OHpaaTk0?=
 =?utf-8?B?c244dWttK1NDWml0Z3hrK3FLVVpER3AxTmYvS0VXZ0x4b20yakdjd3VIQ01x?=
 =?utf-8?B?VlcwWUpxa0hCaEx3dTk4WENWNE5vRVMyODJtYUdISjBqV3EzRC9xY2hVaEhK?=
 =?utf-8?B?L21MQ21GajlaSDBLamxRdTcveGZGbXFIbEw4MWk3cVJ1YlB6cE16RDJFQUs5?=
 =?utf-8?B?emtzTEl0YVZGeTAvUGM0QVNtdXlOM1o5TFhpNXk4U0xPYVBSSmlNZHliOW80?=
 =?utf-8?B?b2FHMnNnblBBQVpsb01HaC9RSVBJSFBzUG5vRnBSc0Q2bkFOZFNMR0VpN3Jw?=
 =?utf-8?B?SlpKRHJXQm5SaW1SSEhPd3F2MGg3ZTIza3k4NDNiZm1vdDhNaGpWbzdDUWlN?=
 =?utf-8?B?TGMrWW14MHkrZ0lhN0tzVDQ1aVFsM3FVckU5cU9nd3RNdXRUNVMwOTNuUEZa?=
 =?utf-8?B?clI5eWdVWStTVkJZeWJGbGR4eUNLRVM1M1Z2L2FoUjVpaCtTQ3Z6S1d3OURp?=
 =?utf-8?B?Y2ZvSnhlMkVTbFJBZHBCN1FaQVRYZFYrZlFVaHZ4SDhPQVFFL1NUaS9NdXJX?=
 =?utf-8?B?RzFIREVzeTJpNTlRbnpKNmVjWkdsaEljU2N6Wnc2WjFUb3J1QnhKcFZVN0dm?=
 =?utf-8?B?aS8zOGpsbWlGa1lzU1F2Qlc3YVRIa05pUGxEWFZ3b0l6cXNjY29aOHJEMkI5?=
 =?utf-8?B?K3RmUkQ2VE1VQzVNWEg1N21SL1A4Vmk1SlJONEk4M3pkdDl4TTM0b1AyTFZX?=
 =?utf-8?B?MXVSUG0xTzRTdWh5ejk3NjhDVThVbG00ZzdWbGJVWXRxUjNxN21Fc09BTDFi?=
 =?utf-8?B?ZjUyWlF0clIyZ1VydVdnQVRqT3dEMlNyajZJcXFvZENlSmFCQTcyb3prQTMy?=
 =?utf-8?B?dStWcHRYVFZjdlZQSTVyN2UvRjdZYXF4ajVabmVOUHlaUjZlazhnQmFTaDZy?=
 =?utf-8?B?a3I0TWU2N0Yza1BVVGhSZitqcDVxTDV2QzhEQlNHNnJiNU1uMC84azgzRUhw?=
 =?utf-8?B?K3pUZ21COHg3aThrSjUxU1FXVUgvSVlrcDhQSkxUWWJ6QUJCTHZQbUxpUzJY?=
 =?utf-8?B?UklzT0lXYlhWUGlpcFR4MngvR0tTTDZWUGFBcmRUeUc4K1VXbGs5U2M1NXlK?=
 =?utf-8?B?OEJFc1Y5OHJLU1hyK1AwcVN1QzZ6N2tDWlBia1VXK1R6N0pjbWVEc3pDcmt2?=
 =?utf-8?B?LytIemZpMFM1TW1NbzFsakR4bkZMQ2dubU12VnpWSEhOS0J3dlZ1UVhac0Q1?=
 =?utf-8?B?ZmRIdmg1a09nRStmbGFCUitwa08ybzB3TENDNk84NGkzQlkrVkR3Nk43Rjkz?=
 =?utf-8?B?bTNDOU9ZT1RmTDhEbmRZa1NUdk85dWd2ajNzNzB1NzZiOWxncXBNbzZ2cGNu?=
 =?utf-8?B?clhrcHdLV0ROYWdGUzQyUWFMV21VOUpCbjUwR1ZSUlRmbWo2a1M3aDdWVzFj?=
 =?utf-8?B?cG1pK2E4V1lvZGplelQ4bkIzUmNTeTJ5NUNyaVI3T2QyNk05Qm5OeFlPRGVj?=
 =?utf-8?B?cDJtc2M0ejJrRCt3bUFKWlAvOVVPUzV1UUZQQk4xVzJOcy9jSzhBbkxEK2lH?=
 =?utf-8?B?NC8vOHR5Z1ZyTnY3RHBCMXRkT3ZKeExKSys5NS9vRExkcE8rOGQwSHJCTURP?=
 =?utf-8?B?WllSMGU3bzVoemJmdUh4QWs5Z2RoL1A4TDAvY1VZWldRa3VNc2dTT3k1OFVv?=
 =?utf-8?B?YzZ4b0lHY2p0TldNdUtWdEl0eFVSc2pBMVA3K2t6bnFXS0RFbmhYWGZDMEVO?=
 =?utf-8?B?cUlaS0R1ajc1czliZWxtNElSZGdNL2RKdElXaitXc2U2bGVUczVibUw3M0w1?=
 =?utf-8?B?Q1FiMVRVSHNmOTZ4RmV1c1FDSlJQQzVFSTBXbjMwaDZiSHc5NDNIaFFDcFdi?=
 =?utf-8?B?aXdYMkJQUi9Dc1JJajlhZjZ5ZTNBc0VlaWIyM3U2SXE2QVNXRmh1bE9zM3N2?=
 =?utf-8?B?R3AydDNMWXZhem9qdmZsWjYwMzB2cGJ3OHpTMk1QOGpqRU9UQm9zYkNmQklU?=
 =?utf-8?B?ak0vcVVrVDQzZ1J6NFNST2VWQ1I5anhjT3ZnbVlaVjBDUzU2L0xLK1ZlZEMv?=
 =?utf-8?B?UktORnp2MmdmQ0Jqb2RNS2FsMlNpMEM4WUozY3BBbmQyamlMalVHQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f3fd20-7c6b-47f5-dde5-08de837d13b7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 16:57:16.1016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: td2nJ6fXv2FFgjezgOiZl9UVz6mz95hiY/VYMG5DR+EtVlMON5ydIIhgaHzdqC8fzXG24ElE/DO+udloZcgvVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9094
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

On Mon, 16 Mar 2026, Alexandre Courbot wrote:
> This doesn't take into account the feedback I gave in [1]. In
> particular, a TODO to handle the remaining regions looks important to
> me.

Sorry about missing the v8 feedback. Fixed in upcoming v10.

--
Joel Fernandes
