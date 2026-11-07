Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E242606A334
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 01:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pCkYqA77
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE4F10EB0E;
	Sat,  7 Nov 2026 01:26:39 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B47F10EAEA
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 01:26:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPJoGsQaZyEqFq8ZJEMs+FURpr6uSi4umZCE9ze7YA+F01MC9f07Q0SFEKwdYnXcxVw4yJnNHMuuArHvtpqb4Wt3673RLVZBaGrcalkS6BP5egXecPkkmdYcXUL0aHfAPlN2pmn/Z02bahx9OxAv3LccMUcli6/sy8sHji544w/3bHLlPonpUuArmuGlCQmmGOjUaH0FiSIyEEGc/RZYUvk8SQiJhhpgGlXy8sk6lChfSeKOQ31W6qo9cI2TxUpkeLAI0xYdgekh3hBO8pyitVICXVrfmIu3Kl7dpJHu9fm4zn4LD+QMZUvauo4wirgyjvu8Hkc2mmRhmS+Ghh8Ohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeAhvGsyF5D4LwiVGiBGlu0QrByZZrdIpVxA56Z4AIs=;
 b=nyTx3QetFBckc/79BvtaFpOf3eU/KqTlw/oi1YDxO8scwpdXoO2dXKAMbjnNkDRD6RThn7s2PIrqV0svz/o0iGIhw5kLTG6WQs2nqMu0xUjKionCMNNZb/x2pgaqQnlBq5e35gV8mcZXdD8wjHOJiExo8rqBCHqB98ZwHAozr9xp/0lnhqJ3uDiRF1CcnUsM5r/L/aB20oQvAtUjBd3oK2mJfNv9i94fWabdbMiTNoxnCPQuSDL1s6bmEwWWHdLbmdAvocLEoKegql0pDLE9a+OaJT9jqmWYztQONfFZcEFlGHp63mmhXUieNOfkSiZHKKE0wPxJ2/1rp8oMh8cc6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeAhvGsyF5D4LwiVGiBGlu0QrByZZrdIpVxA56Z4AIs=;
 b=pCkYqA77iY1n3U4IVJ/Y2/wh7VrzDNeiSScyXAZVp5J40KaGxxLf0P8dW34Gig01pqE0JpLAVd4f8c6N6PHhHsgmqTixqmbQqAPjSag92DR9n2oNa/RTaNJi1GdD2q0MPXYv0ay2SZkc46Ro5jEyOi++ANDWQKc91tP904NEqJdZK/cBgx5Mq3yRKXkXHxavFMUwhMn0tFmDCquGRFC6AHUPgMSQGiLz1mPl2pcBRc3tXbwImIeVjg3a3woTKaTbD1DL31GuRelXrLTEDv1TJmdr5e9mUy7zC8KC70SLr5axc9OXO8GZ481+zfKpTr5drrv8EiwIdZHw0IoH34yHTw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DSVPR12MB999309.namprd12.prod.outlook.com (2603:10b6:8:41f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 01:26:27 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.007; Sat, 7 Nov 2026
 01:26:27 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Nov 2026 10:26:24 +0900
Message-Id: <DMOL5YCIIWZ4.3QZ73GMLSITG@nvidia.com>
Cc: <dakr@kernel.org>, <jhubbard@nvidia.com>, <aliceryhl@google.com>,
 <ttabi@nvidia.com>, <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v6 2/3] gpu: nova-core: gsp: retain the GSP-RM log
 buffers after unbind
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Vladislav Zaharov" <vladazaharova2018@gmail.com>
Content-Transfer-Encoding: quoted-printable
References: <20261014154554.231015-1-vladazaharova2018@gmail.com>
 <20261014154554.231015-3-vladazaharova2018@gmail.com>
