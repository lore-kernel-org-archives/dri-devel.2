Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CABAC98328
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 04:26:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48D9510E752;
	Mon, 28 Sep 2026 04:26:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="okoWWk32";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011066.outbound.protection.outlook.com [52.101.57.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAC7110E753;
 Mon, 28 Sep 2026 04:25:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmymbuySJVw+y7kNEbXZclHxVuBucxhcEXFVOOYfGXPYw/yVGs7nUjCG1UC1PpHZ+rKTfAEy4naWSnpazF1PVl4ry7Cvg8EbdKTAUlsLtTgvQJNrINSkBTow3hoUDpAP3Hal6pDbUdorKjnJO85x1ETtuDuJAGIi77n+JdJJFGtHMM8PLXMGzKqcY939tmSQhJlZL6j/HFyyEhYbPwCXE6+HCj3ew7JTgUOsXJq3xFUoAzfPbz12PFfs+WRpg9RdqkyNQyedMk0diyI33mnJRTbPuIK4hmoaOHqBqZFiKcjThsWH+DvX/I55/ET2X+YPlPsttZq2b7OsQU1t9RJTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CukcseP0aC6jqXN649AEo1z40fgyDOb5b7d34pbgIk=;
 b=wtDrnnTbmKs07FQf0b2g2fQQN795e9YNctnvnO9Fz+bBfKGw4JZR8wtgFuoppJRsRV7qWojEom+toVdxuxnaHo3IHQiIZZ32lQtZc2F7WBhrDMQhBHSh3rtl1uSRXxK7E4idcVRriRnyBzpC3r6rtL9l1AyrLr94ECgiYWB5h3VGOw22GwFqw+IYi3mmxChBpgdJosdNgRdWokaARzOi5drrnk6QGVvjbMQOTD6HifpH/xLDgDWTjXhzQ4KdiCya4IPUw47MetdNZhld2isaFJH7LIlxZ9bc0+q1B9kc2kLieFQvl/ml9KVhtvSMd23YVOfIuyoLkQE9VG3gGQeTYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CukcseP0aC6jqXN649AEo1z40fgyDOb5b7d34pbgIk=;
 b=okoWWk327HVkFljXRQwt41h4JC0W1qgrnqCNl29Hkb4leMJb1pvECQKwgd95vNt2Xy9mXf/jqk8riHFa4NdfYorrvCRgWLhkUE88fCdvRLpBHxYedxxBy/4AnDgOA4dg+ZbMOdj4YNYMIQJfKmZATFkUscn9ZJJwc1+K9yrXkXxlFW8p7QWM3EiPChQTbGcWxFn6809PKKq/JPTLM9naFb2fGnw+7Y+c4y1/u61dkF1scrOae9I3gfhoa8asdXkWrLDvlgEzc/QDJTgOTP1kgAOa2laq8FI7JdKskUXwnB1u1Nt/DXvW3tJDnTPcnAmXe6FuOgX3RH0Pgv8M1ttFpA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS7PR12MB6336.namprd12.prod.outlook.com (2603:10b6:8:93::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.23; Mon, 28 Sep 2026 04:25:56 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 04:25:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 13:25:52 +0900
Message-Id: <DLQNXKFGJHZ1.SGPZQQPQ6BT9@nvidia.com>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/9] gpu: nova-core: gsp: cmdq: validate checksum
 earlier on receive
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com>
 <20260927-cmdq-rpc-v2-1-c3f66ae73be4@nvidia.com>
In-Reply-To: <20260927-cmdq-rpc-v2-1-c3f66ae73be4@nvidia.com>
X-ClientProxiedBy: TYCP301CA0010.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::13) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS7PR12MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9eed63-144e-4a2f-a452-08df1d1896c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|10070799003|7416014|366016|1800799024|11063799006|56012099006|4143699003|10067099003|22082099003|11062099010|18002099003|7136999003;
X-Microsoft-Antispam-Message-Info: 7r8vUoxIE7xkG6EKjI75+ul8OXAIay8NCucDUsWr3+XYUfWhvfLj1B0FUBPWwkU1u63KxMEVOdfz3T/c5y4ixDEP4MrGX2vB/846vyGezoodyblL9eqQf98dIbs1D0HXAg7UbaQC/Dj7dloejEXEQobRg6byhigcW/zPp0J8jXjWQgvTLPivcZiKqU23q0LuTryHuqzHZrr92a10hV358oCBq9sgk/ok9Xfql/YtGznYBmxPmTNj0NUwVvuYHd+PGR4gBTyOg+o7GJdgOBxvP6BGPHlYC7Z2DYYQ/x1Lo0JjhwRRo13ZxjnVbXIulYmLzjYiwIYIqFYvA5Ugas98MtAxmlCqgwEJB0mBAtUnHS9tqCpFotX+a4yoNQxlFLZaI+n+HbPayGpiEFCmKjRoJRaD135E2DtFPh+JedA+9q+3DqgUS34xuPAz5O+wNqpq8HkuxBYe2SQm0lzWBd4OrQTsN6aswRFb8u5ayuFm6yetOnsboel16WiQTcq/otyk9YDzRRul05VldD65jmseL9Np814hR+vzRfkKcSX4Co++TrBO+dkAiTSwJ/XWMMiZ0TP93Uot3x+6u6kkHrpR3htOwAT8lMGbSir1ln7ZuYrzw5dwAmcTGocGLNjcu8QX0m9Xx3ShyI+oqoJ3WHxOLHdD2pmmwooqDtJIbmHpcDc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(10070799003)(7416014)(366016)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(11062099010)(18002099003)(7136999003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHV0YzF1UU1wNmVnNWc5bzI0bFlxVTRDU0R4MVFEeHlrcTZWd3dubUxGTDZx?=
 =?utf-8?B?OVhTVjZPbXlSTlo5Nk1BOW9KK1RKWVdaY1pLMHdyc1F3M0NDYUdVOGdzUk1F?=
 =?utf-8?B?L0ZMZWlZSm5qeFY5Qm5EWWJiNlpuSVIrcnFYVDM4WDh6bTBEMldQVnA0UjZI?=
 =?utf-8?B?NGI3YzJrL01Na3gzazlKL0JZKzNDQVl1cGpSb2pWZU1CeEk4c0NyaTZuM3pG?=
 =?utf-8?B?ZWZMVVBLYnhzM2JpRldxWEFZY25NYm9pcmY4VisvdCt0RXVZS3NPK1p2Y0pi?=
 =?utf-8?B?b1VpOW82U2M2K1JJK0Znbkx4Z2ltc2R2Y2x2S20rWm9UTGE4WDczeklxcXoz?=
 =?utf-8?B?Q0x1T0dtekpUUzVQSlpNeklBdm1KWXFxRDBTUkpISWNteFVnaUtraVdKR3Fj?=
 =?utf-8?B?K216ekVDSngrby9HQlJYY1BmaVh0WXRReXM2dDkzelg3VExDNWsrYktiWnJ6?=
 =?utf-8?B?cHZxZC9Qa1FQMzZxTG50bFpDRlJGRlZZYjYzU3RHRExCNFhCWmI4MHR1UFRs?=
 =?utf-8?B?a0dBS1YyOStJeVo2aG1CN25XdUFGRU03a1gwdlZPODZSemZLNmhxNzRxSk1v?=
 =?utf-8?B?NFdyOWJGYi8xL0dSalhLTCs3VWxGaFQ4OEU5azByTHZKQVFMcTlhUnJCdWp6?=
 =?utf-8?B?UGU4SW1kSGIzZ0dnSHJ5V0FnbURWKzRIUkV2ZHFYNmtzMHZmU3dwcS85V3ZL?=
 =?utf-8?B?YUJialkxRmZjbHNVSThlQlRtSjFFdzgyQ0FSdWZvT3lacHdadFpqR3UzOXA5?=
 =?utf-8?B?Y0tyVllvcWpuRWhLa3FlcUNndXVVNnRiYm8rTFBqdDI1SlFGeGVlNnQ0RG5v?=
 =?utf-8?B?REtyOGg3NDRJQmhJTkxSRlRjUk5Hc0NrVW9teFQraktQeWlPZ1dldDFqaHhB?=
 =?utf-8?B?UUZhM2pnb0NCMWc4RjhGay9EZk45MTJCcEhibXNvSHhPSkl2aFFqb0RicGw1?=
 =?utf-8?B?eVowMWxUUVlUTFlHRk4xK25BeG5EZ1kwS1hoVG41Q0l0aldqdlZmSDhyWGgw?=
 =?utf-8?B?eUhqenQ1L3R3UDZhN1l1ek93NXIxczMyd2IrOEp6VVBwVDI2ZTVodVcvVStk?=
 =?utf-8?B?empacnMvVGtZTGNBeG16Ujc4eDhldlNnQmdiUlVtWkZSZDQwdHpZaTZWMkox?=
 =?utf-8?B?NDl0QThWTk9EU0wyeVpJbmRldnZVajRHb2I0MU5xWG03SkRsNWZ6M09BR2dp?=
 =?utf-8?B?R2JoQUdTM1Z0RmZRZnFIQlpaaHJ1aFAwSFBRZTRoVk8yRDlSV21LOE9nUEI4?=
 =?utf-8?B?NDVOUFcwVGpWUlI0dXRNMmdtQWN1Q0pNNk1OSnhmNklmVU9DVDkxMDBaQmJL?=
 =?utf-8?B?aXU3MGVoNzZva2xUUFhtWlM2MjhvekJyWm1aUHlRcnI5NUFjdUF1V1YrdmNl?=
 =?utf-8?B?NW9ubFZMZ0pEVUV2VERzbUZFeEIwUWdFWDc3QjdGNzBOaWFXblozRHVKWTBD?=
 =?utf-8?B?dmZVTzc4UWRLdmgvM0RTZnlzTVZQQmFRZUpveWxacGJ4U01oKzlOSUwyYVRK?=
 =?utf-8?B?cjEyRTNQalJtMk5Bc2FXSTJrOVpaV1lWN2RPSWV0L2Q1RG9mTG05K2poWWVY?=
 =?utf-8?B?UEZnT3cydk5YQkRObkhHOWtlSWF2bk9XejNlSktyQnJISk9xZUN0RmdYUmFl?=
 =?utf-8?B?UXMvTjVrZDRxdVB4eTQyYk5RME1sNzViVlhocnUwUVl3bk83NENtcUxiK1VZ?=
 =?utf-8?B?emVaN2tibnhEdWU3MjJFdnpWbkNWdDZqYmN5TzBDUXc5WWdJU1hleWYwM2p1?=
 =?utf-8?B?QzlaM3NQZGx6V0hnMUwyNi9TM0h3Skx0dXZpVzU1blpxMnRPd25SZkdIbkRT?=
 =?utf-8?B?RFA1aGhpS3RmZG1vZmZ6UmVMMlBPazdyVDM4dHZCWll0REhkRm5MdmNPSGJM?=
 =?utf-8?B?MGVmZTN1ekNlbUtBQ0FLWithUGY3NEtDRmUzMlBpeHJKbkFZM1Vvb0VMTFM3?=
 =?utf-8?B?Z0JFckgyWHNmQzVaVXlLSSszUUpwdzRuOGhmekV2OUg5dnJwWDlrV0RRTVRV?=
 =?utf-8?B?WXNXdzNlOHFzSXRRZHN5SW5iRmx0M0ZNdklvQndJY1RnNjk2YW84QjF5SU1s?=
 =?utf-8?B?Tm44OSszbjV3VGRVZ2JOZW5DV2NhbExVQnY0cTNjbFdGazJxSVQyN2U4WkFw?=
 =?utf-8?B?WVRHZFRqVmxIZVVFb3BuNUtVSmZ4T0Z6cUtxUkhBc0pFZlArNWFQN1BZUDhE?=
 =?utf-8?B?bnlyanc0cXY1eHNwUUk1UWdHYUt6ZHF3VGxhbkU2Uktzem80MnRUdEhaN3Jl?=
 =?utf-8?B?ejUwbGxmVUgwVS9XRlhBbXA5NW5EbStHR0l5K1lGTHgxMWxDL2pHdW9GL1lX?=
 =?utf-8?B?MnFhU09wdVVvRmZYKzVTOWIrcFZXUmZhZXdWNk5CUjNDOHdDZENIVkJIYU56?=
 =?utf-8?Q?6+HpUUq8/sWliIa1FiF0fpp9Mzs36vmBbrT5UXAFBnAGH?=
X-MS-Exchange-AntiSpam-MessageData-1: 1vU0gnWCmhz8kw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9eed63-144e-4a2f-a452-08df1d1896c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 04:25:55.7608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdwepX6Q08mcUN5GaUa0WmrXld/99V57JG61zDeKBsdj75X216+uv2rXJjjB+Pvp+Lj57di0y/xWfu0KF5ABKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6336
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

On Sun Sep 27, 2026 at 10:46 PM JST, Alexandre Courbot wrote:
> The checksum validation error message of `wait_for_msg` prints the
> message's sequence number before validating the checksum.
>
> But the checksum is part of the transport layer, and it not validating
> indicates a corruption that could very well be in the RPC message
> header, meaning the value of this field cannot be trusted.
>
> Furthermore, the transport layer is not supposed to know the kind of
> message it transports, and it accessing the RPC header is a layering
> violation.
>
> Thus, move the checksum validation before we start looking at the
> message header, and drop that information from the error message.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

N.B. this means that checking the length of the message (which uses the
payload length) almost always gets replaced with a bad checksum error.
But since we can't distinguish between corrupted data and something
wrong with the lengths, we can't do anything about it anyway so lgtm.
It also means we don't know which message had the bad checksum, but
again I think this fine too.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
