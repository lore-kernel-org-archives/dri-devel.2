Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F8AC79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2F2110E189;
	Fri,  4 Sep 2026 07:49:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gei6Cc8/";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD4BF10E189
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 07:49:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHqUXDMegkSGU+3ABAMZKuCfnLC+NhL3FLfg8VYVM9Y0VYw70L93O9oiBXed140N0NZbsT0iUC6qK3hY69YPyuUV8ckXEPnEaxxk2sGGbCqtc1vfcOBIIhUcOy9gUoGLh2DfCzveLRl6oZuS010vEYsP2xynuWpfHGC9t+Rp7zu4QxVJMNzAKsYzNg4Q9a86HPNsDxnbGQLLsjQE4ZUonEzZk8M58W1rAy0xIJm+jfubok2AnR8elQGXxm5vJtNSWo7sbrGxaFw1TkD+m+KuoG8OL9wZSWuDMZHxFitBLH4kSCKoWj+XYOWRBHkCFCltAxmc7ajxgfq54TqzyTlNVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCppztHwf2rgIAOOJF31ZbuygvbNF4VCgXpEbQ+BSdg=;
 b=LCOmhVrwoU3BU7xwSmzrzDlvF2psgS7kspl6a0ejQBdmcIC9xC/fA9uUlKLThP34mcb9TqdPyUPDo9lJUoQURFqu5v182899hpcimuGoP+54+JBrvApsVdwGo4xwjZNlNDPmZoezj6Bdn//e+Uzdphz9oZ/ZA8Mr/OLOyIf/pTKTye0q/KvmS8K/suuEafTvrcAUi148cWCchPSWCilTkozY9qM2y9xASqxMQCxijr5cw2RXP/2iBS2lTLT4MnkLQcURP5T7x+Gqe4n7nx6nDl72ueGlxv1Y3mDTe/Y576Hwe9l8Fh7U3fTrGSfXgd1st0N9ACiJYtUZQKaQMrHY0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCppztHwf2rgIAOOJF31ZbuygvbNF4VCgXpEbQ+BSdg=;
 b=Gei6Cc8/j+nn7B4Ah3xcNAhZtDvi92ivG1DHWGDwPpS0KVnx7fzr1f2X5DhBG24vNBsmu0o5UzfdUIRW++KbOvf8Oq6aQElRrNvlUCfIpc7aB8Zj/f1Tw2t+lDO2uYC/McYvffv6DhYpxURZx8KSe5kh3c8DtZJSVEN8DhhtJxCz96rZyBIJloDG5dGY9Ye4yX3UgpCDS4WMtxK7FysPhGZMffK4Hm2czsUgz2csUTwbyReNYBQLgnflTO9oSlq4MCtsSxU2mK2ed1RHJ5zw9Ph41LygTvxWkoVKm7QwzJmDbgR3vPzYCSCHh4xUukh94ql0x8Wv89Xsh9Tb4aHSVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 4 Sep
 2026 07:49:22 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:49:22 +0000
Date: Fri, 4 Sep 2026 17:49:16 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: nova-gpu <nova-gpu@lists.linux.dev>, 
 M Henning <mhenning@darkrefraction.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 05/11] drm: nova: Add an info ioctl
Message-ID: <appc5-0MRW1XwsMh@nvdebian.thelocal>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
 <DL3WXUPD5JKE.2GZ1CNJH539ID@kernel.org>
 <DL453EFS03T6.2VGI5TJEQ52QO@kernel.org>
 <apdvTgAp5eGezO5t@nvdebian.thelocal>
 <DL4QCAZXM8EU.2K8MLAM00VNTX@kernel.org>
 <apioGUDamrCur_oR@nvdebian.thelocal>
 <DL5MA26KZEF9.3KHKQXZ4JD2G6@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DL5MA26KZEF9.3KHKQXZ4JD2G6@kernel.org>
