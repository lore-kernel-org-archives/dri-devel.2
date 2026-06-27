Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0D5C43211
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 140B410E451;
	Sat, 27 Jun 2026 03:32:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="nC5ajQ3U";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6407910E429
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:31:48 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 0A59EC5CD7E;
 Sat, 27 Jun 2026 03:31:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EEAFE60233;
 Sat, 27 Jun 2026 03:31:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 99BFC106F1171; 
 Sat, 27 Jun 2026 05:31:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782531105; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=2PVxc3f7q+TwjmunPIwT/G1YrbhRzEI7yNPLDNnhiL4=;
 b=nC5ajQ3UH3FhfcEjpmuvKzHPn0ETtIL59LrMWOZpq2fhh6gt2M07/O9da2kgMSDgWjJckl
 eBRG1oHRngjU/2HVHxZq+AuBbyljDAXKHWG5Zr/346snJCMbghh8AVyws619oi9Wkju1cS
 oNo9ehO8ZRibUqLnxVq08Ssh9U1+vLOKvjetaUjwPenCftNCWUg5sgzDCqj/wyfLsj+iKS
 AQwD4UbiF8lpyiR6d6qDCTQfGAQAAmLkiRlQZRTX5jfpcl+wFaE0ga+SaDuiDeEHUXVTRf
 W0oK67jj3Z4Y7xfGac3l4ofbb0iu5IkH6S/NoLNAMiP9qcXCd7tJgAvC/0z9qw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 27 Jun 2026 05:30:40 +0200
Subject: [PATCH v5 23/38] drm/vkms: Introduce configfs for plane format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260627-vkms-all-config-v5-23-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
In-Reply-To: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, victoria@system76.com, 
 sebastian.wick@redhat.com, victoria@system76.com, airlied@gmail.com, 
 thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Louis Chauvet <louis.chauvet@bootlin.com>, llvm@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11133;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=gRy1bSB46PGpZU8CBgEC2GGeRPhG+dN+lEnn2TmDBOo=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBqP0Pg1y3Z4jqxgp+5cXV4fj/A/GB6KSDpfo7qp
 X4/d0DoSLKJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaj9D4BsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOIoyRAAvWrV6/OGvsq5mkBN635pvGjM05cDXoc
 YgZjm7WymmWTjrQH6wyPUSLAB3nBrE7vtiQiLlCESOnLByrMcy2xrKbU9kvaAY6chX9xnrMwDqV
 GSgkR5K+4OKOt7NH9G8S7mnC6/7qg/TXIdp2GgQrJrr3QMBOr5857GTokryqOvEaLWlL68fMkpu
 oElFW5dgVdU7qG6kk857ol83Q7ELJWCODwY9R/MkdGsapIhbq8RbkYxkfg6shVIwcY6rbmBgAah
 xIt11idjczsNW9FAYsCJfkpzgP7orjHma+xjvfYzMf2mSFmnyWWXB5qoGhIsuAotqEUBDAPCqP/
 vv+W79BMpiVZ3hKYa402gQ8uWA+CF4rYspWWMElhxU0zSrWAUlGdEIyLOueKUvrkgGEym7ULLNo
 /D/H7yzMiaqc0WzU6g9+r/T4ZLO6ZV1Ltr8WfX7YYNxXMgqnawbK6CV7pB7nN5tIB6KhmKKx47+
 1fp5rY34DLp+mt5vk3lkYwCu5g9zIZw7hpA1Jk2xkbQqXQHVzw3dILhLTtn+2y6ocJ4IZIXwB+o
 +Iih6/AfuV2H2qabNQ9ZoIj1iY9Bqa44gGmt9rW1vbtaEE/PFW+JOioSk/6DTQ14vMEQRPjfttb
 +nptIqF79gDn23AWQRpZZxlA9K3Dy888SaqQeV+DrLHgYu6IvNXk=
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3
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

To allow the userspace to test many hardware configuration, introduce a
new interface to configure the available formats per planes. VKMS supports
multiple formats, so the userspace can choose any combination.

