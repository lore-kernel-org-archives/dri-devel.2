Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6260D606A322
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=VpmQ77Y5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5D7410ECD7;
	Mon, 26 Oct 2026 08:44:53 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C376F10ECD7;
 Mon, 26 Oct 2026 08:44:46 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q5I2ig2459339; Mon, 26 Oct 2026 08:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=OPjKlmQhOolYsyN1l8JwVw0
 v9oJi4NbTI7scNS9SDa4=; b=VpmQ77Y59Ib9gtOqe87dNqTYSp+4fdMDMEeA4l4
 2n4XaYXJ9FN4Pd473sGbKPV2EUSL/AWuNd+B3jqfqeArJkTzslcIQvHIKdiz4HOG
 mal8t98tOyMONxfWq3Gwdue0lLYoWl+V0WGuY8fEn30fxqwbvglNXroO1WsD3Fg8
 1Qm0LVTogkCcAIGiQsqD67+3eHiBgpK7kHGplZ8kpP4qzwPrYRahrtmmnmEp7ENX
 hrJ34UbrMK2xwLK2lZTsdx5tgZAHD87DkGj7uDDGGJ5uMXImL9zIPNoMQbXVvaV8
 FT45+QEWNgvGGLnjvZ8MiH4jAt98wpOfUAzZQKPRrZITJ2A==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hgmrthgvs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 08:44:37 +0000 (GMT)
