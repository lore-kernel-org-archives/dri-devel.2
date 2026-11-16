Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89DE606A32F
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 00:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nbmLKTsO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=VDZKQ7fE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12F3910E79F;
	Mon, 16 Nov 2026 00:48:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FFDA10E049;
 Mon, 16 Nov 2026 00:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794789720; x=1826325720;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=EJVtDyKHnjMRuupBhO1G5hP2SoE/IiXDzrSiH/AXYTs=;
 b=nbmLKTsOJJZFRiA+OvqQKwf2ytw3W25K68PV1WpXi81m4hZEBf0p957s
 Kz/2HGoCbQDr2mQB6Wy+AkPlRt2QyJFaz/6D95+EC4FGboFm3b8sBFOjm
 LkaMv345xMKUkgRDYtLdhr0xkn4xBpcF/RhxlrvKHMMO8mQbDhEBpEotN
 0ZDZrBUclGlqUR4CW9eJvnR16pX6k/Wtakv21Gih4o0epixMyF/p1ItW8
 vOPToDi3usumvcIde/o4sKIPVATaZJKk1jRR9iGRgJCoiIg2nMSd4rxUH
 WAKbhYX1iyTBNyX17znaeWtv1kbg1PCj21TRFyu5w7kFwqEb2u6GI2ht9 w==;