The supported formats are configured by writing the fourcc code in
supported_formats:
 # enable AR24 format
  echo '+AR24' > /config/vkms/DEVICE_1/planes/PLANE_1/supported_formats
 # disable AR24 format
  echo '-AR24' > /config/vkms/DEVICE_1/planes/PLANE_1/supported_formats
 # enable all format supported by VKMS
  echo '+*' > /config/vkms/DEVICE_1/planes/PLANE_1/supported_formats
 # disable all formats
  echo '-*' > /config/vkms/DEVICE_1/planes/PLANE_1/supported_formats

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/ABI/testing/configfs-vkms         |   9 ++
 Documentation/gpu/vkms.rst                      |   7 +-
 drivers/gpu/drm/vkms/tests/Makefile             |   3 +-
 drivers/gpu/drm/vkms/tests/vkms_configfs_test.c | 102 +++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_configfs.c            | 113 ++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_configfs.h            |   4 +
 6 files changed, 236 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-vkms b/Documentation/ABI/testing/configfs-vkms
index ef0c3da6b3ca..de901ce36b2e 100644
--- a/Documentation/ABI/testing/configfs-vkms
+++ b/Documentation/ABI/testing/configfs-vkms
@@ -147,6 +147,15 @@ Description:
 	Default color range presented to userspace, same
 	values as supported_color_ranges.
 
+What:		/sys/kernel/config/vkms/<device>/planes/<plane>/supported_formats
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	List of supported formats for this plane. To add a new
+	item, write its fourcc code prefixed with '+'. To remove,
+	use '-' prefix. Use '+*' to add all formats, '-*' to
+	remove all.
+
 What:		/sys/kernel/config/vkms/<device>/planes/<plane>/possible_crtcs
 Date:		Nov 2025
 Contact:	dri-devel@lists.freedesktop.org
diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 7e8f4fe3b392..e5280a99eee8 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -87,7 +87,7 @@ Start by creating one or more planes::
 
   sudo mkdir /config/vkms/my-vkms/planes/plane0
 
-Planes have 7 configurable attributes:
+Planes have 8 configurable attributes:
 
 - type: Plane type: 0 overlay, 1 primary, 2 cursor (same values as those
   exposed by the "type" property of a plane)
@@ -108,6 +108,11 @@ Planes have 7 configurable attributes:
   must be set too.
 - default_color_range: Default color range presented to the userspace, same
   values as supported_color_ranges
+- supported_formats: List of supported formats for this plane. To add a new item in the
+  list, write it using a plus and fourcc code: +XR24
+  To remove a format, use a minus and its fourcc: -XR24
+  To add all formats use +*
+  To remove all formats, use -*
 
 Continue by creating one or more CRTCs::
 
diff --git a/drivers/gpu/drm/vkms/tests/Makefile b/drivers/gpu/drm/vkms/tests/Makefile
index d4d9ba8d4c54..92cfa7262ba4 100644
--- a/drivers/gpu/drm/vkms/tests/Makefile
+++ b/drivers/gpu/drm/vkms/tests/Makefile
@@ -3,6 +3,7 @@
 vkms-kunit-tests-y := \
 	vkms_config_test.o \
 	vkms_format_test.o \
-	vkms_color_test.o
+	vkms_color_test.o \
+	vkms_configfs_test.o \
 
 obj-$(CONFIG_DRM_VKMS_KUNIT_TEST) += vkms-kunit-tests.o
