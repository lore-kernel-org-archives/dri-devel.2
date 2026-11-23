Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DD9606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dHVvsyTZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=c3G31SnN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 992C410EC58;
	Mon, 23 Nov 2026 18:08:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 082FB10EC58;
 Mon, 23 Nov 2026 18:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795457306; x=1826993306;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Stl4K4fJl9se4zMhNSdxm3KXDgqJz9tsG+nE3YKEUnQ=;
 b=dHVvsyTZ/PnVZtg5e7bqkOwExDtmDSWqeGSegY7w6M9KoSwJrl2w2yTt
 +CUVfXT4USD5HyPVAMkYX0kOYnFewho7xwtRaCLDJZp2O57j0h8oqTxXu
 Os+7HUldl68xQM7zBIWhqfA88JAA5qQTde5f9nyMVSqScbuLXxnx4r1g3
 gcJc6wUTEYVzoRD/bbrdkWfBC2Z/8EvRD23VkVu6rnHGMwmTV0tsDJefR
 kfX80NfidNAsB/Nwz1TZ8kMUFYschPJ2RG2wuWIdYvhLIJVaGma1n6bCE
 U5/HCMeIEd3EU5yFEF8KIHiU5vqXW7c3wlEuMjdygvO5/hT81WQo5wigD A==;
