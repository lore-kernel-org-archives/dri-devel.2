Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202A5CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 09:59:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70BEC10E341;
	Tue,  6 Oct 2026 09:59:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NDppgix/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9209210E321;
 Tue,  6 Oct 2026 09:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791280744; x=1822816744;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=iU0OY7v20o+2Twac/ZCcg6wg56gr/vII3zye0B6ImvE=;
 b=NDppgix/Q73t27qc9xehp1orRgQk7ZaZIPfi/HwoETAv0VWnSDKsCof7
 0uwG7UKvmd0xwv/T5rh/3U+CwOmgvg+LrImPleTU+VmqA7Cm1dvH1vhzk
 sg8ZpJTvqN3x7+tw+F+gtt5p/ldfZbFqHdke4+WSCZ9l5/yLJWHlbnIVO
 FbcNQGilI7c1hlWpMIOwmmCWnueqMK6hMLJA3Xvmor0Vcgg6WJOm1KHRf
 Xttvk2Xsxs04mki17GXy8l1Izgj77RmGJH4f5+ra+yJh5ACttHJG8pFbk
 45GEnDK6xQTESO0g6/G0XdLiSAezl5lR1XMCrf4F3DSVBMnFXIOd/zUgM g==;
X-CSE-ConnectionGUID: 6ge1kMFRTga51afksGWUmg==
X-CSE-MsgGUID: 1hsL0CdBTpiG3WzFrT7Axw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="16107"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="16107"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:59:04 -0700
X-CSE-ConnectionGUID: op7x0YK9SN6fGvHhqri3Jw==
X-CSE-MsgGUID: 3qp2E8DiQ5yR0AzPDiVTkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="277218498"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:59:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 02:59:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 02:59:02 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 02:59:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYv9ZSEhKoMMFNF1aMIp0gFP8uGErJEhydhe6FzwVqbgWcOADz0TivSEMzditdAbf4z1q/88cul6czxNDXBVQ4QD0y8uB+LZZE7rZyJ/GZ5hFcS0cy1bCQ5wTEJ1YOjIu5IS6DXLQ49DSENK5+2lGuJGCB41wlpAN/w2ftYwMbjbHVoabP5RAX7gT0hz5FSKQjSaRm0KB0eQijeqcjYt1mHCPE+kZJDHzUQex38eV7P4B/zpQNpLN29T8Qn4u+sa/hHVSqG7QSAYNrmfJZSx3xcHhuAu/GDs8kU26UBZbE8A7BoVqLr8dWnHi6jVgP8kBLVrVdm704ZTkZ/Tj/F3Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgCKjdPWTnZdI4PF6EUGdQc8kA15FknhjMOdInvi8yc=;
 b=ltqBI3ob7PZIOS3wC7DFwxz/VzHkF7DDlb6Xad8Xe3uqNC9AcHOZWKILc7/yoB013VBrJ4tACJU4PCR/V92jksKDt5JgZaiONY7j9i8xVxoikXuf5zMNw/Z10EQyXjN9haoqBtBMHrQ7ZOnmHIR5BjMvGOeEvYm2HBsr2NHt0W/GiqVKeOWBTr0INGgtlHfTAeB7z1WXQQrBmwZzrkmameZinUPWrNu62aWG1eg+akVDk1Y8nnd95GHojv6K/opNUdxzsrWjuWAapmIE6zJiljLakTF5xaewmKYG0lYWBo10gRmlUjZU57JCoKYP1k/8bjS9eXOgYfoFHbC0zAVYgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH7PR11MB6721.namprd11.prod.outlook.com (2603:10b6:510:1ad::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 09:58:58 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 09:58:57 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Andi Shyti <andi.shyti@linux.intel.com>, =?UTF-8?q?Micha=C5=82=20Grzelak?=
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v7 0/6] drivers: Improve memory management for large object
 allocations when i915/shmem is used with iommu
