Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A2EC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 07:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6888210F040;
	Wed,  2 Sep 2026 07:59:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TYw8lMvl";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013012.outbound.protection.outlook.com
 [40.107.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27E7A10F040;
 Wed,  2 Sep 2026 07:59:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcGO1Mm2UcflNnjITR9HmoZPSGFRqLqJDmsrPpZ1dNbHpWOd8mru7tyQFCOAl0M9beNOdaPnUn+aN5+0xJAdzB/QbJU0EUWNmP4GNilbJkVfzWPNGPho6ltBYDcsXtTKerBWlWmKqk8pnsAnQPfb85d90VlCxMI4Ud14ef/zGPt8zObtTfgqbNsgl7E+fLElNQ89PV0kUBpYKGu2bqpJ49feOQ70d0q3ajccNIQG/bq7IrfE9AKo60g9ZzxbjTRiFAJiDCE2Y9fFqEVzBYfmYlRLNmtzK9yNFJ5vomerqnUG/VJVomEUgnpujneD+0AZevX8Wgn6Maa+9Hjo+acNTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaOae7Au1nOcdzsoiLAOdFRMWoHsI+dI20IATRI0yaE=;
 b=byUwznhMkAr4DKAVZax74d1MlyrbIsIdroY5UULxmG+Y1cXbBKzAzq6RAgOHjV1n8b/FiSwH7VQsV9xs4+Ewi5+KpPS+esLyxyOohKFRA1xvPTNN6OJyqpGcNa+r9+sgvp6JOSlAsIJhS1xmcmbTLdD+2xaK/rV14YW7rEud0m8tKLRCo95/EhNzidl3a7uJtVe0HGq3Qw9nQ6HBBjdo/Fszr3+Y0tGcm2uSQmsw0usn2tC2kwQYO4ah+I7Oi//7u8iS/ovpQsSB13uDZbxUqWVWofuGTP1z5sxWmXWccjcexdMkGlpzGNQ1wTt7Q9NDzMZKz7zLdacEwzTEaufqOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaOae7Au1nOcdzsoiLAOdFRMWoHsI+dI20IATRI0yaE=;
 b=TYw8lMvlsMK2vD9FSXZ0kYQd93bbLMZtBE8BS9vgGTdXAOvFQbbqO3tnTNo5OF4tmth0FB/xNVQR6qYzsvJzwBD5X1RblP0uvjZuVpsroT1esksY4JMcy3N9sd4YagcydGLWe5oyRS/K84ZK4egLjbiD94QZe26CtH8fRGWwrOrnCcSjr41DFN3p1aqPkK2WvPH/W+3uH+vHHBtKFYmk2bB4krzAflO/61gfjV8DoYEthSmXdSMpVTPsW5+c2Qr2dXrQItlp7+jFoezLtUp1G/LhTnavCZ00AD7YgeTmtImZMxXekilox/PkAEQ1Vdqi3m4vMDHrmwr1SV7uF1ZJRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Wed, 2 Sep 2026 07:58:54 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 07:58:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Sep 2026 16:58:51 +0900
Message-Id: <DL4O6H8CRTEE.1AFLODAI3F53N@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 2/2] gpu: nova-core: fix barrier usage in GSP->CPU
 messaging path
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260901-rust-barrier-v4-0-94427f445310@garyguo.net>
 <20260901-rust-barrier-v4-2-94427f445310@garyguo.net>
