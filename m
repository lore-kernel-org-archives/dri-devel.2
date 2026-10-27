Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF19B606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=KK1KI0xY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1587910F604;
	Tue, 27 Oct 2026 14:50:33 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B85B610F603;
 Tue, 27 Oct 2026 14:50:26 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDmqoJ1769897; Tue, 27 Oct 2026 14:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=o1dJZFs9c5KPrg9FcLGTKeV
 gc8n83BCpUxJ0UGGUvvk=; b=KK1KI0xYRzC2a15CHabv7KPxNb723RDxaJBHQtF
 2nToq0qot+buA3Eqn07efIyJRv3fNO2+qz+mLYReC33/Ap3TYVtkEsxdDCBMsNus
 GEt62eSj/FP8IdfW1VSIF48bwcmInTtdrfJprBWEQOlCWRI2E/3OQxOYDOtroDPx
 dCXfRJsxb09h9hSQsBlb5PmWuh/A7sISK0BVSXJdlg7v7SxbCtAE9dbTPvx4G6Ew
 53MB9bZVALfd+aS4wO+TDSROMH4k6G4IkFW7tMWAIzhZnbCUtUyqeiDA7OC1jQKt
 DnUlaQoUTd0hmVWk8HJNEUhqaim8o/w8DrpD0SAEIUxKeMA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hgmrtjpb6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 14:50:08 +0000 (GMT)
Received: from [127.0.1.1] (172.25.128.158) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 27 Oct
 2026 14:50:04 +0000
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Tue, 27 Oct 2026 20:18:48 +0530
Subject: [PATCH v3] drm/imagination: Support for querying Firmware information
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261027-fwversion-v3-1-f363de59205b@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAM+54GoC/3WMzQ7CIBAGX6XZsxigpRVPvofxAHRp99CfQIOap
 u8u7c1ED3uYzTezQsRAGOFarBAwUaRpzFCeCnC9GTtk1GYGyWUt8jH/TBj2FdPKXKTRwmvfQN7
 PAT29jtb9kbmnuEzhfaST2L+/KkkwwUpsReNqZX3lbjR0C7qzmwbYM0n+VWVWreVSOV0aXpkvd
 du2D4BP+N3eAAAA
X-Change-ID: 20261026-fwversion-95a82a91f9f7
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Frank Binns <frank.binns@imgtec.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Brajesh Gupta <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6317;
 i=brajesh.gupta@imgtec.com; h=from:subject:message-id;
 bh=lL9VMhVrfU0AcCILH01ccZHbPxRB7y0otXn3NwQU8cI=;
 b=owEBbQKS/ZANAwAKAdAmd1l+AvFwAcsmYgBq4LocWeurLiJ8bMRK1iZoMJbxeQiRDxl0e+w2O
 mzs4cCUIYaJAjMEAAEKAB0WIQSQIkZAwD1cxcAsz3LQJndZfgLxcAUCauC6HAAKCRDQJndZfgLx
 cLX8D/0S5PybX0CcoMySyOG3AOVNxw606BkyXJdwrlo+Rw+JxuFrEZGefE279UrGBkBW+cWpsG6
 NQuemJsaZEBLdiLUeZe5s6bF5PJfYV96MnmqrMoDmO1dnRimEodZge0wXpo2rnp/PhO0RybufHH
 cGi2EVaATNNTpxu7JWOwxoAzsZapzxstT5bHN9PxQM1OIDpyZuIMAmLnF6tLL+ZW+izPQmykVDQ
 9CnDsG25G4y3+JU1bAES0kkqpg35kd46dGgtn6hgQrG9U6cw/E7URflNTvgHx3/5lLi+4fu2yrV
 ZIlslUZvwzQfAz0thZw4K9kqpDhllo64l/pv9KAYwz9fjfMJXVOZdT9Igj15CTLYSyURcaJDNmt
 0C3y+u08+Zi/LvKXRCldQ1rRCLjqYgF1zm/ABSmsqqWqA4/o3iCRyaAcXWdkiMBDD2BWJ+60USY
 77ifPSFrB7YabqjQlj5GUZFUe+byWw/JssouTA9EX/h9N5yvBeLo7aiEqUZkXLX+4Wmtrvounp/
 bKE96VgWvUrFc4Zb2/RRnmT873B0iJ9YgToSi9mdXFU85ES3aJWwSRN7buMdmwigsUL60nrvllx
 aJdmwtOifFqH6K7MuNlRBU/NibWX2a8UZeTfJ0KBzexfYdclTvjQMBBUMqlEIs1n6OvYyhLF6Eh
 EApShRZZ2jVmO6A==
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=openpgp;
 fpr=05BAA300FD5C580EFD3F8D2F073292BAD0D39671
