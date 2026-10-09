Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C99CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 16:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A28410EA76;
	Fri,  9 Oct 2026 16:47:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NraUPIFf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F5B910EA76;
 Fri,  9 Oct 2026 16:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791564459; x=1823100459;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=zn9uwRXfOJUduMTI6jPZLW7hN7FLMw55P0jLzb5Vhgc=;
 b=NraUPIFfuSKxLfNBsJiN0OFIvDdNSGVA44ip6lNmnRfm1wvd8iOf7CoQ
 mUg95kXz3iV61V09p2vCcigYx8TG7K07OSix8Uks8JGLFs4GJBZqIHMqJ
 ni3A1eoecxxhgdDrWfS62BVpXzp5cpE3G6Du0FENqTbT4bXUW0mW+FSSF
 S8+knkIfgjOU6cXVvIn0RZILO+p0ttLRQIw1XFP8+OzlSrR+qdW8OtH/X
 BYizS1i9Z37jF3YikDLYOgGo8EYt0ZfMpFNQ1y4Mb2ny38zZRi8fBvy7F
 UeBYtlyJUx36xJdcIPO0fpXQXEk970q2I3LAqwh+vLVypi24bsrKyu+8L Q==;
X-CSE-ConnectionGUID: AvZinre1TRawlK/s0BR8sQ==
X-CSE-MsgGUID: VBAsGjybQAez4g9ytstZvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="247711"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="247711"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 09:47:38 -0700
X-CSE-ConnectionGUID: PfaakpxTRjehAlePQLb8hQ==
X-CSE-MsgGUID: 26cm5r2cSpS4Jp10bhmB4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="683518"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 09:47:39 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 09:47:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 09:47:37 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.45) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 09:47:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbUKL6pmUJr8tEItIvywHLchS94H0XDidvDSV5nKIahuNiTYUhJvQi3ExojOZFpe9Lk7V0v2ohthk1tCsMK+hr2YJqp/fRlZ3i30wTFDdS4+DgjJ/M2wFc4xVFnxshCexHcSEqrJql7CffgjFCXcnL2E0k7xJmZohiK9GHZxzcrgrQ7CvEAPsqGoExWoQ5vpAv3LlAyvwXwaao1/ObDO673ruU4xQyduWIhVjjau983RJ0OzHVxZjNYtgqxhA2CetMD5YpZrET0BR5m9fDLxu3HRDcwewUohikejV2piGPMbFPl80KN5NM0IfiaBN4d/nsYDMDWqbROCvbHp2p5aMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeLBLGIziWiESiMjpoe+gLWUELMre2tgjikV+eZs3Is=;
 b=PhMShVIxlhd4dEhqMuFSqsYl4bkHy+apoxzP6lmMD5+w52sbOnRgViSQOwWZlK9E1K+5O52NY3jZ/XjVPdHBTGXBwqa7LeTp6BTOwkTAHbsag16U+5PLMRUDVfXX8ytWyJULDHr3TlPy81hMeNCiARU56pj+MxjZOzmmbXqwpx2cFbsmN2N3mtlXGDV5O65q/nTzTYm8EPGoaQx7u3sYnhi0BhMGJgBTfRuH059i/p3G9mLAqoXvA6NFxphv/l+qFX7YNygn8Y2zyNu4DMWMMU/XlmgrIZL8tYYMXt3xyvhTjARDV4fFE/yjvovih/SIcV4SG8p21VWgU03ot7DjPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6974.namprd11.prod.outlook.com (2603:10b6:510:225::16)
 by PH7PR11MB5981.namprd11.prod.outlook.com (2603:10b6:510:1e0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Fri, 9 Oct
 2026 16:47:29 +0000
Received: from PH8PR11MB6974.namprd11.prod.outlook.com
 ([fe80::44a4:1ecf:f303:d08f]) by PH8PR11MB6974.namprd11.prod.outlook.com
 ([fe80::44a4:1ecf:f303:d08f%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 16:47:25 +0000
Date: Fri, 9 Oct 2026 22:17:15 +0530
From: "Vivekanandan, Balasubramani" <balasubramani.vivekanandan@intel.com>
To: Raag Jadav <raag.jadav@intel.com>, Bartosz Golaszewski
 <bartosz.golaszewski@oss.qualcomm.com>
CC: Matthew Brost <matthew.brost@intel.com>, Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <brgl@kernel.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Heikki
 Krogerus" <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] drm/xe/i2c: use device_create_managed_software_node()
Message-ID: <askak_ee4PPH0N8Q@bvivekan-mobl1>
References: <20260922-xe-i2c-reapply-swnode-unreg-v1-1-1bdda5d44701@oss.qualcomm.com>
 <asiNCndYPAlM1p5u@black.igk.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <asiNCndYPAlM1p5u@black.igk.intel.com>
X-ClientProxiedBy: MA5P287CA0361.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::7) To PH8PR11MB6974.namprd11.prod.outlook.com
 (2603:10b6:510:225::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6974:EE_|PH7PR11MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a5e425-87d4-4f42-c3b3-08df2624fee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|260925022911599003|260925021311599003|260925021911599003|56012099006|10067099003|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: meV2ZGognjWsxGIP2fUxq+wYvuTF2Z/CfREJv4zcrgAicRu6YgBHrBtNqMAwrP9D9UCRQlaspLXRvssps7qAl0LqXccssWgheVQiBlyLNjmfxu1hyJ+fAuRxIAkN9K+ScU36S+7Aae1fHlRCjrWU+GvOQyQ8zRTnqmBY0TFI2VybMg552MwX/usSlpR05go7MZzVon5SJcNm9OznPxPpTDpQgNG2xn2f7lua4VFdAvxnlQLDcPHnHbOUQ3FhhLZmTQL0SRuyXpq6ZWrc1nu6hWPNfHaVl7Gw0QsS/wni+f7WY4EqRF27gMCEZOETWGwfBUZ9B38B271zZydpNEExpFgQutfxfRn82ZH9jO7c9s6D5eoJ2cwDOQQrOXrJj2KHO7k1n4ELNhns4v0wfr0XmwSmJ5ITcgAI9rE8f+u8OZhXuVnj6gQPJKu4JSOkpDmEon4VugcmkAr3VAlbkkwWlE+HCc34c3Tq8RlirHulOZL3jBt0RnyssWHmNUiWw9L/tg3lMpNS3L2Uob24gmx9UUMr3yFnCF90LMWKBeFoO+AShwrxLoGDASKvIvub7hGu/TJjkODZa1ODTInuOFTZHAwkjJete104UiN9W2i0yqp33zKITH8on0UQbjB69VMv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnFkNWdxbkFlNTM4RHhmMk11KzFZUUhGLzkxTHRhczEvNjZIUFR3TkI4ZXRz?=
 =?utf-8?B?SjBBNVB6M2FEeUJ2NVZoNGlJcklBbkJIa1k3bmFHNFZ1NE5uRlFKYm5XMXZj?=
 =?utf-8?B?TkhJRWFQVGpjaVMyaWkxOGIwMUlYRE1WUnZhaWdyZDBVMCtyZjE4MnVPUTY5?=
 =?utf-8?B?OWVHYk1lUkl0Z1BQZllNY283ZzlPUDczUXJMbTlLcjJHU2x2WFpweHVBOVlV?=
 =?utf-8?B?QVJMT3F4S2h3TCtrQVZHekx2N3VHN1ViYkV4RW5jUlQ5T0RaUFJNR21HbWlW?=
 =?utf-8?B?WnJuY1F0MW9KTWpqM2dXWnBNQTN5UHNBOFBURHJoUVM2Y2xTNmt6RUdDTVc3?=
 =?utf-8?B?Q0VwUFlXdnhhaEgzVk9JVGV2SjlCQ0pibjdyNDJIV1VJYmlxWlRPWVNHSlE4?=
 =?utf-8?B?SGJLRkFxU2F3clpuK2h2K0d4UGVMeDBKVi9mVGl6RktVVU9qZ09EckxEMlMw?=
 =?utf-8?B?K3ByRUZub2xON2RORGs5SjBOR3BOTFFRdnoxejZOZUZqUEFtTEpBeitZNHFz?=
 =?utf-8?B?TFRXd1h2RVNTNlBocXV4d1kvcHdBeDQ1TWVZU0FJYldXZFV1amZzQXJ0cGZy?=
 =?utf-8?B?VzBIdklhaDYrKzZha0dNRkVNNXA1RnNiOGU1WmwzbE1GK0xLeG1xVXE3YlJp?=
 =?utf-8?B?WEVoZUt5MjRsNEh6YXdybmZHL2RSZXF3bVZqR3htVG1HcFByWUdKUlc2V2Jk?=
 =?utf-8?B?ZVU0YXF2U2JXYXM5d3Q1TitOSk1wVktkZHF5MTRnVVU5anJSLy9JWFo3WW5R?=
 =?utf-8?B?NXZCb3lPZjRMWmNHMDJqZExPVDN4WEdDYisrOCtJWDJ2UU9qeVpRUmZJQ1d0?=
 =?utf-8?B?OVQvb2ozRjA0TmhDbDh5T3dHRk1OazVwOVBZYkdlWkhEVVdJLzdJVFlDK0ht?=
 =?utf-8?B?VkN1ZkE4T0FEQThETHFFWDBjRjVDM2xCSW5YRVo3QWoxeEZ0d09UZ0dpMGp2?=
 =?utf-8?B?N3lON0Y4djRoeWNXQnZnSUtPMWR5MDN1ZTIrMGpIdjlyckdhUFFXZmplQkpB?=
 =?utf-8?B?aUZSeEE0YjJNa085VEVac0g3Y2psR01pbklVRktyOGFuZ29iYmJuR1ZlbVJE?=
 =?utf-8?B?a2srczNwd3NGcWpTcE5FVDkxTVN5eHlvcUFtay9EdWE5b2JQS0w5NWFjY3gz?=
 =?utf-8?B?NmR5bS81RytjKzJkRWtKQmVaZnU5cHVsRWtROUJja1dMK2ZXWlJlMXFWMzBn?=
 =?utf-8?B?ZDZIM1dNR3VUbmRvWTF0SjBZZHJhVHgxcHNWSWhTb3hjcmJuWG41dFh4cWd4?=
 =?utf-8?B?eEJqM0piVzZ5ZWZFdllxcVp2dHpwRDJJS2dTb3M0NzUrS1M5bXFHbnJaekR2?=
 =?utf-8?B?S2s1VEdzKytqTzhvNG5QcW5QYmNGeGljcnFQaWZWcGVGbTQzK1VaU3JHSTMv?=
 =?utf-8?B?cUFPa0oxMERIZnZMVGlVTGNsSW5qZ0pyNUtjNVJSTFROekNNQVNaMWY0c0hH?=
 =?utf-8?B?SlhFM01iZDYzcGZuVXp6S1lYZ21BaUpUMFhBdDBkTzkvTGtNK0trUmcvemkr?=
 =?utf-8?B?Zkp6dWphY2c0RkJVY2lDQ0RtMXJCdVFTdG1RdVI4eHVhYXZldEFvdHdTRlRN?=
 =?utf-8?B?b3NVb0ZvMjVpOVBOQ0xpSlRhaTdJMUp1dmNiNW8zeHFIUmxhRy9iU0psNHVl?=
 =?utf-8?B?V3djc1JMWGFZcEUwRG5HdDA3NGQxZTIxeHozNlJhN0RsTmV6VDBMWVAzNXNT?=
 =?utf-8?B?eHZRKzNabTByUzgyTEJyYm85OTZxM3NETGNDV1dOOGVPbk9KdDFveHRjNjlm?=
 =?utf-8?B?MU1JQmEvUm5BbUE1SmhFWHVobG9WNnBRYmF4N3o5TkVrTXJ4akZpbkxkY3Ri?=
 =?utf-8?B?VGYwaG5rRWRYT21WTUlXV3F1NjFOUW1TOHN1alAvdGhnQjlRK0JMUmNNejlw?=
 =?utf-8?B?TUc2enFBajl4WFJiWU0reFB1K1pJczRIZU5EYWo5K0tCRzVrV252VEh5RVBv?=
 =?utf-8?B?YzRFNVlCVHF6YmxBN3A4Ty9qN2FNdVpUUmkzWVJkOCtqaWtZTTlOTm5SbEtz?=
 =?utf-8?B?eWcxY1A5cHJJdVNOVE1nYm1pWnVwYzFUcXJFbmVFTC83aFR2bEV5TGJpS01o?=
 =?utf-8?B?MGhVR2JIT1o0dWFoOXUwdXVYdzVuSFZGSmdtNjBBRFJxb3RxUWMwTG5ZRVBr?=
 =?utf-8?B?cnA2aEtWdTA5TUJmaFR2TU9udG96VWoxS3JLdUdDMkx4UXl1bG5vSjBkYlRm?=
 =?utf-8?B?dFNpZkY1M0lUR3grYzB0WVRrdDg0TnBxTHljOWZxczdLc0VNaGg4ZnhOejFh?=
 =?utf-8?B?YVR2YUhhbEZIUnpGZE5INlFLQ0pNU2oxZzlMejFWbno0YlBIakV4VWZZOVFS?=
 =?utf-8?B?dWtrWVdaOW5vOTBYY0RabEtvOHFiQU1rQzZXQm9mYlh2V3hncUQvTm1sZXhO?=
 =?utf-8?Q?jTKtyX6bUiBozXDjbhyUU/J3u8LqnfCp74Zfy?=
X-Exchange-RoutingPolicyChecked: ozZozJmLqUcRkCsqRUgrlhT+d0iFNatrhIP5KHDMU7GvT5j54CnU/MDODQdbUdF0YA/wC4ESuy7/9N33zxkxAfAgfz74ixLUIr/mo7ZVmwxBruSSb39JLTso9f56ZL0oHtdi86zSSXkjfHm5HMjvwTGXDgwPhemH69Q7+yLaPNwxqcv1XyYTY9OtRqNspB23a4w1BNepnh53D8A1pPW2QCu59tJ1+20MCp/yVG77K774y7vS0+WWcbR7kIxs0AgLi67djZp+1SzDmiZ/IN7qLwkHSDs9TN0ipfmFMzpomEYQ/kFjezNf136K2KBs8KAgY8AmadRKKwUq2Ns6XoIjcg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a5e425-87d4-4f42-c3b3-08df2624fee1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 16:47:25.0812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OE/2vnT5HoarIkF3aDhzdvK+tVsO0VmY+m6sD5Y4qKSprDVrQA5rVlID6/wYyVKGwJM1gcUbqR8yi/lZEsKRdhIZUK14gtpYalNOL+3b463sJ+0QCzrlx0d2gjpjLrQv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5981
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

On 09.10.2026 08:43, Raag Jadav wrote:
> On Tue, Sep 22, 2026 at 04:25:55PM +0200, Bartosz Golaszewski wrote:
> > This driver intentionally uses the fine-grained approach to creating
> > platform devices. It assigns a software node as the primary firmware
> > node of the device it creates. Ahead of improving the reference counting
> > of platform device software nodes, switch to using
> > device_create_managed_software_node(). This way, we create a dynamic
> > software node whose life-time is tied to the device to which it's
> > assigned.
> > 
> > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > ---
> > This patch exists in mainline as commit fc90ce2d ("drm/xe/i2c: use
> > device_create_managed_software_node()") but the code got silently
> > overwritten by merge commit cc467969646b ("Merge drm/drm-next into
> > drm-xe-next"). It should be reapplied.
> 
> Seeing this on drm-xe-next during driver unbind.

Submitted a fix for it - https://lore.kernel.org/intel-xe/20261009164241.923756-2-balasubramani.vivekanandan@intel.com/#t

Regards,
Bala

> 
> [ 8042.309896] Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b73: 0000 [#1] SMP NOPTI
> [ 8042.316397] [Poison overwritten] 0xff110001b3a7e838-0xff110001b3a7e847 @offset=26680. First byte 0x6a instead of 0x6b
> [ 8042.316513] =============================================================================
> [ 8042.316534] BUG kmalloc-512 (Tainted: G S   U      E      ): Object corrupt
> [ 8042.316551] -----------------------------------------------------------------------------
> 
> [ 8042.316572] Allocated in swnode_register+0x35/0x260 age=42577 cpu=0 pid=381
> [ 8042.316598]  swnode_register+0x35/0x260
> [ 8042.316612]  fwnode_create_software_node+0xbe/0x180
> [ 8042.316628]  device_create_managed_software_node+0x82/0xf0
> [ 8042.316642]  xe_i2c_probe+0x1b8/0x260 [xe]
> [ 8042.316939]  xe_device_probe+0x617/0x1000 [xe]
> [ 8042.317109]  xe_pci_probe+0x539/0xb40 [xe]
> [ 8042.317310]  local_pci_probe+0x47/0xa0
> [ 8042.317322]  local_pci_probe_callback+0x1a/0x30
> [ 8042.317334]  process_one_work+0x2ad/0x880
> [ 8042.317347]  worker_thread+0x204/0x3e0
> [ 8042.317357]  kthread+0x113/0x150
> [ 8042.317367]  ret_from_fork+0x2dd/0x3c0
> [ 8042.317379]  ret_from_fork_asm+0x1a/0x30
> [ 8042.317391] Freed in software_node_release+0xa0/0x100 age=2 cpu=13 pid=6676
> [ 8042.317409]  kfree+0x227/0x4c0
> [ 8042.317418]  software_node_release+0xa0/0x100
> [ 8042.317429]  kobject_put+0x8c/0x220
> [ 8042.317440]  software_node_notify_remove+0xa5/0xe0
> [ 8042.317450]  device_del+0x17b/0x3b0
> [ 8042.317461]  platform_device_del.part.0+0x18/0x90
> [ 8042.317475]  platform_device_unregister+0x24/0x40
> [ 8042.317486]  xe_i2c_remove+0x84/0xa0 [xe]
> [ 8042.317720]  devm_action_release+0x1a/0x20
> [ 8042.317729]  release_nodes+0x3d/0x130
> [ 8042.317738]  devres_release_all+0x96/0xd0
> [ 8042.317749]  device_unbind_cleanup+0x2a/0xa0
> [ 8042.317763]  device_release_driver_internal+0x21e/0x260
> [ 8042.317775]  device_driver_detach+0x18/0x20
> [ 8042.317785]  unbind_store+0xa8/0xb0
> [ 8042.317794]  drv_attr_store+0x28/0x40
> [ 8042.317804] Slab 0xffd4000006ce9e00 objects=21 used=17 fp=0xff110001b3a7dc00 flags=0x17ffffc0000240(workingset|head|node=0|zone=2|lastcpupid=0x1fffff)
> [ 8042.317830] Object 0xff110001b3a7e800 @offset=26624 fp=0xff110001b3a7dc00
> 
> Raag
> 
> > ---
> >  drivers/gpu/drm/xe/xe_i2c.c | 22 ++++++++--------------
> >  drivers/gpu/drm/xe/xe_i2c.h |  1 -
> >  2 files changed, 8 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
> > index 51ca9fb73b708317c5dd8613d0ba060b8dc2028e..f4f3819882897f7f19a7bd3043a936e3c7eec553 100644
> > --- a/drivers/gpu/drm/xe/xe_i2c.c
> > +++ b/drivers/gpu/drm/xe/xe_i2c.c
> > @@ -111,14 +111,9 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
> >  {
> >  	struct pci_dev *pci = to_pci_dev(i2c->drm_dev);
> >  	struct platform_device *pdev;
> > -	struct fwnode_handle *fwnode;
> >  	int ret;
> >  	u32 id;
> >  
> > -	fwnode = fwnode_create_software_node(xe_i2c_adapter_properties, NULL);
> > -	if (IS_ERR(fwnode))
> > -		return PTR_ERR(fwnode);
> > -
> >  	id = (pci_domain_nr(pci->bus) << 16) | pci_dev_id(pci);
> >  
> >  	/*
> > @@ -128,14 +123,16 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
> >  	 * platform_device_register_full() is done.
> >  	 */
> >  	pdev = platform_device_alloc(adapter_name, id);
> > -	if (!pdev) {
> > -		ret = -ENOMEM;
> > -		goto err_fwnode_remove;
> > -	}
> > +	if (!pdev)
> > +		return -ENOMEM;
> > +
> > +	ret = device_create_managed_software_node(&pdev->dev,
> > +						  xe_i2c_adapter_properties,
> > +						  NULL);
> > +	if (ret)
> > +		goto err_pdev_put;
> >  
> >  	pdev->dev.parent = i2c->drm_dev;
> > -	pdev->dev.fwnode = fwnode;
> > -	i2c->adapter_node = fwnode;
> >  	i2c->pdev = pdev;
> >  
> >  	ret = platform_device_add(pdev);
> > @@ -146,8 +143,6 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
> >  
> >  err_pdev_put:
> >  	platform_device_put(pdev);
> > -err_fwnode_remove:
> > -	fwnode_remove_software_node(fwnode);
> >  
> >  	return ret;
> >  }
> > @@ -155,7 +150,6 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
> >  static void xe_i2c_unregister_adapter(struct xe_i2c *i2c)
> >  {
> >  	platform_device_unregister(i2c->pdev);
> > -	fwnode_remove_software_node(i2c->adapter_node);
> >  }
> >  
> >  /**
> > diff --git a/drivers/gpu/drm/xe/xe_i2c.h b/drivers/gpu/drm/xe/xe_i2c.h
> > index d63adacfefe71b3ae695987f104f978959a7e2c5..5969054a6b6b3f184857defd4ad3f6489f05aca0 100644
> > --- a/drivers/gpu/drm/xe/xe_i2c.h
> > +++ b/drivers/gpu/drm/xe/xe_i2c.h
> > @@ -33,7 +33,6 @@ struct xe_i2c_endpoint {
> >  };
> >  
> >  struct xe_i2c {
> > -	struct fwnode_handle *adapter_node;
> >  	struct platform_device *pdev;
> >  	struct i2c_adapter *adapter;
> >  	struct i2c_client *client[XE_I2C_MAX_CLIENTS];
> > 
> > ---
> > base-commit: 5c4d4169604b335c38bbc79bc1fc03042981fc6f
> > change-id: 20260922-xe-i2c-reapply-swnode-unreg-8e18b542549f
> > 
> > Best regards,
> > -- 
> > Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > 