In-Reply-To: <20260901-rust-barrier-v4-2-94427f445310@garyguo.net>
X-ClientProxiedBy: TYCP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::9) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: e3070d04-42a7-46d9-a6f8-08df08c808a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|23010399003|376014|22082099003|18002099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: ZgEt+YxfbmNiXDXYel99HbE2Nvmph6CnhmuEx/VIGToCpf+V7nvk0NU2lNA3ohW7n6E2JFpN2ohSaVA7t9uh5j4kcVIZV9kskNIsQhMOpqucXTbEm+bCgS4p9mS1BQiMzChlL1PXNyrmk0sagETQK6lcucGyX25UH7dKr+A5Y2Cw8ht0nk/7IxpTARA5YclzO54BKe5jOrO+nEw0HlX4oBbN/VbpbkREh6UT2gXErHF+1sk87unYGkKaN7Ux7bLpmVTa5/qNPUbZALfAsie18suf+ngY/OnnsqChMSpT3Fjygxa1uo1LkJn7oMm4yBNroRXoai3+4ZhxJng8gWzTb76eC7X57rc1WlTmIwBqtbRWHLb/qbjFlOxCW+ppAUy+KPuyrenWWp01Q3pUDofHupa/zBfSMWwAOcOL4evY6d0mdVM8W5SlfH0WpdrUZeKhqUUGuuCMNoZZ8bz3SfhxX/evL0O5f40niL3/CPJGv7kDVpmuny8ulZXgr3u/ntN3tQUBPICgMXUZWGnQO0HFQUYhvPZGYIQnon9UGTTk7NkZz/s+i8ir8r9TMIAtyx7ZvkebWRYbuPMW1sjQAd/5aKDAB1IM7Ct1SWUolfMnE+4AaX6Bbd+6I9im9jdN899OcO5fNzHWZFAYXF+7y3HyqAliWL+RFm1foE/6U3fi4HM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmxuU1doZjZZZllVT0FPOHh2dlN6bVc0NW1KSngvM0E4cElwOHI2YnpyYWNI?=
 =?utf-8?B?T2E3ZG1CZ05LN001S0UrRzNrNWt1K3lvRStrNTJyUUdYeTB2Sk9zTjd1TkZz?=
 =?utf-8?B?UUR5cFo0RGw2Q3V2VWlpSFlHTi9MMEpsaHZETVc2dGRrU0F3VjJ1M1IxT0hJ?=
 =?utf-8?B?Y3gzMHY2UHFlU0F2Y0JQYU9YS2VtMmtXQThscU9hdURTZm42cW9PK3JxTXU5?=
 =?utf-8?B?UThUYVl2UDNZcmlEaDc0S2pieGU3QlZYdFZQRGJXUDg3aUhoZG95VEdIdzZo?=
 =?utf-8?B?cXBCOUZYdVluYmZoTWt2TUo0QithL2tUZlljdVpzNjN6WWxWcU9RR0laR0V6?=
 =?utf-8?B?azZWckZnencxTjh6SW92cXhFZGt5SzZubEhPcXd1ajUzT3NGVlFNYTR1YmJU?=
 =?utf-8?B?K09KRzNjb29DYVVUeG5valpYRUlwaU5GdVFlWUZGMGh1aEgxdEhVL2wrZzQ1?=
 =?utf-8?B?dXdEVFVKUmM1a3E5QUxQY21iYkxrZ3ZjRkpXb3NLQ3E3QzdvODVKZERWZEJs?=
 =?utf-8?B?NHFRSHo5SWtQU1hMa2Z3K28rWTZXdlRkUmt5Uk9PYkRxOTdRb1p4aHh4K3or?=
 =?utf-8?B?SUFsbHFJWTJwaGxxVnpwQ0xtcG5mNE5LaXZ4TGZxSzUvRklzak1YNGhocDJU?=
 =?utf-8?B?MUJaNFZJSmVtdWY3aVJ5Y3o3aGpzMmtack91a0dCaXVOOXlzdUFRRnkwT1hv?=
 =?utf-8?B?eUdkT3ViU1VVVktENkJBdlhsSVBxeHJld29Vc0RnUFhweUNVNXlsMDRSNGZB?=
 =?utf-8?B?cXFWZS9hZmVjRkFHVmlqeVg0bkYwNDNUenpTQXZXU1I2c0ZybzlPeFBwU1Zn?=
 =?utf-8?B?ZGdSdmxBN3VyOXpudUhWSCtkQ2Q5NzNXQUJpck5TS01udE02d0VVcGN6dFZI?=
 =?utf-8?B?UWkvaHYyYmpNbElSWmtSZXI1U0xNT3BKVFgyc0lMNVF5b3Z5bG5LNVlEQldI?=
 =?utf-8?B?UmwwcjJUODhkVGkxcTArZDg2d0JtQWg2RzRwTzI3aXVuM2pEL24xc1AvTFd2?=
 =?utf-8?B?cnVtZGFzOTQrSzQxU3pybDVFK29ubk5iWTIwTVl4RHlPYTJ6ZlB2VnJrOWZv?=
 =?utf-8?B?NXZmT01xZFdjZ0l4TXl4UkxsKy9ueFpTMndERlU5dUxOWGdqNnlwZENXcmdS?=
 =?utf-8?B?OHg5M1h3N0h3Wm9YdzV0YU5KN1BHUFgrcERyLzBsaVE3VnhiS2p5WlRJL2dL?=
 =?utf-8?B?bzZkbkRudUZUa0x2akduMSt4VWl5WGxjcHhHZS9JZkkxTXJ5aHo5Y1Fyamkx?=
 =?utf-8?B?b3VWMGdsUWFyY3psa3poRU1sbXhheFpOVzZNNTRLZmpNeC9oeWluTGZXZnFm?=
 =?utf-8?B?QlpuN21oRUhSVWs5dWtMdk5zVVFKeC9zOVh4T1p3YXhuZ09tUzAya21KdjM4?=
 =?utf-8?B?eGJFdThiaEthcHNUV1p4eS9tS3JidFltaUFoVjRORVN3cW90L0VGVGNrMEtu?=
 =?utf-8?B?VjljOG00QUJiQXlpTHZOTjQ3elV6QWFwQUdDbkpiZDFQZjRmdWh1RzdHbE5O?=
 =?utf-8?B?b1BJdWJCUWtJVGM1aHI1MVE2eGNBNzNXYStTVXprdFZzUjJweE1CTlNWYXRn?=
 =?utf-8?B?Yks0U29kZWp2cXVYN09QMlI2R0JlRlNmOXUybGp4NDNuR05HZTlBWEd6Wmlx?=
 =?utf-8?B?bGJpZHZRbTV1UU1yekhwRXpFWnNxMFhDTFI4bitCdWNuZ2NnOVRuazZlT0hK?=
 =?utf-8?B?WTl5akl2RVllbWE4c3ZaNmF5TUM3YUp2Qk5IRklSamtZUkg5bmIvZ2psUS9x?=
 =?utf-8?B?bGlhdHBIOXJxQWhEelltUTVyMWRGTEZUTElEK1J6djJKdkdnWUpkSGh1dmpO?=
 =?utf-8?B?eG1PeXR2MDhpVmFqbGVMQlhkeUxKbkRyWVppYkV5R0ZRdHdRUXFGWUxYUmFt?=
 =?utf-8?B?VElsbzFOVWRXYkRaZytNVHNpYnVYTjhaZFcybll2OGIybUFCcTFIamMvU1Yv?=
 =?utf-8?B?Tzh4RmduZE9kYmZTL3ZFbzh0QVRCbVM1WnhYZVJ4djBLNUh2L1ZZVEFSd1c4?=
 =?utf-8?B?YkFUbjQ3VHpqd2tXcFAwbTJuN3lNUGQrSlc5ZVdxUUU4czhyQ3g4VFpRNGlY?=
 =?utf-8?B?RndpSXUxVXZKdWxjTnFmVGFhaVl0R2x1UE1oSjJnd2J1WTV1MFJiYkhmSFJs?=
 =?utf-8?B?RnllVklIZjF5V0lOa0tETWhGQXU2NWRTQVY0Q1JTdmFuOTRiKzVwYk1ERTNI?=
 =?utf-8?B?RXJuYXB3TWlpUDk2N2pqcWd0OEpoemVMZ3BnSStvRnl1UkpqalNONzFZZGx1?=
 =?utf-8?B?aUsvWjRoNlAzOFVydjVMTFZ5bUc0MENoU1Ftck1KRnJhZ21JZ0hZWUgrcS9P?=
 =?utf-8?B?a1NwTkhPYXBmcnp3cUhtamJNTEpPeUgwUXFINzFYZGgvQzFOZnpUUjZhL0h1?=
 =?utf-8?Q?QSiyu7MjAnNLN2jSeiSuREO57srMPC5C8yZpDDlbMc94X?=
