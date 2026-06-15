Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25507CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 17:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8086710E4A6;
	Mon, 15 Jun 2026 17:11:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="clmc3lVa";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021131.outbound.protection.outlook.com [52.101.100.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B69010E4A6
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 17:11:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNu6BeCaN1U0hNzX8/nuabbfE65EiYKP79wu6PAOwXihujvMl5WclgQD+Frd8din+hB6k43kbAMs42jaLjCbllUqiEPDLKYfqyhLt70Ks383Tk+j6uwrmOMM0JvCBiHelxs7ph2xrnjhNeUmo52LnE5pmDYtPMNohJssgdxC5m6YufheQyHm7CTeLLx24WVzLxtz0VL4n6L449D4egxvkw4tSonsXvkGJstIIjqSZuHedAXRB8Fl9pWU5OlpW/Xfrr0HArZ6wh8JXMn3UdqOSBX6lK3UPRE+gn0WYn69YsoeoXcLzyAbZiTn19C59j8CHFJocm7WF4gWaxg3HPOp/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qebyRJPEpG7Gp1bI5VWjLXKM2B9erhMe20TRNgjjxSs=;
 b=Hq2b1nrpJzsbzaXunaO8yGl3P15BxZjjl6cZtke2psHBb3YKQGgv6DVQMb53idn10c0hXHltLw2I1ef7IDIc3V5qCEEQCKyubZnQmxOQb42rhGgfEkWsNLQitaxkmoV2uUTz1ufUh6OpRuRLzdnR+7R8tCgOxkm6i89eXIeW+ttBYH/nNWtBfTbqlHNik1B00aFmSeW13U+zQl938dat/W0rnZGNQTwK/djVKPQfDhUIfZiMmfpdu7MCIopdOGElUuaQbdxTKVhLWqPL2zTFuAy/izEYu7zHETo0YTui6KPNxwbAOTCMzax5rYx4c44iGJyEmmY3N4IVvgRweDJdAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qebyRJPEpG7Gp1bI5VWjLXKM2B9erhMe20TRNgjjxSs=;
 b=clmc3lVa8VzaQmMea/XhKH2P50/Q5dt5ssDKTvNzf+Q5/INJUIfWi8S2XWOhqd4rBZ4tvuYbdMueMSbmt63uLS5kBtLBQj23aPh6GYYYJthkiIPf2vSwAGFQ84gQBY7Q94M0JLAIjo5S0vpAsu0/7vxQZ2s02HD7UkOGVaa2tTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB9152.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:270::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 17:11:17 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 17:11:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 18:11:16 +0100
Message-Id: <DJ9SGEPBEHR0.R2JB1EQJQKT6@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 01/13] gpu: nova-core: fsp: limit FSP receive message
 allocation size
X-Mailer: aerc 0.21.0
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
 <20260615-blackwell-fixes-v1-1-f2853e49ff7d@nvidia.com>
