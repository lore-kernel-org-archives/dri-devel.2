Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC282606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Lsj/S1nw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE6EF112CC0;
	Fri, 27 Nov 2026 17:59:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DACC8112C75;
 Fri, 27 Nov 2026 17:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795802369; x=1827338369;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=X51x9q+LjAt7UmmLNVnEh6BxUgv23Bh+ZSnZCZk1jW8=;
 b=Lsj/S1nwEWHmaEWPKmrkQ+FRlwC2rmivrx67XLSzeRUNVU+AYFCsPBXY
 8pqE+GQFp2UE2vsEqyQNzZ2gdLJfXozqcucyrDolnBekwpAHEgJu3QmlY
 FdG+R5ni7KOXIJuZFGFk8CidOCa12+mrkbnV4UEVi/jyvEgZ+ZJSdPtN+
 Yr5WQUpnMoAfl+t4VAf0zdUMDd1ngGOUpZx7ioItQ0IbQIz1KxkjKgHKC
 bpGcK23WQe9zSk50sL13/4iQeJTQuHgFmDYIIX8mIM5X6azEd1CqNY7De
 pv1qw1yj77usRBNJmUiJd4j5WLhTrm5KSf1eM6I/us3WTvgWiF4uoXihm A==;
X-CSE-ConnectionGUID: WIGFXSkMRVOutK8E1cU5QQ==
X-CSE-MsgGUID: wwjTnuw9RkOk8vnV3CAz2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4678090"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4678090"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 09:59:29 -0800
X-CSE-ConnectionGUID: P1LPxeJeQQCBT3mK6Lpa5g==
X-CSE-MsgGUID: ZaNBbvQVRqyc4b+eCdycNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12789904"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 09:59:28 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 09:59:27 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 09:59:27 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 09:59:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOEKdVKX1CKCPHkdEfpX7EXccOrwRZp1A/uov2ANtlzwjtQgr9NazEv0xJBSdq4JS12Y90JFaIUTeCqJT7wXGAq8MaJAEjlveFPCBExJ4fJITnorWLyVTsVvUIdVRx+lrHXuCKc6glDsCSmBmYjHgZY6+OGww+0Eze5BaehSPJHazgKWrLv2E7F8W1VFLeH9AvXrcANBTCdEBaQWU9EeHFR4jNRnvhdP0gw4zr0WANiMpVb6ux68Ebmwbg5iE1C+rqH1bLQ/nuZKy4FwqobEDHvRVqyW4dqiun1uEUa0Bzw8KL6I+QP3jueLDyXOGvYE9NjMI4XkMuF2051wuDSEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDeQJU1H+SzIyOOaGcWZCIa18X0+lBdbE8GNz6fS5ro=;
 b=PrizpkHBuk33D+DDQ8Em3+zN+Kqw6qnK8OvlTLnYUBz+xWSaghhH/rxkYNIpS6Stqr46iwsqETZOVQRD6It+/PHUIJVKbjof3y6yAlpnUE/VQnkPjOF/H3yHJAkoVDxvixLQJ7g08pgFg4mr3CH4m2t5Vy2nznk4dBY8CsywA+Dd40l/U3LcNIcjBUC6rHvKNR02Uta1rWvONn5d4pYbytC1z3Z+QBthhsv62Qt3wFHMrpJRHVjYhz7SanRI2lmdpZUE92pXNo0DScLhBU6TKWa+YHu7Q8nclP2eYkeNfloA8ONpGpoCH/93uQ7IwXla5CtGVlIOoPT3g03oBTtRWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 CY8PR11MB6865.namprd11.prod.outlook.com (2603:10b6:930:5f::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.9; Fri, 27 Nov 2026 17:59:25 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Fri, 27 Nov 2026
 17:59:22 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <intel-xe@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH i-g-t 2/9] tools/drm_ras: Add a DRM RAS netlink tool
