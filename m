Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2B4606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 02:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kVQBlrKk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=kgOWzmmL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79B9C112848;
	Fri, 20 Nov 2026 02:29:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2E87112842;
 Fri, 20 Nov 2026 02:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795141777; x=1826677777;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=40C/H1yB4Vbb3AhnjEnL2Xs1wM6OMG1lTkMsbiMku94=;
 b=kVQBlrKkUD+Fly010nH0zDespVmgwoGRScTkkineJfpWI+vHkGPrb7m8
 sNX4axidceKPsBdz07R2kqHr1vMt7mVLdAdd1pBsTjFI7b6FfIz5jD1E2
 QEO1LXH2l1JrojR6lXPp+Jrn3PUNR73G2bRPtU+7e0rGuzxU5o974r7eq
 gTy/vRLEac4gvDJi4L2mOQ1Y8amncCuuEMc1EW7XoRDqV3+nVXvEnV2Ch
 nnutyNZozFQzwmsKFOkIUUMQfiA8ha7NF2EG87JKR5EHW9iHOtaqxXVIt
 UiuAEa95xQ3zWPF0cHbL6mEiJqes1R0e1yG7VlUTD6gY6DAfiue3Clk1k g==;
X-CSE-ConnectionGUID: 4csldEI7TliK4XxE4qHI/Q==
X-CSE-MsgGUID: BPtEQVqUQgqRwNbIZr/wGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3905753"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3905753"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 18:29:37 -0800
X-CSE-ConnectionGUID: I8/OSONXRTi84y+MCcoKSg==
X-CSE-MsgGUID: vJgNkCqeRqqF/RPm/oHLXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10932695"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 18:29:37 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 18:29:36 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 18:29:36 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 18:29:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0tyw70E4Q5Q/UygcbZGzmvVwFLilfVscAFNiKqgI3boS60bM25CvpAjO91HCnMFBin7pHmvIb0W6cN8wcnBNK3LnNVndbxOzl4uQ1spcnFaIzs76iOf7ygxvWa2axz57e7dzP4vqQxS+hn/5SDBksbugY95+vIoiuzaqgpI1ieJPtWB7RgFjqvobBd2q5UCKLaQ+cxi3wx3xr+Xu1LkBo571e7Jtuumme+76bcjKJGrvsAqNbvmRNn+UBIf2cd2AWi76NXJLk9a3WlrvDIGqEf6iQEJP54Udv2GhLSCKYniJ2WfB3NooHEzOhbRC9iGOv8mRl7VJjlQ8W3uQQm4Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUUZAU6dX2XM5AQ+yCANsLXE+sJNY51MGt8p238LtQo=;
 b=ISQHgo4HgE9wny7nmSUfVFAO6mzD89Sq2vId7jIbYa6tKpDk+kp5goDJseBQ4s6MTZSVUS2Xu9Sl602jQ5B7s4DxZ0NOdd+vrJ6I3qB4MgWfafTiiU4erNjq9fcV+ZJ7b1+86tQBEG1pHME0L85waVcGrr46wd2Q4Twuai6UCm4c4MGUbJDrTks0vcBdPlV8aZ6TWr//2FI8V8Tp/un621mtvpN5sxpMK56kzis3aZUZ9F+R+JVu642JYMCKkahcBNRM0lYQ6+bxap2pATSP3fw2dEheRrh2LjSagt4PJ4Cg2wt7beAFLtj6LTtFWmEkSSvf3iQpu8EeKUyGtOX4CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUUZAU6dX2XM5AQ+yCANsLXE+sJNY51MGt8p238LtQo=;
 b=kgOWzmmLJe4bzjt5JEQdghQ27eAZpaC857AgTlsipOYu2Qpx4qCycaIx0XSqNLUkCz+e38GMH6t6QbJCmkk3JEQjiKvTJ2FUkzoLDG3q/i0jGbbvUQSCVgcFK9o13w8k6xin6YJWyf2z514Ewwbru2KptzUuCF2HcpRR9TB+d74=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DS7PR11MB6014.namprd11.prod.outlook.com (2603:10b6:8:73::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 02:29:26 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 02:29:26 +0000
Date: Thu, 19 Nov 2026 18:29:24 -0800
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
Subject: Re: [PATCH v3 09/33] drm/ttm: Preallocate beneficial-order defrag
 pages outside the lock
Message-ID: <av+whJDu3X1dkukt@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-10-matthew.brost@intel.com>
 <avQd8-goadCYcs68@nvishwa1-desk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avQd8-goadCYcs68@nvishwa1-desk>
X-ClientProxiedBy: MW4PR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:303:8d::17) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DS7PR11MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a9599b0-a4f1-4dc7-139e-08df46ae18b7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003|5023799004|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261028144727099003|261102123227099003|261021121427099003|261021123027099003|261102130727099003|261009221227099003|261009220027099003|261009223027099003|261009223327099003|261009221727099003|261022113327099003|10067099003;
X-Microsoft-Antispam-Message-Info: /hqKfLUrl+TPhvoAEV8sXC8K9th6A7lUQJoCw/Ub6qFECqbsDJnjPs0KYWO7CXN3B0BN+1C6DC06xs4IbKnb1yZ7czj61x3m14h/fhE2Ok2nACSdahIDywYdiuvftXn4NLObSxnQ/DjM1TIbenJ8n0SAuNKryJOgdX5XD8sGbw1B23i2OFQos55phfnjf7WECNBLjLnRizzcnEE5c/HJLaCEI3Y+gsWXx613GzqdFLi04CIzEH5wfymootWLQrn0JNaCor+WpzRwW0vtKOZRs97Ied0mQY1zSw3j9sv1fEHLHgLMVWDJJgjjJ2xV84K5uRwzb28zDRsUalwa2JpkWFzJ4MhYMfsnDCxm9BECu6BnJ+Cpjfta08E1aLAkrAwjp++k/oA31nC2EpqDb3MofJRGCdzFetb0vMjd0BHqmpylNGi0eHOCShn8S3MPYCIvkjZvvudI1OIu9GuVyKu+g8nNSQRHZw000GvFqoG5KAYE8n1zXsTjLDw01T6cOL2dA1kFpP+zUj0a4B3qIzYLfZiCqOWDZ56VaNJ68dGupI8Jl1BgAbgZqlXTlIEe1AEexPU3oD4Tf65ZikeJU8PZpUPBXFtfX0FhNWMPInXnHbyeRGEBNeOcz3USXWRO9Bivqn+Gb1k2DAaPQWabd8w33W8KUqL8X602K0C+adpJLlU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(5023799004)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261028144727099003)(261102123227099003)(261021121427099003)(261021123027099003)(261102130727099003)(261009221227099003)(261009220027099003)(261009223027099003)(261009223327099003)(261009221727099003)(261022113327099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?dSUziHa6f4iHpSXHMCWrFfq74WZPo7qhoKDs5jWZR2PEPfvmpHJz/AacJ1?=
 =?iso-8859-1?Q?7cx6U+l0oR49nKM+y2SlsPrdfkQsOVT+5YpdN+LBFwrriWMmobQ+jliTyX?=
 =?iso-8859-1?Q?i1pRNnYlmqQNgaDw1h0Bt4EUFfoMTEKv33wRMggoaODGvw6b3TU820Zzzi?=
 =?iso-8859-1?Q?f+J5g/1pkocitJH9uA2Yr7FvnH9CABvl3KJLJYGuem+qh5/QGmUt6b6uOf?=
 =?iso-8859-1?Q?+dBrmFi7QezGtR60LsbYdfM2DsjHqZXIZjLZBmKUgZCOWfMtO9F+uNpxLT?=
 =?iso-8859-1?Q?97dOxKrYK8o1fme7hkOcwyVYrV8eQ6OyN42/1gyJGBgEK3C/5Lp6E1wsRa?=
 =?iso-8859-1?Q?8UI2a5pXTbovDsKsy75cOclAIqW+4daJQK9KdvKe2arFm2N9XfmDVzRuo8?=
 =?iso-8859-1?Q?Q7rW4hN8KPLa2BrdHxxPq66HeCyvzfz8G4eVy3vQpgI2FD29uKjDM0aS9v?=
 =?iso-8859-1?Q?NIMJtAZNvGl1H2mq4Ej1t+DzbHjH4bC7RuWieHFHsmRnRbeAD1Z9UrFiuy?=
 =?iso-8859-1?Q?X0lnH2tm26Ijq1G2/12WPsKgeVjYx6wFNEySB1cb+OnnAUsKgPkS0NH3Q9?=
 =?iso-8859-1?Q?Mr58QE/4nEDEYuso3EPihH2MrIlUoHjMEEIGp+ybcnj1rgv/Id2HcLC8NL?=
 =?iso-8859-1?Q?FQCGLDELR4pgLbbokLh5yCIKgxdyrMgbtEwbML3vf6nj05mADmRuKVYvYI?=
 =?iso-8859-1?Q?Ype8gexXMM+w7+5Iozx+0T7Lor1+cPep1NEs2LWKyDhATbjKmAiccDVQSU?=
 =?iso-8859-1?Q?3NT6D264WtcvCQfdWylZMq0O4RxQmWlnhNtswQvQGPLLxfeoSTofixlz+n?=
 =?iso-8859-1?Q?wUz74sEBLObZMHDyIDY6vSpbJ2hS5HxNZRtRuBJNdy1AtIUUEysizJDY33?=
 =?iso-8859-1?Q?IUFBLs8Op3LSMrIDQrlNTs89llFmvjqesVl1IborAX4xYvyp4AzDgHxLbB?=
 =?iso-8859-1?Q?Pk2+xgn2nKihTzgubVjzEb97DW7Z7AOHg4b8DR19w1Mgiic2NsOjO4vPl4?=
 =?iso-8859-1?Q?BArmfjdFFpjqH4zaxrLLzpZ8bcE4RNF6aaJ5y508DmdO4mGYqaE+BLKNh4?=
 =?iso-8859-1?Q?FtB/W8J9omd/ZJ26rCrTiGrxTocf47rvhKfxzCwr5pWrLK51ncFKZ74wzj?=
 =?iso-8859-1?Q?XN382uWu6CjVgC7xbST2bNkj3L8f4cthHHxi4MuK2eeOh1w2MNwciJWZML?=
 =?iso-8859-1?Q?zjyqREgy+tCk3t9PUaR6NFr86enfdxOYUEnmkwZCN2MgIYLasAffhhHj6d?=
 =?iso-8859-1?Q?0vetoBgnqpl5wtzy8mnk1elIL8HrnRj2uSmqQNx51TIMVv7Z4gJMg56Nuu?=
 =?iso-8859-1?Q?ztpFiPvo6WtWbnvMCFF1oiK3ipfafFIMQ/ObXd+DHKQd5p6lUNJCPHpkRT?=
 =?iso-8859-1?Q?Kb5eVSxY6PptjNr0y14JTB7QfpQ7snnaUYi3SPSsTmapDRaxd7ywP4l3VI?=
 =?iso-8859-1?Q?pAj56LPgH/0sI/5YTUSql2/8HreDwQ+1nVTuLxYOn8s6FY0+XoaEyOxBYW?=
 =?iso-8859-1?Q?2F74E15SX4UPBA35RSHnIRicAi3uS5IJ9YwC12nhDt47XFnph3Ldr87XIy?=
 =?iso-8859-1?Q?BTm8p9znyhrxJEVyo9XQ3qZx2V9+e81Vp5OXJ7EFeOlt4DO6AC+jdTMTY8?=
 =?iso-8859-1?Q?OY3xqFjuCTzA722KQJdt4YatG0s48R1N6hvsJsZRjLu5XcLtM/+tuWCiR7?=
 =?iso-8859-1?Q?AiwVo/NRdfU7X+IaNqeKKC/txvRWxQa0pZYy3RaXAfvRIUUhv1whC2FZyY?=
 =?iso-8859-1?Q?q4yoAQHLB2H1ppjhiOMUSf3iEVNdAZzB3AxjhEkJXXuNiU/PQdOL24L2Lb?=
 =?iso-8859-1?Q?au/K0xWe4Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: wJJnA6wJRTKV05Kmwa3gIQw4FSyvKfigsFy+2hmEBPwPLAK0Z9ziv4Kvn0/D6WS0bp/yzspOidSjxEO0fN8FL5ugW8Yl+EpHS0JsT11H7Cv1lnGSuJcwnaYCF7xQ9p0dtdsQPNz4IIw7RBehVWFO0rTizrXFcOUrQGgqsNg4iz36kUsudY1TmdANr+bzBWhgYGXNxrUUghCcvsRgi74VCJ2alshdd56mNlpBH4KLeDJIYqCQhifsFf96UX/+W1DP/Z5LFT8nMf7ZswC2wiLJhlR4aIEiEY3OBfI5/npsXZx/Yxz/O3IYjxpfpyk7n6dPTU08tJe6Y5zHk51zFDyzvg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9599b0-a4f1-4dc7-139e-08df46ae18b7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 02:29:26.4180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hF6Bch2jmAqqh2+ITI6dBlyYy3XPbZ8woMqZASRzp6QpGam6QIuJUoErf6BMDsa6q8MSd9i4j5LZVnv5p0fuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6014
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

On Tue, Nov 10, 2026 at 11:49:07PM -0800, Niranjana Vishwanathapura wrote:
> On Fri, Jul 10, 2026 at 07:55:55PM -0700, Matthew Brost wrote:
> > Defragmentation moves reallocate a BO's backing at the pool's beneficial
> > order. On a fragmented system those high-order allocations frequently
> > stall in direct reclaim/compaction, and they run under the BO dma-resv
> > lock, holding up concurrent rendering. The defrag worker does not care
> > how long the work takes; it only cares about minimizing locked time.
> > 
> > Add a preallocation bag so the expensive allocations can be hoisted out
> > of the lock:
> > 
> > - struct ttm_pool_prealloc carries beneficial-order pages preallocated
> >   outside the lock; ttm_pool_prealloc_fill()/_fini() allocate and
> >   release them. __ttm_pool_alloc() consumes them via ctx->prealloc.
> > - Apply the requested cpu-caching to the bag pages during fill, so the
> >   set_memory_*() cost is paid outside the lock too; consumed pages are
> >   already cache-consistent and leftovers are restored to write-back on
> >   free. Bag pages are never highmem so the kernel mapping is always
> >   valid for set_memory_*().
> > - Record the exact number of sub-optimal pages on the tt
> >   (nr_suboptimal_pages) at populate time so a defrag pass can size its
> >   prealloc precisely instead of guessing.
> > - Once a defrag move exhausts the prealloc bag, harvest the remainder
> >   of the old tt rather than entering reclaim under the lock, and flag
> >   the tt sub-optimal so the driver re-queues it for a later pass.
> > 
> > This keeps all reclaim/compaction stalls and cache mode changes out of
> > the dma-resv critical section: lock-held time then tracks only the bytes
> > actually copied.
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
> > ---
> > drivers/gpu/drm/ttm/ttm_pool.c | 244 +++++++++++++++++++++++++++++++--
> > include/drm/ttm/ttm_bo.h       |  11 ++
> > include/drm/ttm/ttm_pool.h     |  29 ++++
> > include/drm/ttm/ttm_tt.h       |  17 +++
> > 4 files changed, 287 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> > index 1673e81b8df8..da7d132c8297 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -82,6 +82,9 @@ struct ttm_pool_dma {
> >  * Pages harvested (borrowed) from the old tt are free and do not count; once
> >  * this drops to zero the allocator stops upgrading and harvests the remainder.
> >  * On completion it holds the unused budget. 0 means unlimited (no defrag cap).
> > + * @nr_suboptimal_pages: Number of pages backed below the pool's beneficial
> > + * order. Recorded by the pool allocator after populate; a defrag pass reads it
> > + * to size its out-of-lock preallocation exactly.
> >  */
> > struct ttm_pool_alloc_state {
> > 	struct page **pages;
> > @@ -90,6 +93,7 @@ struct ttm_pool_alloc_state {
> > 	pgoff_t remaining_pages;
> > 	enum ttm_caching tt_caching;
> > 	s64 defrag_bytes_remaining;
> > +	u32 nr_suboptimal_pages;
> > };
> > 
> > /**
> > @@ -787,6 +791,7 @@ static void ttm_pool_alloc_state_init(const struct ttm_tt *tt,
> > 	alloc->remaining_pages = tt->num_pages;
> > 	alloc->tt_caching = tt->caching;
> > 	alloc->defrag_bytes_remaining = 0;
> > +	alloc->nr_suboptimal_pages = 0;
> > }
> > 
> > /*
> > @@ -852,7 +857,8 @@ static unsigned int ttm_pool_defrag_old_order(struct ttm_pool *pool,
> >  * pages stay owned by the old tt until the move commits.
> >  */
> > static int ttm_pool_harvest_page(struct ttm_tt *old_tt, unsigned int order,
> > -				 pgoff_t off, struct ttm_pool_alloc_state *alloc)
> > +				 unsigned int beneficial_order, pgoff_t off,
> > +				 struct ttm_pool_alloc_state *alloc)
> > {
> > 	pgoff_t nr = 1UL << order;
> > 	int r;
> > @@ -887,6 +893,9 @@ static int ttm_pool_harvest_page(struct ttm_tt *old_tt, unsigned int order,
> > 
> > 	alloc->caching_divide = alloc->pages;
> > 
> > +	if (order < beneficial_order)
> > +		alloc->nr_suboptimal_pages += 0x1 << order;
> > +
> > 	return 0;
> > }
> > 
> > @@ -934,7 +943,8 @@ static int ttm_pool_harvest_remaining(struct ttm_pool *pool,
> > 		    round_down(off, bnr) + bnr <= num_pages)
> > 			*suboptimal = true;
> > 
> > -		r = ttm_pool_harvest_page(old_tt, order, off, alloc);
> > +		r = ttm_pool_harvest_page(old_tt, order, beneficial, off,
> > +					  alloc);
> > 		if (r)
> > 			return r;
> > 
> > @@ -944,6 +954,173 @@ static int ttm_pool_harvest_remaining(struct ttm_pool *pool,
> > 	return 0;
> > }
> > 
> > +unsigned int ttm_pool_prealloc_order(struct ttm_pool *pool)
> > +{
> > +	return ttm_pool_beneficial_order(pool);
> > +}
> > +EXPORT_SYMBOL(ttm_pool_prealloc_order);
> > +
> > +/*
> > + * Build the gfp flags used for the high-order, possibly reclaiming, beneficial
> > + * order page allocations, matching the in-line defrag alloc path.
> > + */
> > +static gfp_t ttm_pool_prealloc_gfp(struct ttm_pool *pool)
> > +{
> > +	gfp_t gfp = GFP_USER;
> > +
> > +	/*
> > +	 * No highmem: prealloc applies caching in bulk via set_pages_array_*()
> > +	 * on the kernel mapping, so the pages must be permanently mapped.
> > +	 */
> > +	if (ttm_pool_uses_dma32(pool))
> > +		gfp |= GFP_DMA32;
> > +
> > +	return gfp;
> > +}
> > +
> > +/*
> > + * Apply a tt's cpu-caching to a batch of freshly system-allocated (write-back)
> > + * prealloc pages in one shot. @cpages is an unpacked array of @ncpages
> > + * individual 4K pages (the constituent pages of the mixed-order chunks, expanded
> > + * so set_pages_array_*() sees one entry per page), since the packed prealloc bag
> > + * holds multi-order chunks. Prealloc pages are never highmem (see
> > + * ttm_pool_prealloc_gfp), so their kernel mapping is valid. No-op for cached
> > + * pages and on non-x86. Returns non-zero if the caching change failed (the
> > + * caller drops the whole bag and falls back to in-line allocation).
> > + */
> > +static int ttm_pool_prealloc_apply_caching(enum ttm_caching caching,
> > +					   struct page **cpages,
> > +					   unsigned int ncpages)
> > +{
> > +#ifdef CONFIG_X86
> > +	if (!ncpages)
> > +		return 0;
> > +
> > +	switch (caching) {
> > +	case ttm_cached:
> > +		break;
> > +	case ttm_write_combined:
> > +		return set_pages_array_wc(cpages, ncpages);
> > +	case ttm_uncached:
> > +		return set_pages_array_uc(cpages, ncpages);
> > +	}
> > +#endif
> > +	return 0;
> > +}
> > +
> > +/* Expand an @order chunk into its constituent 4K pages for bulk caching. */
> > +static void ttm_pool_prealloc_stage_caching(struct page **cpages,
> > +					    unsigned int *ncpages,
> > +					    struct page *p, unsigned int order)
> > +{
> > +	unsigned int i, nr = 1u << order;
> > +
> > +	for (i = 0; i < nr; i++)
> > +		cpages[(*ncpages)++] = p + i;
> > +}
> > +
> > +/**
> > + * ttm_pool_prealloc_fill() - Preallocate beneficial-order pages outside any lock
> > + * @pool: The pool to allocate from.
> > + * @tt_caching: The requested cpu-caching for the pages allocated.
> > + * @pp: Prealloc bag to fill; @pp->order is set to the beneficial order.
> > + * @count: Number of beneficial-order chunks to attempt.
> > + *
> > + * Allocate up to @count beneficial-order chunks, parking them in @pp for a
> > + * later __ttm_pool_alloc() defrag move to consume under the dma-resv lock. May
> > + * sleep/reclaim freely as it runs unlocked. A short fill is fine: the pool
> > + * falls back to in-line allocation for the shortfall. DMA-alloc pools are not
> > + * supported (count stays 0). Returns 0 (release with ttm_pool_prealloc_fini()).
> > + */
> > +int ttm_pool_prealloc_fill(struct ttm_pool *pool, enum ttm_caching tt_caching,
> > +			   struct ttm_pool_prealloc *pp, unsigned int count)
> > +{
> > +	unsigned int order = ttm_pool_beneficial_order(pool);
> > +	gfp_t gfp = ttm_pool_prealloc_gfp(pool);
> > +	struct page **cpages = NULL;
> > +	unsigned int ncpages = 0;
> > +	int r;
> > +
> > +	pp->pages = NULL;
> > +	pp->order = order;
> > +	pp->caching = tt_caching;
> > +	pp->count = 0;
> > +	pp->used = 0;
> > +
> > +	/* Nothing to gain without a beneficial order or for DMA-alloc pools. */
> > +	if (!order || !count || ttm_pool_uses_dma_alloc(pool))
> > +		return 0;
> > +
> > +	pp->pages = kvzalloc_objs(*pp->pages, count);
> > +	if (!pp->pages)
> > +		return 0;
> > +
> > +	/*
> > +	 * Every chunk is a fresh write-back system page of @order that needs a
> > +	 * caching change; collect their constituent pages into an unpacked
> > +	 * scratch array and issue a single set_pages_array_*() after the fill.
> > +	 * Cached tts need no change (and non-x86 handles caching at map time).
> > +	 */
> > +	if (IS_ENABLED(CONFIG_X86) && tt_caching != ttm_cached) {
> > +		cpages = kvzalloc_objs(*cpages, (size_t)count << order);
> > +		if (!cpages) {
> > +			kvfree(pp->pages);
> > +			pp->pages = NULL;
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	while (pp->count < count) {
> > +		struct page *p = ttm_pool_alloc_page(pool, gfp, order, false);
> > +
> > +		if (!p)
> > +			break;
> > +
> > +		pp->pages[pp->count++] = p;
> > +		if (cpages)
> > +			ttm_pool_prealloc_stage_caching(cpages, &ncpages, p,
> > +							order);
> > +	}
> > +
> > +	/*
> > +	 * Apply the requested caching to every collected page in one shot. On
> > +	 * failure the pages' caching is indeterminate, so drop the whole bag
> > +	 * (freeing restores write-back) and let the consumer allocate in-line.
> > +	 */
> > +	r = ttm_pool_prealloc_apply_caching(tt_caching, cpages, ncpages);
> > +	kvfree(cpages);
> > +	if (r) {
> > +		unsigned int i;
> > +
> > +		for (i = 0; i < pp->count; i++)
> > +			ttm_pool_free_page(pool, tt_caching, order,
> > +					   pp->pages[i], false);
> > +		pp->count = 0;
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(ttm_pool_prealloc_fill);
> > +
> > +/**
> > + * ttm_pool_prealloc_fini() - Release unconsumed preallocated pages
> > + * @pool: The pool the pages came from.
> > + * @pp: Prealloc bag to drain. Consumed pages (< @used) are now owned by the tt.
> > + */
> > +void ttm_pool_prealloc_fini(struct ttm_pool *pool, struct ttm_pool_prealloc *pp)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i = pp->used; i < pp->count; ++i)
> > +		ttm_pool_free_page(pool, pp->caching, pp->order, pp->pages[i],
> > +				   false);
> > +	kvfree(pp->pages);
> > +	pp->pages = NULL;
> > +	pp->count = 0;
> > +	pp->used = 0;
> > +}
> > +EXPORT_SYMBOL(ttm_pool_prealloc_fini);
> > +
> > /**
> >  * enum ttm_pool_iter_action - Outcome of a per-order allocation phase
> >  * @TTM_POOL_ITER_FILL: A page (@it->p) was acquired; proceed to fill it in.
> > @@ -975,6 +1152,7 @@ struct ttm_pool_alloc_iter {
> > 	struct ttm_pool_alloc_state *alloc;
> > 	struct ttm_pool_tt_restore *restore;
> > 	struct ttm_tt *defrag_old_tt;
> > +	struct ttm_pool_prealloc *prealloc;
> > 	unsigned int beneficial_order;
> > 	gfp_t gfp_flags;
> > 	bool defrag_capped;
> > @@ -990,16 +1168,20 @@ struct ttm_pool_alloc_iter {
> > };
> > 
> > /*
> > - * Defrag move budget exhausted: the upgrade can make no further progress this
> > - * pass. Snapshot @defrag_capped is set only when a byte budget was in force at
> > - * entry.
> > + * Defrag move budget exhausted, or the out-of-lock prealloc bag ran dry: the
> > + * upgrade can make no further progress this pass. Snapshot @defrag_capped is
> > + * set only when a byte budget was in force at entry.
> >  */
> > static bool ttm_pool_iter_defrag_exhausted(const struct ttm_pool_alloc_iter *it)
> > {
> > +	const struct ttm_pool_prealloc *pp = it->prealloc;
> > +
> > 	if (!it->defrag_old_tt)
> > 		return false;
> > +	if (it->defrag_capped && it->alloc->defrag_bytes_remaining <= 0)
> > +		return true;
> > 
> > -	return it->defrag_capped && it->alloc->defrag_bytes_remaining <= 0;
> > +	return pp && pp->count && pp->used >= pp->count;
> 
> Assisted-by: LLM
> 

Yes.

> Also, there is a sashiko reported issue here which suggests to dropping
> 'pp->count' check here. Though, we won't endup here with pp->count as 0 and even
> if we do it gets handled properly, it seems it is good to drop it so that it is
> explicitly handled.
> 

Yes, that is better. We actually handle this driver side in Xe but TTM
should handle this as well.

Matt

> Niranjana
> 
> > }
> > 
> > /*
> > @@ -1056,7 +1238,8 @@ static int ttm_pool_iter_reuse_old(struct ttm_pool_alloc_iter *it)
> > 		return TTM_POOL_ITER_FILL;
> > 
> > 	it->order = harvest_order;
> > -	r = ttm_pool_harvest_page(it->defrag_old_tt, it->order, off, it->alloc);
> > +	r = ttm_pool_harvest_page(it->defrag_old_tt, it->order,
> > +				  it->beneficial_order, off, it->alloc);
> > 	if (r)
> > 		return r;
> > 
> > @@ -1068,11 +1251,13 @@ static int ttm_pool_iter_reuse_old(struct ttm_pool_alloc_iter *it)
> > 
> > /*
> >  * Acquire a single page for the current order, leaving it in @it->p (NULL on
> > - * failure). Tries a same-order pool page, then a fresh system allocation. Fault
> > - * injection can force the beneficial-order paths to "fail".
> > + * failure). Tries, in order: a beneficial-order page preallocated outside the
> > + * dma-resv lock (defrag), a same-order pool page, then a fresh system
> > + * allocation. Fault injection can force the beneficial-order paths to "fail".
> >  */
> > static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
> > {
> > +	struct ttm_pool_prealloc *pp = it->prealloc;
> > 	struct ttm_pool_type *pt;
> > 
> > 	it->p = NULL;
> > @@ -1087,7 +1272,18 @@ static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
> > 		it->beneficial_order && it->order >= it->beneficial_order &&
> > 		should_fail(&beneficial_order_fault_inject, 1);
> > 
> > -	/* First, try to allocate a page from a pool if one exists. */
> > +	/*
> > +	 * Defrag move: consume a beneficial-order page preallocated outside the
> > +	 * dma-resv lock instead of allocating one in-line (which may stall in
> > +	 * reclaim/compaction). Falls through once the bag is empty.
> > +	 */
> > +	if (pp && !it->fail_beneficial && it->order >= it->beneficial_order &&
> > +	    pp->used < pp->count) {
> > +		it->order = it->beneficial_order;
> > +		it->p = pp->pages[pp->used++];
> > +		it->page_caching = it->tt->caching;
> > +	}
> > +
> > 	pt = ttm_pool_select_type(it->pool, it->page_caching, it->order);
> > 	if (!it->p && pt && it->allow_pools && !it->fail_beneficial)
> > 		it->p = ttm_pool_type_take(pt, ttm_pool_nid(it->pool));
> > @@ -1164,6 +1360,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > 		.alloc = alloc,
> > 		.restore = restore,
> > 		.defrag_old_tt = restore ? NULL : ctx->defrag_old_tt,
> > +		.prealloc = restore ? NULL : ctx->prealloc,
> > 		.beneficial_order = ttm_pool_beneficial_order(pool),
> > 		.page_caching = tt->caching,
> > 		.allow_pools = true,
> > @@ -1193,8 +1390,8 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > 	     alloc->remaining_pages;
> > 	     it.order = ttm_pool_alloc_find_order(it.order, alloc)) {
> > 		/*
> > -		 * Out of defrag budget: harvest the rest of the old tt as-is and
> > -		 * stop (the tt is re-queued if the remainder is still
> > +		 * Out of defrag budget/prealloc: harvest the rest of the old tt
> > +		 * as-is and stop (the tt is re-queued if the remainder is still
> > 		 * sub-optimal).
> > 		 */
> > 		if (ttm_pool_iter_defrag_exhausted(&it)) {
> > @@ -1211,7 +1408,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > 		if (r == TTM_POOL_ITER_RETRY)
> > 			continue;
> > 
> > -		/* Acquire a page (pool / system) for this order. */
> > +		/* Acquire a page (prealloc / pool / system) for this order. */
> > 		ttm_pool_iter_acquire_page(&it);
> > 		if (!it.p) {
> > 			r = ttm_pool_iter_lower_order(&it);
> > @@ -1243,6 +1440,8 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > 			alloc->defrag_bytes_remaining -=
> > 				(s64)(1UL << it.order) << PAGE_SHIFT;
> > 
> > +		if (it.order < it.beneficial_order)
> > +			alloc->nr_suboptimal_pages += 0x1 << it.order;
> > 		it.alloc_count++;
> > 	}
> > 
> > @@ -1306,6 +1505,9 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > 	/* Report the unused defrag budget back to the caller. */
> > 	ctx->defrag_bytes_remaining = alloc.defrag_bytes_remaining;
> > 
> > +	if (!ret)
> > +		tt->nr_suboptimal_pages = alloc.nr_suboptimal_pages;
> > +
> > 	return ret;
> > }
> > EXPORT_SYMBOL(ttm_pool_alloc);
> > @@ -1358,6 +1560,15 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > 
> > 			if (ret)
> > 				return ret;
> > +
> > +			/*
> > +			 * __ttm_pool_alloc() counts each freshly (re)allocated
> > +			 * chunk against nr_suboptimal_pages, but a chunk whose
> > +			 * backup copy was interrupted and is finished here
> > +			 * resumes past that loop, so account for it directly.
> > +			 */
> > +			if (restore->order < ttm_pool_beneficial_order(pool))
> > +				alloc.nr_suboptimal_pages += 1U << restore->order;
> > 		}
> > 		if (!alloc.remaining_pages) {
> > 			ret = ttm_pool_apply_caching(&alloc);
> > @@ -1367,11 +1578,16 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > 			kfree(tt->restore);
> > 			tt->restore = NULL;
> > 
> > +			tt->nr_suboptimal_pages = alloc.nr_suboptimal_pages;
> > 			return 0;
> > 		}
> > 	}
> > 
> > -	return __ttm_pool_alloc(pool, tt, ctx, &alloc, restore);
> > +	ret = __ttm_pool_alloc(pool, tt, ctx, &alloc, restore);
> > +	if (!ret)
> > +		tt->nr_suboptimal_pages = alloc.nr_suboptimal_pages;
> > +
> > +	return ret;
> > }
> > 
> > /**
> > diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> > index 6124d2627b47..a80304f179ba 100644
> > --- a/include/drm/ttm/ttm_bo.h
> > +++ b/include/drm/ttm/ttm_bo.h
> > @@ -237,6 +237,17 @@ struct ttm_operation_ctx {
> > 	 * @defrag_old_tt is set.
> > 	 */
> > 	s64 defrag_bytes_remaining;
> > +	/**
> > +	 * @prealloc: Pages preallocated outside the dma-resv lock for a defrag
> > +	 * move. The pool allocator consumes these instead of allocating fresh
> > +	 * beneficial-order pages under the lock, moving the (potentially
> > +	 * reclaim/compaction stalling) high-order allocations out of the
> > +	 * critical section. NULL means allocate in-line as usual. The pool
> > +	 * silently falls back to in-line allocation for any shortfall. The
> > +	 * allocator consumes it for beneficial-order chunks of any populate;
> > +	 * drivers only set it for a defrag move.
> > +	 */
> > +	struct ttm_pool_prealloc *prealloc;
> > 	/**
> > 	 * @resv: Reservation object to be used together with
> > 	 * @allow_res_evict.
> > diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
> > index 753203980e2c..71670350eb15 100644
> > --- a/include/drm/ttm/ttm_pool.h
> > +++ b/include/drm/ttm/ttm_pool.h
> > @@ -81,6 +81,35 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > 		   struct ttm_operation_ctx *ctx);
> > void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt);
> > 
> > +/**
> > + * struct ttm_pool_prealloc - Pages preallocated outside the dma-resv lock
> > + * @pages: Array of @count beneficial-order pages (or fewer if a fill fell
> > + *         short); each entry is the head page of a 1 << @order chunk.
> > + * @order: Page order of every preallocated chunk.
> > + * @caching: CPU caching applied to the pages, so leftovers can be restored
> > + *           to write-back before being freed.
> > + * @count: Number of valid entries in @pages.
> > + * @used: Number of entries already consumed by the pool allocator.
> > + *
> > + * Defrag pages are interchangeable, so only a count of beneficial-order chunks
> > + * is needed. ttm_pool_prealloc_fill() populates this outside the lock and
> > + * __ttm_pool_alloc() drains it; any unused tail is released by
> > + * ttm_pool_prealloc_fini().
> > + */
> > +struct ttm_pool_prealloc {
> > +	struct page **pages;
> > +	unsigned int order;
> > +	enum ttm_caching caching;
> > +	unsigned int count;
> > +	unsigned int used;
> > +};
> > +
> > +int ttm_pool_prealloc_fill(struct ttm_pool *pool, enum ttm_caching tt_caching,
> > +			   struct ttm_pool_prealloc *pp, unsigned int count);
> > +void ttm_pool_prealloc_fini(struct ttm_pool *pool,
> > +			    struct ttm_pool_prealloc *pp);
> > +unsigned int ttm_pool_prealloc_order(struct ttm_pool *pool);
> > +
> > void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
> > 		   int nid, unsigned int alloc_flags);
> > void ttm_pool_fini(struct ttm_pool *pool);
> > diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
> > index 55c35bcf134d..81a5446ca693 100644
> > --- a/include/drm/ttm/ttm_tt.h
> > +++ b/include/drm/ttm/ttm_tt.h
> > @@ -135,6 +135,12 @@ struct ttm_tt {
> > 	enum ttm_caching caching;
> > 	/** @restore: Partial restoration from backup state. TTM private */
> > 	struct ttm_pool_tt_restore *restore;
> > +	/**
> > +	 * @nr_suboptimal_pages: Number of pages backed below the pool's
> > +	 * beneficial order. Recorded by the pool allocator after populate; a
> > +	 * defrag pass reads it to size its out-of-lock preallocation exactly.
> > +	 */
> > +	u32 nr_suboptimal_pages;
> > };
> > 
> > /**
> > @@ -201,6 +207,17 @@ static inline bool ttm_tt_is_beneficial_order_failed(const struct ttm_tt *tt)
> > 	return tt->page_flags & TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
> > }
> > 
> > +/**
> > + * ttm_tt_suboptimal_pages() - Pages backed below the pool's beneficial order
> > + * @tt: The struct ttm_tt.
> > + *
> > + * Return: Number of pages a defrag move would (re)allocate at beneficial order.
> > + */
> > +static inline u32 ttm_tt_suboptimal_pages(const struct ttm_tt *tt)
> > +{
> > +	return tt->nr_suboptimal_pages;
> > +}
> > +
> > /**
> >  * ttm_tt_create
> >  *
> > -- 
> > 2.34.1
> > 
