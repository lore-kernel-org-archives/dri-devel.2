Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C8CCD4F5E
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 11:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DC8F10F2ED;
	Thu, 21 May 2026 11:00:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ciLZjTG4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A9C010E37C;
 Thu, 21 May 2026 11:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779361243; x=1810897243;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cTm7mYY29LnI8Xz7uhyFwyYtmSzW7AKyRnkKZBdtylk=;
 b=ciLZjTG47evOoMQ4TXHRArl+EqONx8Zcge0goPu3G0o3RwvlcgmfF6i9
 iuSIzKD3mzlm4qvAytskpbZChdkrCfNCN3O+sfaamxRYZjy9CQmnueUPg
 o55VtzB906X/Tor18wQ6+7+TkRwa9n9eEa8XdoBj47H5vTPp/NFu4djfS
 /RgfY1QXj9KjSix30BkjXH6o9Ts67O7lUiKUiFOsJU1kYwf0WuNq/Ecil
 oqo3otYROC2Ea5ehEZY97CR29lIa83w8IQmFbKtIKTWcjMXoOPSWCcoeF
 CYVIio5SV1l4rcxlsYRpFnkIk0H20Neg9oDxiudwZUUBwTEgT5XOQ4hFp g==;
X-CSE-ConnectionGUID: OmJUdttvSKCWeGZLiYVxrw==
X-CSE-MsgGUID: QuoXsdVOSmuKALuGlIxnaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="83894859"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; d="scan'208";a="83894859"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 04:00:42 -0700
X-CSE-ConnectionGUID: XJbZ6/W7R8q4CjaLrfXUmw==
X-CSE-MsgGUID: s9OxaWjEToqwdIyMXOerJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; d="scan'208";a="264303414"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 04:00:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 04:00:41 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 04:00:41 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 04:00:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcOmiGaDTK5V/1O2bz2d+ONo+yTqF/1LLeUhIhoLmu8n/lI4nueqURIKiuty1l8b/R7yKV8dZ+hLocPL78EsztYoDez9XswISq4QH8B311mUSop7ESr3sd69Diod0gI9QOqhg9h3dIxVD1a2CA4DHmiLp/EiyVzhbTVHD02gSJOa3lt7owHfZdxS97QvJ47+s7hXA4ZDKtIZhtAHLhJq6Y/ylzOCAgLIt1KKoIhsYGnbTLozdslEzde3LLceEZKMUd9Uk7qjagUis9QpxWMEvkdxbgmsvTD58c1CIcG+6BEw7OxDPO0yJGkrm3LF+n4Z988+9w1T0gg0uue9DBodpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7W3gdQDx++oywrwS9YQYM09yvz0Aye4z928LonlJcl8=;
 b=iJOPK+IDOHiTvY9YOTYVky1FgHkIsjtTescPeXtZCG9JnP+AedUuv11vnXG7fQ4IQf4DmfBLHkUXRO6RO8BKj2ejLwd0ersl40pZaixSdIns0Ru3hNtXDiWPb32o1MRqrzgOpIrqXJeFisw/aT5Z9L4VqLTSkqq+KIENe3zThQ2ceU0pZMHmmR3E44hMTgyuiGERvVwPKFoyJYFinAWDpCoNy6va+p6tvAuOwQVJe/HVPH2Qnz0NuyaxQubVv7pUSCB052cWZixqloF/w9bcWdoKZWnWTpE8qRCop5g5FLSBKYSffATNB50iJ56Mg7HcLixmvC9KYQZPVIuJmHdE8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by DM4PR11MB6214.namprd11.prod.outlook.com (2603:10b6:8:ac::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.17; Thu, 21 May 2026 11:00:34 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::45f:5907:efdb:cb5b]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::45f:5907:efdb:cb5b%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 11:00:31 +0000
Message-ID: <5caac879-5063-4999-941f-d062da040879@intel.com>
Date: Thu, 21 May 2026 16:30:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] drm/atomic: reject colorop update from inactive
 color pipeline
