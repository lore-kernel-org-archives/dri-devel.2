Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9253606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GEN8aaQe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=VTLEOXIi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50B6D10F017;
	Tue, 24 Nov 2026 15:37:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A74E010F640;
 Tue, 24 Nov 2026 15:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795534666; x=1827070666;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=74mWzKQeAJymaVLTpR2jKlhcsNAfIerQupO+IW9mVf8=;
 b=GEN8aaQeP0S2euFq9AOC8PO2RId50oMfgbF0/8XSerSTARqifhLc1BGY
 iypCq+TUmbfCCLGmWf3AHgd042VCBBIGPERTtuFh6p2WpkRZ8Gidqa0IT
 ZAaKMuFP8fexX08Zo3NCSXfsY1E+OVfmeOWdVBiyiUn4/ecVvkJesmWkz
 H6Bc1XEccXTlmZwDNxFDcZU2S5ZDkR8y0FShJXgACZZgYbeMNfo0lFyg3
 akNlFxu5466ixlvtZ0b4+7vviIE2b5Qb7BwC5JyvYiSiK2w2lsLMYTbyY
 Zx+p5QRI89NyiynWLmdWvnanjJzmyiKCgNWzdP394CSkHAf5IVvOoeZka Q==;
X-CSE-ConnectionGUID: xZATvvjKR/6eTbg2nC4T0w==
X-CSE-MsgGUID: fDbGdZnqQnCqt/+4xeugDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4386086"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4386086"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 07:37:45 -0800
X-CSE-ConnectionGUID: 57OmKJGjT4WIkbO3OjhehA==
X-CSE-MsgGUID: LKyluw3EQXGuS/wEnZnunw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11891616"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 07:37:46 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 07:37:44 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 07:37:44 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.2) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 07:37:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuVUU1pOZOO8H1Q0wWOaVFwPlZ+eXds14fbHBUIAfzvcc8P8vzHg3oi8hIfWamm0n5ZtJe5iIpt9nSOlWoGhHn9+Q/vU0t/0QlmXv2VdjvBZxWwrGJ1twis3rWeQFBb7Wgzxb+MVXCOgpBOQj1Pm/e7HA2hqJA0mC9/LS5zIkNqsz3tLbGR4DHfrRu4YhVCaOEFlZp0Q7aCQkYpvk7pVfjSIBO60MXZDTpvXoMass3eyuRMb24PXIeh50guDrIhxrEAQ7bGZUkKoVbSEtnFDe+o9W8I17UVEK+TVewDetX6zlUswPQtZlYHl6WDOKR4IzEAU4iXLZP9BX/RdjlnOlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IA9Df4m3jUK5HMwV/Vr/n/FiLN18QvHgHGqqc45d7sM=;
 b=SjpvqyF1x+8oskIoLh87aV+WEoPyzq14pBKqci4CJfBrd/le9RaXwtjJ4NJv99RlaKZR/8cJYypYxBKRSZV+MoJ07uImVfDmFZAQM+3aPyEaVf2TZNIQ5jCRdRwI3DuvSSzcsLZd6K71YqhDLcZX/M8DL6xk+Txf+C626vu02RUZsi450rq1NIbqRtaDLNXy96wIhNWx+K38QRN6UBuMjsL/ee78mRqEW5/TyIkHVomyH/axMkeF4TAhwSKWJ49yihJXumLNFw2X+prlOzgk83PE2PANDYMY/NHpUnec6lGydgk32eYHuEHUuMfRzsBR75muv1JPGo6BhJSZs6QxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IA9Df4m3jUK5HMwV/Vr/n/FiLN18QvHgHGqqc45d7sM=;
 b=VTLEOXIiEIdRSx9BhG1pvUax+nFMOwZT61ymXB4C2yFPS1xoW/X/32EbbfESlw9wuaQCQeGrWfYFGjKvlHllQp+8BU1Uv6FVU4vN/iAvcBkHGZan0nh4Jg7Ku8KX8tzEjl2jW4hL/k55PH+n0+by96qbt1zSSGxaTXwv2mPRSyA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DS2PR11MB075082.namprd11.prod.outlook.com (2603:10b6:8:3c6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 15:37:42 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 15:37:41 +0000
Date: Tue, 24 Nov 2026 07:37:38 -0800
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
Subject: Re: [PATCH v3 18/33] drm/xe: Handle defrag moves in xe_bo_move()
Message-ID: <awWvQlMgHAV1urDL@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-19-matthew.brost@intel.com>
 <au6zTq7ophThShBO@nvishwa1-desk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <au6zTq7ophThShBO@nvishwa1-desk>
X-ClientProxiedBy: SJ0PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::25) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DS2PR11MB075082:EE_
X-MS-Office365-Filtering-Correlation-Id: 64db7ef0-415d-4bce-beee-08df4a40e064
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|23010399003|1800799024|10067099003|11063799006|4143699003|56012099006|261021123027099003|261022105027099003|261021121427099003|261022075727099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tHZ9izl4xfN3W/MiddEJ9K58O5VTz/D2PTjAw5toRzLe1Me0LDz/NFEj3EgSx/3p6VetSA0HHRs4QdhUJlziV7eMGVseNHcu/gEBks9Da9ZmX7R+GtdughzgWieVEv9IyI2fqIh8JNdypF4XrUZqJeWOeGSV+mzTSNcsUyW8/1XMFnQ/sY3+PfZBqez3G/DhOGXmfHKHUSVUVF1OWD97K1RnhAfKBuPCxia+Xco16SzUH/rfr2I6tDG0IQjO0pifgx+6lzVAmarUthyOS6qO8xPFDpnuVIPXpQf3aEZxDzoCmBneuWdtTEh3koxarI3ZXwb3nl+s83faamrDZri4BV3JkipUCvKwpenv2OpcqNXPuPSRRseu5kWYNfQTdlWbEAB69Pm31B/lRoBNv6Tjb09dCGl0jBfxTQL62UhlHl1Zw1ob8eGZI6wsLm6dMhD4aw74q3WwAUmE5cB9SlusDyfXnIgvgXa0J0XuFk6vuxrJm/kOYWQoddbTPdnTkL77CxSeKXcWfeMcDgFx9gwnI3cUZC0UwLsUNWUPskQxwNo+RRhH1UkTlaeNniUwATyn7uH4djvHWx2R4Rlhuiw02ESekh8OSW7g9SewPEiOw6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3MuuBdZP7Ygs2JBXYFHb7Xi5wFrLdk7XJGGfQLAgd6ZizFigL2zQD63xpg?=
 =?iso-8859-1?Q?7+8T+AgSOtPLPt0vONKv5ibn/zGnVY92q1dT2k/uETd3ENbAHkMTvXUEvE?=
 =?iso-8859-1?Q?69G1zGld9SCOMBLX13thtAApyjtydNfTNQ3DMDDD2SWs2mNaF3AyxPIuu+?=
 =?iso-8859-1?Q?4YBWZZrJJL3G//4TH7hmTiGgzh29+DCK4U/3bkWT0Se4SHvd+0CzpcyTzk?=
 =?iso-8859-1?Q?BgPin0fvvxbTElBphlFb29e3jEen5EnKIMe7iClLtymHmXPW7nGZY+oeh4?=
 =?iso-8859-1?Q?lXMfyRFMZNyy/3u2CtkGJMvBrtxzn1sXFzhk3KBdr/Cf5fZfDHLqu7dSY+?=
 =?iso-8859-1?Q?bYJYOszGu6zU9tCYDnnVLQL9GX8enrwTvKNxa3e8JKlMMpFRYoJZ1q+rR4?=
 =?iso-8859-1?Q?nuV3c+i0a43k75O+0UAM3mJh1itUGOa3tphRSAJQT5ashdk8J2oBIeFVBl?=
 =?iso-8859-1?Q?ZKBQtqxaoljNEXNkHK+Xj/xRPBIEWtGNxEjMrRk1YlKq6R0txE/LMgK4Kt?=
 =?iso-8859-1?Q?4PZskuZDeithEPJY3KQXDxpa14ejPUTmv2GZ/6ZxbdE60h99dR3MlXtosQ?=
 =?iso-8859-1?Q?hJNQymf/+1X366UGc+ycSYNo2ntNa/nkXgcr/7n5I851/MPxa+GTJu8alt?=
 =?iso-8859-1?Q?OSv++UAC93OJ6JtrmYS+i8T4CvnZJsxAWfL58PGPkGmscDJLeySxsmVVeb?=
 =?iso-8859-1?Q?FKJ34FwqhFKn28o6jfabiWlNcsv2l6D+UBt5Dm43Kml+Q0wiFGxuiGNMI8?=
 =?iso-8859-1?Q?1Hb2bFe5CqLwHBIdsAsmaS6hFoFdVmahwKk13y4Hfv4OXVdSseAqdHs9WV?=
 =?iso-8859-1?Q?teYp2P7Rl4Ln+ArlFwcAJsjgvy9LC03hY+3cdXRJlqyVf7Y0xw5IDCdHeC?=
 =?iso-8859-1?Q?/ChesRIqpBfnm3b/ZAZueCccqFySq64DJcjIEy5ipDaDBJG9OacN/i5VA2?=
 =?iso-8859-1?Q?4AsxEgjKKfe7guDrQtJeNHgW1FpYCGa+DsnXpZQKt1wcn2HGDJxpBRZmiJ?=
 =?iso-8859-1?Q?7pIceYHqBoRYVAZfbiv1qyVPvCp6gKBL9m3jlVFQmICIVNV+qE4Ru1k/eK?=
 =?iso-8859-1?Q?Txj++BNz3ze59gZvUA6R4xY4rpVgdWZkHkKdHUr8v/ZPIZhKE5O+E9NONA?=
 =?iso-8859-1?Q?i3axFn1DHUGiY9N+/cm+KOOIwEZtI4KQ9WO5z+ySn5VuOvw1+yn3WF6Y1a?=
 =?iso-8859-1?Q?iitYIxxbSj4dMcZEnX9nbiDWAU2DfxpQLwYn3edSI7grncGM6JLqPdeVqH?=
 =?iso-8859-1?Q?dQrOwEyieB1HcoCBxx3Ttx87K4ZlKjb7fOUaa9ZALOutGxPbTncW8gDEoT?=
 =?iso-8859-1?Q?8a5J1OTtdUKnAf/ivw+WGmF7ReEOKTIFb4fl9rznocmRFA4RiwgwlZNbzt?=
 =?iso-8859-1?Q?ckBNMTjKwZLYfELI+rYUJkCePuUbtbZzRYm9Ex0BOPKRWT0dEAv8xX4L/c?=
 =?iso-8859-1?Q?m0qDlLDTm+rkgQ+CUzpEH/SYF2cSn+t9/3vzm5n/TRWX44fUsnbjMyyAfW?=
 =?iso-8859-1?Q?G7A3smbuTxT/Gg0eNdt+HVLZKklRLoXLYJpPQWbG+yWCTBlC1qNNT7yqh2?=
 =?iso-8859-1?Q?iiRfnuj8iBURnuQnpB2hjhqv+U8q1Ikqf/luOG9YrR4yFVVL0O5PGzDYYf?=
 =?iso-8859-1?Q?3X0GWGOUUbWsPb8RemsDF6oKDcM6ZIst5neMIDufG0BTdO0KZSXOcg9L7v?=
 =?iso-8859-1?Q?pOZE8bT3CL+NYm2zlDV7QCBErfAxfBb2K2aC7P7OILyYR2xfqenRyejOzW?=
 =?iso-8859-1?Q?aQMK1BkNOMKwgvliANhS7kaAgv0p9pzYEK2Sj7QlcZ3khUcB0FvRogRbXa?=
 =?iso-8859-1?Q?MzxsTs5z1spP6KBfuJHyA3LfssZ6HeQ=3D?=
