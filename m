Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116B3C61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2852E10E2DD;
	Tue,  1 Sep 2026 20:19:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BEVfrZYB";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012035.outbound.protection.outlook.com
 [40.107.200.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 627A810E2DD
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 20:19:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdhKqDAplhLoAKmqYYG9YwFOXjpFKpxDiTQKOzyCBFKMo+MtzQqx+9KDrbpCQalNLh07ZamX9l2xG4JvGkYMXRM1XMz0M5ziuN9J2Brqa4sMuTy5TlMv27GGwYdKDrsnhrDhnCep3/Huz/NWi6PNIucq6SWG8Za8VF2lx4m1NdYtkgHVO5XIVhp/iyYXqNjYb6/Gu+P4Zzei4/174h8E7OPCsUDyqqUxlEd6qiknK1zELFYDs8/yAuvfPe1eLami/un/NCHv7HbJqKFtELGZSsXxmZCenGFbJLi0baac3BftuADVg7umLdf3RA7Uy3BUthmWI08VTwRrEF6+cTgD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yRpwrJSBL2wP1dJJpZJp84zZDr0a+S6O0rNrm5Obec=;
 b=hja74mCEiUFf/r11m9luLR80JBnEcepFiX2n0HrGptMJXgjIH8BqtyKWUWeYNI3epr+Of/S6nQNst+bfnnCamG80a73whB9uZDg+hfrJDddqx78Ci40vvmIcKOnSZ28CFv41Wg5OVDp1NNw1NAV6yuRU8aXA6ATyrha8BExBdb5CzchkYt8SYkuOuyiEc0UVWBgrSLA9IdbblUhaLpF5d8HYOlTAoyH/s53a/aK9HDpFfnulQxJ2a4YYwuO6VtIWOmI2x1erdTKcjzlRjsSCeO0VWWDRx6auhhMn+v4LTo+k13sX4Gjroqrfi8EhKlxh4MeUM7W9G0UXipyG1QNN9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yRpwrJSBL2wP1dJJpZJp84zZDr0a+S6O0rNrm5Obec=;
 b=BEVfrZYBMyAzzgVsgP7HrATVhjS08JIJ1Se0/3YSh3MxcqVRb6cnfDzwbImPUPXpqQn+RwXAJ/ugM2zyeb+ICjYW3ar3XQgfslcl5vQalNcUYwSdQwx2zAX/j1mO8LKF++atrvkSHWhE91iKoZkqPBV1dgPXgGnIwk6ItlHi7Quj4jQ56WJHehK7sAZcEMNqC0a0lQbPz04Xke+K7QaKm1umboZ69zJHQd68xe53C+AI3X4Hl0HksWOUoJpHwL3WykE8gf5LUzpyRhtV6eLjxow5BpDjNYjbJWaDnoYpYEEeuujIiCNaOB1CI03OOBv/fU9q90ATdNY7Z31lkzJBtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 CH2PR12MB4184.namprd12.prod.outlook.com (2603:10b6:610:a7::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Tue, 1 Sep 2026 20:19:02 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 20:19:02 +0000
Message-ID: <a796c716-4db0-4bd4-b69a-accfe0d382d5@nvidia.com>
Date: Tue, 1 Sep 2026 13:18:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] rust: num: add cv! macro to create values from
 constant expressions
To: Eliot Courtney <ecourtney@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Yury Norov <yury.norov@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, =?UTF-8?Q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20260901-cv-v2-0-446bc69d2ade@nvidia.com>
 <20260901-cv-v2-1-446bc69d2ade@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260901-cv-v2-1-446bc69d2ade@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::11) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|CH2PR12MB4184:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a823fa-2200-4937-c4ff-08df086642c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|11063799006|56012099006|4143699003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fqeOiWBk3x34lOLJztj8iydNPU0Ix4oViFH4oHqFLBcAIuez6PcTm+hcZhsO16GfB1x8mq9FDRV0BYhAoXFUjDzHsR6zzPHcJY9Jg0UjVxML/zAfPLGrWNtle9iGg9ylOsUf7TQbolBIt3QJ36mFLLIu4D8QOVGsrBHvVpZFaFEKPTa0U0IdPMlJDjHWLKOrIlXKEBlsz1zTAAKQtpkdKfTMUFBkO69lmmBDGA56KODwuQxZ9j4sNQu1wJVergrNHAfSIsw92ZQeg09s1/bSoKLBgppQzORFdPaaZsPZtOEbqCulvNWw0nKibPX5bqiBALGsALX+Y3haj1u+YFeiPxlNwKQqBIixwl92ryV7vildgD4IKU9pAinDRvDzY3NfBeEA2qLJakudkhpJsUAmtbMmgbalme6Wwncna/k6MtEnZBID+1QJW5cPUOqnYNwH4BavFkdlxmvEEClBFN++R69AHF/8gxepmpPVBs/8F5HlDt8oAv9PPAXyYoXNR0dVyW0KsShNnD4zzne7ODPQ8U9jbS23KFGg5qiReN7DWq5B+QYJ0R6D6ex986m+vJycNruEBw3IgY4v8ykoOARYyK7/gODG9x+avZkk20sW4Znyl836YokM1LhrTsGc+ZnYXUjXNrWB6d9LPOzLaM/vYrAT8IRndSyeXyfZ3gjl3So0GLHN4MOFmBnc+087W9K65I4ElQ0xK/4COgTVpXJA0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(921020)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z01nUFQ2VmEwMG5mRW1jZytLdzJKVitNby85ei9MaE9IeEd2eTF3d0RSL3NN?=
 =?utf-8?B?dlo0S2hNUm54WUhqcW9NMThMbkRvci95U2tzUVNYTm5kVmkzS2R0bURwNlk4?=
 =?utf-8?B?NGowVnlVRUNFN2FJVTFmYy9FMXJpM1N0SjZJZkQ0ajAwbXBCMW9kOE1UVnc3?=
 =?utf-8?B?RFNBWnV0S1M5c1Q5UW9uWURRckVKQmk0WjBmWVdVSzhPNGdQaUY5Y2xYZTR4?=
 =?utf-8?B?blk5b0Q1YmVjOStVUjZ4aXlxY3FISDNBK3c5RWd5UUJpZUV5RFhLZVNPbE1v?=
 =?utf-8?B?YnVoZStBa3lGeSt5RVJ4ZnNnSnpGYVo2UVNLWG9xVFJiNFVlS3pwUGhML1Zq?=
 =?utf-8?B?NlAycCtVcHdFMkRmN0NIdGhUVThnK0JTeVFiaG14THVlSkg2OVhtQk9Cb0Vx?=
 =?utf-8?B?RDlOcWRsdHZNMlFYTjVkcEduMVZ1MFZGTGNMQ1dsajh6QU1oUE8xZUg1MWtZ?=
 =?utf-8?B?UlhNZTRUUVBHeXdDYlNDdllkMlFrYlE1YnJ2aklnOHZ6emgvbElkRW5HWjZa?=
 =?utf-8?B?d2hRQk82SXVqUnlWcTRhNVBQamVIYU43ZHoyMnpMTXljMTY2dUJkVkJKTzI1?=
 =?utf-8?B?cmtVb2E5V093ekFhLzVYd1JFR3FKUURCeFBQMmt1bldSa2hUd1VrcHlrcUx3?=
 =?utf-8?B?RDFRU0xJUVgxOSt2cUZQWXhuV0VSdTNndWEzRGw2OWxaS0FSSnMvM0E2UFdz?=
 =?utf-8?B?NitMS0tuRElpcXN1UWY3QnliejBITGRWRGtTYStndDlSK0RUcytmYWlGcEVM?=
 =?utf-8?B?dHhHL2tCZGVVYWVFSmFxUGRxTEdEMUVtTkxsekRqS1ZxV0JHaXk2Y2lsUVRS?=
 =?utf-8?B?ZVFEYy9PR2tFTGdkQ1psUEZKZmVaRHJxUEJyc2oyWStZbzE0TXkzeXNZLzNJ?=
 =?utf-8?B?UnhONkdJWEdTWDVqUnFJNS9ZK1dpMis4WndNNFhiV1N5c0RFQTA4ZjFITjZW?=
 =?utf-8?B?Tm1JdHFady82akUxMk5PSnl1dWRnSXhEYzBqNms0TlFNTHpPdjI3aHBLNERX?=
 =?utf-8?B?clFHSFVwOHBuR2tGZ0tCbjc2ZGNlQ3lPekNWOTJTZ0htVzhWVEtJWmdPVHFG?=
 =?utf-8?B?cXh6R21iVnRLbXpUSVE3cGhwWVFYd3lmMmFReHdwelF3eXg3Y3V0OXB5SW5B?=
 =?utf-8?B?cFVTcWV1UXNIa3lLcFZjcU9OOGhsalVaRHRpaEFNVlFNYnJDVEozZ1JBU2xB?=
 =?utf-8?B?K2dOYlBZR2RGRjlWTTVZUlhpVkFyV3BKYUxZUWtHeXI2YXV1UEhZQXZNZnVT?=
 =?utf-8?B?UkNYZVhrM3ZidzkwcDQrbVNHbnFWNEFySldQWjV2UXAxYzRBM1J0Wm13UlZv?=
 =?utf-8?B?WmNJYkFLU1ZTNXdzSlZZUTc2N1BLSWpMWFZnUWtWWE5Ec2pzdDRFT1Z1R1V0?=
 =?utf-8?B?S2JwRlNxbFJ3dHFFaGFlWlczeVBXY0dINFNBSllQNG9Uc2Nnc3JHRjFhYlZ5?=
 =?utf-8?B?K1hVSDNid0JYRkhvZkNmV09TUWFQbngrdnpmeEU1SkR0WUtVdjFQeExQU09z?=
 =?utf-8?B?ZVB6RU81RmdUZ1pHT2t4TjBqUUVOZ1p2QjZrRXBQVFloeHhHTFY1eEd4M29E?=
 =?utf-8?B?WWpyM0VzQ29CSGNGcTZFTW9WdVA5UFNKMVNwT3R1aGdPc3Z6ejNhUVVXdWRW?=
 =?utf-8?B?QVhNT3FPMEtqQWYzdmZVZjZST2FFSnhUNUlSVkFYYVlqbCtJZlBlMzRPakhH?=
 =?utf-8?B?VGNnOE5PTDRpYUVBN0xmUkhQUVRJVFkxUVJodHBIaVo0OFdlK0V3cjNhR2Fp?=
 =?utf-8?B?NkNPRlM0UUxZK0xvU1czcjl2SFNtU25zbXhRVHRBUVhvWUtNcDJpdnpGeTRz?=
 =?utf-8?B?T2Q5UEhnYmRRcE1MZG9oRkkraVVGeWhrWGlvMHl5aUk1ZkR5K0lFaHRadDFW?=
 =?utf-8?B?cXJWc2pPQmFZd1o5RHZQMThQU1M1U3NpMXJ6M2JiTll0R0U0V0pYeHhURUQz?=
 =?utf-8?B?TTd5Q3BJUFg3MWdwTkxpWFM5c2UrMENpRFZnMG9vd1djQ2dNVnQ3NVhqcVRM?=
 =?utf-8?B?ampRZHVqOWt5WjF4M0tjdXU3Zk5VOTFDbEpQMWtvaFVaRDA2NVo3ZnlQQWRw?=
 =?utf-8?B?NTZpN3ZoSUE2eW1oUHdNcHRwbkJuVUhtWVhYTms4R0l3aEdDTXdXd3BDbHZG?=
 =?utf-8?B?bzJZQmdYcUhOVUMzRGxaeWdLVWNqcUJoQ0R0Tks3akFPaGJxeng3MWtBMERN?=
 =?utf-8?B?YUthN3FJNks0ejQ0SkN2SnVtVmdVbDMrRksvYUIzNzNEd2hLdnA0UkpkRlJj?=
 =?utf-8?B?R2U4Z1VlcWEvMFZES1ErRkNtQmpqeEo1YitoY1lRa1dkVE1EQytsb0YvL0x5?=
 =?utf-8?B?SkFIQzJPWjA0aWlTMGJnbnY1SHh2U2hJK3V4NVBtaHdZNnhoZjM4QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a823fa-2200-4937-c4ff-08df086642c2
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:19:01.3991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZyT5zMt4NmUK+9zQc3XqNvBQ1OhJpDpCE+wEdnHFHWVkLelnYmqhXvzPFXQu1YEJsQWUc8jiSU9ZL78gorkZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4184
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

On 8/31/26 10:06 PM, Eliot Courtney wrote:
> Currently, using NonZero/Bounded constants is quite verbose. It's
> unfortunate because it disincentivizes using it in interface boundaries.
> Introduce a macro to make it nicer to use. The macro `cv!` (for constant
> value) takes a const integer expression and widens it to i128 (at build
> time only) before passing it as a const generic value to a new trait
> `FromConst`. The value is then converted and appears in the
> associated constant `FromConst::VALUE`. The trait is implemented by
> NonZero, Bounded, and Alignment and lets values of each be constructed
> from constants without a verbose turbofish syntax.
> For example, `const { NonZero::new(1).unwrap() }` can be written as
> `cv!(1)`.

Remarkable, in the sense that it seems like an oversight at the Rust
language level.

Alex, Miguel, is this worth mentioning at Kangrejos?

thanks,
-- 
John Hubbard

