Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449A7F364B8
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 20:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 910E810E01F;
	Thu,  9 Apr 2026 20:25:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="p0L/UKj4";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012019.outbound.protection.outlook.com [52.101.53.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 854FB10E01F
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 20:25:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/Rln9l1LENrxUwsaAuIe4zKhavlajYYddHe23UcRNeB2ENKrN7I0i90LDuwJ9BqjZBjDrSKplkz24Vp32W1wmlKEbZW3m6aOW+DFslNjyv878Wz9wMHE2BW1mHqFvgVo0VYbeBZlsGms00mQfWn/v8c4Euq9MWG/JIEU4eaa3CPAWaNgRtze8lTXeTXR9k8JPayMVD/31wlQkVl+F0iU4gaVaCmFZ6P19sNBGNGHc8TuM0FAHVTDw1wkPqAc6cvFiIkNnHNZong6Ip91qGwVchxpuszRJ9BCRet7irm4K11FmxkbNyMpEBIZOVdiNGNIkJzptLeKbXOhbsPSzE4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkUqWlYYBo4duq0kgt4AIavCNZCG/vy1kVBobug1JGQ=;
 b=bscOlEUXz4hREUskr5LUXwQNG59juCOWo0hJkGn49B1whneIHBp6S065eKzdBSPIezd6k13ZTRufLPFWiJKamxzp02+S07wnYQgyrFNdEi9vcfndMhqSREhU/PUgBRd3ZV+k2lhM2sWQQCpAQkCXooMIS6sRahLtafVOFVEjhI/HmJWlYyOb7ZJaDRtL7O74xvUwYmx/Jf6siJ/1owOQ3gS6eK5cLDmm5js/O0LXzIy6JBetmgBJz8Iug0WZrxfvCNEEkBE0kExy+zHcx188vGwFl2HcdM59cSiioLmAZ5ZMyxaC3CQJlKsPU406j6v8lOxjFK7JiZq/eMugDAVBXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkUqWlYYBo4duq0kgt4AIavCNZCG/vy1kVBobug1JGQ=;
 b=p0L/UKj4JwB+BOJkR7xrzwFzLXEXKcUYBfpT9NykFj1VRSB00VSgH0dx/2P+lgx19c4yaIrSG9T0TpfJraaEa8hByOcl04xZWmrUw2ntjQB7mtbtxtHaM5k2UEmRnwY0wOfwt6M6tXAXq9WfmEo3/2Tdt8ZbxWqtdbyCxzTornE=
Received: from LV3P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::19)
 by IA6PR10MB997658.namprd10.prod.outlook.com (2603:10b6:208:5dc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 20:25:37 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:234:cafe::53) by LV3P220CA0018.outlook.office365.com
 (2603:10b6:408:234::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.40 via Frontend Transport; Thu,
 9 Apr 2026 20:25:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Thu, 9 Apr 2026 20:25:37 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 15:25:36 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 15:25:36 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 15:25:36 -0500
Received: from [128.247.81.183] (ltpf5gwk6l.dhcp.ti.com [128.247.81.183] (may
 be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 639KPavG181324;
 Thu, 9 Apr 2026 15:25:36 -0500
Message-ID: <8d1ca869-350f-44b2-999b-93c6f23028c0@ti.com>
Date: Thu, 9 Apr 2026 15:25:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: sii902x: Add Power Management hooks with
 audio context
To: Devarsh Thakkar <devarsht@ti.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>
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
 <8ccc9527-8779-4aba-bd43-54999b589506@ti.com>
Content-Language: en-US
From: "Wang, Sen" <sen@ti.com>
In-Reply-To: <8ccc9527-8779-4aba-bd43-54999b589506@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|IA6PR10MB997658:EE_
X-MS-Office365-Filtering-Correlation-Id: 82852067-b84b-4ccb-f395-08de9676293a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|7416014|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: p4RahmDBSOz8FQujvaqAiIwyWzrvg18n5Qo7OuEO9WR8RMLNp8K4NYhOyGkTobaBkRb4MmH+AKsOY6W9QjlKIo7p8mijlfRGQxl8xMsi24uy7uybFwsDOtL2DAcrYgavwBurqhW18EqButNQwchxiD1BsL/XPA8/rOvQSKg0Vxl8N4KaZMcgGx3gst9TNiI77YZkXlptDPmMiDtgfIi9YUNiwtr6rjupS3lRA4DA9gF5EGqSwws+jeVTWakFN+5Da2fN0Og1ylcuKT52kHTjL5j5ntt2kjRAbja2NBtZTSPAXZflanRSSHWKBO+hswCvwi7lJqsWk8rlIK/pHASfeBWfesEYSjwHgcBk8MuLEFn+KjPWqED7JazkTIwRTKjWYAWlIc0MvfJ1hOzDuFeRozt6fc6k80+ImQNwJOmZtrjoGuDtHzz8O7ubZelAu0Ommjav2j4sFGidi4g71hVRe/arVAlzpu2Za9acz5WsK3SiOWjltlpvRB/n5TDW1l9VJNVYksWcGHW8M6ThjS8XmsOdq8dLiW5u6fee02efZmPbxIVLACQ/GJdKTQg9UN00B5u1qvqeQXc7K3NgDgmDPvMTMq6RfzqAhB/eRaqPTe1j1l7fB80ooln4QOSvNE+JTzW6OqccI+3c4Nt1GlxqvKg6gGEudqPy0iA6BHNC3bbti3elPXUIvYOyq/4YT6tua+MOqqPE9JfuAS5D47luq8RTgLXohi+Av7sX1qkUHyaSBAtybNa8UejHph7sBglGkbxrynnytJTGS1j2PNTiiw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(7416014)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OWbGFa9yU726+xDHYUXQ5jKfLZkpi1cVfiB24wWX4Pbwg9AAbTSentlwyBhZaQhScTTaKs0oMClCYhXsV8x19quuEi9j8Smc4YEyI4WO4nK86QSPQ0mnue67mgo/FH7HQ+F6dGXHNKA/Nou2LFMJP231ScAKZFnwje5ck8C7Tt0CHhUw3LeMUxs37LpRIGXtJHJXq3rEIsoI7fDombpZwJ7uCrinveyx+cmE+szfctOygbIHLlWj+KbZUi8msWIk+V2XO8/pm74vCZWk14nMWmntgFwdPMhL6iopDM+hDecWyOWaoJCpLABbuC3fnr5poQeFfPUOjjO63+e+J08DYGS86eEHjAHUbgK4WN2eVMMhXKC0Ql4Cz5zjpX4z9WAAf6arCT/w+TCqN3CZzZZXwaO31viJoOU50NJwjI8fu9Yg5R49IcwLIsaLycsGarW2
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 20:25:37.3987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82852067-b84b-4ccb-f395-08de9676293a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR10MB997658
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

On 4/9/2026 10:11 AM, Devarsh Thakkar wrote:
> Hi Sen,
> 
> Thanks for looking into this.
> 
> On 04/04/26 23:11, Sen Wang wrote:
>> On 4/2/26 02:07, Thakkar, Devarsh wrote:
>>> Hi Sen,
>>>
>>> Thanks for the update.
>>>
>>> On 02/04/26 05:03, Sen Wang wrote:
>>>> On 4/1/26 09:42, Thakkar, Devarsh wrote:
>>>>> Hi Sen,
>>>>>
>>>>> On 01/04/26 07:07, Sen Wang wrote:
>>>>>
>>>>> Sorry but this is not very clear, is this a V2 to
>>>>> https://lore.kernel.org/all/e6497541-f3e7-4533-
>>>>> a188-9d422cb34d74@ti.com/ ?
>>>>>
>>>>> In that case, the subject should mention it as PATCH v2 along with
>>>>> changelog as documented in kernel patch guidelines :
>>>>> https://docs.kernel.org/process/submitting-patches.html
>>>>>
>>>> Hi Devarsh, Thanks for your review.
>>>>
>>>> This new patch encompasses more features than the previous patch to
>>>> warrant it being a separate patch. But nonetheless my apologies for
>>>> not stating the indirection in my commit message.
>>>>
>>>
>>> I don't think this qualifies to make it an independent patch altogether,
>>> as long as goal of the patch is same as the initial one posted, this
>>> should be labelled as a V2 with linkage to V1 in changelog. And the
>>> follow up patch should be labelled V3.
>>>
>>> The changelog should capture the changes under ---:
>>>
>>> V1->V2 : What changed
>>> V2->V3 : What changed
>>>
>>> along with links for V1 and V2.
>>>
>>> This gives the reviewer necessary context on architecture and reasoning
>>> behind new changes/approaches even if it means the new patch contains
>>> some extra feature which was not present in previous patch.
>>>
>>> Regards
>>> Devarsh
>>>
>>>
>> Understood Devarsh, thank you for the detailed explanation. Deeply 
>> appreciated.
>>
>> I also dug more into the datasheet with your comments in mind and 
>> wanted to gather some feedback on the proposal before sending a proper 
>> V3 patch.
>>
>> Here's my proposal, TL;DR:
>>
>> - Runtime suspend to use D2 (Sleep) for a quick bringup
>> - System suspend to use D3 Hot for a complete power-off/on scheme
>>
>> For the full summary:
>>
>> (per Datasheet's powerstate, Table 3.8)
>> D0     - Full power
>> D2     - Quiet Power Down (i2c accessible)
>> D3 Hot  - Complete Power Down (via HPD or RSEN wkup)
>> D3 Cold - Complete Power Down (HPD)
>>
>> Runtime suspend on sii902x should NOT use the same flow as System suspend
>>
>> - Runtime suspend to use D2 for a quick bringup
> 
> If D3 mode resume latency is faster and comparable to D2 and no obvious 
> tradeoffs then maybe we could use D3 for runtime resume too?
> 
D2 resume presumably will be a lot faster because it's a shallow sleep. 
Also for backwards compatibility, D3 requires a full context switch and 
I can't guarantee runtime resume would preserve all the states that user 
relies on. Currently we only restore the essential registers needed for 
video and audio context.

>> - System suspend to use D3 Hot for a complete power-off/on scheme
>>      + Hot vs Cold: even though Cold use marginally less power, it can 
>> only be entered and wkup via HPD event (Hotplug detect), which is not 
>> a software-controlled event.
>>
> 
> For system suspend, anyway the system resume will mostly be done with 
> system wakeup sources so I am not sure if we really need the extra 
> wakeup present in D3 Hot as compared to D3 cold, so probably would be 
> better to stick to D3 cold if no obvious tradeoffs.
> 
Well we can't use D3 cold in system suspend. D3 cold only triggers via 
HDMI wakeup, so it's a passive mechanism rather than the PM's active 
trigger.

That does bring up an alternative approach. Rather than using PM 
framework I'm more familiar with, we could rely on DRM atomic KMS. Since 
it handles hotplug detection and we're offloading impl to the core DRM 
helper APIs. This way no system resume/suspend is needed, but we still 
get the benefits of D2 runtime resume.

> Also could you please measure resume back latencies for each of the D2 
> and D3 modes and we can then maybe compare that with the power table to 
> get latency vs power tradeoff view and decide ?
> 
Compatibility is the biggest concern I have, rather be safe than sorry.
And I don't think it's worthwhile to focus so much on sporadic events 
that runtime PM handles, when the narrative is on the overarching power 
management.

>>
>> In such case, only system suspend needs to cache TPI and audio 
>> context, reset & initalise the hardware. Whereas runtime suspend 
>> should just be in a D2 state where all reg values are preserved. Thus 
>> providing faster response time for runtime resume, especially when we 
>> don't have autosuspend (yet), and avoids latency for spontaneous 
>> events in the DRM framework.
> 
> I think we probably should add auto-suspend support too w.r. runtime 
> suspend as don't want to go to suspend too frequently if the 
> initialization latency (along with power rampup sequences) is too high.
> 

Okay I can do that.

> Regards
> Devarsh
> 

