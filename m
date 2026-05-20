Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6623FCD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 00:59:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7332B10E41C;
	Wed, 20 May 2026 00:59:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="F1aOlAQi";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB44D10E41C
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 00:59:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdHqiPdMwn2N/bVOfOHCsXvajlaVOozQ1namFppXNGztRuZCNHyHst7mmUMxfVm++CoIC7cFLKlqW+lFSxdyLRcBMtLZ962eiHrr0TUPTcHeFd0wHLmnsbOp7JDB6LyPeQhIdizBUPOntHtI5uHR15a3tJhNVGMjIhVdShzboTsDcokDAEdmZzG8B2oYqZP+Lw2U/zxbxSUjmbknnJwii91/pWfydJXV3yJv7nNA4wrOYUFE4DjkrnwnchQ1yNV5SNcRd+QWMjweSsYvkRoJFeV/4WUYOyNw5wTWuQXQhhxPpqz25ScUva6mI2+iisv23nATOZQcJRzd57jrwwGDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ClQeoI90PslEu0zX49LnFjHqyRd8ZBJxVmd39c4p34=;
 b=KmgEBJGrL9LLzFKPgI+Ar7+0KLwHkOgAGw/VSAC+F5bCtwuqWS+33j7TZhAy0vJ6jnMXTtuyW7AMRLC9iiHmhTk1SlmkSaxelzxagS+/aIfH6wPLDoDTZcpbcBS5V6pzYBkYmxFJwPCfiuIdkjfCMVL2eiWfNAhFX0WSs8tG6V8JPv2EBSfzo6PCXdZQEYsTs0B4ibTXQpoBbrMnHpjS1WJGamZSnX/x3FayXMtfe6DIKBASl0tNWXfB7OKwYlIR/GkHg7gwWuS1t4G6/O1ybZfavRjbswIjbQJQs6VdkgfFLlXAS858evc4Kl+pWc9F5mZsIMtvyQ/GUAnTKUeieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ClQeoI90PslEu0zX49LnFjHqyRd8ZBJxVmd39c4p34=;
 b=F1aOlAQifkeGKhQVFuTV6Wr4HjVBb8PvAZFS1sqb3nNd9URrMxJPuULgr27QPtBWLnh4m/md/klI+EGXr6PXX1wGQR7CDUwRurJb8L4SF0+sFdkcLDX/CZ62oIiOIWUxybZl7WGN6xPlpKHoXDEq8r8Ng19uPJhQsQesGWQnwNICyH51r/aMerJWqdMgfHyg0Ot1sdz0LnX8GX3xb9/aISqwNOmQjLvkZAroer4v9vfK/VFst8i1G+YqG+z4s5ImQt2uWuGIeUZro1kabkrLEZiR3QzUZM7OJbnDrvOx3HtvX9jdpwjXkrS3Zn4/kA14sMkeEyGwteKrd/g6WIrZCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 00:59:19 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 00:59:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 May 2026 09:59:14 +0900
