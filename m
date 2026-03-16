Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A060DF46453
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 11:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B23310E2F1;
	Mon, 16 Mar 2026 11:44:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VT2mEuYa";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C391A10E2F1;
 Mon, 16 Mar 2026 11:44:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osvasaPzQ2x4KgaLPW5aWXHorVfRi99+ocBMuzhGMjyf2j62WheTmgMom2rUwL+Qd7FCKwLOyYGR8IedXEAvMxD1zGH6Aw/3fKU4/GZ2DH9SzSX5ZS5a/+bz8wdJsjx8PG1jeJrvYGzoO+jJ56D5Cq/awFBwp02Rjb8GNpSdgPGJCUBVt31wEufGjFdJrXC0Y/epp3kg7u2/TcEqzlQ2BLkneYy/eFxPhik4S1WbvC1I5Hol6XusZC+WDESDvD2GEppWzMy670z2v4AaL117N66Ex7To1EIM9Qul3k9lSsaG+gHNkze3RLUtDaTA31NI5skaUfovGY70xJ8Bb/XagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBmGeV0fxFbumh2qzcwo3oLcjGp1XJ93PfkqC+3A3eM=;
 b=ym97D+N6vGC5lpSSWb4Vs7mb5u/mq7DKy7CoSadmgjXzGJ+AzZrWD0taNLiA4dzkNaWUnAq7H/Wd8Je4ifyS1/sWbiTSklAggx5Zp+QYOZtj2f79Pf84/0ZSbDdDR4RGzsLBOSJWCAebyi/+tn6kDB1zQ4T2kUfo25xAt8yp2INg9dowz+KbZpIhmmImgF7/H3RsCkJNYNvOkliRIuyIK2lIIleqxjtN14U/xHSawvktpHPhpSt5DGyER5QJoA+L5498RQkxVjXwL4cRiMx5KAHJ22puyHXfWwfQ4L/sRe9LXrp8v2UxH2K2IygiIFmB57edf6xBJzTQUrVvXAUNeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBmGeV0fxFbumh2qzcwo3oLcjGp1XJ93PfkqC+3A3eM=;
 b=VT2mEuYa4OvNvL0aE6+axhZCb04Zad0QA1I/mMGG0cwwx/6Hv5rc3GY+jDHAO+tfRWgb9WXVHXM6+wXsd9IpZbr5bNRDNeUsxWNiC3l9KQlsXoPIHavMSokKEGth8t9nCHwKLE2oUUEA6bF2nSsKaRvnkTmWDFGm74Yor+43nef+0SDlCB2Chg19KYVjPmj2o35G9jgTudB8C+IQ0bKGetQ1p0ck7fDAYHDGCaF95UbQCnONe3M0vKOvr/ofr0Nb5BWerLsSU9mkxuSzdqN7Zr2e4aAfuEsSKnZ+FgoJatM6/Dv6QimhFZO3OJ1dN9h6RtMVY/HPAPyoyRdfmf+fJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 11:44:27 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 11:44:27 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 20:44:24 +0900
Message-Id: <DH46IKESDQ3B.2GEUC479WDK3N@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <rust-for-linux@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 6/9] gpu: nova-core: generalize `flush_into_kvec` to
 `flush_into_vec`
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260227-rmcontrol-v1-0-86648e4869f9@nvidia.com>
 <20260227-rmcontrol-v1-6-86648e4869f9@nvidia.com>
 <093ca23e-7081-42db-a202-0a42c51741a3@kernel.org>
 <DGYL9FS1Z00X.2HEJ96J8R3OK4@kernel.org>