In-Reply-To: <20260615-blackwell-fixes-v1-1-f2853e49ff7d@nvidia.com>
X-ClientProxiedBy: LO4P123CA0686.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB9152:EE_
X-MS-Office365-Filtering-Correlation-Id: 336429f8-0645-4681-9525-08decb011ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|23010399003|10070799003|1800799024|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: awEAhZ3rwOnScHwdV5NlwyAEIYarQVx97rIOteGmvcVceAS0gXWr11g2Dsdpqr6SPzGkf/Gv30Z12tHTUywbSG7Xca/qYk+ePPXH2kKeWVtWs305fpZGlaeFxTBKbJYtkFe4aC4J5dfj2gXozeXiVn3Tg2cyHLP1MRzRwJCQGxvRnVHuPGs7e6VyIdTcGxnxjAspjsVw8hpW0e4dx/A8imdRnOyUBZ/J9ZVlQCuZ+LwOiNBMw/9DjqcpWwy2m2MatDr0J+W/c8czLNS5CMH70hR9fCzb1xrDi4AlAZOLm0iZrgaE4z2Ov8yb2b9Hujat/W2wawdhj8aThYsvpy2vbI6j1DmHQKt8t3m2+aWHaGpKMDVIqggDvoCpeBZ0gLljoIfnerVVz9gRxEtx6C1FINnbQIgoslTogiCk1GfL/IBTtEf65pUFpI4l9wh45dEI8Bxze9M/5GRphYGJ2Uy0TIjkg2a9t4Oa5ON/rW9dk+1N+Xo1gzje9jRJbN0kUuKYk5pQe9uxdzpba6P8K3MgrOHrc6ul94k14hSVV+gXf8hqF+8dMTT2ivxrJ19iCUH4M7eyMyZaQv1bfJJkodug1YsUrN0E/dp/tPg9sJYLa5tfHbGpeIPHNs8ypi3iSUZ+9uUUt8QFiCmnNJVTPdkknY+oVRuDWBxKapDOrM6fMvR6CjClo2wovcN8pF2H+ny/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(23010399003)(10070799003)(1800799024)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFFabG1BR256cEZVMHF1RVlNbHp3bVRnekkyVW9lcWVlRGg0T0Z2Zjh5MWJU?=
 =?utf-8?B?M21OSTZuZXhCSWtWbDA2V3VZMlg2aVdDTjBKd3Jiemx4QzdWb2tzVVZKY1Bu?=
 =?utf-8?B?ZnpGekIwckQ2YzhVdG8yKzV3SjhMNkl1Wkc3SENqclZibHhSYktPRmlKbGwy?=
 =?utf-8?B?RVlOZHFGSkNMQTA2b1I5bjZDcGlDWVE1NTMzdjJ5SmhiSkRJazJhVE5OUWw1?=
 =?utf-8?B?NDFBWnZVZTRLN292dld3TERreXdkd29ZY0VVL3dxR0dzeWxCcldIVml0WEJJ?=
 =?utf-8?B?aURZNUp0b2VjNmx2ZmZtMDVKT0RJYXlXNVhqNk5jN1hFQlZYYXNLelQzYzY1?=
 =?utf-8?B?bTNaNk5MZmUxYktKeWM2VEJJMmE5Z1ptemdXdG9xdC9wLzREdU96NWJTWk9S?=
 =?utf-8?B?RG01ZnJLTk0rRmN6cFZLUXo1cW5JZFR3NmJOckYzdlNQaHRVWVBwY2k5WFNu?=
 =?utf-8?B?bEFnUzNJMkNpamNobUFXK1YxNkVOSWtKMHJIUXBXenRNQURHNkVuRVB1OWps?=
 =?utf-8?B?Sjhhb1ViaUg1ci9mOTN4Q3kyTThkcXNhdXViYlFOU3JvcUhtZ3B2cWp3eFp6?=
 =?utf-8?B?RzIxZjJCdTI0QnRPRExYWWZhNUVqTGZtQkhpNGVaaVFuVHBtNUtCY3J1eWZQ?=
 =?utf-8?B?SU5rWm9kRDI2UXUvZnNubEhFQWdNK0VKQkFlYm1sOTRTMEJZVmFaVmNvY0tS?=
 =?utf-8?B?UnZ0aG5yQmc1VU1FeXphY2EyRnV5QURMNlhxUlNBcE1zYm5EVlpDWmdkS1pL?=
 =?utf-8?B?Tmw3SS80OGlpT0o5Qm5aMjY4b2wxcE5IWDZXYVBtNzJuTmU1K0F6citBNloy?=
 =?utf-8?B?cjBCRnpNc0VDMjE3cWZoMWlDRjhVQW82cHpFbktRNi90K083OUNocnZpaXRr?=
 =?utf-8?B?cytyM3VEVDFqUVJqUm90dGl2WHZobkNKT0RaR1M1V3NDbGpNZXBKaXRlNlBD?=
 =?utf-8?B?akhnNmVXbEwrQmhKVWtCR2ZVTWpWZnJKbXp5UXljb3plWDZWakh5RW53N0cx?=
 =?utf-8?B?ZTZJWFRhdER6SmUwQ3Z3b3doRmxXUzZZN1k4UmFMV2Y2eHFnOU81M243SzM4?=
 =?utf-8?B?aDRKRFplR0VGK1k0azNjdG93bkZLTng3amZFRWdyODFDTERTWlZRZ3ZQT2lm?=
 =?utf-8?B?c1RCdm1VREYvTVNBcnEvbkJCbE40NURIdCtZd280VkowaGF1ZWd5ZTRMZVda?=
 =?utf-8?B?dUo5cnFuVGVrTHhzVDYxVEhQZ3FGaldHL1J3NktmeHFXVXlUeUl5a3YxUml3?=
 =?utf-8?B?K1VHQ1F1cjlUNXVOZm1MNDl3eCtUdGR2NnlFeW0yYlJzRzhTZk5yU29YSU9Y?=
 =?utf-8?B?Njc4Znc3R3Fya3g3RVVoNXVmSmhTUCtUc1c5eDNhZWRYLzVWM01yVWd3YUww?=
 =?utf-8?B?ZmpqVWR4ZUk2cDFjU1c1LzhWOEJkN1N0QmxFTXNyamhVV2hFSUVXWDlWd0Yx?=
 =?utf-8?B?V0lNaFhodzVuNmN2Q2ZOSmVOcFN0L0pPVzF0K0hLUG8rS3EzTForQWtJV2RH?=
 =?utf-8?B?N3FEWkYyNGE4K01YTndCMFBsUUhvYkVlN1VTY0RtcVM3TUliUzk5eWloTzRr?=
 =?utf-8?B?dEFGSGt5ZnVjcVIxejE3dXdGYks1V01kUmJGRXdqL2h6dFVnazZQRTBhYng4?=
 =?utf-8?B?V1ptREpyUlVVc2pXYXlWUEc5OVFWSkh0UGswWjVXRzdPQzlaZjBrWkwwcHYz?=
 =?utf-8?B?dlhaNDJNTjdoc29WSXVYK3VxZXV1NXNBRW5tRmw5eG84T3BjcHNVWThPanRW?=
 =?utf-8?B?T3lmU09CMitQSnNUZXMyUmtlcjJYSW05dUoyMHVKb1pQRVlzd0RUWHJBcE9U?=
 =?utf-8?B?clVwc083a0t2OGk1TUR2UTF4Zk9lcnR0TC9VeEdqUjdjSnJHbGZjWDh3NGQw?=
 =?utf-8?B?dWVkUkh0K1hwREt4WWpySGhLUUhUZVA3QlBtNndkWktFSzA3Q0pTMHliV0I1?=
 =?utf-8?B?L2wwazNTWjl0OGV4bFVPQUpMZjl0VGhLQXIrR1FqcXBSbDArNHh5WHNQaUVI?=
 =?utf-8?B?YXo5TGhEZmhpa3JYTXoya09NR01PdGdhNDJNTFVwODlJZUQyZXB6VHJLa0RK?=
 =?utf-8?B?WE5CQVlJd2RzUER2bkxEZGVTWFBNNlVaUlNXK0JtbUt0WUVoc21sSm1jVEdG?=
 =?utf-8?B?VWswRjlPZnFkc3JvNVM4cFFBY2lBSFl2NUJkUS9WWnRMdFNOK2lKWjhyOEJK?=
 =?utf-8?B?b05HQWpyR2xDRmdrM3luMW4vRGxxQUgxbWFzMjQyRmxsYktZMVpMYXdzNE9J?=
 =?utf-8?B?VXlxeExNRGtGV2gzYVB4aUhzNEI2VU1rZTlvS2xnNXFWa0dmSDRSQmUzanZY?=
 =?utf-8?B?cDZGakxrYUNiTGh6NXBaNFIxT0ZXbHNHaENOMzVOTGI1R2dCZVF0Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 336429f8-0645-4681-9525-08decb011ccd
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 17:11:17.2387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KzKKXYBR9nLurKQ2OafNIKY767EwfvCFLYwvWUzQ+o9I/8b5iicoms6qbNDHA/6KZaEYLZwQhFZePtiDE5xYXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB9152
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

On Mon Jun 15, 2026 at 3:40 PM BST, Eliot Courtney wrote:
> Currently, the FSP receive message code will try to allocate whatever
> was sent without checking it at all. But the actual size allowed is
> limited to 1024 anyway, so discard any messages over that size as bogus.
>=20
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/gpu/nova-core/falcon/fsp.rs | 36 ++++++++++++++++++++++++-------=
-----
>  1 file changed, 24 insertions(+), 12 deletions(-)

