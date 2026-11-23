Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E099D606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 21:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=atOlnnZB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Vj3VN/Zc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C0BB10E551;
	Mon, 23 Nov 2026 21:24:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B303110F219;
 Mon, 23 Nov 2026 21:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795469066; x=1827005066;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=nvximz52sjHQa1cQP9ElxsU9IUrMTItLy8uvC5HDdA4=;
 b=atOlnnZBw1sptCO9jISqae3PsvoXcV+SUs6s8QkW8+jkYd9UxerfX1FZ
 jMdWx+RYIzVviVO/lr0BFpYDz5ae7NSrdT4nOnA2HbahfCRhG7xw96pzl
 BpcYQlslB7bfZakwsaHJIqN3lJ/WfEv+5SbnxewiPQXzpYPGLqCOt8829
 KjFHz9P6iac4CCqhlvIQaI3RooxLSnVXto46nFT2IcvwqfOVicNw8gPyS
 KN4ApfpUAHhfcBimMlPrf3bC+YZANm5P+BevKCKWHI7CKFOZIVzRfFRNY
 qi5c4o0iZYVCmuylTgMWwux+3HDTssGdpsGKy8xlPSULRIMpkwleNem2s Q==;
X-CSE-ConnectionGUID: k6BnYptcSIKYa3weyqoaOQ==
X-CSE-MsgGUID: PC44r8gxTaSgL67Ri3T5Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4173144"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4173144"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 13:24:25 -0800
X-CSE-ConnectionGUID: qbaPcQKZTAqqBuBISq78Vw==
X-CSE-MsgGUID: wRew2vSlRb2JqmxnouP0iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11570536"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 13:24:24 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 13:24:23 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 13:24:23 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.54) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 13:24:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVuqFDUpexo1sK5c/SuboT6HE8ujVANCRJa5w1fQhwMlndUHlZEfPLZe785wFawbC6o+UYdSCpoVf/V20UZOBg/vTzk7p5W4cUi1s3RqBE+o3NaoIAUrsz7CxoIo5RE9moWa+UKo1CMtxVeA3QD0S3ARS40hShTPXOArfsrOh8CxxJdXbpCe3DXEREKNS2whrI7BXC8CUUaVLnliOlfvu+OeqK9Rml6gLiK36ppP20osA43M6DTwavRVP8ONOXCWmjWEROCxCGXBSfYVridnj5HeKDxvuLEAkUqJrxYwMLAcbLeaZ+zPGXwtwscYTSqxbolJhjtuc0zQtb644VZSUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sN0OU8YZURWiaTW8YwXOyTP4EkMhm7piycs/lYEQ3Q=;
 b=Lz35las1DqVGFQTvEaYQ5Dahe6SNwxhTK8cNu6MrxtPwC7y/JKQM5Avupefe+rFLKUljjnfzT4zXkZMKvgpgEf60khKLHWEu1o7Ksopnv5Vwx963VQ/5xq15TFFYPwpDxV4iCfW8qBUpevr/oJxlTsHPkCAE768mtL6sQTYa4MCGYE1WpuUbarR9y/paIzB5HOLDYw8hF/MAgI39sh3Q99wFhLFmHbZmA5AzR/NzsPypyNQSh43YAgzlvL4n2v9eyppE37gcIoQnTmAbveoI5acxBr3jKnM08tKl5rtVVVku7U2hgGIIfHN8hrMjOldwiMiXk/Fenodq/BMeRSdkdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sN0OU8YZURWiaTW8YwXOyTP4EkMhm7piycs/lYEQ3Q=;
 b=Vj3VN/ZcKt05WDY+KRiyryjfAJCUCvbOdNqHekoyL22H7AEJwit10hNc/4T0IlJIKdP9yGAlaEyC2eoltZl/LefpvaHtshxPLDG7rkLWo8HIV7sfDdApL7twKnudJGVxXK1IAEgmZMy5Ls0LrkvJbatMVnfl5D7C9K8izNuPfW4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by BN9PR11MB5259.namprd11.prod.outlook.com (2603:10b6:408:134::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 21:24:13 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 21:24:13 +0000
Date: Mon, 23 Nov 2026 13:24:10 -0800
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
Subject: Re: [PATCH v3 08/33] drm/ttm: Bound page (re)allocation per
 defragmentation move
Message-ID: <awSu+nEkfvkNHcTG@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-9-matthew.brost@intel.com>
 <avKE9ruZsQwbsQEa@nvishwa1-desk>
 <av+s/38v9gtCDhhr@gsse-cloud1.jf.intel.com>
 <awCvgBh6-2-tinXR@nvishwa1-desk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awCvgBh6-2-tinXR@nvishwa1-desk>
X-ClientProxiedBy: SJ0PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::20) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|BN9PR11MB5259:EE_
X-MS-Office365-Filtering-Correlation-Id: e904249b-1454-486c-437d-08df49a81ed2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|23010399003|22082099003|18002099003|11063799006|56012099006|261022075727099003|4143699003|261028144727099003|261022113327099003|261022105027099003|261026140227099003|261026121527099003|261021121427099003|261102130727099003|261009223027099003|261009221727099003|261021123027099003|261009220027099003|261102123227099003|261009223327099003|261009221227099003|10067099003;
X-Microsoft-Antispam-Message-Info: Bj1j0polBldU7CjDNbvAqYX6O5ns9IRynpFcQjnzocIw9W9EQ3O/6ytXTXxEyCIR8AGe94QItKZThjmINcMM59CxJBY9LTJG2CJDok0/w4wlYPu5CSL5ANadgySooa6GPy9G4/5szVlLKHdN9wYcwpQFlLu1f3QmfoOs/GXJXmX6cL/V2d5TpbloJ4W81E27+CssJ86z2yraYQYIiU4NyBdNQLxR4JdhXhTm1W8enMBM6f47DRzIpm6MFguK5UPov8vpxwtCcy7OrwxCBnBsNmP+0aFJNi4b1ot3QKg2CKJWLokQW0r45Dpbtr1jKL3w5wC92ikHK1jPlMwILSLjxR+Jp1nu9PypXsta679kwffiwyRVwg0Vlj861LHA5wiHjwKVOdjFY7IAjVzz/dS95LUZhIBmwe7MNsWKj9Ts7Zs9m9fhAoOULeOp5u8yZWmoCNxoHY5jVDr+wNiROiDXiGujxNcUuOw5lWBvwvvZLNbb4HLAXeKFKv951zhZ9iUKhy5E++vbMcf+o6oiZSbsxDAShiP3U2dHu6tyex4v/AnT+VQXTnATsFmHrvbzwUoh69IdxGGgv2afPEg5GeK6v6s/yW92i/p9LG09XQV/wOKyVzBmiDO1umw4wPp/INo0QNwR/zS26gb/g8euDLMnTBZVb3QTjnN7RlfNsoOs/Qg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(261022075727099003)(4143699003)(261028144727099003)(261022113327099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021121427099003)(261102130727099003)(261009223027099003)(261009221727099003)(261021123027099003)(261009220027099003)(261102123227099003)(261009223327099003)(261009221227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2T5wUVVFtm1I7TckmbA1Emqm3QONjsTUM+HUwOaoM5rLzfSKI2xGlrj8DG?=
 =?iso-8859-1?Q?AYQsDgDMWLajrfKSG/DRL2VWVqthKLyRP44VVu/IDp/7oRkAs93lwZ3trG?=
 =?iso-8859-1?Q?KccG+1f2y09zNx5kkazo38hbuFykkPLAHwzTkzyNV5ZvZcX8T5ozG0bnHD?=
 =?iso-8859-1?Q?DwD9RlXiQP+w5k6jSSgo3ybYYr0MY0Io2iT9c9372LGeBJVgEzlmp3iQFr?=
 =?iso-8859-1?Q?sR6bV5LFm3HzZvXnPbVeHXN7f8QH4k4xWl5RAqNmRWIsYjKTLvo+4jvdMG?=
 =?iso-8859-1?Q?wJMCBHvf3Un14fl4d/5r6X/ESPCWGxKNYjZbFBymAYi4LKBSJywG0m2x7/?=
 =?iso-8859-1?Q?JGJWkKkPp5othWMuaD9vxxxbpTSVRncDFS62KUT65J0NeJAwnq57ZMQaet?=
 =?iso-8859-1?Q?RchjinS38VwkJ0QtAoFBg1Z1jKsXYLlYU1U4/H1e1ty/iLdYFQ9AJSNk3U?=
 =?iso-8859-1?Q?ePsYdWd0PdZXYHkiYjfsj4aguYR5q4VwjBefyX5QAGdkplRnJ/gipPp1K5?=
 =?iso-8859-1?Q?xmk+lL9ygidMU2jAym5Oc0qxSBRjijnFUIik+nda/gVjSoRjwnxsXXhjWu?=
 =?iso-8859-1?Q?mWCFqiXN+U0G5jvdh34yYhQA6QZZ+4KMI4i2n8jjaXaxkDZmJ2BwoJji5+?=
 =?iso-8859-1?Q?8EWeaJtyQgnZzIQAoyVbOqb63ONfyHGfeb51EjH45BkOi/DGYK417LqA00?=
 =?iso-8859-1?Q?KnrBddrmXuZO4JV7IGyt7S58MSLLvuUqxd1lUcJTk9tza3t82RrcL2CGpi?=
 =?iso-8859-1?Q?RR5mtnO3OyhQHwLKlGdKnEA5OCE+9cbr+ZJ+nNNMmJFAWtJug2WneWwsK+?=
 =?iso-8859-1?Q?yaCCrZqchC0ZIS6Y890P7oHCljBsLQ0RlafqoAZLAtZelVnM3BO/eksBsy?=
 =?iso-8859-1?Q?ICSlk/7U/i2imNmhCjJhFcoNzWbjASlCgUhfJkYQ2l7xhDeXH2WoBs1H4M?=
 =?iso-8859-1?Q?7wZlMqcAgz/Co1gZ3siL9yqoOMkqD2hjDYFtWl/94VPLLPfNNlRmYx1TTj?=
 =?iso-8859-1?Q?UyzsscByr13zOsol6I1+ENh/sXVSSPpJMQeK3Hvlgii8xle1xEwqx4Wz+B?=
 =?iso-8859-1?Q?SnBXigmnKoiGddfAAkuL3l/O4hWGBEzO7+SGzKC67sO82oP6RheULeiM9V?=
 =?iso-8859-1?Q?0E599gBJxBlPJ0y+E3n0EWIiWhJQka1+ALZLkcjitwSpc20zjSBDq67KS/?=
 =?iso-8859-1?Q?B7QI5QqidfXWnd4zCdOj8mBUU4/HMFrj7m9ElFtq0Rx7c39paTJPx6IXDj?=
 =?iso-8859-1?Q?A6XlrM17rIZx4FjsWO/n3K0nwxMNnVYLbf+mmPO65x/xuJy3VK0D6D+G23?=
 =?iso-8859-1?Q?zdVQD1wVz82s79JKlY5DQbj/mcZ67Fgw8fzzBkMSi/mbrmEaq11YZ0mZK1?=
 =?iso-8859-1?Q?LgOtgo9tFGE4sisDDcuRoye+LSvrKFzpogd2DZuAKWGSBZk92sSPuf7ANQ?=
 =?iso-8859-1?Q?jGzxSKmYomGUnfqYLHgvcf22Q1D29yPh+90waTwP+vfRIpS0MHkPoKVhPj?=
 =?iso-8859-1?Q?4HNXRxa5UdrwJQThh53bngAGVjORhcXIvgMSI4b2zE4jGnKShL3hQtg1iu?=
 =?iso-8859-1?Q?ttvka8ILPc3nyD7tXfT1pEiINTlM3WpKvwV2F5/8oKR/LcWSyvDP33YCz7?=
 =?iso-8859-1?Q?06giIxUo1oorE09RbCzfMcFWKxKTKpqst70LdIAvyHfPGRd2txJ5Ni+8EL?=
 =?iso-8859-1?Q?1Afx2HUl4mMtRsLhOO+16nAu+6EE6fVW5R0ZBdRCMELJw+wxTEPxn0YUYs?=
 =?iso-8859-1?Q?hbuBe2ho8n9n83AQHGTa3RAx8kLFvz8GR2hwB1pMEJR7W5dogpn1/xTKt6?=
 =?iso-8859-1?Q?PLBqYkdSNN1InMYJjTSI+AdkCVVvUh8=3D?=
X-Exchange-RoutingPolicyChecked: mlNghVYNu4gnDAC3JY6wj5bHrpzKMJvFfYW6UnrHbq12gKXE0qaFknYF0mRhVlQvq08YdOb5xl2FnacMZsZFzg/L2K+xKmJ9oMbvZhbL/ZfH0pdrY8F4NP/csRmKfuCycWUT8HL+jcrIHv6NNitqukhwVztCO+JH1RoVxus2EDlluW+C6FuTt/K18GBRwI6HkgYRcQO4ExUe0OKgIq2yRoUs2iAYLfVof7FfuGQSicKeDB3DFB4R52ocucOsNLe7TofBelxrfNfKDpQzfb7YKyqhKyzFnGcAS5AQrcIklxhatzyAkJfLn8hrJa/A4WKpfnLKwJ058VdYHHA83GKLQg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e904249b-1454-486c-437d-08df49a81ed2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 21:24:13.3137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yyUXvdqLidH4Z708XwZdqsS/vVEhYVkBnQ6wM4GxEjQnBdweOQa4N5R4cesc5dQyFK+/nwvG9DdSTe0c0hEqmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5259
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

On Fri, Nov 20, 2026 at 12:37:20PM -0800, Niranjana Vishwanathapura wrote:
> On Thu, Nov 19, 2026 at 06:14:23PM -0800, Matthew Brost wrote:
> > On Mon, Nov 09, 2026 at 06:44:06PM -0800, Niranjana Vishwanathapura wrote:
> > > On Fri, Jul 10, 2026 at 07:55:54PM -0700, Matthew Brost wrote:
> > > > A defragmentation move reallocates an object's backing at the device's
> > > > beneficial order and harvests whatever the allocator cannot upgrade from
> > > > the old tt. For a very large object this can reallocate (and have the
> > > > driver re-copy) the entire backing in one move, which is expensive and
> > > > can stall concurrent work for an unbounded stretch.
> > > 
> > > Assisted-by: LLM
> > > 
> > > NIT...So, a time budge would also be helpful here along with the size
> > > budge?
> > 
> > That could be option but a size budget seems like reasonable place to start.
> 
> ok
> 
> > 
> > > 
> > > >
> > > > Add an optional per-move byte budget so a large object can be upgraded in
> > > > slices across successive moves. Plumb a new
> > > > ttm_operation_ctx::defrag_bytes_remaining through to the pool allocator:
> > > > only pages actually (re)allocated at the beneficial order are charged
> > > > against it; pages harvested (borrowed) from defrag_old_tt are free and do
> > > > not count. Once the budget is exhausted the allocator stops upgrading and
> > > > completes the new tt by harvesting the remainder of the old tt as-is,
> > > > marking the tt sub-optimal (TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED) so the
> > > > driver re-queues it and a later move resumes the upgrade. The slices
> > > > already upgraded come back as free already-beneficial harvests on the
> > > > next pass, so each move spends budget only on new forward progress.
> > > >
> > > > The allocator decrements the budget as it allocates and writes the unused
> > > > remainder back on success, letting the caller compute how many bytes were
> > > > actually spent. A value of 0 means unlimited (upgrade the whole object in
> > > > one move), preserving the previous behaviour. This is only consulted on a
> > > > defragmentation move, i.e. when defrag_old_tt is set.
> > > >
> > > > Cc: Carlos Santa <carlos.santa@intel.com>
> > > > Cc: Ryan Neph <ryanneph@google.com>
> > > > Cc: Christian Koenig <christian.koenig@amd.com>
> > > > Cc: Huang Rui <ray.huang@amd.com>
> > > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > > Cc: Maxime Ripard <mripard@kernel.org>
> > > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > > Cc: David Airlie <airlied@gmail.com>
> > > > Cc: Simona Vetter <simona@ffwll.ch>
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > > Assisted-by: GitHub_Copilot:claude-opus-4.8
> > > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > > > ---
> > > > drivers/gpu/drm/ttm/ttm_pool.c | 101 ++++++++++++++++++++++++++++++++-
> > > > include/drm/ttm/ttm_bo.h       |  14 +++++
> > > > 2 files changed, 112 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> > > > index 52f5e64f05dd..1673e81b8df8 100644
> > > > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > > > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > > > @@ -77,6 +77,11 @@ struct ttm_pool_dma {
> > > >  * @dma_addr: Pointer to the next tt dma_address entry to populate if any.
> > > >  * @remaining_pages: Remaining pages to populate.
> > > >  * @tt_caching: The requested cpu-caching for the pages allocated.
> > > > + * @defrag_bytes_remaining: Byte budget for newly (re)allocated pages on a
> > > > + * defragmentation move, seeded from ttm_operation_ctx::defrag_bytes_remaining.
> > > > + * Pages harvested (borrowed) from the old tt are free and do not count; once
> > > > + * this drops to zero the allocator stops upgrading and harvests the remainder.
> > > > + * On completion it holds the unused budget. 0 means unlimited (no defrag cap).
> > > >  */
> > > > struct ttm_pool_alloc_state {
> > > > 	struct page **pages;
> > > > @@ -84,6 +89,7 @@ struct ttm_pool_alloc_state {
> > > > 	dma_addr_t *dma_addr;
> > > > 	pgoff_t remaining_pages;
> > > > 	enum ttm_caching tt_caching;
> > > > +	s64 defrag_bytes_remaining;
> > > > };
> > > >
> > > > /**
> > > > @@ -780,6 +786,7 @@ static void ttm_pool_alloc_state_init(const struct ttm_tt *tt,
> > > > 	alloc->dma_addr = tt->dma_address;
> > > > 	alloc->remaining_pages = tt->num_pages;
> > > > 	alloc->tt_caching = tt->caching;
> > > > +	alloc->defrag_bytes_remaining = 0;
> > > > }
> > > >
> > > > /*
> > > > @@ -885,8 +892,12 @@ static int ttm_pool_harvest_page(struct ttm_tt *old_tt, unsigned int order,
> > > >
> > > > static int ttm_pool_harvest_remaining(struct ttm_pool *pool,
> > > > 				      struct ttm_tt *old_tt, pgoff_t off,
> > > > -				      struct ttm_pool_alloc_state *alloc)
> > > > +				      struct ttm_pool_alloc_state *alloc,
> > > > +				      bool *suboptimal)
> > > > {
> > > > +	unsigned int beneficial = ttm_pool_beneficial_order(pool);
> > > > +	pgoff_t bnr = 1UL << beneficial;
> > > > +
> > > > 	/*
> > > > 	 * @off is always an old-tt chunk head here, never a tail page, so
> > > > 	 * reading the per-chunk order below is safe. This holds because:
> > > > @@ -906,8 +917,23 @@ static int ttm_pool_harvest_remaining(struct ttm_pool *pool,
> > > > 		struct page *p = old_tt->pages[off];
> > > > 		unsigned int order = ttm_pool_page_order(pool, p);
> > > > 		pgoff_t nr = 1UL << order;
> > > > +		pgoff_t num_pages = off + alloc->remaining_pages;
> > > 
> > > num_pages seems loop invariant. May be move it out of the loop as total_pages
> > > or something?
> > > 
> > 
> > No, both 'off' and 'alloc->remaining_pages' change each iteration of the loop.
> > 
> 
> Yes, but the sum 'off + alloc->remaining_pages' is always equals to
> it->tt->num_pages, as we do +nr to offset and -nr to alloc->remaining_pages.
> 

Right, my mistake. Let me move this out of the loop.

Matt

> > > > 		int r;
> > > >
> > > > +		/*
> > > > +		 * Only report a sub-optimal backing when a chunk we cannot
> > > > +		 * upgrade (out of budget/prealloc) sits in a beneficial-order
> > > > +		 * aligned region that fully fits in the tt: that region could
> > > > +		 * have been upgraded with more budget. A chunk below the
> > > > +		 * beneficial order is expected for the unaligned tail (the last
> > > > +		 * partial beneficial-order region) and for already beneficial-
> > > > +		 * order harvests - neither leaves real defrag work, so they must
> > > > +		 * not flag the tt for re-queue.
> > > > +		 */
> > > > +		if (beneficial && order < beneficial &&
> > > > +		    round_down(off, bnr) + bnr <= num_pages)
> > > > +			*suboptimal = true;
> > > > +
> > > > 		r = ttm_pool_harvest_page(old_tt, order, off, alloc);
> > > > 		if (r)
> > > > 			return r;
> > 
> > e.g., below here (unseen) 'off' is incremented by 'nr'.
> 
> yes, but alloc->remaining_pages is decremented by 'nr'.
> 
> > 
> > > > @@ -951,6 +977,7 @@ struct ttm_pool_alloc_iter {
> > > > 	struct ttm_tt *defrag_old_tt;
> > > > 	unsigned int beneficial_order;
> > > > 	gfp_t gfp_flags;
> > > > +	bool defrag_capped;
> > > >
> > > > 	/* Mutated as the loop walks the orders. */
> > > > 	unsigned int order;
> > > > @@ -962,6 +989,44 @@ struct ttm_pool_alloc_iter {
> > > > 	struct page *p;
> > > > };
> > > >
> > > > +/*
> > > > + * Defrag move budget exhausted: the upgrade can make no further progress this
> > > > + * pass. Snapshot @defrag_capped is set only when a byte budget was in force at
> > > > + * entry.
> > > > + */
> > > > +static bool ttm_pool_iter_defrag_exhausted(const struct ttm_pool_alloc_iter *it)
> > > > +{
> > > > +	if (!it->defrag_old_tt)
> > > > +		return false;
> > > > +
> > > > +	return it->defrag_capped && it->alloc->defrag_bytes_remaining <= 0;
> > > > +}
> > > > +
> > > > +/*
> > > > + * Complete the new tt by harvesting the rest of the old tt as-is (borrowing its
> > > > + * pages, including any still below beneficial order). Never fall back to in-lock
> > > > + * reclaim for the shortfall - that would reintroduce the stall we preallocated
> > > > + * to avoid. Only re-queue (flag) the tt when the harvested remainder is
> > > > + * genuinely sub-optimal; if every remaining old chunk was already at beneficial
> > > > + * order the move fully upgraded the object.
> > > > + */
> > > > +static int ttm_pool_iter_harvest_rest(struct ttm_pool_alloc_iter *it)
> > > > +{
> > > > +	pgoff_t off = it->tt->num_pages - it->alloc->remaining_pages;
> > > > +	bool suboptimal = false;
> > > > +	int r;
> > > > +
> > > > +	r = ttm_pool_harvest_remaining(it->pool, it->defrag_old_tt, off,
> > > > +				       it->alloc, &suboptimal);
> > > > +	if (r)
> > > > +		return r;
> > > > +
> > > > +	if (suboptimal)
> > > > +		it->tt->page_flags |= TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > /*
> > > >  * Defrag move: reuse an already beneficial-order chunk from the old tt at this
> > > >  * offset rather than reallocating it. Harvest whatever order the old chunk has
> > > > @@ -1062,11 +1127,12 @@ static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
> > > > 		if (it->alloc_count && it->defrag_old_tt) {
> > > > 			pgoff_t off = it->tt->num_pages -
> > > > 				      it->alloc->remaining_pages;
> > > > +			bool suboptimal = false;
> > > > 			int r;
> > > >
> > > > 			r = ttm_pool_harvest_remaining(it->pool,
> > > > 						       it->defrag_old_tt, off,
> > > > -						       it->alloc);
> > > > +						       it->alloc, &suboptimal);
> > > 
> > > As suboptimal is not required here, probably send a NULL here and have
> > > ttm_pool_harvest_remaining handle that NULL.
> > > 
> > 
> > That is better will change.
> > 
> > > > 			if (r)
> > > > 				return r;
> > > >
> > > > @@ -1121,10 +1187,23 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > > > 		gfp_flags |= GFP_HIGHUSER;
> > > >
> > > > 	it.gfp_flags = gfp_flags;
> > > > +	it.defrag_capped = it.defrag_old_tt && alloc->defrag_bytes_remaining > 0;
> > > >
> > > > 	for (it.order = ttm_pool_alloc_find_order(MAX_PAGE_ORDER, alloc);
> > > > 	     alloc->remaining_pages;
> > > > 	     it.order = ttm_pool_alloc_find_order(it.order, alloc)) {
> > > > +		/*
> > > > +		 * Out of defrag budget: harvest the rest of the old tt as-is and
> > > > +		 * stop (the tt is re-queued if the remainder is still
> > > > +		 * sub-optimal).
> > > > +		 */
> > > > +		if (ttm_pool_iter_defrag_exhausted(&it)) {
> > > > +			r = ttm_pool_iter_harvest_rest(&it);
> > > > +			if (r)
> > > > +				goto error_free_all;
> > > > +			break;
> > > > +		}
> > > > +
> > > > 		/* Reuse an already beneficial-order chunk from the old tt. */
> > > > 		r = ttm_pool_iter_reuse_old(&it);
> > > > 		if (r < 0)
> > > > @@ -1155,6 +1234,15 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > > > 				goto error_free_all;
> > > > 		}
> > > >
> > > > +		/*
> > > > +		 * Charge a newly (re)allocated chunk against the defrag move
> > > > +		 * budget. Harvested chunks borrow the old tt's pages for free
> > > > +		 * and never reach here.
> > > > +		 */
> > > > +		if (it.defrag_capped)
> > > > +			alloc->defrag_bytes_remaining -=
> > > > +				(s64)(1UL << it.order) << PAGE_SHIFT;
> > > > +
> > > > 		it.alloc_count++;
> > > > 	}
> > > >
> > > > @@ -1204,14 +1292,21 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > > > 		   struct ttm_operation_ctx *ctx)
> > > > {
> > > > 	struct ttm_pool_alloc_state alloc;
> > > > +	int ret;
> > > >
> > > > 	if (WARN_ON(ttm_tt_is_backed_up(tt)))
> > > > 		return -EINVAL;
> > > >
> > > > 	tt->page_flags &= ~TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
> > > > 	ttm_pool_alloc_state_init(tt, &alloc);
> > > > +	alloc.defrag_bytes_remaining = ctx->defrag_bytes_remaining;
> > > > +
> > > > +	ret = __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL);
> > > > +
> > > > +	/* Report the unused defrag budget back to the caller. */
> > > > +	ctx->defrag_bytes_remaining = alloc.defrag_bytes_remaining;
> > > >
> > > > -	return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL);
> > > > +	return ret;
> > > > }
> > > > EXPORT_SYMBOL(ttm_pool_alloc);
> > > >
> > > > diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> > > > index fcaba5fb8bf7..6124d2627b47 100644
> > > > --- a/include/drm/ttm/ttm_bo.h
> > > > +++ b/include/drm/ttm/ttm_bo.h
> > > > @@ -223,6 +223,20 @@ struct ttm_operation_ctx {
> > > > 	 * NULL for non-defrag operations.
> > > > 	 */
> > > > 	struct ttm_tt *defrag_old_tt;
> > > > +	/**
> > > > +	 * @defrag_bytes_remaining: Byte budget for newly allocated pages during
> > > > +	 * a defragmentation move. Only pages that are actually (re)allocated at
> > > > +	 * the beneficial order count against it; pages harvested (borrowed) from
> > > > +	 * @defrag_old_tt are free and do not. When the budget is exhausted the
> > > > +	 * pool allocator stops upgrading and completes the new tt by harvesting
> > > > +	 * the remainder of @defrag_old_tt, marking the tt sub-optimal so the
> > > > +	 * driver can resume on a later pass. The allocator decrements this as it
> > > > +	 * allocates, so on return it holds the unused budget (which the caller
> > > > +	 * can use to compute how many bytes were spent). A value of 0 means
> > > > +	 * unlimited (upgrade the whole object). Only consulted when
> > > > +	 * @defrag_old_tt is set.
> > > > +	 */
> > > > +	s64 defrag_bytes_remaining;
> > > 
> > > If user specifies -ve value, currently it means unlimited. So, may be update the
> > > documentation here to say "A value of <= 0 means unlimited"? Or, better only accept
> > > > =0 value from the user ctx here.
> > 
> > How about I reject user input defrag_bytes_remaining < 0?
> > 
> 
> Ok, sounds good.
> 
> Niranjana
> 
> > Matt
> > 
> > > 
> > > Niranjana
> > > 
> > > > 	/**
> > > > 	 * @resv: Reservation object to be used together with
> > > > 	 * @allow_res_evict.
> > > > --
> > > > 2.34.1
> > > >
