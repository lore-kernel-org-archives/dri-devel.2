Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD4FC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E02EF10E037;
	Mon, 29 Jun 2026 07:09:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="E99aCBVK";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D9DD10E037
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:09:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+n0tc+8kWJVCfR2GFqNrFuKaMfouO+GmWCPQt5pzOxExMeo96Jw3Np7UBmZQJ0Kt5sudUx/4fXTiIQUXCQTnXWirhs1EaKat/q5Wq1v8HODsZKA86FXbU++OEZ+gvdoNIgccSQBBoddEkQ8LHW96ThfCXa2ZYWu/mZDOU2J3QXFqor0r/nh4nn8JAGOPztH2M4pXh+vmN2O9gH2LdhDcct1uLJxYbtUiUElMbQPtM1riP1KIVtCPKbsrrJSvPUcFC8efwsK313Co2zyDp4lEi9I9MDnfUnNqP1jZRopvbgTRWfLzEcviINUKwFdY/2+sMm5+mzfmPKwDsHn82ctzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmGdH9/tuSG0Vd/IPj1qkk1rQ0qzgelJPkB419/3eMs=;
 b=RzhmeL33HIM4JjhReOH7t7kQA6CVp8Ie8aZJM5jF6iY0j6NPAfHAWY6KiePh7Ml1TNqQ8gY1A/SHE7GJxlx2IFHLnhhNfWhpvKB5/WDmukAOj1IOlhO/5gyt55ZhgIr85aC+6X1Kb662oLMrDyRiNuEw/lwkXr3CALANnHluvE68r2gM6+lC+lUN960QGoLsNYVlyOplJpSj2p4/nyJY9mygxGt4kBVA5yGl653zE9rj6iFjMZTclC63DzdHNWhDih5n+N+4a0U3jK0gK7qMDMUc75EyRMEw+eoyABkoxMZA1Joi3jFvMQKrHn2SFvoqrMKy2ghhkKnmmOeEn6G+jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmGdH9/tuSG0Vd/IPj1qkk1rQ0qzgelJPkB419/3eMs=;
 b=E99aCBVKcV6ohwD0rAgwNiPhof16WoB96eop2zDSW2QzDjRBtsTQX2d6DTclYLMakVXrpFN5Dwteq8Ji8fe2spzrNlHlHyPVI0GZU/gR2Flve8ZDMzR7Ljv/EjUSCzmW/iVO7RPCt5bnAlUAFb/nLr0jRcGlPl6B4CvbPkwZdaL5qbvThbHr0HP+IGWZHZB/QkW+x/1diOB+He73cu89hZMtG/2MHdyJbHR/+ieK8AMUsHYGoppV6Q6TnRPLXa6Q9/CAow6qzm7n9Ur3YNlTW7Q9rtq8oRjSgKx7832UXMHvCSFFLSUugG9C3awvyu39HmYbd7VZA+x4gFwYZ2ZkBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 07:09:20 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 07:09:19 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 16:09:16 +0900
Message-Id: <DJLCF3LR0KMN.1TMKMZEZWKN8O@nvidia.com>
Subject: Re: [PATCH 0/1] nova-core: Convert bindings to use zerocopy
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "SeungJong Ha" <engineer.jjhama@gmail.com>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>, "David
 Airlie" <airlied@gmail.com>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Simona Vetter" <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Tamir Duberstein"
 <tamird@kernel.org>, "Trevor Gross" <tmgross@umich.edu>, "Pedro Yudi Honda"
 <niyudi.honda@usp.br>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <nova-gpu@lists.linux.de>
References: <20260629025220.1935622-1-apopple@nvidia.com>
 <DJLAUOEDW6HT.39URSU30Z0HT9@gmail.com>
