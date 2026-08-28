Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39ABFC61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 17:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A8D510E05F;
	Fri, 28 Aug 2026 17:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="KxXTt8aL";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20C8210E05F
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 17:03:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3mW6c9NRBN1ZpAzw/zTBF4EAjvF0KhuE7jnuu5HLG6pIaiMAGohbgLYxRt11q7AT23/CHPjiSqXrfRjpHILvikGQuRQ2C0ZJDFJAzIFjnazkhturnyKFm1gRQ2751h7RXnCGv0iQD4qTLh9XuWRCDPp4QkP8dmDvrVfcswSt4mwLTnLy9/1vvU9YEqNA0BHTZmLn4CBvmgfL023NX/KiXTy1wbJ52OQJG3LDYPKWL+aDDfA0S/1iK5QzJ5fPxHUFrScReQq/Lz6AGvvjylusWJ8zMoubVcPiIs+4PqWKe00ZAIqgHfyp5r+ZOPyJ6bMVXv29r/sVLAVj8H0DgQciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOkZKl8FLrxcDgiwBhG5npLG0VN2yeJe+wNzshWNTd8=;
 b=ORkM7Agx2tZFlaEhKVTpnImIF80RhsuSerIgFRa3lm8N2zuCP+WfH2RXcDxlfKysDG+Let5ot5mWglI59D1FdTXVQL+Bpz5qEj7RVH9EWGnkugmrEptrIUcvxG5SDl5ejUX8MSCEdkHn7Ca1x51nJfpHQESiMzXrgnMpOf60CyrnvkWUrQqf/23t3GvIhq/IfNrEJGu3Y9tvARcu7TAQloFurNKcXTiKwetL/JiWmqRqrF7fF4ofcAptDQiTf35VfO9sJFFgv8BQGpPDb9ebjuN1SrRTLE5SwyG+HeiDN8lY20Ycull+JxhKlqdFjPNO08vi+1gLxBeG1Nx+uij/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOkZKl8FLrxcDgiwBhG5npLG0VN2yeJe+wNzshWNTd8=;
 b=KxXTt8aL+Xoy847Eb696pK9cMuSXU01hZ4WHGWtghTtxWgxRJAAKSZUWCYHW/5RnevWt1i6ce0Ogs7IjwS4UKUgji0zruNuED7vW777xakI/kW8FpETngwp67aVlCE+pzY5sgtz3jCYboBV2ek3sd4E70OU8waswptZqMX8XLB66gofCN69YJW6rKLtPezzpS69Eeq3N8ZF7AofriR6K4b5yKol2lYX5hrjRGrNGPRX3rFlRtA7a0AU/7iJ/IzQ3FLxtEKaRNx2cj00BbvzfzvcV0Y+SFRE7+I8iBEwbsklUrz1/+uGK63YRgA20mWDlKEBKy67FWwY/QNYZTqJrAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 17:03:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 17:03:03 +0000
Date: Fri, 28 Aug 2026 14:03:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Konstantin Sinyuk <ksinyuk@kernel.org>,
 dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Francois Dugast <francois.dugast@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Ilia Levi <ilia.levi@intel.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jhs@mojatatu.com
Subject: Re: [RFC PATCH 0/12] drm/fabric: vendor-neutral topology
 infrastructure for scale-up accelerator interconnects
Message-ID: <20260828170301.GA4157646@nvidia.com>
References: <cover.1787552412.git.ksinyuk@kernel.org>
 <apAsfOowcG0cTvT8@FV6GYCPJ69> <apG3Gsk1TeMD-oCc@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apG3Gsk1TeMD-oCc@intel.com>
