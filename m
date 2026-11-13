Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0003606A32E
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 19:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VMoSIXkc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=iBFTIUax
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDFBF11278B;
	Fri, 13 Nov 2026 19:40:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9653910EC99;
 Fri, 13 Nov 2026 19:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794598844; x=1826134844;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=vUPs58DfyjQYFy1bWvTtozjqk9ETkhm4iZ9UXg6iaYo=;
 b=VMoSIXkcL4yrRa2XeO1+fX3JARN65ZrVARKi+OqSc65MqPOSX9Ur4GDx
 odcC5xPshqXCunqCKK4gJgb9U91SQEJNn0BHMBrO2K4qaFJwrs0bddRJO
 7kDoAj6nBoHj8JMyHJvUvXhIBvnD3Yo/wdgkgIKMALrAnItFkosQbDkL8
 UQR0+cRAS316Mwj4jOY5m8KO6RZflKgd6xz7wg4rFd1xip721y9v3N3LP
 iS+Z+Bapa4MRFRBB/J7HPSqBCJ1FEhw8Kw//VHjYTnC1Jjsb3QbhoOMBZ
 MVZ+kELQlIq34fdPdT6t4GKdairsAE71zIvN1tkdIGEOh/0dzKD47SYu9 w==;
X-CSE-ConnectionGUID: 1pQ+sxg6QbynjeMkQkpkWQ==
X-CSE-MsgGUID: KjWF3r2qSgGoUl71BdESBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3446309"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3446309"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 11:40:43 -0800
X-CSE-ConnectionGUID: ovgZV24nTMCuXl94tRWHqQ==
X-CSE-MsgGUID: tPzqz198Rr2Tu8s0QT7Upw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; d="scan'208";a="10905076"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 11:40:43 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 11:40:42 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 11:40:42 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 11:40:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mD/QBf1qDKWtmmUZdXeoeSL9lNbxg6k7K5qOz4L3wE3wuLYDvMFzz7rl158xdVjPach+Hcg7ODciNSbzd+bYnrM/cRgD5F30XRH+mq3AmLcah9tnLLWkv6m24VJdAkfNXqZzwKcvCMIoP2IF2J+Lk732haK3JKUIwrohTuqlAhqUvIbi8pGxKHBucMJfjcMfvJaBUwl5xhqUG1Usx5T1Mygmwi8+TdRSLfjFtazfcJ2Jf8KFBW+zHUSzF6ROmjwm5T4wel7mqJBD3dw/2zMH4Yk8KEDgxLFvyIrrP9ASlCVHGHtKuAylqWzINDAUlmTyxMUBVujKLQAXyh97Frh6yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpkeBKfMpGptehQlaBU39k6ADTheNOc1MqDAojLNgtc=;
 b=VC0H7PDhygRDMpym+39NOmvVVBbcV6aOXrQUlQoTgr7kIUmM5R/G3u+4ViIdthXTdi1BBufItQwfuovk6yAJZoYXpBJ9c0CPoBK02kahUWe7xrkE/Tk76z0bixgLJM8WUA9p8thL9dBkBhWJ0722HVuzomcF+1MbvT0NaxSTsM5pCOnqdgCHjKiNp4vZ5rAuWQN8x4n/uzaDIC6UXVbyKkVpHVQ5IIAkDyc9cgMIh0+BhFoOP7gZipW+C4WurMWysbok31/sDsStPuiFV9MdkqgkKmP+oS0MSxn2H8qqxjLJw0Lz7cEsYN7MwYx3U4x8I9rUJMJ2WO1HiTeMDz4l7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpkeBKfMpGptehQlaBU39k6ADTheNOc1MqDAojLNgtc=;
 b=iBFTIUaxFVZKMLND0LybtohfPxPSmA4IUxvguZXKVMB6yUuDARlRY7g5vLxM7ByDS5geH3t3su7U+DJfVpbJyD7u8rsaRYgxp8AW89NjlyRV7nBariUff72TwD8CquP6QA3ZT5BoBINQ8cieIZ521qnAydkRdM977b+gIyH1S44=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SA3PR11MB245380.namprd11.prod.outlook.com (2603:10b6:806:52d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 19:37:35 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 19:37:35 +0000
Date: Fri, 13 Nov 2026 11:37:33 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: "Yadav, Arvind" <arvind.yadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <himal.prasad.ghimiray@intel.com>, <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH] drm/xe/svm: Take write access only for GC attribute resets
Message-ID: <avdm/ajA/I0rwQ5a@gsse-cloud1.jf.intel.com>
References: <20261026122045.2709500-1-arvind.yadav@intel.com>
 <auENFUKFEcjZorM6@gsse-cloud1.jf.intel.com>
 <6b8b81b5-0da8-4f02-acc0-5de6a89ec88f@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b8b81b5-0da8-4f02-acc0-5de6a89ec88f@intel.com>
