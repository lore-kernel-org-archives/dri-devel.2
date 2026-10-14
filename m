Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185E0CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 655D010E04E;
	Wed, 14 Oct 2026 16:57:57 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazhn15010009.outbound.protection.outlook.com [52.102.161.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09E1910E9CD
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:57:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+m3C1VF4RZJFdqFkcEvz5HBrPagEjYfHqkJDd14S8hNNRZsECtV9b+TNuhZ9/dcXUGlDfc7Uc32lodCO/bCHo2p3zdFrXh6qjCFchCWk5udyEMgr1okrSP6pJxgreB+TVIXmTtORWqc55GOeGepBCV84rJzQjF2sP6gzAxi7P6sHdR65M8uhqSwZ4/4clPC+lho3M4/KP/k/77Iuev2BDjXx7gi1K9o0yFBXQ9yVyBHnhKoHS5q6cSjXqEZqmfDVchSscaDKACrigIaZL7Z4MJ1mRVEvEN1icZHFKzp59ONYhEpsv1SJO30DqbAupgygjI59R3DkSG3F9U75pdtKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFIQspE78173JERdSzX9t1NRuY8+2KrnZKd62sGFYCg=;
 b=ozOGo6Bnh3PgLjflAVSNLvMowhtQYP+181FNk+vgRqpv2HVP2MJAST7wrUBy/ojWTbAIxV+Onzv1uZN/gRAK0mi464z8JdIwi4LSAbYx+Myc8ZBL7CYKYMB7a3t56JWk7Z16iScMUY0/0c7h52TtFn0nmELe00452CpnBVobVymMC145VY/oUvgaxji7W27UAMDdHYHZKrHI0U03b2646Dl0Bm6PlflxL3e1JmhLcA17GLBKSeMqtbEQMFULskp4k8szXDZ39+NIs97fhMzg6ywTjdHSu9HYcLhzYlWkSDpXBvt0uD2KGhjUNRiA+MOl01z/I8swXivMnNLtruzymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=intel.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFIQspE78173JERdSzX9t1NRuY8+2KrnZKd62sGFYCg=;
 b=bFAbFt30DdTswDWEMMnXa6u6wTBOkJ1AKnS9/9kdk6m4wvZAn+CPF959/KYpGmADPwjjFIOTucEfRYC9UuS+qcyO1SLN2iakOGt9C80+WvCcooSidl2w/r1ej0PtqL1Dm5ClRVxI5dzFdTyQOpRZh9AXPVFqRtA3PSBtVDyJ3ZfGq5iURXOlCG4YeaKsn4CYjg1qZ3+N4EEalbHJ/pimSnJwbBs/7NYVq+/jBXgpz1Q2hZnfPgc9B4/KHhSVXGJtvvobYiZSMlsJxowyNK+lpQQKnUyqv8EVAl+1obtxKWLJhc5YpC/C/LZi5Xd8uHfe/ywHjcLvcBfvnBJmW7ANcQ==
Received: from PAZP264CA0008.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:21::13)
 by DU4PR10MB8999.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 16:57:46 +0000
