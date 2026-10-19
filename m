Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBA6CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 08:48:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BED110E0B1;
	Mon, 19 Oct 2026 08:48:40 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C41E010E0B1;
 Mon, 19 Oct 2026 08:48:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewni72/a1D9nNq+UCEcN0rMtfEZZeET1BCOCA7ETruT2w6UNpVwxYAIJT9+lxOu2CC9ja3Wre9uYUdq9SI9hX8PkzYzzfI8HRGt1DY/9b5iM6UtEvEWZlBgPCJLzG/j55e0zLzWMLZxneTNotJKschG3ff96UvuFYQP2t90Uczg6dJmaT1yCYQlYRaa1f+CjtQTyb5Y0olnXgABqMee7+l+DU8rdJesnTcnPT28okwnOetiY2XfuWNKgToobg7goWRt6G+GNZtXNkF7ukfFncplv4QEYp5RgtgYgi9bYkORHr3e8mBLrnzHd0JeVsRU6ihFRiTPdjW87HboZFUhn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M60A7iMZbc9qnqJK9RCpJAehgbykrLh8EW+f5UWXAnY=;
 b=ceZzGR4aD+8zyBNPPOotNOhOjeZvRjhfWZevNrEdas7nafN+FhODqCeIHBEzK8wGJOsJ3bE1h5d9fbVm8BM6L6mViHD7ArirPtoS+fL/Nnh4ccaSIbbiopL36u+vE2RXq2oINT7CTwvaxbvwiRTgadO63qSxJcmWNmKk0D2ZeNBE+ll1nCNtE4F7mBWrHQTwYPSnRXbI1z0d+Qiv9HJvyb2zdKOVN2rPlN8wV801v56/6z7f8glR8V9ENYBlw+j/rFNHdRKBeuBecRuUB6xQcqy2f0e4sy5KYmcsdaFVqqH834CKMhLl7JDePqX8UkkBe2GjPyJ+snN067HK5TSYsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M60A7iMZbc9qnqJK9RCpJAehgbykrLh8EW+f5UWXAnY=;
 b=x3RbJjxdD1/0KDeAYG6mdmwBEof8mDQYTkgldLpDyk4pax8E5HBrUy+b5bbyW30ef1A5UoBGtsPkOs/fogbIa3MX7Ic5GF5PrVEuu5rEsTZKRAupN/Ix0gBAYmEX6LhODh8feRZv+SyBJHVRLjSKONmv7IHCxySgMnQG4vztK7I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8924.namprd12.prod.outlook.com (2603:10b6:930:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Mon, 19 Oct
 2026 08:48:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 08:48:30 +0000
Message-ID: <c0a9c733-5910-400d-8db6-3fc25986dd02@amd.com>
Date: Mon, 19 Oct 2026 10:48:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] drm: reject empty TTM range manager sizes
To: Jiale Yao <yaojiale02@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Zack Rusin
 <zack.rusin@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ben Skeggs <bskeggs@redhat.com>,
 David Rheinsberg <david@readahead.eu>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