Message-Id: <DIN3HZV9YVU9.87C4SH46QXUH@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Antonin Malzieu Ridolfi" <dev@nanonej.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>
Subject: Re: [PATCH] Nova: Move register definition into module using it
References: <20260516161258.455442-1-dev@nanonej.com>
In-Reply-To: <20260516161258.455442-1-dev@nanonej.com>
X-ClientProxiedBy: OSTPR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:604:21b::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN2PR12MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: bf672ba1-540d-449a-80ce-08deb60b0535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: Xnotjj1Laj7ToKbJyFJS0LL7oV5WxqKqEVrO02quifm1c/UzhxBN/tAq6aoXp66QjGHp5g7Wp1tD5LPupi7iI1E/LlMgLWgYFp3vaVWrKCUfugxssgurI9eENPfL3MpmG1xF7q/zlSsvvcvoNImT29iroxB6E7S+gh73v8y1Te9U8sfqP4qotbtzX46H2EtvfAkuKh9izFdAkKdUPl7AWsq/vFlL6NI5XxxBcRnIKHrfKFEznrH6C77imPSm67ncv1+lO7Cl77Gx/CY7WfjdmqZVCimHRCwAFuS/j+HNnn2Qay4/h88ra4aqo6TGBHyFyNhyUblEuLzIs837ny5AfbLqnKAsf5Sb29sOaN75DFrMzWTjSeb7v4xTOofY+Su1EmazIIFvsa8az1aHgwHeWhpnBlVKCEqkQa3hdlzPTDq33YAGbYvsZc0XjMqs/HwB1GmtOvg4ISHyHdk2BoLr+rMb3AvrY8AbylvYW5dLHoxatgSMDN/wttfkOzjO8lw0DCzGgz4ou3IHCDTXaz71/bYh1xR1UheURskp7kgRY9Bu0uFYlvjLeOoI3A+DTzGT8XmNjkn4MMr4+6WTmyGjqxf03xMMPCyUHXZ4K+depmBqS51gqIiIf0QnQcPUoi2Dm7ul9gnr9XNKpgjNfAS45QAj5u1dd14hlJ0yZsaane98bLNkSnZGXVeyE9k0nqqr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGxnekVVenVGTlJIQUs0eXRoU0tEZFM1bTRKaWtDTDFsY01jN3FIeFcwdzRn?=
 =?utf-8?B?L2tXMnpQT2dMdVVaNk1iYnA0VFlmQVE3NkRNSWxBWTdZYXhNZHViU1d6MnBo?=
 =?utf-8?B?aXpuUHIwYXRTUkduaWF0b3pNdGJkcDFMUzlmdmc2YVorRTJsWjA4anNPTlJJ?=
 =?utf-8?B?RDI0WktIUjJQV0JWK0lMZTAwaWF3Y2toNW9kUXRjK1hqbE4rMHZEY0RYeHRW?=
 =?utf-8?B?OVJNOTIwUWYwSmdEYW9OaVRzbEdDRkxBSnM2ZUxaWitmQW5icGVraktJdUhB?=
 =?utf-8?B?TFNld25FM3phNURzeVdBbkJ3RWY3bDNsMnY5RW5HUk8xeFRxcUcrSkpVSG1K?=
 =?utf-8?B?N2VWZkwvMUI2eHhGVzlMdkw0bjh2OVBFV0w4SklhNkd6NEZ6dEpyclZSVnYy?=
 =?utf-8?B?c0VBcERxeGFYQmw0Nng4MUU2QXlDeS8rQ296WmJkNkU0cXJvSzVYQ1JwM1lo?=
 =?utf-8?B?YnphWXd1MFBwZXFxVGpkSllnRlFTajZhVGQzS1VrUnRjKzBVZWtlR1EzU05G?=
 =?utf-8?B?SWZ3aEwzaWJNRDFwbUtOSkhMbHdZUVkzODllZkd6cTA5QnRTanhvODNyc0pp?=
 =?utf-8?B?ZDNuVGFJcE8xbUJwRm1FSU1kakZjY0ZLeWU1S3IzY1pERUcvVi9QNlJ4WE15?=
 =?utf-8?B?WU11VEFGQzRHL0pVbDZhc3FaR09vdlpJNVM2TXJyUjh0K2YrdUxDWUJDcHpa?=
 =?utf-8?B?TjFEM0xxMUxkb1FBbXVQdUFJakFydTBzZTZPYm1sKzBOMUExbXB5cXJrSjdp?=
 =?utf-8?B?M044VjFCazJ1SW5UOTZsbnhna29VdDMvZVEzakkrd2ZLcmJlWEtkYWd3NnN4?=
 =?utf-8?B?SU0ySW9oYnB6b0QzNFA0NWlFcWJqRm52YldaRkUwaDE1em5wZWs5MmF3MFhy?=
 =?utf-8?B?aUZ4VDZzV1orY2ZIakh3V0xySlljVDkrYm9hOVhLVS9GY2JXTDJmUnlZZFFv?=
 =?utf-8?B?OEdlRkljUGh4MDRWaHRiTTVHOVd6d3laaDBnUEp2S3c2Vk5QRERUMmtoWEhP?=
 =?utf-8?B?SVlvR3prT1V0VjRLMW9CWWRFOVZrOTAyekhWYUtpYjhVNkVJa01pd2t0MTFN?=
 =?utf-8?B?VHpNYnh4RUVpY04zOHhoOUZqTHNNd0ZrR05SM1V4dnNveVViWXVRLzdrNUFj?=
 =?utf-8?B?aWV1RHZwS0VFMkxGY1dWTXZpa3ZWWWhrbUNLa1V1dWZmdmpKN1c2eXZGaXdu?=
 =?utf-8?B?S2t5bHlCcGJIMHBYUVhkbCtGRnpHeDhqMTBZMmxTb0JRQ3RGNlRWanlkNDVB?=
 =?utf-8?B?K2RMb1ZrN0JJbDRpOWpDUytRUTNtY3pCNlV1RURTTXBKcUtmdXJGQm9OYkVz?=
 =?utf-8?B?YjE2Rm1ZQ05FSWxDa203MUZnenFsREcyYnE3NURvODJQZVlRMHI2K1Z5aGZD?=
 =?utf-8?B?M2ZSR3JSaFVvb085TzJzOTIwL0VOV3lRT3M1dThZcUR0cWRhTjU3ZktaSVRE?=
 =?utf-8?B?ZkVreVNRR2lSbXR3RmpmZmo3b3hvRjlaTFQ2OVdnM2hNbVhBZ2NLcHMwTjg5?=
 =?utf-8?B?cUZMbE4rdkE4YTNha1E4QlJ1S1RXOXVUQTh4cURpb0hxZlc3VnVXckpQRC93?=
 =?utf-8?B?MzlLaWhmUzF0cndVVGRkcjVTS2hrU2hteThmamx0anVMbVpUL2pWWHVVc0F6?=
 =?utf-8?B?OWtpczdnNzdnVTByUVhxeDhUbUJ1bDB5SDNWOTl0ak5ucDBqRGUveWdsb1B4?=
 =?utf-8?B?ZDRjcnVCQzhBSDBLSWdudXloSEI5WklNS0cwcHRvTlFycUpvK0JBTGpJQllV?=
 =?utf-8?B?a1duNnJweW1iR0psZjJnU0xRQkRkTjhRclVlS2RjQ1AvdXRDeGRzQktDNjd6?=
 =?utf-8?B?dlFSZUZhZkxKOEtMbjZqM2szdFF0WXRSY1pCWEU1ZUZqYzhoQ1RzQWo3WE81?=
 =?utf-8?B?R3ZSZ1RsTjA4QlRlQkt5YzZVWGtEdSs1QWxjbTlwWmZrYnBOSlRKN2ZhVmgw?=
 =?utf-8?B?MGh1OFkwUS94ajN5SzRMU3RTYSs2QzVIdUwwVzBaZGMvYXdlTTdlYXl3Mmll?=
 =?utf-8?B?Qm93NFV2M3BBUXJTR1VDOVJKUWJKREw4R0NrSHZpUUlzTTRCY0ZRTnphbDF1?=
 =?utf-8?B?Z3Z1UTlNRjFGbXlSOUs3K1JFSEhxUUVld25GenYvb3FXeEJ2enpFeFkwMVIy?=
 =?utf-8?B?TzZnc1VBTUxyOUZlYUtmS0JzeE5LSlJMQ0hQOGEwMDNnbjNRR3BaNFZ6Q0ZZ?=
 =?utf-8?B?UDlZM0ZoV3oyUmZ0UjBtbWIvbUhjb2s4RWZBWWpTeFNYc3VQSEQ2Mzdjanpl?=
 =?utf-8?B?TkRTVC9MOHJiVW44Rk9kZjY4cnlKUTlralJaUE4zZE1lVGVvaGNsQjRMalVU?=
 =?utf-8?B?Z2FmRG9iaDBNQzkyY1NVdEZFdldtQmhJK2poMmdqNlo1QTNreWVSaVRsOE5D?=
 =?utf-8?Q?eizT5Zb59ZivoeADNm6581bKOV3WoS73yvFlSm/MS6ck8?=
