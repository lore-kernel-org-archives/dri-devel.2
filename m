Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18F9606A32C
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 23:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DhqGqn8c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C5D10E1D9;
	Thu,  5 Nov 2026 23:14:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F53F10E1D9;
 Thu,  5 Nov 2026 23:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793920478; x=1825456478;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=yx123Wk9YIjUmZl2p8kBuayURd7K+I7ttNIuw3rfEkQ=;
 b=DhqGqn8cqskdf0ANiAuBtckgi8jHbk0MtQGHNqZURPAff/CHrbrEXO5m
 9da0jIAY+p3tL5rjVE8mZj3+Zla7B2w1qb+/paMYgRwtEojR+Yvladl5y
 5PKCQkaHCBKHMzPpO08nF677mAB0tqUOtqQawCP+AwNBPs/QsBM8lw6y3
 yVYLu7XwPuX46n5rpf8TnNnP6jdjLX50cttSTg22pvtmNSMkqmogaEzyM
 YbymPBQYKGn+4zHg3tfiHeaFe1FNuqsXr/RvWGZaSS1hH9zIY7O9IfCZc
 /2InTMJ/8+NxkMN4eJBPCCIO2HH8CzKxTek9Sm27q5/0ZgyFscYSXxP3A Q==;
X-CSE-ConnectionGUID: AcPZuNQ6Q9iWes9b6yp4gA==
X-CSE-MsgGUID: 4aNWtOB2RHSh1ZR5NIWJAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2730977"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2730977"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 15:14:37 -0800
X-CSE-ConnectionGUID: J5pf81LSR2+Ris1vZ+UaHg==
X-CSE-MsgGUID: EY7VWjoyRoW4+M9C29hF1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7696252"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 15:14:37 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 15:14:36 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 15:14:36 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 15:14:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdix936QwVpMSECmt5c5xuB9BiIE+fRDg7nvQ4RiCxQgHl5agr9OmRZz98fX/sOmuLfJc9O9jmVNerJqDxxlZzUar/b3yf3jTFC18ss8OrJounQzWy5HpeW+p4Jf/TL+HSJMQgwSRZYiMb0ZTeCpLZsb9KBA1POClcuZTC19roOEQPr7SONySW2rFqXHdgP3e6WH1vuRn5mTGrGP084StVqxve6/5ObOMb+6f6fc6go1XEg9wK70BB14FUiDawOrKGZ909svRFdtRjRN7UOzpVvyvHLcayPfyRy9R9qxe7+8Tve6r/lT+gqIb0ZcNj37X9hTbjq8i6GjAsT2deXvVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8c8VbRNWz4Hy+RCSofJ3wt8lQpjcsl/gZwmlZMgzBs=;
 b=tkm8eg6pTN3imchv8SV34pV3lwsZJfjj0le5Ygnym6gb3bLSzLDuqq0zjRp5XvvYZhcIDjZwhwJx4UnB8FPjwbkS1D/OTVU+NVLXmT+LobUgO9Y7rTjkd9G7y5J8Cv2PWxhdgfGRG1JajowmUtv/2IendR5ihU6xVBYVzHDlH46KqQSTsR7fKMfa2P+C9gK/Dc15++KRkQtOGKkbASwTZRE7E7SuxqNkfLIeQ8o9MQA7o957NEazTBXUZIfxYekizw97znTB1qqAYPQquGvJZfERfzesM0so6rrZREgVnsVwd7lhtJHPUMCzRPFCwljJnpvLPv+janj0t3+QasCvAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by CO1PR11MB4995.namprd11.prod.outlook.com (2603:10b6:303:9f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 23:14:34 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 23:14:33 +0000
Date: Thu, 5 Nov 2026 15:14:31 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, Natalie Vock <nat@pixelcluster.dev>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>, Matthew Auld
 <matthew.auld@intel.com>, Niranjana Vishwanathapura
 <niranjana.vishwanathapura@intel.com>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/4] drm/ttm: Don't mark backed-up shmem folios accessed
Message-ID: <au0N17/xdm849qvT@gsse-cloud1.jf.intel.com>
References: <20261104201331.2462-1-thomas.hellstrom@linux.intel.com>
 <20261104201331.2462-2-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261104201331.2462-2-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0326.namprd04.prod.outlook.com
 (2603:10b6:303:82::31) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|CO1PR11MB4995:EE_
