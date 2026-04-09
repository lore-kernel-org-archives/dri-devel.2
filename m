Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8CDF31E25
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 15:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20C9410E81A;
	Thu,  9 Apr 2026 15:11:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Hd420Vh1";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012027.outbound.protection.outlook.com
 [40.93.195.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA4D810E81A
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 15:11:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeX/7oDgSgpYxWq/sLq8vC1tFesz6e9ZmNNvopsVyHEzwRlnOy/WM9s7688z8GxUouJfiWJ6WO7xd1fdVjDZogK5JskS3Qfu9r7x9xIil3giT6boTUcWUBB7rAqW6N7Y3URvVi99eoa+bS1VwBRZhv//TearxP9cRzFJ58TO7avSAUrzk6PhpOBp0NVeyp518nfdhHXnPn4lE+qCkyJkDk2ZqImOYEBOrjZEOX4a9V0e+N2DrP+JpDTNajmVTCUSTCv1434zKJJjEXRBmvURiltNhCJUbvQdUO/tcFhwghTT59CaYlfBUNlSUY5rWomwudAlolRFBiQJjOrcgJvpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6U2Lh2XygsHPJVYH5oOuMmwgRuZjaihQVRVusS4HPU=;
 b=P/RMN+//FNL9vvo3qN8zACTa+rCRhkPo60M5g9QpRtpr7dyNWtGseJXXDu1yyfBXNYQWcx0u48QTRVLnToK2KEwZJMm7YInMyhMKrD9kBKEMYeAt/6f5NPHshdrVE0mvAqWevnsXUNS9CmAz7kMt0LMubCGSQGUsHz/099ykysSSmoSghOblklUWd7MPrUUSd/ynt3pdVoS4lSqbQbXOVwUI7yGDXWTE+Eb3B+OtWfZQU4aDgMsjhMk/Nq6A6wxO2e/RQxsBAIFsZtwH9JAtaxknmYF5sEEjaJ2pe39vFaX6sNFAEsxX7E5eO2qcdtIUDakZANLvuGAEgjCZ5/8nlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6U2Lh2XygsHPJVYH5oOuMmwgRuZjaihQVRVusS4HPU=;
 b=Hd420Vh1SltQ/dVMcmovgJKx5synbmTBbvGL10NjGha1KSMBl2gvAQjRPaKTiLSwfNdUGawYxpzmgqctmu4ybw7PU2hotSwyHJb4J9gsjLw46e4rhmNSJZNO8s1Jwf12jR8ByYnNMCrar/jOHhk4qRgHDErKDyU2Q39PYpsE9OI=
Received: from MN2PR07CA0028.namprd07.prod.outlook.com (2603:10b6:208:1a0::38)
 by BN0PR10MB5158.namprd10.prod.outlook.com (2603:10b6:408:120::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 9 Apr
 2026 15:11:47 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::79) by MN2PR07CA0028.outlook.office365.com
 (2603:10b6:208:1a0::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.35 via Frontend Transport; Thu,
 9 Apr 2026 15:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 15:11:47 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 10:11:44 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 10:11:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 10:11:44 -0500
Received: from [172.24.233.62] (devarsh-precision-tower-3620.dhcp.ti.com
 [172.24.233.62])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 639FBeNI2785302;
 Thu, 9 Apr 2026 10:11:40 -0500
Message-ID: <8ccc9527-8779-4aba-bd43-54999b589506@ti.com>
Date: Thu, 9 Apr 2026 20:41:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: sii902x: Add Power Management hooks with
 audio context
To: Sen Wang <sen@ti.com>, Andrzej Hajda <andrzej.hajda@intel.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
CC: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Donadkar,
 Rishikesh" <r-donadkar@ti.com>, "Jain, Swamil" <s-jain1@ti.com>
References: <20260401013758.4149091-1-sen@ti.com>
 <96444379-712c-4e21-8f3c-55eaad850cd4@ti.com>
 <09d3cf4d-ecb3-444a-8e88-7d51599007fe@ti.com>
 <58abc6bd-2f34-4b85-b26e-34324079ec50@ti.com>
 <f3371c6f-b253-442f-b54d-833b711b5dcc@ti.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <f3371c6f-b253-442f-b54d-833b711b5dcc@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|BN0PR10MB5158:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc01815-4d0c-4230-cbb1-08de964a51db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|36860700016|376014|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: HvoU2JrKvmlpJeXiS6rE6UD+fKPnT8q7FQ167fGDh6TWvZkthtcO+LEqM1F9M52X+R4AgqicN2bzHoMOY2i2wrt8CZ0n7dWspbrouQ+lsK67jrQTTHi9XphRMC3U7jkWIbwKedeSXHTaR9e7OO0N6qbIJewEkK6sAqHA/qjdeQsvfZF9fIlUrTSXwbl/Q5BGNlcD0no5ot2S5tEVNA3bPGbwsqCQWDjKe1P0NDnupm3DqqQ5r7iJ1t/aIHkKzQyAEDIVgITSChJDwMvZDBGeEKh8Mv4gcha1gKLzspJ3oMlTTg8gkF07A9RifvtDheRQ4qT/ku37bKe86NSLs4TGcFCYBWIrvRSTFpNlis5qOnD8j7Bi2lTygTzIZYYhv/MsVSOid7JWTTPYcFyeTArrXGkySbkLcHpEqOW/b9doYPbX0KcaHMoE40sgIlwaQ3ssW8aMUBz1YjmgL8krcTluwp1M9Ywkr4vseiIYRc6veMY1LZxDq/DXFHLD5UMVX06X1tLztoziRNw6IUFT3GfcDbCOjqQ9LucBG5jZainxDAU6ncjMMDcNMNYcpvnwYNDX2puj2rf+3IxqM3XKmm/cjE+5HOMmXc0dcCV/40VhGgdGcm6Qa11RWDltaP2eIzXBH+KEOcBx2vLQVdAy6enuBjK+FGW6J+2aiLQARu92iSHG9rV/O4piQPS9S67wV4IoaY8T4T0LKwAcQTwYnk56FtUjgiUGkm/X02GdhKvNZspHALBsgYymxaEnnv9+FqmanH2dQhzJsUtz855QNC1u6Q==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(7416014)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: evhyfVQ/CtPTX7wxRTPjogZItCRAM/lSdyH0heYXhf8w9tArRpvuLbni4hmU7EYddK/XP5ELO7G81uNJ7l9CwHQDkBnPoywXnZOg9bUAv2h5ty7Br0tEqwHW5RODzqWIHhoWmXv6HumrjnRAEMdJ+ys1OgJgG9XlWT18rNH/ZuEAaFe7ndoJYEYhdnDjIu//fo42ir81w6CfxbyYGGnMMZM2nrR3Z/LCe5+mTzlkafLd3pZDdRU5c21J/ceb/6ladYb6C5Qe+G60QlQP9C8BULWV2Yi8WQezWEHDIXTtD5DgDa79/+4Z8eHbAqXbz2eXNhmQBg8dNLzCSCB6UpYDv1tXeIvZLFTobKGPRVdeLgxRx/2f4P6C1YE812V46tJ0hPQ6YEnQOwP86cez30NT0wOhHWD1If/XnMfbPKPFsFBIU6F2oJw/Mn0Ug+H4e6Ev
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 15:11:47.7047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc01815-4d0c-4230-cbb1-08de964a51db
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5158
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

Hi Sen,

Thanks for looking into this.

On 04/04/26 23:11, Sen Wang wrote:
> On 4/2/26 02:07, Thakkar, Devarsh wrote:
>> Hi Sen,
>>
>> Thanks for the update.
>>
>> On 02/04/26 05:03, Sen Wang wrote:
>>> On 4/1/26 09:42, Thakkar, Devarsh wrote:
>>>> Hi Sen,
>>>>
>>>> On 01/04/26 07:07, Sen Wang wrote:
>>>>
>>>> Sorry but this is not very clear, is this a V2 to
>>>> https://lore.kernel.org/all/e6497541-f3e7-4533-
>>>> a188-9d422cb34d74@ti.com/ ?
>>>>
>>>> In that case, the subject should mention it as PATCH v2 along with
>>>> changelog as documented in kernel patch guidelines :
>>>> https://docs.kernel.org/process/submitting-patches.html
>>>>
>>> Hi Devarsh, Thanks for your review.
>>>
>>> This new patch encompasses more features than the previous patch to
>>> warrant it being a separate patch. But nonetheless my apologies for
>>> not stating the indirection in my commit message.
>>>
>>
>> I don't think this qualifies to make it an independent patch altogether,
>> as long as goal of the patch is same as the initial one posted, this
>> should be labelled as a V2 with linkage to V1 in changelog. And the
>> follow up patch should be labelled V3.
>>
>> The changelog should capture the changes under ---:
>>
>> V1->V2 : What changed
>> V2->V3 : What changed
>>
>> along with links for V1 and V2.
>>
>> This gives the reviewer necessary context on architecture and reasoning
>> behind new changes/approaches even if it means the new patch contains
>> some extra feature which was not present in previous patch.
>>
>> Regards
>> Devarsh
>>
>>
> Understood Devarsh, thank you for the detailed explanation. Deeply 
> appreciated.
> 
> I also dug more into the datasheet with your comments in mind and wanted 
> to gather some feedback on the proposal before sending a proper V3 patch.
> 
> Here's my proposal, TL;DR:
> 
> - Runtime suspend to use D2 (Sleep) for a quick bringup
> - System suspend to use D3 Hot for a complete power-off/on scheme
> 
> For the full summary:
> 
> (per Datasheet's powerstate, Table 3.8)
> D0     - Full power
> D2     - Quiet Power Down (i2c accessible)
> D3 Hot  - Complete Power Down (via HPD or RSEN wkup)
> D3 Cold - Complete Power Down (HPD)
> 
> Runtime suspend on sii902x should NOT use the same flow as System suspend
> 
> - Runtime suspend to use D2 for a quick bringup

If D3 mode resume latency is faster and comparable to D2 and no obvious 
tradeoffs then maybe we could use D3 for runtime resume too?

> - System suspend to use D3 Hot for a complete power-off/on scheme
>      + Hot vs Cold: even though Cold use marginally less power, it can 
> only be entered and wkup via HPD event (Hotplug detect), which is not a 
> software-controlled event.
> 

For system suspend, anyway the system resume will mostly be done with 
system wakeup sources so I am not sure if we really need the extra 
wakeup present in D3 Hot as compared to D3 cold, so probably would be 
better to stick to D3 cold if no obvious tradeoffs.

Also could you please measure resume back latencies for each of the D2 
and D3 modes and we can then maybe compare that with the power table to 
get latency vs power tradeoff view and decide ?

> 
> In such case, only system suspend needs to cache TPI and audio context, 
> reset & initalise the hardware. Whereas runtime suspend should just be 
> in a D2 state where all reg values are preserved. Thus providing faster 
> response time for runtime resume, especially when we don't have 
> autosuspend (yet), and avoids latency for spontaneous events in the DRM 
> framework.

I think we probably should add auto-suspend support too w.r. runtime 
suspend as don't want to go to suspend too frequently if the 
initialization latency (along with power rampup sequences) is too high.

Regards
Devarsh

