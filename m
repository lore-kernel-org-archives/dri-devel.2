Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC44ACD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 13:02:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30C5110ECC3;
	Tue, 19 May 2026 13:02:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="fKoe44Ei";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020127.outbound.protection.outlook.com [52.101.195.127])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FF3610ECD6
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 13:02:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuhN7Gm+jvRDEU+Kq80pgsPNCNxQlWPeTJXdTL78CMVEjm9dosMYw+4RVxRAoOXd5x0wgySqgNDqHE2IFvZ+hLW32hfW5HOoR6ckVqCtBGj2AJrDD/5KkqbOsiX7CNGF+ZnRvtEBpkV70n6i6d7ceI09WoST4Czfn1GbKutEUUsBDM3gZAnfg9CxIIHBLxoPcAkJlL8hV7due0EpFOxnrO3lpSkSesuSTUbWu3rrCPJrAyZjmI+WZvKEh9YsTsRZnSekkwkCG2Cc6JV3AHJZONh1JWrMrXcy2jFdej8xdzl6fzgoOuoe/b57zkUAtDdKxt3D4J3qBbhMF9UsnQNz3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wws0Na0lWOjG/Wo84uSKdZyNdkL8ic26+FvJCTFVQYg=;
 b=Pna7uJAwZsGr3WHFHYORoqYDpUVI5yDgHJrdZUqSp8F6PXeIJncnj4WEUIjHJB5DD7t6z0eLlYCNkCNrE297J4m656glb/I+n6BDo4OTWeP0TTNckbX5yDAUAQxRqYOP28AcaM5pN+FOywQGHCrLonRs0N/oWoA6QaIWn5XO+/67WYXbLlLZyh0IhhvZQLMKLXltFa4yGldPgcHRXvTNLCbV1WCzhzPBg1CYMgk8OR4S4f6koHtfRcNrwQ4BbDkVaWIeFjdFTzRn1lkzIgA2OJ0NratPhQxuN3H7/BwKuNgfh4c9vAsf+0mc5QwWtpeNFk3bYcBddjxUlXOeYa3spg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wws0Na0lWOjG/Wo84uSKdZyNdkL8ic26+FvJCTFVQYg=;
 b=fKoe44EiKVQhB/l3nSVGKaUxJ6w/MYaHXcIxFfdFKt1/PnlmH99VBdUeeac7zF2Rvp9B4dPSOCxVIcSsL1SJnSXnxV6pGIvTzQigjl6Ba7FzREULb7Bhm6ti2pT8OyFCyzcG1szyeqRPSjtYUmecuTsji4SV4USzweKnieyacws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2231.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:75::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 13:02:14 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 13:02:14 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 14:02:13 +0100