X-Proofpoint-ORIG-GUID: KuQYRl4Buu6GVnQBRDpSaj-PGkHQ2yYa
X-Authority-Analysis: v=2.4 cv=NZdzRGD4 c=1 sm=1 tr=0 ts=6ae0ba20 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=x1VBDH5lXswA:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=bC-a23v3AAAA:8 a=QyXUC8HyAAAA:8
 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8 a=7UFbgRoScb10X7_jHdcA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22 a=FO4_E8m0qiDe52t0p3_H:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX4rrtj8e5Qbbb
 mqFcHIt5Xyrt692GQKYro2g5dKyjrFQplVTuImjuuutfU8JS+VxOjnNMHml2NNkl5f/XcDL439s
 W99KA4vWvntIJDWtoeHif2ZD3sw5TMU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX5u4Kk54IjFgC
 /emCvnPEo7bALeYimRf5DZD1qY1tlv/OJv8a9lBdHR0K97XCJBlDhxpXxwTMZT30+v/n+1jjHIw
 KEE2K6oARHr4dMQyPXTbLBTNFi4ehDapB7Rd1ngcyeDu7sCCjahcaqpfshB4HGh0bIBcyEL0321
 DyCV1asJ0La1Y6a5ppjY4UqbIUZQS9ai88EpLvPSxA7e0uR8cVLu0R0T8EuE11/ANG/gWYBTm+m
 bOkXRhtFzAXy1k1vlTjsSm8x3Pi7auC5x9RUFtX/gHcX0uV2Gz2QHJd/EZv7FjmojhzdHufFY4i
 nRLUxA6kBdUOFd8TyDOitFY+G7fuYgFvlz8R+5DTfBwgjtcjYk5Nl7Nyb8EruLUg9F8urhSDPW2
 OTvhpaptDzmD50x+Br2LHup7MjIB6HJFuETshGH7OzZfycihli9qHKrJVrMQwBYm86ilWnHCoXT
 Qg3FQqHYeASxvyPWYKA==
X-Proofpoint-GUID: KuQYRl4Buu6GVnQBRDpSaj-PGkHQ2yYa
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a new subtype DRM_PVR_DEV_QUERY_FW_INFO_GET under
DRM_IOCTL_PVR_DEV_QUERY to query Firmware information. This allows the
userspace to detect any bug fixes and features present in the Firmware
and take appropriate action.
Currently it supports querying major and minor version of the Firmware.

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
Changes in v3:
- Add missed check for padding field added in v2.
- Link to v2: https://lore.kernel.org/r/20261026-fwversion-v2-1-bb025c93a04a@imgtec.com

Changes in v2:
- Add padding field to align new FW query struct to 64-bit.
- Link to v1: https://patch.msgid.link/20261026-fwversion-v1-1-3ed17c65bf4c@imgtec.com

To: Alessio Belle <alessio.belle@imgtec.com>
To: Luigi Santivetti <luigi.santivetti@imgtec.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: imagination@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/imagination/pvr_drv.c |  5 +++++
 drivers/gpu/drm/imagination/pvr_drv.h |  4 +++-
 drivers/gpu/drm/imagination/pvr_fw.c  | 31 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/imagination/pvr_fw.h  |  3 +++
 include/uapi/drm/pvr_drm.h            | 21 +++++++++++++++++++++
 5 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index 5c965ef0274f..2d522a8e46ad 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -6,6 +6,7 @@
 #include "pvr_device.h"
 #include "pvr_drv.h"
 #include "pvr_free_list.h"
+#include "pvr_fw.h"
 #include "pvr_gem.h"
 #include "pvr_hwrt.h"
 #include "pvr_job.h"
@@ -658,6 +659,10 @@ pvr_ioctl_dev_query(struct drm_device *drm_dev, void *raw_args,
 	case DRM_PVR_DEV_QUERY_STATIC_DATA_AREAS_GET:
 		ret = pvr_static_data_areas_get(pvr_dev, args);
 		break;
+
+	case DRM_PVR_DEV_QUERY_FW_INFO_GET:
+		ret = pvr_fw_info_get(pvr_dev, args);
+		break;
 	}
 
 	drm_dev_exit(idx);
diff --git a/drivers/gpu/drm/imagination/pvr_drv.h b/drivers/gpu/drm/imagination/pvr_drv.h
index 7fa147312dd1..4e058a6fdd5c 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.h
+++ b/drivers/gpu/drm/imagination/pvr_drv.h
@@ -13,9 +13,10 @@
 /*
  * Driver interface version:
  *  - 1.0: Initial interface
+ *  - 1.1: Add DRM_PVR_DEV_QUERY_FW_INFO_GET query
  */
 #define PVR_DRIVER_MAJOR 1
-#define PVR_DRIVER_MINOR 0
+#define PVR_DRIVER_MINOR 1
 #define PVR_DRIVER_PATCHLEVEL 0
 
 int pvr_get_uobj(u64 usr_ptr, u32 usr_size, u32 min_size, u32 obj_size, void *out);