X-ClientProxiedBy: SY6PR01CA0049.ausprd01.prod.outlook.com
 (2603:10c6:10:e9::18) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cbe5fa2-7479-460e-db90-08df0a5908a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|23010399003|22082099003|18002099003|11063799006|56012099006|4143699003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: fjVdifVBDLSEzum9+wGXGyW8pdv93GxqFuE4mFwWZc4/NSeOg+Ou1sDUdGJt+dh+A0Un/xICLh1TA1EVjRuSCJZp2MzXLVSASwTXoXs+UVOHB9HneLh+PffWegyF0wf7PeCCZczfmiDm+tMRpjoD3H/GDjmTFPsl7ebksL2m/Dy/DEXYDk2lJCyqfVXk9Ag7kKprqSWFa8ZThA/7+h6BM8NKHPYVSyWdWakZ87+qRy010RDbpXIlqljkoofERaf9OD39yPRKMK/sYbciu8hPSlIw/0dRYC5l8Gbbz4XDTQ6HkHs9ySkFnzFdFvmUQhneLjEktPEBeKh3HABmNaP2I57ehYjQtxBcmgLFWXjQXwiBX1v0sNAmtwrUp8QfxTm2Mygq16Vl56J/t9VC5s++guunaz7VUjahKIaDR4xFjU1L04QkjPNJvb08gkop8k9NcdVCFrBBWMVAgcdfqfkz5hVOtLkbwUQ+D4Q11YWbGIR2rTSIxR1GDDaaDIeFwOefjS4NPFCLkpYm0K/SPQLTZ6JaXczS6Gp8HqCjYpMHTHxe/PYE6faoZ4dxENv0zqxFHeE1DGsn7xu3Wi7WhzaP9V/WSMJRzO130WctV2+ashnlGUYioTsfUz2sIUNRFsghSlfgZcVDFxmCZKQ+QCBO15tB1OD2AN3TaMbxhXwup7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PQyJckh054qLNupketASrUII3aa4cxNgJ112gdgvhxOx+w3qcEdDvIqphAEy?=
 =?us-ascii?Q?DUvT+9UXF/f4oY/bQUJ824h/l4EiZeG4trKRNVJ7lju4w1SNU7aav6aUnhp5?=
 =?us-ascii?Q?RfdRC3mJZevYjdDrjHC7tCJjmd8hN2z52TgwT8IFE5uc83cjbLeP+VVRo7D8?=
 =?us-ascii?Q?3bE/9hObS848O9FzZMAioIvkbHzdrDi6fW94atKF53u8YlBSrPxeyj9JHMS/?=
 =?us-ascii?Q?dtz6DXAVUaf6IBOLN+zYUYFiolswV6XfIqYmoBywaCgG1EqZGzofkRdlxnxs?=
 =?us-ascii?Q?6pWD0/a5uW+Hpw1AjIZqzfc4d/gd7DZkldLrMqwYNBtOeEH0bw+2kJLonuIH?=
 =?us-ascii?Q?dHbKjtKbJdBBUOCxQCC+QVjzCbNojHk5T0iPlgaMKeqUWhSLZ5I/+8Gzk60J?=
 =?us-ascii?Q?IEq/oWuOMn7wTQKJ3QK72P/eB8zlAjnqjZRjcQpVgc5uxYMBqietB9RwcMHY?=
 =?us-ascii?Q?AHjOeoCelGwXtl7WhiMs79tPAXbArAtD1O4HAw/+8W3ik6WIq1Y1SDZcV7Qg?=
 =?us-ascii?Q?QzYcGbAyDli8lVCoDGe32sbs2U8upvvwpV9E4GpVA/FUA9xq753Td4C5v1mJ?=
 =?us-ascii?Q?TYQOyDXYIPvDTZUZ5/4AycYcER78fu3FlxB5NhalNYN3atCTDSM86nEHoVN+?=
 =?us-ascii?Q?bk03N2NP2f58ul/mqDs0TGtquT5SGGiFzKmoz9dP6W47b0ttQF7k1tVlOgVW?=
 =?us-ascii?Q?xA9bKf/3CQObHzl3Izpw5keeOPnMCg3HMl9VGF8hK03+UbECurxtIkS73rIf?=
 =?us-ascii?Q?F8C+op7ZPA/EnQHK4FpaK0e+asjSeHteqVFrNBNrK6f2aESHp4zuBiptxCSq?=
 =?us-ascii?Q?MtBlcSJgMQsuG5LMcjJC5gHpRLBlKauFnFIllpRiegLtF9FLJfepDbKWIpIA?=
 =?us-ascii?Q?Z9NjNOW23YFr7Gjd8DX3fFqqPy7ttPWFleKsb2VrH4U/klVJhpNuXJGaYnVD?=
 =?us-ascii?Q?5b17nSXLPIIIZZrloJn9FgiCTr1DOtnCigc6+XwpqOfWu0KoOBXkDzx/RJX7?=
 =?us-ascii?Q?zIM1TBJ016iV8YP8qq+IgRr+o/poePdxGz+4+JkjlFXNuIR9A7Btr6V9PDLU?=
 =?us-ascii?Q?lXSvdGr2Vb4myZjaai7Ijpnmr4Udi6a/azy4RubIJrsrdom9OyAabO8BZxGW?=
 =?us-ascii?Q?Q3e85YNApY5Wib8kmMgBWz+LPUJjgtG86vlCud+0+nLUx90ZmUVU6/EUsAqe?=
 =?us-ascii?Q?fYY7b3Mx6JEqdBaCEzbhvjijeVLtg4AW7u4ky5oGad2fPZcIYAtZOdXYNN1p?=
 =?us-ascii?Q?HJ68r6j0l5BdI1oiEoi5ccPvwxZNTZdVCWYRnFwEBRfBRfySNSqC2x6NZdRN?=
 =?us-ascii?Q?RNvOo5bIqwRqk3C0fmI1W7Vgmeec2sI6H4i8XYdMwhyROugUETEfajw1Rnhz?=
 =?us-ascii?Q?wqBO63OEZzK2dXLC4M84QEZpRmIWx/Yf6YuSLLtUfYkvC8U/g/8zqluomlf5?=
 =?us-ascii?Q?rlMnlSgG2ieXp1u2oab29JX04zb6MBFhFZJmiup9H5De5z8HUs4VEaAnWFj5?=
 =?us-ascii?Q?z15ymJ6fBgvnejMYwzCjaYxVgqxJiRp2cy62FK2uAILVoYJkTPjq7aVa2Ki5?=
 =?us-ascii?Q?WsrcvbEXVIy0LeUqgR6/2zRU5B5bt+r5AcWeaCNujHgau2/OWngqHK+2BWWP?=
 =?us-ascii?Q?ci1CWgCundjFe5ObEHj45bGiLTJ1ivEG+joeSIV3bZJQpDqoItwC60JBfrgs?=
 =?us-ascii?Q?HBSvEqczWBhoHjX66SDha7bsiGImwFbzgeUPU4drlxBImwZSfapa50ZFnil9?=
 =?us-ascii?Q?p38jg+m1mA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbe5fa2-7479-460e-db90-08df0a5908a8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 07:49:22.4888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uG/5oirkPIJfrjPB80LYyPXjrC1UUCddnroSDkQbs4CIdFETnbuIQy1SfFLEvGy/7P+yxfo+XLQBFT0YngvbGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
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