X-MS-Exchange-AntiSpam-MessageData-1: KLNfLhQBrrqi+g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3070d04-42a7-46d9-a6f8-08df08c808a5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 07:58:54.2851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abUD7hmPOAXB/r1i7YFofFwYVQmtzQipr+g5GE5K9zUYUp27ZUqgE/zhOUPCA5NqrPE269ymoVhoWS9A30mhLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388
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

On Wed Sep 2, 2026 at 5:59 AM JST, Gary Guo wrote:
> In the GSP->CPU messaging path, the code reads the write pointer from GSP=
,
> reads the response and advances the read pointer.
>
> A LOAD->LOAD ordering is required after the write pointer read and the da=
ta
> read. Add it as this is currently missing.
>
> A LOAD->STORE ordering is required after the data read and the advance of
> read pointer. Currently a Rust `SeqCst` barrier is used, which roughly ma=
ps
> to `smp_mb(Full)`; this however does not order DMA operations (notably on
> ARM, the generate barrier orders inner shareable and not outer shareable,
> which is ordered by `dma_mb`). This ordering does not need to be in betwe=
en
> read pointer read and write, because it's for ordering between the ring
> buffer data and the pointer; the RMW operation does not internally need a
> barrier (nor it has to be atomic, as CPU pointers are updated by CPU only=
),
> so move it to before the RMW sequence for clarity.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---


thanks!

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

