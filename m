Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65631CD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 11:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD47A10E23B;
	Mon, 25 May 2026 11:12:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="kNTe5h/Q";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C92B210E212
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 11:12:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8FkEqRuKiIN+VEMHt2L3uxBgTDb3RLLSorksrlZbRbKevM2OiEVy0Wi/ogonCmGtjc2Ky1mZVonpPb9jVYPC4AhVR/mJ17/WcM6XSDjD3ikKxwUyIuEPLeAPFl9A6tkPR4fRRkAWqzOpP6pqGFoOfv+WjNeiSuWKI7rWtulAOhfed1wCOheNgb4ToNxNLoyzP5JJboX2xWU+E3Y3jJbB/zS5pNrTBk3BxtpSUqEXk00LnmI65Ij3dmnDaoqcG9MQUKiUnmfZh1UNU82y0Caq7Zl/tCfV6mZehlGkd0MubpGayVbkaCZcJPp08RFrs73F5wzsHilPeLhAhVWeniaUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuZeYZ0z/QskM3xrHr+idD9QgPnEfDBnYZSf3VZLXXY=;
 b=Nbxcmt8eSCtS//7m9hXtlyqaggdf804GdhnU9lMy6dcmz7M8B2M16FAilpvyJwcCajlJPltSZ8s4sLkEM3B7cqGO9eseTBfmWlWOMNS6V2LIzkvFVhqY0oZIQ5wfR6EWNBmKtYEg6CWlz9yfUqPtvXGE09AJ0kF4KA/bOuQzYBbd+CENrIOKxFMbsm/nc3vPFoPw+Vs7zI2OIkkeWzFVrlZx3mYEoJaMY/wMSQn4YUPZAU99Lsa4xTcd1Hf1lZkZRfdmbCkh8SIB7UJhmo2xFeHN3ALSBbvOhUOfdHLLq9eF6X3Ba2y4vHozI7gNfnhMtaI/oOItvw6cfAZvf1daEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuZeYZ0z/QskM3xrHr+idD9QgPnEfDBnYZSf3VZLXXY=;
 b=kNTe5h/Q4iGLUAijac1ZO5axuWpxbebFXWzOAoxWQRL5b70JJ5zucuKaZa/CPgSA1ym2s5ZDRB5KipHj446KciePoe8b+RH4UqZpFVa2laYZtuJ7J509kh4Q5uVs5yztiC+z22EdCysd7ajwCCy4OlJSJ0SKdcx4mkPsAyiWfHtTyMqSLMCvYLasqBLxH2u7xB+2kSQEt8gzYORYkom7v4+k54QcHAhn8Rzc16wtpXb3ioWiQwU602ls6Ned2BZb5khoiLZQ2bxoVC7olCtvftW3MmXLQTVia7Dk4tJTTVI6rJVyTBXUEGEBuCqDEaOZ8HYspzQ2SinBJ4QCqU7A5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH0PR12MB7485.namprd12.prod.outlook.com (2603:10b6:510:1e9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 11:12:25 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 11:12:23 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 20:12:19 +0900
Message-Id: <DIRPO4VAEB06.3OJOTPSHLKGCG@nvidia.com>
Subject: Re: [PATCH v4 17/27] rust: pci: make Bar lifetime-parameterized
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <aliceryhl@google.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Eliot
 Courtney" <ecourtney@nvidia.com>
References: <20260521233501.1191842-1-dakr@kernel.org>
 <20260521233501.1191842-18-dakr@kernel.org>
 <DIRPMGXM98DZ.3OQ68CH14J7SS@nvidia.com>
In-Reply-To: <DIRPMGXM98DZ.3OQ68CH14J7SS@nvidia.com>
X-ClientProxiedBy: TYCP286CA0070.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH0PR12MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 948710e1-51f1-4a0f-2ef3-08deba4e7ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|7416014|376014|366016|11063799006|4143699003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: IHw4gWXcgpVaQGq9ocgT5sbrBFXlGlqRWJm1zBt4AmHwhvsON042zXKdPj5+yGvneEtPq/Jlyt/ZPJTUyTBxM+rusR9nVQZ1Pr/QhZpFmfV2sBGHAdLhxYuDEAGS9YhQYP+GnfMdmPsZmk2BiUj7M/xoIXGpB5tk+La2NbbwARTD+raGUsQPS0QwRdQnV1xIKHHVAvWgwzcdT+cPhQp5Cg10xoGGGK0SYC0B8S+i0131b+IOTyMdneAFDzMK+FFb7dPT21JUjSnjgsR57ty4IlxOfAOH4qY/tiW3+J02M328pz/xb+tfe2qq+Yp82XETNyQ/vUepN9FYJXAX9mxsZGq6THTh2w9wZtzJI1HJVSu+9zZWuCatbj/jj7iUm11JQ3+FlZtDAQcrEV9tjBrI7VVj523V95OwY33pZzmzv4H6P6BRsoNc/xSxLWuLumo4/c/Ov0R4T646sufbcCSh5ydR+3so8RenqZ5GHbwuChLPpeKCxQpL0ncJkFVtbu3NmjvvnI2JMBLMt5BnPS6N0tyTmMZXFizVYL9/50PN/zwag11K61O/i2b1BCKT8+Gaak0ue9yGLMRjYfFproB85K0aRtjIer4ekMPA8S6RsOWG2hVuRMym3/+OqO8/E/OTObmZJFUB8Xcuwddj+I4OvaqoS6fiYM5p5DCdYTQ3tG8bTJOSWaAHeQAhn9PCMvia
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(11063799006)(4143699003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUN0OTBFdWZiem9FOEFOZlp1Wjh4OVhvQkMxZnN6RHhOZnpHYWRneVdxUy9a?=
 =?utf-8?B?YU9qYldyTHhxMlBWeFFlY1RNZDlOLzJrN3NDR2kvZEhpV21hbk1xNTNmNWs5?=
 =?utf-8?B?UHBzalUvMTFtSHYvMDJKUWFQUzVXS0h0bzlTbjQxQWtnaVZkVG5rZUdGOFg4?=
 =?utf-8?B?bW1RVklLandrOFFSeVAwZXVBcTZpYnRvc3VJMjdiMlRwNkxDVCtnOUFwYXMw?=
 =?utf-8?B?b0FCNEM5TlJ1dm9RMU0yNFpKY09WeWhZbTZSUzZhRW9mUkxUdytpSFJpTzRq?=
 =?utf-8?B?ZFd5aThOYnNzS1VaZVg0K0psZnZZdEpIMXhVbXF6RXRnbUVzN3RLeFBYUURF?=
 =?utf-8?B?eHZ3YS9KYkFEcXJMSjRHUkZROU5DMzJib3FtbnkrMzZ0dEdZck5PRVRpdVR4?=
 =?utf-8?B?a3liNjNSdktIbjdSTW5rVDl6TVlJRTBZb2FxbVFlWk9aZ1h1Znp3VWdTTGFz?=
 =?utf-8?B?VFhUNEhKR0Q4b2pmRWVEQkRETzFzbElBcnE0SlpLdGkvbUtJeVpBbllVMy9Y?=
 =?utf-8?B?ZWZkVkk2elVoajJTeFE4cjRLNWRmcXpycFcvV0ZLMitUdld6K2h5UEk4QnRN?=
 =?utf-8?B?SWc2WjE3ejZDckQwM2pzMnJpUGhwSzhqSzVkSHJTam1GcTJGNURqNEdXSlVD?=
 =?utf-8?B?eXN3TXdkSm9kbkFIRWxPalRxandXSSt4eU1oQlhRRzlsVjZHenY5cStVb05O?=
 =?utf-8?B?S0thN1doZEl4SlgwUm52Wm5OcTR2OEFDa2lTZVhLdVJ2YXIvMCtOdTJ5OHh2?=
 =?utf-8?B?QVh2RFlPaEttU1FwYWFabmVYeWRuZE9KejNNQXd5dGk1ZVV1U21XMEZtS2xW?=
 =?utf-8?B?WWYzQ1BpRkQ1YkorRm45MklQc3huZkFxc2JpYXY2cFpqK1h0Y2x4ejd1WDIy?=
 =?utf-8?B?aEJKODdjdTc0T2RqY3lxemVkc01lazJqNTFLYTFqZmFPOU9HN1pTOGR0cVN1?=
 =?utf-8?B?ZmtucDQ2UHR1U2dyNlRjc0VtcmJwSktHT2dzWlpJSUdOMHdsUVpUbXI0cjEv?=
 =?utf-8?B?cFkwUWFsNmFkMC92OXlMWU1QTXp4b1pLSmpNUXh1VUMxQktGK3pIT1krTHhJ?=
 =?utf-8?B?Z1Rub3RVcU05MWxWODl3ZzA0SGhMZGYrOWNIeHo4eUVPS1dPcXRMa2t5Skgv?=
 =?utf-8?B?LzdYQkdZRXpiM2VHSWRuMXRkT3hKSDNQY1dqdjZhZ3JSOFpaR3JWZEx4bzIy?=
 =?utf-8?B?QndqV0cvSGx6dE1kNHFhZGhpTStKNmhiQlJRT0NwRTdHQUY2WlpQVi81Y2xi?=
 =?utf-8?B?Z1BUMXZ5UmhsdzdCK1VHU2FzYmNiQ1QzMmRMUUtGQnhNTnA5V2NKTytMeUdy?=
 =?utf-8?B?SmFOMXFLcnBRZ1hPUWp5VTZhMTNsYXVnRE5KcW1SK1VxeFVicFJXNXhoekZD?=
 =?utf-8?B?c1ptUVBCUk5TT1hUZy9zY3JTNnZLSjRtbmw0anNlbjE3VVRQSjdjcHdKVE9t?=
 =?utf-8?B?ZWNFYzQwZG1PeHNOb1ZvaFJ5MkR2aC9LSWNNOW1SOXBkdlN5M0lvU2JlVDRH?=
 =?utf-8?B?K3N5aXpvRkZtQVpoZ0cxb29GSnNxZHh6R1M0dE1HUFl5UkY0Z1RUbnQyQmlo?=
 =?utf-8?B?Yit3dVBsUXBnSFhCelhLOTg1MndCY29EYzFDV3hqZkJvNzl0WUdBNm9lQjIy?=
 =?utf-8?B?MjVuWEUxaW9WRHNPR3NISFdsZ0tqKzhkYmdIMjRsRUVJRVlQeVRqbjBSaUwv?=
 =?utf-8?B?aWVDR1EwVnNPNFJrKzRmcnU5NTRxVjM5NDBZcHlKUVRXbkMwSEcyTWNwN09F?=
 =?utf-8?B?U2FLVnBqNGFRNHBjMEM0QkwyK25jYTRXdjJ4YUE1T0Y0eHpLbEw0eDBaakwv?=
 =?utf-8?B?dE0rQVRaQmtaaitjZHN2MGM5NjBrd1RucFJvU2JlN2t1b0xKNGFYNFRBMlFR?=
 =?utf-8?B?UjhpaUlpOGtQajFXNmFIM0l2Y3Z2aitxdlBrTXgvOHhzUk85UDBVb1ZTRWE2?=
 =?utf-8?B?cGRtQ2VJMFZPeSt2ZFZ5ZzdyWFFvUWpCM0VZUm1sN3I5TjhxcVFmUkdDNFdP?=
 =?utf-8?B?bWhMVTBXZFpPZVh4VHQvNnFtQUFDbGQ5NEo5U0tlUmhYN2EzcXArV1RjRmxB?=
 =?utf-8?B?K1pXZ2x0YS9GWG9jcDMyK3ZrSlRuQVBpemJKMzhHeGM1MzFweTZESFE1S2ht?=
 =?utf-8?B?THVXdithN2x2b3Y0Zzd0UHlnZFl5eWhtVzRVbERrMVI1U1huaUpBbEIzYTVz?=
 =?utf-8?B?L2lHeEpwUmhwdG9UbXdmYmhVSWpKSUZ6NDJsWDk2Mkk3NUNxUmhJaU9Hb3pB?=
 =?utf-8?B?NVdtVGdwZStTK2lPTUUzOWN6RDlJazArNkRpZEdTUWdURDZQQ2Jac3d3M1RD?=
 =?utf-8?B?OUpWOS9jdGRFNzNQNnpGVnVuM2RZdTJxdTdVbDZtUFd6Mm1BUkFWeUVKK2JC?=
 =?utf-8?Q?vcok5mgIalBZEXByp4ml8N+GsD5zUUhrM5INv02iBusys?=
X-MS-Exchange-AntiSpam-MessageData-1: lEum9/Jjd3THbA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948710e1-51f1-4a0f-2ef3-08deba4e7ebd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 11:12:23.1082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3YYV20oA+YlpP5a/BYua1M2ElTtRZi0d7/KNjLc044g8XFpPh4i6LJNzIXPsQ8cKhtcrO2Auh2dzAp0OzPo8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7485
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

On Mon May 25, 2026 at 8:10 PM JST, Alexandre Courbot wrote:
> On Fri May 22, 2026 at 8:34 AM JST, Danilo Krummrich wrote:
>> Convert pci::Bar<SIZE> to pci::Bar<'a, SIZE>, storing &'a Device<Bound>
>> to tie the BAR mapping lifetime to the device.
>>
>> iomap_region_sized() now returns Result<Bar<'a, SIZE>> directly instead
>> of impl PinInit<Devres<Bar<SIZE>>, Error>.
>
> A small sentence explaining why that change happens here could be
> helpful.

... or not - it's clear that the lifetime makes the Devres irrelevant.
But mentioning it explicitly can be helpful nonetheless.
