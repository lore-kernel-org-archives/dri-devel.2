Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052ACC54FDF
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 10:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A12E10EE74;
	Thu, 30 Jul 2026 10:33:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="GCgmuKwd";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F71210EE74
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 10:33:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxr9isKi39J8N8eFXO15r5fUikwx2ZPaz3j16+Eh8cCGcn9RkK9oBzfvS7U7vcyEbgAbeDgAKo6FENZhI0Bumy9fDuvTpmxhgGfC7eKC5hpP6khddOdy7yGyvp7SLUkeuIyWS1QNMU5nLMR4wIzn2lyhdSrwyfMxp44X/jCKa9sCc8b1G+Jj39jXkn6dGYtT2TFZq06buwhyU1FFbiXB8uuZl+WB6XAXuKWtqlnnSQDZOkUP7mzCPDC8EGihk1uClf/iAX8y7zyK6MZhth8Tc0ON6CtrJVvY896qG6+fC1Wch9Cg/YHpoeUmQaG/xauUg5HqVXRv7e3bzupyDhdaTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMjc7g9UY1aZg+Yp3DPvs46TTal+G1oHq8MWeLG0T/s=;
 b=vqlfVVd7lZS299jyZEbJGLXqpwp6XcjNy7fQNjitzalw2oc45EnWiWlPzKz81VQq2O6XBrfT1MKhyxUqASRBPfvRtgGmzJXqMqFsMb/IiNoFr9AMU+HKJrtUj1r1asW/3qHsWn8mvDHP1AaZvHMrDZN3XTIWS2DL3+ZR1DddVYDKZ6rG0nrrx9SaJyg7/GLwicp8h4angee957UwTYIo8W72ugYigwFxVe8gHY6v9Ssd0jY1p9JpFezCCXFxAPr0K6WDt8Fani8ij0ZGuFO6Q9Y7innD+UtVGiesEnC+nrifK3i7lK8P1nXWjQkEkcy+4azlKppp+zODbwGUltRN7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMjc7g9UY1aZg+Yp3DPvs46TTal+G1oHq8MWeLG0T/s=;
 b=GCgmuKwdwv5N4juALg6ijz/EruSU+u/aNzxEIOyO1U71DKU+J+h+O11iI/FlLx72ru0uCW+GCn/yhxMUewpe+3TZvS4EhVgi161WR1vPC8OQwNwyc4fZTPg7QBZQLDHIEgwvCZ9eZ1FIkQAQ4mDctZbq4MVoamHDCilPC0oucuoXtUFgK7XkyS8JAhz0FmjBoKxgdqq81jghMGDzt666tsPNQYAaC2t26G9hJqZzn2bXI/GwibJUyL0JM466mNhVBVuT6W2vfFzrx/wlgW9lbv7td7RNihW/Pv8z+Bzt4Vx1aIXdXq2dq2nKZGG+f5eo9DJiX95TcqHsNwic2NTDnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB8054.namprd12.prod.outlook.com (2603:10b6:510:27f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 10:33:49 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 10:33:48 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Jul 2026 19:33:39 +0900
Message-Id: <DKBU6HELTIKR.2NF8HDO8EKUPP@nvidia.com>
Subject: Re: [PATCH v2 0/3] gpu: nova-core: Move PFB and PBUS register
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Antonin Malzieu Ridolfi via B4 Relay" <devnull+dev.nanonej.com@kernel.org>
Cc: <dev@nanonej.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <daniel.almeida@collabora.com>
Content-Transfer-Encoding: quoted-printable
References: <20260727-nova-core-regs-split-v2-0-21b5e6e32ea5@nanonej.com>
In-Reply-To: <20260727-nova-core-regs-split-v2-0-21b5e6e32ea5@nanonej.com>
X-ClientProxiedBy: TYCP286CA0099.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 96475925-45e5-4ae4-d607-08deee260a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|10070799003|23010399003|6133799003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mXfBc2FvJNL7myC9lPOZl5ugHRvBUVtOlZMDWui3kxpkhFYpgD+CEoNnU87ifpiMtA70Wu9C0Fr1V9vRpBb8lAq8+wnGDtLfhMAP0yjTQw70Q54xxDdAWMG0LDfYeRVe5uMY550CrusQ74PA63iz3sT3m4MOyLGB8rHvXvPAN7mPJuRgbhqlW0OXDgmhB+2ebKzzrvbI6Ef8oeEaP7eeBMzHV9tnHAilsw76QH5z7vH3/hFrYS2mrT0Nr+DvcPqLMfk2FAMrnP9ZiemytHLY+hnUSt0dV1gMqaJzQ52OK8JcfcLRsEdfOmVT63wic3OrjZrgmr9UtCkNomQcA97N2/NU48jhxN1bZvPlog24sqCqYfiCu29OMrNSjilEDhVE4i/tmuTLK6tGdEU1fRQ2aFdY7XkLvx/234lyDOCiK/SAw2hFegdsO06O24uGA1yNo65AUfSuG/P71isd7cx90f/kYrJgjnPfAsBdG6wrWAw9f7woDfUtde+adwxFVa2VIus/LpUFY0eFAfe5iUmoSm4po1VB5whIwsSfrpGcsqhgA113ZFE3o2a890/kxW4yjw31pAw6rgX4b3VlL5xa4fM4xTdp1GI0jEsx+LJq3sv6St9eX1KBg8G96QNLZRQwf2YBYibw1W09ktrws6Ocq5oX+rNSSkb3/3I95vgl+a0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(23010399003)(6133799003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dC9QaTR3MFdXOVlPNGdGdVF2UnNBSHdJMm5jR0VNQlBPcnpyaGZ5MU5kQXM1?=
 =?utf-8?B?L0tmWG5rRnJoenBTc1crQ3ZVa1cybVF3TCtZOTVpZ0prcFpOcVliRzgzY1ly?=
 =?utf-8?B?TGR0YmtyYzBTOEJMakZQcm1HR3V5WVhxdEt6Rnp6SFhjYmJKMHVERDdkcG1o?=
 =?utf-8?B?WDNDQmtIbXJNVVY0NEIvUjFxTEttU3FwR1Zpd0JoNUhNdXVwSHRIblRpWUxR?=
 =?utf-8?B?Wm1QL2VOTVhwNHBEbmZrWmRqdU5Jd1ZhOEVwTkljQm1ISVpiZjJyL1c3anFn?=
 =?utf-8?B?bFZvSCtkV1hnVjBJTjJ0MmVYam0rb0xGSDBiaVp3ZGxQKzVOVUNMd09vMG9X?=
 =?utf-8?B?enphOGc5U05LblYydUNQcXlPc2tNdGI1UTJxcGxOenVoK3dzcS9QcXQyY084?=
 =?utf-8?B?eTQzbWpPUlJKVjAwYTl3bTBkZlNocVY5djVtWk50WEdoWTZvWmhJemNtVExN?=
 =?utf-8?B?Q1pJOVlmTEh2blpJVVNHZEJwMFhmNFRpQ3hBaW1KR2lSeGRzSnZydFN5WmZS?=
 =?utf-8?B?R3NBajB4cTJrWHhoM0VTc3VmV0Y3Wk5tYXJLUk43MHZtR0E1SGE2Z0xJek15?=
 =?utf-8?B?UTNJaUJwdTB3MlQyNndnYkIrTWthajJ3Njl3UEtxWmhqK09ZQVJSejhzNUNL?=
 =?utf-8?B?T0FpVFFCbXB0R2x6NVFzMTlIMzY1dytITGlGcmJRdnNPc2YxN2EvOElDSHZT?=
 =?utf-8?B?NTNPcnNWNXV3aGFPR2ZJR2dPUkJpRTdEVFRxcWpjSHFiTDQ1cUVtckNUMnA4?=
 =?utf-8?B?VThjUWxaelNvOURUWitmNko4N094aHNZUHlCZ2k0NGRlcloyYnZUNWtiRFZm?=
 =?utf-8?B?MDB2TXBRclNTUHNsR0c0MWg0T2hNSUp5Q1hycDVpRklmempGMUhldU96Mjd4?=
 =?utf-8?B?WGNXQWNlVVZLQ09lUXdaTm1qeEhrcnpRZmM5VDIvZzZoTFQ3aTBtQ0hBTGdJ?=
 =?utf-8?B?bkpWbjFnbC9ncytCUjltb01kN0pKNENZeVRwRWQ1THQ1clhKZW8xK2dnRmtU?=
 =?utf-8?B?SkczQ2diWXp2Qm40N0U5YzY3OVdXRU9aRG4wYmh6NDZ6YzV1bTFZMFZNamw0?=
 =?utf-8?B?dnJBK0FnZkZ6Mlh4UmFWNWhjQ2lZK0tYUGRHUnhndk96bHpmS25HM0Nqdnl4?=
 =?utf-8?B?RS9uUGdCWWZKRUVySndaWUk4SStlSk53cUZIQkR4VlU3ZkdpSnYwbmJKQk5k?=
 =?utf-8?B?czBpb1k1bTdlV09jdFFMcXJPbEJ5bXMrT3NWc1crRnkrUnYyZmptenQyMUVL?=
 =?utf-8?B?bHBYTXg0cVZQZDVDNGtlNkk2Ny8vVHNYNGtvY1RkbTliZWRqRGVEYlM0enBr?=
 =?utf-8?B?Y0s4Zmt4aXRTeHRXWHd6MDIvSlI3WXNXVW9BTDFiVm80QzdEWFRpNVVLMUtS?=
 =?utf-8?B?UGp5c2ZLaEV5clM5K0MxamdvOE8xZHEyWjBpSVhmWlZWbXYxZlNTbVE2YmZ1?=
 =?utf-8?B?OUlWMVpDYVdNbWFxMHU5dzdkMXFveW15a1VRcWkwNE9GeVIzcUgrejY3Nzcr?=
 =?utf-8?B?R1hQQ1V5R0xXZmtKZ1JMUERIdHp0cGRFamVvZXVFaWFnNHZ0U1hFeFRsbmVm?=
 =?utf-8?B?VnplMk9ldGx0Zml3TWFLcythQUtZY1VvV3poeDRxRGtzTkx6M0NPOGdYaVcx?=
 =?utf-8?B?Ukp3dUtNY0NSdnVZRUpOMVp3TnR5bFQxNkE2TnErTGxRN0tiRXpUeUhKTkJ0?=
 =?utf-8?B?S21IaFJId1lCYnZlSEcwWnRiY29TOS9zRCtEWkQ4S2ttL2hOUWJiT1d6S1kx?=
 =?utf-8?B?K2wzRm5CbDRXYUh5M1hvaFJLK2RxMkRnWXZ6cUdVSDQrM1RETnhDKzZNZ3Nr?=
 =?utf-8?B?NkE1aVduZHY3eDMxbmJwQ3Y4V1pGc3hLOXhvRUFJSGMrYmZRei9panM1ZW9W?=
 =?utf-8?B?eG1idTh5WGlUelhKbFY5WmY1VjZzUllqVWU2M1hLOTJGSnlVakxDOWVGQjVz?=
 =?utf-8?B?L2hiUTB5c1ZRYmN3K0JxU0R1MTJiKy8wMmVVL253TDA0NWN1cHM2WGxJU25t?=
 =?utf-8?B?QlBGL0l4MGZXSDJrQXk0WGdCanc5RTFJWTd5UmQyUThwVE1QYmVYNHJib3FU?=
 =?utf-8?B?WDREbkF1Vm9PWk9Uc3MxTDdpYy9ncVZWVGRxd3p2YTNiLzl6b3VlcjFqVkM0?=
 =?utf-8?B?MXIyZnVXZXFIYktvRWpPWUpXVnhvUUZIWjcvZXFRdWtYT1h6am9UMVZtSEl5?=
 =?utf-8?B?dkZhYWZrV2hvTjIydGc3OUdRblNxR0V2WkdTbVd2VzVWYTEvcW9CVkpQWDd4?=
 =?utf-8?B?Y2xpVGRUWWpFNWhaUDNvVGhFT0tqaUJQVVpvYU9zTUZUOXoyTy9uemhNVkEw?=
 =?utf-8?B?UGdCY0hlU1lybkp1OTlqMUhlQWJ2dzdqalQwWFErbmxDRWlqckJXZVZiMlRx?=
 =?utf-8?Q?ANdKEYbd6xAJfkxyF9+ShmrY43drVAh/b45tz8+By9dbn?=
X-MS-Exchange-AntiSpam-MessageData-1: 7oGFgaDQmU6tbw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96475925-45e5-4ae4-d607-08deee260a5f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 10:33:48.5530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kt3eXZMtHqSf4OdlkwVj66r8s6efkoPoqcdJaYRs2xdg9kuY0l7q/bJO6KrHz+GGXUDkOB9NTTp6YpjURsQbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8054
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

On Tue Jul 28, 2026 at 12:51 AM JST, Antonin Malzieu Ridolfi via B4 Relay w=
rote:
> Split part of the registers definitions grouped in nova root register fil=
e to
> belonging modules whom actually use them.
> Add WPR2 range query function to fb module.
>
> To: Danilo Krummrich <dakr@kernel.org>
> To: Alexandre Courbot <acourbot@nvidia.com>
> To: Alice Ryhl <aliceryhl@google.com>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> Cc: nova-gpu@lists.linux.dev
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: daniel.almeida@collabora.com
>
> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Antonin Malzieu Ridolfi <dev@nanonej.com>

Pushed to drm-rust-next, thank you!
