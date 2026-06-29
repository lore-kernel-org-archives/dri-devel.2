Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE01C43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23D3D10E6FF;
	Mon, 29 Jun 2026 07:52:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="D0Mqw1Uu";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010006.outbound.protection.outlook.com
 [52.101.193.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B81E10E6FF
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/WpNaKnszQqwrBxb0KCEGaKF6oenSYE+9Lgz4FfLyMn9ZJvgc+k5EObrG8r1Ie1T8PlFZRBtqre8K/mJsaSvNt2lirK5yif/PnTG7Yw/VlTV978Pxulry8tf8Vpsi60HiW6W4RUJvEwXtf4BSfRwhhxwCxqASfFpnvhtM0Fa3Al/A4CHIKF8wMIDnoT79cErdh/+f6S8ITpc82VJ/FpVFTuf5umbXOIz9bpgFmTvUcTNLmjaKzjtDANq1rb80mxMi/dGBVwIB4HdcLMR8APlfbgh9Ro2ypJex3gdDq2IxX31/BdLQg1bXtJUXTXDmmttY0iMLkjhZgQ4hDBMopLrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ut05uJwjG6pwYJr551poOO6C4Kw372iPr7vkm/31jWg=;
 b=knqN0h1Dax3f+WcEOk4ZVxdpvydQUr9ggHOqaTDgGLv7EGxmlvMVOAHOy+UtdBF2FcDiqCcu0tHjgZ86OAD2ZFMpexheovxNqQxKt/PcNMkVZWgA6hbDyWe/eQuQ+Lk25YUiNbkymKRBY191Yai/0T/QL1JsUKQ/6Vx/FSAvrmG7W3vE4dXweFbCN9KTLOx5GKzAY/D0okLx4wMNEIpJuSO2iHqZuGNIX49l/pc8+6zPWeh23vtf3x5olV/EYe5IWEIE3eeuiyjQQJW263/9cBMlVmm/k2K349P10kzBcHToH08wajHdcQ/eobsNFOs/E8Rjeqw7/oca+mguh4oGGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ut05uJwjG6pwYJr551poOO6C4Kw372iPr7vkm/31jWg=;
 b=D0Mqw1Uu5yIEZoxvC1gFDG0zqo66vrmZ3tuiVuY//Amp5p+T8veCEiXUmFduj2Q6z4rpur1WZ2YT5AvYBXzI+NPThpwHxp4yBfBhyQwVN+gIVTCYpgwGiLr4T3RMiIjrYIr8DsevbxSTU0d0y2pg8req/Fo9gReY9YQih13D1dciics1IW4tAHIQYBAc/gGsPwhBaZDJe1cYp38odW+WUjs15p6niEFaZY9EtqCbogKOL4cSccagelF3Oz1LrIN6K48OzwVWRwe42RPu8xnGkEVSk88SK+68okmfSLCPyDhB7uqDFP4nFd1cJMwO7doQAPEQYdX8CbN+LeTyn5qJpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 07:52:44 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 07:52:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 16:52:39 +0900
Message-Id: <DJLDCBSH5GKK.3RFXVC3US9GJ6@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 13/13] gpu: nova-core: store Fsp instance in Gpu
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>
References: <20260622-nova-bootcontext-v2-0-0ddeafc06f5d@nvidia.com>
 <20260622-nova-bootcontext-v2-13-0ddeafc06f5d@nvidia.com>
 <5022f3d8-288c-4732-8f66-c38af5d90801@nvidia.com>
