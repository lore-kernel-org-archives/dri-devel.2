Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD3DC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4447C10ED04;
	Tue,  7 Jul 2026 13:26:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TeVvZiVc";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9137B10ED04;
 Tue,  7 Jul 2026 13:26:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJCCSIYLcn9IJK20sOfId5g8yU29RvsyoQzIixWQGCXZBOYkm5v/1lU7XWNrb8njaPULGWJJEVmjf6YHOJP1IsnH9XfkdSciMOE1d9g31V0x+PpNubbVqgBwumwd+NeEK/lbyOt5SBUaOpR9toH7QRm99QYvsQUnPVN+C+px1BTP+kC8Ypl6GVWBJ1EETzBUXK4N/dySxDuy6ofvP2kMhY9PG3PzU8vO/zff0z+rPc0J0qA2BRx/Sl6qqxQRY8jBfLn/BsTJOqzq5Tm04jir8qowrlDC4mjb0A3U60ApNbKuv/ndt1Ng158Wrzx7rKlg8oKIu/Ov38xYst5tMS7dgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxKPXAiY5Wwoio7LhJRQjgBP1A/NjuiRUuAIwlnoKHc=;
 b=SlGfLRSfj/Mkc/uvUOUl3u7AAClG19wjYiNbF3cx95JehM9jlcXYM6IqxRsPbFe6C1T9mB4l9RIWndc98dxG8GHKGQHcEaGHdZR377UBqy+/CSZt36PDV4t/gocb25GUyi73ijlJepwyavYS6dCmfn4sVGkE0J5SMsUfAZvZUJFFK8iLPE/8fU48reXl4Ow7ny4xmUo2yo6dVfeDlTthtBCFews2nRQtDzZSroftZx2KTviJt0j5jYGzBoLQvZHEK2XrxhVPXgdyDPUFKeKu1oX7ST4Otme11uMD2vvng5lzw2VgZuoeXLqDP3bUqdw8YnqKtLjA/expaZEjbxWURw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxKPXAiY5Wwoio7LhJRQjgBP1A/NjuiRUuAIwlnoKHc=;
 b=TeVvZiVcJbnAYrOnocXY2gt9/5MqJw8RNpIJNTNN/8114pQW+8RnNbHwfgfMX0s4rRgxy3teQH4htHVJNddvgV/yCaWPBcRo1fkIupIfAqrxzaaNSv3jrytEICwb+vOHQbyEycYvcJxtDBZmrIBW5QXJ13VbE4w7Pm/1VuSufixJi4A910SS0aWuTNWdA84FzWJ6ShNngXpwjLN1LNjOqbRa4rbeTdPSoxvpHvJZ9LlJVFqRKHy8xwdqYXJCrh/cHEpgchjT4AUdF2zDRqVi2qFaqYbFRfwWDKRpChDRdmuSyOb4eq4tWstLA5DC5PSy9YbX38l3p1Ez6WMiw9Nx1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 13:26:18 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 13:26:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 22:26:15 +0900
Message-Id: <DJSDG3RE8MDB.135TG7FX4Z1G1@nvidia.com>
Subject: Re: [PATCH 0/4] rust: Add support for reserving of ranges of IDs
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alice Ryhl" <aliceryhl@google.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
Cc: "Burak Emir" <bqe@google.com>, "Yury Norov" <yury.norov@gmail.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
 <akuV_GRAM4QPqf-o@google.com>
