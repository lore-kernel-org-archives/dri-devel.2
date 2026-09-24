Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A407C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 12:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 762DE10F4AC;
	Thu, 24 Sep 2026 12:03:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="W9doPOOk";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59E6B10F4BE;
 Thu, 24 Sep 2026 12:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790251387; x=1821787387;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=I/bqblnZzbyTe/rGTNgqPPBL25Qx/jXzJDAJ7j9Y9EA=;
 b=W9doPOOkwDiOQRTx9hGyMWWrOSJlHykC5c0B8XZEekgETYVzTuLLsL03
 8fwHJpsD8KmHRXlR7BAjxSSC7cUfJW03PH0/Kn44R31xjjBAUdJi5e8J2
 6DNUpDnQk/bPsMApb0rxPADVtFE4STtOWfNTZXsu3i4dyMOei1wRTmbJA
 FghSd6YKJE4GINeP4NMbYNZMXfmvEaVYLHr/e0uJ+CZw3vH6QdjiQ5f2/
 U54i89SpyEHrLvMfNcf7OeZ/5nLDpI6jCHd/ejcD67uwghxpucMqQkmtS
 tY8eTNAoszfHteahmmyoSTkYjcdtGKSo9fHuZH7ql/frivmbZm2RlrX8X g==;
X-CSE-ConnectionGUID: MIaIliRuRNqbqxZGFN868A==
X-CSE-MsgGUID: +EwFgj5DR/O1Gd4NBhMlSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="91123437"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="91123437"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 05:02:59 -0700
X-CSE-ConnectionGUID: S6HACaDzQ+e3qNJClBYokQ==
X-CSE-MsgGUID: ddrmGr3fQua/BV35krdHAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="270492689"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 05:02:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 05:02:58 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 05:02:58 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 05:02:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqlxttS0/5zFdmrL+KNob4J+CiubVy3sQcpDQ09ZoGDq4Thqz2i4sfCnAseQtZNzc5mv6lzK0p+sSqe6oJTnmnCSSwNNNsz4cwg1rVZKY8tJyMAOfVlBs0v0luCVYH7zFNWQ9GH0Ez5r/KwuQMrX0Dom4G7OtCP4drhvMXZbo1xSGRCuZO0odEpe+XTd385cCf1MyezogO3NtQbM60hDB9JUs7NFLJ5j32cArOZun3P8LotyOWbB4ZiqGJl3kH6N96Pqk3BLL+Q5U4Kr7OY4S1QilbOBs2YN+7m/DPJApVgnTY2jWpCbT96Mu5HNTO/7tOnNfmqFF5tMz5xorPogeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RATT5Hf364nNytr9xr1oX83aehyeg7WvR+3MDbUr7I=;
 b=DX6TyiG1cdDT4Cy7zwPOzoUZ2xRvX+9dp2qGW68v0G8YqyhwoggjlL0VqL1Q+nfGzju6X3XJONsEOfvjWd2CLis3+4q0aoNJQ9WVVCYjh0CpAqPC8Dr03AGU9MT3AgPN5RuUpcQMA9TTg5Ucr8wCMfgtb0rQB7Z90GSPCCQhDBcG3RctQYIuGLQNQzz8Ie7mVnYPQAZ0POHjxWkTCI96Q3N6McxfCfser2Ija+HBn6BCNc0nKLqGkhyS8wegH1XSTQASAaoiw1yKMe1nyEo8T/oXV8JdPnbBW/4NbUw1LCFqSaJ6kGvPnw2nC4Y3L5oIll9oTrI/aGjRJBGw7MgKPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by LV8PR11MB8748.namprd11.prod.outlook.com (2603:10b6:408:200::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 12:02:44 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 12:02:44 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v4 4/7] drm/i915/gt/selftests: Use gt_* prints in aggregated
 gt selftests
Date: Thu, 24 Sep 2026 12:01:44 +0000
Message-ID: <20260924120147.1305127-5-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924120147.1305127-1-krzysztof.karas@intel.com>
References: <20260924120147.1305127-1-krzysztof.karas@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::18) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|LV8PR11MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ea713b-ca58-4767-83e7-08df1a33bb36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|11063799006|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: N6aU4gwse+gRoj8dLnZIOF6FTgTfJiUNFdEKV7pJj47FwpAI5r/Dv+W0E9MlAaLdXx5Mw+tv8vnip4eVAk052ny4D7TL7xv4hnzsSnaP8aKgoTevyn9IsWX6OzjBlKt2KZ6e64BHBwPW/zl/OhPB1kpIyMc02oaSRe+10lNuQRb/Aw4RZlh5wYaOVbYaBg7zFr1dgxd0hTY/PTOxmb0wx32m0rNHQth9wEVloPBoVFJOErxrQTUbgU97AM/PpHSBA756hf7mq9uKzF/Zi0oCr/CstD5af9HsNKFTJhLekGf7jEHSzQKfzo68Wcthvy7nELzDOWZ6iYR94B8W9J3zvFO2T+N2DM5FFSDYHY2Dndp9dtWI1GkjHzTKg9CC2npC9uGRIHM/VJtyN0sx7V8coC9/RSstH5Cfn4KaNiuhI0FkCH9zC2ECNRuWCpS0oP/as9URVvWjZr+Ftk9MnXzwghu+YDMv9wGskBbI1+gk4U5kEBk4U2FdzzNfK254/eycuNUecud8OoLzgiP1qlkYwLWWR0kzqFWlNb6TmKwiPms0AM4IT7+ZSxFNitpqxOyrF5+YpKsIAR9se7om04mSaWGOXipZOThHppFXRE4cdQPcIocKGJlu4Rg2lLGkaE7kJWsojcKoeVpfOqCTm0VyFBg4t2YhtJpVGOLX1iy+uWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk5zazRpRi9EOGNzL2hPU0RIM0JOeWl4S0VtZGx2bDBmNHRKUEhxVDBFbGFs?=
 =?utf-8?B?a1R3WXlQQ2w1blFSTHJQdEgwMGo5a0FHYUlZa0hHck1aUE54NjgvTXV1VXRh?=
 =?utf-8?B?bzNJb3daYzBFbFY1Qk5yKzhNeEdMM3dCdnFTWGFUdnlydzdaYTFjOW1oZU9H?=
 =?utf-8?B?TGdXcjZkYVVqL0dCNndZR2w2VlNlN1E5eWNMQ3gwVlhPTXBEMHEvYjFFTnky?=
 =?utf-8?B?NzZubmkzSndwQlpVS01sdlhnSjBSVWI4UERQVGJ6dThwenUrUGJHRmN1TzFC?=
 =?utf-8?B?V3NmbjVIOU9wbXdEUkRVMU1hRWw0Y0tzalJsK05DWjExWGhOOHlIZkdWdll2?=
 =?utf-8?B?d2tsQS9ET0cySTQ5M3FOK0VyazZleUFTZXEvRDVtd1Erclh3bGMrMVBoaFIw?=
 =?utf-8?B?dnB0b3FuVmp5YVJQVGpheThicDdoUEVETWk5Y0hpNkxCN2ZidVpOUVZDdmNZ?=
 =?utf-8?B?ampwL3N6R3NzR0hiYkxOOUFGMllIT2dJbFdVaVp5L0pFM3Q2OFdSQ1RoY2xJ?=
 =?utf-8?B?RTlkK1B5Q3JreVlqdUVlak9QNGhHUVViaDdNQlJIemtvTFFwZ3BXYUZQK2c1?=
 =?utf-8?B?UHpKVExmbjdBbWEyczdQMjUyV1lPUW9JK2xJQ1lJVlBJNTVCYnhTOWNzZlc2?=
 =?utf-8?B?cGZnbnRmekZHSDlMSHJZdmRzcldaOWxpQkpjdGthdDh0cUZaT1NVc3NRRlZN?=
 =?utf-8?B?ZmZBTHJFaU1TenRVZWg3YlRCUVhhLzNjQWxPa0NJNjJtUlhxMFBDamZvcjNx?=
 =?utf-8?B?a2dBR0xGTWFGTVp4TnRwSU1PV3pCUEdYcThsZTd1SXU1YnczSHE0OFVuTWZh?=
 =?utf-8?B?bXVzRU1NbXpoaTdDbGdnTHpJUldWcGNJTHhaVGYweXdSQmcvY0N5NW95aFpj?=
 =?utf-8?B?TG92M3FlRVIrMnQrM1RBaHA4bFBSakliT1lvVGxKUmlCN1lLQmVQZ1pCV0VV?=
 =?utf-8?B?ekNObERGM2NwbzJVZHkrajhKakNGWnRpMGJOZWRRNE5YdHNlSmluNm5UVzVQ?=
 =?utf-8?B?TjlNL3Y5cXBEbU9JMkxVOGFhWWJ4RnF6d0RpRWJzSzhOdUlJb0I0RURaenM3?=
 =?utf-8?B?VjZTcFo2VW9aeFhsVDc2WTBDNE1oUXA1a284UWFENXlic1Q4bXFrNmJnOWxt?=
 =?utf-8?B?dUFzbE1QcHZ2OFhWUHl1MHl4Y0RMUzhYTjBXcDNRWVFKc2FjRE9RV0Rldmdl?=
 =?utf-8?B?ZkhFS1Y2WmNHTDc4aS9ZejhhK2FvNTZ5azV5VmFNd3dVV1lDTWdDbkRQbUNU?=
 =?utf-8?B?MU1Ec2FlU3paZFBtN05JeENYQjRnZmdhSUxNa2FoK05rQmVYUmpzQXJXY2Jk?=
 =?utf-8?B?UzBZSy94Q0Q4RVNabis4clNGejdXVGh5OFBJL1hud3JoWXFrR3MvTllXUkkx?=
 =?utf-8?B?UzhZZU5OL1JtZXVobU9ZUUc2bjhiWE5MR2sxcUM5TC9SZ0JhRTJoUlFYSWJC?=
 =?utf-8?B?N0JPTmNKNERUNTNhcU5VQVdGcTkyZ05KYkxJYmJpd0dIN0twVnZZTVZpZ3NE?=
 =?utf-8?B?NjJRVWNnQmE2TzRVUlNkbEkvREJhL1NVNGpEMWhpd3h2NVNJbk92VFhCSlhr?=
 =?utf-8?B?a3doL0x3TWxmcTFCeGV1Tld1ZUxaZnJEN0ZJQlBhbEpJeGhSbkJjNDdSb0Vi?=
 =?utf-8?B?c2FmZUZ4Njc2M1ZTWVJBUUYxOEZOQ1NDU1phdVNKOFE5bmFoSDdURmQrWE4z?=
 =?utf-8?B?WnF6dEFBT2l3UjJ0VER5d3BYTjd3bzRqZVF0WmZhanBaekZWUnRaNUI0SWpD?=
 =?utf-8?B?V2FpdVUyUWFHV3ZlN3huME1PNHFMTExycmRVUFdUZmZLS08vQ0pSN1hOd2F4?=
 =?utf-8?B?Qml0NFdtam5PSE0wMFh5QnBmc1VSRXVWcHFpUkVwTG0wbkkxLzhkWVZIeC9L?=
 =?utf-8?B?QjFOUWYrR2MvdWtmYm9mNTZhZDhGUGk0NmpHWlJtNlNvaWV1K2VEaFprcEhq?=
 =?utf-8?B?WFVzMmxOUTBuWmg2YWpiMnJxS2lKK3ZSQXpwc0pObFNwbk1ST05LWmF0dXZh?=
 =?utf-8?B?M3NLRGpWcG9kNThiNkNGU1ZJV2RxeWo0bTFiQ0hRTE90NWZpSlAvek5oR3pP?=
 =?utf-8?B?Q3p2ZUhvRno2VCtZY0dvbkRwS3NXSjJjcXNodEgybldab0lVNGZUMWZ0a29M?=
 =?utf-8?B?bzRiR1JiaGsxOWpLaUVJbDhDT2tiMm9QdDRwMmE5L1A5UTE2UUIzT2dYcTlZ?=
 =?utf-8?B?ZkhQb0t1OXJZMDlPRHlSOUtaOWNEaDNxMzVlU29QR0FibUpyc3VuZUN5eVY1?=
 =?utf-8?B?UGdyWmFGVENFdC84NDZtSmRGd3dwOEQ5NEdkMEV5eHFmR0JQZm9TY1lXRUd4?=
 =?utf-8?B?VUpiVTE3eXQ2ZGM4akxQbkMrSjVCM3NNc29aZm51dWc3NWpaM0JMSjZ0amNq?=
 =?utf-8?Q?dQmODM/8MDlgVtAY=3D?=
