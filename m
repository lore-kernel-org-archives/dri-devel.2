Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19635606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 06:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Jy6wg5n4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 793B210EA7B;
	Mon, 26 Oct 2026 06:00:38 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010009.outbound.protection.outlook.com [52.101.56.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66AF810EA7B
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:00:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhUN0v2BnFyGN7oBsK8dyyCxSp8WdLZOuY1QVpvU/KLKI4fV16wm08HDKvW88sc+XskOj9RNSWAkd6zY7YLHg1rG76JCUQIvx2x77W3SN7IlyKwKrE+8NB4WxSQxebLl6T1yPc6fVOBXdr5FZEZ54+OqgmdhbhtTwp6UWo8NaE/ZXq9yOFY4DlN+bjESO9TrAimE5VrdXiGZpRGmSn4HNzZOnIz4xQ/TlcUo0hVh2qSAzBxlHINLQzcuM7LSIR/qvu7IWTktsEhhzwtcF/egpRzcVztC+yUhQcwXXKNC2p+L+/rJwRpArEAAJmBKg7sJYbc6E/xIn2UYgBxSnXV0kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdrVES6cBxCoVqfZygZv458YoGaZ2e1uGqDnKxdwVns=;
 b=BqVHekFs6LKBYTmJWTLx+K2qqM1oQ8C8XXtOuGEE/oSsgqCdaE3BKIoR//K7yVcPykUqpNicFeuD5MCcjgyx2sqT2YPWkBgfZi5rO3FW/isPPCw6X7e9iRgf/+Upj8RxNEgnPo4YVhaFtZXBM2C+kv4pqfqDWHNDDeDXqRGk3ecZQMIE3Kf02G/PXhPljDxLyF5P9jatxbNilfAQy/fwi8svfDeIQMAzfyhr/8eNXgWBtDn0/2eUFmEoiqUGz8aS9sSOoxHdt/jHkontMac+LrBMimGv/4tSxJTzgrVfR2O5U4PWDs++0xDaEX14BSd0GoJB2N5m7EFnkpkT7x9lVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdrVES6cBxCoVqfZygZv458YoGaZ2e1uGqDnKxdwVns=;
 b=Jy6wg5n44NwMrMnvKtpv/6Kga/825YjBDD3v1NT+m5e2a3r9sYSrZ60ZPC9Mx0jwzbgdGBw8LuDZMvUSRC4m0M/tAXRcUZnDOc3CWf4TSeNnG8qdHm3ffFQ5hpvRhyVcv6kjh0lWCjrIABAmrn5Bpu6a6pPUx9H7PQtlK5aZj+we1VzYNuELCdnNq01xsVtVK7w5biZSKEprkBvFoMKQmzl+De6PmR7Bsm+kU1W7b6HsLB4VbUfcvEQiW3hq8JFhDpefF5CXcMBQhR+O5G46C9YiGyNSuXjUJJhGkm51x0lep3HnTMhGw/mu/fSyUlcJ9LLokBv2Olr9Rv6R81PFDg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SJ2PR12MB7962.namprd12.prod.outlook.com (2603:10b6:a03:4c2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 06:00:26 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 06:00:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Oct 2026 15:00:22 +0900
Message-Id: <DMEJH6QMN46I.20QLHRHQWR32P@nvidia.com>
Subject: Re: [PATCH v4 3/7] gpu: nova-core: add NVKV encoder
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
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
References: <20261016-b4-nvkv-v4-0-e8b92b91aa5b@nvidia.com>
 <20261016-b4-nvkv-v4-3-e8b92b91aa5b@nvidia.com>
In-Reply-To: <20261016-b4-nvkv-v4-3-e8b92b91aa5b@nvidia.com>
X-ClientProxiedBy: TYCP286CA0291.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::13) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SJ2PR12MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b6df98-2971-446e-45ad-08df33266dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|10070799003|366016|1800799024|7416014|261021121427099003|261022105027099003|261021135927099003|10067099003|56012099006|3023799007|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: aRl4rHRDdV7GhuKBrPlNwz4keLH5dCs2igaAoeuMZqd/w/Y48+J22974zuFh3ocGk7siUN1Zs2qlloJvnYcNSVkiH1axJe+4u4C1aB/Dg5z8uLSwhEbuoTcE+CDlikWvpr8QDDsOYy8Ax3a4y4Zh44JxfEz67o+rpJY9OPT0H3TW93cNwdphSVTIS8RS1QkWNwYDyvNI8mISzP67uDjfhgDx6ZGNI3CDyEcKH8BVQZMm5g8v8rvIgs8wwmZCJbLcu0pETzkqCgqmqJqQBU1GEvpK7BNPmAVKC/kWb3ImxIta3SK/GBmdgMzaojc5t2Opu+RXsd4+0/cOFLC/PDAlLCT1raVum535i+8+KhyjrdK9SApm277dpyPovEptI2VdHtgwttL6LeU8r5XVlcaLbf4/2wIiBKxDnCMUO6fYhGCGsR94TZJo/sphPDfueGDkVgIlW1KOqX9azdCRareGd9lxc4JuUN1TX48AS0ybHqlKTA+sW3u6l61kvwV8l0+g2Hw9+grW1fKg3mfmP5GhbK5iQb3D03ZQ3O3YCwRMe84G1sAt0hR5ytEUZ8n4NXA68Xpv1+RPrmTIfZWicPXogF5wSwZ3f1oMcOYvTDaZipS7B40fe6dC4Nw44qiUplolYl4QVvzkpHSICYnmAmCYsalp5jrBz9SgAKa6sAQ5Wng=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(10070799003)(366016)(1800799024)(7416014)(261021121427099003)(261022105027099003)(261021135927099003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGs5aTYvZjdZUnk0alJvNStwVk4xYlRmN2o3a0Rjczd4R0Zlck9BaDlrUm9V?=
 =?utf-8?B?WWtsb2RHaFh4dDQ3U1BCNzJKWVRPVFFQOHRTZWNVT3dPOC83a3VYdm5nZncv?=
 =?utf-8?B?YVBkM25FbDlPRWFhN1FjUVZhOGRURnZvUyt3WHZxTVVaQlFNelk2d2VoVDJw?=
 =?utf-8?B?VHo4b0ZRR2M2eVQyaGQ1SUdISTNIMnpybkpibGpvVlFjdTJGamhETEZIcWVy?=
 =?utf-8?B?VHVkY1pUc05TbVhVa2lUZ1hha2wyaW10aGdvcG90SXFZeXVsRE1hczRyOEFJ?=
 =?utf-8?B?WjVmdS90aWQxQVJJUFF1Y2xGbjlCeDMzVmVRdHBUNmNEU3BreWdjM1oycGFr?=
 =?utf-8?B?c3BGdE56aHBxVXNZcmQxZFVZeTVrV2JjVFRPcTMyU2VlQzROdktwSkRCMnRL?=
 =?utf-8?B?cGRxUUVHdWJKMkRQMzRiWjZRR0J4dk01RDRDbWo5ZFBEK3RjZndjaWZJcVZY?=
 =?utf-8?B?cmcyelNpZGNTSGlpMVRsNW1wSEtxeVN5a0x3Y1ExVVdwY2VLVm9Mdkl3NGEy?=
 =?utf-8?B?Z0o2V1RSR0gyR3VhTUh0ZkIwN0pRYlNqSFdRdVN1b3l3Y042aW8zT3Jtb3ZV?=
 =?utf-8?B?VGFXVVgwYnZHak9jcldRWjM0N1Y2WUl2Z1ArMHliVzFRY3h4OXAxOW9sRGRH?=
 =?utf-8?B?Nkk5cEM0VkJZbkVXRWVwaG1QMXdDVHVuVTUzcW1UcGh4R3ZlU2JLZUdmZ09p?=
 =?utf-8?B?NTNxR2l2MjF3YXFuakVkbmVSRUcvcTdIcnRMN0JMQXdHOUNNRjVPbmFQZkhj?=
 =?utf-8?B?ODY4cUxHdVVaVG1rN29ZOGVPQmNKVFlIRWpsZkhOU3c4N0dZZEZ6ZlhYRm9U?=
 =?utf-8?B?NGNLV3BUMFBaUU9aY3doNGtjaExpeE5hZStxdWQzd28vNkVvVjVoUmNaSEpq?=
 =?utf-8?B?OHhLYzBNZjQ1dEwyRjZFVTdTN1J1R1lHQnRnZ1BzeElOZHdQMURKQWZCOVZV?=
 =?utf-8?B?eDRJYzVPMVRkNkJzamd1aDQydy9TcXVmM2FHdHc5dDMwNHVXNFo5NG16SEpM?=
 =?utf-8?B?c29kTXptc2l1cTFvK1cycWdQUkkvMzVNSGhJNEJzcGVMOFNBaGNtZWJJb2li?=
 =?utf-8?B?OVFmVmEzc0p0QXhUVEpNUVQ3SGVtYnNsWnBtYWt0SHM1RDYyQmliZXcvd2lK?=
 =?utf-8?B?THdycHlabk1zS0Y5ZmVVWE9XR0M0NXBybjhOVFJCbVdJM1JJNHJiemhMc1V1?=
 =?utf-8?B?QXpqN3A5VTgwZGprTlBnZHhZcFN4UDMvR0gvcWs4aUZPTDl2OUZqdmUxUGtF?=
 =?utf-8?B?M1ZZdXJCWHJ4SUZFKzRVc3UwVEhLRXgxN3o5ajhyVVlnVHZPRGN4czMxY1hK?=
 =?utf-8?B?cXpQeWZ2YU5nMGxzd0tIWEl2NHRaS1A2K01GT05LblhlTUdUclJsb1JIWGlr?=
 =?utf-8?B?Z0g5RjRnWkZQSEd4QnBpdW9ranFmNDBIZUF1R09TcE4vZ2JVSTYvcFM3dWhD?=
 =?utf-8?B?TTA1WUdFUlpWVmlRNVlVM1BoUnVlNDd5Z0lVejhwWitMT1RMaFRGQUJhRm9I?=
 =?utf-8?B?QTV1czRKN1BST1ljYUZMNFpKNWhxR2F6YWVjZ01iV2hPbDhCcTMxQ2JMeFF1?=
 =?utf-8?B?LytDL0FZTDBSczJUcVlWMWJzMllXZTBKZklFUTFjeC80Y21hVm55ZnBhZWdt?=
 =?utf-8?B?b3czdnpOQWxzKzlYUUpqMzQ5UUpsZXV6c2pkdisyYnM4bVV1ODlwNW05Zld6?=
 =?utf-8?B?b3NxVHZ6VGQ4SEt5R1VVZ3dhNFpGcW9MSmpENXBkOFUyanQ0VDFHMmcwQ0hQ?=
 =?utf-8?B?dUlsZFVLMU1hdnpQeVUzSjBzOUpra0tqcnp5NjB1K0FlWmZGUjJRWGdONVNT?=
 =?utf-8?B?eUFueHIrZGYxZXFVc0lEaWlDaVdTZ1BhM0w3RSt6WHFibitqS2lpY2h1azhE?=
 =?utf-8?B?WndKOGZPYXdHaDBFV0ZnRTkzOTlJSEw4TWs1cUZzamwwblVmVWF0cHREeHJJ?=
 =?utf-8?B?K21hTlJIQ28ySXg0V1E3TklSellwSy9WVUFaM3R2a0JpTjhYbjlEMFhtMzRY?=
 =?utf-8?B?Q2ZLMTFMQktxbStwWld4cVcydjg0SE14WSsyS2ZCTC9LTFJ3VjVMc09rK25W?=
 =?utf-8?B?c3dXb05sT3cvUFNYMHJzZGFJOXlYNUJFb2tXdFV5Qm8weFptTTBzQWtLMXYv?=
 =?utf-8?B?WGZhWUJRa2U0emsrZU9WS3Vyam85RndSSlArMS9YQVhBZmRWa0lLQW1ZYTVk?=
 =?utf-8?B?ZDB5Z1hVTzFRLzNxQzFKaUZDRlV2Si93NUFGMW1zRDJoeXU4SFp4bWUxSVEr?=
 =?utf-8?B?ZlZwaGRzTXZhRzllbkZRSGkzVzFveUIrKzlWMVMzME4rTThCazhreVR4ekh5?=
 =?utf-8?B?QnVwZXh1SWhoYUxwSUlNNlJ4RGZ0Rm5ZOWNKU3F2TDNuMlpVSDcyb2NHZENu?=
 =?utf-8?Q?voKungBSI3kNqQ1tbUAIvxlBhe19v31iVwT/HX+BbMAge?=
X-MS-Exchange-AntiSpam-MessageData-1: 9y+9/5ps5/idFw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b6df98-2971-446e-45ad-08df33266dd6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 06:00:25.5964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: US+PGK64IpDKq37EF3VAC4TSylQciFe8FbFaw/G4hzZvcLaa8KuXCWPkX4a9f5zNiUnDuXqeS7DIvXp72/G6ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7962
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Oct 16, 2026 at 10:53 AM JST, Eliot Courtney wrote:
> +    /// Encodes a 64-bit value as a single-element SEQ64 pair.
> +    pub(crate) fn encode_u64(&mut self, key: KeyId, index: Index, value:=
 u64) -> Result {
> +        // TODO: Consider automatically merging sequential keys.
> +        const KEY_COUNT: u32 =3D 1;
> +        self.encode_op(
> +            Op::zeroed()
> +                .with_key(key)
> +                .with_index(index)
> +                .with_opcode(Opcode::Seq64)
> +                .with_value(KEY_COUNT),
> +        )?;
> +        self.stream.push_u64(value)

Only noticed now that if `push_u64` fails, the encoded op remains on the
stream without its expected payload. It's not a problem at the moment
because an error here is a global failure, but it would be nice to see
if this cannot be made more atomic by tweaking `EncodedStream` a bit
(same for all the `encode_array` methods below).
