Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6D7C61DB9
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 01:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1EF910E09D;
	Wed, 26 Aug 2026 01:27:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="LR9YpWF/";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013036.outbound.protection.outlook.com
 [40.93.196.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0D9E10E09D
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 01:27:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/C1gFNt/WYp8Nq/V4tgijVGSuiqELw9rhjis0zJE9ZQzHGPACItZdxflwNrWBRnNF4isr+Srgf5m1z6MQwGlvuHqUV9TSqH3WzNnY7DZ3bV38nChsBF6ujc4HGHxmWxTcpvW3IImB5z5ucNPdOedW0VU0Wcg+ODCCUsGo639ovs3fC0UNAnd3t+dy7uxH0/spDrhob4zPLj6Q28EbVQiWNUx9pHq4jbgoek/yjhMh5QVDzTrXdgMxpX8OLdjSjSk7wxm+W1cxAALqM3NEFCVkgOQjIK0PkLu5q17FgwOxsoOhXHLP4YhocXomoX9mwe47Tmz14fcmUwIROfFykGUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BD9PUtYZwpPhEpY3kI4VHrInGDgdWcpXkelQbGihT2s=;
 b=b9kaw/Cl5lGRUG6zSjEy+Dw3nrpqWW/VH+tHPXFoU4XD7qdUVuD3qii4jK4U1ju/dgEhp7Qqkxw2dgrbLhAHao2DOf+wp+d+2GA3U0DRg7+bSUgyU01AhMiZBYScqmCrGd8PUJOEbr70W+bCb3etdbuD6PWXa8A+MolDfvULjG+4bxfeWdu0frW6UUTN1sOYAtfSW7ZVeHwi5haAN7X7vUtMLeOnWl/1wjQPQm4CTUsH+VXwrDA/OaW/B9kzxO2PQw4hmY9Hg+Os1gZx0/RcZcSE4313Nw2thAYPking+j4566HQfCSkXWMlLsPBKaX5zPkBXNP5zqbkL39DeJNeDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BD9PUtYZwpPhEpY3kI4VHrInGDgdWcpXkelQbGihT2s=;
 b=LR9YpWF/kVhRoXHtoTKDfzLRbC0cmk2wVQy1lyXJJjUWgaVMINkClwekArh1ROokH7X+Y+iGJO/8VR+gC/snTkT/pOhrjZXo5lnPmjYvCImnh1DgQVqhWcwMZGWxysKjKBjvZ4fV8hdvIKTvuoyf33dS81wDMYKC2Xomg26C3jq+9B8X8UykPmZ5fHMXGNfuRci0CyBJz3cLm6zGMPk282sVrYrEfgX5TRzr974JdyTm+BpnjVkPxl0SwNhgstixkt1ks+bhCnhZyZiOqKIYjgAyjiEG3CcomP/mOrgMqPMfocX27VM+tDkt2saPOoevmVKxPulSI8L13p7DpYC07Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 01:27:18 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 01:27:18 +0000
Date: Wed, 26 Aug 2026 11:27:12 +1000
From: Alistair Popple <apopple@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, 
 M Henning <mhenning@darkrefraction.com>, nova-gpu <nova-gpu@lists.linux.dev>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 3/7] drm: nova: Add chipid enum to nova-drm UAPI
Message-ID: <ao48Kz_vDm8Ogg9n@nvdebian.thelocal>
References: <20260811050657.646799-1-apopple@nvidia.com>
 <20260811050657.646799-4-apopple@nvidia.com>
 <CAAgWFh0VvY4D=-Se+bVO1YonRNFEa28nc7+ZbxEbv6en7oPaDw@mail.gmail.com>
 <DKXF49DF656E.XB24SXGL3RLE@kernel.org>
 <ao062w9fdaQEEYHy@nvdebian.thelocal>
 <DKYBNF427ALE.1OFETHRT4KNHK@kernel.org>
 <ecb0dc71-84f6-4a0a-8bcd-d38b194630d3@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecb0dc71-84f6-4a0a-8bcd-d38b194630d3@nvidia.com>
