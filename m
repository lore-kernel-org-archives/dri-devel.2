Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFE7C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C67410F156;
	Fri, 31 Jul 2026 06:04:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="tMpAz463";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012052.outbound.protection.outlook.com
 [40.107.200.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED18310F156
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:04:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJFQHyhWhQxaVmD3V5jFA6KnEDvzcJJ4Xwt4tPdyTMMy0gg6q4dYSZj0PIvQBvleyTc8KhVVPdCX2nxo5Fiy0MKGl1EN1nNvtDUyz5D2Wo1ghQTKKYjcCVLHONmRKrC5KJhATyBADimMXY3EsVP6N1BGUdQNS5xwv7ky99Nafh2smqDSeMbYnvnQp8sblRRTvTtZp0T9VpiYRLXv78dNjlyXx0j8thm134KL3PyW909fnmuPyalQfmC5q+McOgMnukjrpA7v5FgY+wPM+5XQJDVgIoNezqg9Ok0MSbvQqDJwnilhYs2N4rTyaHPrmoRhMihZ3TBPqsRLmYh8jTDb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EE0zxclNyJTphJwDnbc9WGqaMa2UnZj8OxhcYLMZ/AI=;
 b=fnKjBnJoLibLW1mX8ST35xxqgn+JpU8Q30aw+GarEodAPaC4wr060zbJxsVNRukxjajuEoNMvaRrdGUYc/QHZ12hIUjs0I+m7PKl8dMiTnfhVc1IR2yCoxCDjXJfvV4qUURSSMVTTGm3J+y7xGvyh3UsNdXDNm23PGWtrFdLyMgektbp61L2kWuERkOw0YwIh1d1Qz0VaX5OMph6SBc7mAM2fVmnj+IIwV+EaT4pyboA+31r1VmWACwqHU7IbFRHG9xdFmF2jcGG4jG5BXPXk0isyeQENK92GoLztwzjejk3dT/ZAQ/kKNsGiaBdCZo4PowobI5ych3pbtzxxe3Rkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EE0zxclNyJTphJwDnbc9WGqaMa2UnZj8OxhcYLMZ/AI=;
 b=tMpAz4632qCcKozJaY57QZamebZBIJ1uRw/QSw1S2rEexLNaLPi+1Nt5YXp5mXCXwC2TijGzxwmCtSCysiUaHXXFPmGk4wyxuo4blnE7YQd/JBgng3FUfZuM2bbxFaT+1x3sn8HvAtHdUHvj1oCYDPaHVedNlrbl1y32Qn9ZNft3Kw6np8dG8XApACrGmh7IhKYG0gDZrX4dim/Nqc9pRy4WR5KAymUpjcrXYnnZ09W9hMhPyK12INdhUcSoeSoSQRah9uCjWFd2BrzG01rn9dv7/ML2QJ7yedxm18wunEesQ0hD4XVlPEnqb0TKGvCCckPfP/fMYRdQeJIo+gUqVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.15; Fri, 31 Jul 2026 06:04:52 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 06:04:52 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dri-devel@lists.freedesktop.org
Cc: nova-gpu@lists.linux.dev, jhubbard@nvidia.com,
 Alistair Popple <apopple@nvidia.com>
Subject: [PATCH libdrm 2/2] xf86drm: Expose auxiliary bus GPUs as
 DRM_BUS_AUXILIARY
Date: Fri, 31 Jul 2026 16:04:15 +1000
Message-ID: <20260731060416.1400253-3-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731060416.1400253-1-apopple@nvidia.com>
References: <20260731060416.1400253-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0038.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fd::11) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 28772847-651b-485c-c416-08deeec9a2cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|6133799003|11063799006|3023799007|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: DGUu6GfAjHX+jsdhIfDdfouE6a0ua0F4DY/ztc6l7LZois42VJ3jeuQjT1G/xUVzeDLMppHXJZowJhWfOqqz1NV21zBG6hKe/uX38Srt4VHDUC2dKq7RMpv1EQ37AZ9fYtWLJPsMg5idk2/1RxXmCMZ/R+fABa4IYY+tlBfPM08cGFyNQo9nf0gT45iERL0kMbobatHgQnF75Gy+yJ9Cl8ODl54R3ftiBdPxQgh9JBlF0am58qadcp9JVDspPLFT/FDdoFrF7iNSKK0wkj59Ljw09f7VPF6qReU7xIc8jUkmwbNzeCYp4AmYTJwg7m+uYhMw1bDuuElswJzsgCJEh3BLbZjv1lPe7zIsQ18UzV+su/A5FQluh0hCRKLdLok2qnEvc2C88uwS8mkqIWxvBuaByYTJF10Ou6Njh/NyReXte2jUionK0tBZ4dzRo7SbDd6vpW97hlIyom7vG6qmWYrLxVOi2IFuzCJtGftmM3DjS6+lYBykIKiyjvNkED1WYc5eCv5kXwXGtZj3zLzgRpTneW6IgRZ701Cy8b/Wrn/iRDUx3pYFfREiYAoXyJQfYRHk5cKG7ynjmasIBtCj/dv++zghGMvn2zSKJ24gem9+jjL1wGyPbrY0vHnZDfgmdD3eMn17rpgUaSH45aqzlUbyxKmwmcLOQpMqW36TD4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(11063799006)(3023799007)(56012099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vUk9BLUI5ctHt+4LKd6JkUMsIklBMlB0FTVr/6Rz2TFzv0Zx85vAPIob2s2z?=
 =?us-ascii?Q?IbkAuY5jqA3cNLZPdlStH1XrgCASYEbDRjKeAjtSsUARsYsnjqhzn8w5f6g6?=
 =?us-ascii?Q?tjghCWJcLB7Rq12S46IUbPCUFeUAxra/MtznNaP/YidJdK3l9wVwK1f6t1oR?=
 =?us-ascii?Q?qkBBGJ7GDO878COldg7rpgNzlNCYklzGptSRBVDNJnLDgJ7u/bNM5aAoEIED?=
 =?us-ascii?Q?nDu7gtXHgqkNegpT5yyl7X6ChBbMlwfD7sz2AQYhRz/T5yigLdhPS65FzpMY?=
 =?us-ascii?Q?0vRRqVp2urarIvZjQqhOSVMd/J6xyiI8MfiUzvybmz3n+qPM5JNY0HRQL7Na?=
 =?us-ascii?Q?JryYhKkiQg0DRARnCRnabWOIVuWxfKNyVgbg923wAELTuajz0WeV5FLJHzuo?=
 =?us-ascii?Q?OHCDMx+BoQoeXCXlleAYw0udx6Q39iGMgaIxui3TiHTl6Ffo77XivmrjsDJD?=
 =?us-ascii?Q?wfZJiEQ4Cw0UvxBums0KhJCs0oKUU+mdklikjAm90Q7yyXMr/3pi3UPesORj?=
 =?us-ascii?Q?TN2+K0gqWQyffGjOLqzsgVEWmXCLybDfp47/keU3/pPUFtnHbsAEbBEHjH7G?=
 =?us-ascii?Q?yUwt6PXVlybmOPRVbwd4URXKmHiJG01Nz4CWeyDZpZwOhZ+g8w5WNjR/Ypu5?=
 =?us-ascii?Q?3kmut5aEuKz3B6tcCjoR6BZ4/FydbZbrVG1aQWAx3e/cYuSNZpIoYk5dorwT?=
 =?us-ascii?Q?+Gf0azMm3WDKNejaUEMdN1teKmGH4eVgpVNq+UcCjv+rFIHqj9LsP+/L5RAx?=
 =?us-ascii?Q?JOPNBddmv3Z/hEBUTyRGs7ZFth1gpYtbYqdVKmB7SD5wDDu0zkJM6V/3+VyH?=
 =?us-ascii?Q?39jPz2OmecYEwnkZciIW03a1fDIByw6WihOCVvUPBqn31ti7mJg7fVtfPoQ2?=
 =?us-ascii?Q?WmX+Fh+Dn9ljTb4aeE4iYi7tFwgFGk0iecBzwtmmMsjU1QaXUttLdgmqODS7?=
 =?us-ascii?Q?jnhK6RoEWRgcgqYfC36mOdKSDgPWYnpfcKOy/btPmGd0w4UTriNgoF6LiPdm?=
 =?us-ascii?Q?FRjNfKaBe4Vlc6G/HJyrmWtdh4LiLDGd8FZdfwSIeFO7A5FaCXlmvPD7Z8KO?=
 =?us-ascii?Q?KI7g5hsAZtpy06UiulXVPgQMTSAcYfntBRgT3nGLnTRGNPDu9Kth/zDQ5nU6?=
 =?us-ascii?Q?NdOd7olWtBhIVAMcJlTmmtyct1G//t8q5KDUUAEiGVRzMJs5LeG3fpjbidAC?=
 =?us-ascii?Q?C3efIt2W+E0g4+uAazEF2tnRiD5sT91y60es0ojnSpGBDmAU0kl43s/MPL3Z?=
 =?us-ascii?Q?3E1hdq0X1yUyP0SYX7qh/sEgh8d5v5DXOMg4X7FtjCYlg0X/8rt9tvxAw09L?=
 =?us-ascii?Q?RE2rg36bcJJmPpcnApX5N+BEgBWNZHKwNQRtihGBpUoawvvoCBhJaL65SfsA?=
 =?us-ascii?Q?SPmhysSA7/WXCyhijpmvuf8zjwmUtvJ6cCt5jmVG6f+OHhw1XZgKAWLFgC2Z?=
 =?us-ascii?Q?eLtYr7Ze4Pa62odnOQk+0QOTLAJ7Yqs9xMd05FIUsUnJLZVhpUOSqGwpLP0G?=
 =?us-ascii?Q?cJxM/z/Q+wt1xGWMYB31Wfe11Cv0WAZ9+h4E3TUTzabFY2dxR3GSROGgoRfZ?=
 =?us-ascii?Q?9Ska2wIOCQnVi5urzVCrgiGMQSZNseiIJonR26aioLibyMzmvE4+dhmFiiyW?=
 =?us-ascii?Q?7zvmPcAUFQMGEwiKubnO6COcAmQozzU7WxyO6N5sFOSuS1bzBaT+8Dmcc35h?=
 =?us-ascii?Q?4xPKF/NNIUYGs3hD8oglOWsBCfpWl7pZ/kMD1dhxx3zfWU1bj3jzCfWR0ste?=
 =?us-ascii?Q?7JqypT9dYQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28772847-651b-485c-c416-08deeec9a2cc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 06:04:52.3491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DyNaEj5BDbihXx0Et9isVUxWxULU7naRAy86DxEEMF11mqA6/qQ87j9IqSRBuYCeopf2psCKYdpvIzjvuT7jaA==
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

NVIDIA GPUs supported by the nova-drm driver appear on an auxiliary
bus created by nova-core which binds to the physical PCIe GPU
device. To allow these to be enumerated and supported by libdrm add a
DRM_BUS_AUXILIARY bus type.

As the auxbus may in future contain multiple sibling GPUs for a single
parent we can't take the virtio approach of just reusing the PCI
subsystem parsers and searching up the bus for the PCI device.

Instead we add a proper auxbus parser and device. The bus info carries
the backing PCI device plus the auxiliary device name which uniquely
identifies each GPU even when siblings share a PCI parent.

As the auxbus parser already knows the parent PCI device there is no
need to scan up the bus like virtio does. Instead we modify the existing
drmParsePci functions to allow the device path to be passed in directly.

This relies on the auxiliary device being a direct child of the backing
PCI device in sysfs. The auxbus parser resolves the DRM device's sysfs
path, records the leaf as the auxiliary device name and strips it to
obtain the backing PCI device path. If the parent is not a PCI device
the PCI parsers fail and the device is skipped.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 xf86drm.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 xf86drm.h |  12 ++++++
 2 files changed, 121 insertions(+), 8 deletions(-)

diff --git a/xf86drm.c b/xf86drm.c
index 25f2a3ff..bb22fb11 100644
--- a/xf86drm.c
+++ b/xf86drm.c
@@ -3597,6 +3597,7 @@ static int get_subsystem_type(const char *device_path)
         { "/host1x", DRM_BUS_HOST1X },
         { "/virtio", DRM_BUS_VIRTIO },
         { "/faux", DRM_BUS_FAUX },
+        { "/auxiliary", DRM_BUS_AUXILIARY },
     };
 
     strncpy(path, device_path, PATH_MAX);
