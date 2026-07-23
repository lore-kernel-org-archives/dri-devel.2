Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63594C531F8
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 16:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD26C10E5E5;
	Thu, 23 Jul 2026 16:34:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UQiTfsyx";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9F4C10E547;
 Thu, 23 Jul 2026 16:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784824492; x=1816360492;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=qXa3PQa3USHGGaCls/ZbejWGp9UOj2Jg0+BK6RqPbeI=;
 b=UQiTfsyxnOwwxAi5SNtVJ5US8PHKdv8JR2XMWHn1bgCzVtSkuEUHzmL4
 5ZwM+90d1LQjeHSQ9BdOp1ssitm3I5eJVnboElx5fqxKKcBKzZVIJOMiy
 9J6mAyIqogRZWRQIIctwbe8Bw6SxHSRKlZWwfLl4zikIAQWqsqduz5JeJ
 whp7cfTzOkHuzbPtxmXVwvABRjaoeKHMbQi0dhDB8+hhwAdOPukNb03Z8
 GWKj1QeIptOnWngMBq7XjiflU9Vx9SIB5Q0lB5MlMe6L2tJaZkYMwaV1E
 8l0eK+8q2D3UIFyPMGCKsJ2M1MaVzwwwlUrH3r5nsMfN/m10PfOqca5xp w==;
