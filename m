Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DB4606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Bqvi3A7z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0957E10F1C9;
	Mon,  9 Nov 2026 12:08:37 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0DCA10F1C9
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:08:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aS6R1z4G2E+hZ49JS+dHtPo2z0adhZPX6SvIrtrlScjtK2e0BGNjhWUFkJJgus1tnhmMplpmg6Fpy7XevWj8fsv3DVTB7GNqeI9fR6QTm1qlytf5UWGgtrQC/J0QYvl3hm16dMls5KrV8G9h0daG7oMghjad4KBGWxFAeOt4SpbltVTpmMYCIzhOYFCAdreYcOyftyxCKltWhWF+jR2S8rSwpRzhznqXZjUKBCw4tuq6ao1IcTVpTL9Rb4K5OcteMCiHPXrZtqibfLHtLho48KmxHDr22Gacjg015BxceDIe3vR9bzwq+rmUWtfB+tGnZ0J7msW2u2bLpS7cQLQUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPuqOtcKETNZ+9NL0dzC9IlGRwh+zSe9grKnZnim9GE=;
 b=B0E0bw9N3BZ27bcf6EgUo1VRfhtCQ/WPyOZg5dn9rtgqSkCsTtjTy7aPD7FcC1nukvUFumcIL39CnBBzuPRrMQW9v8HxuPK/dz8Kykz+F1HAlLzalTeA+1huNi9xkySuLctuZS12OeWx+DV78ZGvboyh4SM82NIdL+jkRecnQjCZQylhYDTD5uUItnAmvtNRo1ZO8+GpoWjP4JkGEt3TGAw5FIpb7BZIWTo40UccytIeZkMRfdnauXcEej+64OnCJh+XrT1rs6bDdAOWF3h57cUzLWHjfsSjOKf0MPD9byCnrBXmzlulW61vYyu1eEE7YQnAvgRvuKfDNi2Tg/9PBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPuqOtcKETNZ+9NL0dzC9IlGRwh+zSe9grKnZnim9GE=;
 b=Bqvi3A7zhwY5W/YJtNX5lEAeP7vKz8Qo7x0EtfnOVzT17EKJxvTbN+qGNYTf/Av4lhAQ5uF7bmJX8+Zjyflk7Z8qcKmTO6kpM+VHPf/0fjgYEa/UCabCtkAmHTb8x2XNn9pIyUUfctdT+BX7+EpnU1Tg4WFAQvbtLD5bossGms9fN+1YyuHYbcxTJV1bVpz2OJhZKNBG1vVZNMYeEqStWjleR4Vumsu864Qz+fUm5I/DRrPVJ+8bYZQ4jy1FUpCwPXZD+DLbgVVJV0gH73Rr6cE7tw0OstTSlw/TMcNPyvwixCcY/slUnuSdsmUbLUPccBSKDshNmFuVQFzdHUrtEw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by MW4PR12MB6850.namprd12.prod.outlook.com (2603:10b6:303:1ed::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:08:27 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 12:08:27 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 21:08:24 +0900
Message-Id: <DMQO2LBNLJGK.3DH2LJGMV41TA@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v11 4/5] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20261109-chid-v11-0-082aa9bf5a91@nvidia.com>
 <20261109-chid-v11-4-082aa9bf5a91@nvidia.com>