X-CSE-ConnectionGUID: M4rwaS0lTt2V0E7CBHiEwQ==
X-CSE-MsgGUID: SgNN2gVASreNJk8juW5jGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3411875"
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="3411875"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 16:41:58 -0800
X-CSE-ConnectionGUID: JaEwC+pfSnKrxt3phPV7Rg==
X-CSE-MsgGUID: hTXGu4A7RuuIr18DPywGeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="9603360"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 16:41:58 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 15 Nov 2026 16:41:57 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 15 Nov 2026 16:41:57 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 15 Nov 2026 16:41:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrzK2KTQITwQcltbkJ6xiusjWfNIyGqe1Aqv463EdMZXnDfl3RBCoN/D7Ow+IfND7TpE4XLUXXL8ocDULkwbkvQ+Px5KS/Hk+18utDNPtgDyatO33dDp0OjYcySQcRIcyKmKP1USYjQZmC2cz9DjeK/o2tdC7CdGYI2MYtZabg3dXQ2/xQM5LCgkWNCn5oAOzJgrLkxcyKaNDd4f1KGoaFfLW1ifUMjSYEoF61C6IsvdbbSKMw7S8BWgQqWXXRTQzg7cgN0TLbfgsvgMyMslyMvDyPSmSzi+UQB+g5rEFyYfbHIrI00M6JOdquScLOMn/giiaYhqVachpZQ8NAuC6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WS7gUs4dyxlC08ChMG4hrKGFGdLAIq7xxLYeZiqy5U=;
 b=xl27G0q93UmJYa8NZkXBIPEd7VNYiOUUrZUInkdueKSpwpo5UXWOxrwek5duE3HuRDvPU6qWQ4xWpIV1EuYDLdoDJwUSOiscE69mQLJW4jmTaW6fW+oMxyCx2KkQuWkAVDVYiuRsKgUCkdIp4IIDPbOzQvrbU4TvIpMexo3Z2hqkjCdNLJJiqNRXAvlphco8qejJeyn93fDN6eSZmERyt7SYGfqSBykY3F+ow7JbYwndzPk4oOOmoLmpfIF6Eu9lTQK+bwQJfldNyOW/w/uaEFWoEQ7B85btQXJu92Tv3wcGK9XkgZvwlPpqRvE5ZxQ0RhFmInGhZNp/Bf3OiIL2Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WS7gUs4dyxlC08ChMG4hrKGFGdLAIq7xxLYeZiqy5U=;
 b=VDZKQ7fEintpFI/vAVlvd6xi7Re68klx30faSh9zCATsQDEjgcpdIfwxBe3kURF+mon/bt0EasEGljDW3TEFMSBt71osxErMNirh7JMm1ByrurKtHrhdR4eMk3o6K3rr/lZyIJ7nlinQ5qq03j2eDGpEh5MxBy1uaxsBO5AoMUM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by MN0PR11MB6302.namprd11.prod.outlook.com (2603:10b6:208:3c2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 00:41:51 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 00:41:51 +0000
Date: Sun, 15 Nov 2026 16:41:47 -0800
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
Subject: Re: [PATCH v3 31/33] drm/xe: Blit src-natural to dst-packed for
 defrag-IOVA copies
Message-ID: <avpRS8zPewRYRXaP@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-32-matthew.brost@intel.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-32-matthew.brost@intel.com>
X-ClientProxiedBy: SJ0PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::10) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|MN0PR11MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f0dd85-198e-4d54-e613-08df437a672f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|10067099003|5023799004|11063799006|4143699003|56012099006|261022105027099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: M+wMmwA6Yn3SOVXhM+M+Teh2feXj0y99rZVddPbP9j0cyBshgiIeTdvgGNodxZ3A3HnJ5F/9gVAIZN+lJhTrjPqP6b6SSIfS226Ij5uM1Qg0ZH2M9GTbT+VE58ERYWOmjbCub0sMoGMEYqLl0oOk/cnyPQL1fmkrvk0tQSSNr8g1all0ycBvULd42Xx+uWVyeDnhz0eJVn9iFKT8VarWbSaiOgcjVRfBZkUjc/nAx1k63mpP2WRZsRV7JL0QKyNtIrQq9T/jwPF9dw+TQnrwakkpYkFo5yFAcKj5BEGu35ggJ8ZgUYcw7mZCjgOm7wTMmZF8DK4Qgj8P2ZUdrUXNzC/D/XmmgdFdT3AbobzdFj5lHucJoCMeSdpU9SJ7CiZGW02hif1uVfAmDpFcx76bZLd8E9i8bL2Ed1gVbVMl/2nHkmmUE9kVZAqKtRxYz4RZun3x+h/RyGcNzZbtlQshsnZ9N7Ie9dHUdd3fxz92k7s+oo/FKSgAn1yo/oM89/26r97S1eWIeb4mg8zv025EDunLnN5JKriuBNeu4Xgj203BPLoRysJ4Q5gCYEomYrPqODMQbEfC3XehsE6n8i8i9Ahk9LvUPIc0nQVpa/jAOqsZey5j3XUD6OEx/tcwIq4AHjXCTOKJVFO7gdOTOEIEWGEY5vzf+QKwX6vQ0kpYURY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?nMxZYYzeVWMNSnADg5dRUO0ujuehHjLOakyQo/r44dpPv+hecYuhpzUPGJ?=
 =?iso-8859-1?Q?KXqobcZSByIUniWITJNIH8MvxgXwag4+NoYm6ORAAiQlSk+/gc1vc0HGcO?=
 =?iso-8859-1?Q?tasDeuOg/KBRqSvFlQ2aX4PWoeweZhofRpQMdpnAdoVEkv5muHIwwFxYI0?=
 =?iso-8859-1?Q?pKl6Bllr3DkeauBQhRTJFCQzhDoSutwyqE+u4uSmeUUl5dXuPkkqS41OCc?=
 =?iso-8859-1?Q?jPJtU9kXhWBITwCPT2z/rUgcmvsrizVynDzvoP6v1M8qSDzHaFv0gV6/Po?=
 =?iso-8859-1?Q?IuhDob3gjw9+rzuV7VPIih8szea+lpWnBt3i0me7tDDL19f8wsJJq3ce4q?=
 =?iso-8859-1?Q?WWelflP0/PnpyGIV6r+BL1vz2IgjYd8U/0ZX8dkOl6a9aVaD0+F8QFN84c?=
 =?iso-8859-1?Q?JrZU1Y5a2RNyAmhNc1ggUilXZ0euVtSjgpnSxb9vMkITASPQ/hZg65NT12?=
 =?iso-8859-1?Q?whCJPkOqM5adBzB1v2CB6c707z9cqRtZTeCl4SNvypQUGXEi3mvqYHSsoz?=
 =?iso-8859-1?Q?RwCv90C7wshc8DWJvuBP06gzWhmRyijKDnHEmCw/YtvWujrWjIa22/FlBY?=
 =?iso-8859-1?Q?nJHVsakT0T/7yIXetVjfQjB+Lgc77Rlt+Xx1hQoXcJKFG8p+s4GN8FVuO8?=
 =?iso-8859-1?Q?cz9U6SySSlMElmO1Crr4KyE5sjnAq9hExpQ5XrOzFJJ5R7K9Szhim4vVwD?=
 =?iso-8859-1?Q?AB8vEyDFX1PQcju5u8oPvrTWN7npuyB3AOuaybg6qQ+IzDXRMJdJ1u4O1o?=
 =?iso-8859-1?Q?sxANF7QSRI+RjHhS9pe2J8Yfx9EZDP18Jq0P7EUbc5iNxbxUb/lbXJNQEP?=
 =?iso-8859-1?Q?/d/0i3jeN49b4ixHcE6K33vVtwBBsgBVd5r4dvYqVKp56WRXRoFZMXKLNQ?=
 =?iso-8859-1?Q?TTDh2pVi7q5RcibeNFrfRrjf4bQ99S65wN9pJ7tlTMB2MC9j7lE1EkBkpB?=
 =?iso-8859-1?Q?KRPUIGnRHe7PU/vCB/BqAcQ55VCRi36GKtS6BWmTCLGqIsc31HPQZJ3a0k?=
 =?iso-8859-1?Q?IM8ACsr9eQe4jpt63wuKG7mXKwrvtzIEjVUZ7fgcB0prXHTf/R3fjMY8+t?=
 =?iso-8859-1?Q?mpD2w60sI/ZIq3EJx1X0pBWWUqcms/kaD1x7KOdpDRSVkPe3Oao1TYXh6B?=
 =?iso-8859-1?Q?xNjQoi7U0I3IObdJFhUKS857C4JOFR6Kl/Vi4IVPF4JG4qKkKr7ym+1MD9?=
 =?iso-8859-1?Q?WW7fi4XabrVUIgBh2ZV9LHdUhlyy6oIygrOTJ3j+By1dVAjgZO1LflWi+R?=
 =?iso-8859-1?Q?TUmsImrIN3EGzakr5E0h978po5fK8BuN4HIX4Sws9ZitSVLOigQANc+uc0?=
 =?iso-8859-1?Q?XBrvRxHDAybN+butBQ8fSROmP6vcdC8vS+H9GshsztPx2QBVMdZ3zbE7yO?=
 =?iso-8859-1?Q?fwFToLynk2lWu7FG3ycwvscHhbZLkQ7zh/NNt5+Cjy152QZBqZgqdYtBMb?=
 =?iso-8859-1?Q?91gcTK3bDCgClOKs81KdtPROsvQ5/2IAn69xQKm/nW+rH+qh4daqAIXXA3?=
 =?iso-8859-1?Q?ZG/e/r7nXZH8Rx5N8n4LhFKiyPSwKFVuwigsUHxnoLzcL41niZU+TTkGEK?=
 =?iso-8859-1?Q?pMhIoNqqTC5ZbVyH7Ktl7PoDpeudSjp33Riz+MT9/buM6nENi4eRocqXI4?=
 =?iso-8859-1?Q?PZNf2g+CUBav5Bcvm/QNxiGUIpxOndmuXG+QM2HU/QeN7E/DIvsiQWC184?=
 =?iso-8859-1?Q?N+eXu4hWm68k83lcaOkQ+1Xeq001fooAW78arN7NTiQOxEatUtAoWDxKOM?=
 =?iso-8859-1?Q?n8ToeeboGkncGYtlZzuV5FdOKcSZR6LmWIM0Uf2cdWibtkfpyTIqrgFpQZ?=
 =?iso-8859-1?Q?fj7fbKFHQ66ZJilEzOdKlB22ng9/pppDdk0EKkHYqkKAif+c7ns1?=
