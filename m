Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA7FCD5BC9
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 02:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC41A10E088;
	Tue, 26 May 2026 02:10:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jYI9z8Zt";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013052.outbound.protection.outlook.com
 [40.93.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20CF110E088
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 02:10:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+e/o7gc1aVfdCZQ8rj0i9gfXOR5zsdlkwXMw6RfJnB+HbCj8pevTOQne6W5xR+F0rwyLPrYWzQxn8MOCnTIxl0iC2WP0wOeDPMs6TT/Ox9uEhrb32MjMY99FNoFntxxfFLNOa/Tt00JYZvnTd9rmQO/gGrOtPO89Fg++rdtRtzsMfe7oBAcJiyanjy6QwKumE2grdBgXphFD14F5GmgwjD5z5pVkTyoI2Q3ilu3dDwYBV7kdybHdP3tJctZpuMtswY1Wdx5W9CCwIkNrkQnhmhFVrl1+pHAhdyu9WsdfNYf5CYwYcYLaFIcWzG/wh6iOl8E1ktZMwznbN1aVpVr0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIMywZfoVROExD0Tt0gjtkrrZ1wroz9F4Pq+tb7YHak=;
 b=RRUYszn85SAE+CWBYF+F9qIIStNYmfQYUeAhE091uOM0nd0a/bdObC8Ei6Bm1uXt7/NFxlOE2pNGTxOEMQEZ95S3aWh6NO1ud/l0uhBT/w/rNtBiHkMCeGlcI7V1WUOFWgAGLjBrvfqCPdWszm6ypEAdOr6qz00P5GsJhdPaAZlg4sg9sP0Lm9qaEfvPYryxBgTt6GOZxr97ilDqbHX4hy+RIGf6pr6JhBmqmB7leQxrjwpEUrfkwQkY44Z7GxN3XobWVDk7XynDC4WW2Srf8R2pVP7HdJLc+QBDXryuMxTxsL39tn121tQFCsmdgpF6jvtzWI//P/bce5GLxfwVKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIMywZfoVROExD0Tt0gjtkrrZ1wroz9F4Pq+tb7YHak=;
 b=jYI9z8ZtNPMYprkh2HUUESbv7j+j37HDDGNpXKiQPy9lwlDTzcfG1yoZ2m3yxysGCR+rATHOMzVw3mKkQbYwQyBswF2GgxblIbK9SII8/wNeVPKZMG0whN7Nlkg0GGDlwFRHAT2lJQ1KmSjhsBrkRPBQY565gMEZCTYkDh2lhLHwNMOVmKzdYr/k/RM5v7Ckc2kze3KO61zymKftERVcw4NopdTx3+clPnH9iCoRy4reW1ZzCk0VH1rcUmTJgc5sX1iii5z68LGD0bTq/1riPCACXKETGTeOJFzYOSX2f7uBaq82Oewuc88zeye/c0XlGFfuAO7TMjoA5cpljOPtaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Tue, 26 May
 2026 02:10:03 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 02:10:03 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 May 2026 11:10:00 +0900
Message-Id: <DIS8RFZO6IF6.OMCDPD24RSXN@nvidia.com>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <aliceryhl@google.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH REF v4 24/27] gpu: nova-core: use lifetime for Bar
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260521233501.1191842-1-dakr@kernel.org>
 <20260521233501.1191842-25-dakr@kernel.org>
