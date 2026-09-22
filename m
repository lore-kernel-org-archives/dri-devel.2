Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40232C982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA31B10E6B2;
	Tue, 22 Sep 2026 09:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hnWeraXO";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1884D10E683;
 Tue, 22 Sep 2026 09:44:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuUHL3R/lxV+tBKbvJlEVv05L28VnxKRjzGnvQk7n1kpKUu6wkv1bBSjROGI46BrfTyH7lP3oTfZz4cTQgn8xdltEzU9X6ED6FkjhTb1E6Xma/63Z3HYfChcimAnREJEUM8Fe/6qniX2krwGczqJIM7sHZOduOqJGF0Ce2YUUVE3eiwfRqUliFvOr3vXIGA10FrwauUI9kz1pGEdpv3iydGwt2XcusGNFwIfSh8bwCuPhYBt4yx4S4+cGufTkvMMCWVmf8l10FqRSr4+oVG/8B7VCaLa57WS5T00m/3uGY81751Sc5wcwVfvmhKPztMsc0FIjlvQdPDj5ZW3bmOFew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AYkml0+1ea1WnVV9Hf1LbhAQ19Ouw6pDUAbSySylWI=;
 b=xOzaG4fEaQmpJDdNEGZoo0Iw0JyewGuLdIyZkUhfHJkCh0OaUhWByCVm4kxn+bQKcVeq9wswOjOEm3XzbqOWJgADKmP8m+r6McSkWa5MNDxo7wIlBmwP8GwJp1luQ/uVg8GIg1yvFLEGo+suBLLZ1wTQQUBajcDMhFxobnyroml3r+72Wscn5QhCgcKg7Bm+y7c6FW2JJ/DSRmXIzkCBZKoHiOAyMObHqkbyjnnMYTUDzrnjkHrai2309oKbzo7sEyaZjpNMnwmvk+DI6yRqgAT99zzyLS0WmcyjeCBe/0vaIqvwJ0CF1O/ztdwotV4ZLHyDRgS9Qo9S1C24uaw5tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AYkml0+1ea1WnVV9Hf1LbhAQ19Ouw6pDUAbSySylWI=;
 b=hnWeraXOFtr/8owcg00XFP2Bdceqe29XXmmnGgeyLvjcR0O8L1TFoj5RovACiGRrNg/vXKkTEU5msf2vKlw1OnJ3APqFbLqfwm72UCm7We1uwC5+A1v5XWnxPzTQTN0XcJ6VCIR1l++L0KghrOTtc2QSssKN+X3E4WPpUDT1bOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by EA3PR12MB828978.namprd12.prod.outlook.com (2603:10b6:303:308::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 09:44:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 09:44:26 +0000
Message-ID: <026cf5c2-585d-4171-b27f-74cd01e81b02@amd.com>
Date: Tue, 22 Sep 2026 11:44:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915: fix incorrect RCU teardown order
To: Jani Nikula <jani.nikula@linux.intel.com>,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, tursulin@ursulin.net
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260903113621.54660-1-christian.koenig@amd.com>
 <87116b9512796cf3ac2db310aa320f94a87a96e4@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <87116b9512796cf3ac2db310aa320f94a87a96e4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:208:52f::28) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|EA3PR12MB828978:EE_
