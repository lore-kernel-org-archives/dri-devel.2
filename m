Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E99606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 21:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lWzcDFxP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Mmt+dI4y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BC4710E57C;
	Tue, 24 Nov 2026 21:08:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37FFD10E57C;
 Tue, 24 Nov 2026 21:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795554527; x=1827090527;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=fI6sSCexMYUBVnrvnF+PnHHgoKNQzpQCyjQml4Klmb8=;
 b=lWzcDFxP3Mz9GK3uuzvrnUYr/rbYmLnPRd81dWCynGtWG5gzcRGZfeOv
 tPDXJxJ/iHlDC19Yaq9ihPWF9A8d7OSzxF3PHHHv0zO8lOl0zBeIV3S/l
 6jDyxA5fjmpAzwCGASBLlRKMBb4MvjwB5biYjtgqMczi/3FEPa/5N7tkg
 VVNdYJnQHNOos6WlwEC1Tqyp9tPDI+Bjier+TGwgUtw3G/YKDu2mUjStw
 v/nMa+JyiyQmtyVST/ZncyFIS/IHgWSMErCxiEfDywhuljKJTk6pCz8ZX
 If0LTmkayl1JyhIPQ4rVSWnBpu/f9JlrrWL2+lzc6YbUPzeVeMtc46YGS g==;
