Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAB0CD98C5
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 01:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E400010EC5B;
	Thu, 11 Jun 2026 01:40:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ToHIft63";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F69A10EC5B
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 01:40:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIBdrYfudcDS8hE7w3sYNzvdkqDAMaMG0PmX9sUSALtd+DFvUZpfOclTYGkWL0ddzg+TG5mz6cE22/SXzlmb3Hxi7k61520yODB4yi6gjA+1X2xickrxLZ9i/Vq15ma2NdJptKL/Vf9jTynb8H04xqcNliQAqAiwXT8hqXDpLvSEp1BtEeMz4hE9JftGE/MY46EJ9p16SyahAEHudnO+lpkGctlCFkDoZSSkxgxyryT1Rzphni2NZwZpHA5Sya0wI9nvPVCQfwoJOKmlQA3/tfni5/+OcjXymAwXj+FHOwVzcEs6hcp85borNYNSjb/rXyY2mnaEEsMT4E8vy9xM6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N16wxyB5o9+oygtoKu7BV9MEEk+1crSYu08x8UAGgMM=;
 b=V3G2LyOx5dVm90MrZ0W3TRahpbjKKjS4Png6zR8KqjNxaYxlgLjtfns7ja7NSsfK5RhLQJ1HdweFwepePG/RbH2rUOj0xVVAAu71DS7mFKzCNv8mj+xGEpmgXimPYj/UgEFSFTYsmuQGMHCHdcWiKykK72Z2bZ8zNUSU4oe9j+fC2xpqc8o5kGFk46DhDK3YSk+A6tezCD20Y/E6bEAx5bL5vWQE6e11LdvguFoABt7+bibJ/o8mkcNvJsmijM5+KKkL7scommsqJVnoPE9LZ5bGX06NKbYGsQudwUr/Dp92qBqqGmOByzIxY7mXGR68uTdD5RIwIHc6R7M7hQ5EXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N16wxyB5o9+oygtoKu7BV9MEEk+1crSYu08x8UAGgMM=;
 b=ToHIft6349rnTrtksT9j+Yd29MFytQ1qJ3uUfjrsUIfkjJwcrfVzZBl7Hp41oUTwIpURP1FrUBmq35sqP2lRRt2RxMDDNluiqAAUDinDAeMjmXdRdkSIdtfwKfTv59vfoQRRU8ZNoYOigTDI1f1scXxHMapq1l4AjJxiWmb6tPe/4AlzokV/BoCSdp+Umakxjyh3HNsB03v4Q6UOsRrtagaA/qQuXF+FmQvQdDr7yfqBU0KWMOO1JyMUCdH3BNlsw3/IJ7Efas09pRznSlh+H81DZadWWl3VOwC728oVbBrDbJFAJGliRr8V3WfsZjXGyYx5isMqbN27k04QMtkVXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY8PR12MB8314.namprd12.prod.outlook.com (2603:10b6:930:7b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 01:39:58 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 01:39:58 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 10:39:53 +0900
Message-Id: <DJ5U53UC0NV3.3L6GGS2OJ64Q4@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>
Subject: Re: [PATCH v2] gpu: nova-core: gsp: Move gsp register definition
 into gsp module
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Nanonej Dev" <dev@nanonej.com>
Content-Transfer-Encoding: quoted-printable
References: <20260607140949.152575-1-dev@nanonej.com>
 <DJ5EN9YOZOVF.RZ2WJGSB0L6G@nvidia.com>
 <9B2MG9ICH2MOGGwTsi0aCGBlEyEO3p-VTk7iR0wgDgBkAYKEu9GC2mc7eAODT5nilASpnSaPdZZjliM9HcvEY96LscSKHF2iDXDXCESptAA=@nanonej.com>
In-Reply-To: <9B2MG9ICH2MOGGwTsi0aCGBlEyEO3p-VTk7iR0wgDgBkAYKEu9GC2mc7eAODT5nilASpnSaPdZZjliM9HcvEY96LscSKHF2iDXDXCESptAA=@nanonej.com>
X-ClientProxiedBy: TYCP286CA0074.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY8PR12MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: b3957a9c-bd3b-48bc-1c4c-08dec75a5889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10070799003|22082099003|18002099003|4143699003|11063799006|3023799007|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: 5fSXAg92732yMXuXWLI1V7xr9iwfHzlyL3INGK10zkp0kmSucHcXejx8Sc0JbmDSSR7pg2aqtoTl706e1XtzXTaqx24hF6Gj4tYM5/CoAvmKS7ltvhFcwsDprmUyxmBTx26YFYiWXfetBH8SB/3mCV/7VC8i/RmAuCwP93x857k7IZoRVYRq+BB8DSLUuwDn2ePWX6xCAsG7BVjLuuNtnde2fhByLFAgEbTHH47Yk6SukJbkoy//89SpojobZBRG+ttHc5UNFJHU2dnJqX/7FDSUHYue6DRAf+sCbRf6ScSANgz14sC/lTFSsDEuJQ/2v8P8ZYdLeCClfFV+/uEIV+i9Uvy35HQjCHNKK0Ga/WMCocxXz03MyKNBCJSsB1u8WfMeNsOuB/650GxiT8wX+zCTdjQ/BpieuvOmfLAJIB1797NH1Q2hHUCnazEZy0ipjXQouYFh1P1owBb+clvF14DLfxfszH1y5gUZL/f2jnG7jrnfZPB2XqDDra5GwiH2ZKfDuWvTxsqho9XPKQ3lJiOZ9BGuI4QWuM87sPhTl+R4xgOQH4NGrN/WUiS3PG2yMmL2UNH5Fm/vC3LKh5RTjuS2rRKrkQ8L8QGiQ+2l9STgGQm24OcIg+GrKiQbEj+Q2sj1S293lrz65lMDqIRz0qne4lb/7tnLthDRsuAJzs2pi5shi1HvGa/OVhC8OT+k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10070799003)(22082099003)(18002099003)(4143699003)(11063799006)(3023799007)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFgzMXdHeThzMWI0cm9jd1pRK3ROL21lSjNTeXg2bVphQzhiSnYrbythb3Av?=
 =?utf-8?B?RnBySVlqVk5VZU1ad2lmcDdHZlBvZlpkZ0tuNE94b2t0S0NiUkdlZ3UrQXUw?=
 =?utf-8?B?UmdFSFIrb2hMMXo3MWZBRURUNlpjQkZLenNtNk1FY3VKTE9SVDE2cnR1UGYr?=
 =?utf-8?B?bGVicWgwWFFVYzFiU2toU21QdHRFeHlVbklrMkE1R3UyaXVYbGNmQ3V4Um9u?=
 =?utf-8?B?RE0zUDM0VzFRcjJ1QzVHenNOTEdPOURqbmZycnd0VFJCaXNOenZudWQ1ZllJ?=
 =?utf-8?B?NStqQlpUNGw0andLL1Yzc1VvYThUQWlwZjRxcElTQjd1dERERC8wL2xqYkpr?=
 =?utf-8?B?R1pmbGZ6dnlOOUkrMEROb09OUXJxVzdQVHVsL0Rrd080ZGNvREMwZmViSWxD?=
 =?utf-8?B?SkFnc1RZQTFuc1V6WEY2L1JpWmNDbXgxaFNTdmliVkYvWGdJUGxZR3djeGJl?=
 =?utf-8?B?czFNZE1MVTB6VkRFTXpGTWxNQlMrOHc2NVVaZWdhMXV0TVhrSHd5MlJzeEpC?=
 =?utf-8?B?Ti9yNUJGNkVUYlBaUVZKQ3lOVDkzeDNGRWx2cXhubi8rc3V4VFVMczRjekNP?=
 =?utf-8?B?R0c0RFh5eUIwVFFjYUM5N2xRKytJSjNFbmxBckxIQmJlcTE4bnJrMlpJeTFi?=
 =?utf-8?B?SjkybFd4aW5JQ1hVdHJDWnI0QmJid1Z0VXRNRjF2K2lCV1JmdjhyMkZYREQ2?=
 =?utf-8?B?UVpTdUV2L0FSWjRqOUlXeHdlYTVrVUhoZ1VJWWtwTDFXaCtTSUVZSDFscVd2?=
 =?utf-8?B?V2FrYjkySDc2cHdSQy90d3d1cGwrTm5TVG1Ld3pyR0ptVjh6SlBDd080OUVl?=
 =?utf-8?B?cllScHpHcHFVRUdnTVdlWXBodHlISFJ5ek96ajFicEk5enBnWFVPTHRjNWVM?=
 =?utf-8?B?NFMwL1gweE4vSFVwNi9rV0lMV3RHSTg5SmMwSHcrZWZ0RU9QYi8yd21SY0pD?=
 =?utf-8?B?eFVqajIyUUVMTzk5V2dZV0hHeHpTK2ROTWdkR2pOWGlLbytKMEFGcWRnVXd6?=
 =?utf-8?B?VkpZa3NyaHV4U2V1NlJiak5qRGV6OVBKNC9QQ01OTlRlOUh2TlJ5QUluK1Yv?=
 =?utf-8?B?R2RjbEhuRDVmRlBjTElUUWhzNC9qbS9DTkdTa2hlclZyM1BWVE9qcXVEdUtx?=
 =?utf-8?B?QVNtRFhSYXRqSGZBb2ZQNlJEaHVFMU5zVW1Qb1laN0VMZGpJOXpGbkhnWkxS?=
 =?utf-8?B?ajBvZFdYdkFwMWZBbldrSFE4SGhxMWtkNU5COXdDNkgraWlqelltWEVPbS9l?=
 =?utf-8?B?R0N5MG9jbGkxcGRMVlN2cW9uOGtJVEE3S0lIM1g2MUs4Vk9vemdlU29GK3ZF?=
 =?utf-8?B?VnprUGFTaXFKazAwV0ZjYUhDUDNPL0RDNC8xRGc2Unp4TTJoa0FjZVlDS3lv?=
 =?utf-8?B?S2NJVjNWazlUWkVXWDhnR2wyS1k2UG1vU2szNEF4TkFDMGZTQ0V4VEs0dDZm?=
 =?utf-8?B?RExMZzNNR0RCdkhEd2RDVW5SVGpha0ZYQ1ZaTms5RHpySW54Yk5uVldZWEI5?=
 =?utf-8?B?SHVCS2tjTFJacU0xTWlVRU95bCtrV2VzWU5CRXhVbnZkMk5VYXRiZEJNYWNh?=
 =?utf-8?B?TTRSajAyZHFVWW56TndSWFUxb0k2a0tVQXVjMmpBVFptTWZOL0Q4L29LRFVC?=
 =?utf-8?B?S20zdzJjRlJ0VjlwSVY0MlNBVGhSV2pHVzd1QUlzN2M5TEovV3ArM2kvNjdW?=
 =?utf-8?B?bGxHT0RyTmFlNlcxdWllRE91eS9FT1JISG84c2RXUnJ5U0hYcElyTVlzY1N0?=
 =?utf-8?B?TzdCMXYxQU5DK2hFSXhuVjJpeDl5RzQyemFBUlhYYjI3eVBqMkZyZ040ZmZq?=
 =?utf-8?B?WXAwZjlXMDkwSHBJZ29ZQ0I1eElnaC9aZ2tEd2RpZUpzditMdW50QXlRc1VE?=
 =?utf-8?B?WURUbWlMWGdpZC9MQmRzaW9NZXhiNERtZUNOTDBaekREYWdsbHQrM1J6ekZt?=
 =?utf-8?B?UHpQdHdYbGZCWktZSTlabkMvUnVUWWJXUmE4RTArRFRicXZPMWJRNVdjek51?=
 =?utf-8?B?U1BCTUE0Vi9kTzJzMmp0OVdIbytmNjRrWmFFWXpmaWNrMVhzZmozRWNrZTZP?=
 =?utf-8?B?MVBmbmRUeGlyUzhaT2F6S3RyT2xGYjBLYjJZWmZuYWtNM2hUdTIyT0MzTnpC?=
 =?utf-8?B?SncrdzREMnp3L1o5YlFCT2hSL05vWWF2WW5UYjVFUVlOUUVjU2JKTTZ3eXVi?=
 =?utf-8?B?OTBHcHh0cEt0UzBPY2o4TXh0TXJZVFZuUzE5UGo2dHVLM2orL0xvY1A5dldG?=
 =?utf-8?B?QVppSURDS2p5ajhGb1FMdmVtdGdUNmwwRXpON2M0QkhHRjBoM25STjlibFZo?=
 =?utf-8?B?TlhkVy9XUW5WMmRaVDJXbFJKdE4vZTg4WnBHczVpSGtmVHdhOTZsZjZKUE1G?=
 =?utf-8?Q?vgBkQ7qWtY9WV7PqlEHRkYMYH5XAPZtrEGzqeN0RzxAzD?=
X-MS-Exchange-AntiSpam-MessageData-1: PLB8Z8j2b3lrxw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3957a9c-bd3b-48bc-1c4c-08dec75a5889
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 01:39:58.2331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXaHjios2jdlu1+eOdFTXrZvRXhFrYFqbkKiyPYZxa/0pniLGUGDSl8uraSiDeVgpqt9DmQtj1+5fKyxbJhCkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8314
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

On Wed Jun 10, 2026 at 11:57 PM JST, Nanonej Dev wrote:
> Oh! Didn't think to add this extra tag since your review, sorry!=20
>
> Can we add it now? Should I do a V3 to add it? Or not that much of a big =
deal this time, but should think about it for the next time?=20

Don't worry, you did nothing wrong.

This is just the (rudimentary) process by which we state that we have
processed a patch in some way: just reply with the tags carrying our
name/email that we want to stick to the patch [1]. In this case, I've
reviewed it, so I signaled that by giving my `Reviewed-by`.

Since I hadn't given it by the time you sent this patch, there was no
way for you to add it.

The common practice is to collect the tags you received on vN and carry
them onto vN+1 (unless the patch has significantly changed), but in this
case this wasn't necessary since Danilo applied the patch and added the
tags [2].

All this to say that this was a perfectly normal kernel patch review and
there was nothing more for you to do.

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#=
using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
[2] https://gitlab.freedesktop.org/drm/rust/kernel/-/commit/3e4bac7b8ca7688=
fb3aa9c0bf005a5a4256ad578

>
> Anyway let me know and thanks for the feedback!
>
> Also, I check for Proton Mail, as I understand they don't support `format=
=3Dflowed` so except using there "uservoice" service to ask them to impleme=
nt  it, I had probably nothing else to do. But I found a git-protonmail ser=
vice dedicated to use proton mail with git send-email, so maybe it will wor=
k? I have to try as I don't know the email protocol well enough to understa=
nd on which layer the patch get mangled and if this tool can proxy around t=
he Proton implementation.

Normally `git send-email` or `b4` should do the right thing, but after a
quick search there seems to be recurring server-side mangling issues
with Protonmail, so you might need to use another service to send
patches. B4's web endpoint might be an option [3].

[3] https://b4.docs.kernel.org/en/latest/contributor/send.html