@@ -68,6 +69,7 @@ int pvr_set_uobj_array(const struct drm_pvr_obj_array *out, u32 min_stride, u32
 	PVR_UOBJ_DECL(struct drm_pvr_dev_query_heap_info, heaps) \
 	PVR_UOBJ_DECL(struct drm_pvr_static_data_area, offset) \
 	PVR_UOBJ_DECL(struct drm_pvr_dev_query_static_data_areas, static_data_areas) \
+	PVR_UOBJ_DECL(struct drm_pvr_dev_query_fw_info, _padding_4) \
 	)
 
 /**
diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/imagination/pvr_fw.c
index c6c77b152342..34093d29baa0 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.c
+++ b/drivers/gpu/drm/imagination/pvr_fw.c
@@ -4,6 +4,7 @@
 #include "pvr_ccb.h"
 #include "pvr_device.h"
 #include "pvr_device_info.h"
+#include "pvr_drv.h"
 #include "pvr_fw.h"
 #include "pvr_fw_info.h"
 #include "pvr_fw_startstop.h"
@@ -1496,3 +1497,33 @@ pvr_fw_hard_reset(struct pvr_device *pvr_dev)
 
 	return 0;
 }
+
+int
+pvr_fw_info_get(const struct pvr_device *pvr_dev,
+		struct drm_pvr_ioctl_dev_query_args *args)
+{
+	struct drm_pvr_dev_query_fw_info fw_info = {0};
+	int err;
+
+	if (!args->pointer) {
+		args->size = sizeof(struct drm_pvr_dev_query_fw_info);
+		return 0;
+	}
+
+	err = PVR_UOBJ_GET(fw_info, args->size, args->pointer);
+	if (err < 0)
+		return err;
+	if (fw_info._padding_4)
+		return -EINVAL;
+
+	fw_info.major_version = pvr_dev->fw_version.major;
+	fw_info.minor_version = pvr_dev->fw_version.minor;
+
+	err = PVR_UOBJ_SET(args->pointer, args->size, fw_info);
+	if (err < 0)
+		return err;
+
+	if (args->size > sizeof(fw_info))
+		args->size = sizeof(fw_info);
+	return 0;
+}
diff --git a/drivers/gpu/drm/imagination/pvr_fw.h b/drivers/gpu/drm/imagination/pvr_fw.h
index 4b25291135b6..7e18f3e7d4be 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.h
+++ b/drivers/gpu/drm/imagination/pvr_fw.h
@@ -496,4 +496,7 @@ int
 pvr_fw_process_elf_command_stream(struct pvr_device *pvr_dev, const u8 *fw, u8 *fw_code_ptr,
 				  u8 *fw_data_ptr, u8 *fw_core_code_ptr, u8 *fw_core_data_ptr);
 
+int
+pvr_fw_info_get(const struct pvr_device *pvr_dev, struct drm_pvr_ioctl_dev_query_args *args);
+
 #endif /* PVR_FW_H */
diff --git a/include/uapi/drm/pvr_drm.h b/include/uapi/drm/pvr_drm.h
index ccf6c2112468..1179c1e7d92d 100644
--- a/include/uapi/drm/pvr_drm.h
+++ b/include/uapi/drm/pvr_drm.h
@@ -434,6 +434,21 @@ struct drm_pvr_dev_query_static_data_areas {
 	struct drm_pvr_obj_array static_data_areas;
 };
 
+/**
+ * struct drm_pvr_dev_query_fw_info - Container used to fetch information
+ * about the GPU Firmware like its version.
+ */
+struct drm_pvr_dev_query_fw_info {
+	/** @major_version: Major version of the Firmware. */
+	__u16 major_version;
+
+	/** @minor_version: Minor version of the Firmware. */
+	__u16 minor_version;
+
+	/** @_padding_4: Reserved. This field must be zeroed. */
+	__u32 _padding_4;
+};
+
 /**
  * enum drm_pvr_dev_query - For use with &drm_pvr_ioctl_dev_query_args.type to
  * indicate the type of the receiving container.
@@ -476,6 +491,12 @@ enum drm_pvr_dev_query {
 	 * a pointer to &struct drm_pvr_dev_query_static_data_areas.
 	 */
 	DRM_PVR_DEV_QUERY_STATIC_DATA_AREAS_GET,
+
+	/**
+	 * @DRM_PVR_DEV_QUERY_FW_INFO_GET: The dev query args contain
+	 * a pointer to &struct drm_pvr_dev_query_fw_info.
+	 */
+	DRM_PVR_DEV_QUERY_FW_INFO_GET,
 };
 
 /**

---
base-commit: a8fe4e162ba8212b7e51fdb024b37800f36b496c
change-id: 20261026-fwversion-95a82a91f9f7

Best regards,
--  
Brajesh Gupta <brajesh.gupta@imgtec.com>

