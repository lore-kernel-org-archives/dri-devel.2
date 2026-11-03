Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC148606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B8KkBwXX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41D2010F80F;
	Tue,  3 Nov 2026 20:08:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B78AE10F808;
 Tue,  3 Nov 2026 20:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793736516; x=1825272516;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=otMQNZeOnVb0zahjcSN9opFKxhALhjI3S9E/F+vcppU=;
 b=B8KkBwXXD+WYv0dBjHD3v/5eqfRk2c7popSeO1g9mGoaQg2rQCJGbAzY
 NtgoIV+ZaYYzbIsnxjSkAvWQNZiuv42agIxf916UNXNHnM32Oq9+IIrnP
 8YiQHI/ktgB448h+0bUDgyf59ImzDD+h9LBBbpVWTNpMpJ2V+S+Gh4LQ6
 IpdZa8rrA8P3rE8sf2wAn421MapcLui6QatNeRGdDU3qMltz2ObGRxt7f
 IgJQ/r4Q0Yv7CK/HAXxxgbqOzYnRl4++ciDAztOlr81scvnwpSFoJRGzE
 C4kf/S0SIMY/ykqxWs5OPrjhVv7Ih3ytWmHlO/iuFXcm3W+IOb/HahQB7 w==;
X-CSE-ConnectionGUID: HKpZvAL+TKiSoKp1KABf+Q==
X-CSE-MsgGUID: bp/l95EJSO6/iyplNTivzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2508285"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2508285"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 12:08:36 -0800
X-CSE-ConnectionGUID: Gy48LlHqTZq0ycm534Y5iA==
X-CSE-MsgGUID: rvFC3EpNR5emzjaLhl1vOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6896323"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 12:08:35 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 12:08:34 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 12:08:34 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.69) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 12:08:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZT2GVyvEhtJsDEL6WX+oANdwZ1f8RQnnjyFcdKhnxrEUsj1tbqS3zhaAqmpe8JCyGyTIIYVELqeYcRokloPeYzsqcPXlQPuP15siDmjfQcBg81JaAbk/qsOhegaeWqnyIlTICHaz6lFuntUf8VpVpecqFLPJ0uS2cBglbOTlVGRAAx14qyS8NyYhs3ywsMRnsiDQXijFcHRtHRXK6Kh2e7w8CkihYAShukUsTziiuPthKy8XpVR5Oa54LdFjkZi/5a/ed2zmV5KRBEFbBJcPxIchg7fgn7J1GojDU73ARSmrG9cAk/y3EiSzry9LIiQ+wyOnR0fduyFNu+5VUmIpWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78EfQ2NqGwHyCitxXvw/rass+giBVeKKloSo1xFJg44=;
 b=kV2TSM5SeQM9lqCJ653gb+yeOprgPR748bEmTM0lnAbljfdoopbLByOfdjqnimSeSheVttFiZ6DmKvJeIJNEJlsah4+/9W8w0Ui1XlT8y0MiMFfEhlOIRkkyehFSWhivjCYf0UQDJIbJZpgeWVG84FsLu6JHYgNmYqXcOolo3KCzE+X7IMzgBRHRTAfdoh7v9oVnbDuuFSR4/wCE7XR03tWxyc/PmOfi0TVRQZWfMxSD9ms8ZrKR12TTURwpdKZNT3YhLIW2AVtluV2r0EvTCBE4szBH6vgrROtXLi7Ax+6zIAswpX2YOYXvYsZilaQR/zf85uFAOzrnyv2672NsDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by PH7PR11MB8501.namprd11.prod.outlook.com (2603:10b6:510:308::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 20:08:15 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 20:08:15 +0000
Date: Tue, 3 Nov 2026 12:08:13 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <linux-kernel@vger.kernel.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 17/33] drm/xe: Add xe_migrate_copy_defrag() for on-GPU
 defrag copies
Message-ID: <auo/Lc103kibONZC@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-18-matthew.brost@intel.com>
 <3bc563bf-9692-4611-a85a-9e21d43373c9@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3bc563bf-9692-4611-a85a-9e21d43373c9@intel.com>