X-ClientProxiedBy: SY5P282CA0021.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:202::7) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b91fe9-9eee-4a17-df24-08df03112acd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|7416014|56012099006|10067099003|6133799003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: wf6hICwD+gFxdOuBvZHH4b1kPnn3iXOLgZX5FSmpd3VkobE5c5BwEIwTMOPeDTk977b68xd3IBuDm9YBNlLrIdB3h9hzzOwo09tcfOS+JDG5Z33jE91QnG1wE7CbwVAgacSZSo3CA8mSgrvEDKdgg117AJ8LHqtqOv0A8vOEcE6p5Iy5cYGizy+DFm4tedxPz6V9sty0f03dBzkYLxdE8Z2c247rGU45yYJdJbmxI4U27tBj7xEMeZNsZjWf5VXyQ3qToJI9nYw0FN23Wd1Nq78QzFc+Wr1h/Wrdso/9saM5kqvp+Ym7UKySQof0amITAe3LDabjLsC9SmkLGEzZ9LUSovVGefLfdtV7+WDZRlmZkqAfqZbYyf1DSWrtKf7kvfNmMgi1Ci5DUAJ1RTf73ZH0naL8zE9ckLGN+VsVEoCP5AuM1vaHWmTslx1HoJAOOn7GZje5vkO68YhCjml1m/4bCKL8RUpPJN+X0MMQ9bU1HXtlKQJjQuwwBZ4lX0wQbi4tvtRwG+5NUWBYxmQdsq5QS7Y6KRw1cabW7arFZCJTbX+uBg5qyHZURniVC45fZqwLnjc2Hp9JSAkcPgpEGzO2eaDxLzeeyawaeDRnTMrQ8N9Btyfg0BxllNiz/05weSJwEhlY1VjuYZexTW8PVbEEBpG5Rd6Xl9pKIi8KvOI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D+DYsXpRxpczdfrqSpz4bUTbuLEiJKCypDHH2M/k6BYUF6Nt87rxjZIyRbZT?=
 =?us-ascii?Q?US8bZJ+9f9iBzSb3sBP8Ctd50vO/tEf9QjiBHEClaM0Q6kfUK0ChITQm4F79?=
 =?us-ascii?Q?gdyktqrh3xw5llbZjAkGExBw7/NbUbNdIW9rEOsKQ0hPojUgERtOC0PtfVFO?=
 =?us-ascii?Q?Kp5F9mvn1vIZ2/Bfs493mo/sV69kWHNivj/cCOuh08ih52It3jJZcxe1qvjh?=
 =?us-ascii?Q?DwWzorOmdYz8PfAjUsUj2e+UjWMu5+6rA0nRdpdJWdP4eV3fSlkuTlc9tEGI?=
 =?us-ascii?Q?kDPPMXs3VbF1VnEr+nPM8KT2K27lkDfDe9H3u6DS4HLpkZNiiTxAMG1nJZW/?=
 =?us-ascii?Q?4gQYObk0Xa10FarYlzveedI8c2YoXT3thWPY5FlzBcokOxQJzeWN44UG1ZI7?=
 =?us-ascii?Q?w3NUtGicnFR3KOUc0hd5DNBtVFUAu7xEUqc3f4RufarKkhnwXdjNvjKm2V0Y?=
 =?us-ascii?Q?PtBXqIVaeq3f8CxUFw7ip615PE6kNuV7mAU2K7oz68x62KgzvAG8+nBZhw9n?=
 =?us-ascii?Q?4PeL0S5Ph7fQCyszL8rIyjVxP3j9sfTSJd8iy//vMTVacQyQmUzqf3wnFnAw?=
 =?us-ascii?Q?khuxVm4CjKCMUnNKr4/HjqnGeNwsuSugh0YQ4rGepvwSfikF+ZoN6YUaScQS?=
 =?us-ascii?Q?cX4BAqltaYhcSi/NRL4uUmKqelgXMrv8VV6wbAVfA7Xor7JDxqj87169cIJs?=
 =?us-ascii?Q?Ulq/4A5e7S+ouz04+pLt2XAa4e09sBXt21a5a+H5MeWpNRfB/hMYnh760h1y?=
 =?us-ascii?Q?+N4Mak+7KzghjoPS9fDLvFIxy6b2FkBQFZz+cWWoiIP/CFuDFYux9nPUEx/7?=
 =?us-ascii?Q?cdQ14236p8gJAw4Cts2ZhNw/zp0jwvsYLO/bfQsXtEEDq5bFfRRJIVCAMxjO?=
 =?us-ascii?Q?8IEITDB35oVaEdK7SJiPdAFqHfG8v6z8KSC5+AJt54dY5k9yNRo+C2Uxw4qJ?=
 =?us-ascii?Q?tdKKdKFdAw753HU4olMtDG6x5nNMLzXvYbalKIrnz+LlYwe+Kv42ZXNQia2P?=
 =?us-ascii?Q?OzxmvS1wPZ8mJQeYNfEWqvvArVLUwZ/MkOqYgP0KxLlhsGs+EE+nQwETeBcp?=
 =?us-ascii?Q?Owp2EOaIwKSwsQ1k2+T7RgHDeTpX8PUeii0F55QOisw1agsO3tuaIF7RcLpS?=
 =?us-ascii?Q?ltDubAbJTS8sL1ShNElTSdJpARI55t8birtsr1WM4OruJZeDawIkkq+TJkr3?=
 =?us-ascii?Q?FMja06hdSYijsZAV5wSFYGRkEojxYF7BUK0XaHdW2FG0OFc65oKCHjEasPag?=
 =?us-ascii?Q?uKfvXZuLyN+H/wRuUX4EdS29ZhSC351nIH2Bzq6RzIAEbCqfjKVn+88Ctrgn?=
 =?us-ascii?Q?p8P0WCyZchake5gl4D5+PJj6p/HeFJ9gdx1KR4dqiCf3bP5GDopOxgN7m/Vr?=
 =?us-ascii?Q?hQkYXqXURjoUh7TyeyFfwLkFMvi0E11v8wYJpDpHmaFW1ip60RKbNEvnx0+Y?=
 =?us-ascii?Q?mMvmCzDJZvDQ2VQUsvT4c/UosgS96m53A2yjXsWi/nUpNn8nU2GrnHuhi6pI?=
 =?us-ascii?Q?IE2K+L7rlhAh/VrTCw5J+mTejO+9Fss5mRLlFUS+fjlSSa7UXcGellezzRyX?=
 =?us-ascii?Q?/cfqaw+wuQRtXJhtO+Yjg60b8jAIMMcXzganS34QPwuAqpNXtpBP4G4Rg5xF?=
 =?us-ascii?Q?bqyfGKcetZ9egkEriZzslepgJThj1USs52O7W5CiRVT+q75djHCpy9xNAXKA?=
 =?us-ascii?Q?Q3oO7zJqq2kfHqYvkE/Q1AOyDnKCeLSis75s7fqwQL0usO3RLVQRmwSn3OeL?=
 =?us-ascii?Q?fPuqfQw1gw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b91fe9-9eee-4a17-df24-08df03112acd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 01:27:17.9728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qg7jRU6N9Rfwk5aUZkkzzvfiL3ozHOdLipgQNzPrBlhGOo8gTqwnrlc5nDZDy8PRLhn17a5ZlU11JPg+ge0xqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
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

