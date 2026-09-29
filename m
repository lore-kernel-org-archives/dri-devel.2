Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E77CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE9510EF27;
	Tue, 29 Sep 2026 14:42:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DhLhMNXL";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012053.outbound.protection.outlook.com
 [40.107.200.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A930010EF27
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 14:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcmdD5iTunAhQuOwu3m12USo+2Ev0JW/J4DSQfLiSV//8eibrs+EWmD6KU/QUzM2PtsSlKI1zuTcdwzLm1VGxhpgwBY311SgblrWlgmJ9x99tWoSoVU9DeVUrYjIERZhyVjuMp71hVlOHNG0Apbo0WG65OiNSJIGkR+BEXDHec4FbEcLYFIY+CKo2CA12kn8iX3hPdGqH5XMkv8Q937c/gIjH53763c/IsBpWcwCI/O5TbiVN2xFlPF7vh2D9wA41+REijDX136iE16GXiuNuV9R9eJrJ2vkVQA8+M/cTB9Q+qXT0xcbjs+VzvZmxRNQSxAAiyhBeXGI/wctwCPqgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4aL6GbJ9FiMExmgue30oCHr4+UQLRVfMHX4WMvdwNk=;
 b=sMRxKUDhFtEbFJ3huBqsKSlI7UvS5M3tvpgAGiV5/IXvXb04d6tRQE2At606n6OrS8QtQZgygQ8eU/eBpwz/2HxtP1OzxQpMQHOsU5xFn6DVkKPrthQb9il/kYk0LAGa9uI7nJt68+vI7E3lmdR01bYBaJyQbqOd+gU9I2QuZIp3fEtViBd0yFJxshKlNphDt1FAjTrRDgzK5vG2R4nea07TEibgomzjeGEA+sqcNe5URx/53n/M378t86yPVJEOyPqpgQjm6ioLqtyrvcDNx53T7XHKxkpMD69WQwEt7lJ82wX8xWAR4IizOxerLfmmGT4ObLwVxlhqK+sB0uGoxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4aL6GbJ9FiMExmgue30oCHr4+UQLRVfMHX4WMvdwNk=;
 b=DhLhMNXLlI8Xq1e3JJvzqJZsXP4xMozlLs7pifJP6iGgjgn+6eJK+UZPU3QOs2pwu0uJXefNlYWbFc8z333xk8xOjlkwvmWd4Fys3JTyYhb/gQAZaSxvCZKCqtkhWGunJvtkI17WNT/mp7YEEVDYFD4AHM6ihIAu4+aJxmP2BuSyvX9dWu/R30Yz0jBAv3VUh+0CPw/a9jLHkvQDBtGSKzA5ShBPtHvmF9lgdHxK12v0OPXmtPpuoIYKBNd5eCFuqV9RGrVOT7P+Xh8zwbDSeW19Nm4xOma2hZZGfD9JupjJUhVAj1uj03h2TyZ9ybG83nT6nWHoM2vdJmicw8pEHA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 14:40:26 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 14:40:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 23:40:22 +0900
Message-Id: <DLRVMM6HVO54.NV3FUAYPC7UU@nvidia.com>
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
 <20260928122015.3df66b3e@inno-dell> <DLQX62L47S38.1D5416RRETLY3@nvidia.com>
 <20260928181106.06eca8fc@inno-dell>
In-Reply-To: <20260928181106.06eca8fc@inno-dell>
X-ClientProxiedBy: TY4P301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::7) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CH3PR12MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b5581d-4f8b-46b9-d0a3-08df1e37994d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|10070799003|366016|23010399003|22082099003|18002099003|3023799007|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: Vq115iPDGFf9oT8nriYZToncQaIah5wf01m4LRuNzy8ur85RVX54gnotZ/t6seHmw0mfikl6/xeslm5Bz43Tynl2vxhQ5n+C4WQTA134ABrQmDNuvv9ulIVyu2sD+LEO6fbiUUHJioJTsyjDtns4ssmqQp2LbGyZKzag1nBmw7jOwSKj61tUYaTnEvIJwj30Kbt98uH31lashWjf+AuoaxvpAdRYLn4/Buk+IGn7bJxEvEQbXJLnxARo1laqHxiW6Vcy6wdqJD6/7XP5j6+A/KlxOYTtL1SOrSUpQ2k40ZycBlBA4+nQtOgn6Ra3vt6xwrxoZDSESQEh1Oa8wT9dXGymAyhjgnuGvWTAFNkqNEDwmd3i6paNcwIBZmkQm/wuKztk7qaptLSwB5c+F8Z9ej+VuOc62mWbcpz/yyv0C41vNSx9tc2o+7D0WrGIUtGfX83LVR76cMlgdpG3ew5tN7R1JkaesniwRUkRs3pnrNIRkE0A9FaP+C2oFDe+v4FYQ2aRmwk3DN7sI9WMWGisum4gCO7q0fmVrgPf1lM2rmX9QVdLd6FSU8qK9adwIDp0lUQhadHtN1aoDrv71/MD1CMFfMtJ1j6vgjzkApan2XHk3XmMn9gHyONi2ZJqUqS0tt/lqJABL9ISViX40wxdWMcwaYxOTN2oG0uW6MYL8G8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(23010399003)(22082099003)(18002099003)(3023799007)(56012099006)(10067099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWF5L28zWGtEMjZtajhCWFgrbTlOMlFCbTU0MDdNa1NiTGRHUFRNd0xwR3Mv?=
 =?utf-8?B?Z1Z2RDZjTnYzdGNpTzVad3ZBdGlUSVBJMjlEWmdtS0liZ3ZZdGV1cmE3K05I?=
 =?utf-8?B?a1JMMnhFeE1nV1VUSXFXM0lJNzlhaTZFeDlPZldnT1k0d1p5VlJCeitjVWY4?=
 =?utf-8?B?QW1FMmJObHBQYmVQUHM2YU42UnBqTzkrZ2dRRDF2L1dEbUtVZFl2U3hPUzEy?=
 =?utf-8?B?djRwNzVEd2lWTS9FM1lma0IwemRwS3ZOOGxTRVpqMXpQRVdPRGZTMmRzZjJx?=
 =?utf-8?B?ZllpODdVbnpPUTBBVXh2QWZMdEVoaXdOKzQwbUkvb25xVlNPZFJDVFJ5N2R1?=
 =?utf-8?B?djBnNHhXYWxQSk1ucDdmS2VPVXBTNXcrajh1ZW5NSGUzVFNDc2FhajlNNmZK?=
 =?utf-8?B?V0RtZ0tQY1dHNkFuRVp4Y0VuV2x1Q2RFQnE0TFRnR291NytoUGowWlhJKytY?=
 =?utf-8?B?aWZ4TElJNDYvQjlxdjd0YVE3YVZWVU1oVFN3Vk92aGx5OU1IajVPaExEN3By?=
 =?utf-8?B?THpTa0EwWWdZUkpFbWdlTmd4cXc3WFd2aCtyUTU4TzBuRVNwMmRiQ0ZWR2s0?=
 =?utf-8?B?ZU5UUFFPTTlRd3RkbTB1WlVpSXRHbDJyaEEzVHlYQWFKMStMOUJ4NFhseHNO?=
 =?utf-8?B?Q3Y3dHJHdnB3OXQwUkZZVjFuVVEycXVuclhkYk9PYW5IUHNhSzM0K3U2Vzkv?=
 =?utf-8?B?RFIzS3k3ODIwZkVOSWhlUUJrdm0vOWJ6OU5OR2RMUERKR0lXcUIxaEY2MVB0?=
 =?utf-8?B?ZEpha3lhcnFJMEpBSWlyNE1NSUkwZWVXOHRhUWxaMlJVMENVM0lZWHVuUFd6?=
 =?utf-8?B?eDNwYUpkU2UrWVM0QS9EdXA2YS9kVlJYbGRSYjg2YVhJNjJGNmhWR0xtTVBl?=
 =?utf-8?B?U3hWeTFJR3RmM1hQMWdDMTY5TjhJNWtHc3hzY09LaWNRbDcwSHlaUTJzY2sr?=
 =?utf-8?B?OHl6S0NzYk1HSzdIZHk3Q1JTb0Z2eVNxTklxS0NvNDlNS0puWGxBb3FTcThP?=
 =?utf-8?B?VUhtb1NBWHRrQm5Lc2hKVmo3TXlWczg2eElFdGNUeTg4T1kvNllQendaalVP?=
 =?utf-8?B?M0phNkp1ZVlIbkp6anc1d3ZVOHQvS0IzY0lET1g2S3J0QVc5M3loQkVCMEJI?=
 =?utf-8?B?SzhpQkpadlBna1psdURBTHRCZFBUOWY0UHhxMTdleFlrcitHTEhZcEF1NTZw?=
 =?utf-8?B?bkpkQnp2VGlvcE1NVmlwbVUzM0lwV0ozdDA0SVVxSStVbWNndnpnNW56UUdp?=
 =?utf-8?B?S1RTQmF6SjdBVU9Ecmp5ejg1M2pVVmRWMTV0aWlnYWhndElNeUJXTTJ4TnBn?=
 =?utf-8?B?ZVFUbWREMUc4YW9NWEptN1JmNVJYQnVDN3JaQ0FrZ0E3TlZSdU5FL0pUdWxX?=
 =?utf-8?B?dHVKZ3JUSFR1SjhKb1o1aUxWNTZwUmk0QVhtRlV2Y2lURVErbnRJVDJHTDFR?=
 =?utf-8?B?Zlc4OFhNVFVVdzVySHRtZHg5R2RvcEwzWVA3VXZ0TENxTEsycEp5aHJydWx0?=
 =?utf-8?B?UnU5dXlQTHJZWG4zVTF5VFdWa2VLWXgydzNLN3llcGUwaW1WM0tmU0JVVFVw?=
 =?utf-8?B?RXZBWG1HbkdyUllzYWhRci9Zc0VJK2NpdzY4ai84UDNUZWRxWU9NT3ZMRWhl?=
 =?utf-8?B?aDQ5ZEhwTytkY0tlL1A2aDRXZjdUc3ZFcGY1bjc2eWJ2Rm5SL1ZyMlRwV3BP?=
 =?utf-8?B?Q3MwcGlzb1lwNnlvcHFiQjVDZlBTT1NJRWdVY251MlN2b2hta3Jpa0hnZmp3?=
 =?utf-8?B?V2RsRTJIbnV4azRzQ1ZSRXBaNG9Qd2ZUUkVCWUgvcjBSUEw5TGxRL3c5ZGFw?=
 =?utf-8?B?YkNpSDM2ZEorU1YrZEVhdmxYNmo2ODhHajZOaVpYVlhUd2ZsYW44Tlpmd3B1?=
 =?utf-8?B?NGFYdVNvYU9yMmN2Q2UyNG9pQjFaM1pUQUV6VDVaWEZDaCs2MjJLUjgrdTNs?=
 =?utf-8?B?bjQwQWY2UWdlNklFdVA5ZWExWnNKbE8rVURJTjU0cGxCczNQNTZ0L2E5eGZE?=
 =?utf-8?B?Y3kvZmpwdW56REpwdWtTeDFhaUVLL3V2aDFJWUhGNXArZDZRc0lrMy9DOTBh?=
 =?utf-8?B?L2JlcGpxUmVTNXBCa2FNSVRSRlRQWm0xUkxueXI1M0ZkQzUrSE9yVlNlcklk?=
 =?utf-8?B?ZkxoSjRGa2lLNm5GbUkxOVE0UkRwTU9XUlRhNUhZejBlK1NlNUp1T0N4VktF?=
 =?utf-8?B?OXQzZExZenQ4TGZsZTFmS0Z2b0tYVTNqZkRrM0ZUcEdqTTZVbEx6YWJ2MlI3?=
 =?utf-8?B?Z21Eb25GaUVORHBPK2RzY3g4bkh4dUJnanduM3FROGx0V1hqYmJjWS9VSW4x?=
 =?utf-8?B?TWxCUkFCVGRYQ1JISEJDTzMwcUxEbWdKeHlLbUQ2WjFGSlN2aG02REhNU0E2?=
 =?utf-8?Q?1z3TFB1PLp5IAw4jVldeetR7eAh5tvZOkBEXwuoOpUdGo?=
X-MS-Exchange-AntiSpam-MessageData-1: ortGOp9YU9TvfQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b5581d-4f8b-46b9-d0a3-08df1e37994d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 14:40:25.6855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCwsVM4FUaA0T0RgqE5AiwRBWmCvXu2fE1m87dU/KKWJcGEV4rQQMjrK79J4+/rJdURbX0mVFuxi38d+GXpSWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909
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

On Tue Sep 29, 2026 at 12:11 AM JST, Zhi Wang wrote:
> On Mon, 28 Sep 2026 20:40:08 +0900
> "Alexandre Courbot" <acourbot@nvidia.com> wrote:
>
>> On Mon Sep 28, 2026 at 6:20 PM JST, Zhi Wang wrote:
>> > On Sun, 27 Sep 2026 22:46:25 +0900
>> > Alexandre Courbot <acourbot@nvidia.com> wrote:
>> > =20
>> >> Move the types and code related to RPC commands into the
>> >> `rpc` sub-module, and update their users to reference them from
>> >> their new location.
>> >>=20
>> >> This is a pure move commit, with no functional change intended.
>> >>  =20
>> >
>> > Hi Alex:
>> >
>> > What would be the plan for commands.rs in the future after the
>> > movement? I was adopting the similar code structures
>> > (fw.rs/command.rs) for vGPU manager's RPCs and GSP plugin RPCs,
>> > e.g. having RPC typed code and function handler(wrapper)s, it would
>> > be nice that I can align with the idea accordingly. =20
>>=20
>> Can you point me to the the structure you have if it is posted?
>> (sorry, too many series in-flight and I cannot find where it is ^_^;)
>>=20
>
> No worry.
>
> I am trying to maintain vGPU-related RPCs and GSP plugin RPCs in below
> two files. Basically the maintaining schema is similar to current
> nova-core fw.rs and commands.rs.=20
>
> IMO, nova-core and vGPU managers bindings should stay together, but
> there can be quite many vGPU RPCs. Would it be a good idea to maintain
> them together with nova-core's fw.rs and commands.rs?

Unless there is a good reason not to do so, I'd put all vGPU commands
into their own submodule. This makes it easier to e.g. create a version
of the driver without vGPU support, which I feel like we may end up
putting behind a Kconfig option since it won't be relevant to
consumer-grade GPUs.

Bindings are a different story, they are generated in one go and unused
ones are just optimized away, so having them all in the same file is fine.
