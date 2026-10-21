Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70EC606A31F
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 02:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FoXD2s5O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5556710E20D;
	Wed, 21 Oct 2026 02:58:15 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBF4E10E20D;
 Wed, 21 Oct 2026 02:58:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2LobR6wJnQ8Drqb6Y9tngkGDd87wUsy8VZN3xGf9wdqpiipI9ZJ8svYJYOABfDQWpFXPOXwHuT1W5mh1vLAOTWmJUP3kxt8uDOEWlMdGd7EwGme9e2UZTW5oT9fwinUSBrbcNiZCh8W4ehDZmmCIW5i9ygVZsw9P6dfgU2/4bzFaP/QuDaCbhQEogtXb3mmNJsExYrK9LkvB7wbKBHrSVMQCtooMZKj4SsIIoTMfsyjAFp+NE1oDPZ2IMQHscfm6Ep33dbEs2/N4zr53m+2Hdjh/uPK3CXia4PdSm2Rsz9VgqhxLAFx1hGv+jsjNizsc8XLsVkIZ2HCBb503o5mug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMe6iPw09X8BBNWrQSytP27VQmOwrWaqqVPVEB4W2SA=;
 b=fWeMYArPIl0BtjJtc0gCEHODKF4Q9OrcqyhxqUXONws/zM5sPjQQBpU8kez/IwgyCNlBA8otkXaMA0MqNB2K8sDbSqPQ/P1U/lxf37l6hqBJcYRbVOWcN26eJnoPuyxYfqFJlJip8ZnYn5JhIpO+e2PVc1iGRGQ48oRNiEEvKWfVJZrj4NBjlnrepRotvVdlhkISK3hYWdlUabkkaKlGy/JGBAWKF5fCjAYmYdZFTJ1el1pNFmUEwjtdcUebsGkHheEvPl/yBvG82ZqMNRvn5jz27urGKOjpY3q9w9aGL5uMhHkXjPAxTYshaBtXDIae4Y1eT4dmKvlpV9HmxxPirA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMe6iPw09X8BBNWrQSytP27VQmOwrWaqqVPVEB4W2SA=;
 b=FoXD2s5OIct3UYiDnVfgsa8MxaF1wLyTVbfZIHcVfVXMT8AREeOTUHG7eZopHdq+NhhAP6wA2kKIv7eLPcOFo1GXYT85/5ojRHEnKVyaJyNNKghku90RVo7g1uBgYdg77eOR/3cFbAoez5ZAWNntvJGFsykD6nD0X9t4kcTqz05b0eRyTCdUtl9GEpIfTGoLzuxYwnYbBzEV4nlxYPsLYjITSiWMoQCl1G1ooKUX+SKB84t+52nG7mP1QHbXRC6MqwP6k+Oo649fUMKACF5SLtnj/g9+lqY3Z15YE0kRUv28QUNFpK1bbyJrtMrEYUf6zwhuFIla/sIS/xXvA9LBGQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH7PR12MB7456.namprd12.prod.outlook.com (2603:10b6:510:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:58:04 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 02:58:03 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 11:57:57 +0900
Message-Id: <DMA6GSC7REE4.1OL8XYR8JKJ3C@nvidia.com>
Subject: Re: [PATCH v5 11/14] gpu: nova-core: gsp: cmdq: use consume_element
 to implement drain
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, <sashiko-bot@kernel.org>
Cc: <sashiko-reviews@lists.linux.dev>, "John Hubbard" <jhubbard@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <ojeda@kernel.org>, "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
 <20261020-cmdq-rpc-v5-11-dceeb8f360ec@nvidia.com>
 <sashiko-outbox-178822@kernel.org> <DM9QI47QSJ0L.2QMRVD4AP5WIV@nvidia.com>
In-Reply-To: <DM9QI47QSJ0L.2QMRVD4AP5WIV@nvidia.com>
X-ClientProxiedBy: PAZP264CA0018.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:21::23) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH7PR12MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 8272a31f-8bfd-495c-6ffe-08df2f1f1fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|7416014|376014|366016|23010399003|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9mgQUh9I8RZFU71HQz8qaa7BFj1vsJnYU/QGMrw/sqgqGoESqRxfpnN9mM+m1/ZJZo8PWildA1bku+Dphn7E3KlyPMciLiyLiETTmRDaKcVMGyzsNEE7uyzb+QMvaevk9DV6bP7XiWbvWurlg7JytokK7SpRtbmCAGYmINa/TkO6b9puIfSPPgPz4zLPma7qQXAvBtXhDcy+tETjf3pB2MbWfRpsnWxlF/DGC4IqkZ55ZViShXNceMGQzT5CHGiO5sD/Z5QNNps+uHfQdVEfx3mq0HS93azBKPFp1MBDmm6CL2glspQt1STRezOMF33EOEpkf4Zx6KYh/d7WczER5k4tWfR9OZU45UXzvxETLhdtikWLL2VwfdaVRwp0vF/+RRSoJP1qGs5KX5e2NKmb7WYVbuhoMc5BNKwtzTJKIAF7x9X2t9Sk6aENFhlK8UhLm3Zor7e4PNww0l1pvNAweyNqdAbdCQn7ZP1ZB831ow7afEDnMbH62PwyaaKCOCyCzdZQXga/pGuAPFH9Ul1PjXMiIAji3zAGLiOJNAOdSX+dJXqlZsrwRXIhkNnblXLJ2pGLyh7nPSV3A7ZhMt+01nwwEeaCbVgxzxhMs3unuuC5mARkY9CeRfkYb3MOrnqChpVvtYjKN4XUYvWnxFoZjd3oitAQTvjOPspgovGq1qU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3lHL0M1RjFqTjRpN1lRVmxGQSs1dURlRGNDRmtranhBZEx5eDFNQkY3N1hN?=
 =?utf-8?B?aU5mWFV2d0ZLMGxRK0FvVDFSRzdxeWZJRDZ5WU0yWEJXNFhPS014WEJad1Ju?=
 =?utf-8?B?RTM2cEZ1TFV3b2psS2ZqVjY5dnFPaUxkQU56dUJUNVVZWTJPdWdIb0F3OTRP?=
 =?utf-8?B?Ulc2RUVWRFhWaDNGa25RN0NMZVl4alc1SW5FZjFDOXo3N2Q1MlJ3UXhXdng0?=
 =?utf-8?B?aGZzczQ1cFUwK2NiWkRnZEdhc1F2NlRCUVJzazc0Nm94M3RHVW5xZWd4RGlx?=
 =?utf-8?B?QllLY2Uwc28zdjJ2L3FuLzU5WFR2QnQvd0svcktOS2xTeE9LKzlOUk41U29H?=
 =?utf-8?B?UmtENUhhYU8rVmo3cWYrVWZLZ1VoMi9VdlZBeS80WUI0TDVaVTBKbGNHa2ly?=
 =?utf-8?B?QlBlUjNRcE8xQ1lmREgwVWZOWmdjTjFqajZOYWJ1bUg1aWVXelZjZDA3Qk1F?=
 =?utf-8?B?YzJ2OEVZRU1wZlAzeGtJWnU4ZTR1YVhvTnRROHFhSzkyYXF2ZUp6OG9UVTJq?=
 =?utf-8?B?T2cvREtNaVVWZk15bGJ2YWFta2VKeVB5SnV5ZDlhOWRRaW9BSWtLMEVMaUtV?=
 =?utf-8?B?N21hNExRbnVHakdtNnJKSUtEak5pSnByNnVFbm1UaXFrYlBkTEtMOXI4SGJm?=
 =?utf-8?B?ZHVHZk80OVNHMTJ6YmZ5V3prS1hIWWcvb1crczVyOHlzRTNIemFya2l3Wis1?=
 =?utf-8?B?ZHRTbW1Ta05YN254Yk9XNU5LQXNQTFVNaTNSTHI0VWY5Umkzb3plSWxGK3Zs?=
 =?utf-8?B?eTBTMUVFdkE5aitoMWJaK0dEN0QrVjBhYmdoa3RxVEl5bDhXbzMzWjRZSXBM?=
 =?utf-8?B?L2JFTk9pV0p0eHNxUFBDbWovT2ovY25PTldzY0VsVjJtcTRxU0Q4SjJhUEV1?=
 =?utf-8?B?NEVFbUpBSDNkNjkwVk9NS2V2SEhDTDczUjZPK1BLRFRZWVdBa0ZPa2twa0lo?=
 =?utf-8?B?WVFyMW92Z0xwM0tOWU5ubGVoSktiUEdDUWcyQ3ZVT2JvSmxGZ1NJVHhjZmhS?=
 =?utf-8?B?YjIzWHRoQ1B1ZjE2OUt0cXMxbzZLRUJSRlpSNk5peW5KSjdrMnNrdzVIMG1Y?=
 =?utf-8?B?cmxocDRiUjZxeCtZZHRMQ2NZUEhiSjdseUVraHdqbzdoZkNEWkhhK2JienBI?=
 =?utf-8?B?bTFmTS9sOXFaeWFicktIci8xSkJsQXEyYUdFYXR0bFZuRmN4UVlxbTF1UmRM?=
 =?utf-8?B?UVlzTG96UUZCM1ZyM01sUlhoSVdpeFhpcXpUb3VYUFJnUm50UStnUlN5M2dq?=
 =?utf-8?B?TmppZDV6LzhwbWVhREZJZGxnek5LZ1ZBVzR4eXU3M1NxRmZWOHhRcUFFQmJh?=
 =?utf-8?B?ZnlRbmFUUGZyVkwvSGU3WnZxc2J1bG9sOUpKaHcveDZYdkdSSnJtdVlzbXE2?=
 =?utf-8?B?WlFrb2d3bTBGMW43cnRMQTN2UEkraExiOGl5RGdsY1lKZDJPb3psdzYzaWwy?=
 =?utf-8?B?UWc0TWdZT2tsOGkzRXE1RDg3NytSY09tR0JWVmRpVGxMNjJ2N254ZlB5cXp4?=
 =?utf-8?B?K1c4VzFNbGVhQm14MExTdld1VGRodXYwTVVFemVrRmlEQmdMNmJncTFnLy8v?=
 =?utf-8?B?eHIwMVBkQmtpRHdmRFNRQVEydyt0UnV0WGlWY2JITTcyM0czOElOZndxSTZu?=
 =?utf-8?B?dUFGMEFPSEpVMW9SRWtLdWR6TGlQODgzTE41aDJMbVhuakV2VUVWRWVSK3FC?=
 =?utf-8?B?Ui9RTXh5R053R0RUYWROcG5DNzdRcTQ4d0E0VmM1S2dOYnhCaVFuc3NTZXZG?=
 =?utf-8?B?c2FRamp6OTNKeGxELzBzdkZIeWhQZFFxUmFnNTlJYTdtTGhoR005YmoyaGlV?=
 =?utf-8?B?dVNZNmdGQVFGcHU1K1lHQk9CVDNHeXJ2YURvTDZ3cVdRSk1sT2VkSzVFNzd0?=
 =?utf-8?B?ekdTWGxvcEQ0VDJCTFlDTlp5M21hdkdNV2d4RURsMXc2VGQrdS8wTStSUndC?=
 =?utf-8?B?Ull0QVdhSmNTT0IyNWxyN2pLM0hvelo3UmR3VHZBWG8yNXFoMnBMWk1JdHl4?=
 =?utf-8?B?a0ZQU2RLbVFKQ3I3MXU0eTJsS1VwS1RkSFgyZTYveHZvYUFZOVM2TWRrYWNX?=
 =?utf-8?B?UXBuaUpGVE9tdW83S3FKZE1ldnNaN1V6ZGM5Y05RUkk5NmQ5NHZ3Qmh5WWkz?=
 =?utf-8?B?Z2JZYmY4ZWFDcmE5SnlNYlpzcGZ6cW9kRFNuVGluRW14cFlKWUUrSldGYXQv?=
 =?utf-8?B?RGhJbXNZSkZQR3RGY1FYR2lIZk9xY1RRTkVvbXNWNklsdzJtUVlWVXozNGc5?=
 =?utf-8?B?eGtHbkdoNUd0cHpvMnFkOWN1eDRKQ0J4VkxncGs0eVk2NjN4Zmt6ajdIZlZn?=
 =?utf-8?B?bnVrUWdPVTNyUzczZ210dWFEeDF5Mm5RR1pBY2ZFOGErUzNyVFFHS1B4WXd1?=
 =?utf-8?Q?6xzzYa+MS35K+aNoijEaaTkHVmyS4ZTwYElsLmnoIVhrN?=
