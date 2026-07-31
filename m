Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C76CC55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A06810F151;
	Fri, 31 Jul 2026 06:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XKV5N2l8";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9073210F151
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVq2y44a/ZPjARZ99WElG/z0mP9KW/wXRCfIpdR7qsOc175LT0/E3TZiADGQ3v9yNA1lQi42Ey1AMWk9fMKUGu/bG5MxfIjswsFm6L+d8gIG4f7JBVmYGb+hMZ6881amV96rn3hXp82s9RRQg35mHOyJ4oZXEBKItNIi+wsNzd4xo+6Z8LPZi+7/Usjx9mtTo3BBTuFm6vddcrxqxmRkKJzEvdhoKrNmtY4GoWAbxqvpx5TXs/eBZ1dGy+0jjRf408fgMUYMeNl2Jb3haiMsM0Ao65e0I3k9mLZYID1mu/4RMnkyD4Tj23eRr/W+fM4p8zt8HfdqijL+5vs1DRvB8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oota8pyk49vFmnUVxEJNDIdNOfbuvy8FAcPBPbKxU3E=;
 b=M1b/bRAPWOfaYa+C2NxW41tNontsozK2usnDIiqGXxUImyjR4lXtk9DSL8L8utS1DV5Y3ONQ29rnS5v70+0EuteKJeeR1YLeGALkuc/zVJ5BNoSSwRxb+z5IjNP7FD6QYZ2stl5dQs0kj+kEq7Y6mSDLKwUEOcW+dK68HAAiQ+kAwWysJ1GQ5sYdmExCHJ0UsGZF9Wk9ZWk1SmVb+wufxe2IvV7P2J0XnscPLa6thkHs13zQHbWtSe8VtPNKvunYV7HJ/5D9+KGaXf3bWyEvOp7vLXx273FzzLVrmm4/hzu4BqFnffeeLThgaHG/6YcHmlk+drukuy6WXEJ516q1Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oota8pyk49vFmnUVxEJNDIdNOfbuvy8FAcPBPbKxU3E=;
 b=XKV5N2l8Wp8vDs0+BHKfMQKlJXUDo+YcMmEqKLElaqDepS+YJejWvNsR1tVeMAwi2rBNnSKwRd9JM5WVfbtr8eeIMSVqZDoKpfTE1REp333iy4BHgA16ZuIGw9wziUmYCd1Le/FRYsmb0Z+turqOI3yW0PnHodl7oIBd6/LH4whZmLy0/Vh45RW25bH1HdVvttF2zMu3yabebtj6o+t3+ssnKv6MIIrQ0/ptmbN4RtcChO4QJGIXZtPFe/cdK8u1dfK4u/K9bTyMPOB3vOFmfbrh+ioUsaNbDRL3EYQYboIr6NZx4rTUBCBEVPzjwghsambsWKSLSK+ZY+NNJh61gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.15; Fri, 31 Jul 2026 06:04:47 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 06:04:47 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dri-devel@lists.freedesktop.org
Cc: nova-gpu@lists.linux.dev, jhubbard@nvidia.com,
 Alistair Popple <apopple@nvidia.com>
Subject: [PATCH libdrm 1/2] xf86drm: Pass PCI path rather than maj/min when
 parsing sysfs files
