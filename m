Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E93C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 09:30:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E481A10F9A9;
	Fri, 25 Sep 2026 09:30:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BEy6u7ad";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010068.outbound.protection.outlook.com [52.101.201.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D95C10F9A7;
 Fri, 25 Sep 2026 09:30:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+nExUlmc6xeC2P6sAB2x88m1RoV/yTr4jpwPrSqbGaGYns6nUQK7nYgC4CmxxhUmNV5Z90Z9eSY13n1UU5b4epHJTJTWoY0nq1VHBTzjbyJESdtUZ/ZfQxf1pkp8u/dLTz0vRMHRJ7COrLDrCDURpB0Mthd6cLTSjcAKNxCxZjLlcY10qu8SVQKw0kG5wjzUC97RtCBRWLG0SWKe3VZkeGgeVMQ5MCfBKP33FLvSTNpPm0GA5+Wn9U7OBspiNkAwG7quYlLdg6+DO5lF6rhMfz5tvmiQKR9YCjPRJ/Gs9VWV7oHWvTLs8LFVXFZ/l16d9FXOmXT3mWrH5kM++zfPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGhUuvEaLirxZAJJ14sCb5kwyMTc6dzNrH5Vp6SX7rM=;
 b=D73UVud7lDMC6sNxpXNPzTRO2SmsffnahF/xopwfrydogvIBKyVzbONYOosoM73+yUHT0zw822dE/MMmsYcJIWKPQxv95lGHHezOeVBQ54bLLolLUegtCx/Fw+dfI8eTpzfvIoyfyH9Oqo+QglhOhmZaaLKDbUs7xpusX3O+pWM5p4/WDHuz3gWixBzXwB3jfe3bNVMnZ6l8MlDAOqB2dsmpIlfp50Ug1pAyB2YiMYzXo1SVbGDOAT2iKWa9/a8Ym68eCokscCw7Ot0//nvdlhFxUEYfh6yJHY07mqFgog9XJ53N0ROnUKNPge6F6v1ABo4nbVAFWC/GEJvVepbfpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGhUuvEaLirxZAJJ14sCb5kwyMTc6dzNrH5Vp6SX7rM=;
 b=BEy6u7add5fWKk/klvpZZEcFU20DKi+K2MX6rjB6uH+5hPUCRQrIhVn7h3pQD8S7OKK+0mCo1B3KM/IfA9gGpk8z210lkIclTxmWbNZ3R8iOB4CmqDayATMU+ZyspXCSu0wAAPOb5VI3Fb/GmztoW0099IOHrjkB3ezcaphe9Vw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB626779.namprd12.prod.outlook.com (2603:10b6:806:590::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 09:30:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 09:30:34 +0000
Message-ID: <1ddc407c-5644-40d1-a3e6-14058f8be701@amd.com>
Date: Fri, 25 Sep 2026 11:30:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/ttm: NULL dereference in
 ttm_resource_add_bulk_move after OOM on Navi32
To: =?UTF-8?B?6LWk5bKh5oKg?= <c0a25004a6@edu.teu.ac.jp>,
 dri-devel@lists.freedesktop.org, Natalie Vock <natalie.vock@gmx.de>,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
Cc: amd-gfx@lists.freedesktop.org, bub4z0r@gmail.com,
 thomas.hellstrom@linux.intel.com
References: <CA+Y9VQNZnAKCoCjWtLeA5TS+CLm0rPgsa7YrE8vOPDo4pV-mDQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CA+Y9VQNZnAKCoCjWtLeA5TS+CLm0rPgsa7YrE8vOPDo4pV-mDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB626779:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1f05a2-7415-412e-04fb-08df1ae7a69e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|5023799004|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: iO6+3aprz5Wk7JWnlVMY5Dy125Ygkv1hWvvsyEI7mahUyMLyY4vVyd2S50rGli6zPgXXeH6iGH4bVgUb2lQw1T1xAL7l8GaG7bIelqTRUKCkHxha2PeJW3eaDKODBZGirKYciuIRLeqPudJP5rl6yQWTe/MivM8jMkHuOxNZOcIun+NjirBS9md88D3cCmLuM/s0zLWkrTkEqq9GUcepjkzhk+VleiyqryfV+T3sYFy86NNv91tcGF9gJBKocolPtQadXF5XERT7CB3OEKmqgYRzxdx/nJvNoJO1zvj+kAmjkw5+2jBpIrlBYgc5StOdDaAPbat+3c0ZH2gM7HKfc10CDgWpLkqNU3T1zcdHxqg7UCWKX6gVylKdT8OT1E6xiuhprLUp0QIgzA3HelHrGPMuPT+NrRFGV6UIkkWYXuFGHI7uf+bTQlUEWEO58x8ttq1FO0t7sHwHJ4BjOyYT6KAfxeZhDstJaX7BT6zcKnIshGEcj7QFRenRyPpc/XTX4pWZCOBQN5CoigGE+0KbZmHZ7cAuluTLz+zPChuSEnkWBQoW6L2Jt+Q7bIlhO9jxbDhg6XKju7SjnlMcVok2zNgC6n0lMTSyHeyxUZfWo+dQutcFIQB2e/72qowHEPku
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(5023799004)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjAycFhYSnltMDRvNENoVW9HeWd4Mk55UzJXYWFRdXBYclE0SWJXVytBbk9N?=
 =?utf-8?B?VzZHMVNuZ0lVYnlxY2hEVlFnWWN3RjQ1OWZwWVkrc0dtdTZ1TThJMExXS1p5?=
 =?utf-8?B?MlRJRjNvOUl0Yml5NG1HMWpDZW1zR2FhVzlMZ1ZQTjE4OWdPVnJITnJWd3Fn?=
 =?utf-8?B?Y0lsZ05HdGhTQTNtbXdWU25qb3RpV3AweHhwZytSTWdhOGJ1bnpHQnZ4Y25i?=
 =?utf-8?B?M3lHdi9yN3oxTWRFc3Q2L0RGWFpKUC9rRzZiSG1yNTlmVG03MXd3WlFxUHFn?=
 =?utf-8?B?dFFxc2h4d1hJOG1mZGQzODhwWk0yVnY0bElIUDAxMTBSRlJ0OFJLbE93K0Uv?=
 =?utf-8?B?Zk9VdE12aHhQYWxMcllVNjBPcE8vUGdERUo4OUVLZ2ZTaXJudmZ0TzN0ZG54?=
 =?utf-8?B?RHkrN1F1c2xLVkZLN1ZabnZRNHNESlVHNUkzTGNUdFNYbXIyZHprSElHUSsr?=
 =?utf-8?B?d211eWVXQ0xWWi9vMkFFWGRobWFNNkxwU0d6T05zN1kreGxFWDBLUjJWUzdS?=
 =?utf-8?B?aXNNcmx2MTlLbUhqWUNyK0lIZ2dCdU9RTXQ4NDBERkorVElBS29BS3prMHo4?=
 =?utf-8?B?eTN1Tyt6RFNvQ2kzLzNjcHlHZG9qN1doLzlFa3lsbnRRRi9FV0V3d3B0Slcr?=
 =?utf-8?B?VW1wWWpUZ1JXdUJ6SVRxdG5UYy84U1FQUDVVaWIvcENBeVVnNDRzNVF1R21v?=
 =?utf-8?B?R2NpUXNGaTdrODVwZVJPVDhjWnBMS3hzWWVwdFlYNGNsQ3oxS2V2Ykc2dkZK?=
 =?utf-8?B?SW5RVTgvYnppTVljT3dBMVhsekpSNmdmK2tZOG5ZK0JmNEwxVkxhQjJzTE9F?=
 =?utf-8?B?dlZsOEszN3ZoWWhVR2ZDVmwvSFR1aERHak8vaEt0YnNydGlWUDhxL3FoRkdQ?=
 =?utf-8?B?Qnh0WkIwRXJ2QUNvdlVzczdBYUtMalpBOW5kbGFSU09lQ3pvQWhheHlVT1Nt?=
 =?utf-8?B?bmhKQXArRjNUYkxoYUNDbzdGV3dPQU41UnQ1TnE3MHJtN2NVSHErNjJDYmlp?=
 =?utf-8?B?YXNmRVFjK2lVamJhVzZUQ0Vpblo2cCtLR3E2UjBlT2paSUd0Rm5ycmtDTW1r?=
 =?utf-8?B?UXo0YStpUy8rWGVOTWNBVmsrbG15U0hwVDhncVRWaFBmcW5RRndDNW10eFJs?=
 =?utf-8?B?OVovN3RsRzM5MVk2QmVXMi8wSVRUMEZaVGpRS0cvekw0YURUVncydnRMdEl2?=
 =?utf-8?B?ZzJnRFNCNENPMHRqVFhrcmt4dVkrSGdNZEljTFp5WkV3dzVuTWpuZVAxTXBj?=
 =?utf-8?B?OVFSSXFsaWdsQ2ZoUEJtUENZeTV2RGQ0dnkvK0xJZkNpTUJJbEZGQmRkTTRN?=
 =?utf-8?B?L3NPckcxODl2NkpBcmlua3Jma2p1cjhIZ0ZQS29LYWRjTVA4bTNmQ3ZKUy9m?=
 =?utf-8?B?aWtXYjkxeE5QVWRHZTM5MytQNmU5SENqYnJjbmFUZ1E5MjhIL1R0WGF0dVd5?=
 =?utf-8?B?VDRQYml6b1ZyU3dzTUVIcU1PdFJMUFdYdTNIZFlBcFkwSEZPV3BlUFJiYjU5?=
 =?utf-8?B?elFORHNBTXI4eHhlSFdDb0xuLzhvNU01TU5EeWIwK3p0K0x3Qk9SYVoxQVpj?=
 =?utf-8?B?Y0FsdDkzNGlFM2tFUWRyREtTY0ZWYlFYcW03M2Y0dDlWRjhLSk9BNTc1VFFW?=
 =?utf-8?B?RHlmQndsT1JZQjNhT0xvd0Q2bDlwYWVhbkM2WW1LL2E0T3k1QjcxUnJScmwx?=
 =?utf-8?B?ZXdPY3lpWFVkVEVtR1hOZXlkUmEwMWlpazkyVW94dEJVUHhmd1VNRDRXSWM2?=
 =?utf-8?B?TXBDdmFxWDBKdEZEOVZNTEQ2V2dOOTJYYTJUb3FpZ1kzRk03TDFoUG9MaTZX?=
 =?utf-8?B?blpYQURUS2pmWWRTTTNtaXlNV1dqUHVxQXFjdjc2S1EwZEw1UmdFR2l6dG5S?=
 =?utf-8?B?cHFiejh2SGNZRWx2OXBlcEw3d09BL1VSWmdaSXZJUUNlT2dyNXp3OWZIalFx?=
 =?utf-8?B?d2tzVkJWMCtwNUNNMkhMNkVvZVd0eE1PTVovRGRtUXZCMUNlYlVIMTZYVURp?=
 =?utf-8?B?VjlVdTVFYXcwalphbmpwb3VScm9KSDFiakpSY1Z6dUh4WVJVakY1U0hNM0pC?=
 =?utf-8?B?YUtYYWRPUVlCU3phTHcvS0VXbU5mWjNuVnpHaWdlakdxRFBWWTJXM2dPeDdZ?=
 =?utf-8?B?MUNVRmViVVJKbVR2b0dTcG1zSlE3dmFBakgycTc2ZTAyTHpSelhZYXNVK21h?=
 =?utf-8?B?ZTc2ak5CSDlVSnlDRk9QV3hpOEJtdWNnOTRqTzNrSUdKY1RtNEt3Y2toSTlp?=
 =?utf-8?B?N1NoNWhhK3JTdnI0RFl5UjVOb0MrUDN3RFp3UEZIOTRjOE1GK2RzNXNqRDFW?=
 =?utf-8?Q?MQYTYUXvzA4Irx3eHg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1f05a2-7415-412e-04fb-08df1ae7a69e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 09:30:34.6372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuUiaESQ5UnT55NQu5rN91GOoP1knSrN+PJI3VNtZu8pdkZhK0gWnIknq/gs/Jho
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB626779
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

Adding Natalie and Arun as well for awareness.

Regards,
Christian.

On 9/25/26 11:03, 赤岡悠 wrote:
> 	
> 	
> 
> Hi,
> 
> I hit a kernel Oops in the AMDGPU/TTM swapout path on a Radeon RX 7800 XT. The
> failure happened immediately after a global OOM condition and was followed by an
> RCU stall and a host reset.
> 
> The kernel was `7.2.4-1-cachyos` on CachyOS. The GPU is a Sapphire Navi32 / RX
> 7800 XT (`1002:747e`, subsystem `1da2:475d`). The relevant userspace versions
> were Mesa `26.2.2-2`, KWin/Plasma `6.7.5-1.1`, and libdrm `2.4.134-1.1`.
> 
> The first failure in the affected boot was:
> 
> kswapd0 invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0
> oom-kill: ... global_oom ... task_memcg=<redacted>, task=llama-server
> Out of memory: Killed process <pid> (llama-server)
> 
> amdgpu 0000:03:00.0: [drm] *ERROR* Not enough memory for command submission!
> WARNING: drivers/gpu/drm/ttm/ttm_resource.c:235 at ttm_resource_add_bulk_move+0x124/0x150 [ttm], CPU#15: QSGRenderThread
> /2457
> BUG: kernel NULL pointer dereference, address: 0000000000000008
> Oops: Oops: 0000 [#1] SMP NOPTI
> RIP: ttm_resource_add_bulk_move+0xc9/0x150 [ttm]
> 
> The call chain was:
> 
> ttm_resource_add_bulk_move
> ttm_resource_alloc
> ttm_bo_swapout_cb
> ttm_lru_walk_for_evict
> ttm_bo_swapout
> ttm_global_swapout
> ttm_tt_populate
> ttm_bo_populate
> ttm_bo_vm_fault_reserved
> amdgpu_gem_fault
> 
> After the Oops, an `amdgpu` KFD cleanup worker and an `amdgpu_drm_release`
> path were both blocked on TTM-related spinlocks. The journal does not contain
> `Kernel panic - not syncing`; I am calling this an Oops followed by a lockup or
> reset, not a confirmed formal panic.
> 
> This is consistent with the stale `bulk_move` endpoint bug introduced by
> `b2ed01e7ad3d` ("drm/ttm: Fix ttm_bo_swapout() infinite LRU walk on swapout
> failure", v7.1+): `ttm_tt_swapout()` returns the number of pages swapped on
> success (never zero for a populated ttm), so the
> `ttm_resource_del_bulk_move_unevictable()` /
> `ttm_resource_move_to_lru_tail()` pair under `if (!ret)` is skipped on every
> successful swapout. A swapped-out resource stays inside its BO's bulk_move
> range while unevictable; a later `ttm_resource_free()` /
> `ttm_bo_set_bulk_move()` skips it via the `!ttm_resource_unevictable()`
> guard, leaving a dangling range endpoint. Upstream names
> `ttm_resource_add_bulk_move()` as one of the places that trips over that
> cursor (a use-after-free on the dangling endpoint) — exactly the function
> my NULL dereference hit at `+0xc9`.
> 
> The trigger on my system differs from the hibernation cycles reported in
> https://gitlab.freedesktop.org/drm/amd/-/issues/5387 <https://gitlab.freedesktop.org/drm/amd/-/issues/5387>: here the swapout was
> driven by runtime memory pressure — a global OOM followed by
> `ttm_global_swapout()` reached from `amdgpu_gem_fault()`/`ttm_tt_populate()`.
> If the mechanism is the same, the defect is not suspend-specific; any
> memory-pressure eviction pass can leave the stale endpoint.
> 
> The upstream fix history is worth noting:
> 
> - 3db7d7d <https://github.com/torvalds/linux/commit/3db7d7d583419f7b1f2e141e36418802dbb25cf8 <https://github.com/torvalds/linux/commit/3db7d7d583419f7b1f2e141e36418802dbb25cf8>>
>   was the intended fix, but it was applied to the wrong `if`: it changed
>   `if (ret)` to `if (ret > 0)` after `ttm_resource_try_charge()` in
>   `ttm_bo_alloc_at_place()` (a separate dmem-charge bypass) and left the
>   `if (!ret)` after `ttm_tt_swapout()` untouched. A kernel carrying only
>   `3db7d7d` therefore still has the original bug.
> - fcfe647 <https://github.com/torvalds/linux/commit/fcfe64715b425262af1b36f498f9197f3537ceed <https://github.com/torvalds/linux/commit/fcfe64715b425262af1b36f498f9197f3537ceed>>
>   applies the intended `if (ret > 0)` at the swapout site and restores the
>   charge check (`Cc: stable # v7.1+`).
> 
> I checked the source release used for `linux-cachyos 7.2.4-1`:
> `cachyos-7.2.4-1` <https://github.com/CachyOS/linux/releases/tag/cachyos-7.2.4-1 <https://github.com/CachyOS/linux/releases/tag/cachyos-7.2.4-1>>.
> It still contains:
> 
> ret = ttm_tt_swapout(bdev, tt, swapout_walk->gfp_flags);
> if (!ret) {
>         ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
>         ttm_resource_move_to_lru_tail(bo->resource);
> }
> 
> The installed `ttm.ko` has the matching `test eax,eax` / `jne` branch, so the
> installed binary also has the old zero-only condition. The CachyOS 7.2.4
> PKGBUILD does not list a TTM bulk-move patch. Version check
> (upstream sources):
> 
> - `v6.18.52` does not contain `b2ed01e7ad3d` — it keeps the pre-change
>   structure: the resource is removed from the bulk_move before the
>   swapout and re-added conditionally, so it is not affected.
> - `v7.2.6` and `v7.2.7` still have `if (!ret)` at this site. The host now
>   runs `7.2.6-1-cachyos` (booted) and its installed `ttm.ko` still shows the
>   same code generation.
> - `v7.3-rc4` has the corrected `if (ret > 0)` form.
> 
> The kernel was tainted with `CPU_OUT_OF_SPEC`, `OOT_MODULE`, and
> `UNSIGNED_MODULE`; the Oops also set `WARN` and `DIE`. For completeness:
> the only out-of-tree module was `v4l2loopback` (a DKMS V4L2 loopback
> device) — not in the DRM/TTM path.
> 
> Caveats: I have not boot-tested a fixed kernel on this hardware — no
> native kernel A/B was performed. The evidence above is source-level plus
> disassembly of the installed `ttm.ko`; `drm/amd#5387` has the live
> reproduction data on a different GPU.
> 
> Since `fcfe647` already carries `Cc: stable # v7.1+`, I assume the 7.2.y
> backport is queued — `7.2.7` (latest 7.2.y) still carries the bug. Two
> things this report adds: (a) an independent hit through a non-hibernation
> trigger, on a distribution kernel (CachyOS 7.2.4/7.2.6/7.2.7 all show the
> old condition); (b) a heads-up that trees which picked up `3db7d7d`
> alone are still buggy — its one-line change landed on the wrong `if`, so
> the intended swapout-site fix only exists in `fcfe647` (this
> backport-unit warning is now also on public record via a comment on the
> CachyOS issue). Does the crash signature above match the dangling-cursor
> mechanism?

