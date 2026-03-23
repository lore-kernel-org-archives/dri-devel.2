Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656B6D58CBB
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 01:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15F1610E171;
	Mon, 23 Mar 2026 01:08:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="oFcY9XtI";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012061.outbound.protection.outlook.com
 [40.107.200.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B112A10E171;
 Mon, 23 Mar 2026 01:08:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUYsUp2bNsnEUg0uhKRWH3uLxYk395n3/e53Tpdb8ElSwrHrYo/2GDvmwhsDOpzpbEdvPNwMxuRBwDuJUWyW1mMCheeWakMkLfaXELAlbOdNzw3U/QVBXWWs5QvDA0bT5S8LNnBhjCY+dc0yXQLeheeBvGcAevvk9PRkw1c0Zg1tpmZCzrWMCNOXD96KPQeuc0rQ53Tn6km1xN21J3tSPtAccxPEfL+AZYomc02gP7ESOTm/rQ3slKJ6uFBC4+uMYSWHlLlCmU8L+aYxNQTqZLyCvxBIXiOQLA5Diuz8vReJjIVJT+dvOOQAis87mtkP9VyKzI7vXnHi/2ZDUHvbjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsMzV3DG8cPswbkYgfnLLHAhLlxp9QxcZMEFgkoL1A8=;
 b=JF0VoG1OTCvPuZu1bf/Xz6XkaV5DUCwJUxQG6+MohQxIFAzUFOST4z2SIxTFavwBelvzXIH/ibkLVFppWb42vNzYOQVN+AmajQe0q3C4MAMGtZtrtPXm0tpHyUdjcutIeh0ObdAUqLckxUFv2jrZQw3ujYnqS+a2lWUbHO/M1tDBkVoZELfq1uldnW68pl0Rhi4fKd+6WXsoLFlv+vcbs/3fdvuSAWrmPZil2PF0bqtslnCjuOVt3vPvWoE+8OUVSSQ0pKlKu3Xjucc2REp6dyEQ+0eIunkuFoDsklEkSONehGL60Z/ltMqjs6bY+7YgnQpckp3qlor3R6ZFS+LA8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsMzV3DG8cPswbkYgfnLLHAhLlxp9QxcZMEFgkoL1A8=;
 b=oFcY9XtIJUpX4Jj6eblLR4tV5hLtqCK7eTsfgNoW9UIpL6zO9y8hyG2OX9rBAVmFsJ3FILUzd1KbkpSjPMlH2W1lnAqlehJhZn2YytVjSw3fjbExTGR+P9lfN8zTRNER0gUnXYskOw4eXKocZoRhb98lXJydaE4WrC2YwELBQJeJKx90cEeZyUxojk9SMG0aHTYT2MK8JSWnFEWNALhhy2cey/5ueazNxy31pHI54Gus13trLONGbxgg2nc/fggUUAie5WIeXMYHu0c61ejGEUfmhrxA4RI2XBVyxu1JYQCX9JIvrBoDxV9jMb4ib8Qu+BGcsufXaarw1lWsm0FGwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Mon, 23 Mar
 2026 01:08:28 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 01:08:23 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Mar 2026 10:08:18 +0900
Message-Id: <DH9RDC77E3NE.3F8BURMZ8INBX@nvidia.com>
Subject: Re: [PATCH v3 4/4] rust: make `build_assert` module the home of
 related macros
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "Gary Guo" <gary@garyguo.net>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Tamir
 Duberstein" <tamird@kernel.org>, "Andreas Hindborg"
 <a.hindborg@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "Yury Norov" <yury.norov@gmail.com>, "Will Deacon"
 <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Mark Rutland"
 <mark.rutland@arm.com>, "Ingo Molnar" <mingo@redhat.com>, "Waiman Long"
 <longman@redhat.com>, "Yury Norov" <ynorov@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <netdev@vger.kernel.org>
References: <20260319121653.2975748-1-gary@kernel.org>
 <20260319121653.2975748-5-gary@kernel.org>
 <CANiq72kZH-AX=QQz2V+qCfVzMsUEAPan=o1E=OZOAnivj3L3HQ@mail.gmail.com>
In-Reply-To: <CANiq72kZH-AX=QQz2V+qCfVzMsUEAPan=o1E=OZOAnivj3L3HQ@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0169.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c9e9a4-829d-42ad-776c-08de8878ae12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iuaQ0u/DzDtMzQ1aQaksoofdMuqoPkx2g/plQIurVAWum18lnMsBJJtq0BUoK3FFJrs764aAu5ObKWu0h55AofjX02a/fNsWW/y1Edi++bjVIPumKeOToCqhShplTp8VKImzBMnIz+6863mvYyJQC7uWi5IrcSikwctOsCpYhZ3FNp1rO9PY8N/Z2qnHmQ1DBH2X7m3DRL9lJqwh0zRnGz2vjjHuhMrIBgB1w0A1FDaopKWKUI0v290SrS00ZIt8vzDIKDGSqTgDlZvP9NyXBU+EP6dS10Gxfm4ivWTk6xnorenoaKztd5upHMz/oUL8b6s6yqC3LUrHTyMDA/ovn5EiZlZkCztiLbwLgoh1AH8ohu23Y9HmOc95qlQMc+kFmAfLE3s1GrgDKC/tbssv9Xbd4//KQ9qWV+IfbPsuWr006Q7eWvqS8P5kzbG3JK/fsQrcpUq50xvxDDODrdEVGNL/YwSWEdw/W26KhlvVKebumm/eYftPzZqQkD9hxahCKZMIWUzNWmEIuMn/FxSqpA1xQvtuUYKVG3uiIw3Slo32FhrBbs3OXrvGh6v7/CHFENG9WLP6OZuEiIiGYjOAJhuVbOi7dprjCS4i2eW/FlXLgbQwnxjr7BnSyc0eWy2GJT5CZsJMkfgQRrwW7evz8UR971R6KVHCEcBeIMKG7sgZWygA9pv5vZ4UBE2MFkwDB/sOii5s+iUwSpA1y9Ej4yn1UvjqHb2cyqY5TgDo/Tc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmpFZ3gwNEdJRVladjVwVVVNbU1SZzk1b3dGZXNIVC9zeEk3NjB6c1JxUUJt?=
 =?utf-8?B?UHhZcS9pb0htcnBHdlNPQzlIaktRV3BQdGNjVzN1RWFnandiTUxkNVpaWkhy?=
 =?utf-8?B?MVYzNE1oemlIdUNvb2NMaE5heG5mamR3VTJuSVhXZEQ5UUF3MkRzclJ5ZjJN?=
 =?utf-8?B?UmtWdjNpazUyZU90Y0dGM21NVkd5U3pCeFdBeC9TT1dYVnNQUW81eURmOU5Q?=
 =?utf-8?B?d0E4TFpzZGpMbW5lSi9YK0ZRcGd0SG82aGw1TGV4TExCWnhzWUtTZDE5NHNk?=
 =?utf-8?B?TlJmK3FUTEpuaDZlL1JJdkZCTzB2eG1yQ1JNUVljZFdzMWM3NnZPQW5xcGUz?=
 =?utf-8?B?OVVEOWQvd240czExekZ2NjBzbkNTQ1BDYXZQYm1TMUNMOTZocDBHdGpGclZJ?=
 =?utf-8?B?bGp0WnZlWFNUSUhXMHQzbDhUcG9seEJrTmVhTTJsdmowWUlWWGRjMFJXZ1Jj?=
 =?utf-8?B?ZjN5UmMxTk53Y3RSRjZlaHEzdTJpbXJuR0dwelREdEhQSStkTGF5a2lkVVJh?=
 =?utf-8?B?aWQzM1h5OE5ZWlJLZm5SQlN0YTh3NEUyUnlSSnNNbStOWlJyUjdMYU9RS0t2?=
 =?utf-8?B?MUw2QU5aaWUyT2xJTTM0YVlUeWhRWDYvMTVyMnYrOWUxc29nSWZLbFF3VXBR?=
 =?utf-8?B?enlrYVYzWW1jTVFPNnFZM0RpTG1rNTdXM2VEU0tHN0pJTEhxMkJqbERVd3E1?=
 =?utf-8?B?N2R6NDlKelg0N0JnTjRUanBmbG5ncG1QM0MrY1UrZERIMnNGNzdIUTFMYjVR?=
 =?utf-8?B?YXFrNUxJV1ZmS050aW9WZXFMWUdFSU1mWk16VlNGRGU3ODdiMDBpSjhpVk9H?=
 =?utf-8?B?bkV2SERxVHlyWjZpcStGbzVyZjAzVzI1OGwxR0VZNlpGS0o5UE1mQjlScGJL?=
 =?utf-8?B?QzFCbUxOKzZNNWhCWGdlSkV2WFpuMlBWZWFvNzRic3JFWHZHWXBBOEw4ZC83?=
 =?utf-8?B?SkxpWXYySHFqV3hmNUNLYnZkZTNibElSR1VuQWlDSC9NTlIyRmU4cXF6ZWZB?=
 =?utf-8?B?T3FEbHo5elZLL29HZzZRaVFuU0hqdEFRTERNaGsya2J6SmQ4QTNpT3JLTVFM?=
 =?utf-8?B?eitRMy9ON2wxaHlzL1ZBamFWWUFwQmxkYTdvamVFVm1pQ0dIRzVya1FpNStV?=
 =?utf-8?B?QW0zZG91SUdLWEN2akR5aVBGTWVjaVVVSGFwbG0yMFRkZ0RJNTM1dm5FbTY0?=
 =?utf-8?B?a1RzczdpQmJySGRsMklHMmIyS05ibU9pVTduTWl0czdiVTlaY3IweG1sanBG?=
 =?utf-8?B?WXFFU0N5NG5MT3FmczJMQkMrTWFOR1REWDVCQzBGcHd2LzlTZ1gyYnAxaDF0?=
 =?utf-8?B?UG9MLzlSMmVEZlpNQXN3ZnF5R0I1TzhDM2Evb3lsbkY0UU5LVHcvQnFYeC9F?=
 =?utf-8?B?c2hVWUdzNk02ME13QUwrMFQxcCtaSVN0MVg5M3NUQ1BNdTBQeHh3dExaRUpC?=
 =?utf-8?B?c0xTQ3ZlY254SlR5YkpBR3h6eVQvcUsyclptZ1NrMWc3WWxjWEpNdWJLcmVI?=
 =?utf-8?B?b3dMQzQwUE5xY25Bb3YwTFBQeUxzdm4rYjNiZWVMWkFTSHAxYmlsanR3MTV6?=
 =?utf-8?B?TG15RGtPVVd0R24vNnZJbFlPelVpSmN1MzIxUmhwbUNtMng4Z2NXNEI1bnlm?=
 =?utf-8?B?L0sybEhPSGRrdEhtSGtDdW1vbENndnNlMXQ2SkJINTRKMlZLQW9mL2NJSmhr?=
 =?utf-8?B?Tmtrb1hZd2tWRlRibjF4MDMzbGhqN0Npdk14am5RU3cybHRRZnFtM0JvbGxm?=
 =?utf-8?B?WUZlbUJpRStIRHI1QStFelZIc1l1RW1vNGhpL0tEN1BIQnh3RnlsUXJ0bU44?=
 =?utf-8?B?OVhnS1BwTFpEN1hOQjI0UDlVRXlYVUp0TGdHM2xCaTE4SHZmTU01Yi85dmJy?=
 =?utf-8?B?K2F6U3hRb3c0ajBPZ1gvYWdHclAzb0t6QUo1b01yTlU1MURhOFlyTUNjdW1x?=
 =?utf-8?B?dlJFUzgrVVJ0UnJ3RmRGYTdxYy9TVGFIZHA3bTB0eUVCUlpxaHNsK2ExQ2xL?=
 =?utf-8?B?Vjh4b1hOM0ZrN0o4RGxpektPcjhoM2xDOENFdE0rQkk0N2JxTWtGU3hSell5?=
 =?utf-8?B?WDlWYllpekZsN3djSUczTXBrd0JOZjdxakdkL3N2alhoaFR0MmNTSHNCY3Jo?=
 =?utf-8?B?ZjBTNzh5RDJHNGorZ0h3NUVtRDhHZmFtVHVjRy91Mko1c2w1cGhGNG1XQTVk?=
 =?utf-8?B?ZHhHNHFnV0JoaldwT2JpL01SWUl3STFLOVVjKzV6cG9VNHV4V0ljY1BJbHkw?=
 =?utf-8?B?cUhSdWs1WkphNHZQYTM2Y2R1SmlXVUMxQ1pZbE00WTh4QVVJVzI5OWFaZzZR?=
 =?utf-8?B?MFNITks4ZUdoblBkb3ZNWVhlQ1owR2haYVord3pFanV1QnFIRTNtMTJTcG9Q?=
 =?utf-8?Q?ZYKKVcDayirdgjWP2o74KlOH1C8dxlFi+LsWiQqMICoXz?=
X-MS-Exchange-AntiSpam-MessageData-1: N38irVZVO6Iy9w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c9e9a4-829d-42ad-776c-08de8878ae12
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 01:08:23.3943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4R9MskNz6Wwx0vFj3DU3+hBefOX0mgZmyT7v86sCC7ORiD+/i1AE+k/Yi5jjVsNtYsnbFAS49ZJOm2zjMf6znA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276
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

On Mon Mar 23, 2026 at 8:36 AM JST, Miguel Ojeda wrote:
>>  rust/kernel/num/bounded.rs           |  2 +-
>
> Alexandre: are you OK with these changes?

Acked-by: Alexandre Courbot <acourbot@nvidia.com>

(sorry, assumed my Reviewed-by carried an implicit ack as well)
