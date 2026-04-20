Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F87F36C41
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 08:07:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66C3610EBD2;
	Mon, 20 Apr 2026 08:07:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="HIkEWBvm";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D96810EBD3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 08:07:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlabP1cIPqX5FgYrc0VNfdMbdDghld07aaAYmsbIN2SYPQC5bVjiWGs4RkPSDJtCdJLARTjGM9GUbdEMOi/fX0t31f/5YB8oQrCKF4gFHZhYZpTjxnhMXkP7bL1OjSLIRtb6Is5DsQjS8oKSA8IGrN0tqh5lojBKN3HheDOQtkowGbZqACJnhFPbaXEDagXCr2XkBj+G82hhULL1O1T7Aae5Al32HB3BpvolGuOkHY8V5hCOAJiZH6rSwNT16QfEE12kae/sc/2D/hJPUPe/GmDfD4+mW0U2E17ARbqv9jBkXoUzcNZRi07+mZFoSja8a3MeQfuWCRDCnuvEdXcv+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3q7X3zq9DKKG9D11fHRzGqW7uVsFPh7BMM3d/E+vLtY=;
 b=EvXljM7mEVTdYWjBmZ0vsVJpxKqktkZBrc105gGMXOXmVdc3pfMtldYFVzbNlRu2aoQl6sqmkJVoBG0TVEd9pUV+3V8eISsFBQXtx27M5LUWmtIlHHbjVVrv8JgE2bx1r/NdE2Lo2xyDLkMMKiDi6LWrXcLujzMARmB49Is0orVeOckDtIo+7Z+wGh4JGBZHAUmbgE0PTf3p8P01vv6WiLxm+bSOih0IFtYEL6yrKohIPpiAMJxO+93CFnfB7XMvJFEbMbAfgdRhppxj207B6Qy/l2j8WOp8UZAqsBUqlvKoB72x2Q4EBtOVujdf7jLGykzI1lRPldRXWxdi05mgXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3q7X3zq9DKKG9D11fHRzGqW7uVsFPh7BMM3d/E+vLtY=;
 b=HIkEWBvmFE5SUcqoHKna0qr0KnBsvf8MNdfSk5jU5PAF/609dnbJ14U/2vDEosOY2+iN8zbFwKbq8knBfBnezeqBEEu9HyG2LXlB+F8ULXkJklDSFwemXzPVLEWDLAd/u20uJYf+D1K/d8klWMMSsp5BO2d24+5OZi9dF2t2gx3tZpejo6Mi9qM/JCNONFmhri0tbgeC3WYwzCNZ7chKm9vb1pTqUzv+hjhmIcc9Hsk7+NtGiIBgzWiquCdhKprlRX3DHB8dXvGFq+OpAGd/7g3/ai7Yhd1ykw75NpjdAXyW9BISq8JAgAO9ahH1gLHtdSIwok+MLmBVbKKwbWMAMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 08:07:29 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 08:07:23 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Apr 2026 17:07:19 +0900
Message-Id: <DHXTTF1ZSHLJ.2SPZ5QXPWJRPT@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Gary Guo"
 <gary@garyguo.net>, "Alistair Popple" <apopple@nvidia.com>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] gpu: nova-core: add non-sec2 unload path
References: <20260409-b4-blackwell-unload-v1-0-0f5a2ff838dd@nvidia.com>
 <20260409-b4-blackwell-unload-v1-3-0f5a2ff838dd@nvidia.com>
