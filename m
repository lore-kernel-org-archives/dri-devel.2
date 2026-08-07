Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A32FC2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 14:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ED0410F4F6;
	Fri,  7 Aug 2026 14:03:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="MBXEdnbj";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010012.outbound.protection.outlook.com [52.101.61.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7CD010F4F6
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 14:03:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tytNp06VEzRYiDIxqrrqf48u+Lyw5JBW3vpDBB8M/7G+sho6EU2HSXkqY2DN83uqTV5FY1fVYU2vKVXF4W2JOW6kKpixs4DlEajo3x9Sd/x1wKAAgSqhNEhOalZoZ9TRmGaXZ7TBkCNNcxOdRBMCBM6CHac+wuKatnUr3mYNIbxECC0WNHiTKUQefGxkM3HbIa590vxQZyl59ZldRMXPCo3N9+loQ/iO0xUXhkhHCSMYMl3MDYfbOvbb7IKDHrc+lq1PrIN4HlvYXkFKap5hjhuO5Cu/8OWRW5z/dfK8TwW5JJ6WLWgR+sTsGOR1/1+GwNXBPlDbbAj92RfZKqsYpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lAGhc3gPzYH24KmYPBFB5GbnhhwkL4ncIAhr24++KY=;
 b=Vb8gbtGmmbXHr5ewcCr3KIdD3gHMbQvn7bxL4lV+LHqNzD4uNj1oaA0bugTKp8w8PBOqrqq+AYHaqhrDwoqjqdRh4SI1IGhhZzu6U25GFoYbGDw9jvFZDRw9nCeAEnKlwpfnRbUDjWnvZxisAwJgdWmdY04q+Gf++UuqJa+SOMc6/Unal3bjRpfTJQ2VeEXmUZN05k1O5onoz4VtOYdiXCV4Kh4RLiS2XD/MEbEwamh4R9/oXcO07MKkpwypYG/89nJ7XksfhUdFDXN+x4ujq7RKwUHSiwbqa0NsevmOfJh4evlFVB7L9Tkca09gjU1s5xVL/t+PRmR5xlIoNie/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lAGhc3gPzYH24KmYPBFB5GbnhhwkL4ncIAhr24++KY=;
 b=MBXEdnbjBWJ0KxHnSGpx5rbHEK860Eq/pVjDY0Dk+qluZtfqQmpE8aAbY/nZ+oFitvAAxQbJWomG5B2FSXgijykXPX7N5lIOSoJzmQEU1TcYzEU2HrZwKjyA1vvgQ30yFHuuEn4Iq8MBFQJkInukhqM8VaGoWrhnyrK3foAQq63dMMyN4tSmgJijbzCxUBZeiLMijTdRIY1YTXmzvd8qLBRTPjiFOE1Q5/vogl4I51LiR/ha9Vd5P/BLatt5cYt3+HM1hN2fOrzO5DWAzmknKQyzRfbTZ26sQ5XIRmjL4M/XfxrmOqNSC/OumI9TFMiwKfvfDLkotpgskBPKQJxFKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA3PR12MB9157.namprd12.prod.outlook.com (2603:10b6:806:39a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 14:03:18 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0292.018; Fri, 7 Aug 2026
 14:03:18 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Aug 2026 23:03:10 +0900
Message-Id: <DKIRN9CO8EGF.2U1743ODPICPU@nvidia.com>
Subject: Re: [PATCH 01/12] rust: io: add Region::try_subregion
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
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
Content-Transfer-Encoding: quoted-printable
References: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
 <20260805-pramin-split-v1-1-ff3e84a75dac@nvidia.com>
 <DKGY508IDAS4.9E9983YWQ2F5@garyguo.net>
In-Reply-To: <DKGY508IDAS4.9E9983YWQ2F5@garyguo.net>
X-ClientProxiedBy: TYCPR01CA0178.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA3PR12MB9157:EE_
X-MS-Office365-Filtering-Correlation-Id: 055b4b26-e86f-422e-e000-08def48ca224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|10070799003|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JzwZUX1YPXWek6tdy+KI9ej0tChbDqKPYOKiigQyZiavxFim7eMhaY28H+ZbOxV6MeGAYEDP/T8Qs/khERppcGPllEmwAEjCnAoXCj8SKCpQDochdFNRvmRoye3jfmRk954U8ePTeeJigb/aZ7WlKxwz2pREeo8pkWCKQCvs9VnM44PIH/ywUQUf6xukml8cG75NGih4hdF/EYEVlSntkzd9FN8wBIEE648yLjPjqUfZiERBaaM4Edyq8Eyvk5NWKYuNRov6ne38y4DUekRDQbbBwdypn6RSJnrYlMViAMdEsBExs0jXnhqrCUidUOPyYhF5Kyc2SJnPmRzc5LRHmQmpeFxNSLu/eaZpKNH8+R4vP/QLORniZY9UZT95H4tZD8YvZdmgY7xlhkiNpjawFjpsf2/xYiTyXRl1bpCQRKW+ZN+BFR0pXvj4tZi/8VZg7PrtADNfGgLtIFPhoPIdN73pVdYf5AYlHEFhsrD3L3Z4y5DW0HnanNHxXUEL2JK1VuehbEc628jDFTgICrFp180/loAqpXz9LZOpar0Nu5c02oczElCZdo4zJNkYZZg/FRxrJ3vHoa2PWZsS28dyDXPLD+VNGXyFNVIw+0vCLwefqBtglaAwbNlKZpLhyWE6oiY5CygKmbrmq8FheWvn7/Gjrs4+hcRkLx8um3cMy4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(10070799003)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2lLS2NvRk53MlBYOFZkZm9IcnVUTjB1TUU0d1FhbEVkYXRLR1g2Zk9INC9Z?=
 =?utf-8?B?YWxPZ2I4YnZUcVNvUmZkcFo4UHJSMkFRVDdJNXhrUWJDekQvN2FkRStvSjE3?=
 =?utf-8?B?Q0NoSThoQ2pQdXBBaEQwK0s2bThMTXlrNE44eXQvbllGek95VEJjZmlxL08y?=
 =?utf-8?B?bW1kZXhjYnc5c1gwdmwrMExwTm5ZWjZPTWtET21RSEYxZ010bXE2bFJzOHkr?=
 =?utf-8?B?WUljUDNLbGZpaVcyMmZ0YTNDdDBSQ2hkOTkyaDJjS1A3TU5sVGlUd2FwRmJM?=
 =?utf-8?B?VG04dHVSbXZYLy9mMmNXWEdxY042dUxMaWNUY1hQc2tiUXR1alZxQVVWS0pT?=
 =?utf-8?B?UE5KdGVremorWThEcnZrTVM5SjZlLzY2TVlFeHM5Z3VqMW1HSGpyRUdFOTFK?=
 =?utf-8?B?Q2lyNUxrM1dmcVQrOG5FekJvb1prTWFIWTVsTmg1citDdVZKbUh0U2tpNnNT?=
 =?utf-8?B?ZTQ3ZlJlcks4VGVCTGZQVkxIQytvZnY0RzdOWEUxSEZRWTFzTnB2S1ViZytR?=
 =?utf-8?B?TXAyOFU5UzFLNGJMV1lrbEZpZEFybGhiV2N0bHI3K2lrUFBrWkthQjdObksv?=
 =?utf-8?B?M3lhWktYa1pHTGsySnRkRWxQd0d3eVFzdDZwQ2U1eFJtbS90enRkc1JnUm9W?=
 =?utf-8?B?WkVieldjYyt4ZktNYi9na2hTRUZoQncySjIyMlZicC8yUTNKRW1lUE43WlIv?=
 =?utf-8?B?YllHL2V5RnJGbUgzYmhMc1k2UER4YkM4SjM5bldPY25keTNIUWhTMFB6MnVn?=
 =?utf-8?B?aHY1SnB2YVo5YkFaVE54ZXBNRllLd3NDN3hvSEtYdmxHRlNWc3crUDlYV2Rq?=
 =?utf-8?B?YXlKUUhZZUlIY0hJaEtBZ3J5K0tHUUdoVjZKTCtheDRZNHdzVlUxdEtibEwy?=
 =?utf-8?B?alJ3a2VNV3VZK1p6ZUJsbFBwTUtNUWRsTWJDU0JISitNaUZUbmxmYis1UnRm?=
 =?utf-8?B?ZjBTdlhPYVpHZDNRb25lUmUxNTFnaWN0czVXeGJ0N2NkUkFWUWs4ZXpSa2N3?=
 =?utf-8?B?N2wxaE4wWlRyTm9FTEszelo4d2ExU3k4NC9mNTN6ckhCRnFqSWduZWkwU1Ru?=
 =?utf-8?B?SU9hY1hzQmVybm5iQUlLVW9DRFRmUVNQbm1WQXBMMkF6QVVPTVY3c3dMREtW?=
 =?utf-8?B?S3dGMmpLdThrTENYL0lBLyt4Z3JFcGVCZE1URmJTbEVpWWNCbktPUm9YTXJu?=
 =?utf-8?B?UnRBTjByQWEzQW02STdkOTB6dkV5T1hZNU5nOU80WjIrVmNra2x1dGR4cXhq?=
 =?utf-8?B?dFBuOEMzNDRuelptTXJ0SlJqY3ZuajNUU3lLbkNnQ2w1c1paU3F0VmdrQ05p?=
 =?utf-8?B?c21zdWtJbXlHeTR2T1JZRGtQZ1lFcjQzSGFYTUhFa3IwZHgxeDh6Nkg3VTJN?=
 =?utf-8?B?Ym1ZN3RLNUdlL0l0eS9RNDYzUloyUFIvN3lpa0ozNkw4bytraVltUUxNUy84?=
 =?utf-8?B?MzVvWW40dHo1bHRYbE1hbTY0TXlMS2hnanl2emtXS1JjRyt3YzE1TGpLWXUr?=
 =?utf-8?B?aHlwUTU4aU8wWlFJVGZUK21CRldNRlR5WTdMQTBMT0tJRjl1bWU0ZVJhNzdi?=
 =?utf-8?B?QjRTZnhDMUtyRlJxZXBMZXZWbDRZcEYwQlFMUllpdlhLL3ZkQ3pVRzdzcTFy?=
 =?utf-8?B?eXh2ZzF1b0JtSjlmOFVvTldGUHVjdW5GSHphYTF2UzRBaVZmWFE4cjNPdU91?=
 =?utf-8?B?YnRnVGl1MHpJZEVxZXlGdllTczBjRUlZL0lFSlVla2N0dFAwSmtKdHFJakJl?=
 =?utf-8?B?UmhXKy9GOVhZSzJZQUVEdEFuZzNMN01JZkp4ZGU2OFF6RHJkZEcxdDhYMUto?=
 =?utf-8?B?L3B0aWIwcFBMUnI5RzBaa050QjdqYUxzeXkzck1QdkQ0NjYvN0Q2bFdIN2ov?=
 =?utf-8?B?bEg2bThvTTNlVktSQSswVk80K05yUW5ucjdpUE1oSHZtV0dSSFkyS2F2RWVU?=
 =?utf-8?B?U3dFNEdIa3pTQ3I4WVl1SnA1aXJnNG54UnVLNFlWbDhrUkVHeldEcnlZQmFT?=
 =?utf-8?B?MWpqam9LdGFqaVhKYlFza29sWjA4T0EzdEtIaDBPMFBlSjF6THhoYkR0TzVS?=
 =?utf-8?B?aFMvZGJ5am5YWStvMUVrd1h4VjVvbHVrVHZRbU5sblZQQkhNOTlWZzJlVi9o?=
 =?utf-8?B?MXNjTzBWZWNYS1ZXZ3dpM0F6OGkyMG84M1U4TDI0VExhUURjV0FJUWgzQ0w2?=
 =?utf-8?B?dFVyZ1k2amtTTGhUQUpiMzJPdEJhZkRxR0xuR1Q3NFBhK2RZcmZCcnNhMzIw?=
 =?utf-8?B?U09LVUdsNlVoZFRuRUg5dk9TYVRMMlB6enRyWUt3cXg4MWlZc3gzMGZKcDJS?=
 =?utf-8?B?cG9DQWp6M1MvVXMyM1ZqbUFidGJXQnl4b2tSVzN2VXhuTm5acEtJbTBlRU45?=
 =?utf-8?Q?HLqi2jEk/IsU2WPje5QKl+xqPXz3Epyl7QTW2FjzjJUGE?=
X-MS-Exchange-AntiSpam-MessageData-1: 80Y5w1arXdL5ag==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055b4b26-e86f-422e-e000-08def48ca224
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 14:03:18.8161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IIfNPxRQ/lKUs/Z+FLo50LJNbZ+xsPOjd+MBGdytLdvt3ymRmkL1PDCFO2x6wQoAg1cggXazNgHIp8Lmun72A==
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

On Wed Aug 5, 2026 at 7:43 PM JST, Gary Guo wrote:
> On Wed Aug 5, 2026 at 6:44 AM BST, Eliot Courtney wrote:
>> Add a helper to get a subregion of an IO view fallibly.
>>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  rust/kernel/io.rs | 31 ++++++++++++++++++++++++++++++-
>>  1 file changed, 30 insertions(+), 1 deletion(-)
>
> Looks like the case where you need this don't actually require a `Region`
> (dynamically sized type) but rather a fixed size window?
>
> In that case the next version of
> https://lore.kernel.org/rust-for-linux/20260721-typed_register-v1-0-452d7=
2b60262@garyguo.net/
> will contain what you need.

Looks like we are going to need to full series (or at least until and
including patch 11) before this can get in. Gary, what tree are you
planning to merge the register projection series into? It would be nice
if we could do it in a way that makes it possible for this series to be
merged shortly after (either through `drm-rust-next`, or a merged signed
tag) for the next cycle.
