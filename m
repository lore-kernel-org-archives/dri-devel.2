Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12D7CD3423
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 15:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A89610E2B9;
	Sat,  2 May 2026 15:42:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="mG9/AIqF";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013045.outbound.protection.outlook.com
 [40.93.196.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2431610E2A0
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 15:42:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mawl59Lr4OUzENYW3ObB6ZURdghH7kE4cnikonDWVUhnZuUPFhSkdl51dLwvj5ariFWB46V2DFr5sChpDzZYW25tIMXKsz0uhV9FWMrTIzwwd+GzclTZ5qVMgqIn2aOKsuZMPO/A47pBNZ5aefgBoAgJczN86jvgga+hJxRfSgDwRKMpEe/zgtaGTgLbYuLcrBiOvL0VIvF8FCTi35y3XM9GR1NtQkAzPAi4Xi9RNT9PMMd4G9bxuCAzty21ox9F3j9OD1tCGXnVA70+RwuEI6W9JhlOG9YnePQ2UKC79VXaA6NOQLr10fyMwX40QrAihDwNcQfdEBWUt6WMMDxQoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GA8dlpKnsWPIP19mnpMMU1JrtSYA47hxaIz/J/Jz4Zg=;
 b=djFbXZ15RxpV8M8n/CM+qN+OKMGyI68gm5Uyy5LLnNVt14ymCXrLOMYouv/gtiDKPvMKODno2BrQQNTCcmS3GvSkCXlbebDcEUdHP68Y8VB0o83g2MyoI5pun5k3SRehAXVvZnouabO6gG/wkc2ScToWU8VyThm7EWyNhEp3QXDh76Hk8Y3R+RsSSD6bKzgEmdCsHS4Gllgx4gDjybkCUbymwefcuS0g4kqpW9blCuL0qCSTPxe0CPhPh2rA399unnkTsNM9kv7/r0xx2N7hph17ak+eQ3TkYi2DyYbS6RjCpGpz0JlJhc2cPb4ODJAT008B7Ot3WHxYow/lEV8hvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GA8dlpKnsWPIP19mnpMMU1JrtSYA47hxaIz/J/Jz4Zg=;
 b=mG9/AIqFtWiuUJ22KyYne7qpeLzlu3AQTgEmluZBktqnAMc7G/De76COKD+L+uXhkmXkuPkpNEa6TofWdM8wru2lj+dfSUOjW5IhSOXbJqRyuooQCNntESIMgUXnoMS5xZ0mBM61bRJetX0sv4I1IDr7624HQDS2zuhbGcINcJX8qyO7sMmi6+rQwMpNSeWFeI3y1ElrCwH1j3hz8pcKoYhcumRi4GEhdOrMQcmevxqwHKdZruEnXYQqG6G8SzmBnRDATItjNtCiI6AUU1YIYOIsXVOy7iXbk/7YIqp050BMTzAygLWrdAAQl0ZJ5ynpIegHWOWNAOERPga8MpKW7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Sat, 2 May
 2026 15:42:51 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 15:42:51 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 03 May 2026 00:42:47 +0900
Message-Id: <DI8B0OTV3O0Q.268XADNUSZW7P@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Bjorn Roy
 Baron" <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Dave Airlie" <airlied@redhat.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>, "Nikola
 Djukic" <ndjukic@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Edwin Peer" <epeer@nvidia.com>, "Andrea Righi" <arighi@nvidia.com>, "Andy
 Ritger" <aritger@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Balbir Singh"
 <balbirs@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>,
 <alexeyi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <joel@joelfernandes.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v12 21/22] gpu: nova-core: mm: pramin: drop useless
 as_ref() in run_self_test
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-22-joelagnelf@nvidia.com>
In-Reply-To: <20260425211454.174696-22-joelagnelf@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0077.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: 53bee376-6da6-477c-218b-08dea861782f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qmMp65Nw5DihsaFJzaw3uoJVf2a4conK7kI66lqgkxnQHDq1ANvcLFxNaElKVqzgbBod2A8MrSZ00jATqauW/zjfMuPfokMwDTas2sQHlMrBKEdY/SXgkcNWZhwPj+Eomifcm5EAsbVHsNS3h9qXGkki+r9NWCAhCBMhauUB+GfLz23nugaIgHDdLHKrnSjTdrvhUDRXhTxI68Q1VQpP4EWQCHoiW1tvEr7vCk4WSanA2sazDCt6i99lsLVW9va/zpmdugaiKd0N64aa4o9xKA4CoCjdm/pD8kbWabBctM/hIoWaxpXN4veErtHquI61bFvzleBsoaOtuKHRaldPOfNWUS5NfbkVqeZXC/kf/lCZgKneWdUy/WCUB0DrBDFOuHTjfDibtoerS470o9XRlVThz4agP8i83Ae6S5CM62Z2xktD36o8F89aNbsDeAAqq7td5sGwhd4dsskxPT4u4hcg6GzakFwRD6yeBmj4y5VMLw0WA3KHiSvvXQszyE3w2mAmXp5qZMiptdVPng+J1OlQ/1MqB6agCsZHYQZuSVc+iG/SBT7YwA+erFLuL3ZKx0/dGQOfmjGbDEHjpqfycwCUX2tWdM4pc+07Wq1uJt8KGDGZtr/ChkzaAUsRagpKG15fH4qE1Gv6/5StrRQd2gKgPRWGbvaeK4rZjy06fYLQvKxpyQZU108nYpKsEm2M
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTZrL3FLeUcrTGxoNmhBSU9jcXlUVG9WRmtNTUZOYnEwMWFRZkV0cVZwTTk0?=
 =?utf-8?B?V0RXNzBvWWdxUXBudXd1bVpUeklpUTkxZjhFYUk1YUlRdGJoekNTNGRFRTk5?=
 =?utf-8?B?MFFCWFdiVW11WUZ6QzFSQkRjRXdaekN3aytoMWE1SEU3TWJqM2Z0Wjc1aTBE?=
 =?utf-8?B?ZFVUaVF2RWZhVXFSdzNqRERDSnVrdC82d24yblJvNVVOZkpQcFE4dC9Fakpz?=
 =?utf-8?B?YjdKblNMbnByY2puejlUTTk0clFSR0Q1ZmJvVEpta2lkOG5tTFZKTUxoSjRB?=
 =?utf-8?B?b0prUnVTbnY0b0VzZXFkaVl5MWNNc012SXhjOXBCbEFUN0ZlcHdKVTR6NkMz?=
 =?utf-8?B?UGxtTHkvQXczVU1uUi8yeDZBaFZzYTBrUVhoWTlOZUNxYkMxRCtqS3dxNnMz?=
 =?utf-8?B?SWhoNUhRWkoxNVBrOURqN1ZFK00wTlgyRXYraFRQcnRUT3NSaDFiK3ozeDAx?=
 =?utf-8?B?RnpZTlllcDFkM01xcGxYYXBSQWh2WjA5ZmNHNlpJaithdm9DUjd1TUlDc3hT?=
 =?utf-8?B?UlEyN2JlcXZ6ZmUwckVRZklxZEJTbG5ObHhNcWs4dXpXSlNIRzVzS3BCaWRT?=
 =?utf-8?B?Y0RVZWF0RzJJYmx6UlI1MXRBSkIxRU1ETkQ5b2lYbnNSMnRjUSt3TXk1ejVE?=
 =?utf-8?B?NFNudnNYL3hpWDBzY0wreTVmV1ZxeU5LZ05Idk14bjZpcW9IQ0tsSVdOdERK?=
 =?utf-8?B?RS9ZUEZIZWYyZTdTa3h3ZkFhNUpKeldDQVJHU2c4RVBMMVRhTVlRY1dpRmJT?=
 =?utf-8?B?d1RwOGNKYnJEWjUzUGJ2d2hoT054dWtLV1lGTEc2Tm5rK2VaMTV2M0FWWkJl?=
 =?utf-8?B?alZPaS9NbE5TbmZUVENKcTlqQXhlYkpXUXVveDd2S2VHOVFDY0RkZ2crZm9O?=
 =?utf-8?B?V1YrbHNzWllzeEdLTUp0TnpHa1VjcUZhelBCSUkyN1c1QTdQT0xYYXdVekRC?=
 =?utf-8?B?QktMRVo4dG1wUzU0VGVDWXV0Z1J0cEZXSnhqR1RlNTB3aUVyVEsxVWtHbzJs?=
 =?utf-8?B?U2o5ZEtLSE11eEFNVll5WHZ3SEdzZ2N5SzdwZUtsSVV3QytQUXdYQmh1MU10?=
 =?utf-8?B?ZURNczNNeDEybXdkNDdmbm5hSDd5dlE2MjJhbFoyb29va1RtbytISkNoaWpL?=
 =?utf-8?B?SEFwT2tSb1l3SGczdEFIeklLV0pCRkYwN2JGdWJScG8xUGloTVFFcHNYV0Jn?=
 =?utf-8?B?TzlhZUllcDRPc1UxZmR2cy81N0ltRlhrcDN6NkVKTDZwam5pNmQ4NmVZSWFX?=
 =?utf-8?B?cFBuSG1zV2hNOUhibDlBT2NVYkpjbDkrWmFTK3VnOWlQaUFvSXQvc2ZzNzhk?=
 =?utf-8?B?YTZpQjBMUEFjZmRjMENsdlV1ZFd0cVRnYThadXBFLzMvQWczNEZGTEU1RXdh?=
 =?utf-8?B?RmtjazMvczFYMmlYQ3RZUWM3Y0NETUNsK0tMd3ZpTFFrSlJxdVhFVGZWaTdw?=
 =?utf-8?B?OVFVMWQ0NW1lNzdqK2dRckhxaEQ0cHp1VllKSjJvaGtlNGRtUVhxT1ovc2I4?=
 =?utf-8?B?dFh1SDJoK3UrSHpMTTA5V1dta0tWVU5pZkJ0ckZtOGpBMlB0Nk9OcVpzc0lX?=
 =?utf-8?B?dUlUMVQxM2lwMzBLUDVSbnRnY0Y5R1BiNHJYTXUrRjByVGJhUXZGYklEajdF?=
 =?utf-8?B?dVlBVVJPQkxlWVowY2ZTVFJVUVpEYk4zazhuelp2S1FxVEN0d25SNDZ3QWN5?=
 =?utf-8?B?aHpXektpNlpkeFZSODRJTi9sb2RyTHBpVHBYQ1ZHMjRpdHBvMFZhQytQUXBi?=
 =?utf-8?B?b1BsU3VDUEI5RjVjNUJsMWVEdUVLR3dzVmwwZzJFMW5ZYURNelpUWVgyNkM0?=
 =?utf-8?B?VUxkUS9HeFAyT2t1blAvVWgvUE1UQTlNQnF3blF5Tmx6ODVZeTg4dXBVMDZ3?=
 =?utf-8?B?YUN2cUlzdExCc2NNNnladWRyUUE5VzhYMmZKQnF3eEdrWU4vZndQVDJ1RmdN?=
 =?utf-8?B?OS9CamxIUGVrdC9aVVl4ckVJZ0svYUxGQUc1VDZHRG52UG44Q253bGlqMm1R?=
 =?utf-8?B?V2ptU3JFZGxxdTducDd0U3pMTWphYWdnUmJvazQ3b2E2KzhiWGhwdG5VOU4z?=
 =?utf-8?B?eER0b0tLN3VIa1d2NEEvWHo1SGUzTm4ySTBWSThacnliT3c4RzhWb0Qya0p5?=
 =?utf-8?B?SWdDYTc0aEE5ZTAzbXJ1K3ZrZnhBRDNHT0x2bG1kN1EvR2ZjREZwTkJxZkRv?=
 =?utf-8?B?UUhSaTdmejhMK1VpSnZzcjEzbDZQam9MMER2cDhOc2dYMnViSHJLOGlYcDNC?=
 =?utf-8?B?WTdaSjhtYlZaMUk4R0VjQndsS2w0dDJpdlYvcEhFZzFQajRobGRnYVErMTlD?=
 =?utf-8?B?cTBrWW9kMk5iaytaRnRlR0txcWRCd2pmMFQyVjhlUkJQZ1cyYlRGRmpueExk?=
 =?utf-8?Q?qz2vOZYhqUi9ehSg39qTA8FuebRQud8bJyVJvLseLvahj?=
X-MS-Exchange-AntiSpam-MessageData-1: LIaXcBEFeRuvzw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53bee376-6da6-477c-218b-08dea861782f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 15:42:51.6408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhQUXFIUEK0662wkYVmJh4V4U1W6vkENrkiKVcn5uh2U0Gnod4F4O9HIO0TZOMH5lV5Akm455+bwNhNq6Jb4Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9591
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

On Sun Apr 26, 2026 at 6:14 AM JST, Joel Fernandes wrote:
> `pdev` is already `&device::Device<device::Bound>`, so calling `.as_ref()=
`
> on it just returns the same reference. Bind `dev` to `pdev` directly to
> silence the `clippy::useless_asref` warning.

Why is this a separate commit? It can, and should, be squashed into the
previous patch.