On 2026-08-26 at 07:13 +1000, John Hubbard <jhubbard@nvidia.com> wrote...
> On 8/25/26 1:53 PM, Danilo Krummrich wrote:
> > On Tue Aug 25, 2026 at 9:13 AM CEST, Alistair Popple wrote:
> ...>> For example if someone plugs a shiny new card with a different chip_id
> >> register layout into a machine running an older kernel they could get an
> >> incorrect arch which would be confusing. Users would get upset if for example
> >> ShinyNewCard got reported as being Turing say.
> > 
> > If the kernel can't deal with a chip it should never succeed probing and never
> > expose any information to userspace in the first place.
> 
> Agreed.
> 
> We had also some discussion about this point during the BOOT0/BOOT42
> change-over. And we arrived at that same conclusion back then: don't
> let PCI probe succeed on an unknown new chip.

Ok. I thought maybe with GSP providing a lot of the HW abstraction we might have
been going somewhat in that direction. It's something I've seen done well in the
past on other products.

> > 
> > nova-core does enforce this already; if a chipid can't be matched against an
> > architecture it won't compile, and if the chipid is not known by nova-core it
> > will fail to probe.
> > 
> > Note that nova-core binds by vendor + class, not specific PCI device IDs, so the
> > chipset check is our only gate against unknown hardware.
> > 
> > If we'd hypothetically remove that gate and just allow trying to probe unknown
> > hardware with the boot sequence of just assuming some default with the latest
> > supported architecture, it would potentially be an even worse user experience,
> > where instead of a clear rejection of the hardware a user might experience
> > security/stability issues.

With careful design it can work, but you're right that probably isn't something
we're doing or want here and would make the experience worse.

> >> So I think it makes sense to keep this decoding in user-space regardless of
> >> whether that's exposed via documented opaque chip IDs and lookup tables for
> >> arch/implementation or by a commitment to keep the chip ID register layout the
> >> same.
> > 
> > I still don't see much value in letting userspace decode this again, nor do I
> > think lookup tables are necessary.
> > 
> > If the driver succeeds to probe for a device we already did decode things, so
> > there's no need for userspace to do it again or know about this.
> 
> Also agreed here. It's hard to see any advantage in decoding in both
> user space and kernel.

Sure. Two questions:

1) Do we also need to provide the decoded implementation value?
2) If we provide the decoded values why do we need to expose the chip-id at all?

Thanks.

 - Alistair

> thanks,
> -- 
> John Hubbard
> 
