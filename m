Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1E8CA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:40:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29E8010E12B;
	Mon, 28 Sep 2026 11:40:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="kz2gu6+C";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A4AE10E12B
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 11:40:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XE3/5be1VWM4CZSPn9p5OKVFM59b35KAznzVWP7fMXc/Xa/Vx12DDZdq0XyTJaHPX4OwPCtYYfmeVWVgwbmxkOQPhQKxkXdKkcUDNI+3UCYojPWpXczsCqq3IgAeK8+RDoqjciK2GwqBYSYk7iJWNM6dHpzfrfauTTS2TAXQSHD41n5HK1/4gWTCs9dbilQzmzzR813uwMP0zPJKwnb+lpN6EeBWx8ru45qhFbzc6awSuotFGizK+ST7u/XKWqvVlEzQx0mOjx4SGEKX7QJmgJ7rR6Pa3KH/6dAUWAukYzKpm5IuntfNOIcKopmKiXe5LZ1GYa22s+i0IuHrApk6Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrbS6vXLH8q+fLpPJUOqUARfaZE+/JOqx0Y25J88fYg=;
 b=LsrgJA5ZpPWV8Lxv6Fb9AgzQt/qrbVCG3VmYm0JeNcxowAyB6RLcD0fghYgARhUfmlBiDvF9QoHoRQpQ/virRBPrstmyk4zXuUVppMrY0wwsgJgJen+JyUazrhtTIXMmPTfGgo5/+owvbhY8irNLGS3kugBcTyd7DBCjKuarAFCu7TT2uSycIWvaRxLL7gSxAZJwTGgwPcB0OxW3Zb8OZfpDqgOPn1i3CM+mPrMM/uYMDohXTwms9bao1zR0w/BCm7PKma/q+FJ1c8ww2oQZeUI4BaZEivDF2tlrUs1KztihakQ0LgZqehH+rqcSkXmn8gy5G+HbWW5geNfj8lngEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrbS6vXLH8q+fLpPJUOqUARfaZE+/JOqx0Y25J88fYg=;
 b=kz2gu6+CxxT4qOgR7ZxIq2DlGtLdTApuXYCD9xxa8nt85dVh3N+6pfTQ00Eo3/bSW+6NnbsI+y0hlXvJAESpQ5+R9YbwluhfhkKhXueibIFzuE4ZNGkZN7ZE7PFlvwqFue0+X7Jpw5nqmmmU5fCWaVVjCdZRE47n1Jm3M0p/vjdDdJaLZmnRkFeHL0pGBSS1lMMXlgy4W39jHABak3kLjdwQMg7kY4APzlZDxrWn0kQGNRcKndASgAmEJICr2mbbrm7bihzh1e6wEr3MA7IbarWhV5+BFUZ9/3zimDM8Jd9MVolN1E0mFx5vPDpTMvTMKi5ufhCt6fTSOvir2KntoA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 11:40:11 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 11:40:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 20:40:08 +0900
Message-Id: <DLQX62L47S38.1D5416RRETLY3@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 8/9] gpu: nova-core: gsp: move the RPC commands into
 a sub-module
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
References: <20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com>
 <20260927-cmdq-rpc-v2-8-c3f66ae73be4@nvidia.com>
 <20260928122015.3df66b3e@inno-dell>
