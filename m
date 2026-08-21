Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53F7C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2150110E2B8;
	Fri, 21 Aug 2026 14:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="cC9SCOdl";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07B7A10E2B8
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:01:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHEW6fgxRrEdXDdurghZ8iC95nLbtTjgV9eOqqSOqtPsOkkpgY+0+rGKhb0qgvl8bTbBpOC5kB4E4Bc1uYgnxhYhlrEfGlihCn46AATLHTj5icBc1UuBGmRTeMwdAkQbz6Ey94H6vFcFss/PnY48mIzlw2Xtj0Tfco15nljzKvbQH0LLe2nLVyL1maYfgvxB4eTQ/ABGrZsrYpYgermu6waQ/5KmmtiNx8ZXF6TgesmPjaf4ER6JYxmVdkJDIhr+b9GWJMVxWLtN5XEC1dB/LFZcCMOBocAscJCRosOi+G37M3T+8OMSO64J0/o5VrIuMPC/46OIhl2iNwb+xGjASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2w7zA0l9DiuhHR5gqP0e1TbV8w5OoIh2bied+Y+TFrE=;
 b=V1IalasH+C8du/Z9dTzz5amB3wAmKjiAVFah+f5wNfDLGxOGFuE44T4YPkhnPOMhX7jRveW03aRSLXsEObnEpnHnzaqO560EivUhbKIrtxrEnzQQ13gWgjhSPkWaUUxKXaXosu1qB113C4xdMRR2TskkmZ5P9Pq0rQ6kfeg33H85qUjAxRSH+/aZzij6cyApEtAJ38zDCNp2Zetnag+AKPqC0gEZKY6gxlU6rA8dt1mb2BubXE5jU/uuGTSOmoAa8aPmJKBiuSo8DMKmRPRDS9pB6GpUceITfC1gjAonbTAY1VBqQDO8gIYqxExeJedKKITxRjshfAxyLgbuIBcmfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2w7zA0l9DiuhHR5gqP0e1TbV8w5OoIh2bied+Y+TFrE=;
 b=cC9SCOdlKMYgCqApvuEF+Yz++se50FTAQDQSbJ6EShFA9Et5M4C7+LPDUs9bPShiHfmmUi5mCcubREmdq3PcM4qp5r+JY79YLpBp70MNwkNIcjTYJd/QvMBgVdqPTVVd9lNO+k/jf0xbPENY1pxQtrXCdoTVhRWQrOf/ZCtUmRFp5zLfEMpzHGmW/KN1JfGEIZHto2Ke9ZWiBxMpoCjgr0OsPQkEZZRQq+g8iqecMpAikIB346sVcS3LCtz6FLgXLvAxF8oybUzA+WkFjrZgQuWd91UNGatmeyuYxFPMf6Pg4hWcRJzxty2U0jgynTJC5XpJ0Gahwy8/qBXro51Vwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ2PR12MB8925.namprd12.prod.outlook.com (2603:10b6:a03:542::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 14:01:34 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0339.007; Fri, 21 Aug 2026
 14:01:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Aug 2026 23:01:30 +0900
Message-Id: <DKUODLYRNG9W.94VB048U76FT@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 01/12] rust: num: use const_assert! in Bounded
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
 <20260810-pramin-split-v2-1-65a00b3c7309@nvidia.com>
 <DKUO7T5FN47F.3J21T5BJZ6Q5@nvidia.com>