X-MS-Office365-Filtering-Correlation-Id: e1cfacdc-9ba7-4da1-c133-08df188e16ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: ycoMSoKDAjduNiVyZmpk5a9EPICpbNtZZawwhI1vL6ohFnEwjQxJx2QiPthrIf5i6MVMIJZJ0XCEeZZRZx8GUEjK/T4KuD8zW/P0x/yVUH+639uua6PZEf4CZ4Fwt7XiPCCcCq0Jm324y8j2RXQhRirwLi2a/841edZJqU/4BC98yjNaNF0YKtiVrzfrrxleQjDSCyz2FVdQ0cqyi60u4dJP7YdGiLK4s+2qmnZgkj6GtWB8rqGvD+tpFoXRp7EOLCBlZALDtSQEO2hMzZ3kVtEZrsJbf9JZrzSTTYDEaIqPFHgwmsuTNHWQL8lAeFGqBc8xkkpG6x62/XvRXC+UFQ1FRCR+qQ31nPFl3fxQ1DPlU/QO4IzyJz85W0UUe7s1SwcfwjVujhUDJSf1EW0YLLdJlNN6l1GwxpPdwNBB6RSV/8qvx4FA2T0qN/0iAJ87XcYrrtyg0ZulQtarQF6DZ7ZrOc3w1iYVqlejvUsWwo8/YToBQVeuzcsi53qDtP3D5AB93L6Es5NuOns1HdyuL64JFcIYZrLT/m1XFUTJzBdvspfwchOhVs05wLlJloicLl0c9JoAqrdCyw3KqdjvdAmMwerpONe6F9EXZ/7iLZ/GTPfwU9hYBPnV3Lug4kLH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alJadDBXcHJFTTRpTjNsYU15Y0F6ODF1VEQzMWlJSWZvOGdFT1JpUXdjVXZD?=
 =?utf-8?B?MmcrS1RxeGxHM2JBSzFScHdHRzVLeWxDRnVpb0dxb2Y5M0ZscWFjVTNZMnJt?=
 =?utf-8?B?dElDRmxQeVQ0MU9nWktsZGpOTWlIUFREekk1V1RxMFl4Vmp6Zyt4QVAzMTZn?=
 =?utf-8?B?TXo1dUVzOUptMVpjQUpxQkVGMUE3cGVETGxuTXNTeVcvbm82Rmt5NW5DTU1o?=
 =?utf-8?B?TENsTURJWktYTFUvYjdDM3hnek1Ra0FwcnNKVFVuMnB4aUc0bG83cFhOWHVC?=
 =?utf-8?B?WUhLM1VRcUJzMWM2OS9yYzFBbWxabnRSSkpwOHZQamhRUXFoZUxPNFJaclVP?=
 =?utf-8?B?N2NqK0JOT1hVRVpSVjRTMTBiZlp1UFFicGozSW9mQXhTY245b2JSbE5JREhZ?=
 =?utf-8?B?Z2wwYjR6Yno5em5uQmVYeDREK2lIa1BTTXBvSUFFOWhxSU9Va1YvMmFlOVR4?=
 =?utf-8?B?VVJxZ3NzRnhpQ2RibHM1NTY3TlJaYzI2MnFmcWx5K2h5bXkrN3hmakl0aTA1?=
 =?utf-8?B?T3g0VmNtMTNFN1g2MmFqREVMdWUzek9jRjNibk5kMlQ5MnlEQTZYSlUwVWR4?=
 =?utf-8?B?SVE4d08wbG9UUzJOYktIcnhGOVcra3dLQmhaM3FoaE5UcGQwNG0zOW1XbDVO?=
 =?utf-8?B?R0RORUpCTFB5UUVsZFlCREFwMmhsL1JCR3huZEdzS003cEpsNldMNjlIcWdX?=
 =?utf-8?B?Zlh6YTNLREhSY3Z6NnovRndZdUFwMFBoUmJuU01sc0lsanFlazRjUzVQbUl2?=
 =?utf-8?B?Qi91bHNoRkdrdWVIWWZoVTJGNktzMVNRUDVhVlFGNU5yU0FJZHUzY1IwTjFY?=
 =?utf-8?B?UTFrU2xUanVmc0dzTXp4MEFValkvcTk4azJ0TVZhcjZwY0ZwZ3Q0MG1IV1lu?=
 =?utf-8?B?VXFwSE9NREtZYXJpN2dmRGFBTmxRcnFYTVA0YktGVlNLU3JYdmxtN1VPZnY1?=
 =?utf-8?B?Wm5XWkY4SGJHQjI5dXhwWVFBcmw2aDRFaTVZa0NwbTByWGxhWHdGMWFaa0NC?=
 =?utf-8?B?NW9tZGJ6TytMZmcyeHpMbjJWNERYdEZRak55UEdYQjJXcGQyeG9WazJzcnQv?=
 =?utf-8?B?T3VxdlNkRkVzUnA1M050VnFiWlk1bG5sTzV3d3dSQi9pZWYxdUV0aG53QXdo?=
 =?utf-8?B?a1R2VDRVNkNOYmtocFZCNlVzTEg1S2tQY09sNm9BdnFkTzJRbm5XZnkrOG9a?=
 =?utf-8?B?MFFQS0dGbWV2ZWJrbUpna2dHdTJKdmorcnVZRmxxbkVHUjBNWnljRWNFR1JZ?=
 =?utf-8?B?clhIb2xJR1doaDlXd3dUVFJ2bFl3VFZERG9FbEZHUWhFOGMzZ0o0V09oQThX?=
 =?utf-8?B?K3BiVXd3NGxDejI1VDVFZXlzWVJqZG42N0lRZEJBL1VOdkVTT2FvUlR0b1pq?=
 =?utf-8?B?Tk9mV0JieTRWTE4zVzJUeE55MWFzd1VxYXVBNG1iOHMvS2JhaWUvNzZDS0Zj?=
 =?utf-8?B?WEcyckFqc3hPTitOSFFkRjZ6K3ZhZEhwc2hLSGVIb2JxZmZKVGVnWU9MYXpn?=
 =?utf-8?B?OEFZanNWc2xLOU1Kek9Mb2V3QzRZUXdRbHJhaHRhWGlkdGxMWFdpZ01SSWcw?=
 =?utf-8?B?WnprTzU5bGRhdXNmc2U5SVdpRmgyQzlIcmtkM2NrUzVDb3BrVjZpL2ovbjFr?=
 =?utf-8?B?K3lxeC9JaHVRUzBYM3FIdXdyV3ZyQzc5anIyL0JkYWIzL0llekJYNmlUdVph?=
 =?utf-8?B?Y2R3aXVDeUJ4bmxNVDQ0Y3RaMXVtOU16aitoMnVqakliVlRGUVZFdTJwd0VX?=
 =?utf-8?B?ZnJ1TjVxSzJoQ3BleGFXR0xldmF0bzZaSFZRRUY5K21heEc1SVZyMUhaK0Vr?=
 =?utf-8?B?UmVyOGZFR05mWndaM0lEbmJXZmg1Q1ZqbzdzREQ4cEhtaXdzaHU1WFJYb2dm?=
 =?utf-8?B?aVZNaTBsYU5KaGxnb3Z6QXJvdWJQZHIwcnlHVHFWVFVJYkJBOElNeVovYWZu?=
 =?utf-8?B?bE5qYnFiM3lNakQ5WFo1Y3ZIcUVDS25VeVF2UExic0hHdTVXWG1ySmNOT3N2?=
 =?utf-8?B?S25WajJYQnQ3WWJQZEFjNksxZjZvZUlRakExdXVNQ1l2Z2FNVG44QWM3djFT?=
 =?utf-8?B?ckxSbmVUZXZxSVhNWWRsbVRaazIwQVdDZ0VtdGd6OFpUU0RWSWsrVFc0WkQ2?=
 =?utf-8?B?RzE3Zm9pMXhjaGY5a3dIVFg4Q05ycmdqN2Zwbi9SZS8rdEc2Q1ZqZ1lBQVZL?=
 =?utf-8?B?ZlFhbkV0K0YwZHV5cjBSYkxTb2dyNGJhUnhHY2M5SUFKcjZ4NXpKQnVLcHVv?=
 =?utf-8?B?S2ZUZjl5a1Y5MHdib1ZTWW1ZcStSd0swNVo3TjRkNWFBVTh1ODZnRHFMRzdY?=
 =?utf-8?Q?HkfbESqgO956VtA5xo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1cfacdc-9ba7-4da1-c133-08df188e16ee
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 09:44:26.0654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/JlA49dpXZPjjvwJSnKLFoRezqCANZPcawjsaDJqec+eC/z6gJvSPsqj1hdau2N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR12MB828978
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