In-Reply-To: <DJLAUOEDW6HT.39URSU30Z0HT9@gmail.com>
X-ClientProxiedBy: TYCP286CA0224.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL4PR12MB9533:EE_
X-MS-Office365-Filtering-Correlation-Id: 4199ae6c-3ec5-4df7-a08d-08ded5ad5683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|376014|7416014|1800799024|366016|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4AEeDyfOGPri8MevnwLGoHcvrMmqYY6yzBfJaoAOQAnwn4cjcIfwzOoUVu1OAw+YhxSln5MV0xNNOGoLkw3lbUziUBkUbRv13Eu9KrGqCc/y3R2E583EZaFaQeWZgubxCZoRkHhM0FmV9of6E566VbZLwn/nzi+VbdHBxKSCnQQdlLM0lV6yKsn6YOP//CcmJ0pBmiUAh68PxQQJmOj60Yn1HwsepBdSKdAINwQYBrq1/XVSgQpBqEoYewmHi3omGoPcO2tsrArC4MTOn2eZkBRbRS/VhAMcJXc9Njlq2HXESjf1pYs4IFxxGI1emnFHizp7Vj4fCXg+jsF5pKUuylfUKmGGJa/Fv369j2PoFHbaF325nSz8FOUoK3hPBXnH5zfKLkqSeemI7xSUi6ZjasPVa2DGCG7uF2yiVCwEVXK7HzGFWABxElq+Ct+EgVy9xD7CgCY+PE2cxXTVN1Qw+9AM9bcFu1rb8Ks+AL8bKh74ClDMY4e8b6Tn3SLmcW2SMWzdNz9Xm/JoW5A+xf3/brlDLOb6yLOmHfcGNYRBQs4yANpyJfaNMOkEMgMF7VfuLWMdFZwGhDyAgT4OgVrtN0u0hvLlRz70Bbet6vFY+gSsXzL/bIwx5NsYxspV6TxjX8cpHFOlNlnJ5HBbzgBcYJH4+t89sfrTGA6q9V7S/cc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(376014)(7416014)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TC94RGpVeXB5MjA4STZmZ09SSEEydHdObkp2NDRrYzN3MGx1UnZ4ZVZtQWlp?=
 =?utf-8?B?N2RMS282QkV0Z2Y0cVhHQWR2eVV1Wkh4QzN5eVZqdElQMTlzQm9DazhDWUll?=
 =?utf-8?B?b3FsTTNsWUxEQmNHcy84cnF3N1R3YVlPNU1KbXFGckh0TUpaaTk3azNjaGlx?=
 =?utf-8?B?MkdkSFdFS0NjZUtQMzg1ZnVpMk9tYVBGbHlVTUxqeTg1bE44QnhZM3FOUlFl?=
 =?utf-8?B?WkFnMDVzMFFpeHdMSzY5dnNxQWdFdEZsLy9JTWlWcFRjcng5bEdCb3MwWTV0?=
 =?utf-8?B?dnBMREhGTThkakxJL29SbHpKTHFqK3hoRlh0cjhnMHU4Y0o0SUsvclRCWjB5?=
 =?utf-8?B?M3pwc0xJOU52TVJEeFBRaTYwK1lkeG4wQ2RsUjBCbi92Q0FkMy9OZmRBYXpp?=
 =?utf-8?B?TzJBWTdCbTFsSjVSa0UxYXdDdXFNWGlOaVMzMzRJa01KNEExUU84TjZWUE1M?=
 =?utf-8?B?WWJEdC9yVTZGeG9JeElSUFF3cE9xQm1xOGVzUk0yNGtFQVFvNFVKN2tDaC8r?=
 =?utf-8?B?ZWtVRW0vcTN2dTFLVnpSOGdQSzRVc0lROVVUbzRjRk1mTDFTMTREOVhNUUZt?=
 =?utf-8?B?MkdMSkZQYzYrTVBJK1JWbEpNQmJlUzYyd25rN1hiTEI0T0hRL0Frd0hUSEt6?=
 =?utf-8?B?cmxkeStaUXpBdlp0S3RpSW9ORFltNTA2RFNyS1I1dkVybm1vMkpVdlpMT3dW?=
 =?utf-8?B?WVlrMG43NGZrL3NhS0tFT1A4Q1RQTVlPZk5tTlpVSE5JZHk2Tkw0ajJXY25H?=
 =?utf-8?B?MWJmRUtBQ3JVZStaUUtTa0FCWWVkemExbk1zMUVtdGZFMGFqTmtCUTY0Q3I0?=
 =?utf-8?B?L0pRdHREL2YxYS9MTG03a0dPcUpzbUJjYmlqTHVSZ0k5bFdmWlYyTzgzZCtZ?=
 =?utf-8?B?SENFQ3FkNktQNUpyMzIyT1hzblJXQWNDeXpVSWtpbXRnVC9ydnM4a2Q4eHRJ?=
 =?utf-8?B?MkpFR0RxMldUajJ5TXZTaEU4Z2JkbDlUeHRYNm53V3NPOG5ZRW9NUVNpY2Z2?=
 =?utf-8?B?c0NrVWVhZjR1L1JSdDZ3SmVRODJnSnBnL1RDZ0h2Y3RjQXJXZGZMU3g4akZj?=
 =?utf-8?B?STJwT3dpQVBVbExUa2tjRTJUN3dFekxzNnREWE82VmRoZ1pxRUhJaE1peHc1?=
 =?utf-8?B?WTE0dUt0RkZ3VnJpUHc5U3gwNzBXRVd1OTJDbkpaWm9RMHFTVTFBK0V4ZkhU?=
 =?utf-8?B?K0QzdS9HNXkvMTd3Vit5UmhmWUFyTCtPM3kyUWdRU2h5NWJmY29oZVI3bXNP?=
 =?utf-8?B?UUcwamMvNkszYmlKQmpaUGdPSjRzS003aUhNQzBJUm1JNHU5VXh5cmtWQ0Ft?=
 =?utf-8?B?RGhmWGQrbExGczcxQ2lIcWhMdWZkMVFHZkpMYVNMMGd3RFJUSHNCbHdSN0JJ?=
 =?utf-8?B?WWRjVWx5a1VSZlpUcHZBNGVsYmNVR1d0bG55NVNzRTNWb0N6K1NlU0JPMVZI?=
 =?utf-8?B?ODdoMDdLdERmcTF3MHhybnBJN2V0a01WTEEySGhLTnNLb2tHSjRNMklkRm04?=
 =?utf-8?B?bmJ1dDNJMW0zUXZKWDRzUTRSY0lLY1NPcnpCcDNyK2k5NFJpcEtnRGdxcTRq?=
 =?utf-8?B?QjBRNDNsTkFGUExaUldFZFcvMWQxU0dJUjI2RGNYTFo2bmF2SXJjc2s5dnpw?=
 =?utf-8?B?RUVFVWZlYVdoSS91SmJzSXYxbWwzclp1NUJXbllMWno1d3NaY3NvM3NsaDNS?=
 =?utf-8?B?a2F4OGE2TGFERzAwd3g2SkV3Q3hicDlQYmJPZWNlM0hxQzgwS0FEYVZzeCs4?=
 =?utf-8?B?b2xBZWFuTVhyYTk1NUZYZklQc1RlajJYVE9aNStySUFTZmg4Vm9jbjdwU0F5?=
 =?utf-8?B?ZlR3VWsrcUdFUUh2OHRMUzM2RU1SemliN1ZGYjFlZC8yQXpFMGliR0RXeVFV?=
 =?utf-8?B?c0dmcjdBMURsaEt5eTcrWk1TcDdHZmxldWlSVy8rL0tqNU9YU3FXeXJZeGZu?=
 =?utf-8?B?VHdkYUVWSk9CMWlQYzlVd0lyRG9UM09ld25mRGZic3pCUS9aWEFNdzNzUnNG?=
 =?utf-8?B?VzZ1akNnSjcwVWlSaEprZVEvMllNQ0lhbTNodTBuVUVvaDBDeVNHQTB2YjIy?=
 =?utf-8?B?czlpc3FHOXh6ejJKZG9ITHFzQS9ENjBLR2RHR2dJMEpTT1RIUFhWNE83b1Rv?=
 =?utf-8?B?dGU0Ly9IMG5ZSW4vRHVWNkZNbEJBZFhrYXFwUjRZYWNXWUlHYUVocVpXT2t3?=
 =?utf-8?B?WG01THYxbXFxZlJ0YUw5RzNoNk52U0FrM2NSUkFsMXE3Y2svMEpFa0g1ZGtS?=
 =?utf-8?B?MkNrdGJacFhDNy9yaUYydEQ1QUdrNm5FaDgxRnRLWHg1K1FtOTlIVVBtTzda?=
 =?utf-8?B?bUpmZFpaLzRxaFJMSDBKTVVnR1kxWmJOeW5XZ0JuWHFXS1BIc1NoVlRRWHdt?=
 =?utf-8?Q?nzPpOhsw+iFoTPpYAvY1PZCqXTV99fBjl7fwJzW6VajPg?=
