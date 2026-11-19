Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67933606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iyfuWtKw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=b0gbpb8c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F03810E8C1;
	Thu, 19 Nov 2026 20:15:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A22710E833;
 Thu, 19 Nov 2026 20:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795119331; x=1826655331;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=QPNwmMmAN74ierSbcLP2Sve0tZqYPQ0fZ3MMLKMjpMc=;
 b=iyfuWtKw802EgyUYLgnc/OFDGLaAc0w6y2tBNgwpKt/PcXLWg9urvtF2
 6XXbNFHWJMVWt5AlJJcLmrtuLoGO/0xjRPrD+Ihnskk27eoms3bb5ph1T
 goGb1k+v4YB60++qUE/otKVrkVoI4B99VXeNA5YFDlhui7XuMjpK+w6C9
 EDIQk94QaO6GGZXnQOny26hhyqLAM2ZZHllN4sBiyHj2OFBUJEOfgIXA4
 KUrHJm/GClVlCGR039R75/krC/HWoni+gknpqBgByzzoQKmPfCeE0T2XF
 YLAMQwyARBQuaBesNrFa2Q50ELDB7SVEeVObkBWh0z2DEEcTV5xrm730H g==;
X-CSE-ConnectionGUID: bQ6rguN+RI6+diHA5QppdQ==
X-CSE-MsgGUID: puACLundTymn7ZbM69rzaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4014629"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="4014629"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 12:15:30 -0800
X-CSE-ConnectionGUID: 7ipHazU9Qdem080OFJFLKw==
X-CSE-MsgGUID: n9jG+hZVQeqyymOXAwnrKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10605584"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 12:15:30 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 12:15:29 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 12:15:29 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 12:15:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjUoO//04OEIMlGmgJyKyL17BSHpe9DlgY6uk4/4MrWMhMo9kpXDRBnu6Yh+xAZP1pzKqmly5y+sEN5a8MOqIK3sA/CBCyWGPHNqpRBVMggO7wfnANV3tYqvCJUpkMO+KJsZn8FxtwvjlQV/PsRpNObmydgoqp7JkLaOswSL4adllhkSkOpqCnStbi9pdmIAKpvqo0/tkAw2rcfGvzCzs6b4BEr0xLAQ0NQUSkOZltpZK8r5UeF+6X5/9LFhwK+UHTuk6VkYOl9WK1Hkhd4/EJafX7nBbNb0cxyHuuAoEwo7vcGC/ofdob2Tm9f4bQDC8Agls9Wwo7LnHU0hWBKgrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnYHHrJvamo4OpxfX/OnmmQ40niFYM3ocAn96tco2Rw=;
 b=PRnURTH3I8ORhRaZ8QeuXCFdvTladIftHS2ZVNgeJcy/3mrbV10/a922ZOtpxoiTQFbUcwYp4SvS143DZMNtzS4HFXt7eTvkTu2uq3EBUf4Dwp/rUO9QU5IjHAwgiS1F+MPLOE89kVuTu0wtac8JO4qU0Hpx7nsGlG9uuHTWAVRkj8lHDawwfLasJIUfXBFoEgR5gkuWU1qsAMwjrPRcQ2g/vZ0NceqWmgAEgPkzVjtuvx7FOGIxa4WtHuEd83C3lqoVTC1s/YDFUKjbN+UrEtEltnIz10VHrvxdZobu/bXBaywCaP/NHuqkizuC5VKGR063svSYdgcHDHidJbOwKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnYHHrJvamo4OpxfX/OnmmQ40niFYM3ocAn96tco2Rw=;
 b=b0gbpb8cdN+6hcwL2jxC/i71dZYbUs+ITo73qskeB6POAko1VZ5rjpf7lNX+fwZVgbxpuWoFBKgKq//kmhQZ9WVga/PWUxdJKfE9u3DOaZEEywmZyeZkWcO138B4ku4Ty97pCntEU4kw2qwE1tJ/R9hbF1o7ufDxY3QBH/jWi3c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by CYYPR11MB8331.namprd11.prod.outlook.com (2603:10b6:930:bd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 20:15:14 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 20:15:14 +0000
