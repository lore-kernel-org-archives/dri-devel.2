Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718AB606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OZe8Dtui
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5CBD10E1F1;
	Mon, 16 Nov 2026 07:58:26 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013005.outbound.protection.outlook.com
 [40.93.196.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78B7E10E212
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 07:58:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYoaqvecvckWLSIU5eKRtTIUgr2Ff/lYJa4Ag7loO/qp7/C8byZ4Sm846Xn16BkYxT8aKDOht6us81gb776JOh10hrfcaPt4qPX+vmkyja+MjHOWU+RlOkve+nr7rPP07nfA5fOXBZ5OwOR/hwUrygngnnJDCqRZbmlO91E9whtSXahm1RC0LAdKQM/FbBs849aM/mpo/7dGSV65sOdMB6gCsrtUH7eeV7SSi38677oskvKpjmNMIMfpi8eFc4BJd5QCWNMI26qS/PeJnVUbURVCaNZVrGdT7NAmS07R+ztvd6xJmHrB4RNrFsscsHjlBIxjIWwny4sFS1ZlxCVx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hV3r0tSwgUmjK5cqkHGWd22JGFw8M4y82I1iKi3Dr14=;
 b=M+/zh5vIP0Nk0wK5QhWfHpTvVFMslCR9SQvjMueQ2KxEQSxfWCzd4PKk2xHcY3KmaPT6mE1lhc7m/7uLRANl5UedvW1DcqpdE7UyfaN9MPcTH3Ar4WMl5c5Q8VMf7p7TXqGD/9vVwy8bHh6HwmS4ajXkP5hxgkpc74VZLPSxQBJ4ZAu+trDKDETx5JEzcM70WjRufSzCEpPN1WKjBRoWGYGFe2LZz+yRZFyQDJ4Jl6vtShENo/uE2q/7PeUuTeTFxjz/2yJTyYV908lRn3f4guAu4s8/v88ZHrm5mQ1dJIilW/5PRhZdd5SpmDBQOBZNWscCFjzPfnu9OifwCR7MeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hV3r0tSwgUmjK5cqkHGWd22JGFw8M4y82I1iKi3Dr14=;
 b=OZe8DtuiIG2wD0AUdA4L4fw+O8MaohtrZJcj04V4/LshYC8ofvtuMVevbsIazZxUu98C0sgu1C/qIwAvppCTNyiaNoFV7AgexxMXIiyfaMhjEC9Cu55p8qEdgH1p4ywi8YpCN08GYU7EH0mm0PQ42RTTsJguqNYVvVYFmfeDwKIiopw5ID6eJSabtc27Zff1GhWoLiI1Go6o61S+c+LoJZCypATPIZgSvUdwpBD5cUaEhv4M/XSorDq1QwyAnRAk38Cl4OG708nlMRHf0Xq8mZryCvbCQ6hHeSlPNi4hDIqYlOrA8izikkb5uP/MmRs+JMz4UZMy8RSkMmmG9mQPLw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by IA0PPFAF4999BF6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 07:56:12 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0615.012; Mon, 16 Nov 2026
 07:56:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 16:56:09 +0900
Message-Id: <DMWH39UWW4KZ.1C5B2M4W1V3CF@nvidia.com>
Cc: <aliceryhl@google.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <lossin@kernel.org>, <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] gpu: nova-core: use pin-init self-referential
 support
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20261111161935.750047-1-dakr@kernel.org>
 <20261111161935.750047-2-dakr@kernel.org>
