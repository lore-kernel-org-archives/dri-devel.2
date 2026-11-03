Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79109606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=M2D9lamU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B295D10EB34;
	Wed,  4 Nov 2026 08:58:23 +0000 (UTC)
X-Greylist: delayed 412 seconds by postgrey-1.36 at gabe;
 Tue, 03 Nov 2026 11:48:42 UTC
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.64.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16BB410E14F;
 Tue,  3 Nov 2026 11:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
 s=iohv2404; t=1793706514;
 bh=+zHiE5XcWww7tLTpXyIARkWQlwlTAcUnLfouLWCJeB4=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=M2D9lamUa9DR6rgvnM/7qabeY43vqLNct7HkjaKLwefpHQh2QZbx21NRFgDksfPsS
 Te5GSc7t9CWghNuc6uQFgszJY1LYS7sMme2qwrW/HnpF76coDJMjATMOsjsv9+CJQI
 Is2NpQS08dIoT0qnG8pR5x7De1obKn6WSntOp/vg=
X-QQ-mid: zesmtpip4t1793706059t80501f17
X-QQ-Originating-IP: 1MCHwRi6gNt0bcBzShi+yjMARG4lYNZkcQfQtp8Ebn4=
Received: from workstation-Precision-7920-Towe ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 03 Nov 2026 19:40:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13736684038379576073
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>,
 Dave Airlie <airlied@redhat.com>, Rosen Penev <rosenp@gmail.com>,
 Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/gsp: validate the ACPI backlight package
Date: Tue,  3 Nov 2026 19:40:57 +0800
Message-Id: <20261103114057.73915-1-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: N7h1OCCDntujaG65BDQTMdPGBnB7wXQEAgRivP/JDrGe+ed6NUoY1rNK
 jno1+MoMqUbdCKU8bAkIr2l/yIUcoooq6+tx1Ay7RoxXsGvIkjrThdjvrr1muZfLZYdoAkJ
 oTWw08nIgkkQjkSdZiiy3j/UtapDAzrBj3PzfEhucAokKtNQhJHmY+HnTYKJgnr/STPaFqN
 CT2BAQPFsUMN/eFvRYouMaAp3d7bNO4d3WyCikB1zrAp8X35DFiymAyzIgfqm6SaKeIJfW3
 1Z8wFHe/YIQeTvd3uG0TPe+6+clIigCs0J3gSlzXq36QbdW5l4y9/wkunwt2GHrysIi61R9
 E2YsWgwItIaoFlKDxbiVa0IkLyhDBLQgkl04u1w7wtlmKoP1rblno1SjeOt/P1oyRUnDoSZ
 LPcxF36GKtQQDFFY/KfCBLkdrQM19KJ2LC8Kq5tsNWQnUCxEW43teTq/G4tFrxPMKX2T6Jr
 EdZHuk/+XmqLnyLbJk7mUZOuljNKYvDMmsffMOmbzFNokz4WcyPn24zymjG08DXtKxOaj5v
 RJTjQSofyZ3zKt/roI7jD3pwSTJ7/6eVrg3iqc+rIhWukaXGB7qOl4LEKQb3b8B634rJZuf
 nRX7dkGaU4xgjYAXrusYtPViXPdQZeihKMedBq/G0be9MPD/tAmH0iAT+7mN8Ik2RijqU+S
 EDpuzMVc3ccZMDF9/YIipCa0z54KPR3LXwJoLgr5UYeAjV958ESyr9A564dVsldKkrtxGEb
 MioM4MJuy9VKSPFI2JH3qOdE1bdOkD5SlVketmgvx3lqhnmadw4RigFvWQm46PTRYrRVD8t
 MIWryvXSGDfj2G0pB3X7I800FRMZqonfjhY32GNZpuNyt5WvOI26y8d0Ym65b5HBUf0gKps
 PErXB+WkqaPKDoPoQna//iRgQBZWDqNjyBgEhnfXVqLXqdCiEhVmN4me7UZ4OMUaXIGJVHc
 EfyO6mvJn991m6NmZEn3ufxOR0Kjxac71AOwRBf6DCZmDhior/YOhrEWUqbBrDw/zSn6VLM
 BPbf/ltsitnrvus0GLmIW80+Q1P4fdOAScwPdKgXbNNkeo55Gp
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The _DSM handler for the internal brightness state load command walks
the returned package and copies every element into
ctrl->backLightData without checking the object type, the element type,
or the size of the destination.  A firmware-provided _DSM method can
return a non-package object, non-integer elements, or more data than
the 4 KiB backLightData array holds, causing out-of-bounds writes in
the RM control buffer.

Move the _DSM handling into helpers that validate the package and every
element, and that refuse to copy past the end of the destination.  The
destination size is only updated after the whole package has been
validated, and success is only reported to the RM control command in
that case.  Use a zeroed buffer for the _DSM input and reject an
invalid initial data size before subtracting it from the destination
length.

Fixes: 9e99444490238 ("drm/nouveau/disp/r535: initial support")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
 .../nouveau/nvkm/subdev/gsp/rm/r535/disp.c    | 142 ++++++++++++------
 1 file changed, 92 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index f5f22173fc2c..730bd08da911 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -1467,6 +1467,94 @@ r535_disp_get_static_info(struct nvkm_disp *disp)
 	return 0;
 }
 
