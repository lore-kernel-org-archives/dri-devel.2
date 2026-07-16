Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97B9C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:41:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E870110F334;
	Thu, 16 Jul 2026 14:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="sfekNBj6";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013015.outbound.protection.outlook.com
 [40.93.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 107D110F32E
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 14:41:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTilAOV5mWk/Dov7Cafi9FRneueEw6wVcYCBrHFgA5R8eP2Ri1DM7PnsnjfmrQH6G/1Y6s4OKWk8nRde21Vh/XT7zI5Q/eo/yqOC2muoCLuFPPQhMVu2yAMgyjA5qtyCy+wIgs/3Q0CfmxyaTtuWc2GpxgNebb9l76OK2EPgWpkx9mPi/UsfYMVOYeKRTLP3G05Mck2QLy/q0zMgtI4/QKMxA8A/q/o4hKAQvEGGTHJc9QI5Jkjgj0G6nEEaJ7V11edHeSKrJEl310FK2gnuvmrE65m+5AKi2Z39sUmy3T22onmHE0eA/cxOsnSUpxz/poNq2qOVx0r8W7/hsjV/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bH1J2I524d2tNe5CN3b6KCw/MottnMUZ61p/ADrbNf8=;
 b=rIF2t2CzZ9Q/hOQyDT8ptHwd2iaeLGzP0ec84lRbmhTL3xkVnPSyjNd3As+/jUTt5B36a1lIVCy1PWTapJQ6hitzvhRl/77c+BjtiJ2mDALxs+AGLKlvz5lH5RgSX/ZCoNi/iM7MYqVbCz9AoBGlAGIu28cAz01lgmcj0nXGmDUbjzDC+L/duGLUe/8a1qsX72+L/YfRSddESbEkVlWo/KqkJ/el1me+QigRJ9HtRXXcagcxqVHPOYJW5PTWEWD/o5YsFNGwtPBGlNZ/WjqL9hGZO5ZvXuHrI6flktWn7ML6xHS5wPZ0EiOqS6aV/9rCaKXmM2595M9/ncZzfWgK+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bH1J2I524d2tNe5CN3b6KCw/MottnMUZ61p/ADrbNf8=;
 b=sfekNBj60dMF2Zq5BQ7U7r5wcv66oj/t5bdJsxzs74bgHps0gIHCIs8aRsnzUL70ppI6RiyIQyOMb9LBqpCoaaqu+Kf6Bdb4SkTqRVpwpXyhHgRS5F0U8o3tJdhAXG6bKglwcqJ874gbUhLspUvJNzhBV9vAqYy1rXmYsPI9PnolReeQXHHGwb1t7BSANtDR1F36yMsDQI/pqyaCwG0QdLpGHsyT952lIHP5yJQf68VE0qMsN1JLnCxFvLi9Ci6NcY13SCpd3Mq/624E8jVZCUNksEf6lHNJ2OyvHK3BYbxhqXbiH2SfC1kO8aN9JpdurnDOPZD5U7Tr8ePlJLelKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB9516.namprd12.prod.outlook.com (2603:10b6:806:45b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 14:41:30 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 14:41:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 07:41:27 -0700
Message-Id: <DK02OL2V85GC.3RA06XWW10NL5@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>
Subject: Re: [PATCH v6 00/13] gpu: nova-core: consolidate and streamline GSP
 boot process
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>
References: <20260709-nova-bootcontext-v6-0-520cbf8b9b50@nvidia.com>
In-Reply-To: <20260709-nova-bootcontext-v6-0-520cbf8b9b50@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:a03:333::27) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce8d2d6-86ce-4541-2942-08dee3485265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|10067099003|18002099003|22082099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: 3a90fOtG51cSWTbYUqKrzG7XW/ehusq40oA6mrx7h8jzJlCSsOmKiS0gibwteU+v4pkOsE5Neh8UKwofB5xRLBQJj/kA0cxYvcGvWLDC9vKAiIDrujE8f+UTjKu6QqJRVRcN8y/UrVH0sXFO4hhXnBdjW0Rnun/vo6hNHrW3V4HS0biqvqzqAMY0rwny14LU5WejY4H6hcm6Ibh2lvqZXkaGSHumhbNoGqhHzEQzcEKF3PbthRGfcImJp/T/e0kiaGmlBJfcqhgPLRIEjMOdekfFaanNm4tQgtx9V/srP4yt6ks4XBYYku66thLqlz+oZNyf1Ec3OVErxeFYLv6aWLwZDXv+DMwFugSexxcYIhds6ukikC8oHO71r3IaDODbsJueLKsnQG213T4wBjJS5oaOKQKGAnBi09513i4c1ZdgNf8eUqfh1iQOt5DxFToAAmtyQj7c4rhHPzlp71OZcNYOreUDxANO/OVoYvbp1RgXczzbkvYpkSCCeJ3KTLpKYa8VBvgFsjWOwv4FlMW19GkajOBJRRgvvhrTd5cznd1zQZri/crWgOffUia7N3YtcIrseIAt8YCnDJ1P99QCdyc3ZsrrcPLdd4a8TgFhTS5w+gluW7PVwQIPg5dB8Nu6TpmojXTkG5jTQVCXXPbQcG/ME14hPDZX9jLwjJrNknl/LkErrgZe4nkDAPg102koDHCqC3GOC0z/432m+kSPRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(10067099003)(18002099003)(22082099003)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TCtkLzg2dHhVbzRFYU1KcHhnTy80UzFmLzFOUkMzbnJBOXNFK0pIcFVnZUhL?=
 =?utf-8?B?SjZMV3BGOG9PYXlrWjdWWFBRd3RiYmRZaUEzWnFBNnNKbm54ZW5rTGc2Y0hU?=
 =?utf-8?B?ck5rV1ZEdWZGYTRoQjl6a2x0YlZlcU84TGR2TVVodUd3RHkwa3NyWVZvRTRI?=
 =?utf-8?B?N1ZtTWJrZ3Z5QjlnMmpYcDdLVUtCdHdUTHJJSk83bjNYY0N0ZmpKSnZxdXN2?=
 =?utf-8?B?UEpVemdqUDlLVE9yNExFNXdiMW96bU5zRHJhdEcrVWtxcUFBYjdaM3Q1SU83?=
 =?utf-8?B?aHhWYVk1RmQ2ckg0RVdTYmZlUW5xb1NrZEpVWUg2QnNPSjBuY09aRGhvYjBG?=
 =?utf-8?B?OFg3dnFranJvL2pLV0p2ZzBmZXRQVnZPOEZ5K3AwNjhmS3h0WURIZ0Rud2VB?=
 =?utf-8?B?Ny9XcW1qZHcwTER6VjBiaWhtcXdEWWtwU1lOZEIrNWRzQjJ2alpFdDNMR1lo?=
 =?utf-8?B?U1hDRVIva2FIWHNsblFPRmxTMFovbEtGdVlkVDQ4ZWg4bmZaR3F1aVZidmxH?=
 =?utf-8?B?dm1hVHJHSkdFM3R2Ni9mbGpiWXVjN2hqUUc3dVM5L25vMnRNbTZwMTF0OGhz?=
 =?utf-8?B?RXhGM0MzVjlQY2JwYkY3bjRkZ1Q3Q0lrYXZqV0RVeWdMUW1tUzZQN2hwZUh5?=
 =?utf-8?B?R08zVk9xMzBhaU42dlY1WW5OSjNkZHFVYmpaTk81MTlOMFNlU05qMVZma09L?=
 =?utf-8?B?ak9uRkdDd0FkUjBqaGc2Y2dwSk9vMUR4UXQvNmFWS1BWZEpHTkVYWVFjeWgx?=
 =?utf-8?B?eHFmVlFuSWdmSklnTUt6dHdJYnY1SkNoSG5tUHU4cDZPYVZtdXV0c01qZnR2?=
 =?utf-8?B?SkdsMFhKVi94MlcvY3Zzbm1pY2tpdFEreDh5cTRYdEVHcCtmZW11M2Rub2p5?=
 =?utf-8?B?Zkg2b0QvQUUyY054T01GSlpqZXRoc1hrNnJBbkJHQnVJdFl4Wm44R1FHK2VR?=
 =?utf-8?B?T05QemR1MWRxaDc4WkV0RFQwdDZ6Ym84cGUySmJpeDg2WTAzanEwU1hqclBj?=
 =?utf-8?B?ODN3WVZ0VW12OHVWUUNLRzFOUGE3WFJZOGh1clBBc0hpVGlJMmJ0dDVhdEFp?=
 =?utf-8?B?S2Z6eVhWRkVMQlYyb2pKWENLQU1TRHlGTGdwc1FoR1ZOOFRSR1pndCtsU1hR?=
 =?utf-8?B?K1lLbW5UREMwVDl4ajVsYUZhQUxSL2huSTg0TW5MM0VIczVXTUR0S2M2OUNp?=
 =?utf-8?B?ak5kMldMa0RGVlBRckVzcTRrc2RYVG9QWngyOUtoRGRSUCtsOXlYcS8zUDZR?=
 =?utf-8?B?M2RoUVB1WmQ4S3lGS2J4RGxsQXcwZUk0SjBTMm41elc1RTY3bmxLSGIyVkJE?=
 =?utf-8?B?SVhDeHNEbGhOL2U0UzltUmxlWlZvbG8zUGtxdGYxSFJmK2IxdHBaMS9yU05m?=
 =?utf-8?B?b0YyMjBzL3JkYldka3FJVU55eUszT04xODVQaFRhRituQTgrUGx6Zm9kRlNl?=
 =?utf-8?B?TnJuTTF6VHQ0QloyNzFqRnM1bnNRb3FhR2J2OVJOUzkvVVFrZEdXcVV6Mm04?=
 =?utf-8?B?VFd3QnJMUUJBNDMrN0RSUXluVHJ0S3NEbkM2UDdjU204dEtsN1AxVVpIY2RE?=
 =?utf-8?B?WEpmbWd2TUFRZzJPazhIMVlLVDZNejE4akxLZDE5SlkzOWtPSEMyNjRQT0VL?=
 =?utf-8?B?eEs5WkExWEt3ejBTbS9XTmVaNFViN1ZDTWFIaDAxTTBSeENOMUlFRnBoQnpr?=
 =?utf-8?B?MEZTUEYveDNDanNPWGl1Z2pQLzVLeFFQN3hrdkFxZ0NsM3lSS1FaQXFVWU92?=
 =?utf-8?B?MXVlMERuL1hpUlhhdmcrUVdnTHlabEpDMzQvWml3NzVZdktrcXh5SDZPUHRO?=
 =?utf-8?B?QU5NWUVqdCtCK1FBWGhFVXhpRG5wVXVvS256dmdsUXdDMW5JRmcvQ1g1VXAw?=
 =?utf-8?B?M2M3SU44akxueDMzM0Jya3dIOERrSEpwL0dOTERqODVtUnViYkVISnlqQmpJ?=
 =?utf-8?B?QjVoMzRGVmdCZWpsVGhaZmpOTUl2UEFHUENLQjRkNXJlaGo0bjhSTVVQQ1Y0?=
 =?utf-8?B?eGczU0I4T1hhZkR6YnBvWEE3cGZ1SEhHdXczWDUyS0hZOGw3SjhnUHAzclRa?=
 =?utf-8?B?elRxb1Uwb1BDWFJCTFF4K3Y3TTdtcU5ZLzdjazJGR2RFNktTVHF5OVB3Myt0?=
 =?utf-8?B?akFrVlNnZGpNc0pJejB6cXVwRWVuZ1pKRUJaSjZkNlhwdjVLZndJTjZub0pB?=
 =?utf-8?B?Z2lRQ3k1TjZsd2ZGdXVzc1kvN1p4Wk9lS1hjSjEreEFlM2JPNkFzN0NlcGZz?=
 =?utf-8?B?VGJ2ckt4c08xMU5zRXZUaTF5U3p3Z0lGWGcxdlpMTEZRRVZyQ3hucDhxVEFW?=
 =?utf-8?B?MXhJaEFxek50a3RLQVNvQUtHN3ZlM1Q2VytlNHNJaHhkZ0dyT3RKdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce8d2d6-86ce-4541-2942-08dee3485265
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 14:41:29.5590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhcqrtO1UUyobkTs9vRYraMeKnxIdiX2/aDVRctDSr9DkErHHy69CLKFysRaS+/AydRrmq1evXJx6r2Lc9t9Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9516
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

On Wed Jul 8, 2026 at 11:52 PM PDT, Alexandre Courbot wrote:
> The recently introduced `GspBootContext` is useful in at least two
> other places:
>
> - As a replacement for the sequencer's `GspSequencerParams`,
> - As the main parameter of `Gsp::unload`, for symmetry with `Gsp::boot`.
>
> This symmetry can be further exploited to make `Gsp::boot` and
> `Gsp::unload` generic over the exact boot context required for the
> current chip. Doing so requires some more preliminary work that goes
> beyond this series, but this groundwork is needed regardless.
>
> Another cleanup that can be performed as a consequence is the removal of
> the `BootUnloadGuard`. This type is cumbersome as it holds extra
> references to the boot context, making it difficult to make some of
> these references mutable (as we want to do with the `Falcon`s that
> should require exclusive access to load and run firmware). Furthermore,
> it is only needed a single time in `Gsp::boot`, and is inadequate for
> handling errors occurring in HALs.
>
> Based on Eliot's feedback on v4, the series then removes the last
> remnants of the boot procedure leaking outside of the HALs, and
> consolidates everything within the GSP and FSP HALs.
>
> This series applies on the latest `drm-rust-next`.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Pushed to drm-rust-next! Thanks all.
