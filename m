Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB69CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 10:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDA7610E1F3;
	Wed, 27 May 2026 10:35:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="DGvlhWdW";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020088.outbound.protection.outlook.com [52.101.69.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2567C10E1F3
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 10:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWh1NyDlJgWpxCMkUGUrFTtxbJyXDjn9qT6xzszxFqJ66ag//UrXgFEnXWS4cEjSRng1gmZZy5S/+CuyLR6OmepuMDLTi8waJZzYflX6FmlihRg1dXAISW2vLeYygQzXUY5bVLjsKojVxwg5UrUWp1ZZzLWml1bcDnnQVPoZ1+NsR+CWRw653i+widEdOoAwmkcvX5sanreQZob66LUAkuGjr+rXgyP8m/Vl+hATe1ub7LViJVlMzk4UEzMSSAjKKKwcgfOaQTxTJAQswY7tGEg9CoqKTDRNcqFdLPe1SMt5eeleqxkTAqbV4mTyYXGWoMfsmIRLBbRZwn16P8XN9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUQA4NtnoU4DLQIOZUnX7Yw/AmmOxMCla74NIttugpg=;
 b=KzLpG7AiANmR0YEmX9ijvSzyr88frKFuErstoFE2cfsvQyCetRq6vY58x0sAHdiciEfmd74lHxcVdwgnwcBXTj+Z6QO+IRWJEgkpcUR+Wqi2yqfOSaClUd8340hQ5Q+AldazXypEBwEvB5UvLHaOj/y9BC2a8hhm8WZz4pry9eIET5O7S1QQoYfGGFsLIEu7yuzxJ9HkOiB5jiCgCG/gDTsvBBnQVoEqKZcF8KzbKo8lwQ3xAU5BdVP/j5+i36zW7tgS6S+4ZoilJ6D0jmuIrJ1mdP3HJcgC8txne6zW4lpwJjvxse2D7rXJrbt5NZsUe76QdH9yw7ennAWX496zvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUQA4NtnoU4DLQIOZUnX7Yw/AmmOxMCla74NIttugpg=;
 b=DGvlhWdWFTMqpzU2n0tc7gwXgzIHYNX1oZ6tfbGspVfVPWyUEBpjV0VJJdycK0i/IzjXsrnK85uWkpOY2GNW7UXhSy/NGCq2dEgtRARTGgEgMmA5ouNshm3x8fWA5tUQP65cL6b5hn3s9aHvokVsg4R4tWEH5/Fne0ACia387o8iOtfJRA3OsdHdEvTbiOyp3m5qr4zoAGt/6QCrK9ZE5qzVyBY1Ar3fqQ1qo3S1ISS3NjWu/83gBMVEwuvCWjaOp6J+ijNYu1jlV533MS1UOXtAyDqzeTCvRnIJom9YY4B3EYGdHnsneGqWFXxVuKGVnArwe3ben0dArWhDL3ecKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by AS8PR10MB7563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:563::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 10:35:48 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 10:35:48 +0000
Message-ID: <01c33cda-e6ac-44a8-b1eb-8a8d7118175e@kontron.de>
Date: Wed, 27 May 2026 12:35:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] drm: lcdif: FIFO underrun/solid color bug fix
To: Paul Kocialkowski <paulk@sys-base.io>, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
 =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
 Marco Felsch <m.felsch@pengutronix.de>, Liu Ying <victor.liu@nxp.com>
