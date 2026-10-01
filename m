Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4982CA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 07:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16B1410E24F;
	Thu,  1 Oct 2026 07:42:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fhAGAq60";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6493F10E24F;
 Thu,  1 Oct 2026 07:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790840566; x=1822376566;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=C0lOPz4cDMIBhtBrqyoxpXOK82X+cGjQpw/GpG0y/k4=;
 b=fhAGAq60FrcL+cjAxZ96tnSzCnGzPdEMumX7Q2BL6eDhTjU0StRFrDOP
 mhU4FeoCaNmssHZH8MTur8JTuF4s8rr4CsWJwwuvajlsWtpuhjhYLg7DJ
 pSalvcWEWoJRYPdHYWjLGya4vzD6WoFkfWe1l3uKexhsvW0jOt9DnqLgF
 55eiahBY3Xo9acumwpCCKgNUvbEDnNryNF0NEk5n4vbjAbH+JmsIKZWjB
 7dkvxrn36pFqk8q3e1YVTzTTE03tmuJ+zNtqmT8sWgFkNsc4Ny2WNM6nj
 gSjEEvfQxbELssiuysSoHpPiOMxEbB0ezQ4TmB8EEp4eOuJ6ti8kCLRF2 A==;
X-CSE-ConnectionGUID: GdaS1LuwTVu8ZYK0wJIocg==
X-CSE-MsgGUID: cSoSgcfrTS2f4eWAoTosBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90491393"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="90491393"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 00:41:45 -0700
X-CSE-ConnectionGUID: uVsd8RNzSA6U29mj+0jwuQ==
X-CSE-MsgGUID: Ext6S9k4S12BPrmkVe8o9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="279705675"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 00:41:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 00:41:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 00:41:44 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.18) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 00:41:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IV7pK4MqN9dLx5tT/aHTn0twqCY1z4bM+tNy2eix/24eZTa9VVkjIlmNxQSjYnPJG1T1VM0Kj48FTyEbfHhH/GW5lY8TU0s8+ei1W2nj2SMSrwUUPgMgYn8wkrv3VFYlohUQ+iKDkuwAExQB8JLx2WxkDtJS1lqlk187JVY9NT/oqSlk1jxrOVDBbg59AtPvFeZ5d//ZPjNEkIiAZ+dK/axfKeHjy+XkiJASJRwXdPrQ8oq9WNnr7dpUUVlCfKJ3GEAfKbkTQ6itQu5EOL/tuQNmsC19cti/X9q2xIIzyUcak/KbEWQwdR12iYpPREf8+ga0ZSVpUgh9XO/U6asGUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWftuTadtloRU2XSAdlv9YVsfDcgQWFvymCZqFOWZ/k=;
 b=A0l5DlLKWCp5SkPcKIDbtUGaPHBtUZGKlFjcG8BPjdA2bb1ZgbRvvyvCWQ1RmQnaXRZ4ignlkQ/InXeUsH/9kW+W5kQFAPj6adQoeSSyJgQjU3TMKzXQCkUB9LQ9WYhO0xmOghxuZ5fCTgoXHzHpfShWch7rUcUcXqvwRrYkiS6+EzUpGFMs1tj3TapOAitpjGuZeXeysClp176iac42Iu2PZcZBvnCDbTKhATrzzBwNhrmfL+95G+2B/bk3L6j4CTqMsnhDTS1iQuqDTbJuwaKNfRqejP/454oV/hxa/pDPZ393FJ3OFganTZtB/1hPgvHdbfzjMszzP84zJ+5aOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by DM4PR11MB6285.namprd11.prod.outlook.com (2603:10b6:8:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 07:41:36 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 07:41:36 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v5 5/6] drm/i915/gt/selftests: Use gt_* prints in gt selftest
 helpers
