Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BEB606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 02:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kZq/6TwA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28AA510E8F6;
	Tue, 10 Nov 2026 02:44:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABD4B10E1C3;
 Tue, 10 Nov 2026 02:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794278658; x=1825814658;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=m2Lg/O8FpNqFBHaES2iBsPx96KSV9uJu+KXOIpV1qcg=;
 b=kZq/6TwAiQnHhAyEtuJtuxB4EO78bzmZmKEGPYqz2yjWA9Ia6h7ZgBQX
 zDSZaNEZzJ/W0a57vxhGhB5AhaHjFTLfRkskYehvuOY7f1BjcdMk9f7N8
 qQ7swiSXfZdOGoLk+5+9B9TlJWSrmfyqFCisQdEFcpHAKpOt05N1L+mM/
 NSal5+B1Nqdqlt/laqwQwhdZYTQaDslnCj4dTTRY7fDuG33wifU2pMFqw
 U2Qr/QRsYBR3LtQb/3mRZQ+boo9FM+Do3HU2cr8DAziOwYhbh0BCZyS3N
 YNbAX96jTHuLkWIw8YNf1Eri4oruIKIZRjiHI9FWOfun9921b7Q55hDd7 w==;
X-CSE-ConnectionGUID: Vy9WejcRQXKiS20TWHgE6g==
X-CSE-MsgGUID: K93iGx7hRGu8cf6eFbROqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3052184"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3052184"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 18:44:14 -0800
X-CSE-ConnectionGUID: NXswh0GjQ2iEEaj/uJ0F9w==
X-CSE-MsgGUID: /LAtMG1sSO+/HPr08qRDJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="9884375"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 18:44:13 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 18:44:12 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 18:44:12 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 18:44:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRyfGgw5vMHd7/UtRHi5imVHEE7rpxsTZPEbl4ipxglWEXFsoTdHAvVvPvLsMuDv7/f4c1Aah/qFBLZsm1t0wCFvCjoqgDL2c4eceg6PmnWrLPYZna5oiLBjppsfSrbyOFQ0qdu2A4J4YHdGemzwxUDdCTgbh0zADcYjF/ozZM9agNUR7taIgaXT7JOLjd7J1PBRPxn2lloHhAbLr0k/gQchQkXQYmV3dF0SdAcImNf4+l8yPXVgBU2LlpwQE99O2ntr5VTYHHVjRyXkVsCunI18Y52aiBT1Jo0thKWL4W9bhKgHqpSXUZyMk3uR15vmfoMdXzMdBRmgRUZf5srABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKJVXzsRANETgoFVQ4KfuwazeholpIyt9bgGIRpG4DQ=;
 b=yaW3RlouL5zcmoZYKKzPAT5LzUxYxJKWfOthFtSg8S+uMIlvxiVamzmrcnc2IpLrLSc4MBCuptnjaTHKhV1tsjVfnotu1tU8rwMLF73eW3JSR3BZ7vv7qqddBD90lHjGsXhT/yT8VWHllHtIt7noCY8g4Qs/sUs/cJeFkyfB2bS9e3wzc66hm7BJCv+qgaBtaHkSEtdcGaprU5wMIWu7+RlkqRHEiCO+TYioOY26rZDVSPxZIOizV7/DwOfjQhZ00bS0fYrFQY2QALE+HggUVrX0oh2zxi84B/hE+nN9RYHrR6oS+r7xL9ulXbMiytDQ8LVJE1isqwu5s0qoEAoVNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by CH8PR11MB407363.namprd11.prod.outlook.com (2603:10b6:610:32d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 02:44:09 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 02:44:09 +0000
Date: Mon, 9 Nov 2026 18:44:06 -0800
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
Subject: Re: [PATCH v3 08/33] drm/ttm: Bound page (re)allocation per
 defragmentation move
Message-ID: <avKE9ruZsQwbsQEa@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-9-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-9-matthew.brost@intel.com>
X-ClientProxiedBy: SJ0PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:a03:331::25) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|CH8PR11MB407363:EE_
X-MS-Office365-Filtering-Correlation-Id: 374edf55-a133-41dc-c470-08df3ed47ed6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|7416014|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006|261102123227099003|261028144727099003|261102130727099003|261021123027099003|261022105027099003|261022113327099003|261009220027099003|261022075727099003|261021121427099003|261026140227099003|261009223027099003|261026121527099003|261009223327099003|261009221227099003|261009221727099003;
X-Microsoft-Antispam-Message-Info: KNmEJY739bfGe0ze10fd+dLJMKqGO5UvRAEHAgJ05rxRmge4yU2S1KXYwZP3tsj/xw5AxHX0PdbJ0bMneiwfhGTeb854wcH2i7eNP5ISiKXFzxwdx9wD6qjDyr6v4r1q2csCIOOW3RGUj0jLR8TYHKrmVfhIY755OQTv87XlzKtRnA7PcO6zHSX2rvVWGlpG3wfGXMOAMjzSUVdyLW/AhoO4SDNJL1vuOuJ16jQG0VKn1pAN89xFney0uNqbGdCAUSRDomXE0Eu0ozCR6Zee0t9UFeoyPCGLzEGGt0tL9F1vwFVhvjPymwsAo6nROG5BlOzUzrNZ8kNvXqlz7f2+vsfj+58cvinFFR5+19DLpnzhl2kCLYd4NcimbfGD59CVgyUqrlEYgCMXY1HEcsYUmVYIDVYYwAMnNFk57/3LjXPib9zU599CeVl7yNym8tYLJRFx4Qim7GdR97umubAsDnnvUsYtPOg9FPZloD7wsmOnoUOOypVk29CtZEMvnoB5xMcWbWQeXynZ8e0bUqym9j7MJZ0Z5co5E36HHhsPrl0dJYKakzTt+j12o6OEPOvUgxaONn7BlOZvjwScGe89eCtkun2lhp31W9Iz/m87TpXuhlYvCaXRwAMBw4HAXloG4BJj8iH+ihF9LRGFQvFf65AubxzXAyr2ZcXKrU5DPQQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261102130727099003)(261021123027099003)(261022105027099003)(261022113327099003)(261009220027099003)(261022075727099003)(261021121427099003)(261026140227099003)(261009223027099003)(261026121527099003)(261009223327099003)(261009221227099003)(261009221727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?cBmK23P72fCSbufnVRE38vsAvBaRX40PkOqZJsul+PP6R+q+i58grCrxny?=
 =?iso-8859-1?Q?hW+BeMy/Day6DkDpsGEOggCJ6cxDo300AZ8TCEEwSdE/F1roVRk2DOwA2s?=
 =?iso-8859-1?Q?4qJ68yXW6xCD9pTPDsipHnzor4tmLQ6Hl6aHfE7azTbNM6C+bP4F3nQ5iw?=
 =?iso-8859-1?Q?w7l1q/HWO9qa6Jw8jzMTk4lndO2lpqmm2soU7+5XLArGzqskrTtYADBIJ1?=
 =?iso-8859-1?Q?yL/pbDJU6LZtAnAuqwxCETWmgMMEZ7meQDxZvEBF5TL/XiQXMGdfTFQD+p?=
 =?iso-8859-1?Q?qybpdWVwLeIBXEwyC+ibsJoSOcupco8JDp+/KLooC68ubfUneJsTD4YY/+?=
 =?iso-8859-1?Q?PV1Jf6v8PanzUKxXP9Lu3wewpQH8cJZL/NjAKdhShFjWjUd7QhdgnM4hXs?=
 =?iso-8859-1?Q?xGb7U6ruaAN7K6b7QP2OkNvVEdNCB+FSJE/pwMQoLtfDwksKTOvuKPVSlH?=
 =?iso-8859-1?Q?CSia+kL5SsHPc50eTpKGE0Qr5B5GJ3YKNgIw8JkzryJpePgzakx7dCQr3X?=
 =?iso-8859-1?Q?3qRxGG0IKAUaIoJZSBo3Q1HOLoB7Ny5fitPJovR6CgQyokYidO/mkIPdXf?=
 =?iso-8859-1?Q?3r8Bb2Xbb5YBgjVSUX51IcybCir13XDmoodbTcYA1rmbf7mh/lZP7l092p?=
 =?iso-8859-1?Q?8vopAd2kzyUeRY0/jV67GGW1aHKj0h59puiC9q83AmjSXvsd5ne4l76iF2?=
 =?iso-8859-1?Q?MQ5HVuxQoTcK6HmOduZB925dWIWmw8+2E5kvUlZ45wA1SGKUOPote1xfZl?=
 =?iso-8859-1?Q?BNpghupW9ACmTzCDqLj5IUH1LQOcZQkoZNk1fkbwwf0MBEEVp84fxbFWYt?=
 =?iso-8859-1?Q?+FVApZ6vECv3mNf5lISejaeJfKIg3sn5Hf3Ld9yKSWB2dX25dME/+JpNGP?=
 =?iso-8859-1?Q?1nGwMD63XqMUZSPqELMizwjq4JoIMkf5iQVBX6XtAVsfUaMy7KTOiLGMT8?=
 =?iso-8859-1?Q?bSbnnvgupjGOfZ8pBRUHhNQYuSfJGQn5u8B+eJCF0jw8ZtZSrjY+ljcuLJ?=
 =?iso-8859-1?Q?HfOEDronD+qgzS3gCJMtft0dmYbm1yX1q0yql1DIY7ohGnNLBiEN8DAmw1?=
 =?iso-8859-1?Q?ut64LRVlQFkFwFK5ioJLRnhLgD2XAbi0ZZeM1zxsvwisifD8y5O8bwJcV/?=
 =?iso-8859-1?Q?Km2LYiEvkepFoGU7B8Betil7Y2TFVelfnvxtv7bYUoueyAC13N76DHqHuL?=
 =?iso-8859-1?Q?Q7DOJ9ESVGpNB2wHyJWkHJ74qgvyFjO3ILLh28TAmMxmsMoH06bGO5iOw9?=
 =?iso-8859-1?Q?lhWHo5LAh/yNKcqCpVDZKT38qMzBRlSjrbJRas7FM+jzcV76XrvvmDHwe/?=
 =?iso-8859-1?Q?hbNwHe2Rx5rSG5u/JhkrpdDBusv7KNzNorPK/HyzVcWfKq9yxcVn2bxREk?=
 =?iso-8859-1?Q?eRbDQ0QThJk0GQJuNHTst95Mtw+YMz80MJCEKqYaHkarh6ql8IfrDLldR8?=
 =?iso-8859-1?Q?pJ4mWIG/WK7cYkIA5gKYN4Giw0jvG0QM0EfRd5TQQ8HAtR1cWwXWAOXpDy?=
 =?iso-8859-1?Q?Zhgmdkptttzb0zl1uL09oMW7qSDMC2pDrs8ang2ju2obup6wXY7JBIM6oH?=
 =?iso-8859-1?Q?YR3UlQDD0ZMw0GjP9f8qB2cQK+XLMTqGPKcfRoDRjfxqiEE5m1XNBz4MG7?=
 =?iso-8859-1?Q?ja4qufqzeB2YD3z2DtwaMLdVz9rqAxZQ9kewAOtRRNuhW4JG7k+lU5H1O+?=
 =?iso-8859-1?Q?qZYmZHAy2wITXiAFBtcKXoizcEZLAKoMA94vTgWSsenRNvy0rMEUA71swL?=
 =?iso-8859-1?Q?OW+g73r5N8FA+8fIioBj+aczzy1Zju50cUQznPuQQpMhdOkRx6WS1jc+5d?=
 =?iso-8859-1?Q?1BEzgJCqdhZud/QDYwAaiTKzMb9kqXKLFCT6y5abG9tJ0CwELOqH?=
X-Exchange-RoutingPolicyChecked: DxtUa/d/Vv/kDDA2Tsfjgd7aAV6IwxnN62Aw2sCD/67uhGL2TZ3ugvRy7SFeIsCq4EfyTzSTaeSCO5SOtPat2rc328DRn2ywZxVp9w26Mgz2Oomp0Z1SWTUnGPRgbrT5haBms71lSbMLs0CE1wejUlI6uPElk1OMAZdeoyJOeUGLIruviTixvO/PE3FfVjO4SqVS3Z80prxqVyKKgYgctllX1mno8FMmcd/RA5cL7+31uIpODapX+aUj8wnWZ8n8E1legzsHSqlQqEvII/pAlhGui9Dhfcnh5J18/i9S0Ax+iPv2pfYtuyhnxMYlaWnTVZ4kcN4ou0JsGM7u33BSWg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 374edf55-a133-41dc-c470-08df3ed47ed6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 02:44:09.3230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xgbkaxgKwHUdodiuTIjsQGLrDbBtmmOgILUD+z2iFGD165fDQJSbqQcD5TTEM/ncqhWmPG+T+CzxmM2ewKTNBLEua3OePsl5s8sABSS61lRyGHsY4yD82eO2cF6gZh3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB407363
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

On Fri, Jul 10, 2026 at 07:55:54PM -0700, Matthew Brost wrote:
>A defragmentation move reallocates an object's backing at the device's
>beneficial order and harvests whatever the allocator cannot upgrade from
>the old tt. For a very large object this can reallocate (and have the
>driver re-copy) the entire backing in one move, which is expensive and
>can stall concurrent work for an unbounded stretch.

Assisted-by: LLM

NIT...So, a time budge would also be helpful here along with the size
budge?

>
>Add an optional per-move byte budget so a large object can be upgraded in
>slices across successive moves. Plumb a new
>ttm_operation_ctx::defrag_bytes_remaining through to the pool allocator:
>only pages actually (re)allocated at the beneficial order are charged
>against it; pages harvested (borrowed) from defrag_old_tt are free and do
>not count. Once the budget is exhausted the allocator stops upgrading and
>completes the new tt by harvesting the remainder of the old tt as-is,
>marking the tt sub-optimal (TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED) so the
>driver re-queues it and a later move resumes the upgrade. The slices
>already upgraded come back as free already-beneficial harvests on the
>next pass, so each move spends budget only on new forward progress.
>
>The allocator decrements the budget as it allocates and writes the unused
>remainder back on success, letting the caller compute how many bytes were
>actually spent. A value of 0 means unlimited (upgrade the whole object in
>one move), preserving the previous behaviour. This is only consulted on a
>defragmentation move, i.e. when defrag_old_tt is set.
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
> drivers/gpu/drm/ttm/ttm_pool.c | 101 ++++++++++++++++++++++++++++++++-
> include/drm/ttm/ttm_bo.h       |  14 +++++
> 2 files changed, 112 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
>index 52f5e64f05dd..1673e81b8df8 100644
>--- a/drivers/gpu/drm/ttm/ttm_pool.c
>+++ b/drivers/gpu/drm/ttm/ttm_pool.c
>@@ -77,6 +77,11 @@ struct ttm_pool_dma {
>  * @dma_addr: Pointer to the next tt dma_address entry to populate if any.
>  * @remaining_pages: Remaining pages to populate.
>  * @tt_caching: The requested cpu-caching for the pages allocated.
>+ * @defrag_bytes_remaining: Byte budget for newly (re)allocated pages on a
>+ * defragmentation move, seeded from ttm_operation_ctx::defrag_bytes_remaining.
>+ * Pages harvested (borrowed) from the old tt are free and do not count; once
>+ * this drops to zero the allocator stops upgrading and harvests the remainder.
>+ * On completion it holds the unused budget. 0 means unlimited (no defrag cap).
>  */
> struct ttm_pool_alloc_state {
> 	struct page **pages;
>@@ -84,6 +89,7 @@ struct ttm_pool_alloc_state {
> 	dma_addr_t *dma_addr;
> 	pgoff_t remaining_pages;
> 	enum ttm_caching tt_caching;
>+	s64 defrag_bytes_remaining;
> };
>
> /**
>@@ -780,6 +786,7 @@ static void ttm_pool_alloc_state_init(const struct ttm_tt *tt,
> 	alloc->dma_addr = tt->dma_address;
> 	alloc->remaining_pages = tt->num_pages;
> 	alloc->tt_caching = tt->caching;
>+	alloc->defrag_bytes_remaining = 0;
> }
>
> /*
>@@ -885,8 +892,12 @@ static int ttm_pool_harvest_page(struct ttm_tt *old_tt, unsigned int order,
>
> static int ttm_pool_harvest_remaining(struct ttm_pool *pool,
> 				      struct ttm_tt *old_tt, pgoff_t off,
>-				      struct ttm_pool_alloc_state *alloc)
>+				      struct ttm_pool_alloc_state *alloc,
>+				      bool *suboptimal)
> {
>+	unsigned int beneficial = ttm_pool_beneficial_order(pool);
>+	pgoff_t bnr = 1UL << beneficial;
>+
> 	/*
> 	 * @off is always an old-tt chunk head here, never a tail page, so
> 	 * reading the per-chunk order below is safe. This holds because:
>@@ -906,8 +917,23 @@ static int ttm_pool_harvest_remaining(struct ttm_pool *pool,
> 		struct page *p = old_tt->pages[off];
> 		unsigned int order = ttm_pool_page_order(pool, p);
> 		pgoff_t nr = 1UL << order;
>+		pgoff_t num_pages = off + alloc->remaining_pages;

num_pages seems loop invariant. May be move it out of the loop as total_pages
or something?

> 		int r;
>
>+		/*
>+		 * Only report a sub-optimal backing when a chunk we cannot
>+		 * upgrade (out of budget/prealloc) sits in a beneficial-order
>+		 * aligned region that fully fits in the tt: that region could
>+		 * have been upgraded with more budget. A chunk below the
>+		 * beneficial order is expected for the unaligned tail (the last
>+		 * partial beneficial-order region) and for already beneficial-
>+		 * order harvests - neither leaves real defrag work, so they must
>+		 * not flag the tt for re-queue.
>+		 */
>+		if (beneficial && order < beneficial &&
>+		    round_down(off, bnr) + bnr <= num_pages)
>+			*suboptimal = true;
>+
> 		r = ttm_pool_harvest_page(old_tt, order, off, alloc);
> 		if (r)
> 			return r;
>@@ -951,6 +977,7 @@ struct ttm_pool_alloc_iter {
> 	struct ttm_tt *defrag_old_tt;
> 	unsigned int beneficial_order;
> 	gfp_t gfp_flags;
>+	bool defrag_capped;
>
> 	/* Mutated as the loop walks the orders. */
> 	unsigned int order;
>@@ -962,6 +989,44 @@ struct ttm_pool_alloc_iter {
> 	struct page *p;
> };
>
>+/*
>+ * Defrag move budget exhausted: the upgrade can make no further progress this
>+ * pass. Snapshot @defrag_capped is set only when a byte budget was in force at
>+ * entry.
>+ */
>+static bool ttm_pool_iter_defrag_exhausted(const struct ttm_pool_alloc_iter *it)
>+{
>+	if (!it->defrag_old_tt)
>+		return false;
>+
>+	return it->defrag_capped && it->alloc->defrag_bytes_remaining <= 0;
>+}
>+
>+/*
>+ * Complete the new tt by harvesting the rest of the old tt as-is (borrowing its
>+ * pages, including any still below beneficial order). Never fall back to in-lock
>+ * reclaim for the shortfall - that would reintroduce the stall we preallocated
>+ * to avoid. Only re-queue (flag) the tt when the harvested remainder is
>+ * genuinely sub-optimal; if every remaining old chunk was already at beneficial
>+ * order the move fully upgraded the object.
>+ */
>+static int ttm_pool_iter_harvest_rest(struct ttm_pool_alloc_iter *it)
>+{
>+	pgoff_t off = it->tt->num_pages - it->alloc->remaining_pages;
>+	bool suboptimal = false;
>+	int r;
>+
>+	r = ttm_pool_harvest_remaining(it->pool, it->defrag_old_tt, off,
>+				       it->alloc, &suboptimal);
>+	if (r)
>+		return r;
>+
>+	if (suboptimal)
>+		it->tt->page_flags |= TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
>+
>+	return 0;
>+}
>+
> /*
>  * Defrag move: reuse an already beneficial-order chunk from the old tt at this
>  * offset rather than reallocating it. Harvest whatever order the old chunk has
>@@ -1062,11 +1127,12 @@ static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
> 		if (it->alloc_count && it->defrag_old_tt) {
> 			pgoff_t off = it->tt->num_pages -
> 				      it->alloc->remaining_pages;
>+			bool suboptimal = false;
> 			int r;
>
> 			r = ttm_pool_harvest_remaining(it->pool,
> 						       it->defrag_old_tt, off,
>-						       it->alloc);
>+						       it->alloc, &suboptimal);

As suboptimal is not required here, probably send a NULL here and have
ttm_pool_harvest_remaining handle that NULL.

> 			if (r)
> 				return r;
>
>@@ -1121,10 +1187,23 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> 		gfp_flags |= GFP_HIGHUSER;
>
> 	it.gfp_flags = gfp_flags;
>+	it.defrag_capped = it.defrag_old_tt && alloc->defrag_bytes_remaining > 0;
>
> 	for (it.order = ttm_pool_alloc_find_order(MAX_PAGE_ORDER, alloc);
> 	     alloc->remaining_pages;
> 	     it.order = ttm_pool_alloc_find_order(it.order, alloc)) {
>+		/*
>+		 * Out of defrag budget: harvest the rest of the old tt as-is and
>+		 * stop (the tt is re-queued if the remainder is still
>+		 * sub-optimal).
>+		 */
>+		if (ttm_pool_iter_defrag_exhausted(&it)) {
>+			r = ttm_pool_iter_harvest_rest(&it);
>+			if (r)
>+				goto error_free_all;
>+			break;
>+		}
>+
> 		/* Reuse an already beneficial-order chunk from the old tt. */
> 		r = ttm_pool_iter_reuse_old(&it);
> 		if (r < 0)
>@@ -1155,6 +1234,15 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> 				goto error_free_all;
> 		}
>
>+		/*
>+		 * Charge a newly (re)allocated chunk against the defrag move
>+		 * budget. Harvested chunks borrow the old tt's pages for free
>+		 * and never reach here.
>+		 */
>+		if (it.defrag_capped)
>+			alloc->defrag_bytes_remaining -=
>+				(s64)(1UL << it.order) << PAGE_SHIFT;
>+
> 		it.alloc_count++;
> 	}
>
>@@ -1204,14 +1292,21 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> 		   struct ttm_operation_ctx *ctx)
> {
> 	struct ttm_pool_alloc_state alloc;
>+	int ret;
>
> 	if (WARN_ON(ttm_tt_is_backed_up(tt)))
> 		return -EINVAL;
>
> 	tt->page_flags &= ~TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
> 	ttm_pool_alloc_state_init(tt, &alloc);
>+	alloc.defrag_bytes_remaining = ctx->defrag_bytes_remaining;
>+
>+	ret = __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL);
>+
>+	/* Report the unused defrag budget back to the caller. */
>+	ctx->defrag_bytes_remaining = alloc.defrag_bytes_remaining;
>
>-	return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL);
>+	return ret;
> }
> EXPORT_SYMBOL(ttm_pool_alloc);
>
>diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
>index fcaba5fb8bf7..6124d2627b47 100644
>--- a/include/drm/ttm/ttm_bo.h
>+++ b/include/drm/ttm/ttm_bo.h
>@@ -223,6 +223,20 @@ struct ttm_operation_ctx {
> 	 * NULL for non-defrag operations.
> 	 */
> 	struct ttm_tt *defrag_old_tt;
>+	/**
>+	 * @defrag_bytes_remaining: Byte budget for newly allocated pages during
>+	 * a defragmentation move. Only pages that are actually (re)allocated at
>+	 * the beneficial order count against it; pages harvested (borrowed) from
>+	 * @defrag_old_tt are free and do not. When the budget is exhausted the
>+	 * pool allocator stops upgrading and completes the new tt by harvesting
>+	 * the remainder of @defrag_old_tt, marking the tt sub-optimal so the
>+	 * driver can resume on a later pass. The allocator decrements this as it
>+	 * allocates, so on return it holds the unused budget (which the caller
>+	 * can use to compute how many bytes were spent). A value of 0 means
>+	 * unlimited (upgrade the whole object). Only consulted when
>+	 * @defrag_old_tt is set.
>+	 */
>+	s64 defrag_bytes_remaining;

If user specifies -ve value, currently it means unlimited. So, may be update the
documentation here to say "A value of <= 0 means unlimited"? Or, better only accept
>=0 value from the user ctx here.

Niranjana

> 	/**
> 	 * @resv: Reservation object to be used together with
> 	 * @allow_res_evict.
>-- 
>2.34.1
>
