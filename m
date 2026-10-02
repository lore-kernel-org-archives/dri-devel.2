Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D98CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 20:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA00810E693;
	Fri,  2 Oct 2026 20:21:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VQGcQ6d6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E5B510E6A3;
 Fri,  2 Oct 2026 20:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790972266; x=1822508266;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Sww4ekFnJtsf0RaEg+dDdjj+5ZfafvS+bq5bQAkunKk=;
 b=VQGcQ6d662szp5/J/fTN8qe1hdjiNnr18bXOopuaksWID5lfLDiVYYwl
 Oq9EO/dOv396QIxKCv4AqP2u07z9frsOBRPlyBi3WXCPPHURCPc8BS+/3
 oD+VSgC3F3WD066zpk/ANPFfW8lPrX8fCHX4t1B6RhphEQWhbiegsvZEC
 d+pF+blg4OfzjY594Qw+lKRywXH4Zw9O+EUTrWrAD7A4g/oJK+WFf11Is
 f/uQwg7lQCDXqZfxZMjM6rUJ4lUy9q0sEf+oS9qtVEIioZQ8edifn7CnS
 5yJjtWnRRjxAcfpCb/b1iWAHDBDXp4P40mshJvxiSuJnKLcgIcsOIjDKQ w==;
X-CSE-ConnectionGUID: Zu5zYwi2S8q6AwLsC51UjQ==
X-CSE-MsgGUID: eAYboSGtTQaqLOMUL9+atA==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="95560475"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="95560475"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 13:17:45 -0700
X-CSE-ConnectionGUID: o9dAzauNS6mDlUjva5cvdA==
X-CSE-MsgGUID: 4llcHgD/RdGOsvVV4AKj6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="279607639"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 13:17:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 13:17:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 2 Oct 2026 13:17:44 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.19)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 13:17:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ooWWedF1sDwBV646EC1jQ+bdsyl/7j2jpNn6VzKWwqeE98sNn7EUUCmUpisS7b27qQd6fCX0WO+x+ScCr+Bcm/iupLdI7B2X97HsZ5OYhs7tWuvYsXq10UH2b5sAGLNutFCMMG8LSBZHQLXSPmeutkJz/NbBFHfEkLuDs3OPOQ20DqnKCU3Qz4o+Ji1YMvtsvooFo50jHo6S2X7lksux9k5nY0VIibe+MQ0U8TFjSfuT9GOZzCYav/WHaAM7E/Q0PquEdMrhkv3YYKFS1sDCYuxPjtyRYntwYVlspUUpVntVgkKPJfklikc9B1933Yb18Y7FUtZgWwf6AxY5o7/Wrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MImMoSoQUA+V4lUDNG/ajNhqmXpcG73SZ91C4YBnqNc=;
 b=YATJw/YQ2zyd+258k/M3wM+xZzWh5T1SKBqvnUGraNgTzMxqqsUhkmlhQkdKFgKj5eB0SOk4udJFi5WKekWjkSEMQM9gKp0/Q0DyvD7EONMmes14AGaj4g4Qj+1Z7sywDQpnzX1p1bCROmjSnj3ebz/teqJy+O8l/Tz1CFDDmktwedRkEzCNEyeBzJ2SmRiA0wR9NyjfifgiClf9UxZnWkOe2Hg10g4e/FjfPWN2iVGNgRc/quwhv+icIGzFp6ndyuwRiJfv3d+qrHKKp6B+HcOs/+iVMbwqXmrt6VV6LNTDsNCmDyyeFzeuEsXs/LAneDH2zc5i6pmA0NJZK9z+Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by BN9PR11MB5244.namprd11.prod.outlook.com (2603:10b6:408:135::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Fri, 2 Oct
 2026 20:17:42 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 20:17:41 +0000
Date: Fri, 2 Oct 2026 13:17:37 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Alice Ryhl <aliceryhl@google.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>, Antonino Maniscalco
 <antomani103@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, "Dmitry
 Baryshkov" <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Liviu Dudau <liviu.dudau@arm.com>, "Lyude
 Paul" <lyude@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Marijn Suijten
 <marijn.suijten@somainline.org>, Maxime Ripard <mripard@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Sean Paul <sean@poorly.run>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, "Steven
 Price" <steven.price@arm.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 7/8] drm/nouveau: use DRM_GPUVM_RESV_PROTECTED
Message-ID: <asARYb+nQTONRxgL@gsse-cloud1.jf.intel.com>
References: <20261001220632.3190896-1-matthew.brost@intel.com>
 <20261001220632.3190896-8-matthew.brost@intel.com>
 <ar71hn8WpDHD8cHH@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ar71hn8WpDHD8cHH@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: BY3PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::9) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|BN9PR11MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: b627adba-2f77-489a-6edf-08df20c235ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|22082099003|10067099003|56012099006|11063799006|5023799004|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: F4fGHBehIFtwmUhgDlewgQ2F7LZYLq/6DXBYHsgGxh2E5JnnHnshTnlJgWSfASiPgs9Lzvs6mP9GFhZPvNP23oEejWn3rVYzFFE6tl+iK5M+tp88JOFFhP4T72ccKMm/owrk66pX6JCfefcBPkTYcucLv6+7+oi3yiYTOT2sKb73nNInhey9QmCEA7cQPXNU2RQJnVXf7Lwgny/KKZZaSjjEX6UkgTzgNlZo0k5jUeCHmo0w+N08zehir+XdR9gQ52eD5dUJoq3jRWuoXGMVR4UV51mDm9CKrD0iEhayv/nQCxFB4DeAdLdkjycf5Jn/zS3k7gLi7eTDDC85i8AXioLvGN2NUOKmuX57lR1Lo0jxobvtRC+IZ4Y2wPyya4Ks77EUn+0yDN8DVTYlMSxIIOoa7pKq4Jsx+WFl9Qaa6wOUUeOaPARqwaX9ktNTdwl8VYYdPOUU85YsxZjwrxR29QcLsysAP9fdUBWBMdAFQk/GAze52gaFmVY4oqd0yLe5X08IbfNSMBi+XrrhrtjQrva1uvJxibHJ4DLWMkr+5dHXT3Op/D0UgIgVXRNzOwY5SajLG4jxMIsyDZUG+CJok+dKLMJKK3H3QM1uEoSvnrc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(22082099003)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?lywoY6bBlxk8p9fPow4CgpcGXxcx8KFya2YwloN4nUjQ49rO2H/uv33RZf?=
 =?iso-8859-1?Q?bv1INK9iccK5T0aGy+zpE4M14nnnUhvagpWKsZpryNFuFfdIe/XbSoV+Bw?=
 =?iso-8859-1?Q?a/qZ0vSNlA5LlWtuipuinvR0u5AMh+/AVNvmmTTI+a9MJq6dFxzLbEMm1F?=
 =?iso-8859-1?Q?BrizHjcFseX+C1+UBdpf7viTOkPzngkEncCwlM5dO7qcDmT/+W5Be3Q1c9?=
 =?iso-8859-1?Q?EQup+vL0d1U1Rzvg+T/u3veZUOGvN6I4UaSFnEdqWdjnqWgkf2im2L70ME?=
 =?iso-8859-1?Q?etg+8ybmE5z09yvSPvuzelhEg66jWoc21C6esd4q26wVXXcncI2A3YWzva?=
 =?iso-8859-1?Q?pBRpa4SeCgJPe+WBNcGtyHxM6HYhpkvRYN1YbnqqqieSzWg1pLzZBBLUjt?=
 =?iso-8859-1?Q?GNC8Oh6Y7EF2eXBCnsZF3Vjb7SzvVYJ//4FlCXds1vz7iM537Z80svOwib?=
 =?iso-8859-1?Q?m4aYb8t6AEixJF5XuhrwvYar2Jp5k9MLpFo6bN+rXPuEbCWGTjzdOXUy5k?=
 =?iso-8859-1?Q?Ew1/uTEDgyCPEpaA99wF3KB7sUl0DV/rLKlELRF0TU/n6rFVbvPYohE5VL?=
 =?iso-8859-1?Q?4Ha0xyOWM8YYjDQlJsmAHobplQTcYEioPMY1kG31b7WivJ3Nc4G47oydFA?=
 =?iso-8859-1?Q?15J1yOHiNUeXU9mXEaQM0xOW+vUbMi16AMhh9hxVcACbwKDoIQKqFRfdiR?=
 =?iso-8859-1?Q?dWDSVjFbzQiqvoLfxy7NS5q+O4sYPQQhqMqGD6UI/k8g65UDyLzo+NawT2?=
 =?iso-8859-1?Q?hKWyLMkj4nmlQ0tvpgmqS6cM4hq9c+te3736SlaCU9B6e9/qw4CWzTznor?=
 =?iso-8859-1?Q?yFFnTG1/1f2TxRSVV9dMYc+VShnxchTQ7o5QHTEEiMpy/gOUH56R8dH6it?=
 =?iso-8859-1?Q?h9YSuViwiaKuqJangX+o6M02+z/b7xA8paKUvClbSOvzFobLa8Ar6OicLr?=
 =?iso-8859-1?Q?OgTBYIw+o/a7g3rkVdeF3aCRlPgcECMekzOazobaedunUO9zaBpFA8pCK4?=
 =?iso-8859-1?Q?aSVh+N9xjc3VfVXJaj6YZM8/4rj8/Nr4UXzlDA3z1xFCnesXgkEnG6HFtQ?=
 =?iso-8859-1?Q?Kc0PhZi1VVay3zgJT89HO2sWVGuWs8iHKhjkk6z7F6I1nefa86cr0H+czP?=
 =?iso-8859-1?Q?7VHhV7UkiD6UAK71FCmPGj2KFiwFZFxI9SO3e2tX5+94dksnql0dJuNoUi?=
 =?iso-8859-1?Q?OuCZ4Kgr7Mhy02zzJ26doa5MvbVfjoPrl9FEraktuzUmUP5mou2gP+EMDV?=
 =?iso-8859-1?Q?RVvS9zeAcpPJ+ry86GOJa6iUFo2RZ+I8hYLPGtPv5hPww3lqmE3zlAkpnc?=
 =?iso-8859-1?Q?7rVkWLTP/O0a5nS6vguBorSFTmQ8DOl4rUxewVGdyPP0ya1nVuNViC1jij?=
 =?iso-8859-1?Q?PzpILKZxZPbXYTAdrOXUKV8lo3NFwwWgymSHLc3/+ZF3F9oQqUNJ0GUEBe?=
 =?iso-8859-1?Q?Ay+8axlr1C/5k+AAwbMmGbMI1sf6qtivly3n82DxpMheervuz2D2toEpWi?=
 =?iso-8859-1?Q?3svhv9fLZwtfXlEZHg3h40MP4Q59C3L1stQcwF80QqWtsReffVdyweSBew?=
 =?iso-8859-1?Q?IOBclr1gwrHjOqPwU0bgOgtkND+Ag04/jjg4YtwX06h3EkaSP0AdtDFRNz?=
 =?iso-8859-1?Q?dWMtE0NwMk5yTpB6yC0ZhBlUXlZcrpAIrzKh2dAGdO2W/9j4QJ/dkjILw8?=
 =?iso-8859-1?Q?Tp+8YbE9JtF13L4bPXw7XVoPtOSlygHc6WWGY5rb+87uHlFCjwCNTOKWxT?=
 =?iso-8859-1?Q?KZBKKdWBj1H3ZdoPqX6tat8iroMJx5JCCYxn8jCBNnvEGXYYERKLLUd6/e?=
 =?iso-8859-1?Q?32aOBlBxlA=3D=3D?=
