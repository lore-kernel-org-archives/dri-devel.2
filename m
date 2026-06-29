Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94214C43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8AC410E011;
	Mon, 29 Jun 2026 04:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="tsHHYF4+";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0AB610E010
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 04:03:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1tUV5KSDgHSfMMM+Al/lRAtxG7fRuR02ryamSpIEdh1R7Tvro8Qqe54TZUvfVf9oxk6x/mqyHMwJ5fJSDsHtFHS4eGxnCENM1sdfCrf5/uGViE6F3uzBNy6QeJn3Q3FkGPQQyv8tj0OWyLl97uTZq9tOD4dy8u53BBypOZcZPWc0CSzT6ReiOyrCHkD+XmFCETtWSzW/Qgxz08s49OTf9sZusq13wSk/OhgO1xAItyXncU++i29f0fpgiV+uD7hlXKbfwu5a3qi4Wq+dUddYNAE/rdCvs+qQnkB3aLVsHIIr5eVIe620P76JS69vImJ8riDA7t5dXCm/4w8X4hP3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuhx4EVneepgnyPO//NMysgpZZx+64YXntXeHjkjfEM=;
 b=azveEOKTVnpdgkYPn16PhY5yP7ifnHT5cltjD4zIDESYyzaE17Lc6ejHxftYSNlthBy3uO65Tcf4mMfkSQawT25UYh+9kEGoiIUMpnnKP6b3iwe2l9El39XlYKk+AkGt6Ans0RiEB4fS7Rl7IIyu4UdlC2jj2zNkJFBgVxJR8llnQihTqJXqb21UQidI2f9Ux4eD40NHBKmhwtpEisNKVN8NT65tAuggPrWVgE9faszD0mgDRqNs5Hkno7YY7OrXEVjOS+MwzI5b8e8gNbX4RLbIyJ7YwC/KDlcRhR7RUUOBZTWfmq96EvmE5X4UB3gNnoCFUMh6PgEHs+ftHLMaJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuhx4EVneepgnyPO//NMysgpZZx+64YXntXeHjkjfEM=;
 b=tsHHYF4+kTVou0V3FK3eKvpFmgZRvKc9a5QsozBahR7cKHXEpq6/lTz2H92cMlvKM/CxVvACCx7FIHhCs5syq0wFWUwFfPayDNSYe/jF0KirG5p434vLDJvFqQBlF/qDivgjsjJhvna4zYUQ3j/nHYkuOTRd6PFblSlDz4XchdEAxEfhIXRKtr6wy+8/KQuMSs5MhWJ5CV09pJGJ77qSTwjtkVYT0cd+nNqWxWfKJ43Z/vbSaJMZZXb7ups4MblIFtEOjJ9SWJQtXYOt3XR63nQWQrJ+JV+gHpDTDWIhcsOAeHhAjum2anRfINYpXBlx4R/I61oQ8QltDBVgPUn6gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Mon, 29 Jun
 2026 04:03:12 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 04:03:12 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: display: tegra: Add channel/syncpoint
 range properties