@@ -3722,14 +3723,23 @@ static int get_sysctl_pci_bus_info(int maj, int min, drmPciBusInfoPtr info)
 }
 #endif
 
-static int drmParsePciBusInfo(int maj, int min, drmPciBusInfoPtr info)
+static int drmParsePciBusInfo(int maj, int min, const char *pci_path,
+                              drmPciBusInfoPtr info)
 {
 #ifdef __linux__
     unsigned int domain, bus, dev, func;
-    char pci_path[PATH_MAX + 1], *value;
+    char resolved_path[PATH_MAX + 1], *value;
     int num;
 
-    get_pci_path(maj, min, pci_path);
+    /*
+     * Callers that know the backing PCI device (e.g. auxiliary bus devices)
+     * pass its sysfs path in directly. Otherwise resolve it here, possibly by
+     * searching up the bus hierarchy (e.g. in the case of virtio).
+     */
+    if (!pci_path) {
+        get_pci_path(maj, min, resolved_path);
+        pci_path = resolved_path;
+    }
 
     value = sysfs_uevent_get(pci_path, "PCI_SLOT_NAME");
     if (!value)
@@ -3803,6 +3813,9 @@ drm_public int drmDevicesEqual(drmDevicePtr a, drmDevicePtr b)
     case DRM_BUS_FAUX:
         return memcmp(a->businfo.faux, b->businfo.faux, sizeof(drmFauxBusInfo)) == 0;
 
+    case DRM_BUS_AUXILIARY:
+        return memcmp(a->businfo.aux, b->businfo.aux, sizeof(drmAuxBusInfo)) == 0;
+
     default:
         break;
     }