diff --git a/drivers/gpu/drm/vkms/tests/vkms_configfs_test.c b/drivers/gpu/drm/vkms/tests/vkms_configfs_test.c
new file mode 100644
index 000000000000..8d02c2c459d9
--- /dev/null
+++ b/drivers/gpu/drm/vkms/tests/vkms_configfs_test.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "linux/printk.h"
+#include <kunit/test.h>
+
+#include "../vkms_configfs.h"
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+/**
+ * struct vkms_configfs_parse_format_case - Store test case for format parsing
+ * @str: Contains the string to parse
+ * @str_len: str len
+ * @expected_len: expected len of the matched format
+ * @expected_offset: expected offset in the string for the parsed format
+ */
+struct vkms_configfs_parse_format_case {
+	const char *str;
+	int str_len;
+	int expected_len;
+	int expected_offset;
+};
+
+struct vkms_configfs_parse_format_case vkms_configfs_parse_format_test_cases[] = {
+	{
+		.str = "+RG24",
+		.str_len = 6,
+		.expected_len = 5,
+		.expected_offset = 0,
+	}, {
+		.str = "-RG24",
+		.str_len = 6,
+		.expected_len = 5,
+		.expected_offset = 0
+	}, {
+		.str = "  -RG24",
+		.str_len = 8,
+		.expected_len = 5,
+		.expected_offset = 2
+	}, {
+		.str = "+*",
+		.str_len = 3,
+		.expected_len = 2,
+		.expected_offset = 0
+	}, {
+		.str = "-RG24+RG24",
+		.str_len = 11,
+		.expected_len = 5,
+		.expected_offset = 0
+	}, {
+		.str = "-R1+RG24",
+		.str_len = 9,
+		.expected_len = 3,
+		.expected_offset = 0
+	}, {
+		.str = "\n-R1",
+		.str_len = 5,
+		.expected_len = 3,
+		.expected_offset = 1
+	}, {
+		.str = "-R1111",
+		.str_len = 3,
+		.expected_len = 3,
+		.expected_offset = 0
+	}
+};
+
+static void vkms_configfs_test_parse_format(struct kunit *test)
+{
+	const struct vkms_configfs_parse_format_case *param = test->param_value;
+	char *out;
+	int len = vkms_configfs_parse_next_format(param->str, param->str + param->str_len, &out);
+
+	KUNIT_EXPECT_EQ(test, len, param->expected_len);
+	KUNIT_EXPECT_PTR_EQ(test, out, param->str + param->expected_offset);
+}
+
+static void vkms_configfs_test_parse_format_get_desc(struct vkms_configfs_parse_format_case *t,
+						     char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s", t->str);
+}
+
+KUNIT_ARRAY_PARAM(vkms_configfs_test_parse_format, vkms_configfs_parse_format_test_cases,
+		  vkms_configfs_test_parse_format_get_desc
+);
+
+static struct kunit_case vkms_configfs_test_cases[] = {
+	KUNIT_CASE_PARAM(vkms_configfs_test_parse_format,
+			 vkms_configfs_test_parse_format_gen_params),
+	{}
+};
+
+static struct kunit_suite vkms_configfs_test_suite = {
+	.name = "vkms-configfs",
+	.test_cases = vkms_configfs_test_cases,
+};
+
+kunit_test_suite(vkms_configfs_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Kunit test for vkms configfs utility");
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 56a0c542a143..e6cb245b8582 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -3,6 +3,8 @@
 #include <linux/configfs.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/string.h>
+#include <kunit/visibility.h>
 
 #include "vkms_drv.h"
 #include "vkms_config.h"
@@ -576,6 +578,115 @@ static ssize_t plane_default_color_encoding_store(struct config_item *item,
 	return count;
 }
 
+static ssize_t plane_supported_formats_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	page[0] = '\0';
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		u32 *formats = vkms_config_plane_get_supported_formats(plane->config);
+
+		for (int i = 0;
+		     i < vkms_config_plane_get_supported_formats_count(plane->config);
+		     i++) {
+			char tmp[6] = { 0 };
+			const ssize_t ret = snprintf(tmp, ARRAY_SIZE(tmp), "%.*s\n",
+					       (int)sizeof(*formats),
+					       (char *)&formats[i]);
+			if (ret < 0)
+				return ret;
+			/*
+			 * Limitation of ConfigFS attributes, an attribute can't be bigger
+			 * than PAGE_SIZE. This will crop the result if this plane support
+			 * more than ≈1000 formats.
+			 */
+			if (ret + strlen(page) > PAGE_SIZE - 1)
+				return -ENOMEM;
+			strncat(page, tmp, ARRAY_SIZE(tmp));
+		}
+	}
+
+	return strlen(page);
+}
+
+/**
+ * vkms_configfs_parse_next_format() - Parse the next format in page,
+ *				       skipping all non fourcc-related characters
+ * @page: page to search into
+ * @page_end: last character of the page
+ * @out: Output pointer, will point inside page
+ *
+ * Returns: size of the matched format, @out will point to the + or -
+ */
+VISIBLE_IF_KUNIT
+int vkms_configfs_parse_next_format(const char *page, const char *page_end, char **out)
+{
+	int count = page - page_end;
+	char *tmp_plus = strnchr(page, count, '+');
+	char *tmp_minus = strnchr(page, count, '-');
+
+	if (!tmp_plus && !tmp_minus)
+		return 0;
+	if (!tmp_plus)
+		*out = tmp_minus;
+	else if (!tmp_minus)
+		*out = tmp_plus;
+	else
+		*out = min(tmp_plus, tmp_minus);
+
+	char *end = *out + 1;
+
+	while (end < page_end) {
+		if (!isalnum(*end) && *end != '*')
+			break;
+		end++;
+	}
+
+	return end - *out;
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_configfs_parse_next_format);
+
+static ssize_t plane_supported_formats_store(struct config_item *item,
+					     const char *page, size_t count)
+{
+	struct vkms_configfs_plane *plane;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+	int ret = 0;
+
+	if (count < 2 || count > 5)
+		return -EINVAL;
+
+	if (page[0] != '+' && page[0] != '-')
+		return -EINVAL;
+
+	if (page[1] == '*' && count != 2)
+		return -EINVAL;
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		char fmt[4] = {' ', ' ', ' ', ' '};
+
+		memcpy(fmt, &page[1], min(count - 1, 4));
+
+		if (page[0] == '+' && page[1] == '*')
+			ret = vkms_config_plane_add_all_formats(plane->config);
+		else if (page[0] == '-' && page[1] == '*')
+			vkms_config_plane_remove_all_formats(plane->config);
+		else if (page[0] == '+')
+			ret = vkms_config_plane_add_format(plane->config, *(int *)fmt);
+		else if (page[0] == '-')
+			vkms_config_plane_remove_format(plane->config, *(int *)fmt);
+
+		if (ret)
+			return ret;
+	}
+
+	return count;
+}
+
 CONFIGFS_ATTR(plane_, type);
 CONFIGFS_ATTR(plane_, supported_rotations);
 CONFIGFS_ATTR(plane_, default_rotation);
