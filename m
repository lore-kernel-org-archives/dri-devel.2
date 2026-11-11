Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32828606A326
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=rAGrgQrz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42B2210E0FF;
	Wed, 11 Nov 2026 09:22:05 +0000 (UTC)
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021091.outbound.protection.outlook.com [52.101.100.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D01F10F9F8
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:21:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWCmicY4u7mBtj9cwoqsCk3pnjM4BWcKyaZz0bCc1dpD9sAPwdes708bWgNDjLEry3m9tEpTgzFdJJo1Ux6/65vNEFVaOraMzetQUCwKpgIJGYpZ6IAWtjet4y0SuaazTACTyXEHQH68nBpJJwpHkvwg7iKJR7tKmq1ufoyTZPCHRVOWwR1Fv1Uy8G2RjnWeyddNvVxc36wPUc//6ZGC01quzUuEejEbRxnEBfPKPJ81MnoRzsrHQdnK24srVG+r2DSBiZdmWc43AMbYTPKEZzErZf5VuFS7hpdB09RQfZvMPRcGLkIxt9+XBSVuLAqJtoXOymbbVPomjA0y0koj7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtR3j1pBRkkMQ7seDNzYwy/UpIHGuZ0BrcXgGlNdkXo=;
 b=FSCg/NaRmNUI4bX8dQblud8j2tPV9b/w1l24tcdVA7hXQGsSJXbw667k+m25tjPzl3KMX+vR6EwEsZUxBOEKwVunQnuelIXaLynOaZ506mRUFYdk5D3htb7YYPuWM/AkMVZhAE0Yt2EdYY87DjOxLtsceBp0V5PGlvs3OS/CeMBokOhmtKkgZrxwL0ef49a1y9C9lxUmh5hlnlZrBOliYOXIu2oIlPuYLx/E04sLgttlOJD0PcJu31pImnRLvnpizkyjCCVJF3tOzkM/yl3uZpaKS5Uw7Jfu8w2JOiI5RqCdLUrujFk/r+ZzT8OadCUUigVPpFGIbXx0ThDywkmfwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtR3j1pBRkkMQ7seDNzYwy/UpIHGuZ0BrcXgGlNdkXo=;
 b=rAGrgQrzN/gwoQnvN82yc9VvS7vckFRUz3yhpQSkY+l+u07Sljzcq+sJuOLx6fNLJfiToKm0PhB+cjlxPgrLJREy+5uiljXzuN7SDrcrF8FlT57aG6/hs7SWq1ZoUqjoLmfev2uwb1X+KLjc009ghIPDmoHRTZJuRLdOnIiEPrk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO6P265MB6206.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:21:50 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 09:21:50 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 09:21:49 +0000
Message-Id: <DMS9S521X3BT.17VUFWPMII88C@garyguo.net>
Subject: Re: [PATCH v2 2/7] rust: drm: gem: gate open/close callbacks with
 RegistrationGuard
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <aliceryhl@google.com>,
 <acourbot@nvidia.com>, <daniel.almeida@collabora.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <tamird@kernel.org>, <work@onurozkan.dev>, <brauner@kernel.org>,
 <lyude@redhat.com>, <j@jananu.net>, <alvin.sun@linux.dev>,
 <deborah.brouwer@collabora.com>, <laura.nao@collabora.com>,
 <beata.michalska@arm.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20261107021427.2105374-1-dakr@kernel.org>
 <20261107021427.2105374-3-dakr@kernel.org>
In-Reply-To: <20261107021427.2105374-3-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0110.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::14) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO6P265MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: f62a0e37-2e78-4d99-b90d-08df3fd5379e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|10070799003|1800799024|921020|4143699003|10067099003|56012099006|261021121427099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: n6uvszmUWTbkyQPcfl/qhmyzjp/nbVBZHY0I+TYjKQQilbmyBkVWNBJTKmeFx5yql60hgGICowdM2MyyMTo1l514yrYmkWUhDV60WSeBzO+GgrTy5xuQlb565ilgEAyx2yEtkUtlwQkJiK1+Nv5SCThwJHjEIvBGytcguHXJGpAt1+4F6uY0JBx5M5x3oAmn41BNeNMEWm503KieiaF0zYSBbUvQ4mIAhIaG16guN+BXd++vbTJslYQyRLcmLlHklEOpMdsd0GtePpSPCjSVa/xpyYjDJVu+sKxXANi7QXKYbDHorJZHeuFIVbyLLNle1sVyRecPilTX8rhscjmSP8cggurLt05BsSDaIq21hCjUrX0kEi6UDO5HGNbqR6WtZi7KZkwXW1Se8cuHiMGe7fhb1hhB7OYKgaxNiCtchTr3Exku7zm+fEPY+dW9PYeqkKzgrsamjOLb8Yx/djs9+riW3OpVMSmFDjFHwIBD5rGz22fTGEvRTlvRd8LxGpUE4QDp7jSvtMc4ML4dtQZhQw+kVPLlJLBuhMHekmDfUK8G7dk15RHiC/L1ea6cXajSXXRk2sY5RPgpgDbCVM6IYNPRThGedDlqqYbFI56nm7eYeOsGNt7naSqaSTwyvORMGJds4HbmLH4jJHGg3vLlSFqgJLOchtr3dFnK2HoXA0nXz7Xzf/pBUsqOJyqxNO5ymCZfhEWLYSRYrA0TsJUuBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(10070799003)(1800799024)(921020)(4143699003)(10067099003)(56012099006)(261021121427099003)(261102123227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2ZyeGNNWUZuc0xyTEt1TkpqKzQxRmZtUlVsQlJWNFdZZWR0ejROdkxUZytX?=
 =?utf-8?B?cDVWaElIcG9GOFd4WExEZk4wejQzTThhN1R1czVlNG5sY0ZyQlFBc0dnVTNk?=
 =?utf-8?B?SkxsemNqZDJzcUVSbWo0SEdGOFJYQUp4RHp2TUJ3Y3l3ei9WRU1tK3JuQ0p0?=
 =?utf-8?B?SmI4ZXNVTWptb1AyNVBoeHRXUVBBck4rN29DNGpRcXRmVEE2ZGhzK21ZOWhj?=
 =?utf-8?B?aW04dTA2SXdwTXBydkhUSXdiZVJDYnBZRW82cFhWZnFTKytxeG5pWS9ITGFG?=
 =?utf-8?B?YVdiR2NpRXUwMmEvU2xLUkdwVXI4MnYxNkRCYW5qWVNUT2R2R3kxcHh4WE42?=
 =?utf-8?B?VVVKQTFNdDRkVVp5bmx1cngyeEx3NEZINHhOY1BISTJJSEN0UU9MSkV6djZv?=
 =?utf-8?B?OVdlcUkzcFR0QTE2UDUrNFBzVVU4Y1lUeWJyeHQ0RFdaT29qM2tQRWs0STVB?=
 =?utf-8?B?SHpubWdub2VmaUNJYjhzQkZGTTM3c3JzdXBHdk4wcnpJRVhpeUZ0UzNCc09X?=
 =?utf-8?B?aStMNTJWM3Y5TGsyS2VnbVlPZjk0VEF2ZjNVRkRqTmwzUDRwT3RrVHhOZVc1?=
 =?utf-8?B?OHJGZDFlOVMraGVaenJXTHl4Qi9sZzdoejNueTlQRHErUWdhb1pURjBtQUdZ?=
 =?utf-8?B?OGFyNEJWdE4zbzBkcWVUQnBtRFNkUWFzQ0lYU3FFbWQ5MVZ6VDB5VlNVNmcv?=
 =?utf-8?B?NEY0UVJuWmVMempzUDAwWklHbWtrM0VhVlBkNWpHaThWa1ZubUFqRHdEWlV1?=
 =?utf-8?B?Q0JDZDdoelNJR3RadVJGYks3a2hUM1Q2WmpFd1lQWk9HTFdQcTI5M1gzc2d6?=
 =?utf-8?B?T3pUaUFQYkE3ZEQxYU5oU1Vjc2ZkVXJHcFduaDVIREQ2QzlySUdnT00rb3Fk?=
 =?utf-8?B?OTByaFRLMXZJSHFqanErMFh2VzcxS2VScmxzbk5mRjlCa1p2Mjl5b1ZFWVlS?=
 =?utf-8?B?ZmswUmZJMDR2VGxJWjk1NGtFY3VYK0I1SHhEOFc4YnlQR0Q4NDlpRTBFUmpO?=
 =?utf-8?B?ODNvcm12L0tvL2gydEREV0YxRkp1cDhoSDYyTWNSN0NUdFI5eDA2TnlHMG1o?=
 =?utf-8?B?blJkRmF2N25QVCtBSFErZXdleWVQVFV2bnFPUWE3Ukd6K2hCOG0wTVVJN1ZW?=
 =?utf-8?B?MmtZV1U3QXZ0TFRFTWN5MWJqZDBJekdXN0NPN2pGQmtxbTFBZnp2YWdIcVE4?=
 =?utf-8?B?bFdqK2NaMnB3Mm9GNXBtWW5yek1ZSE04YnMxZmJSNXB6OVZpK1pRVXpiVDdo?=
 =?utf-8?B?cGdHRG9zQUR0TDZrVHZ2WXJoYzVlWEg1RlFMN3NKRHhxY28wY25KTVdLK05R?=
 =?utf-8?B?Ly92ek5OdE03MUF6MXdYcTdZK1VqNjhRNG9sMkJ3d3ozeUs1aEJkSTlMbU45?=
 =?utf-8?B?cUN4c2VDV1M2NTZ3YXZCZ2tBeW1FcUhTTzVOUGRhMmZWYTRXVm90MWtPcWZx?=
 =?utf-8?B?bCtRdkZXYUN0R3UvbXBxY21pU09oVU1xNnF0QmFENnZZdWNncGRHR01QajRP?=
 =?utf-8?B?a2xpMGNaNmhubnpEOTFnYnl6aVdpYUdhQ2pVcDVRSWU3TjUvSWE1VUlXclRw?=
 =?utf-8?B?b0VYTGxDOGVVWCs4STNIeTJPWjZlZU5kcEdVenFqUndwKy9VcUVxdVh0N2dt?=
 =?utf-8?B?MWxqKzY5dDNGTVFrdWtCaElvTkNkWUxEMmVXSUFFalp3d2ZXMVoxWmkvd2pm?=
 =?utf-8?B?L1pCR2JxaFllKzJkUHd3a0dhRDRzUEF5T2FsMytIdW55bElzUFpGcGtqaWlm?=
 =?utf-8?B?YWxMRmRBQXErTitkYU4vYkFpcW4xbEZVM0ZWWDdndVVzR3dBMWhoM25YTGJk?=
 =?utf-8?B?WnZxK0tOaGlIK2FiSnA1REpLd2ppdjlnSVA4cHFubmxyWndNZ2Z1cW5GZEk1?=
 =?utf-8?B?eUhSVGZTOE9KRVVna1hValkzczZucm5hRzZWV2ZrNmQ1SnE2bnZhclZvRzAr?=
 =?utf-8?B?SWdsRkhhM1FOb3RaOGRrM204SVdNK0ljU0lsdytWSGowRnQyWEdEYU5ZT00x?=
 =?utf-8?B?TnZnVUhuU2FxYXFHMDZyaVJONjU4ZFdDeklXN1ZVLytKNWtoNWhTR2tQOTRt?=
 =?utf-8?B?SzhRUnNvVGc2NmdTV3owZE12U3k5RCtMVTJEaUR1M0J5czRRRWhkNm1rUkVn?=
 =?utf-8?B?MjY2azdJanM0b2gzYk5HUk9jMm9zYVc0S01JdE0ycUtTUDZ0NmN2ZzNNYXda?=
 =?utf-8?B?Qzk1emdGTHNHbW1JdEppc3pyc2RqZ0hMeG5IeHp3Q3JBSkJKSXdRL0NCT29J?=
 =?utf-8?B?TGVKV1N1a2Ztb2RDWkdtWnE2KzkwUkR1bzJkUVFjZU1SdENKV0ZDMUFpSHdi?=
 =?utf-8?B?c2NyZ0VwY053UGxDNWkrSFZmaEd1ekF6Z2NldHZWUVl1WjVBZ1pydz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f62a0e37-2e78-4d99-b90d-08df3fd5379e
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:21:50.4701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0S7c6SmDms8a5+YT+vt+2RtIghYdW3XB4WJfzDJVA2G3qh2VSMMgPGmujTA/w2IV8+VSZoi8ZCDwO8Z2JyFgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6206
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat Nov 7, 2026 at 2:03 AM GMT, Danilo Krummrich wrote:
> Wrap the GEM object open and close callbacks with a RegistrationGuard
> (drm_dev_enter / drm_dev_exit) to ensure the driver callbacks only run
> while the parent bus device is bound.
>=20
> If the device has been unbound, open returns -ENODEV and close silently
> returns. This prevents driver code from accessing device resources after
> unbind and is a prerequisite for making drm::Driver::File
> lifetime-parameterized, since GEM callbacks receive a &drm::File that
> could otherwise be used to access invalidated file private data.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/drm/gem/mod.rs | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

