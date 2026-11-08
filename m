Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90C3606A31C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ocZU6icH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F2EF10E2F0;
	Sun,  8 Nov 2026 13:51:46 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CCEE10E2F0
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 13:51:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nb3PYRCFcw2qaE7t32D6/0KX6S34H3sJRQrb4psgLzMVAlOZS8FhS6V+IHvVz1ooGrtNZbBCNCaNKNddzQQv9Seny7RtdkoHeb6yFBQu+ozxbb2094MhYlx3MQGb/MdCoKvGPdSjnPw5w5b9U3JGYAsoZ1XwnhgvUwTPHgGX24QwbN881c8j1DbZZgj0n2TZl8f96An9zp700B6OlGtdV/FwCWE5fVQmtMFdz+rULdiVnrKcS0rcNS7jEHkwAO7WbQEQXY/DsR3bJ9dGExqVU4/5g6JwR4Vo5ZqTHae/3Q+c+1ia/RhBVyy3WTT7M0dQhcyEDULMNzUWz++XmOhDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jx4TLuf8LEXuj2vvXAFHar97lXfG0sz7c92+SX6QB0U=;
 b=Iqqbp20PdgVbAEF/po0ohOM292XrlCbf4o6nFRzjNJnf9f09j1xyAxbG8XKI8ve9NwEt/bbQHS/bUp7B0ed1sXTpKX3mxNit1rKNpF38TxM+Lj7jN/SuumnAPwo9l6kIBYAVdzOVoehnAUb98B+TFk8wGS18Dm2t7+vRJ7zklC8ogMIRoe4YHIFD5oA52Xrqgw8PIp151cm+//StWwUeZ5qz7cKCYECVy4gCyBLOegVlyVIGwd+dOIx02GugmSf8jROklkJmO7w5aTdtnmdz1mLwHzsUf4/fnaGby+sqzGqQloPlOfk/Yk56s2jztoKnwzlHJCphjhwuD5pfq0FEzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jx4TLuf8LEXuj2vvXAFHar97lXfG0sz7c92+SX6QB0U=;
 b=ocZU6icHIPHpwgG3Ma+u1q+cdwa3tVNkUtrRzdZBGETqPIg1gbgdHrSiFvcndGNc9Zr3X3O7JWRRpLuK9Sf9Q+5VzFMGs2AJFsBz3l6IsUmxGozIrNMy+i3HD12s9IhJP0ZfMc3mEcUOqJE6T5JtMGhJP8AeoAx09ArGmi4aqQEgQB5ZgqO1MrZfiNxII347cJ8Xjdnoj156pkVyYa9pIP6b2gllvosJ25yHmU91IonMwKCFIB+e4gFm5W9thEBiZB0yUwoqpmLL5VMvy/n+iLEDbpCTIth4OP3Ft1XEywqmGojO+BpB/bzZ2bzpgN7rtFpd496dq3e4sMiEbYUSIQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 13:51:34 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.007; Sun, 8 Nov 2026
 13:51:34 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 08 Nov 2026 22:51:31 +0900
Message-Id: <DMPVN025DBS8.1HVI0U45RAS5J@nvidia.com>
Cc: "Dave Airlie via B4 Relay" <devnull+airlied.redhat.com@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Gary Guo" <gary@garyguo.net>, "Alice Ryhl"
 <aliceryhl@google.com>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 2/2] gpu: nova-core: add support for GPU timer block.
 (v4)
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "David Airlie" <airlied@redhat.com>
Content-Transfer-Encoding: quoted-printable
References: <20261105-nova-timer-v4-0-45a7c121d4de@redhat.com>
 <20261105-nova-timer-v4-2-45a7c121d4de@redhat.com>
 <DMNCVDFYPL3I.3CCYXY4641F13@nvidia.com>
 <CAMwc25rODe5F7MdhWEr80q+eOitKqg-O0LQhEWOMSVWZodfyMg@mail.gmail.com>
 <DMO7FUYY05LK.123ZPLIW24C2S@nvidia.com>
