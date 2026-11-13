Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D5F606A33D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gR7MhRqH;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=jy5LxV5G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EDDB1126AF;
	Fri, 13 Nov 2026 16:25:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B66C10E4DF;
 Fri, 13 Nov 2026 16:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794587097; x=1826123097;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=tkXl+h6BxY5h52cPzoZL9gFXDB/H149f4qy1E60FvmM=;
 b=gR7MhRqHqjwZSXT/hPqee81eCCgnl7J65gHrK4N7FsjuSQZ5tsm7Sm8K
 QpAr/LWzNzpjWzFcOXncjrl1d6pKtrfiZo58XTbh72tdajeZiI7aef8v1
 MPpxKxtTUju8kcPyxxKIZiJ4wMhaz5TwP99buPc6FaxdBlHeSQgOd0pNG
 auT1XJC0blL3Uu1d0Z02HS2EmxV+kFHWgYhpLJyC+5sZHcsTuLhsqv1dh
 iCwL6W114YAMLka/dxEDdY/9GNE6veuPYYqUzLJaruFFfpLq5pyu3FQOR
 pxQUndAyeofy+V6+VgjoFv/X84bs0YZMwumaE9iAVUmZJFHqUrg8Y3jWR w==;
X-CSE-ConnectionGUID: zVrARhxqT0auahnjs7YU2A==
X-CSE-MsgGUID: 6Cai26KYTVKYA0TEMI3X/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3299081"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3299081"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 08:24:54 -0800
X-CSE-ConnectionGUID: yMJXqCa0RzeTYQXcqWiGyA==
X-CSE-MsgGUID: nM1VWB1WTkqSbPtBmfIOgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="8803446"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 08:24:55 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 08:24:53 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 08:24:53 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 08:24:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abQQr3A219VdVSljzOxXo1K30QKTeg+8wTXNjWxLwC2GeAdnMSk7XYO812eMBE/+BAwBV7MO9rAjL4gtH012OX7ywlVGJtH2+O85ftCqVtbFtZ7RYFM50e7x4oOaDvnpi8enieztLatiQZRtmAao7cZ0qu62lWsw0N54zwpLXVr84qHeWIkW1bj5Z0Rws/8O+4gFYBlY7IIXA3eVYAJ6Yd+UBEzKtx0YMDuv4d/L5g/F6BZRiTaJv+0CWWM/QeuCBOQxMez47yUcp3dosoiusHY3aGx+Qm6EMHzTbKLPSr+rKeSNQwFY1vLa7tIJ2vr8NW+BVUTZQnXdX8bmw/YLYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASr9HiS9I9Se5TCgwbKtmWPayEVNvCfiDKSyWQtoH6M=;
 b=kDE5N6Rj8IJN/OfWRIkYflwg2RuH5DCn77FPWTaZgs68byu/YDNtlRMDKbN38rJA1jBUa7DLgEYv74zPDgm1uT7lEL47B2T/H/WFQLku2kg51U7wBWSEn6Ll9FuoOhfDLtxFre6BVA/HcC6fYNiTJUpdJAIl5Y3r5M99eDoZQmg/0pEVLtUVHMplTyxEjt/LC2ZaMQN6Fxt1y55QLVu/qAO9IkCfAvn9YHqvz4pc+pPL/J+dRmZRr8V7Je6rlSBnT2cxW4ChZtdKHAj9W9jzzE6HE1WyTpHSeua/4A5viFMOXE++vsQVKmhUtlySz+4whrBR2Af9yor1eMcdBEofFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASr9HiS9I9Se5TCgwbKtmWPayEVNvCfiDKSyWQtoH6M=;
 b=jy5LxV5GXod8p6Qtu/WQ5VaK/KoMIpwF9AQVQWMfVm2KbKy7/1epZICUx26KCv5FzwJlz+F6in1PNsymYWpDuX+qRzF5c5nPBHPNrdjixtgA4+tl3GJbgu+zvGnXepkY0OiD0I1pEigUHtCK0p2tvU0q5w4WtcxWfunxCQNWYng=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17)
 by DM4PR11MB5311.namprd11.prod.outlook.com (2603:10b6:5:392::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 16:22:16 +0000
Received: from DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e]) by DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e%6]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 16:22:16 +0000
Date: Fri, 13 Nov 2026 08:22:12 -0800
From: Matt Roper <matthew.d.roper@intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
CC: Arnd Bergmann <arnd@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 "David Airlie" <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Lucas De
 Marchi <demarchi@kernel.org>, Riana Tauro <riana.tauro@intel.com>, Arnd
 Bergmann <arnd@arndb.de>, Matthew Auld <matthew.auld@intel.com>, Shuicheng
 Lin <shuicheng.lin@intel.com>, Armin Wolf <W_Armin@gmx.de>, Zhanjun Dong
 <zhanjun.dong@intel.com>, Michal Wajdeczko <michal.wajdeczko@intel.com>,
 Piotr =?iso-8859-1?Q?Pi=F3rkowski?= <piotr.piorkowski@intel.com>, "Tejas
 Upadhyay" <tejas.upadhyay@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: xe: select configfs