In-Reply-To: <DGYL9FS1Z00X.2HEJ96J8R3OK4@kernel.org>
X-ClientProxiedBy: BYAPR08CA0039.namprd08.prod.outlook.com
 (2603:10b6:a03:117::16) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d99318-e5dd-4b8f-9f8d-08de83516108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: R3GL6I8p8LmmL6+1P+WCatdpkAjaioG3Ldi0mjqtRrvYJQqia9WBFIalYXkUwItMR+P1Npl9WgsNL6/26pf7ZHhB0xMvINX3mICDqvp480PD/Fdx1R36jgr3W5oVFW4ppHLBqAMGXcNCuF7qswd7CcbM3K1iXjzzjbQ1YZTvzjLqYafUhnNyfQwcryzG0J3h/EhN7hxtIiET7VUZ6VTdkE06RZ6L7TMSh7Py06nRcQ6zyKF6n+XcKhqWMc45cowEk+Gqn5ZRJl1DoPv59+0f2P8ocerFRY5XD/St5liQksG/2Sv0mU+J4zXBwIsbMYO1MBKcPndWFDli4a4dexTevERKwrtH5WBQNNtuZms0Z8eVnJTPnfb9L4eK8w0Ogb/+WkNv1Ez2PTWLNll9t3C/rx0wni8dH6ggCfPgzxQW4aOWXtD7jVNaaXDo66D3S8icbrcCJM2Y6XLgji5dmHmVl2bsT2FDNeWy6p6C6RAcAA/ixCMCjntzv4chivO8wPJJeINykphwokgpsCX/i3PVehuKHDQASuth8QpKxZQHS36czqW2BS8RJEy5bxwj6T4bXiweVDHoxr7P7vZjE8K8RJPjVUcWQT/XKFVUVhQjFyN0NwICnZB+MjaeIhyCxLCAm1OO43uHnvDzFTFixEWAIJuy7a8G0iQ7IkOwnB8/WTUTURqO3k+opHew6hNWNIiNu4lJdju7m8O94CbndLgO5NmlfffRnBjAOfKkb0SpVqs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0VSZ2FoS3Qvc3FCcHRQaVlTbHhkKzE0NS9tSTJPSmRtSXFIaWM1TE1iTGxh?=
 =?utf-8?B?Q29hUkY0by9mQkdoa0RvOGdMMVFoWDlxZFgvcFFPOGxLSHdFMmlpNy8yOFcx?=
 =?utf-8?B?c3dYOHJHQUd0ZURRc0J4cmE1WlJydHRoa01UVjNyQ1FmNS9lN0kyNXZORmo3?=
 =?utf-8?B?Yy9hUFB0U2lkVERNMnBjWmNoL1gyeXozL0loRWZrU1RrMU1mMjJsUEgrU2Z2?=
 =?utf-8?B?bGNwWmF2V3k2dE1EUEU0aHQzNnh5d29Jc1BWdmd2M01nck5QUnhIbHVkdjNo?=
 =?utf-8?B?SXhkQWlBNzA1TVNEb3pYbllGRUg3OCtzKzZVaU5tck1jQm5kRFNOcmlTeGNN?=
 =?utf-8?B?cHVzRW9jQzVsMnFwcGtVWHoxdnRnaGhLZGVxWnU2QXkzQVRvbzdGLzM3WmlO?=
 =?utf-8?B?MWlpclJ6UTF3bDVHb0lrMUE1clpreDBsYWwvbEMzWmtJM2hRamtyZTdrQWxm?=
 =?utf-8?B?aEpCVWRmaUVueTViWVJpNXRKa29pNDVNVWxBRFRiNkNucDU0d2pKRzZqZnFF?=
 =?utf-8?B?clpUbHpwMitWVFlVVzQzOTB6SThidFhNL0x1U2lOdmhyUjgybHFINklVQkwz?=
 =?utf-8?B?VVdNZzRITnJpWk1rQ29oWmRaOEdKR2lPNk1XV0c2eGtBelpmejQ4eUw3OHFp?=
 =?utf-8?B?ZG5VMGkra2tabTBZb3EzMEo0NGVubitLR3MzYzhFNGdGdEg5aXh4N1RBU29B?=
 =?utf-8?B?Q1R5RE91WEJLYXlhS2xMNmVhZW01WDk4UGJVdUxMRkZMN2UwcnJab2prNjdu?=
 =?utf-8?B?emx5N2I3M21DeE9VQXJBeE0rUUt6bTJvZlYwWlEydU9IVCtjWVBhSHVtRVlk?=
 =?utf-8?B?ZzFXai9SU1cxSEUxc3RGWDdzNHVLSzg0bkdZeXRyVTBFYklIS1V6NnJXTkR1?=
 =?utf-8?B?a1JXNDVoeEszQkc4QlhDNmNpS3NON3RlWnJjbVpYd1hFWlo1MU9NS1phQWM4?=
 =?utf-8?B?a08rNlArYlhPU2NWbFFuZ1gyOEt4KzZZUW9Oc0dRcWNQT2RaaWRxcTdIK2M3?=
 =?utf-8?B?RWFDc0k4L3RlY1pKOUlFdzhsNkdGNjdld2RGR0s4NWVIOE1KWC91QzJadFcx?=
 =?utf-8?B?ZHpPYXdUV1BFclpqeEMvRDlFNGd2L2p5cHpVb3Q4QU5yTldqdDYzZjRwbm1v?=
 =?utf-8?B?VHdVSEtOYXh6YTV0b2xSTi9yMjU3Tms2bkd4aGliK09hQVA0UTdmSDdDaE0x?=
 =?utf-8?B?c0tCQ3VBb1BqVDVwcHhKd0pKbW5sUUpBQ2drb2xQUWJGRlpnOHRIdXhJS3hW?=
 =?utf-8?B?dzV5NHFZWmdWSlJsRFZTUDZxNnM0RlJZMGFwaSsxTzR6NW1YRU9Ma21sTTk5?=
 =?utf-8?B?czVGVWpEU1pRRzNGd282aHhUdUlGVkJoSm1LNDlIcWh4ZFdFelFuME5ia1dk?=
 =?utf-8?B?Q2xmV2cyalg1WjNudi8vUi8wb3JpVm96RnRBTTZJUGFCVmx5SzZ1T3pWY1dO?=
 =?utf-8?B?WmtrMmVQSnpEWmh6TzI3WnZuWm5LM1hFZUhUVC9nMER3RjdmQTdmWlZxQlVr?=
 =?utf-8?B?OVBnUVJNM2VNK1NBQkZIOXZLNnE2U0JNTkRiWnI1aTJvZ3VEc3pxaTc5Rk1U?=
 =?utf-8?B?UEpWUis3ZHlGcDgzMWZHWHh0ZmpBaGp0Z2Jra3hFMmxHSFYwTnN4RTB3eE9F?=
 =?utf-8?B?NHgvNm0vRnR5SUxsU1FtUVdHbnhSSVN5Nk5FelNXTGJxQ2FiZVJ1WElycEZn?=
 =?utf-8?B?RDFjUVpkY2VIaFEvR0NBS3NMeGVrUGZrTUxRZTc5VHpIYmdIcnhYUS9LSXI4?=
 =?utf-8?B?VzBSd1I3VnhWb2xKZVlXV1g2N0trWmJKVHpXVmFsM0ZPYkxRRUluMWErSzdC?=
 =?utf-8?B?d3hONXVCSVFPWi9aVm00b2pMektiL3RXcGhMWlFWSHprNkpCRHRUK3Y5RzBO?=
 =?utf-8?B?SDVxZHZ2ZHJyTXhtWWNrVUlCdEJDd1g0VmFDNTBjYVY5Q1JqbDdTODhqWG5y?=
 =?utf-8?B?T216TmtFdkNwQWJpNjl2YUVOSE5wU1ZuZkliVyt6RkdzcCtsem01ODdSVjd6?=
 =?utf-8?B?d1dYSE53NC9haXBTQ1Z6QzhsSnFVYmxBM01ZcnNqcThMb2tiWmFWN1JseVlz?=
 =?utf-8?B?Q0NQNktkbVRjNElMUmpFRWJ3eFNOMVZ4dlhqemNXZTMwVjB5d3A2OExVUlJt?=
 =?utf-8?B?c1NWNUZYTFJQZDBIcHZqUTRRMW9lZlZUM0V3aVlWVnFhQ1FtUElwZFArUUt2?=
 =?utf-8?B?Q0YrczlGRWlJOEdEV2tvTEU3RTRPbXhYMThxSWp4b0k2MnU3bXRNaTUvSEVr?=
 =?utf-8?B?bmhrNDVpYUF5TlJtVXl4eVZQallGamp6QlVWOEpUVTNmVTFheEhETXBLMExy?=
 =?utf-8?B?eS9hc3FNR3BMaEhRbWw3VG1yT25ER1pkeUxQdncwMHM1MXkyWktrWWd3ZDZP?=
 =?utf-8?Q?yU1/SB5SdKwVEhT1F4RwV4DVpYfIUv7CLQ1qQi5zKEArC?=
