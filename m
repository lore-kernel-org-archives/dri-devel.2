Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF55606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WzUacvPg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=gzSjfaeO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12C6710F0A6;
	Tue, 24 Nov 2026 20:44:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6199C10E8C0;
 Tue, 24 Nov 2026 20:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795553067; x=1827089067;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=9a9uLMPGNVOnMLpMCnQ9cSNzBIo4cW/zCISmuykPqoY=;
 b=WzUacvPgs/EtnFuwmLAdNsA76ayLalBWjS4Y5mksITYrdH+sDNaMbCdt
 la43NksslQ/MTcIjQClLWT14TANqQCMmX92h81ZYpXm64Sd7vLnerTs6A
 t1UKujQZcRYoZIu755fuGYZjdEZfNAPeSTcpKuv7wPcpW7HZ6mcBDPqkF
 QYlYMgomcLpFJIzcL53vizNon0akQk8EKPb056ysMaE1fwJ82PPCTaG6+
 nem4zGiGLUsM32qmdu7dcre2w2nCcyJQ31Myh8+ZKVKEippfZL1g5i8v1
 /AIV3NzcRp7DTAb7oSomssDlaNy1RrlcVzPTwilXVdrvkaSO+kWlpogGW w==;
X-CSE-ConnectionGUID: O0HDNmE2SMi0mFIQejSTMQ==
X-CSE-MsgGUID: MTuf2NSRQ22lJn1kkIdOUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4332307"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4332307"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 12:44:26 -0800
X-CSE-ConnectionGUID: nsx+d8EnSB2vhB24yJb+Aw==
X-CSE-MsgGUID: b7JgTALLR4OYoMI5Gyg/8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11656194"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 12:44:27 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:44:26 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 12:44:26 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.21) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:44:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YX/IV8FyqcXxzKADGdrQYB2CvugVLsvXx+q7zdzCnFP3UNofwUxldvsB/34n3twlZfk+nTcVoKcwVouKxW6SRAanxdrMAziVSBAH1/49a0u7ThtI/b7buDzndP8r5cGuv4v6LE9TS85P773IKBiRF1Cjuj1mW9kk3wff381/geW0fgwiJh4Unx63faGd3xxleWpunOC98339fsLMgyc0C/TZT898lmsvEgb7WS321TrPsfM5avGv/pTcxvGggbUfiSA3VjrZS+TtwyjITqFg+8W0qEZDdvQtnQ27UBtHjSwIsgH/y+U3fKQ67/ubcpixi3mXiAyj7TqULGhBn7c3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+KNBN47/Y80ffeHFvCWE086rUtqetMQncMe60ojQlw=;
 b=yvQFvpqiCa1yigjGg4LNlmhFaWVb+cPEHhfzWAIoevUAzfxusf8K9PQ+j13PUOsqEIbLfBbAX9XjtVULACMeQ0+1344k8Wx4wP2OLFvKddOE3W8HGpg1/6Q+XSSCFPJPZLviL7X8DZkLKFLEMW1lAATQFUqlTXbWWAAS1SSgVbfwtM7rHI+wajhOCCYfNh9p+gVi2o6EzvwfUUXXYb0wqZdqCqKfb5GmB5fhutVo4dWjbi9xVE+mJPyKluucihHYyLIZ5HHeFKRw7L3ufCraMxK8fSPaY3ZUf7LB7G500phDDEEH6k+a44Q4irdC0Goy8sRVAh3hgbv2dYGEi0MYGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+KNBN47/Y80ffeHFvCWE086rUtqetMQncMe60ojQlw=;
 b=gzSjfaeOeuV5FwwwUlzHDXgE4U0fLIydKvg0ylxFnDjTjFqIwkhjn2yVorvhLa20i6JJJmRwIgstcsJBmksxPSz/PLN8ORPi4toa9QKZLxG1o7f1r3S0RiApAxGOv8yeGskW0zmhkYg1FdV/9t/PlGczjOhypa0MddA6vxlA1ww=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by IA0PR11MB7696.namprd11.prod.outlook.com (2603:10b6:208:403::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 20:44:11 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 20:44:11 +0000
Date: Tue, 24 Nov 2026 12:44:08 -0800
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
Subject: Re: [PATCH v3 25/33] drm/xe: Preallocate system BO backing outside
 the dma-resv lock
Message-ID: <awX3GIscscnIWKQ4@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-26-matthew.brost@intel.com>
 <avQa-BlJQMKkoI4k@nvishwa1-desk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avQa-BlJQMKkoI4k@nvishwa1-desk>
X-ClientProxiedBy: BY1P220CA0039.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::7) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|IA0PR11MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cafa542-2f45-4211-fc57-08df4a6bb1bf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|22082099003|18002099003|3023799007|56012099006|11063799006|261009223027099003|261021123027099003|261102124527099003|4143699003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|261009221227099003|261022075727099003|261022105027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: 0ISABrCOneIG6cfwzWMtTe2zUa79NGje1bovVSJaq86eM3OHm6tq0PQAj48Bm1E6h+nS3euV5BhgeNCBOJ4rZIW7bNGVtBLNMrXknPR0hugUNPGrH7IFcc66T96ORkKwn1Yox9WPiKe6UELdDh+eP3HrIbMXnTTUP97BPU7WglRHvPosbxwImiymfVp4Marq2wWeIOvyL8+Q4oUGVqVlAryzWVRJ2+86oousiM2E9H07T8hhRVOyvo9paTJhJfTB0iVTmqnGE7qIFeyQ73oEQ530NZbDR1uprXg07s0JuW3jtkIX30hw1rA7GRE1Q7c5rmSJVCDG2EHRpmHH6mjmIW8g4QDnvvdVP0f14kMqzZB7EV/K/bHQ/Vaqs6WX1C407w1TSGThwqw6nsQ5R73W+aCnAmqjKN979c0y8LHHCJXs3SXkhrIQIZEn9z8u6KIbhLH+vx8KMUCg63I3oiz9VpLMDxBaoVW33Nu3OTqo8VxelROMLjGpGS7zQdcFYYV0sLVI8TnWXzLrRYHZqDgRxw98ej5CJxu0si36AmXquOz3tmYXiEGmq8QA1Mg6boARQcROOmHZHrVpNU77boOwPneHVD81CLN/yxYzkfDlwOtodo5f8SWs3wDpF9Y7CbF3bzbGNLeSHVBR1LUJAoBgK7UGt+WAu8I9bRtidp01ihY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(261009223027099003)(261021123027099003)(261102124527099003)(4143699003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(261009221227099003)(261022075727099003)(261022105027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Ifq4q1OAEATu7c29YMtGhKTtAqKVcfkVGZwVRtsyxMXcylyJIpolwzJY+s?=
 =?iso-8859-1?Q?Ft01sROObgzRBO9U0iJY1H7KRyyGrhN1Zo0AdFgTjw2iOdAgXAGmcgTX2f?=
 =?iso-8859-1?Q?6E6bFZhLzjMzGx6g0K2+gpCNR1ex8JXho13N03WbKfD5s/TA4o8Vxkz07c?=
 =?iso-8859-1?Q?PZdQWiktkpQ82Bj3WAGiPhNq77+0saxDiBJfudApY9Dx7hxYV/EE4gzgJV?=
 =?iso-8859-1?Q?O5Vr/NKo1HQkrzjYsqH850Ai0UIKVERcySnNO88AiGj1J2qUe2PwgQC9QM?=
 =?iso-8859-1?Q?OK73Lj78RAit35DuRXks/qpwZF8Kj3sxU97DVzRS6hTItRYnbsnPlyp5aN?=
 =?iso-8859-1?Q?qzNxnB/ry363BpPXcT9AT2JMJag0DBqrSqFH+KYvYw1ecqn3KqMW1qCPQu?=
 =?iso-8859-1?Q?/tb1S5UfhJ3mF8ekPY70vwSkzu8qRTSDXx8odRz8l/Yt+6G+pqq1vTWL4g?=
 =?iso-8859-1?Q?gyyZb+iJT40DBTSTqxKyfs21G+92REpvCKGAOLIEFltSGTLWiraj78F9AM?=
 =?iso-8859-1?Q?8fvlhQEu0S14tsAZubzmF8DZjoS1wvLfsmz/m2WABdQf5CB69CxY+Gdw4I?=
 =?iso-8859-1?Q?nJ8pbCl0WQvcXaATGwJuAIj0khCh/cDL2jHM6xpAbKGqcfyhLEscfTtN2s?=
 =?iso-8859-1?Q?VyDrwg2JK8rdK0do2K8+Q7byQyYh5FVoq4r3C8fjZeRbwyW9xMBEh40TJd?=
 =?iso-8859-1?Q?NxoSoteG3TFW0YyTSnRzNZIWxbFRBvBbSlSEdAnXDKObUn5ZchRDgzllQW?=
 =?iso-8859-1?Q?rRj7sJ2heGe42wDoST7mbf/re4AgyThiKgIdZ9ylsgkxdbgPWboJMKR9AN?=
 =?iso-8859-1?Q?gOE+fw1vr2/ECe4iV3u3A43g4t0QYdH5sMSHhgWj2KiLJ7qqQuylXicEZO?=
 =?iso-8859-1?Q?HQv7hL7Iv2R+vet2De8apXFCUqk9aBHiddlz6GWZnVnb9A3+XwzQhaeIqb?=
 =?iso-8859-1?Q?j0TrMYaQZzFXCoXB9p3qP5RDb7VSD1Wz7PfnpPUq9tePmfFOa781Vqu1Me?=
 =?iso-8859-1?Q?QvSJwZF3Y58QHAFVb1BIhu6L7A0PgN9NWHWi8ydVheqJDWbADz3nB3gZ57?=
 =?iso-8859-1?Q?gWwfLVGoQGSjCus5GwZpZ8DOYXXR5f399fj5PlYMkIExVGKbHRAK5EszzX?=
 =?iso-8859-1?Q?vQXuqE7Y/aRH+VhTF3q4/kTrxWNcVyGIL7IDFL/8XtNhcy5Bwtl0Fq0+c/?=
 =?iso-8859-1?Q?1NnY6XN035dsF3+Ofyw8k1X7fSPSwCTziH49WCS49wpl1jvabY5bxHpUpa?=
 =?iso-8859-1?Q?wI3JaC53elywl4GYIpoV6wzLNEHQ887tuZjtE9mPQtWZcPwtIhcRcNMpx1?=
 =?iso-8859-1?Q?upec3BDR4IYTBCpfUlB2mKJEKQG4hqVlEZTdiHTAbInyFQXsV7HkRoBaYs?=
 =?iso-8859-1?Q?dyWDqa3j7/mkRKqCvQ2CZXBoLYT+zW82kDIxzWmc6y/YWxSOVZToJcCULk?=
 =?iso-8859-1?Q?s3kWt7SHzkDi/LS/U8mzHWni+cnbueFg78fe5SQuPJAdAEgP8wjz9yZ+2X?=
 =?iso-8859-1?Q?G9XBZA/f7/DxTFKS4Al2BJWKhOgYoN3SoScobF45RzWhTziQfyDAnaKi1o?=
 =?iso-8859-1?Q?xVESNIqE0Z9kHFqnTabUxI5Y91nLWs7mlXRs9FvVs7RNIATqnt/1Dl6GeE?=
 =?iso-8859-1?Q?Pw593JK+yE3agwFS2mgPkGthVH/iK3g01iJmCRAF1B8cO21DAQtD+tgtfu?=
 =?iso-8859-1?Q?0AQqaywVz/7pGL5f9CdTvNJgEUzCuIZBl3YH5fBYBqFAdN/1JJv9dARBwq?=
 =?iso-8859-1?Q?W3skdKgyZHONBOw8rNKuuNlhzzzDg0Kl2o7gku/Dq229fInvNpTpLnlG3v?=
 =?iso-8859-1?Q?5EM2Etgf1dJzWmX9ja0YZrc01Woevpc=3D?=
X-Exchange-RoutingPolicyChecked: YSYL18XfFu1bBy7rR9wHrO3yU4nw7RQQ6LvhQqOj1RKJogVOXfBhgSctNmAOodmYmIlC7D8pwhoWiAWNNtVg1882/CftBRa5TP/EtBmwMZGjNb+BLsxIotdPuY2ARMnKdSfr4E9/nsCnzKP0LiA/6RU2hf2kxDWeY9Xoi4kSLp0vwkjJklcOgIFIwscWMLVmywZbToBxLxy3Ko7W6/X+fEUnat0qIeJgcaaKYfS1vGL64aFmyC+OM1zkmBQlsogRrkAPae/ist5kilmMiapJLUKVvBg+SHFdv1IedSV6Edebe1iMEBdPHdla0ahyQM2/HWbrSC9yI3vo8fsgAkQ+ug==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cafa542-2f45-4211-fc57-08df4a6bb1bf
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 20:44:11.5337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aT2os+KOvCSRtZ6J0pxK63ONX5nVIPTuuRcz8RA+LC/WVMvULFy4YKSGk4NurSXMVjuis19VFfeglc/UQrW9gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7696
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

On Tue, Nov 10, 2026 at 11:36:24PM -0800, Niranjana Vishwanathapura wrote:
> On Fri, Jul 10, 2026 at 07:56:11PM -0700, Matthew Brost wrote:
> > xe_gem_create_ioctl() populates a buffer object's backing store inside
> > xe_validation_guard(), i.e. under the dma-resv lock.  For a system-memory
> > buffer that means the whole page allocation - potentially stalling in
> > reclaim or compaction - happens in the critical section, holding the
> > reservation and blocking anything that contends on it.
> > 
> > Use the TTM full-preallocation mechanism to move that work out of the
> > lock.  For a system-only, non-deferred user BO, allocate the entire tt
> > backing up front, before entering the validation guard, and hand the bag
> > down to the populate so it merely installs the pages:
> > 
> >  - Thread an optional struct ttm_pool_prealloc through xe_bo_create_user()
> >    -> __xe_bo_create_locked() -> xe_bo_init_locked(), which stashes it in
> >    ttm_operation_ctx::prealloc.  All other callers pass NULL.
> > 
> >  - In xe_gem_create_ioctl(), for XE_BO_FLAG_SYSTEM BOs that are not VRAM,
> >    stolen or deferred-backing, call ttm_pool_prealloc_fill_full() before
> >    the guard and ttm_pool_prealloc_fini() after it.  The bag size covers
> >    both the data pages and the appended CCS backup pages, matching the tt
> >    layout in xe_ttm_tt_create(), and the caching mirrors the same path.
> > 
> > The fill is best-effort: on a short fill (or if it is skipped) the pool
> > allocates the remainder in-line as before, so this is purely an
> > optimisation with no behavioural change to the created BO.  fini() only
> > releases the unconsumed tail, so it is safe on every success, error and
> > OOM-retry path (consumed pages are owned by the tt).
> > 
> > The fill requests reclaim backoff for higher-order chunks
> > (@beneficial_reclaim_backoff): Xe runs a background defragmenter that
> > upgrades suboptimal pages to beneficial order in place, so there is no
> > need to stall this user context reclaiming/compacting for contiguity.
> > 
> > To size the preallocation before the xe_bo exists, factor the CCS-pages
> > decision in xe_bo_needs_ccs_pages() into a parameterised helper,
> > __xe_bo_needs_ccs_pages(), and query it directly from the ioctl.
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
> > - Preallocate only when the backing fits the available TT space
> >   (Sashiko)
> > ---
> > drivers/gpu/drm/xe/tests/xe_bo.c      |   8 +-
> > drivers/gpu/drm/xe/tests/xe_dma_buf.c |   2 +-
> > drivers/gpu/drm/xe/tests/xe_migrate.c |   6 +-
> > drivers/gpu/drm/xe/xe_bo.c            | 139 +++++++++++++++++++++-----
> > drivers/gpu/drm/xe/xe_bo.h            |   8 +-
> > drivers/gpu/drm/xe/xe_dma_buf.c       |   2 +-
> > 6 files changed, 128 insertions(+), 37 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/tests/xe_bo.c b/drivers/gpu/drm/xe/tests/xe_bo.c
> > index 49c95ed67d7e..78781317b420 100644
> > --- a/drivers/gpu/drm/xe/tests/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/tests/xe_bo.c
> > @@ -141,7 +141,7 @@ static void ccs_test_run_tile(struct xe_device *xe, struct xe_tile *tile,
> > 		kunit_info(test, "Testing system memory\n");
> > 
> > 	bo = xe_bo_create_user(xe, NULL, SZ_1M, DRM_XE_GEM_CPU_CACHING_WC,
> > -			       bo_flags, exec);
> > +			       bo_flags, NULL, exec);
> > 	if (IS_ERR(bo)) {
> > 		KUNIT_FAIL(test, "Failed to create bo.\n");
> > 		return;
> > @@ -220,7 +220,7 @@ static int evict_test_run_tile(struct xe_device *xe, struct xe_tile *tile, struc
> > 		xe_vm_lock(vm, false);
> > 		bo = xe_bo_create_user(xe, vm, 0x10000,
> > 				       DRM_XE_GEM_CPU_CACHING_WC,
> > -				       bo_flags, exec);
> > +				       bo_flags, NULL, exec);
> > 		xe_vm_unlock(vm);
> > 		if (IS_ERR(bo)) {
> > 			KUNIT_FAIL(test, "bo create err=%pe\n", bo);
> > @@ -229,7 +229,7 @@ static int evict_test_run_tile(struct xe_device *xe, struct xe_tile *tile, struc
> > 
> > 		external = xe_bo_create_user(xe, NULL, 0x10000,
> > 					     DRM_XE_GEM_CPU_CACHING_WC,
> > -					     bo_flags, NULL);
> > +					     bo_flags, NULL, NULL);
> > 		if (IS_ERR(external)) {
> > 			KUNIT_FAIL(test, "external bo create err=%pe\n", external);
> > 			goto cleanup_bo;
> > @@ -494,7 +494,7 @@ static int shrink_test_run_device(struct xe_device *xe)
> > 		/* We can create bos using WC caching here. But it is slower. */
> > 		bo = xe_bo_create_user(xe, NULL, XE_BO_SHRINK_SIZE,
> > 				       DRM_XE_GEM_CPU_CACHING_WB,
> > -				       XE_BO_FLAG_SYSTEM, NULL);
> > +				       XE_BO_FLAG_SYSTEM, NULL, NULL);
> > 		if (IS_ERR(bo)) {
> > 			if (bo != ERR_PTR(-ENOMEM) && bo != ERR_PTR(-ENOSPC) &&
> > 			    bo != ERR_PTR(-EINTR) && bo != ERR_PTR(-ERESTARTSYS))
> > diff --git a/drivers/gpu/drm/xe/tests/xe_dma_buf.c b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
> > index 0be8440b3976..e4fdc247c0c7 100644
> > --- a/drivers/gpu/drm/xe/tests/xe_dma_buf.c
> > +++ b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
> > @@ -127,7 +127,7 @@ static void xe_test_dmabuf_import_same_driver(struct xe_device *xe)
> > 
> > 	kunit_info(test, "running %s\n", __func__);
> > 	bo = xe_bo_create_user(xe, NULL, size, DRM_XE_GEM_CPU_CACHING_WC,
> > -			       params->mem_mask, NULL);
> > +			       params->mem_mask, NULL, NULL);
> > 	if (IS_ERR(bo)) {
> > 		KUNIT_FAIL(test, "xe_bo_create() failed with err=%ld\n",
> > 			   PTR_ERR(bo));
> > diff --git a/drivers/gpu/drm/xe/tests/xe_migrate.c b/drivers/gpu/drm/xe/tests/xe_migrate.c
> > index 3c1be809be82..41de648b2c86 100644
> > --- a/drivers/gpu/drm/xe/tests/xe_migrate.c
> > +++ b/drivers/gpu/drm/xe/tests/xe_migrate.c
> > @@ -647,7 +647,7 @@ static void validate_ccs_test_run_tile(struct xe_device *xe, struct xe_tile *til
> > 				   DRM_XE_GEM_CPU_CACHING_WC,
> > 				   XE_BO_FLAG_SYSTEM |
> > 				   XE_BO_FLAG_NEEDS_CPU_ACCESS |
> > -				   XE_BO_FLAG_PINNED, NULL);
> > +				   XE_BO_FLAG_PINNED, NULL, NULL);
> > 
> > 	if (IS_ERR(sys_bo)) {
> > 		KUNIT_FAIL(test, "xe_bo_create() failed with err=%ld\n",
> > @@ -673,7 +673,7 @@ static void validate_ccs_test_run_tile(struct xe_device *xe, struct xe_tile *til
> > 	ccs_bo = xe_bo_create_user(xe, NULL, SZ_4M,
> > 				   DRM_XE_GEM_CPU_CACHING_WC,
> > 				   bo_flags | XE_BO_FLAG_NEEDS_CPU_ACCESS |
> > -				   XE_BO_FLAG_PINNED, NULL);
> > +				   XE_BO_FLAG_PINNED, NULL, NULL);
> > 
> > 	if (IS_ERR(ccs_bo)) {
> > 		KUNIT_FAIL(test, "xe_bo_create() failed with err=%ld\n",
> > @@ -698,7 +698,7 @@ static void validate_ccs_test_run_tile(struct xe_device *xe, struct xe_tile *til
> > 	vram_bo = xe_bo_create_user(xe, NULL, SZ_4M,
> > 				    DRM_XE_GEM_CPU_CACHING_WC,
> > 				    bo_flags | XE_BO_FLAG_NEEDS_CPU_ACCESS |
> > -				    XE_BO_FLAG_PINNED, NULL);
> > +				    XE_BO_FLAG_PINNED, NULL, NULL);
> > 	if (IS_ERR(vram_bo)) {
> > 		KUNIT_FAIL(test, "xe_bo_create() failed with err=%ld\n",
> > 			   PTR_ERR(vram_bo));
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> > index 25e5b72f870c..a646a72122d4 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -1948,7 +1948,7 @@ int xe_bo_notifier_prepare_pinned(struct xe_bo *bo)
> > 		backup = xe_bo_init_locked(xe, NULL, NULL, bo->ttm.base.resv, NULL, xe_bo_size(bo),
> > 					   DRM_XE_GEM_CPU_CACHING_WB, ttm_bo_type_kernel,
> > 					   XE_BO_FLAG_SYSTEM | XE_BO_FLAG_NEEDS_CPU_ACCESS |
> > -					   XE_BO_FLAG_PINNED, &exec);
> > +					   XE_BO_FLAG_PINNED, NULL, &exec);
> > 		if (IS_ERR(backup)) {
> > 			drm_exec_retry_on_contention(&exec);
> > 			ret = PTR_ERR(backup);
> > @@ -2089,7 +2089,7 @@ int xe_bo_evict_pinned(struct xe_bo *bo)
> > 						   xe_bo_size(bo),
> > 						   DRM_XE_GEM_CPU_CACHING_WB, ttm_bo_type_kernel,
> > 						   XE_BO_FLAG_SYSTEM | XE_BO_FLAG_NEEDS_CPU_ACCESS |
> > -						   XE_BO_FLAG_PINNED, &exec);
> > +						   XE_BO_FLAG_PINNED, NULL, &exec);
> > 			if (IS_ERR(backup)) {
> > 				drm_exec_retry_on_contention(&exec);
> > 				ret = PTR_ERR(backup);
> > @@ -2884,6 +2884,8 @@ void xe_bo_free(struct xe_bo *bo)
> >  * @cpu_caching: The cpu caching used for system memory backing store.
> >  * @type: The TTM buffer object type.
> >  * @flags: XE_BO_FLAG_ flags.
> > + * @prealloc: Optional pages preallocated outside the dma-resv lock to back the
> > + * bo (see ttm_operation_ctx::prealloc), or NULL.
> >  * @exec: The drm_exec transaction to use for exhaustive eviction.
> >  *
> >  * Initialize or create an xe buffer object. On failure, any allocated buffer
> > @@ -2895,12 +2897,14 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
> > 				struct xe_tile *tile, struct dma_resv *resv,
> > 				struct ttm_lru_bulk_move *bulk, size_t size,
> > 				u16 cpu_caching, enum ttm_bo_type type,
> > -				u32 flags, struct drm_exec *exec)
> > +				u32 flags, struct ttm_pool_prealloc *prealloc,
> > +				struct drm_exec *exec)
> > {
> > 	struct ttm_operation_ctx ctx = {
> > 		.interruptible = true,
> > 		.no_wait_gpu = false,
> > 		.gfp_retry_mayfail = true,
> > +		.prealloc = prealloc,
> > 	};
> > 	struct ttm_placement *placement;
> > 	uint32_t alignment;
> > @@ -3077,7 +3081,8 @@ __xe_bo_create_locked(struct xe_device *xe,
> > 		      struct xe_tile *tile, struct xe_vm *vm,
> > 		      size_t size, u64 start, u64 end,
> > 		      u16 cpu_caching, enum ttm_bo_type type, u32 flags,
> > -		      u64 alignment, struct drm_exec *exec)
> > +		      u64 alignment, struct ttm_pool_prealloc *prealloc,
> > +		      struct drm_exec *exec)
> > {
> > 	struct xe_bo *bo = NULL;
> > 	int err;
> > @@ -3102,7 +3107,7 @@ __xe_bo_create_locked(struct xe_device *xe,
> > 			       vm && !xe_vm_in_fault_mode(vm) &&
> > 			       flags & XE_BO_FLAG_USER ?
> > 			       &vm->lru_bulk_move : NULL, size,
> > -			       cpu_caching, type, flags, exec);
> > +			       cpu_caching, type, flags, prealloc, exec);
> > 	if (IS_ERR(bo))
> > 		return bo;
> > 
> > @@ -3177,7 +3182,7 @@ struct xe_bo *xe_bo_create_locked(struct xe_device *xe, struct xe_tile *tile,
> > 				  struct drm_exec *exec)
> > {
> > 	return __xe_bo_create_locked(xe, tile, vm, size, 0, ~0ULL, 0, type,
> > -				     flags, 0, exec);
> > +				     flags, 0, NULL, exec);
> > }
> > 
> > static struct xe_bo *xe_bo_create_novm(struct xe_device *xe, struct xe_tile *tile,
> > @@ -3193,7 +3198,7 @@ static struct xe_bo *xe_bo_create_novm(struct xe_device *xe, struct xe_tile *til
> > 	xe_validation_guard(&ctx, &xe->val, &exec, (struct xe_val_flags) {.interruptible = intr},
> > 			    ret) {
> > 		bo = __xe_bo_create_locked(xe, tile, NULL, size, 0, ~0ULL,
> > -					   cpu_caching, type, flags, alignment, &exec);
> > +					   cpu_caching, type, flags, alignment, NULL, &exec);
> > 		drm_exec_retry_on_contention(&exec);
> > 		if (IS_ERR(bo)) {
> > 			ret = PTR_ERR(bo);
> > @@ -3213,6 +3218,9 @@ static struct xe_bo *xe_bo_create_novm(struct xe_device *xe, struct xe_tile *til
> >  * @size: The storage size to use for the bo.
> >  * @cpu_caching: The caching mode to be used for system backing store.
> >  * @flags: XE_BO_FLAG_ flags.
> > + * @prealloc: Optional pages preallocated outside the dma-resv lock to back the
> > + * bo (see ttm_operation_ctx::prealloc), or NULL. Only consumed on the locked
> > + * (@vm or @exec) path.
> >  * @exec: The drm_exec transaction to use for exhaustive eviction, or NULL
> >  * if such a transaction should be initiated by the call.
> >  *
> > @@ -3223,7 +3231,8 @@ static struct xe_bo *xe_bo_create_novm(struct xe_device *xe, struct xe_tile *til
> > struct xe_bo *xe_bo_create_user(struct xe_device *xe,
> > 				struct xe_vm *vm, size_t size,
> > 				u16 cpu_caching,
> > -				u32 flags, struct drm_exec *exec)
> > +				u32 flags, struct ttm_pool_prealloc *prealloc,
> > +				struct drm_exec *exec)
> > {
> > 	struct xe_bo *bo;
> > 
> > @@ -3233,7 +3242,7 @@ struct xe_bo *xe_bo_create_user(struct xe_device *xe,
> > 		xe_assert(xe, exec);
> > 		bo = __xe_bo_create_locked(xe, NULL, vm, size, 0, ~0ULL,
> > 					   cpu_caching, ttm_bo_type_device,
> > -					   flags, 0, exec);
> > +					   flags, 0, prealloc, exec);
> > 		if (!IS_ERR(bo))
> > 			xe_bo_unlock_vm_held(bo);
> > 	} else {
> > @@ -3272,7 +3281,7 @@ struct xe_bo *xe_bo_create_pin_range_novm(struct xe_device *xe, struct xe_tile *
> > 
> > 	xe_validation_guard(&ctx, &xe->val, &exec, (struct xe_val_flags) {}, err) {
> > 		bo = __xe_bo_create_locked(xe, tile, NULL, size, start, end,
> > -					   0, type, flags, 0, &exec);
> > +					   0, type, flags, 0, NULL, &exec);
> > 		if (IS_ERR(bo)) {
> > 			drm_exec_retry_on_contention(&exec);
> > 			err = PTR_ERR(bo);
> > @@ -3311,7 +3320,7 @@ static struct xe_bo *xe_bo_create_pin_map_at_aligned(struct xe_device *xe,
> > 
> > 	bo = __xe_bo_create_locked(xe, tile, vm, size, start, end, 0, type,
> > 				   flags | XE_BO_FLAG_NEEDS_CPU_ACCESS | XE_BO_FLAG_PINNED,
> > -				   alignment, exec);
> > +				   alignment, NULL, exec);
> > 	if (IS_ERR(bo))
> > 		return bo;
> > 
> > @@ -3926,6 +3935,10 @@ static int gem_create_user_extensions(struct xe_device *xe, struct xe_bo *bo,
> > 	return 0;
> > }
> > 
> > +static bool __xe_bo_needs_ccs_pages(struct xe_device *xe,
> > +				    enum ttm_bo_type type, u32 flags,
> > +				    u16 cpu_caching);
> > +
> > int xe_gem_create_ioctl(struct drm_device *dev, void *data,
> > 			struct drm_file *file)
> > {
> > @@ -3936,6 +3949,8 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
> > 	struct drm_exec exec;
> > 	struct xe_vm *vm = NULL;
> > 	struct xe_bo *bo;
> > +	struct ttm_pool_prealloc prealloc = {};
> > +	bool have_prealloc = false;
> > 	unsigned int bo_flags;
> > 	u32 handle;
> > 	int err;
> > @@ -4018,6 +4033,64 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
> > 			return -ENOENT;
> > 	}
> > 
> > +	/*
> > +	 * For system-only BOs, preallocate the whole backing outside the
> > +	 * dma-resv lock so the populate under the validation guard does not
> > +	 * stall in reclaim/compaction. The caching mirrors the system-BO path
> > +	 * in xe_ttm_tt_create(); the pool falls back to in-line allocation for
> > +	 * any shortfall, so a failed fill is harmless.
> > +	 */
> > +	if ((bo_flags & XE_BO_FLAG_SYSTEM) &&
> > +	    !(bo_flags & (XE_BO_FLAG_DEFER_BACKING | XE_BO_FLAG_VRAM_MASK |
> > +			  XE_BO_FLAG_STOLEN))) {
> > +		struct ttm_resource_manager *tt_man =
> > +			ttm_manager_type(&xe->ttm, XE_PL_TT);
> > +		enum ttm_caching caching = ttm_cached;
> > +		unsigned long num_pages = args->size >> PAGE_SHIFT;
> > +
> > +		if (!IS_DGFX(xe) &&
> > +		    args->cpu_caching == DRM_XE_GEM_CPU_CACHING_WC)
> > +			caching = ttm_write_combined;
> > +
> > +		/*
> > +		 * Cover the CCS backup pages appended to the tt (see
> > +		 * xe_ttm_tt_create()) so the whole tt is preallocated.
> > +		 */
> > +		if (__xe_bo_needs_ccs_pages(xe, ttm_bo_type_device, bo_flags,
> > +					    args->cpu_caching))
> > +			num_pages += DIV_ROUND_UP(xe_device_ccs_bytes(xe,
> > +								      args->size),
> > +						  PAGE_SIZE);
> > +
> > +		/*
> > +		 * Only prealloc when the backing fits the currently-available
> > +		 * TT space (manager size minus current usage). This skips the
> > +		 * up-front reclaim/compaction both for over-large,
> > +		 * user-controlled sizes and when TT is already near full; the
> > +		 * populate under the validation guard handles those cases.
> > +		 */
> > +		if (tt_man) {
> > +			u64 used = ttm_resource_manager_usage(tt_man);
> > +			u64 shift_size = tt_man->size << PAGE_SHIFT;
> > +			u64 avail = shift_size > used ? shift_size - used : 0;
> > +
> > +			if ((u64)num_pages << PAGE_SHIFT <= avail) {
> > +				/*
> > +				 * Back off aggressive reclaim/compaction for
> > +				 * higher-order chunks here: Xe runs a background
> > +				 * defragmenter that upgrades suboptimal pages to
> > +				 * beneficial order in place later, so there is no
> > +				 * need to stall this user context reclaiming for
> > +				 * contiguity.
> > +				 */
> > +				ttm_pool_prealloc_fill_full(&xe->ttm.pool,
> > +							    caching, &prealloc,
> > +							    num_pages, true);
> > +				have_prealloc = true;
> > +			}
> > +		}
> > +	}
> > +
> 
> May be extract this new code block into a separte static function?
> 

Let me see what that will look like.

Matt

> Niranjana
> 
> > 	err = 0;
> > 	xe_validation_guard(&ctx, &xe->val, &exec, (struct xe_val_flags) {.interruptible = true},
> > 			    err) {
> > @@ -4028,7 +4101,8 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
> > 				break;
> > 		}
> > 		bo = xe_bo_create_user(xe, vm, args->size, args->cpu_caching,
> > -				       bo_flags, &exec);
> > +				       bo_flags, have_prealloc ? &prealloc : NULL,
> > +				       &exec);
> > 		drm_exec_retry_on_contention(&exec);
> > 		if (IS_ERR(bo)) {
> > 			err = PTR_ERR(bo);
> > @@ -4036,6 +4110,8 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
> > 			break;
> > 		}
> > 	}
> > +	if (have_prealloc)
> > +		ttm_pool_prealloc_fini(&xe->ttm.pool, &prealloc);
> > 	if (err)
> > 		goto out_vm;
> > 
> > @@ -4331,21 +4407,19 @@ int xe_bo_evict(struct xe_bo *bo, struct drm_exec *exec)
> > 	return 0;
> > }
> > 
> > -/**
> > - * xe_bo_needs_ccs_pages - Whether a bo needs to back up CCS pages when
> > - * placed in system memory.
> > - * @bo: The xe_bo
> > - *
> > - * Return: true if extra pages need to be allocated, false otherwise.
> > +/*
> > + * Whether a bo with the given attributes needs to back up CCS pages when placed
> > + * in system memory. Split out so callers can query before the xe_bo exists (see
> > + * xe_gem_create_ioctl() preallocation).
> >  */
> > -bool xe_bo_needs_ccs_pages(struct xe_bo *bo)
> > +static bool __xe_bo_needs_ccs_pages(struct xe_device *xe,
> > +				    enum ttm_bo_type type, u32 flags,
> > +				    u16 cpu_caching)
> > {
> > -	struct xe_device *xe = xe_bo_device(bo);
> > -
> > 	if (GRAPHICS_VER(xe) >= 20 && IS_DGFX(xe))
> > 		return false;
> > 
> > -	if (!xe_device_has_flat_ccs(xe) || bo->ttm.type != ttm_bo_type_device)
> > +	if (!xe_device_has_flat_ccs(xe) || type != ttm_bo_type_device)
> > 		return false;
> > 
> > 	/* On discrete GPUs, if the GPU can access this buffer from
> > @@ -4353,24 +4427,37 @@ bool xe_bo_needs_ccs_pages(struct xe_bo *bo)
> > 	 * can't be used since there's no CCS storage associated with
> > 	 * non-VRAM addresses.
> > 	 */
> > -	if (IS_DGFX(xe) && (bo->flags & XE_BO_FLAG_SYSTEM))
> > +	if (IS_DGFX(xe) && (flags & XE_BO_FLAG_SYSTEM))
> > 		return false;
> > 
> > 	/* Check if userspace explicitly requested no compression */
> > -	if (bo->flags & XE_BO_FLAG_NO_COMPRESSION)
> > +	if (flags & XE_BO_FLAG_NO_COMPRESSION)
> > 		return false;
> > 
> > 	/*
> > 	 * For WB (Write-Back) CPU caching mode, check if the device
> > 	 * supports WB compression with coherency.
> > 	 */
> > -	if (bo->cpu_caching == DRM_XE_GEM_CPU_CACHING_WB &&
> > +	if (cpu_caching == DRM_XE_GEM_CPU_CACHING_WB &&
> > 	    xe->pat.idx[XE_CACHE_WB_COMPRESSION] == XE_PAT_INVALID_IDX)
> > 		return false;
> > 
> > 	return true;
> > }
> > 
> > +/**
> > + * xe_bo_needs_ccs_pages - Whether a bo needs to back up CCS pages when
> > + * placed in system memory.
> > + * @bo: The xe_bo
> > + *
> > + * Return: true if extra pages need to be allocated, false otherwise.
> > + */
> > +bool xe_bo_needs_ccs_pages(struct xe_bo *bo)
> > +{
> > +	return __xe_bo_needs_ccs_pages(xe_bo_device(bo), bo->ttm.type,
> > +				       bo->flags, bo->cpu_caching);
> > +}
> > +
> > /**
> >  * __xe_bo_release_dummy() - Dummy kref release function
> >  * @kref: The embedded struct kref.
> > @@ -4477,7 +4564,7 @@ int xe_bo_dumb_create(struct drm_file *file_priv,
> > 			       DRM_XE_GEM_CPU_CACHING_WC,
> > 			       XE_BO_FLAG_VRAM_IF_DGFX(xe_device_get_root_tile(xe)) |
> > 			       XE_BO_FLAG_FORCE_WC |
> > -			       XE_BO_FLAG_NEEDS_CPU_ACCESS, NULL);
> > +			       XE_BO_FLAG_NEEDS_CPU_ACCESS, NULL, NULL);
> > 	if (IS_ERR(bo))
> > 		return PTR_ERR(bo);
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
> > index 38d50f8122cb..18fcccd082b7 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.h
> > +++ b/drivers/gpu/drm/xe/xe_bo.h
> > @@ -111,6 +111,7 @@ enum xe_madv_purgeable_state {
> > 
> > struct sg_table;
> > struct ttm_tt;
> > +struct ttm_pool_prealloc;
> > 
> > struct xe_bo *xe_bo_alloc(void);
> > void xe_bo_free(struct xe_bo *bo);
> > @@ -119,13 +120,16 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
> > 				struct xe_tile *tile, struct dma_resv *resv,
> > 				struct ttm_lru_bulk_move *bulk, size_t size,
> > 				u16 cpu_caching, enum ttm_bo_type type,
> > -				u32 flags, struct drm_exec *exec);
> > +				u32 flags, struct ttm_pool_prealloc *prealloc,
> > +				struct drm_exec *exec);
> > struct xe_bo *xe_bo_create_locked(struct xe_device *xe, struct xe_tile *tile,
> > 				  struct xe_vm *vm, size_t size,
> > 				  enum ttm_bo_type type, u32 flags,
> > 				  struct drm_exec *exec);
> > struct xe_bo *xe_bo_create_user(struct xe_device *xe, struct xe_vm *vm, size_t size,
> > -				u16 cpu_caching, u32 flags, struct drm_exec *exec);
> > +				u16 cpu_caching, u32 flags,
> > +				struct ttm_pool_prealloc *prealloc,
> > +				struct drm_exec *exec);
> > struct xe_bo *xe_bo_create_pin_map(struct xe_device *xe, struct xe_tile *tile,
> > 				   struct xe_vm *vm, size_t size,
> > 				   enum ttm_bo_type type, u32 flags,
> > diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
> > index 8a920e58245c..ec947d86a1ce 100644
> > --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> > +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> > @@ -302,7 +302,7 @@ xe_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
> > 
> > 		bo = xe_bo_init_locked(xe, NULL, NULL, resv, NULL, dma_buf->size,
> > 				       0, /* Will require 1way or 2way for vm_bind */
> > -				       ttm_bo_type_sg, XE_BO_FLAG_SYSTEM, &exec);
> > +				       ttm_bo_type_sg, XE_BO_FLAG_SYSTEM, NULL, &exec);
> > 		drm_exec_retry_on_contention(&exec);
> > 		if (IS_ERR(bo)) {
> > 			ret = PTR_ERR(bo);
> > -- 
> > 2.34.1
> > 
