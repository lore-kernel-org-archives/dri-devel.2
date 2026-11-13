Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34658606A327
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 06:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VuXMrIVn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Pd5F1oyr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8658A10E5E2;
	Fri, 13 Nov 2026 06:14:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ACC310E0C8;
 Fri, 13 Nov 2026 06:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794550478; x=1826086478;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=I6CdfwXYpb5q0sTwGQ/ZhIYJJeSiuqQicP+h11WfdHk=;
 b=VuXMrIVnl4C1AukuyvTpCD4jPFdgdbyP85B5M1z5PTi/UAzA6rpRrV7l
 tZCdgL8Fv+TPClH/jXCGVfnL9U4kcgzkuwjHNjfLOzZ5STjtIEKLuxTzK
 OIwQArNJZyXrwbvdfMTPZMYUCvOryid1SFk81/dJKzGS3f0QS0VTh6gY5
 S4VwfD2tvGhdAt4LUAm5dOC/aUc3kVCx1muHroUMQLa0OSuP1WgakIOwn
 XMcx4yJRPBHVYfrNbqRp0eDw7SK47vWwRyTulWinZIf5sDcMgcj5I8Jga
 RKvig5v3UgP3HQClL8db/xI6IzBRfu8cOtY630O1buQBoVtOIRymgper7 Q==;
X-CSE-ConnectionGUID: 0skawVDPT22WvqKZ1FqYcQ==
X-CSE-MsgGUID: ulvy6YtTSnmmPbTmzYeuQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3237583"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3237583"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 22:14:37 -0800
X-CSE-ConnectionGUID: lQzJpHulSgicpWVPMrUlHA==
X-CSE-MsgGUID: DIkXiLAiSxW4JQfog+q4+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="8769852"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 22:14:36 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 22:14:35 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 12 Nov 2026 22:14:35 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 22:14:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHDxWtEuRFfX6kRGZPw6/Ub+G3cjau4CXOvAFHwarGnq2yqTZp8/JMicX5AuGc/DhWd/aV4xI+9jODBzrXEMOHi6t+1HidMVtndfPozjMtNcMMAfiNS7q1kEP1w5R9/kGV2HRacfGd6+JMH9WvbSgKj87xqpkq/1uAGDH2MHJnepxzPwsCkifZxoig1bcQSapFZLAhDSeecjIpCiSlK+urJO88Z6tOm1sOofcAy3msM6yC0vTrsAOMZD0kLwWUU1NlZbI/viyK7NgDArThXFypqWfsygaEvbIkAHwpyWbQDNjHMKsDz+cv1kbLCo0PmNyxUaLeBv10ootaEXvLbFiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDLa/jBNLlipxPSnhg9dv7aeFhhHNR16IemCyY48TwU=;
 b=EQhX5WDJyvvMUwfYzwvqWOnd8eyFzR1Kq5jwCzGOUCYlTXQNzjsiyQ18pS105CmmVBDlk+Zj4nEqmBtSnq6wyLWPVHG1yULlXoUTI/7n2/Xxq74kvJ2wo+OFdj1pHwBt15YplrDsJ35TG5Lmm40gRnW7AGR4yZbG8GbhxwRBW8JEatXaAFR8QeiAUlzX2v/6zCufNlDzTLEgxTF4aEopkFXiKn/drvxEpXSiYw+QmURNJ+JJPT1pR05pxLFGs3QNrxtigzWnnMeNlheVuB6fZPPMdm/QJo+A8Gf0z0u0s7uqdDyJE9ZLe3K9MfZBaDUnxsXeiDanzBoO2pnt3L+Ceg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDLa/jBNLlipxPSnhg9dv7aeFhhHNR16IemCyY48TwU=;
 b=Pd5F1oyrdaNadLOTJKhhSWTjTwfn5qi5G/UOXxX4KGdPqEFhfWhtiRggH7dEjNXuTpagIQNDRSyGx+8GW9r/knD3LoEtW5CWtD9fM6HXqcgg2Snn96y44CVTmA7//H3/SYGnnTqodsy9YqHpexDcEzE+o/DmTDhREUEYnHZ4yVI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by SJ0PR11MB4877.namprd11.prod.outlook.com (2603:10b6:a03:2d9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 06:14:30 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 06:14:29 +0000
