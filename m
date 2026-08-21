Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587A7C5DF87
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 07:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4372110F25C;
	Fri, 21 Aug 2026 07:39:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="GvbKjNFU";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 390E610F25C
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 07:39:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFcXEzIR84qElbwcm+4NIhpfvYOHFEg7rdL5A1dupqfLXw/HumGn8msThGvgJM1cvmv7PSFfIJ8hfUqwQ1GnBYsjxkmagyltIwy1ZNZvKgjooh2NmwZF2D47WomuYiNVotvfI/1xhvU7TVjJApb+9r7W7Vkn22HoTuHFRMAxaicbgswojSxQFVT5V5vn1Yri9JcrYXPVlhBfl0F0Y4/vy3sbkeOO1jYa4/Mb2fVb5gBw485ZYvp4R1uQ2ZyE76KvkoaKIGDVmyx9rqNoKGS6v+yCv2FnaC6p1+K5sScoyyK8ualgqvSa7+61S5whtAkhNTTRWiWell0ncR7HHqDvWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4I6TmtZSLij/VPp1R2t6jMFD+rY8VPjXtv8ff5WYmJU=;
 b=RabKkkQI29oBUmKpS1mW24rbggv5BgE1sbZYpmi1tQQZEjk2mtq8lMEj9cCUnqlNeo0FaXrgszETL0rTfuuNAQy8kIRxX9PxNpvMWdvJ16cbHaiwcGq82jXPil0rNg3sVBE7Ll9qp/tzfsGhk+cj3V1e2V+LBDLLm6bOInX2n1YY1StUnQucE8HODUbR26OmTcRtJteDiKtgoLaUVT4sjUxaN+z8J0u+pSE5Q7xB2uq81z+1S/ib55Ng33UqYQpK2BaGFwPi6JCO3o4yhXW1sIj0WJGNaGo1d8GbbsAgs0C6cpjt/0BPRlafQjBtlZ9xHB8lUmqrJ8aMcYTMVkpAyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4I6TmtZSLij/VPp1R2t6jMFD+rY8VPjXtv8ff5WYmJU=;
 b=GvbKjNFU2ZtrTodi84HfDJHCLOEgQBV+EsNy8CglbbXWb91cFhnOsqgT9ZkMrziTiDz2+7WgucuGN9nBBXdlZE5sb4gvfwnBf4dHN7nARi7BfgsqIy9gjmqYT772b8YT+yTHeb4n7+3d2GLHN+kklNTxWlEcKjsXZ3hdsnOvKL3tUu04s4zoD6R3b9gBxxSP0xKmfHZHO7W6AN3zU/9qgQrqD4VlD1HBlLRIJGEA1IWXj5AW5krefnEQURJzH+hL/1N1XdIzaD16a7r8ewV6ImEAJyASc0SPa9RLbYVRrluOJmLSy1yEWNPLlGOn/gVM8G/6lLzum6Xtwj0DECRiAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB7843.namprd12.prod.outlook.com (2603:10b6:510:27e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 07:39:41 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0339.007; Fri, 21 Aug 2026
 07:39:41 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Aug 2026 16:39:38 +0900
Message-Id: <DKUG98C82FJB.9NQFRNHRAT93@nvidia.com>
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
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v7 03/10] rust: num: add nz! macro for compile time
 NonZero values
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-3-a5872e64d8f4@nvidia.com>
In-Reply-To: <20260817-chid-v7-3-a5872e64d8f4@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0124.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: c3da5269-cc05-49fa-20ad-08deff575c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|10070799003|366016|7416014|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: O8dpwrhy+GLIQz6EQObh16jlbkPNEtnJPyu4nSFiGycd8qXN869t6RuO4rHfyK+2K4ly0MFICtlWuSrq7R9+h6CYnHjI4eAHeH9+ZMFdfi9N3n1EzCMlBAZScKN0VYKLrbEUJ4seb7suEiy5Qw7sUeSf80sjoosISDNLA/f8wqL5qnH5gXMG7/ZPbA3GACuJe3fsaEyp6WKrgdmvQJiqNjqcJUpqWHsJf9h2wfCNtbja2W29uGNKLhdt5ZxtxkpFDoXA7vl0Ed/X7x9wiRG75h3DR/8IlDfIti+YBMsSDN6OUYrO/SFcN1XIj/4zkNqB6/pgbQIfFygF49PJygRDnC3ebegrxtDM4sOY1CSLHbS0sXwgdoyI1S5Z4YmoC8qjqAudyfhE0NnuF6ZOBXeeyKHgB5JcvjUNzX3ULEcCxhzuKrFeTUjh8PxtgoVYFjkqsGVkA9rg/Re+CLlOb9NodsF7ukUYYY30ebrkjUcGF3MeFitH4cjUvbwMMtJy1cYyhuJy0pvk9BG9GVOSZg93uWJzSj3fjs25tJvCuyTNHB0GSippqkNkW/VRqSBOKhFLOZdFY6OGH0SGzYFnvkI6VwR8q9xO6O9GbC8QVFia0+VzIs5GF2+ffdHt0ANy0XESoXtvhqT6LzLN6hYE6/uAr0Z11KrC5p6+651lliKi2+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(10070799003)(366016)(7416014)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUpaZWRBZVp4cjh4SFZFaUswamtzVkIzeDFtbUFKenhuMW1TdWR2WWdQOU9X?=
 =?utf-8?B?c1ljTXk4RysxU0FEdlFQRC9LZ2IyL2dqV3dzUU5KQ2FGT2ZiTTJSY2RKV2Ra?=
 =?utf-8?B?aVB2Qnk3czlJT2dsYTR1V2EwQ2V4dVE1WE56c1RtbUs5aXRhanFMLzgxQTl1?=
 =?utf-8?B?bTlvY3RLWnN3cTRiSGtrVytEUStROFdJSmg0NFpLOTIwZ2QyNVluR3czMWVV?=
 =?utf-8?B?clNxd2cxN252YU0wbmk4SW5pdGk1M0lDUlR6aFVaZ3BnYVJLOXM2ZmNrUlBX?=
 =?utf-8?B?OUlRSTdXUU5hbGlubzJJNURhdnI4emh4dldwRk9PRHVkZllZTTdMYnlWRFRI?=
 =?utf-8?B?TGUwOVo1MzVJai9HL2ZxdDhKR0NCQXpwVnBuV0dYZ2FqZEZpb05GOU9CamFj?=
 =?utf-8?B?Qk5HSFE0QlNocXdDVjkxY2w1S3lRN0k4WCtYckoxT3lkY3pSeDdaNEFxTmJn?=
 =?utf-8?B?UUhVL0Z1dXFkR3ZvcGJJckgzeS90b2FzaDgyK3RERytpTmdkMHhKa0I2TGp6?=
 =?utf-8?B?SUhtbkpIWGpPRi8zcm1RVHl0Z1JvdVo5NjdWU09PSmtOMkJwdlpmWlFaMUVm?=
 =?utf-8?B?eTdXTEExYmpQZGhyTGRGeDYvbXZ2S3FjYlJlWHo4WkpTeDlwT3N5RC9mQTBh?=
 =?utf-8?B?TlNpQk55SmI5SjhPMjNsS3BtZFdSejdzc3NTbmlwVDFtTUQzRVUybGZwQVQv?=
 =?utf-8?B?MWRDZ2dvU0ZGYzhySWtOeWVGTUJvRFU5QitRakFSR2lzdmNBNUFEbi9CbjFH?=
 =?utf-8?B?OFEyVnZXYzlkZVJzcG5taWRsR2JmWE9mS3Z6ZjJXeCtTaDhORHppM25qMFhy?=
 =?utf-8?B?YllreFZFRW1QbnhEUnd2OWtSazFOT1dRNEd5MmFkaHZLcktXNlVwRVI2Y25L?=
 =?utf-8?B?M3VHampMa1NhSVlQbE5sOXJ5OTNFRHBMWDZuN3k1K3FFb0diTnUyRE9CSVdU?=
 =?utf-8?B?OTJJWVozMDAxdVFaK0NtY3lwSFlCZTE0ZGhDczlNV05hdEtRaXdheDE3Q3NZ?=
 =?utf-8?B?K1M3bFI2L1pkV1BMbVFaK3NJejdkZXducTNJSE80d2EzQlZ0eFlZeFJJNk9D?=
 =?utf-8?B?a0w4VW13VTRVcmVjZzJwV2VMdHdjRkN6KzJPYzEzSjdDWkF2S284WFIvRWhB?=
 =?utf-8?B?VHk0MWFtZzVodVA2clZEK3hTMnJNdmpSd25ra1FPUTVSWGkyS01Uc1B5Ylda?=
 =?utf-8?B?OG1yaVNteEtEMC9qMzkvQTJPTkRGbWh3UTlyckRFZ0FDKzZOcWg2RzNqckdB?=
 =?utf-8?B?cFlCRVNUdTRMN1lITHZlTmdzVVcwNUVwNW8zS3l6aXJqUjVCUUNlWkhTS1Yy?=
 =?utf-8?B?NHJPWVJvdmtqWmdyTE9CWk5PSkZzaldPajdZczg4ekNGWElwNE9BbVZwWXNw?=
 =?utf-8?B?ck1BQXZqMmFIcHlJbGVyODlRaGhRM1pGWUlTdlI5M2pBNzVtZ21lQTIyYUF0?=
 =?utf-8?B?VXh1ZkYvRlRNcnNSL3N2ejV3WjBLcHFMU25Zb0Z5ZmphRUZLYnZhdW50M3Ey?=
 =?utf-8?B?Q0ZkVHd5dDV2czB6bWdwRXpiUG1JSlNPdzNGRStRK0RnYTVrVDV0TlBiREl4?=
 =?utf-8?B?aHhnL05ENEV5eG1DMWpycDBCaGRlSFd6V3lXRDNrd0dlKzQydjVOckVLYlR5?=
 =?utf-8?B?TDE2VjNJcWl1RU90RmFjUlhrYytQM05vRFhKK3ZGMiswdUQ4a21uZ1pMVkJB?=
 =?utf-8?B?TzFVSEJwd1NNbVN4U2pWMXNMdzdVTUxydHZ6WWhpYzFQWjBGOXRGdmF0T0JW?=
 =?utf-8?B?ZzdGd1RTVUxXWmlOQ3gzUmVTWWZ1d081QXkzL2R2WXBXNDZrY3hIdHBLbEUx?=
 =?utf-8?B?WitHZ3h0dUJjYitrSG95UjRtVlFIS2NUWWhFWnNEdFlyQkxhY3pVRUdUOUJK?=
 =?utf-8?B?N2hpc2tBMEtmTFRlNmcyRlYvQWxXMHBqVWhsT1pFV1BDWmtwUVVHNzBKdnQ4?=
 =?utf-8?B?KzZTcmRtTm4vNStYU1A2V0FrQnBlSG1DVmtYamhRR3RqQWR3d251aTZKbi9i?=
 =?utf-8?B?S0I0U21oZk5JVlNONlFSYm0yb2d4d3BSc2IxOStJM09iZkJLMnkvZFFWeFVV?=
 =?utf-8?B?aTB4cnNvTUVEU0hjNTdDak1aVTZRNUJaUnBhWUppeTRSZU5yUU5rOEZwbmZG?=
 =?utf-8?B?dFd1WjVDOEpYbVV4dENpVXV4Sm1qUmJ4Y3lOR0hXZWpUeDRGVXhycytZN256?=
 =?utf-8?B?WHNBZzU0em0ycmN1Qzg0UnpJSEx1K2RJR0FFZy9kS0c2eHhuQmFLaytjaGND?=
 =?utf-8?B?bU5mT0tBM1VoQ3RZRzBVU0xickRLK3o0azM1bUE0cUNWSTYyV3BiS1g5RFM4?=
 =?utf-8?B?YU5FYTFYVFM0UGJvVlZoVzhTZVVydU5GZDhFcGdKQTUwY3pVMzNWcTZwdm1u?=
 =?utf-8?Q?iW093po60u45VcPWe+NHTP3XO7br5rKqPRFDvL8+VRf5j?=
X-MS-Exchange-AntiSpam-MessageData-1: 33vAKxSw67Rhfw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3da5269-cc05-49fa-20ad-08deff575c9e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 07:39:41.6066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7SzZypkkhKm+b9JLVrMYfPiR5JQSctQH0l7309ySO4M14/+g9gHImR2XPzf9LvcLDJn5H2cELU4sFbPQ6dJfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7843
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

On Mon Aug 17, 2026 at 4:04 PM JST, Eliot Courtney wrote:
> Currently, using NonZero constants is quite verbose. It's unfortunate
> because it disincentivizes using it in interface boundaries. Introduce a
> macro to make it nicer to use.
>
> Link: https://lore.kernel.org/DKO414SNC0B2.248FUBGJGSPLU@kernel.org
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
