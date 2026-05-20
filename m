Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5B6CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 08:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E8A210EB74;
	Wed, 20 May 2026 08:22:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TLdTe5xo";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8896510E419;
 Wed, 20 May 2026 08:22:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQPv3rTWOzxuirybcsBeg8VNdwezxLMvDbb9xCerTYJU9UD3ziBrOh7cGxZVsWHn8/NEc2rYULKAemfplagm5D0LP7lj9+3C04i3T5SxdFNI7mH/fCSuDseiwKKguy4qFZCD1LsqOaJdyMSJVaVBJZEv8I5Eqs9b3Atq3LLvk+O8t0c8rtdteLq3VtqpXm1FKl0gNGvH5pTQOVHG/RHa4EaQN8SgxZcN+8WKw2PFHjMRZbN/tLrc7jC51ES7M5G2Pwwa74vpJHlEjkpPYhIoladMx3GH7fa2xWaHmjuld2rODgN+R/KZMk3pDd9YqqBiVH9Zk7pd0oIH85S7eYi22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ww0/PM/2ttPPfSNJ9uCaeXSLEfRObxOWKRjoQcQklLU=;
 b=hxLJBEvplAIJSdKuDGPUOPvBlrI2aSqAboDlLwpwpnLDnAM08U/M0sfSVYuB2Mi8HgSjFfgstUnFGsOkQZklTGpHU6ScSqM/eoVgFHfzhtdVtSk812YE2UdW710YeX3IxOzhYcH3sCeILy05vRTZvPSxAEhOWZ7WhGmPEBIE6EPprphb80V68ShwpsePwQQfeVdFKWixQw+Ypsw4zh+fIV1fa32TzUAFXUzjpnu/aQwtTBjBkrL+RJvmJq7ZkLmYsZzMiWJd/JBxnTauhbRMh53SVeMTInergl54Nxhjbh4TDs88qUSKOgDZS87MRWZoEAXfqUZlHT+yEXPUkKVo9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ww0/PM/2ttPPfSNJ9uCaeXSLEfRObxOWKRjoQcQklLU=;
 b=TLdTe5xoIFUypuTQ8bBEBqbm+yOewqJ1qW6Gf+Sdgyg2vDop0cdM9D2EzYAJu9rc9FJHZ5O89UZQhA6k+TMUULW5JH6NZFZYXTcXfniXxFgh0LVJnQrEP1j9sjxR2Exrojn7iCe9A4F8ZcnIp8hQ9hdNOOdJQqha0MeMmlDEnxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.24; Wed, 20 May 2026 08:22:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 08:22:51 +0000
Message-ID: <ecab2606-e54b-4d21-93f0-0feaade64e6c@amd.com>
Date: Wed, 20 May 2026 10:22:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: drm/amdgpu: dead empty checks on e->list in ring_mux
 ib_mark_offset and end_ib?
