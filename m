Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A651E606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ABS/Ul4p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B15F10EB7E;
	Tue, 20 Oct 2026 10:13:44 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012043.outbound.protection.outlook.com [40.107.209.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4CA710EB7E;
 Tue, 20 Oct 2026 10:13:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuOeqAlt1mIVk+K9c5Gcjoiin2/E8KQLYNofOQF49//1zFF6RXNhgLKjoRPqOmpgA1m41tveAmgHzOBkWf9oks/czruKCEiRH4++rbTrATMLFzp7+58K36AksMtvmryWUw6cTq/eNcZYJjSeUuO81fqrSnx0YA3QPR32YhbDNmeo+42Ye9LtYc06yW/mGDK35Fq8tzSRLlNqsvY9M4C9ENxUSlKnzPdZ66Z8tvZ3xsevz1n39QJgRkerzmdvpqkFW+dyId0zvaacJ4LvHO2gKtWEo6NvsbXnGHJ+N3k2rVf4mwaGWbQFfxZhcT0yD2zpLzb1UJAtsTPshs9jO3VJfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSdWO0XhFJu/bA2TkcTRLNapIIOpUbLGNWev43bIqo4=;
 b=ecr8JvHOaB+FJUrlUdBFrAh39cgld01qUlAO5gn/jk2uW8mhrCFtp1pnOKqPRFlJ6E60XaNtdzgGcIulksQLs1V/gcSxZwVKzpDfvTG5W3Nk9owfdJylexC0rPLWEdkSsZ3QOn9vPYun3YUY/jWqsSbEV6CD6+awptQ4z+kgk7LoyR5ABkJpRN//jE1aqYc/LaTq/lHyKrrFK/XVTeEjyiQY+EOUrBcTzGihbaBioFkdILq5cwHwqteaeRkb73JOFE754kmn9xt4wrpsNswtrnlCAGJv0ey4/KatE8mZWaVxlj1YYxt5S+Ek0j4Ph1zPxLdG3IC5AZZN3WjdolZISQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSdWO0XhFJu/bA2TkcTRLNapIIOpUbLGNWev43bIqo4=;
 b=ABS/Ul4pDVFiskVGW2Lax2zikGle9KLPWs5YvkykjYPXgRl96YT6J5fHGI01EJ3jxs8V7Lvb0z6mKSFNQXsxxduvRUDO1LKmRRc2kyoIJ6i90U8H+uD6PeAIDtQkuL3O42/iBLuWVI2HVIdgX5/JEM9+/DxnVVDU5Yu5CKJ5MzcNGCRRFwywYLPnwWP6TdDWz6ZtEsOBFThLlmxkttED1cmg1Pk1/u3x0SCGZkpYWIbf9EtavYv+hsOFCGRiSKlO4masjXbZlYZ9nbKOHY52ukdSTkVysJzI3Ie3LKwQac6vHCt/b/oPB5ftlHfXbBSPLKKlbPk2dNoW7K+dYhjxlg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 10:13:34 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 10:13:34 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 19:13:32 +0900
Message-Id: <DM9L3QYY9Y27.WM0G66X0Y8PG@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 06/10] gpu: nova-core: gsp: cmdq: move RPC message
 logging to RpcMessage
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20261009-cmdq-rpc-v4-0-c9ab8de1d3f2@nvidia.com>
 <20261009-cmdq-rpc-v4-6-c9ab8de1d3f2@nvidia.com>
 <DM46C72WC4G9.FRMU9QSIS1SE@nvidia.com>
 <DM5GBX7ULZFR.2TT17DYNN2UCL@nvidia.com>
