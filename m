Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E9ECC6B0F
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:18:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76B4210F505;
	Tue, 13 Oct 2026 07:18:04 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013053.outbound.protection.outlook.com
 [40.93.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1644910F505
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 07:17:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvmHFe0nkOp/9JrMAB6qhbdnBnZLm1yWlQS9taxO4tliUa8kjiJfy7xcj17yVHlUZirUJoCj80Ico3Q/1MlJc3jgWBJ5Z4JLyndASckCmNoZQJiGta1MP8DxHiC4Tce9Z2mqiUYvb053Qd6yV6fAEDnOorpnqOPvElWVOIhrdVnDyCVDpjHeif0XVkkkpJSgNZUipsYL2XZZjBecm1FJjGyzzi3qb64DHB5vuMeBCyEnt8F32XGgvzblpuwPTu9FCledcIIBNFXlD6+2INZ+8frTWBfr/uYGCKUDDCRsKDYknYkjBWAHLY17TZVhk9w5wWgOQMhC7h1KE3xQHt9pdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oB1dx1IeA8gbMLw2wDs5y9oUGlGuuZ2UMSJz/qdxHE0=;
 b=r3W8CHFmpZMqeIwrFJlwDW/C2QLxPcWApui4Xn2+RVpQrmEZnaz5KnMdUwUiJ04qPDmJiZs2TD2Zb3d9weGroRnbIuoyPF0ilhWDY7D5Et++8rRUwNF2UDWIub4OIbVFv00SOlI9JcUpni7JTvQG40O7Hqi66d8j1f74bXXmx9YMKO/Rl0DaEsYlYGQD/scNsBdr9k0f6XHdOJjQkHhNE0Np5wXRghiFrIAcUnkjact+MtXGP+orKfrBnRKEbnim4SI3NzB1u1Ytq0dRVVHDMYu1lrjozFl+kbnK54J9bEyytw4Yk0e0y+wCVO5/72dAcrqZcyiJ1HiNsDKUcRqtAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oB1dx1IeA8gbMLw2wDs5y9oUGlGuuZ2UMSJz/qdxHE0=;
 b=si/ivFtuzxJZmvl/+FYLr9MjkTpYsB+lGQVQd33D52FRGwSccMSWUm5gXLh8Bw/cExfYyYSjXYzbP5Bgz/+8fuuEKBE+vx++V2wkFPGx+NsZp9vruGHuPh/EmJJWdbBVIgnZBLknfFKZkCOXQ6D5x8tnWXsDFUUiohGe4Rv8gLejoDS06BGCdEeAY3dhCeyVfJZBz2Cl4zTxJCu86R8zu0hgjWh207z4E/UDnSAEjqCB5tGv55z4HyfNIu/xJm+Ebf/Mgb/2sOQhvxIinCy15HgT2Xruh1mO418avitJnHiXbK966BUJ7yX3aJVOFy0ecG2oqj90tcquURjuu5885Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS0PR12MB7534.namprd12.prod.outlook.com (2603:10b6:8:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.35; Tue, 13 Oct
 2026 07:17:45 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 07:17:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 16:17:41 +0900
Message-Id: <DM3IZAKDOOCR.2AKZ2VTDXNG0X@nvidia.com>
Cc: "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v5 1/2] rust: num: add cv! macro to create values from
 constant expressions
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20261013-cv-v5-0-113a538dfaef@nvidia.com>
 <20261013-cv-v5-1-113a538dfaef@nvidia.com>
In-Reply-To: <20261013-cv-v5-1-113a538dfaef@nvidia.com>
X-ClientProxiedBy: TY6P301CA0021.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::11) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS0PR12MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: d69f0c86-9516-4892-0922-08df28fa1395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|10070799003|366016|1800799024|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: e5qsz84I4gOD8rTAV3QSeT0+i+4zPrnZvgdHbSpJXqBkmS00Eg8NrQ4t0U44BBGCaiOyT5O8wu/ejt2VZOYRdo42LiICXNpX324K/gK0L4yQqNES5+94n2xED7Jp2ZgxFmgb1CYAaKJqqdLZYduc6yWgcNYTnJuylq93ir1jz5xRCiKEsMD5whqMRWxOjzcIniPodHhniO3UdZbw0TElNm6qNnS6xTH87pkvYszg3aSrm75DsJva34zRCuKGNx4s/i9I2PNn3uXL4gSkwKG7uSQMAjDYgct2C54T2k76XWnvjILIicDXz5DL6YuC5kmYNSElmoGXZLVAlC0iBz9f+1K66AYlLua8vWxuWfrXWNLjkzplx6LP+/XXFvxAiNZ5WgRKbfPPPGIIDCkXya4yWhrNL22OTmVcAsB4GDyiR4XZutKXNsLwY4bCvjGP03DLB8qUrDfWOO+mxb/gMHuYkC8XzLrCxYd4cK/B7KPn2DJOZwr5OsnuqAPjwB0xFImDcYi7AN0mXUqsc/bzK2eBFiTcnfchv4Sv14rm2Wkyhcw8AM0wCB8FaHZgqRuNegEW6hJl7hTqQ5tu+R93QOQ/Jfru8M3Fsa/M7iIrmxg7uiCMyo9WEZXYfdOl121kn3h3vDfl7P1v3vwux1BYQFRD0hpOebwDscl6cSJhKqLvIcM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(10070799003)(366016)(1800799024)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGhkRnNsTVhjWlc1bW10UkZzZE5lMTQwUWM5SktKL1VSZmx5dWw2QlJRdElq?=
 =?utf-8?B?Vko0ajhpT29peDJSQ1FBR1grYlYwekFnZUlhWXk2RHNpSnI4UFBuRElJOHdU?=
 =?utf-8?B?VU5OUDhGZE1rUm5kbkdEUzF5RGdZL2NKWHBDU3piUy9qZUZHMHRlWU5PeHlE?=
 =?utf-8?B?WVlrbVRGeWQ1NkpSelhzNmFnZGpUTWtiTlZBd1JrUC8wTzBTYVgyZ3NPUzIv?=
 =?utf-8?B?N1p4blB5ejZ4anFMTlU2aEdGUXBTTmo1RWNBTVBCSllqOUVuTU1mbndLVUtL?=
 =?utf-8?B?azVhem9VcFFYbzNUWkFJYWY4YW1KN1RTWDlSUmZkUVYzVWNnV2ZUNzk0NXFZ?=
 =?utf-8?B?RnlBWVlWc0h5WjV6c0FQMktGcHhZaHhGblAvTXFXWnpwQXkweVBVSGIzNS9l?=
 =?utf-8?B?VzRpazU0Z1RXTWFRWTRVbVdFb29yYXQ1ZVJhSlNRR3NCaWdCVW5LNWFnS2VR?=
 =?utf-8?B?QWF2Ny9nWUNuL1IxblVJdWNhNExEbTQwdEdCdjJpbHU2Q3Vsa2E0N0RwV3Rn?=
 =?utf-8?B?SnpQZEJkUS95MHRKVjhuRW5vWDFwNmdzcUErL0V6MTlPY2I1VnZ2YTQzNE0r?=
 =?utf-8?B?VHVZSlRrM0xWa0VSMko3U21DbzZLNDlnd0s5NjZwd29jV05jL0tFdHpNbThD?=
 =?utf-8?B?S2VERjdhVTY4dm9QT1A5SDJoK3h6RzErRE1DQTYreUNOWWZPSlNUaVNRTllX?=
 =?utf-8?B?Zm1YVzduR0lZT0NWTWJkZ1RZMG90T0tyNXJtWFdpd2tFdkZGVkh6eS85SE5r?=
 =?utf-8?B?bjZRM2MxRlNoZGNCZWs1UnFCbG8wSFRQSlgzSFpWdHFhU01kYWNsVWZTckc3?=
 =?utf-8?B?a0N5SmU3YUdpSGFwZGd6QWY4RjgrT1U5amQrdGhiajRNdGY2YmJuUTVySE5a?=
 =?utf-8?B?SjNCenowMmVtN2VHTUVLemlsOS95dGMrOXlFcEphbitjZXVLY1BmenIxazBX?=
 =?utf-8?B?NlNiaGh4U3psVkticXh4anlreTFRZGxZcnVHQkQ5cENRUEgvbytVUmErYWpM?=
 =?utf-8?B?OFF6L0hpUW5mNG00ZW1YY2pXc1h0ZElaZTNFenc5cXZhNHNuN3hHNnhsNGRJ?=
 =?utf-8?B?MlprejNiNnkrZldNMElNc09nTlBkU0xCL0pQTmtTUVJVNGRCOVlFNGxrTXpF?=
 =?utf-8?B?cFRkdVc3VFk2ZUxtMlJHNTE4M2FWTUxHaHJXM2tmOGlSdXJJTm9Sa2JUcWta?=
 =?utf-8?B?NUl3bGNJTDExVm5XanhBM3cybVVKMU9XaEFYdnFpU0ZLRE5vYlZMOXZXam94?=
 =?utf-8?B?dVZFZGdqbWFwdk9aK1FiQWo3SHZWK3MwQkxrNFFoUWdXSFdEK0E5Tkdsa0g3?=
 =?utf-8?B?MktybXVLTWtqRzhJUW51ZVB3MjJEUnpDVkl5RG1uTjliOTVJaHk1UnNwNSth?=
 =?utf-8?B?dWdFSnliY2FRSFQ1NTk4dzhpVk5xdjhaNjFCR2VHWDVQOHN2djVoUXdmczJB?=
 =?utf-8?B?dnRTajdqTGRvNDcwYjJpbloxUGhwbkozTWMwS1FxUkJVWGRiR1BRWFR2VndM?=
 =?utf-8?B?OCt1YmFtVWU0d2ZDM3BzVzI5b01xOUtxYlljdVk2THVCZ0RQaDJhc2pqTjJ2?=
 =?utf-8?B?MTFiQkZ3RHB0MWtRY2lndkZIL3Z6NlYvWEtJQ3hMZG9nT240VDZQYWJEV1ZW?=
 =?utf-8?B?RFZxK1NlTkJVZm03cng1YXQySXhUcG1UT1FIeTRyOCsyWGE5ckNLdlBsb3Za?=
 =?utf-8?B?dFp5YmhvaWFLZXNJWlBZMENoUTNFWXdiNGhPc0FMendGRHR6T0g0SEJ0Sm1p?=
 =?utf-8?B?NFhqaFRJTFRzVHVpR0dyN3ZhcnUxMFpaOTNYSURvYTBpNWl1aGxwczJFV28y?=
 =?utf-8?B?NVU3bTRoMnZDVDRncG1oWUdYc1M1SGxIaVV3ODRiMnBGNkp3MU13UFp0N3lq?=
 =?utf-8?B?RjcwK05uVnRRdnNDT3VtMzk0WTBJSE5ZSXdkQXN1SzZ6eGdjRnR6YitvZFVv?=
 =?utf-8?B?cGdQVWp4Lzl4K0NCZjVKdVVLa3lsTmRPRVJCMlhla1loUXRxUjNZSTlkU2Jz?=
 =?utf-8?B?dmZrd3krU3U2bkN5eG90MEt1Q2Y4bnBocllpQUxUWUs3QXAzSnc0aGJRMUUx?=
 =?utf-8?B?bGo0NnRQMnhBTzZBY0tSelpmRmFXakhqYmlLRFJ6TjRvUC9pYjNsV1V2Zkd1?=
 =?utf-8?B?eWZsYTV5RlhZSzFwcnRseExKNXBuZjdKMXB1OVhuWGVGY1R6TTVCd3dadDA0?=
 =?utf-8?B?WWhMV1dOajRGbS8xd043cHhwM01IM1VEN0xBTkJYL2x6NjdkQ3RGNlRPb1pz?=
 =?utf-8?B?c3FwUmFoVjRhTy91cFp4cGpmT3J4a2R0UFQ5TmhHazB3L1d6dXN4Q21mUUM1?=
 =?utf-8?B?Y2RETFBEQnh0VWx6SEtvNUloazZMN005K1FoSXNFMEVVOG9ESjNyK0RlcHRu?=
 =?utf-8?Q?5yvk9GjuyXIoUea2fH7uxSn82K/fVB/sMTUpOOGjbtxbn?=
X-MS-Exchange-AntiSpam-MessageData-1: i87uYUF7/4a/jg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69f0c86-9516-4892-0922-08df28fa1395
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 07:17:44.8728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3Bm+8MPlSR8yAfaSehvHII+ZCZJfLwMUloeqIXbxARHFUxNKD4h8nkLm1Q0bU1zvrjbhc6KHWesPvT/U47l5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534
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

On Tue Oct 13, 2026 at 2:58 PM JST, Eliot Courtney wrote:
> Currently, using NonZero/Bounded constants is quite verbose. It's
> unfortunate because it disincentivizes using it in interface boundaries.
> Introduce a macro to make it nicer to use. The macro `cv!` (for constant
> value) takes a const integer expression and widens it to i128 (at build
> time only) before passing it as a const generic value to a new trait
> `FromConst`. The value is then converted and appears in the
> associated constant `FromConst::VALUE`. The trait is implemented by
> NonZero, Bounded, and Alignment and lets values of each be constructed
> from constants without a verbose turbofish syntax.
>
> For example, `const { NonZero::new(1).unwrap() }` can be written as
> `cv!(1)`.
>
> Add the `cv!` macro to the prelude so it doesn't need to be imported
> explicitly to use it.
>
> Suggested-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Acked-by: Alexandre Courbot <acourbot@nvidia.com>
