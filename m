Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E800F1061B1C
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74C6A10E696;
	Mon, 30 Mar 2026 18:52:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aglVrzdS";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012058.outbound.protection.outlook.com
 [40.107.200.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DB0A10E297;
 Mon, 30 Mar 2026 18:52:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpOjRr6zDqYpqHAm9YgktHnFAiSFcDW537sMvsCiTDBbalWkS39C6eskD4qj5Z6Vx27ktzjPOZCqjVwgABWFphVmqdXKUZ7vzURoJmn5bLJ5Wd1CiMvw/0KVzgIpqIhtM+UO3Pt/rYNpSofHHPfP3OLtg6aXmQexnjuhuLlYJoEw58W3173Egx1E1InB2ozaTqTkP9AU44qbelngWm8d/SkPcVvU1YYzPSl0mMVGWItH+FsHrOZTy93lzmHk18h4hs3JnoPNRtJFEgW47ksxoZ/n1THHQ/noqs1CBmyv7YXhxvKZxgzfiut8PwDZ9x+QuKMNmk4KvDHOk62V8kocYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXlDmDYULqxa3iKTJsb6NyxNHxuaRgpQcqlCf3WLeJo=;
 b=qDKESkgpONtlajcpk5Tu71hffzS1xo6ndkJooSiWmcOhsvvOLUzpGUEEIrQjS7v0s60+jxRzqQCJsjjaanxwTbUOrbPas+tVTdKk0ykE3msZNFRdI4KSGtlb78zxxGCb4FiCLhbDs1jEK7yUr8ztRa02kQnSxLpHycplQ3VZlJYwHHTWshIx5cyBg7rrxrywEa1BgY9zagBaOGPxRbKJuuTKMmuTUFhGXFNieL1EKL8HXNKxfDMwJfH5M6nwnfBSHVA41Tj5zt/d2Isr2eBfekijMEjyGMuZcpkzC9qbugZ2NisHVISnvWZ42rit72k+E7xXN0ZoSoWGWaz7/ErofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXlDmDYULqxa3iKTJsb6NyxNHxuaRgpQcqlCf3WLeJo=;
 b=aglVrzdSUgtuxMJkeoz+RZjWhaBCQo1867DUSB7E7FZYDJ0vMdko6gTou5zR6evhOZ3KD7q+TXgOkmW95YZkuVTV/j8R97UZPQMhQj0gGqFACJv2rPIDN5PizymA5THWWuMZYAGeTNiZeLqQb9eCNPKQ+1RZn+TWxXKbHQvb8Ew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 18:52:29 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 18:52:28 +0000
Message-ID: <9d525fe4-b091-4cd9-b977-de19ffe4b957@amd.com>
Date: Mon, 30 Mar 2026 14:52:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Daniel Stone <daniels@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, kernel@collabora.com,
 Derek Foreman <derek.foreman@collabora.com>,
 Marius Vlad <marius.vlad@collabora.com>
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <4265353.aeNJFYEL58@workhorse>
 <254c20a4-cce3-4c8e-9902-514586f3e694@mailbox.org>
 <5416161.aeNJFYEL58@workhorse>
 <792c4540-d690-4453-a32e-62e23e78d628@mailbox.org>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <792c4540-d690-4453-a32e-62e23e78d628@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0026.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::8) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a8277f-cef3-4e53-0a5f-08de8e8d7d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: gNvsVXPguJWGpSqplzAluoklxIFwfbuCiU9+c9V0lSKSm11WuZklq/Zkl/0pCVAxWFFaKwPbHNIhebXhYvvOL4ZtRtdsPinf6Oix860LJswJbeW4cTXKxbfh3y5yR/INMEroxune9e1+F6f/hluQMQC2bc5sqzvCY3p8es8nzc9ctPUmmZXcmkXX7xwXYcM3RlfxFQWR+IN5EQHHdwxXLd8WwOgm3AJeqVwHXMi69jEmje7CxkAgttQmzevLlPzD6/M2Rn0xSXTma5QLTCQVt5QGfP+jkbNsvaOcuJpNS9vk7D4eMUE314lcVJKuaUjzQRoVK76iuQ7rkxyQLsKXzQx3NHHuRH/Q/COMtzna41/1D982O9bR8I6IWOxncNNiwcUIirIAXORm5CYIQMmW3hbS3n9kYAALJPxods+5xZV4BaCvGKAf5SSeFSLbUh6vnyDrpStgIOf1wcqQbZWMec6RR+Q0/s1ulpCvdHyi1jb6JlrXnBCrqrM3Vd6wgGAWUIQz2IuxodqPqwfpewFV6xYwa8GRLMjnTw30YYwpnTf5Ho/cAIIPlNJ9CqsWZQuPobiZ438ZjEmkbyZipYJwMaCcbriHEg7SveBZOgfsLnyxxqHo1bqtd3UOWhn/KHAqLexb+BPsriTEClypbX77GsJIStfC+q8sJXvEzMq2RhpftKG2eA3tpWluQ33Tql+2RYAfQ4JjSfq7JuBubJn7XHyyT14fjdBFYatTnvY8Tt7IHWsWUd1938f0q4ChJPpG1KYpWr9UE5Jbosc2CKMJEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UklQa1BHbEZGbmFITzFwMmo5LytFVCtISnM1eTdTVVgxYk9SeUYvY2tpRzhM?=
 =?utf-8?B?S1VYckkyc1Y3RDdOY0Zqa01LQnFzK29SNVBzUnk5K1ZOcjFLSTFka2YyWTlj?=
 =?utf-8?B?SGpsUXVQQThNVzZVNU9LaithMng0SUFDM25nMUZhRjEzSC9acmtsZ2txaXFv?=
 =?utf-8?B?alFnNjVlWDFVVC80MjFDbjhPRTA3MzEvQnVYd0JycGxQeVdUT1p2bkxwNkpD?=
 =?utf-8?B?N1RyVkVjb0JyYzFsSDBQYTRQbVdCTWVpMFRNa1J1TXZTQlRWSGJBOWZJQVZS?=
 =?utf-8?B?NU1TK1ZYbEorallZRFRMdklJd2RYa21xZGdOdXFNejZqNDBPMCsyVjBHWFlP?=
 =?utf-8?B?M2dyK2lHTHByVVFWS0RZSGNyeUU4OUZ2ZThIeHBnaWtMRGUvdWVsZHg0Vzlh?=
 =?utf-8?B?UU0zeWxCbmlFSzd6L2JzYTZWb2FIWFNRNnJzLzE2OHFuU0VtQURIUjM0Wlgx?=
 =?utf-8?B?ek4wRGNQQ2xPTHFGNmJ6bFRuSE16NkpOa0ZzS1FmbFNpS3VvYzdud05pRnFN?=
 =?utf-8?B?YVEwQ1luNlZjZUFlTnozNHAxMU9Bb3R5VERVcVdjZy9UbldWejJBUDRYQWth?=
 =?utf-8?B?QnZsNGltMW01R3R2ZkNFYkROMTNXM2k5TDBYZGdFaHNiUXJwNHpBQkJNZ0RT?=
 =?utf-8?B?NGF4R09kWWVidStidUFTMmp1WFU3MU10bk1QaVJzSUJ0U2d6b21WbXRVclBC?=
 =?utf-8?B?MUFqRElWOWlDQ0tVOHFwKy9XM3c1YmgwRmh5MlpwNERVMWhWY1hiRmMzOUMr?=
 =?utf-8?B?a1hUbUh6c1pid2N4SFl6WXVDYUFoRUo1cXRCM2ZTS3IvekpCdDFNL01GKzhT?=
 =?utf-8?B?d0Q3WCtua0pYaUpFQzZhZ05ZeDNENzg4ODVLL3ZjSUd5U2xyWWN4Ui9YWjN5?=
 =?utf-8?B?R0t6NG1iWFhibTVxeDgwQVZUWURuN1NGOXV0MWMwVnZFWVNwcVFZQ3ZNRElU?=
 =?utf-8?B?bXNTRkhadk5McWQwVGlac0hyYWhQc0VqcWlteU1zSEh5ZjNBRXhsTnR5cUlh?=
 =?utf-8?B?MzRydmQ1TUJKeFVyUzl6a1hEY2dUTE9vbHBqYllnZGtCeE9zRUNNZGZaZzBR?=
 =?utf-8?B?YmhIWkQ1ZnBlOVZiSUJ1Qy9GWHUzcERxUUsyaXJPYVlhZXpEckt4RVIwdG9Q?=
 =?utf-8?B?UFM3UnBVeVo5cTA0Ymx5M1d3OS9kWXlDZTF1alQyRy9yRjUvVzZQc1FlYUNN?=
 =?utf-8?B?L0JpRlFYZllLekIrZWdRYXVZK2RNelhkUlNKSXlLNTZ1SFdsSjVua0ZWTnRV?=
 =?utf-8?B?M0dXQUJVelZmWFhxUEJPdDkrSlJUZnI5SXZaSGJlQXBLS2hjVzlaS1NSNnI5?=
 =?utf-8?B?cU40cTZON1NqU040Ym40WkUyVndEdFpTaWp3ZXlBRUJYanpFMVRKU2toZ3ho?=
 =?utf-8?B?TmlvdTZGaGI4RVRuaElCanJTWXRhd0pTT0I1RHh0WmZrUi9YcDliNit1am1Q?=
 =?utf-8?B?bVFsb1VFTDdpTXVDSUJ3UlJrVWgvaFlLeklIYlVyajdVdFJFeEVTRzhsKzJu?=
 =?utf-8?B?bXA2L3NvZFhqRlZWNG5kbkh4b0pRSDJFSDdXSkpybHBOVzBEeGlRQThiT2NB?=
 =?utf-8?B?OXVFVjJFV05WUWhleXgxVy9GZ1BtZzRsWURsWXFIT25ieU0rNE0yU01Rb1dS?=
 =?utf-8?B?aG9BRFF0eGl2bU82eERidmphYTRhd1dBVmdsSlZ1Q1RmNDY1cW1XVUN4U2gx?=
 =?utf-8?B?NmhIa0ErS2dQL3FOOTk4WXpobHFNWmNOcy9DRzFkT1NwUm9vY2VFT0NRalIr?=
 =?utf-8?B?QnVJUTRDL1FGVW1DMEZZNWw1c3BNdkFuTE1Cd3JkRXdwVkV6KytxRTJoU21S?=
 =?utf-8?B?T0FzOVNzNXNBNUZ0YmJvSFNVenNZbm9RaDlxYi9GVFEybUdPWU4wdm1wZnVM?=
 =?utf-8?B?Y09sWER2T1UybUlGbnc0UXZXT2JmUDYrRlpKWEpCKytQd2dwYkljc09DdFpK?=
 =?utf-8?B?M3hJaEtHRXlrWU5mWDVOb25ub3FwUTNWS3diNmgwMVJlYlVUakVQVFpiaVdv?=
 =?utf-8?B?eEVKdzQ4SHpUUHJ6MytCbUJhaDNocEFkZzhwSm15M1ZPQmFiWGFiaFBLcFdy?=
 =?utf-8?B?WURJWjN5QXMzK2lLcUxRa1hNWjZ6Q09WUkNNN243bmIvWElrRDR3OVN2SGY2?=
 =?utf-8?B?cStqb09tVkVNZzdsMWwxcVRrSkJlbk1XclhPaGFsZldsQWgyRTZ2RGh5RlhB?=
 =?utf-8?B?TXdBNm5kZG5DS1BON3ZjWXgvRW9yeXlRQTZrMTlqL0Qvb0ZzcGFsVDFUaGdj?=
 =?utf-8?B?bm9QWlRubVhTS0FTVTRsNDRmVVorZlVkUkZOM2p2Yys3SExmamhIVTFPNzRa?=
 =?utf-8?B?a2FER2RKdlpoejJxbHJZRXZ4dkp0UkRVdS9aYVZYb3JLSGdlWFFiZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a8277f-cef3-4e53-0a5f-08de8e8d7d61
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 18:52:27.9423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0EYfK01DUkw7inz4Nxl/iWQa66P9CmdlkrSHX/7vn4MSUH3RE9MPKBnQ75yjvexcOyHdBmslAgUaon7Yn/ptw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243
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