Received: from [127.0.1.1] (172.25.128.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 26 Oct
 2026 08:44:34 +0000
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Mon, 26 Oct 2026 14:13:55 +0530
Subject: [PATCH v2] drm/imagination: Support for querying Firmware information
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261026-fwversion-v2-1-bb025c93a04a@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAMoS32oC/22MQQ6CMBBFr0Jm7RinClhX3sOwqGUKs4CallQN6
 d0trF38xft5eStEDsIRbtUKgZNE8XMBdajAjmYeGKUvDOqkGipD904cNgt1ba7KaHLatVD8V2A
 nn7316AqPEhcfvns60fb+qyRCwjP31NqmfrqLvcs0LGyP1k/Q5Zx/Ctipd6MAAAA=
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Brajesh Gupta <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5582;
 i=brajesh.gupta@imgtec.com; h=from:subject:message-id;
 bh=PW7i/+RQVTHXW4Nw0I6lp9odmlm2he+P1vM5eQQiXgQ=;
 b=owEBbQKS/ZANAwAKAdAmd1l+AvFwAcsmYgBq3xLxW1T+12APP9dl0C6q+tF8JKcTMU7so0OCe
 /0O6VvAETSJAjMEAAEKAB0WIQSQIkZAwD1cxcAsz3LQJndZfgLxcAUCat8S8QAKCRDQJndZfgLx
 cFLeEACCF1SIvYT7QloOek3MQKeOPHiGw5MyKJUBL5SByPYMurI82ylBX1VX0BSZmop3LTuxe2W
 GDaMnc058n2hW5BS0dZC6mvu0n6YmIfSpqYgYo8Y9WxfabrXSZmHn/qEkfv5BhlwH5cKwcauo+T
 GL3YyyzkX2bTOOL7JxfgQo39jCCkyBalm7/hW0MMrVd4FjW57xJyF2vR+G54zdzX7/Acp3P4fpp
 0cx+H3zdrNWfA0lmoAanQzmSq5PHyFtQAhdNN0O58hynzl7GUo2hpaH5yfg7EgW9HXwP/GyV2ye
 PG82ijbirCIkarDjHYA9DOOdmy1oHxrSwluNlW9G/hJm1JAjR6SI5Vfj4LVRCIE9kllFamxphE0
 Ny0Q2TXYsoHc2hCkpoz2upgoODcIHkSFQxs06cf9M1jbYEQVor7/zPMjTjLGAw/l7PUEAzHdQGO
 NQal4dZblRwQ/JlA9TayLa3O+N0YSMd1QGHGCniUi8iBFTuGfUi5TSGRmeGNgeqBOC+ZTSOkaUa
 SGgvUeBuf4nPCpkdKsYVEJ8zVmi6mRM7qciASUm+qXmymuF8nDGOtEyxVXO5tHgoKz6Kou2gz9j
 QJc5xnFyOGk1+Og0hlOtMJiAtCeTEYdS+u2sWqxORvF/6KsWOPwqZeh3Iby9dTxM+jYiaNJlv+Y
 N0ZepvM3UkaKSZg==
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=openpgp;
 fpr=05BAA300FD5C580EFD3F8D2F073292BAD0D39671
X-Proofpoint-ORIG-GUID: iURTvS0fMT8INX3wjdNinv5m0Pn4Kt8S
X-Authority-Analysis: v=2.4 cv=NZdzRGD4 c=1 sm=1 tr=0 ts=6adf12f5 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=HYrZrZQ_E1YA:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=tATwJB8W6yD03TAJafYA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzNCBTYWx0ZWRfX3nVQX6ueuzBW
 XXc0FOhh+dp9LgTFYMOdPMT+HA3rJNXx41x8LUHyTc0lCSUIa6PoxGN8T/k75CrQ7SKeh21GWQz
 o8xzZ/GmARUSe4lLMLvyNZPuOCjCqL8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzNCBTYWx0ZWRfX1FMINEoJUlUF
 Up5oqmdg4jHRjrLQc5m21emqmhgZ6CZMlRL3Wb+w/K9/ZbuObht1Odk1L17m38nfSydnutZmJIt
 nVGWdNQ/ydhpnU176QrsYlYckfXjg/UgQsgE76TCCPvpOAjIgS9rVtwWPWeKqBsNN39O768/1NY
 Kj9v7Knr8s4+4sfQpLQU8LfOJP0iMsY9Uvhh3RSVN3nNzAvhSrMeYKZAULi0PGQJevNMvNvc6VG
 eJW+ARpAPkEhGt9VbD8GqHDJ35p4i8+jtjzyW/vM8UsUXBJmbX2IGVz3vUPpuv6/patDmEWe17B
 bMtJ6SI77Cu2csTPuvLdyWPcVN2A1TU5L6/MYLu/xvCKaaShtRw3Uyx3YfG97JWlKmqqD8HsL8y
 nQySb/+63MkRysEiPEcbKU7zfaUpxybt5yrT2qzFQkOpFuWfmQ5mFpfuKeHBzlt5SZD7qcFFe87
 Y94n24hbL9Ohx+TgXyw==
X-Proofpoint-GUID: iURTvS0fMT8INX3wjdNinv5m0Pn4Kt8S
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a new subtype DRM_PVR_DEV_QUERY_FW_INFO_GET under
DRM_IOCTL_PVR_DEV_QUERY to query Firmware information. This allows the
userspace to detect any bug fixes and features present in the Firmware
and take appropriate action.
Currently it supports querying major and minor version of the Firmware.

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
Changes in v2:
- Add padding field to align new FW query struct to 64-bit.
- Link to v1: https://patch.msgid.link/20261026-fwversion-v1-1-3ed17c65bf4c@imgtec.com
---
 drivers/gpu/drm/imagination/pvr_drv.c |  5 +++++
 drivers/gpu/drm/imagination/pvr_drv.h |  4 +++-
 drivers/gpu/drm/imagination/pvr_fw.c  | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/imagination/pvr_fw.h  |  3 +++
 include/uapi/drm/pvr_drm.h            | 21 +++++++++++++++++++++
 5 files changed, 57 insertions(+), 1 deletion(-)

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
index c6c77b152342..1f21e6adaff2 100644
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
@@ -1496,3 +1497,27 @@ pvr_fw_hard_reset(struct pvr_device *pvr_dev)
 
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