References: <20261019084138.1821477-1-yaojiale02@163.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261019084138.1821477-1-yaojiale02@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: fcdde232-78a6-4c03-a2c4-08df2dbdc02d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|921020|56012099006|11063799006|261009223027099003|261009221227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: oXjhhGgmw+3jA0KBphD58k8cHsuU16KdevJDn5hPmENT+u7fzvHenHKdfWUWJVMLmA5oWjm1L8xWbwnUm2pVcP0wpRzvQbkbfOrZ571Q6ePG2lBajIXWxMCBidRCapTYuToKwrnybwvowzGuXXs/NkpYSwLWHqcpyL/SKANfuyU2aSRsvPUTXvVw96R79k+f0KykZD4s1SLOzPxw5YY8oSq9nwASXRo/pDauH7H8t5xxeitrB2WLzIDmhuZby+BcymlWLQVcsmlh7JWXJViffc8nfsE87pneO5LMmMFTpt1JvZib4I4EqrlSg9cgIINth9ANEPY/XJHZSZdwz5mrI3eF9JrUZBA2LJ9TUYes2GAHvCKxXUrvrP5FWPvv0ecLT5I/shqut/l8+1sSRvz7vFWRaO+APT8SWEahmkq/F5rSYlyWuYkz/OEtyOIHCj73q4N/5FUVBMkTpny2+w8WxCXFfVDgR4HOMz/pJv3Znp0yHbb4pnXboLkWgoNB+a+q1OWHiOYqxGZyxjT0tC7lW1TnTC63WwU+jP30LGuWYyoSKqgWUdo1ZAvpxjO/xjiAyQ3oZpuitoPWt/T0t6ped7f/0aJGIpuxIqN2a0Gmnsf2EkTXOXnUw2yJKTMPpm6dPv1E3X6XyETe59QnYJgqUCoXCLsCk7OJr2mqCOgC2+LcnW6/h+ZKANYDA/54XMQaPUUF1USQfjmAhoQE0n9r+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(921020)(56012099006)(11063799006)(261009223027099003)(261009221227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFFMZ09WbkttcEsrZU1ZV3FDWklQaTNpclRSa0taWGNGMjNGR0JsTG9YUXFm?=
 =?utf-8?B?UERuMmlSU1RLajl2QUxmRTlkcnZWRytxQ3pBZFhUSUI3eERvMStRd25rZ2Vt?=
 =?utf-8?B?TUN1cGg0U2JCejRCeVNIQUhUQlBwZnBRVEVYMlQvOG0vYUgzeERUM0hNa2lz?=
 =?utf-8?B?VEJzQ010T3Z4R29wK3JpRmErM0kxa2tOVEwxMS9NSTZCY3pnVTcvdDRzcEsx?=
 =?utf-8?B?NUFBTzJGWjl5SXI3WmpGT1ZXRTRZUG9vK3M1cWF0UStma21JcG5GYnJud2V4?=
 =?utf-8?B?Y3Z5TFlzcDY5ajQ2ejZrbDZIb210Si81a1paTWtIUHlPTy9vZU8xZDAzUmQz?=
 =?utf-8?B?OWNXdHlSZVAweDdaaVBVTERYbWV4YzFyZTh5TW9OUnhLZEJqbE8xdGtJZUd4?=
 =?utf-8?B?SitoMW9WZjRPeEZUZTBFc29qT09FSUIzMmt4VzEvd01oWXVIVndxd1gxNk1G?=
 =?utf-8?B?U3lCSkpOaTRkaUdCOTZVZGEyVW5GUHJEa1FOTEgwKy9rU0dOVmVNdjFHRHdu?=
 =?utf-8?B?djY5UitnKzZoTGpGWUhnajdnZGQ4SWFZaTFudHFwMWtrRU9rNk04dkVleE5R?=
 =?utf-8?B?N3pZOERpTlhkK1lLR0ROOSt6S3NhcDRqUmRNcmgwMktjc3VoT25PbGVKOERG?=
 =?utf-8?B?eEc5OGtOa2lzYlRyVDdDUkdsL09EMWdXbjFSMVZKREZNSXlXZ1U4Y1JHcnJy?=
 =?utf-8?B?aDNOcDJKSUVkdm9QeFRZWjJMZk1vTmlZSmluUmdLSGtZM3BRczllTi9yRUVi?=
 =?utf-8?B?eHlORzZyRTBSRDYvclkwdmYwRDVOeWEzS1VlbnJab1hrMmcwM3Y3QmZMcTc4?=
 =?utf-8?B?WlczaTAwb01WaEVvRzd3TUFWUnZBdlhJa3pwQmVpTWt2WmtqQXZmZnA1dHhP?=
 =?utf-8?B?TzJUUS9HaUR2M2tQaXZSU2U5SUpKcENBQkxxL3M3aEdOTm5MeForSnY4M1J6?=
 =?utf-8?B?c3cyQTlxRlBXbENhSjRiYUZDMTloaGlLbjQyeFhjeVNMenAvWGlXODFMZk5k?=
 =?utf-8?B?Qmt2Nk1uQVJCOFpWc2d5Unh0SHcrdEJKU2VXKzhrYlJmR0p5RVRVcnZjUFRH?=
 =?utf-8?B?amlNMmtxRDM4V2llL2tPT0QvVXZPR0FhNEN4cm83Y0FvaHVzSFNvOWQzSTlw?=
 =?utf-8?B?a0txbS8vRnRYRGNyaXMzcHgyR2FOM01XNkZWNTdSWERjTi9mL1BKcWxFc25Z?=
 =?utf-8?B?WkxnS0VpOVZRMmxNWXNhd0taRytTUmNQOGR1L2tQajVvYk9kb1dkcS9DOVIx?=
 =?utf-8?B?MTVvSFFYMWora01zN2FHdWtaL1R5WDhmR3I5NlpqRUF6REhoN0FRdytGMjdG?=
 =?utf-8?B?K2FJSjFVZzBJTCtqL1BlaUM0aFZBcS9leUJuOUZXanZoN3RzWVZDMXN1ZDZT?=
 =?utf-8?B?NFR4WFc4b2lHUDhucG1HZkFjNytHRGh3L081WVlHOGdMVW5ZaXVVeldqcTl6?=
 =?utf-8?B?NTJlOG56UEdnZFJoQlhQbUtiZjRhbDRVeWY3bUpEMXF2RXVUWVg0VmJ6NllL?=
 =?utf-8?B?RXdhS2JneHJNMklXeS9Od1d2YVQxbjF5czFvM1JiY0ZKbmhWU3V0b3dHU1Uv?=
 =?utf-8?B?dFVoTlMwU3o5NnlCRVJqTVkwN3RzTC85aWFzUExEZk04bFY0RDE0a2RodmVW?=
 =?utf-8?B?bFNPaCtlVlNJdHQzb1ZYTG9XU3RGSWtJVG1wME1tZklKaFpCaVVnRW0xanlJ?=
 =?utf-8?B?Q2d2UHloK0FITTdQUVFCcEJuazhpK04vdDh3QlJmZ2xmOWh5OTJpcytaRmFy?=
 =?utf-8?B?Nm04V3c1SDdEcmJrN2tzZzhCSUtLbEw4WW8yeTFZRGd5V2JYL2JGeU1nanFk?=
 =?utf-8?B?YVZ5My9UR3ZyWU5waVMyc2hmVVBvMThKaUx2bkpzNEx0WDdGelNleDNWYTE2?=
 =?utf-8?B?MitmQWREa2hYQ1pvVFFveERPZys0bGtSYlhvWlhIYjQ5UjRSNXA1RWduMU1Z?=
 =?utf-8?B?UkZ1aWcwZ2RKaTUzYm1ONCtFbm5mbnI4YnRqVDZDVVJhVkN5cUJOWDFLYUx2?=
 =?utf-8?B?Z0IrdUhFc3VRWjBBU0tOd3I1NGN3MHVHTjNGT1ZFN3JQOXpqSFNybnNobVFM?=
 =?utf-8?B?VWVYOUJveitwNURWTUZQTUxsRnI1Q3lWWmYrcWJrTjRRbGhPRUl0N0ZTRFdV?=
 =?utf-8?B?SGpVblFUM2taWXpCem1PVEgzNFpkWGVUQi9NSkkxTy80ZUhEa3BJemx1Z0dB?=
 =?utf-8?B?RWI5WTZWUkV2ZktRcFdlVlp5dHVybGVmVnZsTFAyWE1OdHZLSXRrdGx0dmYv?=
 =?utf-8?B?MTQyZ2VveFpBVU0vZWVsMm0wUkhZOGhMMWNxdHZxenBmSWxVS0dXMFhDQmVH?=
 =?utf-8?Q?jxgQGuMbm0spLLrXhI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcdde232-78a6-4c03-a2c4-08df2dbdc02d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:48:30.7349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3sX0oX476f/4ZxfTtw5tBLfyXLaGfgrXT1aldZn4r24Ncz7GlqWgXrw4OplMX17
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8924
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

On 10/19/26 10:41, Jiale Yao wrote:
> drm_mm_init() rejects a zero-length allocation range with a BUG check.
> Several DRM TTM users can derive a zero page count from device-provided
> VRAM metadata and pass it to the range manager.

The BUG check is there to point out driver bugs which try to initialize a VRAM manager while no VRAM is installed.

That is intended behavior and returning an error instead of running into a BUG() makes that intended behavior go away and eventually cause more problems down the road.

So absolutely clear NAK to that.

Regards,
Christian.

> 
> This series rejects empty ranges at the affected callers and adds a
> defensive check in the common range manager. Patches 1 through 4 and
> 6 validate the individual driver inputs. Patch 5 protects the shared
> range-manager API against any remaining zero-page caller.
> 
> The series was checked with scripts/checkpatch.pl for every code patch.
> 
> Jiale Yao (6):
>   drm/vram-helper: reject empty VRAM ranges
>   drm/nouveau: reject empty VRAM ranges
>   drm/qxl: reject empty TTM memory ranges
>   drm/radeon: reject empty VRAM ranges
>   drm/ttm: reject empty range manager sizes
>   drm/vmwgfx: reject empty VRAM ranges
> 
>  drivers/gpu/drm/drm_gem_vram_helper.c   | 3 +++
>  drivers/gpu/drm/nouveau/nouveau_ttm.c   | 3 +++
>  drivers/gpu/drm/qxl/qxl_ttm.c           | 3 +++
>  drivers/gpu/drm/radeon/radeon_ttm.c     | 3 +++
>  drivers/gpu/drm/ttm/ttm_range_manager.c | 3 +++
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     | 4 ++++
>  6 files changed, 19 insertions(+)
> 

