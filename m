Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4107CC4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 09:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1EC889FF9;
	Tue, 21 Jul 2026 09:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Cm0x6DuO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 963C189266;
 Tue, 21 Jul 2026 09:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784625389; x=1816161389;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=ejQzxOLGKTja8GrLFBgbrMk41lDH21EI6K4Xy0IpmMo=;
 b=Cm0x6DuOU4LFu0W6yDsOLNN2lqchm/LIsRKvaTI5acH0KKkjmMrdLkcO
 TnaX6uWIGILIoMEALg/KRIBnXwRuVwI6kiypmcDSoDTZiaHi2qtcoPyP1
 4/53g2juhgog46snRNJ45L4JdJpZinh2cbdgY67V94OJ2ii39tjv/asXa
 Kejw7rS1dB08pdrDX1NvlKCXAqhHXqX+ULll9yhFChrDWzznURZJLFrBL
 nyts8GAgiub4O/UtkE1NUFv2AqAQEZno+SN6t3foBEiQW3fazVNpK7q20
 cIDpRD6H5U7zpM+X6/rNpx7EeOtyrkWm4dfE5JXAsEwRagFU+xEqkr+Uh g==;
X-CSE-ConnectionGUID: gpz3WEGRQMGmoJ4c/eqANg==
X-CSE-MsgGUID: N9Pdp4RMTTCZofeFmZa3sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="89042295"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="89042295"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 02:16:29 -0700
X-CSE-ConnectionGUID: NWmPt9iNTV2gX3HAVdGOCQ==
X-CSE-MsgGUID: C8BPmqLQQUmvTwSOGoSR7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="261258188"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 02:16:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 02:16:28 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 02:16:28 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.13)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 02:16:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqOJFC/uzMcJeV0tYWrj5jokb1EiZpYdtLJyAqvWyfgviesaxFD7ENlAq4jFq4fW5+KpIXkbNXcs/y0eMpvs8l6WNW8asD11bjvUVfcZ/KbtlbGrGccvHrJngteg+35wS2qw+YHb+bN6DgI/I5MhPHqUEHDGMktslAFk0aJAoZYDSN4XOJrCCtiUjj4vTlFd0lsHSFk6xrO+XJ0tU+y2a/zBXIXVE7BZP6rc/VNiyEEv9kqEVGxKQcwwuw0RAT+vyRmP03UZpgFY9zJ4zBZb9GSQlRBIq7liYw61oKD3pLoOuaQSzBfZv18dkDfnjBu3rQOzV87lS1aTf6HTm5YL6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbI9FRkfZsz63LsTdcGwvifl2l5d4Yfva9WHYfVdqDw=;
 b=GD1YHGip0D3LNkVFu4SXaU+2+COJkpZxieNwm6HkwMtQ+AUl+7snAxIJO1eBHAWD57QKaeQ5ew5/jbob1q9j1JlMY8KNtuJiM+VgYAM6tUJOGU5tdhP7SX7pkm5HOJTFzVsBKcq+u6/9FrW73NIQr39KoThXruuU+L+R84IH0dFZen0+BJ1WuFijLdvM5uUhSyF2mQG12nJtpYwrBWIfJG9ULPN4lkYFOsHptFSHt4sWOeH3n40CzxO8yWfUjXajwsP3/xOqIbGPPBWnDR661QkK4MIad4kX6eLHuPgSHmn1fO581e6bNRLWD6oSj+ycCeVOdBKzX+M/52AyeG/+uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by IA1PR11MB7293.namprd11.prod.outlook.com (2603:10b6:208:42a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 09:16:26 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0223.013; Tue, 21 Jul 2026
 09:16:25 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH] drm/i915/selftests: Disable live_pphwsp_runtime on graphics
 version 12
