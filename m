Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FE3109878A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AA4210EAE1;
	Fri, 20 Mar 2026 14:45:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="n6xRL+pl";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53C7D10EB04
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 14:45:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAYLgf3h76xQcwv7uAFCIHEDTwxbhgPVGEylDzpiaSpPCufla+fWfK4kLS/hRb5aOnkOCnGEQMh/bfiazQ7F107ZfK8hPfq48HoG6fZ/Zik2JCv9BVZyn9Pu1SvpKqX9Dc9+Gzan1hwWUiMbSuZVEECe5co0plMVJppnqN3TTaGRTKUjOBYNkvPxGL1FLclqvxwozKb/XhH23fVzpElKfM+JcPtz0WphU2R2eXO9TTg29+l+LAVvPz4Glz3sYTAo1e0YAtunp5k5Om7bPFvIWv4eRPJSCTEhNWpaVGKJAk3I17ViVunc8xkTcPtv60jZmYAUIQQL129S12kWd6nvag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJoapkvBTaydBOv66JGkNqr7BO2LGqle35OfAR9sRbA=;
 b=XPF8Yb6NU2Wkv1/oVT7FUvNufewEEsoWFpHosWCqOqk/tR4YaXVY3Ar+87w27KuwRaEa46eEqJCxJ075sf6W7SFthad/dtCYICiHQpD86XNXm0g+A2GTr5pf8gQ+vcc7BGcb3SMVV3MpL/ZGifji5L6uA37oMWK8nEyPtjmbIygRlR+sVPWnIJ0iN4+DEV6NU6BiYg+q32dTwmpISiPUDm/obSVFZlghcCIvqXLbNZUIQ2TmVk/A0HHC9mY/TWDSf14Vs9k9saIjF8EkKVty3F24ZDvmShazqXDcz3pmJVFX9vtVzi3OBH28q50gN5F5e994yCjP4Zj2ojWjB0O0bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJoapkvBTaydBOv66JGkNqr7BO2LGqle35OfAR9sRbA=;
 b=n6xRL+plS9Ay0tZB9iWTUTeUluLf9/zw3SnKzfv937S0JChB/hyNzc8BBRm4kmiDhLUzOBbh8HQHrYrOoRO9He3aFu2EjEFG9BDT4lS1+zd9vPhM1RoTB/hKODL5pwX3W0DMjCUbO413naCiYSPoNuUG/dx6CfvHgcCSocIDMKg2W0P5W40l9MOKg5bp2bPkqvzFkGYGqBMjUi1cJ/TuPReJ1VnSk/E8V/thGGZzXEcZ4vLeHThV4wVEW57UyliKsQcMexVCY07ZK7/U/6hVRq+J8vtd7cmFZKc61cCje5fPIuQknXwOQXQX1NdqaWi1D+AWMz5woC24rsVk/jUCaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DSSPR12MB999237.namprd12.prod.outlook.com (2603:10b6:8:377::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.14; Fri, 20 Mar
 2026 14:45:49 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 14:45:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Mar 2026 23:45:45 +0900
Message-Id: <DH7OVL519XQK.28GPA9347W33F@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Zhi
 Wang" <zhiw@nvidia.com>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: gsp: add mutex locking to Cmdq
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260318-cmdq-locking-v5-0-18b37e3f9069@nvidia.com>
 <20260318-cmdq-locking-v5-5-18b37e3f9069@nvidia.com>
 <DH60IMOXP3O2.26EAXOW3BC7S4@nvidia.com>
 <DH60S91O053Z.1DDUJSL0D6NQQ@kernel.org>
In-Reply-To: <DH60S91O053Z.1DDUJSL0D6NQQ@kernel.org>
X-ClientProxiedBy: TYCP301CA0071.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DSSPR12MB999237:EE_
X-MS-Office365-Filtering-Correlation-Id: a3397bc3-ece1-498c-747f-08de868f600c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: rK8zWfOSh5rwukC0bGOyfLs+xPkD+mWx/pmbWO8DZnVj7azmTFlneaGWptiiI6kdwASS4zOFeGuoXBN5qhyEhd8fKXhrsOolfqYjfgkbSMGDKFEwktECx+WhguwPCkAc1p/GHCQZ6fxaO6VRaQh+FkfWh5wmhmAnl9N8dKtHB9D8Yaqx1JMqDAcGOVyX7VeeKblzMLlq7XmVqb6rfl+OWk50O19lIRH81mj8Qr3yKZRJ2Wu3J0db6xeaD4d/10QsZtEHQu3+H5uXGjnwTV5zGrgCw09t8Ti5FltWXLKiqBVzdvnaL28Od1brsnU03SittawN7xZYeGFj6ve+Uimy3tRS5KiGPj4oaRuwNSKG2Exq/Ufqe79axgOKUnEKTA9YNAwygX5pMKV4DLopI3UHs8QQ00En6gkvQgbej7GCSh5HfAiqgTNkdp8JtI8oHEURhsUwQXppu0AFwJh9I16IpFaQGVp8L2avDRmRAh7Osf+e8vVBaZ7qT5xuza/lYs5Wnw0YrNvnNhzb9euWHsC7pMNfSDeVxgZd9C3fsAxLMx09tjLtTHmke90B1IrXCk4ANhi4uza+r3+ZEC9089pKE2pT9eImnz0cOXPCnYRt/ZFjmXd+jHYxDXwkYlm72RGtttYQFK9UQge0/Bh/4zqlaZv0e0jClyikP1tCfxFLYgoZ2tIeH5rhbItKFAK/1jI3JMCcaswpnXTofN6cWuP1ydCqlFKnt9qESUZLUckPhes=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHVyaUdEQ2x2VTdEN29Lc2JVdXhMWUZRS2I1a0RpUURCYVFHVWRoYWczVEdm?=
 =?utf-8?B?MldXZm40UDB6dkVQRmFFVFhoWnFpVkdVdlZGZG4vRU5Sd0YrL2IvTEdNZnhx?=
 =?utf-8?B?ZGtVenU3Tyt6TmdJbExrV1Qzbi9lZnJDTVRQZk5ZY3J4WGVpbkp4Zkc2MHo0?=
 =?utf-8?B?aWlKYncybzJuazdabExBbFhWcXh0N0g5V2YrTXhhWEpkMnRBaVZSUWdRbGpr?=
 =?utf-8?B?UEQveVhpNzNiclB0RDBSS3J1OS9QTk44WGpsNW1rSVlQdTAxVHVJQnN5S0xm?=
 =?utf-8?B?L3RIY042NUxUWG9yazZ2MXp3ZTBwNHJuTDFUalJXV0lNbm5KaUNabnJvR2hC?=
 =?utf-8?B?R2hFdWxmYm1kYk01cis0RzZocGpxaDRWYW0wMWdndlNvNG9FaWhLRGptVTIy?=
 =?utf-8?B?Vm8yVEZ6NGVRZENrTFV1UlIwOUc1QjZkK2J3U01pdWM4S3ppTU44NlFabE8z?=
 =?utf-8?B?UXNoNmluRVp5S3pBK0RYRVc1Y0NHMUdqRWpUVWlETE02bUp3R0FIaDAwS1Zq?=
 =?utf-8?B?YUwraWlVeG54cEwxZUZGUUxsR3ZsWlpFckdkK0JzUW9Bc244L08rL1N2WWR6?=
 =?utf-8?B?UlVQVURodXNVc3hQYnBDL0QrdXc1VlAveUNhcUtKSWkxUnhoZS9vQlFJRjFu?=
 =?utf-8?B?amtXblhnQXYwaXJWRXMvRTZVOHI4eTZXTFRiZ2NQMlo4eWlnVElFMFREajlm?=
 =?utf-8?B?L2NoWXJkT2g0eEJ2WUhlSVZSWmlwRWZsNldKQTl1MUQrRTdhK1pGUy9GcDZX?=
 =?utf-8?B?M28yZE5iZUt4ZlF6WE10M2lZdFRqYldqcXJUU0pFbDg3YWJKWnhhbTE1MFJN?=
 =?utf-8?B?Q1R5NDh5bTc5RXRURjZ3eFUwZmJqWUdkeFJLMEV3WjhCanM2Z1pBSlpzY3c4?=
 =?utf-8?B?QkVLSTBvY0pHRzNKeDg0bVhxTTBJRFQ0dGhjYmMzbldpeGdFc3VzRjB2bnF0?=
 =?utf-8?B?SDVocnB1N3djV3NuVmVUeFRBc3dGajF0aFh4TjV6YTlmdi9rUHE5d1grdHV3?=
 =?utf-8?B?cmtiN0pselFUQTlZc1Q3OXhwWm9EVlNURjFScy9LVVJtejB4MnpDcG03Zjcx?=
 =?utf-8?B?RUdjQ1lNcVE1VzdxZWU4aStZY1hpczhsQUxjRm9RWjg5QWVYYUVpRWlmSTBM?=
 =?utf-8?B?RzVkN2VKSE5Mai8rNHlQRTlZQzNPZnJwLzZ1YjMxODFnT1FOM1N2SGVCMHlk?=
 =?utf-8?B?aW8rcFdJRUdQY3pwczQrakxDdTc0S0xlL28xY1o4cnRNWjhzZ2JhRk9UT3pj?=
 =?utf-8?B?V2ZEYXptbFNCdWJxK2xtT2ZBQzBmanJaMUgyRVNkcEhKSzhNY1VjQ3ZiblYv?=
 =?utf-8?B?TEJaaVJmRW9sbVJCekZETHFmRzVVR3gwMW1HUkxMQm5xb21FeTVmRVVvLzM5?=
 =?utf-8?B?Y1Q0aWNET1c3aWlQZjI2S090aG94NG03WXRHTy9UZG5qQlZLamJuNENPVkR5?=
 =?utf-8?B?SGxUaEhIbVQ0VlNIdjFLNkloRy9rVTdZTzBZL0ZGeDc2WkQ0ay9EYURpYnNu?=
 =?utf-8?B?M0xvOHhlMmppRG42V042TktUOEhrWDA3VlNSQ21FVERhQThvemczeVZTL0lu?=
 =?utf-8?B?LzhZNktEUWxkUUdzMnZONEtLZEFDaVNqa2hTZlk2Y2s0eHFDQU9DTmVTdnVm?=
 =?utf-8?B?a0orUFA0RDNUSlRQMzRTQjgrbGxBY3FpYjRBZnBiRFlBa3Z6cUp2L3BZM2hj?=
 =?utf-8?B?T0tMSFMzTzhFSXVFWk1FRVBWUEtYOXUxT0VEbWdvNjl4VFBLdmQyWksyWlBs?=
 =?utf-8?B?WXFzL0lhVWsyZEZzZk5iQUF3cTN4eHJsSDc3OTZKZjkzZzh0bVAwbDlWam5u?=
 =?utf-8?B?UnNMRE5WVmNpQ2ZPM1NpWHFraXlhbkoyQkFYV2w0eTlGVTBPNDM2NVFyMDZ1?=
 =?utf-8?B?QVAwTkVuQTVtUjlNclN1VUowaFNPaWZidmQySk0rY2ljM3N0VC83Qk9VdCsw?=
 =?utf-8?B?SlU2ODNMamJJMGtoYnk4bjlDV2paZ0p0bEJwcWJMOWdjdGhVS2tITk42OEsr?=
 =?utf-8?B?cGkwUDZUSUJUa3F3T3dvVVBNZ2V3QnNKaTdrYXVtSEpLR3RtZUwvdnVoOUxV?=
 =?utf-8?B?KzlnNWlvYXNqT0pEd2RzTml2WTBQd0tncXlITW5ZYU05NlhNc1JmVG1GVDQ0?=
 =?utf-8?B?VnI3QUc0Vk5IYnNCK1JxZWpweCtNK21pbHh6NTJJaHl0STNLWlc5UFArSE1v?=
 =?utf-8?B?OStRRmZYbWtyaWVMRXFpTzlQeEZmTDk0ejFoMmdJN2duNzkxWXFMUENOV0dO?=
 =?utf-8?B?S0pubmo4NmJWZnFVTjRNL0NNdHU1VTlzR3VDQVM4T3ZDZDJmVllMYXZNdFEv?=
 =?utf-8?B?SklaaTI5eUsxUGNDbndrUUVYSUtnYkZXY21mL2VVZXNrSVhWME9zZ2IxR21Q?=
 =?utf-8?Q?oo390/ZLFY/Ww3oAlfrh90/IDL9AJvbap4cZ3wOLOVA8K?=
X-MS-Exchange-AntiSpam-MessageData-1: PNW0nQwRMuoF+w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3397bc3-ece1-498c-747f-08de868f600c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:45:48.5427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mgyz1Ddz2MypepIE5DrA1AeTyDNQMcCC0TULlzFDBL8taK6dcu7pqbTu8pBg9Fqu1Cszwn67V5y2tH3qB/axfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999237
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

On Thu Mar 19, 2026 at 12:40 AM JST, Danilo Krummrich wrote:
> On Wed Mar 18, 2026 at 4:27 PM CET, Alexandre Courbot wrote:
>> On Wed Mar 18, 2026 at 1:07 PM JST, Eliot Courtney wrote:
>> <snip>
>>> +    /// Returns the DMA handle of the command queue's shared memory re=
gion.
>>> +    pub(crate) fn dma_handle(&self) -> DmaAddress {
>>> +        self.inner.lock().gsp_mem.0.dma_handle()
>>> +    }
>>
>> Just noticed that we now need to lock to get the DMA handle. It's
>> inconsequential in practice but a bit inelegant.
>>
>> Since the DMA handle never changes, and is only ever needed during
>> initialization, I think I will just insert a patch before this one that
>> adds a `pub(super) dma_handle` member to `Cmdq`. That way we only need
>> to obtain the handle at construction time and can get rid of this
>> method, which keeps the public API focused on message handling.
>>
>> No need to resend, I will apply this patch on top of mine and merge.
>
> It is a minor inconvinience, but it may indicate that dma::Coherent shoul=
d
> probaly support locking, i.e. you want to protect the data within the
> dma::Coherent allocation, not the dma::Coherent object itself.

Not quite sure I understand what you mean here - can you elaborate? This
sounds to me like you want to add a `Mutex` to every `dma::Coherent`, so
I am likely misunderstanding. :)