On 2026-03-30 12:57, Michel Dänzer wrote:
> On 3/26/26 13:17, Nicolas Frattaroli wrote:
>> On Tuesday, 24 March 2026 17:44:21 Central European Standard Time you wrote:
>>> On 3/24/26 16:25, Nicolas Frattaroli wrote:
>>>> On Monday, 23 March 2026 18:27:41 Central European Standard Time Michel Dänzer wrote:
>>>>> On 3/23/26 17:55, Nicolas Frattaroli wrote:
>>>>>>
>>>>>> "Someone might not understand its purpose" is, in my eyes, not a valid reason to
>>>>>> not have this property, [...]
>>>>> Per my previous posts, that's not my concern.
>>>>
>>>> Then what is your concern?
>>>
>>> Per my previous posts, my concerns are:
>>>
>>> * The meaning of the "link bpc" property value isn't defined well
>>> enough vs things like dithering or DSC, which will likely result in
>>> compositors / users overestimating what value they need / want,
>>> resulting in compositors spuriously rejecting configurations which 
>>> would work perfectly fine, and/or spurious issue reports.
>>
>> Dithering and DSC are supposed to be transparent, no?
> 
> Not really, no. They achieve higher "effective" (as perceived by the user) bpc using a lower physical bpc.
> 
> 
>> If a link bpc is 10 but DSC is on so it's 9 on the wire, it's still 10 bits.
> 
> If DSC encodes user-perceived 10 bpc at a lower physical bpc, and the "link bpc" property reports 10, that would satisfy my concern for DSC.
> 

