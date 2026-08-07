Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6071C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 14:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16B6910F4F9;
	Fri,  7 Aug 2026 14:04:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gltewjL6";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66BEB10F4F9
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 14:04:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JS+E0sgjTceh4+7Ko8uWhyv4N3QbwgV9AhNWNUXELCZV3xAwJA5RuG7Ihs0D7tTEEM5zQJsSFCr0LNIFaVBSmSzbImhqfZsPki/g8qiDIeRLBA9J/SyvQlhip3BqGvscw9ETH1cYQym6I8sx7sHC+QQXHywcAK5dySOOEkhcfS0h8mg4EBI/JNboGPOIYKwzXPnRzCF+uoPsj5A9UGFuhWI8H9tXnukz0rig+d/h9vQfNgfsMi5LonjcUUJBUB+Tsf3fnpJiyIP4Kim0sMX6w3FiNsJpF4DQaqCNEWdfIRLJWN9d6PGC0swqtzaWbagrd2UwQueRUsMCGssiea40JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOyX3LWA7mA/tkPrHvelLta3KPfueUkikM/gLaKfTz8=;
 b=bfCf9t32dwuAi8j3CGmEj3AUAHd8MQ0h2eTIy2lPjkTwQJ29uk8GedHCbHOLuu8rFIJlWjMTTLkFjjvq1kwjOBwIov2kzJzpEApJwyvssQikhRBLE5jVO6QnKXgaDpcjDpoiG+KWBR7B1MWhIXDKZ2SStX8ypl/C+NV0/cdxvW0wNeyzsfIWHMayzr1iSOiAA+hL/L/UuL1Hhz8xE9bARrBmwGWlEpJNp9TWD6DRVoInrqUwu1WFoNxvy7qi/yiYNQCckfHyVe8mUuGPJEVm0ZMXm7Tj5XD8ycbO4zyNITPbRsQ8CowN8fXhjzcq93MU5Tlel+IKBFW6DaAFWwBwdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOyX3LWA7mA/tkPrHvelLta3KPfueUkikM/gLaKfTz8=;
 b=gltewjL6eSVyji49qDt4iojIIibccikOkgADIdkwQfhybe5u7ReMngYXC0VaeecZmjdF76Dg5MBrKudetmeHnoR517P0nkbHJynk9hiG/PKLAnblc8CUZw3yaoOVOmHA0LIWRHQgkIF7y2G4ueZ1HtNZe5ncfOjS/V2+iCQR8jZotmH1JJBAObmYA3ZKk4Xd6BAdcXbcPK89/EFHBzEcfRrEXwjA6fkm5Th1RFoLoE05lqPK6VIX24KSOb0hLsBGLcrOWKzlgPofFD7LG8w8dlTg2rhb/s5fI7OpF6sEktBLSIG+wL6BUKMA6oUVA/K6E0PIfBUA8okjqPdVb1EQ1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA3PR12MB9157.namprd12.prod.outlook.com (2603:10b6:806:39a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 14:04:11 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0292.018; Fri, 7 Aug 2026
 14:04:11 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Aug 2026 23:04:08 +0900
Message-Id: <DKIRNZU2XQNE.19XD9LHUSR80J@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Tamir Duberstein" <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Yury Norov" <yury.norov@gmail.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 03/12] rust: num: add Bounded::shr_exact
Content-Transfer-Encoding: quoted-printable
References: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
 <20260805-pramin-split-v1-3-ff3e84a75dac@nvidia.com>