In-Reply-To: <20261109-chid-v11-4-082aa9bf5a91@nvidia.com>
X-ClientProxiedBy: TY6P286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b9::6) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|MW4PR12MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: 5481a336-0d5b-4ccf-4ab1-08df3e5a296d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|10070799003|22082099003|18002099003|10067099003|4143699003|11063799006|261028144727099003|261022105027099003|56012099006|261026140227099003;
X-Microsoft-Antispam-Message-Info: fppPhfJrhrmrVqWM8L8OoW+xbv+ydzRzHPjtMus7gUjO6ZDX7v2+ad3DWxCGui5pUkhmffihlyHsX5IPlEdDj0rtD/icZuTcKQQjk+J2Bw7sRZ9Aio7023MdQ2ryK/ADePrcNBGROU2jaXksiEBfvAAcN09+1m6TVn0b/VSiPV1oOZ0b3/+4zMz1vsMb2MWmTAyRCft9iMBRaEmseuGnTCE0bIsneAfFnu3Lgf9teqaVHJP516yjr/pa2zoZXSxRsftMVTqmmOLou16Oawa58sgBqx/3IpfLkNZdq65N+pbQH9n6DWmj/OMyfs0e8SO1H3uoActl5nrqNHUMKt30tsnJYjJJf+myjiRsTFeLoUEEzKucKC4vxerUuC5clxoqh5GdpaaNIHBhRFJn89ltjcnlQpPqe1IgRFKxWxs1AWGCnqIxmtobbRkA3ats1BMzTZBCl2pyfWHHlrZ/Alka3esHBg4OFwSbgV7BrU+53FNR8gvBvg6iwbG7MR4R66j7cKVPpT6zAukA8j++7nrALB1rdv+J/1iWS3++Pa9Ot9MvPnGf+XghjMQ+G71h1iDE6yUCbv+mKJnGckRE0I3yvjVeqKTYAiNjJaAApV12GwkGcYZxeWOzB6zsTag7aHBYyDfpp0uPkSq2EvnSXCHlTCP8vSg0va3Ofs+yJGLlfd8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(10070799003)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(261028144727099003)(261022105027099003)(56012099006)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW5wL3dDTk45d05MZ0s0Rm5lOG0yelB2MXdlVTRGWVZlbERWN1NzNDBpK1h1?=
 =?utf-8?B?SHE0OHV4dkFCeDhhd2ZnVXF1MW11bkQxSEx0UW04Zm5KbVFLWFdEQjVjcTVH?=
 =?utf-8?B?ZGZFY21zZ1h3OUR6NURBMXA3WnhoNDA4eXRvS0FVQ3ZwVXlsdjcwSENHcEVK?=
 =?utf-8?B?blV6dmZqaFNiQkw2VXZkTUs2a25nQzJmVnRNbVhvL3Z6eExyQWxPTGx4YWRt?=
 =?utf-8?B?VHBoZG5kYlV2L2xvcEQxbW5GU3lZODVYdjAySU1OQitaZ211M3V2QVpPaExu?=
 =?utf-8?B?Si9lTWZ0TmI0TFNZYWh6a2VyNmlFeTFDbXprRlBhdUI1bHQ3U01ZMnl2c252?=
 =?utf-8?B?VzgwcVQ5bDZpdHBzVjZGZldJMzh6RUR1SUFEQTFDQm9zVTUwUmZtTW42YVRp?=
 =?utf-8?B?S0NycmJLRThmNlZtMTF0UjI5K3hOU3R1d01HeWU1VVQ1MEJIbzZmZHhxc1Jw?=
 =?utf-8?B?N0hSM0lPUzV4RGpwcDNIbFJwMUN1VC8yRjAyUUJJY2FOVEZXTFljWHVpMG9m?=
 =?utf-8?B?QnJ2OU1aLzhaL0ZaWE9LYllUQmlMM2dnZEpTM1JUR21kMDl0RHhwL2Uvb1FT?=
 =?utf-8?B?dmNXVjBMcStzc2ZxbCtqSW1MTDljWjEzZDdQbG9aQ3FCd1RLcSsyQzM2ZGNs?=
 =?utf-8?B?bDRyQzZ2MXdBakVFaHpaK3JON3g4ZllJY3cxdnhtSzJXZTc5YSswbUxta3hl?=
 =?utf-8?B?MnNZQWNqbkEwNS84NERNYmpEYXFPZXIzNlJpSzhjSTUxaGVvaFlkQWZ1bFRP?=
 =?utf-8?B?dlhuczhGNnViU2RocDRDUlh1Z2NhQkpRNklvTDNlMXdoZDFqVWJsMUlHUmdX?=
 =?utf-8?B?Rlo0SE5KajFhUTFrNnpsWHlBSkRwRWhiU3pkTmFBQzJ4bmNBWnBWZTZub0Vp?=
 =?utf-8?B?QXRFbmRoL09rWE1TRVMvYTdhaUhRVG1rNHR4WWJLYmtrM0VVSnBoR3lOaTZW?=
 =?utf-8?B?aVNWOEdEaTU4K2RtMFZWLytSeW9JaXh1T2tmMmxsL3RtNWhhdHY2ZjJnYXhY?=
 =?utf-8?B?b0g0S0sxQ2psVlZzQUhPMVRyVy8wOVQ1cnJLWmZmeitNRmR2QjBJSzk3VmM5?=
 =?utf-8?B?VU8wYkk2Vk9QRzBrdFhKZ1lzbjdHZEFGZTdxQUZ5UWs1MkdnbVRlQnNnNm5M?=
 =?utf-8?B?eURHdHM1NSsxQ0Y0R2xpMXZtc1lXV0pXL2kwcnhjUjUraC8zSTd0TU12TmYr?=
 =?utf-8?B?SDhYL3JSTkhEZytBVDBGN3lCMGpIbVQ2dzJBVUpzSjA5MUJPbmFOZjZab25W?=
 =?utf-8?B?dm1SY0kxRUh3U0xDRFJGNk0zNGJ2M3BudVVhTE1uOU9hbzZZT2dUMWFMQkdu?=
 =?utf-8?B?dG95bVpkeEkxdDhpNWE1Rmt1QVdOd3MwaWtIMnhyS0FERGExQ3kxbytqZUk4?=
 =?utf-8?B?TkRrU3c5QkJBRHdXWDBZRi90SUErUzB2UXl4RkM4c2NoMGZOYThpdWQxbUhU?=
 =?utf-8?B?alF5NWMrUm1GYklmVFd0SDNCSTA0Y0JPSjBYVFdVanhmVmxmYlJsd1pYekgw?=
 =?utf-8?B?Z0RKNG1tQi9uV09uaUtObTlqaGg0aVFITXUyN1hVWXltZXBuZFdjcFh5U1Yx?=
 =?utf-8?B?Tm80dmx6MzltZ2lKNUJsWUdtTEZpR08rZEVMVmZPM25EZ0RDRjQ1VWNLSldV?=
 =?utf-8?B?alB1S1daZFk1VHhONkRFdDBDNGV4bk5kcElJSjBLdXk2aVVkeFMvY3J2VTdD?=
 =?utf-8?B?TzkzdnBRSVNxbStzRmd3dDdUV3V6bHFZRXE2UkQ5SXpjL0lDVEFBSXlNMUZ1?=
 =?utf-8?B?bzVsV2Z5Mkt2TmNrU2w4N3FRbWVkUVN1R2lzMm5BdnFtdkFZUGNJaUZJL2Fk?=
 =?utf-8?B?UytGS2xYSWhnaDBjMlVFQnNuNG44ZU9RUmdtakZrVE5qU21FS3ovVlpKNHJX?=
 =?utf-8?B?VWxTcVh1SFN6d0k5SW1Ld0dyMWV6ZTVPalhKU3NFVitPVHlKUlAxY2FZRlBG?=
 =?utf-8?B?VDRkOXNWZkZRY1ZKSldHeDBCQmNNYjljTXkrK0htV2M3VGN3dWdBcTZlVlUr?=
 =?utf-8?B?UCtHRUU4ZDdWcVBJckpRZ3VEZ2xCY3psUk5QYzJHc2dxWEpZcldTN0VGZ1JO?=
 =?utf-8?B?VjNvY0RSRkEwb3pNY1kzY2N2dzc3elBnWG1ORUUyb3hNeno2Y0s5YVNMUy9k?=
 =?utf-8?B?M1kxWjJjbmJiUWhVRUVPTGtuL255cnNmVjgyL2VEUFFsME9GMmFKRG52MXdF?=
 =?utf-8?B?bE9KaTJkZHZISjBjUXVCREtzQ2NrSDNRTVZFTWVWVlB4ZG1ERzFoK2lrdlA2?=
 =?utf-8?B?SnlaN0JrTStqVDE0Y0pmRldCK0NlcTNuTEh3dmJFT3BLYWdEZy9iRXhYeTdj?=
 =?utf-8?B?MEdOTzAzOFh5dFBxRGRYa2ZyVzR5VndxS1JPdDBaTUtxSnFYTzFOQzQ2OFFw?=
 =?utf-8?Q?ibIYZOiM6QYmeRnN5B6jCTTxfSPJgYZ4lci4mtggx6vIh?=
X-MS-Exchange-AntiSpam-MessageData-1: R9dFAID7t8K9IA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5481a336-0d5b-4ccf-4ab1-08df3e5a296d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:08:27.4033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQiLyZbcsXQbnQs0wlwCuH1IOI3VSWk0vTq7ak+Jb/hkdBvau/kyxwwdOhX0/6iNNNcliVxaU+8Px5oUjtbJzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6850
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 9, 2026 at 5:32 PM JST, Eliot Courtney wrote:
> Current code in IdPool::with_capacity rounds the capacity up to
> BitmapVec::MAX_INLINE_LEN, but BitmapVec::new works fine with values
> smaller than this and still uses an inline representation. Remove this
> behaviour.
>
> This allows specifying a real capacity of 0, which was not previously
> possible. This breaks `grow_request` in this case, so change it to grow
> to at least `BitmapVec::MAX_INLINE_LEN`, mirroring the capacity floor in
> `shrink_request`.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Burak Emir <burak.emir@gmail.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
