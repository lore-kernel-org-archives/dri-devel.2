Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A701B606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=StpojMvs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF0F01122D9;
	Thu, 19 Nov 2026 11:28:51 +0000 (UTC)
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022085.outbound.protection.outlook.com [52.101.101.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CC691122D9
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 11:28:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXa7WyxFB6oLcAd7Dhi4iM5SrZKmliO4uGmL5jCfFBl/VcpGV9OUlPkxpt61LRz9hntOJPS7m6hltLCq8bBjsfSyjdg1oyetINCMxTVsxfHnKXMHZLWZ6Vpn3GD+6UTvXoWLUYxQORpribMeBtZjpMkUo7mTxdoMRxR9vvGZLEBEog7fDLevTi22VUa5wgna6Hcwxs5Trk1EfgxO8np5D1M9DRa8DFtuKmDdJSMaCC12CjyK9xYc0LClb2SdMaEP8D+ZKGbqejIbMNhXP4qgLERC0d88kqeyivMb/6FOEVEJiwyss2lDdaAAEFdubKH4W3Ce3c2sHVSzEpL1B/n/DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=808J7PNFPIIHz+voB6IbC90ayK3WTI6EeXcC4XBvC/4=;
 b=FFInbLoxLriq8W+1iQ57sqaZGg8bdGck5Ilz62Rn2qEQjFAIqOcWzmKDvKqWJSVzVoymiqK4m89fKpgUOeazNT2w1FQJl7HUfvR4wcbEBA/bImHZ1MQWAVPIUZdwe55hTOBWd4lW5R/787dQRJxlYxhcvGtWR7r6xrUCqYqoMfFA06093zRPEOVPyIiXqmOvlyBj4/dkHNQDoAr13fkUNzGB5S8BM1FbweRSaubg9ppr8680+cdoEDOtDIxP1dD2lz2tm9mwmIP+6UBG/+zApfspm0zb9KcUa6upco3itBiPxmvRQoVfOSieJkz8EBlIHNG96kVogAWde6EZHUJYEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=808J7PNFPIIHz+voB6IbC90ayK3WTI6EeXcC4XBvC/4=;
 b=StpojMvsTAV8o9kgzJXp111EyDrRk32lpjEMIGhhZ1s/iRXHDOogzpr28b5HMLSUTxY9UNhyLFRSJ/0Ab7/89tKy/7HUvS+kaCQaQQ1o/XbG5LWDNZWcdmJb82bavu0flrgm032IIvhp9I7KnpNtI2/5ENGk8xjnqG49nMkJboo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by CWLP265MB6561.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 11:28:40 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.015; Thu, 19 Nov 2026
 11:28:40 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 11:28:39 +0000
Message-Id: <DMZ5HM326EKD.1I8KUFD65L91Y@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <lossin@kernel.org>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <tamird@kernel.org>,
 <acourbot@nvidia.com>, <work@onurozkan.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] drm/tyr: name resource lifetimes after their types
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20261118233727.3147222-1-dakr@kernel.org>
 <20261118233727.3147222-2-dakr@kernel.org>
 <DMYTKRS80NRC.18PBQHK9SZ8K9@garyguo.net>
 <DMZ4C3GGD9U0.360KJBSFLEK61@kernel.org>