To: Melissa Wen <mwen@igalia.com>, <airlied@gmail.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <harry.wentland@amd.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <simona@ffwll.ch>, <siqueira@igalia.com>,
 <sunpeng.li@amd.com>, <tzimmermann@suse.de>
CC: Alex Hung <alex.hung@amd.com>, Simon Ser <contact@emersion.fr>, "Uma
 Shankar" <uma.shankar@intel.com>, Xaver Hugl <xaver.hugl@kde.org>, "Pekka
 Paalanen" <pekka.paalanen@collabora.com>, Louis Chauvet
 <louis.chauvet@bootlin.com>, Matthew Schwartz <matthew.schwartz@linux.dev>,
 <amd-gfx@lists.freedesktop.org>, <kernel-dev@igalia.com>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, "Abhinav
 Kumar" <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 "Sean Paul" <sean@poorly.run>, Marijn Suijten
 <marijn.suijten@somainline.org>, <linux-arm-msm@vger.kernel.org>,
 <freedreno@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
References: <20260519211111.228303-1-mwen@igalia.com>
 <20260519211111.228303-3-mwen@igalia.com>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <20260519211111.228303-3-mwen@igalia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0106.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::17) To SJ1PR11MB6129.namprd11.prod.outlook.com
 (2603:10b6:a03:488::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6129:EE_|DM4PR11MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: d053b4b9-0d11-4f06-cc17-08deb7282d18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003|7136999003|921020|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: NNFDkPIWxy/fWXMzALzE/iiHMXfdTSMk/kJo+y3v0uyCoU/YuYO2mjoJV3mVbMGt56Rp/p9n0HOUIDqzwNuv561r2DedyQ2ll6pKtgBJAl63lJLW3h/8c8WakhOC5HwcuCxNPISSmfUVcl/4HCmJlhSEsL4767cFvKI1hsC2+pH20hu6X9STmRri3DWbbDvLfEycZb6E9joewDyvdSei/d7xUZYT59HXZeADdQOAdZM7vzyB9MGGa3G47BoYOv6XLKBV4fJHUxXjDw/X5JdmkLjYnhj9I4ao4r/Nz0ViX0JAtCnycUNzkZcaUrnHgdU3lQP7pLa4x8o0GsQ8zQO1IODSsdviQ62/fRH+YqoLql6d4RSE+MEkvP3+9W7udAQIAfyueCe2NkiJBYf1uawvztmo5EIFTALZ6soQKwDjmZXYaMS9EzP3cVHOwjUQjxaWVGPgL/Yce6cxA6QUyj9wLh9T57YOVjIaGXi7fspCVkHiKuQ9gfuVTeseD7R+HJyCHCaqSOQpjjKKs455nnYCNzqoxvz6aSwKwdgIGjkic/0+TvQFQSrVCb1PDYUAsCk1SMa2/8iCD2vIJb5yxBUF/6oaadG0EFwoHIus9jR5tLrSCMESxguyIBCbfD3hDEyOCMY/U2Pbx8UkcLaaspEnOIJlb+0iF1HaBOAmO7eHVpInUO35jxEVl+lGlZoSzMQa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR11MB6129.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003)(7136999003)(921020)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUM3QWVSRXFPbXVwR0x4UW4wb2UyTmhnY0NieHd4RkY5RTlMalllR3ZUelVu?=
 =?utf-8?B?aUNlTm44ckRCMCtEaVVTWmphQlprS0JHcDkyeFUxYXBxeHBLNzVwRmh5ZWZU?=
 =?utf-8?B?bnprYTZLQmRwZjRqR05kRnVFWUxQZ3QrV0p3cU5ZMVVseDR6a1hScEhZVk9W?=
 =?utf-8?B?a3FSbFJnZnJaUHppWnhDK3dDcG5iR041STNqT0FEaHpsQ3VHT1p3dEJUWm0x?=
 =?utf-8?B?aTZINDN6bHBicUUxc0tjZFZrYjZ6Wlpsb0F0Rzd6UnNzT29VbS9OMGc2YWpo?=
 =?utf-8?B?d3pxNmZBUVNNaVZYM0dCaWNRYkpvRGl2WFZlMDYzMEprRjJmdTVxdU0yRlg4?=
 =?utf-8?B?YkFVMERVN0lqNFZremxFQ3pNaFlnM3RlK0xWWStoUDZTWmVrSkJSanduUnVy?=
 =?utf-8?B?Q3R2ZnR0Y1dsTVhQVGRhMVhMYTdzbFhXQ2hJcXdPZndld3dGbDdrOWF2aW9N?=
 =?utf-8?B?bEJDNEQ4cGFqU0tTZE9TSWhiaG04Yys3aG1RSUsrZkphMmhIWktObndvR0FW?=
 =?utf-8?B?S2ZabVFsZEZvKzRCemg1VDg0eFRZRnFGbU1Mc1dKa29Gd3N6b3dRSjJQM2cr?=
 =?utf-8?B?OUl0WmpkOHpWUGFlSXdMU25PS0h3ZXFoWWpGWmJsYmx4Z1hENWJiUlUxRjFE?=
 =?utf-8?B?NXhrbGNSVGNmSXlhRTdIdDJyNlRObFhicE00YkpaNDhmWk5BaUovc1VMVTFT?=
 =?utf-8?B?MDZkRTdXQVF5WHJvVUM5bG9QWmpVKy9BRjd0WDVMRUZROWdNaFdUVDlPYld2?=
 =?utf-8?B?NkRseFhuS0JWOHJpeVBDNllUVy92VlNORTJ6ZWNkdTZPQTljSDlxRFpaZWxn?=
 =?utf-8?B?UDNkV25TY25ldFlFeGRWb01hYVhnWVBXT0gzRVdOYjF5WHIwc0tlOEc5UlZX?=
 =?utf-8?B?WFhOR3BpT2JUUXpZaU9YRlBYUnhCNHNmYUkxTEkwZ3BJbXB3anZoUEVwMUkv?=
 =?utf-8?B?cWdzUjgzTHl2bzVGMGVVTmZ1QjltTlZyUXdmMkFJWWtnNU4yeCtsempZcXFJ?=
 =?utf-8?B?SEZaWHVjRHEwT2JMZC9HUmpLMGcyL0VTMFNOUjB6SFhvOTltU2kyYjc4S3Az?=
 =?utf-8?B?K3VvYytzN013T3BEd2xqOWVGMmFMQ0M1RzZBbm1kTUhVdXRmVDR4RW4vblhk?=
 =?utf-8?B?WjRGRWxCblVVQWdOYUhLRVcrYXdBTWhrbUY4ZDZsTXhXMFVrMzc1NE1Ldk5E?=
 =?utf-8?B?cHRBU2RRNUNLbHJnT1F6N09pTmRKQ3BoUm5raEpIVWYzNGp1S0x0dFQ0aEov?=
 =?utf-8?B?Lzh3Rjkzbmd5MzlFUTRpQi9jVmd3SHpJL3hIejJIb0daRkErL0NMOEppdjla?=
 =?utf-8?B?VWcrV0RudzUvU2xwN0pnNEo2emhwdUFQM3R5RlRqK0FmN2xBdkJ4YU83Yk5X?=
 =?utf-8?B?aWh3dFdyN0pOUkZOQ2FCU2FydjdOWjJJYVR6bzJnTlY1SFNDNG9CNWp6eWsr?=
 =?utf-8?B?MndaOGlMNHNTTDZrNVh4SGVPWndqbTBsdFY4QUF2M2VKUXhMdWN4RmduZWV2?=
 =?utf-8?B?RDhmbzhvd1plclhtZlg4YUFzNVM4bE5WMHhKY3Z6c09wNzFJOVhPeFVvbjNK?=
 =?utf-8?B?VVNQM3c4M0UzRjhCVFpCTVZGTDVuWFBxSGk0YjIrV2Q2K05oaHQ3RXpJSUEy?=
 =?utf-8?B?SFdrb3Q5Yys3TEtOZFUwY1g1VGJoQTIrMjBUdjVBbWYrMWRjRStIemJVSTFm?=
 =?utf-8?B?QThYcDkxTWtKU2F6WERQR1doaDJnWW1rOENKZkhQOEhWYXB3Uzl2Z3ErTzdl?=
 =?utf-8?B?OWZJRG1IK1lhQ3JDZ3FBMHZYMDR4d0d5bnUzbUdNVm5nUnhzSWY5blZpRndS?=
 =?utf-8?B?d1hLTG00NmpPdy93WjBvNDNJSGNYUklPbWtIQnl6SmNxMjNpNm8wb2pwa0dP?=
 =?utf-8?B?d2JkTzNaUFdETXErS2FGdHI5akwxQ1JTTGJFeGxDakFGR2dOQUIya1l6Yll0?=
 =?utf-8?B?REo3MDYwdFJLcmw5c2FJR3VJVENyM1p6eGxxdlZzcjVKYk9ialB0ZHFkcGFE?=
 =?utf-8?B?b29QbzBPK1p5WUZoK2ZBcHVlK3liL291WERwOUZpSmpvMjVQVVB1MWtSTXk2?=
 =?utf-8?B?S2xSQ3l0eEovakFPdXJnNktVeHBMZVNaTjlma2phYUpCRklLc2JDQktoUWpT?=
 =?utf-8?B?Zk5NL1k0MG1meWxsY25Td2JvS1hBaHRpbjNhRTRqZDBtNzV1Tk1BTStWUXZl?=
 =?utf-8?B?QWd3OStzRjNsVTNwajlnbEJ5MGN6dndkUFMrVmY4alhhVVVrTERobWJ6bXE3?=
 =?utf-8?B?SE5pajlabThweGRVckl5ZnJUMGhsMGJiMkJEKzRKRHZ2eXBKSzgxdXBMWnp6?=
 =?utf-8?B?K2p5eS9lMktJKzNRc2NpL05iMUl6cGZMTjgxQ3EwZG9rUk1ReTE0L0JaVVpB?=
 =?utf-8?Q?/anb1HGtLfsZi3n8=3D?=
