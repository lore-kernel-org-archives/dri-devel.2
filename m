Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0A8606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 00:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=R4i5Sv4s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4352A10FA0B;
	Wed, 18 Nov 2026 00:28:58 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010061.outbound.protection.outlook.com
 [52.101.193.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2202A10E710
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 00:28:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMKbFqNt05YtgZDD0Jtq0BQIr73OGj5evkEv3voJnxJcGiWInijGn3uZvaVfvnrhmdF/L8mSFKEnrtGYPy9oN7qbtHMaZz9OvSJ54xiXCFuXeeBZg74ugIQnt77z46PCaMMwHg5vJrnbbba0R1x/l/1hakQyFXQbwdjZSwj8HERr0wjStTDUYvsqMO2oRL94oHczNzTiF70Cuh3MiA210TM6OHPMtN9X42UX62EJTTbrJkdE3rG0DMZ8ozFmg5RzLRpBvERlK/tzUyPO8s4w1Wc6caefSP7owONjXlWlm9opVgjARrRDbWzw9JrGCDxeRweSUFtIYFwWonwzltgSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qx+4s4wXOKCgX41rrsFfYWHK6/MR4pep1TyNfKF3xsk=;
 b=o4sCmrizVd8jhywxBg2ryFdsNpiwSiYKU9+CsFYxZ1B7hTX7UTyi+7idEQ56CJopeWCqM0pBBLQcuOkAzqL31rKq1MtOmpOdxO1AvcDEfh2RR9+g/eFoDiW+J3iqSR+eJym9lhN2WO0U9wb1+O6rnDbmhi3PyiAjstsNR69Xg8ZJqD90hlca1tKKqsth3MDvTRvTzK3mJNzmzSBeSidLI3LEWdUyIPXX+XEXvaIGf1O7itJAwpEYxmK/bXBzMS0gXwvpzfMAUqLpIR66VHQF6LH/kbk31XSCa5dCw+VkTpJ+pz+v4aMSvFsqT0VqHICD60gWfSyIaSUnH3oHeaaeqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qx+4s4wXOKCgX41rrsFfYWHK6/MR4pep1TyNfKF3xsk=;
 b=R4i5Sv4skkMCbulcZy++XSqhKo3TwKuELt8hCyyAHVucqCD1RNEOH4RRy8W7DtOG8dj/ShhYnCRpSr3mGQDeWmuWvCHYYBaz7cKU6tWaqzoOtYzPfIzbZ1ifit8ANyh2Lxf5x91d03AY2px0omTut76UmghyA7U6TEQ0NBRRgTEbqwfxOOe/kI/iqDwnaXVdXbAun5E47RGOAWovtpzdZNoKa0A3xHiwVNzGYPTAVR1b5rjOTRtY+xZZUEBWOEwArZYtZF2GSCtW6lZonfiPqCbPTjD21+BbGjsMu5B7UheD5XnlxPUHuyqxO/0x1Om8piNQ9B0wtcnvCnx41zX1hQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 00:28:45 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0615.012; Wed, 18 Nov 2026
 00:28:45 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, Björn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, Onur Özkan <work@onurozkan.dev>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Eliot Courtney <ecourtney@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20261112-chid-v12-0-49ad43286dad@nvidia.com>
References: <20261112-chid-v12-0-49ad43286dad@nvidia.com>
Subject: Re: [PATCH v12 0/2] rust: Add support for reserving of ranges of IDs
Message-Id: <179496165052.454970.17980287507795025780.b4-ty@b4>
Date: Wed, 18 Nov 2026 09:27:30 +0900
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0139.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::7) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM6PR12MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: d17d146c-0161-47f7-1d6e-08df450ae7ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|10070799003|366016|18002099003|22082099003|261009223027099003|921020|11063799006|56012099006|261028144727099003|10067099003|261026140227099003|261026121527099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: pRTCYtR4myANaWajUvTEhwCgEIUDf8Rq6gCmJ/9WFFMSkLASHz6AmKdx4nAATiRYb89xQ+cu0kNvCB8P/XuhVUwcbNG9oBzPZH5UmEkqnR3cUyva/BRw8/zrmQzNlDRgrMlYGpELyTfBP50DiVPk3D/i2UpLm10dBTHFXhCUty/QR11G8JWlFfDOBCwAw4lMYe5lJAFpkUpsI/hf9YB0vBNq95Q9rqLnPExdXJS3xl9costpBMUo4YQ6mPhEdyTmniqk5YXJ8SNbWVRccMXfaoI6WpEkFW0rQM2VYEycm/30CYTAjckMFBBWlJ1CVVljtF1p79NQQi62d32nsywyd+nkvM+Dd929mWK6vVYTEuMFFdceZHHBoLHVom6tPwi5UnKTlujwSmOWl1bRZ9+0TU6N0MsR0gimhXa6hRXlCx/iS1p+JMlqYLWRYVlgfK2MRxaLUmP1Ky5JFP0wG0Z9ckGfP9qv8pNwkdN3M3ECYFhPTKHTNV07h1c8MYz8aGAYuSuiBn/XzR4BpkHCdkxdTrqAA3TbEmjrYF1rPNN99Z4HCS40/X2YihuSKdzKlmGmbyfui5dJ96pdNB8m1cIj4Dun/tgPp2rMLyvzoF1xT0pzKO+x6SayQSgoZ0y7FHtBpbsSD7EwooLmNyyINxpVyO0//Vfh2W1ibAdsHbBaIV01rmVSBRibIG21yODS4K5pt1TFwr8jlEQRxydHStxI0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(10070799003)(366016)(18002099003)(22082099003)(261009223027099003)(921020)(11063799006)(56012099006)(261028144727099003)(10067099003)(261026140227099003)(261026121527099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3dEWEYxYTN1Si9PVS9VeHVPUVNBM1IzcHFLYVZvYkgyeXYrS3VaLzN0UGlE?=
 =?utf-8?B?RkM1b3V2d1UzaHdtbGtqVUdyR25iUXZMVHcxUEFqSGNrZjVwTGo3dWdwMU0x?=
 =?utf-8?B?U2FyZUdMWXJJMDJuU1JQa0FsZXFac3B3TUErRXlJZWU3b3BjNGhDa2p3SGVo?=
 =?utf-8?B?NlFtRjdBL25iVXh0Z2J3QngxQ1lFNUF1ekVWYnJCNG1rbUR4Wm1MVzlRekF3?=
 =?utf-8?B?c3pheUI1aEJrSlREMTBmaEpIWW15MW1oN3JyUE04R1A5Zzc4bkJ3WDF4V25q?=
 =?utf-8?B?S1YxaDBJcTE1WjFNZFZDSkF0UDcrdGhrRlo0b0RkUW9KOTlxOG84UkJORGtS?=
 =?utf-8?B?YUZ6OUlVZ3JFV2c5RVREZXBOdGN4RDhienU2VUJjZmdmU2crVHNXbXVEMitV?=
 =?utf-8?B?dDdOUHBFNWE3cmxVckFSZ0hjRmdXUEdTamFWRDB5ODEzRFR1K1JHL1c1eUl2?=
 =?utf-8?B?TmhIZUxTTlM5RjNlTnNCenpLSHBkaThzclFCeUxrb3lOVUR4amc4Sm51Z1Qr?=
 =?utf-8?B?eFA5c1NaRDVmN0RxR1cyeVluQmtuYU5wRmdsQmE1VTZRaTdqUmdHK2J1TTNR?=
 =?utf-8?B?OTFSM01uYVZpemNvS0tEdFBCVlJrZEtKdEY0VTV2Y3NUVEk4ajVRSzJMSWdt?=
 =?utf-8?B?SlJRR0xOVXJNS1lKZEpSMHNmc1gyWHNzNk1rU3hNa1dIVG5za000c1libmN2?=
 =?utf-8?B?NmRRUmViSDhnM2pYaFJiNjFKUk9CNGhyM3U4aXBzYXFEUlpIclg1Ym9UblVX?=
 =?utf-8?B?VzlrdkFOSEwvVDlaL1RMVUpQS3g0dkZJOVJIN1NVYmRtMHcwQVFoZ3B6TERN?=
 =?utf-8?B?S2NRbmphZkw4R0tDYUxCWDY4cGZBZnBOMjU3bk0zSEIxcUdTa0RpODZ4c0VB?=
 =?utf-8?B?aW1vWkhuMlM4ZCtYK0lQTDNiSWtPdDdQWE14eTIyMzFaWjRQVVNQblJTZm5r?=
 =?utf-8?B?dFFEb3BxNkw0SFhJc3FDbTNrRTlTOWFxYVVRMnhyUk5leTBBM3BPKzJmdEwv?=
 =?utf-8?B?UFBNWG1rWUhvSndvNENJSG5wRHFyMFI3cGxiTkVFSTdFZi9HZnlkYXNwZ3Rp?=
 =?utf-8?B?NSttZlExN1BBbmw0V2pSZFU2amNqWWpPWkx6RnRTd2dZeDVPa2tjZUd2alRk?=
 =?utf-8?B?b2dWRHptWFRGVzZDSnZZTGxzMkQwMmhCcndXczM1NHlVNHRDRU5MbHU5YjJu?=
 =?utf-8?B?TEVnNW96WVF4Z2drcnF5SFk5ZWFYNmF6UjdrNWJaSlNLTVlRSk9UaE1XYm1o?=
 =?utf-8?B?UmNFblVsV3FzaktJSTVWRG9Va0lQa25ZcDFqNGRoUWhOYlR3TEF2TmtCRWwx?=
 =?utf-8?B?YlNYa1R3ODFla3drZXc3VUwrMCtaT29rWU40U0NuWm53YnhyTEF3RmU2T3pF?=
 =?utf-8?B?T3U5KzlBaWYyZm51a0lveUVwZ2V1YTIxbFpiUitUeWwzOWVZYzJ6SklzOWdz?=
 =?utf-8?B?dHdwZ3JMbWpNeTVrSmdpQ2c3NzBnSXJZUHkzRktWOVEvaEJjWEJ6SDJhN1la?=
 =?utf-8?B?SUZPRzFUNUU3bjF2OGFxdk92blRjcTFlMmFTczRnei8wQkxQcjMvTTA3Yjhx?=
 =?utf-8?B?bkNHR1BTRUp6MGIzTFBDc0J5eVJmUkdTR2taV01aTlFxeFB6dkZ0Yk1UVEhm?=
 =?utf-8?B?UkN3WUpaYUd6L3hLd0dGNGNqVzR2ZTl4S05ldDVoblBEWXBCaTNVT2szOVpj?=
 =?utf-8?B?bi80YlJnclZoZnF2a0lrTW9JNEYzZWRDOTVIYy85dVF4MGd4VlFiRkJlNlBw?=
 =?utf-8?B?TXlXRWlCT3AwakhkaHlSOWd2eWtoTjdtbXk4TEdaTHB3SFR1azdqYmRERlQ1?=
 =?utf-8?B?MnNmUTFGaTZSQ3lWdHFHNyt1Nzg0cCs5VVJYOWxsNjJkcmJNcUtCT0N0WURj?=
 =?utf-8?B?QWpudGp5UHFRU05uVVRYajhLKzRFbXExdS9OWlBqMnQyd0FsZkc1RHQ4ZWlU?=
 =?utf-8?B?ZXNGeGpWQ3N5N2NWcU5rOVlxS3pRbisra0tWVFdkUXpQaThwbGVkM2xNMWQr?=
 =?utf-8?B?TldwQWpNWEMwS2hDcVRTWkE0dUZBZVF3MzVNYU1JbjlOYkhKNjM4YWJyMWtt?=
 =?utf-8?B?WmVNZkJneTNkK05IUXl0RGttb3VVNkkyWkpyNjVseUFNcEV6NVErdm1tRmhz?=
 =?utf-8?B?SG42MjR2QUVvU01MTlVILzFmMWhHN21VbFN0OGZLR0hKQXYwblFDVWkvWHor?=
 =?utf-8?B?cWFncTlvbC9hT3p1aWVCOWg5c1FEaDJ4WWd2QVhhbk5vdVFaSjJmRks5U0pq?=
 =?utf-8?B?N0lxUUdROU5GK2xDVTVtYWpBTkQrejhpNmdUZFpzNkJ0NTgrdXVDaWZTSERl?=
 =?utf-8?B?QWRYZjk5SlgvWkdXQzJQa2k5anUrZWRkODdHN1ZjSVNuMW93SDJOMDZ1VXZ2?=
 =?utf-8?Q?NbEVhBzJbmc5vmghT/maIwbD5jsEeNiBG9OYQClKv4POE?=
X-MS-Exchange-AntiSpam-MessageData-1: XkMKhj0tKBRY4w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d17d146c-0161-47f7-1d6e-08df450ae7ed
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 00:28:45.4865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CWlv+ao9LswwyezXHuGnNFzRh0qj0gtemnDXfjINZaVyz5aRx7KVafGRHkqE6N/OxAbY1OpU/Wh5SY+GAf9CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403
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

On Thu, 12 Nov 2026 21:37:11 +0900, Eliot Courtney wrote:
> Add support for reserving of ranges of IDs, with a usage in nova-core
> for channel IDs.
> 
> The bitmap and `IdPool` parts from earlier versions are in v7.4-rc1
> now, and this version has the remaining patches: exact `IdPool`
> capacities and `ChannelIdPool`.
> 
> [...]

Applied to drm-rust-next, thanks!

[1/2] rust: id_pool: do not round capacity up to BitmapVec::MAX_INLINE_LEN
      commit: 8ea1ad9ac79575d0fb2d86b700b2db21d7149547
[2/2] gpu: nova-core: add ChannelIdPool
      [acourbot: use range comparisons in tests for better coverage.]
      commit: e825f4373d252339b6f66732d6f57427930bdc77