Date: Fri, 27 Nov 2026 12:59:13 -0500
Message-ID: <20261127175914.784751-11-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127175914.784751-10-rodrigo.vivi@intel.com>
References: <20261127175914.784751-10-rodrigo.vivi@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0190.namprd05.prod.outlook.com
 (2603:10b6:a03:330::15) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|CY8PR11MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: def48ca6-05b8-456e-2a05-08df4cb02ac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|261022105027099003|261028144727099003|261026140227099003|261102123227099003|261026121527099003|261022113327099003|261022075727099003|261021121427099003|10067099003|261009223027099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: v7RROs+l1j/yfaA8WYMlj79NOh2/spS+DcqunCu5+NbROsv9ynpA16Yf2hGfCMJRTtjChORF4ti1VW4DS3wfeULtqGgJSCYTgZsp+H7PQQV+OnGAjb6G6Q7RZpZiFnPxdVm88F1V8AFPNIm5mpApnc/NFVxCzw55POGRwTminiCFKKsE7JcCP1Su8VrJSlWhm3lu9Ey9EtnSOOZnUQ/HGowUDb/+ewmj+l9aAI8+TomqHVelc2UsnYa4754HOy2fecAj6v+Dlsry9gILAWjm7iPBIIsfg/TqsUa+ZRhQJ1gKcWgfUpj2UhBrZRDQekRjFTMbVeyYQM5JIYmoAzOhgC6qtxjlAuY/I75LLpcmRtfIHwB9Ow7dYZiBlRg7b+kyUsr3dbtPYGgMi3/dOisfED+s+KtNVdLlTFpXgT3vDnDylKNiUdjr+CuXk7Go7LbJ2Fjt0RtWoUfg8+WNk7ZoOJRdVOHD8njby47vdvGO0zA7vvuDIymIYYlBligPDW45yLN1HhaSklnK+b33yhqsbKxWa0fO1BJk5F9mb/WE4MhmV5X/9oZfNVJJkUkCTQeehZbX6lzkipk/zh/qCbTGz2x/zU0BMqWqjb297PSsXMbvWQSBlG5A5CI6Zznpnknja+huEu2VWGuENVSK/xvRNDx9ZKF371mt+6aPZYK0wPs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(261022105027099003)(261028144727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261022113327099003)(261022075727099003)(261021121427099003)(10067099003)(261009223027099003)(18002099003)(22082099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1VJNTcrbDQvNHlVVlhzS2JtaFZkQW5GMEV2dHl5UHJHZHQ5SlUvbW9lWHlS?=
 =?utf-8?B?T3A1Q2tBSUdPTDV0UWVJMG9VOEMwT1R4cDcyV1N2azIzTmZmT2l4ZDZ6aUVm?=
 =?utf-8?B?RVBFK3N0bGhud1V4N3NOemduazRZMFU0azRLbmYza3NKZlRUMW50bG9Oc0U3?=
 =?utf-8?B?MlFoTndOaGZ3QnZlRnJhQnhadWU5ZDVPeVpDNVc5UjJsWDYwZFZ5VkhDaFZE?=
 =?utf-8?B?WXZWYXJhd2pJaklFclhrYUl2WTBpVWVESG5PSGhvaURtLzdsQWhPVWs0MXd3?=
 =?utf-8?B?b2hkYVlCdWFCS2xkNUo1ODNoU0RURzVJNEhVUlZ3UnI3enhXVXdpQzV5Y2JX?=
 =?utf-8?B?NVVjdzhjQ25WWFRsK2wyVTBzeEphZDVIMmJWdGMrOTJGQUJyVFRmQytkazNF?=
 =?utf-8?B?SmJUbmZZZHRENiszNWRtZFAyUXVPQ3krczBLUS9TbEI0eENLbUx4WW9HU1U5?=
 =?utf-8?B?UGpNREhEdkZySndEU3lUMFBkbjkvNjVmbXVrYjRRU3lLb2lUMzhOVzluelNE?=
 =?utf-8?B?dUhQSFNrckhCQVlFeWdHZm43OEx4dmdYQS9QMUlSTjE1TjFWZW5NaUN0N2l5?=
 =?utf-8?B?bVUybllsUG9XN3h5eXcvK1hvZzBiNnFVZitYUU1KZW9jZUprZVkxRjZuQnMv?=
 =?utf-8?B?SldSQ0N4UWQrMDl2a0lzNDZKazU0TVVmbzhWU2NiS2lZek1PSzZ4ODh5b2p5?=
 =?utf-8?B?Z0pqaUJ2NTlScSthRzR2YUVLUWZuVW52Q3YrTm9FdVpIcWR0cGp2cFE5WENo?=
 =?utf-8?B?QjFVVUVIdlN3UlUrcTBDVllwUnBoZkZQd1dMY1ROcUF2N2xtZlkvaGN1UElh?=
 =?utf-8?B?dHNhM2NvTzJPNTczbERML0wrR2tnZ3RCVEVLbElZOFdzN3dJR3RVRUtvbXBV?=
 =?utf-8?B?T2xYeUJMWExyNG5haTJJYnQxRS80WTFPaDlBWGY4OVIwWG4xdUd1OXZhY21Y?=
 =?utf-8?B?Nlptdk9LRk9VZzhZbU5JK3o0WExFTmt6aDB6YkE2Ny9WcXQwZzZlQzB1aFR2?=
 =?utf-8?B?SGZzcXhXcFhuUkVZZFFxblNxODBkZXRWRi9PU3U4aEUvUS9TYkR2SGRTZ1Zx?=
 =?utf-8?B?TlRaMmQyQmtiaXJRREQ0djlpTVljSmZ1L1lYQjhYZU1TMTBGeHpaNk5Ha1NB?=
 =?utf-8?B?bG5Wc0Vac2puYiswcDF1Vll4YmhWQ1JBcE1BZ2RXTUVkbldtenpSL3BCUkl2?=
 =?utf-8?B?dWt5ajkxc09LOHRVcWNwcWNvTUxXdTJBcDJqTDJlaWp5ZDhpSmhFOVlLYW13?=
 =?utf-8?B?cHhDZ0Q1U3R1d21TMGtUaHdTNVEyTnZaTjc2REpQaHBtMEt0MVpLWllPTk5C?=
 =?utf-8?B?YWhMcFdnaUdOMlowYlZvZ0c1TUhubnFhZGs5Y0lMSmxjTXBVQ3FBVmttUmVz?=
 =?utf-8?B?MGxZazl1Vnc2djJtWENMOTA5TTBHWDBkV3Bsd3ZmdzluRHZxM3NPWVkwaEFr?=
 =?utf-8?B?TEk3eG1mcU85ZHB2a0RrVVlhNWdtd3BadU05ckp5eG9LWEVvdktHbEZ6TFNK?=
 =?utf-8?B?aFJrVi9kUktsNGg1VitCVHVhaml3dFRxVm1kMzdkeGdLNU85cElOTmo0MnFK?=
 =?utf-8?B?elFwWEtCQy9LZ0l4eWpmVHB0UHpnVlRqbW9iV2Z5RDYyYzdtZS9mZS9LdVAr?=
 =?utf-8?B?b0t4RityRFMvZ2s2UUs1aTRmRThkWHgrLzFNOHBxR0VJVU5rMUtqL1huRVRP?=
 =?utf-8?B?ZDUzR1lKN2NCaDJYNGlWZlZVN21qa2orWXA5d0hMMm9pMGFyM3JIcUw3U1I5?=
 =?utf-8?B?ek02SzFyNVZESFNnK0E3WW9ObXJibk51UWFFUUpmRkJ5WlBaTXUraEt2dlBG?=
 =?utf-8?B?WEFOaHpNRWliR2hVWjZLMmFTUEw2ZXloN1p3aXFhL25vdnZOVHVRbTFwQk1j?=
 =?utf-8?B?L2x4cSs1ZThzQkV1aStpemFrRkhrbytmWHRmbUFLeEczc2FCRGVVNENWR1Qx?=
 =?utf-8?B?WVpGZFJRR0kyOTc0SjJkYTVYNE41WUZqeWIzZUFrVGJwNlV3eVhVS2VRYTh3?=
 =?utf-8?B?VXV4UlErbWhGbyswZGpuUmhjVG5qUnNidmhsWklLaEJ1NWliRGpKMzBxVCtj?=
 =?utf-8?B?MjlLZytDanJFeG1ScFhLRTUyVWJpOEVvTXlDWHVyQWk0TWRzZzBuQzFQc00v?=
 =?utf-8?B?WFdkcEl5R25yL0xpZXpENTBUVDYxZGdyNVJYSGFHSXFJazZWYnI5d3F1Y1VQ?=
 =?utf-8?B?QVh1Wk02TXN2YURZSE0xOGs4bTJhUC9jcDNRTGo4eEppaVdDZGIwcG1QdThM?=
 =?utf-8?B?Tmk1QlZqUnJaTVIrR2I1bmNpTHlhR2JnbTRVQVpWY2t5V0FVNEFNQ3BGUUZv?=
 =?utf-8?B?YnkyZ0x1aHRRTFlJNjYvVDhkaWtjR1RJWVc3WENpV0JNN3VFWEw1QT09?=
X-Exchange-RoutingPolicyChecked: Q0Myjlo9DlN8J5BEckI6hP4l59ZOqd1A1LxRm2/LWDZWtR24vth6hKcUxi49gA3vvZ2OBGyqXtz+t6OG9n9gI/AaaEuIWadUZIBO6OlNsV5Izp+j6+5wPZmwAUv9Zm6ulwc0wz2zG2DHNa7v8gFsmsia9aM352D5cNlNpfbWJp6GvGxCT67BTMrYD3Hl949J934bk09ouiF3ogXmRuAgUP5FraUJ+ElvrpT0UmB8tquCqMuOEfAtrxCd25/pIdD6gS0ywQ/XpoEOBfj0Jyru3MGHyl8nGx3Tz8mg1/VfgZP1A+QBnQA18fgeIUxYvUtymLI1vU+/6OSTT7GauEoecw==
X-MS-Exchange-CrossTenant-Network-Message-Id: def48ca6-05b8-456e-2a05-08df4cb02ac8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 17:59:22.7482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gTRuohsgsM09t5fkFbluP/gAJgRJdHKke8xY+GgAZDg2MnJ0k/8innsLlOKFqBhig56sFDJ1XKcwtoe3Im6FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6865
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

List the drm-ras nodes, and show the error counters of a given node:

  # drm_ras
  0	0000:03:00.0	correctable-errors	error-counter
  1	0000:03:00.0	uncorrectable-errors	error-counter
  # drm_ras -n 0
  1	core-compute	0
  2	soc-internal	0

Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 tools/drm_ras.c   | 106 ++++++++++++++++++++++++++++++++++++++++++++++
 tools/meson.build |   7 +++
 2 files changed, 113 insertions(+)
 create mode 100644 tools/drm_ras.c

diff --git a/tools/drm_ras.c b/tools/drm_ras.c
new file mode 100644
index 000000000..0af1ca919
--- /dev/null
+++ b/tools/drm_ras.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+#include <errno.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "drmtest.h"
+#include "igt_drm_ras_nl.h"
+
+static const char * const node_types[] = {
+	[DRM_RAS_NODE_TYPE_ERROR_COUNTER] = "error-counter",
+};
+
+#define name_of(names, i) \
+	((i) < ARRAY_SIZE(names) && (names)[i] ? (names)[i] : "unknown")
+
+static void print_node(const struct igt_drm_ras_node *node, void *data)
+{
+	printf("%u\t%s\t%s\t%s\n", node->id, node->device_name, node->node_name,
+	       name_of(node_types, node->type));
+}
+
+static void find_node(const struct igt_drm_ras_node *node, void *data)
+{
+	struct igt_drm_ras_node *found = data;
+
+	if (node->id == found->id)
+		*found = *node;
+}
+
+static void print_error_counter(const struct igt_drm_ras_error_counter *counter, void *data)
+{
+	printf("%u\t%s\t%u\n", counter->id, counter->name, counter->value);
+}
+
+static int show_node(struct igt_drm_ras_nl_context *ctx, uint32_t id)
+{
+	struct igt_drm_ras_node node = { .id = id };
+	int ret;
+
+	ret = igt_drm_ras_nl_list_nodes(ctx, find_node, &node);
+	if (ret)
+		return ret;
+
+	switch (node.type) {
+	case 0:
+		return -ENOENT;
+	case DRM_RAS_NODE_TYPE_ERROR_COUNTER:
+		return igt_drm_ras_nl_list_error_counters(ctx, id, print_error_counter, NULL);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void usage(const char *name)
+{
+	printf("Usage: %s [-n <node-id>]\n"
+	       "List the DRM RAS nodes, or show the content of one node.\n"
+	       "  -n, --node <node-id>  show the error counters of a node\n"
+	       "  -h, --help            show this help\n", name);
+}
+
+int main(int argc, char **argv)
+{
+	static const struct option opts[] = {
+		{ "node", required_argument, NULL, 'n' },
+		{ "help", no_argument, NULL, 'h' },
+		{ }
+	};
+	struct igt_drm_ras_nl_context ctx;
+	long node = -1;
+	int c, ret;
+
+	while ((c = getopt_long(argc, argv, "n:h", opts, NULL)) != -1) {
+		switch (c) {
+		case 'n':
+			node = strtol(optarg, NULL, 0);
+			break;
+		case 'h':
+			usage(argv[0]);
+			return EXIT_SUCCESS;
+		default:
+			usage(argv[0]);
+			return EXIT_FAILURE;
+		}
+	}
+
+	if (igt_drm_ras_nl_init(&ctx))
+		return EXIT_FAILURE;
+
+	ret = node < 0 ? igt_drm_ras_nl_list_nodes(&ctx, print_node, NULL) :
+			 show_node(&ctx, node);
+	if (ret)
+		fprintf(stderr, "%s\n", strerror(-ret));
+	else if (ctx.dump_interrupted)
+		fprintf(stderr, "List changed while reading, rerun for a consistent view\n");
+
+	igt_drm_ras_nl_cleanup(&ctx);
+
+	return ret ? EXIT_FAILURE : EXIT_SUCCESS;
+}
diff --git a/tools/meson.build b/tools/meson.build
index 68c31da92..78587ec74 100644
--- a/tools/meson.build
+++ b/tools/meson.build
@@ -38,6 +38,13 @@ foreach prog : tools_progs
 		   install : true)
 endforeach
 
+if have_libnl
+	executable('drm_ras', 'drm_ras.c',
+		   dependencies : [tool_deps, libnl, libnl_genl],
+		   install_rpath : bindir_rpathdir,
+		   install : true)
+endif
+
 executable('igt_stats', 'igt_stats.c',
 	   dependencies : [lib_igt_stats, lib_igt_tools_stub, math],
 	   install_rpath : bindir_rpathdir,
-- 
2.56.0