X-Exchange-RoutingPolicyChecked: Sxl3MLJdO7v6pEyThRlvlXh2krdmDCgtXWFVtu9MM78RDOJHTcURclvSlwzz9kHTtD2GSVDvD6+qltIcgu8yl9jC08Nj63GIFhMtnXuX5WXI+SRjEk1/2va8vgVTCv/U2gtvAfLtbd+RFpv+6eP/PwnUWvsPgA6kWqX6y2W5SwA/u4n4qFwOUTBvZP3N4x5HlmOCSevkvChzFWGv6SaJ6f3U+mpota6AqMrGyrn6PLmSfJEbODsYCkZ0UIjnQ7+Zqo9VdX8VzAlielyRx2Vq0H+/X9+i2Czl0wXTqiJSG1Kyx52SWNE8J+zbnoA2+tE32IGleY5hTPqYHYltzWyZeg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d053b4b9-0d11-4f06-cc17-08deb7282d18
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 11:00:31.8092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsV5GRcIk1pFjxnqyFirEW372Xl8u1xTsSPctWgbsSFu4mOkwjSLlx2VD+W0CPw3Q4k1/rzNdpJWW+rd39UcP/amkH4hPTS/TfOzHtlq29E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6214
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



On 5/20/2026 2:39 AM, Melissa Wen wrote:
> Only allow updates on colorops that are part of an active pipeline.
> Check if a colorop in a new state belongs to a color pipeline which was
> set as a plane color_pipeline property and therefore is an active color
> pipeline. If not, reject the atomic state. Performing this check later
> in drm_atomic_check_only() to remove the ordering dependency that would
> exist if done at the time of colorop property setting.
> 
> Suggested-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   drivers/gpu/drm/drm_atomic.c | 38 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 28831a548b0c..659cf56150e5 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -812,6 +812,33 @@ static int drm_atomic_plane_check(const struct drm_plane_state *old_plane_state,
>   	return 0;
>   }
>   
> +/**
> + * drm_atomic_colorop_check - check new colorop state
> + * @new_colorop_state: new colorop state to check
> + *
> + * Ensure that the colorop in @new_colorop_state belongs to an active color
> + * pipeline, i.e. it's in the chain of colorops set to the color_pipeline
> + * property of a plane state.
> + *
> + * Returns: 0 on success, -EINVAL otherwise.
> + */
> +static int drm_atomic_colorop_check(const struct drm_colorop_state *new_colorop_state)
> +{
> +	struct drm_colorop *colorop, *color_pipeline;
> +	struct drm_plane_state *new_plane_state;
> +
> +	new_plane_state = drm_atomic_get_new_plane_state(new_colorop_state->state,
> +							 new_colorop_state->colorop->plane);
> +	color_pipeline = new_plane_state ? new_plane_state->color_pipeline :
> +			 new_colorop_state->colorop->plane->state->color_pipeline;
> +
> +	for (colorop = color_pipeline; colorop; colorop = colorop->next)
> +		if (colorop == new_colorop_state->colorop)
> +			return 0;
> +
> +	return -EINVAL;
> +}
> +