Date: Thu, 12 Nov 2026 22:14:23 -0800
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
Subject: Re: [PATCH v3 27/33] drm/xe: Add IOVA-based xe_res_cursor variant
Message-ID: <avaqidD422qjvpLV@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-28-matthew.brost@intel.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-28-matthew.brost@intel.com>
X-ClientProxiedBy: BY3PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::32) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|SJ0PR11MB4877:EE_
X-MS-Office365-Filtering-Correlation-Id: d70614f5-dffa-4d84-f062-08df414d6072
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|23010399003|1800799024|18002099003|6133799003|261009223027099003|22082099003|11063799006|56012099006|10067099003|4143699003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: lc8UfOCLOwZo7O8VTuaJahh3l9F0SK8gYKiPeScPK8hd+0x2rLNpbSju6R0Te+BDBUZZOUcR9MYL6/kG2FiTj0jxEI2rDMKGaF0Zo3FjrUh4QuS6+TwkkR5EHefUVKWGebxl9s7k2P23SrUGfdHkMZ+CnmNtgbNFhCAbxvYs1lOwP6vCiuoxiFo6p4XttgIEAYaht5xr36S/a7UPkaRk2SNPRHS28fgM2Ohf7Z2RE87p3ZmdmV/oofSeWhdFpXboRE/bHyxMCjLFpy31GYDb8dbjweLOExKgqxKB2Khq7je5e+rsncEZl9xCTAn5SdvEvytkuGXd7Oz9B/Px+cf+qY4+n7m8iJ5z7jwo5ZOv6clf/4hQtM/7LpKQ4oeYPoEBkXqpDbILs9sVWV8TkS8OkVBqOFOFLQ46S4Aoest/jU/ierwMfZ+Wust4mfO04FK0YbOR+KuXrq3f+MgVhMl9IHcOPYsUN8HRcHT6pqpeEiSir0tJ2JFVaTXXIylj88BzL8h0IETD4mTkLFVphvndEPFx8VeFl75SjXjXFoIzMiRPVLM4uF00B1cw0jMPTOrfj834zYLWG30Bzjs2Po3rDTdAVOfeJ82KQZ/VwSKz/e9mOLjnNM0neXBhbdekjGzZGuXN5jXJNl8IoA0R/9uk8Q02j7iqe1aAlGey+eqT4x8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(18002099003)(6133799003)(261009223027099003)(22082099003)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MH/B/1B+ciyv3gXHTybsmUkWnvssaduoJBcMoFn6Z9oAMH4RrqQEyR1J5p?=
 =?iso-8859-1?Q?IfAizHUYn1Y8pYJ7J7Ry4pfILeHAhRXw3bE9XVg6APFsxJRpC8PZiI1R9A?=
 =?iso-8859-1?Q?1egRYgTz50LY3a8EAi0MP5bKowUbTGA3BWCvex8goi33XL7YhX+lSaUiws?=
 =?iso-8859-1?Q?h4KkaNUlAqSVr5iGu67uCbrSMeGsq+HQvcCPFTKw5szJZ/WV9JqdewfBiz?=
 =?iso-8859-1?Q?KIcds24i7P4z+3SntZzk4/iUileHi27rcKeHnja3du3Sv8q2z2leZlbDsF?=
 =?iso-8859-1?Q?xFwnWmn7L4Z6UByUp7dHCZse2dhJCMTyKUJzOdUHHk0KgZBitWzKRO4TsL?=
 =?iso-8859-1?Q?BvtUwj/5aX2w0YF7wvZAfie0qXfchsrLklMgdl3L4OnNwQld58ll47lRw6?=
 =?iso-8859-1?Q?CBNdpSs49dMrQmrEfWPeQ1TX1a7g9OVrentBgeosVpGOmqo//RWk6xoU7E?=
 =?iso-8859-1?Q?p/jgx/AY0O09iBUBwWg/xCc50PLcD9NOwmijaD7wnMIZhahshDfLgwE+z8?=
 =?iso-8859-1?Q?+jEjPyTtLhlDdMPKA0n8qd9rXxCsVns/pLmRolEn2voaWJ54s1eBZO/qjq?=
 =?iso-8859-1?Q?WNyANh0N4JyxRH9L9ETxJrfqivFTVd0nNfVVa2OlmPGjtKoqJTRz5NuE4C?=
 =?iso-8859-1?Q?S82qgkC3WXoVOjdakYL1zo6lT1UXwvLo3efA3qx1kdzYx0HxQLQnBpLwy/?=
 =?iso-8859-1?Q?cjYmdr9QVJ0+AAdJpmJkGQM84Ce7SQF9zQXgI3HUJnFqfMlpUqdUaP0xAW?=
 =?iso-8859-1?Q?aqCGpwF+PqAODgAYj4mBZFzIEITnOYqpk7NjZ6WyDpq0YrBnZbZJPiS9LQ?=
 =?iso-8859-1?Q?ecEBkox/W+q5U6Rcx1kLrZ4yKMV/nScnbenPTcJ5r1pRaUzA4J/DqUUjkt?=
 =?iso-8859-1?Q?NboFx9Qm5nWIMR4cTL0UEiQrnJUZNDSTm8mQITgzCiBwgeS9qZpXPGMraR?=
 =?iso-8859-1?Q?AfM3oiVjoCRwzrepH9I7X5C7tBZNzpQyftRxmTeExYpqe0/aeuHpv52YUs?=
 =?iso-8859-1?Q?DcV2uwpQHaDcA+t26Ni+vHStHlLqEtBEUwPMg9nHIWdWIzrR2pdRNTsvVp?=
 =?iso-8859-1?Q?CaaVU3AaqEpxAcFhyCWmlHqfmTQgHsJyg1qfopK3t6QV+s0I0LtRriSsa3?=
 =?iso-8859-1?Q?78mGX+0xuE2ZxOzUNH6YZeWx9ONXPV9VOWwsWtnrP+XSCKb8xBsskLvRac?=
 =?iso-8859-1?Q?YDCeQJpDUInDMGbLRYIypbK10L2lDPuE7PaLWmwObuQ9t98muPhrYKtpqQ?=
 =?iso-8859-1?Q?/XmLiLq9KWBtAxfJZvaZHqjXNVacwfHVaDoKtIlMiPGdNEot1giWjjkUq5?=
 =?iso-8859-1?Q?eWQJRR9PGeD/c1dLL+YnAXMEMW8qnx5qRBXlbMJjWFk4Zic4PmRJqQ/eNS?=
 =?iso-8859-1?Q?WFL1UCFDxzGHnwbnAgcqM8FzQYsTLFIFjxPIF8jJf+zgXk24s+mY4qkPCj?=
 =?iso-8859-1?Q?jSroB7MW8Mmc0ywJrIrlz3mtqQMOnTzV44sxR8/V+bE/2CjNqhyvn2rkUO?=
 =?iso-8859-1?Q?h5z9xlQuyFRN/DCySI9LUhp33yL8TkWksX5QqoyBJwwQr2sgKT6zjaTlJG?=
 =?iso-8859-1?Q?ROuRnlV9ncUqfszkj10r0GNX3Xl6c14k9LVy9x1DgnWn2OFEnp8wneVOfw?=
 =?iso-8859-1?Q?blXkjAZynV6l4T0g+cDH8y23ayohM/DFq73Yao3511r2PpHBmq0V5CECdD?=
 =?iso-8859-1?Q?KAMiVlFv/EcEXV4pyWAlJQK+9OpCgznpM2Nu3BOtJsAkopT2qb/HXjmEvU?=
 =?iso-8859-1?Q?mxSGGVRrrMxxn2ZLdIiO9trIqv7bC5Sbs6OVn0LhGas0rsnHZSimC+fOQX?=
 =?iso-8859-1?Q?4ZIGE9s7mRX7NVrNiTOyINmbCPhq98sR9K2IKgq/EnEj756GyyYp?=
