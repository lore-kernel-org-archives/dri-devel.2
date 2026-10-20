Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41F5606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=actdtqiT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4802B10F3F3;
	Tue, 20 Oct 2026 11:43:40 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4C9A10F3F3;
 Tue, 20 Oct 2026 11:43:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=roabGKCxbrIC89qlfp5+HTVi1mDUstmDjrEHM4E89gUW1Uq87czTBzimQQI/bdaJ6Uiu6TMnQ/MQi+sxXQo3LkQ3e5z5C+3L+aVkL3ctQBzCZKBmGTXrwx/TU9II5s1RNaNkX5/uHfN8bw0Oj/OAW2aFO6+eMNpnPJ8IcblPQS5jvpbrUP7Z6YDWntof8T4jy/jO5FL+tr5Z3W1OzRRbCdSRkFLgzwXL/3f70pbda3OrK4UxWBmpDEKvNk44/deT88GJCprE/hFk8X4WN2KdueK6qv6r3bDg+Oa+kSVboBCPRaUUqb1qqAVe91IE4AYRl00qduYgymf3BhKLtHFqqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwZpjP4sN9Z4WLBpIqoGyYYkKT7FrXM2qtdyxxBgkd4=;
 b=Aey6hxtj6SZqwHattOMyTjFNJPtLYz8jFKDdi3lXvzByG+VPweFQ3voe0bVjRh6qZSC7g63qrpZJWlgSe1+kVT4T/XidoFxWV98E6OuzU2bLNSos47UecDhbA3cqyGpnWs1Yxlu26qjLqiuzEG+bJVlXEeXEaw8HQsaeD4KOD+XKykPNFgUrFakzT0vqPtERRkt1sb05ZZP1Ki1YbQVXR74IOZLckZxFR+ZJQ98W7dhWfjTlpIOyLccQ2/mTRV2u7oqeMGJdwsHtwRZ6A4QOEdkUEMSOMZC6MfQm2FrF2IpOpuazOtxFU32zVivXTC0evD800bdqn1rTUaEXi3QGxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwZpjP4sN9Z4WLBpIqoGyYYkKT7FrXM2qtdyxxBgkd4=;
 b=actdtqiT3Ks4C7tybSyWsUjVs6d460ZLxFR4kBb1fj67vsYuUCMtrXC8e0Vl7nG26/fUYXodmAvLodKvBk/gKVs4RVA2HPPImJ6deC7UP0qq0aVurNb4F+auj6FjR9ir9gM0YbnZ4X4p2h4/PRvajx6UPOS9cMMuWz1blF4K3Uahi/BwzbvPrzQLGdzVW4M9kWdcvjZPs4t87WK7bKp+qZ2xQSp5TXbpisG6o/ddok7y/mGIEsusJYfmVSVZ5pwizmYeEXXmPJpuNrgImQfG8dSn60WEjgjku3cQPuH/wHbD+Jk0BOncVu/2MJRKu6aZJRvd+xQxJW2iLvmGKZTKGg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CH3PR12MB8725.namprd12.prod.outlook.com (2603:10b6:610:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 11:43:29 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 11:43:28 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 20:43:24 +0900
Message-Id: <DM9N0K8QZL1N.2QUORY1WPJXMU@nvidia.com>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 02/14] gpu: nova-core: gsp: cmdq: simplify framing
 error description
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
 <20261020-cmdq-rpc-v5-2-dceeb8f360ec@nvidia.com>