In-Reply-To: <akuV_GRAM4QPqf-o@google.com>
X-ClientProxiedBy: DSZP220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:5:280::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec739a7-ddd8-4904-4a5e-08dedc2b53d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|10070799003|23010399003|366016|22082099003|56012099006|18002099003|11063799006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: oXznECyQAqWrTiVzGKGJxiV3IYTaeZiYcyv52WJuSamqrxUSOUdcHrjrVMr0Ez43aRayshTppTcVNyCpAu401P5OW+vWNyh7bqnmZT9FGjkDNjoxSuXLKUBWPVxscW9c0vVT+gM3X4suwLXrQJzFtHqhSv4K0Kj3QUhYnPz988/t0jbkCADhfsroYGRzqaZegPbYLEfcUGLlwKAFArICr0BVU+fqvWuZT2eAKrXuralGRhJ7NXrvxl+uUw1eqQF4tNqhZJ2Gtd8YyvZoLCXGn9DS5NwmiKybQzExwmwC7/BbfQq3tbvvHsBUxZ1h32v2eS8XbCZhBb05FWHKp9nsbJGSa0hhQtTAP3RNnMnDvWP97EybO9gltOkjKTtIcgfgsDt15Uwsrs1LJVB0YSwKRUlC/FocO0flPSInRGTxlxJjlZ1SGjbI4SwdQlf8kQ4UwYuyM8X/S751nvDOIPN1/7qxabn1J9Hr0jqg2qqPx75QgcB/1ehg6W5xu1I9/BWK4a5viDLlJulLI0SONH3XeqQR3M31uqNyRRnlkin8fw7MKFfbHF9cEWASpmwVwlI8J8zJCMjVwBMFHmtVTmbmK1WxavH+r+vkiO0PeJIwofeksjIuHDq8qocXDg4UOAiAYAVablBWwFx7jrJjx60cFv9MOfbquYe4SL2zXI425QM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(23010399003)(366016)(22082099003)(56012099006)(18002099003)(11063799006)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2JEbVhLeXFLYnNxbW80MDNteU9MejdQMk1SNnQ2djNJbEJ6Y0kzMGFQZVgx?=
 =?utf-8?B?U0d6K240dTBUYXpZOTEyRHlLYUx5c242VktlY0VaaHkvTEZ4N0FWcE1JUmk5?=
 =?utf-8?B?RFRTYlY1MEttYWNoNXlLcUpUNlAwQ2ZORVJWeHVpQnBkclhOb0NNSDY2REtD?=
 =?utf-8?B?OWlKRG1HdVJyNGx0S1NZT0xwUXhqUFNCc0pyYkN2Zjh0Y1ZRZTV1blFEZ09V?=
 =?utf-8?B?OEt6a0lnQWF4QS9rV2dibXBBL2xDMWZoa08vMHFGWGdCdlgvMU9FK2ZEa3lY?=
 =?utf-8?B?WEhjMnlOaFZ0bWdjdVluR25ZMDVtSTJ4d1FGeE40WlgvWUpQdkhIQVpaaStW?=
 =?utf-8?B?enpOVmVXUDE1eEdLaU1GSHFxanlWWSt5M3g2ZitMRWU4R2czc3FlMUtETmlZ?=
 =?utf-8?B?U2pJd0UvcXBaazFvWVp5QytlRldudWl6SGtHUmxFYzBMMWdpdkJuRzJkTHFN?=
 =?utf-8?B?SUhRdkNqVDYremplNUIyMVVIVnRjV2RiMFNuRHRSd0ttQlAvdk5KbE0ybTB2?=
 =?utf-8?B?MVRNTlVUWUhxRG5Od1FFZG9FMnQycG9ZRG8vYTBmWUU5UkV2eWRkS3ZNUjRw?=
 =?utf-8?B?YUY2aTFkUUU1eWtZM2xsYWxaY1F6bCs4Q01pSTZoR0hrN1NsWkNmNnpRWDdP?=
 =?utf-8?B?cWZHUW5WZXNXM21lMDM4RkNnUXk0OFNjSVJHNXIzVjdiTy94Vk5aczU3a29p?=
 =?utf-8?B?Yjd2b09Nak1DNHFkSzNmSkg1WWNmYS9JMWJjVnFKdWZTUVl0eFNqZ0o1UXdI?=
 =?utf-8?B?RnJpQTg4SHVXbE90RXlGaXc0dEs4R2VhYmc5REt3Q01pQnNPNlJCNGhkMVhw?=
 =?utf-8?B?VExPMmJ3NjJKMi84WGcrOWZSNUcvSUtsTFBMUnliN05MVE9ueC9wTXRwNXho?=
 =?utf-8?B?alo0azB0Y3ZNQUxyVnlvbkpTemVHTFlUNzZkRnAvK3BoNDVoc2x3Vm94MVRj?=
 =?utf-8?B?Y0crazRDZWw4MlpsQklUOGU0LzFyVytsM1RiSWROcG4za0hpV1RXMUxpWk5G?=
 =?utf-8?B?TDZIblR2WmZ5VGhuc0thZWtsRStZTWhFNk90U0pwMlJIK0Q3bjN0NEw4Y1Zz?=
 =?utf-8?B?aVpQSFhwRUhWS20zYVNxVVo1K2M3NkF0RU5UamU5S1V2SDR1YTNhQ08ya2R5?=
 =?utf-8?B?Y2lIdkw0ZVFVMktEdlFpTW0wVzNDRlJCVTJZczZmam4vYm92UVlHbjR3RkU0?=
 =?utf-8?B?K1BWbG53TzNEbll5ckNPa1lsRzdLTFQySFFZV0pnZXBuRUhkUnJTSjVCMnd1?=
 =?utf-8?B?WE1yVTk1V1grYk5iazVDOG9HRHVmYVVHQWw2WEgvbFYwdWVCeFZIQUFkcXRv?=
 =?utf-8?B?TG1VU3V4cmFWRHF1L1pyaHkxOXVvL0hxYjlBUUdnb0Nxa1I5M21OL1RVZXdS?=
 =?utf-8?B?SHRsd0hpdG9OMGFKSkFXNTJIK2tiMTh2UTRoemNJNXY4MnIxek02UUhhSTRE?=
 =?utf-8?B?Y1NwWVZJejRRaFErMDdja0RacnFpbm9wbUR0YUNRdEQ4aitYWUlJTFJSYzVh?=
 =?utf-8?B?NzlrR1h2MzdLWUVwZWdTeE1BZm9OZmVXNWFlOXB5aTRaaGFLNGZkWWRCSjYr?=
 =?utf-8?B?MlpJckg2SWZ5RWtSMzZlZlVqRTQxNXp6c0NtN1pSaVdaL3BLNzYwenpLa3F1?=
 =?utf-8?B?V1FnSThCWDBwd2Y4Z1B4NzNoUmRiOFdUNUtaM0FNeTFZYnRVblplbUo1RHZU?=
 =?utf-8?B?eXVTMGFXTkN3NmdmVnZSSTZVdEh4K0pONVpjZFdwR1Q0QnIwOXRMMGJkbUFr?=
 =?utf-8?B?eTJXOVVBZXRQZFNLSUdueFc4eWZ1eHpoc2VTUEo3d0owWlpsWW1YdmN3TzYx?=
 =?utf-8?B?ZnZBTDBraXd3VzNoUDNidmVod1VlSHY0YlhHRkpnWnVRSXZlWkNFanQvemFm?=
 =?utf-8?B?VXBIcmM1Nldtd1pNYU82aFBLTWpYRmZaNjF3ditKK1pmblkrbGYyaFRPa0RP?=
 =?utf-8?B?MVQ2V0VXSlViaDAyQ09IRTNEWHBXNFpXc1FrVHFlK3BDaitnTmVoUE9vQi9z?=
 =?utf-8?B?UFplcVBpSjJCWXVWWGlNTUp4WkdhSHY5b2VIR2N3bUNZN3VKYlBzWDNoRmNF?=
 =?utf-8?B?WTRWZmErcVNTQ1NGK0F6Z1FBajMyK0hBNVRYNzlVK2phZEExc0tHZ01hQW50?=
 =?utf-8?B?T2Z5bHJiSmYvMW5WbTdZdUQ2OUp5T3g2eXpQcC9zeTdEZWtFZlFGRlRLSytS?=
 =?utf-8?B?bnNvaEpCSXF3N0xVVW85aDM0aEp1RUluSXJPNDc3RnNOM1hzcVhmTDdnWFlZ?=
 =?utf-8?B?RE5iT2E0MVgxWXcvOVNGaTFJeHN2NGNSeFlmSTNaQlQ0QkFSdXg4UXZiZW1T?=
 =?utf-8?B?UzlSeEVFWG52NjlicEQ5U0FmVGtua0FYSURaRjUrbFVGbWFDUzB6MU9IdzRQ?=
 =?utf-8?Q?7nsQRigjbt91W8KLQhYjOTauUBv2aozpJj1cWPEy1INq7?=