Date: Mon, 29 Jun 2026 13:02:59 +0900
Message-ID: <xLshrt-qQoOT-VB3QjfvBA@nvidia.com>
In-Reply-To: <20260626-sceptical-aardvark-from-mars-cedf81@quoll>
References: <20260622-host1x-nohv-v1-0-65bc682a617f@nvidia.com>
 <Np88My8kTE-rRphOw0a-Ew@nvidia.com>
 <20260626-sceptical-aardvark-from-mars-cedf81@quoll>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY6PR01CA0036.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::10) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 394fc545-9a4a-4c36-f3d0-08ded593564e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|10070799003|23010399003|6133799003|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: +dTXg/OvSTdj6VxJTnX5HM3izgXDFc4QjwebCn0DsGa9Gn5KFeC06bCJKs4S2XltRyBqRJDJtwCQmGNzsdlaCM9/jPKdU9LDc11wM0baiE/3hakyYUoQPqLnWxHFegh01OslsPQHtxTf/Hlc8HBJqeXOeFRBv5dv6sYVgGw5RmvJ632cLQ59t6IVixy+A1ofDINyZGuKE+L8RKXZA5D0movze7Yl4fge7OPb8q5ugBczQDzWwPr1C4sBP6plAU+lggtq2g9v6YkKlCInxtCj1Oq4l93r0TpQ9KeC8gKdMRdQmQ8s76wVPGFQ2Gu11KtfaB7Gv/02UtfK1A8zG2JnRAoik3OX+E6PrFLaZsxaZlHDkyBWnPhGGjJ0XpwvsA/Brs1pReUSVupNsUdGakbDXcF/UkPfy4olfKUNjvYE1fY2vG+lxJbl87hE/LH1OtE8w7qd87Dw9IfHK4pBNgxDyVhIWLT1aYhUHH+hHlxHpIspTkjmkbKdPkbUpUyj2tnGleej25WpOx3tZVct8zBttgUqDLC8gHiF0DDwPbLAqpYIMSbmu2ZwFb0tE+8tOGVOnh5m1PLcmzlz0s11v6R8Hda7a/AgIMz5/BUYGASRuad/R9HW3HHE2GVdSMb1FnJsMxc+lE/fVAtjZACXfW7VoKbCDRl65QTCkMK4ytncUEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(23010399003)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDRaSkJUaXdKRkdyNDBBUXZ1aWd6dGZoS3hESHpVSWl1VDd4UTB4bnJRRFBI?=
 =?utf-8?B?dk9ZWkhieTJZUGZFQWhWT1pHUERtbUdCT3J5SkJuWHJCWEdiTHFSNG9hYVYv?=
 =?utf-8?B?NDBkZ3EyWWFtc0RQVTdZWDRmSnZFdWp0QXpLLzBiWThaTVpid1pGZStJTmtv?=
 =?utf-8?B?bHp3SUtERVpYZlp4TzZqdG9oUmdLbEZtK1hIb2NsRHNWVnFCNXV5SnFIcGNn?=
 =?utf-8?B?eWhYajN3dXRBRDd2cm85aFFHNUpRY2xKTkJ6cHYvdFg5aFVUWXhUU3FmOFZs?=
 =?utf-8?B?Sk9XKzRtWGs0amVHZ1ZaTTdhOVRkR2toU3RFTHhyU2xkcGdURTdQaE5COUZP?=
 =?utf-8?B?WUVqR2ZoaG1BRkxSc24rOWZPSmpFNEJxMmRSd2tXV011K1pPSG9yNUZKQ1Bl?=
 =?utf-8?B?V215SHBVaXRtL2hQRzNzclVvR0FaUnNGMXQvWDNDZFc3RjdZVTUxNHRVd0p6?=
 =?utf-8?B?UVZqR3pyN0xVSHhKd2g5eDUxZDI2YVFUY0RhM3F2NXhpdUtSN1UzbWM0TnIw?=
 =?utf-8?B?RG5LeWpsekVMQWlQOGhyTkRnZWNlcDV5ME1YSEVoSVNWYnY1MjZONTk1YXF4?=
 =?utf-8?B?UTh3bzFpeGxMUjM0Y21wd1U3bXR4cUI0MGdEK1dMS1Nlc0NpWDh4TXhZbzdI?=
 =?utf-8?B?ZFR1V3RFZ2dURWRWNEd1ZmRsZVkxdXJhQXJoTlBoR2s0TjlaQkZ5cmJRMTFz?=
 =?utf-8?B?dkVETWsyaGtJNXM4cExwSUhMbGNTejZXRXlUcmRXUmVvcnlOTy9lVUNlVnha?=
 =?utf-8?B?R1Z6TUZsZlpoWmZCQUhzWHc4cm5vRllpM2xMTURQYm81K0xPVEw1OXBCZEcz?=
 =?utf-8?B?Y043WUpERHF3UUhBT1N1YmE1U1pNTHFTTG90SVdjaklTTHQ0UzR2MTVHMkFK?=
 =?utf-8?B?VFJ3dzd0cmlYajAwZGhXZW16bFlkdE1rQk9wbU1yTWlKTWVTSGl1dUtxalBk?=
 =?utf-8?B?WEVEbktyZHJNZHFDRHJPN2FncWF6NHZ3SGx4dE5ybVh3RUVCNFlQRzNjWEtX?=
 =?utf-8?B?Qmg1RjhCeEJLd0hUNzlLSWpkN250d3dQWDhBK0FrR3JqaWQwU2JCbTNMUnhN?=
 =?utf-8?B?cHFobDAvT2MwMVZQK3lML0MrYkh4WjJaWVN0ZlVpQXJuZm9jbEF1ZGM1cm1W?=
 =?utf-8?B?WXpOeXpaaHViTG0wV2l6V0tZY0FLR1g1UVB6Qk0wbWI5aVMzZjN3ZEQwMzFT?=
 =?utf-8?B?RzJ0MzRlNEM4RDBpWVhRVjRocXoyRlF3RGFobmtNOCtCbTlYRVBNSnJndzNi?=
 =?utf-8?B?dVBwZ0hFd2x4djRySU14Q1JzSWFUT2VibWJHc1pPOE5vaFJsWHdPUGZsWVNk?=
 =?utf-8?B?dXlJNy9XNFFaMEcyWGp4NGVOZW9lSGwrUURZamZ0Wk0zOTVzd0VXOHY1Smdo?=
 =?utf-8?B?d291WUNwdEtoTHFUTVVOejEvb08yUVhxcHducjlaQUtORFdVbzJvSHJjRVM3?=
 =?utf-8?B?NTBGcFRyYU9hMVRTNFFVMlRieHdBVkFOTldSTk81Y0VzVDNJbGJZMFlBcmtU?=
 =?utf-8?B?emZDQ1E4ZVJwUk40NGk3TmhSV2ZkN01LRGppR05uQzhPdXlib25kOHpMNGpY?=
 =?utf-8?B?R1JQR1I5L0tWUzdIdmZVKzRaU29lbTVrOXFta3VXRkFPRnVycDh2OStyamxK?=
 =?utf-8?B?Q2lPVlE5bWJ1d3Jwb25LTk9GYWtmeUhuWU5aSWVRbG52OUI2dzlzb0JMcUFK?=
 =?utf-8?B?T05NV1NQemQySXRYalEvdGJIY1JqNjZ5ci9qbjUxRk9UV2tjZzN5NTlUVUNh?=
 =?utf-8?B?MEV4YURLa2I3VFN3ZnREM2N4WVJTTVVzUDZIS2NyamdmUS9BTnczVkVlSnZY?=
 =?utf-8?B?L00wLzVBSWhUcG1odWw3U1JhbFA3NDBZa2VXZUdUeFpkMlY1bjQ3NTg0ZEpG?=
 =?utf-8?B?Nk9hMVd2RlV0eEhrWTFqdy9Calk3YlpvUTdITzBBSmtYZWdMVnpwTWw1dDBm?=
 =?utf-8?B?QStma3Ftalg0Ukl5TjVneUdGdVhKaGpaRHhFamYwMlI1YkdQaktxSDNCcTBS?=
 =?utf-8?B?SmdrZFh4ZzJnS2cxa01INTBvY1VLVVI2S2cwaEVmWkJFWVhhL09JZW5XMmh4?=
 =?utf-8?B?ajFHWHlkRGlUdHF6VUpSSU9IUHozTDF4c1I1cCtxcCtsdUhpWUhya2x0WWhw?=
 =?utf-8?B?cml5Z3ZqTy84UjdqYlR4ckYzRm5zQTJBWmNMZVpVdUc2aTNIMDNydjJaM1I3?=
 =?utf-8?B?OWxEdE0rWUdvR1lKV2hJc0RnVDNwSDhQNG5pSmJmK01ZNHRzYitUOVZHaC85?=
 =?utf-8?B?b2p4Z3ZoKy82RzZrUkE4OWhHd3ExYVRRTXVUMCt3SXVETzdndFNSc1dXWVM2?=
 =?utf-8?B?NEFjWVB5Qitud0ljblVsakRWRkpPbVNITXo3RUtZS29sNng3RVNXdWtPckpF?=
 =?utf-8?Q?yh8dCdjwaS8jo7xdAFp+qeoOBW3yRB2WjqcAsYjsZN5Dw?=