To: Maoyi Xie <maoyixie.tju@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260519194113.2411822-1-maoyixie.tju@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260519194113.2411822-1-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ebdc737-0924-45bc-7b9b-08deb648fbbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799006|22082099003|56012099003|18002099003|5023799004;
X-Microsoft-Antispam-Message-Info: ubsgD/VLr9nEoJYc+T2SOSCHN59Iy6auz7iyBizFjvDZPc/POySPtR3YzN9IvEoO6xiisa/e6hMu8o+5CIQlY1mL/6+S/bEWuzHXa/x/7Lcwcg7LJAzO1CSAH5eoYWJxfwRxMzWBjcinS9BNz7iNGMjPrTmIZb6NBM7772MwtwMVRRfCwUoPxmOvKyrnFFycZqyVZ78i+gocn4fJeOmG2YxpYSs0jqX1bT4Bug18xpGPzBUPCw1MikFyDB5g1tTmYkCCEwXRQirHyOiupUpjdnIg2lmxoyAWN1A3khPHFVfSHnAmfyz0hX8sZYyS9aC0MfuDE+JXvFcki3Np5Ct2mgNP0kvZUmFECuWh0D+KNCFp7slwl9igJ/+DlY/xHzdzBurqUWKsJ2rSjOs16keIbllxL0uFPX/ut1v8ET3jgi5j0VlKWzAAbqV+SX+Qm50NLNkxlDhIVPhhtTsQduunLuhTuXIBPj4y494jn9vq6oHJNRHeFLY074Lnd05vNQzJBEHCdW1I7nl+kccJwRiI+EfWiPYNCMVS7Q0aSc6Rr15YPxdZcTADIJsRsUbMPW3qfwaCVesZ6XIIzuSbBT4dW6klVALyUnsGHBE4dMGC65E3B4crvLmeO+ECrw1QDLlRkT9Qsii4ArfRkLEipsGqVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799006)(22082099003)(56012099003)(18002099003)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUQ1c2xvSzNTWksvUVhadEZEeFBaWDZaeTZZb0FLbEp1d1IvR0hQdlhQODRX?=
 =?utf-8?B?WlhlVDdxc2hqQnlKOFVaQjBoQXVCR3d0aU5BREQ0VWhvUm1xL3RSZ0crTmox?=
 =?utf-8?B?VVJrdDUxRjNja0x6Nkh0a1F2WHZubzhaSTI2LzVLS1RaSldLUDJiYW1xdzAy?=
 =?utf-8?B?UlVBSkFJdzNocUsrOGNZMHc4UWZyeFVvckc1dzlpQ1NDSmFGSnNPRFVHdkpV?=
 =?utf-8?B?bXF4MVZWNEt6UEptQVZwZ3d2dHBhZGNENkRJNUMwL2YvVlU3RVRLWDhsdXBt?=
 =?utf-8?B?NnJqV25kMVRieklMdG9WenhFRklUeFYwL3FaVkVoM3d2Q3VvbjdnQ2tTVFB5?=
 =?utf-8?B?bnduRlFGUkMyRElXaVBWSnVyT3RURHlWU2RpZmt5RWh5NFBMMi9tUUZ6d1Vo?=
 =?utf-8?B?N2Zyc3JrUU9IOVBQVHhQam9RZnl3TDRFdjF0bVhUeG9IdTFHQU14RVBRVjhD?=
 =?utf-8?B?L0F1OEEvbnNZNko4UjFuSlN6a3JLUCt6NzhxaVg3S28xaU5mT2QwNmlobDc1?=
 =?utf-8?B?elRCWHQxNXN4QTFaOWRiUkFGelRnSGpUTXFScWlEbmtDTDRGZTBjaGxtMXcx?=
 =?utf-8?B?WnFVUDFlM3hGdkRnVm1qa3NrUjB3TTRIYkR1OXowT2JtTUxLYXpjSHR5bXdy?=
 =?utf-8?B?VERERDVvTHZkWSs4NUhtM3pRZDlSVmlhV25TU2RacUYrUzRjSnczNGxTMU9t?=
 =?utf-8?B?OXc0akFoNjlid2RXK0pjdFNQQWZQV3lhYzNkb1ppSUVpWkNtUWNmRk9hYmVm?=
 =?utf-8?B?TDk1NEQ5T3FFbm9BUXNZcXFVOS83RTQ4QUtzQWpzUmw3MTFPa3NxK3NiZWEx?=
 =?utf-8?B?bHNvdVZHUU1xMThFVkViQzF4QW5uYksxbzFMSi8yVnQ1dlE3d2ZyTXRLa2hU?=
 =?utf-8?B?WS9UUFZsQUR3K1pqbk15QnYwYVlqZHJENzJ2ZTh2NCt2enhraGUvMkdtTnlG?=
 =?utf-8?B?bmdLYzRpbjA5ejJBNXU5aFhyanorRVE1L1Nnb21vQ0VJNUtTZmRhU01tQ2xx?=
 =?utf-8?B?TER1a1E4TjVLTWkvQWVCVXVLRDdoV1kyNmllNlJteTVMcTBOZmhtN1ArRzRG?=
 =?utf-8?B?TWtPSnZRM0FmU0Vvek52WFRjSjNUVkNIS3h1U2RrQlBSS0E4bm03NmRERkxi?=
 =?utf-8?B?djA3ZEh6Y3NwaVEyTVltWkVlMVorUGo0dGJ6WDR4N2xCNWxmMmRvQzdwSlZV?=
 =?utf-8?B?U2x6Qk1QSXFiMERDbTFpbnhEanJXbzNtZUlIQVFvaE9JMDVuLzFJVXFYd0hD?=
 =?utf-8?B?dTl2QVU0T0sxazhYMGp0Y2d3M0p4aDJ0aGV3TlI0WXJ6VHZJTWxTU04xNUpw?=
 =?utf-8?B?K3VpRzBKT3V3VGxXMC9lOEZkUmhPY2IvcHBVYXJPV1dzS1BidzQ4QVRPamRU?=
 =?utf-8?B?enNzQjVMUUlEclBaNExuUnk1aTBOaUg5TUdoaTFmZ1JqdlByeDltR0N1ak5G?=
 =?utf-8?B?V280Q2k4am5MWGNhaENWcXF6bGxrZS8vc2IyWWZjMnVPeEIzbGhWRjdJT2Q3?=
 =?utf-8?B?TEJ0Mnh1YndCZ3JXcjA3REZka1lsek1aSFFlc3NMNkZScFpOaHNIOENkRHRz?=
 =?utf-8?B?ellaaFNBa25ubTJ6WkJpRGpzck95YXV5Y0RjbTdHY25RS2czNUxwUXNGQlo2?=
 =?utf-8?B?ZXROQjNDNVhHSXFSQmFGVkE2bHBvbEV6bXNkN1NIS0IybEhIdjJzRGVuTGZR?=
 =?utf-8?B?c0FEenNrVTNVTDFEdFM2d1lsM1UyelRvUWY2MG1pTnIzeHlWYWJNS21sVVNy?=
 =?utf-8?B?SkZuMmtMTHFoaVBieXJvZnVBb0dKUGtOL3ZmUVFrWGJ3aVBQVG1ZblV5SzZy?=
 =?utf-8?B?azJoMDhjRUw4K2tVZGlNZk0wSkYrbEtEbDR1cS9EZ2N4ZnpEMzZkTGVsbjF1?=
 =?utf-8?B?b3BMNnJ2NmNWUDQ0bTRXT0dtbE9RSHhudlZkazN5TmNYbnZYZGpWUjV6RzVW?=
 =?utf-8?B?dG44QmszRWJFN3VDYXcwSElEOGtVNUh2bk94NWFnS1dFenBnay9FQlRtRHE4?=
 =?utf-8?B?am9HOU9aUmhBQURzYTQ3eWthQU1aUm8xdkNqTjI3eEUrdHNUa21tWFRIcG5H?=
 =?utf-8?B?Ynhub2c5bUxkY1lsb1JyQzZLZitZN0JvMWRxN3E2eG13dm5jdmUzNXMxMDg2?=
 =?utf-8?B?QlJKVE9aRzF2bURCZ1kySVNNaVhVbXZ3MmIvZ2xqdzFmeXJuOFdVV1NMQnNj?=
 =?utf-8?B?QnZXelZRcFhQL2ppT3pmWG1LaEhjTnJxeWpwR3pMWC9rRlJQYmRobHkyUkVT?=
 =?utf-8?B?QU9wWXh3bXh2Mkc5REk5ckpQVkNuc2RKLzh5a0JXQWdraXNERXA0Y2ZCazJH?=
 =?utf-8?Q?MO14If1rdw8h6TBtXQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebdc737-0924-45bc-7b9b-08deb648fbbe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:22:51.2510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5icayGVKYcRJ/T92FtrZJ8L2hKma2UUTgk+tFK/q34dtT9d62mEaeEWCWxuBlWio
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232
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