In-Reply-To: <20260928122015.3df66b3e@inno-dell>
X-ClientProxiedBy: OS7PR01CA0191.jpnprd01.prod.outlook.com
 (2603:1096:604:250::10) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ada62d-6f9a-4005-fd8a-08df1d554138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|10070799003|366016|1800799024|10067099003|11063799006|3023799007|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: vCQOPlTEevDGJdOe3Q1vIuY87zR5KZSrRySkLVmJu938idMhSCpYOqDifItF86p1JlWRTA7TQmWQcELYvBkuG1dk8v+7HJnxH8pckwiwoeM5il5uGu+HxNgDul2mQUTkaCm3fVBZoeBoNdYhLdt3aLr5ATR6yqniZcicHSBi8Au/bnv/16sg1a4Bx/zSnY5sSLzfNd0BiQBorMKv+0PdzIHKASW4KeeqNjFcukb/EwdBelYWoW7L+TQXmSd2aY0dVDRa7FpsLc/xGrcOqUgacVrHLl0QEXv9qNMqtIjREhoAfmvXfysVyPXiArru6UdT9AY4ZY9EaH8ld98qJ7XeXv85GLpuxayhEtvZVoPjfSUdkM3BAUCuMSXU2dyvmKI8oav1zwnsn8Q6TSN2iKn9EhO7IbTCdXq2JbFB6uwvdH8Tahn8VO13zFnCeSsgMeUswmKsNiLTjoU5fWM2lVHsG402qSXvk5jkH5HXloFKpmIlckfwJ05aSyGd3YCAf7CTV2oc0/HNoxiV5lY56QMCtykEFrq/Bssy9/Dg2hsatvz3ScDRk3mDFPXLga68Hm/tbEAMYdH+0wxiyV6yCQcuLx2iK2o5JA4bOpK+rp1ZvAOZ/eBBx3Wliiv2VbvjQufDWrKbK7qngW5QR7cKE1FHEyj/RcbQEi7Ui+V5y0R9PIc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(10070799003)(366016)(1800799024)(10067099003)(11063799006)(3023799007)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXBndE9teFVSMXR4VTR5dXFwK0J4V2hBdExlcGtkRmhXck5PYVJZVlpPUVk0?=
 =?utf-8?B?elFEMDNwSWNkeG1KcXB1Ulo1U1NjdFJ2dXRVUDNnRnl3R2FWRVlRT1lzT0kz?=
 =?utf-8?B?cS95Qjc3QVd6c25QZHk4SVc4a0kvcUFldkIxYkhhZFBTM0NXU3JSSlViMkRh?=
 =?utf-8?B?cVh6QzJGY21HMXJISHJxQ1dZQkxXS0tlOWxGWUJXc2FCcEV1UVdSdTdlaDIx?=
 =?utf-8?B?U2RIV3R2NXFETU82cnFRNHcrZGV3anZzRVJEczNqUmJ2WlRlRjBBM1QwT3Y4?=
 =?utf-8?B?RTdReUlTVjBDMTVieTkvR01IaFhTaStxWmFMMmRmV04vMm83TjVmanVTeDJq?=
 =?utf-8?B?V1hlRFRicnoxV3RsSFNvK0VwNkZ1Yk9aUnhyWlZVcDluS0NPRkRMeERQYWtM?=
 =?utf-8?B?UXMzYWJHY1ZuMDhxVDMwa3NRWUxINWRxTXpGRmNteWNWRFNDWXM5SUw4NGNW?=
 =?utf-8?B?bkVOZ0FGVDdkVEtHZDQ1eDhYbnVxSWJJUEFUU1pLZW9XNFJ5bTBDbWV6VEtU?=
 =?utf-8?B?ZTJqMFlvSUNMQTY2UG9pRk1sODgveTBHLzFoZGE2QThzbmNtR2d5WWdseXEz?=
 =?utf-8?B?NFRhaVBtcjRya09WZTJZcHFxQXhxMlord1hGZWFrZnNxbTZWbHZHZi94RnBZ?=
 =?utf-8?B?S3VYeHBNOUYxVzZJZnJPMS96YldKZ1hUZTlabXhmczBmWjM3d3k2OUE5dUFk?=
 =?utf-8?B?dGpOblkzZ3RMMFNiSVdTWU4yYnp5NlhMOWN4ZGJlVE14U3NITlc2OFlYY1NR?=
 =?utf-8?B?L3h0Z2tGT3Z1TURaenBkaGMwd3NXZTZFWVRhRzBtcXFJd0pPY0hIbkJKUVVH?=
 =?utf-8?B?LzZueXBMNHNtczY2NWgrd05JYUZ2eHpHbzJRN2pxS2dqWllIOXljU2ZiWGNl?=
 =?utf-8?B?TUZMZ2s0QlFoVDk2QW5XblhDSElyM2FHN25EOXpMZjVwZkpZN0VtZ2FrSnZ3?=
 =?utf-8?B?cUNWTFoxazV1ejgyc2crd3YvdHhFakc0TXA0RFJRK1M5MWtjRjhrd3lSbUdU?=
 =?utf-8?B?ZzN0Z0ZLNFVIOG9GT05uOE11amJQdEFmSW5VaGJsRDlSY3pab0FyWTJBME1i?=
 =?utf-8?B?MS9UUTY0Rzc1V1doYURsbGNyd1lTaElhWFBURHVCZEZIMzRhd2dBS242Vmdr?=
 =?utf-8?B?NnlxaTI0aURhZ1JsZ2tqOTZRdmlVTjRXYVdPQ0xJRXdTMUtPT3NvTk9hMkNz?=
 =?utf-8?B?UHZqTHluMHVBV2tIU3pwWjdSZ3V6VGRUNGNIakh4cjQ1OWFtTmc5TXdjMFc3?=
 =?utf-8?B?MzhPWHVEcUFmekxqR2lEV1kyMDFwVE8xbHVYNUhJNXFLK3NCdGo4SlU0V0xV?=
 =?utf-8?B?RkJKbm9lYldrTHRDY3JmaDc2endmd3lyUjdjNXdwLzFHTm9VRS9BblhHanBk?=
 =?utf-8?B?L1I3dDcvK09FYUlzMWpnYlVCVTJCbk43MUFpcXRlQnVDYXNjajI2RTVwM3A2?=
 =?utf-8?B?TzUvRW5FdUxpYVdpemJWOHE4cTlkNUxjWUcrQ0g5bytZb3hzeklSZjZ5Qnh6?=
 =?utf-8?B?TXNya0Zwbkg5K0VONDBRNE0weVI4cGNtRldybmpVY1g2bHlhM05obUtxTHFF?=
 =?utf-8?B?UW1Zd2t4QmRaNTA1WThiNjNoQ2dwNFJZTXdoZWw4QU1xa0RWUVJFVHl1OWhv?=
 =?utf-8?B?MmUzSDlmbE5tR3VvdVdLSzEyVDJwQjNlcVYxUkNaSS9oanBvQU5GeTFWUFZW?=
 =?utf-8?B?ZVdvbFQxeVY0RS9CQ2NRM0tYZjh6UXdrSVM5NGtmTXY1U25qanBxWDA3NFIx?=
 =?utf-8?B?VnNkZ1krNU9NRlVYUW96ZkpNekxaTlpiV2oxRytJTnVHenNaWXprcmREb3Rl?=
 =?utf-8?B?WjM0QzVibExZMHdRQlJvMEhCZXRSNTVIT0NHYnpBb1JoakxpSUpFdzY0WWpy?=
 =?utf-8?B?emI4dFQzZ0FtTnNadlVSdTNyOHE1Ym91ZzF4eldvKzhqRUIxakUyWmt0cHdv?=
 =?utf-8?B?MlgrcXl2VWY1UnRNQithVTh5cEdnQk44dFJRN1g2eWZadFE5R05EdDl0NE1r?=
 =?utf-8?B?TnR2amtvZDl3QWw5bXlsYmZXejVkWnRVQnJTS0syVS9pR1YzeUlOWHlaOVpy?=
 =?utf-8?B?anJFWjBVM1d6dEJxWEsxYnV0Nm81WjhubmtHd0ZOZUdWZEptWmlUUWxhU01M?=
 =?utf-8?B?VGZPL0pqdWxrM1JJYWp6T0NhcldLSzJFSFYxdndlazdYd3lYbDZ2NFF1SmVW?=
 =?utf-8?B?eGJKaE5ScFRlTDFVVElhbnRxNXpzUHpDT2xXa1JIeDRuYjBrQUFuQVg1MHNF?=
 =?utf-8?B?SWZnQnpDV29HbGxVelk2TVBObW5UMVZuZUVhdWplWlhlL3lJZ1JSSE8rbTBB?=
 =?utf-8?B?bHhwSjljbXMzRGRpcWRGSTlwTktkbHcyMWlhWHVLV05UY2UzbVhhc3FNZGR3?=
 =?utf-8?Q?jKs3DAKcXrPyam2g8ODCo0mMMaB7nXIOExmsmleOhoodo?=
