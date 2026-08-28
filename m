Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4308FC61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 05:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9781810E483;
	Fri, 28 Aug 2026 05:36:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q3uOq4De";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010026.outbound.protection.outlook.com
 [52.101.193.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20FD910E483;
 Fri, 28 Aug 2026 05:36:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bh6dx1g400GdUXb22UYGN925wcBT4xA9tRR691B6qQiLeYLEOTATo05EL2vsPIMv2ERoGqScFO7x8E5r0+oeSC0qthUKyE9JJCcWsolFfBwZm2Uvhz9WrylMqrC21LBq0jhaGkE+Z2HqvTA6oQq127vpdJmYxXDAvCj0ExHoAGNZUCb7inXgSIj0b6Usy4lKylR8RwmRs8c++O9vN8Z1WgZ/LYoKk6cBB3AIK6lK/Q6MRnQmk3KSFgOAHwgEoV+21eDRxnBumfnPp0W7Xgxvw45Y2JzfW1Dy5H/mrum5eDMtV80/shR5bIWZN1s34zOyTXSYdon+J2H8aaJIPqamvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNwLUBxqnozNIpTupa9dw5T8I/MLKKN5ZuSV+m2SNG4=;
 b=FHaoo6p2izD1F5485Qkh+nRRno6tPMMu4Jm1zdRQZfRzyvE6sEc/GXzl93KEw5iSdEYVo+/wDBcAwHTcSCgyBAkz8qy71ZJB71oR7YHOfBvAlTNMx5EtK7VknPL9z7sFTmdc9R3Amrekh7dHgSw8lksDDHMCJAXYDjua3deCdNLnQnw7B3UI3G9GWK7L1dEr71Hp6NKqRtEt8Bu8drWOnwTIJa2PpvqHokIGThyRSirTjd1ngXk11jTRGojra84a6ZlCHhXYTibYPHCXeBCmW/P7L3eK5ybJoZZPcQHl12ORin80rpxrJ2FfjnNXH0tQLXINHz+pKfD4b5ppPXtZ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNwLUBxqnozNIpTupa9dw5T8I/MLKKN5ZuSV+m2SNG4=;
 b=Q3uOq4De6LjjwTrNaLvc5Ecin0N7lObB50pruXhVYV/qNgYov11uQ36upTRxnfdaZ/y6GTrQGjUH5cWNsM+Lgr+OV5VNdO+AdA5ZM9RNR/8w94EMbZK5gwoVe33O0CNwJz6hqRkKjcHc/mgQhUT3LF/E1QM3nufojaKEd4I/l11rtQXvMIvy4XZdnD5TqC2Ol+9t7qJXwwERnQmD7xDQROFIJil2Yf9uhtlDBV8voshCk+KNXc4ellinLjXX8VRUQtHU836GKqa7K5G8jyZF1d9t7ucYeHoVcKbVOP0b+uA5yK2be2aDV8VCYQUWwF2dH6SJIm60MPH4h+aqhRocXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 05:36:11 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Fri, 28 Aug 2026
 05:36:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 14:36:08 +0900
Message-Id: <DL0C0HAK8CKB.PES9IOYFNA9D@nvidia.com>
Subject: Re: [PATCH v8 07/12] rust: sizes: implement SizeConstants for
 Alignment
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
 <20260827-chid-v8-7-bc74c77d0214@nvidia.com>
 <DL0BIY2CGYQ3.TY18JERIWOUK@nvidia.com>
 <DL0BR314U4Q3.PMFAV27Q6EM8@nvidia.com>
In-Reply-To: <DL0BR314U4Q3.PMFAV27Q6EM8@nvidia.com>
X-ClientProxiedBy: TYCP286CA0078.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::15) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH8PR12MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: e986aa59-1aee-41fd-9d22-08df04c6441f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|10070799003|366016|10067099003|56012099006|4143699003|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: F3qsVyunHVnTvGZwT4ZoKtK+SWIBd7FBeI0+kUCWIGOMAkWGqXqU0bb2+TrVOxSWBiWry0fjAPLkAI/ZydSsQs1OUN4PTaTRXHR+xWr44DOXos1OWrBSjN5tLb9f8c/8v1F7Y9DIWsSz4TfSz1E5P3WetxOp6T2hycClK+9SQYF+3qsVhPrLdOfFIhPi3JjCJJC8xbZ5PS8QxZOf0axZcefIflqssBcA9bGjFziKGxWLmQsfQF/5xK5n49UHF+pNzcjO64vC61n3nqfd9ZljULuu0bM60qJATEUXUC0KX/xR420b9HOJlIV56vT0bvucYt57xEhB6X0HMoYh9W5in4QIr0F6EFhhVui4UNrPn6+qWv7NvjZXd0KpBcCO9F6c4KGNhyswXpTVWlMF5jWAgWF8OzM/bm6muteCvhQXKKo7REgdM3gc1QHPIBrzSS/MTvayvOdFE1q9iKUprK/zKUnjaW9CDAZXNPNZ3Ub38VmT7IIiNgDemFP/mCkfJdDOrpnABjTliy57Nz0xId+S8tJrLSyS5zGgvL0urCbBAdJIJ2+bHnGHSRQuvraR/6LbKahw2skR6ezxFfAj+/7cpEWYXTNU9qgI12NU9bjen0zaw3gN90P7AaLztXez8n8NbhbtO2un2+/C6kG2g/bcBo/O8alzfPN98/B7Ki+w8vA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(10070799003)(366016)(10067099003)(56012099006)(4143699003)(5023799004)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NndwR0RDRnVTR3U0UzZHb3AwM05zenAxVlIyT2FFZ0Z5WVFsODhlWnkzNTlq?=
 =?utf-8?B?TS9SSHRma2U4YjV2bkNPOHgrYTUvYi9tYk5vV1ZIMnRPa3BpaGQwbk4xYjN1?=
 =?utf-8?B?NnE2cXdMcWkxdDhXNmErd3RYQzJKOFRObWNtdmd2UUVWbS90NDBFYSs4ZXJz?=
 =?utf-8?B?TnZVb2t3cWM5cEFYSlFQMlZqWUp1ckdiUGMwRDhVbE03MThVWm5aYUhjMm9I?=
 =?utf-8?B?aUp4TXhBMFd3ejllcUw4WjBjQlBPNWhKaU1wazk2aFNaY2N3N09NQWd5WEM1?=
 =?utf-8?B?Q2NjYnlrOVlzUFMzY1JneUJBTGpiZm1WUzlXdk5FSnJaWVZWdy9hWEs2cDJP?=
 =?utf-8?B?TENZRDFNT2xpNU45Zjdka2FwcjAvU1ZlWUxhSzhqOXZoL1pRYUowNi9SdWI0?=
 =?utf-8?B?enN4cUkva2VkeVMwTmY4ZlovS3A3bmkySWQzOG9HdkNWS2pYNithaXBjSUg1?=
 =?utf-8?B?V3NOTE9KRjhmY21PNFhWVlE5UWhOdWJWWjFNVmJ3eUZKQXE2NXFmaGtsdUU1?=
 =?utf-8?B?UEpUTVFXdGJnVkZjVmMrMGM5RXRTVjFNcTFkNWFRZGxyRXhvZ3A3U1dYNDZa?=
 =?utf-8?B?cWcwM3FYV003dldEY0FxVlliZk1EM3hLZFVyVGQ4b25rNENkZ2JFRE1Ib00v?=
 =?utf-8?B?OXJoc2VHekZJRWpQbnhtbG5RSVc1UGRkUXNPYzFlcXdUb3VXZ2NsSjhSOEkw?=
 =?utf-8?B?TVJ4RFhhQUFyNmFDYUx0L1VQWk9wYlVBcWR1cVBPVlJhNGhaaWQ1dU1ScnJz?=
 =?utf-8?B?Y21XK2NpdS9pS2xraDd4YUtCeStiNW9tejU2ZFBOMVZzWHFBaTlkTEZsS0Zv?=
 =?utf-8?B?N01zS3dnNkNEa05jb1Y5YmpBOVdaMlkva2FMMTB3dnlHbGltMlRGNDMxOENj?=
 =?utf-8?B?MlBaaU1sYVhsTVZyeW1DMm9EZTFWOGFwb21rWHJmL0o0ZTZLNVhpUkFJbnpx?=
 =?utf-8?B?Ukw3Rmthbi9VWWhoTW5sVHBEcExZSUgwZTNmbDd3K0EyaVdXa0tMcGxWZzY2?=
 =?utf-8?B?RDg1ei80a1dKcXdETS96Y3FwaUpNNXJDd2pqYitsU3JNS1V5RVhGSFRveWNE?=
 =?utf-8?B?djQyeXlWbis2elZUOVhSdTgvU2tYL2IyRW80RFV1V3JybzZWcUtiaXFYeHF3?=
 =?utf-8?B?QnFCclhhQzJGQ0pYbXFxRGJNL3NTdlpEM05YZVl1NDlrbEo4Y3Exa1JrUjdt?=
 =?utf-8?B?U01PbnRWVndjUHFtUDNJNDZtWTBpNzl5M3ZFa0hWenFDMm81VFp1NGdCMHQw?=
 =?utf-8?B?UDhSY3NXLytaNXhvQVZFaStROXNLc2FsZ2pDZzBhNjd0cHlJQmVoWWlnNDU3?=
 =?utf-8?B?TUQ5cTVNOFo4akdlanhsTkEvQW4yT1QzUURhQk1NZ3VHYnZ4ak1oaFNSMnkz?=
 =?utf-8?B?Wkd0N3pHNkVCYUMxeUwwVHdPbUVOM1JXVy9sZlNYZDZsS0hrRHNsWStpYmtB?=
 =?utf-8?B?V1dwZFpMYTZzYXJiWC9lY2syMm9UdjVZSUVGSHdUSTJ0T2I2czJJM282NXhj?=
 =?utf-8?B?TjZJSit3aE5zU2hXT1kzd1lvMmNLeHExTEhxYWRpZkVKQVV3cWJEWHpoNjRm?=
 =?utf-8?B?TGhIVWdEelBOblU2YUdiM1N5enM2MC92RklXYVRHQVo3WE90TlphVXh5OHFa?=
 =?utf-8?B?SVFtMFcyZzBZRkhOanp5L25LY0o5dkw3VWRXYXh3SjI3Vk8wN0pZUG5PWVV2?=
 =?utf-8?B?bXZBeVg0emErV0hORWJCeW11VTBqWDdwWEdjSmljdVBJNDlwRGpMeUNIaW83?=
 =?utf-8?B?RTV6c0hsc2lPOERxOGdiVzVrbDh3RklTOFVQd1FJaHRneTUrQ3UvRE83S3E0?=
 =?utf-8?B?RXNhUXBJYTEyV04yZlBUQmZYVzZNMk1TREZCSHlFbEpJWmtjQkhaTTNZMDFC?=
 =?utf-8?B?NnlzbnpybVI5U3dlYncxNml0VkRDS1N5SXY0TnZSZmNlclZHb1dGMW5nK1p4?=
 =?utf-8?B?b01zWm5Rck8zMlFSRDNON2YrOUlhUDNYK2JpK0IzYnFONWlsQVNkdldldW5q?=
 =?utf-8?B?SjUyeDBNU2tHK1EyYVNEK0NleURIOVpEOHFOQldybW10MXhWTXZLamVYMFlx?=
 =?utf-8?B?eC93ZWVBT0lFdzF3eTI2eHR3ai9SNUpRRTJVa2pyZ0NMNXpoK0NmZWVSclVk?=
 =?utf-8?B?NjNYeUJKckxZR2lmeWNzNWpWeFo0WEw4NFlHOHlRRGYrbFNLeUdWejlJamg1?=
 =?utf-8?B?SWtXTWQ3cU80eWNNOWIxQ1Jpdk1tVlBPQTUvSDlqY1JFc1VwUkZHWUd4Qm1q?=
 =?utf-8?B?ekVZZnVSaXFlTmNCS285Y1RoRmEwYzBpL3NVSHA0cCs1OFR3U2NHYUtGQm5J?=
 =?utf-8?B?Tk5KU0tZdzZoV3dzbzlLZWFVZ0N6cVNwc2hLZkpKeTFmcmU0aXUzTzVWVHlz?=
 =?utf-8?Q?v6HtOGNPdzE0WnpuTqkVYDe1sKMpctTCHvn2TNOAVfBgA?=