In-Reply-To: <DMO7FUYY05LK.123ZPLIW24C2S@nvidia.com>
X-ClientProxiedBy: TY4P301CA0054.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::14) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 72534d8a-ca42-4699-e181-08df3d9f668f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|366016|376014|7416014|1800799024|22082099003|18002099003|4143699003|5023799004|11063799006|56012099006|10067099003|261028144727099003|261026121527099003|261102123227099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: LMlYy/I0T97kuCeRXaSR1vL1QBQz+N+OMjKIFSHpOzXvsH9zVe9gAWgLxoGnGiCIAB2GPC98sAGbzmamHcE4u8bIbvXXWPaM254zm4m7o98OHDlZTUNFvvCZnI6C02gN9LYgx2Fe3P5hD2+Q9x1xjo8lbtNz067H1qYRQloSyNJAsq6GMXlvadcq93eJIgubQmM4+YCHBlZHMN7wRx09hhp3bwUzT6cqx9CTnCDjFUyZP+I4N96CYQVCg850wPSWeS5e9ffZWBpOaheKGBMkJHNxIKwle93Q2NuiUXn4H0jTjgupY7EQoPSwNSiDfd1vIA2Gi5j8ve/zkYREfwundyA0ed5gqzW7vNyhPNd7SuFodTL6hIB5Uzgfsi7cD9/N+UbILO9bEjGCC8UiaIHM38LvEzC8C1hQV1nkklIXBm8ZjBnhiB87YFOp5KK7B6gVdxx0ajerHiXAEryjHBvbfS2yLEt/6XL8NPPz1p1AdjH+ZailfJpSQtcdsoT1Q3u/ZXRZDuW+aJLrSe1p5FBnRLmpTh5SUALhqyNF7A+/vfLNr2MFSHFzv+OilNgv8QJ23OvQ5mciajCAUYnuAH/NbzprpcdqIl+vvuS4ahl48ugLyF7+gmH/+I19que3wU8r7gfeWll6xtZD+SDG9G+6Dcq9lSYU0OXign3HhWvGIWE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M29BY0QwV3lNeDllRUthTDZqRmcvUW9tRzcyVUEwZWN1d1BweVFWUEllbEpK?=
 =?utf-8?B?VVkvY1p4cmJSTjViUzZneFlQQnZwYzJPcXRtc3hpek1hbzJhUmtEV004cHM2?=
 =?utf-8?B?bm4yWWlQRVN6K0pNTzhLMVc3cVliazRNbitGM1BEVjBzck0yVmZjSUVtRFVY?=
 =?utf-8?B?MWNhQWYxdWpnU3hON01hb1RIWEQ2QzZteXFmL25CSVMwNUZyQUpYQVRJU1Fi?=
 =?utf-8?B?eFJWbkJFbUlqUS9iSTV5L3B2dXlxQitYa0pjSXFVZXRqYkY0clFsNGd5L21M?=
 =?utf-8?B?R00rdmhRWU9lNlArTXFiVzkzZ0JTYWQrdFhPTEFaVVk5endtd0NYeUdRRFFk?=
 =?utf-8?B?QTZyWEYreXNKWmpuYjlvUzh2TjF4L0lwU2dBK2JhdFJqcFAzOVFudlFVQ3lU?=
 =?utf-8?B?ZDdSczNyU2Z1VHJiN1ljeERDVzkxazJlRmloV3NqVkZ4VWNIRVYzRkRqM2ZL?=
 =?utf-8?B?QkxBOCswZ1VLSW5iR1BvbmprM2JqdWlTOWRoZm5VQjk4b0FxSVYvNndSWXZQ?=
 =?utf-8?B?SWx5dGMxbVhkUnh6bkdQWGhzcFFMRXVjb3ptb3JCK0FmQjNON2w0aGR5LzN2?=
 =?utf-8?B?dnZwRldteS9wVTB4U2JvVDgvVnQ5czZza2wvdTFIUUNjOUhwb09jOHQ1Qzk4?=
 =?utf-8?B?VmdDS1ZSZlkraXhVQjArSGsrQTJ1eEUveVNXNVVBRk9sU1ZhczluQjUxMFJL?=
 =?utf-8?B?dmhwL0lLVWVXVk1Pc0RocEtyQzh4KzVvcWMvK2grYldwMnNNdVB2SXJ2Snkv?=
 =?utf-8?B?dE1JeWVWOWh6MGhQUWZZZmxteU0xWmVQeFN6NU5vMzRuanZvdmlBYVZidERl?=
 =?utf-8?B?cThDRWphb216U0JYUGtONjh1cTd2ektGR29UdU5DdGRLNnJMRjF1L01VRXNj?=
 =?utf-8?B?SkJuT2tGVmp6TEVUKzE3YXpzK0g3YW83TDBqRmgxQzJuMVRqWUhNaDVPRWVn?=
 =?utf-8?B?TjJqVko1OE5rTVRqWHY3dUF6dnFpNVNxN1Mwa0lYL040UXRSZjdZUkRwSzMw?=
 =?utf-8?B?bytNTzFKSW9McU8rM2NQczJIK3FFREdjTVp6UzZoWHg5SUdVcytTVk45Y3hJ?=
 =?utf-8?B?WlJodTNEcEsxOStCR1I1QVlRSW1qeisrRHNWTWVOaW5reENvYlArKzRQNmtT?=
 =?utf-8?B?NlMvVkV2eFJqRHFIckh0RS9VMWE3Ri9pQTMzS0RQVkJid01SUzZ3TXZWVlcv?=
 =?utf-8?B?aWV5N0NDb0xpeUQyVUVBbERkREVaQ094Y1ZocnFxV3NyTUdyNUsxQ1g1N2JO?=
 =?utf-8?B?Yk5JWDlYVi8veERCdVgrUnRPYlBYSjk2SFdIQzVURkU0emhTNVNtdWlqeGsv?=
 =?utf-8?B?S0hVM3BvOHk0azBWcFY4enkxY3BVdVcvWmZiRlFhTktGSVdDVlovUW1scWdh?=
 =?utf-8?B?SzRsWTkwQ1YrL1A4djZreWtHd2d1RFdodzBQdEwzN0JOUGxJYVVnUnpmN1F1?=
 =?utf-8?B?R094NGlWaVk0N1RFY05ka1VjL1ZibWJaMlRGOHdUZWIzQ053WjQ1K1M3aEgy?=
 =?utf-8?B?RmZOTnhMM2ZnT1lQN2NUblNOVmR5S1pEQmVGNG0wTzV5b2FjU1dZdWx5U2pM?=
 =?utf-8?B?T0w1Zks3SzVTM1gydGc2eGxwbkREMmY0YVRQOTE3TzdwbnZoOFN5Q3ZOK1ZU?=
 =?utf-8?B?aDJ0TWc5Z0hNSWhrVjRYWGowR3NubmJOVTNZZUlFYythbUF3VFpYVWMvMkJK?=
 =?utf-8?B?TkRxN3d6UFBEV1EyVGRrRXJBVGp1QXFpcDM2RVBYcllhVzFBVW5MUTJ1WUtC?=
 =?utf-8?B?bGFlbS9lSEo3T2hndG1UdThrclBpY2t5RHNiSmFCYXg2Zjlid1ZlQ1dtYmpP?=
 =?utf-8?B?QXE4NURPaVNoR1k3UVVFV0JmN0g2RVY0QUd5MzV6ZzhYRU9uQnpmbm5zRHRD?=
 =?utf-8?B?b3BlaFJKTUxDd05URWpGQUFJbWZYTG9CUlJmVUROZjNnSDBlcDVtOWlBRW5u?=
 =?utf-8?B?R0FHcTNjMnl3a254NUJzS01KNzY0NnlPdktkZkZ2MXNQUWtia3RKdDFHdUt1?=
 =?utf-8?B?d0NoNTRzdmxkL1RER2M5OFpOLzRzclZhOTFEQWgrWlMxQ0NUblluUFFUMjY5?=
 =?utf-8?B?L1RiN0lPZG5IMWt4YjNla3UxVnQvYytDaVZqemhEdnNLOVlqMFlsZ1JvSGlN?=
 =?utf-8?B?UWFHUytaVGxUZkg2Z1ZGODlmS2FEQllicGxVTDBMejdhd3A0MlpuZlRsOHZw?=
 =?utf-8?B?dnFkS3Jpck1ydllRVURYMURRdnEvdURCUlJwd29YVU1DMm9hb25GdUFaS3VO?=
 =?utf-8?B?VkhGci96NFVvUG5QbXlEdEpnRHZkWEwwc0o4V2lQaDZUVGYvbUFiOW5Ga24r?=
 =?utf-8?B?dGRSU0dHbEFDQ1FwVlZvOG1iZHVqOWdmWFlqdkszS21nZmMwQk9aM3crRkgw?=
 =?utf-8?Q?+jmWovI/K9ERQNh6mQLeAsvRHNY0P+R4/61OB9IWORZGW?=