X-Exchange-RoutingPolicyChecked: 2ZgQBBzg4DEGPDXhsLO7ubIi64tsW92Tk8M/AD5H5p7qisRiXssFhjAEeJRjPzw38mtxz9rfELmMN8gh3uhMKsBq2pyc8WsjxkJZKWDD+cqqAdEQI087Yel4KwAW/1y225/mpEfEPYOoWLfA0jSeChllt4xacTInpQEiDMXu6GCmixFnnXc8iTo08q1ULfShTeZIJ06GQLvfVEeu342+Mtm5DbG5ytuRAaojPk9EarsMkF3vnVryQOI6SILe8xql7LJxpOd7yj88Jm+WLlLeIvUSpTaKY26rbhNhkvJnyGDJI5MfGlsrqwQmpQsleRWoxSuwjiA1xeXCy8OqMksL1Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: b627adba-2f77-489a-6edf-08df20c235ce
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 20:17:41.0887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbMTalHn2eOUeOx5MYcTsBrTSjMTk/TCUtima1+nai4mJzazeZFLcmYEuzJTJBDBF9zsxExUTSyqgD+4+AwILg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5244
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

On Thu, Oct 01, 2026 at 05:06:30PM -0700, Matthew Brost wrote:
> On Thu, Oct 01, 2026 at 03:06:31PM -0700, Matthew Brost wrote:
> > nouveau creates its drm_gpuvm without DRM_GPUVM_RESV_PROTECTED, so the
> > extobj and evicted lists are protected by internal spinlocks. Every
> > nouveau path but three already touches them with the VM's resv held:
> > drm_gpuvm_exec_lock() and drm_gpuvm_validate() on exec, and TTM moves of
> > private BOs, which share the VM's resv. The remaining three are:
> > 
> >  - nouveau_uvmm_bind_job_submit() adds the vm_bo of a MAP op to the
> >    extobj list holding no resv at all. Move that into
> >    bind_lock_validate(), which now locks the VM's resv as well.
> > 
> >  - bind_link_gpuvas() unlinks the GPUVAs of UNMAP and REMAP ops, which
> >    can drop the last reference of their vm_bo. It runs within the bind
> >    job's drm_exec transaction, which the above makes hold the VM's resv.
> > 
> >  - nouveau_uvmm_bind_job_cleanup() and nouveau_uvmm_fini() can drop the
> >    last reference of a vm_bo holding only the object's resv. Lock the
> >    VM's resv along with it, through a new
> >    nouveau_uvmm_lock_vm_and_obj().
> > 
> > The bind job's fence now always lands in the VM's resv, as BOOKKEEP.
> > This already happened whenever a bind job mapped a private BO.
> > 
> > With that the internal spinlocks buy nothing, so set
> > DRM_GPUVM_RESV_PROTECTED. This is also what two-pass locking in
> > drm_gpuvm requires, which a following patch makes use of.
> > 
> > Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
> > Cc: Alice Ryhl <aliceryhl@google.com>
> > Cc: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> > Cc: Antonino Maniscalco <antomani103@gmail.com>
> > Cc: Boris Brezillon <boris.brezillon@collabora.com>
> > Cc: Danilo Krummrich <dakr@kernel.org>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Dmitry Baryshkov <lumag@kernel.org>
> > Cc: Jessica Zhang <jesszhan0024@gmail.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Marijn Suijten <marijn.suijten@somainline.org>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Rob Clark <robin.clark@oss.qualcomm.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Sean Paul <sean@poorly.run>
> > Cc: Shuah Khan <skhan@linuxfoundation.org>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: Steven Price <steven.price@arm.com>
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > Assisted-by: LLM
> > ---
> > v3:
> >  - New patch (Danilo)
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_uvmm.c | 49 ++++++++++++++++++++++----
> >  1 file changed, 42 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> > index 2026fe6b48c6..dae612e56d91 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> > @@ -1187,6 +1187,27 @@ bind_validate_region(struct nouveau_job *job)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Lock the VM's common dma-resv together with the one of @obj, as needed to
> > + * drop what may be the last reference of a &drm_gpuvm_bo.
> > + */
> > +static void
> > +nouveau_uvmm_lock_vm_and_obj(struct nouveau_uvmm *uvmm, struct drm_exec *exec,
> > +			     struct drm_gem_object *obj)
> > +{
> > +	int ret;
> > +
> > +	drm_exec_init(exec, DRM_EXEC_IGNORE_DUPLICATES, 2);
> > +	drm_exec_until_all_locked(exec) {
> > +		ret = drm_exec_lock_obj(exec, drm_gpuvm_resv_obj(&uvmm->base));
> > +		if (!ret)
> > +			ret = drm_exec_lock_obj(exec, obj);
> > +		drm_exec_retry_on_contention(exec);
> > +		if (drm_WARN_ON(uvmm->base.drm, ret))
> 
> Sashiko flagged that -ENOMEM is a possible return from drm_exec_lock_obj
> if a kmalloc fails and that is correct.
> 
> My plan is to change this and open coded WW transaction which can't
> fail.
> 
> Not going to post now as I don't want to spam the list.
> 

Or this patch merges - then is a moot point:
https://patchwork.freedesktop.org/series/175390/

Matt

> Matt
> 
> > +			break;
> > +	}
> > +}
> > +
> >  static void
> >  bind_link_gpuvas(struct bind_job_op *bop)
> >  {
> > @@ -1224,12 +1245,24 @@ bind_lock_validate(struct nouveau_job *job, struct drm_exec *exec,
> >  		   unsigned int num_fences)
> >  {
> >  	struct nouveau_uvmm_bind_job *bind_job = to_uvmm_bind_job(job);
> > +	struct nouveau_uvmm *uvmm = nouveau_cli_uvmm(job->cli);
> >  	struct bind_job_op *op;
> >  	int ret;
> >  
> > +	/* The VM's dma-resv protects its extobj and evicted lists, and must be
> > +	 * held by bind_link_gpuvas() in case it drops the last reference of a
> > +	 * &drm_gpuvm_bo.
> > +	 */
> > +	ret = drm_gpuvm_prepare_vm(&uvmm->base, exec, num_fences);
> > +	if (ret)
> > +		return ret;
> > +
> >  	list_for_each_op(op, &bind_job->ops) {
> >  		struct drm_gpuva_op *va_op;
> >  
> > +		if (op->op == OP_MAP)
> > +			drm_gpuvm_bo_extobj_add(op->vm_bo);
> > +
> >  		if (!op->ops)
> >  			continue;
> >  
> > @@ -1288,8 +1321,6 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
> >  			dma_resv_unlock(obj->resv);
> >  			if (IS_ERR(op->vm_bo))
> >  				return PTR_ERR(op->vm_bo);
> > -
> > -			drm_gpuvm_bo_extobj_add(op->vm_bo);
> >  		}
> >  
> >  		ret = bind_validate_op(job, op);
> > @@ -1603,9 +1634,11 @@ nouveau_uvmm_bind_job_cleanup(struct nouveau_job *job)
> >  			drm_gpuva_ops_free(&uvmm->base, op->ops);
> >  
> >  		if (!IS_ERR_OR_NULL(op->vm_bo)) {
> > -			dma_resv_lock(obj->resv, NULL);
> > +			struct drm_exec exec;
> > +
> > +			nouveau_uvmm_lock_vm_and_obj(uvmm, &exec, obj);
> >  			drm_gpuvm_bo_put(op->vm_bo);
> > -			dma_resv_unlock(obj->resv);
> > +			drm_exec_fini(&exec);
> >  		}
> >  
> >  		if (obj)
> > @@ -1941,7 +1974,8 @@ nouveau_uvmm_ioctl_vm_init(struct drm_device *dev,
> >  	mt_init_flags(&uvmm->region_mt, MT_FLAGS_LOCK_EXTERN);
> >  	mt_set_external_lock(&uvmm->region_mt, &uvmm->mutex);
> >  
> > -	drm_gpuvm_init(&uvmm->base, cli->name, 0, drm, r_obj,
> > +	drm_gpuvm_init(&uvmm->base, cli->name, DRM_GPUVM_RESV_PROTECTED,
> > +		       drm, r_obj,
> >  		       NOUVEAU_VA_SPACE_START,
> >  		       NOUVEAU_VA_SPACE_END,
> >  		       init->kernel_managed_addr,
> > @@ -1978,6 +2012,7 @@ nouveau_uvmm_fini(struct nouveau_uvmm *uvmm)
> >  	struct nouveau_uvma_region *reg;
> >  	struct nouveau_cli *cli = uvmm->vmm.cli;
> >  	struct drm_gpuva *va, *next;
> > +	struct drm_exec exec;
> >  
> >  	nouveau_uvmm_lock(uvmm);
> >  	drm_gpuvm_for_each_va_safe(va, next, &uvmm->base) {
> > @@ -1989,9 +2024,9 @@ nouveau_uvmm_fini(struct nouveau_uvmm *uvmm)
> >  
> >  		drm_gpuva_remove(va);
> >  
> > -		dma_resv_lock(obj->resv, NULL);
> > +		nouveau_uvmm_lock_vm_and_obj(uvmm, &exec, obj);
> >  		drm_gpuva_unlink(va);
> > -		dma_resv_unlock(obj->resv);
> > +		drm_exec_fini(&exec);
> >  
> >  		nouveau_uvma_unmap(uvma);
> >  		nouveau_uvma_vmm_put(uvma);
> > -- 
> > 2.34.1
> > 
