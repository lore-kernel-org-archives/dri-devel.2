Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A3E606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WQc+J5ho;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ll5G+/mY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8565410F685;
	Tue, 24 Nov 2026 15:27:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 868C210E1E8
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 15:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795534052; x=1827070052;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=HnDgJD25gPlPSyxZZGuUQfcWT3TCTVSEVbme+9NgTXo=;
 b=WQc+J5hojPmL3CFbC93ub96wr7YKO87PKMUZx8WMUPmNaaycCSqNSYK2
 tQH6oUE+Q3e3XLFmUEr0M7rCAhz4A5Qhldl47Hk3rLNs0a0KNds5s1Vz5
 l7mkW3X8FoAWLC8H813mbIzr1U3mAw7BeNiIKmUcUdV+o28DxfjKQ6L0H
 PT/Kw+L9w5Q4bxhRFxGX6ARYB/QiY1ylcgB8bcUU+yDPtvIT6pG0q5KtZ
 hCng2K9crkABJ33OHBKGRgATrRijhljycxd2t6mzbWJ3eGavmQhr3NN2K
 7gJ+nnOzUs5UPTB6tiz+uHIOV70iWpO0YS7MBvFyV92vBnUc4bZtHlzXB g==;
X-CSE-ConnectionGUID: Qd5LLNNRQnW7tkb7LbiknA==
X-CSE-MsgGUID: ouKeBcD2SAyhpqqGf1P5wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4263589"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4263589"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 07:27:18 -0800
X-CSE-ConnectionGUID: QWJ6kyKKTaubvXP2zAJ+Aw==
X-CSE-MsgGUID: mXJauCIMQMeVwqHI+MP+kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11590189"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 07:27:18 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 07:27:17 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 07:27:17 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.32) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 07:27:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4Fz8cu1Fc0pWhq9yttko/9WoQBhi/KCLPAJVVkByi/e0Phy53bLDwvw9VKRU+RtBTHUg9GBHTuHm3IJAr+OKvhv2TBLSBcNDTQb5mZwIXGl0AeYSCZeKMNm5TUsTmBS7VfWMdXhPmQHdITSaXBQW2/9BwFQ4Jnscd6sWAI5VNSPsFxHIMfkKQyZOm5qBewWNtMtU+rvka4qBxi7H1PeiBm8TmfA1Gm17nlsUNnoBP/tkc/BRvtlSRF4qNXCKHUcWTURpci0HHtsX1KJDeA03plDkBCscwPKkFumZvO1gZltAwyreclLra5i/7a7a3+HZuTYHGynIsqqznYjZRe0eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvM3DiNv4Zhg8jXaHt6pB6kFkqFQFkvsyHdR9ZgrhJw=;
 b=tpfd4M7VxSwFHJUyoTcl3puDA9IYf1zNs3/JbGuwnuy+wXIUuF3rW93ztRLqd8N9h8e06F06FI3fOzamlYyu039mV+5tUrTvwU/IVGBhI3K/gBwSJ0g5hqRxuUYSr+l5IrM7j4I0WzRml98truK0Bfjzr9cxjdCV6JEmla8NC0VB+LDzokJRFEHQ+nFiJzt4Y9orc7Ru7BMItqEzllIFnCleRIEQOZ0pRJbVsx6d6H0bGpAHcu0+4JWmJRa990p8LkG/xSci6MZIJPiZGSZ4rNKakKPrJPI/vhSIIYGZDEKm38cf/RC/dqEqAfzxeFNUgzuSYHqWezHjKmfAv45pjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvM3DiNv4Zhg8jXaHt6pB6kFkqFQFkvsyHdR9ZgrhJw=;
 b=ll5G+/mY2QP8N+v95wcd193y/fl8INWqEeEHeGxzu3jimIck9renyuyF4x3U4KkRt9gOo3NT6897o4de+q6ZMxF+xyWKKVljM3jrtIuhyIgk5IxNaLB8H4Vsb14PbHeh+vLs+1Rd7nErKSuude+7gaAXM5/8nZ+OoCk9ZuDzm6I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 DS0PR11MB7957.namprd11.prod.outlook.com (2603:10b6:8:f8::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.14; Tue, 24 Nov 2026 15:27:14 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 15:27:14 +0000
Date: Tue, 24 Nov 2026 10:27:11 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 3/4] drm/drm_ras: Extend DRM RAS interface to include
 telemetry nodes