X-MS-Exchange-AntiSpam-MessageData-1: g4bjU2IlQVEdOg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec739a7-ddd8-4904-4a5e-08dedc2b53d0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:26:18.3493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6EINSbHDuuwSpns/hpOZ8yqR+Dhc0L5Joxt4Ym6TOu2zDbNAm0gUiqHmN2vXjVjSlkmmLW4DIzCLtOyPewgpaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522
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

On Mon Jul 6, 2026 at 8:48 PM JST, Alice Ryhl wrote:
> On Fri, Jul 03, 2026 at 07:16:03PM +0900, Eliot Courtney wrote:
>> Add support for reserving of ranges of IDs, with a usage in nova-core
>> for channel IDs. This entails adding the helpers+users of the C bitmap
>> API for ranges of bits, then users of that in `IdPool`, and finally a
>> user of `IdPool` in nova-core, `ChannelIdPool`.
>
> If you need ranges of IDs, perhaps you want the maple tree instead?
>
> Alice

I think maple tree would work, but it looked like not as good a fit to
me because:
- the number of channel IDs is small (limited to 2048)
- allocation of a contiguous sequence of channel IDs is sometimes
  aligned to its size (which should be a power of two, AFAICT) - I
  realise patch 4 doesn't reflect this (yet). The bitmap APIs natively
  support this.=20
- maple tree's alloc_range stores a value: T for the range which isn't
  necessary for ID alloc

WDYT?
