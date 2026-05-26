Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C390FCD5BCF
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 05:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1910F10E45E;
	Tue, 26 May 2026 05:55:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="NB9h3o19";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013051.outbound.protection.outlook.com
 [40.93.196.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE98110E45E
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 05:55:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZfMcYpqmVaNE9SpVAHGNgRLwb4oJ7o9s5nuf21cFb+IY79LsURUT+2Sx5ZEEU6u5bDQy/P0Y/scNBcXgAhk50/pxKylJW2yBi5cHEvkP7WbphjMHxiPbd9M09sLufYNFsrCl4xkwBm1WPSs8aVxRxcVgTmclkTqweZU48o2lbHrWGIzmvZ1iZK9OkbHWGpx5jO7a72fCxFxTTj/ls8QoX8ihfyPvF3RfRjVfoZhF4PljQJ799BnAZnNrs6oEzKKWjnowX5vupgo99yR7o2gienJ4wN1NeG9rlOqEFi2FCKSypYScCuzDAhJbcpxt3s740v4nefQNA5tjlNo693JuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jIcB852PtBzM0IPMGXMf2vHBl8ztwK7UVqU7CErxYk=;
 b=lpvxqEcNXanLatYdeYOfFVhuF+5lhi+R/jIw8z5XpIF6ktbHZQHt69BBjh2G0FUFC56hf8SIHEi82iVwXXIPmfCH6JhmkJP8MNZ2bH4xIizYh9kwv5V+taJOWL/YF+rFY/lFD+Sq2UvBSWVJ4UJzgas5y5Kmomuos5eGAOTQqDo2AwUKC61DU2fGkNry/oIiBkJkYBA6m5KaXwiqXSi9zcL7LlfTA7SThQQjIv5VVrpaclQ0fTVnC9IkYq7KbRH3h53oC4hdf7KmvnJyXqa4192tNBgRIbD4nAn/t7Bgw8nY+45YbTrwrFOu8IE4dwzfv+WfBJCIn/PZiPOrSha0iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jIcB852PtBzM0IPMGXMf2vHBl8ztwK7UVqU7CErxYk=;
 b=NB9h3o19P+8iAwOMBjd5teFxtmfSXJ0JeVeWpwug0O8Rwd7bE5Xm1K2NIZI667MJx+s4axsrHOmWb0fU2UwnyvW239opBTE8hBI0ENtJyBhl1bjWJN110fdkY/n8UeMQq64uNOGddjUFr+2tDQMeVVCVLL+at1fVFDEKDaKBA5cky+XezIKRHRfrs6/p6mQbV5+BOByQ4iorkgEc2go4FFTKbnqMe2P/MfuwsV9xbFgTeIW6BhL+rxFHX9zXPSYt8gyuoQuwmh6At3FrvOEvyWoEi7JU85+RBs6M7YBnZvpiCGE6KjgwES+Ui1dv4fDCUaTZ6Dq1RJIemS8dop2SoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS0PR12MB7745.namprd12.prod.outlook.com (2603:10b6:8:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 05:55:37 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 05:55:37 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Tanmay Patil <tanmayp@nvidia.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tanmay Patil <tanmayp@nvidia.com>
Subject: Re: [PATCH 0/2] gpu: host1x: syncpt_wait micro-optimizations
Date: Tue, 26 May 2026 14:55:27 +0900
Message-ID: <KV7-sSqdSXCYm56vbRzGFg@nvidia.com>
In-Reply-To: <20260514103153.766343-1-tanmayp@nvidia.com>
References: <20260514103153.766343-1-tanmayp@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCPR01CA0007.jpnprd01.prod.outlook.com (2603:1096:405::19)
 To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS0PR12MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: d7c4f94a-5a00-4b01-b715-08debaeb6896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|56012099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: B6ez1CPpOu80EEPHh8ny2ZhIqajQYhJMWKLyf4fpJu4Es1sxpTdqersBoWqsOBTQuRTIeu/p2U1lxLUHMaZfMpn+W8RSPPmd4WnspTcdrtZHPwqrBtqh4Tw8XFcw1Np4rYo3XG1wqbQn1L8QQY0gdWWz5E0WVs7GSu6y7Aacsj8t9kf+d0Zrb9UUyfvMJhx0vX3uj82YJW3whuk7hSpnjwYsD6wPsvvnvYZTpct5ReWQdmO9KyupfzGIoCxoq5GDMFAUQWBNi5ajhQI0pCQlz0J1HPrxbMe1Tos/nBOl3VVGVO7m8T0bwXSgSW3Cty/1d5+JYxsCCqHDBLWH2rqFz+ydgj+Mg3KDNSW/JXdyc4Uv70eoBYYkt+Q8tH0BCeWXM0pVr8aZMepeVS8FDJ0eUGJM002bAlC5zwcOxujpOqh2I56SsgQhdHPCLHX384KL7xxI9gm/RucVlD4VPQWmx9hQLD8Isby2C1txsCwZ6DbYILTu4IUsXU0yNrb7d9B1FLBKe9i4DbKEfNmRgCgiYKdZTEail/qvHnparZm1Ad/K03q7o2QLJVAGY/APgoE2eAY26w2Yw45/QunNa51l5jqeFvUXAEa78qNtV4C3U4hX1+49M9Buaeb+FHkhW4d3DAg7OL+55PIZy7VSRfWxgqnD17iWYOcIr/EwgJFhXa5Ift2eYg0OV0Niz1qkAylF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(56012099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkZnSEptbGsyQittdCtxM2ZWbVJRQi9mNWFhbWdDZTEzdWx1S2NZeGMwdjNY?=
 =?utf-8?B?RmV2NjJPTjdFUEhQMjZQVHJCdGx4eWNRVnlNOUFyQ05ESVFiZDAvaVBYWkFr?=
 =?utf-8?B?b0N4Q3dvelBmMkdYVEk5d1pwT1RSOW9vd3luZURPQ0xKai9SYVU3bzFxTzVa?=
 =?utf-8?B?RHpoeTlVZmxKeklpZk54cVNxdW1QMHE2c2RkUzVkZ2FOQUVKVGlvOENtNmJH?=
 =?utf-8?B?T21pb2kvdEpvSmp6aEVna3JlRm9kam1KY3hoN2tlWlRVa2MxZDVGRnNoaU91?=
 =?utf-8?B?cjVyYk8rOUFTV3dQeDJGQ3Z1VjcrTzJBaHhyci9oYmhaMm13MFJkajNFMGlC?=
 =?utf-8?B?eXhDbWtjb05hZlFHeTFsUVdOVElIckJqS01ud2R5bXk2cmRoM3FmZng1eW0z?=
 =?utf-8?B?Ly9PZ1BOL2lKRWZRK0hOcDMrTWhKR3oxM3NjOEo2THJQMk9DZEJ0N2VoeG8z?=
 =?utf-8?B?b25zRkRhb2QrT1hyTXJmSnZmcFdvL3hGL1RmaGxUd2o5MEhHSEtqaFUwZEFm?=
 =?utf-8?B?VzU5WklOem9hUm5keWxWNjNSTWRXNkpCWFJ0cjNuOFR6Sm9EcEt0NitwNGJT?=
 =?utf-8?B?bWdoNjgxVDNvdGZqUTJ1bUhQd2c5ejNzb1d2MUN3aG9ZVHBiM0FFa3RoaDQ4?=
 =?utf-8?B?N0Rmcis5d2NpL0FzRWJVV2pSd0xBQWg2ZkhLV05lQkJXV0pRRFF1cnZvOFpm?=
 =?utf-8?B?TW9QYUdRWi85QnEyeGRhUVM5K2QzRDJ4blNkNzU1aDNTQVhrZkxxMENHeXRR?=
 =?utf-8?B?dzFKS0xZUjR1cEloUkc4ck9JMXU1TDVjQkIzOTQvSzRvbGl2S3JtcnVMUDdp?=
 =?utf-8?B?TEFCUGVQTlVlYThnQzlaamdMdUtxVUR5QWg3TlJTZi9VSE5VclJ6dXRxb2Jx?=
 =?utf-8?B?QWNJazdDNlR5bmE3VTJnbVQ0Tm1UTEltM3lQdHZsOStYWEE3Tm5PbjhkREFj?=
 =?utf-8?B?NExCUmU5MXl3OVZpSCtXNTRidVduQ1M1eCsxdk53b2hQZ1piYzlCSjVKL1Q1?=
 =?utf-8?B?UW41SmhvQWZJTVczbWV4dkE3OFFyNnp3c2pzSmZkbDFWK2pHcUpSSUFuOVRo?=
 =?utf-8?B?YVBBQ1BLeVFmSnRKclpoK0Q4cTBoaE83SmJyU3NSS2FTU1Vaelp6QU9zN1Fj?=
 =?utf-8?B?NG9pYkRDS0hrSmZQQlEyOWFlNnNSYS9uWmtFMzFtcGJ3Nms4a2g3WE9tM0ZF?=
 =?utf-8?B?NlBJcmxSRVBadU9xcUtJNHpSQkgzU3phamlteEhXSldkb0dsbmwvNjBPV2VB?=
 =?utf-8?B?dllDYXlpaWpMcEIvVzVUckhMRlh0NlJoVDJvQzV2QitDQmZEL28vRnEvMFI0?=
 =?utf-8?B?SFVqbGthTG1hVEgyQ0tQa2tKcSs5QzJpL1BEenh1STJER1NSZWdqaDk0VjRF?=
 =?utf-8?B?TWx5LzFJZER1ZzRXUm5zMkFNemhxaWlTVkJFY1Q3MndIM3ZoZ2Rpb2hZSGUw?=
 =?utf-8?B?SmRUOTVkbms0Q041cXVCOUFqZEJJbWlhRmMwTytGL3R4YmJEdzNiUkF2RERj?=
 =?utf-8?B?eGtlSzJBSW9IMnpnK3J0K0FKMDNBODh4Qm9tU1g3aTJ3Y1drK0xWaDhMa3c0?=
 =?utf-8?B?TDNLVnowSHE5UGJ2bXY4NWMxajJnWGlKb3VjTkFCdlJ3SDEvc0lNMHlicXFY?=
 =?utf-8?B?L0FkM0x4bHFCaytzOWE4dDhhTmdKdFBUS3RCcWNCVjFBUVYyUW51OXdSTlQv?=
 =?utf-8?B?U0pQclVDZlFLMXpwakhrRHRFNE9pZjBYQ1k5bDdIbG5udDluM0NLNDV5VDVM?=
 =?utf-8?B?MFpzU0h2Y25hMUVsSGRkSWpRVFlCb1BhdExUb2h4WUlqTHhtVTFPMWJlOERp?=
 =?utf-8?B?WE1sWHpNa0lwNE4wdWxscE1LVldXTmg1UnpFTHdvc1BhKzErRWJLckFacmFQ?=
 =?utf-8?B?bTZMaVUxcTA4QW5HY0x4V3VwczNMbW1NUkpROUFHOWI1cGlyNTdRdkVqZlEv?=
 =?utf-8?B?TFJMdW1rT2VDSEhOaERiKzFKOS9WZmhpNHkxNlBKSmIwVkZVd1R2T3l0NlZl?=
 =?utf-8?B?R01pbDVOVzdmWVA0SmUrNmNRcmhQNm9ORFhnSDU4dTNQd2Y4VUdmQmdJcUVY?=
 =?utf-8?B?blNRUUppbXExY2p1ekxNTmYvTFFlSjhoMkhJNWJzcnhwbGdqMm1UQ0w0TlM4?=
 =?utf-8?B?NnpIMVhheUJISWMzU1ZNWk9IWGVpeGJSQytaYUR2YXNUa3p3bGw0ZUdCMkRm?=
 =?utf-8?B?ZGlIaHh4ak4xRDVXbTVZcHBrUkRZK3dsOFJJT3JrODVvZ2JkN1FxYUljUXox?=
 =?utf-8?B?MXhWTDg1RzhPbHIxZ0F3WmZ4MDgzaFBZNjVaRWdpejdlR2NIenBibDdJbGpa?=
 =?utf-8?B?blhnZkJndWZoa1l2dExIUytCL1cvY2w0Q21NaDVyUnU4T0RocnVPdzVYdzF2?=
 =?utf-8?Q?Nmzon606H/j7E8du7B+FZm09DU9t80yBEOdFVWM081ZyT?=
X-MS-Exchange-AntiSpam-MessageData-1: nDX+BN8VEmVwhg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c4f94a-5a00-4b01-b715-08debaeb6896
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 05:55:36.9646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6y0yKbkwk0W29khXDwEoUxZHcNybQwSNFnFLPxsvY4d9VhVmeGdD2NcVaZ4pgrBwywqf0aNZKzyBZ0vINsIRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7745
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

On Thursday, May 14, 2026 7:31=E2=80=AFPM Tanmay Patil wrote:
> This series reduces the latency in host1x syncpoint wait path.
>=20
> Patch 1 removes redundant MMIO reads in host1x_syncpt_wait().
> Patch 2 skips the host1x_intr_update_hw_state() call in the ISR
> when no fences remain.
>=20
> Measured syncpoint wait latency (50000 samples):
>   Average latency:   12.2 us  -> 9.4 us
>   99.99 pct latency: 62.96 us -> 36.58 us
>=20
> Tanmay Patil (2):
>   gpu: host1x: skip redundant syncpoint loads in host1x_syncpt_wait()
>   gpu: host1x: skip redundant HW state update
>=20
>  drivers/gpu/host1x/intr.c   |  8 ++++++--
>  drivers/gpu/host1x/syncpt.c | 23 ++++++++++++++---------
>  2 files changed, 20 insertions(+), 11 deletions(-)
>=20
> --=20
> 2.54.0
>=20
>=20

Thank you!

Acked-by: Mikko Perttunen <mperttunen@nvidia.com>



