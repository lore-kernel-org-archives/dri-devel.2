Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D995CDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 00:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72A5210E110;
	Tue, 23 Jun 2026 00:23:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="uPyATvdU";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC6CE10E110
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 00:23:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=othlDCYtWxJ76A3fEx526kC3/AFTpTJfERDsYcZjs4Fec8s34Gbb8fjFYisg3yRbKCd0cI8a4lW5eGpGlISd20rzN6IoYDzTaMsu11k/MKBHFSUlIaVkkLGO2Hew4rqwD+1Z728/qMY67L0QWLznVyGlGhAp8WGNO/d03vadRepLnO7wHShL7KMNINIjhxLNyaKKMXnUDd10gCkdxW29+iKW2AvBGV3gsYN/X4aGC1rjWB9QucD3+oaxz9fP0b6hmljUOeqrCAIFiebKVWUDQC8cla2jCaYngOD398Mx4hYkj2OCOAhKrX7bXZr1UUmrqg6x4F1WH0RZBmjtkDZzWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1TEslRMmGmkzSbxUGGkI7y5QRI755Wvt8G+3jNMVNA=;
 b=DXkmW6qRvfJqwDh/NoHv/ZJBzkoRvwJqQf/0D4Sa3ciMZIeVxMoqxSixN4cr36a+Muq3R/tDNCPlX4fgjtMGFiGcc3bUb6y82zI1QXtrw+fML4Y1Q3gfZH/KDnEYrbs0J0THQRyOkNQZ5e/N1nN3783Y3X2IvuyovQCWL9HAXe2uZYdlQNowaDt2VlPlfY/uXubqQUqDhoYLWmjtvKnhlCgAfAo18JKsxpvmyQOw3hjwAXZUcogi5fo4z8MBUdQ438EPTVZnt9KitfArqOx9ikdBagGZHN28DOwHuBFmLDokbW2ZrYE8No3z6tdEBLt2rPPDX+JDDuMbv3Okkk4LzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1TEslRMmGmkzSbxUGGkI7y5QRI755Wvt8G+3jNMVNA=;
 b=uPyATvdUFkuN4Te3c/40HHUIR137syAklEbZ8IpwSPI2yW626xByc4xVkcfSrjysuhymmy5w9qvU840Ep3Y5pwPhkWcAef87SQoiRP69Jv9CDMDR5iIBlC4oTSNVg92cjFDFOtWh1fY8jUMRxDvcyialVwss+fhPAAjiGrFFiTGZ9Ai4MK6Vmkuh/rro6Gb3NJzUhvDqMzmve0QIX2fuqSRgnyk4PNifdq6BHP8fk4UAcAWwZP9yWqqpFxem4SZoPkwJS+2XxNdpe48GB2KTCkQpsCr5Ep1dVF1ZkqUkso7HcsoRhAIohYbdtQmW8HnfzcRC39BCmIjbXi+YE9d81Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BN5PR12MB9486.namprd12.prod.outlook.com (2603:10b6:408:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 00:23:07 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 00:23:07 +0000
Date: Tue, 23 Jun 2026 10:23:01 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: =?utf-8?Q?Nicol=C3=A1s?= Antinori <nico.antinori.7@gmail.com>, 
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>,
 Gary Guo <gary@garyguo.net>, 
 Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>,
 Tamir Duberstein <tamird@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
 linux-kernel-mentees@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev
Subject: Re: [PATCH] gpu: nova-core: parse structs via zerocopy
Message-ID: <ajnPpyQcirSDIZTu@nvdebian.thelocal>
References: <20260621143647.264770-1-nico.antinori.7@gmail.com>
 <ajjj1yyMcrCA8H19@nvdebian.thelocal>
 <DJFUZJYZHOT1.M74T83PJE8GM@gmail.com>
 <DJFVRMR67B0W.2AJBHU1PWDPFT@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DJFVRMR67B0W.2AJBHU1PWDPFT@kernel.org>
X-ClientProxiedBy: SY8P282CA0023.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:29b::33) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BN5PR12MB9486:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca592a7-7bb0-44c9-f227-08ded0bd98ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|22082099003|18002099003|56012099006|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: y2gePKfxsebOnxrf7k8InCgzXnRRPBiCQ5+tzNXr7wCkfUnoLhANyGuQ61CWzUA0MGDqW9YM47dP1pKgRJb+WreIX3KPJH6vwj40/bsBvoxHTi897UCNaYaQQhJIfvG3XN9Mn+UZyJjVtAS5H4XCw6J3PXnfraOuHATR7HJGk0xBhVLO7G+KyywYz0G2huK/3vXiOsVGfFnW+qZZJsu/BkhYMp773hc2r7KklkVixT7cfGBwtSPzDSbEbLCG6l+OU35ZniacTgOvRsdde+Mp1DC+4ceOHndO+qD9G3dknGh/Lg/aS79bpCGb6dBDbwP5JdCmNjtshwrvDP4YZOBO8jF53US2PDWAbbNwWtOa/+8YIsQNdRnM1R7q5O0TG/gMrtUjsRubmpSMPuWHBExy8xddcZNpfY4FGMSGlfZYHtBIYez6jBK6CsU4HgcpHV3+NegVriTBCNJQkC11LUHmn8x5siwVQJQwr+Nq2ApNU5aEpIivlRP9U+rDHxQ4PKCrhMzi8TLgSyEZyRdf9WhCuxhivYqXAOgAZlFCksnojsmgUkTuxWmIRqqBC24n76JyzN7nz0RI69J6neg8OaR/zPbGyH6DwnYtAZz0Zr5OWBrlo1CMZtzMnI2T1q0sytNtY/euHJ1wf6Q44xd7idbxkzSZBePHUbw/MereXJr606Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?EZH1hRUhW79d0TcFdZqqUZZLA2et3IhHo1bLOVN6U87kg6YhR8Eesd//Um?=
 =?iso-8859-1?Q?e4PQvwWHA0AbKzL67dFBBu0aAgyjkGR2ZZB/M6yYjMZAcqFcg4p97w+JEI?=
 =?iso-8859-1?Q?CkVDZEmOfV0d5ruU0sqVP00MkMNMa9EDdhMpUXou7MQrLDZdTlxCKAf3s5?=
 =?iso-8859-1?Q?N3ez9/PQTgQoON5uRAA6gscHkyTIC/EAH3/t/vL1YNcy1SICU+NsCr3SqM?=
 =?iso-8859-1?Q?lt3Ms/JCsIg/G9hL4GXbciJbrayNB2V7AXgUmxEBz9J70xXZw2djxOP5wM?=
 =?iso-8859-1?Q?9DGe8DVnMEe8G9/ZIBDqh1uxHzGLTSycRcMvbYXtsDh1QsyGSPd9zcIDft?=
 =?iso-8859-1?Q?/mC/ewa6MuN+n7F869eznVpagC6KeU7eIZbYkCK0NC5ir6LhPUXNew+EDv?=
 =?iso-8859-1?Q?jPGrX257QsgMe6pDTX627Y+sAo80glAgL3zGaFzYqEUdTDxcC0lCiozLdd?=
 =?iso-8859-1?Q?DgSWnHoLsnGxmEB0l5idPijfYuNou+X2OWaBNldBM0XW6p/8wfantjMjC8?=
 =?iso-8859-1?Q?DlaY7BfMk/OrfGh8Yg6//pDFU4slK95YAZwMRDmLnEYk6eVzigqMZo3FCt?=
 =?iso-8859-1?Q?u+kz9kWIGAlT8xsscXx1axObxAlhUB1Gixd+xWh7su5j5BKyR/WH1QVDlY?=
 =?iso-8859-1?Q?kht0uwhpvgmR7ZGM0eAN7JISdnFQfb9NF9dJI/jH0AwSucVqe/Q3mfS7cF?=
 =?iso-8859-1?Q?DCIwRPa/DjrBc/uSxi8dgvDzS5919xPPddwV4sBTVj9tqGX8XCgDhHli93?=
 =?iso-8859-1?Q?HyKDREfsX5MHS68U3zYAQYI8P40JyVx9lhhJf7BlSfsEza5Y/rkHt8BXtQ?=
 =?iso-8859-1?Q?6qPMCfDKdw4qeMOs/G1UnwjELqILcdLRKeQcIUUfejLtxgpVZqhZzb+NiT?=
 =?iso-8859-1?Q?p4aTEhf5kwOyr+GcmJ9xtY0MhMNgTltauTfjBSIKwC/kPfSrnL4l8fyZS1?=
 =?iso-8859-1?Q?6/vQFaXLaCU39ndHhODljpanld82R7wQjaRwXgwFz0A2WRTjcynGD9QVp8?=
 =?iso-8859-1?Q?jx8EcPeB4CwxjKm1EwNv/glGjkLyFLVujXO9kz6K2PZpJ8x++x1b5TvJc0?=
 =?iso-8859-1?Q?QQMsv7TUe6fs8MIkB+qMgoDNeZkhNj7qntesiQb1BsSKS0fTVQc1DKCcy8?=
 =?iso-8859-1?Q?KdbriXoOrnHCySYoq/4gmNZ9Ux/Ggbrlh6ECf5MyKvdLlO7Gh6QnCGpGZt?=
 =?iso-8859-1?Q?o65SqxOGZxJlmbg+WhiUBwJUpolfpC9WeFBu31Vw8XM6QvNZ5DePsr3bXd?=
 =?iso-8859-1?Q?8L+MkppABfKjqCzUdrI3/n2b7nthvJ6F8nF1FKQZuVvVfttv24AhqS2ni5?=
 =?iso-8859-1?Q?SYG+Dm0NL756t//zoVu7vuR1jkv/3+5/reN4m93pIjsMISzxCF976xV1lN?=
 =?iso-8859-1?Q?3IFGJtRAzf51ZnxElLfgGeVmsEz7V0AmC6alIdofk9//cGUaG1B3DrB0Ob?=
 =?iso-8859-1?Q?pn7K78+DfCP12bXJppwMzvfSObCnMKqo/WlKmqhIq2GCAc+a3NTD5nX9QM?=
 =?iso-8859-1?Q?cdp11HhhTLHSQlvucH/HNmIpuwAhkjCVRtmzrtBB+Rlslo+cwsUDpNHG00?=
 =?iso-8859-1?Q?0ogBZ9qtO/FSkz+o5fA95a7ZSVoAwhI8UIFj2MMd6/kxFvg9dpXZbrTHky?=
 =?iso-8859-1?Q?Si3gmpUWKeu+i8n01U/VSSpPAUoN+BnTyHZmg3AyoSIfTh8vnqaiaxp7OP?=
 =?iso-8859-1?Q?UpbC52Dbgbiwo6EavYM56fdZFaEYynRlmSA5w1kxCnPTTtIDSI+FVTnGE0?=
 =?iso-8859-1?Q?CoYddciIBqUAIKf2qZIo5el7PSfEajzn3dYgCpiYjYH9wHb5dg8ph+S3LI?=
 =?iso-8859-1?Q?ry8o+pAxoA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca592a7-7bb0-44c9-f227-08ded0bd98ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 00:23:06.9549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNOLOoAxMMwFjq5+NRFWS12m25pheUZ5xcSxN+d9SWgvqxFCnt1qy7ie7J5BZNqn5plWJW18ahSaZszW9sDcZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9486
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

