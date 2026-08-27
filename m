Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C889FC61DC6
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 11:30:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E21710EFB6;
	Thu, 27 Aug 2026 11:30:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ihSe45uH";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011028.outbound.protection.outlook.com [40.107.208.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 825C210EFB6
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 11:30:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPvhuGfy+sI7UUwXCcN0E9gUYM/1rf5JIHdWfunyB1Kf//r39NyDBv+hbfRoBQJPh074/cviHgblzN0BB9Ed06RJTfbBHX50p/HJ2rQp3khI5QhM9LFwDlSMy/Yhth7p0BL766wBT4OKTcTMTn5XakCfO+oUjXZVAOGVa3sZJ5/phhW/Uu8uDksJvuoow0Ix7lfcLrdB4bNKlgU6InOq21RHL7Safkied8NgxVHxRKTIM8cwvEbreKTeys0HgueavwAcLRWWzOegS69lNkvaw1REl7Qpvt5beGEePmQ27t2XvwV6DeVS0WfTlvkqtcAsdMUFFSYlkW9eEnqubdgizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HteZFtmD8cavf1XatsiGOrVoQxFua6NqBHglH8IQTMM=;
 b=xclMlP1kMGC0WL9Lt1hYMyPPF6R6z9U8CHHmth+vrZuMNvFSXzDXLNvIB4fS5MxoJNz2eBPrszhDcmpg/z/+PpwL2S/U0tmi9TLIco/JeN8PAgr7lJX1h2bgrocVzDEafeOgwJ6Vj4zme3DzURPetLzAJLEd/qf/rpmB3FV9hh8MmKzY7pJw0c9MOcs8wCtjM77h+/UNWz60cPyBrWLPCfzawvEDFXKnasCx9N9WoMf6M3AQHlmuKzxkwZXGBrtLkZWkpS37bgrH1OEMtNyNfgo/CNZ21EegTfkbmTX/fPlG3v918rGqxvVlOvtxUFtTmvFTHuvWNJL6E8uwzlf/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HteZFtmD8cavf1XatsiGOrVoQxFua6NqBHglH8IQTMM=;
 b=ihSe45uH9/QySF3FGdnYKN3qFscJW9Dd9+CPrCtga87BVH+oYQ54lDA0S1nXLOTixIFAOY+Ob7R6nQTFL3BYuVzgfK7xVITACsKsJneYDr3Sv4ob9E/2dUrnHmlKdKdU+hQbOb+gamNAU8k7Ywgs0uM91y1YE5N9KfdqB88WhvillS8bkSFYrXO7zwukdfSNerJ0bxcO0fhvMXNxNvgwcMZgR0MNG1DUSZm1IE/o8VSbywOezq0WzZoVd8aWExnaUlgTHZ/AKeElZFqjwJJA6OM/8NKtQRJEXA+v8jA09oZeMcBRgBgrn5sybcgM07x+KNP505eAEfrFXtx/xSxUIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Thu, 27 Aug
 2026 11:30:01 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Thu, 27 Aug 2026
 11:30:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 20:29:58 +0900