X-CSE-ConnectionGUID: 5THncS8JRpijzyAyV0u2vg==
X-CSE-MsgGUID: tB5baKjKTuCZt/AUuCXdGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="95840478"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="95840478"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 09:34:51 -0700
X-CSE-ConnectionGUID: Yfxjz0WVSg+B6b0MC8S0Kg==
X-CSE-MsgGUID: +inydvrFS56EgU6cbFZyXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="252147654"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 09:34:50 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 09:34:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 09:34:50 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.32)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 09:34:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2i4aKjaGTSw6GwYWaJulN7eAOM4aKzbBF6bazCD2B2ppkUmCHzVjzSZzvElaJKEOtLj+HrKpGe3StRQpsSuEKvihN/gqhUUOKudR0y3qJf+k3t74A2BySSftp7+D8/BoVn/rlseJ0IKkc8COTxrFOmOmQEcsdhvD5NmUBMbDXmJpcRBQlMTEpgbx0eH3YTmNyJLSpU3ZN9LdHbLvgr3cqWOsRS0nv2U2/20Pw/yIurwuK7+mYv1WGKXiVdxGPYP5SbNt37i2v+yCGT0TJjS6z5WWBj1ZIzDtlSDMfkU1QPPYg/MM8PIBK72eD33Ystw1Wq2YWmXePJaStAG5PAZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vagwIaNfpscC9JCpYM7GUZ9Ua3MaxChiVlmGcye2Onk=;
 b=At+MMwUzC7yzNDu4PcZ72yNhSIY8r6U2aBMyyJAIYbNyUAQTtCJk1irB2ojSi+eK4ToBnj7Cfw5BqUuGPZlotfaBNopM4aOZ1rbhO7APwcotGB9LUbi4Wlku3yKzYEWdSP35VVBD929XuJGvgSamK6HI4dcuXnozhhRD9jMdtJeGQw0Xzw0oZLkm81Io+brh8TzBmQ0GL1aeUX0mwPElQWpAnRQiZyvWoLt3tBszVa4cC6a289jqwWVMDcJpKClNraowaJAN8S9BML4MNSJQjIB66ADSZTxtvkVyf6muzbVGNq29yfO6+DMSttoTHsECWF4nrJ7vX869/ILQ8SZ8tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by BL4PR11MB8799.namprd11.prod.outlook.com (2603:10b6:208:5aa::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 16:34:46 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 16:34:46 +0000
Date: Thu, 23 Jul 2026 12:34:39 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
CC: <aravind.iddamsetty@linux.intel.com>, <anshuman.gupta@intel.com>,
 <joonas.lahtinen@linux.intel.com>, <simona.vetter@ffwll.ch>,
 <airlied@gmail.com>, <pratik.bari@intel.com>,
 <joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
 <shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
 <raag.jadav@intel.com>, <maarten.lankhorst@linux.intel.com>,
 <mallesh.koujalagi@intel.com>, <soham.purkait@intel.com>, Zack McKevitt
 <zachary.mckevitt@oss.qualcomm.com>, Lijo Lazar <lijo.lazar@amd.com>,
 "Hawking Zhang" <Hawking.Zhang@amd.com>, "David S. Miller"
 <davem@davemloft.net>, "Paolo Abeni" <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <intel-xe@lists.freedesktop.org>, <kuba@kernel.org>
Subject: Re: [PATCH v6 1/2] drm/drm_ras: Add drm_ras netlink error event
Message-ID: <amJCnyvuxcMtXxYL@intel.com>
References: <20260722094134.3036087-4-riana.tauro@intel.com>
 <20260722094134.3036087-5-riana.tauro@intel.com>
 <a5eb582c-f063-4730-8015-da59079a258e@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a5eb582c-f063-4730-8015-da59079a258e@intel.com>
X-ClientProxiedBy: SJ0PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::27) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|BL4PR11MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: 027ab79e-131a-41ed-5d04-08dee8d84e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|3023799007|56012099006|11063799006|10067099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: cG9gdj48aV57kOc1s5mBYvuv9Gdi2+8zAWmUkfdRMJnRS1LUMJ9srz3a0fYVE60Zh0t6mas3eWKQikz2JItVSVt8PEY/iHQuraYIzpPNi3GxreTvHfDr9kRw3MgksBJ3l6+WfOlcwm+4al1qJtbOVzlV9fbhEwc/DiRtdEwyi1i63X/Z0LVb4K+Vz2SuPJtOCGhPzSNBIV2GzlgLY+fAMUpaaNnq/LqQ7sYz4phkRJApKExmb5jP0ZJzUGHT8ho/eW1v4TGEKmLqEcse3Gr/LJDQu07zCX7o2OjQWqN857TvAmg4AdzHKW8+mTgIeBn3SUot8npAY/KcgepcsHo+/AoKd4aqAJAgseLa73Z+yDQOKsxeYDhCqafJp+EygMXpUuv/DjCGsM+a4SoYIwSDD83JjjDABai7+ujQUjh9Nd1Afudh/Ymk3oyw2D7CDMkmejHE8XFk9H28EbH+034NpwURDg6LfR1c7nbqJV6CmcXNocIon6WRpNd0dQ0wObfrMzHQ3CfboxQrKI4EnFNCRozeEDhDsB+Ci5YuDQT0WC+eTpAncUsn26HI3WTji9NmTZdix5xtoshsmOG08Y2FNMP6iWa9OqQfgU0si/O60OoIMjPuxaGBv47d+qiECS1KvVVhPjLzqvFnzEAh4hrEFp+jEhluQJ0KrEKSgdNWvRY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(10067099003)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PeUPjr00GwHC5DcemVqVjXE1t7ymMiHabUHju0YaVJIkYLOQR4lJl3uMepaK?=
 =?us-ascii?Q?8CO0tGirQuxL4309N4w69Y/i55ydN63GE7UAOrrMrw5erzaZ/VZjbX30jWw7?=
 =?us-ascii?Q?qZOWdQ71WQZ69OMZYGONZMuEMTZUSdyVPNfwja3CRsr+SlmhjuWOUnRJmpiK?=
 =?us-ascii?Q?mCtTgCIqHp+qoy6+8PBnBL0FXtrcTaBa8As3s79sd20wwcQg3OY6B5LSWsxk?=
 =?us-ascii?Q?82n1N4KJYaWfm4MTcHqIDawf3qDbKG5v/jaU3p+51EBguGubeiVbUaZqROJk?=
 =?us-ascii?Q?ZvAiJ2/u8BI0V516YsACynfXnqaHBF9l3kLN8t02ARqIV7iqqRid+gSHZng9?=
 =?us-ascii?Q?w2mLiA8HkrLal4/x3Qhb5mSg21byKqbQP8k+MJmBln45EiVD4ny4E+aYEhlR?=
 =?us-ascii?Q?rdLevNPapej38Mz6G9u8vhDfr+cOg+tuHDb2VV0apz1o35QUf1AsYwDNWCIh?=
 =?us-ascii?Q?aNh1ggunHICGOPXigdccBSadtuBaZuAr7uZBu9eYWErujPLaNLkS/QoNW/nI?=
 =?us-ascii?Q?Qvyz5E6eoHI7L0LRH6dtseWt4i+ZYjxB35O0IpPA5EKvZ5QP1fG5p2myNeQk?=
 =?us-ascii?Q?CgkvchMZZ/xQk+gs8MDq+xM4TGctUw7ev4DpkRXrbtfPGEtP9AqV14aQK2uX?=
 =?us-ascii?Q?XuyT41o0j1sc8bW6STwMA8SD90bKgVo1vsQnlHqYv43SZQ7eI1oO9oQU5e0D?=
 =?us-ascii?Q?t9m8IywZcGSFKavSKeusX796NWlzZ02vr1HrqS0u8itXawX22Q9ckUXXlK0Z?=
 =?us-ascii?Q?W/LYn+wkgSgsxpw4WP2zx8gYl/5XofLg1ATkJew7bD1MdiinbxPhWqBiVjO2?=
 =?us-ascii?Q?p3rV0zaAkIYjTULU6xRTT27zoazKrd32n11j45xHyHKeevDbCQlGfRd0vXNs?=
 =?us-ascii?Q?5sgoQeMcSqn2Mzk1vCbpua3yK7Eez0eUiq+HK+Mi3dIA6A97pDX4e/XsoJWy?=
 =?us-ascii?Q?m/cLiDW809rixzDM3AdryIKdhUj5zhSTLXIR3XrkRgrwy3MHVUOALptYj2Vj?=
 =?us-ascii?Q?skTAvlm2AiorFCsYvxxvIb2iLoxE0YWnhhgFiPYLqDzrrPFAL4w+cDzmm147?=
 =?us-ascii?Q?HTuoIzDKpxG2Lg+lbGE7hkGghfB/lCeHMcTse7wT5jKeplHzE26N5rW6gQlB?=
 =?us-ascii?Q?P2x8NhdkK8qfEKwURL501fXL8tTkLeG23ZyGpWUmJp5m27qz812+DweCZgDZ?=
 =?us-ascii?Q?RSdp6qvAEVv9kzi17CydaYBAkhL9bEfMAYbJvyNMFaYgbcpqBBFV4AD+tasI?=
 =?us-ascii?Q?9dcFFGXDOJEDSo9+KNc2ifNp9+gQV5GVpnjtTTHr5lzmCYOw30BTkTKrv1bO?=
 =?us-ascii?Q?sj30XEHFt8TQNVijlOh+Pk6aj5do/epUN4Ogy4nJZKGN6S9K6lyQ+sahHeE8?=
 =?us-ascii?Q?KEfdf766qOexkNN8zabphZ7e77zRx1+eJKFS69IwZnMuvQqoVeb4RdmyP4Ee?=
 =?us-ascii?Q?tWgDZi5mrIzwfs28Obej0fOoL+cm0VMatAzIs9kMdOlc3+jHEsYvH6tLKmFj?=
 =?us-ascii?Q?7xItLV/zDVmHU+L4b+CpHUQSlukYFv2CZHROn7hY9MeGhB4QO9w0sIc9K6ZT?=
 =?us-ascii?Q?BbVb3J5PEG2FJ/JeAkgHsa/spkHxxKgrkv/wfvhEBPb7rbFqKB70CGJ1/S1b?=
 =?us-ascii?Q?vePqBr4cjerwzSE6Mw4URcUldmBNp684sjqnHFvsZ4ix+UKuNf9yotWTqKNy?=
 =?us-ascii?Q?KCXyRUGQpcqOOSkJBlQpOwMmMh3wCN4cVAvt7l0L98yUN9ttR9tD8vQ6fDnu?=
 =?us-ascii?Q?a/I5p4QCdg=3D=3D?=
