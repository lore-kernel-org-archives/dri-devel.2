Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF29606A337
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 23:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JeXWXu7q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A84B010EAB8;
	Fri,  6 Nov 2026 23:15:48 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011018.outbound.protection.outlook.com
 [40.93.194.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2F2C10E4D7
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 23:15:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6L9mjjQqZnYrP5wcdLjpdpoi1lG+1hxrLruQDVfn2hGLwo+C8TbB+1NayVF5f0cF3f9jlfJZLpQIHkqMNpBovhlV/TCRmN+1my9s9mVPjf/Gp79Xb1PxPD/lcLc55DWp7EAHQhWBleuLkcWDwFeUUByNdSPInfoiVf30xqN12jF60dKEorwa+CiLNNrn952fbr39CDMh3WOO3l0S0gmIakYJ5flA06FlVxo2MwSkvi3gG8Picplig/YdahUytwjdXRnh3fuHss1QzOY1i+DKTrU6suOyoHa5JrQnQXFqPl/d9CXfkJHof27VAodUla4mEfPyyChFYOlegY+fzR54g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKFtqwDl9Tv/mgYMiGvI5DVa+xqVVVNLY05hP5nGV1w=;
 b=CVJZbDGUdlfwkg6MZOeiJwsXj41acAau7PC/ZjWK64/1GptxWpV94xQzniNpRuGgow/3sytFq21V/7sb7ev8FSJjGtZMYIZ8Ae7z+xV1UXPwQDiEMbzGrJrD36lu74Tt1qpedkbEAjObQuPr6QQrLC7KIF9CyXeK+PIDrGfTgrh7oZ2HxTuuxJacX5T9c8syAKdKcVovUq9T9xC1MsI0DIqGn7pq3+D5CNwgvb+kwQxLjp5uqB8PbIK+LOVepmmTqlyT4i+VFF8hTL8INzYK6J+LagKxhg2MBenARkErvqbC5PyiT5iJa5GKls9gRbYBeCZzD5aqNpitp4wYTsi1/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKFtqwDl9Tv/mgYMiGvI5DVa+xqVVVNLY05hP5nGV1w=;
 b=JeXWXu7qy1wtwq4RTdp77Io0zpa+lp98MLZfNBpxbfueNEhhYT4lSgp4JH3iOVnEi1B4GHs1wxUQmNbEG3EqnGk4z+guyx0QzvZcKJmslqqho5ILxjz46bQbkLNVl8y0kx3RN5BnW5FUsU1OsGNyfFikr0gfjasFj4zzh/y45VVHaxeR1RHzZpuSADMFHyO+I1eKycgSdxqgH1B6cd4Q64jXPPaT/qzmZX6SU/5pH0hdyDtCQ4gQpidGeL1icfMSqiOuNtxAcUAo4QvFWw4PB+b/hHbJJe2a0q+VGVn4CA74o2QNAl/vg6O+NamzZdDIZBF4N9UpF2aeV0ct4nVURQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 23:15:38 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0569.011; Fri, 6 Nov 2026
 23:15:38 +0000
Message-ID: <695942a0-15f9-4cce-bb54-ea7f727ed9e1@nvidia.com>
Date: Fri, 6 Nov 2026 15:15:36 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] gpu: nova-core: retain the GSP-RM log buffers
To: Danilo Krummrich <dakr@kernel.org>, Timur Tabi <ttabi@nvidia.com>
Cc: "vladazaharova2018@gmail.com" <vladazaharova2018@gmail.com>,
 "gary@garyguo.net" <gary@garyguo.net>,
 "nova-gpu@lists.linux.dev" <nova-gpu@lists.linux.dev>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "aliceryhl@google.com" <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>
