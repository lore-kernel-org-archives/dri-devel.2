Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96ED2CA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F363B10E8FC;
	Mon, 28 Sep 2026 15:05:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="efVL6Z6l";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010018.outbound.protection.outlook.com
 [40.93.198.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59FDA10E8FC
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 15:05:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpdM6+dAGumO+3o40RS11jR9lRnNDDx8OSqrmy7uPoYwq6XP8dIAUXXEWf2UJLpwn04GUdErxCC6+n+UiJ5/OsCPlpgNQtMHvHTmtLy0tnUKsvhaq7qgI0BdWYhOB3a/fcPTX75N+a0eVa2odazcWlO8z4lusk2pZAw0F1/Q1Mttpf/r4zBjC7pEtXd2dsecgATDEkzWPwVqFBak2DRtIVn4J7eXYGW1A9lQOU+m4kTH8vazaVGn/JtiAYOUm9D8cbMLBp/5kDR0YUv/m8PDPSvmNTOSyoKtVwJtGXEIojlgHHHWNhn+cZN584GYUEGy4JYpJFs4qbmaFrW0FxPeiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs+Lk4KNk6jd0j66sPCNvJAzAvBniaNtPdV7KAQ9lGU=;
 b=YDflsoYTMjfMT5eo2k/06CuT2hiiGpPG4ugthdAHRtbVKfiYPQBFKAtSaNIyM7jIvYlt448N4zgM/UIyZ9FvfIs4s3DhFZ3dPTnTQ3P+JPxUQm5K3wiWbmRZo4pkr8cr4sST2zYr5WgvEGHSdfXgeLKL7gtwziiLZ8sZOC9SCvGBM8v7MNnvfPsJ7tqdwM8t9+4X4v45Y0TYIzyqk2Kixb2VjNlGIYDFoHm6/PFqebnt5LADDmbh21frKw4kjpisCRXCImi40ENWrwlp3AeF7knayqC7v9iYV6nBRJ+FNabpbPjoxUkq4JLarfccasOvkctsJ6NDq3TY/D0ISSnzHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bs+Lk4KNk6jd0j66sPCNvJAzAvBniaNtPdV7KAQ9lGU=;
 b=efVL6Z6l7ls+7sFoMz4SMDiiBfF2mweYfVjYSh0cb/wmAtF6IrCMV4IWSLAFThfDwoeX14iJEq91BIy4n4wvqKnltmb/ba1Ekx6d9M/RXirpZZUJJyF5VsezvsH9ztjJ7yVVhjwlI/IIGcIC2MeFffqzomXaQaYLfbAVC6jH0au/9dA3jAzr58SbkYm2LYSq3KeshsUvQ8iBp9KAetyCKCysKt4egNLhnliLKubv52qJAMq8dsda5FhUXrHlbOY+lEnqilNhbOvy66r4hB7g0fgprSV6heruogX/pNms2YiIkaDTCPGMr66XbtSGTrjk9YpOGnlY3m+hW6x1eQmeoA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH7PR12MB8777.namprd12.prod.outlook.com (2603:10b6:510:26b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:05:37 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:05:36 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 00:05:34 +0900
Message-Id: <DLR1JCUWS824.35QJU45D2W9ZE@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 "Robin Murphy" <robin.murphy@arm.com>, <aliceryhl@google.com>,
 <ojeda@kernel.org>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <a.hindborg@kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rust: scatterlist: honor the device's maximum
 segment size
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Matteo Kloiber" <kernel@matt3o12.de>
References: <20260831233215.287881-1-kernel@matt3o12.de>
 <20260831233215.287881-3-kernel@matt3o12.de>
 <DL8QLYLQJEL1.3F653J67DYZ47@nvidia.com>
 <20260913210806.125589-1-kernel@matt3o12.de>
 <DLEMH1X0KQA1.D1PYVJD0E6SR@nvidia.com>
 <DLEY8AHWZFCQ.QUHP2NHJW1QX@kernel.org>
 <DLEYQNUGTQYU.34AISCMMZXG8B@garyguo.net>
 <ea8caba1-eb78-40cd-b025-e8c02009f2d7@arm.com>
 <DLF2GNSEGHKR.2UI219W5RK94F@garyguo.net>
 <DLF3BLOLU8HS.1AXNNXWVQUFNU@kernel.org>
 <DLHH0K25NLX5.616R4D860TXU@nvidia.com>
 <20260927224446.1053037-1-kernel@matt3o12.de>
In-Reply-To: <20260927224446.1053037-1-kernel@matt3o12.de>
X-ClientProxiedBy: TYCP286CA0293.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::11) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH7PR12MB8777:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fce4a14-44d6-424e-1ffe-08df1d71f39a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|7416014|366016|10070799003|4143699003|6133799003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: q0wBw0FubBj04YrQ3eKngc4RJi9kUEwF9Oh2jFdO4unQqCJCXRkc6NIplCQfWPTaXqhvwck/TRZLpbqXkWqMW1jOPZ/g/E+Em/sHH24N9XQOkNJY3ZlL6MVIck9vJO5YgaS6PmEEaorbymh3lljvVOExsmmAFXAxii+TyVjpjfTEPjqu3EMGUlAdabCvUDX3BzT/QAgUEVdFtInSn4e02wB6RXLyDIwiQKhjGvRTQICXXuWy72+AGksFfOhfVDnRpnUyHJRn0duKn2IGzyOcTkCmJay/uwtzndqX7on7n6kSazzV7VJxMhW4IaJ5EUVmzXmoPjMj6yl6qiuyMaUo1aqF5tvyh2C2ogeT+71oJaCpQFHRNTbH01gG0+nucK+6SpCex4NBbBeVlR8ATT9W2R4TlkBGuH6bngkSZkwhQJvhxcLJiafjvJdGeyzebvKEwSxv586mAJMTSnUJSzicH/LGqllvn3V0eINXZKvpV0QCHVtblPxk3nZn98AXjEW8E9LGA2mpwSEI5h3D83moAp4zG/+1VpClWZzdAXvNyhj9obRSsYvEALm4BgJexFkJqcvpWAZQl5AZGWpRee5X82wk/0g2L8VDExzKGk32Qtr7OHMjjnsAB/614fkrxkPnFPe0ux3AOZEfEkPeUDc3vRI46sK96kcd0wZqGMs92KY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(7416014)(366016)(10070799003)(4143699003)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkZEa2tIVHFBU2hxek5uWmpUV2x5cnBEak4yNzRnRDU5eng2SHdqT3BxT1Z6?=
 =?utf-8?B?QVR3NXl1bVh2MDRBOXA0QWR1M3kxQk9tZG84K3VRbytNSFJMV0VSbDdIOFox?=
 =?utf-8?B?MCs0QXQzV3gxc3ZESWhXRnd3YWtEVGJ6Q2duZVRZMmsxWFRwd3huMk5QZUdY?=
 =?utf-8?B?aTNUQU9KQ2hiSzNScy9TOHBveTlqbVduZjRva01hNlVXVkkwK3dEbE9sVVg1?=
 =?utf-8?B?a0oyVTFkcElVM3o5ZlNCTThUTFNLczlwdElHOGxlWWhTVCtibkxXOG0ydmZt?=
 =?utf-8?B?d1pCd3QwUmFMcXBqNGNnL3RoSmx1NEpiM2NPVmJYRUtlRVArU21nUkJwVFI5?=
 =?utf-8?B?N3FzQ2tOcWVOaG5wRkJYTmVOUFFJV1J3Vit4KzBadHlaTGtWb0RjTWtZSHlP?=
 =?utf-8?B?NGpuUzFSdi9IWjFaa2JuM0NrcHF3dk1PdmhNM21FakNXOXI2ZHVFV1UvNGVV?=
 =?utf-8?B?RXpvMjFML1FTM1FlWlQ5NG5GK0hqSVlEbmI0WHBpSW5DUFNDM3JKNS9QSEVC?=
 =?utf-8?B?TWdBQUE2ZHBvVk5NRS8razd1RjNHRnJtbmlVYVBuSG9sN2VMc3lMazR3VUF0?=
 =?utf-8?B?cWJDYU1oYmtRZHovc2QxeHRCTkpMSTNjRVhPZk9XOUwzZC9KaWVpQ3poMlFh?=
 =?utf-8?B?bjhKbkt3ZjhvY0U4eGFmMkVpQ1ZoSmZMN0c2T2hqT3JoRXRpbnpXTkw4OGxr?=
 =?utf-8?B?ZmE2R2RUbDdIcE1RU3RzTG85TTc5YVI4L3hqYUxsUkxNMFJwQVdJd091dXly?=
 =?utf-8?B?WWV6MXVoc21ndi90MUZmMmxWeUtTWERnNnN1U2RyWmlMY0tMTnJUS3l4bFc1?=
 =?utf-8?B?cnFYdFh0WWllYWI2OEZMZkdBYmpiWEVpQTZRdUtoQnNhNE9PUjZPRXpZa1BI?=
 =?utf-8?B?QThncjNNUWdGNWE4dU1aWXVMK2xTUUkvak54akRhOHNDNnhDOHpBUVNFMzVQ?=
 =?utf-8?B?am0zYlVNejlGblVOanNhZHl0VS9iZitkMHUyU3FsZThKVzQ0RmRwOVg5VUdt?=
 =?utf-8?B?QWZHaFBxK3M5NE5hckdna3hCTStRN3c0UmJMSGFRVzBrRTVLRkdKOVJ4U0lH?=
 =?utf-8?B?WWNJdFJXYUt5WTFoSFN1a3lSZktvRjR1d1dtZzJKeGllcVNSZmkwWDUzZlJF?=
 =?utf-8?B?NkxZOUV2WGg4WnFrVEQybHVTdlhIVWtHbzJCZ3FWL1I1bWpqNGltRU1SS0ZL?=
 =?utf-8?B?dEZZZ2NWeHVkZVR6Zm54SEk5TmNHNldhL0RNanpwTEdidHRpWGxpWGcrQkJF?=
 =?utf-8?B?dysxTm9ZdTA2RCs3MVM5Zi92L3EvMXIrSHMwV3YwcW9NcDNXSXh3UURUY1Iv?=
 =?utf-8?B?OEozdS9yTTlWVnpIMWlPSVdUUWowNlBBRzdNWElySlJtL01za083cnVrUnNz?=
 =?utf-8?B?VjFDeHl4dEJZMnorNGZvWVZERlZiWE4rdXJBRmZWaEVlRGdXSHdVUUNoUHNh?=
 =?utf-8?B?YWRMcGRkKzF6Yi9MSEJ1OWR4a1k4OVBTSjNxcm1QTWtxSGUxUU1qdCtLenpD?=
 =?utf-8?B?WnZVaEdtMXNUemNKa0h6MTcxSVdJTnVDb2RRTjZFdjB3M0VkbWlacFl5SVZo?=
 =?utf-8?B?aWN3Q2JidjlVdmsyS3Y5Nm1tU3VkTWZuU3JxWnVFN0Z5bWh3MWcxcm9MLzRz?=
 =?utf-8?B?aXBWN1BOdG9uUGxjeGdCcUJmcXVNaGhqL3laelU0N3BtS25LU05SdUdkUUpL?=
 =?utf-8?B?VGx6ZHlNd0d4R0VueGtlNkY5b09ydzBNWmtOYlhxQnZORkN6R2RiY0hMaGxW?=
 =?utf-8?B?UmdKZkFSWk9ZMG9WVldvZk01SXZ1TFVpcHlDMmF5ODc5SHAvMTg2L1FNcWVo?=
 =?utf-8?B?RTd6dlRWbjY4VmhtSFFmVmd4dSsvakJyajAxTW5mZXlSOGZhcm13Uk5lSnRK?=
 =?utf-8?B?aHNxc3UxUWxNcE9NdFpNQkd3SkJkSHRNd2dURXFydzBzbFhWd0NraFdhdysv?=
 =?utf-8?B?R0VIMmw2azg1YU1ZWTNVMDlSKzFqK0VJT3lFbVRTMVRuQXl0bzFKUGZWd3dz?=
 =?utf-8?B?eVNDd3h6YXVLRk5EQUxNdStRMHdJVk9EUFpBNTBmNE1xSE4xR1VPUHFXa1ZQ?=
 =?utf-8?B?OGRhY3NPeVA5MEFMZUpOSE45T08ycmpxQTdKNDBFOHhkUkl2S3ZvcC9neGJk?=
 =?utf-8?B?OHRPSlV2Wk0xcWxCTjZKWE1wN1lzblRVL2RLVm1xaTJEWGpoS05BMnA2V21n?=
 =?utf-8?B?UVdPbG95cGxLRlJ0OCtnc01XM1ZpaGFkSkpjRWt4RW5vbm51SlV6UkY0TTNY?=
 =?utf-8?B?T2Q3b2NCK21EbmpFa1VBd01la095OUNUQk5xZVUvYnEraWNmUmxEWllkclRK?=
 =?utf-8?B?ckxJVW5CdVY0NlRrd1dRM1d3Z25PY08wSUV4cEFueUwyYnFDZE1MbG9lZUZ0?=
 =?utf-8?Q?3faFla+qNncFn3OxTWNOWzts1VDS29yDuYUDHo2MJJVBa?=
X-MS-Exchange-AntiSpam-MessageData-1: BMzafcVNJRDXqQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fce4a14-44d6-424e-1ffe-08df1d71f39a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:05:36.8353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EemIVQqhBmk591juynpPE5g07gkTehlSQxzYEeZQp75beP96yy/8fXLxBYorUoZ6OUXaYELHrTEPWjOZLFQUYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8777
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

On Mon Sep 28, 2026 at 7:44 AM JST, Matteo Kloiber wrote:
> First of all, thanks for merging my first two patches and sorry about my =
late reply.
>
> What I think Alex meant and what I agree with is that the new API should =
focus on
> making semantic bugs harder, not to necessarily make it easier to write s=
afer
> drivers. That being said, I think we can do both with this change.
>
> The key change here is that we introduce a structure that defines dma
> parameters for a device. This structure deliberately has no default
> implementation and new fields should be added even if they require change=
s for
> all dma drivers.
<...>

Thanks for the detailed plan; I think it mostly makes sense.

A few details that we have discussed offline with Danilo:

- The `probe` methods should not take the `dma::Setup` token directly,
  but rather a bus-specific struct that contains it and can be augmented
  with other capabilities. Drivers would have to deconstruct it using
  the `..` operator to make sure code doesn't break if we add new tokens
  to it.
- The token should not assume default parameters and only call functions
  corresponding to parameters explicitly set; converting the token to a
  handler means the driver acknowledged all the settings, so we should
  not make any parameter mandatory (the doc should of course detail what
  drivers *should* do).

With that and your plan I believe you have a solid basis to send a
RFC/PoC. :)
