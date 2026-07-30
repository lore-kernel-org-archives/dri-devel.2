Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9834DC55165
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0BA710EF71;
	Thu, 30 Jul 2026 14:51:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="amRIMvVL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5B4910EF70;
 Thu, 30 Jul 2026 14:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785423098; x=1816959098;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=Gc2oTdbp0xc5c5Yw7hn3RggNxbpQRsMaTw0LBm2zOiQ=;
 b=amRIMvVL2ZL6rEQRQHPsh4uIavYgE9YPCTzut6wXYH5rWfnG7B80gPtP
 mAjJ7jd19pMEED566AIurqPpcsmqqFzPMmRE7LknxrI4MwiDAN6yxyMOX
 E9tkBHaSFWbkoYEbOQ+7dWyRH5BDiqUi9BHMcMSXJg02F1C+aigQgPulw
 OOZEvANaOJn0Dy+BXu6kVjUaS+DU4zJ5AXz5YtZqpIAr9jDZUysTveP+Y
 z7pYrgCqCmCDPk6WWPiGMf7U5V4SQCETEzdqzv7XrkKNCgYRcOUNtc34v
 +GlpQaRpZhZ9vjH4fRynSc5D7FaT1EVW6UMY3E6Aggs1Q0W/Y1Vev9w68 Q==;