Date: Thu, 1 Oct 2026 07:40:59 +0000
Message-ID: <20261001074100.2694888-6-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261001074100.2694888-1-krzysztof.karas@intel.com>
References: <20261001074100.2694888-1-krzysztof.karas@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|DM4PR11MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: cebbfe71-7b8b-46df-9b2d-08df1f8f6c02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vhh00403NN+kBCgJDHxXFIaz2fB5FHjJLjILkXtB4pABz1cRzpzqYT0zCMg+AnkwT/GVpqUqZuM5+Dg441QFrxlTkwG3Nwn0OMLJWK2mpDL+7+Wf9r9RCRytiWI9gaSP5oimKpeFRpzu3CkooaUF6b6ADx+P7lYytNivleCRWU4IDCWY/tlVUKINYMprQ8BZci+G0KWxTbvpyvbNEfqw10+cjq1p+bLHfBBEbtF2YqeZjk+aZpLiUkOWyem5gEwqnHQ1dPYJn/G4GGXzgNQhKdhol28W6rFxHIRp/pPyr7+ApW1Ao6BJflYbwxlXoH/Ix3CaVOQ0p+pTseiv35NNQtXebt8GdV7weW/aJyzMd2kWan/lnjwFhgloxgnrJY6BN63zoANA4mAcH0nvqCOVcjeJenrAycqZm1nNqCAPYLjoRsm2YicatiJFSveszj7SFSgYdC9yLM1htPL1WZ+Zl5ptjCu2z4lsCC6bI5sBlzIRAV0VtLFgNlQJYAqJjVizpESjCal23Zv8VQ0Wz2/48H3h1Xzn+yGNjjzS0OHS9muoKFg7VBAsy/PZ0K7Ols2wPS6dLDQegmO4VaeJ7nRL4YEWJZWQfJ9/cG7js/DsTHZc/JkEHRv+otky8yUbRoesXRRrrqJJT0DJ1byzH+hiPusECpqIpQk30cBnOyarSyE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkswVTRRdk9TbGsva1llUWRCTHcvamV0QzBKNHVTYTJBalE3cW0zMWpUa3VM?=
 =?utf-8?B?TytFTzRqMGNHTlI5NzNkemNzMjNpQkhoaEhsdlZIQ1pjdG0rVXhrNUxralRO?=
 =?utf-8?B?OG9PUGExblVnRjVoZmVEck14WUZveEV5Y2ZWU1JXNm1OWmRQN2d4c0ZkYzYr?=
 =?utf-8?B?ZUhFbGhQOS8xMi9WY2pTSnhsNGxWZmVDSVdLTUd2eFk4RkFYcVJGZzB5VWRC?=
 =?utf-8?B?YThZUitGUURQMnBocWpBbFVIdDBsbUlKMWhJRXg0RlpaV0dIWlJXaWlmRlJl?=
 =?utf-8?B?dlB1KzUxTng1WVVnYlMyNWdUc1YvbjZiSUUveG05M3VLdHI4U01YbGZWTnU1?=
 =?utf-8?B?VGtUQXpyU0swVk9takNtcnZYQ1JOVTZDTHhiaWpQbzlETXJudFU3Qlhkei9l?=
 =?utf-8?B?RjRMaWluOHBzVkZNNjQ5enVsc3ZINnRmOUVzWTRJY2lmYkVxMEpsTTRyQllB?=
 =?utf-8?B?eWFxWW1wUUxqYkNYWms2aEVmZ2dGK2p1ODVSR3crREZUN0h3WWcza0pkby9J?=
 =?utf-8?B?ZFJ0dXZUVXR1UEIySWRDdFhuSUlTRzVoOE1PVzhrWWlQa2EyamR0Zml3cGlW?=
 =?utf-8?B?czJITmFFZnNoT2ZpWEhYWW5qNHNlQ09uTWRoeWoxVCtTYlo5K0dPY1l6dDF3?=
 =?utf-8?B?bXhWL3dCaElHL3I4OU5UVC92TGI2VzhVdGtmaHVwdTU4MTYxUUg5MkVIRXp5?=
 =?utf-8?B?NlpoYXc5ZzZtbUV1cTczK2xmNXlCRWxBZ3BaR21WcGdFaXlSeXlqTmZ0N0Jo?=
 =?utf-8?B?enRQbVdETVd3enBvSzdVUDM0UlIyODRmUXVQRU42UGI5azFEbzdoeGIzZnFn?=
 =?utf-8?B?U1p0SW11WHBwVGxqeCtIRDcxbi9xK1V4dWxHN1NKYUtxalFpc3RrcHRINlVy?=
 =?utf-8?B?SnBCTk1JQzc3Yi9QZjhwMWJPdnE5NHNTdSt0Y1Btc01OZ05sNUhOVkladkJ1?=
 =?utf-8?B?TTJpTWZPRGI4MGkwMlh4b1FmdFM3Vjl3SnhJMjcyUCs2Skp2VFYybFF6RlRh?=
 =?utf-8?B?VDMzVE9qN1dJRGxXMncwTTQ0T041ZWFFVUxINUQ0NFFJbE1BS05HUzRMVTdC?=
 =?utf-8?B?S3JOVEo0bDExT1dDT1dlYnZRMnJVTytmR1Q3d2JONElVdmdxU0tKWEhZU1J2?=
 =?utf-8?B?bmx2bUNnUlhDcDNVM2lIeXJTbHFrQTBNMnlmUTFYY2UvVCtuTkFhazAyWG44?=
 =?utf-8?B?L1Zhcm5FWXJjZmZkQVU5eXR3T3RkVG4rYkc0U2FNbTZxaExvdXdUOGRmTk9X?=
 =?utf-8?B?SU5oYmJqSGQyS2VaVXllb3B0OU8yU2hPblhMUDk4SVMyU1hyRklTYkVYY2Ru?=
 =?utf-8?B?T3U5OTFiZ0tVT05rQW5ScUVWS1Z5K1IvL1BnK0dkK1pTd3dPU0FsM3JhblM2?=
 =?utf-8?B?bHpzQ1A3anNWWkhLRmtaSzZKZTVzR0wrUzdiam04b1F6UjF0bVJrVmtuQXAx?=
 =?utf-8?B?QVgvSmNtUjgxeTFhMnZaWUFXcHhIS0E5dS96d2NjNmY3U21NSUw5Z2lYNHlD?=
 =?utf-8?B?SGdqUm9mTUNWWExxRWFUbmJzODJDRThMandoeGVZaVRLc0pBMG5hZEN2MWVV?=
 =?utf-8?B?VEd6TEdaeldGcktncGlvWUd4RzhHNVVDakozY2w1VWRuMngyb292aVMzUHFX?=
 =?utf-8?B?NHloVnpzLy9LVHNNYWJEUDJlU1JFcE9CdlI3SjRJb1dGb0tkbjdHd2ZPRjh5?=
 =?utf-8?B?eTNWOHdhUFBpcWUvVkdsQVBUZ2lOaHdqakh5aEgwNDBTWWZvMTh1MzlhSi9S?=
 =?utf-8?B?YVpuM2RGWUNSeHdsQ2JqYWpxRWd0NTBrUjJnL0hvaEdQQW96a21hdVFQV2ly?=
 =?utf-8?B?TlY3R0lnUyt5RS9WWWhTL1Bsa1dwOVZtdWU4eEdHN1p4MlJndFVBdWlZR015?=
 =?utf-8?B?Zi9sTjhCYlBjYWRvQ3R6V3lBejZjMlprSEdCQ24vM0xicHJmQ0RWNG9wRFND?=
 =?utf-8?B?NVhHRmVmTWNBOXpaejBnR0swdFhMSzllRDdESFRjeFlyZGpDaHpKSGsvd01W?=
 =?utf-8?B?bTF2aUpvYjNWU2cxOU5OSmNDRTFCNzNHVzZna2QwcEt1Rk9ETE5ub2xvdUNV?=
 =?utf-8?B?aUNHbU1nUW96SHBNdTBXcVUvdFNIQWZZZ0N4WUk0Q3VlOHJ6a1RQRFYxNm5r?=
 =?utf-8?B?WlA5U01iaE52bmhmR05JVkc4YkVCMHg4WXNJcjRMdzlWOHQyWjJzam96eWlS?=
 =?utf-8?B?cGlsMm95VFR5NmZXTkZxYTBkQzFDY0VqMGRoZVgrQjFRbmNyVEpNalowR1Vq?=
 =?utf-8?B?VEFjZ0V4WVN6b3pBdlN0eW1GdG1pTm1lc21SUlhqSXdyekV3WFJENUUzL1Nu?=
 =?utf-8?B?eVY3ZzRnWFVyeWRjTjMzbC91SjBBM05GT1EyMER5YVBrclgvZzN1bmFINGFT?=
 =?utf-8?Q?p59sYLQ1Li/+Q7VM=3D?=
