Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA081606A327
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=c4oBYiRq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9FEB10E605;
	Thu, 12 Nov 2026 13:12:28 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68A6B10E605
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 13:12:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7vnzo83exPKmKbAyxuhK3XkgBd5PR72bTa0ubae7qsqxwD9cng2f+F9cUEXLYDXSCVSaq7aw/zlwPUpkZxBpIPWwE3rfAGVQlZU9X4epVhGM+lYBsx8DnBds5EUjYmlfFVIUmCVU3tXkbOHBqcAfAu3gx4w43oUSLssl0gcTpYvvCwPSsMhrk3B4uh0wyQefwWZ1w7LeHOAnbRHvR5k4PWbHVsMaR+QJYYZelbXtNtBIIwZkCJ9QlFHcp5Mz/xD5euoYcTSg1ICYzKCis9lyWXQ/52u0hweOVCYYdd8YrsQFKCaIw8XQ5mEA/Z+LdINnpRZgj2SAgZcfYQDXtwvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIPKa+rnVbXWfXcagFPPXqR1Z+z/g+/v8fb/mOBzu+s=;
 b=KWers/eO/EWmbJlKQWXFI//JWS4Vts36L7ORkARXtfc3mJYHg4eG8cG9ywXm8/0kyYQKzntcgOTkXoAztDFwvfXe7IcRbhzLSczktcX31OB3I9FZyYaiJyym8OeMrxhAL/IxhRDGMZf3N+aSgdk/SRzgLIeKIH3UaxldHPYhg+LLa06w+KBvPkNJVRkMZucOujvGc5/tN8UDHTKBQurs38/6nrWOT2tIzFBhXAhSRN4jCh/iUpeU0ZAK8ijvR1JBE+jmBc8iWgHX78g4Apcfkakw9vvIXkbk2dWWwOsGw18yDVmS37bO3l3d05sq+aj1IC/Dbfvl+N2wtxGJR438/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIPKa+rnVbXWfXcagFPPXqR1Z+z/g+/v8fb/mOBzu+s=;
 b=c4oBYiRqINfEpfCn+vLCISFr2Tq2SlTWiflkJ6aVN8OriVGeTHWuJ8T4Cp/HSs02buszsbd0zwcJyTU+oXeHlU33zoJy1DnP85E119ImLXy2qt1t2WEZNYcbJo3mo2obdD4uB95X8rjrn5BQLxOMDoV9EGp4hqEmjaXEL8P7Rg8rLqbciUgDZ0hxV6FeV2OD7yRwfPZBkKZMoJpUtPgeUfxMekRpxqdvOpqAoqoXGI+yNTYTbWCioWycKYEZMWHtpRK1wusKkzDwYe862hZurxGE6nzAOqW4GxvEAIjUdLeJeBEMcNFl6LNIv30pK8GhJUklOzcH2b/kxkC9dVy7QA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 13:12:18 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Thu, 12 Nov 2026
 13:12:11 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Eliot Courtney <ecourtney@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261112-msgq-64-pages-v2-0-bc1e6f7301ca@nvidia.com>
