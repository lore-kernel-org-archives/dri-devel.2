Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33687CDB481
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 14:49:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71DCA10EF54;
	Wed, 24 Jun 2026 14:49:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ctxlo3A4";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013013.outbound.protection.outlook.com
 [40.107.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A79210E08C
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 14:49:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osV5g2PG+d8Pg0kSCDKzjR3SL5M96g9Yp0wSLK3cMrKru3pBfzA7jZJ8dp02ouopDsBTHKaAmkRRlyTcPmKJywbFxnqGiJMtjsfco0sPj2L4mR3nfmcbE/DgXCQJvGvXQOzaNC5m1d+rmnUMtIcxPG7J7g5R4NUEXuzENo5B9vGxzU9x7RZBFq6FKVHQAICfkRIQEwgv/zhhctNE/fxA1EheV6oH4VM3dZoSERTxBZvAjrYlL2+yRUgKwAnhhOVDhaUamqUAhYgoU5HMR6Cu2JV9tMGN3UB1cW2T2HLpK+guLcFaGOBVU+ow/Dsxpgq3MqWwwjBqRsBWl3m0Rtn1Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zr60GkB+mfvuroyRsK8s5cadeehohkPndPudbXilaio=;
 b=Q1Yq8ManiEeMJZm5jTSz7b0vPUWOsddqThULYYBzwo37tOLwtIPxdTvF1pgJG0fbXlbog778nqGx/THZ59GG4zumimiUV45cPOeUjd8OyT5TyI3ftoXFQjEaxZzhPUWw/dTS2aDREve5B8miHxlv560x323Ry8GXlj9dNOefKWu0D7M0erlLyc00EMBA/tEHamorEvn1zWdrd7gvt+svmBnDefYOXqS58TtY/UJING6DepOLx8ijz3KTSgn9WU/zh+pVMVvrutccXuMQzIpkLxI8v/2lyOR0zQD207VP4BjKvVFeGWlQVc6mD8BOIhDoO/++VaxzQ9ltRHzzWGBjIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zr60GkB+mfvuroyRsK8s5cadeehohkPndPudbXilaio=;
 b=Ctxlo3A4/8lF/yeFPNRwRGhN+fuR6nzELYodJT6irtc1Xjffcokqv1HHzgdHVBDe/l6L5VueFqtza3UhIztOvug+4yuyZSuyv6K8Jeu1nvl2Gfk0e4zE0ABjr/vq34+RHwa4VZpWv4VpFKXs1w0fxeZwGx8gIm8r4KPqVQ+K5dGa1ylXj+iJnNts2J5DQJAVz9FHlsDQ9my3wOSSUP7LvaiaYhR48tpBqRYyOJTl9hIil99vgkHfOsNdwW479n6r3FO5csNIryByQNTNcpW95Y1GiqyGd6YWLbFQPEwvXxLpgO06WUiC7iskoMy9k1PHZrCNsWXKH140GK7/fAVdDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ2PR12MB8941.namprd12.prod.outlook.com (2603:10b6:a03:542::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 14:49:23 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 14:49:23 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 23:49:19 +0900
Message-Id: <DJHD2MDVI1NM.39DDGWBM7KLG1@nvidia.com>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <ecourtney@nvidia.com>, <m.wilczynski@samsung.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <daniel.almeida@collabora.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pwm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 5/7] rust: devres: add DevresLt for ForLt-aware
 device resource access
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260618230834.812007-1-dakr@kernel.org>
 <20260618230834.812007-6-dakr@kernel.org>
In-Reply-To: <20260618230834.812007-6-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0106.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ2PR12MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: df1c4e4b-ec1a-45bf-9df9-08ded1ffc774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|10070799003|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: U5Dp974/rsgrHTJWpmBat80LQSCM2zBmDWjww5XhsK3jZ19tNNGaR3N8RJtpZHSYKF8NIk/CgAB8sbt/KaRBEFASH/uQlxf3A8Yo95RawRJdJ11+Y2H/kzWFwyT5B8QJBqOkAfMDwVOqmnD5m8O8ftprGHby8LG8I1QZkFaO+JojjU2GnbAp5hVoYHO2/zCZ8lXUWi3haHvP38eS/bXzd94H8w/AI4QJ0wGMfQ3oNQ6J2M7n47nCKA23fODFxW/FcrFVb/8SSCtU7Q37w2r7ePMaBazVt0GQr1NThpnp8ClYK5LDI9ZvUIo0qesIlsRVPhpcWbjC0jcGymZo4tPbjSy2bkAsrsLUsqy+4shdoYVZwK1ZFCXZeRiBj++1KiIhrxW3x+IdjWCzkVnTl9Eri0iC1lPcP08WwElNS0xfJ/Ww6YAhyaRx2KhCZYWTvnHKIQ2pDjLzT85xBOFB7RCLMJyRxqhXMphkB7oXd99s8QNVZ3a4Sdye/BsWZ4Y7QdkQXm/+tFflF0/zm8PeLcpbAtW88wfviAOVCHB2jy5Ujy+Ke3cL//zs3M4SfR56Z1rdfryBmMOqgFerjlbQxPHcXp1MHeaGeBMVwLGHcC6egkREvedjuMuBh7O6qnP9rFqpuS3DNNyaty8922cxfp/Qbc1/34PDXZpccVhyZZ+Z3f8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(10070799003)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym5wbUsvOHZOanhRUHBqQ21SZkVrQ0FxWkdhNVVNWjhSd0w2bkYvcXZNd3Y5?=
 =?utf-8?B?U0xOL20vQ2hVeXIrT1krZjVkWW91NGxWRjhVU3JnaHpnYk96cEE5R203RWxx?=
 =?utf-8?B?V3hueTZWK2w1b0NsdVQvbTJOUksvZC9vZ3QwSzU5Sk8yNTA5M2F1OTR3QWha?=
 =?utf-8?B?TTlnYmZjbExMYmphRFgxZFpHYWJnVDc3dlhVaWU2Y21aUFBFZlZab05GdXhr?=
 =?utf-8?B?WHpMZm5MRmhxNTBtM1Z4WHh6MUl2N1hpOE01emFLVmZyOGxBUnlFb05neHJ4?=
 =?utf-8?B?RE1obyt5NklTc2ZDbnBxUEN4aWtmZlloUm40WVpicUFQcVMvUEJTemdJMDVk?=
 =?utf-8?B?NC9INkZvYUJsL29DajMwWTJlYS9BT2wwQWtTT1NrNzFuRnJrZEFObXk5bHds?=
 =?utf-8?B?c2lEQkRCZWpsUGN4ajhlYk92ZkRCdHpHMm9lTmFVSHZ1M3ViS1NHWEJoSWMv?=
 =?utf-8?B?M3JscHBlMmlqbzN4bDFubHpTT0RFQUl3SWlnY0svdWJqS2FBaEdibVFzZlIv?=
 =?utf-8?B?cHRNOTg3dEJFOGV0UXFLaGFqZHZjL3hPZERtMjRtSVVZK2F3dHREOHh6U3Fj?=
 =?utf-8?B?c2JCTk1qTHJtNWRRZ0ZUalFHdmdjeVhTR0ZJMFVKNDMxcCtsL0dpeDZYM2ZZ?=
 =?utf-8?B?MTF0ZXRScTVYMlZoRUdHNytGdEg5TzhRWkdDNFAyTWxtT1l5TGk5MmNUaGVD?=
 =?utf-8?B?c1hJVXZTWitldGF3RzdOaFJVOU1kQ0tvV0NDRFpFN0h0Z2lwU0diYTR3K0ZF?=
 =?utf-8?B?UVhQdHIwOHVsclBpbTRES2p0cEYzaHlFOUE3aEFOcUt6cjlOaTJIeWpHT1hQ?=
 =?utf-8?B?L1VVQUNLbkhvMHlsdUk0T1pyQ3duRSt2MFFoQUU0NER3YVVaRUNSNzV6NTRN?=
 =?utf-8?B?bVJQL04rdjluZlUrV3JTdkFuUEg3OTdLeVVkYlp2eW5UeVI0ajlqT0FaS2xy?=
 =?utf-8?B?dmF6eGc3WGVONmFCOWdaMXFWdnVaVGNtZCt0YS91VlRGTW10aUp6Q242c1lP?=
 =?utf-8?B?ZlBxT1NSMFBNbnlHNjdweWV3emNqenAzRkJaR1RmSFV5WnRndUF6ang4eDNR?=
 =?utf-8?B?VkExemc4Lzgvc1RnRHQvMmQwVW8vMzh6bGQyNjlabXZGNmhWNVdTbTNlVkdt?=
 =?utf-8?B?ZHZNWDJCSWsvS3QwQ3ZWRzZRQm4zQW5UVHdyMGlpM3lFd2pqNS9EYkNpWjY5?=
 =?utf-8?B?b3N4a00xK3B3MzFzZWRsRFp5OHRlSnFnSVpOM0c4WmI1WG9pRzZyaGNkL2Nv?=
 =?utf-8?B?d1hYc2ZBQWN6Yjl2aE9YeGZhYkN1b1hHVHY5em9uVkkzUjM2T3BocDQ1dmdP?=
 =?utf-8?B?bVhyeDFnQTVLSHNNTDhFaVMyRFF4THdKYk02RkRRQmswbzZpVEtQaGRiak1S?=
 =?utf-8?B?SWt3K21XdnF2MzBSbDIza2VZYWd0WXhUbXhwbnlFZi9TS2dXYXR5aTZWRU1K?=
 =?utf-8?B?Y1pMWFJWYUpUcllDKzN2bEdiT1RxNlJ5V0dqVzhsRFFXUHlNTkRBUkJLaDZC?=
 =?utf-8?B?c2k1S3JZc1AvRGg3QTRlWHlCZGhxTlJxZnd2UEd5Z1l6UWU0WWJmOWtpczlM?=
 =?utf-8?B?M2NwM2pCemdMdEtxbXVPWGYzdEVqeGtEN0hUYkVMMXJrV2VZNmYrWmh0cWlx?=
 =?utf-8?B?SVk0d1Y0U3A0cVc4ejF0dGhCTVZUUXJqTjhzZVNzRktocEtzZ2ZJSUdpQnMw?=
 =?utf-8?B?S3g1UEFPUCs2UnAvZHY4YWxkbU9nVGtzSVptSkhlM0c1ZGwzYnh5eG9ta3dS?=
 =?utf-8?B?RTh4UitFYlFkWEhNYVFyMjlZdmNjMm1XOExUUTI4UDA4T2RlTVV3N05PclVJ?=
 =?utf-8?B?WkYwUWlxTE4yZkNmbmc4eHU0SG0rb2hsV2kvZnd0WjVTOUw5Y281cUJ0YTZx?=
 =?utf-8?B?VEd6dGpFckdYMjhxUTBSYXAzVlFJUTd0c2tjblZhWkxmalNTU3lJVy9uQVF4?=
 =?utf-8?B?TXp4WERMNnArcjlxZFFlRE1EZ1BxMTl4T0EzMmZuWGx6ekROblFIUFp1aURU?=
 =?utf-8?B?SGtoOUpybVpoeEhNaHZ1SVUxNVZFKzhZcFpvdkJ0MHlncDRjUXAzdk9UWm8y?=
 =?utf-8?B?TnlzL0pmQXl2L1RDNitsbVdxT3czL1p3QmZXSXlUUnlDNWhUdVdCUjVFYUg5?=
 =?utf-8?B?eTg4c0Zocit2SlZuZWFHYTdKUXNHbld1Z2VFSTFtMWdTZ3pob2FhWU40V0gx?=
 =?utf-8?B?US9vaWhma2VVV1VGVHdRcWVhSkJBYkc2TnBsY3NFeURRdllOMmdrMnl5YmIv?=
 =?utf-8?B?d05MOHVkSEN0TCtOaStKYmlMV1hWYXdWaHJ1d055akxYdmlJRVZseVYySlNT?=
 =?utf-8?B?bDJWalZLb0ZHamkyNFY5djhVWUNoYnNYMTdreUFMNmI1V2dwclYxQ1FzWG5x?=
 =?utf-8?Q?fpjN82rNXqXRk2rcc8x5WxQ9OLlN0m7O8rthbLYzmjX3N?=
X-MS-Exchange-AntiSpam-MessageData-1: UYFfJNtNatC6mw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df1c4e4b-ec1a-45bf-9df9-08ded1ffc774
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 14:49:23.0363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNhJZNLHqrPmJ8cxpjuqUR24nwBagX4cUmJHaFZRiS07TqsycOWoU4i0ONRscjmTcbXUlHDJ+Z9mbJ6cRb+klQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8941
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

On Fri Jun 19, 2026 at 8:08 AM JST, Danilo Krummrich wrote:
> Devres<T> stores resources as T and returns &'a T from access(). For
> lifetime-parameterized types like Bar<'a, SIZE> that are transmuted to
> 'static for storage, this exposes the synthetic 'static lifetime to
> callers -- any method on the stored type that returns a reference with
> its lifetime parameter would yield a &'static reference, which is
> unsound.
>
> Add DevresLt<F: ForLt>, a thin wrapper around Devres<F::Of<'static>>
> that shortens the stored 'static lifetime to the caller's borrow
> lifetime in all access methods.
>
> DevresLt::new() is unsafe because the caller must guarantee that the
> data remains valid for the device's full bound scope; the internal
> transmute from F::Of<'a> to F::Of<'static> would otherwise allow
> use-after-free.
>
> Two access patterns are provided:
>
> - CovariantForLt types get direct-reference accessors (access,
>   try_access) that return shortened references via
>   CovariantForLt::cast_ref.
>
> - Plain ForLt types use closure-based accessors (access_with,
>   try_access_with) whose universally quantified lifetime prevents
>   callers from smuggling in concrete short-lived references.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