X-ClientProxiedBy: MW4PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:303:b4::33) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SA3PR11MB245380:EE_
X-MS-Office365-Filtering-Correlation-Id: 9355dc5e-f771-436b-d869-08df41bd9145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|261009223027099003|10067099003|261026140227099003|11063799006|4143699003|261021121427099003|56012099006|261021123027099003|261009221227099003|261022105027099003|261022075727099003|261009220027099003|261009223327099003|261009221727099003|261102123227099003|261028144727099003|261026121527099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: leVlHIeySTetcGlB7UrX7SuHjZEIG51YpRBI11E5ZNTC94xtJnrzPglfb8eEB+yhyiJw/ezCFAtg1r1vcR6MQYttXBoALua+S1JD/8PWcsjO1lucUSuUTQQRs+h+6jQ9tjm6Xsrt7PaimHnnd1FUtAb9pWlMKQGYXalK9pdy8RVCpD1Y4H7y1i0PL36nWuzBifudDMkVcxXbFKyyPTWUrZ/rZUmbYfJRWBvEQhhBAe4IqGYxV30rpQUe20LH7kW4nbFE3QgQSWh3JFIvEBFH2j+ILIpF5Jt/A+Ovr8GF2Nd0qOzmX4HOJq/hhvdNRHOAL025CIClBfgALMNQtZgv+3T9OdzFCmmF14xajE6NqadtvyRrKwOT+ehstl+7z49VD/rrWSBkBpAYhi7bA8Y70cIekX0PJIV5q5C95kUEiKPtvGzqRdOWOvh2tD8AS/kQm4p/abTCGwzv3pLl82Cnwk44yOaAAKjt6c4wOI9tt1qnbSZjUHIeWqCy2sPDoN0Uw8GFkGyiYpgOcZRa3dUFdBBBrqTcbBcPq3AvmMFPq+d2r+v1AUQ+svFUJ1D8m7iLDLcU56L4AbshJw/F73LX9/aszXkAozO1yzHczIU7VCmTwRSHa3d9yMASvHONNNbju3M7Ktk2z6SHke1M0f0f1AgHZCWlXjt/s7VAVVRNrSw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261009223027099003)(10067099003)(261026140227099003)(11063799006)(4143699003)(261021121427099003)(56012099006)(261021123027099003)(261009221227099003)(261022105027099003)(261022075727099003)(261009220027099003)(261009223327099003)(261009221727099003)(261102123227099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?t8glUGWGD1hq1gNjrYmrDVHfqP/SSE2Y48r+8LofzoaIUzWCnDWfpSo1wE?=
 =?iso-8859-1?Q?GDRmI+wiY4fdeM36eOS1ha4xYdl3hUfz99fIF37lEGvyf8UR3CVPdquCyt?=
 =?iso-8859-1?Q?nmrHLhXMirO6KTqsZVb8m9tZfEHDr3SJn5mZnN2dCDvnFdplkj9GpkS4hN?=
 =?iso-8859-1?Q?AJo/43ZA2wT0kvt50R85YNnmo9w7ueCc7qqYcu5F6qJqFTRFZwaOMOwlIB?=
 =?iso-8859-1?Q?31o/VArFmSsqUZliVeEVTvxJI//2D2EaKOUe1ebAkIH4J9+ozhFGh4xysz?=
 =?iso-8859-1?Q?hwSmwYmzGDcZS34FPYbFupqVhIApQgEuXio5CFO/IIRl9qRJq1H+z4ecKi?=
 =?iso-8859-1?Q?98buKdPcCranvuLg0vo9zNHz484iiZFz2APeWBmMaFyQJmY+Rza0CaqHvJ?=
 =?iso-8859-1?Q?9jxKvKtpVUQO2/aHR4oBm2ip///e08IQvrH3z28IlM5WFk+KEn/uU5nGCs?=
 =?iso-8859-1?Q?fbQjr5sNMQDHQbUu/SDuOOHSO1gNJ/3VaBSK26fbrKghABmLwhdcFnSPyl?=
 =?iso-8859-1?Q?J0UrT2/Pqw4sEfb1VtD0f/fWkI6pWbTq4TNfdYqY80bfgvyYyzcHV3+nSG?=
 =?iso-8859-1?Q?t63NaFaF+Y7OfwSQGBg4Pt8Ia6HAJ7EKQjJERONaZy2HRkaY3hanYSkhuD?=
 =?iso-8859-1?Q?7/Z+NtNKwDhIUIiw4v+pPncC4wki0NUwwttRzpEA/KukdvuQqqvU+2kaBv?=
 =?iso-8859-1?Q?javbHnWWUrNI6bm3fJgBlDBFEtMlGPGXrJ1CWP8kCLsuAFKB/Ih2kXd3IF?=
 =?iso-8859-1?Q?GSqPqvkk+Ri85NrEqFSKKcMxUm/nzejwiVL1d4Af+teHtVVVxrifb48u8n?=
 =?iso-8859-1?Q?I0M5KzkTlT6B7E4dnHt8ZU1Qf01uqCRhtP9NwOWVpJ95K+bFgy4kspCJYn?=
 =?iso-8859-1?Q?/ck1tGwBEAxJrO63rPYRh7AYzoNhb0A1LE53sFctFRw4hmyf8RA4X0GjUC?=
 =?iso-8859-1?Q?quLN7gYsu8qb0L00MBiHQ10zZZTIxjxn7LMrs3IykKmn639L3UJG4cmT4r?=
 =?iso-8859-1?Q?eiCkikJuZdjo8FqQ9lNTYx2Xws9nGJ8kubF9NnrNhfUVN3NYj/pNe5+LBU?=
 =?iso-8859-1?Q?H0T3XajFCfaiTzZjZCKfMV55djT66F1Z4GkZs3O8eRtPTmK4rEln8KT3vo?=
 =?iso-8859-1?Q?+rgzZAswEfzoQnN3tfQhyqzyLUcNi7Ackq3+EMYVwzVLa1qnW2K2ZbSrSO?=
 =?iso-8859-1?Q?fdWBXMBkrggFGcddZhMFsNciNfP5MgV0SQRQ04DgquJsEZBrxe/mlsiFfX?=
 =?iso-8859-1?Q?+YlJGhi5zsmqUnzIVeaY4GG8s//nFrdFWp65RaV5KlF8UD04OCn0Zk05Rl?=
 =?iso-8859-1?Q?6wwRZXNok2p4kdrV4/OLdKiM0DRl03LM0tjXLxzEs+PkdgpnmBEpbW9SE/?=
 =?iso-8859-1?Q?D80HxtKurcJoM0qcJDC/tl6omg4W8dQV5bI3fkLeH1p5mfaLcz1nn414FP?=
 =?iso-8859-1?Q?+Sl5DmF/+7VxQG2vR5dEMjvxzIe21TaORKbWDGtqGKABP5y7DJ/SnNBfjS?=
 =?iso-8859-1?Q?sJy7R2WDh1z7NjM2QPxttYBZcRGQdGjhCn7RlE7KmGtkPqEcjjosL+QI0/?=
 =?iso-8859-1?Q?Y28QeUxnIW9bfa/5LcRX0vg0AXMOCPD5SD/i5SInO/zJgOWLTMHNQ/1eKg?=
 =?iso-8859-1?Q?FQe4TM9c01MHht+8W19YOnWkApVh5i3cUIjxlkxKxA8p/BlkwAZqAxiJak?=
 =?iso-8859-1?Q?Ojso/NU0rrgNhLpmzTiXIZfBYeGEuxwfwRrkME0ihedH6qw7kbJa5L845V?=
 =?iso-8859-1?Q?scmvpLC0MxYpmTkQoB6kfr+6fBAPu9PpS/eN9/ZzzGoazIzon0WkTerMAp?=
 =?iso-8859-1?Q?MhSb/1Z5CQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: NOWLSX8dTYiilLPHV14bnkTSaugYv8mZWKFE3dlsp7ftoAocFoEwkWMeEXYjFCKmtoq1ZWqgAIgUeB91R2YvV3TN1Adx6qf733Y8Ohd6c9NY4oCmMIKfCiLqT2QuiBOj7rTTDcP+uIeiSivUHRW3TY6NeqGhTDRdPq13XaQ6SanZKjSsPPRTrppE2AsPLGQXp+W5Ejc0GDru/PRW5FqCqWLplNTJeh/AEoDE89ECSpiHKER/V8DHY60ywZICHcrgclXCu3AsT+Vxb7s53/c6j4Qc3dvf75SouxQiKTbMVaphtFWocHI7vxqxZyF9+fyoY9tp22oTcuPBgMv74v9rMQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9355dc5e-f771-436b-d869-08df41bd9145
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 19:37:35.3767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6L8FGDgnG6SCWDPKF39r3Nr+V9VmpCIFt8jRUfBszCqKAJxMTTo/ER5uG92UxvUwQKbM0ln6kMK1kcIEwf9xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB245380
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

On Thu, Oct 29, 2026 at 09:20:33AM +0530, Yadav, Arvind wrote:
> 
> On 28-10-2026 02:14, Matthew Brost wrote:
> > On Mon, Oct 26, 2026 at 05:50:45PM +0530, Arvind Yadav wrote:
> > > Fault service holds vm->lock for read while using a VMA. SVM garbage
> > > collection also runs under the read lock and can reset AUTORESET
> > > attributes. The reset can split or merge VMAs and immediately free a
> > > VMA that another fault worker is still using. The GC mutex serializes
> > I'll have to think about this one for a bit but quick thought:
> > 
> > Can we use some ref counting (e.g., add a VMA ref count) rather than
> > changing the locking?
> 
> 
> A VMA ref count would keep it alive while the fault worker uses it. But the
> reset also changes "vma->attr" which the fault worker reads. The ref count
> would not protect those updates.
> 

Can't this race only happen if say a fault starts (A), an unmap occurs
on A's fault, and different fault starts (B) and see A's unmap and blows
away A's VMA? This is memory unsafe as A can currently UAF but ref
counting could make this memory safe.

Now to the attribute race - wouldn't A fail somewhere on a notifier
retry if its attributes actually change? I guess we don't always lookup
on a retry but we could.

Matt

> I will check if we can avoid changing the attributes in place and retry the
> fault when the VMA is replaced, keeping the current locking. If You have any
> other suggestion please let me know.
> 
> Thanks,
> Arvind
> 
> > Matt
> > 
> > > collectors but does not protect VMA readers.
> > > 
> > > Keep backing collection under read access when no attribute change is
> > > needed. Defer ranges requiring a reset and return -EAGAIN so the caller
> > > can release its read-side state and collect with write access.
> > > 
> > > In fault service, discard the old VMA pointer before releasing the read
> > > lock. After acquiring write access, recheck VM state and collect the
> > > queued ranges. Downgrade to read and repeat VMA lookup, permission checks
> > > and advice-dependent setup.
> > > 
> > > Drain GC under the existing write lock before madvise, bind and attribute
> > > query. Require write access for VMA changes while retaining parallel
> > > fault service when no reset is needed.
> > > 
> > > [ 2163.042338] ==================================================================
> > > [ 2163.042353] BUG: KASAN: slab-use-after-free in __xe_svm_handle_pagefault+0x297/0x1460 [xe]
> > > [ 2163.042815] Read of size 8 at addr ffff88813f879b70 by task kworker/u65:3/3115
> > > 
> > > [ 2163.042834] CPU: 0 UID: 0 PID: 3115 Comm: kworker/u65:3 Kdump: loaded Tainted: G S      W  O        7.3.0-lgci-xe-svm-22oct #16 PREEMPT(full)
> > > [ 2163.042841] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN, [O]=OOT_MODULE
> > > [ 2163.042842] Hardware name: ASUS System Product Name/PRIME Z790-P WIFI, BIOS 1002 03/31/2023
> > > [ 2163.042845] Workqueue: xe_page_fault_work_queue xe_pagefault_queue_work [xe]
> > > [ 2163.043326] Call Trace:
> > > [ 2163.043327]  <TASK>
> > > [ 2163.043330]  dump_stack_lvl+0x91/0xf0
> > > [ 2163.043336]  print_report+0xd1/0x610
> > > [ 2163.043340]  ? __xe_svm_handle_pagefault+0x297/0x1460 [xe]
> > > [ 2163.043825]  ? __virt_addr_valid+0x1b2/0x350
> > > [ 2163.043831]  ? kasan_complete_mode_report_info+0x6a/0x210
> > > [ 2163.043836]  ? __xe_svm_handle_pagefault+0x297/0x1460 [xe]
> > > [ 2163.044340]  kasan_report+0xa3/0xe0
> > > [ 2163.044344]  ? __xe_svm_handle_pagefault+0x297/0x1460 [xe]
> > > [ 2163.044881]  __asan_load8+0x8b/0xe0
> > > [ 2163.044885]  __xe_svm_handle_pagefault+0x297/0x1460 [xe]
> > > [ 2163.045456]  ? lock_acquire+0x1b0/0x320
> > > [ 2163.045461]  ? xe_vm_find_overlapping_vma+0x88/0x310 [xe]
> > > [ 2163.046072]  ? __pfx___xe_svm_handle_pagefault+0x10/0x10 [xe]
> > > [ 2163.046679]  ? rcu_is_watching+0x21/0x60
> > > [ 2163.046684]  ? __mutex_lock+0x1172/0x18b0
> > > [ 2163.046690]  ? find_held_lock+0x31/0x90
> > > [ 2163.046696]  ? xe_vm_find_overlapping_vma+0xa1/0x310 [xe]
> > > [ 2163.047273]  ? __kasan_check_write+0x14/0x30
> > > [ 2163.047278]  ? __mutex_unlock_slowpath+0x10f/0x660
> > > [ 2163.047285]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
> > > [ 2163.047295]  ? mutex_unlock+0x12/0x20
> > > [ 2163.047299]  ? xe_vm_find_overlapping_vma+0xa1/0x310 [xe]
> > > [ 2163.047844]  xe_svm_handle_pagefault+0x5c/0x140 [xe]
> > > [ 2163.048355]  xe_pagefault_queue_work+0x19ad/0x2450 [xe]
> > > [ 2163.048843]  process_one_work+0x5ae/0xdd0
> > > [ 2163.048847]  ? __lock_acquire+0x58a/0x2820
> > > [ 2163.048850]  ? __schedule+0x22a6/0x3670
> > > [ 2163.048858]  ? __pfx_process_one_work+0x10/0x10
> > > [ 2163.048866]  ? __pfx_xe_pagefault_queue_work+0x10/0x10 [xe]
> > > [ 2163.049345]  ? assign_work+0xe4/0x1d0
> > > [ 2163.049350]  worker_thread+0x3b4/0x6a0
> > > [ 2163.049357]  ? __pfx_worker_thread+0x10/0x10
> > > [ 2163.049361]  kthread+0x204/0x250
> > > [ 2163.049364]  ? kthread+0xf1/0x250
> > > [ 2163.049369]  ? __pfx_kthread+0x10/0x10
> > > [ 2163.049372]  ret_from_fork+0x465/0x6a0
> > > [ 2163.049377]  ? __pfx_ret_from_fork+0x10/0x10
> > > [ 2163.049381]  ? __switch_to+0x26f/0x740
> > > [ 2163.049386]  ? __pfx_kthread+0x10/0x10
> > > [ 2163.049390]  ret_from_fork_asm+0x1a/0x30
> > > [ 2163.049399]  </TASK>
> > > 
> > > [ 2163.049654] Allocated by task 522570:
> > > [ 2163.049662]  kasan_save_stack+0x26/0x60
> > > [ 2163.049668]  kasan_save_track+0x14/0x40
> > > [ 2163.049672]  kasan_save_alloc_info+0x37/0x60
> > > [ 2163.049677]  __kasan_kmalloc+0xc3/0xd0
> > > [ 2163.049681]  __kmalloc_cache_noprof+0x2b4/0x6c0
> > > [ 2163.049686]  xe_vma_create+0xe3/0xe60 [xe]
> > > [ 2163.050170]  new_vma+0x416/0x540 [xe]
> > > [ 2163.050654]  vm_bind_ioctl_ops_parse+0xc3e/0x1110 [xe]
> > > [ 2163.051139]  xe_vm_alloc_vma+0x243/0xd60 [xe]
> > > [ 2163.051623]  xe_vm_alloc_madvise_vma+0x92/0xd0 [xe]
> > > [ 2163.052107]  xe_vm_madvise_ioctl+0x783/0x14f0 [xe]
> > > [ 2163.052591]  drm_ioctl_kernel+0x143/0x200
> > > [ 2163.052597]  drm_ioctl+0x419/0x790
> > > [ 2163.052600]  xe_drm_ioctl+0x9e/0xf0 [xe]
> > > [ 2163.053074]  __x64_sys_ioctl+0xd5/0x130
> > > [ 2163.053079]  x64_sys_call+0x2b5/0x27e0
> > > [ 2163.053084]  do_syscall_64+0xef/0x6c0
> > > [ 2163.053088]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > 
> > > [ 2163.053098] Freed by task 17929:
> > > [ 2163.053105]  kasan_save_stack+0x26/0x60
> > > [ 2163.053110]  kasan_save_track+0x14/0x40
> > > [ 2163.053114]  kasan_save_free_info+0x3b/0x60
> > > [ 2163.053118]  __kasan_slab_free+0x6f/0xa0
> > > [ 2163.053123]  kfree+0x2bb/0x600
> > > [ 2163.053127]  xe_vma_free+0x5a/0x70 [xe]
> > > [ 2163.053610]  xe_vma_destroy_late+0xae/0xf0 [xe]
> > > [ 2163.054093]  xe_vma_destroy+0xda/0xf20 [xe]
> > > [ 2163.054576]  xe_vm_alloc_vma+0x304/0xd60 [xe]
> > > [ 2163.055059]  xe_vm_alloc_cpu_addr_mirror_vma+0x8f/0xd0 [xe]
> > > [ 2163.055543]  xe_svm_garbage_collector+0x388/0x5d0 [xe]
> > > [ 2163.056028]  xe_svm_garbage_collector_work_func+0x2a/0x40 [xe]
> > > [ 2163.056512]  process_one_work+0x5ae/0xdd0
> > > [ 2163.056517]  worker_thread+0x3b4/0x6a0
> > > [ 2163.056521]  kthread+0x204/0x250
> > > [ 2163.056525]  ret_from_fork+0x465/0x6a0
> > > [ 2163.056530]  ret_from_fork_asm+0x1a/0x30
> > > 
> > > Fixes: 941bcc1a4bbf ("drm/xe: Fine grained page fault locking")
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> > > Assisted-by: LLM
> > > Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> > > ---
> > >   drivers/gpu/drm/xe/xe_pagefault.c  |  37 +++++-
> > >   drivers/gpu/drm/xe/xe_svm.c        | 179 ++++++++++++++++++++++-------
> > >   drivers/gpu/drm/xe/xe_svm.h        |   8 ++
> > >   drivers/gpu/drm/xe/xe_vm.c         |  54 +++++----
> > >   drivers/gpu/drm/xe/xe_vm_madvise.c |   5 +
> > >   5 files changed, 212 insertions(+), 71 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
> > > index 5247321c805e..9e1377df9d01 100644
> > > --- a/drivers/gpu/drm/xe/xe_pagefault.c
> > > +++ b/drivers/gpu/drm/xe/xe_pagefault.c
> > > @@ -270,8 +270,9 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
> > >   	struct xe_device *xe = gt_to_xe(gt);
> > >   	struct xe_vm *vm;
> > >   	struct xe_vma *vma = NULL;
> > > +	enum xe_pagefault_error error;
> > >   	int err;
> > > -	bool atomic;
> > > +	bool atomic, svm_relookup = false;
> > >   	u32 asid = FIELD_GET(XE_PAGEFAULT_ASID_MASK, pf->consumer.id);
> > >   	/* Producer flagged this fault to be nacked */
> > > @@ -297,10 +298,13 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
> > >   		goto unlock_vm;
> > >   	}
> > > +lookup_vma:
> > >   	vma = xe_vm_find_vma_by_addr(vm, xe_pagefault_addr(pf));
> > >   	if (!vma) {
> > >   		err = -EINVAL;
> > > -		xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_VMA_NOT_FOUND);
> > > +		xe_pagefault_set_error(pf, svm_relookup ?
> > > +				       XE_PAGEFAULT_ERROR_SVM_VMA_NOT_FOUND :
> > > +				       XE_PAGEFAULT_ERROR_VMA_NOT_FOUND);
> > >   		goto unlock_vm;
> > >   	}
> > > @@ -313,11 +317,36 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
> > >   	atomic = xe_pagefault_access_is_atomic(pf->consumer.access_type);
> > > -	if (xe_vma_is_cpu_addr_mirror(vma))
> > > +	if (xe_vma_is_cpu_addr_mirror(vma)) {
> > >   		err = xe_svm_handle_pagefault(vm, vma, pf, gt,
> > >   					      xe_pagefault_addr(pf), atomic);
> > > -	else
> > > +		if (err == -EAGAIN) {
> > > +			/* GC needs to change VMAs. Drop all read-side state. */
> > > +			vma = NULL;
> > > +			up_read(&vm->lock);
> > > +			down_write(&vm->lock);
> > > +
> > > +			if (xe_vm_is_closed(vm)) {
> > > +				err = -ENOENT;
> > > +				error = XE_PAGEFAULT_ERROR_VM_CLOSED;
> > > +			} else {
> > > +				err = xe_svm_garbage_collect(vm);
> > > +				error = XE_PAGEFAULT_ERROR_SVM_GARBAGE_COLLECTOR;
> > > +			}
> > > +
> > > +			downgrade_write(&vm->lock);
> > > +			if (err) {
> > > +				xe_pagefault_set_error(pf, error);
> > > +				goto unlock_vm;
> > > +			}
> > > +
> > > +			xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_NONE);
> > > +			svm_relookup = true;
> > > +			goto lookup_vma;
> > > +		}
> > > +	} else {
> > >   		err = xe_pagefault_handle_vma(gt, vma, pf, atomic);
> > > +	}
> > >   unlock_vm:
> > >   	if (err)
> > > diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> > > index bc6902b5bf57..d19cb0c4b154 100644
> > > --- a/drivers/gpu/drm/xe/xe_svm.c
> > > +++ b/drivers/gpu/drm/xe/xe_svm.c
> > > @@ -356,12 +356,36 @@ static void xe_vma_set_default_attributes(struct xe_vma *vma)
> > >   	xe_vma_mem_attr_copy(&vma->attr, &default_attr);
> > >   }
> > > +/* vm->lock keeps the VMA and its attributes stable during this check. */
> > > +static bool xe_svm_range_needs_attr_reset(struct xe_vm *vm, u64 start)
> > > +{
> > > +	struct xe_vma *vma;
> > > +	u64 end;
> > > +
> > > +	lockdep_assert_held(&vm->lock);
> > > +
> > > +	vma = xe_vm_find_vma_by_addr(vm, start);
> > > +	if (!vma || !(vma->gpuva.flags & XE_VMA_MADV_AUTORESET))
> > > +		return false;
> > > +
> > > +	if (!xe_vma_has_default_mem_attrs(vma))
> > > +		return true;
> > > +
> > > +	start = xe_vma_start(vma);
> > > +	end = xe_vma_end(vma);
> > > +	xe_vm_find_cpu_addr_mirror_vma_range(vm, &start, &end);
> > > +
> > > +	return start != xe_vma_start(vma) || end != xe_vma_end(vma);
> > > +}
> > > +
> > >   static int xe_svm_range_set_default_attr(struct xe_vm *vm, u64 start, u64 end)
> > >   {
> > >   	struct xe_vma *vma;
> > >   	bool has_default_attr;
> > >   	int err;
> > > +	lockdep_assert_held_write(&vm->lock);
> > > +
> > >   	vma = xe_vm_find_vma_by_addr(vm, start);
> > >   	if (!vma)
> > >   		return -EINVAL;
> > > @@ -397,70 +421,134 @@ static int xe_svm_range_set_default_attr(struct xe_vm *vm, u64 start, u64 end)
> > >   		return err;
> > >   	}
> > > -	/*
> > > -	 * On call from xe_svm_handle_pagefault original VMA might be changed
> > > -	 * signal this to lookup for VMA again.
> > > -	 */
> > > -	return -EAGAIN;
> > > +	return 0;
> > >   }
> > > -static int xe_svm_garbage_collector(struct xe_vm *vm)
> > > +/*
> > > + * With reset_attrs false, defer ranges requiring a VMA change and return
> > > + * -EAGAIN after collecting the remaining ready ranges in the batch. The
> > > + * caller must release all read-side state before collecting them with
> > > + * vm->lock held for write.
> > > + */
> > > +static int xe_svm_garbage_collector(struct xe_vm *vm, bool reset_attrs)
> > >   {
> > >   	struct xe_svm_range *range;
> > > -	u64 range_start;
> > > -	u64 range_end;
> > > -	int err, ret = 0;
> > > +	LIST_HEAD(pending);
> > > +	LIST_HEAD(deferred);
> > > +	u64 range_start, range_end;
> > > +	bool needs_reset;
> > > +	int err = 0, ret = 0;
> > >   	lockdep_assert_held(&vm->lock);
> > > +	if (reset_attrs)
> > > +		lockdep_assert_held_write(&vm->lock);
> > >   	if (xe_vm_is_closed_or_banned(vm))
> > >   		return -ENOENT;
> > >   	guard(mutex)(&vm->svm.garbage_collector.lock);
> > > +	/* Process a finite batch, excluding events queued during this pass. */
> > > +	spin_lock(&vm->svm.garbage_collector.list_lock);
> > > +	if (list_empty(&vm->svm.garbage_collector.range_list)) {
> > > +		spin_unlock(&vm->svm.garbage_collector.list_lock);
> > > +		return 0;
> > > +	}
> > > +	list_splice_init(&vm->svm.garbage_collector.range_list, &pending);
> > > +	spin_unlock(&vm->svm.garbage_collector.list_lock);
> > > +
> > >   	for (;;) {
> > >   		spin_lock(&vm->svm.garbage_collector.list_lock);
> > > -		range = list_first_entry_or_null(&vm->svm.garbage_collector.range_list,
> > > -						 typeof(*range),
> > > +		range = list_first_entry_or_null(&pending, typeof(*range),
> > >   						 garbage_collector_link);
> > > -		if (!range)
> > > +		if (!range) {
> > > +			spin_unlock(&vm->svm.garbage_collector.list_lock);
> > >   			break;
> > > +		}
> > >   		range_start = xe_svm_range_start(range);
> > >   		range_end = xe_svm_range_end(range);
> > > -
> > >   		list_del(&range->garbage_collector_link);
> > >   		spin_unlock(&vm->svm.garbage_collector.list_lock);
> > > +		/*
> > > +		 * Keep the backing range alive until its attributes can be
> > > +		 * reset. The GC mutex excludes other collectors and explicit
> > > +		 * range removal requires vm->lock for write.
> > > +		 */
> > > +		needs_reset = xe_svm_range_needs_attr_reset(vm, range_start);
> > > +		if (needs_reset && !reset_attrs) {
> > > +			spin_lock(&vm->svm.garbage_collector.list_lock);
> > > +			list_add_tail(&range->garbage_collector_link, &deferred);
> > > +			spin_unlock(&vm->svm.garbage_collector.list_lock);
> > > +			ret = -EAGAIN;
> > > +			continue;
> > > +		}
> > > +
> > >   		err = __xe_svm_garbage_collector(vm, range);
> > >   		if (err) {
> > >   			drm_warn(&vm->xe->drm,
> > >   				 "Garbage collection failed: %pe\n",
> > >   				 ERR_PTR(err));
> > > +			/* Leave the failed range in the tree for VM teardown. */
> > >   			xe_vm_kill(vm, true);
> > > -			return err;
> > > +			goto out;
> > >   		}
> > > -		err = xe_svm_range_set_default_attr(vm, range_start, range_end);
> > > -		if (err) {
> > > -			if (err == -EAGAIN)
> > > -				ret = -EAGAIN;
> > > -			else
> > > -				return err;
> > > +		if (needs_reset) {
> > > +			err = xe_svm_range_set_default_attr(vm, range_start, range_end);
> > > +			if (err)
> > > +				goto out;
> > >   		}
> > >   	}
> > > +
> > > +out:
> > > +	/* Restore ranges not yet processed, including deferred resets. */
> > > +	spin_lock(&vm->svm.garbage_collector.list_lock);
> > > +	list_splice_tail_init(&pending, &vm->svm.garbage_collector.range_list);
> > > +	list_splice_tail_init(&deferred, &vm->svm.garbage_collector.range_list);
> > >   	spin_unlock(&vm->svm.garbage_collector.list_lock);
> > > -	return ret;
> > > +	return err ?: ret;
> > > +}
> > > +
> > > +/**
> > > + * xe_svm_garbage_collect() - Collect SVM ranges and reset their attributes
> > > + * @vm: The VM, with vm->lock held for write.
> > > + *
> > > + * Process one batch of queued ranges, including attribute resets. Ranges
> > > + * queued during this pass are left for a later collection.
> > > + *
> > > + * Call before changing advice or bindings, or querying attributes, so the
> > > + * batch is reset before applying new advice or reporting attributes.
> > > + * No VMA pointer may be retained across this call.
> > > + *
> > > + * Return: 0 on success, negative error code on error.
> > > + */
> > > +int xe_svm_garbage_collect(struct xe_vm *vm)
> > > +{
> > > +	lockdep_assert_held_write(&vm->lock);
> > > +
> > > +	if (!xe_vm_in_fault_mode(vm))
> > > +		return 0;
> > > +
> > > +	return xe_svm_garbage_collector(vm, true);
> > >   }
> > >   static void xe_svm_garbage_collector_work_func(struct work_struct *w)
> > >   {
> > >   	struct xe_vm *vm = container_of(w, struct xe_vm,
> > >   					svm.garbage_collector.work);
> > > +	int err = 0;
> > > -	guard(rwsem_read)(&vm->lock);
> > > -	xe_svm_garbage_collector(vm);
> > > +	scoped_guard(rwsem_read, &vm->lock)
> > > +		err = xe_svm_garbage_collector(vm, false);
> > > +
> > > +	if (err != -EAGAIN)
> > > +		return;
> > > +
> > > +	guard(rwsem_write)(&vm->lock);
> > > +	xe_svm_garbage_collect(vm);
> > >   }
> > >   #if IS_ENABLED(CONFIG_DRM_XE_PAGEMAP)
> > > @@ -1302,13 +1390,15 @@ static int __xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
> > >   	if (range) {
> > >   		mutex_unlock(&range->lock);
> > >   		drm_gpusvm_range_put(&range->base);
> > > -	}
> > > -	/* Always process UNMAPs first so view SVM ranges is current */
> > > -	err = xe_svm_garbage_collector(vm);
> > > -	if (err) {
> > > -		xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_SVM_GARBAGE_COLLECTOR);
> > > -		return err;
> > > +		/* The caller collected before the initial service attempt. */
> > > +		err = xe_svm_garbage_collector(vm, false);
> > > +		if (err) {
> > > +			if (err != -EAGAIN)
> > > +				xe_pagefault_set_error(pf,
> > > +						      XE_PAGEFAULT_ERROR_SVM_GARBAGE_COLLECTOR);
> > > +			return err;
> > > +		}
> > >   	}
> > >   	dpagemap = ctx.devmem_only ? xe_tile_local_pagemap(tile) :
> > > @@ -1468,14 +1558,28 @@ static int __xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
> > >    * Create GPU bindings for a SVM page fault. Optionally migrate to device
> > >    * memory.
> > >    *
> > > - * Return: 0 on success, negative error code on error.
> > > + * The caller must hold vm->lock for read. On -EAGAIN, discard @vma before
> > > + * releasing that lock. Collect with write access, then repeat VMA lookup
> > > + * and permission checks before retrying.
> > > + *
> > > + * Return: 0 on success, -EAGAIN if the caller must collect with write
> > > + * access and repeat VMA lookup, or another negative error code on error.
> > >    */
> > >   int xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
> > >   			    struct xe_pagefault *pf, struct xe_gt *gt,
> > >   			    u64 fault_addr, bool atomic)
> > >   {
> > >   	int need_vram, ret;
> > > -retry:
> > > +
> > > +	/* Consume older UNMAPs before reading advice or building the context. */
> > > +	ret = xe_svm_garbage_collector(vm, false);
> > > +	if (ret) {
> > > +		if (ret != -EAGAIN)
> > > +			xe_pagefault_set_error(pf,
> > > +					       XE_PAGEFAULT_ERROR_SVM_GARBAGE_COLLECTOR);
> > > +		return ret;
> > > +	}
> > > +
> > >   	need_vram = xe_vma_need_vram_for_atomic(vm->xe, vma, atomic);
> > >   	if (need_vram < 0) {
> > >   		xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_SVM_NEEDS_VRAM_CHECK);
> > > @@ -1485,18 +1589,9 @@ int xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
> > >   	ret =  __xe_svm_handle_pagefault(vm, vma, pf, gt, fault_addr,
> > >   					 need_vram ? true : false);
> > >   	if (ret == -EAGAIN) {
> > > -		/*
> > > -		 * Retry once on -EAGAIN to re-lookup the VMA, as the original VMA
> > > -		 * may have been split by xe_svm_range_set_default_attr.
> > > -		 */
> > > -		vma = xe_vm_find_vma_by_addr(vm, fault_addr);
> > > -		if (!vma) {
> > > -			xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_SVM_VMA_NOT_FOUND);
> > > -			return -EINVAL;
> > > -		}
> > > -
> > > +		/* Retry from the caller after collecting with write access. */
> > >   		xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_NONE);
> > > -		goto retry;
> > > +		return ret;
> > >   	}
> > >   	if (ret && xe_pagefault_get_error(pf) == XE_PAGEFAULT_ERROR_NONE)
> > >   		xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_SVM_SERVICE_FAILED);
> > > diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
> > > index ffc1cc808102..523213a8cd26 100644
> > > --- a/drivers/gpu/drm/xe/xe_svm.h
> > > +++ b/drivers/gpu/drm/xe/xe_svm.h
> > > @@ -109,6 +109,8 @@ void xe_svm_fini(struct xe_vm *vm);
> > >   void xe_svm_close(struct xe_vm *vm);
> > > +int xe_svm_garbage_collect(struct xe_vm *vm);
> > > +
> > >   int xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
> > >   			    struct xe_pagefault *pf, struct xe_gt *gt,
> > >   			    u64 fault_addr, bool atomic);
> > > @@ -316,6 +318,12 @@ void xe_svm_close(struct xe_vm *vm)
> > >   {
> > >   }
> > > +static inline
> > > +int xe_svm_garbage_collect(struct xe_vm *vm)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > >   static inline
> > >   int xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
> > >   			    struct xe_pagefault *pf, struct xe_gt *gt,
> > > diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> > > index d12365b11186..6afe6f1be1d4 100644
> > > --- a/drivers/gpu/drm/xe/xe_vm.c
> > > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > > @@ -1308,19 +1308,12 @@ static void vma_destroy_cb(struct dma_fence *fence,
> > >   	xe_destroy_wq_queue(&vma->destroy_work);
> > >   }
> > > -static void xe_vm_assert_write_mode_or_garbage_collector(struct xe_vm *vm)
> > > -{
> > > -	lockdep_assert(lockdep_is_held_type(&vm->lock, 0) ||
> > > -		       (lockdep_is_held_type(&vm->lock, 1) &&
> > > -			lockdep_is_held_type(&vm->svm.garbage_collector.lock, 0)));
> > > -}
> > > -
> > >   static void xe_vma_destroy(struct xe_vma *vma, struct dma_fence *fence)
> > >   {
> > >   	struct xe_vm *vm = xe_vma_vm(vma);
> > >   	struct xe_bo *bo = xe_vma_bo(vma);
> > > -	xe_vm_assert_write_mode_or_garbage_collector(vm);
> > > +	lockdep_assert_held_write(&vm->lock);
> > >   	xe_assert(vm->xe, list_empty(&vma->combined_links.destroy));
> > >   	if (xe_vma_is_userptr(vma)) {
> > > @@ -1416,7 +1409,7 @@ static int xe_vm_insert_vma(struct xe_vm *vm, struct xe_vma *vma)
> > >   	int err;
> > >   	xe_assert(vm->xe, xe_vma_vm(vma) == vm);
> > > -	xe_vm_assert_write_mode_or_garbage_collector(vm);
> > > +	lockdep_assert_held_write(&vm->lock);
> > >   	mutex_lock(&vm->snap_mutex);
> > >   	err = drm_gpuva_insert(&vm->gpuvm, &vma->gpuva);
> > > @@ -1429,7 +1422,7 @@ static int xe_vm_insert_vma(struct xe_vm *vm, struct xe_vma *vma)
> > >   static void xe_vm_remove_vma(struct xe_vm *vm, struct xe_vma *vma)
> > >   {
> > >   	xe_assert(vm->xe, xe_vma_vm(vma) == vm);
> > > -	xe_vm_assert_write_mode_or_garbage_collector(vm);
> > > +	lockdep_assert_held_write(&vm->lock);
> > >   	mutex_lock(&vm->snap_mutex);
> > >   	drm_gpuva_remove(&vma->gpuva);
> > > @@ -2267,7 +2260,7 @@ static int xe_vm_query_vmas(struct xe_vm *vm, u64 start, u64 end)
> > >   	struct drm_gpuva *gpuva;
> > >   	u32 num_vmas = 0;
> > > -	xe_vm_assert_write_mode_or_garbage_collector(vm);
> > > +	lockdep_assert_held(&vm->lock);
> > >   	drm_gpuvm_for_each_va_range(gpuva, &vm->gpuvm, start, end)
> > >   		num_vmas++;
> > > @@ -2280,7 +2273,7 @@ static int get_mem_attrs(struct xe_vm *vm, u32 *num_vmas, u64 start,
> > >   	struct drm_gpuva *gpuva;
> > >   	int i = 0;
> > > -	xe_vm_assert_write_mode_or_garbage_collector(vm);
> > > +	lockdep_assert_held(&vm->lock);
> > >   	drm_gpuvm_for_each_va_range(gpuva, &vm->gpuvm, start, end) {
> > >   		struct xe_vma *vma = gpuva_to_vma(gpuva);
> > > @@ -2330,6 +2323,12 @@ int xe_vm_query_vmas_attrs_ioctl(struct drm_device *dev, void *data, struct drm_
> > >   	if (err)
> > >   		goto put_vm;
> > > +	if (!xe_vm_is_closed_or_banned(vm)) {
> > > +		err = xe_svm_garbage_collect(vm);
> > > +		if (err)
> > > +			goto unlock_vm;
> > > +	}
> > > +
> > >   	attrs_user = u64_to_user_ptr(args->vector_of_mem_attr);
> > >   	if (args->num_mem_ranges == 0 && !attrs_user) {
> > > @@ -2487,7 +2486,7 @@ vm_bind_ioctl_ops_create(struct xe_vm *vm, struct xe_vma_ops *vops,
> > >   	u64 range_end = addr + range;
> > >   	int err;
> > > -	xe_vm_assert_write_mode_or_garbage_collector(vm);
> > > +	lockdep_assert_held_write(&vm->lock);
> > >   	vm_dbg(&vm->xe->drm,
> > >   	       "op=%d, addr=0x%016llx, range=0x%016llx, bo_offset_or_userptr=0x%016llx",
> > > @@ -2694,7 +2693,7 @@ static struct xe_vma *new_vma(struct xe_vm *vm, struct drm_gpuva_op_map *op,
> > >   	struct xe_vma *vma;
> > >   	int err = 0;
> > > -	xe_vm_assert_write_mode_or_garbage_collector(vm);
> > > +	lockdep_assert_held_write(&vm->lock);
> > >   	if (bo) {
> > >   		err = 0;
> > > @@ -2795,7 +2794,7 @@ static int xe_vma_op_commit(struct xe_vm *vm, struct xe_vma_op *op)
> > >   	switch (op->base.op) {
> > >   	case DRM_GPUVA_OP_MAP:
> > > -		xe_vm_assert_write_mode_or_garbage_collector(vm);
> > > +		lockdep_assert_held_write(&vm->lock);
> > >   		err |= xe_vm_insert_vma(vm, op->map.vma);
> > >   		if (!err)
> > > @@ -2806,7 +2805,7 @@ static int xe_vma_op_commit(struct xe_vm *vm, struct xe_vma_op *op)
> > >   		u8 tile_present =
> > >   			gpuva_to_vma(op->base.remap.unmap->va)->tile_present;
> > > -		xe_vm_assert_write_mode_or_garbage_collector(vm);
> > > +		lockdep_assert_held_write(&vm->lock);
> > >   		prep_vma_destroy(vm, gpuva_to_vma(op->base.remap.unmap->va),
> > >   				 true);
> > > @@ -2842,7 +2841,7 @@ static int xe_vma_op_commit(struct xe_vm *vm, struct xe_vma_op *op)
> > >   		break;
> > >   	}
> > >   	case DRM_GPUVA_OP_UNMAP:
> > > -		xe_vm_assert_write_mode_or_garbage_collector(vm);
> > > +		lockdep_assert_held_write(&vm->lock);
> > >   		prep_vma_destroy(vm, gpuva_to_vma(op->base.unmap.va), true);
> > >   		op->flags |= XE_VMA_OP_COMMITTED;
> > > @@ -2889,7 +2888,7 @@ static int vm_bind_ioctl_ops_parse(struct xe_vm *vm, struct drm_gpuva_ops *ops,
> > >   	u8 id, tile_mask = 0;
> > >   	int err = 0;
> > > -	xe_vm_assert_write_mode_or_garbage_collector(vm);
> > > +	lockdep_assert_held_write(&vm->lock);
> > >   	for_each_tile(tile, vm->xe, id)
> > >   		tile_mask |= 0x1 << id;
> > > @@ -3072,7 +3071,7 @@ static void xe_vma_op_unwind(struct xe_vm *vm, struct xe_vma_op *op,
> > >   	switch (op->base.op) {
> > >   	case DRM_GPUVA_OP_MAP:
> > > -		xe_vm_assert_write_mode_or_garbage_collector(vm);
> > > +		lockdep_assert_held_write(&vm->lock);
> > >   		if (op->map.vma) {
> > >   			prep_vma_destroy(vm, op->map.vma, post_commit);
> > > @@ -3083,7 +3082,7 @@ static void xe_vma_op_unwind(struct xe_vm *vm, struct xe_vma_op *op,
> > >   	{
> > >   		struct xe_vma *vma = gpuva_to_vma(op->base.unmap.va);
> > > -		xe_vm_assert_write_mode_or_garbage_collector(vm);
> > > +		lockdep_assert_held_write(&vm->lock);
> > >   		if (vma) {
> > >   			xe_svm_notifier_lock(vm);
> > > @@ -3098,7 +3097,7 @@ static void xe_vma_op_unwind(struct xe_vm *vm, struct xe_vma_op *op,
> > >   	{
> > >   		struct xe_vma *vma = gpuva_to_vma(op->base.remap.unmap->va);
> > > -		xe_vm_assert_write_mode_or_garbage_collector(vm);
> > > +		lockdep_assert_held_write(&vm->lock);
> > >   		if (op->remap.prev) {
> > >   			prep_vma_destroy(vm, op->remap.prev, prev_post_commit);
> > > @@ -4092,6 +4091,11 @@ int xe_vm_bind_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
> > >   		goto release_vm_lock;
> > >   	}
> > > +	/* Consume queued resets before replacing VMAs. */
> > > +	err = xe_svm_garbage_collect(vm);
> > > +	if (err)
> > > +		goto release_vm_lock;
> > > +
> > >   	for (i = 0; i < args->num_binds; ++i) {
> > >   		u64 range = bind_ops[i].range;
> > >   		u64 addr = bind_ops[i].addr;
> > > @@ -4907,7 +4911,7 @@ static int xe_vm_alloc_vma(struct xe_vm *vm,
> > >   	u16 default_pat;
> > >   	int err;
> > > -	xe_vm_assert_write_mode_or_garbage_collector(vm);
> > > +	lockdep_assert_held_write(&vm->lock);
> > >   	if (is_madvise)
> > >   		ops = drm_gpuvm_madvise_ops_create(&vm->gpuvm, map_req);
> > > @@ -5041,7 +5045,7 @@ int xe_vm_alloc_madvise_vma(struct xe_vm *vm, uint64_t start, uint64_t range)
> > >   		.map.va.range = range,
> > >   	};
> > > -	xe_vm_assert_write_mode_or_garbage_collector(vm);
> > > +	lockdep_assert_held_write(&vm->lock);
> > >   	vm_dbg(&vm->xe->drm, "MADVISE_OPS_CREATE: addr=0x%016llx, size=0x%016llx", start, range);
> > > @@ -5073,7 +5077,7 @@ void xe_vm_find_cpu_addr_mirror_vma_range(struct xe_vm *vm, u64 *start, u64 *end
> > >   {
> > >   	struct xe_vma *prev, *next;
> > > -	xe_vm_assert_write_mode_or_garbage_collector(vm);
> > > +	lockdep_assert_held(&vm->lock);
> > >   	if (*start >= SZ_4K) {
> > >   		prev = xe_vm_find_vma_by_addr(vm, *start - SZ_4K);
> > > @@ -5105,7 +5109,7 @@ int xe_vm_alloc_cpu_addr_mirror_vma(struct xe_vm *vm, uint64_t start, uint64_t r
> > >   		.map.va.range = range,
> > >   	};
> > > -	xe_vm_assert_write_mode_or_garbage_collector(vm);
> > > +	lockdep_assert_held_write(&vm->lock);
> > >   	vm_dbg(&vm->xe->drm, "CPU_ADDR_MIRROR_VMA_OPS_CREATE: addr=0x%016llx, size=0x%016llx",
> > >   	       start, range);
> > > diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_vm_madvise.c
> > > index 5c7aefc641ee..1af5e79bbfd3 100644
> > > --- a/drivers/gpu/drm/xe/xe_vm_madvise.c
> > > +++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
> > > @@ -638,6 +638,11 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
> > >   		goto unlock_vm;
> > >   	}
> > > +	/* Consume queued resets before publishing new advice. */
> > > +	err = xe_svm_garbage_collect(vm);
> > > +	if (err)
> > > +		goto unlock_vm;
> > > +
> > >   	err = xe_madvise_details_init(vm, args, &details);
> > >   	if (err)
> > >   		goto unlock_vm;
> > > -- 
> > > 2.43.0
> > > 
