Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01878C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 04:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 566A010E430;
	Thu,  2 Jul 2026 04:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="YNGVZ8/L";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01EE410E430
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 04:54:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naIK1zNMaGFkJ1rwmYFDVmX6vepEK1tOK1JlC/y0U/tWzHU+CMvVQ1fNgmoVq3iDvlyQipTSGkB/8plgCmZxOKxp+VsblcIfNBv7cA92Tzgg2MdEDq5kncR4eiFaHVLRIix/RogxxYtXjjUM8AJCCPmkCuakSkWLM3tylmFTcHU/r9UB2YUC6vdHex227SoA3NXyfkd22a750Mw8Z6BkwaIk40QjXzbq2yTrp4MaxVpZMghTe2BTMuX2/81ukFwZrN8tVlxmBPUu84xq1WCV2EBauU18RROZ4phIDKm/+vHFNGi7p5/4jr3oSNJuGJU01NT1n8Dsg4Z+V/X038TAxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9UFtf/fJW1E8zfGdM7ieRoovAuULf1MSQsoun241Rc=;
 b=tbVHfj41laSmVjj/igNHnxPRSlZmiRZCmfVz2X1T8s+tBHr5XO/yNgO1uu3wLmUTNE5jgCFLo0tmBMqUgQmPNnD7AyqmBLRe7nOKKFOKE9Kfg+AheI+tyzPaGCYN/RQILiJGp3jsPbXYtvVgfMJHFYVIAa2hru5jHfxmC0ixTw3No51BfODfMgm0hVqSyxplGAvNBOutACGY2AgUbandrWfyVKs2WCvC88LeNfIybh7sk0zdERIbXulut4+o1TjeotEExQRDDutuKJy3QSC7E3sLdVxtkcnmWVBsPZWWqIAta0ZpGT+f7wDn4YmljUuY0AwdbIDkUoaP1f51PH8aPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9UFtf/fJW1E8zfGdM7ieRoovAuULf1MSQsoun241Rc=;
 b=YNGVZ8/LVVPQVojn2y4Y2JC35Nwbdv2q1paX7vPakvCOQDT0TJRUWJ9Y1fvAie2AO9bqBxsB9czSQKfLqtahp4D0YoCgaQ0LkGt38R2Zo6n2JH4Ri9IiDz3z7xaA7cemCvktPREoryIpq/cLnwB6y5dVKVqXoxzehoT299/4CKfSKJC/VYgi39VSDWU7Qu4msYj7TSi65o7UmRXQCFOTc42PPxbG45uD0UReJDc3yvdVMw+VroddGWXVA4Ny+fvCa8dmFVtVqGi17Ph0qBVh/y0sG+OQgBbwxcUV6V4nU9PuVOJxcGiZg0TFAKlip+N5SucrALx/mv92f3ocC4ZbDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB5865.namprd12.prod.outlook.com (2603:10b6:8:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 04:54:22 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 04:54:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 13:54:18 +0900
Message-Id: <DJNTFEJTQQ2E.3FJ9W7J46HRPM@nvidia.com>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <ecourtney@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <lyude@redhat.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v5 10/19] rust: drm: pin ioctl Device reference to
 Normal context
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-11-dakr@kernel.org>
In-Reply-To: <20260628145406.2107056-11-dakr@kernel.org>
X-ClientProxiedBy: TY4PR01CA0063.jpnprd01.prod.outlook.com
 (2603:1096:405:370::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: c488bae2-5997-41b8-fae4-08ded7f5fb5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|10070799003|376014|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Sa/SGb3yGIUTwGgjVzK/PTLw3uUIMN1gCRiPB5927HqEqLFUZt9/fyDvioM+AIXfu/mNt+PHD9HI4DEVwuLwPGQGS33w8a0Ht4snjx1Efo23XMTL2TwEtJgC4CRLbePU+4mwyl19ZNVR9KWKGwCAVnBmkvBKU4se+WIrw4PoVaaYQagKGlkRJ7gedxuZScEApcWiUUy173ijL1PTTmQ+YmNKis+rRIt2/JlAv5/+hV6pz2d4JYmoRG4ZRONIJs4yB2eoPNTa6iBD2ejPDFFKeL7WFd+FetCgUFIRIKMjjRdbFbjEcuqb+3PXqxgkxcAvyXUtr75FlbyJ523ideaILJR8bILCsn75uaIrP66FTNV+HxwnMA58GHe4G7aXBGpn5IpD1OnD3koeLi3Uyt6FGJBllw2+lzkxm4ZNu9uMjifdmMVelRAWvwKMjhyoaWOfRbxe4C1txwFx1aNuXkNmOBbBJ7ArZADq5Psda0AD0q7F3dg30ZfbLrr3RgovUyZ3nNpm3HBHQdAzcNkavesBttGO10+Xvf24PNIXJvHr+sxVNL+M62CdMZdoUuW0vYnG7GLNW64b/3XdIopvX1G8lf1v/O5k/UnuI7dp5HCIrovAzpY/QsELPiD5cWa9mKmn8Qn3spEnhsHwhqHb0Um+Pifla6XLGSZA2M4GpMD/kII=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(10070799003)(376014)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHdkYVRKVUU2ZHhJb1JRRXRhdlA2RWlvVTd4UlliK21LU0tzNzFET0M0MG4r?=
 =?utf-8?B?Qk5ZcGtwTHFvQ0JRZXIzSkkxOStXd0lhRlBFR2JoS2lBSFk5SVRSbEszblJK?=
 =?utf-8?B?M3FySkNxM3dONWd3NVF1dmg5NDgySFE0Q2ZxUndQMUhLaFJ1REN5V1I4NmF0?=
 =?utf-8?B?Tmxtbmc1ejlqMXRzWHgzT2JLMzR3bURsd0tKVkVzMHNLeVB3S1Fyd1ZUOXE1?=
 =?utf-8?B?QmZXVFFOb2dnaVpoNW9WcFI4WENtdFVnTXV3UGRCc1lzdHdLZDFnYVhWNmVV?=
 =?utf-8?B?eTZES0dScm9NZzdBbHlDMlQ2WU1BN2FtL2ZuNGs4OFcwdlViNDY0dzNaeWd5?=
 =?utf-8?B?Zm9adXJQKzF3T0JSdEdJNTh1ZVFVcXloNEZIb3JvWGNCa0F6ZTMrZ3lDaGdC?=
 =?utf-8?B?L0tJbXpLUDBsbHljWE5uT3dvanZsc2h3QlhQby9nUTcrTmhnd1NheDV3dnNL?=
 =?utf-8?B?by92QTdqeEczVFZqdUdDVUpzMlFwY1l2MDhyMEJqbFBYUXhsMnVEbmRPNlRZ?=
 =?utf-8?B?aVRTcnlFc0crVkY0VDk1SkxveVdhaEtlQ1I4bm5JU1RDQVFiRUtna0prUUJk?=
 =?utf-8?B?VXlZYnkwMVdkdWYrT3haTE5UQXNuMHdVR2xnRXVFend2emtaank4eUhqaXZH?=
 =?utf-8?B?TmdycndEaTllM0R2c1ZzQTlxZTM5c3IrRUFTU1ZzcXJJcTFWMVQybDNVMldE?=
 =?utf-8?B?VUxzbUk1bGFrRit0RHFaOEF1czZmdEY2WHV6YkFVSEppZnMvZnM1L2ZZMTZm?=
 =?utf-8?B?ZDJUTmQ5K29qMk5nQXpENkRWb3c0K0RSQUp5RU90UDc2TS9Gc1BKVUt4c3Y5?=
 =?utf-8?B?ZldPZVpnWmRtdi9lait4ZHByeEoxbVNBN01SVUFoS3JOTnQ3bzRSRHhIT3VS?=
 =?utf-8?B?bnBJN05WNCtxUjJ3UjFuWXgyNFlsOGJXR2lLanNQSzVoMG93ekFuZXMwc0ZN?=
 =?utf-8?B?SjFOTTUwQTl0ZElzdURLTHJGZ3dKRkpibnpMdVkvQnQxbUpMSWd6OTZrM0hL?=
 =?utf-8?B?Sjh2TldLZm5hVnF2byt2QTVFYkFmT3ZkYTd4NFFJai9RdTBjdEFhK1hlSy9U?=
 =?utf-8?B?R3AyUE00dDlKQ253Z2FUS2tIZ29iWUJqWm91ZWJXcVMrWXZxM25DYmxNcEZ4?=
 =?utf-8?B?NkpjcjV0eHMwQm5nbEdBVmhxd3hVNXpaVTNnMFVRc3RsajhYdGJRL252SDhR?=
 =?utf-8?B?Zm1LcGppWXhOWGxjdW5nVXl2clRNQnVhTzMxb042V0h4UTJUcHhQMnM3am15?=
 =?utf-8?B?TUt2VHh0TVVnNUZIK01DSGhFOXRJSW05Zm5kWlNqOWtBWVoxU001M1dvVGVS?=
 =?utf-8?B?VVY1N09ZUDJPVGkwSWdFQTZhejFBaU4wMUVwSVBVYW1mZDlmdXdNNXlrc2M4?=
 =?utf-8?B?Ry8zbHB0NXczR05yU0Z5c3Ryb05kQVlrZVRhelRueDJwRjB1eHdYbG5wQVVz?=
 =?utf-8?B?c2FWbVBSN0tYcHltbEE5SS94MUhXZjNuVFpGYldWK1NWSWtsYm52SHVyQVpU?=
 =?utf-8?B?MFByRWMzelF2N2g3OW9wQkZDYzdYS1g0WmVHVzNFUGxxMEFWMnM0M3grcjV5?=
 =?utf-8?B?Sm5XMW9rZTN3R0hXV09SZkFTR1pZOXUwOFZaVHZldzUvRkxCS2xIblU0ZHBo?=
 =?utf-8?B?U0lRalVjS2RzdkIzUlBHb2pPRG9XTGNLeEdBY0RhNjJqMHJqajlJRTA3bkVY?=
 =?utf-8?B?eW15Q0VxdlJTaHhsQ2ltREM0NEpBOU1wbWkybkhqRG91Tm9sbkFkNTY0YXFi?=
 =?utf-8?B?NENXU25xRHplS09LQ090S3Y5OTVsMWRYa25HamhNRHVqM09CVURUUS9NUEIv?=
 =?utf-8?B?b3M2MjBYOW9Na0VYOVh4RHdoRit0a3paMmF4VHJwZjNGbkUxSGRDS1BSSXI5?=
 =?utf-8?B?ZnNPcG1NWVpCRUx0SmNRc2FTY1Q4MitWcFVnY25GQUN1dC9MKzJMKzk3SGZs?=
 =?utf-8?B?dDNudThqWEJIam91d1VVTWdhK2p4dW9UT0xtSllrUDFON3VISVlPSFlkWGZG?=
 =?utf-8?B?aW1OY1pRajFOcFAwOXNOeml5WWpWd1UyUGMveGtveEFidjRiVUdjMXFnTDVx?=
 =?utf-8?B?Tk1rUGErSDhtVWF1RDdhc1VZNURXMjQ5TWxDclIvd2JJSFNvMjZXTWllaDFr?=
 =?utf-8?B?SUNJQzZYbjB6SlBTa21uY3o3Zys2WjVPT3NnbFUzdFppNG9PU2EzUnpxVW40?=
 =?utf-8?B?K0pOVzIweXJVeFRMUGJVaXdqbUYzZlZwbmJ0Z3hzWDM2TEUzNWNHTTh2Tzl1?=
 =?utf-8?B?OGhLdlNCVGJIaHgxNERMZnpKZm9oYWUrUmlraW1IWXNQOFpqUUIrdGZjYStH?=
 =?utf-8?B?VWdZa0pUM0hpTHE3bTh6alVsQnRxbWp1YUcxV0RRcG9iczNSNFRMMWg5WFdR?=
 =?utf-8?Q?nFFlKoSmoKoJt/TaAhGIdw/kyHc/rwwTUODkmeqm0yBjk?=
X-MS-Exchange-AntiSpam-MessageData-1: Rl+liwZI1xX0sA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c488bae2-5997-41b8-fae4-08ded7f5fb5a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 04:54:22.0541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QQ/8weaVgSFXgVU4CTS0JtSpxDiGkoMiZ2sU88YZ8TjWe8d1Ru4HloHDIP6O0I0UNq7MXF6er1yGsAv/w5C6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5865
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

On Sun Jun 28, 2026 at 11:53 PM JST, Danilo Krummrich wrote:
> Explicitly annotate the Device reference produced by from_raw() in the
> ioctl dispatch macro as Device<_, Normal>. Without this annotation, the
> context is inferred from the handler's first parameter type, which would
> allow a handler declaring &Device<T, Registered> to obtain a Registered
> reference without runtime proof via RegistrationGuard.
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
