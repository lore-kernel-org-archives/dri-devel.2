Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1BDEDB7CA
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 07:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A98610E38E;
	Tue,  7 Apr 2026 07:59:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NNLgzF4L";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C03010E36D
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 07:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMtzVb/KDznNHLcureBpn7TB6lWidRJdcbWk/XL+bP32U6eN5GPCKJ+GYfv0fBZ83qRONO+2w+wze25i48KHnCRscZXHSpoXF0jElZDQuCuCQnAnVpMldy/5y3zvUTYfQK1TGonnmlSVOKRKzUb4/03dGYjNoRH+7rx56pe4yLE5eyBB7MnYGa1Q1uLCuWIkJ2GFXBFE3B5jRvqu2VLaApMHVjBAJXcsB+Wwc4NY4SrwdRYPEpmbYA1wcCT2sX2HyGbZTQbzHigqFBkhYLkNR1vJmlA9rggu6OORgKrknTDxZnn+bmHy9rkXsvgwRUkJX8f7hjtYmgxceCmUBKnXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmoHSkOoLqRGWBzAd85aOq3tltzTlkNWc7STEEXnP4Y=;
 b=rmqs2+oIqOsJpdqPpoDotdV5p/ufXd3V5/3bLiu0a+E3/6CCvFiadYO4b5ftPhqdMif1ZfQBF5ZeMGKtvAc6Vp1hVPydESiRkj5xP+qce+1yNTnOwDWtyECPV+INNZ8jwE7eS+hVkInl0fkYy018LqGinqKnTfaMV4c1IOqF0vym1v6dUfrBNrfu/+jVx9kbSOZubTrdnUv6nJN+MdEXhazGGf/H9CRi/43HwY8ly8Jwf1098pCRGqvIwxBzaON0caY9LFkRHL9AowJhfeaZGV8riEhFrLKG4PyFILRCgwd4k66dj64E9CXuWWS/vN/6Hngk5TKqbwbt3kRpGjvAsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmoHSkOoLqRGWBzAd85aOq3tltzTlkNWc7STEEXnP4Y=;
 b=NNLgzF4LakkKO9GXUs/9P304uTdVW+puh1HF9sAFXRCv1A+B5L1vgfO/3LNY9poLZwWhgDZtvkQz6HseP/4qOMEKxHKCnHeAxocskFgSo5nPjUnEyKLv+GJ1M2FduvX+636BM49cmfkCpo/vv6KRdKX2jTgd3UEOmi7zFalSyrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 07:59:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 07:59:27 +0000