X-MS-Exchange-AntiSpam-MessageData-1: YRFQla8PuuP1Tg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394fc545-9a4a-4c36-f3d0-08ded593564e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 04:03:12.0654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pT2/fvx/10eSZptM0L8n89tUBCTWWt2l1GfqtIs0YnzQFk7xwv3W7nghdIDb+socdQgqjqCZ0lv7KFpXFq+iaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157
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

On Friday, June 26, 2026 7:26=E2=80=AFPM Krzysztof Kozlowski wrote:
> On Thu, Jun 25, 2026 at 06:26:43PM +0900, Mikko Perttunen wrote:
> > On Thursday, June 25, 2026 5:36=E2=80=AFPM Krzysztof Kozlowski wrote:
> > > On Mon, Jun 22, 2026 at 05:22:51PM +0900, Mikko Perttunen wrote:
> > > > Channels and syncpoints available may be limited when other system
> > >=20
> > > What are channels and syncpoints?
> >=20
> > Very host1x-specific hardware resources. Somewhat close to GPU channels
> > and semaphores / fences if you're familiar with those.
> >=20
> > >=20
> > > > components are using them. Add properties nvidia,channels and
> > > > nvidia,syncpoints to limit the range of usable channels and/or
> > > > syncpoints.
> > >=20
> > > Why isn't this deducible from the compatible?
> >=20
> > When Host1x is partitioned, the hypervisor (or other software entity
> > with access to the non-vm host1x register regions) can configure which
> > channels and syncpoints are available to each partition arbitrarily.
>=20
> So you will have different boards for the same SoC with different
> values?
>=20

Yes -- even the same board will have different values depending on the
use case of the system. The hypervisor or bootloader has to update the
properties according to the configuration it has programmed in the
hardware.

I will update the commit message with clarification.

> >=20
> > How that partitioning was done is not discoverable through hardware
> > directly, so we need to pass that information through device tree.
> >=20
> > >=20
> > > Also, nvidia,channels is too broad/generic. This is not ADC, right? A=
nd
> > > channels is a common term in IIO. And in few other cases.
> >=20
> > It's not ADC. Yes, it's a common term in a lot of contexts. I can call
> > it nvidia,host1x-channels if you prefer but that seems a bit redundant
> > given the context.
>=20
> host1x is indeed poor, but maybe there is some way to be a bit more
> descriptive? message-channels?

I would prefer to keep these as is -- anyone working with host1x will
know what 'channels' and 'syncpoints' mean, and changing the name could
cause confusion since the name would not match other code or
documentation discussing these.

I can update the binding documentation with some more explanation about
what these properties mean.

Thank you
Mikko

>=20
> Best regards,
> Krzysztof
>=20




