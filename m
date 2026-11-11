Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D88606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gCutBi1L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2808910E2A4;
	Wed, 11 Nov 2026 07:38:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33E0810E2A4;
 Wed, 11 Nov 2026 07:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794382686; x=1825918686;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=ZdBvx+NTfuyg+nyaib52g78YHU0K3uEar9Xj05yzB9A=;
 b=gCutBi1LQyngVdjmpT5i6J7mZoLAijmeu3PADvO59qNDWVgpJbHNiy1M
 UOgcwVbs0BFircc/4K7fBzjWqOHWrjLgWbwMN8LzhwBZ7L5d4tjFDZkZ0
 Qeny0R3QClvvvQsyC5OmjLkZECmAqBDVzqN2uoaLSKi74edkO5kBQXXhh
 6sy3UW/VRWRQY4OiWV4PEt1y0wY9UG218lkGYp6082jp+4pM7I2IvaRoU
 G4KD/9d+A1hdjqcSbgm/iZ2EasWEUcURQSqMBYPDccz6mQ4i/PA9QSYUT
 bPe6jPcDZH5iTlFXj1+/7Dz9FjtG/xROk+JsQ0yNII9FuJ0EpZ2uvMqm+ g==;
X-CSE-ConnectionGUID: 7PhAJuTQSke6qBQCIx7u0Q==
X-CSE-MsgGUID: GJTNkGufR5iZkSYjHL6v/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3031618"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3031618"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 23:38:05 -0800
X-CSE-ConnectionGUID: 4M4/KpG+Qtyq5cwRcAZDIg==
X-CSE-MsgGUID: ZuLTvcbQRN6GsxwCXWHyqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8688921"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 23:38:06 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 23:38:04 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 23:38:04 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.32)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 23:38:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+R62aGqQTsA4Ph5K0oFKS0thKbEqAfqW0889oFW7BKQg9Cov/w6F9zfyZ/crkayhVmYTknonG5ya/VrnZVfzuC65I+hB0GjeLtHFjoxvDd/ENgtbwFUjuvDtmLnVLrQjXWPGPjJiufTfcrYrSB7NWOrAAifXNBHe/SwjJRI92iMNQy/EbnRcU7gNpAAM7F/7UaT6v2lEgRfT6MpgHG7fw+iraOme9uMjbpSOFkAsEGnhTvm2JTBzIzLRujZELAcMxFnbu8AMmGLRFISqsVsPBmNzKCF5+wVDcNilkH0lofm3s2MRQvaI+Btrg09gV82pjl0BixbYLc9RF7R253qCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsbs+FyAn96+THZD8WiMOoj+GhkBpf4SX+D3+AuNd3A=;
 b=OuwOkHAjKVtZoVNbZ/JSEtGH6d1NjKh8rKT/77PuFL5RVD+WMOGwnQikVWL8E+61+1HpUAXrPHKR8YfH+H5ikKnMTN7J+dXNn+SVI056KYniiq+zNVe3Bv7Wi2Lt93vx6J11mDligUj3451eGAnDOzJ8eF7CqyXIpERldDiyriOIk0EdvzSpKMlkMWHNlUvB7B3eviBgEHPYJqFTmwRlbfL+JWGDDgGFRGC4atcnldtAWPweQjSSTnTOe+y+O1tlvITFO6/u1AUv2kJykSjiAKQiV1kA5XBh1W2j8DUpORGipuIgoFBwn5h/emldzypHCplzf6DAc9um5CAQH/VoVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by DM4PR11MB5996.namprd11.prod.outlook.com (2603:10b6:8:5f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 07:37:56 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 07:37:56 +0000
Date: Tue, 10 Nov 2026 23:37:53 -0800
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
Subject: Re: [PATCH v3 26/33] drm/xe: Add tracepoint for xe_gem_create_ioctl
Message-ID: <avQbUZVNm9jzIhbA@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-27-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-27-matthew.brost@intel.com>
X-ClientProxiedBy: SJ2P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::13) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|DM4PR11MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d2f95d-e96c-439f-7d98-08df3fc6b3ac
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|261021121427099003|261028144727099003|261026140227099003|261102123227099003|261009223027099003|261022105027099003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QMRJtRGc5h816MDz3iROFYbZgASrPgBr/G/yTi3UWmljqaRdLzlT4atVPbMuzOFvCjWHX1QPwTM8kMBHzHsSoJHYN3JiKImc9bi/42X3FyNpK4qOlTdXdk8ChA/1GUXtEyKF0EA6MZOU4GWkKlAWdgMk0c2WUU5VLxHfTpKJ9yKmBn/+kQESfQFs5bM9f7GYhMwpkKTGGnHFZTJKebtDM2fvehRK7bADCXdMF98gCSpWnMVRrvhyqFnALUQLOmfq6XebNOCHLyjDX7+gjtGAUipqPd4b9q6KtOQAmoSxnajTXKp9v7/yq+D9Za/u2DDvoXOTCb3EiYTLFJpirPmXNA9PCSVFkYIrjKFbt91kJIR6J3tJnmwe0kgS7okoFjM88bRsEKsV/hH7VrlQPnfVyE0jZ1y9zzzh7y3Zr+30duuA6kKTcPWkQfIIQ4AQBnMPKV6z4uSGOVZVhO84EDmPngM7ilJIV0Uxegfc0EQWVfSFFXYxjXvK4ANYUVY+0v8mxoL8126zHYvqzYfSrqPa9SNrBghnz7hR4HYz9E1+6fDnZdpierBIt5k7FqKq7S5ZcHJaS87jUHtHCFzEW3fDoCebMDy6urlEPpkSG0qOFnemA8tDCjcOH3jzZZ+xkZe3LHbftFkKxjJ1QIAQMwIMAdqOn3OsMebKdinC6/Axnog=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(261021121427099003)(261028144727099003)(261026140227099003)(261102123227099003)(261009223027099003)(261022105027099003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?iv83CrxQfUGHgUEkbTaF1OygFp8k6qtEZFVnmvMIdXcEJN29HFm7U9OpdL?=
 =?iso-8859-1?Q?qXNmJOt+Y4M1xS2/Vb6qOdCOMMUhEidZfDuEQLxHIijW96AHgOgeptknSK?=
 =?iso-8859-1?Q?h6ryT6YX+ZRfyAmEcZU2U4iYiFCFoeT0z3Hbyqv+pGHufzIiqv078Xe2lP?=
 =?iso-8859-1?Q?k6AT4BwZymkcM+7fBFEw5YlfdPMyZK+vZz2VlHmZI0I+z/Odj9w9eeFVZh?=
 =?iso-8859-1?Q?2cXaYh6pJmUio1nJ3/CmKP+dn7ZXhMD6oofz1vw7jXXnMcTeCoarBOR6jn?=
 =?iso-8859-1?Q?K9bhFRIAeDCcyOp4rviVGRkMldy5+otSBnCBimh5/x+8ajH/GAKKGpJ1rZ?=
 =?iso-8859-1?Q?t6ecpl6yTzIhl71OP4qc//ng7cdPo1yIn7Q55LIBu9eE3BnfwmQw4lKy4M?=
 =?iso-8859-1?Q?NOzjt0H0L62iAVHUmkJwDgTDIDsG9IvlfVyXWefYfuifL8LxGJmZS7RLOz?=
 =?iso-8859-1?Q?CSOzRMdv9g4LQKnzSyMb8HNFpL1Ci4M/5W1rO2KyGcf3NFMY3y+WbluVpb?=
 =?iso-8859-1?Q?GeF8+0ZRTkzFyqXRZLJYFHFtNmN/jZksQdXawr90NA6VN3k0bJK+77Dnye?=
 =?iso-8859-1?Q?1rnp1PDVILJrZcnZk6/AaNlUpEWqZVKWQfMMwUSofCOUMZUVYjhP+Kf1R5?=
 =?iso-8859-1?Q?SKgqCmHcY/bX3zIATQMGV1J10cT+8vjEPEjkhZpaYfjG00ELi439mdfUYg?=
 =?iso-8859-1?Q?GBN5/rSgJFo1vvt7xP46eHdgsZUSaeCJw98eQBJ/sc7kap7/2lv4bL/pgF?=
 =?iso-8859-1?Q?Y0UYNGrQdux+pBjWUZYQ4Ohi9EnsBUtVtcSxxPPSZkDq61Ja0ov94bfMcI?=
 =?iso-8859-1?Q?jwzzLB6oUY1sQq1+20btPCz7lK97Q0cu89LmxYwacRfWq9WEYM6uQ7bw9O?=
 =?iso-8859-1?Q?SuTrenWcnOw4KIYya9dccXcwBsMGZgjtisQYnmqtG115diWkz6I2i3Pf5y?=
 =?iso-8859-1?Q?YCeGAeEcp2NKMX8AN8TfW3jwAh/MFb3wInsUJkpkIDfmCh+xjToQMUbcGn?=
 =?iso-8859-1?Q?peTmr/UshgKgCgVq9OMb//py37ucJMtpt0VIl/Vx9NMFSlNKQuCHUBBhHF?=
 =?iso-8859-1?Q?hx1AWKqSGXO8l0lMGym/DK4TYav2+DNv5ny8KsYNc+TXjOQbdjP0TbwukD?=
 =?iso-8859-1?Q?FOLK0q+OAOwLAt89/+P6ecywNQL2zY1pbuU4YB3vffmFzDwiH9qxWLWupR?=
 =?iso-8859-1?Q?XKoTcVl/MBoAftIf8idPr8tS/ZSR0GHo96BFcfxNdPzt1B6pg0SbTpioR4?=
 =?iso-8859-1?Q?7ixrhiCb758qcenTqK+Xyn9SyY65skt+IFcS/WcnjhoKEafrr8EFekuS/Y?=
 =?iso-8859-1?Q?bbBcWh8QSZ1cesCiq/mu/1z4FKzpCFT8ftOJLyh1gmpCaBA/S2D2Uv78Bb?=
 =?iso-8859-1?Q?kX2CgP2MzV5GLm/qTI2ScRXyXwI3zdRw14ukAFrcb3uHZr0t5+kt3GgvmW?=
 =?iso-8859-1?Q?GukbHZlrAgPZN4qaoGbe+qDVkx7MlVHBsAH75xWzzOoWnJJUHyd1Y/Qs6l?=
 =?iso-8859-1?Q?NF1Rm27shfWv6YejIbok7p+piuvFuh/8oTzPbMeLR7oyXWHbXWYqhqO1y9?=
 =?iso-8859-1?Q?DIpiUhUfgsjk3OtQUL14PKSd3IJoYNbMonmU0aspiSpKIGACGEbjZxPK4k?=
 =?iso-8859-1?Q?pynaEpuS/6t5j/ABhVy2t75PjpIc30eiMah4HqkTFnElGaBC97pdIn3Y0X?=
 =?iso-8859-1?Q?WsHyqo89c3crO6HBjywHM+NLSkEgyR2lBhwGlhBEbzcOMWWt8WVlAq8D9B?=
 =?iso-8859-1?Q?P2eYIIh84YgGjB3LJkIvVCIRRfipVBF9eLAXYZVxXobShQ5+yvvMKPA9R4?=
 =?iso-8859-1?Q?NiqnXnuT72XpYgEzgFwC7y+jaWua1H3exiF3pwpRMLna34T4/5Re?=
X-Exchange-RoutingPolicyChecked: Ori1q5yfiA+O3iHJTbsv9mNiKpwVG/t9p8M2ZKp8rc3caERFqPG712lozbLj5imm0TJiJqZFeUZDpxMAH9dPK1K0s4iRqux9PDC3kn9/V7iS9qpuoTyPupL5iOE16SzuEd5JShKaxlFygFsfVsuHvw2Onk1S2G98xQKhqQebcf2zKGBWbK/ReklwY4P8Sx41eo8Z4FoOIOt8KVI/FcxJnKmhk9FZKaF5SCj7Cufz17Kc4x9MS83lqaV71C38/qtN5i3EMwztSKWMoyWkhtTyia1ee/S8sXtwVzlrtKfJssTGN1InL62d6doChOQvaT+e44Ex9RkM8b3h/Oby3VdjUg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d2f95d-e96c-439f-7d98-08df3fc6b3ac
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:37:56.1909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bsk62bbPihOVcksWkEY5L9fuFuF7naXdj5Kl+wV8mUUEc+JDivE6RkztZY1zw9J87q/YZ09/Qagw5I9RUZIYdvtVsvb505qlm+DnRWSST/puA4q3EJYkQenfc4JqXkYd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5996
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

On Fri, Jul 10, 2026 at 07:56:12PM -0700, Matthew Brost wrote:
>Add a xe_gem_create_ioctl tracepoint to help profile GEM creation, in
>particular the cost of populating a BO while holding the dma-resv lock
>versus the total IOCTL cost. This is useful for evaluating the
>out-of-lock preallocation path, which aims to shrink the time spent
>under the lock.
>
>The tracepoint records the BO size, the requested placement mask, the
>CPU caching mode, the VM asid (0 when no VM is bound), the total time
>spent in the IOCTL, and the time spent under the dma-resv lock (the
>xe_validation_guard region where the lock is held).
>
>The asid is captured at VM lookup time rather than at trace emission,
>since the VM reference is dropped before the tracepoint fires.
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
>
>---
>
>v3:
> - Guard lock_ns against an unset lock_start and use div_u64() in the
>   tracepoint (Sashiko)
>---
> drivers/gpu/drm/xe/xe_bo.c       | 17 +++++++++++++++++
> drivers/gpu/drm/xe/xe_trace_bo.h | 31 +++++++++++++++++++++++++++++++
> 2 files changed, 48 insertions(+)
>
>diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>index a646a72122d4..caf5aa0bab53 100644
>--- a/drivers/gpu/drm/xe/xe_bo.c
>+++ b/drivers/gpu/drm/xe/xe_bo.c
>@@ -3953,6 +3953,10 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
> 	bool have_prealloc = false;
> 	unsigned int bo_flags;
> 	u32 handle;
>+	ktime_t ioctl_start = ktime_get();
>+	ktime_t lock_start = ktime_set(0, 0);
>+	u64 lock_ns = 0;
>+	u32 asid = 0;
> 	int err;
>
> 	if (XE_IOCTL_DBG(xe, args->pad[0] || args->pad[1] || args->pad[2]) ||
>@@ -4031,6 +4035,7 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
> 		vm = xe_vm_lookup(xef, args->vm_id);
> 		if (XE_IOCTL_DBG(xe, !vm))
> 			return -ENOENT;
>+		asid = vm->usm.asid;
> 	}
>
> 	/*
>@@ -4100,6 +4105,10 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
> 			if (err)
> 				break;
> 		}
>+
>+		if (lock_start == ktime_set(0, 0))
>+			lock_start = ktime_get();
>+
> 		bo = xe_bo_create_user(xe, vm, args->size, args->cpu_caching,
> 				       bo_flags, have_prealloc ? &prealloc : NULL,
> 				       &exec);
>@@ -4110,6 +4119,8 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
> 			break;
> 		}
> 	}
>+	if (lock_start != ktime_set(0, 0))
>+		lock_ns = ktime_to_ns(ktime_sub(ktime_get(), lock_start));
> 	if (have_prealloc)
> 		ttm_pool_prealloc_fini(&xe->ttm.pool, &prealloc);
> 	if (err)
>@@ -4140,6 +4151,12 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
> 	if (vm)
> 		xe_vm_put(vm);
>
>+	trace_xe_gem_create_ioctl(xe, args->size, args->placement,
>+				  args->cpu_caching, asid,
>+				  div_u64(ktime_to_ns(ktime_sub(ktime_get(),
>+							ioctl_start)), 1000),
>+				  div_u64(lock_ns, 1000));
>+

Will prealloc time (prealloc_us) also useful to print in the trace message?

Niranjana
> 	return err;
> }
>
>diff --git a/drivers/gpu/drm/xe/xe_trace_bo.h b/drivers/gpu/drm/xe/xe_trace_bo.h
>index b159d37d39a1..63db37edadc2 100644
>--- a/drivers/gpu/drm/xe/xe_trace_bo.h
>+++ b/drivers/gpu/drm/xe/xe_trace_bo.h
>@@ -144,6 +144,37 @@ TRACE_EVENT(xe_bo_defrag_one,
> 		      __entry->ret)
> );
>
>+TRACE_EVENT(xe_gem_create_ioctl,
>+	    TP_PROTO(struct xe_device *xe, u64 size, u32 placement,
>+		     u16 caching, u32 asid, u64 ioctl_us, u64 lock_us),
>+	    TP_ARGS(xe, size, placement, caching, asid, ioctl_us, lock_us),
>+
>+	    TP_STRUCT__entry(
>+		     __string(dev, dev_name(xe->drm.dev))
>+		     __field(u64, size)
>+		     __field(u32, placement)
>+		     __field(u16, caching)
>+		     __field(u32, asid)
>+		     __field(u64, ioctl_us)
>+		     __field(u64, lock_us)
>+		     ),
>+
>+	    TP_fast_assign(
>+		   __assign_str(dev);
>+		   __entry->size = size;
>+		   __entry->placement = placement;
>+		   __entry->caching = caching;
>+		   __entry->asid = asid;
>+		   __entry->ioctl_us = ioctl_us;
>+		   __entry->lock_us = lock_us;
>+		   ),
>+
>+	    TP_printk("dev=%s, size=%llu, placement=0x%x, caching=%u, asid=%u, ioctl_us=%llu, lock_us=%llu",
>+		      __get_str(dev), __entry->size, __entry->placement,
>+		      __entry->caching, __entry->asid, __entry->ioctl_us,
>+		      __entry->lock_us)
>+);
>+
> DECLARE_EVENT_CLASS(xe_vma,
> 		    TP_PROTO(struct xe_vma *vma),
> 		    TP_ARGS(vma),
>-- 
>2.34.1
>