Message-ID: <20261113162212.GB7214@mdroper-desk1>
References: <20261026102603.2045493-1-arnd@kernel.org>
 <avS7mZMrS7nQv_RK@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avS7mZMrS7nQv_RK@intel.com>
X-ClientProxiedBy: SJ0PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::14) To DS0PR11MB8182.namprd11.prod.outlook.com
 (2603:10b6:8:163::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8182:EE_|DM4PR11MB5311:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fce5ea7-5386-48a6-45eb-08df41a24816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|10067099003|4143699003|5023799004|11063799006|56012099006|261022105027099003|261022075727099003|261026140227099003|261026121527099003|261021121427099003|261022113327099003|261028144727099003|261102123227099003|261021123027099003|261009223027099003|261009220027099003|261009221727099003|261009223327099003|261009221227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: X+AaUzXdWgCw7BzFUQQCVGm9Erm0aEcsLnrzCp+swIF3UzuI/o9C1aUDH98bQdVd5PHqmKPDfkk2/4BJTBNGoThhtesJU3b83fHst7BsFnibdxhcseoFWMVv3AMkrhUX/XMnTG30dlwupuc9QmGGt9WkIojjNphW/1CIuWkop/zqsNx/kgKPelohJk/xfU9+I60Wzfja0y5v28CtEA32Vs6bjY0s2iQE7Z3ltt/2uKSfMF8lEodVnhQ1dyddOWBD488rp31uvccGMsS1qG4y8MYAGw2FPEj4nLxlWdczUJ3UshKklOgtLYlC5Kzpq0DLpN8OP+ZgN+yDeJp/pmwW+zhMeUO9ueuuwiFiItGhbdvux4Ik9gTIykEu5NMN6KC5zXH0WppuRcRo4WM1gQBcvXGYmCiuMTSDP9pg6kIpBZCzJhPY2WqAtwZeOra+osXVJ5KjfuWOLmyP6KunUo41Fis//8DM2gsqDH3Tp6V5T+Tk8pSnhXrVb+pWq0aQpKJvdOunbzAn1hEfsdO7xJn2uc8tzeF6mUBVYFEN/9D3CBqVN4QC6dzX7B3bHxI8DkacWNgnsHI+iOVXQL0Vl8vKjxKKlH5GVD63cehX8CTORMPOinWYzqn2ZzRdtnF1s3V8d/Wk4jQS6b61YjTIg7M83ClYjNinQlgGoAtO1z1rbnM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8182.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022113327099003)(261028144727099003)(261102123227099003)(261021123027099003)(261009223027099003)(261009220027099003)(261009221727099003)(261009223327099003)(261009221227099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ff4d+oFOoJY3bx3MW/uRNoStZGGv7qvnRatLrPlDgqP+8vBg+XTVU6qQl4mx?=
 =?us-ascii?Q?3nJtgxHwGpMwT2ISdmHsqDT59L6ApUCIcJoaPhN26wcVeae3yzGSdz6D73nt?=
 =?us-ascii?Q?322ju+03HElrzkM1JAYnr2Odd02Hlq7anwbeizd3lUXyUSKN/D2EG08GMKDP?=
 =?us-ascii?Q?DiRtqYRovjNIRlkGlrS3t40LVtaAHYroi+8Va59suUGZF/swB2jTnAeL/O6N?=
 =?us-ascii?Q?+d8wwCHmH8WY1cKnOMMpHQLjm3IFixCV+uox4BGhN2M52pn6P9fJZcGkRxIq?=
 =?us-ascii?Q?IwgaUxWPNzNAwAZcuEAbzc+S9rWpYYRCuLGolt72H3P4UhjIGQgilmFRPewy?=
 =?us-ascii?Q?gH6mB7sDhxZeAcAlHTP4ZjCeSBNs69t2ad0IaMSAXyRtpN0EaM4o5BkChDPC?=
 =?us-ascii?Q?QIxQX/TXuP1yPdtXEKyDHsdSj4eyum8ABw5BvpfVpEznzohNhsT4o8bq4mg/?=
 =?us-ascii?Q?9fZ4l2QAZvtsRWFsQmAiGXke9B4GL5FBDTdOJJcKQa7Cfmgt8rP9bmuAy4gS?=
 =?us-ascii?Q?C2qkt6ZuPJQxmqGxgefKLFK8AfWxGFR+Q9TB93hFNSLKwDvRo5WqEWIHSJM1?=
 =?us-ascii?Q?FSMrgpGSlxje6+Nfz0cfe+t71WOXtkf1EyMkqEkvoBX9ZIp7KoWzHd8R9T0z?=
 =?us-ascii?Q?LlIrU38PA0SE9UewSFv6nsxDxmXEOIv4F48dzKkDID+7k1LHokhsy5pIiriH?=
 =?us-ascii?Q?9nxi4X2/kiKQgbs7SN4r7YcrlwS1c6gCbn8BhzBp2I/MuFfJ1NYnfMnk7YEx?=
 =?us-ascii?Q?yRq3rWFzeqVJEbZtO5eBYrMNlXRUKhkomeWVOlkax4+/VFMog4jM+2dRdP8F?=
 =?us-ascii?Q?kIp/bLrzh9GDvD2YE32a2sBwKcj/xirJlyAJqc2gE2GWPWv38zSqf0b4Q7fO?=
 =?us-ascii?Q?BiRX5oheo9tYK4+sjgx8rYUbegeWnzP6bwX6XgqLBokQNB3TK6Xyk96QwZSm?=
 =?us-ascii?Q?KdL8smM1cwtQpCpRc9VLwM0hjo0KZBEKtBgbkCdFXK4odDUf/EYeDoWClRKW?=
 =?us-ascii?Q?ppWxiP11cNCD6v0SlOxEPZDyMW11x73KgXH6U2mLcu61hmDvI6BEMudUaDP3?=
 =?us-ascii?Q?LX/tmneuc2abP7VgmXjIz4p7E4vgYg44CDwawnDNxrAC/tHnIaXFXnwyHbMy?=
 =?us-ascii?Q?xMubo0FU0F3bRA9B8JT4JFL/PdaZr+IqJxcShCFYCDGiF9X4mxTAbUflUZaB?=
 =?us-ascii?Q?4gNH6eaCKEsaK0dsuqyJE1Vtf+kJCOIj9EybNTcx2w7xgEDUkmZfc3a4wiDm?=
 =?us-ascii?Q?CwhpPgxxfALxc6XLdq0I/lODpBp/8Qs/JZkArajhJRBB3Oqifj3a5zW09WP2?=
 =?us-ascii?Q?ds/l53X40I+oXQwxymGl+lDW8zMeo6seHcC356vIDbcOi5WKDniz9Vyun0QU?=
 =?us-ascii?Q?3bh/JayoMVoit1O45YVPUdsVq/IeI84aTySdBX8qdB1SiphFShK+9uCc0qgn?=
 =?us-ascii?Q?Rg1IlNbMIGeifNa9sEpPmzZscTVuf1na26lbvwb3eRAMQ58WIFIvOzC8lNe2?=
 =?us-ascii?Q?OFdOeBRK+X7IYA8/ejLsOFAYf0lINYgeIJqGrLCh5p8SappX8UNdvZkNck3G?=
 =?us-ascii?Q?PLwJE2jP0PeW1bb5d7l9ShQqOYsD8fE+tWh95LHEKquoCBQPhTIDaNI+KLFO?=
 =?us-ascii?Q?0VMtQbzai13fUph/ofVijLXeuC0fDcUCoOk66Hc9TWHSisuUkpYCVohp9bmQ?=
 =?us-ascii?Q?jgwaaymqZx5Q6qvp6o2Y2HloUJcjjXtW6gX/IwQdXz50ooy4KYLFwK5gkW5e?=
 =?us-ascii?Q?5PO1Iwp3dVh8Zcp91+V/dv+xL4R3QzI=3D?=
X-Exchange-RoutingPolicyChecked: dry8mow0sLiY0l/8QUArI89BorUl8GR25vZIIpxHVsjcbTsMe/j8UEzb3adBlF2J/D4HAsmav+9Og5M8yzEVlKgQfInp5iNSx3ZIe+1upfS6LpjOo84jxXq4gFEmdcktU8bNRCdZAs44rHgJTIvHOfdK57eCfeF0kdT8O1QuOswGjNaIat7uZLfDV57/m2lgpDE2w+dcvKzELXk1YB9Z1EazHHUqr39/fetRo3QX5J959xTyeoePK7SS40VpiaLQOnkTbRTM/k8Pna9RYI6Y3CXtp8ZtC0y77+MtEafiW2m7TLQHoIIc3hIuIfXWS0JcaDuxDQsPVkjHMqK+4t2R8Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fce5ea7-5386-48a6-45eb-08df41a24816
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8182.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:22:16.4705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebVWG/zwlwjB4K3Td+qPuC67B6Ut00VtPIvS7wqITu4dmBOpsZoJ4xGBO9ja5vqBt0A/Aje6Tg7pBrslbmQkbpJM5tqrpw3QCUCM/KHe4Hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5311
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

On Wed, Nov 11, 2026 at 02:01:45PM -0500, Rodrigo Vivi wrote:
> On Mon, Oct 26, 2026 at 11:25:50AM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The original addition of configfs to xe missed a compile-time dependency,
> > which leads to a link failure when configfs is enabled as a loadable module:
> > 
> > ld.lld-21: error: undefined symbol: xe_configfs_get_survivability_mode
> > >>> referenced by xe_survivability_mode.c:224
> > >>>               drivers/gpu/drm/xe/xe_survivability_mode.o:(xe_survivability_mode_is_requested) in archive vmlinux.a
> > 
> > A recent workaround added a 'IS_REACHABLE()' check around the calls into
> > configfs, which makes it link in this configuration, but this is generally
> > a bad idea because it makes the actual behavior inconsistent and confusing
> > to users that expect configfs to work if both xe and configfs are enabled.
> > 
> > Use 'select CONFIGFS_FS' instead, like every other configfs user does,
> > and remove the unnecessary stub functions. There is little practical
> > difference here as anyone using XE graphics is likely to have a complex
> > configuration that already selects configfs anyway, and the link error
> > or the IS_REACHABLE() would only manifest during randconfig testing.
> > 
> > Fixes: 30499cbd7961 ("drm/xe: Fix build with DRM_XE=y and CONFIGFS_FS=m")
> > Fixes: 16280ded45fb ("drm/xe: Add configfs to enable survivability mode")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/gpu/drm/xe/Kconfig       |  1 +
> >  drivers/gpu/drm/xe/xe_configfs.h | 30 ------------------------------
> >  2 files changed, 1 insertion(+), 30 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
> > index 4fc8abdc5cb6..b52a8dc28f97 100644
> > --- a/drivers/gpu/drm/xe/Kconfig
> > +++ b/drivers/gpu/drm/xe/Kconfig
> > @@ -11,6 +11,7 @@ config DRM_XE
> >  	# the shmem_readpage() which depends upon tmpfs
> >  	select SHMEM
> >  	select TMPFS
> > +	select CONFIGFS_FS
> 
> Perhaps another option would be what Jani had suggested:
> 
> config DRM_XE_CONFIGFS
> 	def_bool y
> 	depends on DRM_XE && CONFIGFS_FS
> 	depends on CONFIGFS_FS=y || DRM_XE=m
> 
> But anyway, we are depending more and more on the configfs for
> production choices. So, let's go with you select and close this
> for good.

I really don't think this patch was the way we wanted to go.
IS_REACHABLE was giving us exactly the behavior that we wanted, but now
we're getting behavior that we did not want.  Xe absolutely does not
depend on configfs in any way.  _If_ configfs is there we'll enable some
config options in it, but none of those are mandatory for our driver as
a whole.  We're perfectly happy to build and run without configfs if
it's not selected in the config.  We're also happy to build and run
without configfs functionality if the user wanted Xe built directly into
the kernel, but configfs was built as an unreachable module solely for
other non-Xe purposes.

While this change won't matter to 99% of the cases where someone is
running with a typical distro kernel, this is the kind of thing that
makes embedded users unhappy since they're very carefully managing their
configurations and we've taken away their ability to avoid configfs now.

Also, as mentioned earlier in the threads, using 'select' on a
user-visible config option rather than a hidden option often causes
cascading problems down the road because it ignores any dependencies of
the option being selected (configfs in this case).  At the moment I
don't think configfs has any dependencies of its own, but if it gets
some down the road, this can cause problems.


Matt

> 
> I'm pushing this to drm-xe-next.
> 
> Thanks for the patch.
> 
> 
> >  	select DRM_BUDDY
> >  	select DRM_CLIENT_SELECTION
> >  	select DRM_KMS_HELPER
> > diff --git a/drivers/gpu/drm/xe/xe_configfs.h b/drivers/gpu/drm/xe/xe_configfs.h
> > index 327b648944ff..d726800de26a 100644
> > --- a/drivers/gpu/drm/xe/xe_configfs.h
> > +++ b/drivers/gpu/drm/xe/xe_configfs.h
> > @@ -14,7 +14,6 @@
> >  
> >  struct pci_dev;
> >  
> > -#if IS_REACHABLE(CONFIG_CONFIGFS_FS)
> >  int xe_configfs_init(void);
> >  void xe_configfs_exit(void);
> >  void xe_configfs_check_device(struct pci_dev *pdev);
> > @@ -36,34 +35,5 @@ u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev,
> >  unsigned int xe_configfs_get_max_vfs(struct pci_dev *pdev);
> >  bool xe_configfs_admin_only_pf(struct pci_dev *pdev);
> >  #endif
> > -#else
> > -static inline int xe_configfs_init(void) { return 0; }
> > -static inline void xe_configfs_exit(void) { }
> > -static inline void xe_configfs_check_device(struct pci_dev *pdev) { }
> > -static inline bool xe_configfs_get_survivability_mode(struct pci_dev *pdev) { return false; }
> > -static inline bool xe_configfs_primary_gt_allowed(struct pci_dev *pdev) { return true; }
> > -static inline bool xe_configfs_media_gt_allowed(struct pci_dev *pdev) { return true; }
> > -static inline u64 xe_configfs_get_engines_allowed(struct pci_dev *pdev) { return U64_MAX; }
> > -static inline bool xe_configfs_get_psmi_enabled(struct pci_dev *pdev) { return false; }
> > -static inline bool xe_configfs_get_enable_multi_queue(struct pci_dev *pdev) { return true; }
> > -static inline u32 xe_configfs_get_migrate_ulls_period_ms(struct pci_dev *pdev) { return 5; }
> > -static inline bool xe_configfs_get_disable_vram_page_offline(struct pci_dev *pdev) { return false; }
> > -static inline u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev,
> > -						     enum xe_engine_class class,
> > -						     const u32 **cs) { return 0; }
> > -static inline u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev,
> > -						      enum xe_engine_class class,
> > -						      const u32 **cs) { return 0; }
> > -#ifdef CONFIG_PCI_IOV
> > -static inline unsigned int xe_configfs_get_max_vfs(struct pci_dev *pdev)
> > -{
> > -	return xe_modparam.max_vfs;
> > -}
> > -static inline bool xe_configfs_admin_only_pf(struct pci_dev *pdev)
> > -{
> > -	return XE_DEFAULT_ADMIN_ONLY_PF;
> > -}
> > -#endif
> > -#endif
> >  
> >  #endif
> > -- 
> > 2.53.0
> > 

-- 
Matt Roper
Graphics Software Engineer
Linux GPU Platform Enablement
Intel Corporation
