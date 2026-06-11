Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233AECD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 16:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B11910EFA9;
	Thu, 11 Jun 2026 16:06:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="F1NvBVeT";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="F1NvBVeT";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010016.outbound.protection.outlook.com [52.101.69.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 534D210EFA9
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 16:06:09 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=kURtFk6Jr1LcKeYnYDH/ZdUkdj+EAJpA0H8F79+A5rrNjQ+jrNxCE1tIVL+Xr7trl578lrKdwKHt2vtR/fkRvxwmx4x4QRBaTCkTt45OkbeaMz+Hoc3Jk7DuupjH/i485cgwMcGvsPPvw/WRwpGmW//J/rhwLdbAwPAU+xF1wHA4TYED92OqFDLjaf6SrbJhSJyDuSgwoTZoa4gLNHPxKTFNYRzdeFYBdasCndf7sbVXGRqf6o9hU2YP6J3xfySxFF6gxt3xI8aLoM+HZP9QnfXA1cMo/jfHiCxkIaePzhnEMd7BEZ3LuPDiqre5vbzIhj7P01dBFdICdpjq6rCqFA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICXW8xtYPWBSIXtg2kGYIqX168+2hCiMQj6DUhoN1tQ=;
 b=cR5AsYXIi13aMF/zIm45ER89FJTdDCaLu0826/R1f5EDDGKIz23i49esC0o2ztljc6ttqmZa+NqXwow/naSNOiFpj6Xq4VT5Ji4Y2NaXCY0DY+QsPJiZKdQeXBx+awUvwFCA/cobDSjXJSYY4/zjE6UuujG/xYAAaZ6TlGI8cswRP6QfktBM1tle8PeisZp0TFAiAU00hqZU5u8Jhwv0t4Zho4Y0jkvhuroncjSQocN3+8BbQp2WqysvhpV9VpjL38R6BuXIjFDfsikfeO1sHvvQe72hphgl00BbNrOw+PrZijN37JpFRZCsfl6Kp7/p3NPgUYbHISYYd2Y7rpDZ/g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICXW8xtYPWBSIXtg2kGYIqX168+2hCiMQj6DUhoN1tQ=;
 b=F1NvBVeTP/Mpty5xTspHrW9rIf3suMd1muiCJCH3IQkuxDcHOhtibp93xPa5M76Tye2M+DHPA/sxswvCJ4z0Zr7g7U+gplqhKcKpkrWqE/odhKilXgUdIuQdCtCRR0jgGKIZRdhe0zEBcs4FRlf0LVkH7wqhCfdH7w31soJoYmk=
Received: from DUZPR01CA0218.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::21) by AS8PR08MB6391.eurprd08.prod.outlook.com
 (2603:10a6:20b:31d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 16:06:02 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:4b4:cafe::9c) by DUZPR01CA0218.outlook.office365.com
 (2603:10a6:10:4b4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 16:06:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7 via
 Frontend Transport; Thu, 11 Jun 2026 16:06:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKRtt09mdMrRdfdrYHRqbHldDl6kK2YlaclaITIENb/Dkoe4MxGTvx27GM0Yn/atoJYwrSrRNar+hfs/8CkiIUVuEHiroht0ozNhV6szCvlwgJ2wVhkRfyVruFxY3iChMispqxcMMR03r0HhWL3nrG4+uZ4HNb5ekdU/H63BmJJbUYBzzmrOLLr30FLAWsbgzOH+2DSrm8dewWp1/yMMjgMKrmqrXW36XGr4LkxGkNxlGjiUgW9GYPJYS7R/domtmEAG640JO0Mx+Ht6tdZoNfv1zFgNKwjmlrTYFIwxxCE6zcBkBiQJmswi0/5d5KalSWKNaLv3dCMmr3IR6EfuoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICXW8xtYPWBSIXtg2kGYIqX168+2hCiMQj6DUhoN1tQ=;
 b=EmMiC6uikdmzn0GQuk3h5m/ImVpCdyeMK04BzUEKii/R2dXOkWK+DjKA9DZzeV+2hdpKNL8CdOJ10tuur5q0pRouXZZns7yYEwdUGUlTqNBzkyIigZOwQLynldwOyUM70qnsUDpGIMUjuBSQ7uXThT5JfKz4J26n3T8WdS4noR//3rrDVWfw2txJaPwNpemeNvdxXXuW72f2hfZFIFzTSLwsTBznCC6BwTx/yfpOqXG0CD3cMF62Bap5wrZgQTV2Rq/mhXQUzqzmrCFz9sXVI0Te/6Q12ot9rNh+MffWjEuFAAhHc5AMtkw33ZmlTinox9jrUCZWAMEOVxa8wXK1Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICXW8xtYPWBSIXtg2kGYIqX168+2hCiMQj6DUhoN1tQ=;
 b=F1NvBVeTP/Mpty5xTspHrW9rIf3suMd1muiCJCH3IQkuxDcHOhtibp93xPa5M76Tye2M+DHPA/sxswvCJ4z0Zr7g7U+gplqhKcKpkrWqE/odhKilXgUdIuQdCtCRR0jgGKIZRdhe0zEBcs4FRlf0LVkH7wqhCfdH7w31soJoYmk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB11183.eurprd08.prod.outlook.com
 (2603:10a6:150:1fc::16) by AMBPR08MB11915.eurprd08.prod.outlook.com
 (2603:10a6:20b:760::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 16:04:59 +0000
Received: from GVXPR08MB11183.eurprd08.prod.outlook.com
 ([fe80::5576:8db3:22e8:135c]) by GVXPR08MB11183.eurprd08.prod.outlook.com
 ([fe80::5576:8db3:22e8:135c%6]) with mapi id 15.21.0092.017; Thu, 11 Jun 2026
 16:04:59 +0000
Message-ID: <4da19dca-ce00-4888-8f9d-2400e2617a29@arm.com>
Date: Thu, 11 Jun 2026 17:04:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/18] drm/panthor: Add Mali v15 hardware support
Content-Language: en-GB
To: Steven Price <steven.price@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20260528150546.3168527-1-karunika.choo@arm.com>
 <20260528150546.3168527-8-karunika.choo@arm.com>
 <99c5c33c-3c68-49a8-b827-c3fa210e8b13@arm.com>
In-Reply-To: <99c5c33c-3c68-49a8-b827-c3fa210e8b13@arm.com>
From: Karunika Choo <karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0108.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::23) To GVXPR08MB11183.eurprd08.prod.outlook.com
 (2603:10a6:150:1fc::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GVXPR08MB11183:EE_|AMBPR08MB11915:EE_|DU6PEPF0000A7E2:EE_|AS8PR08MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 2910f221-7107-45eb-a3b0-08dec7d35581
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|6133799003|18002099003|22082099003|3023799007|56012099006|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info-Original: hJ0+Fdk4ewBrZpVx/MUa0Vms89WKRWMV0JwsBrlPF8su9hZFb53AYrgbHNpEsVYMNM/vBT4u70Lyuv5+5ObTdEfU1Fy9pJ2KSAa5Eb2L6vao7yDkT2f4qYYHDgy+uqXtOpWVHIn3O1q86QM0UXnHWZ9UBImOqZQTFTtKdgP+vgMwyFUnqyL0IFGfcqmkIkq4pcfIqn9Kzu6yJB9C+V6sdUOih0jPMPV4h1c2y+xDGj613d09TqkT6D6fmfSndFGP8Cz5bZ6ux4Dr2aOvDG07QaPm12yA7yEqwRLVsXTilTbB1Is0csYOVjkGBTPC5tANuJJjfixGZHRi9rMDn3PZlR0IRNZkdRsWYVGprsSFoF7tTgRnOrmRXdyYcigbOc+Kas4ORQMO+OicM8oJVhGUhYkqg+blR3Dpcpcgx2wV50XkfIOiRqDz6+7exTAvOj1QTikwa/I1W/VSYFCZQ+T18XFjDZc6K3mb/iGiDLGiSyoS+1LRWoa+Ygi4hw2z1wQBD9xnf7D9xZSq/Y0gPKMWYpbm87sr4LLEdY4Hg8T9wI41PVGaPJQ6+CkbHkQEeBC3oUzV2KSjtFSaM3Um9+fJDebMzIPV/CrSS7/eqElIOuMvx28MllMmvkYrxN4VEV0l4Ma52VSTMncn8QInJuLpzoQv5wKo177pxUwIanaO+ZdEpCENAccMBLIAXdzcBZPI
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GVXPR08MB11183.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(4143699003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: gBoCBk6fcHHH60hhkO4fgxSCY1xUp2jB61hoNFsbxJAHLTY/R8nexzEGirVHEKKQeaaMQsIy0TAFTlQdI9rQVs9KEw+e0ogExaXOrQoJQCKsFFHo7T/tt+hIIkXpDAjMNLd1KQvoh9F5eftgbndGLKn41u64rtO4WwJIuqf65SCdpS6MvReOEG/+YDhk7rkpuhuluEqmAxj0hLlex6dwehJihEEBYt/eD0ClgV4mV4IYrmBuwm1Cl8fPg7Q4xc82nLizdiNtMQBfiMtjifWsHKIg4lh5OZAWDvN3aLa2J9QTUZ1uWZODY3AJxdQ9uBqmow4J30O8Zthbp3dKSNJ3SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB11915
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: bdb741c5-1fc7-42d3-2120-08dec7d3301b
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|14060799003|1800799024|36860700016|82310400026|376014|23010399003|6133799003|18002099003|3023799007|22082099003|4143699003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Aj2BJvvgzx0TCiGNY22BSKtsJDPJgYo4XtYSE6FO1/PVHgNAH1Z+oqqjXqzVueBuD8lJzGk9gz6hE9iQoovflqZaxRdYtkEyhTOGwiDa9erapzbZ1oC7ebp6hFOGPLFkjKtvMVfH0TsLhTbUbTNWS9DhYj5ztU5vy5ZsGyLkhUzh1GZTeH3BSR/MTAONc4NNdTsi+buhoNqfoVhvXMF4a+5XgDShGLd86srP186DpnyFnqwAncYGtOteM0KUOjEsoX0ewB2rU0FagIeLIbttalCwU7CV/t2qlbbllDBAZV9n2Cjy8qBbdhtVtrSYLkFBiXWaHnGpISNsk9WV4r3NmZ/KSGzw1x3Ks5NsiBnEMkY0EakmW6M+dk3z02wEzx1bKI06JROYaFhJFpYCufOgXUEfH37iGjUbjUUTpF9HH4K/r73256m6zqws6fpApQVPQe5ZrNFiGfVdD9MTbI6MYA4xCklho3JuyGbdb2stt1uR4wDDnQpNtpLdXdaP5vzanp80nQiL9pW7T9ABpvK6DvSsk6+tqwSESKxgG9SzWA9hQj5XyXRo5vIqgfc5QLKSxeHg0oKGHFNXVzY2SGYiXFLRQYIhcAI6hid0I3khW7LBIy57plsRDwQzYaZfdFzvFi51o+LP4+TU2mDUS/atLTPXfcu0sOWtrzwSHLEMyBgZyqwar+jNOi/HcMBqd7/o1/o0/r6qFptqubll8avNI40DHOTDOeOM6+X4Ey/bOk0=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(14060799003)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(6133799003)(18002099003)(3023799007)(22082099003)(4143699003)(5023799004)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J9npBcy4PXLuGwgS8AVx0IimPa8nBUkLIClm7FbfIPQNGiVDa+dDxWa6sy+KhIBzUHAxgj+qk/SKHWKQI6u5Ezdl9YgvxUZIx2QlrUhAAFRENPaDcS/vQLEnt3zpgAxSCQAdCLzsrKk2bpGzo4yK45eLjVnxMxPMPOM7qFhKupItRhLgOieIev2fusvTXkNylMO1x5y/L3tbWJFq+6bRBRyDA3IBl6HfiqWAXzW+AJzHy+Q0NJdn0Yx2t9xYeLTIQAhg8uP6OQ7ggv9CIz0+yaOfd4Iie5cxgccJKx+nqFkRvUmBJG9LexgvxxaaD6IpJqV0/2O9v4a3OMNq4gyLn5OX+IprTX5dWRk22HP1ckqRyH+EQx2A5RuvEvyDNwaeGNzgfH6GU016EI917bDMk1ODzmtcV3STPDbhLRdZTmASWjxwQjEoVVOeYNWz+b9U
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:06:01.8647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2910f221-7107-45eb-a3b0-08dec7d35581
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6391
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

On 11/06/2026 16:18, Steven Price wrote:
> On 28/05/2026 16:05, Karunika Choo wrote:
>> Add the panthor hardware description for Mali v15 GPUs and hook it into
>> device matching.
>>
>> This includes the v15 register map and product identification needed to
>> populate the GPU information exposed by the driver and its uAPI.
>>
>> Add compatibility string for v15 GPUs.
>>
>> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
>> ---
>>  drivers/gpu/drm/panthor/panthor_drv.c         |  1 +
>>  drivers/gpu/drm/panthor/panthor_fw.c          |  1 +
>>  .../drm/panthor/panthor_gpu_discover_regs.h   | 25 ++++++
>>  drivers/gpu/drm/panthor/panthor_heap.c        |  3 +-
>>  drivers/gpu/drm/panthor/panthor_hw.c          | 81 ++++++++++++++++++-
>>  drivers/gpu/drm/panthor/panthor_hw.h          | 13 +++
>>  include/uapi/drm/panthor_drm.h                | 10 ++-
>>  7 files changed, 128 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
>> index e8dc4096c1d2..21644a60c8e4 100644
>> --- a/drivers/gpu/drm/panthor/panthor_drv.c
>> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
>> @@ -1875,6 +1875,7 @@ static const struct of_device_id dt_match[] = {
>>  	{ .compatible = "mediatek,mt8196-mali", .data = &soc_data_mediatek_mt8196, },
>>  	{ .compatible = "rockchip,rk3588-mali" },
>>  	{ .compatible = "arm,mali-valhall-csf" },
>> +	{ .compatible = "arm,mali-gen5-am" },
> 
> Just a heads up: a new DT compatible should have a binding document
> describing it. So this can't be merged until the DT bindings change is
> agreed.
> 

In this case are we leaning more towards a new arm,mali-gen5-am.yaml
or is it preferrable to update arm/mali-valhall-csf.yaml instead?

>>  	{}
>>  };
>>  MODULE_DEVICE_TABLE(of, dt_match);
>> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
>> index f6381f5f236f..e2a511b741f4 100644
>> --- a/drivers/gpu/drm/panthor/panthor_fw.c
>> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
>> @@ -1529,3 +1529,4 @@ MODULE_FIRMWARE("arm/mali/arch11.8/mali_csffw.bin");
>>  MODULE_FIRMWARE("arm/mali/arch12.8/mali_csffw.bin");
>>  MODULE_FIRMWARE("arm/mali/arch13.8/mali_csffw.bin");
>>  MODULE_FIRMWARE("arm/mali/arch14.8/mali_csffw.bin");
>> +MODULE_FIRMWARE("arm/mali/arch15.8/mali_csffw.bin");
>> diff --git a/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
>> index 54bb104902ee..9c64676dc35a 100644
>> --- a/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
>> +++ b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
>> @@ -14,4 +14,29 @@
>>  #define   GPU_WIDE_VER_MINOR(x)				(((x) & GENMASK(15, 8)) >> 8)
>>  #define   GPU_WIDE_VER_STATUS(x)			((x) & GENMASK(7, 0))
>>  
>> +#define DISCOVER_REVIDR					0x8
>> +#define DISCOVER_GPU_FEATURES				0x20
>> +#define   GPU_FEATURES_VARIABLE_RATE_SHADING		BIT(0)
>> +#define   GPU_FEATURES_SIMD_STATE			BIT(1)
>> +#define   GPU_FEATURES_CROSS_STREAM_SYNC		BIT(3)
>> +#define   GPU_FEATURES_NX				BIT(4)
>> +#define   GPU_FEATURES_RAY_TRAVERSAL			BIT(5)
>> +#define   GPU_FEATURES_LD_LEA_TENSOR_INSTRUCTIONS	BIT(6)
>> +#define DISCOVER_MCU_FEATURES				0x40
>> +#define DISCOVER_PRFCNT_FEATURES			0x50
>> +#define   PRFCNT_FEATURES_COUNTER_BLOCK_SIZE(x)		(((x) & GENMASK(7, 0)) << 8)
>> +#define DISCOVER_DOORBELL_FEATURES			0x60
>> +#define DISCOVER_MEM_FEATURES				0x100
>> +#define DISCOVER_MMU_FEATURES				0x108
>> +#define   MMU_FEATURES_AS_COUNT(x)			(((x) & GENMASK(23, 16)) >> 16)
>> +#define DISCOVER_AMBA_FEATURES				0x120
>> +
>> +#define DISCOVER_L2_FEATURES				0x128
>> +#define DISCOVER_TILER_FEATURES				0x200
>> +#define DISCOVER_CORE_FEATURES				0x300
>> +#define DISCOVER_THREAD_FEATURES			0x320
>> +#define DISCOVER_THREAD_MAX_THREADS			0x330
>> +#define DISCOVER_THREAD_NUM_ACTIVE_GRANULARITY		0x334
>> +#define DISCOVER_TEXTURE_FEATURES			0x360
>> +
>>  #endif /* __PANTHOR_GPU_DISCOVER_REGS_H__ */
>> diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
>> index 99311abdf1e9..afb7d68abc87 100644
>> --- a/drivers/gpu/drm/panthor/panthor_heap.c
>> +++ b/drivers/gpu/drm/panthor/panthor_heap.c
>> @@ -11,6 +11,7 @@
>>  #include "panthor_gem.h"
>>  #include "panthor_gpu_regs.h"
>>  #include "panthor_heap.h"
>> +#include "panthor_hw.h"
>>  #include "panthor_mmu.h"
>>  
>>  /*
>> @@ -105,7 +106,7 @@ struct panthor_heap_pool {
>>  
>>  static int panthor_heap_ctx_stride(struct panthor_device *ptdev)
>>  {
>> -	u32 l2_features = ptdev->gpu_info.l2_features;
>> +	u64 l2_features = panthor_hw_get_l2_features(ptdev);
>>  	u32 gpu_cache_line_size = GPU_L2_FEATURES_LINE_SIZE(l2_features);
>>  
>>  	return ALIGN(HEAP_CONTEXT_SIZE, gpu_cache_line_size);
>> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
>> index e677f1a8f488..52271fb9db52 100644
>> --- a/drivers/gpu/drm/panthor/panthor_hw.c
>> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
>> @@ -65,6 +65,23 @@ static struct panthor_hw panthor_hw_arch_v14 = {
>>  	},
>>  };
>>  
>> +static struct panthor_hw panthor_hw_arch_v15 = {
>> +	.ops = {
>> +		.soft_reset = panthor_pwr_reset_soft,
>> +		.l2_power_off = panthor_pwr_l2_power_off,
>> +		.l2_power_on = panthor_pwr_l2_power_on,
>> +	},
>> +	.map = {
>> +		.gpu_control_base = 0x3000,
>> +		.pwr_control_base = 0x3800,
>> +		.mcu_control_base = 0x3100,
>> +		.mmu_as = {
>> +			.base = 0x2800,
>> +			.stride = 0x80,
>> +		},
>> +	},
>> +};
>> +
>>  static struct panthor_hw_entry panthor_hw_match[] = {
>>  	{
>>  		.arch_min = 10,
>> @@ -76,6 +93,11 @@ static struct panthor_hw_entry panthor_hw_match[] = {
>>  		.arch_max = 14,
>>  		.hwdev = &panthor_hw_arch_v14,
>>  	},
>> +	{
>> +		.arch_min = 15,
>> +		.arch_max = 15,
>> +		.hwdev = &panthor_hw_arch_v15,
>> +	}
>>  };
>>  
>>  static int panthor_hw_set_power_tracing(struct device *dev, void *data)
>> @@ -187,6 +209,12 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
>>  		return "Mali-G1-Premium";
>>  	case GPU_PROD_ID_MAKE(14, 3):
>>  		return "Mali-G1-Pro";
>> +	case GPU_PROD_ID_MAKE(15, 0):
>> +		return "Mali-G2-Ultra";
>> +	case GPU_PROD_ID_MAKE(15, 1):
>> +		return "Mali-G2-Premium";
>> +	case GPU_PROD_ID_MAKE(15, 3):
>> +		return "Mali-G2-Pro";
>>  	}
>>  
>>  	return "(Unknown Mali GPU)";
>> @@ -210,7 +238,7 @@ static int overload_shader_present(struct panthor_device *ptdev)
>>  	return 0;
>>  }
>>  
>> -static int panthor_gpu_info_init(struct panthor_device *ptdev)
>> +static void panthor_gpu_info_v10_init(struct panthor_device *ptdev)
>>  {
>>  	unsigned int i;
>>  
>> @@ -251,12 +279,56 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
>>  		ptdev->gpu_info.tiler_present = gpu_read64(gpu_iomem, GPU_TILER_PRESENT);
>>  		ptdev->gpu_info.l2_present = gpu_read64(gpu_iomem, GPU_L2_PRESENT);
>>  	}
>> +}
>> +
>> +static void panthor_gpu_info_v15_init(struct panthor_device *ptdev)
>> +{
>> +	void __iomem *pwr_iomem = ptdev->iomem + ptdev->hw->map.pwr_control_base;
>> +	u64 texture_features;
>> +
>> +	ptdev->gpu_info.gpu_rev_wide = gpu_read64(ptdev->iomem, DISCOVER_REVIDR);
>> +	ptdev->gpu_info.l2_features_wide = gpu_read64(ptdev->iomem, DISCOVER_L2_FEATURES);
>> +
>> +	texture_features = gpu_read64(ptdev->iomem, DISCOVER_TEXTURE_FEATURES);
>> +	ptdev->gpu_info.texture_features[0] = lower_32_bits(texture_features);
>> +	ptdev->gpu_info.texture_features[1] = upper_32_bits(texture_features);
>> +
>> +	ptdev->gpu_info.thread_features = gpu_read(ptdev->iomem, DISCOVER_THREAD_FEATURES);
>> +	ptdev->gpu_info.max_threads = gpu_read(ptdev->iomem, DISCOVER_THREAD_MAX_THREADS);
>> +	ptdev->gpu_info.thread_num_active_granularity =
>> +		gpu_read(ptdev->iomem, DISCOVER_THREAD_NUM_ACTIVE_GRANULARITY);
>> +
>> +	ptdev->gpu_info.gpu_features = gpu_read64(ptdev->iomem, DISCOVER_GPU_FEATURES);
>> +
>> +	/* The following _HI registers do not contain any information (yet) */
> 
> This is a little confusing as a comment - there are no "_HI" registers
> mentioned. I think this would be better reworded as "32 bit reads are
> used as the HI part of the 64 bit register does not contian any
> information (yet)" (or similar).

ACK.

> Or alternatively you could just upgrade these to 64 bit and be done with
> it ;)
> 
>> +	ptdev->gpu_info.mem_features = gpu_read(ptdev->iomem, DISCOVER_MEM_FEATURES);
>> +	ptdev->gpu_info.mmu_features = gpu_read(ptdev->iomem, DISCOVER_MMU_FEATURES);
>> +	ptdev->gpu_info.coherency_features = gpu_read(ptdev->iomem, DISCOVER_AMBA_FEATURES);
>> +	ptdev->gpu_info.tiler_features = gpu_read(ptdev->iomem, DISCOVER_TILER_FEATURES);
>> +	ptdev->gpu_info.core_features = gpu_read(ptdev->iomem, DISCOVER_CORE_FEATURES);
>> +
>> +	/* AS_PRESENT register removed on v15+ create virtual mask from MMU_FEATURES.AS_COUNT */
>> +	ptdev->gpu_info.as_present =
>> +		(1U << MMU_FEATURES_AS_COUNT(ptdev->gpu_info.mmu_features)) - 1;
> 
> This might be better expressed using GENMASK:
> 
> GENMASK(MMU_FEATURES_AS_COUNT(ptdev->gpu_info.mmu_features) - 1, 0)
>

ACK.

Kind regards,
Karunika

>> +
>> +	ptdev->gpu_info.l2_present = gpu_read64(pwr_iomem, PWR_L2_PRESENT);
>> +	ptdev->gpu_info.tiler_present = gpu_read64(pwr_iomem, PWR_TILER_PRESENT);
>> +	ptdev->gpu_info.shader_present = gpu_read64(pwr_iomem, PWR_SHADER_PRESENT);
>> +}
>> +
>> +static int panthor_gpu_info_init(struct panthor_device *ptdev)
>> +{
>> +	if (panthor_hw_has_gpu_discover(ptdev))
>> +		panthor_gpu_info_v15_init(ptdev);
>> +	else
>> +		panthor_gpu_info_v10_init(ptdev);
>>  
>>  	return overload_shader_present(ptdev);
>>  }
>>  
>>  static int panthor_hw_info_init(struct panthor_device *ptdev)
>>  {
>> +	u64 l2_features = ptdev->gpu_info.l2_features;
>>  	u32 major, minor, status;
>>  	int ret;
>>  
>> @@ -268,14 +340,17 @@ static int panthor_hw_info_init(struct panthor_device *ptdev)
>>  	minor = ptdev->gpu_id.ver.minor;
>>  	status = ptdev->gpu_id.ver.status;
>>  
>> +	if (panthor_hw_has_gpu_discover(ptdev))
>> +		l2_features = ptdev->gpu_info.l2_features_wide;
>> +
>>  	drm_info(&ptdev->base,
>>  		 "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
>>  		 get_gpu_model_name(ptdev), ptdev->gpu_id.prod_major,
>>  		 major, minor, status);
>>  
>>  	drm_info(&ptdev->base,
>> -		 "Features: L2:%#x Tiler:%#x Mem:%#x MMU:%#x AS:%#x",
>> -		 ptdev->gpu_info.l2_features,
>> +		 "Features: L2:%#llx Tiler:%#x Mem:%#x MMU:%#x AS:%#x",
>> +		 l2_features,
>>  		 ptdev->gpu_info.tiler_features,
>>  		 ptdev->gpu_info.mem_features,
>>  		 ptdev->gpu_info.mmu_features,
>> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
>> index 0ae11b78c77e..1b2678ea00db 100644
>> --- a/drivers/gpu/drm/panthor/panthor_hw.h
>> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
>> @@ -83,4 +83,17 @@ static inline bool panthor_hw_has_pwr_ctrl(struct panthor_device *ptdev)
>>  	return ptdev->gpu_id.arch.major >= 14;
>>  }
>>  
>> +static inline bool panthor_hw_has_gpu_discover(struct panthor_device *ptdev)
>> +{
>> +	return ptdev->gpu_id.arch.major >= 15;
>> +}
>> +
>> +static inline u64 panthor_hw_get_l2_features(struct panthor_device *ptdev)
>> +{
>> +	if (panthor_hw_has_gpu_discover(ptdev))
>> +		return ptdev->gpu_info.l2_features_wide;
>> +
>> +	return ptdev->gpu_info.l2_features;
>> +}
>> +
>>  #endif /* __PANTHOR_HW_H__ */
>> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
>> index 04fc9f133152..2ecc50eade27 100644
>> --- a/include/uapi/drm/panthor_drm.h
>> +++ b/include/uapi/drm/panthor_drm.h
>> @@ -368,8 +368,8 @@ struct drm_panthor_gpu_info {
>>  	/** @core_features: Used to discriminate core variants when they exist. */
>>  	__u32 core_features;
>>  
>> -	/** @pad: MBZ. */
>> -	__u32 pad;
>> +	/** @thread_num_active_granularity: Granularity of number of active threads */
>> +	__u32 thread_num_active_granularity;
>>  
>>  	/** @gpu_features: Bitmask describing supported GPU-wide features */
>>  	__u64 gpu_features;
>> @@ -383,6 +383,12 @@ struct drm_panthor_gpu_info {
>>  #define DRM_PANTHOR_WIDE_VERSION_MAJOR(x)	(((x) >> 16) & 0xff)
>>  #define DRM_PANTHOR_WIDE_VERSION_MINOR(x)	(((x) >> 8) & 0xff)
>>  #define DRM_PANTHOR_WIDE_VERSION_STATUS(x)	((x) & 0xff)
>> +
>> +	/** @gpu_rev_wide: 64-bit GPU revision for v15 onwards */
>> +	__u64 gpu_rev_wide;
>> +
>> +	/** @l2_features_wide: 64-bit L2_FEATURES for v15 onwards */
>> +	__u64 l2_features_wide;
>>  };
>>  
>>  /**
> 

