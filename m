Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995FCC61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 05:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C42CA10E43F;
	Wed,  2 Sep 2026 05:21:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="LWwnADBB";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013046.outbound.protection.outlook.com
 [40.107.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21F9010E43F
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 05:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7xTKR+o2mQrqnlcDz+bCv7ZX8f7DYWfD0s4XDNObcvIielWKGpVPHsSYVMjapb0ga3tKREghJVCQJ9Bv017uSg0hrxMv00ibwygahA/FPqc0atktbkXyWumeAAj6yTlyPElu2stUXWGqHq2Ofgc7Us4gUjJg+I7ZUGFPccB7zal7Gz+BTNiUkX1FEYZnLjO9987Q14qBktjz9opGM60DtsOAsDqTeFEF7/fLnpPpjVsZkd/N+6PKPI+qHFpF2QxaVmfsm/HxGqbfikWfoz8i2aA2kn3osAUig7m0bYucy91CTRqXs8bThrzfQBDvkLaT6WXDlmIS6v/NwtBYPRCoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdej3ABdWvxQ0OxpaVkq6VKM/3tYDRi5CwZ88LOWXNE=;
 b=rpkenbD64nL/0D6Er9J8bg1Tx6RHHx9GZOnyR13wEpf+pmtHOEP+ovMfFVC1j91Oh6SkRsdcd0OOCMPhb8iNemn7ClREpFI71m2ZDgKV8kJhQxdfqn4ihJzKX4p/XFkpNnob2fHlJxuA7K13Lkyk4YHOw7C/jI1xJ2M/Tciw4iqbsi0MCa0fNgYm7b0xpGgvwB1DyU/Y0tB+8swM6nwEuv2JPWTob/gOKV97stZHYbA3lQ2CjB0xODSI2y6xcoX+MH5xBS5YgUVOOgHo3g35zrKIPffK9pgQ/7N+lumoheMDCktumAc8rAebO/ACgTOmt6occq9050poF86mMCiqzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdej3ABdWvxQ0OxpaVkq6VKM/3tYDRi5CwZ88LOWXNE=;
 b=LWwnADBBuoeBQ7TfNDi1wNRcYQsdT5CVk/72x6EnnpGDb62tHxRkrw/EP7DvJZAHQaUVfemHVO6V9CvR7V5CtO+vYgLDRQ2fFtNOo92jYqAfqOcT+eVJi2I7DNA1ieeWor6KgwJByKkGMhBscGkWFKdr6zLN9gRfVVTnT4dvOUKA8hJ5pBO0AagQ7ci473FpAqSOgrgZgliT8YdR8z4yMOTfCt9XKIbXbzmKBRfefWxIIwVASLYeH7qzoLXqnyR9G916X0miuZ5kuVL1JynleRdsvZJgfrCmmLf48qmG58zLITQnvpmXja5EpApKu4tcUebflW5+rQKIojy4d9NMeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:21:42 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 05:21:40 +0000
Date: Wed, 2 Sep 2026 15:21:34 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Dave Airlie <airlied@gmail.com>, nova-gpu <nova-gpu@lists.linux.dev>, 
 M Henning <mhenning@darkrefraction.com>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 05/11] drm: nova: Add an info ioctl
Message-ID: <apetgjQ9zWpJATj3@nvdebian.thelocal>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
 <DL373JA1ZANX.21L51RTEUQ2UG@kernel.org>
 <apZCTUYiN5FHCkCm@nvdebian.thelocal>
 <CAPM=9twQxnx5DDkjwXWi-vXM4kqUQQdPaL+=1ASS0tpf2GmnYw@mail.gmail.com>
 <apZbKc5xMQ1yTBTu@nvdebian.thelocal>
 <DL3SXIIA4FID.2V3K5YC91RM3V@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DL3SXIIA4FID.2V3K5YC91RM3V@kernel.org>
