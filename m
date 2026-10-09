Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F35CA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 06:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA18910FEB7;
	Fri,  9 Oct 2026 06:45:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fFqlJMCz";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013002.outbound.protection.outlook.com
 [40.93.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8915510FEB7
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 06:45:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWd/BDbyhot296SrH+bvz7oDrjspHc5J6hjhul3KRsVtwUxzW1mPNmX17xJotOiFmqjtTku78yy5FxN0LzYAFwAmLizR96iQbYPDOvJ9ZVzpz+1WokZxtfJPJrK1OBU5RJGtaCbNjcPilc5UHYssa6uR4Y8Ihc5yVQgTGFg3MiiwQf+hVXg+oEcxe1mL1sgLM8yht1F9d+/XFYrdax/soIXUukY8a225UOaLJFM75jjjuccIPP2VR3BrGFb4CjBdYXtdB7HufX8tJEjFAF2LH7izWEesNI58bsgG6lv2Uk3qG4hcEMSHbgBz2aqrPG6s+QcDQly2R2BSk2h4nLDI9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+4DRuyUn5Q/271HZhlLLASsCuCfULofWsk/vmie4hs=;
 b=MLI5g+13XpZyWJfApCqOZcQZMWNi5U7UJ6nv9UfUUk1qeikwJ4Qw4ksUm7Shzjy8dtkeRC/z7NnuMYDSAbueHJqpnE4qB4DazgvlYkA0oTlr3Y91lYeJehoPk9Nbu5fFxRJNlxFkEJB5t7StJeXzSjFFtTQ6IM9u5KbnoL/Xpy3wDVCXolAwDp7bx6OPKC7jpePRDgjpYG2piB8DGWoIjXYoBOTido8mpUKFbPSPVXdqrh+zcazz8rYdskpPizI4iASckozmh/nfm5WK6JnF6J1xa8FLGS/HjXMKdZRHZrOuVdmgIuReKBAovTdn9E3VH5PmzLdDDWQyTkL5bQ3K9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+4DRuyUn5Q/271HZhlLLASsCuCfULofWsk/vmie4hs=;
 b=fFqlJMCzXqb6tOBKgayzfk7hH2jWTO7/jBOJ2mNlIemlPI4yR+17kuO1P3yM5SQBAQngy6CkrqEPo5oI4iROtiqGgY1X9rXVQJt/9M/v08Je4dk0VmSQXWbH3RFN8NIOKvr8zLKOXPBJq6Hc4G2LEsLLRHllMVRVN8+/9sYHfUe21tayJlA14VX4fJbRRxaBFdcLgI6+1i++pOJ0CQoPLGjN9TjGFxRwFfZ8aOkcNZ3KorhNmUELzCqFr8O0I93muTP7BcG5T4rvR4Pqb9xGn2Rc141LTqVxAmnL7x+JP/ybV8JdTTdvZv+ota590vgX6SiE+eQLYmj6pfGrhXIkXw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 06:45:30 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 06:45:30 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 09 Oct 2026 15:45:03 +0900
Subject: [PATCH v2] drm/tegra: dsi: Unconditionally manage reset line
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-dalmore-fixes-dsi-reset-v2-1-90237a9461f1@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0Jm7RhahIAr72FYlHaQMUJNBxsN4
 e4WPIDLl7z/3wJCgUngnC0QKLKwnxLoQwZ2MNONkF1i0Lmu8qbI0ZnH6ANhz28SdMIYSGjGU1+
 oRjlr6rqCtH4G2pU0vrY/lld3Jztvd5sxsMw+fPZ0VJv3vxIVKixr2zil+5I6d5kiOzZH60do1
 3X9AiJl7dLRAAAA
X-Change-ID: 20260930-dalmore-fixes-dsi-reset-4f3191dca886
To: Thierry Reding <thierry.reding@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, dri-devel@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TYCP301CA0066.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::7) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS7PR12MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: fe9c2752-5a70-4473-4b31-08df25d0e8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|23010399003|10067099003|56012099006|11063799006|10063799003|18002099003;
X-Microsoft-Antispam-Message-Info: HaITciirQt5kvDhw1xO6Imy0VJoHzXGLpya6F7MIThyIuvnuvVyOmzCUNlzYnLObMcElGhXw16qbQtR3EbjAcKCP89J+suyyAiTkcRoy9f+HrKfmzR4i81TI7sR2gMAbD7oFZs/ZFrJP7I8LpiWU/c7JwCdA/8j5kLD3nN9ISJpWg/Dgv2RhPi3490T4DdpQJupyAFGnOSl/RBsc1cPOvrEriOVLptdnvkTupnaULT/UpiXUbxfHD1PUjNEkXI9UzY4me98lZHDHANsV8lAXvD/EYUGeqMdb0b/69tJ9FW52khZd6ym4k0oaqc6qrHRoDS1Y86NDS+Z/QilJd2ubm/OIrhc1fBQjfki2hNw9Z6CGZt5TxTMiCPzIYfUt5nHpZOrcXiyHcC0Ep7KgmPAAO6OWQ11fNG/pUbAe8/JilZJgE+DLeGVnkAAT00LUMl/HlMhLzXqwjDC80Gvmo92iMH/F0mqPfmfKKj35kKM+0e1pLek8B7p1l7/ohZF4gsOkJ0KFdYuHXfZSoB5OI+oVcWMsavSuI0b45qWBFDajLZF/N0Wb+tbiZYDkc5yNiFgm9r5BTU/MbC/DmIUNLTbAtZgpBdfyN2egbeoBcQ3/swRA5ziZLuQu0g1g21btkCy61rKNYxMyzMrQjdymwm8F7gDOhfAgj/DtugSlu1DzNjY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(23010399003)(10067099003)(56012099006)(11063799006)(10063799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGFLQ2JNWWNtODNZNElVNUhpeHdnL0xVQnRGMWkxRnJpQklmNnZUazMza3cz?=
 =?utf-8?B?REVUbDlPRHhRUDl0RHhnazdOc09CR1BySFdtM2tjRy9lV1BUV2VpSUVkcWxJ?=
 =?utf-8?B?R1VaSHg0MDVyRTFiYWZXenRUZHREWEZaNW5YS1FBQXZSbFF3SWlnOHRKcGhi?=
 =?utf-8?B?OGIzSXBpZUJnYk5TNE85dktvREY3eE5jSUhtZkVNM3pTOVJPaTYvMEk5Yitq?=
 =?utf-8?B?cmVDQUp1Nk9iczhUV2JmQ2s4bFRXY3M3bzZEUWF1WDhRT09QM1dJVUR6ejY5?=
 =?utf-8?B?bWlFN3lKN20zdkNuNFFmWkpXNzZ4QkpYbm41ZERzVWhyZHFhTTBWZjJFajNv?=
 =?utf-8?B?NmxzNGhXV3VYRkhmVXRBOURqaGYwWE1uR0hrYjlxd2pDNUVhRFYxT1NXeE1P?=
 =?utf-8?B?bVluMFJMNDV6c2lqYXZ1UzdlTHAyUmZoQzgyWktVWlhZbVZHU0dOeDRwMUtI?=
 =?utf-8?B?MkJHUjNRTDBJK0Z5dGR5Vi95MUZnMGdtK2luVGp2R1VBTWtyWHd6ZmRqWHRx?=
 =?utf-8?B?THNHL3BqSzBIWW5VOTM1R1lkYk11VE9XVTFzYTFpQzFHZHhnT2RzalNhQkxS?=
 =?utf-8?B?ZG5LK1d2K2Mwd1AvUmRveEE4LzZJSDZaWVNMU1RlZmd4cTdVKy9POGVoN2Zi?=
 =?utf-8?B?aU1qK1d3ejhQRHM2ZkZXM1RxQmVLTnhYaTV3OFJmZTBHSGtpMUx2WkpZM1p1?=
 =?utf-8?B?ekdLQWF6MjBKZkQ1VUhKeUExVUFJZVFHY1gzSGhhZGpZMVkvaitLS2tQT3Fl?=
 =?utf-8?B?cjF5cExETldSeTM2VXBMcnpUT0N2cXRMOStzQVFCSXJWTnNzdklNTTFBQUxy?=
 =?utf-8?B?aHNqaUh2UitPdklaMVE0OTN0eUExa1htcXQwMTMxU1VyNjhkc1FWU3JBbEhJ?=
 =?utf-8?B?MXVhblNQS3BhUnNyaUJ4MTJjamhvYlZrd1UyMGo1QXhBemtmLzY0UzBBbmNH?=
 =?utf-8?B?UmNGQXVNa3VkMm1DSk9uTEhYZXplR0lmMjZXeWRkUEpuS0tETy9ua1N6UWlQ?=
 =?utf-8?B?ektQaWw2dmRTY280dW9QNlhkdENMeGZSaUdIdXBCOXFJTGN6VFM0QTVoSzcw?=
 =?utf-8?B?S1cySmlYMVd5S0ZNa2xWZkROMXEyZnhKTjBSZXJ3TkhqM2xmQW5pL2ZIMlBH?=
 =?utf-8?B?bkJ0ckNpYkl0TjFCQ0ZPbDVqd2h3ZUI0S1VnNitOZjljUkhYWnpsamdGUWdE?=
 =?utf-8?B?a2VUZUkxYmxvNmFKZjVQVWJ1MUkwem9SNi95Z0piNWZieG5DUUxjUkx1Umtn?=
 =?utf-8?B?RXNnR2hyNFFPS1Z0c0pCVUhrWEFtMmVvSTR2WDBoOFowM2ZKb0x3MUVFaFdj?=
 =?utf-8?B?cGdsUU9uc2REOFI5VXoyblorZDlidHVLMTlKV2s5V0IxU0gvdnpsb2tkQ0pt?=
 =?utf-8?B?bk02Tm9lY2wxUDY3TnppcXFqTVpydXM4bTE2Y1J6UDAxVmVzTlZIMmZJaFpw?=
 =?utf-8?B?Lzg0RWpaRS9qMGNnbGMwTy8yQVhQc24ya1ZqU1huTW9pK3JGUXp2VVFDTWRB?=
 =?utf-8?B?UGZGMDVMQ21aVVFRS1JObXpKUWpNMTdhN25LLzc5NFdWTUhoMVBnaklYWXFt?=
 =?utf-8?B?ZjYvY1pvd1RJa3Y1UXVVTy81bTczL1FLUGpqQ1VVTVNuSmZmcUhieHBybnh0?=
 =?utf-8?B?cXZPNnhncVdrbE91SjNjNnEvREpidCtvRWpBUWo3QkdGSzUrdjRRVVlQTEJ4?=
 =?utf-8?B?MDkzeHl1ZXJxQ3l2THZDWUQwd0dmb0NBWERmMUVNWUlpa2REMmtVelZzeWR2?=
 =?utf-8?B?U3NuOFF2WlJVYjl3cVJhTWt4NXB2cVFQUWtBcklwQ0xjZkNmRWNYdmNzc001?=
 =?utf-8?B?dGh4RFdRUzREdkxSWjVIdnVaZFUwR1JFYkdxMUZZblRpd1h0WXRZTGpaSDkv?=
 =?utf-8?B?amVhdmFIWURLN09TMXE4RUw4cEM1eGsycVBIUHhFdlFYZ3BRZkZ6d0NQYWti?=
 =?utf-8?B?ZTlCVlF3dlJhYnRWaEJEcmdaZ1RmNEp6ZEVUbVBHSmdCZXdYaUQxYWpRWUVh?=
 =?utf-8?B?RDRkbW4rL2ZZb3ZUajRrb0NiT0VJTk5BTjlTcFpyZkNXcWdQR25PNnBCWitm?=
 =?utf-8?B?VVlTc2VNd01kQ2E5Nlc4MUFLMnZBYlZtdjBySkpMTENCQzVjTStqMCtTQ3VI?=
 =?utf-8?B?RVNDVVoreEJXUVhkQkwzTTNDYjBzaHB5VjQydUlidURMby9LeklkNTBRRkdk?=
 =?utf-8?B?VmRyUERBTFVOUHl6ZC82UG82SmpoWHh2eW1ZWmp1K0JnOVNlN0puQVkrcWxt?=
 =?utf-8?B?ZG9FRDlLVlhYQjQ0NmwzVW10RktWQ3FCd0E1cHhWUERGWHIwbG1sQWJZWXBk?=
 =?utf-8?B?Nk1SSVRDQU10ekdUMDgzOVkrYWRQeVplZGIyb2liVVhLczNpaFR1MTBDakJI?=
 =?utf-8?Q?/tzQSHqQ73xb7euCuzSstaV+D7KGN1evm6mZigKMpRGc5?=
X-MS-Exchange-AntiSpam-MessageData-1: F3r+Db+N890L7Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9c2752-5a70-4473-4b31-08df25d0e8e9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 06:45:30.3208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: McQ7AmS/sXqq1d2vRd/UVQXMsuLRPAdf4VSAUB4idMShsRnUdIenFj0QI/J5OpYTIPaG+xH9EwLNWUV41TVFYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9473
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

The DSI driver ignores the reset line if a power domain is configured.
This was originally added to support Tegra210, where the power domain
provider has to control the reset line -- at that time, older SoCs
didn't have a power domain for DSI, so the driver continued to manage
the reset line.

Now, however, Tegra20/30/114 place DSI in the core power domain, causing
reset management to be skipped. On Tegra114, DSI should be placed in the
DIS power domain where PMC could manage the reset, but that power domain
hasn't been implemented yet. On Tegra20/30, there is no such power
domain.

On many platforms this seems to happen to work, presumably due to the
bootloader bringing DSI out of reset. However, on Tegra114 Dalmore this
isn't the case and the system ends up hanging during boot. Fix the issue
by managing the reset unconditionally - while there is the alternative
fix for Tegra114, for correctness this is required on Tegra20/30.

While the power domain may also access the reset, managing it also in
the driver is safe -- asserts/deasserts are done in runtime
resume/suspend where the device is guaranteed to be powered on from the
power domain's perspective. Hence we can consider the additional reset
assertion just a "runtime reset" independent of the power gating
sequence. Ownership of the reset line is also no longer a problem with
reset acquire/release semantics.

Finally, the device tree bindings already require the reset and it is
present on all platforms, so this is safe to do.

Fixes: 4cc90d4c043e ("ARM: tegra: Configure Tegra114 power domains")
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
Changes in v2:
- Based on offline discussion, updated commit message to clarify
  that the reset management is safe and does not interact with the
  powergating sequence. Also other commit message improvements.
- Link to v1: https://patch.msgid.link/20260930-dalmore-fixes-dsi-reset-v1-1-58c9d12f5ebd@nvidia.com
---
 drivers/gpu/drm/tegra/dsi.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index cb88aafbd36f..7124cf648a1a 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1113,14 +1113,14 @@ static int tegra_dsi_runtime_suspend(struct host1x_client *client)
 	struct device *dev = client->dev;
 	int err;
 
-	if (dsi->rst) {
-		err = reset_control_assert(dsi->rst);
-		if (err < 0) {
-			dev_err(dev, "failed to assert reset: %d\n", err);
-			return err;
-		}
+	err = reset_control_assert(dsi->rst);
+	if (err < 0) {
+		dev_err(dev, "failed to assert reset: %d\n", err);
+		return err;
 	}
 
+	reset_control_release(dsi->rst);
+
 	usleep_range(1000, 2000);
 
 	clk_disable_unprepare(dsi->clk_lp);
@@ -1164,16 +1164,22 @@ static int tegra_dsi_runtime_resume(struct host1x_client *client)
 
 	usleep_range(1000, 2000);
 
-	if (dsi->rst) {
-		err = reset_control_deassert(dsi->rst);
-		if (err < 0) {
-			dev_err(dev, "cannot assert reset: %d\n", err);
-			goto disable_clk_lp;
-		}
+	err = reset_control_acquire(dsi->rst);
+	if (err < 0) {
+		dev_err(dev, "failed to acquire reset: %d\n", err);
+		goto disable_clk_lp;
+	}
+
+	err = reset_control_deassert(dsi->rst);
+	if (err < 0) {
+		dev_err(dev, "cannot deassert reset: %d\n", err);
+		goto release_reset;
 	}
 
 	return 0;
 
+release_reset:
+	reset_control_release(dsi->rst);
 disable_clk_lp:
 	clk_disable_unprepare(dsi->clk_lp);
 disable_clk:
@@ -1623,12 +1629,10 @@ static int tegra_dsi_probe(struct platform_device *pdev)
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->lanes = 4;
 
-	if (!pdev->dev.pm_domain) {
-		dsi->rst = devm_reset_control_get(&pdev->dev, "dsi");
-		if (IS_ERR(dsi->rst)) {
-			err = PTR_ERR(dsi->rst);
-			goto remove;
-		}
+	dsi->rst = devm_reset_control_get_exclusive_released(&pdev->dev, "dsi");
+	if (IS_ERR(dsi->rst)) {
+		err = PTR_ERR(dsi->rst);
+		goto remove;
 	}
 
 	dsi->clk = devm_clk_get(&pdev->dev, NULL);

---
base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
change-id: 20260930-dalmore-fixes-dsi-reset-4f3191dca886