Message-Id: <DIMO907LZ8LW.1SE1NXXUIECMD@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 09/27] rust: device: implement Sync for Device<Bound>
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-10-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-10-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0064.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2231:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ace1a4-f38a-4b48-4bf1-08deb5a6d8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|7416014|376014|18002099003|22082099003|56012099003|921020|4143699003;
X-Microsoft-Antispam-Message-Info: Dn+O+7DQtVLhjTsuggeV7Y+0jWxQcezjsamWpl+AX5BYlzTAeZZ2gvXCPQJHI1v+Ic706GQ8w2EE26L7HEunR+DWLaH6j/FMhjVFXuo9GGz2YUiv20eUEpUZZh0Y/WfYaTZKj/UJWkfeVJEjPJL5N+xP3EU9fKkZooJaXI8jQTypdMdpmhkCa+rcdd94kfJkYklGCw2u2pbRRxJZheS93k6U0hSwN+KhqBAf4g10+M/l3TlldM3P2iVZ7B88k41Mb01PEfayb2c7xx5V0KNETy9OURlZRGHdEKjIqzkVm0snJFw5ARd8hhjwpKrgd9lH5TIGQR3N+BjthZ8kyYNbg0OFH+x3Qy66Z5lFPI/eTMW49e9DFpgvZnDfvBsWhk9ff/O6ilhwDGl5Qz2XMi1sBJs5ksLip6xf36jUY7BZIaNUtsWummDQ2N+jLGOFgaIXP2frSgbSQY5zX3U2ZxyKvJzWFC9F4zgpZRf3UIWhRJLY9mLPNetkFk7pxV1Hk82tVBYRQv1hVOa4uyUKmgaqM4orthO45CJBp6MqZ9ZHxeXNLJ+hm2aHspS1vF8Yq+rERg+qoQOVFEb2Kh0K2dax64DYDcNbU52o4FcfjgRHkFmJhAfNdAaB9qi/W+tw5+uS0dbkcFr1Y+FTlOceqRfjwCwsMFi0bmUjHJZDSgnaPa+YrIXAfBa/zODuLMqJvzGSw1HiyjnJBEswAg+yRWUwtFJP+EQcz0KjzsY32zLdFp8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003)(921020)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekU2UXBzVDg2MGc2SkhYOVAxRytKQTVpOEVRUlhlTFBEUytiUmtLK3RkeUlY?=
 =?utf-8?B?NElsaTd5d3ZteXRoQ000UWI2MnRMNTJLZmUxZm9BaEFUWll3eUJFMGdDZTcz?=
 =?utf-8?B?aitNT0RwTDl2Ymw5TzhXM0UzbFcySTkxaXFSclpFN0JEbEE1U21IL2ZabTAx?=
 =?utf-8?B?SjgvZEF0bEVhcmhQdzc1ZHVYWDJhT0cvbWVlZ1YwOWozNjdRT3VZSzdpa1hH?=
 =?utf-8?B?TzhRc2ttUmFLNHdjMi9HQTVDQjdnM3M5amZkWnBUbGVPQU9vTlZhY3FySGVO?=
 =?utf-8?B?Z2NaZWM2enRoYlQ3dThNUHY3ZFd4dUR5OXhva1kwZ3RnbUxUeGJDZVpSV1Q1?=
 =?utf-8?B?NzVZTnd6TDMvRnErbHBBc3RYbW90RG1lYzBiaTFMY2pWZ2JiQjEwandITzFX?=
 =?utf-8?B?NGV5Z1JIU3pXZzJxTEJQSW1qMllNK3NjTVNJYnhmaTBycEFDUEY1SklpWTlu?=
 =?utf-8?B?N3ZOK3AvMEEvUDFCcGVRaFF5azRRREJhSGh1R0dUMWdCZ3NwQ1FvdGJZeTZC?=
 =?utf-8?B?RU1oTXRUVFZaRXpMSHV5MVowUW5jcE5xS2RycEo4WjZQZ0dwSXlVKzgzZWIw?=
 =?utf-8?B?NlZvcGlSaW1MVmdpOHNncmhKZGtSa0FKRjk5QWRxYlRPVGNzUHgvb2ZGOEsx?=
 =?utf-8?B?aTBkL2NtY3V0WTdhb2tFbHB4Z0RTWWgxS0hObGk4a3VQZHlseFNSYzRaMlNR?=
 =?utf-8?B?Q0RUczBjL004elZNcXY3ZGFteUwxVWJzeVMxNm82N1U4RUoyaDhoZlp5TDRC?=
 =?utf-8?B?SjE5dWF3UXlZL2tMeTE5L2J0TUNpYStuZFo2NGtGSlZYd0JES2dvK2M1MVBB?=
 =?utf-8?B?YTd5TktHVXZFZVNRM0E5c2JTMXJpRjNiQXFTWCs2dXI3U3gvMFhVWHpCNFBl?=
 =?utf-8?B?a2ZHdlRycFRYWlNTcSt5TzNqWTNUbE1zUVdJMFBNU3IrR20yd0JzSDd3aFBO?=
 =?utf-8?B?Nk1sM09mT0xFdnVlVWZxbm85Q3A3NmIxYm1HSGxCOEJtekx3Y3lVUHlNZGhh?=
 =?utf-8?B?SmRUdGJBd2VIYjFBMzQ0b0dqM2dUOURpK2syVUpGakVia1VSZkFvaUV1bllx?=
 =?utf-8?B?OGdualZraDlPaExscURQMlk0MGl5Nk1mVGFVUWlMZ3F5eEE2Vy9KKzlUdFk0?=
 =?utf-8?B?MnYzODVxd05sMmZ4SU1pWnpvSnpkejFZNktEeE41OTZBanRaYk9aOHR5eVVU?=
 =?utf-8?B?R3ZXZFREc2xieUg5ZW9tY0VINWsvYU1pdUlWUzhHZ3FVblFFK3hGU252Z0Ru?=
 =?utf-8?B?aWFzaFFLN2U5aXpXNzVzT2E3c0hIWVFmeDQ3SkFTTE5obk93akNFRTFnUU5s?=
 =?utf-8?B?dWhKV1BQM3lVWStZMm53bHJJYW1oMk9RczdQQUNYUDhuQXc3S0RuNVpSM29F?=
 =?utf-8?B?WDdCMHNZZC9IUkNyS01Fdit4ckFURGlHR2hzNkhMVjMxTm9KeFpqaEhaS3Ri?=
 =?utf-8?B?aWdoOFpZdUVvUUtPb1VlaTJoVStmOGpzT3p2VHRPVHQ4ZURZUlRINXFPdHpF?=
 =?utf-8?B?MzQvSWlaZ1NaeUtQZEZiSnJ3aitISzJ6VHcyUmdVcVM5Z0t5RngxTlgxN3Ru?=
 =?utf-8?B?alM2VmszVjdMWnJkVmg4b3dSdEJaWHBQYWlhN05EYlVsa2xiV2thMlpVNzNK?=
 =?utf-8?B?Q1hFMHhaamtUblBybDhFMS8rMmhUUlZ3WTJtUndLUHJLQzliVW5lZlcyTGZj?=
 =?utf-8?B?L2RGOVUrdFdPMEx6bFZOblNrNWk2ak8yaXptWiswY01Tc1orb0NQREVSZjlR?=
 =?utf-8?B?U3d5SXlFYS93UE1QVlNhMlMxbUZVK21Nc1pPTVlnZDN5U21uTWhvcFVIS1gr?=
 =?utf-8?B?N21MK0ozT2w0dlZJYXJ3cnJjdXBvcmZuNmdTeHRwT0I3T2piM3lsbXhhZGtY?=
 =?utf-8?B?K1Izd01nbXg2cTVDQmFmSjNsenltQmVpaXNVSW96Tm9CQkUwUTlPRnJNRDFN?=
 =?utf-8?B?cHRESWw1bmRrbWRpWnpyc2dYUzg0Wm5tUXRwZ0FhcTk3YnZBRHhGS1NPZmsv?=
 =?utf-8?B?M1poem96eEFIUCs5N2MvVlBza1lrMEVkeXlvYWN5b0NIYlFIZUhGWnoyc3dn?=
 =?utf-8?B?VEU1NDROenFkcCtLbXkvK1FxWENYbE9TTHVFT0J0R0NJMEdPTmVvNkd4OUtY?=
 =?utf-8?B?eXNKVHREUW9wMm5sbDE3eEVzNHpoOUV2dkphVDVwWmltbUpkdEFkWkZjaG5x?=
 =?utf-8?B?dzdDa3VnYXpKK1dXd0NJK3k4ZjBWb1IyV1VwNG5LdWcvZFpTY0w1TWg2aGYy?=
 =?utf-8?B?ZjJBemhiWUVBbnBsWktBS21yNFNUZXpUb2JwaDlxaVpIOFJSSzhwejBCTXkx?=
 =?utf-8?B?OVJxQ3BUU3BUMzRZVkdBOVJWUFBwd2hrMS9VajVsemsrR3ljUDZaUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ace1a4-f38a-4b48-4bf1-08deb5a6d8b1
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 13:02:13.9088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23im3WsSG3pQzw8BAwFytBuA6S64Xm65tL/fUqAU8l3s5vgg0n+EcrPt2DKlFbWIv9VONSosxoRNDF37KSsAIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2231
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

On Sun May 17, 2026 at 1:00 AM BST, Danilo Krummrich wrote:
> Implement Sync for Device<Bound> in addition to Device<Normal>.
>=20
> Device<Bound> uses the same underlying struct device as Device<Normal>;
> Bound is a zero-sized type-state marker that does not affect thread
> safety.
>=20
> This is needed for types that hold &'bound Device<Bound>, such as
> io::mem::IoMem, to be Send.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/device.rs | 4 ++++
>  1 file changed, 4 insertions(+)