On 2026-09-03 at 20:42 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Thu Sep 3, 2026 at 3:12 AM CEST, Alistair Popple wrote:
> > Originally I thought the point of providing the decoded arch rather than
> > chip-id
> 
> I think there never was a "rather than". The point was that if userspace has
> conditionals based on the architecture it shouldn't have to figure it out based
> on the chipid, as this has been done by the kernel already.

I see. Maybe that was a bad assumption on my behalf, because I assumed that if
you make a precise hardware description available (chip-id) there'd be no point
making an imprecise subset of that description (arch) available as it isn't
particularly useful if you can't use it in isolation for any generic purpose.

Which is to say it's unclear what generic properties users are allowed to derive
from the kernel saying "this is a Hopper GPU". It's clearer for a chip-id as it
represents an (almost) exact piece of HW with the exact properties of that HW,
so userspace can derive everything from that.

Anyway guess I will just leave it in, time will tell what use it has, even
though I think it would be better to know that use upfront.

> > because as you rightfully point out the kernel doesn't (currently at least)
> > care much about the implementation
> 
> I still don't see how that value will ever be meaningful, there is no such thing
> as "all GPUs of a certain implementation regardless of architecture" have
> something in common, is it?
> 
> But since you say "currently at least", are there any plans to give this value
> some meaning beyond being a unique counter for chips within a certain
> architecture?