Message-ID: <cbc66e2d-6195-4c8a-a86e-335c459db1c0@amd.com>
Date: Tue, 7 Apr 2026 09:59:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-fence: correct kernel-doc function parameter @flags
To: Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org
Cc: Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
References: <20260407043649.2015894-1-rdunlap@infradead.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260407043649.2015894-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: defde705-37ba-4e26-3e1b-08de947b96f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: V0rNqFJc9UDAvgGWf8VR3sQUsfEqIdvx7Vw15z+QaAGJN79T6l59ApwOTNXje0f6NyH9nFyD1hA4EWuaQb6PMftzppxQ37ovA7Zfspt1jkgojJfXy6Osn0MVCv0S26Mmtx8EP4opnMxeDreeuSBOJtAt3elJY7/wYvJmWM8Lp3aungn7HtHBnuUgWN1J8srL9EVB1Lw4z4mw3qCal/RfqJoF0qY8WiCZkstksf4tIcuomKecic7E+vq612SF71eO27J2su9YZdPnBUBupXGKkIIaYOBXLWw/G3BgRB9xf4clU5ipko7d+uQjgELB8KPsAJUJOSKjvP45PzXt27hLydgucT1BG423C/imOiztdm4Uhy72aowL6EJmnKcK+FZwv4VggmpNMuYfLAz9V1bN1qTknEBSfTtY96oIu1P++qx7hMt7AcXrzc5ifL/hVAEh024G0JiTUPRbQVenYLNncBH8pGE6L6H97HMdC3PPn+P8Nwc8bhTKSK3w0rqr+26/qhYtH/lMJZscu3pJlVHjxKyWDJvD4PZ2Rq7p8HBc8Mi8MXMGRvWWlk+qPKK3DUAawJL+cETwBNAa+ywPHMpQx6Z90o4KvEzG4yJYJXoRplQ2UaizAeqQRPO4FOQeopPf51bwEb/3L6r2wL9txeRjwjyXC7fbvQt4NEU8xw6frFuNFSE/WvSEke+xGYh9LEc3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEJNeXF0RjFBNWxEODhmejdqbzdsZ1YxU0o3RFNnank2a0QrblM5WTJ2VSt3?=
 =?utf-8?B?QW54cUN0azBodkVOWlFRVEE1dWg4UU8vR3o3SjRtM00zSGJtb3dYT2VJa1lo?=
 =?utf-8?B?ODNnRnJCcXN3MnFMN0FnT3RMMUZ3Vk1xVFJTNzNZck1RbjR0bTFRektRZHM2?=
 =?utf-8?B?UFNPNmkydkEzbEZSS0ZiS01qQ1ZWOG8zaTZiSjl6UVdVSzFUdkVjMTlrL3pX?=
 =?utf-8?B?S1RZbjRyamdwUGNENXRRUzgvb3FwMVZCTU1qNzdqcnIyYUhHeWxJenRkVHBK?=
 =?utf-8?B?dzBueVR2b3F0elNrREJRNUxTTHB6b05ZaHR1bGFoQ0Exa3VES1NFek56eHhI?=
 =?utf-8?B?dDdhWUV5bGthUUVvWkU1MXlacHQweXlLUkJIYk5PN1Fsd3psSVZqWlRwZkxU?=
 =?utf-8?B?YlhTTEpIdytWWklIZXdWWHZUa01NR0pCcnRJMEw2VWp4bnYxeXByTDZjMXZO?=
 =?utf-8?B?c3dLTWhzaWc1QXFCU0hPZytyWmR1Q0xtSlczTjdSa3I4Y1o4SndOc2sxR2h0?=
 =?utf-8?B?TzVSMURKSlNQV2NtcFJMZW4wcXBEYUJtSlBLUDZLZzN0ZzZablYrQTRjVWpz?=
 =?utf-8?B?M1Y2dlk0STNLTW4xM0VVekN2UjI1Y1JFOWJpVVlHZkRGeTBmZU9oSGt3NG5t?=
 =?utf-8?B?bmRSRGJtNGZBUXE4MUtUaFhDUDRsWG41Y2xwclNnc3VLNE1KY0VySXN1SWo4?=
 =?utf-8?B?T1pHZjRYSFBTdXU5b3lGOTBlQzZTTlFBZklrK2k3OEpieU90bEVBNXk1Q1Z0?=
 =?utf-8?B?UE8zY2tRTkFyVlhEVE1YMnh4LzlDaWZyK0hGZ0lQcWZzelRndmxmbmpzY3NK?=
 =?utf-8?B?MDZpT01CRHp4NzhsMGoxZEdHdWRRemJvM2ZsdlQ2cEs2aFlMdldaQkFSOTJx?=
 =?utf-8?B?YXRqWHFPSGhLK0ZqVlpzUnpENDIwbGh5VktkbzdkQ3VsRE1rNlZmQzFXblZq?=
 =?utf-8?B?aEl0NXpTbmlLeHNkOVFya3BVWEFzRTdydlIvTDJjejYzN2M2WksxUUNWeWJj?=
 =?utf-8?B?MUI3S1pMbFFvRHpxUmIwaTZrREYrUGNkZGZlT3ZSQzFrMHRxOVY5RUdacU1J?=
 =?utf-8?B?cThYaTNqRms5MXZVdzNpNEJINnRud0ZUaVNQU0dxR1dHVHFqK04wMVc4V2hF?=
 =?utf-8?B?TTV2RXdtQmRVWUYyUlpzL3hDTDBnRzlVQ1o2emdpY3pLWlhxRFFjNnVONlQ5?=
 =?utf-8?B?V1JqeGlrRVMxRzFBN21iR1UrSENHcHdnL0orZXROUU9CZVp4VTlXejc2M3kr?=
 =?utf-8?B?dmRqYWlWelE1VlJNcDdrempxMHRxMUs2MDRYbitoaXJVeG5Nam41TDVYWjh0?=
 =?utf-8?B?UjcyRzBHM1ZsMG4xZkVnRFJBSW81R2V5UEZEMCtaYnYvODV0ZjNXVE50NXAz?=
 =?utf-8?B?WHhhWFRtL1VWb3A1OHhBR3lraldIbmNzbE5ESnAvbU9sdDFkUHhVNmxVbDVq?=
 =?utf-8?B?SC9tTGFsWldETk1mQzNTbDVlTzkzYlZVTEt4ZldQLzZEWk51dWd1WUlFUENy?=
 =?utf-8?B?clFwb3dyWXF3d0FBcWNxc3FQSTl0aE9Ka1lmZjVVOTlaT1gyVWk0eHZvbTZq?=
 =?utf-8?B?UnpqSkF5dEtUaGlWVmNqcUh6MWhYWnhyN1FEMGRSRXU0T2FickcwMythdWl0?=
 =?utf-8?B?dGFQczYxUnRxVFYxeXhIdzhsdDIwNDN1dkpwd2FZZnV1MnJCeDZYU0p4Y2d3?=
 =?utf-8?B?c0JlM0R4NThkenB1S29JZm1oamxod2syTEVqNHdQWUpINFNmUHAzb1ZoT001?=
 =?utf-8?B?dVlTSit5aFZGZGsrdU1ueVBLRnlHUExiaFhnRWdqMXpxNFhnYWtwZVJBbzFT?=
 =?utf-8?B?QnRQYzU0Z3U4MzhyalRXTjlhblMrMWxzZllhWHc4bDlUVmdsMjl1QndPK3B6?=
 =?utf-8?B?VFBoeENWOEcxdHBFaTJ6MTI2ZWZma3J3bmQzZ0xyV2QrMCswb0wxZ0FwYWRt?=
 =?utf-8?B?M053Zmg5VFBoWkN3anZ3eUxUNlhFclRmWEJjYnBDWWRNbmthZGJhSnZDU1hQ?=
 =?utf-8?B?Ty95REthMXQrZjRoT3MyZVRkelNmNytVbUZ0V05kc1NUWXVaWUVDUmRrMGNl?=
 =?utf-8?B?NkJLWU0wS1Q0SlBVL0tiUFlCVWhSa3hKb25uU3NOb1VHQkozbTlOUlI4WHZq?=
 =?utf-8?B?L3dXTHZ4cTFWUCtDVG5GdThsN01MVkRaZGl2Q0JEckN2Ry9GRWJnVGRnTDVw?=
 =?utf-8?B?czMxSlBCNG83Y0dOR2gwbk9wRFhkdXNTT2I2WWJGQWVhazEzbnEwUnExTGZu?=
 =?utf-8?B?bHVDTXZ1MzNQejBBa0lLM2ZBRXJyNGhTQU01RkJvSXBlQzcwRDlMR0doaVp4?=
 =?utf-8?Q?+AxCaloGAaJg4UeQX0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: defde705-37ba-4e26-3e1b-08de947b96f3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 07:59:26.9025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFHJlnoxTkUlx7vFJ0HgjM6X30DW2c42E3RWKIjLKDe3QL5E2Nga0B+gRvakI6OA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
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