Date: Tue, 6 Oct 2026 09:58:39 +0000
Message-ID: <20261006095845.451212-1-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DB8P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::30) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|PH7PR11MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: c61b2255-5820-4132-256c-08df2390704e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|11063799006|6133799003|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: LAznRkYBnSHNlMogcietZ6knkNlG1KbZsPlxwQ1OEgIsSGYOm3lb8E1wnKmL9ZySrVHYF7A74JrA3IEtnGImPZofLhuOZwhxigx0iReSeZrXlFoIpf2ebjaiUvI9CK1gdSyzk3OevcfAD8LosxSxr/kTQm5idmEI7AG8nkG48EjTsorluB30rThDNGEMl6U+KY4Szs+IpZzC9XtJP81jqWPt9oHkn0lQ3uZBw6b2rk4qU2nS4tyK3EHZe+5hztTBOzz4eITHew3pF25IMV9l5setsv+Nl5m/lWJBueCvVzcWSndJOpCZgrsovqdB9gXuHmB4me9cBU0N7Vs5E+oeVs/ZZKwyeRTu6iiBP6llff3mDdyqrcD7oOj2FQ943rQqo0vCIMQDK1O9Jm3Thq3zXwEL7NTO+d+dYqJiAjCbRfJUGUgyS62jsuOxM5cQD7JB+H06DeYuWB1f/8j4MVlYTS3KMWl9FcCjJRho3lOWGcj6G7hWRgvv6YLpikgTOQza+Zz/ETD7NJF/qRJfftazPGu2xXY/1twJ+uNourOdhg1zhEf5ml40RGkNSNlpJoJQ/oJQWeaB5apy/7HrXhJdLNIiezBHkon/LZlTH7xCxVJYmvQ8TONkv4F6RDB4Taphrahei7RoGaZD0xKGDyBcIdsTXAHBIGA7jm/uG49qEVU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(6133799003)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jNhu3btNdmBlcST7zko0Mb0s9EqLYyq8aNchxylVbVUB2CgJ2FJihYMUEhIJ?=
 =?us-ascii?Q?24w2m2WRSzbBjD8KpvMkMUVVB6anqt1LGh+0L6ymBgoOG3THRoaOAXOA1HVR?=
 =?us-ascii?Q?l0gg0aiLVbuz+Ioasdksi5gQakDtLThWMh2L1iPYu/sJzOpArrgG/SZ+lHI1?=
 =?us-ascii?Q?o8CxM4mPLnbcivBbKRXL4gkEvvR4pP9nfn5gh8natzBqvMNfD+RNoYq9KqjX?=
 =?us-ascii?Q?ORYfFyip7kE5MXGc1DGu9OtUwB05BfAewX3gkHaUAITLgYtYex5WPfi1b54s?=
 =?us-ascii?Q?yfI2YmgElybiqLcQD7MaOkFDxu5Z8MDXyRueckKIqLr0hRkDIdobgQIr52XD?=
 =?us-ascii?Q?8foiqlM0rpJOhuq3Q0+QT8lZ1cBh0tT35/HOUEJYHb6P6MMXBi60UuNyULZU?=
 =?us-ascii?Q?5CyD2rGQHeEuUxCDQC21E5h4nQIMC3yxh9jTmgZJT1yCImYes3DLkO+OFZRl?=
 =?us-ascii?Q?/+Mcy2E55SR1VZgbuWGXfmWiqmw2h1CkVyUGTCjow8TC2bn5jpy/M8LYOvzk?=
 =?us-ascii?Q?iRmtlEB4m3ksvJU5VQfnSR4HREb6wo6cSLQQEG9LkHCyFSLx0fpYZDrlbdyQ?=
 =?us-ascii?Q?vdud+p08fphW2Thumnp4IQH0VzcrEDpEQwbwdd8yV+iRvVqkAYiclJeaDf1T?=
 =?us-ascii?Q?Zusu/uOTMnUfjGqXvOvFRQjSzd400MpeDtrbgxy/ck9pgtGPD1h0WDhP3B1x?=
 =?us-ascii?Q?HQ7Dn/KtSt0vpQR3GoWCQ6IDhPnQIi/ENts00rw7HKvxJ315Vf+XijFvVWHy?=
 =?us-ascii?Q?zLxutdJwdSzn9t67LEiFYGY74hch5WiVycCNVuhePKOlkd56Ya1AkQiUt20v?=
 =?us-ascii?Q?GcWDEODhNTZEBDyh6AJY6CpFDc0zXaF6/d4NCZCo3f1UZTzrlzHwVZ/cIGrr?=
 =?us-ascii?Q?nvCawltw6KdADvDXpGSx3XL7k2viJkDiSu2j8ChNC4oJagUEWUBd1GJ5sIX2?=
 =?us-ascii?Q?8ENWNPnT5IG9lwuRaAS07BOdMMvz9iaUO5yMJ/u7g87G+oaL/fAcxPH3maI9?=
 =?us-ascii?Q?v/ml8cv16Kga8HSUsruG2RzFHPJ++FL2Y9bDuEEeQilV4dyMBs+VD1laY9qv?=
 =?us-ascii?Q?GM7xCBDwGti4qFfOBiCkxpaNy4veDu87Is9gki8j1AT/Ss6mig9IHSWGn9E5?=
 =?us-ascii?Q?oym75H3UIL7EgZpou2xLtm5/TmG6ltFYjNWiPNgx2xZOQWIF9CpDbOXxnhb3?=
 =?us-ascii?Q?VkbibYKnwnsiIw/icMpdl95oSdl4mVojEhH8r2+hezYeecV+ur8khIslp14n?=
 =?us-ascii?Q?t26G0EH3UoVLXzuv2kidr4MLanKbD7ptmW99H5M3TZZV45Cqu37BAJN3sYg5?=
 =?us-ascii?Q?vheHvSwVTBI2+HsM4lOYZ96BkM7a441Q0nW9dc/EAVnhEA9kH4NTjT5Zy2W0?=
 =?us-ascii?Q?yuiKrD+0qwqoyO6v8q2xfGey5r5bBIwOlG9gqnOSRrCS7ksC2BPacAuWBYEe?=
 =?us-ascii?Q?pdAcfw6bI/GUKNcqWiXj+cvPs62ejCnutDznOQRLH0VAas2pjODhCS14RQZb?=
 =?us-ascii?Q?081zU74FVPGVl5bHkTbrcdgWD31DHbiKFwDvRlOM9mhrZsMbQQAEivYdNqlb?=
 =?us-ascii?Q?jNgE7iBJFDpSPcGIDgnpxp5jIWMskzD5Syeb2PcqpUcg3LLftmXbMdZFivAq?=
 =?us-ascii?Q?A0m9paB84fc8x1n9Qj6FLaKx9wz1f0sWTVEHPpkZ4BCHGJ5i23deeABUBsn0?=
 =?us-ascii?Q?rkV/2xoesMLR0X9OdU6sz/wYsPRFbgC1ja/q+nk2mf4qPgpni+A528UNE2fe?=
 =?us-ascii?Q?8ThAmr4vgWSx8C0R04AZkjoOo86UQW4=3D?=
