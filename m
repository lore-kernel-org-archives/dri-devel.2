Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9904FCDE008
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E337610F21B;
	Thu, 25 Jun 2026 10:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yXK0gqkx";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011006.outbound.protection.outlook.com
 [40.93.194.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40D3710F20B;
 Thu, 25 Jun 2026 10:13:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqYf2s4mOjw/crlP8cxe3ZwVPsaMBjQLGQ+Xcg7RlCRABLPq+YEE/gjY+pHfC31b679A8+RNhqiZHavHadN1jiOOq1MfPHs4Jaq+qhb4hzp8VyQ1VVvnZ5vH4IUkCX+g0cIHmNm0QQqu8nUNXj6QMqgwgq3lXap/+1LvEpB2iqTLUU+JNb13rcZvpE0n20fJFg/Z8hKJ4Ze2qbiHMRcFmaA3kcacs/Xvpuygiof940MLWmLTL8zPfTZPcb7ha5C9odJ8SLk6KLgzShZFgcKEe5idTR4PdidQETKIIApXW/tZ5TjwaHWvfY+igw4POHaNelnsRv14xDsdCYqLZ04ylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrMBxvLUYSeL2UVUtpLkcwzMoaaAtLDTiZMqoS/qN1o=;
 b=vAve8R+BoFuNCwsCqI7SzcnbUgPVLLwiP2Hs6VoGWzcHBOolcI1LVbVrnpuXJzW0dGTWs9i1w1ynkS3D0HGHPxHFewUbITwkLcCaiMBpZWv84EkIAcDTpc6wPcifPpg4/Dhvww9UR+jDGXpuSO2TciEc/jOa/U4HhHNzRQKyDoRskr+a7fWa1cr38MIisW5QeY/A0gNF8CQOdwr3VYKgdKc8pUW8ntRukFHqAQBIBliwYcXaiig5GD5pCgM6Z7KOff1sblCVl5T3gdJLbJKsIkP6AkMAD2sh7E0+7yEMa8PiQy2Kt6RSsC2Eg0u7kBWcdWOPJNiRWog3piZ9xk7Hpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrMBxvLUYSeL2UVUtpLkcwzMoaaAtLDTiZMqoS/qN1o=;
 b=yXK0gqkx0ZcMyc1jYeCeu551SnW4xutc2i+9am+M9BCjJJNYVy6WVrOlasmhg2DehHr2bGPsm39WJrIEH3f2y3bdsfCU2TJJJjEBObn6Ny5uWATfQaj0/ycPR87LJAQafuMpXRKEsAhtZbs0JKhlIthNilQn/8XFOmn51Ax5wkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB9036.namprd12.prod.outlook.com (2603:10b6:930:78::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 10:13:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 10:13:55 +0000
Message-ID: <ff6ec078-9b3f-4740-bb87-66b76e36e571@amd.com>
Date: Thu, 25 Jun 2026 12:13:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/amd/display: Pin native scanout to VRAM on
 large-carveout APUs
To: Harry Wentland <harry.wentland@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>, Melissa Wen
 <mwen@igalia.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, natalie.vock@gmx.de
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
References: <20260616071037.26718-1-matthew.schwartz@linux.dev>
 <334d4642-a7ce-4d04-ab14-6b95653e6f86@amd.com>
 <09a37c38-3f99-40bf-9a87-f88298ce349a@amd.com>
 <9b96d6a5-7c3c-4bd5-8785-76c9642bc933@amd.com>
 <faa1c424-2282-4e70-9934-e29f437f8bbb@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <faa1c424-2282-4e70-9934-e29f437f8bbb@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0294.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB9036:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1ff40b-60fc-42e4-43f2-08ded2a276f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|5023799004|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7RRVmwaYk+qnVpG+UFQSaerQA/vHb0dnpTt+DmZB2L4KXMbU8FFotworJtrY9uPS/A1OiSQUym6dCdEK7Tz/0B8Cgk9LaKwoCCxRP0C9CZ3NTwP/wu6ZvvjXrrVRD/LrhiOIuz2wQ77XRb0+uRnpBSicJDFAE/kxM8qpqk/dyLszAaN3o/iizCPJvk2hzy0U62IWpbG4ytF3s+QjMmIGHOXe7apkHspVVbt4VaLbMI9/x0CwdEoUozgWlAp3j0WHhqJYM7/x9L0yJaUMCZFWgpsVre9GChXIMKzNFDrU2VGH3goqP/XdNVlmD4ESfUyd/IK0T2B1IrfS3YJ7FwDHFrImLPv/RqzPgSGm6En4oxHDKY8Q90Ra0+XzJzWWVfzyZtPbNRTx3VLrOmffOfco0RiHghH3rFDHdkOX8kX8GQmxxBnRCLu8wYtYMjeE6ypSLY0sJmnW0YPoIVmjRdbfJ7dTgIoUOIzpNGGuz+8CjsseH7VVHZmGm3hsVP3VgykC6IvbaGTyLtmbtXyAdRXAHQuOv69ltXQIwUo2g39pmilZPVEJWduUOOREcOiBGhT1+9ZYo8lOIh36+V1AQ5GLBiLUFluDZsVNBHJDXXs7CJFifKVbLeBmCixGzzn+uOWLtd/04nMRfC56+aUwh0Qaxjzjk8G+YNpmGhZfWLbp09w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(5023799004)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUUvdHR5bUM0MWlZMEdqTXF1UHhwWGM1Ym5sTTFzMERnMTIxbTR2WllTanVv?=
 =?utf-8?B?a21zWXZvTXE3NkgwS0tmbWpyYmxvcHA3Rzd3QVpxZzFudjNhMmJJNnhoNkcr?=
 =?utf-8?B?UG9nb2ZURFhMcXlGYU5HLzd0TFFFV21NMDM5UncyWHhYRXBoVXZpTkwwUmlN?=
 =?utf-8?B?cFVhcmVVclY3a2EzTE9Rc1FnMEFwNnY1MHk1WUdSdHh3UVFhMnVXYldCaTZ6?=
 =?utf-8?B?KzdVbXpLZTdqVkFLRWwyS3dQSzdjRVZqNS9nRkovcjUycXZOV2VKaWlLWjVP?=
 =?utf-8?B?azdpOGhjOG1rQzZKaTZjTnpPQ3I3VU1HVzh5Y2xjckxUdkVCV2RVcnlYRDcv?=
 =?utf-8?B?ditsaHhrc3BBbEVOaUozVFhRSmpzeUxLMGJSeFEyTldJWnhsbHBCNE5LNnRS?=
 =?utf-8?B?T1NzVkRvSGEwblN5anAvbXhjWmlKU2xCcURsN0tybCtYZTZuVTBUaG9YRzky?=
 =?utf-8?B?K1UrT0VnQWdRdWNLRVBFM3pQMWViRFJuVmhsdXlPeUErOEsrRDEyVDNqTTU5?=
 =?utf-8?B?Ni90RnJhRm1ENTd0YkxsTW1OSEVTbFIwbW5HN1lXS0h6MTU4SnoxcFdVcEM2?=
 =?utf-8?B?YndTYXlDVThJcFZDUFZkbE5TWXVESFduVnpRU25rVVl2R0h2alNXUDFWaXE5?=
 =?utf-8?B?ZUc1bndFbzVjUFExSzZ4SjNETXNvZ2pIWXY0Rk1pRjhrcGFrWXlDSmhEKzNy?=
 =?utf-8?B?enVlUXB3RndkdmwvNDVJdmNuNU5sdFU2YlRGeWlmRVNsckMwQ3J3TWV1Z0p3?=
 =?utf-8?B?aDdaR3Qrak9TK3RHeGZuY0xIK3Y0ZEE5TkNDTlV5N01zdHRRVzUrQTFKdzJo?=
 =?utf-8?B?bjV1d08zMGM1dGpUeERqcFNoNC9hTXE5cDVzQm9xZkpBWHEvaE1PQlBmNmRq?=
 =?utf-8?B?RGJSYjVBRG03amVVU3hMRko3K2Nucm9PelhoT3FwRDh6enFFZzJmWFhSdEFC?=
 =?utf-8?B?Wnl2OUZTbDJseUswS1F5djdXWHprUC9BZjZYMjJHTUVncTFxZHVNVmR4dkdG?=
 =?utf-8?B?UWIwUTkzbXVKWVlQQ3dJZlJzOWNGUEJoZWJqNDJEejBHbThDZTBYakphL0pQ?=
 =?utf-8?B?bisvbW1hbzZZSEVFbFFQdC9sWmhSQTJCcXJwTTNucjJoU3o0b3RwQWJsWXN5?=
 =?utf-8?B?Mm9zdkZFTWliU241MEZKRWRGL3htb29EUjhxTXc4em9JczBlK3FiaTRKNitY?=
 =?utf-8?B?UUZWYmRTbS95dUVPU1kvV0hJZXd6U2VWcHQ5VVg5c0hubEJyVGdNbkpsZC9o?=
 =?utf-8?B?amJESEp1VzN1bUJzbDIvdmFSRzlHM2d5aTZjVU5yemFOa2h0dGdQNXQ3c1dC?=
 =?utf-8?B?SWwvcHNnMUkwN1I5QzVqQlMvNFgzcHhKMW40emVNS3M5dXlobzF2cHRMT0NQ?=
 =?utf-8?B?QnFRU1dZRjFtdkZaN2JOSHBhYjlBMlpUREpyTDlXYXNXRFJleUUzVHJEMTZI?=
 =?utf-8?B?MWNoRTRBQk5xSmlWaDFBZ2R4V3ZHbmFXdEplMUp0T1UzampraXdVaUZBVTVX?=
 =?utf-8?B?WjBBQzNLZ3FCczVRb1RYNThYRzY5eU16MFRoMFNnWUZJZGRhaXRaWFcvYkZX?=
 =?utf-8?B?cDNHUTJFWGtBVW5aRUppRUVWNndXSVpnbkFmMTM2Y3VPQ04rRkUzQUhrUmZ4?=
 =?utf-8?B?azh3cEF4SEozeHJhcGU1L0tTRDJ6Z2FCOCtvRlU4RE11VWgvajNJNzU5RXNX?=
 =?utf-8?B?ajY2amM4a3VxOXBDaUVESGJ6V290RWtUVkEzRkxQRHJtVmhVUXZEUy9pdVBP?=
 =?utf-8?B?R09zdjE3NDJEdFlhQU8yL0tTdzF2alFScGxOdnNVYXkzQjhnbmM0R3VMVEZB?=
 =?utf-8?B?eGs4aGZaUlNZYThMbmxJVCtDbi8xVVc1QnFwMzkzWEVXUHk0czM0bG16WDBq?=
 =?utf-8?B?bUhWZ3hEVnAyK2tBMGVMRUNaVG5qWGVZVmhIb1FVTW01SVA1MUZzUi8yZThI?=
 =?utf-8?B?YXZhRUQ0Mmd3T1FHVHVBNkZ4MnZzYWE1aFUxRDJyd0lyUjNRNFlONjY2clQv?=
 =?utf-8?B?S2x0QUN1RENpaU9nZXpocWVQZmpJQ0VpRmgrbzg4NUNkdE5ocUVBdFZ4SEFp?=
 =?utf-8?B?am9Oay9ZR1gvSUN3NmRRWGtOUnp2TFhkRk1kd1hMbjRPVnFFemxKUkVSQU5X?=
 =?utf-8?B?VWVzaHBDZ0lRSnJPZy9laVR3bFFWSWRnNDJEZ09hTGVOV1c0Z3ZodWwvTDNR?=
 =?utf-8?B?bkFrRzNZdHZEaHdPTkZMcVBsaHVTdGVJZmFVcW9sczFlSnhDUWpGbHJTKzhn?=
 =?utf-8?B?eTRwWWhVK0RBWnIweG44anBYbERWRllQdmY3UVUvZjdQYldhRkUzNG03ZWJC?=
 =?utf-8?Q?iimllv6A9JLFXS86Dz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1ff40b-60fc-42e4-43f2-08ded2a276f3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 10:13:55.7057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6btiBhToYvk60+igugP1txcLkb1lxpejOwd0P3XyrzfuU2a4O+AQu4uhQF3amk8h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9036
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

Adding a few more people on CC.

On 6/24/26 19:55, Harry Wentland wrote:
> On 2026-06-24 11:52, Christian König wrote:
>> On 6/24/26 17:30, Harry Wentland wrote:
>>> On 2026-06-16 03:31, Christian König wrote:
>>>> On 6/16/26 09:10, Matthew Schwartz wrote:
>>>>> Native scanout buffers on APUs are pinned with the VRAM|GTT domain, so
>>>>> under VRAM carveout pressure a swapchain can end up split across VRAM and
>>>>> GTT. The scanout buffer's memory type then changes from one flip to the
>>>>> next, and amdgpu_dm_crtc_mem_type_changed() rejects an async page flip
>>>>> across the change. The result is repeated async page flip failures,
>>>>> observed as choppy updates under carveout pressure, until the buffers
>>>>> reconverge to a single domain.
>>>>
>>>> That's intentional behavior.
>>>>
>>>>> Pin native scanout buffers in VRAM only so the swapchain stays in one
>>>>> memory domain. Restrict this to APUs whose carveout is larger than
>>>
>>> Above you mention that under VRAM pressure a swapchain can end up split
>>> across VRAM and GTT. Wouldn't restricting the swapchain to VRAM now mean
>>> that in those cases you fail to allocate the swapchain entirely?
>>
>> Yes, exactly that.
>>
>> My educated guess is that the display server then falls back to using a copy instead of a flip and that helps saving memory somehow (e.g. less scanout buffers alocated concurrently).
>>
>> Would it somehow be possible to get DC to dynamically switch between VRAM and GTT?
>>
> 
> DCN can't switch between mapped and unmapped memory. I'm not a memory
> management expert but wouldn't GTT be in GART (mapped) and VRAM in
> the (unmapped) FB aperture?

Well at the moment yes, but that is changeable.

It's correct that for scanout we currently access GTT buffers "mapped" through the GART while VRAM buffers are accessed "unmapped" through the FB aperture.

As far as I know starting with I think Vega or Navi 1x (or maybe Navi 2x/3x you probably know that better than me) the DCN block became capable of scanning out through the GART as well, which is a prerequisite that we can allocate framebuffers on APUs in GTT in the first place.

So what we could do in theory is to allocate a window in the GART address space, map the VRAM buffer into it and then start scanning out from that address instead.

We already do that for a couple of workarounds on older HW and to copy TMZ buffers etc... So most of the infrastructure necessary is now already there.

This would also reduce the pressure on the VRAM manager backend because we don't need to allocate those buffers contigiously any more. Leading to less pin failed with -12 errors when memory becomes tight.

The only problem I see is that I don't know if this doesn't have any negative effect on the DCN power consumption or something like that? That's where I need input from the display team.

Additional to that we need to find somebody who implements/tests that stuff, but maybe Timur or somebody else from Valve could take that since I think.

Regards,
Christian.

> 
> From DCHUB HW doc:
> "No change from mapped to unmapped or unmapped to mapped is 
> allowed for immediate f lip"
> 
> If so, we can't async flip between them.
> 
> Harry
> 
>> Regards,
>> Christian
>>
>>>
>>> Harry
>>>
>>>>> AMDGPU_SG_THRESHOLD, so small-carveout parts keep their existing VRAM|GTT
>>>>> placement, and fall back to GTT when the buffer does not fit in VRAM, so
>>>>> the flip still succeeds and the swapchain stays in one domain. Imported
>>>>> buffers may only be pinnable in GTT, so leave those on the default
>>>>> domains.
>>>>
>>>> The display guys need to take a closer look at that, but it sounds like what we used to have before and that caused problems.
>>>>
>>>> We somehow need to change the DC stuff to allow switching between VRAM and GTT frame buffers to fully fix this.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>>>> ---
>>>>> Hi,
>>>>>
>>>>> This came up while testing my kernel patch to fix mem_type detection for
>>>>> async flips here: https://lore.kernel.org/amd-gfx/20260611154438.571685-1-matthew.schwartz@linux.dev/
>>>>>
>>>>> I found a new issue where splitting a swapchain between VRAM and GTT
>>>>> causes a noticeable stutter in gameplay if gamescope is using direct
>>>>> scanout and tearing is enabled while a game is already running.
>>>>>
>>>>> Once a swapchain is split across the VRAM carveout and GTT, the scanout
>>>>> buffer's mem_type changes from one flip to the next, so
>>>>> amdgpu_dm_crtc_mem_type_changed() rejects the async flip. Under direct
>>>>> scanout with tearing that rejection recurs every time the displayed buffer
>>>>> crosses domains, which is what surfaces as the choppiness. 
>>>>>
>>>>> With this patch, I can enable tearing on top of an already-disabled frame
>>>>> limit mid-game and no longer reproduce the choppiness.
>>>>>
>>>>> amdgpu_gem_info confirms the swapchain converges to a single domain
>>>>> instead of splitting across VRAM and GTT.
>>>>>
>>>>> Before:
>>>>> 0x00000f81:      3981312 byte GTT exported as ino:275 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC     write fence:drm_sched gfx_0.0.0 seq 88248 signalled
>>>>> 0x00000f82:      3981312 byte GTT exported as ino:276 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC     write fence:drm_sched gfx_0.0.0 seq 88224 signalled
>>>>> 0x00000f83:      3981312 byte VRAM VISIBLE pin count 1 exported as ino:277 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC        write fence:drm_sched gfx_0.0.0 seq 88236 signalled
>>>>>
>>>>> After:
>>>>> 0x00000f82:      3981312 byte VRAM VISIBLE pin count 1 exported as ino:548 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC        write fence:drm_sched gfx_0.0.0 seq 822258 signalled
>>>>> 0x00000f83:      3981312 byte VRAM VISIBLE exported as ino:549 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC    write fence:drm_sched gfx_0.0.0 seq 822255 signalled
>>>>> 0x00000f84:      3981312 byte VRAM VISIBLE exported as ino:550 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC    write fence:drm_sched gfx_0.0.0 seq 822261 signalled
>>>>>
>>>>> Does this seem like the correct approach to take for fixing the observed
>>>>> issue? I wanted to start with an RFC to make sure I didn't overlook
>>>>> anything obvious or miss any better methods of fixing this.
>>>>>
>>>>> Thanks,
>>>>> Matt
>>>>> ---
>>>>>  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 29 +++++++++++++++++--
>>>>>  1 file changed, 26 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>>>>> index 23a9faa2ea89..b99f938e58ec 100644
>>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>>>>> @@ -932,6 +932,7 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
>>>>>  	struct amdgpu_bo *rbo;
>>>>>  	struct dm_plane_state *dm_plane_state_new, *dm_plane_state_old;
>>>>>  	uint32_t domain;
>>>>> +	bool pin_vram_only;
>>>>>  	int r;
>>>>>  
>>>>>  	if (!new_state->fb) {
>>>>> @@ -958,13 +959,35 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
>>>>>  	if (r)
>>>>>  		goto error_unlock;
>>>>>  
>>>>> -	if (plane->type != DRM_PLANE_TYPE_CURSOR)
>>>>> -		domain = amdgpu_display_supported_domains(adev, rbo->flags);
>>>>> -	else
>>>>> +	/*
>>>>> +	 * Pin native scanout in VRAM on APUs so a swapchain stays in one
>>>>> +	 * memory domain. A VRAM/GTT split changes its mem_type between flips
>>>>> +	 * and amdgpu_dm_crtc_mem_type_changed() rejects the async flip. Skip
>>>>> +	 * small carveouts that may not fit, and imported buffers.
>>>>> +	 */
>>>>> +	pin_vram_only = plane->type != DRM_PLANE_TYPE_CURSOR &&
>>>>> +			(adev->flags & AMD_IS_APU) &&
>>>>> +			!rbo->tbo.base.import_attach &&
>>>>> +			adev->gmc.real_vram_size > AMDGPU_SG_THRESHOLD;
>>>>> +
>>>>> +	if (plane->type == DRM_PLANE_TYPE_CURSOR || pin_vram_only)
>>>>>  		domain = AMDGPU_GEM_DOMAIN_VRAM;
>>>>> +	else
>>>>> +		domain = amdgpu_display_supported_domains(adev, rbo->flags);
>>>>>  
>>>>>  	rbo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>>>>>  	r = amdgpu_bo_pin(rbo, domain);
>>>>> +	if (r == -ENOMEM && pin_vram_only) {
>>>>> +		/*
>>>>> +		 * VRAM could not fit the buffer. Fall back to GTT where
>>>>> +		 * allowed so the swapchain stays in one domain.
>>>>> +		 */
>>>>> +		domain = amdgpu_display_supported_domains(adev, rbo->flags);
>>>>> +		if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>>>>> +			domain = AMDGPU_GEM_DOMAIN_GTT;
>>>>> +			r = amdgpu_bo_pin(rbo, domain);
>>>>> +		}
>>>>> +	}
>>>>>  	if (unlikely(r != 0)) {
>>>>>  		if (r != -ERESTARTSYS)
>>>>>  			DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
>>>>
>>>
>>
> 