X-MS-Exchange-AntiSpam-MessageData-1: cINKeIfeZUv97g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf672ba1-540d-449a-80ce-08deb60b0535
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 00:59:18.7099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9b3z4P9m+RTd9mbueozv5GAnmbwsefPgZZjsFmUyBBd77y5XlFMVZt8D3pf056ITr+WYS1zA8uZSJ6RPPJl+og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285
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

Hi Antonin, thanks for this first patch!

Note about the subject: if you look at patches under
`drivers/gpu/nova-core`, you will notice that they all use the same
prefix (`gpu: nova-core:`). Here since you touch the `gsp` module,
you'll want to refine it further to `gpu: nova-core: gsp:`.

On Sun May 17, 2026 at 1:14 AM JST, Antonin Malzieu Ridolfi wrote:
> First babystep to split the register definitions grouped in nova root
> register file to the module which actually use them.

nit: "first babystep" is irrelevant for the git history, we prefer to
keep the log strictly factual. If you want to add side-comments, you can
do so after the `---` marker - these won't be picked up when the patch
is applied.

>
> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Antonin Malzieu Ridolfi <dev@nanonej.com>
> ---
>  drivers/gpu/nova-core/gsp.rs      |  1 +
>  drivers/gpu/nova-core/gsp/cmdq.rs |  3 ++-
>  drivers/gpu/nova-core/gsp/regs.rs | 11 +++++++++++
>  drivers/gpu/nova-core/regs.rs     |  8 --------
>  4 files changed, 14 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/gpu/nova-core/gsp/regs.rs

The patch in itself looks exactly like expected. The reduced visibility
is definitely nice.

I suppose you will want to send a v2 addressing this feedback; feel free
to include one or more extra obvious modules as additional patches if
you feel like it. This is the kind of rework that can be merged quickly.