X-CSE-ConnectionGUID: iQhCVTswTpSVbwxE6KWiHw==
X-CSE-MsgGUID: HBu5DguzREit5L2lxvxdVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4163543"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4163543"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 10:08:25 -0800
X-CSE-ConnectionGUID: xKEocC2xRcu3tBop8EP2IA==
X-CSE-MsgGUID: 2ikJ4aVXRnGHTYfGSkbkwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11569331"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 10:08:25 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 10:08:24 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 10:08:24 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 10:08:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWC4JapfjZSZpBcrXM5JUBah7mbQNFrWLR5dluN9PAD803zU44gLOT5PKhNceQH2MZrcm189SdCQSLPl6vHCFm8rhTnIGh6O/6vJxm0GD8z92pBt6c8lQebe6o7gJJq+/Pp47VFg3mQ54YO9LOY+yWIgTtYhTeqo19tl02zOltqvFutgydr1Szrq0vDXZ3STb7b7ZO5FvJX1u0LvcDD7pwvBHE7KyY+z0P3Pf0YyyjMIODx+mLo1eTqjiWV+QNk6f1wsbmKRllJlFocNnol/oxT4azjJGZu0T9v0vXlJmmzVmd+CD6Vg0V1B3T+4DTAZSOYBnr+YINDzZ/FGzmcLsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kl7gIPkHMCTW5EynnK7Ug9M5wufdN0L/40GzLngPCc4=;
 b=d/+/VAoqjERtb9EMiQq6yktunrIrUVilC6wWB4CnKi5M47dE9K04S0XQjmomAvH4hAzTH4M6WvroDB+8fLTtfqFsAYRDfFPFYKlxLFdqIQggVsK4cNLxWoLQYMSXnLiLFiy7TjIqNKkFv5Wrh1P7d8UZC8ddXiG8iRJnJ7Ho5Dl2d9LWc5sTQdBJ3/1ZXsV/xDHpk6SkX5deQ5G8wRmzAXR8eQWbUQV8LRlMjm6lDhz8C9XvrtAYxd5yJQAakqh7eGaFPYf6IIjuPIn73s7t1UpZqpVQ/mMpVGPRyziNhk5mtPtY/Y325S5HyG3H7Pc3nOl8ma42QWSGBIiOHGcYxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kl7gIPkHMCTW5EynnK7Ug9M5wufdN0L/40GzLngPCc4=;
 b=c3G31SnNrISX0rPGQbKNQvK4dWmo6FWKU/onM3ZpVlB1qMar7Sh1yy/kXDnYYFzqUcjZABMUlYGfuiq8ZBuYURGUyYzbl3rKLk0msAMuodRDP3HpsGgon3cqFxJShlJlhN8Xe6GFCmZl6tKmF0zmo+G6gdKsgHIQWbo50K2L3YY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SN7PR11MB6922.namprd11.prod.outlook.com (2603:10b6:806:2a9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 18:08:21 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 18:08:21 +0000
Date: Mon, 23 Nov 2026 10:08:18 -0800
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
Subject: Re: [PATCH v3 07/33] drm/ttm: Harvest beneficial-order pages on
 defragmentation moves
Message-ID: <awSBEsu0qXRQg57F@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-8-matthew.brost@intel.com>
 <avKDURZLW9pvCFvF@nvishwa1-desk>
 <av9seBmEpkJn6ubW@gsse-cloud1.jf.intel.com>
 <awDTJ3p_o1dI6_i2@nvishwa1-desk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awDTJ3p_o1dI6_i2@nvishwa1-desk>
X-ClientProxiedBy: SJ0PR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:a03:338::15) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SN7PR11MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: 48180b82-6296-49f6-f91b-08df498cc214
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|261102123227099003|261102130727099003|261022075727099003|261022113327099003|261022105027099003|261022115727099003|261021123027099003|261021135927099003|261021121427099003|261021133027099003|261021130227099003|261028144727099003|261026121527099003|261026140227099003|261026130827099003|11063799006|261026135527099003|4143699003|56012099006|10067099003|22082099003|18002099003|6133799003|261009220027099003|261009221727099003|261009223327099003|261009223027099003|261009221227099003;
X-Microsoft-Antispam-Message-Info: vDGtwX+Ggq42BkDgOM0dEvyJQWABVnaSeSh+e2xoYB7XFsISDw7AyXSBT1Q7NB2HdiE5puqUJflViE1TDs+9+Exm3HoOimCe6Wm7Uf4ZIK8Z6bfr/qVTRr4rEEBwZN407UA/Ukh8fjL/KhGSRE1W9hORUpi+FFVHfEWx5IyVeyrm4P9u+zU86f4uEBmW6YJU72t42WGnpxrOwpUeYL5Y1DGlDYFr1+6Npxhv5wk0f+NTRXKjvEt6He2oSe1FixAGHiRpCr3XWK4ZPQ64FmQiIVR1ZYbFjQazXccdWhR+o5s54qvsaJifrz3UCt0xQhu3DrQDKX4HrySqzBT094cIds2Mine5mwmaOn2iFhlahUqMm5KX4pFOI9csyY5KJ2KU6VdHmHU/VraLWtvBiTmX2xBj9ekA7YEnY2bkOND39h8IBrqZaWd/KW+k0wtqmXrX8e8UuGh3epdo6ARc6gPREAu6mZMUUVOF/r2w3RCC+JNOZCjrnZ8oM8XlmD7lo7hhErKn28b/oPsBzt4SSIoElaaS7IA2vFpb7c3ZkgwH4Paxds/BSp4h65qMMEo/b01F/CsmIRwS91aUp6gLKmrcmmPhkRcFWYJy7t7bfa9oS+1vJ2t0eV5eUklEq8XUdX/3KLFSwI3sL72eplHJs8l39gMVNfDnY/8KQokxRJG2rkQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(261102123227099003)(261102130727099003)(261022075727099003)(261022113327099003)(261022105027099003)(261022115727099003)(261021123027099003)(261021135927099003)(261021121427099003)(261021133027099003)(261021130227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261026130827099003)(11063799006)(261026135527099003)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(261009220027099003)(261009221727099003)(261009223327099003)(261009223027099003)(261009221227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bEctlJz8iP04rIL4KzLePN9pLuckrZ2+k63tCJtO9Q0IRbvciDOazR02Yt?=
 =?iso-8859-1?Q?6QD/8Mv/buK1Xkwe0PdW36Wg0GJp5izcS450rfGgs7g1YeljbFAcnzTIGk?=
 =?iso-8859-1?Q?3gvOJ0O5Ab9ZABW9rV0HMxPjESwj6U7qnMW5SiWIlyWEkfxsbJaFp/790r?=
 =?iso-8859-1?Q?FiNA+3QEyuVxwWbZ2/0qEKmlw0O/qnyygzLGNCjMD2ov+2N3F/fSX1F51O?=
 =?iso-8859-1?Q?IdyPSZqSILe0q3jPiKSc8UcfzVu2VYHBUOY9d4tPXxZ14ztfU767NqIreO?=
 =?iso-8859-1?Q?eTmXo5eaJrT/T0uCJ2/phvShRbiuM5GViG4kX7qfmzEoNd8K8Iy/unkOjF?=
 =?iso-8859-1?Q?iHWmR02kaw3xYqCGnCcGrKvSrfXASgOQZ40xy973nja2xUoEbvXnRrD+p3?=
 =?iso-8859-1?Q?YACjZvzNXUDlrr/thJDK618L6HsjQ2BYV8BWvOZ8vmFtdkTQwSLPML21Bx?=
 =?iso-8859-1?Q?K+uwnnZjAjhy/geVGSlkPhtHZF10hUeUhj3GgA4fnyARso9InUXTcaJgit?=
 =?iso-8859-1?Q?/C6LxZ9jSb8zf26d/KyGXIRPhHWzFlmx3D2YesPHfJx38QujhqrLDWOyiB?=
 =?iso-8859-1?Q?MHYxFGrJ6fFMGyx/o7udgUacXgflX1TW0/Od8eliYtSJYODZMgoNWF6m6r?=
 =?iso-8859-1?Q?Gwv4NmxiDDSQC6Vxfw5x8qRMLOnfHvxINaA/RgScdQ1Uw02NRPYH1Z13/W?=
 =?iso-8859-1?Q?A0Q/tjoDe2dckniCHnl/ROpMU/vOt6g+n+keAv7ioZ5O3we3gMi1I5Yd96?=
 =?iso-8859-1?Q?DFJL5u+HSnoQCM3OBvdWlkzvcymLoAeyDplF4MQfY8Y1HczB5bd0WWIZdd?=
 =?iso-8859-1?Q?PTF8u+3CBLrmqIzNvXt5qZTq0BhEsdcHq0rfilfBDAayz7M1s7y5VL3KCQ?=
 =?iso-8859-1?Q?GfBZcm7jJVFw+QXAxGeiMnU0sZXnB57DxbXf9fdf8zue13lR9otKqdgfdl?=
 =?iso-8859-1?Q?PJBjlOfJ2GPK8sHy/iej/CXJy87sX2zwKNeLHIpY3eMQPeH2vKIW6FrsGZ?=
 =?iso-8859-1?Q?Apf+msAkc/kX10a3sZg8nRNj4lO6XWqB2xgkIoi7K6D7/GLoH+zkXaTrrl?=
 =?iso-8859-1?Q?loA9cD7Z0sINX2nURrQVukG0jToFgjElKMgIhWTmadZIP9C3+1ur2uUi4k?=
 =?iso-8859-1?Q?7Marakxbi/j77LzLbMsiF3W1NZn2bcsqOHgxDF1kZacY2y6Kn1iefKCbNL?=
 =?iso-8859-1?Q?t9hcBFNbHFDdPQ7cJGxuiLYSb1923+z8LgmY1Hp3yZxUShcBU57aHNbYSX?=
 =?iso-8859-1?Q?pASzt+Q4BkwhFQBfywaCntQs/QhTYa2+weXpe1qcOfIVyVHvYx33AFdVDs?=
 =?iso-8859-1?Q?HtD1KagqYshG9LVL2d/6f3jOCJwWs/LsFu/dM6gdUzy4yWjxoWbcPVN6AT?=
 =?iso-8859-1?Q?nDOgeIhZmYQNyYDb9bdAB1IjXOsmusIY7mvlFqcrO2XWJ0PyVDggm+ymFh?=
 =?iso-8859-1?Q?2JKoNH5fRQ11MdXSnrs0x6t0Z7smlWaxMCPFnUMrd4VqBM2cOY96cBNUki?=
 =?iso-8859-1?Q?tM8778lQ3zoh6Ht7KkDuisMbJfp3Hu0d+Ka+FdcQgeon+7lEwi4pPuuRlK?=
 =?iso-8859-1?Q?OUqfY58L24T37ZBJ2NqZUYTBat5Ob+80pjQ466QiHQRQewBoiQnrLfAEP7?=
 =?iso-8859-1?Q?5Vn85EjeM3FhkqWeFNKKwSxFdYkr6nPNuD6GZ2CLbZaMwWXap+7lXmGK9s?=
 =?iso-8859-1?Q?M0qDQVmKRPC/31A6pnfHvqgehwGLzU99WhWU60iHZ2EuK89MX9ecKaBJd5?=
 =?iso-8859-1?Q?6DvM+0ncv0y49VWEJSe1YdtWHlvujy8l4QOSoVK6BLxKorqGPU8q8ZNm1c?=
 =?iso-8859-1?Q?lTPSBQ3nuw=3D=3D?=
X-Exchange-RoutingPolicyChecked: ZAnJ78MqR8rstZwaogF6QDncAQm+qnnd+REAr365DB4/E261nAEpxAo5fdqf9NWhKvF/kP/711Mdnsbe1yfyw4vTdLfak47OBmMDN91FnmmtOFJHLHS24jyclNcqfrVQFhsZBXQ9HyJ1oAEykJDsUaIIRMmV5ywYNO0c7abNUD5iZK/NC0GVt+J0le5FNiOubsJZd9kZ12O4l52j3dgETd8dhxuMZqYn+4lwSPpPFvT57kiR0lbL2uCLCn/aRMkCPnQE/sS9sw7RsSNOEOr+Aoz27jVCLtqwjnIn1NinPx+h5dmHZ4hqkuMVBeJ87Qtb5+sZrdLOkPQf0cs8Ve81Xw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 48180b82-6296-49f6-f91b-08df498cc214
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 18:08:21.1871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inZPzcGQSyy/EMVdD561l2bijdyqKmR9XAeGmfrQf6bnPz6likrM4cq6pD5glda4vxLCB4/eO83FwbLpA6Y6jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6922
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

On Fri, Nov 20, 2026 at 03:09:27PM -0800, Niranjana Vishwanathapura wrote:
> On Thu, Nov 19, 2026 at 01:39:04PM -0800, Matthew Brost wrote:
> > On Mon, Nov 09, 2026 at 06:37:05PM -0800, Niranjana Vishwanathapura wrote:
> > > On Fri, Jul 10, 2026 at 07:55:53PM -0700, Matthew Brost wrote:
> > > > A defragmentation move relocates a populated tt into a freshly allocated
> > > > one so that sub-beneficial-order chunks can be upgraded to the device's
> > > > beneficial order. Previously, if allocation could not complete entirely
> > > > at beneficial order, the move failed and all progress was discarded.
> > > >
> > > > Instead, once allocation has successfully upgraded part of the object,
> > > > the remainder of the old tt is harvested to complete the new tt. Thread
> > > > the BO's old, still-populated tt into the page allocator via a new
> > > > ttm_operation_ctx::defrag_old_tt. While allocation is still proceeding,
> > > > any existing chunk already at (or above) the beneficial order is reused
> > > > directly instead of being reallocated. If allocation later has to fall
> > > > back below beneficial_order after making partial progress, the remainder
> > > > of the old tt is harvested instead of failing the move. This preserves
> > > > the beneficial-order upgrades already made while leaving the rest of the
> > > > object unchanged, allowing subsequent defragmentation attempts to make
> > > > additional forward progress.
> > > >
> > > > Harvesting only borrows the pages; they remain owned by the old tt until
> > > > the move commits. This keeps every unwind path non-destructive: if the
> > > > (re)allocation or the move later fails, the new tt is torn down without
> > > > freeing the borrowed pages and the old tt is restored fully intact.
> > > > Ownership of the shared pages is transferred to the new tt only once the
> > > > move has committed. ttm_tt_defrag_disown_borrowed() implements both
> > > > directions of the transfer by clearing a tt's slots for every page it
> > > > shares with the other tt (same struct page at the same index), so that
> > > > tt's teardown leaves the shared pages alone and each page is freed
> > > > exactly once by its owner:
> > > >
> > > > - on the alloc unwind and the failed-move paths, the new tt disowns the
> > > >  borrowed pages, leaving the old tt as the sole owner;
> > > > - on the successful-move paths (synchronous teardown and the pipelined
> > > >  ghost-object teardown), the old tt disowns the now-transferred pages,
> > > >  leaving the new tt as the sole owner.
> > > >
> > > > Detecting shared pages by same-index struct page identity needs no extra
> > > > per-tt bookkeeping, since two distinct allocations never alias. This is
> > > > safe with drivers, such as Xe, that build their own per-tt sg table and
> > > > DMA-map it independently: each tt maps and unmaps its own sg, so sharing
> > > > the underlying pages between tts is DMA-clean.
> > > >
> > > > This is a no-op unless ctx->defrag_old_tt is set, which only happens on a
> > > > defragmentation move.
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
> > > >
> > > > ---
> > > >
> > > > v3:
> > > > - Document the chunk-head invariant read by
> > > >   ttm_pool_harvest_remaining() (Sashiko)
> > > > ---
> > > > drivers/gpu/drm/ttm/ttm_bo.c      |  20 ++-
> > > > drivers/gpu/drm/ttm/ttm_bo_util.c |   5 +
> > > > drivers/gpu/drm/ttm/ttm_pool.c    | 235 ++++++++++++++++++++++++++++--
> > > > drivers/gpu/drm/ttm/ttm_tt.c      |  67 +++++++++
> > > > include/drm/ttm/ttm_bo.h          |  12 ++
> > > > include/drm/ttm/ttm_tt.h          |   2 +
> > > > 6 files changed, 328 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> > > > index c1629b4c4f0f..ab2e637a017f 100644
> > > > --- a/drivers/gpu/drm/ttm/ttm_bo.c
> > > > +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> > > > @@ -182,7 +182,14 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
> > > > 		}
> > > >
> > > > 		if (defrag_old_tt || mem->mem_type != TTM_PL_SYSTEM) {
> > > > +			/*
> > > > +			 * Let the page allocator harvest already
> > > > +			 * beneficial-order chunks out of the old tt to back
> > > > +			 * the new one, rather than reallocating them.
> > > > +			 */
> > > > +			ctx->defrag_old_tt = defrag_old_tt;
> > > > 			ret = ttm_bo_populate(bo, ctx);
> > > > +			ctx->defrag_old_tt = NULL;
> > > > 			if (ret) {
> > > > 				/*
> > > > 				 * Discharge the freshly allocated backing and
> > > > @@ -235,6 +242,12 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
> > > > 	}
> > > >
> > > > 	if (bo->defrag_old_tt) {
> > > > +		/*
> > > > +		 * Successful defrag move: any pages the new tt borrowed from the
> > > > +		 * old tt are now owned by the new tt. Disown them from the old
> > > > +		 * tt before it is torn down so they are not freed.
> > > > +		 */
> > > > +		ttm_tt_defrag_disown_borrowed(bo->defrag_old_tt, bo->ttm);
> > > > 		ttm_tt_unpopulate(bo->bdev, bo->defrag_old_tt);
> > > > 		ttm_tt_destroy(bo->bdev, bo->defrag_old_tt);
> > > > 		bo->defrag_old_tt = NULL;
> > > > @@ -245,7 +258,12 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
> > > >
> > > > out_err:
> > > > 	if (bo->defrag_old_tt) {
> > > > -		/* Failed defrag move: restore the original backing. */
> > > > +		/*
> > > > +		 * Failed defrag move: drop any pages the new tt borrowed from
> > > > +		 * the old tt (still owned by the old tt) before destroying the
> > > > +		 * new tt, then restore the original backing.
> > > > +		 */
> > > > +		ttm_tt_defrag_disown_borrowed(bo->ttm, bo->defrag_old_tt);
> > > > 		ttm_bo_tt_destroy(bo);
> > > > 		bo->ttm = bo->defrag_old_tt;
> > > > 		bo->defrag_old_tt = NULL;
> > > > diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
> > > > index 771313162c8d..7cb718fc97c0 100644
> > > > --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> > > > +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> > > > @@ -633,7 +633,12 @@ static int ttm_bo_move_to_ghost(struct ttm_buffer_object *bo,
> > > > 		 * tt (the move's source) to the ghost so it is kept populated
> > > > 		 * until @fence signals and then unbound and destroyed, instead
> > > > 		 * of being torn down synchronously. @bo keeps its new tt.
> > > > +		 *
> > > > +		 * Any pages the new tt borrowed from the old tt are now owned by
> > > > +		 * the new tt; disown them from the old tt so the ghost teardown
> > > > +		 * leaves them alone.
> > > > 		 */
> > > > +		ttm_tt_defrag_disown_borrowed(bo->defrag_old_tt, bo->ttm);
> > > > 		ghost_obj->ttm = bo->defrag_old_tt;
> > > > 		ghost_obj->defrag_old_tt = NULL;
> > > > 		bo->defrag_old_tt = NULL;
> > > > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> > > > index 2598d2f33767..52f5e64f05dd 100644
> > > > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > > > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > > > @@ -792,6 +792,148 @@ static unsigned int ttm_pool_alloc_find_order(unsigned int highest,
> > > > 	return min_t(unsigned int, highest, __fls(alloc->remaining_pages));
> > > > }
> > > >
> > > > +/*
> > > > + * Defragmentation page harvesting.
> > > > + *
> > > > + * A defrag move relocates a populated tt into a freshly allocated one in order
> > > > + * to upgrade sub-beneficial-order chunks to the device's beneficial order.
> > > > + * Chunks in the old tt (ctx->defrag_old_tt) that are ALREADY at the beneficial
> > > > + * order do not need to be reallocated: their physical pages can simply be
> > > > + * transferred ("harvested") into the new tt at the same offset, avoiding the
> > > > + * alloc/free churn that is significant for large buffers.
> > > > + *
> > > > + * Harvesting only borrows the pages: the new tt simply references the old tt's
> > > > + * pages, which remain owned by the old tt. This keeps the unwind paths simple -
> > > > + * if the (re)allocation or the move later fails, the new tt is torn down without
> > > > + * freeing the borrowed pages and the old tt is restored fully intact. Ownership
> > > > + * of the shared pages is transferred to the new tt only once the move has
> > > > + * committed, via ttm_tt_defrag_disown_borrowed() (see ttm_tt.c).
> > > > + */
> > > > +
> > > > +/*
> > > > + * Return the allocation order of the old tt chunk whose head sits at @off, or 0
> > > > + * if @off is not an old chunk head (it falls inside a chunk, or the slot is
> > > > + * empty / backed up). @cursor monotonically tracks the old chunk boundary and
> > > > + * must be advanced past every offset that has already been queried; a page
> > > > + * order may only be read from a chunk head page, hence the lazy walk.
> > > > + */
> > > > +static unsigned int ttm_pool_defrag_old_order(struct ttm_pool *pool,
> > > > +					      struct ttm_tt *old_tt,
> > > > +					      pgoff_t off, pgoff_t *cursor)
> > > > +{
> > > > +	struct page *p;
> > > > +
> > > > +	while (*cursor < off) {
> > > > +		p = old_tt->pages[*cursor];
> > > > +		if (!p || ttm_backup_page_ptr_is_handle(p))
> > > > +			return 0;
> > > 
> > > Assisted-by: LLM
> > > 
> > 
> > Yes.
> > 
> > > ttm_backup_page_ptr_is_handle() is only check here, but not in the harvest
> > > function. Probably we won't endup with ptr_is_handle() case during defrag,
> > > but thisasymmetry makes it bit confusing.
> > > 
> > 
> > In Xe we only allow defrag in TT placement, so
> > ttm_backup_page_ptr_is_handle probably could be omitted here.
> > 
> 
> Or may be add this check in harvest function also? It is probably better
> to add the check in both places (probably better than adding an assert
> here to ensure we never come here with ptr as a handle).
> 

Sure, so if ttm_backup_page_ptr_is_handle(p), the order of harvest is zero.

> > > > +		*cursor += 1UL << ttm_pool_page_order(pool, p);
> > > > +	}
> > > > +
> > > > +	if (*cursor != off)
> > > > +		return 0;
> > > > +
> > > > +	p = old_tt->pages[off];
> > > > +	if (!p || ttm_backup_page_ptr_is_handle(p))
> > > > +		return 0;
> > > > +
> > > > +	return ttm_pool_page_order(pool, p);
> > > > +}
> > > > +
> > > > +/*
> > > > + * Borrow an already beneficial-order chunk from the old tt into @alloc. The
> > > > + * pages stay owned by the old tt until the move commits.
> > > > + */
> > > > +static int ttm_pool_harvest_page(struct ttm_tt *old_tt, unsigned int order,
> > > > +				 pgoff_t off, struct ttm_pool_alloc_state *alloc)
> > > > +{
> > > > +	pgoff_t nr = 1UL << order;
> > > > +	int r;
> > > > +
> > > > +	/*
> > > > +	 * A harvested chunk keeps the (same) bo's caching, so the deferred
> > > > +	 * caching range is consistent here; flush it before committing, exactly
> > > > +	 * like the caching-consistent path in ttm_pool_page_allocated().
> > > > +	 */
> > > > +	r = ttm_pool_apply_caching(alloc);
> > > > +	if (r)
> > > > +		return r;
> > > > +
> > > > +	/*
> > > > +	 * The borrowed chunk's page pointers (consecutive struct pages of one
> > > > +	 * compound allocation) and dma addresses already sit contiguously in
> > > > +	 * the old tt at @off. Copy the whole run with memcpy() instead of the
> > > > +	 * per-page increment loop in ttm_pool_allocated_page_commit(): for a
> > > > +	 * large defrag the borrowed pages dominate the new tt, so this turns
> > > > +	 * the populate fill from O(num_pages) individual stores into a handful
> > > > +	 * of bulk copies.
> > > > +	 */
> > > > +	memcpy(alloc->pages, &old_tt->pages[off], nr * sizeof(*alloc->pages));
> > > > +	alloc->pages += nr;
> > > > +	alloc->remaining_pages -= nr;
> > > > +
> > > > +	if (alloc->dma_addr) {
> > > > +		memcpy(alloc->dma_addr, &old_tt->dma_address[off],
> > > > +		       nr * sizeof(*alloc->dma_addr));
> > > > +		alloc->dma_addr += nr;
> > > > +	}
> > > > +
> > > > +	alloc->caching_divide = alloc->pages;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int ttm_pool_harvest_remaining(struct ttm_pool *pool,
> > > > +				      struct ttm_tt *old_tt, pgoff_t off,
> > > > +				      struct ttm_pool_alloc_state *alloc)
> > > > +{
> > > > +	/*
> > > > +	 * @off is always an old-tt chunk head here, never a tail page, so
> > > > +	 * reading the per-chunk order below is safe. This holds because:
> > > > +	 *  - Old chunks are self-aligned: greedy largest-power-of-two fill
> > > > +	 *    places an order-k chunk at a 2^k-aligned offset, so any
> > > > +	 *    beneficial-order-aligned offset is a chunk boundary.
> > > > +	 *  - Fresh defrag allocations are capped at the beneficial order (see
> > > > +	 *    ttm_pool_iter_acquire_page()), so they advance @off in beneficial
> > > > +	 *    steps and never overshoot into the middle of a larger old chunk;
> > > > +	 *    super-beneficial old chunks are always harvested whole by
> > > > +	 *    ttm_pool_iter_reuse_old().
> > > > +	 *  - We are only reached once the defrag budget/prealloc is exhausted,
> > > > +	 *    which in the capped/prealloc config leaves @off beneficial-aligned
> > > > +	 *    (or, in the sub-beneficial tail, already walking old boundaries).
> > > > +	 */
> > > > +	while (alloc->remaining_pages) {
> > > > +		struct page *p = old_tt->pages[off];
> > > > +		unsigned int order = ttm_pool_page_order(pool, p);
> > > > +		pgoff_t nr = 1UL << order;
> > > > +		int r;
> > > > +
> > > > +		r = ttm_pool_harvest_page(old_tt, order, off, alloc);
> > > > +		if (r)
> > > > +			return r;
> > > > +
> > > > +		off += nr;
> > > > +	}
> > > 
> > > The 'off' being always at chunk head is documented, but not checked/enforced
> > > in the code. Though currently, we won't have it otherwise, but tomorrow if
> > 
> > I don't know how to enforce this. p->private is the chunk order at the
> > head page only but an order of 0 is a valid value, i.e., I'm not sure
> > how to implement 'page is chunk head' in the current code.
> > 
> 
> Yah, currently we don't seem to have a good way.
> 
> Perhaps we can add below checks, though that is not eactly what we want?
> 
> WARN_ON_ONCE(!IS_ALIGNED(off, 1UL << order));
> WARN_ON_ONCE(off + (1UL << order) > old_tt->num_pages);
> 

TTM isn't like Xe where we assert all of sorts of things - it just isn't
the style. I'd rather not liter is with open coded WARN_ON that do not
compile out in the case xe_assert.

Matt

> > > we do for some reason, it will go unnoticed. Probably worth adding a warning
> > > here.
> > > 
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +/**
> > > > + * enum ttm_pool_iter_action - Outcome of a per-order allocation phase
> > > > + * @TTM_POOL_ITER_FILL: A page (@it->p) was acquired; proceed to fill it in.
> > > > + * @TTM_POOL_ITER_RETRY: Loop state was adjusted (e.g. order lowered or a chunk
> > > > + *	harvested); re-enter the loop body for the next order.
> > > > + * @TTM_POOL_ITER_STOP: The allocation is complete; stop the loop.
> > > > + *
> > > > + * Phase helpers return one of these (>= 0) on success, or a negative errno on
> > > > + * failure (the caller then unwinds via error_free_all).
> > > > + */
> > > > +enum ttm_pool_iter_action {
> > > > +	TTM_POOL_ITER_FILL,
> > > > +	TTM_POOL_ITER_RETRY,
> > > > +	TTM_POOL_ITER_STOP,
> > > 
> > > NIT...STOP is really not needed here, RETRY will do as the loop is
> > > expected to end there. But it is fine.
> > > 
> > 
> > Not following this - __ttm_pool_alloc look at TTM_POOL_ITER_RETRY vs
> > STOP.
> 
> I mean if we return RETRY instead of STOP, the behaviour will be the
> same as it breaks out of the loop as alloc->remaining_pages is 0.
> 
> Niranjana
> 
> > 
> > > > +};
> > > > +
> > > > /**
> > > >  * struct ttm_pool_alloc_iter - Working state for the __ttm_pool_alloc() loop
> > > >  *
> > > > @@ -806,6 +948,7 @@ struct ttm_pool_alloc_iter {
> > > > 	const struct ttm_operation_ctx *ctx;
> > > > 	struct ttm_pool_alloc_state *alloc;
> > > > 	struct ttm_pool_tt_restore *restore;
> > > > +	struct ttm_tt *defrag_old_tt;
> > > > 	unsigned int beneficial_order;
> > > > 	gfp_t gfp_flags;
> > > >
> > > > @@ -814,9 +957,50 @@ struct ttm_pool_alloc_iter {
> > > > 	enum ttm_caching page_caching;
> > > > 	bool allow_pools;
> > > > 	bool fail_beneficial;
> > > > +	unsigned int alloc_count;
> > > > +	pgoff_t old_cursor;
> > > > 	struct page *p;
> > > > };
> > > >
> > > > +/*
> > > > + * Defrag move: reuse an already beneficial-order chunk from the old tt at this
> > > > + * offset rather than reallocating it. Harvest whatever order the old chunk has
> > > > + * (>= beneficial order), which may exceed the order the new tt would otherwise
> > > > + * pick. An order below beneficial_order is only reused for the unaligned tail
> > > > + * (where there is no benefit to reallocating). Only borrows the pages; the alloc
> > > > + * unwind path can drop them again.
> > > > + *
> > > > + * Returns TTM_POOL_ITER_RETRY when a chunk was harvested, TTM_POOL_ITER_FILL to
> > > > + * fall through to a fresh allocation, or a negative errno.
> > > > + */
> > > > +static int ttm_pool_iter_reuse_old(struct ttm_pool_alloc_iter *it)
> > > > +{
> > > > +	unsigned int harvest_order;
> > > > +	pgoff_t off;
> > > > +	int r;
> > > > +
> > > > +	if (!it->defrag_old_tt || !it->beneficial_order)
> > > > +		return TTM_POOL_ITER_FILL;
> > > > +
> > > > +	off = it->tt->num_pages - it->alloc->remaining_pages;
> > > > +	harvest_order = ttm_pool_defrag_old_order(it->pool, it->defrag_old_tt,
> > > > +						  off, &it->old_cursor);
> > > > +
> > > > +	if (harvest_order < it->beneficial_order &&
> > > > +	    it->order >= it->beneficial_order)
> > > > +		return TTM_POOL_ITER_FILL;
> > > > +
> > > > +	it->order = harvest_order;
> > > > +	r = ttm_pool_harvest_page(it->defrag_old_tt, it->order, off, it->alloc);
> > > > +	if (r)
> > > > +		return r;
> > > > +
> > > > +	it->page_caching = it->tt->caching;
> > > > +	it->allow_pools = true;
> > > > +
> > > > +	return TTM_POOL_ITER_RETRY;
> > > > +}
> > > > +
> > > > /*
> > > >  * Acquire a single page for the current order, leaving it in @it->p (NULL on
> > > >  * failure). Tries a same-order pool page, then a fresh system allocation. Fault
> > > > @@ -859,9 +1043,10 @@ static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
> > > > /*
> > > >  * The current order could not be satisfied. Lower it and retry, recording a
> > > >  * sub-optimal backing (so the driver can later re-defrag) when we drop below
> > > > - * the beneficial order.
> > > > + * the beneficial order. For a defrag move that has already made partial
> > > > + * progress, harvest the remaining old pages and stop instead.
> > > >  *
> > > > - * Returns 0 to retry the (lowered) order, or a negative errno.
> > > > + * Returns TTM_POOL_ITER_RETRY, TTM_POOL_ITER_STOP, or a negative errno.
> > > >  */
> > > > static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
> > > > {
> > > > @@ -871,16 +1056,24 @@ static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
> > > > 	if (!it->order)
> > > > 		return -ENOMEM;
> > > >
> > > > -	/*
> > > > -	 * Failing to allocate at the device's beneficial order means we are
> > > > -	 * about to back this object with a sub-optimal (smaller order) set of
> > > > -	 * pages. Record it so the driver can later try to defragment the object
> > > > -	 * back to beneficial order.
> > > > -	 */
> > > > 	if (it->fail_beneficial || at_beneficial) {
> > > > 		it->tt->page_flags |= TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
> > > > -		if (it->ctx->defrag)
> > > > +
> > > > +		if (it->alloc_count && it->defrag_old_tt) {
> > > > +			pgoff_t off = it->tt->num_pages -
> > > > +				      it->alloc->remaining_pages;
> > > > +			int r;
> > > > +
> > > > +			r = ttm_pool_harvest_remaining(it->pool,
> > > > +						       it->defrag_old_tt, off,
> > > > +						       it->alloc);
> > > > +			if (r)
> > > > +				return r;
> > > > +
> > > > +			return TTM_POOL_ITER_STOP;
> > > > +		} else if (it->defrag_old_tt) {
> > > > 			return -ENOMEM;
> > > > +		}
> > > > 	}
> > > >
> > > > 	if (it->fail_beneficial)
> > > > @@ -890,7 +1083,7 @@ static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
> > > > 	it->page_caching = it->tt->caching;
> > > > 	it->allow_pools = true;
> > > >
> > > > -	return 0;
> > > > +	return TTM_POOL_ITER_RETRY;
> > > > }
> > > >
> > > > static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > > > @@ -904,6 +1097,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > > > 		.ctx = ctx,
> > > > 		.alloc = alloc,
> > > > 		.restore = restore,
> > > > +		.defrag_old_tt = restore ? NULL : ctx->defrag_old_tt,
> > > > 		.beneficial_order = ttm_pool_beneficial_order(pool),
> > > > 		.page_caching = tt->caching,
> > > > 		.allow_pools = true,
> > > > @@ -931,13 +1125,22 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > > > 	for (it.order = ttm_pool_alloc_find_order(MAX_PAGE_ORDER, alloc);
> > > > 	     alloc->remaining_pages;
> > > > 	     it.order = ttm_pool_alloc_find_order(it.order, alloc)) {
> > > > +		/* Reuse an already beneficial-order chunk from the old tt. */
> > > > +		r = ttm_pool_iter_reuse_old(&it);
> > > > +		if (r < 0)
> > > > +			goto error_free_all;
> > > > +		if (r == TTM_POOL_ITER_RETRY)
> > > > +			continue;
> > > > +
> > > > 		/* Acquire a page (pool / system) for this order. */
> > > > 		ttm_pool_iter_acquire_page(&it);
> > > > 		if (!it.p) {
> > > > 			r = ttm_pool_iter_lower_order(&it);
> > > > -			if (r)
> > > > +			if (r < 0)
> > > > 				goto error_free_all;
> > > > -			continue;
> > > > +			if (r == TTM_POOL_ITER_RETRY)
> > > > +				continue;
> > > > +			break;	/* TTM_POOL_ITER_STOP */
> > > > 		}
> > > >
> > > > 		r = ttm_pool_page_allocated(pool, it.order, it.p,
> > > > @@ -951,6 +1154,8 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > > > 			if (r)
> > > > 				goto error_free_all;
> > > > 		}
> > > > +
> > > > +		it.alloc_count++;
> > > > 	}
> > > >
> > > > 	r = ttm_pool_apply_caching(alloc);
> > > > @@ -969,6 +1174,12 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > > > 	if (tt->restore)
> > > > 		return r;
> > > >
> > > > +	/*
> > > > +	 * Drop any pages borrowed from the old tt during a defrag move: they are
> > > > +	 * still owned by the old tt and must not be freed here.
> > > > +	 */
> > > > +	ttm_tt_defrag_disown_borrowed(tt, it.defrag_old_tt);
> > > > +
> > > > 	caching_divide = alloc->caching_divide - tt->pages;
> > > > 	ttm_pool_free_range(pool, tt, tt->caching, 0, caching_divide);
> > > > 	ttm_pool_free_range(pool, tt, ttm_cached, caching_divide,
> > > > diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
> > > > index b645a1818184..2388ff794a59 100644
> > > > --- a/drivers/gpu/drm/ttm/ttm_tt.c
> > > > +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> > > > @@ -450,6 +450,73 @@ void ttm_tt_unpopulate(struct ttm_device *bdev, struct ttm_tt *ttm)
> > > > }
> > > > EXPORT_SYMBOL_FOR_TESTS_ONLY(ttm_tt_unpopulate);
> > > >
> > > > +/**
> > > > + * ttm_tt_defrag_disown_borrowed() - Drop borrowed defrag pages from a tt
> > > > + * @tt: The tt to drop the borrowed page references from.
> > > > + * @src: The tt the pages may have been harvested from, or NULL.
> > > > + *
> > > > + * During a defragmentation move the freshly (re)allocated tt may harvest
> > > > + * already beneficial-order chunks from the BO's old tt, sharing the underlying
> > > > + * pages instead of reallocating them. Until the move commits these pages stay
> > > > + * owned by the old tt. Clearing a tt's slots for every page it shares with
> > > > + * @src (the same struct page at the same index) makes that tt's teardown leave
> > > > + * the shared pages alone, so they are freed exactly once by their owner.
> > > > + *
> > > > + * This is used both to unwind a failed defrag move (disown the borrowed pages
> > > > + * from the new tt, leaving the old tt intact) and to commit a successful one
> > > > + * (disown the now-transferred pages from the old tt, leaving them owned by the
> > > > + * new tt).
> > > > + */
> > > > +void ttm_tt_defrag_disown_borrowed(struct ttm_tt *tt, const struct ttm_tt *src)
> > > > +{
> > > > +	pgoff_t i = 0, run_start = 0;
> > > > +	bool in_run = false;
> > > > +
> > > > +	if (!tt || !src)
> > > > +		return;
> > > > +
> > > > +	/*
> > > > +	 * Borrowing happens at chunk granularity: a borrowed chunk shares the
> > > > +	 * same struct page on both tts across its whole allocation order, while
> > > > +	 * a non-borrowed chunk differs across its whole order. Stride by @src's
> > > > +	 * chunk order instead of walking every page, coalescing the borrowed
> > > > +	 * (matching) chunks into runs and clearing each run with a single
> > > > +	 * memset rather than a per-page store. @src is a fully populated,
> > > > +	 * non-dma_alloc tt (the defrag path), so its page order is recorded in
> > > > +	 * page->private and read via ttm_pool_page_order_nodma().
> > > > +	 */
> > > > +	while (i < tt->num_pages) {
> > > > +		struct page *sp = src->pages[i];
> > > > +		unsigned int order = sp ? ttm_pool_page_order_nodma(sp) : 0;
> > > 
> > > Here ttm_pool_page_order_nodma() is used where as in harvest funciton,
> > > ttm_pool_page_order() is used. Though it doesn't matter to Xe, this asymmetry
> > > makes it bit confusing.
> > > 
> > 
> > We don't have the pool here, hence we use ttm_pool_page_order_nodma.
> > 
> > Defrag isn't supported on dma_alloc pages, thus is safe.
> > 
> > Matt
> > 
> > > Niranjana
> > > 
> > > > +		pgoff_t nr = 1UL << order;
> > > > +
> > > > +		if (sp && tt->pages[i] == sp) {
> > > > +			if (!in_run) {
> > > > +				run_start = i;
> > > > +				in_run = true;
> > > > +			}
> > > > +		} else if (in_run) {
> > > > +			memset(&tt->pages[run_start], 0,
> > > > +			       (i - run_start) * sizeof(*tt->pages));
> > > > +			if (tt->dma_address)
> > > > +				memset(&tt->dma_address[run_start], 0,
> > > > +				       (i - run_start) *
> > > > +				       sizeof(*tt->dma_address));
> > > > +			in_run = false;
> > > > +		}
> > > > +
> > > > +		i += nr;
> > > > +	}
> > > > +
> > > > +	if (in_run) {
> > > > +		memset(&tt->pages[run_start], 0,
> > > > +		       (i - run_start) * sizeof(*tt->pages));
> > > > +		if (tt->dma_address)
> > > > +			memset(&tt->dma_address[run_start], 0,
> > > > +			       (i - run_start) * sizeof(*tt->dma_address));
> > > > +	}
> > > > +}
> > > > +
> > > > #ifdef CONFIG_DEBUG_FS
> > > >
> > > > /* Test the shrinker functions and dump the result */
> > > > diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> > > > index f4f8a8c29f04..fcaba5fb8bf7 100644
> > > > --- a/include/drm/ttm/ttm_bo.h
> > > > +++ b/include/drm/ttm/ttm_bo.h
> > > > @@ -211,6 +211,18 @@ struct ttm_operation_ctx {
> > > > 	 * order.
> > > > 	 */
> > > > 	bool defrag;
> > > > +	/**
> > > > +	 * @defrag_old_tt: During a defragmentation move, the bo's existing
> > > > +	 * (populated) tt that is being relocated. The page allocator may
> > > > +	 * harvest already beneficial-order chunks from this tt to back the new
> > > > +	 * tt instead of reallocating them, avoiding alloc/free churn for large
> > > > +	 * buffers. Harvested pages are only borrowed: they stay owned by
> > > > +	 * @defrag_old_tt until the move commits, at which point
> > > > +	 * ttm_tt_defrag_disown_borrowed() clears the old tt's slots for the
> > > > +	 * transferred pages so they are not freed when the old tt is torn down.
> > > > +	 * NULL for non-defrag operations.
> > > > +	 */
> > > > +	struct ttm_tt *defrag_old_tt;
> > > > 	/**
> > > > 	 * @resv: Reservation object to be used together with
> > > > 	 * @allow_res_evict.
> > > > diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
> > > > index ce7533677d77..55c35bcf134d 100644
> > > > --- a/include/drm/ttm/ttm_tt.h
> > > > +++ b/include/drm/ttm/ttm_tt.h
> > > > @@ -284,6 +284,8 @@ int ttm_tt_populate(struct ttm_device *bdev, struct ttm_tt *ttm,
> > > >  */
> > > > void ttm_tt_unpopulate(struct ttm_device *bdev, struct ttm_tt *ttm);
> > > >
> > > > +void ttm_tt_defrag_disown_borrowed(struct ttm_tt *tt, const struct ttm_tt *src);
> > > > +
> > > > /**
> > > >  * ttm_tt_mark_for_clear - Mark pages for clearing on populate.
> > > >  *
> > > > --
> > > > 2.34.1
> > > >