In-Reply-To: <20260805-pramin-split-v1-3-ff3e84a75dac@nvidia.com>
X-ClientProxiedBy: TYCP286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA3PR12MB9157:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a989c13-ef4f-43de-8268-08def48cc1a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|10070799003|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6vNLTgOkFhLrULYNAWgOpyfAWBpzl0FLklyKOkmIii2LiRd+MAa3boSkQObvyq3U+Q6WZqHOvsiGlsCQn46VhoJnfNGUrw6aWEFBp19fR/7RDrquoNlptiWwOFIzhtBwZOmEfqzmqpGwWsV9mvmOfOUUsqZKlcinR8ZJFYzLcLyXgAkRltweiUW4nqPLJDNMPPgTCwo9P8gscvS5tsh9+cFnDlOweV4Y7aR9v1kbjTqplfScUHxLJ/MhlIBcat/tuQ3VzQBQljIHkECYkgiGKieFbowvzPEwi0Ciq5Z6ljKjYo6q6Ay7yt4B/4lCcoVlXuEkEfJBnsYezWMYsrXPD9NNZrwwU8gpNbcKo2vPJqAY7vhBSnWsmb0X5QdHd1vYsC9vfkvTV0XMOHS72j+hmbuHLz+y2hidkiWRhdVJfeERFCtrZ8hjo9HJV3m1D1p+DNutWXKE+GF1tD3838srwAcBJI2PEzSW17ofPpZ+xNzxzp1DdQDawEqqeQY0YdsMeM6S5dSXLk+CRy8CF6qlSU2OCo2dWDSLwkLoGsSKCoYwhj1LBmpEY+oolbu782ke2cd2WvpNsQ2gTD023jGZ99soc1xsaB62abISytbrtnUOVG77kH5Tne2X68gRvEjyFlJURt1wDtqF9ylQYtM8V+a5kwQUhnNFhx1xWjAnm+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(10070799003)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmU3dXlGVkNZZ3ZZczdLT1NiM1ZRVTNaWG9yQXc3MVFpOUlrMWxhVEZRY2FS?=
 =?utf-8?B?L0JlUmRqVy9tZVJBMjRVVnI1SDVQVnJhckpYY25Pam1HdTNPUEVrZVFEOXBW?=
 =?utf-8?B?QmswZ3Bjc1NuRStidlNxbnFLUVYzY2J3STArUnlPeTBpWUhOK2Zob3hzeGU5?=
 =?utf-8?B?blN1MC8wUUlWMGdKdDRjNGhhMTdsUXpSMnUrQll3K0dxSTEyWEowSmNxODVG?=
 =?utf-8?B?TUNDQUJxOGs5M0ptMFIzZk1iMXBudHdBV0tJdWU2T0xTNWt6LzhHQTA3UWFp?=
 =?utf-8?B?ODFwU2Q4eVU3R3F4b1lHd1ljVE9UVU0yVG1Dby82WGFPL2ZRcTc5TmhoUE1I?=
 =?utf-8?B?U3NVV2plQWxvQkxWQUJqVExjYXhjT2M4bXIzaE1QNmZpNE5lL1g4MjF1RTJz?=
 =?utf-8?B?a1hOREZHdHo4RVdiV01URDVGUUZyK3VFV3F3SGJFenovcmYrY1drTzhNRFNi?=
 =?utf-8?B?ZnJxY3g2MWZZQlVVSXpla20wTHIyVzB1OUtTZU1uLzJTMHJsRmR1bDhWTUMx?=
 =?utf-8?B?V1FLWk52RkZuQWhYVStQQUY4blNSODl0bUZmT0ttalZUalZ0R3Axckl0b0xL?=
 =?utf-8?B?aGVLajZsQTJIc29KZ1lFZjFnWDl0VXFIeXg0U3E1SHA1T3RWVWpzTlAwWU9i?=
 =?utf-8?B?Szd1MVhGRVVrb3VwN05ydDQ1VHFvWVFJWXlnemlhOUtBc2ZtMi9FaXRvNVlC?=
 =?utf-8?B?Nk01THc0c3FEZnN1NHpWeVBEaFMveHhYS3NrT1NBSmIzQW5ZdEtkQUhNYjFV?=
 =?utf-8?B?UTlJT1I2MXFQYVdHeXBvWUtSQTlsUjYzSjVqYU44MTJNSERDenBFeWFxc3Vy?=
 =?utf-8?B?UjNjNmdlazBabnowcDlGM2NoRzJvcThxbnRGNU11ZTFzczhEMHA1RnF1a2o0?=
 =?utf-8?B?SWZ4VjJoN0RIVjFSNjlxQldkUmFSVUZIbTVZUTR6QWFHWjlvNm1JMDg2R1Zz?=
 =?utf-8?B?ZGgyQzVjOWlCMjNLK3B4ZEN2eGlwbFdhK1N1MDZHeWxEdDV0c3JjNjU1YW0z?=
 =?utf-8?B?TWVxSDRGdGxoZURpRVBQSHZacE9MZGJEaURmaEVIWkU2MUk1QmY4cXhKR2pt?=
 =?utf-8?B?RjdzLytWNVRXNm96U3JCdDVhS0NhdnJUeXY4T0pZVUpWY0djb1ZHNFFtVVdU?=
 =?utf-8?B?cXkvOE4xeFFlRUZtMXUzelY3Y055QW95Y2hLMEluZDhuekF0Nmt0QVk4TXBp?=
 =?utf-8?B?Q2N2bDJHZUFFckVhMlNPRzMzNnJjaVkyTFh5eEkwK2xhZVY4TnhwcWtxMXpP?=
 =?utf-8?B?c25sT0FyOWdFSHJPSmJ1RU9vSXQzamFxSGhJcXluOHVUSTZMVnhMMHJGZUJw?=
 =?utf-8?B?bjB6Y1AzeC9HUXNwVEZYQjUwMVVFVjVYczAyeUhYY0NtWm02emlHdEEvbklo?=
 =?utf-8?B?NUQyOGliT2h6L3dqenhHZkk4QmZpMWNhL0hHaURtM1drTGIycFJwd0NsWkI5?=
 =?utf-8?B?WjFIdXJxWkQ3dWhGaTVMcm16ak1xSGtqSDZTeWliVnF1RkFaVEw0SGMyVUJS?=
 =?utf-8?B?aVdVaXJyZkY3dEVTc3drd1RvMzFHcWc3dVZoQ0p1TkZ2QUxSTXI5Y3BxbzNh?=
 =?utf-8?B?TzNQc3VLQXFKZzQzanlaclFKUTZVNU9OQThvUENyTzJtK3l3Rkh1SmRpUGtP?=
 =?utf-8?B?M2dkRHpuRzFVSU8zNFBtcGhhVDhkMVFGSnJOb25zcWVZVDc1WWxUM05WSlk0?=
 =?utf-8?B?ZTA3ckpTeHA0M0ZOU281N1hMS0Y2bEhYTW5yRU9WZW4zOFdVN05jcU9ZTUJZ?=
 =?utf-8?B?QVpkNkVhMHo4N2h4b0ZSZXNmMDNEVlpvbmFjNmZLL0Z0VjhnM21rU2pjWjFW?=
 =?utf-8?B?MTZIWWYxMHovYXl1UUpHUm9aYXFLWUNMR2IyMkp5NkhhajhBQU4vTmlLQmx6?=
 =?utf-8?B?WTh5Q202UUtVMGVteFI0YVcra3dNN08zYkNVYi9QT2hla3ErSzNzVDFURnBu?=
 =?utf-8?B?a3B6dlJoakIvNXJpKzdOQmVXLzZQSkNZNnA1N3NCY3NXM01yNVhjU0NoL3BK?=
 =?utf-8?B?NWp6RzIyNHpKMHNSaU5qRjAxNmdpMFVtN3E5UzBTd1prcHdjS05KT1JCbmxa?=
 =?utf-8?B?cEhTV3hWSDVrNUcxVzE2bksvejIvWFlHUDl6R3E4SWhmN1k2dkZYTXFxNDFL?=
 =?utf-8?B?SW44YmhkNS9qRXM0VnJKdkhlaURVWTdmZ2tYcFVnSVdVMTcwUUpxNW5HWC9C?=
 =?utf-8?B?RXU3WmpWRmRvM0tDWGV3TDBQSGVaUkpKd3lHTkVVTi9DMDVlQkM3TWh2RWhs?=
 =?utf-8?B?bE9ZbjNhUGpzVjEzdXhTMTZGQ2NQRUZqTmxjbnNraXpsMDYxMmF1b3htWjhM?=
 =?utf-8?B?WG9raUp5MTFqYWlVeDhUaEU3TG1rRHc0QnlPakR5Tkk4b1VUR3NQRUMrYU1O?=
 =?utf-8?Q?9Yrt0S539hKE8X2k4k2Rqx/bg7UYovH1F/Tsyft8zdipz?=
X-MS-Exchange-AntiSpam-MessageData-1: 574YuW1PLbq11Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a989c13-ef4f-43de-8268-08def48cc1a0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 14:04:11.6031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FbQeoR8F84eOTurS/FrFNaDTyR+dtoJoNWumpt/PKlfA1eD53jgC4AwYDSxkYkSkpCNmTuoO+pplUtnxit4RBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9157
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

On Wed Aug 5, 2026 at 2:44 PM JST, Eliot Courtney wrote:
> Add `shr_exact` in the vein of `try_shrink` which shifts a bounded right
> only if it loses no set bits. This is useful for getting a shifted down
> integer while simultaneously checking that it's aligned.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Maybe it is worth briefly mentioning that an equivalent method exists in
the standard library (in nightly) for primitive types [1].

With the missing `#[inline]` mentioned by Sashiko fixed,

Acked-by: Alexandre Courbot <acourbot@nvidia.com>

[1] https://doc.rust-lang.org/std/primitive.u32.html#method.shr_exact