X-Exchange-RoutingPolicyChecked: nDGDPs9GoA+14f5A9N/ewLE06G2G8AplFMN3u2yWqQFnTjBXS6HVJk6YPGFO0HZQA4jPjz2x6oy8EMWTtVQLAv19WgoQvde4rLALJLkB+qjm08UjAPv04Jjn9JYnSR4JziCUJyCux+4FQHrnWyzxsGYBoVtbnmRrobhcGCUWqR2SKH/RuGUVgRtHg9ShHENbuKbtaUh3iUp2mcN6AKu5q7jg97B0vTe8lHttBXqJYwcUE58gNTmHfDtDaAy53Wst6WZLyWtxNnyN+eUaoucTlyYc6jkf/jBjlfNuhYJWcQqTWa05B2jginL4hBrcdBTcAp4/EIQwYz160CcP+3XmyA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 64db7ef0-415d-4bce-beee-08df4a40e064
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 15:37:41.5647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMHzb5O1DNazerQkDJLlQAWwpxCgr1Cs5oPiwqnIA9KYI932vFXRMvYNWySrixzoU37szhO+EfvAgtzigwhO2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR11MB075082
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

On Fri, Nov 06, 2026 at 09:12:46PM -0800, Niranjana Vishwanathapura wrote:
> On Fri, Jul 10, 2026 at 07:56:04PM -0700, Matthew Brost wrote:
> > Teach xe_bo_move() to service a defrag move, where TTM reallocates a
> > BO's backing at the device's beneficial order and hands the old, still
> > populated tt to the move via the BO's defrag_old_tt.
> > 
> > A defrag move always has existing contents to copy, so force
> > move_lacks_source false and fall through the XE_PL_TT -> XE_PL_TT no-op
> > shortcut so the copy path runs. The relocation is performed entirely on
> > the GPU via xe_migrate_copy_defrag(), reading the old pages from the
> > stashed tt's sg table and writing the freshly reallocated backing.
> > 
> > Both copy passes run in order on the same migrate queue and are captured
> > by the returned fence, so the teardown is pipelined via
> > ttm_bo_move_accel_cleanup(): the old tt is handed to a ghost object and
> > only unpopulated and freed once the fence signals, so the move need not
> > block. The VF CCS attach/detach handling is extended to treat a defrag
> > move (ctx->defrag) like the XE_PL_SYSTEM <-> XE_PL_TT transitions it
> > mirrors.
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
> > drivers/gpu/drm/xe/xe_bo.c | 24 ++++++++++++++++++++----
> > 1 file changed, 20 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> > index 02395968d613..bdcc9bed5d36 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -1170,6 +1170,13 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> > 	move_lacks_source = !old_mem || (handle_system_ccs ? (!bo->ccs_cleared) :
> > 					 (!mem_type_is_vram(old_mem_type) && !tt_has_data));
> > 
> > +	/*
> > +	 * A defrag move always copies the existing contents from the stashed
> > +	 * old tt into the freshly (re)allocated backing.
> > +	 */
> > +	if (ttm_bo->defrag_old_tt)
> > +		move_lacks_source = false;
> > +
> > 	needs_clear = (ttm && ttm->page_flags & TTM_TT_FLAG_ZERO_ALLOC) ||
> > 		(!ttm && ttm_bo->type == ttm_bo_type_device);
> > 
> > @@ -1206,9 +1213,12 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> > 	/*
> > 	 * Failed multi-hop where the old_mem is still marked as
> > 	 * TTM_PL_FLAG_TEMPORARY, should just be a dummy move.
> > +	 *
> > +	 * For a defrag move the old and new tt differ, so fallthrough to the
> > +	 * copy path instead of treating it as a no-op.
> > 	 */
> > 	if (old_mem_type == XE_PL_TT &&
> > -	    new_mem->mem_type == XE_PL_TT) {
> > +	    new_mem->mem_type == XE_PL_TT && !ttm_bo->defrag_old_tt) {
> > 		ttm_bo_move_null(ttm_bo, new_mem);
> > 		goto out;
> > 	}
> > @@ -1279,6 +1289,12 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> > 			flags |= XE_MIGRATE_CLEAR_FLAG_CCS_DATA;
> > 
> > 		fence = xe_migrate_clear(migrate, bo, new_mem, flags);
> > +	} else if (ttm_bo->defrag_old_tt) {
> > +		struct xe_ttm_tt *old_xe_tt =
> > +			container_of(ttm_bo->defrag_old_tt, struct xe_ttm_tt, ttm);
> > +
> > +		fence = xe_migrate_copy_defrag(migrate, bo, old_mem, new_mem,
> > +					       old_xe_tt->sg, handle_system_ccs);
> > 	} else {
> > 		fence = xe_migrate_copy(migrate, bo, bo, old_mem, new_mem,
> > 					handle_system_ccs);
> > @@ -1315,13 +1331,13 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> > 	 * BBs from BO as it is no longer needed.
> > 	 */
> > 	if (IS_VF_CCS_READY(xe) && old_mem_type == XE_PL_TT &&
> > -	    new_mem->mem_type == XE_PL_SYSTEM)
> > +	    (new_mem->mem_type == XE_PL_SYSTEM || ctx->defrag))
> > 		xe_sriov_vf_ccs_detach_bo(bo);
> > 
> > 	if (IS_VF_CCS_READY(xe) &&
> > 	    ((move_lacks_source && new_mem->mem_type == XE_PL_TT) ||
> > -	     (old_mem_type == XE_PL_SYSTEM && new_mem->mem_type == XE_PL_TT)) &&
> > -	    handle_system_ccs)
> > +	     ((old_mem_type == XE_PL_SYSTEM || ctx->defrag) &&
> > +	      new_mem->mem_type == XE_PL_TT)) && handle_system_ccs)
> > 		ret = xe_sriov_vf_ccs_attach_bo(bo);
> 
> Assisted-by: LLM
> 
> Looks like code has changed in drm-tip and sriov_vf_ccs_attach/detach changes here
> needs to be rebased.
> 
> There are also some sashiko reported bugs around this sriov_vf_ccs_attach_bo which
> looks legitimate (like move() function returning earlier in error case while move
> is in progress).
> 

Yea, I believe I fixed VF CCS issues here:

https://patchwork.freedesktop.org/series/170380/

Matt

> Niranjana
> 
> > 
> > out:
> > -- 
> > 2.34.1
> > 