Oh I just meant AFAIK the kernel isn't currently looking at the implementation
because everything it cares about (like the HAL) can be keyed off the
architecture and that's been my experience with most of our GPU kernel drivers.

Or IOW, at the moment, from a kernel perspective the kernel doesn't care about
implementation beyond needing to encode that into a type. So supporting for
example GB203 instead of GB202 amounts to just adding the encoding for that.
If we didn't need to add the encoding the kernel could say claim support for all
Blackwell implementations.

Of course whether this remains true generally requires a fair bit of
co-operation from the HW, and I'm not sure we're actually there yet although I
think there has been some discussions in the past.

But it would be a nice place to be - having dealt with similar problems in
the past on the CPU side it all becomes a bit of a pain constantly backporting
patches to a bunch of distros just to allow a +1 on your minor HW version that
the kernel doesn't actually care about anyway.

But we already agreed this isn't something we can or want to solve here and now,
so this is really just an aside. Maybe one day we can get there, but not now.

> If so, I think that'd be a horrible way to encode some chip commonality.
> 
> > But we agreed that wasn't desirable, so now I'm still left figuring out why we
> > need to provide an arch value? The chip-id already entirely encapsulates the
> > concept, so what can/should user-space use the arch value for?
> 
> Because userspace otherwise has to figure out the architecture itself based on
> the chipid, while the kernel already did derive this information.

That wasn't my question. My question wasn't where should userspace get the
arch, it is what can user-space use the arch value for? Again, architecture
alone isn't entirely sufficient for user-space. There isn't for example a neat
mapping of arch to sm version for code generation once you start looking at all
our GPUs.

> There's many ways userspace could do this, and I don't want to incentivise any
> of them.
> 
> For instance, you previously showed how userspace derives the SM value from the
> chipid with sm_for_chipset() in mesa with its own lookup table.
> 
> Then in NAK (src/nouveau/compiler/nak/ir.rs), there's this code.
> 
> 	fn is_turing(&self) -> bool {
> 	    self.sm() >= 73 && self.sm() < 80
> 	}
> 	
> 	fn is_ampere(&self) -> bool {
> 	    self.sm() >= 80 && self.sm() < 89
> 	}
> 	
> 	fn is_ada(&self) -> bool {
> 	    self.sm() == 89
> 	}
> 	
> 	#[allow(dead_code)]
> 	fn is_hopper(&self) -> bool {
> 	    self.sm() >= 90 && self.sm() < 100
> 	}
> 	
> 	fn is_blackwell_a(&self) -> bool {
> 	    self.sm() >= 100 && self.sm() < 110
> 	}
> 	
> 	fn is_blackwell_b(&self) -> bool {
> 	    self.sm() >= 120 && self.sm() < 130
> 	}
> 	
> 	fn is_blackwell(&self) -> bool {
> 	    self.is_blackwell_a() || self.is_blackwell_b()
> 	}
> 
> That's two unnecessary indirections for something the kernel already has
> available.

Again though is what the kernel provides in the form of an arch actually useful
to user-space? Obviously the code above makes it look nice and simple like that,
but as I have been saying more complete implementations can't just rely on arch
alone and so are still going to have lookup tables both for SM and for other
info the kernel can't provide.

Anyway at this point I'll just leave chipset and arch in. Clearly you think
there is some value in providing it separately, and I suppose it doesn't make
much difference just to have it there.

> > It really boils down to how much static config info we want to encode into
> > kernel lookup tables vs. user-space lookup tables. I don't this we should be
> > filling the kernel with a bunch of static struct lookups just to ship those
> > struct definitions to user-space. It seems more reasonable to put that in
> > user-space, unless of course the kernel needs it.
> >
> > So I think your "does the kernel need this" is a reasonable benchmark for
> > deciding this.
> >
> > As I think you're hinting at it would be ideal if GSP or some other firmware
> > table could just provide everything in some nice static config table, but I
> > don't think that's currently possible and looking at other user-space drivers
> > we're certainly not alone there.
> 
> Yeah, although if SM is correctly reported by the GSP, I'd rather have it
> exported in an info structure than have userspace create its own lookup table.

Yeah, although that would need to be a contract between HW and GSP and GSP and
user-space. That's fine, and can could probably do it one day, it just doesn't
currently exist AFAICT.

 - Alistair