X-MS-Exchange-AntiSpam-MessageData-1: MHrNUGRDERzIQw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ada62d-6f9a-4005-fd8a-08df1d554138
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 11:40:11.6426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EyTsFNjw9ihtPBaEfvd2K7TQd05sxBvMjLrMkxTQWyYPBd1JQX0DeEDkmmdAbiWlDYVXlqkJjIr6KEdk4gkZ3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568
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

On Mon Sep 28, 2026 at 6:20 PM JST, Zhi Wang wrote:
> On Sun, 27 Sep 2026 22:46:25 +0900
> Alexandre Courbot <acourbot@nvidia.com> wrote:
>
>> Move the types and code related to RPC commands into the
>> `rpc` sub-module, and update their users to reference them from their
>> new location.
>>=20
>> This is a pure move commit, with no functional change intended.
>>=20
>
> Hi Alex:
>
> What would be the plan for commands.rs in the future after the movement?
> I was adopting the similar code structures (fw.rs/command.rs) for vGPU
> manager's RPCs and GSP plugin RPCs, e.g. having RPC typed code and
> function handler(wrapper)s, it would be nice that I can align with the
> idea accordingly.

Can you point me to the the structure you have if it is posted? (sorry,
too many series in-flight and I cannot find where it is ^_^;)

If you add vGPU RPC commands then I guess somewhere like
`gsp/commands/rpc/vgpu.rs` would be a good place for them. But let's
wait until this series is approved before settling on a design - moving
code around is easy anyway.