X-ClientProxiedBy: SY5P282CA0011.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:208::20) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|MW3PR12MB4345:EE_
X-MS-Office365-Filtering-Correlation-Id: be380f47-7f43-4328-1ff4-08df08b2118f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|6133799003|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bn2es/ZJnkZscYWlnOD3rVGI/PyqirgE7FidTNMz64dsGc1ZrCwEBSbD4jT4nLa0IJbOLztsOG5jOa3rSjsyKMVA3IaCgJp3OEnOPYXAtMg2z7IqmHeYu52YRWZdq+Hdtn3n3ZOIuJh0qjBcgNFJbEcBn+SaKg7F9MdbpaBdxCch4s/QFl3WYSBK/tcPRJaEJGn1OVgtCTNvrUztyRRoDIkDCljEUqgXy4K9/J2ISizNJSRFH4h3IhoviPoQq2P8/RNpgmTgjee5b6tZtSi/hGUFKugSKCpfDQuKjZjik4grozrHIyIENKFkFDzhqigKOwNQH55hnUSOGfm4IdT356LHdBZiseuMPrRHQjnu/lZylbaQkh3xq0yD5lvU3SlRwp/241ouJ+eOEmaTEl+sZhze3nVLSmTgjL65nnn9PKClzEctu5R4bhRyDcL7EFtIjM9FHp4PjVQME12q6/WjgVHECKXzv6sqsYSQxn4qQBz6wF9B8W0WbvwTryqtcBZScV8AZdS9Y48THcvsOzXCXkpNXD4Q53Ee2b+Pxl82sXg3Dv8k+5s42KHxcFlRSTyok0WAA/UcFF1SgJo9vVRb279LLfjVvDHM+5fKboJMRCQSSHCP6RbS6W0/cz/9vFU+um7yD770lIk1oewtOGzQgyDUoA1WRkxjmeSxECHdoY8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O0Ol37qRtdTa+9SFKp0pAdZ2YwgWuXWbdazzhYccasjylKHd/TJxpU4HwCdt?=
 =?us-ascii?Q?HKJHDbOFVsw87LXdSuZ18yR07g7Umf+mIj++JK6aLhSD1zXmNfqg71aGJYIK?=
 =?us-ascii?Q?iGXep6xylA4zO9SCVBHXYkv6SR5XaDw1gS1wsc+jDY+Dk/+FrJ7hBd9i0hck?=
 =?us-ascii?Q?I7/MFsUwOlbPemA/aw0tpuHyb0tZeX7tAc7pWC36IIJF13QDqVHWGRwiDGQJ?=
 =?us-ascii?Q?acSbhmULEF1YLZakGcCwJZiXmQ5JeXUGG/t1/pq7/bp2tTVu76GvdpnLhQNu?=
 =?us-ascii?Q?b53xx5l8aO2KARKmZbn97ZphhE7d2UgWz5kxhH8j7vFjIIZo4YyXu+WKTzok?=
 =?us-ascii?Q?aiEZxVg0BVPdd/2ZtTWBKS+MWE0w28vkKWIAecE24oH4GRkq932VY0JxNJkJ?=
 =?us-ascii?Q?Z6BpyK4WE4IjLzeN8MuZVkDr1GIrTpRwOqRRLE6Z/93GhKYPfs3XLC7GE98S?=
 =?us-ascii?Q?pOxFxz/SZ1RItRWtN612aHJCsi+2U/9I3ocIHstlcvAW0CJffMTYcpiecVJb?=
 =?us-ascii?Q?ISHvIfcN3j30WRZIP5M21CFXIG7D5/ueo1e3Ulj50wUbA1iI7oRYP0uTgLRx?=
 =?us-ascii?Q?+dw472x7NZYKk+eTNRI+fcfJR+YHGgeYEXtip8F+uoSx5shKEZ7u+pnOVyFk?=
 =?us-ascii?Q?7U3CGmZuellnkYBFpO9IaMEBjfZHlm0+L4n7iuKJiep61WbiIvaVhD0ZS3za?=
 =?us-ascii?Q?RyJ1H4jUhQINfTr3beJZGyBa8sDL5iyDzLtf12qsOaPuJWrLosywu8p+ocnB?=
 =?us-ascii?Q?RFd2AHvE0+v+J44T9LHl/TvnX7CwlTKBA5tEppd0o8ZLsGTfqi4MGOdwUEqy?=
 =?us-ascii?Q?jNU3X0aL6/biEVchoFzDFegROnz92uHby8m8KZFb/eBAWvi/o9UK4SKWIG+z?=
 =?us-ascii?Q?ntpRnBLyyyNDJfKjrtPK2VfI0q091syZZjBY1fi2v7mNrlsPUm6FitFbGBSQ?=
 =?us-ascii?Q?wfnk6/t8tgLkG328szW77o328l4Hv77TAz0veplAtBqrieFVN+Rd5x98cGAF?=
 =?us-ascii?Q?6kHFaOtdAdodIGTthgm5xHXf2flhur/5SKSura8mZZXFl0cJVHKqw6QyVviU?=
 =?us-ascii?Q?YTXb55QpCfNaSnd3DlLaHmvoKIFTXbUXYM6snypfb6Iy891OTYql0gKNLY7P?=
 =?us-ascii?Q?esnzyEQcg7H9+QefqRiUORKD1g+7ucGPzpNBVtUcWltq/29ir5kemecB1iGz?=
 =?us-ascii?Q?rssBJOzrFUTNDq/0Rou+v6qxMiI5KqPVpsOPcZlLvdgIetLwWPbLsVuPQkgU?=
 =?us-ascii?Q?5zeECS1DXBfVqXovBzluY2yiWni2ajdC/Jw+i01ljZMNKNQ+XQIt+rx74i7Q?=
 =?us-ascii?Q?ccxgYpu8bfOsG87VXqHvoeUKdk8lu8/H8VsG3w/5IihI9UwkGUjEwRn14wtq?=
 =?us-ascii?Q?2Dm249uusBv7ox9mX/p8nnHRuwiWm8pK0g8e/090NC6Uyb3fgsnBNLGroGoN?=
 =?us-ascii?Q?U00+6y7TydcVwnXauK+ksZO7mdExxegOSLE913BRihBBtTcMBHALQz+57i1d?=
 =?us-ascii?Q?rc0VcxgiMhhDUEiwUMEp/EzPjlTbq4PV5vbgwsTRhC6e/lk4QyMrKMSi3ys/?=
 =?us-ascii?Q?FmmzP9ntfVg2v1id/vxWEkGPOSqlilb4OLoMi/owPeO3zljtexiah1PFkQ8E?=
 =?us-ascii?Q?YF/zb3Rj0NfRCSlCPCjzHZPsI0v4LrFGHj4N7MrrlBDO5GVZ5B5R2yxxujs9?=
 =?us-ascii?Q?fBnPXc4TSOcrE9rHTa4N+j/FViIpzA1U9yRRfychQ+6NqlKxZH2VkvqTOLQT?=
 =?us-ascii?Q?vVu6zkuSsw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be380f47-7f43-4328-1ff4-08df08b2118f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:21:40.3093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuF0i6OaQgdg5P0rT4X/RSLaHyd2QBDT0WYF+yvCxMgOQchfUKDpgx1UAR0iTfMiNqLlrMObeEpvw8GV3sbwYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345
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