X-CSE-ConnectionGUID: T2GgfKoAQ0qqGbxBZYt/yg==
X-CSE-MsgGUID: driPAQj2QWac0TDcykoQnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="96401878"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="96401878"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 07:51:38 -0700
X-CSE-ConnectionGUID: VubZ/p/mRDCxa1VIDU/2KQ==
X-CSE-MsgGUID: M//G4FS2T5u8c3a7b0nEKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="264113326"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 07:51:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 07:51:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 07:51:36 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.21) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 07:51:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWYPydcEUlQtAsKCRS3prcUj+Cq9mRJACXUJIgfuoJtpQi3AHse6lh4Mo3h2IsbNiiPGKcui6XFHcjbYpGQorRJobSssJP1xom2jyikKyUxQCJb6NwOgrw5w+dFIbTo5pqXfegGeLm9luAJ6TFrdlRSZsS8BiyrLUaTIlAhg2QAtfsiuAc+7zvm4La7hPG1BSi25lyzFkddtAKP6dHAss/mWOAmIWzswtUUfsM26DF/DRzrqZ+U9KxnhCag4tRTmIud4blZsPpkR92J0OadO78THJgkjYRlDdPoWzwl95PhWxlGb32aPT11UbzJxmOfq9CE7XiyK0NAvaRBZVXiQmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QNmWx1LUFUjzH0xas5nPfv+vawwSZYrfm9Bwc60cD8=;
 b=wJVs9iiTL29GfbRTlbL3ZPQlBqInmWXcRxOpiaX6UYiYEqNIpervrvFNbQG9I92mi73GtgTOanBfmSMOpaFrqvrm4mLg/w72sot3cE1y9ZI4gGcJdMzAT1ugyKUTTk1gU98TC1eM3M+LTT1dl33va98C4GDr2iKx1hrQxUFStfFu0xo6mzaJwwZFeAI9t9ZjqPvGDySdKl50kocKEeICi/Pt0OIp9hhdZ0AOc3NOe+rDqh6S98IKjLCobfhTsRibkvbZVLPn6oWnOAtd//m7zn9e//GDyTlZos6UR2qfMCFe6yYivU/WfUlf2tvtwRg+z1cPxhA5xcOdBo0f5B4jmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5082.namprd11.prod.outlook.com (2603:10b6:806:115::5)
 by PH0PR11MB7447.namprd11.prod.outlook.com (2603:10b6:510:28b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 14:51:31 +0000
Received: from SA2PR11MB5082.namprd11.prod.outlook.com
 ([fe80::96a1:ce7b:b3b4:6026]) by SA2PR11MB5082.namprd11.prod.outlook.com
 ([fe80::96a1:ce7b:b3b4:6026%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 14:51:31 +0000
Date: Thu, 30 Jul 2026 10:51:25 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
CC: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, "Oded
 Gabbay" <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <dim-tools@lists.freedesktop.org>
Subject: [PULL] drm-xe-fixes
Message-ID: <amtk7ZddR12dgg-A@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::14) To SA2PR11MB5082.namprd11.prod.outlook.com
 (2603:10b6:806:115::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB5082:EE_|PH0PR11MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: d6d7d47f-7551-45fa-c988-08deee4a0a94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Ws0yJq1dLX43vTchC8iXfIPuwlQgbcI/Rn+Q7XuXqopUzU9CY7qVCmcU8nZk/bS0MOF/dpBEiSW/SzxbFv3IkgexQNgjO0Dul/VZb/ZbEIVcAFCO/RicfEah913CaERfQySq3CDRZfltxcUJvqWQU23sGytQJW7DTRCo6EB+CADGzuBsfhTWOsXeTXsTT9tioEjHAV0Po8qeDESKMt6a+XP7Ie7PYDVVDZe0gOXebajin9tcLSfs63YxpXjNpyJ52sqJlD0bMz4SsOjtdH/lZUaBN2G5mPWsgfzGKMfm9iLZYOtPQyvDhIlymbE9ayF9D1vFk+3fBFHor3iMhL0cfoiA9qRdexyCc2yxG+oe1bdWj+qEpw0Xsb5MjnI2h1S4Poq7kTkpxnoYZQVGeYwcAnXU/768VKpcMpqJreodUfIwXMvr1KUTGuLin7UMHiftNlpByj795gKzhWJi32ODKqxt8wEtYSfUO08Q5N6NpdgLWN3CgR7jNB7kJoNyWufDTAeIE+sEergDM4U+7+4v8rXD0MSdsHhMu9729luXpGIPq1lHP/Jldex0e9uU2KnUsYn39tp85i8wqBeN+uMXZrqfoWKQnLMqmKaM7tKYers=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR11MB5082.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WI7idtfCxeGWlvLqcJBbk4Ozif/yehs1nC16EonVkCC6lP/XztebC9X+dEaR?=
 =?us-ascii?Q?iYdTOYAke7U52yjCuS/V5tQOkFmWgq+ibPIZGsqOPcjjO2s2OeMdBstqTf4C?=
 =?us-ascii?Q?1yjd0Dht9I4ugBEi7vtnsUfSHkbfnGfSGQFLnjKOQbwl5Kl7ZpI4z5oimjo6?=
 =?us-ascii?Q?w/nIApvp4zrCUgcbIt/6nwh/mkGBeXQwsh5YFRBEav/jjPFYshxnnzg871HF?=
 =?us-ascii?Q?jOQkqcy73/sIYg7kwmSA9P1zxwrd4vuJ53pZD3AduoXeswD8e7PiPqqnkqtz?=
 =?us-ascii?Q?pz2bQZcKKL9+yB6jG9yY/sK4UK57EPBzlCFhi2JQePCEzybRokBX5cTbKXWc?=
 =?us-ascii?Q?U2E1UBzv3LkdaluRA0uRlJWZqypT88GGhBzuoLH8QzbR6Q7wJYdzSM4kUVrL?=
 =?us-ascii?Q?KY839WEr/8OCAAmw9gIuzLy4UTQEA8Z2T087COHk3SzLRx3vuhH/sPvMgb86?=
 =?us-ascii?Q?IR7kVgB8B/573LteYrMKIAHo8F//4EZ9Dehf2wFocZAWpwgVP+L1PDYOD7IG?=
 =?us-ascii?Q?SOgaV8PrReiQlh13Tifpqky4bvbPF5ZxE0ThN6OIvh4T6eT623NJfulgMu7Z?=
 =?us-ascii?Q?gC1ZKo0Ros7ftvkJcFvuWac6r71hLCCN/hXCGeetMhLdE7ukq3SUUVvYTRcI?=
 =?us-ascii?Q?K4n212tS3/6zTHvgCqykZapXw3qnpVYQIDIJ+1vqhUWp5rqP9hF8VmbTTsXt?=
 =?us-ascii?Q?eoYTjqL1cmydxge3hK4ofsiLDWd6w9CSnZ4RUliCKqijnb+WsG5jRUrs27aY?=
 =?us-ascii?Q?Gz/5ouCaxSsFOdAv80z2bIrjdc7BDBvuFT/4tJTAnhuC1pWByDuLCqsn7I47?=
 =?us-ascii?Q?vLKDnZZB8mT0h8yvats6l3t5PEtHjGkW3eA7SxbCYtmslhc7ofzDWKmWJgpy?=
 =?us-ascii?Q?HHGYd/RLvFhRhTbp0OBZZaOhChf1EoaMU3iHfE17otms1BGSeQUFm8n4iu+V?=
 =?us-ascii?Q?9ECjtRdEETEZTnecEZXkEjcraBlI2VSx/bMCoFKe6yVOl3Gc4PhLg4gfNN0D?=
 =?us-ascii?Q?x4qdONICbnqucOzuXqeUF1KkonYP6rEIlnEGEOwEipO6chKC6ztrEZNnwSpV?=
 =?us-ascii?Q?X8TG4lNGtUOMmtlQwJAz/jgExCIkm1ZqwNleFKG2BM+CX7+9+viExDY2V2bS?=
 =?us-ascii?Q?7yhgef9yhzomDB2p55slOfVl7kJxiNGKJDWln1AGpFivRZiKxNhfUFhgWOOV?=
 =?us-ascii?Q?ddFfHWj6E7QdpU0sZPjwWQy31S/OvUmFqcqNcWLMhOW82i7FyUzAxOSAwk7h?=
 =?us-ascii?Q?u2RozK9gfG29Sod4F9EsmYlKuwpq+qVBVQ1CfEjKv3Goy+B0KN8BB86lGMkK?=
 =?us-ascii?Q?xD4bpmy2LrZQx6BBMAVHp3H+3aIN+PH5KXXVSzgG+SDygpsdz75CgLt74FtW?=
 =?us-ascii?Q?7QecOPWX4FwJzn3Z4jgGEamSC6Z+DiYpFJBmG2W28Hou4na0jm79U2eE743f?=
 =?us-ascii?Q?7lID4qXJd9ZH1PBxpz/C0Ly6SdTm6Eb3rQQNAv1bv0OXiTmyA3EdJTJU0Six?=
 =?us-ascii?Q?rTpZYPj+p1F3CBOqEhq+IzJtepycBO7XOkZl2WiOJR34BtQMfsm2STTuomqa?=
 =?us-ascii?Q?GiZA6CPkR/t4Fc+G17DBuRmK3V7+UDRKQJCZBdVt92omEPIFwjhDpPEeHUux?=
 =?us-ascii?Q?WXzCrbArFMMbDhiLyNqlHcuDLmuFc4NuyVq8X2qE7xass9pliyRt+a9vvaVK?=
 =?us-ascii?Q?HJxgNMMskUM4I3I+8zsIMPs79mG7HyrWFTLzbFL5vIGorF8Fz7B2RSa6ZPRe?=
 =?us-ascii?Q?doOsnasGrw=3D=3D?=
X-Exchange-RoutingPolicyChecked: aLOF1akdwR0JW322Qys13sjX3M9HgDp9iVN2auzSgJ0SkUPFO90EjbbnZ8FDb4pox5EbC1lA/NZuF0GR1DssOXFDlrVFGFUN+PDSIlYlXsfmS1/NsfemMyLKkirSc8l95buQlm4l76I0rcO5JvGEtPicL1tm2OaID62D4iO7FDsYoY6HmZZtlDPg67QzX9l3g1YPU/n9rLWGoZe9hH+keO38DQiOgVVdQfGZBuQ/6W6P4iuyZ4h0lHeZ65a3y/rbamfSqcbdQNRY8TMrdJCjnMTir2G1Y1kKtK1GAHUVzKTrGMgx15D+h+9cJ7SglBKvKgZ9lY1aI4sEfzvEefKTcQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d7d47f-7551-45fa-c988-08deee4a0a94
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5082.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 14:51:31.3541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tr06TUvoFX3zR53wdVzYiK2QONNC4XdrBoguIj35FktP3kTjkymKqqmqeE4L3IQHwa8MrhEPVzxN1anFzJ3oMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7447
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

Hi Dave and Sima,

Here goes our drm-xe-fixes for this round with a single fix.

Thanks,
Rodrigo.

drm-xe-fixes-2026-07-30:
- Check no-DMA huge-pte cases before DMA segment test (Himal)
The following changes since commit f5098b6bae761e346ebcd9da7f95622c04733cff:

  Linux 7.2-rc5 (2026-07-26 14:45:48 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-fixes-2026-07-30

for you to fetch changes up to d94f82d57e7a86def6946f22b34eb53f96628f8a:

  drm/xe/pt: check no-DMA huge-pte cases before DMA segment test (2026-07-29 09:43:21 -0400)

----------------------------------------------------------------
- Check no-DMA huge-pte cases before DMA segment test (Himal)

----------------------------------------------------------------
Himal Prasad Ghimiray (1):
      drm/xe/pt: check no-DMA huge-pte cases before DMA segment test

 drivers/gpu/drm/xe/xe_pt.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)
