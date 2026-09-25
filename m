Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB145C9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 10:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E10D710F9C1;
	Fri, 25 Sep 2026 10:26:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="Q4zNbtax";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020117.outbound.protection.outlook.com [52.101.195.117])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C116210F9C1
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 10:26:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k728eXgz3AlXIa7rStLekEtyNUuA76FLNeaRi0loNxquKEW6281pSj8lswUCxCk+4zC/cHce1KcC1PIhdLI75rTysP3fUe/E7JpsPL/q2061EgA9G3WBJsgWpKZ+s0rrk15IiJCE4pRg8f/P37jeLvErHfq4XIjMFDedZoBnvtxILJVG8m2LjBNOM91JRGiKwKdzJu6ecpccFoiw+/c6F9zb5qlPMqVDuusq4Qaq10VW16PPbKNaWhYgoEj6TlVBAvqjPi6VWyAWOV5fTibQVxWxKWAmq7zZ2a9eZW4QJJbYaMuniJppeJ3Ipw7rP5WQfIEQq7PRqUj1m0UxdoHxyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZJu9LoV7syLi+e6CLD3MHg/aKox3Bc7UM3+IlGh+m0=;
 b=xuwNpA45vshX4FC1jvSDY8XeT9lkNrqLc/0RHYZndKRV3WOJv5yeabq3ww7yW7ZFtvq2BqW641MKQCYaQA/sP9b5hSeQoq1BIPIG8xL5vx+QJchRH4+HCb6DQxKV7WwtqiM3ZXjVd/tebqwCzpECN0ExxzNrXwvfcIo8NR2T2SfiibHLZxOu19cukaJLW4oURpWcPHDAThgYhy4efweCZh1xkFFYLozh0277ytTBFwC8GMnGo2x8AYJVwIg+1rt2QeCXB4+8ff3Lzm98B/tTEzMF2eFYtLg0oSRTLGxfuyIUNXYswlaAKrrrXr6ESZJLhJcSOI8WlGF2pP45iM8W1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZJu9LoV7syLi+e6CLD3MHg/aKox3Bc7UM3+IlGh+m0=;
 b=Q4zNbtaxX7ca/IRLHcLo/HGOwdy7oVqX/cEBUacoEtMM5YfcMexIctfTJm7MTUrqYkZjrb3uRPFj5CzHjTf6V1bWMGB2P1lVADizj5DTw3iGGqTRZa4Zf9mSEDGA+U8jXYOlh3yjiNbCd64SZJGXGV5A+QrXtlJucTL0dKaVVO0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB3010.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 10:26:23 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 10:26:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 11:26:21 +0100
Message-Id: <DLOBPY6OBEOG.2Y4I4LRA276WU@garyguo.net>
Cc: <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: DmaFence: Add better warning through Device
 reference
