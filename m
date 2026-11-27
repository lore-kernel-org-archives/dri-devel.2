Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64167606A32E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 04:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=I5PHY/bI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C503F10E02B;
	Fri, 27 Nov 2026 04:00:27 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013007.outbound.protection.outlook.com
 [40.93.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43BB210E02B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 04:00:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqIRq3Bv/fDvP0+eHTFt2CsCO2kQUr3b69KzJaprGiLKJmiq+hhlBEwp66qyhCxkyOQlNMEMxWkereR4Zznb47bxaBlFbnWXVREaOL5MSAZNQZYI0yBr3vKUkmUGtVSquN3kjXfEu6g0ru9K0y8xJu/v9ZUWNu7oF3HbyGDtUwYjPk+MXaT3dEGzdeW62cefr5TeSE3psZsC4qUrZqd79HgXOFClQX0ekNqevovLgY0IyS4nEPMuXw4tVkWSQ7Cv9pUzB2Ewz9vaKfUzpNL74XYc9XV4OIbT5aY4qPEth7wzk15tL28fqWJmQYlNaz2jK7+8CHqB99mckEplEnYLoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qx60QzUrsxmk16R0DxZfMDH0/bhpLa+kNt3lA79+Xo0=;
 b=cZ/sAJobCHzNT8MMvJ3gllx0DvMARrfgrGYA95dBXKFaeagATzbqpRktWGWPyTmIjZfkNY0SQCxyLSqTFPv45i5Vwj6Y7I7jPUjQfMLIzQxQGf+Lbl+MtfZo4iHoJtGg4ceW6GhjORl077BUAeyyNB+FZ5prp79OJgjA2W8QcJeztw8F/owjJxI/1Tse9kyJCOYLEJcuASg4usA9SPRXZXiNDUgKZPux2MCbyp1Yif6iOu6hREMjiwv46qM+17wnMAceD+ZcJsaUVgV/waxqQex4ML4vttwXIdFMjHWOMXVfg3hlh/JzTrPTxU8+nmyW9j7VK/LQSDwB/GjZWcEf9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx60QzUrsxmk16R0DxZfMDH0/bhpLa+kNt3lA79+Xo0=;
 b=I5PHY/bIFbwy+hTC3YokrOwFVKYtQu+0RnKOIDfoLFLEt1l5f1M5LPnvlkrllctQzbKYRpH6+bB4zUCVqMSk3lWY3RIw3Qr1vDyy/0WRVDN8V7IA8vfBPNqTx0qYNBcYRj0djy+rSg85mHq1t71QsKKcB6h/qN1wnMVL2hMG0m36dVnyItGV4z3MByu3d6mGZA72G3tNOc2WHtJ5tykIYwXtfaK3JM/yK9y/xMHT8Afqt384mfHkM8ELHs1rfkM3ywRH9VAU81/a5n4ko8rwMjlH7BxVxwhH0vMJF340x8R8ZO5KrbkJRgWWbxy2NULFhG/UkrpFdSQ4XOzuEhd1jQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM3PR12MB9415.namprd12.prod.outlook.com (2603:10b6:8:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 04:00:17 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0662.001; Fri, 27 Nov 2026
 04:00:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 13:00:14 +0900
Message-Id: <DN5OYMKPCP2N.1PZRAMK80MVJD@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] gpu: nova-core: gsp: remove unnecessary start of
 `gsp_falcon`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20261126-boot-rework2-v1-0-99a1dc6c7cc4@nvidia.com>
 <20261126-boot-rework2-v1-2-99a1dc6c7cc4@nvidia.com>
In-Reply-To: <20261126-boot-rework2-v1-2-99a1dc6c7cc4@nvidia.com>
X-ClientProxiedBy: TY4P286CA0131.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM3PR12MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: 4992f486-5d51-4cfa-c5b5-08df4c3af25b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|10070799003|1800799024|261021121427099003|261102123227099003|5023799004|56012099006|11063799006|10067099003|261021135927099003|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: x/06JQ3Wq0XtYWJNw6casDo+mgzQDvTwGYPLJz2M5vOool04dskdabNSbt4vYisR1CmNkTG5dANEz/IRP1KrTf3CtL0S4hfPlZ+8AVci+HohbsXtDJdAMdPThFniOXG9ZPvf77Yat1eLewAKMNoXeBtf1t6cQTK0rH+PWXRDD6kyuEEk9SBNMPu+RO4KOVEun6qGDMzv5Z9TJ7i0y/ZBaSAPuwUuXXkCxh5jfKe5jgvyLRs24I58EpUV6AUqsjDlitJ2vr9qKEamh3qpAncPZHb/I1Z39FLATOT2zZT1T6jBQfoJZEj++zUsDeQ00Hn2OLSumZdF8kxR5PB3XGCf5yY+XQfuCHqdxdGAMOgPf2fy4KDv5K4s9a0lZ1NrkfkwwwuLkkihzcgnYuB7Qo8hCjWzrYBL81fkP6tOHuU05701OQSfEt8ScIZq3VCsNBBGZJliyE+TcsQerHmiTFTVYNmDCEOUtMByrvbsYZ+7Synf2TatuvCv383mI8MTZcaeqRjwUzUHbsjJ9JfklIkcfxJ/VtkF/yL36nDcIrDx6sxjfJ11IVNCF5IWD9MVOpdtOpZ0xC3kmlFiiwY0NOy7xUCc/lBH1iA67SbXX3q5k1WTBdGM5/184mAl3GF28VU19PBmgjkpYGWVGYf+p4wldE3t7lBceLwViupiqz8aQWA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(10070799003)(1800799024)(261021121427099003)(261102123227099003)(5023799004)(56012099006)(11063799006)(10067099003)(261021135927099003)(18002099003)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWgwajZNN0x4ZHhyWHFuTUNuQmlJak5qeWIxRStFUml1c21BdTdaNTV2NGsx?=
 =?utf-8?B?cnBMdUtkMFZYR21LTTlTSk00ZjRqcW5PUkR0V0dtVzBEUzU2dUxzNk8xMHBF?=
 =?utf-8?B?cXk0Rm1CVDY2Qno2RzZEZVByUkdMZzVGVk9MOHdCWm50RUpZLzNnUkptTkh2?=
 =?utf-8?B?YzhBc1hTSjFmNTUzNE5uRWg3RzFhS0NZR245QUZDRnRIS292S3RIelRjWDlL?=
 =?utf-8?B?aVVCaFI3b3Z5VXYxSExYaGE2TENHM25RY0VONTQxdkduOFVTdzh1Yk5QSFFI?=
 =?utf-8?B?L1B2aVBMdDBMeVV1aXRXeTd2UTRXTklsNUdvdHh2RXlzeWxXN0VlQkZuQXZu?=
 =?utf-8?B?UnFXNEtOU3dIdDgwMStiemYzblprc3NxUmR0cVN1bE1sQ1llSW9Razh0VGp0?=
 =?utf-8?B?VmlYWnMvbjBQRXdpdTJidG5OdWN6RTVSaWpJcE5BNGNtS054Ui93QVQ3TUNn?=
 =?utf-8?B?L0dGeHBZWFM5dnBlZXpuek8wVWJOckwwa0pMaWtGRFlVWmpyRUduWnpzalZP?=
 =?utf-8?B?UkNUK1pXeUtQL1ZBTTkycWczK2d1a0tSS2ttWGtXa0Z6Qjh0bHdkblpKOWN2?=
 =?utf-8?B?TUZsU2ZKTWFmSU54VjdPamhvTkljdXd2bFVXcmx3OTNzT0ZBWDdoNlBiaytO?=
 =?utf-8?B?bkdCUjRSTWpaTC9LUzZ3MS84OERodUVKZFJMa1JpU0FjS1pDMTF0L2VPL2pn?=
 =?utf-8?B?YXF0eEYzSDhWS0N4dlRwcGc3cVNqVWhQUzBkZElJRythTEZDa0Z4VHBiUTVS?=
 =?utf-8?B?eEZUeTNaUDRZS0tkNkhkd3I1VklIK2NZa21IMUhZcFZCZy9BVFlmMENRNkNW?=
 =?utf-8?B?cThCY3Z2WDBjNTFVanNZSWFhOFhNTFF2T0pLdjBwTllEOTA0Z3owNVR2SXQ5?=
 =?utf-8?B?azloQjJTbDU4citma1NqM1F4ejBkR2tXd2dmRHBpZTRseVNKN2pqUGFyUkwr?=
 =?utf-8?B?am85UHhLVjN1ZFNkWVVPZ0VObVlJdTFxVEJsNVN6R2IwQ2Q5RE1iaWJWK0Vn?=
 =?utf-8?B?V1ZiWmFlVTh4clpVREw2czg1OHJHUEdObVQrelY5bDJxbGp4ZkdicXN5SzYy?=
 =?utf-8?B?YXI2akR4R0w5NXArQXdGbk9ZRUk5VW1Zb1Z3WUd0bGJZVWpxSW1sekQ4YTlz?=
 =?utf-8?B?WVNhQVdWLytBRG1wK2lUWjlpQWNpeSsyNGtJcDA4T3hEMTVDdm9sa3lUbXVt?=
 =?utf-8?B?UWdmZHJtb1hzR1VndGp0eFhzNW0zN2tVYzU5aUREK2RSK1JGbFU1eU5JOHNa?=
 =?utf-8?B?ckxpOXNSOTJsekE3cUd2VjdZbFc3Wk83YzN3Q04wOXVPYmhmNUNHb0N4SnNS?=
 =?utf-8?B?VnhvUkxzL1RZejVidlJoNnl1OTNpNDJyYmJQT25jWEp1QlVJeGZqN3hweUc3?=
 =?utf-8?B?Uy9rdUtiUEthZWVHLzNmdHZpdUt4RVplWTNSMkc3V3ZuTjMwRUQwc2dCeEVW?=
 =?utf-8?B?L0pxWlkycU9FRkF5RWRtaUl0R0lmcDJrOU5DeGlEYWFkNDdUQkJHdlhVaytv?=
 =?utf-8?B?UVk0cmJvVG1SVmpXN0preXM2cTdLb2FDUkdlYU9XdTgwNlg1SnRIem4wWmdJ?=
 =?utf-8?B?akR3bGhyc0lQRG1HUWg5UFpJRXdmSnB2TXdMc3pvWUJUclRyL3E3cncyMENF?=
 =?utf-8?B?LzBqTXNBU04zSzlMMEFHQlVVWE9yanU1SmlubHJzQ1JZeGkyOGxLYmtXM1dG?=
 =?utf-8?B?N2RuTjMycSs4Um5rTUpXeVp4ZzhFU04wbmNLK1FRV3MrOUxjWUFKaFRQNmV5?=
 =?utf-8?B?WVJNSlB1a1RzSXNmdDNsb3lBeVNNR3lWejF2YUJwcnpiQlM3VTlzZFV4bUtt?=
 =?utf-8?B?YndiZlJBVE5mM2hOZldBL2p2ejFkb210Q1plZW5FbnlJVXlUa29NQXp1NElX?=
 =?utf-8?B?ZE9sN1RFNVhPRXJqZWphNjNYcWY4RG9XRmZuQkRjL29iUmxVaUJKOWVocXhR?=
 =?utf-8?B?eVBKb0NodVRRamxJcFNieWNaNmYrN0hoSzI5S2tsbGJIZWh6bFNUZkFYUXlJ?=
 =?utf-8?B?THRaeXh2aVhzTlRubHlYWnBZbVdIWU1ObHNjTlkxZGhjREZIN29JdlhqZllr?=
 =?utf-8?B?TDhwcEp5UHM3Yk1ZVVF4eFhuai81S1NqUU1PM1NMcTRobDZiMFRaTlZ4b0xa?=
 =?utf-8?B?bHd1NjNHNEx0bytRc1dlTVhVVWQ5V2dsbEhoRStoUkJXa2E2d3l3OEtLSjV6?=
 =?utf-8?B?M1dpd1BwMjdoOFpnN3UvU3ZZTUZ4QWVmdlY2V3BVS0dtT0M1bTdETGdudjFa?=
 =?utf-8?B?R2NPWWFySGhpVEp6OTJINkJpR1FtaXZWUko2dm1tUEZqMm1pZmpBa2JOSHh2?=
 =?utf-8?B?SHNCZmY3bngxR2ZwOGNNWTBaU0FjSWplQ2l0aXFyVEdVTUhtK3dwVmIvSmF2?=
 =?utf-8?Q?TbR7FklBK6P3hinOaSFBOT6FbhCp+bqewQr8XVhCn9bcs?=
X-MS-Exchange-AntiSpam-MessageData-1: eGDRyrppp8vdEg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4992f486-5d51-4cfa-c5b5-08df4c3af25b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 04:00:17.1756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kI6XueNRsnqhHAA9/yb3qk7dxPb+/9mpfbhD1L5wN3oFqQVd+HsoaojI1JsFJSTrg79pgpxFeKTZhu64tzhvOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9415
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

On Thu Nov 26, 2026 at 5:20 PM JST, Eliot Courtney wrote:
> At this point we just need to write in the DMA address of libos and that
> is sufficient for boot. Remove the unnecessary call to `boot`.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Oof nice catch. We were basically starting this falcon on nothing.