@@ -583,6 +694,7 @@ CONFIGFS_ATTR(plane_, supported_color_ranges);
 CONFIGFS_ATTR(plane_, default_color_range);
 CONFIGFS_ATTR(plane_, supported_color_encodings);
 CONFIGFS_ATTR(plane_, default_color_encoding);
+CONFIGFS_ATTR(plane_, supported_formats);
 
 static struct configfs_attribute *plane_item_attrs[] = {
 	&plane_attr_type,
@@ -592,6 +704,7 @@ static struct configfs_attribute *plane_item_attrs[] = {
 	&plane_attr_default_color_range,
 	&plane_attr_supported_color_encodings,
 	&plane_attr_default_color_encoding,
+	&plane_attr_supported_formats,
 	NULL,
 };
 
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.h b/drivers/gpu/drm/vkms/vkms_configfs.h
index e9020b0043db..73be660412ca 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.h
+++ b/drivers/gpu/drm/vkms/vkms_configfs.h
@@ -5,4 +5,8 @@
 int vkms_configfs_register(void);
 void vkms_configfs_unregister(void);
 
+#if IS_ENABLED(CONFIG_KUNIT)
+int vkms_configfs_parse_next_format(const char *page, const char *end_page, char **out);
+#endif
+
 #endif /* _VKMS_CONFIGFS_H_ */

-- 
2.54.0