Date: Thu, 19 Nov 2026 12:15:11 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 05/33] drm/ttm: Support defragmentation moves
Message-ID: <av9Yz12dG7+vtgb2@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-6-matthew.brost@intel.com>
 <au1Ax4zGApeRJF47@nvishwa1-desk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <au1Ax4zGApeRJF47@nvishwa1-desk>
X-ClientProxiedBy: MW4PR04CA0214.namprd04.prod.outlook.com
 (2603:10b6:303:87::9) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|CYYPR11MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: d8af458e-4445-438f-f8a3-08df4679d211
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|6133799003|18002099003|22082099003|4143699003|5023799004|11063799006|10067099003|261022075727099003|261022113327099003|261026135527099003|261026140227099003|261022105027099003|261026121527099003|261026130827099003|261028144727099003|261021133027099003|56012099006|261021121427099003|261021135927099003|261021130227099003|261021123027099003|261009221727099003|261009223027099003|261009223327099003|261102123227099003|261009220027099003|261009221227099003|261022115727099003;
X-Microsoft-Antispam-Message-Info: vyUICQBitUv11e6KvoqO+3L8EUUFPoRszKsQBkHMyvbBtyOq02q7VvwoUXRUz+ABpmFKJWTuEzfCBt0FeDwbUtmR70MDVJTDJ2Gw4q6xY3ceuDudBC0vDlHnAGfxGFTWZzxCUvm7QIFIkUY4b9RDTDEeOuCclpLbiyT6jK4PLjP6VSM9ZDNS7uNUZ8QMWZKa1mH7cSZPp/EMHIOrzwVQA+y4WFR7gh8vW50gpXy/aj51F5BSjHevhQSluClMm9hFALhN/CjoyE09coBQUPgc2it0SrsZMt+v+Rz3oR/GK0Ua+npK8m/RvOf44Xww5xImlSvbObBxMs9QBXUehGODEvers5X46RE9IGrT/60GWzr5ZWrGmQXAVavFHXWlgslGR6TL+nOQyTHf+sC8nntyC7osgEnQEFStHrmBm/azNx49NathDZzIalpGfSBAJz88zbJ9/B960bXosguxmZp+M5QdMvKkC/vGzJn96BYONdymiOpCGGhCtXGKlTzldgo/WFRbgYZqjzDvhLOmYrD/7AjEzyCM9b6W2v2SpPQ+92iBJzbmsy/LO1F11M1GvLyUzpDi0emoQcE3zsms8nSl2LAzp2+GhoFPtHPZvU8YcHMX2jvQRns0lAC7QwGRh5nosgGYax8lBfWcpdipI/XRCm/zHL+886PV+6snjJhSTV0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(6133799003)(18002099003)(22082099003)(4143699003)(5023799004)(11063799006)(10067099003)(261022075727099003)(261022113327099003)(261026135527099003)(261026140227099003)(261022105027099003)(261026121527099003)(261026130827099003)(261028144727099003)(261021133027099003)(56012099006)(261021121427099003)(261021135927099003)(261021130227099003)(261021123027099003)(261009221727099003)(261009223027099003)(261009223327099003)(261102123227099003)(261009220027099003)(261009221227099003)(261022115727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0GERN+Zs5LWPZXT8OWRcs+BKBc0TEyb2Dc24xTklnU77x16PuqEpTVvjXj?=
 =?iso-8859-1?Q?DKNT0y+mYwkWyFnQ7Kl8UjWtetjJieS+huxLV8b7xs3gMz9BEE/OJ6Ux6q?=
 =?iso-8859-1?Q?sp3U/A9kneVuGEzyFP/d3cg63zUwgAzGGa25yvL7vGgxiaG+T6WBtdAoH1?=
 =?iso-8859-1?Q?q10xiPIV5n6W6r2rb1VaEJzMHRs7EAOe4wINbBi5x+t1UKnjoKtvU3rCl2?=
 =?iso-8859-1?Q?NxH5EYLIH8TrOOIr3Rdv0MvO8GQePULkgOUtlKPahKtOCCgr566gIXyA9U?=
 =?iso-8859-1?Q?2dCb4dM2hlJ3ysL1gQ9mgcDUfjMZgv8EHmjaDmtguKbWr/uMDBKZTodZVt?=
 =?iso-8859-1?Q?OGF+gerIz4uwiLfb/WlBg+e/jvvAw3jgp2b/fDnnhLQCU/MhIuGJfWr1nJ?=
 =?iso-8859-1?Q?2Zu0YU2YifHj0FM05lt3ECZxvMW+Mla3RslQoliPOJf3zXq4zISxeVkDBo?=
 =?iso-8859-1?Q?D68Y8EyXYDty0WOPuXiT3eXQynC1prw9for9/5RDtg9vU0XC8ivSm5rJSt?=
 =?iso-8859-1?Q?83H4uw/hQ/A1lGGXabNi029uQR2SlZzsu5vAOObIFZpg2eNMUnyZ2olyut?=
 =?iso-8859-1?Q?4KoBN3El12Q3aZY04oLxOG6X36WgC37XHhFZxhnrFswItXkICKtHKjg3O3?=
 =?iso-8859-1?Q?DuhRP+ErQFwbqJUHRyj8Q2ekVXalH4KIAJrj9+J6YBddGslYe1waxSHnW2?=
 =?iso-8859-1?Q?KvHjF6MfH+B0C8QIYJ0skkGAXW5OAqZYukqfDYSbtFpx/Ki9/MUfrlr/bE?=
 =?iso-8859-1?Q?MFFmfXqBfE/ygKzXwJw/3ctEHHqC0ya0ETR6/ABnBonvAxMm+76uI6Snkj?=
 =?iso-8859-1?Q?Q+E9sx1WRs5MuT8A3fkUudZn2CLO72a9/RqTg62q3OvEGY8CtK89kt+24P?=
 =?iso-8859-1?Q?HG/xh1gW6pPg2r56CZACZEb0/tKAL2fm/9v2+OgvhaYsTWRaCF/B4t8k0E?=
 =?iso-8859-1?Q?6Xup5qJFhEmtsNFP2AQJkH0njoOS3HggMPjM/UiUVgidxqb4vQX05CzOtI?=
 =?iso-8859-1?Q?Hbz14CcV04ogCQUQUNzJCAs/LL0LWHn8W0du/OfjYadFR5/Sx8Ko9tcpGc?=
 =?iso-8859-1?Q?WAkk+HvqCyWQ1vz7NHqdWEGg+4IiaJ5DISTiiox4048j+49Rz3LxXT250r?=
 =?iso-8859-1?Q?FWISOBTCtmKXCCJ1wBYUsXHxqOMYJl/D3f6oyrJaIijbo/cS5Clz223mXt?=
 =?iso-8859-1?Q?fDknTngWCSDKDAFkxfv2CutYtaJNJPTqErxQ2OlXvsopsaiZa1TTuKXtBs?=
 =?iso-8859-1?Q?qUg126uId/c3n0dkATMgoHO7S9kCKQ1c9F4+oDmqd4gDJoOonweJdSzsnJ?=
 =?iso-8859-1?Q?HylD0srlS8SoRN3SuoYJeYgPtovb1lTWuHvkkl7LEh0WIYJfmhPS7mfzLC?=
 =?iso-8859-1?Q?eB1vFCaVP82wedHaa5ZNm0vgay79GPmU7sf1emA42YvyMvxxyRsb8QMJY6?=
 =?iso-8859-1?Q?s6PBCyW20NguoVlLYoA4EkfDegOUBZ8KGhOwXhPgjHIbP9DhG1hqbc5ren?=
 =?iso-8859-1?Q?DXBHd7+BdJV53x0zM0T4HBleqC41y8njVChV2ZEjbzH/rxtWYz7koOcXIR?=
 =?iso-8859-1?Q?KkGFzihEqH18bdNAPGKPoS1CXQ3/pma/AIQESyZk45r+UrkiK4reWPxoon?=
 =?iso-8859-1?Q?bFq5kf6fDc5tWG31kW+naFwl9wGtEgHin9QjN17B/KSH1dJdf53DE1LxFF?=
 =?iso-8859-1?Q?ig7kF8EPi2RLdN1rrao3PgK6jrVN8gD+AEETpv7dWIm7neMDFDWXpm4mvn?=
 =?iso-8859-1?Q?ttideSU88aoIgSY257b9zmZzI4CJbLqX4dVJJmOztodbYRFrIqqmWc3b99?=
 =?iso-8859-1?Q?JEONbKIUVtcNwZyWNpu3md0/7nwWZrM=3D?=
X-Exchange-RoutingPolicyChecked: wdYAagwT/nuCoyrrXLpH3FTLux3Zxsj9Up1iOuWka8U/ay4Rz3IXzQMxOfvjD2oT/yUZPOdkdYNyLT81CS/IBt9i6cuaZQLKWErxzfefdOdP5NYDI6+D9upt8tPxCdMdWOTcIgbEzej8h7tGCbAiwZQYdxYNETKVmmVF8Zpklgb4DXkAqJPniRdr9iLBlXBlRQN+PCLgAAfWMgZZpbjKdAQ0loA4P2RqLeuCs8yyMmCqvaMmkm+bQNnOqwuIpvFPNoBNw7CtpS3GGO7NzqPSIRYB3aJ7E9raUqk5QYuDLkxsOazLulb8JeGS0vjo1G57ABGrjxyOx5qcWB2CNjznoQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d8af458e-4445-438f-f8a3-08df4679d211
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:15:14.3080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpiQoASz8dL9yGfUGRZY228nByrdZ5QhOWqSUXFcZsG68CJpia1JYYOQPJ7QVt+rvKJK5qCxw+TW8jZoz6vCoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8331
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 06:51:51PM -0800, Niranjana Vishwanathapura wrote:
> On Fri, Jul 10, 2026 at 07:55:51PM -0700, Matthew Brost wrote:
> > Add infrastructure to let a driver re-back an already-resident BO with
> > fresh pages (e.g. at a more beneficial order) by reusing the normal move
> > machinery.
> > 
> > Add ctx->defrag, which makes ttm_bo_validate() skip the "current
> > resource already compatible" short-circuit so a move is forced even when
> > placement is unchanged. In ttm_bo_handle_move_mem(), when defragging a
> > populated BO, stash the old tt, create and populate a fresh one
> > (allocating new backing), and hand the old tt to the driver move
> > callback via bo->defrag_old_tt for copying. On success the old tt is
> > unpopulated and freed; if populate or the move fails, the freshly
> > allocated backing is discharged and the BO is restored to its original
> > tt and placement.
> > 
> > The old tt is handed off through bo->defrag_old_tt (reservation-lock
> > protected) rather than the operation context. The pointer describes BO
> > state for the duration of the move, so keeping it on the buffer object
> > is better layering and lets ttm_bo_move_accel_cleanup() pick it up.
> > 
> > Because a defrag move commonly fails (beneficial-order pages are often
> > unavailable) and then leaves the BO untouched on its original backing,
> > defer ttm_bo_unmap_virtual() for the defrag case until the new backing
> > has been populated and the move is about to commit. Ordinary moves still
> > unmap up front. This avoids needlessly zapping and refaulting every
> > userspace mapping on the common failure path where nothing moved.
> > 
> > Teach ttm_bo_move_accel_cleanup()'s ghost path about defrag: instead of
> > tearing the move's source tt down synchronously, hand bo->defrag_old_tt
> > to the ghost object so it is kept populated until the copy fence signals
> > and then unbound and destroyed asynchronously, while the BO keeps its
> > new tt. This lets a driver pipeline defrag teardown behind the GPU copy
> > rather than blocking on it.
> > 
> > This is driver-opt-in and a no-op unless ctx->defrag is set.
> > 
> > Cc: Carlos Santa <carlos.santa@intel.com>
> > Cc: Ryan Neph <ryanneph@google.com>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Assisted-by: GitHub_Copilot:claude-opus-4.8
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > 
> > ---
> > 
> > v3:
> > - Reject defrag moves needing a multihop bounce: WARN, restore backing,
> >   -EINVAL (Sashiko)
> > ---
> > drivers/gpu/drm/ttm/ttm_bo.c      | 100 +++++++++++++++++++++++++++---
> > drivers/gpu/drm/ttm/ttm_bo_util.c |  16 ++++-
> > drivers/gpu/drm/ttm/ttm_pool.c    |   5 +-
> > include/drm/ttm/ttm_bo.h          |  17 +++++
> > 4 files changed, 127 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> > index 3980f376e3ba..c1629b4c4f0f 100644
> > --- a/drivers/gpu/drm/ttm/ttm_bo.c
> > +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> > @@ -125,49 +125,133 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
> > {
> > 	struct ttm_device *bdev = bo->bdev;
> > 	bool old_use_tt, new_use_tt;
> > +	bool defrag;
> > 	int ret;
> > 
> > 	old_use_tt = !bo->resource || ttm_manager_type(bdev, bo->resource->mem_type)->use_tt;
> > 	new_use_tt = ttm_manager_type(bdev, mem->mem_type)->use_tt;
> > 
> > -	ttm_bo_unmap_virtual(bo);
> > +	/*
> > +	 * Only the BO that is the actual defrag target (moved in place via
> > +	 * ttm_bo_validate(), evict == false) is being defragmented. The same
> > +	 * ctx->defrag is threaded into evictions triggered while allocating
> > +	 * that target's new backing (ttm_bo_evict_alloc()), so guard against
> > +	 * an unrelated victim BO (evict == true) being misclassified as a
> > +	 * defrag move and needlessly reallocating its backing.
> > +	 */
> > +	defrag = ctx->defrag && !evict && new_use_tt && bo->ttm &&
> > +		 ttm_tt_is_populated(bo->ttm);
> > +
> 
> The sashiko reports a bug about '!evict' check which seems legitimate.
> 

See below - we don't allow multi-hop if ctx->defrag == true - i.e., we
pop a warning if driver tries to do this. Thus the Sashiko feedback
isn't right. 

> > +	/*
> > +	 * Tear down userspace mappings up front for ordinary moves. A defrag
> > +	 * move is likely to leave the BO in place (beneficial-order allocation
> > +	 * commonly fails), so defer the unmap until the new backing has been
> > +	 * populated and the move is about to commit. This avoids a needless
> > +	 * zap and refault of every userspace mapping on the common failure,
> > +	 * where the BO keeps its original, still-mapped backing.
> > +	 */
> > +	if (!defrag)
> > +		ttm_bo_unmap_virtual(bo);
> > 
> > 	/*
> > 	 * Create and bind a ttm if required.
> > 	 */
> > 
> > 	if (new_use_tt) {
> > +		struct ttm_tt *defrag_old_tt = NULL;
> > +
> > +		/*
> > +		 * For a defrag move, stash the current populated tt and force a
> > +		 * fresh one to be created and populated (at beneficial order).
> > +		 * The old tt is handed to the driver move callback to copy the
> > +		 * contents from, and freed once the move completes.
> > +		 */
> > +		if (defrag) {
> > +			defrag_old_tt = bo->ttm;
> > +			bo->ttm = NULL;
> > +		}
> > +
> > 		/* Zero init the new TTM structure if the old location should
> > 		 * have used one as well.
> > 		 */
> > -		ret = ttm_tt_create(bo, old_use_tt);
> > -		if (ret)
> > +		ret = ttm_tt_create(bo, old_use_tt && !defrag_old_tt);
> > +		if (ret) {
> > +			if (defrag_old_tt)
> > +				bo->ttm = defrag_old_tt;
> > 			goto out_err;
> > +		}
> > 
> > -		if (mem->mem_type != TTM_PL_SYSTEM) {
> > +		if (defrag_old_tt || mem->mem_type != TTM_PL_SYSTEM) {
> > 			ret = ttm_bo_populate(bo, ctx);
> > -			if (ret)
> > +			if (ret) {
> > +				/*
> > +				 * Discharge the freshly allocated backing and
> > +				 * leave the BO on its original tt/placement.
> > +				 */
> > +				if (defrag_old_tt) {
> > +					ttm_tt_destroy(bo->bdev, bo->ttm);
> > +					bo->ttm = defrag_old_tt;
> > +				}
> > 				goto out_err;
> > +			}
> > 		}
> > +
> > +		bo->defrag_old_tt = defrag_old_tt;
> > 	}
> > 
> > 	ret = dma_resv_reserve_fences(bo->base.resv, 1);
> > 	if (ret)
> > 		goto out_err;
> > 
> > +	/*
> > +	 * A defrag move deferred its virtual unmap until the new backing was
> > +	 * successfully populated; tear the userspace mappings down now, before
> > +	 * the move swaps in the new pages, so the next fault re-establishes
> > +	 * them against the new backing.
> > +	 */
> > +	if (defrag)
> > +		ttm_bo_unmap_virtual(bo);
> > +
> 
> NIT...would it be good to always do virtual unmap here defrag or not?
> 

We could unconditionally move the ttm_bo_unmap_virtual here. I didn't do
that to not mess non-defrag behavior but it looks harmless to
unconditionally shuffle around.

> > 	ret = bdev->funcs->move(bo, evict, ctx, mem, hop);
> 
> Sashiko reports a bug here when ttm_bo_move_memcpy() is used as move()
> function. Though xe doesn't use that function, it is perhaps good to
> guard against.
> 

What is suggestion to guard against this?

> > 	if (ret) {
> > -		if (ret == -EMULTIHOP)
> > +		if (ret == -EMULTIHOP) {
> > +			/*
> > +			 * A defrag move targets the BO's current placement and
> > +			 * must complete in a single hop. A driver requesting a
> > +			 * bounce here is unsupported: restore the original
> > +			 * backing and fail the defrag rather than retrying the
> > +			 * multihop with ctx->defrag still set, which would
> > +			 * misclassify the bounce as another defrag move and
> > +			 * overwrite/leak bo->defrag_old_tt.
> > +			 */
> > +			if (unlikely(defrag)) {

Here is what makes -EMULTIHOP (Sashiko evict issue) impossible.

> > +				WARN_ON_ONCE(1);
> > +				ret = -EINVAL;
> > +				goto out_err;
> > +			}
> > 			return ret;
> > +		}
> > 		goto out_err;
> > 	}
> > 
> > +	if (bo->defrag_old_tt) {
> > +		ttm_tt_unpopulate(bo->bdev, bo->defrag_old_tt);
> > +		ttm_tt_destroy(bo->bdev, bo->defrag_old_tt);
> > +		bo->defrag_old_tt = NULL;
> > +	}
> > +
> > 	ctx->bytes_moved += bo->base.size;
> > 	return 0;
> > 
> > out_err:
> > -	if (!old_use_tt)
> > +	if (bo->defrag_old_tt) {
> > +		/* Failed defrag move: restore the original backing. */
> > +		ttm_bo_tt_destroy(bo);
> > +		bo->ttm = bo->defrag_old_tt;
> > +		bo->defrag_old_tt = NULL;
> > +	} else if (!old_use_tt) {
> 
> Another sashiko reported bug about tearing down the old pages while an
> async copy is still in progress. Looks like xe driver waits for move to
> complete before returning, so should be fine. But probably worth adding
> a documentation for defrag_old_tt that "a defrag-aware move callback must
> not return an error while a copy into the new backing is still in flight
> 

I think it is implied in the ->move() contract if one fails after
triggering an async move, you must wait on async move before returning
or TTM will explode. This appears to be existing behavior too.

Matt

> Niranjana
> 
> > 		ttm_bo_tt_destroy(bo);
> > +	}
> > 
> > 	return ret;
> > }
> > @@ -835,7 +919,7 @@ int ttm_bo_validate(struct ttm_buffer_object *bo,
> > 	force_space = false;
> > 	do {
> > 		/* Check whether we need to move buffer. */
> > -		if (bo->resource &&
> > +		if (bo->resource && !ctx->defrag &&
> > 		    ttm_resource_compatible(bo->resource, placement,
> > 					    force_space))
> > 			return 0;
> > diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
> > index 3e3c201a0222..771313162c8d 100644
> > --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> > +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> > @@ -626,10 +626,22 @@ static int ttm_bo_move_to_ghost(struct ttm_buffer_object *bo,
> > 	 * bo to be unbound and destroyed.
> > 	 */
> > 
> > -	if (dst_use_tt)
> > +	if (bo->defrag_old_tt) {
> > +		/*
> > +		 * Defrag move: @bo already points at the freshly allocated,
> > +		 * beneficial-order tt that the move copied into. Hand the old
> > +		 * tt (the move's source) to the ghost so it is kept populated
> > +		 * until @fence signals and then unbound and destroyed, instead
> > +		 * of being torn down synchronously. @bo keeps its new tt.
> > +		 */
> > +		ghost_obj->ttm = bo->defrag_old_tt;
> > +		ghost_obj->defrag_old_tt = NULL;
> > +		bo->defrag_old_tt = NULL;
> > +	} else if (dst_use_tt) {
> > 		ghost_obj->ttm = NULL;
> > -	else
> > +	} else {
> > 		bo->ttm = NULL;
> > +	}
> > 
> > 	dma_resv_unlock(&ghost_obj->base._resv);
> > 	ttm_bo_put(ghost_obj);
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> > index 0ca63f5ce73c..d045105afc24 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -860,8 +860,11 @@ static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
> > 	 * pages. Record it so the driver can later try to defragment the object
> > 	 * back to beneficial order.
> > 	 */
> > -	if (it->beneficial_order && it->order == it->beneficial_order)
> > +	if (it->beneficial_order && it->order == it->beneficial_order) {
> > 		it->tt->page_flags |= TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
> > +		if (it->ctx->defrag)
> > +			return -ENOMEM;
> > +	}
> 
> NIT...probably good to add a comment here that says something like,
> 'return error here as the purpose of defragmentation is to get beneficial order'.
> 
> > 
> > 	it->order--;
> > 	it->page_caching = it->tt->caching;
> > diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> > index fd814b5cf535..f4f8a8c29f04 100644
> > --- a/include/drm/ttm/ttm_bo.h
> > +++ b/include/drm/ttm/ttm_bo.h
> > @@ -135,6 +135,16 @@ struct ttm_buffer_object {
> > 	 * reservation lock.
> > 	 */
> > 	struct sg_table *sg;
> > +
> > +	/**
> > +	 * @defrag_old_tt: Used internally during a defrag move to hand the BO's
> > +	 * previous, populated struct ttm_tt to the driver's move callback so
> > +	 * that it can copy the contents into the freshly allocated
> > +	 * beneficial-order backing. Set by TTM, consumed by the driver; the old
> > +	 * tt is freed (or restored on failure) by TTM once the move completes.
> > +	 * Protected by the reservation lock.
> > +	 */
> > +	struct ttm_tt *defrag_old_tt;
> > };
> > 
> > #define TTM_BO_MAP_IOMEM_MASK 0x80
> > @@ -194,6 +204,13 @@ struct ttm_operation_ctx {
> > 	 * reclaim/compaction before falling back to a smaller order anyway.
> > 	 */
> > 	bool beneficial_reclaim_backoff;
> > +	/**
> > +	 * @defrag: Defragmentation pass. Attempt a move even when the bo's
> > +	 * current resource is already compatible with the requested placement,
> > +	 * so that the backing store can be reallocated at the pool's beneficial
> > +	 * order.
> > +	 */
> > +	bool defrag;
> > 	/**
> > 	 * @resv: Reservation object to be used together with
> > 	 * @allow_res_evict.
> > -- 
> > 2.34.1
> > 