In-Reply-To: <20261020-cmdq-rpc-v5-2-dceeb8f360ec@nvidia.com>
X-ClientProxiedBy: TYCP286CA0057.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::20) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CH3PR12MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: 50fc9f6b-7ad4-486b-d1df-08df2e9f5bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|10070799003|1800799024|366016|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rbFTBMf/YmZ//0lfjxu+vuguxPB5ClCJYxj0h7lsAJDGcMzxdkDTMqRrlTHJ38pCnUfrdfSu9GNhrb8Vyrh5U9Gk2rULGSmPrKw3BqdtghtYMRL9XNzhf/Rt5drQ8gnomJDN9+wESyHSBlQwihokRHayYKc4rDN62Q5ikx7yDK1br5q9Smhbb6aNPy0SK0yx5YTUD1cpcQYICIGKiiSjZL+EEUjKhQTtmlbM94wQHcmgBtvvJxvSjeXxAuqlSwKOikrkgIhlIPRgi5UPqZMMfIdS7I+eEzuuL/yD5Gq0lPHEXI1pVu3usWBFbEpch1d8gX2QBX9aO4GaFsYO2pACnsElTRkqNVWZqBOOUv83CBpE/oWmsfJ1ZYl75oHNQs8MmjsVvIzrgkaQekmRSF+2L7jPZYtcyxnyN0Fhu/gV7SQDUoxFm9M+q9uwntZkzssBE+De27myurpY0OtXKv4I1RVH59um7OPamZJqENdmnUcH5Wer4gkwvm3eYVFiE0EB/bmNh590J7epkKTcvI0xFKDVFYwwD9vi4fsocGZqmzd9U2Pu2uz3tLV6biPQg1mUd9yMixY+MPFZr+c16jril6dAyocu5W9b85FaQvQt+wSSxM7n/8y2CLtPEcLF/PHDdWnep9cOeszaHRJdfoavNoMvHpUTf6NJENcCO5kYbgw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(10070799003)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzBCcDQ3MFJHcEZxenV3SDdGRU0vTlZkckZXNUw3RzR0N2xQb2lVNkIwSWZ3?=
 =?utf-8?B?ZlRwWTRha0hscGwyTS9QQ2dKdTFVMk5XcUtURHBNWFk0UzZ5aE4yYUk4Mldv?=
 =?utf-8?B?TXo5YnNLUFgweVMxVWhndUkvMjh4Tm40QjVRSVVHampkd0JnUWFUQ2pHNnhm?=
 =?utf-8?B?YW9Rb2NjREhXL215UUhOK0dhWjRiSXZra1c5V2kvQXFUeHRVS05SZFpGZHcx?=
 =?utf-8?B?RHorTVVKYTlOTVZXMmtaMTlWSkRsZ0s0L1JTUVNLdXFMaGlzTVlyZlB3bzEw?=
 =?utf-8?B?Vk5iQ2NGWEdzVWk0b3E1S2h6MXY2VU5BUDZZUjROdHRnOEZCSmhScG9kci8v?=
 =?utf-8?B?NXhBQVlxMy9CMnVKZUc3Q0VENURrTEFoMWJFYURPTkFRcWVQZ3lFeWdJd2Rs?=
 =?utf-8?B?WGJiSHhNS3ZjZFlMdlY1VUFUcGo3YjBUZm9pNmhQMGp6Wk1DMCt1QmEyOGFK?=
 =?utf-8?B?MGQyN2Z0MWxrSjNuWWlpRHZ6OFRka2krQzhNVitIU0xlajlWVVFBMnRJUmo4?=
 =?utf-8?B?dURlMGZMMEh1T244NlBRRUxxalh1V0I4bTBKTDV2MTFVeENEanc3UisrK3g2?=
 =?utf-8?B?SU5GT1diTHUzUHZaL1VPRE5MZERNYWxkOWVkQmxESlZrWmNmU2Q1cm1zS2R1?=
 =?utf-8?B?MlJGSmtRZlNFQnBnTEhYQUtpUEhyZDZrdWVQbVhXQ2dyRFB4OHRZbnk3ZWJC?=
 =?utf-8?B?bnN5QUxUWVhSWUtoOStYZnJWNlVMd1FYU0laYU1FTk1ZV0ZuVFRCajJwUTN6?=
 =?utf-8?B?R3Q1djZ2WHZOMjNSN1JLV3NFYlEzcjMrVWJWQkljVmNLUGNKek5JcjlSTld2?=
 =?utf-8?B?TjVjVlRvTlNzYUduSC9IbWdheTNEbjMzNmgxTEJUcjhXRnFGL3hFbWs1RU1X?=
 =?utf-8?B?a1RqZ2M4RkE0ODNuZ0c0QTNJemZOYUN2RFhvMVVxYU5HYmJFZlRXVFlrR1NL?=
 =?utf-8?B?RVhscU1nT3hVcTRpcXNQNStOZjFyR3hVZnFZbzF5RTZkckpoa215SkozRTI4?=
 =?utf-8?B?cTE2VHVLd2ltQUZwV0QwMElCeWRwWGY1aEVPelIwVUZlS2dTUGlNeU9RWUI4?=
 =?utf-8?B?ZTlKZSt0YVdrTkpnczZEeWhWK01hbnJCRXhFUmovRTU0ZUNPNjNzNGh5WjRC?=
 =?utf-8?B?SWY2dklVcEFhemV4a1FOUU5vZkxhVTY4Wmh0dUx5L1hUWklYbys0bUV5ZmJY?=
 =?utf-8?B?alBoVGF1OS82MkpScFBGaWx2alJKMTZ2RnE1bHY1UU9Vc1Jzd1I2MVQ0bVNI?=
 =?utf-8?B?Ymt6WjBISVlvRHpVNmxHMkFMUjRtTGtrMHBPYUt4WWc0dk9FL3NrUVRtL29D?=
 =?utf-8?B?dEpnRUthWDVCN2FOSEF6elR3eGxRMzJKbUI2SHQvZUN4cThSaGFYc0R1bHAv?=
 =?utf-8?B?bkVkNFJuQzBjQTNlbXRaMlN2QVVKNTVHZVllNHo4SFJPMVNDV0FMcTVHajJa?=
 =?utf-8?B?N3pCY3NPMEoxdXJGSXRlSzJtdk9sQjlxYWh3b2RreThmb3l1blBTbHU3ZmdC?=
 =?utf-8?B?Sk9ZSWhBV0xWVzc2KzExa3p2bTZwZXpRd0lIY3R6dkhNaWVhSDhlRkhZN0tL?=
 =?utf-8?B?M2JQWmh2Y29MeUNNb2w4a2tUdmhqanNMUFlGWEVpUlhMZ0JvdlhxZ0ErbmRi?=
 =?utf-8?B?S0NrcHczRnNpamF1WEl3MjVvdEpwTFJXb2NWZW1QVmovblhNTEE2LzkwK2lE?=
 =?utf-8?B?bmZON3Q1MWR5WnNhek1DYS90c01qeHZJbWdYemRxazhpeHY3ZjdFaUxrUExp?=
 =?utf-8?B?ZU5lKzFtSVFnSjBMNVdVeFd6MDEvMFU1VmFWRDIreHA0MzBiSWJDYVB6a21B?=
 =?utf-8?B?Rmp5VTVHd2x2MEFoQ0hmdjdaQkhyRWpHT2dVZ2tWZzUwZ0hMdEV4dWlQM1k1?=
 =?utf-8?B?Q0E5dWhrS0ExZlZ2TmtKVGFUQ2hTNUk3RERZSyt0azVxRVBNUFhzWll3RjFC?=
 =?utf-8?B?dVlZUDdaYjVWR1QrWGp1Nmw4dXg5d0RydTY2QTYrNDZJSXZIc1RUMGdjb1gy?=
 =?utf-8?B?UTBtaTFZbW8vbzBqMDNoKzg1alVMcUlvZGVJWGdZTk1kY0FCNWZJQ3RmUlFH?=
 =?utf-8?B?Y1pUSzNKdi9IM3ovUFpjUlltcTFlWnJMOWxJR2RZalRhU0l3dVpkMEVDQmtL?=
 =?utf-8?B?NkYzTjI1b0t6QTcxak9OeGFqb0UwUTlYOFVpVUU2WkxSZ3l4RE5OMzlQd0lZ?=
 =?utf-8?B?NjRYbHZ6MzlYUUJaeEFwUmphU21SV0tRT0ZWeitTcmVBRjQ0V1QzSkwyeG1H?=
 =?utf-8?B?bkdNSlNpLzJIYmIyaTY0L3A3YXZsbHlwQUl5STZVcHBQNE5STk00UUdaTFQ2?=
 =?utf-8?B?ZzNaaytDaWNNK1oyWGdoeUR2OWhZK3ozaElLNXo4R3o1TkFkellZQ2pqQ0Rp?=
 =?utf-8?Q?JEaxa9eDSxTAdQXv3TFuErWYE3dKFiNh6jMfV18m/LB6s?=
X-MS-Exchange-AntiSpam-MessageData-1: npHLDs9m6/fQUw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fc9f6b-7ad4-486b-d1df-08df2e9f5bcd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 11:43:28.5727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRzfigqtTsy5fbkXUsBigqcHQNmFJ0xua9nQn4yqU11tLA3+JQFzKTMOQDsodxR07jL0iEhrySXA2SmiqSTetA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8725
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Oct 20, 2026 at 7:08 PM JST, Alexandre Courbot wrote:
> Use simpler and more precise language to explain the conditions in which
> `EIO` is returned.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