In-Reply-To: <DM5GBX7ULZFR.2TT17DYNN2UCL@nvidia.com>
X-ClientProxiedBy: TY6PR01CA0032.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::8) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: c442fc35-b5a1-4359-be85-08df2e92ccae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|10070799003|1800799024|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ByfpVMhLPintPBqc1yCCNxWLyCCWuLYRC6GstT5KvLumKNBGJ68UFD6bXT9brHXx8kkBMeKCaVA0D48rKtjdJW3LydBOQboLeyh1JFNxjHpcY/KDlhhyTuxbDRLAvJziSOY2mj14MVmOtDu00nVGWozMQlMxm9dVOhGSerGVmgfQ3xPpQaXaEXf1uwOdO8bDuyZpL2HfJ3nXUBn68t7oLRIxGH30opJt5/74dKamjGxvcM5dWphOAwAEa/rzckpVuYYTz3Xq/9CFiTmvrt3ARCa1nxTpCUo51vUNw2Pwr9WP6QZYm31+qILnGethIWB+1WhEOatqagZXjBF4OSgSgkPG0xHrEponqJMwam4n2ngFJSkaGVYuc2w3nI2Qnlx+4Z2/uy1WzjAkunWH87STY9tpVbFnJSaVA19yJjKVJatmtFcYmFisRzEqk8nt4MTuzNMV2HbsALOezulnoIQ/K1XTfe7PqfSaSHzQTRFQGQKF9qQsBTQAemgZOlTHK/IjX5z8/yJg0rBtiPfyGDDjj9CihhCwKPsbXgzgFgdQ9VaMnA/fCaQDxDpy65mu72yzhqCQeL7N9JPK3fbU4BNOETPyRgRQg2iafIz9MWAcRMMS1Xg1QPEq0RfRIhTf0qVa09aBgxJ/Ggj11i2pePvyocY3IRxVrRILgq2vg87S9M8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(10070799003)(1800799024)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1pvZHdrR0VaKzBjMTgvQVlnUGx3aCtPWG11V3NGMDg0azZxWlM4T25aeFQ0?=
 =?utf-8?B?MVNMS09zLzVXSUJIWkdwOGZvUU1GRUFldU9sN2xOS0ZPeWU4a2dnMzRvb1dN?=
 =?utf-8?B?Q012UFhyYlZhR3lnUGQxVG1CTFh5TDFjRjJ6NUhBd0Z1Y05qbG1FODgxci9h?=
 =?utf-8?B?UE5hb0J1T1kzWTEwWW1mR0tpeDh0c01BLzJUMFVlQzlHOE41NFlvQjZJNDND?=
 =?utf-8?B?RHRMUU0rdEd1TmQ0dlVKdVhEN3A4Y0EwRFFkZXFaa0ZqaGtXbVpoUmFuaEhh?=
 =?utf-8?B?VS9DN1I2b09pMXN0WVVxRk1VWkY1Mk5mNjNGS3E5Nkk3ZkRlRGd5QmlDS3NE?=
 =?utf-8?B?NEVmT2VzM2V1Y0FhNHZmL1k2WnVqazJuUnhROWwxNnY3VHBOd1E4MUtuK2Fv?=
 =?utf-8?B?R0RaWUFCVVN5aFlhYVAvL3pjNGZ0VHBmN2l3NDNiT3ovdUlzU1pnbll5Z1hL?=
 =?utf-8?B?ZnRPaTJVTTM5Tk1kb3lnRmZTYmRJSGlwY1IwcGkzQ0xKNHNkY3pTb0QzdGhJ?=
 =?utf-8?B?eWxNVnRBWmxkSU81ZEQ2b3ZTZTdVZ1BxaDVza0tsa015TzFJNE9jenNsT2dw?=
 =?utf-8?B?V2N6NktPSnoyMEtWVFVtNmpVTUs4Nzg0QUJIdjVuY0dwSk1rUHFNczF3VnRN?=
 =?utf-8?B?VmV6RGtpejFzK3V0RzhYR0h1NXRQdmEzS2NoWnlrdWtFdjlHMW5uTXVKQlpW?=
 =?utf-8?B?OGVOMjBrYVp5UHVqbHdtbU5mMCtqL1RxWk16MDU3aGZNN1VYa2pDaEl4ODVs?=
 =?utf-8?B?WENsbUtDaDV3MzdNOTRTRlNGLzdFcnc4V3grOXE1Y3pSVGpqSjlwM2laSVhv?=
 =?utf-8?B?VkJxekZOcmlsODBvR0I3SzduUlh3SzJCOWtoMnpPQjBYQ1MybXo2V0dFREFR?=
 =?utf-8?B?MEtja054SWVHQkdaaXhBRXNuWTh2T0N4UTMzT3NiNkdMOElYQUZaa3NweDlW?=
 =?utf-8?B?eWd0RlBMZWxPYVRmWGZKQytQQTNaRlgrOXZCMUtISmJMRnFHOXFodkdzclhR?=
 =?utf-8?B?ODZkS2QzY1ljcnh0eStEREFHenpzN2tYT0tVUE5XNzRHQVA3SXVxTW5UdHdR?=
 =?utf-8?B?bkh4SGRDUklSS0x2VUloczhOUm4xcXErYzJRcGNoTlBFV2puOFpMSzlhTlNo?=
 =?utf-8?B?TmZXejBqVTIwVGExNDIyd2NHNmJUeHBKcWhIRmZtV0t6b3Rob1Y3MVpFWHZD?=
 =?utf-8?B?OWZMSWdRaUs3SGZsdllxSjVXNXI4VWFIVXV5ZWNsTlVYNkNaT0VmalFWckFj?=
 =?utf-8?B?L2ZuVjZENWNjbkNzc2lCZUR6T25acWJrbEgzRzlVbzFnM1M4UElwanhNOU5I?=
 =?utf-8?B?ZkNGN1N2WEs0b0o2UVBjNzdGRDZLaEdZOVZuNEswMXJyYklHd3JKVTVzbzNk?=
 =?utf-8?B?TWErKzRMZk4rOHUyMENCdnI4K1AzVlZleDRTWU45dVpuYXpSWlFqV04vcTV5?=
 =?utf-8?B?dGZ5VkNuSktQV2pnbjVTK29QcE5DSFBnZHpCL1Y4Q09Gd0pxQW5CVndEcEdG?=
 =?utf-8?B?ZEZQaFFRS25rTHNUQlp0amZmdnhveDlRYm0raUJpa0F4NmhEYXNyMGJ2dnBW?=
 =?utf-8?B?VzZrbjljZG9FZDRTdjV4M2NCN3J4K1FJdFZRanZsKzNtaFlONnlwMk1SRGVY?=
 =?utf-8?B?cjhCRm9sSWNtZndqN1R0cEZIWUhnUEhLdi9TZkZqRlJMSmFCNGdCUWRmQ1Ay?=
 =?utf-8?B?V0hFNU9IaDBNS2NYM2xHeEpScXVFU0J5ejUwSDFJVitTd0xLZUxrMm1xRGdn?=
 =?utf-8?B?UDNmZGc5WWlFd0pMMWs3ZnBQSnpNL0FVK2doYXlRdExRMnQzWGtsdVFYMG1p?=
 =?utf-8?B?Sy9qeko5UnBVaWYyYWozSTFxQnU4UjVqaXJrc285WmhRbUw0cWxGSU92dUhq?=
 =?utf-8?B?VGxMclNJSkd3b3I3TzVadGdKTmxVVWMwWk5NUHFNUFFCeGlZR09mQ1c5RUpq?=
 =?utf-8?B?VzFtOTd3U0kzUU9yVEpzSkxmUHFuazkzdThjNEJZRnp6UWp0RlB2MHh5QWQ0?=
 =?utf-8?B?aDJSWWc3ZUNKZXZtTkc2L1N0ZHVTNEkwQ3ZvdndHa0MyRUVGcStWOUlvY3pP?=
 =?utf-8?B?bm1hMG5mc3NXekgvOFk5VXM4UmtjTFhNSmx4VnVuZi9wU2xWVS9MOWFVOWd1?=
 =?utf-8?B?L0hqQ1Y2UlROSVNIRng2WUJuMHI0WEp5NXhrTE8zZXJ0WVRDNG5KZlNqQUZh?=
 =?utf-8?B?VlJ5Y3JGb2tTYy9GRTRGQkh1L1lGd2ZabGJ4YVl4NG9uKzhpT1dVdDhFZVRF?=
 =?utf-8?B?bUZEV0VNVkh2aDRQRGdIRHNzb2NSendVUC9iMDBpK3dlYWJRcy9yakJ0NE1R?=
 =?utf-8?B?NUVqekdhVjVPbWJiOG9TclZDQ3MrSS9neUxtcTJTSjhQdjBoRU45ZkZaWjRM?=
 =?utf-8?Q?L601gjm6Fj/Yk6tQGMoKOrRSIxC2c9nc9R7iZpUPSllzc?=
