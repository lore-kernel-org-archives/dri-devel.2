Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAD2F433D3
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D13D910E0E0;
	Thu, 16 Apr 2026 01:08:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="be1r3kGZ";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013010.outbound.protection.outlook.com
 [40.107.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C9EB10E0E0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 01:08:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZX60A7I/8M4GJ3zvA3MunJszBo19JdW0uj3NKMvMSO+sQiUxtUTKLNK+c/PFUD+C8Hg549sBLD0gxjUmnKlBgKHnuDvFmaiRKjLjgStr6tAG2pKgEFVVkR/8sCaFfFKiHq24+QQdITPNBwtccCKpueRvGmhPzvszlF967lTpT/zm8s0oNC3hHVvXL5kdAh12RGDm8ZED28vlwqIdTns8j9A9g/27WJkeeGJrIZnX8DxxOqxmNnXpWSSEce8X9aB8V91EwiEQ0HIP2YdNOAN3RcRhJlsnoFmy2Mm/jSkzqWhEjh8pfXUN2ubfy3nfSz5BgRwlKaxfgaPKG1gt3EPmmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkBzYkvB0idhnGbrAIDFrfpBzS2SbQfG15vGqO0Grbs=;
 b=Jd+cO0RXUCdnsrFsnNyLRWrH8hiTEInMs/lM8YfvDyMc+LGEOz4jZ5XWwcySLj7yDTqURX+b4YxKv/fVgRt0cTL3M+GFkLfQxQWQ8gfuILr2WXML2IFXkjrsgGbfCZiBKLhvk6Ditp/+8/YuyGa/AQziVwRZcbEaz8cZFoHkTqCKX5p6bC4PfQUU/Y2wgxG7VD1FKUJozSl3cDY9co0pnOss8XbvNPk6m+5iLeKpIzmoBxnUPMNh7Hk4ZU7CAAUNcRBKcmjxhyuRRmrWma6MBHEa/QuxPxuacDlVRDj5O8aZXoGD1HqQtCX7+5Nb0uZy7lVcXQHUqWvFOZLpxWEMsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkBzYkvB0idhnGbrAIDFrfpBzS2SbQfG15vGqO0Grbs=;
 b=be1r3kGZBhFxB1z0TU5wpFhJ8vw9867969fEDZL5xMP347RrHajxt8lNQKRwiSbVJuvtu7t9RsICdQR6uwuVHfBl0dmY8lQ7+gyKlEEvbYAIzOJcDPykiQW5t1FKsI1zO1aZsQo4BQE1q9UF8vp9X+KVznPWnCLkg8MN0GInD1Qq0UbLLQ6O3XgwAlmLGmaUIkdAn6SGcDHacYut5XGzLUR4sinqMT8nLxxESQa2eYJ7yngHbxsnuNWxVItFuosKb9fGdFeJmtGsdn4O3SSCtNsaFG7LkomtPfpv/fB0lviTY17AhemMtWL9B5cOowSSSPtvvZSR/aYIdtHip8nR+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MW6PR12MB8664.namprd12.prod.outlook.com (2603:10b6:303:23c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Thu, 16 Apr
 2026 01:08:27 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 01:08:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Apr 2026 10:08:22 +0900
Message-Id: <DHU6EGW46AID.Y0243IOI1YWM@nvidia.com>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 0/3] rust: add `bitfield!` macro
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Yury
 Norov" <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
 <798e83e6-eb7b-4502-85e7-5a0f6d9c6281@nvidia.com>
In-Reply-To: <798e83e6-eb7b-4502-85e7-5a0f6d9c6281@nvidia.com>
X-ClientProxiedBy: TYCP301CA0056.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MW6PR12MB8664:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe213b3-6dc6-4942-9d64-08de9b54aa01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|10070799003|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: dRO0d4Te5FdMPkVF1wiSVRx3dg6p6JlUPgAUVE0iGREPxwxw2klYjwEpE9gGU3oINJ89SgYpvEYP4YhInXOYPw8cN/KAsTqmLonDVjAJZeIPO10sTRxhfe/ixEQItZnyz+7K7cFFjKkj+dTvTEnuHZ8NxSuMR3SO/xyDod5dQc6I6ULjWqum/ZbBUcZvWHgZhiXY3I1s84nLfvv0EEQyo0x8YWG1CFfmx2AzdXx54EtX47rVKLUsfDYFi6tUAQrY0DLUI0OD9RWtnttPNlLkODU4f9h1zpVLBShogwjc5sU+CTHLbwKfRzRCHEIDIzc8uRhXtHwSvFVRTklrpjEls67+YqF3UG+8qzsSWj4iJZ/dJN20gt6vL/I/w3KH7L2HUcJiXTIzhUdXxGbPBD8+xV81JiS0CyVTVOgZgQYB4pezINnKFC5inymuiDtQBEoGe+uPwcHT2pJol1H4NKN2AqjTXwRJ1HoSsAt43ugpWXbt3/BClIuTMTPE2eImvsL1Yo+Qk79g5MABnyH9dMG0OeK3ZkmKkMx+0BjtpMToYQv4y3NQkkQhdzANt1Df0AmYHoZanhWP/Xg/3zQVgXgd2elkco4RXGssLPmrOccdX7n+VLgiWirEKmDEav2vHtGR02ZuAVH3110XKc9JKe8tjH7IwL/RG5XRZyZqSrINdZcDW8JDL8aV0IJSnSXZVuy/5FJmSCEYzxjeD2dTVvqXaq+RF6E/aEXjVoCPR//bYtRwJPN6t0wEPhMBUjD85bne53bjzjU7B5t00w2/DYob6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(10070799003)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzZDWlhnU2Q3NncyRDJaSTFLTmhySnRXNjdTVkJFNHUybnpPczh4aXFwUTF5?=
 =?utf-8?B?OW9IV0FOL3A5eDB1Nlkzay94aEdWQWhyc3ByblhXbFpMdEpOMm5aYndvalBh?=
 =?utf-8?B?eFZ0dVJjazNoeEVKWThiSElDMFdWKzV0VzAvOFUwSWV1SjJiNEdzdVNaOFpk?=
 =?utf-8?B?RE0yd2xUK205Y2xlMlZKbnpBYy9ZVDF1YTFRTGVFL3VFVStueHIvWmJSa0ZO?=
 =?utf-8?B?TEFDQXdxVFVndmRUUHVVTVl0N1R1Mm5qZE9EVW1RUTIzRlQrOEg2ZFJxL1Z2?=
 =?utf-8?B?ZjFUR216cExFNnJFdDdhUG1UOTNZaTIvTXJlVHhOMHVwRzZ6N2o2VzNmcDhu?=
 =?utf-8?B?ckV2V1ZVYythVGJJdThMdGRMQ1Q0YU1KbTNYK2ordmpBQmovdlRseW50dE5p?=
 =?utf-8?B?VWtZb0JKN1Z4U3RMbXJHazFWT04wSUFBVVdHMnREekZpdnVLbXNtQUZNaGZj?=
 =?utf-8?B?WTZnb2NISVdzNHVZWVNaVERJa2U1QnNOTDRUVXVjbnRySHNpbnpLdTJabVNj?=
 =?utf-8?B?bmxaQVRCN3ZqeGdYL3dHM2lmTHROUlJ1VTVLUS9CelhVdjJRa3hkcTVjOXYv?=
 =?utf-8?B?OEphTFZ2bGt0eVlVUjF3WGxYdDdnS0hyUXNsQ0pvZjZRRDAxVFRGeHpMRTRM?=
 =?utf-8?B?MEswaU52UUpQTnZMREYwZ3ZZUmtRV2kyYWxPL1QvY1hJcXVsdEFIRXRZWVBY?=
 =?utf-8?B?R1BJQXE4NW1SUHpKWm1XMEp5dUtoNFhEWGZGWEtMN09GT0Q0aGhHOHJhQUwy?=
 =?utf-8?B?ZTF5R2JDa0wvck4xNDlORDJoY3E2VEJ2Y1hQc1ZLWXh5cWVKeXdzc1g0TzAv?=
 =?utf-8?B?eEJBcVFFanB4akJBajExS1JXdDhRdyt5SVVQMGFheUIrTWg2YWxpaDVuNGUx?=
 =?utf-8?B?cjI3ZVgxbDNKdi9kandlRHB5TXVmaVB5Qy84L1EwMW1TenhFbzdYa1RteXoy?=
 =?utf-8?B?VVRKV3REU3Y3M1N2dHdPcEQ4b3lVdXZpdnZRSkhwbFU5NGdHY1gzalpEaUY0?=
 =?utf-8?B?MHZXbGhhcHpLbnE3R2NzZzVKcDdUSmkzZmQ0ZTFHTnB3aFhIemxQblhjdUtm?=
 =?utf-8?B?U2JzNXFtRTJWY0VIY3E0ZFRIcVJmL0xOK21yQTVidGpsNGczem43eGtHQXkz?=
 =?utf-8?B?MkJXVHpMVWpCSlppR2xJN1ZIRi9jN2o5T2NlR2p3R0tJSVhKazc3ZGVLS0xJ?=
 =?utf-8?B?Q1JtbkV1ZjZkc0FJS0NGNXVFMm9kYUkxWWVldDdpVUE0MzkzVUdQeWFNQ2xR?=
 =?utf-8?B?RFlRVDFjWi9oZG9iaERQTW9BMDdVaHNXeUNVbExUaHZtZGJrTUFwWnNWVmps?=
 =?utf-8?B?ekYwWUgzVG1ZeEI3dXp1eEk3MnJPdEtEUDJsS3YxK0dyMVZUMEFMWUc4QUFF?=
 =?utf-8?B?K3IrNExhQitoZzBmZytERk93VVZCcnFaVjRuQklvbmpsNkNMT1ZFczNRV2FW?=
 =?utf-8?B?Z3Y1R3gyOEhBSmw1cE1vZjIzb2M5VWJDUWV2aXRId0lYRnBraGE0TkxEUjA4?=
 =?utf-8?B?U3pWL282MVZiRjc4OVVGSFJtNmVoaU9LS1d1MHB6VkJyT21ESVhFNDRqeXJX?=
 =?utf-8?B?Q2FFOXg1dDJMNDdZeVQ3SHRsdS9qeTQrK0kwcEpMOWt6U3cySWZ0QUVQRENr?=
 =?utf-8?B?SlRQbkR6b1JXbS9GNWhVNjJQQ3A4cEVzT3hMdVBBblJjRnhwTVRrNVdZMEVJ?=
 =?utf-8?B?SUNXZnVKc1cvY3FodEo0Ryt6Sit6MWpvL05BRDlXMHBEM0Z1K21wdzNPYVZZ?=
 =?utf-8?B?a2dUUnY0dXRsYjEweUU3WjJ2Y29iR0tSdVQ4WFMwQVJoR1RDRFd1S1o4eWty?=
 =?utf-8?B?aUVCWVc1eHZhekpoWmVNNklSck5uc3lyelpHMnhyVEV3TzdYdkhWR2hLZmNj?=
 =?utf-8?B?c2UzTHJoZWZxT09DYlZnSzdqcy9IWTg1ZDdPOXFoUXdMalM5ZzI2bWF2V1hH?=
 =?utf-8?B?ay82bkZ2THJyZFBGdjJvakRCanBkb0JKQ2ZhbzdDRStsM2toZFVtT2FNQ3c4?=
 =?utf-8?B?dXAzc2VKajZud09acWR4M0I2Wm1xaFBqWkxIbzNTbndwNXpDN3hwYXp0V2JN?=
 =?utf-8?B?NmpSRHhTc1ZiRXNORFRoeXEzY3FrbHZCcVNIcWVmRFpFcm91bkh5QTBqczQy?=
 =?utf-8?B?ak5WVm1rMzc5YytXY3psY0VCN0w3cDd5cXd4RzkweG9TemFIeXpVbmNGdDB0?=
 =?utf-8?B?UnRvcFlCYzYvSDRpb1p1NUVtcHpIWmxZOUd4U20wRmsvWG5tTGhydEhYZTFS?=
 =?utf-8?B?NE1mMEJWdU11UXc4NzlDbGtNemZBR0pOR2toUFFVOEJBU2x3TUZJKzZQRWd4?=
 =?utf-8?B?QnNGWUFXNkRPazVGSUZWNlQzYjBpeWR5aEQwZzlGQ0pTZ24xREdWSjNYRld1?=
 =?utf-8?Q?AsiMO80uAjijDw4FDMcKK9vd7Z8pj7ZgLv2wghzs9hoHO?=
X-MS-Exchange-AntiSpam-MessageData-1: hMqWtiNUKSu6XQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe213b3-6dc6-4942-9d64-08de9b54aa01
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 01:08:26.7194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4VoytYpdLAXn7V60X2E4T3vG5NCpsdg9LmYQYd3NQPrmhlpMP+vHJiVRlNHE7zyGaJoUgamoOYJ4XLH6J+5vxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8664
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

On Thu Apr 16, 2026 at 8:22 AM JST, John Hubbard wrote:
> On 4/9/26 7:58 AM, Alexandre Courbot wrote:
>> This is the continuation of the `bitfield!` macro which started
>> alongside the `register!` one before being temporarily integrated into
>> it [1].
>>=20
>> There were still ongoing discussions in [1], notably about improving the
>> ergonomics of setting bitfield values. This revision doesn't try to
>> address them yet (although the `with_const` setters partially solve the
>> issue); it just extracts the `bitfield!` macro and makes it available,
>> for the following reasons:
>>=20
>> - To get the ball rolling again after several months of hiatus,
>> - Because it is already useful as-is, and ergonomics will be improved
>
> Yes, and I'm worried now that we can't write things such as Joel's page
> tables without it.
>
> Can we please put this into your drm-rust-next-staging ASAP? I don't
> think we have any comments that would really need to hold that up.
>
>
> thanks,

Yes this seems fine to me as well. I'm personally fine with improving
the build errors in a follow-up.