Date: Fri, 31 Jul 2026 16:04:14 +1000
Message-ID: <20260731060416.1400253-2-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731060416.1400253-1-apopple@nvidia.com>
References: <20260731060416.1400253-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0010.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5d6fab-4ec9-4bf5-86ac-08deeec99fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|6133799003|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: PPEefkGXPawjOkB26EDsDgtUB+Xw4ruwe/38SbmjQ1ylR4EZSH4ZDxWzAt85lGqbHj2DrSZvQTVn49vbkZk3205dMHGBRkdd/bmk1ajxXoGSAtawOVi+6yzizmbzZXw9BDNfIHX8zd04G+z6j8KLSgDQ4A80mzUJZjB2GBUp6exBa+4KaS0rhAkoCJ3IJ/8yrA8ngS77htCR6WSYf5zQWQDpZkPQNMiJzpde43mAuFrWqtygMQ/O/nc7PwoxnKGPlsfsbvOsuDtddlyIWG7eV2MRI8cr2bzGW2qfqVPCKI54OSpEk35L1sM/+RO5lLMDmMvlgqV26K/iSuVeq/V7/LR3G41ac0Gt7OUCBHS3CbIcpFOp5+hJ295+FtaultGK5htsIvqMUaRsu/6KilA/nsfo5nrZs5wgx+7xbxZoqdevuvH6wYqFPe5EXrp6KX5zI3YXOc2xDxeatW7QsYqKadhQdemf7dmZUFbHvzevJbXW6pJ+x1G9ytUuXCf2IS7Sbio3O+i0nk+x544P4cR3W2OWPkFjYrUKEHK72P3BwYETINq6NSGUpSfvVRDdq8LgiF/75AH79RObKca4ccb3Kw8seFTciDQSV1Meoy0gz0rtq6MjNe7wrJwBSl3jtvXk5bHqvJA/Etf7gztazODQ/N4VpurtEuotMSgHdoaTCW0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?70Rv1UN/bGOJJCveLU6btCbX8QRCIMaOm2QM8RkoLI6tBc6vpzcEVFjVZWx2?=
 =?us-ascii?Q?DnXTGY0w1LVcEMFEOvyzWzC6jYSrSBXxWhNotuHQM8yO+Xevj9h02pA/Nx+a?=
 =?us-ascii?Q?WkwMlJvcsnm8awd+Zcgheyz70YiHPnYj6t6nYbCIHgiio6fwr120F9i9O1RH?=
 =?us-ascii?Q?VcX/ZN4UBxDPmrXgjo76nKkRRjOuY8+RcDqEJXfyTTjBUA+y9bORPpWnKQ1I?=
 =?us-ascii?Q?UoNZBctynbDfFjQELe5eQC6yGGlIOO+VjTzlwNnUGSVmMjvjhX6yuBqTzhbo?=
 =?us-ascii?Q?y5vP++QpCFvBrb5axmVovXtu74sxL/JuOkX9o/cJD1cX7b6LoJlIS23gmo2z?=
 =?us-ascii?Q?7JE6f5WEXGTNAEM3OUv2UgqZ16O0ucF7cOyWxFnfXxEBWJbisdjQxhgTtisL?=
 =?us-ascii?Q?fY078bDKwxAD7Bga7qQpb6IeBvRRSDs4kiu541FxH8795epNbaHiiKOnVpZu?=
 =?us-ascii?Q?qfoQD4PPwo1/hX2U0GdnicANEMwFZy8l2tuJ5tJQzfjjhyFfrwkMQgSNMmwF?=
 =?us-ascii?Q?wqU5A2KI93CVtcSRJYYbib/AyOGGqMlVqildjR3ANlHXEEmrcF5PBRj4GIP5?=
 =?us-ascii?Q?wn36wbeei1LPgLRlLahYtAlfzpNOz+p9QywPiwBPIrxYNrLoszWPCZ/3udNk?=
 =?us-ascii?Q?8l5u9+B6OLdbPxH/c6/zHHIM7ftqziaW0aG8LBbGy4DDBGTadHAV/yO1P1ON?=
 =?us-ascii?Q?LW0GcwekBr/f8rtHRqlhs4gxw7qazXqwCNspxb5LObM3Lt0WHS39tlZr52JQ?=
 =?us-ascii?Q?Bp9/w8BKvALFwatwA1WT0jxTq97aSLdVnQcyefcO5QCjhhD2pXatVDcSTmDK?=
 =?us-ascii?Q?tcklZIAP4MMAJwiq/h3RdxgAQtKyB1FEDuDvEGpnXZSsJnlE7GqPJ8YX0uRw?=
 =?us-ascii?Q?4c4FdECar02GDeKOykDlJB1up0Xm4Jb3DKjSOs4p7wWNmi2K8w/1eChh50JM?=
 =?us-ascii?Q?lQIwF3vyIDG3rvRGmKZupfR9VCkDGeEsO8aq8YC1ZhmTdVP7DiCRYJ76gw0V?=
 =?us-ascii?Q?qFaw0KAEYo/suyOFIqXrA8p/jm8aeZhvcM54Ddu/BkBJ4+208crO14j+Dx5r?=
 =?us-ascii?Q?SCF95gR6PzrYsA4bjjmQ2TjHts5EZiPGeWSKK/bGXJI9POFmPSm2bxNIMOka?=
 =?us-ascii?Q?cnjo0V703NH70kCUA8ZAgeSCbc89ege4OcwefCduDax+1+8XyeoXKpoIz8Tr?=
 =?us-ascii?Q?G5Tdhsmfv7cRp/54cnN/YC96zLCsIPyYcJL+sxtyeXxLpechzQyN1P0lTBxh?=
 =?us-ascii?Q?CbItz7VT0DCpjIdU/bDvZhqhnYbQlNGgmo0+3bJcWXSVyD1yDPFkQpLJA0Eg?=
 =?us-ascii?Q?jwW01qrFf2klrvpvbuRObcdI5Nsu0+F6w4Hphq26kxay75qYQ6relXAG8CI3?=
 =?us-ascii?Q?3wYHnJ13agBZGYrKA3HmM6hpqh0SteTUkrhDys93x3YWvEfHv2Y8SUoM5qfK?=
 =?us-ascii?Q?fZIzwneLBG9LoWOhmMbRlmhRoHjs7lZ8mxAPN8StVisUo3eLhuMJBZCqWWm9?=
 =?us-ascii?Q?13ioZhNYD7VshP1OIRik1acsNsgBedr5vle1YIDVZYc7GT+2tmM8OTHoWr0P?=
 =?us-ascii?Q?p5U9ZnClgDLevbzq0m5FWGJsVinLxTjbM1GQn9OXhSbuS5wtEV6xQup/yj9v?=
 =?us-ascii?Q?4lpt9kZvaKdrotDvg/OniN3lafPf3Kt7GNmXNi6BvZFN2BoKIYThQpmkh4Me?=
 =?us-ascii?Q?fnejWKDyVrqb/fI0zV4oSzmS4/ntfbvb37n2cKOwqU369cqc4ADUi2erOr6F?=
 =?us-ascii?Q?ub7u+ZHWgw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5d6fab-4ec9-4bf5-86ac-08deeec99fdc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 06:04:47.2805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bo2RbHQrSzxB484lwjRqc3j0lj4nTN/4MLmjZweR9lrqgLrA552j1Uzqe+pqpMmJ4ofwgZWmkmYb0o3BIImSXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614
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