On 4/7/26 06:36, Randy Dunlap wrote:
> 'make htmldocs' complains that dma_fence_unlock_irqrestore() is missing
> a description of its @flags parameter. The description is there but it is
> missing a ':' sign. Add that and correct the possessive form of "its".
> 
> WARNING: ../include/linux/dma-fence.h:414 function parameter 'flags' not described in 'dma_fence_unlock_irqrestore'
> 
> Fixes: 3e5067931b5d ("dma-buf: abstract fence locking v2")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Christian König <christian.koenig@amd.com>

Going to push it later today.

> ---
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: linux-media@vger.kernel.org
> 
>  include/linux/dma-fence.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20260406.orig/include/linux/dma-fence.h
> +++ linux-next-20260406/include/linux/dma-fence.h
> @@ -408,9 +408,9 @@ static inline spinlock_t *dma_fence_spin
>  /**
>   * dma_fence_unlock_irqrestore - unlock the fence and irqrestore
>   * @fence: the fence to unlock
> - * @flags the CPU flags to restore
> + * @flags: the CPU flags to restore
>   *
> - * Unlock the fence, allowing it to change it's state to signaled again.
> + * Unlock the fence, allowing it to change its state to signaled again.
>   */
>  #define dma_fence_unlock_irqrestore(fence, flags)	\
>  	spin_unlock_irqrestore(dma_fence_spinlock(fence), flags)