X-MS-Exchange-AntiSpam-MessageData-1: 01XWHxSPDS1gNQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4199ae6c-3ec5-4df7-a08d-08ded5ad5683
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 07:09:19.4237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k75lHvvC11f8Hbmfuvnr/B7J0R05Qe2IyOvbKQoEwsW9A7hYJ47J4BXQUaISvdy9lRadR0r9+JLoVj0Kq5pkuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9533
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

On Mon Jun 29, 2026 at 2:55 PM JST, SeungJong Ha wrote:
> On Mon Jun 29, 2026 at 2:52 AM UTC, Alistair Popple wrote:
>> Given the inevitable conflicts that will arise from trying to merge seve=
ral
>> different series doing bits of the same thing I'm happy if someone wants=
 to take
>> this patch and the others and roll them into a single series. Alternativ=
ely I am
>> happy to take that on - hopefully Alex can provide some guidance here fo=
r what
>> would be preferred.
>
> Agreed it should be one series. Happy to help or fold in my part --
> whatever Alex prefers.

Since there is no particular urgency to switch from transmute to
zerocopy, I think it makes sense to merge things in an order that limits
churn as much as possible.

This means the conversion should probably be done bottom-to-top,
starting with the bindings, then the types that embed them. For the
bindings, `#[derive(zerocopy_derive::most_traits)]` should be landing
soon [1] and I would like us to understand first whether that is
something we want to use with the bindings; if so, let's wait for it to
be available (unless there is a good reason to convert quickly) as each
change to `bindings.rs` is almost 200 LoCs.

Since Alistair maintains the tool generating the bindings [2], I think
it would make sense if he takes care of that part (bindings and anything
embedding them) as well.

There are also types in nova-core that do not depend on bindings at all;
for these I think it is fine to take the patches that have been already
submitted if they apply cleanly and build, as these are good
opportunities for first contributions. Nicol=C3=A1s was first to send
something for vbios/firmware [3] so I'd like to consider his v2 first
now that `-rc1` is tagged.

For the rest, I'm happy to merge anything that applies - small patches
limited to a single module should be easier to process and less likely
to conflict.

[1] https://lore.kernel.org/all/20260625231919.692444-1-ojeda@kernel.org/
[2] https://github.com/apopple-nvidia/nova-gsp-binding-generator/
[3] https://lore.kernel.org/all/20260621143647.264770-1-nico.antinori.7@gma=
il.com/