Received: from MI3PEPF00008491.eurprd03.prod.outlook.com
 (2603:10a6:102:21:cafe::11) by PAZP264CA0008.outlook.office365.com
 (2603:10a6:102:21::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 16:57:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF00008491.mail.protection.outlook.com (10.167.240.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 16:57:45 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 14 Oct
 2026 18:58:12 +0200
Received: from [10.252.12.121] (10.252.12.121) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 14 Oct
 2026 18:57:44 +0200
Message-ID: <0cf0f3ca-bcb5-47d2-a4c7-9a3ab03d7293@foss.st.com>
Date: Wed, 14 Oct 2026 18:57:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: adc: add stm32 mdf support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>
References: <20261001145702.2628429-1-olivier.moysan@foss.st.com>
 <20261001145702.2628429-3-olivier.moysan@foss.st.com>
 <ar6wypoRS-5j9iM7@ashevche-desk.local>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <ar6wypoRS-5j9iM7@ashevche-desk.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.12.121]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008491:EE_|DU4PR10MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: 176e283a-aa03-45a3-a395-08df2a144522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|34020700016|82310400026|23010399003|36860700016|7416014|376014|4143699003|56012099006|11063799006|10067099003|261009221227099003|261009223027099003|22082099003|18002099003|6133799003|12100799066;
X-Microsoft-Antispam-Message-Info: ehFrLC5tsuaw3UcBhV4KMCcjdjFm3Xaxg9MbKLnppFd8IHpHv6CW6rGzpoH1OoD2ytc037izurA1jpEZYEIWj8b/VdzNN2hkiwT0WPQA0coCWZyuA1+DOB3Ahfhw/jTihRh5DFRFsDVvKumoPHTRhG2xjR0eYpkiCe7PxWvx1g9dmU5sv1xBSMojuRk80Ssf9q+If6FJJUZKRPwNWDont51O4AxW6beQltXw0d+tU2itwRdNyNaLnhOYCgQmmC7ir1UBq/z56ae7axb4IhDSgCC5AHXnApRQJekm3HJ9POR3xYTHLNvoGMJJCAtlnwRoDR3/eBxvck9dfV9IxOyj/lGFjRFi60oRFrbCaRFTA88Xv0KSZfBfylrAy1H7nl3AuA3+/E5eR3cRT4uFJEYV2iYWOLsf8/zgCBTtdJV3C2ixf+hwUs0F2WnP8xUmPLynyIjBIWvHkWWoxzs/j2x3h5XLnSUzJ6LyXVE5zwIEQhO6AzP/g2upqkOV9p9qrO1QyHI3H6tZCupFFpAuGptrx9BqfYHPS36AmYAs0HEdyOXIYR5JVl6lxk0xHBgtdFRj/vO05kevH3gcCzApKTggL8XKvaLYGhboXBwE22W/aOBhSfynKaBOMCuIC1VhA0i2IMsLoJwTdzBT52doDzpMo9+AubWPDXVnZnMY2c0Sl4z9RWkFJIhVnBdrv6B0Nd6tQGBFv3QckLnh2Hh8jqmvnQ==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(34020700016)(82310400026)(23010399003)(36860700016)(7416014)(376014)(4143699003)(56012099006)(11063799006)(10067099003)(261009221227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(12100799066);
 DIR:OUT; SFP:1501; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5cZJCHhw/6cOM0KYgDWB2RtGzXCJ6toa5McRJS2Mj33g8g622eQqFBH794aqUHj0rakygtWCUem8o+C+yfsxLBhHdRRg8Wktih298E7w4KCF2RkqxfEKt8TW1ssQtL6ke58gMIcctbhz5O3mU6PDUIuQuCiiaalIxY5IwY+E9r1z/R68YfTuYyg/1sAhmSG9Zh/hsVdGBriU/4E/zpgea0sY/EF1IkowodyZdIjsiBcbLuYo+5oOwkT8ObdLo9tA4vi52dccqi4JpjhS0kskWzIn2UFEVGVkpCHNjdV+FNnpJ9oLyZFysAmlPok85XrJLS5NarlGDWAPMcp6uQSpjo1gXibFMsGc30qjAp61TgU2oizMYjiOFf0ME74OFFkxZ5bZGA5qCrnhAsg/F6OkGFNKG7hxadvnP5r+Vk0w1+8gUBmCseO84doPVnNRuUk1
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 16:57:45.7078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 176e283a-aa03-45a3-a395-08df2a144522
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008491.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8999
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

Hi Andy,

On 10/1/26 21:13, Andy Shevchenko wrote:
> On Thu, Oct 01, 2026 at 04:56:46PM +0200, Olivier Moysan wrote:
>> Add the STM32 Multi-function Digital Filter (MDF) core, serial interface
>> and digital filter drivers. The MDF converts bitstreams from sigma-delta
>> modulators or digital microphones into samples exposed through IIO.
>>
>> Audio: capture PDM microphones via cyclic DMA for an ASoC consumer.
>> Support CIC scaling and filtering, synchronized and interleaving modes.
>> Audio use case requires a DMIC filter, and a separate ASoC DAI.
>>
>> Analog: expose sigma-delta modulators as IIO voltage channels with
>> direct reads or DMA buffering mode. STM32 timer triggers can be used as
>> clock source.
>> Analog use case requires an IIO backend for the SD modulator.
>>
>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>> ---
>>   drivers/iio/adc/Kconfig               |   27 +
>>   drivers/iio/adc/Makefile              |    3 +
>>   drivers/iio/adc/stm32-mdf-adc.c       | 2078 +++++++++++++++++++++++++
>>   drivers/iio/adc/stm32-mdf-core.c      |  857 ++++++++++
>>   drivers/iio/adc/stm32-mdf-serial.c    |  309 ++++
>>   drivers/iio/adc/stm32-mdf.h           |  312 ++++
>>   include/linux/iio/adc/stm32-mdf-adc.h |   19 +
>>   7 files changed, 3605 insertions(+)
> 
> Unreviewable. Make sure the single patch is ~750 lines.
> 
> 

Ok. I am preparing a v2 series to reduce the size of the patches.

Best Regards
olivier