X-Exchange-RoutingPolicyChecked: gEOlEdmiADiOfTGTTeR+W4vipo0tGow+K20FJbLqWdQvUmjTCYXaVjuy1mcUokcPpGLIi7M+Eo7oh1VgRnHAiQxtPUX9NzCjqWokv91fNi0esIdx8Nkkt9JZRvePrLnv74dHY7BWU+/gttGfDkLK7wF+oz/7l+5OvEgpj/PzQlrXFHt0rM+7p4IfhPXW6qwzKetIic1rAjakmSSV1uYQiov3Ld1+3o38ju+KP/Va7YkB5pVYge1KCbIULoVBEiV4XCklFxXTWpEgUcT9GQcy9slpOWyOJyLfeOGQePRBcScMpiwKQRo+wAjokf806OiKGlVHVAFeoTTf5T56ok7NTg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ea713b-ca58-4767-83e7-08df1a33bb36
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 12:02:39.9141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrf919c+LcfikBK1iOPbJkDcmJeEfwDFa9mb4jVC/1tVYW/9MQhulu2aRY+IXZNzzGI0wOF4gTVQwpf1jgenBvpAD2LRZJxnqP23HtrZGJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8748
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

Move away from generic pr prints to GT aware gt_* versions,
which tag each message with device and the tile it came from.

Assisted-by: GitHub-Copilot:claude-opus-5
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
v4:
- switch drm_* conversions to gt_*/gt_info() where a GT
  reference is reachable (Andi Shyti);
- keep the __func__ reference in the reformatted spinner_kill()
  message (Andi Shyti);
- fix include ordering nits (Krzysztof Niemiec, Jani Nikula);

 drivers/gpu/drm/i915/gt/selftest_context.c    |  20 +-
 drivers/gpu/drm/i915/gt/selftest_engine_cs.c  |   5 +-
 drivers/gpu/drm/i915/gt/selftest_engine_pm.c  |  31 ++-
 drivers/gpu/drm/i915/gt/selftest_execlists.c  | 243 +++++++++++-------
 drivers/gpu/drm/i915/gt/selftest_gt_pm.c      |  21 +-
 drivers/gpu/drm/i915/gt/selftest_migrate.c    |  47 ++--
 drivers/gpu/drm/i915/gt/selftest_mocs.c       |   7 +-
 drivers/gpu/drm/i915/gt/selftest_reset.c      |  20 +-
 drivers/gpu/drm/i915/gt/selftest_slpc.c       |  79 ++++--
 drivers/gpu/drm/i915/gt/selftest_tlb.c        |  24 +-
 .../gpu/drm/i915/gt/selftest_workarounds.c    |  70 +++--
 11 files changed, 371 insertions(+), 196 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_context.c b/drivers/gpu/drm/i915/gt/selftest_context.c
index ab76703f6e8b..4b40b6679edf 100644
--- a/drivers/gpu/drm/i915/gt/selftest_context.c
+++ b/drivers/gpu/drm/i915/gt/selftest_context.c
@@ -9,6 +9,7 @@
 #include "intel_engine_heartbeat.h"
 #include "intel_engine_pm.h"
 #include "intel_gt.h"
+#include "intel_gt_print.h"
 
 #include "gem/selftests/mock_context.h"
 #include "selftests/igt_flush_test.h"
@@ -136,7 +137,9 @@ static int __live_context_size(struct intel_engine_cs *engine)
 		goto err_unpin;
 
 	if (memchr_inv(vaddr, POISON_INUSE, I915_GTT_PAGE_SIZE)) {
-		pr_err("%s context overwrote trailing red-zone!", engine->name);
+		gt_err(engine->gt,
+		       "%s context overwrote trailing red-zone!",
+		       engine->name);
 		err = -EINVAL;
 	}
 