In-Reply-To: <20261014154554.231015-3-vladazaharova2018@gmail.com>
X-ClientProxiedBy: TYCP286CA0286.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::18) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DSVPR12MB999309:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d91ea74-7af8-46e5-5a72-08df3c6e24da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|10070799003|366016|5023799004|11063799006|4143699003|56012099006|261021135927099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 2SpInPFvUq/zMmneG8xHiRTExIdqZZ2XiMu7ElH1BXph9srxlwlK67uo5A4YsDJZTtHbaAsFw9haM/Qb/AsNwrqiu8S2CxnHkoThcsI1gtACmL3vVku8AiV4TpwRIa7NLSi77jEiXVRjte+2KRCUpgpcIQ7K74O/HAU6l3/fHy3vV1TjTIkxb9hcdsx04P+/jk6rMEDRJUFHLdLgbJEt0fSVuWpszSaP3GsluOdITdczLI1V0GDDeDnY+cNQrn+Y7cI6AMp3j7e5Vm8cvKRdty9GKitx2bArKewMue6SKZK9mbejQkSBMK0tSsv/7hLIxq7KxdnlAvNBd0MOD8xvdo59bBGQasmgCOjR39+tVKuMPqBZfCl8rWVL0QRHDvlt6YI4rtNs/hT50LJsJr9HIDWCX/XT9cXO0oOuK6J1p3uXQ7II7bZLZl4XUJxQs+K3nHeEDnc4T07QgT3JqfiGK5PUYde0tf2noyOStIQvqzQ0D6aWqopeja4w1pJE3GrBSfWlvlpLj1c+e+5vZX3EHDEsMqT67JlEn7HofS2/gGwmTzjHDWKqu2a1IrQ67L3/XZ4FYvEkqUYg6Q+jq7N/urllsNqZOn7Eg+NXtPO26xyn76h0jJPGUmGpbtCEFnzzhDc/MfSBFeX2KJwrWkWT0+TBeDZlCqnDpg83zwsSDx0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(10070799003)(366016)(5023799004)(11063799006)(4143699003)(56012099006)(261021135927099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWw2dWdkL0JnYzJNd3kvNEZWMitVZGtGNnNIZHNRYVB1S3JOZS9iQWd4N2lP?=
 =?utf-8?B?SThSRmgvcmRMNDNzaUlncE9YOUlFQ09OdlZkdEt5ZWNwWW03TUJEbHQwTkU5?=
 =?utf-8?B?cDJwQ1FoVG4xOHlHL1FQZTZRTW5vdVZlUE5MUE1aR2N5SmE2QmtMenNYWkRB?=
 =?utf-8?B?Vno2Snl3dThWRVUzL2F3dWlYT0Q2Z0xWbG1Ia2pLWWJaMWlqams0czkzejN3?=
 =?utf-8?B?U3JvZUVwU3h1V3lBN0pzYTNmV0VxbFNVVWlaYkVFNWJnUFZ5eWcvRnFWc3VC?=
 =?utf-8?B?N0ZBencxN0pxUDEzS3diYjdwbE1QNkdtMXIxL1ZJa09Ha2w5YXQ1djM1V210?=
 =?utf-8?B?VjVWZytvbVU4SURNY1JLbFJ5d1FFYkFScVJCTTYxMnUxeDBjRUhZdXE3NUpM?=
 =?utf-8?B?TUp2dmFabVVIdjBqdTNPQWFXdGRvdGhIMnpGT0x0NnV3NHBwSzc4T1g2MlFF?=
 =?utf-8?B?VytqczhQQXYzbUJwdWZtY09SUWdXdTEvTzlyU1hWTmdoZFN0UnRtMndGUVpD?=
 =?utf-8?B?TmRPTWlMcWdpRjIyS3VTWUJNaDRqalkyQW1RSU83SGppL09LaFB3dkM4U3R1?=
 =?utf-8?B?bGdRcmpJVVJyeTQvRzNaeGJ3dEJyM0U1STdQZUluYWl6a295UTd2aFhncGNk?=
 =?utf-8?B?bkZxZVRsbFNXUDBaN28yUUI4dktYNUhUNWphUnpVanZGa3RwbmJoTm5uSnVp?=
 =?utf-8?B?blVJbThHT1JKaE1qWTZPVk1UTWJVc2RoOTludFlDeWFLcEJ2U0dtblRrbXlU?=
 =?utf-8?B?NkpwZkFja0R4ODl5MDNoSjZ6VUV1NmZ6dUtXNnBhcW1sNGE1Y3NxaTBZQmJI?=
 =?utf-8?B?N3gzZXBnTWxDNVg0MWs0Qms4VHF4TlE3OTh2UXk4QXI4MUhYUXdkbUFOcThz?=
 =?utf-8?B?RVYzL1pRdE1ES1pxVGFVZk5qcmNrQi9zazJyZm1pWjR1TFFPc3Mxa0FMZjN1?=
 =?utf-8?B?bFg4OWNTS3U0VnBjRkFNZlVuWVBLa0N6SUxNaFZveVZGeHp3UEdGcTZxNHFn?=
 =?utf-8?B?MFlPWVgzVGxFdzRzeU1Sb1I2V1Brb1dLOTZmQmZ6RUt5bzJENWlZclhMbHlB?=
 =?utf-8?B?cHJoUnppUXI5TVg0M1NiWS9STUdCUmw0YTJlQVJjb29pcGJpbXFuZHVnZk0z?=
 =?utf-8?B?dm5aZ1dvbjdLcW5COU56d3hZTzhBMXJnT3BFek5wQ3hqZm1DdWwvemszVFlN?=
 =?utf-8?B?bDFUVWZCWTU5R0VJbnUyS2plL0E5emVpVmt5UXBueHk3SEJPSUg5dUJZZlc4?=
 =?utf-8?B?VE13ZFNTV1NBWkJvZVhINGhiUy9JaWkxNjlpeUtQTGpBc3RJSC9XSFJVUk5S?=
 =?utf-8?B?ZW5oQWMyM2NzYUNXT0pJMWZ1eHpaZjJzcEFQa1A1SjI3My91cWNZUzlpOXB6?=
 =?utf-8?B?R2ZkRVFEdE92L3ZYQVlaN0ZaRFRUU2cvSUE4UGswajQwaE82VXNBNEIyMm5S?=
 =?utf-8?B?WXBLR0F0QXJvRkpONHIxTG5oUDdEbGJkSHRNUG0zVHJJQlFzOHE1ZWpmQk1w?=
 =?utf-8?B?NS9qZUMxZzhBRWtPZkdiUXp1c25YUUx3cjVrdktpYU5QUXJOMDFvWm4vM0E1?=
 =?utf-8?B?UFEwTTl3ZWdWZTFPblZIMTlpNGlzNW5pOW5WMlFBaE8vbkRwd2xoY2VFRmw3?=
 =?utf-8?B?SkhvckdZVHJFTHo2dEY5V1JKUkVVTU44YkFxYmQwM3FwdVVOM3lLanhJaXcw?=
 =?utf-8?B?ZFVmUXhaSWozR2wxU25uODMyQXFnMFQ4bGVpRXJCNUMzc0poL2dpTUQ0aDFY?=
 =?utf-8?B?VG42WkVsaGZoS1M3cXJoeDljLzJnUHRRMFJTcFVsS0NxMEsrY2FiMEQvYzBn?=
 =?utf-8?B?NGRDQkhDWEVhblFPWjI4S0pTbHhVK2dpeUUxejQ0UldGRitJZDdiNVdBczNj?=
 =?utf-8?B?QkRwY1FMc003aU0rWldqLzJBUmJkM0FxR2padVpmc2VtMTZiZlBPRnUxdzhs?=
 =?utf-8?B?OHBMMGx4ejM1ZXVXUWNsMVR6UVc3UDdmSzE0bm1Faklab0YxSkVCZ0ZMeDZh?=
 =?utf-8?B?L3M0TW5wVytLYUdQRHJZTWx5Sms4dUZGOXJYenQ3TUFHRlFIYlRBS2lzTzN3?=
 =?utf-8?B?SGcvUll6RlA1UkRSOGhXUmFmT1pWTUhVd05yZnVHTG9HakRURE9nb3c2U0V4?=
 =?utf-8?B?dU13UmovQUU3YjJmWGFlZUJ4dnl5OFNSTittZEU4L1hYM2F0YWsrWmc4eVdk?=
 =?utf-8?B?UVAvVzZDcVJXb1pmZTlYOHpVV0ZmOTFSZXNXbHNDOG1vM3dVM3pnNlBJcUtF?=
 =?utf-8?B?bnJZRkYrdlBVZFdiTjJBaHcyN0g1STNFOWlsWktHanNBeHBKVE5BRmZrM3ZE?=
 =?utf-8?B?M0NaNU9uUkp1WnJRN3JzVkxldENCN1N1d0ZHaUlBUStHWmZSV2t4UnFYV2ZU?=
 =?utf-8?Q?1sw+O/wc56jSTTAF1FwlKcg7mQHtrjivcrceVmQwVYDyU?=
X-MS-Exchange-AntiSpam-MessageData-1: pinhhxg8AIWOqA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d91ea74-7af8-46e5-5a72-08df3c6e24da
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 01:26:27.3367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRqm9fLsLX9n/cCesGJh50c9UAgrUX58nqiwlJpSjcIerR3QzAZU53QGHJ5Zi5/ODxZePmeterkUpbcG4gXN0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999309
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Oct 15, 2026 at 12:45 AM JST, Vladislav Zaharov wrote:
> The GSP-RM log buffers are exposed through debugfs, but the Scope that
> owns them lives in Gsp, inside GspResources, inside the Gpu built by
> probe(). They are DMA allocations of the device and cannot outlive it,
> so the entries go away as soon as the GPU is unbound - and, more to the
> point, as soon as probe() fails, which is exactly when the log of a GSP
> that did not come up is the thing one wants to read.
>
> Add a gsp_keep_logs module parameter. When it is set, dropping the log
> buffers copies whatever the GSP wrote into memory owned by the module
> and exposes the copies until the module is unloaded. A buffer whose
> "put" pointer is still zero was never written to and is skipped.
>
> The GSP has normally been stopped by the time the buffers are dropped,
> but a boot that timed out can leave it still appending, so a DMA read
> barrier orders the read of the "put" pointer before the copy, and that
> value, not the one the copy reads again, is what the copy keeps.

That paragraph is nice as a code comment, but that's an implementation
detail that doesn't belong to a commit log. The commit log should tell
us *why* you are doing this, not go into excruciating details of *how*
you did it - only the big lines to make review easier.

I'd appreciate if you could do a pass on the commit logs and code
comments to deslop them and make them shorter and to the point
(similarly to what I tried to do on patch 1). Right now this patch
is pretty heavy to read.

>
> The copies belong to the module data next to the debugfs root, and live
> in a "retained" directory created during module init rather than on
> first use, which keeps the teardown path of a device from having to
> create anything. Keeping them out of the directory used by bound GPUs
> also means a device coming back does not find its debugfs name taken by
> its own history; nouveau, which recreates the entries under the name of
> the GPU that just went away, has that problem.

What Nouveau does is irrevelant - that's the kind of unneeeded
information I'd like us to avoid.

>
> While at it, move the log buffer code out of gsp.rs into gsp/logbuffer.rs=
.

"While at it" means this should be two patches: a first one that moves
the code into `gsp/logbuffer.rs`, a second one that performs the changes
you need there.

Right now this moves things while changing them, making it more
difficult to review than it could be.