X-Exchange-RoutingPolicyChecked: XtG+1Cmf/PX+boz2UdcodkIYJtVPRv8cGYxT9eqvadq3Owc6Jvy67PXXyF9cc5poIj10LauAToWWWR5nPlKjScOi4l74P7txujJw4YEIUmd1A5HjLEas3vh0DsP0E4xS099tSTN2V7YAsFTtNWPx0ZIBVupQVmyVY2TP1JTnDR7ysJQ8xzVJicmQJfUS0TIJrOX+1CylLswjbPRP08sdt8hI0BRKwWE543QqWSP8pvho79IYh9lQ/wjcUzXGM8fcIIJ5EPyWYd0Mnc0gAhcqU3qanw2JSblq93VbjwGFFYf/JdjbLeFSpxVz9PURnh/hMuOWOvUPPhP9x71StbTw2A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 027ab79e-131a-41ed-5d04-08dee8d84e87
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 16:34:46.4853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4SCS3ihg2JwwNCSNpfDvaMNQG4vu2ikEhkBssKhiGBFDMTFf0LsypbQQVVJ0jMn66sXOjo5azsIFVZnlYluyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8799
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

On Thu, Jul 23, 2026 at 08:06:22PM +0530, Tauro, Riana wrote:
> 
> @Rodrigo The sashiko comments are resolved and has been tested with multiple
> namespaces using docker.
> Sashiko review is now clear with a pre-existing issue that is being fixed in
> another patch
> [PATCH v5 1/5] drm/ras: Cancel and free message on get counter failure -
> Raag Jadav
> 
> <https://lore.kernel.org/intel-xe/20260722034228.662746-2-raag.jadav@intel.com/>Let
> me know if this looks good