On 2026-06-23 at 07:02 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Mon Jun 22, 2026 at 10:26 PM CEST, Nicolás Antinori wrote:
> > I did my work on rust-next [1] because drm-rust-next does not have the
> > zerocopy crate present yet [2]. linux-next contains both zerocopy [3] 
> > and the new users of transmute::FromBytes if I am not mistaken (BitToken,
> > PciRomHeader, and PmuLookupTableEntry), so I can make the changes there.
> 
> The drm-rust tree is a bit special, as it remains open for contributions even
> after it has been tagged for inclusion into Linus's (including throughout the
> merge window). However, all changes staged in drm-rust-next are not going into
> linux-next until -rc1 is released.
> 
> IOW, until -rc1 is released this may or may not resolve all conflicts with
> drm-rust-next. Once -rc1 is released, it is backmerged into drm-rust-next and
> drm-rust-next is picked up by linux-next again.
> 
> Usually all of this remains rather transparent to contributors, but you hit the
> case of using a new feature introduced through another tree before drm-rust-next
> caught up with Linus's tree (which will happen next Sunday).
> 
> Before drm-rust-next caught up, this patch can't be applied anyways, so all
> good.
> 
> > I am fairly new to kernel development, I apologize for the mix-up.
> 
> No worries, you did nothing wrong; thanks for the contribution!

Yes sorry if I gave the impression you did something wrong - this also took me
a moment to untangle as an experienced contributor so perfectly understandable.
Appreciate your contribution and hope to see more of them in future.

 - Alistair

> - Danilo
