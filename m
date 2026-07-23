Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22BDC531F7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 19:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 060C310E5EA;
	Thu, 23 Jul 2026 19:43:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bzoJsNYz";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B907F10E5EA
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 19:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784835784; x=1816371784;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=k2VDKeviWQ2+1SjByYUuoemQ/q3UktI6/NxUSKGBXgQ=;
 b=bzoJsNYzazrtZNAnfr79dxLh5OhCMiRCbIVSHDMbMhmik92UmdMkAlxT
 rINoK1UFz+IuGJXYjGxWwVzPhvoKrJLMz/Mm5KA3Huky6IAtWdxOya8YT
 6UPIOwgdMKSmUd7vUwNqyyN2Uo5rQxEVU7nWprGKnCeL7b7LzZx2PS3VX
 2S9TlkoGUCefsrbmcKMBZZUHGYJxtLJqQ15tPo+8GvJN2PgB41yGfmfEz
 cJe7SILtf7TCf+GMUYHlBshjQVgU4lDsIPgvsnlI4Fr08500zCZH7UjUd
 ArQspX7VyKodp0qMchNsMMVaCVJqUO5IgxoHDn+6WE+6p5jF5CHwxlMqf g==;
X-CSE-ConnectionGUID: sqTdxsyhTdWW8sD7MEDUfQ==
X-CSE-MsgGUID: HJo6JSHPTRaXFNwNm77uxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96163350"
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; d="scan'208";a="96163350"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 12:43:03 -0700
X-CSE-ConnectionGUID: S7jR2QzCTYqSmJMkRabGNw==
X-CSE-MsgGUID: bshAFxBETWGESCkGYaa+YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; d="scan'208";a="254161594"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 12:43:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 12:43:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 12:43:02 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 12:43:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQT9PsDJTvkO4wh8s7rfa2cO4/mrtAZhTbxPoJ4Ki6UYZo1zWDYtOstdatFxKWIq2fbgNqckuNhTDJKkEVhtBrTLl8FccG3tPGLYz7W0c29B1JqEaQZWm/eV9w6YmzYBqEQ1Vg0QfI1hPqjrfBfVZNst9lak6A0PmhANl1huieHVIQ60CjiTcJy2m7ReIsDjDfPHPdqsfcJkiLUmuCWV7zhVWerQ6tBQtJCY3CMtbibMlUoY6uzMwkD6GjHAS60I9ae6JXxHanKld3YiuV1MUcUCfn3JnsDz/zRnRCXV7PSwsXj+tZ/ocyPLT4oYN7jDsPk/ier9KruymRTcxhD6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Nhokg/0lgyZy5ndHOgDrMAE3GVBBbjVBXUP5TIMW/w=;
 b=umcmTlVDjDjj5fONV2ipMrdTLWS2lmZf/dzxELzSKoECB0XQpa8c2O1C/c3quTXjq2O1VbHYDZW5XjCCaEa0sqEzYvPOQv3kvpN7nABGD5HV8zUyom/6Q92+vO+/5r+ki1HaC7iqGemateS+d9piRl4P87Jb4fXrI1euUr6cZ2iQE6mF+FfdKSzfvFEaVW0RgMHrFAEoCuQfEgLFFDWyZRxNzyKJO7VNstR2A837ASdBo0Yls2Fl+YPK3Z7IKsBwTRHDOThyPbWKHjFe8fvU+iVqqq8ngRqjLcvpb1chFiKI5TkOqJFWiqbQHg1MbjZ1uSUp3MmpHoyImVLbvaHZRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS4PPF409BB8CE8.namprd11.prod.outlook.com (2603:10b6:f:fc02::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 19:42:58 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 19:42:58 +0000
Date: Thu, 23 Jul 2026 12:42:55 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>
CC: <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: Re: Concurrent Kconfig renaming, impacting your commit "drm/pagemap:
 Guard HPAGE_PMD_ORDER use with CONFIG_ARCH_ENABLE_THP_MIGRATION"
Message-ID: <amJuv+Icq1fs2wym@gsse-cloud1.jf.intel.com>
References: <CAOc5a3NBcpJnjB=Tv3+tjFoD5aJe4dUTH7qmTFom2z7-eDQiqw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAOc5a3NBcpJnjB=Tv3+tjFoD5aJe4dUTH7qmTFom2z7-eDQiqw@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0148.namprd04.prod.outlook.com
 (2603:10b6:303:84::33) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS4PPF409BB8CE8:EE_
X-MS-Office365-Filtering-Correlation-Id: 05916dca-4a3a-42fa-70f3-08dee8f2990d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hr9SJ6OUtFbWgH9Z1hCOc94+7iaeArd+Tao3TX9ZUzasBRiweGbfx6Q9aUDbySp9mMOMdWZqGoYMIsBh02dW+VOoEieV0l+EPPAhZhm2V7c6pOYz0s217Fby4qGdYbMsL6P0pIpIuEopx+WGdpCDtFBk8egMFfn147pagt1oY1iM70lxCGWn3sfwA2kApWmpsQAZKsXIKhkmcfUzeSVKlPxfuaKMNZ+gke/1Ge53GKgmMYv/kzKuaIKAizTIRQw9tOSRtfvbbIsida1aPRVHFLQYQyai7/tC4EzR3PQPqJjrn3ooCgC0aPV5xCRXJ6rrrUKI1k5B8Xb+5pCO8nTqxozwhV0NUsWrc6w3Q+OwAzQwghdgaY+XQsyvEKH/wWH5pQnha5Onlz1yp5Of/Y721LqeAOetm/2Xyv7sCwD9CoS3PDZa4x/uUtW3YblYYJ1Jf37oTv/+hSr0dVyCdg/AS8cTeLsegEhtzf3Els0PsspfNTBGKjyyRGxdMHjdAsfelYkkMoJDozC7dOEwXMlAWFDXF3Tp+DcOY9qXf9JKuEiXh5PUCsuxDk0A+AL7mhGHKrufOw8WGz4qOEIcBP1ahT5NlVl/IZ0jmhI34WaQf/63B4/w4OKSnWrfeIdOOXhNwZEMwsa4w9OW3PlUY7bMuJJucpuJOwKwCBlR0siySQo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FFl0xa6hUKYUhj4RhaukZS/tScBHIot+qGAWFNUiFqm+Qp8rOtKM/QU3To9w?=
 =?us-ascii?Q?ZwqVIkbvmWZTZMDlK4QB1BlqQmIdLixdiWpaBym3papfZ7CCYaT48PZN+zhC?=
 =?us-ascii?Q?viMyd8SMpkW3CmFK9UbBfT07N9X3pCXapwwtBoEeZjSpYelDP5yPExYOgKch?=
 =?us-ascii?Q?xpj3E4FQQoc46N8CQbmP5RIdlvtVRwx2SAn5+9bNLJDz5/yMMXPMBwOGJdXO?=
 =?us-ascii?Q?vN1jkkwGGJ74S24KEiWh/t0wf74ipYxCYje5mAbsY1+RlKfCuJMDxwtXxovQ?=
 =?us-ascii?Q?W/aEj9VRfYnDItZ2GaqbBXU098YvhPuBEgfiBOnGYu1ozvxGRo1u83RpcqS+?=
 =?us-ascii?Q?ZubeFk6aPIvaLCYbALLd9lOABWj0EEtpU6CZ/QKh6gEQ4KOm+vODLRAdBsIn?=
 =?us-ascii?Q?+3wcBGuU3FDc+Pv1KKVTrq6TUVyEWK68B67f0LJtvz2aeajxhzwSPWTtCYnv?=
 =?us-ascii?Q?J2Fsx4QppXQiSORBcWYBlwA2f/3E7x7GVqEwRm51//h1jZ9vVr4McIvRFzfO?=
 =?us-ascii?Q?N+vvsPIDIG351xp5o0TtyO1E+8vn28BWfBUa5HEO17Gn5byAbEAAZ6l7GruR?=
 =?us-ascii?Q?pbkSXEKQ2t6vTnO1QNXkM8UFDDf6vf9F0gSuEzpSbrSVemi048FSwshU3BhP?=
 =?us-ascii?Q?YDcC0EVznBP7D4hVI8AiLBY4NtFFtNEhS6w4BK0cSY4MaOqjhYidKMD0oeF7?=
 =?us-ascii?Q?epFEArDF90ejKQRvhYknjF3bpe7t6w/b+sZa5RWuOAwPloY888fNahuxH53S?=
 =?us-ascii?Q?mpp3xp9h4nEH4EhY5KN7IvmeMuahV9A23QtvoyCSf59HMgxG3im1KfCzKRtS?=
 =?us-ascii?Q?0AIfmJ6Oke+fc/4mwk0VgZz6YwOBdBKE3sksrlfyAAje61m/DfE3oI4xrRUK?=
 =?us-ascii?Q?evSbHytFOgNHO1BD6d3OhTpFB3V/PjSWZs4e94PUYvkittALzo7Xq0WS5TPP?=
 =?us-ascii?Q?2n05v9/p9XnyyjbK8HtVuMmyZMEtEfvTuukTp1X+ZGoIr496in55liiJmIsk?=
 =?us-ascii?Q?srb7TH6a9zi3qFMAtTCKybdmW9M7raesHEvtN8tfuIEx3my30aoPPkvCnDR9?=
 =?us-ascii?Q?XvvWy6CHEgaug66J39VoC1e+Oln0OBh6HeKj5yZnwWDg4PhrLkgBk+t/WaEj?=
 =?us-ascii?Q?qSf2xWuXT0GqRYUIuvh04oa2Vkx5xZMM/NxVHR+8dG8pOjII66vyzNdAL+Wl?=
 =?us-ascii?Q?43MAHoiAmi+2s54vOp5JFEOjvmaKkwVZ3IUC+DC5/G47Mfmjm4ZhSobXzk9/?=
 =?us-ascii?Q?Yi8TZuL8THb5yVcILYsQlytfshmO4Bsh5TejDi3wxHsENGb7ctRVRxl2vw0x?=
 =?us-ascii?Q?8xlB0fp1YGz7vbvxIp47PP6+9DrqYu8xVsF2cJ+FzM51spcqyziS+ytI3t3u?=
 =?us-ascii?Q?6INXXUaHIlzH2dIzNHIYPJcharNtjdpIOivPGYzXjgYfUvEGXBZeMb6HN14l?=
 =?us-ascii?Q?2jJuvZyLkqA90zcY0WT1RKPEKWTlO7QDb9FozkVb4cwRxF3yR9KEMoWeHY2y?=
 =?us-ascii?Q?ryOriYhD7RTMQcetNT1KDuz4Kg5r8xkkpd8Kmj9clltFtU/LYVhbm0P4dPv1?=
 =?us-ascii?Q?CoI0DJGpYPSFiuoDzHaBHBQZDMJB0S0edxmAfsb6+srkx5CxPhKMNLSTJKzA?=
 =?us-ascii?Q?42wJMS3VfLB9WRBiXBThVKosXqWpERnS4+DSPkpWiNdrc9fzbOmBf9HSGuH/?=
 =?us-ascii?Q?upUb4X51g7CTs9m6EqaJh5LPmul5DQyZ+fu2l9GImc/PY9OY5T0GQoUtsxDd?=
 =?us-ascii?Q?UalAUVth9w=3D=3D?=
X-Exchange-RoutingPolicyChecked: XchiUjEm00YdrJstZfqi0HtOqRPz6PtrhxzsvZxc40JOjTalYGtm4uxF3LKFzkE5Umkf6H+Gf1xSesza/saE+ath6KsLbh1jDyMG2i4D+fIs3cARe1Z38owvPwAc5VZFycSJXolW0APAfWIkGY2Xf/+fwWUR5EBxbh39Fs9UU+jX5nh4akcoy9ctS9Qn+pQM8TvksPXq2T6r8+fZnp/lej25N0DtqyvjIovmlJQvT7nDL/WDqIG4hIcH6o+ecT4KT/dE5zPvLEP5oXMMa+rXmJIbQNqO/PezWPvfv/yzY1rwr/HeAHTrnrSuSUV1rLQp+xnio/CigPxRrMBYAWJTKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 05916dca-4a3a-42fa-70f3-08dee8f2990d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 19:42:58.2187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FbDfJ+17dcX6BCsFADsdDmMMTCVD7+UvokjVX6vBBkJ1T6RgUXAyax7KsUb+srxh7gkSvIaKgK+u2j15or4DsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF409BB8CE8
X-OriginatorOrg: intel.com
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

On Thu, Jul 23, 2026 at 09:12:26AM +0200, Lukas Bulwahn wrote:
> Hi Matthew,
> 
> I noticed that the commit 0b6b1bb28482 ("mm: rename
> ARCH_ENABLE_THP_MIGRATION to ARCH_HAS_PMD_SOFTLEAVES") on linux-next
> renames the config option ARCH_ENABLE_THP_MIGRATION, which is referred
> to in this recent commit 04b177544a040 ("drm/pagemap: Guard
> HPAGE_PMD_ORDER use with CONFIG_ARCH_ENABLE_THP_MIGRATION").
> 
> You might want to have a look at that.
> 

Thanks, I saw some discussion on a linux-next merge conflict about this.

I think I can just do this in DRM to avoid the conflict + work with and
without 0b6b1bb28482.

-#if IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION)
+#if IS_ENABLED(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
#define DRM_PAGEMAP_PMD_ORDER        HPAGE_PMD_ORDER
#else
#define DRM_PAGEMAP_PMD_ORDER        (-1)

Need to  look at linux-next or core MM branches to confirm before I
post anything though to confirm.

Matt

> Best regards,
> 
> Lukas
> 