X-MS-Office365-Filtering-Correlation-Id: 5171bd4a-ff0e-4818-ec9c-08df3b928d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|10067099003|4143699003|11063799006|261021121427099003|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261009221227099003|56012099006|261022075727099003|261022105027099003|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 0mW6ycGCiGaAXYFnbM2iHJpduYTePPp6Xhy42ZhHvsJ3eT5egpAdVgPU9xrNSi2hwScd4IfmWMvhFRDLfYVMZbdQ1AnFct8+yaADeKrQnhU830N4EyKRlrStfAwoINS9wTkGBqlrI3tQszL6+NcJBOACkbGLX3f9mWVd3Q7TUsnDiOFrYkN74rFZKtfk8JPokcw9os2JdpLzZBeJBaBMhXXYmw6CbmJ0F2PA8+ghMqkkT01OhWF8iEqApF9k7jzy72QintusbaNUydAdHb2KWgTAY9rsX/NuR99N/jobPAwehxOR4tzVmyrMAK4I0tv70mvSAED4gFA9DCMICuJMvGY/y6C0Pe5X9wjMRk4KtlsnJ0Rcntpw+6trlXQNQneX7ZnakMG/wAERyC4pSl/LS9L8CCEXNBjGc+YowgLgmIVLLeCDwDkQwYmSNzkWi+icEJdk3E1ysoMteKVe/ZK4t6qvVyVGxCKhE+qhu9ey+U29J4XXZWJ3rby7v4LyTwvvCbcg9MDaXZATL5k174f7UneeDPWNV3kwW9sYWLj7YN8q4RZbF0dTuHv7YSw63jju3NFl5JckCpBjNvjDqEQ1JSf7Ue8SRtmIAw0Lu/pFADa158teHbScAiYTjqoWXDPrW6wdnJpT77HmAFnEDiBxy0fxPuEEAQalub4gseElLoY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(261021121427099003)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261009221227099003)(56012099006)(261022075727099003)(261022105027099003)(261009223027099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?JHDs+It+R+RRXeTzTDdgBXBbXOUo9pkj7iN2HNKj27BgMMWM/iitfBs44t?=
 =?iso-8859-1?Q?iAtYLvwFByoTcsw+mhYAqW49Ht5xDGMvWfczD6A8yByJHaLfOhFkZ1A/hD?=
 =?iso-8859-1?Q?pihlEbV/Py/HPk9kHm5yyX994S1j+v+Gq8i7W2rhnBQk57WhuJCH83SLr8?=
 =?iso-8859-1?Q?SaZ8XX98KXdBsJFQrjEgXbEQ6lwoN2SsKoEi/K3SFKZ2gq9EWogiknfEmF?=
 =?iso-8859-1?Q?6G80FqWHzbGnqVL/+1GVYJrDnpoy0OsEw3SgtdbgShemW9ecIUbHHxM5L1?=
 =?iso-8859-1?Q?+1TlbD6VApeURUp3e2kdIqw5zMvVUVXCuRLxkOYutn8ObmZesfq7qF8Yun?=
 =?iso-8859-1?Q?eWi5/gfmsU/BFjm4iTVN2dBOzmKWc2Xc5k+zJP/ZDhFkJvFX/Bn6w4ThuM?=
 =?iso-8859-1?Q?ibx5ytASu/Yub3JYTyTe5RypXru7FMfaHVIGxUQVIdGzbZk6SiBuWxFqCm?=
 =?iso-8859-1?Q?utqqThQdil6xSSFrMJ6P6PWKbP+g/jZbVHAemMPYZdylG5gyCAX39X2Gbx?=
 =?iso-8859-1?Q?8/nPwLBn++xsZ7E3H7TthkJM0CTYjYMfJlOTtj5DvjdppggM2q5Y0PgqmK?=
 =?iso-8859-1?Q?Y9iBTV7+PSqtXA8I5x0NQg1E89oL6f/BgBInz8rk1GrvZzphx44Ti4UPP2?=
 =?iso-8859-1?Q?4yw7Uz3mzkBoAokRtfadXGea4Ars4zztgxRk9LrZJRT5+/DYb7Tg3/6kqZ?=
 =?iso-8859-1?Q?DRUiKXIMGCV0kcBaBygdcMafxO1HXOVcYqfz7f3PnP6Aq1B6+svS6XxgmN?=
 =?iso-8859-1?Q?fwRIaiANne0O9i7jQaN0A19zf+H/Q7SWuyP11NSmGq+Ri8Fhy2SwkneGBs?=
 =?iso-8859-1?Q?b+JfmnjMh2zufgvG3+kQs8/PvvABk2svWk32IcTOwGzqkjyMjo/uh92v8X?=
 =?iso-8859-1?Q?AXd6GZjXtRwzaLAn5qYfv+WiHDgm4rQ3gFAMAfwAAKOzqRKlrtQwaLKmv0?=
 =?iso-8859-1?Q?IhZcTNVfUE8IcCSTnKdOGbVEpR1NkBas/zKZsRLQ+V0iNpka7ZSEkZJr6s?=
 =?iso-8859-1?Q?8YVlNe5tnGzrJoF5ZtgqGkGeJ9REnn8o9GZ9Ffc8n2WZ6iLKuW3zwU6Mvz?=
 =?iso-8859-1?Q?e4mdi+UZUic6rHyKOprYU8jAJgGdZDJD8QFIOgswQdHQMkSe/GokeUIQdn?=
 =?iso-8859-1?Q?czCSz+1a0enfSyUsWxooqPFM9pAaWC8mOXDJbRZKYdxg+8eMxKhBwQBLr8?=
 =?iso-8859-1?Q?Xg860MNYRDqsYOB6oDJc/ZQwSLUUeAqfCE/pp0OLT5tEYN3L2qjvlRWW4d?=
 =?iso-8859-1?Q?VQRQ9gzHyLYpTPaO1Og5MhwRzPb4cbL4mQTm6WkDFrVfSq+TyaCVFFkGeh?=
 =?iso-8859-1?Q?A7+izT7VEK4b86Ech2zHtS4tKRukSEUpuKfapPL+fKPBZk98lDEA5jGdhe?=
 =?iso-8859-1?Q?DGOVrd13biu0NncN+w4sGdR9Ui1CoW99qdwVrubcXDQgDzvz3u9Xs+MBHK?=
 =?iso-8859-1?Q?DrZNs5Xs+C0KfqW6hTRd4jOKwtTW1pzNaYaYbpTUuSvAHYWpr4tFxJ1B7A?=
 =?iso-8859-1?Q?55QaHUH/suyT2PcJvO8cKlnqYPv9+i/J1AtR82ZLHIwl0/de8GDYBztkBH?=
 =?iso-8859-1?Q?Aa8hlbmySEiV2HPNVetxSAK7EcRbT4uGfGSj7LoSAcUB1FNqp2OmTi3C+z?=
 =?iso-8859-1?Q?40aIkNJE8UvaUS2UEvm8NC6gNqNiV1TZUPtgcvN0aXxXHPXglZSLksvvfS?=
 =?iso-8859-1?Q?6jt51RgsQuR5biY0lTCvIo9F7TsJ0CCnxhKB7shW4LB73ADivgskmb1yVs?=
 =?iso-8859-1?Q?OkCJ9cTSGSHG0KO0k05qOtTHiSgiTm5LcSTBqEF3pB9i4yVDpc6djO4RfZ?=
 =?iso-8859-1?Q?AG9OCuNc4A=3D=3D?=
X-Exchange-RoutingPolicyChecked: BnLx/r4ZRmrYUc6El4PccBtYDTuYw3uUiweqDtIe6JVQ1RjeIRcLCne/D2OFu1x4OwjmODNzIxfWDrFebx9076vHPmjlE1JDDWV2u6vN11fQy9NUIfURQ7ySmA+zTXIHgNAp5wZLv1jIeNdS7zv5gsFWLWU334tfPs9OkjMVQ0tXi8oE0SlW36EafstYhKOkf531ZMQ1xFRwKROp/VhTwcpwRMZ1B2YkMWaR3lcm83E/c8YqUuFc8D5IsZj22U81V3jNm3A8SNkxvxSBFawtezghJy5OZL6D1P1R4ClR3phBTJZF1rZ5g+rKEcALPoy+2IihXQ3U9OC2NXx9ySQMXg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5171bd4a-ff0e-4818-ec9c-08df3b928d89
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 23:14:33.7768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40b0/A9edVscVmyFXIEskF+Eatdr0+aSBZvat6LaakWQOS6oxM438NAYnxKcz4PjTcqbmmBUSgR7Gq6D2RUjvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4995
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 09:13:28PM +0100, Thomas Hellström wrote:
> ttm_backup_backup_folio() unconditionally called folio_mark_accessed()
> on the freshly populated shmem folio before copying the BO's data into
> it. This path is only reached from a shrinker, i.e. precisely when the
> system has already decided it needs memory back, and the whole point
> of backing a page up into shmem is to let core mm reclaim it through
> the normal swap/writeback path instead of keeping it pinned as TTM
> memory.
> 
> Marking the folio accessed works against that: it sets the referenced
> bit / promotes the folio on the LRU, so a later reclaim scan gives it
> a second chance (or skips it) instead of reclaiming it on sight. This
> is actively counter-productive even when the writeback backup flag is
> set to synchronously flush the folio's content via shmem_write_folio():
> writeback only clears the dirty bit, it does not free the page, so an
> accessed folio just sits there, clean and resident, protected from the
> very reclaim pass it was written back for.
> 
> Drop the folio_mark_accessed() call so these folios decay through
> normal LRU aging and become immediate reclaim candidates once written
> back (or once picked up by the system's own asynchronous laundering),
> instead of being artificially kept warm.
> 
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> ---
>  drivers/gpu/drm/ttm/ttm_backup.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_backup.c b/drivers/gpu/drm/ttm/ttm_backup.c
> index 0c2d53a13b2a..9589067ad8cf 100644
> --- a/drivers/gpu/drm/ttm/ttm_backup.c
> +++ b/drivers/gpu/drm/ttm/ttm_backup.c
> @@ -149,7 +149,6 @@ ttm_backup_backup_folio(struct file *backup, struct folio *folio,
>  		to_nr = min_t(int, nr_pages - i,
>  			      folio_next_index(to_folio) - (idx + i));
>  
> -		folio_mark_accessed(to_folio);
>  		folio_lock(to_folio);
>  		folio_mark_dirty(to_folio);
>  
> -- 
> 2.56.0
> 