X-Exchange-RoutingPolicyChecked: YPlVPYNt5bYfYCRia4BzODqmQvxJ89MXvOWsWCQyrbsQQPtA8f92mDNQk+Q98Va+stvim9FVlNWm+YbRuh6gjgIJTyPV+ZYLKgLEfbWrpU3fyVC3VlTsdG+vOdVpzDx/h/p+beuEUV0lVSQ10t5Uxuk+Z3hj7HAM3WNRemNI7uSJ+oeCNevM1QcJP+qcqzLVAyOB0MyKgFmuSIc/QPoBmzK825qCIIaTvVUHU41FgBtFHwfUNq/HbNV9p27nloM2Xf6Zgn0a8685eojPt98IfIJZpa7NEfvZasuvwF+CjFAaRvlNp8PvlzDoPHFYR+IQDC29HcY3B0PMgvpXWRLi0g==
X-MS-Exchange-CrossTenant-Network-Message-Id: d70614f5-dffa-4d84-f062-08df414d6072
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 06:14:29.8332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7kKcYVdH1WooPuiMLZjNoYg4iIrblhg8Nzi0l3xmY4mSs6N6jK7oVSavFbIrT2d/wDWQhVTIvQH+tQUkud9czMqjEfuORGS3uKiitlSl6/72rBrVLEJCt93xynAjv8g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4877
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

