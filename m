Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDCC606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 02:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ia2JoOyj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=VnnGAyoQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2031710E8E1;
	Fri, 20 Nov 2026 02:14:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E530F10E3B0;
 Fri, 20 Nov 2026 02:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795140873; x=1826676873;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=e1LTrTtLkgX+YAu2ZIcCn4IPEhIJYWdHZ2lb5HssVA4=;
 b=ia2JoOyjHtYymq3HrYa0e/vUf4IPvI6e1VK5iXSKcEW/HgzFdIbSxxIl
 ehq1zgYX/p3oeYHOQVQJXmjEyutPBPDxd8Igoeiw721GFGngsyr9hOVrS
 m1tE8ZrnheInV/X64v04k9OuSH7cyYRFiz5hikCLDH+5c7aXY8JhJetaR
 Bf1tRPl+SnvcwaUA2SThiXEJvhHslGW/MIvnVm5OgwBP7kYKi78HZAjgS
 4kKcXHOysj8RsZvNJ7Wfx4u37rJhhMCA+pW1V2ipJbViLmZb6HhFz+7Dw
 kbshgjEyF1VFWK52at6o0sFdTU6RDISzqlQtkljlWMYMw+GGl6x3cm8qa g==;
X-CSE-ConnectionGUID: EZGVNMXyRBeFFgtupJzAmQ==
X-CSE-MsgGUID: 2sBLm9LQQsmQEBzaa/ILDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4046529"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4046529"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 18:14:33 -0800
X-CSE-ConnectionGUID: bCYxoTPZQ1W6x8uV0r5jXg==
X-CSE-MsgGUID: cMqnMNLiQ9CTN8DoDXyX1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10670578"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 18:14:32 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 18:14:31 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 18:14:31 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.11) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 18:14:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJz5Le2RecwoyL1xKuwPuScODiWiRrizl/5ol2g1joB4L+1hQ7bPKRHVJvDC/xtTXo+GzUIOZGTjoGYTq0kZtexW16KkpmOfjzfRl/jS5RGi7RWouY9b8uDDvkZzA3iq1BRcOhhvCeaT8LzU88vjhfbkbusv4bnlKV1Y7ZbG72ck9sqRUU1smXVPunUgF8KksFbjUYYtnq2LfKhqDEDkkpCdyTE3HVqCei4+1swSaQJgSJ+/U5NzZmAGpHs+jAtLSbOdCx8I173CLWEP/HkPzCKBnf2SNXr8Xd6ZqiQX1EgXdVx9kLLKt7T656Y+nS2w5But5IpNjwGIpJX9KOv2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCMTAZ2CCaI6/tBl5K5cBB9A9U+zFLEGqWWtCf5Ttgk=;
 b=mpKk5pIglVxehYxG2F1OKy1jYJTQ/kjIvLfWleKM5xx5SRTgi1b+uQybSyjc/SZhG936SrjPSntJ66cFIDCzHnXw/LAkDEg2x51eGc856gZvA3lLkQmIeBFw/R0ZZ5131O5pj+Cbzg0nsGl59h9AHRvnuYDZOh8MLPgzjwbDUhRd59kagRRCMeB0bc4NLfyIqM5DcKWmbM89/bsBraVuxlqlqMjOZZhtyDM8Gzbnukfk3sya/3M1iWUjHWqRd5dOwic2o87HFDlodO7yfb/vHbijfNlJG2tIIpnlSglv+mOqyCyFU2CsXm6crN66xsfvHN6D8ZA0f00PXImoTgip/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCMTAZ2CCaI6/tBl5K5cBB9A9U+zFLEGqWWtCf5Ttgk=;
 b=VnnGAyoQrqQiQuUkB54iJmLhlzmyPzK7BPnSnHR+vZq7n4EWDPBAh7Jjuot9fNqgJ5Am47+mIEz0QLWwAyHLiQkB85d0rEZoJztEJ/ZPdbEGtGazr+idNmfPZ92beXKoSeJMnUbhzxsEOR6hzn/8qDYSuQlkSBdMJ6bA/qM5J6s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by CY8PR11MB7921.namprd11.prod.outlook.com (2603:10b6:930:7d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Fri, 20 Nov
 2026 02:14:26 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 02:14:26 +0000
Date: Thu, 19 Nov 2026 18:14:23 -0800
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
Subject: Re: [PATCH v3 08/33] drm/ttm: Bound page (re)allocation per
 defragmentation move
Message-ID: <av+s/38v9gtCDhhr@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-9-matthew.brost@intel.com>
 <avKE9ruZsQwbsQEa@nvishwa1-desk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avKE9ruZsQwbsQEa@nvishwa1-desk>
X-ClientProxiedBy: MW3PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:303:2b::20) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|CY8PR11MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc7269d-f09b-4228-29ec-08df46abfff5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|1800799024|376014|261026121527099003|18002099003|22082099003|261022105027099003|261021123027099003|261009220027099003|4143699003|11063799006|56012099006|261009221227099003|261028144727099003|261022113327099003|261102123227099003|261022075727099003|10067099003|261102130727099003|261021121427099003|261009223027099003|261009221727099003|261009223327099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: WmpDBqejMZCUcqwaZkvQ1mM+n1gAMyLDjWkuGmSSn3jYcQ0UCx4dB7RZnzaMTODeHXX/Cu1UfncNqliCOqY9+zslwQUKNeBHrwl0zi7KkECn2r94NhCqXESvZSw0gbqD6PhajxTU8kMRVLzIeRKk3gqTbs8BsisX8hcWmmMjdDntYRZa9PE0V75BIdTI6gEqtCDqo8JaZUgM45qNBW0Dy1bVvo+mN18KD9RvlmYgk+Qz0oyjHIAFgx45TlI0nPyQRU7SDbmtsJmWjRoeAoMpU76Cu/yZ8pCrNwmumaleQFVUOKn+Y3XlA4P59gmo+5dtgYc8j43npuyXy+n7Yo5do7Wqzq9wFhy5wQyVW4E/Mg2lKZLagcd53or4ZYINfOdDj7aI2lrslIUPm7MSg7u01/+a0g6z6AEmO76Jya+1xAtroVBETFf0sN8a0izTC2ztlctHvLe4P/BUmvV18awAo/pcwk+n5v53lxwYjEpnVAPpsiugJkeAh+U6hfLJsvRMH53zdpuW0Gt69JUvcN5xzjUnxSxaHHtfIHouO71c8b5axLumnR+CJgz48EjtX6wlsKmBVFP6L9R04HSjwgPpgaCCD1MUpVkPq+ppvE3s0XapdRaRua4IsYHVeXs9NcCCqAt9eWt5IfY/5pW4ZMphl6raIKlA9Pb4rTu1aByBi+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(261026121527099003)(18002099003)(22082099003)(261022105027099003)(261021123027099003)(261009220027099003)(4143699003)(11063799006)(56012099006)(261009221227099003)(261028144727099003)(261022113327099003)(261102123227099003)(261022075727099003)(10067099003)(261102130727099003)(261021121427099003)(261009223027099003)(261009221727099003)(261009223327099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zRiriSUr355sP/5M/NRD9qxArrIzCKfwJpSj6TjBkrl5SPV+mV0XoG711e?=
 =?iso-8859-1?Q?YZTyjpbwLhxGAsc9pxYhvcN6qpSy526kK4Kiuc2e32QMeMvI6U+L0K6OML?=
 =?iso-8859-1?Q?KmiK/YyoAVXypA9eRQMLbMbokAxS6anuhvQqOnOI6oY1tOyfj15MKiCJM1?=
 =?iso-8859-1?Q?5lqn79kb/VyJDgkL5erHEkzkGVfTrk5xByxuq9tnDSIR7KFj+jWmSzbgm9?=
 =?iso-8859-1?Q?9BV9nJYNJgtpRDlMMCArMmPAjC0gNRNuTekTDM1wLkPz7Diavkmz6jTvxt?=
 =?iso-8859-1?Q?nUeqqNZF3faAjdfYTXG30pJ1yjtfEUV16X3v3FsSGOvbWt0aoCdfNW4baR?=
 =?iso-8859-1?Q?5huh0ILSOiWSNodJrRggouQQRVywav1u3DUJVHUqEIHI37Nvutl6jCHVZr?=
 =?iso-8859-1?Q?V9a7somOERBZDWtkX8z6/WLpsJXdisHGzvYB6jMQsJidU7PAVgleeQH/KD?=
 =?iso-8859-1?Q?/tQ0JSTGU7UgO1fLLtqZq4iXCG1kN61rzbdMh+wEVz9eSifAG/z0Ghtf+T?=
 =?iso-8859-1?Q?2JxjKsVtczcnpvsnckDv/6HSaXV/jls45EQnEv0gmaQTe8Tha3cjRxnM8Q?=
 =?iso-8859-1?Q?QDA9dMluHhU7uhcms49C0mh9RVbIqsx9k6erV1G+h6P65dWM+thPwlUyJf?=
 =?iso-8859-1?Q?Bv2CjkF9ofm3hTvrBpT2tDYkddYiDgx55Eya9A5l5D7Mkxgsa4FOrzGwjl?=
 =?iso-8859-1?Q?Q6fjSRvg3at5vGgkWXCbYJzfK16QlhCm57PwBJehqcyoIdhCaaKYXfEkUA?=
 =?iso-8859-1?Q?ao7WltlL9g76NEc/iPYp5FWMVd9H/YeL3XDw2x+i9GHqXh04wvP8Fbky92?=
 =?iso-8859-1?Q?Gq+I6K7baVWZPvs0gQCmqgPy5vmNjJquutqBt/sb/+V6bVnwiRmVZkG7Vc?=
 =?iso-8859-1?Q?6lmkaRBc0szPqfBaan5NVa3Uw6RXIdw9XLcLSzVE9SqgZ7C1A2s8zYAF/B?=
 =?iso-8859-1?Q?L346ggHr70E6lgTHIIa1K0/+dWXOpdl7cGxSzBTAkd6gtvSf9KIm10rxTo?=
 =?iso-8859-1?Q?IaDYOi+utgGxl2tjioWNdTUqBoEd+FmlqaTiwG6eOx+mBCiGZGD7laCoRH?=
 =?iso-8859-1?Q?RYn1nbS4suoLJYYZNKzsGvQWY9IB109PRQdXBB9EYwGAwtbnbVbGZxiyXv?=
 =?iso-8859-1?Q?DV31oQzjVnE0a1KT7k1oEZu33Zbz0UlCcFXXJF4OM1j6MsmGzD+1JkOYry?=
 =?iso-8859-1?Q?yPcc2//Xs7+QLseb6chFrbGaWcRxhXuLE1L0jFXi3swxFIRMF1YoRH3KKD?=
 =?iso-8859-1?Q?Sa2z7Tu6swyac9e4c8fnxqZVsLxAX1+k4rxh72jfHAQWFztSg76MQS4yhg?=
 =?iso-8859-1?Q?Tg5lB6gO1Hdw7ECAf55SPHavLi6xD2YUHZz3YhauZxoN6GcACcwzHXPcSF?=
 =?iso-8859-1?Q?MgHJE2a1H3LNQAUobEEEpmq0j0jWMFFnTwNBUfKre0oI2dNZJ/DmhCAHtp?=
 =?iso-8859-1?Q?v/zf+/IDDI5mvJRtlpZQRSgEU1YpZPvLEkeQhdLzstHks8CvH2Ipf2KoVx?=
 =?iso-8859-1?Q?10/ITjvRCR6yQRwHXw6PLDGrD20+jtuXoLsr9xuoFz0Iw1Tpae7DeV9rMV?=
 =?iso-8859-1?Q?aNjh8EYUwRR8laJmMnCpCHF4U2NBSS5529D3sgxg3/MnZiC1GrF17Dyo61?=
 =?iso-8859-1?Q?LfspDrbsTowFnL7OO9FKTUs25twGSCMwMWGjA2ZMo22YUkGleUydI1HfVG?=
 =?iso-8859-1?Q?rIiXlynwmi6UjMSrP5NMNXn7st7leN9r9d7mCs2qm71wO4gTEqYdG8u9MV?=
 =?iso-8859-1?Q?07SG+KsZeysCaLue0EdVfxEYGePRVIA212d5w5islo9s9FdFGszAeVM6AO?=
 =?iso-8859-1?Q?V2EFQlcswMaXdMEVtj5klF4LJDg4F0A=3D?=
X-Exchange-RoutingPolicyChecked: Jmo6HJE7J7j14LbO9a64E8YODL8fDX2NiV0n3m6sJMff/60LIVELNq99aQpWbN3NA5nKrLxmuZpjsEfgbuNCrgI4rivbq7kuMlGkOJGRxgs4sZnQ2E1Jy8MgRQfF9bQaYR962Cw3Vb18THFlvoTOEF5/ksaz8/+xIjGUfM7syyPNbc8ZzsEhgfXoP9EN0bz19Z9iViW8zh82CeeybnOvqWRRw8vyUdlCNr+/0aLMeyqcegSjnh+hI7GWyD0an2QD2N5clE9aYwleafCpaZqDk/RS1zt5vTSeH0JcRk23+JK4BtSSXPUvCuL0KTc6GLaidEXqFnNwPD1QyRvuGFlOVA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc7269d-f09b-4228-29ec-08df46abfff5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 02:14:25.9495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7mvlt/AHdYsf3xT6w7qJ4azndh5ijcTVihYeCFE3L0e5H2DbPvJ3mIx4gqSUs9QbSf4vv4RUPLFCeyNtGVRoeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7921
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

On Mon, Nov 09, 2026 at 06:44:06PM -0800, Niranjana Vishwanathapura wrote:
> On Fri, Jul 10, 2026 at 07:55:54PM -0700, Matthew Brost wrote:
> > A defragmentation move reallocates an object's backing at the device's
> > beneficial order and harvests whatever the allocator cannot upgrade from
> > the old tt. For a very large object this can reallocate (and have the
> > driver re-copy) the entire backing in one move, which is expensive and
> > can stall concurrent work for an unbounded stretch.
> 
> Assisted-by: LLM
> 
> NIT...So, a time budge would also be helpful here along with the size
> budge?

That could be option but a size budget seems like reasonable place to start.

> 
> > 
> > Add an optional per-move byte budget so a large object can be upgraded in
> > slices across successive moves. Plumb a new
> > ttm_operation_ctx::defrag_bytes_remaining through to the pool allocator:
> > only pages actually (re)allocated at the beneficial order are charged
> > against it; pages harvested (borrowed) from defrag_old_tt are free and do
> > not count. Once the budget is exhausted the allocator stops upgrading and
> > completes the new tt by harvesting the remainder of the old tt as-is,
> > marking the tt sub-optimal (TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED) so the
> > driver re-queues it and a later move resumes the upgrade. The slices
> > already upgraded come back as free already-beneficial harvests on the
> > next pass, so each move spends budget only on new forward progress.
> > 
> > The allocator decrements the budget as it allocates and writes the unused
> > remainder back on success, letting the caller compute how many bytes were
> > actually spent. A value of 0 means unlimited (upgrade the whole object in
> > one move), preserving the previous behaviour. This is only consulted on a
> > defragmentation move, i.e. when defrag_old_tt is set.
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
> > drivers/gpu/drm/ttm/ttm_pool.c | 101 ++++++++++++++++++++++++++++++++-
> > include/drm/ttm/ttm_bo.h       |  14 +++++
> > 2 files changed, 112 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> > index 52f5e64f05dd..1673e81b8df8 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -77,6 +77,11 @@ struct ttm_pool_dma {
> >  * @dma_addr: Pointer to the next tt dma_address entry to populate if any.
> >  * @remaining_pages: Remaining pages to populate.
> >  * @tt_caching: The requested cpu-caching for the pages allocated.
> > + * @defrag_bytes_remaining: Byte budget for newly (re)allocated pages on a
> > + * defragmentation move, seeded from ttm_operation_ctx::defrag_bytes_remaining.
> > + * Pages harvested (borrowed) from the old tt are free and do not count; once
> > + * this drops to zero the allocator stops upgrading and harvests the remainder.
> > + * On completion it holds the unused budget. 0 means unlimited (no defrag cap).
> >  */
> > struct ttm_pool_alloc_state {
> > 	struct page **pages;
> > @@ -84,6 +89,7 @@ struct ttm_pool_alloc_state {
> > 	dma_addr_t *dma_addr;
> > 	pgoff_t remaining_pages;
> > 	enum ttm_caching tt_caching;
> > +	s64 defrag_bytes_remaining;
> > };
> > 
> > /**
> > @@ -780,6 +786,7 @@ static void ttm_pool_alloc_state_init(const struct ttm_tt *tt,
> > 	alloc->dma_addr = tt->dma_address;
> > 	alloc->remaining_pages = tt->num_pages;
> > 	alloc->tt_caching = tt->caching;
> > +	alloc->defrag_bytes_remaining = 0;
> > }
> > 
> > /*
> > @@ -885,8 +892,12 @@ static int ttm_pool_harvest_page(struct ttm_tt *old_tt, unsigned int order,
> > 
> > static int ttm_pool_harvest_remaining(struct ttm_pool *pool,
> > 				      struct ttm_tt *old_tt, pgoff_t off,
> > -				      struct ttm_pool_alloc_state *alloc)
> > +				      struct ttm_pool_alloc_state *alloc,
> > +				      bool *suboptimal)
> > {
> > +	unsigned int beneficial = ttm_pool_beneficial_order(pool);
> > +	pgoff_t bnr = 1UL << beneficial;
> > +
> > 	/*
> > 	 * @off is always an old-tt chunk head here, never a tail page, so
> > 	 * reading the per-chunk order below is safe. This holds because:
> > @@ -906,8 +917,23 @@ static int ttm_pool_harvest_remaining(struct ttm_pool *pool,
> > 		struct page *p = old_tt->pages[off];
> > 		unsigned int order = ttm_pool_page_order(pool, p);
> > 		pgoff_t nr = 1UL << order;
> > +		pgoff_t num_pages = off + alloc->remaining_pages;
> 
> num_pages seems loop invariant. May be move it out of the loop as total_pages
> or something?
> 

No, both 'off' and 'alloc->remaining_pages' change each iteration of the loop.

> > 		int r;
> > 
> > +		/*
> > +		 * Only report a sub-optimal backing when a chunk we cannot
> > +		 * upgrade (out of budget/prealloc) sits in a beneficial-order
> > +		 * aligned region that fully fits in the tt: that region could
> > +		 * have been upgraded with more budget. A chunk below the
> > +		 * beneficial order is expected for the unaligned tail (the last
> > +		 * partial beneficial-order region) and for already beneficial-
> > +		 * order harvests - neither leaves real defrag work, so they must
> > +		 * not flag the tt for re-queue.
> > +		 */
> > +		if (beneficial && order < beneficial &&
> > +		    round_down(off, bnr) + bnr <= num_pages)
> > +			*suboptimal = true;
> > +
> > 		r = ttm_pool_harvest_page(old_tt, order, off, alloc);
> > 		if (r)
> > 			return r;

e.g., below here (unseen) 'off' is incremented by 'nr'.

> > @@ -951,6 +977,7 @@ struct ttm_pool_alloc_iter {
> > 	struct ttm_tt *defrag_old_tt;
> > 	unsigned int beneficial_order;
> > 	gfp_t gfp_flags;
> > +	bool defrag_capped;
> > 
> > 	/* Mutated as the loop walks the orders. */
> > 	unsigned int order;
> > @@ -962,6 +989,44 @@ struct ttm_pool_alloc_iter {
> > 	struct page *p;
> > };
> > 
> > +/*
> > + * Defrag move budget exhausted: the upgrade can make no further progress this
> > + * pass. Snapshot @defrag_capped is set only when a byte budget was in force at
> > + * entry.
> > + */
> > +static bool ttm_pool_iter_defrag_exhausted(const struct ttm_pool_alloc_iter *it)
> > +{
> > +	if (!it->defrag_old_tt)
> > +		return false;
> > +
> > +	return it->defrag_capped && it->alloc->defrag_bytes_remaining <= 0;
> > +}
> > +
> > +/*
> > + * Complete the new tt by harvesting the rest of the old tt as-is (borrowing its
> > + * pages, including any still below beneficial order). Never fall back to in-lock
> > + * reclaim for the shortfall - that would reintroduce the stall we preallocated
> > + * to avoid. Only re-queue (flag) the tt when the harvested remainder is
> > + * genuinely sub-optimal; if every remaining old chunk was already at beneficial
> > + * order the move fully upgraded the object.
> > + */
> > +static int ttm_pool_iter_harvest_rest(struct ttm_pool_alloc_iter *it)
> > +{
> > +	pgoff_t off = it->tt->num_pages - it->alloc->remaining_pages;
> > +	bool suboptimal = false;
> > +	int r;
> > +
> > +	r = ttm_pool_harvest_remaining(it->pool, it->defrag_old_tt, off,
> > +				       it->alloc, &suboptimal);
> > +	if (r)
> > +		return r;
> > +
> > +	if (suboptimal)
> > +		it->tt->page_flags |= TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
> > +
> > +	return 0;
> > +}
> > +
> > /*
> >  * Defrag move: reuse an already beneficial-order chunk from the old tt at this
> >  * offset rather than reallocating it. Harvest whatever order the old chunk has
> > @@ -1062,11 +1127,12 @@ static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
> > 		if (it->alloc_count && it->defrag_old_tt) {
> > 			pgoff_t off = it->tt->num_pages -
> > 				      it->alloc->remaining_pages;
> > +			bool suboptimal = false;
> > 			int r;
> > 
> > 			r = ttm_pool_harvest_remaining(it->pool,
> > 						       it->defrag_old_tt, off,
> > -						       it->alloc);
> > +						       it->alloc, &suboptimal);
> 
> As suboptimal is not required here, probably send a NULL here and have
> ttm_pool_harvest_remaining handle that NULL.
> 

That is better will change.

> > 			if (r)
> > 				return r;
> > 
> > @@ -1121,10 +1187,23 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > 		gfp_flags |= GFP_HIGHUSER;
> > 
> > 	it.gfp_flags = gfp_flags;
> > +	it.defrag_capped = it.defrag_old_tt && alloc->defrag_bytes_remaining > 0;
> > 
> > 	for (it.order = ttm_pool_alloc_find_order(MAX_PAGE_ORDER, alloc);
> > 	     alloc->remaining_pages;
> > 	     it.order = ttm_pool_alloc_find_order(it.order, alloc)) {
> > +		/*
> > +		 * Out of defrag budget: harvest the rest of the old tt as-is and
> > +		 * stop (the tt is re-queued if the remainder is still
> > +		 * sub-optimal).
> > +		 */
> > +		if (ttm_pool_iter_defrag_exhausted(&it)) {
> > +			r = ttm_pool_iter_harvest_rest(&it);
> > +			if (r)
> > +				goto error_free_all;
> > +			break;
> > +		}
> > +
> > 		/* Reuse an already beneficial-order chunk from the old tt. */
> > 		r = ttm_pool_iter_reuse_old(&it);
> > 		if (r < 0)
> > @@ -1155,6 +1234,15 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > 				goto error_free_all;
> > 		}
> > 
> > +		/*
> > +		 * Charge a newly (re)allocated chunk against the defrag move
> > +		 * budget. Harvested chunks borrow the old tt's pages for free
> > +		 * and never reach here.
> > +		 */
> > +		if (it.defrag_capped)
> > +			alloc->defrag_bytes_remaining -=
> > +				(s64)(1UL << it.order) << PAGE_SHIFT;
> > +
> > 		it.alloc_count++;
> > 	}
> > 
> > @@ -1204,14 +1292,21 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > 		   struct ttm_operation_ctx *ctx)
> > {
> > 	struct ttm_pool_alloc_state alloc;
> > +	int ret;
> > 
> > 	if (WARN_ON(ttm_tt_is_backed_up(tt)))
> > 		return -EINVAL;
> > 
> > 	tt->page_flags &= ~TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
> > 	ttm_pool_alloc_state_init(tt, &alloc);
> > +	alloc.defrag_bytes_remaining = ctx->defrag_bytes_remaining;
> > +
> > +	ret = __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL);
> > +
> > +	/* Report the unused defrag budget back to the caller. */
> > +	ctx->defrag_bytes_remaining = alloc.defrag_bytes_remaining;
> > 
> > -	return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL);
> > +	return ret;
> > }
> > EXPORT_SYMBOL(ttm_pool_alloc);
> > 
> > diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> > index fcaba5fb8bf7..6124d2627b47 100644
> > --- a/include/drm/ttm/ttm_bo.h
> > +++ b/include/drm/ttm/ttm_bo.h
> > @@ -223,6 +223,20 @@ struct ttm_operation_ctx {
> > 	 * NULL for non-defrag operations.
> > 	 */
> > 	struct ttm_tt *defrag_old_tt;
> > +	/**
> > +	 * @defrag_bytes_remaining: Byte budget for newly allocated pages during
> > +	 * a defragmentation move. Only pages that are actually (re)allocated at
> > +	 * the beneficial order count against it; pages harvested (borrowed) from
> > +	 * @defrag_old_tt are free and do not. When the budget is exhausted the
> > +	 * pool allocator stops upgrading and completes the new tt by harvesting
> > +	 * the remainder of @defrag_old_tt, marking the tt sub-optimal so the
> > +	 * driver can resume on a later pass. The allocator decrements this as it
> > +	 * allocates, so on return it holds the unused budget (which the caller
> > +	 * can use to compute how many bytes were spent). A value of 0 means
> > +	 * unlimited (upgrade the whole object). Only consulted when
> > +	 * @defrag_old_tt is set.
> > +	 */
> > +	s64 defrag_bytes_remaining;
> 
> If user specifies -ve value, currently it means unlimited. So, may be update the
> documentation here to say "A value of <= 0 means unlimited"? Or, better only accept
> > =0 value from the user ctx here.

How about I reject user input defrag_bytes_remaining < 0?

Matt

> 
> Niranjana
> 
> > 	/**
> > 	 * @resv: Reservation object to be used together with
> > 	 * @allow_res_evict.
> > -- 
> > 2.34.1
> > 