X-MS-Exchange-AntiSpam-MessageData-1: d4orOMul9TDatg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8272a31f-8bfd-495c-6ffe-08df2f1f1fa2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:58:03.2658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zIjybXVY2+YFqqTRIVu7gnYxonwXbxQSdfpoKpDiaEdsSbptYjEebgkOl2Cm19lnw3a7K9AesY5B7fi37zpew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7456
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Oct 20, 2026 at 11:27 PM JST, Alexandre Courbot wrote:
> On Tue Oct 20, 2026 at 7:18 PM JST, sashiko-bot wrote:

[...]

>> In rust/kernel/io/poll.rs:read_poll_timeout(), when the condition is
>> false, the timeout check uses a strict greater-than comparison:
>>
>>         if start.elapsed() > timeout_delta {
>>             // Unlike the C version, we immediately return.
>>             // We have just called `op()` so we don't need to call it ag=
ain.
>>             return Err(ETIMEDOUT);
>>         }
>>
>>         if !sleep_delta.is_zero() {
>>             fsleep(sleep_delta);
>>         }
>>
>> Because op() only reads two u32 indices from coherent memory in RAM, if
>> the monotonic clock has not advanced by at least 1 ns between
>> Instant::now() and start.elapsed() (for instance on architectures with
>> coarser timer resolution or under virtualization), start.elapsed() is
>> Delta::ZERO. Since Delta::ZERO > Delta::ZERO is false,
>> read_poll_timeout() falls through to fsleep(Delta::from_millis(1)) while
>> holding the Cmdq mutex (in paths like GspInterrupt::handle_threaded() ->
>> Cmdq::drain() and Gpu::new() -> Cmdq::drain()).
>>
>> Would it make sense to keep the while
>> !self.gsp_mem.driver_read_area().0.is_empty() loop condition around
>> self.consume_element(Delta::ZERO, |message| message.log(self.dev))?
>
> Mmm, that's an interesting one, in that I am not sure there are any
> concrete implications but I'd like to fix it anyway.
>
> I was thinking that maybe we should add a special-case to
> `read_poll_timeout` so it returns unconditionally after checking the
> condition once if `timeout_delta =3D=3D Delta::ZERO`, but doing so would
> make the `sleep_delta` argument moot so I guess that's not adequate (and
> the current behavior is technically correct). So I think I'll
> special-case nova-core's `wait_for_msg` instead.

Personally I don't mind the special case in `read_poll_timeout`.
If you say, I want the timeout to be zero and then it sleeps, that
sounds like wonky behaviour to me. I think it feels weird to have
this special case w.r.t. `sleep_delta` only because we are using
constant values and that's a common use case. TBH I think it would
even be fine to change `start.elapsed() > timeout_delta` to
`start.elapsed() >=3D timeout_delta`, then it's not even really a
special case. I could try sending a patch for this.

I'm also fine with special casing `wait_for_msg`, but personally
(maybe) sleeping when you set timeout to Delta::ZERO sounds busted to
me.