Yeap, this is okay. On this one I just had the feeling that Raag had changed
his mind and asked further changes after the put the rv-b.

Perhaps we should resend a clean history and then we use that to ask
for the appropriate acks

> 
> Thanks
> Riana
> 
> On 22-07-2026 15:11, Riana Tauro wrote:
> > Define a new netlink event 'error-event' and a new multicast group
> > 'error-report' in drm_ras. Each event contains device name, node and
> > error information to identify the error triggering the event.
> > 
> > Add drm_ras_nl_error_event() to trigger an event from the driver.
> > Userspace must subscribe to 'error-report' to receive 'error-event'
> > notifications.
> > 
> > Usage:
> > 
> > $ sudo ynl --family drm_ras --subscribe error-report
> > 
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> > Cc: Lijo Lazar <lijo.lazar@amd.com>
> > Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Riana Tauro <riana.tauro@intel.com>
> > Reviewed-by: Raag Jadav <raag.jadav@intel.com>
> > ---
> > v2: remove redundant initialization
> >      remove unnecessary space
> >      use ynl in commit message and doc (Raag)
> >      simplify doc for error-event attrs
> > 
> > v3: rename error-notify to error-report
> >      Replace notify with report across the file (Raag)
> > 
> > v4: send event to all network namespaces (Sashiko)
> >      remove has_listeners check
> > 
> > v5: add context in function for choosing GFP_KERNEL (Sashiko)
> >      add additional checks for node registration, range checks (Raag)
> > ---
> >   Documentation/gpu/drm-ras.rst            |  21 +++++
> >   Documentation/netlink/specs/drm_ras.yaml |  48 +++++++++++
> >   drivers/gpu/drm/drm_ras.c                | 101 +++++++++++++++++++++++
> >   drivers/gpu/drm/drm_ras_nl.c             |   6 ++
> >   drivers/gpu/drm/drm_ras_nl.h             |   4 +
> >   include/drm/drm_ras.h                    |   5 ++
> >   include/uapi/drm/drm_ras.h               |  15 ++++
> >   7 files changed, 200 insertions(+)
> > 
> > diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
> > index 83c21853b74b..406e4c49bac1 100644
> > --- a/Documentation/gpu/drm-ras.rst
> > +++ b/Documentation/gpu/drm-ras.rst
> > @@ -56,6 +56,7 @@ User space tools can:
> >     ``node-id`` and ``error-id`` as parameters.
> >   * Clear specific error counters with the ``clear-error-counter`` command, using both
> >     ``node-id`` and ``error-id`` as parameters.
> > +* Subscribe to the ``error-report`` multicast group to receive ``error-event``.
> >   YAML-based Interface
> >   --------------------
> > @@ -111,3 +112,23 @@ Example: Clear an error counter for a given node
> >       sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
> >       None
> > +
> > +Example: Subscribe to ``error-report`` multicast group
> > +
> > +.. code-block:: bash
> > +
> > +    sudo ynl --family drm_ras --output-json --subscribe error-report
> > +
> > +.. code-block:: json
> > +
> > +    {
> > +        "name": "error-event",
> > +        "msg": {
> > +            "device-name": "0000:03:00.0",
> > +            "node-id": 1,
> > +            "node-name": "uncorrectable-errors",
> > +            "error-id": 1,
> > +            "error-name": "error_name1",
> > +            "error-value": 1
> > +        }
> > +    }
> > diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> > index e113056f8c01..8aed3d4515e5 100644
> > --- a/Documentation/netlink/specs/drm_ras.yaml
> > +++ b/Documentation/netlink/specs/drm_ras.yaml
> > @@ -69,6 +69,33 @@ attribute-sets:
> >           name: error-value
> >           type: u32
> >           doc: Current value of the requested error counter.
> > +  -
> > +    name: error-event-attrs
> > +    attributes:
> > +      -
> > +        name: device-name
> > +        type: string
> > +        doc: Device (PCI BDF, UUID) that reported the error.
> > +      -
> > +        name: node-id
> > +        type: u32
> > +        doc: ID of the node that reported the error.
> > +      -
> > +        name: node-name
> > +        type: string
> > +        doc: Name of the node that reported the error.
> > +      -
> > +        name: error-id
> > +        type: u32
> > +        doc: ID of the error counter.
> > +      -
> > +        name: error-name
> > +        type: string
> > +        doc: Name of the error.
> > +      -
> > +        name: error-value
> > +        type: u32
> > +        doc: Current value of the error counter.
> >   operations:
> >     list:
> > @@ -124,3 +151,24 @@ operations:
> >         do:
> >           request:
> >             attributes: *id-attrs
> > +    -
> > +      name: error-event
> > +      doc: >-
> > +           Report an error event to userspace.
> > +           The event includes the device, node and error information
> > +           of the error that triggered the event.
> > +      attribute-set: error-event-attrs
> > +      mcgrp: error-report
> > +      event:
> > +        attributes:
> > +          - device-name
> > +          - node-id
> > +          - node-name
> > +          - error-id
> > +          - error-name
> > +          - error-value
> > +
> > +mcast-groups:
> > +  list:
> > +    -
> > +      name: error-report
> > diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> > index d6eab29a1394..39155fb514de 100644
> > --- a/drivers/gpu/drm/drm_ras.c
> > +++ b/drivers/gpu/drm/drm_ras.c
> > @@ -41,6 +41,11 @@
> >    *    Userspace must provide Node ID, Error ID.
> >    *    Clears specific error counter of a node if supported.
> >    *
> > + * 4. ERROR_REPORT: Subscribe to this multicast group to receive error events
> > + *
> > + * 5. ERROR_EVENT: Report an error event to userspace. The event contains device, node
> > + *    and error information that triggered the event.
> > + *
> >    * Node registration:
> >    *
> >    * - drm_ras_node_register(): Registers a new node and assigns
> > @@ -186,6 +191,34 @@ static int msg_reply_value(struct sk_buff *msg, u32 error_id,
> >   			   value);
> >   }
> > +static int msg_put_error_event_attrs(struct sk_buff *msg, struct drm_ras_node *node,
> > +				     u32 error_id, const char *error_name, u32 value)
> > +{
> > +	int ret;
> > +
> > +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_DEVICE_NAME, node->device_name);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_ID, node->id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_NAME, node->node_name);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_ID, error_id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_NAME, error_name);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_VALUE, value);
> > +}
> > +
> >   static int doit_reply_value(struct genl_info *info, u32 node_id,
> >   			    u32 error_id)
> >   {
> > @@ -222,6 +255,74 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
> >   	return genlmsg_reply(msg, info);
> >   }
> > +/**
> > + * drm_ras_nl_error_event() - Report an error event
> > + * @node: Node structure
> > + * @error_id: ID of the error
> > + * @error_name: Name of the error
> > + * @value: Value of the error counter
> > + *
> > + * Report an error-event to userspace using the error-report multicast group.
> > + *
> > + * Context: Process context only. Uses %GFP_KERNEL and multicasts to all
> > + *          netns, which is unbounded work; callers in interrupt handlers
> > + *          or other atomic context must defer event.
> > + *
> > + * Return: 0 on success, or negative errno on failure.
> > + */
> > +int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
> > +			   u32 value)
> > +{
> > +	struct genl_info info;
> > +	struct sk_buff *msg;
> > +	struct nlattr *hdr;
> > +	int ret;
> > +
> > +	if (!node || !error_name)
> > +		return -EINVAL;
> > +
> > +	/* Check the node is currently registered */
> > +	if (xa_load(&drm_ras_xa, node->id) != node)
> > +		return -ENOENT;
> > +
> > +	/* Currently only Error Counter events are supported */
> > +	if (node->type != DRM_RAS_NODE_TYPE_ERROR_COUNTER)
> > +		return -EOPNOTSUPP;
> > +
> > +	/* Check the error ID is within the valid range */
> > +	if (error_id < node->error_counter_range.first ||
> > +	    error_id > node->error_counter_range.last)
> > +		return -EINVAL;
> > +
> > +	genl_info_init_ntf(&info, &drm_ras_nl_family, DRM_RAS_CMD_ERROR_EVENT);
> > +
> > +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> > +	if (!msg)
> > +		return -ENOMEM;
> > +
> > +	hdr = genlmsg_iput(msg, &info);
> > +	if (!hdr) {
> > +		ret = -EMSGSIZE;
> > +		goto free_msg;
> > +	}
> > +
> > +	ret = msg_put_error_event_attrs(msg, node, error_id, error_name, value);
> > +	if (ret)
> > +		goto cancel_msg;
> > +
> > +	genlmsg_end(msg, hdr);
> > +	genlmsg_multicast_allns(&drm_ras_nl_family, msg, 0, DRM_RAS_NLGRP_ERROR_REPORT);
> > +
> > +	return 0;
> > +
> > +cancel_msg:
> > +	genlmsg_cancel(msg, hdr);
> > +free_msg:
> > +	nlmsg_free(msg);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(drm_ras_nl_error_event);
> > +
> >   /**
> >    * drm_ras_nl_get_error_counter_dumpit() - Dump all Error Counters
> >    * @skb: Netlink message buffer
> > diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> > index dea1c1b2494e..9d3123cc9f9c 100644
> > --- a/drivers/gpu/drm/drm_ras_nl.c
> > +++ b/drivers/gpu/drm/drm_ras_nl.c
> > @@ -58,6 +58,10 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
> >   	},
> >   };
> > +static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
> > +	[DRM_RAS_NLGRP_ERROR_REPORT] = { "error-report", },
> > +};
> > +
> >   struct genl_family drm_ras_nl_family __ro_after_init = {
> >   	.name		= DRM_RAS_FAMILY_NAME,
> >   	.version	= DRM_RAS_FAMILY_VERSION,
> > @@ -66,4 +70,6 @@ struct genl_family drm_ras_nl_family __ro_after_init = {
> >   	.module		= THIS_MODULE,
> >   	.split_ops	= drm_ras_nl_ops,
> >   	.n_split_ops	= ARRAY_SIZE(drm_ras_nl_ops),
> > +	.mcgrps		= drm_ras_nl_mcgrps,
> > +	.n_mcgrps	= ARRAY_SIZE(drm_ras_nl_mcgrps),
> >   };
> > diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> > index a398643572a5..03ec275aca92 100644
> > --- a/drivers/gpu/drm/drm_ras_nl.h
> > +++ b/drivers/gpu/drm/drm_ras_nl.h
> > @@ -21,6 +21,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
> >   int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
> >   					struct genl_info *info);
> > +enum {
> > +	DRM_RAS_NLGRP_ERROR_REPORT,
> > +};
> > +
> >   extern struct genl_family drm_ras_nl_family;
> >   #endif /* _LINUX_DRM_RAS_GEN_H */
> > diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> > index 0beede3ddc4e..ee2caa0edc6f 100644
> > --- a/include/drm/drm_ras.h
> > +++ b/include/drm/drm_ras.h
> > @@ -80,9 +80,14 @@ struct drm_device;
> >   #if IS_ENABLED(CONFIG_DRM_RAS)
> >   int drm_ras_node_register(struct drm_ras_node *node);
> >   void drm_ras_node_unregister(struct drm_ras_node *node);
> > +int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
> > +			   u32 value);
> >   #else
> >   static inline int drm_ras_node_register(struct drm_ras_node *node) { return 0; }
> >   static inline void drm_ras_node_unregister(struct drm_ras_node *node) { }
> > +static inline int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id,
> > +					 const char *error_name, u32 value)
> > +{ return 0; }
> >   #endif
> >   #endif
> > diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> > index 218a3ee86805..eab8231aa87c 100644
> > --- a/include/uapi/drm/drm_ras.h
> > +++ b/include/uapi/drm/drm_ras.h
> > @@ -38,13 +38,28 @@ enum {
> >   	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX = (__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX - 1)
> >   };
> > +enum {
> > +	DRM_RAS_A_ERROR_EVENT_ATTRS_DEVICE_NAME = 1,
> > +	DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_ID,
> > +	DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_NAME,
> > +	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_ID,
> > +	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_NAME,
> > +	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_VALUE,
> > +
> > +	__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX,
> > +	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
> > +};
> > +
> >   enum {
> >   	DRM_RAS_CMD_LIST_NODES = 1,
> >   	DRM_RAS_CMD_GET_ERROR_COUNTER,
> >   	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
> > +	DRM_RAS_CMD_ERROR_EVENT,
> >   	__DRM_RAS_CMD_MAX,
> >   	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
> >   };
> > +#define DRM_RAS_MCGRP_ERROR_REPORT	"error-report"
> > +
> >   #endif /* _UAPI_LINUX_DRM_RAS_H */
