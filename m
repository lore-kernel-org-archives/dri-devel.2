Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94717109B497
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 04:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D783110E023;
	Wed,  1 Apr 2026 04:26:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="EAfjJFyW";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013026.outbound.protection.outlook.com
 [40.107.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D53010E023
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 04:26:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOwKxr72B+1GMkrxBUit3yJIjKNq7AA6vcPvSbHov6cMGMHyogGqfjCc3MdHzbsZ8Nreh/YKbgwEvIJzTAXOw5ibJODNN98nBpkBjGQy7bwJajiL49/UseLMSPh66HPgTq7qh55GGLMy7AEAv74hFcQ/GzHh1PZJNiE3jwi2duVEnNJh07NjGmCkT85K2jRaNC3H+koBvkAGJFsjwB88CBdA/yaUH7gb/S8R/sl8E5ZhfaZO0UjTddi2re+7dDecRCiRf6DgTeVY74CEi0BuFWLMeNl3bzr4Je0CkCtb3OZyKYDf2tCRLnXKge58djwfFqi7SaMYUe5oesrmP1PDFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vamWpOu013uay1fEsYMab3RNeilkVH9tihZMSvKNKw=;
 b=VJelk+7f6QkzY7EOs0+84EMIYJYCCb5e4vRKUtrWhJ7ogSBPPmGF6xwwFMukPFpbYP6kvtus0luoGW5/4aw+mxpQZKvjv6RpQQY2/K+VYknKJHlD7s+naFJbb5Il5DM3Sp7TlGLXWDXot0olwPeh5o+hv/h6Dqf+eQwyHIJNZY3zxoKNriacU9wdzacMMCVTWSL1t259E55hFTpyUTmGEyUN+Xbowj9IUBPy4+CgzjlUOW63CtqN414ahMKvs171xWB9JP36OQjA3wyyXjvTti8+abiJyydi2jC9YYR6rWSFyrQr4AflNeXovvkQI8q8xg2gbCoWJIwvZPFfuXnsgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vamWpOu013uay1fEsYMab3RNeilkVH9tihZMSvKNKw=;
 b=EAfjJFyWU28xRbOqHxNbFbE/7jPtvZt7uFg5pWXj0xVjUeqG6EeO7wRkNJqEBe4/H0TNV6bsqmXDCzelgbpSGoANAVjQ6617xvEUI79DRTrmO+2GkqbwbJ7PO12zgYiCgS3Dk7BqLPiaNvvbUNpb9tZivW2cn4UdeQMc+PEu5kJA6y7Zryq/nU202f9W3J9BlrjeNaHg5vldj45/RcwR5vnb5U7X+yrQ6F+ormu1+0eHbeF99yKvzYKPb8/HgXxamtG1ZYmbNTW2QPd866LTWe1mSITkRaChjpd0FWDsZBWp1QF8GvuF6B+/wAFXfszhAP0JF4brbD0GAQRHU9P3zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ5PPFDF5E260D0.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 04:26:42 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 04:26:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Apr 2026 13:26:37 +0900
Message-Id: <DHHJ82YDW7FP.2ZFKZUQUZZ2H7@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Lyude
 Paul" <lyude@redhat.com>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] gpu: nova-core: bitfield: fix broken Default
 implementation
References: <20260401-fix-bitfield-v2-1-2fa68c98114a@nvidia.com>
In-Reply-To: <20260401-fix-bitfield-v2-1-2fa68c98114a@nvidia.com>
X-ClientProxiedBy: OSTP286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:223::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ5PPFDF5E260D0:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8bec8e-31c0-490a-5769-08de8fa6df61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: +9gar50Gj0Ld09NYdvGjN5p6NTBlPd9JESQGWHSpPwpe2UxDKDSk3NHiECXG+05rvzJBeLc9NmclZ3vGP848jWLpQHdn6jOpjR1l+6qsFxkkBODF0Um6wvtZb2ikPhNz6PgfJZDfFZYwTSl6FarPJhwUAxKWB1rRusXxpIY81kIn4aF3PklDIYfIsJJRoFh+HsWuVcS4cRNhlh9JACXsC1q0vVndetrCqXMk00t3gsCEGMU2813hpj3GOfJWdEzeJHqDr6NCFCqEyv9V3mkmRZz+i0GM9a8wowjONP0B3ZVV3U2HZjg2ltmh0DusIaopJDUzEvq51HBQT5ek93qIa6uAf7B8+HZ/YmNo0ZmY4m8ab3KD79Zex4jLHM85k4wpwq6fQ0mO7+XVE3F+lzVhv0cLJ1RGgV2foRy+QjpeE7GIHe0zNnCg7Em7tpICwlqywG65ti0SLNi4zGqvZPonc6gwBok3xRE+EFdtIIANGkRCA8PKmrMrDSfBwe6B7tT+amgNdz/SFquWtqdanxPpwLhhmjJhL2LjoQ7cV2eIEmjK//qtPTabvQ36GpyqFkiII1hPN/bhNHzR/ylTl2r0US8EcstuEu+VbcpG760RlM3VAn6/uuZqm/OwMXN45ZWIkRwny+nvGBqI3QLFxoGcgMgnblCNMeOKsh207asFb1KBs+m3ZWJyKLLhPukHuvqPDswFyPN0AVpP86KkVA0GzSk7sReZFt0WLn3oGtkbmSs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkJTMXZXUHd6dnh0bUVSbW1IT09LbWpJWXMrdkdsY3lnNkNYYUh1Z1kwcjha?=
 =?utf-8?B?VDlhQ2ZkZDZpODd1SisySVNUcDRSTGo1dS9oZkFWdTZhVE9QMUhzcmVCdW1v?=
 =?utf-8?B?eCtPSTMxVEJxZjB1cVArMXBqNVFXcmovUHBwRURyYnBRNVNPNWZLd0kxWHJI?=
 =?utf-8?B?aWZoMlk1MXEzSlpqOEljUHV4ZHlCUDJRU0VYRFRBYlN1RFdGbTZ2L2NFR2R1?=
 =?utf-8?B?ZVNpb0xOQWtOR005QTJiL2FrbHhvaUxXV0J1aHJieCtvSHZqVlJaclg4anNT?=
 =?utf-8?B?WUV2dlMyQi9UZE9lM2RCRTZqbCsySjNwWTZUUmd2WCtXNyt2QVVueTYvSGZR?=
 =?utf-8?B?YjNwTnZrSk5wSkpTZ2tVZVhCQVIraTlzMERuS0tkaG1QQ1VNRmJkMzZoRm5n?=
 =?utf-8?B?Y2NvRU1hQnk2czVKYVBHNGErNk1CdjhnV09oY2tvMDhGQTFYdzhSaHh6SkNm?=
 =?utf-8?B?K283dk9FdlZaSnlpMDdEdXZlSzh4Z0RHbXFjSjBjVlpIY2pwdWthK1BVK2Jq?=
 =?utf-8?B?OGFrd3JFcWxPZHdETGNtSk52S0NaRXRKZW9pcWt5RXZFM29URkNYZ2dHRjBv?=
 =?utf-8?B?RnI5c0lZcVl5b3k4RU56blRyK0tNMnVrcG95NGtseFNhMGpEMzVTNHZtbW9K?=
 =?utf-8?B?ajZBWEVTSkhHRDdYMXA2SThsY3JRM0FoNkdibFphYjdsMzlMOS9TMUUrK25H?=
 =?utf-8?B?UzdYMnRidjlYOFFKYVdWajlQeUl3QVlYUmZoVlU3Mm5hZzVwN3BFNGZPaTBv?=
 =?utf-8?B?WVc0bU5FSWNaVy83ekt5dkNBbm1hQ3lPR0ltS3o4ZFNiVUdtRmFqblB0b2Q3?=
 =?utf-8?B?Z0ZyOWZQVmNvc2pCQ0MxTTEvcU10WXVVVGdiZWJiWkNVUml3SVBzUUNIY3Bv?=
 =?utf-8?B?OXR2NmFOdVd2cnJCdVJyZG9pUEY3My9xYWdjTkJCdnhvUTdaUUwzMi9Jb01N?=
 =?utf-8?B?alY1c2ttcS9iYVMzWUdBQzRrbkp0R2ZOdVBYcjB0UFozS0cvdXN4VDQzdjl6?=
 =?utf-8?B?MWNIZUhVdlg3UGNCaXlTL3pyL2dyendGOUpBVGlzNmY1UlA1cFBPdWIvWURJ?=
 =?utf-8?B?QWJncFU3dkEvOWM4Tyt1R2hkV3BmSkdlL0xIOUl0K1dKU1QweVpwWjdGOTMx?=
 =?utf-8?B?bXBEajVuVmxpKzdjZE9GdjB2bWgwWldHRWg4YlgvVmJaUnYxS1lGRWFGaFBI?=
 =?utf-8?B?cFV2NENNNnBsTE1paXBkVE9SdEE4NWFMOTFudDc4VTd4UDV1OTcwWXFTZll4?=
 =?utf-8?B?R3ZCOVhvZHhaL1V0R1pKNENPZXlGdHpjdk9pRmJNNlAycWVjUkk3MEREMUFF?=
 =?utf-8?B?b0pZdTFXVjNPa3lGNFkyK3B6cENGanpjUDUyWXdOSEc1UHF4clBESjhUZ2Yw?=
 =?utf-8?B?NjVUUlYycURHRVQrcG90OHI4aGE3ODNFZmY2WHpocVo4MENhelZVTW1uRVpO?=
 =?utf-8?B?TzErNzVIbWpjZjNTdHRGd24wRW9rY2MzNFluQ0tOdXBFSk8xdi9hTHUybDFP?=
 =?utf-8?B?Q0lGUHJ2ancvYkVYRnNWbFczUXNrblJlbWdqV1JqUkc1UDYxMWEyRHJyK3NY?=
 =?utf-8?B?cVZJRmtHbUhQVFhjNVdCQTl4OWVtOGpSVmhEL3ZHQlFkeHhHYlo1cVExVWNk?=
 =?utf-8?B?dnExMTNvaGVzS093Y3RyMWpISGJnWVNmT09KaHd1QnJSYnNiSXlSQ0g2SkRX?=
 =?utf-8?B?OTFDU1lqaEJmczdHZE1FMy9iK3NMTnJVVlJsbXUvVjZmTEc5Qm9QZVoxd1FN?=
 =?utf-8?B?akZidGRzS3dUUXlOTUpuVDFkVlMzRW5sT2QxWXd6V3hHVUZKRXljK01qb0pD?=
 =?utf-8?B?Mjd1anc2MEsydWVLd0ZDbjlLc3VxcHo2ZVRFb3crNXFudlFld1FQaE1DdFd5?=
 =?utf-8?B?WEJMYTJNanl6d3JvUmtsaWlpYmI4OEl4ZGI4cWJIaDBtdWtGZEVmVzE1ZTc4?=
 =?utf-8?B?bTVxb2xROG5rUkhKWWJPaW4zdk12MGtaQWpQNnFLQWdYYklxUzZqSkE4ZnNG?=
 =?utf-8?B?SGFKdER5L2NrZXlpNWdadTd6R2tNa2NWZjhTMEJoODlVakJpdFQ5RzBnUFhN?=
 =?utf-8?B?aHE3THpqUUR5MWFaazlQQ0lTanVmUDRETS9NOWxsTWZtcWhKam1PSm9mN3Ni?=
 =?utf-8?B?dW9UdWtGOHhGamY0dlZhcUlRcUthQzMrWUU3NHdvYUNDbGFwdjVzQlppcSsy?=
 =?utf-8?B?WTJxTVlMRzduQmtpY05QalVsRVRLQ3ZXTTZTQjlxWnBwcTA0aGorL2NwYlpO?=
 =?utf-8?B?b25zWUhxbTNncndQU3VmcDZqM0dnMGczNzB1Zm4vQVJ5TnFhR3pRejIyMEVz?=
 =?utf-8?B?d2dPVFFxblU5bnREckdJTXpsWkxxTVNFNnRQVnJJUFVPTi9iZnkyKzIySjFW?=
 =?utf-8?Q?qHMfZqftBdStE1z7jL/2ELehzJbPiMg/aG2K49bGqYw86?=
X-MS-Exchange-AntiSpam-MessageData-1: 5hKwJcC0ToqnMw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8bec8e-31c0-490a-5769-08de8fa6df61
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 04:26:41.1048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUusj8m6eupS0yfiP5JxEmtfvwF6rQN4cgk+9UodwXm/SzilRr47uazS6CzQNjH2NLrcnsZwIssWwTB0tvfVng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDF5E260D0
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

On Wed Apr 1, 2026 at 10:42 AM JST, Eliot Courtney wrote:
> The current implementation does not actually set the default values for
> the fields in the bitfield.
>
> Fixes: 3fa145bef533 ("gpu: nova-core: register: generate correct `Default=
` implementation")
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Don't forget to collect the tags you received on v1 (I use b4 which will
do it anyway so no biggie, but not everybody does).

> ---
> It doesn't actually set the default values for each field. I know that
> bitfields are being moved soon, so maybe this fix is unnecessary but I
> saw it and it's a simple fix.

Fixing it is the correct course imho - the common bitfield macro still
needs to undergo extensive review, and we might hit some hard-to-debug
issue in Nova because of this bug. I'll apply it as soon as
drm-rust-next reopens, thanks!

