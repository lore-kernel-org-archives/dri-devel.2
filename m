Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22B4606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=LIVE.CN header.i=@LIVE.CN header.a=rsa-sha256 header.s=selector1 header.b=GNQWAnUr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59D1F10FCB8;
	Wed, 21 Oct 2026 08:51:53 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazolkn19010078.outbound.protection.outlook.com [52.103.66.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37E7410E181
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 16:51:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuwRdqJwlnvyhe1NAFGqQbAeuotjOnqlOGUtyDxXBAYdOxkskly79uFXc2P7/TqwJ8zruzUpn6XHNvg4aKJXYbFzLDpr7MlzKm3fTRy8tKj7pGJO57BszPkfrxZLauunCobG9jtz61YKePeu+tLZFo1YkNO8MhQQJDbzU8JFmJnGJeUI+tAW4iZnX++ZccyXYeyW5CAQdPkwzNgKbNSMBiMtxUAWBBUo/vMmnA1DdyIEJt/YPBaTJUW5n/xPLGWogEsz7DcE+tGdQqnS9jruZqmowCWQuVpGrotwbFn1KsxA4JqQX7D6BDnHG57HAM/MtwyEC8c3BiuTUh9MExTFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUpl0FSU+oNCfbkH3dQal1e6omOdr0d786VCJLhxzzk=;
 b=Wt48+XOCpKech2qJHb6DO0o0vVOWVohgxtyKy5niTpJ0FO3S0Zv2iF7QW+DoWrVx7YIwcK242qaF3H1RTMsgQ/dA+slBhumQoQNVZBfKLicKUqyA9hpbiZ9gZjZixfSnUZqKGQAC7fmujzUQvhPFZqFdPBQIdk0JUpyKMww78E4i91AKd0MvXox5JOcYEe0S9wN+jvY5M53zvj44ouPdiP8iMNELYw8yYx1i3xAF2aTqI0g6PnUWE7wgqjEmbft9EeRMVfIsFGN0ie0gd5lSNDo4HkmWUxoCJbhVtZ0OLv+jG289CLDpBjPuTvvdgvJfcKQkAptVMxvkHdFV+DWwRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CN; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUpl0FSU+oNCfbkH3dQal1e6omOdr0d786VCJLhxzzk=;
 b=GNQWAnUrBNoQj4q7T/+rXnh07Iwcqy8vgh+wce7rQ8+ocGFjAnl1BCy/5UtQ8nbgi9F9DmTZNWyrXm2MsbpbzPaF5aDfmtLELZcZ9DMrRSQubgmk30+lYhFt9YudjErDNhMvoGNZjxY1PVUr4e5qQL/Md4vCyZfUbEOYumnwvQLWUnYs6WmhJhowc5mmyTJ84kDYJotivElh6jEJj7OROPEyj2SRqlFMB6EQ0fJoTlSQjfBrpxP8genx6bkOuZmpPuOqaI1ueBN6zf6IBwu7uNRlMA58emF4qtL+gOg+6QalYyahXbTl8nhUhyW9aQm0amHd2KCxJPsqCgVYyO953g==
Received: from TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:30e::5)
 by TYCP301MB0748.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:438::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 16:51:38 +0000