From: "Gary Guo" <gary@garyguo.net>
To: "Philipp Stanner" <phasta@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>
X-Mailer: aerc 0.22.0
References: <20260925081958.3048112-2-phasta@kernel.org>
In-Reply-To: <20260925081958.3048112-2-phasta@kernel.org>
X-ClientProxiedBy: LO4P123CA0406.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::15) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB3010:EE_
X-MS-Office365-Filtering-Correlation-Id: 541edd9c-de4e-4f4f-0a2f-08df1aef723a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|7416014|23010399003|10067099003|18002099003|56012099006|5023799004|3023799007|22082099003|921020;
X-Microsoft-Antispam-Message-Info: N64gNEEOtYJBrdYvM6wke8biTp3UKKbxJCpqzcmuYTLJpmKbtVwDVQ3oI0y5sBLbSrlao62oCSbNbhE08h2aPRIc+KEuvRxg4gwFg3bHbOX6khmynny+Y3ryPEzRZ+omxxY72d83au7WCFRwX5IHyIiK11I2fwF6ljAf90gmud6Vd3I0IaHAf/KrjSVsmVEihKg57nQKMPuezAXpJw1EF7VM42cU+JhYfJiIAsnkON7KzOtVLjInW0tI4gTXEshNJ5G9NrKBs4ICovUBhVmnQKmJ4/VPbVLUCqDyBJk9wF75oDDB6p3NOB/Fp21nQPwsv7FHWhxlVohwlYtFsmiLGAG9aSWnbas/GRO7FlZ6S9ldGKR56N4187ikdrQrPHwK4LnpCoTBPu9QCNdrbic9R/8rXY1QNEn8Ohb+EdhEBN8khumXtyNzXI1jt/AWcwtzZArqNHpVg6EJ2G6OX3AZdt+aWgCtIrBAqqVJxji/jg+OvH0EWgXKFlCLjIijSRkyzJ8SMwqY6B4nBcdVzTbrMW63H8DBh9mWuL/20npPkXY1FcXT53VBVhl2tFV94PnT4sQ5sglLCKL2w3YCocxucrafA9MblXA4MLNkjcuxK+IOjy57OAe0bm7FD3oM49x0D4YfVnT2LaaVj+NtEnQ/tlFKyuuZf+PdgSkuMss1Af4p8BXPlXdbwgrRcRuZ20TCtz/cLJriOBqEXSHGRIELNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(23010399003)(10067099003)(18002099003)(56012099006)(5023799004)(3023799007)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVFmTVFuQ08xV0NhaUROVnZFTFhHU3FGYkllOGpKNUFid3AyRWtJN2wxWXRO?=
 =?utf-8?B?QTFlUWpEdE9PSTA3cjZ6amNJd1lzdGxyTWNpNjRWK2Y5VHlGeHRFdVViWU54?=
 =?utf-8?B?V3V2b1g4ekJOQlowcnFRbmRRaHRaVUdUemIyYmM5bXJ1aVdHWVk3SWVnODAy?=
 =?utf-8?B?ekViWVRWZUFnZ3RCdTRxOUxGTWV4bkcra1VSV0hwZXAxVGdzcXZ5Q2hpU09O?=
 =?utf-8?B?ZldRYjBtMXp2WlJKY2x5WW1JU3pKZnZtMldDZ0pybGVpWnBQUDAwYlhUcXQ0?=
 =?utf-8?B?V2l2UFdIWjZ6ZjZ1RVhMWWU3bjVKWUJEV0YzN3ZwK2hmNTl1ZjQwbm0zTzBw?=
 =?utf-8?B?amRKWTY3YUNXYUUxelpXWFJiQlpZY05RTlJXVFhiOTgzR2NYbU5RZmk4Tk9w?=
 =?utf-8?B?Zkw4ektmNVZVMjlqSmR4WFYvZG1IYlNRQ28rd2NiSEQ4dnFpZzlWaVk5K1ps?=
 =?utf-8?B?cVRoRFZad0ZpUWJPMEZma1FkVkdJK3RnaXdSeFJnaERMdlZUTXFRYmUzMlpn?=
 =?utf-8?B?ODJORWZhdVEyM1hsNEZlL3JoNFZ0QXVjTXU1b1hRdUg4ZEdXTXd0SXc5eVBk?=
 =?utf-8?B?aUg5MFBYVWNoNmFKTVVScnYrdW9hbnpCRUlSNSsrMGdKTWpzM3QxRU9EVVRD?=
 =?utf-8?B?bUVkU0pUTzBQU1NEQnB6bDdVOHF4Vi9YU0FSMGQ3V2oxN3FueWY2TjVEcGRZ?=
 =?utf-8?B?d1IwVUpaU21nMzNFbHhYakNsVlk0VmU3cVd6V295UERlcHYvRGR3YmF6emM4?=
 =?utf-8?B?ZUFVOWRNMFJDRkVmb3VvZDBTRVNsbnFucDFFRWt5dzhjRXlkZzVLNENNV3FT?=
 =?utf-8?B?d0pYQU9jZjZ5amxnNmhDb2hGVzlQWFV1V3NvakFEdGZqdFovRDgrelJWeHRH?=
 =?utf-8?B?NVRySTZnZHVYVXR2WDlWbEtrcVBBUkJ3RkhZZWNNZmlHWDU4M0c1cnNaQldC?=
 =?utf-8?B?Uld3ZEkzRXRDajh1Ulp5OTNsMktVcmpCbU9aM2pVWnFPOHhPRVdQUVJJUml6?=
 =?utf-8?B?NXFvNkZpYXdwWXByUzVtTlY5aGdJSWptU2gwZnZScS8rN1pLQWVzWDkvYmpB?=
 =?utf-8?B?NVNPRXRERmN5cmFxM2F5Y1h1NjlrZDR2VW5oUk1ra1hHZ1BJSE5MQld5NnlU?=
 =?utf-8?B?UGM4Rmk5UjJnZEt5YzliOGl5SUgwNUVvL3NMZ3dlT0lQTXIyYlpJSHBOcFZw?=
 =?utf-8?B?bnlySEk1YnRBVlQvWEdDUTVPakphVHg2T0FaTmk5UVVmZFVVT1UvVGdPN1Rt?=
 =?utf-8?B?bUpQQjdzTWNacTlHQUp2aTlwaTl4WDU4T0FkYWQ1eExkeWZFMUVBaFVxWjJB?=
 =?utf-8?B?Q1BuOEVSTUN2MkJBVUhrVGp2ZkFDSks0RVg3NTVYMUF5OXRuR1c0R1hEL1I0?=
 =?utf-8?B?c2lGc0ZjeTlhV052bk92TUNqTkRNd05obVBXcUZNTm0rbWIwRklrL3RrVmZI?=
 =?utf-8?B?MHpkSFdtbTRiOHNsUEl0YUJVYzhJeXF6bU0vOEF2WkJnSHZTbFJKeGx2NjU1?=
 =?utf-8?B?NkFhUlhWc08vN2tXVmNkTlBKVEJWTjdNUkZSS05hb09YbERXdHRSbDJzR3dx?=
 =?utf-8?B?aWg4eTl4T3NZanlLL1FyUlNTcWVrM2NPOWZ4ZE0yN0FsdXhWc1B3aUNubDJK?=
 =?utf-8?B?cWU5dFl4SGxOcTNKVGlpVEZoSncxR1U4eWUvN3BhN2VyVitVbVU0MndmSEdt?=
 =?utf-8?B?dEJuREZZYm83MWFXSE1TWWQrbUV3LzZHNW52SDNaeFkzMjFabXpGcXVWaWlP?=
 =?utf-8?B?eWJGNkhadW5uUWNhdUFWRkFPVWJHMTd0U0FISnpidktTOFhuTUlMTkl0Qmd6?=
 =?utf-8?B?NzdsQjJKZSt2SlRpeTdOalhpcTRRRjZDMDBTT2k3aCtxY2ZDaTZpYTFaT0U4?=
 =?utf-8?B?cCt4MXk1WjFBVUFtcVJCcyt2RDFVa3Zud05vRkVtT3RheFh5aTRRd29URUJm?=
 =?utf-8?B?dXRWZnZIN2lkWUo5Qi9kNjhjMHI1NFN5UDZ0eWpPWUJpVnZucFhuVE43Y3Nv?=
 =?utf-8?B?d2RFRmd0dndXNGRiN0R4cTdGWGMrOWM0UEw4cWRHdTdtbkJGVURJejg1dy9R?=
 =?utf-8?B?bXlLZDFnbEdCRzg4ZEtQL0QzakphUGh0WTRTTk9jV3dtUDJpU1ZhVUgvRGR1?=
 =?utf-8?B?SlRvWWtmaDR2Y3dlZ3JyVHNycWRMSm9nRUNrZDMxNWNoZXd1ZTk2SFFnbVJ4?=
 =?utf-8?B?NHpRU0ZCdVZDcnlGb2VGV3ozY1N4NnRESERTRFBnZU9xVzVZTUZoUzNvaHUr?=
 =?utf-8?B?b3pmWGVWMnNnbWxVT3o2TGZQa2xOQ2JPQytzcXRLTWVGa3BETEJGcEpQcDNC?=
 =?utf-8?B?bURZTUFLRTJDSW9Xa0dMZEkyanVKUVpidjd2VTZMMml6SjJqTTNrQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 541edd9c-de4e-4f4f-0a2f-08df1aef723a
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 10:26:22.7230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0TR+H+l7BUu7tc8BGXyxiXKJ5Jl4taR8+Yi6sTvDMakLwwLBJ8qjqKwj/4/FMck1kwvttVCDz5lvi4KFdxJ+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3010
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

On Fri Sep 25, 2026 at 9:19 AM BST, Philipp Stanner wrote:
> FenceContext::drop() contains a warning print that warns about possible
> memory corruptions if there are forgotten fences. However, precisely
> speaking, a forgotten fence is undefined behavior.
>
> Moreover, forgotten fences hint at a severe design problem in the
> driver. In this context, the used pr_err!() does not provide very useful
> text output.
>
> Replace the warning print with a dev_warn!(). To do so, have the
> FenceContext carry a reference to a Device, protected by the already
> present lifetime.

Add a lifetime just to do this a print doesn't sound ideal. You could use
`ARef<Device>` instead?

Best,
Gary

>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>  rust/kernel/dma_buf/dma_fence.rs | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>

