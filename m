Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97631093190
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 08:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27B1D10EA98;
	Fri, 20 Mar 2026 08:43:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ymgzu0dB";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013032.outbound.protection.outlook.com
 [40.107.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA05B10EA94;
 Fri, 20 Mar 2026 08:43:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qU1b7/ishJECxAq5GxGSP8Y+Q/cFJfkUvXuwcZgXdUw1XFL5sJP+Nd+DHSXzZHh+HvoA2rBI15nqRTzMa3lg1wL3YNtY8LXyWL0mHN7NI/5gZQ+aYzsvWYgmkWVMToBamiqRtN/fPei7ndZzZ4guyYyIj5dAZI8ksB8OhMQSIn9W/KUB9F3/GbNuQ5r7bLvS/Gn2C8u0+7VoEk/8eBc8MmrlLjcX3oxvQKfh/+p33ptUVgyb/+4ap3A3XVa5xnMzwPhxzArTM7Tv+/Lq+9GbZmK19nq2RfEmsjHXNJplGhE3nE9pNWg1PZnXm48Vn76XjavBcYZ5xHMHebs/o70f8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOei0u2At0KnjLo4dO8duy1g1tLxcEjum7a0KNYI+a8=;
 b=Yw8I/RNfkasAjATT0TA4z3+UTo7g/EV3IUsOYrrI40/pFhRzUrdR2F43rOS9cg5eJzIIFRZk1G5bpI5vKJj6Zu2SjwdzZBmigbrRG4Qr2LSwJcJE2RVq0dNBP9dHYkMIZwnaip/GmcFJsZPkteGm+OQIBeBmG7/so5/xiWvzae5497hf8195wSqLP+YPxG6WTabkcsxFL8VY5SJ9KbM9Q6WWBumIQU2DUbNsxPestZ8cRZeEV1xe/R9B5ZQrIM+XxF8gmbEJXOil57bfya7hGaQuEZyFh74hQvPdAOhAAS8Z0aqmWi4H41g3SOTfTYriAsXzTnDalTymwYqnCrzhUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOei0u2At0KnjLo4dO8duy1g1tLxcEjum7a0KNYI+a8=;
 b=Ymgzu0dByVoMB5nd74TiQcPJM5m4QvRZB6wXuDWrcFiOtsUmVXlBUfdv8oO4AMzliGrjbwKWj41ALywZnWhT7Qme51Ff6jdzWJ29vZ+sF0ohWDPbY481Orq5gFn6L9pg8XvIl3fbFSflIN9c9U44N4AxZ4Cr0lt6YpXXBdOQsHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7487.namprd12.prod.outlook.com (2603:10b6:510:1e9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Fri, 20 Mar
 2026 08:42:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 08:42:57 +0000
Message-ID: <09f9a8ce-231e-4bb1-b95f-8dff8060d042@amd.com>
Date: Fri, 20 Mar 2026 09:42:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] drm/ttm: Improve the TTM operation context
 gfp_retry_mayfail behaviour
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, dri-devel@lists.freedesktop.org
References: <20260317141856.237876-1-thomas.hellstrom@linux.intel.com>
 <dbb22727c88887375737f5a837b245ca22bed988.camel@linux.intel.com>
 <237c24790679ebf668bf1d38155ac8888d211028.camel@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <237c24790679ebf668bf1d38155ac8888d211028.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: 07cd02a0-d23c-4641-d339-08de865caf68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 023DaqMckx8o3cnl7ilIKUCH/PZK8GcMABjooiZbBSDWxkDU8strdYOaubpLimj8oYU23C9OEvEUy3iSF3RTXBHBHCCfsOZph8AKUr4CI/bh7up+FlLded+wfVCvRgVWe1h0W/4MSji838Z1z44gbwkY2s91yy3OsyRa67Ax9Q0pJQLwyFr4erSnIlGlnGfu69a5PYjSyGPm1lDjIgW5gyFSRO+8r33JNNlLhovXdBsiKhnH0JUAF8cujoifvc2cwQhcx0YuHkqPrJkW1Hjk3wNasm1pv2s/6ACv3icphX3Y//vh3vw2Gv2PnnbwD6yjS5pg9I61XQXHrzLVJZ/TD9gdwek/4RtdxAYa/MXGDBLyf3JZ3LZkpl9vx6mpccmM/9/IGBRBFJS3kwTycney+KSn32GviO6K/iKBqwQhR3qqma8i2CvodRNxZ0lVZfEek6fKTnY7NtZcOltEkGwUOH89Bah1dw0X1WMl65EqJAq65TyMcIkbNUu/KWvAMHVc6zq+HFhxi2Mqe5I47ycgeXjIZMJ1xCWLNo0KwT9q5LN3PzzQAgG6R7fndsdO7FET9J8aXzeeradFxpCkDzBfBbJ5zKcxXfSqqCCva/49rC2/wBDFD8p+wgQWp2M09lxg0foVBD177XhQqswWa2ZT98M3fziyGovQy/EYTISHxlRIjIfWP9k2OIoNYamNQhlaHcHA27Zcypv48zyV1lhpAHlszSNjJnOrMVSWWlbUD1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEcxUlVoV1oxWnpPZXVKcVNzNllRRHBEZUZGNVUveGZoYWhPdm4xaElrcklv?=
 =?utf-8?B?cFZyMkxuZXVMUUg3TDFMYjNieUtMbmMxWDVXaFlZK3lyZFZHTUtTYnJuN2o4?=
 =?utf-8?B?aUZKUGN4MnNrNE1HVGhNcGJyTGJyUVMybThhOHBYOWFUSG8wZFNkQ3d6Q01a?=
 =?utf-8?B?QWVBL1VJd1RkQkNKZ0hKTU5iVGplQlRGcE1iRTRzTTNDREJtVituTzlPNUUr?=
 =?utf-8?B?MkhnN1d1cHYxMFU1V0hOSjExeHMvWkFsZG54QmlzZkIvK2hyMTcvbzlLd3U1?=
 =?utf-8?B?cUV5UWN5OEpWQ2RIU3RMK25weklwMnZWUC90dFJUMUc4OTJZM1c1bFN6Ly8v?=
 =?utf-8?B?YnJVVzlnOXpNWVRXOU5zYkpseW81R1FrUFdYc3krc1JlRStvTXJuT3V1NHk1?=
 =?utf-8?B?bWxtUFRjNktBWTBEbFpaTUpMaE51Z2I4dFBGNktWREtPT2s1alhHbzZNNEZa?=
 =?utf-8?B?NjZrWEd6MTdsZE51ellacjVVRitaS0YvbUlEVzkrVkNtTXEzNmJqOHpMUWo1?=
 =?utf-8?B?YjNoV0VFQXlJTEN0dWg1QWp4ZnBpL3pBRkRHYTFBaHlldTRrRTUrdkM4SjJK?=
 =?utf-8?B?aGszVC9YQnRoMG5EU2VubGh4OEZVNXRObjBOZUF3R3Q4UlFpSTIyaTM2emFS?=
 =?utf-8?B?WXdkM0FSSE1xOUE0QU1iNEh0REIxMjBwMVJ4UUFZS25xdXdiRkNvei8zSkJL?=
 =?utf-8?B?QnlHQ1hES3VWS08zaW91VTRSU0tzWnFxKzAveHRDeWcxVjhpcm9iQXAvZlpi?=
 =?utf-8?B?SVFDdWVuU21IV0ovZXpRU1dkRG5HOTgxSFYrdkFuU1ZqcGkwRXR5bk9SQjIx?=
 =?utf-8?B?QXhvcTZ1eEZQOTdiSWpJUUZhTlRwcHVySWw4OWJTTmhHeHdlUHh4R2dmV3ND?=
 =?utf-8?B?MWsxWkF0b3ZrT3psQXdpRE43MjgzKy82QUE0UTZPQ1J4YzVyRW10S1dGTkdL?=
 =?utf-8?B?SmxVOEQwU2VhbWxWUEV1bWh1MC9QUStoZGpaT1lMYzJhc21HZmdOTjBkMERa?=
 =?utf-8?B?cWJOd3VRbDQxL0tENThIZFkraG5leHFQeTRPaDBXS3R2VXdCZks1MnJKazFj?=
 =?utf-8?B?SUViWUZuUGlzelh6NExQMHV5cFRLeWpUeFcvYTVnYmlrVlBkUHRRRUFienZ3?=
 =?utf-8?B?SUNYSmlkNE13MFZJRlJIM0NsTjczMjNKZTZHOUFRdnprbktUR1hobzJhNGc2?=
 =?utf-8?B?NVNLaDV5RnJoL3dWaUsvN3p4WURxLzR0L1h0TktRSUtGbWplVzA4bGQzU1hX?=
 =?utf-8?B?OUx2QUt0Y0RKZDEvRVVtVFI4dGNuR1p3VVhLWUVKVU54TThjMCtuTnhMTmxz?=
 =?utf-8?B?aThwWGZCbnk0R2swZG9rN2FUOG1VL1hzYkRyTmVQdWxnenJFQSsxZVVRVkU2?=
 =?utf-8?B?U01iS1ZCY3pSdjVoQk1hWHBMbEhqVE1ET3lqakVMbFhUS3gzbDZXY0NoU2hi?=
 =?utf-8?B?N2Rjb0pKdllKU2NabDFzcGRKeUp4RTE4NmtiNmUvKzhTelgreGFoTkVGL2N3?=
 =?utf-8?B?U0RveHVlQ3U4L1RqamRPMFFyTzBKTzJWdGQwcUtLWTZCZDFQOGRWaXZqVnR6?=
 =?utf-8?B?L0wxd3BxQlRONkxiY0MvZkRTSllZYUVOTVd1dGVuNkh4dmJmT3JGaXk0WHd1?=
 =?utf-8?B?czBDRjArZnB2c2k2RVl1cE9iZ3p3Mk0wd2tFSStGUWZCb1BObE56UVVnbkZa?=
 =?utf-8?B?K3k2WlF5NzFKeUpmaEdXS2lRRnBEZWNWWlhpSGZudmdPQ2ZiVU15VXhiZGxh?=
 =?utf-8?B?elloYm9EYlZreUpZQjd2am1vaUlZYVZNMm50enRVTVpTQ1NtbkFTZlMzVU5w?=
 =?utf-8?B?NmZHVW9aaW45L3NmbkpTL2tsaXRqOW1QaHNKLzhha2ZLKzNaWXVwK3lyNVFT?=
 =?utf-8?B?MVE3YmYwQWpzbjhtdXljWWp2WVlKZTZRb3BkN0FQcTE3NGdBUUQ4bWF4a1Fx?=
 =?utf-8?B?aG92Z00yQXBVYy9mU3FmR0FHK0thN2xOSnVPNEJRRjNkeFJhM2dKa2xQTXYy?=
 =?utf-8?B?TCtRN2piYm5IUWI0WkVtSENWZFJnQlhoV1U3Q0hJM09SV01WWnQzb3pkT0Jm?=
 =?utf-8?B?eExHWWZDWWxZN04wbTQ3VmNGcDhwb0ZRVmlMUzBRT1AwWVE5VVNGcHVkM2Jw?=
 =?utf-8?B?Vi9FVEdvMkZlV1UvN245SjFTR2pZZ3RJSUk5aHA4b0pDczhDVGI1MGorRjBt?=
 =?utf-8?B?RGlncWtOc2twRUFVMlFFdHBBZUVQbThzelRXUko2RmN0UFU5emI5Z0ZzYTdi?=
 =?utf-8?B?RGdnMXl6T0grTXhIbkM0T0dXaysvczIwTjg3WVJvVFNVdm5seTllR0RZd1h3?=
 =?utf-8?Q?hHwj+F0jNyInj9kml/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cd02a0-d23c-4641-d339-08de865caf68
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 08:42:57.4709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUvcIzwf+KVUM83JB6TodugJzaoonpaB8He+7lrBMh+5+dVv3Hum5hgLkmFbvr5M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7487
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

Sorry for the delay. Feel free to add my Acked-by.

Regards,
Christian.

On 3/19/26 20:30, Thomas Hellström wrote:
> Hi!
> 
> Since Sima was OK with this series and I believe the changes are
> completely non-controversial, I'll go ahead and merge this tomorrow
> through drm-misc-next.
> 
> Thanks,
> Thomas
> 
> 
> On Wed, 2026-03-18 at 15:50 +0100, Thomas Hellström wrote:
>> @Christian, Ack to merge these?
>>
>> Thanks,
>> Thomas
>>
>>
>> On Tue, 2026-03-17 at 15:18 +0100, Thomas Hellström wrote:
>>> Two small patches around the gfp_retry_mayfail behaviour, and
>>> one patch to improve associated kerneldoc.
>>>
>>> Patch 1 ensures we don't spam the kernel log on allocation
>>> failures.
>>>
>>> Patch 2 extends the gfp_retry_mayfail to swap readback.
>>>
>>> Patch 3 Improves on the associated kerneldocs.
>>>
>>> v2:
>>> - Add patch 3. (Sima).
>>>
>>> Thomas Hellström (3):
>>>   drm/ttm: Don't spam the log on buffer object backing store
>>> allocation
>>>     failure
>>>   drm/ttm: Avoid invoking the OOM killer when reading back swapped
>>>     content
>>>   drm/ttm: Update the struct ttm_operation_ctx kerneldoc
>>>
>>>  drivers/gpu/drm/ttm/ttm_backup.c |  6 ++++--
>>>  drivers/gpu/drm/ttm/ttm_pool.c   |  7 +++++--
>>>  include/drm/ttm/ttm_backup.h     |  2 +-
>>>  include/drm/ttm/ttm_bo.h         | 28 +++++++++++++++++++---------
>>>  4 files changed, 29 insertions(+), 14 deletions(-)