Message-Id: <DKZOWUNLUA0W.KLNJUG1EEN8Z@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 09/16] samples: rust: pci: specify base type for
 registers
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-9-3699a75fadf1@garyguo.net>
In-Reply-To: <20260819-typed_register-v3-9-3699a75fadf1@garyguo.net>
X-ClientProxiedBy: OS7PR01CA0095.jpnprd01.prod.outlook.com
 (2603:1096:604:256::15) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fafda31-0356-43d6-bec3-08df042e8863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|10070799003|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: pvIZMtlBIUnfPFr9Cv90C5fWTdB6UL317BsHTOxdB85a8XH9agNq3DlfTKFlk0dNrW0W+17/ksKzaIfWQOgIV19isek0DjHaCJhR8Nzb1UJDdA2x8ZrpUBBHa0cjQKdu5TQgGNssrmYjSWM+zmGplULilMNvGK0pmUwscL4GSIBnjzdfLPI8cTjjj0OR+T2QPXjmEpH8SOhubMcMv0gLkJ/3/g/CAwDl+jwdz03iPz9f2IEPgzU/5vYpXWIHzaREH+QsrBBjYmQvWpe9FU5dUF21yM/qv674JlyHBbWSi5OOMrzsbQaTUR6cMZ5Vy4SJUH578gv1aG2rqgFJ6Ht2+IDiXHTg+EK8SBHqNCXOWPwvteojQcnEWRKrttU+xEMAUesWUFhzpNdHRkfaZeo2WRK+lPZW568SVTphJyBeigr09Wu7gejrJjXFxmakhjRkfzMwSBJSsO8Y/vryhWCGVE+aUJevry/Vs7ryAMPDmwWlVk7MybVmSZOSd6LHdVbWM+C2Pc3UDNEQ8S68S5J71N6sthD3e9raijxXD/jGauK6LdKAXTyMyBvYtqiFdki6Rk3lPOU7Ek5nVtXupCnY54ketPpImABZgyBG6jOVT1iqa0JoqAlx0+fEbVwqs0tzBlYu3ZhOfFlgoBVmhiXenyiiMNHZvKwWKaJCkHY/08s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10070799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVlpNUJraTZ3bFVrbm94cVlDdE9tRFNNY1o2ZWRxUDkrQXdadnI0dm9xcVF5?=
 =?utf-8?B?R0RHdXpDaDFCR2F4dm9mSk1CREFZTkR0cHdwVjlKM0VPbmdDaG0rVW8zcVZ2?=
 =?utf-8?B?T1FDcTEySW5MTmluZ0xadU5hbU9SYTBHVTJGb05yNXl3dnpDNFM4K096VlZ0?=
 =?utf-8?B?SkU1cGtLOWlrbnpISitVdzVqSFBtdjhQWm4rRGZzYWIrdmgrL0ZFc0pOWmpV?=
 =?utf-8?B?MVdYVVB1Zy9PR2ZBVHdHMkloNmRPWVFEa2x3QjNKVVpaVWtQUldOU2VSTHRk?=
 =?utf-8?B?NXdodUswbFhxOWtxSWY2eHR4V3ZaVkF2ZW5sSUdJOEN2REl4NkswQ0I5TnN6?=
 =?utf-8?B?b3JwSTRmcTVYUCtwc2pYWHllSTAxZEpSTm9vYlVSK0lWT0IzSHZLOHFJWVky?=
 =?utf-8?B?RHQzbUtDNEVPejJYM090SHh3QjMyOHBQbzhSSndDY1kzQ2tweE9EbTVtVGpX?=
 =?utf-8?B?Nis2c2tZaFExbWZqVE9tS0pYbDZGMGgzellOeEtuLzk2c0ZTNVBmOHROcWhG?=
 =?utf-8?B?cU5Rc3pjZllzTHREa3o1alNoOGRDR1kxN1RzQkEwQjB5WERva1RndGx3Zk5L?=
 =?utf-8?B?bDBJd1JLN3dGODFUcVREMmczQ0dXYm9UUFlQdTJnS3ZzNFFIQnhrV29ua1dt?=
 =?utf-8?B?anIzc3lXdzVnTmlqNDUwZVBybHE4TXljMmt4Kzh3VzF1YmJJZHQ3NGpmTk43?=
 =?utf-8?B?cEUyblJ4Qm9XV3ZYN1R6NWNxdVpZMjNhTHBPWmhUVStUV2NxeUNZTGFsWDZ5?=
 =?utf-8?B?Z1JPRGE2elJtbnJjSUo2VVA1Tm96bWhBT3Y4bkxlYUx0N1lWbDRBZFpVMTBW?=
 =?utf-8?B?Wm5EUUhUQWxUenB1TDJ0NStBZ0tBempFMjNOMWZhZWhYczFNQUdnc0IvRXFr?=
 =?utf-8?B?NW1PVG1QUTNOTzJ0ZC8ra05YYVhzcllJNnVBTDh2eVZFTENkZzVOcWVzZUtD?=
 =?utf-8?B?dGcvbTV4Q0U4Q3BEWUNNaFMwYU9SUjdzUGlNY3ZOdTE5RXpZZjlGKzdNd0Q0?=
 =?utf-8?B?SE1yMzMxMURDNFZoTmFCdWNWTmM5Ums1ZjhCT0ZxWkxxMW9GVFdNZ2VUcUJq?=
 =?utf-8?B?OVI4SU4yWXdBOE4zdjN1L05uQ1ArSHdGYUQrU2piLzNwb1BKUGVoQzRSeUJW?=
 =?utf-8?B?UmhBdnlZbFVnUTc2OWFOZlFjOFlyRTdGR1htbHcwV1F3STNDdXZtMkhCcVN0?=
 =?utf-8?B?MzkxVUw3UlJLUThha2QySkRKYW01a1FFYUZma3FCMWErcDJBSDRpaTR4b01w?=
 =?utf-8?B?dHN5aGZDVlBZV0FqMnZMQ3hPWHc5VjBNNU85Z3hxekw5KzdFT1oycWtObGYw?=
 =?utf-8?B?U2Q3ZVhETnEzM0ZmMCtqQWhpTUQ5SjIrYnJVSGJMejJHbFVuOTNqZ0lCdzRo?=
 =?utf-8?B?UVFJcjJrd0h0RXVrZHp4QUVENXRmdUxQVmE0azdVZGd4bGhtN0txR1NMS0Z4?=
 =?utf-8?B?Wm1iVHl2bGREaUpuaEZnWm40dmRrOFNDZzNabjFSaXF4Z2lVc055bG51R21R?=
 =?utf-8?B?RzFoRnZjWXBDUGtzZlhlbVk3cmZnU01VNklRcmZLUHBZRTFla05HZGtyMGlM?=
 =?utf-8?B?M3EwSWcwQTNiR3ludzFSQVFTYW5XV1hOUE1VcGNoNzBoR2JLTnk1UHVSUDkz?=
 =?utf-8?B?NGhvRzhMWVdsYXozWk5UY3I0elNDYXB6RlBhTForUjVlZllib0Z6UkF6ZldS?=
 =?utf-8?B?dWhqRko3bXlOdGkyTE5pcElQVnVoZm1PSjVlMExZVlVaRVZaWjJFbzd1R1NS?=
 =?utf-8?B?UHNBS0tJamdYS3dTQUMxUW04RTZYdFpUVGdLemV0Y2VKUXUzR2ZNR09ybElO?=
 =?utf-8?B?U2JWSDBtMlV3ekxiUUJ1NGZQTlo0MVh2bGdacFFmcVphdFE5NXFPZWtGTWZj?=
 =?utf-8?B?RkM3ZXd0S2w2S0pIOHUvOTJJLzBseTNJdHNZR1c5YzFXYU1XTHhMS0I5ellZ?=
 =?utf-8?B?bVpPSDh4SHZhTFBoK09rYStBRUxHNkhLMkpoNzlmSHQxdzE3TW5Bd3R6am05?=
 =?utf-8?B?cVZSbkJRcTRTMmFPMXBPUU9ZUkJac1Y2angzRTIydVFrd09ac1FtQTZQV0Uz?=
 =?utf-8?B?MnlEMnh2SGlpQTY0QzhJM1ltMXJGZzE3MVJGMU1BaDJveWRENnUvbm4rKzA3?=
 =?utf-8?B?MG9zZFd2cXNObm5zR3k3UEdCR1krdzY0eVppN1ljTlc5L3l2WDZRTllMRlBa?=
 =?utf-8?B?RkVGUzFneDBXZVlaYVlod0VXRzREVE1HaDNwK1dFWGJZZEhSRWtZa012NHR4?=
 =?utf-8?B?RnJHVGhhV2dLbUtySDk3MWExY3V6YnZJSXlXdkFBMjJxNmhHQ2h3bFBVNU83?=
 =?utf-8?B?Qmk4TDV5VEd3MFhUbW44ZEJ2cythWGpBR1ovUHBPTDdHSDBHZmlsSGxJQ2NW?=
 =?utf-8?Q?S6e1NTIHR7zZR2KxTcsUMHVBkGj/fhO/oPrKXyai1v9sS?=
X-MS-Exchange-AntiSpam-MessageData-1: CCi9kHV7OdYjRQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fafda31-0356-43d6-bec3-08df042e8863
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 11:30:01.6131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JDt7C3Ntsgj2aMlAx0fespMTSqH23dn8VnR6xHy0xD1k+aRu6y+dMX3cltPT0iBkW99DPkrK0xpZmtT8YQhtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301
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

On Wed Aug 19, 2026 at 8:09 PM JST, Gary Guo wrote:
> The `register!` macro is going to require explicit base type, specify it
> for both `register!` usages in PCI sample driver.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