X-ClientProxiedBy: BN9P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::30) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: f2bea89e-975e-4f9a-c1d5-08df052638d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|10067099003|4143699003|56012099006|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: falNyYxFLYValaE2+gRzb4v85L+JMaE4HVph73kNapQad03eJjKWvCzumXNPtqU5A1xe2U66rOoAh+y14ADBxBQsks+5RB0Q8ratwcQe3eHNEKY148EK1scceSiqy0k7xmt2qptZmbwLVBqsbV/SW7Xx3a91VNrJ13IsY+C3oLKjy01TYYSDAnu779Yi/C9pdGD2n2zKOSku/mzZBjOujIJULqPuO8sjBmxumL4b2ApHJmUdMHrb0dqSHVVn6XtNugURdADSRFj8hLn4YALr/IauezKjToZp+Ty62pi8lkHvKEpvWkyuStSeXGeUgXMRgRxqHVLox9ZZnXYdAywNZ4Wv97c3rC1IX/QPCcwynjmAE9OtvfhBknyjiVv4dxrBTY14lJKe4hcWiAHYcBNTfJt6xK8kLWfc2pv7wJy364I8nIa9MZ1/nuKdO/nRhnPBe0a2uQBm1u6P9F90z8Gs77X6f0M6eWpopfgPUeqHtdbDbG6X7+VB6mtk4d1q/CVZJI8lhkqNLLXck9hjVM2rZZaT/Bd6140WHRvgXMSE2T4kL3D8/X0uzdkDktHQKxrjqNMF/9YSPfmv4Slp0Twy3EDR6fKlmHr02ivcFx4c9mIsqOH945AhrQQq8Fl0L8jvFGiTfBFHKB7gN343b8Bcb/eJuClGeSiqGUPcPSb/2T8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6tY3ypkzi4eTB8tC01egKXs4HX/8qhDx1HzK/qzlAqy8g1CiGYD1f6heGedy?=
 =?us-ascii?Q?8b7qRmwMz0T195byO+fd/mhXVkmOVpY+3ipJFB2sZQ7oZYqQpjdnzFbA8yMp?=
 =?us-ascii?Q?3LD4oyuWv0m0GnQu8rlPftOcUYi9dLSwfG2qdITrhZWnTqBI+aG1yyxCsluD?=
 =?us-ascii?Q?WtdLT1PL9/KqqMjO9d5nBKJYmrVFi4monIR6bA2cgYvQv/hUpWuSS2DJKpYT?=
 =?us-ascii?Q?VgZ8ns3q03N53F06neo3boSi28J2kdF9dh3ssN0YRj+gBQYl+quwbgx3hllk?=
 =?us-ascii?Q?0HspdlcGztuJE304mvoUwYV889GJ/raxjZV9iARg4ufuhwzvDZjXi//mtHtq?=
 =?us-ascii?Q?UodzL/nxohPSxMMtSUOyyoXJNv4Td98GG5hFZ0gXY4FjUeL/PEyNPyk+alRP?=
 =?us-ascii?Q?Lap73QhTg3oLGMluagEx/0XllbWurOsrcCiAt7DmaItkiJp4a/JodjMF9kIw?=
 =?us-ascii?Q?0/PqWmHr9IMlw/FpRoQ4zGBhHrLL59sziY1CCnI0oEuvrPQhOy5myz0Yc0UR?=
 =?us-ascii?Q?TNtnt3vZ71nOMLzSzbEQHVi6lt3MmeKn4UO/KE1Gg6QPltjAURJNGO9ZDB8W?=
 =?us-ascii?Q?/lfsONczs7sE+SmojvWwvCxXjOIZcdoP6rGRteq6EX/9KeGUE1ESfKIKPZLu?=
 =?us-ascii?Q?0P1iM5EUyCmPYepqVS0aSyahh/ttghZvLM8YY6yqJV09Wl9ghF8yBcQqLcvW?=
 =?us-ascii?Q?L/K7JBIQu/j8sXI283BSUJjeDodibK3iHwQC50Vec8EUnObIxe8ekzqOIeX1?=
 =?us-ascii?Q?NS2llgHUEcEsFyc5wwl+PJf3igM89n2dlbrv9x1d6JOz9NlTP3XC+Ani6JkE?=
 =?us-ascii?Q?axTFiTDt9yCgwgb1kbz+VOAIYPLcRVJbi8vKrhhLI6yPcLIYrgbexALATTC8?=
 =?us-ascii?Q?0jBrX9GWRC8HKNsAcydliXdtDxKgakoqJGy9C/Nrxxc/px2OEaMOibZAIVGn?=
 =?us-ascii?Q?bDXKy2e8BDLN6s/UbaPctyrfAzCS4UAwQolaXLBGtCbHS3Ad6M9uAYUEnvwv?=
 =?us-ascii?Q?Q8cQTe9SafD1sQdE/7wnvjYAhnqpfRqk8FPkupV3a1REjZSSM5rhTAVJUfOL?=
 =?us-ascii?Q?MqVnsSZP2WjLU+IB78y1IBK4V+nY7Md+IR9d4agDyk6LNoaxPMpeUH2KGZ5X?=
 =?us-ascii?Q?P0IGv/M+F4HLjqbP2dVBCfKFP9b5wp6VFjk7kYD26ihTbY9n60zpTCiFZ2Ne?=
 =?us-ascii?Q?cDGnwjHsPPMPE+iS+W0BY5Bv//rvkmG0j4ypjoNEgQcK81Wbz7F5IBQJRfB8?=
 =?us-ascii?Q?SItSVEgnztRkoEEQ3NpTxcoadoBdNIFV7j8J9oEUaH4IoOP70Mxo4+RxzUwF?=
 =?us-ascii?Q?WOnxMQ7+AFteAN1P49daCwAVlHzy8flhtBUVfl42q8Z5N917K6ytMeQpGI7n?=
 =?us-ascii?Q?W6VFF5T0Oe0QrdgH2D/8tNtfuJKjvf+WkZNt0o75GbEwqeRFlGFF+mVdDzhc?=
 =?us-ascii?Q?nTwK7hFboCVuGtg/T+jvZhFUBa2/7lXbOYzjJcN6EcOaA73ofynh6EE0WVEQ?=
 =?us-ascii?Q?luyAO3tL99XEgoto6eMQoMGyewQFtJiSqHEEuUvY3V9eidiyT//8JW3UBblu?=
 =?us-ascii?Q?/hsvd1WlQ3CepYE4Z68QL8/UEkvyWdf0PshWXjNn2GsUTwtc7Y53suvuG/jt?=
 =?us-ascii?Q?vXH2mkVcjKuwWZsDvwg3OzRvXIYLPDcENaPi5fCDPS5TM3FMLYZHdGlp8eAf?=
 =?us-ascii?Q?CD6bK6yyIff2z97NN4B6wmvkiFI01Rfuh7Pyz3voexkWCvFg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2bea89e-975e-4f9a-c1d5-08df052638d1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 17:03:03.1768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/qEqiIGJtkG2csj8qgdK1ksg5yoIBbZxe7EOir45849mdWwYheT6yRaa8q6ZjkI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487
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