References: <20260402183351.3281123-1-paulk@sys-base.io>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20260402183351.3281123-1-paulk@sys-base.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::15) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|AS8PR10MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: c135c3ce-031d-4499-a868-08debbdbb73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bmDjm3sVDBRd511q8QlnmRWyGLmInVd4OufVtCs6r4K8YHK4rilby4XgeV2XzZhV9EKM9rFzNzmrMu3PJEkRZyj9pXZrZYLq/SeYkVMhCQM6bDa3HKhSeD39of40dAg24+aAkJYFSDrKywB1zbbuZV3GXcZislu9zaMi4AgzECZZuDMHV4F1YzHM7hcBq9RPpb65LDIR9jWNQQyXfD2R6MvSW8bvBi+Jpzo9DG2JdZXmNP+BTfpAnj6/u9XK4IY7j+2b/pIUVr96zm8gFpASyYxuK9lJI/cISROvDtKavxd/ugC7V2V7TXP/r/gXycSaH3icRUDA9JPmUxxcnWoEJRE+Dv4Za4pOnkJHGgvZNStsWiv35kd+CZ8NeRZ/LlIU/KeGJgkDA8u1a78YXbJqpKEgzsOKWgJ+bij1JLADKypryx75XwOctvfV/zaSmvAgw9JMQ6wff2qD9Hfk0+lmaK7TE2YphjGFfr5lF3FjzNnMJPmWmC2efiPKyPsIudWYgtrvp3TjGNE9hnVjVNHuckKKuAjwyfzCrhljr9gWMTNJMB3xuYcOA8jzs7jZ4HsTyD/feiogfhHeqLzmpk3DJ03k1deeXZpzuhzBGTrfLMILVyoDgRxwYedJtnmtFu7dF2Q8i/DQzVqOg6ln6Z8fYsQIkKd/y5KQ18l2avDRc5KebN9UupME39RktfdP487U
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGVEbTBUVE9OUEtJd1UzbSs5eUFlWUQ1bTZpbm5WczlONzhpZ1FKUlVmSS9T?=
 =?utf-8?B?b1dRQ3QzWlpiUWM5VUU2RTVsT25kRm1WOUQvdVYvTm1qamZSY3pqSnNBSERY?=
 =?utf-8?B?b2d0c2dkT1kzUEJuWG1vVnlRZG5CQ2hmVW5STDdCaGE1czkyVWd2d3FUKzJT?=
 =?utf-8?B?dkJ3VXNtZ3RUOHd5dFlaWXZjQmcrRDBNNkQ3UXB1SGhRdWs4QUEzcHp2RHNz?=
 =?utf-8?B?YVBEdFMxelZScDB3WkZzSTVzWmR5UXo5cDZya2x1Y0k3aDBHYU9maVRqTHRz?=
 =?utf-8?B?Y3NLU3MyaEVTYjJHZFkrNjF3SGV0YXE2U0xkdGpKbHdiMVFtaC96LytZNTZI?=
 =?utf-8?B?ckNIYVVvd0EwWHcyL3p3c1BRVWlvclAwZmZwRHVPZXZVdDBwVm5ZWVNmMldp?=
 =?utf-8?B?NlVEVjBBS0lqR0czeXNVWHA5ZTJyYkxSazVndmpQMkUwSmJNZSs4dG1BeG1Y?=
 =?utf-8?B?YnRBcWo5MmtSRCtYZVZiZVBvWXduL2JBeWxvbWhjVUxnaHU3TnBoZ2VvenQy?=
 =?utf-8?B?VzlLbXZzQ21YcWxYSUJZN0YrREd4WjAzWTNEcnFnVGVrci9HcUEvdmZkNmVN?=
 =?utf-8?B?YytKaVBNNXNZYm52eGxOR1R0WFdqWXBFcjBFY2VOc0UxeklwbGxsdjBhaFFa?=
 =?utf-8?B?OWF6OTlBMmxhU0szREtlNlpmNkFWeFJpNUt3MkFGVEVmQzU4eFg2TnNtbGtz?=
 =?utf-8?B?SXJKUlF2SE42Zk9jd28vazNEbU5wL2YxMGRtSnlzWTJCL0Q4My9NWS9ZTFVB?=
 =?utf-8?B?V1pRVkd1RU1ZeStmUGJROE5RanZ3SEZRYmFGV0ErR2tHaUZ1N0xPRHFneWJ2?=
 =?utf-8?B?Y29rcXF2eE03TGlpV3NoNmxISkQyRXppcUJJa2hoSmhVZldkWEh0cjZXODBr?=
 =?utf-8?B?WXlvTklMK1VZMWNRL2ZFOTVMME04MUF4ZVRtakRBZnV2alRCRmpkc1IxL0hU?=
 =?utf-8?B?MjhselZEU2FVZDZ3dVpvTHpJNlNlMm9wZDhvZmczMW52QjY4b2g4QUN1SHND?=
 =?utf-8?B?dGRnQmxMcjBRNHQ3OEN4b2JDYWdLSlRxN2UwMmNFa2NDaW54VmhDU2l0dnRs?=
 =?utf-8?B?WlY2N0FkdlFQZ1R5MDhKOFptM0d6VlN1Z3MyYlU5Wk1LRWlDc0hZYU1yQjBB?=
 =?utf-8?B?eTlTS0lIakpyZzQ5aTk4MC81Q3ZvQklVZGFXd1M3T2NsVkFhZWl3bG8wYURD?=
 =?utf-8?B?Nkk0a1hkNS95bGZyZ1pqaUdZY2M2ejV5UDlNNHhWNGNwUW5nQ250WE44TUhq?=
 =?utf-8?B?bHJFVkZVbGpJNGxpUHROblR2bEtvZ0wrRko3RTlObXIxb3VqNS94MU0xenlx?=
 =?utf-8?B?dmJTZ1ZEdkZLRnczVUtIb0VPNkp6Tk80L3ZNenJNSnlma0ZOV2xHdi9MSnRI?=
 =?utf-8?B?dmFwdmhJbWVCZnB3RTZRL2VpeUJVZVZ2eHBUTUdwMldoMCtCK3owWUE0NmxB?=
 =?utf-8?B?SWhyY1J6YVArMXR2aGNJeGpDUmg1eGY1dDg4VXdhQS81bUI5bnFxNjBDMTNJ?=
 =?utf-8?B?aGpJWEl5OFl2UGtWMGx1TmIwTC8xVzBHUmp1aW4vVnV0V2gvMVdUdVdFRGJm?=
 =?utf-8?B?dFUyU005c2RPbXVBa0FhZ0FMbGNsWWZZTjNRNUdHU1RVMjU3aU95Mi9uakpD?=
 =?utf-8?B?WEc2MkJ4YWgvNlBFWlFJbjNxU1RMSlBMRkJ1S2cwd0xIWk04UU9ZNlJ4cVlL?=
 =?utf-8?B?R25uSkNBWUZGSU5BOXdyRTJhOE9nQ2FVL2Q3TmJ5NzdTUDV1OURPQjBCL3Bl?=
 =?utf-8?B?b1IyYVdIdGozeVRndWp4VW9xS3c2dXBobldkN29PSDdLS1ZLUjZkQmtiVmRL?=
 =?utf-8?B?NEpSayt2d3pzcHpPaDhERmZQajZXOVBnMDFqOTljVjE0dlhsVDhscHpRZDFM?=
 =?utf-8?B?Qmh2VWc4NzVIeWtqSWVyM3NTVXRKbEw1TG1ScXJuNko4T0hRNGJGVlBHZFl5?=
 =?utf-8?B?cDRCMjFYZk96SmpYbFc5aWhUbVhROFhMckhZNFRXVjRQTG5ETnpGbjUzVXlO?=
 =?utf-8?B?RXhjOFNQWkVlbjJJM1JjS1h0VHhaSkdvMThFQnBGb0d5MW9ESTFobld4K3ha?=
 =?utf-8?B?bVZGU0JjTHJFT25BMWdaN0MwZ2V4WU45bVlqb1JPTzNXbU1pV0V6QWplbzJS?=
 =?utf-8?B?amRpazQ2TWg3NnVDT3dlVklTRXZLRU1lZTNQeTlkQXRyeU4zQWFJM3ZEVG00?=
 =?utf-8?B?bGFsbmRRVnVoNXhjTXh6YVNPSHhabjJxaTVsdGJWUlp1dkw3SHNtTE1jV2Ey?=
 =?utf-8?B?Z0FtY1l5d24vWXM4QjR2VHNGczlHaFBQOEpqekdEZ3VkR2NpNDJSWkt5Q1JT?=
 =?utf-8?B?TXMxRWlkQlc5dXZUMXdyczdIOEJKMGplV2p6TFdGWnFHTWYyNGtSbVlwZ09E?=
 =?utf-8?Q?SK2mUtxg2ggLywj0=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c135c3ce-031d-4499-a868-08debbdbb73b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 10:35:48.0528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKQYDKfk5YWCeXGXMoKp+Hqlr6duySBZCGGUmv4culXw8IRzYvf29uhIFy3GPo26U5vqPhvsg6XsregR5yxb7MK6cwU8Zpjx/Cb1DPcZrWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7563
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

On 02.04.26 20:33, Paul Kocialkowski wrote:
> This series brings a fix for the FIFO underrun/solid color bug (in the
> last commit) and two other changes that may help with reliability.
> 
> Paul Kocialkowski (2):
>   drm: lcdif: Set undocumented bit to clear FIFO at vsync
>   drm: lcdif: Wait for vblank before disabling DMA
> 
>  drivers/gpu/drm/mxsfb/lcdif_kms.c  | 18 ++++++++++++++----
>  drivers/gpu/drm/mxsfb/lcdif_regs.h |  1 +
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 

Can this series be applied, please?

Thanks!