On 9/22/26 11:31, Jani Nikula wrote:
> On Thu, 03 Sep 2026, "Christian König" <ckoenig.leichtzumerken@gmail.com> wrote:
>> Signed-off-by: Christian König <christian.koenig@amd.com>
> 
> Christian, this was already merged, but it's flagged by checkpatch with
> From/Signed-off-by mismatch. I see that you've sent a bunch of patches
> like this recently. Please configure git to add the same From: as your
> Signed-off-by, or set the Signed-off-by to your From.
> 
> Though I don't understand how e.g. commit 643f9c6d862e ("MAINTAINERS:
> change TTM maintainers to Natalie and Arun") got the AMD address as
> author, even though the patch has gmail [1].

Yeah, that is my normal setup for the last 15 years :(

AMDs mail servers do very very strange things to mails, including converting text mail to HTML, mangling mails so that patches won't apply any more, changing the encoding from utf-8 to something else because non latin letter in my last name etc....

Because of that I have an exception from my manager to use my gmail account to send patches with a "Reply-To: christian.koenig@amd.com" in the header.

I could fight AMDs IT to get an exception for the email setup, but that has been a very time consuming task for other so I have never done that.

Regards,
Christian.

> 
> 
> BR,
> Jani.
> 
> 
> [1] https://lore.kernel.org/all/20260915154804.605772-1-christian.koenig@amd.com/
> 