In-Reply-To: <20260521233501.1191842-25-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0129.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: 73495f76-872c-49c7-47f2-08debacbe600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|10070799003|4143699003|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: h6qwGtzgKoU1LdzgxspLc3N+g5j1tvQh5U63wnT2avEWIzQdrD555MRx7amO82ZvMLioNbIP4WLEDd0wmCvJZ/egXKzQNbTGvjfOj6QSRUuWhX2qyHy7on9tvcd3qKK5JHjbT2FpYxC4x/TmDVHOnFVodRg2w5Gz/R9KnoTrrGocVAj5wxqWuCAEiD2V7xP5XQbUGr0finu+oQi5N4gsRPuOPdOe0QBaia+gVdrBSASE5TxCajRKvBu+ghVjqk4vVaK34YJviDm2AjSU5iEtUHTemEKy9+8lQJA4EH5ri8SKkwI4AJ0XUbLedZyOFxswKLpKOsK2DbrJgrJvV/aDZemS1+6HEuGQfcEFh/GB7yD8Kjt2I8uhvGAPKsxOJAiVFi49vlO06D3BIIs51QnSa9/mqwwLiBXgDHdPkYQVH81U7tO8voryXQsMeLQjFauvdAp02d1fHUJdX1mWHPgplTdJjsKbtNP8YU0t52oADsO9sfdTeMBs5zD73yPnjJpW2yMM9F8nkiI2AWTv/tznN5wW+XsNRdmISbn2vk5SR5FfExmizgzpMfgIcIA6QQxb96tuSDOXlcgPekrjVZj6/unsus6Qa0bMDQFRwRvV8+ll7wdKXdQ6yikT7C2WX6PBT62q7WS9PVcG/CyawlA0pxmgxKNfjHc4JdpWhDdS3WNPqeVxh0H3TBu9qWhaI2Ew
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(10070799003)(4143699003)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnVPcENXRjNUQmh2NDlzNGRyYzBJeE5hRE1Ob0Jzd2xxSDYrMTRLS3NhOFRi?=
 =?utf-8?B?M2t6L0wySHl4bC96T0cyWEJySUxsdVNqcjNPRXFkVHpsZE5majNCN2ovQXp5?=
 =?utf-8?B?bG92L1Z5RUNIdXJ5STBERHhGQ0o3MG9YeFJiSFUzRFhyWHdyL0N5OW5aeW03?=
 =?utf-8?B?MU9kRDFCajg4VGN3RkN2SnRLcVFsTkh1ekJtdWN1a3hrclhsWWtubXcwY05m?=
 =?utf-8?B?NktWMlkrOHR6Ly9KbWl4RG9Lc0JmSytLL2x5VHpVdG9YdVVXRjVoZCtaaEo3?=
 =?utf-8?B?cmdBMFhVemlyanhWOGNCM3Z6UFg1MW53ck9vZnFhRjZOU1lFWFFKRTE0SkNC?=
 =?utf-8?B?SDRKNld3Z0Z4bHdrUURWbGc4dGt3bDBQZzFvL01RSnFwOWJwYm82WHpKZG94?=
 =?utf-8?B?ZHd2cTZDYy9nd0UvSDBOenkwRWQ1cFcwcVE2SnVySnBzdldlNTNKK0k4aTJq?=
 =?utf-8?B?N0thcFBtbzFuZmNSL3lnbVYyVFhVMEZsZFhvK1BrMjRHZ3FDN1REMGZwc0Vq?=
 =?utf-8?B?MTVYWWY1bk5QNndVakt5THNTUVZTbHdlNnVhbGdPZU5ISTlZb29vMHJwcHFj?=
 =?utf-8?B?ZGs0UzBoRlFWbFdDM2NGY1NPN1kxMFJSS1RtR0prcUVzOFVWbGR0bzY5dHNw?=
 =?utf-8?B?bkRtTHoyb3RJWjlrWlA1Q3VZdGJiMmo5ejRUbVdTSVdEU2FGdW43WXo2OEdR?=
 =?utf-8?B?ZjltTW05dG13U2lmMG5NZTFBZ3NTNDAyazlScnhYQ1pTSFBKR0hUTUJjWms4?=
 =?utf-8?B?U1diNGlPL1VyeHdENS9JNjZ3NGZIcDBBOE5ZMVdQeDE4QlQrMExwNlhKbndn?=
 =?utf-8?B?NDZuWCtiSEx6cm1kZ2ZYM3lnRU9URjN4VFhNRWc4bmJ2YmNTTzRWZy91enFv?=
 =?utf-8?B?UXFlbXlXZ25YajdoVEc2UzhMT2N4cVZVL21mamR1U1g5Z0Z2V2UyZFN6bjM1?=
 =?utf-8?B?TU9zUzVEYzh3UUxjVmpzM2ErZHZwSFR5TzBmbW9qcmhiRkJDbm9tQzY1MXF1?=
 =?utf-8?B?YVo5TWR3TllhV3phczQ0WnVCaThrUEdnRUVCQjhLZkpENlc5VC9od1NmalFJ?=
 =?utf-8?B?Um1HY2NLbUcrUHhhMGN1SlAxb01ESDRGWDVSUGFIcXY0YXJqMmtXR050Q0JE?=
 =?utf-8?B?SHdMTlJUbHpxZW1La21XU0pxRlZwNVdlcVF1SGpVa2dLUytsYitYdjVMb3pP?=
 =?utf-8?B?NHRINTZWcXBqRllmU3dwc3lIMTgvSkIzRU9kVmp1TW94QUhTdDB0WUUyWk5N?=
 =?utf-8?B?UE8zenJHaTY1dm16ZHFKUWVIVTBPOXo2ZDNETHQ5ekQwWWlXOTdCMEJUOHYy?=
 =?utf-8?B?RnF0amdUc3NtRWxFZzl4MUtlNGEwemlpNXdQV3pYWGVWWWlNdVY5YjRFa0p5?=
 =?utf-8?B?bThlVmVIY0VSK250S3hZS2J5Uk0xVFZnbUJ1WG5kcWZKSVFvamtGNVdIRy85?=
 =?utf-8?B?K0RTVkVrY1Bpa3JjU2grOFhOSTh2bWxUTURoc2JVVEhPZENWTnhSWTVXeU4w?=
 =?utf-8?B?dXQyYStBNEdsOHA2V202OVAyQVlwdjFlNk1BWjZHT05ETE5nZnk3RThNUUlT?=
 =?utf-8?B?c2wvb2JTMlp4YnZQdGVBbmJrbnZ2Wk9UQ2N5M0tBa0FtSVIrZmxRVGszYnJy?=
 =?utf-8?B?eDBNUHJxY1dTZ3lFTitEWGtRWFgzM1JuclpjVVoxN3NhNmQvVTVRWTF2YW9j?=
 =?utf-8?B?aXNjK2UwU1pCbTNNZ3dVWjhLUm5zVGxHK0lJWkZhaXJlNEdLZjhXcFZaV3k3?=
 =?utf-8?B?dUVTNmNrMHFCTlpiOXJqT2hUeGJPek56OU9aYUROV1FOcEFjUnRSTzJBMTVZ?=
 =?utf-8?B?QWlFUHA3Zk5nRE9yd2ZIWG5HME9ad3grbWszdEFiYjVvL3Q1UHBxTzdKWXkr?=
 =?utf-8?B?NW85VHMwNnFaaTBlSjhYOEtaWS83b0RDaFU5cnVmMmdFMzRSd1F2SXZ1cmV0?=
 =?utf-8?B?eDkxNWFxbDVSSTVieUJyNE5mckFFeGkwUnFvMjBac04xQ1Z4M04zclZVc0JB?=
 =?utf-8?B?QTgxVWt4MjYwV1BRSGJPQnZKL2xoVXEzeWJDcGhrWmVDRndZM1ZPanVTY0lE?=
 =?utf-8?B?Qjdlb1ZMM25QMnhBV01CV09ZUm5BTXJnMGpmV1Y1TGh0SCs1aWZoYjA5Y1dI?=
 =?utf-8?B?UmJJNFRrc0ozNVFXMUN6eEhjTlMyYjRXbEVXMTkvZjdqeDd1Mm9zdlExazFa?=
 =?utf-8?B?dzM2VHp0eStIRGFCUjNLZFQ3MFZWdGdNNDU5YjY2b0s0d0ZoQ2plSm9uMG1W?=
 =?utf-8?B?R3lnV0tLV3V5cVJ0RUJicFVObTFXRjRYclR6bSs5cHQ5RGEycm1Nc3V1V1VU?=
 =?utf-8?B?ZlRya3VRQ1Mxb1dHSUhGaDFXdG5pMXliT3gzVHFreHNQWThoTnRYYmhqRExu?=
 =?utf-8?Q?oU97JwoZr3HNfLzkOQCToiPJWSSiGTNtAh8cYVEytw6wX?=
X-MS-Exchange-AntiSpam-MessageData-1: TNvdvYkgEfBPBQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73495f76-872c-49c7-47f2-08debacbe600
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 02:10:03.5361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BPB6cUXNMRjxgH6Nyr4rdQsD5T5JTkzrvkZHdtv5Q8vruXJBaklNlat6ss/ZbHFh0C8kzzVeXvrqPgmmgL8/yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715
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

On Fri May 22, 2026 at 8:34 AM JST, Danilo Krummrich wrote:
> Take advantage of the lifetime-parameterized pci::Bar<'bound> to hold
> the BAR mapping directly in NovaCore<'bound>, and pass a borrowed
> reference to Gpu<'bound>.
>
> This eliminates the Arc<Devres<Bar0>> indirection, removes runtime
> revocation checks for BAR access, and simplifies Gpu::unbind().
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

I see that this patch is not in v5 (and it is marked `REF` here), do you
intend to push it soon? Knowing that would be useful to understand which
base to use for work that depends on HRT.
