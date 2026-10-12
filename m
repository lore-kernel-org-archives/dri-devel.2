Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF17CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC9FC10E593;
	Mon, 12 Oct 2026 14:11:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCABF10E593;
 Mon, 12 Oct 2026 14:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791814290; x=1823350290;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=YhUV4G7a9G3yAH3v7M6xpjhVVVpCSlVq8GS1bQPw2bI=;
 b=ZLw+lhUGobWC+g4DNkdNAc7E56tSKomcGLijlJ67o221403EgSK2sdIX
 nfpomVkkZP+BQIlFj52n6pydsdvZlasNBFNtaNaK3wGvZRnYsb0+Dz7RL
 n7csenAHH4LZ3SahxJdq/3I32mfKmb3ap0eOIC9j3raojS7sIzf3QGyzm
 wyF6ta97Z0HajsG5yJgQaDntQtaoUpnu4HZOzWozOyUEsaShACCkyMDzz
 b25SUZ8WAWsdFdg+zX9TsoegXhGHOB7ie8VK7/O7u09BDpRSWFuDOIjB9
 ZjleBg2lZm0agQRP3JuS3Geb0so+4wbd7jjN+3dfPPhbNuGlka1tfMS05 g==;
X-CSE-ConnectionGUID: Uq771qbIQKqiztmC261aCA==
X-CSE-MsgGUID: pFDziMPuQymZovpG8i5x1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="627820"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="627820"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 07:11:29 -0700
X-CSE-ConnectionGUID: Z2M+lwu0Sz20NivZzA2Sqg==
X-CSE-MsgGUID: bQUF+BSSTBOcYdCkSjqEjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1380774"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 07:11:27 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 07:11:25 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 07:11:25 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.68) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 07:11:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntmN7/1SCGcWujxDhjdVdDuk/JJ5worYWb89fg97jyPh5FxXPdLxtZQ2nx+xidBdPani7BeznWYTFH+O/B/LKRD+ECQhMoq0xRBqFTl7SX1aC4zSMSMySNTwdv5s0BeVL8jcRB+JL08nCSJbi3W9MbegBAcMYWb2dKnYPWxraEXi176220ZWdIZF6at7sjwFe3iy2ttHlBgL1kPn4mJAPxzNQKr3aiQGtipyS/8+hA+CoesReIV7njiH++5bgMYw03YU2OcOxiLwCi1yhX4F+LPMsbD6W84dXSxiWLu87LDlPgCLBT/J/Ync8yn2tTynkrZD+ruBMvOn9fHobqkOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jcsj37We55pViW9gmbR93e5CuU6pjRTHu+h7P6hoYTE=;
 b=H+2Eo09MXJpK/kS01zY+afCHlm4MJ0dkHjJo3c2AXhbaT+Qy6vdbL94Zh7SEhXN2GdvT9fu7PDez/P/y9w8aZQrlsGEWQ+dFVTlGuq6jalz8yIIkRXiMSX5LN+YVuQtLN6ik8wNCp8v6JggsN/5+Skkrq3LdH8WkGCiamU7xfrM5b0HoouEfSJbrSBeIN/HcNpZPPAbk16V+BMwYr8yxUp4vuNaLojOrJpiZeDG2Dbk4hcKf2mXLeQq2CjXpqE5aP3mzLSgSyeWbgNorYWk8KMLtXS3yq3f64cqhTkzzss+265H91xYHvL7a4L02Ui55OeZ1s0hgbpePAEbdXTBBeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4792.namprd11.prod.outlook.com (2603:10b6:510:32::11)
 by SA1PR11MB6784.namprd11.prod.outlook.com (2603:10b6:806:24c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Mon, 12 Oct
 2026 14:11:11 +0000
Received: from PH0PR11MB4792.namprd11.prod.outlook.com
 ([fe80::fec9:8db4:c768:8289]) by PH0PR11MB4792.namprd11.prod.outlook.com
 ([fe80::fec9:8db4:c768:8289%6]) with mapi id 15.21.0472.016; Mon, 12 Oct 2026
 14:11:11 +0000
Date: Mon, 12 Oct 2026 07:11:08 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Liviu Dudau <liviu.dudau@arm.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>, "Abhinav
 Kumar" <abhinav.kumar@linux.dev>, Alice Ryhl <aliceryhl@google.com>, "Anna
 Maniscalco" <anna.maniscalco2000@gmail.com>, Antonino Maniscalco
 <antomani103@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, "Dmitry
 Baryshkov" <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Lyude Paul <lyude@redhat.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Marijn Suijten
 <marijn.suijten@somainline.org>, Maxime Ripard <mripard@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Sean Paul <sean@poorly.run>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, "Steven
 Price" <steven.price@arm.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 7/8] drm/nouveau: use DRM_GPUVM_RESV_PROTECTED
Message-ID: <aszqfCemcNPebrgZ@gsse-cloud1.jf.intel.com>
References: <20261001220632.3190896-1-matthew.brost@intel.com>
 <20261001220632.3190896-8-matthew.brost@intel.com>
 <asUm6j1GD6yxeBvy@e142607>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asUm6j1GD6yxeBvy@e142607>
X-ClientProxiedBy: BY3PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::22) To PH0PR11MB4792.namprd11.prod.outlook.com
 (2603:10b6:510:32::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4792:EE_|SA1PR11MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: eab775bc-10c3-4757-ab8a-08df286aab0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|261009223027099003|4143699003|11063799006|56012099006|5023799004|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 05NtOcPrvvcLMZeRR+IVUXDICbH/WTT1S8i8zgWVJGtP7vMFIO5ntRw1tHyXu2Zl8g4wTeesQa/4eBrRRJM4/y4DPjirJAZ4Fj2IWHY8Uep6r5EL+SO15nngC5IxOLD+xlYviNn/PpThOaq/vwxCioxaU0ZEZQ6XKjGVjxOBdQL0MmKkVVo+9vDXk1ZxhowXV7XsLD6Ue6/qyalQGHBYCo3fW7VFIwT1aAWmMs7kKAsBNrY50oPDQqzMddYGxOLXMVngKGB7gmWTQdyHbR/Rs/kkVBCFY6YuSfbbSx4P4zxh9KU4AGaNtiGZO0GQsuqc/PjScLaO4BSq2vFMqqIjkywtBJ5uz+rpNyv+R1p4rSDGJeMZzrJjP/QeqlrLEYF17YsXDYT9FU0afAzKxffYWikD8j0o3g/AJets1gbL4aoAPLnXRSJ3N89PzqPIQp+o+joyouYFaYPdqt4jsns/PGV58rd6SftzTJ3IELX3IwWim6FmzLj+6BjFVX840ctfMDRaNNswOaLfv6IXsPqTlZNPKpdrEDs/DQby6tte79X92J7udk4hYzb3EA7dYdomho9f8NFUlmb8yxu4kw0lClvJ8p9+M5D7ybx4UVwYNo26cQMyyfI6nxvaYhOZNqcF5OhpbZAUso5q6uRkktZEyH1NMkHIY1xCWPnjU2KY9ys=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4792.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(261009223027099003)(4143699003)(11063799006)(56012099006)(5023799004)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWg5bkd3cS9KMXJTNEdQNEx6T29ZUHF2QjVnalBPUVplUWFEVUx1c1BRRTcz?=
 =?utf-8?B?NnZHVG52eWNveXdUWncvWXFmZjN2VXNxOG81RGtaWmxSaCs3Wng5aTVTNGxi?=
 =?utf-8?B?QTc1SlVEV1hDWWRvTC9TSDdkMmRGVkUzVFRxYXY5djN4dURmWm40eGRTUjky?=
 =?utf-8?B?NjBQdDhBcUFYOTZJUlplazR6MXQyR1lhUDZWdlFBNHEwdHRwUUNlcDR5MzNu?=
 =?utf-8?B?L1NLK2RqamZxdlVOd3FzeXI2dTljYU5RRUs3N0tydElXcXVHTTF2eVA1UDNQ?=
 =?utf-8?B?RHdGaXByRmwvWjdCMC9UZlJiaU04bThOMHlpdWkvQ3RRL0FvNHROdndUN3Ri?=
 =?utf-8?B?aGxHODhXY3FiQ25sd0g3SkovSCtqaVlpZ1oxSW01Wm0rdVRORzRtSytDbXE2?=
 =?utf-8?B?aG13MVpYRXQxZE81S1VPZW5OVEZoekM4cDJVWStIY1VCZHhlYkphR0xFZExn?=
 =?utf-8?B?QW52WGl5eFdYVVAyZHloK1FLdDZ1dFllS3lEOXNSYU1RRzRoNDV3WkZPTFh2?=
 =?utf-8?B?aE9lQW9CQnZiS21ScFk2TnFXUGpOcEcveXBHb2YwbFFzUkVZbEhrVWdlT2th?=
 =?utf-8?B?TUNJcll4U2hCZnZIU01UMW1wTWNxbFdYVHZwN1AzQmRMY05lbUtDM09rdDZr?=
 =?utf-8?B?VHgvdFlrNS83WXVaaU5KVk1SQnc3Q3cwS05FMkRnZHJNRGZEVFVUWVkya1VV?=
 =?utf-8?B?VWJoSTNKT0ZzeVBoaWNsdHZDdzJuQnNSOUFEUzNCb2tScmUwRDZ4NndwUmJG?=
 =?utf-8?B?eXE1RStIYTVhYzlMdWNuOGt1bmJNTXlrbkFhcU1Lc3ppZi8xa3BqSjlBNUJH?=
 =?utf-8?B?YlgyeVZnSTQvZnJnVjFVbUl4ZVAzc1FDQWFRSVZ3RUNLRmZ5L0RDVHVaU2V5?=
 =?utf-8?B?OWY5QVRUb1JzeUh0L3RWNnNWcG96N0wxYWdUR2RObmxhSkhmV0N2UWdjWUp6?=
 =?utf-8?B?ZCs1NGMvWEhQaDY3OFdkMG5idlg1bGR0UCtLbFB6VHk1V01vN2tIaitoOG4x?=
 =?utf-8?B?UzljWVliMTEycGk3Tzl2Ulk0S0ZUYlNZbjIybXhXQ2lQVGxzMHQzWDlzMXJu?=
 =?utf-8?B?UVNEQnVsNzRvckp3ZkZQUjVGaVFFbEhaMi9WL0gzT0NwcDlaeVNlSWdtMS9L?=
 =?utf-8?B?aTVSQXNhcVlKN1BMcmJteXlCRE0wdzB4VXFPdkRWblBLU3pxb0FLYUFpQlJT?=
 =?utf-8?B?dDBtTDZyYVNFWjQvcG9BZjF3RlpkcnFERnI1SS9DY2E1MDI1aDJocXJmLzVB?=
 =?utf-8?B?NXBJRENmUEllZ08wdG8zaThObytrU0FpN2xJdzFocGI3Q0Fpb2JsanBKdWd4?=
 =?utf-8?B?YzFZeHRHSmZkZmNFWGM2cTVaVjhsOS9rMnpCUVh0aXAvUGR2QSsvblZ2UzdM?=
 =?utf-8?B?M2FNQlQxNFVSbHo4WUhFUTkvbDhBNzZmbTJianh4UEVBdkpaKytYbkx0bmlI?=
 =?utf-8?B?azlNWStLSWZsbWZWcHdBUUJkT042em9RSmsxU1cxQytNY0V6NXAxTklMU003?=
 =?utf-8?B?MmIwMlRmWi9ONGdRa21qUXBQRU85RC9JcExJZHd6OHhQOUJCdm1jNDIzYU9F?=
 =?utf-8?B?VUVyUkJERy8vbG5vWlhGdDNQdENHSGh4amUvaGhoaFdSYzdielBBSmVXTGl2?=
 =?utf-8?B?eWNMa3VEVEdxNFlkZFdyVUx5RDVBbCt3QnN5ZFJZRjY1blVLWGkrSWxWN3dC?=
 =?utf-8?B?ODBEaFlRbEpKOUtsNkVEaWRRSHNmZENOUmROa1R1bFpzZGV1cDhnRjJkWmhp?=
 =?utf-8?B?V1ZKSFpRTG9yWURsZjVxcW03a3FGQnRwajNvT1ZJd293WE9FSDFmRS90Ykdk?=
 =?utf-8?B?R1B4TUg1NEcvTUxiN1V4Qnk4YmdyZFlWSHEwSEpXMGVrY2tmbU53aWVLUm5o?=
 =?utf-8?B?QnJHdHh4M2VaQ2FSNFBNaEFUUmxOcXpBc2RDSlFtOVRzTjVYZ1ZMV1oyc3RK?=
 =?utf-8?B?ditOZktnOGZNSWhZME5TYUlONGtzYmpWSVFqcUpDSjhqYVFNZEs2c3hFT09Z?=
 =?utf-8?B?ZU1iODFmQ3JMRm1wUDhXZUNZTXl3WTEvbjZLUnpyTTN1aGIvTm9sbktYQ3JP?=
 =?utf-8?B?U3VlNHRjeUNKa1VoQ2drNWJzRGNENW9pWnlMbzRXcS9USDJkWjFNamtjQkZk?=
 =?utf-8?B?YjY1dlpnUzJpTllpdFovbStxN0FKaTNaY2NqbWVUUW5nZTU4a1FwaFBvMXBC?=
 =?utf-8?B?TTc2UmxuaDIyU1FJS2pBNUhTU2lnSTJ6MHhSanVoaTRDMjIxeE1RQ2Y0TXU5?=
 =?utf-8?B?elZUcGxjREtKZXZzODRXUkdVdmhQN29rT040RVhSNW5neTdhL25mKzdNWm5i?=
 =?utf-8?B?MU5wQzhKMElqbUV2eUgySHJpMldmdXFxUGFOWGo5UnNKTDRWdm1FZz09?=
X-Exchange-RoutingPolicyChecked: O0mHiwzUiYXgesEDU6pGeilQjzCFEiU27zUoVdFFT6lUWGPfx2q1GRO5tfUGwZdOSewwfMU2gIFQIQm7LwhT0BVMs/A8GHO1zGMH4geRlzhA0n9YONL/cfmYX1tCU4ZF9r3hMLrDRorqKKKsXKPA4IAwAAt8s+iQxyJ1Jp1IOFXAH87lGvd8QAWz+csartHBsh6KXE+KRV9LYtNX7LSugQc/R7wHrB2ahXmwGnX3uS5V9loo4lNsa1JPsTtBTRiMndNwgKuoiu1Kf2idtHDWQH0CsB/563rimb3cW/ks94L7BgRIthax73FXTNk39dQRw3JfUs3qMl6fnVC2RbCpLA==
X-MS-Exchange-CrossTenant-Network-Message-Id: eab775bc-10c3-4757-ab8a-08df286aab0d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4792.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 14:11:11.3340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XskEuLj0zfTA1vmh4fhfVT9g+LEADfjlqsDxjLW3IAZ0FiSF432A6wtfKH6JHQZEdCeyv9KB0oISRu4hNVI9Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6784
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

On Tue, Oct 06, 2026 at 05:50:50PM +0100, Liviu Dudau wrote:
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
> 
> Bit confused about this. If Danilo contributed this patch should it not carry his S-o-b as well?
> 

Danilo - correct me if I'm wrong but in prior rev one of your dislikes
was some drivers using DRM_GPUVM_RESV_PROTECTED and others not (msm,
Nouveau), thus I have both fixed in this series as it was quite easy +
using two pass gpuvm.

So Danilo didn't contribute, rather suggested.

Also in a follow up we should probably rip out
non-DRM_GPUVM_RESV_PROTECTED support as I believe all drivers will now
use this.

Matt

> Best regards,
> Liviu
> 
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
> 
> -- 
> ====================
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     ¯\_(ツ)_/¯