X-MS-Exchange-AntiSpam-MessageData-1: jMRpdgx283FaLg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c442fc35-b5a1-4359-be85-08df2e92ccae
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:13:34.5291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHwFNDhqFgyiLWZt5Ymc+hrPO7F7QAsYo62uyiKMsWXmmTQeATKDOljGWVkKg4vw1swe+NhF58V6rMvb9sfoRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862
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

On Thu Oct 15, 2026 at 10:38 PM JST, Alexandre Courbot wrote:
> On Wed Oct 14, 2026 at 10:35 AM JST, Eliot Courtney wrote:
>> On Fri Oct 9, 2026 at 8:54 PM JST, Alexandre Courbot wrote:
>>> The `RpcMessage` type is the right container for the `log_event` method=
,
>>> since it contains all the data we passed to it. Move it there so caller=
s
>>> don't need to extract the required data themselves.
>>>
>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>> ---
>> [...]
>>> -            let function =3D rpc_msg.header.function();
>>> -            let seq =3D rpc_msg.header.sequence();
>>> +
>>> +            RpcMessage::parse(self.dev, msg)?.log(self.dev);
>>
>> nit: in core/interrupts.rst we say:
>>
>> ``` A drain fails when a message's framing or checksum is bad (see
>> "Draining the GSP-to-CPU queue"). The message stays at the queue head,
>> so every later drain would fail the same way, and the IRQ thread
>> disables vector 155 and logs the failure, which leaves the queue
>> unserviced until the device is reset. ```
>>
>> So `parse()?` returning early on failure here is intentional, but I
>> reckon it is worth a comment, especially since the behaviour is
>> different to the semantics for consuming elements regularly (still
>> consumes and progresses for failed elements). Especially since you
>> wouldn't expect this behaviour to differ for a method which explicitly
>> "consumes every message the queue holds".
>
> Sure, I'll add a comment.

The inconsistency in dropping behavior between `drain` and `await_msg`
really bothered me, so I've spent more time than I should have reworking
that to harmonize the two. As a result v5 has changed a bit more than I
wanted, but hopefully it's for the better.
