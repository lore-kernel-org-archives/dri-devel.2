Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398B2CD3423
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 15:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8643E10E29D;
	Sat,  2 May 2026 15:42:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="KKMbv9cL";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012013.outbound.protection.outlook.com
 [40.93.195.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82C2410E29D
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 15:42:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnalxDZ8bEgIBXm/F8Rk+4v9wNP+Ya2brGbHMkKlWHTq050hIhCpXgttNY3r5xbri4CJT/oGDPW2iTCj0YHG0li0ZLiPFMypkXo4h5k9w8zLXP9vxj+Fkh5L8Zp/ljtkgaUc7WcxV3waL8b46svqSHKkCPceu6MiXaTRh3uwadBmZKkpPz0W+f02UF2ytPGI+PQthdHERtSY5X6tTgJJ4dJpRdT2Y2cIu6p8kCWrOp12hkvBNCg9PGUiJiQsWjHKqxTFjs17lJs6GzDLBs4bmjOYQUBFnL/OHIyuRjgDEXb6dSg1X17Xs9gwr/qw3Zt/up8IIKUJKaw1hmjI7YTiYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fg7MceDFb3nlPbopQ1JOPUk9B85nNXLyLIbXeKiUt7g=;
 b=xfP7fEquazbD4GB6tKdQp+JFmmwN5bY81zpMsaAdqV+4vAiWP9n0Lh/1elj3LtefS1mGQMbraR/tRClpxzhCRu90EiwNTGlRR1XMXjV31N8FR7Vv7YzNJJClY8wqjxFGEida0wZ48mdz2jK9BRYMRLRrPj2JTIKAOl6oGJ9yTY3MeKJx88fmnD4/tWWhwBbWskuh1sX1bmMppiC7+5Quj8g5dbsxyn6IZnJN0LB7g2YI2Z9jgnGC0w30Qo5jED9jAfb7ObM6EBvkwQT7WLGpbvAVRbufdydGsORrPIJHNs6ni8pfUxY3xRNxi5wZWf04z3tnLaaa0nUy+8TFTLYQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fg7MceDFb3nlPbopQ1JOPUk9B85nNXLyLIbXeKiUt7g=;
 b=KKMbv9cL4ocuqxGMSWf5/edZlZakTpCB2o3ztYGHn3TuDO7BKA9WgBl4+Ztb1+pIc61I3zeFbn7Z0oXmIaIv58u86+/DxHKqVh/KaR7qNBCIHiPQABrvhr+2sUu/JG1VCNH8j45JnweKk9KSa3x2kd14Er/O/CeiSxendr9T/5PLR5uuOwS/nb4BB3oo7//k4Xj1ElonK2b1IgUMhIbVA8P0uuOp8C8FtomR+4xAh3HSqVo/9RpUV+OEBfB3Kx0V7wnfdOT+TbhG/NngntxQhr1U1bvMirgiG2Hp76PeVAuMVYl80vC8qEVSKSrxQ8uYI+VtRav64kC03D+9IiyLqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Sat, 2 May
 2026 15:42:37 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 15:42:37 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 03 May 2026 00:42:34 +0900
Message-Id: <DI8B0IOXNP2L.1NFX4OTABNHA0@nvidia.com>
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
Subject: Re: [PATCH v12 12/22] gpu: nova-core: mm: Add page table entry
 operation traits
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-13-joelagnelf@nvidia.com>
In-Reply-To: <20260425211454.174696-13-joelagnelf@nvidia.com>
X-ClientProxiedBy: TYCP286CA0001.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: eac5d934-a48a-4dfe-09e4-08dea8616fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: e3uhKSel3Oa0rj/kKta+E2XCm5JytKdU/sx+SJwjfLdnZyyRc9SLigIdjjAPEDWUf5a2NnOOasYLb81ciqn/bsrMWBkIploxUfdUetfaprmhM72MJSX7c9iOfrlgt5oiW7G/ayexfRvEho5aVeUg/YvD9DWbuXZi68sccH/g3fpp5G13AdOTBMESSf5ezg4bc5CtGHJqlHkba4PvJDkt19SK/mnhKuHH1zAkVOiDf73RvHftndRlT/JObF6yR9iy40aI8Xp6Nv3RjjjDoQ0MTrLihhsrQXOm7EYyf1xD3Brb8ry2lnM6PhzrVjiIM5/llCKTKTiNEk+F0rHsW1l1gFQ9huOKLtDdLXj3RuXn+ACn5wu/7CA4yySPW2Oo78Xnk3MbGJFcJfFV0TUyldme63KGCs5tC5wIpG/UqwJNi8NaP/bdRvZ9tzmz9yi+CIZQaGs+b1ZQD3fCz8HmiRj9FY3zK0g7Dlt2o4Z27eMg+NrrS3r/vDehjpbGnxzY+P5ST0KX1grhT1hXt/Tk/Bpvos5jidRn131i6GIbctfvITgNWwGE8l44dODbE9OlRYMuvsRTH5l/DZhRulrsV5SE7QygiKUAAR6amwsGce5SLsWxIHf2o8DbkQ3sbn8CshSD4HS+T2Bl/FhH8l4Vth76E1+iaQKMce1trSgpWozZMWjMhsXPzN11J5VdfYBKiaMT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejdMTjRRcXlYeTRsYjltcndKY1A0Mkx0V1g3Z3A4bTg2T0JiaEFYOVcxU3RW?=
 =?utf-8?B?eEtOelFmZ2R6UktnN21rUVJvVklmeCtPa3BWWXpVOG5hTnlBTWU4MG8zWGVR?=
 =?utf-8?B?djNGSGJvSEJMd3FGZm9KNkNXZXRGSVFkdFBVcGg1MTlndHlFSXFDdkJLdzh5?=
 =?utf-8?B?TXlXSDZDbXU0WjlPZlluNGJyL1FMaGtycm9Nc09ONDRxZStkalNySEI1dnN2?=
 =?utf-8?B?S1Nla0RCbkJ4T2hENHpqVG44ZkVWcTY3WWNzVHl5NzZnTlpoTW5ENVhjTE9n?=
 =?utf-8?B?Q1Y2K2dLYWZIT3ZrYTZIc1JoMng0RHgzR3dDUkdVOTBOVUw2S25KRDJSbUNX?=
 =?utf-8?B?bU1tS0NZcERYcmdqQ1E3cUNlQlFBSjBDVEJITFBpUWdnQk1WckF3ZWpVL3Qw?=
 =?utf-8?B?Y1hNVGRNNXV3TDA4MDUyWTdlamhwdS9hUXpUZVMvajVyaVpUVGxNVDlyOWRj?=
 =?utf-8?B?dmpKc2g0U3Irc1dnZmkweXYrYjVydS9EOWZ2VkkwSEc5cGdJTEdyVGVnK3Ux?=
 =?utf-8?B?T2wzcnphQ1VZM0FUNWxXelBWUkJQYWFUN2p2V0R3TFVSR011TnVyZFNyRzJt?=
 =?utf-8?B?bEEzYWxIOXBTSmh1d0FwQ05ibVhXK09YV3FVQlBqZ2FwM3NsaDJRZFdoZWpL?=
 =?utf-8?B?T0l3S3VXZ0tTZzFEaTQzdzBjUEgxNUU4TGZ0bGV5eWZRVlV3ZVNEbW40VHpj?=
 =?utf-8?B?eTZIMnc4Mnp2eU54TllJUlpEV1VvVkJBVDNyWHkvSEJlL2k0QXVrMHdEZ1ox?=
 =?utf-8?B?NHFRTzI1dFJjZjZQZU9jR01HZG1KWGk2TlM3cllJdmNzWWRWTG9MSWZvbkFs?=
 =?utf-8?B?czd5MlgzSzVCVkxZbCtwdi9YdnI1b2crUmtPWXVtZS8vSkgrbXZHZ3FHZ3Jo?=
 =?utf-8?B?T2ZwUFg4eGQzK1QwSitCRU5BQXQySkNta3FBdzBrWldhamQ0YXVPZmtDSG5a?=
 =?utf-8?B?SjJmYWJCeGhTcC9qZ1NTeDBpV214QVdSZFpNME5zcmJUVGpWN1NNUlI5VHBQ?=
 =?utf-8?B?b1hxWjJkQTN6OGpybW1HT2tidGkyY014b2xubnpIV21mb0ZCNGpWWHhUTmF0?=
 =?utf-8?B?Y01kelk5eWdUeW5XUjBkNWpQY20wemRPTTlQTXowanFUZHRYZ2U5RWFOSGYy?=
 =?utf-8?B?bEYzeVU4QnFTMU9FbkFVTk9UdnhXa3pYNEVhWlhkSUtWN1RHaVB2NVFaNFZl?=
 =?utf-8?B?enpZZXpPb0RmZHZiUUpzdkZobHB3Z09uQ1U5a2NhSGkvT3pPMzJNdVpqRTVB?=
 =?utf-8?B?cXdJUEFJWG0yeUMvNWhpVFhwUDNWZUtUZ2VNN29xTDVXbEJSNmxxSG55S3Nk?=
 =?utf-8?B?dGM3ZWFRdjRxRHZjQjVKNEYyaDVDRThsSVY4aDlVZFlNNGNSNGgyYnFXZXU2?=
 =?utf-8?B?MnNKOVlMTjdxYW5YMXYxbmtZS3BGOVV3MURuVlNxME5YdXlqS25yaXBpaUJT?=
 =?utf-8?B?ZUhEODYwZzR1UCt0cWE3RitaQUVSMGZ3dDFmeUgxY0xxYXVVeVFPeXRVZXVP?=
 =?utf-8?B?N3VYanE2ZzJrdDJ0QXdCWnd0QzlVTU02M3QyL3BaNnRWblZzMEU4UndQU1o4?=
 =?utf-8?B?MWs5VmlxcGF3K2FiL09FM3NHU0hXdjNaQmxBRFArT2RRVTEvUFdXbzF6SWJK?=
 =?utf-8?B?a3RReFBxdm5RajB0VGlsZkN1Y0E5c3M0b1RwZy9kQkoxWVltb2I0Ky9Qak85?=
 =?utf-8?B?cEZTZnRLOENjZ2o4TWNucGdaNUo5R1B3ODlOTzFrREIxb2NLYXo3c1ZmSGNj?=
 =?utf-8?B?dG5COHBYd3NsUG5QNXA4UFdRT1c2MXp3QXMwN0I3eTkzRDFvTERoZGxndVhn?=
 =?utf-8?B?TW41SG5aNCtBMGRUUGRTRjN6aUtwOGlHd2dMUkFaNGpIamZ4TVJXZjY1d0pu?=
 =?utf-8?B?NUNCbVZ4NXhFMnBCbVJFdS9KcVdVZU5xbkdDeUJYQ25PQ3F0TUlacURVUElV?=
 =?utf-8?B?T0EzNHBPWG96WEg5Y2dsOFhkdWNoR2lDdWVBTTEzWC9pTUFhM3Q3STdCb1g1?=
 =?utf-8?B?clRjcEVtZnB6dkxJL2FpaGlJaG90bTA3R2xjcFBUeVlwYjNSRmxuakJsNEsw?=
 =?utf-8?B?VEtJeEI1Yys2Ny9wNHdsSEJwUm9DNGVDaFdQRG4yTDkzcHgvSjErM0R1UGp4?=
 =?utf-8?B?T3E3cmxPb2tKdFFmUVpBWDk5R0RLZkxidlRHejJhNURyblZTdStkamUzeDMv?=
 =?utf-8?B?cXRUMW9iV3h3ZjM4ZFlHbm1BYnVwdHo4dE81eDlrUWJ5WkxHQkpYVXdxSkQ1?=
 =?utf-8?B?RWFsTVFmSFJEdElNbnFXQTI0QVFHM1RCamQrOFRoMGJVWGRZa09pd0orUkIx?=
 =?utf-8?B?Qm5sakxrQXBSWmtlc043WGt6c05JSWlrNVp1K1JOMFhwaDdMVmw5YTQ0Z1Ir?=
 =?utf-8?Q?P6RMaXl+oFUzqnvmEAd3jHEo6bovx9TBrbtbqtJlRcv2+?=
X-MS-Exchange-AntiSpam-MessageData-1: 9eMgzUUEJ1P5TQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac5d934-a48a-4dfe-09e4-08dea8616fe3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 15:42:37.7175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7BxcJMPRbWhRyvHj78L24DfhviYgCppoyTmxVdf7Tk8sEoXu06eQjSTKJkkZ3/b6939t/dDiA8/PmGCcyWsp9Q==
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
> Introduce trait-based abstractions for GPU page table entries: PteOps,
> PdeOps, and DualPdeOps, along with the MmuConfig trait that ties them
> together with version-specific constants.
>
> Refactor the ver2 and ver3 page-table modules to implement these traits
> and expose the shared entry/PDE/PTE operations uniformly.

Please, no. We don't introduce code that gets refactored the very next
commit. This patch supersedes 270 lines of diff that reviewers will have
processed for nothing.

Please reorder things so they land, as much as possible, in their final
form. In this case this probably means defining the trait *before* the V2
and V3 page table definitions, so they can implement it from the get-go.