On Fri, Jul 10, 2026 at 07:56:13PM -0700, Matthew Brost wrote:
>Introduce xe_res_first_iova() to walk a buffer that was DMA mapped using
>the IOVA-based DMA API (dma_iova_try_alloc() and friends). Such a mapping
>is described by a struct dma_iova_state and is a single contiguous IOVA
>range, so the cursor walks it as one segment.
>
>Add an is_iova flag to struct xe_res_cursor to distinguish this case.
>When set, xe_res_dma() returns the IOVA backing the current position
>(state->addr + cursor offset), xe_res_next() advances within the single
>contiguous segment, and xe_res_is_vram() returns false since IOVA
>mappings never point to same-device VRAM.
>
>The flag is explicitly cleared in the existing xe_res_first(),
>xe_res_first_sg() and xe_res_first_dma() initializers so stale stack
>values cannot leak into the new path.
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
> drivers/gpu/drm/xe/xe_res_cursor.h | 56 +++++++++++++++++++++++++++++-
> 1 file changed, 55 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_res_cursor.h b/drivers/gpu/drm/xe/xe_res_cursor.h
>index 0522caafd89d..f0f1d699e16e 100644
>--- a/drivers/gpu/drm/xe/xe_res_cursor.h
>+++ b/drivers/gpu/drm/xe/xe_res_cursor.h
>@@ -24,6 +24,7 @@
> #ifndef _XE_RES_CURSOR_H_
> #define _XE_RES_CURSOR_H_
>
>+#include <linux/dma-mapping.h>
> #include <linux/scatterlist.h>
>
> #include <drm/drm_pagemap.h>
>@@ -67,6 +68,12 @@ struct xe_res_cursor {
> 	u64 dma_start;
> 	/** @dma_seg_size: Size of the current DMA segment. */
> 	u64 dma_seg_size;
>+	/**
>+	 * @is_iova: Whether the cursor walks a single contiguous IOVA
>+	 * mapping described by a struct dma_iova_state. When true, the
>+	 * DMA address is @dma_start + @start and never points to VRAM.
>+	 */
>+	bool is_iova;
> };
>
> static struct gpu_buddy *xe_res_get_buddy(struct ttm_resource *res)
>@@ -93,6 +100,7 @@ static inline void xe_res_first(struct ttm_resource *res,
> {
> 	cur->sgl = NULL;
> 	cur->dma_addr = NULL;
>+	cur->is_iova = false;
> 	if (!res)
> 		goto fallback;
>
>@@ -224,6 +232,7 @@ static inline void xe_res_first_sg(const struct sg_table *sg,
> 	cur->dma_addr = NULL;
> 	cur->sgl = sg->sgl;
> 	cur->mem_type = XE_PL_TT;
>+	cur->is_iova = false;
> 	__xe_res_sg_next(cur);
> }
>
>@@ -255,6 +264,41 @@ static inline void xe_res_first_dma(const struct drm_pagemap_addr *dma_addr,
> 	__xe_res_dma_next(cur);
> 	cur->sgl = NULL;
> 	cur->mem_type = XE_PL_TT;
>+	cur->is_iova = false;
>+}

Assisted-by: LLM

NIT..Instead of defining and clearing is_iova flag, would it be better
to define enum defitions for different cursor types?

>+
>+/**
>+ * xe_res_first_iova() - initialize a xe_res_cursor with a dma_iova_state
>+ *
>+ * @state: struct dma_iova_state describing a single contiguous IOVA mapping
>+ * @start: Start of the range
>+ * @size: Size of the range
>+ * @cur: cursor object to initialize
>+ *
>+ * Start walking over the range of an allocation that was DMA mapped using the
>+ * IOVA-based DMA API (see dma_iova_try_alloc()). Such a mapping is a single
>+ * contiguous IOVA range, so the cursor walks it as one segment. Subsequent
>+ * calls to xe_res_next() advance within that range and xe_res_dma() returns
>+ * the IOVA backing the current position. xe_res_is_vram() always returns false
>+ * for such a cursor.
>+ */
>+static inline void xe_res_first_iova(struct dma_iova_state *state,
>+				     u64 start, u64 size,
>+				     struct xe_res_cursor *cur)
>+{
>+	XE_WARN_ON(!state);
>+	XE_WARN_ON(start + size > dma_iova_size(state));
>+
>+	cur->node = NULL;
>+	cur->start = start;
>+	cur->remaining = size;
>+	cur->size = size;
>+	cur->dma_addr = NULL;
>+	cur->sgl = NULL;
>+	cur->dma_start = state->addr;
>+	cur->dma_seg_size = dma_iova_size(state);

NIT...looks like cur->dma_seg_size is never used, but should be fine.

>+	cur->mem_type = XE_PL_TT;
>+	cur->is_iova = true;
> }
>
> /**
>@@ -283,6 +327,13 @@ static inline void xe_res_next(struct xe_res_cursor *cur, u64 size)
> 		return;
> 	}
>
>+	if (cur->is_iova) {
>+		/* Single contiguous IOVA segment. */
>+		cur->start += size;
>+		cur->size = cur->remaining;
>+		return;
>+	}

This code never gets executed. Probably remove it and add an assert
if we reach here with cur->is_iova set (or add a comment)?

Niranjana

>+
> 	if (cur->dma_addr) {
> 		cur->start += size;
> 		__xe_res_dma_next(cur);
>@@ -334,7 +385,7 @@ static inline void xe_res_next(struct xe_res_cursor *cur, u64 size)
>  */
> static inline u64 xe_res_dma(const struct xe_res_cursor *cur)
> {
>-	if (cur->dma_addr)
>+	if (cur->is_iova || cur->dma_addr)
> 		return cur->dma_start + cur->start;
> 	else if (cur->sgl)
> 		return sg_dma_address(cur->sgl) + cur->start;
>@@ -351,6 +402,9 @@ static inline u64 xe_res_dma(const struct xe_res_cursor *cur)
>  */
> static inline bool xe_res_is_vram(const struct xe_res_cursor *cur)
> {
>+	if (cur->is_iova)
>+		return false;
>+
> 	if (cur->dma_addr)
> 		return cur->dma_addr->proto == XE_INTERCONNECT_VRAM;
>
>-- 
>2.34.1
>
