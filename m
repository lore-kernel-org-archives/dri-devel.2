Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC466606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TtiivPbd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F014D10E4ED;
	Wed, 28 Oct 2026 02:31:28 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010025.outbound.protection.outlook.com [52.101.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C508010E4ED
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 02:31:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1z9ia9cBp//nZWIYNyTlKi9TdMlAeAY2xCyM1FQ9M1vADXgAPbPR3dG1nGMc+4yukioUcSsClVNdGkhJqQxnCZFACgBcDIcKZMpVcHdQyOypfggoqKOcN/9XEqfcz7p98FbrC/E0QeFA76QkA7j0M8ATRtY6SuKAjKRJTWR7o5KIDZ95t6SNhKiq4iNVFQ8GeVxfAWVgbNFr6zgV3xiRg/DIB/KCeYdECqDqdNhiY5Me+HH7NMltUb8uhcHGjOpXptYHSCEnYITUG9U61KDXXmGnG5fCucRJqsD9C1ZaaCi2VPlvIdrpGLsFT4c4cMFf1Q+wCfN9wbn/zfz5K8CDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVBN7NiU8wseeVaXrTuTy+WqdEevdbJUNJotbS3dIdg=;
 b=uySelen97nEeym5k98d6AVUZrhEKqUo3OHN+zkBA4K7YNtqXe4+QF7Skt+N5NRSITR8R0sqdJwxjUWMr5mOdAzzSCmkKLhlYrK2UYbmQej54zwxNj9lODv0esUgSGEDm5NOxmnXYZw9wwJrtjat8GiC0BmZKaDTKJWtkSVAG2Ba0O8Qzwyai+/TNgCGCvtRqzpA+fW92sO3mgQHdXsZMo/XTYJHSNeDHBb4kO7xW6BBnQexGxTdau+QDuz5P1p+8X3o3BpZc3ULV/zsV4L9aajLOfcUVT2DbfH3eYkOGP0f6aXUXUgAPMGw/4nXANitNma/85EXBDD29USng7QFb+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVBN7NiU8wseeVaXrTuTy+WqdEevdbJUNJotbS3dIdg=;
 b=TtiivPbdAPyJ3vj0bT2xJy8Z0lM9SuxDKKL9FZ7nFyC85KYAEhgyfJxvMA6BFlLbeXbA5in1CuzfQjc5eDavN9AqZZQXfc/kIKOnkZCmoAnPL68zNCeq94gWvkO0LOrrQ8IRog57sGquEVPbqs1hnb4pi7N7fUuK0rR9siRKvYe6NRXv+6A32D30FGxaq+wqEuUOA4bFN5xaP1vW/9rGuCfAwglMPqf0Zbv62vfBrsRyx5/vCvuRAHsxTsZFVvibj3PjSY36YckyIFHUKTEAp5nRGo7rA90J6dPTPHBlEtlPROXS/Qq6RxNCMzj2dZhSKyKKZktftlln1GZpeUwIig==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by MW6PR12MB8866.namprd12.prod.outlook.com (2603:10b6:303:24c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 02:31:18 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 02:31:18 +0000
Message-ID: <c9e88fe3-24da-48bf-8a84-1afe22949021@nvidia.com>
Date: Tue, 27 Oct 2026 19:31:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/15] gpu: nova-core: gsp: prepare the command queue
 for r000 dual-message types
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20261027-cmdq-rpc-v6-0-bed9669724ba@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20261027-cmdq-rpc-v6-0-bed9669724ba@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0064.namprd07.prod.outlook.com
 (2603:10b6:510:f::9) To SA1PR12MB5614.namprd12.prod.outlook.com
 (2603:10b6:806:228::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|MW6PR12MB8866:EE_
X-MS-Office365-Filtering-Correlation-Id: a57afabb-6f56-4a47-0d86-08df349b8bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|23010399003|376014|18002099003|22082099003|261026140227099003|3023799007|56012099006|11063799006|261021121427099003|10067099003|261009223027099003|261021123027099003|261022075727099003|261021135927099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: DWWeokEuT3XIsQSZRzGg7YAFPC1N0IJgAengzrs7anuiezgSUJ9Oyxq+y66WbOXJtNGJC2CaTnkJFY1c2QNGJWrxp3xgzHjsCF5K+6qoLCml+bS1i1cbBW3kDqPMvi0t0G3rBZV7nmTyBJqnaQnggzJs7lBlRJ5tO9acGnfTR3hol8U3nzTLwVabttabuziL9kHalmIwprIP9VVXGxOp/6z7AvmWDjM/+1jOionaGPJ5bJCb78s0GnojVfIlXnGbuvnnhuhLr+FxTreHFAqijM7Jn5SAJlqjGky+P3Ojd0dpKZzFVS1m0haDBX2Q6L098lLkic40hZUGHr8GY3jLw44O95vxY9PRFVfzVfrCB6qruhr3jSrFq4cRYfKuRB0oPok7Imyirulw2EobwOD4X0RfNh74yH3PxTtRZq4+wE1iaqif2Wz6xAZvSgpl3FFwRgEqPg4jWXRqTVXDcAqkJGMZHqw9BYcU5j29bgjTF8cwpvVvRhfTsGLus+a+qzFZ8FAJkHO+5TCyHBMBqYrdtrBt+j2QikZNVHxSgFoeSu+tc/BpIWPckycyNoTNgSZuQCTXaLfnMoJF3Q0QRN4ZVOjPudTO201kgY7VpUUIwPsPMb/AL7gW+i1Bmdy7pOjIZdrLVqrls42IC+ohnTAQo1Lh1by2PSUbaRZc1Y3F7ME=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(18002099003)(22082099003)(261026140227099003)(3023799007)(56012099006)(11063799006)(261021121427099003)(10067099003)(261009223027099003)(261021123027099003)(261022075727099003)(261021135927099003)(261022105027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTh4RnhibExRbURYbGRjRDVRcUNjZG9Tb1FQSi9yK3Btbkk1NllBOU92djhh?=
 =?utf-8?B?a3dveXI5ckxCb0hWMXRkS0NDL2RhZGs0MGFJL0JyU0F3VWI3ZmlmeHVFWnFx?=
 =?utf-8?B?MHYrN29BUytiaWEranpWeFBFVmlxeWZuRFdYZ0dnb2c5c0RhMGNTR0FsQ3RO?=
 =?utf-8?B?NHIzKzVmNFRUb1k5SWVYQlJmaHBXWlpDR2svcGNmZDhoVWl2RnNWTThBVmVC?=
 =?utf-8?B?SHluSTRmdWNiaFVUWHlUbk16U2UyeTA1MUl5S3l5UFc0QnlUN3p6ZlptRSt6?=
 =?utf-8?B?WGd2YWlWZlU2Q3pzYjRRK2l3amdGc3hIdlhrRnBQL3JTV2pIcmJGS1luLzI5?=
 =?utf-8?B?bkV2MnIwTjlqb1lpTTlrTkNOVEpjeUdheUZabTdmdnVqVExXeUxpZS84dGZl?=
 =?utf-8?B?cTRQcXFSVFlrTk85ZCsyMko1YjZWamVUSDFtOURQcEpEandIMEMrQ0VJSlAv?=
 =?utf-8?B?UGhYcXd6VVRKZlNpSG0xRHltNkpLU25RUmlxcU5qeDNCdUp5cmhpR0NZMWV6?=
 =?utf-8?B?Z1dscDVzMDN3bCt0WlFUK200dHUxZkNaTk81dGF3K0ZUMVk2dWlwLzlyOE13?=
 =?utf-8?B?QXdKLzVmV3gwdnZEN2lXTkZUT2NiZVgyWFcyK2dJallhK2JQOU9lWEJsQ1F1?=
 =?utf-8?B?UVFBYVl3T3BiNG9jOE00bnN6VElEWlNCR1BPTmU0VFI3SlNiRFlIY1puME5u?=
 =?utf-8?B?d0pMcGttblNESU1PS25UdUVVaVRnT09YT3A0YVNoQm0rUi94Z3hXTWRFRzBw?=
 =?utf-8?B?bGwxdWZUdGlXazNCRURwVkFGRXVFSVd3dVJTOFZDSjNrR0QrK0pobEVHMWhu?=
 =?utf-8?B?TVBkNlphYTVnUGhybUpwZVRtZVpXME5IZzJSQU9kYWpnMWVwSmUzeVhteUZs?=
 =?utf-8?B?bGdVSjZ1NWdTZGhMOStaT3psY014RnA1TzR0SjVDVXZwZXhFeFhHTDg0VmNU?=
 =?utf-8?B?bHY5UUJUQ1I2NUhoUkR5Smh1NnEvZC9hQlppQmRwb0FxNFdVaERhSnNvMzNS?=
 =?utf-8?B?N25tYnFzYkJwaFZYUzU5UzRkbzNhNXoxcmZ4cE5Ic3pRK3djU3UyV0Z2WnlO?=
 =?utf-8?B?SXYrVFN6eTRhUG1vZFNjY1dCWE1pMzV2azg4dXB2enRpb3d3ODhhWm9GR25q?=
 =?utf-8?B?elIyUjZuQ0hpV1I1MGZISDM4czlMOThNandlajhUQjlLQnd0S1lYNkYrY2VE?=
 =?utf-8?B?NytoWHdUVlE4MC9iR3lCT24vcmdhSm0zNjlCc2RqcmtrVTVuZTRNaTR6L09K?=
 =?utf-8?B?QWlVbGJ5cXdwcjd1bzJiY2NTSkI4MzQxdy9YclMzUmx2TUc2dldxWkdzVDY2?=
 =?utf-8?B?S3N2eXB2d3hFb3QxUWZyaDFaMG13amRWRHo3ajJSbmp6azJ6VG9uNkJXUGsz?=
 =?utf-8?B?emtwNTBOeGhwVmQwWVBKRWl6U3NkMmVzcER0WVRZRnczbnBCRjkzblpUVmlH?=
 =?utf-8?B?L0hNQ1pQcFJYUUw0VEFoYVk3Yjk2VWhuM0J2SjN6aHArc2I2WTdTOXdKOHpx?=
 =?utf-8?B?T3B0WFUvZjkzZ0FMcHdqYTVLTzU0K3BZZWttQ296WUxRYlJnTVpWbkdjazN0?=
 =?utf-8?B?WGJGbEhWRnp5QkJiRjVqY1cwSUsxMzJxem0xMXBMRHRtRFVEVWEzc1BCL3NU?=
 =?utf-8?B?WUo5UDlZNVBVWWJhcFVtclJTcjl4U28wcGhxRlNjZjI2N1BlZDFKR25vS2FW?=
 =?utf-8?B?eWlTNnh2UDJRbGl6ZUJoNUFLcThWam5mMEZkaXpiUEhxMVVqRnRhMW1pNnVn?=
 =?utf-8?B?d2tZQzlVdzNycnlaV0tpTE02cEF4TjdzZjh4bWZ5ZGxsTlNMNFhhYzRkN3RC?=
 =?utf-8?B?MnV4N1ExT3RpaEJ3eThnVU1ycjdTRHN6Q1VuTmx0WWJyUjUxM1ZTbFQ0Lzdw?=
 =?utf-8?B?ZlhIcWhESHVEQm1TZEdRamxpaFpiY1VreUV4Q1RpTTJMV3lMMFZ5NTNhQ1M2?=
 =?utf-8?B?WHZHMmZ5NGF3Z0FzTzRCQUtiWHA3S2lRZnpzbE5xYkxpcE5VZlFIY1ppZGcw?=
 =?utf-8?B?Q1VzZVNwVkdnNUhCNSt5eUVObzdSQ1QrMy9oUjVYOVFiZVdWZ0RmSTdwN1ZF?=
 =?utf-8?B?cm9ZN0UvMnBKUmdFdXVuN21ieHlOT05MdDZKNG1MMU93Ymk0MFg3YkNIcm1E?=
 =?utf-8?B?Tkg2ekMvTGdaUzZPUjNQOUp1aU5WdlMvSmJjdjFzOGN2V3Z4ZXRPNmhZYysv?=
 =?utf-8?B?UWlTUm1Yd3B1OU5NRk5XL1ZpRjF4YmxBOHBlRDFkNk5kdjZnQi9Pdk56U2ow?=
 =?utf-8?B?THVvcG4rNXROUjhvVVp5WC9rOFBWdGN4SWZSNU1lSTNDRzVQVzdTd2tkNC83?=
 =?utf-8?B?ckNwcGVRWmQ1eVVaRjRxVTZIS1U0L1FZTHM5UU9WV3BXWnRycG40Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57afabb-6f56-4a47-0d86-08df349b8bb5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 02:31:18.0461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udGovI/51iUGkLd+T8kDiAiDFRWBPuL8+lC7ctWYFELKn8vABSecxsxN49z2A7VBjSzpmwlbryxauR0Gevc4qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8866
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 12:35 AM, Alexandre Courbot wrote:
> The upcoming r000 firmware support [1] introduces a new type of command
> named GMC alongside the existing and already supported RPC command type.
> 
> Since RPC was the only command type supported so far, it was embedded
> into the lowest command queue level: the message header actually
> includes the RPC header and the code considers them as one.
> 
> This makes the r000/GMC support difficult to land without a refactor,
> with the result of transport layer code being duplicated between the two
> message types, and no clear separation between the RPC and GMC code
> which are mixed together in the command queue. Merging the code that way
> would introduce quite some technical debt.
> 
> Thus, this series prepares a proper landing ground for a new message
> type by extracting all the RPC layer code and moving it into its own
> sub-modules, making the `cmdq` module completely agnostic of the type of
> message it transports.
> 
> With the transport and message layers properly separated, support for
> GMC can be added into sibling modules of `rpc`, and the transport layer
> can be converted once when doing the switch to r000.
> 
> This moves quite a bit of code around, but most of it is moved verbatim.
> No significant functional change is intended.
> 
> For the r000 series, this essentially means the following:
> 
> - Its patch 7 making `allocate_command` generic can be dropped as the
>   transport layer makes no assumption about the message type.
> - Patches adding GMC support will do it in dedicated `gmc` sub-modules,
>   following the model set by RPC. These `gmc` sub-modules will start as
>   `dead_code` as they are being built.
> - The "switch to r000" patch will essentially operate on the transport
>   layer level, i.e. `cmdq.rs`.
> - There should be no need for extra post-switch RPC fixing, as the
>   transport layer code will already be shared with GMC.
> 
> Overall, this should make the r000 series much easier to review and
> eventually land, while not creating new technical debt.
> 
> This revision fixes the latest nits while addressing a couple more
> issues found by Sashiko.
> 
> This series is based on `drm-rust-next`.
> 
> [1] https://lore.kernel.org/all/20260918010719.1176945-1-jhubbard@nvidia.com/
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> Changes in v6:
> - Add comment to `consume_element`'s documentation to disambiguate it.
>   (Eliot)
> - Add a patch to avoid sleeping in `drain` when reaching the end of the
>   queue. (Sashiko)
> - Fix badly-formatted import block. (Sashiko)
> - Link to v5: https://patch.msgid.link/20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com

Hi Alex, looks like it is converging, are you planning to merge soon?
Or do you need more reviewers to weigh in?


thanks,
-- 
John Hubbard

> 
> Changes in v5:
> - Drop `MessageElement` and instead use a closure to process messages in
>   `consume_element`. This reduces the behavioral change of `await_msg`
>   and harmonizes it with the behavior of `drain` to the point where the
>   latter can also use `consume_element`. Eliot's R-b has
>   been dropped on that patch as the code has changed significantly.
> - Avoid unneeded temporary result variable. (Eliot)
> - Rename `await_msg` to `await_rpc_msg`. (Eliot)
> - Add patch splitting looping behavior of `await_msg` from its RPC
>   message handling.
> - Add patch factoring out `drain` code.
> - Add two doccomment fixes.
> - Link to v4: https://patch.msgid.link/20261009-cmdq-rpc-v4-0-c9ab8de1d3f2@nvidia.com
> 
> Changes in v4:
> - Rebase on top of latest drm-rust-next, including the interrupt series.
> - Move RPC parsing code to `RpcMessage`. (Eliot)
> - Do not mention the command queue slots in the public documentation. (Eliot)
> - Use different names for the length methods of the message and RPC
>   headers. (Eliot)
> - Fix bug where the RPC header length was used instead of the message
>   one to compute the number of pages to advance by. (Eliot)
> - Add a patch moving the message logging code to `RpcMessage`.
> - Make the `rpc` module only visible from `gsp`. (Eliot)
> - Link to v3: https://patch.msgid.link/20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com
> 
> Changes in v3:
> - Use dedicated `RpcMessage` type to distinguish parsed RPC message from
>   the transport-level `GspMessage`.
> - Introduce traits for sending and receiving elements on the command
>   queue (thanks Eliot!).
> - Split unsafe blocks, drop unused impls, and other fixes on patch 2.
>   (thanks Eliot!)
> - Squash the two move commits into a single one.
> - Link to v2: https://patch.msgid.link/20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com
> 
> Changes in v2:
> - Fix checksum on receive incorrectly using the whole slots allocated
>   to the message instead of its actual length. (Sashiko)
> - Drop patch 1 to avoid having to validate the `elemCount` header
>   member against edge cases. (Sashiko)
> - Fix incorrect layer separation in receive path, where the CPU read
>   pointer was advanced in the message layer.
> - Move `log_event` into a method of `RpcMessage`.
> - Make the `rpc` module only visible to `gsp` and its submodules.
> - Fix doclinks pointing to old function names. (Sashiko)
> - Link to v1: https://patch.msgid.link/20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com
> 
> ---
> Alexandre Courbot (15):
>       gpu: nova-core: gsp: cmdq: remove stale comment
>       gpu: nova-core: gsp: cmdq: simplify framing error description
>       gpu: nova-core: gsp: cmdq: validate checksum earlier on receive
>       gpu: nova-core: gsp: introduce and use proper RpcMessageHeader type
>       gpu: nova-core: gsp: cmdq: group the RPC-specific part of send_single_command
>       gpu: nova-core: gsp: cmdq: split the transport part of the send path
>       gpu: nova-core: gsp: cmdq: split RPC parsing part of the receive path
>       gpu: nova-core: gsp: cmdq: move RPC message logging to RpcMessage
>       gpu: nova-core: gsp: cmdq: split the transport part of the receive path
>       gpu: nova-core: gsp: cmdq: extract await_msg_with from await_msg
>       gpu: nova-core: gsp: cmdq: do not sleep when waiting for a message with timeout 0
>       gpu: nova-core: gsp: cmdq: use consume_element to implement drain
>       gpu: nova-core: gsp: cmdq: move the RPC code into a sub-module
>       gpu: nova-core: gsp: move the RPC commands into a sub-module
>       gpu: nova-core: gsp: add `rpc` to RPC message send/receive methods
> 
>  Documentation/gpu/nova/core/interrupts.rst         |   7 +-
>  drivers/gpu/nova-core/api.rs                       |   2 +-
>  drivers/gpu/nova-core/gpu.rs                       |   2 +-
>  drivers/gpu/nova-core/gsp.rs                       |   4 +-
>  drivers/gpu/nova-core/gsp/boot.rs                  |  12 +-
>  drivers/gpu/nova-core/gsp/cmdq.rs                  | 486 +++++----------------
>  drivers/gpu/nova-core/gsp/cmdq/rpc.rs              | 415 ++++++++++++++++++
>  .../nova-core/gsp/cmdq/{ => rpc}/continuation.rs   |   0
>  drivers/gpu/nova-core/gsp/commands.rs              | 329 +-------------
>  drivers/gpu/nova-core/gsp/commands/rpc.rs          | 333 ++++++++++++++
>  drivers/gpu/nova-core/gsp/fw.rs                    | 123 +++---
>  drivers/gpu/nova-core/gsp/sequencer.rs             |   6 +-
>  12 files changed, 947 insertions(+), 772 deletions(-)
> ---
> base-commit: 3497a403264b094ebd61b8b755165d56e7d9dc37
> change-id: 20260927-cmdq-rpc-ed5f850b207e
> 
> Best regards,
> --  
> Alexandre Courbot <acourbot@nvidia.com>