This causes regression in our CI[1].

I looked into it and looks like the following sequence in 
igt@kms_color_pipeline causes the error

         set_color_pipeline_bypass(plane);
         reset_colorops(colorops);
         igt_plane_set_fb(plane, NULL);
         igt_display_commit_atomic(&data->display, 0, NULL);

So this change restricts bypassing/disabling both the pipeline and a 
colorop within it in a single commit.

Also Sashiko had the following to say

"Furthermore, does this unnecessarily restrict UAPI by preventing userspace
from configuring inactive pipelines before enabling them, or from resetting
properties on a pipeline in the same commit that switches away from it?"

So this will also fail a commit which tries to change a pipeline and 
disable the colorops in an old pipeline.

That got me thinking whether the first patch[3] in the series is also 
correct, since it is quite similar to the change[4] I added, where 
colorops are only added to the state when a pipeline is active. In both 
cases, we could end up ignoring colorops that are not part of the 
currently selected pipeline.

[1] 
https://intel-gfx-ci.01.org/tree/intel-xe/xe-pw-166922v1/shard-lnl-5/igt@kms_color_pipeline@plane-ctm3x4@pipe-a-plane-2.html
[2] 
https://sashiko.dev/#/patchset/20260520073827.3395745-3-chaitanya.kumar.borah%40intel.com
[3] 
https://lore.kernel.org/dri-devel/20260519211111.228303-2-mwen@igalia.com/
[4] 
https://lore.kernel.org/dri-devel/148df44d-2456-40e3-8be6-f98b89b7ee4d@amd.com/