X-Exchange-RoutingPolicyChecked: aXTrXPvC4n98TU8NgoOyu87/xo6zVt+AG1gdBNIYB+08S4pbtjoC2mg8Ghes6yXpkbzY2SOC9B3hVaGnMdVScNx/POhaS3ISBN/uDazAGnWf1HyTrKgvtIikdhyGMoqNCZTjfDJHdO8OU4hievYF9wAQY96oz4d8hYy/9JAxiL1cjjxU6jXYRjzs7BmJsjqCrdSL/moJ5w8QEvqkwk/jaIBz13Rgowns98GP/wLdi9v4MWG4Q7NMWwg8CFPphD0ergDK+go2CUJOknWWD/n2gZ+atkTxVf8V/kKE5nVSc78dYAkfQn8emg7ggMJErKD5+HXqOaNrM/rb6Hux+g5PcA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f0dd85-198e-4d54-e613-08df437a672f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 00:41:50.9994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfoF3idBjU22fBwzMwwZYto4n7danUOopJV8jp4keGCVAtYXRRBJoxHuQX1dd3A8sVvPa/RUx8lDhRd5uW3/EaPN6Uk/2HToyr5t8lu4b9LMAlfL1e7Ai8mrM2MXeOmB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6302
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

On Fri, Jul 10, 2026 at 07:56:17PM -0700, Matthew Brost wrote:
>A defrag move with IOVA enabled only DMA-maps the changed (non-borrowed)
>pages of the new tt, packed contiguously into the front of its IOVA
>reservation (xe_tt_map_iova_copy()). The GPU copy therefore has an
>asymmetric geometry: the source is read from the old tt at its natural
>page offsets (via the old tt's full IOVA), while the destination only
>exposes the changed pages, packed.
>
>Teach __xe_migrate_copy() about this packed-destination mode:
>
>- Add a @dst_packed_pages argument. When non-zero the destination tt
>  cursor walks just that many packed pages and the source (not the
>  destination) drives the chunk size, so the smaller packed prefix never
>  clamps the source walk.
>
>- Size the destination PTE update for each chunk from the changed-page
>  count (xe_migrate_count_changed_pages()) rather than the full chunk,
>  and skip the destination PTEs entirely for an all-borrowed chunk.
>
>- Extend emit_copy_chunks() with a @pack_dst flag so each emitted run is
>  blitted from its natural source offset into a running packed
>  destination offset that only advances for changed runs. The
>  all-borrowed skip leaves the packed destination cursor untouched.
>
>Expose this via xe_migrate_copy_defrag_iova(). It is only valid when the
>BO needs no CCS pass, since the separate CCS pass migrates aux state for
>all pages and would require the full destination mapping. The existing
>xe_migrate_copy_defrag() (full destination mapping) remains the path for
>CCS BOs and the non-IOVA fallback.
>
>No users yet; xe_bo_move() is wired to this path in a later patch.
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
> drivers/gpu/drm/xe/xe_migrate.c | 307 ++++++++++++++++++++++++++++++--
> drivers/gpu/drm/xe/xe_migrate.h |   8 +
> 2 files changed, 296 insertions(+), 19 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
>index 666c715a9067..e1dc2fb5c5cb 100644
>--- a/drivers/gpu/drm/xe/xe_migrate.c
>+++ b/drivers/gpu/drm/xe/xe_migrate.c
>@@ -811,6 +811,64 @@ static void emit_copy(struct xe_gt *gt, struct xe_bb *bb,
> 		emit_xy_fast_copy(gt, bb, src_ofs, dst_ofs, size, pitch);
> }
>
>+/*
>+ * xe_migrate_count_changed_pages() - Count non-borrowed pages in a defrag chunk.
>+ * @src_tt: Source (old) tt providing the page pointers.
>+ * @dst_tt: Destination (new) tt providing the page pointers.
>+ * @start_page: Page offset of this L0 chunk within the tt page arrays.
>+ * @npages: Number of pages in the L0 chunk.
>+ *
>+ * A defragmentation move may harvest already beneficial-order chunks from the
>+ * old tt, so the new tt references (borrows) some of the same physical pages.
>+ * Count the pages that actually differ (src page != dst page) within the chunk.
>+ *
>+ * Return: The number of non-borrowed (changed) pages.
>+ */
>+static u32 xe_migrate_count_changed_pages(struct ttm_tt *src_tt,
>+					  struct ttm_tt *dst_tt,
>+					  pgoff_t start_page, u32 npages)
>+{
>+	u32 i, nchg = 0;
>+
>+	for (i = 0; i < npages; i++)
>+		if (src_tt->pages[start_page + i] !=
>+		    dst_tt->pages[start_page + i])
>+			nchg++;
>+
>+	return nchg;
>+}
>+
>+/*
>+ * xe_migrate_leading_borrowed_pages() - Count the run of borrowed pages at the
>+ * head of the remaining copy.
>+ * @src_tt: Source (old) tt providing the page pointers.
>+ * @dst_tt: Destination (new) tt providing the page pointers.
>+ * @start_page: Page offset of the next page to copy within the tt page arrays.
>+ * @max_pages: Pages left to copy.
>+ *
>+ * A defragmentation move borrows the already beneficial-order chunks from the
>+ * old tt, so the new tt references (borrows) the same physical pages for the
>+ * unchanged majority of a large object. Those pages alias on both the source
>+ * and destination GPU mappings and need no copy. Count how many consecutive
>+ * pages starting at @start_page are borrowed so the caller can advance past the
>+ * whole run at once instead of rediscovering it one L0 chunk at a time.
>+ *
>+ * Return: The number of leading borrowed (src page == dst page) pages, capped
>+ * at @max_pages.
>+ */
>+static u32 xe_migrate_leading_borrowed_pages(struct ttm_tt *src_tt,
>+					     struct ttm_tt *dst_tt,
>+					     pgoff_t start_page, u32 max_pages)
>+{
>+	u32 n = 0;
>+
>+	while (n < max_pages &&
>+	       src_tt->pages[start_page + n] == dst_tt->pages[start_page + n])
>+		n++;
>+
>+	return n;
>+}
>+
> /*
>  * emit_copy_chunks() - Emit the data blits for one defrag L0 chunk, skipping
>  * borrowed pages.
>@@ -822,6 +880,9 @@ static void emit_copy(struct xe_gt *gt, struct xe_bb *bb,
>  * @src_tt: Source (old) tt providing the page pointers.
>  * @dst_tt: Destination (new) tt providing the page pointers.
>  * @start_page: Page offset of this L0 chunk within the tt page arrays.
>+ * @pack_dst: If true the destination only maps the changed pages packed
>+ *	      contiguously, so the destination offset advances by changed-page
>+ *	      runs instead of tracking the source page index.
>  *
>  * A defragmentation move may harvest already beneficial-order chunks from the
>  * old tt, so the new tt references (borrows) some of the same physical pages.
>@@ -830,16 +891,21 @@ static void emit_copy(struct xe_gt *gt, struct xe_bb *bb,
>  * only blit runs of pages that actually differ (src page != dst page),
>  * coalescing contiguous to-copy pages into a single blit.
>  *
>+ * When @pack_dst is set the source pages are read from their natural offsets
>+ * (@src_L0_ofs + page index) while the destination pages were packed into a
>+ * contiguous prefix, so the destination offset is a running counter that only
>+ * advances for emitted (changed) runs.
>+ *
>  * Return: The number of blits emitted (or that would be emitted when @bb is
>  * NULL).
>  */
> static u32 emit_copy_chunks(struct xe_gt *gt, struct xe_bb *bb,
> 			    u64 src_L0_ofs, u64 dst_L0_ofs, u32 src_L0,
> 			    struct ttm_tt *src_tt, struct ttm_tt *dst_tt,
>-			    pgoff_t start_page)
>+			    pgoff_t start_page, bool pack_dst)
> {
> 	u32 npages = src_L0 >> PAGE_SHIFT;
>-	u32 i = 0, nblits = 0;
>+	u32 i = 0, pack = 0, nblits = 0;
>
> 	while (i < npages) {
> 		u32 run = 0;
>@@ -859,9 +925,71 @@ static u32 emit_copy_chunks(struct xe_gt *gt, struct xe_bb *bb,
>
> 		if (bb)
> 			emit_copy(gt, bb, src_L0_ofs + (u64)i * PAGE_SIZE,
>-				  dst_L0_ofs + (u64)i * PAGE_SIZE,
>+				  dst_L0_ofs +
>+				  (u64)(pack_dst ? pack : i) * PAGE_SIZE,
> 				  run * PAGE_SIZE, XE_PAGE_SIZE);
> 		nblits++;
>+		pack += run;
>+		i += run;
>+	}
>+
>+	return nblits;
>+}
>+
>+/*
>+ * emit_ccs_copy_chunks() - Emit the indirect CCS aux copies for one packed
>+ * defrag L0 chunk, skipping borrowed pages.
>+ * @gt: The GT.
>+ * @bb: The batch buffer to emit into, or NULL to only count the copies needed.
>+ * @src_L0_ofs: GPU offset of the source pages mapped (comp PAT) for this chunk.
>+ * @dst_L0_ofs: GPU offset of the destination pages mapped (comp PAT) for this
>+ *	        chunk (the packed changed-page prefix).
>+ * @src_L0: Byte size of the L0 chunk (page aligned).
>+ * @src_tt: Source (old) tt providing the page pointers.
>+ * @dst_tt: Destination (new) tt providing the page pointers.
>+ * @start_page: Page offset of this L0 chunk within the tt page arrays.
>+ *
>+ * Companion to emit_copy_chunks() for the packed defrag CCS pass. The flat-CCS
>+ * aux state is migrated indirectly through the data-page mappings, so it
>+ * follows the physical page regardless of the (packed) GPU VA layout. Borrowed
>+ * pages alias the same physical page on both sides, so their aux is already
>+ * identical and is skipped; only the changed runs are copied, from the source
>+ * at its natural offset to the destination at its packed offset.
>+ *
>+ * Return: The number of CCS copies emitted (or that would be emitted when @bb
>+ * is NULL).
>+ */
>+static u32 emit_ccs_copy_chunks(struct xe_gt *gt, struct xe_bb *bb,
>+				u64 src_L0_ofs, u64 dst_L0_ofs, u32 src_L0,
>+				struct ttm_tt *src_tt, struct ttm_tt *dst_tt,
>+				pgoff_t start_page)
>+{
>+	u32 npages = src_L0 >> PAGE_SHIFT;
>+	u32 i = 0, pack = 0, nblits = 0;
>+
>+	while (i < npages) {
>+		u32 run = 0;
>+
>+		/* Skip a run of borrowed pages (src and dst alias). */
>+		if (src_tt->pages[start_page + i] ==
>+		    dst_tt->pages[start_page + i]) {
>+			i++;
>+			continue;
>+		}
>+
>+		/* Coalesce a run of pages whose aux must be migrated. */
>+		while (i + run < npages &&
>+		       src_tt->pages[start_page + i + run] !=
>+		       dst_tt->pages[start_page + i + run])
>+			run++;
>+
>+		if (bb)
>+			emit_copy_ccs(gt, bb,
>+				      dst_L0_ofs + (u64)pack * PAGE_SIZE, true,
>+				      src_L0_ofs + (u64)i * PAGE_SIZE, true,
>+				      run * PAGE_SIZE);
>+		nblits++;
>+		pack += run;
> 		i += run;
> 	}
>
>@@ -949,6 +1077,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 					   struct ttm_resource *src,
> 					   struct ttm_resource *dst,
> 					   struct ttm_tt *src_tt,
>+					   pgoff_t dst_packed_pages,
> 					   struct xe_migrate_copy_flags flags)
> {
> 	struct xe_gt *gt = m->tile->primary_gt;
>@@ -981,6 +1110,23 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 	 */
> 	struct ttm_tt *dst_tt = dst_bo->ttm.ttm;
> 	bool skip_borrowed = flags.defrag_copy && src_tt && dst_tt;
>+	/*
>+	 * Defrag-IOVA copy: the destination tt only maps the changed
>+	 * (non-borrowed) pages, packed contiguously into the first
>+	 * @dst_packed_pages pages of its IOVA. The source is read from the old
>+	 * tt at natural offsets and each changed run is blitted into the packed
>+	 * destination prefix.
>+	 */
>+	bool pack_dst = dst_packed_pages != 0;
>+	/*
>+	 * Packed defrag CCS pass: migrate the flat-CCS aux state of the changed
>+	 * pages only, from the source at its natural offset to the destination
>+	 * packed prefix. Borrowed pages share the physical page (and thus its
>+	 * aux) on both sides, so they are skipped exactly like the data pass.
>+	 */
>+	bool ccs_pack = flags.defrag_ccs && pack_dst && src_tt && dst_tt;
>+	/* Per-run, borrowed-skipping defrag emission (data or packed CCS). */
>+	bool defrag_runs = skip_borrowed || ccs_pack;
>
> 	/*
> 	 * For decompression operation, always use the compression PAT index.
>@@ -1009,7 +1155,9 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 	else
> 		xe_res_first(src, 0, size, &src_it);
> 	if (!dst_is_vram)
>-		xe_res_first_tt(dst_bo->ttm.ttm, 0, size, &dst_it);
>+		xe_res_first_tt(dst_bo->ttm.ttm, 0,
>+				pack_dst ? (u64)dst_packed_pages << PAGE_SHIFT :
>+				size, &dst_it);
> 	else
> 		xe_res_first(dst, 0, size, &dst_it);
>
>@@ -1030,29 +1178,86 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 		u32 pte_flags;
> 		pgoff_t start_page = (xe_bo_size(src_bo) - size) >> PAGE_SHIFT;
> 		u32 ndata_blits = 1;
>+		u32 nchg = 0;
>+		u64 dst_size;
>
> 		bool usm = xe->info.has_usm;
> 		u32 avail_pts = max_mem_transfer_per_pass(xe) / LEVEL0_PAGE_TABLE_ENCODE_SIZE;
>
>+		/*
>+		 * Defrag fast-forward: the new (destination) tt borrows the
>+		 * unchanged beneficial-order chunks from the old tt, so for a
>+		 * large object the bulk of the copy is borrowed pages that alias
>+		 * the same memory on both sides. Skip the entire leading
>+		 * borrowed run in a single cursor stride rather than discovering
>+		 * it one (8 MB) L0 chunk at a time - each such pass would
>+		 * otherwise pay xe_migrate_res_sizes() + pte_update_size() + a
>+		 * full chunk walk only to copy nothing. The non-vram tt cursors
>+		 * are normally advanced by emit_pte(); replicate that with
>+		 * xe_res_next(). In pack_dst mode the destination only maps the
>+		 * changed pages, so its cursor must not advance for borrowed
>+		 * pages.
>+		 */
>+		if (defrag_runs) {
>+			u32 brun = xe_migrate_leading_borrowed_pages(src_tt,
>+								     dst_tt,
>+								     start_page,
>+								     size >> PAGE_SHIFT);
>+
>+			if (brun) {
>+				u64 brun_bytes = (u64)brun << PAGE_SHIFT;
>+
>+				xe_res_next(&src_it, brun_bytes);
>+				if (!pack_dst)
>+					xe_res_next(&dst_it, brun_bytes);
>+				size -= brun_bytes;
>+				continue;
>+			}
>+		}
>+
> 		src_L0 = xe_migrate_res_sizes(m, &src_it);
> 		dst_L0 = xe_migrate_res_sizes(m, &dst_it);
>
> 		drm_dbg(&xe->drm, "Pass %u, sizes: %llu & %llu\n",
> 			pass++, src_L0, dst_L0);
>
>-		src_L0 = min(src_L0, dst_L0);
>+		/*
>+		 * In pack_dst mode the destination is the (smaller) packed
>+		 * prefix, so it must not clamp the source chunk size; the
>+		 * source drives the walk and the destination is sized
>+		 * independently from the changed-page count below.
>+		 */
>+		if (!pack_dst)
>+			src_L0 = min(src_L0, dst_L0);
>
> 		pte_flags = src_is_vram ? PTE_UPDATE_FLAG_IS_VRAM : 0;
> 		pte_flags |= use_comp_pat ? PTE_UPDATE_FLAG_IS_COMP_PTE : 0;
> 		batch_size += pte_update_size(m, pte_flags, src, &src_it, &src_L0,
> 					      &src_L0_ofs, &src_L0_pt, 0, 0,
> 					      avail_pts);
>+		/*
>+		 * The source chunk size may have been clamped above, so derive
>+		 * the packed destination size from the changed-page count of
>+		 * the final chunk.
>+		 */
>+		if (pack_dst) {
>+			nchg = xe_migrate_count_changed_pages(src_tt, dst_tt,
>+							      start_page,
>+							      src_L0 >> PAGE_SHIFT);
>+			dst_size = (u64)nchg << PAGE_SHIFT;
>+		} else {
>+			dst_size = src_L0;
>+		}
> 		if (flags.copy_only_ccs) {
> 			dst_L0_ofs = src_L0_ofs;
>+		} else if (pack_dst && !nchg) {
>+			/* All borrowed: no destination PTEs for this chunk. */
>+			dst_L0_ofs = 0;
>+			dst_L0_pt = 0;
> 		} else {
> 			pte_flags = dst_is_vram ? PTE_UPDATE_FLAG_IS_VRAM : 0;
> 			batch_size += pte_update_size(m, pte_flags, dst,
>-						      &dst_it, &src_L0,
>+						      &dst_it, &dst_size,
> 						      &dst_L0_ofs, &dst_L0_pt,
> 						      0, avail_pts, avail_pts);
> 		}
>@@ -1072,26 +1277,31 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 		 * is split into one command per run of non-borrowed pages, so
> 		 * size for the number of runs actually needed.
> 		 */
>-		if (skip_borrowed)
>+		if (defrag_runs)
> 			ndata_blits = emit_copy_chunks(gt, NULL, 0, 0, src_L0,
>-						       src_tt, dst_tt, start_page);
>+						       src_tt, dst_tt, start_page,
>+						       pack_dst);
>
> 		/*
> 		 * If every page in this chunk was borrowed there is nothing to
> 		 * copy: don't build a batch or issue any GPU commands, just
> 		 * advance the cursors past the chunk. The non-vram tt cursors
>-		 * would otherwise be advanced by emit_pte().
>+		 * would otherwise be advanced by emit_pte(). In pack_dst mode
>+		 * the destination consumed no packed pages, so leave its cursor
>+		 * untouched.
> 		 */
>-		if (skip_borrowed && !ndata_blits) {
>+		if (defrag_runs && !ndata_blits) {
> 			xe_res_next(&src_it, src_L0);
>-			xe_res_next(&dst_it, src_L0);
>+			if (!pack_dst)
>+				xe_res_next(&dst_it, src_L0);
> 			size -= src_L0;
> 			continue;
> 		}
>
> 		batch_size += ((flags.copy_only_ccs || flags.defrag_ccs) ? 0 :
> 			       ndata_blits * emit_copy_cmd_len(xe)) +
>-			((needs_ccs_emit ? EMIT_COPY_CCS_DW : 0));
>+			(ccs_pack ? ndata_blits * EMIT_COPY_CCS_DW :
>+			 (needs_ccs_emit ? EMIT_COPY_CCS_DW : 0));
>
> 		bb = xe_bb_new(gt, batch_size, usm);
> 		if (IS_ERR(bb)) {
>@@ -1111,7 +1321,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 		else if (!flags.copy_only_ccs)
> 			emit_pte(m, bb, dst_L0_pt, dst_is_vram,
> 				 copy_system_ccs || flags.defrag_ccs,
>-				 &dst_it, src_L0, dst);
>+				 &dst_it, dst_size, dst);
>
> 		if (copy_system_ccs)
> 			emit_pte(m, bb, ccs_pt, false, false, &ccs_it, ccs_size, src);
>@@ -1121,16 +1331,22 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
>
> 		if (skip_borrowed)
> 			emit_copy_chunks(gt, bb, src_L0_ofs, dst_L0_ofs, src_L0,
>-					 src_tt, dst_tt, start_page);
>+					 src_tt, dst_tt, start_page, pack_dst);
> 		else if (!flags.copy_only_ccs && !flags.defrag_ccs)
> 			emit_copy(gt, bb, src_L0_ofs, dst_L0_ofs, src_L0, XE_PAGE_SIZE);
>
>-		if (needs_ccs_emit)
>+		if (ccs_pack) {
>+			if (emit_ccs_copy_chunks(gt, bb, src_L0_ofs, dst_L0_ofs,
>+						 src_L0, src_tt, dst_tt,
>+						 start_page))
>+				flush_flags = MI_FLUSH_DW_CCS;
>+		} else if (needs_ccs_emit) {
> 			flush_flags = xe_migrate_ccs_copy(m, bb, src_L0_ofs,
> 							  IS_DGFX(xe) ? src_is_vram : src_is_pltt,
> 							  dst_L0_ofs,
> 							  IS_DGFX(xe) ? dst_is_vram : dst_is_pltt,
> 							  src_L0, ccs_ofs, copy_ccs);

Assisted-by: LLM

There is a sashiko reported issue here about ccs_ofs being used uninitialized.
Though probably we never run into that case, probably add an assert here which ensures that
ccs_ofs never used uninitialized.

>+		}
>
> 		job = xe_bb_create_migration_job(m->q, bb,
> 						 xe_migrate_batch_base(m, usm),
>@@ -1218,7 +1434,7 @@ struct dma_fence *xe_migrate_copy(struct xe_migrate *m,
> 				  struct ttm_resource *dst,
> 				  bool copy_only_ccs)
> {
>-	return __xe_migrate_copy(m, src_bo, dst_bo, src, dst, NULL,
>+	return __xe_migrate_copy(m, src_bo, dst_bo, src, dst, NULL, 0,
> 				 (struct xe_migrate_copy_flags) {
> 					 .copy_only_ccs = copy_only_ccs,
> 				 });
>@@ -1267,7 +1483,7 @@ struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
> 					 bool need_ccs)
> {
> 	struct dma_fence *fence2, *fence =
>-		__xe_migrate_copy(m, bo, bo, src, dst, src_tt,
>+		__xe_migrate_copy(m, bo, bo, src, dst, src_tt, 0,
> 				  (struct xe_migrate_copy_flags) {
> 					 .defrag_copy = true,
> 					 });
>@@ -1275,7 +1491,7 @@ struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
> 	if (IS_ERR(fence) || !need_ccs)
> 		return fence;
>
>-	fence2 = __xe_migrate_copy(m, bo, bo, src, dst, src_tt,
>+	fence2 = __xe_migrate_copy(m, bo, bo, src, dst, src_tt, 0,
> 				   (struct xe_migrate_copy_flags) {
> 				   .defrag_ccs = true,
> 				   });
>@@ -1286,6 +1502,59 @@ struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
> 	return fence2;
> }
>
>+/**
>+ * xe_migrate_copy_defrag_iova() - Copy a defrag move into a packed IOVA dst.
>+ * @m: The migration context.
>+ * @bo: The buffer object being defragmented.
>+ * @src: The source (old) TTM resource.
>+ * @dst: The destination (new) TTM resource.
>+ * @src_tt: The stashed source (old) tt providing the page pointers, fully
>+ *	    IOVA-mapped at natural offsets.
>+ * @dst_packed_pages: Number of changed pages packed into the destination tt's
>+ *	    IOVA prefix by xe_tt_map_iova_copy().
>+ * @need_ccs: Whether the BO has flat-CCS aux state that must be migrated too.
>+ *
>+ * Defrag copy variant for IOVA-mapped BOs where the destination only maps the
>+ * changed (non-borrowed) pages, packed contiguously into the first
>+ * @dst_packed_pages of its IOVA. The source is read from the old tt at its
>+ * natural offsets and each changed run is blitted into the packed destination
>+ * prefix. When @need_ccs is set a second pass migrates the flat-CCS aux state
>+ * of the same changed pages indirectly through their (packed) data mappings;
>+ * borrowed pages share the physical page and its aux, so only the changed runs
>+ * are touched.
>+ *
>+ * Return: Pointer to a dma_fence representing the last copy batch, or an error
>+ * pointer on failure.
>+ */
>+struct dma_fence *xe_migrate_copy_defrag_iova(struct xe_migrate *m,
>+					      struct xe_bo *bo,
>+					      struct ttm_resource *src,
>+					      struct ttm_resource *dst,
>+					      struct ttm_tt *src_tt,
>+					      pgoff_t dst_packed_pages,
>+					      bool need_ccs)
>+{

There is a sashiko reported issue which though is not a bug, it would
be good to assert here that dst_packed_pages is non-zero here.

Niranjana

>+	struct dma_fence *fence2, *fence =
>+		__xe_migrate_copy(m, bo, bo, src, dst, src_tt, dst_packed_pages,
>+				  (struct xe_migrate_copy_flags) {
>+					 .defrag_copy = true,
>+				 });
>+
>+	if (IS_ERR(fence) || !need_ccs)
>+		return fence;
>+
>+	fence2 = __xe_migrate_copy(m, bo, bo, src, dst, src_tt,
>+				   dst_packed_pages,
>+				   (struct xe_migrate_copy_flags) {
>+					 .defrag_ccs = true,
>+				   });
>+	if (IS_ERR(fence2))
>+		dma_fence_wait(fence, false);
>+	dma_fence_put(fence);
>+
>+	return fence2;
>+}
>+
> /**
>  * xe_migrate_resolve() - Resolve and decompress a buffer object if required.
>  * @m: The migrate context
>@@ -1301,7 +1570,7 @@ struct dma_fence *xe_migrate_resolve(struct xe_migrate *m,
> 				     struct xe_bo *bo,
> 				     struct ttm_resource *res)
> {
>-	return __xe_migrate_copy(m, bo, bo, res, res, NULL,
>+	return __xe_migrate_copy(m, bo, bo, res, res, NULL, 0,
> 				 (struct xe_migrate_copy_flags) {
> 					 .is_vram_resolve = true,
> 				 });
>diff --git a/drivers/gpu/drm/xe/xe_migrate.h b/drivers/gpu/drm/xe/xe_migrate.h
>index 4094ea1c19c1..da066cdf01bf 100644
>--- a/drivers/gpu/drm/xe/xe_migrate.h
>+++ b/drivers/gpu/drm/xe/xe_migrate.h
>@@ -141,6 +141,14 @@ struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
> 					 struct ttm_tt *src_tt,
> 					 bool need_ccs);
>
>+struct dma_fence *xe_migrate_copy_defrag_iova(struct xe_migrate *m,
>+					      struct xe_bo *bo,
>+					      struct ttm_resource *src,
>+					      struct ttm_resource *dst,
>+					      struct ttm_tt *src_tt,
>+					      pgoff_t dst_packed_pages,
>+					      bool need_ccs);
>+
> struct dma_fence *xe_migrate_resolve(struct xe_migrate *m,
> 				     struct xe_bo *bo,
> 				     struct ttm_resource *res);
>-- 
>2.34.1
>
