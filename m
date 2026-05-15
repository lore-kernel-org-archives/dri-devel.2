Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A13CD4F3C
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 02:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA01F10E411;
	Fri, 15 May 2026 02:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="PkjeAqQb";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013034.outbound.protection.outlook.com
 [40.107.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 599B310E411
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 02:20:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuWxRn02SpNTruAxC4wl/wNLSZR4Y1jENFne8G0zW/tENYJZvzP8vCwkosKCHknASoBXNzHOUpYbYyyIlZsh5UaysM9LDIexpIRWaqfRc7N2ynJ4aDJP3jWaufxVsLwD6MD4bC0E/G5oNtTetE8Y0p9VHV5B+5LtHTIhRP4kSP9pNKYD0pKuF4byvXsgHV8mOpPbS7EnPKjUAsy1nHRSCKUOOnHhFICTJdlMkgAOS+hFtl9wtwnMlMOxc9zTMRpH03SIhGNUnHn3fNf1HECvFPE8KOrpAPGSxPUE8n8NOcFVyrnIQkBtKfdULDQFl03KXz0zBj5R2p4trpfpdeOEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSXENkhfDd6AaxTOYQTifL88J+VWSRRRWrpV1SfawrU=;
 b=rH4ifIq7Tw7ZdfOE/s2+HQakXF2Ev2usjUV2Kr4eJIkbp4X1OSOVDU74d9e66q8hVBcPYHXpZgcsGMiNupWfVzFFvZaRhCtXBeQ0CG3n+YnlMv5rL16Yy++BvpFSzFcsWxo1/sfil0WUnfI7Tnm7mt1rhuUp6EJnwCwW8YSQ5xe/uRQLQMG6+hkbEwQA9IF9mY6zXgWMpp8I4CsrL4OTLzaVgjtDrbJEOcppG55HuEFfpRsktgM5MRkMWtvHN2AGPdeDVmrKE1T48Jb+csWUtlC2QG93opzzJ0ZPRcnLGUK0ikjVWsEsyXjEpfkHVC+Iu9KFs8xQd+MxMsRidUXABw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSXENkhfDd6AaxTOYQTifL88J+VWSRRRWrpV1SfawrU=;
 b=PkjeAqQbiG0S0qhMr2CAImIsTlayIME01t8N3iuQQ2wLhxpStaqYpvCxaDoFsxpxi+VFwzmpe0v8G5ZmbrHqyd524KMF1j8wg/WUGXzEuYvYPh6gF/tzV/biJxzo1JbXYZcbWWejVbN8oTdJhtZRNUsQgFhzaQ4e8tqSASRJRy//K0+FpjKBdi8ngI0zO8oRKCXlzyBuq3J7dPY5+GlCu6W2XV2AkUr0GH38+41pdX8Vv5zJGoLK1QXpbXSG5tUhchBwMsePTPm2spPDFFAIuoRHQokWMKTco8tnEmYEFANX14GQLhfuSlvFlbjg4AnlkT/K6uKdLxPgRfv8IYN9MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DSWPR12MB999151.namprd12.prod.outlook.com (2603:10b6:8:36b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 15 May
 2026 02:20:46 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 02:20:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 15 May 2026 11:20:37 +0900
Message-Id: <DIIW3L0LG68L.2ABZYIY4KTBB5@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Boqun Feng" <boqun@kernel.org>, "Alistair
 Popple" <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] gpu: nova-core: run unload sequence upon unbinding
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>
References: <20260422-nova-unload-v3-0-1d2c81bd3ced@nvidia.com>
 <72641f20-a15d-4ac8-ac1d-26c88f52ee25@nvidia.com>
In-Reply-To: <72641f20-a15d-4ac8-ac1d-26c88f52ee25@nvidia.com>
X-ClientProxiedBy: TY4P301CA0045.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DSWPR12MB999151:EE_
X-MS-Office365-Filtering-Correlation-Id: 339678e3-ef83-4476-2662-08deb2289263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|7416014|4143699003|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: ybvfe1E+DUzYvvXIQqzvh6pWmOODlRcx3eKwLRjk+lg7U/R6c2v/+sZInLktw16gRwXxOOoMrQFNOSiyCJvbUjDXXxVMAucqBISG6226lAKk1Dfb6uhB60GMdAzpZ2QFcclBDgRv4IESvq43MtOLKWawDFCJokB8nOST2skE2yJC6FQjyTmDv8jk6t/mAkcTq1ffil6DILHwT3OPGjL2n4eS5dsvk4DvOmDcUq/rYMn1aOr2V+flIiQUobpDhxi7HfqOnt4092hermz27Rjra7pCzXrmTl2BnFyDfC8yFYvEjRfgO+wYvdH0GhqxjTZ1IIeH1vW3N053d8KriayVA03/oEHJPqwkCmqeutjQ6gkwzSBk9dOrYqaI7LjWDfz7xzo0jk19qJeyTKk+GeinqeOxNuWpw1KhIcn1aT0IKnrgTZanMxGzj8eS0ikT6eHhx2S4lMiZh9RcHcWMNwcSwunoHFdW3QQiKDJRZas6D5fKIn/nfCCg8PRIvkHvWE2UhRxzbFgYOKvishZ5/EVmeIrkrZxjJZZUfHVVfmF6nVu1ucexJUSkn6hM3wduKmt3cmlh518Ze13qFVgjD/EHi94CG3lHsLtKDetgE2Kx6uNmAiFT0OR6mqExGpLh0o7+DDQbc05b+A5cAnzqNfhnax0wCJsmJLxkGdCmFWwO+Fv27oph81bpEsY4MbEBZ78g
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(4143699003)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW1HQnJUZlVPaHNOc0hRT3BmTHJVSFYwc2E1WEpvcVRwd1RLUG4zb1UvMFVI?=
 =?utf-8?B?Rmp3SkZaOEdIQ0c1RktXSU53bHVXNUhYNXVmYWFMcFhnL1JCS0twcm0waGdw?=
 =?utf-8?B?R2F3SjFBMGpEYXJkNXZRK09MWWZ5Y1Nsd014WWVvdFZ0Y0dUUk5lMFZXMGkx?=
 =?utf-8?B?MXlBbzN4OWgyMytPcWNtQ1dLU2pCRk84WWFDM2U1QS81bXc5eW03MzRpSTdr?=
 =?utf-8?B?Vzl2RzM0bjNIcEhseWhld21GN0RjMVNhUWJRZmJScEwveUpYdkpCNEozWUow?=
 =?utf-8?B?RTVtc0FRc1llMEJGYU5CaytKTHpHRHpJdXAweE9LOWR2bVhZQlpiRHRtY3ZX?=
 =?utf-8?B?MmEvT2tOaG9jOE1WbHUrWWx5cGZ6ZjZRdUxuUHhHTU5ZM3YwWHF1cnNFVG5Y?=
 =?utf-8?B?azVtZlNXVDVudTB4TnQrOGdWWU1kbU9MT3gvUWxuTmRKeUd6OFhUNm9JY1dU?=
 =?utf-8?B?OVNZKzVVaWxDRjAyYjJna0VzSFRnZWFGL0xwLzh3UFp4U3B5bWVJcHFlRWJi?=
 =?utf-8?B?R2RhdVRkQkU2R2Zpc1FYVWVpd2hJN0R6Lzdkc2dMbkJGNlpnWTdWa3dzSVZn?=
 =?utf-8?B?MENyS3ZaT3hlNEpxR1ZwSVhMTVlDTjVRcmE3K1E1VUVDMk9qT3U1L2syRWM0?=
 =?utf-8?B?NzRPT0FiZzFXZWg1S0hHMFVjYWRnRlJaM3lvTVo2VnI0aVZjcThRWXlsRmFH?=
 =?utf-8?B?Zi9qSTFSWENhNm9BSzRocG9WTnpQUGFJVm82V1M2VGJTNVhveisxR1VrUjRJ?=
 =?utf-8?B?eHgwYXpKUDdJcFVDbURQQ1UwZnlOMkt0OEpnNEQ0UFNwN0ZDZ1l4cFZKaG4z?=
 =?utf-8?B?V3BwRzNSRndEd0pPTzI0WGVaSUV2aGR1Ni9CcnVZT1VUVlgvMksreWp2cFlt?=
 =?utf-8?B?aEllT1ExQlRDeXZQckMrS0JvM3NhNFVsbVlTN0RRSmh0Tjd3ZUNxNTljc2JC?=
 =?utf-8?B?K1o5Y3JLOVROaEpzT1AvY0o4REF0dFkyWmI2Z0pwUHMwblJXS0R2NU1OVjdk?=
 =?utf-8?B?YzJMK1NTSFJMdC9WR0FpVmJvNktMSUgxeVEyRVdyUERJYWNILzlselkrbzFJ?=
 =?utf-8?B?Vlk0UWo1VWc1bXVYZTg4K0V0Rk1BTFJiRkcweHZPcFlZalhGaC9GQkQ0aURM?=
 =?utf-8?B?MlNMMTJJN0Fzc2s5M3VqbHpPQUV6VlhaektpcjR6LzlnQlFQby9KVGNNSEE3?=
 =?utf-8?B?M213MVBxT2ZzdGJvalN2dVBoUEdSeEVZaDFjT0VSSmxFMlQ3b2hrcnc5RGY3?=
 =?utf-8?B?b3k1cUNSRnJ5TlkwTnNOQnpvVzI0K0tDQXYycE9UY1c4MldXWUIxTDJqdFZm?=
 =?utf-8?B?L0tjOXdMdnN6ZmpoTEQyZHlWcCtnUGtMZXkxVE9WQWdZSnFYK2hYWWRxNVRo?=
 =?utf-8?B?bUZBZFNJaVF1aGkvSmwvQmtBWjRsc2kvQURnKzgySnR4MFRIeXJFcjlrc1M3?=
 =?utf-8?B?bzY1cUVOM2trSGxFZU51T0JTUE02S0RSeFVibWpZYkc5amtUSFRYV1lKeFds?=
 =?utf-8?B?WmtJc1VjVEhpWDRnNmFXanNRcVdaQ0RvRVBIbWREWjBZb1M3V21iNE9LZjIr?=
 =?utf-8?B?NXdLZUh0TXJrYzlPcDJyc0hkVEI5YTZVRU9DdGFGTlowUTZ5WHRTNlBRbHh3?=
 =?utf-8?B?OFpIcVR3OTgzR3ovUUNjOXpjbHBpNlJxNGtJUXVaNElzUitJaWphMWVYaGky?=
 =?utf-8?B?U2N3dHJMclBYVmRRbENpRE05QXEySE9EQmR5RExlZTNoVkVzZVBOcmxrWVRy?=
 =?utf-8?B?UVNXNHZhQVdNWXJFbERvVjR4TVVwa3dQVm5HU081S05sQUNhaFZ0SHY3Q0cv?=
 =?utf-8?B?bkl3YVVWRTI5ckpvc0dueEg3NnNSZTE5bXg5ZW8xdkZpZEVnOUpNd3V3dUI2?=
 =?utf-8?B?RmRXZkhxMDBhRS83NGFiSzhCZitFZDJEaDQrRStWMy9UNkNaUUwvTzF2T3Fk?=
 =?utf-8?B?VDlJRUpmbWVXZ1VTdnhleHNvczlsN2UwOCs4ekJkUFVodmxITUZMUzAvNHhH?=
 =?utf-8?B?TFljODNOQktoaHhsSkJkWWZyc3MzZ0N6ZVA0NEg3TStDNGdrWTVkOEJFVU5x?=
 =?utf-8?B?MVdGclRPV1VFTERNaTJmZk5VNk5jNjZiS0ZMMm11Wkk0MHZiVFNBaVNQa3M4?=
 =?utf-8?B?dFZVbnlEdEV3K3JKOXBuRHdQMXNYWkUvWmxVTEtJcDIyS2taQlg5YjZVc2FT?=
 =?utf-8?B?L2Q1MUxvYml4cTg4N3lQRWZuMS9FbUJ1LzBRb0ljaWZtVWZmejA3TlJOYXl6?=
 =?utf-8?B?RGtoQTBBZFdvV0h4eFFWYnBpbGN3LzcyeUVySHN3b1pNQW5qazl4b3E1NUhj?=
 =?utf-8?B?ZXJBWUc1MkVFM0hiVUZseHZlU0VNRHZHd1ozKzQxaGtxektKNTNBRzlCd2hm?=
 =?utf-8?Q?pUOlmDx+pa6q4S3um6paQzoZY7OU/tE1YOKZQcT2mIQO7?=
X-MS-Exchange-AntiSpam-MessageData-1: BtPwlM/hWYfbCQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339678e3-ef83-4476-2662-08deb2289263
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 02:20:46.2144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5HSNvqDtma+i/uMPsTCgW4N1KYtgv022sSJGRCk5WSrW68uMjKsnzSmPAWnxx7BWWbiu6BiSXfCYsHBLB+RJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999151
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

On Thu May 14, 2026 at 5:59 AM JST, John Hubbard wrote:
> On 4/22/26 6:40 AM, Alexandre Courbot wrote:
>> Currently the GSP is left running and the WPR2 memory region untouched
>> when the driver is unbound. This is obviously not ideal for at least two
>> reasons:
>
> Hi,
>
> Is this ready to merge, or are you looking for more reviews?

This needs to be rebased (and applied after) the Device HRT series. I
will try to post a v5 today that does that.