In-Reply-To: <DKUO7T5FN47F.3J21T5BJZ6Q5@nvidia.com>
X-ClientProxiedBy: TY4P301CA0059.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ2PR12MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: b5822a18-c822-4c32-7d81-08deff8cb565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|10070799003|1800799024|366016|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ujGJ5xCN0KymlGCoWFnoNzIFu5tG+VhsftZv2J1JE1cazTcnNtt8XLE6YhaSnfUTx3Jc+blDUuk1FVUav4gGIf8K7k/eSNNewV7yaNJC6n731V+2UvjcOvF1FyFiwQvp09JlQ8bR2RoyTL0b2MveGT2oon4hJ3Wgy1NOmAbe7oGfMjISTLHRsc451aTL6PhPaNQbgwjwmpZRYkKX/q1VAC0ShCSuhlTxLv+mzizb6NVAA6hr8YhdrAqLy438AO3tkjJF6QdHtNBkOrPDmulgCGP1VQcyVtQouNY3PKcJiBhgdsJU5AjtdSuMuI+jzrP/Jlo6QEt7JZmYiD48dAV4ThLHiEsAGJxywfiY5Y3o0G6JjunECTSaJIYhL4R3GwpJJ4doy44qJBj9J3TlI7MCWTtrej/qQaKXfnUai51waxDmkqPOq4eXJKlJzmyCB1t4IaweMObozR0ENNvlm3NfmB2YnlNq7GRC8Qqgm6w40wRc93whxb7NmfYqmww5ob7c+vGbFY/g+Nd4O9rjqLgIw1FD2Ht0kQpHp2kJeRdN1PVi+8DT9ujw5RbWRfIpWgQI9ta5S+VVdTw/EMa2LGB/diiv7nnKDVthTuq9hhSq69XnMUraddxexqS/7rb6fkMbdWEOjgLZV4iFvTv4d1GfMJje7874Az+AccmWEjrYVcw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(10070799003)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHZRYnB5YXZNdnpRNkZyeTg5NXE0enFrYzZKY3JuRWdGYWRpZjdDSlY4UHkv?=
 =?utf-8?B?QWR0Y3d0NSsybndra0dxVnR1N3AxRHBTc1c0eUUwNW9WNC9SUE1jZTJMMHQx?=
 =?utf-8?B?aWgrWFFYTk0zU0d6ajV5cE9mWER3Si9pN0FFQjFIcWxZSDFZb0FHbUltSHYv?=
 =?utf-8?B?bDJtTW9vSGF1bnZWeU1lU21ESzZJb3JkQmE3SUpIa1E5dHg3MDEvU2JvWVBS?=
 =?utf-8?B?UGk3V3AvdGMweWVYd0lTZ0JvWGFpWGdpMWNvY0NXdEN5SEhhakxld243d1RL?=
 =?utf-8?B?K09ab01oZUJHaS9oSmJ4aURWSXFFdFcxT1l2MkdJakt1emtkNVlaOE5ZTFZq?=
 =?utf-8?B?dHR5NDVvbFA4QUxHaUdhVTdKREprL0pKVzVPRXIvN2p0RUFnRXJjaURsUFVq?=
 =?utf-8?B?cGVWTmR4b1krU0lDR2ZKbFhoT3NIYUV1azVLb0NPUHRYQTJQSDhyWjRFZnJa?=
 =?utf-8?B?aElPMnFBTnFTa2FEa2c1bHcxTGJPcGlCcjlKK0RxUVhQYnRGODZMekhjcGh6?=
 =?utf-8?B?K3R1YnNHR2wzazU2TzB5OElWTUF5bzVLVGNUSk1jUFJITHMyZ0xpbit0OWpk?=
 =?utf-8?B?RlY4QTRtNXJLM1NkVTRjSFNlR25MRFRqNncvT1drM0dJSUhRYm8wQklTVjhI?=
 =?utf-8?B?a2JMc0I1ZER3ZCtWVXlGeVdxRXF0UHFBeVRROVo4bjhxdmJKMDRaZGs5V3NC?=
 =?utf-8?B?ZWdYTW5jMUJ5VlA1Mk5SRG5zNHNJN0YyNTdqTzFFdG5NNjhTOE1Pa1NuVFNR?=
 =?utf-8?B?aDBnUVo2ZW9oMXF3YXZKN2Y1Qk4vcGhLSjk2aW5FdHNEOVptYms5OSt4STRF?=
 =?utf-8?B?bWpzMlBaa3hId04zTTZXa0VqVy9rMG91R1AvMnNyQmpHQU03QTBCRkl4N0Yz?=
 =?utf-8?B?Q04ybmxzRTdCeXRlb0VEaUREdWxFTzZaRmdXU0UwYUVQcU11cjRPZDdKUSt6?=
 =?utf-8?B?c3BuczR4UDliVTNlUmJqeTlhZC9YYkEzYkVqanBqOWtKOFQ2R2ljaFlpZ1BG?=
 =?utf-8?B?TmlGZE9FQjl5QlRDREdsODZVMXhsSGtjT25mOGt1ZFpqbkE1d3cwZ2lpUTVt?=
 =?utf-8?B?MWxzUU9EdnovTlhTUXViUE85b0ovOXFGcXhub2dRVnBIOUpGNmpKMVVzczZn?=
 =?utf-8?B?d3UwN2N2d2h2b3d6c0psT1N2bm5BeTRoVG84cnN1ZjR0RHE4ZVVFeG1Xdy9H?=
 =?utf-8?B?QlpZSE90UlFNcURvLytzZXpBczFEUk5pN2pFZkxubWNoQWp4RGs2MXJwK3V5?=
 =?utf-8?B?VkRZZlNSMk1uY3d6YnRtMDFQdFF0anNaRTFrNnFxTk1RL2pmNFJjTXdhaEV2?=
 =?utf-8?B?R0xtMlBMcmhNS0FxVkYrL0paak1KTmZiZzFuSG9PUldUejkrWUVxMDBmbjJG?=
 =?utf-8?B?OVBuNEdDNlFyRjFob3ViMjJYa25tZi9WdTJBOGthR2o5N2lKNWhCTjhON01H?=
 =?utf-8?B?cDdlckFxbkowaVVJODkzZWpaLzF4SFhhNTdWcmFRQkVRTkd4aHBTS2hCTHNL?=
 =?utf-8?B?Q1Rac2M5eXYyRDN1d0hhTVI3YWsvc2ttWC9tTjZKR0lTOThJVnZpNklCMFU4?=
 =?utf-8?B?OHpuSEZxMUNjWWl0dXFqM3JPSHNaVHdwUHRkQmNadlpTVzhnSTFnZG1SWjM4?=
 =?utf-8?B?NUtIMUc0bmtLU05ZSnFCYUdsRHQxNEV6emVTWSthZXFZN1pNdnYzN01aWVM4?=
 =?utf-8?B?aEg5MHk2TlRjYUtwQWJRc3lVeGV1RTh6dC9SeGNJelR1eXNnMElvY2NMM2Qv?=
 =?utf-8?B?aW1xUmxVYnlhNjNEKzFGNjRFRlU0ekM3RHZpWFdjTzFuZkVvMTlPTmpwaFRM?=
 =?utf-8?B?bkF2UmJLTy9HK1pHdWYvM1ZaZFFyTXF1TFFaSWVZQXFLbEgvc3dlaHZZS1Nv?=
 =?utf-8?B?ZkhobnRmVFN4eU9PMU1qc0lJQ1R2V1Axc3hXaW5FUWFpQ1ozamJXdmVGTWR0?=
 =?utf-8?B?S2RJejZkcnBwNW5JK2J5M3FJUXR2UnZjTGFhVWF2ZHo5UnR1R3Z1Zko1VHJ1?=
 =?utf-8?B?c2FJUzdreGxVZTlSR3k3RHBxQ1hSOVlEenJtaDVXL2tjaWVBdUkzVithVkNy?=
 =?utf-8?B?UURpdlZBTlQ2UjhUUnl5UFJpMnVVeVpWSC9uZUlTdjM1ZHk0TTFxZUFUUWp6?=
 =?utf-8?B?RmgzU1YvTEtOTnpkOWVzZExGN3gxQXVoQVJkQjBZUlN4TUwreWlwV3JGQkRY?=
 =?utf-8?B?UUFwQWoyRHRIa0J1VUs5ckN1WG5zQlV4bk1PSzJrRVEzeDdldnZLRkY1SDF1?=
 =?utf-8?B?WXYvc0N3OTBSOGRUV2FDY2p4QS9nTGlLWnRWYTloVitqMyt1T0labTEvZksw?=
 =?utf-8?B?MlBUQ2FPN1lZU0luR0dCRWJmUVhvbTJRVG1CV2JobW1PaGk4aTY0VGtyN1A4?=
 =?utf-8?Q?gPzthqYnoDno+biHgVYwG10QB1qRPopFvYBrzt3s/7iWf?=
X-MS-Exchange-AntiSpam-MessageData-1: HKUNWuNa+TL8xg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5822a18-c822-4c32-7d81-08deff8cb565
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 14:01:33.8411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xb2VLXB5i7UebujGxKN/08Acvv/M0rA9bfoiHryGKabNB4ToNHKm8jv5ieK+2AaZdVH+yTrt9Znzy5aiTRydFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8925
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

On Fri Aug 21, 2026 at 10:53 PM JST, Alexandre Courbot wrote:
> On Mon Aug 10, 2026 at 10:55 PM JST, Eliot Courtney wrote:
>> Convert the const-block asserts in bounded.rs to const_assert!,
>> matching the rest of the file.
>>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>

Errr this is already in rust-next, never mind! :)