In-Reply-To: <DMZ4C3GGD9U0.360KJBSFLEK61@kernel.org>
X-ClientProxiedBy: LO4P302CA0002.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::8) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|CWLP265MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e7f43ba-b3e2-4bca-e2f0-08df463042f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|10070799003|22082099003|18002099003|4143699003|10067099003|261026140227099003|261026121527099003|261028144727099003|261022105027099003|56012099006;
X-Microsoft-Antispam-Message-Info: OxRaJOEwJckp3KGQZv8abOsyvx14W+1bLRRRI0dXBdroj+9CXs0E1TmFlb+eMaNlJNPXe9Njc+c7M3Gn2Pn0ayPYhIVdP0Li/Hp4A0cG0B0RXK/tvmnSig5BeWixGBEZ9Fy8MRRMKfOf2XiUGlh5KViAujm8/6X7JA0dcuV/WZHDTT4XTpKqcOIqMGuGU55ygl2hogvOHeeqIXsRNeF5XfS4NG1Q5IpYrn+IqsnYKOfX2os+wJVu/Or/qU8NyOklHppPrq6gGuSTqNpvvBmh58wZHactmkcXNmJvB9yWP1cEKJiVbFtXqG/zE84Y/4GN+rUkXJzg/BhYMV0obzc71D8FPDFu1Avp2FFgprI68ZP9w0bdN6tv70rux+rD1HG3t/CGWuC5ysLC8nHB+MrnVTQqauJaXGZ8ESnBQ9mkmrqc+zwNB1xLNFEmUyd8b3nTNcxL5d3NxDJUeqCrcGQMnLjlzO309jZg22Wnxgke/9WOWydTgn8OZ8536MKrRHjBsZioSKM9Y8t45RsE6CWBzd68AjAhvzuwmjmXom+0qnYLXqEXfiYuHlYod7TWcwreTA33Y/rtSDusXocQW7QHQao4CJqAdn4xzS4PHrI1GqIey8la5+NSqhegZTMrVYPW+mJwpfNSs/ll4NZZ4yORLDAG36OSTKDOfH24z7UolSs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10070799003)(22082099003)(18002099003)(4143699003)(10067099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDBBSXNPQ0RNbG1NZGFBd1hYVEdZcEN4L0FTM2dGbzhkUTRtVUtBb0txQU9t?=
 =?utf-8?B?THBvS1FTOEpOQ2FxajZSaDZWeU1ISFpMUUp5c1VOU0U2KytVb0RRQVdnY1NR?=
 =?utf-8?B?OElpWlVQdVZ6MUVNeUY2MTA1WlFFcWg2THJ5QlBuQ2tSb1lGZVFLVzVkOUlr?=
 =?utf-8?B?VFVVMkNCOXdsSjRONFQyTUUreEltMWtLS0ljcURiVHhLc0JCYnVDTWtYbjNZ?=
 =?utf-8?B?enZUQ3FkR2tFUHpwTS9VVVVBYXdqZXlRN1VvQ040aDNVTUpNR2xXL2k4ZzZr?=
 =?utf-8?B?V1YwZTZqMXd0dUxJOW9mekNRSk0rTmU5L25QQVRnWWhxMnRDZ3JzRm91SGtT?=
 =?utf-8?B?L1ZpcnFOc29wS2RGeDhIdS9SQlFVcHRiRWErMURhQlE2T1RjSTBLaXRpTmJK?=
 =?utf-8?B?aWp2Mk5uWE5QeXlVS0VwRTY4YjU4ZFpKdVlrVnY1RG1MUVF4S3pYWUJpb1J0?=
 =?utf-8?B?TVBJY3IwSnRVMnFOdkphTk54UUxkNHRzdGFnVmovVGVkTVZsMm5mMWRGNnlJ?=
 =?utf-8?B?OTBaMklHRS9raWZpQzVZYnd1a0o0VDh5TWhUVklRd2tGNEJsUTJxUko3R0Ur?=
 =?utf-8?B?M1YrUUVHZEpEdlQ3cElDU1dob1ZlcTJ1QUJMeW1NWTNMYlptaS9OUThES1Jo?=
 =?utf-8?B?amVjYTEvR1pyQzJHTElzaUsxYktJcCtVaVV6M0NLUStGb2ZNWU94VTV2NWZs?=
 =?utf-8?B?NkJ0dkFHdVErcVRNWVdqS2Vsbm4rOVdJaldxTGY0aWxGV0o1UXc1dWpzYUxR?=
 =?utf-8?B?MWxpQjc2L2NNbnRkYnU0Mm5kUzNZZWMzbGhqLzRETDJ4clZqQnIzRkcxMGh6?=
 =?utf-8?B?MkcrWGNzQ3JyUlJUTHZQS3VpeHVyVTRTdjF3eGNmYWhTaVRPN0V2T0o2eTdo?=
 =?utf-8?B?UnkwOGhmcXJuOVc5Y09VRjBlR0I4aTVnZUFCTThkZXhaMFQ5V2svNU9UWUFq?=
 =?utf-8?B?MFpvVzJMY25tK2Y4d0t2MlRZQ1BVUDdSN3U3aFRCemM0ZCszcGw3MHRKYXdM?=
 =?utf-8?B?YkhRNHdianljVDJLcnpzQVhEeXBOWWpGaXIrQ05HcGZqL2lTYk1RT295Y0Fn?=
 =?utf-8?B?ZkhJMis0VGpwTGpxVFR2OXNPTFZacWtsV3hMSi8xYWc4anNMTjVpSHBlMGlw?=
 =?utf-8?B?MTVRWEU2ait6aDRWU2I2K3J4bjBzUXpEdjVUdUtPT2hMWHV3NVcvYmZNeE9a?=
 =?utf-8?B?T0NHSEtIQTIvbXU2cXgrVDBpMFV6Nklld3plMjVjd2I5VmcyeTQ1T2s4Z05i?=
 =?utf-8?B?MDMyUk0rNWlVYm12d2hFclFUMHRNWWlvclNMa1NuWE9Ld1pvVG1jWnpuajAr?=
 =?utf-8?B?NDRZU3ROdDVVeE9JL2dnS2x4SURmdnY5OEcrbHd1akZ3ekJGVEtzbzZNUDF3?=
 =?utf-8?B?c1hveUhMUEU3enhKcmVtZ1VGRUZFTElwNzEvMHpneDJpR2lvTnF3Q1JyMURL?=
 =?utf-8?B?VzZEc1ozdzZ1OFVJSkZ1N1lpNUhCcktWa0Rqdmx0RUk0Y0ZUd2lLZm9oTWpC?=
 =?utf-8?B?VmVhVUxPVkFmS3dXYUNSTFViQzZlY0Nvb0lKRURXcHRPaFR5UE1ONk5LRjE4?=
 =?utf-8?B?ZVozL2pONWlCQkZJb2Z2SkRDaHFlUlRXWGhUUTYvQXQrSlNQRCtlWWhrTnRh?=
 =?utf-8?B?ZUpWOExJcGZjWTRkeCtRRjVPY09UQ2NUZ0htR0c5NGRzOWZtSzFWV2wvdG5w?=
 =?utf-8?B?RE9tbXNLUVFnYzlmc1pkM1ZSb3ZwdE5XZFZpNmZFczc1OUpQbFY3azl4c3Zj?=
 =?utf-8?B?MS9PelVvb0dteXh4VzdjZXdrWU0wRU83TXp5RUNSTHJtYmdpM1FDcnAzMlFX?=
 =?utf-8?B?L2p0RThwenFqYVhLSVAzcWFyRFFuTFJvQWR6WXBTOWxQNDRjalZzTHFURDJy?=
 =?utf-8?B?ZXVEWkFyZ3NvdHREN3Q2OVFrbEJuRWVGUUZQbTQ0ckNieTE0MGpGSGVqeGJn?=
 =?utf-8?B?R3h6MzZCekFUUFA2VmNUVWlKN1pLUzFNL09JU1BzdHNIaVpYVUpLeEtMbVND?=
 =?utf-8?B?WFJCUlF5TDM3ekkycDVTT0dGdXd0SGpqdG1ZUkt4NzNaTlI5R0ovTlR1RHgw?=
 =?utf-8?B?cUVSYStKZVFQWUhtVlU2L1Budzczbk84L0pMQWZCZmt6UlkyWWVXWUdXNjNO?=
 =?utf-8?B?MitFY3ZPaWFqSGdYdlF4KzRkd0c5RTdnM0l2bHZnTDRMYW9nczhJdVkyKytQ?=
 =?utf-8?B?UVNMOXBzTHpNRDlQQnNvc0xsdlU0VDVYelFUQkluZ1FNSExEcVZIdFMzQysx?=
 =?utf-8?B?NmU2Y28xTjJoUEVKaG5RQ2FQaWpTaHNRaWxaK1dIMnRRWEt6T0Y0WXUwSzU1?=
 =?utf-8?B?ditEVVRtWmNaSi9iSTNkcW9UWG1JbGwrelgvbEhWbXJDVkZybmVEdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7f43ba-b3e2-4bca-e2f0-08df463042f5
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 11:28:40.7078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pa9D26UYpWQHS8FGXYI7EQI78/tav/noQKQIRSndOaHnl6FuWiS8ipNZwBVo2Y9TvRa8mTgjyjL1ZtyUirNxwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6561
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 19, 2026 at 10:34 AM GMT, Danilo Krummrich wrote:
> On Thu Nov 19, 2026 at 3:08 AM CET, Gary Guo wrote:
>> On Wed Nov 18, 2026 at 11:37 PM GMT, Danilo Krummrich wrote:
>>> The firmware, buffer, VM and MMU types use 'drm for their resource
>>> lifetimes, even though each parameter is local to its type.
>>
>> This doesn't make any sense, a lifetime on a type by definition cannot r=
efer to
>> a scope of itself.
>>
>> `'sec` is not the lifetime of `Section` and `'fw` is not the lifetime of
>> `Firmware` and I think this is just confusing.
>
> Yes, this was badly phrased. What is actually meant is that e.g. 'fw cons=
trains
> how long a Firmware instance can be used.

I think this is weird still. Any lifetime on a type would constrain how lon=
g an
instance of that type can be used, that's just type wellformness.

I think what you're saying is basically "I couldn't think of a good name so=
 I
use the name of the type instead". To me I think using `'a` has the same ef=
fect
and is less confusing because reader knows that it is a generic name and is=
 not
tied to any specific scope.

Best,
Gary

>
> (In the following patch, in TyrDrmRegistrationData, Firmware borrows Mmu.=
 That
> borrow has its own lifetime, distinct from TyrDrmRegistrationData's 'drm
> parameter.)
