Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838DBC4451B
	for <dri-devel@archiver.kernel.org>; Sun, 19 Jul 2026 20:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88F7110E07A;
	Sun, 19 Jul 2026 20:54:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="U2gK/VOs";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022141.outbound.protection.outlook.com [52.101.101.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE9FF10E07A
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 20:54:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wknGdTyUtU3c0kpefjh8gUk2tAVt8Wbdlv9gFAm3vt/kx5kvWN9jWcvNpzXJyLb/AXqVYcvDIg9v+ojyphybtryw4M/ze6je0jXSRtM1X0KBGC5G5iUt5E/rXJzLi14Y4ZZBKRutAKQbH0kvAGjbKVawHhgZZZiHWIvZ5DEEuPXf6DP6gB6ZnOnb2ZQ69MjS3afPNMP0ZuPl8HYNYGhiCdLrvBysp0wU3yDz5+9bKmP7DTzy4c1MBSvCWr6ATt573kD+OLGSqQvAAAeLRyn+TVQjkixS8mQx2QYrBEhHZKADXKblOdP8Dtuf1K3ca/YCFZn8hR1g6czisivIPhTeGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYyHU8c5joNEUFLXt1lHcrmkZlaV1jPk2DbZNAEQhSE=;
 b=ExQm35JBwFN2h2GH7qL65LRFg6fMuYRej9/rYx4icE399LMgeAGwAM04oCsQTi6n920FZ8qBnbYqymJNqMJihloTK8dgeoXzBf8KVpX4Ivu383Y8Rbkg8xYjPKUnzAEMxQGPRZXuvbr4i1hLgrEEFZZe4xyuTgqXzX52KZeYlHwsxHhFylQ8btpbauhexXP4nLSy6Eb15mH18ZW/LxPGZHC6u6nn1Awrcj7pzcNn6OIeYTn6/+tKZ273UrkotlhV3x7NoFd+Foh5i08/UA7w8wQo4v/wxAJ4bLqgwuR2fo6CSYwjU3XshqrQKiUgg1XhchisacolOXnRV65yJDWPWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYyHU8c5joNEUFLXt1lHcrmkZlaV1jPk2DbZNAEQhSE=;
 b=U2gK/VOsNhHg8hL61Qy1XQv13r6UMnB444x2Aczyr2YvdhTbjlEcCx8c/do0NTtBZMZyZMUfa1V5U/3R5WB5yBoCNOQEhwaw8Rj6FheN9rzU18jw7q+j9RI3gvg4KwbN4D/HeOxzc2HyHDhd1OYQvxovmUUjLK04D6/0OS6PD7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB8634.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Sun, 19 Jul
 2026 20:53:57 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0223.015; Sun, 19 Jul 2026
 20:53:57 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 19 Jul 2026 21:53:56 +0100
Message-Id: <DK2UHF0JHVJW.39W4VPL8H5CM8@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Tamir Duberstein" <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, "Robin
 Murphy" <robin.murphy@arm.com>, "John Hubbard" <jhubbard@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <nova-gpu@lists.linux.dev>
Subject: Re: [PATCH] rust: io: convert ResourceSize into a transparent newtype
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Lorenzo Delgado" <lnsdev@proton.me>
X-Mailer: aerc 0.21.0
References: <20260712113602.389060-1-lnsdev@proton.me>
 <DK0BPAHR8IS3.2KLSLH7K448RJ@kernel.org>
 <20260719104012.364283-1-lnsdev@proton.me>
 <DK2MT37NYCTQ.3JCJ9EAQ9TJEE@kernel.org>
In-Reply-To: <DK2MT37NYCTQ.3JCJ9EAQ9TJEE@kernel.org>
X-ClientProxiedBy: LO3P123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB8634:EE_
X-MS-Office365-Filtering-Correlation-Id: 1937ae5f-1f50-4bd8-1d37-08dee5d7da27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|10070799003|22082099003|18002099003|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: ruO0APhMqNqaoO1HI9dBeKsb1gwcIAqlxruYq3mZ06fDPn0Bj6ANyyfpE0GK7U5hoppOJL8LiFJfx4pWRRpp3ETFzXsqHciA+DgJFo+mRhzc4m1BO1Bx4oI/U4+4k/JJ1WJRBy2Tb48e5YXkoB2Qafr4qcSrh3ZBtl76nC/YRiTSlJw6/DDr0yKODzPKSPTynczg482XGaa7IxsnWpjp660rHntNPVR762W77Ft1D/vG/IN3R5iQZyl+el/JRMJXTdZOrKsLUPEmlSChJJQrypozKU1yYjQ5uOPmcTLIBbScD8MzgQtixTVajeaaTzQAkjuxDcmNSRwwMlfzH0+XLoACW0fc4bGEffssKg6m5MSR/7qoqqpI4s0sllYU3vdQKUndXyRs4k5E2ZYPNV2Zp7AxLtPS00k+fknitasQXG3KXeuL+xpk5bQrqe2qEOauMCB2/i9pySS/to/FJjcd4RN03HIrtdM+GibO90vNECMHzG5mQWKsap/PRIzTmmzHqab91nfZkpP2+HHUuT68BdQpVBVsQ5PG3gIcPpkP/KP+gHyjNyBTaRmMAX1skT/1SpQgsUipiLoYUT8NkLLklCKJe7JJrKLtB0eiRoEzVnyBFYvHxtiX9KDK1jwPFTWnhkAs+AXBAvzvZGF1DWtxjcOfSw0XrKhvEADZSvwUS9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10070799003)(22082099003)(18002099003)(56012099006)(10067099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE1ZdGcycFcxRm10azVkOHZBK0xqeHdMTHYwMFYwT2c1ZEVYNGdHRTJqMVRK?=
 =?utf-8?B?SjdaSjdnZi8rcFlVMi8vcU4wcXZZRFFFZnR4OGVIV0IvMGtSR1Nka2RtWDZm?=
 =?utf-8?B?V1VZbDEvaW5Sc0xOWDZDem83K0JhTSszbndLbFhjTlBvVVRvcTFUTUZkYmtG?=
 =?utf-8?B?NHNtUVd5ZkNEQTdxOTNDR1BsNURJazBZb3BTalNmNHBKQ1pINnhmMkFDRnBm?=
 =?utf-8?B?L0ZHWVJ3eE0yRWNaNW4xOE1xVy8xTVRBVnU3eXlRN2ZiSXBiN0xOQ1A1T1Fx?=
 =?utf-8?B?WGVDTWQ4MUVaLzlFeUFiRXo5b0N6M1h1ZXptY0tRZ1Bkb0FEa3R0OUlIUkVM?=
 =?utf-8?B?NXRIYzRoOGVmOU1kR0k4RXhvelhFRzBramNJcjRlMTBFOWtwVWErL1YyRVpk?=
 =?utf-8?B?bHBKNzNYZksvWncrMEE2blRPUHFscCtVSlphTEZGdXREeGtiMGppM2VzMmJO?=
 =?utf-8?B?aThLTGk5a25jVkhpVjYwaitYQi90eVg0NTlidXBzNjZsRE5Vd1lDS0hrYmo3?=
 =?utf-8?B?VXVVSGpNdlRDc0VvTGY1V2lEdUpZbE1kaGdtY1lDOTNQczF0cDE1UEF1NkVE?=
 =?utf-8?B?a3pydUxvK0trOGZsN0FuN1FMNVMvTGhrMmRheG9iZGR0UGVmeVJIN0ZLdnRY?=
 =?utf-8?B?RkdudlZUM0IvTWMxeklrdWJaaksxYTNoL1dveHJDdzBWdXJUY3hRN3dpWTdR?=
 =?utf-8?B?ejRqRUxDUmRldXBtVlRhYytMMTA2QjdPaGFsY3N4TkFQa3o3Zm5zdWJHNWsx?=
 =?utf-8?B?WmphWmVFRDRkZWpBWEZ3a1E4bURaMzF2UFdkU0FMcVhIZ3k3WWpUclYxRXU3?=
 =?utf-8?B?NTlmcFRsUEp5Qnd2ay9Ua25PUkMvdDdyKzZYOElTYjJtQWJhTWNhcEdoNm9v?=
 =?utf-8?B?dTk2N25kZFU2Q1I5RkVjTTFsOGFXNTlaclRqa1Z5bFVkeEFPZVFUYUxjZVFa?=
 =?utf-8?B?RkRaeVBUUU1nTDZNQzBXbWQ3TnJYOEN2QTc5eElabE9QSFZLWkFjRWlGQlZJ?=
 =?utf-8?B?OXhMMkRZS1ZNd3pocVRXVlc2a094N3M3Vkt3UXVhOUV1emcySW1YK09CMlov?=
 =?utf-8?B?eXRsM1dySUQxa1VxUDM5eHkvbU5WSnZ3TythSklBc2VWQnRvdC9WRFVYbXNw?=
 =?utf-8?B?TmZQNE15SXBVdG5XQ0N0MVowcnBVMkV1ckgzNXk2cnVvSi94dEM0SzZNQnFU?=
 =?utf-8?B?bVBzOGJDUFI4ZTZQYmgwSUlQT2gxWHo5V3A2RVdjVklheW4zVGdkektNUlp0?=
 =?utf-8?B?VTZvUFlWbzVHLzBBckUzcnhIdC9ma2ZGc3NPWHA4RlROOThTK0paSEpGWXpV?=
 =?utf-8?B?UFZjZm1yUUNkWW1lMUp5cUl3c1cyV1FDTXYzcHRJajBWeUYxVnVCa3dFTGFK?=
 =?utf-8?B?bzR2R0JVTGZnWm9TRGp6eFRlTGg2VEEyYWZYbWNUc1JqRmlUUUszT2c0ek5V?=
 =?utf-8?B?NmVPUEZjbHNJVmMrczFJc2FoZ2Myd3hxQzg1Z3d2ODZ3LzcyTmk0aFZ0K0dn?=
 =?utf-8?B?d3pwYXUxcnkrc015UDFBd2MreU9OTXk5dFUyUWpPTGt0WHRkUTA2MGJuRDZy?=
 =?utf-8?B?WmlwKzIyblJQdmNYWXZHWjNRL25XQ3BOUzNhVzNMcnAzQmgxc2Jjell4VHM3?=
 =?utf-8?B?SVJrVngxUE1OSXQvb2tkQVRzZmJ4MlRlclB5NDl2Q2plMXFRNzErYlNlWHlD?=
 =?utf-8?B?UmFrVTZCREdHR0NNdEhPdHk2YVVVTGoyRUVMS2FwUzNKR2tUVkpySjFOTER6?=
 =?utf-8?B?cXJtOVVtMm9tbkJDUzdVNmVaWEJYeGlXYVQ5UUd6OEJmbnp5ODZNR0VXU3lj?=
 =?utf-8?B?cWN3dW9QdGRTU3YzU0tTb2dpODZyNGkyY2p0U0lzV05qSUR4V1kwbEN1b0xt?=
 =?utf-8?B?aEt5WnNzYWhMSTVCdW1nMHpMQWtCM1crdUwrUDVsQ0NGODJlMk0xOC95RjQ5?=
 =?utf-8?B?dTIwUURqM09iL2k2RS9Jd0dNeFdtVHhLTUkydExjbmxVYS9WbnZnbVdKQWIr?=
 =?utf-8?B?WVJqU2dhaXYvSVdPZ3hZNEJyS3dXemtHcnlhUDlsSGJrRWtTU0dHOTFpNEsy?=
 =?utf-8?B?anpBTk9wQm5EUTJBa1Y1NC83M3M4ZWdFLzdVWXpWM1ZNLzg0eFk2ZEhRWWl5?=
 =?utf-8?B?ZHc5cXRsZkttVzU2T0doWWRLSmx6ZHBaNkZXWllYeTdHMlYwR1V1RDVhZVlP?=
 =?utf-8?B?SjQzWVk0c29Va0VGcHVJamhuWkZUbk5rZk5sNy9sM0tvVzVqSFZPNXVmLzlI?=
 =?utf-8?B?a3ZRM1JRR2NuRHJaTnRIaUl0ZFJBaEVNa0dkTTdRWjZXWUJPL0tnWEg3Q0Ju?=
 =?utf-8?B?Y2twODV6UG1hQitKckF0T3JaeHM5YTBxQi9RN0RHSjRZblhTNXRFUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1937ae5f-1f50-4bd8-1d37-08dee5d7da27
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 20:53:57.4679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crAksFfM+nUifen50LwwiHaADWI7bxd2VS6R0oAbZYczjLpIzwgmIU1h/7psEVfe7WNw7cFZSjY2bmk0iH04Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8634
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

On Sun Jul 19, 2026 at 3:53 PM BST, Danilo Krummrich wrote:
> On Sun Jul 19, 2026 at 12:40 PM CEST, Lorenzo Delgado wrote:
>> I tried that, but it doesn't build. ResourceSize wraps resource_size_t,
>> which is u64 on 64-bit (CONFIG_PHYS_ADDR_T_64BIT), so the impl the patch
>> already has,
>>
>>     impl From<ResourceSize> for bindings::resource_size_t
>>
>> is already From<ResourceSize> for u64 there, and a second one conflicts:
>>
>>     error[E0119]: conflicting implementations of trait
>>                   `From<ResourceSize>` for type `u64`
>
> Sure, but in the case a cfg-gate is perfectly fine, as the impl will alwa=
ys be
> availble.  Either through impl for u64 directly or through impl for
> bindings::resource_size_t.

Given that `resource_size_t` is either u32 or u64 depending on cfg, essenti=
ally
`From<ResourceSize> for bindings::resource_size_t` has cfg-gating. So basic=
ally
we always unconditionally have u64 impl, and for `!CONFIG_PHYS_ADDR_T_64BIT=
` we
have a condition u32 impl.

Best,
Gary