X-MS-Exchange-AntiSpam-MessageData-1: NX/1HVA0uQNwNw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72534d8a-ca42-4699-e181-08df3d9f668f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 13:51:34.1220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0nGLcCFOjMKBd4ymaUfm6n0A+58xpXvFKvU0QxCVDOC9O7jTpUSWKSuD2WotHlSvaDbHo1iO5sKknYfWMBUHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571
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

On Fri Nov 6, 2026 at 11:41 PM JST, Alexandre Courbot wrote:
<...>
>> nsec_lo/hi are now used in the register from_nsec for both tu102 and
>> gh100 registers.
>>
>>> I'd ignore Sashiko's suggestion as it looks like it is trying to
>>> reconcile the code against the comment instead of the other way around.
>>
>> I just fixed things to truncate and used wrapping_sub, to be honest
>> being careful here is probably the wrong answer, my local review bot
>> pointed out some wierdness can occur in 2043 with the current scheme,
>> so let's just keep it simple, wrapping subtract, and feed the result
>> to the hardware which is what the other driver does and what nouveau
>> did.
>
> The other drivers do what they do, but here again do we understand what
> happens when we write a wrapped value into the timer registers?

I checked what OpenRM does and it doesn't appear to wrap. Actually
`tmrSetCurrentTime_GH100` has the following line:

    NV_ASSERT_OR_RETURN(secTimerNs < osTimeNs, NV_ERR_INVALID_STATE);

meaning it expects the OS/GPU time delta to be positive. The error it
returns in that case is ignored by the caller, so nothing gets
programmed. In the absence of a better alternative I guess we should do
the same thing, i.e. the `checked_sub` and return early (but the
returned error should be just logged and ignored).

Nouveau AFAICT does not write `NV_PGC6_SCI_SYS_TIMER_OFFSET_*` at all.
