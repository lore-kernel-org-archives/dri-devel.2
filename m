Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90D2CA5FFC
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 06:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDF9B10E069;
	Tue,  6 Oct 2026 06:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="N7sObxPV";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013068.outbound.protection.outlook.com
 [40.93.196.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB3FC10E069
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 06:10:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diZ9Kkd/8LxuQ1FH03Lva3+bpA+XOulqD8lqJakQo2i1WGb4cpjw0qY58bYtyPpEUX0OCfYRxLzHL35dEapjZl6SO7srHboJjW+Ds/jzEs5G+SMZonETI/s6u3GBzAtNkOZM1k/hK60pTBcJD/b9wkptLwTqdGCb75xpGKP4+PczCWr3GJs0QFqMNBsUA8COxs35gDLRMcSEDcPN6aM4Y4HnTUJIuEcj17VVfI0k+UDq0IvGbdF5w74yerecJ0xWvF5SX4IHYP/2hBrH2DIWt4DOiB4XN0gTMGbkotobVEyMJFTJ2B+SNylVVYjc/DLuiEEVcIk8PaYzO2Ive8aRhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oj++YW5ntYZ7SOzeeINeIDSxf/8cbhA4KdkSINDFhdk=;
 b=AMn/MMHdvPGZzmLjbXHHmqmvd0rkAiIF5/46OQhfisrn6wsPYGZhlwPSjFws2jU5ZkRtyU6ZzbEexhxgoihl6Ee38HII6H/tJgs4MHj+szWb8Wyz/rxW2WWgXW7KAxq1164t8yRLV3yuVsxEQsmUtjOQGv8kuTN5+tDKdauDVswSQZfhsutdOkcYydBNyp7Z3shKzRJKFUFeigNIIRawYQ1bR8aCUiU4MQN4itrkfZrHWpdIFxgsNCvA8wIbwQtzQsLs2LvtaBjVmY/CQq8YFvKniCNSj1/QMIGDIkF6nA2HO+gn2x+Zy6h4sTirZrFqChqofVJmxFeRIKWIxrZNmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oj++YW5ntYZ7SOzeeINeIDSxf/8cbhA4KdkSINDFhdk=;
 b=N7sObxPVaVvjHDxoaMOotmTWHuVI7LeHNZQQtD3FJLSRKm7SrehxBQBKqIg7FQuYtA0xwwuuiiPZs3Y7yvr2aYgkvmrI7xvk9UtVI0McEWU8aF6vYdcqfgetuNf20RHd8pEnvwPENT2t/gvvzbNy6KaIlAppMspZAWpaw2Bxrx6HRPZANx5VoaC61MuHGiApJPCM+oZHBSVPAOc53fmRI7lR4OodlHoeAZx3OyeMvrK9ekaW/7RmVXY4MdIEByLgqb8OKXaerHofAHRFE40C96aXr/Ynhe3Uk35H09AsmnEF3eAT/DhokYaS9DBNt5ouGDDQjlci5a/8D7IPjj7o4Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by EAYPR12MB999179.namprd12.prod.outlook.com (2603:10b6:303:2bf::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 06:10:40 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 06:10:40 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Oct 2026 15:10:37 +0900
Message-Id: <DLXJ64SVRMFW.NX53HBMT16K@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3 2/8] rust: alloc: add Vec::push_init
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-2-f04504c262c2@nvidia.com>
In-Reply-To: <20260928-b4-nvkv-v3-2-f04504c262c2@nvidia.com>
X-ClientProxiedBy: TYCP286CA0262.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|EAYPR12MB999179:EE_
X-MS-Office365-Filtering-Correlation-Id: 2edcf0ac-4751-4de9-d0dc-08df23708bc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|23010399003|7416014|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8IJMHO1qGXv9yx3Lw42hJmdfcY/cTArNmgrnpEeHtCwYiFJ3Z6DY4InsjJwrlIveYZabXAvB8BXEUlQRa33UyRpWt5p0A5cxmuk61f6kcn4XNBjWpLQfZXETFeT4Rwr0C+UVy/ojlKeuNjern7C+4fNq57yYY5DODQdbU2E+DUfgpHZQtSO4tMmDIBWs7F2CMY9ZItBVnlhUL8H7nuh08aAFFpIsVM5R1wImxUm4E7zsyQgGmUsuzLHWiESiIPknxm/vOGT6/wHR6wp+hPhkADMDpK/p28yZ5aX7VLsnoJ8H5UgM0OvjoteAuXBzIQsZXF2rcV25r2rbS4hD8eP1DDVf05OoWNUigqTtJEURwUYVOfrWHMh8yNQMqDeNwyfPJK5RGjaw9lwYpPQpEcEVWxFuHVvecRIx7fW5i4kixZGZqAtN9toZO4vaa/rmp632zR2XTQSV5er2yB7Xr/s5jh25vuZL9chziY6ud+51Ofd+EqOVcae0X9SEeIVyU7kkU01lJ2jOHuTiruEUrggfhHIAk6QWRCIKepJvRYR+Kx0FjYS96dFNAxYyV1mVfumHBaRjvJ5g1z8+z+PVN80cX8QFmUADTdzti78Dlmme1M45yyGj7AUDyeyYTSlOCQ70QdEfSDiDlC028nPrcZyVtsTXprWikjd5GUVR7Zq980k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(23010399003)(7416014)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWtLaWgwQ2c0bUNhRmUwUUFPMU9iNnhJdXpDKzRXZEdNaTBpTnhPWXh0dUZY?=
 =?utf-8?B?SDIyTFB6dmRJSGl2Y3dkRUtacTRtTlRkY3l5Wmwxak5HUzV1elJRWlcxQ21p?=
 =?utf-8?B?aThCT1lOcG12WFJqZjB5RFJ5UUVNandTcFZnYitzVWpMYnJUVjN4ak4rT3JI?=
 =?utf-8?B?aXZoL3RPYTRVb3pKei82TEdhOThXQkxFek9PZUxTcE9WNlZnRXBZeFVuenBa?=
 =?utf-8?B?UDJjSnNNdldzS2ZianlmeVZGMHJNdndqTDg1Z1lPbEtaSDlWOUlXNzZWNHBF?=
 =?utf-8?B?UFZWRjlYa0tRZVkvbzZjS0JVUEZIQ2xCbGxobTRWWVprMTh1YmhOaFpRRXZs?=
 =?utf-8?B?T1NVUVdJUFFnRGMycVZzRWdCZ2NHWDRCN2s3Rm1jUmZEVlBrcGFJRjRWQStv?=
 =?utf-8?B?Uk5ueGxpZ1YxT0ZFTEJmU0RIZVhwc3VhcEhRQlNiSE9mQ1BWTGpPazBOWUpX?=
 =?utf-8?B?d3c0V1NNMTlERmxPTGNZMlNMYXVsOHJwcndxM01KNXJLWnV2ZjRDQk9hb3Q1?=
 =?utf-8?B?c0Fuem9MMDdsSlhIL3plY0ZtN2xOU05aenhkVXJkYUlJWVplQTNCa2I0UEQ2?=
 =?utf-8?B?Y1hQQk1GRUFCWDU4S3Jua3Jrai9GRnNDTXpnS1RXWDN6LzhqQm9MaDJjaUlz?=
 =?utf-8?B?eTZHZ01jVWRtRVhtaktLTnRTbUhRd1g2aS9XQ0ZwMGNFMXBZeTRkRmIxZVFt?=
 =?utf-8?B?RjROck12aytwY3orbUlOWlVQQmZMRHBzY0tPeittVXZBTmFnSjJqV1lTY1pN?=
 =?utf-8?B?Nkx2bG8rRTg1UjU0UGZ6MytxSHlwZVQ2UWhWNXVYR1EwZWVIZ01nN2tvOWZE?=
 =?utf-8?B?MGxIbGliaDZWSnNqaWcrYk1OZmpOVCtoTVViWjdseUgrZzhjMGNuNkJFcTI2?=
 =?utf-8?B?UytMSzd1cmQwOHR5b1Z5bUZ5bmg0TUhsSEJUckxnd0JFSGZISGErK0FiUVhW?=
 =?utf-8?B?cWpKL0UyVk5uVTRRWkNRWEkwcE81cCtsSElXenFocTFNN3BteHg3eUpQNy9o?=
 =?utf-8?B?czFwSCtkUkRZYkRGMnRIejI4TS9WRHJrcFB2OXQyTXIveXloYWpPamNTUDVB?=
 =?utf-8?B?RGNtdmY1TnZNcjFvWml5NzhyMVZtdGdXZEthRlhQdmF6T2JwQ3JzSG9KZ2Na?=
 =?utf-8?B?Q3lxNWlJbmpOVTNScFV3a2U1RHQ5OTRLMXlzdSsvUDFJY3Y3dGZpQlQvaTM4?=
 =?utf-8?B?S1VEeFhYSmtZUGgrNUhReEF3a1RsSkFmVURtS0Ryb2d1ZXdYbVYyZVZQSGZz?=
 =?utf-8?B?L0YvY2FOZHFZck9hWVdWYVNWVkltejkyVkJGZ256KzNYNDJnSnk2aVdudGZl?=
 =?utf-8?B?ZE9TMkFBTGRuK00xVEI4VTZwa0lMR2ljVHNwYzU2YTRYRUt2OExnRFlIazds?=
 =?utf-8?B?eTNyOWY3NEZGNzR4N2RDU2t1c3lnZWh0WjNPTEEralBVeUZCU1doTXZTc0VM?=
 =?utf-8?B?TVY4TXJIWGNucmdXQXRCYzRrUGZOMFV3Nmtnd2FrTVE3eFRyTnZwMHFyd1hR?=
 =?utf-8?B?V21lazlFVDVoZDQ3aTdJdzFYUGR6YW56N1RxNzZHUHdSZXZCOVQyd3ZxRlFx?=
 =?utf-8?B?VEg5MFJEVXBScE56VXZKaHprcUdvWlRPcHNqbk5mNGpYdTl4b3Nvcm5RWXU3?=
 =?utf-8?B?UTRFWEpSUVk2NXVQYzBtUVN0bHY0ckR1c1BzZXJtUVhqQkhNL2pqSWxFa3BU?=
 =?utf-8?B?R0Fudi9WTEFkbDBJOGJMdzQ0ekFLMTRFL09CdytsSVFqRW1uYzZtVVZ3WXFL?=
 =?utf-8?B?MkJMdUN6Yko0VTZENm42ZEVtcSsxYktyTDIydHZwSGVYTzUzNGkyd3BBWU9F?=
 =?utf-8?B?WEg3L0tlZC9CUVFJK2drN3ZwbTd6bUdnRStYNXQ4S2syV1pZaG9wQ2UvOWho?=
 =?utf-8?B?NmhnYmhWVlZRbElnbTQvRzlRR2YvY05IKzREdkxsQlNFbnpjbW5yQ0F1bGVZ?=
 =?utf-8?B?U2NPOW5sZkFKa243UVlaSzlpM0FmYmF1bVc3Nm55MTdQR1NaM052WHBVaDEv?=
 =?utf-8?B?UDZhZVZvcjVadkNRSmJrd2IrZ3hTZDNXN1g0NHd6QXd4Z3BXSFBYQ1BDUVA4?=
 =?utf-8?B?aXRNVlVGTVo1Q2tnM0g0cmsyNDRVS3hFSXladWdrUmhFNHNMaGFnRXRNTGhY?=
 =?utf-8?B?VnZ0MHhaemlxL2tNNDR0bHNzQ0ViYzhuV1M1amR0bTRYamJGT0NoTDdTTnBo?=
 =?utf-8?B?c1d0NGUzbzFCeDBpZU9qTWtMZVhoR3VHS2lFYVNNVWRlVGFZYml3N0lMd3lC?=
 =?utf-8?B?Z2ZEb21JaWdjam1zYlZJVjFpWVBaejRQdlNqYzZ6QUlZNzhsNmZrSEIvMWRZ?=
 =?utf-8?B?Nkl4UktQT0lUTk5EZjNLYTRhMzNEMkQxWjkvYnBJN3dQYWorRW5Hcm5vK3F4?=
 =?utf-8?Q?s/2qJjEkdfJReD3G2PQmy/3UYQfqhp6L2kLL9FG1U3hGA?=
X-MS-Exchange-AntiSpam-MessageData-1: RiVWC7ehl/LNSA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edcf0ac-4751-4de9-d0dc-08df23708bc9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 06:10:40.0445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJ/F3eJ/3HbenyJTZyAJB3LE/lBO49s7CwcL4dSXpKNNnjGUnYO5oxZ3mO7NAPObThXkEQllToQL60NKTZZM7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999179
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

On Mon Sep 28, 2026 at 5:42 PM JST, Eliot Courtney wrote:
> Add `Vec::push_init` which is the init-infallible version of
> `try_push_init`.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  rust/kernel/alloc/kvec.rs | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

This patch can probably be folded into patch 1 without making things
harder to review.
