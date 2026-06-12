Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7824CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 23:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADF2410E5D4;
	Fri, 12 Jun 2026 23:29:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ph4+Zeah";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FE8E10E5D4
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 23:29:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sreIktuJsDMwN3PHvBaaeRODen2zj/1YPnDzBQAQuAqphs4EN51dDgyFjZdHfwpDof57tk1rL2VMoyQP5ThBcNFs93u2lNOI68mA1Iwt3+a/w+GND/uBaMV/wH0Prg0B4hJkQfgtruycJUBL4cm/hjuxEWfnfvJLdiKO3S0yOg5POCl41x7v0XSAQX2i0tVUKKvTQXZkJ38AQ1viclbjukdacxYaK3xUMgsQPvvuHOEuUCJKnjC1rtrjo/6aePnEp97CQaXKB8wwrreEbXfzjU5HcEUZMLUcGARu2gRSaL59VRUM+2luyxEN8ssYhEirNunPeQ7mq+129qCA31FXhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQi2PVqSBpnE9v8c6PtHbDTwJKbVthBR4xayluPpv+Y=;
 b=sOBGamRvthp3wQyur2nK64qGRbdYpsi7dHxYEtS+0ELjixlIv+NUIKGvPczeM+JiOhOUQsecGkRjMHpayMk6mVCDVV0JrMMAa/6DzkGBZGqn213FMWVCu3i16yKgvL+naKAf7xZ6zizkcUAQ9tdO6745Uvn6yupwLu/ZhzL669Kl7axQ8jOKmEnHyZhTr0NW/jD0RQthXZXOf8alEIHZXhpC6PRCxsM7Pnq9HPJcmm5sO8JnkOiwno2h0QlwdvcV13aLa9Ify7okbH98K50PrIc7tvGz+j6cMBtBMcwQAljY5V6efYWErroNJ4IbLHUTiAw15PmDBF9FhrRV3zSsjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQi2PVqSBpnE9v8c6PtHbDTwJKbVthBR4xayluPpv+Y=;
 b=Ph4+ZeahG71+WZlb3X+mRso4WFQ19vBWMo4coB6MJZkZfXH4Y/60Oa09BOHc9fTSRLilvJcWYOh0kRwI7OUzkbdmEWGnFWKI9WdZtKuIdMF+Qn7r0CMjaapcv6Cqb+TSVxILVb8m9If/Vn4DeYxR1SLDKrQupmHMyMr5+Pr6Gkdt6TvVPy5zSUfYWqKxzgnv1N/6xqBc+ysDT+J8+GGMo9YjJvhqkrlpCmzT73T5tu+7I5ZByAxBKpz016HPT7Mg4Le0Y4qb32IJ4AkInpijUZH+osYKdVMhZ5eTDfAkk4SO00nCzi+55n+L4kyE3aVugIJht7MOljvEZEK4QcIYyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 23:28:59 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 23:28:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 13 Jun 2026 08:28:55 +0900
