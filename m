Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21F8606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 02:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=p0tz7N7h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 352D710E08C;
	Fri, 30 Oct 2026 02:43:31 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011066.outbound.protection.outlook.com [52.101.62.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5701C10E08C
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 02:43:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5t6+Q2iFWFT/bjJ9vh0jSQhdcCwXFdNYRhlvz5wqDkUgT30dvI4JHJg/zYTKgvTf3qQHBWXPAPsCWNOZavi5MnmBBTdhhkbMO5lbXo1OsyRQrfE9tLSItzf1pTaUpuZ9EY/ZrTSXHT3od0ykAAO9q7/L2V4GpnridMV28ajsNReY2xKTM5gI7r6TGUoemne9b2nnoBuhBhLd4xP7U22dQknxgQLQrqktpxWPkE+HiJujdymnepKKBk8WzxR9AEEmNMljDXjTLwaVmmqPTz0biezEO5U2JwdmfonBqBx28b8RopAuBDV/qfPr/xkrXgSxITxs5TaTOHtkDV3V1WLQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgcidXzasZXGmyCOcxrxXktzlpWjfMP81OF7oFSKqho=;
 b=Pxt0WmLSy4Kj56AQe5X8w7mBp1sYjHAidhyCKKYCjcOAmoFQixcWNKOLt/I5OVI/YPBbtW80mKn0o+XVPWny220WbPquU4zr+pOeGIswyOFqfe5v+u8haRFSkFIpXLWKWc5p2RxnToG6xJbPBUwhjDlqig02kmtpOxFHLUZ/JjjaQf6izqSEUSkPYO1qwBsvfCa1Kg4JOqDaMri5Lqtp3GgD0V9ewaTkqkG+rZ/nwo9+qfDGEm9PSKvVMwQNoTWfwSUYPeKgQQ8SmM1Wu+KdJ1PDlj7Uyp0RiXlMmDZxeCeI0yfHDINz5Vsy5If8/uewhMlRHgzWzX1fsKATwNyKrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgcidXzasZXGmyCOcxrxXktzlpWjfMP81OF7oFSKqho=;
 b=p0tz7N7hNa3M1cI2nj3EOHiBjTHNnYCq4U++E4vKsbkxN+phh4CMcjPgoGFB2Ht+zrKin5PeH+NNsl28uQ/rXUdmtxNNMtmFpIwRjBk+BMYvOpxuypeyb5iKelQLU2HsNgqhyfXCZVWjb76LNuxb/stX5HFoUf2qctFKh7VTWOm866WMLiV5g7E3tfkWHCPDHpB002ATx24aIeK0n/VkdXLc9ZpNjVn6aV/3uct8QpnVcLEDgnvEzIeEScuBpoo/20ZVf8JDPZRHNqhN8geD40M1at3QC7VgzlXuw5KANDxMBl79G8gF3WptbHbnwl/m/IbjyqJKxZZv3n62dkeT7A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.20; Fri, 30 Oct
 2026 02:42:58 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 02:42:56 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Oct 2026 11:42:54 +0900
Message-Id: <DMHTS639LVGB.376844ZI0GD05@nvidia.com>
Subject: Re: [PATCH v6 00/15] gpu: nova-core: gsp: prepare the command queue
 for r000 dual-message types
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>
References: <20261027-cmdq-rpc-v6-0-bed9669724ba@nvidia.com>
In-Reply-To: <20261027-cmdq-rpc-v6-0-bed9669724ba@nvidia.com>
X-ClientProxiedBy: TYCP286CA0314.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::18) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 4db13631-8513-46b7-6ee5-08df362f8101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|10070799003|376014|1800799024|366016|23010399003|261026121527099003|261022105027099003|56012099006|11063799006|261021121427099003|261022075727099003|18002099003|22082099003|10067099003|261026140227099003|3023799007|261028144727099003;
X-Microsoft-Antispam-Message-Info: beiuLRSsOHQtiLmYSM8XJ1cknB8BKxEpgjdLf3hSd0r1/Wdbhk0EysWPvIovbUFPAt51nYmCrdo10zoKVbELlTNtQH2NSYOJlo4XUWRKDX+O2Pa7YJlXo2A1Fl2BXXln+bFel0t4dbro14qGcKiJFc3FCYDVnWtNs1DdQoBTT6vZK9KItKMCqDQRy2LD9J6j3QWPO6LCLVDI0qdQAjg7/hv/+iHWT0u1nTCnBSzLnz1TZo+CGFkNEFBM+Jhl0lkPOXuKrqUolm2g+VV5eTgFuxgRQ3dFqh4EcSKj9mkPFtDroHdmnE13FdEnujHJq1FmjwDOJY/jIfG9463ateWa5DlEe1Vgt6yjkbSszP1ZwdZSuI3LdTvjXAVZ55GDbAuTwdFi2r/g5nCtvR6AqG04AOp17tLnXEFTONXjNGcIYSWLxsJYj8w60VYlgo0zdz+XZsbzU8RCbktvbQhGaLjAKXz6yza8aTJKbo5ffd3w7TRwosu/s20QBYC4wBP37F0gTMlN1q1FCNEeJLCOQZvIsHYL649z1JiOU3oejho0je9SPwxi8eZiTe/s8Dj1h3ni4nOcg7klT9WcCCfB1+kM7MqAUK3/DIPP8ekrfVCee5VRwBOVWcaWwuEcl1pykl0mHw9wwIVWLlzli9GtVUOI2EZgvrR7x1sSW5vvGmZi2Ok=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(10070799003)(376014)(1800799024)(366016)(23010399003)(261026121527099003)(261022105027099003)(56012099006)(11063799006)(261021121427099003)(261022075727099003)(18002099003)(22082099003)(10067099003)(261026140227099003)(3023799007)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rnd5WFR5QUdUZktPbzRPeEtOY2RqRG9ySzcwVlpQR0VYSEtPMThjcVZHSmNN?=
 =?utf-8?B?WWJCcjI3aUJkbDN0WE5iTElqY3pKSXErUnBzS1RyK3JJcTdwRGJYODVzc3Qy?=
 =?utf-8?B?cHVJNHJROHVaNFhwL3hoeDVySk9TWnY1RmhEL1phTW9lMnp0NWZWb2RCWXRv?=
 =?utf-8?B?SXR5YlcrMUo5ZnNoTXM1bjJZN01IdllIYkxMVWVBbm5Ud3FJK0Z1U1Ztd3ZC?=
 =?utf-8?B?N2xxVTRxR1Y3MGlrTm0vSGRDT3F5SFRhWEd2UnNSejkvZ3RaOGNYOHc5YUQ4?=
 =?utf-8?B?dXRkRldvejNPQlQ0TzhIa0wvNTA1TXFUNjhXMFFJbStNdUt0S2c2eC9iQnNX?=
 =?utf-8?B?TW00QVZkSWVBV3dRQ3NBVmxacitJUXlwZFlrMDRYMEV4dmpvdGxoaDFIUVcv?=
 =?utf-8?B?OTh1S1Fwa3diV3pRZkVRN09KZ0JlT0VNSENqVnRNMUpxTWJpeEY4MUhxaGxD?=
 =?utf-8?B?Um5URnR3SlhWVDdVR3FNMkZ0WjZNYWpRL3VjWlBVelFPTnE1dWhYc3VPWGRC?=
 =?utf-8?B?Skt0aFlGVWozZm5UYjZMWU02RSswOFRjY1FRN1BoM0JEMktCSFE0QTY5dVdJ?=
 =?utf-8?B?SE0xc1RlbjBkejNvT0tlMVg1WWdOanFYK2czbFVnUkVSQWliemJTY1pIVkND?=
 =?utf-8?B?VSszUkt2enRGblN3dmJ1TlNRMk9BYWRtSnRaYjZ1V0VYNHFjZGFHMmdzZ0xj?=
 =?utf-8?B?KzEyR2NoT0gyT2RWa1k5dHVEWjdYaDVLblIyWitzblE1WFVOSm5mMUt1OXBS?=
 =?utf-8?B?S2ZBNHpaT3Y0ZVlFRHNVNE9UUnA3ZzRNdnJiQ3JkOTJ0UGFYcWtlWElLTElW?=
 =?utf-8?B?ZjdISlJUU2ZiSWpWWCt6bHBTNnVwL09xZElQSEhmQ0pJUEdkbmUrRWJQaXVV?=
 =?utf-8?B?VG5lL0YxcE9aTDJCc3MyNHpWSHZTNmY2dEpBbnZ1dDZubVJwL21IQXBySTJm?=
 =?utf-8?B?VUVhTXhydkpiZnI3T0I4clkvZ3F1VnJDQ1VsdklDOEFBR09SVHJGL1MvVkFF?=
 =?utf-8?B?UHM0c1dRRDNpNVhMa1pwd0tOT0NtU0tZeGlsRjVMeGZlQzdiMHU1dDlHeHdP?=
 =?utf-8?B?OGlkZUlPSnhVR3djQWVOdnE2Ym5rU1JYTlhBbVBIZEJXYldZY3Z4UHpoMGp3?=
 =?utf-8?B?bVg4SXdrTStpLzBDZS9KL3ppQklQODBxQW0vR1FlYndTY1grWithSzZJYlFM?=
 =?utf-8?B?TGxxTzRqTlh1ajMxR2JaZUlVdEZld0NZbEpnSUgyWEsxNGdhOG9CTS9EbUh1?=
 =?utf-8?B?TGpXdHZRQXhQUHZudnJ5NnBJYThVMUVIbm8rRDFWcW1KZytuU2MyQ0xwSDJJ?=
 =?utf-8?B?ZnVydXlBTnhUZzJ4S0l0VmNRTGpoYmdVbXVxY3VmMGpuV3hQcyttK3RYaDhX?=
 =?utf-8?B?L3pLUUEzWmZNT29jQUl6ekZPZDU1VHRLbUwyK3VTZERtN1p4UFlKRFZaampK?=
 =?utf-8?B?L3JETEJxeElWWHpMWUwvSzB4NWh0NmlZTy8zQUFvMGpUTlNGTXdLWnhnSmVj?=
 =?utf-8?B?ckJvMEs4QjZjSk82ZDB4d2dESGVEdm41bVpQN2g2NWlsUEFjdTFULzJ4ZGlk?=
 =?utf-8?B?Yk95L1RnU3I1V0J3ek5ZUFREampra0V3N3N1MjBJa2EwNVU1T2ZjVlp0QUEr?=
 =?utf-8?B?NXFjbGlQdk1CYWxENE5QSUdHRTAyWFlLYnA4MU9lODArZHdEN1Jsdzhud3By?=
 =?utf-8?B?Tnd6bVphTkRUamZrcXZMdjlxVkdPZ0NyU1NDNEg5TTZaZXdXVS8yKzFONzVs?=
 =?utf-8?B?azI0Ukl6R292cFdQY2RaNDZobldhMTJlNTV5dVkwbCtDYWtPRFJzY1RRZDBz?=
 =?utf-8?B?ODg5VWVpem85YW8rRCsySUx3UWIxZ2pyNW9CTk42NUZremFVcHlvaG16OG1Y?=
 =?utf-8?B?Q0hkWDU4Q2FaZnRyYXNERis1SHMrQXFDbUNYYm4wWVJOS1BpOXNHdUN1QzRs?=
 =?utf-8?B?ajhxV3dNUWErWmFOQ3k4eTBvNXdOQS9uN3F4SDJ5Q3BUT09tQ0pBbEJPSkJk?=
 =?utf-8?B?T25RbG9paFJpcTI1SXg4Zk0ralZlNEVwUm1PaHd0dXpleXpXUHR5cUt5Zyt5?=
 =?utf-8?B?cGNNNmVQR2NFRlU0dFRsd3VjOVZIMGZWVlowYUNpamNWL0M2eHJacTlxblh1?=
 =?utf-8?B?MWIyUGgwbHhnbGZsMGlzNFJTMjZscGFwUXJpUVZ6WE1ERzBCc1YzRUVmUThI?=
 =?utf-8?B?LzVXNnQrM3EyaVkzaCtacENJREp6bU1OWTJqeFVEZkxBVEZGWXNSUk85M1VF?=
 =?utf-8?B?S0J5L3ZQU1dQUEl2dmUyY0lIdzI1Vyt3Uy9ablpmTXVYdDJJbmNoK0FWOXN4?=
 =?utf-8?B?TDhUMi9mZEo5cHVlYVdoN1p3SWxlODRCYjVUWVR1cDA4TUl5eUJ0c1plYTJN?=
 =?utf-8?Q?hhDW9unBmOK2e5b40IeX8ew2VnFkNdoY0RabvVfY0uzCa?=