Date: Tue, 21 Jul 2026 09:16:15 +0000
Message-ID: <20260721091615.2680038-1-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0017.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::7)
 To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|IA1PR11MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: d318e8b9-e6ef-43d5-e420-08dee708bd6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 97uhB83Ro7DsGgQUAWU55wQrtF4ByJiuoUWX1p1t8bh2scufah/1akNaIpo/Zp6mkIzE7j4MpV6jeWsn8YnNn111WQDUPLdL3caL6Zfpk8MLoME3dJbe+PvQqHB7kg/lUHxu/x+vE4XL9rR9I40aioSceyZxXrQoO9A+uYfPI7uV+uBQrFOUqa7kd6DLJlq0U5qFjKO0kETCpGjDHRtxfq0WmbTi98uEWuGGpNv6+lpoN6j3bqa8K9vk/QgNiKUXzHmgGeXi14LwMdn8Dyn5HvPcM96XADbfW7Y4IHMWDJsPWisP5uvZ4P1Q24PN7z9HX0FKyPEOir4h/LnykxDn3iHq/AhA8tuO4ieCy68tZQPtN9gEhJjdKEQaY8IToBG5sVE/hzgyu15SyYcom0HYP8r0htMxCzPddmHywtFYnvIeVIjdvcW5ZqjqVV9HKKL3L8PaHUc1HwoZPcb3rigQCFZ5TBCV1IuFuWK44OptKfGVhxAbXnkczfwNXj1GrY058rFHXCdobloh5Tuf/bTyGQM85zUNu7y7QaEAo+yO86l6vs39xUUD/pjD06kVAKXXMdNCbhAD9/YUAz+ijYyhWLIlXh3KzQBGvIrJDWVhLDPoALsyIPcqpylvOrfdU0Pp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?siT3L5JkfqjzmeyBnTz+37KeI1nlStpeIhJQWxezbd6s6IE6wHMMaw3C1N6Q?=
 =?us-ascii?Q?sxAOZWCSJyYAjcsjgypaGUsM8qKboi0HmeL12YBEmYoQMr9QTT/Y/Afi7Y4e?=
 =?us-ascii?Q?IvmPHOFStFx16WT2JLAdESEJL8s05Q4bGF0nZbmcv1AlMBBj3s/qDdLcx2zw?=
 =?us-ascii?Q?2S5uJnegw0r1rbykNh0xZUWni471xFQM/g4A9sXJBwDit7cV6CR5YZtD35pM?=
 =?us-ascii?Q?XzKMyNqR1vyAqdsdbzXV48C1SfBY24DIrEMNCKnVf/NmM5Pq9HaIQp8o7ViM?=
 =?us-ascii?Q?CtAKVWosnfHK4MdaTfmbtRo8c5/+yP09C4p1ruoASQPP+BSNdu2BD7SLs5a/?=
 =?us-ascii?Q?JvIqv7oSqyGn7QJobyBWQUSAHY7mPuDyuQPqKkR/aAWsHaa5jf52sSEfxd31?=
 =?us-ascii?Q?/twp6EKtGuED1QF/0Bsu8geS6Puuedw46Jj+j14wvwdrExMCiWsvIjlpZOFl?=
 =?us-ascii?Q?4KM6bsnbneCNzd5/vDzdVo2gWdvX8AHSB32Nwi14QIKI4GsVw3s2B2YBrdAl?=
 =?us-ascii?Q?FHbfwSt2bCLhGsRoq7sTSX6edPFpOzqqiiDi1ER2pX/hzPAhJO5PyPqrhzz9?=
 =?us-ascii?Q?EyMmULLgJC9UArkfwRH6tsYV6Np30KDELAjBQCDnCrWMUn08ckgU08dgZxOp?=
 =?us-ascii?Q?d4/Uhg9EH/yvNi68I/WdL4d+LJ+6sYW/RgtsxYJtTjRZYvLlFu71qleOm38m?=
 =?us-ascii?Q?MZPWtg7VPHwv78he2Pl5QrxHmAiaGAOd9w8Q2kCOg0RwWkwXXXViHNNEEMfO?=
 =?us-ascii?Q?q5B9l/lb5q84eQBqK/oRNlIhHwLjY11gUJZGvKoQvrAZ+g60UUZjILtYkRL4?=
 =?us-ascii?Q?5qcc/FXlYFTw6R4SPHqMRcjN0KtCCfQgfOF8lbMKMhsXjfdtEZrH6AwPF9HA?=
 =?us-ascii?Q?IBbW3szR8PxPyw67wV6lCJO/hJfOHqefx2pgtfnS3Yw8uBOkyDBnXawBKoxa?=
 =?us-ascii?Q?oVaVaWGrX5AxiuAiA6ae2wtylkrogdlibUwj9YZWJcQQuZVz8MK6ZbPgE4t1?=
 =?us-ascii?Q?2JdhryMBW1oZQsIA94t+GNQ4nSdnDvTeJhHiPACDr9NFdgy0/VqhDAjK5+Pl?=
 =?us-ascii?Q?eMrSTtvCio//vtEmYsKw4xaNxxxw1z4sJQ00mDg3FLXv35X1kXDUUsEUYLL5?=
 =?us-ascii?Q?L0db07nJ55cqT6KU9E/0DxrX2xoW//k2jML4ijVivuR3h60gKbO1SBX3RI+8?=
 =?us-ascii?Q?BIYVEHT4otMcEgMTwhyCtJ/2uD5ZikVUQMGLKQaRl5xnWoF8LP6JvRYG6GRc?=
 =?us-ascii?Q?gFEYorHyykEs9HNweMw2IO9VUdP3kzGlVqILWibC6mXqSQmjtbIcGdQD7tn5?=
 =?us-ascii?Q?Rc5nNNp5rBdwSe6Mx35k3qnUXVorjhtstMHTAs14sFhEB5U0IOMquWNeuzVd?=
 =?us-ascii?Q?lRb7Lo4RMa02fxWOAkYiXyhkH9EyJKu2ZtCMMx7pWkip8GOcMFfctoO0E5yV?=
 =?us-ascii?Q?vakn8lhJG5O0kOdyfMXSgmxOiwwLOzxAIFIPt1tfO5INR2Jd7WvehYCi0z9d?=
 =?us-ascii?Q?t4qmFp5GH/77yw/KtR/oYyyV1QI1m1JyrfWq2WEB1kpiUmwAt6WQOvhVHMYe?=
 =?us-ascii?Q?MWLX/mmDFCP3/6tlyZCz5zDANzLnZk9Cy5zS0slxPC2h/srofPUdaTGAo8Wv?=
 =?us-ascii?Q?jV9RUbpIvE42JdYXBDjtrwbABjZt5tvlI+YXL26p2V366OFSdCCjeN+p7c+L?=
 =?us-ascii?Q?T0jfU+lG+vyRLKwIv5/Z3eq/OmFgSLnc9JXghV4tOYyciZF5fQ3xjMpQxt6i?=
 =?us-ascii?Q?RfTzBLODMojWZPS0JqLiT6T80jgfK10=3D?=
