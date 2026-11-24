Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A812606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d/ggmbgC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=dprlYagr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C973710EF97;
	Tue, 24 Nov 2026 19:08:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7961D10EF97;
 Tue, 24 Nov 2026 19:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795547289; x=1827083289;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=TZqF+5qqalvMoMPoAqLWd2O6o93V4HPQpY5743/b+LQ=;
 b=d/ggmbgCvy4AlqePkCsXvq1RTJ7w42odHhgS8Pu+0VM2WnFGEdel2pye
 28ntkZGtQXeu8TTyQybHu3h79CMKVz/GUsKJvYvJm/Dc0U0eO2TorCkK7
 T4Cdcv5q/Esi3fNgqGEUn86ZXztbcgvxqG5CwK4/nUlYOOu1eDbIjQmSf
 GQI69QTg3cl8KYZPZHFDZ+ZoKIcnE8H4hDjI0ux7Kf5svWB9I5H50pLGd
 w2NMR5DT6BZ7lSTE9QQDDB/IkrbWXlBnfCgqRvqeeObo7YXTLWsBMyKbC
 0f6zznEH22hUvvxSTWxwXDRvqSLx5f6Nn8Ik4Qh/Zc0N7ccHLjuWJT83N Q==;
X-CSE-ConnectionGUID: mbLt9RLmQ6mZ5iN8wydVFg==
X-CSE-MsgGUID: nPGUEFfgSre3CzgWG+2b8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4421987"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4421987"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 10:54:21 -0800
X-CSE-ConnectionGUID: C3MkTBKXSZKrdJ5OAx9bzg==
X-CSE-MsgGUID: goj3NezYReW/lCy/akaiCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="12224549"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 10:54:21 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 10:54:20 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 10:54:20 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.29) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 10:54:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwOYWceMY3ER98Xd1g6bNBjyrC4ntPGBCt9ptkvGhL5fUMuifovwOK0C36sD/u2q45z9117lOmQfbL2vVEBU3ToCtKz4crQvy6GOUEEJuLVgzbdtp1/fmfUfVHJ0Bw+UZtivyifkbk1v9aOnGIy6pyEkvUOWPtsWVh6mAoisjHr+olMOgn0p+pUwtUtuHsVs08Y+QMM4ypwARVgxGvZbgCeNSAoJ02e7uaWJBBZU6k67imc895Ldxsr89DguTQFqAmQAppkkF9ps8wjTjoc4iI2a67dA1UiG4RQE3ghDEukXO3RN+c/tZ/PWP+LYLKM335MPdbZ91bHU9/Slsd3bng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtvM4wywamAnkq2Ho6LfrxHGqgmfviNghaD7olDge6E=;
 b=D+OgmpQE/AwDmhKOcL2uTlQeWvCZ1CRpoAgZCIVsG+cCIdDS3G0iiwmfG7N2qbiFsawhBCEJw0UeTuFagcvE/1yNqzyrTBjSMrJj5BbzvC7ZmpRr7jkGSMG7eZBBwCi/I6S8M9HknoZwwB7fCn2KncejfQzjKPyNzM8cJmRRdZnotDecGNVzcp6XSgg3KuoXMoTqRKV5hv5UNW3uXG7whVhykufN6PvYpOA7LpmKeJxoit0Fq5CLZ0zUcuuQW0nzOay55xrZKLFPJpL3//HOGasbrHKSJ5xrPqeriL5k8EsdLJrnDnxVYKMdxlA50ffa1S45Jhg0T2JutoX0FYcvww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtvM4wywamAnkq2Ho6LfrxHGqgmfviNghaD7olDge6E=;
 b=dprlYagrfadKGATtj+yGBmX7v/UzGcOjujsPMYwbQN1ctC2D0U0YmTo3cEjvH4EzF1bhSGwqGX7eoA5Dnp8U1Q/kcWqNO+MCP7yi+AXfcX6WFpJy1M+9JeXtUTNDkX6VIdYRyyd7G0yIXk2vQk0Bw8AFVPk6X3bsiUmOSgOg+cc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by IA4PR11MB480151.namprd11.prod.outlook.com (2603:10b6:207:14d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 18:54:12 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 18:54:12 +0000
Date: Tue, 24 Nov 2026 10:54:09 -0800
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
Subject: Re: [PATCH v3 20/33] drm/xe: Add a page defragmentation worker
Message-ID: <awXdUTLvmVL1p6DE@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-21-matthew.brost@intel.com>
 <au621A_K50hsPxnv@nvishwa1-desk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <au621A_K50hsPxnv@nvishwa1-desk>
X-ClientProxiedBy: SJ2PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:a03:505::21) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|IA4PR11MB480151:EE_
X-MS-Office365-Filtering-Correlation-Id: deb202a2-0631-4abc-f10a-08df4a5c53f2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|18002099003|6133799003|22082099003|261009221227099003|261009223027099003|261021121427099003|261021123027099003|261022105027099003|261026140227099003|261026121527099003|261102123227099003|261022075727099003|261028144727099003|56012099006|10067099003|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: SHCw8tmm29hTh7NHpNStwizw3HLtQwQt6zE9GmQyTUuEupKOFoL6WEPpUL9hwaDj+uMATyUEb/OAkLjnFUnQv4WiJ0IVk9akQN7JiC3WIAQbwQWDUNksX9noMT8WT+hlgLh1pOdOo7bBh+2uQC6NcKVh8+PiPDz0vwMg3szedFfxWN/FWf2Wrt8AhyNwJam54oI9dJNiI1shR90QuNUGjrHLRIWicS2r2R/GcVI49QcKZA96PSz7lxa/t+ISFJjoeCHTK5M4px0l9dX/KMA2ObQsqB0VcaS+HmmJnHosmjmDTCfoVKgGk/eyErH6eaU3dQZd2ct5A6Rt2JZ044r0VOkD8FxI9WkHpv/p0FDJxfRivDGLWMibCwZNpj/jRyLc++5tMo6rEO9IWUcUjq2pcqG2qjL1x48ECRKp/E5nGB87jJtQI4v0jRGVrL+Ju+MlCJQczMOJmJvCddLNkd/vj3BCQafpvqX9kb5lByBQJidj+EsyI9LOST+ILtvsEZz0N+gPqUanRlmEwYJOPchkGI2DvgnnaPtZTMRBoRfKBVgNnKkyW+bUuNcSw9GrL6jBQJPVdWSyGdcXyQmhwAYq9d6PbBiWEQemd8Am3kwYB9TTjMIICh/Hfr/flzrZhUG5TzqpCe+IQLqQTzLeH4UE7r+qKR5bKwloL296TrBNGjI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(18002099003)(6133799003)(22082099003)(261009221227099003)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(261026140227099003)(261026121527099003)(261102123227099003)(261022075727099003)(261028144727099003)(56012099006)(10067099003)(4143699003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CtaCef7yD+7WVU1OaQcQVajKvmBHPz4xOXAq7U5V8xTULBYJvnfiaSdmxW?=
 =?iso-8859-1?Q?3jdphuD4uM1yuaYCbrTveJ/YdO2yD1srST7AOvLiLCehMYXlg9YuWaPDL8?=
 =?iso-8859-1?Q?Wv3vXV1lr67Jv2MOdVkRoU3GPflIn/dMRaSeQhuWFXRm4ufFHUHHM+b1gK?=
 =?iso-8859-1?Q?YJXXBEWnqGwelm9kAzEbNOqgyPEdb7vTRLTGT/7/kFRRQtuDSMnVOHoe47?=
 =?iso-8859-1?Q?K1wxTHRuMtNz0wK281rjTHHP1hcFWepdBmh8qMt6AlpgC3HBiszxPbswvn?=
 =?iso-8859-1?Q?9EhQIjurruAFTAfFLRCj2CeCPdoF7TFTazXDdYuIHB8oVv3cQInpAEJ+HW?=
 =?iso-8859-1?Q?wS3b8t9qK+bSthOjJZ8JFcaVxKDza5AKy8LcMnSkE8Or9ut4iWdvBZIHRX?=
 =?iso-8859-1?Q?j6p5I27I0Tqw6xbvLZ+g4WWsxZ2DQfDvIGmxQEgSgWJvd7nP8gRkeIrXKW?=
 =?iso-8859-1?Q?0lDn0r4V+r1ORdeLkUd6KlYc/owI93jiup7CyNhGxNisJpU2+kGR1hvCI5?=
 =?iso-8859-1?Q?Z9eRFaHGTcmMH+EUXUW9GinOOPGK+4M5mqgyh8dwyz/VmX/YMp5RujLZ9U?=
 =?iso-8859-1?Q?+m+guwLeAxp5A2FhJ1gT43zOw1q/HkYWIVVrg51IfH3ciW7gNymG5dIvak?=
 =?iso-8859-1?Q?H3eM/O4PvpQNlLoXRX+chwVF1DBPBExozsDV24SmHsrxO9l5AA/wrxAkhW?=
 =?iso-8859-1?Q?BFpyXbrRzIU9GiCpDNqVXqpGq5AHk3VAHP3FE0UKFzB2HZ/xSvf4Qre+nn?=
 =?iso-8859-1?Q?DqwRxz1Pt4cGjDbbBL8Bgy6DJia18HAH0L5/DmBahPPM0RpG8CC3DO5vfe?=
 =?iso-8859-1?Q?1h8YJ0KCjAvatNhA9ROlgWFGKtoNmZEmIIj5NlESFT6DTPzmEV+fNECzCO?=
 =?iso-8859-1?Q?ROSmIdY/7fJJOPmofdmQb8H0a9zy4tqvQkQbjaHXckEZEErY83p19f2wwL?=
 =?iso-8859-1?Q?Nd8OmBDi2lFVIXQxy2aCZV0re8lBYhmwz+7BA5MkQ260xDNHOoYFFRFXPW?=
 =?iso-8859-1?Q?O9Iuu2kFi7Zz/xsk1kQVhbmn8ftlqcRmhGNoWKszuz97NN2auIQ1arXxOl?=
 =?iso-8859-1?Q?IpT4OIZ3JQsuimfbtRWfONMpSc3PH4zMFuqFmRMfkzcndB1UaHJr0mKfLl?=
 =?iso-8859-1?Q?gYN9Jo4i895dZjmQkWaupW6h+GjkojW3YeaAnHIg8zTZvjSWuF4d0wdQ8I?=
 =?iso-8859-1?Q?ujeYnHkAXZVUKqhPeMgLG9WYrCYgnFUcfFwb5tWNf6u+WqKZrQHVqQOOAc?=
 =?iso-8859-1?Q?gVLuSAYPozPxF82dUQD6QeD3+UeNSmcgASZoXUditnjXTj251+JEF1gDwo?=
 =?iso-8859-1?Q?0I8uvQbvs1dqIAkp1eENU/CRPim3fCq/1QX0ge7WQAwiD85KJK7p7OycR8?=
 =?iso-8859-1?Q?Evb1Vp7daMBWUeh7plPh4mNhSeqEGFKAsyfkAAK/HTJBdlihIhFNmOpDLl?=
 =?iso-8859-1?Q?d7w1HvZWFunhzvnZWM2gMofhJbBHu5Od4t5uamRDEGoCk3vhCvkF+VXKmZ?=
 =?iso-8859-1?Q?UwvNjs8ariqBxT9spQ+ziRIcNXH3vwNs9zZ+5Uawz5TCFa/wO9NFTM1XP9?=
 =?iso-8859-1?Q?R/gWqNZktZ6pnr78QcF4zd5ZDccN7QWXtaXH/KF1ev22JIIrV2YaTzFJ33?=
 =?iso-8859-1?Q?g6kffZJVzGgeInmS3APfyL3+REllMjKayV4CYpxqt8eN8JHUzbGY/YF5TC?=
 =?iso-8859-1?Q?MMlnEp0T1ZPt1/+Gxt2hdLf2EwouqKfyow8EzvudPcJl0HSCzs398iHKN4?=
 =?iso-8859-1?Q?k04VneXVoQnoORaneLYtAMX70PW4Gf2mXMUa4oVLm66IU5lteQLpcMIUz+?=
 =?iso-8859-1?Q?YQS8GcOC2ymfQTs8a1oLCmtOgrmbFvo=3D?=
X-Exchange-RoutingPolicyChecked: N6/2ev1GXMWRVFZt9oG7VnEeJy68RIgnXrc95485yEEzK2j56ZuBUFlCKvOgyuRcA1fCSVurixIxSQprj7Jg1QmqG8NA0Opwouy5gI6fj+THgZZ1iz7lrbxyK+4Mnaz/96xflTKrqDoLugRExyc3f+TOediQWKwINPDuh4UIMX0Ue6CTVspasXwW1jukXs3NJaM1D+W0bj7xvj2ExWnkvo/StzniMnRqVVWESoKbxKGRDebPDVXSZp4klWsMbdssMUyhenoOxRxzU5CWbKZPwNGVlYbADex8m5oSIQtZybHqSRieWbXGqR3QOS2bK19T528+eMA+xH/oJ7Ztsy3d1g==
X-MS-Exchange-CrossTenant-Network-Message-Id: deb202a2-0631-4abc-f10a-08df4a5c53f2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 18:54:11.9750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKezK+3P1l9Wf1KQB8urTI2exNSdRQrqPorbCsPu2fImv5Z4Dmf/Bs/5Tx3apG0+wlZe5FDS9V/yqYUHL9ZuzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB480151
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

On Fri, Nov 06, 2026 at 09:27:48PM -0800, Niranjana Vishwanathapura wrote:
> On Fri, Jul 10, 2026 at 07:56:06PM -0700, Matthew Brost wrote:
> > BOs whose backing TT pages were allocated below the device's beneficial
> > order (tracked via the TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED tt page flag)
> > are added to a per-device defrag list. Add a delayed worker that
> > periodically walks this list and attempts to re-back each BO with
> > beneficial-order pages, improving TLB efficiency for long-lived objects
> > that were initially allocated under memory pressure.
> > 
> > The worker is kicked when the list first transitions to non-empty and
> > reschedules itself while work remains. On a failed pass it backs off
> > exponentially (XE_BO_DEFRAG_INTERVAL_MS up to
> > XE_BO_DEFRAG_INTERVAL_MAX_MS) and retries the whole list later; the
> > interval is reset to the default on the next fresh enqueue. The worker
> > stops scheduling once the list drains.
> > 
> > A defrag move synchronously reallocates and re-copies a BO's backing
> > store, which is not free. To avoid stalling concurrent active work when
> > many BOs (or one very large BO) become eligible at once (e.g. after a
> > burst of memory pressure, which would otherwise manifest as a large FPS
> > drop while the worker churns through the whole list), cap the number of
> > newly (re)allocated bytes processed per run to XE_BO_DEFRAG_SIZE_LIMIT
> > and reschedule. Only the pages a move actually reallocates are charged -
> > pages harvested (borrowed) from the old backing are free and do not count
> > - so the budget tracks real defrag work and an object larger than the
> > budget is upgraded in budget-sized slices across runs. This spreads the
> > defrag effort over time, keeping it in the background and yielding to
> > userspace progress.
> > 
> > Defragmenting a BO forces a TTM move (ctx.defrag) that reallocates the
> > backing at the beneficial order and relocates the contents on the GPU
> > (see xe_bo_move()). The per-BO move is bounded by the run's remaining
> > byte budget via ctx.defrag_bytes_remaining; the pool allocator reports
> > how much it spent so the worker can charge it accurately. When
> > beneficial-order pages cannot be obtained the new allocation is
> > discharged during populate and the BO keeps its original backing, staying
> > on the list for a later retry.
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
> > - Compute the needs-more state under the BO lock via an out-param
> >   instead of re-reading bo->ttm.ttm after unlock (Sashiko)
> > ---
> > drivers/gpu/drm/xe/xe_bo.c           | 296 ++++++++++++++++++++++++++-
> > drivers/gpu/drm/xe/xe_bo.h           |   1 +
> > drivers/gpu/drm/xe/xe_device.c       |   9 +
> > drivers/gpu/drm/xe/xe_device_types.h |  11 +
> > 4 files changed, 313 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> > index 7f6ee9b8d12e..907cfa57481f 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -31,6 +31,7 @@
> > #include "xe_pat.h"
> > #include "xe_pm.h"
> > #include "xe_preempt_fence.h"
> > +#include "xe_printk.h"
> > #include "xe_pxp.h"
> > #include "xe_res_cursor.h"
> > #include "xe_shrinker.h"
> > @@ -49,6 +50,35 @@
> >  */
> > #define XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD	2
> > 
> > +/*
> > + * Maximum number of bytes of newly (re)allocated backing the defrag worker will
> > + * produce in a single run before yielding and rescheduling itself.
> > + *
> > + * A defrag move synchronously reallocates and re-copies a BO's backing store,
> > + * which is not free. If a large number of BOs (or one very large BO) become
> > + * eligible at once (e.g. after a burst of memory pressure), processing them all
> > + * in one worker run would hold things up for a long, unbounded stretch and can
> > + * visibly starve concurrent active work (e.g. a large FPS drop). Instead, cap
> > + * the bytes actually upgraded per run and requeue, spreading the defrag effort
> > + * out over time so it stays in the background and yields to userspace progress.
> > + * Only pages a move truly reallocates are charged; pages harvested from the old
> > + * backing are free, so an object larger than the budget is upgraded in
> > + * budget-sized slices across runs.
> > + */
> > +#define XE_BO_DEFRAG_SIZE_LIMIT			SZ_32M
> > +
> > +/* Default delay before (re)running the defrag worker, in milliseconds. */
> > +#define XE_BO_DEFRAG_INTERVAL_MS		25
> > +
> > +/*
> > + * Upper bound for the (exponentially backed off) defrag worker interval, in
> > + * milliseconds, so repeated failures don't push the retry arbitrarily far out.
> > + */
> > +#define XE_BO_DEFRAG_INTERVAL_MAX_MS		15000	/* 15 seconds */
> > +
> > +static void xe_bo_defrag_worker(struct work_struct *w);
> > +static void xe_place_from_ttm_type(u32 mem_type, struct ttm_place *place);
> > +
> > const char *const xe_mem_type_to_name[TTM_NUM_MEM_TYPES]  = {
> > 	[XE_PL_SYSTEM] = "system",
> > 	[XE_PL_TT] = "gtt",
> > @@ -624,8 +654,10 @@ static int xe_ttm_tt_populate(struct ttm_device *ttm_dev, struct ttm_tt *tt,
> > 	} else {
> > 		struct xe_device *xe = ttm_to_xe_device(ttm_dev);
> > 
> > -		if (atomic_read(&xe->mem.defrag.count) >=
> > -		    XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD)
> > +		if (ctx->defrag)
> > +			ctx->beneficial_reclaim_backoff = false;
> > +		else if (atomic_read(&xe->mem.defrag.count) >=
> > +			 XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD)
> > 			ctx->beneficial_reclaim_backoff = true;
> > 
> > 		ttm_tt_clear_backed_up(tt);
> > @@ -1047,18 +1079,54 @@ static int xe_ttm_bo_purge(struct ttm_buffer_object *ttm_bo, struct ttm_operatio
> > 	return 0;
> > }
> > 
> > +static void xe_bo_defrag_fini(void *arg)
> > +{
> > +	struct xe_device *xe = arg;
> > +
> > +	disable_delayed_work_sync(&xe->mem.defrag.worker);
> > +}
> > +
> > /**
> >  * xe_bo_defrag_init_early() - Initialize the device defrag BO tracking
> >  * @xe: The xe device
> >  *
> > - * Initialize the list, lock and count used to track BOs whose backing TT
> > - * pages were allocated at a sub-optimal order.
> > + * Initialize the list, lock, count and delayed worker used to track and
> > + * defragment BOs whose backing TT pages were allocated at a sub-optimal order.
> > + *
> > + * The devm action that cancels the worker on teardown is registered separately
> > + * by xe_bo_defrag_init(), which must run after the migrate contexts the
> > + * worker depends on have been initialized.
> >  */
> > void xe_bo_defrag_init_early(struct xe_device *xe)
> > {
> > 	spin_lock_init(&xe->mem.defrag.lock);
> > 	INIT_LIST_HEAD(&xe->mem.defrag.list);
> > 	atomic_set(&xe->mem.defrag.count, 0);
> > +	xe->mem.defrag.interval_ms = XE_BO_DEFRAG_INTERVAL_MS;
> > +	INIT_DELAYED_WORK(&xe->mem.defrag.worker, xe_bo_defrag_worker);
> > +}
> > +
> > +/**
> > + * xe_bo_defrag_init() - Register defrag worker teardown
> > + * @xe: The xe device
> > + *
> > + * Register the devm action that disables and drains the defrag worker on
> > + * device teardown. This must be called after xe_migrate_init() so that, with
> > + * devm's reverse-order cleanup, the worker is stopped before the migrate
> > + * contexts it relies on (via xe_bo_defrag_one() -> ttm_bo_validate() ->
> > + * xe_bo_move() -> xe_migrate_copy_defrag()) are torn down.
> > + *
> > + * Return: 0 on success, negative error code on failure.
> > + */
> > +int xe_bo_defrag_init(struct xe_device *xe)
> > +{
> > +	return devm_add_action_or_reset(xe->drm.dev, xe_bo_defrag_fini, xe);
> > +}
> > +
> > +static void xe_bo_defrag_schedule(struct xe_device *xe)
> > +{
> > +	schedule_delayed_work(&xe->mem.defrag.worker,
> > +			      msecs_to_jiffies(xe->mem.defrag.interval_ms));
> > }
> > 
> > static bool xe_bo_needs_defrag(struct xe_bo *bo)
> > @@ -1079,16 +1147,24 @@ static bool xe_bo_needs_defrag(struct xe_bo *bo)
> > static void xe_bo_defrag_add(struct xe_bo *bo)
> > {
> > 	struct xe_device *xe = xe_bo_device(bo);
> > +	bool kick = false;
> > 
> > 	xe_bo_assert_held(bo);
> > 	xe_assert(xe, xe_bo_needs_defrag(bo));
> > 
> > 	scoped_guard(spinlock, &xe->mem.defrag.lock) {
> > 		if (list_empty(&bo->defrag_link)) {
> > +			/* Kick the worker when the list transitions to non-empty. */
> > +			kick = list_empty(&xe->mem.defrag.list);
> > +			if (kick)
> > +				xe->mem.defrag.interval_ms = XE_BO_DEFRAG_INTERVAL_MS;
> > 			list_add_tail(&bo->defrag_link, &xe->mem.defrag.list);
> > 			atomic_inc(&xe->mem.defrag.count);
> > 		}
> > 	}
> > +
> > +	if (kick)
> > +		xe_bo_defrag_schedule(xe);
> > }
> > 
> > static void __xe_bo_defrag_remove(struct xe_bo *bo)
> > @@ -1131,6 +1207,218 @@ static void xe_bo_defrag_update(struct xe_bo *bo)
> > 		xe_bo_defrag_remove(bo);
> > }
> > 
> > +/*
> > + * Attempt to defragment a single BO by forcing a move that reallocates its
> > + * backing at the device's beneficial order. @budget bounds how many bytes of
> > + * new pages the move may (re)allocate; the remainder of the object is completed
> > + * by harvesting the old backing, and the BO stays flagged for a later pass. On
> > + * return *@consumed holds the bytes actually (re)allocated (0 on failure or
> > + * when nothing needed reallocating). *@needs_more is set to true when the move
> > + * succeeded but the BO still has sub-beneficial backing (partial upgrade) and
> > + * should be revisited; it is computed under the BO lock so the caller does not
> > + * need to re-inspect bo->ttm.ttm after the lock is dropped. Returns 0 if the BO
> > + * no longer needs to be tracked (either defragmented or no longer eligible), or
> > + * a negative error code if the attempt should be retried later.
> > + */
> > +static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo,
> > +			    u64 budget, u64 *consumed, bool *needs_more)
> > +{
> > +	struct ttm_operation_ctx ctx = {
> > +		.gfp_retry_mayfail = true,
> > +		.defrag = true,
> > +		.defrag_bytes_remaining = budget,
> > +	};
> > +	struct ttm_buffer_object *ttm_bo = &bo->ttm;
> > +	struct ttm_placement placement;
> > +	struct ttm_place place;
> > +	int ret = 0;
> > +
> > +	*consumed = 0;
> > +	*needs_more = false;
> > +
> > +	xe_bo_lock(bo, false);
> 
> Assisted-by: LLM
> 

Yes.

> Instead of waiting for the lock here, would it be worth trylocking it
> and upon failure move to next bo?
> 

I don't think, this is background worker so really no downside of
blocking behind foreground work with the lock.

Also later in the series we pre-alloc pages outside of dma-resv and then
just prune it in under dma-resv - a try lock would be quite weird as
we'd have to throw away the memory we just tried hard to get.

> > +
> > +	/* Re-check eligibility under the BO lock. */
> > +	if (!xe_bo_needs_defrag(bo)) {
> > +		xe_bo_defrag_remove(bo);
> > +		goto unlock;
> > +	}
> > +
> > +	xe_place_from_ttm_type(ttm_bo->resource->mem_type, &place);
> > +	place.flags |= TTM_PL_FLAG_TEMPORARY;
> > +	placement.num_placement = 1;
> > +	placement.placement = &place;
> > +
> > +	/*
> > +	 * On success the move reallocates the backing at beneficial order and
> > +	 * drops the BO from the defrag list. On failure the BO keeps its
> > +	 * original backing and stays on the list for a later retry.
> > +	 */
> > +	ret = ttm_bo_validate(ttm_bo, &placement, &ctx);
> > +
> > +	/*
> > +	 * The pool allocator decremented defrag_bytes_remaining as it
> > +	 * (re)allocated pages, so the unused budget tells us how much was spent.
> > +	 * Only meaningful when the move succeeded. A successful move may spend
> > +	 * nothing - e.g. when the object was already fully upgraded and every
> > +	 * chunk is harvested (borrowed) from the old backing for free - so a
> > +	 * zero spend is legitimate and must be charged as zero, not the whole
> > +	 * budget.
> > +	 */
> > +	if (!ret) {
> > +		s64 spent = (s64)budget - ctx.defrag_bytes_remaining;
> > +
> > +		*consumed = spent > 0 ? spent : 0;
> > +	}
> > +
> > +	xe_dbg(xe, "Defrag attempt on BO size=%zu: ret=%pe consumed=%llu\n",
> > +	       xe_bo_size(bo), ERR_PTR(ret), *consumed);
> > +
> > +	if (!ret && ttm_tt_is_beneficial_order_failed(bo->ttm.ttm))
> > +		*needs_more = true;
> > +
> > +unlock:
> > +	xe_bo_unlock(bo);
> > +	return ret;
> > +}
> > +
> > +static void xe_bo_defrag_worker(struct work_struct *w)
> > +{
> > +	struct delayed_work *dwork = to_delayed_work(w);
> > +	struct xe_device *xe =
> > +		container_of(dwork, struct xe_device, mem.defrag.worker);
> > +	u64 defrag_bytes = 0;
> > +	bool requeue = false;
> > +	int idx;
> > +
> > +	if (!drm_dev_enter(&xe->drm, &idx))
> > +		return;
> > +
> > +	if (!xe_pm_runtime_get_if_in_use(xe)) {
> > +		/*
> > +		 * The device is (runtime) suspending/suspended. Reschedule so
> > +		 * the pass retries once it is active again: the enqueue-time
> > +		 * kick in xe_bo_defrag_add() only fires on an empty->non-empty
> > +		 * transition, so it will not re-arm the worker while the list
> > +		 * is still non-empty. Requeue here to avoid stranding tracked
> > +		 * BOs. The get attempt does not resume the device, so this is
> > +		 * just a lightweight CPU-side timer while suspended.
> > +		 */
> > +		if (atomic_read(&xe->mem.defrag.count))
> > +			xe_bo_defrag_schedule(xe);
> 
> Instead of keep retrying with backoff during suspend, would be good to launch
> this worker from the resume handler?
> 

Yes. I actually made this change locally on my own before this
suggestion.

> > +		drm_dev_exit(idx);
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * Process at most XE_BO_DEFRAG_SIZE_LIMIT bytes of newly (re)allocated
> > +	 * backing per run rather than draining the whole list in one go. Only
> > +	 * the pages a move actually reallocates are charged - pages harvested
> > +	 * (borrowed) from the old backing are free and do not count - so the
> > +	 * budget tracks real defrag work. A single object larger than the
> > +	 * budget is upgraded in slices across successive runs. Each defrag is
> > +	 * synchronous and relatively expensive, so bounding the work per run
> > +	 * keeps the worker from monopolising resources and lets concurrent
> > +	 * active work make progress; any remaining work is handled by a
> > +	 * follow-up run scheduled below.
> > +	 */
> > +	while (defrag_bytes < XE_BO_DEFRAG_SIZE_LIMIT) {
> > +		struct xe_bo *first, *bo;
> > +		u64 consumed = 0;
> > +		bool needs_more = false;
> > +		int ret;
> > +
> > +		scoped_guard(spinlock, &xe->mem.defrag.lock) {
> > +			bool again;
> > +
> > +			/* Progress, reset interval */
> > +			if (defrag_bytes)
> > +				xe->mem.defrag.interval_ms = XE_BO_DEFRAG_INTERVAL_MS;
> > +
> > +			do {
> > +				first = list_first_entry_or_null(&xe->mem.defrag.list,
> > +								 struct xe_bo,
> > +								 defrag_link);
> > +				bo = first ? xe_bo_get_unless_zero(first) : NULL;
> > +				again = first && !bo;
> > +				if (again) {
> > +					list_del_init(&first->defrag_link);
> > +					atomic_dec(&xe->mem.defrag.count);
> > +				}
> > +			} while (again);
> > +		}
> > +
> > +		if (!bo)
> > +			break;
> > +
> > +		/*
> > +		 * Bound the per-BO move to the run's remaining byte budget. A
> > +		 * large object is upgraded in budget-sized slices across runs;
> > +		 * the slices already upgraded come back as free already-
> > +		 * beneficial harvests, so each run only spends budget on new
> > +		 * forward progress.
> > +		 */
> > +		ret = xe_bo_defrag_one(xe, bo, XE_BO_DEFRAG_SIZE_LIMIT - defrag_bytes,
> > +				       &consumed, &needs_more);
> > +		defrag_bytes += consumed;
> > +
> > +		if (ret || needs_more) {
> > +			scoped_guard(spinlock, &xe->mem.defrag.lock) {
> > +				if (ret)
> > +					/*
> > +					 * Abort the pass and retry the whole
> > +					 * list later, backing off exponentially
> > +					 * on every failure.
> > +					 */
> > +					xe->mem.defrag.interval_ms =
> > +						min(xe->mem.defrag.interval_ms * 2,
> > +						    (unsigned int)XE_BO_DEFRAG_INTERVAL_MAX_MS);
> > +				else
> > +					/* Progress, reset interval */
> > +					xe->mem.defrag.interval_ms = XE_BO_DEFRAG_INTERVAL_MS;
> > +			}
> > +
> 
> If xe_bo_defrag_one() returns error, code does backoff and retry but with the same BO
> at the head of the list which can fail again (more so if that BO is a large BO).
> Not sure if that is fine or we should move the failing bo in the list.
> 

Yes, we retry the same BO which I think is fine. See below my next
answer relates.

> Also, if the BO is large and returns needs_more, code backsoff and retries until that
> large BO is gets beneficial order. Would it be better instead to move on to other BOs
> without the backoff?

Again I don't think so. The defrag worker grabs X amount of 2M pages per
pass (default 32M). I don't think it matter which BO is grabs the pages
for, the goal is just to drain the entire list eventually. I don't see
value in rotating the BO which we grabbing pages for - either we will
get pages or not; The BO actually has nothing to do with the memory
acquire step.

> 
> > +			xe_bo_put(bo);
> > +			requeue = true;
> > +			break;
> > +		}
> > +
> > +		xe_bo_put(bo);
> > +	}
> > +
> > +	/*
> > +	 * Decide whether to reschedule:
> > +	 *
> > +	 *  - The loop hit its per-run limit (defrag_bytes >=
> > +	 *    XE_BO_DEFRAG_SIZE_LIMIT): we stopped early to spread the work out,
> > +	 *    so requeue at the default interval (reset here since this run made
> > +	 *    progress) whenever the list still has entries.
> > +	 *
> > +	 *  - The loop aborted on a failed defrag (requeue): retry later at the
> > +	 *    backed-off interval computed above.
> > +	 *
> > +	 *  - The loop drained the list (broke on the empty list): nothing left to
> > +	 *    do, so stop scheduling. A fresh enqueue will kick the worker again.
> > +	 */
> > +	if (defrag_bytes >= XE_BO_DEFRAG_SIZE_LIMIT) {
> > +		struct xe_bo *bo;
> > +
> > +		scoped_guard(spinlock, &xe->mem.defrag.lock) {
> > +			bo = list_first_entry_or_null(&xe->mem.defrag.list,
> > +						      struct xe_bo, defrag_link);
> > +			xe->mem.defrag.interval_ms = XE_BO_DEFRAG_INTERVAL_MS;
> > +		}
> > +
> > +		if (bo)
> > +			xe_bo_defrag_schedule(xe);
> > +	} else if (requeue) {
> > +		xe_bo_defrag_schedule(xe);
> > +	}
> > +
> > +	xe_pm_runtime_put(xe);
> > +	drm_dev_exit(idx);
> > +}
> > +
> > static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> > 		      struct ttm_operation_ctx *ctx,
> > 		      struct ttm_resource *new_mem,
> > diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
> > index 32211016a722..38d50f8122cb 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.h
> > +++ b/drivers/gpu/drm/xe/xe_bo.h
> > @@ -226,6 +226,7 @@ int xe_bo_pin(struct xe_bo *bo, struct drm_exec *exec);
> > void xe_bo_unpin_external(struct xe_bo *bo);
> > void xe_bo_unpin(struct xe_bo *bo);
> > void xe_bo_defrag_init_early(struct xe_device *xe);
> > +int xe_bo_defrag_init(struct xe_device *xe);
> > int xe_bo_validate(struct xe_bo *bo, struct xe_vm *vm, bool allow_res_evict,
> > 		   struct drm_exec *exec);
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> > index bb93425a5c70..19d38e14c910 100644
> > --- a/drivers/gpu/drm/xe/xe_device.c
> > +++ b/drivers/gpu/drm/xe/xe_device.c
> > @@ -1069,6 +1069,15 @@ int xe_device_probe(struct xe_device *xe)
> > 			return err;
> > 	}
> > 
> > +	/*
> > +	 * Register the defrag worker teardown now that the migrate contexts it
> > +	 * depends on are initialized, so devm's reverse-order cleanup stops the
> > +	 * worker before those contexts are torn down.
> > +	 */
> > +	err = xe_bo_defrag_init(xe);
> > +	if (err)
> > +		return err;
> > +
> 
> There is a sashiko reported bug here regarding probe failing earlier than this
> teardown registration causing teardown not waiting for worker to finish. Not
> sure if there will be any defrag list at that time, but probably work a fix
> for completeness?
> 

Yes, let me make sure that is fixed.

Matt

> Niranjana
> 
> > 	err = xe_pagefault_init(xe);
> > 	if (err)
> > 		return err;
> > diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
> > index 9e6244d8f41b..6e68add4d652 100644
> > --- a/drivers/gpu/drm/xe/xe_device_types.h
> > +++ b/drivers/gpu/drm/xe/xe_device_types.h
> > @@ -314,6 +314,17 @@ struct xe_device {
> > 			 * @mem.defrag.list.
> > 			 */
> > 			atomic_t count;
> > +			/**
> > +			 * @mem.defrag.worker: Delayed worker that walks
> > +			 * @mem.defrag.list trying to reallocate BO backing
> > +			 * store at the device's beneficial order.
> > +			 */
> > +			struct delayed_work worker;
> > +			/**
> > +			 * @mem.defrag.interval_ms: Reschedule interval for
> > +			 * @mem.defrag.worker, in milliseconds.
> > +			 */
> > +			unsigned int interval_ms;
> > 		} defrag;
> > 	} mem;
> > 
> > -- 
> > 2.34.1
> > 
