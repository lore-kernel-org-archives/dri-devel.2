Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D69C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 07:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B59910E718;
	Thu, 16 Jul 2026 07:34:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="19sG7xwl";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012068.outbound.protection.outlook.com
 [40.93.195.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0AD110E70D;
 Thu, 16 Jul 2026 07:34:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8UmSJJhvXZmAmb8+mk2UCB94WigKJEG58cfWvvdDnVJTNI1msdqfzIG07Eexfnyh+HKRKPxIvSWMng5OE5nIWxPdlKm0kVn04MpfzZPWswaAZlfUD7wnFXtU1usc++eHSTDuqdJLwl3DWfyShgYR0PUVl+HftL4VGljF4V8g5W+3IpACqSinQbZ7md0h6y+hc7jXZ+6HNXmxxkFAcQe/dYkbTHgIiBu1JgU//5XMWdrcsRR8z9J6AxSFKP5v/dDi+2Qi2vcvS2nE/ljWuj28qrjKvtDTRukwHbpwNEh3qQMFG+nQl+DR9Iu3JbKaCIF6z278KWA6PZ7BEsjIKLzWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fi2clKDzpKiAznS/JTCtfM/Q6qodJzmDG8q+LTqyFeI=;
 b=tOAucph7TNwg4wTQfe5qtSZbeFMK2AMxQtavMqwvlmlhKNGMTniwSaokO3k/nbXFkvTimLIt6Hm4VE8zPGWIiX9HBYGavyBHTwcIy9Quc+JYV3vedQx6YKHjPTk0bYWPIrpxiMEP8a5O4t36qav8FOypjglvY8Y+00lpZdcjp7/+p+VRG4H30UwLvtNxiAcS/qxsC5TFgZwJ+8oPtrvU+YlHFv+r9Yp39Vo1042zgEwGjdvPqBmfVcPphUTl1t5f9c5eZwqHy+nMbsmjtXlPMyOmDD93X0rXkvKSQKvN6kKNqXCmgi2tyFS23O3Lr5JfVoYD+VhVUb4nzMkjbKZ0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fi2clKDzpKiAznS/JTCtfM/Q6qodJzmDG8q+LTqyFeI=;
 b=19sG7xwlhcZHAx7sZ5CVnVBQUTxs91y5QUqu1zcI4t8Z+mM0/RIE6K3ADj3FHP0Z3iiZDpvAbPg//2Vq23xk5BsWqO1GgfU05ArgnqwmV+YXk2GCph3dvXlbnAC+Y95TArtlQdXuwg3k8FH0P4XHzM1Fx+/gjvVHeUPbVMZ9PBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SAWPR12MB999165.namprd12.prod.outlook.com (2603:10b6:806:4e1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 07:34:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 07:34:16 +0000
Message-ID: <7619ffd0-a77b-4596-a9ab-8e5172c929e2@amd.com>
Date: Thu, 16 Jul 2026 09:34:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon: allocate dummy_page without DMA32 on fail
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260714-radeon_32bit_fix-v1-1-42a99945f6e0@oss.tenstorrent.com>
 <11218edd-ae58-4966-8172-27b2435eaa1f@amd.com>
 <CAEev2e_gnmhYw_mV8zt2AnkY6Hj_F165veoAPaXhA_ej-5RUUg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAEev2e_gnmhYw_mV8zt2AnkY6Hj_F165veoAPaXhA_ej-5RUUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SAWPR12MB999165:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fac12fb-5483-4ede-7608-08dee30ca40e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|18002099003|22082099003|3023799007|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: vwFllCJcMGCYD/0ObP27i74JbfSRA5M8DKqhAAuLwfd+L5vusTKruy0k1Ld/x/KFdlrvdgwpevtoxBWwa4jJT6XgRWq1wQg+lCStd0xCz8EO1xBS4xtTIHcQz3OKF1MtIbfhvrS01Rb07S9OvWtcuTpaaxudRRM3Bud8+o3O6fE8xMpECPMqdUfqAnGRu0z9mp2pZVP5ujdE++uPdKe27Udy+ibAatiPinL5WjkuzbVe+iorn3cvypu6vsENINVhgu2UQ17oioQGslrgfheUrjs0UaaVDh/DSNFL5Cj8gqLju1K3EvDkQ7FM/s7iIZBeJpCMdy01AKyEeISFWX37lSgihKLU1NrhCpJB9XFNcKBw9gcRuNluzLeozKLOi0qcW4COxeeKPcr9bfSl+3Leg8BYAGxGzUxvTM3wI5jqD9P6IqTbNUTbNfwqv3QUYAw0lWBivgXn+/fs049HX6KHenkdTGAGPo9OZ5NIhvctVjr0t3tvhWslwWYPD/cgUTvQk1cFtWnP+RXzSGel8GR1U/2VdjzS+nQp56deRTODu8cLofLsNL2Axb/bvv/u3t6amrpGC5bOVYmJ2bmk0QMTktURoyIfg7orOaFxhKzlA4c7aOM5+6nntQnK7vbQgM1DiKehi3nLGWrLAXD5tUWmHk8UaVn5jCl+PIaArb9tXtw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(18002099003)(22082099003)(3023799007)(10067099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2h1aXZyWVc2ZDduZkFld2VtL3prR3Q4amt5ejg4RUdXZlB2VEQySVBma21I?=
 =?utf-8?B?WllkODRMVVNlcE00bitKTlVnOVNneFNwdFJkcHhJTGcyM1p1M0NrTnM4R04w?=
 =?utf-8?B?VmZDbmlNc0pLdlZReGtwOGFPSDVWNTl0L1ZTWnNlUmsxQ0o2YThsZ0hlMytI?=
 =?utf-8?B?eGhVdENoTXFxOGNDcHhCd2xHK0x0eE1iUDR6Q3ZzaHdNWXo1Ty9Zd2Q1T0Ey?=
 =?utf-8?B?UHdjTTErTE1LZElaY1V0UzJQZm5iWm11NUVNaExuSVcyMkNOVEEwOWFZRW9Z?=
 =?utf-8?B?YlZ6RldwYyt5VXZyc3d4bUtONG4wU3RmSXh0Y1FqTkl6UHRkbVRsUFpzVGxu?=
 =?utf-8?B?OUNTZFRDZXp2Q3NFQlRXTXNoemt0RS85WFZoRDdScmJoeUEvcFlOWmxDSEpG?=
 =?utf-8?B?VDBVU3pWQmRlRnF0NHhiRmhiZUFDcHFlYmxqSzVieG5vOC9BT1hOdzRiUzE4?=
 =?utf-8?B?Mm5pZFl1T011b21CWWp2MzM1cGY3MUxEV1ZwZVBPcjhsTzR4TjVJUmYxNVFw?=
 =?utf-8?B?OWxLbThXcnFLQ3dSS1lGVjNXZFBIS21NMWtKZ3FkRmV1SlNzaEVCTmtOSTlh?=
 =?utf-8?B?SERVN3FhUFNESVAzK2dKd2cyMGZvM1VwZURvRDZUc2ttUWozQW0vTnZ5WGJl?=
 =?utf-8?B?dnRRNURsYy9ES0ZUY1E0OG90QmptV2Y5ZTFwUk94TFBWM0dpNm1HTnRVY1dY?=
 =?utf-8?B?MUxocml4VG5RODhKdk5hRmhvRURzUW0xaGtTai9maW55K2t3czdmNEg1R1Jl?=
 =?utf-8?B?UGNhaFhSQXlNME5GZitWYm5vZnBQVkoyRHFjUHZsMzFKTElxTHZ0Y3psTHZM?=
 =?utf-8?B?K0t5ZU9jOSsvQ0hZb0x1YmhtL0FCN1JCL2gvMUVGNlNnNmVxajFCYWJQSyt3?=
 =?utf-8?B?WTZ6RTViZDFpbUJxRWhLR0k1L1BVN1FtaWtDRmh4a2Y1eEhDSE1qYXhLV2VC?=
 =?utf-8?B?L0RJTE8rdXlZZFJ3VmJIaCtINzJrR2U2L09IdU5La21mYTg2dEFudlA2SCtT?=
 =?utf-8?B?M2grSXYxaFQyVHpIRzUvRVJHeVo5blBoUmwzNU9YVmdpK0pHdTZhNEFWUHRw?=
 =?utf-8?B?TVhVUGtzalRmaE5zaTVuQW5xbzFub2J5UkVzcXM4Smk5Y0F1MngvYVRUY0cz?=
 =?utf-8?B?MEd5V05zams3blE5Y0haVUw0WG1Qdy9mUGxkV0RNQ2ttTnNuZTcrRVpMNm1F?=
 =?utf-8?B?WTlDYzVzYzQreXlYeS9HTWNCbGF2L0NFOVhQNjFaeC9FT1dzdWNaVHd3OXZu?=
 =?utf-8?B?MENtcVZTQjBTSlo5bGgxekFDNVhmUmpQSG4ySjlBNlNJQ1R3OExnbVJMTnZP?=
 =?utf-8?B?NEt3azk4bnF5MmZQTWtsNS9uWjFPQWRCcjRHczFTNGNvb200MGtuTXBPUFBs?=
 =?utf-8?B?a3RXRWVsVisvN2xFbXFpbnhVUGJ3cXNMTUltbUkvTWFZUS9XbFUwQjNZT0cr?=
 =?utf-8?B?Z2NWak5kZHdUSlpkaGhYWlAra1NhaFlqVkVOSDk2akQxWFRvTmwxanlpcVpM?=
 =?utf-8?B?bXREbEVPN2NydVNyekxSR2RoSFRXMzJ2d3lENmlKV3VNOFoyM1FkNGlLeWFF?=
 =?utf-8?B?cVQxdlhIZ2lkYUhmYXBrYXBnb3ZWWC9SeGpEZmJCcFpuRHpXTXFSWUR3SWpI?=
 =?utf-8?B?d2hnM1hMZGhsM1ZOejhGME1raDN1bjVhNFBKcllFbDR2L1pFcjRjbXY5aGNP?=
 =?utf-8?B?Z0FOOURGTUhKZlc0cnpvT0Joa3dOUXMrcmtNTkpZU1Yxa3pMQ092TWp4VDd5?=
 =?utf-8?B?Y2tLMGdXLzNzTWpJekhiT1F1L3RJVGtiWUptSGZjMmxZNkN1Q3N1QlRmbHBk?=
 =?utf-8?B?OUlOMHczM2JKS21pZFBSTGJzYXNBSFVXWTlMN0tnWngwcGt1Sm1FbUgvT0Zp?=
 =?utf-8?B?ZUlkeUU5OXA3bDZmVFdicWpXb21SN3dLSjUzSWFWUkhRb3BSd0ZpZmVUNVdt?=
 =?utf-8?B?elovUjhSMk03bG5pUDNLUWJReDBwK1I1bnM4UXA0OGxobVdXaEdWMjcvTmdV?=
 =?utf-8?B?MHBtLzFLV05MNlYyUjcrWFVXOStsTlNiNDM5Q1JWeVY2VjBaa3VwU1p2Q2lY?=
 =?utf-8?B?L2E5TC8xaUprTE9ubjNvZUh6a2NOTTZVanhTaU90K2VCbFN0VWZPR1NtSmda?=
 =?utf-8?B?a3o5MDBKOE5mWm9PMmw2eGxvNExlZWN1ay9LSlZlRElabGlsNmQzWlVnUlZC?=
 =?utf-8?B?T09SQ0hVRDZVbUszR0V5ZkZDOHFUNTNnOTRYc0g4MXhhOVg5WWRTK2FFWXhD?=
 =?utf-8?B?ZWdrSUtlRTE4MEpNNU92TUpzSWlzcjVTanAzV1N4YkVxQmdQNXc0UGZwNUpC?=
 =?utf-8?Q?+Np87WDIuH2XQjZ66v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fac12fb-5483-4ede-7608-08dee30ca40e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 07:34:16.6004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3oBB8HlQb+9rLIeDQS2c44/1+QM8EeHMsBgP2Tvr6H7VuPyXrJETNYM40MsUEhSd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999165
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

Hi Anirudh,

On 7/16/26 04:08, Anirudh Srinivasan wrote:
> Hi Christian,
> 
> On Wed, Jul 15, 2026 at 4:15 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 7/14/26 18:03, Anirudh Srinivasan wrote:
>>> radeon fails to probe on platforms that have all their memory above the
>>> 32-bit range with an -ENOMEM because dummy_page_init calls
>>> alloc_page(GFP_DMA32), which would fail.
>>
>> Unfortunately I clearly have to reject this.
>>
>> The DMA32 allocation is mandatory for radeon to work correctly on some platforms.
>>
>>> Allow this driver to work on such platforms by falling back to
>>> ZONE_NORMAL regions. dma_map_page called subsequently would catch any
>>> issues with the device being unable to DMA into the mapped page.
>>
>> No, it doesn't.
>>
>> It's just your special case that dma_map_page() is able to use some IOMMU to remap the page below 32bits so that the driver can access it.
>>
>> The problem is that we have quite a bunch of cases where this doesn't work correctly and eventually result in all kinds of trouble, including random memory corruptions.
>>
>> In those cases it's better to not load the driver at all than to later deal with corrupted data.
> 
> So this platform has an IOMMU, but it isn't enabled in the upstream
> kernel at the moment. I am able to boot up to framebuffer console.

That is not even remotely enough to actually test the driver.

What happens is that you allocation succeeds, but you simply doesn't exercise the functionality which would need the dummy page.

> Is there anything that isn't expected to work in this setup? Is there
> some test I can run to verify this?

For the technical background, the dummy page is there to prevent buggy applications/driver code to crash the system.

The general idea is that a reads/writes which otherwise would go into nirvana are redirected to the dummy page and so prevented from harming the system as a whole.

The problem is that while some HW generations can handle 40bit of PCI addresses the dummy page register is only 32bit wide in some cases (I would need to double check your specific HW generation, maybe that would help).

To actually make sure everything works as expected you need to enable some desktop system and run OpenGL tests. If then an error occurs and IOMMU confirms that the right address is used for the dummy write then we could be save that this actually works.

> I should look into whether the IOMMU on this cihp can be enabled and
> then try this out too.

Well enabling IOMMU could eventually help, but the code in the current form would still fail. You need to use something like dma_alloc_coherent() and I think that this won't work because of the HW restrictions.

>>
>> What could be possible is to add a special quirk for your platform to not allocate the dummy page as DMA32 in the first place.
> 
> So some kind of a whitelisted set of PCIE vendor/ID combos (with
> working IOMMUS?) where we fallback to non DMA32 ranges?

No, what you are testing here is basically that display is functional and not anything else.

Regards,
Christian.

> 
> Regards
> Anirudh Srinivasan

