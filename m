Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42ABDFEEF49
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 14:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A86B010E41E;
	Tue,  7 Apr 2026 14:11:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="tcsIOc6I";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33F3410E418
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 14:11:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kK0+rzk/xQfCN803ZIPX8KsoH/OhwgAXNpt0fMYqYjX/JnC1ynztQ9qjHIIQI15bufjwEN5oXYibo/lFnBa+IH+y0ae2yZn6bTAqtQtfA5EtAJ7JQ4uXj8U7hofpGKzFGn2oF1MsAMmOtbl0Sm1uZewVfaEkT0/AzCHJVBzL+B0uWyckEOfTaYU3U/5x6H2MzZ17FdeALZC0cV5Ulm6v7NgHZaXs7ARX7x9yBkVvw1yACYB2cNs8jZqA++k/lidZTx3kedaSX11joH7pNXpRRhegQQ+8K3Kmi2woiq+7HC04272ZQxmM3cQq1FJKf0iD8HSnfyNRxAB1vrM70gh5SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7H+aGt4botVa3Js9yrkdy7kMbr/csLAozZKbS1KYwoQ=;
 b=Po72b4xe5AoeeFstZ0EYlb0l5IbpVRWvNc2J84v+yLnONYw/MqeLnGAUlGYiSzfYk5+H0Ipu88jgcGiYDkSxWsMm4IB/jdfrvzHfxIlc4tV5JnrPJjnANx0C8Ja1QHHBzs8wb0az4uqOezk4HmbFfCTzYsVU+SGjfa90vxPaS1vMTh/o6pi6LdHC/ZOb3GGTmQjdIhIvJMeb+QD5GqdxwUuDYZVVFEWMrDXqtRG87HomaMn107cCXVKvIFevMtfsrNGipHBFIOZkQlwE0XHrO5Sv6FrhogTtTi9/4S+IPGBHjY3IpOhG3ZvgYbXdX2us3tQIXWS/Zm/scKCdl4hw4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7H+aGt4botVa3Js9yrkdy7kMbr/csLAozZKbS1KYwoQ=;
 b=tcsIOc6IjpDi1KGaAs4ftzkkMuinOe7PRgNLO/2agP87fMb7rRHd+mOFlB6h+0rir9jkiHVIrLpXM89xVmGVJ/Nnu57MFEkYl9WE3Pl5vJQOmExqOsVwihafc6RvlEO85ljUVvaUKRmakK0Qum5nd+f1+Em+Pn3qrtyxUag4IMCz5yt5StnahcvxAgB2h0c5T/Ud+SfR3tNFA8r9jHwjffcUneyTxFcNq80Lxxwr+MLve2XTleOEC/kNLzavhK155KhsQqKPJTP+yLIi9AQzJjNq+cWs1zGYS3NLYw16gL4adIenWgEh/pCWZ69Kj+1JPEt+FMLmyQDTWk+Pgfx/DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH7PR12MB8825.namprd12.prod.outlook.com (2603:10b6:510:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 14:11:16 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9769.014; Tue, 7 Apr 2026
 14:11:16 +0000
Message-ID: <bec38992-ad0c-4f9b-aa15-5487db92f4b8@nvidia.com>
Date: Tue, 7 Apr 2026 10:11:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gpu: nova: require little endian
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260407-fix-kconfig-v2-1-6b4fb06c690c@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260407-fix-kconfig-v2-1-6b4fb06c690c@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR13CA0052.namprd13.prod.outlook.com
 (2603:10b6:930:11::34) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH7PR12MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: e0633920-d1b7-4a61-cc2c-08de94af87ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 2wxSmeEsyoqF97hbodXZBH/LMCK47gUsiKHyM9QyFVOVzzxpce+uT+jb88U/hg8rrCwqgMj3gopgc2IaJwU9BmW/Hab1nMs4m/JLYtrsT83ipO8hU2PoPv4YGI16nc0GWgRuMQjd7GYijmQleY8wydNMftiQ0b/i64iJ9V9ijdImjp5WYUd4NlgJTs63BnSYcUMY8MRxK0xGn4y/SuSBrH+V4D+OKyEJPUfvVAvCc3TaQjztBBm57x7Cf28dHKZbWaby2407DcDClDGZKiHQjvKK85pztil33Z+nMP+jgDN/E4ULzjq/6s/rYnQK8E//sWycdZixAH0VvtL/DkynoqachgA/uXIP05K45DuVqIZfpiZoj1RFMFOUgFuBFd1NnhN3efRJpfKT8I/U3mlofLMv/3WRnyhs5kxdtHdCW8yVtBBbAdeIEProBk1WsFqY7ex3wl9RjUeGtBMLp1qC1hR1TQzifiBL3vmERAWHA+ntOi1IKDXBVa6fzuApHYwcE/0VVIa9FwghVe4TpbluCzP1NYJbH8VJl9m0Xbbhr3zm+sb210GGPJja1kEFaHQ5Me4ahpkX1z6VDere/s1bv1xXDTXL11DQOHJcL551UoD/wGdOJ4IWMb2A2tPwmtjxLktiVXVfBLAc5qwXRFUkqPOCDUW+vbGMxaHOspEBon+ObfZzUu/Il8mjSh5T/qFVrfEOUWa6FMN2Vnz/gfOgbOSSTIXMbnARVsQeeFOKij0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmxBSGRWUi9yNENMMzN1MEtRT05JOWdXb3dZOEJMcGM5RVliQ2hUOVpQd01n?=
 =?utf-8?B?VVVhWHU5OTBCNTFySkhWK05OcksvNTRaWEFSZ09kTkZmTmN4MTNiL3A0YTJw?=
 =?utf-8?B?L3hoaUxkVWp6bUJaNUs4NkFNaE1sZDFCQjB4Mk40dll5cE01WnlKdEJQSnJB?=
 =?utf-8?B?bTU2MkVGRkxxYUhKWWZHVGViSFNqV1V3Z0lXRkhpTmc3RnVOMXFVOVVqYkoz?=
 =?utf-8?B?UDdxSTRmUGtGblB1WWtXKzQveW9pSEZSWjJXd1R3TUJoa2VXV0xhVWhsa2Jl?=
 =?utf-8?B?VjNsTTF3SVNGWk1STktFRlk4a0ZGczkyNHhhWXJGKzNWMmg2MEExL0xrWm5q?=
 =?utf-8?B?L1IvYnRQZ1BOV3V6cUkrMWxHdjhsV1FYZzd3RUM4M1JTbHMyWXNpY3p6MkZW?=
 =?utf-8?B?TmFjZ29PbFdtN0c5RTNKa1FTOFNmL3dvUk5zU0x0OWRpR2NRaXNuVENLRFVy?=
 =?utf-8?B?eU1XVEpiK3I5a0tCL0VjK21mRWpkN0dGUlMzcXl1d0IwcXNTdDVBNUF1NWdL?=
 =?utf-8?B?bEk3QW4zYkdwTnFBT3Vvc3hmc1grN2lvUnQwNXFvRkFZMVAzdXhrSDh2UjVC?=
 =?utf-8?B?TW5BOWpXT0E2MkVOTXVGSWJNclFSQ2hYOURzVk41MGlpMnpmNDdqenN5V3JH?=
 =?utf-8?B?aGU1R0NIOGwxQUx4N01IWWpuRFQ1L0xqc1I4NVdvazJWVk1PdFdwbUFoajli?=
 =?utf-8?B?MWhmdUFBemZiNitoakJKUTIzckRnRUtPdThMSXBFdHVMNWRzNnM1ZHdlTjdy?=
 =?utf-8?B?bk1TL3RMT0dIUXkva0tuanpMRnM2eWF3aU5STHFTVjRMci8ranF4c2I4RExY?=
 =?utf-8?B?dEpiVktuOWsrOTNpY045bUgrWWk1N0R4Szc1Njd1N0c4R2xHVzJBbUMvbGJ1?=
 =?utf-8?B?TVVEUFJiYmZZT2NMcG9hYnRLbWpHd0FXdXBpMEQrbitON0xpc1U2WkswOXpZ?=
 =?utf-8?B?L2VOWDltMzZvNFd4dmxuZk1mVytDRUZYZnlhaG14MkwyVFViZENBWUYxTjlz?=
 =?utf-8?B?ZEFVbzZDUUMwVW9iWGliK2cwUmcrdCswOUYzYkdFdG5nQVdKZVhFQmhTYVZl?=
 =?utf-8?B?TXI4VUJaWTQ0ZU5yaWdoT21uQnc4Sm0xcGp1aUNzMlo4MnExRUszZ0lDZ0d2?=
 =?utf-8?B?a3cvNWNtd1p4ZFhsN3J1QTQyYm9Oak1yNVo4TkVkL2pTVkZ5Rlh4eFVyMUdw?=
 =?utf-8?B?MlBxaC9xeTlFeXpMdFE1Vmc0Y0xrVVFldGNDMHVLSm1BODFaWGtDR2I1eEtK?=
 =?utf-8?B?ZTZDZUNVdVdhUGpRYm8zSnFyTythOFdjV2NUMXcyK2JLVlYwN3pqV2tqNzF1?=
 =?utf-8?B?Q1RuN2wyd2I5bndCZzUyeHBLeFVQVGJQR21lTU11Y0VUdWdsVHVocWZPTldR?=
 =?utf-8?B?Ym9xN29iUHdsVUVtWWJXdEFZeS95bVM5TDJBNlRlSmpxU25xaCt4NnBiVWVN?=
 =?utf-8?B?SDQwY2RERkliVFlpWkJ2SmxENWxBOFc2Vjk1Q05qM1htNEdhZ3VpQmN1UG00?=
 =?utf-8?B?Z2oxMTlSRGZuQXk4N3ZaTDk3bTRjYldGQTBieDlXVU9sRExyUzZXVE9hY092?=
 =?utf-8?B?UDl2bEduVitsN0FoYlZid0Njd3QxTVlEeU10cGlvbUl6d2ZrOTZrSXlwOFUr?=
 =?utf-8?B?RjgvUC9iTW9JL3YzQTJLM0JZZk4va2hFOEpVNnpOeDVsMmk5Rk5rZGh3Mm84?=
 =?utf-8?B?cW51QzQ3Tmpielh4WVlxanVDYjR3eGZRa2krVUhGR3BNKzdVbm01MHE5S3pP?=
 =?utf-8?B?WDVjamZaeWR1WG8zL3VFeFZJbWhDM3VjSERSOFhyTjhKamxQc2drQytqZlc1?=
 =?utf-8?B?cFl5U0ZlR1k4ZUxOMWZPL2dsdmZySVBsTFltNWY0RHpuakFwbmR3NmF5SGF2?=
 =?utf-8?B?bjh1VE5CV1laMUkxNm1zRXZkd1lCMXhOSDZmWEdNUFNCdEtVckpOcTg5ZEkv?=
 =?utf-8?B?T1VzYVdHNmRTYzlzbTVnMlppSmN5eUVFeHZFVFB2eCtqajl0VG13YzdoSnl6?=
 =?utf-8?B?a2ZkZUR3dmMrVTJtcy9zbUp4eEh0bkZsWjhtYUh1OFQreXNMaEY0YnpsU3hQ?=
 =?utf-8?B?eEVoc0xFR1VrSzNOOEx1NmcwaWNoTjlOTHVwOVJVa2djVWlsZlpqNWRUT29V?=
 =?utf-8?B?blN1bUdMRzJyMG5FMFVnSUR5V2JmQndjekR4TVRXQXd5Y2ZDMm5zd0ZwNkFn?=
 =?utf-8?B?ekN4d1YxVGlHcUdSOWVKWXdEb2s4VHpqRzQ3dlFFdDBVV0FoTmN6STJEcDNC?=
 =?utf-8?B?bXNPbWxJWGlyREV0UGhsOTQyNEF1MFRsd0dXU0VEOGhDay8yQXRIRks0Wmti?=
 =?utf-8?B?UmQ1OFIvR3RjT2k0eW5DajM5dm05b203N3IwY2VLSG1EbEdCZnFDZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0633920-d1b7-4a61-cc2c-08de94af87ec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 14:11:15.9455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMdiVJiH/dVniVqA/8uFcIGyiq8d2a3b2oXbHkQktDcN4B7JTQfrCOeMkNOvRSATsXihG9yU/BtA+JotuUVGYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8825
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



On 4/6/2026 11:59 PM, Eliot Courtney wrote:
> The driver already assumes little endian in a lot of locations. For
> example, all the code that reads RPCs out of the command queue just
> directly interprets the bytes.
> 
> Make this explicit in Kconfig.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks,

--
Joel Fernandes

