Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E489CD8C8E
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F70910EF32;
	Mon,  8 Jun 2026 08:31:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rCyY24hg";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011027.outbound.protection.outlook.com
 [40.93.194.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8663C10EF32;
 Mon,  8 Jun 2026 08:31:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjSw5OjGYZugmWspXCxIpVv3UA6cxk0FR/aL8V68R3TlRgZTa8fr+BzOTrgdU+d9uXkGVifHvL6XUANy0vO0guRmZE7SwIAnHW4s2F38KOaR2/AbYTZB0Dmg6YQAU/2fh1nnHHIx7aMN95Qb9TI9QdUda0paUPgS5ykePvsI1wvHH8dJZ2cqTVGiXlaBaeUie8CzyJf1StXjItcbQONP+9WT6NyWmcvlPICX3hLHy/Sw2JeOBs3LMPodfaWQ2ejwodA8oFZgP/Qhh7CGYLeRINkEp101zSBMTk2rcBRYRxK3IWmDn/aY71zXGaCVJFR2dOqQGimnl1nHVMV8xl+P6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rmaf/Wll3uf0MlDFPIUnZsTqrNE7ymawUAMqChDcXfA=;
 b=Uxord7CB8EBWHqSVj2Im66UOTltxYn7DqtH5XIroscvCN46m+6ZF7hMUKZCbCjHl4bKXLISuwQBJXgzwAVs+ho887fHA+BVxxsbmY32W/DgS1lxiOMdg1TOCSZ1QAc0nLsPpp9VmeVlUFtET3D9x4S+oX2s1WN23hPOWya+Q72zQGmKEXn39m5YK0403eoDi9QhJRzQkkUmX3oJF3X3Wx7ry4mD9uG9U4UKt/dy8ObBbsE3mylb7RGYIwji1lcfk2+2QVn0Z5+0DFpHTZ5n/KwuXRwCUCOBUJ17a17gnNGxAeFRIXNAMU5XmXQFWkFVxiTcQBxnxhRI/1yVn2DzB1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rmaf/Wll3uf0MlDFPIUnZsTqrNE7ymawUAMqChDcXfA=;
 b=rCyY24hg62Wcvf4dEjJE0HfF7YEuqKVc/j8GuSldLdV2UJ15jEvA3MNv92uMoD0jcVJe//pRF5h+N/cpq7f7LwDlXk+XaoWOS0dqEfxit6puSdug9rCU/tRHvuFEDF0MhhDUKBNl3vsCP/qdLUkj44Mo8VzYmH0SVNc3M4iijnWwgEYBPW83IfDey2UGg1EHRR/S/rezGzQGrvskd8JVxmJqmQdPW875+H4VbO3Q3jvE1qMp1UmDoRl+v2RrDdES/1dvNrqTKQPf5FrjybT5HR64TvciX04mS2ueAYP+Z/bQmTmhZpgnGClPRRk0EstvD9Qgw+oqgYFPE7Lmst9JGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY8PR12MB7658.namprd12.prod.outlook.com (2603:10b6:930:9e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 08:30:57 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:30:57 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 17:30:53 +0900
Message-Id: <DJ3J05KYZ0TO.1O4R56QTR8NOG@nvidia.com>
To: "Lyude Paul" <lyude@redhat.com>
Cc: <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 <driver-core@lists.linux.dev>, "Miguel Ojeda" <ojeda@kernel.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Simona Vetter" <simona@ffwll.ch>,
 <linux-kernel@vger.kernel.org>, "Sumit Semwal" <sumit.semwal@linaro.org>,
 <linux-media@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Maxime Ripard"
 <mripard@kernel.org>, "David Airlie" <airlied@gmail.com>, "Benno Lossin"
 <lossin@kernel.org>, <linaro-mm-sig@lists.linaro.org>, "Danilo Krummrich"
 <dakr@kernel.org>, "Mukesh Kumar Chaurasiya" <mkchauras@gmail.com>, "Asahi
 Lina" <lina+kernel@asahilina.net>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v18 3/4] rust: faux: Allow retrieving a bound Device
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260604192740.659240-1-lyude@redhat.com>
 <20260604192740.659240-4-lyude@redhat.com>
In-Reply-To: <20260604192740.659240-4-lyude@redhat.com>
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY8PR12MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5d8307-2a99-4407-7278-08dec538430e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|10070799003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: V8ud9wF3ZakJJ60wX8U3khQJKVDQwdPoJyXVqfJEbVWtyOmPyPCQmDLZhY1dxzwi2rzt2jx+61SguLc11S5h4X/YYt+npZirkFs+0IPNAG6BR9hiW9NI5ICdZehAmIT9+p4003b6ptaOetJZ4VtAe8tCj63eaWkfZAqUhd7Fz1vUOwnX8IEu9AHPiGUlo0b7FJzWOIP2WS7wTq5I1bQBNigCII0gBy0PAoiJ5N/1MMQ1NVOTPZ1ARUraGetK6owWmbV7pAptX5IxFxcR5w5EAhn7/H8AmOgbcqrlHaPUCJAaKYFHotIAV5sztjHCOGEKyH8bAsloFiazBsgkFqPxsdVOGL4v2fj2RElvx8PHcnJG0mVc2zrBT92nXk1KkywI5t3v11gQRvrV11JaR91+F63v/6Xi1SsR/BliYrxub1g18fcBm/MmnpacNaufMp1CcJjqYql+ICUwLGwD1k9Wx+bJDe2oCjXxbB8VfNyV0di5SM7ylZxkyMiAg8mlz0jOxJLnUhS/F3WunHIfOwWq6bQlKl4cGMrr3MfxkUt/UPbOix0xopJVUSIbCv0CFGn830z82INdJTDGWsTYcUG5BFddQSBeTmxVFVjzpqRORe3j59zRk6NCBNM4JKrvlMAqgKevCPRZ6cpcri1Ifte2a2I3m1JOTNZDH0wr7S0yZBw3aVwtQ38t/ml8fyZA5yBP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em1Dck52U2FvRVhQV3hXN3FDWWR0V2R0UWhJdjdoMy95YlVOZWVyd2pDVXFI?=
 =?utf-8?B?R2ZCQmoxaHdnbmRKVTJMNFcxYlBmSTZ6L1MwUjlnaEUrV2VCWVRtNjlxeWtU?=
 =?utf-8?B?S2FhbjBhd2JsSEF6R28xSmV2Tm1kbnZ1Y2lLM20wa0l2dGc3dTJmdGZWbG1n?=
 =?utf-8?B?VGJ3Vi9SRjVjVlFPdHhwaHdZaUV3VEVSeG1iMnA3VHhCUGxIdjROTHFNM0RT?=
 =?utf-8?B?SFk5SHZOQ2VFNlgxQUcyZnkxcGMrYUtnbGtvUEpUa09SNjJRaHovbGFVZThV?=
 =?utf-8?B?MFdaR1o3TW5qS0tTbXV0WmhzbDhFamhBT05IOCtGMVArOUVmRFphQnpwNkZM?=
 =?utf-8?B?RUJQZlVvZlExMXVJQ2pzaW1idmlyM1BtMEllUmJIMmltK0JlYXc0T3gvcFhz?=
 =?utf-8?B?ZHZkeHVzWFlzVFVvOXF6RUdaelpxWGNEVUpHUjZxbE0yUWZrV0VjYWtXL2h1?=
 =?utf-8?B?RDh0Z2Nic0NlclUrM2RsQno5dEZ2SDVtK1A4cFROQzQzeVpVQkFCVGw3ZW8x?=
 =?utf-8?B?RkZPRHlkQXFtWXNDSVdBbFlqSDVmUGY2Vm9POG4yYis2OXhCN0o5RVpvbnhs?=
 =?utf-8?B?ZGZmQysySkZpTmhSUFZCQzBGQ2xGbk5tVk5VZjhHaXdaaytoODUyYUg0N2xN?=
 =?utf-8?B?UmVOdnZ1Zk5HZ1ZRZy9HUnFiNU5mUkNud3F6c24xbGtVYWNUbkFNeXFFMklk?=
 =?utf-8?B?YkRDQWVDcW9GOHVOaGhlUXdNaU9tYlFNZWlkekgrRXJwbGVoUUV3ckVBZWVU?=
 =?utf-8?B?RytQeEZaaWtxSk1ZSXBWMTl5QXMvcDdpNXVXaVJwZktZL1JGNVRibzIxOG1E?=
 =?utf-8?B?NUxmMkIzRmQrbkdrUm9KeVEybk9MTmlaUWp6WHZaNEtPbzIrRXpqc3BUUm9X?=
 =?utf-8?B?MWtxMld6WjNRS0d4TUh4QytLM055MTlMVDEzYzFyZC80Si9IZzRjUnFIUGw1?=
 =?utf-8?B?Skx6Qkd1QVJUWHdPSVlib1RRcjV3MFhXZ0d0dll2YXY4U01KdE5pUzQ1eDl0?=
 =?utf-8?B?alZMdVJZbkUyNW5zWmRaU1JkUDNHWDR6d003K1dzNUxnOExjV2dvNEN6eEdn?=
 =?utf-8?B?YWxic0MwazUyenJMbXI4cTJWRzBJWVJvV3lYRmJiM2QwV0J2ZFhjeU90c1lo?=
 =?utf-8?B?MUFqbUh4RWc2TVdoVTg2UmVPL1lZYnl3NjIrOEZpMDNZcmJJa2ZwNzFIU1Er?=
 =?utf-8?B?TGdCaVdyOHhNTTdlYUV0cmJaRzZrL2xGc2oyMGJIS1U3ZlM2MWRJTVdYak5a?=
 =?utf-8?B?RU5kVGphZlh4TGpFby9KMDQ2bW45Yk4xby91b3V1Q0hsY0FJdTI5dm5TTS9t?=
 =?utf-8?B?Y3Irek9YaWRGVE9sSmF2T1lvMXE4c1VqYzNJbFY1OTc1T3pXbG5lMHpUU09Q?=
 =?utf-8?B?MWNzSGsxMWRmSGhLRCtLZ1lsRzFaN3AvdUtzQkFsNk1BQk1oU1lETlg4VlN6?=
 =?utf-8?B?amlzSS84S2NrSGJHVjJ5UE54elJFWFN4VVk4dWlnbEw5SC9mYWd5MUF1Lzcv?=
 =?utf-8?B?S0p1TmI0YThkdjltcWQxNDVCdzFqK0N6Zk1vTUc3ditCVGRFUjV2eFg0NUdD?=
 =?utf-8?B?Q0tkeHZBRGNpcWIycDZqNmpRVUljOUtvODdYbEFETEhpVXdtNkREd3BQby9v?=
 =?utf-8?B?OFF5NW54ZmdaUGF4c3c5NWdPR01EWWZXM0QwNHJySG9zUFBYZlprU1lMajFh?=
 =?utf-8?B?Mk9uZWo1UkpPd0tQSGpPMTdSQWhSODQyN05xL3IwcU1DWjJVNUZPMVRPVENU?=
 =?utf-8?B?cHZxL09UdkVDby9Bd3AreFJWdEhrRWFzSEVhdWdPNXBXeEwvUDJ2R1N2elJs?=
 =?utf-8?B?MkdBSTlXMWNNWGVmSEpQVnRhOVhsOGFndHdFa2dyVlNPT1ZkWDEyQStrYzFN?=
 =?utf-8?B?cXZadlI3bGY4bnlCa2JBbERiUWFlcmU1OE5iZVVsSE5JbE8rVkovZ2JsZjRl?=
 =?utf-8?B?NFhlMms5UERSWFBCQ04yWVJSM3FiakFwQzQyV2ZvWEJqdDZTSktkakJqTnIy?=
 =?utf-8?B?T1hDS0c4YTlxZ2c2QlhHNWtRYTVKbmhpYzUvTndLSTViemdsS3loYURZRXRu?=
 =?utf-8?B?RmxqNW9Ka2ZlNVhBN1pMWXFLdHRmN1Q4bk5zQmFteEpHZFB3cm95TjlxNHFE?=
 =?utf-8?B?bnRyZHpkR1pONkZzMjFwbnZ0cktyakxmQ216VE5TRisvQkFDKzd0S0pDQVZ2?=
 =?utf-8?B?UW4rYkI1TUgvb2p5d2JLeVdQSXRiaVlFSloxaWtLbGNQTXZsSkZoNGFLUXln?=
 =?utf-8?B?LzRRaVdnUHVndHBocXlJRGZWWmhwdGJxaWhyeDE5cjVzbWNYOFBzZ2lXdnQ4?=
 =?utf-8?B?OVpxM2hCa0Z2ZVV5d0x4MWNDZVBWaVVrYUZ5NUNTZSszalAyTDhQejRxN1hs?=
 =?utf-8?Q?Yk1vDB1igJqzz5la57Cu9SOgR545VFT6A4V9bUj0KLN9j?=
X-MS-Exchange-AntiSpam-MessageData-1: dxG1zWeNfJXQDQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5d8307-2a99-4407-7278-08dec538430e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 08:30:57.0295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TacqNG/w9aTh2CJJvCZb+5tDA6fbvC+N0VY/o5ACSC1Oq+2Jd0h4RwYNlINOlbqCrY55TtSa4VMY8cEntG8iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7658
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

On Fri Jun 5, 2026 at 4:24 AM JST, Lyude Paul wrote:
> When writing up some rust code that used faux devices for unit testing, I
> noticed that we never actually added the Bound device context to
> faux::Registration's AsRef<device::Device> implementation. This being sai=
d:
> the Registration object itself is proof that a driver is bound to the
> device - so this should be safe.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