P.S. Can you please send the next version to intel-gfx and intel-xe too?

==
Chaitanya
>   static void drm_atomic_colorop_print_state(struct drm_printer *p,
>   					   const struct drm_colorop_state *state)
>   {
> @@ -1665,6 +1692,8 @@ int drm_atomic_check_only(struct drm_atomic_commit *state)
>   	struct drm_plane *plane;
>   	struct drm_plane_state *old_plane_state;
>   	struct drm_plane_state *new_plane_state;
> +	struct drm_colorop *colorop;
> +	struct drm_colorop_state *new_colorop_state;
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state;
>   	struct drm_crtc_state *new_crtc_state;
> @@ -1681,6 +1710,15 @@ int drm_atomic_check_only(struct drm_atomic_commit *state)
>   			requested_crtc |= drm_crtc_mask(crtc);
>   	}
>   
> +	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
> +		ret = drm_atomic_colorop_check(new_colorop_state);
> +		if (ret) {
> +			drm_dbg_atomic(dev, "[COLOROP:%d:%d] is not part of an active color pipeline.\n",
> +				       colorop->base.id, colorop->type);
> +			return ret;
> +		}
> +	}
> +
>   	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
>   		ret = drm_atomic_plane_check(old_plane_state, new_plane_state);
>   		if (ret) {