X-MS-Exchange-AntiSpam-MessageData-1: DftFCNds5tVN4g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d99318-e5dd-4b8f-9f8d-08de83516108
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 11:44:27.8308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 367Cs9WYEFiNvdjGFhbYK9CVarLZ+BacCuYQMPCfO3WRU6vp9NiaoHOLI6Qmt0akwT/rrw1otBPFFWbARzvQXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813
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

On Tue Mar 10, 2026 at 7:01 AM JST, Danilo Krummrich wrote:
> On Mon Mar 9, 2026 at 10:57 PM CET, Danilo Krummrich wrote:
>> On 2/27/2026 1:32 PM, Eliot Courtney wrote:
>>> Add general `flush_into_vec` function. Add `flush_into_kvvec`
>>> convenience wrapper alongside the existing `flush_into_kvec` function.
>>> This is generally useful but immediately used for e.g. holding RM
>>> control payloads, which can be large (~>=3D20 KiB).
>>
>> Why not just always use KVVec? It also seems that the KVec variant is no=
t used?
>
> (Besides its single usage in GspSequence, which wouldn't hurt to be a KVV=
ec.)
>
>> If there's no reason for having both, I'd also just call this into_vec()=
.

I think always using KVVec should be fine, thanks!

For the naming, I think `read_to_vec` may be more conventional for this
-- `into_vec` implies consuming the object, but if we want to keep the
warning in `Cmdq::receive_msg` if not all the data is consumed we need
to take &mut self.