X-MS-Exchange-AntiSpam-MessageData-1: w/B8XKwdarXztg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e986aa59-1aee-41fd-9d22-08df04c6441f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 05:36:10.4756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICgp39gpXZiYjqu+QGZGy6nqml78qdolr4APEmMdhfR80fCWcI8EGe2y/6Qkv9Hm2Eio4WBKTzWwAyH6NeV3ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109
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

On Fri Aug 28, 2026 at 2:23 PM JST, Eliot Courtney wrote:
> On Fri Aug 28, 2026 at 2:13 PM JST, Alexandre Courbot wrote:
>> On Thu Aug 27, 2026 at 4:28 PM JST, Eliot Courtney wrote:
>>> Currently, constructing an alignment is quite verbose:
>>>
>>> `Alignment::new::<8>()`
>>>
>>> It's unfortunate because it disincentivizes using it at interface
>>> boundaries. Implement `SizeConstants` for `Alignment` so we can write
>>> e.g. `Alignment::SZ_8` instead.
>>>
>>> Link: https://lore.kernel.org/an4xDp29VX8Am0uR@yury
>>
>> What's the context for the link? Is this a `Suggested-by`?
>
> Was trying to show the context for the motivation for this change
> (verbosity). But I can remove this if this is not how you use 'Link:'.

The custom is generally to have `Link:` follow tags like `Suggested-by`
or `Fixes`, but I guess it is also ok to keep them as general context
when nothing matches.
