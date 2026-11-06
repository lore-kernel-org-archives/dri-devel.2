Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BCE606A31B
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 02:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QnhfiKBp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F9610E12F;
	Fri,  6 Nov 2026 02:54:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0822510E033;
 Fri,  6 Nov 2026 02:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793933692; x=1825469692;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=DsA5/cLC8sPFBHXQX4WZLuQig5bOC4xU8hmTjda/QxE=;
 b=QnhfiKBpStLDIJmOvVx8zWthmKh6h5zq9PgcupszKNmbMbP99QXVj82A
 RExAoFc+dD833er5JDkerTrtmgMsRioM03OwAKUlnnOA2mQyj1wnFTY0T
 Xd5fgM7OXl1+5huBte2XkeYR/JPM0E+yoO06zahWL0fL5nPDBymREYdsI
 5lJF0da9tC6AXBg8rqhKloAQFCEb3ixnYOCNWVhabhxg0gPdbBO2zo7iR
 I9Kyml2CKH98iyiWKFelY1QEfqUS08GCZySllDBkaBU9p5mvAdRRdAY8W
 BKvDFnAX4NW9CGy0lnQYv+8O1NA5PTuQD7wLKoByy5FwWg7BJqc16qT7J Q==;
X-CSE-ConnectionGUID: Sd3w5wjsSsGXMDqU/he4nQ==
X-CSE-MsgGUID: pbxsgALdThiFWltdccj+QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2621591"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2621591"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 18:54:51 -0800
X-CSE-ConnectionGUID: Aat6oiz8Q5ClReel5E7oAw==
X-CSE-MsgGUID: kXyVyEOwQsSrFkF0OLk/cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7506292"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 18:54:50 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 18:54:50 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 18:54:50 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.52)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 18:54:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUhYiQjqeIeAeEBEx3m1+qnVHD/Ql96w63LdoQ9+RpCOcNLql6TSa2sLO0GSPeFWKw+JJPy4WFfX4+elkgzkTapzfYWyDvYJag+FXrSGXArqJ7oIoGoksVJ3NdhywkBhCoq9NTEwTb+ofFtO5+UNRe/PnS37kocVeDZ9ZTs6CjKortGBe0HO6hYW36JpjOHagua3oSEnbLAqSWlBxFfatx6gYcuYyy0jjGu/YOMMKUi59ejnBeQJJjkoRA5/xqWC6Baz6kDxWVinya5x9KLK1sTJLa+KVQD/XFaWawbkSekBCAPnLy3ubnWcbIT3NiJOSzyRgSU+3RkL3dleOEZO7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUiY6SVgzrtUGd/zpJX6p7xdbKW5CyWCDN0RSOyD0qM=;
 b=HzJw2ImSBGkEaiHdrTV4H0fyz1V4xNy58eobQvs1Z96Mprfjs5ns4Qui7EMo9Mna3Agpg0gHFTcIkAKCuhWW1etExnzr3+HCw7VSojaMFPz3PvWQFpSWIJ3g2nBkgvGTYXiNx5+s0lyor733XXf4tHmas7oo5AKf7ZSJmsSYFfFDIeZFnK6yYQj5IidqcWD6ewpTBu18ECDxtRZvRdY1yBBtkSZ7oQKayXb51xjbBESZYQlWqV9ocGTKEwhcZWSqyDWDjTdMfJFggCVabLEKvjishmmkxIsIHaA8R0LJp+6KsNueHNLzFDb9eAusKFNYzQksNet4qRzayCvXDn8UXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by LV2PR11MB375110.namprd11.prod.outlook.com (2603:10b6:408:3a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 02:54:46 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0569.011; Fri, 6 Nov 2026
 02:54:46 +0000
Date: Thu, 5 Nov 2026 18:54:44 -0800
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 06/33] drm/ttm: Add fault injection for
 beneficial-order allocation failures