X-MS-Exchange-AntiSpam-MessageData-1: vlmHpOn7lgXKVA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db13631-8513-46b7-6ee5-08df362f8101
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 02:42:56.7526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPRAbzPVwYgheAUD0ugjpf6KTE1PU0ahBh/MCB1NZfrMDD5cGqt0j6AqkFsQfquRyZD/vJE0RKH0Fzk5VdI8Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Oct 27, 2026 at 4:35 PM JST, Alexandre Courbot wrote:
> Alexandre Courbot (15):
>       gpu: nova-core: gsp: cmdq: remove stale comment
>       gpu: nova-core: gsp: cmdq: simplify framing error description
>       gpu: nova-core: gsp: cmdq: validate checksum earlier on receive
>       gpu: nova-core: gsp: introduce and use proper RpcMessageHeader type
>       gpu: nova-core: gsp: cmdq: group the RPC-specific part of send_sing=
le_command
>       gpu: nova-core: gsp: cmdq: split the transport part of the send pat=
h
>       gpu: nova-core: gsp: cmdq: split RPC parsing part of the receive pa=
th
>       gpu: nova-core: gsp: cmdq: move RPC message logging to RpcMessage
>       gpu: nova-core: gsp: cmdq: split the transport part of the receive =
path
>       gpu: nova-core: gsp: cmdq: extract await_msg_with from await_msg
>       gpu: nova-core: gsp: cmdq: do not sleep when waiting for a message =
with timeout 0
>       gpu: nova-core: gsp: cmdq: use consume_element to implement drain
>       gpu: nova-core: gsp: cmdq: move the RPC code into a sub-module
>       gpu: nova-core: gsp: move the RPC commands into a sub-module
>       gpu: nova-core: gsp: add `rpc` to RPC message send/receive methods

Merged into drm-rust-next, thanks!