On 2026-09-01 at 17:29 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Tue Sep 1, 2026 at 7:09 AM CEST, Alistair Popple wrote:
> > On 2026-09-01 at 14:50 +1000, Dave Airlie <airlied@gmail.com> wrote...
> >> > >
> >> > > We should make the NovaCoreApi just provide an accessor for &Spec and make every
> >> > > subsequent method we need public. Otherwise we end up with endless forwarding
> >> > > methods. We can also add as_raw() methods to the specific types as needed.
> >> >
> >> > Ok. This is where I don't have a good instinct for what we think should be an
> >> > accessor/forwarding method vs. where we should just expose the underlying data
> >> > structure and required methods to API users.
> >> >
> >> > In the past it seems there's been some resistance to exposing nova-core or gsp
> >> > data structures like this which is why I added the forwarding methods. In future
> >> > we're going to have other data-structures that NovaCoreApi will need to access
> >> > so it would be good to understand what we should do here so we can keep things
> >> > somewhat consistent.
> >> 
> >> We can expose structure defined in nova-core, we cannot expose
> >> structures defined in gsp bindings or firmware.
> 
> Yes, those structures are not even exposed to the nova-core layers we are
> dealing with here.
> 
> There are the structures abstracting firmware interfaces, but despite exposing
> trivial cached values, they should not exposed to nova-drm either.
> 
> Instead nova-drm should call into nova-core and ask it to do things on its
> behalf.
> 
> More in general, the same is true for any other device resources. For instance,
> we also should not expose the pci::Device or the pci::Bar to nova-drm, but again
> provide a higher level API.
> 
> > All the fields of self.gpu are structures defined as rust native structures in
> > nova-core. Their values may be decoded or derived from GSP responses, but by
> > design none of the raw structures from gsp bindings live in self.gpu AFAIK.
> 
> We could indeed expose all values from struct Gpu directly and control
> everything through visibility, but ...
> 
> >> In theory we can internally between core/drm but I'd really really
> >> like to keep that boundary as the limits of GSP for auditability
> >> purposes.
> 
> ... exposing struct Gpu and controlling everything through visibility still
> means that we could easily miss some device resource being exposed directly to
> nova-drm, which also includes GSP abstractions.

The individual fields would still need to be explicitly marked as `pub`, so it's
not like just exposing the top-level data structure suddenly exposes all these
device resources without them being explicitly marked as accessible.

> So, I think we should provide accessors for the major structures that we
> intentionally want to expose (so we have an obvious boundary), but not for every
> single fields inside them.

Sure, I don't really mind either way. I just figured that's what the point
of Rust visibiity was, to provide a simple boiler-plate free way of saying a
type/method/field was used externally. But will switch this to using accessors
for major data structures instead given that seems preferred.
 
> This is also why I said that we can expose an accessor for struct Spec, which I
> think serves as a good example.

Ok, so just to double check are you happy with an accessor to return
gsp_static_info as well?

Thanks.

 - Alistair