References: <20261112-msgq-64-pages-v2-0-bc1e6f7301ca@nvidia.com>
Subject: Re: [PATCH v2 0/2] gpu: nova-core: gsp: fix misc cmdq issues
Message-Id: <179448889802.1805213.17351857583595993113.b4-ty@b4>
Date: Thu, 12 Nov 2026 22:08:18 +0900
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4P301CA0039.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::14) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 2809ed9c-fc2f-4d19-d6ad-08df40be9008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|23010399003|22082099003|18002099003|261009223027099003|11063799006|56012099006|260925021911599003|260925021311599003|260925022911599003|10067099003;
X-Microsoft-Antispam-Message-Info: 8BShU/IILnegkkJy7DcuA4Wc/Wf/6EgfetGXgQgfdypekajS7Va5oWupA6dpVrOBP8Mfek/UVCpbJfdfRKM41wdR6oRLGqLWsWcHmUr/tAfcoz7woZAHzBmhfA7tep99GA4udywnyD0/HIhjA36suRxK2vuUjtWnm3r2ualxopuP4Av1wFmmq9vOjzdW7ts926zqb6eiK+XgOJ7T9FD7I/Dtnc4WZkTgb9J/jAdfEXDbw0zbU3SN4pHfa1oaDKhGuDslqhGrI6Fk7wh1qudSfrAmZiF9Nhj3jhTQN5MTrGDzF7EhK5qfxBAwScqi7ruVcRRJfe2oWFaidVoruZXULX8KOeaeeqwIAxYZd8D4VFbr9s2MVRodU8snQIF6OgxgInLMYrWLU7+oDL/HFpRkyLPnPJ691yWqR/I9dqAIf98YPXFj+K532tkGWwGqVI5kT2rB0WG2LNoMNlh/KjQPGXkdvapgjKzPkFGMgnBDWuiSxC8tWk+GHlB4YzjlTOfH/rYaY66cE8tW9ppeEIKYNEDe67DukhA0qrdcRtZuoEcYHs4VvkGBwBYnh1bhsbp0JrJ2gRCLuZKgH1ck/LsDdRMxogGUvq8fw3riTZ9kkftM0ZUF+xOSS/Zpn3+EM/FaEo7hVNcP23pmO1iwSSoQSlF1wQApiD5mvZZK7rZCd1Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(260925021911599003)(260925021311599003)(260925022911599003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YS9IU3BmSnZ4eFhack9vK3ZRdTRVY1ZUVXZldUJaSGZBd0YyTjRxL0FrZ243?=
 =?utf-8?B?MUhZaVVQS2ZyL2swQjRiWmNqTk9pZkR5M3YzcnpiQnl5akZHRGVIL04ySi9p?=
 =?utf-8?B?ZTVmUEx5RU5xRGRNZ3VIOTYreXp1bCtWN1RMNHRaZzN4Q2pNOUJKaE9XdVZO?=
 =?utf-8?B?TnkxNDZYNDl2c1laSnZ4bE1ycEcwbU9BZEhKSmUyWEF6citDaDBUV3NXSDBL?=
 =?utf-8?B?ekxyQ2p5ekJJZlRpQzJKUTZjVHR4empGSURZSkxYS0RwNFBFaU9JR2RPU3BZ?=
 =?utf-8?B?Um9hYzZyc1ZUbkIwVmh6R0pOZWFmZGdqc2ZpVHZONVJWeFg2M1JTdzZ4OGlL?=
 =?utf-8?B?bXR2S2tyaVdjcUt4UDFUaGJZSVFVS05VVEkxTVk1VVdyLzRuaHlxZHBHR1Ja?=
 =?utf-8?B?SktnV1dySjdwcllGR29KTnAvRzIzajFNOVBwbEVhWS9MQjlUV3VxRnlIL0Zp?=
 =?utf-8?B?MXNmRUFieEdTYWhKcDFyelhhU3ZmcFRDTnJFZGdIWkc3eXVCQ1VhSm9ydTVD?=
 =?utf-8?B?MkkrdzhsKzhRM2FMMys1QWVUWjF6QVlVL3hISURsaDB4UndtVnl1WHdBVGV6?=
 =?utf-8?B?QmdhZ3FiTXhEbnRwZmdKWlpkdUxPSk5mNmIwSzI5L3g5ckJVN1J2R3dYL2Za?=
 =?utf-8?B?cThIQjZmWWxmMC9SQzcwMGY0MytEeGVRTFhWeWFIRklJaXY4c3NCZ2ZLdmQr?=
 =?utf-8?B?NlEwd2REbzNxK0VscFBKNGt3SWpoWGxpTERRTTQyK0s2YUZJeThBRHdLN1JK?=
 =?utf-8?B?Wldub1BoVlRyTktkTTlLQVI0SGk3TGp6WHRGQ2VpMGo1cWEyeHpWSWNJSG1H?=
 =?utf-8?B?VVc1c2xQSXIzUWlEcFV4RCttbHJ1ZlNKVHhmWldxcFdWQjNPcEJ1ZXNwYStp?=
 =?utf-8?B?RU91S0ErWjZWbHlnMUtWeEVBd2pBRmhFVDhMWlU0UXkyOWh1OHhicmZpL3Bk?=
 =?utf-8?B?M1dON2xzSDhtSFZsdHkraytON2I4bE8zNnZrb2tKTHpmK2FNOFIrMEppY0d5?=
 =?utf-8?B?MERQV0ZsRTJuWHhraFQ1a1E4ZlE5OUdmbUViMEIwRDBPdk45YnQvT1JhNW9H?=
 =?utf-8?B?UTRKOHRxaVdvMWMwQmJCL3p2T0xYaG56V3JVY0Qxa0haZmZnVWQ3VjhUQlBR?=
 =?utf-8?B?azB6b1FaVjJZUU5kR050elRoc3ZJNU16YkM0ZkJHWVF4RzhKYVk0TmIvYXVa?=
 =?utf-8?B?K0FuRG9Nd2Z5QlJvWWdrTkcrK01hQ3ZPdlM4YzgxbHV2YTdZZWZkT0l2Kzlu?=
 =?utf-8?B?dzNYdjFjRVNqVVVsYlBMVkdWQ1FZSU11WHR0OS9yNWpCYnZrTVNFRTl1cjE3?=
 =?utf-8?B?R3crNE9LYjFmRCtETlc2M2N5ZE5Jc3IwMHl5NWpvRlhRbXpZdTlPaHZLeW9D?=
 =?utf-8?B?SVFCUVNpbm9iUmpBNUVERHpScW5lQzB2d2pybGVlUXRHNStPMG8rNkNSN1ZB?=
 =?utf-8?B?QVNQazFFc00xbU9kWWpLdVF0cTN1NUxsK2JGQ0p1MExmOFdrQUU3bHdiUkxm?=
 =?utf-8?B?NWYwWGMyTngzMkc1aE5iK2t0dk1KdEVIVGhYZkJUOU1QQ0xZT21oVkx4aEZ1?=
 =?utf-8?B?Skd1dlhIcU9XdTJmMjJBdEtnY3VxUXRGUGxzWnBoWVFFOTdKQllOQzJNNVFm?=
 =?utf-8?B?Q2hVcDU5QmExd1RuZEh2d3NyclFZUHVNbFgwTjIyRTFtbVFhMXJOK0VoLzNY?=
 =?utf-8?B?VEJoOGUyVUNKZW9LTVc4cnB1YzU3cFR6N3dRTEFESnBIaUZMZnAvYkxLMmhq?=
 =?utf-8?B?K2tzNWVKRWFEczA0c2l2cTVqcWJDSXJ1Q1BhcEl4R2Y2S0tkYi9NQSszVzZs?=
 =?utf-8?B?R2RGZFY4aDR5UDI5L25GWE14SVFFTmM5TU9BL2MzZWdVeE4vTGthczB4RklH?=
 =?utf-8?B?RjFsOVBDTk5RVDdmK3dENEhqb21vR3NDYkFpd0t6QmlPNWlTaDIxVTdsbmpq?=
 =?utf-8?B?UjJGdXpjaG9Xc2ovWFhNQ3hOMUFMMzFXM2FjajE4VGl4MnczR1BXS0V0RHJq?=
 =?utf-8?B?TjFKNVdBQmJLTUd6bStSU2JjYkRSVGptL2FWM2ZCWWNJRk1oUlQ3UGlKcXpT?=
 =?utf-8?B?RWlqQ05VK3IwSFo1Q0s0eHJXaFNRbUFvZDVJTGI1V2x0SFJFWGY4RkNoZElD?=
 =?utf-8?B?TXRoUy9JcUFlZVpwTmE2SSs5Y1BucWFjTENQWlExaHB1eTgyR1gydjNkMFly?=
 =?utf-8?B?QWs0SWdLUHNOWUY4K0JSeGtNYzdFZmdkcDU0RG40ZGcwZGpuQ0VJbldKTWht?=
 =?utf-8?B?cXZBZjl1TFJhY2RCVXROU1hyRDdYNUZXZTB6V3kyc25TTWtnS0FEUzBCUmlx?=
 =?utf-8?B?TWlRTjRsYmNydUdBS251WDBHYVlSRXBCVEg2cytvdy9qOWlYZWhKUkJETGNp?=
 =?utf-8?Q?m33/bWO1GwrkGrjRtP6JwueE/BtEzRR6A/dFY6yABHSUN?=
X-MS-Exchange-AntiSpam-MessageData-1: OAweDB2Sq4ko+w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2809ed9c-fc2f-4d19-d6ad-08df40be9008
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 13:12:11.6296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JiBtA63RzV5xRa92UlCswfu6/I3lo5/Kk7MXMteQwIjDHlyRlClb/K//DR214JIyW3jBrABbN+AzhhGX96n+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 15:14:52 +0900, Eliot Courtney wrote:
> Fix two cmdq issues.
> 
> This is based on drm-rust-next.

Applied to drm-rust-next, thanks!

[1/2] gpu: nova-core: gsp: cmdq: wrap the sequence number on overflow
      commit: 75c25f42536d91fcabd6042dd8872400601f4f7c
[2/2] gpu: nova-core: gsp: cmdq: increase MSGQ_NUM_PAGES to 64
      commit: 0ff9e5b9ff6736c37593cd7db89f4593ec4f8e86