In-Reply-To: <5022f3d8-288c-4732-8f66-c38af5d90801@nvidia.com>
X-ClientProxiedBy: OSTPR01CA0009.jpnprd01.prod.outlook.com
 (2603:1096:604:220::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 5654a4b3-799e-45d4-eec3-08ded5b36710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10070799003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: dyISX3LkVz/LqSln13XsEK3bsVShmnBnj02gIcY/XEl/4cLR2JwJvf4BHWAlf1zImY6hkxUNi2CiWxg4iodbdXJp0+rbYvwZ5co7pV8urE9qsVITZhtA9TGOVv5kwXgrBvxW5HpjVn3wb4LEOm25TrtS7v8Vg8DF219niT/X4HUZGSBqDRDM1v9RQzPX315AGyLNN/zM2Ytu2uZTflyxWvwQ+1zgznVcINdVDD1zSrvGA19ViGegOyI6m9J20XWjW+/vxC4uZZuri7a0QLBlIA0ZJzibuXqZBToX4GNNYqcfFs5YJr6+YmC8kPLYKcjkC7Z/J++nx66nQqeM4Qgj8G0Q2yLkmUqQK3E3M3aGRolxLJkbHO6x1ptjI3I/JkYjDg8/yAgBO0itCp3OZExg8EvJyB/o1v27KnnaXUffEMIg1JfJo1O04YNUZksCRZWnziNxU2wvvsDnFBCDYXGmkoLvz3xbfPm+zcZu4rKsMZq4xg7P5dfsiBremHIorAV0TlS+Ru5GOP1wuQcbhRFujCYtoYqOAjlsoMTZUWOdmpaDry5OjK7oxLjV61ia9LLuAJuGa+dlAuxvhtzzLTIPa2kgcIsNALauP8yz+9nuQzhLZklKiWstRdD6WbOPb566i3L6KSAi7GtRtMKzC4e8C8/ku9EP/OvZvOkEGGFC97s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10070799003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekhFUXZRL0JqbHV4ZllhVzE1VUo4ZExtZkZZcjlsY0cySE9jQnJ5VkN1bE83?=
 =?utf-8?B?N2ZySmtBNVpsTlJMTDI1aml3eE1NUWh6UUtCT2YzTjh1ZFQwdUpjc1krSC9l?=
 =?utf-8?B?MmRlSCt4b3kzMmxFb0c4UG9hRmFRc0g1UWErQXNrajh2UHRhZ2Q4bVBybHBz?=
 =?utf-8?B?SmU3TVQrait0VnloS0VjU0MzaXhwT3NtK04yVHdMdEllYy90NVV3Qy9GWEVl?=
 =?utf-8?B?L1Z4MUF5dlZaczZrY1NpQnh5N2NLZzdQckV1QkQ2ZGp5d2R3VXRkWG8zRXEr?=
 =?utf-8?B?NURIL2R1d1drSFdIVUkxU2hXWmpUY1FFRmNQVjQ4ZENwbHFuK0gwWkdSTGJO?=
 =?utf-8?B?R1Z1NXlFRUhoVkN5TG9RMlFKTTJuNXpVaHJoU2xEUDFWVmJ3b3NXM3NaQzRC?=
 =?utf-8?B?bmNDQTkzbC9TS3Z4SDlRWHJIV2QwQWpua1JVRno0RCt4LzJqbFZLYmJneVVD?=
 =?utf-8?B?Q2s1c3FET0l6ZVBGbEdTRUhQcnVvbGhYb0NadlR5eEd4eXZ4dTVtY0Vycnhq?=
 =?utf-8?B?ZmtWbmpVajZaZGhuRk4yL21qamlNOHF2Y09LNnBYZHVMUitJNmY4QkhoZjEz?=
 =?utf-8?B?TTI3QmZLaDROYkV3TlZ5R3FPTVBTZDY3dHdKbm5qSCtWNko4V1dKM0VsaUx5?=
 =?utf-8?B?Y2VaRXhUNGlBN0lqaEJSc1ZWcEdVajFnUGVSdXY1a1hOb0pzaXlFajd1T3FR?=
 =?utf-8?B?elJCQnhCaWt4TTlIUnRsYWJ1OS85ZDRaUzNJamdZMnpPRzA4R3FkdzkzR21N?=
 =?utf-8?B?NVZ3R0VLMkFrMHlQR1JjdkpEaEVadnhneWREdi9wYmpMcWY5KzRIdGRYN1Zv?=
 =?utf-8?B?c0VxUHVmSVQ1WjVTSWJPTldIeDVCYjJ0aXNEQ0lHMWdSY3pmN0hBZld2dkJV?=
 =?utf-8?B?TURQakpVOGxHSm1ZSytYMTdOMU93eGZFWUdTMFI4c29hK0VPeGZSTE1Pazhz?=
 =?utf-8?B?dHVHRm9vbEJnTkxuaERNd2RrV3lXd01FcGtEM09ac01QQ0RuSlNZOEJtN1A0?=
 =?utf-8?B?UVNucHNZRHBGRzdhWU1EdzRUZE9mb29pd3ordlFjN0czcFJhRlhncDkzSlpz?=
 =?utf-8?B?TjFMS1RTSk1Kdy8yQnZtdXhjNzhzTnQ2T1YraG5IUWNlNWtnZWxoZzd3aFA3?=
 =?utf-8?B?UGdIVUNQRHZFTlRYTmRaWDVXbzhFcEtjajZYK2NGKzZLR3lKd1VkWjlFdDla?=
 =?utf-8?B?OTM1K0NLT2RBVUJvM2xOYWFTcEpKUjgxc0RIRFlvVjVqazBKV2hjbFAxT2Q2?=
 =?utf-8?B?YURCbW50bU12Z2Rtb3diRWJQbzFtRXI3d0NnYmVHZElkRVNyOWw0SHJxQjl0?=
 =?utf-8?B?cS9GSkZlTFZRclJDVVB4L0ovSnpTdHpjVGMwZnhNRk1nNjZmUVBQV0dyQmpj?=
 =?utf-8?B?b0lmZkY0R0JQNlBGT3dNMWhoZUVFWHJGVkg1Q05rWS95a0RzT0JhdHBVZzJz?=
 =?utf-8?B?ekwwODNHeDJQKzNNcUVLeXpFREtGa3FaVFpxQWZmOFNZTGd6Y3M0L2JiOWVm?=
 =?utf-8?B?SkUxbFZxTUpZV2J0alAzb25XZHZXNS9QYTZwUVBxRjN4WjFIRWhTQW92TE43?=
 =?utf-8?B?aDAzME8rNjM1WWtFZno5Rk1ERXFOQTJaSXVPd1FKL3JEMThFdGdWbG80QzZJ?=
 =?utf-8?B?WExRRTdoTE9TNWFtOThCY1R5RHF4dkZRRjVTTUhKNlVXQ1l0Z2Y1UTgrNGtY?=
 =?utf-8?B?TnZtQ1lTZ2I4N2diY3RPcGgzMzdhS1Rwbkk4T0xlWDI5a1RXSUxHWmRaNXV4?=
 =?utf-8?B?OGs1T1VnTkduVUNEK2pVdG1pTHNoSGZ6NFdtYlFuMWZwWGZSeXo0M3pxSVZz?=
 =?utf-8?B?MUxkR1JabUlFT2xkMUxtNkNzejRsU1M0SExQeUY3bFFYbWZOQTJGaStuR1dY?=
 =?utf-8?B?ZjM0ZFFLd29kK2RRRDMrRnIybm1RZEgwYXRoZ0hXRE4vQ24vMVZuU0hEUm50?=
 =?utf-8?B?Q3dSSFB6NEhNdFhHUXlXUmZwK0pXUDkzcHhzalNsNHRvYjB6cWVNLzB6anBz?=
 =?utf-8?B?RWRZUmFtemdlQWhrSGprZlNYUjN0VXVyRFk2eXdTWllXVjVDZnJLbG5XQVpt?=
 =?utf-8?B?YzJxT2dXck93NDR3R2pNRTVsRzdKUncveU1WWnlkSXREQnVFMS9TMzY4b0tD?=
 =?utf-8?B?bUlWTUJRQklxUjdCTlhHRFhERHFzUmpIenY5bE85UmNkeTBUaUNmODh4TDZ5?=
 =?utf-8?B?NnNCSXhtc08xck9hcC9IMDNNSHp6b1dZVmJBb1RQeE42eURrSzczci9tTFVX?=
 =?utf-8?B?dzBBa2lYcHpDWFJDdFh1M0lJYWFpeXVTdElwb2JXTVNtS1FTcFJDNFFleTNS?=
 =?utf-8?B?eWgyZGNicWJ2YW12VUl2cHU3YnFaQTFzTWVsVFN1NEUzZDFndWg5ejErOU1i?=
 =?utf-8?Q?OIT7cJMhG5U6iCBcf3Uqr/ikMHS0rjub+GoXTJ3rAs2zC?=
X-MS-Exchange-AntiSpam-MessageData-1: r9XOo8fibt5/oA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5654a4b3-799e-45d4-eec3-08ded5b36710
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 07:52:44.0314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUbAV9/PLd33zD1mLDOWbH0e7xRoesvXjRM3/smjyf3FGTSlif0qHwQplFt6YRBmUSd8sXb87ZlZnwbiLWjzdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075
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

On Tue Jun 23, 2026 at 7:28 AM JST, John Hubbard wrote:
> On 6/22/26 12:10 AM, Alexandre Courbot wrote:
>> The `Fsp` instance was only used in the Hopper+ boot path, and
>> consequently built locally (and immediately dropped) in it.
>>=20
>> This worked well as a temporary measure, but the FSP is also needed in
>> other parts of the driver, for instance vGPU.
>
> Or: "will be needed, in future patchsets", but not in this one. May I
> suggest that we put this patch in one of those future patchsets,
> instead of trying to do it here, in advance of anything using
> it?

So we have two patchsets (from Zhi and Eliot) that eventually depend on
this, and I am not sure which one would take this patch. :)

Besides, I'd argue that this change also stands on its own; FSP is a
sub-device of the GPU, we ephemerally instanciated it in the GH100 HAL
because that's where we needed it, but from an architectural perspective
its scope should be larger.
