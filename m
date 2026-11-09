Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A7C606A330
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=dQkPhOjX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AB0110F251;
	Mon,  9 Nov 2026 12:38:14 +0000 (UTC)
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022115.outbound.protection.outlook.com [52.101.101.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A48E110F251
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:38:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MApvc4qt8F7pneIYVTjgKBbNHRYDXDwmuYnZJeqAJvK0jTuhxORvkNl6ox1HSCWJaHb0HWGFW6BAY77/oqI7v/oD9SrFx9kf8QeIyaOiaTecmOSzsQbbC0o/HXAcgctf/CMEWSYtc9BtsFgdbTTvxMB0Oh8dr1edsmxK8y4pXas9Ws6jJgg6TcPze5IdjA5ItMwKtPfOtUkbBamq0wT22XTyOEP4azx4v896/VLB47UBZPAFCJ/k6bjbKvn5WpKBPIyKh1Ii54VPK7NpSbkBmJfkovMSpT595EOKTxLcHb+hf/83x7i4Ytf1p8x0B8wCWgxFMeLq4pVIkw9PXc3mAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXoyfZ9I3VHCEIeyWJEqK0RML32BA/wqJYjnNmzLriI=;
 b=oTQSd70RgHETR45z8GYefQmPeRUbaeZLVUHvIgCF8bGA6z9VAjBTSidftaZ2tUReWaBV3pg9xP2UBNDXqjaYIv5Qro0ijEyZrR46GILGNT7RQqotaAKtG4ZAKgM/canBg4cXIR2rXAW34Wx+aG43QVl2FpiIy+Jgizl/YU+hCxWNDoeqBQlTOpe+3C0Rd5qF8mMo4H/MTcQ5MonVIh4BXqjx5UBxj4/0yO9irUn0XQM7OPYHoxGfNA81AsgddS49YE1vd3hMHw52T5hDqHv5YbuU6JIUPrkK+RsX87lgc910OUGMRaMT1apzLw9w6fQGjmm3JuWzwRJipWX6mCB89w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXoyfZ9I3VHCEIeyWJEqK0RML32BA/wqJYjnNmzLriI=;
 b=dQkPhOjXMJLNEHWPh28JpMZ0yMarw2kowpy4R2VWRPqrE7FBskEr7/orKq3Ce1GCD8pUuccM3ZAVDzctg2VwOzx5iu0uMkf7ZLtLZTOtoVKPUigKSAr8KN78C3dpYE/79qhqAydb8KvOS0UvPuf10Qisz2HokGDaS+3WfyoPNzU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by CWLP265MB2084.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:61::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 12:37:19 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 12:37:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 12:37:16 +0000
Message-Id: <DMQOOP9SB7JB.2YUOQZFYKSZ9W@garyguo.net>
Subject: Re: [PATCH v11 3/5] gpu: nova-core: use Alignment size constants
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Burak Emir" <burak.emir@gmail.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.22.0
References: <20261109-chid-v11-0-082aa9bf5a91@nvidia.com>
 <20261109-chid-v11-3-082aa9bf5a91@nvidia.com>
In-Reply-To: <20261109-chid-v11-3-082aa9bf5a91@nvidia.com>
X-ClientProxiedBy: LO4P123CA0033.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::20) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|CWLP265MB2084:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a77de3c-1645-4f60-fc9d-08df3e5e30c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|366016|376014|1800799024|7416014|22082099003|18002099003|10067099003|921020|4143699003|56012099006|261102123227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: RRtu5XnEhFP1S9pXjJ+PDHXZDLj0WicaCq4pJbUPfwB2nkWbJCYrLbueXXVh/YN4c5qA3wqG2iIDK/5M/u5/1DHTjxCU0HL1e9Q+lEByXaLFkH8TYz4PGULTFad7hCL5eAPk2by8l7KXZARNB0UmEVpp/aSF4zMFjIC8xgosJxKBSS3MUMg7BGuwtPl/ykBi+BDxPJiRktsC8E5n+ceJJmRYx9eu/kdtnE28/oJaOouYmWFeoMOwpo7IERWeQALwhmTI+APYhY+0t9D5LpCtGWox8MjvPcOYwCp6fUFcPvPbKy7SeLY0L+eEBV/QtG2g+QjUfg+z4YcIuOtYgFGwtU2Aucvxx+B++z5cv6YNPwkonP829418uplob55YCbD+FoIohloGsxGn64SBtGbf6W1qid30rBKoAyFFLfEPpJJdwXCoZYtGa4Dj2dFcK6ndvAWun5ejRiArHs96+KITrLZ9tbLEyt88MroXNfVPUtFbmFL0TgouBJHNhSoJPMC30WlDVC49aI9x0UQX0mpQ6e74iyAik96DUSoHgWyHpftsH//pSNSymrUltuPQ07FmXk5ktGIlo2YduIjV9OVLJWQPgRjGDhaLDQZUF7ZlG8I/0gX8m2h1+31sC8xxSCEWdNyG5j5eqZdmZEQFzB3jPWrOGmQ1Zk1tAVl5Lx3kmGgkKvoQ2eiEz/IwpBNl8Z3Yy5DPvvyHYDwXC0mjEGUlIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(366016)(376014)(1800799024)(7416014)(22082099003)(18002099003)(10067099003)(921020)(4143699003)(56012099006)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUxLc2w4UmZTRUxhYngrQ1BLM2xZR2VvNjM3OG1jL283MERkWTA4WmNSQ2tn?=
 =?utf-8?B?V3ZlblVORVg4K0hCSDZ6SVprZGFFZERWMmtSQzRCdDBpNkprZjdXVzNTWkQ3?=
 =?utf-8?B?WkhIT1o1TVNhcFB3VGkxcEtwQnRBeU5MMyttandrOG5iZzVJYXdhbW9XNmI3?=
 =?utf-8?B?cU1lWDFVN2VGVXdxZkR3SnFrZkFKV1BGSFA0OUNvelFXOVdGVjQ1WVk2UDZl?=
 =?utf-8?B?Qi9GSzRiK1NYOHBGeGNab25zK2crNUgxck55Z2l1RmtDa2VlKzJMR1lKczhS?=
 =?utf-8?B?N3drVG1Yald6UHd0STZZK1FxR2RLcmNqdjdrQURyWDBaYm9TT25rYzhjS25u?=
 =?utf-8?B?ajNkWktIZC9jbG9KY2VnSWFtVTNNV0N4MHl4aW0wdktrRG9RQ0ZMV1JyazBS?=
 =?utf-8?B?M3A3ejFKL2dGbU9pQ09XbXJsUWVqcWVSRVhuN1RTVmROQkhnOHVsQTk5UzN2?=
 =?utf-8?B?bVcyV1pLbzFBVUdraVdGSHd2Z0N3V3dnSVFtMVFXYVBCWlNPSEtBMjlpdTZk?=
 =?utf-8?B?SnBjeEpISkhjQjBieW5aaU5STVRmMkoySzhnT0FjdTlqNUhyZWNmVGZDblpM?=
 =?utf-8?B?MG1oelh5YmZmSzRMSzNFREVmMXlHRlZ5cmxZSnh5YmNhd09DdkRLdHQwZFpB?=
 =?utf-8?B?Q0Y3bW1hMXRVYlM1NlhobUZ4dTRZeFBFZGliajZiM3p2NjQ5ZDZDTXZZTnFk?=
 =?utf-8?B?MG9NMmxjaHQvM2d0eXFvOXJxK1NGR2swYkRFQWw1eGVzdUdBMnR5Y01BNlNL?=
 =?utf-8?B?bFEyb2tscjFDRnhrQStCZ2NLSFdOK3F0Nm1SenAxWDAzVDF1d251bkVVMkdn?=
 =?utf-8?B?VG54UzgvQWJDTVYxUUp4eEh0d3BWUTVuTU12NmJ0T1pmSFA2OTBnRGU0MnUy?=
 =?utf-8?B?djQzellKMTM3WXZUZHJFTE5UUTdqTnVLV1hHVDVhSG8xN0VjcThuSWNrZ2Zo?=
 =?utf-8?B?L0Q5YytoWjBBeGM0T3IvT3RLRkhlMERsZzJBOFZ5UFZ6ZUVhSjlwQWdCNlRv?=
 =?utf-8?B?cnFxZXhrNGoyd1ZZYzArczN4MFFQamkvVEhnSzIwb2RTWU1zNTN3ZGpSeENU?=
 =?utf-8?B?OERkaW9jT2gwYTJQb1FmcEV0eXZkeE5jQXVuVzZORWdTbU52UnJZSnhqT0Zs?=
 =?utf-8?B?UU42WUhObXM0Q3h4ZXN0SmVuNlNKQUdpN21sT2t4UDlGSWN5TVY3cWFJcFBZ?=
 =?utf-8?B?aW4wME1rcnJiQWxxS0IxRVZTcU01OWN0S2FiMWtjSWRkMjFIbG1xcFRKKzRY?=
 =?utf-8?B?a09WM2ZOQU5GbG9YQ2c3dlB6eGZwaUNicmo4akpFd3Fpa3VRSnBlcGpBZXVk?=
 =?utf-8?B?TGROeXg2bWZTN3VoNDBNblVjamlYbWNLay9KT2FPRUhqamt6cDhEaDR6b3E2?=
 =?utf-8?B?QkdISUh4ZEV2VytxdThWeFNWVDNoZGUwWmZzMDNwWTIvRHVUYVRMeXdyQVM3?=
 =?utf-8?B?bmo0ZitEUjcxZnBNVXd0bnV4K2p2RVVsZll0TXFhcjVMRWJYMXdQNjB4Nlls?=
 =?utf-8?B?K3pTQ0pmL1hnTGtDN2hXWGJqWWhCRDNrNDc0SHhBdHJkMWlSOWFWMGVTbTRh?=
 =?utf-8?B?V1hWUXZMbTFOUzEvMDBjYmt6QnZ0RDlQbnpGdVRPcHI4MVZRRkJta1Y0ZVVr?=
 =?utf-8?B?eXdKa0VkV3hRandXZnc2MkNkelIyVXc2STV6WDVXeEhIaklvL0QwSVlkS25Z?=
 =?utf-8?B?blVGcUsrbnpQajN6MnQrQ3pjQ3ByeG81M1MyZ3V6dkc5eGJkQ3ZnSytOOVo5?=
 =?utf-8?B?THhzU085d0lzZ2N0STE0UU5aWUpPaTVIWlpUYnBZOUlWbEYydll6U2hJdjNL?=
 =?utf-8?B?LzBIVGJNbkorSEV5eUhIVEZlN0ZTVXVWN3ZuNlY4K0JPU2xJd3REWmoyWUts?=
 =?utf-8?B?VEFRUFZQZkpvUjFpaVFjTHNLd3JGT1pOeFlzb0ZyRE1KaUJHOWV3bkREU0Fl?=
 =?utf-8?B?b25pMkhqempMVUFEaXFIN1hEMmZmck5Ec29hVmE0ZldLZ1ZHaEROTGZVSHd5?=
 =?utf-8?B?LzBRSzMyczB2SnpUUDhkL1o5ODZDaU0yeWJOb3REcjdKaFVUTWJZLzBSL2do?=
 =?utf-8?B?TjBrT0hzL3prQUlwVkdYaUJrZnpaUUR2NHdlZE1nQ2JIS3g1My9ENjRDZTlH?=
 =?utf-8?B?OEhyTzZuM2Y0ZDBhN3kxRkxySGpLM2RiQUtqaFJlVktpT0VVQk9IRkNXeFVE?=
 =?utf-8?B?N2ppS0RzNndienRJUTYvaGFzMmhLT0M3TVdhbXJFQlRaUmsvODdVRld2NDdK?=
 =?utf-8?B?cTFlRm91T0ZzcHBqWERLZE5ZbTNJZFliNk1Rc1ZYcWpORWdwL1BzMFNnOElV?=
 =?utf-8?B?QTYyM1BJalJ5UnF5K1k0eFpTQkVpb05kOXFMT2lqQUtPeUpWQVhldz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a77de3c-1645-4f60-fc9d-08df3e5e30c4
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:37:17.7453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXr1vbltgrpuFAhBS4uqvoZpObB1EDDA2WKd8UhDs+RXryKATO1bpcaI4fIISVHrMbTHJcviWsZeviOV3zKbBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2084
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 9, 2026 at 8:32 AM GMT, Eliot Courtney wrote:
> Use `SizeConstants` for Alignment that are implemented now.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/gpu/nova-core/fb.rs               | 10 +++++-----
>  drivers/gpu/nova-core/fb/hal/gb100.rs     |  2 +-
>  drivers/gpu/nova-core/fsp.rs              |  4 ++--
>  drivers/gpu/nova-core/gpu.rs              |  7 ++-----
>  drivers/gpu/nova-core/gsp/fw.rs           | 12 +++---------
>  drivers/gpu/nova-core/mm.rs               |  2 +-
>  drivers/gpu/nova-core/mm/bar_user.rs      |  7 ++++---
>  drivers/gpu/nova-core/mm/pagetable/map.rs |  7 +++++--
>  drivers/gpu/nova-core/mm/pramin.rs        |  6 +++---
>  drivers/gpu/nova-core/vbios.rs            |  7 +++++--
>  10 files changed, 31 insertions(+), 33 deletions(-)