In-Reply-To: <20261111161935.750047-2-dakr@kernel.org>
X-ClientProxiedBy: TY4PR01CA0075.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::17) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|IA0PPFAF4999BF6:EE_
X-MS-Office365-Filtering-Correlation-Id: a91f23f7-fb1c-42fd-6dc8-08df43b71522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|10070799003|23010399003|366016|10067099003|11063799006|4143699003|56012099006|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iMrKcR6pK39kt4pwz2SF67VdWrxDfPybc1wHjb1KqohHSLuQm9eYI2RHhKa/lJDtUrUH+RCOcMD13vDDxMtyE4pVLpvEWXCG5PwNdWeeIzLHXTIBk0oZVl27EPAqCcn7phuSVeBGhMYX19IDfbVtgpGBj6vWYpDN/ERUvfqcGKsUzB46+jwl1W0IVl3PcKpE4OYSjCF/sz2Ra6faFYSRg7VJWrGvphOSz1MmKIqp5kYdt6tPoQ+5yHlyCzTBlkDT+PW46mLRgj3OKbNu5qPhW+0v+96+lW4NC3GZHHhLiHZKPyVU7iOinP+ySb+Y6VrTAJXX4bIRdeTozUNj3nj4ZMQmiryYxShkUXhQgolHB8SiZFMVZdLMwVXYW0G9cmloK/zxQCQE03ZUy5Tyx1MslmaftDIF/+0Rs3ZIiiaJYgoDrT1qWw0+BPDi0QHos9g7TNfOXSSSoBYTmmBwg5r8AxPOl4nphvswZWYXzUeQyjUQl/XvSHQ1jCprrtSPZPVh17KK90ev4HwDZR1imriGPiW3f+LXQ30gZvsHCszycrZPVYEheiNVxwrkWR5clawUdc/xQdzSe+mk1Sq0ArixTliV6Nrlu2O/ZwBqKRpKda3RzxcQfytwT8+CLvNkpJJRgUnwDKBz2AgXSJqZVF1IY7OM4hxDChtXubwLcZ2dMnA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(23010399003)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXVhUEN0OC9rQ1d4bGc3aTV5dTVCUjBmbllXZHpKUzhZT2pWRWRkZ1ZkRlVm?=
 =?utf-8?B?Q3U5bk81a2NhWFcvNkFOS2llYTVBQzR6eWlMNTAyOWtHYXBGeXBldE5RVzht?=
 =?utf-8?B?TXYxTTNpVkNhQlBDTkQrbFB4bmd4ZnZnWVBvWmxuY1pINktKeTFMWEsrUDVE?=
 =?utf-8?B?cE15YUZuWkRsRU8wY21BSE1kY2NtWldnbW5qTjVwa1M5aVVDcUk4YWxDUHBL?=
 =?utf-8?B?WENNajVmMll6TzBpL0RVbzlVeWZ2Mm9RY2JqWTZzbHhoWkF5WWxyWWRPWi94?=
 =?utf-8?B?blJ0MGVxQXQ0cmFyWi9mckg3U3UvaVROQjcxRy9CN1lMQ0xMOTUxbTlCZTQ0?=
 =?utf-8?B?TjFpQzZyMkh5M0RQWnQ4RFUrNy83MHVSbmFPRU9OSW9qendHV2RoY1RkdnM5?=
 =?utf-8?B?ZjhrbW5LNkJXUVU5d3c3MjVjRXlvKzNYb0N6T0Y3RW56cEtBUkZ2bXVTYkwx?=
 =?utf-8?B?Z0dCNW4veFFJY25senNWbzV2OVF1emQ4aTZaaGJoclE3dXZiOWY2TEZzOVlr?=
 =?utf-8?B?bmhIaDBHNkdSYjhneEdYaGd6ZU1wVXErak90T25lamExeFFNMVJtTi9RUThX?=
 =?utf-8?B?SG16bWx0ZFk0T1VHSWdRMHhsc0JsUWZHY1BPVCtaamlraXhaUVdqNzdhclpT?=
 =?utf-8?B?M3NRRnJzeXdmVFFlNit3MlVvNW50L0hxTXlKQ1UvWjZ5Um5YTDFmVzllM2kw?=
 =?utf-8?B?RENRcXRNRGY2R1A2US9PMlJ6VmF1bjFqZnZIWXFvOXhhNjZvRWVyNUlyUmhS?=
 =?utf-8?B?ZHphN2NKM3ZuUFkwNmRJanVKcGVxaHE4SSt3YmNNd0hTT0FaWk9ZZDZPbUxN?=
 =?utf-8?B?dkcrM3R5SmdNeFpQdGdwVkVWMjIremNLTGJOUXRXNWxTcmZFS29ockw4NmFL?=
 =?utf-8?B?WUFnZ0Z1aG56RWJZdG8wYmc5L2FKTGxnOUh5aHRSTTJQellmTk1nYUhseWRu?=
 =?utf-8?B?ZmZMTUxjckFHa2xPa3NLYkE4b1lSZFdPZHlXcVRCc3k1bEtWMDhaem13SDBK?=
 =?utf-8?B?eUtPK3lSdFZjRUl5Ukh2S1BxSmxFRjRwWGNYSDBBdDdlY1Q0eFpDTENvOU4w?=
 =?utf-8?B?QjBiL2RtQWxlZWFURzNQdUV6K0gyYjhlakQ0MEZRZGhxbFB3Mkd3K2Zqc3Ny?=
 =?utf-8?B?MG5zUUQwY0h4QTdDQ0VwdTJwSDRTZFloTXlUeHNOS2dnSmtJTm9POXhPV2Rt?=
 =?utf-8?B?SDAvRE1qUUhOOU1DU29ORGtLU2VSdVMxeDFLWjR3R0JRaWdUUHBwOUV6M29i?=
 =?utf-8?B?c1RVa2QxVm41L2JJSTVPcUZ4eEU1QVZDNjBlNVFsdDJ1VStJaHRvQ0xLb0Nr?=
 =?utf-8?B?MjNlNVphTzB0U1Q0ZGgvZ08wb3JrUCtZSHE1WEFLbVl0Y1RtckhORXAwUnNk?=
 =?utf-8?B?bHRNZC9tTlRGVG9JQUl4V25hSEZrRG1aK0NPUGpaRGdnanVZbjFpK3F1OWN5?=
 =?utf-8?B?cTBZSi9lQ1Q3Y2lmNjhOc2t5bkZtNXlubzNsZDMxUG1LSnE3a1R6OXd1Y2Rq?=
 =?utf-8?B?SHBsRk9DU016a0JQNyt6VkY1TVBzd3hyQm9lVDFHMFJ3SjVjOXRDNVFqd0NL?=
 =?utf-8?B?N1AyMXhYbm5lVlV2TVhoWTZidGN6MU5YR2VXKzFMazZwQ2daZWJXdHBKUkd6?=
 =?utf-8?B?TE9XazhZNkp4Mm4yRFovZ3QxaFhKYjA1SFIvR1Y1YjBjWGxteGVOeVVnR2lI?=
 =?utf-8?B?Qk9LckRWZjJmVUNoVmZGYVZucnlydU9OMHZOUU54RDV5TmV0K1hrTUVNOXJP?=
 =?utf-8?B?RU1sWmEvQ2RZTTdqcTFia1U1bDl3MVQ2R2tyekxIeG1IUDJFQTBSMzhuUUYx?=
 =?utf-8?B?VXd4WGwzWG52NTFHSmxqblJab2p6dURsaGg2YmlEZ3pIZ01lSFVYWVBoYith?=
 =?utf-8?B?a2QvdDZqOUNVSU5SVkhtSWE1Zk5kZ0t6U212b0VzcS9Ec01BWHdIUENDNExP?=
 =?utf-8?B?UjlYUTZKU3VmcElQRHlWUWNnby9IdHdURW91d0NhcnZSandUdkJPalZqR2Ex?=
 =?utf-8?B?QjRzK1ZLaFZQMWpuaWFNSG1rQ1U1cjZWbGdtb2lzYUx5dFErZ1dTMGUwRGRl?=
 =?utf-8?B?YUNqdkEybHR6ZVYycGphc252TURjaGxVb2hIeUtBbmVwTWM4RGJSZkRZd3Bj?=
 =?utf-8?B?eUVpSWtjMk45Ykw1c0QveFpxZktyUE0vVUxtdnZGbkVpZ2NULy9TOXVZOXRS?=
 =?utf-8?B?blppbkY5RUcxSXZ5eEtMTkIwbE45ZFBhV1Nnc1V3Y2VPbkgvKzZkVlBianV2?=
 =?utf-8?B?dzJtcUk4aWJzVzZPTnIxUEF4UWlhZUdpNzU4LzRvUmhFVkYrSnVzbWdjVXpJ?=
 =?utf-8?B?R09sU1JsTURVU1V5czFnb1ZTQmJtWFZ0ank2VU9NVDFOSXk0NXRvV2ZSR1pm?=
 =?utf-8?Q?GnWtb1Iedbdxm93rn97LgrUyfEv5v+Qx82p3hmZMjI9W5?=
X-MS-Exchange-AntiSpam-MessageData-1: 1kCh9o1f/EU6bQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91f23f7-fb1c-42fd-6dc8-08df43b71522
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 07:56:12.4029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hm+3a7ysCSKa8E8Tw+wPsP4BO1yQWB3aiZlhUNtCg24bT673z12LyIMKyhCNRUEVN/xvwVKZeO7GiPeqvbXmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFAF4999BF6
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 12, 2026 at 1:19 AM JST, Danilo Krummrich wrote:
<...>
>  drivers/gpu/nova-core/gsp/cmdq.rs     | 16 ++++++--
>  drivers/gpu/nova-core/gsp/cmdq/gmc.rs |  9 +++--
>  drivers/gpu/nova-core/gsp/cmdq/rpc.rs | 11 +++---

The changes to these files look like they are a change on their own;
they are not using the self-referential support but rather change how
the queue lock is acquired. It should probably be a separate patch
before the rest (which would be the last patch of the series).