In-Reply-To: <20260409-b4-blackwell-unload-v1-3-0f5a2ff838dd@nvidia.com>
X-ClientProxiedBy: TYCP286CA0261.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 76cb24f1-77e4-4192-0843-08de9eb3da07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: xSHLMRmv/6XIoEmaOUKRwZF9APJm3VsuJCFnvvXZrTQCtURPyLHhctXRggDP8PION93zhxPIrJltMd0G/LQ0zCccOvCOIR+k8VPHD03panq6R83BnI7X78v5XTA/ibjWiFUQ7cH6FOK1tbAObPvW0XYlVhiMHh1YcSsiik4KBlH9/N9PAo9miXzr/1VkOWe7zA5vcq4sCumiN/ss5ev3PBXcJgI6K+OnhnWrkhq9lcgrUWs+Caj+Sr5i0RLC/YK0L4yP3G/0PZmhMTCbFzLPsmovaWmSNZFcejVlfSIdS5EI7megEUHbICM317B5pTRdMkrpMZeULomuL+RJlF5PKR8mIErLuv6H9IALxGSc+amT76nasUXqYuc4szlCiNiW4GTvsANLFmvW7RB2WQxGRNTKk6ZJUoGIaVh7GXojONTeXM1YKavaDlm4stGLszbOz8tg++fHyYv/8kVO6v+hj9PJu/mhx7yoYDu95ddYPjczaTIqh8r4pMR77TW0YN3IY3CYob0ga3Vlrt7fNqdm/t/zC0ZLdqnnXHQ1VEG75zu4gRUIhDNWfzkjWbxX+InRbASrfuUVu0Op0SX2mVrYDV12qwiAvnlKqQazySirggUUTOeSq/RA+MP/RpxddtgxZ3e++gslPLdM/2m8GRv2KFV/MBlqamgBc1umV3hu8d7Jti5xD+5KlchrarrvOX69yCTN217ILiXjYxpggb6bakQsyw8fVt60z630ujDlhKk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU5rTEM0aGlZK1JQRWtlbCszY2oyRVpGQzd3WU1IZlI0YjdRbmN5RXBJVjBX?=
 =?utf-8?B?NDNRUFBaUm9yanU0eW5hcEVaQ2I5b3Zwb3c0WWdKZUlyaVNvZzV4QkdkbWJI?=
 =?utf-8?B?bTlKY0FoN2h2Y1EwVEQ1a3RVdHVCbk52SW41eDgvczVpUmk5TWdmMUp5Y0hI?=
 =?utf-8?B?ZERwVHdlQnlja0FHa21Pa3dUUHhLTkU1dmNhS1M2SHRuQTB1WFY2ZklJTFFk?=
 =?utf-8?B?NndpQjJFcHRxUzNwcGhrS1RDYm1JQ1hoK2NJT2l1b0JEcEtENDRrSEVrVFI0?=
 =?utf-8?B?RUxZcnFKdlNFS2twYUdxZUhXUFFqWDV5eXV2aVVWYStvaEVMT2RBYjlObkM5?=
 =?utf-8?B?b3l6cUI4QnlUOUg3aVFlZFJtbjhxMGhnQ1BxcGFZWVNZUlpZQWtITDNVN1Yx?=
 =?utf-8?B?clNGT2V5UXlWS3FBdGpGSDlJb0lVbGpoWk9TQVhyOStyNlV1RVhFQmh6WE1K?=
 =?utf-8?B?cElrcGxmSXowVHp5a2pIN2xJQWFLV3U3TFN3ZWg4dktRNStsaVltcDJtWHFt?=
 =?utf-8?B?ZVpRaVNub25QcnRpRXJZQkp4SS9wNi96N1BrcHZvUXNNTlJUdlVxSnJUWkx0?=
 =?utf-8?B?SDdBOVVSRHg5MWVzeEZRanJibzZ6UjBFQUlBeS9zRnFFejgrbUwxSFdiS1hO?=
 =?utf-8?B?ZEUzc25DMzFlekZ1N1g4dUxWeEdSV3pUaDdiTGJXUlJIdHJZQmNHdWcrZnZ4?=
 =?utf-8?B?TWtRaG5oTjV5R2NBZjExVFJ3c3hMR2VNZ3hEWUw3d1FQUlBWSVVnSXcxeHM4?=
 =?utf-8?B?UjRqeXhqRnBTTTNuaXJLWnZlSnZmcHlwRzJXSzJrTWxxbk45aFV6dHEzWFBo?=
 =?utf-8?B?cm9xcmN5bC9lNlhuVmVwaFlIOE1CK0Z6dzc0SU5FNEVXdmk5alJpcXZLbUpH?=
 =?utf-8?B?dVpteWdyNjNqekhLWEpPN0xiWDN6NHYyc2pEOVNRUkhDeldhQllHc2hDNlND?=
 =?utf-8?B?VnQrNXp6TDBxYW5KVlgybGE4WFRTZUwxZTNnL2dVU3RBanNtS1d4anh5ZXVQ?=
 =?utf-8?B?elZiNXV2TUgvT3ZWc2YxMTVHRXB0dGdkMlhxdnhjNFlPTGRDRkllVnc2WnVy?=
 =?utf-8?B?SmFtMFc4R2lENy9sR1VTdUpQOUJQTm9UT1p3dmNkUjBaaGZwRlRtbDRhRmVF?=
 =?utf-8?B?RzE5MjZJMkdaVi9sTjlscll5REVtbWhyZVJ1bnBiK2JYSDJLazF5MlBoVTJ0?=
 =?utf-8?B?ZitNeFRqcHZqd2RwbmdXczZYMWg1VWx2dXVVamZxWFlrYnFZTjltT1hrdTY4?=
 =?utf-8?B?T09rZnJqTEhQODRWdThIWUE5L3JJb3BreVFmVkJaYTZUMzF0c2ZWNm9ZYlg1?=
 =?utf-8?B?Q2FQcVNNNjh5WjNtbG5OZ3JNSG93VDd5em0xS1huVTlsdUo2SXJmVUhvTlFN?=
 =?utf-8?B?TnhFenFlUVhsYnZDV0xWUkpPTUYxOTZaRDVDT0lmTFc2MHNKTExYSk1OYWRD?=
 =?utf-8?B?a2lsTkhYUHQrbFBYZjVzclJEakRka1ZBc1BDd0wyT0JIU0NEbk0wZDBBSWVM?=
 =?utf-8?B?SDJaS2RHWmZqZHhKTjV2WmtnclZ6QTB3NkEzYjgzNVJOcWpEZktMVSs5YWQr?=
 =?utf-8?B?eDZVOGJrVURXMG1mNmZWVGtDYnJMOVRIMVR0VjlnRG1tZG9WRFJiNFJZMWRy?=
 =?utf-8?B?Ri94dDFkUGJQbWxJYXBIRExGTHF5UHhoTWdjVXBYa2pFdm1mRTJUN0tNS2V2?=
 =?utf-8?B?SXBjU0NreFB4QmlMeFgrbXV2cVBreDR0aXdIeG1xZkJhNE5lWjk1OGtLY2h4?=
 =?utf-8?B?WGQvRTgreEo4RklBUW5FYWx4RWw1Nm5VMmtMVlZKa0ZQVHhDK214V0IzaWda?=
 =?utf-8?B?NFpOVWdtYWRVZk1NTGplQUhBVzI3Tk96Q045alJIL1RCbWJVRzJkTm1rRWRI?=
 =?utf-8?B?dVR5RnJuekFmTk1hUXBUaHNYS0pPTFp0VlkrRXN3Zk42VDJadHlrejNVQnNH?=
 =?utf-8?B?OUJ4anprV3daSldEdzRlUnI5N0NhYXF5clU1aTZWNlN2WVZoaGdnMjUzdzJI?=
 =?utf-8?B?ajZPL1Ezam5nOFRVcHZLYndsUE9mQlRKUEdJM0NzcS9OOGpBTWlmTkp6a0dr?=
 =?utf-8?B?Y3NhYWxrVWg5dG5rSGdZd1ZYOGNKU2M5STV5VFhhM05tSFcvZDk4SjQ5Zit4?=
 =?utf-8?B?akR4RnRva1R0QWNlV0lvUi9FWkUrRUkyR1RpQ1FWcDB5WXJiaEczdVJPbzhw?=
 =?utf-8?B?R21Ha2F0ckoxWTRCZmU0YWNwOGdkVlQ5Qk95ZUVaaXdNN1NoeWZOQVNQeGlH?=
 =?utf-8?B?Qm9USHcrMVRNN0FhUEkwU3ZZUjNvQW5RSHVWVkErM1FKeGVjbXpLZTIvRDBs?=
 =?utf-8?B?R1pGY3dNdFZzWC8xNUU2TE5zZFN5c3dyUXJnejNMeDc2VGM0alZ4V0dBa2w2?=
 =?utf-8?Q?rJxO5PDV7XC8BV/P+CLMRabfhP+9Ge4qT4Q1VIWk1JExx?=
X-MS-Exchange-AntiSpam-MessageData-1: tw1sUAx4AmwXiw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76cb24f1-77e4-4192-0843-08de9eb3da07
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 08:07:22.9673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6DMMzdfJ7Tw225shg1Fokb2NWRniRR7Whe3nGoF13mWml425Nlqj1pIust9+g0kIPv+szKEFp3u9PI1DGQghQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976
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

On Thu Apr 9, 2026 at 11:19 PM JST, Eliot Courtney wrote:
> For non-sec2 it is only required to wait for GSP falcon to halt. This is
> because GSP does the main work of unloading on GPUs not using sec2.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Thanks a lot for this, I am hitting the FLR reset bug and this has made
testing the Blackwell series so much easier! :)

I think we should take this into John's series after rebasing it on my
unload code, as without it running Blackwell through VFIO is
impractical.

I think patches 2 and 3 can be picked up as-is. For patch 1, I want to
give feedback to make the FSP command queue sounder from the get-go, so
I'm not sure whether it will still apply after that, but let me come
back to it a bit later.