Message-ID: <au1BdOeD319qwsYa@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-7-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-7-matthew.brost@intel.com>
X-ClientProxiedBy: BY5PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::11) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|LV2PR11MB375110:EE_
X-MS-Office365-Filtering-Correlation-Id: b19999c5-f277-41b5-3fcc-08df3bb15115
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|23010399003|376014|22082099003|18002099003|6133799003|10067099003|4143699003|56012099006|11063799006|261026140227099003|261009220027099003|261028144727099003|261021123027099003|261022075727099003|261009221727099003|261102123227099003|261021121427099003|261009223327099003|261022105027099003|261009221227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 2zpJ8c/nRoyAPbNNhX9huJi9J/xCAnCPXzcIHMkOZtZ2LsJ2Lin1+xGq1R7q4jJBTlSmODPwOYc/XLvlR+TA3cj34kZgE7Cs6fswDQhuk5UUejgk/ZxO9pAcEnLyLKvhpoRvPdW+sleIdoDIsX2e88HEYcng0aoz+Q9ja9v544aaHc9bQaWuKII8bUw7K3Bls3uJX3gpJK2aLpJKMxHvHoS2dwiZPr1hRdEhLC+FPdrBDAHZGc1xQu6ahasP6jAP2NVRmOHSY3WXpgDXJxUJD/WhRT0J5qn/DiuHMCsIDd/V/DP0+jhlrKpDvpXqebp7BX7s3yOyDrAqoT1v9F0MRZ6rUIGmV+PE7KiBNMQ9vK50X9bv64/5zPe9NIL2K3SnCJtN75yXJJH8y5tcaAlcfSZi3wIcOcpBTT40+junec+ll0iyr8SO7yWVlNnNDxf53ZvTbbpUCuXsmefHJYwWQuIJQkV2foE5Rn9vN7btL8nPqIdyNs+lNEU9otMTu7qki3fi4xwndfwzSSWIqeszf0D6qCS65Ij93yMuZIpkSSHB69dpkzjW6Bk++U8PsWZem08EdhFeHG+Ppn5d9EQO7uJFma41+uRRNrHnhbxUHL7IZox5F7ckIgfNljD/OHwhOOk8u9rB+DIJdrypYcNAFjFdBbLTi0nrQii+iD2wYHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(261026140227099003)(261009220027099003)(261028144727099003)(261021123027099003)(261022075727099003)(261009221727099003)(261102123227099003)(261021121427099003)(261009223327099003)(261022105027099003)(261009221227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?tFm9t3URLIt5wqVIC80nfqB9temQ8TzvMy4QJEkidC1bhyvRly4TteBvZ5?=
 =?iso-8859-1?Q?7JbPYMffj4TFYs0L8fR0KaQxGXfqBLVOhuOflHQiCd8n17SHE5ykHHQKNl?=
 =?iso-8859-1?Q?aGQCup9w7U16NxGotKLK2Pz0qXcfVindaozZ+TYAXYsKfCs6sE92LQ7KH+?=
 =?iso-8859-1?Q?7uUm1U95R9yxBpojqwKck4Q0IIpmjiuCgrOdCaQ7BmEmB7X5GDbb8hf0OL?=
 =?iso-8859-1?Q?DDcirRxY0xyNoNZcfXr1YSqZSO9BhNQ7qKDTCxVEJA8ztbwVKaHndl+VXC?=
 =?iso-8859-1?Q?AsJcsn6gGySoBOxKqmIzEve/qtPNi5BMEEkd+zwWuQigMKU6TvINhQyaA8?=
 =?iso-8859-1?Q?awtLp3rKzmBa5JlOB/6ShBvZiolgvMcs8krcTAhnJISKhgF6VsFuWrTm2I?=
 =?iso-8859-1?Q?BWkDtECyPO6v2noL9GxCXQb/fv/UodVLOumefaSU4AojfF6ZK7ugSlzc7Q?=
 =?iso-8859-1?Q?NEjHWH7oDSijIcj1XOU5+mNVOjAmMr/ExtQKgeZPckbIgQnapfHhuH6+F2?=
 =?iso-8859-1?Q?jbsH4fafhlJxAFQgbyxiMXbFP/mTH/bqPeEi6yxqwTuk6zAdsUUjnOrgEQ?=
 =?iso-8859-1?Q?uUEdfIlBWG8LoyaV0qKARbIHV9Dq/6a+kh8KWD5kUDiwubsgYtmp9ycpcf?=
 =?iso-8859-1?Q?hTylOsppCfI5cAkQx7gT6wD/cH0yHsdWseGJyQpvKNM5pILgXTxOD4RbcF?=
 =?iso-8859-1?Q?QwL3F5IhjbXZSu9zzCp7HVvrYY2YqY3NhngHH7qxStKy8PI31Twex2DcCT?=
 =?iso-8859-1?Q?pP4/5nqNqUfme2XbUn/RA8iQyH3FHH9MAVCMxP22y1AC9M5dzHYKDHq6an?=
 =?iso-8859-1?Q?qZRz64763i6jmotWv31PnZXr4gP3+ZOlZjkP0VzUFYKhYS4EKdtkE97+8H?=
 =?iso-8859-1?Q?ZzgefW1RCnorfMYyP/RGf8Ax7y4nGh1d3l5/XRh8sNIWJFObT8EyGrmRF3?=
 =?iso-8859-1?Q?AmJlme+9nLvlGiOFlbh9+NsvfPq7ea/6ZXSJ4bw3B68oI/B7H1I6Emo7Pi?=
 =?iso-8859-1?Q?met+Orl7mkOcfiAYQ5XvNvOTBcSv+FjpNeHZMog6HR/IRyb8Ko/RiolvOb?=
 =?iso-8859-1?Q?tVnytR3grQR/NwcVnz5sW/xggL4Wv9en/dvFAJSMjtGOGKr20j1rBuERA9?=
 =?iso-8859-1?Q?nbwUgc54Mr/yU7gclyrhja9kcoNKWuxwDHaNAu819L3jgJiGlV4L0AxSuQ?=
 =?iso-8859-1?Q?z9jfL8Oq811wRc4t/ToXGxTdCfXlKIwq3SDdIL9RMJHuhtzYG1QbKGHxfs?=
 =?iso-8859-1?Q?JxJrEDjMZ97mWWRb7PwZ3xfRvWJxuIhAJf4ocRJsdqrIpWuZEz2x6ZSseA?=
 =?iso-8859-1?Q?C2L22rwh6+bFXtIPKmAM/xzTndesgqNMn0f1cGqLoYJ0uQQT5ceR03DRXM?=
 =?iso-8859-1?Q?mj91DWK4M+rEAyrMt0+Xny+GFri9yRYu/o5uzLdh5oP1d4WRSw53CbwIIt?=
 =?iso-8859-1?Q?TY3BaSUq/qUEx3XmIgkgd1E1ihYZEsvnwqJBWq4Hv4caR1g8u446MRnSDN?=
 =?iso-8859-1?Q?LJnmwbUgbdPUuIuNHNudlnXXWD9P2bmQ2JQ71r9HL2yVcGe9Ekm4oGwS1q?=
 =?iso-8859-1?Q?vaa0ua2KdpgS9klNxmyG5PSubEpxIYc6dbwr1h0vC31ryIPZsyMMJbDCMN?=
 =?iso-8859-1?Q?6BKjX7j10UWrNaGkztetzfoHp5VTpD8XMxLTOknngmfRH177imksrTd4dw?=
 =?iso-8859-1?Q?kUT3Q9b4M0DxpSYALs3VCPp6PCQ+1D001Tud3bq6pwQMBMJxRM9GXXGrIG?=
 =?iso-8859-1?Q?aZYtcKi/O7rM00hzG8UjqC52VL/A7gJDp5A15/2vMElB6iMTa7yw2iM4cQ?=
 =?iso-8859-1?Q?n2goN+W44k7lcFW7p7Kl15NBcfiZInmjkiaUb8pCA2N6ySAnnTZz?=
X-Exchange-RoutingPolicyChecked: Fm9vPEFeVBIVYkAfND7wZkR3g4p6V3SlVd5KYmkBH9twQoxSBAuL4pvQXIBw3mUZul4KB0PGr98DhWWYnE5KuMp1+cMihuGNY/RsRPVjRQSsPN55cM4K1WFplE6q2OijWHq22Rlo7J/RoaGMu8UNYC5KWSaXRQYODR5lWj2MB0y5tR6IWov0yFXUqz1wRWlvtG06copYgJ2aNi4ujobcpEzSMaCPf9raNwdUNB1Da/8lecb8wsMJQnEE+ssD0Acvxwn4m/mheCyrd/MZ9ohRdy50YfT138sHitiCvL/qorAW2pz+FurG1SII1jd+W5AoJ1wvl76KnNhnUh5wTanLbw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b19999c5-f277-41b5-3fcc-08df3bb15115
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 02:54:46.6933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NP1jXidDc81dp0OFYXX+DyrdMIWgP71EDjd/t/pzjY18kksWMnJB7So0WyKHi0QvXInjZVww4c6mXIXaAJc7pmK02KNSXYlaoEbNtc91Nnq9mITWfmlwQhHcCzlS4x/W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB375110
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

On Fri, Jul 10, 2026 at 07:55:52PM -0700, Matthew Brost wrote:
>Add a beneficial_order_fault_inject debugfs fault attribute, mirroring
>backup_fault_inject, that forces allocation at (or above) the device's
>beneficial order to fail in __ttm_pool_alloc(). When triggered, both the
>pool take and the system page allocation are skipped for that order, so
>the allocation falls into the existing lower-the-order path that sets
>the TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED tt page flag (and bails out with
>-ENOMEM for defrag moves).
>
>This lets the TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED tracking and the
>driver-side defrag path be exercised deterministically, without having to
>drive the system into real memory fragmentation to provoke a sub-optimal
>backing.
>
>The knob is registered at
>/sys/kernel/debug/ttm/beneficial_order_fault_inject and compiles out
>when CONFIG_FAULT_INJECTION is disabled.
>
>Cc: Carlos Santa <carlos.santa@intel.com>
>Cc: Ryan Neph <ryanneph@google.com>
>Cc: Christian Koenig <christian.koenig@amd.com>
>Cc: Huang Rui <ray.huang@amd.com>
>Cc: Matthew Auld <matthew.auld@intel.com>
>Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>Cc: Maxime Ripard <mripard@kernel.org>
>Cc: Thomas Zimmermann <tzimmermann@suse.de>
>Cc: David Airlie <airlied@gmail.com>
>Cc: Simona Vetter <simona@ffwll.ch>
>Cc: dri-devel@lists.freedesktop.org
>Cc: linux-kernel@vger.kernel.org
>Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>Assisted-by: GitHub_Copilot:claude-opus-4.8
>Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>---
> drivers/gpu/drm/ttm/ttm_pool.c | 35 ++++++++++++++++++++++++++++------
> 1 file changed, 29 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
>index d045105afc24..2598d2f33767 100644
>--- a/drivers/gpu/drm/ttm/ttm_pool.c
>+++ b/drivers/gpu/drm/ttm/ttm_pool.c
>@@ -53,6 +53,7 @@
> #ifdef CONFIG_FAULT_INJECTION
> #include <linux/fault-inject.h>
> static DECLARE_FAULT_ATTR(backup_fault_inject);
>+static DECLARE_FAULT_ATTR(beneficial_order_fault_inject);
> #else
> #define should_fail(...) false
> #endif
>@@ -812,21 +813,34 @@ struct ttm_pool_alloc_iter {
> 	unsigned int order;
> 	enum ttm_caching page_caching;
> 	bool allow_pools;
>+	bool fail_beneficial;
> 	struct page *p;
> };
>
> /*
>  * Acquire a single page for the current order, leaving it in @it->p (NULL on
>- * failure). Tries a same-order pool page, then a fresh system allocation.
>+ * failure). Tries a same-order pool page, then a fresh system allocation. Fault
>+ * injection can force the beneficial-order paths to "fail".
>  */
> static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
> {
> 	struct ttm_pool_type *pt;
>
>-	/* First, try to allocate a page from a pool if one exists. */
> 	it->p = NULL;
>+
>+	/*
>+	 * Fault injection: pretend allocation at (or above) the device's
>+	 * beneficial order failed, forcing a sub-optimal backing. Exercises the
>+	 * beneficial_order_failed tracking and the driver defrag path without
>+	 * driving the system into real fragmentation.
>+	 */
>+	it->fail_beneficial = IS_ENABLED(CONFIG_FAULT_INJECTION) &&
>+		it->beneficial_order && it->order >= it->beneficial_order &&
>+		should_fail(&beneficial_order_fault_inject, 1);

NIT..Looks like IS_ENABLED(CONFIG_FAULT_INJECTION) check here is redundant,
but other fault inject case is also using it, so, should be fine I guess.

This patch LGTM.

Niranjana

>+
>+	/* First, try to allocate a page from a pool if one exists. */
> 	pt = ttm_pool_select_type(it->pool, it->page_caching, it->order);
>-	if (!it->p && pt && it->allow_pools)
>+	if (!it->p && pt && it->allow_pools && !it->fail_beneficial)
> 		it->p = ttm_pool_type_take(pt, ttm_pool_nid(it->pool));
>
> 	/*
>@@ -834,7 +848,7 @@ static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
> 	 * this also disallows additional pool allocations using write-back
> 	 * cached pools of the same order.
> 	 */
>-	if (!it->p) {
>+	if (!it->p && !it->fail_beneficial) {
> 		it->page_caching = ttm_cached;
> 		it->allow_pools = false;
> 		it->p = ttm_pool_alloc_page(it->pool, it->gfp_flags, it->order,
>@@ -851,6 +865,9 @@ static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
>  */
> static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
> {
>+	bool at_beneficial = it->beneficial_order &&
>+			     it->order == it->beneficial_order;
>+
> 	if (!it->order)
> 		return -ENOMEM;
>
>@@ -860,13 +877,16 @@ static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
> 	 * pages. Record it so the driver can later try to defragment the object
> 	 * back to beneficial order.
> 	 */
>-	if (it->beneficial_order && it->order == it->beneficial_order) {
>+	if (it->fail_beneficial || at_beneficial) {
> 		it->tt->page_flags |= TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
> 		if (it->ctx->defrag)
> 			return -ENOMEM;
> 	}
>
>-	it->order--;
>+	if (it->fail_beneficial)
>+		it->order = it->beneficial_order - 1;
>+	else
>+		it->order--;
> 	it->page_caching = it->tt->caching;
> 	it->allow_pools = true;
>
>@@ -1536,6 +1556,9 @@ int ttm_pool_mgr_init(unsigned long num_pages)
> #ifdef CONFIG_FAULT_INJECTION
> 	fault_create_debugfs_attr("backup_fault_inject", ttm_debugfs_root,
> 				  &backup_fault_inject);
>+	fault_create_debugfs_attr("beneficial_order_fault_inject",
>+				  ttm_debugfs_root,
>+				  &beneficial_order_fault_inject);
> #endif
> #endif
>
>-- 
>2.34.1
>