+#if defined(CONFIG_ACPI) && defined(CONFIG_X86)
+static int
+r535_gsp_backlight_pkg(union acpi_object *obj, u8 *data, u16 *data_size,
+		       size_t data_len)
+{
+	size_t offset = *data_size;
+	unsigned int i;
+
+	if (offset > data_len)
+		return -EINVAL;
+
+	if (obj->type != ACPI_TYPE_PACKAGE)
+		return -EINVAL;
+
+	for (i = 0; i < obj->package.count; i++) {
+		union acpi_object *elt = &obj->package.elements[i];
+		u32 size;
+
+		if (elt->type != ACPI_TYPE_INTEGER)
+			return -EINVAL;
+
+		if (elt->integer.value & ~0xffffffffULL)
+			size = 8;
+		else
+			size = 4;
+
+		if (size > data_len - offset)
+			return -EINVAL;
+
+		memcpy(&data[offset], &elt->integer.value, size);
+		offset += size;
+	}
+
+	*data_size = offset;
+
+	return 0;
+}
+
+static bool
+r535_gsp_backlight_dsm(struct nvkm_device *device, u8 *data, u16 *data_size,
+		       size_t data_len)
+{
+	const guid_t nbci_dsm_guid =
+		GUID_INIT(0xD4A50B75, 0x65C7, 0x46F7,
+			  0xBF, 0xB7, 0x41, 0x51, 0x4C, 0xEA, 0x02, 0x44);
+	const guid_t nvhg_dsm_guid =
+		GUID_INIT(0x9D95A0A0, 0x0060, 0x4D48,
+			  0xB3, 0x4D, 0x7E, 0x5F, 0xEA, 0x12, 0x9F, 0xD4);
+	acpi_handle handle = ACPI_HANDLE(device->dev);
+	union acpi_object argv4, *obj;
+	bool ret = false;
+	bool nbci, nvhg;
+
+	if (!handle || !acpi_has_method(handle, "_DSM"))
+		return false;
+
+	nbci = acpi_check_dsm(handle, &nbci_dsm_guid, 0x00000102,
+			      1ULL << 0x00000014);
+	nvhg = acpi_check_dsm(handle, &nvhg_dsm_guid, 0x00000102,
+			      1ULL << 0x00000014);
+	if (!nbci && !nvhg)
+		return false;
+
+	argv4.buffer.type = ACPI_TYPE_BUFFER;
+	argv4.buffer.length = data_len;
+	argv4.buffer.pointer = kzalloc(data_len, GFP_KERNEL);
+	if (!argv4.buffer.pointer)
+		return false;
+
+	obj = acpi_evaluate_dsm(handle, nbci ? &nbci_dsm_guid : &nvhg_dsm_guid,
+				0x00000102, 0x14, &argv4);
+	if (!obj) {
+		acpi_handle_info(handle, "failed to evaluate _DSM\n");
+		goto out_free;
+	}
+
+	if (r535_gsp_backlight_pkg(obj, data, data_size, data_len))
+		acpi_handle_info(handle, "invalid _DSM response\n");
+	else
+		ret = true;
+
+	ACPI_FREE(obj);
+out_free:
+	kfree(argv4.buffer.pointer);
+	return ret;
+}
+#endif
+
 static int
 r535_disp_oneinit(struct nvkm_disp *disp)
 {
@@ -1528,56 +1616,10 @@ r535_disp_oneinit(struct nvkm_disp *disp)
 
 		ctrl->status = 0x56; /* NV_ERR_NOT_SUPPORTED */
 
-		{
-			const guid_t NBCI_DSM_GUID =
-				GUID_INIT(0xD4A50B75, 0x65C7, 0x46F7,
-					  0xBF, 0xB7, 0x41, 0x51, 0x4C, 0xEA, 0x02, 0x44);
-			u64 NBCI_DSM_REV = 0x00000102;
-			const guid_t NVHG_DSM_GUID =
-				GUID_INIT(0x9D95A0A0, 0x0060, 0x4D48,
-					  0xB3, 0x4D, 0x7E, 0x5F, 0xEA, 0x12, 0x9F, 0xD4);
-			u64 NVHG_DSM_REV = 0x00000102;
-			acpi_handle handle = ACPI_HANDLE(device->dev);
-
-			if (handle && acpi_has_method(handle, "_DSM")) {
-				bool nbci = acpi_check_dsm(handle, &NBCI_DSM_GUID, NBCI_DSM_REV,
-						           1ULL << 0x00000014);
-				bool nvhg = acpi_check_dsm(handle, &NVHG_DSM_GUID, NVHG_DSM_REV,
-						           1ULL << 0x00000014);
-
-				if (nbci || nvhg) {
-					union acpi_object argv4 = {
-						.buffer.type    = ACPI_TYPE_BUFFER,
-						.buffer.length  = sizeof(ctrl->backLightData),
-						.buffer.pointer = kmalloc(argv4.buffer.length, GFP_KERNEL),
-					}, *obj;
-
-					obj = acpi_evaluate_dsm(handle, nbci ? &NBCI_DSM_GUID : &NVHG_DSM_GUID,
-								0x00000102, 0x14, &argv4);
-					if (!obj) {
-						acpi_handle_info(handle, "failed to evaluate _DSM\n");
-					} else {
-						for (int i = 0; i < obj->package.count; i++) {
-							union acpi_object *elt = &obj->package.elements[i];
-							u32 size;
-
-							if (elt->integer.value & ~0xffffffffULL)
-								size = 8;
-							else
-								size = 4;
-
-							memcpy(&ctrl->backLightData[ctrl->backLightDataSize], &elt->integer.value, size);
-							ctrl->backLightDataSize += size;
-						}
-
-						ctrl->status = 0;
-						ACPI_FREE(obj);
-					}
-
-					kfree(argv4.buffer.pointer);
-				}
-			}
-		}
+		if (r535_gsp_backlight_dsm(device, ctrl->backLightData,
+					   &ctrl->backLightDataSize,
+					   sizeof(ctrl->backLightData)))
+			ctrl->status = 0;
 
 		ret = nvkm_gsp_rm_ctrl_wr(subdevice, ctrl);
 		if (ret)
-- 
2.34.1