Message-ID: <awWszy9Jyf5VjQie@intel.com>
References: <20261117233442.407877-1-zachary.mckevitt@oss.qualcomm.com>
 <20261117233442.407877-4-zachary.mckevitt@oss.qualcomm.com>
 <sashiko-outbox-222189@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-222189@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0131.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::16) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|DS0PR11MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a49722a-b3f6-4933-1882-08df4a3f6a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|261028144727099003|10067099003|4143699003|11063799006|56012099006|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261102123227099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yRRDNBrLt7DT4Mn0Inq80JrcIXntQK39pTm8i/inlggUImSJhcAt2s6HAlv7nFPBJHWD2ebTVwW51Fkb1f9Hy+IwJl3TqyBcdrQdUW1hrDQC9m5xlKSTnXjl8CQaXMbifZs5wE3TZcqZPKNaO+oMMCm5vL2LYS7Ad6LbUZIWlqnm1NFQW7IXm+SkoeYdMhZBdDKQtLSDPO/h5XgtzKv+2yQFlzFCXMpiWm1tL9OhWnAeT7Nkd/Nj2QJHE03EQez4nV8yUDEPfly6bR+9BMbWEF8p3uvFYU87ABodFZjM00qU2FMWaV+8Kq2nhA7Irc1Raz3EK02+ds+U2FyVOuwKXR0rAOjLXSF/BycGQWOZzTB4sAkV58fIXPoBDTfbGjJ4ahUqOf0SB1ZJtLLb/xt+I8SXhSyo5pHM1VnE3P8LLF9vlXFcdnqvpChO8h10XzDHeb6ARhIletqoDYA+yzoRzT+OadN42MNM1fwnKt+Oi4c9OpzY8+DMweRDXVCzGU6ZZoT558PeMjanqSjhlFuD9D5teacT2as7Qqu10CCGi9UdTuDAFc5JJ9WZP0zbA3JesvhZvpna7T4QlTcpQyHtJ2QXOdMqkD7n6U9DXyMMPDs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(261028144727099003)(10067099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261102123227099003)(261026121527099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8mqQ/Y/x4uDnEmIlSujy6Oozj/+Woawdq7GLnSdGWBNwfX+o58BykHhHZE?=
 =?iso-8859-1?Q?ip+rZ6qEuNw33FlxjGVBibbXeuh522+i1K/FJBldwZo+1eal5yFJOcdfzz?=
 =?iso-8859-1?Q?I2RCcj3dRPlCZDpBOJDGXe+BxkOLQ35rm2f9eJ7auUlB/21XMAk3+SMJAY?=
 =?iso-8859-1?Q?bXzoPdwdhEyauGz6+xDVAJ4hTyiFkvgd+m5GQ2ZUJw+Rsxl7xaV8VHdxJP?=
 =?iso-8859-1?Q?JXyfrCKiOO7iIvA8HEr4Ft+0F7Bu3kZ7v78mcSWJumbiz/KmHiXgJcpWhO?=
 =?iso-8859-1?Q?zIyr9YkOiwfiScTn4mJQo5/AbBDcBRSU5VODB1560HhuCe+iu2uQKuDlnz?=
 =?iso-8859-1?Q?vIwf7kDiss4ClAzJnGvXOyATaWfhocf6bSIqpoSTVB3bVR+sbEzMft5fSX?=
 =?iso-8859-1?Q?d+D7DGylBJo4TfWpVUfeYGX3mnuRbg1tv+KcJp/Qu4jXjKvW+GEAHy3Pvw?=
 =?iso-8859-1?Q?zBjQ8B1h0DPRzIiPOTWXr5kqphi50mePrwrDfa105IZC1SHpshPCIkb08T?=
 =?iso-8859-1?Q?sDpF7NhAuJo/5gQOOoAks6EN+ENl1rKJY/eFwmNYxOszqeb/cWiyVhgE7F?=
 =?iso-8859-1?Q?4RR7Ygs8goWh9wwsMMyqJrfHyznXZ8KTfP4/6jmQfhjiJKVhndXH1vfgp5?=
 =?iso-8859-1?Q?Ng6vHV+VcH+ck75rgo8cmiXQ0s345F/CdP7EWY6eSf7x/G6ujVLwUosjXw?=
 =?iso-8859-1?Q?1ArqPFlwwxUIRRPqhWMBEQMo8za3lSUxp3Yhm9GRymHzAF7v3156KLgJRv?=
 =?iso-8859-1?Q?SbSQo6pGM4Xb0J2v8nPTsyZ769lXeh6813R0XXQ8bFRKvJhjyTrsczalOC?=
 =?iso-8859-1?Q?I42ZYnY1DlsseJZpfW0Mt1COndKMhvdXIXzbLbkdum3/gN66+2g/RYnc+A?=
 =?iso-8859-1?Q?SLEbWf4yNjSB5mIF0FEV1R4RIIiUnmNzHVQfW7xQgl3lO8VvaaXXREdvQN?=
 =?iso-8859-1?Q?wMRutxhaKkJBW5qjD8r3WT3/5qmUcLQfOoH8g1w/Kks9PHmos3aAyJFXd8?=
 =?iso-8859-1?Q?AHKyVVf8VF2fsribNfa7IWoZBSnhIlY3wN4JfMtoRutToeVBAdHXXL83vl?=
 =?iso-8859-1?Q?OVl2dihxvEbUfGZq/z26tSOtK4jEbeQWQ2VjUBPDMs+jBy341cAe64Phik?=
 =?iso-8859-1?Q?SuQOptFildHw7z1FVKucN98bCqjHt1xaBa6QZmVQ8eK6faJcpN4HTQkiX3?=
 =?iso-8859-1?Q?gdCagkDbY41rpQN6A/aygRV4TBnoTBXnbLZy2OfpnrOKH0bBli5rRTKq5F?=
 =?iso-8859-1?Q?ufhVXycd48DxEPkPkjp0FWSxovAFSESMK8UKvzVoazXgaTt2prC3pjtp0F?=
 =?iso-8859-1?Q?xHO7d5+DBhGhz2LZCgDRFsjfp8Nuz2puBnal9erugGoWbP+UoxMiPcUeHX?=
 =?iso-8859-1?Q?rrpMIgrHuI9WaUQZffjIfZN0NbFCIKtRPgt4ZRDR5zV9KTiFCky5rQ04pl?=
 =?iso-8859-1?Q?dmECtF5x3nYTwfW7Um9gvXr6zV6oq4FddGYJb7aQ15gvIPIg4GkXu5NFVv?=
 =?iso-8859-1?Q?jwHbwx52YbmTo9o2QUGsn3O55RycpZkxPFjr2B1svH9/PF6IZH2pzdTeml?=
 =?iso-8859-1?Q?5T4CdfUVP/RqGYPDzV24b6ILTbaF59mE5TgaHtY74VAATknqtrzytedJe/?=
 =?iso-8859-1?Q?PQ7+/OYSYiFTpIrmIwfynmH9xtV/PZt12mVMlkwWBNj6/OqCxvXQXsU+Z0?=
 =?iso-8859-1?Q?xgx2LMcBGGtlNe71Ibsc5g+mR0ZPQ6uNbomRa3aneq2ntjy6C78liBDTuJ?=
 =?iso-8859-1?Q?TyuoJ48Xk4VECi9Q2MBqCX2tPa28yqt9KLOPsSPKfOnToIjZclFsMsR7qJ?=
 =?iso-8859-1?Q?Fm5NBFmeLQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: Mqbhmg1Eh5LfKbiFEqnorDwpKzZQKdA98/PRztrO3SFLcHQX8XfbkmTK+aXjF0YjauIRecb590RvIhhAgD8qcer4fiKc01sqb/7U6/wCPXbTsZqL/N5aoMl3PSdSDZbTLDkaBQ2FbLPE+M1Xb2Oi2LUxFdn711DB3HeXCz16VwdnqXFsMowdn7otGtIJg48lFZPS2TXbrwishxuG2pOJdO2arTMKv6ulPf/7l/5NTUU95tK/vB7MDceDR4e6s6PG2ZhaWtn30yK2kUrVj91o1rXqVV9jRBcZ1ZKe2Gvr7vhhjxy5MATIGqqRvroIypqTeYXIB3ZYYjfRrZejHbhOfg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a49722a-b3f6-4933-1882-08df4a3f6a84
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 15:27:14.6324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvt2tNapZ5fDCgiu3d8inWlommYp1Im5x/UN5KV+yQQvdVHIUNt3nC/lYl+Ss5VDrKJqwGw8NZGRaV/nl9pGxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7957
X-OriginatorOrg: intel.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 11:35:21PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] drm/drm_ras: telemetry-attrs mode flags attribute uses u8
>   instead of u32/uint
> --
> 
> commit fd2287347a17ff8e49c9be2dea7e5b0d3b353084
> Author: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> 
> drm/drm_ras: Extend DRM RAS interface to include telemetry nodes
> 
> This commit extends the DRM RAS netlink interface with a telemetry node
> type and adds operations to list telemetry fields and read or write field
> values.
> 
> > diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> > index a88fdab7a1c74..28a89aef1e016 100644
> > --- a/Documentation/netlink/specs/drm_ras.yaml
> > +++ b/Documentation/netlink/specs/drm_ras.yaml
> 
> [ ... ]
> 
> > @@ -100,6 +105,41 @@ attribute-sets:
> >          name: error-value
> >          type: u32
> >          doc: Current value of the error counter.
> > +  -
> > +    name: telemetry-attrs
> > +    attributes:
> 
> [ ... ]
> 
> > +      -
> > +        name: mode
> > +        type: u8
> > +        enum: telemetry-field-mode
> > +        doc: >-
> > +             Bitmask of access modes (read/write) supported by the
> > +             telemetry field.
> 
> [Severity: Low]
> Should the mode attribute in telemetry-attrs (and struct
> drm_ras_telemetry_field.mode) use u32 or uint instead of u8?
> 
> Netlink attributes are padded to 4-byte alignment, so u8 saves no space on
> the wire over a 32-bit attribute while permanently limiting the
> telemetry-field-mode bitmask in the userspace interface to 8 flags.

Hmm... this comes from the review-prompts that Jacob asked us to respect.
Possible to change this to u32?

Meanwhile I want to take your patch 1, resend and merge on drm-misc-next.
okay?

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261117233442.407877-1-zachary.mckevitt@oss.qualcomm.com?part=3