On 5/19/26 21:41, Maoyi Xie wrote:
> Hi all,
> 
> While auditing list_last_entry callsites, I noticed two places in
> drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c where the developer
> wrote a NULL check for an empty list but used the unsafe API. The
> check is dead code. I would appreciate it if you could take a
> look and let me know whether these are worth fixing.
> 
> The two sites are amdgpu_ring_mux_ib_mark_offset() and
> amdgpu_ring_mux_end_ib() (linux-7.1-rc1, around lines 497 and
> 530):
> 
>     chunk = list_last_entry(&e->list, struct amdgpu_mux_chunk, entry);
>     if (!chunk) {
>             DRM_ERROR("cannot find chunk!\n");
>             return;
>     }
> 
> list_last_entry() returns container_of(&e->list, struct
> amdgpu_mux_chunk, entry) when e->list is empty, never NULL. The
> "cannot find chunk!" error path is dead code.

Good catch, as far as I can see the NULL check can safely be removed.

Regards,
Christian.

> 
> With an empty e->list, the fall through pointer aliases &e->list
> inside struct amdgpu_mux_entry. The writes that follow then
> corrupt fields of the mux_entry at the corresponding offsets.
> mark_offset writes cntl_offset, de_offset and ce_offset. end_ib
> writes end and sync_seq.
> 
> e->list is empty if a software ring submits an IB mark or IB end
> before any chunk is queued for that ring. This can happen on a
> fresh start_ib path, or after end_ib drops the last chunk.
> 
> A candidate fix is a one liner per site. Switch to
> list_last_entry_or_null so the existing error path runs.
> 
> Similar dead empty checks after list_first_entry / list_last_entry
> have been cleaned up in the same shape, for example commit
> fbb8bc408027 (net: qed: Remove redundant NULL checks after
> list_first_entry), commit c708d3fad421 (crypto: atmel: use
> list_first_entry_or_null to simplify find_dev) and commit
> 10379171f346 (ksmbd: use list_first_entry_or_null for
> opinfo_get_list). The qed commit message describes the exact
> shape we observe here. These two sites appear to be missed by
> those cleanups.
> 
> If this is intentional or already known, please disregard.
> Otherwise I am happy to send a [PATCH] or to leave the fix to you.
> 
> Thanks,
> Maoyi Xie
> https://maoyixie.com/