Conceptually I would understand DSC to not effect the reported bpc, so
a 10bpc output bpc would be reported as 10bpc via the property, but
DSC would compress that down to a lower value on the wire.

Dithering wouldn't do that. An 8bpc output would be reported as 8bpc
even if dithering makes it perceptually look like 10bpc.

I can understand the challenge of how to intelligently use it to
report anything back to users. I could see some compositors being happy
to use the bpc alone, while others might want to know dithering and/or
DSC state (compression ratio?) as well.

Harry

> Are you sure that's the case though?
> 
> I would be quite surprised if this was correspondingly the case for dithering.
> 
> Either way, the "link bpc" semantics regarding these should be explicitly documented.
> 
> 
>> No compositor would care about the compressed-to actual bit depth on
>> the wire being 9 bits on the intake of a DSC decoder, it's not relevant
>> for their use case, they're not decoding DSC.
>>
>> Making it consider DSC as part of the link bpc would lead to what you
>> describe, since now compositors would need to know the compression
>> algorithms of every single display protocol to correctly determine
>> whether unintended degradation has happened. Ignoring DSC, which is
>> what I am doing, would not do that.
> 
> Sounds like you misunderstood my concern.
> 
> 
>>> With my compositor developer hat on, what I'd want to know is something
>>> like: "How many bits of information can be passed over the link, allowing
>>> the display to present it in a way which can be perceived by the user?"
>>> With dithering or DSC, that would be a higher value than the physical
>>> link bpc.
>>
>> You're assuming link-bpc isn't precisely that.
> 
> I'm not assuming, I'm asking for this to be clarified.
> 
> 
>> [...], you seem to be obsessed [...]
> 
> Not sure why you keep attacking me personally. I'm not trying to shoot down your proposal, I'm trying to prevent potential flaws I see with it. A bit more cooperative attitude would be nice.
> 
> 
>>>> If all you want is a clearer description of the property in the comment that
>>>> accompanies it, then I can do that, and I said I agree with this point.
>>>
>>> Patch 3 would need to take dithering & DSC into account as well.
>>
>> There is no patch 3,
> 
> The start of this thread is the cover letter of a 3-patch series.
> 
> 
>> and I will not break the feedback loop semantics of this property to please you.
> 
> More ad hominem.
> 
> 
>>>> But you seem to be arguing from a position of not wanting the property to
>>>> exist at all, [...]
>>>
>>> I'm not. However, per the first concern above, a not-well-defined
>>> property could be worse than none.
>>
>> So should I remove max-bpc as well? It's not well defined after all.
> 
> This isn't a good-faith argument either. Nobody asked for that.
> 
> 