X-ClientProxiedBy: MW4PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:303:b7::24) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|PH7PR11MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f3fc2e-bd30-45f5-1802-08df39e631cd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|22082099003|18002099003|4143699003|11063799006|56012099006|3023799007|261009223027099003|261028144727099003|261026140227099003|261026121527099003|261102123227099003|261021123027099003|261021121427099003|261022105027099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: FElMugxVU/p9dOxZoaNBbliOQ+L4q+f/DUEFUd/XwZvjuAhyFPKU/XmMBE1BXC24qbOQWKqVcgoYkqkgpKIv9r2prJ0hV2nWHR+/ECpX5Ihu1mYjWPbWORMPPISCpXmMTPLDEV3pcR401JUnREB8OPQOjLH8i8RVht+ieF6Ntx5FfuGgtMF18l3DUYR1KxwGkzzY0N5H717wHJj7lSXMqDAojcjEBvO1hqgZDrHLGMngI+Q0a/5qKlgC3nx2moFVINydwhAXqcIHLfY0Jkem6fIviMc8wkGh+m5mp7eREjA37fmVweKuO1XdN4f8omHiiLM8u617HWf/BWws732cb41lacRUk0b2WqCCPsuF1LsWOD8B0NjAqsptzo66YS+YJKBOwNG0k7WU6jUZWTqnK1JqU1PCK2Z6cxd38yv8TLV8/8YObqUKYkkC1zjTGhXt/0OSZ+9bbYOquaGu3x9wVnZDmCbLtElpEt/IOGYsSa9IoJqj2/WL+IpkbvTsHCgD8V2UwzdNu/337Jtyht2klAnP9OYBSJs1wl8pTlpzjyVdl4awnx95oB216wluW4Miz3vcU/itWOuJtNG2F+PlBbyEgGMlNSjvJCFB4+um+LY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(3023799007)(261009223027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261102123227099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?lxV2bAniicHlUogEBdq2Y4QRh7xxosq2q0rZEDkXPbw1x/A40wchSTH+Mi?=
 =?iso-8859-1?Q?yrg1YPFpQo++N5j/q54FdI3wc4iJqVnm+0shBUpCJ0Jt9RRnYZE4AmEoaj?=
 =?iso-8859-1?Q?fjQ/yLGp59oCgPFJOJmAzMTkHHC5RHcTQ3kFoldt3Hz8tXQD7+vE6lE8bV?=
 =?iso-8859-1?Q?ob4MQJyY96Oxv9RzCsx1wp5k2GaUpINt/2VyO8oRyFMsd5weYi+oaPhncE?=
 =?iso-8859-1?Q?4UkArcPDUFa6ey+L+V3/kSSdHygsc/DXnW2qW6Z/Sod+T6fRN6hLLPyrFH?=
 =?iso-8859-1?Q?cptSHF4N3n+AJljiJ/XYxdFHDKOMPdBlfXZ/idJ8FAT443KMUJ8nPNvwYr?=
 =?iso-8859-1?Q?olTRTSKsxCiARUTD1VLvU0zp9UwkWrnbEpFfXl5usqOkFrOYq0Ey734Aur?=
 =?iso-8859-1?Q?e9n+KJyH6mRYWah1VFt+4pPIhEybj61EZvq/n7zPuxFubBakJzDF6u/ihv?=
 =?iso-8859-1?Q?C6xW554obdPiD5khXvXh8IhZkAcg5tk8lNP4aT51dsigCZPyzoSCKsE9oh?=
 =?iso-8859-1?Q?i5S68SOW/1kxDC5rla8KyUt+0ENGtAgnlGn3wijPxyRZJbxnFXVF34KI9z?=
 =?iso-8859-1?Q?iUofpe9M1/SusKiSMHmpeVD47pIIEJChuc+bmOTULbAUSjohEauZoVdN39?=
 =?iso-8859-1?Q?+6/QrfK8w8Bb3NWPullGCIHUQ9RlKlKshqMv0H05VFBshNfyVRfHuPABEZ?=
 =?iso-8859-1?Q?wp17Is7uvFYQlpLFz2ROWuIUJIY80RJIjeuthU6Jr2DrNXhhS2tnbAdI+P?=
 =?iso-8859-1?Q?QOzQBF/kqK1PlUHf6V07o/RAN2dA7cLJL2TihIz37VtJTc+xsC7pTZ8YSc?=
 =?iso-8859-1?Q?jWlWHYKEEaeuw0zwITROTchZ7vltaHKuyY9wPc7uQCdH4GTKkhu7I1qRi+?=
 =?iso-8859-1?Q?/UMiN+D+sNwEugRs3GmcUX+myTzKoULIsnI4xP84aJ/W3z38tmCGECMGIp?=
 =?iso-8859-1?Q?X2ribK+6ctJMfRf6yiuwK6sJ4Ox+t0OA9OiZCXsG8n7Hn1bgzO9GHetRyR?=
 =?iso-8859-1?Q?z/IkiG6hsrRJGCfg4+voCIMJldeS4IEbL8YBGuYvcx+HBUV+xe/8sKBVz1?=
 =?iso-8859-1?Q?4rfI2dVl8CRSLF0VYDE7tKoYU/JhYwXMJqcFzb+Y9brSxSWDuiiFbX5Jxl?=
 =?iso-8859-1?Q?DLWfQd54j10BdQKF6Al/kmQtFA9soiU8mIiMgP1N121KDZ+I5vMcQA9MHU?=
 =?iso-8859-1?Q?sbl3MGAT3kmwEEkgJMHIW5mVpWn61T+aBzS58L6Y040jweoTwxFmMJl9W4?=
 =?iso-8859-1?Q?zy5gAt1R+rfoAexNZyZa1Gwf7gO3cVNWc1w7sWAaLjCrhSmOGFGoeNlDbZ?=
 =?iso-8859-1?Q?Wr7tVweXZIDtKv0LCuuDWw6o/CcyeKY+rlpgeiXqOIenvYk35FXMiKvYIo?=
 =?iso-8859-1?Q?zO7XY7ROobdfxAI0UW2TsyXMR+QSldi7LPq0VlSYxF2oS/mStsbB6g4acP?=
 =?iso-8859-1?Q?qx6xwgZjTSKFgTEE7okO8VnpF/6j7w7ZutWng9bRHfNZ7ELhmLFNawKDdf?=
 =?iso-8859-1?Q?8PJMtNi2wtynk84l/Dx5GyfVnuQw31jcOwnjbszzfHGJ6hozfhIUAqdREw?=
 =?iso-8859-1?Q?f8pgnKGtShezxuizc4Aw5ySl+Aay7SSQRXldx8XHt+pa0mtDcz7XxkxlgZ?=
 =?iso-8859-1?Q?NovMf3B0da7LRx3a+L2kJNMLDkJztKWH4EjYS5wcpTsEysoBEw8mnp3wMg?=
 =?iso-8859-1?Q?YKGYEHVpJtnVj1XxOarFBjIfAH8QsYIJ37MWTopR7tVVKbSwivglJ+eoPY?=
 =?iso-8859-1?Q?F6xlZXInLYBf4Hp+5VNwYB4UUNHt35hiKuHVwRYkdnVdKNwncNiExb4hxn?=
 =?iso-8859-1?Q?tO/uK3PiYQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: hEJA2obKV4aQKHz7GKZZ5PaU+AXifYZ9HLMmaSC7V+lBsKKGOQjYn0wa+Fw1bnpfVedxoj2ALtavsTYfcqmWADjXS3+l9sKmLUKBQejWbsCsuebG+9+qCEsaqJKLNBaw09a760Bp4hSeAutBW9UKqNIVZ1Mv85R998fA1qXqYUPbe4pO48s1MlLKdXkrMMlt0vICzEBbqimX/6hba2Tb/A8aDGx7F0/ODvLv+wzzLG6LpS/Zvr3VjZJkaA+ANuuCHqUfm/h2FFQnS0QPqvmwer98tnYnVzVNk1rmqG2R8ss2j7GjjYWXLPuiGNiJUiM4r1HKt/xcjEMUaGYZHNjGcg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f3fc2e-bd30-45f5-1802-08df39e631cd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 20:08:15.3740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGRD1h11J6cPDwpoAcqgth+t6zQrISxREi2FXZ0TT6jr5Cvlce4whTkpnage207UHHcx9FRITpQ8LBf+qHNIYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8501
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

On Tue, Nov 03, 2026 at 12:58:39PM +0000, Matthew Auld wrote:
> On 11/07/2026 03:56, Matthew Brost wrote:
> > Add xe_migrate_copy_defrag(), a copy helper for the upcoming page
> > defragmentation path where a single BO has its backing reallocated at a
> > more beneficial page order and its contents must be relocated from the
> > old pages to the new ones entirely on the GPU.
> > 
> > The contents are relocated in up to two passes:
> > 
> >   - Data pass (always): copy the data pages verbatim. The pages are
> >     mapped without the compression PAT, so the (possibly compressed)
> >     bytes are copied as-is rather than being decompressed and
> >     recompressed, and no CCS aux copy is appended.
> > 
> >   - CCS pass (need_ccs): copy the CCS aux (compression) state. Both the
> >     old and new data pages are mapped with the compression PAT so the
> >     copy engine accesses the aux state indirectly, issuing one
> >     indirect -> indirect XY_CTRL_SURF_COPY_BLT; the data blit is skipped.
> 
> 
> Just to double check, there were no issues with this flow for a compressed
> surface? Not 100% sure if reading from the src with uncompressed PAT will
> zero out the CCS state (update to uncompressed status), such that when you
> do the CCS pass it is already gone. Quite sure it does that for a write, but
> I guess not for a read, so we are fine here?
> 

This isn't my area of expertise, but IIRC I spun on this patch several
times before I finally got it right. In my first few attempts, when I
ran something like 3DMark Wildlife Extreme or WebGL applications that
would trigger the defragmenter, I could see visual corruption on the
screen (i.e., the buffers were clearly being corrupted). I eventually
landed on the approach detailed here and have not seen any visual issues
since. So I think the reads without the compressed PAT are fine, at
least on PTL.

I also have a local update to [1] where I use the compressed PAT, and
the tests seem to pass. I can post an update to this test shortly.

Matt

[1] https://patchwork.freedesktop.org/patch/739244/?series=169723&rev=2

> > 
> > The two passes are issued separately because they require opposite
> > compression PAT settings on the data page mappings (cleared for the
> > verbatim data copy, set for the indirect CCS access), which a single
> > mapping cannot satisfy. Both passes run in order on the same migrate
> > queue and are captured by the returned fence.
> > 
> > The source pages are passed explicitly via an sg_table argument (the
> > old, still populated backing) since they no longer match the BO's
> > current backing. The boolean arguments to __xe_migrate_copy() are folded
> > into struct xe_migrate_copy_flags to keep the growing set of copy
> > variants readable.
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
> >   drivers/gpu/drm/xe/xe_migrate.c | 136 ++++++++++++++++++++++++++++----
> >   drivers/gpu/drm/xe/xe_migrate.h |   8 ++
> >   2 files changed, 128 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
> > index 92d5e81ceac2..305c6e1942fb 100644
> > --- a/drivers/gpu/drm/xe/xe_migrate.c
> > +++ b/drivers/gpu/drm/xe/xe_migrate.c
> > @@ -858,13 +858,39 @@ static u32 xe_migrate_ccs_copy(struct xe_migrate *m,
> >   	return flush_flags;
> >   }
> > +/**
> > + * struct xe_migrate_copy_flags - Flags for __xe_migrate_copy()
> > + * @copy_only_ccs: Only copy the CCS aux state, aliasing the destination data
> > + * mapping to the source (used when the data pages are shared between src/dst).
> > + * @is_vram_resolve: Decompression (VRAM -> system) resolve; always uses the
> > + * compression PAT index for the data copy.
> > + * @defrag_ccs: Defrag move pass that migrates only the CCS aux state between
> > + * two distinct page sets (old @src_sg pages -> new pages). The data blit is
> > + * skipped (the data was copied by the @defrag_copy pass) and both the source
> > + * and destination data pages are mapped with the compression PAT so the aux
> > + * state is copied indirect -> indirect.
> > + * @defrag_copy: Defrag move pass that copies the data pages between two
> > + * distinct page sets (old @src_sg pages -> new pages) without touching the CCS
> > + * aux state. The data pages are mapped without the compression PAT so the
> > + * (possibly compressed) bytes are copied verbatim rather than being
> > + * decompressed and recompressed, and no CCS aux copy is appended; the aux
> > + * state is migrated separately by the @defrag_ccs pass. The two passes need
> > + * opposite compression PAT settings, which is why they cannot be combined.
> > + */
> > +struct xe_migrate_copy_flags {
> > +	u32 copy_only_ccs : 1;
> > +	u32 is_vram_resolve : 1;
> > +	u32 defrag_ccs : 1;
> > +	u32 defrag_copy : 1;
> > +};
> > +
> >   static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> >   					   struct xe_bo *src_bo,
> >   					   struct xe_bo *dst_bo,
> >   					   struct ttm_resource *src,
> >   					   struct ttm_resource *dst,
> > -					   bool copy_only_ccs,
> > -					   bool is_vram_resolve)
> > +					   struct sg_table *src_sg,
> > +					   struct xe_migrate_copy_flags flags)
> >   {
> >   	struct xe_gt *gt = m->tile->primary_gt;
> >   	struct xe_device *xe = gt_to_xe(gt);
> > @@ -881,20 +907,29 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> >   	bool src_is_vram = mem_type_is_vram(src->mem_type);
> >   	bool dst_is_vram = mem_type_is_vram(dst->mem_type);
> >   	bool type_device = src_bo->ttm.type == ttm_bo_type_device;
> > -	bool needs_ccs_emit = type_device && xe_migrate_needs_ccs_emit(xe);
> > +	bool needs_ccs_emit = type_device && xe_migrate_needs_ccs_emit(xe) &&
> > +		!flags.defrag_copy;
> >   	bool copy_ccs = xe_device_has_flat_ccs(xe) &&
> > -		xe_bo_needs_ccs_pages(src_bo) && xe_bo_needs_ccs_pages(dst_bo);
> > -	bool copy_system_ccs = copy_ccs && (!src_is_vram || !dst_is_vram);
> > +		xe_bo_needs_ccs_pages(src_bo) && xe_bo_needs_ccs_pages(dst_bo) &&
> > +		!flags.defrag_copy;
> > +	bool copy_system_ccs = copy_ccs && (!src_is_vram || !dst_is_vram) &&
> > +		!flags.defrag_ccs && !flags.defrag_copy;
> >   	/*
> >   	 * For decompression operation, always use the compression PAT index.
> >   	 * Otherwise, only use the compression PAT index for device memory
> >   	 * when copying from VRAM to system memory.
> >   	 */
> > -	bool use_comp_pat = is_vram_resolve || (type_device &&
> > +	bool use_comp_pat = flags.is_vram_resolve || (type_device &&
> >   			    xe_device_has_flat_ccs(xe) &&
> >   			    GRAPHICS_VER(xe) >= 20 && src_is_vram && !dst_is_vram);
> > +	/*
> > +	 * The defrag CCS pass migrates the aux state from the old pages
> > +	 * (@src_sg) to the new pages with both sides accessed indirectly, so
> > +	 * keep both src_is_pltt and dst_is_pltt set (no direct staging side).
> > +	 */
> > +
> >   	/* Copying CCS between two different BOs is not supported yet. */
> >   	if (XE_WARN_ON(copy_ccs && src_bo != dst_bo))
> >   		return ERR_PTR(-EINVAL);
> > @@ -903,7 +938,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> >   		return ERR_PTR(-EINVAL);
> >   	if (!src_is_vram)
> > -		xe_res_first_sg(xe_bo_sg(src_bo), 0, size, &src_it);
> > +		xe_res_first_sg(src_sg ? src_sg : xe_bo_sg(src_bo), 0, size, &src_it);
> >   	else
> >   		xe_res_first(src, 0, size, &src_it);
> >   	if (!dst_is_vram)
> > @@ -912,7 +947,8 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> >   		xe_res_first(dst, 0, size, &dst_it);
> >   	if (copy_system_ccs)
> > -		xe_res_first_sg(xe_bo_sg(src_bo), xe_bo_ccs_pages_start(src_bo),
> > +		xe_res_first_sg(src_sg ? src_sg : xe_bo_sg(src_bo),
> > +				xe_bo_ccs_pages_start(src_bo),
> >   				PAGE_ALIGN(xe_device_ccs_bytes(xe, size)),
> >   				&ccs_it);
> > @@ -942,7 +978,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> >   		batch_size += pte_update_size(m, pte_flags, src, &src_it, &src_L0,
> >   					      &src_L0_ofs, &src_L0_pt, 0, 0,
> >   					      avail_pts);
> > -		if (copy_only_ccs) {
> > +		if (flags.copy_only_ccs) {
> >   			dst_L0_ofs = src_L0_ofs;
> >   		} else {
> >   			pte_flags = dst_is_vram ? PTE_UPDATE_FLAG_IS_VRAM : 0;
> > @@ -963,7 +999,8 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> >   		}
> >   		/* Add copy commands size here */
> > -		batch_size += ((copy_only_ccs) ? 0 : emit_copy_cmd_len(xe)) +
> > +		batch_size += ((flags.copy_only_ccs || flags.defrag_ccs) ? 0 :
> > +			       emit_copy_cmd_len(xe)) +
> >   			((needs_ccs_emit ? EMIT_COPY_CCS_DW : 0));
> >   		bb = xe_bb_new(gt, batch_size, usm);
> > @@ -975,13 +1012,15 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> >   		if (src_is_vram && xe_migrate_allow_identity(src_L0, &src_it))
> >   			xe_res_next(&src_it, src_L0);
> >   		else
> > -			emit_pte(m, bb, src_L0_pt, src_is_vram, copy_system_ccs || use_comp_pat,
> > +			emit_pte(m, bb, src_L0_pt, src_is_vram,
> > +				 copy_system_ccs || use_comp_pat || flags.defrag_ccs,
> >   				 &src_it, src_L0, src);
> >   		if (dst_is_vram && xe_migrate_allow_identity(src_L0, &dst_it))
> >   			xe_res_next(&dst_it, src_L0);
> > -		else if (!copy_only_ccs)
> > -			emit_pte(m, bb, dst_L0_pt, dst_is_vram, copy_system_ccs,
> > +		else if (!flags.copy_only_ccs)
> > +			emit_pte(m, bb, dst_L0_pt, dst_is_vram,
> > +				 copy_system_ccs || flags.defrag_ccs,
> >   				 &dst_it, src_L0, dst);
> >   		if (copy_system_ccs)
> > @@ -990,7 +1029,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> >   		bb->cs[bb->len++] = MI_BATCH_BUFFER_END;
> >   		update_idx = bb->len;
> > -		if (!copy_only_ccs)
> > +		if (!flags.copy_only_ccs && !flags.defrag_ccs)
> >   			emit_copy(gt, bb, src_L0_ofs, dst_L0_ofs, src_L0, XE_PAGE_SIZE);
> >   		if (needs_ccs_emit)
> > @@ -1078,7 +1117,69 @@ struct dma_fence *xe_migrate_copy(struct xe_migrate *m,
> >   				  struct ttm_resource *dst,
> >   				  bool copy_only_ccs)
> >   {
> > -	return __xe_migrate_copy(m, src_bo, dst_bo, src, dst, copy_only_ccs, false);
> > +	return __xe_migrate_copy(m, src_bo, dst_bo, src, dst, NULL,
> > +				 (struct xe_migrate_copy_flags) {
> > +					 .copy_only_ccs = copy_only_ccs,
> > +				 });
> > +}
> > +
> > +/**
> > + * xe_migrate_copy_defrag() - Migrate a BO's backing to a reallocated page set.
> > + * @m: The migration context.
> > + * @bo: The buffer object being defragmented. Both @src and @dst belong to @bo.
> > + * @src: The source TTM resource (the old backing).
> > + * @dst: The dst TTM resource (the freshly reallocated backing).
> > + * @src_sg: Scatter-gather table of the source (old) backing pages.
> > + * @need_ccs: Whether the BO has CCS aux state that must be migrated too.
> > + *
> > + * Used by the defrag path where a single BO has its backing reallocated at a
> > + * more beneficial page order. The contents are relocated from the old pages
> > + * (@src_sg) to the new pages (the BO's current backing) entirely on the GPU,
> > + * in up to two passes:
> > + *
> > + *  - Data pass (always): copy the data pages verbatim. The pages are mapped
> > + *    without the compression PAT, so the (possibly compressed) bytes are copied
> > + *    as-is rather than being decompressed and recompressed, and no CCS aux copy
> > + *    is appended.
> > + *
> > + *  - CCS pass (@need_ccs): copy the CCS aux (compression) state. Both the old
> > + *    and new data pages are mapped with the compression PAT so the copy engine
> > + *    accesses the aux state indirectly, issuing one indirect -> indirect
> > + *    XY_CTRL_SURF_COPY_BLT; the data blit is skipped.
> > + *
> > + * The two passes are issued separately because they require opposite
> > + * compression PAT settings on the data page mappings (cleared for the verbatim
> > + * data copy, set for the indirect CCS access), which a single mapping cannot
> > + * satisfy. Both passes run in order on the same migrate queue.
> > + *
> > + * Return: Pointer to a dma_fence representing the last copy batch, or an error
> > + * pointer on failure.
> > + */
> > +struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
> > +					 struct xe_bo *bo,
> > +					 struct ttm_resource *src,
> > +					 struct ttm_resource *dst,
> > +					 struct sg_table *src_sg,
> > +					 bool need_ccs)
> > +{
> > +	struct dma_fence *fence2, *fence =
> > +		__xe_migrate_copy(m, bo, bo, src, dst, src_sg,
> > +				  (struct xe_migrate_copy_flags) {
> > +					 .defrag_copy = true,
> > +					 });
> > +
> > +	if (IS_ERR(fence) || !need_ccs)
> > +		return fence;
> > +
> > +	fence2 = __xe_migrate_copy(m, bo, bo, src, dst, src_sg,
> > +				   (struct xe_migrate_copy_flags) {
> > +				   .defrag_ccs = true,
> > +				   });
> > +	if (IS_ERR(fence2))
> > +		dma_fence_wait(fence, false);
> > +	dma_fence_put(fence);
> > +
> > +	return fence2;
> >   }
> >   /**
> > @@ -1096,7 +1197,10 @@ struct dma_fence *xe_migrate_resolve(struct xe_migrate *m,
> >   				     struct xe_bo *bo,
> >   				     struct ttm_resource *res)
> >   {
> > -	return __xe_migrate_copy(m, bo, bo, res, res, false, true);
> > +	return __xe_migrate_copy(m, bo, bo, res, res, NULL,
> > +				 (struct xe_migrate_copy_flags) {
> > +					 .is_vram_resolve = true,
> > +				 });
> >   }
> >   /**
> > diff --git a/drivers/gpu/drm/xe/xe_migrate.h b/drivers/gpu/drm/xe/xe_migrate.h
> > index 965c45889c72..e4f996942a6d 100644
> > --- a/drivers/gpu/drm/xe/xe_migrate.h
> > +++ b/drivers/gpu/drm/xe/xe_migrate.h
> > @@ -11,6 +11,7 @@
> >   struct dma_fence;
> >   struct drm_pagemap_addr;
> >   struct iosys_map;
> > +struct sg_table;
> >   struct ttm_resource;
> >   struct xe_bo;
> > @@ -132,6 +133,13 @@ struct dma_fence *xe_migrate_copy(struct xe_migrate *m,
> >   				  struct ttm_resource *dst,
> >   				  bool copy_only_ccs);
> > +struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
> > +					 struct xe_bo *bo,
> > +					 struct ttm_resource *src,
> > +					 struct ttm_resource *dst,
> > +					 struct sg_table *src_sg,
> > +					 bool need_ccs);
> > +
> >   struct dma_fence *xe_migrate_resolve(struct xe_migrate *m,
> >   				     struct xe_bo *bo,
> >   				     struct ttm_resource *res);
> 
