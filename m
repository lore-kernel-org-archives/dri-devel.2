Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81867CD13DA
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 17:37:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB1F410E032;
	Sat,  2 May 2026 17:36:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VfqYHa1k";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013054.outbound.protection.outlook.com
 [40.93.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C90E310E2BC
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 17:36:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKDJX4rDDtK9nfhK2anqieXD350iDMMcw0ffR2uTGSKYBFWC5EssQDd9L/ImpJG4brvfdlhknPVw0AktznPooFh5SCTSAEmQHIEPB6dS3rcKdPhfubNWJDIW5MKY7wN6BIqqnHMl7cy+xwPkE3V32jhIay87ApGkrpnhfc8xJEO3jHdY5aVc4zxSuTe8sUYEAi2ZLSFk9J+7Yl08DGcWwfTva6rI6MDd0sZue7bKukbQEf7X1XS/Y60Rn2/8rgfX1Gnj0SXh/c+K1VuK1oGQP5ny0XFnviUFyttWYOx6dwznzywdxJ2VhEiebjDXEbA0qGqh0aH5PIixt+/KgPNcPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bdF/k6Bq4YdqsTqRmfHreYO1fcZRKzt/+k0LqgTpAs=;
 b=GTGtbg+Cu0tPYRVquBvLWSIJU7XChgzL18jKcN5ETOeusIeSu/1OYSgqX9KWTEBEM8f5fCWsb5L1YSacGkPt2z4AFzEfhupQ8z9bauChLP4xrK2vSPvbb9edKp+hdXMjm/2+ls8S1sY6PAuWFezJyOK9lHdNwbN0qtrW97xuIkuuFnS+dqfVFpMR4jxneyzq6UbeBxJQk5uu8vguHtDiOkcb/mlbPhvvTr3IGvPME5s7flFAuWwgjh3BCwI+nN6OUe2EaAbFbUCBfUZom2FQlHXkj0eQ0OWZQ4uHEBpCgx/M7gtO0YGIDNhiCwhV4C46MZSfybDhhhcM0iDVRfHv/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bdF/k6Bq4YdqsTqRmfHreYO1fcZRKzt/+k0LqgTpAs=;
 b=VfqYHa1kon3lgJr84MDQ3Yv/8JTc23LI4hTkIvl68eLmg7hEDNwZ9/w7pH6tbzw26kWQf8jPgbPpNKjagVU8HhLPOqhMlSP1ovXgjfxz03aBc2jbrIbaXZgL54LD/u3spFPYvz69G6TlGIJZjpZkURyqt0DaQahVA5N6kPmjXa7UNe+G6XD1YI73be46b3PdCzQtMjasdN/Vbf1w3PSdWM4aDdVhE4nwO7pbzScj34Aj4JXLX94nPqQ07z+tT2qQ8NH8lTdgvCZgUnztIKDHu0IE+yE0a2mpYEQhTgJISqIKAK3XHR3Gwtso/fYqMWtTBCcScXm2e2N5+283ozBMDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ2PR12MB8012.namprd12.prod.outlook.com (2603:10b6:a03:4c7::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.23; Sat, 2 May 2026 17:36:54 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 17:36:53 +0000
Message-ID: <252a4eef-f4f4-4edf-8154-06cae4ad8518@nvidia.com>
Date: Sat, 2 May 2026 13:36:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 22/22] rust: maple_tree: implement Send and Sync for
 MapleTree
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, Nikola Djukic <ndjukic@nvidia.com>,
 David Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Andrea Righi <arighi@nvidia.com>, Andy Ritger <aritger@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
 Philipp Stanner <phasta@kernel.org>, alexeyi@nvidia.com,
 Eliot Courtney <ecourtney@nvidia.com>, joel@joelfernandes.org,
 linux-doc@vger.kernel.org
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-23-joelagnelf@nvidia.com>
 <DI8B0RAI4S86.2K4SLZH2YS2W5@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <DI8B0RAI4S86.2K4SLZH2YS2W5@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYZPR14CA0028.namprd14.prod.outlook.com
 (2603:10b6:930:a0::7) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ2PR12MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 43225918-68c2-4c79-1128-08dea871661f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9HhwK9NjNgJtbY90n26/lZGX5mn8C+I/GE9+6GEOA2klmUoUF8Jl2MviM7gmUbwBO6/E/UTa1nZeyuM0D7VdBmM2DCciE4F1MekImlo9y7imrLEhubgCTiZ0sSrCVki90QnQzESnvUpWF3ejKbBUmD+CDYBH24gkwKb1HovoEHJBHTIeCJXVHTsDOaZfbYEBxrhFNyoY42vrFQ6RxnkzyD0+xGH6sww43lcH7zCTvzBiWdJXOzdtK0PILEURnKehT7ZTUz+26lRuaItekbop9mUy7yyI0t2qySP4VEcIwsHQJ+eKaby5nxouScqUYg94m4qVXrJYz+tWxbJi+3c+IIiYlPD68D8dTb4R4OX12AmAvFCsFuMleNILWO5dNNuVwsyFm1+janHW09VUIAwlT0B9a1ZirqihFCpxtzahhZWLf6vi+lCDacnV19pvFtTv7voqnOILf9a88T6EFnXHvDZM6t4lwGewB7K+pcK3ETe3c+udJXxH/YbRdtOaTKWxu7JW1WjGu1llk7KOjDJKFEyxzSo9i7l3alJBtTyqbzkgjGlXSPBPN7vZHDBz1EPIiHjWC0KDdP97HWvEogrLEWSJM4hIGO42+oZNP6ZpxbjhNPcY9rHXCW3bhvN52vqGhiEGv6MYE85Z0mfyGm3PWb9opgCbx2v9EwaIMONnnlLItVsjxXVMriEFSSOrWn5G
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWJVV2I2dUhINUEyWGoxN1k4RGRidzRkN2lCZ2lXUTlFbitBclViaUlEcXVQ?=
 =?utf-8?B?djU5bWhid010ZE5jTytTOWNLNmJia2hKVjJISzZXYmxudHA1dUUyQkY1YjVP?=
 =?utf-8?B?QktyUUlsS2laeE03TkhKRnAxR2V1dFJncHFNQzBvSGRZTEVZbzJmMkZKUVhp?=
 =?utf-8?B?OEw1S1lpcitFa3V3VjJFdWpoTWc2ZWVadGc5bFpaMm56L0VYTnltc2d6Ukxl?=
 =?utf-8?B?dUs0MS9YN0RBNE5GYWJlZngvVVJBMEwreWdmWW9JOHdLd2FyY2pQZ0czbTB6?=
 =?utf-8?B?ZTQvd3NCOUI5aTFRTmdzYUlUaEc5cVJ0TkgyQkNTTGdEM2pORS9nY2hzWGRN?=
 =?utf-8?B?b2hMZEFJcjN5TjN2MFc1STJlMUdoeEIxd24wMHI3ZDF1cy81OHhKNTVSVmU3?=
 =?utf-8?B?Z253M1F2dHFicTRKQm9vek90d0VsbTV6ajh2YVowLzVwb3dKemxSa3g5Tm92?=
 =?utf-8?B?UU5VN2FrK2hUeDR4ek9qOEcyYlE5empDZFlzWm5NVStwU1FaV3RKc2ZpL2xt?=
 =?utf-8?B?UFdSMktLUUNySW5mMHRhbjd4b3ZZbks5cFNkWUlnVnZjYm9JTm9qcWlRemR6?=
 =?utf-8?B?YWhFVlhKOW4wdThrUzlJNkZhN1NJTWZIOS96dlVEMEo5YlEzZ09xcE5PL3Zy?=
 =?utf-8?B?MXVXbjhTNGloaVQrOUlOdUc1bnNRaTg4N0xXbS9VM2ZmTzdMcnhTWEIrOFBB?=
 =?utf-8?B?RWpMSUt5M1dRaWhLS0lKbTl2NlU1dHJwbEkxOHB6WUNVU0xDNWV1R2xZd2pG?=
 =?utf-8?B?MG9FZi81MFVjVTJlT0drVlF5SnVJNFNnQXlTcGJFVndXaUt1WGJoU0x5cnMz?=
 =?utf-8?B?cWluUHZLTndzeUIyVHo5R1BQdHZnc2dWSDV1bEw2VmNDWEJMVkRqdE9vblpT?=
 =?utf-8?B?R0hJM0w1Q2l2V1JCTjduWURPNnhkS2hnaVIvYTM1RVVGYUxteFpXbGNrSmJn?=
 =?utf-8?B?YVo3bnZLOUhta05ja0NUUVZwMStiWmZtSytaUmNtMFJRaWJQNWtXNVFwS2Fw?=
 =?utf-8?B?ZzVCRzc4Sy9VTU16eHRCQnRqSEc5cWJuWVRMMytiRlFoNkNLajdXM0dGNHhP?=
 =?utf-8?B?MnJjV1BZVUFVTWVMYlhxNDdQZ1VpODg1aFliUFhCRVRQQnNBcXZyWEJKcUI3?=
 =?utf-8?B?TTFObFVHMWdoUUhBcDI0V1hzaE14OXJlRkltWW5LV1lSU05tU2RNenJKQmov?=
 =?utf-8?B?TVNaalNDS0M5aFBsM09pU0wxbXcybVdCS3kwcjY1K0pIWUQ5Yk1laVNTMmlE?=
 =?utf-8?B?dEpJQlRkVVhmeEVFR0dzM1ZWOUN5Kzc3VVBYUjhZemtRWHJqZE4zWFVuUmxH?=
 =?utf-8?B?OThZVy85UWkxUGw4QnhPd3hRK1B4amIyZXJlejJPV01Nb2p4REYzdXhzcGI4?=
 =?utf-8?B?Z3pPSDk0TnQxaUtvMUdFUWF4SDY5TDNwNzRHN3NPTEpNWUxiQnhvNWM0L0pP?=
 =?utf-8?B?dE1oOEU4VUxIN0x5Z3AyeXFDbkRYK0ZDWDJjdlNlelNOR3MvaDhLTVA0eVNu?=
 =?utf-8?B?L1BEbjVJSm1RamF1TlVoVU9NbkxzZnlYOVc2bjBQbnFSZ01jMjRkdi9kRUNx?=
 =?utf-8?B?c2piT0YvSDhkNkRWV2VDWFdqTE1KajcvUURaS29hY21PZDFiam13STNiemd4?=
 =?utf-8?B?N000VE1SR050UzMrUmNpbFlkMllMOUdxc21uWHNybjN6ZEpZNC9jems2Q2Zl?=
 =?utf-8?B?Mmh4MElzdDBwMndKQm9QY1BpQWJSL0JtVEtuTDgwSVF2YkxhVVAxMnh0aVZ3?=
 =?utf-8?B?MkRlZ2pJbmQrVWthWUNwMStsdWErNE0vcUh6ZHBVSXVDSWp5ZU9TK2ZBVXBR?=
 =?utf-8?B?MDBUckJTK3RQNVlNaDRoOVlycmthajJVVEhQSzQzSGQ1aGZTWkFjVHBQb291?=
 =?utf-8?B?clB1bzgwam0wZUpXc25mbm5FeXc0dC8yV0w3UHZqS3IvVGwwRTBiSjBEMHdq?=
 =?utf-8?B?ZTN4ZUJRYXFrcGphd1ZaS25XcDNlWGtQRDlPYjJuVVZmdGtRZTgvbTRMQU9x?=
 =?utf-8?B?Tlk1cFJIRnZHNFY4bEhWTXRkZVlxMEVDalhYRVRoUHNqeEV6QlFyYlRqdE0x?=
 =?utf-8?B?N2htREI5TDYrRXE0NlNGaEVKQW9MQVFWaTRNQmVsN0FLa0Z0NU9LOHJvVmZ4?=
 =?utf-8?B?a1g4ck5ldFJxZnBTaXFJYmhZNVlBd213dnUrTE84aWZ3YVE4NHY0Z1lGRmdL?=
 =?utf-8?B?Mml2NzJXY0laYzdXN0EyNXJqbHozS25ab3VtaHJUMWloZkxITkQ1cUJPTWp1?=
 =?utf-8?B?YUdvYjdGNnFYT2MwS0pqdHdhRjhHM1hTNStPZ2swTHFVNVZqUGlqb0Y0bVdD?=
 =?utf-8?B?amZMRGk3T3V5bm1pbjlkc05LYUVCZnVtYTRnTGE1OCtHcVQwWnA2QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43225918-68c2-4c79-1128-08dea871661f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 17:36:53.4520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 798FcDQsdt7VA8WuXd0W1LVTq3kIZ76l43DMPFTjiWcnZJEeRKLSCcvLoySwXeEVPjrIP7POoSNNEIRoVrrOeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8012
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



On 5/2/2026 11:42 AM, Alexandre Courbot wrote:
> On Sun Apr 26, 2026 at 6:14 AM JST, Joel Fernandes wrote:
>> The C maple_tree struct contains a *mut c_void, which prevents Rust from
>> auto-deriving Send/Sync. Following is an example error message when using
>> MapleTree in nova-core's Vmm.
>>
>> This propagates up through MapleTreeAlloc to Vmm, BarUser, Gpu, and NovaCore,
>> causing NovaCore to fail the Send bound required by pci::Driver:
> 
> This patch is not at the right place - the last few patches of the
> series won't build without it.

Right, the maple tree change in an earlier patch makes this one required to
go before it.

> Besides you have sent it separately before this series, so just mention
> it as a dependency in the cover letter, so reviewers can pick it up
> before applying the series and not witness it breaking in the course of
> reviewing it. The cover letter already mentions the bitfield series as a
> dependency, so the same could have been done for this one.

The sending separately bit was actually an early RFC I wanted to get
feedback on. But indeed, now that I have got that I can just post it
independently. I'll post it separately once I am back to work. Thanks,

--
Joel Fernandes