X-Exchange-RoutingPolicyChecked: gqKLnLbPyaAf0TffBYOklyqjYT5ab3qVQV1cpu3HTwEqJAD0wHXrUKGpjhKTZhNpNBp02utEumzABEkCNkAJZz+sgu0djrjislr8Zj9wUoXSN3bWVM3UiTNeD/ljLY9DzDcqJl71xUqB1J/52aq/m3SyJXNJbRPYVC56OxpkqgUvvybPZfwqcANeZt0E9ODSCcjZtj8JWW21oouYOXQG9nTO7f+XaxLGDfN3WutB1jxDwPlO6PEf5m2Ilx5OoSugHO0AyNaeB576uIahn68k5hnryZ9tBv4A5w3Os4ZnDd7FNnH2YHmC8lHl+FMLhTpjWr1vyLeuwAX83wz5qjV6CQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d318e8b9-e6ef-43d5-e420-08dee708bd6d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 09:16:25.8867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4VLh//D64Z0UhmEhlRIb0zMtB5OL3jPX2mZsiO7xcjg2tQXt9yNjiz5UGbHBRXFBCf/wp0IiMVMrhUwFOsxritlG/3Wcd9fP3RW0yRYXdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7293
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

When a context is saved and then restored, the timer delta is
calculated using signed 32 bit arithmetic on hardware written
value to PPHWSP/LRC image and previously stored value, which use
unsigned types. This difference may become negative for version
12, due to hardware quirk on these platforms. This in turn,
would cause -EOVERFLOW to be thrown inside live_pphwsp_runtime
test.

Similar case has been observed [1] and addressed [2] already,
so follow suit and disable the test here as well.

[1] https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/13697
[2] "73782fc64793 (i915/gt/selftests: Disable lrc_timestamp test)"

Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16521
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
 drivers/gpu/drm/i915/gt/selftest_lrc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/selftest_lrc.c b/drivers/gpu/drm/i915/gt/selftest_lrc.c
index 23f04f6f8fba..d5196ef4a1e5 100644
--- a/drivers/gpu/drm/i915/gt/selftest_lrc.c
+++ b/drivers/gpu/drm/i915/gt/selftest_lrc.c
@@ -1955,6 +1955,13 @@ static int live_pphwsp_runtime(void *arg)
 	enum intel_engine_id id;
 	int err = 0;
 
+	/*
+	 * Gen12 (TGL/DG2) has a hardware quirk, where CTX_TIMESTAMP may
+	 * appear to go backwards, causing sporadic underflow detections.
+	 */
+	if (GRAPHICS_VER(gt->i915) == 12)
+		return 0;
+
 	/*
 	 * Check that cumulative context runtime as stored in the pphwsp[16]
 	 * is monotonic.
-- 
2.34.1