On Fri, Aug 28, 2026 at 12:28:10PM -0400, Rodrigo Vivi wrote:
> On Thu, Aug 27, 2026 at 02:35:16PM +0200, Jiri Pirko wrote:
> > Mon, Aug 24, 2026 at 10:09:28AM +0200, ksinyuk@kernel.org wrote:
> > 
> > [..]
> > 
> > >Example queries using the in-tree YNL tool are:
> > >
> > >    $ ./tools/net/ynl/pyynl/cli.py \
> > >          --spec Documentation/netlink/specs/drm_fabric.yaml \
> > >          --dump fabric-get
> > >    $ ./tools/net/ynl/pyynl/cli.py \
> > >          --spec Documentation/netlink/specs/drm_fabric.yaml \
> > >          --dump endpoint-get --json '{"fabric-id": <id>}'
> > >    $ ./tools/net/ynl/pyynl/cli.py \
> > >          --spec Documentation/netlink/specs/drm_fabric.yaml \
> > >          --do port-get --json '{"endpoint-id": <id>, "port-index": 0}'
> > 
> > Using generic netlink instead of sysfs for this makes a lot of sense,
> > but it may be a bit odd to use it outside the networking area.
> > I've been struggling with the same in another non-networking use-case
> > as well.
> 
> Please notice that this bubble was already broken. Netlink design
> always had the dream to replace ioctl everywhere. And there are already
> other usage in place that are not network related.

Yeah, and people have been living with the friction, and some places
don't have quite the same complexity, but that doesn't mean it cannot
be improved. :)

For something complex like this, if you can't concretetly tie the HW
to a net namespace, and follow the net namespace rules for visibility,
then it is going to be a painful choice. I speak from alot of rdma
experiance where net namespaces have been consistently challenging.

> In our case we use the netlink API for GPU RAS error reporting: drm-ras.
> 
> Also there are other usages in netlink spec that apparently has nothing
> to do with networking, like energy...
> 
> And in this particular case here, the drm-fabric is a 'network' of
> GPU memory... At some point we even wondered if net/ was the right
> place for this common API....

net/ is mainly focused on IP networking, it is where you should be
putting the ethernet layer at the bottom of the ua link over ethernet,
SUE, or whatever. It is hard to imagine having an actual physical
ethernet network and claiming no implementation will ever need to
process ethernet packets or deal with ethernet phy.

There are so many variations of these "scale up" fabrics now, it would
probably be appropriate to have one subsystem that aims to work with
all of them. It is almost rdma but different enough it probably
wouldn't fit well.

Certainly redoing all that ethernet related stuff in drm or, worse, in
amdgpu, is a pretty ugly idea.

Jason