Message-Id: <DJ7GLX1CLDSR.1U7AKTLN63IA5@nvidia.com>
Subject: Re: [PATCH] gpu: nova-core: remove `#[allow(non_snake_case)]`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@kernel.org>
Cc: "Gary Guo" <gary@garyguo.net>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
References: <20260612123401.2684025-1-gary@kernel.org>
In-Reply-To: <20260612123401.2684025-1-gary@kernel.org>
X-ClientProxiedBy: TYCP301CA0043.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e9775f-fb68-4ef2-7413-08dec8da6163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|23010399003|7416014|376014|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: M0dqgxS2W6K/2jV5GccggeWxek+SYNplmFCKHBi/+dx5O/O6Id+Cqbd/y1WKmlfBAb9HpTRNEMOoM83ShgZJe0zLzZjQ5GOiNEokgoS4GLjSGy9ZP66bvdQe9GpToRgZqkLDIC3ADmlRKWm2vOQMIrJvE+MjJZ/AbjePOg6myJquoAqBzaDFfPCuEnxs5VnWIO30IRrX2cMg7EYG5o2aRbGGUuNzMS+IFlCr1hT8QSYEYqSPnvI+a162oczo21qrmnu+BEko0FbRH3nre7vLjDV+QOrVkEa296SO6VIPnLF7kYoFh6K3/FnZHUg6hQXQeVDaRL4ia9wVvuT9uGij1rGBy51SW/kt3/mO7CryXiRUmbLdZdh1zumiePtvWImbdN3vnr5oMHIGO4YhZnAyJ5rT15BnjP3D+fAWndOJQ85PCWPSPaM+XMRnQw9hDxj2x/FTVor9TS9cs6RzeoaImZ6FNxDneAYYUIudsQbvMCIPAV06ITboSRLcBYDvbG/SbOccr/H37XjroXjciFAH1PmH5lAqf8D867VGKKWhC/K/mwGRGRS2EwmW80XkKnXiH286M11TwJdI9KjEzjPhnMqB3E001delzKoXsrr5UwSxJwAZ4sdR16g7NGsyCBdKcYE4Q7aegVRDafFH6TWAPiaN8FnKJDWtW1A0SFHq5auRibAU7kO2ieYEe2/Q1SXS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(23010399003)(7416014)(376014)(366016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3pPaWtpN1JFOHJMbHFSb3lGaDgxVmlyNDE4T1NZUXI0WHBuSk5iK05jNzky?=
 =?utf-8?B?Z3NBVk1PdUZrMGxIVXk5VTdRck50bU1zS1crZjdmblZiWjQ0dVBqU2JPWFZY?=
 =?utf-8?B?NjBsSGhhNUJ1bkpnU0N3N3ROS2lzVUJNQTluWGkyd1JJL1RtSW9wNnlaM0RY?=
 =?utf-8?B?cFY2WUxJT3dUSlM1eTN3eU5Rc09QZTZCMGFVUWdwdm1RRjdITEh1cHJGc1cr?=
 =?utf-8?B?bnI2WU5oUFRFOGpCdk1MQUhQZkh4VEpYMmpndHRnSzJwZGVOcVBtekNydkl0?=
 =?utf-8?B?ZU9HMlV3QURUNFhSTkh2Q3QvTkp1NHQ3Wm5nZHcvdWI2OE5QQWZLcWMvTkhj?=
 =?utf-8?B?dktVNWpsZUVTTXBjZEFzSUJWVUJtZVpxdStoRTJVaHo1TzRDaGQzY2d1YUtJ?=
 =?utf-8?B?d0doc3k5dnpRSGs5Mi9TbHhYMytNblpqcmdGVFZKa0MzN3l4dnhTZ2NRUzRl?=
 =?utf-8?B?MUs3WWtuSGZQM2ppaFRXQWxRTnZpYXh6VXdtWFdUOTJVS2h6M0xoMC80ZDZV?=
 =?utf-8?B?ZkdCcE5vZytPbzFsK2NpaEgxOUdiM0RBSHp3Z0ZqODNvamZOdUwxSWNYWERy?=
 =?utf-8?B?ZEUyVitJS2QzMWt0dXZCVEIxMHR1TGJrNnBNdittOERTMkZhWFBNd281eTky?=
 =?utf-8?B?Tk9GSVI4Qlc4MFVpSUtOeUZnLzI2M1RZNHYwbDc3RjBkQU5JOFYxdUgwSUZF?=
 =?utf-8?B?T3NwWnY3NUdPUFFjWERmYzg3ZUpnZTFFZ21CSWFUeWVIVS9NWmg4WnNTUmU4?=
 =?utf-8?B?TlJVRmVubkRlcXJucTR0RUNFUEg4bEphMXpDbXdqZkJsMGFsMllMZ2JNL1pE?=
 =?utf-8?B?Q3J1M05YY1BDRGRmdytHYXRyYzFzTzJNVm95dldWS0piZURLSldLbm9EWjAw?=
 =?utf-8?B?MW1oRi9BUjhOVXBnUFZ2bkZkSVZwVThzUk1Vb0JsWHFxYUFGWEZpK2xnb0tM?=
 =?utf-8?B?cFRjOUhINWZzZ0h6eWtCVG12VW1MdEoxS2RyM1RzR3lSMG9TWUVQVlYyUE9K?=
 =?utf-8?B?TFFLWStYVVVIZ2VHeFBxUU1oSXZEY1dHb0FKSjU4SEpSSmJuOFJWamwxYm00?=
 =?utf-8?B?TGI3bmFPZEJRbHpxVXN4cU1LS051czFGL0I2bjVZcjBFNm9vZDV0akZPanVa?=
 =?utf-8?B?T2J0Y0NlNWU1NmFpR2VhQWdyNFZQQkQ5TUZLVzhFUHczZ3pybG9zM0pVQ05W?=
 =?utf-8?B?enZDUkMrN3JvbWNFVWVkeUtzUzdvSkZ1SDUveHFuSFVsWDdoaCsraERBelR3?=
 =?utf-8?B?RjZydDVXV3pEdDF5aFM0NTdDNGZTWGRmVTdXVFhFdzBpekVicEsyRHpiWjBm?=
 =?utf-8?B?MklIZFl1VFRmWnJUUnBPNUc3ck9mMHByN21sUTNoNS9IdmxDZDVqcnl1d2lm?=
 =?utf-8?B?MzRSb0ZSZm5TVkdNcVFjdEJPUUltUTY0K216Vm42MVB3WDU0UWhvbXVDc25w?=
 =?utf-8?B?QWR0dWkwZnJQR1VKUmVRcTVGL1JKc2p4bWJTc3lpaVRLUGtMeXBlQ0czNUN5?=
 =?utf-8?B?ODhzbkJKdDNwZFNWcmkrQUM2Vi96SW1jRmJXZWFDTDlOeW0zajhMRFF3VUxL?=
 =?utf-8?B?U1J1dm5BNmkzTmNEeFFLUEllNVIyT0M2N09Nd1ljV0U0MHljd1M1Z296TDJV?=
 =?utf-8?B?UFYxMG55Y3ovOSs4bmJvZDdZbHBLc0pMeTA3cHdrVjdtQzZLbGFJeUJtcU04?=
 =?utf-8?B?Vk9GWEp6UmwvMjhGRERHY2NZL1lPQ0tndE9QTERYdytWR2wzSkNIaUVTYlJU?=
 =?utf-8?B?aEtoQVR3cmNzSTErL2ZRSWxxVlZPYi9NakZpOXVrd29LRnlMVTdROHcxOE95?=
 =?utf-8?B?dG1xeUczbGJxSG1UTEM5dFFxdmlYRmFxOVcvUWNxems3T1lCU3VnenN5TW55?=
 =?utf-8?B?L3hkak1KZlJJWm1FRVE0ZVE3Qk1VVnJWVjJjNFd4dEEvT2pVNC9ReDFyZmV4?=
 =?utf-8?B?WTQrcjNHVDQ2VGRMbkdDUlFoNFlubFgwOUczTnZqemo2dUJ3TXdUZkhjRmxU?=
 =?utf-8?B?d1RjYTc5amI3N2VvYitWWHVZT2dJZFB4MmtZRURaZFM4TW9IT21RYmk2d0FX?=
 =?utf-8?B?R21yQks3TlBHUy96bE1xWDlWMEJNM0luVFdLNUJGTHNlbmh3UUlIcnJWZmFl?=
 =?utf-8?B?R0wzSUlEUkE2QVRKNDVGVjlmeFQzR2ErRlYzSkRITCs2M25uTnhhd0xSMGlz?=
 =?utf-8?B?NVBoaHRmSGtBNDFrVTEycCtNMHREbzV5emx6aGhUckpZcThOQlRSeHVXZzhN?=
 =?utf-8?B?eng0bEk1UjQybW9LWXlYdXh0MkJHa2ZyWFhUalAwTksrOWJXUEhOTDhmRWJ1?=
 =?utf-8?B?Y2ZZdnYrckF5UldKaytCL1NVbnFXV1RwdWZuVlJ1UUh2V0FVQ2ZvTFZUalh1?=
 =?utf-8?Q?lbfs9wEdAAAliGmteGbo2o9Ah7/sBp6xqvmi0vBBSA+kU?=
X-MS-Exchange-AntiSpam-MessageData-1: 9aEJryasmOOF+g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e9775f-fb68-4ef2-7413-08dec8da6163
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 23:28:59.7017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTieg7F6xTa9elRd2gY2Ovo6qJ69eiwo6BRW6afNbL7mxfo1XhX3M9NcOhpPBpessqkMKYM6yu8pJB045aABdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430
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

On Fri Jun 12, 2026 at 9:34 PM JST, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
>
> Since commit 5423ef9d4db8 ("rust: pin-init: internal: suppress
> `non_snake_case` lint in `[pin_]init!`"), mere use of the non-snake-case
> identifiers would not cause the warning to be generated. Thus remove thes=
e
> allows.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Acked-by: Alexandre Courbot <acourbot@nvidia.com>