X-Exchange-RoutingPolicyChecked: 4Pd0THR4Jhh5rRJpyG3MOGnJH2xCjkeCgIIo0QgfGN2fHurPekyFeQOhPTabxMJMk5cjnH1SxJLZyTRb9k7TV2JseVeyikLn2tcz9Na/uuOkKYLmRofPJZPTMpBcka4Lqhj9W//U2IsMHoHOBklyska5YaVRKKuqPxnwjcUmHQiYaynlAw27mCK/ht8HiEjNdLEWKGod4z87hkBedZ3kEprp3IbwakCl0VTu4fmKF7qAS/EkGltJgfaVfCHfB6S/NwqY7KLOCv3dNT3oV2XQ8bO/NuesxDzk0PTKnVOaetC7Z6gGtf1Vz8NH+P+ZjAoj7z7eD9x6A69Hv02lhWEKBA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c61b2255-5820-4132-256c-08df2390704e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:58:57.8883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8qHmc7FB7UldxLQ9FPgM5RJma2ry/flIYKOvkt+nD3oDyOY1daRvtT2selrJi93pZ/5XKDoHQ083Baw9tMG18WuBIfeLdhXI+AbK0tfkFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6721
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

It was observed that allocating large objects via i915 driver
(igt-gpu-tools/tests/gem_exec_big/single) the folios and their
pages were not handled properly leading to buffer corruptions
during relocations.
Furthermore, using iommu driver in this context would leave
residual mappings in memory that could not be released, hogging
available RAM even after the process ended.

v7:
 * Drop iommu/dma patch from the series, as it was submitted
   separately. (Andi)

Krzysztof Karas (6):
  drm/i915/shmem: Validate max_segment
  drm/i915/gem: Count mapped pages in a folio
  drm/i915/gem: Free sg table on failure to acquire second folio
  drm/i915/gem: Pull out size validation into a separate function
  drm/i915/gem: Read and shrink memory in a separate function
  drm/i915/gem: Remove iterator and use while loop

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 168 +++++++++++++---------
 1 file changed, 104 insertions(+), 64 deletions(-)

-- 
2.34.1