@@ -221,7 +224,7 @@ static int __live_active_context(struct intel_engine_cs *engine)
 		return 0;
 
 	if (intel_engine_pm_is_awake(engine)) {
-		pr_err("%s is awake before starting %s!\n",
+		gt_err(engine->gt, "%s is awake before starting %s!\n",
 		       engine->name, __func__);
 		return -EINVAL;
 	}
@@ -250,14 +253,16 @@ static int __live_active_context(struct intel_engine_cs *engine)
 
 		/* Context will be kept active until after an idle-barrier. */
 		if (i915_active_is_idle(&ce->active)) {
-			pr_err("context is not active; expected idle-barrier (%s pass %d)\n",
+			gt_err(engine->gt,
+			       "context is not active; expected idle-barrier (%s pass %d)\n",
 			       engine->name, pass);
 			err = -EINVAL;
 			goto out_engine;
 		}
 
 		if (!intel_engine_pm_is_awake(engine)) {
-			pr_err("%s is asleep before idle-barrier\n",
+			gt_err(engine->gt,
+			       "%s is asleep before idle-barrier\n",
 			       engine->name);
 			err = -EINVAL;
 			goto out_engine;
@@ -280,7 +285,7 @@ static int __live_active_context(struct intel_engine_cs *engine)
 		goto err;
 
 	if (!i915_active_is_idle(&ce->active)) {
-		pr_err("context is still active!");
+		gt_err(engine->gt, "context is still active!");
 		err = -EINVAL;
 	}
 
@@ -374,7 +379,7 @@ static int __live_remote_context(struct intel_engine_cs *engine)
 		return 0;
 
 	if (intel_engine_pm_is_awake(engine)) {
-		pr_err("%s is awake before starting %s!\n",
+		gt_err(engine->gt, "%s is awake before starting %s!\n",
 		       engine->name, __func__);
 		return -EINVAL;
 	}
@@ -403,7 +408,8 @@ static int __live_remote_context(struct intel_engine_cs *engine)
 			break;
 
 		if (i915_active_is_idle(&remote->active)) {
-			pr_err("remote context is not active; expected idle-barrier (%s pass %d)\n",
+			gt_err(engine->gt,
+			       "remote context is not active; expected idle-barrier (%s pass %d)\n",
 			       engine->name, pass);
 			err = -EINVAL;
 			break;
diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c b/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
index 5ffa5e30f419..5304331188a4 100644
--- a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
@@ -7,6 +7,7 @@
 
 #include "intel_gpu_commands.h"
 #include "intel_gt_pm.h"
+#include "intel_gt_print.h"
 #include "intel_rps.h"
 
 #include "i915_selftest.h"
@@ -207,7 +208,7 @@ static int perf_mi_bb_start(void *arg)
 		if (err)
 			break;
 
-		pr_info("%s: MI_BB_START cycles: %u\n",
+		gt_info(gt, "%s: MI_BB_START cycles: %u\n",
 			engine->name, trifilter(cycles));
 	}
 	if (perf_end(gt, wakeref))
@@ -365,7 +366,7 @@ static int perf_mi_noop(void *arg)
 		if (err)
 			break;
 
-		pr_info("%s: 16K MI_NOOP cycles: %u\n",
+		gt_info(gt, "%s: 16K MI_NOOP cycles: %u\n",
 			engine->name, trifilter(cycles));
 	}
 	if (perf_end(gt, wakeref))
diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_pm.c b/drivers/gpu/drm/i915/gt/selftest_engine_pm.c
index 10e556a7eac4..9f8dfc027b6b 100644
--- a/drivers/gpu/drm/i915/gt/selftest_engine_pm.c
+++ b/drivers/gpu/drm/i915/gt/selftest_engine_pm.c
@@ -128,8 +128,9 @@ static int __measure_timestamps(struct intel_context *ce,
 	}
 	i915_request_put(rq);
 
-	pr_debug("%s CTX_TIMESTAMP: [%x, %x], RING_TIMESTAMP: [%x, %x]\n",
-		 engine->name, sema[1], sema[3], sema[0], sema[4]);
+	gt_dbg(engine->gt,
+	       "%s CTX_TIMESTAMP: [%x, %x], RING_TIMESTAMP: [%x, %x]\n",
+	       engine->name, sema[1], sema[3], sema[0], sema[4]);
 
 	*d_ctx = sema[3] - sema[1];
 	*d_ring = sema[4] - sema[0];
@@ -159,14 +160,16 @@ static int __live_engine_timestamps(struct intel_engine_cs *engine)
 	d_ring = trifilter(s_ring);
 	d_ctx = trifilter(s_ctx);
 
-	pr_info("%s elapsed:%lldns, CTX_TIMESTAMP:%lldns, RING_TIMESTAMP:%lldns\n",
+	gt_info(engine->gt,
+		"%s elapsed:%lldns, CTX_TIMESTAMP:%lldns, RING_TIMESTAMP:%lldns\n",
 		engine->name, dt,
 		intel_gt_clock_interval_to_ns(engine->gt, d_ctx),
 		intel_gt_clock_interval_to_ns(engine->gt, d_ring));
 
 	d_ring = intel_gt_clock_interval_to_ns(engine->gt, d_ring);
 	if (3 * dt > 4 * d_ring || 4 * dt < 3 * d_ring) {
-		pr_err("%s Mismatch between ring timestamp and walltime!\n",
+		gt_err(engine->gt,
+		       "%s Mismatch between ring timestamp and walltime!\n",
 		       engine->name);
 		return -EINVAL;
 	}
@@ -181,7 +184,8 @@ static int __live_engine_timestamps(struct intel_engine_cs *engine)
 		d_ring *= engine->gt->clock_frequency;
 
 	if (3 * d_ctx > 4 * d_ring || 4 * d_ctx < 3 * d_ring) {
-		pr_err("%s Mismatch between ring and context timestamps!\n",
+		gt_err(engine->gt,
+		       "%s Mismatch between ring and context timestamps!\n",
 		       engine->name);
 		return -EINVAL;
 	}
@@ -232,7 +236,8 @@ static int __spin_until_busier(struct intel_engine_cs *engine, ktime_t busyness)
 	while (intel_engine_get_busy_time(engine, &unused) == busyness) {
 		dt = ktime_get() - start;
 		if (dt > 10000000) {
-			pr_err("active wait timed out %lld\n", dt);
+			gt_err(engine->gt,
+			       "active wait timed out %lld\n", dt);
 			ENGINE_TRACE(engine, "active wait time out %lld\n", dt);
 			return -ETIME;
 		}
@@ -284,7 +289,8 @@ static int live_engine_busy_stats(void *arg)
 		preempt_enable();
 		dt = ktime_sub(t[1], t[0]);
 		if (de < 0 || de > 10) {
-			pr_err("%s: reported %lldns [%d%%] busyness while sleeping [for %lldns]\n",
+			gt_err(gt,
+			       "%s: reported %lldns [%d%%] busyness while sleeping [for %lldns]\n",
 			       engine->name,
 			       de, (int)div64_u64(100 * de, dt), dt);
 			GEM_TRACE_DUMP();
@@ -323,7 +329,8 @@ static int live_engine_busy_stats(void *arg)
 		preempt_enable();
 		dt = ktime_sub(t[1], t[0]);
 		if (100 * de < 95 * dt || 95 * de > 100 * dt) {
-			pr_err("%s: reported %lldns [%d%%] busyness while spinning [for %lldns]\n",
+			gt_err(gt,
+			       "%s: reported %lldns [%d%%] busyness while spinning [for %lldns]\n",
 			       engine->name,
 			       de, (int)div64_u64(100 * de, dt), dt);
 			GEM_TRACE_DUMP();
@@ -358,7 +365,7 @@ static int live_engine_pm(void *arg)
 	 * tell us.
 	 */
 	if (intel_gt_pm_wait_for_idle(gt)) {
-		pr_err("Unable to flush GT pm before test\n");
+		gt_err(gt, "Unable to flush GT pm before test\n");
 		return -EBUSY;
 	}
 
@@ -386,7 +393,8 @@ static int live_engine_pm(void *arg)
 
 			p->critical_section_begin();
 			if (!intel_engine_pm_get_if_awake(engine))
-				pr_err("intel_engine_pm_get_if_awake(%s) failed under %s\n",
+				gt_err(gt,
+				       "intel_engine_pm_get_if_awake(%s) failed under %s\n",
 				       engine->name, p->name);
 			else
 				intel_engine_pm_put_async(engine);
@@ -396,7 +404,8 @@ static int live_engine_pm(void *arg)
 			intel_engine_pm_flush(engine);
 
 			if (intel_engine_pm_is_awake(engine)) {
-				pr_err("%s is still awake after flushing pm\n",
+				gt_err(gt,
+				       "%s is still awake after flushing pm\n",
 				       engine->name);
 				return -EINVAL;
 			}
diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/drm/i915/gt/selftest_execlists.c
index 21e5ed9f72a3..b2c67fdc4312 100644
--- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
+++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
@@ -10,6 +10,7 @@
 #include "gem/i915_gem_internal.h"
 #include "gem/i915_gem_pm.h"
 #include "gt/intel_engine_heartbeat.h"
+#include "gt/intel_gt_print.h"
 #include "gt/intel_reset.h"
 #include "gt/selftest_engine_heartbeat.h"
 
@@ -89,7 +90,8 @@ static int wait_for_reset(struct intel_engine_cs *engine,
 	} while (time_before(jiffies, timeout));
 
 	if (rq->fence.error != -EIO) {
-		pr_err("%s: hanging request %llx:%lld not reset\n",
+		gt_err(engine->gt,
+		       "%s: hanging request %llx:%lld not reset\n",
 		       engine->name,
 		       rq->fence.context,
 		       rq->fence.seqno);
@@ -99,7 +101,8 @@ static int wait_for_reset(struct intel_engine_cs *engine,
 	/* Give the request a jiffy to complete after flushing the worker */
 	if (i915_request_wait(rq, 0,
 			      max(0l, (long)(timeout - jiffies)) + 1) < 0) {
-		pr_err("%s: hanging request %llx:%lld did not complete\n",
+		gt_err(engine->gt,
+		       "%s: hanging request %llx:%lld did not complete\n",
 		       engine->name,
 		       rq->fence.context,
 		       rq->fence.seqno);
@@ -419,12 +422,13 @@ static int live_unlite_ring(void *arg)
 			n++;
 		}
 		intel_engine_flush_submission(engine);
-		pr_debug("%s: Filled ring with %d nop tails {size:%x, tail:%x, emit:%x, rq.tail:%x}\n",
-			 engine->name, n,
-			 ce[0]->ring->size,
-			 ce[0]->ring->tail,
-			 ce[0]->ring->emit,
-			 rq->tail);
+		gt_dbg(gt,
+		       "%s: Filled ring with %d nop tails {size:%x, tail:%x, emit:%x, rq.tail:%x}\n",
+		       engine->name, n,
+		       ce[0]->ring->size,
+		       ce[0]->ring->tail,
+		       ce[0]->ring->emit,
+		       rq->tail);
 		GEM_BUG_ON(intel_ring_direction(ce[0]->ring,
 						rq->tail,
 						ce[0]->ring->tail) <= 0);
@@ -444,15 +448,17 @@ static int live_unlite_ring(void *arg)
 		err = wait_for_submit(engine, rq, HZ / 2);
 		i915_request_put(rq);
 		if (err) {
-			pr_err("%s: preemption request was not submitted\n",
+			gt_err(gt,
+			       "%s: preemption request was not submitted\n",
 			       engine->name);
 			err = -ETIME;
 		}
 
-		pr_debug("%s: ring[0]:{ tail:%x, emit:%x }, ring[1]:{ tail:%x, emit:%x }\n",
-			 engine->name,
-			 ce[0]->ring->tail, ce[0]->ring->emit,
-			 ce[1]->ring->tail, ce[1]->ring->emit);
+		gt_dbg(gt,
+		       "%s: ring[0]:{ tail:%x, emit:%x }, ring[1]:{ tail:%x, emit:%x }\n",
+		       engine->name,
+		       ce[0]->ring->tail, ce[0]->ring->emit,
+		       ce[1]->ring->tail, ce[1]->ring->emit);
 
 err_ce:
 		intel_engine_flush_submission(engine);
@@ -644,7 +650,8 @@ static int live_hold_reset(void *arg)
 
 		/* Check that we do not resubmit the held request */
 		if (!i915_request_wait(rq, 0, HZ / 5)) {
-			pr_err("%s: on hold request completed!\n",
+			gt_err(gt,
+			       "%s: on hold request completed!\n",
 			       engine->name);
 			i915_request_put(rq);
 			err = -EIO;
@@ -655,7 +662,8 @@ static int live_hold_reset(void *arg)
 		/* But is resubmitted on release */
 		execlists_unhold(engine, rq);
 		if (i915_request_wait(rq, 0, HZ / 5) < 0) {
-			pr_err("%s: held request did not complete!\n",
+			gt_err(gt,
+			       "%s: held request did not complete!\n",
 			       engine->name);
 			intel_gt_set_wedged(gt);
 			err = -ETIME;
@@ -764,7 +772,8 @@ static int live_error_interrupt(void *arg)
 
 			err = wait_for_submit(engine, client[0], HZ / 2);
 			if (err) {
-				pr_err("%s: first request did not start within time!\n",
+				gt_err(gt,
+				       "%s: first request did not start within time!\n",
 				       engine->name);
 				err = -ETIME;
 				goto out;
@@ -772,12 +781,14 @@ static int live_error_interrupt(void *arg)
 
 			for (i = 0; i < ARRAY_SIZE(client); i++) {
 				if (i915_request_wait(client[i], 0, HZ / 5) < 0)
-					pr_debug("%s: %s request incomplete!\n",
-						 engine->name,
-						 error_repr(p->error[i]));
+					gt_dbg(gt,
+					       "%s: %s request incomplete!\n",
+					       engine->name,
+					       error_repr(p->error[i]));
 
 				if (!i915_request_started(client[i])) {
-					pr_err("%s: %s request not started!\n",
+					gt_err(gt,
+					       "%s: %s request not started!\n",
 					       engine->name,
 					       error_repr(p->error[i]));
 					err = -ETIME;
@@ -787,10 +798,13 @@ static int live_error_interrupt(void *arg)
 				/* Kick the tasklet to process the error */
 				intel_engine_flush_submission(engine);
 				if (client[i]->fence.error != p->error[i]) {
-					pr_err("%s: %s request (%s) with wrong error code: %d\n",
+					gt_err(gt,
+					       "%s: %s request (%s) with wrong error code: %d\n",
 					       engine->name,
 					       error_repr(p->error[i]),
-					       i915_request_completed(client[i]) ? "completed" : "running",
+					       i915_request_completed(client[i]) ?
+						       "completed" :
+						       "running",
 					       client[i]->fence.error);
 					err = -EINVAL;
 					goto out;
@@ -802,7 +816,8 @@ static int live_error_interrupt(void *arg)
 				if (client[i])
 					i915_request_put(client[i]);
 			if (err) {
-				pr_err("%s: failed at phase[%zd] { %d, %d }\n",
+				gt_err(gt,
+				       "%s: failed at phase[%zd] { %d, %d }\n",
 				       engine->name, p - phases,
 				       p->error[0], p->error[1]);
 				break;
@@ -964,7 +979,8 @@ slice_semaphore_queue(struct intel_engine_cs *outer,
 
 	if (i915_request_wait(head, 0,
 			      2 * outer->gt->info.num_engines * (count + 2) * (count + 3)) < 0) {
-		pr_err("%s: Failed to slice along semaphore chain of length (%d, %d)!\n",
+		gt_err(outer->gt,
+		       "%s: Failed to slice along semaphore chain of length (%d, %d)!\n",
 		       outer->name, count, n);
 		GEM_TRACE_DUMP();
 		intel_gt_set_wedged(outer->gt);
@@ -1174,7 +1190,8 @@ static int live_timeslice_rewind(void *arg)
 
 		err = wait_for_submit(engine, rq[A2], HZ / 2);
 		if (err) {
-			pr_err("%s: failed to submit first context\n",
+			gt_err(gt,
+			       "%s: failed to submit first context\n",
 			       engine->name);
 			goto err;
 		}
@@ -1192,7 +1209,8 @@ static int live_timeslice_rewind(void *arg)
 
 		err = wait_for_submit(engine, rq[B1], HZ / 2);
 		if (err) {
-			pr_err("%s: failed to submit second context\n",
+			gt_err(gt,
+			       "%s: failed to submit second context\n",
 			       engine->name);
 			goto err;
 		}
@@ -1222,18 +1240,21 @@ static int live_timeslice_rewind(void *arg)
 				;
 
 			if (!time_before(jiffies, timeout)) {
-				pr_err("%s: rq[%d] timed out\n",
+				gt_err(gt,
+				       "%s: rq[%d] timed out\n",
 				       engine->name, i - 1);
 				err = -ETIME;
 				goto err;
 			}
 
-			pr_debug("%s: slot[%d]:%x\n", engine->name, i, slot[i]);
+			gt_dbg(gt, "%s: slot[%d]:%x\n",
+			       engine->name, i, slot[i]);
 		}
 
 		/* XZY: XZ < XY */
 		if (slot[Z] - slot[X] >= slot[Y] - slot[X]) {
-			pr_err("%s: timeslicing did not run context B [%u] before A [%u]!\n",
+			gt_err(gt,
+			       "%s: timeslicing did not run context B [%u] before A [%u]!\n",
 			       engine->name,
 			       slot[Z] - slot[X],
 			       slot[Y] - slot[X]);
@@ -1347,7 +1368,8 @@ static int live_timeslice_queue(void *arg)
 		engine->sched_engine->schedule(rq, &attr);
 		err = wait_for_submit(engine, rq, HZ / 2);
 		if (err) {
-			pr_err("%s: Timed out trying to submit semaphores\n",
+			gt_err(gt,
+			       "%s: Timed out trying to submit semaphores\n",
 			       engine->name);
 			goto err_rq;
 		}
@@ -1361,7 +1383,8 @@ static int live_timeslice_queue(void *arg)
 		err = wait_for_submit(engine, nop, HZ / 2);
 		i915_request_put(nop);
 		if (err) {
-			pr_err("%s: Timed out trying to submit nop\n",
+			gt_err(gt,
+			       "%s: Timed out trying to submit nop\n",
 			       engine->name);
 			goto err_rq;
 		}
@@ -1385,7 +1408,8 @@ static int live_timeslice_queue(void *arg)
 			struct drm_printer p =
 				drm_info_printer(gt->i915->drm.dev);
 
-			pr_err("%s: Failed to timeslice into queue\n",
+			gt_err(gt,
+			       "%s: Failed to timeslice into queue\n",
 			       engine->name);
 			intel_engine_dump(engine, &p,
 					  "%s\n", engine->name);
@@ -1501,7 +1525,8 @@ static int live_timeslice_nopreempt(void *arg)
 		 * enough to see if it is timesliced in by mistake.
 		 */
 		if (i915_request_wait(rq, 0, slice_timeout(engine)) >= 0) {
-			pr_err("%s: I915_PRIORITY_BARRIER request completed, bypassing no-preempt request\n",
+			gt_err(engine->gt,
+			       "%s: I915_PRIORITY_BARRIER request completed, bypassing no-preempt request\n",
 			       engine->name);
 			err = -EINVAL;
 		}
@@ -1648,7 +1673,8 @@ static int live_busywait_preempt(void *arg)
 		/* Low priority request should be busywaiting now */
 		if (i915_request_wait(lo, 0, 1) != -ETIME) {
 			i915_request_put(lo);
-			pr_err("%s: Busywaiting request did not!\n",
+			gt_err(gt,
+			       "%s: Busywaiting request did not!\n",
 			       engine->name);
 			err = -EIO;
 			goto err_vma;
@@ -1680,7 +1706,8 @@ static int live_busywait_preempt(void *arg)
 		if (i915_request_wait(lo, 0, HZ / 5) < 0) {
 			struct drm_printer p = drm_info_printer(gt->i915->drm.dev);
 
-			pr_err("%s: Failed to preempt semaphore busywait!\n",
+			gt_err(gt,
+			       "%s: Failed to preempt semaphore busywait!\n",
 			       engine->name);
 
 			intel_engine_dump(engine, &p, "%s\n", engine->name);
@@ -1871,7 +1898,8 @@ static int live_late_preempt(void *arg)
 
 		i915_request_add(rq);
 		if (!igt_wait_for_spinner(&spin_lo, rq)) {
-			pr_err("First context failed to start\n");
+			gt_err(gt,
+			       "First context failed to start\n");
 			goto err_wedged;
 		}
 
@@ -1885,7 +1913,8 @@ static int live_late_preempt(void *arg)
 
 		i915_request_add(rq);
 		if (igt_wait_for_spinner(&spin_hi, rq)) {
-			pr_err("Second context overtook first?\n");
+			gt_err(gt,
+			       "Second context overtook first?\n");
 			goto err_wedged;
 		}
 
@@ -1893,7 +1922,8 @@ static int live_late_preempt(void *arg)
 		engine->sched_engine->schedule(rq, &attr);
 
 		if (!igt_wait_for_spinner(&spin_hi, rq)) {
-			pr_err("High priority context failed to preempt the low priority context\n");
+			gt_err(gt,
+			       "High priority context failed to preempt the low priority context\n");
 			GEM_TRACE_DUMP();
 			goto err_wedged;
 		}
@@ -1993,7 +2023,8 @@ static int live_nopreempt(void *arg)
 
 		i915_request_add(rq_a);
 		if (!igt_wait_for_spinner(&a.spin, rq_a)) {
-			pr_err("First client failed to start\n");
+			gt_err(gt,
+			       "First client failed to start\n");
 			goto err_wedged;
 		}
 
@@ -2012,21 +2043,24 @@ static int live_nopreempt(void *arg)
 
 		/* Wait long enough for preemption and timeslicing */
 		if (igt_wait_for_spinner(&b.spin, rq_b)) {
-			pr_err("Second client started too early!\n");
+			gt_err(gt,
+			       "Second client started too early!\n");
 			goto err_wedged;
 		}
 
 		igt_spinner_end(&a.spin);
 
 		if (!igt_wait_for_spinner(&b.spin, rq_b)) {
-			pr_err("Second client failed to start\n");
+			gt_err(gt,
+			       "Second client failed to start\n");
 			goto err_wedged;
 		}
 
 		igt_spinner_end(&b.spin);
 
 		if (engine->execlists.preempt_hang.count) {
-			pr_err("Preemption recorded x%d; should have been suppressed!\n",
+			gt_err(gt,
+			       "Preemption recorded x%d; should have been suppressed!\n",
 			       engine->execlists.preempt_hang.count);
 			err = -EINVAL;
 			goto err_wedged;
@@ -2058,6 +2092,7 @@ struct live_preempt_cancel {
 
 static int __cancel_active0(struct live_preempt_cancel *arg)
 {
+	struct intel_gt *gt = arg->engine->gt;
 	struct i915_request *rq;
 	struct igt_live_test t;
 	int err;
@@ -2089,7 +2124,8 @@ static int __cancel_active0(struct live_preempt_cancel *arg)
 
 	err = wait_for_reset(arg->engine, rq, HZ / 2);
 	if (err) {
-		pr_err("Cancelled inflight0 request did not reset\n");
+		gt_err(gt,
+		       "Cancelled inflight0 request did not reset\n");
 		goto out;
 	}
 
@@ -2102,6 +2138,7 @@ static int __cancel_active0(struct live_preempt_cancel *arg)
 
 static int __cancel_active1(struct live_preempt_cancel *arg)
 {
+	struct intel_gt *gt = arg->engine->gt;
 	struct i915_request *rq[2] = {};
 	struct igt_live_test t;
 	int err;
@@ -2152,13 +2189,15 @@ static int __cancel_active1(struct live_preempt_cancel *arg)
 		goto out;
 
 	if (rq[0]->fence.error != 0) {
-		pr_err("Normal inflight0 request did not complete\n");
+		gt_err(gt,
+		       "Normal inflight0 request did not complete\n");
 		err = -EINVAL;
 		goto out;
 	}
 
 	if (rq[1]->fence.error != -EIO) {
-		pr_err("Cancelled inflight1 request did not report -EIO\n");
+		gt_err(gt,
+		       "Cancelled inflight1 request did not report -EIO\n");
 		err = -EINVAL;
 		goto out;
 	}
@@ -2173,6 +2212,7 @@ static int __cancel_active1(struct live_preempt_cancel *arg)
 
 static int __cancel_queued(struct live_preempt_cancel *arg)
 {
+	struct intel_gt *gt = arg->engine->gt;
 	struct i915_request *rq[3] = {};
 	struct igt_live_test t;
 	int err;
@@ -2234,7 +2274,8 @@ static int __cancel_queued(struct live_preempt_cancel *arg)
 		goto out;
 
 	if (rq[0]->fence.error != -EIO) {
-		pr_err("Cancelled inflight0 request did not report -EIO\n");
+		gt_err(gt,
+		       "Cancelled inflight0 request did not report -EIO\n");
 		err = -EINVAL;
 		goto out;
 	}
@@ -2246,13 +2287,15 @@ static int __cancel_queued(struct live_preempt_cancel *arg)
 	 */
 	if (intel_engine_has_semaphores(rq[1]->engine) &&
 	    rq[1]->fence.error != 0) {
-		pr_err("Normal inflight1 request did not complete\n");
+		gt_err(gt,
+		       "Normal inflight1 request did not complete\n");
 		err = -EINVAL;
 		goto out;
 	}
 
 	if (rq[2]->fence.error != -EIO) {
-		pr_err("Cancelled queued request did not report -EIO\n");
+		gt_err(gt,
+		       "Cancelled queued request did not report -EIO\n");
 		err = -EINVAL;
 		goto out;
 	}
@@ -2268,6 +2311,7 @@ static int __cancel_queued(struct live_preempt_cancel *arg)
 
 static int __cancel_hostile(struct live_preempt_cancel *arg)
 {
+	struct intel_gt *gt = arg->engine->gt;
 	struct i915_request *rq;
 	int err;
 
@@ -2300,7 +2344,8 @@ static int __cancel_hostile(struct live_preempt_cancel *arg)
 
 	err = wait_for_reset(arg->engine, rq, HZ / 2);
 	if (err) {
-		pr_err("Cancelled inflight0 request did not reset\n");
+		gt_err(gt,
+		       "Cancelled inflight0 request did not reset\n");
 		goto out;
 	}
 
@@ -2371,7 +2416,8 @@ static int __cancel_fail(struct live_preempt_cancel *arg)
 	intel_engine_set_heartbeat(engine,
 				   engine->defaults.heartbeat_interval_ms);
 	if (err) {
-		pr_err("Cancelled inflight0 request did not reset\n");
+		gt_err(engine->gt,
+		       "Cancelled inflight0 request did not reset\n");
 		goto out;
 	}
 
@@ -2490,7 +2536,8 @@ static int live_suppress_self_preempt(void *arg)
 
 		i915_request_add(rq_a);
 		if (!igt_wait_for_spinner(&a.spin, rq_a)) {
-			pr_err("First client failed to start\n");
+			gt_err(gt,
+			       "First client failed to start\n");
 			st_engine_heartbeat_enable(engine);
 			goto err_wedged;
 		}
@@ -2513,7 +2560,8 @@ static int live_suppress_self_preempt(void *arg)
 			igt_spinner_end(&a.spin);
 
 			if (!igt_wait_for_spinner(&b.spin, rq_b)) {
-				pr_err("Second client failed to start\n");
+				gt_err(gt,
+				       "Second client failed to start\n");
 				st_engine_heartbeat_enable(engine);
 				goto err_wedged;
 			}
@@ -2524,7 +2572,8 @@ static int live_suppress_self_preempt(void *arg)
 		igt_spinner_end(&a.spin);
 
 		if (engine->execlists.preempt_hang.count) {
-			pr_err("Preemption on %s recorded x%d, depth %d; should have been suppressed!\n",
+			gt_err(gt,
+			       "Preemption on %s recorded x%d, depth %d; should have been suppressed!\n",
 			       engine->name,
 			       engine->execlists.preempt_hang.count,
 			       depth);
@@ -2595,12 +2644,15 @@ static int live_chain_preempt(void *arg)
 		if (ring_size < 0)
 			ring_size += rq->ring->size;
 		ring_size = rq->ring->size / ring_size;
-		pr_debug("%s(%s): Using maximum of %d requests\n",
-			 __func__, engine->name, ring_size);
+		gt_dbg(gt,
+		       "%s(%s): Using maximum of %d requests\n",
+		       __func__, engine->name, ring_size);
 
 		igt_spinner_end(&lo.spin);
 		if (i915_request_wait(rq, 0, HZ / 2) < 0) {
-			pr_err("Timed out waiting to flush %s\n", engine->name);
+			gt_err(gt,
+			       "Timed out waiting to flush %s\n",
+			       engine->name);
 			i915_request_put(rq);
 			goto err_wedged;
 		}
@@ -2648,7 +2700,8 @@ static int live_chain_preempt(void *arg)
 				struct drm_printer p =
 					drm_info_printer(gt->i915->drm.dev);
 
-				pr_err("Failed to preempt over chain of %d\n",
+				gt_err(gt,
+				       "Failed to preempt over chain of %d\n",
 				       count);
 				intel_engine_dump(engine, &p,
 						  "%s\n", engine->name);
@@ -2669,7 +2722,8 @@ static int live_chain_preempt(void *arg)
 				struct drm_printer p =
 					drm_info_printer(gt->i915->drm.dev);
 
-				pr_err("Failed to flush low priority chain of %d requests\n",
+				gt_err(gt,
+				       "Failed to flush low priority chain of %d requests\n",
 				       count);
 				intel_engine_dump(engine, &p,
 						  "%s\n", engine->name);
@@ -2867,12 +2921,13 @@ static int __live_preempt_ring(struct intel_engine_cs *engine,
 		n++;
 	}
 	intel_engine_flush_submission(engine);
-	pr_debug("%s: Filled %d with %d nop tails {size:%x, tail:%x, emit:%x, rq.tail:%x}\n",
-		 engine->name, queue_sz, n,
-		 ce[0]->ring->size,
-		 ce[0]->ring->tail,
-		 ce[0]->ring->emit,
-		 rq->tail);
+	gt_dbg(engine->gt,
+	       "%s: Filled %d with %d nop tails {size:%x, tail:%x, emit:%x, rq.tail:%x}\n",
+	       engine->name, queue_sz, n,
+	       ce[0]->ring->size,
+	       ce[0]->ring->tail,
+	       ce[0]->ring->emit,
+	       rq->tail);
 	i915_request_put(rq);
 
 	/* Create a second request to preempt the first ring */
@@ -2889,15 +2944,17 @@ static int __live_preempt_ring(struct intel_engine_cs *engine,
 	err = wait_for_submit(engine, rq, HZ / 2);
 	i915_request_put(rq);
 	if (err) {
-		pr_err("%s: preemption request was not submitted\n",
+		gt_err(engine->gt,
+		       "%s: preemption request was not submitted\n",
 		       engine->name);
 		err = -ETIME;
 	}
 
-	pr_debug("%s: ring[0]:{ tail:%x, emit:%x }, ring[1]:{ tail:%x, emit:%x }\n",
-		 engine->name,
-		 ce[0]->ring->tail, ce[0]->ring->emit,
-		 ce[1]->ring->tail, ce[1]->ring->emit);
+	gt_dbg(engine->gt,
+	       "%s: ring[0]:{ tail:%x, emit:%x }, ring[1]:{ tail:%x, emit:%x }\n",
+	       engine->name,
+	       ce[0]->ring->tail, ce[0]->ring->emit,
+	       ce[1]->ring->tail, ce[1]->ring->emit);
 
 err_ce:
 	intel_engine_flush_submission(engine);
@@ -2999,8 +3056,9 @@ static int live_preempt_gang(void *arg)
 			engine->sched_engine->schedule(rq, &attr);
 		} while (prio <= I915_PRIORITY_MAX &&
 			 !__igt_timeout(end_time, NULL));
-		pr_debug("%s: Preempt chain of %d requests\n",
-			 engine->name, prio);
+		gt_dbg(gt,
+		       "%s: Preempt chain of %d requests\n", engine->name,
+		       prio);
 
 		/*
 		 * Such that the last spinner is the highest priority and
@@ -3024,7 +3082,8 @@ static int live_preempt_gang(void *arg)
 				struct drm_printer p =
 					drm_info_printer(engine->i915->drm.dev);
 
-				pr_err("Failed to flush chain of %d requests, at %d\n",
+				gt_err(gt,
+				       "Failed to flush chain of %d requests, at %d\n",
 				       prio, rq_prio(rq));
 				intel_engine_dump(engine, &p,
 						  "%s\n", engine->name);
@@ -3319,7 +3378,8 @@ static int live_preempt_user(void *arg)
 		}
 
 		if (READ_ONCE(result[0]) != NUM_GPR) {
-			pr_err("%s: Failed to release semaphore\n",
+			gt_err(gt,
+			       "%s: Failed to release semaphore\n",
 			       engine->name);
 			err = -EIO;
 			goto end_test;
@@ -3335,9 +3395,10 @@ static int live_preempt_user(void *arg)
 
 			for (gpr = 1; gpr < NUM_GPR; gpr++) {
 				if (result[NUM_GPR * i + gpr] != 1) {
-					pr_err("%s: Invalid result, client %d, gpr %d, result: %d\n",
-					       engine->name,
-					       i, gpr, result[NUM_GPR * i + gpr]);
+					gt_err(gt,
+					       "%s: Invalid result, client %d, gpr %d, result: %d\n",
+					       engine->name, i, gpr,
+					       result[NUM_GPR * i + gpr]);
 					err = -EINVAL;
 					goto end_test;
 				}
@@ -3601,7 +3662,8 @@ static int smoke_crescendo(struct preempt_smoke *smoke, unsigned int flags)
 		kthread_destroy_worker(worker[id]);
 	}
 
-	pr_info("Submitted %lu crescendo:%x requests across %d engines and %d contexts\n",
+	gt_info(smoke->gt,
+		"Submitted %lu crescendo:%x requests across %d engines and %d contexts\n",
 		count, flags, smoke->gt->info.num_engines, smoke->ncontext);
 
 	kfree(arg);
@@ -3630,7 +3692,8 @@ static int smoke_random(struct preempt_smoke *smoke, unsigned int flags)
 		}
 	} while (count < smoke->ncontext && !__igt_timeout(end_time, NULL));
 
-	pr_info("Submitted %lu random:%x requests across %d engines and %d contexts\n",
+	gt_info(smoke->gt,
+		"Submitted %lu random:%x requests across %d engines and %d contexts\n",
 		count, flags, smoke->gt->info.num_engines, smoke->ncontext);
 	return 0;
 }
@@ -3787,7 +3850,8 @@ static int nop_virtual_engine(struct intel_gt *gt,
 
 		for (nc = 0; nc < nctx; nc++) {
 			if (i915_request_wait(request[nc], 0, HZ / 10) < 0) {
-				pr_err("%s(%s): wait for %llx:%lld timed out\n",
+				gt_err(gt,
+				       "%s(%s): wait for %llx:%lld timed out\n",
 				       __func__, ve[0]->engine->name,
 				       request[nc]->fence.context,
 				       request[nc]->fence.seqno);
@@ -3819,7 +3883,8 @@ static int nop_virtual_engine(struct intel_gt *gt,
 	if (err)
 		goto out;
 
-	pr_info("Requestx%d latencies on %s: 1 = %lluns, %lu = %lluns\n",
+	gt_info(gt,
+		"Requestx%d latencies on %s: 1 = %lluns, %lu = %lluns\n",
 		nctx, ve[0]->engine->name, ktime_to_ns(times[0]),
 		prime, div64_u64(ktime_to_ns(times[1]), prime));
 
@@ -3880,7 +3945,8 @@ static int live_virtual_engine(void *arg)
 	for_each_engine(engine, gt, id) {
 		err = nop_virtual_engine(gt, &engine, 1, 1, 0);
 		if (err) {
-			pr_err("Failed to wrap engine %s: err=%d\n",
+			gt_err(engine->gt,
+			       "Failed to wrap engine %s: err=%d\n",
 			       engine->name, err);
 			return err;
 		}
@@ -3954,7 +4020,8 @@ static int mask_virtual_engine(struct intel_gt *gt,
 
 	for (n = 0; n < nsibling; n++) {
 		if (i915_request_wait(request[n], 0, HZ / 10) < 0) {
-			pr_err("%s(%s): wait for %llx:%lld timed out\n",
+			gt_err(gt,
+			       "%s(%s): wait for %llx:%lld timed out\n",
 			       __func__, ve->engine->name,
 			       request[n]->fence.context,
 			       request[n]->fence.seqno);
@@ -3970,7 +4037,8 @@ static int mask_virtual_engine(struct intel_gt *gt,
 		}
 
 		if (request[n]->engine != siblings[nsibling - n - 1]) {
-			pr_err("Executed on wrong sibling '%s', expected '%s'\n",
+			gt_err(gt,
+			       "Executed on wrong sibling '%s', expected '%s'\n",
 			       request[n]->engine->name,
 			       siblings[nsibling - n - 1]->name);
 			err = -EINVAL;
@@ -4272,7 +4340,8 @@ static int preserved_virtual_engine(struct intel_gt *gt,
 
 	for (n = 0; n < NUM_GPR_DW; n++) {
 		if (cs[n] != n) {
-			pr_err("Incorrect value[%d] found for GPR[%d]\n",
+			gt_err(gt,
+			       "Incorrect value[%d] found for GPR[%d]\n",
 			       cs[n], n);
 			err = -EINVAL;
 			break;
@@ -4400,7 +4469,7 @@ static int reset_virtual_engine(struct intel_gt *gt,
 	/* Check that we do not resubmit the held request */
 	i915_request_get(rq);
 	if (!i915_request_wait(rq, 0, HZ / 5)) {
-		pr_err("%s: on hold request completed!\n",
+		gt_err(gt, "%s: on hold request completed!\n",
 		       engine->name);
 		intel_gt_set_wedged(gt);
 		err = -EIO;
@@ -4411,8 +4480,8 @@ static int reset_virtual_engine(struct intel_gt *gt,
 	/* But is resubmitted on release */
 	execlists_unhold(engine, rq);
 	if (i915_request_wait(rq, 0, HZ / 5) < 0) {
-		pr_err("%s: held request did not complete!\n",
-		       engine->name);
+		gt_err(gt,
+		       "%s: held request did not complete!\n", engine->name);
 		intel_gt_set_wedged(gt);
 		err = -ETIME;
 	}
diff --git a/drivers/gpu/drm/i915/gt/selftest_gt_pm.c b/drivers/gpu/drm/i915/gt/selftest_gt_pm.c
index 07eaf71955c4..cb1ce386e09f 100644
--- a/drivers/gpu/drm/i915/gt/selftest_gt_pm.c
+++ b/drivers/gpu/drm/i915/gt/selftest_gt_pm.c
@@ -7,6 +7,7 @@
 
 #include "intel_engine_regs.h"
 #include "intel_gt_clock_utils.h"
+#include "intel_gt_print.h"
 
 #include "selftest_llc.h"
 #include "selftest_rc6.h"
@@ -85,7 +86,7 @@ static int live_gt_clocks(void *arg)
 	int err = 0;
 
 	if (!gt->clock_frequency) { /* unknown */
-		pr_info("CS_TIMESTAMP frequency unknown\n");
+		gt_info(gt, "CS_TIMESTAMP frequency unknown\n");
 		return 0;
 	}
 
@@ -109,19 +110,22 @@ static int live_gt_clocks(void *arg)
 		time = intel_gt_clock_interval_to_ns(engine->gt, cycles);
 		expected = intel_gt_ns_to_clock_interval(engine->gt, dt);
 
-		pr_info("%s: TIMESTAMP %d cycles [%lldns] in %lldns [%d cycles], using CS clock frequency of %uKHz\n",
+		gt_info(gt,
+			"%s: TIMESTAMP %d cycles [%lldns] in %lldns [%d cycles], using CS clock frequency of %uKHz\n",
 			engine->name, cycles, time, dt, expected,
 			engine->gt->clock_frequency / 1000);
 
 		if (9 * time < 8 * dt || 8 * time > 9 * dt) {
-			pr_err("%s: CS ticks did not match walltime!\n",
+			gt_err(gt,
+			       "%s: CS ticks did not match walltime!\n",
 			       engine->name);
 			err = -EINVAL;
 			break;
 		}
 
 		if (9 * expected < 8 * cycles || 8 * expected > 9 * cycles) {
-			pr_err("%s: walltime did not match CS ticks!\n",
+			gt_err(gt,
+			       "%s: walltime did not match CS ticks!\n",
 			       engine->name);
 			err = -EINVAL;
 			break;
@@ -146,7 +150,8 @@ static int live_gt_resume(void *arg)
 		intel_gt_suspend_late(gt);
 
 		if (gt->rc6.enabled) {
-			pr_err("rc6 still enabled after suspend!\n");
+			gt_err(gt,
+			       "rc6 still enabled after suspend!\n");
 			intel_gt_set_wedged_on_init(gt);
 			err = -EINVAL;
 			break;
@@ -157,7 +162,8 @@ static int live_gt_resume(void *arg)
 			break;
 
 		if (gt->rc6.supported && !gt->rc6.enabled) {
-			pr_err("rc6 not enabled upon resume!\n");
+			gt_err(gt,
+			       "rc6 not enabled upon resume!\n");
 			intel_gt_set_wedged_on_init(gt);
 			err = -EINVAL;
 			break;
@@ -165,7 +171,8 @@ static int live_gt_resume(void *arg)
 
 		err = st_llc_verify(&gt->llc);
 		if (err) {
-			pr_err("llc state not restored upon resume!\n");
+			gt_err(gt,
+			       "llc state not restored upon resume!\n");
 			intel_gt_set_wedged_on_init(gt);
 			break;
 		}
diff --git a/drivers/gpu/drm/i915/gt/selftest_migrate.c b/drivers/gpu/drm/i915/gt/selftest_migrate.c
index 5b986a7687d9..44cb2b4fb3c1 100644
--- a/drivers/gpu/drm/i915/gt/selftest_migrate.c
+++ b/drivers/gpu/drm/i915/gt/selftest_migrate.c
@@ -11,6 +11,8 @@
 #include "selftests/igt_spinner.h"
 #include "selftests/i915_random.h"
 
+#include "intel_gt_print.h"
+
 static const unsigned int sizes[] = {
 	SZ_4K,
 	SZ_64K,
@@ -42,6 +44,7 @@ static int copy(struct intel_migrate *migrate,
 		u32 sz, struct rnd_state *prng)
 {
 	struct drm_i915_private *i915 = migrate->context->engine->i915;
+	struct intel_gt *gt = migrate->context->engine->gt;
 	struct drm_i915_gem_object *src, *dst;
 	struct i915_request *rq;
 	struct i915_gem_ww_ctx ww;
@@ -92,7 +95,7 @@ static int copy(struct intel_migrate *migrate,
 			continue;
 
 		if (err != -EDEADLK && err != -EINTR && err != -ERESTARTSYS)
-			pr_err("%ps failed, size: %u\n", fn, sz);
+			gt_err(gt, "%ps failed, size: %u\n", fn, sz);
 		if (rq) {
 			i915_request_wait(rq, 0, HZ);
 			i915_request_put(rq);
@@ -106,7 +109,8 @@ static int copy(struct intel_migrate *migrate,
 
 	if (rq) {
 		if (i915_request_wait(rq, 0, HZ) < 0) {
-			pr_err("%ps timed out, size: %u\n", fn, sz);
+			gt_err(gt, "%ps timed out, size: %u\n", fn,
+			       sz);
 			err = -ETIME;
 		}
 		i915_request_put(rq);
@@ -116,7 +120,8 @@ static int copy(struct intel_migrate *migrate,
 		int x = i * 1024 + i915_prandom_u32_max_state(1024, prng);
 
 		if (vaddr[x] != x) {
-			pr_err("%ps failed, size: %u, offset: %zu\n",
+			gt_err(gt,
+			       "%ps failed, size: %u, offset: %zu\n",
 			       fn, sz, x * sizeof(u32));
 			igt_hexdump(vaddr + i * 1024, 4096);
 			err = -EINVAL;
@@ -261,6 +266,7 @@ static int clear(struct intel_migrate *migrate,
 		 u32 sz, struct rnd_state *prng)
 {
 	struct drm_i915_private *i915 = migrate->context->engine->i915;
+	struct intel_gt *gt = migrate->context->engine->gt;
 	struct drm_i915_gem_object *obj;
 	struct i915_request *rq = NULL;
 	struct i915_gem_ww_ctx ww;
@@ -304,7 +310,8 @@ static int clear(struct intel_migrate *migrate,
 						     true, &rq);
 			if (rq && !err) {
 				if (i915_request_wait(rq, 0, HZ) < 0) {
-					pr_err("%ps timed out, size: %u\n",
+					gt_err(gt,
+					       "%ps timed out, size: %u\n",
 					       fn, sz);
 					err = -ETIME;
 				}
@@ -318,7 +325,8 @@ static int clear(struct intel_migrate *migrate,
 		err = fn(migrate, &ww, obj, val, &rq);
 		if (rq && !err) {
 			if (i915_request_wait(rq, 0, HZ) < 0) {
-				pr_err("%ps timed out, size: %u\n", fn, sz);
+				gt_err(gt, "%ps timed out, size: %u\n",
+				       fn, sz);
 				err = -ETIME;
 			}
 			i915_request_put(rq);
@@ -335,7 +343,8 @@ static int clear(struct intel_migrate *migrate,
 				i915_prandom_u32_max_state(1024, prng);
 
 			if (vaddr[x] != val) {
-				pr_err("%ps failed, (%u != %u), offset: %zu\n",
+				gt_err(gt,
+				       "%ps failed, (%u != %u), offset: %zu\n",
 				       fn, vaddr[x], val, x * sizeof(u32));
 				igt_hexdump(vaddr + i * 1024, 4096);
 				err = -EINVAL;
@@ -355,7 +364,8 @@ static int clear(struct intel_migrate *migrate,
 						     false, &rq);
 			if (rq && !err) {
 				if (i915_request_wait(rq, 0, HZ) < 0) {
-					pr_err("%ps timed out, size: %u\n",
+					gt_err(gt,
+					       "%ps timed out, size: %u\n",
 					       fn, sz);
 					err = -ETIME;
 				}
@@ -377,8 +387,11 @@ static int clear(struct intel_migrate *migrate,
 									 ccs_bytes_left), prng);
 
 				if (vaddr[offset + x]) {
-					pr_err("%ps ccs clearing failed, offset: %ld/%d\n",
-					       fn, i * PAGE_SIZE + x * sizeof(u32), ccs_bytes);
+					gt_err(gt,
+					       "%ps ccs clearing failed, offset: %ld/%d\n",
+					       fn,
+					       i * PAGE_SIZE + x * sizeof(u32),
+					       ccs_bytes);
 					igt_hexdump(vaddr + offset,
 						    min_t(int, 4096,
 							  ccs_bytes_left * sizeof(u32)));
@@ -394,7 +407,7 @@ static int clear(struct intel_migrate *migrate,
 
 	if (err) {
 		if (err != -EDEADLK && err != -EINTR && err != -ERESTARTSYS)
-			pr_err("%ps failed, size: %u\n", fn, sz);
+			gt_err(gt, "%ps failed, size: %u\n", fn, sz);
 		if (rq && err != -EINVAL) {
 			i915_request_wait(rq, 0, HZ);
 			i915_request_put(rq);
@@ -540,7 +553,7 @@ static void spinner_kill(struct timer_list *timer)
 	struct spinner_timer *st = timer_container_of(st, timer, timer);
 
 	igt_spinner_end(&st->spin);
-	pr_info("%s\n", __func__);
+	gt_info(st->spin.gt, "%s: killing spinner\n", __func__);
 }
 
 static int live_emit_pte_full_ring(void *arg)
@@ -633,7 +646,8 @@ static int live_emit_pte_full_ring(void *arg)
 		cs += sz;
 		intel_ring_advance(rq, cs);
 
-		pr_info("%s emit=%u sz=%d\n", __func__, rq->ring->emit, sz);
+		gt_info(gt, "%s emit=%u sz=%d\n", __func__,
+			rq->ring->emit, sz);
 
 		prev = rq;
 	} while (rq->ring->space > (rq->reserved_space +
@@ -646,7 +660,8 @@ static int live_emit_pte_full_ring(void *arg)
 	 * This should wait for the spinner to be killed, otherwise we should go
 	 * down in flames when doing i915_request_add().
 	 */
-	pr_info("%s emite_pte ring space=%u\n", __func__, rq->ring->space);
+	gt_info(gt, "%s emite_pte ring space=%u\n", __func__,
+		rq->ring->space);
 	it = sg_sgt(obj->mm.pages->sgl);
 	len = emit_pte(rq, &it, obj->pat_index, false, 0, CHUNK_SZ);
 	if (!len) {
@@ -853,6 +868,7 @@ static int __perf_clear_blt(struct intel_context *ce,
 			    bool is_lmem,
 			    size_t sz)
 {
+	struct intel_gt *gt = ce->engine->gt;
 	ktime_t t[5];
 	int pass;
 	int err = 0;
@@ -880,7 +896,7 @@ static int __perf_clear_blt(struct intel_context *ce,
 		return err;
 
 	sort(t, ARRAY_SIZE(t), sizeof(*t), wrap_ktime_compare, NULL);
-	pr_info("%s: %zd KiB fill: %lld MiB/s\n",
+	gt_info(gt, "%s: %zd KiB fill: %lld MiB/s\n",
 		ce->engine->name, sz >> 10,
 		div64_u64(mul_u32_u32(4 * sz,
 				      1000 * 1000 * 1000),
@@ -932,6 +948,7 @@ static int __perf_copy_blt(struct intel_context *ce,
 			   bool dst_is_lmem,
 			   size_t sz)
 {
+	struct intel_gt *gt = ce->engine->gt;
 	ktime_t t[5];
 	int pass;
 	int err = 0;
@@ -963,7 +980,7 @@ static int __perf_copy_blt(struct intel_context *ce,
 		return err;
 
 	sort(t, ARRAY_SIZE(t), sizeof(*t), wrap_ktime_compare, NULL);
-	pr_info("%s: %zd KiB copy: %lld MiB/s\n",
+	gt_info(gt, "%s: %zd KiB copy: %lld MiB/s\n",
 		ce->engine->name, sz >> 10,
 		div64_u64(mul_u32_u32(4 * sz,
 				      1000 * 1000 * 1000),
diff --git a/drivers/gpu/drm/i915/gt/selftest_mocs.c b/drivers/gpu/drm/i915/gt/selftest_mocs.c
index d73e438fb85f..97a6bcdf273d 100644
--- a/drivers/gpu/drm/i915/gt/selftest_mocs.c
+++ b/drivers/gpu/drm/i915/gt/selftest_mocs.c
@@ -5,6 +5,7 @@
 
 #include "gt/intel_engine_pm.h"
 #include "gt/intel_gpu_commands.h"
+#include "gt/intel_gt_print.h"
 #include "i915_selftest.h"
 
 #include "gem/selftests/igt_gem_utils.h"
@@ -169,7 +170,8 @@ static int check_mocs_table(struct intel_engine_cs *engine,
 
 	for_each_mocs(expect, table, i) {
 		if (**vaddr != expect) {
-			pr_err("%s: Invalid MOCS[%d] entry, found %08x, expected %08x\n",
+			gt_err(engine->gt,
+			       "%s: Invalid MOCS[%d] entry, found %08x, expected %08x\n",
 			       engine->name, i, **vaddr, expect);
 			return -EINVAL;
 		}
@@ -203,7 +205,8 @@ static int check_l3cc_table(struct intel_engine_cs *engine,
 
 	for_each_l3cc(expect, table, i) {
 		if (!mcr_range(engine->i915, reg) && **vaddr != expect) {
-			pr_err("%s: Invalid L3CC[%d] entry, found %08x, expected %08x\n",
+			gt_err(engine->gt,
+			       "%s: Invalid L3CC[%d] entry, found %08x, expected %08x\n",
 			       engine->name, i, **vaddr, expect);
 			return -EINVAL;
 		}
diff --git a/drivers/gpu/drm/i915/gt/selftest_reset.c b/drivers/gpu/drm/i915/gt/selftest_reset.c
index 2cfc23c58e90..bf8b316f0b92 100644
--- a/drivers/gpu/drm/i915/gt/selftest_reset.c
+++ b/drivers/gpu/drm/i915/gt/selftest_reset.c
@@ -10,6 +10,7 @@
 #include "i915_memcpy.h"
 #include "i915_selftest.h"
 #include "intel_gpu_commands.h"
+#include "intel_gt_print.h"
 #include "selftests/igt_reset.h"
 #include "selftests/igt_atomic.h"
 #include "selftests/igt_spinner.h"
@@ -147,8 +148,9 @@ __igt_reset_stolen(struct intel_gt *gt,
 		    !__drm_mm_interval_first(&gt->i915->mm.stolen,
 					     page << PAGE_SHIFT,
 					     ((page + 1) << PAGE_SHIFT) - 1)) {
-			pr_debug("unused stolen page %pa modified by GPU reset\n",
-				 &page);
+			gt_dbg(gt,
+			       "unused stolen page %pa modified by GPU reset\n",
+			       &page);
 			if (count++ == 0)
 				igt_hexdump(in, PAGE_SIZE);
 			max = page;
@@ -160,11 +162,13 @@ __igt_reset_stolen(struct intel_gt *gt,
 	ggtt->vm.clear_range(&ggtt->vm, ggtt->error_capture.start, PAGE_SIZE);
 
 	if (count > 0) {
-		pr_info("%s reset clobbered %ld pages of stolen, last clobber at page %ld\n",
+		gt_info(gt,
+			"%s reset clobbered %ld pages of stolen, last clobber at page %ld\n",
 			msg, count, max);
 	}
 	if (max >= I915_GEM_STOLEN_BIAS >> PAGE_SHIFT) {
-		pr_err("%s reset clobbered unreserved area [above %x] of stolen; may cause severe faults\n",
+		gt_err(gt,
+		       "%s reset clobbered unreserved area [above %x] of stolen; may cause severe faults\n",
 		       msg, I915_GEM_STOLEN_BIAS);
 		err = -EINVAL;
 	}
@@ -223,7 +227,7 @@ static int igt_global_reset(void *arg)
 	intel_gt_reset(gt, ALL_ENGINES, NULL);
 
 	if (i915_reset_count(&gt->i915->gpu_error) == reset_count) {
-		pr_err("No GPU reset recorded!\n");
+		gt_err(gt, "No GPU reset recorded!\n");
 		err = -EINVAL;
 	}
 
@@ -287,7 +291,8 @@ static int igt_atomic_reset(void *arg)
 		reset_finish(gt, awake);
 
 		if (err) {
-			pr_err("__intel_gt_reset failed under %s\n", p->name);
+			gt_err(gt,
+			       "__intel_gt_reset failed under %s\n", p->name);
 			break;
 		}
 	}
@@ -347,7 +352,8 @@ static int igt_atomic_engine_reset(void *arg)
 				local_bh_enable();
 
 			if (err) {
-				pr_err("intel_engine_reset(%s) failed under %s\n",
+				gt_err(engine->gt,
+				       "intel_engine_reset(%s) failed under %s\n",
 				       engine->name, p->name);
 				break;
 			}
diff --git a/drivers/gpu/drm/i915/gt/selftest_slpc.c b/drivers/gpu/drm/i915/gt/selftest_slpc.c
index c3c918248989..d65f06826930 100644
--- a/drivers/gpu/drm/i915/gt/selftest_slpc.c
+++ b/drivers/gpu/drm/i915/gt/selftest_slpc.c
@@ -3,6 +3,9 @@
  * Copyright © 2021 Intel Corporation
  */
 
+#include "intel_gt_print.h"
+#include "uc/intel_guc.h"
+
 #define NUM_STEPS 5
 #define H2G_DELAY 50000
 #define delay_for_h2g() usleep_range(H2G_DELAY, H2G_DELAY + 10000)
@@ -23,13 +26,22 @@ struct slpc_thread {
 	int result;
 };
 
+static struct intel_gt *selftest_slpc_to_gt(struct intel_guc_slpc *slpc)
+{
+	struct intel_guc *guc = container_of(slpc, struct intel_guc, slpc);
+
+	return guc_to_gt(guc);
+}
+
 static int slpc_set_min_freq(struct intel_guc_slpc *slpc, u32 freq)
 {
+	struct intel_gt *gt = selftest_slpc_to_gt(slpc);
 	int ret;
 
 	ret = intel_guc_slpc_set_min_freq(slpc, freq);
 	if (ret)
-		pr_err("Could not set min frequency to [%u]\n", freq);
+		gt_err(gt, "Could not set min frequency to [%u]\n",
+		       freq);
 	else /* Delay to ensure h2g completes */
 		delay_for_h2g();
 
@@ -38,11 +50,13 @@ static int slpc_set_min_freq(struct intel_guc_slpc *slpc, u32 freq)
 
 static int slpc_set_max_freq(struct intel_guc_slpc *slpc, u32 freq)
 {
+	struct intel_gt *gt = selftest_slpc_to_gt(slpc);
 	int ret;
 
 	ret = intel_guc_slpc_set_max_freq(slpc, freq);
 	if (ret)
-		pr_err("Could not set maximum frequency [%u]\n",
+		gt_err(gt,
+		       "Could not set maximum frequency [%u]\n",
 		       freq);
 	else /* Delay to ensure h2g completes */
 		delay_for_h2g();
@@ -57,13 +71,13 @@ static int slpc_set_freq(struct intel_gt *gt, u32 freq)
 
 	err = slpc_set_max_freq(slpc, freq);
 	if (err) {
-		pr_err("Unable to update max freq");
+		gt_err(gt, "Unable to update max freq");
 		return err;
 	}
 
 	err = slpc_set_min_freq(slpc, freq);
 	if (err) {
-		pr_err("Unable to update min freq");
+		gt_err(gt, "Unable to update min freq");
 		return err;
 	}
 
@@ -72,23 +86,24 @@ static int slpc_set_freq(struct intel_gt *gt, u32 freq)
 
 static int slpc_restore_freq(struct intel_guc_slpc *slpc, u32 min, u32 max)
 {
+	struct intel_gt *gt = selftest_slpc_to_gt(slpc);
 	int err;
 
 	err = slpc_set_max_freq(slpc, max);
 	if (err) {
-		pr_err("Unable to restore max freq");
+		gt_err(gt, "Unable to restore max freq");
 		return err;
 	}
 
 	err = slpc_set_min_freq(slpc, min);
 	if (err) {
-		pr_err("Unable to restore min freq");
+		gt_err(gt, "Unable to restore min freq");
 		return err;
 	}
 
 	err = intel_guc_slpc_set_ignore_eff_freq(slpc, false);
 	if (err) {
-		pr_err("Unable to restore efficient freq");
+		gt_err(gt, "Unable to restore efficient freq");
 		return err;
 	}
 
@@ -143,7 +158,8 @@ static int vary_max_freq(struct intel_guc_slpc *slpc, struct intel_rps *rps,
 
 		/* GuC requests freq in multiples of 50/3 MHz */
 		if (req_freq > (max_freq + FREQUENCY_REQ_UNIT)) {
-			pr_err("SWReq is %d, should be at most %d\n", req_freq,
+			gt_err(rps_to_gt(rps),
+			       "SWReq is %d, should be at most %d\n", req_freq,
 			       max_freq + FREQUENCY_REQ_UNIT);
 			err = -EINVAL;
 		}
@@ -179,8 +195,9 @@ static int vary_min_freq(struct intel_guc_slpc *slpc, struct intel_rps *rps,
 
 		/* GuC requests freq in multiples of 50/3 MHz */
 		if (req_freq < (min_freq - FREQUENCY_REQ_UNIT)) {
-			pr_err("SWReq is %d, should be at least %d\n", req_freq,
-			       min_freq - FREQUENCY_REQ_UNIT);
+			gt_err(rps_to_gt(rps),
+			       "SWReq is %d, should be at least %d\n",
+			       req_freq, min_freq - FREQUENCY_REQ_UNIT);
 			err = -EINVAL;
 		}
 
@@ -224,18 +241,21 @@ static int slpc_power(struct intel_gt *gt, struct intel_engine_cs *engine)
 	if (err)
 		return err;
 
-	pr_info("%s: min:%llumW @ %uMHz, max:%llumW @ %uMHz\n",
+	gt_info(gt,
+		"%s: min:%llumW @ %uMHz, max:%llumW @ %uMHz\n",
 		engine->name,
 		min.power, min.freq,
 		max.power, max.freq);
 
 	if (10 * min.freq >= 9 * max.freq) {
-		pr_notice("Could not control frequency, ran at [%uMHz, %uMhz]\n",
+		gt_notice(gt,
+			  "Could not control frequency, ran at [%uMHz, %uMhz]\n",
 			  min.freq, max.freq);
 	}
 
 	if (11 * min.power > 10 * max.power) {
-		pr_err("%s: did not conserve power when setting lower frequency!\n",
+		gt_err(gt,
+		       "%s: did not conserve power when setting lower frequency!\n",
 		       engine->name);
 		err = -EINVAL;
 	}
@@ -265,10 +285,13 @@ static int max_granted_freq(struct intel_guc_slpc *slpc, struct intel_rps *rps,
 
 		/* If not, this is an error */
 		if (!(perf_limit_reasons & GT0_PERF_LIMIT_REASONS_MASK)) {
-			pr_err("Pcode did not grant max freq\n");
+			gt_err(gt,
+			       "Pcode did not grant max freq\n");
 			err = -EINVAL;
 		} else {
-			pr_info("Pcode throttled frequency 0x%x\n", perf_limit_reasons);
+			gt_info(gt,
+				"Pcode throttled frequency 0x%x\n",
+				perf_limit_reasons);
 		}
 	}
 
@@ -290,7 +313,8 @@ static int run_test(struct intel_gt *gt, int test_type)
 		return 0;
 
 	if (slpc->min_freq == slpc->rp0_freq) {
-		pr_err("Min/Max are fused to the same value\n");
+		gt_err(gt,
+		       "Min/Max are fused to the same value\n");
 		return -EINVAL;
 	}
 
@@ -298,12 +322,12 @@ static int run_test(struct intel_gt *gt, int test_type)
 		return -ENOMEM;
 
 	if (intel_guc_slpc_get_max_freq(slpc, &slpc_max_freq)) {
-		pr_err("Could not get SLPC max freq\n");
+		gt_err(gt, "Could not get SLPC max freq\n");
 		return -EIO;
 	}
 
 	if (intel_guc_slpc_get_min_freq(slpc, &slpc_min_freq)) {
-		pr_err("Could not get SLPC min freq\n");
+		gt_err(gt, "Could not get SLPC min freq\n");
 		return -EIO;
 	}
 
@@ -313,7 +337,7 @@ static int run_test(struct intel_gt *gt, int test_type)
 	 */
 	err = slpc_set_min_freq(slpc, slpc->min_freq);
 	if (err) {
-		pr_err("Unable to update min freq!");
+		gt_err(gt, "Unable to update min freq!");
 		return err;
 	}
 
@@ -322,7 +346,7 @@ static int run_test(struct intel_gt *gt, int test_type)
 	 */
 	err = intel_guc_slpc_set_ignore_eff_freq(slpc, true);
 	if (err) {
-		pr_err("Unable to turn off efficient freq!");
+		gt_err(gt, "Unable to turn off efficient freq!");
 		return err;
 	}
 
@@ -349,8 +373,8 @@ static int run_test(struct intel_gt *gt, int test_type)
 		i915_request_add(rq);
 
 		if (!igt_wait_for_spinner(&spin, rq)) {
-			pr_err("%s: Spinner did not start\n",
-			       engine->name);
+			gt_err(gt,
+			       "%s: Spinner did not start\n", engine->name);
 			igt_spinner_end(&spin);
 			st_engine_heartbeat_enable(engine);
 			intel_gt_set_wedged(engine->gt);
@@ -387,13 +411,16 @@ static int run_test(struct intel_gt *gt, int test_type)
 		}
 
 		if (test_type != SLPC_POWER) {
-			pr_info("Max actual frequency for %s was %d\n",
+			gt_info(gt,
+				"%s: Max actual frequency was %d\n",
 				engine->name, max_act_freq);
 
 			/* Actual frequency should rise above min */
 			if (max_act_freq <= slpc->min_freq) {
-				pr_err("Actual freq did not rise above min\n");
-				pr_err("Perf Limit Reasons: 0x%x\n",
+				gt_err(gt,
+				       "Actual freq did not rise above min\n");
+				gt_err(gt,
+				       "Perf Limit Reasons: 0x%x\n",
 				       intel_uncore_read(gt->uncore,
 							 intel_gt_perf_limit_reasons_reg(gt)));
 				err = -EINVAL;
@@ -525,7 +552,7 @@ static int live_slpc_tile_interaction(void *arg)
 		kthread_flush_work(&threads[i].work);
 		status = READ_ONCE(threads[i].result);
 		if (status && !ret) {
-			pr_err("%s GT %d failed ", __func__, gt->info.id);
+			gt_err(gt, "failed in %s\n", __func__);
 			ret = status;
 		}
 		kthread_destroy_worker(threads[i].worker);
diff --git a/drivers/gpu/drm/i915/gt/selftest_tlb.c b/drivers/gpu/drm/i915/gt/selftest_tlb.c
index a5184f09d1de..fa43fa99281f 100644
--- a/drivers/gpu/drm/i915/gt/selftest_tlb.c
+++ b/drivers/gpu/drm/i915/gt/selftest_tlb.c
@@ -15,6 +15,7 @@
 #include "intel_engine_regs.h"
 #include "intel_gpu_commands.h"
 #include "intel_gt.h"
+#include "intel_gt_print.h"
 #include "intel_ring.h"
 
 #include "selftests/igt_flush_test.h"
@@ -40,6 +41,7 @@ pte_tlbinv(struct intel_context *ce,
 	const unsigned int pat_index =
 		i915_gem_get_pat_index(ce->vm->i915, I915_CACHE_NONE);
 	struct drm_i915_gem_object *batch;
+	struct intel_gt *gt = ce->engine->gt;
 	struct drm_mm_node vb_node;
 	struct i915_request *rq;
 	struct i915_vma *vma;
@@ -68,7 +70,8 @@ pte_tlbinv(struct intel_context *ce,
 				 va->size, align);
 	err = i915_vma_pin(va,  0, 0, addr | PIN_OFFSET_FIXED | PIN_USER);
 	if (err) {
-		pr_err("Cannot pin at %llx+%llx\n", addr, va->size);
+		gt_err(gt, "Cannot pin at %llx+%llx\n",
+		       addr, va->size);
 		goto out;
 	}
 	GEM_BUG_ON(i915_vma_offset(va) != addr);
@@ -91,7 +94,8 @@ pte_tlbinv(struct intel_context *ce,
 	addr = igt_random_offset(prng, addr, addr + align, 8, 8);
 
 	if (va != vb)
-		pr_info("%s(%s): Sampling %llx, with alignment %llx, using PTE size %x (phys %x, sg %x), invalidate:%llx+%llx\n",
+		gt_info(gt,
+			"%s(%s): Sampling %llx, with alignment %llx, using PTE size %x (phys %x, sg %x), invalidate:%llx+%llx\n",
 			ce->engine->name, va->obj->mm.region->name ?: "smem",
 			addr, align, va->resource->page_sizes_gtt,
 			va->page_sizes.phys, va->page_sizes.sg,
@@ -147,9 +151,11 @@ pte_tlbinv(struct intel_context *ce,
 
 	if (va == vb) {
 		if (!i915_request_completed(rq)) {
-			pr_err("%s(%s): Semaphore sanitycheck failed %llx, with alignment %llx, using PTE size %x (phys %x, sg %x)\n",
-			       ce->engine->name, va->obj->mm.region->name ?: "smem",
-			       addr, align, va->resource->page_sizes_gtt,
+			gt_err(gt,
+			       "%s(%s): Semaphore sanitycheck failed %llx, with alignment %llx, using PTE size %x (phys %x, sg %x)\n",
+			       ce->engine->name,
+			       va->obj->mm.region->name ?: "smem", addr, align,
+			       va->resource->page_sizes_gtt,
 			       va->page_sizes.phys, va->page_sizes.sg);
 			err = -EIO;
 		}
@@ -171,12 +177,13 @@ pte_tlbinv(struct intel_context *ce,
 		tlbinv(ce->vm, addr & -length, length);
 
 		if (wait_for(i915_request_completed(rq), HZ / 2)) {
-			pr_err("%s: Request did not complete; the COND_BBE did not read the updated PTE\n",
+			gt_err(gt,
+			       "%s: Request did not complete; the COND_BBE did not read the updated PTE\n",
 			       ce->engine->name);
 			err = -EINVAL;
 		}
 	} else {
-		pr_err("Spinner ended unexpectedly\n");
+		gt_err(gt, "Spinner ended unexpectedly\n");
 		err = -EIO;
 	}
 	i915_request_put(rq);
@@ -271,7 +278,8 @@ mem_tlbinv(struct intel_gt *gt,
 
 	GEM_BUG_ON(A->base.size != B->base.size);
 	if ((A->mm.page_sizes.phys | B->mm.page_sizes.phys) & (A->base.size - 1))
-		pr_warn("Failed to allocate contiguous pages for size %zx\n",
+		gt_warn(gt,
+			"Failed to allocate contiguous pages for size %zx\n",
 			A->base.size);
 
 	ppgtt = i915_ppgtt_create(gt, 0);
diff --git a/drivers/gpu/drm/i915/gt/selftest_workarounds.c b/drivers/gpu/drm/i915/gt/selftest_workarounds.c
index 4e4c420ae67f..0b37334294a4 100644
--- a/drivers/gpu/drm/i915/gt/selftest_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/selftest_workarounds.c
@@ -7,6 +7,7 @@
 #include "gem/i915_gem_pm.h"
 #include "gt/intel_engine_user.h"
 #include "gt/intel_gt.h"
+#include "gt/intel_gt_print.h"
 #include "i915_selftest.h"
 #include "intel_reset.h"
 
@@ -193,7 +194,8 @@ print_results(const struct intel_engine_cs *engine, const u32 *results)
 		u32 expected = get_whitelist_reg(engine, i);
 		u32 actual = results[i];
 
-		pr_info("RING_NONPRIV[%d]: expected 0x%08x, found 0x%08x\n",
+		gt_info(engine->gt,
+			"RING_NONPRIV[%d]: expected 0x%08x, found 0x%08x\n",
 			i, expected, actual);
 	}
 }
@@ -233,7 +235,8 @@ static int check_whitelist(struct intel_context *ce)
 
 		if (expected != actual) {
 			print_results(engine, vaddr);
-			pr_err("Invalid RING_NONPRIV[%d], expected 0x%08x, found 0x%08x\n",
+			gt_err(engine->gt,
+			       "Invalid RING_NONPRIV[%d], expected 0x%08x, found 0x%08x\n",
 			       i, expected, actual);
 
 			err = -EINVAL;
@@ -304,7 +307,8 @@ static int check_whitelist_across_reset(struct intel_engine_cs *engine,
 	intel_wakeref_t wakeref;
 	int err;
 
-	pr_info("Checking %d whitelisted registers on %s (RING_NONPRIV) [%s]\n",
+	gt_info(engine->gt,
+		"Checking %d whitelisted registers on %s (RING_NONPRIV) [%s]\n",
 		engine->whitelist.count, engine->name, name);
 
 	ce = intel_context_create(engine);
@@ -317,7 +321,8 @@ static int check_whitelist_across_reset(struct intel_engine_cs *engine,
 
 	err = check_whitelist(ce);
 	if (err) {
-		pr_err("Invalid whitelist *before* %s reset!\n", name);
+		gt_err(engine->gt,
+		       "Invalid whitelist *before* %s reset!\n", name);
 		goto out_spin;
 	}
 
@@ -327,7 +332,8 @@ static int check_whitelist_across_reset(struct intel_engine_cs *engine,
 
 	/* Ensure the spinner hasn't aborted */
 	if (i915_request_completed(rq)) {
-		pr_err("%s spinner failed to start\n", name);
+		gt_err(engine->gt, "%s spinner failed to start\n",
+		       name);
 		err = -ETIMEDOUT;
 		goto out_spin;
 	}
@@ -342,13 +348,14 @@ static int check_whitelist_across_reset(struct intel_engine_cs *engine,
 	igt_spinner_end(&spin);
 
 	if (err) {
-		pr_err("%s reset failed\n", name);
+		gt_err(engine->gt, "%s reset failed\n", name);
 		goto out_spin;
 	}
 
 	err = check_whitelist(ce);
 	if (err) {
-		pr_err("Whitelist not preserved in context across %s reset!\n",
+		gt_err(engine->gt,
+		       "Whitelist not preserved in context across %s reset!\n",
 		       name);
 		goto out_spin;
 	}
@@ -363,7 +370,8 @@ static int check_whitelist_across_reset(struct intel_engine_cs *engine,
 
 	err = check_whitelist(ce);
 	if (err) {
-		pr_err("Invalid whitelist *after* %s reset in fresh context!\n",
+		gt_err(engine->gt,
+		       "Invalid whitelist *after* %s reset in fresh context!\n",
 		       name);
 		goto out_spin;
 	}
@@ -565,8 +573,8 @@ static int check_dirty_whitelist(struct intel_context *ce)
 		if (GRAPHICS_VER(engine->i915) >= 8)
 			lrm++, srm++;
 
-		pr_debug("%s: Writing garbage to %x\n",
-			 engine->name, reg);
+		gt_dbg(engine->gt, "%s: Writing garbage to %x\n",
+		       engine->name, reg);
 
 		/* SRM original */
 		*cs++ = srm;
@@ -646,7 +654,8 @@ static int check_dirty_whitelist(struct intel_context *ce)
 err_request:
 		err = request_add_sync(rq, err);
 		if (err) {
-			pr_err("%s: Futzing %x timedout; cancelling test\n",
+			gt_err(engine->gt,
+			       "%s: Futzing %x timedout; cancelling test\n",
 			       engine->name, reg);
 			intel_gt_set_wedged(engine->gt);
 			goto out_unmap_scratch;
@@ -657,7 +666,8 @@ static int check_dirty_whitelist(struct intel_context *ce)
 			/* detect write masking */
 			rsvd = results[ARRAY_SIZE(values)];
 			if (!rsvd) {
-				pr_err("%s: Unable to write to whitelisted register %x\n",
+				gt_err(engine->gt,
+				       "%s: Unable to write to whitelisted register %x\n",
 				       engine->name, reg);
 				err = -EINVAL;
 				goto out_unmap_scratch;
@@ -689,14 +699,17 @@ static int check_dirty_whitelist(struct intel_context *ce)
 			idx++;
 		}
 		if (err) {
-			pr_err("%s: %d mismatch between values written to whitelisted register [%x], and values read back!\n",
+			gt_err(engine->gt,
+			       "%s: %d mismatch between values written to whitelisted register [%x], and values read back!\n",
 			       engine->name, err, reg);
 
 			if (ro_reg)
-				pr_info("%s: Whitelisted read-only register: %x, original value %08x\n",
+				gt_info(engine->gt,
+					"%s: Whitelisted read-only register: %x, original value %08x\n",
 					engine->name, reg, results[0]);
 			else
-				pr_info("%s: Whitelisted register: %x, original value %08x, rsvd %08x\n",
+				gt_info(engine->gt,
+					"%s: Whitelisted register: %x, original value %08x, rsvd %08x\n",
 					engine->name, reg, results[0], rsvd);
 
 			expect = results[0];
@@ -708,7 +721,8 @@ static int check_dirty_whitelist(struct intel_context *ce)
 					expect = results[0];
 				else
 					expect = reg_write(expect, w, rsvd);
-				pr_info("Wrote %08x, read %08x, expect %08x\n",
+				gt_info(engine->gt,
+					"Wrote %08x, read %08x, expect %08x\n",
 					w, results[idx], expect);
 				idx++;
 			}
@@ -719,7 +733,8 @@ static int check_dirty_whitelist(struct intel_context *ce)
 					expect = results[0];
 				else
 					expect = reg_write(expect, w, rsvd);
-				pr_info("Wrote %08x, read %08x, expect %08x\n",
+				gt_info(engine->gt,
+					"Wrote %08x, read %08x, expect %08x\n",
 					w, results[idx], expect);
 				idx++;
 			}
@@ -985,7 +1000,8 @@ static bool result_eq(struct intel_engine_cs *engine,
 		      u32 a, u32 b, i915_reg_t reg)
 {
 	if (a != b && !pardon_reg(engine->i915, reg)) {
-		pr_err("Whitelisted register 0x%4x not context saved: A=%08x, B=%08x\n",
+		gt_err(engine->gt,
+		       "Whitelisted register 0x%4x not context saved: A=%08x, B=%08x\n",
 		       i915_mmio_reg_offset(reg), a, b);
 		return false;
 	}
@@ -1007,7 +1023,8 @@ static bool result_neq(struct intel_engine_cs *engine,
 		       u32 a, u32 b, i915_reg_t reg)
 {
 	if (a == b && !writeonly_reg(engine->i915, reg)) {
-		pr_err("Whitelist register 0x%4x:%08x was unwritable\n",
+		gt_err(engine->gt,
+		       "Whitelist register 0x%4x:%08x was unwritable\n",
 		       i915_mmio_reg_offset(reg), a);
 		return false;
 	}
@@ -1211,7 +1228,7 @@ live_gpu_reset_workarounds(void *arg)
 	if (!lists)
 		return -ENOMEM;
 
-	pr_info("Verifying after GPU reset...\n");
+	gt_info(gt, "Verifying after GPU reset...\n");
 
 	igt_global_reset_lock(gt);
 	wakeref = intel_runtime_pm_get(gt->uncore->rpm);
@@ -1266,7 +1283,8 @@ live_engine_reset_workarounds(void *arg)
 		bool ok;
 		int ret2;
 
-		pr_info("Verifying after %s reset...\n", engine->name);
+		gt_info(gt, "Verifying after %s reset...\n",
+			engine->name);
 		ret = intel_selftest_modify_policy(engine, &saved,
 						   SELFTEST_SCHEDULER_MODIFY_FAST_RESET);
 		if (ret)
@@ -1287,7 +1305,9 @@ live_engine_reset_workarounds(void *arg)
 
 			ret = intel_engine_reset(engine, "live_workarounds:idle");
 			if (ret) {
-				pr_err("%s: Reset failed while idle\n", engine->name);
+				gt_err(gt,
+				       "%s: Reset failed while idle\n",
+				       engine->name);
 				goto err;
 			}
 
@@ -1311,7 +1331,8 @@ live_engine_reset_workarounds(void *arg)
 
 		ret = request_add_spin(rq, &spin);
 		if (ret) {
-			pr_err("%s: Spinner failed to start\n", engine->name);
+			gt_err(gt,
+			       "%s: Spinner failed to start\n", engine->name);
 			igt_spinner_fini(&spin);
 			goto err;
 		}
@@ -1325,7 +1346,8 @@ live_engine_reset_workarounds(void *arg)
 		if (!using_guc) {
 			ret = intel_engine_reset(engine, "live_workarounds:active");
 			if (ret) {
-				pr_err("%s: Reset failed on an active spinner\n",
+				gt_err(gt,
+				       "%s: Reset failed on an active spinner\n",
 				       engine->name);
 				igt_spinner_fini(&spin);
 				goto err;
-- 
2.34.1