Both parse_separate_sysfs_files() and parse_config_sysfs_file()
take a maj/min device numbers and resolve the actual PCI path using
get_pci_path(). This was to allow virtio to resolve the correct path.

However there is no reason to call get_pci_path() in these functions -
in all cases the caller can call get_pci_path() prior to calling these
functions. This results in a minor code simplification for a future
change which allows callers to provide the PCI device path instead of
using get_pci_path().

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 xf86drm.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/xf86drm.c b/xf86drm.c
index a8b39a31..25f2a3ff 100644
--- a/xf86drm.c
+++ b/xf86drm.c
@@ -3833,7 +3833,7 @@ static int drmGetMaxNodeName(void)
 }
 
 #ifdef __linux__
-static int parse_separate_sysfs_files(int maj, int min,
+static int parse_separate_sysfs_files(const char *pci_path,
                                       drmPciDeviceInfoPtr device,
                                       bool ignore_revision)
 {
@@ -3844,13 +3844,11 @@ static int parse_separate_sysfs_files(int maj, int min,
       "subsystem_vendor",
       "subsystem_device",
     };
-    char path[PATH_MAX + 1], pci_path[PATH_MAX + 1];
+    char path[PATH_MAX + 1];
     unsigned int data[ARRAY_SIZE(attrs)];
     FILE *fp;
     int ret;
 
-    get_pci_path(maj, min, pci_path);
-
     for (unsigned i = ignore_revision ? 1 : 0; i < ARRAY_SIZE(attrs); i++) {
         if (snprintf(path, PATH_MAX, "%s/%s", pci_path, attrs[i]) < 0)
             return -errno;
@@ -3875,15 +3873,13 @@ static int parse_separate_sysfs_files(int maj, int min,
     return 0;
 }
 
-static int parse_config_sysfs_file(int maj, int min,
+static int parse_config_sysfs_file(const char *pci_path,
                                    drmPciDeviceInfoPtr device)
 {
-    char path[PATH_MAX + 1], pci_path[PATH_MAX + 1];
+    char path[PATH_MAX + 1];
     unsigned char config[64];
     int fd, ret;
 
-    get_pci_path(maj, min, pci_path);
-
     if (snprintf(path, PATH_MAX, "%s/config", pci_path) < 0)
         return -errno;
 
@@ -3911,11 +3907,15 @@ static int drmParsePciDeviceInfo(int maj, int min,
                                  uint32_t flags)
 {
 #ifdef __linux__
+    char pci_path[PATH_MAX + 1];
+
+    get_pci_path(maj, min, pci_path);
+
     if (!(flags & DRM_DEVICE_GET_PCI_REVISION))
-        return parse_separate_sysfs_files(maj, min, device, true);
+        return parse_separate_sysfs_files(pci_path, device, true);
 
-    if (parse_separate_sysfs_files(maj, min, device, false))
-        return parse_config_sysfs_file(maj, min, device);
+    if (parse_separate_sysfs_files(pci_path, device, false))
+        return parse_config_sysfs_file(pci_path, device);
 
     return 0;
 #elif defined(__OpenBSD__) || defined(__DragonFly__)
-- 
2.54.0