X-Exchange-RoutingPolicyChecked: yDkcQqUwuZa8HfqVhPFmYcEy/rk4LOf/KqBPGJqzrRUk22MRDgV39iqgpFO8kVn1c+K5qnNslI08k/g5CEzassjlBPjAwgm1jKKht9OrbNSAKjCcx0woJG6EcKw46BDHTIeZcIYZ+DIPDVq8WSLLgvtdOxuluV0CxuY5KpP8+YhXIefFGD6ysszG2K4+drxFhnx/4mpW+9Jx+WNhmNO17PqxJPA8E5sWxsgcNFQsMfPAIqwFcW8QFRCA0mR59PqEposacH3Sz950+CTgCgSwXppiEPPZLjBgGFlfZg7KQJOa22Qb9WpSqux7puqW/dUt4m7YFcCpZU2YyG8aNQpY3Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: cebbfe71-7b8b-46df-9b2d-08df1f8f6c02
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 07:41:36.4138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYyrBu59avzID0S5JFOkltEtE58oGI6FVw/ISjBcv2XY++o+Bcibak7jKqWI3/W4nEjq8/GJZWs5c+3jgzc3UfHdJRmLiPJX2rqJ1+0B7Iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6285
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
v5:
 * No changes since v4;

 .../drm/i915/gt/selftest_engine_heartbeat.c   |  7 +++---
 drivers/gpu/drm/i915/gt/selftest_llc.c        | 25 ++++++++++++-------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c b/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