@@ -3902,14 +3915,21 @@ static int parse_config_sysfs_file(const char *pci_path,
 }
 #endif
 
-static int drmParsePciDeviceInfo(int maj, int min,
+static int drmParsePciDeviceInfo(int maj, int min, const char *pci_path,
                                  drmPciDeviceInfoPtr device,
                                  uint32_t flags)
 {
 #ifdef __linux__
-    char pci_path[PATH_MAX + 1];
+    char resolved_path[PATH_MAX + 1];
 
-    get_pci_path(maj, min, pci_path);
+    /*
+     * Callers that already know the backing PCI device (e.g. auxiliary bus
+     * devices) pass its sysfs path in directly; otherwise resolve it here.
+     */
+    if (!pci_path) {
+        get_pci_path(maj, min, resolved_path);
+        pci_path = resolved_path;
+    }
 
     if (!(flags & DRM_DEVICE_GET_PCI_REVISION))
         return parse_separate_sysfs_files(pci_path, device, true);
@@ -4111,7 +4131,7 @@ static int drmProcessPciDevice(drmDevicePtr *device,
 
     dev->businfo.pci = (drmPciBusInfoPtr)addr;
 
-    ret = drmParsePciBusInfo(maj, min, dev->businfo.pci);
+    ret = drmParsePciBusInfo(maj, min, NULL, dev->businfo.pci);
     if (ret)
         goto free_device;
 
@@ -4120,7 +4140,7 @@ static int drmProcessPciDevice(drmDevicePtr *device,
         addr += sizeof(drmPciBusInfo);
         dev->deviceinfo.pci = (drmPciDeviceInfoPtr)addr;
 
-        ret = drmParsePciDeviceInfo(maj, min, dev->deviceinfo.pci, flags);
+        ret = drmParsePciDeviceInfo(maj, min, NULL, dev->deviceinfo.pci, flags);
         if (ret)
             goto free_device;
     }
@@ -4521,6 +4541,84 @@ free_device:
     return ret;
 }
 
+static int drmProcessAuxDevice(drmDevicePtr *device,
+                               const char *node, int node_type,
+                               int maj, int min, bool fetch_deviceinfo,
+                               uint32_t flags)
+{
+#ifdef __linux__
+    char path[PATH_MAX + 1] = "";
+    char real_path[PATH_MAX + 1] = "";
+    drmAuxBusInfoPtr aux;
+    drmDevicePtr dev;
+    char *ptr, *term;
+    int ret;
+
+    /*
+     * This assumes the auxiliary device is a direct child of the backing PCI
+     * device in sysfs, i.e. the DRM device's sysfs parent is the auxiliary
+     * device whose own parent is the PCI device, e.g.
+     *
+     *   /sys/devices/.../0000:01:00.0/nova-core.nova-drm.0
+     *
+     * Resolving the DRM device's sysfs path therefore yields the auxiliary
+     * device path; its leaf is the auxiliary device name and stripping the
+     * leaf leaves the sysfs path of the backing PCI device.
+     */
+    snprintf(path, sizeof(path), "/sys/dev/char/%d:%d/device", maj, min);
+    if (!realpath(path, real_path))
+        return -errno;
+
+    term = strrchr(real_path, '/');
+    if (!term)
+        return -EINVAL;
+
+    dev = drmDeviceAlloc(node_type, node, sizeof(drmAuxBusInfo),
+                         sizeof(drmPciDeviceInfo), &ptr);
+    if (!dev)
+        return -ENOMEM;
+
+    dev->bustype = DRM_BUS_AUXILIARY;
+    dev->businfo.aux = aux = (drmAuxBusInfoPtr)ptr;
+
+    strncpy(aux->name, term + 1, DRM_AUX_DEVICE_NAME_LEN - 1);
+    aux->name[DRM_AUX_DEVICE_NAME_LEN - 1] = '\0';
+
+    /*
+     * Strip the leaf to get the sysfs path of the physical PCI device to pass
+     * to the PCI parsers. If the parent is not a PCI device the parsers will
+     * fail and the device is skipped.
+     */
+    *term = '\0';
+
+    ret = drmParsePciBusInfo(maj, min, real_path, &aux->parent);
+    if (ret)
+        goto free_device;
+
+    /* Fetch the device info if the user has requested it */
+    if (fetch_deviceinfo) {
+        ptr += sizeof(drmAuxBusInfo);
+        dev->deviceinfo.aux = (drmPciDeviceInfoPtr)ptr;
+
+        ret = drmParsePciDeviceInfo(maj, min, real_path, dev->deviceinfo.aux,
+                                    flags);
+        if (ret)
+            goto free_device;
+    }
+
+    *device = dev;
+
+    return 0;
+
+free_device:
+    free(dev);
+    return ret;
+#else
+#warning "Missing implementation of drmProcessAuxDevice"
+    return -EINVAL;
+#endif
+}
+
 static int
 process_device(drmDevicePtr *device, const char *d_name,
                int req_subsystem_type,
@@ -4564,6 +4662,9 @@ process_device(drmDevicePtr *device, const char *d_name,
     case DRM_BUS_VIRTIO:
         return drmProcessPciDevice(device, node, node_type, maj, min,
                                    fetch_deviceinfo, flags);
+    case DRM_BUS_AUXILIARY:
+        return drmProcessAuxDevice(device, node, node_type, maj, min,
+                                   fetch_deviceinfo, flags);
     case DRM_BUS_USB:
         return drmProcessUsbDevice(device, node, node_type, maj, min,
                                    fetch_deviceinfo, flags);
diff --git a/xf86drm.h b/xf86drm.h
index b45337a4..654e4caf 100644
--- a/xf86drm.h
+++ b/xf86drm.h
@@ -844,6 +844,7 @@ extern char *drmGetRenderDeviceNameFromFd(int fd);
 #define DRM_BUS_PLATFORM  2
 #define DRM_BUS_HOST1X    3
 #define DRM_BUS_FAUX      4
+#define DRM_BUS_AUXILIARY 5
 
 typedef struct _drmPciBusInfo {
     uint16_t domain;
@@ -896,6 +897,15 @@ typedef struct _drmFauxBusInfo {
     char name[DRM_FAUX_DEVICE_NAME_LEN];
 } drmFauxBusInfo, *drmFauxBusInfoPtr;
 
+#define DRM_AUX_DEVICE_NAME_LEN 512
+
+typedef struct _drmAuxBusInfo {
+    drmPciBusInfo parent;               /* Underlying (physical) PCI device */
+    char name[DRM_AUX_DEVICE_NAME_LEN]; /* Uniquely identifies the device on the
+                                           auxiliary bus, e.g.
+                                           "nova-core.nova-drm.0" */
+} drmAuxBusInfo, *drmAuxBusInfoPtr;
+
 typedef struct _drmDevice {
     char **nodes; /* DRM_NODE_MAX sized array */
     int available_nodes; /* DRM_NODE_* bitmask */
@@ -906,12 +916,14 @@ typedef struct _drmDevice {
         drmPlatformBusInfoPtr platform;
         drmHost1xBusInfoPtr host1x;
         drmFauxBusInfoPtr faux;
+        drmAuxBusInfoPtr aux;
     } businfo;
     union {
         drmPciDeviceInfoPtr pci;
         drmUsbDeviceInfoPtr usb;
         drmPlatformDeviceInfoPtr platform;
         drmHost1xDeviceInfoPtr host1x;
+        drmPciDeviceInfoPtr aux; /* Device info of the underlying PCI device */
     } deviceinfo;
 } drmDevice, *drmDevicePtr;
 
-- 
2.54.0

