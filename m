Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCCD60A2607
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=M5YQ6DQJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B6F711217E;
	Thu, 12 Nov 2026 15:19:31 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E6310E617;
 Thu, 12 Nov 2026 15:19:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5PWuRmACJrlpXsIf6bNJHgWpy5QHPb8Utm7To/3n7ExtcBrwbE0Cq34gV982IMP2VXDYvNlBaqZBOWnM3Krya9uEzP1lIsJo7UDzIha2h1JF75t1v6ROeiUOTs1sDzBonchdr/v2VJ1GyyuFlOIWsa5H0DnPZ0fj43RYvzqRKxvsKdh3QfK2JygS31OCyM4vrM7N2JcEJq+UhKSpTaG24CpwHUOpIc4jedJrsl3MylEuFJWw7x8LP8fcclWWtbTSny0nSZPlNUYEXgLv1mxVT3WLwEDIAAn/24PqVZ0Mu//NlWdZinyIVcDkCaIsrn1jNRkXXf2lvYrX9hYum5dtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkRjU8GkgGh3V+PDNRHrFrODKPWw+29nyEJFVFodV3M=;
 b=mU/T997ZA/oDi3sIx7ShsojXZLJ1/G2cRrEsezNBphDVUvuEXYxGq3cFMNcvJTmte/iXiyt2QssMcStGo3LiwMEGvy/xmJnAvqhizkc2oMJZl4FZHK4XL1Gbf3e2sXW3ac1fxtoKe7VXbVfeYb73XkgcY/QosAk0/HnMCxYcFxqK2pYgGTPsQFdBzaTPvvl8aAW8y1c+MSavFQh7vGV/ZP/L1vwPRevu0YJlISQRLQtsft7Wix3nwGY0LJxGmLMfbHCqfJUJBhG2VDeAEmln7VKNjiWTbaJ5D6K/DO+ABgKxMME9Mkn6d4gAyhYnxO2Hj0/AetxB9KI4ZkjTfx6qIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkRjU8GkgGh3V+PDNRHrFrODKPWw+29nyEJFVFodV3M=;
 b=M5YQ6DQJftzjicg1F+wn38LD9IoeckDkjeiSZ6gpM3KWoDmoNBUTvzdPTOF2G+1jKwTmSqcAWUY5KcN8PfBOMZLwXGyhp8SqMZYihwUqkZmfmwF9tafZlwO16Krn/fC9VTNQz13AJq9lP9RQQewOOollU7KdJ0aByhYPPkWGACs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18)
 by DM4PR12MB7504.namprd12.prod.outlook.com (2603:10b6:8:110::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 15:19:08 +0000
Received: from MW6PR12MB8705.namprd12.prod.outlook.com
 ([fe80::e75b:745c:ed13:f321]) by MW6PR12MB8705.namprd12.prod.outlook.com
 ([fe80::e75b:745c:ed13:f321%4]) with mapi id 15.21.0592.012; Thu, 12 Nov 2026
 15:19:08 +0000
Message-ID: <796642f5-da07-43c7-9596-771649257b9a@amd.com>
Date: Thu, 12 Nov 2026 09:19:07 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: use atomic commit for panel power
 savings
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: shivamkalra98@zohomail.in, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, David Weber <weber.aulendorf@gmail.com>,
 James Lin <PingLei.Lin@amd.com>
References: <20261111-abm-sysfs-atomic-v2-1-6dfb19c51ebe@zohomail.in>
 <e925978e-7b1a-4780-9e0c-616b9455058b@amd.com>
 <avOFuxeIiMRr2V0p@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <avOFuxeIiMRr2V0p@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:303:b6::12) To MW6PR12MB8705.namprd12.prod.outlook.com
 (2603:10b6:303:24c::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8705:EE_|DM4PR12MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c7a2a60-9cdb-4684-6569-08df40d04c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|6133799003|261009221227099003|261009223027099003|5023799004|11063799006|56012099006|4143699003|261028144727099003|261021121427099003|261102130727099003|261102123227099003|261026140227099003|261026121527099003|261021123027099003|261022105027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: KZAaKqyBq1Puek/rdbeXkgE9tiIOrEtWR2djXYqiZGkWMx2Eye4A2c8dZlKIX3z872P0PStmTjRLd86U5u9meSgZlo+poCZ3Tu7TkRz5wi3LLrCWSrKpXLEgzCw/BPqIQOXh8z30fEGujBr8/jabueePLXWxFa4r+m8gHOJ4Yjyrskbu1NS0KwMNhN4ZoaON5xIEhv0FYEvq9GRf7zhAwHrNn/oDSUiKBYjsgWSDzh2oMu2bsVX0x+U/i2haaF4PwOFAs8Zy5XVS6i7QgE8PBokOnIRAZ4XHlasMaGKC1nUtajARScnGM1i0Trd3w9QZOgrbrtuuPcz1NGOd92I4zVxliVqdJFDrIFA4tI4wa8fD+XbZBKxn/csyHgtpyveRxH/5gYxB+DndOa7+Ft1JdkzfqtsXWqHLFBsWj7/EIEk7gS5xBaZ6mYC/PM1WuBR4V2euWW7ngQfRTVr6OveUP6TsnpziNqVc9eKfUmpIVUbcMhNNNn+bKWK0/ZZ78Nx39PMaI0uNT8ApM4SnXf1DbgyVksPsxYlWggai8lGHsBOv4HF8q7KrLi8tTL/hJdY58anCA3dcOuksyQP/UMX8vNlq29NoqnAKSOUQ41HfPF/4fZ5s6J4l2mvf4j9ve6bF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8705.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(261009221227099003)(261009223027099003)(5023799004)(11063799006)(56012099006)(4143699003)(261028144727099003)(261021121427099003)(261102130727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021123027099003)(261022105027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0VrVG9nRDdUSXl4TDR4YkYvVVIrNG4rSVRYSEt3eFgrVlEyTisrd0p0RWtT?=
 =?utf-8?B?TFB3dXp1QlduNzN3S3BOM2R3ekV4T083QWVkN3ArQ2pXUGhVemtVTWV4Tm4z?=
 =?utf-8?B?VVlKOE16emxxalU0SUc2N1g1ajZTcE5Cait2bDZ2TUcwZVdrQThMbnBvNld4?=
 =?utf-8?B?M3ozQm95Mll5T1JBQzhIcC92bDljeG44Rms5dWdHSmlnTDc2QlhqVjVWRGZr?=
 =?utf-8?B?Y1A3YnMrN3AvKzBPNkZLeEs2d2xHbkQ1MGI1Z2RheU5JUXRuMTV1cDlmT0Zl?=
 =?utf-8?B?Rkh3VjFzUWdhY0l3WHJDZ1pYL0diT0UveDlFU2JwaDRydHJ4bGpway9LRFp3?=
 =?utf-8?B?aG41QVlmT3NXWlhFalBGMFpJQ2JFRTRUeVBYdXFtY3JobVpYM25JWlNodGQy?=
 =?utf-8?B?cUlQTDlEMSttV0NBUFJhYWU1RTArTTRQRUYwU3dFRjNodmpOcVRxN25zNDY1?=
 =?utf-8?B?cmZyaDh0OW9PaXVvYnJMK0huTkNndjkrUDJhOFNlcUhJRkZJWmJ5N0l2S2tm?=
 =?utf-8?B?T1JJdnE5Ui9CYkxrOExjTEtEMmgrS055dzJ1NXJzeldEVnVlUVFxMm5UazVI?=
 =?utf-8?B?Y3p6djNGdGFWMjl0SGtSSm9IbHJzdHpoSFJyTGNYTDlkQ0syK042U3RRTy9R?=
 =?utf-8?B?OU00anZlQjRrU21nTkNFYXY3U0tCcVZJSlE1OGd4L0RVdDBzTyt3NHUrb0FN?=
 =?utf-8?B?SkIwM2YwdGRNQjFDN2FqeFJSblc4NWc4eC9CRTFWUGVaK2tpUTVNRFB0RnVV?=
 =?utf-8?B?QWc2OXBBOGVDSW9WTlNDSUhlMTJrRnJTT1dRVklxU1BlWHFOMkxsMEk4Tkxu?=
 =?utf-8?B?aGZQRnFuSmxsaXh0MlFyR1ozZkhqVGQyYzJ3alRlN3N6V05tWWcyLzV2SThX?=
 =?utf-8?B?M045TU9UQVFlZllYZnhFZVNXYlNSTTdQelRrS3BVZGF3WU9rbVpsbzZDR3Mw?=
 =?utf-8?B?ano5UjhUT0p4b3pzNDZ2dmVkeXVXSWw2ajhBenpLNXdCK01JRjl4VWVvR29Y?=
 =?utf-8?B?Z2MxUmdJcTJNODVpd2FUTDBubE9NcmRVblhaZWorZ2RJU2E4SkdxN3lWWUYz?=
 =?utf-8?B?Z3VXdWZSUTVETHpGQ0JqK0dPVUxVSGpqRTkrWmJaM2lZZC9lYW5hMUdFdGZP?=
 =?utf-8?B?Q3Z6czc3d0JTYXB0UXdTamdoQVFVcXAxVjVvS01HampQaVdleTU4VUJKQVRY?=
 =?utf-8?B?SWdNbFZVZ2VpNWoxdlJzSWhjREZpM3hrYXgzU3prUEc1a2RiUnRjaSsraUMv?=
 =?utf-8?B?VXlkdVcraDNoSm5ySXE2NDFZQi9wbzMvNll2cWJBN1J0aEMvRys1bGhHRURC?=
 =?utf-8?B?RVVVczh1OE9DUm15UjFkWUZEMTdQL1RrWGhzajZsdTI2RitZMGdvbVl0RlZn?=
 =?utf-8?B?dE84TVpYTkJ6eFh5cUlWcEJCR2dHVjh5anlCRk9JZ3psMUJMVVMxRm1Zem81?=
 =?utf-8?B?bDdtQ2VmT21ERUpUb2lCLzNKRm5OSWdLcnExWlA5RzVKVC8zYWJRTDl1MFhB?=
 =?utf-8?B?MjFkOVlzYWdNMmdwU0E3dGZVNHdoRUxacXd1QUI0VjlQK253YjAxQ2xQWWky?=
 =?utf-8?B?bU83R1VVVU9HSFVNdmJib0pxb0IzNGdLY3ZXek9hWFowa2ZGREgxdzFkemo1?=
 =?utf-8?B?cEM5TXlpWlBuWHRmK0RzVzVrcVNHRWEzVnQzT0taTnY3SWozWlNDclIvNXRL?=
 =?utf-8?B?akgwVTM3NUlza2RWQUU2U1NmYlBEVGQwV0xoZHhNU3F5V0MvdlcxRTFuTGhw?=
 =?utf-8?B?MXlZNC9TbENEbDVVU1lqMEw5MmgvdnAxeTR0Uk5EdTc1Yk1EelowWjJTQ21X?=
 =?utf-8?B?YW9Ya2ZZTko5eUh4aEs4dDdTYUpwTC9ERkcwKzQ2Mjhoa3hEUWdTTnU2cjV3?=
 =?utf-8?B?RTh3MDZVVXpJaVcyN1RmWkJRZzZJQnNSQjl5MDlKS1cvRVVUQ0JOZmhRS2xQ?=
 =?utf-8?B?bmUzc3lZRTlaVk1kcnk4VjduQ1pMWVRsQmJMSmNEd2x2QVNQakV3VGgwTVYw?=
 =?utf-8?B?aHNtQWlXUE9ZdDRaY24vVTBnUmN3WUNadGN3b2pNMDVIR2x5emt1VTAvQk1w?=
 =?utf-8?B?dHJlamVFa0dOMnpuQWVlYWNoVUhXRmx1L2JCS2pWYy9RS0ZYMEdDUEVSQWF1?=
 =?utf-8?B?MXJkSzVmMG9YZFF5VzFsSU5HYTNnUWtab1Rhc2Z2ci8rekdEbVhuQUNzaHd1?=
 =?utf-8?B?V0tjRHJWOGlXbEdaRHhtcFBaZDhkUGRWUUQ4MXg0ZWdxL2U2QWV3TzZINWtX?=
 =?utf-8?B?Ni9FM2NmK3E1aEpqL3Bra3VvRmlXVHZvSXlVeWVYdkZZV2hlVndDSWw0OStW?=
 =?utf-8?Q?OItV1weFJ1lqvTSX0W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7a2a60-9cdb-4684-6569-08df40d04c0c
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 15:19:08.4974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFwG2+1UdzJZ/rznPmDlkp1o4x0+fVliJvq1OvnT9Zy/n5ngFri8sDS7a+6IzMP8auOBBYP1fFQ5E3mIryZulQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7504
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/10/26 14:59, Hamza Mahfooz wrote:
> On Tue, Nov 10, 2026 at 02:30:04PM -0600, Mario Limonciello wrote:
>>
>>
>> On 11/10/26 13:24, Shivam Kalra via B4 Relay wrote:
>>> From: Shivam Kalra <shivamkalra98@zohomail.in>
>>>
>>> panel_power_savings_store() mutates connector->state directly and sends a
>>> hotplug event. This bypasses atomic commit handling, so the new ABM level
>>> is only applied when userspace happens to perform another modeset, and it
>>> races with concurrent commits.
>>>
>>> Build an atomic state, set the level on the connector state and commit it.
>>> If the connector is not attached to a CRTC, keep the level in the current
>>> state so the next modeset picks it up, as before.
>>>
>>> In amdgpu_dm_atomic_check(), drm_atomic_get_crtc_state() already adds the
>>> CRTC to the atomic state so dm_update_crtc_state() can propagate abm_level
>>> to the CRTC state. Stop setting new_crtc_state->connectors_changed for ABM
>>> changes and keep it only for scaling changes, allowing ABM updates to go
>>> through the existing non-modeset stream update path without blanking the
>>> panel.
>>>
>>> A previous attempt to avoid the modeset by calling into DMUB directly was
>>> reverted because it broke the abm_gradual IGT test (8d20a066fa9b,
>>> 95aaa207e9ef). This version instead uses the normal atomic stream update
>>> path.
>>>
>>> Extend the backlight KUnit tests to cover the atomic commit and inactive
>>> connector sysfs paths.
>>>
>>> Fixes: 63d0b87213a0 ("drm/amd/display: add panel_power_savings sysfs entry to eDP connectors")
>>> Signed-off-by: Shivam Kalra <shivamkalra98@zohomail.in>
>>
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Others should comment before merging though too.
> 
> I would suggest running this through the weekly promotion before
> merging. As I can recall there were a number of edge cases that
> prevented this approach in the past (mostly concerning display off and
> DC oddities).

That's a good idea. I will send this patch to next week's promotion.

> 
>>> ---
>>> Changes in v2:
>>> - Avoid forcing a modeset for ABM-only changes, matching David Weber's
>>>     patch [1] (Alex Hung; issue also noted by Sashiko).
>>> - Make modeset-lock acquisition interruptible (Alex Hung).
>>> - Inline the state update and remove the redundant connector-state
>>>     lookup (Alex Hung).
>>> - Reuse existing connector-state helpers in KUnit (Sashiko).
>>> - Add a KUnit test for the sysfs commit branch with an attached CRTC.
>>> - Run the amd_abm IGT suite, including abm_gradual.
>>> - Link to v1: https://lore.kernel.org/r/20261031-abm-sysfs-atomic-v1-1-a99068f3b49c@zohomail.in
>>>
>>> [1] https://lore.kernel.org/amd-gfx/20260813112634.11455-3-weber.aulendorf@gmail.com/
>>>
>>> Testing:
>>> - KUnit: amdgpu_dm_backlight, 74/74 tests passed.
>>>
>>> - Hardware: v2 backported to 7.1.13-stable-manual on Rembrandt
>>>     (DCN 3.1.2, eDP-1). All five amd_abm IGT subtests passed, including
>>>     abm_gradual. No HOTPLUG=1 events were captured.
>>> ---
>>>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  3 +-
>>>    .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    | 64 +++++++++++++++---
>>>    .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 79 +++++++++++++++++++++-
>>>    3 files changed, 132 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index dfbc384fbbdb..256699cdd0b5 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -6304,8 +6304,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>    			goto fail;
>>>    		}
>>> -		if (dm_old_con_state->abm_level != dm_new_con_state->abm_level ||
>>> -		    dm_old_con_state->scaling != dm_new_con_state->scaling)
>>> +		if (dm_old_con_state->scaling != dm_new_con_state->scaling)
>>>    			new_crtc_state->connectors_changed = true;
>>>    	}
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
>>> index 27546febf90d..97684a58cd3d 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
>>> @@ -719,31 +719,73 @@ ssize_t panel_power_savings_store(struct device *device,
>>>    {
>>>    	struct drm_connector *connector = dev_get_drvdata(device);
>>>    	struct drm_device *dev = connector->dev;
>>> +	struct drm_modeset_acquire_ctx ctx;
>>> +	struct drm_connector_state *conn_state;
>>> +	struct dm_connector_state *dm_conn_state;
>>> +	struct drm_atomic_commit *state;
>>> +	u8 abm_level;
>>>    	long val;
>>>    	int ret;
>>>    	ret = kstrtol(buf, 0, &val);
>>> -
>>>    	if (ret)
>>>    		return ret;
>>>    	if (val < 0 || val > 4)
>>>    		return -EINVAL;
>>> -	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
>>> -	if (to_dm_connector_state(connector->state)->abm_sysfs_forbidden)
>>> +	abm_level = val ?: ABM_LEVEL_IMMEDIATE_DISABLE;
>>> +
>>> +	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
>>> +	state = drm_atomic_commit_alloc(dev);
>>> +	if (!state) {
>>> +		ret = -ENOMEM;
>>> +		goto out_ctx;
>>> +	}
>>> +	state->acquire_ctx = &ctx;
>>> +
>>> +retry:
>>> +	conn_state = drm_atomic_get_connector_state(state, connector);
>>> +	if (IS_ERR(conn_state)) {
>>> +		ret = PTR_ERR(conn_state);
>>> +		goto out_backoff;
>>> +	}
>>> +
>>> +	dm_conn_state = to_dm_connector_state(conn_state);
>>> +	if (dm_conn_state->abm_sysfs_forbidden) {
>>>    		ret = -EBUSY;
>>> -	else
>>> -		to_dm_connector_state(connector->state)->abm_level = val ?:
>>> -			ABM_LEVEL_IMMEDIATE_DISABLE;
>>> -	drm_modeset_unlock(&dev->mode_config.connection_mutex);
>>> +		goto out_state;
>>> +	}
>>> -	if (ret)
>>> -		return ret;
>>> +	dm_conn_state->abm_level = abm_level;
>>> +
>>> +	/*
>>> +	 * Without a CRTC there is no stream to update and nothing to commit.
>>> +	 * Keep the level in the current state so the next modeset picks it
>>> +	 * up, matching the behavior of the sysfs interface.
>>> +	 */
>>> +	if (!conn_state->crtc) {
>>> +		to_dm_connector_state(connector->state)->abm_level = abm_level;
>>> +		goto out_state;
>>> +	}
>>> +
>>> +	ret = drm_atomic_commit(state);
>>> +
>>> +out_backoff:
>>> +	if (ret == -EDEADLK) {
>>> +		drm_atomic_commit_clear(state);
>>> +		ret = drm_modeset_backoff(&ctx);
>>> +		if (!ret)
>>> +			goto retry;
>>> +	}
>>> -	drm_kms_helper_hotplug_event(dev);
>>> +out_state:
>>> +	drm_atomic_commit_put(state);
>>> +out_ctx:
>>> +	drm_modeset_drop_locks(&ctx);
>>> +	drm_modeset_acquire_fini(&ctx);
>>> -	return count;
>>> +	return ret ? ret : count;
>>>    }
>>>    EXPORT_IF_KUNIT(panel_power_savings_store);
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
>>> index c6d15fb8ad98..586e838a8f63 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
>>> @@ -20,6 +20,7 @@
>>>    #include "amdgpu_mode.h"
>>>    #include "amdgpu_dm.h"
>>>    #include "amdgpu_dm_backlight.h"
>>> +#include "amdgpu_dm_connector.h"
>>>    #include "amdgpu_dm_kunit_test_helpers.h"
>>>    #include "amd_shared.h"
>>>    #include "link_service.h"
>>> @@ -514,6 +515,43 @@ static void dm_test_register_backlight_device_success(struct kunit *test)
>>>    			adev->dm.backlight_dev[0]), 0);
>>>    }
>>> +static int
>>> +dm_test_panel_power_savings_atomic_commit(struct drm_device *dev,
>>> +					  struct drm_atomic_commit *state,
>>> +					  bool nonblock)
>>> +{
>>> +	struct drm_connector_state *new_conn_state;
>>> +	struct drm_connector *connector;
>>> +	int i;
>>> +
>>> +	for_each_new_connector_in_state(state, connector, new_conn_state, i)
>>> +		to_dm_connector_state(connector->state)->abm_level =
>>> +			to_dm_connector_state(new_conn_state)->abm_level;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct drm_connector_funcs dm_test_panel_power_savings_connector_funcs = {
>>> +	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
>>> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>>> +};
>>> +
>>> +static const struct drm_mode_config_funcs dm_test_panel_power_savings_mode_funcs = {
>>> +	.atomic_commit = dm_test_panel_power_savings_atomic_commit,
>>> +};
>>> +
>>> +static void
>>> +dm_test_panel_power_savings_crtc_destroy(struct drm_crtc *crtc)
>>> +{
>>> +	drm_crtc_cleanup(crtc);
>>> +}
>>> +
>>> +static const struct drm_crtc_funcs dm_test_panel_power_savings_crtc_funcs = {
>>> +	.destroy = dm_test_panel_power_savings_crtc_destroy,
>>> +	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
>>> +	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
>>> +};
>>> +
>>>    static struct drm_connector *setup_panel_power_savings_connector(struct kunit *test,
>>>    							 struct device **device_out,
>>>    							 struct dm_connector_state **state_out)
>>> @@ -527,6 +565,7 @@ static struct drm_connector *setup_panel_power_savings_connector(struct kunit *t
>>>    	adev = dm_kunit_alloc_adev(test);
>>>    	ret = drmm_mode_config_init(&adev->ddev);
>>>    	KUNIT_ASSERT_EQ(test, ret, 0);
>>> +	adev->ddev.mode_config.funcs = &dm_test_panel_power_savings_mode_funcs;
>>>    	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
>>>    	device = kunit_kzalloc(test, sizeof(*device), GFP_KERNEL);
>>> @@ -536,7 +575,11 @@ static struct drm_connector *setup_panel_power_savings_connector(struct kunit *t
>>>    	KUNIT_ASSERT_NOT_NULL(test, state);
>>>    	connector->dev = &adev->ddev;
>>> +	connector->funcs = &dm_test_panel_power_savings_connector_funcs;
>>> +	connector->index = 0;
>>> +	kref_init(&connector->base.refcount);
>>>    	connector->state = &state->base;
>>> +	state->base.connector = connector;
>>>    	dev_set_drvdata(device, connector);
>>>    	*device_out = device;
>>>    	*state_out = state;
>>> @@ -614,10 +657,43 @@ static void dm_test_panel_power_savings_store_sets_disable(struct kunit *test)
>>>    	setup_panel_power_savings_connector(test, &device, &state);
>>>    	KUNIT_EXPECT_EQ(test, panel_power_savings_store(device, NULL, "0", count),
>>> -			 (ssize_t)count);
>>> +			(ssize_t)count);
>>>    	KUNIT_EXPECT_EQ(test, state->abm_level, ABM_LEVEL_IMMEDIATE_DISABLE);
>>>    }
>>> +/**
>>> + * dm_test_panel_power_savings_store_commits_with_crtc - Test store with CRTC
>>> + * @test: The KUnit test context
>>> + */
>>> +static void dm_test_panel_power_savings_store_commits_with_crtc(struct kunit *test)
>>> +{
>>> +	struct dm_connector_state *state;
>>> +	struct drm_connector *connector;
>>> +	struct drm_crtc *crtc;
>>> +	struct device *device;
>>> +	size_t count = strlen("3");
>>> +	int ret;
>>> +
>>> +	connector = setup_panel_power_savings_connector(test, &device, &state);
>>> +
>>> +	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
>>> +	KUNIT_ASSERT_NOT_NULL(test, crtc);
>>> +	ret = drm_crtc_init_with_planes(connector->dev, crtc, NULL, NULL,
>>> +					&dm_test_panel_power_savings_crtc_funcs,
>>> +					NULL);
>>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>>> +	drm_atomic_helper_crtc_reset(crtc);
>>> +	KUNIT_ASSERT_NOT_NULL(test, crtc->state);
>>> +	state->base.crtc = crtc;
>>> +
>>> +	KUNIT_EXPECT_EQ(test, panel_power_savings_store(device, NULL, "3", count),
>>> +			(ssize_t)count);
>>> +	KUNIT_EXPECT_EQ(test, state->abm_level, 3);
>>> +
>>> +	state->base.crtc = NULL;
>>> +	drm_crtc_cleanup(crtc);
>>> +}
>>> +
>>>    /**
>>>     * dm_test_panel_power_savings_store_forbidden - Test forbidden update
>>>     * @test: The KUnit test context
>>> @@ -1939,6 +2015,7 @@ static struct kunit_case dm_backlight_test_cases[] = {
>>>    	KUNIT_CASE(dm_test_panel_power_savings_show_reports_level),
>>>    	KUNIT_CASE(dm_test_panel_power_savings_store_sets_disable),
>>>    	KUNIT_CASE(dm_test_panel_power_savings_store_forbidden),
>>> +	KUNIT_CASE(dm_test_panel_power_savings_store_commits_with_crtc),
>>>    	KUNIT_CASE(dm_test_panel_power_savings_store_rejects_invalid_text),
>>>    	KUNIT_CASE(dm_test_panel_power_savings_store_rejects_out_of_range),
>>>    	/* amdgpu_dm_backlight_get_device_index */
>>>
>>> ---
>>> base-commit: ba496bb837882eb1af58f41572fc289e46c77b8c
>>> change-id: 20261031-abm-sysfs-atomic-c79505f63a2e
>>>
>>> Best regards,
>>> --
>>> Shivam Kalra <shivamkalra98@zohomail.in>