X-CSE-ConnectionGUID: +6LfsP3+QvCSaRvOZWrYqA==
X-CSE-MsgGUID: vVpwyp2PT+C5e8W27fcf+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4471152"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4471152"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 13:08:47 -0800
X-CSE-ConnectionGUID: ppWaxRefQfKyzBbTUDnmvQ==
X-CSE-MsgGUID: yBt76Lt6TEiKBubVGuDbPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="12096264"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 13:08:46 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 13:08:45 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 13:08:45 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.54) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 13:08:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAUfOB6S7h38Qd2Z2zzC5GUYjSQEDA9L96x/XmxYAQ1AtnKjBHWJQYGOIOkxpBmRQCfuxLRY/Vke+mZKqF/nCU4vgrACSbeU04QC9y5pz9z4RAGdhA6shf6v56tYH14+cyvzqdKjeOgNQikZkLKQGc0HXOnJd4lH/yEqOVOlVS2XC32JPw+GMiT0RZq57CjQUvxxiVuBoyStRyI9bpWsyR2v0kOFEGc6nuYTSxwPwIVxWKxKZmM+7j0F4CkAyKMMVZCsOZxl+uiBIJLe0n31xr0l61VLGk6vGVH1qR40zunqcvSdl/Fw5TgkpT2CdUCNa2Od4ig/MClYhxcK4XV3zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7OF+zZZX+PosgMJIEANiHWv0WtQsBwnqqyZhkdnmnY=;
 b=TcECNv5DtcYDBEyPDxbK/MTqnXdvYI9TVre63YtEQP5WkhVfrxKtnqgSR4AWYHjhSyqWgbqeHFXoxOIL4hKlSZA8irMcH16T45jUc722/CSqgBJGFEjdQP0TIcUd0OEQy7s4xbW5OO2PgEvqhZCPGilXo+uLCKQPFmZfT3IAlyzyekyyuceL6ZTmrsnil+n600M7SaXByvpQyvi0fX+DsfHA7YQk4srfR775fowHQZmCU4G1dmUNLyA0z/z7rp/Q77DMeaHqvd8reXfU15Sp35DqZKrHOaMCtixNZERVY4gV0iPDrtTYkN9NxDwm1CxCWzq1Dpuojia/LquE/gTbGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7OF+zZZX+PosgMJIEANiHWv0WtQsBwnqqyZhkdnmnY=;
 b=Mmt+dI4y4UPOavT+2mWQ6Cm03HxjVEJ+FgAOcLuPsUkWACG787rPJLXNJdfmmZkaMPy+m+SWAeYE3Q6rVhoAPMA+QgOUiBI8XgjWGkIv4X69yaWc3BgHcwcHTNVVxhDjdFylPTvxAVuxGYcebtbQUUMZyYiK/HyyOxy2slfVEHw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by MW6PR11MB8310.namprd11.prod.outlook.com (2603:10b6:303:249::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 21:08:40 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 21:08:40 +0000
Date: Tue, 24 Nov 2026 13:08:37 -0800
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
Subject: Re: [PATCH v3 32/33] drm/xe: Finalize defrag-IOVA moves with
 post-copy job
Message-ID: <awX81cww2IB7Vf8b@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-33-matthew.brost@intel.com>
 <avfBNLDPLhl8_mkb@nvishwa1-desk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avfBNLDPLhl8_mkb@nvishwa1-desk>
X-ClientProxiedBy: BYAPR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::44) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|MW6PR11MB8310:EE_
X-MS-Office365-Filtering-Correlation-Id: b9299ef3-0929-403e-e2ac-08df4a6f1d80
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|10067099003|261102123227099003|261021121427099003|5023799004|11063799006|56012099006|4143699003|261022075727099003|261009223027099003|261026121527099003|261022105027099003|261021123027099003|261026140227099003|261028144727099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: X9yuYdPcxY43t8eRt1vGMzwUp4SbX4QgYGfXc0a0by8nDF3lVZdoYAD2adp/oInNCJyyxVKc+Joh1iE7GFdYtJWcxuwn7SfqmCALcFgbzgNfNPlQswLQuwzUWHdoFQnsUNFkcTog+tIU5KOZG/ttotEb+noi1mDMhBOb94BO6bIRGiCTIXphA6zaKpyY91Cp8xGRE0uE1FywR/87bQjmpEo7s+hEt0GZyfcYlndTLL4Qt0a+fF+3RT/5CMBuaeKV/7lX5ZXdxIzkhISdNdbCBk4U+V6czOp/x8ymcWkkiLr1Bv+KInbZRw6wg36p4Iqije9SoApCbwb+aQt5uH3Ylaf9kqM4Ov7RcqietOB3cYKLaxM7H9r4J3ZgNs1Cv7M9oNZsNjT+N6Ua2R+t4+HEVlTdBPVZzGrhQIZXemuYt3hRIgWMM60+dkx1Bp+YyipkHNtdV9lnaznp6vJbDfydTrErh3Uhv5naxQgsOFU1jOQeuEqqHZpdlBWN5ZHrsW5XJrfDi9oWgX08gd0huT/wHXVWUUsLj5b0eN6sjhVUroVK+CLs1P25/KdsdQ4T0xvea8FcoJLNqYHluTBWttNCDbATPl2IDd/SMfgzlRsEZh+ZZ3IRZn7KP2YGFcnKbsWIOgJxnbsIddbk2JGTcrbqU5YS6WeXSfpN7/y8U/WBtkM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10067099003)(261102123227099003)(261021121427099003)(5023799004)(11063799006)(56012099006)(4143699003)(261022075727099003)(261009223027099003)(261026121527099003)(261022105027099003)(261021123027099003)(261026140227099003)(261028144727099003)(18002099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ic5p442mY1jszAnrQeqCfih0CWEBtCw+7YG0PZPgzHulZxKXlXxbrUUHuk?=
 =?iso-8859-1?Q?RnuoBErx4VM/Ln2YjIlHJz/GxwnlTisflddiYKlGFsEex/TnUv6fVyzyYK?=
 =?iso-8859-1?Q?uCigD0OXBLDnefDX4mERC49TQC6YZMLaQiN9bNUPxDAzIYbW9l0/Q45DiJ?=
 =?iso-8859-1?Q?mr/6X+Jju2CHPC+zc79xz22X43neJfFbT7nn5tC7yHJjI/QYXtAskY/Eyj?=
 =?iso-8859-1?Q?dnhsQ20YEtQa2BKjDFnfRFMTb9+5Aev6Ok40nC3L+HkRoUpgM/y1TGpoNE?=
 =?iso-8859-1?Q?h4qJ2clLOzeBDC570ffLUMcnoWcSlYAO6RC42QizRN1Iw9mfqZL+N1aVm8?=
 =?iso-8859-1?Q?HARrBhgv86WZ5voKK/Y4n2T5EuXjO2UKxCv2fNkw9CWhdKw9h8kGQ0xe71?=
 =?iso-8859-1?Q?tL24iE30L8/Yhyt2mLjs67sO2ibwpoXlkiAj4IE/s/PttOsXM/LyeyNQRu?=
 =?iso-8859-1?Q?qCP3ohr2QuE2pPmw0w5Ckrci69gPHLgCJoDCN1GzManpz5Tp0y4iULjCBc?=
 =?iso-8859-1?Q?9seZJiB9QWiqQSZ1MoNWnylk9iQ7gf2hPyYQ2eXSuxi4tFpNUf5/ty2NGy?=
 =?iso-8859-1?Q?snl/kbhNf+Nw5pTAexVOI1Nl2IxYxaovJLFn7b0EscyJ/0ynggdRaJYkux?=
 =?iso-8859-1?Q?ss7T9s0tccB4f+qZYgcsaw9+QyfY36N0cY0lIfKuMWbd2SyPMuOgW7qLFS?=
 =?iso-8859-1?Q?Vm2XA7IFdmlMUsBRUVLW99m1m9KxPACpTb0lP2M42HJHG1rJZIPGN6llSq?=
 =?iso-8859-1?Q?VQfAwsU4P75xNiG3XobyqbR+igW99Z3chLTIKZvuayeaSQatx8f9SwINz/?=
 =?iso-8859-1?Q?8NM+yBd16g4hIMBuRp5e+qjoiQZPh4yBY+gnn/rJDhlc7AIVBq3TwfXYxn?=
 =?iso-8859-1?Q?IuwS3+1w9P1ianwCOsaG/mfBnqlOu7lVp0294ADWa+j3edrc1U94As+k8z?=
 =?iso-8859-1?Q?kx8U8iHjicqigqYppAI2ra8Of6MuU+ndtUfgHaMIOEJqaJe9TbrYz5g7Db?=
 =?iso-8859-1?Q?VqwyLiAPI5q98BOY7oQ5A+OUSpPHnD0IgJozCtPKyP3K6rq3LkvwfdYity?=
 =?iso-8859-1?Q?uEGS7DUTi4kFMxjB7n+lc2ColBVTrFT2BiOCyR+yn28hZejdmJQUEkjvup?=
 =?iso-8859-1?Q?4h7BYNZhgPIFtrLDaAC7s85do0ga2qDSKSO89jDf4KuVVXSuVaekNFNrdI?=
 =?iso-8859-1?Q?/Vw8AU05fDF+5nafHwXlNz3d1GR8b+R1IFH+yQ6fxHo/j/yPC03a4Zt8Lb?=
 =?iso-8859-1?Q?1qqtT/oVHuqvENRfVM+oaNCm92YB1i4jDIQ7CAYK8XLSMfY5IeCp56qSAC?=
 =?iso-8859-1?Q?9/C94M8aFZsfaeB6QiNfE4wZKcWAdXsXrZLoqhf2Y9wVrRm+T+yAoDqXXS?=
 =?iso-8859-1?Q?YM0jg3UAXzct8drSShWhXo3AdVIThRboU8MKDxaxRIqz0uXOBeHw8KmJKE?=
 =?iso-8859-1?Q?3CyUKLmY+rA/eX8QH1GQ7Si617HTM3QyyDDPqyfKrb1ks8LdGQKvv31HPE?=
 =?iso-8859-1?Q?IXmBaUYhMV5R7mIH78YTRo83Q0NTf8+JHKcBIg5mgs2wl2KXzPpXuhjY6A?=
 =?iso-8859-1?Q?hmlDSQ352GcILQypRydkt4pcPDFi29ryOH/A3gu4pgl/r3ZmhUUelKYZRe?=
 =?iso-8859-1?Q?8Kl8OJMT9hD7ZW9TffpR57zAtG9eWh+Uwk5U0fzdjYUW+1+k15XsJbf46Q?=
 =?iso-8859-1?Q?EneBwEqYQJUKdTM8H3QNkoiXIO9ZGcgP7BB45dHYeBoeo6a0P+/494dmJ7?=
 =?iso-8859-1?Q?xGv4ueLkFu2AvcPKWmaeBbKZowfncV7+06eK7hhA2hhVc5HM7RNx43fFTG?=
 =?iso-8859-1?Q?CPTgyKUL3P9vzZF81CKg/lHORbVrYH0=3D?=
X-Exchange-RoutingPolicyChecked: jKJTUnEVdCw4ebINgANn3n+e8dpKj7tgV2AfI233gsSmREf7dP7rBPEqhw+MU0DArePMkdHLmo4YxbnCk6ETK/QCD4XrESWH5tdQpRfOwWbqF1+schdcQR0uzTVGITTEn2ut6VNvKy5YPI16G4Rtf+lajb3d1Tl7DHgxBuqVUpWXkRN+qLGZSI15GTpNVQLPNw7Mt7L2814qhN5tUIyUSQU7Sjw9WtAATtMlsl2Dul0/BFxNIuqrEDYECn1CuxrN2a2tZ8xStLwcKr2fEj9NOo8CnFOC6Su8lVHCSgqdz031veR+pF1A/JhF0kKCLqYmglL6xy9+YGiXvYGFtqLRpA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b9299ef3-0929-403e-e2ac-08df4a6f1d80
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 21:08:40.7865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHuNns0RLGte1JLfLpJPQy6qJGAQ/8OLDoZayaodOVprYasSGssK8dDsaPCfoESUChuEPqclv2jUzSw9fYeTTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8310
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

On Fri, Nov 13, 2026 at 06:02:28PM -0800, Niranjana Vishwanathapura wrote:
> On Fri, Jul 10, 2026 at 07:56:18PM -0700, Matthew Brost wrote:
> > Wire up end-to-end defrag for IOVA-mapped BOs. A defrag move
> > is eligible whenever the destination TT is IOVA mapped. The
> > packed-copy step moves only changed pages; the IOVA reservation
> > is transferred to the new backing so device-visible addresses
> > are preserved, avoiding GPU rebind overhead.
> > 
> > Add xe_bo_defrag_use_iova() to select the IOVA defrag path.
> > Add xe_bo_defrag_iova_copy() to drive the move: diff new vs
> > stashed old TT, link changed pages packed, blit them, then
> > queue a post-copy finalize job.
> > 
> > The finalize job tears down the temporary packed mapping,
> > transfers the full old TT reservation to the new one, and
> > relinks the copied pages at natural offsets.
> > 
> > Borrowed pages skip the copy and simply adopt the old
> > reservation.
> > 
> > Since reservation transfer preserves device-visible addresses,
> > xe_bo_trigger_rebind() skips drm_gpuvm_bo_evict() marking;
> > GPU PTEs stay valid.
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
> > - Check dma_iova_sync(), wait the copy fence before unlink on error,
> >   and gate the fast path on old_tt->use_iova (Sashiko)
> > ---
> > drivers/gpu/drm/xe/xe_bo.c | 325 +++++++++++++++++++++++++++++++++++--
> > 1 file changed, 311 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> > index c087f17ad6db..36290f58ccc1 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -13,6 +13,7 @@
> > #include <drm/drm_dumb_buffers.h>
> > #include <drm/drm_gem_ttm_helper.h>
> > #include <drm/drm_managed.h>
> > +#include <drm/gpu_scheduler.h>
> > #include <drm/ttm/ttm_backup.h>
> > #include <drm/ttm/ttm_device.h>
> > #include <drm/ttm/ttm_placement.h>
> > @@ -25,6 +26,7 @@
> > #include <trace/events/gpu_mem.h>
> > 
> > #include "xe_device.h"
> > +#include "xe_dep_job_types.h"
> > #include "xe_dep_scheduler.h"
> > #include "xe_dma_buf.h"
> > #include "xe_drm_client.h"
> > @@ -542,7 +544,6 @@ static void xe_tt_unaccount_iova(struct xe_device *xe,
> >  * @xe_tt->iova_dma_pages[]. Used to (re)derive accounting that exactly matches
> >  * the pages a tt is actually mapped with.
> >  */
> > -__maybe_unused
> > static void xe_tt_account_iova_pages(struct xe_device *xe,
> > 				     struct xe_ttm_tt *xe_tt)
> > {
> > @@ -567,7 +568,6 @@ static void xe_tt_unaccount_iova(struct xe_device *xe,
> > {
> > }
> > 
> > -__maybe_unused
> > static void xe_tt_account_iova_pages(struct xe_device *xe,
> > 				     struct xe_ttm_tt *xe_tt)
> > {
> > @@ -806,7 +806,6 @@ struct xe_tt_iova_copy {
> >  * differ. Coalesce contiguous changed folios into runs and, for each run,
> >  * invoke @fn. Returns the total number of changed pages.
> >  */
> > -__maybe_unused
> > static pgoff_t xe_tt_iova_walk_changed(struct ttm_tt *new_tt,
> > 				       struct ttm_tt *old_tt,
> > 				       void (*fn)(pgoff_t start, pgoff_t count,
> > @@ -855,7 +854,6 @@ struct xe_tt_iova_run_collect {
> > };
> > 
> > /* Geometrically grow @arr (element size @elem) to hold at least @need slots. */
> > -__maybe_unused
> > static int xe_tt_iova_grow(void **arr, unsigned int *cap, unsigned int need,
> > 			   size_t elem)
> > {
> > @@ -878,7 +876,6 @@ static int xe_tt_iova_grow(void **arr, unsigned int *cap, unsigned int need,
> > 	return 0;
> > }
> > 
> > -__maybe_unused
> > static void xe_tt_iova_store_run(pgoff_t start, pgoff_t count, void *arg)
> > {
> > 	struct xe_tt_iova_run_collect *c = arg;
> > @@ -933,7 +930,6 @@ static void xe_tt_iova_store_run(pgoff_t start, pgoff_t count, void *arg)
> >  *
> >  * Return: 0 on success, -ENOMEM on allocation failure.
> >  */
> > -__maybe_unused
> > static int xe_tt_iova_copy_init(struct ttm_tt *new_tt, struct ttm_tt *old_tt,
> > 				struct xe_tt_iova_copy *copy)
> > {
> > @@ -969,7 +965,6 @@ static int xe_tt_iova_copy_init(struct ttm_tt *new_tt, struct ttm_tt *old_tt,
> >  * xe_tt_iova_copy_fini() - Release a struct xe_tt_iova_copy
> >  * @copy: The copy description to release.
> >  */
> > -__maybe_unused
> > static void xe_tt_iova_copy_fini(struct xe_tt_iova_copy *copy)
> > {
> > 	kfree(copy->runs);
> > @@ -1000,7 +995,6 @@ static void xe_tt_iova_copy_fini(struct xe_tt_iova_copy *copy)
> >  * Return: 0 on success, negative error code on failure (any partial linkage is
> >  * unwound).
> >  */
> > -__maybe_unused
> > static int xe_tt_map_iova_copy(struct xe_device *xe, struct ttm_tt *new_tt,
> > 			       const struct xe_tt_iova_copy *copy)
> > {
> > @@ -1047,6 +1041,133 @@ static int xe_tt_map_iova_copy(struct xe_device *xe, struct ttm_tt *new_tt,
> > 	return ret;
> > }
> > 
> > +/**
> > + * struct xe_iova_defrag_job - Post-copy finalize job for an IOVA defrag move.
> > + *
> > + * After the GPU defrag copy into the packed copy-step mapping completes, this
> > + * dependency job runs the CPU-side IOMMU fixups at the point of no failure:
> > + * tear down the temporary packed mapping, then per changed run unlink the old
> > + * pages and link the new pages into the (transferred) reservation at their
> > + * natural offset.
> > + */
> > +struct xe_iova_defrag_job {
> > +	/** @dep: base generic dependency Xe job. */
> > +	struct xe_dep_job dep;
> > +	/** @xe: The xe device. */
> > +	struct xe_device *xe;
> > +	/** @new_tt: The destination tt being finalized (owns the reservation). */
> > +	struct ttm_tt *new_tt;
> > +	/**
> > +	 * @copy_iova: Snapshot of the new tt's original IOVA reservation that
> > +	 * held the temporary packed copy-step mapping. Destroyed by the job
> > +	 * (the new tt itself adopts the old tt's reservation at job creation).
> > +	 */
> > +	struct dma_iova_state copy_iova;
> > +	/** @copy_bytes: Byte length of the packed copy-step mapping. */
> > +	size_t copy_bytes;
> > +	/** @copy: Changed-page description; the job owns and frees @copy.runs. */
> > +	struct xe_tt_iova_copy copy;
> > +};
> > +
> > +static struct dma_fence *xe_iova_defrag_job_run(struct xe_dep_job *dep_job)
> > +{
> > +	struct xe_iova_defrag_job *job =
> > +		container_of(dep_job, typeof(*job), dep);
> > +	struct xe_device *xe = job->xe;
> > +	struct device *dev = xe->drm.dev;
> > +	struct xe_ttm_tt *xe_tt =
> > +		container_of(job->new_tt, struct xe_ttm_tt, ttm);
> > +	unsigned int r, l;
> > +
> > +	/*
> > +	 * Tear down the temporary packed copy-step mapping and free its
> > +	 * reservation. The new tt has already adopted the old tt's full
> > +	 * reservation (transferred at job creation), so this only touches the
> > +	 * snapshot taken before the transfer.
> > +	 *
> > +	 * This mapping was the GPU blit's write destination, so tear it down
> > +	 * with attrs 0 (not DMA_ATTR_SKIP_CPU_SYNC): for non-coherent or
> > +	 * bounced (SWIOTLB) mappings the device->CPU copy-back / cache sync of
> > +	 * the freshly copied data happens during unlink, exactly as
> > +	 * xe_tt_unmap_iova() does. Skipping it would silently drop the
> > +	 * defragmented data on those configs.
> > +	 */
> > +	if (job->copy_bytes)
> > +		dma_iova_destroy(dev, &job->copy_iova, job->copy_bytes,
> > +				 DMA_BIDIRECTIONAL, 0);
> > +	else
> > +		dma_iova_free(dev, &job->copy_iova);
> > +
> > +	/*
> > +	 * For each changed run, unlink the old pages (still linked from the
> > +	 * adopted reservation).
> > +	 */
> > +	for (r = 0; r < job->copy.nr_runs; r++) {
> > +		size_t off = (size_t)job->copy.runs[r].start << PAGE_SHIFT;
> > +		size_t len = (size_t)job->copy.runs[r].count << PAGE_SHIFT;
> > +
> > +		dma_iova_unlink(dev, &xe_tt->iova, off, len,
> > +				DMA_BIDIRECTIONAL, DMA_ATTR_SKIP_CPU_SYNC);
> > +	}
> > +
> > +	/*
> > +	 * Relink the freshly copied new pages from the snapshot captured at job
> > +	 * creation. The destination tt's page array may have been mutated (or
> > +	 * torn down) by TTM since then, so it is never dereferenced here.
> > +	 * Borrowed pages are shared with the old tt and stay correctly linked
> > +	 * for free, so the snapshot only covers the changed runs.
> > +	 */
> > +	for (l = 0; l < job->copy.nr_links; l++) {
> > +		int ret = dma_iova_link(dev, &xe_tt->iova,
> > +					job->copy.links[l].phys,
> > +					job->copy.links[l].offset,
> > +					job->copy.links[l].len,
> > +					DMA_BIDIRECTIONAL,
> > +					DMA_ATTR_SKIP_CPU_SYNC);
> > +		/*
> > +		 * Point of no failure: the data is already copied and the
> > +		 * reservation ownership has been transferred. A relink failure
> > +		 * leaves a hole in the mapping; there is no safe recovery, so
> > +		 * just warn.
> > +		 */
> > +		drm_WARN_ON(&xe->drm, ret);
> > +	}
> > +
> > +	/* Sync the relinked changed runs into the device's view. */
> > +	for (r = 0; r < job->copy.nr_runs; r++) {
> > +		size_t off = (size_t)job->copy.runs[r].start << PAGE_SHIFT;
> > +		size_t len = (size_t)job->copy.runs[r].count << PAGE_SHIFT;
> > +
> > +		/*
> > +		 * Point of no failure (as with the relink above): warn on a
> > +		 * sync error so a stale IOMMU cache does not fail silently.
> > +		 */
> > +		drm_WARN_ON(&xe->drm, dma_iova_sync(dev, &xe_tt->iova, off, len));
> > +	}
> > +
> > +	/*
> > +	 * All work is synchronous CPU-side IOMMU fixup, so there is no hardware
> > +	 * fence to wait on; returning NULL makes the scheduler signal the job's
> > +	 * finished fence immediately.
> > +	 */
> > +	return NULL;
> > +}
> > +
> > +static void xe_iova_defrag_job_free(struct xe_dep_job *dep_job)
> > +{
> > +	struct xe_iova_defrag_job *job =
> > +		container_of(dep_job, typeof(*job), dep);
> > +
> > +	xe_tt_iova_copy_fini(&job->copy);
> > +	drm_sched_job_cleanup(&job->dep.drm);
> > +	kfree(job);
> > +}
> > +
> > +static const struct xe_dep_job_ops xe_iova_defrag_job_ops = {
> > +	.run_job = xe_iova_defrag_job_run,
> > +	.free_job = xe_iova_defrag_job_free,
> > +};
> > +
> > /*
> >  * xe_tt_iova_transfer - Transfer a full IOVA reservation old_tt -> new_tt.
> >  *
> > @@ -1063,7 +1184,6 @@ static int xe_tt_map_iova_copy(struct xe_device *xe, struct ttm_tt *new_tt,
> >  * folio walk of the new tt keeps xe->mem.dma_mapped_pages[] exact while the new
> >  * mapping lives, rather than carrying the old tt's stale distribution.
> >  */
> > -__maybe_unused
> > static void xe_tt_iova_transfer(struct xe_device *xe,
> > 				struct xe_ttm_tt *new_tt,
> > 				struct xe_ttm_tt *old_tt)
> > @@ -1078,6 +1198,154 @@ static void xe_tt_iova_transfer(struct xe_device *xe,
> > 	old_tt->use_iova = false;
> > }
> > 
> > +/*
> > + * xe_bo_defrag_iova_copy - Run an IOVA defrag move with a packed copy mapping.
> > + *
> > + * Only the changed (non-borrowed) pages of @new_tt are DMA mapped, packed
> > + * contiguously into the front of its reservation, the GPU copy blits them from
> > + * the old tt at natural offsets, and a post-copy finalize job adopts the old
> > + * tt's full reservation and relinks the changed runs. Returns the finalize
> > + * job's finished fence (the fence the move waits on), or an ERR_PTR on failure
> > + * with all partial state unwound.
> > + */
> > +static struct dma_fence *
> > +xe_bo_defrag_iova_copy(struct xe_device *xe, struct xe_migrate *migrate,
> > +		       struct xe_bo *bo, struct ttm_resource *old_mem,
> > +		       struct ttm_resource *new_mem, struct ttm_tt *old_tt,
> > +		       bool handle_system_ccs)
> > +{
> > +	struct ttm_tt *new_tt = bo->ttm.ttm;
> > +	struct xe_ttm_tt *new_xe_tt = container_of(new_tt, struct xe_ttm_tt, ttm);
> > +	struct xe_ttm_tt *old_xe_tt = container_of(old_tt, struct xe_ttm_tt, ttm);
> > +	struct drm_sched_entity *entity =
> > +		xe_dep_scheduler_entity(xe->mem.defrag.iova_sched);
> > +	struct xe_iova_defrag_job *job;
> > +	struct dma_fence *copy_fence;
> > +	struct dma_fence *fence;
> > +	struct xe_tt_iova_copy copy;
> > +	bool packed = false;
> > +	int err;
> > +
> > +	xe_assert(xe, new_xe_tt->use_iova && !new_xe_tt->iova_linked);
> > +	xe_assert(xe, old_xe_tt->use_iova && old_xe_tt->iova_linked);
> > +
> > +	err = xe_tt_iova_copy_init(new_tt, old_tt, &copy);
> > +	if (err)
> > +		return ERR_PTR(err);
> > +
> > +	if (copy.nr_changed) {
> > +		err = xe_tt_map_iova_copy(xe, new_tt, &copy);
> > +		if (err)
> > +			goto err_copy;
> > +		packed = true;
> > +
> > +		copy_fence = xe_migrate_copy_defrag_iova(migrate, bo, old_mem,
> > +							 new_mem, old_tt,
> > +							 copy.nr_changed,
> > +							 handle_system_ccs);
> > +	} else {
> > +		copy_fence = dma_fence_get_stub();
> > +	}
> > +	if (IS_ERR(copy_fence)) {
> > +		err = PTR_ERR(copy_fence);
> > +		goto err_unmap;
> > +	}
> > +
> > +	job = kzalloc(sizeof(*job), GFP_KERNEL);
> > +	if (!job) {
> > +		err = -ENOMEM;
> > +		goto err_fence;
> > +	}
> > +
> > +	job->dep.ops = &xe_iova_defrag_job_ops;
> > +	job->xe = xe;
> > +	job->new_tt = new_tt;
> > +	job->copy_iova = new_xe_tt->iova;
> > +	job->copy_bytes = (size_t)copy.nr_changed << PAGE_SHIFT;
> > +	job->copy = copy;
> > +
> > +	err = drm_sched_job_init(&job->dep.drm, entity, 1, NULL, 0);
> > +	if (err)
> > +		goto err_job;
> > +
> > +	err = drm_sched_job_add_dependency(&job->dep.drm,
> > +					   dma_fence_get(copy_fence));
> > +	if (err)
> > +		goto err_job_init;
> > +
> > +	/*
> > +	 * Point of no failure: transfer the old tt's full reservation to the
> > +	 * new tt. The finalize job (already armed below) destroys the packed
> > +	 * copy mapping snapshot and relinks the changed runs.
> > +	 */
> > +	xe_tt_iova_transfer(xe, new_xe_tt, old_xe_tt);
> 
> Assisted-by: LLM
> 
> We transfer the ownership here without waiting for blit to complete.
> Probbly we should wait for copy fence to complete?
> 

Most definitely not. This is an async pipeline, we don't block on
anything by design - blocking anywhere would break the entire design as
we'd miss page flips.

Here once we can't fail, we update the bookkeeping of the TTs so we can
immediately issue another async job behind this will the current one is
in flight.

> Niranjana
> 
> > +	memset(&copy, 0, sizeof(copy)); /* ownership moved to the job */
> > +
> > +	drm_sched_job_arm(&job->dep.drm);
> > +	fence = dma_fence_get(&job->dep.drm.s_fence->finished);
> > +	drm_sched_entity_push_job(&job->dep.drm);
> > +
> > +	dma_fence_put(copy_fence);
> > +
> > +	return fence;
> > +
> > +err_job_init:
> > +	drm_sched_job_cleanup(&job->dep.drm);
> > +err_job:
> > +	kfree(job);
> > +err_fence:
> > +	/*
> > +	 * The GPU copy into the packed destination mapping was already
> > +	 * submitted; it must finish before we tear that mapping down below,
> > +	 * otherwise the blit would fault or scribble on unmapped IOVA. (Reached
> > +	 * only with a valid, submitted copy_fence; the IS_ERR(copy_fence) case
> > +	 * jumps straight to err_unmap with no GPU work in flight.)
> > +	 */
> > +	if (packed)
> > +		dma_fence_wait(copy_fence, false);
> > +	dma_fence_put(copy_fence);
> > +err_unmap:
> > +	if (packed)
> > +		dma_iova_unlink(xe->drm.dev, &new_xe_tt->iova, 0,
> > +				(size_t)copy.nr_changed << PAGE_SHIFT,
> > +				DMA_BIDIRECTIONAL, DMA_ATTR_SKIP_CPU_SYNC);
> > +err_copy:
> > +	xe_tt_iova_copy_fini(&copy);
> > +	return ERR_PTR(err);
> > +}
> > +
> > +/*
> > + * xe_bo_defrag_use_iova - Whether a defrag move should use the packed IOVA path.
> > + *
> > + * Eligible when the move is a defrag (stashed old tt) and the destination tt is
> > + * IOVA mapped. The IOVA reservation is transferred to the new backing, so the
> > + * device-visible addresses are preserved and no GPU rebind is needed (see
> > + * xe_bo_trigger_rebind()); this makes the path worthwhile regardless of BO
> > + * size. A flat-CCS aux pass, if needed, is migrated packed alongside the data
> > + * (changed pages only), so it does not disqualify the path. Otherwise the
> > + * full-mapping defrag path is used.
> > + */
> > +static bool xe_bo_defrag_use_iova(struct ttm_buffer_object *ttm_bo)
> > +{
> > +	struct xe_ttm_tt *xe_tt, *old_xe_tt;
> > +
> > +	if (!ttm_bo->defrag_old_tt || !ttm_bo->ttm)
> > +		return false;
> > +
> > +	xe_tt = container_of(ttm_bo->ttm, struct xe_ttm_tt, ttm);
> > +	old_xe_tt = container_of(ttm_bo->defrag_old_tt, struct xe_ttm_tt, ttm);
> > +
> > +	/*
> > +	 * Both tts must be IOVA mapped: the packed copy reads the old tt's IOVA
> > +	 * and the finalize job transfers the old tt's reservation to the new
> > +	 * one. use_iova is a deterministic per-device decision taken at tt
> > +	 * creation, so for a given BO the old and new tt always agree; the
> > +	 * explicit old-tt check guards against ever routing a sg-fallback old
> > +	 * tt into xe_tt_iova_transfer() (which would copy an invalid iova).
> > +	 */
> > +	return xe_tt->use_iova && old_xe_tt->use_iova;
> > +}
> > +
> > /*
> >  * Account ttm pages against the device shrinker's shrinkable and
> >  * purgeable counts.
> > @@ -1357,6 +1625,7 @@ static int xe_bo_trigger_rebind(struct xe_device *xe, struct xe_bo *bo,
> > 	struct drm_gem_object *obj = &bo->ttm.base;
> > 	struct drm_gpuvm_bo *vm_bo;
> > 	bool idle = false;
> > +	bool defrag_iova;
> > 	int ret = 0;
> > 
> > 	dma_resv_assert_held(bo->ttm.base.resv);
> > @@ -1369,12 +1638,25 @@ static int xe_bo_trigger_rebind(struct xe_device *xe, struct xe_bo *bo,
> > 		dma_resv_iter_end(&cursor);
> > 	}
> > 
> > +	/*
> > +	 * A defrag move that reallocates IOVA-mapped backing preserves the
> > +	 * device-visible addresses: the IOVA reservation is transferred from
> > +	 * the old to the new tt, so the existing GPU PTEs stay valid and the
> > +	 * BO must not be marked evicted (the rebind paths in xe_exec_ioctl()
> > +	 * and preempt_rebind_work_func() would otherwise needlessly rebind).
> > +	 * Preempt fences still need to be triggered, and fault-mode / L2
> > +	 * flush-optimized configs still need a TLB invalidation below, so only
> > +	 * the eviction marking is skipped.
> > +	 */
> 
> The commit is bit confusing compared to the code below. Eviction marking is
> not completely skipped, it is only skipped when it is not needed. May be
> update the comment?
> 

I've read this a few times and it pretty clear to me.

Do you have different suggestion?

Matt

> Niranjana
> 
> > +	defrag_iova = xe_bo_defrag_use_iova(&bo->ttm);
> > +
> > 	drm_gem_for_each_gpuvm_bo(vm_bo, obj) {
> > 		struct xe_vm *vm = gpuvm_to_vm(vm_bo->vm);
> > 		struct drm_gpuva *gpuva;
> > 
> > 		if (!xe_vm_in_fault_mode(vm)) {
> > -			drm_gpuvm_bo_evict(vm_bo, true);
> > +			if (!defrag_iova)
> > +				drm_gpuvm_bo_evict(vm_bo, true);
> > 			/*
> > 			 * L2 cache may not be flushed, so ensure that is done in
> > 			 * xe_vm_invalidate_vma() below
> > @@ -1394,6 +1676,8 @@ static int xe_bo_trigger_rebind(struct xe_device *xe, struct xe_bo *bo,
> > 			if (!ctx->no_wait_gpu &&
> > 			    !xe_vm_flush_vm_bo_tlb_async(vm, bo, vm_bo))
> > 				continue;
> > +			else if (defrag_iova)
> > +				drm_gpuvm_bo_evict(vm_bo, true);
> > 		}
> > 
> > 		if (!idle) {
> > @@ -2120,6 +2404,7 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> > 	bool needs_clear;
> > 	bool handle_system_ccs = (!IS_DGFX(xe) && xe_bo_needs_ccs_pages(bo) &&
> > 				  ttm && ttm_tt_is_populated(ttm)) ? true : false;
> > +	bool defrag_iova = xe_bo_defrag_use_iova(ttm_bo);
> > 	int ret = 0;
> > 
> > 	/*
> > @@ -2168,7 +2453,12 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> > 	needs_clear = (ttm && ttm->page_flags & TTM_TT_FLAG_ZERO_ALLOC) ||
> > 		(!ttm && ttm_bo->type == ttm_bo_type_device);
> > 
> > -	if (new_mem->mem_type == XE_PL_TT) {
> > +	/*
> > +	 * For a defrag move using the packed IOVA path the destination tt is
> > +	 * not fully mapped here; only the changed pages are mapped (packed) for
> > +	 * the copy, and the finalize job establishes the full mapping.
> > +	 */
> > +	if (new_mem->mem_type == XE_PL_TT && !defrag_iova) {
> > 		ret = xe_tt_map(xe, ttm);
> > 		if (ret)
> > 			goto out;
> > @@ -2278,9 +2568,16 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> > 
> > 		fence = xe_migrate_clear(migrate, bo, new_mem, flags);
> > 	} else if (ttm_bo->defrag_old_tt) {
> > -		fence = xe_migrate_copy_defrag(migrate, bo, old_mem, new_mem,
> > -					       ttm_bo->defrag_old_tt,
> > -					       handle_system_ccs);
> > +		if (defrag_iova)
> > +			fence = xe_bo_defrag_iova_copy(xe, migrate, bo, old_mem,
> > +						       new_mem,
> > +						       ttm_bo->defrag_old_tt,
> > +						       handle_system_ccs);
> > +		else
> > +			fence = xe_migrate_copy_defrag(migrate, bo, old_mem,
> > +						       new_mem,
> > +						       ttm_bo->defrag_old_tt,
> > +						       handle_system_ccs);
> > 	} else {
> > 		fence = xe_migrate_copy(migrate, bo, bo, old_mem, new_mem,
> > 					handle_system_ccs);
> > -- 
> > 2.34.1
> > 