index b893a8fde895..1164dd4aea11 100644
--- a/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
+++ b/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
@@ -7,6 +7,7 @@
 
 #include "i915_drv.h"
 
+#include "intel_gt_print.h"
 #include "intel_gt_requests.h"
 #include "i915_selftest.h"
 #include "selftest_engine_heartbeat.h"
@@ -202,7 +203,7 @@ static int __live_heartbeat_off(struct intel_engine_cs *engine)
 	engine->serial++;
 	flush_delayed_work(&engine->heartbeat.work);
 	if (!delayed_work_pending(&engine->heartbeat.work)) {
-		pr_err("%s: heartbeat not running\n",
+		gt_err(engine->gt, "%s: heartbeat not running\n",
 		       engine->name);
 		err = -EINVAL;
 		goto err_pm;
@@ -215,14 +216,14 @@ static int __live_heartbeat_off(struct intel_engine_cs *engine)
 	engine->serial++;
 	flush_delayed_work(&engine->heartbeat.work);
 	if (delayed_work_pending(&engine->heartbeat.work)) {
-		pr_err("%s: heartbeat still running\n",
+		gt_err(engine->gt, "%s: heartbeat still running\n",
 		       engine->name);
 		err = -EINVAL;
 		goto err_beat;
 	}
 
 	if (READ_ONCE(engine->heartbeat.systole)) {
-		pr_err("%s: heartbeat still allocated\n",
+		gt_err(engine->gt, "%s: heartbeat still allocated\n",
 		       engine->name);
 		err = -EINVAL;
 		goto err_beat;
diff --git a/drivers/gpu/drm/i915/gt/selftest_llc.c b/drivers/gpu/drm/i915/gt/selftest_llc.c
index 779fadcec7c4..71ea688be154 100644
--- a/drivers/gpu/drm/i915/gt/selftest_llc.c
+++ b/drivers/gpu/drm/i915/gt/selftest_llc.c
@@ -3,6 +3,7 @@
  * Copyright © 2019 Intel Corporation
  */
 
+#include "intel_gt_print.h"
 #include "selftest_llc.h"
 #include "intel_rps.h"
 
@@ -22,8 +23,8 @@ static int gen6_verify_ring_freq(struct intel_llc *llc)
 	for (gpu_freq = consts.min_gpu_freq;
 	     gpu_freq <= consts.max_gpu_freq;
 	     gpu_freq++) {
+		u32 scaler = GRAPHICS_VER(i915) >= 9 ? GEN9_FREQ_SCALER : 1;
 		struct intel_rps *rps = &llc_to_gt(llc)->rps;
-
 		unsigned int ia_freq, ring_freq, found;
 		u32 val;
 
@@ -32,17 +33,21 @@ static int gen6_verify_ring_freq(struct intel_llc *llc)
 		val = gpu_freq;
 		if (snb_pcode_read(llc_to_gt(llc)->uncore, GEN6_PCODE_READ_MIN_FREQ_TABLE,
 				   &val, NULL)) {
-			pr_err("Failed to read freq table[%d], range [%d, %d]\n",
-			       gpu_freq, consts.min_gpu_freq, consts.max_gpu_freq);
+			gt_err(llc_to_gt(llc),
+			       "Failed to read freq table[%d], range [%d, %d]\n",
+			       gpu_freq, consts.min_gpu_freq,
+			       consts.max_gpu_freq);
 			err = -ENXIO;
 			break;
 		}
 
 		found = (val >> 0) & 0xff;
 		if (found != ia_freq) {
-			pr_err("Min freq table(%d/[%d, %d]):%dMHz did not match expected CPU freq, found %d, expected %d\n",
-			       gpu_freq, consts.min_gpu_freq, consts.max_gpu_freq,
-			       intel_gpu_freq(rps, gpu_freq * (GRAPHICS_VER(i915) >= 9 ? GEN9_FREQ_SCALER : 1)),
+			gt_err(llc_to_gt(llc),
+			       "Min freq table(%d/[%d, %d]):%dMHz did not match expected CPU freq, found %d, expected %d\n",
+			       gpu_freq, consts.min_gpu_freq,
+			       consts.max_gpu_freq,
+			       intel_gpu_freq(rps, gpu_freq * scaler),
 			       found, ia_freq);
 			err = -EINVAL;
 			break;
@@ -50,9 +55,11 @@ static int gen6_verify_ring_freq(struct intel_llc *llc)
 
 		found = (val >> 8) & 0xff;
 		if (found != ring_freq) {
-			pr_err("Min freq table(%d/[%d, %d]):%dMHz did not match expected ring freq, found %d, expected %d\n",
-			       gpu_freq, consts.min_gpu_freq, consts.max_gpu_freq,
-			       intel_gpu_freq(rps, gpu_freq * (GRAPHICS_VER(i915) >= 9 ? GEN9_FREQ_SCALER : 1)),
+			gt_err(llc_to_gt(llc),
+			       "Min freq table(%d/[%d, %d]):%dMHz did not match expected ring freq, found %d, expected %d\n",
+			       gpu_freq, consts.min_gpu_freq,
+			       consts.max_gpu_freq,
+			       intel_gpu_freq(rps, gpu_freq * scaler),
 			       found, ring_freq);
 			err = -EINVAL;
 			break;
-- 
2.34.1