Received: from TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM
 ([fe80::2834:779c:2a80:9f60]) by TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM
 ([fe80::2834:779c:2a80:9f60%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 16:51:38 +0000
From: Tingjie Zhong <catme0w@live.cn>
To: Helge Deller <deller@gmx.de>
Cc: Albin Babu Varghese <albinbabuvarghese20@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: bitblit: Fix glyph clipping when fbcon pans
Date: Tue, 20 Oct 2026 10:51:24 -0600
Message-ID: <OS9P301MB15353A271601CB8E1541CC33F6672@OS9P301MB1535.JPNP301.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <01b697bc-a15c-4790-b0f0-a22c44d5873d@gmx.de>
References: <01b697bc-a15c-4790-b0f0-a22c44d5873d@gmx.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0297.namprd04.prod.outlook.com
 (2603:10b6:303:89::32) To OS9P301MB1535.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:604:402::13)
X-Microsoft-Original-Message-ID: <20261020165124.90028-1-catme0w@live.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYYP301MB1525:EE_|TYCP301MB0748:EE_
X-MS-Office365-Filtering-Correlation-Id: a197478e-3181-4064-cffc-08df2eca6706
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|25010399006|260925184616899003|8060799015|19110799012|25031999004|15080799012|37011999003|23021999003|24021099003|8022599003|5072599009|1602099012|10035399007|3071699003|440099028|4302099013|3412199025;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kgm7q3pcig6iF4k1XRBpQbj48FUFKC94KYA/RPvvbzmpP+bTZslbhMC+1AHY?=
 =?us-ascii?Q?gCZnDrInUXrB1BUjpadv0U63/QFMHeW4W7SBcwuRxSfv8KF4PQyWNdYsWURR?=
 =?us-ascii?Q?hIGimeg5RrV12mzGzO9cAiyTSmw+8ZLZWgoAMpt3lwRuPqQmDH/rZQ/18buL?=
 =?us-ascii?Q?zXlmfn7m8HMYk4P0FIrKEThwPSF8RH/ZBoPh7YH/tfZf/1a1hTbja/Ons5si?=
 =?us-ascii?Q?fo88MghERf0I8EAg/sNva8HstoBNxIXCnmFGuVxq2uqvlOWJFyI1vZKNQz4m?=
 =?us-ascii?Q?qvfOiVAUxxDF7VypiSN21c8UEQ5ayjp2yKbFjnaTW5R+lbZkQ4I6Wc0tLGXT?=
 =?us-ascii?Q?uYDnnPK6xHWDDw2/MR0SVZgKUl25emQaojvMaYh2jwn4Ry3dl5fKqPukOug6?=
 =?us-ascii?Q?r0Vw6YxpIb3O4HnWB8ickrzZqD+ptgHtY/nPmiX98FuLe6bndmHs38LSeu1c?=
 =?us-ascii?Q?AUUPfJdIDCUM8h4zdLKxmvmmFXjrpct7WWEbZi1EQriRx+RytQSQOH9tQT+T?=
 =?us-ascii?Q?dXwwt1RvEQlc4+y9yTrJbJ16xlxqlROreB4Msvw2ZCLn38LTm3s+hM33l/Cr?=
 =?us-ascii?Q?5uw7z+7vS2L7vwkYbre0f2v4suGJ8COX7hgAJDOcn/ftdgACAhHZQWaUSprq?=
 =?us-ascii?Q?RUe4r2tdXF+/CbwgeB4RRJfjOT/2mPDn+iFZCCxZHkNNjViXZa4q4PqcQGfU?=
 =?us-ascii?Q?8BcfLfkXsAm9QG7LBXAHqsHabE/1/AOUzrpGjROtosAN4MnRbuHFnhf6Pk7A?=
 =?us-ascii?Q?f/tZmsVgxIJHQRvw46nfI53KMcSHbrmkTduZFqwCdjTWlx+OVHD7aTtL68tf?=
 =?us-ascii?Q?W7RwwRRFo3bah3lXJVRwY555HLMgTCyc8u2IOSPrq/gpTwskn9va6suX4k7e?=
 =?us-ascii?Q?75ZpdQiJfKmsHYSdMrJwoKH1NoBTQT5A+54oMkuuBOxZrqwiKXPZlSrCFb5Q?=
 =?us-ascii?Q?dMI7D2yUiPV5l0gQjvc7j3cUI3pPPazGi9KMPg4fGLZ2xtKdj7WfSs/VNmGc?=
 =?us-ascii?Q?37NNjKRQNOZu31+untVxlpoUHuTlJaR+fc/tbVqvVIRZb94=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r3yZFCwKucsgDULyaLJ9Tf+h5YvUyOXEyL+QfTmhWjfEPAS5sVrDmEIXynYI?=
 =?us-ascii?Q?gJ5CIDOD1nOHDIPEz8Fk2LAcQnJTO2r2aqZW96GtolZ4+Qlv2dtCzyvfROP0?=
 =?us-ascii?Q?X1bzR98cemPbgcPXpa9pVY2/XelwpcnhduQXjwrIRWAipM7Oz0UD3c+j3SRi?=
 =?us-ascii?Q?0+j8UUDouta4e2Wj4U+SF0ZhQ/4ptBmEq4P84jPPdMGYmtSjAgFGg5DM4o2s?=
 =?us-ascii?Q?akMsjQ2itdwlHPmj2BUhermEqqY4ORgzbnrZCrKFrOHlLYLEdnQKAW5MOxwk?=
 =?us-ascii?Q?rboW5L26apXLKsmKJ4lKZ7MyxMqBXIQ6ZFlL+v6FS6+510+HgXZ8PPfolBHv?=
 =?us-ascii?Q?5lUXqEeP8BQuOQ/2d/mYTp9mgTp/4NlTO0zjdbt/3z1Wiaja5UJycPkfdCus?=
 =?us-ascii?Q?1gm5lJ3nh9Z6fcgImdqW3q/3SQHaw17Ajgy43dC1fs/EI7Pu6XE4xMdT02SY?=
 =?us-ascii?Q?xXto/kc4xLA713Ckq6ZNguCYdgc+ZEU0Ow04Ch8KjyIRLdSBP1IjDeDaPAuP?=
 =?us-ascii?Q?0Hfl+StgxHRqF5n7f0ZFTah0u17PxNBjo//2YcsN3WArFW8vBYWu4bk0lJHO?=
 =?us-ascii?Q?8cuUwXIgi4jbL7dtFTWqk6zjfupfBOgHXBUXtl0qXb8cvQTE3L3DafUj4v3G?=
 =?us-ascii?Q?kRiLigq5Qr0Ksj0KWnZuv6J6JebhlieqjcrunUKKt1O7ifqe0jBjDi1bQN+p?=
 =?us-ascii?Q?brhZ8AXc7Kr9Q8cJ9zCYbaCh+bJwf8qbl+Bc+EA9MNe9PaoPB9kYr1c2FK0k?=
 =?us-ascii?Q?EXth3ALoyqkj2zzbrWGxkE1mXC35vtnsrh/916pJxrb1DP9P5bf93VXCOzZz?=
 =?us-ascii?Q?9KyEmYISKTqg9F5U2uBPWNAu+rD6BjTHtr5pUv6PjGfHucH/chHFWlyJU3g1?=
 =?us-ascii?Q?xzKybK+S1L0wAc6n1iX4VXBnDWBbT22vvldGK6QLjloxnGN2KPC4/i6nkvtl?=
 =?us-ascii?Q?ZRw6jO72xwPn8F1uCnPBYU8DUcnqYOe8Oe/ksYtNJGLRK8wk5VFfh6lv2KTA?=
 =?us-ascii?Q?fK2n/VP0EsFCAuh6GRoIfpcPLJvZjE2pcRPFgLWAsHwr8k3rUNFP0JPpxTyS?=
 =?us-ascii?Q?HU0x6kBTGOow6Hxm6SlfQT2KESIJcoIxuG27QGN3ov4fyzOvpWsKbwY8cZbw?=
 =?us-ascii?Q?Dm2z8qFmKJG4iWzPoQ97vhznpFxVpOwPwXXBvAUeWXzXMir12kSRx9d0gKfO?=
 =?us-ascii?Q?75N4S0+OeiE+Y2E0v6kvhV4VsXhO6Gn1gweDE0rLLg+kZX/SYETMQQz1IvHn?=
 =?us-ascii?Q?sdJowSs/uDPaCYYk/a7uAZT3GGR5AiLKsWErI44bjGVnrzrnXMAV5DZSZ855?=
 =?us-ascii?Q?na8vQE3lbfKs5ermKWg1k58cwW7w94YkrTs8wLDCcmZve52Wlcp90VlH91NY?=
 =?us-ascii?Q?mDcxBd4Z1M+0sUX3MuKhjd6htLBf1vmYXE1Iwzua6Cz25zk8M4M2fTTfZExo?=
 =?us-ascii?Q?jgNEdzhJRqE=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-a91ca.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a197478e-3181-4064-cffc-08df2eca6706
X-MS-Exchange-CrossTenant-AuthSource: OS9P301MB1535.JPNP301.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 16:51:38.3518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP301MB0748
X-Mailman-Approved-At: Wed, 21 Oct 2026 08:51:51 +0000
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Helge Deller wrote:
> CatMe0w, I'd like to take your patch, but as Greg already pointed out,
> I can't take anonymous contributions.
[...]
> Can you please sign off again with your real name?

Hi Helge,

Sure. I have sent v2, signed off with my real name and with the tags
from Thomas added:
https://lore.kernel.org/linux-fbdev/TYYP301MB1525C5CFBFCE755C7F31426FF6672@TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM/

Thanks,
Tingjie