References: <20261014154554.231015-1-vladazaharova2018@gmail.com>
 <b2ff5c437c41ba4f8c1a8f354d24d7e68517fbf3.camel@nvidia.com>
 <DMOHVQREU4JM.1A6IV5O5VMXKZ@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DMOHVQREU4JM.1A6IV5O5VMXKZ@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0176.namprd05.prod.outlook.com
 (2603:10b6:a03:339::31) To SA1PR12MB5614.namprd12.prod.outlook.com
 (2603:10b6:806:228::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b09bd55-2dcd-4025-86ee-08df3c5bde47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|261022105027099003|11063799006|56012099006|261021123027099003|261026121527099003|261026140227099003|4143699003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: EXEtCXjwRPLQIE/zcboRSBZxR751oohONIyFEJRCl6DAQMoxLToYLEEjpISCjzXOrGA1fpw3wCi29r2IS3TsJTVMpEjukUH25LHNPOR8qR8o4sIvqaDhERAu4DviIocmWAyex3KExmuzmK9037O/gephYR6kR95HaspLYGbtFHCDmJhFIppoTiZo4B0inFibKW1/v9v35S9F2wJ4Hdj9S6L05Y3frx9/5SxQ+KWmo9d7xnFRloReMvE8ys5d7EITXJEQsu1eYsm0U6dD6x/Vwxot6edTlGADeYkdAgnbcJQndku4xYr+n0XFqG5YF3pIi7EJ37DU01T/UNd8QZ5rv5Fr1spdWN4cPTTWR/Vu54KfTnfezD/BKEVFR8Zqx1iCVDkQcjnjHLaC1aTOTNAoy9VFNQvngV+Q7bJdc2X0PX+hkZfcYJ3BlSZCtEHSYzd9SJYnpL6aZmwunGf0sFJN/W73YAF/wfVzy/O/R4IU97QnISJ01zlcTQJgesTZPa8bh0vrTIMsTqvNQE177pO+OGBgL2zUxNrW6XIzcF4t34JNmhRB9jiN5xLzt3Pq2N++O+PbmOlr31gq6+Jr7vEhCooB4Hhs9MbLZa/XA+2nIEm9VsaUirJZ/QMsaWsew58ZtFvyOUpM1d11AKpoJOGmPaP+4cRth7Oho55836DUxkU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261022105027099003)(11063799006)(56012099006)(261021123027099003)(261026121527099003)(261026140227099003)(4143699003)(261028144727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHlLU1BMNlkyTzVqVWl0WVgzc1dSNC9jLzlxU1VsUjBoR1FwZjcrWWhiLzYr?=
 =?utf-8?B?TWEveExPTXc1bUUxUS93MVozbEEvTmxhNk16d0ViWjUzTWg2OS9OQ2hlTjRG?=
 =?utf-8?B?cjZhN2dUQkVXU0ptOGpWT280QTVTNTgvVFRnNXpEZjk0a2xUTWhISmtWNVJU?=
 =?utf-8?B?SG9aTml2VXM3SlZHOTRSL29iVFZuZXZwVUdwNW4wOWFqZmNMT1RYVGE5Z3Zm?=
 =?utf-8?B?dFJVYnAzQlpTYjB2WUtGUXhQMVY4MU5tN1FqS0hveWYxNEh6WS80b1BUdjBh?=
 =?utf-8?B?K3A3UkM1UWZoTHJCYXQvWFN4elh2czJzQVFVYm1aaDJEMVU5MnVua0kza2hz?=
 =?utf-8?B?YmplYmQrdGxiaDUxMTFtZjl3OHJWWlQ4a1R3NGxUYTBKMGh4cmYzOFVobmtz?=
 =?utf-8?B?T3FWT0tlYmwzb0FkSUFYdXA3cXQxWnRxWFo1TG9ZR3B4Zjc1Skh0eEIyRXU2?=
 =?utf-8?B?QXViTE1FS1ROSkhNZGdBd0pTc0ZkZklJdXMyd2ZoUEwzZkJwK3hOZHI0YnY0?=
 =?utf-8?B?aHg1VGpKYkVrVGJqNGFlN29GT1dSTldsTUViWlIzYnJKV3RxVExjWEFuMGNF?=
 =?utf-8?B?d1EwUFhod0ZRVjhUK3N4bHJGRWt6VklucG9SeEUxODdaQ0lQWnRKak01UEVz?=
 =?utf-8?B?dGNpYlQ5L1NXeU1RZGE5cUh2aTA3dFNOaDM5SEdTajRDS3BvOEttZndLYU81?=
 =?utf-8?B?cnhVWFNYdzNycFJQN2ZSMERzQkdGcjdaYzBRWkN0ZFZCbGNjZjErVmQ3NDhJ?=
 =?utf-8?B?R3U2RTNRZVNJRTZFYW0yd1l2M2ZESW9PODArekRRWi9HZG5ma0UyUk1hVVVV?=
 =?utf-8?B?ekwxdG1UZ3JnWmI4NjlwRnNLeUFoTERTRHJLWnlyeEF6LzMyQTBvTExtdUZj?=
 =?utf-8?B?WXdXRkx2Z2tQanYyUzU1dkVaTDFtdDc5OXF0d3hXZ2Vma1FyQUp6SUVzYUg5?=
 =?utf-8?B?d0prMWZWbzZuUTJVbE9hQmZCYUNKeUFRMFVzZDlOLzRiN2QvNXlRUU1HTmt0?=
 =?utf-8?B?NktYN3RwQXY4ODdaVFhRWFRwN0dzYmt2SWNjZzRXdEtYLzJ4Q09BRzFaeTNJ?=
 =?utf-8?B?K1FrVngrWllNakhQb2Jyb1ZkWk1LdnpSWUdaSjdkRDRKQ0ZVczlyVHByS0p6?=
 =?utf-8?B?VjdGYUpJYVVPKzBvK0doQTQxVXVyWWg2WXVWVXhKYytEWlU1NE1JV09mN1Qw?=
 =?utf-8?B?bnhOYWl2b2tpTmxnWm5kV1BEV2tUMnMrbTVvcWJ6aTgxQTRWU1ZyKzJQUXZK?=
 =?utf-8?B?d0FlYUM1WGI0VjllWlNpRWJndDBsMEY4T00ycFk0OVRtOGliZUc4NXFIZkds?=
 =?utf-8?B?TkdOcUNlUkR4SVNhcUxlSFUvRFRUSXo0dUZWZFNaVjl1Y2FrR3dKeWRETzAy?=
 =?utf-8?B?REVaMCtYS2t4eE1weWFFWkFJTDJzZVkvYTFsckFsUHl5RkxPUytDS3RSQ2JY?=
 =?utf-8?B?aXE2eVFTbkZoU2R0RDJSWTl6Vk13Vm9nU3ZvbUdaMU5tS0RPK0J3bmo1RFRZ?=
 =?utf-8?B?NjBEVVcvaGR4ZUtQMGs2YWNrVmk3VDB4YUxvU3YwZlJvQnduYlJPdGN4Uk5w?=
 =?utf-8?B?SHFidXhwSHBEMnVwaVVNb2Ntc3VmdnZQNjQzcTlFeEprUTBxaUhsNFR4UWdS?=
 =?utf-8?B?cnZZb21ScGd2RkF1QmxWV0pNMnBRZDlsa2QxQllCYVE2NnhYUkpDbzBmaEho?=
 =?utf-8?B?bUFHYm43THdRSGlZQW1GalBGazRVdWlXZi82RnlVeGx3WTB2QVEyN1gxakFV?=
 =?utf-8?B?Q1VVUE1vY0tVZndPdjhCS0ZpaHdrSm50V0dncU9jS0pvSDhSbHl4MDY0OWlM?=
 =?utf-8?B?VDREQUJ0N1JpWWpHd0s4NlBQTThGbWdZNFdrRW9waG55RW1SMFBWV1p2ckZF?=
 =?utf-8?B?Y3Z2Q2Eza2RZbWxDeXZLNUFOaE10cDRnenhvNlM1TWprUWNrU3RMV2xCWXlw?=
 =?utf-8?B?aERuUmdxMGp2NTN0Mmk1SldTK3RRMStDUmNrS3R2bS9VR0tQbCtXS2RQcGUy?=
 =?utf-8?B?em5DRDlxMmVlTlUzSEFuYTRoUEw0M0hLSXFRZmNxbVN6S3ZnOHJZRS92UFEz?=
 =?utf-8?B?YmhFaDB1Yzkwdk9GYnBiSWlHQlJZMTNpUHNpUms0Q0JkeVFObUxqbStrV3ZK?=
 =?utf-8?B?Ty92RllBU0dYMC9rNzh4ODZnNjF1T3liOFVOaUN5RjBWeHBydmhoTHhySjYz?=
 =?utf-8?B?dGFJNFBQRXBWVE4rTGJNVHU0QUx4SlZzTFNFMmxrd21acEJIZG1la2NKQVNN?=
 =?utf-8?B?N0M3bnNMTnNGWE93Q3BrelVLU2xwYkhPMkxPZjNIK1o5NEdBRmZHTjZMcElD?=
 =?utf-8?B?eVgyTndMTU9iTy80WFVUZ2xXTlZMNXdsSjBGbnArdG1tMUI3Z2JVUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b09bd55-2dcd-4025-86ee-08df3c5bde47
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 23:15:38.0842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abaPu78A47VR4dahqzVNIuk3RowJLaD4HtT31aBOg7fvXaeF3JlkWDMUkGCDYf7eprPPPEoTmioDrqIDBoOgdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 2:52 PM, Danilo Krummrich wrote:
> On Fri Nov 6, 2026 at 9:51 PM CET, Timur Tabi wrote:
>> This tree is the future of rust-drm-next, and there have been some significant changes to
>> debugfs that result in a lot of merge conflicts.
> 
> I know what you mean, but just to avoid confusion for people new to the
> community: It's not exactly the future of drm-rust-next, but work that is
> targeting to land in drm-rust-next in the future.
> 
> As for this patch series, it sits on my list of patches to deal with (for
> probably too long). It also has been on the list for a couple of month now and I
> don't think it should be delayed further, so I'll pick this up after some smoke
> testing.
> 
This is great timing. I'm debugging something with Timur Tabi, and need
this functionality. Although "fortunately", I've also broken GSP booter
unload too, so logs are accidentally retained at the moment, haha. :)

Anyway, I've give this a quick test on that setup, and maybe can
provide a Tested-by, let's see.

thanks,
-- 
John Hubbard

